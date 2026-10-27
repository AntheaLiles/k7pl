<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Project-wide rules

k7pl is a programming language under design, with a specification in Verso and an implementation in Lean 4.

## Sources of truth

- `spec/` is the normative source of the current specification.
- `src/` is the source of the Lean implementation.
- `tests/` contains the executable checks.
- `wiki/` contains maintained project documentation and generated status views.
- `theoretical-projects/k7os/` contains research and models for the separate K7OS project; keep its evidence distinct from the normative K7PL specification.

A claim in the specification, a Lean definition, a proof and a test are different objects. Never treat them as interchangeable.

## Invariants

Do not introduce:

- `sorry`, `admit`, a new `axiom` or `native_decide`;
- an uncontrolled dependency;
- a silent change to the manuscript;
- a weakened check to make CI, Scorecard or CII pass.

Before any significant change, read the specialised rule for the area being touched.

## Working discipline

Prefer the smallest change that demonstrates the requested result. Do not refactor an unrelated area.

A task that spans `spec/` and `src/` must make the relation between the two explicit before implementation.

An uncertain decision must be marked as a hypothesis, an open question or a required human action; never present it as an established fact.
