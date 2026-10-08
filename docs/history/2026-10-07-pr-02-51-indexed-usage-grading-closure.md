<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 51 : clôture minimale de la gradation d'usage

**Date :** 7 octobre 2026

La séance 50 a réduit le problème budgétaire à une scalarisation encore conditionnelle. La séance 51
réduit de même la dette de gradation indexée à un petit ensemble de lois explicites.

## 1. Support retenu

Le support effectif de la comonade est le semi-anneau d'usage `𝓡`, et non le grade complet `𝒢`.

Le constructeur syntaxique `!_r A` se factorise par `π_U : 𝒢 → 𝓡`, sans effacer `r` du jugement.

## 2. Lois minimales

Pour les indices d'usage, la cohérence requiert :

`coerce_{u,u}=id` ;

`coerce_{u,w}=coerce_{v,w} ∘ coerce_{u,v}` ;

une comultiplication `c_{u,v}:!_{u+v}A→!_uA⊗!_vA` ;

une counité `w:!_0A→A`.

Les compatibilités de naturalité, de `c` avec l'addition et de `w` avec le neutre sont les obligations
usuelles de l'interface comonadique.

## 3. Liaison au grade complet

Les règles de K7PL ajoutent seulement :

- `r≼r' ⇒ π_U(r)≥π_U(r')` ;
- `Box`, `App` et substitution utilisent `Scale_Usage(π_U(r),−)` ;
- les composantes monotonie, niveau et budget conservent leurs conversions propres.

Aucune multiplication globale de `𝒢` n'est nécessaire.

## 4. Verdict

**Établi au niveau architectural :** le noyau des obligations de gradation indexée est fini et localisé.

**Non établi :** la fonctorialité sémantique complète des conversions du grade et la preuve finale de substitution.

**Conclusion PR-02 :** la dette « gradation indexée » n'est plus une question de choix d'algèbre de
support ; elle devient une obligation de preuve sur l'interface `𝓡` et ses conversions.