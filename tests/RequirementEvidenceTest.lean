-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Compliance.RequirementEvidence

open Compliance.RequirementEvidence

namespace RequirementEvidenceTest

def currentRequirement : Requirement :=
  { id := "R-17"
    sourceRef := "contract://demo/revision/3"
    sourceRevision := 3
    artifactId := "ETMT-PEB"
    artifactRevision := 5 }

def applicableDecision : ApplicabilityDecision :=
  { requirementId := currentRequirement.id
    sourceRef := currentRequirement.sourceRef
    sourceRevision := currentRequirement.sourceRevision
    status := .applicable
    decidedBy := "reviewer-1"
    rationale := "The clause applies to this deliverable." }

def verifiedEvidence : Evidence :=
  { requirementId := currentRequirement.id
    sourceRef := currentRequirement.sourceRef
    sourceRevision := currentRequirement.sourceRevision
    artifactId := currentRequirement.artifactId
    artifactRevision := currentRequirement.artifactRevision
    status := .verified
    reviewedBy := "reviewer-2" }

def staleSourceEvidence : Evidence :=
  { verifiedEvidence with sourceRevision := 2 }

def staleArtifactEvidence : Evidence :=
  { verifiedEvidence with artifactRevision := 4 }

def disputedEvidence : Evidence :=
  { verifiedEvidence with status := .disputed }

def unreviewedEvidence : Evidence :=
  { verifiedEvidence with status := .unreviewed, reviewedBy := "" }

def validException : Exception :=
  { requirementId := currentRequirement.id
    sourceRef := currentRequirement.sourceRef
    sourceRevision := currentRequirement.sourceRevision
    artifactId := currentRequirement.artifactId
    artifactRevision := currentRequirement.artifactRevision
    reason := "A documented project-specific deviation was accepted."
    approvedBy := "approver-1"
    expiresAt := 8 }

def notApplicableDecision : ApplicabilityDecision :=
  { applicableDecision with
    status := .notApplicable
    rationale := "The scope condition was reviewed and does not apply." }

def conflictingNotApplicableDecision : ApplicabilityDecision :=
  { notApplicableDecision with decidedBy := "reviewer-3" }

def obsoleteDecision : ApplicabilityDecision :=
  { applicableDecision with sourceRevision := 2 }

#guard assessRequirement currentRequirement [applicableDecision] [verifiedEvidence] [] 5 == .satisfied
#guard assessRequirement currentRequirement [] [verifiedEvidence] [] 5 == .needsApplicabilityDecision
#guard assessRequirement currentRequirement [obsoleteDecision] [verifiedEvidence] [] 5 == .needsApplicabilityDecision
#guard assessRequirement currentRequirement [applicableDecision, notApplicableDecision] [verifiedEvidence] [] 5 == .conflictingApplicabilityDecisions
#guard assessRequirement currentRequirement [notApplicableDecision] [] [] 5 == .notApplicable

-- Evidence is tied to both the source revision and the artifact revision.
#guard assessRequirement currentRequirement [applicableDecision] [staleSourceEvidence] [] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [staleArtifactEvidence] [] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [disputedEvidence] [] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [unreviewedEvidence] [] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [verifiedEvidence, disputedEvidence] [] 5 == .conflictingEvidence

-- Exceptions need accountable metadata, matching revisions, and a non-expired validity window.
#guard assessRequirement currentRequirement [applicableDecision] [] [validException] 5 == .excepted
#guard assessRequirement currentRequirement [applicableDecision] [] [{ validException with expiresAt := 4 }] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [] [{ validException with sourceRevision := 2 }] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [] [{ validException with approvedBy := "" }] 5 == .needsEvidenceReview
#guard assessRequirement currentRequirement [applicableDecision] [] [{ validException with reason := "" }] 5 == .needsEvidenceReview

-- A purported decision without both a decision maker and rationale is not accepted.
#guard assessRequirement currentRequirement [{ applicableDecision with decidedBy := "" }] [verifiedEvidence] [] 5 == .needsApplicabilityDecision
#guard assessRequirement currentRequirement [{ applicableDecision with rationale := "   " }] [verifiedEvidence] [] 5 == .needsApplicabilityDecision

-- Malformed identities are explicit failures; missing evidence is never called non-compliance.
#guard assessRequirement { currentRequirement with id := "   " } [applicableDecision] [verifiedEvidence] [] 5 == .invalidRequirement
#guard assessRequirement currentRequirement [applicableDecision] [] [] 5 != .satisfied

end RequirementEvidenceTest
