# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Structure checks: references, labels, tables, appendix letters, author comments."""

from __future__ import annotations

import re

from . import corpus
from .journal import ko, ok

PREFIX = {"::::figure": "fig:", "::::k7table": "tab:", "::::listing": "lst:", "::::formula": "eq:", "::::thm": "thm:"}


def labels_defined():
    labels = []
    for name, _, text in corpus.modules():
        labels += [(name, l) for l in re.findall(r'\{label "([^"]+)"', text)]
        labels += [(name, l) for l in re.findall(r'^::::\w+[^\n]*\(label := "([^"]+)"', text, re.M)]
    return labels


def references_resolve():
    defined = {l for _, l in labels_defined()}
    seen = [l for l in (m for _, _, t in corpus.modules() for m in re.findall(r'\{num "([^"]+)"\}', t))]
    missing_marks = [n for n, _, t in corpus.modules() if "{missing " in t]
    unresolved = sorted({l for l in seen if l not in defined})
    if unresolved:
        ko("renvois vers une étiquette inconnue : %s" % unresolved[:5])
    elif missing_marks:
        ko("renvois non résolus (`{missing}`) dans : %s" % missing_marks[:5])
    else:
        ok("renvois : %d, tous résolus" % len(seen))


def labels_unique_and_prefixed():
    labels = labels_defined()
    names = [l for _, l in labels]
    dups = sorted({l for l in names if names.count(l) > 1})
    bad = []
    for name, _, text in corpus.modules():
        for directive, prefix in PREFIX.items():
            for m in re.finditer(r"^" + re.escape(directive) + r'[^\n]*\(label := "([^"]+)"', text, re.M):
                if not m.group(1).startswith(prefix):
                    bad.append(f"{m.group(1)} ({directive[4:]}) dans {name}")
    if dups:
        ko("étiquettes en double : %s" % dups[:5])
    elif bad:
        ko("étiquette au mauvais préfixe : %s" % bad[:5])
    else:
        ok("étiquettes : %d, uniques et bien préfixées" % len(names))


def appendix_letters():
    """Appendix letters are never written by hand: they follow the numbering, through `{num}`."""
    bad = []
    for name, _, text in corpus.modules():
        body = re.sub(r"^:::comment\n.*?\n:::$", "", text, flags=re.S | re.M)
        for m in re.finditer(r"[Aa]nnexes? ([A-H])\b(?!\.)", body):
            bad.append(f"{name} : « {m.group(0)} »")
    if bad:
        ko("lettre d'annexe écrite en dur (utiliser {num \"sec:…\"}[]) : %s" % bad[:5])
    else:
        ok("annexes : aucune lettre écrite en dur")


def tables_regular():
    bad = []
    for name, _, text in corpus.modules():
        for m in re.finditer(r"^:::table[^\n]*\n(.*?)\n:::$", text, re.S | re.M):
            rows = re.split(r"\n(?=\* )", m.group(1))
            widths = {len(re.findall(r"^\s*\* ", r, re.M)) - 1 for r in rows}
            if len(widths) > 1:
                bad.append(name)
    if bad:
        ko("tableau irrégulier dans : %s" % sorted(set(bad))[:4])
    else:
        ok("tableaux : colonnes régulières")


def no_author_comments():
    """Author comments are follow-up items: they belong in docs/suivi, not in the text."""
    found = [(n, c) for n, _, t in corpus.modules() for c in re.findall(r"^:::comment", t, re.M)]
    if found:
        ko("%d commentaire(s) d'auteur dans le texte (à verser au suivi) : %s" % (len(found), sorted({n for n, _ in found})[:5]))
    else:
        ok("aucun commentaire d'auteur enfoui dans le texte")


def glossary_covers_layers():
    text = corpus.raw("Refs.ListeDesGlosses")
    missing = [t for t in ("couche 1", "couche 2", "couche 3") if f": {t}" not in text]
    if missing:
        ko("glossaire : termes centraux absents : %s" % missing)
    else:
        ok("glossaire : les trois couches y figurent")


def run():
    print("\n[Structure]")
    for check in (references_resolve, labels_unique_and_prefixed, appendix_letters, tables_regular, no_author_comments, glossary_covers_layers):
        check()
