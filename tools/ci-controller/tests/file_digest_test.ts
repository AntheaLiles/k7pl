// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assertEquals } from "./assert.ts";
import { sha256File } from "../src/file_digest.ts";

async function withTempFile(
  contents: Uint8Array,
  fn: (path: string) => Promise<void>,
): Promise<void> {
  const path = await Deno.makeTempFile();
  try {
    await Deno.writeFile(path, contents);
    await fn(path);
  } finally {
    await Deno.remove(path);
  }
}

Deno.test("sha256 of the empty file matches the known vector", async () => {
  await withTempFile(new Uint8Array(0), async (path) => {
    assertEquals(
      await sha256File(path),
      "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    );
  });
});

Deno.test("sha256 of 'abc' matches the known vector", async () => {
  await withTempFile(new TextEncoder().encode("abc"), async (path) => {
    assertEquals(
      await sha256File(path),
      "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
    );
  });
});

Deno.test("sha256 of a multi-chunk file matches the system tool", async () => {
  const contents = new Uint8Array(3 * 1024 * 1024);
  for (let i = 0; i < contents.length; i++) contents[i] = i % 251;
  await withTempFile(contents, async (path) => {
    const cmd = new Deno.Command("sha256sum", { args: [path] });
    const { stdout } = await cmd.output();
    const expected = new TextDecoder().decode(stdout).split(" ")[0];
    assertEquals(await sha256File(path), expected);
  });
});

Deno.test("sha256 of a missing file rejects", async () => {
  let rejected = false;
  try {
    await sha256File("/nonexistent/k7pl-file-digest-test");
  } catch {
    rejected = true;
  }
  assertEquals(rejected, true);
});
