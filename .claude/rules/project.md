<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Règles globales du projet

k7pl est un langage de programmation en cours de conception, avec une spécification en Verso et une implémentation en Lean 4.

## Sources de vérité

- `spec/` est la source normative de la spécification courante.
- `src/` est la source de l'implémentation Lean.
- `tests/` contient les contrôles exécutables.
- `docs/` contient le suivi, les décisions, les audits et les matériaux de recherche.
- `archives/` conserve l'ancien manuscrit et l'ancien outillage ; ne pas les modifier pour corriger la version courante.

Une affirmation dans la spécification, une définition Lean, une preuve et un test sont des objets différents. Ne jamais les considérer comme interchangeables.

## Invariants

Ne pas introduire :

- `sorry`, `admit`, nouvel `axiom` ou `native_decide` ;
- dépendance non maîtrisée ;
- modification silencieuse du manuscrit ;
- affaiblissement d'un contrôle pour faire passer CI, Scorecard ou CII.

Avant toute modification importante, lire la règle spécialisée correspondant à la zone touchée.

## Discipline de travail

Préférer la plus petite modification démontrant le résultat demandé. Ne pas refactorer un domaine non concerné.

Une tâche qui traverse `spec/` et `src/` doit expliciter la relation entre les deux avant l'implémentation.

Une décision non certaine doit être marquée comme hypothèse, question ouverte ou action humaine requise ; ne jamais la présenter comme un fait établi.
