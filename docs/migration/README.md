<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Migration register

This directory is the active register for **semantic qualification** of the legacy documentation. The physical documentation-tree migration was closed on 2026-10-08; its [dated programme](../history/2026-10-08-legacy-documentation-migration-programme.md) is retained as provenance, not as an active move plan. Do not reopen directory relocation as a substitute for proposition-level review.

## Lot states

NOT STARTED → IN PROGRESS → UNDER REVIEW → VALIDATED.

A lot is validated only when its stated acceptance criteria are met. A successful build is evidence about the checks actually run, not scientific validation or author ratification.

## L0 — Corpus inventory

`docs/migration/LEGACY-INVENTORY.md` remains a generator placeholder until `scripts/inventory_legacy.py` has been run and its output reviewed. It is not a current inventory. Keep that status explicit; do not hand-edit generated content.

## L1 — Semantic qualification

L1 classifies propositions from the former `suivi/` corpus, now represented principally under `docs/tracking/`, and other migration sources by epistemic role: current decision, hypothesis, evidence/observation, critique, or historical provenance. The physical relocation is closed; semantic qualification remains **IN PROGRESS**.

Entry points:

- [L1 source register](L1-SUIVI.md)
- [Proposition-level extraction register](L1-SUIVI-EXTRACTION.md)
- [Decision analyses and author choices](L1-DECISIONS.md)
- [Annexes B/C/D options](L1-ANNEXES-EXTRACTION.md)
- [Theory objects](L1-THEORY-OBJECTS.md)
- [Theoretical foundations and temporal sedimentation](L1-THEORY-SEDIMENTATION.md) — instruction file (IN PROGRESS) for the theory imports decided in L1-DECISIONS.md, separating what the specification already states from what remains to be demonstrated.
- [C-01–C-09 source integration and remaining proof obligations (2026-10-12)](L1-C-SOURCE-INTEGRATION-2026-10-12.md)
- [Independent revalidation of the Stage C exit gate (2026-10-12)](L1-C-GATE-REVALIDATION-2026-10-12.md) — dated verdict on the PR #170 candidate branch: gate C not satisfied, no go for D–J.
- [Stage C effective-rule evidence matrix (2026-10-12)](L1-C-EFFECTIVE-RULE-EVIDENCE-MATRIX-2026-10-12.md) — inventory of the 49 C3 typing-rule occurrences against `src/K7pl/`; each is marked ABSENT (no mechanised rule or rule-specific preservation proof). An inventory finding, not a proof.
- [C-08 memory-safety justification audit: H1/H2/H3 and profile Π (2026-10-11)](L1-C08-MEMORY-SAFETY-AUDIT-2026-10-11.md) — provisional documentary audit: spatial safety is stated under H1, H2 and H3, whose justifications the audit finds incomplete (H1 is not demonstrated independently); no normative decision.
- [T-68 primitive audit](L1-T68-AUDIT.md)
- [Archive PR #10: selective recovery, piece by piece (2026-10-14)](L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md)
- [Stage C instruction of the archive's scientific findings (2026-10-14)](L1-C-ARCHIVE-FINDINGS-INSTRUCTION-2026-10-14.md)

## L2–L4

L2 covers research; L3 covers method and peer-review material; L4 covers historical records and bibliography. Each extracted statement must retain its source and epistemic status. A historical conclusion is not current solely because a register labels it “decided”.

## L5 — Validation

[L5-VALIDATION.md](L5-VALIDATION.md) separates validation of the completed physical migration from validation of semantic qualification. Its current evidence must identify the exact commit and checks observed. Open author decisions, unverified PDF output, and incomplete source-by-source reconciliation prevent a global `VALIDATED` status.
