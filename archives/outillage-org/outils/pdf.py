#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Relève ce que le PDF composé montre, et ce que la compilation a laissé derrière.

    python3 outils/pdf.py                 le PDF trouvé automatiquement
    python3 outils/pdf.py chemin/x.pdf    un PDF nommé

Quatre relevés, dans cet ordre :

  1. AUXILIAIRES  — un .aux, .toc ou .bbl corrompu, c'est-à-dire porteur
     d'octets nuls. C'est le relevé qui passe en premier parce qu'il explique
     les compilations qui s'arrêtent sans message : LuaTeX lit le .aux au
     \\begin{document}, rencontre un octet nul et s'arrête net. Le journal se
     termine alors sur « (./main.aux » et rien d'autre. Vu le 8 septembre :
     420 677 octets dont 323 480 nuls.

  2. DÉBORDEMENTS — ce qui sort de la zone imprimable. Deux seuils, et la
     différence compte. Au-delà de la marge de quelques points, c'est la
     protrusion de microtype, qui pousse la ponctuation hors du fer pour
     l'aligner à l'œil : voulue. Au-delà de sept points, c'est une formule ou
     une table plus large que la page. Seul le second est compté.

  3. REMARQUES   — les pages qui portent une remarque dans la zone
     d'annotation, et celles où le marqueur [rmq: s'imprime encore en clair,
     signe que le filtre org n'a pas tourné.

  4. NOTES       — les pages qui portent une note de bas de page.

Sortie : 0 si tout est sain, 1 si un relevé signale quelque chose, 2 si le
relevé n'a pas pu être conduit — PDF introuvable ou pdfplumber absent.

Dépendance : pdfplumber (pip install pdfplumber).
"""

import os
import re
import sys
import glob
import collections

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MARGE_CM = 2.4
PT_PAR_CM = 72.0 / 2.54
PROTRUSION = 7.0            # points tolérés au titre de la protrusion


def trouver_pdf():
    """Rend le PDF composé le plus récent, ou None. Org écrit à côté du .org,
    latexmk dans son -output-directory : on cherche donc aux deux endroits."""
    candidats = (glob.glob(os.path.join(BASE, "src", "*.pdf"))
                 + glob.glob(os.path.join(BASE, "build", "*.pdf"))
                 + glob.glob(os.path.join(BASE, "*.pdf")))
    return max(candidats, key=os.path.getmtime) if candidats else None


def auxiliaires_corrompus(racine):
    """Rend la liste des fichiers auxiliaires porteurs d'octets nuls.

    RACINE est le chemin du PDF sans son extension. Un auxiliaire corrompu
    empoisonne toutes les compilations suivantes : latexmk renomme .bbl et
    .bcf en *-SAVE-ERROR quand une passe meurt, mais jamais le .aux."""
    abimes = []
    for ext in (".aux", ".toc", ".lof", ".lot", ".bbl", ".bcf", ".out", ".thm"):
        p = racine + ext
        if not os.path.exists(p):
            continue
        d = open(p, "rb").read()
        n = d.count(0)
        if n:
            abimes.append((os.path.basename(p), len(d), n))
    return abimes


def relever(chemin):
    """Rend (débordements, pages_remarques, pages_rmq_en_clair, pages_notes)."""
    import pdfplumber

    fautives, rmq_marge, rmq_clair, notes = [], [], [], []
    with pdfplumber.open(chemin) as pdf:
        for numero, page in enumerate(pdf.pages, start=1):
            limite = float(page.width) - MARGE_CM * PT_PAR_CM + PROTRUSION
            sortis = [c for c in page.chars
                      if c["x1"] > limite and c["text"].strip()]
            if sortis:
                lignes = collections.defaultdict(list)
                for c in page.chars:
                    lignes[round(c["top"])].append(c)
                hauteurs = sorted({round(c["top"]) for c in sortis})
                premiere = sorted(lignes[hauteurs[0]], key=lambda c: c["x0"])
                fautives.append({
                    "page": numero,
                    "lignes": len(hauteurs),
                    "jusqua": max(c["x1"] for c in sortis),
                    "limite": limite,
                    "texte": "".join(c["text"] for c in premiere)[:110],
                })
            texte = page.extract_text() or ""
            if "[rmq:" in texte:
                rmq_clair.append(numero)
            elif re.search(r"\bRMQ\s*\d+\.", texte):
                rmq_marge.append(numero)
            bas = " ".join(w["text"] for w in page.extract_words()
                           if w["top"] > page.height * 0.80)
            if re.search(r"(^|\s)[a-e]\s+[A-ZÀ-ÜÉÈ]", bas):
                notes.append(numero)
    return fautives, rmq_marge, rmq_clair, notes


def main():
    chemin = sys.argv[1] if len(sys.argv) > 1 else trouver_pdf()
    if not chemin:
        print("PDF introuvable — cherché dans src/, build/ et à la racine.")
        print("Composer d'abord le document depuis Emacs.")
        return 2
    if not os.path.exists(chemin):
        print("PDF introuvable : %s" % chemin)
        return 2

    print("=" * 74)
    print("RELEVÉ DU PDF COMPOSÉ — %s" % os.path.relpath(chemin, BASE))
    print("=" * 74)
    verdict = 0

    print("\n[Auxiliaires]")
    abimes = auxiliaires_corrompus(os.path.splitext(chemin)[0])
    if abimes:
        verdict = 1
        for nom, taille, nuls in abimes:
            print("    ECHEC  %s : %d octets dont %d nuls (%.0f %%)"
                  % (nom, taille, nuls, 100.0 * nuls / taille))
        print("           Un auxiliaire corrompu arrête LuaTeX sans message.")
        print("           Effacer les auxiliaires et recomposer : latexmk -C")
    else:
        print("    ok     aucun auxiliaire corrompu")

    try:
        fautives, rmq_marge, rmq_clair, notes = relever(chemin)
    except ImportError:
        print("\npdfplumber manque : pip install pdfplumber")
        return 2

    print("\n[Débordements de la marge d'impression]")
    if not fautives:
        print("    ok     rien ne sort de la zone imprimable")
    else:
        verdict = 1
        for f in fautives:
            print("    ECHEC  page %d — %d ligne(s), jusqu'à %.0f pt pour une "
                  "limite de %.0f" % (f["page"], f["lignes"], f["jusqua"],
                                      f["limite"]))
            print("           %s" % f["texte"])

    print("\n[Remarques en marge]")
    if rmq_clair:
        verdict = 1
        print("    ECHEC  %d page(s) impriment « [rmq: » en clair : %s"
              % (len(rmq_clair), rmq_clair[:12]))
        print("           le filtre my/org-remarques-en-marge n'a pas tourné.")
    if rmq_marge:
        print("    ok     %d remarque(s) en zone d'annotation, pages %s"
              % (len(rmq_marge), rmq_marge[:12]))
    elif not rmq_clair:
        print("    ok     aucune remarque dans ce document")

    print("\n[Notes de bas de page]")
    print("    ok     %d page(s) en portent : %s"
          % (len(notes), notes[:12]) if notes else
          "    ok     aucune note de bas de page")

    print("\n" + "-" * 74)
    print("relevé sain." if verdict == 0 else "le relevé signale quelque chose.")
    return verdict


if __name__ == "__main__":
    sys.exit(main())
