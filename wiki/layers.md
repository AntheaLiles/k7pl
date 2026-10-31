<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# The Three Layers

> **Provenance — Lot 1 (pilot).**
> Consolidated 2026-10-25 from `spec/Spec/C1/GerminalAxiomatics.lean`
> (the formal definition, section "Spécialisation par couche"),
> `spec/Spec/C1/ReadingGuide.lean` (sedimentation as a reading), and
> `spec/Spec/C1/Introduction.lean` (the three maturity levels, including
> "Arrêté").
> Status: living and canonical for the definition of the layers.
> **Clarification from the project owner (2026-10-25):** sedimentation
> is the project's method of reasoning, presented in the Prolegomena
> (chapter 1). It is therefore neither "open" nor "closed" as a
> theorem would be. What remains open is a distinct set of
> mathematical results listed in § "Sedimentation: a method, and
> the theorems it still owes".

## The definition, and only the definition

The three layers of K7PL are three instances of one and the same
germinal judgement, obtained by restricting the admissible form of the
context `Δ`, the grade algebra `𝓖` from which its grades are taken, and
the domain of the effect component `𝓔`. The specification states this
explicitly: this specialisation, and it alone, constitutes the formal
definition of the three layers of the language. Later chapters develop
the content of the layers; they never add a further stratum of
definition.

The three layers are therefore not three different calculi. They are
three restrictions of the same calculus, each obtained by fixing what
the general judgement is allowed to do. A layer is defined by what it
removes from the full judgement, not by what it adds to it.

## The three layers

| Layer | Name | Context `Δ` | Effects `𝓔` | Grades `𝓖` | Structural rules | Categorical mechanism | Principal guarantee |
| --- | --- | --- | --- | --- | --- | --- | --- |
| L3 | Mathematical purity | Reduced to `Δ_ω` (all bindings unconstrained) | Empty; no `tick` is even counted | Stack grade domain `𝓖_pile` | Contraction and weakening | Initial algebras `μF` | Termination, referential transparency |
| L2 | Orchestration | Affine form, non-empty | Active, containing `tick` | (general, as restricted by the affine form) | Weakening only | Terminal coalgebras `νF` | Productivity, controlled effects |
| L1 | Infrastructure | Strict linear form | Containing `tick` | Budget grade domain `𝓖_budget` | None | Capabilities under `⊗` | Unique resources, supervision |

In judgement form (from `GerminalAxiomatics.lean`):

- L3: `Δ_ω ⊢_𝓖 t : A`, with `𝓔 = ∅` and `𝓖 = 𝓖_pile`. A pure
  λ-calculus in the strict sense.
- L2: `Δ_aff ⊢_𝓖 t : A ∣ 𝓔`, with `Δ_aff ≠ ∅` and `𝓔 ∋ tick`.
- L1: `Δ_lin ⊢_𝓖 t : A ∣ 𝓔`, with `𝓖 = 𝓖_budget` and `𝓔 ∋ tick`.

In the text, each layer has its delimiter — `[ ]` for L3, `( )`
for L2, `{ }` for L1 — and they nest in one direction only:
`[ ]` contains atoms and `[ ]`; `( )` contains atoms, `( )` and
`[ ]`; `{ }` contains all three (the author's grammar of
2026-10-26). There is no layer-neutral parenthesis. The grammar is
written in K in `lexicon/syntax/layers.k` and displayed in chapter 5
(`sec:c5-s-expressions-universelles`); the three refused inclusions
are `ERR-TOP-001` (`( )` in `[ ]`), `ERR-TOP-002` (`{ }` in `[ ]`)
and `ERR-TOP-003` (`{ }` in `( )`), emitted by K with the messages
of annex A.

Two engineering consequences follow from the definitions and are
frequently misread. First, in L1 time is read on two components at
once: a finite budget in the grades and a `tick` in the effects.
Second, usage statements hold per layer, under the evaluation strategy
each layer fixes — strict in L1 and L3, call-by-need in L2 — not
globally.

## What the layers are not

This is the disambiguation the old entry path never provided. Do not
collapse the following distinct "threes":

| "Three" | What it is | Why it is not the layers |
| --- | --- | --- |
| **L1 / L2 / L3** | The three instances of the germinal judgement, defined above. | This page. |
| **C2 / C3 / C4** | The foundational chapters of the specification: `spec/Spec/C2` (categorical foundations), `spec/Spec/C3` (types and the graded system), `spec/Spec/C4` (automata and execution). | Chapters organise the specification's content; they are not instances of the judgement. A chapter develops material for all layers where relevant. |
| **Execution scales** | The three execution scales of chapter 4: local scale, actor scale, system (orchestrator) scale. | Scales describe where execution happens and at what grain; layers describe which judgement instance governs a term. The same execution scale can involve more than one layer, and the three scales are not three instances of the judgement. |
| **Repository layers** | Parts of the repository: `spec/`, `src/`, `proofs/`, `tests/`, `tools/`, `scripts/`, `wiki/`. See [understanding](understanding.md). | A physical organisation of artefacts, not a language definition. Calling `src/` a "layer" in the same breath as L1 invites exactly the confusion this page exists to prevent. |
| **Engineering dimensions** | Per-layer tables (paradigm, syntax, effects, termination, mutation, data, namespace, memory, recursion, branching) in `GerminalAxiomatics.lean`. | Consequences and synoptic summaries of the layer definitions, to be justified point by point in later chapters — not definitions themselves. |

Practical rule: whenever a text says "layer" without a number, or says
"the three layers" while meaning chapters, scales, or repository parts,
treat it as ambiguous and rewrite it with the numbered layer or the
correct term.

## Sedimentation: a method, and the theorems it still owes

Sedimentation is the project's method of reasoning, presented in the
Prolegomena (chapter 1, which gathers the Introduction, the Reading
Guide, the Postulates and the Germinal Axiomatics). It is the
principle by which theories are deposited layer by layer, from the
most constrained (L1) to the freest (L3), so that going up means
forgetting a constraint rather than capturing something. As a method,
it is neither "open" nor "closed": asking whether a working principle
is proved or unproved is a category error. It frames how the
specification reasons; it is not itself a theorem awaiting proof.

That distinction dissolves the apparent tension with the
Introduction. When the Introduction lists, under "Arrêté" — defined
there as "will no longer change without a revision of the
axiomatics" — "sedimentation in three fragments and its origin in
the semiring", what is settled is the method and its organisation
in three fragments, not a graded theorem. The reading guide's
warning stands at a different level: triadic sedimentation as an
image is a **reading** — an organising analogy, with no
demonstrative force — and what formally supports it is the
inclusion of fragments, which is another thing.

What *is* subject to proof status, and must not be confused with
the method, is this distinct set of results:

1. **The inclusion functors are a construction still owed.** The
   proof that the layer restriction is conservative rests on faithful
   inclusion functors `F₁→₂ : Linear ↪ Affine` and
   `F₂→₃ : Affine ↪ Cartesian`. Their construction is deferred to
   chapter 2. Until they are constructed, the conservative
   restriction is not established as a theorem.
2. **The sedimentation theorem as stated does not yet cover grades.**
   The theorem of well-definedness of sedimentation
   (`thm:sedimentation`) holds for ungraded containers, and its
   transposition to the graded case remains to be done. Its
   provenance is also recorded as an open obligation in the
   specification itself.
3. **Inclusion holds on one axis and inverts on two others.** On the
   resource axis, L3 is the freest. On the effects axis, L3 is the
   poorest, because it has no effects at all. On the concurrency axis,
   L3 is again the poorest, because its parallelism is deterministic
   while L2 carries interleaving. An image that holds on only one axis
   must say which one. Relatedly, the polarity axis (initial algebras
   `μF` in L3, terminal coalgebras `νF` in L2) runs over only two of
   the three layers: L1 is neither `μ` nor `ν`.

A further, related construction is explicitly open: a glued-category
construction that would give sedimentation a construction rather than
a reading requires a factorisation system through the relevant
subcategory, and that obligation is not fulfilled in the specification.

In short: the method is the Prolegomena's working principle and is
not up for proof; the graded sedimentation theorem, the functor
constructions and the glued construction are the open mathematical
debts that the method organises but does not discharge.

## What a layer does for a programmer

Sedimentation is not only an ordering of guarantees. It is also a
recourse: what cannot enter through any of the three termination doors
does not disappear from the language; it descends to L2 as an effect or
a process. The lower layer is therefore not a degraded fragment; it is
where what cannot be proved higher up goes. Conversely, purity in this
design is absolute, not recovered: the pure layer is pure by
construction, not by subtracting impurity from an impure ambient, and
effects are operations added to a pure calculus with their own
equational theory. **Textual note, now resolved:** the corresponding
sentence in `GerminalAxiomatics.lean` previously read "la couche 2
est pure par construction", which was inconsistent with L3 being the
pure layer. The owner confirmed on 2026-10-25 that L3 is pure and
terminating and L2 carries algebraic effects and is productive, and
the sentence was corrected to "la couche 3 est pure par construction"
in the Lot 1 closing commit. The former frozen Org chapter carried
the old wording as a historical record; it was deleted after its
verified transposition to Verso (see the migration matrix) and
survives only in git history. The historical research-questions
register still carries a related arbitration wording; it is not
normative and was deliberately not rewritten.

## Safety claims this page does not support

Nothing in this page establishes that K7PL, or any of its layers, is
proven safe, that a program in one layer can be moved to another
without loss, or that the graded sedimentation holds. Those claims
would require the functor constructions, the graded transposition of
the sedimentation theorem, and the corresponding proofs. Until then,
cite this page for the definitions and for the open obligations — not
for the theorems.
