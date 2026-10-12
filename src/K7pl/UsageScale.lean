-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Algebra.Group.Defs
import Mathlib.Data.ENat.Lattice

/-!
# Generic formal interface for usage scaling

This module formalizes the algebraic action selected as the C1 `Scale_Usage`
interface. It is parametric in the usage carrier and its multiplicative monoid
structure, and it explicitly leaves mode, level, and budget unchanged.

This is a reusable interface theorem, not yet the concrete K7PL instance:
the usage carrier must still be instantiated with the normative
`ℚ≥0 ∪ {ω}` structure, and the operation must still be connected to the
actual typing rules, conversions, and exponential structure.
-/

namespace K7pl.UsageScale

universe u v w x

variable {U : Type u} {M : Type v} {L : Type w}
variable {Var : Type x}

/-- The four-coordinate grade shape; only `usage` is scaled. `monotonicity` is not a structural mode. -/
structure Grade (U : Type u) (M : Type v) (L : Type w) where
  usage : U
  monotonicity : M
  level : L
  budget : ℕ∞

/-- The componentwise action on a grade, requiring only multiplicative laws. -/
def scaleUsage [Monoid U] (a : U) (g : Grade U M L) : Grade U M L :=
  { g with usage := a * g.usage }

@[simp] theorem scaleUsage_usage [Monoid U] (a : U) (g : Grade U M L) :
    (scaleUsage a g).usage = a * g.usage := rfl

@[simp] theorem scaleUsage_monotonicity [Monoid U] (a : U) (g : Grade U M L) :
    (scaleUsage a g).monotonicity = g.monotonicity := rfl

@[simp] theorem scaleUsage_level [Monoid U] (a : U) (g : Grade U M L) :
    (scaleUsage a g).level = g.level := rfl

@[simp] theorem scaleUsage_budget [Monoid U] (a : U) (g : Grade U M L) :
    (scaleUsage a g).budget = g.budget := rfl

/-- Scaling by the neutral usage leaves every grade component unchanged. -/
theorem scaleUsage_one [Monoid U] (g : Grade U M L) :
    scaleUsage (1 : U) g = g := by
  cases g with
  | mk usage monotonicity level budget =>
      simp [scaleUsage]

/-- Successive scaling composes by multiplication in the usage carrier. -/
theorem scaleUsage_comp [Monoid U] (a b : U) (g : Grade U M L) :
    scaleUsage a (scaleUsage b g) = scaleUsage (a * b) g := by
  cases g with
  | mk usage mode level budget =>
      simp [scaleUsage, mul_assoc]

/-- A context is a partial map from variables to grades. -/
abbrev Context (Var : Type x) (U : Type u) (M : Type v) (L : Type w) :=
  Var → Option (Grade U M L)

/-- The reference context action applies usage scaling to present bindings only. -/
def scaleUsageContext [Monoid U] (a : U) (Δ : Context Var U M L) :
    Context Var U M L :=
  fun x => Option.map (scaleUsage a) (Δ x)

/-- Context scaling preserves the domain/support of the context. -/
theorem scaleUsageContext_isSome [Monoid U] (a : U)
    (Δ : Context Var U M L) (x : Var) :
    (scaleUsageContext a Δ x).isSome = (Δ x).isSome := by
  cases h : Δ x <;> simp [scaleUsageContext, h]

/-- Identity scaling acts pointwise as the identity on contexts. -/
theorem scaleUsageContext_one [Monoid U] (Δ : Context Var U M L) :
    scaleUsageContext (1 : U) Δ = Δ := by
  funext x
  cases h : Δ x with
  | none => rfl
  | some g => simp [scaleUsageContext, h, scaleUsage_one]

/-- Successive context scalings compose, under the same usage monoid contract. -/
theorem scaleUsageContext_comp [Monoid U] (a b : U)
    (Δ : Context Var U M L) :
    scaleUsageContext a (scaleUsageContext b Δ) =
      scaleUsageContext (a * b) Δ := by
  funext x
  cases h : Δ x with
  | none => rfl
  | some g => simp [scaleUsageContext, h, scaleUsage_comp]

end K7pl.UsageScale
