<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 54 : fermeture sémantique du budget scalaire

**Date :** 7 octobre 2026

La séance 53 avait isolé la dernière ambiguïté budgétaire : l'opération arithmétique `⊖` est totale,
tandis que la consommation sémantique est partielle lorsque la borne finie est insuffisante. La
présente séance sépare ces deux notions et précise les lois nécessaires de `Cost_Budget`.

## 1. Admissibilité de la consommation

Pour un budget `β` et un effet de coût `κ`, notons

`k = Cost_Budget(κ)`.

La consommation admissible vérifie :

`Adm(β,κ) := (β=ω) ∨ (k≤β)`.

Sur ce domaine,

`Consume(β,κ)=β⊖k`.

L'opération `⊖` reste l'opération arithmétique normative, notamment avec `ω⊖ω=ω`. La partialité
vient de `Adm`, et non de l'opération arithmétique elle-même. Cette distinction supprime une
ambiguïté de formulation présente dans les versions antérieures.

## 2. Scalarisation minimale

Le postulat P3 borne simultanément travail et profondeur. Avec un budget scalaire, toute scalarisation
admissible doit donc majorer

`W(κ)=Σℓ wℓ` et `D(κ)=supℓ sℓ`.

Par conséquent,

`Cost_Budget(κ)=max(W(κ),D(κ))`

est la plus petite scalarisation qui conserve séparément les deux garanties.

Le résultat est dérivé sous les hypothèses déjà normatives du porteur scalaire et de P3. Ce n'est pas
une propriété de la comonade et ne nécessite aucune multiplication globale sur `𝒢`.

## 3. Composition des effets

Pour le séquencement comme pour la mise en parallèle, le coût scalaire minimal est sous-additif :

`Cost_Budget(κ₁ ∘ κ₂) ≤ Cost_Budget(κ₁)+Cost_Budget(κ₂)`.

La même forme d'inégalité vaut pour la composition parallèle. Elle suffit à la lecture du budget comme
borne de coût ; une égalité serait une exigence plus forte et ne doit pas être introduite sans motif.

Cette propriété explique aussi pourquoi `Consume` peut être plus conservatrice lorsqu'une composition
est consommée étape par étape : la spécification promet une borne sûre, non une mesure exacte du coût.

## 4. Lois minimales de l'interface

Les propriétés désormais requises pour `Cost_Budget` sont :

`Cost_Budget(0)=0` ;

monotonie pour l'ordre temporel ;

sous-additivité pour les compositions séquentielles et parallèles ;

compatibilité avec le domaine d'admissibilité de `Consume`.

Aucune opération de grade supplémentaire n'est nécessaire.

## 5. Verdict

**Résultat dérivé :** `max(W,D)` est la scalarisation scalaire minimale compatible avec P3, sous la
lecture normative actuelle du budget.

**Distinction fermée :** `⊖` est l'opération arithmétique ; `Adm` porte la partialité de la consommation.

**Obligation restante :** définir exactement `W` et `D` sur le domaine des effets et vérifier les
propriétés précédentes sur cette définition.

Le budget ne constitue donc plus une indétermination architecturale du grade. Il reste une interface
sémantique à spécifier précisément.