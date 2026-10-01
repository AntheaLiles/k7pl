# Manuscrit Org-mode — état figé du 1er octobre 2026

Sources du manuscrit de K7PL telles qu'elles étaient à la conversion en Verso : `main.org`, sept chapitres, les références, cinq annexes et le glossaire. Licence CC-BY-4.0.

**La source de référence est maintenant [`spec/`](../../spec/)** (Verso). Ce dossier ne sert plus qu'à :

* retrouver le texte d'origine, mot pour mot ;
* rejouer la conversion : `python3 scripts/org2verso/convert.py --src archives/manuscrit-org --meta spec/figures --out <répertoire de sortie>` (voir `scripts/org2verso/`) ;
* faire tourner l'ancien outillage, qui lit ces fichiers ([`../outillage-org/`](../outillage-org/)).

Ne pas y corriger le texte : on corrige dans `spec/`.

| Fichier | Rôle |
|---|---|
| `main.org` | document maître : titre, auteur, inclusion des chapitres et des annexes (`\appendix` avant les annexes). La ligne `#+EMAIL:` a été retirée. |
| `chapitres/c1…c7-*.org` | les sept chapitres |
| `chapitres/refs.org` | « Références du document » : listes des figures, tableaux, formules, codes ; glosses, acronymes, index |
| `chapitres/annexes.org` | vidé le 6 août (le fichier le dit) ; conservé pour mémoire |
| `K7_Errors.org`, `K7_LSP_REPL.org`, `K7_Sushi.org`, `K7_Sugoi.org`, `K7_Semantique.org` | annexes A à E |
| `K7PL-glossary.org` | termes, acronymes et index (source `org-glossary`) |

Les sources des figures sont dans [`spec/figures/sources/`](../../spec/figures/sources/) (drawio et mermaid) ; la bibliographie est dans [`biblio/references.json`](../../biblio/references.json).
