#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Registre des obligations — produit, jamais saisi.

    python3 outils/registre.py

Motif, écrit le 30 septembre 2026. La campagne PR-02 a relevé que le document
« se corrige en avant et ne propage pas en arrière » : une correction est
écrite là où elle est découverte, et les mentions antérieures gardent l'ancien
statut. Le lecteur trouve alors le même énoncé démontré page 60 et esquissé
page 240.

Un registre tenu à la main aurait le même défaut, avec une ligne de plus à
oublier. Celui-ci est PRODUIT du manuscrit : le sceau de chaque énoncé y entre,
les dépendances s'y lisent des renvois, et rien n'y est recopié.

Écrit dans meta/registre-obligations.org.
"""
import io, os, re, sys, glob

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def sources():
    return (sorted(glob.glob(os.path.join(BASE, "src", "*.org")))
            + sorted(glob.glob(os.path.join(BASE, "src", "chapitres", "*.org"))))


def releve():
    """Rend {étiquette: {statut, niveau, nom, lieu, cite, cite_par}}."""
    enonces, textes = {}, {}
    for chemin in sources():
        t = io.open(chemin, encoding="utf-8").read()
        textes[os.path.basename(chemin)] = t
        for nom, sceau, lab in re.findall(
                r"\\begin\{theorem\}\[([^\]]*)\](\[[^\]]*\])?\s*\\label\{([^}]*)\}", t):
            statut, niveau = "theoreme", "langage"
            if sceau:
                m = re.search(r"statut\s*=\s*(\w+)", sceau)
                if m:
                    statut = m.group(1)
                m = re.search(r"niveau\s*=\s*(\w+)", sceau)
                if m:
                    niveau = m.group(1)
            enonces[lab] = {"statut": statut, "niveau": niveau, "nom": nom,
                            "lieu": os.path.basename(chemin),
                            "cite": set(), "cite_par": set()}

    # Les dépendances : quel énoncé en cite quel autre, dans son propre bloc.
    for chemin in sources():
        t = io.open(chemin, encoding="utf-8").read()
        for m in re.finditer(r"\\begin\{theorem\}.*?\\end\{theorem\}", t, re.S):
            bloc = m.group(0)
            mine = re.search(r"\\label\{(thm:[^}]+)\}", bloc)
            if not mine:
                continue
            source = mine.group(1)
            for cible in set(re.findall(r"\\ref\{(thm:[^}]+)\}", bloc)):
                if cible != source and cible in enonces:
                    enonces[source]["cite"].add(cible)
                    if cible in enonces:
                        enonces[cible]["cite_par"].add(source)
    return enonces


# Ce que chaque statut engage, et par quelle route il se lève. La route est
# déduite du statut : c'est la doctrine E, appliquée aux énoncés plutôt qu'aux
# seuls engagements de la table 1.
ROUTE = {
    "theoreme":    "—  (acquis)",
    "proposition": "démonstration",
    "conjecture":  "démonstration",
    "definition":  "—  (pose, n'établit pas)",
    "exigence":    "mesure",
    "litterature": "littérature  (acquis ailleurs)",
}


def main():
    e = releve()
    ouverts = [l for l, v in e.items()
               if v["statut"] in ("proposition", "conjecture", "exigence")]

    L = [
        "#+TITLE: Registre des obligations",
        "#+AUTHOR: Cyprien PIERRE",
        "",
        "# NE PAS ÉDITER À LA MAIN — produit par :",
        "#     python3 outils/registre.py",
        "#",
        "# Le document se corrigeait en avant sans propager en arrière : un même",
        "# énoncé s'y lisait démontré à un endroit et esquissé à un autre. Ce",
        "# registre est produit du manuscrit, de sorte qu'il ne peut pas diverger",
        "# de lui. Le statut vient du sceau, les dépendances des renvois.",
        "",
        "* Ce qui reste ouvert",
        "",
        "Les énoncés dont le statut n'est pas acquis, et par quelle route ils se",
        "lèveront. Un énoncé qui change de statut change ici sans que personne",
        "n'ait à y penser.",
        "",
        "| O | Étiquette | Statut | Niveau | Route | Dont dépendent |",
        "|---+-----------+--------+--------+-------+----------------|",
    ]
    for i, lab in enumerate(sorted(ouverts), 1):
        v = e[lab]
        aval = len(v["cite_par"])
        L.append("| O-%02d | =%s= | %s | %s | %s | %s |"
                 % (i, lab, v["statut"], v["niveau"], ROUTE[v["statut"]],
                    "%d énoncé(s)" % aval if aval else "aucun"))

    L += ["", "* L'ensemble des énoncés", "",
          "| Étiquette | Statut | Niveau | Cite | Cité par | Lieu |",
          "|-----------+--------+--------+------+----------+------|"]
    for lab in sorted(e):
        v = e[lab]
        L.append("| =%s= | %s | %s | %d | %d | %s |"
                 % (lab, v["statut"], v["niveau"], len(v["cite"]),
                    len(v["cite_par"]), v["lieu"]))

    # Ce qui dépend d'un énoncé non acquis : c'est la part du document qui
    # repose sur du non démontré, et elle se calcule plutôt qu'elle ne s'estime.
    portees = set()
    for lab in ouverts:
        portees |= e[lab]["cite_par"]
    L += ["", "* Ce qui repose sur du non acquis", "",
          "Les énoncés qui citent au moins un énoncé ouvert. Aucun n'est faux ;",
          "chacun hérite du statut le plus faible de ce qu'il invoque.", ""]
    for lab in sorted(portees):
        appuis = sorted(set(e[lab]["cite"]) & set(ouverts))
        L.append("- =%s= s'appuie sur %s" % (lab, ", ".join("=%s=" % a for a in appuis)))
    if not portees:
        L.append("- aucun : tout ce qui est invoqué est acquis.")

    L += ["", "#+BEGIN_QUOTE",
          "%d énoncés, dont %d ouverts. %d énoncé(s) reposent sur un énoncé ouvert."
          % (len(e), len(ouverts), len(portees)),
          "#+END_QUOTE"]

    sortie = os.path.join(BASE, "meta", "registre-obligations.org")
    io.open(sortie, "w", encoding="utf-8").write("\n".join(L) + "\n")
    print("    %d énoncés, %d ouverts, %d dépendants"
          % (len(e), len(ouverts), len(portees)))
    print("    écrit : %s" % os.path.relpath(sortie, BASE))


if __name__ == "__main__":
    main()
