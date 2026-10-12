-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Data.ENat.Monoid
import Mathlib.Tactic.NormNum

/-!
# Formal arithmetic for K7PL budget annotations

This module formalizes only the extended-natural-number subtraction convention
ratified in the D8 decision trail and its compatibility with finite natural
multiplicities. It does not formalize the K7PL effect judgement, Adm, Consume,
ψ, substitution, or the complete temporal cost construction.
-/

namespace K7pl.GradeBudget

/-- Extended truncated subtraction for budget bounds.

An infinite budget remains infinite after any subtraction. A finite budget
minus an infinite cost is zero; for finite arguments, subtraction is natural
truncated subtraction. In particular, `∞ ⊖ ∞ = ∞`, not the residual of addition.
-/
def truncatedSub (β k : ℕ∞) : ℕ∞ :=
  if β = ⊤ then ⊤ else β - k

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
