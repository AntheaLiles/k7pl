<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# K7PL TLA+ workstream checkpoint

## Current state

- Workstream: progressive TLA+ modelling of K7PL asynchronous and concurrent runtime protocols.
- Branch: `research/k7pl-tla-workplan-2026-10-31`.
- TLA-01 implementation revision: `e7b78b2b2e95aed238184733e3a6a57f9e8ab60f` (direct child of the planning head below).
- Planning head before implementation: `80a439df4fb1e34392bbf27388e5322f63095040`.
- Branch base: `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`; comparison after the TLA-01 implementation reported six commits ahead and zero behind.
- PR #311 remained open at head `f3b33cd34e1da49a4c8c41ca632c586e66715e70`; this is the lexical-source snapshot used by the plan, not an assertion that its changes are merged or normative.
- Canonical location: repository-root `models/`; no model subdirectories have been introduced.
- Status: **TLA-01 is `model-drafted`**. TLC has not yet executed the new module. No model-check result or observed TLA-01 counterexample is claimed.

## Implemented increment

Commit `e7b78b2b2e95aed238184733e3a6a57f9e8ab60f` adds:

- `models/TLA01SessionNetwork.tla`;
- `models/TLA01-AcyclicNominal.cfg`;
- `models/TLA01-CircularWait.cfg`;
- `models/TLA01-SimulationGap.cfg`;
- `models/TLA01-ExternalWait.cfg`;
- `models/TLA01-Timeout.cfg`;
- `models/TLA01-CircularWait-ExpectedCounterexample.json`;
- `models/TLA01-SimulationGap-ExpectedCounterexample.json`;
- TLA-01 contract, bounds, assumptions, omissions and correspondence status in `WORK-PLAN.md`;
- the model index and toolchain baseline;
- REUSE annotations for the JSON vectors;
- TLC invocation, expected-invariant checks and an evidence artifact in the existing `r9-tlc` job. The existing D01 and R9 commands are preserved.

The model keeps `StaticDependencies` constant and derives `WaitFor` from blocked actor states. It checks (Sim) rather than assuming it. The `SimulationGap` profile intentionally retains a static DAG and dual endpoint maps while allowing a dynamic three-actor wait cycle; its expected invariant failure is `Simulation`. The separate `CircularWait` profile uses a cyclic static graph and expects `NoMutualWaitDeadlock` to fail.

## Normative and correspondence findings

- C3 `thm:deadlock_acyclique` is marked `under-review` with `proofsketch`; the work does not promote it to a checked theorem.
- The specification explicitly leaves the static/dynamic graph relation open for `Guard`, `Send`, consumption, residual states and `Timeout`.
- C4's compile-time actor-template graph and the C3 premise (Sim) have not yet been tied by a complete typed relation in this work.
- The model uses the (Sim) pair orientation `waiter -> expected sender`. Whether this is exactly the orientation of the graph construction in the C4 implementation remains a correspondence question.
- The maintained K prototype described in `wiki/semantics.md` does not implement the normative actor/session semantics. No K/TLA+ or Lean/TLA+ simulation is asserted.
- The expected JSON vectors are authored witnesses for the abstract transition design, not actual TLC-produced traces yet.

## Bounds, assumptions and omissions

- Actor cardinality is two or three; `StaticHasCycle` is exact only under this bound.
- Each actor receives at most one message and sends at most one message. Mailboxes are sets of sender/receiver pairs, not the normative K multiset in full generality.
- Sends are asynchronous; no sender waits for recipient readiness. A receive blocks only while its expected message is absent.
- Internal endpoint duality is checked for the configured one-step protocol maps. This is not a proof of general session typing.
- External delivery and timeout are explicit actions. Timeout is nondeterministic and changes an actor to `Failed`, not `Terminal`. Late external delivery after timeout is outside this draft.
- No `WF` or `SF` is assumed. No starvation-freedom, eventual delivery, eventual timeout, global progress or eventual termination claim is made.
- Multiple messages, message multiplicity/order, join matching, branches, actor creation, scheduler interleavings, weak memory and physical time are omitted.

## Commands and tool evidence

- Remote branch comparison: `main...research/k7pl-tla-workplan-2026-10-31` reported `ahead_by = 6`, `behind_by = 0` immediately after the implementation commit.
- Local source checks: both JSON vectors parsed; five TLC configurations were checked for the expected specification/deadlock-control directives; module name, (Sim) declaration, finite actor bound and absence of WF/SF declarations were checked by a small Python source check.
- Local Java runtime: OpenJDK `21.0.12.1`.
- TLC target: repository-pinned `1.7.4`, SHA-256 `936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88`, SHA-1 `bee4a54f3ee3d4afc347c3240ec2d9e93b075104`.
- TLC was not available in the execution container. Attempting to retrieve the pinned JAR failed with DNS resolution error (`curl: (6) Could not resolve host: github.com`). No TLC command was executed locally.
- No PR was opened, so the branch's new CI job has not run. The new TLC checks are wired to `tla_model_check` and will execute in the existing PR CI path.
- This execution environment did not contain a local repository checkout; branch status, commits and tree changes were inspected and written through the remote Git data interface. No local `git status`, `git diff` or shell commit was possible.

## Open points

1. Define the K-side object corresponding to a dependency edge and prove the rule-level mapping from `Guard`/mailbox typing to a dynamic wait edge.
2. Confirm the graph-edge orientation and whether one mailbox may have multiple candidate senders.
3. Ratify neither timeout resolution nor late-message handling: their current model behaviour is a bounded profile only.
4. After the TLC job runs, inspect both actual traces, verify the invariant names and compare the observed traces with the JSON witness vectors.
5. Only after TLC parses and checks the declared profiles may TLA-01 advance to `model-checked-bounded` or `counterexample-found`.

## Next action

Run the new `r9-tlc` path on this branch through the normal PR CI once a PR is explicitly authorised. Inspect the five TLC logs and the `tla01-tlc-evidence` artifact before revising any property or advancing the work-plan status. Then use the checked counterexample to formulate the rule-by-rule K/Lean correspondence obligation; do not start TLA-02 by treating the draft mailbox abstraction as already established.
