<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

k7pl est un langage de programmation implémenté en Lean 4 (projet Lake).

- `src/` : implémentation du langage (Lean 4, CECILL-2.1)
- `tests/` : tests (Lean 4, CECILL-2.1)
- `spec/` : spécifications (org-mode, CC-BY-4.0)

Les spécifications sont ajoutées **a posteriori** dans `spec/` : ne pas en
créer sans demande explicite.

## Règles de rédaction

Toutes les règles détaillées (structure, nommage, en-têtes SPDX, style Lean
et org-mode, Conventional Commits, checklist avant commit) sont dans
[`skills/writing-rules.md`](skills/writing-rules.md). Les lire avant toute
modification.

## Commandes utiles

```sh
lake build   # compiler
lake test    # lancer les tests (exécutable @[test_driver] mainTest)
reuse lint   # vérifier la conformité REUSE (pip install reuse)
```

## Points d'attention

- Chaque nouveau fichier porte un en-tête SPDX. Pour un fichier qui ne peut pas
  contenir de commentaire, ajouter une entrée `[[annotations]]` dans `REUSE.toml`.
- La version de Lean est fixée dans `lean-toolchain`.
- Mettre à jour `CHANGELOG.md` (section `[Unreleased]`) à chaque changement notable.
