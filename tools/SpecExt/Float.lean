-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic
import SpecExt.Render
import SpecExt.Slots

/-!
# Figures, tables and listings

All three are numbered, labelled, captioned objects:

* `::::figure (label := "fig:x") (src := "name") (alt := "…") (width := "90")` — image
  `figures/name.svg` in HTML and `figures/name.pdf` in the PDF; slots `caption`, `desc`, `note`,
  `source`.
* `::::k7table (label := "tab:x") (align := "lZ{1.0}")` — slots and a Verso `:::table`; `align`
  is a `tabularx` column specification used for the PDF.
* `::::listing (label := "lst:x")` — a code block and a `caption` slot.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- What distinguishes a float: its sequence, label and parameters. The `number` is filled in by
the traversal. -/
structure FloatInfo where
  /-- Sequence: `figure`, `table` or `listing`. -/
  kind : String
  label : Option String
  /-- Image name (figures) or `tabularx` column specification (tables). -/
  arg : String
  /-- Alternative text of a figure. -/
  alt : String
  /-- Width of a figure, as a percentage of the text width. -/
  width : String
  number : Option Nat
deriving ToJson, FromJson, Inhabited

/-- Printed name of a float sequence. -/
def floatName : String → String
  | "figure" => "Figure"
  | "table" => "Tableau"
  | "listing" => "Listing"
  | s => s

/-- The rows of a Verso table, as lists of cells. -/
def tableRows? : Doc.Block Manual → Option (Nat × Bool × Array (Array (Array (Doc.Block Manual))))
  | .other blk content =>
    if blk.name == ``Verso.Genre.Manual.Block.table then
      match fromJson? (α := Nat × Bool × Option String × Option Tag × Option TableConfig.Alignment) blk.data, content with
      | .ok (cols, hdr, _, _, _), #[.ul items] =>
        let cells := items.map (·.contents)
        let rows := Id.run do
          let mut rows := #[]
          let mut rest := cells
          while rest.size > 0 && cols > 0 do
            rows := rows.push (rest.take cols)
            rest := rest.extract cols rest.size
          pure rows
        some (cols, hdr, rows)
      | _, _ => none
    else none
  | _ => none

block_extension Block.float (info : FloatInfo) where
  data := toJson info
  traverse id data contents := do
    match fromJson? (α := FloatInfo) data with
    | .error e => reportError s!"float: cannot read its data: {e}"; pure none
    | .ok info =>
      let n ← assignNumber info.kind id
      let (slots, _) := splitSlots contents
      let title := (findSlot slots "caption").map (firstParagraphSegments ·.content) |>.getD #[]
      registerNumbered info.kind n id title info.label
      if info.number == some n then pure none
      else pure (some (.other { Block.float { info with number := some n } with id := some id } contents))
  toHtml := some fun _goI goB id data contents => do
    match fromJson? (α := FloatInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let st ← HtmlT.state
      let n := info.number.getD 0
      let (slots, others) := splitSlots contents
      let descH : Output.Html ← match findSlot slots "desc" with
        | some s => do pure {{<div class="k7-desc">{{← s.content.mapM goB}}</div>}}
        | none => pure .empty
      let noteH : Output.Html ← match findSlot slots "note" with
        | some s => do pure {{<div class="k7-note">{{← s.content.mapM goB}}</div>}}
        | none => pure .empty
      let srcH : Output.Html ← match findSlot slots "source" with
        | some s => do pure {{<div class="k7-source">{{← s.content.mapM goB}}</div>}}
        | none => pure .empty
      let cap : Output.Html ← match findSlot slots "caption" with
        | some s => pure {{<span class="k7-capno">{{s!"{floatName info.kind} {n}"}}</span>{{" : "}}{{← s.content.mapM goB}}}}
        | none => pure {{<span class="k7-capno">{{s!"{floatName info.kind} {n}"}}</span>}}
      -- The provenance catalog is generated from canonical figure declarations and source mappings.
      -- Keep this link generic: the catalog, not this renderer, determines each figure's source.
      let provenanceLink : Output.Html :=
        {{<a href={{"navigation/figures.html#" ++ info.arg}}>Sources et rendus</a>}}
      let provenanceH : Output.Html :=
        if info.kind == "figure" then {{<div class="k7-provenance">{{provenanceLink}}</div>}} else .empty
      let caption : Output.Html :=
        {{<div class="k7-caption">{{cap}}{{descH}}{{noteH}}{{srcH}}{{provenanceH}}</div>}}
      let body : Output.Html ←
        if info.kind == "figure" then
          -- Verso's generated pages have a <base href> pointing at the site root.
          -- Keep this URL site-root-relative; prepending the page-depth prefix here applies
          -- that prefix twice and breaks images on nested pages.
          let style := s!"max-width: {info.width}%"
          pure {{<img class="k7-img" src={{"figures/" ++ info.arg ++ ".svg"}} alt={{info.alt}} style={{style}}/>}}
        else
          pure (Output.Html.seq (← others.mapM goB))
      -- tables and listings put their caption above, figures below
      let inner : Output.Html :=
        if info.kind == "figure" then Output.Html.seq #[body, caption] else Output.Html.seq #[caption, body]
      pure {{<div class={{"k7-float k7-" ++ info.kind}} {{st.htmlId id}}>{{inner}}</div>}}
  toTeX := some fun _ goB id data contents => do
    match fromJson? (α := FloatInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let n := info.number.getD 0
      let (slots, others) := splitSlots contents
      let capTeX : Verso.Output.TeX ← match findSlot slots "caption" with
        | some s => pure (.seq (← s.content.mapM goB))
        | none => pure .empty
      let extra (name : String) : TeXT Manual (ReaderT ExtensionImpls (BuildLogT IO)) Verso.Output.TeX := do
        match findSlot slots name with
        | some s => pure (.seq #[.raw "\\par\\footnotesize ", .seq (← s.content.mapM goB)])
        | none => pure .empty
      let head : Verso.Output.TeX := .seq #[.raw s!"\\par\\noindent\{\\small\\textbf\{{floatName info.kind} {n} : }", capTeX, .raw "}",
        ← extra "desc", ← extra "note", ← extra "source", .raw "\\par\n"]
      let mut out : Array Verso.Output.TeX := #[.raw "\n\\begin{center}\n", ← texAnchor id]
      if info.kind == "figure" then
        -- If the project preamble provides the qvfigure accessibility helpers, wrap the image
        -- in a tagged Figure structure. Keep the fallback for the ordinary Verso PDF build.
        out := out.push (.raw ("\\ifdefined\\qvalt\\qvalt{" ++ texEscape info.alt ++ "}\\fi\n"))
        out := out.push (.raw s!"\\includegraphics[width={(info.width.toNat?.getD 90).toFloat / 100.0}\\linewidth,keepaspectratio]\{figures/{info.arg}.pdf}\n")
        out := out.push (.raw "\\ifdefined\\qvaltfin\\qvaltfin\\fi\n")
        out := out.push head
      else if info.kind == "table" then
        out := out.push head
        for b in others do
          match tableRows? b with
          | some (cols, hdr, rows) =>
            out := out.push (.raw s!"\\begingroup\\small\\begin\{tabularx}\{\\linewidth}\{{info.arg}}\n\\hline\n")
            for i in [0:rows.size] do
              let row := rows[i]!
              let mut cells : Array Verso.Output.TeX := #[]
              for c in row do
                let t : Verso.Output.TeX := .seq (← c.mapM goB)
                cells := cells.push (if hdr && i == 0 then .seq #[.raw "\\textbf{", t, .raw "}"] else t)
              let sep : Array Verso.Output.TeX := (List.intersperse (Verso.Output.TeX.raw " & ") cells.toList).toArray
              out := out.push (.seq sep)
              out := out.push (.raw (if hdr && i == 0 then " \\\\\n\\hline\n" else " \\\\\n"))
            out := out.push (.raw "\\hline\n\\end{tabularx}\\endgroup\n")
            let _ := cols
          | none => out := out.push (← goB b)
      else
        out := out.push head
        for b in others do out := out.push (← goB b)
      out := out.push (.raw "\\end{center}\n")
      pure (.seq out)
  extraCss := [
r#"
.k7-float { margin: 1.4rem 0; }
.k7-figure { text-align: center; }
.k7-img { max-width: 100%; height: auto; }
.k7-float .k7-caption { font-size: 0.9em; margin: 0.4rem 0; }
.k7-float .k7-caption p { margin: 0.2rem 0; display: inline; }
.k7-desc, .k7-note, .k7-source { font-size: 0.9em; margin-top: 0.3rem; text-align: left; }
.k7-note, .k7-source { font-style: italic; }
.k7-table table.tabular { border-collapse: collapse; border-spacing: 0; width: 100%; }
.k7-table table.tabular td, .k7-table table.tabular th { border-bottom: 1px solid #d0d7de; padding: 0.3rem 0.6rem; }
.k7-table table.tabular th { border-bottom: 2px solid #8a949e; }
.k7-listing pre { margin: 0.2rem 0; }
"#
  ]
  preamble := ["\\newcolumntype{Z}[1]{>{\\hsize=#1\\hsize\\raggedright\\arraybackslash}X}"]

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- Arguments of the float directives. -/
structure FloatArgs where
  label : Option String := none
  src : String := ""
  alt : String := ""
  width : String := "90"
  align : String := ""

meta instance : FromArgs FloatArgs m where
  fromArgs :=
    FloatArgs.mk <$> .named `label .string true <*> .namedD `src .string ""
      <*> .namedD `alt .string "" <*> .namedD `width .string "90" <*> .namedD `align .string ""
end

/-- Builds the float of sequence `kind`. -/
meta def mkFloat (kind : String) : DirectiveExpanderOf FloatArgs
  | {label, src, alt, width, align}, stxs => do
    let args ← stxs.mapM elabBlock
    let arg := if kind == "figure" then src else align
    ``(Verso.Doc.Block.other
        (SpecExt.Block.float
          (SpecExt.FloatInfo.mk $(quote kind) $(quote label) $(quote arg) $(quote alt)
            $(quote width) none)) #[$args,*])

/-- A figure: an image with its caption, description, note and source. -/
@[directive]
meta def figure : DirectiveExpanderOf FloatArgs := mkFloat "figure"

/-- A captioned table, wrapping a Verso `:::table`. -/
@[directive]
meta def k7table : DirectiveExpanderOf FloatArgs := mkFloat "table"

/-- A captioned listing, wrapping a code block. -/
@[directive]
meta def listing : DirectiveExpanderOf FloatArgs := mkFloat "listing"

end SpecExt
