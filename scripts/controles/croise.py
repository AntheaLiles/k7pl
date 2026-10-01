# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Cross-check: the grammar of terms must cover the typing rules, and the lists must agree.

Three objects should coincide: the grammar of terms (annex E), the set of typing rules, and the
list of primitives (`docs/suivi/primitives.md`). This compares them and prints the counts.
"""

from __future__ import annotations

import re

from . import corpus
from .journal import ko, ok

# Term constructors the document names, with the rule that governs them: (pattern in the grammar,
# sort). A rule missing from this table and present in the document makes the check fail: a new
# rule must be declared here, with the pattern that finds it in the grammar of terms.
EXPECTED = {
    "Var":     (r"::= x ",                                  "valeur"),
    "One":     (r"\\mid \(\)",                              "valeur"),
    "Pair":    (r"\\mid \(v, v\)",                          "valeur"),
    "Inj":     (r"mathsf\{inj\}",                           "valeur"),
    "Box":     (r"mathsf\{box\}",                           "valeur"),
    "Th":      (r"mathsf\{thunk\}",                         "valeur"),
    "Pack":    (r"mathsf\{pack\}",                          "valeur"),
    "Fold":    (r"mathsf\{fold\}\\;v",                       "valeur"),
    "Ret":     (r"mathsf\{return\}",                        "calcul"),
    "Let":     (r"mathsf\{let\}.{0,3}x .{0,3}leftarrow",      "calcul"),
    "Lam":     (r"lambda x\.",                              "calcul"),
    "App":     (r"mid c.{0,3}v ",                            "calcul"),
    "Fo":      (r"mathsf\{force\}",                         "calcul"),
    "Case":    (r"mathsf\{case\}",                          "calcul"),
    "Unbox":   (r"mathsf\{unbox\}",                         "calcul"),
    "Op":      (r"mathsf\{operation\}",                     "calcul"),
    "OneE":    (r"mathsf\{let\}.{0,3}\(\) *=",                "calcul"),
    "Split":   (r"mathsf\{let\}.{0,3}\(x, ?y\)",              "calcul"),
    "With":    (r"langle c",                                "calcul"),
    "Proj":    (r"c\.i|mathsf\{pr\}",                       "calcul"),
    "Open":    (r"mathsf\{open\}",                          "calcul"),
    "Unfold":  (r"mathsf\{unfold\}",                        "calcul"),
    "Gen":     (r"Lambda.{0,8}alpha\.",                     "calcul"),
    "Inst":    (r"c.{0,3}\[W\]",                             "calcul"),
    "Sc":      (r"mathsf\{scoped\}",                        "calcul"),
    "Del":     (r"mathsf\{delay\}",                         "calcul"),
    "Alw":     (r"mathsf\{always\}",                        "calcul"),
    "Alw^{-}": (r"mathsf\{at\}",                            "calcul"),
    "Now":     (r"mathsf\{now\}",                           "calcul"),
    "Wait":    (r"mathsf\{wait\}",                          "calcul"),
    "When":    (r"mathsf\{when\}",                          "calcul"),
    "VecI":    (r"\[v_0",                                    "valeur"),
    "VecE":    (r"mathsf\{iter\}_\{?V",                      "calcul"),
    "Out":     (r"mathsf\{out\}",                            "calcul"),
    "Cop":     (r"langle\\!\\langle j",                      "calcul"),
    "Par":     (r"mid\\; c \\parallel c",                    "calcul"),
    "Vmap":    (r"mathsf\{vmap\}",                           "calcul"),
    "Spawn":   (r"mathsf\{spawn\}",                          "calcul"),
    "New":     (r"mathsf\{new\}_E",                          "calcul"),
    "Send":    (r"mathsf\{send\}",                           "calcul"),
    "Guard":   (r"mathsf\{guard\}",                          "calcul"),
    "Free":    (r"mathsf\{free\}",                           "calcul"),
    "At":      (r"mathsf\{at\}_n",                           "calcul"),
    "Move":    (r"mathsf\{move\}_\{n",                       "calcul"),
    "Try":     (r"mathsf\{try\}",                            "calcul"),
}
NO_TERM_EXTRA = {"Tick", "Expand"}
NO_TERM = {"Sub", "SubBox"} | NO_TERM_EXTRA

# tick is an INSTANCE of the `operation` scheme, and Expand works in phase 0 on the tree.
NO_TERM_EXTRA = {"Tick", "Expand"}
NO_TERM = {"Sub", "SubBox"} | NO_TERM_EXTRA

TYPE_CONNECTIVES = [
    (r"\\mu\\alpha", "mu", ("Fold", "Unfold")),
    (r"\\nu\\alpha", "nu", ("Nu", "Out", "Cop")),
    (r"\\exists", "existentiel", ("Pack", "Open")),
    (r"\\forall", "universel", ("Gen", "Inst")),
    (r"\\Box_", "modalite graduee", ("Box", "Unbox")),
    (r"\\otimes", "tenseur", ("Pair", "Split")),
    (r"\\bigoplus", "somme", ("Inj", "Case")),
    (r"\\mathop\{&\}", "conjonction additive", ("With", "Proj")),
    (r"\\multimap", "implication", ("Lam", "App")),
    (r"\\mathsf\{Vec\}", "vecteur", ("VecI", "VecE")),
]


def run():
    print("\n[Croisement grammaire / règles]")
    grammar = corpus.formula("eq:grammaire-termes")
    if not grammar:
        ko("la grammaire des termes (eq:grammaire-termes) est introuvable")
        return
    text = corpus.everything()
    rules = {a + (b or "") for a, b in re.findall(r"\\textsc\{([A-Za-z]+)\}(\^\{[^}]*\})?\s*\\;?\s*\\frac", text)}
    good = True

    unknown = sorted(rules - set(EXPECTED) - NO_TERM)
    if unknown:
        good = False
        ko("règles absentes du tableau de croisement (scripts/controles/croise.py) : %s" % unknown)

    primitives = (corpus.SPEC.parent / "docs" / "suivi" / "primitives.md")
    if primitives.exists():
        listed = set()
        for line in re.findall(r"REGLE:\s*([^|\n]+)", primitives.read_text(encoding="utf-8")):
            listed.update(x.strip().lower() for x in re.split(r"[,;/ ]+", line.strip()) if x.strip())
        missing = sorted(r for r in rules & set(EXPECTED) if r.lower() not in listed)
        if missing:
            good = False
            ko("règles écrites sans entrée à la liste des primitives (docs/suivi/primitives.md) : %s" % missing)
    else:
        ko("docs/suivi/primitives.md introuvable — croisement à trois non conduit")

    types = corpus.formula("eq:grammaire-types")
    if types:
        orphans = [n for pattern, n, names in TYPE_CONNECTIVES if re.search(pattern, types) and not (set(names) & rules)]
        if orphans:
            good = False
            ko("connecteurs de type qu'aucune règle de terme n'habite : %s" % orphans)

    absent = [r for r in sorted(rules & set(EXPECTED)) if not re.search(EXPECTED[r][0], grammar)]
    if absent:
        good = False
        ko("constructeurs gouvernés par une règle mais ABSENTS de la grammaire des termes : %s" % absent)

    governed = sorted(rules & set(EXPECTED))
    values = [r for r in governed if EXPECTED[r][1] == "valeur"]
    computations = [r for r in governed if EXPECTED[r][1] == "calcul"]
    if good:
        ok("grammaire et règles coïncident")
    ok("%d règles de typage, dont %d sans constructeur de terme" % (len(rules), len(rules & NO_TERM)))
    ok("%d constructeurs de termes : %d valeurs, %d calculs" % (len(governed), len(values), len(computations)))
    stated_rules = re.search(r"(\w[\w-]*) règles de typage", corpus.chapter("AnnexeE"))
    stated_ctors = re.search(r"(\w[\w-]*) constructeurs", corpus.chapter("AnnexeE"))
    NUMBERS = {"quarante-neuf": 49, "quarante-cinq": 45}
    for label, found, real in (("règles de typage", stated_rules, len(rules)), ("constructeurs", stated_ctors, len(governed))):
        if found and found.group(1) in NUMBERS and NUMBERS[found.group(1)] != real:
            ko("le texte annonce %s %s, le croisement en compte %d" % (found.group(1), label, real))
