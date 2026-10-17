-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Compliance.SbomAudit

open Lean
open Compliance.SbomAudit

namespace SbomAuditTest

def sampleRevision : String := "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

def unicodeWhitespaceOnlyName : String := String.singleton (Char.ofNat 160)

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

example : verifyContract sampleInput = true ↔ InventoryContract sampleInput := by
  exact verifyContract_iff_inventoryContract sampleInput

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

def emptyInventoryReport : AuditReport :=
  auditTexts
    "{\"name\":\"k7pl\",\"packages\":[]}"
    "{\"spdxVersion\":\"SPDX-2.3\",\"SPDXID\":\"SPDXRef-DOCUMENT\",\"packages\":[],\"relationships\":[]}"
    "manifest.json" "spdx.json"

def duplicateRelationshipInput : AuditInput :=
  { sampleInput with relationships := [sampleRelationship, sampleRelationship] }

def tests : List (String × Bool) :=
  [ ("valid normalized inventory passes", verifyContract sampleInput)
  , ("revision format is enforced",
      !(verifyContract { sampleInput with manifestPackages := [{ sampleManifestPackage with rev := "bad" }] }))
  , ("component revision must be preserved",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with versionInfo := "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" }] }))
  , ("component URL must be preserved",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with downloadLocation := "https://example.invalid/alpha" }] }))
  , ("empty component identity is rejected",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with name := "" }] }))
  , ("whitespace-only manifest package name is rejected",
      !(verifyContract { sampleInput with
        manifestPackages := [{ sampleManifestPackage with name := "   " }] }))
  , ("whitespace-only SPDX package name is rejected",
      !(verifyContract { sampleInput with
        packages := [{ sampleSbomPackage with name := "   " }] }))
  , ("Unicode whitespace-only manifest package name is rejected",
      !(verifyContract { sampleInput with
        manifestPackages := [{ sampleManifestPackage with name := unicodeWhitespaceOnlyName }] }))
  , ("Unicode whitespace-only SPDX package name is rejected",
      !(verifyContract { sampleInput with
        packages := [{ sampleSbomPackage with name := unicodeWhitespaceOnlyName }] }))
  , ("whitespace-only manifest package name has an identity diagnostic",
      (auditIssues { sampleInput with
        manifestPackages := [{ sampleManifestPackage with name := "   " }] }).any
        (fun item => item.ruleId == "SBOM-MANIFEST-EMPTY-IDENTITY"))
  , ("whitespace-only SPDX package name has an identity diagnostic",
      (auditIssues { sampleInput with
        packages := [{ sampleSbomPackage with name := "   " }] }).any
        (fun item => item.ruleId == "SBOM-PACKAGE-EMPTY-IDENTITY"))
  , ("unknown licence metadata remains NOASSERTION",
      !(verifyContract { sampleInput with packages := [{ sampleSbomPackage with licenseDeclared := "MIT" }] }))
  , ("invented dependency edge is rejected",
      !(verifyContract { sampleInput with relationships := [{ sampleRelationship with relationshipType := "DEPENDS_ON" }] }))
  , ("missing relationship is rejected",
      !(verifyContract { sampleInput with relationships := [] }))
  , ("duplicate package IDs are rejected",
      !(verifyContract { sampleInput with
        packages := [sampleSbomPackage, sampleSbomPackage],
        relationships := [sampleRelationship, sampleRelationship] }))
  , ("wrong SPDX version is rejected",
      !(verifyContract { sampleInput with spdxVersion := "SPDX-2.2" }))
  , ("invalid manifest JSON reports ERROR",
      (auditTexts "{" "{}" "manifest.json" "spdx.json").status == "ERROR")
  , ("invalid SPDX JSON reports ERROR",
      (auditTexts "{\"name\":\"k7pl\",\"packages\":[]}" "{" "manifest.json" "spdx.json").status == "ERROR")
  , ("duplicate relationship targets are rejected",
      !(verifyContract duplicateRelationshipInput))
  , ("empty inventory is rejected",
      !(verifyContract { sampleInput with manifestPackages := [], packages := [], relationships := [] }))
  , ("empty inventory reports FAIL with a profile-specific diagnostic",
      emptyInventoryReport.status == "FAIL" &&
      emptyInventoryReport.diagnostics.any (fun item => item.ruleId == "SBOM-EMPTY-INVENTORY"))
  , ("valid input has no diagnostics", (auditIssues sampleInput).isEmpty)
  , ("missing required manifest field is rejected",
      match parseAuditInput malformedManifest emptySbom with
      | .error _ => true
      | .ok _ => false)
  ]

end SbomAuditTest
