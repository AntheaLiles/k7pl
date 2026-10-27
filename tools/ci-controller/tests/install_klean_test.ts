// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

import { assert, assertEquals, assertStringIncludes } from "./assert.ts";
import { installKlean, KFRAMEWORK_PIN } from "../src/install_klean.ts";

/**
 * A fake python3: `-m venv <dir>` fabricates a venv whose
 * bin/python records its arguments in pip-args.txt and
 * whose bin/klean prints help (or fails, when asked).
 */
async function stubBin(kleanFails: boolean): Promise<string> {
  const dir = await Deno.makeTempDir();
  const kleanBody = kleanFails
    ? `echo "klean broken" >&2; exit 1`
    : `echo "usage: klean"; exit 0`;
  const stub = "#!/usr/bin/env bash\n" +
    `if [ "$1" = "-m" ] && [ "$2" = "venv" ]; then\n` +
    `  mkdir -p "$3/bin"\n` +
    `  printf '%s\\n' '#!/usr/bin/env bash' 'echo "$@" >> "$(dirname "$0")/../pip-args.txt"' 'exit 0' > "$3/bin/python"\n` +
    `  printf '%s\\n' '#!/usr/bin/env bash' '${kleanBody}' > "$3/bin/klean"\n` +
    `  chmod +x "$3/bin/python" "$3/bin/klean"\n` +
    `  exit 0\n` +
    `fi\n` +
    `exit 0\n`;
  const path = `${dir}/python3`;
  await Deno.writeTextFile(path, stub);
  await Deno.chmod(path, 0o755);
  return dir;
}

Deno.test("install_klean creates venv, pins kframework, checks klean, appends bin to GITHUB_PATH", async () => {
  const bin = await stubBin(false);
  const root = await Deno.makeTempDir();
  try {
    const githubPath = `${root}/github_path`;
    await Deno.writeTextFile(githubPath, "/existing/bin\n");
    const result = await installKlean({
      runnerTemp: root,
      githubPath,
      path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
      log: () => {},
    });
    assertEquals(result.venvDir, `${root}/klean-venv`);
    assertEquals(result.binDir, `${root}/klean-venv/bin`);
    assertEquals(result.pin, "kframework==7.1.337");
    assertEquals(KFRAMEWORK_PIN, "kframework==7.1.337");
    const pipArgs = await Deno.readTextFile(`${root}/klean-venv/pip-args.txt`);
    assertStringIncludes(pipArgs, "--disable-pip-version-check");
    assertStringIncludes(pipArgs, "kframework==7.1.337");
    assertEquals(
      await Deno.readTextFile(githubPath),
      `/existing/bin\n${root}/klean-venv/bin\n`,
    );
  } finally {
    await Deno.remove(root, { recursive: true });
    await Deno.remove(bin, { recursive: true });
  }
});

Deno.test("install_klean fails when klean --help fails", async () => {
  const bin = await stubBin(true);
  const root = await Deno.makeTempDir();
  try {
    let message = "";
    try {
      await installKlean({
        runnerTemp: root,
        githubPath: `${root}/github_path`,
        path: `${bin}:${Deno.env.get("PATH") ?? ""}`,
        log: () => {},
      });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assert(message.includes("exit status 1"), message);
  } finally {
    await Deno.remove(root, { recursive: true });
    await Deno.remove(bin, { recursive: true });
  }
});

Deno.test("install_klean fails on unset RUNNER_TEMP", async () => {
  const saved = Deno.env.get("RUNNER_TEMP");
  Deno.env.delete("RUNNER_TEMP");
  try {
    let message = "";
    try {
      await installKlean({ githubPath: "/tmp/does-not-matter", log: () => {} });
    } catch (error) {
      message = error instanceof Error ? error.message : String(error);
    }
    assertStringIncludes(message, "RUNNER_TEMP");
  } finally {
    if (saved !== undefined) Deno.env.set("RUNNER_TEMP", saved);
  }
});
