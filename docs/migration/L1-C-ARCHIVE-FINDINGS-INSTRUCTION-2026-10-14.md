<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Stage C instruction of the scientific findings of the PR #10 archive

**Revision examined:** `main`, SHA `99a7375e764e86b3c19c19be82accd8db6096a91` (13 October 2026). No file of `spec/` or `src/` changes up to `06f8466`.
**Archive:** branch `valuable/claude/lean4-reuse-init-qvzlcg`, commit `d39d012`, PR #10 closed without merge; review of the archive in [`BRANCHES-STATUS.md`](../tracking/BRANCHES-STATUS.md), section 5.
**Mandate:** decision of the author of 13 October 2026: « instruire en C les constats scientifiques de l'archive » ("examine the scientific findings of the archive in stage C").
**Overall verdict: no C object is closed; C gate NOT MET.** Non-normative report. No modification of the manuscript is made or presented as made; no author decision is inferred.

## 0. Method and status

The findings of the archive often bore on a text that the archive itself had modified afterwards (schemes of sessions 29 and 32, the `maillon` kind, `eq:traduction-fils`, `thm:chaine_fils`). None of these additions is in `main`. Each finding is therefore judged again against the text of `main` only.

Four adversarial reviews, read-only, examined the findings on 14 October 2026. Their arguments are **paper sketches, not mechanised**. The counterexamples were moreover recomputed on finite models by scripts outside the repository; this computation checks the examples, it proves nothing in general. No Lean code of `src/` covers the objects examined: `src/K7pl/Semantics.lean` is a toy LTS, `src/K7pl/WhenBoundary.lean` an accounting contract which "does not define the operational `When` rule", `src/K7pl/GradeBudget.lean` deals with neither `φ_n`, nor `w`, `s`, `δ`.

Verdicts used: **confirmed** (counterexample or explicit argument), **refuted**, **depends on a choice** (options and consequences), **undetermined** (what is missing).

| § | Finding | Verdict | Objects |
|---|---|---|---|
| 1 | `φ_n` and monoid morphism | confirmed in the free model; scope depending on the meaning of `End_mon`; **new defect at the ω case** | C-01, C-03, C-06, C-09 |
| 2 | monotonicity in `ℓ` of the logical relation | confirmed on the unrestricted universe; no statement of `main` invokes it | C-02, C-07, C-09 |
| 3 | temporal forms and `thm:progres` | confirmed for `delay`; depends on a choice for `always`/`now`; undetermined for `when` | C-04, C-07 |
| 4 | terminal forms of `thm:progres`; `Guard` and join | confirmed | C-07 |
| 5 | `spawn`, `send`, `guard`: translation, coupling, `w`/`s`, `Tick` | textually confirmed; consequences depending on a choice | C-01, C-05, C-07; stage F |
| 6 | singularities of wheels (`1/0`, union rule) | sentence of the spec inexact; claims of the research note inexact for `main` | D (BLOQ-12, IMPL-07), C5 boundary |
| 7 | related findings, absent from the archive | to be examined separately | C-01, C-04, C-06, C-07 |

## 1. `φ_n` and monoid morphism

**Archive.** Session 24 (`docs/journal/2026-10-06-pr-02-24-loi-distributive.md`, l. 10-14) and `docs/recherche/instruction-des-decisions.md` (l. 94-96): `φ_n(ε) = ε^n` would not be a monoid morphism in a non-commutative quantale, because `(εδ)^n ≠ ε^n δ^n`; the distributive law would therefore be « affaiblie » ("weakened").

**`main`.**
- `spec/Spec/C3/ReglesDeTypage.lean`, l. 638-645: `φ_n` sends `⟨ε₀,k⟩` to `⟨ε₀^n, nk⟩`; « elle est un morphisme de monoïdes » ("it is a monoid morphism"), justified by `φ_n ∘ φ_m = φ_{nm}`, `φ_1 = id`, `φ_0` constant at the unit.
- l. 657 (`eq:monoide`): `ℳ = ⟨φ_n, π_S⟩ ⊆ End_mon(ℰ)`; l. 846-855: normal forms `(n,S)`, equality decided on this pair.
- `ℰ₀` is **non-commutative by definition**: `spec/Spec/C1/AxiomatiqueGerminale.lean`, l. 281-283 and 447-454; `ReglesDeTypage.lean`, l. 1271; `π_S` keeps the operations « dans leur ordre » ("in their order") (l. 647-649). The temporal factor is additive, hence commutative.
- Distributive law: `AxiomatiqueGerminale.lean`, l. 317-321 (`λ_{r,ε}`, « loi distributive graduée », "graded distributive law"); l. 340 restricts the relation between `φ_n` and `Φ_dist` « aux cas et hypothèses explicitement démontrés » ("to the explicitly proved cases and hypotheses"), whereas `ReglesDeTypage.lean`, l. 639-641, identifies them.

**Analysis.**
- *(a) Multiplicativity.* In the free presentation (`Ops ⊇ {a,b}`, `Rel = ∅`, quantale `P(Ops*)`), `φ₂(ab) = abab` and `φ₂(a)φ₂(b) = aabb` are distinct and incomparable: for `n ≥ 2`, `φ_n` is not a monoid endomorphism of `(ℰ,·,1)`, nor a lax one. The universal formula of the archive is too strong: in `P(M)` for the left-zero band `M = {1,a,b}`, a non-commutative quantale, `φ_n = id` is multiplicative.
- *(b) What the justification proves.* `φ_n ∘ φ_m = φ_{nm}` establishes at best that `n ↦ φ_n` is a morphism from `(ℕ∞,·,1)` to `(End(ℰ),∘,id)`, not the multiplicativity of each `φ_n`. The internal clues favour the "monotone" reading of `End_mon`: `AdjonctionsEtEnrichissement.lean`, l. 385 (`→_mon`), `ReglesDeTypage.lean`, l. 667-673 and 864, `SemantiqueOperationnelle.lean`, l. 185. In the "monotone" reading, the inclusion `eq:monoide` holds; in the "monoid" reading, it is false for `n ≥ 2`.
- *(c) New defect, absent from the archive: the action law fails at the ω case.* With `ε^ω = ⋁_m ε^m` (`SixSchemasDeMetatheorie.lean`, l. 184; domain `ℕ∞` decided on 12 October 2026), `(ε^m)^ω = ⋁_j ε^{mj}`. For `ε = {a}`, `a ∉ ({a}²)^ω` whereas `a ∈ {a}^ω`: `φ_ω ∘ φ_m ≠ φ_{ωm} = φ_ω` for `2 ≤ m < ω`, even in the one-letter commutative quantale. Only the inequality `φ_ω ∘ φ_m ⊑ φ_ω` holds. Equality comes back if `1 ⊑ ε` for every `ε`, a hypothesis that the text uses implicitly (`SemantiqueOperationnelle.lean`, l. 176) but does not posit. Consequences: normal forms `(n,S)` and decidability of `ℳ`; associativity of `req:schema_reinvocation_compatibility` at the ω case; compatibility of `λ` with `δ_{r,s}`. The [C-06](L1-C06-SUBSTITUTION-AUDIT-2026-10-11.md) audit (§ "Lois déjà dérivables") presents the composition as derivable without this reservation.
- *(d) Distributive law.* Under (i) the identification `Φ_dist(n,·) = φ_n`, (ii) a `Ψ_grade` that does not modify the multiplicity (not specified) and (iii) a compatibility axiom with `μ` of strict form, the square requires `(εδ)^n = ε^n δ^n`, false in the free model. The archive's diagnosis "weakened law" is correct under these three conditions. The exact axiom of Gaboardi et al. (ICFP 2016, doi 10.1145/2951913.2951939) could not be reread.
- *Dependencies.* Affected: `eq:monoide`, C3 l. 642, normal forms, `thm:schema_reinvocation` (ω), `λ` of C1. Not affected: `thm:commutation_monoide` (multiplicativity of `π_S` only), rule Sc (monotonicity only), Inj, `thm:coherence_axiome`.

**Verdict.** Confirmed in the free model; the falsity of `eq:monoide` depends on the meaning of `End_mon`; new defect at the ω case, confirmed. Status: paper sketch, recomputed on words of length ≤ 12.

**Obligations.**
- **O-φ1.** Fix the meaning of `End_mon` in `eq:monoide`.
- **O-φ2.** Prove or restrict `φ_n ∘ φ_m = φ_{nm}` at the ω case, then derive from it normal forms `(n,S)`, decidability of `ℳ` and compatibility of `λ` with `δ`.
- **O-φ3.** Establish the status of `λ` with respect to `μ` (strict, weakened, restricted to a commutative part) under the exact axioms of the cited source, and list every rule or proof that uses it.
- **O-φ4.** The case proofs (Sc, re-invocation) use only the monotonicity of `φ_n`, never its multiplicativity.

**Author decisions.** D-φ1 (meaning of `End_mon`), D-φ2 (status of `λ`), D-φ3 (ω case): see [`DECISIONS.md`](../tracking/DECISIONS.md).

## 2. Monotonicity in `ℓ` of the logical relation

**Archive.** Session 28 (`docs/journal/2026-10-06-pr-02-28-troncature-et-conformite.md`, l. 51-54): a monotonicity in `ℓ` would be false on function types.

**`main`.** The clauses of `ℛ_ℓ` are identical to those of the archive (`spec/Spec/C4/SemantiqueOperationnelle.lean`, l. 500-521). `main` states no monotonicity in `ℓ`: `thm:non_interference`, `thm:lemme_fondamental`, `thm:divulgation_delimitee` and `thm:stratification_journal` are posed level by level. `FACT-07` is open (`docs/tracking/fiches-statuts.csv`, l. 95).

**Analysis.** For `L ⊏ H`, `b` with two values and `niv(r_H) = H`:
- direction `ℓ ⊑ ℓ′ ⇒ ℛ_ℓ ⊆ ℛ_ℓ′`: false as soon as `!_{r_H} b` (total relation at `L`, equality at `H`);
- direction `ℓ ⊑ ℓ′ ⇒ ℛ_ℓ′ ⊆ ℛ_ℓ`: provable by induction at positive types (with `π♭_ℓ = π♭_ℓ ∘ π♭_ℓ′`, plausible but not stated), fails at the `⊸` case by contravariance. Witness: the function that returns the base value of its argument, at type `!_{r_H} b ⊸ F b`.
- Reservation: this witness declassifies and is probably not well typed; the universe of terms of `ℛ_ℓ` is not fixed (`SemantiqueOperationnelle.lean`, l. 657-659). On well-typed terms, the question remains open at higher-order types.

**Verdict.** Confirmed on the unrestricted universe; undetermined on well-typed terms; no statement of `main` invalidated.

**Obligation.** **O-ℓ1.** Every proof that transports a relation between levels (`FACT-07`, `thm:divulgation_delimitee`, concurrent extension) must either prove the inclusion on the universe of well-typed terms, to be defined, or adopt a function clause quantifying over the lower levels (Kripke-style variant, not sourced here, fundamental lemma to be proved again), or do without it.

**Author decision.** D-ℓ (form of the indexing of `FACT-07`).

## 3. Temporal forms and `thm:progres`

**Archive.** `docs/recherche/instruction-des-decisions.md`, § « Les six formes temporelles » ("The six temporal forms"), and session 29: `at`, `wait`, `when` wait for values of types that no value inhabits, hence never reduce on a closed term.

**`main`.**
- Grammar of terms (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 27 and 33): `delay c | always v | at v | now v | wait v | when x = v in c` are **computations**.
- Grammar of types (`GrammaireDesTypes.lean`, l. 42-44): neither `□V`, nor `◇V`, nor `○V`, nor `○C`, nor `◇C`; `○ □ ◇` exist only on sessions.
- Rules (`ReglesDeTypage.lean`): `Del` (l. 231), `Alw` (l. 488), `Alw⁻` (l. 490), `Now` (l. 492), `Wait` (l. 498), `When` (l. 500). `Alw`, `Alw⁻`, `Now`, `Wait` conclude without `| ε`, in the format of a value judgement.
- Reductions (`SemantiqueOperationnelle.lean`, l. 50-61 and 88-95): no scheme for these six forms; contexts `E ::= [] | let x ← E in c | E v | scoped_f(v,E)` (l. 110); l. 39 nevertheless announces « exactement une [réduction] par règle d'élimination » ("exactly one [reduction] per elimination rule").
- `thm:progres` (l. 201-214): terminals `return v`, `λx.c₀`, `⟨c_i⟩_{i∈I}`.

**Analysis** (context hypothesis: `○∅ = □∅ = ∅`, not written).
- `delay`: `delay (return ())` is typed by `One`, `Ret`, `Del`, is not terminal, and no scheme or context applies: **`thm:progres` is false as stated on this term.** The only way out is to say that `○(F₁1)` is not a type, in which case `Del` concludes a non-type.
- `always`, `now`: in the "computation" reading, `always ()` and `now ()` are stuck; in the "value" reading, the canonical forms lemma becomes false (`at (always ())` is a closed value of type `1` distinct from `()`).
- `at`, `wait`: no closed term of these forms is typable in the "computation" reading; progress holds for them vacuously. The rest of the archive's finding (no reduction on a closed term) is exact.
- `when`: no closed derivation of the body of type `◇C` has been found; to be confirmed by induction. P3-B makes the waiting intended, but the configuration `⟨c ∣ μ ∣ τ⟩` has no environment component (l. 30-32) and the statement has no "waiting" form.

**Verdict.** Confirmed for `delay`; depends on a choice for `always`/`now`; refuted for `at`/`wait` as a cause; undetermined for `when`.

**Obligations.**
- **T1.** Fix the syntactic category and the judgement format of each temporal form; add the corresponding types to the grammar.
- **T2.** For each elimination, a reduction scheme or an explicit exclusion from the domain of `→`.
- **T3.** Extend the canonical forms lemma to the retained temporal types.
- **T4.** Say whether `delay c` is terminal.
- **T5.** For `when`, after P3-B, fix the form of the environmental waiting in the configuration or in the statement of progress, then establish that a body of type `◇C` is derivable.

**Author decisions.** D-T1 (category of `always`/`now`), D-T2 (representation of the waiting of `When`).

## 4. Terminal forms of `thm:progres` and join of `Guard`

**Archive.** Session 29: the list of terminal forms omits `Λα.c` and the copattern; `Guard` has one branch per message.

**Analysis on `main`.**
- `Λα.return ()` (`Ret` then `Gen`, `ReglesDeTypage.lean`, l. 1080) is closed, typed, absent from the terminal list and not reducible (only `(Λα.c)[W]` is a redex, `SemantiqueOperationnelle.lean`, l. 60): **confirmed**.
- Copattern (`Cop`, l. 1129): with an empty index, `⟨⟨⟩⟩` is typed and stuck, as is `out ⟨⟨⟩⟩`; with `J = {1}`, the witness depends on weakening. Side defect: `x` is bound there to a computation type.
- Evaluation contexts: `E` has neither `E.i` nor `E[W]`; `(let y ← return () in let () = y in Λα.return ())[W]` is stuck.
- Other closed computations without a local step: `return () ∥ return ()`, `try (return ()) catch (return ())`, `new_E`, `spawn (return ())`, `at_n (return ())`. The local statement does not restrict its domain.
- `Unfold` (l. 1074) types a computation in value format, whereas `unfold (fold v) → v` produces a value.
- `Guard` (l. 1407) binds a single message per branch; l. 1431-1432 and the sketch of `thm:sync_motifs_jonction` (`EchelleDuSysteme.lean`, l. 500-503) claim multi-place consumption as an « opération native » ("native operation"). Two nested guards consume `x` even if `y` never arrives. No reduction rule is written for `guard` nor for the four other global rules (l. 1446).
- The archive's request to « rétrograder le sceau » ("downgrade the seal") is moot under the C8 taxonomy (`under-review`, `proofsketch`), but the statement as written is refuted by these witnesses.

**Verdict.** Confirmed (the copattern under the condition of an empty index or of weakening).

**Obligations C-07.P.**
- **P1.** Align the terminal list with the retained computation introduction rules (`Ret`, `Lam`, `With`, `Gen`, `Cop`, and `Del`/`Alw`/`Now` according to D-T1).
- **P2.** Complete `E` or justify the absence of `E.i` and `E[W]`.
- **P3.** For each elimination rule (`Out`, `Fix`, `Declassify`, `Alw⁻`, `Wait`, `When`…), a scheme or a domain exclusion.
- **P4.** Delimit the domain of the local statement (sequential fragment, or global constructors treated as pool redexes).
- **P5.** Write the global rules `Spawn`, `New`, `Send`, `Guard`, `Free`, or exclude them explicitly.
- **P6.** Make the sketch of `thm:sync_motifs_jonction` conform to the actual form of `Guard`.

**Author decisions.** D-P1 (statement of `thm:progres`), D-P2 (join).

## 5. `spawn`, `send`, `guard`

**Archive.** `docs/recherche/analyses-decisions/02-spawn-et-fil-de-temps.md` (§ 2.2) and `03-anom-18-facteur-temporel.md` (§ 2).

**Analysis on `main`.**
- *Translation.* `thm:confinement_sortes` (`spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean`, l. 220-255) claims « Couche 2 — tous les cas » ("Layer 2 — all cases"), whereas no `⟦·⟧` clause exists for `spawn`, `send`, `guard`, `new`, `free`: **confirmed**. New finding: `Spawn` (`ReglesDeTypage.lean`, l. 1393) replaces the `φ` component of the child by `spawn`; under a compositional translation, `⟦spawn (operation_{⟨a,0⟩}(v))⟧` contains a free name `operation_a` that `ε_spawn` does not mention, which contradicts the second clause of the statement if "mentions" denotes the support of `φ`: **depends on a choice**.
- *Coupling.* The clauses `niv(Δ) ⊑ ℓ̂(ε)` appear only in `Case` (l. 221) and `Op` (l. 227); `Spawn`, `Send` (l. 1401) and `Move` (l. 1496) have none, whereas l. 258-262 says the temporal channel is « fermé par règle » ("closed by rule"). `ℓ̂` is not defined for `⟨1,1⟩`, `⟨c,c⟩`, `⟨w(ε),0⟩`. `Send` does not relate the level of the payload to that of the box: **textually confirmed**, consequences depending on the reading of these pairs.
- *`w`, `s`.* Used in `Vmap` (l. 1289) and `Spawn` without definition: **confirmed**. Two readings: projections `ℰ → ℕ∞^ℒ` (the level is kept) or scalar aggregates of type `W` (the level is lost). Name collision with the aggregator `W` (C-05) and the counit `w_A`.
- *`Tick`.* `⟨1, δ_ℓ̂⟩` (l. 229), `δ` not defined; consistent only if `δ_ℓ` takes values in `ℕ∞ × ℕ∞`. Contradictory residue: `LeSystemeDeSortesDuMetalangage.lean`, l. 103-104, still writes `κ ∈ ℕ∞^ℒ`, against `(ℕ∞ × ℕ∞)^ℒ` (`GrammaireDesTypes.lean`, l. 46 and 109-117).

**Split between C / F / E.** Belong to C: definitions of `w`, `s`, `δ`, `ℓ̂`; the residue `ℕ∞^ℒ`; delimitation of the domain of `thm:confinement_sortes`, of `Sim` and of `thm:progres`; over-claim of `thm:sync_motifs_jonction`; temporal forms; `at_n`, `move`, `try` (layer 1). Belong to F: translation of `spawn`, global rules and pool configuration, coupling clauses as typing conditions, join of `Guard`, global progress. Belong to E: reductions and depth of `∥` and `vmap`.

**Obligations.**
- **S1.** Explicitly restrict the domain of `thm:confinement_sortes` and of `Sim` to the rules whose translation is written; define "operations that `ε` mentions"; decide whether the translation of `spawn` contains that of the child.
- **S2.** Define `w`, `s`, the codomain of `δ_ℓ` and `ℓ̂` for effects whose pair has no level; remove or justify the residue `κ ∈ ℕ∞^ℒ`; check whether "closed by rule" holds without a coupling clause.

**Author decisions.** D-S1 (`w`, `s`), D-S2 (coupling or reduction of the claim), D-S3 (delimit now in C or wait for F).

## 6. Singularities of wheels (D, BLOQ-12)

Workstream D remains blocked by the C gate; this section chooses none of the alternatives (i) to (iv) of [`sources-singularites.md`](../research/sources-singularites.md).

**`1/0` in a wheel.** `spec/Spec/C3/LesContraintesDeValeur.lean`, l. 402-404, writes « En roues `x/0 = ⊥`, donc `1/0 = ⊥` » ("In wheels `x/0 = ⊥`, hence `1/0 = ⊥`"). In the wheel of fractions of a field, `1/0 = [1,0] = ∞`, `0/0 = [0,0] = ⊥`, and `x/0 = ∞` for finite non-zero `x`; more generally, if `1/0 = 0/0` in a wheel, then `0 = /⊥ = ⊥` and the wheel is trivial. The law "`x/0 = ⊥` for every `x`" is that of *common meadows*. The sentence comes from the external review `docs/peer-review/pr-02/qwen.md`, l. 498, taken up without verification. The conclusion of the note (the encoding is not a homomorphism to IEEE 754) remains true with a correct counterexample: `∞ + ∞ = ⊥` in the wheel against `+∞` in IEEE 754, or `1/0 ↦ +∞`, which is not a NaN whereas the encoding puts `∞` in a NaN payload. Status: computed on the recalled construction (finite fields, `ℤ/4`, `ℤ/6`, `ℚ`) and derived on paper; concordant abstracts of Bergstra and Tucker (WADT 2020, LNCS 12669, doi 10.1007/978-3-030-73785-6_2: "1/0 = ∞"); **the body of Carlström's article (MSCS 14(1), 2004, doi 10.1017/S0960129503004110) could not be read** (network access refused). Dangling references in the same requirement: "(iii)" (l. 397 and 407) whereas the proposition now has only (i) and (ii), and « la table de propagation des singularités » ("the propagation table of the singularities"), absent from `main` (IMPL-07 open). Correction of the manuscript submitted to the author in [`DECISIONS.md`](../tracking/DECISIONS.md).

**Rule of union of labels.** `spec/` contains no definition of `∘` or `δ` as singularities, no combination rule, nor propagation table: only `LesContraintesDeValeur.lean`, l. 352 and 366-368, name the four singularities. The union rule was written only by `927a6fd` (branches `split/pr10-3-singularites` and `split/pr10-4-manuscrit-semantique`, not merged). The contrary claims of the research note and of the header of `scripts/verif_singularites.py` are corrected in the same PR as this file; the script reads no file of `spec/`, its computations do not depend on this claim.

**Reproduced computational complements** (finite model, recalled axioms): under the least-upper-bound rule, the product is not associative either (`(0·∞)·∘ = ⊥`, `0·(∞·∘) = ∘`), and three other axioms fail; with the fixed priority (iii), only `0/0 + x = 0/0` fails (GF(2), GF(3), GF(5)); with option (iv), `/(xy) = /x /y` and `/(x + 0y) = /x + 0y` fail. No rule tried keeps all the axioms with an additional error class; this is not proved for every extension.

**Obligations D / IMPL-07.**
- **W1.** The differential test excludes or explicitly handles the cases where the wheel and IEEE 754 diverge (`∞ + ∞`, encoding of `∞` as a NaN, NaN payload).
- **W2.** Hardware arithmetic does not fix the payload of the result of two NaNs (a recommendation, not a requirement of IEEE 754): `+` on the encoded values requires a software correction, whatever the option.
- **W3.** The symbols `∘` and `δ` of the singularities collide with composition, `δ_ℓ` and `δ_{r,s}`; to be handled with T-68 if the classes are kept.
- **W4.** Read Carlström 2004 as soon as access allows: all the values said to be "computed" depend on the recall of the axioms.

## 7. Related findings, absent from the archive

1. **Rule `When` modified without trace.** Commit `6371e19` (12 October 2026) changed the conclusion of `When` from `ε[ω/k]` to `ε` (`ReglesDeTypage.lean`, l. 500). [`L1-THEORY-OBJECTS.md`](L1-THEORY-OBJECTS.md), § 4, and the [C-04](L1-C04-WHEN-RESOURCE-CONTRACT-2026-10-11.md) audit, § 1.1, still describe the old rule. A normative change to be traced.
2. **`thm:action_parallele` on `ℰ₀`.** The sketch (`ComonadeExponentielleEtFragments.lean`, l. 326-330) deals only with the temporal factor; on `ℰ₀`, the exchange law (`ReglesDeTypage.lean`, l. 1275) gives only `φ_n(ε₁) ∥ φ_n(ε₂) ⊑ φ_n(ε₁ ∥ ε₂)`.
3. **Congruence of `scoped` in `thm:preservation`.** The inner step (`SemantiqueOperationnelle.lean`, l. 92-93) emits the effect of the sub-computation without transforming it: preservation requires `δ · f(ε′) ⊑ f(δ · ε′)`, not only the monotonicity of `f` (l. 184-186). The inequality fails for `π_{a}` and `φ_0` as soon as an intercepted operation satisfies `a ⋢ 1`, and for `φ_2` in the free model; conditioned on the order of traces, not defined (l. 189-196).
4. **Blind mechanical check.** `scripts/controles/croise.py`, l. 47-52, classifies `Alw`, `Alw⁻`, `Now`, `Wait` as "computation" without checking the format of the conclusion. Discriminating checks proposed, not implemented: (a) every rule whose constructor is classified "computation" concludes with `| ε` (would have failed on `Alw`, `Alw⁻`, `Now`, `Wait`, `Unfold`); (b) every constructor introduced by a computation introduction rule appears in the terminal list of `thm:progres`, or is explicitly excluded from it.

## 8. Remaining actions

- **HUMAN ACTION REQUIRED:** decisions D-φ1 to D-φ3, D-ℓ, D-T1, D-T2, D-P1, D-P2, D-S1 to D-S3 and the `1/0` correction, recorded in [`DECISIONS.md`](../tracking/DECISIONS.md).
- **BLOCKED:** reading of Carlström 2004 and of Gaboardi et al. 2016 (network access refused from the review environment).
- **FUTURE:** Lean mechanisation of the counterexamples (`delay (return ())`, `Λα.return ()`, `φ₂(ab)`), once the syntax and typing of C3 are formalised; checks (a) and (b) of § 7.
