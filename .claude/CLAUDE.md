<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

k7pl est un langage de programmation implémenté en Lean 4 (projet Lake),
avec Mathlib et CSLib. Sa spécification est écrite en Verso.

- `src/` : implémentation du langage (Lean 4, CECILL-2.1)
- `tests/` : tests (Lean 4, CECILL-2.1)
- `spec/` : spécification (Verso, CC-BY-4.0)
- `tools/` : générateur HTML de la spécification (CECILL-2.1)
- `scripts/` : maintenance (montée de version, hook de session)

**Langues** : code source en anglais (identifiants, docstrings, commentaires) ;
documentation, spécification et messages de commit en français.

Les spécifications sont ajoutées **a posteriori** dans `spec/` : ne pas en
créer sans demande explicite. Les sources historiques en Org-mode sont à
réécrire en Verso (table de correspondance dans les règles de rédaction).

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
