-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Algebra.Order.Ring.NNRat
import Mathlib.Algebra.Order.Ring.WithTop
import Mathlib.Data.ENat.Lattice

/-!
# Usage scaling interface

The grade has four coordinates. Scaling changes only usage, never
monotonicity, level, or budget. The abstract laws are parametric; the
canonical usage carrier below is the nonnegative rationals with a top value.
This is not yet a proof that the K7PL typing rules preserve their contracts.
-/

namespace K7pl.UsageScale

universe u v w x

variable {U : Type u} {M : Type v} {L : Type w}
variable {Var : Type x}

/-- Canonical usage carrier: nonnegative rationals with a greatest value. -/
abbrev Usage := WithTop ℚ≥0

/-- The four-coordinate grade shape; only usage is scaled. -/
structure Grade (U : Type u) (M : Type v) (L : Type w) where
  usage : U
  monotonicity : M
  level : L
  budget : ℕ∞

/-- Scaling acts multiplicatively on usage alone. -/
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

/-- Unit scaling leaves the whole grade unchanged. -/
theorem scaleUsage_one [Monoid U] (g : Grade U M L) :
    scaleUsage (1 : U) g = g := by
  cases g with
  | mk usage monotonicity level budget =>
      simp [scaleUsage]

/-- Successive scaling composes by multiplication. -/
theorem scaleUsage_comp [Monoid U] (a b : U) (g : Grade U M L) :
    scaleUsage a (scaleUsage b g) = scaleUsage (a * b) g := by
  cases g with
  | mk usage monotonicity level budget =>
      simp [scaleUsage, mul_assoc]

/-- The usage projection selected by C-01. -/
def piU (g : Grade Usage M L) : Usage := g.usage

@[simp] theorem piU_eq_usage (g : Grade Usage M L) :
    piU g = g.usage := rfl

/-- The selected scaling action on grades with the canonical usage carrier. -/
def scaleUsageK7pl (a : Usage) (g : Grade Usage M L) : Grade Usage M L :=
  scaleUsage a g

theorem scaleUsageK7pl_one (g : Grade Usage M L) :
    scaleUsageK7pl 1 g = g := scaleUsage_one g

theorem scaleUsageK7pl_comp (a b : Usage) (g : Grade Usage M L) :
    scaleUsageK7pl a (scaleUsageK7pl b g) =
      scaleUsageK7pl (a * b) g := scaleUsage_comp a b g

/-- The chosen extension has the zero-times-infinity convention of C2. -/
theorem usage_zero_mul_top : (0 : Usage) * (⊤ : Usage) = 0 := by
  simp [Usage]

theorem usage_top_mul_zero : (⊤ : Usage) * (0 : Usage) = 0 := by
  simp [Usage]

theorem usage_one_mul_top : (1 : Usage) * (⊤ : Usage) = ⊤ := by
  simp [Usage]

theorem usage_top_mul_one : (⊤ : Usage) * (1 : Usage) = ⊤ := by
  simp [Usage]

theorem usage_top_mul_top : (⊤ : Usage) * (⊤ : Usage) = ⊤ := by
  simp [Usage]

/-- A context is a partial map from variables to grades. -/
abbrev Context (Var : Type x) (U : Type u) (M : Type v) (L : Type w) :=
  Var → Option (Grade U M L)

/-- Scale the usages in present context bindings. -/
def scaleUsageContext [Monoid U] (a : U) (Δ : Context Var U M L) :
    Context Var U M L :=
  fun x => Option.map (scaleUsage a) (Δ x)

/-- Scaling preserves the support of a context. -/
theorem scaleUsageContext_isSome [Monoid U] (a : U)
    (Δ : Context Var U M L) (x : Var) :
    (scaleUsageContext a Δ x).isSome = (Δ x).isSome := by
  cases h : Δ x <;> simp [scaleUsageContext, h]

/-- Unit scaling acts pointwise as the identity on contexts. -/
theorem scaleUsageContext_one [Monoid U] (Δ : Context Var U M L) :
    scaleUsageContext (1 : U) Δ = Δ := by
  funext x
  cases h : Δ x with
  | none => simp [scaleUsageContext, h]
  | some g => simp [scaleUsageContext, h, scaleUsage_one]

/-- Successive context scalings compose on every present binding. -/
theorem scaleUsageContext_comp [Monoid U] (a b : U)
    (Δ : Context Var U M L) :
    scaleUsageContext a (scaleUsageContext b Δ) =
      scaleUsageContext (a * b) Δ := by
  funext x
  cases h : Δ x with
  | none => simp [scaleUsageContext, h]
  | some g => simp [scaleUsageContext, h, scaleUsage_comp]

end K7pl.UsageScale
