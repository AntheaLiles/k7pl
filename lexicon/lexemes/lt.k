// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// The lexeme `<`, the layer 3 glyph whose alias is `lt` (chapter 1, table of glyphs).
// Its production keeps the parentheses of the experimental subset.

requires "literals.k"

module LT
  imports LITERALS

  syntax K7Exp ::= "(" "<" K7Exp K7Exp ")" [symbol(k7Lt), strict]

  // Comparison returns a builtin Bool value injected into K7Exp.
  rule (< I:Int J:Int) => I <Int J [label(k7LessThanEval)]

  rule typeOf((< E1:K7Exp E2:K7Exp)) => BoolType
    requires typeOf(E1) ==K IntType andBool typeOf(E2) ==K IntType
endmodule
