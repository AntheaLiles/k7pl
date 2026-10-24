<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Method

This document records methodological rules currently applicable to K7PL work. Earlier working rules and doctrine are kept in [method/](method/); dated historical decisions are in [history/](history/), and the frozen former tooling is in [archives/](archives/README.md). None of these becomes current method merely by being retained.

**Document version:** 1.1.0  
**Last updated:** 2026-10-25  
**Audience:** contributors, reviewers, agents.

## Artefact discipline

K7PL distinguishes specification, formalisation, implementation, proof, test, documentation, and assurance evidence. A result must be reported at the level at which it has actually been established.

## Specification changes

The specification is not weakened merely to accommodate an implementation or proof failure. When formalisation exposes ambiguity, contradiction, missing premises, or an unprovable intended property, the issue is first classified. A specification change is an explicit scientific decision with traceability to affected commitments.

## Formalisation

A formalisation should identify the normative statement or semantic commitment that motivates it. A theorem without a defensible relation to a project claim remains a mathematical result, not automatic evidence for the language specification.

## Proof

Proofs must establish the stated proposition without silently weakening hypotheses or conclusions. The project does not use sorry, admit, newly introduced axioms, or native_decide as substitutes for missing proof obligations.

## Tests

Tests are executable evidence and should be traceable to the behaviour or property they check. Passing tests do not establish specification coherence beyond their tested scope.

## Review

Review is adversarial evidence. A review should distinguish confirmed defects, counterexamples, unresolved questions, plausible concerns, and recommendations. Absence of an identified objection is not itself a proof.

## Status vocabulary

Use bounded statuses: ESTABLISHED, PARTIAL, UNDER REVIEW, IN PROGRESS, OPEN, BLOCKED, NOT STARTED. These are claim- or workstream-level progress states, not statement kinds or evidence types; they do not imply absolute correctness. For statement-level qualifications (specified, formalised, paper proof, Lean proof, finite model checking, test, measurement, assumption, exclusion, open obligation), follow the controlled distinctions in the normative [Guide de lecture](../spec/Spec/C1/GuideDeLecture.lean). A declaration's metadata records the declared epistemic state and evidence kind; only the corresponding source artefact and a successful, provenance-bearing report establish that an automated check actually ran and passed.

## Automation preference

Whenever a fact can be derived reproducibly from an authoritative machine-readable source or a successful build, test, proof, or static analysis, prefer generating it automatically rather than maintaining a manually edited duplicate.

This applies particularly to Lean and test counts, build and test results, toolchain and dependency versions, generated specification metrics, CI status, and release metadata.

## Current versus historical material

A current document describes the state presently claimed by the project. A historical document explains a previous state, decision, or line of reasoning. Historical material must not become normative merely through accumulation or detail.

## Retained method material

The files in [method/](method/) come from the former working folder; their origin is recorded in [the provenance table](history/2026-10-07-provenance-migration.md). They are written in French and carry their own dates. This index describes them; it does not decide which of their rules remain current.

- [charte-redaction.md](method/charte-redaction.md) — writing charter (7 September 2026): sentence-length measurements of the manuscript compared with seven reference style guides, and the rules derived from them.
- [doctrine.md](method/doctrine.md) — project doctrine (28 August 2026): the order of prevalence (postulates, then axiom, then proofs) and the author's arbitrations on what is postulated and what is constructed.
- [doctrine-e.md](method/doctrine-e.md) — "Doctrine E" (9 September 2026): every commitment names the route by which it will be discharged — literature, proof or measurement.
- [protocole.md](method/protocole.md) — working protocol of the former Org-mode setup (28 August 2026): five roles for verification against the literature and the processing invariants they follow.
