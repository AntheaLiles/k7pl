// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_semantics_record_toolchain.sh.
 *
 * Records in the log where the K tools are and which versions of
 * K, Python and pip the job runs (the container image pins K).
 * Fails when kompile or krun is not on PATH.
 *
 * The shell script prints the `command -v` paths and then the
 * version output of each tool, in this order: kompile path, krun
 * path, `kompile --version`, `python3 --version`,
 * `python3 -m pip --version`. This port preserves that order.
 * `command -v` prints nothing and exits non-zero for a missing
 * tool; this port throws an error naming the tool instead, so
 * the failure is diagnosable in the log.
 */

export interface RecordToolchainOptions {
  /** PATH to search, defaulting to the process PATH. */
  path?: string;
  /** Line sink, defaulting to console.log. */
  log?: (line: string) => void;
}

export interface ToolchainRecord {
  kompilePath: string;
  krunPath: string;
  kompileVersion: string;
  pythonVersion: string;
  pipVersion: string;
}

async function findOnPath(
  name: string,
  pathEnv: string,
): Promise<string | undefined> {
  for (const dir of pathEnv.split(":")) {
    if (dir === "") continue;
    const candidate = `${dir}/${name}`;
    try {
      const info = await Deno.stat(candidate);
      if (info.isFile && (info.mode === null || (info.mode & 0o111) !== 0)) {
        return candidate;
      }
    } catch {
      // Not present (or not stat-able) in this directory; keep looking.
    }
  }
  return undefined;
}

async function runVersion(
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
  return `${out}${err}`.trim();
}

export async function recordToolchain(
  options: RecordToolchainOptions = {},
): Promise<ToolchainRecord> {
  const log = options.log ?? ((line: string) => console.log(line));
  const pathEnv = options.path ?? Deno.env.get("PATH") ?? "";
  const kompilePath = await findOnPath("kompile", pathEnv);
  if (kompilePath === undefined) {
    throw new Error("kompile not found on PATH");
  }
  const krunPath = await findOnPath("krun", pathEnv);
  if (krunPath === undefined) {
    throw new Error("krun not found on PATH");
  }
  log(kompilePath);
  log(krunPath);
  const kompileVersion = await runVersion(
    "kompile",
    ["--version"],
    options.path,
  );
  log(kompileVersion);
  const pythonVersion = await runVersion(
    "python3",
    ["--version"],
    options.path,
  );
  log(pythonVersion);
  const pipVersion = await runVersion(
    "python3",
    ["-m", "pip", "--version"],
    options.path,
  );
  log(pipVersion);
  return { kompilePath, krunPath, kompileVersion, pythonVersion, pipVersion };
}

if (import.meta.main) {
  try {
    await recordToolchain();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
