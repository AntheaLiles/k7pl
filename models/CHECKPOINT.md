<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# K7PL TLA+ workstream checkpoint

## Current state

- Workstream: planning and formal-analysis backlog for TLA+ modelling of K7PL.
- Status: the programme is drafted; no new K7PL TLA+ model has been added yet. Historical D01/R9 files have been relocated without changing their contents; existing TLC jobs retain their checking behaviour.
- Branch base: `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`.
- Analysed specification snapshot: PR #311 head `f3b33cd34e1da49a4c8c41ca632c586e66715e70`.
- PR #311 was open at the time this checkpoint was created.
- Canonical location: repository-root `models/`; no per-project subdirectory is used.

## Documents created

- `README.md`: purpose, source baseline, status vocabulary and non-normative scope.
- `CHAPTER-COVERAGE.md`: chapter-by-chapter mapping, including explicit non-targets.
- `WORK-PLAN.md`: sixteen model work packages, their candidate state/actions/properties, tools, dependencies and acceptance criteria.
- `FORMAL-ARCHITECTURE.md`: responsibilities, abstraction relation, forward simulation and traceability.
- `TOOLCHAIN-CI.md`: TLA+, TLC, Apalache, TLAPS, PlusCal and conditional external tools; CI/evidence proposal.
- `OPEN-GATES.md`: unresolved decisions that must not be selected implicitly.
- `CHECKPOINT.md`: this workstream's status and next action.

## Existing sources used

- PR #311 specification and code at the pinned head above.
- `theoretical-projects/k7os/R4-concurrence-protocoles-vivacite-annulation.md`.
- `theoretical-projects/k7os/R5-memoire-emprunt-aliasing-logique-separation.md`.
- `theoretical-projects/k7os/R6-grades-budgets-WCET-temps-reel.md`.
- `theoretical-projects/k7os/R7-pannes-ressources-lineaires-persistance.md`.
- `theoretical-projects/k7os/R9-model-checking-contre-exemples-tracabilite.md`.
- `models/D01NativeBoundary.tla`.
- `models/R9ActorCancellation.tla`.
- `wiki/semantics.md` and `.github/workflows/k7pl-semantics.yaml`.

## Findings retained

1. The current TLA+ models are K7OS research models, not a normative K7PL semantic model.
2. D01 is a small native-boundary profile with a checked negative configuration.
3. R9 is a bounded actor-cancellation race model; the distinction between cancel request and acknowledgement must remain explicit.
4. D01 is checked by the `d01-tlc` job in `k7pl-semantics.yaml`; R9 is checked separately by `r9-tlc` in `ci.yaml`.
5. The K/Lean/TLA+ projection is explicitly open in `wiki/semantics.md`.
6. The highest-value initial work is the dependency DAG versus dynamic wait graph, atomic join matching and scheduler/global progress.
7. General algebraic, typing, syntax and fixed-point theorems remain Lean/parser work; TLA+ should model the relevant runtime protocols and finite scenarios.

## Next action

Review [OPEN-GATES.md](OPEN-GATES.md), beginning with G1–G5, and confirm the priority/dependency order for TLA-01, TLA-02, TLA-03 and TLA-08. Then draft the smallest finite TLA-01 model and its negative three-actor circular-wait configuration. Do not change normative specification text or the current K semantics until the transition contract and correspondence requirements have been reviewed.
