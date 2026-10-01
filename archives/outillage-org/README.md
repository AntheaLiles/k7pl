# Ancien outillage (Org-mode, Emacs, Python)

Ce qui assemblait, contrôlait et exportait le manuscrit Org avant la conversion en Verso. Il **ne lit pas** le Verso. Licence CECILL-2.1 (code) ; l'ancienne documentation d'organisation est dans [`README-ancien-dossier.md`](README-ancien-dossier.md) (obsolète, 4 août 2026).

| Élément | Rôle |
|---|---|
| `Makefile` | `make tout` : assembler puis contrôler ; `make plan`, `make questions`, `make pdf`… |
| `outils/construire.py` | assemble `main.org` et ses inclusions vers `build/`, valide les citations |
| `outils/controle.py` + `outils/controles/*.py` | **les contrôles** (85 verts au 1er octobre) |
| `outils/registre.py`, `correspondance.py` | registre des obligations et table des numéros, *produits* du manuscrit |
| `outils/mesure.py`, `pdf.py`, `corpus.py`, `filtres.py`, `legendes_export.py` | mesure de la prose, relevé du PDF, registre du fonds, simulation des filtres d'export |
| `my-export-config.el`, `preamble-article.tex` | configuration d'export Emacs → LaTeX (marges `[rmq:]`, sceau des énoncés, flottants) |
| `donnees/` | données des contrôles (sondes sémantiques, gel de non-régression, glyphes confusables, arcs) |

## À porter vers le Verso

Les contrôles sont rangés par famille de questions ; seule la **lecture du texte** change, la logique reste.

| Module | Famille | Priorité | Note |
|---|---|---|---|
| `controles/algebre.py` | lois d'algèbre aux bornes (0 et ω), habitabilité sous clause, conventions de l'infini | **haute** | aurait attrapé `BLOQ-03` ; calcul sur 216 triplets |
| `controles/notation.py` | un symbole, un objet ; sceau des énoncés ; propagation des statuts | **haute** | refuse qu'une prose dise « démontre » d'un énoncé ouvert |
| `controles/croise.py`, `semantique.py` | grammaire des termes × jeu de règles ; sondes de sens | moyenne | comptes de règles et de constructeurs |
| `controles/glossaire.py` | sigles, glossaire, table des glyphes | moyenne | |
| `controles/structure.py`, `citations.py`, `figures.py` | renvois, étiquettes, citations, légendes | faible | **déjà assurés par le rendu Verso** (une étiquette ou une clé absente fait échouer `lake exe spec`) |
| `controles/source.py` | hygiène de la source Org | sans objet | |

Les comptes (règles, constructeurs, énoncés, ouverts) sont déjà repris par [`scripts/manuscript_metrics.py`](../../scripts/manuscript_metrics.py) et [`scripts/suivi.py`](../../scripts/suivi.py).
