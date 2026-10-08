<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 23 : signatures du noyau `Box–App–SubBox–substitution`

**Date :** 7 octobre 2026

Cette séance transforme l'intuition architecturale des séances 21 et 22 en obligations de typage.
Le but est de donner à chaque opération une signature indépendante avant de décider quelle structure
globale ou hétérogène la réalise.

## 1. Fragment minimal

Le fragment retenu contient `Var`, `Box`, `Unbox`, `Lam`, `App`, `Sub`, `SubBox` et le lemme de
substitution. Il suffit à couvrir la formation de la modalité, l'application d'une demande graduée,
la conversion de grades et la préservation sous substitution.

## 2. Inventaire règle → scalaire → opération

| Règle | Donnée quantitative | Opération utilisée | Domaine actuellement présumé | Obligation |
|---|---|---|---|---|
| `Var` | `0` | `0·Δ` | grade complet ? | définir l'élément nul et son action sur un contexte |
| `Box` | `r` | `r·Δ` | grade complet `𝓖` dans la syntaxe actuelle | définir `𝓖 × Ctx(𝓖) ⇀ Ctx(𝓖)` et le lien avec `!_r` |
| `Unbox` | `r` | aucune mise à l'échelle au niveau de la conclusion | grade complet | expliquer pourquoi l'élimination restitue exactement la liaison annotée |
| `Lam` | `r` | annotation du type fonction | grade complet | déterminer si `r` est un scalaire, un vecteur ou une annotation structurée |
| `App` | `r` | `r·Δ₂` | grade complet dans la syntaxe actuelle | même action que `Box`, plus compatibilité avec `⊠` et `ψ` |
| `Sub` | `r,s` | relation `≼` | `𝓖` | fournir cohérence, réflexivité et transitivité des conversions |
| `SubBox` | `r,s` | relation `≼` sur l'indice modal | `𝓖` | relier la conversion de type à la conversion de grade |
| `Substitution` | `r` | `r·Δ'` | grade complet | preuve dépendante de l'action et de sa compatibilité avec `App` |

Une seconde famille est indépendante du grade de fonction :

| Règle | Donnée quantitative | Opération | Rôle |
|---|---|---|---|
| `VecI` | `n` | `n·Δ` | répéter la construction d'une valeur dans un vecteur |
| `VecE` | `n` | `n·Δ` | répéter le contexte du corps de l'itération |
| `Sc` | `n` | `n·Δ` | réutiliser le contexte d'un bloc à portée |

Le symbole `·` recouvre donc au minimum deux opérations de familles différentes. Leur coïncidence
ne doit pas être supposée.

## 3. Conséquence pour l'architecture du grade

Dans l'architecture A, `𝓖` doit être un grade algebra assez riche pour rendre les opérations de
`Box`, `App`, `SubBox` et contraction cohérentes. Le point délicat n'est pas l'existence abstraite
d'un produit d'algebras, qui est compatible avec la construction de Bianchini et al., mais le choix
des opérations sur `Mono`, `Level` et `Budget` et leur adéquation à la sémantique de K7PL.

Dans l'architecture C, les dimensions du grade peuvent être traitées par des sortes ou modes
distincts, avec des morphismes de grades permettant à un scalaire donné d'agir seulement dans les
algèbres compatibles. C'est proche de la discipline de GRASS : un scalaire `q` appartient à une
algèbre de mode et sa multiplication sur un vecteur hétérogène passe par les morphismes vers les
modes des composantes. Cette propriété n'est toutefois pas une preuve que la décomposition de K7PL
doit suivre exactement GRASS.

## 4. Condition de séparation `Usage` / `Exec`

Le fragment minimal suffit à imposer une contrainte forte : la donnée utilisée pour `r·Δ` doit être
distincte, au moins conceptuellement, de la donnée utilisée pour répéter un effet.

Une solution candidate consiste à introduire un domaine de multiplicateurs d'exécution `Exec` et
un domaine de grades d'usage `Usage`, avec une application partielle

`execOf : Grade → Exec`

pour les grades qui peuvent effectivement traverser la loi distributive d'effets.

Cette application ne peut être totale si `Usage` contient `1/N`. Une fraction de capacité n'est pas
une fraction d'exécution.

## 5. Conditions minimales de preuve

Avant toute formalisation Lean, il faut disposer de résultats séparés :

1. fermeture de l'addition de contextes ;
2. action définie de chaque scalaire autorisé sur les contextes ;
3. compatibilité de cette action avec l'addition ;
4. compatibilité de l'action avec la composition `⊠` ;
5. compatibilité de `≼` avec les constructeurs de types ;
6. domaine explicite de `φ` et compatibilité avec l'action sur les contextes ;
7. substitution, une fois les six obligations précédentes disponibles.

Le point 7 ne doit donc pas être mécanisé avant les points 2, 4 et 6. Une preuve de substitution
qui traite `r·Δ` comme une opération primitive déjà correcte reproduirait exactement la dette que
PR-02 est en train d'éliminer.

## 6. Résultat

La question d'architecture est désormais réduite à une comparaison de signatures. A et C restent
compatibles avec le fragment abstrait ; B demeure possible au prix d'une reconstruction de `!_r`.
D reste un mécanisme d'indexation catégorique de secours.

Le prochain objet est une spécification comparative des signatures de A et C, sans modification
normative du langage. Le test décisif sera de déterminer si A peut réaliser le même comportement
avec moins de primitives, d'hypothèses de compatibilité et de coercions explicites que C.