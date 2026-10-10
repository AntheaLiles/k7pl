<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Résultats du POC TikZ — figures HTML/PDF

**Statut :** POC technique validé sur trois figures ; génération intégrée au build CI. Les PDF/SVG sont produits à la demande et ne sont pas suivis dans Git.
**Date :** 2026-10-10.
**Validation de génération :** workflow « TikZ figure POC », run 15 ; artefact tikz-poc-renderings.

## 1. Résultat technique

Les trois sources TikZ sont compilées en PDF par Tectonic 0.15.0, puis converties en SVG statique par Poppler. Pour chaque figure, deux constructions indépendantes sont comparées octet par octet, en PDF et en SVG. La CI a validé les six sorties, leurs signatures/structures, le manifeste et la présence des textes alternatifs et descriptions longues.

Le workflow épingle l'archive de Tectonic et vérifie son SHA-256. Le SVG est dérivé du PDF : les deux formats partagent donc la même source TikZ et la même apparence de référence, sans moteur JavaScript nécessaire à l'affichage HTML.

## 2. Revue visuelle et sémantique

| Figure | Comparaison au SVG canonique | Conclusion du POC |
|---|---|---|
| Pipeline de compilation | Les dix phases et leur ordre sont conservés. La disposition est changée en serpentin sur deux rangées, afin de réduire l'étirement horizontal ; les flèches gardent l'ordre de lecture explicite. | Candidat à la réimplémentation. Valider la nouvelle disposition lors de l'intégration éditoriale. |
| Automate de session | Le point initial, les deux états nommés, les transitions send(Int) et recv(Bool) et l'état final en double cercle sont conservés. | Candidat à la réimplémentation ; reconstruction sémantiquement fidèle aux éléments observés. |
| Matrice contraction/affaiblissement | La grille 2 × 2, les axes catégoriels, les couches Lin/Aff/Unr, les trois points existants et la case non instanciée sont conservés. La couleur n'est plus nécessaire pour distinguer les cases. | Candidat à la réimplémentation ; meilleure robustesse en niveaux de gris à confirmer à la taille de publication. |

Les références canoniques et les six rendus du POC sont réunis dans l'artefact de CI afin de permettre une comparaison directe. Les sources géométriques sont sous `spec/figures/tikz/`, source canonique des trois dessins. Les déclarations Verso conservent la légende, le texte alternatif et les descriptions de production. La CI génère les sorties, les valide et les transmet au rendu Verso via un artefact ; les sorties dérivées ne sont pas suivies dans Git.

## 3. Ce qui est validé — et ce qui ne l'est pas

**Validé :**
- compilation PDF et génération SVG statique à partir de la même source TikZ ;
- reproductibilité octet par octet entre deux constructions dans le même environnement CI ;
- structure XML des SVG et présence des PDF attendus ;
- lisibilité visuelle des trois rendus et conservation des éléments sémantiques listés ci-dessus ;
- textes alternatifs et descriptions longues définis dans le manifeste du POC.

**Non validé :**
- conformité PDF/UA avec le préambule personnalisé, qui n'est pas versionné dans le dépôt ;
- intégration de la génération TikZ dans le build canonique de Verso ;
- fidélité pixel à pixel au dessin d'origine — elle n'est pas recherchée pour le pipeline, dont la disposition est volontairement modifiée ;
- test utilisateur comparatif de la compréhension ou de la navigation ;
- génération de liens sémantiques navigables à partir des figures. Un SVG reste un artefact de présentation, pas un graphe de connaissances.

## 4. Décision proposée

Poursuivre vers une **réimplémentation sélective des trois figures**, en gardant les sources TikZ versionnées et les PDF/SVG générés comme artefacts dérivés contrôlés par CI. Ne pas généraliser cette décision à toutes les figures : les sources Mermaid, draw.io et les figures ayant d'autres besoins restent évaluées individuellement.

Avant de fusionner la réimplémentation dans la spécification, la suite doit :
1. maintenir le contrôle CI qui valide les sorties générées et les injecte avant le rendu Verso ;
2. transmettre le texte alternatif au rendu HTML/PDF existant sans dupliquer les métadonnées ;
3. tester le PDF final avec le mécanisme de balisage accessible et le préambule réel lorsqu'il sera disponible ;
4. conserver une référence de non-régression pour chaque figure.
