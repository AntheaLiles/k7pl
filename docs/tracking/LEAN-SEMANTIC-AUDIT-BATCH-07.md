<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 07: simulation and interpreter fidelity

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:simulation` and `thm:fidelite_interprete` in `spec/Spec/C4/CalculDeProcessusSousJacent.lean`, including their direct dependency on `thm:commutation_traduction`, the translation-typing claim, and the stated adequacy assumption for the target interpretation.  
**Method:** compare each complete statement with its proof sketch and explicit caveats. This is not a Lean formal proof and does not independently validate the cited abstract machine or observational equivalence results.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:simulation` | The statement is explicitly marked unproved, and its sketch identifies an essential trace-ordering condition not entailed by typing preservation | Give the translation clauses for effect and time operations, prove channel threading preserves event order, and establish the reduction simulation case by case |
| `thm:fidelite_interprete` | A conditional composition argument is plausible, but its main premise is the unproved simulation theorem and the exact notion of fidelity is broader than the displayed reduction implication alone | Define the source/target observations and adequacy relation; prove that typing preservation, simulation, and target adequacy jointly entail exactly the stated fidelity claim |

These findings do not establish falsity. In this case, the source itself explicitly identifies the central simulation argument as outstanding; the audit records its proof obligations and the limits of the conditional conclusion.

## Detailed findings

### 1. `thm:simulation` — simulation of source reduction by translation

The statement requires every source reduction
`⟨c | μ | τ⟩ → ⟨c' | μ' | τ'⟩`
to be matched by at least one target reduction
`⟦c⟧ →⁺ ⟦c'⟧` modulo structural congruence, with the trace extended by the events of the source step.

The sketch organizes pure reductions into beta-like communication cases, product/sum and other eliminations, and vector traversal. Several pure cases rely on `thm:commutation_traduction` to identify the target reduct with the translation of the substituted source term. The previous audit of that dependency identified missing typing/freshness conditions and an induction interface that needs to be made explicit; those obligations therefore remain relevant here.

The sketch correctly isolates the trace as a separate issue. Because target parallel composition is commutative, the target's communication structure alone does not preserve the source's order between events. The sketch gives a concrete two-`tick` counterexample when the time channel is not threaded, and says the theorem only holds if each event consumes the received time channel and returns the next one. That is an essential invariant of the translation, not a consequence of type preservation. The translation clauses for effects and `tick` are acknowledged as being described only in prose, and the source explicitly calls the proposition “Non démontrée”.

**Required review:** specify the target translation for each effectful operation and for `tick`; state the invariant linking the source trace to the threaded target channel; and prove that every source reduction extends that invariant by exactly the corresponding event(s), including congruence and scoped-operation cases. State the structural-congruence relation used in the simulation and show that the induction is stable under it. Discharge the `thm:commutation_traduction` side conditions rather than treating the cited equation as unconditional. Keep this result open until the case analysis and trace-order argument are actually completed.

### 2. `thm:fidelite_interprete` — fidelity of the reference interpreter

The theorem is conditional on three components: the translation preserves typing; the target interpretation is adequate with respect to its observational equivalence; and a simulation theorem relates source reduction to target reduction while extending the trace. Its stated conclusion covers communication structure, control, and effects, but expressly excludes grades and refinements because the translation erases them.

The proof sketch's high-level composition argument is reasonable as a proof plan: if a source program translates to a well-typed target term, and the target interpretation adequately describes that term, then observations of the composition should follow from the corresponding source/target correspondence. However, that argument needs an explicit statement of the observation functions and of the relation between the source trace and the target observation. A forward simulation of reductions alone generally gives only one direction of behavioral correspondence; it does not by itself establish full abstraction or a two-way equivalence of observations. The theorem does not claim full abstraction, and the audit must not silently strengthen it to that claim.

The proof sketch also says that `thm:simulation` remains to be established and that the fidelity engagement remains open until then. The conditional theorem can be retained as such, but it should not be reported as a completed guarantee merely because its assumptions are stated. The source's change in scope—effects now translated as emissions on distinguished channels—also means that the earlier fidelity claim limited to communication and control cannot be used without the updated effect-channel semantics and the corresponding simulation cases.

**Required review:** define “fidèle à la sémantique” in terms of explicit source and target observation relations. State the direction of adequacy needed and show how the simulation theorem supplies it. Separate the conditional implication from any claim that its premises have been established. Preserve the exclusion of grades and refinements. If a reverse simulation, reflection of observations, or a full-abstraction property is intended, state and prove it separately rather than deriving it from forward simulation.

## Cross-cutting consequences for C8

1. Translation typing and reduction simulation are distinct obligations; the former does not imply the latter.
2. Trace-order preservation requires an explicit threaded-channel invariant, especially because the target's parallel composition is commutative.
3. `thm:fidelite_interprete` remains conditional while its simulation premise remains unproved.
4. The present statement supports no claim of full abstraction or bidirectional behavioral equivalence.
5. No source claim has been reclassified in this note. This batch does not close the audit of the remaining statement blocks.
