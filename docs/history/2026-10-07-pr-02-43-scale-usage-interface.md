<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 43 : interface explicite de `Scale_Usage`

**Date :** 7 octobre 2026

La factorisation de l'indice de l'exponentielle est maintenant accompagnée d'une action
contextuelle explicitement typée.

## 1. Signature

`Scale_Usage : 𝓡 × 𝒢 → 𝒢`

`Scale_Usage(a,<u,m,ℓ,β>) = <a·u,m,ℓ,β>`.

L'action agit uniquement sur l'usage. Elle laisse inchangés monotonie, niveau et budget.

## 2. Lois

Les lois minimales sont :

`SU(1,Δ)=Δ` ;

`SU(a,SU(b,Δ))=SU(a·b,Δ)` ;

`SU(a,Δ₁+Δ₂)=SU(a,Δ₁)+SU(a,Δ₂)` lorsque l'addition de contextes est définie ;

et la monotonie relativement à l'ordre de sous-typage.

Ces lois sont des conséquences de l'arithmétique du semi-anneau d'usage et de l'identité sur les
autres composantes. Elles ne définissent pas une multiplication globale du grade complet.

## 3. Portée

`Scale_Usage` est l'action pertinente pour `Box`, `App`, substitution et `Sc` sur le contexte.
`φ_n` reste une action séparée sur l'effet produit par une ré-invocation.

Le budget reste hors de cette action ; sa consommation relève de `ψ`/`Consume` lorsque le coût
temporel est correctement relié au budget.

## 4. Statut

**Établi algébriquement sur le candidat :** les lois de l'action d'usage.

**Fortement soutenu :** son emploi comme action contextuelle de référence.

**Non établi :** son statut normatif final avant clôture des conversions du grade complet et de la
substitution.