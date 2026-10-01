#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""C3 — les légendes posées sur un bloc export deviennent de vrais objets.

    python3 outils/legendes_export.py          # à blanc, n'écrit rien
    python3 outils/legendes_export.py --ecrire

Le fait, établi le 8 septembre. Org n'attache ni légende ni étiquette à un
bloc `#+BEGIN_EXPORT` : vingt-neuf `#+CAPTION:` étaient écrites et aucune
n'était imprimée. Elles ne se traitent pas toutes de la même manière.

  — Sur un THÉORÈME, la légende double le nom que porte déjà
    `\\begin{theorem}[...]`. Un théorème est un objet numéroté et listé ; lui
    ajouter une légende lui donnerait un second numéro. La légende est retirée.

  — Sur un AFFICHAGE FORMEL — grammaire, jeu de règles, équation —, il n'y a
    aucun objet numéroté, et c'est là que la légende manquait. Elle devient un
    `\\captionof{formule}` suivi d'un `\\label`, ce qui numérote, liste et rend
    l'objet citable sans le faire flotter loin de son texte.

Un affichage numéroté par `equation` reçoit son numéro de la famille des
formules plutôt que du compteur d'équations : deux numéros pour un objet
seraient un de trop.
"""
import io, os, re, sys, glob

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ECRIRE = "--ecrire" in sys.argv


def sources():
    return (sorted(glob.glob(os.path.join(BASE, "src", "*.org")))
            + sorted(glob.glob(os.path.join(BASE, "src", "chapitres", "*.org"))))


def traiter(chemin):
    """Rend (lignes_nouvelles, retirees, converties)."""
    L = io.open(chemin, encoding="utf-8").read().split("\n")
    sortie, i, retirees, converties = [], 0, [], []

    while i < len(L):
        ligne = L[i]
        if not ligne.startswith("#+CAPTION:"):
            sortie.append(ligne); i += 1; continue

        # La pile de mots-clés qui suit, jusqu'au bloc.
        legende = ligne[len("#+CAPTION:"):].strip()
        j, nom = i + 1, None
        while j < len(L) and L[j].startswith("#+") and not L[j].startswith("#+BEGIN"):
            if L[j].startswith("#+NAME:"):
                nom = L[j][len("#+NAME:"):].strip()
            j += 1
        if j >= len(L) or not L[j].startswith("#+BEGIN_EXPORT"):
            sortie.append(ligne); i += 1; continue     # pile normale, on passe

        # Le bloc, jusqu'à sa fermeture.
        k = j + 1
        while k < len(L) and not L[k].startswith("#+END_EXPORT"):
            k += 1
        corps = L[j + 1:k]
        theoreme = any("\\begin{theorem}" in c for c in corps)

        if theoreme:
            # La légende double le nom du théorème : on la retire.
            retirees.append((nom or "(sans nom)", legende[:60]))
            sortie.extend(L[i + 1:k])                  # tout sauf la légende
        else:
            # Un affichage formel : la légende devient un objet numéroté.
            corps = [re.sub(r"\\begin\{equation\}", r"\\begin{equation*}", c)
                     for c in corps]
            corps = [re.sub(r"\\end\{equation\}", r"\\end{equation*}", c)
                     for c in corps]
            # Le \label interne au display devient inutile : il est porté par
            # la légende, seule à numéroter désormais.
            corps = [c for c in corps
                     if not (nom and c.strip() == "\\label{%s}" % nom)]
            corps = [re.sub(r"\\label\{%s\}" % re.escape(nom), "", c)
                     if nom else c for c in corps]
            ajout = ["\\captionof{formule}{%s}" % legende]
            if nom:
                ajout.append("\\label{%s}" % nom)
            sortie.extend(L[i + 1:j + 1])              # la pile sans la légende
            sortie.extend(corps)
            sortie.extend(ajout)
            converties.append((nom or "(sans nom)", legende[:60]))
        i = k                                          # on reprend sur #+END_EXPORT
    return sortie, retirees, converties


def main():
    tot_r = tot_c = 0
    for chemin in sources():
        nouvelles, retirees, converties = traiter(chemin)
        if not retirees and not converties:
            continue
        nom = os.path.basename(chemin)
        print("── %s" % nom)
        for n, l in converties:
            print("   numérotée   %-28s %s" % (n, l))
        for n, l in retirees:
            print("   retirée     %-28s %s" % (n, l))
        tot_r += len(retirees); tot_c += len(converties)
        if ECRIRE:
            io.open(chemin, "w", encoding="utf-8").write("\n".join(nouvelles))

    print("\n  %d légende(s) devenue(s) formule numérotée et listée" % tot_c)
    print("  %d légende(s) retirée(s) d'un théorème, qui porte déjà son nom" % tot_r)
    if not ECRIRE:
        print("\n  À BLANC — rien n'a été écrit. Relancer avec --ecrire.")


if __name__ == "__main__":
    main()
