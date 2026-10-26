// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Lexical syntax used to read a text (kompile --syntax-module TOKENS). It is kept out of
// the module that holds the rules, whose own parser would otherwise read K variables
// as symbols.
//
// Status: proposal, not a decision. The author validates the lexical classes one by one
// in the questionnaire (wiki/questions.md, lot "Reading and delimiters"), where the
// definitions below are listed as material to consider; meanwhile they are what the
// layer checker runs.
//
// - A symbol is any run of characters other than white space, the six delimiters and
//   the double quote; a semicolon belongs to it when a symbol character follows, and a
//   lone semicolon is a symbol of its own. Glyphs, sigils and contract marks such as
//   `?` or `!` are therefore symbols at this level.
// - A number is an optionally signed decimal, with an optional fractional part.
// - A string is enclosed in double quotes; a backslash escapes the next character.
// - Comments (author's choice of 2026-10-26, Q-LEX-004): `;;` opens a comment that runs
//   to the end of the line, `;;;` a heading and `;;;;` a sub-heading. A semicolon just
//   before an opening delimiter disables the tree it opens: this reader does not
//   implement that form yet, and reads `;(` as a lone semicolon followed by `(`.

requires "reader.k"

module TOKENS
  imports READER

  syntax Symbol ::= r"([^ \\t\\n\\r\\[\\](){}\\\";]|;[^ \\t\\n\\r\\[\\](){}\\\";])+|;" [token]
  syntax Number ::= r"[+\\-]?[0-9]+(\\.[0-9]+)?" [token, prec(1)]
  syntax String ::= r"\\\"([^\\\"\\\\]|\\\\.)*\\\"" [token]

  syntax #Layout ::= r"(;;[^\\n\\r]*)"
                   | r"([\\ \\n\\r\\t])"
endmodule
