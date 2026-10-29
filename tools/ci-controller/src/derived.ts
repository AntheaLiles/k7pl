// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * D2 slice 2: the classifier derived from the registry. Since cutover C3,
 * it decides all thirteen surfaces: the impact job emits them from
 * derived_event.ts. Since cutover C4 it is the only classifier: the
 * legacy Python classifier (scripts/ci/impact.py), its Deno port and
 * the shadow comparisons that ran them were removed.
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
 * Its decided divergences from the former legacy classifier, which
 * the shadow comparison reported until C4, were of three kinds:
 *   - intended: proofs/ now maps to axiom_audit instead of
 *     full, tla-models to tla_model_check instead of full,
 *     src/k/ to the K surfaces (lean_build over-triggering
 *     removed) — these are the decided D2 behaviours, and
 *     their coverage preservation is proven in the
 *     orchestration slice, not here;
 *   - closed in cutover C0: light paths (.claude/,
 *     .github/ISSUE_TEMPLATE/, LICENSES/, CITATION.cff) and
 *     scripts/axiom-audit.sh are now classifier-resident rules
 *     in this file, reproducing the legacy treatment verbatim
 *     (light = no surface; axiom-audit.sh = lean_build +
 *     spec_build), instead of falling through to component
 *     roots or to full;
 *   - other non-Markdown files under wiki/ and
 *     theoretical-projects/, which the legacy classifier
 *     leaves unclassified (hence full) while the registry
 *     maps them to docs_links.
 * The C3 cutover accepted these divergences as the decided
 * behaviour; tests/derived_test.ts asserts each of them directly.
 */

import type { Component, Registry } from "./registry.ts";
import { IMPACT_SURFACES, type ImpactSurface } from "./registry.ts";
import { REPORT_KEYS } from "./changes.ts";

export type DerivedSurface = ImpactSurface;

export interface DerivedClassification {
  surfaces: Record<DerivedSurface, boolean>;
  /** The eight report keys (changes.ts REPORT_KEYS) the workflows read. */
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
 * eight report keys, in the order the former impact.py wrote them,
 * then the five gating surfaces. */
export function derivedDecisionOutputLines(
  derived: DerivedClassification,
): string[] {
  return [
    ...REPORT_KEYS.map(
      (key) => `${key}=${String(derived[key]).toLowerCase()}`,
    ),
    ...derivedGithubOutputLines(derived),
  ];
}
