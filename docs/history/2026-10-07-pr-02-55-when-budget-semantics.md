<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 55 : test décisif de `When` et du budget

**Date :** 7 octobre 2026

La règle `When` transforme la composante temporelle en une borne non bornée. La clôture du budget
permet maintenant d'en tirer une conséquence précise.

## 1. Transformation temporelle

La règle utilise

`ε[ω/k]`

et remplace la famille temporelle par

`κ_ω(ℓ)=⟨ω,ω⟩`

à tous les niveaux.

## 2. Conséquence budgétaire

Sous la scalarisation

`Cost_Budget(κ)=max(W(κ),D(κ))`

on obtient

`Cost_Budget(κ_ω)=ω`.

Le budget scalaire ne peut donc pas rester fini si cette borne représente effectivement le temps
d'exécution promis par P3.

## 3. Deux lectures possibles

Lecture A : l'attente environnementale est une composante du coût temporel de P3. Alors `When` doit
être incompatible avec un budget fini, directement ou par une condition équivalente. La règle actuelle
ne le dit pas explicitement, puisqu'elle conserve `Δ₁ ⊠₁ □Δ₂` et ne consomme pas le budget.

Lecture B : l'attente environnementale n'est pas une consommation du calcul et `κ_ω` représente une
borne de latence observable mais pas une dépense du budget. Alors `Cost_Budget` ne peut pas être
défini comme une borne de tout le facteur temporel sans distinguer cette dimension de l'exécution.

Les deux lectures sont cohérentes localement, mais elles ne produisent pas la même sémantique du
budget. P3 doit donc décider laquelle est retenue.

## 4. Test architectural

Ce cas ne remet pas en cause `𝒢→𝓡→!`. Il teste seulement l'interface orthogonale entre la famille
temporelle `κ` et le budget `β`.

Il fournit en revanche un critère de fermeture : la définition de `Cost_Budget` ne sera ratifiée que
lorsque la spécification aura explicitement choisi si l'attente externe entre dans la borne P3.

## 5. Verdict

**Établi :** `When` produit une borne temporelle non bornée et, sous `Cost_Budget=max(W,D)`, un coût
scalaire `ω`.

**Ouvert :** statut de l'attente environnementale par rapport à P3 et donc compatibilité de `When`
avec un budget fini.

**Non affecté :** support de `!`, grade complet et `Scale_Usage`.

Cette question est désormais le dernier test sémantique réellement susceptible de modifier la
définition de `Cost_Budget`; elle ne justifie pas une réouverture de l'architecture du grade.