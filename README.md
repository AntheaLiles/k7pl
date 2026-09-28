<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

[![REUSE status](https://api.reuse.software/badge/github.com/AntheaLiles/k7pl)](https://api.reuse.software/info/github.com/AntheaLiles/k7pl)

k7pl est un langage de programmation dont l'implémentation est écrite en
[Lean 4](https://lean-lang.org/).

## Démarrage

La version de Lean est fixée dans `lean-toolchain` ; [elan](https://github.com/leanprover/elan)
l'installe automatiquement.

```sh
lake build   # compile l'implémentation (src/)
lake test    # lance les tests (tests/)
reuse lint   # vérifie la conformité REUSE
```

## Spécifications

Les spécifications du langage seront publiées dans [`spec/`](spec/)
(à venir), au format org-mode, sous licence CC-BY-4.0.

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
