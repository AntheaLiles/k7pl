<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# org2verso — conversion du manuscrit Org-mode en Verso

Programme à usage unique devenu outil de reproductibilité : il a produit `spec/` à partir du
manuscrit Org-mode du 1er octobre 2026 (figé dans [`docs/archives/manuscrit-org/`](../../docs/archives/manuscrit-org/)).
**Depuis cette conversion, la source de référence est le Verso** ; on n'exécute plus ce programme
pour écrire, seulement pour vérifier que la conversion se rejoue à l'identique ou pour convertir un
état plus récent des sources Org.

```sh
pip install pymupdf                     # PDF → SVG des figures
# optionnel, pour les diagrammes mermaid : npm install @mermaid-js/mermaid-cli
python3 scripts/org2verso/convert.py \
    --src docs/archives/manuscrit-org --meta spec/figures \
    --out /tmp/rejeu --report /tmp/rejeu/rapport.md [--mmdc chemin/vers/mmdc]
diff -r spec/Spec /tmp/rejeu/spec/Spec    # aucune différence attendue
```

| Fichier | Rôle |
|---|---|
| `orgparse.py` | analyseur du sous-ensemble d'Org employé par le manuscrit (titres, paragraphes, listes, tableaux, blocs, mots-clés affiliés, balisage en ligne) ; **tout ce qu'il ne reconnaît pas est signalé**, rien n'est perdu en silence |
| `emit.py` | émission du source Verso : échappement, découpe des lignes, énoncés, formules, tableaux, figures |
| `convert.py` | assemblage : sections, modules, étiquettes, numérotation (annexes lettrées), glossaire, figures, rapport |

## Fidélité

Le texte n'est pas modifié. Les différences voulues, toutes de forme : retours à la ligne à
100 colonnes ; `~` de LaTeX devient une espace insécable ; `**x**` (gras doublé) devient `*x*` ;
les commentaires Org deviennent des blocs `:::comment` (non rendus) ; les `\ref` deviennent des
`{num}` ; les annexes portent leur lettre dans le titre.

Le rapport de conversion liste les renvois non résolus (aucun aujourd'hui) et les avertissements
de l'analyseur (un : l'en-tête du tableau `tab:engagements` est incomplet dans la source, voir
[`docs/tracking/ANOMALIES.md`](../../docs/tracking/ANOMALIES.md)).

Autres scripts : [`../biblio/`](../biblio/) (bibliographie), [`../org2md.py`](../org2md.py) (notes
Org → Markdown), [`../manuscript_metrics.py`](../manuscript_metrics.py) et
[`../suivi.py`](../suivi.py) (mesures et vues du suivi).
