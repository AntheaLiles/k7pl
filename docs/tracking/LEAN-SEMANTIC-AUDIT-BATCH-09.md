<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Semantic audit batch 09: truncated subtraction and graded-action coherence

**Status:** provisional source-level review; author ratification required.  
**Scope:** complete blocks `thm:distributivite_tronquee`, `thm:coherence_axiome`, and `thm:coherence_usage` in `spec/Spec/C2/ComonadeExponentielleEtFragments.lean`, including the definitions and algebraic domains explicitly referenced by their statements.  
**Method:** inspect the statements and proof sketches for domain correctness, completeness of cases, and agreement between the displayed laws and the surrounding architectural constraints. This is not a Lean formal proof and does not validate all algebraic definitions elsewhere in the specification.  
**Source integrity:** no mathematical source, label, hypothesis, proof sketch, or status was changed.

## Summary

| Label | Provisional finding | Main issue to resolve |
|---|---|---|
| `thm:distributivite_tronquee` | The counterargument for excluding the infinite multiplier is strong, but the positive proof sketch does not explicitly cover all combinations of finite/infinite `β` and `k` | State the exact definition of truncated subtraction on `ℕ∞` and give an exhaustive case split, including `k = ω` and `β = ω` |
| `thm:coherence_axiome` | The statement is a compatibility obligation, not a result established by its current sketch; its quantified domain is intentionally conditional but its operations are not yet fully defined | Define `ψ`, context scaling, `φᵣ`, and their common domain; prove the equation only for that domain |
| `thm:coherence_usage` | The componentwise argument is plausible under the described factorization, but the required component signatures and totality conditions are implicit | Give the four-component definitions of `ψ` and `Scale_Usage`, and establish the componentwise equality on their actual domains |

These findings do not establish that the claims are false. They distinguish a plausible algebraic argument from a proof whose definitions and domain conditions are explicit enough to be checked.

## Detailed findings

### 1. `thm:distributivite_tronquee` — product over truncated subtraction

The statement claims
`u · (β ⊖ k) = (u · β) ⊖ (u · k)`
for `u, β, k ∈ ℕ∞` when `u ≠ ω` or `k = 0`, and asserts that the restriction is necessary regardless of the chosen value of `ω ⊖ ω`.

The sketch gives a useful separation argument for the excluded case. With `u = ω`, finite `k > 0`, and `β = k`, equality requires `ω ⊖ ω = 0`; with `β = 5`, `k = 3`, it requires `ω ⊖ ω = ω`. These requirements conflict, provided the stated arithmetic for multiplication by `ω` and finite positive values is in force. This supports the necessity argument.

The positive direction is less complete as written. The listed cases do not visibly exhaust every combination: in particular, the proof should account for `k = ω`, finite `u > 0`, and the combinations involving `β = ω` and `k = ω`. The outcome depends on the exact definition of truncated subtraction over the extended carrier. A proof may well be short, but the present phrase “three cases” does not expose the complete partition.

**Required review:** state or reference the defining equations for `⊖` on all boundary values of `ℕ∞`; enumerate the cases for `u = 0`, finite positive `u`, `u = ω`, `k = 0`, and the finite/infinite combinations of `β` and `k`. Keep the counterexample argument separate from the positive law. The surrounding prose correctly says this lemma is not a general premise of `Scale_Usage`; preserve that limitation.

### 2. `thm:coherence_axiome` — compatibility of graded actions

The statement quantifies over contexts `Δ`, effects `ε`, and grades `r` in the common domain where context scaling and effect transport are both defined, and states
`r · ψ(Δ, ε) = ψ(r · Δ, φᵣ(ε))`.

The source explicitly presents this as a compatibility condition whose proof depends on the domain of the two actions. The sketch only develops a candidate budget calculation for an integer multiplicity and warns that the equation cannot be extended to rational usage grades without separately defining the budget action and `φᵣ). This is not yet a proof of the displayed general equation: it is a design constraint plus one proposed component-level route.

The conditional domain avoids asserting the equation where the operations are undefined, but it does not by itself make the law informative or verifiable. The maps and their domains must be defined independently of the desired equality. Otherwise, “where both actions are defined” risks hiding the principal compatibility obligation in the domain selection.

**Required review:** define the context/effect product, `ψ`, context scaling, `φᵣ`, and the admissible grade domain before invoking the law. State whether this block is intended to be a requirement/obligation or a mathematical result conditional on those definitions. Prove the budget component for its exact domain and do not generalize the integer calculation to rational grades without a defined action and proof.

### 3. `thm:coherence_usage` — usage-action coherence

The statement says that, under the factorization of the index and for each usage grade `u ∈ ℛ`, usage scaling commutes with effect transport:
`Scale_Usage(u, ψ(Δ, ε)) = ψ(Scale_Usage(u, Δ), ε)`.

The sketch's core argument is componentwise: `ψ` changes only budget, while `Scale_Usage` changes only usage and leaves budget unchanged; all four components are therefore said to agree. This is a plausible direct proof if the four-component representations and the two functions have exactly the stated signatures and behavior.

However, those definitions are not restated in the block, and the surrounding prose says that later uses may invoke the law once the index support and `Scale_Usage` are fixed. The proof should therefore be understood as conditional on that architectural interface, not as independent evidence that the interface is already defined and coherent. It also depends on the componentwise equality being well-typed for every `u ∈ ℛ`, including the allowed rational and infinite values.

**Required review:** reference precise definitions for the context and effect tuples, `ψ`, and `Scale_Usage`; verify that both sides are defined on the same domain; and write the four component equalities explicitly. If these functions are still architectural candidates, keep the law marked as a conditional obligation until the definitions are fixed.

## Cross-cutting consequences for C8

1. Algebraic identities over extended carriers need explicit boundary-case coverage; a routine finite calculation does not settle cases involving `ω`.
2. A compatibility equation is not established merely by restricting its quantification to a domain that has not yet been defined.
3. The source distinguishes general graded-action compatibility from the factorized usage action. The audit preserves that distinction and does not treat the former as a premise of the latter.
4. No source claim has been reclassified. This batch does not close the audit of the remaining statement blocks.
