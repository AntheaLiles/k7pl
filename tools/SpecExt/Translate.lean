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
  (">Source Code<", r#"><svg aria-hidden="true" focusable="false" viewBox="0 0 16 16" width="20" height="20" class="k7pl-nav-icon k7pl-github-icon"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.08-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82a7.65 7.65 0 0 1 4 0c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8Z"/></svg><span class="k7pl-visually-hidden">Code source</span><"#),
  (">Report Issues<", r#"><svg aria-hidden="true" focusable="false" viewBox="0 0 24 24" width="20" height="20" class="k7pl-nav-icon k7pl-bug-icon"><path d="M12 8V5a2 2 0 1 0-4 0v3"/><rect x="6" y="8" width="12" height="12" rx="6"/><path d="M4 13H2m20 0h-2M4 17H2m20 0h-2M7 5 5 3m12 2 2-2M9 13h6m-6 3h6"/></svg><span class="k7pl-visually-hidden">Signaler un problème</span><"#),
  ("title=\"Permalink\"", "title=\"Lien permanent\""),
  ("<title>Cross-Reference Redirection</title>", "<title>Redirection des références croisées</title>"),
  ("Cross-Reference Redirection", "Redirection des références croisées"),
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

/-- CSS for the icon-only links in the Verso navigation. -/
private def iconStyles : String := r#"<style id="k7pl-icon-styles">
.k7pl-source-icon-link, .k7pl-issue-icon-link {
  display: inline-flex; align-items: center; justify-content: center;
  box-sizing: border-box; width: 2.4rem; height: 2.4rem; padding: .35rem;
  border: 1px solid currentColor; border-radius: .45rem; text-decoration: none;
}
.k7pl-source-icon-link:hover, .k7pl-issue-icon-link:hover { opacity: .78; text-decoration: none; }
.k7pl-nav-icon { display: block; width: 1.15rem; height: 1.15rem; }
.k7pl-github-icon { fill: currentColor; }
.k7pl-bug-icon { fill: none; stroke: currentColor; stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round; }
.k7pl-visually-hidden {
  position: absolute !important; width: 1px; height: 1px; padding: 0; margin: -1px;
  overflow: hidden; clip: rect(0, 0, 0, 0); white-space: nowrap; border: 0;
}
</style>"#

/-- Adds a class and accessible tooltip to the first occurrence of a known navigation link. -/
private def decorateFirstHref (s href className title : String) : String :=
  let token := "href=\"" ++ href ++ "\""
  let marker := "class=\"" ++ className ++ "\""
  if s.contains marker then s else
    match s.splitOn token with
    | first :: second :: rest =>
      first ++ token ++ " class=\"" ++ className ++ "\" title=\"" ++ title ++
        "\" aria-label=\"" ++ title ++ "\"" ++ String.intercalate token (second :: rest)
    | _ => s

/-- Translates the interface of an HTML page and styles its accessible icon links. -/
def translateHtml (s : String) : String :=
  let translated := declareLanguage (apply htmlRules s)
  let translated := decorateFirstHref translated "https://github.com/AntheaLiles/k7pl"
    "k7pl-source-icon-link" "Code source"
  let translated := decorateFirstHref translated "https://github.com/AntheaLiles/k7pl/issues"
    "k7pl-issue-icon-link" "Signaler un problème"
  if translated.contains "id=\"k7pl-icon-styles\"" then translated
  else translated.replace "</head>" (iconStyles ++ "</head>")

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
