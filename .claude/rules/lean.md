<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Lean 4 development rules

## Architecture

Respect the existing boundaries of `src/`, `tests/` and `tools/`.

Imports must stay minimal and explicit. Never replace a few imports with `import Mathlib` or `import Cslib`.

## Proofs

Before using an unfamiliar lemma, definition or tactic:

- search for the symbol in the repository;
- check it with Lean (`#check`, `exact?`, `apply?`, etc.);
- consult the documentation/source when necessary.

Never invent a Lean API name.

No `sorry`, `admit`, new `axiom` or `native_decide`.

The main theorems that correspond to the language's correctness claims are normative objects: a proof agent may build the proof and the intermediate lemmas, but does not silently change their statement.

## Tests

Every new feature or significant fix must have a suitable check: example, property, rejection test, invariant or proof, depending on the nature of the property.

A test must be able to fail if the targeted property is broken.

## Minimal validation

```
lake build
lake test
lake lint
reuse lint
```

For `spec/`, also use the Verso checks provided by the repository.

Any change to `lakefile.lean`, `lean-toolchain` or `.github/workflows/` must be explicitly reported in the PR.
