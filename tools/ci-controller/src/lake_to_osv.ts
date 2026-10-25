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
 * Manifest validation is ported here from scripts/ci/check_manifest.py
 * (offline checks only: structure, allow-list, lakefile/toolchain
 * consistency; no --check-tags / --check-upstream network checks).
 * It lives in this file, and lake_to_spdx.ts imports it, because
 * this slice creates only the three SPDX/SBOM ports: duplicating
 * the validator in both converters, or adding a fourth module,
 * would both be worse. A later slice may split it out unchanged
 * into a check_manifest.ts module; the two converters must keep
 * importing the same validator either way.
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

export const PAPERPROOF_DIRECTORY = "tools/paperproof-export";
export const MANIFEST_FILE = "lake-manifest.json";
export const PACKAGES_DIR = ".lake/packages";
export const LAKE_DIR = ".lake";
export const MAX_MANIFEST_BYTES = 1 << 20;

const CONFIG_FILES = ["lakefile.lean", "lakefile.toml"];

export interface Workspace {
  directory: string;
  allowedPackages: Record<string, string>;
  toolchainPinned: readonly string[];
  allowListName: string;
}

export const ALLOWED_PACKAGES: Record<string, string> = {
  "mathlib": "leanprover-community/mathlib4",
  "cslib": "leanprover/cslib",
  "verso": "leanprover/verso",
  "plausible": "leanprover-community/plausible",
  "LeanSearchClient": "leanprover-community/LeanSearchClient",
  "importGraph": "leanprover-community/import-graph",
  "proofwidgets": "leanprover-community/ProofWidgets4",
  "aesop": "leanprover-community/aesop",
  "Qq": "leanprover-community/quote4",
  "batteries": "leanprover-community/batteries",
  "Cli": "leanprover/lean4-cli",
  "illuminate": "leanprover/illuminate",
  "MD4Lean": "acmepjz/md4lean",
  "subverso": "leanprover/subverso",
};

export const PAPERPROOF_ALLOWED_PACKAGES: Record<string, string> = {
  "Paperproof": "Paper-Proof/paperproof",
  "mathlib": ALLOWED_PACKAGES["mathlib"],
  "plausible": ALLOWED_PACKAGES["plausible"],
  "LeanSearchClient": ALLOWED_PACKAGES["LeanSearchClient"],
  "importGraph": ALLOWED_PACKAGES["importGraph"],
  "proofwidgets": ALLOWED_PACKAGES["proofwidgets"],
  "aesop": ALLOWED_PACKAGES["aesop"],
  "Qq": ALLOWED_PACKAGES["Qq"],
  "batteries": ALLOWED_PACKAGES["batteries"],
  "Cli": ALLOWED_PACKAGES["Cli"],
};

export const ROOT_WORKSPACE: Workspace = {
  directory: ".",
  allowedPackages: ALLOWED_PACKAGES,
  toolchainPinned: ["mathlib", "cslib", "verso"],
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

export function isRootWorkspace(workspace: Workspace): boolean {
  return workspace.directory === ".";
}

export function manifestLabel(workspace: Workspace): string {
  return isRootWorkspace(workspace)
    ? MANIFEST_FILE
    : `${workspace.directory}/${MANIFEST_FILE}`;
}

export type LakePackage = Record<string, unknown>;
export type LakeManifest = Record<string, unknown>;

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null &&
    !Array.isArray(value);
}

/** Python str() for the scalar values that appear in messages. */
export function pyStr(value: unknown): string {
  if (value === null || value === undefined) return "None";
  if (typeof value === "boolean") return value ? "True" : "False";
  if (typeof value === "string") return value;
  if (typeof value === "number") return String(value);
  return JSON.stringify(value) ?? String(value);
}

/** Python repr() for scalars and string lists, as used in messages. */
export function pyRepr(value: unknown): string {
  if (value === null || value === undefined) return "None";
  if (typeof value === "boolean") return value ? "True" : "False";
  if (typeof value === "number") return String(value);
  if (typeof value === "string") {
    return `'${value.replace(/\\/g, "\\\\").replace(/'/g, "\\'")}'`;
  }
  if (Array.isArray(value)) {
    return `[${value.map((item) => pyRepr(item)).join(", ")}]`;
  }
  return pyStr(value);
}

/**
 * Python clean(): every non-printable character replaced by "?".
 * Approximation: control characters (and DEL) are non-printable;
 * all other characters are kept, as in the manifests this guards.
 */
export function cleanText(text: string): string {
  return [...text].map((ch) => {
    const code = ch.codePointAt(0) ?? 0;
    return code < 0x20 || code === 0x7f ? "?" : ch;
  }).join("");
}

/** Python str.strip() over the whitespace set Python strips. */
export function pyStrip(text: string): string {
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

const TOP_LEVEL_KEYS = new Set([
  "version",
  "packagesDir",
  "packages",
  "name",
  "lakeDir",
  "fixedToolchain",
]);
const PACKAGE_KEYS = new Set([
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

const REV_RE = /^[0-9a-f]{40}$/;
const MANIFEST_VERSION_RE = /^[0-9]+(?:\.[0-9]+)+$/;
const NAME_RE = /^[A-Za-z0-9._-]+$/;
const SEGMENT_RE = /^[A-Za-z0-9][A-Za-z0-9._-]*$/;
const PATH_RE = /^[A-Za-z0-9._/-]+$/;
const INPUT_REV_RE = /^[A-Za-z0-9][A-Za-z0-9._/-]*$/;
const TOOLCHAIN_RE =
  /^leanprover\/lean4:(v[0-9]+\.[0-9]+\.[0-9]+(?:-rc[0-9]+)?)$/;

function allowedRepositories(workspace: Workspace): Set<string> {
  return new Set(Object.values(workspace.allowedPackages));
}

export function checkUrl(
  label: string,
  url: unknown,
  allowed: Set<string>,
): string[] {
  if (typeof url !== "string") return [`${label}: \`url\` is not a string`];
  let parsed: URL;
  try {
    parsed = new URL(url);
  } catch {
    return [`${label}: \`url\` is not a valid URL: ${pyRepr(url)}`];
  }
  // Python urlsplit().port raises on a malformed port; URL throws
  // above for the same inputs, and url.port is "" when absent.
  const netloc = url.slice(url.indexOf("://") + 3).split(/[/?#]/, 1)[0];
  const segments = parsed.pathname.split("/");
  const problems: string[] = [];
  if (parsed.protocol !== "https:") problems.push("the scheme is not https");
  if (
    parsed.hostname !== "github.com" || netloc !== "github.com" ||
    parsed.port !== ""
  ) {
    problems.push("the host is not exactly github.com");
  }
  if (
    parsed.search !== "" || parsed.hash !== "" || url.includes("?") ||
    url.includes("#")
  ) {
    problems.push("it has a query or a fragment");
  }
  if (segments.length !== 3 || segments[0] !== "") {
    problems.push("the path is not /<owner>/<repository>");
  } else {
    const owner = segments[1];
    const repo = segments[2];
    if (!SEGMENT_RE.test(repo)) {
      problems.push(`the repository name ${pyRepr(repo)} is not a plain name`);
    } else if (!allowed.has(`${owner}/${repo}`)) {
      problems.push(`the repository ${owner}/${repo} is not in the allow-list`);
    }
  }
  if (problems.length > 0) {
    return [`${label}: url ${pyRepr(url)} rejected: ${problems.join("; ")}`];
  }
  return [];
}

function checkRelativePath(
  label: string,
  key: string,
  value: unknown,
  optional: boolean,
): string[] {
  if (value === null && optional) return [];
  if (typeof value !== "string") {
    return [`${label}: \`${key}\` is not a string`];
  }
  if (key === "scope" && value === "") return [];
  if (
    !PATH_RE.test(value) || value.startsWith("/") || value.startsWith("-") ||
    value.includes("..")
  ) {
    return [
      `${label}: \`${key}\` must be a plain relative path, got ${
        pyRepr(value)
      }`,
    ];
  }
  return [];
}

function checkPackage(
  index: number,
  pkg: unknown,
  seen: Set<string>,
  workspace: Workspace,
): string[] {
  const allowedPackages = workspace.allowedPackages;
  let label = `packages[${index}]`;
  if (!isRecord(pkg)) return [`${label} is not an object`];
  const errors: string[] = [];
  const name = pkg["name"];
  if (typeof name !== "string" || !NAME_RE.test(name)) {
    errors.push(
      `${label}: \`name\` must match [A-Za-z0-9._-]+, got ${pyRepr(name)}`,
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
  const unknown = Object.keys(pkg).filter((key) => !PACKAGE_KEYS.has(key))
    .sort();
  if (unknown.length > 0) {
    errors.push(`${label}: unknown key(s) ${pyRepr(unknown)}`);
  }
  if (pkg["type"] !== "git") {
    errors.push(`${label}: \`type\` must be 'git', got ${pyRepr(pkg["type"])}`);
  }
  if (typeof pkg["inherited"] !== "boolean") {
    errors.push(
      `${label}: \`inherited\` must be a boolean, got ${
        pyRepr(pkg["inherited"])
      }`,
    );
  }
  const rev = pkg["rev"];
  if (typeof rev !== "string" || !REV_RE.test(rev)) {
    errors.push(
      `${label}: \`rev\` must be 40 lowercase hexadecimal digits, got ${
        pyRepr(rev)
      }`,
    );
  }
  errors.push(...checkUrl(label, pkg["url"], allowedRepositories(workspace)));
  const expected = typeof name === "string" ? allowedPackages[name] : undefined;
  const url = pkg["url"];
  if (
    expected !== undefined && typeof url === "string" &&
    url !== `https://github.com/${expected}`
  ) {
    errors.push(
      `${label}: url ${
        pyRepr(url)
      } is not the repository of this package (${expected})`,
    );
  }
  const inputRev = pkg["inputRev"];
  if (
    inputRev !== null && inputRev !== undefined &&
    (typeof inputRev !== "string" || !INPUT_REV_RE.test(inputRev) ||
      inputRev.startsWith("refs/") || inputRev.includes(".."))
  ) {
    errors.push(
      `${label}: \`inputRev\` must be a plain name that does not start with refs/, got ${
        pyRepr(inputRev)
      }`,
    );
  }
  errors.push(...checkRelativePath(label, "subDir", pkg["subDir"], true));
  errors.push(
    ...checkRelativePath(label, "configFile", pkg["configFile"], false),
  );
  errors.push(
    ...checkRelativePath(label, "manifestFile", pkg["manifestFile"], false),
  );
  errors.push(...checkRelativePath(label, "scope", pkg["scope"], false));
  const configFile = pkg["configFile"];
  if (typeof configFile === "string" && !CONFIG_FILES.includes(configFile)) {
    errors.push(
      `${label}: \`configFile\` must be one of ${
        pyRepr([...CONFIG_FILES].sort())
      }, got ${pyRepr(cleanText(configFile))}`,
    );
  }
  const manifestFile = pkg["manifestFile"];
  if (typeof manifestFile === "string" && manifestFile !== MANIFEST_FILE) {
    errors.push(
      `${label}: \`manifestFile\` must be ${pyRepr(MANIFEST_FILE)}, got ${
        pyRepr(cleanText(manifestFile))
      }`,
    );
  }
  return errors;
}

export function checkManifest(
  manifest: unknown,
  workspace: Workspace = ROOT_WORKSPACE,
): string[] {
  if (!isRecord(manifest)) return ["the manifest is not a JSON object"];
  const errors: string[] = [];
  const unknown = Object.keys(manifest).filter((key) =>
    !TOP_LEVEL_KEYS.has(key)
  )
    .sort();
  if (unknown.length > 0) {
    errors.push(`unknown top-level key(s) ${pyRepr(unknown)}`);
  }
  if (manifest["packagesDir"] !== PACKAGES_DIR) {
    errors.push(
      `\`packagesDir\` must be ${pyRepr(PACKAGES_DIR)}, got ${
        pyRepr(manifest["packagesDir"])
      }`,
    );
  }
  if (manifest["lakeDir"] !== LAKE_DIR) {
    errors.push(
      `\`lakeDir\` must be ${pyRepr(LAKE_DIR)}, got ${
        pyRepr(manifest["lakeDir"])
      }`,
    );
  }
  const name = manifest["name"];
  if (typeof name !== "string" || !NAME_RE.test(name)) {
    errors.push(
      `\`name\` must match [A-Za-z0-9._-]+, got ${pyRepr(name)}`,
    );
  }
  if ("version" in manifest) {
    const version = manifest["version"];
    if (typeof version !== "string" || !MANIFEST_VERSION_RE.test(version)) {
      errors.push(
        `\`version\` must be dotted numbers such as 1.2.0, got ${
          pyRepr(cleanText(pyStr(version)))
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
        pyRepr(cleanText(pyStr(manifest["fixedToolchain"])))
      }`,
    );
  }
  const packages = manifest["packages"];
  if (!Array.isArray(packages) || packages.length === 0) {
    errors.push("`packages` is missing, empty or not a list");
    return errors;
  }
  const seen = new Set<string>();
  for (let i = 0; i < packages.length; i++) {
    errors.push(...checkPackage(i, packages[i], seen, workspace));
  }
  return errors;
}

export function parseToolchain(text: string): string | null {
  const match = TOOLCHAIN_RE.exec(pyStrip(text));
  return match ? match[1] : null;
}

interface LakeRequire {
  name: string;
  url: string;
  rev: string;
}

export function parseRequires(
  lakefile: string,
): { requires: LakeRequire[]; total: number } {
  const requireRe =
    /^require\s+(\S+)\s+from\s+git\s+"([^"]+)"(?:\s+@\s+"([^"]+)")?/gm;
  const requires: LakeRequire[] = [];
  let match: RegExpExecArray | null;
  while ((match = requireRe.exec(lakefile)) !== null) {
    requires.push({
      name: match[1],
      url: match[2],
      rev: match[3] ?? "",
    });
  }
  const total = (lakefile.match(/^require\b/gm) ?? []).length;
  return { requires, total };
}

export function checkConsistency(
  manifest: LakeManifest,
  lakefile: string,
  toolchain: string,
  workspace: Workspace = ROOT_WORKSPACE,
): string[] {
  const errors: string[] = [];
  const allowedPackages = workspace.allowedPackages;
  const release = parseToolchain(toolchain);
  if (release === null) {
    errors.push(
      `lean-toolchain: unrecognised content ${pyRepr(pyStrip(toolchain))}`,
    );
  }
  const declared = [...lakefile.matchAll(/^package\s+(\S+)/gm)].map((m) =>
    m[1]
  );
  if (declared.length !== 1) {
    errors.push(
      `lakefile.lean: expected one \`package\` declaration, found ${declared.length}`,
    );
  } else if (manifest["name"] !== declared[0]) {
    errors.push(
      `manifest \`name\` ${pyRepr(manifest["name"])} != lakefile package ${
        pyRepr(declared[0])
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
  const byName = new Map<string, LakeRequire>();
  for (const req of requires) byName.set(req.name, req);
  for (const name of workspace.toolchainPinned) {
    if (!byName.has(name)) {
      errors.push(`lakefile.lean: missing \`require ${name}\``);
    } else if (release !== null && byName.get(name)!.rev !== release) {
      errors.push(
        `lakefile.lean: \`require ${name}\` is pinned to ${
          pyRepr(byName.get(name)!.rev)
        } but lean-toolchain is ${pyRepr(release)}`,
      );
    }
  }
  const packages = new Map<string, LakePackage>();
  const rawPackages = manifest["packages"];
  if (Array.isArray(rawPackages)) {
    for (const p of rawPackages) {
      if (isRecord(p) && typeof p["name"] === "string") {
        packages.set(p["name"], p);
      }
    }
  }
  for (const req of requires) {
    const { name, url, rev } = req;
    const label = `lakefile.lean \`require ${name}\``;
    errors.push(...checkUrl(label, url, allowedRepositories(workspace)));
    if (!(name in allowedPackages)) {
      errors.push(`${label}: not one of the known packages`);
    } else if (url !== `https://github.com/${allowedPackages[name]}`) {
      errors.push(
        `${label}: url ${pyRepr(url)} is not the repository of this package`,
      );
    }
    const pkg = packages.get(name);
    if (pkg === undefined) {
      errors.push(
        `manifest: no package named ${
          pyRepr(name)
        } for the lakefile requirement`,
      );
      continue;
    }
    if (pkg["url"] !== url) {
      errors.push(
        `${name}: manifest url ${pyRepr(pkg["url"])} != lakefile url ${
          pyRepr(url)
        }`,
      );
    }
    if (pkg["inputRev"] !== rev) {
      errors.push(
        `${name}: manifest inputRev ${
          pyRepr(pkg["inputRev"])
        } != lakefile tag ${pyRepr(rev)}`,
      );
    }
    if (pkg["inherited"] !== false) {
      errors.push(
        `${name}: a direct dependency must have \`inherited: false\``,
      );
    }
    if (REV_RE.test(rev) && pkg["rev"] !== rev) {
      errors.push(
        `${name}: manifest rev ${pyRepr(pkg["rev"])} != the commit ${
          pyRepr(rev)
        } required by lakefile.lean`,
      );
    }
  }
  const direct = new Set<string>();
  for (const [name, pkg] of packages) {
    if (pkg["inherited"] === false) direct.add(name);
  }
  for (const name of [...direct].filter((n) => !byName.has(n)).sort()) {
    errors.push(
      `${name}: not inherited, but no \`require\` of lakefile.lean names it`,
    );
  }
  return errors;
}

/**
 * The manifest itself when it passes the offline checks of its
 * workspace; throws Error otherwise. Shared by the converters,
 * which must only ever convert a manifest this check accepts.
 */
export function validatedManifest(
  manifest: unknown,
  lakefile: string,
  toolchain: string,
  workspace: Workspace = ROOT_WORKSPACE,
): LakeManifest {
  const errors = checkManifest(manifest, workspace);
  if (errors.length > 0) {
    throw new Error(
      "invalid Lake manifest:\n" + errors.map((e) => `- ${e}`).join("\n"),
    );
  }
  const dict = manifest as LakeManifest;
  const consistencyErrors = checkConsistency(
    dict,
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
  return dict;
}

/** Join path segments and normalize "." / ".." (POSIX, as here). */
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

function realPathOrNormalize(path: string): string {
  try {
    return Deno.realPathSync(path);
  } catch {
    return joinPath(Deno.cwd(), path);
  }
}

/** The workspace whose rules apply to manifestPath, chosen by location only. */
export function workspaceFor(
  root: string,
  manifestPath: string | null,
): Workspace {
  if (manifestPath !== null) {
    const given = realPathOrNormalize(manifestPath);
    for (const workspace of WORKSPACES) {
      if (isRootWorkspace(workspace)) continue;
      const candidate = realPathOrNormalize(
        joinPath(root, workspace.directory, MANIFEST_FILE),
      );
      if (given === candidate) return workspace;
    }
  }
  return ROOT_WORKSPACE;
}

function readTextStrict(path: string): string {
  const bytes = Deno.readFileSync(path);
  return new TextDecoder("utf-8", { fatal: true }).decode(bytes);
}

/** Parse the manifest; refuse oversized, unreadable or non-JSON input. */
export function loadManifest(path: string): unknown {
  let info: Deno.FileInfo;
  try {
    info = Deno.lstatSync(path);
  } catch {
    throw new Error(`${path} is not a regular file`);
  }
  if (info.isSymlink || !info.isFile) {
    throw new Error(`${path} is not a regular file`);
  }
  if (info.size !== null && info.size > MAX_MANIFEST_BYTES) {
    throw new Error(`${path} is larger than ${MAX_MANIFEST_BYTES} bytes`);
  }
  let text: string;
  try {
    text = readTextStrict(path);
  } catch (error) {
    throw new Error(
      `${path} is not valid JSON: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  }
  try {
    return JSON.parse(text);
  } catch (error) {
    throw new Error(
      `${path} is not valid JSON: ${
        error instanceof Error ? error.message : String(error)
      }`,
    );
  }
}

export interface WorkspaceInputs {
  workspace: Workspace;
  manifest: unknown;
  lakefile: string;
  toolchain: string;
}

/**
 * Read a manifest (bounded, regular file, JSON) and the files of
 * its workspace. lakefile/toolchain paths default to the files of
 * the workspace the manifest belongs to.
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
  const lakefile = readTextStrict(
    lakefilePath ?? joinPath(directory, "lakefile.lean"),
  );
  const toolchain = readTextStrict(
    toolchainPath ?? joinPath(directory, "lean-toolchain"),
  );
  return { workspace, manifest, lakefile, toolchain };
}

export interface OsvPackage {
  package: { name: string; commit: string };
}

export interface OsvLockfile {
  results: Array<{ packages: OsvPackage[] }>;
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
