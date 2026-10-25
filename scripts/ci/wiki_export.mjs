// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
/**
 * Deterministic GitHub Wiki export. Markdown pages are flattened into a
 * collision-checked namespace; other files live under assets/. A top-level
 * archives/ directory in the source is intentionally excluded, as is the
 * temporary migration matrix (_migration-matrix.md), which is a working
 * tool for the docs/ → wiki/ refactor and not a published page.
 * No external runtime dependency is required.
 */
import { createHash } from "node:crypto";
import { copyFile, mkdir, readFile, readdir, rm, writeFile } from "node:fs/promises";
import { existsSync, statSync } from "node:fs";
import { basename, dirname, isAbsolute, join, relative, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";

const GENERATED_PUBLICATION = "K7PL--Publication.md";
const GENERATED_MANIFEST = "Publication-manifest.json";
const GENERATED_SIDEBAR = "_Sidebar.md";

function posix(value) { return value.split(sep).join("/"); }
function sha256(value) { return createHash("sha256").update(value).digest("hex"); }
function isWithin(parent, candidate) {
  const rel = relative(parent, candidate);
  return rel === "" || (rel !== ".." && !rel.startsWith(".." + sep) && !isAbsolute(rel));
}
function urlPath(value) {
  return value.split("/").map((part) => encodeURIComponent(part)).join("/");
}
function maskNonLinkMarkdown(text) {
  const mask = (value) => value.replace(/[^\n]/g, " ");
  let result = text.replace(/<!--[\s\S]*?-->/g, mask);
  result = result.replace(
    /^ {0,3}(\x60{3,}|~{3,})[^\n]*(?:\n|$)[\s\S]*?^ {0,3}\1[ \t]*(?:\n|$)/gm,
    mask,
  );
  return result.replace(/(\x60+)(?!\x60)([\s\S]*?)(?<!\x60)\1(?!\x60)/g, mask);
}
function unwrapDestination(value) {
  return value.startsWith("<") && value.endsWith(">")
    ? { value: value.slice(1, -1), wrapped: true }
    : { value, wrapped: false };
}
function wrapDestination(value, wrapped) { return wrapped ? "<" + value + ">" : value; }

function sourceUrl(kind, target, context, suffix = "") {
  const targetRel = posix(relative(context.repoRoot, target));
  if (!targetRel || targetRel === ".") {
    return "https://github.com/" + context.repository + "/tree/" + context.sourceRef + suffix;
  }
  const directory = existsSync(target) && statSync(target).isDirectory();
  const route = directory ? "tree" : kind === "image" ? "raw" : "blob";
  return "https://github.com/" + context.repository + "/" + route + "/" +
    context.sourceRef + "/" + urlPath(targetRel) + suffix;
}

function resolveDestination(rawDestination, isImage, sourceRelative, context) {
  const raw = rawDestination.trim();
  if (!raw || raw.startsWith("#") || raw.startsWith("//") ||
      /^[a-zA-Z][a-zA-Z0-9+.-]*:/.test(raw)) return rawDestination;

  const suffixStart = raw.search(/[?#]/);
  const pathname = suffixStart < 0 ? raw : raw.slice(0, suffixStart);
  const suffix = suffixStart < 0 ? "" : raw.slice(suffixStart);
  if (!pathname) return rawDestination;

  let decoded;
  try { decoded = decodeURIComponent(pathname); } catch { return rawDestination; }
  const sourceFile = join(context.sourceDir, ...sourceRelative.split("/"));
  const target = decoded.startsWith("/")
    ? resolve(context.repoRoot, decoded.slice(1))
    : resolve(dirname(sourceFile), decoded);
  if (!isWithin(context.repoRoot, target) || !existsSync(target)) return rawDestination;

  if (isWithin(context.sourceDir, target)) {
    let docsRelative = posix(relative(context.sourceDir, target));
    if (docsRelative === ".") docsRelative = "";
    if (docsRelative === "archives" || docsRelative.startsWith("archives/")) {
      return sourceUrl(isImage ? "image" : "link", target, context, suffix);
    }
    if (statSync(target).isDirectory()) {
      const readme = docsRelative ? docsRelative + "/README.md" : "HOME.md";
      if (context.pageTargets.has(readme)) {
        return context.pageTargets.get(readme).replace(/\.md$/i, "") + suffix;
      }
      return sourceUrl("link", target, context, suffix);
    }
    if (context.pageTargets.has(docsRelative)) {
      return context.pageTargets.get(docsRelative).replace(/\.md$/i, "") + suffix;
    }
    if (context.includedDocs.has(docsRelative)) {
      return "assets/" + urlPath(docsRelative) + suffix;
    }
    return sourceUrl(isImage ? "image" : "link", target, context, suffix);
  }
  return sourceUrl(isImage ? "image" : "link", target, context, suffix);
}

export function rewriteMarkdown(markdown, sourceRelative, context) {
  const masked = maskNonLinkMarkdown(markdown);
  const replacements = [];
  const inlinePattern =
    /(!?\[[^\]\n]*\]\()(<[^>\n]*>|(?:\\.|[^\s)])*)(?=\s*(?:"[^"\n]*"|'[^'\n]*')?\s*\))/g;
  for (const match of masked.matchAll(inlinePattern)) {
    const start = match.index + match[1].length;
    const end = start + match[2].length;
    const original = markdown.slice(start, end);
    const unwrapped = unwrapDestination(original);
    const next = resolveDestination(unwrapped.value, match[1].startsWith("!"), sourceRelative, context);
    const replacement = wrapDestination(next, unwrapped.wrapped);
    if (replacement !== original) replacements.push({ start, end, replacement });
  }
  const definitionPattern = /^(\s{0,3}\[[^\]\n]+\]:\s*)(<[^>\n]*>|(?:\\.|[^\s]+))/gm;
  for (const match of masked.matchAll(definitionPattern)) {
    const start = match.index + match[1].length;
    const end = start + match[2].length;
    const original = markdown.slice(start, end);
    const unwrapped = unwrapDestination(original);
    const next = resolveDestination(unwrapped.value, false, sourceRelative, context);
    const replacement = wrapDestination(next, unwrapped.wrapped);
    if (replacement !== original) replacements.push({ start, end, replacement });
  }
  replacements.sort((a, b) => b.start - a.start);
  let result = markdown;
  for (const item of replacements) {
    result = result.slice(0, item.start) + item.replacement + result.slice(item.end);
  }
  return result;
}

function safePageComponent(value) { return value.replace(/[^A-Za-z0-9._-]/g, "-"); }
function candidatePageName(sourceRelative) {
  if (sourceRelative === "HOME.md") return "Home.md";
  return sourceRelative.replace(/\.md$/i, "").split("/").map(safePageComponent).join("--") + ".md";
}
function groupForPage(sourceRelative) {
  const directories = sourceRelative.split("/").slice(0, -1);
  return directories.length ? directories.slice(0, 2).join("/") : "overview";
}
function indexName(group) {
  return "K7PL--Index--" + group.split("/").map(safePageComponent).join("--") + ".md";
}
function titleOf(markdown, fallback) {
  const match = markdown.match(/^#\s+(.+?)\s*#*\s*$/m);
  return match ? match[1].trim() : fallback;
}

async function listFiles(root, relativePath = "") {
  const directory = join(root, ...relativePath.split("/").filter(Boolean));
  const result = [];
  const entries = await readdir(directory, { withFileTypes: true });
  for (const entry of entries.sort((a, b) => a.name.localeCompare(b.name))) {
    const childRelative = relativePath ? relativePath + "/" + entry.name : entry.name;
    if (!relativePath && entry.name === "archives") continue;
    const absolute = join(root, ...childRelative.split("/"));
    if (entry.isSymbolicLink()) {
      throw new Error("Symbolic links are not supported in the source directory: " + childRelative);
    }
    if (entry.isDirectory()) result.push(...await listFiles(root, childRelative));
    else if (entry.isFile()) result.push({ relative: childRelative, absolute });
  }
  return result;
}

export async function buildWikiExport({ sourceDir, destDir, repository, sourceRef }) {
  if (!sourceDir || !destDir || !repository || !sourceRef) {
    throw new Error("sourceDir, destDir, repository and sourceRef are required");
  }
  const source = resolve(sourceDir);
  const destination = resolve(destDir);
  const repoRoot = dirname(source);
  if (!existsSync(source) || !statSync(source).isDirectory()) {
    throw new Error("Documentation directory not found: " + source);
  }
  if (isWithin(source, destination) || isWithin(destination, source)) {
    throw new Error("The export destination must be outside the source directory");
  }

  const sourceName = basename(source);
  const sourceFiles = (await listFiles(source))
    .filter((file) => file.relative !== "_migration-matrix.md");
  const includedDocs = new Set(sourceFiles.map((file) => file.relative));
  const markdownFiles = sourceFiles
    .filter((file) => /\.md$/i.test(file.relative))
    .sort((a, b) => a.relative.localeCompare(b.relative));
  if (!markdownFiles.some((file) => file.relative === "HOME.md")) {
    throw new Error(sourceName + "/HOME.md is required to generate the wiki Home page");
  }

  const groups = new Map();
  for (const file of markdownFiles) {
    const group = groupForPage(file.relative);
    if (!groups.has(group)) groups.set(group, []);
    groups.get(group).push(file);
  }
  const indexTargets = [...groups.keys()].sort().map(indexName);
  if (new Set(indexTargets).size !== indexTargets.length) {
    throw new Error("Two source directories map to the same generated index name");
  }
  const reserved = new Set([
    "Home.md", GENERATED_PUBLICATION, GENERATED_MANIFEST, GENERATED_SIDEBAR, ...indexTargets,
  ]);
  const pageTargets = new Map([["HOME.md", "Home.md"]]);
  const used = new Set(reserved);
  for (const file of markdownFiles) {
    if (file.relative === "HOME.md") continue;
    let candidate = candidatePageName(file.relative);
    if (used.has(candidate)) {
      candidate = candidate.replace(/\.md$/i, "") + "--" + sha256(file.relative).slice(0, 8) + ".md";
    }
    while (used.has(candidate)) candidate = candidate.replace(/\.md$/i, "") + "-x.md";
    used.add(candidate);
    pageTargets.set(file.relative, candidate);
  }

  const context = { sourceDir: source, repoRoot, repository, sourceRef, includedDocs, pageTargets };
  await rm(destination, { recursive: true, force: true });
  await mkdir(destination, { recursive: true });

  const manifestFiles = [];
  const renderedPages = [];
  for (const file of markdownFiles) {
    const bytes = await readFile(file.absolute);
    const sourceMarkdown = new TextDecoder("utf-8", { fatal: true }).decode(bytes);
    let rendered = rewriteMarkdown(sourceMarkdown, file.relative, context);
    if (file.relative === "HOME.md") {
      rendered =
        "> This wiki is generated from " + sourceName + "/HOME.md at commit " + sourceRef.slice(0, 12) +
        " (source commit: https://github.com/" + repository + "/commit/" + sourceRef +
        "). Edit source files in " + sourceName + "/ through a pull request; this wiki is a publication target, not a source of truth.\n>\n" +
        "> [Publication provenance](K7PL--Publication) · [Page manifest](Publication-manifest.json)\n\n" +
        rendered;
    }
    const target = pageTargets.get(file.relative);
    await writeFile(join(destination, target), rendered, "utf8");
    renderedPages.push({
      source: sourceName + "/" + file.relative,
      target,
      title: titleOf(sourceMarkdown, basename(file.relative, ".md")),
      group: groupForPage(file.relative),
    });
    manifestFiles.push({
      source: sourceName + "/" + file.relative,
      target,
      kind: "page",
      source_sha256: sha256(bytes),
      published_sha256: sha256(Buffer.from(rendered, "utf8")),
    });
  }

  for (const file of sourceFiles.filter((entry) => !/\.md$/i.test(entry.relative))) {
    const target = "assets/" + file.relative;
    const bytes = await readFile(file.absolute);
    const targetPath = join(destination, ...target.split("/"));
    await mkdir(dirname(targetPath), { recursive: true });
    await copyFile(file.absolute, targetPath);
    manifestFiles.push({
      source: sourceName + "/" + file.relative,
      target,
      kind: "resource",
      source_sha256: sha256(bytes),
      published_sha256: sha256(bytes),
    });
  }

  const generatedIndexes = [];
  for (const [group, files] of [...groups.entries()].sort(([a], [b]) => a.localeCompare(b))) {
    const target = indexName(group);
    const lines = [
      "# Documentation index: " + group,
      "",
      "Generated from the canonical K7PL " + sourceName + "/ tree.",
      "",
    ];
    for (const file of files) {
      if (file.relative === "HOME.md") continue;
      const page = renderedPages.find((item) => item.source === sourceName + "/" + file.relative);
      if (page) lines.push("- [" + page.title.replace(/[\[\]]/g, "") + "](" +
        page.target.replace(/\.md$/i, "") + ") (" + file.relative + ")");
    }
    if (lines.length === 4) lines.push("- No pages in this group.");
    await writeFile(join(destination, target), lines.join("\n") + "\n", "utf8");
    generatedIndexes.push(target);
  }

  const quickLinks = [
    ["Architecture", "ARCHITECTURE.md"],
    ["Understanding", "understanding.md"],
    ["Layers", "layers.md"],
    ["Research", "RESEARCH.md"],
    ["Research", "research.md"],
    ["Method", "METHOD.md"],
    ["Assurance", "ASSURANCE.md"],
    ["Provenance", "PROVENANCE.md"],
    ["Status", "STATUS.md"],
  ].filter(([, target]) => pageTargets.has(target));
  const sidebarLines = [
    "## K7PL documentation",
    "",
    "- [Home](Home)",
    ...quickLinks.map(([label, target]) =>
      "- [" + label + "](" + pageTargets.get(target).replace(/\.md$/i, "") + ")"
    ),
    "",
    "### Source tree indexes",
    ...generatedIndexes.map((target) => {
      const group = [...groups.keys()].find((key) => indexName(key) === target);
      return "- [" + group + "](" + target.replace(/\.md$/i, "") + ")";
    }),
    "",
  ];
  await writeFile(join(destination, GENERATED_SIDEBAR), sidebarLines.join("\n"), "utf8");

  const sortedManifestFiles = manifestFiles.sort((a, b) => a.source.localeCompare(b.source));
  const manifest = {
    schema_version: 1,
    repository,
    source_ref: sourceRef,
    source_commit_url: "https://github.com/" + repository + "/commit/" + sourceRef,
    source_directory: sourceName + "/",
    excluded_paths: [sourceName + "/archives/**"],
    page_count: renderedPages.length,
    resource_count: sourceFiles.length - markdownFiles.length,
    generated_files: [
      GENERATED_SIDEBAR, GENERATED_PUBLICATION, GENERATED_MANIFEST, ...generatedIndexes,
    ].sort(),
    files: sortedManifestFiles,
  };
  const publication = [
    "# K7PL wiki publication",
    "",
    "- Canonical source: " + sourceName + "/ at commit " + sourceRef.slice(0, 12) +
      " (https://github.com/" + repository + "/commit/" + sourceRef + ").",
    "- Source of truth: the repository, changed through pull requests.",
    "- Export scope: every file below " + sourceName + "/ except " + sourceName + "/archives/** and the temporary _migration-matrix.md.",
    "- Markdown pages use deterministic, collision-checked wiki names; source paths and SHA-256 hashes are recorded in Publication-manifest.json.",
    "- Non-Markdown files are copied under assets/ and hashed in the manifest.",
    "- Links to excluded archive files point back to the immutable source commit.",
    "- Each publication replaces wiki files with generated output; Git history is retained and no force-push is used.",
    "",
    "## Export counts",
    "",
    "- Markdown source pages: " + renderedPages.length,
    "- Non-Markdown resources: " + (sourceFiles.length - markdownFiles.length),
    "- Generated indexes: " + generatedIndexes.length,
    "- Excluded directory: " + sourceName + "/archives/",
    "",
    "The manifest records source paths, output paths, source digests, and published digests. It does not claim that GitHub's renderer validates Markdown semantics or external URLs.",
    "",
  ].join("\n");
  await writeFile(join(destination, GENERATED_PUBLICATION), publication, "utf8");
  await writeFile(join(destination, GENERATED_MANIFEST), JSON.stringify(manifest, null, 2) + "\n", "utf8");

  return {
    pageCount: renderedPages.length,
    resourceCount: sourceFiles.length - markdownFiles.length,
    indexCount: generatedIndexes.length,
    files: sortedManifestFiles.length,
    excludedPaths: [sourceName + "/archives/**"],
    outputDir: destination,
  };
}

const currentFile = fileURLToPath(import.meta.url);
if (process.argv[1] && resolve(process.argv[1]) === currentFile) {
  const sourceDir = process.env.K7PL_DOCS_SOURCE || "wiki";
  const destDir = process.env.K7PL_WIKI_DEST || "wiki-export";
  const repository = process.env.K7PL_REPOSITORY || process.env.GITHUB_REPOSITORY;
  const sourceRef = process.env.K7PL_SOURCE_REF || process.env.GITHUB_SHA;
  try {
    const summary = await buildWikiExport({ sourceDir, destDir, repository, sourceRef });
    process.stdout.write(JSON.stringify(summary, null, 2) + "\n");
  } catch (error) {
    process.stderr.write("Wiki export failed: " + error.message + "\n");
    process.exitCode = 1;
  }
}
