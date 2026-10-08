<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 41 : interface budget / temps

**Date :** 7 octobre 2026

La séance 40 a séparé borne d'usage et multiplicité d'effet. Le présent test porte sur une autre
frontière : le budget du grade est scalaire, alors que le coût temporel courant est une famille de
couples travail/profondeur indexée par les niveaux.

## 1. Structure temporelle effectivement normative

L'état normatif courant décrit les effets sous la forme :

`ε = ⟨φ, κ⟩`

avec

`κ : ℒ → (ℕ∞×ℕ∞)`.

Pour chaque niveau, la première coordonnée est le travail et la seconde la profondeur. Le séquencement
additionne les deux composantes ; la mise en parallèle additionne les travaux et prend le maximum des
profondeurs ; une ré-invocation entière multiplie les deux composantes.

Cette structure est normative dans la grammaire du chapitre 3. Les extensions futures de concurrence
peuvent apporter d'autres objets, mais elles ne définissent pas le type temporel courant.

## 2. Le manque réel

Le grade contient un budget scalaire :

`β ∈ 𝔅 = ℕ∞`.

La fonction `ψ` doit transformer la famille temporelle en quantité consommable par le budget. Il
manque donc une interface :

`Cost_Budget : (ℕ∞×ℕ∞)^ℒ ⇀ ℕ∞`.

La consommation s'écrit alors provisoirement :

`Consume(β,κ)=β ⊖ Cost_Budget(κ)`.

La relation entre `κ` et le scalaire consommé n'est pas une opération du semi-anneau de grade :
c'est une interface entre l'algèbre d'effets et la composante budgétaire.

## 3. Interface minimale

Les obligations minimales sont :

`Cost_Budget(0)=0` ;

`Cost_Budget` monotone pour l'ordre temporel ;

compatibilité avec la composition séquentielle et, puisque la composition parallèle est normative,
compatibilité avec celle-ci ;

condition d'admissibilité de `Consume`.

Aucune de ces propriétés ne choisit à elle seule une scalarisation particulière.

## 4. Test des deux dimensions

Deux agrégats intermédiaires sont immédiatement distinguables :

`W(κ)=Σ_ℓ w_ℓ` pour le travail total,

`D(κ)=sup_ℓ s_ℓ` pour la profondeur globale.

Sous budget scalaire, une scalarisation sûre peut par exemple prendre la forme :

`Cost_MaxBoth(κ)=max(W(κ),D(κ))`.

Elle garantit séparément `W≤β` et `D≤β`. D'autres scalarisations dominantes restent
possibles.

Le choix entre elles dépend de la signification exacte de `β`. Il n'est donc pas encore
normatif.

## 5. Conséquence pour la loi de cohérence

La loi `coherence_usage` reste indépendante de `Cost_Budget` : `Scale_Usage`
modifie uniquement l'usage, alors que `ψ` modifie uniquement le budget via `Consume`.

Cette séparation explique pourquoi les usages rationnels n'imposent pas de scalariser ou de multiplier
le budget par une fraction.

## 6. Statut

**Corrigé :** le facteur temporel courant est `(ℕ∞×ℕ∞)^ℒ`, pas `ℕ∞^ℒ`.

**Établi :** le budget du grade reste scalaire `ℕ∞` dans l'architecture retenue.

**Établi :** `Scale_Usage` n'a pas à transformer directement ce budget.

**Interface requise :** `Cost_Budget : (ℕ∞×ℕ∞)^ℒ ⇀ ℕ∞`.

**Non établi :** la scalarisation normative du coût.

**Position de recherche :** conserver provisoirement `𝔅=ℕ∞` et isoler la scalarisation dans
`Cost_Budget`. Un budget vectoriel reste une alternative architecturale distincte, à ne pas
introduire sans obligation supplémentaire.
