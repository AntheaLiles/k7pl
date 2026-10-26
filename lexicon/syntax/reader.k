// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// A text, as the reader sees it: a sequence of expressions, each of them either well
// layered (layers.k) or containing refused inclusions (crossings.k).

requires "crossings.k"

module READER
  imports CROSSINGS

  syntax Program ::= List{Expression, ""} [symbol(program)]
endmodule
