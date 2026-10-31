// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// The lexeme `+`, the layer 3 glyph whose alias is `add` (chapter 1, table of glyphs).
// Its production keeps the parentheses of the experimental subset.

requires "literals.k"

module ADD
  imports LITERALS

  syntax K7Exp ::= "(" "+" K7Exp K7Exp ")" [symbol(k7Add), strict]

  // Chapter 5 arithmetic example family. The rule uses the source production
  // itself; k7Add is an internal label, not source syntax.
  rule (+ I:Int J:Int) => I +Int J [label(k7AddEval)]

  rule typeOf((+ E1:K7Exp E2:K7Exp)) => IntType
    requires typeOf(E1) ==K IntType andBool typeOf(E2) ==K IntType
endmodule
