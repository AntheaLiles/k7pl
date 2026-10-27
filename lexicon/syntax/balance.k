// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Reading a text as a visibly pushdown automaton (chapter 5): an opening delimiter is
// pushed, with its line; a closing delimiter pops the delimiter of its pair. Each fault is
// reported with the delimiter at fault and its line:
//
// - ERR-DLM-001: an opening delimiter never closed;
// - ERR-DLM-002: a closing delimiter while no delimiter is open;
// - ERR-DLM-003: a closing delimiter of another pair than every delimiter still open;
// - ERR-DLM-004: a string never closed, which runs to the end of the text (Q-ERR-101);
// - ERR-TOP-001 to ERR-TOP-003: an opening delimiter that the grammar of the layers does
//   not admit inside the delimiter it opens in (crossings.k).
//
// Recovery (author's choice of 2026-10-26, Q-LEX-006-d: delimiters work by two): a closing
// delimiter closes the nearest open delimiter of its pair, and the delimiters opened after
// that one are reported as never closed. A closing delimiter whose pair is not open closes
// nothing. A text is well read exactly when it produces no report.

requires "stream.k"
requires "codes.k"

// The line breaks inside a string literal, which may span lines. K's STRING module is not
// imported: its string literals and the message tokens of codes.k cannot share one grammar.
// Chars is K's string sort, reached through the native functions it needs.
module LINES
  imports STREAM
  imports INT

  syntax Chars [hook(STRING.String)]
  syntax Chars ::= chars(Text) [function, total, hook(STRING.token2string)]
                 | openChars(OpenText) [function, total, hook(STRING.token2string)]
                 | character(Int) [function, total, hook(STRING.chr)]
  syntax Int ::= occurrences(Chars, Chars) [function, total, hook(STRING.countAllOccurrences)]

  syntax Int ::= lineBreaks(Text) [function, total]
                | openLineBreaks(OpenText) [function, total]
  rule lineBreaks(T) => occurrences(chars(T), character(10))
  rule openLineBreaks(T) => occurrences(openChars(T), character(10))
endmodule

module BALANCE
  imports STREAM
  imports CODES
  imports LINES
  imports INT
  imports BOOL
  imports K-EQUAL

  syntax Pair ::= "square" [symbol(square)] | "paren" [symbol(paren)] | "brace" [symbol(brace)]
                | "quote" [symbol(quote)] // the double quotes of a string

  // The delimiters still open, the innermost first, each with the line where it opens.
  syntax Open ::= opened(Pair, Int) [symbol(opened)]
  syntax Opens ::= List{Open, ""} [symbol(opens)]

  // Where a fault is: the delimiter at fault and its line, or, for ERR-DLM-003, the
  // closing delimiter and the innermost open delimiter it meets.
  syntax Site ::= at(Pair, Int) [symbol(at)]
                | meets(Pair, Int, Pair, Int) [symbol(meets)]

  syntax Report ::= located(Refusal, Site) [symbol(located)]
  syntax Reports ::= List{Report, ""} [symbol(reports)]

  syntax Reports ::= Reports "+++" Reports [function, total, right]
  rule .Reports +++ R:Reports => R
  rule (X:Report Xs:Reports) +++ R:Reports => X (Xs +++ R)

  syntax Reports ::= read(Stream, Opens, Int) [function]
  rule read(.Stream, S, _) => unclosed(S)
  rule read(_:Newline I, S, L) => read(I, S, L +Int 1)
  rule read(T:Text I, S, L) => read(I, S, L +Int lineBreaks(T))
  rule read(T:OpenText I, S, L) => located(refuse(ERR-DLM-004), at(quote, L)) read(I, S, L +Int openLineBreaks(T))
  rule read(_:Word I, S, L) => read(I, S, L)
  rule read(`openSquare`(.KList) I, S, L) => push(I, S, L, square)
  rule read(`openParen`(.KList) I, S, L) => push(I, S, L, paren)
  rule read(`openBrace`(.KList) I, S, L) => push(I, S, L, brace)
  rule read(`disabledSquare`(.KList) I, S, L) => push(I, S, L, square)
  rule read(`disabledParen`(.KList) I, S, L) => push(I, S, L, paren)
  rule read(`disabledBrace`(.KList) I, S, L) => push(I, S, L, brace)
  rule read(`closeSquare`(.KList) I, S, L) => pop(I, S, L, square)
  rule read(`closeParen`(.KList) I, S, L) => pop(I, S, L, paren)
  rule read(`closeBrace`(.KList) I, S, L) => pop(I, S, L, brace)

  // Opening: the grammar of the layers decides whether P may open inside the innermost
  // open delimiter. A refused delimiter is still pushed, so that its contents are read.
  syntax Reports ::= push(Stream, Opens, Int, Pair) [function]
  rule push(I, S, L, P) => read(I, opened(P, L) S, L) requires admits(S, P)
  rule push(I, S, L, P) => located(refuse(crossing(S, P)), at(P, L)) read(I, opened(P, L) S, L)
    requires notBool admits(S, P)

  syntax Bool ::= admits(Opens, Pair) [function, total]
  rule admits(.Opens, _) => true
  rule admits(opened(brace, _) _, _) => true
  rule admits(opened(paren, _) _, P) => P =/=K brace
  rule admits(opened(square, _) _, P) => P ==K square

  syntax Code ::= crossing(Opens, Pair) [function]
  rule crossing(opened(square, _) _, paren) => ERR-TOP-001
  rule crossing(opened(square, _) _, brace) => ERR-TOP-002
  rule crossing(opened(paren, _) _, brace) => ERR-TOP-003

  // Closing.
  syntax Reports ::= pop(Stream, Opens, Int, Pair) [function]
  rule pop(I, opened(P, _) S, L, P) => read(I, S, L)
  rule pop(I, .Opens, L, P) => located(refuse(ERR-DLM-002), at(P, L)) read(I, .Opens, L)
  rule pop(I, opened(Q, M) S, L, P) => located(refuse(ERR-DLM-001), at(Q, M)) pop(I, S, L, P)
    requires Q =/=K P andBool stillOpen(S, P)
  rule pop(I, opened(Q, M) S, L, P) => located(refuse(ERR-DLM-003), meets(P, L, Q, M)) read(I, opened(Q, M) S, L)
    requires Q =/=K P andBool notBool stillOpen(S, P)

  syntax Bool ::= stillOpen(Opens, Pair) [function, total]
  rule stillOpen(.Opens, _) => false
  rule stillOpen(opened(Q, _) S, P) => Q ==K P orBool stillOpen(S, P)

  // At the end of the text, the delimiters still open are reported in the order they open.
  syntax Reports ::= unclosed(Opens) [function, total]
  rule unclosed(.Opens) => .Reports
  rule unclosed(opened(P, M) S) => unclosed(S) +++ located(refuse(ERR-DLM-001), at(P, M)) .Reports

  configuration <k> read($PGM:Stream, .Opens, 1) </k>
endmodule
