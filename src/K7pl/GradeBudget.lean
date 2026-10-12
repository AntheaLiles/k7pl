-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Data.ENat.Monoid
import Mathlib.Tactic.NormNum

/-!
# Formal arithmetic for K7PL budget annotations

This module formalizes bounded arithmetic facts over ℕ∞ and generic temporal
profile aggregation. The profile type matches the work/depth pair structure
written in C2, but is not yet linked to the canonical K7PL domain K, effect
judgement, Adm, Consume, ψ, substitution, or resource-correctness theorem.
-/

namespace K7pl.GradeBudget

universe u

/-- A temporal profile assigns work and depth bounds to each level. -/
abbrev TemporalProfile (L : Type u) := L → ℕ∞ × ℕ∞

/-- Supremum of accumulated work over all finite sets of levels. -/
noncomputable def workAggregate {L : Type u} (κ : TemporalProfile L) : ℕ∞ :=
  ⨆ F : Finset L, ∑ ℓ ∈ F, (κ ℓ).1

/-- Supremum of per-level depth. On an empty level type, this is zero. -/
noncomputable def depthAggregate {L : Type u} (κ : TemporalProfile L) : ℕ∞ :=
  ⨆ ℓ : L, (κ ℓ).2

/-- Scalarized budget cost, as the maximum of total work and maximum depth. -/
noncomputable def costBudget {L : Type u} (κ : TemporalProfile L) : ℕ∞ :=
  max (workAggregate κ) (depthAggregate κ)

/-- Work aggregation is monotone in every per-level work bound. -/
theorem workAggregate_mono {L : Type u} (κ κ' : TemporalProfile L)
    (h : ∀ ℓ, (κ ℓ).1 ≤ (κ' ℓ).1) :
    workAggregate κ ≤ workAggregate κ' := by
  unfold workAggregate
  apply iSup_le
  intro F
  apply le_iSup_of_le F
  exact Finset.sum_le_sum (fun ℓ _ => h ℓ)

/-- Depth aggregation is monotone in every per-level depth bound. -/
theorem depthAggregate_mono {L : Type u} (κ κ' : TemporalProfile L)
    (h : ∀ ℓ, (κ ℓ).2 ≤ (κ' ℓ).2) :
    depthAggregate κ ≤ depthAggregate κ' := by
  unfold depthAggregate
  apply iSup_le
  intro ℓ
  exact le_iSup_of_le ℓ (h ℓ)

/-- The max scalarization is monotone when work and depth are monotone. -/
theorem costBudget_mono {L : Type u} (κ κ' : TemporalProfile L)
    (hw : ∀ ℓ, (κ ℓ).1 ≤ (κ' ℓ).1)
    (hd : ∀ ℓ, (κ ℓ).2 ≤ (κ' ℓ).2) :
    costBudget κ ≤ costBudget κ' := by
  unfold costBudget
  exact max_le_max (workAggregate_mono κ κ' hw) (depthAggregate_mono κ κ' hd)

/-- The depth supremum on an empty level set is the bottom of ℕ∞, namely 0. -/
theorem depthAggregate_empty (κ : TemporalProfile Empty) :
    depthAggregate κ = 0 := by
  simp [depthAggregate]

/-- The finite-subset work supremum on an empty level set is 0. -/
theorem workAggregate_empty (κ : TemporalProfile Empty) :
    workAggregate κ = 0 := by
  unfold workAggregate
  apply le_antisymm
  · apply iSup_le
    intro F
    induction F using Finset.induction_on with
    | empty => simp
    | @insert x F hx ih => cases x
  · exact le_iSup_of_le ∅ (by simp)


/-- Extended truncated subtraction for budget bounds.

An infinite budget remains infinite after any subtraction. A finite budget
minus an infinite cost is zero; for finite arguments, subtraction is natural
truncated subtraction. In particular, `∞ ⊖ ∞ = ∞`, not the residual of addition.
-/
def truncatedSub (β k : ℕ∞) : ℕ∞ :=
  if β = ⊤ then ⊤ else β - k

/-- The zero-cost case leaves the budget unchanged. -/
@[simp] theorem truncatedSub_zero (β : ℕ∞) :
    truncatedSub β 0 = β := by
  cases β <;> simp [truncatedSub]

@[simp] theorem truncatedSub_top (k : ℕ∞) :
    truncatedSub ⊤ k = ⊤ := by
  simp [truncatedSub]

@[simp] theorem truncatedSub_finite_infinite (b : ℕ) :
    truncatedSub (b : ℕ∞) ⊤ = 0 := by
  simp [truncatedSub]

@[simp] theorem truncatedSub_finite_finite (b k : ℕ) :
    truncatedSub (b : ℕ∞) (k : ℕ∞) = ((b - k : ℕ) : ℕ∞) := by
  simp [truncatedSub]

/-- A product of finite natural grades remains finite in ℕ∞. -/
private theorem finite_mul_ne_top (n b : ℕ) :
    (n : ℕ∞) * (b : ℕ∞) ≠ ⊤ := by
  apply WithTop.mul_ne_top <;> exact WithTop.coe_ne_top

/-- Finite execution multiplicities commute with the ratified subtraction,
for every pair of extended-natural budget and cost bounds. This arithmetic
identity alone does not make a partial `Consume` operation total: its
admissibility precondition remains a separate obligation. -/
theorem finite_multiplicity_compatibility (n : ℕ) (β k : ℕ∞) :
    (n : ℕ∞) * truncatedSub β k =
      truncatedSub ((n : ℕ∞) * β) ((n : ℕ∞) * k) := by
  cases β with
  | top =>
      cases n with
      | zero => simp [truncatedSub]
      | succ n => simp [truncatedSub]
  | coe b =>
      cases k with
      | top =>
          have hb : (n : ℕ∞) * (b : ℕ∞) ≠ ⊤ := finite_mul_ne_top n b
          simp [truncatedSub, hb, ENat.mul_top']
          split_ifs with hn <;> simp [hn]
      | coe k =>
          have hb : (n : ℕ∞) * (b : ℕ∞) ≠ ⊤ := finite_mul_ne_top n b
          change (n : ℕ∞) * ((b - k : ℕ) : ℕ∞) =
            truncatedSub ((n : ℕ∞) * (b : ℕ∞)) ((n : ℕ∞) * (k : ℕ∞))
          simp only [truncatedSub, hb]
          rw [← ENat.natCast_mul, ← ENat.natCast_mul]
          congr 1
          exact Nat.mul_sub_left_distrib n b k

/-- Exact extended-natural arithmetic counterpart of C2's truncated-subtraction
compatibility law: it holds for every finite multiplier, or for any multiplier
when the subtracted cost is zero. This does not establish that a K7PL rule
actually depends on this law. -/
theorem truncated_sub_mul_compatibility (u β k : ℕ∞)
    (h : u ≠ ⊤ ∨ k = 0) :
    u * truncatedSub β k = truncatedSub (u * β) (u * k) := by
  rcases h with hu | hk
  · cases u with
    | top => exact False.elim (hu rfl)
    | coe n => simpa using finite_multiplicity_compatibility n β k
  · subst k
    simp [truncatedSub]

/-- The law cannot be extended to an infinite multiplier: with budget and cost
both equal to 2, the left side is 0 while the right side is ∞. -/
theorem infinite_multiplicity_counterexample :
    (⊤ : ℕ∞) * truncatedSub 2 2 ≠
      truncatedSub ((⊤ : ℕ∞) * 2) ((⊤ : ℕ∞) * 2) := by
  norm_num [truncatedSub]

/-- On ℕ∞, the explicit infinite-budget disjunct is redundant because every
cost is bounded by ⊤. This proves only an order-theoretic normalization; it
does not define K7PL's Adm predicate or formalize Cost_Budget. -/
theorem top_disjunct_iff_le (cost budget : ℕ∞) :
    (budget = ⊤ ∨ cost ≤ budget) ↔ cost ≤ budget := by
  constructor
  · intro h
    rcases h with htop | hle
    · rw [htop]
      exact le_top
    · exact hle
  · exact Or.inr

end K7pl.GradeBudget
