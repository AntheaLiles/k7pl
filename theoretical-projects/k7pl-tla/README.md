<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL TLA+ modelling work programme

**Status:** non-normative working programme; no model in this directory has yet been implemented or checked.  
**Created:** 2026-10-31.  
**Primary specification snapshot analysed:** [PR #311, commit `f3b33cd34e1da49a4c8c41ca632c586e66715e70`](https://github.com/AntheaLiles/k7pl/tree/f3b33cd34e1da49a4c8c41ca632c586e66715e70).  
**Branch base:** `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`.

## Purpose

This directory turns the TLA+ work identified during the technical review of K7PL PR #311 into a set of explicit, reviewable work items. It is intended to be used incrementally: each item can be specified, challenged, implemented, model-checked, related to K and Lean, and either completed or kept open with a precise reason.

The central question is not whether a chapter mentions concurrency. It is whether a normative commitment entails a state-transition, protocol, scheduling, temporal or recovery property that benefits from an explicit state-space model.

The programme covers sixteen work items:

- asynchronous sessions, dependency and wait graphs, and deadlock;
- atomic join-pattern matching and message consumption;
- scheduler behaviour and global progress;
- actor lifecycle, snapshots and replay;
- cancellation and effect commit;
- foreign-interface transfer and revocation;
- capabilities, memory regions and entity lifetime;
- fork/join, parallel evaluation and partial-order traces;
- dynamic resource accounting and budgets;
- temporal triggers, waiting and deadlines;
- trace stratification and non-interference;
- reactive and deductive-engine case studies;
- optional Noise and replicated-state profiles;
- refinement of abstract queues to concrete SPSC and weak-memory implementations.

## Documents

| Document | Purpose |
|---|---|
| [Chapter coverage](CHAPTER-COVERAGE.md) | Maps each relevant specification chapter and section to work items; records where TLA+ is not the appropriate method. |
| [Work plan](WORK-PLAN.md) | Detailed scope, candidate state, actions, properties, tools, dependencies and acceptance criteria for all sixteen items. |
| [Formal architecture](FORMAL-ARCHITECTURE.md) | Defines the intended division between K, TLA+, TLC/Apalache, Lean and tests; specifies the correspondence obligations. |
| [Toolchain and CI](TOOLCHAIN-CI.md) | Assigns precise roles to TLA+ native constructs, TLC, Apalache, TLAPS, PlusCal and external tools; proposes reproducible CI evidence. |
| [Open gates](OPEN-GATES.md) | Lists unresolved semantic and methodological decisions that must not be silently chosen while implementing models. |
| [Checkpoint](CHECKPOINT.md) | Records the current state of this workstream and the next concrete action. |

## Epistemic and normative status

Everything in this directory is a proposed research and engineering plan. Listing an obligation here does not:

- add a normative clause to `spec/`;
- ratify a choice about scheduling, message selection, timeout, recovery, fairness or hardware;
- establish that a theorem stated in Verso is proved;
- establish that a model corresponds to the K semantics;
- establish implementation conformance or a real-time guarantee.

The plan must preserve the distinction between:

1. **specified** — a normative text states the commitment;
2. **modelled** — a TLA+ module represents a chosen abstraction;
3. **model-checked** — a particular tool and configuration explored the declared model;
4. **proved** — a theorem was checked in Lean or an appropriate proof system;
5. **implemented** — an executable realisation exists;
6. **tested** — selected implementation behaviours were exercised;
7. **measured** — an empirical result was obtained on a declared profile;
8. **related** — an explicit correspondence connects the artefacts.

A green TLC run establishes only the result for the model, assumptions, constants, bounds and properties actually checked. It does not establish the correctness of an omitted transition or the adequacy of the abstraction.

## Source baseline and change control

The specification references and section labels in this work programme were examined at PR #311 head `f3b33cd34e1da49a4c8c41ca632c586e66715e70`. The new branch itself follows the repository contribution rule and starts from `main`, not from the unmerged PR. This avoids making the workstream structurally dependent on PR #311 while preserving an exact analysis snapshot.

Before implementing an item, revalidate the referenced sections and labels against the then-current `main`. PR #311 may change, be rebased, or be merged. Update the source snapshot in this directory when the normative source changes; do not silently assume the current paths and labels still identify the same statements.

The K7OS reports R4, R5, R6, R7 and R9 are useful supporting research, but they remain non-normative. Their conclusions are not automatically K7PL requirements. The K7OS models D01 and R9 are starting points for further examination, not complete K7PL models.

## Working convention

Each work item begins as `not-started`. Status changes must cite an artefact and its exact revision. Recommended statuses:

- `not-started`
- `blocked-on-specification`
- `model-drafted`
- `model-checked-bounded`
- `counterexample-found`
- `model-revised`
- `correspondence-open`
- `correspondence-proved`
- `completed-with-scope-limit`

Do not use `verified` without naming what was verified, by which tool, against which configuration and under which assumptions.

All decisions that could alter normative semantics remain open until explicitly ratified by the owner. See [open gates](OPEN-GATES.md).
