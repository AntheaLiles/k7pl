-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: Apache-2.0

import Lean
import VersoManual
import SpecExt.Render

/-!
# Proof visualizations rendered by Verso

The extension consumes versioned JSON emitted before the Verso build. Both the HTML
and TeX renderers read the same artifact and manifest. These rendered observations
are not proof terms and do not establish normative correspondence.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

private def proofDataRoot : System.FilePath := "_out/proof-visualizations/data"

private def proofField (value : Json) (key : String) : Json :=
  (value.getObjVal? key).toOption.getD Json.null

private def proofString (value : Json) (fallback : String := "") : String :=
  value.getStr?.toOption.getD fallback

private def proofStringField (value : Json) (key : String) (fallback : String := "") : String :=
  proofString (proofField value key) fallback

private def proofArray (value : Json) : Array Json :=
  value.getArr?.toOption.getD #[]

private def proofArrayField (value : Json) (key : String) : Array Json :=
  proofArray (proofField value key)

private def proofNatField (value : Json) (key : String) (fallback : Nat := 0) : Nat :=
  (fromJson? (α := Nat) (proofField value key)).toOption.getD fallback

private def proofIOError {α : Type} (message : String) : IO α :=
  throw (IO.userError message)

private def loadProofArtifact (slug : String) : IO Json := do
  if !(["eval-double", "scale-usage-comp", "project-usage-context-scale", "grade-budget-finite-multiplicity", "memory-capability-allocate-unique"] : List String).contains slug then
    throw <| IO.userError s!"Unknown proof visualization identifier: {slug}"

  let artifactText ← IO.FS.readFile (proofDataRoot / s!"{slug}.json")
  let manifestText ← IO.FS.readFile (proofDataRoot / "manifest.json")
  let artifact ← match Json.parse artifactText with
    | .ok value => pure value
    | .error error => throw <| IO.userError s!"Malformed proof artifact {slug}: {error}"
  let manifest ← match Json.parse manifestText with
    | .ok value => pure value
    | .error error => throw <| IO.userError s!"Malformed proof manifest: {error}"

  if proofStringField artifact "schemaVersion" != "k7pl.proof-visualization/v1" then
    throw <| IO.userError s!"Unsupported proof artifact schema for {slug}"
  if proofStringField manifest "schemaVersion" != "k7pl.proof-visualization/v1" then
    throw <| IO.userError "Unsupported proof manifest schema"
  if proofStringField artifact "status" != "extracted" then
    throw <| IO.userError s!"Proof artifact {slug} is not marked extracted"
  if proofStringField artifact "slug" != slug then
    throw <| IO.userError s!"Proof artifact identifier does not match requested slug {slug}"

  let identity := proofField artifact "identity"
  let extracted := proofField artifact "extracted"
  let declaration := proofStringField identity "declaration"
  let sourcePath := proofStringField identity "source"
  let sourceUrl := proofStringField identity "sourceUrl"
  let revision := proofStringField identity "sourceRevision"
  let (expectedDeclaration, expectedSource) := match slug with
    | "eval-double" => ("K7pl.Arith.eval_double", "src/K7pl/Arith.lean")
    | "scale-usage-comp" => ("K7pl.UsageScale.scaleUsage_comp", "src/K7pl/UsageScale.lean")
    | "project-usage-context-scale" => ("K7pl.UsageScale.projectUsageContext_scale", "src/K7pl/UsageScale.lean")
    | "grade-budget-finite-multiplicity" => ("K7pl.GradeBudget.finite_multiplicity_compatibility", "src/K7pl/GradeBudget.lean")
    | _ => ("K7pl.MemoryCapability.allocate_preserves_unique", "src/K7pl/MemoryCapability.lean")
  if declaration != expectedDeclaration || sourcePath != expectedSource then
    throw <| IO.userError s!"Proof artifact identity does not match the curated target {slug}"
  let sourceLines := proofField identity "sourceLines"
  let lineStart := proofNatField sourceLines "start"
  let lineEnd := proofNatField sourceLines "end"
  if lineStart == 0 || lineEnd < lineStart then
    throw <| IO.userError s!"Invalid source-line range for {declaration}"
  let expectedSourceUrl := s!"https://github.com/AntheaLiles/k7pl/blob/{revision}/{sourcePath}#L{lineStart}-L{lineEnd}"
  if sourceUrl != expectedSourceUrl then
    throw <| IO.userError s!"Source URL does not match canonical source identity for {declaration}"
  let manifestRevision := proofStringField manifest "sourceRevision"
  if revision.isEmpty || revision != manifestRevision then
    throw <| IO.userError s!"Stale or mixed proof artifact revision for {declaration}"
  if !(sourcePath.startsWith "src/") then
    throw <| IO.userError s!"Unexpected canonical source path for {declaration}: {sourcePath}"
  if !(sourceUrl.startsWith s!"https://github.com/AntheaLiles/k7pl/blob/{revision}/") then
    throw <| IO.userError s!"Source URL does not match the artifact revision for {declaration}"
  if !(proofArrayField manifest "declarations").any (fun item => proofString item == declaration) then
    throw <| IO.userError s!"Manifest does not list proof declaration {declaration}"

  let steps := proofArrayField extracted "steps"
  if steps.isEmpty then
    throw <| IO.userError s!"Proof artifact {slug} has no tactic observations"
  for step in steps do
    if (proofStringField step "tacticString").isEmpty then
      throw <| IO.userError s!"Proof artifact {slug} has a step without a tactic string"
    if proofField step "goalBefore" == Json.null then
      throw <| IO.userError s!"Proof artifact {slug} has a step without its before-goal"
    if proofField step "position" == Json.null then
      throw <| IO.userError s!"Proof artifact {slug} has a step without a source position"

  let currentRevision ← IO.getEnv "GITHUB_SHA"
  if let some currentRevision := currentRevision then
    if !currentRevision.isEmpty && currentRevision != revision then
      throw <| IO.userError s!"Proof artifact revision {revision} does not match GITHUB_SHA {currentRevision}"
  return artifact

private def proofRole (hypothesis : Json) : String :=
  match proofStringField hypothesis "isProof" with
  | "proof" => "preuve"
  | "data" => "donnée"
  | "universe" => "univers"
  | _ => "rôle non précisé"

private def proofGoalHtml (heading : String) (goal : Json) : Output.Html := Id.run do
  let goalType := proofStringField goal "type" "Type indisponible dans l'export"
  let hypotheses := proofArrayField goal "hyps"
  let mut hypothesisItems : Array Output.Html := #[]
  for hypothesis in hypotheses do
    let username := proofStringField hypothesis "username" "?"
    let hypothesisType := proofStringField hypothesis "type" "type non fourni"
    let role := proofRole hypothesis
    hypothesisItems := hypothesisItems.push
      {{<li><strong>{{username}}</strong>{{" : "}}<code>{{hypothesisType}}</code>{{" "}}<span class="k7-proofviz-role">{{role}}</span></li>}}
  let hypothesisBlock : Output.Html :=
    if hypotheses.isEmpty then
      {{<p class="k7-proofviz-muted">{{"Aucune hypothèse n'est rapportée pour cet objectif dans cet export."}}</p>}}
    else
      {{<details><summary>{{"Hypothèses et variables (" ++ toString hypotheses.size ++ ")"}}</summary><ul>{{Output.Html.seq hypothesisItems}}</ul></details>}}
  return {{<section class="k7-proofviz-goal"><h5>{{heading}}</h5><pre>{{goalType}}</pre>{{hypothesisBlock}}</section>}}

private def proofGoalCollectionHtml (heading : String) (goals : Array Json) (emptyMessage : String) : Output.Html := Id.run do
  if goals.isEmpty then
    return {{<section class="k7-proofviz-outcomes"><h5>{{heading}}</h5><p class="k7-proofviz-muted">{{emptyMessage}}</p></section>}}
  let mut items : Array Output.Html := #[]
  for i in [:goals.size] do
    items := items.push (proofGoalHtml s!"{heading} {i + 1}" goals[i]!)
  return {{<section class="k7-proofviz-outcomes"><h5>{{heading ++ " (" ++ toString goals.size ++ ")"}}</h5>{{Output.Html.seq items}}</section>}}

private def appendProofGoalTeX (output : Array Verso.Output.TeX) (heading : String) (goal : Json) :
    Array Verso.Output.TeX := Id.run do
  let mut result := output
  let goalType := SpecExt.texEscape (proofStringField goal "type" "Type indisponible dans l'export")
  result := result.push (.raw ("\\par\\noindent\\textit{" ++ SpecExt.texEscape heading ++ "}\\par\n\\begingroup\\small\\ttfamily\\sloppy\n"))
  result := result.push (.raw (goalType ++ "\\par\n\\endgroup\n"))
  let hypotheses := proofArrayField goal "hyps"
  for hypothesis in hypotheses do
    let username := SpecExt.texEscape (proofStringField hypothesis "username" "?")
    let hypothesisType := SpecExt.texEscape (proofStringField hypothesis "type" "type non fourni")
    result := result.push (.raw ("\\noindent\\texttt{" ++ username ++ "} : \\texttt{" ++ hypothesisType ++ "}\\par\n"))
  if hypotheses.isEmpty then
    result := result.push (.raw "\\noindent\\textit{Aucune hypothèse rapportée dans cet export.}\\par\n")
  return result

block_extension Block.proofVisualization (slug : String) where
  data := toJson slug
  traverse _ _ _ := pure none
  toHtml := some fun _ _ id data _ => do
    let slug ← match fromJson? (α := String) data with
      | .ok value => pure value
      | .error error => liftM (proofIOError s!"Invalid proof visualization block data: {error}")
    let artifact ← liftM <| loadProofArtifact slug
    let identity := proofField artifact "identity"
    let editorial := proofField artifact "editorial"
    let provenance := proofField artifact "provenance"
    let extracted := proofField artifact "extracted"
    let title := proofStringField editorial "title" "Visualisation de preuve"
    let description := proofStringField editorial "description" ""
    let declaration := proofStringField identity "declaration" "Déclaration inconnue"
    let sourcePath := proofStringField identity "source" "Chemin source non fourni"
    let sourceUrl := proofStringField identity "sourceUrl" "#"
    let revision := proofStringField identity "sourceRevision" "révision inconnue"
    let sourceHash := proofStringField identity "sourceSha256" "empreinte indisponible"
    let extractorToolchain := proofStringField provenance "paperproofToolchain" "toolchain inconnue"
    let extractorRevision := proofStringField provenance "paperproofRevision" "révision inconnue"
    let steps := proofArrayField extracted "steps"
    let mut renderedSteps : Array Output.Html := #[]
    for i in [:steps.size] do
      let step := steps[i]!
      let tactic := proofStringField step "tacticString" "Tactique non fournie"
      let position := proofField step "position"
      let start := proofField position "start"
      let line := proofNatField start "line" + 1
      let column := proofNatField start "character" + 1
      renderedSteps := renderedSteps.push
        {{<li class="k7-proofviz-step">
            <h4>{{"Étape " ++ toString (i + 1)}}</h4>
            <p>{{"Tactique observée : "}}<code>{{tactic}}</code>{{s!" · Source : ligne {line}, colonne {column}"}}</p>
            {{proofGoalHtml "Objectif avant la tactique" (proofField step "goalBefore")}}
            {{proofGoalCollectionHtml "Objectifs après" (proofArrayField step "goalsAfter") "Aucun objectif après n'est associé à cette transition dans l'export."}}
            {{proofGoalCollectionHtml "Autres objectifs rapportés par l’export" (proofArrayField step "spawnedGoals") "Aucun objectif supplémentaire n'est rapporté pour cette transition."}}
          </li>}}
    let state ← HtmlT.state
    pure {{<section class="k7-proofviz" {{state.htmlId id}}>
        <header class="k7-proofviz-header">
          <p class="k7-proofviz-kicker">{{"Observation dérivée · non normative"}}</p>
          <h3>{{title}}</h3>
          <p>{{description}}</p>
          <p>{{"Déclaration Lean : "}}<code>{{declaration}}</code></p>
          <p>{{"Source canonique : "}}<a href={{sourceUrl}}>{{sourcePath}}</a>{{" · Révision "}}<code>{{revision}}</code></p>
          <p>{{"SHA-256 source : "}}<code>{{sourceHash}}</code></p>
        </header>
        <p class="k7-proofviz-notice">{{"Ces états et transitions sont des observations de l'extracteur Paperproof. Ils ne constituent pas une preuve indépendante et ne démontrent aucune correspondance normative. La compilation K7PL sous Lean 4.34.0 reste un contrôle séparé."}}</p>
        <p>{{"Extracteur : "}}<code>{{extractorRevision}}</code>{{" · Lean de l'extracteur : "}}<code>{{extractorToolchain}}</code></p>
        <ol class="k7-proofviz-steps">{{Output.Html.seq renderedSteps}}</ol>
      </section>}}
  toTeX := some fun _ _ _ data _ => do
    let slug ← match fromJson? (α := String) data with
      | .ok value => pure value
      | .error error => liftM (proofIOError s!"Invalid proof visualization block data: {error}")
    let artifact ← liftM <| loadProofArtifact slug
    let identity := proofField artifact "identity"
    let editorial := proofField artifact "editorial"
    let provenance := proofField artifact "provenance"
    let extracted := proofField artifact "extracted"
    let title := SpecExt.texEscape (proofStringField editorial "title" "Visualisation de preuve")
    let description := SpecExt.texEscape (proofStringField editorial "description" "")
    let declaration := SpecExt.texEscape (proofStringField identity "declaration" "Déclaration inconnue")
    let sourcePath := SpecExt.texEscape (proofStringField identity "source" "Chemin source non fourni")
    let revision := SpecExt.texEscape (proofStringField identity "sourceRevision" "révision inconnue")
    let sourceHash := SpecExt.texEscape (proofStringField identity "sourceSha256" "empreinte indisponible")
    let extractorToolchain := SpecExt.texEscape (proofStringField provenance "paperproofToolchain" "toolchain inconnue")
    let extractorRevision := SpecExt.texEscape (proofStringField provenance "paperproofRevision" "révision inconnue")
    let steps := proofArrayField extracted "steps"
    let mut output : Array Verso.Output.TeX := #[
      .raw ("\\par\\addvspace{0.6em}\\noindent\\textbf{Observation dérivée : " ++ title ++ "}\\par\n"),
      .raw ("\\noindent\\textit{Commentaire éditorial : }" ++ description ++ "\\par\n"),
      .raw ("\\noindent\\textit{Déclaration Lean : }\\texttt{" ++ declaration ++ "}\\par\n"),
      .raw ("\\noindent\\textit{Source canonique : }\\texttt{" ++ sourcePath ++ "}\\par\n"),
      .raw ("\\noindent\\textit{Révision source : }\\texttt{" ++ revision ++ "}\\par\n"),
      .raw ("\\noindent\\textit{SHA-256 source :}\\par\n\\noindent\\texttt{" ++ sourceHash ++ "}\\par\n"),
      .raw ("\\noindent\\textit{Révision de l'extracteur : }\\texttt{" ++ extractorRevision ++ "}\\par\n"),
      .raw ("\\noindent\\textit{Lean de l'extracteur : }\\texttt{" ++ extractorToolchain ++ "}\\par\n"),
      .raw ("\\noindent\\emph{Les transitions affichées sont des observations dérivées, non une preuve indépendante ni une correspondance normative. Le build K7PL sous Lean 4.34.0 reste un contrôle séparé.}\\par\n")
    ]
    for i in [:steps.size] do
      let step := steps[i]!
      let tactic := SpecExt.texEscape (proofStringField step "tacticString" "Tactique non fournie")
      let position := proofField step "position"
      let start := proofField position "start"
      let line := proofNatField start "line" + 1
      let column := proofNatField start "character" + 1
      output := output.push (.raw ("\\par\\medskip\\noindent\\textbf{Étape " ++ toString (i + 1) ++ " : }\\texttt{" ++ tactic ++ "}\\par\n"))
      output := output.push (.raw ("\\noindent\\textit{Position source : }ligne " ++ toString line ++ ", colonne " ++ toString column ++ ".\\par\n"))
      output := appendProofGoalTeX output "Objectif avant la tactique" (proofField step "goalBefore")
      let after := proofArrayField step "goalsAfter"
      if after.isEmpty then
        output := output.push (.raw "\\noindent\\textit{Aucun objectif après n'est associé à cette transition dans l'export.}\\par\n")
      else
        for j in [:after.size] do
          output := appendProofGoalTeX output s!"Objectif après {j + 1}" after[j]!
      let spawned := proofArrayField step "spawnedGoals"
      if spawned.isEmpty then
        output := output.push (.raw "\\noindent\\textit{Aucun objectif supplémentaire rapporté pour cette transition.}\\par\n")
      else
        for j in [:spawned.size] do
          output := appendProofGoalTeX output s!"Autre objectif rapporté par l’export {j + 1}" spawned[j]!
    output := output.push (.raw "\\par\\addvspace{0.6em}\n")
    pure (.seq output)
  extraCss := [
r#"
.k7-proofviz { margin: 1.4rem 0; padding: 0.75rem 1rem; border: 1px solid currentColor; border-radius: .35rem; }
.k7-proofviz-header { border-bottom: 1px solid currentColor; margin-bottom: 1rem; }
.k7-proofviz-kicker { font-size: .85em; font-weight: 600; text-transform: uppercase; letter-spacing: .04em; }
.k7-proofviz-notice { padding: .65rem; border-left: .25rem solid currentColor; }
.k7-proofviz-steps { padding-left: 1.5rem; }
.k7-proofviz-step { margin: 1.3rem 0; }
.k7-proofviz-step h4 { margin-bottom: .3rem; }
.k7-proofviz-goal, .k7-proofviz-outcomes { margin: .6rem 0; padding: .6rem; border: 1px solid currentColor; border-radius: .25rem; }
.k7-proofviz-goal pre { white-space: pre-wrap; overflow-wrap: anywhere; font-family: ui-monospace, SFMono-Regular, Consolas, monospace; }
.k7-proofviz-goal li { margin: .25rem 0; }
.k7-proofviz-role { font-size: .8em; border: 1px solid currentColor; border-radius: 1rem; padding: .05rem .3rem; }
.k7-proofviz-muted { opacity: .85; }
@media print { .k7-proofviz-goal, .k7-proofviz-outcomes { break-inside: avoid; } }
"#
  ]

section
variable {m : Type → Type} [Monad m] [MonadError m]

structure ProofVisualizationArgs where
  slug : Option String := none

meta instance : FromArgs ProofVisualizationArgs m where
  fromArgs := ProofVisualizationArgs.mk <$> .named (Name.mkSimple "slug") .string true

@[directive]
meta def proofviz : DirectiveExpanderOf ProofVisualizationArgs
  | {slug}, stxs => do
    let slug := slug.getD ""
    if !(["eval-double", "scale-usage-comp", "project-usage-context-scale", "grade-budget-finite-multiplicity", "memory-capability-allocate-unique"] : List String).contains slug then
      throwError s!"proofviz: unknown proof visualization slug '{slug}'"
    if !stxs.isEmpty then
      throwError "proofviz: content blocks are not accepted; the JSON artifact is authoritative"
    ``(Verso.Doc.Block.other (SpecExt.Block.proofVisualization $(quote slug)) #[])

end

end SpecExt
