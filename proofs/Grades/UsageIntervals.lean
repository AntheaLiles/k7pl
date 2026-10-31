-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import K7pl.UsageScale
import Spec.C3.EffectiveKernel
import Mathlib.Tactic

/-!
# Usage intervals

These intervals formalise the four usage strata stated in C2/C3 over the
canonical carrier already used by the implementation. Rel is retained as an
usage interval only; no Rel structural language mode is introduced.
-/

namespace K7PL.Proofs.Grades

abbrev Usage := K7pl.UsageScale.Usage

def uLin : Set Usage := Set.Icc 1 1
def uAff : Set Usage := Set.Icc 0 1
def uRel : Set Usage := Set.Ici 1
def uUnr : Set Usage := Set.Icc 0 ⊤

/-- The specification kernel and implementation use definitionally equal usage carriers. -/
theorem specUsage_eq_implementationUsage :
    K7pl.Spec.C3.EffectiveKernel.Usage = Usage := rfl

theorem uLin_subset_uAff : uLin ⊆ uAff := by
  intro u hu
  exact ⟨bot_le, hu.2⟩

theorem uAff_subset_uUnr : uAff ⊆ uUnr := by
  intro u hu
  exact ⟨bot_le, le_top⟩

theorem uLin_subset_uRel : uLin ⊆ uRel := by
  intro u hu
  exact hu.1

theorem uRel_subset_uUnr : uRel ⊆ uUnr := by
  intro u hu
  exact ⟨bot_le, le_top⟩

/-- The affine and relevant usage intervals are incomparable. -/
theorem uAff_uRel_incomparable :
    ¬ uAff ⊆ uRel ∧ ¬ uRel ⊆ uAff := by
  constructor
  · intro h
    have hzero : (0 : Usage) ∈ uAff := by norm_num [uAff, Set.mem_Icc]
    have hzeroRel : (0 : Usage) ∈ uRel := h hzero
    norm_num [uRel, Set.mem_Ici] at hzeroRel
  · intro h
    have htwo : (2 : Usage) ∈ uRel := by norm_num [uRel]
    have htwoAff : (2 : Usage) ∈ uAff := h htwo
    norm_num [uAff] at htwoAff

#print axioms K7PL.Proofs.Grades.specUsage_eq_implementationUsage
#print axioms K7PL.Proofs.Grades.uLin_subset_uAff
#print axioms K7PL.Proofs.Grades.uAff_subset_uUnr
#print axioms K7PL.Proofs.Grades.uLin_subset_uRel
#print axioms K7PL.Proofs.Grades.uRel_subset_uUnr
#print axioms K7PL.Proofs.Grades.uAff_uRel_incomparable

end K7PL.Proofs.Grades
