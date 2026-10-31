<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL formal models — TLA+

This is the single repository-root location for TLA+ work in K7PL. It contains model modules, TLC configurations, counterexample vectors, work plans, formal architecture, open semantic gates and toolchain/CI documentation.

The directory is intentionally flat. The repository concerns K7PL throughout, so a `k7pl/` subdirectory would add no useful boundary. Historical K7OS models retain their D01/R9 identifiers and provenance in their filenames and in this index; they do not need a separate project directory. Broader K7OS research reports remain under `theoretical-projects/k7os/`, but executable TLA+ artefacts and their configurations belong here.

## Work programme

| File | Purpose |
|---|---|
| [`WORK-PLAN.md`](WORK-PLAN.md) | Sixteen candidate TLA+ work packages, now accompanied by one module and finite TLC configurations per work package; scope, dependencies, open gates and acceptance criteria remain in this plan. |
| [`CHAPTER-COVERAGE.md`](CHAPTER-COVERAGE.md) | Maps obligations to K7PL specification chapters and explicitly identifies non-targets for TLA+. |
| [`FORMAL-ARCHITECTURE.md`](FORMAL-ARCHITECTURE.md) | Defines the division between normative Verso, executable K semantics, TLA+, model checkers, Lean and implementation tests; records simulation obligations. |
| [`TOOLCHAIN-CI.md`](TOOLCHAIN-CI.md) | Tool roles and limits, CI tiers and reproducible model-checking evidence. |
| [`OPEN-GATES.md`](OPEN-GATES.md) | Unresolved semantic/methodological decisions; no open question is silently ratified. |
| [`CHECKPOINT.md`](CHECKPOINT.md) | Current state and next action for the workstream. |

The work programme was prepared from the PR #311 specification snapshot at commit `f3b33cd34e1da49a4c8c41ca632c586e66715e70`. The work branch starts from `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`; references must be revalidated against current `main` before implementation.

## Existing model baselines

| Model | Files | Scope and current CI |
|---|---|---|
| D01 — native boundary (historically developed in K7OS research) | `D01NativeBoundary.tla`, `D01-NativeBoundary.cfg`, `D01-NativeBoundary-Unconfined.cfg`, `D01-NativeBoundary-ExpectedCounterexample.json` | Abstract protected-state integrity profiles. Checked by `d01-tlc` in `.github/workflows/k7pl-semantics.yaml`. |
| R9 — actor cancellation (historically developed in K7OS research) | `R9ActorCancellation.tla`, `R9ActorCancellation.cfg`, `R9-NaiveCancelClaim.cfg`, `R9-CancelRace-Test-Vector.md` | Bounded cancellation/commit race. Checked by `r9-tlc` in `.github/workflows/ci.yaml`. |
| TLA-01 — asynchronous session network | `TLA01SessionNetwork.tla`, `TLA01-*.cfg`, `TLA01-*-ExpectedCounterexample.json` | Bounded dependency/wait-graph and deadlock model; nominal, external-wait and timeout profiles plus two negative controls. Included in `r9-tlc` when `tla_model_check` is selected. Draft only until the named TLC runs succeed. |
| TLA-02..16 — candidate model suite | `K7PL*.tla`, `TLA02-*.cfg` … `TLA16-*.cfg`, `TLA02-16-ExpectedCounterexamples.json` | Fifteen independently bounded candidate models covering joins, scheduling, lifecycle, cancellation, FFI, capabilities, partial-order execution, grades/budgets, time, non-interference, reactive pipelines, deductive jobs, optional Noise/distribution profiles and abstract SPSC queues. All are routed through the same TLC job and suite evidence artifact. TLC has not yet run on these modules. |

The historical K7OS source files were moved from `theoretical-projects/k7os/models/` into this directory without changing their contents. Existing CI working directories, impact classification, cross-tool source-contract tests and documentation links were updated to point here. The K7OS research reports themselves remain under `theoretical-projects/k7os/`.

## Placement convention

All TLA+ modules, TLC `.cfg` files, model-specific counterexample vectors and TLA+ workstream documents are kept directly in this directory. CI classifies the programme documents as documentation-only changes; changes to executable model files, configurations and model-specific vectors trigger TLC. New work-item models should use stable identifiers in their filenames and module names, with a short nearby document or a section in `WORK-PLAN.md` recording the abstraction, assumptions, bounds, properties, omissions and evidence. No per-project or per-work-item subdirectories are introduced pre-emptively; reconsider only if the actual artefact count makes a flat directory hard to navigate.

## Epistemic and normative status

This directory is non-normative. A model, a TLC result or a work-plan entry does not by itself add a K7PL language rule, prove correspondence with the normative specification, establish implementation conformance or give a real-time guarantee.

Keep these statuses distinct: **specified**, **modelled**, **model-checked**, **proved**, **implemented**, **tested**, **measured** and **related**. A TLC result applies only to the exact module, imported modules, configuration, constants, bounds, tool version, properties and assumptions that were actually checked. The K ↔ TLA+ correspondence remains an open obligation; see [`wiki/semantics.md`](../wiki/semantics.md).


## Candidate model suite and composition boundary

The TLA-02..16 modules deliberately keep their state spaces separate. They use common design vocabulary—mailbox messages and matching, actor/fibre readiness, lifecycle journals, capability ownership, abstract resource units, logical time, level-labelled observations, and publication/consumption protocols—but do not import one another or claim a cross-module refinement. Their documented dependencies are conceptual contracts and proof obligations, not a syntactic import graph.

The r9-tlc job runs the TLA-01 profiles and all TLA-02..16 candidate profiles as one CI suite and archives the source/configuration/log set. This makes cross-model regressions visible in one revision while keeping explicit-state exploration tractable. A future composed system model requires a separately reviewed interface relation; it must not be inferred from running independent modules in the same workflow.

TLA-14 and TLA-15 are executable conditional profiles, not adopted library or distributed-runtime requirements. TLA-16 models an atomic abstract ring and does not model weak-memory behaviours. No TLA-02..16 profile has yet been TLC-checked, and none establishes K/Lean correspondence or changes normative K7PL semantics.
