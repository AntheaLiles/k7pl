<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL TLA+ work plan

**Status:** TLA-01 is `model-drafted`; TLA-02 through TLA-16 are `not-started`. No TLA-01 TLC result is claimed yet.  
**Priority convention:** P0 = semantic foundation; P1 = runtime assurance; P2 = scenario or optional profile. These priorities are provisional sequencing recommendations.

Each item is an independently reviewable work package. Its model scope is a candidate abstraction, not a ratified definition. Before coding, resolve the relevant gates in [OPEN-GATES.md](OPEN-GATES.md).

## P0 — Semantic foundations

### TLA-01 — Asynchronous session network and deadlock freedom

**Status:** `model-drafted`; the first TLC attempt reached the configuration parser but stopped before module/state exploration. The configuration encoding has been corrected and the rerun is pending.  
**Specification:** C3 `ValueConstraints`, section `sec:c3-les-contraintes-de-valeur`, theorem `thm:deadlock_acyclique`; C4 `ActorScale`, `SystemScale`, `UnderlyingProcessCalculus` and `OperationalSemantics`.

**Normative status and question.** `thm:deadlock_acyclique` is explicitly `under-review` with evidence `proofsketch`. Its premise (Sim) states that if actor `a` waits for a message from `b`, then `(a,b)` belongs to the static dependency graph. C3 leaves the relation between the static and dynamic graphs open and identifies `Guard`, send, consumption, residual mailbox/session states and `Timeout` as cases to cover. C4 describes a compile-time acyclic dependency graph between actor templates. Neither the theorem nor its proof sketch is treated as a checked result here.

**Module:** `TLA01SessionNetwork.tla`.

**Abstraction and state.** The model is a finite one-message session protocol over two or three actors. The static relation `StaticDependencies` is supplied as a finite adjacency function (`[Actors -> SUBSET Actors]`) and materialised as a set of ordered actor pairs in `StaticDependencyEdges`. This avoids tuple literals in TLC `.cfg` assignments while preserving the mathematical graph. The dynamic relation `WaitFor` is derived from actor states and `waitTarget`; it is not copied from the static graph. An edge is oriented `waiter -> expected sender`, matching the pair orientation in (Sim). State variables are:
- `residual`: `Recv`, `Send`, `End` or `Aborted`;
- `actorStatus`: `Runnable`, `Waiting`, `Terminal` or `Failed`;
- `mailboxes`: pending sender/receiver message pairs;
- `waitTarget`: the current expected sender, external producer or `NoActor`;
- `timeoutStatus`: `Disabled`, `Armed` or `Expired`;
- `sent` and `consumed`: message-lifecycle sets.

`StaticHasCycle` is exact for the declared bound of at most three actors (self-, two- and three-node cycles). `StaticAcyclic` checks the compile-time relation. `Simulation` is the candidate invariant `WaitFor \subseteq StaticDependencies`; it is deliberately not assumed by `Init` or by the transition relation.

**Transitions.** `Block` records a wait only when the expected mailbox is empty. `Send` appends a message and returns the sender without waiting for receiver readiness; it wakes a matching blocked receiver. `Consume` removes one compatible message and advances the residual protocol. `ExternalDeliver` represents one explicitly enabled environment delivery. `Timeout` changes a blocked actor to `Failed`/`Aborted`; it does not count as successful protocol termination.

**Properties.** The configurations check `TypeOK`, endpoint duality, static acyclicity where applicable, (Sim), message conservation, mailbox ownership, state consistency and `NoMutualWaitDeadlock`. A raw internal wait cycle is distinct from a deadlock: `MutualWaitDeadlock` checks a cycle after removing edges whose source currently has an enabled timeout action. `ExternalWaiters` and `WaitingOnFailedActor` remain distinguishable from an internal cycle. `AllActorsTerminal` and `AllActorsQuiescent` separate successful termination from a state in which all actors are terminal or failed.

**Configurations and expected checks (rerun pending after a configuration-parser failure):**

| Configuration | Purpose | Expected outcome |
|---|---|---|
| `TLA01-AcyclicNominal.cfg` | Two actors; one asynchronous send and one receive; static edge `B -> A` | All declared invariants hold |
| `TLA01-CircularWait.cfg` | Three dual endpoints, all waiting before sending; static graph is cyclic | TLC finds `NoMutualWaitDeadlock` violation |
| `TLA01-SimulationGap.cfg` | Static graph is a DAG, endpoint duality holds, but the dynamic wait graph is a three-cycle | TLC finds `Simulation` violation |
| `TLA01-ExternalWait.cfg` | A waiter depends on an external producer; an external delivery transition is enabled | No internal wait-cycle deadlock; no delivery fairness is claimed |
| `TLA01-Timeout.cfg` | External wait with timeout enabled and delivery disabled | Timeout failure path is included; this is not a termination guarantee |

The two negative traces are recorded in `TLA01-CircularWait-ExpectedCounterexample.json` and `TLA01-SimulationGap-ExpectedCounterexample.json`. CI must check the name of the expected failed invariant, not merely a non-zero process exit.

**First TLC attempt (CI run 2391).** TLC 1.7.4 was fetched and its pinned digest verified. The nominal profile stopped with a `ConfigFileException` at configuration line 8: the parser expected `}` while reading the set-of-tuples assignment for `StaticDependencies`. This occurred before TLA module parsing and state exploration; it is not an invariant counterexample. The parameter was therefore re-encoded in all five configurations as an adjacency function `[Actors -> SUBSET Actors]`; `StaticDependencyEdges` reconstructs the corresponding ordered-pair relation inside TLA+. The new head's PR run is queued behind the preceding CI run.

**Assumptions and bounds.** Actors are bounded to two or three; each actor receives at most one message and sends at most one message; messages are reliable, not duplicated and represented as a set of sender/receiver pairs. The set mailbox deliberately abstracts away multiplicity and order. Session duality is checked as an invariant over the configured one-step endpoint maps; it is not a full session-typing derivation. Send is asynchronous. Timeouts are nondeterministic actions, not a clock model; no `WF` or `SF` is imposed, so neither timeout occurrence nor eventual delivery is guaranteed. External delivery after a timeout has been omitted. The model omits multiple messages per channel, join patterns, branch selection, actor creation, scheduler interleavings inside a handler, physical queue memory ordering and real-time latency.

**Correspondence obligations.** The candidate abstraction maps K actor/fibre control, mailbox contents and residual protocol information to the TLA+ variables above. It does not yet define a typed relation over complete K configurations or map K's labelled partial-order trace. In particular, a rule-by-rule argument is still required for `Guard`, `Send`, message consumption, residual states and `Timeout`. `wiki/semantics.md` also confirms that the maintained K prototype does not currently represent the normative actor/session semantics. Therefore neither counterexample is yet asserted to be a K7PL execution, and no K/TLA+ or Lean/TLA+ simulation is claimed.

**Dependencies:** none for this bounded draft; TLA-02 and TLA-03 may reuse the mailbox/actor vocabulary only after reviewing its boundaries. G1, G4, G14 and G15 remain open.

### TLA-02 — Join-pattern matching and atomic multi-mailbox consumption

**Specification:** C3 `ValueConstraints` and session types; C4 `SystemScale`, theorem `thm:sync_motifs_jonction`; C4 `UnderlyingProcessCalculus`, construction `J ▷ P`; C4 `OperationalSemantics`, `Guard`.

**Question.** Does a join transition consume exactly one admissible tuple of messages atomically, using the declared deterministic selection policy, and leave every unselected message available?

**Candidate module:** `K7PLJoinPatterns.tla`.

**State to represent:** finite set of mailboxes; message identities, channels, types and payload classes; join-pattern declarations; guards; actor's pending patterns; selected matching tuple; consumed-message set.

**Actions:** enqueue message; enumerate admissible matches; select match according to the specified stable ordering; atomically consume selected messages; execute or publish the resulting handler state.

**Safety properties:**
- a join transition is enabled only when all pattern inputs are present and compatible;
- a selected message is consumed exactly once;
- no message is consumed by two transitions;
- no partial consumption occurs when a full match is absent;
- messages not selected remain pending;
- a declared disjointness property prevents ambiguous selection;
- selection is deterministic for the same mailbox state and pattern definition.

**Liveness question:** can admissible messages remain pending forever because of selection policy or actor scheduling? This is distinct from atomicity and needs explicit fairness assumptions.

**Tools:** TLA+ native sets/functions/actions; TLC required for exhaustive small mailbox/pattern models; Apalache optional for bounded symbolic message populations; Lean for general compatibility of the matching predicate with session types and grades.

**Deliverables:** formal matching predicate; transition relation; positive and negative configurations; explicit witness for absent full match; tests for duplicate, partial and competing matches.

**Dependencies:** TLA-01 mailbox vocabulary; OPEN-GATE G2 (matching semantics).

**Acceptance:** TLC confirms that the atomic action preserves message conservation and at-most-once consumption in the declared finite model. The result must not be described as proving a lock-free physical implementation.

### TLA-03 — Scheduler, fairness and global pool progress

**Specification:** C2 `AlgebrasCoalgebrasAndFixedPoints` (actor and bounded activations); C3 `TermGrammar` (`wait`, `when`, parallel composition); C4 `LocalScale`, `ActorScale`, `SystemScale` (initialisation), `OperationalSemantics` theorem `thm:progres`.

**Question.** Does the scheduler preserve the distinction between local progress, progress of at least one runnable fibre, and eventual service of each continuously enabled actor?

**Candidate module:** `K7PLScheduler.tla`.

**State to represent:** actors and fibres; runnable, running, waiting, suspended and terminated states; ready queue or scheduler eligibility relation; mailbox wakeups; yield points; activation counters; per-turn bound where the specification requires one.

**Actions:** select runnable fibre; execute abstract step; yield; suspend on guard; wake after event; terminate fibre; spawn fibre; advance scheduling turn.

**Safety properties:** terminated fibres never execute; a wakeup does not discard pending work; suspension preserves local state; scheduler selection only chooses eligible fibres; per-turn activation bounds are respected.

**Liveness properties:** a continuously enabled fibre is eventually scheduled under weak fairness; an infinitely often enabled fibre is eventually scheduled only if strong fairness or another explicit assumption is adopted; pool progress requires at least one reducible member, while per-actor progress requires a stronger scheduler contract.

**Tools:** TLA+ native temporal formulas and fairness; TLC required for safety and temporal exploration; Apalache optional for bounded finite scheduler-state checks; Lean for generic local progress and metatheorems.

**Deliverables:** scheduler abstraction, fairness table mapping each action to WF/SF/no fairness, starvation counterexample without the chosen assumption, nominal configurations with and without fairness.

**Dependencies:** TLA-01 actor states; OPEN-GATE G3 (fairness contract).

**Acceptance:** the model demonstrates the difference between global progress and starvation. No fairness condition may be added merely to make TLC pass; its connection to a real scheduler guarantee must be documented.

### TLA-08 — Fork/join, `parallel`, `vmap` and partial-order traces

**Specification:** C2 parallel effect action; C3 `TermGrammar` and `TypingRules`; C4 `OperationalSemantics` reductions for `parallel` and `vmap`; C4 `UnderlyingProcessCalculus`.

**Question.** Do concurrent branches preserve local order and causal dependencies without imposing a false total order on independent events?

**Candidate module:** `K7PLParallelExecution.tla`.

**State to represent:** finite fibres; branch-local state; branch-local event histories; causal predecessor relation; shared abstract memory; fork token; join status; result vector for `vmap`.

**Actions:** fork; take one enabled branch step; emit event; establish a causal edge; terminate branch; join; publish vector result.

**Safety properties:** each branch preserves its own event order; causally dependent events are ordered; independent events remain unordered in the abstract trace; each `vmap` input contributes exactly one corresponding output; a join publishes only after its required branches complete; no branch resource or result is lost or duplicated.

**Tools:** TLA+ native relations, sequences/sets and actions; TLC required to explore interleavings; Apalache optional for bounded branch/vector domains; Lean for the general algebraic/effect and typing-preservation statements.

**Deliverables:** partial-order trace representation; at least two independent-branch interleavings; a negative model that incorrectly imposes a total order; finite `vmap` test configurations.

**Dependencies:** TLA-03 scheduler; TLA-07 resource semantics where shared capabilities are involved.

**Acceptance:** all explored interleavings preserve causal order and result cardinality. The representation must not use append order from TLC as if it were the normative global trace order.

### TLA-11 — Trace stratification and observational non-interference

**Specification:** C2 restriction/erasure schemas; C3 `TypingRules` level projection; C4 `OperationalSemantics`, theorem `thm:stratification_journal`; C4 `MetalanguageSortSystem`; C7 interactive replay case.

**Question.** Can an observer at level ℓ distinguish two executions that agree on public initial state and public inputs but differ in higher-level state or events?

**Candidate module:** `K7PLTraceNoninterference.tla`.

**Method:** self-composition: represent two runs in a single model, synchronise public inputs and compare the observations visible at a chosen level.

**State to represent:** paired actor states; public and secret inputs; level-labelled events; causal order; complete trace; projected trace; observer-visible state and output.

**Safety properties:** high events are absent from the low projection; the two low observations remain equal; high events do not alter low-visible control, event count, order or timing where the property claims timing independence; the projected replay has enough information for the permitted low observation and no more.

**Tools:** TLA+ native self-composition; TLC required for bounded finite paired executions and counterexamples; Apalache optional for bounded symbolic runs; Lean for general non-interference and logical-relations proofs; PRISM only if a probabilistic leakage property is explicitly specified.

**Deliverables:** observation function; projection operator; synchronisation relation; positive and negative paired runs; separate tests for value, control-flow, event-order and timing leakage.

**Dependencies:** TLA-04 journal abstraction; TLA-08 partial-order traces; OPEN-GATE G8 (observer and timing semantics).

**Acceptance:** the model finds a counterexample when a high event changes a low-visible branch or timing observation; the positive model passes only under explicit non-interference assumptions. A projection that merely filters events is insufficient if hidden events influence later public behaviour.

## P1 — Runtime and resource assurance

### TLA-04 — Actor lifecycle, snapshots, journal and replay

**Specification:** C3 pure handlers and journal; C4 `SystemScale` actor lifecycle, `thm:determinisme_rejeu`, `thm:rejeu_binaire`; C7 case study II.

**Question.** Do deactivation, snapshot, restore and replay preserve a coherent observable actor state across every interruption point?

**Candidate module:** `K7PLActorLifecycle.tla`.

**State:** actor lifecycle phase; logical state; snapshot identifier/content abstraction; journal entries and cursor; pending mailbox messages; replay cursor; external capability results; failure point.

**Actions:** process message; append event; append capability result; freeze; persist snapshot; publish snapshot reference; release volatile memory; restore snapshot; replay journal prefix; resume actor; crash at a selected boundary.

**Safety properties:** no message is silently lost or processed twice; snapshot and journal refer to a consistent history prefix; partial restore is not externally published; replay does not resurrect revoked capabilities; each external nondeterministic result needed by replay is represented in the journal.

**Tools:** TLA+ native; TLC required for finite crash-point exploration; Apalache optional for bounded symbolic histories; Lean for pure-handler replay equivalence.

**Deliverables:** lifecycle protocol; crash matrix; journal-completeness assumptions; positive/negative configurations; expected traces for inconsistent snapshot/log pairs.

**Dependencies:** TLA-01 mailbox model; TLA-05 cancellation semantics; TLA-06 capability revocation; OPEN-GATE G4 (journal completeness).

**Acceptance:** every interruption point in the finite protocol leads either to a valid old state, a valid recoverable state or a specified refusal; no partial state is exposed. The model must explicitly distinguish logical replay from crash-consistent persistence and from bitwise reproducibility.

### TLA-05 — Cancellation, commit and failure paths

**Specification:** C4 `SystemScale` failure, cancellation, recovery and restoration paths; K7OS research model R9.

**Existing starting point:** `models/R9ActorCancellation.tla`. It distinguishes cancel request from acknowledgement and has a negative property `NoCommitAfterCancelRequest` that is intentionally too strong.

**Question.** What is the commit/cancellation linearisation point, and what does an acknowledgement promise?

**Candidate module:** either refine R9 in place as a clearly labelled K7PL profile model or create `K7PLCancellation.tla`. Do not silently convert K7OS assumptions into normative semantics.

**State:** caller state; service state; request state; cancel request/ack flags; effect-commit count; retries and idempotency key; timeout; budget; trace.

**Actions:** send; accept; request cancellation; acknowledge cancellation; interrupt pending/accepted work; commit effect; timeout; retry; recover.

**Safety properties:** an effect commits at most once; acknowledged cancellation implies no commit under the chosen contract; committed work cannot transition to cancelled; duplicate requests do not repeat a non-idempotent external effect; timeout is not silently treated as acknowledgement.

**Tools:** TLA+ native; TLC required for race exploration and negative witnesses; Apalache optional for more finite requests/services.

**Deliverables:** transition contract; race table; nominal and negative configs; stable counterexample vector; decision on retry/idempotency semantics.

**Dependencies:** TLA-04 lifecycle; TLA-06 boundary; OPEN-GATE G5 (cancellation and commit semantics).

**Acceptance:** the model exhibits both legitimate race winners where allowed, but never violates the chosen post-acknowledgement guarantee. Preserve the intentionally too-strong claim as a negative control if it continues to illustrate the distinction.

### TLA-06 — FFI transfer, foreign aliases and revocation

**Specification:** C4 `SystemScale` foreign-interface contract, `thm:surete_ffi`, `thm:revocation_ffi`; C4 `MemoryModels`; existing D01 native-boundary model.

**Question.** What does transfer of a capability mean during a call, and what protocol ensures that the foreign component cannot use the transferred access after revocation?

**Candidate module:** `K7PLForeignBoundary.tla`.

**State:** protected region; owner; gateway; foreign component; capability status; possible aliases; call phase; result/error/timeout; revocation status; pending accesses.

**Actions:** transfer capability; call foreign function; attempt allowed access; attempt forbidden access; return; fail; timeout; revoke; acknowledge revocation; attempt stale access.

**Safety properties:** the caller cannot use a transferred exclusive capability during the call; no unlisted authority is gained; after acknowledged revocation no new access is accepted; error and return paths preserve protected state; stale or replayed access attempts do not mutate the region.

**Tools:** TLA+ native; TLC required for call/return/revocation interleavings; Apalache optional for finite alias/region domains.

**Deliverables:** expanded D01 profile; explicit alias assumptions; return/error/timeout paths; expected counterexample when the boundary is not enforced.

**Dependencies:** TLA-07 capability model; OPEN-GATE G6 (meaning of revocation).

**Acceptance:** nominal enforced profile preserves integrity; a deliberately unconfined profile yields a counterexample; no claim is made that an abstract revocation protocol proves hardware or OS-level alias invalidation.

### TLA-07 — Capabilities, regions and entity lifetime

**Specification:** C3 `GradedSystem`; C4 `ActorScale` (arenas, regions, partitioned ranges, EntityRef); C4 `MemoryModels`; C2 capacity lemma.

**Question.** Do allocation, transfer, revocation, deletion, slot reuse and restore preserve capability ownership and entity identity?

**Candidate module:** `K7PLMemoryCapabilities.tla`.

**State:** finite regions and segments; range ownership; read/write capabilities; entity slots and generations; active/dead status; fibre ownership; outstanding references; restore epoch.

**Actions:** allocate; split range; transfer capability; read/write; free; destroy entity; reuse slot; increment/reset generation; restore snapshot; revoke capability.

**Safety properties:** incompatible write rights do not overlap; an old EntityRef never aliases a new occupant of the same slot; freed memory cannot be accessed by stale capabilities; restored state does not revive revoked rights; access remains within the capability's region/range.

**Tools:** TLA+ native; TLC required for small finite regions, entities and generations; Apalache useful for bounded arithmetic/range constraints; Lean for universal interval, typing and capability proofs.

**Deliverables:** capability state model; slot-reuse counterexample if generation checks are removed; explicit bounds and overflow abstraction; separation of abstract permissions from physical address layout.

**Dependencies:** TLA-06 and TLA-08; OPEN-GATE G7 (lifetime/revocation semantics).

**Acceptance:** all reachable finite states preserve the declared ownership and identity invariants; the model includes wraparound/reset cases or states why they are outside the abstraction. Small generation widths are counterexample devices, not proof about production-width counters.

### TLA-09 — Dynamic resource accounting and budget consumption

**Specification:** C2 `ExponentialComonadAndFragments` (budget interface and partial `Consume`); C3 `GradedSystem`, `TypingRules`; C4 `OperationalSemantics`, theorem `thm:correction_ressource`.

**Question.** Does a bounded execution account for each effective use and cost without exceeding its declared grade/budget?

**Candidate module:** `K7PLResourceAccounting.tla`.

**State:** bindings; declared usage grade; per-fibre use counters; ownership/sharing map; budget remaining; operation cost; effect; thread-local and aggregate usage.

**Actions:** introduce binding; use binding; copy/share where permitted; abandon; transfer; compose sequential/parallel contexts; consume budget; reject unaffordable operation; remove binding.

**Safety properties:** effective use does not exceed grade in the bounded model; linear resource use is at most one; affine resources may be unused but not duplicated; shared-resource counts are aggregated without double counting; remaining budget never becomes negative; `Consume` only occurs under admissibility; usage scaling does not silently scale budget.

**Tools:** TLA+ native; TLC required for small finite grades, counters and budgets; Apalache useful for bounded symbolic arithmetic; Lean remains primary for the general resource-correction theorem and algebraic coherence.

**Deliverables:** instrumented transition model; variable-creation/removal rules; sequential/parallel accounting examples; overuse negative cases; comparison table between static grade, operational count and abstract cost.

**Dependencies:** TLA-08 for fibres; OPEN-GATE G9 (meaning and unit of dynamic budget).

**Acceptance:** no counterexample within explicitly stated finite bounds and all overuse scenarios are rejected. This is not a proof that the operational count is a CPU-cycle count or wall-clock bound.

### TLA-10 — Temporal triggers, waiting, deadlines and budget separation

**Specification:** C3 `TermGrammar` and `TypingRules` (`at`, `wait`, `when`, `delay`); C4 `OperationalSemantics`; C4 `UnderlyingProcessCalculus` simulation contract; C7 case study I.

**Question.** Does the model keep environmental waiting latency separate from the cost of the triggered automaton, as required by decision P3-B?

**Candidate module:** `K7PLTemporalScheduling.tla`.

**State:** discrete logical clock/tick; waiting computation; trigger predicate; environment event; timeout; activation state; execution cost and remaining budget; deadline/frame marker.

**Actions:** register wait; receive external event; enable trigger; activate automaton; execute transition; advance logical tick; expire timeout; cancel wait.

**Safety properties:** `when` activates only when its predicate is met; environmental waiting is not charged as execution cost of the triggered automaton; execution transitions consume their own declared costs; timeout follows its own declared contract and is not implicitly cancellation acknowledgement; suspended work is not lost.

**Tools:** TLA+ native discrete state/time representation; TLC required for bounded waits, events and deadlines; Apalache optional for bounded numerical domains. PRISM is only relevant if a probabilistic/quantitative timing claim is later specified. Physical latency requires measurement and a target-specific timing argument.

**Deliverables:** discrete-time abstraction contract; separate counters for wait and execution; timeout cases; proof-obligation links to P3-B and trace simulation.

**Dependencies:** TLA-03 scheduler; TLA-09 budgets; OPEN-GATE G10 (time model and units).

**Acceptance:** the model verifies that environmental waiting does not decrement the execution-cost budget under the declared rule and shows counterexamples if wait and execution counters are conflated. It must not claim a physical deadline guarantee.

## P2 — Scenarios and optional profiles

### TLA-12 — Native reactive pipeline and frame lifecycle

**Specification:** C7 `CaseStudyINativeReactiveArchitecture`; C3 `GradedSystem` capability `WriteCap(DOM)`; C4 actors and event processing.

**Candidate module:** `K7PLReactivePipeline.tla`.

**State/actions:** external events; FRP stream position; logical UI state; previous/current X-expression; diff result; patch batch; DOM version; exclusive writer; frame index; frame completion or overrun.

**Properties:** only the holder of `WriteCap(DOM)` applies patches; each patch batch applies at most once and to its intended base version; incomplete batches are not published; events are not silently reordered/lost; layer-2 state does not directly mutate the DOM.

**Tools:** TLA+ native and TLC for event/patch races. Frame ticks may be modelled abstractly. Benchmarks and target-specific WCET analysis are required for real latency.

**Acceptance:** protocol safety passes in a finite model; frame-overrun behaviour is explicit. No performance claim follows from TLC.

**Dependencies:** TLA-03, TLA-08 and TLA-09.

### TLA-13 — Deductive-engine job lifecycle

**Specification:** C2 fixed points and monotonicity; C4 `SystemScale` and operational semantics; C7 `CaseStudyIIIDeductiveEngineOnColumnarArenas`.

**Candidate module:** `K7PLDeductiveJob.tla`.

**State/actions:** finite graph input; known facts; delta/new facts; current iteration; budget in number of turns; actor/job state; cancellation/failure; publication state.

**Properties:** final result is published only after saturation; already known facts are not repeatedly counted as new; monotone updates remain monotone; cancellation never publishes a partial result as complete; budget exhaustion produces a specified refusal; resume does not publish an obsolete relation.

**Tools:** TLA+ native and TLC for small graph/job protocols; Apalache optional for bounded graph domains; Lean proves generic monotone fixed-point existence, height and termination.

**Acceptance:** job lifecycle preserves completeness markers and publication conditions. The model is not a substitute for the generic fixed-point theorem or performance measurements.

**Dependencies:** TLA-03, TLA-04, TLA-09.

### TLA-14 — Noise session protocol (conditional)

**Specification:** C4 `LocalScale` protocol example and C3 session types.

**Candidate module:** `K7PLNoiseSession.tla`, or a profile of TLA-01 if the vocabulary is shared.

**Scope:** finite abstract handshake/state machine, message types, permitted transitions, failure and closure. Do not model cryptographic primitive correctness unless a separate cryptographic formalisation is selected.

**Properties:** no message is accepted in the wrong state; required negotiation steps cannot be skipped; closed sessions cannot be reused as open sessions; failures do not leave an apparently valid session.

**Tools:** TLA+ native and TLC. Cryptographic properties require other methods.

**Gate:** only start if Noise is an adopted K7PL integration/library profile. Its mention as an example does not make it a normative language obligation.

### TLA-15 — Replicated state and eventual convergence (conditional)

**Specification:** C4 `SystemScale` CRDT/partition discussion; C3 asynchronous messages; C4 journal and actor recovery.

**Candidate module:** `K7PLReplicaConvergence.tla`.

**State/actions:** finite replicas; local state; updates; network partitions; queued/delayed/duplicated messages; delivery; merge; recovery.

**Properties:** merge satisfies the selected CRDT laws; replicas that receive the same updates converge; an update is not counted as delivered before receipt; eventual convergence holds only under explicit eventual-delivery and recovery assumptions; retries do not contradict the selected idempotency contract.

**Tools:** TLA+ native; TLC for small replica and partition scenarios; Apalache for selected bounded symbolic variants; Lean for general algebraic merge laws.

**Gate:** conditional on an actual distributed profile and declared network assumptions. The type CRDT does not itself guarantee delivery.

### TLA-16 — SPSC queues and weak-memory refinement (external implementation verification)

**Specification:** C4 `SystemScale` SPSC queues, release/acquire publication/consumption and mailbox representation; C4 `ActorScale` memory partitioning; C4 `thm:sync_motifs_jonction`.

**Question.** Does the chosen queue implementation refine the abstract mailbox protocol under the actual language and hardware memory model?

**Abstract module:** `K7PLSPSCQueue.tla` for producer/consumer protocol, bounded slots, publication, consumption and reuse.

**Properties:** no message loss or duplication; a slot is not overwritten before permitted reuse; consumer does not observe unpublished payload; producer/consumer indices remain within the declared bounded relation; progress claims state the required assumptions.

**Tools:** TLA+ native and TLC for abstract protocol. If the concrete implementation is C/C++, GenMC is a candidate for checking program behaviours under supported weak-memory models. GenMC is not a TLA+ extension. If the runtime uses another language, select a tool matching that implementation's memory model.

**Deliverables:** abstract queue model; concrete implementation profile; mapping relation; GenMC or equivalent tests where applicable; refinement and memory-order argument.

**Acceptance:** the abstract protocol passes TLC; concrete results are separately reported; the implementation/model mapping is reviewed. TLC alone cannot prove that hardware release/acquire barriers are sufficient.

**Dependencies:** TLA-02 and TLA-08; OPEN-GATE G11 (runtime language, memory model and target).

## 3. Cross-cutting deliverables for every item

Every model work package must include:
- a stable model identifier and explicit normative section references;
- a statement of what is specified, assumed, abstracted and omitted;
- finite constants/bounds and a justification for each;
- `TypeOK`, `Init`, `Next` and `Spec` (or equivalent clearly documented decomposition);
- safety invariants, temporal properties and fairness assumptions separated;
- a nominal configuration and at least one negative/control configuration where appropriate;
- TLC/Apalache tool version, exact command, configuration and archived output;
- expected counterexample or witness for the negative case;
- links to related K modules, Lean declarations and tests, without inferring correspondence from matching names;
- a list of remaining proof, implementation and measurement obligations.

## 4. Completion vocabulary

A work item may be:
- **model-drafted** — model text exists and has been reviewed for scope;
- **model-checked-bounded** — named finite configurations have been checked;
- **counterexample-found** — a reproducible counterexample has been retained;
- **correspondence-open** — no proved relation to K/Lean yet;
- **correspondence-proved** — the declared correspondence theorem is checked;
- **completed-with-scope-limit** — its acceptance criteria are met, with limitations retained.

No item is complete merely because TLC returns success.
