// SPDX-FileCopyrightText: 2026 Cyprien PIERRE
// SPDX-License-Identifier: CECILL-2.1
//
// Codes and messages of the refusals emitted when a text is read. Both readers share them:
// refusals.k, which reads a text as a tree, and balance.k, which reads it as a stream of
// delimiters. The messages are those of annex A (tables tab:err-frontieres and
// tab:err-delimiteurs): they are rendered in the specification and stay in French, and
// tools/layer-check compares them word for word with the annex.
//
// - ERR-TOP-001 to ERR-TOP-003: the three inclusions refused by the grammar of the layers
//   (crossings.k), from the most specific container (layer 3) to the most generic one.
// - ERR-DLM-001 to ERR-DLM-003: delimiters that do not pair (author's choices of
//   2026-10-26, questionnaire Q-LEX-006 and Q-ERR-001: one code per kind of fault). Their
//   messages are proposals, put to the author in the third part of the lot.

module CODES
  syntax Code ::= "ERR-TOP-001" | "ERR-TOP-002" | "ERR-TOP-003"
                | "ERR-DLM-001" | "ERR-DLM-002" | "ERR-DLM-003"

  // A message is kept as written, in a token sort of its own.
  syntax Message ::= r"\\\"[^\\\"]*\\\"" [token]

  syntax Refusal ::= refusal(Code, Message) [symbol(refusal)]

  syntax Message ::= message(Code) [function, total]
  rule message(ERR-TOP-001) => "Structure de couche 2 `( )` instanciée dans un bloc de couche 3 `[ ]`. Déplacer le calcul dans un `let` de couche 2 en amont."
  rule message(ERR-TOP-002) => "Structure de couche 1 `{ }` instanciée dans un bloc de couche 3 `[ ]`. Déplacer le calcul dans un bloc `{ }` de couche 1 en amont."
  rule message(ERR-TOP-003) => "Structure de couche 1 `{ }` instanciée dans un bloc de couche 2 `( )`. Déplacer le calcul dans un bloc `{ }` de couche 1 en amont."
  rule message(ERR-DLM-001) => "Délimiteur ouvrant jamais refermé. Ajouter le délimiteur fermant de sa paire, ou retirer l'ouvrant."
  rule message(ERR-DLM-002) => "Délimiteur fermant sans délimiteur ouvrant. Retirer le fermant, ou ajouter l'ouvrant de sa paire."
  rule message(ERR-DLM-003) => "Délimiteur fermant d'une autre paire que les délimiteurs encore ouverts. Fermer le dernier délimiteur ouvert par le fermant de sa paire."

  syntax Refusal ::= refuse(Code) [function, total]
  rule refuse(C) => refusal(C, message(C))
endmodule
