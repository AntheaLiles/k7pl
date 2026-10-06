<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Research

K7PL is a research project on the design and formal treatment of a programming language whose specification, formalisation, implementation, proofs, and executable tests remain traceable but distinct.

**Document version:** 1.0.0  
**Last updated:** 2026-10-06  
**Audience:** researchers, reviewers, contributors.

## Research problem

The problem is not merely to implement another programming language. It is to establish a development chain in which semantic and structural commitments made by a language specification can be represented, analyzed, formalized, implemented, and verified without silently changing their meaning between stages.

This combines language design, formal semantics, proof engineering, and scientific traceability.

## Research hypothesis

A language specification can be developed as a scientific object when its normative commitments are explicit, dependencies are traceable, formalizable content is represented in a proof assistant, and implementation and testing evidence can be related back to those commitments.

The hypothesis is stronger than “the implementation compiles” but weaker than a claim that the complete language is already formally verified.

## Scientific object

The object comprises language concepts and dependencies, the normative specification, its formal representation, properties selected for proof, the executable implementation, tests and counterexamples, and the assurance argument connecting them.

## Expected contributions

The project aims to contribute a precise language design and specification, a formal account of selected properties, proof-oriented Lean representations, an executable implementation with an explicit relation to the formal model, a reproducible assurance process, and a methodology for moving from specification claims to formal and executable evidence.

The exact scientific contribution claims remain subject to formal review.

## Validation strategy

Validation is multi-layered: specification review; formalisation analysis; Lean proofs; executable tests; consistency audits; and reproducibility through CI.

No individual layer substitutes for the others.

## Current limitations

The project remains under active specification review. Lean infrastructure and executable tests must not be interpreted as evidence that the complete normative specification has been formalized or that implementation conformance is already proven.

See [ASSURANCE.md](ASSURANCE.md) and [STATUS.md](STATUS.md).

## Open research questions

Open questions include the characterization of the mathematical foundations, the architecture of formal semantics, completeness of specification-to-formalisation correspondence, and properties for which implementation conformance can ultimately be established.

Detailed research history remains in the existing legacy material until the planned migration programme.
