# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Algebra checks: the document DECLARES its algebra, the tool COMPUTES it.

Born of the PR-02 campaign: a law stated "for every grade r" was promoted to chapter 2 without
checking its absorbing element, and it is false at ω. These checks compute both sides on a sample
that includes 0 and ω.
"""

from __future__ import annotations

import itertools
import re

from . import corpus
from .journal import ko, ok

OMEGA = float("inf")
SAMPLE = [0, 1, 2, 3, 5, OMEGA]


def plus(a, b):
    return OMEGA if OMEGA in (a, b) else a + b


def times(a, b):
    if a == 0 or b == 0:
        return 0  # 0 absorbs, including 0·ω = 0
    return OMEGA if OMEGA in (a, b) else a * b


def minus_residue(beta, k):
    """⊖ as the RESIDUE of the addition: the least x with k + x ≥ β (so ω ⊖ ω = 0)."""
    if k >= beta:
        return 0
    return OMEGA if beta == OMEGA else beta - k


def minus_truncated(beta, k):
    """⊖ as the truncated subtraction EXTENDED at ω (ω ⊖ k = ω)."""
    if beta == OMEGA:
        return OMEGA
    return 0 if k >= beta else beta - k


def counterexamples(minus, restricted=False):
    """Triples where u·(β ⊖ k) = (u·β) ⊖ (u·k) fails."""
    bad = []
    for u, beta, k in itertools.product(SAMPLE, repeat=3):
        if restricted and u == OMEGA and k != 0:
            continue
        left = times(u, minus(beta, k))
        right = minus(times(u, beta), times(u, k))
        if left != right:
            bad.append((u, beta, k, left, right))
    return bad


def fmt(x):
    return "ω" if x == OMEGA else "%g" % x


def action_law_at_the_bounds():
    """Does the compatibility of the graded action hold at 0 and ω?"""
    text = corpus.flat(corpus.chapter("C2"))
    residue = bool(re.search(r"/r[ée]sidu/ de l'addition", text)) and not re.search(r"n'est pas le /?r[ée]sidu", text)
    truncated = bool(re.search(r"soustraction tronqu[ée]e\s+/?prolong", text))
    if truncated:
        minus, name = minus_truncated, "soustraction tronquée prolongée"
    elif residue:
        minus, name = minus_residue, "résidu de l'addition"
    else:
        ko("la définition de ⊖ n'est pas identifiable au chapitre 2")
        return
    restricted = bool(re.search(r"usage fini|composante d'usage[^.]{0,40}est /finie/|u\s*\\neq\s*\\omega|u\s*<\s*\\omega", text))
    bad = counterexamples(minus, restricted)
    if bad:
        u, beta, k, left, right = bad[0]
        ko("loi d'action FAUSSE sous « %s »%s — %d couple(s) ; ex. u=%s β=%s k=%s : gauche %s, droit %s"
           % (name, " (restreinte)" if restricted else "", len(bad), fmt(u), fmt(beta), fmt(k), fmt(left), fmt(right)))
    elif not restricted:
        ko("loi d'action énoncée sans restriction — aucune définition de ⊖ ne la rend vraie en u = ω")
    else:
        ok("loi d'action : restreinte et vérifiée aux bornes sous « %s »" % name)


def action_through_parallel():
    """Does the action traverse ∥ on both components (work adds, depth takes the maximum)?"""
    if "thm:action_parallele" not in corpus.everything():
        ok("action graduée : aucune composition parallèle déclarée")
        return
    work = [t for t in itertools.product(SAMPLE, repeat=3) if times(t[0], plus(t[1], t[2])) != plus(times(t[0], t[1]), times(t[0], t[2]))]
    depth = [t for t in itertools.product(SAMPLE, repeat=3) if times(t[0], max(t[1], t[2])) != max(times(t[0], t[1]), times(t[0], t[2]))]
    if work or depth:
        t = (work or depth)[0]
        ko("l'action ne traverse pas ∥ — travail : %d, profondeur : %d ; ex. u=%s a=%s b=%s" % (len(work), len(depth), *map(fmt, t)))
    else:
        ok("action graduée : traverse ∥ sur les deux composantes (%d triplets)" % len(SAMPLE) ** 3)


def conventions_of_infinity():
    """Are the four equalities that govern ω written down (0·ω, ω·0, ω+ω, ω·ω)?"""
    text = corpus.flat(corpus.chapter("C2") + corpus.chapter("AnnexeE"))
    expected = [
        (r"0\s*\\cdot\s*\\omega|0\s*\\times\s*\\omega", "0 · ω"),
        (r"\\omega\s*\\cdot\s*0|\\omega\s*\\times\s*0", "ω · 0"),
        (r"\\omega\s*\+\s*\\omega", "ω + ω"),
        (r"\\omega\s*\\cdot\s*\\omega|\\omega\s*\\times\s*\\omega", "ω · ω"),
    ]
    missing = [name for pattern, name in expected if not re.search(pattern, text)]
    if missing:
        ko("égalité(s) de ℕ∞ jamais écrite(s) : %s" % missing)
    else:
        ok("conventions de ℕ∞ : les quatre égalités de ω sont écrites")


def size_sorts_inhabited():
    """Do the well-formedness clauses leave the connectives they govern inhabited?"""
    text = corpus.flat(corpus.chapter("C2") + corpus.chapter("AnnexeE"))
    defs = {k: re.findall(r"\\mathbb\{S\}_\\%s\s*\\;?\s*=\s*([^$`]{0,80})" % k, text) for k in ("mu", "nu")}
    if not (defs["mu"] and defs["nu"]):
        ko("les deux sortes de tailles ne sont pas toutes deux définies : 𝕊_μ %s, 𝕊_ν %s"
           % ("oui" if defs["mu"] else "NON", "oui" if defs["nu"] else "NON"))
    elif not any("setminus" in d for d in defs["mu"]):
        ko("𝕊_μ n'exclut pas ω — un pli de taille ω ne terminerait pas")
    elif any("setminus" in d for d in defs["nu"]):
        ko("𝕊_ν exclut ω — aucun flux non terminé ne serait typable")
    else:
        ok("sortes de tailles : 𝕊_μ sans ω, 𝕊_ν avec ω, disjointes")


def selftest():
    """A check that has never been seen failing is worth nothing: both wrong definitions of ⊖ must fail."""
    residue = len(counterexamples(minus_residue))
    truncated = len(counterexamples(minus_truncated))
    if residue == 10 and truncated == 14 and not counterexamples(minus_truncated, restricted=True):
        ok("auto-test : sans restriction, ⊖ résidu a 10 contre-exemples et ⊖ prolongée 14 ; restreinte, 0")
    else:
        ko("auto-test de la loi d'action : %d / %d contre-exemples (attendu 10 / 14)" % (residue, truncated))


def run():
    print("\n[Algèbre]")
    selftest()
    for check in (action_law_at_the_bounds, action_through_parallel, conventions_of_infinity, size_sorts_inhabited):
        check()
