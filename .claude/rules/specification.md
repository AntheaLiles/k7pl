<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Rules for working on the specification

## Status

`spec/` is the normative source of "K7PL : KonSept Programming Language".

The manuscript carries the instruction « ne rien modifier sans l'accord de l'auteur » ("change nothing without the author's consent"). A change to the conceptual content, a statement, a definition or a structure of the manuscript therefore requires an explicit request.

## Before editing

Identify:

1. the chapter and section concerned;
2. the definitions used;
3. the dependent statements;
4. the cross-references and citations;
5. the current status of the assertion;
6. the related tracking cards or obligations.

Never correct a statement merely because it makes the implementation easier.

## Epistemic statuses

Distinguish at least:

- intuition;
- definition;
- requirement;
- argued assertion;
- proposition;
- theorem;
- conjecture;
- formalised property;
- mechanised and proved property.

"Formally expressed" does not mean "proved".

## Statements

A main theorem must not be modified by an agent without explicit agreement.

A missing proof must lead to a proof problem or a proposed reformulation, not to an opportunistic rewriting of the text.

## Verso

Respect the existing structure, labels, seals (the status markers of statements), bibliographies and the extensions in `tools/SpecExt`.

After a relevant change:

```
lake build Spec
lake exe spec --output _out/spec --with-tex
python3 scripts/controle.py
```

If tracking is affected, also run `python3 scripts/suivi.py all`.

## Research

Every new external claim must be sourced. Agents must not turn a design hypothesis into a fact from the literature without a source.
