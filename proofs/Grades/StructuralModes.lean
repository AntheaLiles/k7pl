-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import Grades.UsageIntervals

/-!
# Structural mode inclusion candidates

The source specification records candidate relationships between Lin, Aff
and Unr, while leaving the exact mode-morphism contract under review. The
relation below is deliberately named a candidate: it checks only inclusion
of contractible grades and monotonicity of weakening permission.
-/

namespace K7PL.Proofs.Grades

structure StructuralMode where
  contractible : Set Usage
  weakening : Bool

def zeroContractible : Set Usage := {u | u = 0}

def linMode : StructuralMode := ⟨zeroContractible, false⟩
def affMode : StructuralMode := ⟨zeroContractible, true⟩
def unrMode : StructuralMode := ⟨Set.univ, true⟩

def ModeInclusionCandidate (source target : StructuralMode) : Prop :=
  source.contractible ⊆ target.contractible ∧
  (source.weakening = true → target.weakening = true)

theorem mode_candidate_trans
    {a b c : StructuralMode}
    (hab : ModeInclusionCandidate a b)
    (hbc : ModeInclusionCandidate b c) :
    ModeInclusionCandidate a c := by
  exact ⟨Set.Subset.trans hab.1 hbc.1, fun h => hbc.2 (hab.2 h)⟩

theorem lin_to_aff_candidate :
    ModeInclusionCandidate linMode affMode := by
  constructor
  · intro u hu
    exact hu
  · intro _
    rfl

theorem aff_to_unr_candidate :
    ModeInclusionCandidate affMode unrMode := by
  constructor
  · exact Set.subset_univ _
  · intro h
    exact h

theorem lin_to_unr_candidate :
    ModeInclusionCandidate linMode unrMode :=
  mode_candidate_trans lin_to_aff_candidate aff_to_unr_candidate

#print axioms K7PL.Proofs.Grades.mode_candidate_trans
#print axioms K7PL.Proofs.Grades.lin_to_aff_candidate
#print axioms K7PL.Proofs.Grades.aff_to_unr_candidate
#print axioms K7PL.Proofs.Grades.lin_to_unr_candidate

end K7PL.Proofs.Grades
