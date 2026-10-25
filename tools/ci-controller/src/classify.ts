// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * Impact classification, ported faithfully from
 * scripts/ci/impact.py (same tables, same order of rules, same
 * outputs). Do NOT "fix" divergences here: parity with the Python
 * classifier is the contract of slice 1, and any behaviour change
 * is a separate, owner-approved decision.
 *
 * Known quirk preserved on purpose: wiki/research.md classifies
 * as docs_links only, although scripts/controles/croise.py reads
 * it (see the CI audit). Changing that rule would change which
 * checks run on wiki/research.md changes, and is therefore an
 * open decision, not a silent port correction.
 *
 * Rule order, copied from impact.py classify(): per path, the
 * additive "read by another surface" rules run first, then a
 * single if/elif chain assigns the path to one surface family.
 * A path that matches no branch is unclassified, and any
 * unclassified path forces full validation.
 */

export const FULL_EXACT = new Set([
  ".github/dependabot.yml",
  "lakefile.lean",
  "lean-toolchain",
  "lake-manifest.json",
  "scripts/sync_zenodo.py",
  "scripts/requirements-zenodo.txt",
]);
export const FULL_PREFIXES = [".github/workflows/", "scripts/ci/"];
export const LEAN_PREFIXES = ["src/", "tests/"];
export const LEAN_AND_SPEC_BUILD_EXACT = new Set(["scripts/axiom-audit.sh"]);
export const SPEC_BUILD_EXACT = new Set([
  "scripts/controle.py",
  "scripts/manuscript_metrics.py",
  "wiki/references.json",
]);
export const SPEC_BUILD_PREFIXES = [
  "spec/",
  "tools/",
  "scripts/controles/",
  "scripts/biblio/",
];
export const SPEC_CHECK_EXACT = new Set<string>();
export const LIGHT_PREFIXES = [
  "docs/",
  ".claude/",
  ".github/ISSUE_TEMPLATE/",
  "LICENSES/",
];
export const LIGHT_EXACT = new Set(["CITATION.cff"]);
export const PYTHON_TEST_EXACT = new Set([
  "scripts/generate_status.py",
]);
export const PYTHON_TEST_PREFIXES = ["tests/python/"];
export const PYTHON_TEST_READ_EXACT = new Set(["wiki/assurance.md"]);
export const PYTHON_TEST_READ_PREFIXES = ["src/"];
export const SPEC_CHECK_READ_PREFIXES = ["src/"];
export const LEAN_BUILD_READ_EXACT = new Set([
  "tools/SpecExt/IndexCore.lean",
  "tools/SpecExt/IndexTerms.lean",
  "tools/SpecExt/Translate.lean",
]);
export const LEAN_BUILD_READ_PREFIXES = ["tools/Compliance/"];

export interface Classification {
  full: boolean;
  docs_links: boolean;
  spec_check: boolean;
  spec_build: boolean;
  lean_build: boolean;
  python_tests: boolean;
  tracking_views: boolean;
  unclassified: boolean;
  unknown_paths: string[];
}

export const SURFACE_KEYS = [
  "full",
  "docs_links",
  "spec_check",
  "spec_build",
  "lean_build",
  "python_tests",
  "tracking_views",
  "unclassified",
] as const;

function startsWithAny(path: string, prefixes: readonly string[]): boolean {
  return prefixes.some((prefix) => path.startsWith(prefix));
}

function isMarkdown(path: string): boolean {
  const lower = path.toLowerCase();
  return lower.endsWith(".md") || lower.endsWith(".markdown");
}

export function classify(
  paths: readonly string[],
  forceFull = false,
): Classification {
  let full = forceFull;
  let docsLinks = false;
  let specCheck = false;
  let specBuild = false;
  let leanBuild = false;
  let pythonTests = false;
  let trackingViews = forceFull;
  const unknown: string[] = [];

  for (const path of paths) {
    if (isMarkdown(path)) docsLinks = true;
    if (
      PYTHON_TEST_READ_EXACT.has(path) ||
      startsWithAny(path, PYTHON_TEST_READ_PREFIXES)
    ) {
      pythonTests = true;
    }
    if (startsWithAny(path, SPEC_CHECK_READ_PREFIXES)) specCheck = true;
    if (
      LEAN_BUILD_READ_EXACT.has(path) ||
      startsWithAny(path, LEAN_BUILD_READ_PREFIXES)
    ) {
      leanBuild = true;
    }

    if (FULL_EXACT.has(path) || startsWithAny(path, FULL_PREFIXES)) {
      full = true;
    } else if (
      SPEC_BUILD_EXACT.has(path) || startsWithAny(path, SPEC_BUILD_PREFIXES)
    ) {
      specCheck = true;
      specBuild = true;
      pythonTests = true;
    } else if (SPEC_CHECK_EXACT.has(path)) {
      specCheck = true;
    } else if (
      PYTHON_TEST_EXACT.has(path) || startsWithAny(path, PYTHON_TEST_PREFIXES)
    ) {
      pythonTests = true;
    } else if (startsWithAny(path, LEAN_PREFIXES)) {
      leanBuild = true;
    } else if (LEAN_AND_SPEC_BUILD_EXACT.has(path)) {
      leanBuild = true;
      specBuild = true;
    } else if (
      isMarkdown(path) || startsWithAny(path, LIGHT_PREFIXES) ||
      LIGHT_EXACT.has(path)
    ) {
      // Light path: only the link check (already set for Markdown).
    } else {
      unknown.push(path);
    }
  }

  if (unknown.length > 0) full = true;

  if (full) {
    trackingViews = true;
    docsLinks = true;
    specCheck = true;
    specBuild = true;
    leanBuild = true;
    pythonTests = true;
  }

  return {
    full,
    docs_links: docsLinks,
    spec_check: specCheck,
    spec_build: specBuild,
    lean_build: leanBuild,
    python_tests: pythonTests,
    tracking_views: trackingViews,
    unclassified: unknown.length > 0,
    unknown_paths: unknown,
  };
}

/** Python repr() quoting, as impact.py prints paths (single quotes). */
function pythonRepr(path: string): string {
  return `'${path.replace(/\\/g, "\\\\").replace(/'/g, "\\'")}'`;
}

/** The human-readable report, in the same shape as impact.py prints. */
export function formatClassification(
  paths: readonly string[],
  result: Classification,
): string {
  const lines: string[] = [];
  lines.push(`Changed paths: ${paths.length}`);
  for (const path of paths) lines.push(`  ${pythonRepr(path)}`);
  const parts = SURFACE_KEYS.map((key) =>
    `${key}=${String(result[key]).toLowerCase()}`
  );
  lines.push(`Impact: ${parts.join(" ")}`);
  if (result.unknown_paths.length > 0) {
    lines.push("Unclassified paths:");
    for (const path of result.unknown_paths) {
      lines.push(`  ${pythonRepr(path)}`);
    }
  }
  return lines.join("\n");
}

/** The GITHUB_OUTPUT lines, in the same key order as impact.py. */
export function githubOutputLines(result: Classification): string[] {
  return SURFACE_KEYS.map((key) =>
    `${key}=${String(result[key]).toLowerCase()}`
  );
}

/** Paths that differ between two commits (git diff, no renames). */
export async function changedPaths(
  base: string,
  head: string,
): Promise<string[]> {
  const command = new Deno.Command("git", {
    args: ["diff", "--name-only", "--no-renames", base, head],
    stdout: "piped",
    stderr: "piped",
  });
  const { code, stdout, stderr } = await command.output();
  if (code !== 0) {
    const detail = new TextDecoder().decode(stderr).trim();
    throw new Error(
      `impact: git diff ${base} ${head} failed with exit status ${code}: ${detail}`,
    );
  }
  return new TextDecoder().decode(stdout).split("\n").filter((line) =>
    line !== ""
  );
}
