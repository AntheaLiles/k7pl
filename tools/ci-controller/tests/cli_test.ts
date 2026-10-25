// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertStringIncludes } from "./assert.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;
const MAIN = `${REPO_ROOT}tools/ci-controller/src/main.ts`;

async function runCli(
  args: string[],
  extraEnv: Record<string, string> = {},
): Promise<{ code: number; out: string; err: string }> {
  const command = new Deno.Command(Deno.execPath(), {
    args: [
      "run",
      "--allow-read",
      "--allow-run",
      "--allow-env",
      "--allow-write",
      MAIN,
      ...args,
    ],
    stdout: "piped",
    stderr: "piped",
    cwd: REPO_ROOT,
    env: { ...Deno.env.toObject(), ...extraEnv },
  });
  const { code, stdout, stderr } = await command.output();
  return {
    code,
    out: new TextDecoder().decode(stdout),
    err: new TextDecoder().decode(stderr),
  };
}

Deno.test("cli classify --paths prints surfaces", async () => {
  const result = await runCli([
    "classify",
    "--paths",
    "src/Foo.lean",
    "docs/a.md",
  ]);
  assert(result.code === 0, result.err);
  assertStringIncludes(result.out, "lean_build=true");
  assertStringIncludes(result.out, "docs_links=true");
  assertStringIncludes(result.out, "full=false");
});

Deno.test("cli classify --force-full sets every surface", async () => {
  const result = await runCli([
    "classify",
    "--paths",
    "docs/a.md",
    "--force-full",
  ]);
  assert(result.code === 0, result.err);
  assertStringIncludes(result.out, "full=true");
  assertStringIncludes(result.out, "tracking_views=true");
});

Deno.test("cli classify writes GITHUB_OUTPUT when set", async () => {
  const tmp = await Deno.makeTempFile();
  try {
    const result = await runCli(["classify", "--paths", "spec/X.lean"], {
      GITHUB_OUTPUT: tmp,
    });
    assert(result.code === 0, result.err);
    const written = await Deno.readTextFile(tmp);
    assertStringIncludes(written, "spec_build=true\n");
    assertStringIncludes(written, "full=false\n");
  } finally {
    await Deno.remove(tmp).catch(() => {});
  }
});

Deno.test("cli validate-registry passes on the real registry", async () => {
  const result = await runCli(["validate-registry"]);
  assert(result.code === 0, result.err);
  assertStringIncludes(result.out, "validate-registry: OK");
});

Deno.test("cli validate-evidence accepts a valid record and rejects a bad one", async () => {
  const good = await Deno.makeTempFile({ suffix: ".json" });
  const bad = await Deno.makeTempFile({ suffix: ".json" });
  try {
    await Deno.writeTextFile(
      good,
      JSON.stringify({
        stage: "k-compile",
        commit: "b".repeat(40),
        run: "1",
        tool: { name: "kompile", version: "7.1.337", source: "kframework" },
        inputs: [{ path: "spec", sha256: "a".repeat(64) }],
        outputs: [{ path: "out", sha256: "a".repeat(64) }],
        exit_code: 0,
        claims: [{ class: "execution", property: "compiled" }],
        depends_on: ["spec-extract"],
      }),
    );
    await Deno.writeTextFile(
      bad,
      JSON.stringify({
        stage: "lean-proof-build",
        commit: "b".repeat(40),
        run: "1",
        tool: { name: "lake", version: "v4.34.0", source: "lean-toolchain" },
        inputs: [],
        outputs: [],
        exit_code: 0,
        claims: [{ class: "execution", property: "built" }],
        depends_on: ["klean-export"],
      }),
    );
    const okResult = await runCli(["validate-evidence", "--evidence", good]);
    assert(okResult.code === 0, okResult.err);
    assertStringIncludes(okResult.out, "validate-evidence: OK");
    const badResult = await runCli(["validate-evidence", "--evidence", bad]);
    assert(badResult.code !== 0);
    assertStringIncludes(badResult.err, "missing required claim class proof");
  } finally {
    await Deno.remove(good).catch(() => {});
    await Deno.remove(bad).catch(() => {});
  }
});

Deno.test("cli rejects an unknown command", async () => {
  const result = await runCli(["frobnicate"]);
  assert(result.code === 2);
});
