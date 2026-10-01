-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual

/-!
# LaTeX set-up

`{texsetup}` renders nothing; its presence adds to the LaTeX preamble the packages that the whole
document relies on: `unicode-math` (the mathematics of the manuscript is written with its symbol
names), `tabularx` and `array` (tables), `graphicx` (figures); it also puts the running heads
and the table of contents in French.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse

namespace SpecExt

block_extension Block.texsetup where
  data := Json.null
  traverse _ _ _ := pure none
  toHtml := some fun _ _ _ _ _ => pure .empty
  toTeX := some fun _ _ _ _ _ => pure .empty
  usePackages := [
    "\\usepackage{amsmath}\n\\usepackage{unicode-math}",
    "\\usepackage{graphicx}",
    "\\usepackage{array}",
    "\\usepackage{tabularx}"
  ]
  preamble := [
    "\\renewcommand{\\chaptername}{Chapitre}\n\\renewcommand{\\contentsname}{Table des matières}",
    "\\AtBeginDocument{%\n  \\let\\llbracket\\lBrack \\let\\rrbracket\\rBrack\n  \\let\\Box\\mdlgwhtsquare \\let\\square\\mdlgwhtsquare\n  \\let\\Diamond\\mdlgwhtdiamond \\let\\bigcirc\\mdlgwhtcircle\n  \\let\\leadsto\\rightsquigarrow\n}"
  ]

/-- Declares the LaTeX packages used by the specification. -/
@[block_command]
meta def texsetup : BlockCommandOf Unit
  | () => ``(Verso.Doc.Block.other SpecExt.Block.texsetup #[])

end SpecExt
