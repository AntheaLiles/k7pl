<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 05: translation commutation and fixed-point interpretation

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:commutation_traduction` and `thm:image_fix` in `spec/Spec/C4/SemantiqueOperationnelle.lean`, plus the direct dependency `thm:terminaison_lfp` in `spec/Spec/C2/AdjonctionsEtEnrichissement.lean`.  
**Method:** compare each complete statement with its proof sketch and immediate definitions/dependencies. This is not a Lean formal proof or an independent validation of the mathematics.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:commutation_traduction` | Standard substitution-commutation strategy, but its unrestricted statement omits typing and freshness conditions needed by the process encoding | State the translation domain, capture-avoiding substitution, freshness/alpha-equivalence conditions, and the rule-by-rule obligations |
| `thm:image_fix` | The fixed-iteration construction is plausible under the finite-height theorem, but typing and semantic equality depend on unfinished translation/reinvocation interfaces | Connect the translated operator to the source function and prove the finite iteration is exactly the translated denotation |
| `thm:terminaison_lfp` (dependency) | The monotone finite-height argument is recognizable; the formal status of the domain structure and height bound must remain explicit | Specify the order/height convention and the decidable finite carrier assumptions required by the iteration bound |

These findings do not establish falsity. They distinguish a plausible mathematical strategy from the formal premises and compatibility lemmas required to use it as a dependency.

## Detailed findings

### 1. `thm:commutation_traduction` — substitution and process translation

The statement claims that translating a substituted term is equivalent, modulo structural congruence in the target calculus, to restricting a fresh channel and composing the translation of the original term with an output carrying the translation of the substituted value. The sketch appeals to the general commutation schema, induction on the term, the source substitution theorem, and scope extrusion in the target calculus.

The proof route is recognizable, but the statement quantifies over arbitrary `c`, `v`, and `x` without stating the typing derivations or the conditions under which the translation is defined. The displayed process equation also needs a freshness convention: the restricted name `x` must correspond to the source variable without capturing names already used by the translations of `c` or `v`. The use of structural congruence and scope extrusion depends on the target calculus's precise binding and alpha-equivalence rules.

The sketch's “if `x` is not free” case also relies on the target's scope law, while the composition cases rely on the source substitution theorem to preserve the relevant grade/context. These are substantive side conditions of the induction, not consequences of the equation's notation alone. In addition, the general schema audit has already identified that `thm:schema_commutation` needs explicit compatibility laws for the transformation's action on constructors and binders; citing that schema does not discharge those instance obligations automatically.

**Required review:** state whether the theorem ranges over raw terms or well-typed derivations; define the translation's domain and the source substitution convention; state the freshness conditions and alpha-equivalence used for target names; then check each source constructor, especially binders, graded modalities, and effectful constructs. Keep the general commutation schema as a dependency with its own outstanding interface obligations.

### 2. `thm:image_fix` — translating the finite-height fixed point

The statement claims that `fix f` can be translated as exactly `h` sequential reinvocations of the translation of `f`, starting from the translation of bottom, and that the result is well-typed, well-sorted, and denotes the translation of the least fixed point.

The source typing rule for `fix` requires a monotone endomorphism on a type in `Trellis_fin`, so the intended finite-height iteration has an appropriate source-side premise. The dependency `thm:terminaison_lfp` states that iteration from bottom stabilizes within the height bound. However, the conclusion is not only a termination claim: it identifies a particular target process with the translated denotation. The sketch argues that (h) copies of the translated function have the right target type, that they introduce only continuation channels, and that their value equals the least fixed point. Those steps need a formal connection between source application/iteration and target sequential reinvocation, not just a type calculation.

The construction also depends on the compatibility obligation recorded for `thm:schema_reinvocation`: context scaling and effect transformation must agree for finite reinvocation. The earlier audit found that this compatibility is not established for the full grade structure. In this block, the empty effect annotation and the claim that only continuation channels are introduced must be checked against the actual translation clauses, rather than inferred solely from the source term's effect annotation.

Finally, the theorem uses the notation `[[fix f]]` as though the translation of the fixed-point construct is already defined, while the surrounding text describes this block as supplying that very translation case. The definition and theorem should be distinguished clearly: the construction defines the translation clause; the theorem proves its typing, sort discipline, and semantic adequacy.

**Required review:** define the target translation clause independently of its correctness theorem; show that the translated operator implements the source function on every element of the finite carrier; justify the exact (h)-step bound under the stated height convention; prove target typing and sorting by induction on reinvocation; and discharge the finite-grade compatibility condition. Keep semantic equality separate from termination and typing.

### 3. `thm:terminaison_lfp` — finite-height monotone iteration

The statement considers a type `S` in `Trellis_fin`, of height `h`, and a monotone endomorphism `f`. It claims that iteration from bottom is increasing, stationary within `h` steps, and reaches the least fixed point. The sketch gives the usual monotonicity induction and invokes finite height for stabilization, then Knaster–Tarski for leastness.

This is the clearest of the three proof outlines, but its correctness depends on the exact finite-order structure meant by `Trellis_fin`. The surrounding prose describes finite carriers, decidable equality, products/sums, bottom as the empty set, join as union, and height as the cardinality of the largest support. The proof uses both a bound on the number of strict increases and the fact that the stabilized value is a least fixed point. The formal definitions must ensure that the order is a complete lattice (or otherwise supply the needed least-fixed-point argument), that the iteration remains in the carrier, and that the stated height convention indeed bounds strict increases by (h).

The source says the monotonicity mark in the grade is a syntactic typing condition, not an independently proved semantic property. That contract should be preserved: the theorem assumes a monotone endomorphism; it does not prove arbitrary functions monotone. The explicit exclusion of non-monotone rules such as unstratified negation is part of the theorem's scope and must survive any migration.

**Required review:** cite the exact definition of `Trellis_fin` and its order; state the finite-carrier, bottom, join, and height properties used by the proof; check the off-by-one convention in “at most (h) steps”; and identify the completeness/finite-lattice result used for leastness. Preserve the monotonicity premise and the exclusion of non-monotone constructions.

## Cross-cutting consequences for C8

1. A substitution equation for a process encoding needs explicit binding, freshness, typing, and structural-congruence conventions.
2. The fixed-point translation requires three distinct arguments: source iteration terminates, the target process is well-typed/well-sorted, and its denotation equals the translated least fixed point.
3. The finite-height result does not discharge the separate compatibility obligation for finite reinvocation.
4. No source claim has been reclassified in this note. All proposed formal obligations require author review.
5. This batch covers two target blocks and one direct dependency; it does not close the audit of the remaining statement blocks.
