<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L5 — Migration validation

This record closes the controlled documentation-tree migration at the repository level. It distinguishes structural validation from scientific validity and preserves the baseline used for comparison.

## Baseline and candidate

| Measure | Baseline (main, bf437f0) | Candidate branch |
|---|---:|---:|
| Repository files | 437 | 444 |
| Markdown files under docs/ | 133 | 136 |
| Root biblio/ | present (references.json) | removed |
| docs/bibliography/ files | 7 | 8 |
| Legacy documentation directories | 0 after PR #58 | 0 |

The additional Markdown files are the English current-entry replacements for provenance and the dashboard, plus the migration-validation record. Their previous French versions are preserved under docs/history/.

## Bibliography consolidation

docs/bibliography/references.json is now the single active machine-readable bibliography source. The former root biblio/references.json no longer exists. The generation path is:

docs/bibliography/references.json → scripts/biblio/biblio.py → tools/SpecBib.lean.

The CI impact classifier treats docs/bibliography/ as specification-affecting, so changing the source bibliography cannot silently bypass the specification build.

## D7 language scope

Current reader-facing entry points and generated views are maintained in English. Evidence-bearing registers, review records, research notes, bibliography acquisition records, and migration evidence may retain French when translation would alter provenance. The English entry points identify those records and distinguish them from normative specification content.

## D8 validation protocol

The validated candidate passed:

CI run #473 on commit `bcd249f9cc59b0dbdfd7bde50230a224d2b1b7bf`: the architecture guard, Python CI tooling, documentation links, REUSE, security checks, Verso build/render, PDF compilation, Lean build/tests/lint/axiom audits, and `CI OK` all passed. The PR-only workflow intentionally skips the `Generated status` job, which executes only after a successful push to `main`; that post-merge gate remains open by design.

The validated inventory contains no root `biblio/`; `docs/bibliography/references.json` is the sole active bibliography source. No current obligation is relocated into `history/` or `archives/` by this migration.

This record is a migration validation artefact. It does not assert that the scientific claims of K7PL are correct; it establishes only that the repository architecture and its declared validation controls are internally coherent.
