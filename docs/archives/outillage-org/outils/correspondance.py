#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Table de correspondance entre les numéros imprimés et les étiquettes.

    python3 outils/correspondance.py

Motif, écrit le 9 septembre 2026. Une relecture externe part du document
IMPRIMÉ et cite des numéros — « le théorème 34 devrait devenir un lemme ».
Nous étiquetons. Sans table de correspondance, aucune de ses recommandations
n'est applicable, et il faut relire quarante théorèmes pour retrouver de quoi
elle parle.

Le numéro n'est pas stable : déplacer un théorème décale tous les suivants.
La table porte donc DEUX colonnes — le numéro tel que la relecture l'a vu, et
le numéro courant — et l'étiquette, qui est le seul identifiant durable.

Écrit dans meta/correspondance-theoremes.org.
"""
import io, os, re, sys, glob

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# L'assemblage sur lequel les trois relectures externes ont porté. Figé : le
# jour où un autre relecteur partira d'un autre imprimé, on ajoutera sa colonne
# plutôt que de remplacer celle-ci.
RELU = "K7_Specification-v66.org"


def theoremes(chemin):
    """Les théorèmes d'un assemblage, dans l'ordre du document.

    Rend (nom, étiquette). Le sceau — second argument optionnel, posé le
    30 septembre — est ignoré ici et lu par `sceaux()`.
    """
    t = io.open(chemin, encoding="utf-8").read()
    return [(n, l) for n, _, l in re.findall(
        r"\\begin\{theorem\}\[([^\]]*)\](\[[^\]]*\])?\s*\\label\{([^}]*)\}", t)]


def sceaux(chemin):
    """Le statut et le niveau de chaque énoncé, tels que le document les porte.

    Un énoncé sans sceau est un théorème du langage — c'était la lecture
    implicite avant que le sceau n'existe, et elle reste la valeur par défaut.
    """
    t = io.open(chemin, encoding="utf-8").read()
    rendu = {}
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
        rendu[lab] = (statut, niveau, nom)
    return rendu


def dernier_assemblage():
    fichiers = glob.glob(os.path.join(BASE, "build", "K7_Specification-v*.org"))
    return max(fichiers, key=os.path.getmtime) if fichiers else None


def main():
    courant = dernier_assemblage()
    if courant is None:
        print("    ECHEC  aucun assemblage dans build/")
        sys.exit(2)

    relu = os.path.join(BASE, "build", RELU)
    numero_relu = {}
    if os.path.exists(relu):
        for i, (_, lab) in enumerate(theoremes(relu), 1):
            numero_relu[lab] = i

    th = theoremes(courant)
    lignes = [
        "#+TITLE: Correspondance des numéros imprimés et des étiquettes",
        "#+AUTHOR: Cyprien PIERRE",
        "",
        "# Une relecture externe cite des numéros ; nous étiquetons. Sans cette",
        "# table, aucune de ses recommandations n'est applicable.",
        "#",
        "# NE PAS ÉDITER À LA MAIN — régénérer par :",
        "#     python3 outils/correspondance.py",
        "#",
        "# Colonne « relu » : le numéro dans %s, l'assemblage" % RELU,
        "# sur lequel ont porté les trois relectures externes du 8 septembre 2026.",
        "# Colonne « courant » : le numéro dans %s."
        % os.path.basename(courant),
        "# Un tiret signale un théorème écrit depuis la relecture.",
        "",
        "| relu | courant | Étiquette | Nom |",
        "|------+---------+-----------+-----|",
    ]
    for i, (nom, lab) in enumerate(th, 1):
        ancien = numero_relu.get(lab)
        lignes.append("| %s | %d | =%s= | %s |"
                      % (ancien if ancien else "—", i, lab, nom))

    # Ce que la relecture citait et qui n'existe plus sous ce nom.
    etiquettes = {lab for _, lab in th}
    disparus = [(n, l) for l, n in sorted(numero_relu.items(), key=lambda x: x[1])
                if l not in etiquettes]
    if disparus:
        lignes += ["", "* Théorèmes de l'assemblage relu absents du courant", ""]
        for n, l in disparus:
            lignes.append("- théorème %d — =%s=" % (n, l))

    # ── Le relevé des statuts, produit et jamais saisi ────────────────────────
    sc = sceaux(courant)
    par_statut = {}
    for lab, (statut, niveau, nom) in sc.items():
        par_statut.setdefault(statut, []).append((lab, niveau, nom))
    lignes += ["", "* Relevé des statuts", "",
               "# Produit par l'outil. Un énoncé sans sceau est un théorème du",
               "# langage : c'est la valeur par défaut, et elle est explicite ici.",
               "",
               "| Statut | Niveau | Étiquette | Nom |",
               "|--------+--------+-----------+-----|"]
    ordre = ["theoreme", "proposition", "conjecture", "definition",
             "exigence", "litterature"]
    for statut in ordre + [s for s in sorted(par_statut) if s not in ordre]:
        for lab, niveau, nom in sorted(par_statut.get(statut, [])):
            lignes.append("| %s | %s | =%s= | %s |" % (statut, niveau, lab, nom))
    lignes += ["", "#+BEGIN_QUOTE",
               "Comptes : " + ", ".join(
                   "%d %s" % (len(par_statut[s]), s)
                   for s in ordre if s in par_statut) + ".",
               "#+END_QUOTE"]

    sortie = os.path.join(BASE, "meta", "correspondance-theoremes.org")
    io.open(sortie, "w", encoding="utf-8").write("\n".join(lignes) + "\n")

    decales = sum(1 for i, (_, lab) in enumerate(th, 1)
                  if numero_relu.get(lab) not in (None, i))
    print("    %d théorèmes ; %d décalés depuis la relecture ; %d nouveaux"
          % (len(th), decales, sum(1 for _, l in th if l not in numero_relu)))
    print("    écrit : %s" % os.path.relpath(sortie, BASE))


if __name__ == "__main__":
    main()
