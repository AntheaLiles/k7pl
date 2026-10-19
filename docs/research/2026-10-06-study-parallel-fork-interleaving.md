<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Comparative study: `∥` and `vmap`, fork-join versus interleaving

> **Status: non-normative archived research material.** This study comes from PR #10 (archive commit `d39d012`), which was closed without merge. It has not been reviewed or ratified by the author. This is an English translation made on 2026-10-14; the original French text and its exact provenance are recorded in the [PR #10 archive recovery lot](../migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md), § 4 (deposit V-02). In case of discrepancy, the original prevails. The current normative source is `spec/`; nothing below describes `main` unless an editorial note says so.

> **Editorial note (2026-10-14): scope of the archived facts.** The "verified facts" of § 2 and every label, rule and statement cited below were read on the archive state `d39d012`, not on `main`. Checked against `main` at `7af5581`:
>
> - the following labels are not defined anywhere under `spec/Spec/` on `main`: `eq:reductions-orientees`, `eq:reductions-couche2`, `eq:traduction-fils`, `eq:relation-sessions-mondes`, `thm:chaine_fils`, `thm:correspondance_niveaux`, `tab:invariants-de-passe`;
> - `spec/Spec/C4/SemantiqueOperationnelle.lean` on `main` has no reduction scheme for `∥` or `vmap`: its reduction blocks are `eq:reductions-pures` (l. 42) and `eq:reductions-effets` (l. 82). The statement below that fork-join is "applied, to be ratified" describes the archive, not `main`;
> - the correction of `thm:determinisme_parallele` said to have been made "in session 31" is not on `main`: `docs/tracking/DECISIONS.md`, l. 48, lists the orientation of its depth comparison as an open decision;
> - "session 31" and "session 32" are review-session records of the archive; they are not deposited in `main` (see the lot, § 3.1). The quotation attributed to the author in the opening paragraph is the archive's attribution; it is not recorded in `docs/tracking/DECISIONS.md`, which states that none of the decisions the archive attributes to the author is decided in `main` (l. 123);
> - this is material for stage E (`docs/tracking/PROJECT-MASTER-PLAN.md`, § 8, l. 232-246), whose state is NOT STARTED (same file, l. 46).
>
> Rewritten in this translation: the bibliography file is cited at its current path, `docs/bibliography/references.json`; the link to the sister study points to its deposited translation. All other text, formulas, notation, labels, citation keys and tables are translated or kept verbatim, without correction.

**Session 32 (6 October 2026), part C.** Answer to the author's decision: « *pour faire un choix éclairé j'ai besoin d'avoir une analyse des possibilités au regard de l'état actuel du manuscrit* » ("to make an informed choice I need an analysis of the possibilities with regard to the current state of the manuscript").

**Status.** No choice is made here and the manuscript (`spec/`) is not modified. Fork-join is **applied, to be ratified** (`DECISIONS.md`); this study does not undo it, it says what it costs and what the other routes would cost. The opinion of §8 is an opinion, with its revision conditions. The translation clauses are sketches not checked by machine. The facts about the manuscript are checked in the repository; the proof costs are the writer's estimates. Sister study: [`study-spawn-time-thread`](2026-10-06-study-spawn-time-thread.md) (see §6).

## 1. In brief

**The question.** `c1 ∥ c2` and `vmap v w` are reduced today by **fork and join** (`eq:reductions-orientees`): each branch runs from the empty trace, and the trace of the configuration is extended by **a single event**, `π(τ₁) ∥ π(τ₂)`. The alternative is **interleaving with one trace per branch**: the branches become fibrils, the trace a partial order from layer 3 on.

**The variants.**

| | Variant | In one sentence |
|---|---|---|
| `V0` | big-step fork-join (applied, route B) | one step whose premise runs the branches; one aggregated event |
| `V1` | unfold into a sequence (route A, set aside) | `c1 ∥ c2 → let x ← c1 in let y ← c2 in return (x, y)`; distorts the depth |
| `V2` | interleaving (route C) | branches as fibrils, structural join; `V2a` free scheduler and diamond lemma, `V2b` deterministic policy |
| `V3` | fork-join with structured trace (hybrid, **proposed here**) | `V0` but the trace keeps the events of the branches, in parallel composition |
| `V4` | `∥` as sugar for `spawn`, box and guard | set aside because of its cost |
| `V5` | cost semantics separate from reduction | set aside by the "a single object" principle (`sec:g-semantique`) |

**What is solid.**

1. `V1` and `V4` distort the bound that the type announces (depth for `V1`, work and depth for `V4`); `V5` contradicts a written principle of the text.
2. **`V0` has four holes independent of the choice between fork and interleaving** (§4): `∥` is defined on `ℰ₀` nowhere; the scheme is written on triples whereas `Par` does not say "layer 3"; the merge `μ₁ ⊎ μ₂` lacks its lemma; the monotonicity of `∥` is used without being stated.
3. **The text is ambivalent** about what `∥` is: five places say "interleaving" or "members of the multiset", one (the scheme, with which the big-step clause of the logical relation agrees) says "fork-join", one says "deterministic on layer 3" (§2). The choice therefore does not add an idea to an unambiguous text, it settles an ambivalence.
4. **`V0 → V3 → V2` is a sequence in which each step refines the previous one** through a forgetful map (`π`): the statements of step `n` are those of step `n+1` composed with `π`. One can therefore advance without throwing away any proof.

**Opinion** (§8): keep `V0` while repairing its four holes (cheap), move to `V3` if the author wants the partial trace from layer 3 on at the lowest price, do **not** do `V2` before layer 2 has its preservation (typing of configurations, preservation along chains), which it would inherit.

## 2. What the manuscript says today (verified facts)

| Fact | Where |
|---|---|
| `Par`: `Δ₁ + Δ₂ ⊢ c₁ ∥ c₂ : F_{ε₁∥ε₂}(V₁ ⊗ V₂) \| ε₁ ∥ ε₂`. `Vmap`: `Δ₁ + n·Δ₂ ⊢ vmap v w : F(Vec n W) \| ⟨n·w(ε), s(ε)⟩`. **No layer condition** | `eq:regles-parallele` (§3.2, `sec:g-parallelisme`) |
| `⟨w₁,s₁⟩ · ⟨w₂,s₂⟩ = ⟨w₁+w₂, s₁+s₂⟩`, `⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁+w₂, max(s₁,s₂)⟩`; `∥` is said to be commutative on `ℰ₀`; exchange law `(a·b) ∥ (c·d) ⊑ (a∥c)·(b∥d)` (stated, without label) | `eq:cout-parallele` |
| Temporal factor: `ℰ = ℰ₀ × (ℕ∞ × ℕ∞)^ℒ` | `eq:grammaire-types`; `ANOM-18` |
| Fork-join: premise `⟨cᵢ \| μ \| ∅⟩ →* ⟨return vᵢ \| μᵢ \| τᵢ⟩`, conclusion `τ · (π(τ₁) ∥ π(τ₂))` and `μ₁ ⊎ μ₂`; `vmap` likewise on `n` branches. « Cette orientation n'est pas la plus fidèle : l'entrelacement avec une trace par branche, ordre partiel dès la couche 3, la prolongerait » ("This orientation is not the most faithful: interleaving with one trace per branch, a partial order from layer 3 on, would extend it") | `eq:reductions-orientees` (§4.7) |
| `μ₁`, `μ₂` « ont des supports disjoints, ce que l'addition des contextes de `Par` garantit par la linéarité des capacités d'écriture » ("have disjoint supports, which the addition of the contexts of `Par` guarantees through the linearity of write capabilities") (prose, without lemma) | `sec:g-semantique` |
| The relation is « déterministe sur la couche 3 » ("deterministic on layer 3"), « ce dont dépend le rejeu de P4 » ("on which the replay of P4 depends"); it « se relève aux configurations concurrentes … sans que le déterminisme de la couche 3 soit perdu » ("lifts to concurrent configurations … without the determinism of layer 3 being lost") | introduction of `sec:g-semantique` |
| `thm:determinisme_parallele` (theorem): same values, different effects on the depth « où le second majore le premier » ("where the second bounds the first from above") (statement corrected in session 31). **The sketch speaks of interleaving**: « l'entrelacement ne distingue aucun état » ("interleaving distinguishes no state") | `sec:g-parallelisme` |
| `thm:surete_spatiale`: « deux membres du multi-ensemble de calculs, composés par la règle `Par` » ("two members of the multiset of computations, composed by the `Par` rule") | `sec:c4-modeles-de-memoire` |
| P4: layer 3 « déterministe _par construction_ : deux branches parallèles n'ont aucun endroit où interférer » ("deterministic _by construction_: two parallel branches have nowhere to interfere") | `Postulats` (ch. 1) |
| P3 bounds **both** components: « le travail, nombre total de pas, et la profondeur, longueur du plus long chemin de dépendances » ("the work, total number of steps, and the depth, length of the longest dependency path") | `Postulats` (ch. 1) |
| Under concurrency (layer 2), `τ` « cesse d'être une suite » ("ceases to be a sequence"): labelled partial order; `Loc` lifts the layer-3 schemes (`τ ◁_p τ₀`) | end of `sec:g-couche2`; `eq:reductions-couche2` |
| `thm:preservation`: `τ'·ε' ⊑ τ·ε`, « le long de chaque chaîne » ("along each chain") under concurrency; the `∥` case « repose sur la préservation le long des suites de pas des branches » ("rests on preservation along the step sequences of the branches"); **typing of configurations not written** | `thm:preservation` (§4.7) |
| Logical relation: the `F_ε V` clause is big-step (`c ⇓ (v, τ)`), equality of traces after `π^♭_ℓ` | `eq:relation-logique` |
| `thm:action_parallele`: `φ_r(ε₁ ∥ ε₂) = φ_r(ε₁) ∥ φ_r(ε₂)`, proof on the two temporal components only | `sec:c2-la-comonade-exponentielle-et`, `thm:action_parallele` |
| "A single object": `→` is the definition of execution « et rien d'autre ne l'est » ("and nothing else is") | `sec:g-semantique` |
| Preservation order `P_dén`, `P_grad`, `P_trace(ℓ)`, `P_repr`; rule « une unité `ℓ`-sensible n'admet que les passes `P_trace(ℓ)` » ("an `ℓ`-sensitive unit admits only `P_trace(ℓ)` passes"); it « localise le conflit entre P3 et la non-interférence temporelle sans le résoudre » ("localises the conflict between P3 and temporal non-interference without resolving it") | `tab:invariants-de-passe` (§6.1, `sec:c6-le-processus-de-compilation`) |
| `thm:determinisme_observationnel` (conjecture): same projections for two interleavings, under `𝒟_𝒮` | `sec:c2-le-systeme-de-raffinement` |
| Threaded time thread, log `J_k`, projection `π^♭_ℓ`, session clause | `eq:traduction-fils`, `thm:chaine_fils`, `eq:relation-sessions-mondes` |

**The map of ambivalences.** Interleaved reading: P4 ("nowhere to interfere"), the sketch of `thm:determinisme_parallele`, `thm:surete_spatiale` ("members of the multiset"), the exchange law ("interleaving never costs more than sequencing in slices"), the sentence of `eq:reductions-orientees` on faithfulness. Fork-join reading: the scheme `eq:reductions-orientees`, the big-step clause of the logical relation. "Functional" reading: "deterministic on layer 3". The three cannot all be literally true of the same semantics: free interleaving makes `→` non-functional (determinism then becomes a confluence theorem, not a property of the relation).

## 3. Grid: what every variant must hold

| | Requirement | Source |
|---|---|---|
| `F1` | **value**: `c₁ ∥ c₂` returns the value of the sequence | `thm:determinisme_parallele` |
| `F2` | **depth bound**: the sequence bounds the parallel from above; preservation `τ'·ε' ⊑ τ·ε` holds for the contractum | `thm:determinisme_parallele`, `thm:preservation` |
| `F3` | **work and depth**: both components are bounded, and the depth is "the longest dependency path"; that of `vmap` does not depend on `n` | P3, `eq:regles-parallele` |
| `F4` | **determinism** of `→` in layer 3 and replay of P4 | `sec:g-semantique`, P4 |
| `F5` | **memory**: `μ₁`, `μ₂` disjoint, no concurrent mutation typable | `thm:surete_spatiale` |
| `F6` | **effect log**: source trace `τ`, target log `J_k`, simulation | `thm:simulation`, `eq:traduction-fils` |
| `F7` | **layer 2**: place of `spawn`, of `guard`, of `Loc`, and layer-2 branches | `eq:reductions-couche2` |
| `F8` | **progress** | `thm:progres` |
| `F9` | **graded preservation** and **non-interference**; `P_trace(ℓ)` | `thm:preservation`, `thm:non_interference`, `tab:invariants-de-passe` |
| `F10` | **proof cost** and debt on sealed statements | — |

## 4. Four holes of `V0`, independent of the choice

1. **`∥` on `ℰ₀` is not defined.** `eq:cout-parallele` defines `∥` only on the temporal factor; the text asserts that `(ℰ₀, ∥, 1)` is commutative without saying which operation it is. `thm:determinisme_parallele` avoids it by restricting itself to layer 3, where `ℰ₀` is neutral. Any variant that lets a `∥` carry layer-2 effects must define `∥` on `ℰ₀` (union, commutative shuffle of operation words: a modelling choice).
2. **The scheme is written on triples.** The premise `⟨cᵢ | μ | ∅⟩ →* …` has neither boxes nor pool; `send`, `guard`, `spawn` are global rules of layer 2. A branch that contains them is therefore **stuck** in the premise, and `c₁ ∥ c₂` does not reduce, without for all that waiting for a message: progress (its global form) falls. `Par` has no layer condition. One must either restrict `Par` to layer 3 (as `thm:determinisme_parallele` does in its statement), or lift the scheme to quadruples.
3. **`μ₁ ⊎ μ₂` lacks its lemma.** That `⊎` is defined is said in prose ("which the addition of the contexts guarantees"). A **support** lemma is missing: an execution typed under `Δ_i` writes only in the regions of its capabilities. `thm:surete_spatiale` says that no concurrent mutation is *typable*, not that execution respects its support. Without this lemma, the rule may fail to apply to a well-typed term (progress). The shared-state variants (`V2`) need it for every step (commutation): cost `M`, **common to all variants**.
4. **The monotonicity of `∥` is used without being stated** (« que ce document n'énonce pas », "which this document does not state", sketch of `thm:preservation`). On pairs of integers it is immediate. Checked by enumeration (pairs in `[0, 6]²`, writer): commutativity, associativity, monotonicity, `max(s₁, s₂) ≤ s₁ + s₂` componentwise, and the exchange law, strict in some cases.

To these holes is added `ANOM-18`: if `κ` is a family indexed by level, `∥` acts level by level, and the aggregated event `π(τ₁) ∥ π(τ₂)` is a family.

## 5. The variants

### 5.1 `V0`: big-step fork-join (applied)

**Definition.** Rule of `eq:reductions-orientees`:

```
⟨c₁ ∥ c₂ | μ | τ⟩ → ⟨return (v₁, v₂) | μ₁ ⊎ μ₂ | τ · (π(τ₁) ∥ π(τ₂))⟩
    si ⟨cᵢ | μ | ∅⟩ →* ⟨return vᵢ | μᵢ | τᵢ⟩   (i = 1, 2)
```

`vmap` is the same scheme on `n` branches `(force v) wᵢ`.

**Sorts and translation.** The time thread for `∥` requires a bifurcation and a join of chains, and **no new capability** (the links travel along a thread, at the same level). Sketch, with `L = lev(ε₁) ∪ lev(ε₂)`:

```
⟦c₁ ∥ c₂⟧_{z,t⃗,t⃗'} =
  (ν x₁ x₂)(ν (u¹_k, u¹'_k, u²_k, u²'_k)_{k∈L}) (
      ∏_{k∈L} t̄_k⟨par, u¹_k, u²_k, t'_k⟩ | ∏_{k∉L} [t_k ↔ t'_k]
    | ⟦c₁⟧_{x₁,u¹,u¹'} | ⟦c₂⟧_{x₂,u²,u²'}
    | ∏_{k∈L} (ū¹'_k⟨end⟩ | ū²'_k⟨end⟩)
    | x₁(a) & x₂(b) ▷ z̄⟨(a, b)⟩ )
```

The handler, on `par`, listens on `u¹` and `u²`, and resumes the chain `t'_k` only after having received `end` on both (a join pattern, already in `eq:metalangage`). The `end` messages are emitted right away: they wait on the last link of each branch, which the handler listens to only after the last event of the branch. Each link is still produced once and consumed once. The `par` marker does not leak, under the same condition as the `fork` of the sister study (`L ⊒ niv(Δ)`, by `thm:correspondance_niveaux`). For `vmap`, the join has arity `n`, defined by induction on `n`, which is closed at compile time.

**Point of substance.** The target log records the events **of the branches**, one by one (aggregating them would require a local collector that receives links, which the "receive" row of `tab:capacites` forbids to a translated term, or a local handler created by the program, which `thm:confinement_sortes` forbids). The source trace, for its part, has **one aggregated event**. The simulation therefore relates `τ'` to `J` **through `π`**: `π(J') = τ'`, a relation, and not "`τ'` extends `τ` by the image of the events of the step", which presupposes that the image of the aggregated event can be read in `τ'` (it cannot: the `τᵢ` are thrown away). The simulation clause is to be written in existential form.

**What it imposes / breaks.** The four holes of §4. `thm:progres` for `∥`: see hole 2 and hole 3. Mixing a big step and a small-step relation: preservation proceeds by induction on the derivation of the step, with a sub-induction on the length of `→*` in the premises (this is what the sketch announces). The depth as "longest dependency path" (P3) **is not provable** in the source semantics: the trace does not contain the dependency graph, the depth of `∥` is defined by `max`. The statement of P3 on depth is then a composition convention, not a theorem about executions.

**Proof cost.**

| Item | |
|---|---|
| four holes of §4 (`∥` on `ℰ₀` or restriction, scheme or restriction of `Par`, support lemma, monotonicity) | M + S + M + S |
| `∥` and `vmap` cases of `thm:preservation` | S (the induction exists) |
| `thm:determinisme_parallele`: the sketch to be aligned with the semantics | S |
| translation of the thread for `∥` (bifurcation and join) and its simulation modulo `π` | M + M |
| session clause: comparison of forests with join | M, common to `V2`, `V3` |

Total: **M**, sealed statements intact.

**Risks.** The source semantics is coarser than the target (aggregation), which weighs on every statement that relates the two (`PREUVE-03`, `PREUVE-07`). The big step freezes the choice "the branches do not talk to each other": `∥` will never be able to cover layer-2 branches without a new rule.

### 5.2 `V1`: unfold into a sequence (route A, set aside)

`c₁ ∥ c₂ → let x ← c₁ in let y ← c₂ in return (x, y)`. The contractum has effect `ε₁ · ε₂`, of depth `s₁ + s₂`, which does not satisfy `ε₁ · ε₂ ⊑ ε₁ ∥ ε₂` as soon as both depths are non-zero: preservation `τ'·ε' ⊑ τ·ε` is false for the depth, and the depth of `vmap` would depend on `n`. P3 bounds both components, `V1` holds only one. It is cited only as a baseline: it shows that the parallel content of `∥` is **in the depth**, and that every variant must carry it in the trace or in the type.

### 5.3 `V2`: interleaving with one trace per branch (route C)

**Definition.** `c₁ ∥ c₂` spawns two fibrils and a join; `vmap` spawns `n`. The bifurcation and join nodes are **structural**: no source event, hence no added cost (a fork event would cost `⟨1, 1⟩` and would exceed `max(s₁, s₂)`, hence would break `F2`).

```
⟨𝒫 ⊎ {p : E[c₁ ∥ c₂]} | μ | ℳ | τ⟩
    → ⟨𝒫 ⊎ {p₁ : c₁, p₂ : c₂, p : join(p₁, p₂; E)} | μ | ℳ | τ'⟩      -- λ(p₁) = λ(p₂) = λ(p), aucun événement
⟨𝒫 ⊎ {p₁ : return v₁, p₂ : return v₂, p : join(p₁, p₂; E)} | μ | ℳ | τ⟩
    → ⟨𝒫 ⊎ {p : E[return (v₁, v₂)]} | μ | ℳ | τ[λ(p₁) ≺ p, λ(p₂) ≺ p]⟩
```

(with the notation `τ[s ≺ p]` of the `Guard` rule, and `λ(q)` the last event of `q`, which "resuming after" of `Spawn` already presupposes.) The arena `μ` is **shared**: no merge, but a lemma of commutation of independent steps.

* **`V2a`, free scheduler.** `→` is no longer functional in layer 3. Determinism becomes a theorem: **diamond lemma** (two independent steps commute), then confluence, then `thm:determinisme_parallele` as a corollary (this is at last the meaning of its sketch: "interleaving distinguishes no state"). Replay of P4 in layer 3 remains log-free if confluence holds.
* **`V2b`, deterministic policy** (left first, or alternation). `→` remains functional. But the adequacy of a truly parallel execution (vectorised, several cores) to the semantics requires the same confluence: `V2b` does not dispense with the diamond, it hides it.

**Sorts and translation.** The same as `V0` (chain bifurcation, `end`, join at the handler); the difference is on the source side: each step of a branch is a source step, each event a source event, and **the image is read event by event**, without aggregate (`F6`: the simulation keeps its form).

**What it imposes.**

* The **typing of configurations** (pool, `join`, boxes) and **preservation along chains**, which the manuscript does not write for layer 2: `V2` therefore makes **all of layer 3 that uses `∥`** depend on unwritten things. Today the preservation of layer 3 is proved on the blocks `eq:reductions-pures` and `eq:reductions-effets`; with `V2`, every program that contains `∥` depends on them as well.
* The relation `⇓` of the logical relation (`eq:relation-logique`) must be defined on concurrent configurations, with a partial order as output.
* `thm:determinisme_observationnel` (conjecture) sees its scope grow: every `∥` is a source of interleaving. By confluence, in layer 3 the trace-poset is independent of the interleaving, so the conjecture is provable there by the diamond; but the hypothesis `𝒟_𝒮` (the policy does not consult any high value) must be stated for layer 3.
* **`∥` generalises to layer 2**: the branches may send, receive, spawn; the join waits for both. This would be the structured concurrency of the language, `spawn` being the case without join. It is a gain in faithfulness (`F7`), and hole 1 (`∥` on `ℰ₀`) becomes blocking.
* **Depth** becomes a theorem again: the depth of an execution is the weight of the longest chain of `τ`, and the chain that crosses a bifurcation chooses one branch, hence `≤ max(s₁, s₂)` plus the rest. P3 ("longest dependency path") finds its definition there.

**Proof cost.**

| Item | |
|---|---|
| typing of configurations with `join` | L (already due for layer 2) |
| preservation along chains, cases `∥`, `vmap` and `join` | L (already due for layer 2) |
| diamond lemma and confluence, with support lemma | M to L, **new** |
| `τ` poset in layer 3, `π` on posets, concurrent `⇓` | M |
| global progress with `join` | M |
| `thm:determinisme_parallele` made substantial | M |
| four holes of §4 | M + S + M + S (hole 3 becomes the commutation lemma) |

Total: **L**, the largest part of which is **debt already registered for layer 2, brought forward**.

**Risks.** Making the preservation of layer 3 depend on the machinery of layer 2 before it is written; non-functionality of `→` to be documented against the sentence "deterministic on layer 3" (or policy `V2b`); loss of the reading "no big step inside small steps". Gain: a single notion of trace, a single definition of depth, `∥` covering layer 2.

### 5.4 `V3`: fork-join with structured trace (hybrid)

**Definition.** We keep the rule of `V0` (big step, premise on triples, functional `→`) and change **what is written in the trace**: not the aggregate `π(τ₁) ∥ π(τ₂)`, but the parallel composition of the traces of the branches.

```
⟨c₁ ∥ c₂ | μ | τ⟩ → ⟨return (v₁, v₂) | μ₁ ⊎ μ₂ | τ · (τ₁ ∥ τ₂)⟩
    si ⟨cᵢ | μ | ∅⟩ →* ⟨return vᵢ | μᵢ | τᵢ⟩
```

`τ` lives in **series-parallel posets**: words are their chains, `·` is series composition, `∥` parallel composition, `𝟏` the unit. `π : SP → ℰ` is the morphism defined by induction on the structure (`π(τ·τ') = π(τ)·π(τ')`, `π(τ ∥ τ') = π(τ) ∥ π(τ')`); `π^♭_ℓ` is defined by induction as well (filter the events in each component), without speaking of induced sub-order.

**What changes with respect to `V0`.** (i) The trace is partial **from layer 3 on**, but without pool, without scheduler, without diamond. (ii) The image of the target log (forest with join, §5.1) **is read event by event**: the simulation recovers its form. (iii) The depth is the weight of the longest chain of `τ`: the lemma `profondeur(τ) = π_profondeur(τ)` is an induction on the structure, an `S` case, which gives P3 a definition independent of the composition law of typing. (iv) `thm:preservation`: its statement already says "under concurrency, `τ` is a partial order"; it is not modified. The inequality of the `∥` case is that of `V0` composed with `π`.

**What it leaves.** The four holes of §4 (unchanged). The big step inside a small-step relation. The layer-2 branch remains excluded (`V3` does not generalise `∥`).

**Proof cost.**

| Item | |
|---|---|
| all of `V0` | M |
| algebra of series-parallel posets, `π`, `π^♭`, their properties | M |
| `Loc`: place a poset after the last event of `p` | S |
| lemma depth = longest path | S |

Total: **M**, a little more than `V0`, clearly less than `V2`.

**Risks.** One more data structure to maintain (series-parallel posets); the big step remains to be lifted if `∥` must one day carry layer-2 branches; the trace is finer than that of `V0`, which makes `P_trace(ℓ)` a little more demanding inside a `∥` (§7).

### 5.5 `V4` and `V5`, for the record

**`V4`, sugar for `spawn`.** `c₁ ∥ c₂` would be `let b ← new in let _ ← spawn (let v ← c₂ in send res(v) to b) in let v₁ ← c₁ in guard b {res(v₂) ↦ …}`. The cost: the child emits `send` (`⟨1,1⟩`), so the work is `w₁ + w₂ + 1` and the depth `max(s₁, s₂ + 1)`, strictly more than `ε₁ ∥ ε₂` (checked by enumeration, §4). P3 forbids hiding a cost, and `∥` would no longer be a constructor of layer 3 (which « n'a pas à être vérifiée », "need not be checked") but of layer 2. Set aside.

**`V5`, separate cost semantics.** Reduce `∥` in sequence for the values (`V1`) and compute work and depth by a distinct big-step judgement. The trace would no longer carry the depth, and the text posits "a single object" (`sec:g-semantique`, « la relation `→` … est la définition de l'exécution, et rien d'autre ne l'est », "the relation `→` … is the definition of execution, and nothing else is"). Set aside on principle; the idea overlaps with the graph-based cost semantics of the literature, which this repository has not investigated (§9).

## 6. Relation to layer 2 (`spawn`, `guard`) and to the study on `spawn`

Three kinds of edge of the partial order: **bifurcation** (`spawn`), **join** (what `∥` adds), **message** (`τ[s ≺ p]` of `Guard`). `spawn` is a bifurcation without join; `∥` a bifurcation with join; `guard` a transversal edge.

* Under `V2`, all three live in one partial order; under `V0` and `V3`, `∥` is a big-step construction of layer 3 and layer 2 has its own order.
* The thread translation of `∥` (bifurcation, join) **is** that of `spawn` (bifurcation) with one more `end`. If the sister study retains bifurcation by link (`O1b`), `∥` inherits it cheaply; if it retains a thread supplied by the handler (`O3`), the join is done in the handler, which already holds the filiation.
* **The meaning of "depth" differs**: `Spawn` announces depth `0` for the mother (« rien à la profondeur de la mère », "nothing at the mother's depth", `eq:regles-couche2`), the child accounting for its depth on its own side; `∥` announces `max(s₁, s₂)`. On a unified poset, the longest chain that crosses the `spawn` edge may exceed the mother's depth: "along each chain" of `thm:preservation` must be read **per fibril** for `spawn` and **per path** for `∥`. To be fixed in any unified poset.
* `∥` is not derivable from `spawn` (`V4`) without cost.

## 7. Graded preservation, `P_trace(ℓ)`, non-interference

**`P_grad`** (the graded judgement is preserved by the lowering passes, `ARB-PR-06`). `Δ₁ + Δ₂` sums the grades: under all variants, the "usage" part of graded preservation for `∥` reduces to the support lemma (hole 3). `V2` adds the commutation property to preservation; `V0` and `V3` have it in their merge `μ₁ ⊎ μ₂`.

**`P_trace(ℓ)`** (the projected trace `π_ℓ(τ)` is preserved in an `ℓ`-sensitive unit). The rule already excludes from these units the passes that change the trace (fusion, deforestation, inlining). Three findings:

* A pass that **serialises** a `∥` (unfold into a sequence) or that **creates** one (parallelise a loop) changes the depth, hence `π_ℓ(τ)`: excluded from the `ℓ`-sensitive unit under **all** variants.
* The rewrites of the exchange law `(a·b) ∥ (c·d) ⊑ (a∥c)·(b∥d)` (strict in general, checked) change the depth: same conclusion.
* **The only difference**: inside a `∥`, `V0` exposes only the aggregate per branch (a pass that reorders events with the same `π` is invisible there), `V3` and `V2` expose the events. In `ℓ`-sensitive units the rewriting passes are already excluded; elsewhere there is no constraint. `P_trace(ℓ)` **therefore does not separate** the variants, except for intra-branch reorderings.

**Non-interference.** The communication-free fragment is proved (`thm:lemme_fondamental`), whose computation clause is big-step (`⇓`): it agrees with `V0` and `V3` without work. `V2` requires defining `⇓` on concurrent configurations (trace-poset). Under `thm:correspondance_niveaux`, the events of a branch have level `⊒ niv(Δ)`: the granularity of the trace (aggregate or events) **creates no leak**, a level `ℓ` that does not read `niv(Δ)` sees neither the one nor the other.

## 8. Examples

**`E1`: `vmap f [a, b, c]` with `f = tick` (one level).**

| Variant | Trace |
|---|---|
| `V0` | `τ · ⟨3, 1⟩`: one aggregated event (work 3, depth 1) |
| `V3` | `τ · (t ∥ t ∥ t)`: three incomparable events, `π = ⟨3, 1⟩` |
| `V2` | three fibrils `p₁ p₂ p₃`, three incomparable events, three-way join; same poset as `V3` |
| `V1` | `τ · t · t · t`, `⟨3, 3⟩`: depth that depends on `n` |

**`E2`: `∥` with a layer-2 branch.** `c₁ = send ping() to ι`, `c₂ = tick`. `V0` and `V3`: the premise has no rule for `send` on a triple, the term is stuck without waiting for any message (hole 2). `V2`: `p₁` sends, `p₂` ticks, the join returns `((), ())`.

**`E3`: `V4` in figures.** `c₁ = tick`, `c₂ = tick`. `ε₁ ∥ ε₂ = ⟨2, 1⟩`. Under `V4`, the chain that crosses the child counts its `tick` then its `send`: the depth is at least 2 (`max(1, 1+1)`) and the work at least 3 (the two `tick` and the `send`), more than `⟨2, 1⟩` (the provision of `spawn` is added to the work on top of that, `eq:regles-couche2`).

## 9. Comparative table

| | `V0` applied | `V1` sequence | `V2a` free interleaving | `V2b` fixed policy | `V3` hybrid |
|---|---|---|---|---|---|
| `F1` value | by the premise | by construction | diamond | diamond (hidden) | by the premise |
| `F2` depth | yes (`max`) | **no** | yes, per chain | yes, per chain | yes (`max`) |
| `F3` depth = longest path | convention | no | theorem | theorem | theorem (lemma `S`) |
| `F4` `→` functional in layer 3 | yes | yes | **no** (confluence) | yes | yes |
| `F5` memory | `⊎` + support lemma | not applicable | commutation + support | same | `⊎` + support lemma |
| `F6` source trace | aggregate (poset of words) | word | poset | poset | series-parallel poset |
| `F6` simulation | modulo `π` (existential) | direct | direct | direct | direct |
| `F7` layer-2 branches | no (hole 2) | no | **yes** | yes | no |
| `F8` progress | holes 2 and 3 | yes | global, with `join` | same | holes 2 and 3 |
| `F9` `P_trace(ℓ)` | coarse intra-branch | not applicable | fine | fine | fine |
| Depends on unwritten layer 2 | no | no | **yes** | yes | no |
| Sealed statement modified | no | yes (preservation false) | no | no | no |
| Cost | M | S, **incorrect** | L | L | M |

## 10. Opinion, roadmap and revision conditions

**Opinion (not a decision).**

1. **Repair `V0` in all cases**: the four holes of §4 do not depend on the choice. They are small pieces of work (`S` to `M`) and they are due whatever comes next.
2. **`V3` is the best faithfulness-to-cost ratio** if the author wants the partial trace from layer 3 on: it keeps the functional relation and the big step, draws nothing from layer 2, recovers an event-by-event simulation (which `V0` cannot), gives P3 its definition of depth and modifies no statement.
3. **`V2`: not now.** Its cost is mostly layer-2 debt brought forward (typing of configurations, preservation along chains). In return it offers `∥` on layer-2 branches and a single notion of trace.
4. **Step-by-step roadmap**: `V0` (repaired) → `V3` → `V2`. At each step the statements of the previous one are those of the next composed with `π`: `V3` refines `V0` through `π : SP → ℰ`, `V2` refines `V3` by forgetting the fibrils. A proof carried out at step `n` is not thrown away at step `n + 1`.
5. **The ambivalence of the text (§2) is for the author to lift**: say in one paragraph which reading of `∥` is authoritative (fork-join, or interleaving of which fork-join is the step). The five passages with an interleaved reading are not false under `V0`, but they speak of something other than what the rule writes.

**Revision conditions.**

* If the author wants `∥` on layer-2 branches (structured concurrency): `V2`.
* If the study on `spawn` retains bifurcation by link: `V3` and `V2` become cheaper (same mechanism); so does the translation of `V0`.
* If `→` is required to remain functional in layer 3: `V0`, `V3`, `V2b` (keeping the diamond in mind for parallel adequacy).
* If a scheduling theorem is required (a real-time bound as a function of work, depth and number of processors): `V3` or `V2` (the poset is needed), not `V0`; see §11, source not investigated.
* If `ANOM-18` is resolved by a scalar temporal factor: redo §4 and the translation (the join would no longer have levels to sort).
* If `thm:correspondance_niveaux` fails on layer 2: the countermeasure "bifurcate on the levels of `L`" falls, see the study on `spawn`.

## 11. Level of verification and what remains to be done

**Facts about the manuscript.** Checked in the repository at the date of writing (labels, rules, statements cited from their text).

**Mechanical checks carried out for this study** (writer's script, not versioned): on pairs of integers in `[0, 6]²`, commutativity and associativity of `∥`, monotonicity of `∥`, `max(s₁, s₂) ≤ s₁ + s₂`, exchange law (with strict cases), and the extra cost of `V4` (`max(s₁, s₂ + 1) > max(s₁, s₂)`). An enumeration is not a proof; it rules out sign errors.

**Unchecked reasoning.** The translation sketches, the costs `S`, `M`, `L`, the findings of holes (§4) are the writer's reasoning on the text, without verification by Lean or proof.

**External sources.** Publishers' pages and arXiv are inaccessible from the session (checked by request: no answer). Nothing here relies on an article reread for this study.

| Work | What is said about it | Level of verification |
|---|---|---|
| Das, Hoffmann, Pfenning (2018), `dasParallelComplexityAnalysis` | temporal session types with parallel complexity (work and depth); to be read for the composition of costs of `∥` | title and notice in `docs/bibliography/references.json`, corpus note; body not reread here |
| Stefan et al. (2012), `stefanAddressingCovertTermination2012` | separate threads for actions whose duration depends on secrets; overlaps with non-interference under concurrency | corpus note ("read partially"); body not reread here |
| Caires and Toninho (2026), `cairesLinearSessionAbstract2026` | deterministic sequential-strategy machine (according to the manuscript); its reading of parallel composition is to be checked | citation in the manuscript; body not reread here |
| Literature on graph-based cost semantics, greedy and work-stealing scheduling, and series-parallel posets | **no source in the repository**; general knowledge of the writer, unchecked, not cited in the bibliographic sense | to be investigated (research card) if the author retains `V3` or `V2` |

**To do, in order.** (1) Repair the four holes of `V0` (`S` to `M`). (2) Align the sketch of `thm:determinisme_parallele` with the retained semantics. (3) Decide the reading of `∥` (§10, point 5). (4) Investigate the literature on parallel cost before `V3` or `V2`.
