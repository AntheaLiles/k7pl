// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { stageKlean } from "../src/stage_klean.ts";

async function fixture(
  toolchain: string,
): Promise<{ tmp: string; ws: string; cleanup: () => Promise<void> }> {
  const tmp = await Deno.makeTempDir();
  const ws = `${tmp}/ws`;
  await Deno.mkdir(`${tmp}/klean-output/k7pl2lean/K7PL2Lean`, {
    recursive: true,
  });
  await Deno.writeTextFile(
    `${tmp}/klean-output/k7pl2lean/K7PL2Lean.lean`,
    "generated root\n",
  );
  await Deno.writeTextFile(
    `${tmp}/klean-output/k7pl2lean/K7PL2Lean/A.lean`,
    "generated a\n",
  );
  await Deno.mkdir(`${ws}/proofs/K7PL2Lean`, { recursive: true });
  await Deno.writeTextFile(`${ws}/proofs/K7PL2Lean/old.lean`, "stale\n");
  await Deno.writeTextFile(`${ws}/proofs/K7PL2Lean.lean`, "stale root\n");
  await Deno.writeTextFile(`${ws}/proofs/lean-toolchain`, toolchain);
  return { tmp, ws, cleanup: () => Deno.remove(tmp, { recursive: true }) };
}

Deno.test("stage_klean replaces the staged copy and accepts v4.34.0 (trailing newline stripped)", async () => {
  const { tmp, ws, cleanup } = await fixture("leanprover/lean4:v4.34.0\n");
  try {
    const lines: string[] = [];
    const result = await stageKlean({
      runnerTemp: tmp,
      workspace: ws,
      log: (l) => lines.push(l),
    });
    assertEquals(result.toolchain, "leanprover/lean4:v4.34.0");
    assertEquals(lines, [
      "Staged generated Klean sources into proofs/ (ignored by Git).",
    ]);
    assertEquals(
      await Deno.readTextFile(`${ws}/proofs/K7PL2Lean/A.lean`),
      "generated a\n",
    );
    assertEquals(
      await Deno.readTextFile(`${ws}/proofs/K7PL2Lean.lean`),
      "generated root\n",
    );
    let oldExists = true;
    try {
      await Deno.stat(`${ws}/proofs/K7PL2Lean/old.lean`);
    } catch {
      oldExists = false;
    }
    assert(!oldExists, "stale staged file should have been removed");
  } finally {
    await cleanup();
  }
});

Deno.test("stage_klean fails on a wrong toolchain, after staging (order preserved)", async () => {
  const { tmp, ws, cleanup } = await fixture("leanprover/lean4:v4.30.0\n");
  try {
    let message = "";
    try {
      await stageKlean({ runnerTemp: tmp, workspace: ws, log: () => {} });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "leanprover/lean4:v4.34.0");
    // The copy happened before the check, as in the shell script.
    assertEquals(
      await Deno.readTextFile(`${ws}/proofs/K7PL2Lean/A.lean`),
      "generated a\n",
    );
  } finally {
    await cleanup();
  }
});
