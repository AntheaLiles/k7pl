// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { COMMANDS, compilePermissionFlags } from "../src/cli.ts";

const CONTROLLER = new URL("../", import.meta.url).pathname;
const CLI = `${CONTROLLER}src/cli.ts`;

function compileTaskFlags(): string[] {
  const config = JSON.parse(Deno.readTextFileSync(`${CONTROLLER}deno.json`));
  const task: string = config.tasks.compile;
  return task.split(/\s+/).filter((token) => token.startsWith("--allow-"));
}

/** Run src/cli.ts under exactly the permissions the binary is compiled with. */
async function runAsCompiled(
  args: string[],
): Promise<{ code: number; out: string; err: string }> {
  const command = new Deno.Command(Deno.execPath(), {
    args: ["run", ...compileTaskFlags(), CLI, ...args],
    stdout: "piped",
    stderr: "piped",
    cwd: CONTROLLER,
  });
  const { code, stdout, stderr } = await command.output();
  return {
    code,
    out: new TextDecoder().decode(stdout),
    err: new TextDecoder().decode(stderr),
  };
}

Deno.test("the compile task grants exactly the union of the commands' permissions", () => {
  assertEquals(compileTaskFlags(), compilePermissionFlags());
});

Deno.test("the union of permissions is computed from the command table", () => {
  const flags = compilePermissionFlags({
    a: {
      summary: "",
      run: ["tar"],
      env: ["B"],
      write: false,
      takesArgs: false,
      main: () => Promise.resolve(0),
    },
    b: {
      summary: "",
      run: ["lake"],
      env: ["A", "B"],
      write: true,
      takesArgs: false,
      main: () => Promise.resolve(0),
    },
  });
  assertEquals(flags, [
    "--allow-read",
    "--allow-write",
    "--allow-run=lake,tar",
    "--allow-env=A,B",
  ]);
});

Deno.test("every k-smoke step has a command", () => {
  assertEquals(Object.keys(COMMANDS).sort(), [
    "axiom-report",
    "build-proofs",
    "export-lean",
    "install-klean",
    "klean-prelude",
    "os-boundary-check",
    "package-evidence",
    "record-toolchain",
    "render-blueprint",
    "stage-klean",
  ]);
});

Deno.test("a command runs without the permission categories it does not use", async () => {
  const expected: Record<string, Record<string, string>> = {
    "klean-prelude": { run: "prompt", env: "prompt", write: "granted" },
    "stage-klean": { run: "prompt", env: "granted", write: "granted" },
    "record-toolchain": { run: "granted", env: "granted", write: "prompt" },
    "package-evidence": { run: "granted", env: "granted", write: "granted" },
  };
  for (const [name, states] of Object.entries(expected)) {
    const result = await runAsCompiled(["permissions", name]);
    assertEquals(result.code, 0, result.err);
    const seen = JSON.parse(result.out);
    for (const [category, state] of Object.entries(states)) {
      assertEquals(seen[category], state, `${name}: ${category}`);
    }
    // Never granted to the binary at all.
    for (const category of ["net", "ffi", "sys"]) {
      assert(seen[category] !== "granted", `${name}: ${category}`);
    }
  }
});

Deno.test("a revoked category is really denied to the command", async () => {
  // klean-prelude does not run programs: with the binary's own
  // permissions, its arguments name a missing file, so it fails on
  // reading it, never on a permission it has.
  const result = await runAsCompiled([
    "klean-prelude",
    `${CONTROLLER}does-not-exist/Prelude.lean`,
  ]);
  assert(result.code !== 0);
  assert(!result.err.includes("NotCapable"), result.err);
});

Deno.test("the dispatcher refuses unknown commands and stray arguments", async () => {
  const unknown = await runAsCompiled(["frobnicate"]);
  assertEquals(unknown.code, 2);
  assertStringIncludes(unknown.err, "unknown command");
  const stray = await runAsCompiled(["stage-klean", "extra"]);
  assertEquals(stray.code, 2);
  assertStringIncludes(stray.err, "takes no arguments");
  const inherited = await runAsCompiled(["toString"]);
  assertEquals(inherited.code, 2);
});

Deno.test("--help lists every command", async () => {
  const result = await runAsCompiled(["--help"]);
  assertEquals(result.code, 0);
  for (const name of Object.keys(COMMANDS)) {
    assertStringIncludes(result.out, name);
  }
});
