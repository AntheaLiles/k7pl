<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Research demonstrator: requirement-to-evidence traceability

**Status:** non-normative research prototype; no legal, regulatory, contractual, or certification claim.

This is a second, independent work item for [K7PL issue #122](https://github.com/AntheaLiles/k7pl/issues/122). It addresses requirements and project artefacts rather than component inventories, SPDX documents, or SBOM generation. The model lives in `tools/Compliance/RequirementEvidence.lean`; executable regression examples are in `tests/RequirementEvidenceTest.lean`. It is built as part of the existing experimental compliance library and test roots. It changes neither `spec/` nor `src/K7pl/`.

## Target claim

For one identified requirement, the model may return `satisfied` only when (a) a current, accountable applicability decision says that the requirement applies, (b) the evidence refers to the same requirement, source revision, artifact, and artifact revision, (c) the evidence is marked verified and reviewed, and (d) there is no contradictory current evidence. An exception is accepted only when its reason and approver are present, its source/artifact revisions match, and its expiry has not passed.

The model intentionally has no `nonCompliant` result. Missing, stale, unreviewed, or disputed evidence is not sufficient to prove that the real-world requirement was violated. Such cases remain `needsEvidenceReview`; conflicting current applicability decisions and evidence produce separate conflict results. A current `notApplicable` outcome requires an explicit decision with a rationale and decision maker.

## Inputs and expected behavior

| Input mutation | Expected assessment | Reason |
|---|---|---|
| Current applicability decision and verified evidence for current revisions | `satisfied` | All modelled identity and review conditions hold |
| Applicability decision references an older source revision | `needsApplicabilityDecision` | The old decision cannot be reused silently |
| Two current applicability decisions disagree | `conflictingApplicabilityDecisions` | Conflict is represented rather than resolved by order |
| Evidence references an older source or artifact revision | `needsEvidenceReview` | Stale evidence cannot establish the current state |
| Current evidence is disputed, unreviewed, or lacks a reviewer | `needsEvidenceReview` | The record has not met the model's acceptance condition |
| Current evidence statuses disagree | `conflictingEvidence` | No implicit priority is given to one evidence record |
| Applicable requirement has no current evidence and no valid exception | `needsEvidenceReview` | Absence of evidence is not proof of a violation |
| Approved exception matches the current source/artifact and has not expired | `excepted` | A time-bounded, explicitly represented exception is accepted |
| Exception is expired, unapproved, lacks a reason, or cites an old revision | `needsEvidenceReview` | The exception does not justify the current state |
| Applicability is explicitly and accountably marked not applicable | `notApplicable` | Non-applicability is a decision, not an inference from missing evidence |

These cases are pinned by Lean `#guard` regressions. The theorem `requirementSatisfiedRequiresReviewedEvidence` establishes the model's central implication: the `satisfied` outcome implies that all selected current evidence records are marked verified and have a non-empty reviewer field. That implication is about values in the model, not about whether the reviewer is authorized or whether the underlying evidence is true.

## Formal boundary and limitations

The proof does **not** establish that:
- the requirement text was transcribed faithfully from a source document;
- a source URI identifies an authentic, current, or authoritative regulation, standard, or contract;
- a revision number is a cryptographic or immutable source identifier;
- a decision maker or approver is authenticated or has delegated authority;
- a reviewer inspected the real project artefact correctly;
- `verified` means the artefact really satisfies the requirement;
- the modeled set of requirements is complete, or that a whole project is compliant.

The prototype uses natural-number revision labels to make version relationships explicit in a small, readable model. A production design would need stable source/artifact identifiers, source provenance and hashes, applicability rules, delegated authority, exception lifecycle, conflicting-source policy, temporal semantics, and a link to the actual document-management system. It must distinguish a source change from an artefact change and re-open affected decisions when either version changes.

## Alternatives and decision

A spreadsheet or requirements-management system with mandatory links and review states may be sufficient for traceability alone. A workflow engine may be better for collecting approvals and expiry notifications. Lean is useful only for checking a precisely stated invariant over a normalized snapshot, such as the implication from `satisfied` to reviewed current evidence. It is not a substitute for a document-management system, source interpretation, or human sign-off.

**Recommendation:** GO for this small research demonstrator and its counterexamples; NO-GO for treating it as a production compliance engine or changing the normative K7PL language. The next validation step is an independently reviewed mapping from one real, non-safety-critical requirement to its source revision, artifact revision, reviewer, and one deliberately stale counterexample. No such real project input is included here.
