<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Suivi — mode d'emploi

Ce qui se tient **à la main** : [`fiches-statuts.csv`](fiches-statuts.csv) (une ligne par fiche : statut,
confiance, preuve, note, et pour les fiches ouvertes `nature`, `avancement`, `suite`, `depend`),
[`DECISIONS.md`](DECISIONS.md), [`ANOMALIES.md`](ANOMALIES.md), [`primitives.md`](primitives.md),
[`hypotheses-de-module.md`](hypotheses-de-module.md), [`factorisations-refusees.md`](factorisations-refusees.md).

Ce qui est **produit** (ne pas éditer ; `python3 scripts/suivi.py all`) :

| Fichier | Contenu |
|---|---|
| [`RESTE-A-FAIRE.md`](RESTE-A-FAIRE.md) | fiches non closes, par nature du travail, avec avancement, prochaine étape, dépendances |
| [`FICHES-PR02.md`](FICHES-PR02.md) | état de chacune des 190 fiches, synthèse par lot |
| [`correspondance-enonces.md`](correspondance-enonces.md) | énoncés numérotés, statuts, renvois |
| [`TABLEAU-DE-BORD.md`](TABLEAU-DE-BORD.md) | blocs `mesures`, `fiches`, `ouverts` (le reste est de la prose tenue à la main) |

Instantanés hérités, non regénérés : [`registre-obligations.md`](registre-obligations.md),
[`correspondance-theoremes-org.md`](correspondance-theoremes-org.md), [`registre-empirique.md`](registre-empirique.md),
[`pr-02-plan-de-traitement.md`](pr-02-plan-de-traitement.md) (plan du 30 septembre).

## Convention « appliquée, à ratifier »

Quand l'instruction ([`../recherche/instruction-des-decisions.md`](../recherche/instruction-des-decisions.md)) donne une orientation
qui ne dénature pas le projet, on l'**applique** au Verso, on écrit le journal, et la fiche passe au statut `a-ratifier`
(`nature = ratification`) ; [`DECISIONS.md`](DECISIONS.md) porte une ligne par décision, avec sa source et l'endroit du manuscrit.
Un sceau (théorème, proposition…) ne change que si une décision l'exige : les changements proposés sont dans `DECISIONS.md`.
Une orientation qui demande un choix de fond reste dans la section « Attendent » avec sa question exacte.

## Quand une fiche avance

1. Corriger le Verso (`spec/`), puis `python3 scripts/controle.py` et `lake build Spec`.
2. Mettre à jour sa ligne de `fiches-statuts.csv` : `statut`, `preuve` (la séance du journal), `note` ; pour une
   fiche ouverte, `avancement` et `suite`. Une fiche ouverte sans `nature` fait échouer `suivi.py check`.
3. Consigner la séance dans [`../journal/`](../journal/) ; `python3 scripts/suivi.py all` ; commit.
