<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# POC TikZ — rendu partagé HTML/PDF

**Statut :** trois figures de production sont désormais générées depuis les sources TikZ versionnées ; les autres figures ne sont pas migrées. La validation PDF/UA reste ouverte.
**But :** vérifier qu'une source TikZ commune peut produire des sorties PDF et SVG statiques, avec une compilation contrôlée et des métadonnées d'accessibilité explicites.

## Périmètre

Le POC couvre trois formes réellement présentes dans la spécification K7PL :

| Cas | Figure canonique à comparer | Propriété mise à l'épreuve |
|---|---|---|
| Pipeline | `fig:comp-process` dans `spec/Spec/C6/LeProcessusDeCompilation.lean` | densité et lisibilité d'un processus linéaire |
| Protocole | `fig:session-automate` dans `spec/Spec/C3/LesContraintesDeValeur.lean` | direction des transitions et étiquetage des états/messages |
| Matrice | `fig:modalites-structurelles` dans `spec/Spec/C3/LeSystemeGradue.lean` | alignement, cases négatives et lecture en niveaux de gris |

Les sources géométriques canoniques des trois figures sont dans `spec/figures/tikz/`. Les SVG historiques sont conservés dans `reference/` pour comparaison. Le manifeste de ce dossier décrit l'évaluation et l'accessibilité ; il ne remplace pas les déclarations Verso, qui restent la source des légendes et textes alternatifs.

## Reproduire

Depuis la racine du dépôt, avec Tectonic 0.15.0 et Poppler (pdftocairo) installés :

```sh
SOURCE_DATE_EPOCH=946684800 bash scripts/ci/build_tikz_poc.sh
python3 scripts/ci/check_tikz_poc.py --root out/tikz-poc

# Préparer les figures pour un rendu Verso local
SOURCE_DATE_EPOCH=946684800 bash scripts/ci/build_tikz_figures.sh
cp out/tikz-production/* spec/figures/
lake exe spec --output _out/spec --with-tex
```

Le script compile chaque figure deux fois avec le mode déterministe de Tectonic, produit un PDF et un SVG statique via `pdftocairo`, puis compare les empreintes des deux constructions. La CI installe Tectonic depuis l'archive épinglée et vérifiée par SHA-256 ; elle conserve les rendus et les trois SVG canoniques de référence comme artefact de PR pour une comparaison visuelle côte à côte.

## Contrat d'évaluation

Une décision de migration ne doit pas reposer uniquement sur le succès de compilation.

- **Fidélité sémantique :** mêmes nœuds, transitions, valeurs, cas absents et sens de lecture que la figure canonique.
- **Fidélité visuelle :** différences PDF/SVG, coupures, épaisseur, typographie et lisibilité aux tailles de publication.
- **Accessibilité :** texte alternatif court dans le manifeste HTML ; description longue et légende dans la spécification ; aucune distinction dépendant uniquement de la couleur. Le SVG produit par conversion PDF est une image de présentation, pas un graphe sémantique navigable.
- **Reproductibilité :** les deux constructions d'une même source donnent des octets identiques dans l'environnement de CI. Cela ne prouve pas à lui seul la reproductibilité entre versions de Tectonic, bundles TeX ou systèmes.
- **Maintenance :** dépendances TeX minimales, source lisible, pas de génération manuelle des SVG, pas de JavaScript requis à l'affichage.
- **Intégration :** seules les trois figures évaluées sont remplacées dans le rendu ; les autres figures et leurs sources restent inchangées.

## Limites connues

1. Le préambule PDF/UA personnalisé évoqué dans l'audit n'est pas versionné dans le dépôt. Ce POC ne prétend donc pas valider le balisage PDF/UA de ce préambule.
2. La conversion PDF vers SVG préserve l'apparence mais peut convertir les caractères en tracés et n'apporte pas à elle seule un nom accessible ; le nom accessible doit être fourni par le HTML qui référence le SVG.
3. La CI vérifie l'intégrité structurelle, la correspondance des mappings et la reproductibilité. La revue visuelle à taille de publication reste un contrôle éditorial humain ; elle n'est pas remplacée par les tests automatisés.
4. La génération est branchée avant le rendu `SpecExt.Float` dans la CI ; elle produit des artefacts statiques et ne crée pas de graphe de connaissances navigable.

## Résultats

Le compte rendu du POC et la décision proposée sont consignés dans [RESULTS.md](RESULTS.md). Les critères de clôture technique sont satisfaits sur les trois figures ; l’intégration à Verso et la validation PDF/UA restent des étapes distinctes.

## Résultat attendu

À l'issue de la revue des trois artefacts, consigner une décision par figure : conserver la source actuelle, réimplémenter en TikZ, ou choisir un autre format. Une migration globale n'est pas un résultat présupposé.