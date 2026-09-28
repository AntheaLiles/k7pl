-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Cslib.Foundations.Semantics.LTS.Basic

/-!
# Operational semantics of a counter

A counter described as a labelled transition system (`Cslib.LTS`), and a multistep execution.
This module is the reference example of a CSLib-based development.

## Main definitions

* `K7pl.Semantics.Action`: the actions of the counter.
* `K7pl.Semantics.step`: the effect of an action on the state.
* `K7pl.Semantics.counter`: the counter as an LTS over `Nat`.

## Main statements

* `K7pl.Semantics.counter_incr_twice`: two increments lead from `n` to `n + 2`.

## Implementation notes

The transition relation is defined from the executable function `step`, so that
single transitions can be proved by `rfl` and tested with `#guard`.
-/

namespace K7pl.Semantics

open Cslib

/-- Actions of the counter. -/
inductive Action where
  /-- Add one to the counter. -/
  | incr
  /-- Reset the counter to zero. -/
  | reset
  deriving DecidableEq, Repr

/-- The effect of an action on the state of the counter. -/
def step (n : Nat) : Action → Nat
  | .incr => n + 1
  | .reset => 0

/-- The counter as an LTS: `n --a--> m` exactly when `m = step n a`. -/
def counter : LTS Nat Action where
  Tr := fun n a m => m = step n a

/-- Two increments lead from `n` to `n + 2`. -/
theorem counter_incr_twice (n : Nat) : counter.MTr n [.incr, .incr] (n + 2) := by
  refine LTS.MTr.stepL (s2 := n + 1) ?_ (LTS.MTr.stepL (s2 := n + 2) ?_ LTS.MTr.refl)
  · rfl
  · rfl

end K7pl.Semantics
