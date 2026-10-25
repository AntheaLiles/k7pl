<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R1 — Authority, Capabilities, Revocation, and FFI Boundaries

**Assessment date:** 2026-10-23  
**Audited repository snapshot:** AntheaLiles/k7pl at main, commit 4aea67661b049161689acb2163cfa1ebed1b5d5d  
**Status:** Non-normative research report. Architecture choices and proof obligations remain open.

## 1. Research question and result

R1 asks whether K7PL's typed and linear permissions can become effective authority controls from source code through the called component or device. The result is conditional: static resource discipline can rule out certain programs within the formal language, but it does not by itself constrain arbitrary FFI code, machine-level aliases, a driver, a device, or another component that can bypass the checked interface.

The repository has a useful abstract resource-counting model, but the inspected formal artefacts do not connect it end to end to the actual K7PL operations, the running memory representation, or an authority enforcement boundary. This report therefore cannot mark capability safety, revocation, or FFI confinement as established.

The distinction to preserve is:

1. **A linear type** constrains how a well-typed program may use a value within the language's formal rules.
2. **A software capability** is a protected or mediated reference whose possession authorises specified operations. Enforcement depends on the table, dispatcher, domain boundary, or trusted component that checks it.
3. **A kernel capability** is governed by a trusted kernel mechanism that controls creation, delegation, invocation, and deletion or revocation.
4. **A hardware capability** is an unforgeable machine value with hardware-enforced bounds and permissions. This does not automatically make it linear, define its revocation policy, or prove the surrounding allocator and device configuration correct.

These are different guarantees, implemented at different layers. They may complement one another; none should be treated as another by terminology alone.

The current system-scale source describes actors in ring 0 in one physical address space and notes that its type-system argument does not confine foreign code by itself. See [C4 — system scale, at the audited commit](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/EchelleDuSysteme.lean). Under that profile, native code capable of arbitrary loads and stores in the shared address space must either be part of the trusted computing base or be restricted by another enforceable boundary. A typed FFI signature is not such a boundary on its own.

## 2. Source audit: what is and is not established

### 2.1 Normative memory claims

The memory-model chapter states a spatial-safety theorem in terms of the linear writing capability WriteCap(r). Its stated premises include:

- **H1 — unique introduction:** the arena or segment from which a writing capability is obtained is consumed linearly;
- **H2 — region correspondence:** disjoint ranges denote distinct regions;
- **H3 — delimiter and capture discipline:** a duplicable value cannot capture a linear writing capability.

The theorem is explicitly marked under review and has proof-sketch evidence. Its note leaves H1 open pending the arena-elimination rule; it also treats H2 and H3 as separate obligations. See [C4 — memory models](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/ModelesDeMemoire.lean).

This argument concerns which operations are derivable in the formal system under those hypotheses. It is not yet a proof that a raw pointer handed to foreign code is inaccessible after the call, that a malicious driver respects the region, or that the hardware maps the abstract region to the asserted physical range.

### 2.2 Lean implementation evidence

The current [MemoryCapability.lean](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/src/K7pl/MemoryCapability.lean) proves an invariant: for each abstract region, the number of available arena tokens plus live writing capabilities is at most one. It proves invariant preservation by an abstract allocation operation and excludes two writers when the aggregate parallel state satisfies the invariant.

The file explicitly says the model is **not yet** the operational rules for Arena, WriteCap, alloc_range, or Par in the K7PL source language. It has no holder identity, object identity, permission set, delegation graph, revoked state, FFI call, device mapping, or operation history. The theorem is evidence for one resource-counting invariant, not end-to-end authority enforcement.

The current [MemoryRange.lean](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/src/K7pl/MemoryRange.lean) proves an interval-arithmetic result. Its module comment states that mapping ranges to actual region identities and capability rules remains a separate obligation; the file does not establish H1, H3, or memory safety.

### 2.3 Dynamic references and the ABA claim

The actor-scale chapter describes EntityRef as a 64-bit handle containing a 32-bit index and a 32-bit generation, and claims that incrementing the generation when an index is reused prevents confusion with the previous occupant. See [C4 — actor scale](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/EchelleDeLActeur.lean).

A generation field is a useful stale-handle defence only if each operation validates the supplied generation against the current slot generation before accessing the object. The field alone does not check itself. The proof also needs a policy for wraparound, reset and snapshot restore, concurrent deletion/reuse, and code that caches a raw address after a successful lookup. If a stale handle's generation can eventually match a reused slot, the anti-ABA argument requires another condition or mechanism. If foreign code retains the raw address instead of the checked handle, validating the handle on a later lookup cannot retract that pointer.

The phrase “no additional check is needed” must therefore be scoped to the particular operation or invariant it describes. It is not a general theorem about dynamic use of recycled identifiers.

### 2.4 Evidence ledger

| ID | Current evidence | Supported conclusion | Not established |
|---|---|---|---|
| E1 | C3 describes WriteCap as a linear resource | The normative intent excludes duplicating a writing capability in a valid derivation | Enforcement against unsafe native code |
| E2 | C4 spatial-safety result, under review with proof sketch | A candidate theorem under H1, H2, and H3 | Discharge of all premises and source-to-machine correspondence |
| E3 | MemoryCapability.lean abstract invariant | Allocation preserves the resource-counting invariant under its stated preconditions | Operational correctness of Arena, alloc_range, WriteCap, Par or foreign code |
| E4 | MemoryRange.lean interval theorem | A limited fact about disjoint finite intervals | Correct mapping to region identities and memory permissions |
| E5 | C4 EntityRef description | A proposed index/generation encoding | Checked use on every access, wraparound semantics, safe reuse, or FFI confinement |
| E6 | C4 system-scale text | The intended shared-address-space profile and an acknowledged FFI confinement gap | A concrete isolation mechanism for mutually distrustful native components |

The evidence is from current repository source at the audited commit. None of the rows upgrades it to a broader claim.

## 3. Authority model

A useful model needs more information than “a value has a capability type”. The minimum state should distinguish principals, objects, authority tokens, rights, and object lifetime.

Let D be a set of domains or principals, O a set of protected objects, R a set of rights, and C a set of capability instances or opaque references. The model needs at least these relations:

- Holds(d, c): domain d currently possesses token c.
- Target(c, o): token c designates object o.
- Rights(c) ⊆ R: operations that c authorises.
- Parent(c): optional derivation parent, if delegation ancestry is tracked.
- Live(o): whether the designated object still exists and is available.
- Epoch(c) or an equivalent revocation state, if the design uses generations or revocation epochs.
- Pending(c, op): an operation admitted but not yet at its defined commit point.

This is a proposed model for analysis, not an existing K7PL formalisation.

### 3.1 Required invariants

**A1 — possession and invocation.** An operation on object o succeeds only when the caller possesses a valid token for o, the object is live, and the token authorises that operation. Knowing an object address or guessing an integer is not by itself authority.

**A2 — attenuation.** Delegating a token may preserve or reduce its authority, but must not silently add rights. For a child c′ delegated from c, effective rights satisfy Rights(c′) ⊆ Rights(c). Any exception requires a separate, explicit authority source.

**A3 — controlled introduction.** An actor cannot create a token for an object or right that it could not otherwise reach. This includes region capabilities: two separately created linear tokens for the same region are an issue even when neither token is individually duplicated.

**A4 — object lifetime.** A token is usable only while its target and the required mapping are live. Deallocation, object destruction, slot reuse, snapshot restoration, and failure recovery must preserve this relation.

**A5 — revocation.** Revocation has a defined target set, ordering point, concurrency semantics, and acknowledgement condition. “Revoke the capability” is incomplete unless it says which derivatives or aliases become unusable and how in-flight operations are handled.

**A6 — composition.** The invariants remain true after delegation, storage in data structures, callbacks, concurrency, error handling, cancellation, and FFI crossings. Proving them for isolated components does not establish preservation under composition.

**A7 — bounded physical access.** Where the token authorises memory, MMIO, IRQ, or DMA, the relevant machine operation is constrained by the authority represented in the model. A source-level type cannot impose this invariant on arbitrary instructions in native code by itself.

### 3.2 Rights are not grades

Usage grades, linearity, and operating-system authority are related but distinct.

A grade can describe how often a binding may be used in a derivation. It need not express which principal may read a physical page, which MMIO registers can be written, whether a capability can be delegated to a driver, or whether an outstanding device transaction survives revocation. Similarly, a linearly used handle may refer to an object with excessive permissions.

Do not introduce a new grade coordinate merely to encode a missing authority mechanism. First define the principal, resource, right, and enforcement boundary. The language can express a statically constrained interface; runtime, kernel, or hardware mechanisms may be required to enforce the intended policy against code outside that language.

## 4. Capability mechanisms: comparison and limits

The following are design patterns evidenced by their own system documentation. They are options for an architectural comparison, not claims that K7PL has implemented any of them.

| Model | What enforces the authority | Delegation and attenuation | Revocation model | Principal limitation for K7PL |
|---|---|---|---|---|
| **Statically typed or linear token** | Type checking and preservation of the language invariant | Restricted by the language's typing rules | Often consumption or lexical lifetime; not necessarily dynamic revocation | Does not confine arbitrary FFI, native code or hardware |
| **Software object capability / protected handle table** | Trusted dispatcher checks token, object identity, principal and rights on each operation | Can create a restricted child token or handle | Table entry, revocation epoch, indirection, or object-wide invalidation | Safe only if callers cannot bypass the dispatcher or access the object directly |
| **Kernel capability** | Kernel-protected capability space and invocation checks | Kernel mediates capability transfer; rights may be reduced by supported operations | Kernel tracks capability references or derivation relationships for defined operations | Kernel API semantics, object lifecycle and complete TCB boundary still matter |
| **Hardware capability** | CPU capability tags, bounds and permission checks on capability operations | Permission/bounds attenuation can be represented in the capability; copying may remain possible | Requires a separate temporal-revocation and memory-reuse design | Target architecture, compiler/ABI, allocator, switcher, and device boundaries remain necessary |
| **Generation handle** | Checked lookup against a current slot/object generation | Ordinary access control must still accompany the handle | Invalidates stale references when generations differ | Handle generation is not authority by itself; lookup checks and wraparound policy are required |
| **Lease or epoch token** | A trusted clock/epoch service and a check at operation time | Derivation limited by expiry/epoch policy | Expires by time or epoch change | Clock assumptions, revocation latency, and in-flight operations complicate the claim |

### 4.1 Kernel capability precedent: seL4

The seL4 API distinguishes deletion of one capability slot from revocation of child capabilities derived from a designated capability. Its tutorial explains capability spaces as protected collections of references and notes that different capabilities can refer to the same object with different permissions. Sources: [seL4 API reference](https://docs.sel4.systems/projects/sel4/api-doc.html) and [seL4 capability tutorial](https://docs.sel4.systems/Tutorials/capabilities.html).

This is a useful model for formalising derivation, delegation, and subtree revocation. It must not be over-read as a generic ability to reverse external effects. A kernel revocation operation does not undo a network message already sent, erase data copied outside the managed domains, or invalidate arbitrary raw pointers that escaped into a realm outside the kernel's tracking model. The exact guarantee depends on which objects and descendant capabilities the kernel manages.

### 4.2 Protected software object capabilities: Genode

The Genode Foundations 25.05 documentation describes component protection domains, kernel-maintained capability spaces, object identities and kernel-mediated capability delegation. It also warns that not every underlying kernel satisfies all requirements of the abstract model, so the platform-specific realisation must be assessed. Source: [Genode capability-based security, Foundations 25.05](https://www.genode.org/documentation/genode-foundations/25.05/architecture/Capability-based_security.html).

This is a good fit for an object-level authority model, but it relies on actual protection domains and an enforcement mechanism. If every component shares an address space and can directly manipulate a service's memory, an integer handle or opaque API type does not recreate Genode's boundary.

### 4.3 Hardware capabilities: CHERIoT

The CHERIoT RTOS architecture describes hardware capabilities as unforgeable values that authorise operations, and compartments as isolated software components. It also assigns concrete duties to the switcher, scheduler, loader, and allocator. The allocator bounds capabilities and, when memory is freed, uses revocation state and ensures a full revocation pass before reusing the region. Sources: [CHERIoT RTOS architecture](https://github.com/CHERIoT-Platform/cheriot-rtos/blob/main/docs/architecture.md) and [CHERIoT FAQ](https://github.com/CHERIoT-Platform/cheriot-rtos/blob/main/docs/faq.md), both accessed 2026-10-23.

This illustrates two distinctions relevant to K7PL. First, hardware-enforced bounds and permissions do not by themselves establish linear, single-use semantics. Second, spatial bounds do not by themselves close temporal safety: memory reuse requires a revocation mechanism that addresses stale capabilities and a precise rule for when reuse is safe. CHERIoT's design is platform-specific; it does not show that the same guarantees exist on K7PL's unspecified target.

## 5. Revocation semantics that need a decision

Revocation is not one operation with one universal meaning. A K7PL authority interface needs to choose and name its semantic contract.

| Candidate contract | Required meaning | Open problem |
|---|---|---|
| **Slot deletion** | Remove one locally held handle or capability reference | Other copies or delegated references may remain usable |
| **Subtree revocation** | Invalidate tracked capabilities derived from a designated parent | The system needs a derivation relation and must define whether all descendants are found atomically |
| **Object-wide revocation** | Make every managed reference to one object unusable | Every access must pass through an authoritative object-liveness check or equivalent mechanism |
| **Epoch/generation invalidation** | Reject handles whose saved epoch differs from the object's current epoch | Checks must be universal; generations must not wrap into a previously valid value within the threat model |
| **Lease expiration** | An authority expires under a declared clock/epoch rule | Define clock trust, exact expiry semantics, and maximum delay |
| **Memory-capability revocation** | Ensure stale references to freed memory cannot access a later allocation | Requires pointer-access enforcement and a safe reuse protocol, not just handle-table deletion |

### 5.1 Proposed linearisation contract

For any operation subject to revocation, define an abstract admission or commit point. One candidate strong contract is:

> Once a successful revocation acknowledgement is returned for authority a, no operation using a or a covered derivative can commit after that acknowledgement. Operations that committed earlier remain historical effects; operations still pending at revocation must be rejected, cancelled, or drained before acknowledgement.

This is stronger than “future lookups fail”. It gives cancellation, device operations and concurrent requests an unambiguous target. It may be too costly for some operations; if the implementation chooses a weaker contract, the semantics and latency must be recorded explicitly.

The contract must distinguish:
- operations admitted before revocation but not yet committed;
- callbacks or queued requests that still carry the authority;
- another thread already executing through the authority;
- a raw pointer or device mapping derived earlier;
- side effects already made visible outside the system;
- object destruction and later memory reuse.

A capability's removal from a table is not sufficient if a caller can still invoke a cached native function pointer, dereference an escaped address, use a queued request, or ask a device to continue DMA.

### 5.2 Generation counters are not a substitute for universal checks

If a table uses slot i and generation g, each lookup must check that the current entry at i is live and carries generation g. The design must also specify:
- the maximum lifetime of stale handles;
- how generation wraparound is excluded or made safe;
- whether persistent snapshots can restore an older generation;
- whether lookup and object destruction are atomic relative to one another;
- whether a pointer is returned after lookup, and how long it remains valid;
- what happens when the FFI retains a handle or pointer beyond the declared lifetime.

A wider counter reduces some engineering risks but is not a proof against unlimited reuse. A hardware capability can add unforgeability and bounds, yet it still needs a temporal-revocation policy if old references could later reach a reused allocation.

## 6. FFI is a protocol boundary, not just a function signature

The FFI contract must define what information and authority cross the boundary, what can escape, and what occurs on every return path. Each interface must be classified explicitly.

| FFI class | Proposed contract | Enforcement and evidence required |
|---|---|---|
| **Copy-in / copy-out** | Foreign code receives a bounded copy; modifications return as data after validation | Length bounds, representation checks, validation of return data; the original mutable region is not shared |
| **Read-only borrow** | A bounded view may be read for the call duration; no retention, mutation, or asynchronous use is permitted | Lifetime and layout contract, no-escape rule, trusted wrapper or isolation against non-compliant native code |
| **Exclusive mutable borrow** | The caller cannot access or mutate the region during the call; foreign code cannot retain the view past the declared end | Ownership transfer in the model, exact return/error/cancellation semantics, boundary enforcement |
| **Owned transfer** | The callee receives ownership; the caller cannot use the resource again unless ownership is explicitly returned | State transition proving uniqueness and accounting for all exits and failures |
| **Retained asynchronous buffer** | The callee may keep the buffer until an explicit completion or revocation protocol ends | Pinning or stable allocation, outstanding-use tracking, cancellation, completion, and delayed reuse |
| **Opaque service handle** | Foreign code receives a handle, not direct access to the protected object | Checked dispatch on every operation, domain binding, rights attenuation, object-liveness and revocation checks |
| **MMIO access** | Access is limited to specific registers and operations on a named device | Platform-specific mapping permissions, access widths, ordering, IRQ handling and register side-effect policy |
| **DMA buffer** | A device may access only the granted buffer for a defined period | Device-visible mapping and IOMMU/SMMU policy where applicable, buffer pinning, mapping invalidation, device quiescence, and completion before reuse |

A declaration that a pointer is borrowed is a promise to the type checker and wrapper. It does not stop arbitrary C or assembly from storing the address globally or in a callback. If that behaviour is inside the threat model, the contract must be protected by an enforcement mechanism or the foreign code must be trusted.

### 6.1 Mandatory FFI contract fields

Every boundary description should state:
1. Representation: exact layout, alignment, endianness, pointer/address-space width, size and length units.
2. Ownership mode: copy, read borrow, exclusive borrow, ownership transfer, or retained asynchronous use.
3. Rights: read, write, execute, invoke, map, delegate, and any device-specific operations.
4. Lifetime: entry, normal return, error return, panic/unwind, timeout, cancellation, concurrent callback, and component termination.
5. Aliasing: permitted overlapping ranges; who may access the same region during the call; whether reentrant calls are permitted.
6. Effects: callbacks, interrupts, I/O, logging, network, storage, and other irreversible effects.
7. Authority checks: who checks the operation and rights at the time they take effect.
8. Revocation: how retained copies, pending requests, native handles, and device mappings become unusable.
9. Failure behaviour: malformed return values, partial completion, exceptions, and resource cleanup.
10. Evidence: proof obligation, runtime assertion or hardware mechanism, negative test, and assumptions not enforced by the boundary.

A type signature without these fields is insufficient for an FFI that is permitted to retain memory or exercise system authority.

## 7. Device authority: MMIO, IRQ, DMA and physical memory

A peripheral interface should not be represented as one undifferentiated “device capability”. At minimum, the model should distinguish:
- a bounded set of MMIO registers and allowed access operations;
- authority to configure or receive a particular interrupt;
- authority to map a named memory range for device access;
- a lifetime or lease for each mapping;
- reset, detach, failure and reassignment semantics.

CPU checks do not necessarily constrain bus-master DMA. Where a device can access physical memory, the threat model needs an enforceable device-side boundary or must explicitly trust the device. If an IOMMU/SMMU is used, the proof target includes mapping creation, invalidation, translation-cache completion, outstanding device transactions, and memory reuse. The exact steps depend on the target platform and cannot be fixed before platform selection.

A revocation acknowledgement for DMA must not be issued merely because software has removed a mapping from its own table. It needs a platform-supported condition establishing that the former mapping can no longer be used, and that pending transactions cannot corrupt memory after it has been reassigned.

## 8. Adversarial scenarios and falsification tests

These scenarios are intended to falsify the candidate claims, not merely demonstrate the happy path. Tests should record the target, runtime, architecture and configuration. Passing them is evidence for the cases exercised, not a general proof.

| ID | Scenario | Property challenged | Required test or model |
|---|---|---|---|
| F1 | Call alloc_range twice through a path that can reuse or alias the same arena | Unique introduction of WriteCap | Construct two capabilities for the same abstract region and attempt parallel mutation; prove this state cannot be reached through the operational rules |
| F2 | Duplicate or attenuate a capability by a malformed FFI handle conversion | No authority creation or privilege increase | Mutate handle bits, rights fields and object identifiers; invalid or excessive-right requests must fail before the effect |
| F3 | A foreign function stores a supposedly borrowed pointer and uses it after return | Borrow lifetime and no-escape | Use the saved pointer after normal return, error, cancellation, callback and region reuse; establish containment, not only wrapper discipline |
| F4 | An actor revokes a delegated capability while another actor has a queued request | Revocation ordering | Race invoke/delegate/revoke; assert the declared linearisation contract at the external side-effect boundary |
| F5 | A stale EntityRef is used after deletion and slot reuse | ABA and stale-reference protection | Keep old references over repeated reuse; check every access compares generation, and test defined wrap/reset behaviour |
| F6 | A service uses its own broad authority to act on behalf of an untrusted caller | Confused deputy / least privilege | Pass multiple caller identities and capabilities concurrently; ensure each operation is bound to the originating caller's rights |
| F7 | FFI returns an error after partially mutating a borrowed region | Failure atomicity and ownership | Exercise each error path and verify ownership, resource accounting, and state invariants after partial effects |
| F8 | Cancellation occurs while native code holds a buffer or callback | Revocation and lifetime | Cancel at every boundary state; ensure completion or quiescence precedes free/reuse and callbacks cannot use stale authority |
| F9 | A device retains an old DMA mapping while its buffer is reassigned | Device isolation and memory lifetime | Revoke mapping, trigger late DMA and concurrent reassignment, then check neighbouring and new-owner memory |
| F10 | A derived software handle is copied to an untracked domain | Delegation closure | Compare the authority graph against all accepted possession/invocation routes; an untracked alias must not remain usable |
| F11 | Generation wrap, snapshot restore, or reset returns a slot to an old identifier state | Temporal identity | Search for a trace where a former handle matches a new occupant; specify whether wrap is impossible, blocked, or handled by another epoch |
| F12 | A driver or native library directly reads or writes shared address space without using the dispatcher | Enforcement boundary | Attempt access outside the declared interface; if access succeeds, the component is trusted and must be in the TCB, or a concrete protection boundary is missing |

## 9. Architecture options and recommendation

R1 does not ratify a platform. It identifies the options and the evidence each would demand.

| Option | Security boundary | Benefits | Cost and unresolved burden | Assessment |
|---|---|---|---|---|
| **A. Typed single-address-space runtime** | Only code proved to stay within the language's rules is untrusted; native components are in the TCB | Preserves the intended unikernel and avoids protection-domain transitions | Compiler correctness, all unsafe code, drivers, runtime and build chain become central trusted assumptions; no protection against arbitrary native access to shared memory | Viable only with a narrow, explicit trust model; not sufficient if foreign code is adversarial |
| **B. Kernel-mediated software object capabilities with protected domains** | A trusted kernel or similarly isolated monitor owns capability state and mediates every protected operation | Clear object identity, rights checks, least-authority delegation and revocation semantics | Requires real protection domains; object table and dispatcher become security-critical; raw-memory and DMA paths remain separate obligations | A defensible software architecture where a protected kernel boundary exists |
| **C. Hardware capability compartments** | Hardware enforces tags, bounds and permissions at relevant accesses; software controls delegation and lifetime | Machine-level bounds and compartment transitions can protect against classes of unsafe pointer operations | Requires compatible hardware, compiler/ABI, memory allocator, cross-compartment entry mechanism, revocation, and DMA policy; hardware unforgeability is not type-level linearity | Strong candidate if a matching target is selected and the full proof boundary is addressed |
| **D. Generation handles without isolation** | A checked registry mediates object operations; memory itself remains shared | Straightforward stale-handle detection for mediated access | Does not contain native code with direct memory access; generation wrap, races and escape of pointers still matter | Suitable for a service API, not as the sole boundary against hostile native code |

**Recommendation:** before claiming effective authority for untrusted FFI or drivers, select a protection profile that makes bypass impossible or moves those components into the explicit trusted computing base. Given the shared-address-space description in current C4, Option A does not support adversarial native components. Options B and C need a concrete target and proof boundary; neither should be selected just because its vocabulary aligns with K7PL.

For a platform-independent intermediate step, define an abstract software-capability model in which every privileged operation is mediated, and prove the authority invariants and revocation contract in that model. Treat that work as a specification of the intended policy, not as a claim that the current same-address-space runtime can enforce it. Then compare a protected handle-table realisation with one concrete kernel- or hardware-capability platform.

## 10. Formal obligations for the next implementation stage

The following are candidate statements for a future formal model. Their names are research labels, not existing Lean theorems.

- **AUTH-01 — Invocation authority:** every successful privileged effect has a preceding invocation admissible under the caller's current rights and the target object's current state.
- **AUTH-02 — Attenuation:** delegation never increases the effective rights of the delegatee relative to the delegator.
- **AUTH-03 — Unique introduction:** two independently created live writing authorities for the same exclusive region cannot coexist unless the model explicitly partitions the region into disjoint parts.
- **AUTH-04 — Revocation closure:** after the declared completion point, no covered derived capability or queued operation can commit a new effect.
- **AUTH-05 — Lifetime safety:** no operation succeeds through a handle or memory capability after its target allocation has been reclaimed and reassigned.
- **AUTH-06 — FFI ownership:** every buffer crossing the boundary has one declared ownership mode, and every normal/error/cancel path preserves that mode's postcondition.
- **AUTH-07 — No authority laundering:** a service acting on behalf of a caller cannot use an ambient privilege that the caller did not supply or that the service policy did not explicitly authorise.
- **AUTH-08 — Device mapping closure:** after revocation acknowledgement, no covered device can access a reassigned buffer through the former mapping.
- **AUTH-09 — Composition:** the foregoing properties are preserved under parallel composition, delegation, callback/reentrancy, cancellation, object destruction and recovery.
- **AUTH-10 — Source-to-enforcement correspondence:** the static token or type rules correspond to the exact runtime/kernel/hardware checks claimed by the security argument.

At present, AUTH-01 to AUTH-10 should be treated as open. The current abstract resource-counting proof can potentially support part of AUTH-03 after its operational relation and premises are established; it does not discharge the other obligations.

## 11. Prioritised actions

| Priority | Action | Exit condition | Owner layer / follow-up |
|---|---|---|---|
| P0 | Select the trusted computing base and decide whether FFI/native drivers are adversarial | Each component has an explicit trust status; the security boundary is enforceable and testable | Architecture decision; R0/R2 |
| P0 | Define capability object, rights, possession, delegation, attenuation and destruction semantics | State model and well-formedness invariants are precise enough to formalise | Language/runtime/kernel model |
| P0 | Specify revocation semantics including in-flight calls and external effects | A linearisation/acknowledgement contract and all pending-operation cases are explicit | Runtime/kernel; R4 |
| P0 | Define FFI ownership modes and no-escape/lifetime rules | Each crossing has a complete contract for normal, error, cancellation and asynchronous use | Language and ABI; R2/R5 |
| P1 | Add operational rules for arena introduction/elimination and capability creation | H1 is a stated and provable property of the actual rules, not only an assumption of the theorem | Specification and Lean |
| P1 | Connect range arithmetic to physical regions and actual authority tokens | H2's abstract ranges correspond to unique regions and enforceable mappings | Compiler/runtime/memory manager |
| P1 | Define generation-handle validation and wraparound policy | Every mediated operation validates generation and target liveness; reset/recovery behaviour is specified | Runtime implementation |
| P1 | Choose the device access and DMA policy | MMIO, IRQ, DMA mapping lifecycle, quiescence and buffer reuse are defined for a selected platform | Kernel/hardware |
| P2 | Implement adversarial tests for F1–F12 as the relevant interfaces appear | Negative cases cover each enforceable boundary, with evidence scope recorded | Tests and model checking; R9 |
| P2 | Compare one protected software-capability profile and one hardware-capability profile | A source-grounded comparison of target, toolchain, revocation, TCB, proof scope and cost is complete | R8 and architecture decision |

Do not interpret successful compilation of MemoryCapability.lean as proof that a capability cannot be forged at an FFI boundary. Do not infer that every capability is revocable because one reference implementation offers a revoke operation. Do not infer that a hardware capability is linear. Each property has its own mechanism and proof obligation.

## 12. Sources and applicability limits

Sources below are first-party technical documentation. The retrieval date is 2026-10-23 unless a named release is specified.

1. **K7PL C4, Models of Memory**, current main snapshot. It labels the spatial-safety result as under review, records H1–H3, and leaves arena elimination as an obligation. [Source file](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/ModelesDeMemoire.lean).
2. **K7PL C4, Actor Scale**, current main snapshot. It describes the arena/region distinction, WriteCap partitioning and EntityRef index/generation layout; it is a specification source, not evidence that a runtime or hardware implementation enforces those claims. [Source file](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/spec/Spec/C4/EchelleDeLActeur.lean).
3. **K7PL MemoryCapability.lean and MemoryRange.lean**, current main snapshot. These state the scope and limitations of the abstract invariants. [MemoryCapability](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/src/K7pl/MemoryCapability.lean), [MemoryRange](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5/src/K7pl/MemoryRange.lean).
4. **seL4 API Reference**, current documentation retrieved on 2026-10-23. The documented CNode operations distinguish single-slot deletion, capability minting and revocation of derived children. Applicability: concrete kernel capability management, not K7PL's current same-address-space model. [API reference](https://docs.sel4.systems/projects/sel4/api-doc.html).
5. **seL4 Tutorials, Capabilities**, current documentation retrieved on 2026-10-23. Describes CNodes, CSpaces, object references and capability deletion/revocation. Applicability: illustrates a kernel-maintained capability-space design; it does not imply external effects or raw pointers are generally retractable. [Tutorial](https://docs.sel4.systems/Tutorials/capabilities.html).
6. **Genode OS Framework Foundations 25.05, Capability-based security**. Version: 25.05. Describes protection domains, kernel-maintained capability spaces, object identities, delegation and dependence on the concrete underlying kernel. Applicability: the documented mechanism requires an effective component protection boundary. [Documentation](https://www.genode.org/documentation/genode-foundations/25.05/architecture/Capability-based_security.html).
7. **CHERIoT RTOS, Architecture and FAQ**, repository documentation retrieved on 2026-10-23. Describes hardware capability semantics, compartment transitions, allocator duties and revocation before memory reuse. The repository's main branch may evolve; these links identify the architecture documentation, not a fixed release. Applicability: CHERIoT's specific hardware and software model only. [Architecture](https://github.com/CHERIoT-Platform/cheriot-rtos/blob/main/docs/architecture.md), [FAQ](https://github.com/CHERIoT-Platform/cheriot-rtos/blob/main/docs/faq.md).

These sources establish that the compared mechanisms exist and clarify their documented scope. They do not establish a K7PL-specific property. No K7PL runtime/kernel implementation, FFI contract checker, hardware capability target, dynamic revocation proof, or end-to-end device-mapping proof was found in the inspected sources.

## 13. R1 exit assessment

R1 provides an authority model, required invariants, a comparison of static/software/kernel/hardware mechanisms, revocation contracts, FFI ownership classes, device-access obligations, adversarial cases, candidate formal statements and a prioritised plan.

The blocking architectural question remains whether foreign/native code is trusted or adversarial. Under the current shared-address-space description, type-level linearity alone cannot contain arbitrary native access. Before the project claims effective authority across FFI, it must select an enforcement boundary and define the semantics of delegation, revocation and in-flight operations.

No normative specification change is made by this report. No capability, isolation, revocation, or FFI property is marked established.
