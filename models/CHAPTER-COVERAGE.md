<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Specification coverage and TLA+ allocation

**Current specification baseline:** `main` at `2fbf609f6f3e67ffe011a3f28fd247526684155a` (reviewed 2026-11-01).  
**Status:** living documentary model-coverage matrix; proposed coverage, not normative ratification. The theorem/gap classification itself remains in `wiki/assurance.md`. Remediation urgency P0–P4 is tracked separately in [REMEDIATION-ROADMAP-P0-P4.md](REMEDIATION-ROADMAP-P0-P4.md).

## 1. Chapter-level matrix

| Chapter | Relevant commitments | Proposed TLA+ work | TLA+ necessity |
|---|---|---|---|
| C1 — Prolegomena | Germinal postulates, normative vocabulary and foundational commitments | No standalone model. Instantiate each property only when a later chapter gives it states and transitions. | Not needed directly |
| C2 — Categorical foundations | Graded resources, budget consumption, effect composition, parallel effects, actors, bounded activation, `yield`, fixed points | TLA-03 for scheduler/productivity scenarios; TLA-09 for dynamic resource and budget accounting; TLA-13 for a deductive-job protocol only | Partial |
| C3 — Type theory | Asynchronous session types, mailbox semantics, protocol duality, deadlock theorem, capabilities, resource grades and effects | TLA-01, TLA-02, TLA-07 and TLA-09 | Necessary for dynamic behaviours; not for static typing laws |
| C4 — Automata theory | Actor state, memory regions, actor topology, mailbox and join semantics, scheduling, partial-order traces, cancellation, replay, FFI and operational transitions | TLA-01 through TLA-11, plus TLA-14 through TLA-16 where the selected profile requires them | Main TLA+ coverage |
| C5 — Syntax and practice | Lexical classes, delimiters, layers, trains, macros, elaboration and syntax stability | No dedicated TLA+ model. Use parser tests, grammar analysis and Lean proofs. | Not needed |
| C6 — Compilation and verification | Compilation phases, solver obligations, monomorphisation, finite specialization budget and pipeline stabilization | No model for the static pipeline by default. A separate model may be justified only if an implemented compilation service introduces concurrent caches, workers or cancellation. | Not needed for current commitments |
| C7 — Practical integration | Reactive interface, interactive development/replay debugger, deductive engine | TLA-12 and TLA-13; optional profiles TLA-14 and TLA-15 | Scenario-level |
| Annex A | Summaries of protocol, session, capability, memory, productivity and termination requirements | Cross-reference the corresponding work items; do not create duplicate models merely because an annex repeats a chapter commitment. | Inherited |

The groupings in WORK-PLAN.md describe model families, not remediation priority. The audit-remediation scale P0–P4 is defined only in REMEDIATION-ROADMAP-P0-P4.md; it is proposed sequencing guidance and does not alter the normative roadmap.

## 2. Detailed mapping

### C1 — Prolegomena

No standalone transition system is justified merely by the foundational or categorical vocabulary. TLA+ should not be used to restate axioms that contain no operational state or temporal property.

A later model may instantiate a C1 commitment, but its normative home remains the relevant chapter and its proof obligation must be stated at that later level.

### C2 — Categorical foundations

| Specification area | Candidate obligation | Work item | Preferred method |
|---|---|---|---|
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | Actor consumes messages, evolves state and is bounded by grades per scheduling turn; `yield` advances productive streams | TLA-03 | TLA+ / TLC for scheduler scenarios; Lean for general coalgebraic and productivity claims |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | Cost and budget composition, partial `Consume`, parallel effect action | TLA-09 | Lean for algebraic laws; TLA+ for finite operational accounting scenarios |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | Static topological-order result and capacity lemma | No independent model; relate to TLA-01/TLA-07 if an execution scenario is needed | Lean and static graph algorithms |
| `spec/Spec/C2/AdjonctionsEtEnrichissement.lean` | Grade-factorisation and order laws | No direct TLA+ model | Lean |

The existence and termination of a least fixed point, monotonicity, grade algebra and adjunction laws are not model-checking tasks. TLA-13 concerns the execution protocol of one deductive job, not a replacement proof of the general fixed-point theorem.

### C3 — Type theory

| Specification area | Candidate obligation | Work item | Preferred method |
|---|---|---|---|
| `spec/Spec/C3/LesContraintesDeValeur.lean` — asynchronous sessions | Dual endpoints do not guarantee message delivery or progress; static dependency DAG must constrain dynamic wait graph | TLA-01 | TLA+ / TLC; Lean for the general simulation theorem |
| `spec/Spec/C3/LesContraintesDeValeur.lean` — `thm:deadlock_acyclique` | Relate static dependencies to dynamic waits, including `Guard`, message send/consume, residual mailbox types and `Timeout` | TLA-01 | TLC counterexamples and finite models; Lean for general proof |
| `spec/Spec/C3/LesContraintesDeValeur.lean` — session communication | Type-correct asynchronous protocols and residual states | TLA-01 | TLA+ / TLC for reachable executions; Lean for duality and typing |
| `spec/Spec/C3/LeSystemeGradue.lean` | Linear write capabilities, concurrent readers/writers and fractional grades | TLA-07, TLA-09 | TLA+ finite resource protocols; Lean for static grade guarantees |
| `spec/Spec/C3/GrammaireDesTermes.lean` and `spec/Spec/C3/ReglesDeTypage.lean` | Parallel composition, `wait`, `when`, `at`, grades and effects | TLA-03, TLA-08, TLA-09, TLA-10 | TLA+ for runtime behaviour; Lean for typing/effect laws |
| `spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean` | Pure handlers and journal inputs | TLA-04, TLA-11 | TLA+ for replay/observation scenarios; Lean for functional correctness |

TLA+ must not become a duplicate type checker. Protocol duality, grade algebra, subtyping and static derivability stay in the static formalisation and proof layer. TLC should challenge the behavioural conclusions that are not implied by endpoint typing alone.

### C4 — Automata theory

C4 is the primary TLA+ target because it defines system states, process transitions, mailboxes, traces, scheduling and environment interactions.

| Specification file / section | Obligation or mechanism | Work item |
|---|---|---|
| `spec/Spec/C4/EchelleLocale.lean` | Bounded stack and finite protocol sequences | TLA-14 only if Noise is an adopted integration profile; the R-expression parser itself is not a TLA+ target |
| `spec/Spec/C4/EchelleDeLActeur.lean` | Private actor state, actor transitions, fibres, partitioned regions, entity identity and generation | TLA-07, TLA-08 |
| `spec/Spec/C4/ModelesDeMemoire.lean` | Spatial safety, region disjointness, capability introduction and lifetime | TLA-07; Lean remains primary for general memory-safety theorems |
| `spec/Spec/C4/EchelleDuSysteme.lean` | Actor lifecycle, activation, deactivation, snapshot, journal and replay | TLA-04 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | Failure, cancellation, recovery and restoration paths | TLA-04, TLA-05, TLA-06 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | Static dependency DAG versus dynamic wait graph; actor scheduling and initialization | TLA-01, TLA-03 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | Multi-message join patterns and atomic consumption | TLA-02 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | SPSC mailbox and acquire/release implementation refinement | TLA-16 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | FFI transfer, error paths, foreign aliases and revocation | TLA-06 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | CRDT replication and eventual convergence after partitions | TLA-15, conditional on a distributed profile |
| `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | Process calculus, communications, cuts, join patterns and actor translation | TLA-01, TLA-02, TLA-08; K-to-TLA correspondence is a separate obligation |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | Global pool progress, fork/join, parallel transitions and partial-order traces | TLA-03, TLA-08 |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` — `thm:correction_ressource` | Instrumented execution counter and effective usage bound | TLA-09 as bounded exploration; Lean for the theorem |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` — temporal forms | `at`, `wait`, `when`, `delay` and the separation of environmental waiting from execution cost | TLA-10 |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` — `thm:stratification_journal` | Replay projection by security level and influence on later control | TLA-11 |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` — `thm:preservation`, `thm:progres` | Transition-level safety and global progress | TLA-03, TLA-08; Lean remains primary for the general metatheorems |
| `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean` | Trace order, session relation and level-indexed observation | TLA-01, TLA-08, TLA-11 |
| `spec/Spec/C4/CeQueChaquePreuveOuverteYPuise.lean` | Inventory of open proofs | Cross-reference model evidence; do not create a model solely for the inventory |

Several statements in C4 are marked `under-review` with `proofsketch`. Their presence in Verso is not a checked Lean proof. A model may help sharpen the statement or find a counterexample, but it cannot be recorded as closing the proof obligation.

### C5 — Syntax and practice

The grammar of symbolic expressions, delimiter rules, lexical classes, macro expansion, trains and elaboration are not state-space protocol problems. The appropriate work includes parser implementation, layer-check tests, grammar analysis and Lean proofs of elaboration or syntax properties.

TLA+ is not assigned to:
- lexical tokenisation or escape processing;
- delimiter balancing and reader recovery;
- static name resolution;
- macro-expansion hygiene;
- equivalence of surface and core syntax.

A future interactive editor service could have its own concurrency model, but that would model the service's request lifecycle, not the normative grammar.

### C6 — Compilation and verification

The compilation phases and monomorphisation budget are primarily static algorithms and termination obligations. Lean, solver contracts and compiler tests are the preferred tools.

Do not create a TLA+ model for:
- EBNF or parser phases;
- a static solver's constraint logic;
- static type inference;
- the general termination proof of monomorphisation;
- a finite topological sort of the compilation dependency graph.

A separate model becomes justified if an implemented compiler service introduces concurrent workers, shared caches, task cancellation or transactional publication of compiled artefacts. No such commitment is assumed here.

### C7 — Integration case studies

| Case study | Candidate property | Work item | Scope |
|---|---|---|---|
| I — Native reactive architecture | Event intake, state update, diff, DOM patch publication, exclusive write capability and frame lifecycle | TLA-12 | Scenario model; not a WCET proof |
| II — Interactive development and library | Complete journal, replay, pause/step debugger and consistent observable state | TLA-04, TLA-11 | Derived from C4 lifecycle and trace models |
| III — Deductive engine on columnar arenas | Job lifecycle, iterative saturation, budget exhaustion and publication only after convergence | TLA-13 | Scenario model; Lean proves generic fixed-point properties |

### Annex A

Annex A summaries should point to the same model identifiers as the main chapter. They do not create a second source of truth or a second copy of a protocol model.

## 3. Explicit non-targets

The programme deliberately does not assign TLA+ as the primary tool for:

- categorical laws, adjunctions, comonads or algebraic fixed-point theorems;
- static typing, subtyping, grade algebra or proof of session duality;
- lexical or syntactic parsing;
- the generic termination proof of pure layer-3 terms;
- source-to-binary compiler correctness;
- cryptographic collision resistance;
- physical memory isolation, hardware barriers or measured latency;
- a numerical WCET proof.

These may be assumptions or refinement targets of a model, but their proof obligations belong to other methods.


## 4. Gaps beyond the current TLA-01..16 allocation

This section is a research register, not a claim that every item below is already a normative K7PL requirement. The chapter matrix above maps the current TLA allocation against the PR #311 specification snapshot. A gap becomes a normative model obligation only after its state, transition and guarantee are traced to a current Verso clause. In particular, the current C4 `ModelesDeMemoire` allocation describes spatial safety, regions and capability lifetime; it does not establish a hardware MMU or IOMMU contract.

### 4.1 Memory isolation and implementation refinement

| Proposed modelling package | Missing state and transitions | Central property to investigate | Current gap |
|---|---|---|---|
| CPU virtual memory / MMU | Address spaces; page-table levels and entries; map/unmap; permission changes; page faults; copy-on-write; ASID/PCID allocation and reuse; per-core TLB entries; shootdown messages and acknowledgements | A revoked or remapped page cannot be accessed through a stale CPU translation; physical-page reuse waits until all relevant invalidations have completed | TLA-07 models logical slots/generations/capabilities, not translation caches or address spaces |
| Device translation / IOMMU | Device-to-domain assignment; IOVA mappings; IOMMU page tables; IOTLB and device ATS caches; PASID; in-flight DMA; invalidation and completion; reset, hot-unplug and device reassignment | No stale translation or in-flight DMA can access a page after revocation or after it is reassigned to another protection domain | No current model contains devices, DMA operations, IOVA translation or device-cache invalidation |
| Physical page lifecycle and reclamation | Physical-page allocation/free/reuse; pin/unpin; CPU and device references; reference counts; epoch/hazard reclamation; page migration; ABA and allocator metadata | A page cannot be reused while any CPU, device or asynchronous operation can still hold an effective reference to its previous owner | TLA-07 bounds logical generations, but does not model concurrent physical reclamation or outstanding references |
| Initialisation and cross-domain remanence | Zero-on-allocation or zero-before-reuse; dirty cache lines; DMA buffers; partial initialisation; abandoned pages; crash/restart of an owner | A new protection domain cannot observe residual data from a previous owner, including through an incompletely initialised DMA buffer | No current model tracks payload contents across physical ownership changes |
| Shared-memory permission algebra | Multiple readers; exclusive writers; fractional read permissions; split/merge of permissions; borrow lifetimes; alias creation; overlapping mappings; concurrent revocation | Permission composition never creates incompatible writes or allows a revoked alias to remain effective | TLA-07 only checks finite disjoint logical write ranges; TLA-09 uses scalar use counts, not the full grade algebra |
| Concrete atomics and weak-memory refinement | Atomic read/write/CAS; relaxed/acquire/release; fences; coherence; tearing; compiler and CPU reordering; per-core observations; queue payload publication | The concrete queue and capability protocols refine the abstract happens-before and publication rules under a named language/ISA memory model | TLA-16 assumes atomic transitions and does not represent weak-memory executions |

**MMU and IOMMU must be separate transition systems.** They interact through physical-page ownership and completion of invalidation, but their agents and caches differ. The CPU/MMU model should include a per-core TLB and a shootdown completion protocol. The IOMMU model should include device domains, IOVA translations, IOTLB/ATS caches and DMA already in flight. Both need explicit hardware assumptions; TLC can find protocol counterexamples under those assumptions, but cannot prove that a specific CPU, chipset, firmware or peripheral implements them correctly.

### 4.2 Runtime concurrency, failure and semantic completeness

| Proposed modelling package | Missing state and transitions | Why the current allocation is insufficient |
|---|---|---|
| Multi-core scheduler and preemption | Per-core run queues, work stealing, priority classes, preemption, interrupts, deferred work, lock contention, priority inversion, cancellation safe points | TLA-03 uses a small fibre scheduler and profile-local fairness assumptions |
| Actor supervision and incarnation lifecycle | Spawn/destroy, restart policies, supervision trees, actor incarnation IDs, late messages to a restarted actor, restart loops | TLA-04 models mailbox/snapshot/replay of one abstract actor, not supervision topology |
| Crash-consistent storage and transactions | WAL ordering, flush/barrier completion, torn writes, partial snapshots, journal compaction, inbox/outbox deduplication, atomic publication | TLA-04 assumes atomic snapshot persistence; its journal is an in-memory abstract sequence |
| Concrete FFI/ABI boundary | Layout/alignment, pointer provenance and aliasing, pinning, callbacks and reentrancy, unwind/panic, async callbacks after return/revoke, thread affinity | TLA-06 models logical capability handoff and acknowledgement, not an ABI or concrete runtime |
| Device and driver lifecycle | Device discovery, reset, hot-plug, driver replacement, capability grant/revoke, in-flight I/O, interrupt routing, fault reporting | The IOMMU candidate must be complemented by driver/device ownership and failure transitions |
| Distributed transport and membership | Loss, duplication, reordering, partitions, membership/epochs, failure detection, quorum/election, retries, reconciliation | TLA-15 is a two-replica connected-network G-set profile with conditional fairness, not a general unreliable transport |
| Resource algebra at execution time | The product `𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅`; grade composition; effect composition; parallel split/join; fractional sharing; capability transfer; refunds/settlement; overflow and cancellation accounting | TLA-09 checks a scalar count and abstract integer budget only |
| Temporal runtime guarantees | Logical/physical clock relation, drift, jitter, deadlines, timer cancellation races, queueing latency, simultaneous triggers | TLA-10 uses bounded logical ticks and makes no physical latency or WCET claim |
| Non-interference beyond values | Timing, resource-consumption, cache contention, scheduler choices, termination/control-flow channels, declassification and attacker observation model | TLA-11 checks paired low-value traces; it omits timing and microarchitectural channels |
| Full session progress assumptions | Fair message delivery, bounded/unbounded queues, timeout cancellation semantics, retries and duplicate handling, external actor failure | TLA-01 is a bounded topology model; progress depends on assumptions that are not fully represented by endpoint duality |
| Cross-model composition | Shared typed state, ownership transfer between lifecycle/capability/queue/resource models, stuttering and refinement relation | The sixteen models currently execute independently; conceptual dependencies are not a composed system proof |

### 4.3 Conditional services and integration

| Proposed modelling package | Missing state and transitions | Activation condition |
|---|---|---|
| Reactive backpressure | Bounded event queues, overload, coalescing/debounce, dropped events, stale asynchronous responses, cancellation and patch rollback | Expand only if the C7 reactive runtime contract requires these guarantees |
| Cryptographic handshake and channel security | Nonce uniqueness, transcript binding, replay/downgrade, peer authentication, key confirmation and compromise assumptions | TLA-14 is only a finite protocol-phase abstraction; use a cryptographic verification method for security properties |
| Concurrent compilation service | Concurrent workers, incremental cache invalidation, task cancellation, stale build results and atomic artifact publication | Only if implementation actually introduces a concurrent compiler service |
| OS resource capability protocols | File/network/process/device handle lifecycle, delegation, revocation, close races and asynchronous I/O completion | Model only interfaces included in the specified execution environment |

### 4.4 Properties that should not be turned into artificial TLC models

The following are real coverage obligations, but they normally belong to another formal method:

- C1 postulates and foundational vocabulary: formalise or discharge by the relevant logical/metatheoretic method, not by inventing an operational automaton without transitions.
- C2 category theory, adjunctions, comonads, grade semirings, monotonicity and general fixed-point existence: Lean proofs, with TLC only for finite operational scenarios.
- C3 static typing, subtyping, session duality and general preservation/progress: Lean metatheory; TLC challenges dynamic assumptions and counterexamples but does not replace the proofs.
- C5 lexical analysis, escaping, delimiters, grammar, macro hygiene, expansion and elaboration: parser/compiler tests and Lean-level formalisation.
- C6 compilation correctness, static solver correctness and general termination of specialisation: Lean proofs, compiler validation and differential tests.
- Cryptographic hardness and primitive security: a dedicated cryptographic model/analysis; a finite TLA state machine cannot establish computational security.
- Real-time WCET and hardware isolation: target-specific measurement, architecture evidence and implementation refinement are required in addition to abstract models.

The package groupings in this section are descriptive coverage categories, not P0–P4 urgency labels. Each future package needs a named source clause, explicit assumptions, abstraction relation, positive profile, negative control and evidence plan before it is assigned a TLA identifier.


## 4.5 Audit explicite des obligations Verso (révision main 2fbf609)

Cette section distingue les propriétés écrites dans la spécification, les choix de réalisation et les obligations qui relèvent d'une autre méthode que TLC. La présence d'un sujet technique dans le texte ne suffit pas à le transformer en garantie matérielle.

| Source Verso | Obligation ou choix explicitement formulé | État de la modélisation courante | Travail manquant |
|---|---|---|---|
| C4, `EchelleDeLActeur`, § EntityRef | Une référence périmée ne doit jamais accéder à une autre entité, y compris après destruction, réutilisation de slot, restauration et épuisement/réinitialisation des générations | TLA-07 teste un petit domaine de générations et plusieurs contrôles négatifs | Ajouter restauration, épuisement, reset, incarnation et réallocation concurrente ; les bornes finies ne prouvent pas un tag matériel sans wrap |
| C4, `EchelleDeLActeur`, partition d'arène | Segments SoA statiquement disjoints, alignés sur 64 octets, placés sur le nœud NUMA local ; éviter le faux partage | TLA-07 possède deux plages logiques disjointes, sans adresses physiques ni NUMA | Modèle d'allocation/placement et preuve de correspondance régions logiques ↔ plages physiques ; tests de layout et mesures du faux partage |
| C3, `LeSystemeGradue`, partage de lecture | Plusieurs `ReadCap` peuvent coexister ; aucune `WriteCap` vivante tant qu'une image cartésienne de lecture subsiste ; le partage n'est pas une division fractionnaire de `WriteCap` | TLA-07 ne couvre que l'exclusivité des plages d'écriture | Modèle ReadCap/WriteCap avec création/retrait de lecteurs, conversion et révocation ; preuves de l'adjonction et du solveur en Lean |
| C4, `EchelleDeLActeur`, disposition Arrow/Cap'n Proto/MLIR | Domaine exact du zéro-copie pour scalaires fixes ; largeur, alignement, ordre des champs, bitmap, endianness et version de schéma ; transposition des structures | Aucun TLA ; ce n'est pas d'abord une propriété de protocole concurrent | Vérification de layout à la compilation, tests différentiels et preuve de correspondance par profil Π ; ne pas présenter le zéro-copie comme général |
| C4, `EchelleDuSysteme`, file concurrente et modèle mémoire | Release/acquire pour mémoire partagée intra-instance ; barrières suffisantes ; progrès dépendant potentiellement de l'équité de propagation mémoire | TLA-16 vérifie une SPSC abstraite sous transitions atomiques ; il n'établit ni le modèle mémoire faible ni le raffinement ISA | Modèle par cœur des vues mémoire, publication/consommation et barrières ; liveness sous hypothèse d'équité mémoire ; tests/raffinement sur ISA nommée |
| C4, `EchelleDuSysteme`, journal et rejeu | Journal complet des entrées non déterministes (horloge, aléa, environnement), substitution à la relecture et égalité observationnelle ; identité binaire seulement sous profil reproductible Π/Erepro/Hrepr | TLA-04 couvre snapshot/journal/replay cursor, pas les sources externes ni les obligations de représentation | Modèle d'enregistrement/rejeu complet, trous de journal, appel de capacité, crash pendant append/flush ; séparer rejeu logique, identité binaire et rejeu stratifié |
| C4, `EchelleDuSysteme`, reprise d'acteur | Le redémarrage dépend de l'ordonnanceur, du superviseur, des ressources et de la conservation d'état | TLA-04 est un cycle isolé d'acteur | Modèle de superviseur, ressources indisponibles, politique retry/restart, crash loops et progress global |
| C4, `EchelleDuSysteme`, topologie | DAG statique de dépendances ; graphe d'attente à l'exécution distinct ; l'acyclicité seule ne garantit ni terminaison des initialiseurs ni progrès global | TLA-01 couvre un graphe et un wait-for fini très réduit | Modèle séparant compilation/topological initialization, attente dynamique, external wait et scheduler fairness ; relation entre attentes et arêtes statiques à prouver |
| C4, `EchelleDuSysteme`, jonctions | Atomicité de consommation ; couverture des combinaisons admissibles et rejet à la compilation des combinaisons non couvertes dans le profil exhaustif | TLA-02 vérifie un motif à deux canaux et une sélection par rang exploratoire | Générateur de combinaisons finies, exhaustivité du motif, ambiguïtés/priorités et sémantique d'appariement ; le classement par rang ne constitue pas une politique ratifiée |
| C4, `CalculDeProcessusSousJacent` | Simulation source→métalangage sur configuration complète, état d'arène et traces ; conservation de l'ordre causal, substitution et constructeurs avec effets | Les TLA sont des modèles autonomes ; ils ne constituent pas cette simulation | Clauses K pour chaque constructeur, relation typée `R_cfg`, preuve Lean de simulation et conservation des événements ; plusieurs constructeurs (copatron, récupération, parallèle, découpe, couche 2) restent explicitement sans clause de traduction |
| C4, processus temporel | Canal linéaire de temps, `tick`, ordre causal, `When` et observation de latence dont le carrier/type n'est pas ratifié | TLA-10 sépare attente logique et coût d'exécution sans établir la traduction complète | Modèle des transitions When/tick et des courses déclenchement/annulation/timeout ; conserver l'ordre causal sans imposer un ordre total aux fibrilles indépendantes |
| C3, ressources et effets | Produit complet des ressources `𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅`, partage cartésien, transferts, effets gradués et produit d'effets non commutatif | TLA-09 emploie des compteurs et un budget entiers simplifiés | Formalisation de l'algèbre et lemmes Lean ; scénarios TLC seulement pour les transitions concrètes de split/join, partage et règlement |
| C3, destinations | `Dest` strictement linéaire, remplissage unique, âges `Lin_k` décroissants, absence de cycle et finalisation sans lecture non initialisée | Aucun modèle TLA dédié | Preuves de typage/terminaison et tests du constructeur ; un petit modèle de protocole de remplissage serait complémentaire, pas une preuve générale |
| C7, architecture réactive | Événement L1 → flux L2 → X-expression pure → diff L3 → patches → DOM L1 ; aucune capacité DOM en L2 ; cadence d'image soumise à budget de coût distinct | TLA-12 vérifie l'ordre de quelques événements, la version et la capacité d'écriture DOM | Modèle complet du commit de frame, backpressure, patch partiel/rollback, événements périmés, budget par frame et interaction avec le flux temporel ; validation WCET/profile distincte |
| C7, moteur déductif | Clôture monotone, arène pré-dimensionnée au pire cas, append O(1), évaluation semi-naïve séparant faits nouveaux/anciens | TLA-13 suit une fermeture finie et sa publication | Ajouter deux générations de faits, capacité de l'arène, dépassement du nombre de tours, annulation et mesures de localité ; la négation stratifiée est explicitement absente de la spécification et ne doit pas être supposée prise en charge |
| C7, développement interactif | Complétion par narrowing et replay debugger fondé sur un journal complet | TLA-04 ne modélise pas le debugger et TLA-13 ne modélise pas l'élaboration interactive | Tests du service de complétion ; modèle d'interface de rejeu/pause/step seulement si les garanties d'outil sont spécifiées |
| C6, pipeline de compilation | Huit ordres de vérification, phases 1.5/2.5, boucle Phase 5/6 jusqu'à stabilisation sous budget fini ; provenance des imports | TLA-13 modélise un job déductif, pas le compilateur complet | Automate de pipeline et des itérations/annulations si le service est concurrent ; preuve Lean de décroissance/stabilisation ; traçabilité de provenance des imports |
| C3/C6, import et frontière étrangère | Sources importées et interfaces FFI exécutées sous autorités et effets contrôlés ; provenance journalisée ; aucun accès ambiant aux états protégés | TLA-06 modélise une capacité logique transférée à un appel étranger, pas l'import au compile-time ni les callbacks réentrants | Modèle de sandbox d'import, capacités effectives, échec/timeout, callbacks/reentrance, unwind, pointeurs et durée de vie ABI |

### Interprétation MMU/IOMMU

Dans les fichiers Verso audités, le niveau 7 de mémoire mentionne explicitement la mémoire linéaire WAT et l'interfaçage physique brut, notamment FFI et DMA. En revanche, aucun contrat MMU ou IOMMU explicite n'a été identifié dans les sections examinées. Les modèles CPU/MMU et IOMMU/DMA sont donc, à ce stade, des **modèles de raffinement d'implémentation proposés**, nécessaires avant toute revendication d'isolation matérielle, mais pas des garanties K7PL nouvelles.

Le modèle MMU doit représenter espaces d'adressage, tables de pages, TLB par cœur, ASID/PCID, map/unmap, permission changes, shootdown et acknowledgements. Le modèle IOMMU doit représenter affectation device/domain, IOVA, IOTLB/ATS, PASID, DMA en vol, invalidation et reset/hot-unplug. Les deux communiquent par l'ownership et le cycle de vie des pages physiques ; ils doivent rester deux systèmes de transitions séparés car leurs agents et caches ne sont pas les mêmes.

Pour chaque paquet futur : référence à une clause Verso exacte, statut (normatif ou raffinement), hypothèses, état/transition, invariants positifs, contrôle négatif, trace attendue, borne de modèle et résultat d'outil. Aucun nouvel identifiant TLA ne doit être attribué avant ce rattachement.


### 4.6 Premises de sûreté et frontière d'import : obligations ouvertes à ne pas masquer

Le théorème C4 de sûreté spatiale par capacités linéaires est marqué `under-review` et son énoncé dépend de trois prémisses distinctes (H1–H3). Elles ne doivent pas être déclarées « couvertes » par TLA-07 :

- **H1 — introduction unique de `WriteCap` par région.** Le texte rattache la propriété à la consommation linéaire de l'arène ou de la capacité découpée par `Slice`. Il signale toutefois que le cas d'élimination de l'arène reste à écrire/justifier et que l'hypothèse de linéarité de cette allocation subsiste au niveau du module. Il faut fermer cette règle et prouver l'unicité d'introduction dans le système de typage ; un modèle de protocole d'allocation n'en serait qu'un complément.
- **H2 — portée des régions.** La disjonction des intervalles doit impliquer que les capacités désignent des régions réellement distinctes. Le texte donne un argument par arithmétique d'intervalles ; il reste à rattacher formellement les indices aux segments de l'arène et à leur réalisation mémoire.
- **H3 — non-capture entre modes.** Aucune fermeture cartésienne, tuple, substitution ou conversion ne doit capturer une capacité linéaire. Le contrôle syntaxique des délimiteurs est nécessaire, mais ne remplace pas la preuve de métathéorie couvrant tous les constructeurs et frontières de couche.

**Partage de canaux.** C3 distingue explicitement le partage en lecture d'une région du partage d'un canal et laisse ouverte la question de savoir si l'emprunt d'un canal suit la même adjonction ou un ordre sur le contexte. TLA-02 couvre l'appariement et la consommation de messages, pas la discipline de partage/emprunt d'un canal. Ce point doit être tranché conceptuellement avant de choisir un modèle dynamique ; à défaut, il relève d'abord d'une extension du système de types et de ses preuves.

**Import dynamique et exécution étrangère.** C3 décrit `Import` depuis un fichier, une URL ou un modèle de langage, exécuté dans un environnement à effets contrôlés, avec provenance journalisée pour le rejeu. Le même chapitre identifie cependant l'exécution de macros avant vérification, les sources distantes et les capacités exportées par FFI comme des frontières de confiance dont le contrat de réalisation n'est pas fixé. TLA-06 ne couvre que le transfert logique d'une capacité pendant un appel étranger. Un futur modèle distinct doit, après définition du profil de sandbox, couvrir l'acquisition de source, la provenance/version/hash, les capacités réellement accessibles, les effets autorisés, les échecs/temps morts, les callbacks réentrants, l'unwind et la révocation. Ne pas faire passer un tel automate pour une preuve de confinement OS ou de sécurité du code arbitraire.

Ces trois familles de travaux sont de nature différente : H1–H3 sont d'abord des obligations de métathéorie et de typage ; le partage de canaux reste une décision sémantique ; Import/FFI requiert un contrat de frontière et peut ensuite recevoir un modèle opérationnel. Les futures fiches doivent les garder séparées.


### 4.7 Property sensitivity and observed bounded evidence

The following table distinguishes source-level reasoning from actual TLC
observations. The only complete archive inspected in this snapshot is run
[41308633862](https://github.com/AntheaLiles/k7pl/actions/runs/41308633862),
on source head \`dafbc608f8c94a97644f336286cc228e94d3d975\`. It ran the previous
39-profile inventory (18 positive, 21 negative), not the current 40-profile
inventory. Its results are historical evidence for that exact SHA only.
The run did not validate the later TLA-02/TLA-07 parser corrections or the
TLA-12 revocation extension. No result below is promoted to a current-head
verdict.

| Invariant / property | Transition that actually challenges it | Positive assumptions | Negative control | Observed TLC result | Vacuity / limit | Claim currently authorised |
|---|---|---|---|---|---|---|
| TLA-01 \`NoMutualWaitDeadlock\` | \`Block\`, \`Timeout\`, \`ExternalDeliver\`; the deadlock predicate excludes wait edges whose timeout action is enabled | Finite 2–3 actors; one message per actor; timeout nondeterministic; no WF/SF | \`TLA01-CircularWait.cfg\` | Run 413086: positive timeout profile 3 generated / 3 distinct states, depth 3, queue empty; negative circular wait 11 / 8, depth 4, named violation reached | Timeout is a failure/abort path, not successful termination. External delivery is a separate action. No fairness means neither timeout occurrence nor eventual delivery is guaranteed. Built-in TLC deadlock detection is disabled by \`CHECK_DEADLOCK FALSE\`. | Bounded distinction between a timeout-enabled wait and the deliberately constructed internal cycle; no general deadlock-freedom or progress theorem. |
| TLA-01 \`Simulation\` | \`Block(ActorC)\` creates the dynamic edge ActorC → ActorA | Static dependency relation acyclic; endpoint duality holds; dynamic waits are not constrained to the static graph | \`TLA01-SimulationGap.cfg\` | Run 413086: 4 generated / 4 distinct, depth 2; exact \`Simulation\` invariant violation | TLC stops at the first configured invariant. The observed trace is \`Init → Block(ActorC)\`, with one edge ActorC → ActorA. It is **not** a three-actor wait cycle; \`NoMutualWaitDeadlock\` is not a second verdict. The expected JSON was corrected to this observation in commit \`279f160b\`. | A one-step counterexample to the unconstrained abstract implication (Sim); not a K7PL execution absent a K/TLA projection. |
| TLA-03 \`NoTerminatedFibreExecutes\` | \`Terminate(f)\` would need to occur before a later \`RunStep(f)\` | Positive profile sets \`AllowTerminate = FALSE\`; weak fairness is applied to \`RunStep(f)\`, not to termination | \`TLA03-StarvationControl.cfg\` | Run 413086: fair positive 19 generated / 9 distinct, depth 5; negative \`NoStall\` violation reached in 4 / 4, depth 2 | The positive profile cannot take \`Terminate\`; the property is not exercised. In the module, \`Terminate(f)\` is enabled for any Ready fibre when the constant permits it; no valid-completion predicate currently guards termination. | The fair profile checks bounded scheduler behaviour under its stated WF assumption; it does not validate safe termination or establish a runtime fairness contract. G3 remains open. |
| TLA-05 cancellation/commit | \`RequestCancellation\`, \`AcknowledgeCancellation\`, \`CommitEffect\` interleavings | Finite request/service state; commit and acknowledgement are distinct transitions | \`TLA05-PostAckCommitControl.cfg\` | Run 413086: positive 62 / 33, depth 7, queue empty; negative reached \`AcknowledgedCancellationMeansNoCommit\` after Send, Accept, RequestCancellation, AcknowledgeCancellation, CommitEffect (33 / 22, depth 6) | \`CommittedNotCancelled\` and \`TimeoutIsNotAcknowledgement\` are close to consequences of transition updates; only the post-ack guarantee and at-most-once claim are substantive candidates. | A bounded cancellation/commit race witness under the candidate post-ack contract; not a general exactly-once external-effect guarantee. |
| TLA-07 \`NoOverlappingWriteRights\` and lifetime invariants | Would require grant, split, transfer, merge, revoke, region destruction and slot reuse to change ownership/permission state | Current \`CapCells\` ranges are disjoint constants; finite slots and two generation values | Generation-wrap, stale-access and revoke/restore controls | Run 413086: TLA-07 positive and all three negative controls failed before a model verdict at \`ValidCapabilitiesMatchGeneration\` parsing. Parser changes were subsequently made in commits \`39924233\` and \`70a15318\`; not yet TLC-validated. | Disjoint constant cells do not challenge rights preservation. The state field \`owners\` does not itself model the required region ownership algebra. H1–H3 are Lean/type-theory obligations, not TLA-07 coverage. | No current validated TLA-07 property claim. Define ownership and permission operations first; keep H1–H3 open. |
| TLA-09 \`BudgetNonNegative\` / \`UsageWithinGrade\` | \`Use\` and budget consumption transitions, including unsafe overuse | Finite grades, counters and abstract cost units | \`TLA09-GradeOveruseControl.cfg\`; \`TLA09-BudgetOverdrawControl.cfg\` | Run 413086: positive 73 / 36, depth 6; negative grade-overuse 12 / 6, depth 3; negative budget-overdraw 49 / 15, depth 4 | Positive non-negativity follows arithmetically from configured grade limits. Cost units are not CPU cycles or wall time. | Bounded consistency and sensitivity checks only; not independent evidence for the general budget law or \`thm:correction_ressource\`. |
| TLA-11 \`LowObservationEquality\` | \`RunPairedObservation\` | Paired runs synchronise public values; one-step finite self-composition | \`TLA11-HighInfluenceControl.cfg\` | Run 413086: positive 2 / 2, depth 2; negative \`LowObservationEquality\` violation 2 / 2, depth 2 | One transition only; timing, event count/order, scheduler effects and long traces are outside the model. | One-step value/output observation example; no general trace non-interference claim. G8 remains open. |
| TLA-12 \`DOMWriteRequiresCapability\` and \`NoApplyAfterRevocation\` | \`HandleEvent → RevokeWriterCapability → ApplyPatch\` | Current candidate leaves the prepared patch pending when the capability is revoked; ApplyPatch is disabled unless the unsafe switch is enabled | Existing unauthorized-writer control; new \`TLA12-ApplyAfterRevocationControl.cfg\` | Run 413086: old positive 33 / 23, depth 7; old unauthorized-write negative 4 / 4, depth 3. The revocation action, invariant and new 40th profile were added later in commit \`279f160b\`; no TLC result yet. | The model forbids application after revocation but deliberately does not decide what happens to the pending patch. That policy remains G18. | Only the pre-extension bounded writer-capability check has historical evidence. The new interleaving is model-drafted and awaits TLC plus owner decision on patch lifecycle. |
| TLA-16 abstract SPSC queue | \`Publish\`, \`Consume\`, slot reuse | Atomic abstract transitions; two-slot queue; bounded producer/consumer indices | \`TLA16-OverwriteUnreadControl.cfg\` | Run 413086: positive 49 / 32, depth 7; negative message-conservation violation 23 / 14, depth 4 | Compiler reordering, hardware memory model, cache coherence and release/acquire implementation are absent. | Bounded abstract queue protocol only; no concrete weak-memory or hardware guarantee. G11 remains open. |

For positive profiles the queue is empty at successful completion. For negative
profiles TLC stops at the first expected invariant violation; a non-empty
remaining queue is expected and must not be misreported as exhausted. State
counts and depths are evidence about only the exact finite configurations.
The artifact's 39 results must not be projected onto the current 40-profile
manifest or onto a later source SHA.

All current model configurations set \`CHECK_DEADLOCK FALSE\`; TLC's built-in
deadlock detector is therefore disabled. Explicit wait-cycle invariants remain
separate checks and do not constitute suite-wide deadlock detection.

H1–H3 remain independent obligations in \`wiki/assurance.md\`: unique
introduction of \`WriteCap\`, distinct region/range semantics, and prevention
of linear-capability capture across product modes. No TLA-07 result discharges
them.

### 4.7.1 Observed result for all 40 profiles — run 41310176908

Source SHA: \`a7a6d631f0c19876b0437276e6cd6e8bec79a3de\`. Manifest: 18 positive,
22 negative. The run reached the declared result for 37 profiles (17/18
positive, 20/22 negative). A negative profile passes only when TLC reports
the exact expected invariant violation; full state-space exhaustion without
that violation is a failed control. An incomplete successor is also a failure.

Artifact: [run 41310176908 / artifact 13085331418](https://github.com/AntheaLiles/k7pl/actions/runs/41310176908/artifacts/13085331418).
The archive had 116 entries; all 115 \`SHA256SUMS\` entries verified.
TLC 1.7.4 JAR SHA-256: \`936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88\`.
Uploaded archive SHA-256: \`3c6ab091887715f0cd38f3a2bf59570a929bfca8b1ad74cb6aa979e9b6135e1d\`.

| Profile | Kind | Observed TLC result | Generated / distinct / queue | Depth |
|---|---|---|---:|---:|
| \`tla01-acyclic-nominal\` | positive | completed, no error | 5 / 4 / 0 | 3 |
| \`tla01-circular-wait\` | negative | \`NoMutualWaitDeadlock\` violated | 11 / 8 / 2 | 4 |
| \`tla01-external-wait\` | positive | completed, no error | 5 / 4 / 0 | 3 |
| \`tla01-simulation-gap\` | negative | \`Simulation\` violated | 4 / 4 / 2 | 2 |
| \`tla01-timeout\` | positive | completed, no error | 3 / 3 / 0 | 3 |
| \`tla02-atomic-join\` | positive | completed, no error | 3 / 3 / 0 | 3 |
| \`tla02-partial-consume\` | negative | \`BalancedConsumption\` violated | 3 / 3 / 1 | 2 |
| \`tla03-fair-scheduler\` | positive | completed, no error | 19 / 9 / 0 | 5 |
| \`tla03-starvation-control\` | negative | \`NoStall\` violated | 4 / 4 / 2 | 2 |
| \`tla04-consistent-lifecycle\` | positive | completed, no error | 100 / 69 / 0 | 16 |
| \`tla04-early-publish\` | negative | \`PublishedSnapshotDurable\` violated | 12 / 12 / 7 | 3 |
| \`tla05-cancel-commit\` | positive | completed, no error | 62 / 33 / 0 | 7 |
| \`tla05-post-ack-commit\` | negative | \`AcknowledgedCancellationMeansNoCommit\` violated | 33 / 22 / 9 | 6 |
| \`tla06-caller-alias\` | negative | \`NoCallerUseDuringExclusiveCall\` violated | 3 / 3 / 0 | 3 |
| \`tla06-revocation\` | positive | completed, no error | 14 / 11 / 0 | 6 |
| \`tla06-stale-alias\` | negative | \`NoForeignUseAfterAcknowledgement\` violated | 15 / 12 / 1 | 6 |
| \`tla07-capability-lifetime\` | positive | **FAIL:** \`NoStaleEntityAlias\` violated unexpectedly | 8 / 8 / 3 | 4 |
| \`tla07-generation-wrap\` | negative | \`NoStaleEntityAlias\` violated | 10 / 8 / 3 | 4 |
| \`tla07-revocation-restore\` | negative | **FAIL:** full exploration; expected \`NoCapabilityRevival\` not violated | 23,211 / 5,292 / 0 | 19 |
| \`tla07-stale-access\` | negative | \`NoUnauthorizedAccess\` violated | 29 / 27 / 16 | 5 |
| \`tla08-early-join\` | negative | \`JoinRequiresAllBranches\` violated | 4 / 4 / 2 | 2 |
| \`tla08-partial-order\` | positive | completed, no error | 15 / 11 / 0 | 7 |
| \`tla09-budget-overdraw\` | negative | \`BudgetNonNegative\` violated | 49 / 15 / 8 | 4 |
| \`tla09-grade-overuse\` | negative | \`UsageWithinGrade\` violated | 12 / 6 / 3 | 3 |
| \`tla09-resource-budget\` | positive | completed, no error | 73 / 36 / 0 | 6 |
| \`tla10-charge-wait\` | negative | \`BudgetAccounting\` violated | 2 / 2 / 0 | 2 |
| \`tla10-wait-cost\` | positive | completed, no error | 34 / 32 / 0 | 8 |
| \`tla11-high-influence\` | negative | \`LowObservationEquality\` violated | 2 / 2 / 0 | 2 |
| \`tla11-low-observation\` | positive | completed, no error | 2 / 2 / 0 | 2 |
| \`tla12-apply-after-revocation\` | negative | **FAIL:** incomplete successor; \`ApplyPatch\` did not assign \`appliedAfterRevocation\` | 13 / 11 / 6 | 4 |
| \`tla12-reactive-pipeline\` | positive | completed, no error | 49 / 33 / 0 | 7 |
| \`tla12-unauthorized-dom\` | negative | \`DOMWriteRequiresCapability\` violated | 4 / 4 / 1 | 3 |
| \`tla13-deductive-saturation\` | positive | completed, no error | 14 / 14 / 0 | 6 |
| \`tla13-early-publish\` | negative | \`PublishedImpliesSaturated\` violated | 6 / 6 / 3 | 3 |
| \`tla14-noise-conditional\` | positive | completed, no error | 17 / 17 / 0 | 9 |
| \`tla14-skipped-message\` | negative | \`MessagesAcceptedWereSent\` violated | 9 / 9 / 2 | 5 |
| \`tla15-gset-conditional\` | positive | completed, no error | 15 / 11 / 0 | 5 |
| \`tla15-overwrite-merge\` | negative | \`AllIssuedUpdatesRetained\` violated | 4 / 4 / 1 | 3 |
| \`tla16-overwrite-unread\` | negative | \`MessageConservation\` violated | 23 / 14 / 8 | 4 |
| \`tla16-spsc-abstract\` | positive | completed, no error | 49 / 32 / 0 | 7 |

The TLA-07 failures have different causes. In \`tla07-capability-lifetime\`,
\`Allocate\` could reactivate a destroyed slot at its old generation without
taking \`ReuseSlot\`; the witness was \`Init → Allocate → Destroy → Allocate\`.
In \`tla07-revocation-restore\`, the invariant compared active and currently
revoked sets. \`RestoreRevokedCapability\` removed a capability from the revoked
set while adding it to the active set, so historical revival was invisible.
The completed 23,211-state search is a failed negative control, not a pass.

The TLA-12 failure is a TLA operator-precedence issue: without parentheses,
\`appliedAfterRevocation' = appliedAfterRevocation \\/ writerRevoked\` does not
constrain the primed variable on every branch. This was corrected in
\`a173e227...\`.

The source changes in \`a173e227...\` add a monotone historical-revocation set,
guard safe allocation against stale generations, record an explicit unsafe
finite-generation collision, and parenthesise the TLA-12 assignment. Those
changes are not validated by this 40-profile run. The source-head CI run for
\`a173e227...\` is [41311344952](https://github.com/AntheaLiles/k7pl/actions/runs/41311344952),
pending at last observation.

### 4.8 Order of further modelling work

Do not assign TLA-17+ identifiers merely to expand the directory. The
highest-value next work is to strengthen the contracts and observable
transitions already present:

1. The candidate TLA-12 interleaving between event handling, revocation and
   patch application is now represented. Obtain the owner decision on whether
   a prepared patch is discarded, recomputed/retried or governed by a bounded
   lease before adding lifecycle behaviour.
2. Extend TLA-07 only after the ownership algebra is fixed: multiple
   `ReadCap`, exclusive `WriteCap`, borrow/split/merge, region destruction,
   actor incarnation and stale references. Keep H1–H3 as Lean obligations.
3. Extend TLA-06/D01 around asynchronous FFI completion, callbacks,
   reentrancy and quiescence. Logical revocation alone is not evidence of
   physical alias or DMA invalidation.
4. Define a single physical-page lifetime/ownership invariant (M3) before
   building the separate CPU/MMU (M1) and IOMMU/DMA (M2) protocols. Their
   translation caches and agents differ, but safe page reuse couples them.
5. Reconcile R9/TLA-05 and TLA-01/TLA-02/TLA-16 with explicit typed interface
   relations before attempting a composed transition system.
6. Only then select target-specific weak-memory, device and runtime refinement
   tools. TLA+ does not verify CPU/device implementation assumptions itself.

These priorities are proposed research sequencing, not owner-ratified
normative additions. The normative source remains Verso; implementation
refinements must not be promoted into language guarantees without an explicit
specification decision.

## 5. Obligation-level audit

The chapter-level matrix in this file is the live model-coverage register for
`main@2fbf609f6f3e67ffe011a3f28fd247526684155a`. The theorem/gap status and
assurance classification are centralised in [`wiki/assurance.md`](../wiki/assurance.md);
do not duplicate that register here. The obligation-level report
[`SPEC-COVERAGE-AUDIT-2026-10-31.md`](SPEC-COVERAGE-AUDIT-2026-10-31.md)
is retained as a historical analysis of the then-open PR #311 head
`f3b33cd34e1da49a4c8c41ca632c586e66715e70`, not as the current specification
baseline. PR #311 remained open and unmerged on 2026-11-01. Revalidate any
specific obligation against current main before implementation.

The update to `wiki/semantics.md` that points to repository-root `models/`
must be carried into PR #311's successor lexicon documentation if that PR
eventually replaces the wiki page. PR #311 is explicitly not to be merged
before its lexical work is finished; do not resolve this dependency by
merging it prematurely.
