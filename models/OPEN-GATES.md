<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Open semantic and methodological gates

**Status:** questions for joint review. None of the options below is selected or ratified by this document.

A work item is blocked when its model would otherwise have to choose one of these semantics implicitly. Record a decision with its rationale, scope and specification references before promoting a corresponding assumption into the normative model.

## G1 — Source of truth for each transition

- Which K7PL transitions are already normative in C4, and which remain proposed or under review?
- Does each TLA+ model represent a normative transition, a chosen profile, or a deliberately abstract scenario?
- What evidence is needed before a K module is considered authoritative for that transition?

**Gate:** create a source-to-model transition inventory before claiming K/TLA correspondence.

## G2 — Join-pattern matching

- What is the exact admissibility predicate for a multi-mailbox join?
- How are type, payload, pattern and guard conditions combined?
- Is the current stable sender-ID ordering normative, or only a candidate deterministic policy?
- How is a matching tuple selected when multiple admissible tuples exist?
- Is consumption abstractly atomic, and what exactly is consumed on handler failure?

**Gate:** TLA-02 may explore candidate policies, but must not choose the normative policy by implementation convenience.

## G3 — Scheduler and fairness

- What does it mean for an actor or fibre to be continuously enabled?
- Which transitions, if any, are weakly fair?
- Are any actions strongly fair?
- Does the scheduler make per-actor guarantees, per-fibre guarantees or only global pool progress?
- What predicate establishes that a fibre has completed a valid program result and may transition to Terminated?
- Can any Ready fibre terminate, or must termination be justified by a completed control-flow/result state?
- Is an external event producer assumed to deliver, and under what condition?

**Gate:** document each fairness assumption next to the action and justify it against an actual runtime contract. Do not add WF/SF merely to make a liveness check pass.

## G4 — Asynchronous mailbox and timeout semantics

- Are messages durable, volatile or profile-dependent?
- Can messages be duplicated, reordered or lost in the abstract semantics?
- What is the precise residual session state after send, receive and branch selection?
- Does `Timeout` terminate a session, trigger a handler or merely make a transition enabled?
- Can a message arrive concurrently with timeout, and how is the race resolved?

**Gate:** specify message lifecycle and timeout before declaring deadlock or progress properties.

## G5 — Cancellation and effect commit

- What is the linearisation point between cancellation and commit?
- Does `CancelAck` guarantee that no effect has committed?
- How are repeated cancel/commit requests handled?
- What does timeout mean if the service has committed but the acknowledgement is lost?
- Which external effects are idempotent, transactional or compensatable?

**Gate:** keep request, acknowledgement, commit and timeout as separate states. Preserve R9's negative control unless a reviewed replacement supersedes it.

## G6 — FFI transfer and revocation

- What authority is transferred to a foreign component?
- Can the foreign component retain aliases after call return?
- What does successful revocation mean: no future use, no outstanding reference, or physical invalidation?
- How are errors, crashes and timeouts treated?
- Which assumptions are abstract, and which depend on OS, hardware or the ABI?

**Gate:** the model may test an abstract revocation protocol but may not claim hardware isolation or alias invalidation.

## G7 — Entity identity and memory lifetime

- What is the normative meaning of an entity generation and slot reuse?
- Can generation counters wrap or be reset?
- What must be invalidated on destruction, restoration and actor reincarnation?
- Which guarantees belong to the language and which to a target-specific representation?
- Who owns a region and each range/cell, and how is ownership transferred when a capability is split, merged, borrowed or revoked?
- Which operations change the permission set, and what invariant relates region ownership to ReadCap/WriteCap authority?

**Gate:** include reuse and wraparound in the abstraction or clearly declare them outside the model and retain an independent proof obligation.

## G8 — Observation and security level

- What counts as an observation for a level-ℓ observer?
- Are event order, event count, wait duration, scheduling and termination observable?
- Does projection remove secret timing as well as secret payloads?
- What non-interference relation links two executions?
- Which declassification cases are excluded?

**Gate:** define the observer and projection before using TLA-11 as evidence for `thm:stratification_journal`.

## G9 — Grade and budget semantics

- Which dynamic events count as a resource use?
- Is the dynamic counter per binding, per fibre, per actor or per execution?
- How are shared bindings aggregated?
- What is the unit of the normative budget: abstract work/depth, operation count or something else?
- How do effects and parallel branches consume or combine the budget?

**Gate:** TLA-09 must not turn abstract budget into cycles or wall-clock time without a separate operational and machine-cost interpretation.

## G10 — Logical time and real time

- What clock or tick abstraction does the language expose?
- Is `when` wait time distinct from execution cost for every profile?
- What are timeout, deadline and periodicity semantics?
- Are clock drift, scheduling delay and suspension in scope?
- Is there any actual probabilistic timing claim?

**Gate:** keep discrete logical behaviour, abstract cost and measured physical time separate. Only add PRISM if a probabilistic model is explicitly required.

## G11 — Queue implementation and weak memory

- What is the actual runtime language and memory model?
- Is the SPSC topology normative or just one implementation candidate?
- What atomicity and ordering assumptions are required for publication and slot reuse?
- How is the concrete queue state related to the abstract mailbox state?
- What fairness assumption is made about propagation of published writes?

**Gate:** do not start concrete GenMC verification until the implementation language and memory primitives are fixed. Keep TLA-16's abstract queue distinct from the concrete memory-model checker.

## G12 — Distributed profiles and CRDT delivery

- Is a distributed actor runtime in scope or only an architectural possibility?
- What delivery and partition assumptions are promised?
- Are messages at-least-once, at-most-once or exactly-once under a particular protocol?
- What happens to external effects during replay and reconciliation?

**Gate:** TLA-15 remains conditional until a concrete distributed profile is selected.

## G13 — Noise integration

- Is Noise part of a standard library or a normative integration requirement?
- Which handshake profile and message variants are in scope?
- Which cryptographic properties are assumed from the underlying primitives?

**Gate:** TLA-14 remains optional. TLA+ protocol-state modelling must not be advertised as cryptographic proof.

## G14 — K / TLA+ / Lean correspondence

- What is the source configuration type and what is the TLA+ state type?
- Is the target relation forward simulation, refinement, bisimulation or only a test oracle?
- Which source transitions can be represented by one target step, several target steps or stuttering?
- How are event partial orders preserved?
- What conditions transfer safety? What additional fairness/divergence conditions transfer liveness?
- Which relation and theorem are to be checked in Lean?

**Gate:** every claimed cross-formalism result must have an explicit relation, scope, assumptions and proof/evidence. Similar state names do not constitute correspondence.

## G15 — Model bounds and generality

- Why are the actor, mailbox, message, budget and history bounds adequate for a counterexample search?
- Which arithmetic is finite by design and which is only bounded for TLC?
- Is symmetry reduction sound for the property?
- Which results require an unbounded proof in Lean?

**Gate:** every model check reports the bounds and must not be described as a general theorem.

## G16 — Priorities and normative authority

The model-family groupings in WORK-PLAN.md are descriptive. The separate P0–P4 scale in REMEDIATION-ROADMAP-P0-P4.md describes audit-remediation urgency only; neither grouping changes the existing roadmap, assurance status or normative requirements.

**Gate:** review sequencing and dependencies before opening implementation tasks. Any normative change requires explicit owner ratification and the repository's normal issue/PR workflow.

## G17 — Non-vacuity and property sensitivity

- Which transition can exercise each positive invariant or temporal property?
- Is that transition reachable under the positive profile's constants and assumptions?
- Is the property substantive, definitionally implied, bounded-scenario-only or conditional?
- Does a negative control reach the named violation through the intended unsafe alternative, rather than through parsing, configuration, ASSUME or type failure?
- Does the retained trace demonstrate the claimed behaviour, and does the run exhaust the declared state space?

**Gate:** do not count a positive result as substantive protocol coverage until the relevant transitions are reachable and the property has a meaningful sensitivity argument. Keep definition-level checks if useful, but label them honestly. Do not remove invariants or weaken assumptions merely to make the suite pass.


## G18 — Prepared reactive patch after writer-capability revocation

- If `HandleEvent` has prepared a patch but `ApplyPatch` has not yet run, what must happen when `WriteCap(DOM)` is revoked?
- Must the prepared patch be discarded, recomputed/retried under a newly granted capability, or retained under an explicitly bounded lease?
- How are the patch base version, intervening logical state changes, queued events, resource accounting and frame deadline treated in each policy?
- Is revocation synchronous with respect to all outstanding patch work, or does it have a completion/acknowledgement point?

**Gate:** the current TLA-12 candidate only checks that an already prepared patch is not applied after revocation; it leaves the patch pending. Do not infer a discard, retry or lease policy from that safety abstraction. Ratify the lifecycle policy and its failure cases before modelling disposal, recomputation or lease expiry.
