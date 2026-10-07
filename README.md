<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

# K7PL - KonSept Programming Language

[![Lean Build](https://github.com/AntheaLiles/k7pl/actions/workflows/ci.yaml/badge.svg?branch=main)](https://github.com/AntheaLiles/k7pl/actions/workflows/ci.yaml)

k7pl est un langage de programmation dont l'implémentation est écrite en
[Lean 4](https://lean-lang.org/), avec [Mathlib](https://github.com/leanprover-community/mathlib4)
et [CSLib](https://github.com/leanprover/cslib). Sa spécification est écrite en
[Verso](https://github.com/leanprover/verso).

## Comprendre le projet

Le parcours documentaire courant commence par [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md), puis [`docs/RESEARCH.md`](docs/RESEARCH.md) et la spécification normative dans [`spec/`](spec/). L'état factuel est produit par CI dans [`docs/STATUS.md`](docs/STATUS.md), tandis que [`docs/ASSURANCE.md`](docs/ASSURANCE.md) expose l'argument d'assurance scientifique. Les matériaux historiques et de suivi sont organisés selon l'architecture documentaire décrite dans `docs/migration/README.md`.

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

La spécification du langage — le manuscrit « K7PL : KonSept Programming Language », sept
chapitres, les références du document et cinq annexes — est dans [`spec/`](spec/), écrite en
Verso, sous licence CC-BY-4.0. Elle est publiée sur <https://anthealiles.github.io/k7pl/> à
chaque mise à jour de `main`. Le flux qui joindra son PDF à chaque release `spec-vX.Y.Z` et l'archivera
sur Zenodo est décrit dans [`CONTRIBUTING.md`](CONTRIBUTING.md) ; il n'a pas encore été exécuté de bout en bout.

Le manuscrit est encore en cours de correction (campagne de relecture PR-02) : le point
d'entrée est le [tableau de bord](docs/tracking/TABLEAU-DE-BORD.md), qui dit où il en est et ce
qu'il reste à faire avant d'implémenter le langage. Le manuscrit Org-mode d'origine est figé
dans [`docs/archives/`](docs/archives/).

## Organisation

| Dossier | Contenu |
|---|---|
| [`src/`](src/), [`tests/`](tests/) | implémentation du langage en Lean 4 et ses tests |
| [`spec/`](spec/) | la spécification (Verso) et ses figures |
| [`tools/`](tools/) | générateur de la spécification et extensions Verso (`SpecExt/`) ; bibliographie (`SpecBib.lean`, produite depuis [`biblio/`](biblio/)) |
| [`docs/`](docs/) | documentation courante, assurance, recherche, méthode, suivi et archives historiques |
| [`scripts/`](scripts/) | maintenance, conversion Org → Verso, mesures et suivi |
| [`docs/archives/`](docs/archives/) | manuscrit Org et outillage d'avant la conversion |

## Contribuer

[![fair-software.eu](https://img.shields.io/badge/fair--software.eu-%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8F%20%20%E2%97%8B-yellow)](https://fair-software.eu)
[![DEI](https://img.shields.io/badge/DEI-DEI.md-6f42c1)](DEI.md)

Voir [`CONTRIBUTING.md`](CONTRIBUTING.md) (déroulement), les
[règles de rédaction](.claude/skills/writing-rules.md) et le
[code de conduite](CODE_OF_CONDUCT.md). Les vulnérabilités se signalent en privé :
voir [`SECURITY.md`](SECURITY.md).

## Citer k7pl

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23040451.svg)](https://doi.org/10.5281/zenodo.23040451)
[![SWH origin](https://archive.softwareheritage.org/badge/origin/https://doi.org/10.5281/zenodo.23040451/)](https://archive.softwareheritage.org/browse/origin/?origin_url=https://doi.org/10.5281/zenodo.23040451)

Les versions de la spécification doivent être archivées sur [Zenodo](https://zenodo.org)
avec un DOI, leur PDF étant joint à la release GitHub correspondante. Ce flux n'a pas encore été
exécuté de bout en bout : la release `spec-v0.0.0-alpha.1` n'a pas de PDF joint (voir
[`CONTRIBUTING.md`](CONTRIBUTING.md)). Voir
[`CITATION.cff`](CITATION.cff) (bouton « Cite this repository » sur GitHub). DOI : [10.5281/zenodo.23040451](https://doi.org/10.5281/zenodo.23040451).

[![SWH directory](https://archive.softwareheritage.org/badge/swh:1:dir:b81695cfdce2e418f8a8431b79e8894ee7310c50/)](https://archive.softwareheritage.org/swh:1:dir:b81695cfdce2e418f8a8431b79e8894ee7310c50;origin=https://doi.org/10.5281/zenodo.23040451;visit=swh:1:snp:e8d0a0046dc9e4509fc52655611c04a49414fa89;anchor=swh:1:rel:6c1db6481a70f65688c0cf1f8eb8cbfcf1e128b9)

## Sécurité

[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/AntheaLiles/k7pl/badge)](https://scorecard.dev/viewer/?uri=github.com/AntheaLiles/k7pl)

Les vulnérabilités ne doivent pas être signalées dans les issues publiques. Utilisez le
[signalement privé GitHub](https://github.com/AntheaLiles/k7pl/security/advisories/new) et indiquez
le commit concerné, les étapes de reproduction et l'impact supposé. Le périmètre couvre notamment
la cohérence de la spécification et de ses preuves, l'implémentation du langage et la chaîne de
construction. Voir [`SECURITY.md`](SECURITY.md) pour la politique complète, les délais de réponse
et les limites connues de la chaîne de construction.

## Licences

[![REUSE status](https://api.reuse.software/badge/github.com/AntheaLiles/k7pl)](https://api.reuse.software/info/github.com/AntheaLiles/k7pl)

- Code : [CeCILL 2.1](LICENSES/CECILL-2.1.txt)
- Spécifications : [CC-BY-4.0](LICENSES/CC-BY-4.0.txt)
- Bibliothèques écrites dans le langage : CeCILL-C recommandée

Voir [`LICENSE.md`](LICENSE.md) pour le détail.
