// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
//
// SPDX-License-Identifier: CECILL-2.1

/**
 * D2 slice 2: the classifier derived from the registry, run in
 * shadow only. It does NOT replace the legacy classifier yet.
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
 * Known divergences from the legacy classifier, reported by
 * --derived-shadow and NOT hidden here, are of three kinds:
 *   - intended: proofs/ now maps to axiom_audit instead of
 *     full, tla-models to tla_model_check instead of full,
 *     src/k/ to the K surfaces (lean_build over-triggering
 *     removed) — these are the decided D2 behaviours, and
 *     their coverage preservation is proven in the
 *     orchestration slice, not here;
 *   - registry gaps to close before cutover: light paths
 *     (.claude/, .github/ISSUE_TEMPLATE/, LICENSES/,
 *     CITATION.cff) and scripts/axiom-audit.sh, which the
 *     legacy classifier treats specially and no component
 *     claims;
 *   - other non-Markdown files under wiki/ and
 *     theoretical-projects/, which the legacy classifier
 *     leaves unclassified (hence full) while the registry
 *     maps them to docs_links.
 * The shadow report lists every divergence per path; the
 * cutover decision must disposition each kind explicitly.
 */

import type { Component, Registry } from "./registry.ts";
import { IMPACT_SURFACES, type ImpactSurface } from "./registry.ts";

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
