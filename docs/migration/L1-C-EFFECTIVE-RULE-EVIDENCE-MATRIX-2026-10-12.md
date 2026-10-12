<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Matrice des règles effectives — porte C

**Statut :** constat d'inventaire ; ne constitue ni une preuve ni un remplacement des audits C-01–C-09.
**Source normative inspectée :** `spec/Spec/C3/ReglesDeTypage.lean` sur la branche candidate de la PR #170.
**Inventaire :** 49 occurrences de règles (48 noms distincts ; `Alw` est présent deux fois, pour introduction et élimination). Le contrôle Python associé compare ces occurrences au présent tableau.

## Règles de typage C3

Les modules Lean existants sont des modèles transversaux : `GradeBudget` et `UsageScale` formalisent certaines opérations abstraites ; `BudgetTransport` formalise une instance paramétrique de `ψ` ; `StructuralModes` prouve des propriétés d'un ordre de permissions abstrait ; `WhenBoundary` suppose un certificat de budget ; `MemoryRange` et `MemoryCapability` prouvent des propriétés de modèles d'intervalles/comptes. Aucun de ces modules ne définit la syntaxe de calcul K7PL, le jugement de typage de C3 ou une dérivation inductive sur les règles normatives.

Dans la colonne « Représentant Lean », les modules cités ne sont que des modèles potentiellement pertinents ; ils **ne sont pas** considérés comme le représentant effectif de la règle. `ABSENT` signifie : pas de règle K7PL mécanisée et pas de preuve de préservation propre à ce cas dans la bibliothèque `src/K7pl/` inspectée.

| Nº | Occurrence normative | Modules abstraits éventuellement pertinents | Représentant effectif / preuve de correction de la règle |
|---:|---|---|---|
| 01 | `Var` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 02 | `Ret` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 03 | `Th` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 04 | `Let` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 05 | `Fo` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 06 | `Box` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 07 | `Unbox` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 08 | `Lam` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 09 | `App` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 10 | `Pair` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 11 | `Inj` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 12 | `Pack` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 13 | `Open` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 14 | `One` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 15 | `OneE` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 16 | `Split` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 17 | `Case` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 18 | `Op` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 19 | `Tick` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 20 | `Del` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 21 | `Sub` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 22 | `SubBox` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 23 | `Alw⁺` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 24 | `Alw⁻` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 25 | `Now` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 26 | `Wait` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 27 | `When` | `WhenBoundary` / `GradeBudget` — modèles de profil seulement | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 28 | `Sc` | `UsageScale` / `BudgetTransport` éventuellement pertinents, sans jugement ni preuve par règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 29 | `Fold` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 30 | `Unfold` | `GradeBudget` éventuellement pertinent, sans règle opérationnelle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 31 | `Gen` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 32 | `Inst` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 33 | `Out` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 34 | `Cop` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 35 | `With` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 36 | `Proj` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 37 | `VecI` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 38 | `VecE` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 39 | `Slice` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 40 | `Par` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 41 | `Vmap` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 42 | `Spawn` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 43 | `New` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 44 | `Send` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 45 | `Guard` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 46 | `Free` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 47 | `At` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 48 | `Move` | `MemoryCapability` / `MemoryRange` éventuellement pertinents, sans instanciation de règle | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |
| 49 | `Try` | Aucun module de syntaxe/jugement effectif | **ABSENT** — aucune dérivation typée ni théorème de préservation propre à cette règle dans `src/K7pl/` |

## Résultat de l'inventaire

- La source C3 contient 49 occurrences ; elles sont toutes listées une seule fois dans cette matrice.
- `src/K7pl/Semantics.lean` ne définit qu'un LTS de compteur (`incr`, `reset`), sans configurations K7PL, canaux, effets, budget, traces de `When` ou relation source-cible.
- `src/K7pl/Arith.lean` est un langage jouet d'expressions arithmétiques ; ce n'est pas la syntaxe normative de K7PL.
- Le module racine `src/K7pl.lean` importe les modèles disponibles, mais aucun module de jugement de typage ou de règles opérationnelles K7PL n'est défini/importé sous `src/K7pl/`.

Cette matrice satisfait un besoin de traçabilité négative : elle localise l'absence de représentant, plutôt que de compter une preuve abstraite à tort. Elle laisse **ouverts** les raccords de C-01–C-09 aux règles effectives. La porte C ne peut pas être déclarée satisfaite sur cette base.
