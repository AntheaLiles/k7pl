<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 42 : factorisation des coercions du grade complet

**Date :** 7 octobre 2026

La subsomption sur le grade complet est maintenant confrontée à l'architecture factorisée de
l'exponentielle. Le résultat ne transforme pas la relation `𝒢`, mais précise où doit vivre sa
cohérence.

## 1. Relation de grade

`r ≼ r'` est défini composante par composante :

`u ≥ u'`, `m ⪰ m'`, `ℓ ≤ ℓ'`, `β ≤ β'`.

Cette relation reste une relation sur le grade complet. Elle ne doit pas être remplacée par l'ordre
de l'indice de `!`.

## 2. Projection sur l'exponentielle

La projection d'usage donne :

`r ≼ r' ⇒ π_U(r) ≥ π_U(r')`.

C'est exactement la direction nécessaire pour la coercion d'usage de `!`. La propriété est donc
structurelle et ne dépend pas d'un ordre global supplémentaire sur `𝒢`.

## 3. Factorisation candidate de la coercion

Une conversion du grade complet peut être conceptuellement décomposée en deux parties :

1. une coercion de l'indice d'usage, réalisée par la famille de morphismes de la comonade ;
2. un transport des composantes de mode, niveau et budget dans l'annotation complète.

Ces deux parties doivent être compatibles avec les constructeurs de types. Pour les trois composantes
qui ne modifient pas la valeur sous-jacente du grade, le transport peut être l'identité sur la donnée
sous-jacente avec changement d'étiquette. Pour l'usage, il faut vérifier les morphismes de la comonade
et leurs lois d'identité et de composition.

## 4. Ce que les jointures établissent et n'établissent pas

Les quatre préordres possèdent les jointures nécessaires au produit. Cela suffit pour former une borne
supérieure de deux annotations, mais pas pour conclure à la cohérence des conversions.

Il faut encore :

`Conv(r,r)=id`, et `Conv(r,t)=Conv(s,t)∘Conv(r,s)` lorsque `r ≼ s ≼ t`.

Dans une catégorie mince, ces lois sont les lois de fonctorialité du transport associé à l'ordre.
Le produit des quatre systèmes les conserve si chaque composante est cohérente.

## 5. Statut

**Établi :** l'ordre du grade complet et l'ordre de l'indice `!` sont distincts.
**Établi :** la projection d'usage conserve la direction de `SubBox`.
**Fortement soutenu :** les coercions du grade complet peuvent être traitées par factorisation
plutôt que par une structure de morphisme globale unique.
**Non établi :** la construction concrète et fonctorielle des quatre familles de conversions.
**Non établi :** la compatibilité détaillée de ces conversions avec tous les constructeurs de types.

Cette dette est désormais plus localisée que la question initiale : elle ne porte plus sur l'existence
de l'ordre produit, mais sur le transport sémantique associé à cet ordre.