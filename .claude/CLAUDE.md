<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

k7pl est un langage de programmation implémenté en Lean 4 (projet Lake),
avec Mathlib et CSLib. Sa spécification est écrite en Verso.

- `src/` : implémentation du langage (Lean 4, CECILL-2.1)
- `tests/` : tests (Lean 4, CECILL-2.1)
- `spec/` : spécification (Verso, CC-BY-4.0) : le manuscrit « K7PL : KonSept Programming
  Language », un module par chapitre (`Spec/C1.lean`…) et par section de niveau 2
  (`Spec/C1/<Section>.lean`), figures dans `spec/figures/`
- `tools/` : générateur de la spécification (`SpecMain.lean`), extensions Verso (`SpecExt/`) et
  bibliographie générée (`SpecBib.lean`, depuis `biblio/references.json`) (CECILL-2.1)
- `docs/` : suivi, relectures, méthode, recherche, journal (CC-BY-4.0) ; **point d'entrée :
  `docs/suivi/TABLEAU-DE-BORD.md`**
- `archives/` : manuscrit Org-mode figé et ancien outillage (ne pas y corriger le texte)
- `scripts/` : maintenance (montée de version, hook de session), conversion Org → Verso
  (`org2verso/`), bibliographie (`biblio/`), mesures et suivi (`manuscript_metrics.py`,
  `suivi.py`)

**Langues** : code source en anglais (identifiants, docstrings, commentaires) ;
documentation, spécification et messages de commit en français.

Le manuscrit de la spécification est en Verso depuis la conversion du 1er octobre 2026 : sa
source de référence est `spec/`, plus `archives/manuscrit-org/`. **Le manuscrit porte « ne rien
modifier sans l'accord de l'auteur »** : ne corriger son texte que sur demande explicite, par une
modification minimale, et consigner le changement dans `docs/suivi/` (fiche, journal). Ne pas créer
de nouveau chapitre sans demande explicite.

## Règles de rédaction

Toutes les règles détaillées (structure, nommage, en-têtes SPDX, style Lean
et Verso, Conventional Commits, checklist avant commit) sont dans
[`skills/writing-rules.md`](skills/writing-rules.md). Les lire avant toute
modification.

## Commandes utiles

```sh
lake exe cache get              # binaires Mathlib précompilés (après clone ou mise à jour)
lake build                      # compiler l'implémentation et la spécification
lake test                       # lancer les tests (exécutable @[test_driver] mainTest)
lake lint                       # linter Batteries (docstrings manquantes, etc.)
lake exe spec --output _out/spec  # générer la spécification HTML
lake exe spec --output _out/spec --with-tex   # + sources LaTeX (PDF : lualatex _out/spec/tex/main.tex, 3 passes)
python3 scripts/manuscript_metrics.py summary # mesures du manuscrit (énoncés, formules, citations…)
python3 scripts/suivi.py all    # regénérer les vues du suivi (fiches, énoncés, tableau de bord)
reuse lint                      # vérifier la conformité REUSE (pip install reuse)
```

## Points d'attention

- Chaque nouveau fichier porte un en-tête SPDX. Pour un fichier qui ne peut pas
  contenir de commentaire, ajouter une entrée `[[annotations]]` dans `REUSE.toml`.
- La version de Lean est fixée dans `lean-toolchain` ; Mathlib, CSLib et Verso
  sont épinglés sur la même version dans `lakefile.lean`. Ils montent
  ensemble avec `scripts/bump-lean.sh`, puis commit de `lake-manifest.json`.
- Mettre à jour `CHANGELOG.md` (section `[Unreleased]`) à chaque changement notable.
- Les messages de commit sont vérifiés en CI (Conventional Commits).
- Tout avertissement fait échouer la compilation ; aucun `sorry`, `axiom` ni
  `native_decide` (audit des axiomes en CI). Ne jamais déclarer un patch terminé
  sans `lake build`, `lake test` et `lake lint` verts (localement ou en CI), ni
  utiliser un nom de lemme sans l'avoir vérifié. Détails : section « Travailler
  avec un agent » des règles de rédaction.
- Publication : releases indépendantes. `spec-vX.Y.Z` compile le PDF de la
  spécification et l'archive sur Zenodo (version dans `CITATION.cff`, changelog
  `spec/CHANGELOG.md`) ; `vX.Y.Z` publie l'implémentation (version dans
  `lakefile.lean`, changelog `CHANGELOG.md`). Voir « Publier une version » dans
  `CONTRIBUTING.md`. Les changements de la spécification vont dans `spec/CHANGELOG.md`.
- Monter Lean et les dépendances : `scripts/bump-lean.sh vX.Y.Z` (jamais à la main).
- Le hook `SessionStart` (`scripts/claude-session-start.sh`) installe elan et le
  cache Mathlib dans les sessions web, si le réseau autorise `release.lean-lang.org`.
