-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic
import SpecExt.Render
import SpecExt.Slots

/-!
# Displayed formulas

`::::formula (label := "eq:x") (kind := "formule")` holds one or more plain code blocks, each a
LaTeX math environment (`align*`, `gather*`, `equation*`…), and optionally a `:::caption` slot.

* `kind := "formule"`: a captioned formula, numbered in the `formule` sequence ("Formule 3").
* `kind := "equation"`: a numbered `equation` (its number is displayed as `(3)`).
* `kind := "plain"` (default): an unnumbered group of environments.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- Label, kind and number of a formula block. -/
structure FormulaInfo where
  label : Option String
  kind : String
  number : Option Nat
deriving ToJson, FromJson, Inhabited

/-- Replaces a numbered `equation` by `equation*` carrying an explicit `\tag`. -/
def tagEquation (tex : String) (n : Nat) : String :=
  let tex := tex.replace "\\begin{equation}" s!"\\begin\{equation*}\\tag\{{n}}"
  tex.replace "\\end{equation}" "\\end{equation*}"

block_extension Block.formula (info : FormulaInfo) where
  data := toJson info
  traverse id data contents := do
    match fromJson? (α := FormulaInfo) data with
    | .error e => reportError s!"formula: cannot read its data: {e}"; pure none
    | .ok info =>
      if info.kind == "plain" then
        match info.label with
        | some l => registerLabel l id { kind := "formula", text := "?" }
        | none => pure ()
        return none
      let n ← assignNumber info.kind id
      let (slots, _) := splitSlots contents
      let title := (findSlot slots "caption").map (firstParagraphSegments ·.content) |>.getD #[]
      registerNumbered info.kind n id title info.label
      if info.number == some n then pure none
      else pure (some (.other { Block.formula { info with number := some n } with id := some id } contents))
  toHtml := some fun _ goB id data contents => do
    match fromJson? (α := FormulaInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let st ← HtmlT.state
      let n := info.number.getD 0
      let (slots, others) := splitSlots contents
      let mut out : Array Output.Html := #[]
      for b in others do
        match b with
        | .code tex =>
          let tex := if info.kind == "equation" then tagEquation tex n else tex
          out := out.push {{<div class="k7-math"><code class="math display">{{tex}}</code></div>}}
        | other => out := out.push (← goB other)
      if let some cap := findSlot slots "caption" then
        let nm := if info.kind == "formule" then s!"Formule {n}" else ""
        out := out.push {{<div class="k7-caption"><span class="k7-capno">{{nm}}</span>{{" : "}}{{← cap.content.mapM goB}}</div>}}
      pure {{<div class="k7-formula" {{st.htmlId id}}>{{Output.Html.seq out}}</div>}}
  toTeX := some fun _ goB id data contents => do
    match fromJson? (α := FormulaInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let n := info.number.getD 0
      let (slots, others) := splitSlots contents
      let mut out : Array Verso.Output.TeX := #[.raw "\n\\begingroup\\par\\addvspace{0.4em}\n", ← texAnchor id]
      for b in others do
        match b with
        | .code tex =>
          let tex := if info.kind == "equation" then tagEquation tex n else tex
          out := out.push (.raw (tex ++ "\n"))
        | other => out := out.push (← goB other)
      if let some cap := findSlot slots "caption" then
        let nm := if info.kind == "formule" then s!"Formule {n} : " else ""
        out := out.push (.raw s!"\\par\\noindent\{\\small\\textbf\{{nm}}")
        out := out.push (.seq (← cap.content.mapM goB))
        out := out.push (.raw "}\\par\n")
      out := out.push (.raw "\\addvspace{0.4em}\\endgroup\n")
      pure (.seq out)
  extraCss := [
r#"
.k7-formula { margin: 1rem 0; overflow-x: auto; }
.k7-caption { font-size: 0.9em; margin: 0.3rem 0 0.6rem 0; }
.k7-caption p { display: inline; margin: 0; }
.k7-capno { font-weight: bold; }
"#
  ]

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- Arguments of `formula`. -/
structure FormulaArgs where
  label : Option String := none
  kind : String := "plain"

meta instance : FromArgs FormulaArgs m where
  fromArgs := FormulaArgs.mk <$> .named `label .string true <*> .namedD `kind .string "plain"
end

/-- A displayed formula (a group of LaTeX math environments), possibly captioned and numbered. -/
@[directive]
meta def formula : DirectiveExpanderOf FormulaArgs
  | {label, kind}, stxs => do
    let args ← stxs.mapM elabBlock
    ``(Verso.Doc.Block.other
        (SpecExt.Block.formula (SpecExt.FormulaInfo.mk $(quote label) $(quote kind) none)) #[$args,*])

end SpecExt
