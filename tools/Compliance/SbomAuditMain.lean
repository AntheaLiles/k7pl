-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import Compliance.SbomAudit

open Lean
open Compliance.SbomAudit

def main (args : List String) : IO UInt32 := do
  match args with
  | [manifestArgument, sbomArgument] =>
      let manifestPath := System.FilePath.mk manifestArgument
      let sbomPath := System.FilePath.mk sbomArgument
      try
        let manifestText ← IO.FS.readFile manifestPath
        let sbomText ← IO.FS.readFile sbomPath
        let report := auditTexts manifestText sbomText manifestArgument sbomArgument
        IO.println ((toJson report).compress)
        return if report.status == "PASS" then 0 else if report.status == "FAIL" then 1 else 2
      catch _ =>
        let report := makeReport manifestArgument sbomArgument "ERROR"
          [diagnostic "INPUT-READ" "Unable to read one or more input files." "inputs"]
        IO.println ((toJson report).compress)
        return 2
  | _ =>
      let report := makeReport "lake-manifest.json" "spdx.json" "ERROR"
        [diagnostic "USAGE" "Usage: lake exe sbomAudit -- <lake-manifest.json> <spdx-2.3.json>" "arguments"]
      IO.println ((toJson report).compress)
      return 2
