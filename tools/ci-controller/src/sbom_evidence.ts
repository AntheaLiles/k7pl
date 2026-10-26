// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Check the Lean SBOM audit report, replay its negative CLI cases
 * and write the CI evidence.
 *
 * Port of scripts/ci/sbom_evidence.py (cutover C5). Run by the
 * `impl` job of `.github/workflows/verify.yaml`, after
 * `lake_manifest_to_spdx.py` has generated the scoped SPDX
 * inventory and `lake exe sbomAudit` has audited it against
 * `lake-manifest.json`. The script:
 *
 * 1. requires the audit report to be a PASS of `k7pl-sbom-audit`
 *    with no diagnostic, on the expected source artifacts;
 * 2. runs `lake exe sbomAudit` on four negative inputs and
 *    requires, for each, the expected exit status, report status
 *    and diagnostic rule(s):
 *
 *    - a malformed manifest (`{`): ERROR/2, `INPUT-JSON-MANIFEST`;
 *    - the generated SBOM with its first package revision altered:
 *      FAIL/1, `SBOM-INVENTORY-MISMATCH`;
 *    - an empty manifest and an empty SPDX inventory: FAIL/1,
 *      `SBOM-EMPTY-INVENTORY`;
 *    - a package named U+00A0 (a Unicode blank) in both files:
 *      FAIL/1, `SBOM-MANIFEST-EMPTY-IDENTITY` and
 *      `SBOM-PACKAGE-EMPTY-IDENTITY`;
 *
 * 3. for each `--extra-inventory MANIFEST SBOM` (the separate SPDX
 *    document of another Lake workspace of the repository, such as
 *    the Paperproof extractor's), checks that the document lists
 *    exactly the manifest's (name, url, rev) with one DESCRIBES
 *    relationship each. `sbomAudit` does not cover these
 *    documents: its contract requires the manifest name `k7pl`;
 * 4. writes the evidence JSON (`k7pl.ci-evidence/v1`) and a
 *    summary for the job.
 *
 * It runs only inside GitHub Actions: `GITHUB_RUN_ID`,
 * `GITHUB_RUN_ATTEMPT`, `GITHUB_SHA`, `GITHUB_WORKFLOW` and
 * `GITHUB_STEP_SUMMARY` are required; `GITHUB_EVENT_PATH` is
 * optional.
 *
 * The evidence records what this job checked. It is not a
 * provenance attestation and it does not claim that the inventory
 * is complete (see `lake_manifest_to_spdx.py`).
 *
 * Exit status: 0 when every check passes, 1 otherwise.
 *
 * Porting notes — where Deno and Python differ, the difference is
 * recorded here rather than silently absorbed:
 *
 * - The pipeline is async (Deno's subprocess and WebCrypto
 *   hashing are async); the observable behaviour is unchanged.
 *   `sha256File` is reused from `file_digest.ts`: it reads the
 *   whole file instead of 1 MiB chunks, which yields the
 *   identical digest.
 * - `pythonJson` / `pythonJsonSorted` reproduce Python's
 *   `json.dumps` (separators `, ` / `: `, `ensure_ascii`, and
 *   `sort_keys` + indent 2 for the evidence file), so the files
 *   this module writes are byte-identical to the Python
 *   helper's for the same inputs.
 * - `pythonRepr` reproduces Python's `repr` for the values that
 *   appear in error messages (strings, numbers, booleans, None,
 *   lists, dicts).
 * - `parsePythonInt` accepts Python's `int()` syntax except
 *   underscore literals (`1_0`), which it refuses, and it loses
 *   precision beyond 2^53, which Python does not. Run IDs are
 *   small; neither edge is expected.
 * - JSON parse failures are raised with the name `JSONDecodeError`
 *   but carry the JavaScript parser's message text, not Python's
 *   `Expecting value: line 1 column 1 (char 0)`. Callers match on
 *   the surrounding text, never on the parser's wording.
 * - `pullRequestHead`: a non-object event payload or head raises
 *   `TypeError` (caught by `main`, exit 1); Python raises an
 *   uncaught `AttributeError` (traceback, also exit 1). A
 *   non-string `sha` is normalized to null instead of being
 *   embedded.
 * - `checkInventory` checks that every name, url and rev is a
 *   string before sorting; Python sorts first and can raise
 *   `TypeError` on mixed types. Both paths fail the run; only
 *   the error text differs in that edge case.
 * - File-system errors carry Deno's error names (`NotFound`,
 *   ...) rather than Python's `OSError` subclass names; the
 *   `Name: message` format of the error line is preserved.
 */

import { sha256File } from "./file_digest.ts";
import {
  clean,
  isRootWorkspace,
  manifestLabel,
  workspaceFor,
} from "./manifest.ts";
import {
  TOOL_NAME as SBOM_TOOL_NAME,
  TOOL_VERSION as SBOM_TOOL_VERSION,
} from "./lake_to_spdx.ts";

export const REPORT_SCHEMA = "k7pl.compliance-report/v1";
export const AUDIT_TOOL = "k7pl-sbom-audit";
export const EVIDENCE_SCHEMA = "k7pl.ci-evidence/v1";
export const MANIFEST_ARTIFACT = "lake-manifest.json";
export const SBOM_ARTIFACT = "k7pl-lake.spdx.json";
// Files hashed into the evidence, besides the manifest and the
// SBOM given on the command line. The order of `inputs` is part
// of the evidence format: append, do not reorder.
export const HASHED_SOURCES = [
  "lakefile.lean",
  "lean-toolchain",
  "scripts/ci/lake_manifest_to_spdx.py",
  "tools/Compliance/SbomAudit.lean",
  "tools/Compliance/SbomAuditMain.lean",
] as const;

// The repository root, as Python's `ROOT` (the parent of
// `scripts/`), derived from this file's location instead.
const DEFAULT_ROOT = (() => {
  const path = new URL("../../../", import.meta.url).pathname;
  return path.length > 1 && path.endsWith("/") ? path.slice(0, -1) : path;
})();

/** A check failed: the evidence must not be written. */
export class EvidenceError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "EvidenceError";
  }
}

/** (manifest path, SBOM path) -> the finished `lake exe sbomAudit` process. */
export interface AuditResult {
  code: number;
  stdout: string;
  stderr: string;
}

export type AuditRunner = (
  manifest: string,
  sbom: string,
) => Promise<AuditResult>;

export function requireEvidence(
  condition: boolean,
  message: string,
): void {
  if (!condition) throw new EvidenceError(message);
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null &&
    !Array.isArray(value);
}

function joinPath(...parts: string[]): string {
  const cleaned = parts.map((part, index) => {
    let partOut = part;
    if (index > 0) partOut = partOut.replace(/^\/+/, "");
    if (index < parts.length - 1) partOut = partOut.replace(/\/+$/, "");
    return partOut;
  }).filter((part, index) => part !== "" || index === 0);
  return cleaned.join("/");
}

function baseName(path: string): string {
  const slash = path.lastIndexOf("/");
  return slash === -1 ? path : path.slice(slash + 1);
}

/** String comparison by Unicode code point, as Python sorts strings. */
export function compareCodePoints(a: string, b: string): number {
  const aPoints = [...a];
  const bPoints = [...b];
  const shared = Math.min(aPoints.length, bPoints.length);
  for (let i = 0; i < shared; i++) {
    const diff = aPoints[i].codePointAt(0)! - bPoints[i].codePointAt(0)!;
    if (diff !== 0) return diff;
  }
  return aPoints.length - bPoints.length;
}

function escapePythonString(text: string, singleQuoted: boolean): string {
  let out = "";
  for (const ch of text) {
    const cp = ch.codePointAt(0)!;
    if (ch === "\\") out += "\\\\";
    else if (singleQuoted && ch === "'") out += "\\'";
    else if (!singleQuoted && ch === '"') out += '\\"';
    else if (ch === "\n") out += "\\n";
    else if (ch === "\r") out += "\\r";
    else if (ch === "\t") out += "\\t";
    else if (cp < 0x20 || cp === 0x7f) {
      out += "\\x" + cp.toString(16).padStart(2, "0");
    } else if (
      ch !== " " && /[\p{C}\p{Z}]/u.test(ch)
    ) {
      // Python's repr escapes every non-printable character:
      // printable means not a Unicode Other (C*) or Separator
      // (Z*) character, except the ASCII space.
      if (cp <= 0xff) out += "\\x" + cp.toString(16).padStart(2, "0");
      else if (cp <= 0xffff) {
        out += "\\u" + cp.toString(16).padStart(4, "0");
      } else out += "\\U" + cp.toString(16).padStart(8, "0");
    } else out += ch;
  }
  return out;
}

/** Python's `repr`, for the values that appear in error messages. */
export function pythonRepr(value: unknown): string {
  if (value === null || value === undefined) return "None";
  if (typeof value === "boolean") return value ? "True" : "False";
  if (typeof value === "number") {
    if (Number.isInteger(value)) return String(value);
    return String(value);
  }
  if (typeof value === "string") {
    return "'" + escapePythonString(value, true) + "'";
  }
  if (Array.isArray(value)) {
    return "[" + value.map(pythonRepr).join(", ") + "]";
  }
  if (isRecord(value)) {
    return "{" +
      Object.entries(value).map(([key, item]) =>
        `${pythonRepr(key)}: ${pythonRepr(item)}`
      ).join(", ") + "}";
  }
  return String(value);
}

function escapeJsonString(text: string): string {
  // Python's ensure_ascii encoder: backslash, quote, every
  // control character and every character outside ASCII.
  let out = '"';
  for (const ch of text) {
    const cp = ch.codePointAt(0)!;
    if (ch === '"') out += '\\"';
    else if (ch === "\\") out += "\\\\";
    else if (ch === "\n") out += "\\n";
    else if (ch === "\r") out += "\\r";
    else if (ch === "\t") out += "\\t";
    else if (ch === "\b") out += "\\b";
    else if (ch === "\f") out += "\\f";
    else if (cp < 0x20 || cp > 0x7e) {
      if (cp <= 0xffff) {
        out += "\\u" + cp.toString(16).padStart(4, "0");
      } else {
        const offset = cp - 0x10000;
        const high = 0xd800 + (offset >> 10);
        const low = 0xdc00 + (offset & 0x3ff);
        out += "\\u" + high.toString(16).padStart(4, "0") +
          "\\u" + low.toString(16).padStart(4, "0");
      }
    } else out += ch;
  }
  return out + '"';
}

/** Python's `json.dumps` with default separators and `ensure_ascii`. */
export function pythonJson(value: unknown): string {
  if (value === null || value === undefined) return "null";
  if (typeof value === "boolean") return value ? "true" : "false";
  if (typeof value === "number") {
    if (Number.isInteger(value)) return String(value);
    return String(value);
  }
  if (typeof value === "string") return escapeJsonString(value);
  if (Array.isArray(value)) {
    return "[" + value.map((item) =>
      item === undefined ? "null" : pythonJson(item)
    ).join(", ") + "]";
  }
  if (isRecord(value)) {
    return "{" + Object.entries(value).filter(([, item]) =>
      item !== undefined
    ).map(([key, item]) =>
      `${escapeJsonString(key)}: ${pythonJson(item)}`
    ).join(", ") + "}";
  }
  throw new TypeError(
    `Object of type ${typeof value} is not JSON serializable`,
  );
}

function prettyJsonSorted(value: unknown, level: number): string {
  const indent = "  ".repeat(level);
  const childIndent = "  ".repeat(level + 1);
  if (Array.isArray(value)) {
    if (value.length === 0) return "[]";
    return "[\n" + value.map((item) =>
      childIndent +
      prettyJsonSorted(item === undefined ? null : item, level + 1)
    ).join(",\n") + "\n" + indent + "]";
  }
  if (isRecord(value)) {
    const entries = Object.entries(value).filter(([, item]) =>
      item !== undefined
    ).sort(([a], [b]) => compareCodePoints(a, b));
    if (entries.length === 0) return "{}";
    return "{\n" + entries.map(([key, item]) =>
      childIndent + escapeJsonString(key) + ": " +
      prettyJsonSorted(item, level + 1)
    ).join(",\n") + "\n" + indent + "}";
  }
  return pythonJson(value);
}

/** Python's `json.dumps(..., indent=2, sort_keys=True)`. */
export function pythonJsonSorted(value: unknown): string {
  return prettyJsonSorted(value, 0);
}

/** `json.loads`, with the error renamed to Python's `JSONDecodeError`. */
export function parseJson(text: string): unknown {
  try {
    return JSON.parse(text);
  } catch (error) {
    const renamed = new Error(
      error instanceof Error ? error.message : String(error),
    );
    renamed.name = "JSONDecodeError";
    throw renamed;
  }
}

function parsePythonInt(text: string): number {
  const trimmed = text.trim();
  if (!/^[+-]?\d+$/.test(trimmed)) {
    const error = new Error(
      `invalid literal for int() with base 10: ${pythonRepr(text)}`,
    );
    error.name = "ValueError";
    throw error;
  }
  return Number.parseInt(trimmed, 10);
}

/** Run the Lean audit executable; its exit status is part of what is checked. */
export async function lakeSbomAudit(
  manifest: string,
  sbom: string,
): Promise<AuditResult> {
  const command = new Deno.Command("lake", {
    args: ["exe", "sbomAudit", manifest, sbom],
    stdout: "piped",
    stderr: "piped",
  });
  const output = await command.output();
  const decoder = new TextDecoder();
  return {
    code: output.code,
    stdout: decoder.decode(output.stdout),
    stderr: decoder.decode(output.stderr),
  };
}

/** The audit report of the valid inputs: a PASS with no diagnostic, on the expected files. */
export function checkReport(
  report: unknown,
  sbomName: string = SBOM_ARTIFACT,
): Record<string, unknown> {
  requireEvidence(isRecord(report), "the audit report is not a JSON object");
  const checked = report as Record<string, unknown>;
  requireEvidence(
    checked["schemaVersion"] === REPORT_SCHEMA,
    `unexpected report schema: ${pythonRepr(checked["schemaVersion"])}`,
  );
  requireEvidence(
    checked["tool"] === AUDIT_TOOL,
    `unexpected audit tool: ${pythonRepr(checked["tool"])}`,
  );
  requireEvidence(
    typeof checked["toolVersion"] === "string" &&
      checked["toolVersion"] !== "",
    `the report has no tool version: ${pythonRepr(checked["toolVersion"])}`,
  );
  requireEvidence(
    checked["status"] === "PASS",
    `audit status is ${pythonRepr(checked["status"])}, not PASS`,
  );
  requireEvidence(
    Array.isArray(checked["diagnostics"]) &&
      checked["diagnostics"].length === 0,
    `the audit reported diagnostics: ${pythonRepr(checked["diagnostics"])}`,
  );
  const sources = checked["sourceArtifacts"];
  requireEvidence(
    Array.isArray(sources) && sources.length >= 2 &&
      typeof sources[0] === "string" && typeof sources[1] === "string",
    `unexpected source artifacts: ${pythonRepr(sources)}`,
  );
  const sourceList = sources as string[];
  requireEvidence(
    sourceList[0] === MANIFEST_ARTIFACT,
    `the audit read ${pythonRepr(sourceList[0])}, not ${MANIFEST_ARTIFACT}`,
  );
  requireEvidence(
    sourceList[1].endsWith("/" + sbomName),
    `the audit read ${
      pythonRepr(sourceList[1])
    }, not the generated ${sbomName}`,
  );
  return checked;
}

/** One negative case: the expected exit status, report status and every expected rule. */
export function expectAuditFailure(
  result: AuditResult,
  caseName: string,
  exitCode: number,
  status: string,
  rules: readonly string[],
): Record<string, unknown> {
  requireEvidence(
    result.code === exitCode,
    `${caseName}: exit status ${result.code}, expected ${exitCode} ` +
      `(stdout: ${pythonRepr(result.stdout)}, stderr: ${
        pythonRepr(result.stderr)
      })`,
  );
  let parsed: unknown;
  try {
    parsed = JSON.parse(result.stdout);
  } catch (error) {
    throw new EvidenceError(
      `${caseName}: the audit did not print a JSON report: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  }
  requireEvidence(
    isRecord(parsed) && parsed["status"] === status,
    `${caseName}: report status is not ${status}: ${pythonRepr(parsed)}`,
  );
  const diagnostics = (parsed as Record<string, unknown>)["diagnostics"];
  requireEvidence(
    Array.isArray(diagnostics) &&
      diagnostics.every((item) =>
        isRecord(item) && typeof item["ruleId"] === "string"
      ),
    `${caseName}: malformed diagnostics: ${pythonRepr(parsed)}`,
  );
  const found = new Set(
    (diagnostics as Record<string, unknown>[]).map(
      (item) => item["ruleId"] as string,
    ),
  );
  const missing = rules.filter((rule) => !found.has(rule));
  requireEvidence(
    missing.length === 0,
    `${caseName}: no ${missing.join(", ")} diagnostic: ${pythonRepr(parsed)}`,
  );
  return {
    case: caseName,
    exitCode: result.code,
    status: (parsed as Record<string, unknown>)["status"],
  };
}

/** The SBOM with the first character of its first package revision changed (f <-> e). */
export function mutateFirstRevision(
  sbom: unknown,
): Record<string, unknown> {
  const mutated = JSON.parse(JSON.stringify(sbom)) as Record<string, unknown>;
  const packages = mutated["packages"];
  if (!Array.isArray(packages) || packages.length === 0) {
    throw new TypeError("list index out of range");
  }
  const first = packages[0];
  if (
    !isRecord(first) || typeof first["versionInfo"] !== "string" ||
    first["versionInfo"] === ""
  ) {
    throw new TypeError("string index out of range");
  }
  const original = first["versionInfo"] as string;
  const replacement = original[0] === "f" ? "e" : "f";
  first["versionInfo"] = replacement + original.slice(1);
  return mutated;
}

// An empty pair is structurally parseable but not a valid K7PL dependency inventory.
export const EMPTY_MANIFEST_TEXT = '{"name":"k7pl","packages":[]}';
export const EMPTY_SBOM: Record<string, unknown> = {
  spdxVersion: "SPDX-2.3",
  SPDXID: "SPDXRef-DOCUMENT",
  packages: [],
  relationships: [],
};

// The Lean model and CLI must reject blank package names using the
// same whitespace set as the Python preflight wrapper (including
// Unicode separators such as U+00A0).
export const BLANK_NAME = "\u00a0";
export const BLANK_REVISION = "a".repeat(40);
export const BLANK_URL = "https://github.com/example/alpha";
export const BLANK_MANIFEST: Record<string, unknown> = {
  name: "k7pl",
  packages: [{ name: BLANK_NAME, url: BLANK_URL, rev: BLANK_REVISION }],
};
export const BLANK_SBOM: Record<string, unknown> = {
  spdxVersion: "SPDX-2.3",
  SPDXID: "SPDXRef-DOCUMENT",
  packages: [{
    name: BLANK_NAME,
    SPDXID: "SPDXRef-Package-alpha",
    versionInfo: BLANK_REVISION,
    downloadLocation: BLANK_URL,
    licenseDeclared: "NOASSERTION",
    licenseConcluded: "NOASSERTION",
    copyrightText: "NOASSERTION",
  }],
  relationships: [{
    spdxElementId: "SPDXRef-DOCUMENT",
    relationshipType: "DESCRIBES",
    relatedSpdxElement: "SPDXRef-Package-alpha",
  }],
};

/** Exercise the executable's exit-code/report contract end to end on four bad inputs. */
export async function runNegativeCases(
  manifestPath: string,
  sbomPath: string,
  scratchDir: string,
  runAudit: AuditRunner = lakeSbomAudit,
): Promise<Record<string, unknown>[]> {
  const cases: Record<string, unknown>[] = [];
  const malformedManifest = joinPath(scratchDir, "malformed-manifest.json");
  Deno.writeTextFileSync(malformedManifest, "{");
  cases.push(
    await runAudit(malformedManifest, sbomPath).then((result) =>
      expectAuditFailure(
        result,
        "malformed manifest JSON",
        2,
        "ERROR",
        ["INPUT-JSON-MANIFEST"],
      )
    ),
  );

  const sbom = parseJson(Deno.readTextFileSync(sbomPath));
  const mismatchPath = joinPath(scratchDir, "mismatched.spdx.json");
  Deno.writeTextFileSync(mismatchPath, pythonJson(mutateFirstRevision(sbom)));
  cases.push(
    await runAudit(manifestPath, mismatchPath).then((result) =>
      expectAuditFailure(
        result,
        "mutated package revision",
        1,
        "FAIL",
        ["SBOM-INVENTORY-MISMATCH"],
      )
    ),
  );

  const emptyManifest = joinPath(scratchDir, "empty-manifest.json");
  Deno.writeTextFileSync(emptyManifest, EMPTY_MANIFEST_TEXT);
  const emptySbom = joinPath(scratchDir, "empty-inventory.spdx.json");
  Deno.writeTextFileSync(emptySbom, pythonJson(EMPTY_SBOM));
  cases.push(
    await runAudit(emptyManifest, emptySbom).then((result) =>
      expectAuditFailure(
        result,
        "empty manifest and SPDX inventory",
        1,
        "FAIL",
        ["SBOM-EMPTY-INVENTORY"],
      )
    ),
  );

  const blankManifest = joinPath(scratchDir, "blank-name-manifest.json");
  Deno.writeTextFileSync(blankManifest, pythonJson(BLANK_MANIFEST));
  const blankSbom = joinPath(scratchDir, "blank-name.spdx.json");
  Deno.writeTextFileSync(blankSbom, pythonJson(BLANK_SBOM));
  cases.push(
    await runAudit(blankManifest, blankSbom).then((result) =>
      expectAuditFailure(
        result,
        "Unicode blank package name (U+00A0)",
        1,
        "FAIL",
        [
          "SBOM-MANIFEST-EMPTY-IDENTITY",
          "SBOM-PACKAGE-EMPTY-IDENTITY",
        ],
      )
    ),
  );
  return cases;
}

export function pullRequestHead(
  env: Record<string, string | undefined>,
): string | null {
  const eventPath = env["GITHUB_EVENT_PATH"];
  if (!eventPath) return null;
  const event = parseJson(Deno.readTextFileSync(eventPath));
  if (!isRecord(event)) {
    throw new TypeError("event payload is not a JSON object");
  }
  const pullRequest = event["pull_request"];
  if (pullRequest === undefined || pullRequest === null) return null;
  if (!isRecord(pullRequest)) {
    throw new TypeError("pull_request is not a JSON object");
  }
  const head = pullRequest["head"];
  if (head === undefined) return null;
  if (!isRecord(head)) {
    throw new TypeError("head is not a JSON object");
  }
  const sha = head["sha"];
  return typeof sha === "string" ? sha : null;
}

export function requiredEnv(
  env: Record<string, string | undefined>,
  name: string,
): string {
  const value = env[name];
  if (!value) {
    throw new EvidenceError(
      `${name} is not set: this script runs inside GitHub Actions`,
    );
  }
  return value;
}

export async function buildEvidence(
  report: Record<string, unknown>,
  negativeCases: Record<string, unknown>[],
  manifestPath: string,
  sbomPath: string,
  root: string,
  env: Record<string, string | undefined>,
): Promise<Record<string, unknown>> {
  const inputs: Record<string, unknown>[] = [
    { artifact: MANIFEST_ARTIFACT, sha256: await sha256File(manifestPath) },
  ];
  for (const name of HASHED_SOURCES) {
    inputs.push({
      artifact: name,
      sha256: await sha256File(joinPath(root, name)),
    });
  }
  inputs.push({
    artifact: SBOM_ARTIFACT,
    sha256: await sha256File(sbomPath),
  });
  let runId: number;
  let runAttempt: number;
  try {
    runId = parsePythonInt(requiredEnv(env, "GITHUB_RUN_ID"));
    runAttempt = parsePythonInt(requiredEnv(env, "GITHUB_RUN_ATTEMPT"));
  } catch (error) {
    if (error instanceof EvidenceError) throw error;
    throw new EvidenceError(
      `GITHUB_RUN_ID or GITHUB_RUN_ATTEMPT is not an integer: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  }
  return {
    schemaVersion: EVIDENCE_SCHEMA,
    workflow: {
      // The calling workflow (CI, Full Verification, Release):
      // verify.yaml is reusable.
      name: requiredEnv(env, "GITHUB_WORKFLOW"),
      runId,
      runAttempt,
      checkedOutSha: requiredEnv(env, "GITHUB_SHA"),
      pullRequestHeadSha: pullRequestHead(env),
    },
    toolchain: {
      lean: Deno.readTextFileSync(joinPath(root, "lean-toolchain")).trim(),
      sbomGenerator: `${SBOM_TOOL_NAME}@${SBOM_TOOL_VERSION}`,
      leanAudit: `${report["tool"]}@${report["toolVersion"]}`,
    },
    inputs,
    audit: report,
    negativeCases,
  };
}

/** The hash recorded for one input, looked up by name rather than by position. */
export function inputSha256(
  evidence: Record<string, unknown>,
  artifact: string,
): string {
  const inputs = evidence["inputs"] as Record<string, unknown>[];
  const matches = inputs.filter((item) => item["artifact"] === artifact)
    .map((item) => item["sha256"] as string);
  requireEvidence(
    matches.length === 1,
    `expected one input named ${artifact}, found ${matches.length}`,
  );
  return matches[0];
}

export function summaryLines(
  evidence: Record<string, unknown>,
  componentCount: number,
): string[] {
  const negativeCases = evidence["negativeCases"] as Record<string, unknown>[];
  const cases = negativeCases.map((item) =>
    `${item["case"]} → ${item["status"]}/${item["exitCode"]}`
  ).join("; ");
  const audit = evidence["audit"] as Record<string, unknown>;
  const toolchain = evidence["toolchain"] as Record<string, unknown>;
  return [
    "### Scoped SPDX consistency audit",
    `- Valid input: ${
      audit["status"]
    }; ${componentCount} manifest components checked.`,
    `- Negative integration cases: ${cases}.`,
    `- Lean toolchain: \`${toolchain["lean"]}\``,
    `- Manifest SHA-256: \`${inputSha256(evidence, MANIFEST_ARTIFACT)}\``,
    `- Generated SPDX SHA-256: \`${inputSha256(evidence, SBOM_ARTIFACT)}\``,
  ];
}

export function manifestComponentCount(manifestPath: string): number {
  const manifest = parseJson(Deno.readTextFileSync(manifestPath));
  const packages = isRecord(manifest) ? manifest["packages"] : null;
  requireEvidence(
    Array.isArray(packages) && packages.length > 0,
    `${manifestPath} has no package list`,
  );
  return (packages as unknown[]).length;
}

function compareTuples(
  a: unknown[],
  b: unknown[],
): number {
  const shared = Math.min(a.length, b.length);
  for (let i = 0; i < shared; i++) {
    const diff = compareCodePoints(String(a[i]), String(b[i]));
    if (diff !== 0) return diff;
  }
  return a.length - b.length;
}

/** Python cross-check of a document that sbomAudit does not audit; returns its package count.
 *
 * The SPDX packages must be exactly the manifest's (name, url, rev),
 * without duplicates, and each must be the target of one DESCRIBES
 * relationship from the document, and nothing else.
 */
export function checkInventory(
  manifest: unknown,
  sbom: unknown,
  label: string,
): number {
  requireEvidence(
    isRecord(manifest) && Array.isArray(manifest["packages"]) &&
      manifest["packages"].length > 0,
    `${label}: the manifest has no package list`,
  );
  requireEvidence(
    isRecord(sbom) && sbom["spdxVersion"] === "SPDX-2.3" &&
      sbom["SPDXID"] === "SPDXRef-DOCUMENT",
    `${label}: not an SPDX-2.3 document`,
  );
  const packages = (sbom as Record<string, unknown>)["packages"];
  const relationships = (sbom as Record<string, unknown>)["relationships"];
  requireEvidence(
    Array.isArray(packages) && Array.isArray(relationships),
    `${label}: no package or relationship list`,
  );
  const manifestPackages =
    (manifest as Record<string, unknown>)["packages"] as unknown[];
  const packageList = packages as unknown[];
  const relationshipList = relationships as unknown[];
  requireEvidence(
    [...manifestPackages, ...packageList, ...relationshipList].every((item) =>
      isRecord(item)
    ),
    `${label}: an entry is not an object`,
  );
  const expected = (manifestPackages as Record<string, unknown>[]).map(
    (item) => [item["name"], item["url"], item["rev"]],
  );
  const found = (packageList as Record<string, unknown>[]).map((item) => [
    item["name"],
    item["downloadLocation"],
    item["versionInfo"],
  ]);
  requireEvidence(
    [...expected, ...found].flat().every((item) => typeof item === "string"),
    `${label}: a name, url or rev is missing`,
  );
  requireEvidence(
    new Set(expected.map((item) => JSON.stringify(item))).size ===
      expected.length,
    `${label}: the manifest lists a package twice`,
  );
  const sortedExpected = [...expected].sort(compareTuples);
  const sortedFound = [...found].sort(compareTuples);
  requireEvidence(
    JSON.stringify(sortedFound) === JSON.stringify(sortedExpected),
    `${label}: the SPDX packages differ from the manifest's (name, url, rev)`,
  );
  const ids = (packages as Record<string, unknown>[]).map((item) =>
    item["SPDXID"]
  );
  const sortedIds = [...ids].sort((a, b) =>
    compareCodePoints(String(a), String(b))
  );
  requireEvidence(
    new Set(ids).size === ids.length,
    `${label}: duplicate SPDXID`,
  );
  const described = (relationships as Record<string, unknown>[]).map(
    (item) => [
      item["spdxElementId"],
      item["relationshipType"],
      item["relatedSpdxElement"],
    ],
  ).sort(compareTuples);
  const expectedDescribed = sortedIds.map((id) => [
    "SPDXRef-DOCUMENT",
    "DESCRIBES",
    id,
  ]);
  requireEvidence(
    JSON.stringify(described) === JSON.stringify(expectedDescribed),
    `${label}: the relationships are not exactly one DESCRIBES per package`,
  );
  return expected.length;
}

/** Evidence for the separate SPDX documents of the repository's other Lake workspaces. */
export async function extraInventories(
  pairs: [string, string][],
  root: string,
  sbomNames: Set<string>,
): Promise<Record<string, unknown>[]> {
  const results: Record<string, unknown>[] = [];
  for (const [manifestPath, sbomPath] of pairs) {
    const workspace = workspaceFor(root, manifestPath);
    requireEvidence(
      !isRootWorkspace(workspace),
      `${manifestPath}: --extra-inventory is for another Lake workspace of the repository, not the root one`,
    );
    const sbomName = baseName(sbomPath);
    requireEvidence(
      !sbomNames.has(sbomName),
      `${sbomName}: two documents with the same name`,
    );
    sbomNames.add(sbomName);
    const manifest = parseJson(Deno.readTextFileSync(manifestPath));
    const sbom = parseJson(Deno.readTextFileSync(sbomPath));
    const components = checkInventory(manifest, sbom, workspace.directory);
    const sources: Record<string, unknown>[] = [];
    for (const name of ["lakefile.lean", "lean-toolchain"]) {
      sources.push({
        artifact: `${workspace.directory}/${name}`,
        sha256: await sha256File(joinPath(root, workspace.directory, name)),
      });
    }
    results.push({
      workspace: workspace.directory,
      inputs: [
        {
          artifact: manifestLabel(workspace),
          sha256: await sha256File(manifestPath),
        },
        ...sources,
        { artifact: sbomName, sha256: await sha256File(sbomPath) },
      ],
      components,
      checkedBy:
        "scripts/ci/sbom_evidence.py: the SPDX packages are exactly the manifest's " +
        "(name, url, rev), each with one DESCRIBES relationship",
      auditedBySbomAudit: false,
    });
  }
  return results;
}

export interface SbomEvidenceArgs {
  report: string;
  manifest: string;
  sbom: string;
  output: string;
  root: string;
  scratchDir: string | null;
  extraInventory: [string, string][];
}

export async function produce(
  args: SbomEvidenceArgs,
  env: Record<string, string | undefined>,
  runAudit: AuditRunner,
): Promise<Record<string, unknown>> {
  const scratch = args.scratchDir ?? env["RUNNER_TEMP"];
  if (!scratch) {
    throw new EvidenceError(
      "RUNNER_TEMP is not set and --scratch-dir was not given",
    );
  }
  const summaryPath = requiredEnv(env, "GITHUB_STEP_SUMMARY");
  const report = checkReport(parseJson(Deno.readTextFileSync(args.report)));
  const negativeCases = await runNegativeCases(
    args.manifest,
    args.sbom,
    scratch,
    runAudit,
  );
  const evidence = await buildEvidence(
    report,
    negativeCases,
    args.manifest,
    args.sbom,
    args.root,
    env,
  );
  if (args.extraInventory.length > 0) {
    evidence["additionalInventories"] = await extraInventories(
      args.extraInventory,
      args.root,
      new Set([baseName(args.sbom)]),
    );
  }
  Deno.writeTextFileSync(
    args.output,
    pythonJsonSorted(evidence) + "\n",
  );
  const lines = summaryLines(
    evidence,
    manifestComponentCount(args.manifest),
  );
  const additional = evidence["additionalInventories"] as
    | Record<string, unknown>[]
    | undefined;
  for (const inventory of additional ?? []) {
    const inputs = inventory["inputs"] as Record<string, unknown>[];
    lines.push(
      `- Separate inventory of \`${inventory["workspace"]}\`: ${
        inventory["components"]
      } components, ` +
        `SPDX SHA-256 \`${
          inputs[inputs.length - 1]["sha256"]
        }\`; cross-checked against its manifest by ` +
        "sbom_evidence.py, not audited by sbomAudit (its contract requires the manifest name k7pl).",
    );
  }
  Deno.writeTextFileSync(summaryPath, lines.join("\n") + "\n", {
    append: true,
  });
  return evidence;
}

const USAGE =
  "usage: sbom_evidence.ts --report REPORT --manifest MANIFEST --sbom SBOM --output OUTPUT " +
  "[--root ROOT] [--scratch-dir SCRATCH_DIR] [--extra-inventory MANIFEST SBOM]";

function parseArgs(argv: string[]): SbomEvidenceArgs | null {
  const values = new Map<string, string>();
  const extraInventory: [string, string][] = [];
  let i = 0;
  const next = (): string | null => {
    i++;
    return i < argv.length ? argv[i] : null;
  };
  while (i < argv.length) {
    const arg = argv[i];
    const eq = arg.indexOf("=");
    const flag = eq === -1 ? arg : arg.slice(0, eq);
    const inline = eq === -1 ? null : arg.slice(eq + 1);
    if (flag === "--extra-inventory") {
      const first = inline ?? next();
      const second = next();
      if (first === null || second === null) {
        console.error(USAGE);
        return null;
      }
      extraInventory.push([first, second]);
    } else if (
      flag === "--report" || flag === "--manifest" || flag === "--sbom" ||
      flag === "--output" || flag === "--root" || flag === "--scratch-dir"
    ) {
      const value = inline ?? next();
      if (value === null) {
        console.error(USAGE);
        return null;
      }
      values.set(flag, value);
    } else {
      console.error(USAGE);
      return null;
    }
    i++;
  }
  const report = values.get("--report");
  const manifest = values.get("--manifest");
  const sbom = values.get("--sbom");
  const output = values.get("--output");
  if (
    report === undefined || manifest === undefined || sbom === undefined ||
    output === undefined
  ) {
    console.error(USAGE);
    return null;
  }
  return {
    report,
    manifest,
    sbom,
    output,
    root: values.get("--root") ?? DEFAULT_ROOT,
    scratchDir: values.get("--scratch-dir") ?? null,
    extraInventory,
  };
}

/** Command line entry point; `env` and `runAudit` are replaced by doubles in the tests. */
export async function main(
  argv: string[],
  env?: Record<string, string | undefined>,
  runAudit: AuditRunner = lakeSbomAudit,
): Promise<number> {
  const args = parseArgs(argv);
  if (args === null) return 2;
  const environment = env ?? Deno.env.toObject();
  const annotate = environment["GITHUB_ACTIONS"] === "true";
  try {
    await produce(args, environment, runAudit);
  } catch (error) {
    if (!(error instanceof Error)) throw error;
    const message = error instanceof EvidenceError
      ? error.message
      : `${error.name}: ${error.message}`;
    console.error(
      annotate ? `::error::${clean(message)}` : `error: ${clean(message)}`,
    );
    return 1;
  }
  console.log(
    "Lean scoped SPDX consistency audit and negative CLI cases: PASS",
  );
  return 0;
}

if (import.meta.main) {
  Deno.exit(await main(Deno.args));
}
