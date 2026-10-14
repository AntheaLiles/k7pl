<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Relecture humaine des visualisations de preuves

Ce document trace les actions humaines qui ne peuvent pas être remplacées par la CI. Une extraction et un rendu réussis prouvent que les artefacts ont été produits et compilés ; ils ne prouvent pas que la visualisation est fidèle, lisible ou pédagogiquement utile.

## État des validations automatisées

- Pipeline natif Verso HTML + TeX et compilation PDF pour l'ancien renderer : réussi dans le run [38457573950](https://github.com/AntheaLiles/k7pl/actions/runs/38457573950) pour les cinq cibles du corpus.
- Extraction dans le workspace Paperproof épinglé sur Lean 4.34.0 : les journaux de l'incrément précédent rapportent 2, 2, 5, 17 et 8 observations tactiques pour les cinq déclarations.
- Ces résultats CI ne valident pas le renderer responsive de la branche `feat/proofviz-paperproof-layout` ; les assertions source-level ajoutées ne sont pas des preuves du rendu HTML effectif.
- Contrôles Python, intégrité de la provenance, compilation Lean/Verso, validateurs de navigation et REUSE doivent être confirmés sur le run lié au commit de cette branche avant d'enregistrer une validation.

## Contrôles humains à effectuer

- [ ] Comparer le texte de chaque tactique, les objectifs avant/après et les objectifs supplémentaires à la source Lean exacte.
- [ ] Pour les preuves à branches, confirmer que les objectifs et les noms de cas ne sont pas présentés comme équivalents lorsque l'export n'établit pas cette relation.
- [ ] Vérifier que les hypothèses affichées sont celles rapportées par l'export et ne sont pas interprétées comme un suivi complet de la portée lexicale.
- [ ] Ouvrir le site généré, naviguer au clavier sans souris, vérifier les disclosures d'hypothèses et contrôler la lisibilité à largeur mobile.
- [ ] Comparer le panneau objectif-avant → nœud de tactique → objectifs-après à une capture Paperproof : valider l'ordre de lecture, le contraste, la longueur des tactiques et la distinction entre contexte, objectifs ordinaires et `spawnedGoals`.
- [ ] Vérifier que la flèche encode seulement la succession de la transition observée ; ne pas interpréter visuellement les objectifs supplémentaires comme des branches exactes lorsque le JSON n'en établit pas les liens.
- [ ] Contrôler la provenance repliable au clavier et vérifier que la révision et le lien source restent accessibles sans imposer la lecture du SHA-256 dans le flux principal.
- [ ] Confirmer que le contenu essentiel reste compréhensible sans JavaScript et que les liens source pointent vers le fichier et la révision attendus.
- [ ] Inspecter toutes les pages PDF contenant les cinq vues après validation du commit étendu. Vérifier pagination, lignes longues, expressions de buts, hypothèses et continuité des branches.
- [ ] Consigner les étapes ambiguës, absentes ou trompeuses et la décision prise ; ne pas convertir silencieusement une absence de données en un état de preuve vide.

## Limite spécifique à la refonte de mise en page

La branche de refonte place l'objectif avant, un nœud de tactique et les objectifs après dans un schéma de transition sur écran large, empile ces éléments sur un écran étroit, et différencie visuellement tactique, objectif et hypothèses, et replie les empreintes de provenance. Les `spawnedGoals` restent dans un panneau séparé ; le renderer ne prétend pas reconstruire le graphe complet de Paperproof. Il s'agit d'une amélioration de structure, non d'une validation de fidélité graphique ou sémantique. Cette présentation doit être examinée à partir du nouvel artefact de CI, pas d'une version mise en cache du site publié.

## Inspection initiale déjà effectuée

Sur l'artefact du run 38447082870 (trois vues), les pages PDF 297–298 ont été inspectées. Le contenu restait lisible, mais la ligne de métadonnées comprenant le SHA-256 et le toolchain était longue ; le renderer TeX a ensuite été ajusté pour séparer ces valeurs. Le paragraphe d'introduction indiquant Lean 4.29.0-rc8 a également été corrigé. Cette inspection antérieure ne valide pas les cinq vues produites par le run 38451997922 : elles doivent toutes être contrôlées sur les artefacts de ce run ou d'un run ultérieur.

## Critère de clôture

La relecture est complète seulement lorsque les cinq vues de la révision retenue ont été inspectées sur le web et dans le PDF, y compris la nouvelle mise en page responsive, les réserves consignées, et les cas trompeurs corrigés ou explicitement documentés. Une case cochée par lecture de la CI seule ne compte pas comme inspection humaine.
