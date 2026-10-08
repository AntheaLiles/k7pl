<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

Licences
========

Ce dépôt suit les règles REUSE : chaque fichier est associé à une licence au moyen
d'un en-tête SPDX, d'un fichier adjacent `.license`, ou d'une annotation dans
`REUSE.toml`.

Les textes complets des licences se trouvent dans `LICENSES/`.

Répartition
-----------

- **Logiciel du projet → CeCILL-2.1** (SPDX : `CECILL-2.1`)

  L'implémentation du langage, ses tests, ses outils et scripts constituant du
  logiciel, notamment `src/`, `tests/`, `tools/` hors artefacts explicitement
  générés, `scripts/` hors données explicitement classées autrement, ainsi que
  `lakefile.lean`.

- **Bibliothèques et composants écrits dans K7PL → CeCILL-C** (SPDX : `CECILL-C`)

  Les composants destinés à être réutilisés comme bibliothèques, notamment
  `lib/`, utilisent le copyleft faible de la CeCILL-C.

- **Spécification, documentation et contenu scientifique → CC-BY-4.0**
  (SPDX : `CC-BY-4.0`)

  La spécification `spec/`, ses figures, la documentation `docs/`, les
  politiques et autres documents intellectuels du projet sont librement
  réutilisables sous réserve de l'attribution prévue par CC-BY-4.0.

- **Infrastructure, configuration, métadonnées et artefacts techniques → CC0-1.0**
  (SPDX : `CC0-1.0`)

  Sont notamment concernés l'infrastructure `.github/` et `.claude/`, les
  fichiers de configuration racine, les métadonnées Zenodo/Citation, les
  manifests générés et certains artefacts générés. L'objectif est de permettre
  leur réutilisation sans imposer le copyleft du logiciel ni une obligation
  d'attribution lorsque les droits du projet le permettent.

Cette classification suit la **nature fonctionnelle de l'œuvre**, et non son
extension de fichier : un script reste du logiciel, un document reste du contenu
documentaire et une configuration technique reste de l'infrastructure.

Données et œuvres de tiers
--------------------------

Une licence ne peut être accordée que pour les droits effectivement détenus par
le projet. Les données bibliographiques ou extraits provenant de tiers restent
soumis aux droits et licences applicables à leurs sources ; leur classement sous
CC0 est donc subordonné à cette vérification.

Fichiers générés
----------------

Un fichier généré est distingué de son générateur : le générateur peut être du
logiciel sous CeCILL-2.1 alors que la sortie peut être sous CC0 lorsque le projet
détient les droits nécessaires et que la sortie ne contient pas d'œuvre tierce
protégée.

Les PDF de `spec/figures/` sont actuellement conservés car ils sont consommés
par la chaîne PDF. Ils sont des dérivés des sources de figures et leur suppression
sera traitée séparément lorsque la génération PDF sera démontrée suffisamment
reproductible.

Liens
-----

- Textes complets des licences : `LICENSES/`
- Famille de licences CeCILL : <https://cecill.info/>
- Creative Commons BY 4.0 : <https://creativecommons.org/licenses/by/4.0/>
- Creative Commons Zero 1.0 : <https://creativecommons.org/publicdomain/zero/1.0/>
- Spécification REUSE : <https://reuse.software/>
