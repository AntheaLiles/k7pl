<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# K7PL TLA+ workstream checkpoint

## Current state

- Workstream: progressive TLA+ modelling of K7PL asynchronous and concurrent runtime protocols.
- Canonical location: repository-root `models/`; no model subdirectories have been introduced.
- Branch: `research/k7pl-tla-workplan-2026-10-31`.
- Current head: `38650fca3598757818c382fcc94112175cb174e4`; nine commits ahead of `main`, zero behind.
- Base: `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`.
- Draft PR: [#318](https://github.com/AntheaLiles/k7pl/pull/318), base `main`, head `38650fc`; open, draft, not merged.
- TLA-01 status: **`model-drafted`**. TLC has executed against the previous head, but the first nominal configuration failed in the TLC configuration parser before TLA module parsing or state exploration. No TLA-01 invariant result and no TLC-observed TLA-01 counterexample is claimed.
- No normative specification theorem or K7PL semantics was changed or ratified by this work.

## Implemented model and latest correction

The TLA-01 implementation commit is `e7b78b2b2e95aed238184733e3a6a57f9e8ab60f`. It adds:

- `models/TLA01SessionNetwork.tla`;
- five configurations: nominal asynchronous send/receive, circular wait, simulation gap, external wait and timeout;
- two authored JSON expected-counterexample vectors;
- model contract, scope, limitations and work-plan entries;
- integration into the existing `D01, R9 and TLA-01 model checks` CI job and a `tla01-tlc-evidence` artifact.

The model treats `StaticDependencies` as an adjacency function and derives the ordered-pair relation `StaticDependencyEdges`. `WaitFor` is derived from blocked actors; (Sim) is checked rather than assumed. The mathematical edge direction remains `waiter -> expected sender`.

The config-encoding correction is commit `38650fca3598757818c382fcc94112175cb174e4`. Before it, the nominal TLC configuration assigned `StaticDependencies = {<<ActorB, ActorA>>}`. TLC's config parser rejected this at line 8 with `ConfigFileException: expecting }, but did not find it`. The five configurations now encode finite adjacency functions, and the module constructs `StaticDependencyEdges` from those functions. The same correction is described in `WORK-PLAN.md`.

The CI-only fixes in commit `970cf5bcd8547847d0dc4c2956b6bbdff99d6934` corrected:
- a Deno test accessing `tla_model_check` outside `surfaces`;
- missing REUSE metadata for the moved D01 JSON vector;
- ShellCheck SC2094 in the evidence-manifest generation step.

## CI evidence

- PR #318 was opened as a draft to activate the ordinary CI path.
- First PR CI run on the prior head `ff76fa9` failed before TLC because of the Deno test, REUSE and SC2094 issues. The controller-shadow job also reported the known legacy/derived classifier divergence for the new TLA classification; this job is non-gating and the divergence remains visible.
- CI run [#2391](https://github.com/AntheaLiles/k7pl/actions/runs/41235562330), head `970cf5b`: Impact analysis, Deno checks, REUSE, actionlint, commitlint, security checks, Python tests, quick checks, Lean implementation build and the separate D01 model-check job passed. Controller shadow reported the known non-gating divergence.
- The pinned TLC artifact was downloaded by GitHub Actions and its SHA-256/SHA-1 checks completed successfully. TLC reports `TLC2 Version 2.19` internally.
- Existing R9 and D01 positive checks and their negative controls passed in the run's `D01, R9 and TLA-01 model checks` job. The TLA-01 nominal/environment step then stopped at the old configuration encoding described above. The two planned TLA-01 negative profiles were skipped; they have not been checked.
- Evidence artifact `tla01-tlc-evidence`, artifact ID `13055089416`, SHA-256 `d18f946f8d4dd8bf85f43f0e3eec6ce75f2d27a3d67f16fe7b8069f5a5410333`, contains the old source/configuration and `acyclic-nominal.log` recording the parser failure. It is diagnostic evidence, not a successful TLA-01 result.
- New CI run [#2392](https://github.com/AntheaLiles/k7pl/actions/runs/41235780982), head `38650fc`, was created but is pending with no jobs started. The previous run remains in progress on its K compilation and Verso specification-build jobs. `.github/workflows/ci.yaml` serialises CI by workflow/ref with `cancel-in-progress: false`; therefore the new run waits behind the older run.
- The run on `38650fc` has not yet exercised the adjacency-function correction. The current branch head remains unverified by TLC.

## Normative and correspondence findings

- C3 `thm:deadlock_acyclique` remains `under-review` with evidence `proofsketch`; this work does not promote it to a checked theorem.
- The relation between static and dynamic dependency graphs remains open for `Guard`, `Send`, message consumption, residual protocol states and `Timeout`.
- C4's compile-time actor-template graph has not been linked by a complete typed relation to the C3 dynamic wait graph.
- The model's edge orientation `waiter -> expected sender` still requires confirmation against the normative graph construction.
- The maintained K prototype described in `wiki/semantics.md` does not yet implement the normative actor/session semantics. No K/TLA+ or Lean/TLA+ simulation is asserted.
- The JSON vectors remain authored expected witnesses until TLC emits and their contents are compared against actual traces.

## Bounds, assumptions and omissions

- Actor cardinality is two or three; cycle detection is exact only for this bound.
- Each actor receives at most one message and sends at most one message. Mailboxes are sets of sender/receiver pairs, not the normative K multiset in full generality.
- Sends are asynchronous; a sender does not wait for recipient readiness. A receive blocks only while its expected message is absent.
- Endpoint duality is checked for configured one-step protocol maps, not for general session typing.
- External delivery and timeout are explicit actions. Timeout is nondeterministic and changes an actor to `Failed`, not `Terminal`. Late external delivery after timeout is omitted.
- No `WF` or `SF` is assumed. No starvation-freedom, eventual delivery, eventual timeout, global progress or eventual termination claim is made.
- Multiple messages, multiplicity/order, join matching, branches, actor creation, scheduler interleavings, weak memory and physical time are omitted.

## Open points

1. Inspect the latest PR run and verify that SANY/TLC parse the updated module and all five configurations.
2. Require the three positive/environment profiles to complete without invariant violations.
3. Require the circular-wait profile to fail specifically on `NoMutualWaitDeadlock` and the simulation-gap profile to fail specifically on `Simulation`.
4. Compare the TLC-observed traces to both JSON vectors; retain actual logs and hashes.
5. Define the K-side object corresponding to a dependency edge and prove the rule-level mapping from `Guard`/mailbox typing to a dynamic wait edge.
6. Confirm graph-edge orientation and whether one mailbox may have multiple candidate senders.
7. Do not infer timeout progress or late-message semantics from this bounded model.

## Next action

Inspect CI run #2392 (or its replacement if a newer docs-only checkpoint commit supersedes it). Correct further model or syntax defects using TLC output, and do not advance the TLA-01 work-plan status before the named profiles and actual counterexamples have been observed. TLA-02 remains gated on TLA-01's bounded checks and must treat G2 matching choices as exploratory candidates, not normative decisions.
