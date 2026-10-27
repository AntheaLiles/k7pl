// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Axiom-dependency audit, ported faithfully from
 * scripts/ci/k7pl_semantics_axiom_report.py.
 *
 * The report normalises and enforces the KLean-generated proof
 * project's `#print axioms` evidence against the contract in
 * proofs/axiom-audit-contract.json. An empty dependency set is
 * recorded as [] rather than treated as a missing audit. Missing,
 * conflicting, changed, or forbidden axiom reports are hard
 * failures (AuditError).
 *
 * Claim discipline: this report is a *verification* check, never
 * a proof by itself. The Lean build is the proof; this module
 * only checks that the axiom listing the build produced matches
 * the contract. {@link axiomReportToEvidence} therefore emits
 * only `verification` claims, under the stage id
 * `lean-axiom-audit`, and the result passes *schema* validation
 * (validateEvidenceSchema). It is deliberately NOT a
 * `lean-proof-build` record: that stage requires a `proof` claim
 * in the registry, and a verification-only record must not be
 * presented as one. Registering a `lean-axiom-audit` stage is a
 * later-slice registry decision, not something this port assumes.
 *
 * Port notes (fail-closed divergences from the Python original,
 * all in the direction of rejecting more, never less):
 * - A contract entry that is not an object raises AuditError
 *   here; the Python code would raise AttributeError instead.
 *   Either way the run fails; this port names the failure.
 * - A non-string `role` is reported as "" rather than passed
 *   through verbatim; well-formed contracts always use strings.
 */

import type { Evidence } from "./evidence.ts";

// The \x1B escape is intentional: it is the ANSI introducer itself.
// deno-lint-ignore no-control-regex
export const ANSI_ESCAPE = /\x1B\[[0-?]*[ -/]*[@-~]/g;
const DEPENDS = /'([^']+)' depends on axioms:\s*\[([^\]]*)\]/;
const NO_AXIOMS = /'([^']+)' does not depend on any axioms/;

export const PROJECT_ALLOWED_STANDARD_AXIOMS = new Set([
  "propext",
  "Classical.choice",
  "Quot.sound",
]);
export const PROJECT_REQUIRED_FORBIDDEN_AXIOMS = new Set([
  "sorryAx",
  "Lean.ofReduceBool",
]);

/** The build log does not satisfy the declared axiom-audit contract. */
export class AuditError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "AuditError";
  }
}

/** Strip ANSI escape sequences, exactly as the Python port does. */
export function stripAnsi(text: string): string {
  return text.replace(ANSI_ESCAPE, "");
}

/** One parsed `#print axioms` record from a single log line. */
export interface AxiomRecord {
  name: string;
  kind: "depends" | "none";
  axioms: string[];
}

/**
 * Parse `#print axioms` lines into records. Each line is searched
 * (not anchored at column 0) because Lean prefixes records with
 * `info: <file>:<line>: `. A record is only recognised when the
 * full pattern appears on one line: a bare declaration name
 * elsewhere in the log is not a record.
 */
export function parseAxiomRecords(text: string): AxiomRecord[] {
  const clean = stripAnsi(text);
  const records: AxiomRecord[] = [];
  for (const line of clean.split("\n")) {
    const depends = DEPENDS.exec(line);
    if (depends) {
      const axioms = depends[2]
        .split(",")
        .map((axiom) => axiom.trim())
        .filter((axiom) => axiom !== "")
        .sort();
      records.push({ name: depends[1], kind: "depends", axioms });
      continue;
    }
    const none = NO_AXIOMS.exec(line);
    if (none) {
      records.push({ name: none[1], kind: "none", axioms: [] });
    }
  }
  return records;
}

export interface AxiomContractDeclaration {
  name: string;
  axioms: string[];
  role: string;
}

export interface AxiomDeclarationReport {
  name: string;
  role: string;
  expectedAxioms: string[];
  observedAxioms: string[];
  matchesContract: boolean;
}

export interface AxiomReport {
  schemaVersion: unknown;
  kind: string;
  status: "passed";
  sourceCommit: string;
  workflowRunId: string;
  leanVersion: string;
  contract: string;
  matching: "exact-set";
  forbiddenAxioms: string[];
  allowedStandardAxioms: string[];
  declarationCount: number;
  declarations: AxiomDeclarationReport[];
}

export interface ParseReportOptions {
  sourceCommit?: string;
  workflowRunId?: string;
  leanVersion?: string;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function sortedSet(values: Iterable<string>): string[] {
  return [...values].sort();
}

function setsEqual(a: Set<string>, b: Set<string>): boolean {
  if (a.size !== b.size) return false;
  for (const value of a) if (!b.has(value)) return false;
  return true;
}

/**
 * Parse actual Lean reports and compare every tracked declaration
 * with its contract. Mirrors parse_report() in the Python original,
 * including the order in which failures are reported: per-declaration
 * failures in contract order, then the single missing-reports line.
 */
export function parseReport(
  text: string,
  contract: unknown,
  options: ParseReportOptions = {},
): AxiomReport {
  const clean = stripAnsi(text);
  if (clean.includes("sorryAx")) {
    throw new AuditError(
      "forbidden sorryAx marker found in the Lean build log",
    );
  }

  if (!isRecord(contract)) {
    throw new AuditError("contract must be an object");
  }
  const policyRaw = contract["policy"] === undefined ? {} : contract["policy"];
  if (!isRecord(policyRaw)) {
    throw new AuditError("contract policy must be an object");
  }
  const forbiddenRaw = policyRaw["forbiddenAxioms"];
  const allowedRaw = policyRaw["allowedStandardAxioms"];
  if (
    forbiddenRaw !== undefined &&
    (!Array.isArray(forbiddenRaw) ||
      forbiddenRaw.some((item) => typeof item !== "string"))
  ) {
    throw new AuditError(
      "contract policy.forbiddenAxioms must be a list of names",
    );
  }
  if (
    allowedRaw !== undefined &&
    (!Array.isArray(allowedRaw) ||
      allowedRaw.some((item) => typeof item !== "string"))
  ) {
    throw new AuditError(
      "contract policy.allowedStandardAxioms must be a list of names",
    );
  }
  const forbidden = new Set<string>(
    (forbiddenRaw as string[] | undefined) ?? [],
  );
  const allowed = new Set<string>((allowedRaw as string[] | undefined) ?? []);
  if (policyRaw["matching"] !== "exact-set") {
    throw new AuditError("contract policy.matching must be 'exact-set'");
  }
  if (!setsEqual(allowed, PROJECT_ALLOWED_STANDARD_AXIOMS)) {
    throw new AuditError(
      "contract changes the project allowlist: " +
        `expected ${
          JSON.stringify(sortedSet(PROJECT_ALLOWED_STANDARD_AXIOMS))
        }, ` +
        `observed ${JSON.stringify(sortedSet(allowed))}`,
    );
  }
  const missingForbidden = sortedSet(PROJECT_REQUIRED_FORBIDDEN_AXIOMS).filter(
    (axiom) => !forbidden.has(axiom),
  );
  if (missingForbidden.length > 0) {
    throw new AuditError(
      "contract omits required forbidden axiom markers: " +
        JSON.stringify(missingForbidden),
    );
  }

  const expected = contract["declarations"];
  if (!Array.isArray(expected) || expected.length === 0) {
    throw new AuditError("contract must declare a non-empty declarations list");
  }
  const expectedByName = new Map<string, AxiomContractDeclaration>();
  for (const entry of expected) {
    if (!isRecord(entry)) {
      throw new AuditError("each declaration must be an object");
    }
    const name = entry["name"];
    const axioms = entry["axioms"];
    if (typeof name !== "string" || name === "") {
      throw new AuditError("each declaration needs a non-empty name");
    }
    if (expectedByName.has(name)) {
      throw new AuditError(`duplicate declaration in contract: ${name}`);
    }
    if (
      !Array.isArray(axioms) ||
      axioms.some((axiom) => typeof axiom !== "string")
    ) {
      throw new AuditError(
        `${name}: axioms must be a list of names (empty list means none)`,
      );
    }
    if (new Set(axioms).size !== axioms.length) {
      throw new AuditError(`${name}: duplicate axiom in contract`);
    }
    const axiomSet = new Set<string>(axioms);
    const forbiddenInContract = sortedSet(axiomSet).filter((axiom) =>
      forbidden.has(axiom)
    );
    if (forbiddenInContract.length > 0) {
      throw new AuditError(
        `${name}: contract includes forbidden axiom(s): ` +
          JSON.stringify(forbiddenInContract),
      );
    }
    const unapproved = sortedSet(axiomSet).filter((axiom) =>
      !allowed.has(axiom)
    );
    if (unapproved.length > 0) {
      throw new AuditError(
        `${name}: contract includes unapproved axiom(s): ` +
          JSON.stringify(unapproved),
      );
    }
    expectedByName.set(name, {
      name,
      axioms: [...axioms],
      role: typeof entry["role"] === "string" ? entry["role"] : "",
    });
  }

  const observed = new Map<string, Set<string>>();
  for (const record of parseAxiomRecords(clean)) {
    // parseAxiomRecords already strips ANSI; passing the cleaned
    // text keeps the two passes identical.
    const key = JSON.stringify(record.axioms);
    let bucket = observed.get(record.name);
    if (!bucket) {
      bucket = new Set<string>();
      observed.set(record.name, bucket);
    }
    bucket.add(key);
  }

  const declarations: AxiomDeclarationReport[] = [];
  const missing: string[] = [];
  const failures: string[] = [];
  for (const [name, entry] of expectedByName) {
    const reports = observed.get(name);
    if (!reports || reports.size === 0) {
      missing.push(name);
      continue;
    }
    if (reports.size !== 1) {
      const sortedReports = [...reports].sort().map((key) =>
        JSON.parse(key) as string[]
      );
      failures.push(
        `${name}: conflicting #print axioms reports: ` +
          JSON.stringify(sortedReports),
      );
      continue;
    }
    const actual = JSON.parse([...reports][0]) as string[];
    const declared = [...entry.axioms].sort();
    if (JSON.stringify(actual) !== JSON.stringify(declared)) {
      failures.push(
        `${name}: expected axioms ${JSON.stringify(declared)}, observed ${
          JSON.stringify(actual)
        }`,
      );
    }
    const actualSet = new Set(actual);
    const forbiddenObserved = sortedSet(actualSet).filter((axiom) =>
      forbidden.has(axiom)
    );
    if (forbiddenObserved.length > 0) {
      failures.push(
        `${name}: forbidden axiom(s) observed: ` +
          JSON.stringify(forbiddenObserved),
      );
    }
    const unapprovedObserved = sortedSet(actualSet).filter((axiom) =>
      !allowed.has(axiom)
    );
    if (unapprovedObserved.length > 0) {
      failures.push(
        `${name}: unapproved axiom(s) observed: ` +
          JSON.stringify(unapprovedObserved),
      );
    }
    declarations.push({
      name,
      role: entry.role,
      expectedAxioms: declared,
      observedAxioms: actual,
      matchesContract: JSON.stringify(actual) === JSON.stringify(declared),
    });
  }

  if (missing.length > 0) {
    failures.push("missing #print axioms report(s): " + missing.join(", "));
  }
  if (failures.length > 0) {
    throw new AuditError(failures.join("; "));
  }

  return {
    schemaVersion: contract["schemaVersion"] ?? 1,
    kind: "lean-axiom-dependency-audit",
    status: "passed",
    sourceCommit: options.sourceCommit ? options.sourceCommit : "unknown",
    workflowRunId: options.workflowRunId ? options.workflowRunId : "unknown",
    leanVersion: options.leanVersion ? options.leanVersion : "unknown",
    contract: "proofs/axiom-audit-contract.json",
    matching: "exact-set",
    forbiddenAxioms: sortedSet(forbidden),
    allowedStandardAxioms: sortedSet(allowed),
    declarationCount: declarations.length,
    declarations,
  };
}

/** SHA-256 hex digest (Deno built-in crypto, no dependency). */
export async function sha256Hex(data: Uint8Array | string): Promise<string> {
  const input = typeof data === "string"
    ? new TextEncoder().encode(data)
    : data;
  // Copy into a fresh buffer so the digest input is a plain
  // ArrayBuffer (crypto.subtle's typed view requires one).
  const bytes = new Uint8Array(input.length);
  bytes.set(input);
  const digest = await crypto.subtle.digest("SHA-256", bytes.buffer);
  return [...new Uint8Array(digest)]
    .map((byte) => byte.toString(16).padStart(2, "0"))
    .join("");
}

export interface AxiomEvidenceOptions {
  commit: string;
  run: string;
  tool?: { name: string; version: string; source: string };
  inputs?: Evidence["inputs"];
  outputs?: Evidence["outputs"];
  depends_on?: string[];
  /** Defaults to "lean-axiom-audit"; see the module doc comment. */
  stage?: string;
}

/**
 * Build a schema-conformant evidence record for a passed report.
 * The claim class is always `verification`: this record asserts
 * that the axiom listing matches the contract, and nothing more.
 * It never carries a `proof` claim. Digest/commit/run values are
 * supplied by the caller (the CLI fills inputs with the contract
 * digest); this function does not invent them, so a record built
 * with placeholder values will fail schema validation, as it
 * should.
 */
export function axiomReportToEvidence(
  report: AxiomReport,
  options: AxiomEvidenceOptions,
): Evidence {
  const record: Evidence = {
    stage: options.stage ?? "lean-axiom-audit",
    commit: options.commit,
    run: options.run,
    tool: options.tool ?? {
      name: "axiom_report",
      version: "unknown",
      source: "tools/ci-controller/src/axiom_report.ts",
    },
    inputs: options.inputs ?? [],
    outputs: options.outputs ?? [],
    exit_code: 0,
    claims: [{
      class: "verification",
      property:
        `axiom audit matches contract: ${report.declarationCount} declarations`,
    }],
  };
  if (options.depends_on !== undefined) record.depends_on = options.depends_on;
  return record;
}

function parseCliArgs(argv: string[]): Map<string, string | boolean> {
  const flags = new Map<string, string | boolean>();
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    if (!arg.startsWith("--")) {
      flags.set("__positional__", arg);
      continue;
    }
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
 * CLI parity with the Python script: --log (required), --contract
 * (default proofs/axiom-audit-contract.json), --output (required),
 * --source-commit / --workflow-run-id (defaulting to GITHUB_SHA /
 * GITHUB_RUN_ID, else "unknown"), --lean-version. Returns a process
 * exit code; 1 on audit failure, 2 on usage error. The parent
 * controller (main.ts) is intentionally not wired to this command
 * in this slice; run this file directly.
 */
export async function runAxiomReportCli(argv: string[]): Promise<number> {
  const args = parseCliArgs(argv);
  const logPath = args.get("log");
  const outputPath = args.get("output");
  if (typeof logPath !== "string" || typeof outputPath !== "string") {
    console.error(
      "usage: deno run --allow-read --allow-write --allow-env src/axiom_report.ts --log <log> --output <report.json> [--contract <contract.json>] [--source-commit <sha>] [--workflow-run-id <id>] [--lean-version <version>]",
    );
    return 2;
  }
  const contractPath = typeof args.get("contract") === "string"
    ? String(args.get("contract"))
    : "proofs/axiom-audit-contract.json";
  try {
    const contractBytes = await Deno.readFile(contractPath);
    const contract = JSON.parse(new TextDecoder().decode(contractBytes));
    const log = await Deno.readTextFile(logPath);
    const report = parseReport(log, contract, {
      sourceCommit: typeof args.get("source-commit") === "string"
        ? String(args.get("source-commit"))
        : (Deno.env.get("GITHUB_SHA") ?? "unknown"),
      workflowRunId: typeof args.get("workflow-run-id") === "string"
        ? String(args.get("workflow-run-id"))
        : (Deno.env.get("GITHUB_RUN_ID") ?? "unknown"),
      leanVersion: typeof args.get("lean-version") === "string"
        ? String(args.get("lean-version"))
        : "",
    });
    const reportWithDigest = {
      ...report,
      contractSha256: await sha256Hex(contractBytes),
    };
    const outputDir = outputPath.includes("/")
      ? outputPath.slice(0, outputPath.lastIndexOf("/"))
      : ".";
    await Deno.mkdir(outputDir, { recursive: true });
    await Deno.writeTextFile(
      outputPath,
      JSON.stringify(reportWithDigest, null, 2) + "\n",
    );
    for (const declaration of report.declarations) {
      const axioms = declaration.observedAxioms.join(", ") ||
        "∅ (aucun axiome)";
      console.log(`AXIOM-AUDIT ${declaration.name} := [${axioms}]`);
    }
    console.log(
      `axiom dependency audit passed: ${report.declarationCount} declarations; report=${outputPath}`,
    );
    return 0;
  } catch (error) {
    console.error(
      `axiom dependency audit failed: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
    return 1;
  }
}

if (import.meta.main) {
  Deno.exit(await runAxiomReportCli(Deno.args));
}
