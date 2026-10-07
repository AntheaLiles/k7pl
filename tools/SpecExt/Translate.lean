-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CECILL-2.1

/-!
# French interface of the generated HTML

The navigation of the HTML output (table of contents, search, permalinks, source and issue links)
is written in English by Verso. This module is the translation sheet of the rendering: a list of
exact replacements applied to the generated pages and to the scripts of the search box, after the
generation (`SpecMain`). Nothing here touches the text of the specification, whose own pages only
match a replacement if they contain the exact markup of the interface.

The replacements are pure functions on strings, so that they are tested from `tests/`
(`SpecToolsTest`) without generating the document.

## Main definitions

* `SpecExt.Translate.htmlRules`, `SpecExt.Translate.jsRules`: the translation sheet.
* `SpecExt.Translate.translateHtml`, `SpecExt.Translate.translateJs`: apply a sheet to a file.
* `SpecExt.Translate.translateTree`: rewrite a generated tree in place.
-/

namespace SpecExt.Translate

/-- Replacements for the HTML pages: each pattern is a piece of Verso's interface markup. -/
def htmlRules : List (String × String) := [
  (">Table of Contents<", ">Table des matières<"),
  (">Source Code<", ">Code source<"),
  (">Report Issues<", ">Signaler un problème<"),
  ("title=\"Permalink\"", "title=\"Lien permanent\""),
  ("<title>Search</title>", "<title>Rechercher</title>"),
  ("Search</h1>", "Rechercher</h1>"),
  ("This search feature requires JavaScript.", "Cette recherche demande JavaScript."),
  ("\"Not found: name '\"", "\"Introuvable : le nom '\""),
  ("\"Ambiguous: name '\"", "\"Ambigu : le nom '\""),
  ("\"No name provided\"", "\"Aucun nom fourni\""),
  ("<p>Searched domains:</p>", "<p>Domaines cherchés :</p>"),
  ("<p>Options:</p>", "<p>Possibilités :</p>"),
  ("This page expects a 'name' query parameter, along with documentation domains.",
   "Cette page attend le paramètre « name » de la requête, avec les domaines de documentation.")
]

/-- Replacements for the scripts of the search box (`-verso-search/search-*.js`). -/
def jsRules : List (String × String) := [
  ("\"Search...\"", "\"Rechercher…\""),
  ("\"Jump to...\"", "\"Aller à…\""),
  ("aria-label=\"Search\"", "aria-label=\"Rechercher\""),
  ("aria-label=\"Results\"", "aria-label=\"Résultats\""),
  ("\"Search…\"", "\"Rechercher…\""),
  ("setAttribute(\"aria-label\", \"Search\")", "setAttribute(\"aria-label\", \"Rechercher\")"),
  ("setAttribute(\"aria-label\", \"Filter results\")", "setAttribute(\"aria-label\", \"Filtrer les résultats\")"),
  ("\"Type a query in the search box to see results.\"",
   "\"Saisir une requête dans la zone de recherche pour voir les résultats.\""),
  ("\"Searching…\"", "\"Recherche…\""),
  ("`${n} result${n === 1 ? \"\" : \"s\"}`", "`${n} résultat${n === 1 ? \"\" : \"s\"}`"),
  ("`${n} of ${total} result${total === 1 ? \"\" : \"s\"}`",
   "`${n} sur ${total} résultat${total === 1 ? \"\" : \"s\"}`"),
  ("makeCheckbox(\"Full-text\"", "makeCheckbox(\"Plein texte\""),
  ("\"Full-text search result\"", "\"Résultat de la recherche en plein texte\""),
  ("\"Full-text search\"", "\"Recherche en plein texte\""),
  ("\"No results\"", "\"Aucun résultat\""),
  ("title=\"Result for “${searchTerms[bestStem]}”\"", "title=\"Résultat pour « ${searchTerms[bestStem]} »\""),
  ("title=\"Result for “${searchTerms[t.stem]}”\"", "title=\"Résultat pour « ${searchTerms[t.stem]} »\""),
  ("\"Go to \" + resName", "\"Aller à \" + resName"),
  ("\"Previous match\"", "\"Occurrence précédente\""),
  ("\"Next match\"", "\"Occurrence suivante\""),
  ("\"Close search\"", "\"Fermer la recherche\""),
  ("displayName: \"Terminology\"", "displayName: \"Terminologie\"")
]

/-- Applies a translation sheet: every pattern is replaced everywhere. -/
def apply (rules : List (String × String)) (s : String) : String :=
  rules.foldl (fun acc (pattern, replacement) => acc.replace pattern replacement) s

/-- Declares the language of a page: `<html>` becomes `<html lang="fr">`. -/
def declareLanguage (s : String) : String := s.replace "<html>" "<html lang=\"fr\">"

/-- Translates the interface of an HTML page. -/
def translateHtml (s : String) : String := declareLanguage (apply htmlRules s)

/-- Translates the interface of a script of the search box. -/
def translateJs (s : String) : String := apply jsRules s

/-- Whether the file `path` is one this module translates, and how. -/
def kind (path : System.FilePath) : Option (String → String) :=
  match path.extension with
  | some "html" => some translateHtml
  | some "js" =>
    let name := path.fileName.getD ""
    if name.startsWith "search-" || name == "domain-mappers.js" then some translateJs else none
  | _ => none

/-- Rewrites in place every page and search script under `dir`; returns how many files changed. -/
partial def translateTree (dir : System.FilePath) : IO Nat := do
  let mut changed := 0
  for entry in (← dir.readDir) do
    let path := entry.path
    if (← path.isDir) then
      changed := changed + (← translateTree path)
    else
      match kind path with
      | none => pure ()
      | some f =>
        let before ← IO.FS.readFile path
        let after := f before
        if after != before then
          IO.FS.writeFile path after
          changed := changed + 1
  return changed

end SpecExt.Translate
