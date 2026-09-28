-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Tactic.Ring

/-!
# Expressions arithmétiques

Exemple d'utilisation de Mathlib : une petite syntaxe d'expressions, son
évaluateur, et une preuve de correction d'une transformation (tactique `ring`).
-/

namespace K7pl.Arith

/-- Expressions arithmétiques d'un langage jouet. -/
inductive Expr where
  | lit : Int → Expr
  | add : Expr → Expr → Expr
  | mul : Expr → Expr → Expr
  deriving Repr

/-- Évaluation d'une expression. -/
def Expr.eval : Expr → Int
  | .lit n => n
  | .add a b => a.eval + b.eval
  | .mul a b => a.eval * b.eval

/-- Doublement d'une expression, sans multiplication. -/
def double (e : Expr) : Expr := .add e e

/-- `double` préserve la sémantique : il calcule bien `2 * e`. -/
theorem eval_double (e : Expr) : (double e).eval = 2 * e.eval := by
  simp only [double, Expr.eval]
  ring

end K7pl.Arith
