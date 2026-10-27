// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Port of scripts/ci/k7pl_semantics_stage_klean.sh.
 *
 * Copies the Klean-generated K7PL2Lean modules into proofs/
 * (ignored by Git), replacing any earlier copy, and fails
 * unless proofs/lean-toolchain is leanprover/lean4:v4.34.0.
 *
 * Order is preserved from the shell script: the copy happens
 * first and the toolchain check second, so a toolchain
 * failure still leaves the freshly staged copy in place.
 * The shell script's `cp -a` also preserves modes and
 * symlinks; this port copies file contents and directory
 * structure (Deno.copyFile follows symlinks), which is the
 * behaviour the generated .lean sources depend on.
 */

export const EXPECTED_PROOFS_TOOLCHAIN = "leanprover/lean4:v4.34.0";

export interface StageKleanOptions {
  /** Default: $RUNNER_TEMP. */
  runnerTemp?: string;
  /** Default: $GITHUB_WORKSPACE. */
  workspace?: string;
  /** Line sink, defaulting to console.log. */
  log?: (line: string) => void;
}

export interface KleanStaging {
  proofRoot: string;
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

async function copyTree(source: string, dest: string): Promise<void> {
  await Deno.mkdir(dest, { recursive: true });
  for await (const entry of Deno.readDir(source)) {
    const from = `${source}/${entry.name}`;
    const to = `${dest}/${entry.name}`;
    if (entry.isDirectory) {
      await copyTree(from, to);
    } else {
      await Deno.copyFile(from, to);
    }
  }
}

export async function stageKlean(
  options: StageKleanOptions = {},
): Promise<KleanStaging> {
  const log = options.log ?? ((line: string) => console.log(line));
  const runnerTemp = requiredEnv("RUNNER_TEMP", options.runnerTemp);
  const workspace = requiredEnv("GITHUB_WORKSPACE", options.workspace);
  const packageDir = `${runnerTemp}/klean-output/k7pl2lean`;
  const proofRoot = `${workspace}/proofs`;
  await removeIfPresent(`${proofRoot}/K7PL2Lean`);
  await removeIfPresent(`${proofRoot}/K7PL2Lean.lean`);
  await copyTree(`${packageDir}/K7PL2Lean`, `${proofRoot}/K7PL2Lean`);
  await Deno.copyFile(
    `${packageDir}/K7PL2Lean.lean`,
    `${proofRoot}/K7PL2Lean.lean`,
  );
  // Command substitution in `$(cat ...)` strips trailing
  // newlines, so the comparison strips them too.
  const raw = await Deno.readTextFile(`${proofRoot}/lean-toolchain`);
  const toolchain = raw.replace(/\n+$/, "");
  if (toolchain !== EXPECTED_PROOFS_TOOLCHAIN) {
    throw new Error(
      `proofs/lean-toolchain is not ${EXPECTED_PROOFS_TOOLCHAIN}: ${toolchain}`,
    );
  }
  log("Staged generated Klean sources into proofs/ (ignored by Git).");
  return { proofRoot, toolchain };
}

if (import.meta.main) {
  try {
    await stageKlean();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    Deno.exit(1);
  }
}
