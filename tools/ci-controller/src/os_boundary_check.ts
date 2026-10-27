// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_os_boundary_check.sh.
 *
 * Runs the boundary check: for each example, run krun
 * against the definition, print the case header and the
 * output, and fail unless the output matches the expected
 * result pattern.
 *
 * The shell patterns are POSIX extended regexes using
 * `[[:space:]]`; they are transcribed below as JavaScript
 * regex sources with `\s` in place of `[[:space:]]` and
 * are matched as substrings, as `grep -E` matches. The
 * shell script's `printf %q` quoting of a failing pattern
 * is approximated (backslash-escape every character
 * outside the shell-safe set); the message wording and
 * the failing file name are preserved.
 */

export interface BoundaryCase {
  file: string;
  /** JavaScript regex source for the expected result pattern. */
  pattern: string;
}

export const BOUNDARY_CASES: readonly BoundaryCase[] = [
  {
    file: "conforming-call.k7",
    pattern: "boundaryResult\\s*\\(\\s*0\\s*,\\s*1\\s*\\)",
  },
  {
    file: "native-write-confined.k7",
    pattern: "boundaryResult\\s*\\(\\s*0\\s*,\\s*0\\s*\\)",
  },
  {
    file: "native-write-unconfined.k7",
    pattern: "boundaryResult\\s*\\(\\s*1\\s*,\\s*0\\s*\\)",
  },
];

export interface OsBoundaryCheckOptions {
  definition: string;
  /** krun command: a path or a name on PATH. */
  krun: string;
  examplesDir: string;
  /** PATH for krun lookup, defaulting to the process PATH. */
  path?: string;
  /** Line sink, defaulting to console.log. */
  log?: (line: string) => void;
  /** Error sink, defaulting to console.error. */
  errorLog?: (line: string) => void;
}

/** Error carrying the subprocess exit status, as `set -e` would surface it. */
export class CommandError extends Error {
  code: number;
  constructor(message: string, code: number) {
    super(message);
    this.code = code;
  }
}

/** Approximation of bash `printf %q` for the failing pattern. */
export function shellQuote(value: string): string {
  if (/^[A-Za-z0-9_@%+=:,./-]+$/.test(value)) return value;
  return value.replace(/[^A-Za-z0-9_@%+=:,./-]/g, (ch) => `\\${ch}`);
}

export async function checkOsBoundary(
  options: OsBoundaryCheckOptions,
): Promise<string[]> {
  const log = options.log ?? ((line: string) => console.log(line));
  const errorLog = options.errorLog ?? ((line: string) => console.error(line));
  const passed: string[] = [];
  for (const testCase of BOUNDARY_CASES) {
    const example = `${options.examplesDir}/${testCase.file}`;
    const process = new Deno.Command(options.krun, {
      args: ["--definition", options.definition, example],
      stdout: "piped",
      stderr: "piped",
      env: options.path !== undefined ? { PATH: options.path } : undefined,
    });
    const { code, stdout, stderr } = await process.output();
    if (code !== 0) {
      throw new CommandError(
        `${options.krun} --definition ${options.definition} ${example} failed with exit status ${code}: ${
          new TextDecoder().decode(stderr).trim()
        }`,
        code,
      );
    }
    // Command substitution strips trailing newlines.
    const output = new TextDecoder().decode(stdout).replace(/\n+$/, "");
    log(`=== ${testCase.file} ===`);
    log(output);
    if (!new RegExp(testCase.pattern).test(output)) {
      const message = `Expected result pattern ${
        shellQuote(testCase.pattern)
      } not found for ${testCase.file}`;
      errorLog(message);
      throw new Error(message);
    }
    passed.push(testCase.file);
  }
  return passed;
}

export const USAGE =
  "usage: k7pl_os_boundary_check.sh DEFINITION KRUN EXAMPLE_DIRECTORY";

/** Returns a process exit code: 2 for bad arguments, else 0, else the failing status. */
export async function main(args: readonly string[]): Promise<number> {
  if (args.length < 3) {
    console.error(USAGE);
    return 2;
  }
  try {
    await checkOsBoundary({
      definition: args[0],
      krun: args[1],
      examplesDir: args[2],
    });
    return 0;
  } catch (error) {
    if (!(error instanceof CommandError)) {
      console.error(error instanceof Error ? error.message : String(error));
    }
    return error instanceof CommandError ? error.code : 1;
  }
}

if (import.meta.main) {
  Deno.exit(await main(Deno.args));
}
