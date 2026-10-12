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

Le lemme Lean `K7pl.GradeBudget.top_disjunct_iff_le` formalise cette équivalence d’ordre sur `ℕ∞`. Il ne formalise ni le prédicat K7PL `Adm`, ni `Cost_Budget`, ni les règles qui doivent consommer cette précondition. La conformité de la définition de C2 dépend encore de l’établissement de leurs types canoniques et du raccord effectif avec les règles.

## Questions formelles ouvertes

1. Formaliser et relier les types canoniques : `β : ℕ∞`, `Cost_Budget : K → ℕ∞`, et leur ordre utilisé.
2. Formaliser `Cost_Budget` et démontrer que l’agrégateur de C2 est total sur le domaine canonique `K`.
3. Définir `Adm` dans l’artefact formel K7PL et prouver les propriétés requises par les règles.
4. Définir séparément le domaine de `Consume` et celui de `ψ`. D5 ne suppose pas que ces opérations sont totales, ni que leur domaine coïncide automatiquement avec `Adm`.
5. Prouver, si la formalisation le revendique, le lien entre admissibilité statique, consommation d’un effet et bornes effectives à l’exécution.

## Statut épistémique

D5 ratifie uniquement le principe de couverture. Elle ne valide pas la formule candidate exacte et ne constitue ni preuve Lean, ni résultat de test/CI, ni garantie d’exécution. La porte C demeure **NON SATISFAITE**.
