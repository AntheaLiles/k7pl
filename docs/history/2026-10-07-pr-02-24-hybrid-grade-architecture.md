<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 24 : vers une architecture hybride des grades

**Date :** 7 octobre 2026

Les séances 21 à 23 ont établi deux faits apparemment contradictoires : le produit `𝓖` peut être
algébriquement licite si chaque facteur reçoit une structure de grade-algebra, mais K7PL ne donne
actuellement à certaines composantes que des ordres. L'hypothèse testée ici consiste à ne pas
transformer artificiellement chaque qualification en scalaire.

## 1. Rappel de la contrainte algébrique

Un grade algebra au sens de Bianchini et al. est un semi-anneau ordonné : addition commutative avec
zéro, multiplication avec unité, distributivité, annihilation par zéro et monotonie des opérations.
Le produit de plusieurs grade algebras est alors à nouveau un grade algebra.

Cette construction valide l'existence abstraite d'un produit, mais elle ne transforme pas un simple
ordre en grade algebra. En particulier, la composante `Level` de K7PL est actuellement décrite comme
un treillis de niveaux. Un treillis générique ne fournit pas à lui seul le semi-anneau requis par
cette définition ; il faut au minimum une structure multiplicative compatible, et le cas standard
du treillis comme grade algebra utilise une structure de treillis distributif.

Le même problème ne se pose pas de façon identique pour `Mono`, qui est une chaîne à deux éléments,
ni pour `Usage` et `Budget`, dont des structures algébriques sont déjà spécifiées.

## 2. Hypothèse hybride

Le grade syntaxique peut être considéré comme une annotation structurée

`r = ⟨g,m,ℓ,β⟩`

dont toutes les composantes ne sont pas nécessairement des scalaires du même système.

`Usage` et `Budget` peuvent porter des opérations quantitatives ; `Mono` et `Level` peuvent rester
des qualifications structurelles tant qu'aucune opération scalaire plus riche n'est nécessaire.

L'action utilisée par une règle doit alors indiquer explicitement quelles composantes elle transforme.
Elle peut avoir une forme générale

`Act_q : Grade → Grade`

avec un domaine de scalaires `q` propre à la règle.

Cette formulation est plus faible que l'affirmation actuelle « `r·Δ` multiplie les grades » et plus
forte qu'un simple sucre syntaxique : elle impose de donner le domaine et l'action de chaque opération.

## 3. Application au noyau

Pour `Box` et `App`, le scalaire est l'annotation portée par la fonction ou la boîte. Il faut donc
une action capable de transformer le contexte argument.

Pour `SubBox`, le grade complet reste en revanche le domaine de la relation `≼`. Les quatre
qualifications peuvent continuer à participer au sous-typage sans être toutes des composantes
multiplicatives d'une même algèbre.

Pour `VecI`, `VecE` et `Sc`, le scalaire est `n`. Une action de `ℕ∞` par itération peut alors être
traitée séparément, sous réserve des opérations effectivement nécessaires sur chaque composante.

Pour la loi distributive, `φ` ne devrait être invoquée que depuis un domaine de scalaires dont l'action
sur les effets est définie. Cela permet de traiter les grades d'usage rationnels comme des quantités
de ressource sans leur attribuer une interprétation d'exécution fractionnaire.

## 4. Comparaison avec GRASS et les grades hétérogènes

Cette architecture est proche, mais non identique, à GRASS. GRASS associe à chaque mode une algèbre
de grades et définit la multiplication d'un scalaire sur un vecteur par transport à travers les
morphismes entre modes. La notion de vecteur de grades est donc hétérogène, mais chaque entrée reste
dans une structure algébrique déterminée.

Le modèle de Bianchini et al. est également pertinent : une famille de grade algebras et de
homomorphismes suffit à construire des grades hétérogènes. Ces travaux montrent que l'hétérogénéité
peut être traitée formellement ; ils ne montrent pas que les qualifications `Mono` et `Level` de
K7PL doivent être transformées en grade algebras.

## 5. Test falsifiant

L'hypothèse hybride sera rejetée si l'analyse du fragment minimal démontre qu'une seule opération
globale sur `𝓖` est nécessaire pour conserver la contraction, la subsomption et la substitution.
Elle sera également rejetée si ses actions partielles imposent davantage de coercions ou de règles
spécifiques que l'algèbre globale.

Elle sera favorisée si elle permet de conserver `u = 1/N`, de séparer `Usage` et `Exec`, et de donner
des signatures locales plus simples à `r·Δ`, `φ` et `ψ` sans changer le comportement observé des
règles.

## 6. Statut

Il ne s'agit pas d'une nouvelle architecture normative. C'est une hypothèse de modélisation qui
précise l'architecture C de la séance 22. Elle devient le candidat de comparaison principal contre
A pour le fragment minimal.

Le prochain livrable est donc une formalisation très petite des deux signatures :

`GlobalGrade : Grade × Grade → Grade` et `Scale : Scalar(kind) × Grade → Grade`.

Le premier modèle teste si `GlobalGrade` peut satisfaire toutes les règles avec les lois déjà
postulées ; le second teste si les mêmes règles peuvent être typées avec des scalaires kindés et des
morphismes explicites. La comparaison portera sur les hypothèses, pas sur le nombre de lignes de code.

## Références

Bianchini, Riccardo; Dagnino, Francesco; Giannini, Paola; Zucca, Elena. *Multi-Graded Featherweight
Java*. ECOOP 2023. DOI 10.4230/LIPIcs.ECOOP.2023.3.

Hanukaev, Peter; Eades, Harley. *A Unification of Graded and Substructural Logics*. 2026.
DOI 10.48550/ARXIV.2605.17112.

Fukihara, Yōji; Katsumata, Shin-ya. *Generalized Bounded Linear Logic and Its Categorical Semantics*.
FoSSaCS 2021. DOI 10.1007/978-3-030-71995-1_12.