-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

/-!
# Recognising index and glossary terms in running text

The pure core of the automatic index of the specification: no Verso, no IO, so that it is tested
from `tests/` (`SpecToolsTest`). The Verso side (`SpecExt.AutoMark`) walks the document and calls
`findHits` on every text node.

A term is recognised on _word boundaries_, ignoring case and French diacritics, and with an
optional plural mark (`s` or `x`) : the rule that `org-glossary` applied to the Org manuscript.

## Main definitions

* `SpecExt.IndexCore.Entry`: a term to recognise.
* `SpecExt.IndexCore.findHits`: the occurrences of the terms in a text, leftmost and longest.
* `SpecExt.IndexCore.cut`: a text split into plain segments and recognised occurrences.
* `SpecExt.IndexCore.sortKey`: the key under which a term is sorted in the printed index.
-/

namespace SpecExt.IndexCore

/-- Folds a character for matching and sorting: lower case, French diacritics removed. One
character in, one character out, so that positions in the folded text are positions in the text. -/
def foldChar (c : Char) : Char :=
  match c with
  | 'à' | 'â' | 'ä' | 'á' | 'À' | 'Â' | 'Ä' | 'Á' | 'æ' | 'Æ' => 'a'
  | 'ç' | 'Ç' => 'c'
  | 'é' | 'è' | 'ê' | 'ë' | 'É' | 'È' | 'Ê' | 'Ë' => 'e'
  | 'î' | 'ï' | 'í' | 'Î' | 'Ï' | 'Í' => 'i'
  | 'ô' | 'ö' | 'ó' | 'Ô' | 'Ö' | 'Ó' | 'œ' | 'Œ' => 'o'
  | 'ù' | 'û' | 'ü' | 'ú' | 'Ù' | 'Û' | 'Ü' | 'Ú' => 'u'
  | 'ÿ' | 'Ÿ' => 'y'
  | '’' => '\''
  | ' ' | ' ' => ' '
  | c => c.toLower

/-- Whether a (folded) character belongs to a word. -/
def isWordChar (c : Char) : Bool := (foldChar c).isAlphanum

/-- The key under which `term` is sorted: folded, and reduced to letters and digits. -/
def sortKey (term : String) : String :=
  String.ofList (term.toList.map foldChar |>.filter Char.isAlphanum)

/-- A term to recognise in the text. -/
structure Entry where
  /-- The term, as printed. -/
  term : String
  /-- Other spellings recognised as the same term. -/
  variants : Array String := #[]
  /-- Match case as well (acronyms), instead of ignoring it. -/
  exactCase : Bool := false
  /-- Accept a plural mark (`s` or `x`) after the term. -/
  plural : Bool := true
deriving Repr, BEq, Inhabited

/-- An occurrence: the half-open range `[start, stop)` of characters of the text, and the index
of the recognised entry. -/
structure Hit where
  /-- First character of the occurrence. -/
  start : Nat
  /-- One past the last character of the occurrence. -/
  stop : Nat
  /-- Index of the entry in the array given to `findHits`. -/
  entry : Nat
deriving Repr, BEq

/-- Whether `needle` occurs in `hay` at `i`, comparing through `norm`. -/
def matchesAt (norm : Char → Char) (hay needle : Array Char) (i : Nat) : Bool :=
  i + needle.size ≤ hay.size &&
    (List.range needle.size).all fun k => norm hay[i + k]! == norm needle[k]!

/-- The occurrences of `entries` in `text`: scanning left to right, at each position the longest
spelling that stands on word boundaries, a plural mark being absorbed. Occurrences do not overlap. -/
def findHits (entries : Array Entry) (text : String) : Array Hit := Id.run do
  let hay := text.toList.toArray
  let mut hits : Array Hit := #[]
  let mut i := 0
  while i < hay.size do
    if i > 0 && isWordChar hay[i - 1]! then
      i := i + 1
      continue
    let mut best : Option Hit := none
    for k in [0:entries.size] do
      let e := entries[k]!
      for spelling in #[e.term] ++ e.variants do
        let needle := spelling.toList.toArray
        if needle.size == 0 then continue
        let norm : Char → Char := if e.exactCase then id else foldChar
        if matchesAt norm hay needle i then
          let stop := i + needle.size
          let boundary (j : Nat) : Bool := j ≥ hay.size || !isWordChar hay[j]!
          let stop? : Option Nat :=
            if boundary stop then some stop
            else if e.plural && stop < hay.size && (hay[stop]! == 's' || hay[stop]! == 'x')
                && boundary (stop + 1) then some (stop + 1)
            else none
          match stop? with
          | none => pure ()
          | some stop =>
            if best.all fun b => b.stop - b.start < stop - i then
              best := some { start := i, stop, entry := k }
    match best with
    | some b =>
      hits := hits.push b
      i := b.stop
    | none => i := i + 1
  return hits

/-- A text cut into plain segments (`none`) and recognised occurrences (`some entry`). -/
def cut (text : String) (hits : Array Hit) : Array (String × Option Nat) := Id.run do
  let chars := text.toList.toArray
  let slice (a b : Nat) : String := String.ofList ((chars.extract a b).toList)
  let mut out : Array (String × Option Nat) := #[]
  let mut pos := 0
  for h in hits do
    if pos < h.start then out := out.push (slice pos h.start, none)
    out := out.push (slice h.start h.stop, some h.entry)
    pos := h.stop
  if pos < chars.size then out := out.push (slice pos chars.size, none)
  return out

end SpecExt.IndexCore
