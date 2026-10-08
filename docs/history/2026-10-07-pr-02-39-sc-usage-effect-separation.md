<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 39 : fermeture du cas `Sc` par séparation contexte/effet

**Date :** 7 octobre 2026

La séance 38 avait conservé un candidat `Scale_Exec` agissant sur le grade complet pour les
répétitions effectives. L'examen direct de la règle `Sc` montre que cette action n'est pas requise
par le langage actuel.

## 1. Lecture exacte de `Sc` 

La règle porte simultanément :

`n · Δ₂`

sur le contexte, et

`f(ε_c) = (φ_n ∘ π_S)(ε_c)`

sur l'effet.

Or `n∈ℕ∞⊂𝓡`. L'action sur le contexte peut donc être l'action d'usage déjà retenue :

`Scale_Usage(n,Δ₂)`.

L'effet transformé par `φ_n` est un objet distinct. Il représente la répétition ou la transformation
effective du calcul à portée ; il n'est pas une instruction de mise à l'échelle du budget porté par
chaque liaison.

## 2. Conséquence sur le budget

Sous cette lecture, `Scale_Usage` laisse `β` inchangé. La consommation budgétaire est ensuite
déterminée lorsque l'effet `φ_n(ε_c)` traverse un contexte par `ψ`.

Pour une composante temporelle de coût `k`, c'est alors `ψ` qui applique la consommation
correspondante au budget. Il n'est pas nécessaire de multiplier préalablement `β` par `n`.

La loi `n(β ⊖ k)=nβ ⊖ nk` reste pertinente pour une autre architecture qui voudrait faire agir
directement une multiplicité sur le budget. Elle n'est plus requise pour justifier la règle `Sc` sous
l'architecture factorisée.

## 3. Révision du statut des scalaires

La taxonomie est donc plus simple :

`Usage` est la sorte des scalaires qui mettent un contexte à l'échelle ;

`n∈ℕ∞⊂𝓡` peut être un scalaire d'usage lorsqu'il apparaît devant un contexte ;

`φ_n` est une action sur les effets liée à la répétition effective ;

aucune action `Scale_Exec` sur `𝒢` n'est nécessaire dans le fragment actuellement défini.

La distinction `Usage/Exec` demeure donc conceptuellement utile, mais elle porte sur la distinction
entre l'action contextuelle et l'action sur les effets, non sur deux multiplications concurrentes du
grade complet.

## 4. Effet sur la substitution

Dans le cas `Sc`, la preuve de substitution utilise la même loi d'usage que `Box`, `App` et
les autres constructeurs qui mettent un contexte à l'échelle. La transformation `φ_n` intervient
ensuite dans le calcul de l'effet de conclusion.

La preuve n'a donc plus besoin d'une loi uniforme reliant une mise à l'échelle complète du grade à
une transformation de l'effet.

## 5. Statut

**Établi au niveau de l'analyse des règles :** aucune règle actuelle ne réclame une action
`Scale_Exec`` sur le grade complet.

**Résultat fortement soutenu :** `Sc` est compatible avec `Scale_Usage(n,-)` pour le contexte et
`φ_n` pour l'effet, les deux opérations restant séparées.

**Conséquence :** le budget n'est pas multiplié par `n` lors de la formation du contexte de `Sc`.

**Réserve :** une extension future qui ferait du budget une quantité consommée par une multiplicité
avant production de l'effet pourrait nécessiter une action supplémentaire ; ce n'est pas le langage
actuel.

Cette analyse remplace donc le candidat `Scale_Exec` de la séance 38 comme architecture de
référence pour `Sc`.