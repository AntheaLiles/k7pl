// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_semantics_export_lean.sh.
 *
 * Exports the compiled K definition (src/k/.build/kompiled) to
 * a Lean package with Klean, in $RUNNER_TEMP/klean-output/
 * k7pl2lean; replaces the generated lean-toolchain with the
 * repository's one; fails when an expected generated file is
 * missing or empty; records the generated file list and
 * toolchain in .formal-chain-evidence/ and in the job summary.
 *
 * Deliberate deviation from the shell script (see also the
 * report): the original writes its summary headings with
 * `printf '%s\\n'`, which prints a literal backslash-n, not a
 * newline, so the heading runs into the next line. This port
 * writes real newlines; the file list, the toolchain content
 * and the set of recorded files are unchanged. Klean's
 * published template currently defaults to Lean 4.30.0 while
 * K7PL pins 4.34.0; overwriting the generated toolchain is
 * kept as the same explicit compatibility probe, then build.
 */

export interface ExportLeanOptions {
  /** Default: $RUNNER_TEMP. */
  runnerTemp?: string;
  /** Default: $GITHUB_WORKSPACE. */
  workspace?: string;
  /** Default: $GITHUB_STEP_SUMMARY. */
  stepSummary?: string;
  /** PATH for klean, defaulting to the process PATH. */
  path?: string;
}

/** Files that must exist and be non-empty in the Klean package. */
export const EXPECTED_KLEAN_FILES = [
  "K7PL2Lean.lean",
  "lakefile.toml",
  "lean-toolchain",
  "K7PL2Lean/Prelude.lean",
  "K7PL2Lean/Sorts.lean",
  "K7PL2Lean/Inj.lean",
  "K7PL2Lean/Func.lean",
  "K7PL2Lean/Rewrite.lean",
] as const;

export interface LeanExport {
  packageDir: string;
  files: string[];
  toolchain: string;
}

function requiredEnv(name: string, override: string | undefined): string {
  if (override !== undefined) return override;
  const value = Deno.env.get(name);
  if (value === undefined) throw new Error(`${name}: unbound variable`);
  return value;
}

async function removeIfPresent(path: string): Promise<void> {
  try {
    await Deno.remove(path, { recursive: true });
  } catch (error) {
    if (!(error instanceof Deno.errors.NotFound)) throw error;
  }
}

/** Files at depth 1 or 2 under `dir`, as absolute paths, sorted. */
async function listFilesMaxDepth2(dir: string): Promise<string[]> {
  const files: string[] = [];
  for await (const entry of Deno.readDir(dir)) {
    const entryPath = `${dir}/${entry.name}`;
    if (entry.isFile) {
      files.push(entryPath);
    } else if (entry.isDirectory) {
      for await (const nested of Deno.readDir(entryPath)) {
        if (nested.isFile) files.push(`${entryPath}/${nested.name}`);
      }
    }
  }
  return files.sort((a, b) => (a < b ? -1 : a > b ? 1 : 0));
}

async function appendText(path: string, text: string): Promise<void> {
  const file = await Deno.open(path, {
    write: true,
    append: true,
    create: true,
  });
  try {
    await file.write(new TextEncoder().encode(text));
  } finally {
    file.close();
  }
}

export async function exportLean(
  options: ExportLeanOptions = {},
): Promise<LeanExport> {
  const runnerTemp = requiredEnv("RUNNER_TEMP", options.runnerTemp);
  const workspace = requiredEnv("GITHUB_WORKSPACE", options.workspace);
  const stepSummary = requiredEnv("GITHUB_STEP_SUMMARY", options.stepSummary);
  const kleanOut = `${runnerTemp}/klean-output`;
  const evidence = `${workspace}/.formal-chain-evidence`;
  await removeIfPresent(kleanOut);
  await removeIfPresent(evidence);
  await Deno.mkdir(kleanOut, { recursive: true });
  await Deno.mkdir(evidence, { recursive: true });

  const klean = new Deno.Command("klean", {
    args: [
      `${workspace}/src/k/.build/kompiled`,
      "k7pl2lean",
      "--library",
      "K7PL2Lean",
      "--output",
      kleanOut,
    ],
    stdout: "inherit",
    stderr: "inherit",
    env: options.path !== undefined ? { PATH: options.path } : undefined,
  });
  const { code } = await klean.output();
  if (code !== 0) {
    throw new Error(`klean failed with exit status ${code}`);
  }

  const packageDir = `${kleanOut}/k7pl2lean`;
  let packageStat: Deno.FileInfo;
  try {
    packageStat = await Deno.stat(packageDir);
  } catch {
    throw new Error(`Klean output directory missing: ${packageDir}`);
  }
  if (!packageStat.isDirectory) {
    throw new Error(`Klean output directory missing: ${packageDir}`);
  }

  const toolchain = await Deno.readTextFile(`${workspace}/lean-toolchain`);
  await Deno.writeTextFile(`${packageDir}/lean-toolchain`, toolchain);

  for (const relative of EXPECTED_KLEAN_FILES) {
    const filePath = `${packageDir}/${relative}`;
    let stat: Deno.FileInfo;
    try {
      stat = await Deno.stat(filePath);
    } catch {
      throw new Error(`Missing Klean output: ${filePath}`);
    }
    if (!stat.isFile || stat.size === 0) {
      throw new Error(`Missing Klean output: ${filePath}`);
    }
  }

  const files = await listFilesMaxDepth2(packageDir);
  const fileList = files.length > 0 ? `${files.join("\n")}\n` : "";
  await Deno.writeTextFile(`${evidence}/klean-files.txt`, fileList);
  await Deno.writeTextFile(`${evidence}/klean-toolchain.txt`, toolchain);
  // Real newlines here: the shell script's '%s\\n' wrote a
  // literal backslash-n (see the module doc comment).
  await appendText(
    stepSummary,
    `## Generated Klean package\n${fileList}## Generated toolchain\n${toolchain}`,
  );
  return { packageDir, files, toolchain };
}

if (import.meta.main) {
  try {
    await exportLean();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
