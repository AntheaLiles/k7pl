<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 06: sort preservation and effect-channel confinement

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:cloture_sortage` and `thm:confinement_sortes` in `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean`, including the sort definitions and the immediate dependency on `thm:traduction_metalangage`.  
**Method:** compare each statement with its proof sketch and the stated sort rules. This is not a Lean formal proof or independent validation of the target calculus.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:cloture_sortage` | The proof is a direct induction under the deliberately discrete substitution relation | Make explicit that substitutions preserve exactly the assigned sort and that bound-name renaming is covered by the target's binding conventions |
| `thm:confinement_sortes` | The intended sort argument is plausible, but the induction depends on translation clauses and effect-labeling properties that must be explicit | State the per-constructor obligations and make the relationship to the translation-preservation proof non-circular, preferably by a joint induction |

Neither finding establishes falsity. The first appears routine given the definitions as written; the second is a substantive dependency because it is used to justify the translation of distinguished channels.

## Detailed findings

### 1. `thm:cloture_sortage` — closure under well-sorted substitution

The sort system defines the substitution capability `s # s'` as equality of sorts. The theorem's premise therefore says that each substituted name has exactly the sort of the name it replaces. Since the four sort-formation clauses inspect only the sorts of names, an induction on the derivation of `⊢_S P` appears sufficient: each premise remains unchanged after substitution. The join-pattern case follows from preservation of each of its reception premises.

No substantive defect is apparent in this proof outline under the stated discrete relation. Its simplicity is conditional on that design choice: a non-discrete sort-refinement relation would require a different preservation argument, and this theorem would not establish it.

**Required review:** preserve the explicit premise that substitution preserves sorts by equality, not merely by a preorder. Confirm that the formal definition of capture-avoiding substitution and alpha-renaming respects the same sort assignment for bound names. No broader substitution/refinement theorem should be inferred from this result.

### 2. `thm:confinement_sortes` — confinement of distinguished channels

The theorem states that translating any K7PL derivation yields a well-sorted target process in which operation/time names occur only as free names supplied by the effect annotation, never bound or transmitted. The proof sketch divides the induction into layer 3 (no effects), layer 1 (the `tick` case), and layer 2 (where the effectful operation case is substantive). The sort rules are designed so that restriction may bind only program names and output may transmit only program names; these clauses would indeed prevent a translated program from creating or sending a distinguished effect channel.

The proof still relies on several interfaces. For effectful operations, the sketch uses the claim that the emitted value has program sort and that its level is bounded by the level assigned to the effect channel. The latter is attributed to the labeling action `φ` and the effect-typing rules; those premises need to be cited or stated precisely for each effect constructor. The operation-at-scope case relies on sequential reinvocation not creating names, which in turn depends on the translation clause for reinvocation.

There is also a proof-dependency concern. The sketch says the induction is parallel to the induction for `thm:traduction_metalangage`, while the latter's own sketch cites confinement for the distinguished-channel case. This is not necessarily mathematical circularity: the two properties may be proved by simultaneous induction on the same source derivation. But the proof record should say that explicitly and identify the paired induction hypotheses. Otherwise each theorem appears to rely on the other as an already completed result.

**Required review:** state the sort obligations for every source rule and show how each translation clause preserves them. For effects, cite the exact effect-labeling and value-level premises. For reinvocation, state why the target construction introduces no new names. Prove confinement and typing preservation by a joint induction, or give a dependency order that avoids mutual reliance. Keep the conclusion limited to the target grammar and sort discipline actually defined here.

## Cross-cutting consequences for C8

1. `thm:cloture_sortage` is a candidate for a routine structural proof only under the exact equality-based substitution relation.
2. `thm:confinement_sortes` is a prerequisite of translation adequacy and must have explicit per-rule obligations.
3. Mutual reliance between confinement and typing preservation should be recorded as a simultaneous induction if that is the intended proof method; it must not be treated as two independent completed results.
4. No source claim has been reclassified in this note. All formal obligations require author review.
5. This batch covers two blocks; it does not close the audit of the remaining statement blocks.
