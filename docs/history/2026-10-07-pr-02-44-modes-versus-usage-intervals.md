<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 44 : fermeture de la frontière modes / intervalles

**Date :** 7 octobre 2026

Les quatre domaines `U_Lin`, `U_Aff`, `U_Rel`, `U_Unr` ont été confrontés à la définition
structurelle des modes. Le résultat confirme une séparation des objets plutôt qu'une nouvelle
algèbre à introduire dans `𝒢`.

## 1. Intervalles d'usage

`U_Lin=[1..1]`, `U_Aff=[0..1]`, `U_Rel=[1..ω]`, `U_Unr=[0..ω]` sont des sous-ensembles du
semi-anneau d'usage `𝓡`.

Leurs inclusions sont des faits ensemblistes. Elles ne constituent ni l'ordre de sous-typage
des grades complets, ni les morphismes structurels des modes.

## 2. Modes structurels

Un mode est décrit par un triplet `(R_m,Cont(m),Weak(m))`. Dans l'instanciation candidate de K7PL,
les quatre modes utilisent le même porteur `𝓡` mais diffèrent par les permissions de contraction
et d'affaiblissement.

Les identités de `𝓡` réalisent les quatre flèches du diamant
`Lin→Aff`, `Lin→Rel`, `Aff→Unr`, `Rel→Unr`.

`Aff` et `Rel` restent incomparables.

## 3. Conséquence pour le grade complet

Le mode ne devient pas une cinquième composante de `𝒢`. Il détermine une discipline structurelle
sur l'usage ; le grade complet conserve ses quatre composantes.

Cette séparation évite deux erreurs symétriques : considérer les intervalles comme des algèbres
de modes, ou ajouter un composant de mode au quadruplet sans obligation des règles.

## 4. Statut

**Établi :** les intervalles d'usage et les modes sont des objets distincts.
**Fortement soutenu :** l'instanciation commune sur `𝓡` explique le diamant des permissions sans
modifier `𝒢`.
**Non établi :** l'existence d'un morphisme général de mode couvrant toutes les extensions futures.
Cette question relève des extensions de la discipline structurelle, pas du noyau actuel.