-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.RingTheory.Ideal.Basic

/-!
# Abstract structural modes

This module captures the structural-mode contract from C3 independently of
usage intervals and independently of the grade coordinate `𝕄` (the
monotonicity marker). A mode pairs a contraction ideal with a weakening
permission. The definitions are parametric in a semiring and do not, by
themselves, show that the K7PL typing rules enforce these permissions.
-/

namespace K7pl.StructuralModes

universe u

/-- A structural mode consists of contractible grades and a weakening permission. -/
structure Mode (R : Type u) [Semiring R] where
  /-- Ideal of grades that may be contracted in this mode. -/
  contractible : Ideal R
  /-- Per-grade predicate deciding whether weakening is allowed. -/
  weakening : R → Prop

/-- Strict linear mode: only the zero ideal is contractible; weakening is denied. -/
def linear (R : Type u) [Semiring R] : Mode R :=
  ⟨⊥, fun _ => False⟩

/-- Affine mode: only the zero ideal is contractible; weakening is allowed. -/
def affine (R : Type u) [Semiring R] : Mode R :=
  ⟨⊥, fun _ => True⟩

/-- Unrestricted mode: every grade is contractible and weakening is allowed. -/
def unrestricted (R : Type u) [Semiring R] : Mode R :=
  ⟨⊤, fun _ => True⟩

/-- A structural-mode morphism may add contraction and weakening permissions. -/
structure Morphism {R : Type u} [Semiring R] (m n : Mode R) : Prop where
  contractible_mono : m.contractible ≤ n.contractible
  weakening_mono : ∀ r, m.weakening r → n.weakening r

/-- Morphisms compose because both permissions are monotone. -/
theorem Morphism.trans {R : Type u} [Semiring R] {a b c : Mode R}
    (f : Morphism a b) (g : Morphism b c) : Morphism a c := by
  exact ⟨le_trans f.contractible_mono g.contractible_mono,
    fun r h => g.weakening_mono r (f.weakening_mono r h)⟩

/-- The reference structural-mode chain Lin → Aff. -/
theorem linear_to_affine (R : Type u) [Semiring R] :
    Morphism (linear R) (affine R) := by
  refine ⟨le_rfl, ?_⟩
  intro r h
  exact h.elim

/-- The reference structural-mode chain Aff → Unr. -/
theorem affine_to_unrestricted (R : Type u) [Semiring R] :
    Morphism (affine R) (unrestricted R) := by
  exact ⟨bot_le, fun _ _ => True.intro⟩

/-- The composite reference structural-mode morphism Lin → Unr. -/
theorem linear_to_unrestricted (R : Type u) [Semiring R] :
    Morphism (linear R) (unrestricted R) :=
  Morphism.trans (linear_to_affine R) (affine_to_unrestricted R)

/-- Rel is retained only as an algebraic candidate, not a reference language mode. -/
def relationalCandidate (R : Type u) [Semiring R] : Mode R :=
  ⟨⊤, fun _ => False⟩

/-- The relational candidate may map to Unr in the abstract permission order. -/
theorem relational_to_unrestricted (R : Type u) [Semiring R] :
    Morphism (relationalCandidate R) (unrestricted R) := by
  exact ⟨le_rfl, fun _ h => h.elim⟩

/-- Aff → Rel is not a morphism: weakening would have to map True to False. -/
theorem affine_not_to_relational (R : Type u) [Semiring R] :
    ¬ Morphism (affine R) (relationalCandidate R) := by
  intro h
  exact h.weakening_mono 0 True.intro

end K7pl.StructuralModes
