<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Ratification D5 — principe d’admissibilité du budget

**Date :** 11 octobre 2026  
**Statut :** principe décidé ; définition formelle et preuves ouvertes.  
**Portée :** décision documentaire de recherche ; aucun changement normatif de `spec/` ou `src/`.

## Décision ratifiée

L’autrice retient l’option B : le principe d’admissibilité est que le budget doit couvrir le coût annoncé. Pour un budget `β` et un contexte/coût `κ`, `Adm(β,κ)` exprime ce principe de couverture.

La forme canonique actuellement retenue dans C2 et le registre D-19 est
`Adm(β,κ) ↔ Cost_Budget(κ)≤β`. Ce n’est pas une nouvelle ratification au-delà du principe D5 : c’est la normalisation logique de la variante
`β=ω ∨ Cost_Budget(κ)≤β`, **sous la condition explicite** que `β` et `Cost_Budget(κ)` appartiennent à `ℕ∞` et que `ω` est son élément maximal. Dans ce domaine, le cas `β=ω` implique déjà `Cost_Budget(κ)≤β`, et la réciproque vers la disjonction est immédiate.

Le lemme Lean `K7pl.GradeBudget.top_disjunct_iff_le` formalise cette équivalence d’ordre sur `ℕ∞`. Le module formalise maintenant le porteur `K = (ℕ∞ × ℕ∞)^ℒ` via l’alias `K L`, ainsi que les wrappers `costBudgetK`, `admK` et `consumeK`. Il prouve leur raccord définitoire au modèle de profil et la conservation sur le domaine admis. Il ne formalise toujours pas le jugement de typage ni les transitions opérationnelles qui doivent préserver `Adm` et n’invoquer `Consume` que sur son domaine.

## Questions formelles ouvertes

1. **Partiellement couvert dans `K7pl.GradeBudget` :** type canonique de profil, scalarisation `max(W,D)`, `admK` comme couverture et `consumeK` à précondition explicite.
2. **À prouver :** que les agrégateurs du modèle sont les mesures normatives de C2 et restent les bonnes mesures pour les transitions effectivement observées.
3. **À prouver :** préservation de l’admissibilité par les règles, et preuve que chaque invocation opérationnelle de `Consume` porte un témoin valide.
4. **Séparé :** formaliser le domaine de `ψ` et prouver qu’il ne dépend pas implicitement de l’admissibilité de `Consume`.
5. **À prouver :** le lien entre admissibilité statique, consommation d’un effet et bornes effectives à l’exécution.

## Statut épistémique

D5 ratifie uniquement le principe de couverture. Elle ne valide pas la formule candidate exacte et ne constitue ni preuve Lean, ni résultat de test/CI, ni garantie d’exécution. La porte C demeure **NON SATISFAITE**.
