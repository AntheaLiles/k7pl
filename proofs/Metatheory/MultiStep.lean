-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

/-!
# Reflexive-transitive closure and invariant preservation

A generic finite-trace construction for any small-step relation. The result
is intentionally independent of the KLean and TLA+ encodings: a later
simulation proof must provide an explicit relation between their states.
-/

namespace K7PL.Proofs.Metatheory

universe u

inductive MultiStep {State : Type u}
    (Step : State → State → Prop) : State → State → Prop where
  | refl (state : State) : MultiStep Step state state
  | step {first middle last : State} :
      Step first middle →
      MultiStep Step middle last →
      MultiStep Step first last

theorem preservesInvariant
    {State : Type u}
    {Step : State → State → Prop}
    (Invariant : State → Prop)
    (preservesOneStep : ∀ {before after}, Step before after →
      Invariant before → Invariant after)
    {first last : State}
    (trace : MultiStep Step first last) :
    Invariant first → Invariant last := by
  induction trace with
  | refl _ =>
      intro initial
      exact initial
  | step oneStep rest inductionHypothesis =>
      intro initial
      exact inductionHypothesis (preservesOneStep oneStep initial)

#print axioms K7PL.Proofs.Metatheory.preservesInvariant

end K7PL.Proofs.Metatheory
