-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Compliance.SbomAudit

open Lean
open Compliance.SbomAudit

namespace SbomAuditTest

def sampleRevision : String := "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

def sampleManifestPackage : ManifestPackage :=
  { name := "alpha"
    url := "https://github.com/example/alpha"
    rev := sampleRevision }

def sampleSbomPackage : SbomPackage :=
  { name := "alpha"
    spdxId := "SPDXRef-Dependency-alpha-aaaaaaaaaaaa"
    versionInfo := sampleRevision
    downloadLocation := "https://github.com/example/alpha"
    licenseDeclared := "NOASSERTION"
    licenseConcluded := "NOASSERTION"
    copyrightText := "NOASSERTION" }

def sampleRelationship : SbomRelationship :=
  { spdxElementId := "SPDXRef-DOCUMENT"
    relationshipType := "DESCRIBES"
    relatedSpdxElement := sampleSbomPackage.spdxId }

def sampleInput : AuditInput :=
  { manifestName := "k7pl"
    manifestPackages := [sampleManifestPackage]
    spdxVersion := "SPDX-2.3"
    documentId := "SPDXRef-DOCUMENT"
    packages := [sampleSbomPackage]
    relationships := [sampleRelationship] }

example : InventoryContract sampleInput := by
  exact verifyContract_sound sampleInput (by decide)

def malformedManifest : Json :=
  Json.mkObj [
    ("name", toJson "k7pl"),
    ("packages", Json.arr #[Json.mkObj [
      ("name", toJson "alpha"),
      ("url", toJson "https://github.com/example/alpha")
    ]])
  ]

def emptySbom : Json :=
  Json.mkObj [
    ("spdxVersion", toJson "SPDX-2.3"),
    ("SPDXID", toJson "SPDXRef-DOCUMENT"),
    ("packages", Json.arr #[]),
    ("relationships", Json.arr #[])
  ]

def tests : List (String × Bool) :=
  [ ("valid normalized inventory passes", verifyContract sampleInput)
  , ("revision format is enforced",
      !(verifyContract { sampleInput with manifestPackages := [{ sampleManifestPackage with rev := "bad" }] }))
  , ("component revision must be preserved",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with versionInfo := "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" }] }))
  , ("component URL must be preserved",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with downloadLocation := "https://example.invalid/alpha" }] }))
  , ("unknown licence metadata remains NOASSERTION",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with licenseDeclared := "MIT" }] }))
  , ("invented dependency edge is rejected",
      !(verifyContract { sampleInput with relationships := [{ sampleRelationship with relationshipType := "DEPENDS_ON" }] }))
  , ("missing relationship is rejected",
      !(verifyContract { sampleInput with relationships := [] }))
  , ("duplicate package IDs are rejected",
      !(verifyContract { sampleInput with packages := [sampleSbomPackage, sampleSbomPackage]
        , relationships := [sampleRelationship, sampleRelationship] }))
  , ("valid input has no diagnostics", (auditIssues sampleInput).isEmpty)
  , ("missing required manifest field is rejected",
      match parseAuditInput malformedManifest emptySbom with
      | .error _ => true
      | .ok _ => false)
  ]

end SbomAuditTest
