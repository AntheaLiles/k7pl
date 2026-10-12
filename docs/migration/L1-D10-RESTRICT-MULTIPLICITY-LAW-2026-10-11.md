<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Ratification D10 — restriction du domaine de la loi de multiplicité

Date : 11 octobre 2026.

## Décision d’autrice

**Option A ratifiée.** La loi candidate
`n (β ⊖ k) = (n β) ⊖ (n k)`
doit rester un lemme conditionnel, avec des hypothèses plus fortes que la seule admissibilité budgétaire. Le domaine autorisé de la multiplicité et les conditions arithmétiques exactes doivent être explicités, puis la loi prouvée dans ce domaine.

Le cas `n = ω` ne doit pas être inclus par défaut : avec la convention D8, des budgets finis admissibles peuvent produire des membres différents. La décision ne choisit pas encore un ensemble précis de multiplicités autorisées ni une liste complète d’hypothèses suffisantes.

## Portée architecturale

C2 indique que cette loi n’est pas requise par `Scale_Usage`, qui conserve le budget, et qu’elle ne doit pas être une prémisse générale de la substitution. Toute factorisation globale reste une piste de recherche séparée, non ratifiée.

## Travail restant

- Auditer les six démonstrations historiquement signalées et identifier les usages effectifs de la loi.
- Déterminer quelles multiplicités et quelles hypothèses rendent la loi vraie.
- Vérifier si chaque usage est nécessaire à la substitution ou relève d’une extension optionnelle.
- Formaliser puis prouver le lemme conditionnel, si son domaine est justifié.

Aucune preuve Lean, validation CI ou garantie d’exécution n’est revendiquée. Aucun changement de `spec/` ou `src/` n’est autorisé par cette décision. La porte C demeure **NON SATISFAITE**.
