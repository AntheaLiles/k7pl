<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Ratification D6 — domaine partiel de Consume

**Date :** 11 octobre 2026  
**Statut :** domaine conceptuellement décidé ; formalisation et preuves ouvertes.  
**Portée :** décision documentaire ; aucun changement normatif de `spec/` ou `src/`.

## Décision ratifiée

L’autrice retient l’option A : `Consume(β,κ)` est partielle et n’est définie que lorsque `Adm(β,κ)` est satisfaite.

La valeur candidate demeure :

`Consume(β,κ) := β ⊖ Cost_Budget(κ)`.

D6 fixe le domaine conceptuel de l’opération, mais ne ratifie pas une définition exacte de `⊖` ni les lois arithmétiques nécessaires.

## Obligations ouvertes

1. Définir formellement `𝔅`, son ordre, le domaine de `Adm` et le domaine dépendant de `Consume`.
2. Normaliser le résidu `⊖`, notamment le traitement de `ω` et le cas `ω ⊖ ω`, qui fait l’objet de conventions candidates incompatibles dans la documentation source.
3. Définir séparément le domaine de `ψ` et établir comment elle applique la consommation lors d’un effet effectivement traversé.
4. Prouver les propriétés requises par les règles, et le lien entre coût annoncé, consommation et bornes d’exécution.

L’admissibilité statique ne suffit pas à elle seule à établir une garantie d’exécution. D6 ne rend pas `Consume` totale et ne permet pas de déduire que `ψ` est totale.

## Statut épistémique

D6 est décidée au niveau du contrat conceptuel. Aucune preuve Lean, validation par tests/CI ni garantie d’exécution n’est revendiquée. La porte C demeure **NON SATISFAITE**.
