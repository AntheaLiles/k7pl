# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""The propagation tables of the singularities (section 3.2) against the wheel of fractions.

The two tables of the specification (`tab:propagation-addition`, `tab:propagation-produit`) are
recomputed on the wheel of fractions of GF(5) (classes `0`, `x`, `inf`, `bot`), and the algebra of
the error classes is checked exhaustively (`scripts/verif_singularites.py`).  Neither reads the
article of Carlstrom: the construction and the axioms are the ones recalled in the specification.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

from . import corpus
from .journal import ko, ok

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import verif_singularites as vs  # noqa: E402

CLASSES = ("0", "x", "inf", "bot")
HEADS = {"0": "0", "x": "x", "\\infty": "inf", "\\bot": "bot"}


def klass(e) -> str:
    return {"bot": "bot", "inf": "inf"}.get(e[0]) or ("0" if e[1] == 0 else "x")


def computed(op: str) -> dict[tuple[str, str], set[str]]:
    """Classes reached by `op` ('add' or 'mul') on the wheel of fractions of GF(5)."""
    elts, add, mul, _ = vs.model(5, "wheel")
    f = add if op == "add" else mul
    out: dict[tuple[str, str], set[str]] = {}
    for a in elts:
        for b in elts:
            out.setdefault((klass(a), klass(b)), set()).add(klass(f(a, b)))
    return out


def cell(text: str) -> str:
    """Normalises a table cell (`$`\\infty``, `fini`, …) to a class name or `fini`."""
    t = text.strip()
    t = re.sub(r"^\$`(.*)`$", r"\1", t)
    return "fini" if t == "fini" else HEADS.get(t, t)


def table(label: str, text: str) -> dict[tuple[str, str], str] | None:
    m = re.search(r'::::k7table \(label := "' + re.escape(label) + r'"\).*?:::table \+header\n(.*?)\n:::\n::::', text, re.S)
    if not m:
        return None
    rows = re.split(r"\n(?=\* \* )", m.group(1))
    grid = [[c.strip() for c in re.split(r"\n\s*\* ", re.sub(r"^\* \* ", "", r))] for r in rows]
    cols = [cell(re.sub(r"^\$`b = (.*)`$", r"$`\1`", c)) for c in grid[0][1:]]
    out = {}
    for row in grid[1:]:
        head = cell(re.sub(r"^\$`a = (.*)`$", r"$`\1`", row[0]))
        for col, val in zip(cols, row[1:]):
            out[(head, col)] = cell(val)
    return out


def mismatches(label: str, op: str, text: str) -> list[str]:
    t = table(label, text)
    if t is None:
        return [f"{label} : table introuvable"]
    want = computed(op)
    bad = []
    if set(t) != set(want):
        bad.append(f"{label} : cases lues {sorted(t)} au lieu de {sorted(want)}")
        return bad
    for key, got in t.items():
        exp = want[key]
        if got == "fini":
            good = key == ("x", "x") and exp <= {"0", "x"}
        else:
            good = exp == {got}
        if not good:
            bad.append(f"{label} {key} : texte {got!r}, roue des fractions {sorted(exp)}")
    return bad


def selftest() -> bool:
    """A table with one wrong cell must be refused."""
    text = corpus.raw("C3.LesContraintesDeValeur")
    broken = text.replace("  * $`\\infty`\n  * $`\\bot`\n  * $`\\bot`\n* * $`a = \\bot`", "  * $`\\infty`\n  * $`\\infty`\n  * $`\\bot`\n* * $`a = \\bot`", 1)
    return broken != text and bool(mismatches("tab:propagation-addition", "add", broken))


def run() -> None:
    print("\n[Singularités]")
    text = corpus.raw("C3.LesContraintesDeValeur")
    for label, op in (("tab:propagation-addition", "add"), ("tab:propagation-produit", "mul")):
        bad = mismatches(label, op, text)
        if bad:
            ko("table de propagation en désaccord avec la roue des fractions : %s" % bad[:3])
        else:
            ok(f"{label} : les seize cases sont celles de la roue des fractions de GF(5)")
    if selftest():
        ok("auto-test : une case fausse est refusée")
    else:
        ko("auto-test : une table au contenu faux n'a pas été refusée")
    for kind, expected in vs.EXPECTED.items():
        for p in (2, 3, 5):
            bad = vs.failures(p, kind)
            if not expected(bad):
                ko(f"algèbre des singularités « {kind} », GF({p}) : axiomes en défaut {sorted(bad)} (résultat inattendu)")
                return
    ok("algèbre des singularités : roue sans défaut ; erreurs par réunion, seul l'axiome 0/0 + x = 0/0 en défaut ; borne supérieure non associative")
