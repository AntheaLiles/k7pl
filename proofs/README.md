<!-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Lean formalisation

This package is the maintained Lean proof layer for K7PL. Its source tree is
organised by theoretical domain, not by the language name:

- `Grades/`: usage intervals, grade scaling, structural-mode inclusion
  candidates and a finite budget-accounting model.
- `Structural/`: reusable separation lemmas for finite capability-region
  partitions.
- `Memory/`: generation-based entity-reference invalidation.
- `Metatheory/`: generic multi-step closure and invariant preservation.

The root modules `Grades.lean`, `Structural.lean`, `Memory.lean` and
`Metatheory.lean` are the human-facing domain index. No `K7PL/` source
directory is used.

## Source of definitions and dependencies

The grade representation is imported from
`Spec.C3.EffectiveKernel`, which is part of the root Verso/Lean specification.
The proof package depends on the repository root Lake package so that it uses
the same Lean 4.34.0, Mathlib and CSLib pins. It deliberately does not duplicate
the definition of `Usage` or `Grade`.

KLean-generated files remain staged in `K7PL2Lean/` by the existing export
pipeline. They are implementation artefacts, not maintained proof sources.

## Historical KLean proof of concept

The former `K7PL/` proof directory has been moved to `archive/KLean/` and
is built as `KLeanArchive`. This retains the original expression-level
preservation/progress, generated-rewrite preservation, one-way KLean bridges,
examples and abstract D-01 native-boundary model for auditability. These are
historical prototype results, not the foundation of the new domain library.
The public theorem namespaces are retained to avoid breaking the historical
Verso Blueprint and axiom-audit references.

In particular, the archived proofs still do **not** establish:
- equivalence between K's `typeOf` classifier and the Lean `HasType` judgement;
- a general simulation between the source/surface semantics and generated
  KLean configurations;
- a correspondence between K, Lean and TLA+ states;
- the safety of complete K7PL or of arbitrary foreign code.

## Build

From the repository root, `make proof` runs the K export/staging pipeline and
then builds `K7PL2Lean`, `KLeanArchive` and `K7PLProofs`.

From this directory, after KLean sources have been staged:

```sh
lake build K7PL2Lean KLeanArchive K7PLProofs
```

The CI axiom contract checks the exact `#print axioms` dependencies for
tracked declarations and rejects `sorryAx`. A successful build proves only
the declared Lean propositions, not their correspondence to a different
semantics or implementation.

## Proof boundary and integration with K / Lean / TLA+

The intended evidence architecture is:

```
lexicon/   K source and executable operational semantics
proofs/    Lean definitions, lemmas and general metatheory
models/    TLA+ protocol/concurrency models and bounded verification
```

The three surfaces are related only by explicit, reviewable contracts:
K rules are not Lean theorems by naming coincidence, and TLC verification is
not imported as a Lean axiom. This PR is intentionally based on `main` and
does not depend on the still-open PRs #311 (`lexicon/`) or #319 (`models/`).
After their integration, the correspondence obligations can be added without
moving this domain tree.

## Limits of this slice

The current proofs are deliberately local:
- `uLin`, `uAff`, `uRel`, `uUnr` are represented as sets over the existing
  non-negative usage carrier. Their inclusions and affine/relevant
  incomparability are set-theoretic facts; they do not prove the typing rules.
- scaling the usage projection and preservation of the other grade coordinates
  follow from the existing C3 kernel definition. No laws are inferred for
  `ψ`, effect composition or the complete `⊠` operator.
- mode inclusions are explicitly candidates because the normative
  mode-morphism contract is still under review. `Rel` is not introduced as
  a normative structural mode.
- finite `Nat` budget consumption is an accounting lemma, not the general
  `ℕ∞` budget or the full partial `Consume` operation.
- finite-set partitioning is not a proof of H1/H2/H3 or of spatial safety.
- generation-based reference invalidation assumes unbounded `Nat` generations;
  it does not cover bounded counters, concurrent reclamation, persistence or ABA
  at the concrete representation level.
- multi-step invariant preservation is generic infrastructure, not a proof of
  progress, termination, fairness or liveness for K7PL.

No proposition in this package is promoted to normative status by this PR.
