<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 57 : clôture de la matrice de substitution

**Date :** 7 octobre 2026

Les séances 53 à 56 ont réduit les dernières dettes de PR-02 à des propriétés de preuve localisées.
La présente séance ferme la matrice de dépendances du lemme de substitution.

## 1. Cas déjà fermés

`Var` utilise uniquement l'unité et le zéro de `𝓡`.

`Pair` et `Inj` utilisent l'additivité de `Scale_Usage`.

`Let`, `App`, `Unbox` et `Open` utilisent sa composition et sa commutation avec `ψ`.

`Sc` utilise `Scale_Usage(n,-)` sur le contexte et `φ_n` sur l'effet.

Ces cas ne demandent aucune nouvelle structure théorique.

## 2. Cas `Sub` et `SubBox`

Ils utilisent exclusivement la famille de conversions du grade complet.
La séance 56 a réduit leur obligation à :

`Conv(r,r)=id` ;

`Conv(r,t)=Conv(s,t)∘Conv(r,s)` ;

compatibilité de `coerce` avec `w` et `c` ;

commutation de `Conv` avec `Scale_Usage`.

Une fois ces propriétés établies, `Sub` et `SubBox` n'ajoutent aucun cas architectural à la
substitution.

## 3. Cas `When`

`When` reste le seul cas dont la clôture dépend d'une décision sémantique sur le rapport entre
latence environnementale et budget P3.

Si l'attente compte dans le budget temporel, le passage à `κ_ω` force le coût scalaire à `ω` et la
règle doit préserver cette admissibilité.

Si l'attente est externe au coût d'exécution, `Cost_Budget` doit distinguer cette dimension au lieu
de la confondre avec le travail.

Dans les deux cas, aucune modification de `𝒢`, `𝓡` ou `!` n'est requise.

## 4. Fermeture de la question d'architecture

Le lemme de substitution ne demande donc plus :

- une multiplication globale de `𝒢` ;
- un nouvel indice de `!` ;
- une seconde action scalaire sur le grade complet ;
- une nouvelle composante de budget.

Il demande seulement les propriétés sémantiques des interfaces déjà définies.

## 5. Verdict

**Architecture théorique : stabilisée.**

**Objets supplémentaires nécessaires : aucun.**

**Preuves restantes :** conversion/coerce, substitution sous ces conversions, agrégateurs temporels,
et décision sémantique de `When` vis-à-vis de P3.

TRANS-02 peut désormais sortir du mode d'exploration des objets : toute modification ultérieure de
signature constituerait une réouverture motivée par un contre-exemple ou une nouvelle exigence, et non
par une ambiguïté résiduelle du modèle courant.