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

The final candidate must pass:

python3 scripts/ci/check_documentation_architecture.py

python3 -m unittest discover -s scripts/ci -p 'test_*.py'

the complete GitHub Actions CI, including documentation links, REUSE, security checks, the Verso build/render, PDF compilation, Lean build/tests/lint/axiom audits, and CI OK.

The final validation must also confirm that docs/STATUS.md is generated from the actual validated commit and that no current obligation exists only in history/ or archives/.

This record is a migration validation artefact. It does not assert that the scientific claims of K7PL are correct; it establishes only that the repository architecture and its declared validation controls are internally coherent.
