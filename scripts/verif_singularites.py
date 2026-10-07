# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Exhaustive check of the singularity algebra of the specification (chapter 3, section 3.2).

    verif_singularites.py

Model: the wheel of fractions of the finite field GF(p), p in {2, 3, 5} (pairs (a, b) modulo
non-zero scalars; sum (ad + bc, bd), product (ac, bd), inverse (b, a)).  Three algebras are
checked against the wheel axioms *as recalled* (they were not read in Carlstrom's article):

* ``wheel``: the wheel of fractions itself (expected: every axiom holds);
* ``sup``: the extension with two absorbing error classes whose join of distinct classes is the
  bottom class (the rule written before 7 October 2026; expected: associativity fails);
* ``flags``: the extension in which an error class is a non-empty set of flags among
  {circ, delta}, combined by union, the value of the wheel part being forgotten (the rule now
  written; expected: every axiom holds except ``0/0 + x = 0/0`` on flagged elements).

The script exits with status 1 if an outcome differs from its expectation.
"""

from __future__ import annotations

import sys
from collections.abc import Callable

Elt = tuple  # ('f', v) finite, ('inf',), ('bot',), ('E', frozenset) flagged


def model(p: int, kind: str):
    """Returns the elements and the operations of the algebra `kind` over GF(p)."""

    def norm(a: int, b: int) -> Elt:
        a, b = a % p, b % p
        if a == 0 and b == 0:
            return ("bot",)
        if b == 0:
            return ("inf",)
        return ("f", a * pow(b, -1, p) % p)

    def pair(x: Elt) -> tuple[int, int]:
        return {"bot": (0, 0), "inf": (1, 0)}.get(x[0], (x[1] if x[0] == "f" else 0, 1))

    elts: list[Elt] = [("bot",), ("inf",)] + [("f", v) for v in range(p)]
    if kind == "sup":
        elts += [("C",), ("D",)]
    elif kind == "flags":
        elts += [("E", frozenset(s)) for s in ("C", "D", "CD")]

    def combine(x: Elt, y: Elt) -> Elt | None:
        """Result of an operation when an operand is an error class, else None."""
        if kind == "sup":
            errs = {z[0] for z in (x, y) if z[0] in ("bot", "C", "D")}
            if not errs:
                return None
            return (errs.pop(),) if len(errs) == 1 else ("bot",)
        if kind == "flags":
            flags = frozenset().union(*[z[1] for z in (x, y) if z[0] == "E"])
            if flags:
                return ("E", flags)
            return ("bot",) if "bot" in (x[0], y[0]) else None
        return ("bot",) if "bot" in (x[0], y[0]) else None

    def add(x: Elt, y: Elt) -> Elt:
        r = combine(x, y)
        if r:
            return r
        (a, b), (c, d) = pair(x), pair(y)
        return norm(a * d + b * c, b * d)

    def mul(x: Elt, y: Elt) -> Elt:
        r = combine(x, y)
        if r:
            return r
        (a, b), (c, d) = pair(x), pair(y)
        return norm(a * c, b * d)

    def inv(x: Elt) -> Elt:
        if x[0] in ("C", "D", "E"):
            return x
        a, b = pair(x)
        return norm(b, a)

    return elts, add, mul, inv


def failures(p: int, kind: str) -> set[str]:
    """Names of the recalled wheel axioms (and monoid laws) that fail in the algebra."""
    elts, add, mul, inv = model(p, kind)
    zero, one = ("f", 0), ("f", 1)
    bad: set[str] = set()

    def chk(name: str, ok: bool) -> None:
        if not ok:
            bad.add(name)

    bot = mul(zero, inv(zero))
    chk("0*0=0", mul(zero, zero) == zero)
    for x in elts:
        chk("//x=x", inv(inv(x)) == x)
        chk("0/0+x=0/0", add(bot, x) == bot)
        chk("unit+", add(x, zero) == x)
        chk("unit*", mul(x, one) == x)
        for y in elts:
            chk("comm+", add(x, y) == add(y, x))
            chk("comm*", mul(x, y) == mul(y, x))
            chk("/(xy)=/x/y", inv(mul(x, y)) == mul(inv(x), inv(y)))
            chk("/(x+0y)=/x+0y", inv(add(x, mul(zero, y))) == add(inv(x), mul(zero, y)))
            for z in elts:
                chk("assoc+", add(add(x, y), z) == add(x, add(y, z)))
                chk("assoc*", mul(mul(x, y), z) == mul(x, mul(y, z)))
                chk("xz+yz=(x+y)z+0z", add(mul(x, z), mul(y, z)) == add(mul(add(x, y), z), mul(zero, z)))
                chk("(x+yz)/y=x/y+z+0y", mul(add(x, mul(y, z)), inv(y)) == add(add(mul(x, inv(y)), z), mul(zero, y)))
                chk("(x+0y)z=xz+0y", mul(add(x, mul(zero, y)), z) == add(mul(x, z), mul(zero, y)))
    return bad


EXPECTED: dict[str, Callable[[set[str]], bool]] = {
    "wheel": lambda bad: not bad,
    "sup": lambda bad: "assoc+" in bad and "assoc*" in bad,
    "flags": lambda bad: bad == {"0/0+x=0/0"},
}


def main() -> int:
    status = 0
    for kind, expected in EXPECTED.items():
        for p in (2, 3, 5):
            bad = failures(p, kind)
            ok = expected(bad)
            status |= not ok
            print(f"{'ok  ' if ok else 'FAIL'} {kind:6} GF({p}) : axiomes en défaut = {sorted(bad) or 'aucun'}")
    # the counterexample to associativity quoted in the specification
    elts, add, _, _ = model(3, "sup")
    inf, circ = ("inf",), ("C",)
    print("contre-exemple : (inf+inf)+circ =", add(add(inf, inf), circ), "; inf+(inf+circ) =", add(inf, add(inf, circ)))
    return status


if __name__ == "__main__":
    sys.exit(main())
