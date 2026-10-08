<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 45 : test des candidats de Cost_Budget

**Date :** 7 octobre 2026

La séance 41 a isolé l'interface entre la famille temporelle de couples travail/profondeur et le
budget scalaire. La présente séance teste les scalarisations possibles sans en ratifier aucune.

## 1. Objet temporel

On pose

`κ : 𝓛 → (ℕ∞×ℕ∞)`,

avec, à chaque niveau, un travail `w` et une profondeur `s`.

Deux agrégats globaux sont immédiatement distinguables :

`W(κ)=Σ_ℓ w_ℓ` pour le travail total,

`D(κ)=sup_ℓ s_ℓ` pour une profondeur globale.

Les deux ne doivent pas être confondus avec le budget lui-même.

## 2. Scalarisation totale

Si `β` reste scalaire, une scalarisation naturelle qui borne simultanément les deux dimensions est

`Cost_MaxBoth(κ)=max(W(κ),D(κ))`.

Elle donne une condition suffisante `W≤β` et `D≤β`. Une scalarisation `W+D` serait également sûre
mais plus conservative.

La construction ne suffit pas à établir que cette fonction est la sémantique normative de K7PL.

## 3. Pourquoi le maximum seul ne suffit pas

Une fonction qui ne regarde que `D(κ)` ne borne pas le travail total ; une fonction qui ne regarde que
`W(κ)` ne borne pas la profondeur. Sous la lecture forte de P3, chacune serait donc insuffisante.

Le test ne départage pas `Cost_MaxBoth` d'une autre scalarisation dominante.

## 4. Architecture vectorielle alternative

On pourrait remplacer le porteur budgétaire scalaire par

`𝔅 = ℕ∞×ℕ∞`,

et définir la consommation composante par composante. Cette option aligne directement grade et effet,
mais modifie la signature du grade, le sous-typage, `⊖`, les conversions et les preuves déjà construites.

Aucune règle actuelle de `Box`, `App`, `SubBox`, substitution ou `Sc` ne force ce changement.

## 5. Verdict

**Établi :** le facteur temporel courant porte deux dimensions, travail et profondeur, par niveau.

**Établi :** le grade actuel porte encore un budget scalaire dans la définition normative retenue.

**Établi :** un budget scalaire nécessite une interface `Cost_Budget` qui agrège les deux dimensions.

**Non établi :** la scalarisation exacte du coût.

**Alternative ouverte mais plus intrusive :** budget vectoriel.

**Conclusion PR-02 :** conserver provisoirement le budget scalaire et l'interface `Cost_Budget` est
défendable et n'introduit pas de nouveau composant dans le grade. Le passage au budget vectoriel
doit être traité comme une décision architecturale séparée, non comme une conséquence de la comonade.
