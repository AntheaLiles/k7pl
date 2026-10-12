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

## 2. Comparaison sémantique et différences de disposition

| Figure | Comparaison au SVG canonique | Conclusion du POC |
|---|---|---|
| Pipeline de compilation | Les dix phases et leur ordre sont conservés. La disposition est changée en serpentin sur deux rangées, afin de réduire l'étirement horizontal ; les flèches gardent l'ordre de lecture explicite. | Réimplémenté dans le rendu CI ; valider la disposition à la taille de publication. |
| Automate de session | Le point initial, les deux états nommés, les transitions send(Int) et recv(Bool) et l'état final en double cercle sont conservés. | Réimplémenté dans le rendu CI ; les états et transitions canoniques sont conservés. |
| Matrice contraction/affaiblissement | La grille 2 × 2, les axes catégoriels, les couches Lin/Aff/Unr, les trois points existants et la case non instanciée sont conservés. La couleur n'est plus nécessaire pour distinguer les cases. | Réimplémenté dans le rendu CI ; confirmer la lisibilité en niveaux de gris à la taille de publication. |

Les références canoniques et les six rendus du POC sont réunis dans l'artefact de CI afin de permettre une comparaison directe. Les sources géométriques sont sous `spec/figures/tikz/`, source canonique des trois dessins. Les déclarations Verso conservent la légende, le texte alternatif et les descriptions de production. La CI génère les sorties, les valide et les transmet au rendu Verso via un artefact ; les sorties dérivées ne sont pas suivies dans Git.


La comparaison visuelle de l'artefact initial a néanmoins révélé deux écarts évitables : les libellés du pipeline avaient perdu le préfixe « Phase » et les deux-points des SVG historiques, et le marqueur central violet de l'état final de l'automate était devenu blanc. Les sources TikZ corrigent ces écarts. L'artefact régénéré a été inspecté en aperçu agrandi : les libellés complets du pipeline et le marqueur violet sont confirmés. La vérification à la taille exacte d'insertion dans le document reste ouverte.

## 3. Ce qui est validé — et ce qui ne l'est pas

**Validé :**
- compilation PDF et génération SVG statique à partir de la même source TikZ ;
- reproductibilité octet par octet entre deux constructions dans le même environnement CI ;
- structure XML des SVG et présence des PDF attendus ;
- conservation des éléments sémantiques décrits ci-dessus, vérifiée par comparaison visuelle agrandie des artefacts ;
- textes alternatifs et descriptions de production présents dans les déclarations Verso.

**Inspection à la taille d'insertion (artefact CI courant)** : le `spec-pdf` du run [#38091879446](https://github.com/AntheaLiles/k7pl/actions/runs/38091879446) a été inspecté à 120 dpi. Le pipeline est en page imprimée 242, l'automate en page 106 et la matrice en page 98. La matrice reste lisible en niveaux de gris et est réunie avec sa légende/description sur une seule page ; les labels du pipeline et l'automate restent discernables. Cette inspection d'artefact confirme le fix de pagination, sans constituer une revue humaine indépendante.

Le run POC courant [#38091879272](https://github.com/AntheaLiles/k7pl/actions/runs/38091879272) a réussi : les trois sources TikZ produisent de nouveau leurs paires PDF/SVG dans le test de reproductibilité. Le PDF et le HTML inspectés proviennent du run CI courant #38091879446, tête `5d527c5ee6b74c993903607addb5852f4e914b1c`; le rendu courant n'est donc plus à confirmer pour les contrôles exécutés par cette CI.
**Accessibilité HTML/SVG ajoutée dans la PR #149 :** la relation entre chaque image et sa description longue est explicite (`aria-describedby`), y compris dans le catalogue de provenance. Les copies SVG du site reçoivent `role="img"`, `aria-labelledby`, `aria-describedby`, un élément `<title>` depuis le texte alternatif rendu et un élément `<desc>` depuis la description longue rendue. Les fichiers SVG canoniques ne sont pas réécrits. Le renderer TeX choisit maintenant le chemin `qvalt/qvaltfin` si ces macros existent, l'option native `includegraphics[alt={...}]` si `tagpdfsetup` est défini, puis un fallback non balisé compatible CI. Cette dernière branche native est dérivée de la configuration LaTeX archivée du projet, dont la chaîne Org/LuaLaTeX est documentée dans l'audit.

L'échec initial était une `SyntaxError` dans `check_spec_html_assets.py` (guillemets du diagnostic `role="img"` échappés deux fois), corrigée ; une deuxième exécution a ensuite révélé le vrai défaut Lean à `Float.lean:160:33` (`Unknown identifier figures`). Cette erreur est corrigée en construisant le chemin TeX par concaténation littérale. La tête actuelle passe `Build the specification`, le rendu HTML/TeX, l'enrichissement SVG, la validation HTML et la compilation PDF. Le job plus général `Vérification / Implémentation Lean` était encore en cours, sans erreur rapportée, au dernier contrôle.

**Preambule retrouvé :** la copie versionnée de `preamble-article.tex` est sous `docs/archives/outillage-org/preamble-article.tex`, et la configuration d'export sous `docs/archives/outillage-org/my-export-config.el`. Cela permet de rétablir la base exacte archivée, mais ne prouve pas que le fichier du poste local est byte-identique à cette copie. Le PDF de CI de la spécification reste non balisé (`Tagged: no`) ; aucune conformité PDF/UA n'est revendiquée sur cette sortie.

**Non validé :**
- conformité PDF/UA avec le préambule personnalisé réel, qui n'est pas versionné dans le dépôt ; l'artefact `spec-pdf` CI contrôlé via `pdfinfo` indique `Tagged: no` ;
- fidélité pixel à pixel au dessin d'origine — elle n'est pas recherchée pour le pipeline, dont la disposition est volontairement modifiée ;
- revue éditoriale humaine indépendante à taille de publication, notamment la petite typographie du pipeline ;
- test utilisateur comparatif de la compréhension ou de la navigation ;
- génération de liens sémantiques navigables à partir des figures. Un SVG reste un artefact de présentation, pas un graphe de connaissances.

## 4. Décision et travaux restants

La réimplémentation sélective des trois figures est intégrée à la chaîne CI : les sources TikZ sont versionnées, les PDF/SVG sont générés et validés, puis transmis au rendu Verso comme artefacts. Cette décision ne s'étend pas aux autres figures ; les sources Mermaid, draw.io et les figures ayant d'autres besoins restent évaluées individuellement.

Les contrôles restants sont :
1. comparer localement les empreintes du préambule et de la configuration d'export installés au contenu archivé retrouvé, puis reconstruire le document réellement publié avec cette chaîne ;
2. contrôler le PDF issu de cette chaîne au moyen de veraPDF sur le profil PDF/UA déclaré et par une revue au lecteur d'écran ;
3. faire réaliser une revue éditoriale humaine indépendante à taille d'insertion et en niveaux de gris ;
4. conserver les SVG historiques comme références de non-régression ;
5. poursuivre séparément la navigation sémantique : un SVG statique n'est pas un graphe de connaissances.

La décision de réimplémentation demeure limitée aux trois figures : pipeline en serpentin conservé sous réserve de validation éditoriale finale de sa petite typographie ; automate conservé avec son marqueur central rétabli ; matrice monochrome conservée pour ne pas dépendre de la couleur. Aucune quatrième figure ne justifie encore une migration à partir des seules preuves de ce POC.
