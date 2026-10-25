// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Build-proofs contract, ported from
 * scripts/ci/k7pl_semantics_build_proofs.sh — with one deliberate,
 * fail-closed strengthening: the shell script checked the build
 * log with grep on raw log text, and this port parses the log
 * structurally instead.
 *
 * The ported contract is:
 * - run `lake build K7PL2Lean K7PL` and capture its log (the
 *   Lean build is the proof; this module only audits its output);
 * - fail on any `sorryAx` in the log;
 * - fail if either machine-soundness theorem has no axiom record;
 * - fail if any listed bridge / native-boundary declaration has
 *   no axiom record at all.
 *
 * Structural parsing, and the cases it rejects that grep also
 * rejected (plus the one case it now rejects that grep missed):
 * - A declaration counts only when a whole `#print axioms`
 *   record for that exact quoted name appears on one log line,
 *   parsed by {@link parseAxiomRecords}. A log that merely
 *   mentions a theorem name in an unrelated line, mentions it as
 *   a prefix of a longer declaration name, or lists it inside
 *   another declaration's axiom set, does not satisfy the check.
 * - Preserved quirk from the shell script: the two
 *   machine-soundness theorems require a `depends on axioms:`
 *   record specifically. A `does not depend on any axioms` line
 *   for one of them does NOT satisfy the check, exactly as the
 *   old `grep -Fq "... depends on axioms:"` required. (The
 *   downstream axiom audit would reject a zero-axiom report for
 *   these theorems anyway, since the contract pins `propext`.)
 * - By contrast, each bridge / native-boundary declaration is
 *   satisfied by either record form, exactly as the shell loop
 *   accepted either grep pattern.
 * - `sorryAx` is checked on the ANSI-stripped log, matching the
 *   axiom report's check. The old grep checked raw text, so a
 *   `sorryAx` split by ANSI escapes would have passed this
 *   script (and then failed the downstream axiom report). This
 *   port rejects it here too: strictly stronger, never weaker.
 * - Duplicate or conflicting records are NOT rejected here: the
 *   old grep did not check for them, and the axiom audit owns
 *   that check. Presence, not uniqueness, is this module's job.
 * - Stream ordering caveat: Deno captures stdout and stderr
 *   separately, so {@link runBuildProofs} concatenates stdout
 *   then stderr, whereas the shell `2>&1 | tee` preserved
 *   interleaving. Every check here is line-set based, so log
 *   line order across streams cannot change the verdict.
 */

import { parseAxiomRecords, stripAnsi } from "./axiom_report.ts";

/** The two machine-soundness theorems (shell script order). */
export const MACHINE_SOUNDNESS_THEOREMS = [
  "K7PL.MachineSoundness.rewrites_preserve_machine_typing",
  "K7PL.MachineSoundness.end_to_end_preservation",
] as const;

/** Bridge / native-boundary declarations (shell script order). */
export const BRIDGE_NATIVE_DECLARATIONS = [
  "K7PL.Bridge.add_root_is_klean_rewrite",
  "K7PL.Bridge.less_than_root_is_klean_rewrite",
  "K7PL.Bridge.select_true_root_is_klean_rewrite",
  "K7PL.Bridge.select_false_root_is_klean_rewrite",
  "K7PL.NativeBoundary.enforcedBoundary_step_preserves_protected",
  "K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected",
  "K7PL.NativeBoundary.unconfined_native_write_counterexample",
  "K7PL.NativeBoundary.unconfined_native_write_trace_replay",
] as const;

/**
 * Structural audit of a captured build log. Returns error
 * strings in check order (sorryAx, then machine-soundness
 * theorems, then bridge / native-boundary declarations); an
 * empty array means the log satisfies the contract.
 */
export function checkBuildLog(text: string): string[] {
  const errors: string[] = [];
  if (stripAnsi(text).includes("sorryAx")) {
    errors.push("Lean axiom audit found sorryAx in the build output.");
  }
  const records = parseAxiomRecords(text);
  const hasDependsRecord = (name: string): boolean =>
    records.some((record) => record.name === name && record.kind === "depends");
  const hasAnyRecord = (name: string): boolean =>
    records.some((record) => record.name === name);
  for (const theorem of MACHINE_SOUNDNESS_THEOREMS) {
    if (!hasDependsRecord(theorem)) {
      errors.push(`Missing axiom audit for ${theorem}.`);
    }
  }
  for (const declaration of BRIDGE_NATIVE_DECLARATIONS) {
    if (!hasAnyRecord(declaration)) {
      errors.push(`Missing axiom audit for ${declaration}.`);
    }
  }
  return errors;
}

export interface BuildProofsResult {
  /** Lake's exit code when it failed, else 1 on audit failure, else 0. */
  exitCode: number;
  log: string;
  errors: string[];
}

export interface RunBuildProofsOptions {
  /** When set, the captured log is written to this path (tee). */
  logPath?: string;
  /** Working directory for `lake build` (the proofs directory). */
  workingDir?: string;
}

/**
 * Run `lake build K7PL2Lean K7PL`, capture the log, and audit it
 * with {@link checkBuildLog}. A non-zero lake exit is itself a
 * failure, mirroring `set -euo pipefail` in the shell script:
 * the audit verdict never overrides a failed build.
 */
export async function runBuildProofs(
  options: RunBuildProofsOptions = {},
): Promise<BuildProofsResult> {
  const command = new Deno.Command("lake", {
    args: ["build", "K7PL2Lean", "K7PL"],
    stdout: "piped",
    stderr: "piped",
    cwd: options.workingDir,
  });
  const { code, stdout, stderr } = await command.output();
  const decoder = new TextDecoder();
  const log = decoder.decode(stdout) + decoder.decode(stderr);
  if (options.logPath !== undefined) {
    await Deno.writeTextFile(options.logPath, log);
  }
  const errors: string[] = [];
  if (code !== 0) {
    errors.push(`lake build K7PL2Lean K7PL exited with code ${code}`);
  }
  errors.push(...checkBuildLog(log));
  return {
    exitCode: code !== 0 ? code : (errors.length > 0 ? 1 : 0),
    log,
    errors,
  };
}

function parseCliArgs(argv: string[]): Map<string, string | boolean> {
  const flags = new Map<string, string | boolean>();
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    if (!arg.startsWith("--")) continue;
    const key = arg.slice(2);
    const eq = key.indexOf("=");
    if (eq >= 0) {
      flags.set(key.slice(0, eq), key.slice(eq + 1));
    } else if (i + 1 < argv.length) {
      flags.set(key, argv[++i]);
    } else {
      flags.set(key, true);
    }
  }
  return flags;
}

/**
 * CLI: `--log <file>` audits an existing log without running
 * lake; `--build [--log-output <file>] [--workdir <dir>]` runs
 * lake, tees the log to stdout and to --log-output when given,
 * then audits it. Returns a process exit code. The parent
 * controller (main.ts) is intentionally not wired to this command
 * in this slice; run this file directly.
 */
export async function runBuildProofsCli(argv: string[]): Promise<number> {
  const args = parseCliArgs(argv);
  const logPath = args.get("log");
  const build = args.get("build") === true;
  if (typeof logPath !== "string" && !build) {
    console.error(
      "usage: deno run --allow-read --allow-run --allow-write src/build_proofs.ts --log <log> | --build [--log-output <log>] [--workdir <dir>]",
    );
    return 2;
  }
  try {
    let result: BuildProofsResult;
    if (typeof logPath === "string") {
      const log = await Deno.readTextFile(logPath);
      const errors = checkBuildLog(log);
      result = { exitCode: errors.length > 0 ? 1 : 0, log, errors };
    } else {
      result = await runBuildProofs({
        logPath: typeof args.get("log-output") === "string"
          ? String(args.get("log-output"))
          : undefined,
        workingDir: typeof args.get("workdir") === "string"
          ? String(args.get("workdir"))
          : undefined,
      });
      if (result.log !== "") {
        Deno.stdout.writeSync(new TextEncoder().encode(result.log));
      }
    }
    if (result.errors.length > 0) {
      for (const error of result.errors) console.error(`::error::${error}`);
      return result.exitCode;
    }
    console.log("build proofs audit passed");
    return 0;
  } catch (error) {
    console.error(
      `build proofs audit failed: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
    return 1;
  }
}

if (import.meta.main) {
  Deno.exit(await runBuildProofsCli(Deno.args));
}
