-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Lean

/-!
A non-normative model for requirement-to-evidence traceability.

This model intentionally does not interpret the text of a law, standard, contract, or business rule.
It checks only the identity/version/status relations represented below. A successful result is
not a legal or organizational compliance claim.
-/

namespace Compliance.RequirementEvidence

inductive Applicability where
  | applicable
  | notApplicable
  | unresolved
  deriving DecidableEq, Repr, Inhabited

inductive EvidenceStatus where
  | verified
  | unreviewed
  | disputed
  deriving DecidableEq, Repr, Inhabited

inductive Assessment where
  | invalidRequirement
  | needsApplicabilityDecision
  | conflictingApplicabilityDecisions
  | notApplicable
  | conflictingEvidence
  | needsEvidenceReview
  | excepted
  | satisfied
  deriving DecidableEq, Repr, Inhabited

/-- An identified requirement and the current source/artifact revisions to which it applies. -/
structure Requirement where
  id : String
  sourceRef : String
  sourceRevision : Nat
  artifactId : String
  artifactRevision : Nat
  deriving DecidableEq, Repr, Inhabited

/-- Applicability is an explicit, accountable decision tied to a source revision. -/
structure ApplicabilityDecision where
  requirementId : String
  sourceRef : String
  sourceRevision : Nat
  status : Applicability
  decidedBy : String
  rationale : String
  deriving DecidableEq, Repr, Inhabited

/-- Evidence links one requirement to one artifact revision and one source revision. -/
structure Evidence where
  requirementId : String
  sourceRef : String
  sourceRevision : Nat
  artifactId : String
  artifactRevision : Nat
  status : EvidenceStatus
  reviewedBy : String
  deriving DecidableEq, Repr, Inhabited

/-- An exception is scoped to the same revisions and requires a reason, approver, and expiry. -/
structure Exception where
  requirementId : String
  sourceRef : String
  sourceRevision : Nat
  artifactId : String
  artifactRevision : Nat
  reason : String
  approvedBy : String
  expiresAt : Nat
  deriving DecidableEq, Repr, Inhabited

/-- The model's minimal placeholder for a non-empty human-supplied field. -/
def hasText (value : String) : Bool :=
  value.trimAscii.toString != ""

/-- This is structural identity validation, not validation of the source's meaning. -/
def wellFormedRequirement (requirement : Requirement) : Bool :=
  hasText requirement.id && hasText requirement.sourceRef && hasText requirement.artifactId

def validApplicabilityDecision
    (requirement : Requirement) (decision : ApplicabilityDecision) : Bool :=
  decision.requirementId == requirement.id &&
  decision.sourceRef == requirement.sourceRef &&
  decision.sourceRevision == requirement.sourceRevision &&
  hasText decision.decidedBy &&
  hasText decision.rationale

/-- Decisions for obsolete source revisions are deliberately ignored. -/
def relevantApplicabilityDecisions
    (requirement : Requirement) (decisions : List ApplicabilityDecision) :
    List ApplicabilityDecision :=
  decisions.filter (validApplicabilityDecision requirement)

/-- Different current applicability decisions are a conflict, not an implicit vote. -/
def conflictingApplicabilityDecisions (decisions : List ApplicabilityDecision) : Bool :=
  match decisions with
  | [] => false
  | first :: rest => rest.any (fun decision => decision.status != first.status)

def matchesCurrentEvidence (requirement : Requirement) (evidence : Evidence) : Bool :=
  evidence.requirementId == requirement.id &&
  evidence.sourceRef == requirement.sourceRef &&
  evidence.sourceRevision == requirement.sourceRevision &&
  evidence.artifactId == requirement.artifactId &&
  evidence.artifactRevision == requirement.artifactRevision

/-- Evidence from an old source or artifact revision cannot establish the current result. -/
def currentEvidence (requirement : Requirement) (evidence : List Evidence) : List Evidence :=
  evidence.filter (matchesCurrentEvidence requirement)

def conflictingEvidence (evidence : List Evidence) : Bool :=
  match evidence with
  | [] => false
  | first :: rest => rest.any (fun item => item.status != first.status)

def allCurrentEvidenceVerifiedAndReviewed (evidence : List Evidence) : Bool :=
  !evidence.isEmpty &&
  evidence.all (fun item => item.status == .verified && hasText item.reviewedBy)

def validException (requirement : Requirement) (exception : Exception) (now : Nat) : Bool :=
  exception.requirementId == requirement.id &&
  exception.sourceRef == requirement.sourceRef &&
  exception.sourceRevision == requirement.sourceRevision &&
  exception.artifactId == requirement.artifactId &&
  exception.artifactRevision == requirement.artifactRevision &&
  hasText exception.reason &&
  hasText exception.approvedBy &&
  decide (now <= exception.expiresAt)

/-- Evaluate evidence only after applicability has been resolved as applicable. -/
def assessEvidence
    (requirement : Requirement) (evidence : List Evidence)
    (exceptions : List Exception) (now : Nat) : Assessment :=
  if (currentEvidence requirement evidence).isEmpty then
    if exceptions.any (fun exception => validException requirement exception now) then
      .excepted
    else
      .needsEvidenceReview
  else if conflictingEvidence (currentEvidence requirement evidence) then
    .conflictingEvidence
  else if allCurrentEvidenceVerifiedAndReviewed (currentEvidence requirement evidence) then
    .satisfied
  else
    .needsEvidenceReview

/--
Assess one requirement, not a whole project.

Missing evidence produces `needsEvidenceReview`, not `nonCompliant`: absence of a recorded
evidence item does not establish that the real-world requirement was violated. Applicability
decisions and exceptions are ignored when their source/artifact versions do not match.
-/
def assessRequirement
    (requirement : Requirement) (decisions : List ApplicabilityDecision)
    (evidence : List Evidence) (exceptions : List Exception) (now : Nat) : Assessment :=
  if wellFormedRequirement requirement then
    match relevantApplicabilityDecisions requirement decisions with
    | [] => .needsApplicabilityDecision
    | first :: rest =>
        if conflictingApplicabilityDecisions (first :: rest) then
          .conflictingApplicabilityDecisions
        else
          match first.status with
          | .unresolved => .needsApplicabilityDecision
          | .notApplicable => .notApplicable
          | .applicable => assessEvidence requirement evidence exceptions now
  else
    .invalidRequirement

/-- If the evidence-only assessor says `satisfied`, its current evidence records are reviewed. -/
theorem satisfiedAssessmentRequiresEvidence
    (requirement : Requirement) (evidence : List Evidence)
    (exceptions : List Exception) (now : Nat)
    (h : assessEvidence requirement evidence exceptions now = .satisfied) :
    allCurrentEvidenceVerifiedAndReviewed (currentEvidence requirement evidence) = true := by
  unfold assessEvidence at h
  cases hEmpty : (currentEvidence requirement evidence).isEmpty with
  | true =>
      cases hException : exceptions.any (fun exception => validException requirement exception now) with
      | true => simp [hEmpty, hException] at h
      | false => simp [hEmpty, hException] at h
  | false =>
      cases hConflict : conflictingEvidence (currentEvidence requirement evidence) with
      | true =>
          simp [hEmpty, hConflict] at h
      | false =>
          cases hVerified : allCurrentEvidenceVerifiedAndReviewed (currentEvidence requirement evidence) with
          | true => simp
          | false => simp [hEmpty, hConflict, hVerified] at h

/-- The full assessor cannot report satisfaction without current, reviewed evidence. -/
theorem requirementSatisfiedRequiresReviewedEvidence
    (requirement : Requirement) (decisions : List ApplicabilityDecision)
    (evidence : List Evidence) (exceptions : List Exception) (now : Nat)
    (h : assessRequirement requirement decisions evidence exceptions now = .satisfied) :
    allCurrentEvidenceVerifiedAndReviewed (currentEvidence requirement evidence) = true := by
  unfold assessRequirement at h
  cases hWellFormed : wellFormedRequirement requirement with
  | false =>
      simp [hWellFormed] at h
  | true =>
      cases hDecisions : relevantApplicabilityDecisions requirement decisions with
      | nil =>
          simp [hWellFormed, hDecisions] at h
      | cons first rest =>
          cases hConflict : conflictingApplicabilityDecisions (first :: rest) with
          | true =>
              simp [hWellFormed, hDecisions, hConflict] at h
          | false =>
              cases hStatus : first.status with
              | unresolved =>
                  simp [hWellFormed, hDecisions, hConflict, hStatus] at h
              | notApplicable =>
                  simp [hWellFormed, hDecisions, hConflict, hStatus] at h
              | applicable =>
                  have hEvidence : assessEvidence requirement evidence exceptions now = .satisfied := by
                    simpa [hWellFormed, hDecisions, hConflict, hStatus] using h
                  exact satisfiedAssessmentRequiresEvidence requirement evidence exceptions now hEvidence

end Compliance.RequirementEvidence
