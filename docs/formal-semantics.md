<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Sémantique opérationnelle K — prototype

Ce dossier décrit une sémantique exécutable K pour un sous-langage expérimental de K7PL.
La source éditable de la définition est le bloc K de `spec/Spec/CodeArtifacts.lean`; le bloc
Python de la même page contient le vérificateur des programmes d'exemple. `lake exe spec
--extract-code-only` génère `src/k/.build/generated/semantics.k` et
`src/k/.build/generated/check_k_examples.py`. Ces artefacts sont ignorés par Git et ne doivent
pas être édités directement. Les programmes source sont dans `tests/examples/` et utilisent
l'extension `.k7`.

## Périmètre

| Construct | Représentation K | Comportement |
|---|---|---|
| Littéral entier | `Int` builtin | Valeur entière |
| Littéral booléen | `Bool` builtin | Valeur booléenne |
| `(+ e1 e2)` | `k7Add` | Addition entière stricte, gauche-à-droite |
| `(< e1 e2)` | `k7Lt` | Comparaison entière |
| `(select c e1 e2)` | `k7Select` | Évalue la condition puis sélectionne une branche |
| Types de base | `IntType`, `BoolType` | Classificateur partiel `typeOf` |

Les exemples exécutés par CI sont `(+ 1 (+ 2 3)) → 6` et
`(select (< 1 2) (+ 1 2) (+ 10 20)) → 3`.

## Reproduire

Depuis la racine du dépôt, avec K disponible :

```sh
make k-check
krun --definition src/k/.build/kompiled tests/examples/add.k7
```

Pour exécuter aussi l'export vers Lean, les preuves et l'exposé Verso, avec `klean`
`kframework==7.1.337` et Lean `v4.34.0` :

```sh
make formal-chain
```

## Frontière de confiance

`klean` consomme la définition K compilée en KORE et génère une relation `Rewrites` sur des
configurations K complètes, incluant les transitions auxiliaires de strictness (heat/cool) et
les frames de continuation. Le paquet Lean prouve `preservation`/`progress` pour la relation
expressionnelle `SurfaceStep` et la préservation de `MachineTyping` pour la relation générée
`Rewrites` du sous-langage. L'audit d'axiomes autorise `[propext]` et interdit `sorryAx`.

La fonction K `typeOf` n'est pas exportée comme des règles de `Rewrites`; sa correspondance
avec le jugement Lean structurel `HasType` reste à prouver. Le résultat ne formalise pas les
fragments de ressources, grades, effets, acteurs, capacités ou la grammaire normative complète.
La traduction KORE→Lean, les fonctions hookées et la fidélité de cette définition à la
spécification constituent des obligations de confiance distinctes.
