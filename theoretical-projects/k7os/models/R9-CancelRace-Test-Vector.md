<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R9 — Vecteur de test : course entre annulation et commit

**ID :** R9-CE-CANCEL-RACE-01  
**Modèle :** [R9ActorCancellation.tla](R9ActorCancellation.tla)  
**Configuration négative :** [R9-NaiveCancelClaim.cfg](R9-NaiveCancelClaim.cfg)  
**Nature :** trace témoin dérivée de la relation de transition pour définir l’oracle ; ce fichier n’est pas un export TLC et le lancement TLC reste à effectuer.

## Hypothèse évaluée

La propriété candidate NoCommitAfterCancelRequest suppose qu’aucun effet ne peut être validé après l’émission de la demande d’annulation. Le modèle distingue la demande de l’accusé : tant que l’accusé n’a pas été émis, le commit peut gagner la course.

## Trace témoin S0–S4

| État | Action | aState | bState | requestState | cancelRequested | cancelAck | effectCount | Budget A | Budget B |
|---|---|---|---|---|---:|---:|---:|---:|---:|
| S0 | Init | Ready | Idle | None | faux | faux | 0 | 2 | 2 |
| S1 | Send | Waiting | Idle | Pending | faux | faux | 0 | 1 | 2 |
| S2 | Accept | Waiting | Handling | Accepted | faux | faux | 0 | 1 | 1 |
| S3 | RequestCancellation | CancelRequested | Handling | Accepted | vrai | faux | 0 | 0 | 1 |
| S4 | Commit | Completed | Done | Committed | vrai | faux | 1 | 0 | 0 |

**Séquence :** Send → Accept → CancelRequest → EffectCommit.

À S4, NoCommitAfterCancelRequest n’est pas satisfaite. Les invariants nominaux restent respectés : aucun accusé d’annulation n’a été émis, un seul effet est validé et les deux budgets restent dans le domaine borné.

## Oracle des tests

| ID de test | Cas | Assertion attendue |
|---|---|---|
| R9-TEST-CANCEL-ACK-01 | Annulation d’une requête encore Pending | Si l’accusé est émis, effectCount vaut 0. |
| R9-TEST-CANCEL-ACK-02 | Annulation après Accept, interruption gagnante | L’accusé n’arrive qu’après l’interruption ; effectCount vaut 0. |
| R9-TEST-CANCEL-RACE-03 | Commit gagnant après la demande | L’état final est Completed ; aucun accusé n’a été émis ; effectCount vaut 1. |
| R9-TEST-BUDGET-04 | Débit lorsque le budget vaut zéro | Aucune transition de coût positif ne peut rendre le budget négatif. |

Les tests ci-dessus décrivent les observations attendues du modèle et, ultérieurement, du runtime. Ils ne déclarent pas une API K7PL actuelle pour l’annulation ou le commit. Cette API, son point de linéarisation et ses erreurs restent à relier au contrat normatif.

## Résultat à enregistrer après TLC

Quand TLC aura été exécuté, joindre son export exact, le SHA de R9ActorCancellation.tla, les empreintes des deux configurations, la version de tla2tools.jar, les paramètres, le nombre d’états, le code retour et la trace du cas négatif. Jusqu’à cet essai, cette pièce est un vecteur de test dérivé du modèle, pas un rapport de lancement outil.
