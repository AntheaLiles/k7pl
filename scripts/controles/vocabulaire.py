# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Vocabulary check (`T-68`): the block proposal covers every primitive and has no collision.

`docs/recherche/t68-vocabulaire-en-bloc.md` is the consolidated proposal of the words of the
primitives. It is a proposal (nothing is renamed in the manuscript until the author ratifies it), but
it must stay complete and coherent while it waits : every constructor rule of the manuscript has a
line, no line names a rule that does not exist, no two lines share a constructor word or a name, and
no word is one of the reserved words of the language.
"""

from __future__ import annotations

import re

from . import corpus, croise
from .journal import ko, ok

PROPOSAL = corpus.SPEC.parent / "docs" / "recherche" / "t68-vocabulaire-en-bloc.md"
#: constructor rules without a name in the rule set (the deductive fixed point, `eq:regle-fix`)
UNNAMED = {"Fix"}
#: the words the language reserves (head keywords of proofs, surface words of the effects, text matching)
RESERVED = {
    "pure", "terminates", "event", "contract", "logic", "perform", "handle", "handler", "match", "cond",
    "select", "comptime", "binds", "bind-to", "var", "end",
}


def table_rows(text: str) -> list[list[str]]:
    """The rows of the main table (section 4), cells stripped."""
    start = text.index("## 4. La table")
    end = text.index("## 5. Complétude")
    rows = []
    for line in text[start:end].splitlines():
        if line.startswith("| `") and len(re.split(r"(?<!\\)\|", line.strip().strip("|"))) >= 8:
            cells = [c.strip() for c in re.split(r"(?<!\\)\|", line.strip().strip("|"))]
            rows.append(cells)
    return rows


def word_of(constructor: str) -> str | None:
    """The word of a constructor written in the table (`inject_i`, `declassify_ℓ`), None for a symbol."""
    m = re.match(r"`?([a-z]+)(?:_[^`]*)?`?(?: \*\*→\*\*)?$", constructor.strip())
    return m.group(1) if m else None


def run() -> None:
    print("\n[Vocabulaire T-68]")
    if not PROPOSAL.exists():
        ko("docs/recherche/t68-vocabulaire-en-bloc.md introuvable")
        return
    rows = table_rows(PROPOSAL.read_text(encoding="utf-8"))
    declared: set[str] = set()
    words: dict[str, str] = {}
    names: dict[str, str] = {}
    problems: list[str] = []
    for cells in rows:
        rules = {r for r in re.findall(r"`([^`]+)`", cells[0])}
        declared |= rules
        k, n = cells[3], cells[4]
        key = ", ".join(sorted(rules))
        w = word_of(k)
        if w:
            if w in words and words[w] != key:
                problems.append("mot K `%s` pour %s et %s" % (w, words[w], key))
            words[w] = key
            if w in RESERVED:
                problems.append("mot K `%s` réservé" % w)
        if n in names and names[n] != key:
            problems.append("nom N « %s » pour %s et %s" % (n, names[n], key))
        names[n] = key
        if n in RESERVED:
            problems.append("nom N « %s » réservé" % n)
    expected = set(croise.EXPECTED) | UNNAMED
    missing = sorted(expected - declared)
    unknown = sorted(declared - expected)
    if missing:
        problems.append("règles sans ligne : %s" % missing)
    if unknown:
        problems.append("lignes sans règle : %s" % unknown)
    if problems:
        for p in problems:
            ko("vocabulaire : " + p)
    else:
        ok("vocabulaire : %d lignes couvrent les %d règles de constructeur, aucun mot ni nom en double ni réservé" % (len(rows), len(expected)))
