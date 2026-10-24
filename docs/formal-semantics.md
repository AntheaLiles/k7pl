<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K operational semantics — prototype

This document describes an executable K semantics for an experimental sublanguage of K7PL.
The editable source of the definition is the K block of `spec/Spec/CodeArtifacts.lean`; the
Python block of the same page holds the checker for the example programs. `lake exe spec
--extract-code-only` generates `src/k/.build/generated/semantics.k` and
`src/k/.build/generated/check_k_examples.py`. These artefacts are ignored by Git and must not be
edited directly. The source programs are in `tests/examples/` and use the `.k7` extension.

## Scope

| Construct | K representation | Behaviour |
|---|---|---|
| Integer literal | builtin `Int` | Integer value |
| Boolean literal | builtin `Bool` | Boolean value |
| `(+ e1 e2)` | `k7Add` | Strict integer addition, left to right |
| `(< e1 e2)` | `k7Lt` | Integer comparison |
| `(select c e1 e2)` | `k7Select` | Evaluates the condition, then selects a branch |
| Base types | `IntType`, `BoolType` | Partial classifier `typeOf` |

The examples run by CI are `(+ 1 (+ 2 3)) → 6` and
`(select (< 1 2) (+ 1 2) (+ 10 20)) → 3`.

## Rule-by-rule correspondence with KLean

The maintained Lean proof project now gives explicit one-way bridges for each computational
root rule in this experimental K7PL subset. The source rule labels are the labels in the editable
Verso K definition; the target constructors are generated from the compiled K definition by
KLean.

| K rule | Generated KLean constructor | Lean evidence |
|---|---|---|
| `k7AddEval` | `Rewrites.k7AddEval` | `K7PL.Bridge.add_root_is_klean_rewrite` |
| `k7LessThanEval` | `Rewrites.k7LessThanEval` | `K7PL.Bridge.less_than_root_is_klean_rewrite` |
| `k7SelectTrue` | `Rewrites.k7SelectTrue` | `K7PL.Bridge.select_true_root_is_klean_rewrite` |
| `k7SelectFalse` | `Rewrites.k7SelectFalse` | `K7PL.Bridge.select_false_root_is_klean_rewrite` |

These results establish the listed root transitions over complete generated configurations. They
do **not** yet establish a general simulation theorem for every expression-level
`SurfaceStep`, including all evaluation-context/continuation transitions. The generated
`Rewrites` relation has a separate preservation theorem for `MachineTyping`; this does not, by
itself, prove that the K classifier `typeOf` is equivalent to the Lean judgment `HasType`.
The broader relation, including source contexts, remains an explicit proof obligation. A green
build or a successful example run does not discharge it.

## Reproduce

From the repository root, with K available:

```sh
make k-check
krun --definition src/k/.build/kompiled tests/examples/add.k7
```

To also run the export to Lean, the proofs and the Verso exposition, with `klean`
`kframework==7.1.337` and Lean `v4.34.0`:

```sh
make formal-chain
```

## D-01 — frontière native (modèle de profil, non normatif)

Le modèle séparé src/k/.build/generated/models/native-boundary.k est extrait d'un bloc
k7osModel dans la page Verso. Il compare trois cas : appel natif conforme au contrat,
écriture refusée sous l'hypothèse abstraite d'une frontière appliquée, et écriture native qui
modifie l'état protégé quand aucune frontière n'est appliquée. Ce modèle n'ajoute aucune
construction à la grammaire normative de K7PL et ne choisit pas de mécanisme matériel.

La même transition abstraite est explorée par TLC avec deux configurations : la configuration
BoundaryEnforced = TRUE doit préserver ProtectedIntegrity ; la configuration négative doit
produire un contre-exemple. Le témoin négatif est fixé sur la valeur 1 : l'état initial
(protected=0, service=0), l'action NativeWrite(1), puis l'état (protected=1, service=0).
Lean prouve la préservation pour toutes les traces finies du profil confiné et rejoue explicitement
ce témoin en un pas. La CI joue également les trois exemples K avec les mêmes valeurs.

Ces résultats sont des corroborations à partir de modèles distincts, pas encore un théorème de
simulation K↔TLA+ ni une preuve que le modèle correspond à la sémantique normative complète de
K7PL. Les sources et journaux TLC sont empaquetés avec les sources K, les preuves Lean et la
documentation Verso dans le workflow de sémantique formelle. La relation de projection entre les
configurations K complètes, les états TLA+ et K7PL.NativeBoundary.State reste explicitement ouverte.

## Trust boundary

`klean` consumes the K definition compiled to KORE and generates a `Rewrites` relation on
complete K configurations, including the auxiliary strictness transitions (heat/cool) and the
continuation frames. The Lean package proves `preservation`/`progress` for the expression
relation `SurfaceStep` and the preservation of `MachineTyping` for the generated relation
`Rewrites` of the sublanguage. The axiom audit allows `[propext]` and forbids `sorryAx`.

The K function `typeOf` is not exported as `Rewrites` rules; its correspondence with the
structural Lean judgement `HasType` remains to be proved. The result does not formalise the
fragments of resources, grades, effects, actors, capabilities, or the complete normative grammar.
The KORE→Lean translation, the hooked functions and the fidelity of this definition to the
specification are separate trust obligations.
