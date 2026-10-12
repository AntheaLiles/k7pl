<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L5 — Migration validation

This record distinguishes the **closed physical documentation-tree migration** from the still-open semantic qualification of historical propositions. The metrics and PR #58 validation below are historical evidence for the structural move, not a current baseline for proposition-level qualification and not evidence of scientific validity.

## Historical structural baseline and candidate (PR #58; not a current count)

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

## Historical D8 validation record (PR #58)

The validated candidate passed:

CI run #473 on commit `bcd249f9cc59b0dbdfd7bde50230a224d2b1b7bf`: the architecture guard, Python CI tooling, documentation links, REUSE, security checks, Verso build/render, PDF compilation, Lean build/tests/lint/axiom audits, and `CI OK` all passed. The PR-only workflow intentionally skips the `Generated status` job, which executes only after a successful push to `main`; that post-merge gate remains open by design.

The validated inventory contains no root `biblio/`; `docs/bibliography/references.json` is the sole active bibliography source. No current obligation is relocated into `history/` or `archives/` by this migration.

This record is a migration validation artefact. It does not assert that the scientific claims of K7PL are correct; it establishes only that the repository architecture and its declared validation controls are internally coherent.


## Current observed baseline — 2026-10-11

Exact source reference: [`main` at `86959948ff36deb6e8ee0985cf22740787696720`](https://github.com/AntheaLiles/k7pl/commit/86959948ff36deb6e8ee0985cf22740787696720).

- **Actions evidence:** CI run [`38094667153`](https://github.com/AntheaLiles/k7pl/actions/runs/38094667153), attempt 2, completed with `success`; Scorecard run [`38094666898`](https://github.com/AntheaLiles/k7pl/actions/runs/38094666898) completed with `success`. The successful CI attempt includes the Verso build/render, navigation/provenance and HTML asset checks, Lean build/audits, Python test job, PDF compilation, `CI OK`, and GitHub Pages job. Attempt 1 failed while downloading Lean with a TLS error; that earlier attempt is not treated as a code validation failure or ignored as if it had not occurred.
- **PDF output check (baseline and candidate):** the actual `spec-pdf` artifact from `main` run `38094667153` (287 pages) had 31 index terms without pages on printed pp. 277–278, confirming ANOM-09 on the baseline. On candidate `9c34e7aaa99e00809c00d56812ab2160b55c276d`, PR run [`38131422345`](https://github.com/AntheaLiles/k7pl/actions/runs/38131422345) completed with `success`; actual `spec-pdf` artifact (`11699506098`) has 287 pages and an alphabetical index with page references on printed pp. 277–278. Rendered PDF pages 281–282 showed `ordonnancement` → `64, 82, 99, 171, 175, 233`, `substitution` continuing with page refs, and no red hyperlink boxes. `spec-pdf-log` artifact (`11699366281`) has no unresolved `idx-*` references; the CI guard `Reject unresolved index page references` passed. ANOM-09 is closed on this candidate; this does not complete L1/L5.
- **Verso HTML localization:** actual `spec-html` artifact (`11699620857`) from run `38131422345` contains 67 HTML files and all 67 declare `lang="fr"`. `find/index.html` no longer contains `Cross-Reference Redirection`; its `<title>` and both visible heading instances read `Redirection des références croisées`, verified on the generated HTML after adding an exact-string rule and unit test. This remains a bounded audit, not proof that all dynamic or future upstream UI strings are translated. Verso v4.34.0 `HtmlConfig` has no locale option in the inspected source; the upstream proposal is prepared but not submitted.
- **Annexes B/C/D:** `spec/Spec.lean` imports only Annexe A, while prototypes B/C/D are retained under `tooling/prototypes-bcd/` and original Org sources under `docs/archives/manuscrit-org/`. The appendix-scope decision D-7 remains open in `docs/tracking/DECISIONS.md`; the physical state is not a ratified editorial choice.
- **Remaining semantic gate:** L1 is not validated. Proposition-by-proposition qualification of all 13 in-scope historical tracking sources remains incomplete; D-7/ANOM-04 requires the author's A/B/C choice; ANOM-10 remains open pending a broader audit of visible/dynamic/accessibility strings and a decision on submitting the prepared upstream proposal. The generated `docs/migration/LEGACY-INVENTORY.md` remains a generator placeholder until its generator is run and its output reviewed.

## L1/L5 semantic acceptance criteria

L1 may be marked **UNDER REVIEW**, not **VALIDATED**, only when each in-scope source has a proposition-level record with a precise source location, epistemic class (current/decision, hypothesis, evidence or observation, critique, history), a comparison against the exact current Verso revision, destination/current owner or explicit no-promotion decision, unresolved contradictions, and confidence. Human decisions must be marked as human decisions; dates, generated values, tests and historical decisions must not be conflated. ANOM-09 may be closed independently because the actual PDF output and reference targets are observed; that closure does not substitute for the thirteen source reviews.

L5 may be **VALIDATED** only after (1) the required source-by-source review is complete, (2) all internal links and generated-source ownership checks pass on the candidate commit, (3) actual PDF and HTML outputs are checked for index targets, visual quality, language metadata and visible/localized UI strings within a declared scope, (4) each open anomaly is either closed by observed evidence or explicitly accepted as a documented residual, and (5) all author-only choices have been recorded by the author. A green CI by itself does not satisfy items (1), (3), (4) or (5).
