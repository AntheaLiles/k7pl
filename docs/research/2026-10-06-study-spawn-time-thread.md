<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Comparative study: the time thread of the fibril spawned by `spawn`

> **Status: non-normative archived research material.** This study comes from PR #10 (archive commit `d39d012`), which was closed without merge. It has not been reviewed or ratified by the author. This is an English translation made on 2026-10-14; the original French text and its exact provenance are recorded in the [PR #10 archive recovery lot](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 4 (deposit V-03). In case of discrepancy, the original prevails. The current normative source is `spec/`; nothing below describes `main` unless an editorial note says so.

> **Editorial note (2026-10-14): scope of the archived facts.** The "verified facts" of § 2 and every label, rule and statement cited below were read on the archive state `d39d012`, not on `main`. Checked against `main` at `7af5581`:
>
> - the following labels are not defined anywhere under `spec/Spec/` on `main`: `eq:traduction-fils`, `eq:reductions-couche2`, `eq:relation-sessions-mondes`, `sec:g-sortes-fil`, `tab:couverture-reductions`, `thm:chaine_fils`, `thm:correspondance_niveaux`. The study presupposes the first, the sixth and the seventh throughout;
> - on `main`, the open questions on the temporal order under concurrency and on the translation of `spawn` are tracked by the C-07 audit ([`C-07-SIMULATION-AUDIT.md`](../migration/C-07-SIMULATION-AUDIT.md), § 5, l. 105-115) and by `docs/tracking/DECISIONS.md`, l. 63 (decisions D-S1 to D-S3); this is also material for stage F (`docs/tracking/PROJECT-MASTER-PLAN.md`, § 9, l. 248-262), whose state is NOT STARTED (same file, l. 47);
> - "session 29" and "session 32" are review-session records of the archive; they are not deposited in `main` (see the lot, § 3.1). The quotation attributed to the author in the opening paragraph is the archive's attribution; it is not recorded in `docs/tracking/DECISIONS.md`, which states that none of the decisions the archive attributes to the author is decided in `main` (l. 123);
> - `hypotheses-de-module.md`, cited in § 5.3, is at `docs/tracking/hypotheses-de-module.md` on `main`.
>
> Rewritten in this translation: the bibliography file and the corpus are cited at their current paths, `docs/bibliography/references.json` and `docs/research/corpus.md`; the link to the sister study points to its deposited translation. The link to the writing rules (§ 5.3) is unchanged and resolves on `main`. All other text, formulas, notation, labels, citation keys and tables are translated or kept verbatim, without correction.

**Session 32 (6 October 2026), part C.** Answer to the author's decision: « *pour faire un choix éclairé j'ai besoin d'avoir une analyse des possibilités au regard de l'état actuel du manuscrit* » ("to make an informed choice I need an analysis of the possibilities with regard to the current state of the manuscript").

**Status.** No choice is made here and the manuscript (`spec/`) is not modified. The recommendation of §8 is an **opinion**, with its revision conditions. The translation clauses given below are **reading sketches**, not checked by machine and not proved: they serve to price what each option imposes, not to be copied. The facts about the manuscript are checked in the repository (labels, rules, statements), the proof-cost estimates are the writer's estimates. Sister study: [`study-parallel-fork-interleaving`](2026-10-06-study-parallel-fork-interleaving.md) (the two are linked, see §4.3).

## 1. In brief

**The question.** The threaded time thread (`eq:traduction-fils`) is a linear chain of links (`maillon`), one per level: one fibril, one thread. A fibril spawned by `spawn` opens one more chain, and the translated program can neither create nor receive an ambient time channel (`thm:confinement_sortes`). The translation of `spawn` is not written; `thm:chaine_fils` says so itself.

**The options** (a variant of each is set aside by construction, §5):

| | Option | In one sentence |
|---|---|---|
| `O1` | bifurcation by link (session 29, "route A") | the mother creates the child's links and gives them to it through the `spawn` event; the handler listens to a tree of chains |
| `O2` | inherited, shared thread ("route C") | the child emits on the mother's chain; in its literal form this is impossible, in its arbitrated form it is `O1` plus an arrival log |
| `O3` | independent thread, supplied by the handler ("route B") | the child receives a fresh chain from the handler through a request protocol |
| `O4` | do not translate the child's thread | bound the scope of `thm:simulation` and of the session clause, or forbid `spawn` in code where time is claimed |

**What is solid.** (i) No statement today **proves** anything about the translation of `spawn`: `thm:chaine_fils` is a proposition bounded to a fragment without `spawn`, so is `thm:simulation`, the session clause is bounded to the communication-free fragment (§2). Only the sketch of `thm:confinement_sortes` (theorem) claims layer 2 "all cases", while the translation of `spawn` does not exist: it will be true or false depending on the option. The urgency is therefore low, but this sketch is to be watched. (ii) `O2` in its literal form is impossible (§5.2). (iii) `O1` in its form "a bifurcation marker on each level" leaks: the type-directed form is needed (`O1b`, §5.1), whose correctness relies on `thm:correspondance_niveaux`, **not proved for layer 2**.

**What depends on a neighbouring choice.** Application and scoped operation raise the same question of substance (passing links into a call): the common prerequisite is examined in §4. The complete form of the temporal factor (`ANOM-18`) conditions every option that reads the levels of the child's effect. And `∥` as interleaving (sister study) requires the same bifurcation mechanism, plus a join.

**Opinion** (§8): `O1b` if the author wants the translation to cover `spawn`, under four conditions; otherwise `O4a` (state the scope) is a risk-free waiting state, which does not forbid `O1b` later. To be decided **after** the sister study, because interleaving for `∥` makes `O1b` almost mandatory.

## 2. What the manuscript says today (verified facts)

| Fact | Where |
|---|---|
| Reduction: `⟨𝒫 ⊎ {p : spawn c} …⟩ → ⟨𝒫 ⊎ {p : return (), q : c} … τ ◁_p ε_spawn⟩`, `q` fresh, « reprenant après `ε_spawn` » ("resuming after `ε_spawn`"); `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩` | `eq:reductions-couche2` (§4.7, `sec:g-semantique`) |
| Typing: `Δ ⊢ c : F₁ 𝟏 \| ε` gives `Δ ⊢ spawn c : F₁ 𝟏 \| ⟨spawn, ⟨w(ε), 0⟩⟩`; « rien à la profondeur de la mère » ("nothing at the mother's depth"); **no coupling clause** `niv(Δ) ⊑ ℓ̂(ε)` (only `Op` and `Case` carry one) | `eq:regles-couche2` (§3.2, `sec:g-couche2`) |
| Under concurrency, `τ` is a labelled partial order; the decrease of `τ·ε` is understood « le long de chaque chaîne » ("along each chain") | end of `sec:g-couche2`; statement of `thm:preservation` |
| Thread threaded per level, clauses for `tick`, `operation`, `return`, `let` only; « un événement d'un niveau ne touche que le fil de ce niveau » ("an event of a level touches only the thread of that level") | `eq:traduction-fils` (§4.8, `sec:g-sortes-fil`) |
| Sorts: kinds `prog`, `operation_a`, `temps`, `maillon`; capabilities; `𝒮_ν = 𝒮_prog ∪ 𝒮_maillon`; transfer `[a ↔ b]` | `eq:sortes`, `tab:capacites`, `eq:bon-sortage` |
| A translated program fabricates no effect channel: no name `operation_a` or `temps` is bound or transmitted (theorem) | `thm:confinement_sortes`, whose sketch covers « couche 2, tous les cas » ("layer 2, all cases") |
| The thread is a linear chain, on the fragment `return`, `let`, `tick`, single-level operation (proposition); « pour `spawn` il ne s'étend pas tel quel » ("for `spawn` it does not extend as is") | `thm:chaine_fils` |
| Session clause indexed by the correspondence `θ` of names; two processes `ℓ`-comparable if their logs `J_k` (`k ⊑ ℓ`) are, for the prefix; graded non-interference « bornée au fragment sans communication » ("bounded to the communication-free fragment") | `eq:relation-sessions-mondes`, `sec:g-sortes` |
| Uncertainty no. 6: the ambient channel of a spawned fibril « ne peut venir ni du programme ni de la mère » ("can come neither from the program nor from the mother"); it « vient du gestionnaire, par un protocole que le texte ne donne pas » ("comes from the handler, through a protocol that the text does not give") | end of `sec:g-sortes` |
| Simulation: one source step gives at least one target step; clauses only for `return`, `let`, `tick`, operation; « l'énoncé pourrait y devoir s'entendre `→*` » ("the statement might have to be read `→*` there") for `spawn`, `new`, `try` | `thm:simulation` (proposition), `thm:fidelite_interprete` (conditional on Sim) |
| A computation emits an event only at a level `⊒ niv(Δ)`; induction not carried out on layer 2 | `thm:correspondance_niveaux` (proposition) |
| `ℓ̂(ε)`: greatest lower bound of the levels where `κ` is non-zero; the temporal factor is written in three ways | `sec:g-regles`; `ANOM-18` |
| Observational determinism: « deux exécutions qui diffèrent par le seul entrelacement ont la même projection » ("two executions that differ only by the interleaving have the same projection"); `Guard` resists | `thm:determinisme_observationnel` (conjecture) |
| P4: in layer 2, replay « modulo le journal : l'entrelacement des acteurs est journalisé » ("modulo the log: the interleaving of the actors is logged") | `Postulats` (ch. 1) |

Two readings to keep for what follows.

* **There are two "logs".** That of P4 restores the interleaving for replay; that of §4.8 (`J_k`) is the word of the events received by the handler of level `k`, on which the observational projection `π^♭_ℓ` bears. The text says "the log" for both. The options below touch only the second, except `O2c`, which merges them.
* **`J_k` is defined as a word** (« dans l'ordre où la relation `→` les produit », "in the order in which the relation `→` produces them"). As soon as two fibrils emit at the same level, it is no longer a word that the chain determines: it is a partial order (a tree of chains under `O1`), or else a word that depends on the scheduler. This sentence of `thm:chaine_fils` is true on its fragment and to be reformulated elsewhere.

## 3. Grid: what every option must hold

| | Requirement | Source |
|---|---|---|
| `E1` | **confinement**: no effect channel created, received or transmitted by a translated program | `thm:confinement_sortes` |
| `E2` | **linearity**: each link is produced once and consumed once | `thm:chaine_fils` |
| `E3` | **order**: the image reproduces the partial order of the source, in particular the edge "the child resumes after `ε_spawn`" | `eq:reductions-couche2` |
| `E4` | **no leak through the structure**: the presence of a bifurcation marker on the thread of level `k` does not depend on data of level `⋢ k` | `thm:correspondance_niveaux`, `thm:non_interference` |
| `E5` | **simulation**: a source step is followed by at least one target step, the trace being extended by the image of the events | `thm:simulation` |
| `E6` | **projection definable** in the target: `π^♭_ℓ(J) = (J_k)_{k ⊑ ℓ}` | §4.8 |
| `E7` | **session clause**: comparison of logs under `θ`, without a new notion of correspondence if possible | `eq:relation-sessions-mondes` |
| `E8` | **handler**: the protocol that the text does not give today, with the minimal hypothesis on the environment | uncertainty no. 6 |
| `E9` | **scope**: the same solution serves application, scoped operation and multi-level | log of session 32, "what was not written" |
| `E10` | **consistency with P3 and P4**: mother's depth unchanged, replay log not distorted | `eq:regles-couche2`, P3, P4 |

## 4. Three points common to all the options

### 4.1 Links in a call (application, scoped operation)

Session 32 gave up on the translation clauses for application and scoped operation: « elles obligent à faire passer des maillons dans un appel, ce que `tab:capacites` ne permet pas » ("they force links to be passed into a call, which `tab:capacites` does not allow"). This checks out. A function is a value created in one place and called in another; the events of its body must be recorded on the chain **of the caller**, at the time of the call. The service that translates it must therefore receive `(t⃗, t⃗')` at the call, and `tab:capacites` authorises neither the emission of a link on a program channel (row "emit": a thread transmits only its link, a program channel transmits only program names) nor its reception (row "receive": « aucun terme traduit ne reçoit un nom de fil », "no translated term receives a thread name").

The natural extension is to treat the link as a program name of linear use, of the same level: emit and receive `⟨maillon, k⟩` on a channel `⟨prog, ℓ⟩`. The current predicate requires `niv(t) ⊑ niv(s)`; a service whose body emits at a level higher than its call channel could not receive the link of that level. The repair is the same as for `O1b`: **thread only the levels that the effect of the body mentions** (`lev(ε)`, §5.1) and take as the level of the call channel the least upper bound of these levels. This is a reading, not a written rule.

Consequence for the study: if the author wants application and scoped operation (they are needed for `PREUVE-03` outside the fragment), the extension "link transmissible on a program channel" is due **in any case**. It lowers the marginal cost of `O3b` (§5.3), which needs it; it changes nothing for `O1` (which does not need it) nor for `O4`.

### 4.2 The form of the temporal factor (`ANOM-18`)

Every option that must know "at which levels the child emits" reads `lev(ε)`, the set of levels at which the child's effect has an event. Now `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩` writes a pair without level index, the formula `eq:grammaire-types` writes `(ℕ∞ × ℕ∞)^ℒ`, and the prose and `thm:temps_mononiveau` write `ℕ∞^ℒ`. As long as the complete form is not fixed, `lev(ε)` is not defined and `w(ε)` is not a number. Two consequences independent of the choice of option:

* the level of the `spawn` event (hence the thread on which it is recorded) is not determined;
* `ℓ̂(ε_spawn)` is not defined, so that the coupling clause of `Case` does not constrain a `spawn` placed under a `case` on a secret value. Such a program is probably typable without the leak through the presence of a fibril (§6, program `Q`) being excluded by a rule.

**Prerequisite of all options except `O4a`**: settle `ANOM-18` (`(ℕ∞ × ℕ∞)^ℒ` is the reading that makes `eq:cout-parallele` and `spawn` consistent). None of the options is comparable while this point is open; I compare them assuming the form `(ℕ∞ × ℕ∞)^ℒ`.

### 4.3 Dependency on the study on `∥`

A `∥` as interleaving (route C of the sister study) is translated by a bifurcation of each thread followed by a join. `spawn` is the bifurcation without join. If the author retains interleaving for `∥`, the mechanism of `O1` is already required and `spawn` inherits it; if `∥` remains big-step fork-join, the choice for `spawn` is free. Hence the advised order: **sister study first**.

## 5. The options

Notation of the sketches: `ℓs` is the level of the `spawn` event; `L = lev(ε_c)` the levels of the effect of the child `c`; `z_c` the result channel of the child, which the mother does not read; `H_k` the handler of level `k`. The clauses follow the form of `eq:traduction-fils`.

### 5.1 `O1`: bifurcation by link

**Definition.** The `spawn` event that the mother emits carries, together with her own next link, a link created by her for the child; the handler listens to two chains. The thread becomes a **tree of chains**, which is exactly the partial order that the source gives to `τ` (the child « reprend après `ε_spawn` », "resumes after `ε_spawn`").

Two realisations, which are not equivalent:

* **`O1a`, a marker on each level.** The mother emits on each thread `t_k` a `fork` marker carrying `(t'_k, u_k)`. Uniform, but **leaks**: see `Q` in §6. Set aside.
* **`O1b`, type-directed bifurcation.** Only the threads of the levels of `L` bifurcate; the others pass through by transfer, including on the child's side.

```
⟦spawn c⟧_{z,t⃗,t⃗'} =
  (ν z_c)(ν (u_k, u'_k)_{k∈L}) (
      t̄_{ℓs}⟨ε_spawn, t'_{ℓs} [, u_{ℓs} si ℓs ∈ L]⟩
    | ∏_{k∈L, k≠ℓs} t̄_k⟨fork, t'_k, u_k⟩
    | ∏_{k∉L, k≠ℓs} [t_k ↔ t'_k]
    | ⟦c⟧_{z_c, ū, ū'}                -- ū_k, ū'_k reliés par [ū_k ↔ ū'_k] pour k ∉ L
    | z_c(_).𝟎 | z̄⟨()⟩ )
```

The handler offers two branches: `ev` (receives `e, t'`, continues on `t'`) and `fork` (receives `e, t', u`, continues on `t'` **and** on `u`). This is session branching (`x ▷ {ℓ_i : P_i}`), already in `eq:metalangage`.

**Reduction rules.** No source rule changes. Only what "resuming after `ε_spawn`" requires is to be made explicit: a configuration that retains, for each fibril, its last event (`λ(q) := ε_spawn` at creation). The text has it implicitly in `τ ◁_p e`.

**Sorts.** No row of `tab:capacites` changes: each transmitted link is transmitted along a thread, at the same level (row "emit", second alternative), `u_k` and `t'_k` of sort `⟨maillon, k⟩`, created by restriction (`𝒮_ν ∋ maillon`). The emission goes from one to two links: the text already writes the pair `⟨ε, t'⟩`, but the grammar `eq:metalangage` has no polyadic emission; it must be written as a sequence of transmissions on a session `E ⊗ M ⊗ M`, the capabilities applying name by name.

**What it imposes.**

* `thm:chaine_fils` extends to a tree: "consumed exactly once, produced exactly once" holds (the child receives `u_k`, the end of its chain `u'_k` remains, like the `t'_k` of the main program, without emitter). The statement "the word `J_k` is the sequence of events in the order of `→`" becomes "`J_k` is a forest of chains".
* `J_k` is no longer a word; `π^♭_ℓ` remains "restriction to the levels `k ⊑ ℓ`" (`E6`).
* The session clause compares forests "for the prefix": a definition to be written (downward-closed sub-forests, or chain by chain under `θ`). The child's chain is a **name** (a link): `θ` takes it on board without a new notion, through the existing rule « chaque canal créé au même point entre dans `θ` par sa paire de noms frais » ("each channel created at the same point enters `θ` through its pair of fresh names") (`E7`).
* `thm:simulation`: the emission of `ε_spawn` is a communication with the handler, so the `spawn` case is indeed a `→⁺`: **the question "`→⁺` or `→*`" is settled for `spawn`** (it remains open for `new` and `try`).
* The handler must be specified (this is a prerequisite of all options, §3 `E8`), here in its bifurcating version.

**What it does not break.** `thm:confinement_sortes` keeps its statement (the link is not an effect channel), and the sentence of its sketch « un maillon ne se transmettant que le long d'un fil » ("a link being transmitted only along a thread") remains true: the marker and the child's link do travel along a thread, at the same level. `thm:cloture_sortage`: the clauses bear only on sorts of names, unchanged.

**Correctness condition (`E4`).** Why `O1b` does not leak: every event of the child has level `⊒ niv(Δ)` by `thm:correspondance_niveaux`, so `L ⊒ niv(Δ)`, so the markers fall only on threads of level `⊒ niv(Δ)`, which only observers who already read `niv(Δ)` see. **This argument rests on `thm:correspondance_niveaux` for layer 2, whose induction is not carried out**, and on `ANOM-18` (without a level for `ε_spawn`, `ℓs` is free).

**Proof cost** (S: one induction case or a local lemma; M: several cases or a new definition with its properties; L: an induction over several rules or the rewriting of a sealed statement).

| Item | |
|---|---|
| settle `ANOM-18`, define `lev` | M, common |
| clause of `spawn` and its well-sortedness | S + S |
| polyadic: sequence of transmissions | S |
| two-branch handler, specified | M |
| `J_k` forest, `π^♭` on forests | M |
| `thm:chaine_fils` for the tree | M |
| comparison of forests in the session clause | M |
| `spawn` clause of the simulation | S |
| lemma "markers of level `⊒ niv(Δ)`" | M, depends on `thm:correspondance_niveaux` (layer 2) |
| sketch of `thm:confinement_sortes`: rereading | S |

Total: **M to L**, **no sealed statement modified**.

**Risks.** (i) `thm:correspondance_niveaux` not proved on layer 2 (the correctness of `O1b` depends on it). (ii) The number of handlers grows with the bifurcations (one instance per child link): a memory bound to be written, otherwise P3 (no hidden cost) is affected. (iii) The chain ends of the children remain waiting indefinitely, like that of the main program: without consequence if the handler is a replicated instance, to be stated. (iv) Depth: on the partial order, the chain that crosses the `spawn` edge (prefix of the mother, `ε_spawn`, events of the child) may be longer than the depth annotated for the mother (`⟨w(ε), 0⟩`). If "chain" in `thm:preservation` denotes any path of the order, the statement is false for the depth; it must be read **per fibril** (this is the meaning of « le chemin critique de celui qui l'engendre », "the critical path of the one that spawns it", `sec:g-couche2`) or `s(ε)` must be charged to `spawn`. This point is independent of the option, `O1` makes it visible.

### 5.2 `O2`: inherited thread (the child emits on the mother's chain)

**Definition.** Route C of the instruction: the child does not open a chain. Three readings.

* **`O2a`, literal sharing.** Two producers on one link. Each link is single-use (`E2`): the second emission never binds, one of the two threads remains stuck. Impossible as is. Set aside.
* **`O2b`, in-line relay.** The mother passes her link to the child, which gives it back at its end. The child's events are recorded before the rest of the mother's: this is a sequentialisation of the log. Yet the child may wait for a message that the mother will only send afterwards: the translation **introduces a deadlock that the source does not have**, which destroys the simulation (`E5`). Set aside.
* **`O2c`, shared chain with arbiter.** Each fibril keeps its own chain (like `O1`), and the handler **merges** the chains into one word in order of arrival. `J_k` becomes a word again, total.

**`O2c` is `O1` plus an arrival log.** Everything said of `O1` holds, plus:

* `J_k` depends on the scheduler. So does `π^♭_ℓ(J)`. The session clause can no longer say "comparable for the prefix" without quantifying over the interleavings or assuming `𝒟_𝒮` (the hypothesis of `thm:determinisme_observationnel`, conjecture). The text already notes that « l'ordonnanceur entre dans le modèle d'attaquant » ("the scheduler enters the attacker model") (`sec:c2-le-systeme-de-raffinement`, after `thm:non_interference`).
* In return, `J_k` is a **replay** log (P4 says that « l'entrelacement des acteurs est journalisé », "the interleaving of the actors is logged"): the two logs of §2 merge.
* Cost: cost of `O1` + merge at the handler (S) + definition of the comparison under interleaving (M to L).

**Risks.** Leak through the order of arrival if the scheduler consults high values; the total log is the most talkative log.

### 5.3 `O3`: independent thread, supplied by the handler

**Definition.** Route B of the instruction: the child receives a fresh chain from the handler through a request protocol on the mother's thread. Its chain is **not** extended from the mother's in the translation; it is the handler that knows that the child descends from the `spawn` event.

Three realisations.

* **`O3a`, the child receives a `temps` channel.**

  ```
  ⟦spawn c⟧ = (ν r)( t̄_{ℓs}⟨ε_spawn, t'_{ℓs}, r⟩ | ∏_{k≠ℓs}[t_k ↔ t'_k]
                   | r(ū).⟦c⟧_{z_c,ū,ū'} | z_c(_).𝟎 | z̄⟨()⟩ )
  ```

  A thread must transmit a program name `r` and a program channel must **receive** a name of kind `temps`. The statement of `thm:confinement_sortes` (« aucun n'est lié », "none is bound") becomes false: a `temps` name is bound by the reception. It is a **sealed theorem**: modifying it requires the author's approval ([writing rules](../../.claude/skills/writing-rules.md), §10). Cost `L` and one statement rewritten.
* **`O3b`, the answer carries links.** Same clause, but `r` delivers links (kind `maillon`): `thm:confinement_sortes` keeps its statement. Two rows of `tab:capacites` change (emit: a thread may carry a program name; receive: a program channel may receive a link), and the sentence of the sketch about "a link being transmitted only along a thread" is false. The handler of level `ℓs` must create the chains of **all** the levels of `L`: either it asks the other handlers (communication between handlers, not written), or the mother emits a request on each (one finds again the question of the markers of `O1a` and its leak, with the same countermeasure `O1b`). One new hypothesis: **the handler always answers** (progress of the environment), to be recorded in `hypotheses-de-module.md`. If the extension of §4.1 is done in any case, the cost specific to `O3b` is that of the protocol.
* **`O3c`, static addresses.** The configuration instantiates in advance one handler per `spawn` site; the child is translated with **free** `temps` names indexed by the address (nothing is bound or transmitted: `E1` holds). Valid if the number of `spawn` is statically bounded; false as soon as a `spawn` is under a loop or in a coinductive stream, which is the typical case of an actor that spawns per message. A new typing condition would be needed (a grade that bounds the spawnings).

**What `O3` imposes.** The handler holds the tree: good for hiding the structure from programs, but the correspondence `θ` must then extend to names **created by the environment** (the received chain), not only by the two executions at the same point. The session clause gains one case. `thm:chaine_fils` extends to a forest of chains **plus** a filiation relation held by the handler. The simulation: the `spawn` case is a `→⁺` (emission of the request).

| Item (`O3b`) | |
|---|---|
| two changes of `tab:capacites` and of the confinement sketch | S + S |
| request protocol and inter-handler protocol | M to L |
| hypothesis "the handler always answers" | S, recorded |
| `θ` extended to the names of the environment | M |
| `J_k`, `thm:chaine_fils`, comparison of forests | M + M + M, as `O1` |

Total: **L** for `O3b`, **L and one sealed statement** for `O3a`, **M plus a new typing condition** for `O3c` within its scope.

**Risks.** Two capability changes where `O1` changes none; a protocol that the text does not contain; the temptation to widen `θ` to the whole environment.

### 5.4 `O4`: do not translate the child's thread

* **`O4a`, state the scope.** `thm:simulation`, `thm:chaine_fils` and the session clause hold for the configurations whose translation is written (today `return`, `let`, `tick`, operation). `spawn` is not translated; the text already says so (`tab:couverture-reductions`: scheme written, no translation clause). Zero cost. The consequence is that `BLOQ-07` remains "conditional on Sim" and that graded non-interference remains bounded to the communication-free fragment, which it is.
* **`O4b`, forbid `spawn` where time is claimed.** A side condition on `Spawn` or, in the spirit of §6.1 (« une unité `ℓ`-sensible n'admet que les passes `P_trace(ℓ)` », "an `ℓ`-sensitive unit admits only `P_trace(ℓ)` passes"), an interaction rule: no `spawn` in an `ℓ`-sensitive unit. Cost `S` to `M` (one condition, and the definition of "`ℓ`-sensitive" at the level of typing, which exists only in prose). It **settles** the leak of `Q` by prohibition rather than by translation, at the price of a language in which spawned concurrency and observable time do not mix.
* **`O4c`, child without temporal event.** `spawn c` is admitted only if `lev(ε_c) = ∅` (the child does no `tick`). The child no longer needs a chain. Without interest: the `Spawn` rule written to provision `w(ε)` loses its purpose.

**Risks.** `O4a` leaves the decision for later without forgetting it: the price is to keep two partial proofs (`PREUVE-03` and `PREUVE-07`) as long as `spawn` is not covered, and not to be able to write `thm:chaine_fils` for layer 2.

## 6. Examples

**Program `P`** (a single level `⊥`, to read the form of the logs):

```
let _ ← tick in let _ ← spawn (let _ ← tick in tick) in let _ ← tick in return ()
```

Source: `m₁ ≺ s ≺ m₂`, `s ≺ c₁ ≺ c₂` (`m`: events of the mother, `s`: `ε_spawn`, `c`: those of the child).

| Option | `J_⊥` |
|---|---|
| `O1b` | tree: `m₁ → s ⟨fork⟩ → { m₂ ; c₁ → c₂ }` |
| `O2c` | arrival word, for example `m₁ s c₁ m₂ c₂` or `m₁ s m₂ c₁ c₂` depending on the scheduler |
| `O3b` | two roots: `m₁ → s → m₂` and `c₁ → c₂`, plus the filiation `s ▷ racine(fille)` held by the handler |
| `O4a` | `m₁ → s → m₂` (the child has no translated thread) |

**Program `Q`** (two levels `⊥ ⊑ H`, a secret `s :_r Bool` with `niv(r) = H`):

```
case s of { 0 ↦ spawn (tick_H) ; 1 ↦ return () }
```

Reading: `ε_spawn` is labelled `H`, which the coupling clause of `Case` requires if `ℓ̂(ε_spawn)` is defined (`ANOM-18`). Source: `π^♭_⊥(τ)` is empty in both branches: non-interference at `⊥` holds.

* `O1a`: for `s = 0`, a `fork` marker is received on `t_⊥`, so `J_⊥ ≠ ∅`; for `s = 1`, `J_⊥ = ∅`. **Non-interference at `⊥` is false for the translation.**
* `O1b`: `L = {H}`; the `⊥` thread passes through by transfer in both branches; `J_⊥ = ∅` in both. Holds, under `thm:correspondance_niveaux` and `ANOM-18`.
* `O3b`: same countermeasure necessary (request a chain only for the levels of `L`).
* `O4b`: `Q` is not admitted in a `⊥`-sensitive unit.

## 7. Comparative table

| | `O1b` directed bifurcation | `O2c` shared, arbitrated | `O3a` supplied, `temps` | `O3b` supplied, links | `O3c` static addresses | `O4a` scope | `O4b` forbid |
|---|---|---|---|---|---|---|---|
| `E1` confinement | holds, statement intact | holds | **statement rewritten** | holds | holds | holds | holds |
| `E2` linearity | holds | holds | holds | holds | holds | not applicable | not applicable |
| `E3` partial order | exact (tree) | lost (word) | through the handler | through the handler | by address | not treated | not treated |
| `E4` no leak | under `thm:correspondance_niveaux` | under `𝒟_𝒮` | same as `O1b` | same as `O1b` | holds (static) | not treated | by prohibition |
| `E5` simulation | `→⁺` acquired for `spawn` | same | same | same | same | out of scope | out of scope |
| `E6` projection | yes | yes, depends on the scheduler | yes | yes | yes | not applicable | not applicable |
| `E7` session clause | `θ` suffices | to be quantified | `θ` extended to the environment | same | `θ` suffices | unchanged | unchanged |
| `E8` handler | two branches | + merge | protocol | protocol + answer hypothesis | static instances | unchanged | unchanged |
| `E9` application and scope | independent | independent | requires §4.1 | requires §4.1, makes it useful | independent | not applicable | not applicable |
| `E10` P3, P4 | P3: memory bound to be written | P4: a single log | P3 same | same | P3: static bound | holds | holds |
| Capabilities modified | none | none | two | two | none | none | none |
| Sealed statement modified | no | no | **yes** | no | no | no | no |
| Cost | M to L | L | L+ | L | M + new condition | zero | S to M |

## 8. Opinion, and revision conditions

**Opinion (not a decision).**

1. **`O1b` is the least invasive option that covers `spawn`.** It modifies no row of `tab:capacites`, leaves `thm:confinement_sortes` intact, reproduces the partial order of the source (`E3`), brings the child's chain into `θ` without a new notion (`E7`) and settles `→⁺` for `spawn`. Its price is to redefine `J_k` (word, then forest) and to specify a bifurcating handler.
2. **Four conditions**, without which the opinion falls: (i) `ANOM-18` settled in the form `(ℕ∞ × ℕ∞)^ℒ`; (ii) the author accepts that `J_k` is a partial order; (iii) `thm:correspondance_niveaux` is proved on layer 2, since the correctness of `O1b` depends on it; (iv) the handler is specified, with a bound on its instances.
3. **`O4a` is a legitimate waiting state**, not a renunciation: zero cost, nothing sealed depends on it, `O1b` remains possible afterwards. If the author does not want to decide before having decided `∥`, this is the attitude to hold.
4. **Set aside**: `O2a` and `O2b` (impossible or unfaithful), `O1a` (leak), `O4c` (pointless). `O3a` makes sense only if the author accepts rewriting `thm:confinement_sortes`.

**Revision conditions.**

* If the author retains interleaving for `∥`: `O1b` becomes almost mandatory (same mechanism, plus a join); revise in that direction.
* If application and scoped operation are decided with the extension "link transmissible on a program channel" (§4.1): the marginal cost of `O3b` drops; redo the comparison `O1b` against `O3b` (the question becomes "who holds the tree: the program or the handler?").
* If `thm:correspondance_niveaux` fails on layer 2: `O1b` loses its correctness; fall back on `O4b`.
* If a single log is wanted for observation and for the replay of P4: examine `O2c`.
* If a static bound on spawnings becomes a grade of the language: `O3c` becomes viable.
* If reading the body of the session machine designated in ch. 4 (not done, §9) shows that the interleaving of the metalanguage is fixed there by a deterministic sequential strategy: re-examine `O2c`, whose total log would then be deterministic by construction.

## 9. Level of verification and what remains to be done

**Facts about the manuscript.** Checked in the repository at the date of writing: each cited label exists, the statements are cited from their text.

**Translation sketches, costs, leak findings.** The writer's reasoning on the text of the manuscript; **no** mechanical check, no proof. The costs `S`, `M`, `L` are unmeasured estimates.

**External sources.** Publishers' pages and arXiv are inaccessible from the session (checked by request: no answer). Nothing above relies on an article reread for this study. Only what the repository contains is cited:

| Work | What is said about it here | Level of verification |
|---|---|---|
| Das, Hoffmann, Pfenning (2018), `dasParallelComplexityAnalysis` | deals with parallel complexity with temporal session types; **to be read before deciding** to see how a spawned process is counted | title and notice in `docs/bibliography/references.json`, corpus note (`docs/research/corpus.md`); body not reread here |
| Caires and Toninho (2026), `cairesLinearSessionAbstract2026` | linear session machine, deterministic sequential strategy according to the manuscript; its handling of interleaving is not known | citation in the manuscript (`sec:g-semantique`, `sec:c4-le-calcul-de-processus`); body not reread here |
| Fournet and Gonthier (1996), `fournetReflexiveCHAMJoincalculus1996` | join patterns and sorts of the target calculus (handler as a join pattern) | citation in the manuscript; body not reread here |
| Stefan et al. (2012), `stefanAddressingCovertTermination2012` | place actions whose duration depends on secret values in separate, labelled threads; a lead for `O4b` | corpus note ("read partially" in the collection); body not reread here |
| Borgström et al. (2016), `borgstromSortedSemanticFramework2016` | borrowed sort framework (equivariance conditions, uncertainty no. 5) | citation in the manuscript; body not reread here |

**To do, in order.** (1) Settle `ANOM-18`. (2) Read Das, Hoffmann and Pfenning on the treatment of a spawned process. (3) Write the handler (`E8`), whatever the option. (4) Carry out the induction of `thm:correspondance_niveaux` on layer 2. (5) Only then, write the `spawn` clause and extend `thm:chaine_fils`.
