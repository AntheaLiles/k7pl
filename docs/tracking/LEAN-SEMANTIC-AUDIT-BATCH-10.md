<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 10: monolevel effects, mode morphisms, and context composition

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:temps_mononiveau` in `spec/Spec/C3/GrammaireDesTypes.lean`, `thm:morphismes_modes` in `spec/Spec/C3/LeSystemeGradue.lean`, and `thm:boxtimes_addition` in `spec/Spec/C3/ReglesDeTypage.lean`, including the definitions and side conditions directly invoked by their statements.  
**Method:** compare each statement with its proof sketch and surrounding definitions, focusing on closure, preservation of structure, and whether the stated conditions match the operations actually used. This is not a Lean formal proof and does not independently validate the cited literature.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:temps_mononiveau` | The evaluation-at-`ℓ` map is the natural candidate isomorphism, but closure of the concentrated subset under the full quantale structure must be checked against the actual operations | Define concentration precisely and verify preservation of all quantale operations, not only order, addition, and scalar iteration |
| `thm:morphismes_modes` | The four listed arrows follow from the displayed candidate mode triples if the cited morphism definition uses the stated inclusions and weakening condition | Make the morphism definition and direction of `Cont` inclusion explicit; keep the result conditional on the candidate instantiation |
| `thm:boxtimes_addition` | The componentwise proof is plausible for zero temporal effect, but “temporal component is zero” must match the level-indexed pair-valued effect and the domain of `ψ` | Define the zero-time condition pointwise and prove `ψ` is total for exactly that domain, including the context-compatibility condition |

These findings do not establish falsity. They identify the interface conditions required for the displayed arguments to support the statements as written.

## Detailed findings

### 1. `thm:temps_mononiveau` — recovery of the flat effect form

The statement says that when all `tick` events of a computation are produced at one level `ℓ`, the family `κ` is concentrated at `ℓ` and the restriction of `ℰ` to such effects is isomorphic, as an ordered quantale, to `ℰ₀ × (ℕ∞ × ℕ∞)`.

The sketch identifies the expected map: evaluate `κ` at `ℓ`, with inverse embedding the pair as a family supported at that level. It says the map preserves addition, order, and scalar action, and that the subset is closed under product and supremum. This is the right proof strategy, but the statement claims an isomorphism of ordered quantales, a stronger interface than a bijection preserving only the operations explicitly named in the first sentence of the sketch.

The result depends on the definition of “concentrated”: if this means all other levels carry the neutral pair, that condition must be stable under every operation of the effect quantale. In particular, the proof must check the actual sequential product, parallel operation (work addition and depth maximum), arbitrary joins if the quantale is complete, and any residual/other operation included in the quantale signature. The phrase “produit” should identify which operation it denotes; a quantale's multiplication is not interchangeable with its additive join.

**Required review:** define the subset of concentrated effects as a predicate on `κ`; show the evaluation and embedding are mutual inverses; and verify each operation in the actual ordered-quantale signature. If the structure is only a sub-quantale for a restricted signature, narrow the claim accordingly. Do not infer concentration merely from the narrative statement about all emitted ticks unless the operational semantics connects that premise to the support of `κ`.

### 2. `thm:morphismes_modes` — structural order of modes

The statement instantiates four candidate modes on the common grade carrier `ℛ`: linear, affine, relevant, and unrestricted. It claims identity maps give the arrows Lin→Aff, Lin→Rel, Aff→Unr, and Rel→Unr, while Aff and Rel are incomparable.

The sketch applies the intended mode-morphism conditions: preserve the grade algebra/order, respect the contractible-grade ideals, and do not map a mode with weakening disabled to one that requires weakening in the wrong direction. Under those conditions, the listed arrows appear consistent with the displayed triples. The sketch also explicitly warns that this is conditional on a candidate realization and does not establish that K7PL's typing rules implement those permissions.

The main verification requirement is the exact morphism definition being used. The argument relies on the direction of the inclusion between `Cont` sets and on the direction of the weakening implication. If the cited framework uses the reverse convention, the proof must be adjusted rather than relying on the intuitive ordering of mode names. The candidate `Cont` sets also need to be ideals in the specified grade algebra; merely listing `{0}` and `ℛ` is not a proof unless the algebraic definition of ideal makes those sets valid in this instance.

**Required review:** state the morphism conditions with their directions; verify `{0}` and `ℛ` satisfy the required ideal conditions; check all four arrows against those conditions; and establish both failures needed for Aff/Rel incomparability. Keep the proposition conditional on the candidate mode triples, and do not identify these mode arrows with inclusions between usage intervals or with the language's subtyping relation.

### 3. `thm:boxtimes_addition` — zero-cost composition is pointwise addition

The statement says that for contexts `Δ₁, Δ₂` and an effect `ε` whose temporal component is zero, `Δ₁ ⊠ε Δ₂ = Δ₁ + Δ₂`, with totality of `ψ(·, ε)`.

The proof sketch unfolds `⊠` as `Δ₁ + ψ(Δ₂, ε)`, then uses the fact that `ψ` leaves usage, level, and monotonicity unchanged and applies truncated subtraction to the budget. At zero cost, `β ⊖ 0 = β`, so the componentwise equality follows. The same calculation supports totality if budget subtraction is the only possible source of undefinedness.

The source elsewhere describes the temporal effect as a level-indexed family of pairs, with work and depth coordinates, while this sketch uses a singular temporal quantity `k`. The condition “temporal component is zero” therefore needs to mean that every relevant level's work and depth coordinates are zero, or else identify a defined projection that is being tested. A zero in only one coordinate, or at only one level, would not establish that `ψ` leaves the budget unchanged.

The definition of context addition also requires both contexts to carry the same bindings. The statement quantifies over “all contexts” but does not repeat that compatibility premise, although the surrounding text defines addition only under it. This is a domain condition for `Δ₁ + Δ₂`, distinct from the totality of `ψ`.

**Required review:** define zero temporal effect using the full level-indexed pair-valued structure; state the shared-binding condition on `Δ₁` and `Δ₂`; and show that the domain of `ψ` is unrestricted for that exact zero-effect subset. Preserve the distinction between totality of the transport and definedness of context addition.

## Cross-cutting consequences for C8

1. Claims of ordered-quantale isomorphism require preservation of the actual signature, not only selected operations.
2. Morphism claims over modes depend on formal variance/direction conventions; architectural names are not a substitute for those definitions.
3. “Zero temporal effect” must be interpreted against the normative level-indexed pair structure, not an informal scalar abbreviation.
4. No source claim has been reclassified. This batch does not close the audit of the remaining statement blocks.
