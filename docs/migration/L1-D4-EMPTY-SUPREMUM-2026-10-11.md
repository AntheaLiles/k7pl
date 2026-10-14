<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Ratification D4 — supremum sur domaine vide

**Date :** 11 octobre 2026  
**Statut :** décision d’autrice consignée ; formalisation et preuves ouvertes.  
**Portée :** convention mathématique pour les agrégats budgétaires ; aucun changement normatif de `spec/` ou `src/`.

## Décision ratifiée

L’autrice retient l’option A : le domaine des niveaux peut être vide et le supremum de l’ensemble vide dans `ℕ∞` vaut zéro :

`sup ∅ = 0`.

Donc, si `ℒ=∅`, alors `D(κ)=sup_{ℓ∈ℒ}s_ℓ=0`. Pour `W(κ)=sup_{F⊆ℒ, F fini} Σ_{ℓ∈F}w_ℓ`, le domaine d’indexation contient toujours le sous-ensemble fini vide, et la somme sur ce sous-ensemble suit la convention de somme vide égale à zéro. D4 ne change pas la définition de `W` pour les autres sous-ensembles finis.

## Portée et limites

Cette convention complète la décision D3 de traiter `Cost_Budget : K → 𝔅` comme totale sous les hypothèses et conventions explicites rendant les agrégats bien définis. Elle n’établit pas à elle seule que la définition canonique de `K` autorise effectivement tous les cas considérés, ni que les codomaines et opérations de la formalisation actuelle réalisent cette convention.

Restent ouvertes :

1. définir canoniquement `K`, `ℒ` et les composantes travail/profondeur ;
2. formaliser `sup ∅=0` dans le codomaine `ℕ∞` retenu et vérifier les définitions de `W` et `D` ;
3. prouver les propriétés de composition/monotonie effectivement requises ;
4. spécifier `Adm`, `Consume` et le domaine de `ψ` ;
5. prouver le lien entre coût annoncé, budget consommé et respect effectif des bornes à l’exécution.

La frontière P3-B reste inchangée : l’attente environnementale de `When` est une latence d’orchestrateur, hors du coût d’exécution de l’automate déclenché.

## Statut épistémique

D4 est **décidée**. Aucune preuve Lean, validation par tests ou résultat CI n’est revendiqué par cette note. La porte C demeure **NON SATISFAITE**.
