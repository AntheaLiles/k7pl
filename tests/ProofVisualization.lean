-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Spec.C3.EffectiveKernel

/-!
# Paperproof visualisation fixtures

These small proofs exercise tactic trees over the real C3 effective-kernel
definitions. They are deliberately examples for an editor-side visualisation,
not additional normative statements and not replacements for the canonical
proofs in `Spec.C3.EffectiveKernel`.

Paperproof is a VS Code extension; no Paperproof package import or runtime
dependency is needed to compile this module. The normal Lean build validates
the fixtures, while visual inspection of the proof trees remains a separate
manual check.
-/

namespace ProofVisualization

open K7pl.Spec.C3.EffectiveKernel

universe uVar uMono uLevel

/-- Fixture: record update, case analysis and simplification. Mirrors
`K7pl.Spec.C3.EffectiveKernel.scaleUsage_comp`. -/
theorem paperproof_scaleUsage_comp
    {Monotonicity : Type uMono} {Level : Type uLevel}
    (a b : Usage) (r : Grade Monotonicity Level) :
    scaleUsage a (scaleUsage b r) = scaleUsage (a * b) r := by
  cases r
  simp [scaleUsage, mul_assoc]

/-- Fixture: extensional equality of usage contexts. Mirrors
`K7pl.Spec.C3.EffectiveKernel.addContext_assoc`. -/
theorem paperproof_addContext_assoc {Var : Type uVar}
    (Γ Δ Θ : UsageContext Var) :
    addContext (addContext Γ Δ) Θ = addContext Γ (addContext Δ Θ) := by
  funext x
  simp [addContext, add_assoc]

/-- Fixture: case split on equality followed by simplification. Mirrors
`K7pl.Spec.C3.EffectiveKernel.eraseContext_singleton`. -/
theorem paperproof_eraseContext_singleton
    {Var : Type uVar} [DecidableEq Var] (x : Var) :
    eraseContext x (singletonContext x) = zeroContext := by
  funext y
  by_cases h : y = x <;> simp [eraseContext, singletonContext, zeroContext, h]

end ProofVisualization
