-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic

/-!
# Rendering helpers shared by the extensions
-/

open Lean Elab
open Verso Genre Manual Doc
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

/-- The TeX label of the anchor registered for `id`, if any. -/
def texAnchor (id : InternalId) : TeXT Manual (ReaderT ExtensionImpls (BuildLogT IO)) Verso.Output.TeX := do
  let st ← TeX.state
  match st.externalTags[id]? with
  | some link => pure (.raw s!"\\label\{{Verso.Output.TeX.labelForTeX link.htmlId}}")
  | none => pure .empty

/-- The plain text of some inline content, for lists of figures, tables… -/
partial def plainText : Doc.Inline Manual → String
  | .text s | .code s | .math _ s => s
  | .linebreak _ => " "
  | .emph xs | .bold xs | .concat xs | .link xs _ | .footnote _ xs => String.join (xs.toList.map plainText)
  | .image alt _ => alt
  | .other _ xs => String.join (xs.toList.map plainText)

/-- Text of some inline content as segments, each flagged when it is mathematics. -/
partial def textSegments : Doc.Inline Manual → Array (Bool × String)
  | .text s | .code s => #[(false, s)]
  | .math _ s => #[(true, s)]
  | .linebreak _ => #[(false, " ")]
  | .emph xs | .bold xs | .concat xs | .link xs _ | .footnote _ xs => xs.foldl (· ++ textSegments ·) #[]
  | .image alt _ => #[(false, alt)]
  | .other _ xs => xs.foldl (· ++ textSegments ·) #[]

/-- The segments of the first paragraph among `bs`. -/
def firstParagraphSegments (bs : Array (Doc.Block Manual)) : Array (Bool × String) :=
  match (flattenBlocks bs).findSome? (fun b => match b with | .para xs => some xs | _ => none) with
  | some xs => xs.foldl (· ++ textSegments ·) #[]
  | none => #[]

/-- Escapes the characters that LaTeX treats specially. -/
def texEscape (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    match c with
    | '&' => acc ++ "\\&" | '%' => acc ++ "\\%" | '_' => acc ++ "\\_" | '#' => acc ++ "\\#"
    | '$' => acc ++ "\\$" | '{' => acc ++ "\\{" | '}' => acc ++ "\\}"
    | '\\' => acc ++ "\\textbackslash{}"
    | '~' => acc ++ "\\textasciitilde{}" | '^' => acc ++ "\\textasciicircum{}"
    | c => acc.push c

/-- Plain text of the first paragraph among `bs`. -/
def firstParagraphText (bs : Array (Doc.Block Manual)) : String :=
  match (flattenBlocks bs).findSome? (fun b => match b with | .para xs => some xs | _ => none) with
  | some xs => String.join (xs.toList.map plainText)
  | none => ""

end SpecExt
