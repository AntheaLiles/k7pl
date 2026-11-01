<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# TLA+ candidate suite: interfaces, dependencies and limits

## Reading the suite

TLA-01..16 are separate bounded models with shared conceptual interfaces. They are run in one CI job, but they are not one composed transition system and they do not import one another. That separation is intentional: each model isolates an obligation and keeps its explicit-state search small enough to diagnose. A later integrated model must define a typed state relation and stuttering/transition correspondence; running independent models together is not composition or refinement evidence.

All modules are candidate, non-normative abstractions. The gate references below are deliberately not silently resolved by implementation choices.

## Conceptual dependency map

| Model | Shared interface | Depends on / feeds |
|---|---|---|
| TLA-01 session network | actor readiness, residual receive state, mailbox message lifecycle, static/dynamic wait edges | Base for TLA-02, TLA-03, TLA-04, TLA-14 |
| TLA-02 join patterns | message identity, channel/type/key compatibility, atomic multi-message consumption | Refines the mailbox vocabulary; G2 remains open |
| TLA-03 scheduler | runnable/waiting fibre states, per-fibre enabledness, explicit fairness profiles | TLA-08, TLA-10, TLA-12, TLA-13 |
| TLA-04 actor lifecycle | processed messages, journal prefix, snapshot cursor, restore/replay | TLA-05, TLA-11, TLA-13, TLA-15 |
| TLA-05 cancellation | accepted request, cancel request/ack, effect commit, timeout | Lifecycle and FFI failure paths; G5 remains open |
| TLA-06 foreign boundary | transferred capability, aliases, return, revoke, acknowledgement | TLA-07 and boundary-aware lifecycle; G6 remains open |
| TLA-07 memory capability | finite regions/cells, generation-tagged identity, capability ownership/revocation | TLA-08 shared-resource constraints; G7 remains open |
| TLA-08 parallel execution | branch-local steps and predecessor relation | TLA-09, TLA-11, TLA-12, TLA-16 |
| TLA-09 resource accounting | grade limits, per-fibre use counts, aggregate budget, abstract operation cost | TLA-10, TLA-12, TLA-13 |
| TLA-10 temporal scheduling | logical wait ticks, environment trigger, execution-cost budget | Scheduler and temporal-trigger obligations; G10 remains open |
| TLA-11 non-interference | paired runs, low observation, high trace projection | Journal and partial-order trace obligations; G8 remains open |
| TLA-12 reactive pipeline | event stream order, state/DOM versions, writer capability, frame counter | Integrates concepts from TLA-03, 08 and 09 |
| TLA-13 deductive job | finite closure relation, delta, budget, saturation and publication | Integrates scheduler/lifecycle/budget concepts |
| TLA-14 Noise profile | finite handshake phase and accepted/sent message sets | Conditional on adoption; G13 remains open |
| TLA-15 replica profile | grow-only-set state, outbound messages and delivery fairness | Conditional on a distributed profile; G12 remains open |
| TLA-16 SPSC queue | slot ownership, published/consumed messages, producer/consumer cursors | Concrete refinement remains gated by TLA-02/08 and G11 |

These are conceptual dependencies, not TLA module imports. No theorem transfers automatically between rows.

## Implemented bounded profiles

Every model has at least one nominal profile and one deliberately unsafe/negative profile. Additional controls cover retained caller aliases, generation wrap, stale access, capability revival, grade overuse and budget overdraw.

TLA-03's fair profile assumes weak fairness separately for each continuously enabled RunStep(f); its starvation-control profile explicitly enables a stall action. TLA-15's convergence property assumes a connected network and weak fairness for gossip and delivery actions. Neither assumption is a K7PL normative guarantee.

TLA-14 and TLA-15 are executable conditional profiles, not adopted library or distributed-runtime requirements. TLA-16 is only an atomic abstract queue; it says nothing about compiler reordering, cache coherence or release/acquire sufficiency.

## Evidence status

The file TLA02-16-ExpectedCounterexamples.json records authored expected negative-control scenarios. It is not TLC output. The CI artifact tla-model-check-evidence records D01 under d01/, R9 under r9/, and TLA-01..16 at the artifact root, including sources, configurations, authored expectations, per-profile logs, Java/TLC identity and checksums. The separate d01-tlc-evidence from k7pl-semantics.yaml is consumed by k-smoke. D01 is intentionally run twice: once as a blocking r9-tlc check and once to produce the reusable workflow artifact; eliminating the second run requires a verified artifact hand-off that preserves the gate and consumer. The first suite run must be reviewed for parser errors, invariant names, state-space completion and counterexample correspondence before statuses move beyond model-drafted.

No model establishes K/TLA+ or Lean/TLA+ correspondence, no result changes normative Verso text, and no TLC run is a proof for unbounded systems.
