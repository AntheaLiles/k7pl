<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 50 : scalarisation canonique du budget

**Date :** 7 octobre 2026

Le test de la séance 48 laissait deux architectures : budget scalaire avec scalarisation, ou budget
vectoriel. La séance 50 précise ce que la première implique lorsque P3 est pris au pied de la lettre.

## 1. Les deux bornes temporelles

Pour `κ(ℓ)=⟨w_ℓ,s_ℓ⟩`, on distingue :

`W(κ)=Σ_ℓ w_ℓ`, le travail total ;

`D(κ)=sup_ℓ s_ℓ`, la profondeur globale.

P3 exige que les deux restent bornées. Une seule de ces quantités ne suffit donc pas.

## 2. La plus petite borne scalaire commune

Sous l'hypothèse que le budget reste un scalaire `β` et qu'il doit dominer simultanément les deux
quantités, le candidat minimal est :

`Cost^{min}_{𝔅}(κ)=max(W(κ),D(κ))`.

La minimalité est immédiate : toute scalarisation scalaire `C` qui vérifie
`W≤C` et `D≤C` vérifie nécessairement `max(W,D)≤C`.

Le candidat est donc le plus petit budget scalaire qui ne relâche aucune des deux contraintes.

## 3. Compatibilité avec les effets

Pour le séquencement, le travail est additif et la profondeur est sous-additive par rapport à la somme.
Pour la mise en parallèle, le travail est additif et la profondeur est gouvernée par le maximum.
Dans les deux cas :

`Cost^{min}_{𝔅}(κ₁ ∘ κ₂) ≤ Cost^{min}_{𝔅}(κ₁)+Cost^{min}_{𝔅}(κ₂)`,

pour la composition correspondante.

Le candidat est donc compatible avec une lecture du budget comme borne de coût, sans ajouter de
nouvel objet au grade.

## 4. Ce que cela ne décide pas

Cette propriété ne prouve pas que K7PL doit choisir cette scalarisation. Elle montre plutôt que,
si les décisions « budget scalaire » et « P3 borne simultanément travail et profondeur » sont conservées,
`Cost^{min}_{𝔅}` est la scalarisation canonique minimale.

Une autre scalarisation dominante serait plus conservative. Un budget vectoriel serait plus expressif,
mais constituerait une modification architecturale de `𝔅`.

## 5. Verdict

**Fortement soutenu :** l'architecture scalaire admet une scalarisation canonique minimale.

**Établi sous hypothèse :** cette scalarisation est `max(W,D)` lorsque `β` est une borne commune aux
deux dimensions.

**Non établi :** que la spécification impose explicitement le principe de minimalité.

**Position PR-02 :** conserver `𝔅=ℕ∞` et introduire `Cost^{min}_{𝔅}` comme candidat de référence,
sans le promouvoir encore au statut de définition normative.

La dette de l'objet `Cost_Budget` est ainsi réduite d'une indétermination de forme à une décision de
sémantique quantitative précisément formulée.