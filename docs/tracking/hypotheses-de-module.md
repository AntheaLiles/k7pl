<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Hypothèses de module et obstacles outils (`IMPL-09`)

Ce que la transcription en assistant de preuve devra poser comme paramètre ou contourner. Inventaire
tenu à la main ; les vues de suivi des énoncés sont produites par `scripts/suivi.py`, notamment [la correspondance courante](correspondance-enonces.md).

## Hypothèses de module

| Hypothèse | Lieu | Fiches |
|---|---|---|
| totalité de `⟦operation⟧` | §E.4 → ch. 4 (sémantique opérationnelle) | `PREUVE-07` |
| conformité de l'abaissement de l'arène | ch. 3, élimination de l'arène (exception déclarée) | `BLOQ-09`, `PREUVE-12` |
| `D_det` : parcours, recherche et graine déterministes | ch. 6, §4.1 de la sémantique | `PREUVE-15` |
| `Sim` : simulation de la réduction par la traduction | ch. 4 §4.6 | `PREUVE-07`, `BLOQ-07` |
| traduction qui enfile le canal de temps | ch. 4 §4.6 | `PREUVE-07` |
| `E_repro` étendue (architecture, NaN) et profil `Π` | ch. 4 §4.5 | `IMPL-06` |

## Obstacles outils nommés

| Obstacle | Conséquence | Fiches |
|---|---|---|
| le cadre de sortes n'a de métathéorie mécanisée que pour une sorte unique | la métathéorie à plusieurs sortes se fait à la main | `IMPL-09`, `BIB-21` |
| le type de chemin cubique manque à l'assistant visé | transposition graduée de la sédimentation non mécanisable telle quelle | `PREUVE-16`, `BIB-14`, `BIB-24` |
| le solveur n'émet pas de certificat | certificat exigé aux frontières de paquet, sinon boîte noire | `IMPL-01` |
| le patron de preuve gradué formalisé est en Agda | coût de transposition à budgéter | `BIB-21` |
