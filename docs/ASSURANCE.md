<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL Scientific Assurance Case

This document states why scientific and formal claims should be considered adequately supported within an explicitly bounded scope. It is not a declaration of absolute correctness and is distinct from software supply-chain assurance.

**Document version:** 1.0.0  
**Last updated:** 2026-10-06  
**Audience:** researchers, reviewers, maintainers.

## 1. Scope and status vocabulary

The case covers relationships among specification, formalisation, implementation, proofs, tests, reviews, reproducibility, and documentation.

Statuses are ESTABLISHED, PARTIAL, UNDER REVIEW, IN PROGRESS, OPEN, BLOCKED, and NOT STARTED. “Established” means established against explicit criteria and scope; it does not mean globally or absolutely proven.

## 2. Claims

### C1 — Conceptual foundations

**Claim:** K7PL's principal concepts and dependencies are explicit enough to support systematic review.

**Argument:** Architecture and specification expose principal layers and distinguish normative commitments from formal and executable artefacts.

**Evidence:** [ARCHITECTURE.md](ARCHITECTURE.md), [spec/](../spec/), and formal review material.

**Status:** PARTIAL

**Limitations:** The next comprehensive formal peer-review cycle is expected to refine conceptual dependency analysis.

### C2 — Specification coherence

**Claim:** Specification coherence is treated as an independent assurance obligation.

**Argument:** Coherence is assessed through adversarial review, explicit issue tracking, and consistency analysis.

**Evidence:** Existing review and tracking material under the legacy documentation tree.

**Status:** UNDER REVIEW

**Limitations:** Absence of an identified contradiction is not proof of global coherence.

### C3 — Specification/formalisation correspondence

**Claim:** Formal artefacts are intended to represent identifiable normative commitments rather than silently replacing them.

**Argument:** Method requires traceability from formal statements to normative commitments and forbids weakening the specification solely to make formalisation succeed.

**Evidence:** [METHOD.md](METHOD.md), [ARCHITECTURE.md](ARCHITECTURE.md), Lean source, consistency-audit procedures.

**Status:** PARTIAL

**Limitations:** A complete specification-to-formalisation traceability graph is not yet claimed.

### C4 — Implementation conformance

**Claim:** Implementation correctness is separate from compilation and testing.

**Argument:** The project separates implementation, proof, and test evidence and does not infer specification conformance from successful compilation.

**Evidence:** [ARCHITECTURE.md](ARCHITECTURE.md), [METHOD.md](METHOD.md), Lean implementation and tests.

**Status:** OPEN

**Limitations:** A complete conformance argument is not currently claimed.

### C5 — Verification

**Claim:** Declared computational and formal checks are reproducibly executed by CI for the relevant impact scope.

**Argument:** CI performs configured specification checks, Lean builds, tests, linting, axiom audits, link checks, REUSE checks, and security checks.

**Evidence:** [.github/workflows/ci.yaml](../.github/workflows/ci.yaml), reusable verification workflow, CI records.

**Status:** PARTIAL

**Limitations:** CI success establishes execution of configured checks, not correctness of every scientific claim.

### C6 — Reproducibility and traceability

**Claim:** Project artefacts and validation processes are sufficiently traceable to support reproduction of declared checks.

**Argument:** Source, specification, tests, CI configuration, licensing metadata, releases, and archival records are maintained in the repository and release infrastructure.

**Evidence:** Repository history, CI workflows, REUSE metadata, releases, CITATION.cff, archival records.

**Status:** PARTIAL

**Limitations:** Reproducibility of every historical result and complete provenance of every external dependency are not claimed.

## 3. Evidence classes

| Evidence | What it can establish |
|---|---|
| Mathematical proof | The stated proposition in the formal system |
| Formal verification | The stated machine-checked obligation |
| Computational check | The result of the specified computation |
| Test | Behaviour exercised by the test |
| Static analysis | The properties covered by the analyzer |
| Peer review | Objections, counterexamples, and assessment within review scope |
| Design rationale | Why a project decision was made |
| Reproducibility evidence | That a declared process can be rerun under stated conditions |

Invalid inferences include: Lean theorem proved ≠ implementation proven correct; passing tests ≠ specification proven coherent; successful build ≠ formalisation complete; peer review without identified objection ≠ mathematical proof.

## 4. Traceability model

    Scientific claim
          │
          ▼
    Normative requirement
          │
          ▼
    Formal statement
          │
          ▼
    Lean definition / theorem
          │
          ▼
         Proof
          │
          ▼
    Executable evidence
          │
          ▼
    Assurance claim

The reverse direction is also required: a Lean theorem must be traceable to the normative commitment it supports.

## 5. Assurance gaps

1. Complete the specification coherence assessment.
2. Construct a systematic specification-to-formalisation trace.
3. Define and verify the intended implementation-conformance boundary.
4. Consolidate peer-review objections and resolutions as evidence.
5. Expand reproducibility evidence where current CI evidence is insufficient.

These gaps are intentionally visible.
