<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 60 : agrégateurs canoniques du coût temporel

**Date :** 7 octobre 2026

La séance 59 a réduit la question du budget à l'interface entre l'effet temporel et
l'admissibilité locale de `ψ`. Il reste à définir sans ambiguïté les deux agrégateurs qui composent
la famille de coûts par niveaux.

## 1. Définition sur une famille éventuellement infinie

On écrit :

`κ(ℓ)=⟨w_ℓ,s_ℓ⟩`

avec `w_ℓ,s_ℓ∈ℕ∞`.

Le travail total est défini par la borne supérieure des sommes finies :

`W(κ)=sup { Σ_{ℓ∈F} w_ℓ | F⊆ℒ, F fini }.`

Cette définition ne suppose donc pas que `ℒ` soit fini ni que `κ` soit à support fini.

La profondeur globale est :

`D(κ)=sup_{ℓ∈ℒ} s_ℓ.`

Les deux opérations utilisent la complétude de `ℕ∞`.

## 2. Scalarisation

Sous l'hypothèse normative que le budget reste scalaire et doit borner simultanément les deux
dimensions temporelles :

`Cost_Budget(κ)=max(W(κ),D(κ)).`

Cette valeur est la plus petite borne scalaire dominante : toute valeur `C` qui satisfait
`W(κ)≤C` et `D(κ)≤C` satisfait nécessairement `max(W(κ),D(κ))≤C`.

## 3. Monotonie

Pour l'ordre ponctuel sur les familles :

`κ₁≤κ₂ ⇒ W(κ₁)≤W(κ₂)` et `D(κ₁)≤D(κ₂)`.

La scalarisation est donc monotone :

`Cost_Budget(κ₁)≤Cost_Budget(κ₂).`

Aucune structure supplémentaire du grade n'est utilisée.

## 4. Effet nul

Pour la famille nulle :

`W(0)=0`,
`D(0)=0`,
donc `Cost_Budget(0)=0.`

Cette propriété fournit l'identité requise par `Consume`.

## 5. Séquencement

Pour le séquencement temporel, les coordonnées se composent par addition :

`κ₁·κ₂` porte `w=w₁+w₂` et `s=s₁+s₂`.

On obtient :

`W(κ₁·κ₂)=W(κ₁)+W(κ₂),`

et

`D(κ₁·κ₂)≤D(κ₁)+D(κ₂).`

Par conséquent :

`Cost_Budget(κ₁·κ₂)
 ≤ Cost_Budget(κ₁)+Cost_Budget(κ₂).`

L'égalité n'est pas requise pour une borne sûre.

## 6. Mise en parallèle

Pour la composition parallèle, le travail est additif et la profondeur prend le maximum :

`W(κ₁∥κ₂)=W(κ₁)+W(κ₂),`

`D(κ₁∥κ₂)=max(D(κ₁),D(κ₂)).`

D'où à nouveau :

`Cost_Budget(κ₁∥κ₂)
 ≤ Cost_Budget(κ₁)+Cost_Budget(κ₂).`

Cette loi ne suppose aucune commutativité du séquencement ; elle ne concerne que la branche
parallèle.

## 7. Consommation

La condition d'admissibilité devient :

`Adm(β,κ)
 := (β=ω) ∨ (Cost_Budget(κ)≤β).`

Sur ce domaine :

`Consume(β,κ)=β⊖Cost_Budget(κ).`

La spécification sépare ainsi trois opérations :

`W,D` agrègent l'effet ;

`Cost_Budget` le scalarise ;

`Consume` met à jour le potentiel.

Aucune de ces opérations n'est une multiplication de `𝒢`.

## 8. Cas `When`

Pour `κ_ω(ℓ)=⟨ω,ω⟩` :

`W(κ_ω)=ω,
D(κ_ω)=ω,
Cost_Budget(κ_ω)=ω.`

Le caractère non borné de `When` est donc préservé par la scalarisation et devient observable par
`Adm` lorsqu'une ressource finie doit supporter l'effet.

## 9. Statut

**Établi sous les choix normatifs actuels :** définitions canoniques de `W`, `D` et
`Cost_Budget`.

**Établi :** monotonie, nullité et sous-additivité séquentielle/parallèle.

**Établi :** `When` se projette sur le coût scalaire `ω`.

**Préservé :** le budget reste `ℕ∞` et ne devient pas un vecteur.

**Obligation résiduelle :** intégrer la condition `Adm` à la preuve de correction de `ψ` et établir
que le coût effectivement traversé par chaque règle correspond à la famille `κ` annoncée par
l'effet.

Cette dernière obligation est sémantique ; elle ne concerne plus la signature des objets théoriques.
