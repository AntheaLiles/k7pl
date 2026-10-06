<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Method

This document records methodological rules currently applicable to K7PL work. Historical decisions remain in legacy documentation until migration.

**Document version:** 1.0.0  
**Last updated:** 2026-10-06  
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

Use bounded statuses: ESTABLISHED, PARTIAL, UNDER REVIEW, IN PROGRESS, OPEN, BLOCKED, NOT STARTED. These labels do not imply absolute correctness.

## Automation preference

Whenever a fact can be derived reproducibly from an authoritative machine-readable source or a successful build, test, proof, or static analysis, prefer generating it automatically rather than maintaining a manually edited duplicate.

This applies particularly to Lean and test counts, build and test results, toolchain and dependency versions, generated specification metrics, CI status, and release metadata.

## Current versus historical material

A current document describes the state presently claimed by the project. A historical document explains a previous state, decision, or line of reasoning. Historical material must not become normative merely through accumulation or detail.
