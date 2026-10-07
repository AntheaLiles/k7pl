#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Simule les filtres d'export d'Emacs hors d'Emacs, pour les éprouver.

    python3 outils/filtres.py                sur tout le manuscrit
    python3 outils/filtres.py src/x.org      sur un fichier
    python3 outils/filtres.py --essais       sur les cas de figure connus

POURQUOI CE FICHIER EXISTE. Les filtres qui préparent l'export vivent dans
my-export-config.el, en elisp. Il n'y a pas d'Emacs là où je travaille : chaque
fois qu'un filtre est écrit ou modifié, je le transcris en Python pour le
passer sur le manuscrit réel avant de le livrer. Cette transcription a trouvé,
le 8 septembre, une boucle infinie qui aurait figé l'export sur toute pile de
mots-clés ouvrant sur #+BEGIN_ — un défaut qu'aucune relecture n'avait vu.

La méthode était bonne ; elle vivait dans /tmp et disparaissait avec la séance.
Elle est ici.

CE QUE CE FICHIER N'EST PAS. Ce n'est pas une seconde implantation qui ferait
autorité : l'elisp fait foi. C'est un banc d'essai, et sa seule exigence est de
rester fidèle à l'elisp. Quand un filtre change là-bas, il change ici.

Sortie : 0 si les essais passent, 1 si un essai échoue, 2 si une source manque.
"""

import io
import os
import re
import sys
import glob

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# ── my/org-remarques-en-marge ────────────────────────────────────────────────

def regions_de_bloc(t):
    """Rend les régions (début, fin) couvertes par un bloc #+BEGIN_…/#+END_…"""
    regions, debut, prof = [], None, 0
    for m in re.finditer(r"^[ \t]*#\+(BEGIN|END)_[A-Za-z]", t, re.M | re.I):
        fin_ligne = t.find("\n", m.start())
        fin_ligne = len(t) if fin_ligne < 0 else fin_ligne
        if m.group(1).upper() == "BEGIN":
            if prof == 0:
                debut = m.start()
            prof += 1
        else:
            prof = max(0, prof - 1)
            if prof == 0 and debut is not None:
                regions.append((debut, fin_ligne))
                debut = None
    if debut is not None:
        regions.append((debut, len(t)))
    return regions


def fin_de_crochet(t, debut):
    """Rend la position suivant le ] qui referme le crochet ouvert avant DEBUT,
    en comptant les crochets imbriqués. None si le crochet n'est pas refermé."""
    i, prof = debut, 1
    while i < len(t) and prof:
        if t[i] == "[":
            prof += 1
        elif t[i] == "]":
            prof -= 1
        i += 1
    return i if prof == 0 else None


def remarques_en_marge(t):
    """[rmq:texte] → @@latex:\\RMQ{@@texte@@latex:}@@. Rend (texte, compte)."""
    regions = regions_de_bloc(t)
    occurrences = []
    for m in re.finditer(r"\[rmq:", t, re.I):
        if any(a <= m.start() <= b for a, b in regions):
            continue
        f = fin_de_crochet(t, m.end())
        if f is None:
            print("    ATTENTION  [rmq: non refermé en %d" % m.start())
            continue
        occurrences.append((m.start(), m.end(), f))
    for ouv, cont, fer in reversed(occurrences):
        t = t[:fer - 1] + "@@latex:}@@" + t[fer:]
        t = t[:ouv] + "@@latex:\\RMQ{@@" + t[cont:]
    return t, len(occurrences)


# ── my/org-items-flottants ───────────────────────────────────────────────────

RE_ITEM = re.compile(r"^[ \t]*#\+(DESC|NOTE|SOURCE|ALT_TEXT):[ \t]*(.*?)[ \t]*$", re.I)
RE_CAP = re.compile(r"^[ \t]*#\+CAPTION(\[(.*)\])?:[ \t]*(.*?)[ \t]*$", re.I)
RE_ATTR = re.compile(r"^[ \t]*#\+ATTR_LATEX:", re.I)
MACROS = [("DESC", "descfig"), ("NOTE", "notefig"), ("SOURCE", "srcfig")]


def attr_avec_alt(ligne, alt):
    """Ajoute alt={…} à un #+ATTR_LATEX:, dans :options s'il existe déjà."""
    m = re.search(r":options[ \t]+([^\n]*)", ligne, re.I)
    if m:
        return ligne[:m.start()] + ":options %s,alt={%s}" % (m.group(1), alt)
    return ligne + " :options alt={%s}" % alt


def items_flottants(t):
    """Replie #+DESC:, #+NOTE:, #+SOURCE: dans la légende et #+ALT_TEXT: dans
    :options alt={}. Rend (texte, nombre de flottants enrichis)."""
    L = t.split("\n")
    i, sortie, n = 0, [], 0
    while i < len(L):
        if not re.match(r"^[ \t]*#\+", L[i]):
            sortie.append(L[i]); i += 1; continue
        j, items, cap, court = i, {}, None, None
        while (j < len(L) and re.match(r"^[ \t]*#\+", L[j])
               and not re.match(r"^[ \t]*#\+BEGIN_", L[j], re.I)):
            mi, mc = RE_ITEM.match(L[j]), RE_CAP.match(L[j])
            if mi:
                items[mi.group(1).upper()] = mi.group(2)
            elif mc:
                cap, court = mc.group(3), mc.group(2)
            j += 1
        # La pile s'ouvrait sur #+BEGIN_ : avancer, sinon l'export tourne sans fin.
        if j == i:
            sortie.append(L[i]); i += 1; continue
        pile, alt = L[i:j], items.get("ALT_TEXT")
        if alt or (items and cap is not None):
            gardees = [x for x in pile if not RE_ITEM.match(x)]
            suffixe = "".join(
                "@@latex:\\%s{@@%s@@latex:}@@" % (mac, items[k])
                for k, mac in MACROS if items.get(k))
            if cap is not None and suffixe:
                n += 1
                neuve = "#+CAPTION[%s]: %s%s" % (court or cap, cap, suffixe)
                gardees = [neuve if re.match(r"^[ \t]*#\+CAPTION", x, re.I) else x
                           for x in gardees]
            if alt:
                pose = [False]

                def poser(x):
                    if not pose[0] and RE_ATTR.match(x):
                        pose[0] = True
                        return attr_avec_alt(x, alt)
                    return x
                gardees = [poser(x) for x in gardees]
                if not pose[0]:
                    gardees.append("#+ATTR_LATEX: :options alt={%s}" % alt)
            pile = gardees
        sortie.extend(pile); i = j
    return "\n".join(sortie), n


# ── essais ───────────────────────────────────────────────────────────────────

ESSAIS = [
    ("pile complète, ordre libre",
     "#+DESC: Une matrice à deux /entrées/.\n"
     "#+CAPTION: Les quatre modalités\n"
     "#+NOTE: Les cases grisées ne sont pas instanciées.\n"
     "#+NAME: fig:m\n"
     "#+SOURCE: https://fr.lipsum.com/\n"
     "#+ATTR_LATEX: :placement [htbp] :options width=.9\\linewidth\n"
     "#+ALT_TEXT: Matrice a deux entrees.\n"
     "[[./img/m.pdf]]\n",
     lambda r: ("#+CAPTION[Les quatre modalités]" in r
                and "descfig" in r and "notefig" in r and "srcfig" in r
                and "width=.9\\linewidth,alt={Matrice a deux entrees.}" in r
                and "#+DESC:" not in r)),
    ("sans #+ATTR_LATEX préalable",
     "#+CAPTION: T\n#+NAME: fig:n\n#+ALT_TEXT: Texte seul.\n[[./x.pdf]]\n",
     lambda r: "#+ATTR_LATEX: :options alt={Texte seul.}" in r),
    ("rien à replier",
     "#+CAPTION: T\n#+NAME: fig:r\n#+ATTR_LATEX: :width 0.5\\linewidth\n[[./z.pdf]]\n",
     lambda r: "#+CAPTION[" not in r and "alt=" not in r),
    ("pile ouvrant sur #+BEGIN_ — ne doit pas boucler",
     "#+CAPTION: T\n#+BEGIN_EXPORT latex\n\\x\n#+END_EXPORT\n",
     lambda r: "#+BEGIN_EXPORT latex" in r),
    ("crochet imbriqué dans une remarque",
     "Texte [rmq:avec un [crochet] dedans] et la suite.\n",
     lambda r: r.count("@@latex:") == 2 and "[crochet]" in r),
    ("remarque dans un bloc — doit rester littérale",
     "#+BEGIN_EXAMPLE\n[rmq:littéral]\n#+END_EXAMPLE\n",
     lambda r: "[rmq:littéral]" in r),
]


def essais():
    print("=" * 74)
    print("ESSAIS DES FILTRES")
    print("=" * 74)
    echecs = 0
    for nom, entree, verifier in ESSAIS:
        r, _ = items_flottants(entree)
        r, _ = remarques_en_marge(r)
        if verifier(r):
            print("    ok     %s" % nom)
        else:
            echecs += 1
            print("    ECHEC  %s" % nom)
            print("           rendu : %s" % r.replace("\n", " ⏎ ")[:150])
    print("\n" + "-" * 74)
    print("%d essai(s) sur %d passent." % (len(ESSAIS) - echecs, len(ESSAIS)))
    return 1 if echecs else 0


def passer(fichiers):
    print("=" * 74)
    print("CE QUE LES FILTRES PRODUIRONT")
    print("=" * 74)
    tot_r = tot_f = 0
    for f in fichiers:
        t = io.open(f, encoding="utf-8").read()
        t, nf = items_flottants(t)
        t, nr = remarques_en_marge(t)
        tot_r += nr; tot_f += nf
        if nr or nf:
            print("    %-30s %2d remarque(s), %2d flottant(s) enrichi(s)"
                  % (os.path.relpath(f, BASE), nr, nf))
        if "[rmq:" in t:
            print("    ECHEC  %s : une remarque survit au filtre"
                  % os.path.relpath(f, BASE))
            return 1
        if re.search(r"^#\+(DESC|NOTE|SOURCE|ALT_TEXT):", t, re.M):
            print("    ECHEC  %s : un item de flottant survit au filtre"
                  % os.path.relpath(f, BASE))
            return 1
    print("\n" + "-" * 74)
    print("%d remarque(s) et %d flottant(s) traités, rien ne survit au filtre."
          % (tot_r, tot_f))
    return 0


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--essais":
        return essais()
    if len(sys.argv) > 1:
        if not os.path.exists(sys.argv[1]):
            print("fichier introuvable : %s" % sys.argv[1])
            return 2
        fichiers = [sys.argv[1]]
    else:
        fichiers = sorted(glob.glob(os.path.join(BASE, "src", "*.org"))
                          + glob.glob(os.path.join(BASE, "src", "chapitres", "*.org")))
        if not fichiers:
            print("aucune source dans src/")
            return 2
    code = essais()
    print("")
    return max(code, passer(fichiers))


if __name__ == "__main__":
    sys.exit(main())
