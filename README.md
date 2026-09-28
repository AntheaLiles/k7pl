<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

[![REUSE status](https://api.reuse.software/badge/github.com/AntheaLiles/k7pl)](https://api.reuse.software/info/github.com/AntheaLiles/k7pl)

k7pl est un langage de programmation dont l'implémentation est écrite en
[Lean 4](https://lean-lang.org/), avec [Mathlib](https://github.com/leanprover-community/mathlib4)
et [CSLib](https://github.com/leanprover/cslib). Sa spécification est écrite en
[Verso](https://github.com/leanprover/verso).

## Démarrage

La version de Lean est fixée dans `lean-toolchain` ; [elan](https://github.com/leanprover/elan)
l'installe automatiquement.

```sh
lake exe cache get                # télécharge les binaires Mathlib précompilés
lake build                        # compile l'implémentation (src/) et la spécification (spec/)
lake test                         # lance les tests (tests/)
lake exe spec --output _out/spec  # génère la spécification HTML
reuse lint                        # vérifie la conformité REUSE
```

## Spécifications

La spécification du langage est dans [`spec/`](spec/), écrite en Verso,
sous licence CC-BY-4.0. Les exemples de code qu'elle contient sont vérifiés à
chaque compilation. La CI publie la version HTML comme artefact `spec-html`.
Le contenu actuel est un exemple : les spécifications seront ajoutées par la suite.

## Contribuer

Les règles de contribution (structure du dépôt, nommage, en-têtes SPDX,
style, messages de commit) sont décrites dans
[`.claude/CLAUDE.md`](.claude/CLAUDE.md) et
[`.claude/skills/writing-rules.md`](.claude/skills/writing-rules.md).

## Licences

- Code : [CeCILL 2.1](LICENSES/CECILL-2.1.txt)
- Spécifications : [CC-BY-4.0](LICENSES/CC-BY-4.0.txt)
- Bibliothèques écrites dans le langage : CeCILL-C recommandée

Voir [`LICENSE`](LICENSE) pour le détail.
