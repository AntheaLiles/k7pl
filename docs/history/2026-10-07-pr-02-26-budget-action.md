<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 26 : statut algébrique du budget

**Date :** 7 octobre 2026

Le facteur budget doit être distingué de l'algèbre de composition des grades. K7PL lui attribue
`ℕ∞`, avec une addition et une multiplication utilisées pour certaines bornes, mais `ψ` le traite
par une opération supplémentaire `⊖` qui représente la consommation d'un coût temporel.

## 1. Ce qui est établi

`β` appartient à `ℕ∞` et la consommation est donnée par

`β ⊖ k = ω` si `β = ω`, `0` si `β < k`, et `β-k` sinon.

Le choix `ω ⊖ ω = ω` n'est pas celui du résidu de l'addition standard. Il est motivé par la lecture
de `β` comme borne et non comme quantité exactement disponible : une borne infinie ne doit pas
être artificiellement transformée en budget nul par une consommation infinie.

La multiplication et l'addition de `ℕ∞` restent utiles, mais elles ne déterminent pas `⊖`.

## 2. Conséquence pour l'architecture globale

Pour qu'un grade complet `𝓖` soit une grade algebra globale, il faut donc distinguer au moins :

- l'addition et la multiplication servant à composer les grades ;
- l'ordre servant à `≼` ;
- l'opération partielle de consommation servant à `ψ`.

Le fait que `Budget = ℕ∞` soit une grade algebra potentielle ne suffit pas à produire la loi de
cohérence. Il faut encore démontrer la compatibilité entre l'action de mise à l'échelle et `⊖`
dans le domaine réellement utilisé.

## 3. Contre-exemple déjà établi

Pour une multiplicité d'exécution `ω` et un coût `k ≠ 0`, la loi

`ω · (β ⊖ k) = (ω · β) ⊖ (ω · k)`

échoue pour des `β,k` finis distincts. Le problème n'est pas une mauvaise convention sur
`ω ⊖ ω` : deux choix de `β` imposent deux valeurs contradictoires à cette expression.

Cette observation interdit de généraliser la loi de cohérence au cas d'un scalaire d'exécution
infini traversant un effet de coût non nul.

## 4. Conséquence pour `r·Δ`

Le même symbole `r·Δ` ne peut donc pas être défini seulement par une multiplication du budget.
Il faut une action typée qui indique comment le scalaire transforme chaque composante et comment le
budget réagit au transport de l'effet.

Pour un scalaire de multiplicité finie `n`, la loi budgétaire candidate est

`n(β ⊖ k) = nβ ⊖ nk`.

Pour `n = ω`, la loi est restreinte lorsque `k ≠ 0`. Pour `u = 1/N`, il n'existe pas encore de
lecture légitime sans définir une action distincte du grade d'usage sur le budget.

## 5. Comparaison des architectures

A peut conserver `Budget` comme grade algebra et ajouter `⊖` comme structure résiduelle externe.
C peut faire exactement la même chose mais localiser l'action de consommation dans le seul facteur
budget, au lieu de prétendre que `⊖` est une opération du grade complet.
B laisse cette structure orthogonale au support de la comonade `!_u`.
D permet de l'encapsuler dans la structure multi-objet, mais sans supprimer le besoin de cette loi.

Le budget ne permet donc pas à lui seul de choisir A, B, C ou D. Il fournit en revanche un test de
cohérence commun aux quatre architectures.

## 6. Résultat

Le budget est maintenant caractérisé comme une structure quantitative enrichie d'une opération de
consommation. Cette opération doit rester distincte de l'addition, de la multiplication et de la
relation de sous-typage.

Le prochain test doit porter sur `Scale × Budget` et `Scale × Level` séparément, afin de déterminer
si une même classe de scalaires peut agir sur ces deux composantes ou si les deux doivent être
kindées indépendamment.