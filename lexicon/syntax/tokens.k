// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Lexical syntax used to read a text (kompile --syntax-module TOKENS). It is kept out of
// the module that holds the rules, whose own parser would otherwise read K variables
// as symbols. stream.k repeats these classes for the balance reader, and
// tools/layer-check reads every text with both readers.
//
// Each class follows the author's answers to the reading lot (wiki/questions.md,
// questionnaires of 2026-10-26 and 2026-10-27); what is still open is marked a proposal.
//
// - A symbol is any run of characters other than white space, the six delimiters and
//   the double quote. A semicolon belongs to it when a symbol character follows, and a
//   lone semicolon is a symbol of its own: `a;` reads `a` then `;`, `a;b` is one symbol
//   (Q-LEX-105). A sigil (`#`, `:`, `@`, `?`, `!`, Q-LEX-102) starts a symbol; Phase 0
//   turns it into an attribute (chapter 6).
// - A train is a run made only of glyphs of the table of chapter 1 (tab:glyphes) and of
//   the modifiers ´ and ¨, each character one glyph; any other run is read whole, as a
//   name or a number (Q-LEX-201). reader.k gives trains a sort of their own.
// - A number (Q-NUM-105) is a decimal with an optional fraction and exponent, whose
//   digits may be grouped by `_`; a rational `1/3`; a complex `3+4i`; `inf`, `-inf` or
//   `nan`. Radix prefixes are not numbers.
// - A string is enclosed in double quotes and may span lines (Q-STR-103). Proposal, until
//   the escapes are chosen (Q-STR-201): a backslash escapes the next character; an
//   unknown escape is to be refused (Q-STR-102).
// - Comments (Q-LEX-004): `;;` opens a comment that runs to the end of the line, `;;;` a
//   heading and `;;;;` a sub-heading. A semicolon just before an opening delimiter
//   disables the tree it opens; this reader reads `;(` as a lone semicolon followed by
//   `(`, and so checks the disabled tree like any other (Q-LEX-104). stream.k marks it.

requires "reader.k"

module TOKENS
  imports READER

  syntax Symbol ::= r"([^ \\t\\n\\r\\[\\](){}\\\";]|;[^ \\t\\n\\r\\[\\](){}\\\";])+|;" [token]
  syntax Train ::= r"(\\+|-|×|÷|⌊|⌈|≠|⊏|⊔|⍋|⍒|↕|∾|⊣|⊢|⥊|∧|∨|¬|=|<|>|≤|≥|⍟|⊘|↢|↣|´|¨)+" [token, prec(2)]
  syntax Number ::= r"[+\\-]?([0-9](_?[0-9])*(\\.[0-9](_?[0-9])*)?([eE][+\\-]?[0-9]+)?|[0-9](_?[0-9])*\\/[0-9](_?[0-9])*|[0-9](_?[0-9])*(\\.[0-9](_?[0-9])*)?([eE][+\\-]?[0-9]+)?[+\\-][0-9](_?[0-9])*(\\.[0-9](_?[0-9])*)?([eE][+\\-]?[0-9]+)?i|inf)|nan" [token, prec(1)]
  syntax String ::= r"\\\"([^\\\"\\\\]|\\\\.)*\\\"" [token]

  syntax #Layout ::= r"(;;[^\\n\\r]*)"
                   | r"([\\ \\n\\r\\t])"
endmodule
