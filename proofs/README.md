<!-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Lean formalisation

This package is the maintained Lean proof layer for K7PL. Its source tree is
organised by theoretical domain, not by the language name:

- `Grades/`: usage intervals, specification/implementation grade correspondence,
  the implementation's structural modes, and its `ℕ∞` budget contract.
- `Structural/`: separation properties over the implementation's actual finite memory ranges.
- `Memory/`: linear capability-ownership invariants and generation-based entity-reference invalidation.
- `Metatheory/`: generic multi-step closure and invariant preservation.

The root modules `Grades.lean`, `Structural.lean`, `Memory.lean` and
`Metatheory.lean` are the human-facing domain index. No `K7PL/` source
directory is used.

## Source of definitions and dependencies

The proof package imports both the root implementation library (`K7pl`) and the
C3 effective kernel (`Spec.C3.EffectiveKernel`). The usage interval module
reuses the implementation carrier; `Grades/Scaling.lean` defines explicit
record maps and proves that the two four-coordinate grade representations,
usage projection and scaling commute. No third grade representation is added.
The same local package dependency reuses `K7pl.StructuralModes`,
`K7pl.MemoryRange` and `K7pl.GradeBudget`, with the repository's pinned Lean
4.34.0, Mathlib and CSLib graph.

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

The maintained domain library can be built independently of KLean export:

```sh
lake build K7PLProofs
```

After the KLean export pipeline has staged its generated sources, the
historical archive can also be checked:

```sh
lake build K7PL2Lean KLeanArchive
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
- grade correspondence is a representation theorem between the spec kernel
  and implementation records; it does not prove that K typing rules use either
  representation or that K refines the Lean semantics.
- mode morphisms reuse the implementation's Ideal-based definition. The
  relational mode remains an algebraic candidate, not a fourth normative mode;
  usage interval `U_Rel` and structural mode `M_Rel` remain distinct.
- the budget domain reuses `ℕ∞`, `Cost_Budget`, `Adm` and partial `consumeK`;
  the selected results cover conservation, residual bounds and the existing
  sequential/parallel cost contracts. Operational typing rules are not yet
  proved to invoke `consumeK` correctly.
- range disjointness reuses the implementation's interval type and proves
  elementary relation laws; no range-to-physical-region mapping or H1/H3 proof
  is supplied.
- generation-based reference invalidation assumes unbounded `Nat` generations;
  it does not cover bounded counters, concurrent reclamation, persistence or ABA
  at the concrete representation level.
- multi-step invariant preservation is generic infrastructure, not a proof of
  progress, termination, fairness or liveness for K7PL.

No proposition in this package is promoted to normative status by this PR.
