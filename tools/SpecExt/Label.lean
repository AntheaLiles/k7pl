-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic

/-!
# Labels and references

* `{label "sec:foo"}` (block command) registers a label for the enclosing section, whose number
  is the one Verso assigned to it.
* `{num "sec:foo"}[]` (role) prints the number of the labelled object, as a link.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- Printed form of one level of section numbering. -/
def numberingString : Numbering → String
  | .nat n => toString n
  | .letter c => c.toString

/-- The number of the current section, as Verso assigned it (`"3.2"`); the root header, i.e. the
document itself, is not part of it. -/
def currentSectionNumber (ctx : TraverseContext) : String :=
  let nums := ctx.headers.toList.drop 1 |>.map (·.metadata.bind (·.assignedNumber))
  if nums.all Option.isSome then ".".intercalate (nums.filterMap id |>.map numberingString) else "?"

/-- The anchor name used in the TeX output for the label `name`. -/
def texLabel (htmlId : Verso.Multi.Slug) : String := Verso.Output.TeX.labelForTeX htmlId

block_extension Block.label (name : String) (display : Option String) where
  data := toJson (name, display)
  traverse id data _ := do
    match fromJson? (α := String × Option String) data with
    | .error e => reportError s!"label: cannot read its data: {e}"; pure none
    | .ok (name, display) =>
      let text := display.getD (currentSectionNumber (← read))
      registerLabel name id { kind := "section", text }
      pure none
  toTeX := some fun _ _ id _ _ => do
    let st ← TeX.state
    match st.externalTags[id]? with
    | some link => pure (.raw s!"\\label\{{texLabel link.htmlId}}")
    | none => pure .empty
  toHtml := some fun _ _ id _ _ => do
    let st ← HtmlT.state
    pure {{<span class="k7-anchor" {{st.htmlId id}}></span>}}

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- Arguments of `label`: the label name, and optionally the text printed by references. -/
structure LabelArgs where
  name : String
  display : Option String := none

meta instance : FromArgs LabelArgs m where
  fromArgs := LabelArgs.mk <$> .positional `name .string <*> .named `display .string true

/-- Argument of `num`: the label to point at. -/
structure NumArgs where
  name : String

meta instance : FromArgs NumArgs m where
  fromArgs := NumArgs.mk <$> .positional `name .string
end

/-- Registers a label for the enclosing section. -/
@[block_command]
meta def label : BlockCommandOf LabelArgs
  | {name, display} => ``(Verso.Doc.Block.other (SpecExt.Block.label $(quote name) $(quote display)) #[])

inline_extension Inline.num (name : String) where
  data := toJson name
  traverse _ _ _ := pure none
  toTeX := some fun _ _ data _ => do
    match fromJson? (α := String) data with
    | .error e => reportError e; pure .empty
    | .ok name =>
      let st ← TeX.state
      match st.getDomainObject? labelDomain name with
      | none => reportError s!"No label '{name}'"; pure (.raw "??")
      | some obj =>
        let text := (obj.data >>= fun d => (fromJson? (α := LabelData) d).toOption).map (·.text)
        match obj.ids.toArray[0]?, text with
        | some tid, some text =>
          match st.externalTags[tid]? with
          | some link => pure (.raw s!"\\hyperref[{texLabel link.htmlId}]\{{text}}")
          | none => pure (.raw text)
        | _, some text => pure (.raw text)
        | _, none => pure (.raw "??")
  toHtml := some fun _ _ data _ => do
    match fromJson? (α := String) data with
    | .error e => reportError e; pure .empty
    | .ok name =>
      let st ← HtmlT.state
      match st.getDomainObject? labelDomain name with
      | none => reportError s!"No label '{name}'"; pure {{<span class="k7-ref-missing">"??"</span>}}
      | some obj =>
        let text := (obj.data >>= fun d => (fromJson? (α := LabelData) d).toOption).map (·.text)
        let text := text.getD "??"
        match obj.ids.toArray[0]? >>= st.resolveId with
        | some link => pure {{<a class="k7-ref" href={{link.relativeLink}}>{{text}}</a>}}
        | none => pure {{<span class="k7-ref-missing">{{text}}</span>}}

inline_extension Inline.missing (name : String) where
  data := toJson name
  traverse _ _ _ := pure none
  toHtml := some fun _ _ data _ => do
    let name := (fromJson? (α := String) data).toOption.getD "?"
    pure {{<span class="k7-ref-missing" title={{"Référence non résolue : " ++ name}}>"??"</span>}}
  toTeX := some fun _ _ _ _ => pure (.raw "\\textbf{??}")
  extraCss := [".k7-ref-missing { color: #b00020; font-weight: bold; }"]

/-- A reference to a label that the manuscript never defines (printed `??`, as LaTeX does). -/
@[role]
meta def missing : RoleExpanderOf NumArgs
  | {name}, _ => ``(Verso.Doc.Inline.other (SpecExt.Inline.missing $(quote name)) #[])

/-- Prints the number of a labelled object, as a link to it. -/
@[role]
meta def num : RoleExpanderOf NumArgs
  | {name}, _ => ``(Verso.Doc.Inline.other (SpecExt.Inline.num $(quote name)) #[])

end SpecExt
