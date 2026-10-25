// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Lake manifest -> OSV-Scanner custom lockfile, ported faithfully
 * from scripts/ci/lake_manifest_to_osv.py.
 *
 * This adapter emits repository identities and exact Git commit
 * hashes, not invented semantic versions or package-manager
 * identities. It is a vulnerability-query input, not an SPDX or
 * CycloneDX SBOM, and does not imply that OSV contains advisories
 * for every dependency.
 *
 * Manifest validation is imported from manifest.ts, the canonical
 * port of scripts/ci/check_manifest.py (offline checks only here:
 * structure, allow-list, lakefile/toolchain consistency; no
 * --check-tags / --check-upstream network checks). An earlier
 * version of this file carried its own copy of that validator;
 * it was removed when manifest.ts landed, so the two converters
 * and the manifest checker share exactly one validator. Only the
 * message helpers differ in name (pyStr/pyRepr here are aliases
 * of manifest.ts pythonStr/pythonRepr, kept so lake_to_spdx.ts
 * does not churn); the checked behaviour is the imported one.
 *
 * Behaviour notes (deliberate, matching the Python original):
 * - convertManifest() throws Error with the Python ValueError
 *   message text ("invalid Lake manifest:\n- ..." /
 *   "inconsistent Lake inputs:\n- ..."). The CLI runner turns
 *   that into the `lake_manifest_to_osv.py: <message>` stderr
 *   line and exit code 1, exactly as the Python main() does.
 * - Python repr() in messages is approximated by pyRepr():
 *   strings in single quotes, None for null/missing, True/False
 *   for booleans. Non-ASCII and control-character edge cases in
 *   repr() may differ in escaping, never in the checked prefix.
 * - Python JSON error text differs from the JavaScript parser's;
 *   loadManifest() preserves the "<path> is not valid JSON: ..."
 *   prefix and the exit code, not the parser's wording.
 * - The workspace is chosen by the manifest path only, never by
 *   its content (see workspaceFor()).
 */

import {
  checkConsistency,
  checkManifest,
  loadWorkspaceInputs,
  MANIFEST_FILE,
  manifestLabel,
  PAPERPROOF_DIRECTORY,
  PAPERPROOF_WORKSPACE,
  pythonStr,
  ROOT_WORKSPACE,
  validatedManifest,
  type Workspace,
  type WorkspaceInputs,
} from "./manifest.ts";

export {
  checkConsistency,
  checkManifest,
  loadWorkspaceInputs,
  MANIFEST_FILE,
  manifestLabel,
  PAPERPROOF_DIRECTORY,
  PAPERPROOF_WORKSPACE,
  ROOT_WORKSPACE,
  validatedManifest,
  type Workspace,
  type WorkspaceInputs,
};
export { pythonStr as pyStr };

export type LakePackage = Record<string, unknown>;
export type LakeManifest = Record<string, unknown>;

export interface OsvPackage {
  package: { name: string; commit: string };
}

export interface OsvLockfile {
  results: Array<{ packages: OsvPackage[] }>;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null &&
    !Array.isArray(value);
}

export function joinPath(...parts: string[]): string {
  const joined = parts.filter((p) => p !== "").join("/");
  const absolute = joined.startsWith("/");
  const out: string[] = [];
  for (const segment of joined.split("/")) {
    if (segment === "" || segment === ".") continue;
    if (segment === "..") {
      if (out.length > 0 && out[out.length - 1] !== "..") out.pop();
      else if (!absolute) out.push("..");
      continue;
    }
    out.push(segment);
  }
  const result = (absolute ? "/" : "") + out.join("/");
  return result === "" ? "." : result;
}

/** Convert only a structurally valid manifest consistent with Lake's declared pins. */
export function convertManifest(
  manifest: unknown,
  lakefile: string,
  toolchain: string,
  workspace: Workspace = ROOT_WORKSPACE,
): OsvLockfile {
  const valid = validatedManifest(manifest, lakefile, toolchain, workspace);
  const packages = valid["packages"] as LakePackage[];
  const sorted = [...packages].sort((a, b) => {
    const urlA = String(a["url"]);
    const urlB = String(b["url"]);
    if (urlA !== urlB) return urlA < urlB ? -1 : 1;
    const revA = String(a["rev"]);
    const revB = String(b["rev"]);
    return revA < revB ? -1 : revA > revB ? 1 : 0;
  });
  const dependencies: OsvPackage[] = sorted.map((item) => {
    const url = String(item["url"]);
    const repository = url.startsWith("https://")
      ? url.slice("https://".length)
      : url;
    return { package: { name: repository, commit: String(item["rev"]) } };
  });
  return { results: [{ packages: dependencies }] };
}

/**
 * Python json.dumps(..., sort_keys=True): keys sorted, compact
 * separators when indent is null, indent-2 layout otherwise.
 * (Python escapes and JavaScript JSON.stringify agree on the
 * characters that occur in these documents.)
 */
export function sortedJson(
  value: unknown,
  indent: number | null,
  // Compact separators, as Python's separators=(item, key):
  // (", ", ": ") for Python's default dumps(), (",", ":") for
  // dumps(..., separators=(",", ":")) as used by the SPDX
  // canonical manifest (the inventory hash depends on both).
  compactItemSep = ", ",
  compactKeySep = ": ",
): string {
  if (
    value === null || typeof value === "boolean" || typeof value === "number"
  ) {
    return JSON.stringify(value) ?? "null";
  }
  if (typeof value === "string") return JSON.stringify(value);
  if (Array.isArray(value)) {
    if (value.length === 0) return "[]";
    if (indent === null) {
      return `[${
        value.map((item) =>
          sortedJson(item, null, compactItemSep, compactKeySep)
        ).join(compactItemSep)
      }]`;
    }
    const pad = " ".repeat(indent);
    const inner = value.map((item) => pad + sortedJsonIndented(item, indent, 1))
      .join(",\n");
    return `[\n${inner}\n]`;
  }
  if (isRecord(value)) {
    const keys = Object.keys(value).sort();
    if (keys.length === 0) return "{}";
    if (indent === null) {
      return `{${
        keys.map((k) =>
          `${JSON.stringify(k)}${compactKeySep}${
            sortedJson(value[k], null, compactItemSep, compactKeySep)
          }`
        )
          .join(compactItemSep)
      }}`;
    }
    const pad = " ".repeat(indent);
    const inner = keys.map((k) =>
      `${pad}${JSON.stringify(k)}: ${sortedJsonIndented(value[k], indent, 1)}`
    ).join(",\n");
    return `{\n${inner}\n}`;
  }
  return JSON.stringify(value) ?? "null";
}

function sortedJsonIndented(
  value: unknown,
  indent: number,
  level: number,
): string {
  if (
    value === null || typeof value === "boolean" || typeof value === "number"
  ) {
    return JSON.stringify(value) ?? "null";
  }
  if (typeof value === "string") return JSON.stringify(value);
  const pad = " ".repeat(indent * level);
  const childPad = " ".repeat(indent * (level + 1));
  if (Array.isArray(value)) {
    if (value.length === 0) return "[]";
    const inner = value.map((item) =>
      childPad + sortedJsonIndented(item, indent, level + 1)
    ).join(",\n");
    return `[\n${inner}\n${pad}]`;
  }
  if (isRecord(value)) {
    const keys = Object.keys(value).sort();
    if (keys.length === 0) return "{}";
    const inner = keys.map((k) =>
      `${childPad}${JSON.stringify(k)}: ${
        sortedJsonIndented(value[k], indent, level + 1)
      }`
    ).join(",\n");
    return `{\n${inner}\n${pad}}`;
  }
  return JSON.stringify(value) ?? "null";
}

/** The OSV lockfile text, as the Python CLI writes it (indent 2, sorted keys). */
export function osvJson(result: OsvLockfile): string {
  return sortedJson(result, 2) + "\n";
}

export function osvSuccessMessage(count: number, output: string): string {
  return `Generated OSV-Scanner custom lockfile with ${count} pinned Lake Git dependencies: ${output}`;
}

export interface CliResult {
  exitCode: number;
  stdout: string;
  stderr: string;
}

interface OsvArgs {
  manifest: string | null;
  output: string | null;
  error: string | null;
}

function parseOsvArgs(argv: string[]): OsvArgs {
  let manifest: string | null = null;
  let output: string | null = null;
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    const eq = arg.indexOf("=");
    const flag = eq >= 0 ? arg.slice(0, eq) : arg;
    const inline = eq >= 0 ? arg.slice(eq + 1) : null;
    if (flag === "--manifest" || flag === "--output") {
      const value = inline ?? argv[++i];
      if (value === undefined) {
        return {
          manifest,
          output,
          error: `argument ${flag}: expected one argument`,
        };
      }
      if (flag === "--manifest") manifest = value;
      else output = value;
    } else {
      return { manifest, output, error: `unrecognized arguments: ${arg}` };
    }
  }
  return { manifest, output, error: null };
}

/**
 * The Python CLI (lake_manifest_to_osv.py main()), as a pure
 * result: exit code, stdout and stderr strings. The caller prints
 * them. Defaults are the files of the repository root given.
 */
export function runLakeToOsv(argv: string[], repoRoot = "."): CliResult {
  const args = parseOsvArgs(argv);
  if (args.error !== null) {
    return {
      exitCode: 2,
      stdout: "",
      stderr: `lake_manifest_to_osv.py: ${args.error}\n`,
    };
  }
  try {
    const inputs = loadWorkspaceInputs(repoRoot, args.manifest);
    const result = convertManifest(
      inputs.manifest,
      inputs.lakefile,
      inputs.toolchain,
      inputs.workspace,
    );
    const encoded = osvJson(result);
    const output = args.output ?? joinPath(repoRoot, "lake-osv-scanner.json");
    Deno.writeTextFileSync(output, encoded);
    const count = result.results[0].packages.length;
    return {
      exitCode: 0,
      stdout: osvSuccessMessage(count, output) + "\n",
      stderr: "",
    };
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    return {
      exitCode: 1,
      stdout: "",
      stderr: `lake_manifest_to_osv.py: ${message}\n`,
    };
  }
}
