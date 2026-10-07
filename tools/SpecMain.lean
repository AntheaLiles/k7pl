-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import Spec
import SpecExt

open Verso.Genre Manual

/-- Rendering options: the figures of `spec/figures` are copied next to the HTML pages and the TeX
sources (the generator runs from the root of the repository). -/
def config : RenderConfig where
  extraFiles := [("spec/figures", "figures")]
  sourceLink := some "https://github.com/AntheaLiles/k7pl"
  issueLink := some "https://github.com/AntheaLiles/k7pl/issues"

/-- The output directory requested on the command line (`--output <dir>`), `_out` by default. -/
def outputDir (args : List String) : System.FilePath :=
  match args.dropWhile (· != "--output") with
  | _ :: dir :: _ => dir
  | _ => "_out"

/-- Renders the specification: HTML into `_out/` by default, or into `--output <dir>`; with
`--with-tex`, also the LaTeX sources of the PDF. The index and the glossary hints are marked in the
text before rendering (`SpecExt.autoMark`), and the interface of the HTML pages is put in French
afterwards (`SpecExt.Translate`). -/
def main (args : List String) : IO UInt32 := do
  let code ← manualMain (SpecExt.autoMark (%doc Spec)) (options := args) (config := config)
  let html := outputDir args / "html-multi"
  if code == 0 && (← html.isDir) then
    let n ← SpecExt.Translate.translateTree html
    IO.println s!"interface en français : {n} fichiers traduits"
  return code
