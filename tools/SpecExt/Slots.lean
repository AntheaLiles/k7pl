-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual
import SpecExt.Basic

/-!
# Named slots

A slot is a named container (`:::caption`, `:::desc`, `:::statement`…). It has no rendering of its
own beyond a wrapper: the extensions that expect slots (figures, tables, theorems…) pick them out
of their children and place them where they belong.
-/

open Lean Elab
open Verso Genre Manual Doc Elab ArgParse
open Verso.Output.Html
open Verso.Doc.Html Verso.Doc.TeX

namespace SpecExt

block_extension Block.slot (name : String) (titled : Bool) where
  data := toJson (name, titled)
  traverse _ _ _ := pure none
  toHtml := some fun _ goB _ data bs => do
    let name := (fromJson? (α := String × Bool) data).toOption.map (·.1) |>.getD ""
    pure {{<div class={{"k7-slot k7-" ++ name}}>{{← bs.mapM goB}}</div>}}
  toTeX := some fun _ goB _ _ bs => do
    pure (.seq (← bs.mapM goB))

-- A comment of the manuscript, kept in the source but not rendered.
block_extension Block.comment where
  data := Json.null
  traverse _ _ _ := pure none
  toHtml := some fun _ _ _ _ _ => pure .empty
  toTeX := some fun _ _ _ _ _ => pure .empty

/-- The contents of a slot, with its name and whether its first paragraph is a title. -/
structure SlotInfo where
  name : String
  titled : Bool
  content : Array (Doc.Block Manual)

/-- Recognises a slot among the blocks of an extension. -/
def slotInfo? : Doc.Block Manual → Option SlotInfo
  | .other blk content =>
    if blk.name == ``SpecExt.Block.slot then
      match fromJson? (α := String × Bool) blk.data with
      | .ok (name, titled) => some ⟨name, titled, flattenBlocks content⟩
      | .error _ => none
    else none
  | _ => none

/-- Splits the children of an extension into its slots and its other blocks. -/
def splitSlots (bs : Array (Doc.Block Manual)) : Array SlotInfo × Array (Doc.Block Manual) :=
  (flattenBlocks bs).foldl (init := (#[], #[])) fun (slots, others) b =>
    match slotInfo? b with
    | some s => (slots.push s, others)
    | none => (slots, others.push b)

/-- The slot named `name`, if present. -/
def findSlot (slots : Array SlotInfo) (name : String) : Option SlotInfo :=
  slots.find? (·.name == name)

/-- The inlines of a paragraph. -/
def paraInlines? : Doc.Block Manual → Option (Array (Doc.Inline Manual))
  | .para xs => some xs
  | _ => none

/-- Splits the title (first paragraph) off a titled slot. -/
def SlotInfo.titleAndBody (s : SlotInfo) : Option (Array (Doc.Inline Manual)) × Array (Doc.Block Manual) :=
  match s.titled, s.content[0]?.bind paraInlines? with
  | true, some xs => (some xs, s.content.extract 1 s.content.size)
  | _, _ => (none, s.content)

section
variable {m : Type → Type} [Monad m] [MonadError m]

/-- Arguments of a slot directive. -/
structure SlotArgs where
  titled : Bool := false

meta instance : FromArgs SlotArgs m where
  fromArgs := SlotArgs.mk <$> .flag `titled false
end

/-- Builds the slot named `name`. -/
meta def mkSlot (name : String) : DirectiveExpanderOf SlotArgs
  | {titled}, stxs => do
    let args ← stxs.mapM elabBlock
    ``(Verso.Doc.Block.other (SpecExt.Block.slot $(quote name) $(quote titled)) #[$args,*])

/-- An author's comment (`# …` in the Org manuscript): kept in the source, never rendered. -/
@[directive]
meta def comment : DirectiveExpanderOf Unit
  | (), stxs => do
    let args ← stxs.mapM elabBlock
    ``(Verso.Doc.Block.other SpecExt.Block.comment #[$args,*])

/-- Caption of a figure, table, listing or formula. -/
@[directive]
meta def caption : DirectiveExpanderOf SlotArgs := mkSlot "caption"

/-- What a figure presents (`#+DESC:`). -/
@[directive]
meta def desc : DirectiveExpanderOf SlotArgs := mkSlot "desc"

/-- How to read a figure (`#+NOTE:`). -/
@[directive]
meta def note : DirectiveExpanderOf SlotArgs := mkSlot "note"

/-- Source of a figure (`#+SOURCE:`). -/
@[directive]
meta def source : DirectiveExpanderOf SlotArgs := mkSlot "source"

/-- Title of a theorem. -/
@[directive]
meta def title : DirectiveExpanderOf SlotArgs := mkSlot "title"

/-- The statement of a theorem. -/
@[directive]
meta def statement : DirectiveExpanderOf SlotArgs := mkSlot "statement"

/-- The proof sketch of a theorem. -/
@[directive]
meta def proofsketch : DirectiveExpanderOf SlotArgs := mkSlot "proofsketch"

end SpecExt
