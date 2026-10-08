<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 46 : fermeture partielle des coercions du grade complet

**Date :** 7 octobre 2026

La séance 42 a factorisé la coercion du grade complet. La présente séance vérifie jusqu'où cette
factorisation peut être considérée comme acquittée sans inventer une structure de morphisme globale.

## 1. Décomposition

Pour `r ≼ r'`, les quatre composantes fournissent quatre transports :

`u ≥ u'` ;

`m ⪰ m'` ;

`ℓ ≤ ℓ'` ;

`β ≤ β'`.

Le transport complet peut donc être représenté comme un produit de quatre conversions.

Cette représentation n'exige pas que `𝒢` soit une grade algebra complète.

## 2. Identité et composition

Pour chaque composante, la conversion de `x` vers lui-même doit être l'identité.

Pour `r ≼ s ≼ t`, il faut :

`Conv(r,t)=Conv(s,t)∘Conv(r,s)`.

Sur les deux composantes purement étiquetées pour lesquelles la donnée sous-jacente ne change pas,
la cohérence est immédiate au niveau syntaxique.

Le cas réellement structurel est celui de l'usage, car la conversion agit sur la famille
`!_u`. L'interface C2 fournit précisément une famille de morphismes de coercion admissibles.

## 3. Ce que l'ordre ne prouve pas

Les jointures du produit des préordres garantissent l'existence des bornes supérieures d'annotations.
Elles ne prouvent pas que les conversions sémantiques associées soient fonctorielles.

Il faut encore vérifier la cohérence de la famille d'usage avec les lois de `w` et `c` de
l'exponentielle, et vérifier la monotonie des interprétations qui lisent directement le niveau ou le
budget.

## 4. Test sur `SubBox`

Le seul test nécessaire pour relier l'ordre complet à l'index de `!` est déjà acquis :

`r ≼ r' ⇒ π_U(r) ≥ π_U(r')`.

Ainsi, la coercion complète peut être factorisée en une coercion d'index d'usage et en transports
orthogonaux des autres annotations.

Aucune multiplication globale de `𝒢` n'est introduite par ce transport.

## 5. Statut

**Établi :** la factorisation composante par composante respecte la forme de l'ordre produit.

**Établi :** la projection d'usage conserve la direction de `SubBox`.

**Non établi :** la construction fonctorielle complète des conversions.

**Non établi :** la monotonie sémantique du niveau et du budget pour toutes les interprétations.

**Conclusion PR-02 :** la cohérence du grade complet n'est plus une question d'algèbre globale. Elle
se réduit désormais à la construction et à la vérification des conversions composante par composante,
dont l'usage constitue le seul cas dépendant de la comonade.
