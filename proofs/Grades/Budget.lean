-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import K7pl.GradeBudget

/-!
# Budget domain

The canonical implementation model is used directly: profiles inhabit
(ℕ∞ × ℕ∞)^L, scalar cost is max(work, depth), admissibility is cost coverage,
and consumption is defined only with an admissibility witness. This module
collects the principal sequential/parallel and partial-consumption contracts
and proves an order bound on the returned residual.
-/

namespace K7PL.Proofs.Grades

universe u

abbrev TemporalProfile (Level : Type u) := K7pl.GradeBudget.K Level

noncomputable def costBudget {Level : Type u} (κ : TemporalProfile Level) : ℕ∞ :=
  K7pl.GradeBudget.costBudgetK κ

def Admissible {Level : Type u} (budget : ℕ∞)
    (κ : TemporalProfile Level) : Prop :=
  K7pl.GradeBudget.admK budget κ

noncomputable def consume {Level : Type u} (budget : ℕ∞)
    (κ : TemporalProfile Level) (h : Admissible budget κ) : ℕ∞ :=
  K7pl.GradeBudget.consumeK budget κ h

/-- Every profile is admissible against the top (unbounded) budget. -/
theorem unbounded_budget_admissible
    {Level : Type u} (κ : TemporalProfile Level) :
    Admissible ⊤ κ := by
  exact le_top

/-- Truncated subtraction never returns more budget than was available. -/
theorem truncatedSub_le_budget (budget cost : ℕ∞) :
    K7pl.GradeBudget.truncatedSub budget cost ≤ budget := by
  cases budget with
  | top => simp [K7pl.GradeBudget.truncatedSub]
  | coe b =>
      cases cost with
      | top => simp [K7pl.GradeBudget.truncatedSub]
      | coe k =>
          change ((↑(b - k) : ℕ∞) ≤ (↑b : ℕ∞))
          exact_mod_cast Nat.sub_le b k

/-- Consumption is bounded by the declared budget on its partial domain. -/
theorem consumeK_bounded_by_budget
    {Level : Type u} (budget : ℕ∞) (κ : TemporalProfile Level)
    (h : Admissible budget κ) :
    consume budget κ h ≤ budget := by
  unfold consume K7pl.GradeBudget.consumeK
  exact truncatedSub_le_budget budget (costBudget κ)

/-- The partial consumption operation conserves the declared budget and cost. -/
theorem consumeK_conservation
    {Level : Type u} (budget : ℕ∞) (κ : TemporalProfile Level)
    (h : Admissible budget κ) :
    consume budget κ h + costBudget κ = budget :=
  K7pl.GradeBudget.consumeK_conservation budget κ h

/-- Parallel profile cost uses additive work and maximum depth. -/
theorem parallel_cost_characterization
    {Level : Type u} (left right : TemporalProfile Level) :
    K7pl.GradeBudget.costBudget
        (K7pl.GradeBudget.parallelProfile left right) =
      max
        (K7pl.GradeBudget.workAggregate left +
          K7pl.GradeBudget.workAggregate right)
        (max
          (K7pl.GradeBudget.depthAggregate left)
          (K7pl.GradeBudget.depthAggregate right)) :=
  K7pl.GradeBudget.costBudget_parallel_eq left right

/-- Sequential profile composition admits the sum-of-work/depth upper bound. -/
theorem sequential_cost_upper_bound
    {Level : Type u} (left right : TemporalProfile Level) :
    K7pl.GradeBudget.costBudget
        (K7pl.GradeBudget.sequentialProfile left right) ≤
      max
        (K7pl.GradeBudget.workAggregate left +
          K7pl.GradeBudget.workAggregate right)
        (K7pl.GradeBudget.depthAggregate left +
          K7pl.GradeBudget.depthAggregate right) :=
  K7pl.GradeBudget.costBudget_sequential_le left right

#print axioms K7PL.Proofs.Grades.unbounded_budget_admissible
#print axioms K7PL.Proofs.Grades.truncatedSub_le_budget
#print axioms K7PL.Proofs.Grades.consumeK_bounded_by_budget
#print axioms K7PL.Proofs.Grades.consumeK_conservation
#print axioms K7PL.Proofs.Grades.parallel_cost_characterization
#print axioms K7PL.Proofs.Grades.sequential_cost_upper_bound

end K7PL.Proofs.Grades
