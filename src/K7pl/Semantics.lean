-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Cslib.Foundations.Semantics.LTS.Basic

/-!
# Sémantique opérationnelle

Exemple d'utilisation de CSLib : un compteur décrit comme un système de
transitions étiquetées (`Cslib.LTS`), et une exécution en plusieurs étapes.
-/

namespace K7pl.Semantics

open Cslib

/-- Actions du compteur. -/
inductive Action where
  | incr
  | reset
  deriving DecidableEq, Repr

/-- Effet d'une action sur l'état du compteur. -/
def step (n : Nat) : Action → Nat
  | .incr => n + 1
  | .reset => 0

/-- Le compteur vu comme un LTS : `n --a--> m` lorsque `m = step n a`. -/
def counter : LTS Nat Action where
  Tr := fun n a m => m = step n a

/-- Deux incréments successifs mènent de `n` à `n + 2`. -/
theorem counter_incr_twice (n : Nat) : counter.MTr n [.incr, .incr] (n + 2) := by
  refine LTS.MTr.stepL (s2 := n + 1) ?_ (LTS.MTr.stepL (s2 := n + 2) ?_ LTS.MTr.refl)
  · rfl
  · rfl

end K7pl.Semantics
