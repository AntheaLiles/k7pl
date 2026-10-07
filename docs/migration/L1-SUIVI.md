<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — Semantic qualification of suivi/

Status: IN PROGRESS.

This lot qualifies the legacy suivi/ corpus by knowledge function rather than by file location. No legacy file is moved, deleted, or rewritten by this register.

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
| registre-obligations.md | ASSURANCE.md; RESEARCH.md; docs/archives/ | claim/dependency register | établi; hypothèse; preuve; historique | Reconcile against current spec before current use | source retained |

## Qualification rules

Generated material is not manually reproduced where a current machine source exists. DECISIONS.md is not itself normative. ANOMALIES.md and factorisations-refusees.md are adversarial evidence, not normative truth. registre-empirique.md distinguishes protocols from empirical results. registre-obligations.md is an historical snapshot and must be reconciled with the current Verso specification.

## Acceptance criteria

The lot remains IN PROGRESS until every source is reviewed at proposition level; current and historical decisions are separated; generated facts have a machine-derived owner; current claims have provenance; unsupported claims are explicitly marked; and no legacy file has been moved as a substitute for semantic migration.
