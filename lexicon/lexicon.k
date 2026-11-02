// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Composition of the lexemes of lexicon/lexemes/ into one executable definition:
// one prefix expression runs in the K cell.

requires "lexemes/literals.k"
requires "lexemes/add.k"
requires "lexemes/lt.k"
requires "lexemes/select.k"

module LEXICON
  imports LITERALS
  imports ADD
  imports LT
  imports SELECT

  configuration <k> $PGM:K7Exp </k>
endmodule
