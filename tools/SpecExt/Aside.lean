-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic

/-!
# Marginal remarks

`{rmq}[text]` is a remark in the margin (`\RMQ{…}` of the Org manuscript): a short aside, numbered
"RMQ n." in one sequence for the whole document.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

inline_extension Inline.rmq (number : Option Nat) where
  data := toJson number
  traverse id data content := do
    let n ← assignNumber "rmq" id
    match fromJson? (α := Option Nat) data with
    | .ok (some m) => if m == n then return none else pure ()
    | _ => pure ()
    return some (.other { Inline.rmq (some n) with id := some id } content)
  toHtml := some fun goI _ data content => do
    let n := (fromJson? (α := Option Nat) data).toOption.bind id |>.getD 0
    pure {{<span class="k7-rmq"><span class="k7-rmq-no">{{s!"RMQ {n}."}}</span>{{" "}}{{← content.mapM goI}}</span>}}
  toTeX := some fun goI _ data content => do
    let n := (fromJson? (α := Option Nat) data).toOption.bind id |>.getD 0
    pure (.seq #[.raw s!"\\marginpar\{\\footnotesize\\textbf\{RMQ {n}.} ", .seq (← content.mapM goI), .raw "}"])
  extraCss := [
r#"
.k7-rmq { display: block; margin: 0.4rem 0 0.4rem 1.5rem; padding-left: 0.7rem;
  border-left: 3px solid #c9a227; font-size: 0.88em; color: #4a4a4a; }
.k7-rmq-no { font-weight: bold; }
"#
  ]

inline_extension Inline.amp where
  data := Json.null
  traverse _ _ _ := pure none
  toHtml := some fun _ _ _ _ => pure (Output.Html.text true "&")
  toTeX := some fun _ _ _ _ => pure (.raw "\\&")

/-- An ampersand where the TeX title of a section would not escape the plain character. -/
@[role]
meta def amp : RoleExpanderOf Unit
  | (), _ => ``(Verso.Doc.Inline.other SpecExt.Inline.amp #[])

inline_extension Inline.ccby where
  data := Json.null
  traverse _ _ _ := pure none
  toHtml := some fun _ _ _ _ =>
    pure {{<a class="k7-cc" rel="license" href="https://creativecommons.org/licenses/by/4.0/">
      <img alt="CC BY 4.0" style="border-width:0" width="88" height="31"
        src="https://licensebuttons.net/l/by/4.0/88x31.png"/></a>}}
  toTeX := some fun _ _ _ _ =>
    pure (.raw "\\href{https://creativecommons.org/licenses/by/4.0/}{CC BY 4.0}")

/-- The official Creative Commons Attribution 4.0 badge (a text link in the PDF). -/
@[role]
meta def ccby : RoleExpanderOf Unit
  | (), _ => ``(Verso.Doc.Inline.other SpecExt.Inline.ccby #[])

/-- A remark in the margin. -/
@[role]
meta def rmq : RoleExpanderOf Unit
  | (), content => do
    let content ← content.mapM elabInline
    ``(Verso.Doc.Inline.other (SpecExt.Inline.rmq none) #[$content,*])

end SpecExt
