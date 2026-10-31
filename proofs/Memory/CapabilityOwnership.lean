-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0

import K7pl.MemoryCapability
import Mathlib.Tactic

/-!
# Linear capability ownership

This domain reuses the implementation's resource-counting abstraction:
each region has arena tokens and live write capabilities, with their sum
bounded by one. The results are properties of that abstraction, not yet a
simulation of the K rules for Arena, WriteCap, alloc_range or Par.
-/

namespace K7PL.Proofs.Memory

universe u

abbrev CapabilityState (Region : Type u) :=
  K7pl.MemoryCapability.State Region

abbrev Unique {Region : Type u} (state : CapabilityState Region) : Prop :=
  K7pl.MemoryCapability.Unique state

theorem allocate_preserves_unique
    {Region : Type u} [DecidableEq Region]
    (state : CapabilityState Region) (region : Region)
    (hUnique : Unique state) (hArena : (state region).1 > 0) :
    Unique (K7pl.MemoryCapability.allocate state region) :=
  K7pl.MemoryCapability.allocate_preserves_unique
    state region hUnique hArena

theorem no_double_writer
    {Region : Type u}
    (left right : CapabilityState Region)
    (hUnique : Unique (K7pl.MemoryCapability.parallel left right))
    (region : Region)
    (hLeft : (left region).2 > 0)
    (hRight : (right region).2 > 0) : False :=
  K7pl.MemoryCapability.no_double_writer left right hUnique region hLeft hRight

/-- The uniqueness invariant bounds arena and writer counts separately. -/
theorem writer_count_le_one
    {Region : Type u} (state : CapabilityState Region)
    (hUnique : Unique state) (region : Region) :
    (state region).2 ≤ 1 := by
  have h := hUnique region
  dsimp [K7pl.MemoryCapability.Unique] at h
  omega

/-- The uniqueness invariant also bounds the remaining arena-token count. -/
theorem arena_count_le_one
    {Region : Type u} (state : CapabilityState Region)
    (hUnique : Unique state) (region : Region) :
    (state region).1 ≤ 1 := by
  have h := hUnique region
  dsimp [K7pl.MemoryCapability.Unique] at h
  omega

#print axioms K7PL.Proofs.Memory.allocate_preserves_unique
#print axioms K7PL.Proofs.Memory.no_double_writer
#print axioms K7PL.Proofs.Memory.writer_count_le_one
#print axioms K7PL.Proofs.Memory.arena_count_le_one

end K7PL.Proofs.Memory
