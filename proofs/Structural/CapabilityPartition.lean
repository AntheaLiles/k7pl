-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import Mathlib.Data.Finset.Basic

/-!
# Finite capability-region partitions

The theorem below is a set-theoretic partition lemma. It is a small reusable
component for later capability proofs; it does not establish the linear
introduction, range denotation, or non-capture hypotheses H1/H2/H3 of the
spatial-safety statement in C4.
-/

namespace K7PL.Proofs.Structural

structure DisjointPartition (whole left right : Finset Nat) : Prop where
  covers : left ∪ right = whole
  separated : ∀ region, region ∈ left → region ∈ right → False

theorem partition_exactly_one_owner
    {whole left right : Finset Nat}
    (partition : DisjointPartition whole left right)
    {region : Nat}
    (belongs : region ∈ whole) :
    (region ∈ left ∨ region ∈ right) ∧
      ¬ (region ∈ left ∧ region ∈ right) := by
  have inUnion : region ∈ left ∪ right := by
    rw [partition.covers]
    exact belongs
  exact ⟨Finset.mem_union.mp inUnion, fun overlap =>
    partition.separated region overlap.1 overlap.2⟩

#print axioms K7PL.Proofs.Structural.partition_exactly_one_owner

end K7PL.Proofs.Structural
