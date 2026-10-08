<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 61 : clôture de la loi de transport des coercions graduées

**Date :** 7 octobre 2026

Les séances 56 et 57 avaient localisé la dernière dette de cohérence du sous-typage. Il faut
maintenant distinguer la conversion d'une annotation de grade, la conversion du constructeur `!` et
la conversion d'un contexte entier.

## 1. Transport d'une annotation

Pour

`r = ⟨u,m,ℓ,β⟩` et `r'`

avec `r ≼ r'`, le transport d'une liaison conserve son support syntaxique et remplace seulement son
annotation :

`ConvCtx(r,r') : x:_r V ↦ x:_r' V`.

Ce transport ne constitue pas une opération du grade. C'est une action sur le jugement.

## 2. Lois de la conversion de contexte

La conversion composante par composante doit vérifier :

`ConvCtx(r,r)=id`

et

`ConvCtx(r,t)=ConvCtx(s,t)∘ConvCtx(r,s)`

pour `r≼s≼t`.

Comme le contexte ne change ni la variable ni le type sous-jacent, ces deux lois sont
définitionnelles dès lors que le sous-typage est interprété comme un simple changement
d'annotation.

Le véritable point sémantique demeure la conversion des types qui portent ces annotations, en
particulier `!`.

## 3. Transport du constructeur `!`

Sous la factorisation

`π_U : 𝒢 → 𝓡,`

la conversion du constructeur exponentiel est :

`Conv!_{r,r',A}=coerce_{π_U(r),π_U(r'),A}.`

La direction est légitime parce que :

`r≼r' ⇒ π_U(r)≥π_U(r').`

Les composantes `m`, `ℓ` et `β` restent des annotations statiques du grade complet. Elles ne
requièrent donc pas de morphisme supplémentaire dans le noyau de `!` ; leur changement est porté par
`ConvCtx` ou par les règles de sous-typage qui les consultent.

## 4. Compatibilité avec `Scale_Usage`

Pour un scalaire d'usage `a`, on a :

`Scale_Usage(a,r)=⟨a·u,m,ℓ,β⟩.`

La propriété nécessaire au passage de la substitution est :

`r≼r' ⇒ Scale_Usage(a,r)≼Scale_Usage(a,r').`

Elle découle de la monotonie de la multiplication dans `𝓡` :

`u≥u' ⇒ a·u≥a·u'.`

Le transport de contexte commute alors avec l'action :

`ConvCtx(Scale_Usage(a,r),Scale_Usage(a,r')) ∘ Scale_Usage(a,-)`
`= Scale_Usage(a,-) ∘ ConvCtx(r,r').`

Cette égalité est une égalité de relabellisation du contexte ; elle ne présuppose aucune
multiplication sur `𝒢`.

## 5. Compatibilité avec `!`

Pour le constructeur exponentiel, la condition restante est la naturalité de la famille `coerce` :

`coerce_{u,u'',A}
= coerce_{u',u'',A} ∘ coerce_{u,u',A}`

et

`coerce_{u,u,A}=id.`

La compatibilité avec `w` et `c` est celle de l'interface comonadique indexée :

- la counité est naturelle au neutre `0` ;
- la comultiplication respecte la décomposition `u+v` ;
- les coercions admises ne changent pas le support sous-jacent.

Ces propriétés portent sur `𝓡` et `!`, non sur les quatre composantes de `𝒢`.

## 6. Conséquence pour `Sub` et `SubBox`

`Sub` peut maintenant être lu comme la fermeture du jugement par un transport `ConvCtx` ou par
une conversion de constructeur.

`SubBox` est l'instance particulière :

`!_r V <: !_r' V`

dont le transport sous-jacent est `Conv!`.

Les jointures du produit mixte restent utiles pour relever deux bornes vers une même annotation,
mais elles ne participent plus à la construction de la conversion elle-même.

## 7. Statut

**Établi au niveau syntaxique :** le transport d'une annotation est une relabellisation du jugement
et vérifie identité/composition.

**Établi algébriquement :** `Scale_Usage` préserve la relation `≼` sur le domaine d'usage.

**Fermé comme interface :** le transport de `!` est exactement `coerce` sur `𝓡`.

**Obligation externe restante :** démontrer ou assumer explicitement les lois de naturalité de
`coerce`, `w` et `c` de la comonade graduée.

Cette obligation appartient désormais au modèle catégorique de `!`. Elle ne remet pas en cause
l'architecture du grade complet.
