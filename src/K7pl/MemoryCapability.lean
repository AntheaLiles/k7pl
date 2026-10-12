-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Data.Nat.Basic
import Mathlib.Tactic

/-!
# Linear arena-capability invariant

This module formalizes the resource-counting core of H1. A region has a count
of available arena tokens and a count of live write capabilities; the invariant
states that their sum is at most one. Allocation consumes one arena token and
creates one write capability. Parallel composition adds the two resource states.

This is an abstract invariant model, not yet the operational rules for
`Arena`, `WriteCap`, `alloc_range`, or `Par` in the K7PL source language.
-/

namespace K7pl.MemoryCapability

universe u

variable {Region : Type u}

/-- For each region, count available arena tokens and live write capabilities. -/
abbrev State (Region : Type u) := Region → ℕ × ℕ

/-- At most one arena-or-writer token exists for any region. -/
def Unique (s : State Region) : Prop :=
  ∀ r, (s r).1 + (s r).2 ≤ 1

/-- Allocation replaces one available arena token by one write capability. -/
def allocate [DecidableEq Region] (s : State Region) (r : Region) :
    State Region :=
  fun q =>
    if q = r then ((s r).1 - 1, (s r).2 + 1) else s q

/-- Allocation preserves uniqueness when the state was unique and has an arena token. -/
theorem allocate_preserves_unique [DecidableEq Region]
    (s : State Region) (r : Region) (hUnique : Unique s)
    (hArena : (s r).1 > 0) :
    Unique (allocate s r) := by
  intro q
  by_cases hqr : q = r
  · subst q
    have hCount := hUnique r
    simp [allocate]
    omega
  · have hCount := hUnique q
    simpa [allocate, hqr] using hCount

/-- Parallel composition adds capability counts pointwise, without duplicating them silently. -/
def parallel (left right : State Region) : State Region :=
  fun r => ((left r).1 + (right r).1, (left r).2 + (right r).2)

/-- Two parallel contexts cannot both own a writer for one region if their union is unique. -/
theorem no_double_writer [DecidableEq Region] (left right : State Region)
    (hUnique : Unique (parallel left right)) (r : Region)
    (hLeft : (left r).2 > 0) (hRight : (right r).2 > 0) : False := by
  have hCount := hUnique r
  simp [parallel] at hCount
  omega

end K7pl.MemoryCapability
