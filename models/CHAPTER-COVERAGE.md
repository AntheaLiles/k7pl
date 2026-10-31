<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Specification coverage and TLA+ allocation

**Specification baseline:** PR #311 at `f3b33cd34e1da49a4c8c41ca632c586e66715e70`.  
**Status:** documentary analysis; proposed coverage, not normative ratification.

## 1. Chapter-level matrix

| Chapter | Relevant commitments | Proposed TLA+ work | TLA+ necessity |
|---|---|---|---|
| C1 — Prolegomena | Germinal postulates, normative vocabulary and foundational commitments | No standalone model. Instantiate each property only when a later chapter gives it states and transitions. | Not needed directly |
| C2 — Categorical foundations | Graded resources, budget consumption, effect composition, parallel effects, actors, bounded activation, `yield`, fixed points | TLA-03 for scheduler/productivity scenarios; TLA-09 for dynamic resource and budget accounting; TLA-13 for a deductive-job protocol only | Partial |
| C3 — Type theory | Asynchronous session types, mailbox semantics, protocol duality, deadlock theorem, capabilities, resource grades and effects | TLA-01, TLA-02, TLA-07 and TLA-09 | Necessary for dynamic behaviours; not for static typing laws |
| C4 — Automata theory | Actor state, memory regions, actor topology, mailbox and join semantics, scheduling, partial-order traces, cancellation, replay, FFI and operational transitions | TLA-01 through TLA-11, plus TLA-14 through TLA-16 where the selected profile requires them | Main TLA+ coverage |
| C5 — Syntax and practice | Lexical classes, delimiters, layers, trains, macros, elaboration and syntax stability | No dedicated TLA+ model. Use parser tests, grammar analysis and Lean proofs. | Not needed |
| C6 — Compilation and verification | Compilation phases, solver obligations, monomorphisation, finite specialization budget and pipeline stabilization | No model for the static pipeline by default. A separate model may be justified only if an implemented compilation service introduces concurrent caches, workers or cancellation. | Not needed for current commitments |
| C7 — Practical integration | Reactive interface, interactive development/replay debugger, deductive engine | TLA-12 and TLA-13; optional profiles TLA-14 and TLA-15 | Scenario-level |
| Annex A | Summaries of protocol, session, capability, memory, productivity and termination requirements | Cross-reference the corresponding work items; do not create duplicate models merely because an annex repeats a chapter commitment. | Inherited |

Priority labels P0/P1/P2 used in the work plan are provisional sequencing recommendations. They are not the repository's existing roadmap priorities and are not owner-ratified.

## 2. Detailed mapping

### C1 — Prolegomena

No standalone transition system is justified merely by the foundational or categorical vocabulary. TLA+ should not be used to restate axioms that contain no operational state or temporal property.

A later model may instantiate a C1 commitment, but its normative home remains the relevant chapter and its proof obligation must be stated at that later level.

### C2 — Categorical foundations

| Specification area | Candidate obligation | Work item | Preferred method |
|---|---|---|---|
| `C2/AlgebrasCoalgebrasAndFixedPoints` | Actor consumes messages, evolves state and is bounded by grades per scheduling turn; `yield` advances productive streams | TLA-03 | TLA+ / TLC for scheduler scenarios; Lean for general coalgebraic and productivity claims |
| `C2/ExponentialComonadAndFragments` | Cost and budget composition, partial `Consume`, parallel effect action | TLA-09 | Lean for algebraic laws; TLA+ for finite operational accounting scenarios |
| `C2/SixMetatheorySchemas` | Static topological-order result and capacity lemma | No independent model; relate to TLA-01/TLA-07 if an execution scenario is needed | Lean and static graph algorithms |
| `C2/AdjunctionsAndEnrichment` | Grade-factorisation and order laws | No direct TLA+ model | Lean |

The existence and termination of a least fixed point, monotonicity, grade algebra and adjunction laws are not model-checking tasks. TLA-13 concerns the execution protocol of one deductive job, not a replacement proof of the general fixed-point theorem.

### C3 — Type theory

| Specification area | Candidate obligation | Work item | Preferred method |
|---|---|---|---|
| `C3/ValueConstraints` — asynchronous sessions | Dual endpoints do not guarantee message delivery or progress; static dependency DAG must constrain dynamic wait graph | TLA-01 | TLA+ / TLC; Lean for the general simulation theorem |
| `C3/ValueConstraints` — `thm:deadlock_acyclique` | Relate static dependencies to dynamic waits, including `Guard`, message send/consume, residual mailbox types and `Timeout` | TLA-01 | TLC counterexamples and finite models; Lean for general proof |
| `C3/ValueConstraints` — session communication | Type-correct asynchronous protocols and residual states | TLA-01 | TLA+ / TLC for reachable executions; Lean for duality and typing |
| `C3/GradedSystem` | Linear write capabilities, concurrent readers/writers and fractional grades | TLA-07, TLA-09 | TLA+ finite resource protocols; Lean for static grade guarantees |
| `C3/TermGrammar` and `TypingRules` | Parallel composition, `wait`, `when`, `at`, grades and effects | TLA-03, TLA-08, TLA-09, TLA-10 | TLA+ for runtime behaviour; Lean for typing/effect laws |
| `C3/OpenStructuresEffectsAndMetatheory` | Pure handlers and journal inputs | TLA-04, TLA-11 | TLA+ for replay/observation scenarios; Lean for functional correctness |

TLA+ must not become a duplicate type checker. Protocol duality, grade algebra, subtyping and static derivability stay in the static formalisation and proof layer. TLC should challenge the behavioural conclusions that are not implied by endpoint typing alone.

### C4 — Automata theory

C4 is the primary TLA+ target because it defines system states, process transitions, mailboxes, traces, scheduling and environment interactions.

| Specification file / section | Obligation or mechanism | Work item |
|---|---|---|
| `C4/LocalScale` | Bounded stack and finite protocol sequences | TLA-14 only if Noise is an adopted integration profile; the R-expression parser itself is not a TLA+ target |
| `C4/ActorScale` | Private actor state, actor transitions, fibres, partitioned regions, entity identity and generation | TLA-07, TLA-08 |
| `C4/MemoryModels` | Spatial safety, region disjointness, capability introduction and lifetime | TLA-07; Lean remains primary for general memory-safety theorems |
| `C4/SystemScale` | Actor lifecycle, activation, deactivation, snapshot, journal and replay | TLA-04 |
| `C4/SystemScale` | Failure, cancellation, recovery and restoration paths | TLA-04, TLA-05, TLA-06 |
| `C4/SystemScale` | Static dependency DAG versus dynamic wait graph; actor scheduling and initialization | TLA-01, TLA-03 |
| `C4/SystemScale` | Multi-message join patterns and atomic consumption | TLA-02 |
| `C4/SystemScale` | SPSC mailbox and acquire/release implementation refinement | TLA-16 |
| `C4/SystemScale` | FFI transfer, error paths, foreign aliases and revocation | TLA-06 |
| `C4/SystemScale` | CRDT replication and eventual convergence after partitions | TLA-15, conditional on a distributed profile |
| `C4/UnderlyingProcessCalculus` | Process calculus, communications, cuts, join patterns and actor translation | TLA-01, TLA-02, TLA-08; K-to-TLA correspondence is a separate obligation |
| `C4/OperationalSemantics` | Global pool progress, fork/join, parallel transitions and partial-order traces | TLA-03, TLA-08 |
| `C4/OperationalSemantics` — `thm:correction_ressource` | Instrumented execution counter and effective usage bound | TLA-09 as bounded exploration; Lean for the theorem |
| `C4/OperationalSemantics` — temporal forms | `at`, `wait`, `when`, `delay` and the separation of environmental waiting from execution cost | TLA-10 |
| `C4/OperationalSemantics` — `thm:stratification_journal` | Replay projection by security level and influence on later control | TLA-11 |
| `C4/OperationalSemantics` — `thm:preservation`, `thm:progres` | Transition-level safety and global progress | TLA-03, TLA-08; Lean remains primary for the general metatheorems |
| `C4/MetalanguageSortSystem` | Trace order, session relation and level-indexed observation | TLA-01, TLA-08, TLA-11 |
| `C4/WhatEachOpenProofDrawsOn` | Inventory of open proofs | Cross-reference model evidence; do not create a model solely for the inventory |

Several statements in C4 are marked `under-review` with `proofsketch`. Their presence in Verso is not a checked Lean proof. A model may help sharpen the statement or find a counterexample, but it cannot be recorded as closing the proof obligation.

### C5 — Syntax and practice

The grammar of symbolic expressions, delimiter rules, lexical classes, macro expansion, trains and elaboration are not state-space protocol problems. The appropriate work includes parser implementation, layer-check tests, grammar analysis and Lean proofs of elaboration or syntax properties.

TLA+ is not assigned to:
- lexical tokenisation or escape processing;
- delimiter balancing and reader recovery;
- static name resolution;
- macro-expansion hygiene;
- equivalence of surface and core syntax.

A future interactive editor service could have its own concurrency model, but that would model the service's request lifecycle, not the normative grammar.

### C6 — Compilation and verification

The compilation phases and monomorphisation budget are primarily static algorithms and termination obligations. Lean, solver contracts and compiler tests are the preferred tools.

Do not create a TLA+ model for:
- EBNF or parser phases;
- a static solver's constraint logic;
- static type inference;
- the general termination proof of monomorphisation;
- a finite topological sort of the compilation dependency graph.

A separate model becomes justified if an implemented compiler service introduces concurrent workers, shared caches, task cancellation or transactional publication of compiled artefacts. No such commitment is assumed here.

### C7 — Integration case studies

| Case study | Candidate property | Work item | Scope |
|---|---|---|---|
| I — Native reactive architecture | Event intake, state update, diff, DOM patch publication, exclusive write capability and frame lifecycle | TLA-12 | Scenario model; not a WCET proof |
| II — Interactive development and library | Complete journal, replay, pause/step debugger and consistent observable state | TLA-04, TLA-11 | Derived from C4 lifecycle and trace models |
| III — Deductive engine on columnar arenas | Job lifecycle, iterative saturation, budget exhaustion and publication only after convergence | TLA-13 | Scenario model; Lean proves generic fixed-point properties |

### Annex A

Annex A summaries should point to the same model identifiers as the main chapter. They do not create a second source of truth or a second copy of a protocol model.

## 3. Explicit non-targets

The programme deliberately does not assign TLA+ as the primary tool for:

- categorical laws, adjunctions, comonads or algebraic fixed-point theorems;
- static typing, subtyping, grade algebra or proof of session duality;
- lexical or syntactic parsing;
- the generic termination proof of pure layer-3 terms;
- source-to-binary compiler correctness;
- cryptographic collision resistance;
- physical memory isolation, hardware barriers or measured latency;
- a numerical WCET proof.

These may be assumptions or refinement targets of a model, but their proof obligations belong to other methods.


## 4. Gaps beyond the current TLA-01..16 allocation

This section is a research register, not a claim that every item below is already a normative K7PL requirement. The chapter matrix above maps the current TLA allocation against the PR #311 specification snapshot. A gap becomes a normative model obligation only after its state, transition and guarantee are traced to a current Verso clause. In particular, the current C4 `MemoryModels` allocation describes spatial safety, regions and capability lifetime; it does not establish a hardware MMU or IOMMU contract.

### 4.1 P0 — memory isolation and implementation refinement

| Proposed modelling package | Missing state and transitions | Central property to investigate | Current gap |
|---|---|---|---|
| CPU virtual memory / MMU | Address spaces; page-table levels and entries; map/unmap; permission changes; page faults; copy-on-write; ASID/PCID allocation and reuse; per-core TLB entries; shootdown messages and acknowledgements | A revoked or remapped page cannot be accessed through a stale CPU translation; physical-page reuse waits until all relevant invalidations have completed | TLA-07 models logical slots/generations/capabilities, not translation caches or address spaces |
| Device translation / IOMMU | Device-to-domain assignment; IOVA mappings; IOMMU page tables; IOTLB and device ATS caches; PASID; in-flight DMA; invalidation and completion; reset, hot-unplug and device reassignment | No stale translation or in-flight DMA can access a page after revocation or after it is reassigned to another protection domain | No current model contains devices, DMA operations, IOVA translation or device-cache invalidation |
| Physical page lifecycle and reclamation | Physical-page allocation/free/reuse; pin/unpin; CPU and device references; reference counts; epoch/hazard reclamation; page migration; ABA and allocator metadata | A page cannot be reused while any CPU, device or asynchronous operation can still hold an effective reference to its previous owner | TLA-07 bounds logical generations, but does not model concurrent physical reclamation or outstanding references |
| Initialisation and cross-domain remanence | Zero-on-allocation or zero-before-reuse; dirty cache lines; DMA buffers; partial initialisation; abandoned pages; crash/restart of an owner | A new protection domain cannot observe residual data from a previous owner, including through an incompletely initialised DMA buffer | No current model tracks payload contents across physical ownership changes |
| Shared-memory permission algebra | Multiple readers; exclusive writers; fractional read permissions; split/merge of permissions; borrow lifetimes; alias creation; overlapping mappings; concurrent revocation | Permission composition never creates incompatible writes or allows a revoked alias to remain effective | TLA-07 only checks finite disjoint logical write ranges; TLA-09 uses scalar use counts, not the full grade algebra |
| Concrete atomics and weak-memory refinement | Atomic read/write/CAS; relaxed/acquire/release; fences; coherence; tearing; compiler and CPU reordering; per-core observations; queue payload publication | The concrete queue and capability protocols refine the abstract happens-before and publication rules under a named language/ISA memory model | TLA-16 assumes atomic transitions and does not represent weak-memory executions |

**MMU and IOMMU must be separate transition systems.** They interact through physical-page ownership and completion of invalidation, but their agents and caches differ. The CPU/MMU model should include a per-core TLB and a shootdown completion protocol. The IOMMU model should include device domains, IOVA translations, IOTLB/ATS caches and DMA already in flight. Both need explicit hardware assumptions; TLC can find protocol counterexamples under those assumptions, but cannot prove that a specific CPU, chipset, firmware or peripheral implements them correctly.

### 4.2 P1 — runtime concurrency, failure and semantic completeness

| Proposed modelling package | Missing state and transitions | Why the current allocation is insufficient |
|---|---|---|
| Multi-core scheduler and preemption | Per-core run queues, work stealing, priority classes, preemption, interrupts, deferred work, lock contention, priority inversion, cancellation safe points | TLA-03 uses a small fibre scheduler and profile-local fairness assumptions |
| Actor supervision and incarnation lifecycle | Spawn/destroy, restart policies, supervision trees, actor incarnation IDs, late messages to a restarted actor, restart loops | TLA-04 models mailbox/snapshot/replay of one abstract actor, not supervision topology |
| Crash-consistent storage and transactions | WAL ordering, flush/barrier completion, torn writes, partial snapshots, journal compaction, inbox/outbox deduplication, atomic publication | TLA-04 assumes atomic snapshot persistence; its journal is an in-memory abstract sequence |
| Concrete FFI/ABI boundary | Layout/alignment, pointer provenance and aliasing, pinning, callbacks and reentrancy, unwind/panic, async callbacks after return/revoke, thread affinity | TLA-06 models logical capability handoff and acknowledgement, not an ABI or concrete runtime |
| Device and driver lifecycle | Device discovery, reset, hot-plug, driver replacement, capability grant/revoke, in-flight I/O, interrupt routing, fault reporting | The IOMMU candidate must be complemented by driver/device ownership and failure transitions |
| Distributed transport and membership | Loss, duplication, reordering, partitions, membership/epochs, failure detection, quorum/election, retries, reconciliation | TLA-15 is a two-replica connected-network G-set profile with conditional fairness, not a general unreliable transport |
| Resource algebra at execution time | The product `𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅`; grade composition; effect composition; parallel split/join; fractional sharing; capability transfer; refunds/settlement; overflow and cancellation accounting | TLA-09 checks a scalar count and abstract integer budget only |
| Temporal runtime guarantees | Logical/physical clock relation, drift, jitter, deadlines, timer cancellation races, queueing latency, simultaneous triggers | TLA-10 uses bounded logical ticks and makes no physical latency or WCET claim |
| Non-interference beyond values | Timing, resource-consumption, cache contention, scheduler choices, termination/control-flow channels, declassification and attacker observation model | TLA-11 checks paired low-value traces; it omits timing and microarchitectural channels |
| Full session progress assumptions | Fair message delivery, bounded/unbounded queues, timeout cancellation semantics, retries and duplicate handling, external actor failure | TLA-01 is a bounded topology model; progress depends on assumptions that are not fully represented by endpoint duality |
| Cross-model composition | Shared typed state, ownership transfer between lifecycle/capability/queue/resource models, stuttering and refinement relation | The sixteen models currently execute independently; conceptual dependencies are not a composed system proof |

### 4.3 P2 — conditional services and integration

| Proposed modelling package | Missing state and transitions | Activation condition |
|---|---|---|
| Reactive backpressure | Bounded event queues, overload, coalescing/debounce, dropped events, stale asynchronous responses, cancellation and patch rollback | Expand only if the C7 reactive runtime contract requires these guarantees |
| Cryptographic handshake and channel security | Nonce uniqueness, transcript binding, replay/downgrade, peer authentication, key confirmation and compromise assumptions | TLA-14 is only a finite protocol-phase abstraction; use a cryptographic verification method for security properties |
| Concurrent compilation service | Concurrent workers, incremental cache invalidation, task cancellation, stale build results and atomic artifact publication | Only if implementation actually introduces a concurrent compiler service |
| OS resource capability protocols | File/network/process/device handle lifecycle, delegation, revocation, close races and asynchronous I/O completion | Model only interfaces included in the specified execution environment |

### 4.4 Properties that should not be turned into artificial TLC models

The following are real coverage obligations, but they normally belong to another formal method:

- C1 postulates and foundational vocabulary: formalise or discharge by the relevant logical/metatheoretic method, not by inventing an operational automaton without transitions.
- C2 category theory, adjunctions, comonads, grade semirings, monotonicity and general fixed-point existence: Lean proofs, with TLC only for finite operational scenarios.
- C3 static typing, subtyping, session duality and general preservation/progress: Lean metatheory; TLC challenges dynamic assumptions and counterexamples but does not replace the proofs.
- C5 lexical analysis, escaping, delimiters, grammar, macro hygiene, expansion and elaboration: parser/compiler tests and Lean-level formalisation.
- C6 compilation correctness, static solver correctness and general termination of specialisation: Lean proofs, compiler validation and differential tests.
- Cryptographic hardness and primitive security: a dedicated cryptographic model/analysis; a finite TLA state machine cannot establish computational security.
- Real-time WCET and hardware isolation: target-specific measurement, architecture evidence and implementation refinement are required in addition to abstract models.

The priority labels are proposed sequencing aids, not owner-ratified priorities. Each future package needs a named source clause, explicit assumptions, abstraction relation, positive profile, negative control and evidence plan before it is assigned a TLA identifier.
