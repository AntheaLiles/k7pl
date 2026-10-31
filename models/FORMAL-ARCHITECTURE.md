<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Formal architecture: K, TLA+, model checkers and Lean

## 1. The division of responsibility

The formalisms have different jobs. They must not become competing definitions of the same semantics.

| Component | Authoritative responsibility | Output |
|---|---|---|
| Normative K7PL specification (Verso) | States the language commitments and their epistemic status | Normative definitions, rules and theorem statements |
| K Framework | Executable operational semantics for the represented K7PL subset | Configurations and rewrite transitions |
| TLA+ | Abstract global state machines, asynchronous protocols, interleavings, safety and temporal assumptions | Transition-system models and properties |
| TLC | Explicit-state exploration of finite TLA+ models | Reachable-state results, invariant violations, deadlocks and temporal counterexamples |
| Apalache | Symbolic/bounded analysis of supported TLA+ constructs | SMT-backed bounded checks and counterexamples |
| Lean | General mathematical properties and checked correspondence theorems | Proof terms checked by Lean |
| Runtime tests | Behaviour of a concrete implementation under selected scenarios | Reproducible test results and regression vectors |
| Assurance register | Links claims, abstractions, models, proofs, implementation and test evidence | Typed traceability record |

K must remain the executable semantics source for the constructs it defines. TLA+ is not a substitute for K and must not silently become a second normative operational semantics. TLA+ can abstract away details irrelevant to a global protocol property, but every omission must be declared.

Lean remains the preferred place for general theorems about typing, grades, resource algebra, fixed points, preservation and simulation. TLC is particularly useful where finite-state exploration and counterexample generation can falsify a model or an assumption.

## 2. Three different kinds of result

These statements are not interchangeable:

1. **TLC result:** all states/behaviours explored under a specific finite model, constants, configuration and assumptions satisfy a property.
2. **Lean theorem:** the proposition represented by the Lean statement has a proof accepted by the Lean kernel, subject to its axioms and dependencies.
3. **Conformance result:** a demonstrated relation connects the normative semantics, formal model and concrete implementation.

A test or model checker can find counterexamples. It cannot establish that the transition system omitted no behaviour of the implementation. A Lean theorem can be mathematically valid but irrelevant to K7PL if its relation to the normative statement has not been justified.

## 3. Abstracting a K configuration

The current C4 operational semantics describes a concurrent configuration using a pool of fibres, arena state, mailboxes and a labelled partial-order event trace. The exact tuple and component names must be revalidated against the current specification before a model is implemented.

A candidate abstraction function is:

`alpha : KConfiguration -> TLAState`

For the concurrent C4 model, its projection should account for:

- process/fibre pool and each local control state;
- actor identity and actor-local state where relevant;
- abstract arena/region ownership needed by the selected property;
- mailbox contents and residual session states;
- capabilities and resource ownership needed by the selected property;
- event labels and causal order;
- scheduler state and environment inputs only where the work item requires them.

Do not automatically copy every K configuration component into every TLA+ model. Use the smallest state that preserves the property under examination, then state what is abstracted away.

## 4. Forward simulation contract

For a model that claims to represent a K execution, define a relation:

`R_cfg(KState, TLAState)`

The expected forward-simulation shape is:

`R_cfg(c, s) / c ->K c'`

implies that there exists `s'` such that:

`s ->TLA* s' / R_cfg(c', s')`

The star permits target stuttering when the abstraction has a coarser step granularity. Whether zero target steps are permitted for a particular source step must be decided by the semantic contract; do not permit stuttering indiscriminately.

The relation must specify at least:

1. the correspondence between source terms/processes and target control state;
2. the mapping of arena or region state required by the property;
3. the mapping of channels, mailboxes and messages;
4. the mapping of source events to target events;
5. preservation of per-fibre order and causal order;
6. treatment of independent concurrent events and structural equivalence;
7. treatment of environment, failure, timeout and scheduler transitions;
8. the observation function for the property being transferred.

A forward simulation does not establish bisimulation, full abstraction or equivalence of all behaviours. It may be sufficient to transfer selected safety properties in one direction, subject to the exact relation and property mapping. Liveness transfer requires additional conditions: fairness correspondence, progress assumptions, and prevention of infinite stuttering/divergence in the target.

The C4 `thm:simulation` remains an open proof sketch with missing clauses and a source/target configuration relation. TLA-01, TLA-02 and TLA-08 should not be described as solving that theorem until the mapping is explicit and proved.

## 5. K ↔ TLA+ ↔ Lean: staged evidence

Use this sequence for each model family:

1. **Extract the normative question.** Identify the exact section, theorem/requirement label, status and scope.
2. **Define the abstract transition system.** State variables, initial states, actions, invariants, temporal properties and assumptions.
3. **Check the model.** Run TLC or Apalache on explicit configurations; retain counterexamples and bounds.
4. **Relate the TLA+ state to K.** Define a typed projection or relation; specify which K transitions are represented.
5. **Relate the property to Lean.** Either prove a general abstract result in Lean or prove a refinement/correspondence theorem.
6. **Confront the implementation.** Add test vectors or a stateful harness if an implementation exists.
7. **Update assurance.** Record evidence status and residual gaps without promoting the model-check result to a theorem.

The proof direction should be selected property by property. For example, a K-to-TLA forward simulation might support transfer of a source safety invariant to target states only if the abstraction relation and invariant mapping are correct. A TLA+ counterexample is a useful falsification candidate, but it must be projected back to K and checked for feasibility before being reported as a K7PL counterexample.

## 6. Typed traceability relations

The assurance register should use explicit relation types rather than matching names or file proximity. Suggested relation vocabulary:

| Relation | Meaning |
|---|---|
| `specifies` | A normative statement defines the commitment |
| `models` | A TLA+ model represents a stated abstraction of the commitment |
| `abstracts` | A projection maps a richer state into a model state |
| `implements` | An implementation realises an identified component |
| `proves` | A checked theorem establishes a proposition |
| `model-checks` | A named tool/configuration checked a model property |
| `tests` | A test exercises an implementation or model scenario |
| `refutes` | A reproducible counterexample falsifies a claim or abstraction |
| `measures` | An experiment measures a quantity on a named profile |
| `refines` | A proof relation connects a concrete model to an abstract model |

Each edge should carry provenance: source commit, path/label, tool version, model revision, configuration, assumptions, result and scope. The relation itself must be reviewed; a typed edge is not automatically a proof.

Suggested record fields:
- stable claim or requirement ID;
- normative source path and label;
- source commit SHA;
- model path and module;
- property name;
- tool and exact version;
- configuration and finite bounds;
- assumptions and fairness constraints;
- result status;
- expected/actual counterexample reference;
- K source rule mapping;
- Lean theorem mapping;
- implementation/test mapping;
- residual obligations.

## 7. Model decomposition

Avoid a single global `K7PL.tla`. Use specialised models with shared, reviewed vocabulary:

- **Protocol and concurrency:** sessions, actor pool, mailbox, joins, scheduler and partial-order events.
- **Lifecycle and boundaries:** snapshot/replay, cancellation, FFI transfer and revocation.
- **Resources and observation:** capabilities, usage accounting, budgets, temporal waits and non-interference.
- **Scenarios:** reactive pipeline, deductive job, and optional integration profiles.

Share definitions only after the first use cases stabilise. An early universal metamodel risks encoding design decisions that the K semantics and normative specification have not yet settled.

## 8. Safety, liveness and fairness

Every model must distinguish:

- safety: something bad never happens;
- deadlock freedom: no reachable state is a prohibited global wait;
- local progress: an individual computation can take a step;
- global progress: some member of a pool can take a step;
- starvation freedom: a continuously or repeatedly enabled member is eventually scheduled under explicit assumptions;
- termination: all maximal executions meet a declared terminal condition;
- real-time deadline: a physical or abstract bound is met under a declared timing model.

A local progress theorem does not establish scheduler fairness. An acyclic dependency graph does not by itself establish message delivery or absence of starvation. A productivity theorem for a stream does not prove a frame deadline. These distinctions must be retained in both models and reports.
