-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import Spec.C3.EffectiveKernel
import Mathlib.Tactic

/-!
# Usage intervals

The four usage strata are represented as subsets of the Usage carrier already
defined by the C3 effective kernel. Rel remains an interval of usage values;
this file does not introduce Rel as a normative structural mode.
-/

namespace K7PL.Proofs.Grades

abbrev Usage := K7pl.Spec.C3.EffectiveKernel.Usage

def uLin : Set Usage := {u | u = 1}
def uAff : Set Usage := {u | u ≤ 1}
def uRel : Set Usage := {u | 1 ≤ u}
def uUnr : Set Usage := Set.univ

theorem uLin_subset_uAff : uLin ⊆ uAff := by
  intro u hu
  change u = 1 at hu
  change u ≤ 1
  rw [hu]
  exact le_rfl

theorem uAff_subset_uUnr : uAff ⊆ uUnr := Set.subset_univ _

theorem uLin_subset_uRel : uLin ⊆ uRel := by
  intro u hu
  change u = 1 at hu
  change 1 ≤ u
  rw [hu]
  exact le_rfl

theorem uRel_subset_uUnr : uRel ⊆ uUnr := Set.subset_univ _

/-- The affine and relevant usage intervals are incomparable. -/
theorem uAff_uRel_incomparable :
    ¬ uAff ⊆ uRel ∧ ¬ uRel ⊆ uAff := by
  constructor
  · intro h
    have hzero : (0 : Usage) ∈ uAff := by norm_num [uAff]
    have hzeroRel : (0 : Usage) ∈ uRel := h hzero
    norm_num [uRel] at hzeroRel
  · intro h
    have htwo : (2 : Usage) ∈ uRel := by norm_num [uRel]
    have htwoAff : (2 : Usage) ∈ uAff := h htwo
    norm_num [uAff] at htwoAff

#print axioms K7PL.Proofs.Grades.uLin_subset_uAff
#print axioms K7PL.Proofs.Grades.uAff_subset_uUnr
#print axioms K7PL.Proofs.Grades.uLin_subset_uRel
#print axioms K7PL.Proofs.Grades.uRel_subset_uUnr
#print axioms K7PL.Proofs.Grades.uAff_uRel_incomparable

end K7PL.Proofs.Grades
