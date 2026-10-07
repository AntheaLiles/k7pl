<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Hypothèses de module et obstacles outils (`IMPL-09`)

Ce que la transcription en assistant de preuve devra poser comme paramètre ou contourner. Inventaire
tenu à la main ; le registre des énoncés ouverts est produit par `scripts/suivi.py` (bloc « ouverts »
du [tableau de bord](TABLEAU-DE-BORD.md)).

## Hypothèses de module

| Hypothèse | Lieu | Fiches |
|---|---|---|
| totalité de `⟦operation⟧` | §E.4 → ch. 4 (sémantique opérationnelle) | `PREUVE-07` |
| conformité de l'abaissement de l'arène | ch. 3, élimination de l'arène (exception déclarée) | `BLOQ-09`, `PREUVE-12` |
| `D_det` : parcours, recherche et graine déterministes | ch. 6, §4.1 de la sémantique | `PREUVE-15` |
| `Sim` : simulation de la réduction par la traduction | ch. 4 §4.6 | `PREUVE-07`, `BLOQ-07` |
| traduction qui enfile le canal de temps | ch. 4 §4.6 | `PREUVE-07` |
| `⟦operation⟧` ne mentionne aucun fil de temps | ch. 4 §4.8 (fil de temps enfilé, `thm:chaine_fils`) | `PREUVE-03`, `PREUVE-07` |
| `ℒ` fini (une famille finie de fils, un par niveau) | ch. 4 §4.8 (`eq:traduction-fils`) | `PREUVE-03` |
| `E_repro` à quatre composantes (ordonnancement, arrondi, chaîne, architecture et NaN) et profil `Π` ; portée « une machine » | ch. 4 §4.5 | `IMPL-06`, `ARB-PR-04` |
| conformité de l'abaissement aux tables de propagation des singularités (test différentiel) ; règle d'entrée Float64 → roue | ch. 3 §3.2 | `IMPL-07`, `BLOQ-12` |
| monotonie de `∥` pour l'ordre de la quantale | ch. 4 §4.7 (préservation, fourche et jointure) | `ANOM-17`, `PREUVE-07` |
| préservation le long des suites de pas des branches (fourche et jointure) | ch. 4 §4.7 | `ANOM-17` |
| jeton de capacité : valeur d'exécution, effacée avec les grades | ch. 4 §4.7 (`slice`) | `ANOM-17`, `BLOQ-09` |
| anneaux SPSC par émetteur, borne mémoire par le graphe de câblage | ch. 4 §4.5 | `IMPL-04` |

## Obstacles outils nommés

| Obstacle | Conséquence | Fiches |
|---|---|---|
| le cadre de sortes n'a de métathéorie mécanisée que pour une sorte unique | la métathéorie à plusieurs sortes se fait à la main | `IMPL-09`, `BIB-21` |
| les conditions de bonne formation du cadre de sortes ne sont pas revérifiées pour le prédicat d'émission étendu (maillons) | l'équivariance du prédicat étendu est à conduire à la main | `PREUVE-03`, `IMPL-09` |
| le type de chemin cubique manque à l'assistant visé | transposition graduée de la sédimentation non mécanisable telle quelle | `PREUVE-16`, `BIB-14`, `BIB-24` |
| le solveur n'émet pas de certificat | certificat exigé aux frontières de paquet, sinon boîte noire | `IMPL-01` |
| le patron de preuve gradué formalisé est en Agda | coût de transposition à budgéter | `BIB-21` |
