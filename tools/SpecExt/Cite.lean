-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecBib
import SpecExt.Basic
import SpecExt.Render

/-!
# Citations and per-chapter bibliographies

Each top-level chapter is a *reference section* (`{refsection "c3"}`): its citations are numbered
in order of first appearance, and `{bibliography}` prints the list of the works cited in it.

* `{cite "KEY1,KEY2"}[]` — a numeric citation such as `[3, 5–7]`.
* `{refsection "c3"}` — opens a reference section.
* `{bibliography}` — prints the bibliography of the current reference section.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

variable {m : Type → Type}

/-- The domain of bibliography blocks, by reference section. -/
def bibDomain : Name := `SpecExt.bibliography

/-- Key of the reference-section state. -/
def refsecKey : Name := `SpecExt.refsections

private def readRefsec (st : TraverseState) : Json :=
  match st.get? (α := Json) refsecKey with
  | some (.ok j) => j
  | _ => Json.mkObj [("current", "root"), ("orders", Json.mkObj [])]

/-- The reference section being traversed. -/
def currentRefsec [Monad m] [MonadStateOf TraverseState m] : m String := do
  let j := readRefsec (← getThe TraverseState)
  return (j.getObjValAs? String "current").toOption.getD "root"

/-- Makes `name` the current reference section. -/
def setRefsec [Monad m] [MonadStateOf TraverseState m] (name : String) : m Unit := do
  let j := readRefsec (← getThe TraverseState)
  modifyThe TraverseState (·.set refsecKey (j.setObjVal! "current" name))

/-- The keys cited so far in `refsec`, in order of first citation. -/
def refsecOrder (st : TraverseState) (refsec : String) : Array String :=
  let j := readRefsec st
  ((j.getObjVal? "orders").toOption.bind fun o => (o.getObjValAs? (Array String) refsec).toOption).getD #[]

/-- The position (from 1) of `key` in `refsec`, adding it if it is new. -/
def citeNumber [Monad m] [MonadStateOf TraverseState m] (refsec key : String) : m Nat := do
  let st ← getThe TraverseState
  let order := refsecOrder st refsec
  match order.findIdx? (· == key) with
  | some i => return i + 1
  | none =>
    let j := readRefsec st
    let orders := (j.getObjVal? "orders").toOption.getD (Json.mkObj [])
    let orders := orders.setObjVal! refsec (toJson (order.push key))
    modifyThe TraverseState (·.set refsecKey (j.setObjVal! "orders" orders))
    return order.size + 1

/-- Collapses a sorted list of numbers into ranges: `[1, 3–5]`. -/
def collapse (ns : List Nat) : List (String × Nat × Nat) :=
  let rec go : List Nat → Option (Nat × Nat) → List (Nat × Nat) → List (Nat × Nat)
    | [], none, acc => acc.reverse
    | [], some r, acc => (r :: acc).reverse
    | n :: rest, none, acc => go rest (some (n, n)) acc
    | n :: rest, some (a, b), acc =>
      if n == b + 1 then go rest (some (a, n)) acc else go rest (some (n, n)) ((a, b) :: acc)
  (go ns none []).map fun (a, b) => ("", a, b)

/-- Data of a citation. -/
structure CiteInfo where
  keys : Array String
  refsec : Option String
  numbers : Array Nat
deriving ToJson, FromJson, Inhabited

/-- The anchor of an entry. -/
def bibAnchor (refsec key : String) : String := s!"bib-{anchorName refsec}-{anchorName key}"

/-- The ranges of consecutive numbers of a citation. -/
def CiteInfo.ranges (c : CiteInfo) : List (Nat × Nat) :=
  (collapse (c.numbers.toList.mergeSort (· ≤ ·))).map fun (_, a, b) => (a, b)

inline_extension Inline.cite (info : CiteInfo) where
  data := toJson info
  traverse _ data _ := do
    match fromJson? (α := CiteInfo) data with
    | .error e => reportError s!"cite: cannot read its data: {e}"; pure none
    | .ok info =>
      let refsec ← currentRefsec
      let numbers ← info.keys.mapM (citeNumber refsec)
      if info.refsec == some refsec && info.numbers == numbers then pure none
      else pure (some (.other (Inline.cite { info with refsec := some refsec, numbers }) #[]))
  toHtml := some fun _ _ data _ => do
    match fromJson? (α := CiteInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let st ← HtmlT.state
      let refsec := info.refsec.getD "root"
      let target := (st.getDomainObject? bibDomain refsec).bind (·.ids.toArray[0]?) >>= st.resolveId
      let pieces : Array Output.Html := (info.ranges.map fun (a, b) =>
        let txt : String := if a == b then toString a else s!"{a}–{b}"
        let key? := info.keys[(info.numbers.findIdx? (· == a)).getD 0]?
        match target, key? with
        | some link, some key =>
          {{<a href={{link.path.relativeLink (some (bibAnchor refsec key))}}>{{txt}}</a>}}
        | _, _ => (Output.Html.text true txt)).toArray
      let sep : Output.Html := Output.Html.text true ", "
      let inner := Output.Html.seq (pieces.toList.intersperse sep).toArray
      pure {{<span class="k7-cite">"["{{inner}}"]"</span>}}
  toTeX := some fun _ _ data _ => do
    match fromJson? (α := CiteInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let refsec := info.refsec.getD "root"
      let parts := info.ranges.map fun (a, b) =>
        let txt : String := if a == b then toString a else s!"{a}--{b}"
        let key? := info.keys[(info.numbers.findIdx? (· == a)).getD 0]?
        match key? with
        | some key => s!"\\hyperlink\{{bibAnchor refsec key}}\{{txt}}"
        | none => txt
      pure (.raw s!"[{", ".intercalate parts}]")

inline_extension Inline.sc where
  data := Json.null
  traverse _ _ _ := pure none
  toHtml := some fun goI _ _ content => do
    pure {{<span class="k7-sc">{{← content.mapM goI}}</span>}}
  toTeX := some fun goI _ _ content => do
    pure (.seq #[.raw "\\textsc{", .seq (← content.mapM goI), .raw "}"])
  extraCss := [".k7-sc { font-variant: small-caps; }"]

block_extension Block.refsection (name : String) where
  data := toJson name
  traverse _ data _ := do
    match fromJson? (α := String) data with
    | .error e => reportError e; pure none
    | .ok name => setRefsec name; pure none
  toHtml := some fun _ _ _ _ _ => pure .empty
  toTeX := some fun _ _ _ _ _ => pure .empty

block_extension Block.bibliography (refsec : Option String) where
  data := toJson refsec
  traverse id data _ := do
    match fromJson? (α := Option String) data with
    | .error e => reportError e; pure none
    | .ok r =>
      let cur ← currentRefsec
      let path := (← read).path
      let _ ← externalTag id path s!"bibliography-{anchorName cur}"
      modifyThe TraverseState (·.saveDomainObject bibDomain cur id)
      if r == some cur then pure none
      else pure (some (.other { Block.bibliography (some cur) with id := some id } #[]))
  toHtml := some fun _ _ id data _ => do
    match fromJson? (α := Option String) data with
    | .error e => reportError e; pure .empty
    | .ok r =>
      let refsec := r.getD "root"
      let st ← HtmlT.state
      let order := refsecOrder st refsec
      let mut items : Array Output.Html := #[]
      for key in order, i in [0:order.size] do
        let entry := SpecBib.entries.find? (·.1 == key)
        if entry.isNone then reportError s!"No bibliography entry for the key '{key}'"
        let body : Output.Html := match entry with
          | some (_, parts, doi, url) =>
            let ps : Array Output.Html := parts.toArray.map fun (it, t) =>
              if it then {{<em>{{t}}</em>}} else Output.Html.text true t
            let link : Output.Html := match doi, url with
              | some d, _ =>
                Output.Html.seq #[Output.Html.text true " Disp. à l’adr. DOI: ", {{<a href={{"https://doi.org/" ++ d}}>{{d}}</a>}}]
              | none, some u =>
                Output.Html.seq #[Output.Html.text true " Disp. à l’adr. ", {{<a href={{u}}>{{u}}</a>}}]
              | none, none => .empty
            Output.Html.seq (ps.push link)
          | none => {{<span class="k7-ref-missing">{{s!"Référence inconnue : {key}"}}</span>}}
        items := items.push {{<li id={{bibAnchor refsec key}} value={{toString (i + 1)}}>{{body}}</li>}}
      if items.isEmpty then pure .empty
      else pure {{<div class="k7-bib" {{st.htmlId id}}><div class="k7-bib-title">"Références"</div><ol>{{Output.Html.seq items}}</ol></div>}}
  toTeX := some fun _ _ _ data _ => do
    match fromJson? (α := Option String) data with
    | .error e => reportError e; pure .empty
    | .ok r =>
      let refsec := r.getD "root"
      let st ← TeX.state
      let order := refsecOrder st refsec
      let mut out : Array Verso.Output.TeX := #[]
      if !order.isEmpty then
        out := out.push (.raw "\n\\par\\medskip\\noindent\\textbf{Références}\\par\n\\begingroup\\footnotesize\n")
      for key in order, i in [0:order.size] do
        let entry := SpecBib.entries.find? (·.1 == key)
        if entry.isNone then reportError s!"No bibliography entry for the key '{key}'"
        let body : String := match entry with
          | some (_, parts, doi, url) =>
            let ps : List String := parts.map fun ((it : Bool), (t : String)) =>
              if it then s!"\\emph\{{texEscape t}}" else texEscape t
            let link := match doi, url with
              | some d, _ => s!" Disp. à l’adr. DOI: \\href\{https://doi.org/{d}}\{{texEscape d}}"
              | none, some u => s!" Disp. à l’adr. \\url\{{u}}"
              | none, none => ""
            "".intercalate ps ++ link
          | none => s!"Référence inconnue : {texEscape key}"
        out := out.push (.raw s!"\\hypertarget\{{bibAnchor refsec key}}\{}\\noindent[{i + 1}]~{body}\\par\n")
      if !order.isEmpty then out := out.push (.raw "\\endgroup\n")
      pure (.seq out)
  extraCss := [
r#"
.k7-bib { margin-top: 2rem; font-size: 0.85em; }
.k7-bib-title { font-weight: bold; margin-bottom: 0.4rem; }
.k7-bib ol { list-style: none; padding-left: 0; }
.k7-bib li { padding-left: 2.2rem; text-indent: -2.2rem; margin-bottom: 0.25rem; }
.k7-bib li::before { content: "[" attr(value) "] "; display: inline-block; width: 2.2rem; text-indent: 0; }
.k7-cite a { text-decoration: none; }
"#
  ]

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- The argument of `cite`: the keys, separated by commas. -/
structure CiteArgs where
  keys : String

meta instance : FromArgs CiteArgs m where
  fromArgs := CiteArgs.mk <$> .positional `keys .string

/-- The argument of `refsection`. -/
structure RefsecArgs where
  name : String

meta instance : FromArgs RefsecArgs m where
  fromArgs := RefsecArgs.mk <$> .positional `name .string
end

/-- A numeric citation. -/
@[role]
meta def cite : RoleExpanderOf CiteArgs
  | {keys}, _ =>
    let ks := (keys.splitOn ",").toArray.map String.trimAscii |>.map (·.toString)
    ``(Verso.Doc.Inline.other (SpecExt.Inline.cite (SpecExt.CiteInfo.mk $(quote ks) none #[])) #[])

/-- Small capitals. -/
@[role]
meta def sc : RoleExpanderOf Unit
  | (), content => do
    let content ← content.mapM elabInline
    ``(Verso.Doc.Inline.other SpecExt.Inline.sc #[$content,*])

/-- Opens a reference section: the numbering of the citations restarts. -/
@[block_command]
meta def refsection : BlockCommandOf RefsecArgs
  | ⟨name⟩ => ``(Verso.Doc.Block.other (SpecExt.Block.refsection $(quote name)) #[])

/-- Prints the works cited since the last `refsection`. -/
@[block_command]
meta def bibliography : BlockCommandOf Unit
  | () => ``(Verso.Doc.Block.other (SpecExt.Block.bibliography none) #[])

end SpecExt
