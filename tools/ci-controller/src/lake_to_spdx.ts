// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Scoped SPDX 2.3 JSON inventory from the pinned Lake manifest,
 * ported faithfully from scripts/ci/lake_manifest_to_spdx.py.
 *
 * This is an inventory of packages listed by Lake, not a claim
 * that the manifest contains a complete direct/transitive
 * dependency graph. Unknown licence and copyright data remain
 * NOASSERTION. It does not inventory build tools, GitHub Actions,
 * or generated artifacts. One document describes one Lake
 * workspace; the Paperproof document's name and comments say so.
 *
 * Manifest validation is the shared port in lake_to_osv.ts (see
 * its header note); this file imports validatedManifest and the
 * workspace constants from there rather than duplicating them.
 *
 * Behaviour notes:
 * - generateSbom() is async only because SHA-256 here uses
 *   WebCrypto (crypto.subtle); its inputs, outputs and error
 *   messages are otherwise the Python function's. The inventory
 *   hash is over the same canonical serialization (sorted keys,
 *   compact separators, packages sorted by url/name/rev, version
 *   present as null when the manifest has no version key).
 * - normalizeCreated() honours an explicit value, then
 *   SOURCE_DATE_EPOCH, then the current UTC time, exactly as
 *   Python does. Its error messages are the Python ones; its
 *   ISO-8601 parsing covers the extended format Python's
 *   fromisoformat accepts for these timestamps (a date with an
 *   optional time and an explicit timezone). A timestamp with no
 *   timezone is rejected, as is a malformed SOURCE_DATE_EPOCH.
 *   Fractional seconds are dropped when formatting, as Python's
 *   strftime("%Y-%m-%dT%H:%M:%SZ") drops them.
 * - The Python CLI writes its success line to stderr and the
 *   document to stdout when --output is omitted; runLakeToSpdx()
 *   preserves that split in its returned stdout/stderr strings.
 */

import {
  type LakeManifest,
  type LakePackage,
  loadWorkspaceInputs,
  manifestLabel,
  PAPERPROOF_WORKSPACE,
  pyStr,
  ROOT_WORKSPACE,
  sortedJson,
  validatedManifest,
  type Workspace,
} from "./lake_to_osv.ts";

export const DOCUMENT_NAME = "K7PL Lake dependency inventory";
export const TOOL_NAME = "k7pl-lake-sbom";
export const TOOL_VERSION = "0.1.0";

export type SpdxEnv = Record<string, string | undefined>;

/**
 * Return an SPDX UTC timestamp, honouring an explicit value or
 * SOURCE_DATE_EPOCH. env defaults to the process environment.
 */
export function normalizeCreated(
  value?: string | null,
  env: SpdxEnv = Deno.env.toObject(),
): string {
  if (value !== null && value !== undefined) {
    return normalizeExplicitCreated(value);
  }
  const epochRaw = env["SOURCE_DATE_EPOCH"];
  if (epochRaw !== undefined) {
    const trimmed = epochRaw.trim();
    if (!/^[+-]?[0-9](?:_?[0-9])*$/.test(trimmed)) {
      throw new Error("SOURCE_DATE_EPOCH must be a valid Unix timestamp");
    }
    const epoch = Number(trimmed.replace(/_/g, ""));
    if (!Number.isFinite(epoch)) {
      throw new Error("SOURCE_DATE_EPOCH must be a valid Unix timestamp");
    }
    const moment = new Date(epoch * 1000);
    if (Number.isNaN(moment.getTime())) {
      throw new Error("SOURCE_DATE_EPOCH must be a valid Unix timestamp");
    }
    const year = moment.getUTCFullYear();
    if (year < 1 || year > 9999) {
      throw new Error("SOURCE_DATE_EPOCH must be a valid Unix timestamp");
    }
    return formatUtc(moment);
  }
  return formatUtc(new Date());
}

function formatUtc(moment: Date): string {
  const pad = (n: number, width = 2) => String(n).padStart(width, "0");
  return `${pad(moment.getUTCFullYear(), 4)}-${
    pad(moment.getUTCMonth() + 1)
  }-` +
    `${pad(moment.getUTCDate())}T${pad(moment.getUTCHours())}:` +
    `${pad(moment.getUTCMinutes())}:${pad(moment.getUTCSeconds())}Z`;
}

function normalizeExplicitCreated(raw: string): string {
  const match =
    /^(\d{4})-(\d{2})-(\d{2})(?:[T ](\d{2}):(\d{2})(?::(\d{2})(?:\.\d+)?)?)?(Z|[+-]\d{2}(?::?\d{2})?|[+-]\d{2})?$/
      .exec(raw);
  if (match === null) {
    throw new Error(
      "created timestamp must be ISO 8601 with an explicit timezone",
    );
  }
  const tz = match[7];
  if (tz === undefined) {
    throw new Error("created timestamp must include an explicit timezone");
  }
  const year = Number(match[1]);
  const month = Number(match[2]);
  const day = Number(match[3]);
  const hour = match[4] === undefined ? 0 : Number(match[4]);
  const minute = match[5] === undefined ? 0 : Number(match[5]);
  const second = match[6] === undefined ? 0 : Number(match[6]);
  if (
    month < 1 || month > 12 || day < 1 || day > 31 || hour > 23 ||
    minute > 59 || second > 59
  ) {
    throw new Error(
      "created timestamp must be ISO 8601 with an explicit timezone",
    );
  }
  const asUtc = new Date(Date.UTC(year, month - 1, day, hour, minute, second));
  if (
    asUtc.getUTCFullYear() !== year || asUtc.getUTCMonth() !== month - 1 ||
    asUtc.getUTCDate() !== day || asUtc.getUTCHours() !== hour ||
    asUtc.getUTCMinutes() !== minute || asUtc.getUTCSeconds() !== second
  ) {
    throw new Error(
      "created timestamp must be ISO 8601 with an explicit timezone",
    );
  }
  let offsetMinutes = 0;
  if (tz !== "Z") {
    const sign = tz.startsWith("-") ? -1 : 1;
    const digits = tz.slice(1).replace(":", "");
    const tzHour = Number(digits.slice(0, 2));
    const tzMinute = digits.length > 2 ? Number(digits.slice(2, 4)) : 0;
    if (tzHour > 23 || tzMinute > 59) {
      throw new Error(
        "created timestamp must be ISO 8601 with an explicit timezone",
      );
    }
    offsetMinutes = sign * (tzHour * 60 + tzMinute);
  }
  return formatUtc(new Date(asUtc.getTime() - offsetMinutes * 60_000));
}

/** Serialize the validated manifest's package inventory in a stable order. */
export function canonicalManifest(manifest: LakeManifest): string {
  const packages = [...(manifest["packages"] as LakePackage[])].sort((a, b) => {
    const urlA = String(a["url"]);
    const urlB = String(b["url"]);
    if (urlA !== urlB) return urlA < urlB ? -1 : 1;
    const nameA = String(a["name"]);
    const nameB = String(b["name"]);
    if (nameA !== nameB) return nameA < nameB ? -1 : 1;
    const revA = String(a["rev"]);
    const revB = String(b["rev"]);
    return revA < revB ? -1 : revA > revB ? 1 : 0;
  });
  const normalized = {
    name: manifest["name"],
    version: "version" in manifest ? manifest["version"] : null,
    packages,
  };
  return sortedJson(normalized, null, ",", ":");
}

/** Build a stable SPDX identifier without punctuation outside the SPDX identifier subset. */
export function spdxId(pkg: LakePackage): string {
  const slug = String(pkg["name"]).replace(/[^A-Za-z0-9.-]/g, "-")
    .replace(/^[.-]+|[.-]+$/g, "") || "package";
  return `SPDXRef-Dependency-${slug}-${String(pkg["rev"]).slice(0, 12)}`;
}

async function sha256Hex(text: string): Promise<string> {
  const digest = await crypto.subtle.digest(
    "SHA-256",
    new TextEncoder().encode(text),
  );
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

export interface SpdxPackage {
  name: string;
  SPDXID: string;
  versionInfo: string;
  downloadLocation: string;
  filesAnalyzed: boolean;
  licenseConcluded: string;
  licenseDeclared: string;
  copyrightText: string;
  packageComment: string;
}

export interface SpdxDocument {
  spdxVersion: string;
  dataLicense: string;
  SPDXID: string;
  name: string;
  documentNamespace: string;
  creationInfo: { creators: string[]; created: string };
  comment: string;
  packages: SpdxPackage[];
  relationships: Array<{
    spdxElementId: string;
    relationshipType: string;
    relatedSpdxElement: string;
  }>;
}

/** Build SPDX 2.3 JSON only from a valid manifest consistent with its workspace's pins. */
export async function generateSbom(
  manifest: unknown,
  lakefile: string,
  toolchain: string,
  created: string | null | undefined,
  workspace: Workspace = ROOT_WORKSPACE,
): Promise<SpdxDocument> {
  const valid = validatedManifest(manifest, lakefile, toolchain, workspace);
  const source = manifestLabel(workspace);
  const createdUtc = normalizeCreated(created ?? null);
  const canonical = canonicalManifest(valid);
  const inventoryHash = await sha256Hex(canonical);
  const namespace =
    `https://spdx.org/spdxdocs/k7pl-lake-dependencies-${inventoryHash}`;

  const sorted = [...(valid["packages"] as LakePackage[])].sort((a, b) => {
    const urlA = String(a["url"]);
    const urlB = String(b["url"]);
    if (urlA !== urlB) return urlA < urlB ? -1 : 1;
    const nameA = String(a["name"]);
    const nameB = String(b["name"]);
    if (nameA !== nameB) return nameA < nameB ? -1 : 1;
    const revA = String(a["rev"]);
    const revB = String(b["rev"]);
    return revA < revB ? -1 : revA > revB ? 1 : 0;
  });

  const packages: SpdxPackage[] = [];
  const relationships: SpdxDocument["relationships"] = [];
  for (const item of sorted) {
    const id = spdxId(item);
    const inputRev = "inputRev" in item ? pyStr(item["inputRev"]) : "unknown";
    const inheritedRaw = "inherited" in item ? item["inherited"] : "unknown";
    const inherited = pyStr(inheritedRaw).toLowerCase();
    const scopeRaw = "scope" in item ? item["scope"] : "unknown";
    const scope = scopeRaw ? String(scopeRaw) : "(empty)";
    packages.push({
      name: String(item["name"]),
      SPDXID: id,
      versionInfo: String(item["rev"]),
      downloadLocation: String(item["url"]),
      filesAnalyzed: false,
      licenseConcluded: "NOASSERTION",
      licenseDeclared: "NOASSERTION",
      copyrightText: "NOASSERTION",
      packageComment:
        `Listed in ${source}. versionInfo is the exact resolved Git commit, ` +
        "not a semantic version. " +
        `Requested inputRev: ${inputRev}; inherited: ${inherited}; scope: ${scope}. ` +
        "The manifest is a flattened package inventory and does not establish a complete " +
        "direct/transitive dependency graph; no dependency edge is inferred here.",
    });
    relationships.push({
      spdxElementId: "SPDXRef-DOCUMENT",
      relationshipType: "DESCRIBES",
      relatedSpdxElement: id,
    });
  }

  const isRoot = workspace.directory === ".";
  const name = isRoot
    ? DOCUMENT_NAME
    : `${DOCUMENT_NAME} (${workspace.directory})`;
  const scopeText = isRoot ? "" : (
    "This is the isolated Lake workspace of the Paperproof proof-visualization extractor, used to " +
    "build the specification site; it is not a dependency of the k7pl Lake package. "
  );
  return {
    spdxVersion: "SPDX-2.3",
    dataLicense: "CC0-1.0",
    SPDXID: "SPDXRef-DOCUMENT",
    name,
    documentNamespace: namespace,
    creationInfo: {
      creators: [`Tool: ${TOOL_NAME}-${TOOL_VERSION}`],
      created: createdUtc,
    },
    comment:
      `Scoped inventory generated from ${source}. ${scopeText}It covers only the package entries ` +
      "in that manifest; it does not assert completeness for build tools, CI actions, source files, " +
      "generated artifacts, or direct/transitive dependency edges. Unknown licence and copyright " +
      "information is represented as NOASSERTION.",
    packages,
    relationships,
  };
}

/** The SPDX document text, as the Python CLI writes it (indent 2, sorted keys). */
export function spdxJson(result: SpdxDocument): string {
  return sortedJson(result, 2) + "\n";
}

export function spdxSuccessMessage(count: number): string {
  return `Generated scoped SPDX 2.3 inventory with ${count} Lake package entries`;
}

export interface CliResult {
  exitCode: number;
  stdout: string;
  stderr: string;
}

interface SpdxArgs {
  manifest: string | null;
  lakefile: string | null;
  toolchain: string | null;
  created: string | null;
  output: string | null;
  error: string | null;
}

function parseSpdxArgs(argv: string[]): SpdxArgs {
  const args: SpdxArgs = {
    manifest: null,
    lakefile: null,
    toolchain: null,
    created: null,
    output: null,
    error: null,
  };
  const known = new Set([
    "--manifest",
    "--lakefile",
    "--toolchain",
    "--created",
    "--output",
  ]);
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    const eq = arg.indexOf("=");
    const flag = eq >= 0 ? arg.slice(0, eq) : arg;
    const inline = eq >= 0 ? arg.slice(eq + 1) : null;
    if (!known.has(flag)) {
      args.error = `unrecognized arguments: ${arg}`;
      return args;
    }
    const value = inline ?? argv[++i];
    if (value === undefined) {
      args.error = `argument ${flag}: expected one argument`;
      return args;
    }
    if (flag === "--manifest") args.manifest = value;
    else if (flag === "--lakefile") args.lakefile = value;
    else if (flag === "--toolchain") args.toolchain = value;
    else if (flag === "--created") args.created = value;
    else if (flag === "--output") args.output = value;
  }
  return args;
}

/**
 * The Python CLI (lake_manifest_to_spdx.py main()), as a pure
 * result: exit code, stdout and stderr strings. The caller prints
 * them. Defaults are the files of the repository root given; the
 * workspace is chosen by the manifest path, as in Python.
 */
export async function runLakeToSpdx(
  argv: string[],
  repoRoot = ".",
  env: SpdxEnv = Deno.env.toObject(),
): Promise<CliResult> {
  const args = parseSpdxArgs(argv);
  if (args.error !== null) {
    return {
      exitCode: 2,
      stdout: "",
      stderr: `lake_manifest_to_spdx.py: ${args.error}\n`,
    };
  }
  try {
    const inputs = loadWorkspaceInputs(
      repoRoot,
      args.manifest,
      args.lakefile,
      args.toolchain,
    );
    // Python normalizes the timestamp before generating, so a
    // bad --created fails before any document is built.
    const created = normalizeCreated(args.created, env);
    const result = await generateSbom(
      inputs.manifest,
      inputs.lakefile,
      inputs.toolchain,
      created,
      inputs.workspace,
    );
    const encoded = spdxJson(result);
    if (args.output === null) {
      return {
        exitCode: 0,
        stdout: encoded,
        stderr: spdxSuccessMessage(result.packages.length) + "\n",
      };
    }
    Deno.writeTextFileSync(args.output, encoded);
    return {
      exitCode: 0,
      stdout: "",
      stderr: spdxSuccessMessage(result.packages.length) + "\n",
    };
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    return {
      exitCode: 1,
      stdout: "",
      stderr: `lake_manifest_to_spdx.py: ${message}\n`,
    };
  }
}

// Re-exported so callers of the SPDX port need not import the OSV
// module for the workspace that describes a document.
export { PAPERPROOF_WORKSPACE };

/** Direct CLI entry point with a narrow SOURCE_DATE_EPOCH environment read. */
if (import.meta.main) {
  const env = { SOURCE_DATE_EPOCH: Deno.env.get("SOURCE_DATE_EPOCH") };
  const result = await runLakeToSpdx(Deno.args, ".", env);
  if (result.stdout !== "") {
    await Deno.stdout.write(new TextEncoder().encode(result.stdout));
  }
  if (result.stderr !== "") {
    await Deno.stderr.write(new TextEncoder().encode(result.stderr));
  }
  Deno.exit(result.exitCode);
}
