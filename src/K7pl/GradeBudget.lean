-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Data.ENat.Monoid
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.ENat.Lattice
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
  ⨆ (F : Finset L), F.sum (fun ℓ => (κ ℓ).1)

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


/-- Canonical zero temporal profile. -/
def zeroTemporalProfile {L : Type u} : TemporalProfile L := fun _ => (0, 0)

/-- The sum-of-finite-subsets work aggregate of the zero profile is zero. -/
theorem workAggregate_zero {L : Type u} :
    workAggregate (zeroTemporalProfile (L := L)) = 0 := by
  unfold workAggregate zeroTemporalProfile
  apply le_antisymm
  · apply iSup_le
    intro F
    simp
  · exact bot_le

/-- The depth aggregate of the zero profile is zero, including on empty levels. -/
theorem depthAggregate_zero {L : Type u} :
    depthAggregate (zeroTemporalProfile (L := L)) = 0 := by
  unfold depthAggregate zeroTemporalProfile
  apply le_antisymm
  · apply iSup_le
    intro ℓ
    exact bot_le
  · exact bot_le

/-- The scalarized cost of the zero temporal profile is zero. -/
theorem costBudget_zero {L : Type u} :
    costBudget (zeroTemporalProfile (L := L)) = 0 := by
  unfold costBudget
  rw [workAggregate_zero, depthAggregate_zero]
  simp

/-- Every per-level work bound is included in the work supremum. -/
theorem work_le_workAggregate {L : Type u} (κ : TemporalProfile L) (ℓ : L) :
    (κ ℓ).1 ≤ workAggregate κ := by
  unfold workAggregate
  exact le_iSup_of_le {ℓ} (by simp)

/-- Every per-level depth bound is included in the depth supremum. -/
theorem depth_le_depthAggregate {L : Type u} (κ : TemporalProfile L) (ℓ : L) :
    (κ ℓ).2 ≤ depthAggregate κ := by
  unfold depthAggregate
  exact le_iSup_of_le ℓ (le_rfl : (κ ℓ).2 ≤ (κ ℓ).2)

/-- The least-scalar-bound property for max(workAggregate, depthAggregate). -/
theorem costBudget_le_of_bounds {L : Type u} (κ : TemporalProfile L) (b : ℕ∞)
    (hw : workAggregate κ ≤ b) (hd : depthAggregate κ ≤ b) :
    costBudget κ ≤ b := by
  unfold costBudget
  exact max_le hw hd

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
    rw [truncatedSub_zero, mul_zero, truncatedSub_zero]

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


/-- If the announced cost is covered by the budget, truncated subtraction
leaves a residual whose addition to the cost recovers the original budget.
This is an arithmetic fact about the chosen bound convention on ℕ∞. -/
theorem truncatedSub_add_of_le (β k : ℕ∞) (h : k ≤ β) :
    truncatedSub β k + k = β := by
  cases β with
  | top =>
      simp [truncatedSub]
  | coe b =>
      cases k with
      | top =>
          simp at h
      | coe k =>
          have hk : k ≤ b := by simpa using h
          rw [truncatedSub_finite_finite]
          exact_mod_cast Nat.sub_add_cancel hk

/-- Generic profile-level admissibility: the scalarized profile cost is
covered by the supplied budget. This is not yet the canonical K7PL predicate
because TemporalProfile has not been identified with the normative domain K. -/
def profileAdmissible {L : Type u} (β : ℕ∞) (κ : TemporalProfile L) : Prop :=
  costBudget κ ≤ β

/-- Profile-level consumption is available only with a proof of admissibility.
It models the partial domain contract from D6, but is not yet K7PL Consume. -/
noncomputable def profileConsume {L : Type u} (β : ℕ∞) (κ : TemporalProfile L)
    (_admissible : profileAdmissible β κ) : ℕ∞ :=
  truncatedSub β (costBudget κ)

/-- On the admitted profile domain, the residual plus the announced scalar cost
recovers the budget under the selected ℕ∞ convention. This theorem does not
show that a concrete K7PL operational step respects the budget. -/
theorem profileConsume_conservation {L : Type u} (β : ℕ∞)
    (κ : TemporalProfile L) (h : profileAdmissible β κ) :
    profileConsume β κ h + costBudget κ = β := by
  unfold profileConsume
  exact truncatedSub_add_of_le β (costBudget κ) h

/-! ## Named bridge to the C2 temporal domain

C2 fixes the canonical carrier as K = (ℕ∞ × ℕ∞)^L. The alias below makes that
carrier explicit in Lean. The named K-level functions are deliberately thin
wrappers over the proved generic profile operations: their definitional
equalities are checkable, while their correspondence to the operational
K7PL rules remains a separate proof obligation.
-/

/-- C2's canonical temporal-profile carrier (for a level type `L`). -/
abbrev K (L : Type u) := TemporalProfile L

/-- C2's named scalar cost on the canonical carrier K. -/
noncomputable def costBudgetK {L : Type u} (κ : K L) : ℕ∞ :=
  costBudget κ

/-- The D5 coverage predicate on the canonical carrier K. -/
def admK {L : Type u} (β : ℕ∞) (κ : K L) : Prop :=
  costBudgetK κ ≤ β

/-- The D6 partial-consumption interface: a result is available only with an
admissibility witness. This is the formal K-level interface, not yet a proof
that each operational rule invokes it correctly. -/
noncomputable def consumeK {L : Type u} (β : ℕ∞) (κ : K L)
    (_admissible : admK β κ) : ℕ∞ :=
  truncatedSub β (costBudgetK κ)

/-- The named K-level cost is definitionally the scalarization max(W,D). -/
theorem costBudgetK_eq_max {L : Type u} (κ : K L) :
    costBudgetK κ = max (workAggregate κ) (depthAggregate κ) := by
  rfl

/-- D5's canonical K-level predicate is exactly budget coverage. -/
theorem admK_iff_coverage {L : Type u} (β : ℕ∞) (κ : K L) :
    admK β κ ↔ costBudgetK κ ≤ β := Iff.rfl

/-- D6 conservation on the admitted K-level domain. -/
theorem consumeK_conservation {L : Type u} (β : ℕ∞)
    (κ : K L) (h : admK β κ) :
    consumeK β κ h + costBudgetK κ = β := by
  unfold consumeK
  exact truncatedSub_add_of_le β (costBudgetK κ) h

/-- Contract for a budget-boundary step after its rule proves admissibility. -/
structure BudgetBoundaryCertificate (L : Type u) where
  /-- Budget available before the boundary. -/
  budgetBefore : ℕ∞
  /-- Temporal profile whose cost is charged at the boundary. -/
  profile : K L
  /-- The rule's proof that the declared cost is covered. -/
  admissible : admK budgetBefore profile
  /-- Budget remaining after consumption. -/
  budgetAfter : ℕ∞
  /-- The rule must consume exactly the certified profile cost. -/
  residual_is_consume :
    budgetAfter = consumeK budgetBefore profile admissible

/-- Every budget-boundary certificate conserves budget and charged profile cost. -/
theorem BudgetBoundaryCertificate.conservation {L : Type u}
    (step : BudgetBoundaryCertificate L) :
    step.budgetAfter + costBudgetK step.profile = step.budgetBefore := by
  rw [step.residual_is_consume]
  exact consumeK_conservation step.budgetBefore step.profile step.admissible


/-! ## Reference temporal-profile composition

These operators implement C2's per-level reference equations: sequential
composition adds both work and depth; parallel composition adds work and
takes the maximum of the two depths. They are profile-level constructors,
not yet the effect composition or transition rules of the K7PL language.
-/

/-- Sequential composition of temporal profiles: work and depth both add. -/
def sequentialProfile {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) : TemporalProfile L :=
  fun ℓ => ((κ₁ ℓ).1 + (κ₂ ℓ).1, (κ₁ ℓ).2 + (κ₂ ℓ).2)

/-- Parallel composition: work adds while depth is the maximum. -/
def parallelProfile {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) : TemporalProfile L :=
  fun ℓ => ((κ₁ ℓ).1 + (κ₂ ℓ).1, max (κ₁ ℓ).2 (κ₂ ℓ).2)

/-- Sequential profile composition is associative. -/
theorem sequentialProfile_assoc {L : Type u}
    (κ₁ κ₂ κ₃ : TemporalProfile L) :
    sequentialProfile (sequentialProfile κ₁ κ₂) κ₃ =
      sequentialProfile κ₁ (sequentialProfile κ₂ κ₃) := by
  funext ℓ
  apply Prod.ext
  · simp [sequentialProfile, add_assoc]
  · simp [sequentialProfile, add_assoc]

/-- Parallel profile composition is associative. -/
theorem parallelProfile_assoc {L : Type u}
    (κ₁ κ₂ κ₃ : TemporalProfile L) :
    parallelProfile (parallelProfile κ₁ κ₂) κ₃ =
      parallelProfile κ₁ (parallelProfile κ₂ κ₃) := by
  funext ℓ
  apply Prod.ext
  · simp [parallelProfile, add_assoc]
  · simp [parallelProfile, max_assoc]

/-- Parallel composition is commutative as a cost-profile operation. -/
theorem parallelProfile_comm {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) :
    parallelProfile κ₁ κ₂ = parallelProfile κ₂ κ₁ := by
  funext ℓ
  apply Prod.ext
  · simp [parallelProfile, add_comm]
  · simp [parallelProfile, max_comm]

/-- The zero profile is a left identity for sequential composition. -/
theorem sequentialProfile_zero_left {L : Type u}
    (κ : TemporalProfile L) :
    sequentialProfile (zeroTemporalProfile (L := L)) κ = κ := by
  funext ℓ
  apply Prod.ext <;> simp [sequentialProfile, zeroTemporalProfile]

/-- The zero profile is a right identity for sequential composition. -/
theorem sequentialProfile_zero_right {L : Type u}
    (κ : TemporalProfile L) :
    sequentialProfile κ (zeroTemporalProfile (L := L)) = κ := by
  funext ℓ
  apply Prod.ext <;> simp [sequentialProfile, zeroTemporalProfile]

/-- The zero profile is a left identity for parallel composition. -/
theorem parallelProfile_zero_left {L : Type u}
    (κ : TemporalProfile L) :
    parallelProfile (zeroTemporalProfile (L := L)) κ = κ := by
  funext ℓ
  apply Prod.ext <;> simp [parallelProfile, zeroTemporalProfile]

/-- The zero profile is a right identity for parallel composition. -/
theorem parallelProfile_zero_right {L : Type u}
    (κ : TemporalProfile L) :
    parallelProfile κ (zeroTemporalProfile (L := L)) = κ := by
  funext ℓ
  apply Prod.ext <;> simp [parallelProfile, zeroTemporalProfile]

/-- The work aggregate of a sequential profile is bounded by the sum of the
individual work aggregates. This direction is the one needed for a safe
scalar budget upper bound; it does not claim completeness for an unbounded
family without an additional supremum theorem. -/
theorem workAggregate_sequential_le_add {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) :
    workAggregate (sequentialProfile κ₁ κ₂) ≤
      workAggregate κ₁ + workAggregate κ₂ := by
  unfold workAggregate sequentialProfile
  apply iSup_le
  intro F
  rw [Finset.sum_add_distrib]
  exact add_le_add
    (le_iSup_of_le F le_rfl)
    (le_iSup_of_le F le_rfl)

/-- The depth aggregate of a sequential profile is bounded by the sum of the
individual depth aggregates. -/
theorem depthAggregate_sequential_le_add {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) :
    depthAggregate (sequentialProfile κ₁ κ₂) ≤
      depthAggregate κ₁ + depthAggregate κ₂ := by
  unfold depthAggregate sequentialProfile
  apply iSup_le
  intro ℓ
  exact add_le_add
    (le_iSup_of_le ℓ le_rfl)
    (le_iSup_of_le ℓ le_rfl)

/-- The depth aggregate of a parallel profile is exactly the maximum of the
separate depth aggregates. -/
theorem depthAggregate_parallel_eq_max {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) :
    depthAggregate (parallelProfile κ₁ κ₂) =
      max (depthAggregate κ₁) (depthAggregate κ₂) := by
  unfold depthAggregate parallelProfile
  apply le_antisymm
  · apply iSup_le
    intro ℓ
    exact max_le_max
      (le_iSup_of_le ℓ le_rfl)
      (le_iSup_of_le ℓ le_rfl)
  · apply max_le
    · apply iSup_le
      intro ℓ
      exact le_iSup_of_le ℓ (le_max_left _ _)
    · apply iSup_le
      intro ℓ
      exact le_iSup_of_le ℓ (le_max_right _ _)

/-- Sequential composition admits a scalar cost upper bound computed from
the separate work and depth bounds. -/
theorem costBudget_sequential_le {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) :
    costBudget (sequentialProfile κ₁ κ₂) ≤
      max (workAggregate κ₁ + workAggregate κ₂)
          (depthAggregate κ₁ + depthAggregate κ₂) := by
  unfold costBudget
  exact max_le_max
    (workAggregate_sequential_le_add κ₁ κ₂)
    (depthAggregate_sequential_le_add κ₁ κ₂)

/-- Parallel composition admits the expected scalar cost upper bound. The
work component is additive; its depth component is the maximum. -/
theorem costBudget_parallel_le {L : Type u}
    (κ₁ κ₂ : TemporalProfile L) :
    costBudget (parallelProfile κ₁ κ₂) ≤
      max (workAggregate κ₁ + workAggregate κ₂)
          (max (depthAggregate κ₁) (depthAggregate κ₂)) := by
  unfold costBudget
  rw [depthAggregate_parallel_eq_max]
  apply max_le_max
  · rw [show workAggregate (parallelProfile κ₁ κ₂) =
      workAggregate (sequentialProfile κ₁ κ₂) by rfl]
    exact workAggregate_sequential_le_add κ₁ κ₂
  · exact le_rfl

end K7pl.GradeBudget
