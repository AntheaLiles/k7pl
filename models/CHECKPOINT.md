<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# K7PL TLA+ workstream checkpoint

## Current repository state

- Repository: `AntheaLiles/k7pl`.
- Canonical model location: repository-root `models/`; no model subdirectories.
- Work branch: `research/k7pl-tla-workplan-2026-10-31`.
- Current source head: `cd06607aa67d7273825ea534b64e0f42c2f31830`.
- Base: `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`.
- Comparison: 26 commits ahead of `main`, zero behind.
- Draft PR: [#318](https://github.com/AntheaLiles/k7pl/pull/318), targeting `main`; open, draft, not merged.
- Latest CI run for head `cd06607`: [run 41238524798](https://github.com/AntheaLiles/k7pl/actions/runs/41238524798), created and pending when this checkpoint was written.
- Main remains unchanged. No normative Verso clause, theorem status or project decision has been ratified by these candidate models.

## Implemented scope

TLA-01..16 now have model sources in the single `models/` directory. The historical D01 and R9 models remain present with their original identifiers and existing checks.

| Work item | Module | Configurations |
|---|---|---|
| TLA-01 | `TLA01SessionNetwork.tla` | 5 |
| TLA-02 | `K7PLJoinPatterns.tla` | 2 |
| TLA-03 | `K7PLScheduler.tla` | 2 |
| TLA-04 | `K7PLActorLifecycle.tla` | 2 |
| TLA-05 | `K7PLCancellation.tla` | 2 |
| TLA-06 | `K7PLForeignBoundary.tla` | 3 |
| TLA-07 | `K7PLMemoryCapabilities.tla` | 4 |
| TLA-08 | `K7PLParallelExecution.tla` | 2 |
| TLA-09 | `K7PLResourceAccounting.tla` | 3 |
| TLA-10 | `K7PLTemporalScheduling.tla` | 2 |
| TLA-11 | `K7PLTraceNoninterference.tla` | 2 |
| TLA-12 | `K7PLReactivePipeline.tla` | 2 |
| TLA-13 | `K7PLDeductiveJob.tla` | 2 |
| TLA-14 | `K7PLNoiseSession.tla` | 2 |
| TLA-15 | `K7PLReplicaConvergence.tla` | 2 |
| TLA-16 | `K7PLSPSCQueue.tla` | 2 |

The 15 newly added modules have 34 TLC configurations: 15 nominal/positive profiles and 19 negative controls. The aggregate `TLA02-16-ExpectedCounterexamples.json` records the intended unsafe transitions and expected invariant names. It is an authored test plan, **not observed TLC output**.

## Conceptual composition

`MODEL-DEPENDENCIES.md` describes the intended conceptual relations:
- TLA-01 supplies the finite actor/mailbox/wait-graph vocabulary.
- TLA-02 adds multi-message join matching; G2 remains open.
- TLA-03 isolates per-fibre scheduling and fairness.
- TLA-04/05 model lifecycle, journal/replay, cancellation, commit and failure states.
- TLA-06/07 model foreign capability transfer, aliasing, revocation, identity generations and region ownership.
- TLA-08/09 model branch partial orders and abstract grade/resource accounting.
- TLA-10/11 model temporal trigger/cost separation and paired low-observation checks.
- TLA-12/13 model reactive publication and bounded deductive-job lifecycle.
- TLA-14/15 are conditional handshake and grow-only-set replication profiles.
- TLA-16 is an atomic abstract SPSC ring; concrete weak-memory refinement is not modelled.

The models are independently bounded and are run together by one CI job. They do **not** form a single imported or composed transition system. Their dependencies are conceptual interfaces and proof obligations, not established simulation/refinement relations. A future integrated model requires an explicit typed state relation and transition/stuttering correspondence.

## CI integration

The existing `D01, R9 and TLA-01` TLC job was expanded and renamed to `D01, R9 and TLA-01..16 model checks`. Its timeout is 20 minutes. It runs:
- D01 and R9 checks, preserved;
- the five TLA-01 configurations, with expected invariant-name checks for its two negative profiles;
- 15 positive TLA-02..16 profiles;
- 19 TLA-02..16 negative profiles, each requiring its designated invariant name;
- separate evidence artefacts `tla01-tlc-evidence` and `tla-models-evidence`, with source/configuration copies, expected vectors, Java version, pinned TLC digest, logs and a checksum manifest.

The TLA-02..16 execution step uses `if: always()` so that a TLA-01 failure does not prevent later candidate models from running and producing diagnostics. The job is selected by the `tla_model_check` impact surface; the `models/` root is already classified accordingly.

## Verification status — important limitation

**No TLA-02..16 module has yet been parsed or model-checked by TLC in CI.** The current source head's run 41238524798 was pending when recorded. Do not describe the candidate suite as green or bounded-model-checked.

The earlier CI run [#2391](https://github.com/AntheaLiles/k7pl/actions/runs/41235562330), on head `970cf5b`, established:
- Deno, REUSE, actionlint, commitlint, completed security checks, Python tests, quick checks and the Lean implementation build passed after CI-only corrections;
- historical D01 positive and negative TLC checks passed;
- historical R9 positive and negative TLC checks passed;
- TLA-01 reached TLC 1.7.4 but failed in the old configuration parser at the tuple-set assignment for `StaticDependencies`, before module parsing or state exploration.

TLA-01 was corrected to encode `StaticDependencies` as a finite adjacency function `[Actors -> SUBSET Actors]`, with `StaticDependencyEdges` reconstructed in TLA+. That correction has not yet been validated by the latest-head run.

The pinned tool download and digest checks succeeded in run #2391. The `tla01-tlc-evidence` artefact from that run is diagnostic evidence for the previous parser failure, not a successful TLA-01 result. No TLA-01 expected JSON counterexample has yet been observed from TLC.

The controller-shadow job has reported the previously documented, intentional legacy/derived classifier differences for TLA model paths. It is non-gating and remains visible; it is not a TLA property result.

## Epistemic and normative status

- TLA-01 remains `model-drafted`. C3 `thm:deadlock_acyclique` remains `under-review` with evidence `proofsketch`.
- TLA-02..13 and TLA-16 are candidate models; all TLC runs are pending.
- TLA-14 and TLA-15 are executable conditional profiles, not adopted K7PL requirements.
- G2 matching policy, G3 fairness, G4 mailbox/timeout semantics, G5 cancellation linearisation, G6 revocation, G7 identity/lifetime, G8 observer/timing semantics, G9 budget units, G10 time model, G11 weak-memory target, G12 distribution semantics and G13 protocol adoption remain open as applicable.
- No K/TLA+ or Lean/TLA+ correspondence is asserted. The current K prototype does not implement the normative actor/session semantics.
- TLC results, when available, will apply only to the exact finite models, constants, assumptions, configurations and tool version run. They do not prove unbounded K7PL semantics or physical runtime performance/isolation.

## Next action

Inspect CI run 41238524798 and both TLA artefacts. Fix parser/model/property/CI defects from the actual output. Compare all actual counterexample traces against the authored JSON witnesses. Keep model statuses unchanged until the named configurations complete and the expected invariant names are observed. Only then decide whether to refine any cross-model interfaces or advance the work-plan statuses.
