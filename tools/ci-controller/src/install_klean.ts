// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_semantics_install_klean.sh.
 *
 * Installs the pinned Klean generator in a virtual environment
 * under RUNNER_TEMP, checks that `klean --help` runs, and adds
 * the environment's bin directory to the GITHUB_PATH file for
 * the later steps of the job.
 *
 * The shell script reads RUNNER_TEMP and GITHUB_PATH from the
 * environment under `set -u`, so an unset variable aborts it;
 * this port throws `${name}: unbound variable` in that case.
 * The kframework pin is exact and is exported so tests (and
 * later slices) pin the same value rather than re-typing it.
 */

export const KFRAMEWORK_PIN = "kframework==7.1.337";

export interface InstallKleanOptions {
  /** Default: $RUNNER_TEMP. */
  runnerTemp?: string;
  /** Default: $GITHUB_PATH. */
  githubPath?: string;
  /** PATH for the subprocesses, defaulting to the process PATH. */
  path?: string;
  /** Line sink, defaulting to console.log. */
  log?: (line: string) => void;
}

export interface KleanInstall {
  venvDir: string;
  binDir: string;
  pin: string;
}

function requiredEnv(name: string, override: string | undefined): string {
  if (override !== undefined) return override;
  const value = Deno.env.get(name);
  if (value === undefined) throw new Error(`${name}: unbound variable`);
  return value;
}

async function run(
  command: string,
  args: string[],
  pathEnv: string | undefined,
): Promise<string> {
  const process = new Deno.Command(command, {
    args,
    stdout: "piped",
    stderr: "piped",
    env: pathEnv !== undefined ? { PATH: pathEnv } : undefined,
  });
  const { code, stdout, stderr } = await process.output();
  const out = new TextDecoder().decode(stdout);
  const err = new TextDecoder().decode(stderr);
  if (code !== 0) {
    throw new Error(
      `${command} ${
        args.join(" ")
      } failed with exit status ${code}: ${err.trim()}`,
    );
  }
  return out;
}

export async function installKlean(
  options: InstallKleanOptions = {},
): Promise<KleanInstall> {
  const log = options.log ?? ((line: string) => console.log(line));
  const runnerTemp = requiredEnv("RUNNER_TEMP", options.runnerTemp);
  const githubPath = requiredEnv("GITHUB_PATH", options.githubPath);
  const venvDir = `${runnerTemp}/klean-venv`;
  const binDir = `${venvDir}/bin`;
  await run("python3", ["-m", "venv", venvDir], options.path);
  await run(
    `${binDir}/python`,
    ["-m", "pip", "install", "--disable-pip-version-check", KFRAMEWORK_PIN],
    options.path,
  );
  const help = await run(`${binDir}/klean`, ["--help"], options.path);
  if (help.trim() !== "") log(help.trim());
  const file = await Deno.open(githubPath, {
    write: true,
    append: true,
    create: true,
  });
  try {
    await file.write(new TextEncoder().encode(`${binDir}\n`));
  } finally {
    file.close();
  }
  return { venvDir, binDir, pin: KFRAMEWORK_PIN };
}

if (import.meta.main) {
  try {
    await installKlean();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
