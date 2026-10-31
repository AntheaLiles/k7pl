<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# TLA+ toolchain and CI plan

## 1. Terminology

TLA+ is the specification language. TLC, Apalache and TLAPS are tools with different verification methods; they are not interchangeable language extensions.

| Name | Category | Intended use in K7PL | Important limit |
|---|---|---|---|
| TLA+ | Specification language | States, actions, transition relations, invariants and temporal properties | A specification is not checked until a tool runs it |
| SANY | TLA+ parser/analyser | Parse and analyse modules and imports | Syntax acceptance does not establish semantic correctness |
| TLC | Explicit-state model checker | Reachable-state exploration, invariants, deadlocks and temporal properties over configured finite models | Exhaustive only for the supplied model and finite configuration |
| Apalache | Symbolic/bounded model checker using SMT | Bounded symbolic exploration and supported invariant checks | Supported TLA+ subset and bound/mode must be recorded |
| TLAPS | TLA+ proof system | Mechanised deductive proofs, especially invariants | Not a substitute for TLC temporal/liveness exploration |
| PlusCal | Algorithmic notation translated to TLA+ | Optional notation for procedural protocols or schedulers | Additional source notation; no independent proof engine |
| PRISM | Probabilistic model checker | Conditional: quantitative probabilistic availability, latency or leakage models | Different probabilistic model and assumptions |
| GenMC | C/C++ concurrent-program model checker | Conditional: concrete weak-memory implementation of queues or atomics | Does not verify the abstract TLA+ model |

Primary documentation:
- TLA+ tools: https://lamport.azurewebsites.net/tla/tools.html
- TLA+ tools repository and CLI usage: https://github.com/tlaplus/tlaplus
- Apalache documentation: https://apalache-mc.org/docs/
- TLAPS repository/documentation: https://github.com/tlaplus/tlapm
- PRISM: https://www.prismmodelchecker.org/
- GenMC: https://github.com/MPI-SWS/genmc

## 2. Default tool choice

Start with TLA+ native notation and TLC.

For each model:
1. Parse and check module dependencies.
2. Declare finite constants and model bounds.
3. Run TLC for `TypeOK`, safety invariants, deadlock checks and temporal properties where appropriate.
4. Preserve the complete counterexample when a property fails.
5. Add Apalache only when symbolic encoding or bounded exploration adds value over explicit-state TLC.
6. Use TLAPS only for a distinct deductive obligation that is valuable in TLA+; do not duplicate the Lean proof effort without a reason.
7. Use external verification tools only for concrete profiles (probabilities, weak-memory program behaviour, etc.).

PlusCal is optional. It should not be introduced merely to make models look procedural. Choose it only if it materially improves reviewability of an algorithm-style protocol, and retain the generated TLA+ relationship in the evidence.

## 3. Tool-specific limits

### TLA+ native

A discrete logical clock can be represented as an ordinary state variable, tick action or bounded counter. A finite-state model can express waits, timeouts, frame numbers and deadlines abstractly.

TLA+ does not measure milliseconds, processor cycles or WCET. A result about a discrete deadline is only as meaningful as the mapping between ticks and the target execution profile.

### TLC

TLC is the default explicit-state checker. A successful run must record:
- exact TLA+ source revision;
- every imported module and tool version;
- every `.cfg` and its constants;
- invariants and temporal properties checked;
- workers and relevant CLI flags;
- state count, transition count and completion status;
- counterexample traces or proof of expected negative result;
- any symmetry, view or state-constraint reduction that changes the explored space.

Finite exploration is not a proof for unbounded actor counts, mailbox sizes, integer domains or event histories unless an additional theorem justifies that transfer.

### Apalache

Use Apalache for bounded symbolic analysis where SMT constraints on data and transitions are useful. Record:
- Apalache version;
- solver and solver version;
- supported language subset used;
- bound/length/depth;
- check mode and options;
- counterexample or successful bounded result.

Do not describe “no counterexample up to k steps” as proof for arbitrary execution lengths. Do not assume every TLC-supported construct has identical Apalache support.

### TLAPS

Use TLAPS only where a deductive proof in TLA+ serves a clear purpose. It may be useful for parameterised invariants or to establish model-level lemmas that are otherwise cumbersome. It is not the primary tool for temporal liveness; TLC remains the initial tool for those properties. Lean is already the project's main proof assistant and should remain primary for language-wide mathematical theorems.

### PRISM

Only introduce PRISM if K7PL adopts a precise probabilistic property: a probability distribution, observation model, adversary, time horizon and measurable outcome. It is not justified merely because a system has randomness or latency. Keep non-probabilistic TLA+ safety models independent from any probabilistic extension.

### GenMC

GenMC is a candidate only if the relevant concrete implementation is C/C++ and the selected memory constructs are within its supported model. It can explore behaviours of the concrete concurrent program under weak-memory assumptions. It does not prove that the K7PL abstract mailbox or join semantics is correctly implemented; that requires an explicit abstraction/refinement argument. If K7PL's runtime language changes, reconsider the concrete verification tool.

## 4. Existing repository baseline

At the source baseline used for this plan:
- the D01 native-boundary TLA+ model and configurations are under `models/`;
- the R9 cancellation model and configurations are also under `models/`;
- `.github/workflows/k7pl-semantics.yaml` downloads TLC 1.7.4 and verifies SHA-256 and SHA-1 before running D01;
- the D01 job checks an enforced profile and requires a counterexample for an unconfined negative profile;
- the workflow retains model sources, configurations, tool identity and TLC logs as CI artefacts;
- R9 is checked by the `r9-tlc` job in `.github/workflows/ci.yaml`;
- TLA-01 is checked in the same `r9-tlc` job: three nominal/environment profiles and two negative configurations whose expected invariant names are checked;
- TLA-02..16 are checked in that job as one candidate suite: nominal profiles, targeted negative controls and temporal properties where declared;
- the TLA-01 artifact retains its own model/configuration/vector/log set; `tla-models-evidence` retains all TLA-02..16 modules, configurations, authored counterexample expectations, logs, Java identity and the pinned TLC JAR digest;
- `wiki/semantics.md` explicitly says that K, Lean and TLA+ results are corroborating models and that the K ↔ TLA+ projection remains open.

The K7OS model files now reside beside the K7PL programme documents directly in repository-root `models/`. Their contents and CI properties are preserved; only file paths and workflow working directories changed. Their research status remains non-normative.

## 5. Proposed CI tiers

| Tier | Trigger | Checks | Evidence |
|---|---|---|---|
| TLA parse | Any `.tla` or `.cfg` change | SANY/parser and import resolution | Parser/tool version, module list, output |
| TLA model check | Model or configuration change | TLC invariants, deadlocks and temporal properties | Sources, configs, logs, state counts, traces, hashes |
| TLA extended | Selected models or manual/full workflow | Apalache; TLAPS only when a proof is registered | Exact tool versions, solver, bounds or proof output |
| Formal-chain packaging | Model/proof/source changes | Package TLA, K sources, Lean source and matching evidence | Commit-matched archive with provenance |
| Concrete refinement | Runtime implementation changes | Model-specific tests and external concurrency checker where relevant | Runtime revision, platform profile, test traces |

Do not make every PR run every expensive analysis. Use a source-impact map, but ensure that shared modules trigger all dependent models and that manual/full execution remains available.

## 6. Evidence and reproducibility contract

For each CI run preserve:
- source commit SHA and repository revision;
- model module and imported modules;
- configuration file(s);
- constants, bounds and state constraints;
- exact tool binaries/version and verified digest where feasible;
- command line;
- exit code and log;
- properties checked and their declarations;
- number of states/transitions and whether exploration completed;
- counterexample trace, if any;
- negative-control expectation and whether it was reproduced.

The artefact must not be called a proof unless the verification method is a proof method and the statement's assumptions are explicit. Use “TLC model check passed for configuration X” rather than “K7PL property proved”.

## 7. CI rollout

1. Preserve the existing D01 and R9 checks while moving their working directory to repository-root `models/`.
2. TLA-01 is now parsed and checked through the existing `r9-tlc` job when `tla_model_check` is selected; a separate syntax-only tier is deferred.
3. TLA-02..16 candidate modules and finite profiles are now present and routed through the same TLC suite; their runs remain pending. The TLA-02 selection policy is exploratory only, and G2 is not ratified.
4. TLA-03 fairness applies only in its explicit fair profile; it is not a normative scheduler guarantee. TLA-14/15 remain conditional, and TLA-16 remains an atomic abstract queue.
5. Model-selection/artifact coverage is grouped by the TLA workstream directory; any model/config/vector change triggers the suite. A future shared imported module must also trigger every dependent model.
6. Add Apalache only after a representative model demonstrates a concrete need.
7. Add cross-formalism evidence only after an explicit K/TLA or Lean/TLA relation exists.

The relocation changes paths and working directories only; it does not add properties, alter TLC versions or change the epistemic status of existing results.
