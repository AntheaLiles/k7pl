-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic
import SpecExt.Render
import SpecExt.Slots

/-!
# Theorems

`::::theorem (label := "thm:x") (status := "proposition") (level := "representation") (titled := true)`
holds a `:::statement` and a `:::proofsketch` slot. All the theorems of the document share one
counter, as the `theoreme` counter of the original LaTeX preamble did.

* `status`: `theoreme` (default), `proposition`, `conjecture`, `definition`, `exigence`,
  `litterature`.
* `level`: `langage` (default, not printed), `compilation`, `representation`, `deploiement`.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- Printed name of a theorem status. -/
def statusName : String → String
  | "theoreme" => "Théorème"
  | "proposition" => "Proposition"
  | "conjecture" => "Conjecture"
  | "definition" => "Définition"
  | "exigence" => "Exigence"
  | "litterature" => "Résultat de la littérature"
  | s => s

/-- Printed name of a theorem level. -/
def levelName : String → String
  | "representation" => "représentation"
  | "deploiement" => "déploiement"
  | s => s

/-- Shared internal representation for every proof-bearing or documentary statement. -/
structure StatementInfo where
  label : Option String
  /-- Legacy-compatible display label; not the epistemic state. -/
  status : String
  /-- Historical domain level, separate from explicit scope. -/
  level : String
  kind : String
  role : String
  epistemicState : String
  evidence : String
  scope : String
  source : String
  formalArtifact : String
  number : Option Nat
deriving ToJson, FromJson, Inhabited

/-- Compatibility name for downstream code using the former theorem-only record. -/
abbrev ThmInfo := StatementInfo

/-- Map the old status vocabulary to the new dimensions without promoting a claim. -/
def legacyClassification (status : String) : String × String × String × String :=
  match status with
  | "definition" => ("definition", "", "not-applicable", "none")
  | "exigence" => ("requirement", "", "not-applicable", "none")
  | "litterature" => ("literature", "", "not-applicable", "literature")
  | "conjecture" => ("result", "conjecture", "proposed", "proofsketch")
  | "proposition" => ("result", "proposition", "under-review", "proofsketch")
  | _ => ("result", "theorem", "under-review", "proofsketch")

def allowedEpistemicState (s : String) : Bool :=
  ["proposed", "under-review", "supported", "established", "refuted", "withdrawn", "not-applicable"].contains s

def allowedEvidence (s : String) : Bool :=
  ["none", "written-proof", "proofsketch", "literature", "computation", "counterexample", "lean-proof"].contains s

def validRoleForKind (kind role : String) : Bool :=
  match kind with
  | "result" => ["theorem", "lemma", "corollary", "proposition", "conjecture"].contains role
  | "assumption" => ["axiom", "postulate", "hypothesis"].contains role
  | _ => role.isEmpty

def isTruthClaimKind (kind : String) : Bool :=
  kind == "result" || kind == "assumption"

block_extension Block.theorem (info : ThmInfo) where
  data := toJson info
  traverse id data contents := do
    match fromJson? (α := StatementInfo) data with
    | .error e => reportError s!"theorem: cannot read its data: {e}"; pure none
    | .ok info =>
      let n ← assignNumber "theoreme" id
      if let some l := info.label then
        let (slots, _) := splitSlots contents
        let title := (findSlot slots "statement").bind (·.titleAndBody.1) |>.map
          (fun xs => String.join (xs.toList.map plainText)) |>.getD ""
        registerLabel l id { kind := "theorem", text := toString n, title }
      if info.number == some n then pure none
      else
        pure (some (.other { Block.theorem { info with number := some n } with id := some id } contents))
  toHtml := some fun goI goB id data contents => do
    match fromJson? (α := StatementInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let n := toString (info.number.getD 0)
      let st ← HtmlT.state
      let (slots, _) := splitSlots contents
      let level : Output.Html :=
        if info.level == "langage" then .empty
        else {{<span class="k7-level">{{s!" ⟨{levelName info.level}⟩"}}</span>}}
      let thmTitle : Output.Html ← match findSlot slots "title" with
        | some t => do
          let inls := (t.content[0]?.bind paraInlines?).getD #[]
          pure {{<span class="k7-thm-title">{{" : "}}{{← inls.mapM goI}}</span>}}
        | none => pure .empty
      let head : Output.Html :=
        {{<div class="k7-thm-head">{{statusName info.status ++ " " ++ n}}{{level}}{{thmTitle}}</div>}}
      let mut out : Array Output.Html := #[head]
      for s in slots do
        match s.name with
        | "statement" =>
          let (t, body) := s.titleAndBody
          let tHtml : Output.Html ← match t with
            | some xs => do pure {{<span class="k7-stm-title">{{" : "}}{{← xs.mapM goI}}</span>}}
            | none => pure .empty
          out := out.push {{<div class="k7-statement"><div class="k7-stm-head">{{"Déclaration " ++ n}}{{tHtml}}</div>{{← body.mapM goB}}</div>}}
        | "proofsketch" =>
          out := out.push {{<div class="k7-proof"><div class="k7-proof-head">"Esquisse de preuve"</div>{{← s.content.mapM goB}}<span class="k7-qed">"□"</span></div>}}
        | "title" => pure ()
        | _ => out := out.push {{<div>{{← s.content.mapM goB}}</div>}}
      pure {{<div class="k7-theorem" {{st.htmlId id}}>{{Output.Html.seq out}}</div>}}
  toTeX := some fun goI goB id data contents => do
    match fromJson? (α := StatementInfo) data with
    | .error e => reportError e; pure .empty
    | .ok info =>
      let n := toString (info.number.getD 0)
      let (slots, _) := splitSlots contents
      let level := if info.level == "langage" then "" else s!"~⟨{levelName info.level}⟩"
      let mut out : Array Verso.Output.TeX := #[]
      let thmTitle : Verso.Output.TeX ← match findSlot slots "title" with
        | some t => do
          let inls := (t.content[0]?.bind paraInlines?).getD #[]
          pure (Verso.Output.TeX.seq #[.raw " : ", .seq (← inls.mapM goI)])
        | none => pure .empty
      out := out.push (.raw s!"\n\\par\\addvspace\{0.6em}\\noindent\{\\bfseries {statusName info.status} {n}{level}")
      out := out.push thmTitle
      out := out.push (.raw "}")
      out := out.push (← texAnchor id)
      out := out.push (.raw "\\par\\nobreak\n")
      for s in slots do
        match s.name with
        | "statement" =>
          let (t, body) := s.titleAndBody
          let tTeX : Verso.Output.TeX ← match t with
            | some xs => do pure (Verso.Output.TeX.seq #[.raw " : ", .seq (← xs.mapM goI)])
            | none => pure .empty
          out := out.push (.raw s!"\\noindent Déclaration {n}")
          out := out.push tTeX
          out := out.push (.raw "\\par\\nobreak\n")
          out := out.push (.seq (← body.mapM goB))
        | "proofsketch" =>
          out := out.push (.raw "\n\\noindent\\textit{Esquisse de preuve}\\par\\nobreak\n\\begingroup\\itshape ")
          out := out.push (.seq (← s.content.mapM goB))
          out := out.push (.raw "\\unskip\\nobreak\\hfill$\\square$\\endgroup\\par\n")
        | "title" => pure ()
        | _ => out := out.push (.seq (← s.content.mapM goB))
      out := out.push (.raw "\\par\\addvspace{0.6em}\n")
      pure (.seq out)
  extraCss := [
r#"
.k7-theorem { margin: 1.2rem 0; padding: 0.2rem 0.9rem; border-left: 3px solid #98B2C0; }
.k7-thm-head { font-weight: bold; margin: 0.5rem 0 0.2rem 0; }
.k7-level { font-weight: normal; font-size: 0.85em; }
.k7-stm-head { margin: 0.3rem 0 0.1rem 0; }
.k7-proof { font-style: italic; }
.k7-proof-head { margin: 0.5rem 0 0.1rem 0; }
.k7-qed { float: right; font-style: normal; }
"#
  ]

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- Arguments of `theorem`. -/
structure ThmArgs where
  label : Option String := none
  status : String := "theoreme"
  level : String := "langage"

meta instance : FromArgs ThmArgs m where
  fromArgs :=
    ThmArgs.mk <$> .named `label .string true <*> .namedD `status .string "theoreme"
      <*> .namedD `level .string "langage"

/-- Shared metadata accepted by every specialized statement command. -/
structure StatementArgs where
  label : Option String := none
  level : String := "langage"
  role : String := ""
  state : String := ""
  evidence : String := "none"
  scope : String := "unspecified"
  source : String := ""
  formalArtifact : String := ""

meta instance : FromArgs StatementArgs m where
  fromArgs :=
    StatementArgs.mk <$> .named `label .string true
      <*> .namedD `level .string "langage"
      <*> .namedD `role .string ""
      <*> .namedD `state .string ""
      <*> .namedD `evidence .string "none"
      <*> .namedD `scope .string "unspecified"
      <*> .namedD `source .string ""
      <*> .namedD `formalArtifact .string ""

/-- Shared constructor and validation path for the specialized commands. -/
meta def statementDirective (kind display defaultRole defaultState : String)
    (labelRequired : Bool) : DirectiveExpanderOf StatementArgs
  | args, stxs => do
    if labelRequired && args.label.isNone then
      throwError s!"{display}: a label is required for a numbered/referenced statement"
    let state := if args.state.isEmpty then
      (if defaultState.isEmpty then "under-review" else defaultState)
      else args.state
    if !allowedEpistemicState state then
      throwError s!"{display}: invalid epistemic state '{state}'"
    if isTruthClaimKind kind && state == "not-applicable" then
      throwError s!"{display}: results and assumptions require an epistemic state"
    if !isTruthClaimKind kind && state != "not-applicable" then
      throwError s!"{display}: this object kind uses state := \"not-applicable\""
    if !allowedEvidence args.evidence then
      throwError s!"{display}: invalid evidence kind '{args.evidence}'"
    let role := if args.role.isEmpty then defaultRole else args.role
    if !validRoleForKind kind role then
      throwError s!"{display}: role '{role}' is not valid for object kind '{kind}'"
    let evidence := if kind == "literature" && args.evidence == "none" then "literature" else args.evidence
    if (kind == "literature" || evidence == "literature") && args.source.isEmpty then
      throwError "literature evidence requires (source := \"bibliographic identifier or URL\")"
    if evidence == "lean-proof" && args.formalArtifact.isEmpty then
      throwError "evidence := \"lean-proof\" requires (formalArtifact := \"Module.declaration\")"
    if !args.formalArtifact.isEmpty && evidence != "lean-proof" then
      throwError "formalArtifact is only valid with evidence := \"lean-proof\""
    if kind == "assumption" && role == "hypothesis" && (args.scope == "unspecified" || args.scope == "global") then
      throwError "hypothesis requires an explicit local scope; it must not become a global assumption"
    let children ← stxs.mapM elabBlock
    let info := StatementInfo.mk args.label display args.level kind role state evidence
      args.scope args.source args.formalArtifact none
    ``(Verso.Doc.Block.other (SpecExt.Block.theorem $(quote info)) #[$children,*])

/-- Backwards-compatible directive for existing legacy blocks. -/
@[directive]
meta def thm : DirectiveExpanderOf ThmArgs
  | {label, status, level}, stxs => do
    let children ← stxs.mapM elabBlock
    let (kind, role, state, evidence) := legacyClassification status
    let info := StatementInfo.mk label status level kind role state evidence
      "legacy-unspecified" "" "" none
    ``(Verso.Doc.Block.other (SpecExt.Block.theorem $(quote info)) #[$children,*])

@[directive] meta def definition : DirectiveExpanderOf StatementArgs :=
  statementDirective "definition" "Définition" "" "not-applicable" false
@[directive] meta def «axiom» : DirectiveExpanderOf StatementArgs :=
  statementDirective "assumption" "Axiome" "axiom" "" true
@[directive] meta def postulate : DirectiveExpanderOf StatementArgs :=
  statementDirective "assumption" "Postulat" "postulate" "" true
@[directive] meta def hypothesis : DirectiveExpanderOf StatementArgs :=
  statementDirective "assumption" "Hypothèse" "hypothesis" "" false
@[directive] meta def «theorem» : DirectiveExpanderOf StatementArgs :=
  statementDirective "result" "Théorème" "theorem" "" true
@[directive] meta def «lemma» : DirectiveExpanderOf StatementArgs :=
  statementDirective "result" "Lemme" "lemma" "" true
@[directive] meta def corollary : DirectiveExpanderOf StatementArgs :=
  statementDirective "result" "Corollaire" "corollary" "" true
@[directive] meta def proposition : DirectiveExpanderOf StatementArgs :=
  statementDirective "result" "Proposition" "proposition" "" true
@[directive] meta def conjecture : DirectiveExpanderOf StatementArgs :=
  statementDirective "result" "Conjecture" "conjecture" "proposed" true
@[directive] meta def requirement : DirectiveExpanderOf StatementArgs :=
  statementDirective "requirement" "Exigence" "" "not-applicable" true
@[directive] meta def literature : DirectiveExpanderOf StatementArgs :=
  statementDirective "literature" "Résultat de la littérature" "" "not-applicable" true
@[directive] meta def «example» : DirectiveExpanderOf StatementArgs :=
  statementDirective "example" "Exemple" "" "not-applicable" false
@[directive] meta def counterexample : DirectiveExpanderOf StatementArgs :=
  statementDirective "counterexample" "Contre-exemple" "" "not-applicable" false

end SpecExt
