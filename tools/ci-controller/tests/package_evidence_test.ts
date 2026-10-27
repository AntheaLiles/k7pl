// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { packageEvidence } from "../src/package_evidence.ts";

async function write(ws: string, rel: string, content = "x\n"): Promise<void> {
  const path = `${ws}/${rel}`;
  await Deno.mkdir(path.split("/").slice(0, -1).join("/"), { recursive: true });
  await Deno.writeTextFile(path, content);
}

async function fixture(
  html: boolean,
): Promise<{ ws: string; tmp: string; cleanup: () => Promise<void> }> {
  const tmp = await Deno.makeTempDir();
  const ws = `${tmp}/ws`;
  for (
    const rel of [
      "lexicon/lexicon.k",
      "lexicon/models/native-boundary.k",
      "src/k/.build/generated/check_k_examples.py",
      "src/k/Makefile",
      "tests/examples/add.k7",
      "tests/examples/select.k7",
      "tests/examples/native-boundary/case.k7",
      "wiki/semantics.md",
      "proofs/K7PL2Lean.lean",
      "proofs/K7PL2Lean/Mod.lean",
      "proofs/lakefile.toml",
      "proofs/lean-toolchain",
      "proofs/lake-manifest.json",
      "proofs/README.md",
      "proofs/K7PL.lean",
      "proofs/Makefile",
      "proofs/axiom-audit-contract.json",
      "proofs/K7PL/Inner.lean",
      "spec/formal-chain/BlueprintK7PL.lean",
      "spec/formal-chain/BlueprintK7PLMain.lean",
      "spec/formal-chain/lakefile.lean",
      "spec/formal-chain/lean-toolchain",
      "spec/formal-chain/lake-manifest.json",
      "spec/formal-chain/Makefile",
      "spec/formal-chain/BlueprintK7PL/Doc.lean",
      ".formal-chain-evidence/klean-files.txt",
    ]
  ) {
    await write(ws, rel);
  }
  if (html) {
    await write(
      ws,
      "spec/formal-chain/_out/site/html-multi/index.html",
      "<html/>\n",
    );
    await write(
      ws,
      "spec/formal-chain/_out/site/html-multi/sub/page.html",
      "<html/>\n",
    );
  } else {
    await Deno.mkdir(`${ws}/spec/formal-chain/_out/site/html-multi`, {
      recursive: true,
    });
  }
  await Deno.mkdir(`${tmp}/klean-output/k7pl2lean`, { recursive: true });
  await write(`${tmp}`, "klean-output/k7pl2lean/K7PL2Lean.lean");
  return { ws, tmp, cleanup: () => Deno.remove(tmp, { recursive: true }) };
}

Deno.test("package_evidence stages inputs, writes MANIFEST, packs the tarball", async () => {
  const { ws, tmp, cleanup } = await fixture(true);
  try {
    const lines: string[] = [];
    const result = await packageEvidence({
      workspace: ws,
      runnerTemp: tmp,
      runId: "42",
      log: (l) => lines.push(l),
    });
    assertEquals(result.htmlCount, 2);
    assert(result.archiveSize > 0, "archive should be non-empty");
    assert(result.manifestEntries.includes("k7pl-formal-chain/MANIFEST.txt"));
    assert(
      result.manifestEntries.includes("k7pl-formal-chain/lexicon/lexicon.k"),
    );
    assert(
      result.manifestEntries.includes(
        "k7pl-formal-chain/lexicon/models/native-boundary.k",
      ),
    );
    assert(
      result.manifestEntries.includes(
        "k7pl-formal-chain/proofs/K7PL2Lean.lean",
      ),
    );
    assert(
      result.manifestEntries.includes(
        "k7pl-formal-chain/proofs/K7PL/Inner.lean",
      ),
    );
    assert(
      result.manifestEntries.includes(
        "k7pl-formal-chain/klean-output/K7PL2Lean.lean",
      ),
    );
    assert(
      result.manifestEntries.includes(
        "k7pl-formal-chain/evidence/klean-files.txt",
      ),
    );
    assert(
      result.manifestEntries.includes(
        "k7pl-formal-chain/spec/formal-chain/_out/site/html-multi/index.html",
      ),
    );
    const sorted = [...result.manifestEntries].sort((
      a,
      b,
    ) => (a < b ? -1 : a > b ? 1 : 0));
    assertEquals(result.manifestEntries, sorted);
    const stagedManifest = await Deno.readTextFile(
      `${result.artifactRoot}/MANIFEST.txt`,
    );
    assertEquals(stagedManifest, `${result.manifestEntries.join("\n")}\n`);
    const listing = await Deno.readTextFile(result.manifestPath);
    assertEquals(
      result.fileCount,
      listing.split("\n").filter((l) => l !== "").length,
    );
    assertEquals(lines.length, 1);
    assertStringIncludes(lines[0], "(2 HTML files)");
    assertStringIncludes(lines[0], result.archive);
  } finally {
    await cleanup();
  }
});

Deno.test("package_evidence fails on a missing input", async () => {
  const { ws, tmp, cleanup } = await fixture(true);
  try {
    await Deno.remove(`${ws}/lexicon`, { recursive: true });
    let message = "";
    try {
      await packageEvidence({
        workspace: ws,
        runnerTemp: tmp,
        runId: "42",
        log: () => {},
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "lexicon");
  } finally {
    await cleanup();
  }
});

Deno.test("package_evidence fails when no HTML page was staged", async () => {
  const { ws, tmp, cleanup } = await fixture(false);
  try {
    let message = "";
    try {
      await packageEvidence({
        workspace: ws,
        runnerTemp: tmp,
        runId: "42",
        log: () => {},
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "no HTML pages");
  } finally {
    await cleanup();
  }
});
