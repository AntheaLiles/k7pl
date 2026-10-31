// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// A text, as the reader sees it: a sequence of expressions, each of them either well
// layered (layers.k) or containing refused inclusions (crossings.k).

requires "crossings.k"

module READER
  imports CROSSINGS

  syntax Program ::= List{Expression, ""} [symbol(program)]

  // A train, a run made only of glyphs (tokens.k, Q-LEX-201), is read as an atom of a
  // sort of its own; the grammar of the layers counts it among the symbols.
  syntax Atom ::= Train
  syntax Train [token]
endmodule
