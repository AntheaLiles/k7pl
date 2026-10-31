<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL TLA+ specification coverage audit

**Specification baseline:** `AntheaLiles/k7pl` PR #311, head `f3b33cd34e1da49a4c8c41ca632c586e66715e70` (2026-10-31).  
**Model baseline:** repository-root `models/`, replacement workstream PR #319.  
**Status:** completed documentary coverage analysis; no normative change and no model status promotion.

## 1. Executive result

TLA-01..16 provide a useful first set of finite behavioural models, but they do **not** cover the complete operational content of the specification. The present suite is best described as *scenario coverage*, not specification coverage. The main omissions are not limited to MMU and IOMMU:

1. the correspondence between logical capabilities, physical memory ownership and reclamation;
2. concrete CPU and device memory-translation invalidation protocols;
3. the weak-memory refinement of message publication, queue access and capability transfer;
4. complete actor/session lifecycle and global progress assumptions;
5. crash-consistent persistence and complete replay;
6. complete resource/effect accounting across the multidimensional grade;
7. the time and observation channels used by the operational semantics;
8. the source-to-process-calculus simulation and cross-model composition obligations.

The suite has breadth across many domains, but most modules cover a small finite slice of a specification obligation. A green TLC result, once available, would validate only the state space, constants, assumptions and properties of that slice. It would not establish the corresponding general Verso theorem or implementation guarantee.

**MMU/IOMMU conclusion.** The reviewed C4 memory model does not specify a hardware MMU or IOMMU contract. It specifies an abstract memory/capability discipline and seven memory-management levels; it explicitly places concrete representation guarantees behind a versioned representation profile. The seventh level mentions raw linear WAT memory for FFI and DMA, and the system-scale chapter discusses VirtIO buffer ownership and revocation, but neither defines CPU page-table/TLB semantics, IOVA translation, IOTLB/ATS invalidation, or DMA quiescence. MMU and IOMMU models are therefore important *implementation-refinement work*, not new normative K7PL guarantees. They must be tied to a named target profile before their properties are treated as implementation acceptance criteria.

## 2. Method and coverage vocabulary

The audit distinguishes four questions that are often conflated:

- **Specified:** does a current Verso clause state the property, or is it only a possible implementation/example?
- **Modelled:** does an existing TLA module represent the relevant state and transitions, including the material assumptions?
- **Checked:** has TLC explored the exact module/configuration and obtained the expected result? This audit does not infer checking from the existence of a `.tla` or `.cfg` file.
- **Established:** is there a general proof, a concrete refinement argument, an implementation test, or a target-specific measurement sufficient for the claim?

Coverage labels used below:

- **Partial:** a related candidate model exists, but important state, transitions, assumptions or properties are absent.
- **Scenario-only:** a finite example explores one chosen profile; it does not cover all variants in the specification.
- **Conditional:** the specification describes an optional profile or the model assumes a deployment choice not generally adopted by K7PL.
- **No TLA target:** a different method is the primary method; absence of a TLA model is not a coverage defect.
- **Missing:** an operational obligation is stated or follows directly from a selected implementation profile, but no adequate model currently exists.
- **Open refinement:** an abstract property exists, but correspondence to a concrete representation or platform is not established.

TLA+ is suited to state-transition protocols, concurrency interleavings, safety invariants and temporal progress under explicit fairness/environment assumptions. It is not a substitute for proofs of categorical laws, static typing, general preservation/progress, algorithmic termination, cryptographic hardness, WCET, or the correctness of a physical hardware implementation. Those require Lean, algorithm-specific proof, parser/compiler testing, weak-memory tools, cryptographic verification or target-specific evidence as appropriate.

## 3. Chapter-level coverage matrix

| Specification chapter | Relevant obligations | Existing model allocation | Assessment |
|---|---|---|---|
| C1 — Prolegomena | Germinal postulates, separation of layers, foundational guarantees and normative vocabulary | No independent TLA model | **No TLA target** for the axioms themselves. Instantiate a later operational obligation only when a chapter defines states and transitions. |
| C2 — Categorical foundations | Inductive termination, coinductive productivity, grade/effect algebra, bounded resource use, fixed-point termination | TLA-03, TLA-09, TLA-13 | **Partial.** The models explore scheduler/accounting/job scenarios; general induction, coinduction, algebraic laws and fixed-point theorems remain Lean obligations. |
| C3 — Type theory | Session protocols, endpoint duality, asynchronous communication, deadlock theorem, graded capabilities, effects and usage | TLA-01, TLA-02, TLA-06, TLA-07, TLA-09 | **Partial.** Runtime traces are explored, but endpoint duality, type derivability, full resource algebra and the general deadlock argument are not model-checked by these modules. |
| C4 — Automata theory | Actor and system states, memory models, queues, joins, scheduling, traces, cancellation, FFI, operational semantics and process translation | TLA-01..11, TLA-14..16; TLA-12/13 for C7 scenarios | **Main TLA target, materially incomplete.** Several models cover only one profile or a simplified abstraction; composition and concrete refinement remain open. |
| C5 — Syntax and practice | Lexical classes, delimiters, layers, trains, macros, hygiene, elaboration | No dedicated TLA model | **No TLA target** for the static grammar/reader. Use parser tests, grammar arguments and Lean proofs. A concurrent editor service may be modelled separately from the grammar. |
| C6 — Compilation and verification | Static compilation phases, constraint solving, monomorphisation, specialization budget, graph ordering, compiler correctness | No dedicated TLA model | **No TLA target** for static algorithms and general correctness. Add a model only if an implemented compilation service actually introduces concurrency, shared caches, cancellation or transactional publication. |
| C7 — Integration case studies | Native reactive pipeline, interactive development/replay, deductive engine | TLA-04, TLA-11, TLA-12, TLA-13 | **Scenario-only.** The models capture basic event/replay/job protocols, not the complete UI, debugger or deductive-engine semantics. |
| Annex A | Summary of requirements already treated in the main chapters | Reuses the corresponding model identifiers | **Inherited.** Do not create duplicate models for repeated statements. |

## 4. Obligation-level findings

### 4.1 C2 — foundational execution properties

| Verso obligation | Existing model | What is represented | Remaining obligation | Assessment / method |
|---|---|---|---|---|
| `thm:terminaison_couche_3` and `thm:progression_polarisee` | No direct model; TLA-03 is adjacent | TLA-03 represents a finite scheduler and per-fibre service | It does not model the type-indexed decreasing measure, nested inductive recursion or the general guarantee that every valid layer-3 computation terminates. | **No TLA substitute.** Lean proof of the general theorem; TLA scheduler checks are complementary. |
| `thm:productivite_couche_2` | TLA-03, partly TLA-10 | Scheduler service and some wait/trigger transitions | Per-observation productivity under the actual typed guard; the distinction between an actor taking a step and producing the required observation; external environment responsiveness. | **Partial.** Extend the runtime model only after the guard/productivity contract is explicit. The general coinductive theorem belongs in Lean. |
| Graded exponential, usage scaling, effect composition and partial consumption | TLA-09 | Finite usage counters and an abstract scalar budget | Full `𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅`; rule-local `Scale_Usage`; partial domain of `Consume`; effect transformations `φ`/`ψ`; composition via `⊠`; parallel split/join; cancellation and settlement. | **Partial.** Lean for algebraic/coherence laws; TLA for a dynamic accounting protocol once event-to-cost mapping is fixed. |
| `thm:terminaison_lfp` and `thm:terminaison_strates` | TLA-13 | A finite deductive job with delta iteration, saturation, budget refusal and publication | General finite-height premise, monotonicity, stratified negation, relational semi-naive semantics and the correspondence between program domain and finite-height trellis. | **Scenario-only.** Lean for the general fixed-point/termination claims; TLA-13 checks the job lifecycle, not the theorem. |
| Parallel effect action and bounded re-invocation | TLA-08, TLA-09 | Finite branch interleavings and counters | Exact effect law, sequential re-invocation, per-grade context scaling and effect action compatibility. | **Partial.** General algebra in Lean; operational race tests in TLA after the accounting semantics are fixed. |

### 4.2 C3 — sessions, resources and typing boundaries

| Verso obligation | Existing model | What is represented | Remaining obligation | Assessment / method |
|---|---|---|---|---|
| Session endpoint duality and session typing | TLA-01 | A small asynchronous actor/message protocol | General `Send`/`Recv`/`select`/`offer` residual-state behaviour, branching, multiple messages, arbitrary finite protocol sequences and the derivation-level duality. | **Partial.** Lean for duality/typing; expand finite behavioural scenarios only where runtime ambiguity remains. |
| `thm:deadlock_acyclique` and its simulation premise `(Sim)` | TLA-01 | Bounded static dependency graph, derived wait-for graph, deadlock and simulation-gap controls, external waits and timeout cases | Exhaustive treatment of `Guard`, send/consume, residual mailbox/session states, timeout races, actor failure, retries, message duplication/loss assumptions and arbitrary topology. The finite bound is not the general proof. | **Partial.** TLC is useful for counterexamples; Lean must establish the general graph simulation and theorem. |
| `thm:sync_motifs_jonction` | TLA-02 | Two channels, finite messages, key/type compatibility, atomic selected-pair consumption and partial-consume negative control | Full admissibility predicate over types, payloads, patterns and guards; multiple competing patterns; exhaustive combinations; stable selection semantics; handler-failure semantics; preservation of all unselected messages. | **Partial.** The specification itself leaves the matching predicate and full consumption rule open (G2). Do not ratify rank ordering as normative merely because the model uses it. |
| Graded resource modes, subtyping, `ReadCap`/`WriteCap` and capacity rules | TLA-07, TLA-09 | Finite capability ownership, write ranges, revocation and scalar resource use | Shared readers, exclusive writer discipline (SWMR), fractional read permissions, split/merge, borrow lifetime, overlapping ranges, capability capture across layers, grade-indexed derivations and proof of H1/H2/H3. | **Partial.** Lean for type/grade laws; TLA for dynamic capability-transfer and revocation protocols. |
| Pure handlers and journal inputs | TLA-04, TLA-11 | Abstract journal, snapshot/replay and paired low-observation traces | Full purity/effect boundary, complete capture of nondeterministic inputs, definition of observational equivalence and stratified trace projection. | **Partial.** Lean for functional and logical-relations claims; TLA for lifecycle and trace-protocol counterexamples. |

### 4.3 C4 — actor, memory and system obligations

#### Actor scale and memory representation

The C4 actor/memory chapters define more than a generic capability cell model. They distinguish private actor state, `EntityRef`, ECS/SoA/PIA arenas, region scope, offset provenance, disjoint write segments, 64-byte alignment, NUMA placement, representation profiles and a zero-copy data path involving Arrow, Cap'n Proto and MLIR.

| Specification obligation | Existing model | Remaining gap | Assessment |
|---|---|---|---|
| `EntityRef` remains bound to the same entity across destroy, slot reuse, restore and generation reset/exhaustion | TLA-07 | TLA-07 has a finite slot/generation abstraction and wrap/stale-access controls, but does not prove an unbounded generation protocol or cover actor reincarnation, concurrent references and all restoration paths. | **Partial.** Extend TLA-07's lifecycle protocol; Lean for type-level identity claims; target tests for concrete encodings. |
| Region/arena ownership and disjoint write ranges | TLA-07 | Logical cells/ranges and owners are represented; physical non-overlap is not. | **Partial / open refinement.** The no-diagonal and `WriteCap` arguments (H1/H2/H3) are principally Lean obligations. |
| `ReadCap` sharing with no concurrent `WriteCap`; full SWMR permission discipline | TLA-07 only partially | Current model centres on owners/write ranges; it does not fully model multiple concurrent shared readers, permission splitting/merging or borrow closure. | **Missing extension.** Candidate extension to TLA-07, not necessarily a new model. |
| SoA/PIA layout, offset provenance, 64-byte alignment and NUMA placement | No adequate model | No model maps logical regions to physical segments, NUMA nodes or cache-line ownership. | **Open representation refinement.** A finite placement/allocator model can test allocation protocols; actual layout and placement require compiler/runtime validation and target evidence. |
| Seven memory levels | TLA-07 and TLA-06 touch selected levels | See the level-by-level matrix below. | **Partial.** The seven levels should not be represented as one undifferentiated heap model. |
| Arrow/Cap'n Proto/MLIR layout correspondence and zero-copy transfer | No adequate model | No explicit schema/version/field-elision/alignment/endianness transfer protocol is represented. | **Open target-profile refinement.** Prefer proof of layout correspondence, generated ABI tests and cross-version tests; TLA only for stateful transfer/revocation protocols. |
| Canonical hash-consing, immutable graph sharing and orphan purge | No adequate model | Collision filtering followed by exact structural equality, concurrent insertion/deduplication and safe purge/rotation are not modelled. | **Missing if this runtime mechanism is implemented.** A bounded canonical-store lifecycle model is justified; BLAKE3 collision resistance itself is not a TLA property. |

**Seven memory levels and present coverage**

| Level in `C4/MemoryModels` | Specified mechanism | Current TLA coverage | Conclusion |
|---|---|---|---|
| 1 | Tagged pointers for scalar representation | None | Primarily representation/compiler proof and tests; no general TLA protocol is apparent. |
| 2 | Stack allocation for non-escaping local bindings | None | Static lifetime/escape and typing proof; tests for compiler lowering. |
| 3 | Scoped regions and grade-bounded temporary arenas | TLA-07 logical regions/cells | Partial: region close, outstanding borrow, escape and reclamation races need explicit lifecycle transitions. |
| 4 | Heap ownership with linear/affine transfer | TLA-07 ownership transfer | Partial: no complete destroy/reclaim protocol or integration with outstanding references and asynchronous use. |
| 5 | Canonical deduplication of immutable graphs (hash-consing) | None | Concurrent insert/equality/purge protocol missing if canonical-store operations are concurrent. Hash security is not proved by TLC. |
| 6 | Linear contiguous arenas for SoA ECS | TLA-07 write-range abstraction | Partial: physical placement, alignments, NUMA and layout-to-range correspondence are not modelled. |
| 7 | Linear WAT memory for raw FFI/DMA | TLA-06 plus historical D01 boundary model | Partial: no physical DMA in flight, pinning, device ownership or concrete ABI/translation invalidation. |

The spatial-safety theorem `thm:surete_spatiale` is conditional on three distinct premises: H1 (unique linear introduction of a write capability per region), H2 (disjoint ranges denote disjoint regions) and H3 (linear capabilities cannot be captured by cartesian values). A transition-system model can explore violations of a chosen runtime realisation; it cannot replace the derivation-level proofs of these premises. The specification itself leaves the arena-elimination case and parts of H1 open. Do not describe TLA-07 as proving the spatial-safety theorem.

#### System lifecycle, communication, queueing and FFI

| Specification obligation | Existing model(s) | Present coverage | Missing state/property |
|---|---|---|---|
| Actor active/inactive lifecycle, journal, snapshot and replay | TLA-04 | Mailbox events, journal prefix, snapshot cursor, restore/replay and early-publication control | Atomic snapshot persistence is assumed; no torn writes, flush/barrier order, partial journal persistence, crash during compaction, recovery selection or durable outbox/inbox. |
| Complete logical replay, `thm:determinisme_rejeu` | TLA-04 | Abstract snapshot/replay consistency | Completeness of journal inputs, time/randomness capture, handler purity contract and observational equivalence remain assumptions/open definitions. |
| Binary-identical replay, `thm:rejeu_binaire` | None | The TLA suite does not model executable representation identity | Requires profile Π, E_repro, H_repr, identical toolchain/architecture/rounding and representation proof; use reproducible builds and bitwise differential tests. |
| Actor initialization and dependency DAG, `thm:liberte_initialisation` | TLA-01, TLA-03 partly | Static/dynamic dependency relation and scheduler progress are touched | Initializer classes, initialization side effects, actor creation and failure, and the distinction between topological order and actual progress. Acyclicity alone does not prove initializer termination or scheduling progress. |
| Global pool progress and actor/fibre scheduling | TLA-03 | Two-fibre scheduler with explicit weak fairness and starvation control | Multi-core run queues, preemption, interrupts, work stealing, priority inversion, bounded activations, continuous enabledness, global-vs-per-actor progress, memory fairness and environment delivery. |
| Join patterns and mailbox atomicity | TLA-02, TLA-16 | Abstract pairwise join and an abstract SPSC queue | Complete admissible patterns, several matching messages, contention across patterns, bounded-ring full/empty behaviour, backpressure and concrete queue refinement. |
| Channel transport and mailbox semantics | TLA-01, TLA-02, TLA-16 | Bounded reliable message lifecycle and a two-slot atomic ring | Loss/duplication/reordering, message ownership across process boundaries, queue overflow, retransmission, and transport-specific failure. Which of these are in scope must be fixed by the profile. |
| FFI call-time capability transfer | TLA-06, historical D01 | Logical authority transfer and protected-state integrity scenario | Full foreign-call state machine: pointer provenance, retained aliases, callbacks, reentrancy, exceptions/unwind, thread affinity, timeout/crash and asynchronous work. |
| Post-return FFI revocation | TLA-06 | Logical revocation/acknowledgement and stale-alias control | The model does not establish physical alias invalidation or prove that DMA/callback work already in flight has quiesced. This is explicitly a separate representation-level requirement in Verso. |
| Cancellation versus commit | TLA-05, historical R9 | Bounded request/ack/commit race, timeout and unsafe post-ack commit control | Idempotency, lost acknowledgements, commit durability, compensation/transaction semantics and coupling to actor restart/journal recovery. Keep R9 and TLA-05 aligned through an explicit relation or retire one duplicate oracle. |
| CRDT replication | TLA-15 | Two-replica grow-only set under connected/reliable/fair assumptions; overwrite-merge control | It is conditional, not a general CRDT or delivery protocol. No arbitrary merge lattice, durable delivery, partition recovery, membership/epoch, causal metadata or external-effect reconciliation. |
| Drivers, devices and OS boundary | None adequate | DMA is only mentioned at the abstract memory/FFI boundary | Device ownership, hot-plug, reset, interrupt routing, in-flight I/O, driver replacement and device-domain revocation need a target OS/device profile. |

#### Operational semantics and process-calculus correspondence

| Verso obligation | Existing model(s) | Present coverage | Residual gap / correct method |
|---|---|---|---|
| `thm:preservation` | TLA-01..13 cover selected traces | Some runtime states/invariants only | Preservation is a general typing theorem over every reduction rule. Lean must prove it. Maintain a reduction-rule-to-proof/test/model inventory; TLC is a counterexample tool, not a substitute for the induction. |
| `thm:progres` and global pool progress | TLA-03, TLA-08 | Scheduler and finite fork/join progress cases | Full terminal forms, all enabled reductions, waiting/guard states, productivity versus fairness, and pool-level progress. Lean for the general theorem; TLA for explicit scheduler/environment counterexamples. |
| `thm:correction_ressource` | TLA-09 | Scalar counter and aggregate integer budget | Normative counter is per binding and per multi-set member; usage/grade dimensions and effect/parallel composition are not fully represented. Extend after the counter's event mapping and units are fixed. |
| `at`, `wait`, `when`, `delay`, `tick` and cost/time separation | TLA-10; TLA-03 and TLA-12 adjacent | Logical wait ticks, event trigger, execution-cost accounting; frame counter | Missing level-indexed time vector, per-event tick trace, interaction with suspension/scheduling, deadlines/timeout race, `at` and `delay` case coverage, and proof that environmental waiting is not charged as execution work for every constructor. |
| `thm:stratification_journal` and level-indexed observations | TLA-11 | Paired executions and low-value observation equality | Does not include timing, event count, scheduling, cache/resource contention, termination, declassification or an attacker observation model. Need explicit event/time-channel projection and security assumptions. General non-interference remains a Lean/logical-relations obligation. |
| Partial-order trace and causal preservation | TLA-08, TLA-11, TLA-12 | Small branch DAG, predecessor relations, event and low-trace abstractions | No complete mapping from source trace τ to target events, no proof of causal-order preservation for all constructors, no trace projection/composition theorem. |
| `thm:traduction_metalangage`, `thm:simulation`, `thm:fidelite_interprete` | No adequate TLA correspondence model | The existing independent modules share vocabulary only | Critical gap: no typed relation `R_cfg` between complete K7PL source configurations and target process-calculus configurations, no rule-by-rule simulation, no stuttering/step correspondence, no event/time/channel preservation argument. Lean is the primary proof vehicle; a small TLA pair model can test finite trace counterexamples once the relation is defined. |
| Process-calculus constructs (parallel composition, restriction/cuts, fresh channels, session communication, replication) | TLA-01, TLA-02, TLA-08 partly | Small actor graph, joins, fork/join and partial order | Not a complete operational model of the source constructors or translated process algebra. Do not claim full C4 process-calculus coverage. |
| Metalanguage sorts and time channels | TLA-10, TLA-11 | Some level/time distinction | No end-to-end validation that translated channels are correctly sorted, free effect/time names are preserved, and each per-level time trace follows the source order. Lean for sorting/translation; TLA for bounded interactions. |

### 4.4 C5, C6 and C7

**C5 — syntax and practice.** Tokenization, numeric/string escapes, delimiter balancing, layer restrictions, trains, macro expansion/hygiene, typed holes and elaboration are static reader/compiler concerns. They should be covered by grammar analyses, parser conformance tests, property-based/fuzz tests and Lean theorems about elaboration. They do not justify TLA models merely because a parser has internal states. A TLA model becomes relevant only for an asynchronous editor or language-service protocol (requests, cancellation, stale results, versioned buffers), not for the syntax itself.

**C6 — compilation and verification.** The phase graph, topological ordering, constraint solving, specialization and monomorphisation budget are static algorithms. Their generic soundness/termination properties belong in Lean and solver/compiler tests. A concurrency model is conditional on an actual concurrent build service with shared incremental caches, cancellation, stale worker results and transactional artifact publication; the current specification does not justify assuming such a service exists.

**C7 — integration cases.**

| Case study | Existing model | Present coverage | Missing obligation |
|---|---|---|---|
| Native reactive architecture | TLA-12 | Ordered events, versions, DOM patch base/target, write capability and abstract frame counter | Bounded queues/backpressure, coalescing/debounce, frame deadline misses, stale asynchronous completions, cancellation, rollback, patch rejection/retry and interactions with scheduler/budget/time. Frame count is not a WCET proof. |
| Interactive development and library | TLA-04, TLA-11 | Snapshot/replay and value-level low-trace projection | Debugger control lifecycle (pause, step, resume, breakpoints, rewind, edit/branch, stale handles), consistency between debugger commands and actor scheduler, and observable replay state. Extend only to the functionality the case study actually commits to. |
| Deductive engine on columnar arenas | TLA-13 | Finite closure, delta iteration, saturation, bounded job budget, cancellation/failure/publication | Full semi-naive relational evaluation, relation schemas/columnar arena ownership, stratified negation, bounded arithmetic, incremental update invalidation, finite-height proof and actor/job scheduling. Lean for fixed-point theorem; TLA for concurrent job lifecycle. |

## 5. Memory and hardware: separate model boundaries

The following three model families should not be collapsed into one large “MMU” model.

### M1 — CPU virtual-memory / MMU protocol

Candidate state: address spaces; page-table entries and mapping generations; map/unmap/protect; per-core TLB entries; ASID/PCID allocation and reuse; shootdown requests; per-core invalidation acknowledgements; context switches; page faults; copy-on-write; outstanding CPU references.

Candidate property: after revocation or remapping, no core may use a stale translation to access a page under its previous owner; physical page reuse waits for all required invalidation acknowledgements and outstanding accesses to quiesce.

**Status:** implementation refinement, not a current normative MMU clause. Requires a named architecture and assumptions about TLB invalidation, page-table visibility, core participation and context-switch behaviour. TLC can explore the protocol under those assumptions, not prove the CPU implements it correctly.

### M2 — IOMMU / device-translation / DMA protocol

Candidate state: device-to-domain ownership; IOVA mappings; IOMMU page-table generations; IOTLB; device ATS caches; PASID where relevant; descriptor queues; pinned pages; DMA requests already submitted; completion/abort; invalidation and completion acknowledgements; device reset/hot-unplug; reassignment to another domain.

Candidate property: after revocation, no stale device translation and no DMA already in flight can access a page after that page is reassigned to another protection domain.

**Status:** implementation refinement. C4 memory level 7 and the VirtIO/FFI discussion motivate investigating this, but do not select IOMMU, ATS, PASID, a device model or a hardware contract. The selected target profile must define which mechanisms exist and what “DMA quiescent” means.

### M3 — Physical-page ownership and reclamation

Candidate state: allocator ownership; pin/unpin; CPU mappings; device mappings; outstanding CPU and DMA references; shared read/write rights; free/retire/reclaim epochs; migration; zero-on-reuse; ABA and generation reuse.

Candidate property: a physical page cannot be reclaimed, reinitialised or assigned to a different domain while any actor, core, device or asynchronous callback retains an effective access path to its previous owner; a new owner cannot observe residual data.

**Status:** the essential bridge between M1 and M2. This is a deeper gap than “add IOMMU”: without M3, both translation models can locally invalidate their caches yet still permit early page reuse. It should own the cross-protocol lifetime invariant.

### M4 — weak-memory and concrete queue refinement

The system-scale specification selects acquire/release semantics for shared memory in a runtime profile, while leaving concrete barriers and hardware profile open. TLA-16 assumes atomic visibility; it does not explore weak-memory executions. Use a layered argument:

1. TLA+ for the abstract producer/consumer, ownership, queue-capacity and lifecycle protocol;
2. a language/ISA-appropriate weak-memory model checker (for example GenMC for supported C/C++ programs, or herd7/litmus tools for architecture-level fragments) for concrete executions;
3. a reviewed refinement/mapping proof from the implementation operations and barriers to the abstract protocol.

Do not describe the first layer as verification of release/acquire on real hardware.

## 6. Cross-model gaps and model-family dependencies

The current models execute as independent transition systems in a common CI step. `MODEL-DEPENDENCIES.md` records conceptual interfaces but does not define a composition relation. The following overlaps need explicit ownership to prevent duplicated or contradictory contracts:

- **R9 versus TLA-05:** both address cancellation/commit. Define which one is the canonical abstract contract and how the other refines it, or merge their state/property inventories. Avoid two independently evolving “exactly-once” assumptions.
- **D01 versus TLA-06:** both touch the foreign boundary. D01 checks protected-state integrity in a finite abstract boundary scenario; TLA-06 models capability transfer/aliases/revocation. Define the shared protected-state and authority mapping.
- **TLA-01 / TLA-02 / TLA-16:** session/message lifecycle, join consumption and concrete mailbox queue are three layers of one protocol. They need an explicit interface relation for message identity, queue ownership, publication, matching and consumption.
- **TLA-03 / TLA-08 / TLA-09 / TLA-10:** scheduler, parallel branches, grade/budget and temporal triggering interact. A common execution step must say when cost is consumed, when a tick is emitted and what counts as continuously enabled.
- **TLA-04 / TLA-05 / TLA-06 / TLA-07:** lifecycle, cancellation, foreign authority and memory reclamation meet at destroy/restart/restore. Outstanding callbacks, DMA and aliases must not survive a permission/lifetime transition silently.
- **TLA-11 / TLA-12 / TLA-13:** security projection, reactive event pipeline and deductive-job publication all produce observations. Their observer and event-label conventions should be aligned.

A composed model is not automatically the next best step: it becomes meaningful only after each interface has a typed state mapping and stable semantics. The primary general bridge for K7PL source-to-target simulation remains a Lean proof over an explicit configuration relation, supported by bounded TLC witnesses.

## 7. Prioritised work register

Priorities here are proposed sequencing, not normative status or owner-ratified roadmap priority.

### P0 — close the core memory/concurrency assurance gap

1. **M3 physical-page ownership/reclamation** — define the single lifecycle invariant for reuse, revocation, outstanding references, zeroing and ABA.
2. **M1 CPU MMU/TLB** — only for a selected architecture/profile; define page mappings, invalidation and shootdown completion.
3. **M2 IOMMU/DMA** — only for a selected device/platform profile; include IOTLB/ATS invalidation and DMA already in flight.
4. **M4 weak-memory refinement** — fix the runtime language, ISA and memory primitives; refine TLA-16 and the shared mailbox protocol.
5. **TLA-07 extension: capability algebra and lifecycle** — `ReadCap`/`WriteCap`, SWMR, borrow/split/merge, entity/region destruction, restore, actor incarnation, stale aliases, reclamation.
6. **Session/join completeness extension to TLA-01/02** — full finite branching and residual protocols, pattern admissibility/guards, competing joins, timeout/message race and declared delivery assumptions.
7. **FFI lifecycle extension to TLA-06/D01** — failures, callbacks, reentrancy, asynchronous completion, pointer/alias ownership and explicit quiescence before return/reuse.

### P1 — establish runtime progress, recovery and observation semantics

8. **Scheduler/progress extension to TLA-03** — multi-core scheduling, continuous enabledness, preemption, priority/work stealing, cancellation safe points, actor initialization and global versus per-actor progress.
9. **Actor supervision/incarnation model** — creation, destroy, restart, supervision policy, late messages and restart loops, tied to `EntityRef` and journal state.
10. **Crash-consistent journal/snapshot extension to TLA-04** — flush order, torn writes, partial snapshots, compaction, inbox/outbox deduplication and crash points.
11. **Full grade/resource protocol extension to TLA-09** — all grade dimensions, cost event mapping, per-binding counters, parallel split/join, cancellation and budget settlement.
12. **Time/observation extension to TLA-10/11** — level-indexed `tick` traces, `at`/`wait`/`when`/`delay`, scheduler/time effects, event-count and termination channels, explicit declassification/observer model.
13. **Composed trace/interface model** — only after G14 and the relevant model interfaces are formally defined; it must check a declared projection/refinement, not merely merge variable names.

### P2 — selected integration services only

14. **Reactive backpressure extension to TLA-12** — activate only if bounded queues, overload, stale async result handling or rollback are part of the intended C7 runtime contract.
15. **Debugger lifecycle model** — pause/step/resume/rewind/breakpoint/edit/branch only if these behaviours are committed by the C7 interactive-development case study.
16. **Deductive engine extension to TLA-13** — model relational delta semantics, stratification, cache invalidation and parallel workers only after their operational contract is fixed; keep generic termination and fixed-point laws in Lean.
17. **Distributed transport/CRDT refinement to TLA-15** — only if K7PL adopts a distributed runtime profile; include partitions, delivery, membership/epochs, durability and external-effect reconciliation.
18. **Device/driver lifecycle** — only for an implemented OS/device boundary: reset, hot-plug, interrupt, in-flight I/O, driver replacement and authority revocation.

Do not assign stable TLA model IDs to these packages until their exact Verso clauses, implementation profile, assumptions, bounds and method selection have been reviewed. Several should extend an existing model rather than create a new independent module.

## 8. Explicit non-TLA proof and evidence obligations

The following obligations should remain visible in the coverage register, but should not be converted into TLA models as a matter of completeness:

- general inductive/coinductive termination and productivity, structural recursion, fixed-point existence/height and monotonicity: Lean;
- static typing, session duality, subtyping, grade algebra/coherence, H1/H2/H3 and capability derivability: Lean;
- full preservation/progress and K7PL rule coverage: Lean induction over the operational semantics;
- source-to-process-calculus translation and simulation: explicit `R_cfg`, rule-by-rule simulation, event/causal/time preservation, stuttering/divergence obligations; Lean is primary;
- parser, grammar, lexical/escape and macro-hygiene properties: parser/grammar tests, property-based tests and Lean;
- compiler correctness, monomorphisation soundness and static phase graph: Lean and compiler tests;
- Arrow/Cap'n Proto/MLIR layout, ABI and bitwise replay: target-profile conformance tests and proof of representation correspondence;
- weak-memory implementation: tool matched to the selected language/ISA plus refinement argument;
- cryptographic collision resistance/authentication and physical hardware guarantees: cryptographic/hardware assurance methods, not finite TLC;
- measured latency/WCET, cache/timing behaviour: target-specific measurement or timing analysis; TLC does not give numerical execution-time guarantees.

## 9. Acceptance criteria for declaring specification coverage mature

Do not declare the TLA programme “covering the specification” until all of the following are true:

1. **Clause inventory:** every stateful/temporal Verso obligation has a stable clause/label, owner, status and method assignment (TLA, Lean, parser/compiler test, implementation refinement or explicitly out of scope).
2. **Transition inventory:** every operational constructor/reduction rule is traced to at least one proof or test obligation; a model name alone is not a mapping.
3. **Model contracts:** each TLA module documents exact state mapping, `Init`, `Next`, invariants, temporal properties, fairness, environment assumptions, constants and finite bounds.
4. **Interface contracts:** D01/R9 and TLA-01..16 overlaps are reconciled; cross-model composition is not inferred from shared vocabulary.
5. **Evidence:** each nominal profile completes TLC; each negative profile reaches the intended invariant violation; actual traces are compared with authored witnesses; exact source/config/tool revisions and logs are retained.
6. **General proof boundary:** all general type/grade/fixed-point/preservation/progress/simulation claims have their own Lean proof obligations; finite TLC is not promoted to an unbounded theorem.
7. **Implementation refinement:** each concrete memory, ABI, queue or device claim names a target profile and carries implementation-level evidence.
8. **Normative governance:** implementation refinements do not become language guarantees unless the corresponding Verso clause is explicitly changed and ratified.

## 10. Source anchors audited

All source references below are pinned to the PR #311 snapshot `f3b33cd34e1da49a4c8c41ca632c586e66715e70` so they cannot silently drift with later edits.

- [C2 — Algebras, coalgebras and fixed points](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C2/AlgebrasCoalgebrasAndFixedPoints.lean)
- [C2 — Adjunctions and enrichment](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C2/AdjunctionsAndEnrichment.lean)
- [C2 — Exponential comonad and fragments](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C2/ExponentialComonadAndFragments.lean)
- [C2 — Six metatheory schemas](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C2/SixMetatheorySchemas.lean)
- [C3 — Graded system](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C3/GradedSystem.lean)
- [C3 — Value constraints and deadlock theorem](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C3/ValueConstraints.lean)
- [C3 — Typing rules](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C3/TypingRules.lean)
- [C4 — Actor scale](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C4/ActorScale.lean)
- [C4 — Memory models](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C4/MemoryModels.lean)
- [C4 — System scale](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C4/SystemScale.lean)
- [C4 — Operational semantics](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C4/OperationalSemantics.lean)
- [C4 — Underlying process calculus](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C4/UnderlyingProcessCalculus.lean)
- [C4 — Metalanguage sort system](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C4/MetalanguageSortSystem.lean)
- [C7 — Native reactive architecture](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C7/CaseStudyINativeReactiveArchitecture.lean)
- [C7 — Interactive development and library](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C7/CaseStudyIIInteractiveDevelopmentAndLibrary.lean)
- [C7 — Deductive engine on columnar arenas](https://github.com/AntheaLiles/k7pl/blob/f3b33cd34e1da49a4c8c41ca632c586e66715e70/spec/Spec/C7/CaseStudyIIIDeductiveEngineOnColumnarArenas.lean)
