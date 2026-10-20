<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Semantic qualification of suivi/

Status: IN PROGRESS.

This lot qualifies the legacy suivi/ corpus by knowledge function rather than by file location. The physical relocation is closed; no legacy file is moved, deleted, or rewritten by this register. Old location names in historical source records are provenance labels, not current paths.

**Reconciliation refreshed on 2026-10-12:** current `main` was observed at [`d3d5e9d9cfa0fc1cdc0c825776fdc4fea378af9a`](https://github.com/AntheaLiles/k7pl/commit/d3d5e9d9cfa0fc1cdc0c825776fdc4fea378af9a). The old conversion-anomaly register was stale as a status source and is retired by this change. Current-source checks below supersede its old checkmarks. The normative B/C/D reference has been removed; index generation and its unresolved-target guard are in the current tree; HTML/JS translation rules and tests are broader than the old register records. D-7 remains an author-level choice about future presentation of prototypes, not a broken normative reference. The proposition-by-proposition review of the 13 in-scope historical sources remains incomplete; L1 therefore remains IN PROGRESS.

| Source | Destination(s) | Nature | Epistemic state | Action | Provenance |
|---|---|---|---|---|---|
| Conversion-anomaly register (retired 2026-10-12) | docs/migration/L1-DECISIONS.md; docs/migration/L5-VALIDATION.md; docs/tracking/DECISIONS.md; docs/history/ | conversion audit | historical findings; technical evidence; author decisions | Keep current evidence and unresolved decisions in their owning registers; do not treat legacy checkmarks as fresh verification | retired after reconciliation against current `main` |
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

## Main-source cross-check (2026-10-12)

- **Normative annex references:** the current `spec/` does not contain the old B/C/D labels. The C6 reference to Sugoi was removed by commit [`4a8c34f`](https://github.com/AntheaLiles/k7pl/commit/4a8c34f80f2013b2d9c330f344e82a774a9b275e). The prototypes remain explicitly separated under `tools/prototypes-bcd/`, and the original Org sources remain archived. D-7 is still an editorial decision about whether to expand or regroup those prototypes; it is not evidence of a broken current normative reference.
- **PDF index:** `spec/Spec/Refs/Index.lean` invokes `printindex`, `tools/SpecExt/Index.lean` renders the index, and `.github/workflows/verify.yaml` contains the `Reject unresolved index page references` guard. The visually inspected artifact in run [38131422345](https://github.com/AntheaLiles/k7pl/actions/runs/38131422345) was produced from the PR #153 candidate, not the exact current main SHA. The implementation and guard are present in current `main`; do not cite the candidate's visual check as a fresh rendering inspection of the current head.
- **HTML/JS localization:** current `tools/SpecExt/Translate.lean` includes HTML rules for navigation, utility/search pages and JavaScript rules for search controls, results and ARIA labels. `tests/SpecToolsTest.lean` exercises representative translations and idempotence. The old registry described only a small subset of these rules. The implementation translates the strings it owns; it does not provide a generic upstream `HtmlConfig` locale or guarantee translation of future strings added by Verso.
- **Glossary:** current `spec/Spec/Refs/ListeDesGlosses.lean` contains entries for `couche 1`, `couche 2` and `couche 3`; the corresponding historical omission is closed in the current source.
- **Figures:** the fix and regression checks are integrated via [PR #124](https://github.com/AntheaLiles/k7pl/pull/124); current tracking records the rendering correction and its retained-asset limitations.
- **Unreviewed historical material:** the old register's marked items are not used as current verification. L1's proposition-by-proposition qualification of all 13 in-scope historical sources remains open and is not concealed by retiring that register.
## Qualification rules

Generated material is not manually reproduced where a current machine source exists. DECISIONS.md is a provenance/decision register, not a substitute for author ratification or the normative source. The retired conversion-anomaly register is not a current status source; current evidence is recorded in L1-DECISIONS.md, L5-VALIDATION.md and DECISIONS.md. factorisations-refusees.md is critical evidence, not normative truth. registre-empirique.md distinguishes protocols from empirical results. `docs/history/2026-10-01-registre-obligations.md` is an historical snapshot and must be reconciled with the current Verso specification. For each migrated proposition, record (1) source and exact location, (2) epistemic role, (3) current owner or explicit absence, (4) comparison against current Verso, (5) contradictions and confidence, and (6) checks actually executed.

## Acceptance criteria

The lot remains IN PROGRESS until every source is reviewed proposition by proposition; current, hypothetical, evidentiary, critical and historical material are separated; current claims have precise provenance and are compared against current Verso; generated facts have a machine-derived owner; contradictions and missing evidence are explicit; checks are recorded as observed; and no physical move is treated as semantic completion. A source file's presence in this table is not proof that its propositions were fully reviewed.
