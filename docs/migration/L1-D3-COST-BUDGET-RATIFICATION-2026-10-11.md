<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Ratification D3 — totalité de `Cost_Budget`

**Date :** 11 octobre 2026  
**Statut :** décision d’autrice consignée ; obligations mathématiques et de preuve ouvertes.  
**Portée :** interface de coût budgétaire, sans modification normative de `spec/` ou `src/`.

## Décision ratifiée

L’autrice retient l’option A : `Cost_Budget` est une fonction totale sous les hypothèses et conventions explicites nécessaires à la définition des agrégats :

`Cost_Budget : K → 𝔅`

`Cost_Budget(κ) = max(W(κ), D(κ))`.

Cette décision tranche le statut total/partiel de `Cost_Budget`. Elle n’autorise pas à laisser la flèche partielle dans les registres comme si le choix restait ouvert ; l’harmonisation des sources normatives est une modification distincte à instruire et autoriser.

## Hypothèses et questions qui restent explicites

- `W(κ)=sup_{F⊆ℒ, F fini} Σ_{ℓ∈F}w_ℓ` doit être défini sur le domaine canonique de `κ`, avec une convention explicite pour l’ensemble fini vide.
- `D(κ)=sup_{ℓ∈ℒ}s_ℓ` requiert une convention si `ℒ` est vide, ou une hypothèse ratifiée que `ℒ` est non vide. D3 ne tranche pas cette alternative.
- Les codomaines, l’ordre complet utilisé pour les supremums, et l’existence de `max` doivent être explicités dans la formalisation.
- La totalité de `Cost_Budget` ne rend pas automatiquement totales `Adm`, `Consume` ou `ψ` au sens de leurs opérations : `Consume` et `ψ` peuvent être partielles selon leurs propres préconditions.

## Obligations de preuve maintenues ouvertes

1. Définir le domaine canonique `K`, les composantes temporelles et les conventions d’agrégation.
2. Établir que `W` et `D` sont bien définies dans `𝔅=ℕ∞`, puis que `max(W,D)` l’est sur tout `K`.
3. Prouver les propriétés de composition / monotonie effectivement invoquées par la spécification, sans les déduire de la seule ratification.
4. Spécifier `Adm`, le domaine de `Consume`, la soustraction tronquée et le domaine de `ψ`.
5. Prouver le lien entre coût annoncé, budget consommé par traversée et respect effectif des bornes à l’exécution, sous hypothèses explicites.

L’attente environnementale de `When` reste une latence d’orchestrateur hors du coût d’exécution de l’automate déclenché, conformément à P3-B. Cette décision ne modifie ni cette frontière ni les contrats d’orchestration encore ouverts.

## Statut épistémique

D3 est **décidée**. Les définitions canoniques, conventions de supremum, théorèmes, mécanisation Lean, validation par tests et CI restent des tâches distinctes. Cette note ne ferme ni C-01/C-02, ni la porte C globale, qui demeure **NON SATISFAITE**.
