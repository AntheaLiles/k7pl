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

La formule candidate

`Adm(β,κ) ↔ β=ω ∨ Cost_Budget(κ)≤β`

n’est **pas** ratifiée comme définition exacte. Elle reste une candidate à normaliser à partir des définitions canoniques de `𝔅`, de son ordre, de `ω` et de `Cost_Budget`.

## Questions formelles ouvertes

1. Définir le type `𝔅` et l’ordre utilisé pour comparer un budget au coût.
2. Établir si `ω` est l’élément maximal de `𝔅`. Si oui, déterminer si `β=ω` est redondant avec `Cost_Budget(κ)≤β`, sans supprimer le disjoint avant décision/normalisation explicite.
3. Fixer la définition de `Adm` et prouver les propriétés requises par les règles.
4. Définir séparément le domaine de `Consume` et celui de `ψ`. D5 ne suppose pas que ces opérations sont totales, ni que leur domaine coïncide automatiquement avec `Adm`.
5. Prouver, si la formalisation le revendique, le lien entre admissibilité statique, consommation d’un effet et bornes effectives à l’exécution.

## Statut épistémique

D5 ratifie uniquement le principe de couverture. Elle ne valide pas la formule candidate exacte et ne constitue ni preuve Lean, ni résultat de test/CI, ni garantie d’exécution. La porte C demeure **NON SATISFAITE**.
