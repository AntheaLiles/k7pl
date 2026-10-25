<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R2 — Source-to-Binary Correctness and Zero-Overhead Assurance

**Assessment date:** 2026-10-23  
**Audited snapshot:** `AntheaLiles/k7pl@4aea67661b049161689acb2163cfa1ebed1b5d5`  
**Status:** Non-normative research report. End-to-end compiler correctness and universal zero-performance-loss are not established.

## 1. Question and intended result

R2 asks which proofs connect K7PL's normative semantics to the machine code that actually executes.

K7PL's correctness target is not only “the result has the expected value”. Its source semantics also describes mutable arena state and an effect trace. The language is intended to combine usage grades, capabilities, session channels, effect operations, termination/productivity checks, budgets and memory rules. Compiler assurance must preserve these interacting properties as code moves through elaboration, optimisation, MLIR/LLVM lowering, linking and the runtime boundary.

The intended goal has two parts: accepted code should not be able to perform actions excluded by the specified model, and formal assurance should not require unnecessary run-time checks or slower generated code. The second part must be formulated as a testable contract rather than inferred from successful proofs.

For this report, “zero trade-off” is split into four claims:

- **Proof erasure:** proof-only terms and static metadata do not survive into the executable unless the language explicitly gives them run-time meaning.
- **No added instrumentation for static facts:** properties already established for a program do not acquire additional run-time guards solely to repeat the same checks.
- **Cost-contract preservation:** the generated code respects the source's resource guarantees under a declared target model.
- **Performance non-regression:** for a fixed target, toolchain baseline, benchmark set and metric, validated output performs no worse than the declared baseline.

The first two can be pursued through proof erasure, compile-time verification and validation of the actual generated code. The third needs a cost relation in addition to functional semantics. The fourth needs a specified comparator and empirical evidence; it does not follow from extensional compiler correctness alone. This dossier does not claim universal optimality or zero overhead for every program on every processor.

## 2. Current evidence in K7PL

### 2.1 C4 operational semantics

The current [C4 operational semantics](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/SemantiqueOperationnelle.lean) describes a configuration containing a computation, an arena state, and an effect trace, written conceptually as `⟨c, μ, τ⟩`. Pure steps preserve the arena and trace; effectful operations may change the arena and append events. The semantics also distinguishes sequential event order from the partial order needed under concurrency.

The associated [C-07 simulation audit](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/docs/migration/C-07-SIMULATION-AUDIT.md) identifies gaps in the source-to-target simulation contract. In particular, a relation connecting source arena state to target state is missing, the mapping from target events to the source trace is not fully defined, the target structural equivalence needs an exact contract, and the proof must control extra target steps.

This is a blocking assurance gap. A proof that compares only translated terms does not establish that memory state, capability state, effects, communication, failures or cost bounds are preserved.

The current simulation proposal is directional: each source step is to correspond to one or more target steps, with named administrative steps permitted. It does not by itself establish bisimulation, full abstraction, or a two-way correspondence between every source and target behaviour.

### 2.2 EffectiveKernel and the K → Lean experiment

[EffectiveKernel.lean](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C3/EffectiveKernel.lean) is a compiled Lean representation of part of the C3 core. Its own module documentation says it does not implement the complete context composition, budget consumption or effect transformation; rules absent from the fragment remain unformalised.

The current [CodeArtifacts.lean](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/CodeArtifacts.lean) defines a deliberately small K subset: integer and Boolean literals, addition, comparison and a conditional. Its `typeOf` is a partial classifier for those constructs, not the full K7PL typing judgment.

[MachineSoundness.lean](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/proofs/K7PL/MachineSoundness.lean) proves a continuation typing invariant for generated KLean rewrite constructors in that subset. It explicitly states that KLean does not export the K equations for `typeOf` as rewrite constructors and consequently does not claim equivalence between that K classifier and Lean's `HasType` judgment. A proof for one example is useful regression evidence, not a universal simulation theorem.

[ADR-0012](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/docs/decisions/0012-k-as-normative-home-of-c3-c4.md) records the decision that K becomes the normative home of the C3/C4 grammar and semantics, with Lean proofs on generated types. The same record says the complete C3/C4 rewrite in K and relocation of the proofs onto the generated full-language types have not started; the K definition remains limited to the small subset.

The current experiment is therefore a useful starting point, not a completed source of truth for the whole language. The project must not maintain separate normative and executable semantics while simply assuming that they agree.

### 2.3 C6 compilation design

The current [C6 compilation pipeline](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C6/LeProcessusDeCompilation.lean) proposes checks for usage, types, effects, termination/productivity and constraints, followed by optimisation and lowering toward MLIR and LLVM. Its text leaves the exact decidable SMT fragment open and marks premises of pipeline stabilisation as obligations.

The [solve-output section](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C6/CeQueLeSolveurRetourne.lean) distinguishes reproducible abstract compile-time resource usage from elapsed time, and asks cross-package obligations to carry certificates. That is a useful assurance design, but the stated certificate requirement must not be confused with proof that every current phase emits and checks the required certificate.

## 3. What semantic preservation must cover

### 3.1 Source and target configurations

The compiler needs a relation between complete source and target configurations. A minimum source model should account for:

- current computation and control state;
- logical arena and region state, including permitted memory access;
- capabilities and effective rights;
- session-channel endpoints and protocol states;
- observable effects and message trace, with an explicit concurrency ordering relation;
- grades and budgets relevant to accepted executions;
- termination/productivity status and pending external operations when these affect observations.

The target state needs to identify the corresponding machine state: registers, stack, concrete memory/arena layout, continuations, capability representation, scheduler state, external mappings and pending operations. A source concept need not map one-to-one to a machine object, but the relation must define how its semantic role is represented or observed.

This is a proposed checklist, not a completed K7PL configuration definition. R1's authority questions and R5's memory/aliasing questions must eventually be joined to C4's operational state.

### 3.2 Required compiler theorem

Let (S) be the source semantics, (T) the target semantics, (C) the compiler translation, and (R) a relation between source and target configurations. The baseline theorem needs the following parts:

1. **Initial-state correspondence.** The initial target state represents the same source program, arguments, initial memory, capabilities and environmental assumptions.
2. **Step simulation.** Each source step has a matching target execution reaching a related state. Any extra administrative steps are named and have specified observations.
3. **Observation preservation.** Values, effects, message events, error classes and externally visible actions correspond under a defined projection. Independent concurrent events may use a specified partial-order equivalence rather than an accidental total order.
4. **State correspondence.** The target memory, handles and authority state continue to represent the related source state after each transition.
5. **Termination and failure correspondence.** The statement specifies successful termination, divergence, suspension, blocked communication, errors and budget exhaustion. A defined source failure must not become an unintended successful effect or privileged action.
6. **Composition.** If each pipeline stage preserves its stated relation, the composed pipeline gets a derived preservation result, including each change of representation.

A safety theorem transfers from source to binary only if the theorem is stated over observations and states preserved by this relation, and its platform assumptions remain true. Passing tests is not a substitute for this theorem.

### 3.3 Cost is a separate semantic dimension

Functional correctness does not automatically preserve cost. K7PL makes cost and resource bounds part of its design, so three levels must be kept distinct:

- **Functional and effect semantics:** which values, state changes and visible events are permitted.
- **Abstract resource semantics:** work, depth, memory, effect grades and budgets named by the language.
- **Machine cost semantics:** instructions, memory accesses, cache and memory-model effects, interrupts, device latency and scheduler interference for a particular target.

The compiler should prove that source resource bounds imply the target bounds actually claimed for a declared platform profile. An abstract work bound is not, by itself, a machine-independent worst-case execution-time theorem.

Cost preservation also need not mean equality. Optimisation should reduce work while remaining within the language's contract. The formal relation must state whether the target cost is equal to, bounded by, or refines the source allowance. A source budget cannot be silently treated as a processor-cycle estimate.

## 4. End-to-end pipeline and its proof boundaries

<escape>
Normative grammar and operational semantics
                    |
                    v
Parsing, elaboration, and canonical typed/graded program
                    |
                    v
Checked facts: grades, capabilities, effects, channels,
memory regions, termination/productivity, and budgets
                    |
                    v
High-level K7PL IR
                    |
                    v
Optimisation passes with proof or translation validation
                    |
                    v
K7PL MLIR dialects → generic MLIR → LLVM IR
                    |
                    v
Target assembly/object code → linking → runtime/privileged support
                    |
                    v
Executable + proof/validation manifest + platform profile
</escape>

Every arrow is an assurance boundary with a defined source language, target language, semantic relation, assumptions and checking method. Runtime, FFI, privileged support, linker/loader, boot and hardware are not outside the reasoning merely because they sit after code generation.

### 4.1 Grammar and elaboration

The front end needs correspondence with the authoritative syntax and must preserve binding, substitution, evaluation order, signatures, grades, effects, session interpretation and source locations used in proof provenance. It must not smuggle semantics in through parser recovery or defaults that are absent from the specification.

Useful checks include:
- a formal relation between the grammar and elaborated canonical terms;
- binder and substitution properties;
- specified and reproducible elaboration choices;
- explicit rejection of unsupported or under-defined constructs;
- exact ABI and target assumptions for foreign declarations.

Tests can expose parser disagreement but cannot alone establish correspondence over the whole language. A formal elaborator relation or a small checker of a canonical representation is the stronger target.

### 4.2 Grades and other strategies in the canonical IR

K7PL's strategies must remain complementary in the model. Usage grades, memory capabilities, session channels, effect traces, termination/productivity evidence and budgets all constrain the accepted program. If optimisation erases a representation of these facts, the assurance path must retain enough proof evidence to justify that erasure.

External SMT results need a supported certificate format and a small trusted checker, or the solver and its interface remain within the trusted computing base. An unverified textual `unsat` answer is not itself a proof object.

### 4.3 Optimisation passes

For each transformation, prove correctness for the pass algorithm or validate the particular input/output pair. This applies to inlining, loop fusion, deforestation, defunctionalisation, dead-code elimination, scalar replacement, vectorisation, memory-layout changes and specialisation.

Record each pass's:
- input/output dialects and semantics;
- preconditions on grades, effects, termination, aliasing and capability lifetimes;
- preservation relation, including whether it permits silent steps;
- treatment of messages, failures, budgets and state;
- checkable proof or validation result tied to the exact input/output and tool version;
- response to UNKNOWN, timeout, unsupported operations or a counterexample.

C6 already notes that optimisation may generate grade constraints that require another constraint-solving cycle. The implementation needs a terminating loop with a decreasing measure. The current statement marks its operational premises as obligations rather than established facts.

### 4.4 MLIR conversion

MLIR's [official Dialect Conversion documentation](https://mlir.llvm.org/docs/DialectConversion/) explains legality, type conversion, rewrite patterns and full versus partial conversion. These facilities help establish legal IR and consistent types; they do not automatically prove that a user-supplied conversion preserves semantics.

Each K7PL dialect needs an exact semantics or checkable translation contract. Lowering actor, session, effect, memory and state-machine operations to generic control flow or memory primitives is a sensitive boundary: type correctness alone does not establish that communication order, authority, failure behaviour or cost contracts survive.

Research has proposed translation validation frameworks for MLIR-based compilers, including SMT checks of target refinement. This is an avenue for evaluation, not a guarantee supplied generically by MLIR. Applicability depends on the exact dialects, aliasing model, concurrency semantics and cost properties K7PL needs. See [A Systematic Translation Validation Framework for MLIR-Based Compilers](https://doi.org/10.1142/S021819402450030X).

### 4.5 LLVM and machine code

LLVM IR has its own treatment of undefined and poison values. The K7PL-to-LLVM contract must preserve K7PL's defined outcomes for integer overflow, memory access, floating-point behaviour, atomics, effects and errors. Undefined behaviour cannot be used as an accidental implementation of a K7PL operation with a defined result.

[Alive2](https://github.com/AliveToolkit/alive2) provides automatic SMT-based translation validation for LLVM optimisations. Its documentation warns that inter-procedural transformations are unsupported and can produce spurious counterexamples. Its PLDI 2021 paper describes bounded validation: limits on loop unrolling and resource use allow checks to terminate, but some bugs can be missed outside the supported bound. Alive2 is therefore a candidate for supported LLVM transformations, not a proof of the full K7PL compiler, all MLIR lowering, linking, runtime behaviour or all concurrency properties.

If optimised LLVM is retained, the validation result must be bound to the exact input, output and toolchain settings. UNKNOWN or unsupported operations must not count as success. The compiler must reject that candidate, use another proof route, or fall back to a validated result.

### 4.6 Assembly, linking, runtime and boot

A correct LLVM module does not by itself establish the final executable after assembly, linking, loading, FFI calls and start-up. The TCB register must include:
- assembler and linker semantics, or checked object/link results;
- calling conventions, register and stack rules, relocation and data layout;
- generated runtime routines and intrinsics;
- allocation, scheduler, interrupt handling, memory mappings, FFI adapters and handwritten privileged code;
- boot and initial platform configuration;
- external libraries and code loaded during execution.

Each component must be proved against a contract, independently confined, or explicitly trusted under declared assumptions. The goal is not that every component must be written in K7PL; the goal is an auditable chain from language properties to their concrete enforcement.

## 5. Comparison with established approaches

### 5.1 CompCert

CompCert proves semantic preservation for its defined C language fragment and compiler pipeline. Its documentation states that observable behaviours of generated code must be permitted by the source semantics and documents which compilation stages fall within the theorem. See [CompCert motivations](https://compcert.org/motivations.html) and its [compiler-correctness theorem](https://compcert.org/doc/html/compcert.driver.Compiler.html).

**Value for K7PL:** compositional pass proofs and a precise final preservation claim.

**Limit:** the source language and property set differ. CompCert's performance documents report code around 90% of GCC `-O1` performance on specified ARM benchmarks, showing that a verified compiler does not automatically match every competing optimiser. This does not prove that verification must slow generated code; it shows that proof and optimisation quality are distinct objectives. See [CompCert performance documentation](https://compcert.org/compcert-C.html).

### 5.2 CakeML

CakeML defines semantics and develops a compiler in HOL4. Its project describes a verified backend that produces machine code for several target architectures. See the [CakeML project](https://cakeml.org/) and [source repository](https://github.com/CakeML/cakeml).

**Value:** a concrete precedent for verified machine-code generation and bootstrap assurance.

**Limit:** it does not provide K7PL's grade, channel, authority, memory, effect and OS semantics. The proof architecture can inform K7PL, but its theorem is not directly reusable as a K7PL theorem.

### 5.3 Cogent

Cogent co-generates low-level C and proofs from a high-level functional language, in a systems-code programme built around seL4. See the [Cogent project](https://trustworthy.systems/projects/OLD/cogent/).

**Value:** a small verified vertical slice for a system service can offer meaningful assurance before a whole compiler is covered.

**Limit:** it does not cover the full K7PL source language, K7PL-specific MLIR passes or a complete K7PL OS.

### 5.4 Verve

Verve combined typed assembly language checking and Hoare-style verification to establish safety for its nucleus, kernel, runtime, drivers and applications, with the boot loader excluded from the reported verification scope. See Yang and Hawblitzel, [“Safe to the Last Instruction” (PLDI 2010)](https://www.microsoft.com/en-us/research/publication/safe-to-the-last-instruction-automated-verification-of-a-type-safe-operating-system/).

**Value:** low-level and privileged code needs a machine-facing proof boundary.

**Limit:** its architecture and theorem set differ from K7PL's intended properties. The boot-loader scope limit also illustrates why every excluded component must be named.

### 5.5 Translation validation

Translation validation checks whether a particular transformation preserves the chosen semantics, rather than proving the transformer algorithm for all possible inputs. This allows an optimiser to produce its normal output and moves validation to compile time.

**Value:** the most direct path to retaining the output of a high-performance optimiser when validation succeeds.

**Limit:** a bounded or incomplete validator may be unable to validate a correct optimisation. The compiler must reject it, use another proof path, or fall back. Every pass and IR operation must be covered by the validator's semantics. A checked IR is not a checked executable if later code generation, linking, FFI or runtime stages are outside the relation.

## 6. Making the zero-overhead goal testable

### 6.1 Run-time cost versus verification cost

The proof checker can consume compile-time CPU and memory yet leave emitted machine instructions unchanged. That is not run-time overhead, though it matters because K7PL also asks for bounded and reproducible compilation.

The main strategy is:
- discharge static type, usage, effect, channel, termination/productivity, memory and budget obligations before code generation wherever possible;
- erase proof objects and ghost metadata;
- retain evidence needed to justify optimisations and erasure;
- validate actual optimised outputs during compilation;
- insert run-time checks only when a fact depends on dynamic/external state and cannot be established statically or enforced by selected hardware;
- where a check is required, measure it and determine whether the regular operation or hardware can enforce the property without extra instructions.

This does not assume every property is statically decidable. External devices, native code and changing resource pools may require mediated interfaces or hardware enforcement. The design must distinguish those cases rather than claim that proof erasure alone protects an external boundary.

### 6.2 Proposed performance levels

Fix a target profile (P), a compiler baseline (B), benchmark domain (D), and metric (M).

| Level | Candidate claim | Evidence | Limit |
|---|---|---|---|
| **Z0 — proof erasure** | Proof-only artefacts add no executable state or instructions | Erasure theorem and IR/object comparison | Does not establish optimal code |
| **Z1 — instrumentation neutrality** | Static facts do not receive redundant run-time guards | Compare exact output against the same uninstrumented pipeline; verify binary identity when intended | Validation may reject a result it cannot prove |
| **Z2 — cost-contract preservation** | Output meets the declared resource/time contract for (P) | Cost simulation plus target-specific analysis | Abstract work is not automatically processor WCET |
| **Z3 — baseline non-regression** | Output is no slower than (B) for (D) under (M) | Reproducible benchmark process and fixed toolchain | Evidence is scoped to (D) and (P), absent a matching general theorem |
| **Z4 — universal optimality** | No admitted program is slower than the best possible output on every target | A precise universal comparator and theorem | Not established by current K7PL artefacts or the compared tools |

Z0–Z2 are the principal formal goals. Z3 is necessary empirical evidence for practical non-regression. Z4 should not be claimed as achieved. An empirical result and a machine-cost theorem answer different questions and should be reported separately.

### 6.3 Why validate the optimiser's actual output?

Instead of limiting optimisation to transformations that are easy to prove once for all inputs, allow the ordinary optimiser to emit its preferred candidate and validate that exact transformation at compile time. On success, its code can remain unchanged, so the validator adds no run-time instructions.

Three limits remain: an incomplete validator may reject a correct candidate; a fallback path can produce slower code; and the validator may lack semantics for a pass or operation. Those cases must be logged and measured. The validation tool, semantic model and certificate checker are part of the assurance argument.

## 7. Smallest useful vertical slice

The present five-constructor K subset is a useful starting point, but too small to represent K7PL's complete assurance objective. Extend it by semantic risk.

### V0 — exact semantics chain for a small expression fragment

Use literals, addition, comparison and conditional expressions. Define the source configuration and observations, ensure K and generated Lean structures come from the designated canonical source, and prove evaluation simulation and type preservation for every rule. Define overflow and error semantics for the admitted operations. Include the executable boundary only when a declared target actually emits a binary.

**Exit condition:** every source/target rule of this fragment has a proof or checked relation, and the theorem states exactly where it ends.

### V1 — memory and shared regions

Add allocation, bounded region access, read/write and region closure. Relate source regions and capabilities to target locations or protected handles. Prove that admitted operations preserve memory/authority invariants under sequential and parallel composition, including stale references and error paths.

**Exit condition:** the relation covers concrete representation and states whether protection relies on K7PL-only code or a specific hardware/kernel boundary.

### V2 — effects and session channels

Add an effect operation, capability transfer and a send/receive protocol. Map source events to machine/runtime events and prove preservation of event order, authority and failure observations. Define silent target steps and show they do not add observable effects.

**Exit condition:** a trace simulation works for the fragment, including the chosen partial-order equivalence for independent concurrent events.

### V3 — budgets and termination/productivity

Add a bounded loop/catamorphism and an effectful timed operation. Prove the structural termination/productivity result, preserve abstract resource constraints through lowering, and define the target cost model needed for any real-time conclusion.

**Exit condition:** the target bound follows from formal premises under a fixed platform profile; benchmarks corroborate it but do not replace the proof.

### V4 — one validated optimisation at a time

Start with a local rewrite such as constant folding; continue to inlining, loop transformation and alias-sensitive memory optimisation. Tie each validation result to exact input/output artefacts.

**Exit condition:** every emitted optimised module has a checked result; UNKNOWN and unsupported cases are never treated as successful. Record if the output is byte-identical to the chosen baseline output.

## 8. TCB and assurance matrix

| Boundary | Required property | Candidate strategy | Main residual assumptions |
|---|---|---|---|
| Grammar → parser/elaborator | Elaboration matches canonical semantics | Formal relation, checked canonical IR, regression corpus | Encoding, source locations, implicit defaults |
| Judgements → accepted IR | Grades/effects/channels/capabilities satisfy the rules | Proof-producing checker or checked certificates | Checker soundness, solver certificates, complete rules |
| Termination/productivity → IR | Structural condition is justified | Proof over canonical semantics | Effectful recursion, environment waiting, concurrency |
| Memory/authority → IR | Capabilities and regions are not forged or misused | Linear/graded proof plus explicit region/lifetime model | Relation to FFI, runtime and concrete references |
| IR → optimised IR | Pass preserves observations and cost contract | Pass proof or sound translation validation | Aliasing, effect order, unsupported operations, UNKNOWN |
| K7PL dialect → MLIR | Lowering preserves state/effect semantics | Per-dialect semantics and translation theorem/validator | Unmodelled ops, conversions, concurrency |
| MLIR → LLVM IR | Target refines source | Checked lowering and validation | LLVM undefined/poison semantics, atomics, unsupported passes |
| LLVM IR → machine code | Machine behaviour follows target semantics | Verified backend or checked code-generation relation | ISA model, assembler code, floating point and overflow |
| Object files → linked image | ABI, symbols and relocation preserve the contract | Checked object/link stages and provenance | Linker scripts, runtime libraries, LTO |
| Runtime/FFI/privileged code | Components preserve declared contracts | Formal component contracts and concrete enforcement | Native code, callbacks, drivers, DMA |
| Boot/platform | Initial image and machine model meet assumptions | Image verification and explicit platform profile | Firmware, mappings, interrupts, hardware trust |
| Proof/validation tools | Only checked evidence is accepted | Small trusted checker, pinned tools, manifests | Checker, theorem prover kernel and supply chain |

A small trusted computing base is desirable, but it must not be hidden. If a theorem depends on Lean's kernel, a certificate checker, hardware primitives, linker or bootloader, those dependencies must be declared.

## 9. Tests and reproducible performance evidence

### 9.1 Differential testing

Compare the source model, K execution, Lean model, MLIR interpreter where available, and final executable on the same generated corpus. Include edge values, conditional branches, effects, aliasing, invalid capability use and failure paths. Compare full observations, not only stdout: termination, error class, message order, memory-state projections, resource traces and budget events.

Tests can find disagreement but cannot decide which engine is authoritative. The canonical semantics and proved relations determine that.

### 9.2 Compilation manifest

Each build should record the source digest and model version; front-end, solver, optimiser, MLIR, LLVM, assembler, linker, runtime and target versions; enabled passes/flags; per-pass proof or validation results with input/output digests; every fallback or unsupported operation; target triple, ABI and cost model; final executable digest and its provenance.

Generate this manifest from the pipeline. It is an evidence artefact, not a manually maintained assurance claim.

### 9.3 Benchmarks

Fix the baseline compiler, flags, hardware, workload corpus, and metric. Measure compile time and peak compiler memory separately from binary size, startup, steady-state throughput, latency distribution, memory footprint and tail latency. Include workloads for actor/message throughput, shared-memory access, capability operations, session transitions, effects and bounded-resource computations.

Record cases in which a validator rejects an optimisation or a fallback runs slower. Publish scripts, versions, raw results and statistical methods. A benchmark establishes evidence for its corpus and target, not universal equality on all hardware.

## 10. Findings

1. K7PL's complementary strategies can form a single assurance argument, but each pass must preserve their semantics. Their mere presence in a type judgement does not establish this.
2. The immediate blocker is the source-to-target relation for full configurations and observations. The C-07 audit identifies missing state/trace correspondence; current machine soundness covers only a small generated K subset.
3. Completing the decision to make K the normative C3/C4 home requires the full grammar/semantics and proof mapping. The experimental five-constructor subset is not the whole-language source of truth.
4. Proof erasure and compile-time translation validation can support zero added run-time instrumentation. They do not guarantee that every legal optimisation will be accepted or that every source-level cost bound is a machine WCET result.
5. A bounded validator can be sound yet incomplete. Validation can thus affect compilation acceptance or fallback performance without adding instructions to a successfully validated binary.
6. The final executable boundary includes code generation, assembly/linking, runtime, FFI, privileged support, boot and hardware assumptions.
7. The zero-trade-off target should be recorded separately as proof erasure, no redundant runtime checks, cost-contract preservation and benchmarked non-regression for a named baseline.

## 11. Prioritised roadmap

| Priority | Action | Deliverable and exit condition |
|---|---|---|
| P0 | Define observations and configuration relation | Memory, capabilities, effects, channels, errors and cost have explicit source/target correspondence |
| P0 | Complete canonical source to generated K/Lean mapping | No independent semantics is assumed equivalent without a proof or checked translation |
| P0 | Close the C-07 simulation contract | Complete relation for computation, state, trace and target structural equivalence; proved for V0 |
| P0 | Define TCB and platform profile | Every compiler/runtime/ABI/FFI/boot/hardware boundary is covered or explicitly trusted |
| P1 | Prove V0 for every rule | Universal result for the small fragment, not just examples |
| P1 | Add pass-contract and certificate validation infrastructure | UNKNOWN, timeout and unsupported cases cannot count as success |
| P1 | Validate initial MLIR lowering | Every enabled conversion has a checkable relation for its supported operations |
| P1 | Cover the machine-code boundary | Backend, assembler, object and linker contracts relate final image to the target model |
| P1 | Prove proof erasure and no added instrumentation in V0 | Static proofs are erased; exact output comparison documents any additional instructions |
| P2 | Add memory/capability/FFI slice | R1/R5 properties connect to target memory and enforcement |
| P2 | Add effects and sessions | Trace simulation preserves message and effect observations |
| P2 | Add cost semantics | Abstract limits connect to target costs under named hardware assumptions |
| P2 | Validate one optimisation at a time | Every emitted output has checkable evidence and measured performance impact |

This roadmap does not authorise normative changes to `spec/`. It identifies the work and evidence required; it is not a substitute for the project's explicit process for modifying the normative source.

## 12. Sources and scope

Sources were checked on 2026-10-23 unless a named release is given.

1. **CompCert.** Semantic preservation for its C fragment and documented compiler scope. [Motivations](https://compcert.org/motivations.html); [compiler theorem](https://compcert.org/doc/html/compcert.driver.Compiler.html); [performance](https://compcert.org/compcert-C.html).
2. **CakeML.** Verified ML implementation and compiler backend. [Project](https://cakeml.org/); [source](https://github.com/CakeML/cakeml).
3. **Cogent.** Co-generation of low-level systems code and proof. [Project page](https://trustworthy.systems/projects/OLD/cogent/).
4. **Verve.** Verified OS components down to assembly-level instructions within its stated scope. Yang and Hawblitzel, PLDI 2010. [Publication](https://www.microsoft.com/en-us/research/publication/safe-to-the-last-instruction-automated-verification-of-a-type-safe-operating-system/).
5. **MLIR Dialect Conversion.** Operation conversion/type legality infrastructure, not a generic semantic theorem. [Official documentation](https://mlir.llvm.org/docs/DialectConversion/).
6. **Alive2.** Bounded LLVM translation validation and its stated limits. [PLDI paper page](https://web.tecnico.ulisboa.pt/nuno.lopes/pubs.php?id=alive2-pldi21); [tool repository](https://github.com/AliveToolkit/alive2).
7. **MLIR translation validation research.** A candidate method requiring evaluation against K7PL's dialects. [Publication DOI](https://doi.org/10.1142/S021819402450030X).
8. **K7PL sources.** [C4 semantics](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/SemantiqueOperationnelle.lean); [C-07 audit](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/docs/migration/C-07-SIMULATION-AUDIT.md); [K artifacts](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/CodeArtifacts.lean); [MachineSoundness](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/proofs/K7PL/MachineSoundness.lean); [ADR-0012](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/docs/decisions/0012-k-as-normative-home-of-c3-c4.md).

These sources demonstrate established research directions. They do not establish that K7PL's full compiler or OS already has the described guarantees.

## 13. R2 exit assessment

R2 delivers an audit of the present semantics chain, a preservation target, proof boundaries for the compiler pipeline, a comparison of verified compilation and translation validation, an operational decomposition of zero overhead, a vertical-slice plan, a TCB matrix, and a reproducible performance methodology.

**Blocking result:** the inspected artefacts do not yet connect full normative source semantics to the final machine code. The first deliverable must be a proved simulation for V0 that includes relevant state and observations. Memory, effects, channels, authority, costs and the final executable boundary must then be incorporated incrementally.

The Lisp-inspired shared-memory objective is not rejected. It increases the assurance requirement: for the admitted threat model, the source invariants must correspond to the concrete operations and any path that could bypass those invariants must be proved, checked, isolated, or explicitly trusted.

No normative text is changed here. No whole-compiler correctness, complete OS safety, or universal zero-performance-loss claim is marked established.
