-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Render
import SpecExt.IndexCore
import SpecExt.IndexTerms
import SpecExt.Index
import SpecExt.Slots
import SpecExt.Theorem

/-!
# Automatic recognition of index and glossary terms

The Org manuscript relied on `org-glossary`, which recognised in the text the terms of the index, of
the glossary and of the list of acronyms. This pass does the same on the document, before it is
rendered (`SpecMain`):

* every occurrence of a term of `SpecExt.indexTerms` becomes an index mark (`SpecExt.Inline.idx`) ;
* the first occurrence, in each chapter, of a term of the glossary or of an acronym becomes a
  glossary hint (`SpecExt.Inline.gloss`), carrying its definition.

Only rendered prose is marked: not code, mathematics, links, reference listings, the index itself,
author comments, or ordinary statement children that the HTML and TeX renderers omit.
-/

open Verso Genre Manual Doc
open SpecExt.IndexCore

namespace SpecExt

/-- What the pass recognises. -/
structure Recognisers where
  /-- The index terms. -/
  index : Array Entry
  /-- The glossary terms and the acronyms. -/
  gloss : Array Entry
  /-- The definition of each entry of `gloss`. -/
  glossDefs : Array String

/-- The glossary terms already hinted in the current chapter. -/
structure Seen where
  /-- The terms hinted so far. -/
  terms : Array String := #[]

private abbrev M := StateM Seen

/-- The entries of the definition lists found in the part titled `title`, with their definitions. -/
partial def definitionItems (title : String) (p : Part Manual) : Array (String × String) :=
  let own :=
    if p.titleString == title then
      (flattenBlocks p.content).foldl (init := (#[] : Array (String × String))) fun acc b =>
        match b with
        | .dl items =>
          acc ++ items.map fun it =>
            (String.join (it.term.toList.map plainText) |>.trimAscii.toString, firstParagraphText it.desc)
        | _ => acc
    else #[]
  p.subParts.foldl (init := own) fun acc sp => acc ++ definitionItems title sp

/-- The hint for the first occurrence of glossary terms in a text segment. -/
private def hintSegment (r : Recognisers) (s : String) : M (Array (Doc.Inline Manual)) := do
  let hits := findHits r.gloss s
  let mut kept : Array Hit := #[]
  for h in hits do
    let term := r.gloss[h.entry]!.term
    if !(← get).terms.contains term then
      modify fun st => { st with terms := st.terms.push term }
      kept := kept.push h
  return (cut s kept).map fun (seg, k?) =>
    match k? with
    | some k => Doc.Inline.other (SpecExt.Inline.gloss r.glossDefs[k]!) #[Doc.Inline.text seg]
    | none => Doc.Inline.text seg

/-- Marks the terms of a text node. -/
private def markText (r : Recognisers) (s : String) : M (Doc.Inline Manual) := do
  let mut out : Array (Doc.Inline Manual) := #[]
  for (seg, k?) in cut s (findHits r.index s) do
    match k? with
    | some k =>
      out := out.push (Doc.Inline.other (SpecExt.Inline.idx r.index[k]!.term) #[Doc.Inline.text seg])
    | none => out := out ++ (← hintSegment r seg)
  if out.size == 1 then return out[0]!
  else return .concat out

/-- Marks the inline content: text nodes, and what contains text. Links, code and mathematics
are left alone. -/
private partial def markInline (r : Recognisers) : Doc.Inline Manual → M (Doc.Inline Manual)
  | .text s => markText r s
  | .emph xs => .emph <$> xs.mapM (markInline r)
  | .bold xs => .bold <$> xs.mapM (markInline r)
  | .concat xs => .concat <$> xs.mapM (markInline r)
  | .footnote name xs => .footnote name <$> xs.mapM (markInline r)
  | .other c xs => .other c <$> xs.mapM (markInline r)
  | i => pure i

/-- Traverses source blocks in rendering order. For a statement child, only a named slot
is emitted by the HTML and TeX renderers. Other direct children remain in source but are not marked,
so they cannot create index anchors for text absent from both outputs. -/
private partial def markBlockMode (r : Recognisers) (statementChild : Bool) :
    Doc.Block Manual → M (Doc.Block Manual)
  | .concat bs => .concat <$> bs.mapM (markBlockMode r statementChild)
  | .other b bs =>
    if b.name == ``SpecExt.Block.comment then
      pure (.other b bs)
    else if statementChild then
      if b.name == ``SpecExt.Block.slot then
        .other b <$> bs.mapM (markBlockMode r false)
      else
        pure (.other b bs)
    else if b.name == ``SpecExt.Block.theorem then
      .other b <$> bs.mapM (markBlockMode r true)
    else
      .other b <$> bs.mapM (markBlockMode r false)
  | .para xs =>
    if statementChild then pure (.para xs)
    else .para <$> xs.mapM (markInline r)
  | .ul items =>
    if statementChild then pure (.ul items)
    else .ul <$> items.mapM fun ⟨bs⟩ => (fun bs => ⟨bs⟩) <$> bs.mapM (markBlockMode r false)
  | .ol n items =>
    if statementChild then pure (.ol n items)
    else .ol n <$> items.mapM fun ⟨bs⟩ => (fun bs => ⟨bs⟩) <$> bs.mapM (markBlockMode r false)
  | .dl items =>
    if statementChild then pure (.dl items)
    else .dl <$> items.mapM fun ⟨t, d⟩ => do
      let t ← t.mapM (markInline r)
      let d ← d.mapM (markBlockMode r false)
      pure ⟨t, d⟩
  | .blockquote bs =>
    if statementChild then pure (.blockquote bs)
    else .blockquote <$> bs.mapM (markBlockMode r false)
  | b => pure b

private def markBlock (r : Recognisers) : Doc.Block Manual → M (Doc.Block Manual) :=
  markBlockMode r false

/-- The parts whose text is a list of terms, not prose. -/
private def isListing (title : String) : Bool :=
  title.startsWith "Liste des" || title == "Index"

private partial def markPart (r : Recognisers) (depth : Nat) (p : Part Manual) : M (Part Manual) := do
  if isListing p.titleString then return p
  if depth == 1 then set ({} : Seen)
  let content ← p.content.mapM (markBlock r)
  let subParts ← p.subParts.mapM (markPart r (depth + 1))
  return { p with content, subParts }

/-- Recognises the terms of the index, of the glossary and of the acronyms in `doc`. -/
def autoMark (doc : Part Manual) : Part Manual :=
  let glosses := definitionItems "Liste des glosses" doc
  let acronyms := definitionItems "Liste des acronymes" doc
  let entries : Array (Entry × String) :=
    glosses.filterMap (fun (t, d) => if t.isEmpty then none else some ({ term := t }, d)) ++
    acronyms.filterMap (fun (t, d) =>
      if t.isEmpty then none else some ({ term := t, exactCase := true, plural := false }, d))
  let r : Recognisers :=
    { index := indexTerms, gloss := entries.map (·.1), glossDefs := entries.map (·.2) }
  (markPart r 0 doc).run' {}

end SpecExt
