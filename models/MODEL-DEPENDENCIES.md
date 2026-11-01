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

The file TLA02-16-ExpectedCounterexamples.json records authored expected negative-control scenarios. It is not TLC output. The CI artifact tla-model-check-evidence records D01 under d01/, R9 under r9/, and TLA-01..16 at the artifact root, including sources, configurations, authored expectations, per-profile logs, Java/TLC identity and checksums. The separate d01-tlc-evidence from k7pl-semantics.yaml is consumed by k-smoke. D01 is intentionally run twice: once as a blocking r9-tlc check and once to produce the reusable workflow artifact; eliminating the second run requires a verified artifact hand-off that preserves the gate and consumer. The first suite run (41305607506, on the pre-parser-fix head) matched 10/18 positive and 12/21 negative outcomes; 17 profiles did not reach a model verdict because of parser/semantic errors in six modules. Those source defects and the negative-result predicate were corrected on the PR branch. The corrected-head rerun remains a required gate; no profile status moves beyond model-drafted until its expected result is observed and its state-space evidence is reviewed.

The first end-to-end run 41305607506 on the pre-parser-fix head matched 10/18 positive and 12/21 negative outcomes; 17 profiles had no model verdict. The corrected-source run 41306284770 on head 29845511f018b80da543b975a995b477d4ba9cb4 matched 15/18 positive and 17/21 negative outcomes. The seven remaining failures were TLA-02 positive/negative (TypeOK evaluation error comparing string NoPairValue with a pair tuple), TLA-07 positive plus three negative profiles (parser error in WriteCell line 126), and TLA-12 positive (AdvanceFrame failed to specify frameOverrun). The current PR head contains later documentation and registry-test updates, but no full CI run has completed on it. These observations do not establish the current branch as green.

No model establishes K/TLA+ or Lean/TLA+ correspondence, no result changes normative Verso text, and no TLC run is a proof for unbounded systems.


## Current evidence snapshot — 2026-11-01

The live profile manifest on PR #319 head `a7a6d631f0c19876b0437276e6cd6e8bec79a3de`
contains 40 TLA-01..16 profiles (18 positive, 22 negative). This is an
inventory statement, not a checked outcome. The latest complete archive
inspected is run [41308633862](https://github.com/AntheaLiles/k7pl/actions/runs/41308633862)
on source SHA `dafbc608f8c94a97644f336286cc228e94d3d975`, with the prior
39-profile manifest: 16/18 positive and 17/21 negative profiles reached the
expected outcome. TLA-02 positive/negative failed CFG parsing; all four TLA-07
profiles failed parsing in `ValidCapabilitiesMatchGeneration`. Those sources
were corrected after this run. The new TLA-12 revocation profile and its
expected trace were also added after the run. None of those later changes has
current-head TLC evidence.

D01/R9 shell predicates, artifact checksums, TLC JAR pin, separate D01
artifact consumption by `k-smoke`, REUSE, CommitLint, actionlint, controller
shadow, Python tooling, Lean and Verso/PDF checks passed in run 41308633862
on SHA `dafbc608...`; the K semantics/Verso Blueprint job remained in progress.
The current CI run 41310176908 on `a7a6d631...` is pending with no jobs
created. The older K/Verso job in run 41308633862 remains in progress,
so no newer full CI verdict is available. No relation or theorem transfers
between independently modelled components by implication.


## Current source and execution evidence — 2026-11-01

The last complete 40-profile artifact inspected is run
[41310176908](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908)
on `a7a6d631f0c19876b0437276e6cd6e8bec79a3de`: 17/18 positive and 20/22
negative profiles reached their declared outcome. The three failures and all
state/depth/queue metrics are in `CHAPTER-COVERAGE.md` §4.7.1. TLA-02 is
repaired; all TLA-07 profiles parse, but one positive invariant fails and the
revocation-restore negative control is ineffective; TLA-12's negative profile
has an incomplete action. Commit `a173e227...` corrects these issues and adds
the JSON oracle to the existing CC0 REUSE annotation. Its run
[41311344952](https://github.com/AntheaLiles/k7pl/actions/runs/41311344952)
is pending with no jobs created at last observation. No evidence transfers
from the a7 run to the later source SHA.

On run 41310176908, Deno controller tasks fmt/lint/check/test passed (327
checks), Python tooling, Lean build and axiom audits, Verso specification and
PDF, D01 standalone TLC, CommitLint, actionlint, zizmor, gitleaks and OSV
checks passed. REUSE failed only on the unannotated JSON oracle; the fix is in
`a173e227...` and awaits rerun. K semantics compile/examples/Verso Blueprint
rendering remained in progress. The TLC archive had 116 entries and 115
verified SHA256SUMS entries; JAR SHA-256
`936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88`, uploaded
archive SHA-256
`3c6ab091887715f0cd38f3a2bf59570a929bfca8b1ad74cb6aa979e9b6135e1d`.
