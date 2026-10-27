// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { renderBlueprint } from "../src/render_blueprint.ts";

type LakeMode = "ok" | "empty" | "nodir";

/** A fake lake: `lake exe vbp build` fabricates the HTML output tree. */
async function stubBin(mode: LakeMode): Promise<string> {
  const dir = await Deno.makeTempDir();
  const lines = ["#!/usr/bin/env bash"];
  if (mode === "ok") {
    lines.push(`mkdir -p _out/site/html-multi/sub`);
    lines.push(`printf '%s\\n' '<html/>' > _out/site/html-multi/index.html`);
    lines.push(`printf '%s\\n' '<html/>' > _out/site/html-multi/sub/page.html`);
    lines.push(`printf '%s\\n' 'notes' > _out/site/html-multi/notes.txt`);
  } else if (mode === "empty") {
    lines.push(`mkdir -p _out/site/html-multi`);
  }
  lines.push("exit 0");
  const path = `${dir}/lake`;
  await Deno.writeTextFile(path, `${lines.join("\n")}\n`);
  await Deno.chmod(path, 0o755);
  return dir;
}

Deno.test("render_blueprint counts HTML recursively and writes real newlines", async () => {
  const bin = await stubBin("ok");
  const tmp = await Deno.makeTempDir();
  try {
    const dir = `${tmp}/spec/formal-chain`;
    await Deno.mkdir(dir, { recursive: true });
    const summary = `${tmp}/summary.md`;
    await Deno.writeTextFile(summary, "");
    const result = await renderBlueprint({
      dir,
      stepSummary: summary,
      path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
    });
    assertEquals(result.htmlCount, 2);
    assertEquals(result.htmlDir, `${dir}/_out/site/html-multi`);
    const text = await Deno.readTextFile(summary);
    assertEquals(
      text,
      "## Verso Blueprint\nGenerated HTML files: 2\nOutput: spec/formal-chain/_out/site/html-multi/\n",
    );
    assert(!text.includes("\\n"), JSON.stringify(text));
  } finally {
    await Deno.remove(tmp, { recursive: true });
    await Deno.remove(bin, { recursive: true });
  }
});

Deno.test("render_blueprint fails when no HTML page was produced", async () => {
  const bin = await stubBin("empty");
  const tmp = await Deno.makeTempDir();
  try {
    const dir = `${tmp}/spec/formal-chain`;
    await Deno.mkdir(dir, { recursive: true });
    let message = "";
    try {
      await renderBlueprint({
        dir,
        stepSummary: `${tmp}/summary.md`,
        path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "no HTML pages");
  } finally {
    await Deno.remove(tmp, { recursive: true });
    await Deno.remove(bin, { recursive: true });
  }
});

Deno.test("render_blueprint fails when the HTML directory is missing", async () => {
  const bin = await stubBin("nodir");
  const tmp = await Deno.makeTempDir();
  try {
    const dir = `${tmp}/spec/formal-chain`;
    await Deno.mkdir(dir, { recursive: true });
    let message = "";
    try {
      await renderBlueprint({
        dir,
        stepSummary: `${tmp}/summary.md`,
        path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "no HTML output directory");
  } finally {
    await Deno.remove(tmp, { recursive: true });
    await Deno.remove(bin, { recursive: true });
  }
});
