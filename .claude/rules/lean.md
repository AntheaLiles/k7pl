<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# Règles de développement Lean 4

## Architecture

Respecter les frontières existantes de `src/`, `tests/` et `tools/`.

Les imports doivent rester minimaux et explicites. Ne jamais remplacer quelques imports par `import Mathlib` ou `import Cslib`.

## Preuves

Avant d'utiliser un lemme, une définition ou une tactique inconnue :

- rechercher le symbole dans le dépôt ;
- vérifier avec Lean (`#check`, `exact?`, `apply?`, etc.) ;
- consulter la documentation/source quand nécessaire.

Ne jamais inventer un nom d'API Lean.

Aucun `sorry`, `admit`, nouvel `axiom` ou `native_decide`.

Les théorèmes principaux correspondant aux affirmations de correction du langage sont des objets normatifs : un agent de preuve peut construire la preuve et les lemmes intermédiaires, mais ne change pas silencieusement leur énoncé.

## Tests

Toute nouvelle fonctionnalité ou correction significative doit avoir un contrôle adapté : exemple, propriété, test de rejet, invariant ou preuve, selon la nature de la propriété.

Un test doit être capable d'échouer si la propriété visée est cassée.

## Validation minimale

```
lake build
lake test
lake lint
reuse lint
```

Pour `spec/`, utiliser aussi les contrôles Verso prévus par le dépôt.

Toute modification de `lakefile.lean`, `lean-toolchain` ou `.github/workflows/` doit être explicitement signalée dans la PR.
