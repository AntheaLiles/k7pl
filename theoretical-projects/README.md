<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Theoretical projects

This directory holds theoretical projects that structure the
creation of K7PL, kept separate from the normative specification
in `spec/` and from the current documentation in `wiki/`.
Nothing here is normative, and nothing here is endorsed by
being listed: each project is an adversarial model or a
study object whose conclusions require author ratification
before they can enter the specification or the wiki.

## k7os

`k7os/` (renamed from `docs/research/k7pl-os/` in the
research closing of 2026-10-25, proposed name
`theoretical-projects/` submitted for owner validation)
is an operating system envisaged in K7PL, studied as an
adversarial project model: ten briefs (R0–R9) on threat
modelling, authority, compiler correctness, information
flow, concurrency, memory, real-time budgets, failure
recovery, OS comparisons and model checking, a joint
exploration dossier, and a provisional delta register
(`SPEC-DELTA-REGISTER.md`, SPEC-D-01 to SPEC-D-25).
Each delta remains conditioned on an author decision and
on revalidation at the current head; the deltas are
carried as open roadmap items and open decisions in the
wiki, never as clauses. The TLA+ sources and their
configurations are centralised directly in the repository-
root [`models/`](../models/README.md) directory. A
checked model is not a proof of correspondence with the
complete normative semantics, and the K ↔ TLA+
simulation remains open (see `wiki/semantics.md`).


## K7PL TLA+ work programme

The non-normative K7PL TLA+ programme, including its sixteen work packages, chapter coverage, formal architecture, toolchain plan and open semantic gates, is maintained directly under repository-root [`models/`](../models/README.md). It is part of this K7PL repository and therefore does not use a redundant `k7pl/` subdirectory.
