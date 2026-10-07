#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Mesure la prose du manuscrit contre les cibles de livrables/CHARTE-REDACTION.md.

    python3 outils/mesure.py            # tout le manuscrit
    python3 outils/mesure.py c2         # un fichier

Ce que le script NE fait pas : juger. Il compte des longueurs et des formules,
et compare aux cibles. Le jugement reste à la lecture ; ce qui est compté ici
est ce qu'on peut vérifier sans lire.

Les mathématiques, le code, les citations, les remarques et les notes sont
neutralisés avant le comptage : on mesure la prose, pas ce qu'elle porte.
"""

import re
import sys
import pathlib
import statistics
import collections

BASE = pathlib.Path(__file__).resolve().parent.parent / "src"

ORDRE = ["chapitres/c1-prolegomenes", "chapitres/c2-fondements",
         "chapitres/c3-types", "chapitres/c4-automates",
         "chapitres/c5-syntaxe", "chapitres/c6-compilation",
         "chapitres/c7-integration", "K7_Errors", "K7_LSP_REPL",
         "K7_Sushi", "K7_Sugoi", "K7_Semantique"]

# Cibles de la charte. Les dépasser n'est pas une faute, c'est un signal.
CIBLES = {
    "phrase_mediane": 25,
    "phrase_d9": 35,
    "phrase_max": 60,
    "part_plus_de_40": 0.10,
    "para_max": 200,
    "para_d9": 140,
}

# Familles de métadiscours relevées dans la charte, avec leur poids de départ.
TICS = {
    "annonce (il vaut mieux / de / d')": r"il vaut (mieux|de|d')",
    "annonce (mérite d'être)": r"mérite d'être",
    "insistance (et c'est …)": r"et c'est (voulu|délibéré|le|la|ce|précisément|exactement)",
    "auto-désignation (ce document)": r"\bce document\b",
    "auto-désignation (ce chapitre)": r"\bce chapitre\b",
    "intensif (exactement)": r"\bexactement\b",
    "intensif (précisément)": r"\bprécisément\b",
    "annonce numérotée": r"\b(deux|trois|quatre|cinq) (choses|points|raisons|précisions|réserves|conséquences|remarques|clauses|conditions)\b",
    "négation-correction (n'est pas X mais)": r"n'est pas [^,.;]{3,40} mais ",
}


def prose(chemin):
    """Rend (paragraphes, phrases) après neutralisation de ce qui n'est pas prose."""
    paras, phrases = [], []
    dans = False
    for ligne in chemin.read_text(encoding="utf-8").split("\n"):
        s = ligne.strip()
        bas = s.lower()
        if bas.startswith("#+begin_"):
            dans = True
            continue
        if bas.startswith("#+end_"):
            dans = False
            continue
        if dans or not s or s[0] in "#*|":
            continue
        # Les postulats et les définitions du manuscrit sont des items de liste
        # (« - <<<P2>>> :: … ») et portent de la prose : on les mesure aussi,
        # après avoir retiré la puce et l'étiquette.
        s = re.sub(r"^-\s*(<<<\w+>>>)?\s*(::)?\s*", "", s)
        p = re.sub(r"\\\(.*?\\\)|\\\[.*?\\\]|\$[^$]*\$|~[^~]+~|\[cite[^\]]*\]"
                   r"|\[rmq:[^\]]*\]|\[fn::[^\]]*\]|\\ref\{[^}]*\}|§", " ", s)
        p = re.sub(r"\s+", " ", p).strip()
        if len(p.split()) < 8:
            continue
        paras.append(p)
        for ph in re.split(r"(?<=[.!?])\s+(?=[A-ZÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ«/])", p):
            if len(ph.split()) >= 4:
                phrases.append(ph)
    return paras, phrases


def verdict(valeur, cible, sens="<="):
    ok = valeur <= cible if sens == "<=" else valeur >= cible
    return "   ok  " if ok else "  ÉCART"


def rapport(fichiers):
    tous_paras, toutes_phrases = [], []
    print("=" * 74)
    print("MESURE DE LA PROSE — cibles de livrables/CHARTE-REDACTION.md")
    print("=" * 74)
    print("\n%-24s %6s %6s %6s %6s %6s" %
          ("fichier", "phr.", "méd.", "d9", ">40", ">60"))
    for nom in fichiers:
        f = BASE / (nom + ".org")
        if not f.exists():
            continue
        paras, phrases = prose(f)
        if not phrases:
            continue
        lg = sorted(len(p.split()) for p in phrases)
        tous_paras += paras
        toutes_phrases += phrases
        print("%-24s %6d %6d %6d %6d %6d" % (
            f.stem[:24], len(lg), statistics.median(lg), lg[int(.9 * len(lg))],
            sum(1 for n in lg if n > 40), sum(1 for n in lg if n > 60)))

    lg = sorted(len(p.split()) for p in toutes_phrases)
    mp = sorted(len(p.split()) for p in tous_paras)
    print("\n%-38s %8s %8s" % ("", "mesuré", "cible"))
    lignes = [
        ("mots par phrase, médiane", statistics.median(lg), CIBLES["phrase_mediane"]),
        ("mots par phrase, 9e décile", lg[int(.9 * len(lg))], CIBLES["phrase_d9"]),
        ("phrase la plus longue", lg[-1], CIBLES["phrase_max"]),
        ("phrases de plus de 60 mots", sum(1 for n in lg if n > 60), 0),
        ("mots par paragraphe, 9e décile", mp[int(.9 * len(mp))], CIBLES["para_d9"]),
        ("paragraphe le plus long", mp[-1], CIBLES["para_max"]),
    ]
    for nom, v, c in lignes:
        print("%-38s %8s %8s %s" % (nom, v, c, verdict(v, c)))
    part = sum(1 for n in lg if n > 40) / len(lg)
    print("%-38s %7.0f%% %7.0f%% %s" % ("phrases de plus de 40 mots",
                                        100 * part, 100 * CIBLES["part_plus_de_40"],
                                        verdict(part, CIBLES["part_plus_de_40"])))

    texte = " ".join(tous_paras)
    print("\nMÉTADISCOURS")
    for nom, motif in TICS.items():
        print("  %-38s %5d" % (nom, len(re.findall(motif, texte, re.I))))

    print("\nFORMULES RÉPÉTÉES (5 mots, 4 fois ou plus)")
    mots = re.findall(r"[\wàâäéèêëîïôöùûüç'’-]+", texte.lower())
    g = collections.Counter(tuple(mots[i:i + 5]) for i in range(len(mots) - 5))
    n = 0
    for k, v in g.most_common(60):
        if v >= 4:
            print("  %3d×  %s" % (v, " ".join(k)))
            n += 1
    if not n:
        print("  aucune")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        motif = sys.argv[1]
        choix = [n for n in ORDRE if motif in n]
    else:
        choix = ORDRE
    rapport(choix)
