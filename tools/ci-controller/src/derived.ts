// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * D2 slice 2: the classifier derived from the registry. Since cutover C3,
 * it decides all thirteen surfaces: the impact job emits them from
 * derived_event.ts, and the legacy Python classifier runs only in
 * reversed shadow (controller-shadow, non-blocking).
 *
 * Derivation rule, exactly as decided (D2, 2026-10-25): a path
 * triggers the impact_surfaces of every component whose roots
 * contain it (respecting that component's excludes), plus the
 * impact_surfaces of every component whose read_inputs contain
 * it. Two classifier-resident rules remain, because they are not
 * component tables: any Markdown file triggers docs_links, and
 * any path matched by no component is unclassified and forces
 * full validation (fail-closed, as in the legacy classifier).
 *
 * When full is forced, every surface is set, including the new
 * derivation targets (axiom_audit, k_*, tla_model_check): an
 * unknown path must not silently drop a surface that no
 * component claims. This is conservative by design.
 *
 * Known divergences from the legacy classifier are kept visible by
 * --derived-shadow, but an exact allowlist prevents reviewed migration
 * deltas from making the diagnostic job red. The allowlist matches both
 * the path family and the complete legacy-surface delta; a new or
 * different delta remains unexpected. It covers:
 *   - intended D2 targets: proofs/ -> axiom_audit, TLA models ->
 *     tla_model_check, and src/k/ -> K surfaces without lean_build;
 *   - the PR #311 path migration: lexicon/ -> specification and K
 *     inputs, lib/ -> K examples, and renamed/moved scripts -> the
 *     python-tooling component;
 *   - wiki/references.json, which is both a spec-build read input
 *     and part of the wiki root, so derived also triggers docs_links;
 * The cutover C0 light-path and axiom-audit exceptions are implemented
 * directly in the derived classifier and therefore need no allowlist entry.
 * The TLA model path and wiki/references.json exception above are the
 * non-Markdown documentation-tree cases explicitly reviewed here.
 *
 * The allowlist is diagnostic compatibility only: the derived
 * classifier remains authoritative, and it does not weaken fail-closed
 * handling of unclassified paths in that classifier.
 */

import type { Component, Registry } from "./registry.ts";
import { IMPACT_SURFACES, type ImpactSurface } from "./registry.ts";
import { SURFACE_KEYS } from "./classify.ts";

export type DerivedSurface = ImpactSurface;

export interface DerivedClassification {
  surfaces: Record<DerivedSurface, boolean>;
  /** Legacy surface keys, for parity comparison with classify(). */
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

function isMarkdown(path: string): boolean {
  const lower = path.toLowerCase();
  return lower.endsWith(".md") || lower.endsWith(".markdown");
}

function matches(path: string, entry: string): boolean {
  if (entry.endsWith("/")) return path.startsWith(entry);
  return path === entry;
}

function componentMatches(component: Component, path: string): boolean {
  const underRoot = component.roots.some((root) => matches(path, root));
  if (!underRoot) return false;
  return !component.excludes.some((exclude) => matches(path, exclude));
}

// Classifier-resident rules, not components (the registry header says
// so explicitly): the legacy classifier's light paths and its exact
// surface rules. They are reproduced here verbatim so the derived
// classifier does not over-trigger on paths the legacy classifier
// deliberately treats as light, and does not mis-assign the one
// script the legacy classifier routes by exact path.
// - Light paths trigger no surface at all (the external-links job
//   is not gated by a surface; a light-only change runs no other
//   check). This matches the legacy LIGHT_PREFIXES / LIGHT_EXACT.
// - scripts/axiom-audit.sh triggers lean_build + spec_build only,
//   exactly as the legacy LEAN_AND_SPEC_BUILD_EXACT rule. It must
//   NOT also pick up python_tests from the python-tooling root
//   (scripts/), which is why the exact rule short-circuits the
//   component matching below. Revisit when the script is ported
//   to Deno (cutover C5): the ported command keeps these surfaces.
const LIGHT_PREFIXES = [
  ".claude/",
  ".github/ISSUE_TEMPLATE/",
  "LICENSES/",
];
const LIGHT_EXACT = new Set(["CITATION.cff"]);
const EXACT_SURFACE_RULES: Record<string, DerivedSurface[]> = {
  "scripts/axiom-audit.sh": ["lean_build", "spec_build"],
};

function isLight(path: string): boolean {
  return LIGHT_EXACT.has(path) ||
    LIGHT_PREFIXES.some((prefix) => path.startsWith(prefix));
}

// Cutover C0, author decision 2026-10-26: a non-Markdown file
// under wiki/ or theoretical-projects/ stays fail-closed (full),
// exactly as the legacy classifier leaves it unclassified — even
// though the documentation components would otherwise map it to
// docs_links. Two exceptions keep their normal treatment: files
// claimed by the tla-models component (the D01 models, which D2
// deliberately maps to tla_model_check) and declared read inputs
// (wiki/references.json, a spec-build input). Markdown files are
// unaffected: they map to docs_links in both classifiers.
function isDocsTree(path: string): boolean {
  return path.startsWith("wiki/") ||
    path.startsWith("theoretical-projects/");
}

export function deriveClassification(
  registry: Registry,
  paths: readonly string[],
  forceFull = false,
): DerivedClassification {
  const surfaces = Object.fromEntries(
    IMPACT_SURFACES.map((surface) => [surface, false]),
  ) as Record<DerivedSurface, boolean>;
  const unknown: string[] = [];
  let full = forceFull;

  for (const path of paths) {
    if (isMarkdown(path)) surfaces.docs_links = true;
    let claimed = false;
    const exactSurfaces = EXACT_SURFACE_RULES[path];
    if (exactSurfaces !== undefined) {
      claimed = true;
      for (const surface of exactSurfaces) surfaces[surface] = true;
    } else if (isLight(path)) {
      // Light path: claimed, no surface. See LIGHT_PREFIXES above.
      claimed = true;
    }
    // Classifier-resident rules short-circuit component matching:
    // an exact rule or a light path must not also pick up the
    // surfaces of a component whose root happens to contain it.
    if (exactSurfaces !== undefined || isLight(path)) {
      if (!claimed && !isMarkdown(path)) unknown.push(path);
      continue;
    }
    // Conservative docs-tree rule (C0 decision, see above): a
    // non-Markdown file under wiki/ or theoretical-projects/
    // forces full, unless the tla-models component claims it or
    // it is a declared read input.
    if (isDocsTree(path) && !isMarkdown(path)) {
      const tlaComponent = registry.components.find((c) =>
        c.id === "tla-models"
      );
      const claimedByTla = tlaComponent !== undefined &&
        componentMatches(tlaComponent, path);
      const isReadInput = registry.components.some((component) =>
        component.readInputs.some((input) => matches(path, input.path))
      );
      if (!claimedByTla && !isReadInput) {
        unknown.push(path);
        continue;
      }
    }
    for (const component of registry.components) {
      if (componentMatches(component, path)) {
        claimed = true;
        for (const surface of component.impactSurfaces) {
          surfaces[surface] = true;
        }
      }
      for (const input of component.readInputs) {
        if (matches(path, input.path)) {
          claimed = true;
          for (const surface of input.surfaces ?? component.impactSurfaces) {
            surfaces[surface] = true;
          }
        }
      }
    }
    if (!claimed && !isMarkdown(path)) unknown.push(path);
  }

  // A component surface of `full` is full validation, exactly as
  // an unclassified path is; the expansion below then follows.
  if (surfaces.full) full = true;
  if (unknown.length > 0) full = true;
  if (full) {
    for (const surface of IMPACT_SURFACES) surfaces[surface] = true;
  }

  return {
    surfaces,
    full,
    docs_links: surfaces.docs_links,
    spec_check: surfaces.spec_check,
    spec_build: surfaces.spec_build,
    lean_build: surfaces.lean_build,
    python_tests: surfaces.python_tests,
    // tracking_views is a legacy output, not a registry surface:
    // it follows full, exactly as in the legacy classifier.
    tracking_views: full,
    unclassified: unknown.length > 0,
    unknown_paths: unknown,
  };
}

/** Legacy surface keys shared by classify() and deriveClassification(). */
export const LEGACY_KEYS = [
  "full",
  "docs_links",
  "spec_check",
  "spec_build",
  "lean_build",
  "python_tests",
  "tracking_views",
  "unclassified",
] as const;

/** New derivation targets wired to jobs by cutover C2 (impact outputs). */
export const DERIVED_GATING_SURFACES = [
  "axiom_audit",
  "k_compile",
  "k_examples",
  "klean_export",
  "tla_model_check",
] as const;

/** GITHUB_OUTPUT lines for the derived gating surfaces, in registry order. */
export function derivedGithubOutputLines(
  derived: DerivedClassification,
): string[] {
  return DERIVED_GATING_SURFACES.map(
    (surface) =>
      `${surface}=${String(derived.surfaces[surface]).toLowerCase()}`,
  );
}

/** The thirteen decision lines for the impact job (cutover C3): the
 * eight legacy keys in impact.py order, then the five gating
 * surfaces. */
export function derivedDecisionOutputLines(
  derived: DerivedClassification,
): string[] {
  return [
    ...SURFACE_KEYS.map(
      (key) => `${key}=${String(derived[key]).toLowerCase()}`,
    ),
    ...derivedGithubOutputLines(derived),
  ];
}

/** Per-surface legacy-key divergences between derived and legacy. */
export function derivedDivergences(
  derived: DerivedClassification,
  legacy: {
    [K in (typeof LEGACY_KEYS)[number]]: boolean;
  },
): string[] {
  const divergences: string[] = [];
  for (const key of LEGACY_KEYS) {
    if (derived[key] !== legacy[key]) {
      divergences.push(
        `${key}: derived=${derived[key]} legacy=${legacy[key]}`,
      );
    }
  }
  return divergences;
}

// Reviewed path-specific deltas between the registry-derived classifier
// and the legacy classifier. A rule matches only when BOTH the path
// family and the complete set of legacy-key differences match.
const LEGACY_FULL_FALLBACK_ALL_KEYS = [
  "full: derived=false legacy=true",
  "docs_links: derived=false legacy=true",
  "spec_check: derived=false legacy=true",
  "spec_build: derived=false legacy=true",
  "lean_build: derived=false legacy=true",
  "python_tests: derived=false legacy=true",
  "tracking_views: derived=false legacy=true",
  "unclassified: derived=false legacy=true",
];
const LEGACY_FULL_FALLBACK_EXCEPT_PYTHON = [
  "full: derived=false legacy=true",
  "docs_links: derived=false legacy=true",
  "spec_check: derived=false legacy=true",
  "spec_build: derived=false legacy=true",
  "lean_build: derived=false legacy=true",
  "tracking_views: derived=false legacy=true",
  "unclassified: derived=false legacy=true",
];
const LEGACY_FULL_FALLBACK_FOR_LEXICON = [
  "full: derived=false legacy=true",
  "docs_links: derived=false legacy=true",
  "lean_build: derived=false legacy=true",
  "python_tests: derived=false legacy=true",
  "tracking_views: derived=false legacy=true",
  "unclassified: derived=false legacy=true",
];
const EXPECTED_DERIVED_DIVERGENCES: Array<{
  prefix?: string;
  path?: string;
  differences: string[];
}> = [
  { prefix: "proofs/", differences: LEGACY_FULL_FALLBACK_ALL_KEYS },
  {
    prefix: "theoretical-projects/k7os/models/",
    differences: LEGACY_FULL_FALLBACK_ALL_KEYS,
  },
  { prefix: "src/k/", differences: ["lean_build: derived=false legacy=true"] },
  { prefix: "lexicon/", differences: LEGACY_FULL_FALLBACK_FOR_LEXICON },
  { prefix: "lib/", differences: LEGACY_FULL_FALLBACK_ALL_KEYS },
  {
    prefix: "scripts/controles/",
    differences: LEGACY_FULL_FALLBACK_EXCEPT_PYTHON,
  },
  {
    path: "scripts/controle.py",
    differences: LEGACY_FULL_FALLBACK_EXCEPT_PYTHON,
  },
  {
    path: "scripts/verif_singularites.py",
    differences: LEGACY_FULL_FALLBACK_EXCEPT_PYTHON,
  },
  {
    path: "scripts/check_singularities.py",
    differences: LEGACY_FULL_FALLBACK_EXCEPT_PYTHON,
  },
  {
    path: "wiki/references.json",
    differences: ["docs_links: derived=true legacy=false"],
  },
];

/** True only for a reviewed path family with its exact expected delta. */
export function isExpectedDerivedDivergence(
  path: string,
  divergences: readonly string[],
): boolean {
  const rule = EXPECTED_DERIVED_DIVERGENCES.find((candidate) =>
    candidate.path === path ||
    (candidate.prefix !== undefined && path.startsWith(candidate.prefix))
  );
  if (rule === undefined) return false;
  const actual = [...divergences].sort();
  const expected = [...rule.differences].sort();
  return actual.length === expected.length &&
    actual.every((value, index) => value === expected[index]);
}

