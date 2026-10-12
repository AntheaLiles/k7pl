-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

/-!
# Finite range arithmetic for the memory proof profile

This proves only the interval-level part of H2. Mapping these ranges to K7PL's
actual region identities and capability rules remains a separate obligation;
this file does not prove memory safety, H1, or H3.
-/

namespace K7pl.MemoryRange

/-- A finite closed range of natural-number positions. -/
structure Range where
  first : ℕ
  last : ℕ
  valid : first ≤ last

/-- Two closed ranges are disjoint when one ends before the other begins. -/
def Disjoint (r s : Range) : Prop :=
  r.last < s.first ∨ s.last < r.first

/-- Disjoint well-formed ranges cannot denote the same range value. -/
theorem disjoint_ne {r s : Range} (h : Disjoint r s) : r ≠ s := by
  intro heq
  subst s
  rcases h with h | h
  · exact (Nat.not_lt_of_ge r.valid) h
  · exact (Nat.not_lt_of_ge r.valid) h

end K7pl.MemoryRange
