<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# TLA+ remediation roadmap — priorities P0 to P4

**Snapshot:** 2026-11-01.  
**Repository:** AntheaLiles/k7pl.  
**Workstream:** PR #319, branch fix/tla-ci-unified-suite-2026-10-31.  
**Specification baseline:** main@2fbf609f6f3e67ffe011a3f28fd247526684155a.  
**Status:** remediation plan proposed from the PR #319 audit and the first end-to-end TLC run. This document is non-normative and does not ratify a language or runtime guarantee.

## 1. Purpose, authority and priority semantics

This roadmap consolidates defects and further work identified by the PR #319 audit, the first actual TLC run, and the review of the current model programme. It distinguishes immediate validation defects from model-quality problems, specification gaps, concrete implementation refinements and conditional research.

The P0–P4 labels in this document are an **audit-remediation urgency scale**. They replace the former, overlapping P0/P1/P2 labels used to group model families in WORK-PLAN.md and CHAPTER-COVERAGE.md. Those former labels were not stable across documents: one file used P0 for semantic foundations while another used P0 for memory isolation. The model families are therefore now grouped descriptively in WORK-PLAN.md; use this single scale when discussing remediation priority.

The authority boundaries remain unchanged:

- Verso on the current main baseline is the normative source.
- CHAPTER-COVERAGE.md is the live model-to-specification coverage matrix.
- OPEN-GATES.md records unresolved semantic decisions.
- wiki/assurance.md remains the central theorem and assurance-gap register.
- WORK-PLAN.md records model-family scope, dependencies and acceptance criteria.
- This roadmap records remediation urgency and recommended execution order; it is not a second normative register.

A model or a TLC result does not add a language rule, establish K/Lean correspondence, prove implementation conformance, or provide a hardware or real-time guarantee. Do not promote a claim merely because a positive TLC profile completes.

## 2. Evidence baseline and current status

### 2.1 First end-to-end TLC run

Workflow run 41305607506 executed all 39 registered TLA-01..16 profiles on the pre-parser-fix branch head efd0212b065016c206b9c83c0059f3623957959b, using the pinned TLC 1.7.4 JAR.

| Profile class | Expected count | Expected outcome reached | No model verdict |
|---|---:|---:|---:|
| Positive | 18 | 10 completed with no TLC error | 8 |
| Negative | 21 | 12 reached the named invariant violation | 9 |
| **Total** | **39** | **22** | **17** |

The 17 profiles without a model verdict were concentrated in six modules:

- TLA-01: malformed WaitFor set comprehension; all three positive profiles and both negative profiles failed before state exploration.
- TLA-02: malformed AdmissiblePairs set comprehension; positive and negative profiles failed during parsing.
- TLA-05: precedence conflict between conjunction and disjunction in CommitEffect; positive and negative profiles failed during parsing.
- TLA-07: mismatched bracket in capabilityGeneration update; positive and three negative profiles failed during parsing.
- TLA-12: duplicate existential binder in Next; the positive and negative profiles failed semantic analysis.
- TLA-16: malformed PendingMessages set comprehension; positive and negative profiles failed semantic analysis.

These are parser/semantic failures, not invariant counterexamples and not successful negative controls. The first run did not establish the expected verdict for those 17 profiles.

### 2.2 Corrections present in the branch

The following changes are present in the PR #319 branch after the first run:

- TLA-16 configuration values use the string values required by the module's ASSUME.
- TLA-06 occurrence counters were replaced by finite Boolean occurrence indicators. This preserves the zero-versus-one-or-more distinction used by the named invariants while removing unbounded counter growth.
- TLA-12 now has the explicit FrameLimit bound in its configurations and a guarded frame advance. The bound is an exploration device, not a physical frame-rate claim.
- TLA-14's authored negative witness begins with SendClientHello, the precondition required by AcceptClientHello.
- The six module-level parser/semantic defects observed in the first run were corrected in commit 9a243c9675259c99b83c131301e4a5e7407ddcd7.
- The negative-profile runner now requires TLC's exact diagnostic: Error: Invariant <name> is violated. A parser error, timeout, unrelated invariant violation or arbitrary non-zero exit cannot count as a successful negative profile.

The checkpoint was updated in commit 29845511f018b80da543b975a995b477d4ba9cb4. The CI run associated with that pre-documentation head, workflow run 41306284770, was pending when this snapshot was written. **The corrected 39-profile suite has not yet been observed completing successfully.** Do not describe it as green until the run on the current head provides the evidence.

### 2.3 Audit findings that remain relevant after the first run

The first run confirmed that the new runner exposes syntax and semantic failures. It also confirmed that several negative controls reach the intended invariant on the modules that TLC can parse. It did not resolve the audit's broader concerns about vacuous or definitionally satisfied positive properties, coverage gaps, deadlock settings, cross-model composition, or concrete implementation refinement.

## 3. P0 — close validation and reproducibility blockers

**Intent:** ensure the model suite and its test harness produce a truthful, reproducible result before any profile status is promoted or PR #319 is considered mergeable.

### Findings

1. The initial audit's B1 was a TLA-16 module/configuration type mismatch. The configuration values were changed to strings; the first actual run then exposed a separate module-level comprehension error.
2. The initial audit's B2 identified unbounded state growth in TLA-06 and TLA-12. The counters/bounds were changed as described above; their corrected positive profiles still require an observed completed run.
3. The initial audit's B3 identified an infeasible TLA-14 authored witness. The missing SendClientHello transition was added; retain the JSON as an expected scenario, not as an observed TLC trace.
4. The first end-to-end run exposed further parser/semantic defects in TLA-01, TLA-02, TLA-05, TLA-07, TLA-12 and TLA-16.
5. Before the strict runner correction, a negative profile could be misclassified if TLC failed for an unrelated reason and the output happened to contain the expected invariant name. The current TLA runner checks the exact invariant-violation diagnostic.
6. D01 and R9 also use shell-level negative-result checks. Their current grep tests should be reviewed for equivalent strictness; do not assume the stricter Deno predicate automatically governs those legacy checks.

### Recommended actions

| ID | Action | Acceptance evidence |
|---|---|---|
| P0.1 | Run the corrected branch head through all 39 TLA profiles. Resolve every parser, semantic, ASSUME, type, invariant and timeout failure without weakening the intended property. | All 18 positive profiles complete with TLC's no-error completion message; all 21 negative profiles terminate on their exact named invariant violation. |
| P0.2 | Inspect each profile's state count, queue exhaustion, depth, exact configuration, constants and tool identity. Distinguish completed exploration from initial-state-only or otherwise vacuous runs. | Per-profile evidence is retained; each profile has a recorded completion verdict and its declared bounds. |
| P0.3 | Review the legacy D01/R9 negative checks for the same false-positive risk as the original TLA runner. Require a specific TLC invariant-violation diagnostic, not merely a non-zero exit or occurrence of the invariant name. | Negative D01/R9 tests fail on parser/configuration errors and pass only on their expected invariant violation. |
| P0.4 | Preserve the suite evidence for the exact CI head: sources, configs, authored expectations, individual logs, Java/TLC version and digest, checksums, state counts and counterexample traces. Keep the D01 artifact hand-off to k-smoke intact. | Artifact is present with fail-on-missing semantics; evidence identifies the exact head and every profile. |
| P0.5 | Keep registry/manifest coverage and documentation-only exclusions tested. A new TLA config or model module must not be silently omitted; a programme-only Markdown file must not launch TLC. | Deno inventory tests, derived-classifier tests, format/check/lint/test, REUSE and CommitLint pass on the same head. |
| P0.6 | Consider a fast parser/import preflight tier only after verifying the supported SANY invocation against the pinned TLC release. It supplements, but does not replace, TLC configuration parsing and model checking. | The parser tier is deterministic, pinned, tested, and does not claim that configuration semantics or state exploration have been checked. |

### P0 exit rule

P0 is closed only on a single identified PR head where the required CI jobs are complete and successful, all 39 profiles meet their declared outcomes, and the evidence artifact has been inspected. A queued or pending run, successful unrelated jobs, or a green subset is not P0 closure.

## 4. P1 — make existing model properties substantive

**Intent:** determine whether each positive result exercises the transition protocol relevant to its property, rather than merely confirming a fact fixed by constants, initial state or the definition of an action.

| Model/property | Current limitation | Recommendation |
|---|---|---|
| TLA-03 — NoTerminatedFibreExecutes | The positive profile fixes AllowTerminate = FALSE. The property cannot exercise a termination transition in that profile. | Add a positive scenario in which termination is reachable and ensure every execution action is guarded against a terminated fibre. Keep the unsafe control as a separate counterexample. |
| TLA-07 — NoOverlappingWriteRights | CapCells are disjoint by construction and do not change. The property does not test preservation under ownership or permission transitions. | First resolve the WriteCap/ReadCap and region-ownership contracts. Then model grant, split, transfer, revoke, merge and reuse only where those operations are defined. Keep H1–H3 as Lean/type-theory obligations. |
| TLA-12 — DOMWriteRequiresCapability | writerCapability is initialised but never changed. The model does not represent revocation between HandleEvent and ApplyPatch. | Obtain an explicit policy for a prepared patch after capability revocation: discard, retry or commit under a defined lease. Add a revocation action and positive/negative interleavings only after this decision. |
| TLA-01 — timeout profile | NoMutualWaitDeadlock is defined over NonTimeoutWaitFor, which excludes edges with an armed timeout. This is not a general deadlock-freedom result for timeout-enabled waits. | Separate internal wait-cycle, timeout-enabled escape, timeout occurrence, external delivery and global progress claims. State fairness assumptions for any liveness claim. |
| TLA-01 — Simulation Gap | The cited configuration checks Simulation. TLC stops at the first violated invariant, so another property visible in the same trace is not a second TLC verdict. | Keep each expected negative property in a configuration that checks that property; label trace-derived observations separately. |
| TLA-05 — CommittedNotCancelled and TimeoutIsNotAcknowledgement | These are close to definitional consequences of the transition updates. The substantive checks are AcknowledgedCancellationMeansNoCommit and EffectAtMostOnce. | Retain the checks for consistency if useful, but do not count them as independent protocol coverage. Add scenarios that exercise the meaningful commit/cancel race. |
| TLA-09 — BudgetNonNegative | In the positive profile the property follows arithmetically from the configured grade limits. | Describe it as a consistency check. Expand the operational model only after the full grade/budget semantics and resource-use unit are defined. |
| TLA-11 — LowObservationEquality | RunPairedObservation is a one-transition paired-run model. | Treat it as a definition-level example. Expand trace length, event ordering and attacker observations only after G8 is resolved. |
| TLA-16 — abstract SPSC queue | The model assumes atomic transitions and does not explore compiler/CPU reorderings, cache coherence or release/acquire behaviour. | Keep it labelled abstract-only. Do not claim weak-memory correctness from this model. |

All 43 configurations currently set CHECK_DEADLOCK FALSE. Built-in TLC deadlock detection is therefore disabled across this suite. This does not invalidate the explicit NoMutualWaitDeadlock invariant in selected TLA-01 profiles, but it prohibits a claim that the suite globally checked deadlock absence.

### Recommended P1 deliverables

1. Maintain an invariant-quality table in CHAPTER-COVERAGE.md or a linked model-quality appendix. For every positive property, record: relevant transition, reachable witness state, whether the property is nontrivial, and which negative control demonstrates sensitivity.
2. Classify every checked property as substantive protocol property, definitionally implied property, bounded-scenario property, or conditional property.
3. For each negative profile, retain the exact TLC trace and verify that the trace follows the declared transition sequence and changes only the intended unsafe premise where possible.
4. Record state-space size and completion. A successful profile with one initial state may still be useful as a definition check, but it must not be presented as broad state-space exploration.
5. Revisit the global CHECK_DEADLOCK FALSE setting separately. Enabling built-in deadlock detection indiscriminately may flag intended terminal/quiescent states; any change requires an explicit terminal-state policy and per-model analysis.

### P1 exit rule

A property is not credited as substantive protocol evidence until its positive profile reaches the relevant transitions and its negative control demonstrates that the property can be violated under the declared unsafe alternative. Vacuity/definition-level checks may remain, but must be labelled honestly.

## 5. P2 — close normative traceability and semantic design gates

**Intent:** make the current model set answer explicit questions derived from the current specification, without allowing implementation preferences or convenient TLC abstractions to become normative rules.

| Topic | Existing evidence / unresolved point | Recommendation |
|---|---|---|
| C4 spatial-safety theorem H1–H3 | Unique introduction of WriteCap, region-to-interval correspondence and non-capture between modes remain theorem premises. TLA-07 does not discharge them. | Keep H1–H3 in wiki/assurance.md and close them through explicit typing rules and Lean proofs. Use TLA only for complementary allocation/revocation protocols. |
| Channel sharing | The specification distinguishes read-sharing of a memory region from sharing/borrowing a channel. The latter's context algebra is unresolved. | Resolve the type-theoretic rule before extending TLA-02 or declaring channel sharing equivalent to memory sharing. |
| Import and foreign execution | Import, remote sources, pre-verification macro execution and FFI boundaries need a concrete trust/sandbox/effect/provenance contract. TLA-06 covers logical capability transfer only. | Specify acquisition, provenance/version/hash, available capabilities, allowed effects, failure/timeouts, callbacks, reentrancy, unwind and revocation before a broader operational model. |
| K/TLA+/Lean relation | Similar state names and a shared workflow do not establish correspondence. A typed relation, step mapping, stuttering policy and event-order preservation remain open. | Define the relation property by property, then prove the selected safety transfer in Lean. Treat liveness separately with fairness and divergence conditions. |
| Cross-model composition | TLA-01..16 are independent transition systems. MODEL-DEPENDENCIES.md records conceptual dependencies, not imports or composition. | Do not create a global model until shared state, ownership transfer, stuttering and an interface relation are explicitly designed and reviewed. |
| Normative coverage | Existing coverage spans candidate scenarios but not all clauses or guarantees. The obligation-level report based on PR #311 is historical and must not override the current main baseline. | Link every future model property to a current main clause/label, status and scope. Preserve PR #311 material as historical until merged and revalidated. |

### Recommended P2 work

- Review G1–G16 in OPEN-GATES.md; do not silently choose semantics merely to make a model executable.
- Add a non-vacuity gate (G17) requiring an explicit property-to-transition argument and a falsifying control or a documented reason why no control is meaningful.
- Update CHAPTER-COVERAGE.md at obligation level: clause/label, model/module, property, assumptions, bound, omitted behaviour, evidence status and remaining proof/refinement obligation.
- Keep wiki/assurance.md as the single theorem/gap register. Do not create a fourth copy of the P0–P4 inventory in WORK-PLAN.md or CHECKPOINT.md.
- Require a source clause and a falsifiable guarantee before assigning TLA-17 or any further model identifier.

### P2 exit rule

A model is traceable when its claims map to a clause on the current normative baseline, its abstraction and omissions are stated, and all unresolved semantic choices are represented as open gates rather than hidden constants. Traceability is not correspondence proof.

## 6. P3 — develop concrete runtime and hardware refinements

**Intent:** move from logical protocols to implementation-relevant models only after the target runtime, ABI, memory model and hardware assumptions are explicit.

| Candidate refinement | Missing state/behaviour | Recommendation and boundary |
|---|---|---|
| CPU virtual memory / MMU | Address spaces, page tables, per-core TLBs, ASID/PCID reuse, map/unmap, permissions, faults, shootdown messages and acknowledgements | A separate CPU/MMU protocol should establish stale-translation invalidation before page reuse. TLC checks the protocol under assumptions; it does not prove a CPU implementation. |
| Device translation / IOMMU | Device domains, IOVA mappings, IOTLB/ATS caches, PASID, in-flight DMA, invalidation completion, reset and hot-unplug | Keep separate from MMU because agents, caches and completion conditions differ. Couple the models through physical-page ownership and invalidation completion. |
| Physical page lifetime | Allocation/free/reuse, pinning, CPU/device references, outstanding operations, epoch/hazard reclamation, ABA and migration | Define one ownership/reclamation invariant before detailed MMU and IOMMU models. A page must not be reused while any effective reference can still target its prior owner. |
| Remanence and initialisation | Payload contents, dirty cache lines, partial zeroing, abandoned pages and DMA buffers | Model confidentiality across ownership transfer only after the concrete allocation/initialisation contract is identified. |
| Permission algebra and aliasing | Multiple readers, exclusive writer, split/merge, borrow lifetimes, overlapping mappings and concurrent revoke | Derive from the actual WriteCap/ReadCap and grade semantics; do not infer permission algebra from disjoint constant cell sets. |
| Weak-memory queue refinement | Atomic operations, acquire/release, fences, coherence, tearing, compiler and CPU reorderings | Keep TLA-16 as the abstract protocol. Choose a concrete checker only after the runtime language, compiler and target memory model are known. |
| Concrete FFI/ABI and device boundary | Layout, alignment, pointer provenance, pinning, aliasing, callbacks, reentrancy, unwind, async completion, thread affinity, driver reset and fault handling | Extend TLA-06/D01 only from a documented ABI/runtime contract. Logical revocation is not physical alias or DMA invalidation. |
| Runtime persistence and supervision | WAL/flush ordering, torn writes, snapshots, actor incarnation, restarts, duplicate delivery and idempotency | Refine TLA-04/05 only where a concrete persistence and supervision design exists. |

### P3 tooling guidance

- GenMC is relevant only if the concrete implementation is C/C++ and the operations used fit its supported memory model.
- Hardware-specific model checking or architecture litmus tests need a named target ISA, device contract and memory-order assumptions.
- Runtime tests and measurements complement formal models; they do not retroactively prove that the model abstracts all implementation behaviour.
- MMU and IOMMU must not be collapsed into one state machine merely to reduce file count.

### P3 exit rule

A concrete refinement requires a target profile, a defined abstraction relation to the existing logical model, explicit hardware/runtime assumptions, and a validation method matched to the target. Until then it remains a research proposal.

## 7. P4 — conditional integrations and advanced analysis

**Intent:** reserve effort for capabilities that are not yet adopted as core guarantees or that require a separate analysis method.

| Topic | Activation condition | Recommendation |
|---|---|---|
| TLA-14 / Noise handshake | A specific Noise pattern or protocol profile is selected as a supported integration | Keep the TLA model at protocol-state level. Cryptographic security, primitive assumptions, nonce discipline and transcript binding require cryptographic analysis; TLC is not a proof of computational security. |
| TLA-15 / distributed replication | A distributed runtime or library profile is adopted with explicit delivery, partition and membership guarantees | Extend beyond the connected two-replica G-set scenario only after loss, duplication, reordering, epochs, reconciliation and external effects are specified. |
| Reactive backpressure | C7 runtime contract requires bounded queues, overload behaviour, coalescing, drops or patch rollback | Extend TLA-12 only after queue, cancellation and capability-revocation semantics are decided. |
| Concurrent compilation service | The implementation introduces concurrent workers, caches, cancellation or atomic artifact publication | Model the actual service lifecycle rather than a hypothetical compilation automaton. |
| OS resource handles | The selected execution environment exposes file/network/process/device handles with defined ownership and revocation | Model only the interfaces actually included in the execution environment. |
| Probabilistic timing | A probability distribution, adversary, time horizon and measurable result are specified | Consider PRISM; do not introduce probability merely because latency or randomness exists. |
| Symbolic bounded checking | A specific model has a large data domain or SMT-friendly constraints | Consider Apalache for bounded analysis; record bounds and solver. |
| Deductive TLA proofs | A parameterised model lemma cannot be addressed more appropriately in Lean | Consider TLAPS for that lemma only; keep Lean primary for language-wide theorems. |

### P4 exit rule

No P4 work starts solely because a tool or model is available. The integration or analysis method must be justified by a selected feature, a documented contract and a concrete property.

## 8. Cross-cutting acceptance protocol

Every remediation task must produce:

1. A stable problem identifier and links to the audit finding, current specification clause and open gate.
2. A statement of what is known, assumed, unmodelled and not claimed.
3. A state/action/property description, including fairness and failure assumptions where relevant.
4. A positive profile, a negative control where meaningful, and the exact expected verdict.
5. A finite-bound rationale and an explicit statement of what generalisation is not justified.
6. Reproducible tool output tied to the exact commit, module, configuration and tool digest.
7. Updates to the live coverage matrix, the relevant work-plan entry and the checkpoint, without duplicating the theorem register.
8. CI evidence from the current branch head; no direct merge to main and no status promotion without the required evidence.

Use these status terms precisely: model-drafted, model-checked-bounded, counterexample-found, correspondence-open, correspondence-proved, implemented, tested and measured. They are not interchangeable.

## 9. Recommended execution order

1. Close P0 on one PR head. Do not start broad semantic extensions while parser/configuration failures remain.
2. Execute P1 model-quality review against the 39 actual results. Remove vacuity from claims, not by weakening properties but by making relevant transitions reachable and adding meaningful controls.
3. Close P2 decisions and traceability. Prioritise capability revocation/patch commit, memory ownership, FFI completion and the K/TLA+ relation.
4. Start P3 only for target/runtime contracts that are defined and needed by the project.
5. Activate P4 selectively after a feature or integration is adopted.

The immediate next action is therefore to inspect the latest CI run on the corrected PR #319 head, obtain the 39-profile verdicts, and then work through P1 without conflating model quality with specification coverage.
