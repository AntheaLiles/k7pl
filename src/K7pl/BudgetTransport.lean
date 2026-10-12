-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import K7pl.GradeBudget
import K7pl.UsageScale

/-!
# Budget transport through graded contexts

This module instantiates C2's usage/budget separation with an explicit
context-level model of ψ. Applying ψ requires a proof that the announced
profile cost is covered by every present binding's budget. The transformation
subtracts only that cost from the budget coordinate.

These are interface-level proofs. They do not establish that K7PL's actual
typing or operational rules invoke ψ at the right sites, or that their
profiles describe the cost of concrete executions.
-/

namespace K7pl.BudgetTransport

universe v w x

variable {Var : Type x} {M : Type v} {L : Type w}

/-- The context admits ψ for profile κ when every present binding covers its cost. -/
def psiAdmissible (κ : GradeBudget.K L)
    (Δ : UsageScale.Context Var UsageScale.Usage M L) : Prop :=
  ∀ x g, Δ x = some g → GradeBudget.costBudgetK κ ≤ g.budget

/-- Apply ψ to a context, requiring an explicit per-binding budget certificate.

Only the budget coordinate changes; usage, monotonicity, level, and support
are preserved. The proof argument makes the admissible domain visible in the
API, even though the underlying subtraction is total on ℕ∞.
-/
def psiContext (κ : GradeBudget.K L)
    (Δ : UsageScale.Context Var UsageScale.Usage M L)
    (_admissible : psiAdmissible κ Δ) :
    UsageScale.Context Var UsageScale.Usage M L :=
  fun x =>
    Option.map
      (fun g =>
        { g with budget :=
            GradeBudget.truncatedSub g.budget (GradeBudget.costBudgetK κ) })
      (Δ x)

/-- Scaling usage cannot invalidate the budget precondition of ψ. -/
private theorem scaledBindingBudget
    (a : UsageScale.Usage)
    (Δ : UsageScale.Context Var UsageScale.Usage M L)
    (x : Var) (g : UsageScale.Grade UsageScale.Usage M L)
    (h : UsageScale.scaleUsageContext a Δ x = some g) :
    ∃ g₀, Δ x = some g₀ ∧ g.budget = g₀.budget := by
  cases hd : Δ x with
  | none =>
      simp [UsageScale.scaleUsageContext, hd] at h
  | some g₀ =>
      have hg : { g₀ with usage := a * g₀.usage } = g := by
        simpa [UsageScale.scaleUsageContext, UsageScale.scaleUsage, hd] using h
      subst g
      exact ⟨g₀, hd, rfl⟩

/-- The usage-scaling action preserves ψ admissibility. -/
theorem psiAdmissible_scale
    (a : UsageScale.Usage)
    (κ : GradeBudget.K L)
    (Δ : UsageScale.Context Var UsageScale.Usage M L)
    (h : psiAdmissible κ Δ) :
    psiAdmissible κ (UsageScale.scaleUsageContext a Δ) := by
  intro x g hx
  rcases scaledBindingBudget a Δ x g hx with ⟨g₀, hΔ, hbudget⟩
  rw [hbudget]
  exact h x g₀ hΔ

/-- C2's coherence law: usage scaling commutes with the context action ψ.

The equality is claimed only under ψ's admissibility certificate. -/
theorem psiContext_scale_commute
    (a : UsageScale.Usage)
    (κ : GradeBudget.K L)
    (Δ : UsageScale.Context Var UsageScale.Usage M L)
    (h : psiAdmissible κ Δ) :
    UsageScale.scaleUsageContext a (psiContext κ Δ h) =
      psiContext κ (UsageScale.scaleUsageContext a Δ)
        (psiAdmissible_scale a κ Δ h) := by
  funext x
  cases hx : Δ x with
  | none =>
      simp [psiContext, UsageScale.scaleUsageContext, hx]
  | some g =>
      cases g with
      | mk usage monotonicity level budget =>
          simp [psiContext, UsageScale.scaleUsageContext,
            UsageScale.scaleUsage, hx]

/-- Every present binding conserves its budget and the charged profile cost. -/
theorem psiContext_binding_conserves_budget
    (κ : GradeBudget.K L)
    (Δ : UsageScale.Context Var UsageScale.Usage M L)
    (h : psiAdmissible κ Δ)
    (x : Var) (g : UsageScale.Grade UsageScale.Usage M L)
    (hx : Δ x = some g) :
    ∃ g',
      psiContext κ Δ h x = some g' ∧
      g'.budget + GradeBudget.costBudgetK κ = g.budget := by
  refine ⟨
    { g with budget :=
        GradeBudget.truncatedSub g.budget (GradeBudget.costBudgetK κ) },
    ?_, ?_⟩
  · simp [psiContext, hx]
  · exact GradeBudget.truncatedSub_add_of_le
      g.budget (GradeBudget.costBudgetK κ) (h x g hx)

end K7pl.BudgetTransport
