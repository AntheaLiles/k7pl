// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import {
  BOUNDARY_CASES,
  checkOsBoundary,
  main,
} from "../src/os_boundary_check.ts";

/** A fake krun: prints a canned boundary result per example file. */
async function stubKrun(confined: string): Promise<string> {
  const dir = await Deno.makeTempDir();
  const body = "#!/usr/bin/env bash\n" +
    `case "$3" in\n` +
    `  *conforming-call.k7) echo "boundaryResult (0, 1)" ;;\n` +
    `  *native-write-confined.k7) echo "${confined}" ;;\n` +
    `  *native-write-unconfined.k7) echo "boundaryResult(1,0)" ;;\n` +
    `esac\n` +
    `exit 0\n`;
  const path = `${dir}/krun`;
  await Deno.writeTextFile(path, body);
  await Deno.chmod(path, 0o755);
  return path;
}

async function examplesDir(): Promise<string> {
  const dir = await Deno.makeTempDir();
  for (const testCase of BOUNDARY_CASES) {
    await Deno.writeTextFile(`${dir}/${testCase.file}`, "example\n");
  }
  return dir;
}

Deno.test("os_boundary_check passes all three cases, including spaced output", async () => {
  const krun = await stubKrun("boundaryResult ( 0 , 0 )");
  const examples = await examplesDir();
  try {
    const lines: string[] = [];
    const passed = await checkOsBoundary({
      definition: "/tmp/def",
      krun,
      examplesDir: examples,
      log: (l) => lines.push(l),
      errorLog: () => {},
    });
    assertEquals(passed, [
      "conforming-call.k7",
      "native-write-confined.k7",
      "native-write-unconfined.k7",
    ]);
    assertStringIncludes(lines.join("\n"), "=== conforming-call.k7 ===");
    assertStringIncludes(lines.join("\n"), "boundaryResult ( 0 , 0 )");
  } finally {
    await Deno.remove(examples, { recursive: true });
    await Deno.remove(krun.split("/").slice(0, -1).join("/"), {
      recursive: true,
    });
  }
});

Deno.test("os_boundary_check fails on the first mismatching case, naming the file", async () => {
  const krun = await stubKrun("boundaryResult (9, 9)");
  const examples = await examplesDir();
  try {
    const lines: string[] = [];
    const errors: string[] = [];
    let message = "";
    try {
      await checkOsBoundary({
        definition: "/tmp/def",
        krun,
        examplesDir: examples,
        log: (l) => lines.push(l),
        errorLog: (l) => errors.push(l),
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "native-write-confined.k7");
    assertStringIncludes(errors.join("\n"), "native-write-confined.k7");
    // The earlier case already printed, as in the shell script.
    assertStringIncludes(lines.join("\n"), "=== conforming-call.k7 ===");
    assert(
      !lines.join("\n").includes("native-write-unconfined"),
      "later cases must not run",
    );
  } finally {
    await Deno.remove(examples, { recursive: true });
    await Deno.remove(krun.split("/").slice(0, -1).join("/"), {
      recursive: true,
    });
  }
});

Deno.test("os_boundary_check usage: fewer than three arguments exits 2", async () => {
  assertEquals(await main(["only-one"]), 2);
  assertEquals(await main([]), 2);
});
