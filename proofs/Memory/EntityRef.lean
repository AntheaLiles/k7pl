-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import Mathlib.Tactic

/-!
# Generation-based entity references

This intentionally unbounded Nat model isolates the stale-reference property
under generation increment. It omits bounded machine counters, concurrent
readers, reclamation quiescence, persistence and restore semantics.
-/

namespace K7PL.Proofs.Memory

structure EntityRef where
  slot : Nat
  generation : Nat
  deriving DecidableEq, Repr

structure SlotState where
  slot : Nat
  generation : Nat
  occupied : Bool
  deriving DecidableEq, Repr

def currentReference (state : SlotState) : EntityRef :=
  ⟨state.slot, state.generation⟩

def reuseSlot (state : SlotState) : SlotState :=
  { state with generation := state.generation + 1, occupied := true }

def resolves (state : SlotState) (reference : EntityRef) : Prop :=
  state.slot = reference.slot ∧
  state.occupied = true ∧
  state.generation = reference.generation

theorem reuse_invalidates_previous_reference (state : SlotState) :
    ¬ resolves (reuseSlot state) (currentReference state) := by
  intro h
  have generationEq :
      state.generation + 1 = state.generation := by
    simpa [reuseSlot, currentReference] using h.2.2
  omega

#print axioms K7PL.Proofs.Memory.reuse_invalidates_previous_reference

end K7PL.Proofs.Memory
