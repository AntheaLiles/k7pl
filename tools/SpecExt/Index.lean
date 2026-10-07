-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic
import SpecExt.Render
import SpecExt.Label
import SpecExt.IndexCore

/-!
# Index with pages, and glossary hints

`{idx "term"}[text]` marks one occurrence of an index term in the text; `{printindex}` prints the
index: every term followed by the places where it occurs. In the HTML pages a place is the number
of the section ; in the PDF it is the page, computed by LaTeX from a label put at each occurrence
(no external `makeindex` run: the page numbers are resolved by the same two passes that resolve
the other cross-references).

The occurrences are not written by hand: `SpecExt.AutoMark` recognises the terms of
`SpecExt.IndexTerms` in the text of the document before it is rendered, as `org-glossary` did for the
Org manuscript. `{gloss "definition"}[text]` marks a term of the glossary or an acronym, which the
HTML pages show with its definition as a tooltip.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- The Verso domain holding the occurrences of the index terms. -/
def indexDomain : Name := `SpecExt.index

/-- One occurrence of an index term: the term, and the number of the section it stands in. -/
structure Occurrence where
  /-- The index term, as printed. -/
  term : String
  /-- The number of the enclosing section (`"3.2"`). -/
  sec : String
deriving ToJson, FromJson, Inhabited

/-- An occurrence together with the identifier of the place that carries its anchor. -/
structure Placed where
  /-- The occurrence. -/
  occ : Occurrence
  /-- The identifier of the anchor. -/
  id : InternalId

/-- Every occurrence registered during the traversal, in document order. -/
def placedOccurrences (st : TraverseState) : Array Placed := Id.run do
  let mut out := #[]
  for n in [1:counterValue st "idx" + 1] do
    match st.getDomainObject? indexDomain s!"{n}" with
    | none => pure ()
    | some obj =>
      match obj.data >>= fun d => (fromJson? (α := Occurrence) d).toOption, obj.ids.toArray[0]? with
      | some occ, some id => out := out.push { occ, id }
      | _, _ => pure ()
  return out

/-- The occurrences grouped by term, the terms sorted as an index is (without case or accents). -/
def groupedOccurrences (placed : Array Placed) : Array (String × Array Placed) :=
  let terms := placed.foldl (init := (#[] : Array String)) fun acc p =>
    if acc.contains p.occ.term then acc else acc.push p.occ.term
  let sorted := terms.qsort fun a b => IndexCore.sortKey a < IndexCore.sortKey b
  sorted.map fun t => (t, placed.filter (·.occ.term == t))

/-- The capital letter under which a term is filed. -/
def indexLetter (term : String) : String :=
  String.ofList ((IndexCore.sortKey term).toList.take 1) |>.toUpper

inline_extension Inline.idx (term : String) where
  data := toJson term
  traverse id data _ := do
    match fromJson? (α := String) data with
    | .error e => reportError s!"idx: cannot read its data: {e}"; pure none
    | .ok term =>
      let n ← assignNumber "idx" id
      let ctx ← read
      let _ ← externalTag id ctx.path s!"idx-{n}"
      let occ : Occurrence := { term, sec := currentSectionNumber ctx }
      modifyThe TraverseState fun st =>
        st |>.saveDomainObject indexDomain s!"{n}" id
           |>.saveDomainObjectData indexDomain s!"{n}" (toJson occ)
      pure none
  toHtml := some fun goI id _ content => do
    let st ← HtmlT.state
    pure {{<span class="k7-idx" {{st.htmlId id}}>{{← content.mapM goI}}</span>}}
  toTeX := some fun goI id _ content => do
    let st ← TeX.state
    let anchor := match st.externalTags[id]? with
      | some link => s!"\\phantomsection\\label\{{texLabel link.htmlId}}"
      | none => ""
    pure (.seq #[.raw anchor, .seq (← content.mapM goI)])

inline_extension Inline.gloss (definition : String) where
  data := toJson definition
  traverse _ _ _ := pure none
  toHtml := some fun goI _ data content => do
    let definition := (fromJson? (α := String) data).toOption.getD ""
    pure {{<span class="k7-gloss" title={{definition}}>{{← content.mapM goI}}</span>}}
  toTeX := some fun goI _ _ content => do pure (.seq (← content.mapM goI))
  extraCss := [
r#"
.k7-gloss { border-bottom: 1px dotted currentColor; cursor: help; }
"#
  ]

block_extension Block.printindex where
  data := Json.null
  traverse _ _ _ := pure none
  toHtml := some fun _ _ _ _ _ => do
    let st ← HtmlT.state
    let groups := groupedOccurrences (placedOccurrences st)
    let mut out : Array Output.Html := #[]
    let mut letters : Array String := #[]
    for (term, places) in groups do
      let letter := indexLetter term
      if !letters.contains letter then
        letters := letters.push letter
        out := out.push {{<h3 class="k7-idx-letter">{{letter}}</h3>}}
      let mut seen : Array String := #[]
      let mut links : Array Output.Html := #[]
      for p in places do
        if !seen.contains p.occ.sec then
          seen := seen.push p.occ.sec
          let label := s!"§ {p.occ.sec}"
          let link := match st.resolveId p.id with
            | some l => {{<a class="k7-ref" href={{l.relativeLink}}>{{label}}</a>}}
            | none => Output.Html.text true label
          links := links.push link
      let sep : Output.Html := Output.Html.text true ", "
      let joined := links.toList.intersperse sep
      out := out.push {{<p class="k7-idx-entry"><span class="k7-idx-term">{{term}}</span>{{" — "}}{{Output.Html.seq joined.toArray}}</p>}}
    pure {{<div class="k7-index">{{Output.Html.seq out}}</div>}}
  toTeX := some fun _ _ _ _ _ => do
    let st ← TeX.state
    let groups := groupedOccurrences (placedOccurrences st)
    let mut out : Array Verso.Output.TeX := #[.raw "\n\\begin{multicols}{2}\\footnotesize\n"]
    let mut letters : Array String := #[]
    for (term, places) in groups do
      let letter := indexLetter term
      if !letters.contains letter then
        letters := letters.push letter
        out := out.push (.raw s!"\\medskip\\noindent\\textbf\{{letter}}\\par\\nopagebreak\n")
      let labels := places.filterMap fun p =>
        (st.externalTags[p.id]?).map fun link => texLabel link.htmlId
      out := out.push (.raw s!"\\specidxentry\{{texEscape term}}\{{",".intercalate labels.toList}}\n")
    out := out.push (.raw "\\end{multicols}\n")
    pure (.seq out)
  extraCss := [
r#"
.k7-index { margin: 1rem 0; }
.k7-idx-letter { margin: 1.2rem 0 0.3rem 0; border-bottom: 1px solid #98B2C0; }
.k7-idx-entry { margin: 0.15rem 0; }
.k7-idx-term { font-weight: 500; }
"#
  ]

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- Arguments of `idx`: the index term. -/
structure IdxArgs where
  term : String

meta instance : FromArgs IdxArgs m where
  fromArgs := IdxArgs.mk <$> .positional `term .string

/-- Arguments of `gloss`: the definition shown as a tooltip. -/
structure GlossArgs where
  definition : String

meta instance : FromArgs GlossArgs m where
  fromArgs := GlossArgs.mk <$> .positional `definition .string
end

/-- Marks an occurrence of an index term. -/
@[role]
meta def idx : RoleExpanderOf IdxArgs
  | {term}, content => do
    let content ← content.mapM elabInline
    ``(Verso.Doc.Inline.other (SpecExt.Inline.idx $(quote term)) #[$content,*])

/-- Marks a term of the glossary, shown with its definition. -/
@[role]
meta def gloss : RoleExpanderOf GlossArgs
  | {definition}, content => do
    let content ← content.mapM elabInline
    ``(Verso.Doc.Inline.other (SpecExt.Inline.gloss $(quote definition)) #[$content,*])

/-- Prints the index of the document. -/
@[block_command]
meta def printindex : BlockCommandOf Unit
  | () => ``(Verso.Doc.Block.other SpecExt.Block.printindex #[])

end SpecExt
