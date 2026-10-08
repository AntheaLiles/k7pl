<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 59 : résolution du cas `When` et de l'admissibilité budgétaire

**Date :** 7 octobre 2026

La séance 55 avait laissé deux lectures possibles de `When` : interdire immédiatement une attente
non bornée aux budgets finis, ou considérer l'attente comme extérieure au budget. L'examen conjoint
de P3, de `ψ` et de la règle `When` permet de rejeter cette dichotomie.

## 1. Ce que `When` produit réellement

La règle produit :

`ε[ω/k]`

et sa définition remplace la famille temporelle par une famille non bornée :

`κ_ω(ℓ)=⟨ω,ω⟩`.

Sous la scalarisation candidate

`Cost_Budget(κ)=max(W(κ),D(κ))`,

le coût scalaire correspondant est `ω`.

Le point important est que cette valeur n'est pas cachée. Le jugement de conclusion porte explicitement
l'effet non borné. `When` ne transforme donc pas une attente sans borne en une annotation de temps
finie.

## 2. Quand intervient réellement le budget

La consommation budgétaire est portée par `ψ` lorsqu'un effet traverse un contexte :

`Δ₁ ⊠_ε Δ₂ = Δ₁ + ψ(Δ₂,ε)`.

Ainsi, pour un coût scalaire `k`, l'admissibilité locale est :

`Adm(β,k) := (β=ω) ∨ (k≤β)`,

et, lorsqu'elle est satisfaite,

`Consume(β,k)=β⊖k`.

Le budget n'a donc pas à être consommé au moment où `When` produit l'effet non borné. Il est consommé
au moment où cet effet traverse effectivement une liaison susceptible de porter une borne.

## 3. Conséquence

Un calcul contenant `When` peut donc être typé avec un budget fini dans son contexte local si la
dérivation ne demande pas encore de faire traverser l'effet non borné par cette ressource.

En revanche, dès qu'une composition ultérieure impose le passage de cet effet sur une liaison de
budget fini, la condition `Adm` échoue puisque :

`Cost_Budget(κ_ω)=ω > β`

pour tout budget fini `β`.

Le mécanisme est donc cohérent avec une sémantique de borne différée : l'absence de borne n'est pas
une erreur cachée ; elle devient une incompatibilité explicite lorsqu'une ressource finie doit
supporter cet effet.

## 4. Rapport exact avec P3

P3 interdit qu'une abstraction dissimule un coût. Il n'impose pas, dans sa formulation actuelle,
que tout effet non borné soit rejeté à son introduction.

`When` respecte donc P3 sur ce point à condition que la propriété de correction globale soit formulée
comme une propriété d'admissibilité des traversées et non comme une obligation d'avoir toujours une
borne finie dans le jugement.

La preuve de correction de ressource doit montrer :

si `ψ(Δ,ε)` est appliquée à une liaison de budget fini `β`, alors
`Cost_Budget(ε)≤β` ;

et lorsque cette condition échoue, la composition n'est pas définie.

Cela suffit à empêcher un dépassement silencieux.

## 5. Conséquence pour `Cost_Budget`

La scalarisation

`Cost_Budget=max(W,D)`

peut donc être conservée comme candidat minimal sous les hypothèses déjà fixées :

- `β` est scalaire ;
- P3 borne simultanément travail et profondeur ;
- `κ` représente les deux dimensions temporelles.

La question restante n'est plus le statut de `When`, mais la définition précise de `W` et `D` sur
la famille de coûts par niveaux et la démonstration des propriétés de `Cost_Budget`.

Pour une famille éventuellement infinie, les agrégats doivent être compris par les opérations
complètes de `ℕ∞`, par exemple comme supremum des sommes finies pour `W` et supremum simple pour `D`.

## 6. Verdict

**Résultat établi :** `When` produit explicitement une borne temporelle non bornée.

**Résultat établi :** la consommation du budget est déclenchée par `ψ`, et non par la seule
production de l'effet.

**Résultat fortement soutenu :** `When` et `Cost_Budget` sont compatibles sans imposer une
interdiction immédiate de `When` avec tout budget fini.

**Obligation restante :** définir précisément les agrégateurs `W` et `D` et les relier à la preuve
d'admissibilité de `ψ`.

**Architecture préservée :** aucune modification de `𝒢`, de `𝓡`, de `!` ou de `Scale_Usage` n'est
nécessaire.
