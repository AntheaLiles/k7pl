<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 48 : test du porteur budgétaire face au coût travail/profondeur

**Date :** 7 octobre 2026

La révision de la temporalité normative établit désormais que l'effet porte, à chaque niveau, un
couple travail/profondeur. Le budget de la liaison reste quant à lui une composante scalaire
`β ∈ 𝔅 = ℕ∞`. Cette séance teste si ce choix peut être conservé sans ambiguïté.

## 1. Architecture A — budget scalaire conservé

Le choix actuel impose une scalarisation :

`Cost_Budget : (ℕ∞×ℕ∞)^ℒ ⇀ ℕ∞`.

Pour une famille `κ`, on peut distinguer au moins deux agrégats temporels :

`W(κ) = Σ_ℓ w_ℓ` pour le travail total,

`D(κ) = sup_ℓ s_ℓ` pour une profondeur globale.

Une scalarisation sûre qui borne séparément les deux serait par exemple

`Cost_MaxBoth(κ) = max(W(κ), D(κ))`.

Elle conserve un budget scalaire mais couple les deux contraintes dans une seule ressource. Une valeur
β qui suffit à `Cost_MaxBoth` garantit simultanément `W ≤ β` et `D ≤ β`.

Cette construction n'est toutefois pas imposée par P3. Une somme `W+D` serait également sûre mais
plus conservative, tandis qu'un seul des deux agrégats ne satisferait pas une lecture forte de P3.

## 2. Architecture B — budget vectoriel

Une alternative consiste à remplacer `𝔅 = ℕ∞` par `𝔅 = ℕ∞×ℕ∞` et à définir `⊖` composante par
composante. Cette architecture rend la correspondance avec travail et profondeur directe.

Elle a cependant un coût théorique important : la signature du grade change, le sous-typage doit
porter un ordre produit supplémentaire, la consommation devient vectorielle et toutes les lois
arithmétiques déjà écrites pour `β` doivent être redéfinies.

Aucune règle actuelle de `Box`, `App`, `SubBox`, substitution ou `Sc` ne force ce changement de
porteur.

## 3. Test décisif

Le langage actuel ne permet donc pas de conclure que `𝔅 = ℕ∞` est faux. Il permet seulement de
conclure que cette architecture n'est complète qu'après définition d'une scalarisation
`Cost_Budget` qui respecte les propriétés de correction attendues.

Inversement, le choix vectoriel est conceptuellement plus direct pour P3, mais il n'est pas requis
par la grammaire des grades actuellement retenue.

Le choix entre A et B est donc un choix de représentation sémantique du budget, pas une conséquence
de la comonade, de `Scale_Usage` ou de `SubBox`.

## 4. Statut

**Établi :** le facteur temporel normatif est une famille de couples travail/profondeur.

**Établi :** `Scale_Usage` n'impose aucune transformation du budget.

**Établi :** un budget scalaire nécessite une interface `Cost_Budget` pour agréger les deux
dimensions temporelles.

**Non établi :** la scalarisation normative du coût.

**Alternative ouverte mais plus intrusive :** budget vectoriel.

**Conclusion PR-02 :** conserver provisoirement `𝔅 = ℕ∞` comme porteur normatif et traiter
`Cost_Budget` comme obligation sémantique est défendable ; passer à un budget vectoriel serait une
décision architecturale nouvelle, actuellement non imposée par les règles.

Cette conclusion permet de ne pas rouvrir artificiellement l'algèbre globale du grade : la question
reste localisée dans la relation entre effet temporel et budget.