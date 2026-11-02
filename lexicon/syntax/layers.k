// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Grammar of the three layers (chapter 5). Each production transcribes one rule of the
// author's grammar of 2026-10-26:
//
//   expression     = atom | square-exp | paren-exp | brace-exp ;
//   square-exp     = "[", { square-content }, "]" ;
//   square-content = atom | square-exp ;
//   paren-exp      = "(", { paren-content }, ")" ;
//   paren-content  = atom | paren-exp | square-exp ;
//   brace-exp      = "{", { brace-content }, "}" ;
//   brace-content  = atom | brace-exp | paren-exp | square-exp ;
//   atom           = symbol | number | string ;
//
// `[ ]` opens layer 3, `( )` layer 2 and `{ }` layer 1. The lexical classes of the
// atoms are given in tokens.k.

module LAYERS
  syntax Expression ::= Atom | SquareExp | ParenExp | BraceExp

  syntax SquareExp ::= "[" SquareContents "]" [symbol(squareExp)]
  syntax SquareContents ::= List{SquareContent, ""} [symbol(squareContents)]
  syntax SquareContent ::= Atom | SquareExp

  syntax ParenExp ::= "(" ParenContents ")" [symbol(parenExp)]
  syntax ParenContents ::= List{ParenContent, ""} [symbol(parenContents)]
  syntax ParenContent ::= Atom | ParenExp | SquareExp

  syntax BraceExp ::= "{" BraceContents "}" [symbol(braceExp)]
  syntax BraceContents ::= List{BraceContent, ""} [symbol(braceContents)]
  syntax BraceContent ::= Atom | BraceExp | ParenExp | SquareExp

  syntax Atom ::= Symbol | Number | String
  syntax Symbol [token]
  syntax Number [token]
  syntax String [token]
endmodule
