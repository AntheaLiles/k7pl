-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

import SpecExt.IndexCore
import SpecExt.IndexTerms
import SpecExt.Translate

/-!
# Tests of the specification tooling

The pure parts of the generator of the specification: recognition of index terms in the text
(`SpecExt.IndexCore`) and the French interface of the HTML pages (`SpecExt.Translate`).
-/

namespace SpecToolsTest

open SpecExt IndexCore Translate

/-- Two entries: a phrase, and an acronym that must match case. -/
def sample : Array Entry :=
  #[{ term := "préservation du typage" }, { term := "WCET", exactCase := true, plural := false },
    { term := "terminaison" }]

/-- The recognised strings of `text`. -/
def found (text : String) : List (String × Nat) :=
  let chars := text.toList.toArray
  (findHits sample text).toList.map fun h =>
    (String.ofList ((chars.extract h.start h.stop).toList), h.entry)

-- Compile-time checks.
#guard found "La Préservation du typage tient." == [("Préservation du typage", 0)]
#guard found "des terminaisons" == [("terminaisons", 2)]
#guard found "la determinaison" == []
#guard found "interminaison" == []
#guard found "le wcet et le WCET" == [("WCET", 1)]
#guard found "terminaison, puis préservation du typage" == [("terminaison", 2), ("préservation du typage", 0)]
#guard sortKey "édition de liens" == "editiondeliens"
#guard (cut "a terminaison b" (findHits sample "a terminaison b")).toList ==
  [("a ", none), ("terminaison", some 2), (" b", none)]
#guard translateHtml "<html><span class=\"\">Table of Contents</span>" ==
  "<html lang=\"fr\"><span class=\"\">Table des matières</span>"
#guard translateJs "setCount(`${n} result${n === 1 ? \"\" : \"s\"}`);" ==
  "setCount(`${n} résultat${n === 1 ? \"\" : \"s\"}`);"
#guard translateHtml (translateHtml "<html><title>Search</title>") == translateHtml "<html><title>Search</title>"

/-- The thirty-one terms of the manuscript's index are all declared. -/
def indexComplete : Bool :=
  indexTerms.size == 31 && indexTerms.all fun e => e.term.length > 3

/-- Runtime checks, run by `lake test`. -/
def tests : List (String × Bool) :=
  [("index: phrase recognised ignoring case", found "La Préservation du typage tient." == [("Préservation du typage", 0)]),
   ("index: plural absorbed", found "des terminaisons" == [("terminaisons", 2)]),
   ("index: word boundaries", found "interminaison" == []),
   ("index: acronym matches case", found "le wcet et le WCET" == [("WCET", 1)]),
   ("index: sort key folds accents", sortKey "édition de liens" == "editiondeliens"),
   ("index: thirty-one terms", indexComplete),
   ("translate: language and navigation",
     translateHtml "<html>>Source Code<" == "<html lang=\"fr\">>Code source<"),
   ("translate: idempotent", translateHtml (translateHtml "<html><title>Search</title>") == translateHtml "<html><title>Search</title>")]

end SpecToolsTest
