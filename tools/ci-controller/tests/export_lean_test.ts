// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { EXPECTED_KLEAN_FILES, exportLean } from "../src/export_lean.ts";

type KleanMode = "ok" | "missing" | "empty" | "nopackage";

/** A fake klean: fabricates the package the real tool would emit. */
async function stubBin(mode: KleanMode): Promise<string> {
  const dir = await Deno.makeTempDir();
  const files = [...EXPECTED_KLEAN_FILES];
  const lines: string[] = ["#!/usr/bin/env bash", 'out=""', 'prev=""'];
  lines.push(
    `for a in "$@"; do if [ "$prev" = "--output" ]; then out="$a"; fi; prev="$a"; done`,
  );
  if (mode !== "nopackage") {
    lines.push(`mkdir -p "$out/k7pl2lean/K7PL2Lean"`);
    for (const file of files) {
      if (mode === "missing" && file === "K7PL2Lean/Sorts.lean") continue;
      if (mode === "empty" && file === "K7PL2Lean/Prelude.lean") {
        lines.push(`: > "$out/k7pl2lean/${file}"`);
      } else if (file === "lean-toolchain") {
        lines.push(
          `printf '%s\\n' 'leanprover/lean4:v4.30.0' > "$out/k7pl2lean/${file}"`,
        );
      } else {
        lines.push(`printf '%s\\n' 'generated' > "$out/k7pl2lean/${file}"`);
      }
    }
  }
  lines.push("exit 0");
  const path = `${dir}/klean`;
  await Deno.writeTextFile(path, `${lines.join("\n")}\n`);
  await Deno.chmod(path, 0o755);
  return dir;
}

async function fixture(): Promise<
  { ws: string; tmp: string; cleanup: () => Promise<void> }
> {
  const tmp = await Deno.makeTempDir();
  const ws = `${tmp}/ws`;
  await Deno.mkdir(`${ws}/src/k/.build/kompiled`, { recursive: true });
  await Deno.writeTextFile(
    `${ws}/lean-toolchain`,
    "leanprover/lean4:v4.34.0\n",
  );
  return { ws, tmp, cleanup: () => Deno.remove(tmp, { recursive: true }) };
}

Deno.test("export_lean overwrites the toolchain, records the file list, and writes real newlines", async () => {
  const bin = await stubBin("ok");
  const { ws, tmp, cleanup } = await fixture();
  try {
    const summary = `${tmp}/summary.md`;
    await Deno.writeTextFile(summary, "");
    const result = await exportLean({
      runnerTemp: tmp,
      workspace: ws,
      stepSummary: summary,
      path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
    });
    assertEquals(result.packageDir, `${tmp}/klean-output/k7pl2lean`);
    assertEquals(
      await Deno.readTextFile(`${result.packageDir}/lean-toolchain`),
      "leanprover/lean4:v4.34.0\n",
    );
    assertEquals(result.files.length, EXPECTED_KLEAN_FILES.length);
    const recorded = await Deno.readTextFile(
      `${ws}/.formal-chain-evidence/klean-files.txt`,
    );
    assertEquals(recorded, `${result.files.join("\n")}\n`);
    assertEquals(
      await Deno.readTextFile(
        `${ws}/.formal-chain-evidence/klean-toolchain.txt`,
      ),
      "leanprover/lean4:v4.34.0\n",
    );
    const summaryText = await Deno.readTextFile(summary);
    assertStringIncludes(summaryText, "## Generated Klean package\n");
    assertStringIncludes(summaryText, "## Generated toolchain\n");
    assertStringIncludes(summaryText, "leanprover/lean4:v4.34.0\n");
    // Deliberate deviation: no literal backslash-n from the old '%s\\n'.
    assert(!summaryText.includes("\\n"), JSON.stringify(summaryText));
  } finally {
    await cleanup();
    await Deno.remove(bin, { recursive: true });
  }
});

for (
  const [mode, needle] of [
    ["missing", "K7PL2Lean/Sorts.lean"],
    ["empty", "K7PL2Lean/Prelude.lean"],
    ["nopackage", "Klean output directory missing"],
  ] as const
) {
  Deno.test(`export_lean fails on ${mode} klean output`, async () => {
    const bin = await stubBin(mode);
    const { ws, tmp, cleanup } = await fixture();
    try {
      let message = "";
      try {
        await exportLean({
          runnerTemp: tmp,
          workspace: ws,
          stepSummary: `${tmp}/summary.md`,
          path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
        });
      } catch (error) {
        message = error instanceof Error ? error.message : String(error);
      }
      assertStringIncludes(message, needle);
    } finally {
      await cleanup();
      await Deno.remove(bin, { recursive: true });
    }
  });
}
