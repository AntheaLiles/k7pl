<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Project Dashboard

This is the current entry point for project tracking. It answers what is current, open, blocked, decided, or next. It does not duplicate generated measurements or normative specification text.

## Recovery gate

- [Project master plan](PROJECT-MASTER-PLAN.md) — active scientific and release workstreams. **Stage C is still open; D–F and downstream E–J must not start substantive work until the C exit gate is explicitly satisfied.**
- [Stage C theoretical-object register](../migration/L1-THEORY-OBJECTS.md) — C-01–C-09 residual obligations and explicit exit criteria.
- [Branch status](BRANCHES-STATUS.md) — branch classification; recheck live refs before merge or deletion.

## Current state

- [Project status](../STATUS.md) — generated CI and repository facts.
- [L1 migration qualification register](../migration/L1-SUIVI.md) — current C-stage object and boundary analysis.
- [Statement correspondence](correspondance-enonces.md) — generated view (`scripts/suivi.py`) of the numbered specification statements, their labels and their reviewed-PDF numbers; it does not map statements to Lean declarations.

## Active registers

- [Decisions and ratifications](DECISIONS.md)
- [Migration decisions and validation evidence](../migration/L1-DECISIONS.md) — current source findings and residual limits
- [PR-02 campaign cards](FICHES-PR02.md)
- [Primitives and T-68](primitives.md)
- [Module hypotheses](hypotheses-de-module.md)
- [Empirical register](../research/registre-empirique.md)

## Active methodological work

- [OpenSSF / CII operational status](../security/OPENSSF-ROADMAP.md) — current open security, release, and BadgeApp gates.
- [Human actions](../security/ACTIONS-HUMAINES.md) — ordered checklist for settings, decisions, BadgeApp, and publication.
- [C8 statement register](LEAN-STATEMENT-MIGRATION.md) — C8 statement ontology, classification, roadmap, exit gate and frozen pre-migration snapshot.
- [Migration register](../migration/README.md) — active semantic migration lots only.
- [Interactive exploration plan](INTERACTIVE-EXPLORATION-PLAN.md) — navigation prototype, evaluation, graph and accessibility residuals.
- [Proof visualization roadmap](PROOF-VISUALIZATION-ROADMAP.md) — Paperproof proof-tree prototype, ranked technical extensions, verification commands, and human validation still required.
- [Proof visualization coverage matrix](PROOF-VISUALIZATION-COVERAGE.md) — observed Lean proof families, implementation status, test evidence, and limits.
- [Proof visualization human review](PROOF-VISUALIZATION-HUMAN-REVIEW.md) — manual validation still required for source fidelity, keyboard/mobile use, and PDF pagination.

## Historical records

- [OpenSSF criterion checklist (2026-10-10)](../history/2026-10-10-openssf-conformance-checklist.md) — archived working inventory; not a current status source.
- [Original OpenSSF remediation plan (2026-10-10)](../history/2026-10-10-openssf-remediation-plan.md) — historical plan before the current automation wave.
- [OpenSSF automation closeout (2026-10-10)](../history/2026-10-10-openssf-automation-closeout.md) — prepared work and items still unverified.
- [Coherence review (closed 2026-10-09)](../history/2026-10-09-coherence-review.md) — retained audit checklist and closure context.

The physical documentation-architecture programme is closed. Its final state is preserved in [the historical architecture plan](../history/2026-10-08-documentation-architecture-plan.md) and [the historical legacy-documentation migration programme](../history/2026-10-08-legacy-documentation-migration-programme.md). Historical PR-02 plans and dated campaign reports remain under docs/history/; see [its index](../history/README.md).

## Reading rule

DASHBOARD.md is a navigation surface. Machine-generated facts belong in STATUS.md and generated tracking views; scientific claims belong in the specification or the appropriate assurance/research document. A clean CI run is not itself a scientific closure criterion.
