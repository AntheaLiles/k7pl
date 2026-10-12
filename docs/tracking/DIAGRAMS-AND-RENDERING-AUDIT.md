<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit préliminaire des figures et de leur rendu HTML/PDF

**Statut :** audit actualisé après la PR #149, à partir du code, des runs CI #38091879446 / #38091879272 et des artefacts HTML/PDF de la tête `5d527c5ee6b74c993903607addb5852f4e914b1c`. Le rendu statique, les tests HTML/SVG et la pagination sont vérifiés ; PDF/UA sur la chaîne Org/LuaLaTeX personnelle et la revue humaine indépendante restent ouverts.  
**Périmètre :** figures de la spécification Verso, besoins de représentation de l'enveloppe interactive, stratégie de sources et de rendu.  
**Date :** 2026-10-10.

## 1. Décision de cadrage

Le problème doit être traité en trois couches indépendantes :

1. **Valeur explicative :** quelle question la figure aide-t-elle à résoudre, quelle relation ou quel résultat le lecteur doit-il comprendre ?
2. **Contrat sémantique :** quelle source versionnée décrit la figure, son sens, sa provenance et ses relations aux objets de K7PL ?
3. **Rendu :** quels artefacts déterministes produisent une présentation HTML et une sortie PDF accessibles ?

Le choix de TikZJax relève d'abord de la troisième couche. Un fichier TikZ contient des instructions de dessin, pas à lui seul un graphe de connaissances interrogeable. Un SVG rendu côté navigateur n'apporte pas automatiquement de navigation sémantique.

## 2. Constat de code établi

Le point d'entrée actuel des figures est tools/SpecExt/Float.lean. Le commentaire de module décrit le contrat suivant : figures/name.svg pour HTML et figures/name.pdf pour PDF, avec des slots caption, desc, note et source.

Le rendu HTML construisait un élément img avec un préfixe relatif calculé en répétant ../ selon la profondeur de traversal. Or Verso ajoute aux pages multi-pages un élément <base href> qui pointe déjà vers la racine du site. Le navigateur résout les URL relatives à partir de cette base, et non du répertoire de la page : le préfixe était donc appliqué deux fois. Le défaut est **reproduit** sur l'artefact CI : les 12 figures K7PL pointent hors du site alors que les fichiers existent. Une URL `figures/nom.svg`, résolue par la base de Verso, corrige les 12 références. La correction et son contrôle de non-régression ont été fusionnés via la [PR #124](https://github.com/AntheaLiles/k7pl/pull/124) (commit `d42d33a`). La CI complète est verte et le job de déploiement GitHub Pages a réussi. L'artefact exact de publication a été revalidé (64 pages, 12 figures K7PL, aucune référence cassée). L'outil de navigation n'a pas permis une vérification HTTP directe de la page en ligne ; le contrôle déterministe du contenu publié et le statut du déploiement sont toutefois positifs.

Avant la PR #149, le rendu TeX de `Float.lean` utilisait `includegraphics` avec `width` et `keepaspectratio` sans transmettre le texte alternatif de `FloatInfo`. Le renderer émet maintenant conditionnellement les macros de projet `qvalt/qvaltfin`, sinon `includegraphics[alt={...}]` lorsque `tagpdfsetup` est disponible, avec un fallback non balisé pour le build standard. La compilation Lean et le rendu complet Verso/PDF du commit `5d527c5ee6b74c993903607addb5852f4e914b1c` ont réussi. Cela prouve la génération du code TeX et son build, pas à lui seul le balisage structurel PDF/UA.

Le plan interactif est suivi dans [INTERACTIVE-EXPLORATION-PLAN.md](INTERACTIVE-EXPLORATION-PLAN.md). La correction des figures est close par la PR #124 et ses contrôles de non-régression ; les limites de localisation HTML sont décrites dans [L1-DECISIONS.md](../migration/L1-DECISIONS.md) et les preuves de rendu dans [L5-VALIDATION.md](../migration/L5-VALIDATION.md). L'ancien registre ANOMALIES.md est retiré ; tout nouveau défaut doit être consigné dans le registre actif qui porte son domaine.

Le changelog conserve un compte historique de treize figures. L'artefact HTML CI courant contient douze figures K7PL déclarées et copie également `services-lsp.svg`, qui n'est référencé par aucune déclaration Verso courante. Le SVG existe bien sous `spec/figures/` ; le PDF homonyme est également présent comme asset binaire, mais ni `spec/figures/sources/services-lsp.drawio` ni `spec/figures/services-lsp.mmd` ne sont présents dans l'arbre courant. Une source Mermaid historique est retrouvable dans `docs/archives/manuscrit-org/K7_LSP_REPL.org`. La décision technique retenue pour cette PR est de **conserver les reliquats sans les supprimer ni les archiver** : leur utilité éditoriale et leur destination relèvent d'une décision de maintenance distincte. Le treizième fichier copié n'est pas une treizième déclaration Verso.

### Inventaire des figures déclarées dans Verso

Les douze déclarations de figures présentes dans la spécification sont inventoriées ci-dessous. Les trois figures réimplémentées utilisent des sources TikZ ; les neuf autres conservent leurs sources draw.io. Les assets `services-lsp.svg` et `services-lsp.pdf` restent des reliquats non référencés ; leur source Mermaid historique se trouve dans l'archive Org, pas dans `spec/figures/sources/`. Ce n'est pas une treizième déclaration Verso manquante.

| Module Verso | Identifiant | Asset publié | Source géométrique | Fonction explicative |
|---|---|---|---|---|
| `spec/Spec/C1/AxiomatiqueGerminale.lean` | `fig:specialisation-couches` | `specialisation-du-jugement` | `spec/figures/sources/specialisation-du-jugement.drawio` | Relier le jugement germinal aux trois couches du langage |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | `fig:dualite-algebre-coalgebre` | `co-algebra-duality` | `spec/figures/sources/co-algebra-duality.drawio` | Expliquer la dualité entre algèbre initiale et coalgèbre terminale |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | `fig:fragments-emboites` | `fragments-nestings` | `spec/figures/sources/fragments-nestings.drawio` | Comparer les règles structurelles autorisées dans les fragments |
| `spec/Spec/C3/LeSystemeGradue.lean` | `fig:modalites-structurelles` | `matrice-contraction-affaiblissement` | `spec/figures/tikz/structural-modes.tex` | Montrer les combinaisons de contraction/affaiblissement retenues |
| `spec/Spec/C3/LesContraintesDeValeur.lean` | `fig:session-automate` | `session-protocol-as-automata` | `spec/figures/tikz/session-protocol.tex` | Expliquer la progression d'un automate de protocole de session |
| `spec/Spec/C3/LesContraintesDeValeur.lean` | `fig:session-dualite` | `session-protocol-as-dual-exchange` | `spec/figures/sources/session-protocol-as-dual-exchange.drawio` | Comparer les deux extrémités d'un protocole dual |
| `spec/Spec/C4/EchelleLocale.lean` | `fig:rexp-complexite` | `rexp-hierarchy-complexity` | `spec/figures/sources/rexp-hierarchy-complexity.drawio` | Comparer les classes de complexité des R-expressions |
| `spec/Spec/C4/EchelleDeLActeur.lean` | `fig:arene-partition` | `soa-partitionning` | `spec/figures/sources/soa-partitionning.drawio` | Rendre visible la partition statique de mémoire entre fibrilles |
| `spec/Spec/C4/EchelleDuSysteme.lean` | `fig:acteur-cycle-de-vie` | `virtual-actor-lca` | `spec/figures/sources/virtual-actor-lca.drawio` | Expliquer le cycle de vie d'un acteur virtuel |
| `spec/Spec/C4/EchelleDuSysteme.lean` | `fig:circuit-breaker` | `session-circuit-breaker` | `spec/figures/sources/session-circuit-breaker.drawio` | Expliquer le rejet ou l'acceptation d'un message selon le tag d'état |
| `spec/Spec/C6/LeProcessusDeCompilation.lean` | `fig:comp-process` | `compilation-process` | `spec/figures/tikz/compilation-pipeline.tex` | Exposer les phases de la chaîne de compilation |
| `spec/Spec/C7/EtudeDeCasIArchitectureReactiveNative.lean` | `fig:cycle-reactif` | `unidirectionnal-reactive-cycle` | `spec/figures/sources/unidirectionnal-reactive-cycle.drawio` | Relier les étapes du cycle réactif aux trois couches |

La CI vérifie les sorties des trois sources TikZ, leur reproductibilité et leur correspondance avec les déclarations Verso. Les neuf figures draw.io sont inventoriées, mais leur fidélité visuelle et leur accessibilité restent à évaluer séparément. La revue des rendus TikZ à taille de publication reste humaine : la CI ne prouve ni leur lisibilité ni leur valeur explicative.


## 3. Cause racine et portée de la correction

- **Cause HTML confirmée :** double application du préfixe de profondeur, due à la combinaison de l'URL produite par `Float.lean` et du `<base href>` injecté par Verso.
- **Correction fusionnée en PR #124 :** émettre `figures/<nom>.svg` sans préfixe manuel ; le `<base href>` résout alors l'URL à la racine du site. La compilation de la spécification, le contrôle d'assets, la compilation PDF et le déploiement GitHub Pages passent.
- **Contrôle ajouté :** le validateur de CI doit tenir compte de `<base href>`, vérifier chaque référence locale, contrôler la copie et le XML des SVG, et rejeter les figures sans texte alternatif. Un validateur qui résout uniquement les chemins depuis le répertoire de la page ne détecte pas ce défaut.
- **Déploiement :** le test sur l'artefact local ne suffit pas à prouver la publication. La validation CI et le déploiement après fusion doivent être vérifiés avant de clore l'anomalie.
- **PDF :** le renderer émet maintenant le texte alternatif vers les trois voies conditionnelles (`qvalt/qvaltfin`, `includegraphics[alt={...}]` si Tagged PDF est présent, sinon fallback ordinaire). Le PDF courant de CI du run `38091879446` a été inspecté ; `pdfinfo` indique toujours `Tagged: no`, car la CI construit la spécification via Tectonic sans la configuration Org/LuaLaTeX personnelle. La matrice, sa légende et sa description sont bien sur la même page. Aucune conformité PDF/UA n'est revendiquée pour le PDF CI ni pour le document personnel non produit ici.

## 4. Stratégie de source et de rendu recommandée

### 4.1 Source canonique par figure

Ne pas réécrire toutes les figures dans un langage unique par principe esthétique. Garder les sources existantes (draw.io, Mermaid ou autre) lorsqu'elles sont maintenables et expriment correctement le contenu. Chaque figure doit avoir une source canonique identifiée, versionnée et reliée à ses sorties dérivées. La migration vers TikZ doit être décidée figure par figure selon le besoin de précision, de notation mathématique, de reproductibilité ou de maintenance.

Pour les nouvelles figures scientifiques ou formelles, TikZ/PGFPlots est un bon candidat si la compatibilité des paquets et macros réellement utilisés est démontrée. Les graphes de dépendances et de traçabilité peuvent être mieux décrits par des données de nœuds/arêtes et rendus avec un moteur de graphe, plutôt que codés uniquement comme coordonnées graphiques.

### 4.2 Rendu statique comme chemin de publication

La voie par défaut recommandée est une génération au moment du build : PDF via la chaîne TeX déjà utilisée par le projet ; SVG statique pour HTML, produit à partir de la même source TikZ si le test de compatibilité est concluant ; manifeste vérifiant source, métadonnées, sorties et empreintes.

Cela permet un HTML lisible sans JavaScript, une génération reproductible en CI, un fonctionnement plus robuste sous GitHub Pages et un PDF indépendant du navigateur. Il faut néanmoins comparer visuellement SVG et PDF : partager le code source ne garantit pas une identité parfaite des moteurs, polices, espacements ou coupures.

### 4.3 Place de TikZJax et d'isomorphic-tikzjax

TikZJax compile du TikZ dans le navigateur en SVG au moyen de WebAssembly ; isomorphic-tikzjax vise un rendu SVG en environnement Node et navigateur. Ces options méritent un prototype de compatibilité, mais pas le rôle de dépendance unique de publication. Elles ne produisent pas à elles seules le PDF, et la compatibilité avec le préambule personnalisé, les polices, PGFPlots, les bibliothèques TikZ et les macros maison doit être testée avec des exemples représentatifs. Un rendu navigateur ajoute aussi des dépendances d'exécution (JavaScript, WASM, workers, chemins d'assets et politiques CSP).

Décision provisoire : **évaluer TikZJax comme moteur de prototype et éventuellement de prévisualisation interactive ; privilégier le rendu statique au build pour la publication**, sauf preuve mesurée qu'un autre choix satisfait mieux les exigences de fidélité, accessibilité, reproductibilité et maintenance.

## 5. Contrat minimal d'une figure utile

Chaque figure devrait fournir les métadonnées suivantes, intégrées au bloc Verso ou conservées dans un manifeste versionné :

- identifiant stable ;
- proposition explicative ou question à laquelle la figure répond ;
- type (architecture, processus, états/protocole, transformation, données/mesure, orientation, graphe de traçabilité) ;
- source canonique et sorties dérivées ;
- légende ;
- texte alternatif court ;
- description longue lorsque les relations ne peuvent pas être restituées par le texte alternatif seul ;
- note de lecture pour la notation non évidente ;
- provenance et objets K7PL liés ;
- statut épistémique si la figure représente une hypothèse, une proposition, un résultat ou un historique ;
- critères de validation ou de mise à jour.

Une figure décorative n'a pas besoin d'être fabriquée pour remplir un quota. Si sa proposition ne peut pas être formulée, il faut d'abord revoir sa valeur explicative.

## 6. Accessibilité

Le texte alternatif doit donner la fonction ou le résultat essentiel de la figure en une phrase concise. La description longue restitue l'organisation et les relations importantes ; la note explique les conventions. Les figures ne doivent pas encoder une distinction par la couleur seule. Vérifier contraste, taille de texte, épaisseur de trait, lisibilité à l'impression et comportement en niveaux de gris.

Pour le PDF, l'intégration doit transmettre les métadonnées au backend TeX et produire une figure balisée, puis être validée sur le PDF réellement généré. Le préambule fourni par le projet est un mécanisme potentiel, pas une preuve d'accessibilité à lui seul. Pour HTML, tester la présence des attributs accessibles et la résolution de l'image ; pour un SVG intégré, vérifier également le nom accessible et l'ordre de lecture.

Une future vue graphe devra offrir une alternative navigable au clavier et une liste ou table accessible, ainsi que des liens vers les sources. Le graphe ne doit jamais être l'unique moyen d'obtenir les relations.

## 7. Plan de travaux préliminaires

### P0-A — Reproduire le défaut HTML

1. Construire le site avec la commande canonique du dépôt.
2. Inspecter le HTML généré pour chaque figure : valeur de src, chemin de page, alt, présence du fichier cible.
3. Vérifier la résolution des URL depuis la sortie locale et depuis le chemin de publication GitHub Pages.
4. Examiner les requêtes réseau et distinguer 404, mauvais type MIME, SVG invalide et erreur de rendu.
5. Corriger le chemin ou la copie des fichiers selon la cause démontrée ; ne pas masquer le problème en supprimant l'alt.
6. Ajouter un test automatisé qui parcourt toutes les pages générées et confirme que chaque image locale référencée existe et que chaque figure attendue est présente.

### P0-B — Inventorier la collection

Pour chaque figure, consigner identifiant/nom, emplacement dans le texte, question explicative, source modifiable, sorties HTML/PDF, provenance, objets liés, qualité du texte alternatif, description longue, statut de maintenance et test associé. Ne pas convertir en bloc les figures existantes.

### P0-C — Prototype de moteurs

Choisir trois cas contrastés : une figure d'architecture/processus, un automate/protocole avec relations d'état, et une figure mathématique ou quantitative si le corpus en contient une pertinente. Comparer la source existante et TikZ sur fidélité, lisibilité, accessibilité, taille du dépôt, temps de build, compatibilité des macros et maintenance. Inclure les macros et polices réelles du préambule, pas seulement un exemple minimal.

### P0-D — Contrat et tests de build

Définir un manifeste minimal et valider en CI : source présente, sortie attendue présente, métadonnées requises, références valides, images HTML résolues, PDF produit, absence de sorties périmées. Ajouter la validation PDF balisée lorsque la chaîne le permet. La génération du graphe de connaissances sera un chantier distinct, alimenté par des relations sémantiques explicites, pas par l'analyse des pixels SVG.

## 8. Ordre de priorité

1. Reproduire et corriger les images HTML cassées.
2. Ajouter les tests de chemins et d'assets.
3. Terminer l'inventaire et l'évaluation de valeur des figures existantes.
4. Définir le contrat minimal et les contrôles de génération.
5. Prototyper TikZ/PGFPlots et TikZJax/isomorphic-tikzjax sur trois cas réels.
6. Améliorer le balisage PDF et vérifier l'accessibilité effective.
7. Seulement après ces étapes, décider d'une migration sélective et de l'éventuelle prévisualisation interactive.

## 9. Critère de sortie de l'audit préliminaire

L'audit préliminaire ne sera considéré comme terminé que lorsque :
- la cause du défaut HTML est reproduite et documentée ;
- toutes les figures et leurs sources sont inventoriées ;
- les décisions de rendu sont appuyées par des essais reproductibles ;
- le contrat de métadonnées et les tests sont acceptés ;
- les travaux restants sont reportés dans le suivi avec des statuts honnêtes.


## 10. Résultats du POC TikZ (2026-10-10)

Le POC sur trois figures est documenté dans [tikz-poc/RESULTS.md](tikz-poc/RESULTS.md). Le workflow dédié compile trois sources TikZ en PDF, convertit les PDF en SVG statiques et compare deux constructions indépendantes octet par octet. Le run 15 a réussi ; l'artefact comprend les six rendus et les trois SVG canoniques pour comparaison visuelle.

La revue confirme la conservation des éléments sémantiques principaux :
- pipeline : dix phases ordonnées, avec une disposition plus compacte en serpentin ;
- automate : état initial, deux états nommés, transitions et état final ;
- matrice : quatre combinaisons, axes catégoriels, couches et case non instanciée.

Le POC justifie une réimplémentation sélective, pas une migration globale. La génération est désormais séparée du rendu Verso dans la CI : un job produit et valide les paires PDF/SVG, puis le rendu consomme l'artefact. Les sources TikZ sont versionnées sous `spec/figures/tikz/`; les sorties générées ne sont pas suivies dans Git. Les légendes, textes alternatifs et descriptions éditoriales restent dans les déclarations Verso. La conformité PDF/UA avec le préambule personnalisé reste à vérifier, ce préambule n'étant pas versionné dans le dépôt.

## 11. Vérification des artefacts CI et état effectif (10 octobre 2026)

Les artefacts ont été téléchargés depuis les runs GitHub Actions réellement associés à la PR [#142](https://github.com/AntheaLiles/k7pl/pull/142), et non régénérés localement : [run TikZ POC #38070486651](https://github.com/AntheaLiles/k7pl/actions/runs/38070486651), [run CI #38070486770](https://github.com/AntheaLiles/k7pl/actions/runs/38070486770). Les deux jobs rapportent `success`. L'artefact `tikz-poc-renderings` était présent, non expiré au moment de l'inspection, avec une expiration annoncée le 24 octobre 2026 ; la CI produit aussi `tikz-figure-assets`, `spec-html`, `spec-tex` et `spec-pdf`.

Le workflow de production génère les trois couples PDF/SVG, les reconstruit deux fois et compare chaque fichier octet par octet. `check_tikz_figures.py` confirme pour chaque entrée du manifeste la source TikZ, la déclaration Verso correspondante, la signature PDF, le XML SVG et leur présence. Le HTML CI inspecté contient 66 pages, les 12 figures déclarées avec une alternative non vide et 12 descriptions longues, ainsi que 13 SVG copiés (le treizième est le reliquat LSP). Le vérificateur HTML vérifiait chemins, présence et XML des assets, mais il ne liait pas explicitement la description longue à l'image et ne comparait pas l'ensemble des figures rendues à l'ensemble des déclarations : les contrôles sont renforcés par la PR de suivi.

### Inspection du PDF réel disponible

Le PDF `spec-pdf` de CI du run [#38090151252](https://github.com/AntheaLiles/k7pl/actions/runs/38090151252) (SHA alors testé `79165b921676520b970034066db9e3c8e71041a0`) a été téléchargé, ouvert et rasterisé à 120 dpi. Dans cet artefact, le pipeline apparaît à la page PDF 246 (page imprimée 242), l'automate à la page PDF 110 (page imprimée 106) et la matrice à la page PDF 102 (page imprimée 98). Les dix nœuds du pipeline, leur séquence et leurs flèches restent discernables, même si la typographie est petite. Les états EXPECT_INT / EXPECT_BOOL, les transitions send(Int) et recv(Bool), ainsi que le double cercle et son marqueur violet sont distincts. La matrice reste lisible en niveaux de gris : ses deux axes, les trois points noirs et la quatrième case restent identifiables.

La correction par `minipage` est **visuellement vérifiée sur ce PDF de CI** : la matrice, sa légende et sa description longue occupent maintenant la même page ; le défaut observé avant la correction a disparu. Il s'agit d'une inspection visuelle de l'artefact, pas d'une revue humaine indépendante. Le POC statique a ensuite été relancé dans le run [#38090525710](https://github.com/AntheaLiles/k7pl/actions/runs/38090525710) ; les SHA-256 des trois PDF, trois SVG TikZ et trois SVG de référence sont identiques à ceux du run POC précédent. Cette identité établit que les récentes corrections rédactionnelles n'ont pas changé la géométrie des figures.

Côté HTML, l'artefact du run #38090151252 contient 67 pages HTML, 12 figures déclarées et 13 SVG copiés (le treizième est le reliquat LSP). Les 12 images de figure ont un `alt` non vide et une relation `aria-describedby` valide avec la description longue. Les 12 SVG déclarés de cet artefact possèdent un `<title>` et un `<desc>` non vides. Les largeurs maximales restent explicites : 90 % pour les trois figures TikZ, 75 % pour la figure duale ; `height:auto` préserve les proportions et le CSS général plafonne la largeur à 100 %.

La tête de PR la plus récente renforce encore le contrat des SVG publiés : outre `<title>` et `<desc>`, elle ajoute `role="img"`, `aria-labelledby` et `aria-describedby` qui référencent leurs identifiants propres. Le vérificateur de CI doit refuser un rôle ou une relation incorrecte, un titre/une description vide, une alternative absente, une relation HTML `aria-describedby` invalide, une figure déclarée sans PDF/SVG ou un inventaire déclaré/rendu incohérent. Le renderer TeX utilise également une stratégie conditionnelle : wrappers `qvalt/qvaltfin` lorsqu'ils existent ; sinon `includegraphics[alt={...}]` si l'interface `tagpdfsetup` de LaTeX Tagged PDF est chargée ; sinon le rendu PDF non balisé préserve la compatibilité. Le run CI du SHA courant doit confirmer cette modification Lean et la stratégie TeX.


### Portée des conclusions et dépendances externes

- **Établi par les contrôles disponibles :** génération PDF/SVG déterministe ; égalité SHA-256 des trois rendus TikZ entre deux runs POC ; PDF complet compilé avec succès ; inspection visuelle de la pagination corrigée sur le PDF du run #38090151252 ; 12 images déclarées avec alternatives et descriptions longues reliées dans cet artefact HTML ; 12 SVG déclarés avec titre et description non vides ; tests du vérificateur, de l'enrichissement SVG et du catalogue passés avant les toutes dernières assertions explicites d'attributs SVG.
- **Observé sur le PDF CI inspecté :** `pdfinfo` indique `Tagged: no` et la recherche dans les octets PDF ne trouve pas `/StructTreeRoot`. Le préambule personnalisé réel n'est pas disponible dans le dépôt ; cette observation ne prouve rien sur une autre chaîne de publication.
- **Non établi :** PDF/UA sur le PDF de publication construit avec la copie locale effective du préambule, validation veraPDF du profil déclaré, lecture par un lecteur d'écran, bénéfice explicatif pour les lecteurs et revue éditoriale humaine indépendante. L'artefact de CI de la spécification utilise toujours la chaîne Tectonic standard : il ne démontre pas le résultat de la configuration Org/LuaLaTeX.
- **Périmètre externe restant :** confirmer que la copie locale de `~/.emacs.d/latex/preamble-article.tex` correspond bien à l'archive versionnée (blob `33816e66eda838c9646e40c0c46f5a21a66f444a`) et que `my-export-config.el` correspond à la source archivée (blob `ab63b5d3b11d51ffb19074f6f3d24b0819a0542b`). La version exacte de `preamble-tikz.tex`, référencée par un ancien `protocole.tex` mais absente des archives consultées, n'a pas été retrouvée ; elle n'est pas nécessaire à la génération des trois figures autonomes de K7PL.
- **Dépendance humaine/externe :** après comparaison des fichiers locaux, reconstruire le document concerné avec sa commande et ses versions réellement utilisées ; exécuter un validateur PDF/UA adapté (par exemple veraPDF configuré pour le profil PDF/UA annoncé) ; faire examiner l'arbre de structure et l'ordre de lecture par une personne utilisant un lecteur d'écran ; relire les figures au format d'insertion et en niveaux de gris.



### Protocole reproductible du contrôle PDF/UA

Ce protocole porte sur le PDF effectivement destiné à publication, pas sur un PDF de CI construit avec une autre configuration.

1. Le contenu du préambule article a été récupéré dans [`docs/archives/outillage-org/preamble-article.tex`](../archives/outillage-org/preamble-article.tex) (blob `33816e66eda838c9646e40c0c46f5a21a66f444a`) et la configuration Org correspondante dans [`docs/archives/outillage-org/my-export-config.el`](../archives/outillage-org/my-export-config.el) (blob `ab63b5d3b11d51ffb19074f6f3d24b0819a0542b`). La configuration archivée utilise LuaLaTeX/latexmk et `\DocumentMetadata{lang=fr,pdfversion=2.0,pdfstandard=ua-2,testphase=phase-III}`, avant `\documentclass[a4paper,11pt]{article}` et `\input{~/.emacs.d/latex/preamble-article.tex}`. Un historique antérieur consigne aussi la variante `testphase={phase-III,math,graphic,table}`. Ces deux sources versionnées fournissent le contenu exact des copies archivées, mais il faut encore comparer les fichiers du poste local à ces copies ; ne pas supposer que le préambule actuel du poste est identique.
2. Vérifier dans `my-export-config.el` local le processus exact, puis comparer les empreintes SHA-256 du préambule, de la configuration, de `latexmkrc` et des polices nécessaires avec les artefacts versionnés disponibles. Recompiler le document de publication via cette chaîne exacte ; enregistrer commit, versions, commande et empreinte du PDF. Exécuter `pdfinfo "$PDF"` et conserver le résultat. Le PDF de CI de la spécification précédemment inspecté annonce `Tagged: no`, mais ce n'est pas le PDF produit par la chaîne Org/LuaLaTeX.
3. Installer veraPDF, enregistrer `verapdf --version` et exécuter `verapdf -l` pour confirmer les profils disponibles. Selon le profil de conformité visé et annoncé par le document, exécuter soit `verapdf -f ua1 "$PDF"`, soit `verapdf -f ua2 "$PDF"`, en redirigeant toute la sortie vers un rapport conservé avec le PDF et ses empreintes. Ne pas sélectionner a posteriori le profil qui donnerait le résultat le plus favorable. Voir la [documentation officielle de validation CLI veraPDF](https://docs.verapdf.org/cli/validation/).
4. Une personne responsable examine ensuite l'arbre de structure, l'association des figures balisées avec leurs textes alternatifs, l'ordre de lecture et le résultat avec un lecteur d'écran. Le validateur automatise des contrôles de profil, mais ne remplace pas ces points de contrôle humains ; voir la [portée de la validation veraPDF](https://docs.verapdf.org/validation/).
5. La même personne relit le PDF à la taille effective d'insertion et en nuances de gris, vérifie que la matrice reste groupée avec sa légende et sa description, puis consigne le résultat et les défauts restants dans ce suivi. Aucun de ces contrôles humains n'est présumé effectué par cette PR.

TikZJax/isomorphic-tikzjax n'est pas retenu : les besoins démontrés ici portent sur des artefacts statiques déterministes et aucun cas d'édition/rendu interactif côté navigateur n'a été identifié. La décision de réimplémentation reste limitée aux trois figures déjà testées ; aucune migration globale n'est autorisée par ces résultats.

## 12. Validation de la PR #149 sur la tête courante

La tête vérifiée est `5d527c5ee6b74c993903607addb5852f4e914b1c`. Runs : [CI #38091879446](https://github.com/AntheaLiles/k7pl/actions/runs/38091879446) et [TikZ figure POC #38091879272](https://github.com/AntheaLiles/k7pl/actions/runs/38091879272). Le POC est vert. Dans la CI complète, les contrôles sécurité, REUSE, commitlint, tests Python, contrôles rapides, assets TikZ, rendu Verso, validation HTML et compilation PDF ont réussi. Le job général `Vérification / Implémentation Lean` restait en cours au dernier contrôle, pendant `Audit the axioms (tests)`; aucun échec n'y était rapporté. Ce job ne remplace pas les validations spécifiques du renderer, qui ont réussi.

### HTML courant

L'artefact `spec-html` du run #38091879446 contient 67 pages, 12 figures déclarées et 13 SVG copiés. Les 12 figures déclarées ont un `alt` non vide, une cible `aria-describedby` existante et non vide ; leurs SVG ont `role="img"`, `<title>`, `<desc>`, et des références `aria-labelledby` / `aria-describedby` concordantes. La treizième copie est `services-lsp.svg`, reliquat non référencé, conservé intentionnellement sans inventer de métadonnées pour une figure hors catalogue. Les étapes CI `Enrich published SVGs with accessible names and descriptions` et `Validate generated HTML image assets` ont réussi.

### PDF courant et défaut Lean corrigé

Le PDF `spec-pdf` du run #38091879446 a été téléchargé et inspecté ; la compilation PDF a réussi. À 120 dpi, les figures se trouvent à la page PDF 246 (pipeline, page imprimée 242), 110 (automate, page imprimée 106) et 102 (matrice, page imprimée 98). La matrice reste monochrome et se trouve sur la même page que sa légende et sa description longue ; les étiquettes du pipeline et les états/transitions de l'automate restent discernables. Ce constat est une inspection directe de l'artefact, non une revue humaine indépendante.

La CI antérieure sur le commit `6dc731127ffc5fbee4aff2ff9cfb4048bd042e65` a échoué à `tools/SpecExt/Float.lean:160:33` avec `Unknown identifier figures` : le chemin `figures/{info.arg}.pdf` avait été lu comme interpolation Lean. Le code du commit courant construit désormais le chemin TeX comme concaténation de texte littéral et de `info.arg`. Sur la tête courante, `Build the specification`, le rendu Verso, l'enrichissement SVG, le validateur HTML et le PDF complet réussissent.

### Limite de l'accessibilité PDF

Le PDF CI affiche `Tagged: no`. Le préambule et la configuration historiques exacts ont été retrouvés et identifiés dans le dépôt : `docs/archives/outillage-org/preamble-article.tex` (blob `33816e66eda838c9646e40c0c46f5a21a66f444a`) et `docs/archives/outillage-org/my-export-config.el` (blob `ab63b5d3b11d51ffb19074f6f3d24b0819a0542b`). Leurs blobs correspondent aux entrées homonymes du backup historique fourni. Cela ne prouve pas que les fichiers actuellement installés sous `~/.emacs.d/latex/` sont byte-identiques, ni ne remplace la reconstruction du document de publication avec cette chaîne. Le profil PDF/UA, la validation veraPDF et la revue par lecteur d'écran restent donc des tâches externes/humaines.
