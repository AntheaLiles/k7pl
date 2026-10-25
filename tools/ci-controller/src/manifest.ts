// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Lake manifest check, ported faithfully from
 * scripts/ci/check_manifest.py (same allow-lists, same checks,
 * same error messages where the runtime allows, same exit
 * codes). Do NOT "fix" divergences here: parity with the Python
 * script is the contract, and any behaviour change is a
 * separate, owner-approved decision.
 *
 * The manifest is treated as untrusted data: every value taken
 * from parsed JSON is validated at runtime before use, never
 * trusted by shape. The network checks (`--check-tags`,
 * `--check-upstream`) are implemented for the root workspace
 * only, exactly as in the Python script.
 *
 * Wiring: this module is not referenced by src/main.ts yet.
 * The parent wires it later as a `check-manifest` command by
 * calling {@link runCheckManifestCommand} with the CLI
 * arguments (its return value is the process exit code), or by
 * calling {@link runCheckManifest} directly. Running this file
 * itself (`deno run src/manifest.ts ...`) also works.
 *
 * Known divergences from the Python script (runtime, not
 * contract, differences):
 * - Operating-system error text differs (Deno messages instead
 *   of Python's "[Errno 2] ..." strings); the exit code and the
 *   "is not a regular file" / "is not valid JSON" prefixes are
 *   the same.
 * - A malformed upstream manifest yields a JavaScript
 *   JSON.parse message instead of Python's json message; the
 *   "could not read the upstream lake-manifest.json" prefix is
 *   the same.
 * - A failing `git ls-remote` raises an Error carrying the exit
 *   status and stderr, where Python raises CalledProcessError;
 *   the "could not query tag ..." prefix is the same.
 * - `checkUpstream` skips a direct dependency whose name is not
 *   a string instead of raising Python's TypeError for an
 *   unhashable set member; such a manifest already fails the
 *   offline checks, so this path is unreachable for a manifest
 *   that passed `verifyTags` cleanly.
 */

// The only packages that may appear in the manifest, with the only repository each may come from
// (GitHub, HTTPS). A new transitive dependency makes the check fail until a human adds it here.
export const ALLOWED_PACKAGES: Readonly<Record<string, string>> = {
  mathlib: "leanprover-community/mathlib4",
  cslib: "leanprover/cslib",
  verso: "leanprover/verso",
  plausible: "leanprover-community/plausible",
  LeanSearchClient: "leanprover-community/LeanSearchClient",
  importGraph: "leanprover-community/import-graph",
  proofwidgets: "leanprover-community/ProofWidgets4",
  aesop: "leanprover-community/aesop",
  Qq: "leanprover-community/quote4",
  batteries: "leanprover-community/batteries",
  Cli: "leanprover/lean4-cli",
  illuminate: "leanprover/illuminate",
  MD4Lean: "acmepjz/md4lean",
  subverso: "leanprover/subverso",
};
export const ALLOWED_REPOSITORIES: ReadonlySet<string> = new Set(
  Object.values(ALLOWED_PACKAGES),
);
export const ALLOWED_HOST = "github.com";
export const RAW_HOST = "raw.githubusercontent.com";
export const PACKAGES_DIR = ".lake/packages";
export const CONFIG_FILES: ReadonlySet<string> = new Set([
  "lakefile.lean",
  "lakefile.toml",
]);
export const MANIFEST_FILE = "lake-manifest.json";
export const LAKE_DIR = ".lake";
// A manifest is a few kilobytes; refuse anything absurd before parsing untrusted JSON.
export const MAX_MANIFEST_BYTES = 1 << 20;

export const TOP_LEVEL_KEYS: ReadonlySet<string> = new Set([
  "version",
  "packagesDir",
  "packages",
  "name",
  "lakeDir",
  "fixedToolchain",
]);
export const PACKAGE_KEYS: ReadonlySet<string> = new Set([
  "configFile",
  "inherited",
  "inputRev",
  "manifestFile",
  "name",
  "rev",
  "scope",
  "subDir",
  "type",
  "url",
]);

const REV_RE = /[0-9a-f]{40}/;
const MANIFEST_VERSION_RE = /[0-9]+(?:\.[0-9]+)+/;
const NAME_RE = /[A-Za-z0-9._-]+/;
const SEGMENT_RE = /[A-Za-z0-9][A-Za-z0-9._-]*/;
const TAG_RE = /[A-Za-z0-9][A-Za-z0-9._-]*/;
const PATH_RE = /[A-Za-z0-9._/-]+/;
const INPUT_REV_RE = /[A-Za-z0-9][A-Za-z0-9._/-]*/;
const TOOLCHAIN_RE =
  /leanprover\/lean4:(v[0-9]+\.[0-9]+\.[0-9]+(?:-rc[0-9]+)?)/;
const REQUIRE_RE =
  /^require\s+(\S+)\s+from\s+git\s+"([^"]+)"(?:\s+@\s+"([^"]+)")?/gm;
const REQUIRE_ANY_RE = /^require\b/gm;
const PACKAGE_DECL_RE = /^package\s+(\S+)/gm;

// Direct dependencies that `scripts/bump-lean.sh` keeps on the toolchain release.
export const TOOLCHAIN_PINNED: readonly string[] = [
  "mathlib",
  "cslib",
  "verso",
];

// The isolated Lake workspace of the Paperproof extractor (see the README.md of that directory).
// Its packages, taken from its manifest as of commit cc835b2 (13 October 2026): Paperproof (pinned
// by commit), Mathlib (pinned to its own lean-toolchain release) and the packages Mathlib brings.
// The names it shares with the root workspace are bound to the same repositories.
export const PAPERPROOF_DIRECTORY = "tools/paperproof-export";
export const PAPERPROOF_ALLOWED_PACKAGES: Readonly<Record<string, string>> = {
  Paperproof: "Paper-Proof/paperproof",
  mathlib: ALLOWED_PACKAGES["mathlib"],
  plausible: ALLOWED_PACKAGES["plausible"],
  LeanSearchClient: ALLOWED_PACKAGES["LeanSearchClient"],
  importGraph: ALLOWED_PACKAGES["importGraph"],
  proofwidgets: ALLOWED_PACKAGES["proofwidgets"],
  aesop: ALLOWED_PACKAGES["aesop"],
  Qq: ALLOWED_PACKAGES["Qq"],
  batteries: ALLOWED_PACKAGES["batteries"],
  Cli: ALLOWED_PACKAGES["Cli"],
};

export interface Workspace {
  /** Relative to the repository root; "." for the root workspace. */
  directory: string;
  /** Package name -> the only GitHub "owner/repo" it may use. */
  allowedPackages: Readonly<Record<string, string>>;
  /** Direct dependencies required on the lean-toolchain release. */
  toolchainPinned: readonly string[];
  /** Where a human accepts a new package (printed in the hint). */
  allowListName: string;
}

export function allowedRepositories(workspace: Workspace): Set<string> {
  return new Set(Object.values(workspace.allowedPackages));
}

export function isRootWorkspace(workspace: Workspace): boolean {
  return workspace.directory === ".";
}

export function manifestLabel(workspace: Workspace): string {
  return isRootWorkspace(workspace)
    ? MANIFEST_FILE
    : `${workspace.directory}/${MANIFEST_FILE}`;
}

export const ROOT_WORKSPACE: Workspace = {
  directory: ".",
  allowedPackages: ALLOWED_PACKAGES,
  toolchainPinned: TOOLCHAIN_PINNED,
  allowListName: "ALLOWED_PACKAGES",
};
export const PAPERPROOF_WORKSPACE: Workspace = {
  directory: PAPERPROOF_DIRECTORY,
  allowedPackages: PAPERPROOF_ALLOWED_PACKAGES,
  toolchainPinned: ["mathlib"],
  allowListName: "PAPERPROOF_ALLOWED_PACKAGES",
};
export const WORKSPACES: readonly Workspace[] = [
  ROOT_WORKSPACE,
  PAPERPROOF_WORKSPACE,
];

// (url, tag) -> `git ls-remote` output lines, "<sha>\t<ref>".
export type LsRemote = (
  url: string,
  tag: string,
) => Promise<string[]> | string[];
// URL -> response body.
export type Fetch = (
  url: string,
) => Promise<Uint8Array | string> | Uint8Array | string;

/** True when `value` matches `pattern` in full (Python re.fullmatch). */
function fullmatch(pattern: RegExp, value: string): boolean {
  const anchored = new RegExp(
    `^(?:${pattern.source})$`,
    pattern.flags.replace(/[gm]/g, ""),
  );
  const match = anchored.exec(value);
  return match !== null && match[0] === value;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null &&
    !Array.isArray(value);
}

/**
 * Python repr() of a value, as used in the error messages.
 * Missing JSON fields arrive as `undefined` here and are
 * rendered as `None`, matching Python's dict.get() default.
 */
export function pythonRepr(value: unknown): string {
  if (value === null || value === undefined) return "None";
  if (typeof value === "boolean") return value ? "True" : "False";
  if (typeof value === "number") {
    return Number.isInteger(value) ? String(value) : String(value);
  }
  if (typeof value === "string") {
    const escaped = [...value].map((ch) => {
      if (ch === "\\") return "\\\\";
      if (ch === "\n") return "\\n";
      if (ch === "\r") return "\\r";
      if (ch === "\t") return "\\t";
      const code = ch.codePointAt(0) ?? 0;
      if (
        code < 0x20 || code === 0x7f ||
        (code > 0x7f && /[\p{C}\p{Z}]/u.test(ch) && ch !== " ")
      ) {
        return code <= 0xff
          ? `\\x${code.toString(16).padStart(2, "0")}`
          : code <= 0xffff
          ? `\\u${code.toString(16).padStart(4, "0")}`
          : `\\U${code.toString(16).padStart(8, "0")}`;
      }
      return ch;
    }).join("");
    if (!escaped.includes("'")) return `'${escaped}'`;
    if (!escaped.includes('"')) return `"${escaped}"`;
    return `'${escaped.replace(/'/g, "\\'")}'`;
  }
  if (Array.isArray(value)) {
    return `[${value.map((item) => pythonRepr(item)).join(", ")}]`;
  }
  if (isRecord(value)) {
    return `{${
      Object.entries(value).map(([k, v]) =>
        `${pythonRepr(k)}: ${pythonRepr(v)}`
      ).join(", ")
    }}`;
  }
  return String(value);
}

/** Python str() of a value: strings pass through, the rest use repr(). */
export function pythonStr(value: unknown): string {
  return typeof value === "string" ? value : pythonRepr(value);
}

/**
 * `text` with every non-printable character (newlines included) replaced by `?`.
 *
 * The messages are printed as GitHub workflow commands (`::error::…`); a newline taken from the
 * untrusted manifest would let it start a command of its own (`::notice::…`, `::add-mask::…`).
 * Python's str.isprintable() rejects Unicode categories Other (C*) and Separator (Z*) except
 * for the ASCII space; the same rule is used here.
 */
export function clean(text: string): string {
  return [...text].map((ch) =>
    ch === " " || !/[\p{C}\p{Z}]/u.test(ch) ? ch : "?"
  ).join("");
}

interface ParsedUrl {
  scheme: string;
  netloc: string;
  hostname: string | null;
  port: number | null;
  path: string;
  query: string;
  fragment: string;
}

/**
 * Python str.strip() over the whitespace set Python strips
 * (str.isspace): the same set the Lean inventory check and the
 * SBOM audit use. JS trim() differs (it strips U+FEFF but not
 * U+001C-U+001F or U+0085), so toolchain text must use this.
 */
export function pythonStrip(text: string): string {
  const isWs = (code: number): boolean =>
    (code >= 0x09 && code <= 0x0d) || (code >= 0x1c && code <= 0x1f) ||
    code === 0x20 || code === 0x85 || code === 0xa0 || code === 0x1680 ||
    (code >= 0x2000 && code <= 0x200a) || code === 0x2028 ||
    code === 0x2029 || code === 0x202f || code === 0x205f || code === 0x3000;
  const chars = [...text];
  let start = 0;
  let end = chars.length;
  while (start < end && isWs(chars[start].codePointAt(0) ?? 0)) start++;
  while (end > start && isWs(chars[end - 1].codePointAt(0) ?? 0)) end--;
  return chars.slice(start, end).join("");
}

/**
 * Split a URL the way Python's urllib.parse.urlsplit does
 * (scheme and host lower-cased, netloc kept as written).
 * Returns null for the port error case: urlsplit().port
 * raises ValueError when the port is not a plain 0-65535
 * integer, which checkUrl reports as "not a valid URL".
 */
function splitUrl(url: string): ParsedUrl | null {
  const schemeMatch = /^([A-Za-z][A-Za-z0-9+.-]*):([\s\S]*)$/.exec(url);
  const scheme = schemeMatch ? schemeMatch[1].toLowerCase() : "";
  let rest = schemeMatch ? schemeMatch[2] : url;
  let netloc = "";
  if (rest.startsWith("//")) {
    rest = rest.slice(2);
    const end = rest.search(/[/?#]/);
    netloc = end === -1 ? rest : rest.slice(0, end);
    rest = end === -1 ? "" : rest.slice(end);
  }
  let path = rest;
  let query = "";
  let fragment = "";
  const hash = rest.indexOf("#");
  if (hash !== -1) {
    fragment = rest.slice(hash + 1);
    path = rest.slice(0, hash);
  } else {
    path = rest;
  }
  const question = path.indexOf("?");
  if (question !== -1) {
    query = path.slice(question + 1);
    path = path.slice(0, question);
  }
  let hostname: string | null = null;
  let port: number | null = null;
  if (netloc !== "") {
    const at = netloc.lastIndexOf("@");
    const hostport = at === -1 ? netloc : netloc.slice(at + 1);
    if (hostport.startsWith("[")) {
      const close = hostport.indexOf("]");
      hostname = close === -1
        ? hostport.slice(1).toLowerCase()
        : hostport.slice(1, close).toLowerCase();
      const after = close === -1 ? "" : hostport.slice(close + 1);
      if (after.startsWith(":")) {
        const portText = after.slice(1);
        if (portText === "") {
          port = null;
        } else if (!/^[0-9]+$/.test(portText)) {
          return null;
        } else {
          const value = Number(portText);
          if (value > 65535) return null;
          port = value;
        }
      }
    } else {
      const colon = hostport.lastIndexOf(":");
      if (colon === -1) {
        hostname = hostport.toLowerCase();
      } else {
        hostname = hostport.slice(0, colon).toLowerCase();
        const portText = hostport.slice(colon + 1);
        if (portText === "") {
          port = null;
        } else if (!/^[0-9]+$/.test(portText)) {
          return null;
        } else {
          const value = Number(portText);
          if (value > 65535) return null;
          port = value;
        }
      }
    }
  }
  return { scheme, netloc, hostname, port, path, query, fragment };
}

/** Errors for a package URL that is not an HTTPS GitHub URL of an allowed repository. */
export function checkUrl(
  label: string,
  url: unknown,
  allowed: ReadonlySet<string> = ALLOWED_REPOSITORIES,
): string[] {
  if (typeof url !== "string") {
    return [`${label}: \`url\` is not a string`];
  }
  const parts = splitUrl(url);
  if (parts === null) {
    return [`${label}: \`url\` is not a valid URL: ${pythonRepr(url)}`];
  }
  const segments = parts.path.split("/");
  const problems: string[] = [];
  if (parts.scheme !== "https") problems.push("the scheme is not https");
  if (
    parts.hostname !== ALLOWED_HOST || parts.netloc !== ALLOWED_HOST ||
    parts.port !== null
  ) {
    problems.push(`the host is not exactly ${ALLOWED_HOST}`);
  }
  // `urlsplit` reports an empty query or fragment ("…repo#", "…repo?") as absent: look at the text.
  if (
    parts.query !== "" || parts.fragment !== "" || url.includes("?") ||
    url.includes("#")
  ) {
    problems.push("it has a query or a fragment");
  }
  if (segments.length !== 3 || segments[0] !== "") {
    problems.push("the path is not /<owner>/<repository>");
  } else {
    const [owner, repo] = [segments[1], segments[2]];
    if (!fullmatch(SEGMENT_RE, repo)) {
      problems.push(
        `the repository name ${pythonRepr(repo)} is not a plain name`,
      );
    } else if (!allowed.has(`${owner}/${repo}`)) {
      problems.push(`the repository ${owner}/${repo} is not in the allow-list`);
    }
  }
  if (problems.length > 0) {
    return [
      `${label}: url ${pythonRepr(url)} rejected: ${problems.join("; ")}`,
    ];
  }
  return [];
}

/** Errors for a field that must be a plain relative path (`..`, absolute paths refused). */
export function checkRelativePath(
  label: string,
  key: string,
  value: unknown,
  optional: boolean,
): string[] {
  if ((value === null || value === undefined) && optional) return [];
  if (typeof value !== "string") {
    return [`${label}: \`${key}\` is not a string`];
  }
  if (key === "scope" && value === "") return [];
  if (
    !fullmatch(PATH_RE, value) || value.startsWith("/") ||
    value.startsWith("-") || value.includes("..")
  ) {
    return [
      `${label}: \`${key}\` must be a plain relative path, got ${
        pythonRepr(value)
      }`,
    ];
  }
  return [];
}

/** Errors for one entry of `packages`. */
export function checkPackage(
  index: number,
  packageValue: unknown,
  seen: Set<string>,
  workspace: Workspace = ROOT_WORKSPACE,
): string[] {
  const allowedPackages = workspace.allowedPackages;
  let label = `packages[${index}]`;
  if (!isRecord(packageValue)) {
    return [`${label} is not an object`];
  }
  const package_ = packageValue;
  const errors: string[] = [];
  const name = package_["name"];
  if (typeof name !== "string" || !fullmatch(NAME_RE, name)) {
    errors.push(
      `${label}: \`name\` must match [A-Za-z0-9._-]+, got ${pythonRepr(name)}`,
    );
  } else {
    label = name;
    if (seen.has(name)) errors.push(`${label}: duplicate package`);
    seen.add(name);
    if (!(name in allowedPackages)) {
      errors.push(
        `${label}: not one of the known packages (an extra package?)`,
      );
    }
  }
  const unknown = Object.keys(package_).filter((key) => !PACKAGE_KEYS.has(key))
    .sort();
  if (unknown.length > 0) {
    errors.push(`${label}: unknown key(s) ${pythonRepr(unknown)}`);
  }
  if (package_["type"] !== "git") {
    errors.push(
      `${label}: \`type\` must be 'git', got ${pythonRepr(package_["type"])}`,
    );
  }
  if (typeof package_["inherited"] !== "boolean") {
    errors.push(
      `${label}: \`inherited\` must be a boolean, got ${
        pythonRepr(package_["inherited"])
      }`,
    );
  }
  const rev = package_["rev"];
  if (typeof rev !== "string" || !fullmatch(REV_RE, rev)) {
    errors.push(
      `${label}: \`rev\` must be 40 lowercase hexadecimal digits, got ${
        pythonRepr(rev)
      }`,
    );
  }
  errors.push(
    ...checkUrl(label, package_["url"], allowedRepositories(workspace)),
  );
  const expected = typeof name === "string" ? allowedPackages[name] : undefined;
  const url = package_["url"];
  if (
    expected !== undefined && typeof url === "string" &&
    url !== `https://${ALLOWED_HOST}/${expected}`
  ) {
    errors.push(
      `${label}: url ${
        pythonRepr(url)
      } is not the repository of this package (${expected})`,
    );
  }
  const inputRev = package_["inputRev"];
  if (
    inputRev !== null && inputRev !== undefined &&
    (typeof inputRev !== "string" || !fullmatch(INPUT_REV_RE, inputRev) ||
      inputRev.startsWith("refs/") || inputRev.includes(".."))
  ) {
    errors.push(
      `${label}: \`inputRev\` must be a plain name that does not start with refs/, got ${
        pythonRepr(inputRev)
      }`,
    );
  }
  errors.push(...checkRelativePath(label, "subDir", package_["subDir"], true));
  errors.push(
    ...checkRelativePath(label, "configFile", package_["configFile"], false),
  );
  errors.push(
    ...checkRelativePath(
      label,
      "manifestFile",
      package_["manifestFile"],
      false,
    ),
  );
  errors.push(...checkRelativePath(label, "scope", package_["scope"], false));
  const configFile = package_["configFile"];
  if (typeof configFile === "string" && !CONFIG_FILES.has(configFile)) {
    errors.push(
      `${label}: \`configFile\` must be one of ${
        pythonRepr([...CONFIG_FILES].sort())
      }, got ${pythonRepr(clean(configFile))}`,
    );
  }
  const manifestFile = package_["manifestFile"];
  if (typeof manifestFile === "string" && manifestFile !== MANIFEST_FILE) {
    errors.push(
      `${label}: \`manifestFile\` must be ${pythonRepr(MANIFEST_FILE)}, got ${
        pythonRepr(clean(manifestFile))
      }`,
    );
  }
  return errors;
}

/** Structural checks of the manifest alone (no lakefile, no toolchain, no network). */
export function checkManifest(
  manifest: unknown,
  workspace: Workspace = ROOT_WORKSPACE,
): string[] {
  if (!isRecord(manifest)) {
    return ["the manifest is not a JSON object"];
  }
  const errors: string[] = [];
  const unknown = Object.keys(manifest).filter((key) =>
    !TOP_LEVEL_KEYS.has(key)
  ).sort();
  if (unknown.length > 0) {
    errors.push(`unknown top-level key(s) ${pythonRepr(unknown)}`);
  }
  if (manifest["packagesDir"] !== PACKAGES_DIR) {
    errors.push(
      `\`packagesDir\` must be ${pythonRepr(PACKAGES_DIR)}, got ${
        pythonRepr(manifest["packagesDir"])
      }`,
    );
  }
  if (manifest["lakeDir"] !== LAKE_DIR) {
    errors.push(
      `\`lakeDir\` must be ${pythonRepr(LAKE_DIR)}, got ${
        pythonRepr(manifest["lakeDir"])
      }`,
    );
  }
  const name = manifest["name"];
  if (typeof name !== "string" || !fullmatch(NAME_RE, name)) {
    errors.push(
      `\`name\` must match [A-Za-z0-9._-]+, got ${pythonRepr(name)}`,
    );
  }
  if ("version" in manifest) {
    const version = manifest["version"];
    if (
      typeof version !== "string" || !fullmatch(MANIFEST_VERSION_RE, version)
    ) {
      errors.push(
        `\`version\` must be dotted numbers such as 1.2.0, got ${
          pythonRepr(clean(pythonStr(version)))
        }`,
      );
    }
  }
  if (
    "fixedToolchain" in manifest &&
    typeof manifest["fixedToolchain"] !== "boolean"
  ) {
    errors.push(
      `\`fixedToolchain\` must be a boolean, got ${
        pythonRepr(clean(pythonStr(manifest["fixedToolchain"])))
      }`,
    );
  }
  const packages = manifest["packages"];
  if (!Array.isArray(packages) || packages.length === 0) {
    errors.push("`packages` is missing, empty or not a list");
    return errors;
  }
  const seen = new Set<string>();
  packages.forEach((packageValue, index) => {
    errors.push(...checkPackage(index, packageValue, seen, workspace));
  });
  return errors;
}

/** The release named by `lean-toolchain` (e.g. `v4.34.0`), or null when it is not recognised. */
export function parseToolchain(text: string): string | null {
  const anchored = new RegExp(`^(?:${TOOLCHAIN_RE.source})$`);
  const match = anchored.exec(pythonStrip(text));
  return match ? match[1] : null;
}

/** The `require <name> from git "<url>" @ "<rev>"` declarations, and the number of `require`s. */
export function parseRequires(
  lakefile: string,
): { requires: Array<[string, string, string]>; total: number } {
  const requires: Array<[string, string, string]> = [];
  for (const match of lakefile.matchAll(REQUIRE_RE)) {
    // An unmatched `@ "..."` group is "" in Python's findall, not null.
    requires.push([match[1], match[2], match[3] ?? ""]);
  }
  let total = 0;
  for (const _match of lakefile.matchAll(REQUIRE_ANY_RE)) total++;
  return { requires, total };
}

/** Cross-checks between the manifest, `lakefile.lean` and `lean-toolchain`. */
export function checkConsistency(
  manifest: Record<string, unknown>,
  lakefile: string,
  toolchain: string,
  workspace: Workspace = ROOT_WORKSPACE,
): string[] {
  const errors: string[] = [];
  const allowedPackages = workspace.allowedPackages;
  const release = parseToolchain(toolchain);
  if (release === null) {
    errors.push(
      `lean-toolchain: unrecognised content ${
        pythonRepr(pythonStrip(toolchain))
      }`,
    );
  }
  const declared: string[] = [];
  for (const match of lakefile.matchAll(PACKAGE_DECL_RE)) {
    declared.push(match[1]);
  }
  if (declared.length !== 1) {
    errors.push(
      `lakefile.lean: expected one \`package\` declaration, found ${declared.length}`,
    );
  } else if (manifest["name"] !== declared[0]) {
    errors.push(
      `manifest \`name\` ${pythonRepr(manifest["name"])} != lakefile package ${
        pythonRepr(declared[0])
      }`,
    );
  }
  const { requires, total } = parseRequires(lakefile);
  if (requires.length !== total) {
    errors.push(
      `lakefile.lean: ${
        total - requires.length
      } \`require\` declaration(s) are not of the form ` +
        '`require <name> from git "<url>" @ "<tag>"`',
    );
  }
  const byName = new Map<string, [string, string]>();
  for (const [name, url, rev] of requires) byName.set(name, [url, rev]);
  for (const name of workspace.toolchainPinned) {
    if (!byName.has(name)) {
      errors.push(`lakefile.lean: missing \`require ${name}\``);
    } else {
      const entry = byName.get(name)!;
      if (release !== null && entry[1] !== release) {
        errors.push(
          `lakefile.lean: \`require ${name}\` is pinned to ${
            pythonRepr(entry[1])
          } but lean-toolchain is ${pythonRepr(release)}`,
        );
      }
    }
  }
  const rawPackages = manifest["packages"];
  const packageList: unknown[] = Array.isArray(rawPackages) ? rawPackages : [];
  const packages = new Map<string, Record<string, unknown>>();
  for (const p of packageList) {
    if (isRecord(p) && typeof p["name"] === "string") {
      packages.set(p["name"], p);
    }
  }
  for (const [name, url, rev] of requires) {
    const label = `lakefile.lean \`require ${name}\``;
    errors.push(...checkUrl(label, url, allowedRepositories(workspace)));
    if (!(name in allowedPackages)) {
      errors.push(`${label}: not one of the known packages`);
    } else if (url !== `https://${ALLOWED_HOST}/${allowedPackages[name]}`) {
      errors.push(
        `${label}: url ${
          pythonRepr(url)
        } is not the repository of this package`,
      );
    }
    const package_ = packages.get(name);
    if (package_ === undefined) {
      errors.push(
        `manifest: no package named ${
          pythonRepr(name)
        } for the lakefile requirement`,
      );
      continue;
    }
    if (package_["url"] !== url) {
      errors.push(
        `${name}: manifest url ${pythonRepr(package_["url"])} != lakefile url ${
          pythonRepr(url)
        }`,
      );
    }
    if (package_["inputRev"] !== rev) {
      errors.push(
        `${name}: manifest inputRev ${
          pythonRepr(package_["inputRev"])
        } != lakefile tag ${pythonRepr(rev)}`,
      );
    }
    if (package_["inherited"] !== false) {
      errors.push(
        `${name}: a direct dependency must have \`inherited: false\``,
      );
    }
    // A requirement pinned to a commit leaves nothing to resolve: the manifest must hold it.
    if (fullmatch(REV_RE, rev) && package_["rev"] !== rev) {
      errors.push(
        `${name}: manifest rev ${pythonRepr(package_["rev"])} != the commit ${
          pythonRepr(rev)
        } required by lakefile.lean`,
      );
    }
  }
  const direct = new Set<string>();
  for (const [name, p] of packages) {
    if (p["inherited"] === false) direct.add(name);
  }
  for (const name of [...direct].filter((n) => !byName.has(n)).sort()) {
    errors.push(
      `${name}: not inherited, but no \`require\` of lakefile.lean names it`,
    );
  }
  return errors;
}

/** `git ls-remote --tags` for one tag, plain and peeled; the caller validated `url` and `tag`. */
export async function gitLsRemoteTag(
  url: string,
  tag: string,
): Promise<string[]> {
  const command = new Deno.Command("git", {
    args: [
      "ls-remote",
      "--tags",
      url,
      `refs/tags/${tag}`,
      `refs/tags/${tag}^{}`,
    ],
    stdin: "null",
    stdout: "piped",
    stderr: "piped",
    env: { GIT_TERMINAL_PROMPT: "0" },
    signal: AbortSignal.timeout(120_000),
  });
  const { code, stdout, stderr } = await command.output();
  if (code !== 0) {
    const detail = new TextDecoder().decode(stderr).trim();
    throw new Error(
      `git ls-remote ${url} failed with exit status ${code}: ${detail}`,
    );
  }
  const text = new TextDecoder().decode(stdout);
  return text === "" ? [] : text.split("\n").filter((line) => line !== "");
}

/** Errors, and the names of the direct dependencies whose `rev` is the commit of their tag. */
export async function verifyTags(
  manifest: Record<string, unknown>,
  lsRemote: LsRemote,
  workspace: Workspace = ROOT_WORKSPACE,
): Promise<{ errors: string[]; verified: Set<string> }> {
  const errors: string[] = [];
  const verified = new Set<string>();
  const rawPackages = manifest["packages"];
  const packageList: unknown[] = Array.isArray(rawPackages) ? rawPackages : [];
  for (const packageValue of packageList) {
    if (!isRecord(packageValue) || packageValue["inherited"] !== false) {
      continue;
    }
    const name = packageValue["name"];
    const url = packageValue["url"];
    const tag = packageValue["inputRev"];
    const rev = packageValue["rev"];
    if (
      checkUrl(pythonStr(name), url, allowedRepositories(workspace)).length > 0
    ) {
      errors.push(
        `${
          pythonStr(name)
        }: not querying a url that failed the allow-list check`,
      );
      continue;
    }
    if (typeof tag !== "string" || !fullmatch(TAG_RE, tag)) {
      errors.push(
        `${pythonStr(name)}: inputRev ${
          pythonRepr(tag)
        } is not a plain tag name`,
      );
      continue;
    }
    let lines: string[];
    try {
      lines = await lsRemote(String(url), tag);
    } catch (error) {
      errors.push(
        `${pythonStr(name)}: could not query tag ${pythonRepr(tag)} upstream: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      continue;
    }
    const refs = new Map<string, string>();
    for (const line of lines) {
      const tab = line.indexOf("\t");
      const sha = tab === -1 ? line : line.slice(0, tab);
      const ref = tab === -1 ? "" : line.slice(tab + 1);
      refs.set(ref, sha);
    }
    const peeled = refs.get(`refs/tags/${tag}^{}`);
    const upstream = peeled ? peeled : refs.get(`refs/tags/${tag}`);
    if (upstream === undefined) {
      errors.push(
        `${pythonStr(name)}: tag ${pythonRepr(tag)} not found upstream`,
      );
    } else if (upstream !== rev) {
      errors.push(
        `${pythonStr(name)}: rev ${
          pythonStr(rev)
        } != upstream commit ${upstream} of tag ${pythonRepr(tag)}`,
      );
    } else {
      verified.add(pythonStr(name));
    }
  }
  return { errors, verified };
}

/**
 * Compare the `rev` of each direct dependency with the upstream commit of its tag.
 *
 * An annotated tag is compared through its peeled commit (`^{}`); a lightweight tag, which has no
 * peeled line, through the ref itself. Both forms occur upstream (Mathlib, CSLib and Verso use
 * lightweight tags at the time of writing).
 */
export async function checkTags(
  manifest: Record<string, unknown>,
  lsRemote: LsRemote = gitLsRemoteTag,
  workspace: Workspace = ROOT_WORKSPACE,
): Promise<string[]> {
  return (await verifyTags(manifest, lsRemote, workspace)).errors;
}

/** GET a `lake-manifest.json` from raw.githubusercontent.com (https only, size bounded). */
export async function fetchUpstreamManifest(url: string): Promise<Uint8Array> {
  const match = /^https:\/\/([^/?#]+)(\/[\s\S]*)?$/.exec(url);
  if (match === null || match[1] !== RAW_HOST) {
    throw new Error(`refusing to fetch ${pythonRepr(url)}`);
  }
  const response = await fetch(url, {
    headers: { "User-Agent": "k7pl-check-manifest" },
    signal: AbortSignal.timeout(60_000),
  });
  if (!response.ok) {
    throw new Error(`HTTP Error ${response.status}: ${response.statusText}`);
  }
  if (response.body === null) return new Uint8Array(0);
  const reader = response.body.getReader();
  const chunks: Uint8Array[] = [];
  let total = 0;
  try {
    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      if (value) {
        chunks.push(value);
        total += value.length;
        if (total > MAX_MANIFEST_BYTES) {
          await reader.cancel();
          throw new Error(
            `${url} is larger than ${MAX_MANIFEST_BYTES} bytes`,
          );
        }
      }
    }
  } finally {
    reader.releaseLock();
  }
  const body = new Uint8Array(total);
  let offset = 0;
  for (const chunk of chunks) {
    body.set(chunk, offset);
    offset += chunk.length;
  }
  return body;
}

/** Where upstream committed `lake-manifest.json` at `rev`; both come from the checked manifest. */
export function upstreamManifestUrl(url: string, rev: string): string {
  const parts = splitUrl(url);
  const path = parts === null ? "" : parts.path;
  const segments = path.replace(/^\/+|\/+$/g, "").split("/");
  if (segments.length !== 2) {
    throw new Error(
      `cannot build an upstream manifest URL from ${pythonRepr(url)}`,
    );
  }
  const [owner, repo] = segments;
  return `https://${RAW_HOST}/${owner}/${repo}/${rev}/lake-manifest.json`;
}

/**
 * Compare the inherited packages with the manifests of the verified direct dependencies.
 *
 * `verified` holds the names of the direct dependencies whose `rev` was matched to their upstream
 * tag: only those manifests are trusted. Every inherited package must be listed, with the same
 * name, URL and `rev`, by at least one of them; a package nobody lists is refused.
 */
export async function checkUpstream(
  manifest: Record<string, unknown>,
  verified: Set<string>,
  fetch: Fetch = fetchUpstreamManifest,
  workspace: Workspace = ROOT_WORKSPACE,
): Promise<string[]> {
  const errors: string[] = [];
  const listed: Array<[string, string, string]> = [];
  const rawPackages = manifest["packages"];
  const packages: Record<string, unknown>[] = Array.isArray(rawPackages)
    ? rawPackages.filter((p): p is Record<string, unknown> => isRecord(p))
    : [];
  for (const packageValue of packages) {
    const name = packageValue["name"];
    const url = packageValue["url"];
    const rev = packageValue["rev"];
    if (
      packageValue["inherited"] !== false || typeof name !== "string" ||
      !verified.has(name)
    ) {
      continue;
    }
    const invalidUrl =
      checkUrl(pythonStr(name), url, allowedRepositories(workspace)).length > 0;
    if (
      invalidUrl || typeof rev !== "string" || !fullmatch(REV_RE, rev)
    ) {
      errors.push(
        `${
          pythonStr(name)
        }: not fetching the upstream manifest of an invalid url or rev`,
      );
      continue;
    }
    let document: unknown;
    try {
      const body = await fetch(upstreamManifestUrl(String(url), rev));
      const text = typeof body === "string"
        ? body
        : new TextDecoder("utf-8", { fatal: true }).decode(body);
      document = parseJsonBounded(text);
    } catch (error) {
      errors.push(
        `${
          pythonStr(name)
        }: could not read the upstream lake-manifest.json at ${rev}: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      continue;
    }
    const entries = isRecord(document) ? document["packages"] : null;
    if (!Array.isArray(entries)) {
      errors.push(
        `${
          pythonStr(name)
        }: the upstream lake-manifest.json at ${rev} has no package list`,
      );
      continue;
    }
    for (const entry of entries) {
      if (
        isRecord(entry) && typeof entry["name"] === "string" &&
        typeof entry["url"] === "string" && typeof entry["rev"] === "string"
      ) {
        listed.push([
          entry["name"] as string,
          entry["url"] as string,
          entry["rev"] as string,
        ]);
      }
    }
  }
  for (const packageValue of packages) {
    if (packageValue["inherited"] !== true) continue;
    const name = packageValue["name"];
    const url = packageValue["url"];
    const rev = packageValue["rev"];
    const sameName = listed.filter(([n]) => n === name).map((
      [, u, r],
    ) => [u, r]);
    if (sameName.length === 0) {
      errors.push(
        `${
          pythonStr(name)
        }: not listed by the manifest of any verified direct dependency`,
      );
    } else if (
      !sameName.some(([u, r]) => u === url && r === rev)
    ) {
      const seen = [...new Set(sameName.map(([u, r]) => `${u} @ ${r}`))].join(
        ", ",
      );
      errors.push(
        `${pythonStr(name)}: url ${pythonRepr(url)} / rev ${
          pythonRepr(rev)
        } differ from upstream (${seen})`,
      );
    }
  }
  return errors;
}

/**
 * Parse JSON with an explicit nesting cap.
 *
 * Python's json module refuses deeply nested input with
 * RecursionError (its decoder recurses per level); V8's
 * JSON.parse does not, so the cap is enforced here instead.
 * The exact threshold is a port choice, not a Python
 * behaviour: a real manifest nests only a few levels, and
 * anything past 1000 levels is refused cleanly rather than
 * trusted or crashed on.
 */
const MAX_JSON_DEPTH = 1000;

function parseJsonBounded(text: string): unknown {
  const value = JSON.parse(text);
  const stack: Array<{ value: unknown; depth: number }> = [{ value, depth: 0 }];
  while (stack.length > 0) {
    const { value: current, depth } = stack.pop()!;
    if (depth > MAX_JSON_DEPTH) {
      throw new Error(`nesting deeper than ${MAX_JSON_DEPTH} levels`);
    }
    if (Array.isArray(current)) {
      for (const item of current) stack.push({ value: item, depth: depth + 1 });
    } else if (isRecord(current)) {
      for (const item of Object.values(current)) {
        stack.push({ value: item, depth: depth + 1 });
      }
    }
  }
  return value;
}

/** Parse the manifest; refuse oversized, unreadable or non-JSON input with a clear message. */
export function loadManifest(path: string): unknown {
  let stat: Deno.FileInfo;
  try {
    stat = Deno.lstatSync(path);
  } catch {
    throw new Error(`${path} is not a regular file`);
  }
  if (stat.isSymlink || !stat.isFile) {
    throw new Error(`${path} is not a regular file`);
  }
  if (stat.size > MAX_MANIFEST_BYTES) {
    throw new Error(`${path} is larger than ${MAX_MANIFEST_BYTES} bytes`);
  }
  const bytes = Deno.readFileSync(path);
  let text: string;
  try {
    text = new TextDecoder("utf-8", { fatal: true }).decode(bytes);
  } catch (error) {
    throw new Error(
      `${path} is not valid JSON: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  }
  try {
    return parseJsonBounded(text);
  } catch (error) {
    throw new Error(
      `${path} is not valid JSON: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  }
}

function normalizePosixPath(path: string): string {
  const absolute = path.startsWith("/");
  const out: string[] = [];
  for (const segment of path.split("/")) {
    if (segment === "" || segment === ".") continue;
    if (segment === "..") {
      if (out.length > 0 && out[out.length - 1] !== "..") out.pop();
      else if (!absolute) out.push("..");
      continue;
    }
    out.push(segment);
  }
  const joined = out.join("/");
  if (absolute) return `/${joined}`;
  return joined === "" ? "." : joined;
}

function resolvePath(path: string): string {
  if (path.startsWith("/")) return normalizePosixPath(path);
  return normalizePosixPath(`${Deno.cwd()}/${path}`);
}

function joinPath(...parts: string[]): string {
  return normalizePosixPath(parts.filter((p) => p !== "").join("/"));
}

function realPathOrResolve(path: string): string {
  try {
    return Deno.realPathSync(path);
  } catch {
    return resolvePath(path);
  }
}

/**
 * The workspace whose rules apply to `manifestPath`, chosen by its location only.
 *
 * A manifest that is the `lake-manifest.json` of a known workspace directory under `root` gets
 * that workspace; anything else (no path, the root manifest, an untrusted artifact elsewhere)
 * gets the root workspace. The manifest's content never selects its own rules.
 */
export function workspaceFor(
  root: string,
  manifestPath: string | null,
): Workspace {
  if (manifestPath !== null) {
    const given = realPathOrResolve(manifestPath);
    for (const workspace of WORKSPACES) {
      if (isRootWorkspace(workspace)) continue;
      const candidate = realPathOrResolve(
        joinPath(root, workspace.directory, MANIFEST_FILE),
      );
      if (given === candidate) return workspace;
    }
  }
  return ROOT_WORKSPACE;
}

/**
 * The manifest itself when it passes the offline checks of its workspace; throws otherwise.
 *
 * Shared by the converters (`lake_manifest_to_osv.py`, `lake_manifest_to_spdx.py`), which must
 * only ever convert a manifest that this script would accept.
 */
export function validatedManifest(
  manifest: unknown,
  lakefile: string,
  toolchain: string,
  workspace: Workspace = ROOT_WORKSPACE,
): Record<string, unknown> {
  const errors = checkManifest(manifest, workspace);
  if (errors.length > 0) {
    throw new Error(
      "invalid Lake manifest:\n" + errors.map((e) => `- ${e}`).join("\n"),
    );
  }
  if (!isRecord(manifest)) {
    throw new Error(
      "invalid Lake manifest:\n- the manifest is not a JSON object",
    );
  }
  const consistencyErrors = checkConsistency(
    manifest,
    lakefile,
    toolchain,
    workspace,
  );
  if (consistencyErrors.length > 0) {
    throw new Error(
      "inconsistent Lake inputs:\n" +
        consistencyErrors.map((e) => `- ${e}`).join("\n"),
    );
  }
  return manifest;
}

export interface WorkspaceInputs {
  workspace: Workspace;
  manifest: unknown;
  lakefile: string;
  toolchain: string;
}

/**
 * Read a manifest (bounded, regular file, JSON) and the files of its workspace.
 *
 * `lakefilePath` and `toolchainPath` default to the files of the workspace the manifest
 * belongs to (see {@link workspaceFor}). Throws on unreadable files or invalid input.
 */
export function loadWorkspaceInputs(
  root: string,
  manifestPath: string | null = null,
  lakefilePath: string | null = null,
  toolchainPath: string | null = null,
): WorkspaceInputs {
  const workspace = workspaceFor(root, manifestPath);
  const directory = isRootWorkspace(workspace)
    ? root
    : joinPath(root, workspace.directory);
  const manifest = loadManifest(
    manifestPath ?? joinPath(directory, MANIFEST_FILE),
  );
  const lakefile = Deno.readTextFileSync(
    lakefilePath ?? joinPath(directory, "lakefile.lean"),
  );
  const toolchain = Deno.readTextFileSync(
    toolchainPath ?? joinPath(directory, "lean-toolchain"),
  );
  return { workspace, manifest, lakefile, toolchain };
}

export interface CheckManifestOptions {
  tags?: boolean;
  upstream?: boolean;
  lsRemote?: LsRemote;
  fetch?: Fetch;
}

/** All errors for the repository rooted at `root`, with an optional manifest override. */
export async function runCheckManifest(
  root: string,
  manifestPath: string | null,
  options: CheckManifestOptions = {},
): Promise<string[]> {
  const tags = options.tags ?? false;
  const upstream = options.upstream ?? false;
  const lsRemote = options.lsRemote ?? gitLsRemoteTag;
  const fetch = options.fetch ?? fetchUpstreamManifest;
  let inputs: WorkspaceInputs;
  try {
    inputs = loadWorkspaceInputs(root, manifestPath);
  } catch (error) {
    return [error instanceof Error ? error.message : String(error)];
  }
  const { workspace, manifest } = inputs;
  if ((tags || upstream) && !isRootWorkspace(workspace)) {
    return [
      `${
        manifestLabel(workspace)
      }: --check-tags and --check-upstream are implemented for the ` +
      "root workspace only",
    ];
  }
  const errors = checkManifest(manifest, workspace);
  if (!isRecord(manifest) || !Array.isArray(manifest["packages"])) {
    return errors; // the structure is too broken for the cross-checks to mean anything
  }
  errors.push(
    ...checkConsistency(manifest, inputs.lakefile, inputs.toolchain, workspace),
  );
  if (tags || upstream) {
    const { errors: tagErrors, verified } = await verifyTags(
      manifest,
      lsRemote,
      workspace,
    );
    errors.push(...tagErrors);
    if (upstream) {
      errors.push(...await checkUpstream(manifest, verified, fetch, workspace));
    }
  }
  return errors;
}

function checkManifestUsage(): string {
  return [
    "Usage:",
    "  check-manifest [--root <dir>] [--manifest <file>] [--check-tags] [--check-upstream]",
  ].join("\n");
}

/**
 * Command line entry point for the future `check-manifest`
 * command; `lsRemote` and `fetch` are replaced by doubles in
 * the tests. Returns the process exit code: 0 when every
 * check passes, 1 when a check fails, 2 on a usage error.
 */
export async function runCheckManifestCommand(
  argv: string[],
  options: { lsRemote?: LsRemote; fetch?: Fetch } = {},
): Promise<number> {
  let root = ".";
  let manifestPath: string | null = null;
  let tags = false;
  let upstream = false;
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i];
    const eq = arg.indexOf("=");
    const flag = eq >= 0 ? arg.slice(0, eq) : arg;
    const inline = eq >= 0 ? arg.slice(eq + 1) : null;
    const takeValue = (): string | null => {
      if (inline !== null) return inline;
      if (i + 1 < argv.length) return argv[++i];
      return null;
    };
    if (flag === "--help" || flag === "-h") {
      console.log(checkManifestUsage());
      return 0;
    } else if (flag === "--root" || flag === "--manifest") {
      const value = takeValue();
      if (value === null) {
        console.error(
          `check-manifest: ${flag} requires a value\n${checkManifestUsage()}`,
        );
        return 2;
      }
      if (flag === "--root") root = value;
      else manifestPath = value;
    } else if (flag === "--check-tags") {
      tags = true;
    } else if (flag === "--check-upstream") {
      upstream = true;
    } else {
      console.error(
        `check-manifest: unknown argument: ${arg}\n${checkManifestUsage()}`,
      );
      return 2;
    }
  }
  const errors = await runCheckManifest(root, manifestPath, {
    tags,
    upstream,
    lsRemote: options.lsRemote,
    fetch: options.fetch,
  });
  const workspace = workspaceFor(root, manifestPath);
  const annotate = Deno.env.get("GITHUB_ACTIONS") === "true";
  for (const error of errors) {
    const message = clean(error);
    console.error(annotate ? `::error::${message}` : `error: ${message}`);
  }
  if (errors.length > 0) {
    console.error(
      `${errors.length} problem(s) found: the manifest must not be used.`,
    );
    if (
      errors.some((error) => error.includes("not one of the known packages"))
    ) {
      console.error(
        "To accept a new dependency after reviewing it, add `name: owner/repo` to " +
          `${workspace.allowListName} in scripts/ci/check_manifest.py (see CONTRIBUTING.md).`,
      );
    }
    return 1;
  }
  const extra = upstream
    ? " (including upstream tags and manifests)"
    : tags
    ? " (including upstream tags)"
    : "";
  console.log(`${manifestLabel(workspace)}: all checks passed${extra}`);
  return 0;
}

if (import.meta.main) {
  Deno.exit(await runCheckManifestCommand(Deno.args));
}
