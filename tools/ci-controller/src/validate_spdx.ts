// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Validate an SPDX 2.3 JSON document with pinned SPDX Tools plus
 * K7PL gap guards, ported faithfully from scripts/ci/validate_spdx.py.
 *
 * Gap guards are NOT weakened: a document that fails preflight
 * (empty package name, unknown document-root property, packages
 * not an array, ...) fails here before the external validator is
 * ever invoked, exactly as in Python, and with the same rule IDs,
 * exit codes and report shape.
 *
 * External validator invocation contract (ported, not invented):
 * - Command, exactly: ["pyspdxtools", "--infile", <path>,
 *   "--version", "SPDX-2.3"].
 * - Expected tool: spdx-tools version 0.8.5; any other version,
 *   a missing package, or a missing pyspdxtools executable is
 *   ERROR / exit 2, before the input is read.
 * - Non-zero validator exit is FAIL / exit 1, with the
 *   validator's stderr (or stdout, or a fallback sentence) as
 *   the SPDX-TOOLS-VALIDATION diagnostic, truncated to the last
 *   8000 characters, and the raw stderr (same truncation) in
 *   validatorStderr.
 * - A spawn failure is SPDX-VALIDATOR-EXEC / exit 2.
 * - The input is hashed before and after the validator run; a
 *   change is SPDX-INPUT-CHANGED / exit 2.
 *
 * Deno has no importlib.metadata, so the version/executable/run
 * probes are injection points (ValidatorTool), stubbed in tests.
 * The default tool is fail-closed on the version: getVersion()
 * returns null (=> SPDX-VALIDATOR-MISSING) unless a wiring
 * supplies a probe. createPythonImportlibTool() is such a probe:
 * it asks a Python interpreter for importlib.metadata's
 * spdx-tools version; it is a bridge to the pinned Python tool,
 * not a new validator, and it is not the default, so the
 * controller never shells out to Python unannounced.
 * findExecutable() by default is a PATH scan (the shutil.which
 * port); run() by default is Deno.Command over the exact
 * command above.
 *
 * Behaviour notes:
 * - Python's JSON parser error wording differs from
 *   JavaScript's; SPDX-INPUT-JSON preserves the rule, the
 *   "Input is not valid JSON: ..." prefix and exit 2, not the
 *   parser's wording.
 * - Python str.strip() is NOT JavaScript trim(): the whitespace
 *   set below is Python's (notably U+FEFF is not whitespace in
 *   Python, but String.prototype.trim removes it). Package-name
 *   blankness uses the Python set, so the Python test corpus
 *   (strip set vs. boundary code points) ports exactly.
 * - Report JSON printing uses Python json.dumps(sort_keys=True)
 *   layout (compact, ", " / ": " separators, sorted keys); see
 *   formatReportJson().
 */

export const EXPECTED_VALIDATOR_VERSION = "0.8.5";
export const REPORT_SCHEMA = "k7pl.spdx-validation/v1";

// Root properties from spdx/spdx-spec@v2.3/schemas/spdx-schema.json.
// The schema declares additionalProperties=false at the document
// root. This is a targeted gap guard, not a recursive SPDX schema
// implementation; nested validation remains the external
// validator's responsibility.
export const SPDX_23_DOCUMENT_FIELDS = new Set([
  "SPDXID",
  "annotations",
  "comment",
  "creationInfo",
  "dataLicense",
  "externalDocumentRefs",
  "hasExtractedLicensingInfos",
  "name",
  "revieweds",
  "spdxVersion",
  "documentNamespace",
  "documentDescribes",
  "packages",
  "files",
  "snippets",
  "relationships",
]);

export interface Diagnostic {
  ruleId: string;
  message: string;
  artifact: string;
}

/** Python str.strip() whitespace, as code points (see header note). */
export function isPythonWhitespace(codePoint: number): boolean {
  return (codePoint >= 0x09 && codePoint <= 0x0d) ||
    (codePoint >= 0x1c && codePoint <= 0x1f) || codePoint === 0x20 ||
    codePoint === 0x85 || codePoint === 0xa0 || codePoint === 0x1680 ||
    (codePoint >= 0x2000 && codePoint <= 0x200a) || codePoint === 0x2028 ||
    codePoint === 0x2029 || codePoint === 0x202f || codePoint === 0x205f ||
    codePoint === 0x3000;
}

export function pythonStrip(text: string): string {
  const chars = [...text];
  let start = 0;
  let end = chars.length;
  while (start < end && isPythonWhitespace(chars[start].codePointAt(0) ?? 0)) {
    start++;
  }
  while (
    end > start && isPythonWhitespace(chars[end - 1].codePointAt(0) ?? 0)
  ) {
    end--;
  }
  return chars.slice(start, end).join("");
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null &&
    !Array.isArray(value);
}

/** Reject obvious required-field gaps, including the currently reported upstream name gap. */
export function preflightIssues(document: unknown): Diagnostic[] {
  const issues: Diagnostic[] = [];
  if (!isRecord(document)) {
    return [{
      ruleId: "SPDX-PREFLIGHT-DOCUMENT",
      message: "The SPDX JSON root must be an object.",
      artifact: "document",
    }];
  }
  const packages = document["packages"];
  if (!Array.isArray(packages)) {
    return [{
      ruleId: "SPDX-PREFLIGHT-PACKAGES",
      message: "The SPDX JSON packages field must be an array.",
      artifact: "packages",
    }];
  }
  for (const field of Object.keys(document).sort()) {
    if (!SPDX_23_DOCUMENT_FIELDS.has(field)) {
      issues.push({
        ruleId: "SPDX-PREFLIGHT-UNKNOWN-DOCUMENT-FIELD",
        message:
          "The SPDX-2.3 JSON Schema rejects undeclared document-level properties " +
          "(additionalProperties is false at the document root).",
        artifact: `document.${field}`,
      });
    }
  }
  for (let index = 0; index < packages.length; index++) {
    const pkg = packages[index];
    const artifact = `packages[${index}]`;
    if (!isRecord(pkg)) {
      issues.push({
        ruleId: "SPDX-PREFLIGHT-PACKAGE",
        message: "Each SPDX package entry must be an object.",
        artifact,
      });
      continue;
    }
    const name = pkg["name"];
    if (typeof name !== "string" || pythonStrip(name) === "") {
      issues.push({
        ruleId: "SPDX-PREFLIGHT-PACKAGE-NAME",
        message:
          "Every package in this K7PL inventory must have a non-empty name. " +
          "This guard covers the known upstream validation gap tracked in " +
          "spdx/tools-python issue #885.",
        artifact: `${artifact}.name`,
      });
    }
  }
  return issues;
}

export interface ValidatorResult {
  returncode: number;
  stdout: string;
  stderr: string;
}

/**
 * The external validator probes. getVersion() returns the
 * installed spdx-tools version, or null when the package is not
 * installed; findExecutable() returns a pyspdxtools path, or
 * null when it is not on PATH; run() executes the exact command
 * and throws on a spawn failure.
 */
export interface ValidatorTool {
  getVersion: () => string | null | Promise<string | null>;
  findExecutable: () => string | null | Promise<string | null>;
  run: (command: string[]) => ValidatorResult | Promise<ValidatorResult>;
}

export interface ValidateOptions {
  tool?: ValidatorTool;
  sha256File?: (path: string) => Promise<string>;
  env?: Record<string, string | undefined>;
}

export interface SpdxReport {
  schemaVersion: string;
  status: string;
  input: { artifact: string; sha256: string | null };
  validator: {
    name: string;
    version: string | null;
    expectedVersion: string;
    command: string[];
    elapsedMs: number | null;
  };
  workflow: {
    runId: string | null;
    runAttempt: string | null;
    checkedOutSha: string | null;
    pullRequestHeadSha?: unknown;
  };
  diagnostics: Diagnostic[];
  limitations: string[];
  validatorStderr?: string;
  elapsedMs?: number;
}

function basename(path: string): string {
  const stripped = path.replace(/\/+$/, "");
  const slash = stripped.lastIndexOf("/");
  return slash >= 0 ? stripped.slice(slash + 1) : stripped;
}

function envValue(
  env: Record<string, string | undefined> | undefined,
  key: string,
): string | null {
  if (env !== undefined) {
    return key in env ? (env[key] ?? null) : null;
  }
  return Deno.env.get(key) ?? null;
}

function buildReport(
  path: string,
  status: string,
  validatorVersion: string | null,
  digest: string | null,
  diagnostics: Diagnostic[],
  options: {
    validatorStderr?: string;
    validatorElapsedMs?: number | null;
    env?: Record<string, string | undefined>;
  } = {},
): SpdxReport {
  const workflow: SpdxReport["workflow"] = {
    runId: envValue(options.env, "GITHUB_RUN_ID"),
    runAttempt: envValue(options.env, "GITHUB_RUN_ATTEMPT"),
    checkedOutSha: envValue(options.env, "GITHUB_SHA"),
  };
  const eventPath = envValue(options.env, "GITHUB_EVENT_PATH");
  if (eventPath) {
    try {
      const eventText = Deno.readTextFileSync(eventPath);
      const event: unknown = JSON.parse(eventText);
      if (!isRecord(event)) throw new Error("event is not an object");
      const pullRequest: unknown = event["pull_request"];
      const pr = pullRequest || {};
      if (!isRecord(pr)) throw new Error("pull_request is not an object");
      const head: unknown = "head" in pr ? pr["head"] : {};
      if (!isRecord(head)) throw new Error("head is not an object");
      workflow.pullRequestHeadSha = "sha" in head ? head["sha"] : null;
    } catch {
      workflow.pullRequestHeadSha = null;
    }
  }
  const report: SpdxReport = {
    schemaVersion: REPORT_SCHEMA,
    status,
    input: { artifact: basename(path), sha256: digest },
    validator: {
      name: "spdx-tools",
      version: validatorVersion,
      expectedVersion: EXPECTED_VALIDATOR_VERSION,
      command: ["pyspdxtools", "--infile", path, "--version", "SPDX-2.3"],
      elapsedMs: options.validatorElapsedMs ?? null,
    },
    workflow,
    diagnostics,
    limitations: [
      "The external validator checks the supplied SPDX document; it does not establish that the SBOM inventories every build/runtime dependency or shipped artifact.",
      "K7PL preflight guards package names because spdx/tools-python issue #885 reports that an empty PackageName may not be flagged by the external validator.",
      "K7PL preflight also rejects undeclared SPDX 2.3 document-root properties because the pinned v2.3 JSON Schema sets additionalProperties=false; this root-only guard is not full JSON Schema validation.",
      "This result is not a proof of vulnerability absence, licence compatibility, provenance of upstream dependencies, or overall legal/regulatory compliance.",
    ],
  };
  if (options.validatorStderr) {
    report.validatorStderr = options.validatorStderr.slice(-8000);
  }
  return report;
}

function roundMs(ms: number): number {
  return Math.round(ms * 1000) / 1000;
}

/** Hexadecimal SHA-256 of a file's bytes (the file_digest.py port). */
export async function sha256File(path: string): Promise<string> {
  const bytes = await Deno.readFile(path);
  const digest = await crypto.subtle.digest("SHA-256", bytes);
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

async function readTextStrict(path: string): Promise<string> {
  const bytes = await Deno.readFile(path);
  return new TextDecoder("utf-8", { fatal: true }).decode(bytes);
}

function defaultTool(
  env: Record<string, string | undefined> | undefined,
): ValidatorTool {
  return {
    getVersion: () => null,
    findExecutable: () => {
      const pathEnv = envValue(env, "PATH") ?? "";
      for (const dir of pathEnv.split(":")) {
        if (dir === "") continue;
        const candidate = `${dir}/pyspdxtools`;
        try {
          const info = Deno.statSync(candidate);
          if (info.isFile) return candidate;
        } catch {
          // Not present in this directory; keep scanning.
        }
      }
      return null;
    },
    run: async (command: string[]) => {
      const cmd = new Deno.Command(command[0], {
        args: command.slice(1),
        stdout: "piped",
        stderr: "piped",
      });
      const { code, stdout, stderr } = await cmd.output();
      const decoder = new TextDecoder();
      return {
        returncode: code,
        stdout: decoder.decode(stdout),
        stderr: decoder.decode(stderr),
      };
    },
  };
}

/**
 * A ValidatorTool whose version probe asks Python's
 * importlib.metadata for spdx-tools (the Python check, bridged).
 * Any failure to run Python or to find the package is null, i.e.
 * SPDX-VALIDATOR-MISSING, exactly as in Python.
 */
export function createPythonImportlibTool(
  env: Record<string, string | undefined> | undefined = undefined,
): ValidatorTool {
  const base = defaultTool(env);
  return {
    ...base,
    getVersion: async () => {
      try {
        const cmd = new Deno.Command("python3", {
          args: [
            "-c",
            "from importlib.metadata import version\nprint(version('spdx-tools'))",
          ],
          stdout: "piped",
          stderr: "piped",
        });
        const { code, stdout } = await cmd.output();
        if (code !== 0) return null;
        const text = new TextDecoder().decode(stdout).trim();
        return text === "" ? null : text;
      } catch {
        return null;
      }
    },
  };
}

export async function validate(
  path: string,
  options: ValidateOptions = {},
): Promise<{ report: SpdxReport; exitCode: number }> {
  const tool = options.tool ?? defaultTool(options.env);
  const hash = options.sha256File ?? sha256File;
  const env = options.env;

  let validatorVersion: string | null;
  try {
    validatorVersion = await tool.getVersion();
  } catch {
    validatorVersion = null;
  }
  if (validatorVersion === null) {
    return {
      report: buildReport(path, "ERROR", null, null, [{
        ruleId: "SPDX-VALIDATOR-MISSING",
        message: "The pinned spdx-tools package is not installed.",
        artifact: "toolchain",
      }], { env }),
      exitCode: 2,
    };
  }
  if (validatorVersion !== EXPECTED_VALIDATOR_VERSION) {
    return {
      report: buildReport(path, "ERROR", validatorVersion, null, [{
        ruleId: "SPDX-VALIDATOR-VERSION",
        message:
          `Expected spdx-tools ${EXPECTED_VALIDATOR_VERSION}, got ${validatorVersion}.`,
        artifact: "toolchain",
      }], { env }),
      exitCode: 2,
    };
  }

  let executable: string | null;
  try {
    executable = await tool.findExecutable();
  } catch {
    executable = null;
  }
  if (executable === null) {
    return {
      report: buildReport(path, "ERROR", validatorVersion, null, [{
        ruleId: "SPDX-VALIDATOR-CLI-MISSING",
        message: "The pyspdxtools executable was not found on PATH.",
        artifact: "toolchain",
      }], { env }),
      exitCode: 2,
    };
  }

  let digestBefore: string;
  let text: string;
  try {
    digestBefore = await hash(path);
    text = await readTextStrict(path);
  } catch (error) {
    return {
      report: buildReport(path, "ERROR", validatorVersion, null, [{
        ruleId: "SPDX-INPUT-READ",
        message: `Unable to read the input: ${
          error instanceof Error ? error.message : String(error)
        }`,
        artifact: basename(path),
      }], { env }),
      exitCode: 2,
    };
  }

  let document: unknown;
  try {
    document = JSON.parse(text);
  } catch (error) {
    return {
      report: buildReport(path, "ERROR", validatorVersion, null, [{
        ruleId: "SPDX-INPUT-JSON",
        message: `Input is not valid JSON: ${
          error instanceof Error ? error.message : String(error)
        }`,
        artifact: basename(path),
      }], { env }),
      exitCode: 2,
    };
  }

  const issues = preflightIssues(document);
  if (issues.length > 0) {
    return {
      report: buildReport(
        path,
        "FAIL",
        validatorVersion,
        digestBefore,
        issues,
        { env },
      ),
      exitCode: 1,
    };
  }

  const command = [
    "pyspdxtools",
    "--infile",
    path,
    "--version",
    "SPDX-2.3",
  ];
  const started = performance.now();
  let result: ValidatorResult;
  try {
    result = await tool.run(command);
  } catch (error) {
    const elapsedMs = roundMs(performance.now() - started);
    return {
      report: buildReport(path, "ERROR", validatorVersion, digestBefore, [{
        ruleId: "SPDX-VALIDATOR-EXEC",
        message: `Unable to execute validator: ${
          error instanceof Error ? error.message : String(error)
        }`,
        artifact: "toolchain",
      }], { validatorElapsedMs: elapsedMs, env }),
      exitCode: 2,
    };
  }
  const validatorElapsedMs = roundMs(performance.now() - started);

  let digestAfter: string;
  try {
    digestAfter = await hash(path);
  } catch (error) {
    return {
      report: buildReport(path, "ERROR", validatorVersion, digestBefore, [{
        ruleId: "SPDX-INPUT-READ",
        message: `Unable to re-read input after validation: ${
          error instanceof Error ? error.message : String(error)
        }`,
        artifact: basename(path),
      }], { validatorElapsedMs, env }),
      exitCode: 2,
    };
  }
  if (digestAfter !== digestBefore) {
    return {
      report: buildReport(path, "ERROR", validatorVersion, digestBefore, [{
        ruleId: "SPDX-INPUT-CHANGED",
        message: "The input bytes changed while validation was running.",
        artifact: basename(path),
      }], { validatorElapsedMs, env }),
      exitCode: 2,
    };
  }

  if (result.returncode !== 0) {
    const detail = pythonStrip(
      result.stderr || result.stdout || "Validator exited unsuccessfully.",
    );
    // Python strips, then truncates the diagnostic to the last
    // 8000 characters; validatorStderr keeps the raw stderr,
    // truncated the same way by buildReport().
    const diagnosticMessage = detail.slice(-8000);
    return {
      report: buildReport(path, "FAIL", validatorVersion, digestBefore, [{
        ruleId: "SPDX-TOOLS-VALIDATION",
        message: diagnosticMessage,
        artifact: basename(path),
      }], { validatorStderr: result.stderr, validatorElapsedMs, env }),
      exitCode: 1,
    };
  }

  return {
    report: buildReport(path, "PASS", validatorVersion, digestBefore, [], {
      validatorElapsedMs,
      env,
    }),
    exitCode: 0,
  };
}

/** Python json.dumps(report, sort_keys=True): compact, sorted keys. */
export function formatReportJson(report: SpdxReport): string {
  return sortedJsonCompact(report as unknown);
}

function sortedJsonCompact(value: unknown): string {
  if (
    value === null || typeof value === "boolean" || typeof value === "number" ||
    typeof value === "string"
  ) {
    return JSON.stringify(value) ?? "null";
  }
  if (Array.isArray(value)) {
    return `[${value.map((item) => sortedJsonCompact(item)).join(", ")}]`;
  }
  if (typeof value === "object") {
    const record = value as Record<string, unknown>;
    const keys = Object.keys(record).sort();
    return `{${
      keys.map((k) => `${JSON.stringify(k)}: ${sortedJsonCompact(record[k])}`)
        .join(", ")
    }}`;
  }
  return JSON.stringify(value) ?? "null";
}

/**
 * The Python CLI (validate_spdx.py main()), as a pure result:
 * exit code and the report (with the top-level elapsedMs the
 * Python main() adds). The caller prints formatReportJson(report).
 * argv includes the program name, as sys.argv does.
 */
export async function validateSpdxMain(
  argv: string[],
  options: ValidateOptions = {},
): Promise<{ exitCode: number; report: SpdxReport }> {
  const started = performance.now();
  if (argv.length !== 2) {
    const path = argv.length > 1 ? argv[1] : "spdx.json";
    const report = buildReport(path, "ERROR", null, null, [{
      ruleId: "USAGE",
      message: "Usage: validate_spdx.py <spdx-2.3.json>",
      artifact: "arguments",
    }], { env: options.env });
    report.elapsedMs = roundMs(performance.now() - started);
    return { exitCode: 2, report };
  }
  const { report, exitCode } = await validate(argv[1], options);
  report.elapsedMs = roundMs(performance.now() - started);
  return { exitCode, report };
}
