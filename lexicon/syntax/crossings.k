// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// The three inclusions that the grammar of the layers refuses. Of the nine ways to put
// one pair of delimiters inside another, layers.k admits six; each production below is
// one of the three it lacks. Adding them lets every bracketed text be read, so that a
// refusal is attached to the rule it breaks instead of being a bare parse failure.
// The codes are numbered from the most specific container (layer 3) to the most
// generic one (layer 1); codes.k gives their messages.

requires "layers.k"

module CROSSINGS
  imports LAYERS

  syntax SquareContent ::= ParenExp // ERR-TOP-001: ( ) inside [ ]
                         | BraceExp // ERR-TOP-002: { } inside [ ]

  syntax ParenContent ::= BraceExp  // ERR-TOP-003: { } inside ( )
endmodule
