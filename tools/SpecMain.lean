-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import Spec

open Verso.Genre Manual

/-- Rendering options: the figures of `spec/figures` are copied next to the HTML pages and the TeX
sources (the generator runs from the root of the repository). -/
def config : RenderConfig where
  extraFiles := [("spec/figures", "figures")]
  sourceLink := some "https://github.com/AntheaLiles/k7pl"
  issueLink := some "https://github.com/AntheaLiles/k7pl/issues"

/-- Renders the specification: HTML into `_out/` by default, or into `--output <dir>`; with
`--with-tex`, also the LaTeX sources of the PDF. -/
def main (args : List String) : IO UInt32 :=
  manualMain (%doc Spec) (options := args) (config := config)
