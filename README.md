<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# k7pl

[![Lean Build](https://github.com/AntheaLiles/k7pl/actions/workflows/lean.yaml/badge.svg?branch=main)](https://github.com/AntheaLiles/k7pl/actions/workflows/lean.yaml)
[![REUSE status](https://api.reuse.software/badge/github.com/AntheaLiles/k7pl)](https://api.reuse.software/info/github.com/AntheaLiles/k7pl)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/AntheaLiles/k7pl/badge)](https://scorecard.dev/viewer/?uri=github.com/AntheaLiles/k7pl)

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
lake lint                         # linter Batteries
lake exe spec --output _out/spec  # génère la spécification HTML
reuse lint                        # vérifie la conformité REUSE
```

## Spécifications

La spécification du langage est dans [`spec/`](spec/), écrite en Verso,
sous licence CC-BY-4.0. Les exemples de code qu'elle contient sont vérifiés à
chaque compilation. Elle est publiée sur <https://anthealiles.github.io/k7pl/> à chaque
mise à jour de `main`.
Le contenu actuel est un exemple : les spécifications seront ajoutées par la suite.

## Contribuer

Voir [`CONTRIBUTING.md`](CONTRIBUTING.md) (déroulement), les
[règles de rédaction](.claude/skills/writing-rules.md) et le
[code de conduite](CODE_OF_CONDUCT.md). Les vulnérabilités se signalent en privé :
voir [`SECURITY.md`](SECURITY.md).

## Citer k7pl

Voir [`CITATION.cff`](CITATION.cff) (bouton « Cite this repository » sur GitHub).

## Licences

- Code : [CeCILL 2.1](LICENSES/CECILL-2.1.txt)
- Spécifications : [CC-BY-4.0](LICENSES/CC-BY-4.0.txt)
- Bibliothèques écrites dans le langage : CeCILL-C recommandée

Voir [`LICENSE`](LICENSE) pour le détail.
