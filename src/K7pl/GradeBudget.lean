-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Data.ENat.Basic
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
def truncatedSub : ℕ∞ → ℕ∞ → ℕ∞
  | WithTop.none, _ => WithTop.none
  | WithTop.some _, WithTop.none => WithTop.some 0
  | WithTop.some b, WithTop.some k => WithTop.some (b - k)

@[simp] theorem truncatedSub_top (k : ℕ∞) :
    truncatedSub ⊤ k = ⊤ := by
  rfl

@[simp] theorem truncatedSub_finite_infinite (b : ℕ) :
    truncatedSub (b : ℕ∞) ⊤ = 0 := by
  rfl

@[simp] theorem truncatedSub_finite_finite (b k : ℕ) :
    truncatedSub (b : ℕ∞) (k : ℕ∞) = ((b - k : ℕ) : ℕ∞) := by
  rfl

/-- Finite execution multiplicities commute with the ratified subtraction,
for every pair of extended-natural budget and cost bounds. This arithmetic
identity alone does not make a partial `Consume` operation total: its
admissibility precondition remains a separate obligation. -/
theorem finite_multiplicity_compatibility (n : ℕ) (β k : ℕ∞) :
    (n : ℕ∞) * truncatedSub β k =
      truncatedSub ((n : ℕ∞) * β) ((n : ℕ∞) * k) := by
  cases β with
  | none =>
      cases n with
      | zero => simp [truncatedSub]
      | succ n => simp [truncatedSub]
  | some b =>
      cases k with
      | none =>
          cases n with
          | zero => simp [truncatedSub]
          | succ n => simp [truncatedSub]
      | some k =>
          cases n with
          | zero => simp [truncatedSub]
          | succ n =>
              simp [truncatedSub, Nat.mul_sub_left_distrib]

/-- The law cannot be extended to an infinite multiplier: with budget and cost
both equal to 2, the left side is 0 while the right side is ∞. -/
theorem infinite_multiplicity_counterexample :
    (⊤ : ℕ∞) * truncatedSub 2 2 ≠
      truncatedSub ((⊤ : ℕ∞) * 2) ((⊤ : ℕ∞) * 2) := by
  norm_num [truncatedSub]

end K7pl.GradeBudget
