<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# POC TikZ — rendu partagé HTML/PDF

**Statut :** POC technique validé ; intégration sélective de la génération au rendu Verso en cours. Les sources TikZ restent des reconstructions révisables.
**But :** vérifier qu'une source TikZ commune peut produire des sorties PDF et SVG statiques, avec une compilation contrôlée et des métadonnées d'accessibilité explicites.

## Périmètre

Le POC couvre trois formes réellement présentes dans la spécification K7PL :

| Cas | Figure canonique à comparer | Propriété mise à l'épreuve |
|---|---|---|
| Pipeline | \`fig:comp-process\` dans \`spec/Spec/C6/LeProcessusDeCompilation.lean\` | densité et lisibilité d'un processus linéaire |
| Protocole | \`fig:session-automate\` dans \`spec/Spec/C3/LesContraintesDeValeur.lean\` | direction des transitions et étiquetage des états/messages |
| Matrice | \`fig:modalites-structurelles\` dans \`spec/Spec/C3/LeSystemeGradue.lean\` | alignement, cases négatives et lecture en niveaux de gris |

Les sources de ce dossier sont des **reconstructions de POC**, pas les sources canoniques des figures existantes. Leur fidélité scientifique doit être vérifiée contre le texte et les dessins d'origine avant toute adoption.

## Reproduire

Depuis la racine du dépôt, avec Tectonic 0.15.0 et Poppler (pdftocairo) installés :

\`\`\`sh
SOURCE_DATE_EPOCH=946684800 bash scripts/ci/build_tikz_poc.sh
python3 scripts/ci/check_tikz_poc.py --root out/tikz-poc
\`\`\`

Le script compile chaque figure deux fois avec le mode déterministe de Tectonic, produit un PDF et un SVG statique via \`pdftocairo\`, puis compare les empreintes des deux constructions. La CI installe Tectonic depuis l'archive épinglée et vérifiée par SHA-256 ; elle conserve les rendus et les trois SVG canoniques de référence comme artefact de PR pour une comparaison visuelle côte à côte.

## Intégration au rendu Verso

Le build de spécification compile les trois sources, valide les paires PDF/SVG, puis copie les rendus vers les noms d'assets canoniques déclarés par `production_asset` dans le manifeste. Les déclarations Verso et leurs textes alternatifs restent la source canonique des métadonnées éditoriales ; le manifeste ne sert qu'à associer les sorties générées aux fichiers d'assets attendus.

Pour reproduire ce rendu localement, avec Tectonic 0.15.0 et Poppler installés :

```sh
SOURCE_DATE_EPOCH="$(git log -1 --format=%ct)" bash scripts/ci/build_tikz_poc.sh
python3 scripts/ci/install_tikz_figures.py --source out/tikz-poc --target spec/figures
lake exe spec --output _out/spec --with-tex
```

La copie remplace les fichiers PDF/SVG correspondants dans le répertoire de travail. Pour éviter un rendu différent de la CI, lancer ces étapes avant toute compilation Verso destinée à la publication. Les sorties PDF/SVG restent des artefacts dérivés ; ne pas éditer manuellement ces fichiers.

## Contrat d'évaluation

Une décision de migration ne doit pas reposer uniquement sur le succès de compilation.

- **Fidélité sémantique :** mêmes nœuds, transitions, valeurs, cas absents et sens de lecture que la figure canonique.
- **Fidélité visuelle :** différences PDF/SVG, coupures, épaisseur, typographie et lisibilité aux tailles de publication.
- **Accessibilité :** texte alternatif court dans le manifeste HTML ; description longue et légende dans la spécification ; aucune distinction dépendant uniquement de la couleur. Le SVG produit par conversion PDF est une image de présentation, pas un graphe sémantique navigable.
- **Reproductibilité :** les deux constructions d'une même source donnent des octets identiques dans l'environnement de CI. Cela ne prouve pas à lui seul la reproductibilité entre versions de Tectonic, bundles TeX ou systèmes.
- **Maintenance :** dépendances TeX minimales, source lisible, pas de génération manuelle des SVG, pas de JavaScript requis à l'affichage.
- **Intégration :** aucun changement des déclarations Verso ni remplacement des figures existantes avant revue des artefacts.

## Limites connues

1. Le préambule PDF/UA personnalisé évoqué dans l'audit n'est pas versionné dans le dépôt. Ce POC ne prétend donc pas valider le balisage PDF/UA de ce préambule.
2. La conversion PDF vers SVG préserve l'apparence mais peut convertir les caractères en tracés et n'apporte pas à elle seule un nom accessible ; le nom accessible doit être fourni par le HTML qui référence le SVG.
3. La CI vérifie l'intégrité structurelle et la reproductibilité des artefacts. La revue visuelle et la validation sémantique restent une étape humaine documentée avant toute réimplémentation.
4. Le POC n'est pas encore branché sur \`SpecExt.Float\` et ne constitue pas une nouvelle source de vérité pour les figures publiées.

## Résultats

Le compte rendu du POC et la décision proposée sont consignés dans [RESULTS.md](RESULTS.md). Les critères de clôture technique sont satisfaits sur les trois figures ; l’intégration à Verso et la validation PDF/UA restent des étapes distinctes.

## Résultat attendu

À l'issue de la revue des trois artefacts, consigner une décision par figure : conserver la source actuelle, réimplémenter en TikZ, ou choisir un autre format. Une migration globale n'est pas un résultat présupposé.