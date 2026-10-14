<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Verification strategy

The first question is not "which test should I write?", but "which property must hold, and which error must the check detect?".

## Verification contract

For any substantial change, make explicit:

```
Property
→ level of the property
→ oracle / proof
→ detectable error
→ chosen check
→ observed result
```

## Levels

Do not conflate:

- syntax;
- typing;
- semantics;
- internal invariant;
- metatheoretical property;
- compilation behaviour;
- rendering of the specification;
- reproducibility of an artefact.

A weaker verification cannot be used as proof of a stronger property.

## Proof vs test

Tests explore selected behaviours.

A proof establishes a proposition in the formal system under consideration.

An absence of test failures is never presented as a proof of formal correctness.

## Regression

Every bug fix must look for a check that would have failed before the fix and that remains relevant after it.

## Reproducibility

An artefact is reproducible only if several independent runs produce a result that meets the defined criterion. Merely pinning dependencies is not a demonstration.
