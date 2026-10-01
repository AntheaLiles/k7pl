-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import VersoManual

/-!
# Shared helpers of the specification extensions

Cross-reference labels (`\label` / `\ref` in the Org manuscript) live in a Verso *domain*.
Every labelled object registers its displayed number (`"3.2"`, `"12"`, …) there during the
traversal of the document, and references read it back when the document is rendered.
Numbers of counted objects (theorems, figures, tables, remarks…) are assigned once per internal
identifier, in document order, so that they are stable across traversal passes.
-/

open Lean (Json ToJson FromJson Name toJson fromJson?)
open Verso Genre Manual Doc

namespace SpecExt

variable {m : Type → Type}

/-- The blocks of `bs`, with the `concat` wrappers that the elaboration of directives leaves removed. -/
partial def flattenBlocks (bs : Array (Doc.Block Manual)) : Array (Doc.Block Manual) :=
  bs.foldl (init := #[]) fun acc b =>
    match b with
    | .concat inner => acc ++ flattenBlocks inner
    | b => acc.push b

/-- The Verso domain holding every cross-reference label of the specification. -/
def labelDomain : Name := `SpecExt.label

/-- What a label stands for. -/
structure LabelData where
  /-- Kind of object: `section`, `theorem`, `table`, `figure`, `formula`, `listing`, … -/
  kind : String
  /-- The number as printed in the text (`3.2`, `12`, `A.1`…). -/
  text : String
  /-- Plain-text title (caption), used by the lists of figures, tables… -/
  title : String := ""
deriving ToJson, FromJson, Inhabited

/-- Key of the JSON object holding the counters of the specification. -/
def countersKey : Name := `SpecExt.counters

/-- The counters as stored in the traversal state. -/
private def readCounters (st : TraverseState) : Json :=
  match st.get? (α := Json) countersKey with
  | some (.ok j) => j
  | _ => Json.mkObj []

/--
The number of the object identified by `id` in the sequence `kind`.

The first call for a given identifier takes the next free number; later calls (the following
traversal passes) return the same number.
-/
def assignNumber [Monad m] [MonadStateOf TraverseState m] (kind : String) (id : InternalId) :
    m Nat := do
  let st ← getThe TraverseState
  let counters := readCounters st
  let key := s!"{kind}#{(toJson id).compress}"
  match counters.getObjValAs? Nat key with
  | .ok n => return n
  | .error _ =>
    let n := (counters.getObjValAs? Nat s!"count:{kind}").toOption.getD 0 + 1
    let counters := counters.setObjVal! key n |>.setObjVal! s!"count:{kind}" n
    modifyThe TraverseState (·.set countersKey counters)
    return n

/-- How many objects of the sequence `kind` have been numbered so far. -/
def counterValue (st : TraverseState) (kind : String) : Nat :=
  (readCounters st |>.getObjValAs? Nat s!"count:{kind}").toOption.getD 0

/-- An anchor-friendly rendering of a label (`sec:c3-foo_bar` becomes `sec-c3-foo-bar`). -/
def anchorName (label : String) : String :=
  label.map fun c => if c.isAlphanum || c == '-' then c else '-'

/-- Registers `label` as pointing at the object `id`, printed as `data.text`. -/
def registerLabel [Monad m] [MonadStateOf TraverseState m] [MonadReaderOf TraverseContext m]
    (label : String) (id : InternalId) (data : LabelData) : m Unit := do
  let path := (← readThe TraverseContext).path
  let _ ← externalTag id path s!"lbl-{anchorName label}"
  modifyThe TraverseState fun st =>
    st |>.saveDomainObject labelDomain label id
       |>.saveDomainObjectData labelDomain label (toJson data)

/-- The Verso domain listing the captioned objects (figures, tables, formulas, listings). -/
def floatDomain : Name := `SpecExt.float

/--
Registers the `n`-th object of the sequence `kind`: it can be listed by `{listof kind}`, and, when
it has a `label`, referred to by `{num label}`.
-/
def registerNumbered [Monad m] [MonadStateOf TraverseState m] [MonadReaderOf TraverseContext m]
    (kind : String) (n : Nat) (id : InternalId) (title : Array (Bool × String)) (label : Option String) :
    m Unit := do
  match label with
  | some l => registerLabel l id { kind, text := toString n, title := (title.map (·.2)).toList |> String.join }
  | none =>
    let path := (← readThe TraverseContext).path
    let _ ← externalTag id path s!"k7-{kind}-{n}"
  modifyThe TraverseState fun st =>
    st |>.saveDomainObject floatDomain s!"{kind}:{n}" id
       |>.saveDomainObjectData floatDomain s!"{kind}:{n}" (toJson title)

end SpecExt
