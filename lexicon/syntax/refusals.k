// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Refusals of the layer grammar: each forbidden inclusion of crossings.k produces its
// code and its message (codes.k), in the order of the text. A text is well layered exactly
// when it produces no refusal. balance.k checks the same inclusions on a stream of
// delimiters; tools/layer-check requires the two readers to agree.

requires "reader.k"
requires "codes.k"
requires "tokens.k" // lexical syntax of the texts read by this definition

module REFUSALS
  imports READER
  imports CODES

  syntax Refusals ::= List{Refusal, ""} [symbol(refusals)]

  syntax Refusals ::= Refusals "+++" Refusals [function, total, right]
  rule .Refusals +++ R:Refusals => R
  rule (X:Refusal Xs:Refusals) +++ R:Refusals => X (Xs +++ R)

  syntax Refusals ::= crossings(Program)       [function, total]
                    | expression(Expression)   [function, total]
                    | inSquare(SquareContents) [function, total]
                    | inParen(ParenContents)   [function, total]
                    | inBrace(BraceContents)   [function, total]

  rule crossings(.Program) => .Refusals
  rule crossings(E:Expression P:Program) => expression(E) +++ crossings(P)

  rule expression(_:Atom) => .Refusals
  rule expression([ C:SquareContents ]) => inSquare(C)
  rule expression(( C:ParenContents )) => inParen(C)
  rule expression({ C:BraceContents }) => inBrace(C)

  // Inside [ ]: atoms and [ ] only. A refused inclusion is still read in its own layer,
  // so that the refusals nested in it are reported as well.
  rule inSquare(.SquareContents) => .Refusals
  rule inSquare(_:Atom C:SquareContents) => inSquare(C)
  rule inSquare([ D:SquareContents ] C:SquareContents) => inSquare(D) +++ inSquare(C)
  rule inSquare(( D:ParenContents ) C:SquareContents) => refuse(ERR-TOP-001) (inParen(D) +++ inSquare(C))
  rule inSquare({ D:BraceContents } C:SquareContents) => refuse(ERR-TOP-002) (inBrace(D) +++ inSquare(C))

  // Inside ( ): atoms, ( ) and [ ].
  rule inParen(.ParenContents) => .Refusals
  rule inParen(_:Atom C:ParenContents) => inParen(C)
  rule inParen([ D:SquareContents ] C:ParenContents) => inSquare(D) +++ inParen(C)
  rule inParen(( D:ParenContents ) C:ParenContents) => inParen(D) +++ inParen(C)
  rule inParen({ D:BraceContents } C:ParenContents) => refuse(ERR-TOP-003) (inBrace(D) +++ inParen(C))

  // Inside { }: everything.
  rule inBrace(.BraceContents) => .Refusals
  rule inBrace(_:Atom C:BraceContents) => inBrace(C)
  rule inBrace([ D:SquareContents ] C:BraceContents) => inSquare(D) +++ inBrace(C)
  rule inBrace(( D:ParenContents ) C:BraceContents) => inParen(D) +++ inBrace(C)
  rule inBrace({ D:BraceContents } C:BraceContents) => inBrace(D) +++ inBrace(C)

  configuration <k> crossings($PGM:Program) </k>
endmodule
