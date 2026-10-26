// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Lexical syntax used to read a text (kompile --syntax-module TOKENS). It is kept out of
// the module that holds the rules, whose own parser would otherwise read K variables
// as symbols.
//
// - A symbol is any run of characters other than white space, the six delimiters,
//   the double quote and the semicolon. Glyphs, sigils and suffixes such as `?` or `!`
//   are therefore symbols at this level.
// - A number is an optionally signed decimal, with an optional fractional part.
// - A string is enclosed in double quotes; a backslash escapes the next character.
// - A semicolon opens a comment that runs to the end of the line; `;;`, `;;;` and
//   `;;;;` are comments of the same kind.

requires "reader.k"

module TOKENS
  imports READER

  syntax Symbol ::= r"[^ \\t\\n\\r\\[\\](){}\\\";]+" [token]
  syntax Number ::= r"[+\\-]?[0-9]+(\\.[0-9]+)?" [token, prec(1)]
  syntax String ::= r"\\\"([^\\\"\\\\]|\\\\.)*\\\"" [token]

  syntax #Layout ::= r"(;[^\\n\\r]*)"
                   | r"([\\ \\n\\r\\t])"
endmodule
