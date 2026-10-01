-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic
import SpecExt.Float
import SpecExt.Label

/-!
# Lists of figures, tables, formulas and listings

`{listof figure}` prints the list of the figures of the document, with the number and the caption
of each; likewise for `table`, `formule` and `listing`.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- Printed name of a numbered sequence. -/
def sequenceName : String → String
  | "formule" => "Formule"
  | k => floatName k

block_extension Block.listof (kind : String) where
  data := toJson kind
  traverse _ _ _ := pure none
  toHtml := some fun _ _ _ data _ => do
    match fromJson? (α := String) data with
    | .error e => reportError e; pure .empty
    | .ok kind =>
      let st ← HtmlT.state
      let mut items : Array Output.Html := #[]
      for n in [1:counterValue st kind + 1] do
        let title := ((st.getDomainObject? floatDomain s!"{kind}:{n}").bind (·.data) >>= fun d =>
          (fromJson? (α := Array (Bool × String)) d).toOption).getD #[]
        let titleH : Array Output.Html := title.map fun (isMath, t) =>
          if isMath then {{<code class="math inline">{{t}}</code>}} else Output.Html.text true t
        let label := s!"{sequenceName kind} {n}"
        let link? := (st.getDomainObject? floatDomain s!"{kind}:{n}").bind (·.ids.toArray[0]?) >>= st.resolveId
        let head : Output.Html := match link? with
          | some link => {{<a class="k7-ref" href={{link.relativeLink}}>{{label}}</a>}}
          | none => Output.Html.text true label
        items := items.push {{<li>{{head}}{{" : "}}{{Output.Html.seq titleH}}</li>}}
      pure {{<ul class="k7-listof">{{Output.Html.seq items}}</ul>}}
  toTeX := some fun _ _ _ data _ => do
    match fromJson? (α := String) data with
    | .error e => reportError e; pure .empty
    | .ok kind =>
      let st ← TeX.state
      let mut out : Array Verso.Output.TeX := #[.raw "\n\\begingroup\\small\n"]
      for n in [1:counterValue st kind + 1] do
        let title := ((st.getDomainObject? floatDomain s!"{kind}:{n}").bind (·.data) >>= fun d =>
          (fromJson? (α := Array (Bool × String)) d).toOption).getD #[]
        let titleT := String.join (title.toList.map fun (isMath, t) => if isMath then s!"${t}$" else texEscape t)
        let label := s!"{sequenceName kind} {n}"
        let ref? := (st.getDomainObject? floatDomain s!"{kind}:{n}").bind (·.ids.toArray[0]?) >>= (st.externalTags[·]?)
        let page := match ref? with
          | some link => s!"\\dotfill\\pageref\{{texLabel link.htmlId}}"
          | none => ""
        out := out.push (.raw s!"\\noindent {label} : {titleT}{page}\\par\n")
      out := out.push (.raw "\\endgroup\n")
      pure (.seq out)
  extraCss := [
r#"
.k7-listof { list-style: none; padding-left: 0; }
.k7-listof li { margin: 0.2rem 0; }
"#
  ]

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- The argument of `listof`: the sequence to list. -/
structure ListofArgs where
  kind : String

meta instance : FromArgs ListofArgs m where
  fromArgs := ListofArgs.mk <$> .positional `kind .string
end

/-- Prints the list of the objects of a numbered sequence. -/
@[block_command]
meta def listof : BlockCommandOf ListofArgs
  | ⟨kind⟩ => ``(Verso.Doc.Block.other (SpecExt.Block.listof $(quote kind)) #[])

end SpecExt
