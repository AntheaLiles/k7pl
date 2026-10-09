<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 02: refinement and fixed-point claims

**Status:** provisional source-level review; author ratification required.  
**Scope:** `thm:raffinement`, `thm:non_interference`, `thm:determinisme_observationnel`, and `thm:sedimentation`, with direct inspection of the dependency `thm:traduction_metalangage`.  
**Method:** read each complete statement and its proof sketch, plus the immediate explanatory passages that qualify its scope. This is not a Lean formal proof or independent validation of the cited literature.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:raffinement` | Conditional construction whose listed consequences require separate definitions/lemmas | The functor-and-typing premise alone does not visibly establish all three consequences |
| `thm:non_interference` | Proposed route, with important semantic obligations still open | Formalize the observation relation, the graded relation interpretation, and compatibility with effects/products |
| `thm:determinisme_observationnel` | Correctly marked conjectural in the source | The `Guard` case and trace projection are unresolved; preserve conjectural status |
| `thm:sedimentation` | Explicitly compound: literature result for ungraded containers plus open graded extension | Separate the established external result from the graded requirement; the sketch does not discharge the latter |
| `thm:traduction_metalangage` (dependency) | Proposition with a stated induction plan, not a completed proof | The case analysis is explicitly not conducted and contains translation/interface obligations |

These findings do not establish that a claim is false. They identify which parts of the source currently function as conditional statements, research programmes, or unfulfilled proof obligations.

## Detailed findings

### 1. `thm:raffinement` — one structure, three readings

The theorem assumes that the translation `⟦·⟧` is a typing-preserving functor, then concludes that the triple forms a refinement system and derives three readings: phase erasure, non-interference, and the precision order on each fibre.

The first step may be a definition-level consequence once the source and target categories, the functor, and the relevant typing preservation are fully specified. The subsequent claims do not all follow from functoriality alone as presently stated. In particular, identifying non-interference with indistinguishability under a common image requires an observation/equivalence relation and a statement of which observations the target semantics admits. Identifying the precision relation with the fibre order requires the relation's restriction and order properties to be stated and shown to coincide. The sketch appeals to earlier definitions but does not conduct these checks.

The source itself records that `thm:traduction_metalangage` has only an outlined induction and that the enrichment over all morphisms remains a separate commitment. These caveats must stay attached to the theorem.

**Required review:** split the definition-level refinement-system construction from its three interpretive consequences, or enumerate the additional premises/lemmas each consequence needs. Define “same image,” observational indistinguishability, vertical morphism, and the relevant order precisely. Do not mark the whole compound block established merely because its conditional premise is plausible.

### 2. `thm:non_interference` — graded non-interference for the sequential fragment

The statement quantifies over security levels and derivations with the same image under a level-indexed translation. Its proof sketch proposes an abstraction/parametricity argument: interpret the graded modality existentially, apply relational parametricity, and choose a relation that is identity below the observer's level and total above it.

The surrounding prose explicitly limits the claim to the sequential fragment and warns that concurrency can leak through scheduling/timing. The later discussion also identifies unresolved obligations: compatibility of the chosen relation with products of grades, extension to communications on distinguished channels, and treatment of bounded declassification. These are not cosmetic details; they determine whether the relation is preserved by the language's constructors and whether the claimed observation boundary is the one actually modeled.

The statement also relies on a family of level-indexed translations `⟦·⟧ℓ`. The exact definition and relationship to the earlier phase-erasure translation must be stable before this theorem can be evaluated.

**Required review:** state the observation equivalence and trace/value observations; define the level-indexed translation; formulate the relational interpretation of each relevant type constructor and effect; prove the product and communication cases; state explicitly whether declassification is excluded or handled by a separate theorem. Keep the scope “sequential fragment” attached to the claim and do not generalize it to concurrent execution.

### 3. `thm:determinisme_observationnel` — scheduling and trace projection

The source explicitly labels this statement as a conjecture and its proof sketch as “Non conduite.” It proposes bisimulation over projected traces and identifies `Guard` as the difficult case because branch selection can depend on a message above the observer's level.

This is consistent with the surrounding warning that ordinary sequential non-interference does not automatically survive concurrency. The hypothesis `𝒟_S` constrains the scheduler, but the exact scheduler interface, the trace alphabet/projection, and the reduction relation need to be precise enough to support a step-by-step bisimulation argument.

**Required review:** retain conjectural status. Define the scheduler's permitted observations, trace projection, and equivalence between executions; then address `Guard` explicitly. Do not treat the four easier rule cases as evidence that the fifth case follows.

### 4. `thm:sedimentation` — nested fixed points

The statement explicitly combines two different epistemic components: (i) a result for ungraded containers attributed to the literature, and (ii) the graded-container case, described as an open requirement. The proof sketch outlines preservation of fixed points and a reduction to a simultaneous fixed-point problem, but it does not complete the graded proof. A footnote further records a tool limitation: the cited technique uses path types from cubical type theory that the intended proof assistant does not provide.

This is a particularly clear case where the outer block must not receive one status that is incorrectly inherited by both parts. The literature attribution may support the ungraded component within its actual hypotheses; it does not transfer to the graded generalization.

**Required review:** separate the ungraded theorem/reference from the graded requirement. For the external result, record the exact hypotheses and the result actually cited. For the graded case, specify the missing preservation/convergence statement, the proposed proof route, and the tool limitation. Until this is done, do not classify the full block as an established K7PL theorem.

### 5. Dependency: `thm:traduction_metalangage`

The source labels this result as a proposition and gives an induction-on-derivations proof plan. Its following prose explicitly says the induction is not carried out case by case and identifies two obligations: interpretation of pragmatic dependent types in the target and interpretation of the fixed-point construction in the target semi-lattice.

The translation also makes a nontrivial grade-dependent choice: infinite grade maps to a replicated service, finite grade to sequential reinvocation of a linear channel, and other grades to a simple linear channel. The correctness of this mapping depends on the source typing rules and target process rules matching in each case. The sketch does not list the cases or establish their premises and side conditions.

**Required review:** keep this as a proof dependency rather than a verified foundation. Record the exact source/target judgment forms and perform the induction by source rule, especially for finite reinvocation, replicated services, effects omitted by the translation, dependent types, and fixed points. Any limitation in the target fragment must remain explicit.

## Consequences for C8

1. The four audited blocks are not ready for mechanical migration to a single “established” status.
2. `thm:raffinement` and `thm:sedimentation` should be treated as compound candidates for decomposition, subject to author confirmation.
3. `thm:determinisme_observationnel` must retain conjectural status unless a proof is actually supplied and reviewed.
4. The proof dependency `thm:traduction_metalangage` must not be treated as validated solely because it is cited by `thm:raffinement`.
5. No source claim has been reclassified in this note. All proposed decompositions and status decisions require author review.
6. This batch covers four target blocks and one direct dependency; it does not close the audit of the remaining statement blocks.
