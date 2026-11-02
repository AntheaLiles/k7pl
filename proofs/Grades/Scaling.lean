-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import K7pl.UsageScale
import Spec.C3.EffectiveKernel

/-!
# Correspondence of specification and implementation grades

C3's effective kernel and the executable Lean implementation each expose a
four-coordinate grade. This module proves that the record representations,
usage projection and usage-scaling operation commute. It does not prove that
the K typing rules implement either relation or that the K source refines it.
-/

namespace K7PL.Proofs.Grades

universe uMono uLevel

abbrev SpecGrade (Monotonicity : Type uMono) (Level : Type uLevel) :=
  K7pl.Spec.C3.EffectiveKernel.Grade Monotonicity Level

abbrev ImplementationGrade (Monotonicity : Type uMono) (Level : Type uLevel) :=
  K7pl.UsageScale.Grade K7pl.UsageScale.Usage Monotonicity Level

/-- Encode a C3 specification grade in the implementation record. -/
def specToImplementation
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (g : SpecGrade Monotonicity Level) :
    ImplementationGrade Monotonicity Level :=
  ⟨g.usage, g.monotonicity, g.level, g.budget⟩

/-- Decode an implementation grade into the C3 specification record. -/
def implementationToSpec
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (g : ImplementationGrade Monotonicity Level) :
    SpecGrade Monotonicity Level :=
  ⟨g.usage, g.monotonicity, g.level, g.budget⟩

theorem specToImplementation_toSpecification
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (g : SpecGrade Monotonicity Level) :
    implementationToSpec (specToImplementation g) = g := by
  cases g
  rfl

theorem implementationToSpecification_toImplementation
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (g : ImplementationGrade Monotonicity Level) :
    specToImplementation (implementationToSpec g) = g := by
  cases g
  rfl

/-- The usage projection is preserved by the representation map. -/
theorem specToImplementation_piU
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (g : SpecGrade Monotonicity Level) :
    K7pl.UsageScale.piU (specToImplementation g) =
      K7pl.Spec.C3.EffectiveKernel.piU g := rfl

/-- Specification-level and implementation-level scaling commute with the map. -/
theorem specToImplementation_scaleUsage
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (a : K7pl.Spec.C3.EffectiveKernel.Usage)
    (g : SpecGrade Monotonicity Level) :
    specToImplementation (K7pl.Spec.C3.EffectiveKernel.scaleUsage a g) =
      K7pl.UsageScale.scaleUsage a (specToImplementation g) := rfl

#print axioms K7PL.Proofs.Grades.specToImplementation_toSpecification
#print axioms K7PL.Proofs.Grades.implementationToSpecification_toImplementation
#print axioms K7PL.Proofs.Grades.specToImplementation_piU
#print axioms K7PL.Proofs.Grades.specToImplementation_scaleUsage

end K7PL.Proofs.Grades
