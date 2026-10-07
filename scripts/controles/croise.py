# SPDX-FileCopyrightText: 2026 Cyprien PIERRE
#
# SPDX-License-Identifier: CECILL-2.1

"""Cross-check: the grammar of terms must cover the typing rules, and the lists must agree.

Three objects should coincide: the grammar of terms (annex E), the set of typing rules, and the
list of primitives (`docs/tracking/primitives.md`). This compares them and prints the counts.
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
    "Slice":   (r"mathsf\{slice\}",                          "calcul"),
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


def _frac_conclusions(text: str):
    """(rule name, conclusion) for every `\\textsc{R}\\;\\frac{premises}{conclusion}` in `text`."""
    out = []
    for m in re.finditer(r"\\textsc\{([A-Za-z]+)\}(?:\^\{[^}]*\})?\s*\\;?\s*\\frac\{", text):
        i = m.end()
        depth = 1
        while i < len(text) and depth:  # skip the premises
            depth += {"{": 1, "}": -1}.get(text[i], 0)
            i += 1
        j = text.find("{", i)
        if j < 0:
            continue
        k, depth = j + 1, 1
        while k < len(text) and depth:
            depth += {"{": 1, "}": -1}.get(text[k], 0)
            k += 1
        out.append((m.group(1), text[j + 1 : k - 1]))
    return out


# Type formers a rule can conclude, and the pattern that finds each in the grammar of types.
TYPE_FORMERS = [
    (r"F_", r"F_\{?\\varepsilon|F_"),
    (r"U_", r"U_"),
    (r"!_", r"!_"),
    (r"\\otimes", r"\\otimes"),
    (r"\\bigoplus", r"\\bigoplus"),
    (r"\\multimap", r"\\multimap"),
    (r"\\forall", r"\\forall"),
    (r"\\exists", r"\\exists"),
    (r"\\nu\\alpha|\\nu ", r"\\nu"),
    (r"\\mu\\alpha|\\mu ", r"\\mu"),
    (r"\\mathsf\{Vec\}", r"\\mathsf\{Vec\}"),
    (r"\\mathsf\{Arena\}", r"\\mathsf\{Arena\}"),
    (r"\{\\bigcirc\}|\\bigcirc", r"\\bigcirc"),
]


def degenerate_productions(types: str):
    """Productions of the grammars that are empty or merely the non-terminal itself (`S ::= S`)."""
    bad = []
    for m in re.finditer(r"([A-Z])\s*&::=\s*(.*?)(?:\\\\|\\end)", types, re.S):
        name, rhs = m.group(1), m.group(2)
        for alt in [a.strip() for a in re.split(r"\\mid", rhs)]:
            if alt == "" or alt == name:
                bad.append("%s ::= %s" % (name, alt or "(vide)"))
    return bad


def ungenerated_types(rules_text: str, types: str):
    """Rules whose conclusion mentions a type former the grammar of types does not generate."""
    bad = []
    for name, concl in _frac_conclusions(rules_text):
        after = concl.split(":", 1)[1] if ":" in concl else ""
        for in_rule, in_grammar in TYPE_FORMERS:
            if re.search(in_rule, after) and not re.search(in_grammar, types):
                bad.append((name, in_rule))
    return bad


def selftest():
    """The two new checks must fail on a mutated grammar before they are trusted."""
    ok_bad = degenerate_productions(r"S &::= S \mid \mathbf{End}\\ C &::= \\") 
    ung = ungenerated_types(r"\textsc{R}\;\frac{\;a\;}{\;\Delta \vdash t : \mathsf{Vec}\,n\,V\;}", r"V ::= \mathbf{1}")
    if ok_bad and ung:
        ok("auto-test : productions vides et types non engendrés sont détectés")
    else:
        ko("auto-test du croisement : productions %s, types %s" % (ok_bad, ung))


def run():
    print("\n[Croisement grammaire / règles]")
    selftest()
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

    primitives = (corpus.SPEC.parent / "docs" / "tracking" / "primitives.md")
    if primitives.exists():
        listed = set()
        for line in re.findall(r"REGLE:\s*([^|\n]+)", primitives.read_text(encoding="utf-8")):
            listed.update(x.strip().lower() for x in re.split(r"[,;/ ]+", line.strip()) if x.strip())
        missing = sorted(r for r in rules & set(EXPECTED) if r.lower() not in listed)
        if missing:
            good = False
            ko("règles écrites sans entrée à la liste des primitives (docs/tracking/primitives.md) : %s" % missing)
    else:
        ko("docs/tracking/primitives.md introuvable — croisement à trois non conduit")

    types = corpus.formula("eq:grammaire-types")
    if types:
        orphans = [n for pattern, n, names in TYPE_CONNECTIVES if re.search(pattern, types) and not (set(names) & rules)]
        if orphans:
            good = False
            ko("connecteurs de type qu'aucune règle de terme n'habite : %s" % orphans)

    if types:
        degenerate = degenerate_productions(types) + degenerate_productions(grammar)
        if degenerate:
            good = False
            ko("productions vides ou auto-référentes : %s" % degenerate)
        ungenerated = ungenerated_types(corpus.chapter("C3"), types)
        if ungenerated:
            good = False
            ko("règles concluant un type non engendré par la grammaire : %s" % ungenerated)

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
    stated_rules = re.search(r"(\w[\w-]*) règles de typage", corpus.chapter("C3"))
    stated_ctors = re.search(r"(\w[\w-]*) constructeurs", corpus.chapter("C3"))
    NUMBERS = {"quarante-neuf": 49, "quarante-cinq": 45, "cinquante": 50, "quarante-six": 46}
    for label, found, real in (("règles de typage", stated_rules, len(rules)), ("constructeurs", stated_ctors, len(governed))):
        if found and found.group(1) in NUMBERS and NUMBERS[found.group(1)] != real:
            ko("le texte annonce %s %s, le croisement en compte %d" % (found.group(1), label, real))
