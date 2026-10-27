// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Lean module reachability check, ported faithfully from
 * scripts/ci/check_lean_modules.py (same lakefile grammar,
 * same header grammar, same failure modes, same exit codes).
 * Do NOT "fix" divergences here: parity with the Python
 * script is the contract, and any behaviour change is a
 * separate, owner-approved decision.
 *
 * `lake build` compiles a library from its declared roots
 * and, transitively, from the modules those roots import. A
 * `.lean` file that is neither a declared root
 * (`lean_lib`/`lean_exe` in `lakefile.lean`) nor imported
 * from one is never compiled: a false `#guard`, a `sorry`
 * or a warning turned into an error inside it cannot fail
 * the build. This module reports such files.
 *
 * Scope and limits (the port fails loudly rather than
 * guessing, exactly as the Python script does):
 * - only `lakefile.lean` is understood, and only
 *   `lean_lib X where`/`lean_exe x where` declarations
 *   written at the start of a line, each with a literal
 *   `srcDir` and a literal `roots` list (library) or `root`
 *   name (executable). Lake's defaults are deliberately not
 *   assumed: leaving a field out is an error, as is any
 *   other shape (`globs`, a computed root list, a
 *   `lean_lib` keyword that the parser does not recognise
 *   as a declaration, a missing root file, a missing
 *   scanned directory). Nothing is ever a silent pass;
 * - imports are read from the file header only, after
 *   comments are removed, following the header grammar of
 *   Lean 4.34 (`[module] [prelude] ([public] [meta] import
 *   [all] Name)*`);
 * - it checks reachability, not that a reachable module is
 *   actually tested or audited;
 * - by default it scans the source directories of the
 *   package's targets: `src/`, `tests/`, `tools/` and
 *   `spec/`. A target whose `srcDir` lies under one of
 *   them (`tools/prototypes-bcd/`) is scanned as part of
 *   it; a directory outside them is not scanned;
 * - a directory under a scanned one that holds its own
 *   `lakefile.lean` or `lakefile.toml` (such as
 *   `spec/formal-chain/`) is a separate Lake workspace,
 *   built by its own targets: it is skipped, and every
 *   skipped workspace is named in the output.
 *
 * Wiring: the structured entry point is
 * {@link checkLeanModules} (it returns the exit code and
 * the exact stdout/stderr text, so callers can test it
 * without capturing console output); the CLI entry point
 * is {@link runCheckLeanModulesCommand}. Running this file
 * itself (`deno run src/lean_modules.ts ...`) also works.
 * This module is not referenced by src/main.ts yet; the
 * parent wires it later.
 */

export const DEFAULT_SCAN_DIRS: readonly string[] = [
  "src",
  "tests",
  "tools",
  "spec",
];
export const LAKEFILES: readonly string[] = [
  "lakefile.lean",
  "lakefile.toml",
];

const DECLARATION_RE =
  /^(lean_lib|lean_exe)[ \t]+(\S+)[ \t]+where\b([^\n]*)$/gm;
const KEYWORD_RE = /\blean_(?:lib|exe)\b/g;
// A literal must be the whole value of its field: `"src" / "x"` or `#[`A] ++ more` is a computed value.
// No multiline flag on the field patterns below, on purpose:
// Python's `$` with MULTILINE matches before `\n` and at the
// end of the string, which is exactly what `(?=\n)|$` without
// the flag expresses. With the flag, JavaScript's `$` would
// additionally match before `\r`, `\u2028` and `\u2029`,
// which Python's `$` never does.
const ENTRY_END = "[ \t]*(?:,|(?=\n)|$)";
const NAME_LITERAL_SOURCE = "`([^\\s,\\[\\]#]+)";

/** The repository layout cannot be analysed with confidence. */
export class Unrecognized extends Error {
  constructor(message: string) {
    super(message);
    this.name = "Unrecognized";
  }
}

/** A `lean_lib` or `lean_exe` declaration. */
export interface Target {
  kind: string;
  name: string;
  srcDir: string;
  roots: readonly string[];
}

function isSpaceChar(ch: string): boolean {
  return ch === " " || /\s/.test(ch) || "\x1c\x1d\x1e\x1f\x85".includes(ch);
}

/** Python repr() of a string, as used in the error messages. */
function pythonRepr(value: string): string {
  const escaped = [...value].map((ch) => {
    if (ch === "\\") return "\\\\";
    if (ch === "\n") return "\\n";
    if (ch === "\r") return "\\r";
    if (ch === "\t") return "\\t";
    const code = ch.codePointAt(0) ?? 0;
    if (code < 0x20 || code === 0x7f) {
      return `\\x${code.toString(16).padStart(2, "0")}`;
    }
    return ch;
  }).join("");
  if (!escaped.includes("'")) return `'${escaped}'`;
  if (!escaped.includes('"')) return `"${escaped}"`;
  return `'${escaped.replace(/'/g, "\\'")}'`;
}

/** POSIX normpath (Python os.path.normpath on this platform). */
export function normpathPosix(path: string): string {
  if (path === "") return ".";
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
  if (path.startsWith("/")) return normpathPosix(path);
  return normpathPosix(`${Deno.cwd()}/${path}`);
}

function joinPath(...parts: string[]): string {
  const joined = parts.filter((p) => p !== "").join("/");
  if (parts.length > 0 && parts[0].startsWith("/")) {
    return normpathPosix(joined);
  }
  return normpathPosix(joined);
}

function basename(path: string): string {
  const cleaned = path.endsWith("/") && path.length > 1
    ? path.slice(0, -1)
    : path;
  const slash = cleaned.lastIndexOf("/");
  return slash === -1 ? cleaned : cleaned.slice(slash + 1);
}

function dirname(path: string): string {
  const slash = path.lastIndexOf("/");
  if (slash === -1) return ".";
  if (slash === 0) return "/";
  return path.slice(0, slash);
}

function pathParts(path: string): string[] {
  return path.split("/").filter((part) => part !== "");
}

/** Compare paths the way Python's pathlib sorts them: part by part, shorter prefix first. */
function comparePaths(a: string, b: string): number {
  const pa = pathParts(a);
  const pb = pathParts(b);
  const len = Math.min(pa.length, pb.length);
  for (let i = 0; i < len; i++) {
    if (pa[i] < pb[i]) return -1;
    if (pa[i] > pb[i]) return 1;
  }
  return pa.length - pb.length;
}

function isFile(path: string): boolean {
  try {
    return Deno.statSync(path).isFile;
  } catch {
    return false;
  }
}

function isDir(path: string): boolean {
  try {
    return Deno.statSync(path).isDirectory;
  } catch {
    return false;
  }
}

function readTextStrict(path: string): string {
  const bytes = Deno.readFileSync(path);
  return new TextDecoder("utf-8", { fatal: true }).decode(bytes);
}

/** Blank out Lean comments (line and nested block), keeping strings and line structure. */
export function stripComments(text: string): string {
  const out: string[] = [];
  let i = 0;
  const n = text.length;
  let depth = 0;
  let inString = false;
  while (i < n) {
    const ch = text[i];
    const pair = text.slice(i, i + 2);
    if (depth > 0) {
      if (pair === "/-") {
        depth += 1;
        out.push("  ");
        i += 2;
      } else if (pair === "-/") {
        depth -= 1;
        out.push("  ");
        i += 2;
      } else {
        out.push(ch === "\n" ? "\n" : " ");
        i += 1;
      }
    } else if (inString) {
      out.push(ch);
      if (ch === "\\" && i + 1 < n) {
        out.push(text[i + 1]);
        i += 2;
        continue;
      }
      if (ch === '"') inString = false;
      i += 1;
    } else if (pair === "/-") {
      depth = 1;
      out.push("  ");
      i += 2;
    } else if (pair === "--") {
      while (i < n && text[i] !== "\n") {
        out.push(" ");
        i += 1;
      }
    } else {
      if (ch === '"') inString = true;
      out.push(ch);
      i += 1;
    }
  }
  return out.join("");
}

function splitLines(text: string): string[] {
  // deno-lint-ignore no-control-regex -- Python str.splitlines() boundaries, kept on purpose.
  return text.split(/(?:\r\n|\r|\n|\v|\f|\x1c|\x1d|\x1e|\x85|\u2028|\u2029)/);
}

function stringField(body: string, field: string, label: string): string {
  const pattern = new RegExp(
    `\\b${field}\\s*:=\\s*"([^"\\\\]*)"${ENTRY_END}`,
  );
  const match = pattern.exec(body);
  if (!match) {
    throw new Unrecognized(
      `${label}: \`${field}\` is missing or is not a string literal`,
    );
  }
  return match[1];
}

function nameField(body: string, field: string, label: string): string {
  const pattern = new RegExp(
    `\\b${field}\\s*:=\\s*${NAME_LITERAL_SOURCE}${ENTRY_END}`,
  );
  const match = pattern.exec(body);
  if (!match) {
    throw new Unrecognized(
      `${label}: \`${field}\` is missing or is not a name literal`,
    );
  }
  return match[1];
}

function namesField(body: string, field: string, label: string): string[] {
  const pattern = new RegExp(
    `\\b${field}\\s*:=\\s*#\\[([^\\]]*)\\]${ENTRY_END}`,
  );
  const match = pattern.exec(body);
  if (!match) {
    throw new Unrecognized(
      `${label}: \`${field}\` is missing or is not a literal list of names`,
    );
  }
  const inner = match[1];
  const residue = inner.replace(
    new RegExp(NAME_LITERAL_SOURCE, "g"),
    "",
  ).replace(/,/g, "").trim();
  if (residue !== "") {
    throw new Unrecognized(
      `${label}: \`${field}\` contains something other than name literals`,
    );
  }
  const names: string[] = [];
  for (
    const nameMatch of inner.matchAll(
      new RegExp(NAME_LITERAL_SOURCE, "g"),
    )
  ) {
    names.push(nameMatch[1]);
  }
  return names;
}

function bodyOf(
  stripped: string,
  match: RegExpMatchArray,
): string {
  const lines = [match[3]];
  const rest = stripped.slice((match.index ?? 0) + match[0].length);
  for (const line of splitLines(rest).slice(1)) {
    if (line.trim() !== "" && !isSpaceChar(line[0])) break;
    lines.push(line);
  }
  return lines.join("\n");
}

/** Return the `lean_lib`/`lean_exe` targets of `lakefile.lean`, or throw `Unrecognized`. */
export function parseLakefile(path: string): Target[] {
  if (!isFile(path)) {
    const dir = dirname(path);
    const toml = dir === "." ? "lakefile.toml" : `${dir}/lakefile.toml`;
    const hint = isFile(toml) ? " (lakefile.toml is not supported)" : "";
    throw new Unrecognized(`${path} not found${hint}`);
  }
  const stripped = stripComments(readTextStrict(path));
  const matches = [...stripped.matchAll(DECLARATION_RE)];
  if (matches.length === 0) {
    throw new Unrecognized(
      `no lean_lib/lean_exe declaration recognised in ${path}`,
    );
  }
  const keywordCount = stripped.match(KEYWORD_RE)?.length ?? 0;
  if (keywordCount !== matches.length) {
    throw new Unrecognized(
      `${path} mentions lean_lib/lean_exe ${keywordCount} time(s) but ` +
        `${matches.length} declaration(s) were recognised: unsupported syntax`,
    );
  }
  const targets: Target[] = [];
  for (const match of matches) {
    const kind = match[1];
    const name = match[2];
    const label = `${kind} ${name}`;
    const body = bodyOf(stripped, match);
    if (/\bglobs\s*:=/.test(body)) {
      throw new Unrecognized(`${label}: \`globs\` is not supported`);
    }
    const srcDir = normpathPosix(stringField(body, "srcDir", label));
    const roots = kind === "lean_lib"
      ? namesField(body, "roots", label)
      : [nameField(body, "root", label)];
    targets.push({ kind, name, srcDir, roots });
  }
  return targets;
}

/** The `.lean` file of `module` under one of the source directories, if there is one. */
export function moduleFile(
  repo: string,
  module: string,
  srcDirs: readonly string[],
): string | null {
  const parts = module.split(".");
  for (const srcDir of srcDirs) {
    const candidate = joinPath(
      repo,
      srcDir,
      ...parts.slice(0, -1),
      `${parts[parts.length - 1]}.lean`,
    );
    if (isFile(candidate)) return candidate;
  }
  return null;
}

/** Modules imported by the header of a Lean file (comments removed). */
export function importsOf(path: string): string[] {
  // deno-lint-ignore no-control-regex -- Python str.split() boundaries, kept on purpose.
  const tokenSplitRe = /[\s\x1c-\x1f\x85]+/;
  const tokens = stripComments(readTextStrict(path)).split(tokenSplitRe)
    .filter((token) => token !== "");
  const modules: string[] = [];
  let i = 0;
  for (const keyword of ["module", "prelude"]) {
    if (tokens[i] === keyword) i += 1;
  }
  while (true) {
    let j = i;
    for (const modifier of ["public", "meta"]) {
      if (tokens[j] === modifier) j += 1;
    }
    if (tokens[j] !== "import") return modules;
    j += 1;
    if (tokens[j] === "all") j += 1;
    if (j >= tokens.length) return modules;
    modules.push(tokens[j]);
    i = j + 1;
  }
}

/** Files reachable from the declared roots through `import`. */
export function reachableFiles(
  repo: string,
  targets: readonly Target[],
): Set<string> {
  const srcDirs = [...new Set(targets.map((t) => t.srcDir))].sort();
  const pending: string[] = [];
  for (const target of targets) {
    for (const root of target.roots) {
      const found = moduleFile(repo, root, [target.srcDir]);
      if (found === null) {
        throw new Unrecognized(
          `${target.kind} ${target.name}: root module ${root} has no file under ` +
            `${target.srcDir}/`,
        );
      }
      pending.push(found);
    }
  }
  const seen = new Set<string>();
  while (pending.length > 0) {
    const current = pending.pop()!;
    if (seen.has(current)) continue;
    seen.add(current);
    for (const module of importsOf(current)) {
      const found = moduleFile(repo, module, srcDirs);
      if (found !== null) pending.push(found);
    }
  }
  return seen;
}

function walkEntries(dir: string, out: string[]): void {
  let entries: Deno.DirEntry[];
  try {
    entries = [...Deno.readDirSync(dir)];
  } catch {
    return;
  }
  for (const entry of entries) {
    const path = dir === "/" ? `/${entry.name}` : `${dir}/${entry.name}`;
    out.push(path);
    if (entry.isDirectory && !entry.isSymlink) {
      walkEntries(path, out);
    }
  }
}

/** Directories under the scanned ones (the repository root aside) that hold their own lakefile. */
export function nestedWorkspaces(
  repo: string,
  scanDirs: readonly string[],
): string[] {
  const found = new Set<string>();
  for (const scanDir of scanDirs) {
    const entries: string[] = [];
    walkEntries(joinPath(repo, scanDir), entries);
    for (const lakefile of entries) {
      if (!LAKEFILES.includes(basename(lakefile))) continue;
      if (pathParts(lakefile).includes(".lake")) continue;
      const parent = dirname(lakefile);
      if (parent !== repo) found.add(parent);
    }
  }
  return [...found].sort(comparePaths);
}

/**
 * Every `.lean` file under the scanned directories.
 *
 * The `.lake` directories and the separate Lake workspaces (`nestedWorkspaces`) are excluded.
 */
export function scan(
  repo: string,
  scanDirs: readonly string[],
): string[] {
  for (const scanDir of scanDirs) {
    if (!isDir(joinPath(repo, scanDir))) {
      throw new Unrecognized(`scanned directory ${scanDir}/ does not exist`);
    }
  }
  const workspaces = nestedWorkspaces(repo, scanDirs);
  const files: string[] = [];
  for (const scanDir of scanDirs) {
    const entries: string[] = [];
    walkEntries(joinPath(repo, scanDir), entries);
    for (const p of entries) {
      if (!basename(p).endsWith(".lean")) continue;
      if (pathParts(p).includes(".lake")) continue;
      if (
        workspaces.some((w) => p === w || p.startsWith(`${w}/`))
      ) {
        continue;
      }
      files.push(p);
    }
  }
  return files.sort(comparePaths);
}

export interface LeanModulesResult {
  code: number;
  stdout: string;
  stderr: string;
}

function relativePosix(repo: string, path: string): string {
  const prefix = repo.endsWith("/") ? repo : `${repo}/`;
  return path.startsWith(prefix) ? path.slice(prefix.length) : path;
}

/**
 * The full check for one repository: exit code 0 when every
 * scanned file is reachable, 1 when an orphan is found, 2
 * when the repository cannot be analysed.
 */
export function checkLeanModules(
  repoArg: string,
  scanDirs: readonly string[],
  rootsIn?: string,
): LeanModulesResult {
  let repo: string;
  try {
    repo = Deno.realPathSync(repoArg);
  } catch {
    repo = resolvePath(repoArg);
  }
  let targets: Target[];
  try {
    targets = parseLakefile(joinPath(repo, "lakefile.lean"));
    if (rootsIn !== undefined) {
      const wanted = normpathPosix(rootsIn);
      const roots = [
        ...new Set(
          targets.filter((t) => t.srcDir === wanted).flatMap((t) => t.roots),
        ),
      ].sort();
      if (roots.length === 0) {
        throw new Unrecognized(
          `no lean_lib/lean_exe declares srcDir := ${pythonRepr(wanted)}`,
        );
      }
      return { code: 0, stdout: `${roots.join("\n")}\n`, stderr: "" };
    }
    const reachable = reachableFiles(repo, targets);
    const files = scan(repo, scanDirs);
    const workspaces = nestedWorkspaces(repo, scanDirs);
    const orphans = files.filter((path) => !reachable.has(path));
    const lines: string[] = [];
    if (orphans.length > 0) {
      lines.push(
        "check_lean_modules: Lean files that no lean_lib/lean_exe root reaches:",
      );
      for (const path of orphans) {
        lines.push(`  ${relativePosix(repo, path)}`);
      }
      lines.push(
        "`lake build` never compiles them. Import each one from a reachable module, or list " +
          "it in the `roots` of a lean_lib of lakefile.lean.",
      );
    } else {
      const totalRoots = targets.reduce((sum, t) => sum + t.roots.length, 0);
      lines.push(
        `check_lean_modules: ${files.length} Lean file(s) under ${
          scanDirs.join(", ")
        }, all ` +
          `reachable from the ${totalRoots} root(s) of ${targets.length} lean_lib/lean_exe target(s).`,
      );
    }
    for (const workspace of workspaces) {
      lines.push(
        `check_lean_modules: not scanned: ${
          relativePosix(repo, workspace)
        }/, a separate ` +
          "Lake workspace with its own lakefile",
      );
    }
    return {
      code: orphans.length > 0 ? 1 : 0,
      stdout: lines.map((line) => `${line}\n`).join(""),
      stderr: "",
    };
  } catch (error) {
    if (error instanceof Unrecognized) {
      return {
        code: 2,
        stdout: "",
        stderr:
          `check_lean_modules: cannot analyse the repository: ${error.message}\n`,
      };
    }
    throw error;
  }
}

function leanModulesUsage(): string {
  return [
    "Usage:",
    "  check-lean-modules [--repo <dir>] [--dirs <dir...>] [--roots-in <dir>]",
  ].join("\n");
}

/** Command line entry point; returns the process exit code (0, 1 or 2). */
export function runCheckLeanModulesCommand(argv: string[]): number {
  let repo = ".";
  let dirs: string[] = [...DEFAULT_SCAN_DIRS];
  let rootsIn: string | undefined;
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
      console.log(leanModulesUsage());
      return 0;
    } else if (flag === "--repo" || flag === "--roots-in") {
      const value = takeValue();
      if (value === null) {
        console.error(
          `check-lean-modules: ${flag} requires a value\n${leanModulesUsage()}`,
        );
        return 2;
      }
      if (flag === "--repo") repo = value;
      else rootsIn = value;
    } else if (flag === "--dirs") {
      const values: string[] = [];
      if (inline !== null) values.push(inline);
      while (i + 1 < argv.length && !argv[i + 1].startsWith("--")) {
        values.push(argv[++i]);
      }
      if (values.length === 0) {
        console.error(
          `check-lean-modules: --dirs requires at least one value\n${leanModulesUsage()}`,
        );
        return 2;
      }
      dirs = values;
    } else {
      console.error(
        `check-lean-modules: unknown argument: ${arg}\n${leanModulesUsage()}`,
      );
      return 2;
    }
  }
  const result = checkLeanModules(repo, dirs, rootsIn);
  if (result.stdout !== "") {
    Deno.stdout.writeSync(new TextEncoder().encode(result.stdout));
  }
  if (result.stderr !== "") {
    Deno.stderr.writeSync(new TextEncoder().encode(result.stderr));
  }
  return result.code;
}

if (import.meta.main) {
  Deno.exit(runCheckLeanModulesCommand(Deno.args));
}
