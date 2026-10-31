<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# K7PL TLA+ workstream checkpoint

## Current repository state

- Repository: `AntheaLiles/k7pl`.
- Canonical model location: repository-root `models/`, kept flat.
- Replacement branch: `fix/tla-ci-unified-suite-2026-10-31`.
- Branch base: `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a`.
- Source corrections commit: `8e53ae99f187e86411aaa74f26a5c22d4991f1cc`.
- Unified CI/shadow commit: `7e48b0c0377f20cf71f3ecea50c00fcadb572b34`.
- The replacement branch has a clean first-parent history from `main`; commits use allowed Conventional Commit types (`fix`, `docs`). The previous branch's non-compliant commits are not ancestors of this branch.
- Superseded PR: [#318](https://github.com/AntheaLiles/k7pl/pull/318) is **closed** (not merged). Replacement PR: [#319](https://github.com/AntheaLiles/k7pl/pull/319) is **open as draft** on this branch. The old branch `research/k7pl-tla-workplan-2026-10-31` remains; the repository owner will delete it.
- `main` has not been changed or merged.

## Observed failures and root causes

The last fully inspected failure was [CI run #2410](https://github.com/AntheaLiles/k7pl/actions/runs/41238652081) on old head `47b910a5b8241cb77462b82a2247eb1eb3f9fe69`.

1. **TLC configuration parsing:** the first TLA-01 and TLA-02 profiles stopped in the TLC config parser with `ConfigFileException` (line 8 and line 7 respectively, “expecting ], but did not find it”). The `.cfg` files supplied function constructors such as `[x |-> y]`. The failure preceded module parsing and state exploration; it was not an invariant counterexample.
2. **CommitLint:** at least one old-branch commit used a type not allowed by the repository's Conventional Commit configuration. The replacement history starts from `main` and uses `fix(tla): ...` and `fix(ci): ...`; no old commit was cherry-picked as an ancestor.
3. **Controller Shadow:** the derived registry routed `models/` files to `tla_model_check`, but the legacy Python/Deno eight-key projection treated non-Markdown model files as unknown and forced `full`. A TLA-specific neutral path rule was added to both legacy classifiers. The derived classifier continues to emit the dedicated `tla_model_check` surface; shadow parity is asserted in tests.

## Corrections implemented on the replacement branch

- Replaced function-valued assignments in the affected TLA-01, 02, 04, 07, 08, 09, 12 and 13 configurations with finite scalar/set constants. Their deterministic selectors and relations are now module operators.
- Corrected TLA-05 `CommitEffect`: normal commit is allowed before cancellation acknowledgement; the negative control can commit after acknowledgement only when its unsafe switch is enabled. The previous condition contradicted itself by requiring both `Accepted` and `Cancelled`.
- Replaced the two separate TLA check sections with **one step covering TLA-01..16**.
- The unified step executes 18 positive and 21 negative profiles (39 in total), accumulates failures, and preserves an individual log per profile so one parse failure does not suppress later diagnostics.
- Replaced the two TLA evidence uploads with one `tla-model-check-evidence` artefact containing modules, configurations, authored expectations, individual logs, Java/TLC metadata and a SHA-256 manifest.
- Aligned Python and Deno legacy classifiers on `models/`, added classifier tests and removed TLA paths from the list of expected shadow divergences.

## Verification status

**The corrections above are committed but have not yet been validated by the new CI run.** No claim is made here that the modified TLA modules parse, that positive profiles complete, or that negative profiles produce their intended invariant failures. The previous run only established the configuration parser failure for the first TLA-01 and TLA-02 cases. The authored JSON counterexample vectors remain expectations, not observed TLC traces.

The controller shadow will be considered corrected only when the new run's Deno/Python shadow and derived-shadow logs show no divergence for `models/`, and the new unit tests pass. CommitLint will be considered corrected only when the new branch's commitlint job accepts the full new history.

TLA-01..16 remain candidate models with bounded/conditional scopes. The models are independent transition systems run by one common CI step; they are not composed into one transition system and do not establish K/TLA or Lean/TLA refinement.

## Current model allocation

| Model | Domain | Principal abstraction limit |
|---|---|---|
| TLA-01 | Asynchronous sessions, waits, messages, dependency graph, timeout | 2–3 actors and bounded messages; progress depends on environment assumptions |
| TLA-02 | Two-channel join and atomic consumption | Finite message set; rank-based choice remains exploratory |
| TLA-03 | Fibre scheduling and fairness | Small scheduler; fairness is profile-local |
| TLA-04 | Actor mailbox, snapshot, journal and replay | Snapshot persistence is assumed atomic |
| TLA-05 | Cancellation, acknowledgement, commit, timeout and retry | Linearisation contract remains open |
| TLA-06 | Foreign capability transfer and revocation | Logical handoff only; not a concrete ABI/FFI refinement |
| TLA-07 | Slots, identity generations, capability ranges and ownership | Logical memory model; no physical page or translation model |
| TLA-08 | Fork/join and partial-order causality | Finite two-branch DAG |
| TLA-09 | Abstract grade usage and integer resource budget | Scalar counters, not the full multidimensional grade algebra |
| TLA-10 | Waiting/triggering separated from execution cost | Discrete logical ticks; no physical time or WCET |
| TLA-11 | Paired low-observation traces | Value-level observer; no timing/cache/scheduler leakage |
| TLA-12 | Reactive event order, versions and DOM patch publication | Simplified queue and patch model; backpressure omitted |
| TLA-13 | Bounded deductive-job closure and result publication | Finite closure relation; does not prove general fixed-point theorems |
| TLA-14 | Abstract Noise-like handshake phases | Conditional profile; no cryptographic primitive or security proof |
| TLA-15 | Two-replica grow-only-set convergence | Connected/reliable/fair profile; no general partition model |
| TLA-16 | Two-slot abstract SPSC queue | Atomic visibility; no weak-memory/ISA refinement |

## Modelling gaps required to approach specification coverage

The current chapter matrix is mapped to the PR #311 snapshot (`f3b33cd34e1da49a4c8c41ca632c586e66715e70`). It is a chapter-level allocation, not a proof that every property in every chapter is covered. In particular, C4 `MemoryModels` currently addresses spatial safety, regions and capability lifetime; there is no explicit MMU/IOMMU contract identified in that allocation. MMU/IOMMU models are therefore classified below as implementation refinements until an exact normative Verso clause is identified.

### P0 — memory and hardware isolation

| Missing model family | Coverage to add |
|---|---|
| CPU MMU / virtual memory | Address spaces, page tables, map/unmap, permissions, page faults, copy-on-write, ASID/PCID reuse, per-core TLB, shootdown and acknowledgement, stale translation after revoke/remap |
| IOMMU / DMA | Device domains, IOVA, IOMMU/IOTLB and ATS caches, PASID, in-flight DMA, invalidation completion, device reset/hot-unplug and page reuse barriers |
| Physical page reclamation | Pin/unpin, CPU/device references, concurrent free/reuse, epochs/hazard pointers, ABA, migration and allocator metadata |
| Memory remanence | Zero-on-allocation/reuse, partial buffer initialisation, dirty cache/DMA buffers and cross-domain residual-data exposure |
| Shared permission algebra | Multiple readers, exclusive writer, fractional permissions, split/merge, borrows, aliases and concurrent revocation |
| Weak-memory refinement | Atomics, acquire/release, fences, CAS, coherence, tearing and compiler/CPU reordering for a named language/ISA |

MMU and IOMMU should be two separate protocols, connected through physical-page ownership and invalidation completion. The former models CPU-local TLBs and shootdown; the latter models device domains, IOVA translation, IOTLB/ATS caches and DMA already in flight. TLA+ can explore protocol obligations under explicit hardware assumptions, but cannot prove those assumptions about a particular processor, chipset, firmware or device.

### P1 — runtime concurrency and recovery

- Multi-core scheduling, interrupts, preemption, work stealing, priorities, lock contention, priority inversion and cancellation safe points.
- Actor spawn/destroy/restart, supervision trees, incarnation IDs, late messages to replaced actors and crash loops.
- Crash-consistent snapshots/journals: WAL, flush/barrier ordering, torn writes, partial recovery, journal compaction, inbox/outbox and idempotence.
- Concrete FFI/ABI layout, alignment, pointer provenance/aliasing, pinning, callbacks, reentrancy, unwind/panic and asynchronous callbacks after revocation.
- Device and driver lifecycle: reset, hot-plug, in-flight I/O, interrupt routing, driver replacement and asynchronous capability revocation.
- Distributed transport loss, duplication, reordering, partitions, membership/epoch, failure detection, quorum and retries.
- Full resource algebra/effect accounting using `𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅`, rather than the scalar abstraction in TLA-09.
- Physical clocks, drift, jitter, deadlines and timeout/cancellation races.
- Timing, resource, cache and scheduler side channels beyond TLA-11's value-only observations.
- A composed system model with explicit shared state and refinement relations between lifecycle, capabilities, queues and resource budgets.

### P2 — conditional integration services

- Reactive backpressure, bounded queues, coalescing/debounce, stale async results, cancellation and patch rollback.
- Cryptographic handshake properties such as nonce uniqueness, transcript binding, replay/downgrade and peer authentication; TLA-14 is not a cryptographic proof.
- Concurrent incremental compiler workers and cache invalidation only if such a service is actually implemented.
- OS capability lifecycle for files, networking, processes and devices where those interfaces are specified.

Not every chapter obligation should become a TLC model. C1 foundational postulates; C2 categorical laws, grade semirings and general fixed-point properties; C3 static typing, duality and general preservation/progress; C5 parsing, escaping, grammar and macro hygiene; and C6 compiler correctness/general termination need Lean proofs, parser/compiler testing or dedicated methods. Cryptographic hardness, WCET and physical hardware guarantees also require methods beyond finite TLC exploration.

Detailed coverage and package definitions are maintained in [CHAPTER-COVERAGE.md](CHAPTER-COVERAGE.md); proposed sequencing is in [WORK-PLAN.md](WORK-PLAN.md).

## Next actions

1. Open the replacement PR and close PR #318 as superseded; leave the old branch for the repository owner to delete.
2. Inspect every job on the new PR head: CommitLint; Python/Deno tests; Controller Shadow; TLC 39-profile step; REUSE and the other required CI checks.
3. For every negative profile, compare the actual TLC trace with its authored expectation. A parser/type/ASSUME failure must never count as a successful negative case.
4. Keep model statuses unchanged until the new run proves that the named profile reached the named invariant or completed state exploration.
5. Once the 39 profiles pass, review model completeness against the current Verso head, identify exact clauses not covered, and only then assign the next candidate model IDs.


## Audit complémentaire de Verso

La revue de sources a porté sur :
- `spec/Spec/C4/ModelesDeMemoire.lean` : sept niveaux de mémoire, de pointeurs tagués à mémoire linéaire WAT pour FFI/DMA, sûreté spatiale sous hypothèses H1/H2/H3 et profil de représentation Π.
- `spec/Spec/C4/EchelleDeLActeur.lean` : identité/durée de vie d'EntityRef après destroy/reuse/restore/génération épuisée, SoA/PIA, plages d'écriture disjointes, alignement 64 octets, placement NUMA, contrats Arrow/Cap'n Proto/MLIR et déduplication.
- `spec/Spec/C4/EchelleDuSysteme.lean` : snapshot/journal/rejeu, journalisation de l'horloge et de l'aléa, file concurrente release/acquire, progrès sous équité mémoire, reprise d'acteur, CRDT, graphe de dépendances statique vs wait-for dynamique, et progrès global.
- `spec/Spec/C4/CalculDeProcessusSousJacent.lean` : simulation complète source→métalangage, conservation des événements et de l'ordre causal, canal de temps, tick et When ; les clauses de traduction restent explicitement incomplètes.
- `spec/Spec/C3/LeSystemeGradue.lean` : ReadCap/WriteCap, partage de lecture sans WriteCap concurrent, destinations strictement Lin, âges décroissants, capacités transversales et CRDT.
- `spec/Spec/C7/EtudeDeCasIArchitectureReactiveNative.lean` et `EtudeDeCasIIIMoteurDeductifSurArenes.lean` : pipeline UI, coût par image, et clôture monotone semi-naïve ; négation stratifiée explicitement non traitée.

L'audit détaillé se trouve dans `CHAPTER-COVERAGE.md`. Il met en évidence des obligations non réductibles à MMU/IOMMU : ReadCap/WriteCap, NUMA/alignement/placement, mémoire faible release/acquire, complétude du journal, progression globale, couverture exhaustive des motifs de jonction, simulation des constructeurs du calcul de processus, canal temporel/When, moteur réactif complet, pipeline déductif semi-naïf, imports sandboxés et pipeline de compilation.

**MMU/IOMMU :** les sections Verso examinées mentionnent FFI/DMA, mais ne définissent pas de contrat matériel MMU/IOMMU. Ces deux modèles sont classés comme raffinements d'implémentation proposés, et non comme garanties normatives nouvellement ratifiées.


### Obligations C4/C3 supplémentaires relevées lors de la revue

- La sûreté spatiale conditionne le résultat à H1/H2/H3 : unicité d'introduction de `WriteCap` par région (avec une obligation encore ouverte sur l'élimination de l'arène), adéquation entre intervalles et régions, et non-capture des capacités linéaires par les valeurs cartésiennes. TLA-07 n'établit pas ces lemmes de typage.
- Le partage des canaux est distinct du partage en lecture de la mémoire et reste explicitement non tranché dans C3 ; TLA-02 ne modélise pas l'emprunt ni le partage de propriété d'un canal.
- `Import` (fichier, URL, modèle de langage), macros exécutées avant vérification et capacités exportées par FFI constituent une frontière de confiance dont le contrat de réalisation reste ouvert. TLA-06 ne couvre pas cette sandbox ni les callbacks réentrants. Un modèle séparé ne doit être lancé qu'après définition du profil de confinement.
