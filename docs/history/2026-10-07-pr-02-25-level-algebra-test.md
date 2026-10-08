<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 25 : test du facteur de niveau contre l'algèbre globale

**Date :** 7 octobre 2026

Cette séance teste l'obstruction la plus concrète à l'architecture A. Le produit `𝓖` est licite
comme grade algebra seulement si chacune de ses composantes porte effectivement une structure
de grade algebra. Or la spécification actuelle décrit `ℒ` comme un treillis de niveaux, pas comme
un semi-anneau.

## 1. Fait établi dans la littérature

Les grade algebras sont des semi-anneaux ordonnés : l'addition est un monoïde commutatif à zéro,
la multiplication un monoïde à unité, les deux sont distributives, le zéro est absorbant et les
opérations sont monotones. Une structure de treillis distributif peut être équipée d'une telle
algèbre, avec joint comme addition et rencontre comme multiplication. Le produit de grade algebras
est alors encore une grade algebra. (Bianchini et al., ECOOP 2023.)

Ce résultat est important pour K7PL : il montre qu'A n'est pas fausse par principe. Mais il montre
aussi la condition exacte qui manque : le treillis `ℒ` doit recevoir une structure multiplicative
et distributive compatible avec la signification de la confidentialité.

## 2. État actuel de K7PL

La spécification emploie actuellement `ℒ` pour ordonner les niveaux de confidentialité et utilise
son joint `⊔` dans la précision et dans certaines combinaisons de grades. Elle ne définit pas encore
une opération correspondant à une multiplication de grades sur `ℒ`, ni une unité et un zéro propres
à une grade algebra de niveau.

En conséquence, on peut établir l'ordre de la composante de niveau et les jointures requises par
`≼` et `⊑`, mais on ne peut pas encore affirmer que la composante de niveau participe à un
semi-anneau global sur `𝓖`.

## 3. Test sémantique de la solution par treillis distributif

Une réparation possible serait de définir sur `ℒ`

`a +_L b = a ⊔ b` et `a ×_L b = a ⊓ b`.

Cette construction est algébriquement naturelle lorsqu'`ℒ` est un treillis distributif borné.
Mais elle ne peut être retenue simplement parce qu'elle existe : il faut montrer que ces deux
opérations ont une interprétation correcte pour la confidentialité de K7PL.

Le problème est particulièrement visible pour la mise à l'échelle. Si l'action par un scalaire
est censée être l'identité sur le niveau, alors le produit global ne peut pas utiliser `×_L`
comme une multiplication ordinaire sans préciser comment cette structure interagit avec l'action.
Si l'action transforme le niveau, il faut au contraire démontrer que cette transformation respecte
la sémantique du flot d'information et la direction `ℓ ≤ ℓ'` du sous-typage.

Le choix entre ces deux lectures n'est pas résolu par la seule littérature sur les grade algebras.

## 4. Conséquence pour A et l'architecture hybride

A reste mathématiquement viable sous une hypothèse supplémentaire : `ℒ` doit être enrichi d'une
structure algébrique compatible, et cette structure doit ensuite être raccordée à l'action de mise à
l'échelle et à `φ`/`ψ`.

L'architecture hybride évite cette obligation tant qu'aucune règle n'exige une multiplication du
niveau. Elle conserve `ℒ` comme qualification ordonnée et lui impose seulement les opérations dont
le jugement a réellement besoin.

Ce n'est pas une preuve que l'hybride est meilleur. C'est une différence d'engagement : A ajoute
une hypothèse algébrique sur `ℒ` ; l'hybride ne l'ajoute pas avant nécessité.

## 5. Test falsifiant suivant

Il faut maintenant vérifier les quatre opérations effectivement réclamées par le noyau :

`join_L`, `meet_L`, `scale_q_L`, et la conversion induite par `≼`.

Le résultat attendu est l'un des deux suivants :

- soit les opérations utilisées par K7PL se factorisent toutes sur une structure de treillis
  distributif et l'algèbre globale A devient économiquement défendable ;
- soit `scale_q_L` est soit triviale, soit absente du jugement, et la structure algébrique complète
  de `ℒ` n'apporte rien à la preuve, ce qui renforce l'architecture hybride.

## 6. Statut

Le facteur de niveau est donc désormais un test discriminant explicite de A. Aucune décision normative
n'est encore prise. Le prochain travail porte sur les signatures de `scale_q_L` et `scale_q_B`,
car le niveau et le budget sont les deux composantes qui empêchent aujourd'hui de traiter le grade
complet comme un scalaire homogène sans hypothèses supplémentaires.

## Référence

Bianchini, Riccardo; Dagnino, Francesco; Giannini, Paola; Zucca, Elena. *Multi-Graded Featherweight
Java*. ECOOP 2023. LIPIcs 263. DOI 10.4230/LIPIcs.ECOOP.2023.3.