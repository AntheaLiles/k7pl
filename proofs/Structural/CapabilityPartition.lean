-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import K7pl.MemoryRange

/-!
# Separation of finite memory ranges

The range representation and its disjointness predicate come from the
implementation module. This file proves elementary relation laws and
reuses the existing interval-level H2 lemma. It does not identify ranges with
physical regions and therefore does not establish the full spatial-safety
hypotheses H1/H2/H3.
-/

namespace K7PL.Proofs.Structural

abbrev Range := K7pl.MemoryRange.Range
abbrev Disjoint := K7pl.MemoryRange.Disjoint

theorem disjoint_symmetric {r s : Range} (h : Disjoint r s) :
    Disjoint s r := by
  rcases h with h | h
  · exact Or.inr h
  · exact Or.inl h

theorem disjoint_irreflexive (r : Range) : ¬ Disjoint r r := by
  intro h
  rcases h with h | h
  · exact Nat.lt_irrefl _ h
  · exact Nat.lt_irrefl _ h

theorem disjoint_ranges_have_distinct_representations
    {r s : Range} (h : Disjoint r s) : r ≠ s :=
  K7pl.MemoryRange.disjoint_ne h

#print axioms K7PL.Proofs.Structural.disjoint_symmetric
#print axioms K7PL.Proofs.Structural.disjoint_irreflexive
#print axioms K7PL.Proofs.Structural.disjoint_ranges_have_distinct_representations

end K7PL.Proofs.Structural
