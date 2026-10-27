<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R0 — Threat Model and Assurance Matrix

**Assessment date:** 2026-10-23  
**Repository snapshot:** `AntheaLiles/k7pl@4aea67661b049161689acb2163cfa1ebed1b5d5d`  
**Status:** Research result; non-normative; architecture decisions and proof obligations remain open.

## 1. Result and decision boundary

R0 establishes a first versioned threat model and maps candidate security properties to attackers, assets, observations, mechanisms, assumptions, evidence, and falsification tests. It does not declare the proposed operating system secure, change the normative K7PL specification, or authorize downstream implementation work.

The central result is a boundary mismatch that must be resolved before general isolation claims can be made. The current system-scale chapter describes actors executing in ring 0 in one physical address space, with no MMU-based separation; it attributes isolation of K7PL-compiled code to the type system, while acknowledging that foreign or unsafe code needs concrete confinement that the chapter does not provide. These statements appear in the [system-scale specification at the audited commit](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/SystemScale.lean).

A type-system argument can constrain programs that remain within the language and semantics it covers. It does not by itself constrain arbitrary FFI, assembly, native drivers, a faulty compiler, a compromised privileged component, a DMA-capable device, or malicious boot code. If any of those can access the same physical memory without a separately enforced boundary, the assurance argument must either include them in the trusted computing base (TCB) or introduce an additional protection mechanism and prove the relevant boundary properties.

The target is still prospective. The repository's [security policy](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/SECURITY.md) states that K7PL has no parser or interpreter at present and that the current executable attack surface is primarily the build chain. Accordingly, the matrix distinguishes future OS obligations from current repository risks.

### Evidence and status vocabulary

- **Repository fact:** a statement about files or CI records at the pinned commit; it is not, by itself, a security proof.
- **Literature result:** evidence established for the cited system, method, or publication. It transfers to K7PL only where the relevant assumptions and system boundary match.
- **Candidate claim:** a property worth specifying precisely; it is not currently a K7PL guarantee.
- **OPEN:** no sufficient K7PL proof or test evidence was found for the stated scope.
- **ARCHITECTURE GATE:** the property cannot be meaningfully claimed until a design choice fixes the boundary or assumptions.
- **PARTIAL — repository process only:** some process evidence exists, but it does not establish OS security.

## 2. Scope, system model, and unresolved assumptions

### 2.1 Scope

The model covers a prospective K7PL-based OS and its path from source to execution: language and type system, compiler and code generator, runtime and orchestrator, memory manager, FFI and assembly, drivers, devices and DMA, communication interfaces, boot and firmware, and the build and release chain.

The report assesses the threat model, not a particular production configuration. The target ISA, executable format, kernel/runtime boundary, MMU configuration, IOMMU/SMMU support, privilege transitions, interrupt model, multicore memory model, cryptographic protocols, boot root of trust, and hardware availability assumptions are not fixed by R0. These unknowns are recorded as obligations rather than silently filled in.

### 2.2 Assets

| ID | Asset | Security or system property at risk |
|---|---|---|
| A1 | Kernel, orchestrator, scheduler, memory manager, and global metadata | Integrity, control-flow integrity, availability |
| A2 | Actor-local memory, runtime state, and other actors' state | Spatial and temporal memory safety, isolation, integrity |
| A3 | Secrets and sensitive intermediate values | Confidentiality under the chosen observation model |
| A4 | Capabilities, handles, permissions, and revocation state | Authority confinement, non-forgeability, revocation consistency |
| A5 | Messages, protocol state, and external input | Input integrity, protocol safety, authenticity where required |
| A6 | Logs, snapshots, checkpoints, and replay journals | Integrity, confidentiality, completeness, replay correctness |
| A7 | CPU time, memory, queues, storage, I/O, and network capacity | Bounded resource use, availability, deadline satisfaction |
| A8 | Device registers, device state, and device-accessible memory | Device authority, integrity, DMA containment |
| A9 | Boot image, firmware, configuration, and trust anchors | Authenticity, integrity, anti-rollback, recoverability |
| A10 | Source, compiler, dependencies, CI workflows, build outputs, and release attestations | Build integrity, provenance, reproducibility |

### 2.3 Adversaries and capabilities

| ID | Adversary | Capabilities granted to the model |
|---|---|---|
| T1 | Malicious or compromised K7PL actor | Executes any behaviour expressible by the language and can use every authority legitimately granted to it; may seek resource exhaustion or abuse APIs |
| T2 | Low-integrity external input or peer | Supplies malformed, oversized, delayed, duplicated, replayed, reordered, or adversarial messages unless a lower layer is proved to prevent it |
| T3 | FFI, assembly, or native driver code | May perform arbitrary operations within its actual machine-level authority; language typing does not constrain it unless a verified boundary is established |
| T4 | Compromised or defective privileged component | May corrupt global metadata, alter scheduling, misroute capabilities, or access shared memory |
| T5 | Malicious or defective peripheral with DMA | May read or write device-addressable memory outside the CPU's normal checked accesses unless DMA is disabled or constrained |
| T6 | Observer of execution and resource use | May observe values exposed by APIs, message presence and order, errors, termination, timing, scheduling, resource use, and logs |
| T7 | Compromised bootloader, firmware, or configuration | May load, alter, downgrade, or misconfigure the software before the claimed runtime boundary is established |
| T8 | Compromised dependency, build action, tool download, cache, or release step | May cause the build to consume or publish an artifact different from the intended reviewed source |
| T9 | Faulty or malicious hardware, microcode, or platform primitive | May invalidate the hardware semantics assumed by software proofs; this is a trust-root issue, not something the K7PL type system can repair |

The baseline does **not** assume that the only adversary is a source-level actor. For T1, the model allows malicious behaviour through the legitimate language surface but does not grant arbitrary memory access unless the actor crosses an unsafe boundary or exploits a defect. For T3–T9, the relevant low-level authority is modelled explicitly.

### 2.4 Trust boundaries

| Boundary | Crossing | Required assurance question |
|---|---|---|
| B0 | Firmware and boot chain → initial kernel/runtime | What authenticates the image and configuration, prevents downgrade, detects tampering, and supports recovery? |
| B1 | K7PL source → compiler/code generator → executable | Is the generated executable a faithful implementation of the defined semantics for the exact target and options? |
| B2 | Trusted core/orchestrator ↔ actor | What enforces memory, scheduling, message, and authority separation if all actors share an address space? |
| B3 | Typed K7PL ↔ FFI/assembly/native code | Are inputs, outputs, layouts, effects, memory access, callbacks, and ownership validated at the boundary? |
| B4 | Actor/runtime ↔ network, user, storage, and other external inputs | Which checks authenticate, bound, canonicalise, sequence, and reject hostile inputs? |
| B5 | CPU-managed memory ↔ devices and DMA | Is DMA disabled, trusted, or confined by a verified IOMMU/SMMU configuration and device policy? |
| B6 | Runtime ↔ scheduler, clock, interrupt controller, and memory model | Which fairness, ordering, timing, and hardware assumptions support liveness or WCET claims? |
| B7 | Source repository and dependencies → build/CI → published artifact | How are inputs pinned, verified, isolated, attested, and reproducibly related to reviewed source? |
| B8 | Secret state → values, messages, errors, timing, resource use, and logs | Which observations are in the confidentiality policy, and what explicit declassification is permitted? |

A logical boundary is not yet an enforced boundary. In particular, separation between actors is not established merely because the implementation uses distinct actor identifiers or the type system intends to prevent pointer fabrication.

## 3. Observation model

Any confidentiality, non-interference, protocol, replay, or timing claim must name its observations. The initial observation tuple is:

- **O-value:** values returned through interfaces and values made readable through shared state.
- **O-control:** operation success or failure, exceptions, error classes, termination, non-termination, and the presence and order of messages.
- **O-external:** network sends, device operations, filesystem changes, and other externally visible side effects.
- **O-time:** response time, relative timing, scheduling choices visible to an actor, and deadline outcomes.
- **O-resource:** allocation, queue length where observable, budget consumption, throttling, and exhaustion signals.
- **O-persist:** state after recovery, checkpoint contents, event order, and replay outcome.
- **O-log:** log content, metadata, truncation, ordering, and access patterns.

Let O be the subset selected for a particular property. An equivalence relation such as s ≈O s′ must compare every observation relevant to that property. Confidentiality stated only over returned values is weaker than confidentiality over values plus message presence, termination, and timing. The report therefore does not assume constant-time behaviour or termination-insensitive confidentiality.

The relation, observer privileges, public inputs, secret inputs, allowed declassification, and treatment of divergence must be specified before a non-interference theorem is meaningful.

## 4. Assurance matrix

Each row is a candidate assurance obligation. “Candidate claim” deliberately avoids implying that a definition, proof sketch, or CI run already establishes it. Candidate mechanisms are options for evaluation, not architectural decisions.

| Property | Adversary and asset | Observation | Candidate formal claim | Candidate mechanism and application layer | Required assumptions | Evidence found / missing | Falsification test or counterexample | Status |
|---|---|---|---|---|---|---|---|---|
| **R0-01 Memory safety and representation integrity** | T1, T3, T4; A1–A2 | Invalid reads/writes, aliasing, faults, corrupted state | Every well-typed execution stays within its authorised memory regions; lifetime and layout invariants are preserved | Language typing and ownership rules; runtime checks where needed; compiler correctness; concrete isolation across unsafe code | Exact memory model, complete typing rules, sound compiler, trusted unsafe boundary and target layout | The specification discusses type-based isolation but does not provide a complete source-to-binary proof for the proposed OS | Malicious FFI writes through a forged or stale pointer into a second actor's state; test invalid ranges and lifetime reuse | **ARCHITECTURE GATE** |
| **R0-02 Actor isolation and integrity** | T1, T3, T4; A1–A2, A4 | Cross-actor reads/writes, capability transfer, changes to scheduler/global state | An actor can affect another actor or the trusted core only through declared, authorised interfaces | Decide on a hardware boundary or a narrowly defined trusted-core model; capability discipline; verified boundary checks | Either all code in the shared address space is inside the TCB or a concrete separation mechanism contains untrusted code | C4 describes ring 0 and one physical address space without MMU separation, and acknowledges the missing concrete confinement for foreign code | A native component writes to another actor's memory while respecting no K7PL typing rules because it is outside that type system | **ARCHITECTURE GATE** |
| **R0-03 Confidentiality and non-interference** | T1, T6; A3, A5–A7 | O-value, O-control, O-external, O-time, O-resource, O-log | Two runs differing only in secret state are equivalent under a declared O, except for explicit declassification | Information-flow typing or a proof relation across system traces; control of shared resources; explicit declassification policy | Scheduler and shared-resource model; fixed observation profile; cryptographic assumptions where relevant | No complete K7PL non-interference theorem for the OS, deployment profile, or side channels was identified | Secret bit controls whether a message is sent, when a response occurs, or whether an error/termination occurs, while returned data is constant | **OPEN** |
| **R0-04 Authority, capabilities, and revocation** | T1, T3; A4, A8 | Operations accepted after revocation, forged/duplicated handles, unintended effects | Every successful operation is authorised at the time it takes effect; revocation prevents future use according to a defined linearisation point | Capability representation, least-authority construction, attenuation, revocation protocol, checked FFI conversion | Define capability identity, sharing, delegation, stale handles, races, and revocation semantics | Related work is scheduled as R1; no end-to-end revocation guarantee is established by this report | Revoke a capability while an alias, queued request, callback, or native handle remains usable | **OPEN** |
| **R0-05 External input and protocol safety** | T1–T2; A5 | Accepted message sequence, parse result, errors, side effects | Only protocol-admissible traces cause the corresponding side effects; malformed input cannot grant new authority | Bounded parsing, validated data types, protocol state machine, explicit transitions for timeout, duplicate, replay, and cancellation | Specify framing, size bounds, authentication, replay protection, and failure semantics | Candidate protocol mechanisms are not yet tied to a complete OS interface contract | Oversized, malformed, reordered, duplicated, or replayed request triggers an unintended transition or consumes unbounded resources | **OPEN** |
| **R0-06 Compiler and executable correctness** | T3, T8; A1–A4, A10 | Differences between source semantics and executable trace | For a fixed target and profile, compiled executions simulate the specified semantics and preserve claimed safety and authority properties | Verified compiler or translation-validation chain; explicit semantics; proof/test mapping from source through intermediate representations to binary | Exact compiler version/options, ABI, runtime, target semantics, trusted assembly, and build inputs | K7PL architecture explicitly separates specification, formalisation, implementation, proof, and tests; complete conformance is not claimed in ASSURANCE.md | Compiler optimisation removes an authority check or changes a bounds guard; compare source model and machine trace | **OPEN** |
| **R0-07 Driver and DMA containment** | T3, T5; A1–A3, A8 | Device-originated reads/writes, interrupt events, device reset/failure | A device can access only its authorised buffers and registers; device activity cannot corrupt protected kernel or actor state | Disable DMA for untrusted devices, or use appropriately configured IOMMU/SMMU with validated mappings; restrict driver authority; verify teardown | Hardware support and correct configuration, cache/TLB ordering, device behaviour, and a policy for reset and hot-plug | No target platform or DMA policy is specified. seL4's published assumptions explicitly illustrate why DMA has to be excluded or treated as trusted unless additional mechanisms are proved | Configure a device to DMA outside its assigned buffer or retain a mapping after revocation | **ARCHITECTURE GATE** |
| **R0-08 Concurrency, liveness, and cancellation** | T1, T2, T4; A1, A4, A7 | Progress, message order, blocked tasks, resource cleanup | Safety invariants hold under interleavings; under stated fairness assumptions, enabled work progresses; cancellation releases or transfers owned resources exactly once | Explicit operational semantics; protocol/session-state invariants; scheduler and memory-model assumptions; cancellation-safe cleanup | Fairness, memory ordering, interrupt treatment, bounded critical sections, and a definition of progress | C4 contains design arguments and proof sketches; a target runtime and complete end-to-end liveness argument are not established | Force cancellation at every await/transition point; search for double release, leaked capability, deadlock, or starvation | **OPEN** |
| **R0-09 Availability and resource exhaustion** | T1–T2, T4; A1, A6–A7 | Memory and queue growth, CPU time, throttling, response and service failure | Under stated admission and scheduling assumptions, one actor cannot exceed assigned resource bounds or starve every other admitted actor | Admission control, per-actor limits, global capacity accounting, bounded queues, backpressure, cancellation and recovery policy | Define whether bounds are local or global, accounting overhead, shared resources, scheduler fairness, and failure reserve | K7PL grades/budgets are research topics; a local grade alone cannot establish system-wide availability | One valid actor creates an unbounded queue or churns actors until memory is exhausted; many individually bounded actors exceed global capacity | **OPEN** |
| **R0-10 Deadline and WCET guarantees** | T1, T4, T6; A7 | Worst-case execution time, deadline misses, jitter, budget exhaustion | For an identified task, target, configuration, and interference model, execution cost is bounded and deadlines follow from proved scheduling assumptions | Define task and interrupt model; WCET method; compositional resource analysis; target-specific scheduler and measurement validation | Processor and cache model, interrupts/DMA, compiler options, workload bounds, priority policy, and clock model | The cost scalarisation interface described in migration documentation is a design decision with proof obligations, not a measured or proved OS deadline guarantee | Hidden unbounded loop, cache/interrupt interference, or unmodelled device latency exceeds the claimed bound | **OPEN** |
| **R0-11 Logs, checkpoints, and replay** | T1–T4, T8; A3, A6, A10 | Log disclosure/tampering, checkpoint rollback, final state and side effects | Given a complete, authentic journal and fixed profile, replay reproduces the declared observation; recovery cannot duplicate a non-idempotent external effect | Journal schema and completeness invariant; integrity protection; atomic checkpoint/commit protocol; explicit treatment of clock, random input, scheduling and external effects | Key management, durable ordering, crash consistency, environment/toolchain profile, and definition of replay equivalence | C4's replay statements are marked under review with proof sketches and open premises; binary identity is explicitly conditional in the source | Omit one nondeterministic input or external event; crash between logging and effect; replay and compare observations | **OPEN** |
| **R0-12 Boot, firmware, and rollback** | T7, T9; A1, A9 | Measured boot state, accepted image, configuration and version | Only an authenticated, policy-accepted image/configuration executes; rollback to a disallowed version is rejected; recovery follows a stated policy | Root of trust, authenticated boot chain, protected version state, measured state, update/recovery process | Trust anchor integrity, signature algorithm and key handling, reset behaviour, firmware interface, and physical attacker profile | No concrete boot chain or target platform is selected. NIST SP 800-193 is a relevant engineering reference, not evidence that K7PL implements these controls | Boot a modified image, downgrade to a known vulnerable image, or alter configuration between verification and use | **ARCHITECTURE GATE** |
| **R0-13 Timing and shared-resource channels** | T6, T1; A3, A7 | Timing, cache/resource contention, response ordering, allocation patterns | Secret-distinguishing runs do not differ in the selected timing/resource observations, under the stated attacker measurement model | Constant-time primitives where applicable; resource partitioning or scheduling controls; declassification and quantitative leakage policy | Hardware timing model, co-residency, observer resolution, noise assumptions, and treatment of interrupts/cache/DMA | No K7PL claim of general absence of covert timing channels was found; external verified-kernel literature expressly narrows such claims | Encode one secret bit into branch length, scheduling, queue occupancy, or response timing | **OPEN** |
| **R0-14 Build-chain integrity and provenance** | T8; A10 and ultimately A1/A9 | Source-to-artifact identity, workflow identity, dependency contents, release metadata | Every released artifact is traceably built from reviewed source and declared inputs; checks detect substitution within the stated threat model | Pin and verify tool and dependency digests; isolate build permissions; attest workflow/artifact; verify provenance and rebuild where feasible | CI provider and runner trust, authenticated sources, complete dependency inventory, deterministic build inputs, signing/attestation trust | SECURITY.md documents unresolved remote tool/download and cache risks. The generated STATUS.md records commit 9cd5bc5, not this audit's HEAD; live checks on the audited HEAD were not all complete when inspected | Substitute a downloaded tool or dependency while leaving source unchanged; compare provenance, hashes, and artifact behaviour | **PARTIAL — repository process only** |
| **R0-15 Hardware and physical trust** | T9 and physical attacker; A1–A10 | Any software-visible result may be falsified by the assumed platform | Software theorems hold only for the machine model and trusted primitives actually assumed; no software-only guarantee is claimed against arbitrary malicious hardware | Explicit platform assumptions, hardware qualification, protected trust anchor, and separate physical/security evaluation where in scope | Specify whether invasive physical attacks, malicious microcode/silicon, fault injection, and supply-chain substitution are in scope | No K7PL hardware model or platform validation exists in this research dossier | Hardware returns incorrect memory or privilege results, or a compromised trust anchor lies about image measurements | **ARCHITECTURE GATE** |

## 5. Highest-priority counterexamples

These cases should be kept as named falsification targets and converted to executable tests or formal counterexample models when the corresponding component exists.

1. **Unsafe component crosses a purely logical boundary.** Actor A is well-typed, but it calls a native component that writes to actor B's memory. If the claimed theorem covers only K7PL source terms, the theorem does not cover this execution. If the native component is in the TCB, the assurance claim must say so. If not, a concrete boundary is required.
2. **Capability policy is correct in isolation but the service is confused.** An actor possesses a valid capability, asks a privileged service to use it on a caller-controlled target, and obtains an effect beyond the actor's intended policy. Non-forgeability does not prove the correctness of the receiver's authorisation logic.
3. **DMA bypasses CPU-side checks.** CPU-level bounds checks pass, while a device writes outside the assigned buffer. The test must observe device-addressable memory and mapping lifetime, not just CPU loads and stores.
4. **Value-only confidentiality misses a leak.** Two runs return identical values, but a secret changes message presence, error class, termination, timing, or queue occupancy. A value-only equivalence cannot support a broader confidentiality claim.
5. **Local budgets fail to imply global availability.** Every actor obeys its own limit, while aggregate queues, actor metadata, logging, interrupts, or recovery work exhaust a shared resource. Per-actor bounds need an aggregate capacity and scheduling argument.
6. **Replay omits one cause of nondeterminism.** A journal contains messages but misses an interrupt, clock value, random value, scheduling decision, or external side effect. Replay can diverge or duplicate a non-idempotent effect even if actor handlers are pure.
7. **Build controls pass on a substituted input.** A mutable tool download, dependency, or cache changes the generated artifact without changing the tracked source. A green CI run then says only that the configured workflow passed over those inputs; it does not authenticate their origin.
8. **Boot authentication without rollback policy accepts a forbidden version.** An older but correctly signed image is loaded although the security policy requires a newer version. Signature verification alone is insufficient for anti-rollback.

## 6. Architecture gates before choosing mechanisms

R0 recommends recording explicit decisions for these questions before new language constructs or grade coordinates are introduced.

### G0. Isolation target

Choose and document one primary profile:

- **Profile A — trusted single-address-space unikernel:** every component able to execute in ring 0, including relevant FFI, assembly, runtime, and drivers, belongs to the TCB. The threat model excludes arbitrary native components from the untrusted domain. The proof burden includes compiler/runtime soundness for all admitted K7PL code.
- **Profile B — mutually distrustful components:** foreign code, drivers, or compromised actors are adversarial. A concrete enforcement boundary is required, such as an MMU-backed separation or a suitable capability-hardware design. Device DMA and entry/exit transitions must be covered as well. Capabilities and typing remain useful, but they do not substitute for the chosen machine boundary.
- **Profile C — software-only confinement of foreign code:** this remains a research hypothesis, not the current design result. It requires an exact threat model for native code and a proof of the boundary property; it must not be assumed from source-language typing.

The current C4 discussion motivates Profile B for genuinely untrusted FFI, but R0 does not ratify a target architecture.

### G1. Trusted computing base

List each component whose failure invalidates which property: compiler, linker/code generator, runtime, orchestrator, memory manager, FFI adapter, assembly, drivers, scheduler, bootloader, firmware, hardware memory model, and build service. For each, decide whether it is proved, tested, audited, isolated, or trusted by assumption. “Trusted” must not silently mean “proved”.

### G2. Observation and declassification policy

Choose the confidentiality observation set, termination sensitivity, timing resolution, treatment of resource contention, and explicit declassification rules. Without this decision, no single non-interference claim has a well-defined scope.

### G3. DMA and device policy

Record target platform and IOMMU/SMMU capability, default DMA policy, driver trust level, mapping lifecycle, interrupts, hot-plug, reset, and device recovery. If DMA is excluded, record that as an enforceable configuration assumption rather than a prose caveat.

### G4. Availability and time model

Separate a local computation budget from global system availability and hard real-time guarantees. Fix the scheduler model, interference set, interrupt and device latency assumptions, queue bounds, admission policy, and failure reserve. A scalar cost interface or successful microbenchmark is not a WCET proof.

### G5. Boot and build root of trust

Define accepted boot images, authentication and anti-rollback policy, recovery, source/dependency pinning, CI identity, build attestations, and whether bit-for-bit reproducibility is required. Record which claims depend on the CI provider, runner, signing keys, hardware and external downloads.

## 7. Follow-up obligations and priority

| Priority | Obligation | Deliverable / exit condition | Intended follow-up |
|---|---|---|---|
| P0 | Ratify G0 and enumerate the TCB | Architecture decision with attacker classes and explicit exclusions; no blanket isolation claim left undefined | Human architecture decision before implementation |
| P0 | Define the operational and observation models | Formal definitions of execution trace, authority, memory state, observables, and attacker control | R1, R3, R4, R5 |
| P0 | Specify the source-to-binary boundary | Chain of semantic relations and explicit trusted components; list of machine-level assumptions | R2 |
| P0 | State device and DMA assumptions | Target platform profile, DMA policy, device authority, and relevant failure cases | R1, R2, R3 |
| P1 | Formalise authority and revocation | Capability state, delegation, linearisation of revocation, stale-handle behaviour, proof obligations | R1 |
| P1 | Formalise isolation and confidentiality | Explicit property, relation between runs, observer set, declassification policy and scoped counterexamples | R3 |
| P1 | Define protocol and cancellation failure semantics | State machines, hostile-input bounds, progress assumptions, cleanup invariants | R4 |
| P2 | Prove resource and timing composition | Separate local budgets, aggregate resource limits, WCET assumptions, scheduling theorem and counterexamples | R6 |
| P2 | Specify persistence and recovery | Journal completeness, crash consistency, idempotence, rollback and replay properties | R7 |
| P2 | Add falsification tests at executable boundaries | Negative cases for every implemented boundary; tests must report the build/profile and what they do not establish | R9 and implementation work |

Do not add a new grade dimension solely to encode a missing security property. Memory authority, information flow, temporal bounds, device isolation, and platform trust may belong to different layers and may require different proof relations. The assurance matrix must first identify the property and where it is enforced.

## 8. What external evidence does and does not support

- NIST SP 800-160 Vol. 1 Rev. 1 (November 2022) provides a systems-security-engineering basis for deriving and tracing protection needs, assumptions, system elements, verification, and validation. It is a method reference, not a K7PL security certification: [publication page](https://csrc.nist.gov/pubs/sp/800/160/v1/r1/final).
- NIST SP 800-154 is still presented by NIST as an Initial Public Draft (March 2016), with a planning note dated 23 January 2025 saying NIST intends to finalise it. Its data-centric threat-modelling concepts are useful, but its status must not be presented as a final standard: [publication page](https://csrc.nist.gov/pubs/sp/800/154/ipd).
- The seL4 project publishes concrete proof statements and their assumptions. Its documentation explicitly identifies assembly, boot, hardware, DMA, configuration, and side-channel qualifications. This is an example of scoped assurance and of residual platform obligations, not evidence that K7PL has equivalent properties: [proof assumptions](https://www.sel4.org/Verification/assumptions.html), [proof summary](https://sel4.com/Verification/proofs.html).
- NIST SP 800-193 (May 2018) treats firmware resilience as protection against unauthorised changes, detection, and recovery. It motivates a separate boot/firmware row rather than treating kernel properties as sufficient: [publication page](https://csrc.nist.gov/pubs/sp/800/193/final).
- NIST SP 800-218 SSDF v1.1 (February 2022) gives secure-development practices to integrate into the lifecycle. NIST also lists Rev. 1 as a draft published on 17 December 2025; the final 1.1 text is used here as a stable baseline, not as evidence of implementation: [v1.1 final](https://csrc.nist.gov/pubs/sp/800/218/final), [SSDF publication list](https://csrc.nist.gov/projects/ssdf/publications).
- CHERI literature explores capability-based hardware protection and compartmentalisation as one possible design space. It should be evaluated against K7PL's target, toolchain, ABI, device model, and proof scope rather than adopted by analogy: [Watson et al., “CHERI: A Hybrid Capability-System Architecture for Scalable Software Compartmentalization” (2015)](https://www.cl.cam.ac.uk/research/security/ctsrd/pdfs/201505-oakland2015-cheri-compartmentalization.pdf).

These sources provide methods, precedents, or evidence about other systems. None substitutes for a K7PL-specific semantics, proof, binary-conformance argument, hardware profile, or negative test.

## 9. Repository evidence and limitations

1. The system-scale specification at the audited commit is the primary project source for the ring-0/shared-address-space design and its admitted FFI limitation: [C4](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/SystemScale.lean).
2. The assurance case labels conceptual foundations and verification as partial, specification/formalisation correspondence as partial, and implementation conformance as open. It explicitly rejects inferences from compilation or tests to stronger claims: [ASSURANCE.md](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/docs/ASSURANCE.md).
3. The security policy records unresolved build-chain risks and says no parser or interpreter exists today: [SECURITY.md](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/SECURITY.md).
4. The fetched generated [STATUS.md](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/docs/STATUS.md) identifies commit 9cd5bc57f9c466ea2a6807de96e0b4722e61c70c, not the audited HEAD. The check-run inspection of 4aea67661b049161689acb2163cfa1ebed1b5d5d also showed checks still in progress. Consequently, neither the older generated aggregate status nor an unfinished run is treated as current final CI evidence for this report.
5. No K7PL OS implementation, target hardware profile, end-to-end isolation proof, source-to-binary correctness proof, non-interference theorem, DMA assurance case, WCET result, or executable OS threat-test suite was identified in this R0 audit. This is a statement about evidence inspected, not a proof that no related artefact exists elsewhere.

## 10. R0 exit assessment

R0 has produced an initial threat model, asset and adversary inventories, trust boundaries, a defined observation vocabulary, a property-to-evidence matrix, priority counterexamples, and explicit architecture gates. It meets the dossier's research-artefact objective at this revision.

R0 does **not** close the OS-security research programme. The next blocking step is a human architecture decision on isolation and the TCB. R1–R3 can refine authority, compilation correctness, and confidentiality once that decision is recorded. R8 can compare alternative OS designs, but should not be used to imply that a particular architecture has already been selected. R6 and R7 remain dependent on a concrete execution and failure model.

No normative specification change is made by this report, and no security property is marked established.
