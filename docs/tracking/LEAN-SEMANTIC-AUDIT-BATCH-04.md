<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 04: observational replay and product relations

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:stratification_journal` and `thm:relation_produit` in `spec/Spec/C4/SemantiqueOperationnelle.lean`, including their immediate explanatory context and cited dependencies.  
**Method:** compare each statement with its complete proof sketch and the definitions/results it invokes. This is not a Lean formal proof or independent validation of cited literature.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:stratification_journal` | The sketch outlines the intended projection argument but assumes observational and replay properties not formalized in the block | Define replay, observation equivalence, trace projection, and the dependency on determinism/non-interference |
| `thm:relation_produit` | The proposition is explicitly incomplete: the budget component and factor-by-factor compatibility remain open | Separate the product construction from the missing budget case and prove compatibility for each operation |

Neither finding establishes falsity. The concern is that the conclusions rely on semantic interfaces or proof obligations that the sketches themselves do not discharge.

## Detailed findings

### 1. `thm:stratification_journal` — stratified replay

The statement claims that for any well-typed execution, replaying from the projected trace `πᶠ_ℓ(τ)` gives an observer at level `ℓ` the same observation as replaying from the full trace `τ`. The sketch proceeds by induction on reductions, distinguishes pure and effectful steps, and argues that effects above the observer's level—and their duration—are erased. It then invokes determinism at layer 3 to justify uniqueness of replay.

The intended invariant is intelligible, but several notions required by the conclusion are not defined in the theorem block. “Replaying from a trace” needs an operational definition; the observation function or equivalence for an observer at level `ℓ` must be stated; and the projection's action on event labels, values, and time must be related formally to that observation. Without these definitions, the lower-bound claim (“nothing observable is lost”) and upper-bound claim (“nothing above the level remains”) are explanatory intuitions rather than separately checkable properties.

There is also a dependency issue. The sketch says an above-level step is invisible because the observer cannot distinguish its graded value or count its duration. This is an observational non-interference premise; it does not follow merely from deleting the event and its time from the log if that step can influence subsequent control flow or later low-level events. The source separately treats observational determinism as conjectural and limits non-interference to a sequential fragment. The replay theorem must either state assumptions under which those results apply, or prove the required preservation of observations directly. The appeal to layer-3 determinism must also be scoped to the exact replay relation and trace representation used here.

**Required review:** define the execution/replay relation, trace alphabet, projection, and observer's observation function. State and prove that projection preserves the observation of every execution, including the effect of erased steps on later steps. Identify the exact determinism and non-interference premises used and ensure their scopes cover this theorem. Until then, retain the theorem as a candidate with an incomplete proof interface rather than treating the sketch as a completed proof.

### 2. `thm:relation_produit` — logical relation on a product

The statement says that if each factor in a product of ordered structures admits a compatible logical relation, and the graded modality's decisive clause inspects only one component of a grade, then the product admits a compatible logical relation defined componentwise.

The proof sketch proposes pulling factor relations back along projections and checking compatibility with operations such as `φ`, `ψ`, composition, and unit. However, the sketch itself says that the budget factor is the fourth case not covered by the cited truncation-comonad proposition and that it “remains to be written.” It also says that the details for each factor remain to be written. Those are direct admissions that the compatibility argument required by the conclusion is not complete.

The premise that each factor “admits a compatible logical relation” may suffice for a product theorem only after “compatible” is defined against the same signature of operations, the product operations are specified componentwise, and the decisive modal clause is shown to commute with the relevant projections. The budget component is especially important because the sketch says `ψ` changes the budget while leaving values unchanged and places the remaining condition on traces; that behavior cannot be inferred from the other three factors.

**Required review:** define the signature and compatibility predicate for each factor and for the product. State the product relation precisely, including the relation on the budget/trace component, then verify each operation and the modal clause component by component. Resolve the budget case with an explicit lemma or weaken/split the statement to leave it as an open obligation. Do not classify the full proposition as established while the proof sketch records a missing case.

## Cross-cutting consequences for C8

1. A trace projection is not by itself a proof of observational equivalence; the semantics of replay and the observer must be explicit.
2. Erasing high-level events is safe only with a property ruling out their influence on later observations, not solely because the events are absent from the projected trace.
3. The product-relation proposition must retain the explicitly open budget case until it is proved or separated as a requirement.
4. No source claim has been reclassified in this note. All proposed decompositions and formal obligations require author review.
5. This batch covers two blocks; it does not close the audit of the remaining statement blocks.
