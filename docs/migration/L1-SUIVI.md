<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Semantic qualification of suivi/

Status: IN PROGRESS.

This lot qualifies the legacy suivi/ corpus by knowledge function rather than by file location. The physical relocation is closed; no legacy file is moved, deleted, or rewritten by this register. Old location names in historical source records are provenance labels, not current paths.

**Reconciliation performed on 2026-10-11:** `main` was observed at commit [`86959948ff36deb6e8ee0985cf22740787696720`](https://github.com/AntheaLiles/k7pl/commit/86959948ff36deb6e8ee0985cf22740787696720); the candidate PR #153 is now at `9c34e7aaa99e00809c00d56812ab2160b55c276d`, with CI run [`38131422345`](https://github.com/AntheaLiles/k7pl/actions/runs/38131422345) successful. The targeted checks for ANOM-04/09/10 are recorded in `ANOMALIES.md`, `L1-DECISIONS.md` and `L5-VALIDATION.md`. ANOM-09 is technically closed on the candidate's actual PDF; ANOM-04 still requires the author's scope choice and ANOM-10 remains partially localized. This is not completion of the proposition-level review of all 13 sources. L1 remains IN PROGRESS.

| Source | Destination(s) | Nature | Epistemic state | Action | Provenance |
|---|---|---|---|---|---|
| ANOMALIES.md | ASSURANCE.md; docs/peer-review/; docs/archives/ | conversion audit | preuve; critique; historique | Extract assurance-relevant conclusions and unresolved limitations; preserve full audit | source retained |
| DECISIONS.md | METHOD.md; RESEARCH.md; ASSURANCE.md; docs/archives/ | decision register | décision; hypothèse; établi; historique | Separate binding decisions from pending ratifications and historical rationale | source retained |
| FICHES-PR02.md | docs/peer-review/; ASSURANCE.md; docs/archives/ | generated campaign status | observation; preuve; historique | Retain evidence; extract only current assurance conclusions | generated from source records |
| TABLEAU-DE-BORD.md | STATUS.md; ASSURANCE.md; RESEARCH.md; docs/archives/ | operational/scientific dashboard | observation; décision; preuve; historique | Replace machine facts with CI status; extract scientific state and gates | source retained |
| correspondance-enonces.md | ASSURANCE.md; docs/archives/ | generated traceability map | preuve | Preserve as traceability evidence | generated artifact |
| correspondance-theoremes-org.md | ASSURANCE.md; docs/archives/ | cross-version correspondence | preuve; historique | Preserve Org→Verso provenance | source retained |
| factorisations-refusees.md | ASSURANCE.md; RESEARCH.md; docs/archives/ | rejected proof routes | critique; décision; preuve; historique | Extract conclusions affecting current claims; preserve detailed refusals | source retained |
| fiches-statuts.csv | docs/peer-review/; docs/archives/ | structured review status input | observation; décision; preuve | Keep as provenance; do not duplicate into current prose | source retained |
| hypotheses-de-module.md | ARCHITECTURE.md; RESEARCH.md; ASSURANCE.md | architecture hypotheses | hypothèse; décision | Extract active hypotheses; mark superseded ones | source retained |
| pr-02-plan-de-traitement.md | METHOD.md; docs/peer-review/; docs/archives/ | campaign plan | décision; historique | Extract durable workflow rules; archive campaign sequencing | source retained |
| primitives.md | ARCHITECTURE.md; METHOD.md; RESEARCH.md; docs/archives/ | terminology/design inventory | décision; hypothèse; établi | Extract stabilized terminology and rationale | source retained |
| registre-empirique.md | RESEARCH.md; ASSURANCE.md; docs/archives/ | empirical commitments | preuve; hypothèse; observation | Separate protocols from measurements not conducted | source retained |
| 2026-10-01-registre-obligations.md | ASSURANCE.md; RESEARCH.md; docs/archives/ | historical claim/dependency snapshot | établi; hypothèse; preuve; historique | Reconcile against current spec before current use | source retained |

## Evidence verified on the current candidate (2026-10-11)

- **Normative/source boundary:** `main` @ `86959948ff36deb6e8ee0985cf22740787696720` imports Annexe A; B/C/D modules are absent from `spec/`, while prototypes and historical Org sources remain in their existing locations. This is a current tree fact, not a choice ratified by the author. D-7/ANOM-04 remains open.
- **PDF/index:** PR candidate `9c34e7aaa99e00809c00d56812ab2160b55c276d`, run `38131422345`, `spec-pdf` artifact `11699506098` (287 pages) visually checked on printed pages 277–278. Index page references are present, red hyperlink frames are absent, and `spec-pdf-log` (`11699366281`) has no unresolved `idx-*` references; the new CI guard passed. ANOM-09 is closed on the candidate.
- **HTML/localization:** `spec-html` artifact `11699620857` contains 67 HTML files, all with `lang="fr"`; `find/index.html` title and two visible headings are localized. This does not establish complete localization of all dynamic/ARIA strings. Verso v4.34.0's inspected `HtmlConfig` has no locale option; proposal is drafted but unsubmitted. ANOM-10 remains open.
- **T-68:** the current register `primitives.md` lists 45 rows marked `DOING` (dated 2026-10-08); 44 is a historical count. The number of distinct normative primitives is not yet established.

## Qualification rules

Generated material is not manually reproduced where a current machine source exists. DECISIONS.md is a provenance/decision register, not a substitute for author ratification or the normative source. ANOMALIES.md and factorisations-refusees.md are critical evidence, not normative truth. registre-empirique.md distinguishes protocols from empirical results. `docs/history/2026-10-01-registre-obligations.md` is an historical snapshot and must be reconciled with the current Verso specification. For each migrated proposition, record (1) source and exact location, (2) epistemic role, (3) current owner or explicit absence, (4) comparison against current Verso, (5) contradictions and confidence, and (6) checks actually executed.

## Acceptance criteria

The lot remains IN PROGRESS until every source is reviewed proposition by proposition; current, hypothetical, evidentiary, critical and historical material are separated; current claims have precise provenance and are compared against current Verso; generated facts have a machine-derived owner; contradictions and missing evidence are explicit; checks are recorded as observed; and no physical move is treated as semantic completion. A source file's presence in this table is not proof that its propositions were fully reviewed.
