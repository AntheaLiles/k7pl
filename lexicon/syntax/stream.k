// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// A text as balance.k reads it: a stream of delimiters, atoms and line breaks. Unlike the
// tree of reader.k, a stream does not need its delimiters to pair, so a text whose
// delimiters do not pair is still read, and each fault is reported with its line.
//
// A semicolon written just before an opening delimiter disables the tree that delimiter
// opens (chapter 5); the disabled tree is read and checked like any other (author's
// choice of 2026-10-26, Q-LEX-104).

module STREAM
  syntax Item ::= "[" [symbol(openSquare)]  | "]" [symbol(closeSquare)]
                | "(" [symbol(openParen)]   | ")" [symbol(closeParen)]
                | "{" [symbol(openBrace)]   | "}" [symbol(closeBrace)]
                | ";[" [symbol(disabledSquare)]
                | ";(" [symbol(disabledParen)]
                | ";{" [symbol(disabledBrace)]
                | Word | Text | OpenText | Newline

  syntax Stream ::= List{Item, ""} [symbol(stream)]

  syntax Word [token]    // a symbol, a train or a number
  syntax Text [token]    // a string literal, which may span lines
  syntax OpenText [token] // a string never closed: it runs to the end of the text
  syntax Newline [token]
endmodule

// Lexical syntax of the stream (kompile --syntax-module SCANNER). A word is a symbol, a
// train or a number of tokens.k, and a text one of its strings; comments are those of
// chapter 5.
// tools/layer-check reads every text with both readers, so that a difference between the
// two lexical syntaxes shows as a disagreement.
module SCANNER
  imports STREAM

  syntax Word ::= r"([^ \\t\\n\\r\\[\\](){}\\\";]|;[^ \\t\\n\\r\\[\\](){}\\\";])+|;" [token]
  syntax Text ::= r"\\\"([^\\\"\\\\]|\\\\.)*\\\"" [token]
  syntax OpenText ::= r"\\\"([^\\\"\\\\]|\\\\.)*" [token]
  syntax Newline ::= r"\\r?\\n" [token]

  syntax #Layout ::= r"(;;[^\\n\\r]*)"
                   | r"([\\ \\r\\t])"
endmodule
