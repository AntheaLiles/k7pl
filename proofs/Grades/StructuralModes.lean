-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import K7pl.StructuralModes

/-!
# Structural modes

The proof domain reuses the implementation's actual Ideal-based mode and
Morphism definitions. Rel remains an algebraic candidate, not a fourth
reference language mode; the Rel usage interval is treated separately in
UsageIntervals.lean.
-/

namespace K7PL.Proofs.Grades

universe u

abbrev StructuralMode := K7pl.StructuralModes.Mode
abbrev ModeMorphism := K7pl.StructuralModes.Morphism

theorem linear_to_affine (R : Type u) [Semiring R] :
    ModeMorphism (K7pl.StructuralModes.linear R)
      (K7pl.StructuralModes.affine R) :=
  K7pl.StructuralModes.linear_to_affine R

theorem affine_to_unrestricted (R : Type u) [Semiring R] :
    ModeMorphism (K7pl.StructuralModes.affine R)
      (K7pl.StructuralModes.unrestricted R) :=
  K7pl.StructuralModes.affine_to_unrestricted R

theorem linear_to_unrestricted (R : Type u) [Semiring R] :
    ModeMorphism (K7pl.StructuralModes.linear R)
      (K7pl.StructuralModes.unrestricted R) :=
  K7pl.StructuralModes.linear_to_unrestricted R

theorem relational_to_unrestricted (R : Type u) [Semiring R] :
    ModeMorphism (K7pl.StructuralModes.relationalCandidate R)
      (K7pl.StructuralModes.unrestricted R) :=
  K7pl.StructuralModes.relational_to_unrestricted R

theorem affine_not_to_relational (R : Type u) [Semiring R] :
    ¬ ModeMorphism (K7pl.StructuralModes.affine R)
      (K7pl.StructuralModes.relationalCandidate R) :=
  K7pl.StructuralModes.affine_not_to_relational R

#print axioms K7PL.Proofs.Grades.linear_to_affine
#print axioms K7PL.Proofs.Grades.affine_to_unrestricted
#print axioms K7PL.Proofs.Grades.linear_to_unrestricted
#print axioms K7PL.Proofs.Grades.relational_to_unrestricted
#print axioms K7PL.Proofs.Grades.affine_not_to_relational

end K7PL.Proofs.Grades
