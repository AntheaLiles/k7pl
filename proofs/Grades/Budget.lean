-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC0-1.0
import Mathlib.Tactic

/-!
# Finite budget arithmetic

This is an executable Nat-valued accounting model, not the specification's
full ℕ∞ budget algebra or its still-open partial Consume operation.
-/

namespace K7PL.Proofs.Grades

def consumeFinite (remaining requested : Nat) : Option Nat :=
  if requested ≤ remaining then some (remaining - requested) else none

theorem consumeFinite_succeeds
    {remaining requested : Nat}
    (h : requested ≤ remaining) :
    consumeFinite remaining requested = some (remaining - requested) := by
  simp [consumeFinite, h]

theorem consumeFinite_conserves
    {remaining requested : Nat}
    (h : requested ≤ remaining) :
    requested + (remaining - requested) = remaining := by
  omega

theorem consumeFinite_rejects_overdraw
    {remaining requested : Nat}
    (h : remaining < requested) :
    consumeFinite remaining requested = none := by
  simp [consumeFinite, Nat.not_le.mpr h]

#print axioms K7PL.Proofs.Grades.consumeFinite_succeeds
#print axioms K7PL.Proofs.Grades.consumeFinite_conserves
#print axioms K7PL.Proofs.Grades.consumeFinite_rejects_overdraw

end K7PL.Proofs.Grades
