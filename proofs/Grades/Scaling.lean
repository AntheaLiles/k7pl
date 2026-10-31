-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import Spec.C3.EffectiveKernel

/-!
# Usage scaling

These results lift the scaling equations of the specification's executable
C3 kernel to explicit projection and preservation statements. They do not
supply laws for effect composition, ψ, or the full context operator ⊠.
-/

namespace K7PL.Proofs.Grades

open K7pl.Spec.C3.EffectiveKernel

universe uMono uLevel

theorem piU_scaleUsage
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) :
    piU (scaleUsage a r) = a * piU r := rfl

theorem scaleUsage_preserves_nonUsage_coordinates
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : Usage) (r : Grade Monotonicity Level) :
    (scaleUsage a r).monotonicity = r.monotonicity ∧
    (scaleUsage a r).level = r.level ∧
    (scaleUsage a r).budget = r.budget := by
  exact ⟨rfl, rfl, rfl⟩

theorem piU_scaleUsage_comp
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (a b : Usage) (r : Grade Monotonicity Level) :
    piU (scaleUsage a (scaleUsage b r)) = (a * b) * piU r := by
  calc
    piU (scaleUsage a (scaleUsage b r)) =
        piU (scaleUsage (a * b) r) :=
      congrArg piU (scaleUsage_comp a b r)
    _ = (a * b) * piU r := rfl

#print axioms K7PL.Proofs.Grades.piU_scaleUsage
#print axioms K7PL.Proofs.Grades.scaleUsage_preserves_nonUsage_coordinates
#print axioms K7PL.Proofs.Grades.piU_scaleUsage_comp

end K7PL.Proofs.Grades
