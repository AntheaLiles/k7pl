// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// The lexeme `select` in its conditional reading (chapter 5). The word is also the
// alias of the glyph for selection by indices (chapter 1): that reading is not modelled here.
// Its production keeps the parentheses of the experimental subset.

requires "literals.k"

module SELECT
  imports LITERALS

  // Only the condition is strict: select does not evaluate its unchosen branch.
  syntax K7Exp ::= "(" "select" K7Exp K7Exp K7Exp ")" [symbol(k7Select), strict(1)]

  // Call-by-value conditional: strict(1) evaluates only the condition.
  rule (select true E1:K7Exp _E2:K7Exp) => E1 [label(k7SelectTrue)]
  rule (select false _E1:K7Exp E2:K7Exp) => E2 [label(k7SelectFalse)]

  rule typeOf((select C:K7Exp E1:K7Exp E2:K7Exp)) => typeOf(E1)
    requires typeOf(C) ==K BoolType andBool typeOf(E1) ==K typeOf(E2)
endmodule
