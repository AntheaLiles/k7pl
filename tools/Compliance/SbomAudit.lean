-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Lean

/-!
Bounded consistency audit for the K7PL Lake dependency inventory.

This module checks a narrow contract between the repository's Lake manifest and K7PL's existing
SPDX 2.3 inventory. It is not a general SPDX validator and does not infer dependency edges.
-/

open Lean

namespace Compliance.SbomAudit

structure ManifestPackage where
  name : String
  url : String
  rev : String
deriving Repr, Inhabited

structure SbomPackage where
  name : String
  spdxId : String
  versionInfo : String
  downloadLocation : String
  licenseDeclared : String
  licenseConcluded : String
  copyrightText : String
deriving Repr, Inhabited

structure SbomRelationship where
  spdxElementId : String
  relationshipType : String
  relatedSpdxElement : String
deriving Repr, Inhabited

structure AuditInput where
  manifestName : String
  manifestPackages : List ManifestPackage
  spdxVersion : String
  documentId : String
  packages : List SbomPackage
  relationships : List SbomRelationship
deriving Repr, Inhabited

def lowerHexDigit (c : Char) : Bool :=
  c.isDigit || c == 'a' || c == 'b' || c == 'c' || c == 'd' || c == 'e' || c == 'f'

def validRevision (revision : String) : Bool :=
  revision.length == 40 && revision.toList.all lowerHexDigit

/-- Computable duplicate check for a finite list of component identifiers. -/
def allDistinct : List String → Bool
  | [] => true
  | item :: rest => !(rest.contains item) && allDistinct rest

def sameComponent (manifestPackage : ManifestPackage) (sbomPackage : SbomPackage) : Bool :=
  manifestPackage.name == sbomPackage.name &&
  manifestPackage.url == sbomPackage.downloadLocation &&
  manifestPackage.rev == sbomPackage.versionInfo

def sameInventory (input : AuditInput) : Bool :=
  input.manifestPackages.length == input.packages.length &&
  input.manifestPackages.all (fun item => input.packages.any (sameComponent item)) &&
  input.packages.all (fun item => input.manifestPackages.any (fun source => sameComponent source item))

/--
The proposition covers only the represented fields. It does not assert inventory completeness,
discover omitted packages, establish licence compatibility, query vulnerability databases, or prove
the JSON parser or schema validator correct.
-/
def InventoryContract (input : AuditInput) : Prop :=
  (input.manifestName == "k7pl") = true ∧
  (input.spdxVersion == "SPDX-2.3") = true ∧
  (input.documentId == "SPDXRef-DOCUMENT") = true ∧
  allDistinct (input.manifestPackages.map (fun item => item.name)) = true ∧
  (input.manifestPackages.all (fun item => item.name != "" && item.url != "")) = true ∧
  allDistinct (input.packages.map (fun item => item.name)) = true ∧
  (input.packages.all (fun item => item.name != "" && item.downloadLocation != "")) = true ∧
  allDistinct (input.packages.map (fun item => item.spdxId)) = true ∧
  (input.packages.all (fun item => item.spdxId != "" && item.spdxId != "SPDXRef-DOCUMENT")) = true ∧
  (input.manifestPackages.all (fun item => validRevision item.rev)) = true ∧
  sameInventory input = true ∧
  (input.packages.all (fun item =>
    item.licenseDeclared == "NOASSERTION" &&
    item.licenseConcluded == "NOASSERTION" &&
    item.copyrightText == "NOASSERTION")) = true ∧
  (input.relationships.length == input.packages.length) = true ∧
  allDistinct (input.relationships.map (fun item => item.relatedSpdxElement)) = true ∧
  (input.relationships.all (fun item =>
    item.spdxElementId == "SPDXRef-DOCUMENT" &&
    item.relationshipType == "DESCRIBES" &&
    input.packages.any (fun package => package.spdxId == item.relatedSpdxElement))) = true ∧
  (input.packages.all (fun package =>
    input.relationships.any (fun relation => relation.relatedSpdxElement == package.spdxId))) = true

/-- Executable decision procedure, using only Boolean checks on the finite model. -/
def verifyContract (input : AuditInput) : Bool :=
  (input.manifestName == "k7pl") &&
  (input.spdxVersion == "SPDX-2.3") &&
  (input.documentId == "SPDXRef-DOCUMENT") &&
  allDistinct (input.manifestPackages.map (fun item => item.name)) &&
  input.manifestPackages.all (fun item => item.name != "" && item.url != "") &&
  allDistinct (input.packages.map (fun item => item.name)) &&
  input.packages.all (fun item => item.name != "" && item.downloadLocation != "") &&
  allDistinct (input.packages.map (fun item => item.spdxId)) &&
  input.packages.all (fun item => item.spdxId != "" && item.spdxId != "SPDXRef-DOCUMENT") &&
  input.manifestPackages.all (fun item => validRevision item.rev) &&
  sameInventory input &&
  input.packages.all (fun item =>
    item.licenseDeclared == "NOASSERTION" &&
    item.licenseConcluded == "NOASSERTION" &&
    item.copyrightText == "NOASSERTION") &&
  (input.relationships.length == input.packages.length) &&
  allDistinct (input.relationships.map (fun item => item.relatedSpdxElement)) &&
  input.relationships.all (fun item =>
    item.spdxElementId == "SPDXRef-DOCUMENT" &&
    item.relationshipType == "DESCRIBES" &&
    input.packages.any (fun package => package.spdxId == item.relatedSpdxElement)) &&
  input.packages.all (fun package =>
    input.relationships.any (fun relation => relation.relatedSpdxElement == package.spdxId))

/-- Soundness: a successful computation entails every clause of the declared contract. -/
theorem verifyContract_sound (input : AuditInput) (h : verifyContract input = true) :
    InventoryContract input := by
  simp only [verifyContract, Bool.and_eq_true] at h
  simpa only [InventoryContract] using h

structure Diagnostic where
  ruleId : String
  severity : String
  message : String
  artifact : String
deriving ToJson, Repr, Inhabited

structure AuditReport where
  schemaVersion : String
  tool : String
  toolVersion : String
  status : String
  assuranceScope : String
  sourceArtifacts : Array String
  limitations : Array String
  diagnostics : Array Diagnostic
deriving ToJson, Repr, Inhabited

def diagnostic (ruleId message artifact : String) : Diagnostic :=
  { ruleId := ruleId, severity := "error", message := message, artifact := artifact }

def auditIssues (input : AuditInput) : List Diagnostic :=
  (if input.manifestName == "k7pl" then [] else
    [diagnostic "SBOM-MANIFEST-IDENTITY" "The Lake manifest name must be k7pl." "lake-manifest.json"]) ++
  (if input.spdxVersion == "SPDX-2.3" then [] else
    [diagnostic "SBOM-SPDX-VERSION" "The document must declare SPDX-2.3 for this prototype." "spdx"]) ++
  (if input.documentId == "SPDXRef-DOCUMENT" then [] else
    [diagnostic "SBOM-DOCUMENT-ID" "The document ID must be SPDXRef-DOCUMENT." "spdx"]) ++
  (if allDistinct (input.manifestPackages.map (fun item => item.name)) then [] else
    [diagnostic "SBOM-MANIFEST-DUPLICATE-NAME" "The Lake manifest contains duplicate package names." "lake-manifest.json"]) ++
  (if input.manifestPackages.all (fun item => item.name != "" && item.url != "") then [] else
    [diagnostic "SBOM-MANIFEST-EMPTY-IDENTITY" "A manifest package has an empty name or repository URL." "lake-manifest.json"]) ++
  (if allDistinct (input.packages.map (fun item => item.name)) then [] else
    [diagnostic "SBOM-DUPLICATE-PACKAGE-NAME" "The SPDX inventory contains duplicate package names." "spdx"]) ++
  (if input.packages.all (fun item => item.name != "" && item.downloadLocation != "") then [] else
    [diagnostic "SBOM-PACKAGE-EMPTY-IDENTITY" "An SPDX package has an empty name or download location." "spdx"]) ++
  (if allDistinct (input.packages.map (fun item => item.spdxId)) then [] else
    [diagnostic "SBOM-DUPLICATE-SPDX-ID" "The SPDX inventory contains duplicate package identifiers." "spdx"]) ++
  (if input.packages.all (fun item => item.spdxId != "" && item.spdxId != "SPDXRef-DOCUMENT") then [] else
    [diagnostic "SBOM-PACKAGE-ID" "A package identifier is empty or conflicts with the document identifier." "spdx"]) ++
  (if input.manifestPackages.all (fun item => validRevision item.rev) then [] else
    [diagnostic "SBOM-REVISION-FORMAT" "A Lake revision is not forty lowercase hexadecimal characters." "lake-manifest.json"]) ++
  (if sameInventory input then [] else
    [diagnostic "SBOM-INVENTORY-MISMATCH" "Package names, URLs, and exact resolved revisions must be preserved." "lake-manifest.json;spdx"]) ++
  (if input.packages.all (fun item =>
      item.licenseDeclared == "NOASSERTION" &&
      item.licenseConcluded == "NOASSERTION" &&
      item.copyrightText == "NOASSERTION") then [] else
    [diagnostic "SBOM-UNKNOWN-LICENSE-ASSERTION" "Unknown licence and copyright facts must remain NOASSERTION." "spdx"]) ++
  (if input.relationships.length == input.packages.length then [] else
    [diagnostic "SBOM-RELATIONSHIP-COUNT" "Exactly one DESCRIBES relationship per package is required." "spdx"]) ++
  (if allDistinct (input.relationships.map (fun item => item.relatedSpdxElement)) then [] else
    [diagnostic "SBOM-DUPLICATE-RELATIONSHIP-TARGET" "A package is the target of more than one relationship." "spdx"]) ++
  (if input.relationships.all (fun item =>
      item.spdxElementId == "SPDXRef-DOCUMENT" &&
      item.relationshipType == "DESCRIBES" &&
      input.packages.any (fun package => package.spdxId == item.relatedSpdxElement)) then [] else
    [diagnostic "SBOM-RELATIONSHIP-INVALID" "Only SPDXRef-DOCUMENT DESCRIBES relationships to existing package IDs are in scope; dependency edges must not be invented." "spdx"]) ++
  (if input.packages.all (fun package =>
      input.relationships.any (fun relation => relation.relatedSpdxElement == package.spdxId)) then [] else
    [diagnostic "SBOM-RELATIONSHIP-MISSING" "At least one package has no DESCRIBES relationship." "spdx"])

def reportLimitations : Array String := #[
  "This is not a complete SPDX 2.3 schema or semantic validator; validate the document independently.",
  "Only entries present in lake-manifest.json are covered; this check cannot prove the manifest is complete.",
  "The flattened Lake inventory does not establish a complete direct/transitive dependency graph.",
  "The theorem applies to the normalized Lean model; JSON parsing, file I/O, toolchain integrity and external validation are outside the theorem.",
  "No absence of vulnerabilities, licence compatibility, legal compliance, or production readiness is established."
]

def makeReport (manifestPath sbomPath status : String) (issues : List Diagnostic) : AuditReport :=
  { schemaVersion := "k7pl.compliance-report/v1"
    tool := "k7pl-sbom-audit"
    toolVersion := "0.1.0"
    status := status
    assuranceScope := "Consistency of represented K7PL Lake package entries with the scoped SPDX 2.3 inventory contract."
    sourceArtifacts := #[manifestPath, sbomPath]
    limitations := reportLimitations
    diagnostics := issues.toArray }

def arrayField (document : Json) (key : String) : Except String (Array Json) := do
  match (← document.getObjVal? key) with
  | .arr values => pure values
  | _ => throw s!"field '{key}' is not a JSON array"

def parseManifestPackage (value : Json) : Except String ManifestPackage := do
  let name ← value.getObjValAs? String "name"
  let url ← value.getObjValAs? String "url"
  let rev ← value.getObjValAs? String "rev"
  pure { name, url, rev }

def parseSbomPackage (value : Json) : Except String SbomPackage := do
  let name ← value.getObjValAs? String "name"
  let spdxId ← value.getObjValAs? String "SPDXID"
  let versionInfo ← value.getObjValAs? String "versionInfo"
  let downloadLocation ← value.getObjValAs? String "downloadLocation"
  let licenseDeclared ← value.getObjValAs? String "licenseDeclared"
  let licenseConcluded ← value.getObjValAs? String "licenseConcluded"
  let copyrightText ← value.getObjValAs? String "copyrightText"
  pure { name, spdxId, versionInfo, downloadLocation, licenseDeclared, licenseConcluded, copyrightText }

def parseRelationship (value : Json) : Except String SbomRelationship := do
  let spdxElementId ← value.getObjValAs? String "spdxElementId"
  let relationshipType ← value.getObjValAs? String "relationshipType"
  let relatedSpdxElement ← value.getObjValAs? String "relatedSpdxElement"
  pure { spdxElementId, relationshipType, relatedSpdxElement }

def parseAuditInput (manifestDocument sbomDocument : Json) : Except String AuditInput := do
  let manifestName ← manifestDocument.getObjValAs? String "name"
  let manifestValues ← arrayField manifestDocument "packages"
  let manifestPackages ← manifestValues.mapM parseManifestPackage
  let spdxVersion ← sbomDocument.getObjValAs? String "spdxVersion"
  let documentId ← sbomDocument.getObjValAs? String "SPDXID"
  let packageValues ← arrayField sbomDocument "packages"
  let packages ← packageValues.mapM parseSbomPackage
  let relationshipValues ← arrayField sbomDocument "relationships"
  let relationships ← relationshipValues.mapM parseRelationship
  pure {
    manifestName,
    manifestPackages := manifestPackages.toList,
    spdxVersion,
    documentId,
    packages := packages.toList,
    relationships := relationships.toList
  }

def auditTexts (manifestText sbomText manifestPath sbomPath : String) : AuditReport :=
  match Json.parse manifestText with
  | .error message =>
      makeReport manifestPath sbomPath "ERROR"
        [diagnostic "INPUT-JSON-MANIFEST" s!"The Lake manifest is not valid JSON: {message}" manifestPath]
  | .ok manifestDocument =>
      match Json.parse sbomText with
      | .error message =>
          makeReport manifestPath sbomPath "ERROR"
            [diagnostic "INPUT-JSON-SPDX" s!"The SPDX input is not valid JSON: {message}" sbomPath]
      | .ok sbomDocument =>
          match parseAuditInput manifestDocument sbomDocument with
          | .error message =>
              makeReport manifestPath sbomPath "ERROR"
                [diagnostic "INPUT-SHAPE" s!"A required field is missing or has the wrong type: {message}" "inputs"]
          | .ok input =>
              let issues := auditIssues input
              let ok := verifyContract input
              let finalIssues :=
                if ok then issues
                else if issues.isEmpty then
                  [diagnostic "SBOM-CONTRACT" "The normalized inputs do not satisfy the inventory contract." "lake-manifest.json;spdx"]
                else issues
              makeReport manifestPath sbomPath (if ok then "PASS" else "FAIL") finalIssues

end Compliance.SbomAudit
