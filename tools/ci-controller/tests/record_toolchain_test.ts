// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { recordToolchain } from "../src/record_toolchain.ts";

async function writeStub(
  dir: string,
  name: string,
  body: string,
): Promise<string> {
  const path = `${dir}/${name}`;
  await Deno.writeTextFile(path, `#!/usr/bin/env bash\n${body}\n`);
  await Deno.chmod(path, 0o755);
  return path;
}

async function stubBin(): Promise<
  { dir: string; cleanup: () => Promise<void> }
> {
  const dir = await Deno.makeTempDir();
  await writeStub(
    dir,
    "kompile",
    `if [ "$1" = "--version" ]; then echo "kompile 7.1.337"; exit 0; fi\nexit 0`,
  );
  await writeStub(dir, "krun", `echo "krun stub"; exit 0`);
  await writeStub(
    dir,
    "python3",
    `if [ "$1" = "--version" ]; then echo "Python 3.12.0"; exit 0; fi\nif [ "$1" = "-m" ] && [ "$2" = "pip" ]; then echo "pip 24.0"; exit 0; fi\nexit 0`,
  );
  return { dir, cleanup: () => Deno.remove(dir, { recursive: true }) };
}

Deno.test("record_toolchain prints paths then versions, in order", async () => {
  const { dir, cleanup } = await stubBin();
  try {
    const lines: string[] = [];
    const record = await recordToolchain({
      path: `${dir}:${Deno.env.get("PATH") ?? ""}`,
      log: (l) => lines.push(l),
    });
    assertEquals(record.kompilePath, `${dir}/kompile`);
    assertEquals(record.krunPath, `${dir}/krun`);
    assertEquals(record.kompileVersion, "kompile 7.1.337");
    assertEquals(record.pythonVersion, "Python 3.12.0");
    assertEquals(record.pipVersion, "pip 24.0");
    assertEquals(lines, [
      `${dir}/kompile`,
      `${dir}/krun`,
      "kompile 7.1.337",
      "Python 3.12.0",
      "pip 24.0",
    ]);
  } finally {
    await cleanup();
  }
});

Deno.test("record_toolchain fails when krun is missing from PATH", async () => {
  const dir = await Deno.makeTempDir();
  try {
    await writeStub(dir, "kompile", `echo "kompile 7.1.337"`);
    let message = "";
    try {
      await recordToolchain({
        path: `${dir}:${Deno.env.get("PATH") ?? ""}`,
        log: () => {},
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assert(message.includes("krun"), `expected krun error, got ${message}`);
  } finally {
    await Deno.remove(dir, { recursive: true });
  }
});

Deno.test("record_toolchain fails when kompile --version fails", async () => {
  const dir = await Deno.makeTempDir();
  try {
    await writeStub(dir, "kompile", `echo "boom" >&2; exit 3`);
    await writeStub(dir, "krun", `exit 0`);
    await writeStub(dir, "python3", `exit 0`);
    let message = "";
    try {
      await recordToolchain({
        path: `${dir}:${Deno.env.get("PATH") ?? ""}`,
        log: () => {},
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assert(message.includes("exit status 3"), message);
  } finally {
    await Deno.remove(dir, { recursive: true });
  }
});
