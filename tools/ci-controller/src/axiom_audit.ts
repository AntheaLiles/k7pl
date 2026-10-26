// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Axiom audit, the single definition of the leanprover-community
 * axiom-audit control (cutover C1 deduplication).
 *
 * This module replaces two shell scripts that were the same
 * control in two shapes:
 * - scripts/axiom-audit.sh, the primitive: build the pinned
 *   axiom-audit tool once per job, then run it on one root
 *   namespace with an allowlist;
 * - scripts/ci/verify_audit_axioms.sh, the fan-out: enumerate
 *   the lean_lib/lean_exe roots declared under a directory in
 *   lakefile.lean and audit each one, aggregating failures.
 *
 * What this module deliberately does NOT absorb:
 * axiom_report.ts and build_proofs.ts, already ported from the
 * proofs project's scripts. Those enforce a different guarantee
 * — the exact `#print axioms` dependency set of every tracked
 * declaration against proofs/axiom-audit-contract.json — while
 * this module enforces an allowlist over a whole audited module
 * tree. Merging the two would lose one guarantee or the other,
 * so both controls stay, each with one definition.
 *
 * Pinned tool (same pins as the shell primitive; tags are
 * mutable, so the commit is the real pin):
 * - axiom-audit v0.1.2, commit 46024e005996495c65ef609368e11ab39c4222e3
 * - default allowlist: propext, Classical.choice, Quot.sound
 *   (overridable with AXIOM_AUDIT_ALLOW, as before)
 *
 * Tool reuse, as before: with RUNNER_TEMP set, the checkout
 * lives in $RUNNER_TEMP/axiom-audit-<sha> and is reused by the
 * next call of the same job only if it is still the pinned
 * commit, no tracked file changed (lean-toolchain excluded,
 * compared separately), and it was built for this project's
 * lean-toolchain. Without RUNNER_TEMP a temporary directory is
 * used and removed afterwards.
 *
 * CLI (run from the repository root):
 * - `axiom_audit.ts audit <root> [lake-target...]`
 * - `axiom_audit.ts audit-roots <directory> [module-prefix]`
 * Exit codes: the audited command's code on failure, 1 when any
 * fan-out audit failed, 2 on usage error. The fan-out audits
 * every root even if an earlier one failed, as before.
 */

import { checkLeanModules } from "./lean_modules.ts";

export const AXIOM_AUDIT_REF = "v0.1.2";
export const AXIOM_AUDIT_SHA = "46024e005996495c65ef609368e11ab39c4222e3";
export const AXIOM_AUDIT_URL =
  "https://github.com/leanprover-community/axiom-audit.git";
export const DEFAULT_ALLOW = "propext,Classical.choice,Quot.sound";

export interface RunResult {
  code: number;
  stdout: string;
  stderr: string;
}

export type CaptureFn = (
  cmd: string,
  args: string[],
  opts?: { cwd?: string },
) => Promise<RunResult> | RunResult;

export type InheritFn = (
  cmd: string,
  args: string[],
  opts?: { cwd?: string },
) => Promise<number> | number;

const decoder = new TextDecoder();

export const denoCapture: CaptureFn = async (cmd, args, opts) => {
  const { code, stdout, stderr } = await new Deno.Command(cmd, {
    args,
    stdout: "piped",
    stderr: "piped",
    cwd: opts?.cwd,
  }).output();
  return {
    code,
    stdout: decoder.decode(stdout),
    stderr: decoder.decode(stderr),
  };
};

export const denoInherit: InheritFn = async (cmd, args, opts) => {
  const { code } = await new Deno.Command(cmd, {
    args,
    stdout: "inherit",
    stderr: "inherit",
    cwd: opts?.cwd,
  }).output();
  return code;
};

export interface Runner {
  capture: CaptureFn;
  inherit: InheritFn;
}

export const denoRunner: Runner = {
  capture: denoCapture,
  inherit: denoInherit,
};

/** Where the tool checkout lives for this job (or null: use a temp dir). */
export function toolDirFor(runnerTemp: string | undefined): string | null {
  return runnerTemp === undefined || runnerTemp === ""
    ? null
    : `${runnerTemp}/axiom-audit-${AXIOM_AUDIT_SHA}`;
}

async function isExecutable(path: string): Promise<boolean> {
  try {
    const info = await Deno.stat(path);
    return info.isFile && (info.mode !== null && (info.mode & 0o111) !== 0);
  } catch {
    return false;
  }
}

async function isReusable(
  toolDir: string,
  bin: string,
  runner: Runner,
  cwd?: string,
): Promise<boolean> {
  if (!(await isExecutable(bin))) return false;
  const head = await runner.capture(
    "git",
    ["-C", toolDir, "rev-parse", "HEAD"],
    { cwd },
  );
  if (head.code !== 0 || head.stdout.trim() !== AXIOM_AUDIT_SHA) return false;
  const diff = await runner.capture(
    "git",
    [
      "-C",
      toolDir,
      "diff",
      "--quiet",
      "HEAD",
      "--",
      ".",
      ":(exclude)lean-toolchain",
    ],
    { cwd },
  );
  if (diff.code !== 0) return false;
  const cmp = await runner.capture(
    "cmp",
    ["-s", "lean-toolchain", `${toolDir}/lean-toolchain`],
    { cwd },
  );
  return cmp.code === 0;
}

export interface AuditRootOptions {
  root: string;
  targets?: string[];
  allow?: string;
  runnerTemp?: string;
  cwd?: string;
  runner?: Runner;
}

export interface AuditRootResult {
  code: number;
  errors: string[];
  reused: boolean;
}

/**
 * Audit one root namespace: `lake build` its targets, ensure the
 * pinned tool, then `lake env axiom-audit --allow … --root …`.
 * A failed build stops the audit, mirroring `set -e` in the shell
 * primitive: no audit verdict overrides a failed build.
 */
export async function auditRoot(
  options: AuditRootOptions,
): Promise<AuditRootResult> {
  const runner = options.runner ?? denoRunner;
  const cwd = options.cwd;
  const allow = options.allow ?? DEFAULT_ALLOW;
  const fixedToolDir = toolDirFor(options.runnerTemp);
  let toolDir = fixedToolDir;
  let tempDir: string | null = null;
  if (toolDir === null) {
    tempDir = await Deno.makeTempDir({ prefix: "axiom-audit." });
    toolDir = `${tempDir}/axiom-audit`;
  }
  try {
    const buildCode = await runner.inherit(
      "lake",
      ["build", ...(options.targets ?? [])],
      { cwd },
    );
    if (buildCode !== 0) {
      return {
        code: buildCode,
        errors: [`lake build exited with code ${buildCode}`],
        reused: false,
      };
    }
    const bin = `${toolDir}/.lake/build/bin/axiom-audit`;
    const reused = await isReusable(toolDir, bin, runner, cwd);
    if (reused) {
      console.log(
        `axiom-audit ${AXIOM_AUDIT_REF}: reusing the build made earlier in this job (${toolDir})`,
      );
    } else {
      await Deno.remove(toolDir, { recursive: true }).catch(() => {});
      const cloneCode = await runner.inherit(
        "git",
        [
          "clone",
          "--depth",
          "1",
          "--branch",
          AXIOM_AUDIT_REF,
          AXIOM_AUDIT_URL,
          toolDir,
        ],
        { cwd },
      );
      if (cloneCode !== 0) {
        return {
          code: cloneCode,
          errors: [`git clone of axiom-audit exited with code ${cloneCode}`],
          reused: false,
        };
      }
      const head = await runner.capture(
        "git",
        ["-C", toolDir, "rev-parse", "HEAD"],
        { cwd },
      );
      const got = head.stdout.trim();
      if (got !== AXIOM_AUDIT_SHA) {
        const message =
          `::error::axiom-audit ${AXIOM_AUDIT_REF} resolved to ${got}, expected ${AXIOM_AUDIT_SHA}`;
        console.error(message);
        return { code: 1, errors: [message], reused: false };
      }
      const repoDir = cwd ?? ".";
      await Deno.copyFile(
        `${repoDir}/lean-toolchain`,
        `${toolDir}/lean-toolchain`,
      );
      const toolBuildCode = await runner.inherit("lake", ["build"], {
        cwd: toolDir,
      });
      if (toolBuildCode !== 0) {
        return {
          code: toolBuildCode,
          errors: [`axiom-audit tool build exited with code ${toolBuildCode}`],
          reused: false,
        };
      }
    }
    const auditCode = await runner.inherit(
      "lake",
      ["env", bin, "--allow", allow, "--root", options.root],
      { cwd },
    );
    return {
      code: auditCode,
      errors: auditCode !== 0
        ? [`axiom-audit of ${options.root} exited with code ${auditCode}`]
        : [],
      reused,
    };
  } finally {
    if (tempDir !== null) {
      await Deno.remove(tempDir, { recursive: true }).catch(() => {});
    }
  }
}

export interface AuditRootsOptions {
  directory: string;
  prefix?: string;
  allow?: string;
  runnerTemp?: string;
  cwd?: string;
  repoRoot?: string;
  runner?: Runner;
  /** Override for tests: audit one root. Defaults to {@link auditRoot}. */
  audit?: (options: AuditRootOptions) => Promise<AuditRootResult> | AuditRootResult;
  /** Override for tests: list the roots declared under the directory. */
  listRoots?: (directory: string) => Promise<string[]> | string[];
}

export interface AuditRootsResult {
  code: number;
  errors: string[];
  audited: string[];
}

function defaultListRoots(
  repoRoot: string,
  directory: string,
): string[] {
  const result = checkLeanModules(repoRoot, [], directory);
  if (result.code !== 0) {
    throw new Error(
      result.stderr.trim() ||
        `checkLeanModules failed for ${directory} with code ${result.code}`,
    );
  }
  return result.stdout.split("\n").map((line) => line.trim()).filter((line) =>
    line !== ""
  );
}

/**
 * Audit every lean_lib/lean_exe root declared under a directory,
 * optionally restricted to `<prefix>.*` roots. Every root is
 * audited even if an earlier one failed; the exit code is 1 when
 * any audit failed. With a prefix and no matching root, that is
 * itself an error, as in the shell fan-out.
 */
export async function auditRoots(
  options: AuditRootsOptions,
): Promise<AuditRootsResult> {
  const audit = options.audit ?? auditRoot;
  const repoRoot = options.repoRoot ?? options.cwd ?? ".";
  let roots: string[];
  try {
    roots = options.listRoots !== undefined
      ? await options.listRoots(options.directory)
      : await defaultListRoots(repoRoot, options.directory);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    return { code: 1, errors: [message], audited: [] };
  }
  if (options.prefix !== undefined && options.prefix !== "") {
    const prefix = options.prefix;
    const filtered = roots.filter((root) => root.startsWith(`${prefix}.`));
    if (filtered.length === 0) {
      const message =
        `::error::lakefile.lean declares no ${prefix}.* root in ${options.directory}/`;
      console.error(message);
      return { code: 1, errors: [message], audited: [] };
    }
    roots = filtered;
  }
  let status = 0;
  const errors: string[] = [];
  const audited: string[] = [];
  for (const root of roots) {
    console.log(`::group::axiom-audit ${root}`);
    const result = await audit({
      root,
      targets: [`+${root}`],
      allow: options.allow,
      runnerTemp: options.runnerTemp,
      cwd: options.cwd,
      runner: options.runner,
    });
    audited.push(root);
    if (result.code !== 0) {
      console.error(`::error::the axiom audit of ${root} failed`);
      errors.push(...result.errors);
      status = 1;
    }
    console.log("::endgroup::");
  }
  return { code: status, errors, audited };
}

function usage(): string {
  return "usage: axiom_audit.ts audit <root> [lake-target...]\n" +
    "       axiom_audit.ts audit-roots <directory> [module-prefix]";
}

if (import.meta.main) {
  const [mode, ...rest] = Deno.args;
  const runnerTemp = Deno.env.get("RUNNER_TEMP");
  const allow = Deno.env.get("AXIOM_AUDIT_ALLOW");
  let code: number;
  if (mode === "audit") {
    const [root, ...targets] = rest;
    if (root === undefined) {
      console.error(usage());
      Deno.exit(2);
    }
    code = (await auditRoot({ root, targets, allow, runnerTemp })).code;
  } else if (mode === "audit-roots") {
    const [directory, prefix] = rest;
    if (directory === undefined) {
      console.error(usage());
      Deno.exit(2);
    }
    code = (await auditRoots({ directory, prefix, allow, runnerTemp })).code;
  } else {
    console.error(usage());
    Deno.exit(2);
  }
  Deno.exit(code);
}
