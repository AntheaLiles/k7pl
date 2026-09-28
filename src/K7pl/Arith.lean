-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Mathlib.Tactic.Ring

/-!
# Arithmetic expressions

A toy expression language, its evaluator, and a verified program transformation.
This module is the reference example of a Mathlib-based development.

## Main definitions

* `K7pl.Arith.Expr`: syntax of arithmetic expressions.
* `K7pl.Arith.Expr.eval`: evaluation of an expression to an integer.
* `K7pl.Arith.double`: builds an expression worth twice its argument, without multiplication.

## Main statements

* `K7pl.Arith.eval_double`: `double` preserves the semantics.
-/

namespace K7pl.Arith

/-- Arithmetic expressions over the integers. -/
inductive Expr where
  /-- An integer literal. -/
  | lit : Int → Expr
  /-- The sum of two expressions. -/
  | add : Expr → Expr → Expr
  /-- The product of two expressions. -/
  | mul : Expr → Expr → Expr
  deriving Repr

/-- The value of an expression. -/
def Expr.eval : Expr → Int
  | .lit n => n
  | .add a b => a.eval + b.eval
  | .mul a b => a.eval * b.eval

/-- An expression worth twice `e`, built with an addition instead of a multiplication. -/
def double (e : Expr) : Expr := .add e e

/-- `double` preserves the semantics: it evaluates to `2 * e`. -/
theorem eval_double (e : Expr) : (double e).eval = 2 * e.eval := by
  simp only [double, Expr.eval]
  ring

end K7pl.Arith
