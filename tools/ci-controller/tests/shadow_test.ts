// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals } from "./assert.ts";
import { runShadow } from "../src/shadow.ts";

const REPO_ROOT = new URL("../../../", import.meta.url).pathname;

async function git(dir: string, ...args: string[]): Promise<string> {
  const command = new Deno.Command("git", {
    args: ["-C", dir, "-c", "commit.gpgsign=false", ...args],
    stdout: "piped",
    stderr: "piped",
    env: {
      ...Deno.env.toObject(),
      GIT_AUTHOR_NAME: "test",
      GIT_AUTHOR_EMAIL: "test@example.invalid",
      GIT_COMMITTER_NAME: "test",
      GIT_COMMITTER_EMAIL: "test@example.invalid",
    },
  });
  const { code, stdout, stderr } = await command.output();
  if (code !== 0) throw new Error(new TextDecoder().decode(stderr));
  return new TextDecoder().decode(stdout).trim();
}

Deno.test("shadow mode agrees with the legacy classifier on a real range", async () => {
  const dir = await Deno.makeTempDir({ prefix: "ci-shadow-test-" });
  try {
    await git(dir, "init", "-q");
    await Deno.mkdir(`${dir}/scripts/ci`, { recursive: true });
    await Deno.copyFile(
      `${REPO_ROOT}scripts/ci/impact.py`,
      `${dir}/scripts/ci/impact.py`,
    );
    await Deno.writeTextFile(`${dir}/README.md`, "# test\n");
    await git(dir, "add", ".");
    await git(dir, "commit", "-q", "-m", "base");
    const base = await git(dir, "rev-parse", "HEAD");
    await Deno.mkdir(`${dir}/src`, { recursive: true });
    await Deno.writeTextFile(`${dir}/src/Foo.lean`, "-- test\n");
    await Deno.writeTextFile(`${dir}/docs.md`, "# docs\n");
    await git(dir, "add", ".");
    await git(dir, "commit", "-q", "-m", "change");
    const head = await git(dir, "rev-parse", "HEAD");
    const result = await runShadow(base, head, "scripts/ci/impact.py", dir);
    assertEquals(result.divergences, []);
    assert(result.deno.lean_build);
    assert(result.deno.docs_links);
    assert(!result.deno.full);
  } finally {
    await Deno.remove(dir, { recursive: true }).catch(() => {});
  }
});
