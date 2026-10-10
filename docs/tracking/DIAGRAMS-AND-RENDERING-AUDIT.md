<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit préliminaire des figures et de leur rendu HTML/PDF

**Statut :** audit préparatoire ; constats de code à confirmer par une génération locale et par inspection du site publié.  
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

Le rendu TeX de Float.lean utilise actuellement includegraphics avec width et keepaspectratio, sans transmettre le texte alternatif de FloatInfo à la commande d'inclusion et sans appel explicite visible au mécanisme de balisage de figure accessible dans ce chemin. Une macro de préambule seule ne corrige pas ce défaut si le générateur ne l'appelle pas.

Le plan interactif et son document d'architecture sont situés sous docs/tracking/. Le suivi des anomalies se trouve sous docs/tracking/ANOMALIES.md. L'anomalie ANOM-10 du registre actuel concerne l'interface Verso en anglais, pas le défaut d'images décrit ici ; ne pas réutiliser cet identifiant sans vérifier le registre. Créer ou rattacher un suivi spécifique aux figures cassées après reproduction.

Le changelog conserve un compte historique de treize figures. L'artefact HTML audité contient douze figures K7PL réellement déclarées et un treizième SVG, `services-lsp.svg`, qui n'est référencé par aucune déclaration actuelle. Le nombre 13 ne doit donc pas être interprété comme une déclaration manquante : le fichier LSP est un reliquat de l'ancien manuscrit. Le suivi de cohérence du 9 octobre le croyait déjà absent, mais il existe encore dans `spec/figures/` avec son PDF et sa source Mermaid ; cette incohérence d'inventaire reste à résoudre séparément.

### Inventaire initial extrait des déclarations Verso

La première recherche dans les sources a fait apparaître les douze déclarations ci-dessous. Ce relevé est volontairement **provisoire** : le changelog annonce treize figures, donc il reste au moins une déclaration à retrouver ou à expliquer avant de fermer l'inventaire.

| Source canonique (module) | Identifiant de figure | Objet représenté | Rôle explicatif pressenti |
|---|---|---|---|
| spec/Spec/C1/AxiomatiqueGerminale.lean | fig:specialisation-couches | specialisation-du-jugement | Relier le jugement germinal aux trois couches du langage |
| spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean | fig:dualite-algebre-coalgebre | co-algebra-duality | Expliquer la dualité entre algèbre initiale et coalgèbre terminale |
| spec/Spec/C2/ComonadeExponentielleEtFragments.lean | fig:fragments-emboites | fragments-nestings | Comparer les règles structurelles autorisées dans les fragments |
| spec/Spec/C3/LeSystemeGradue.lean | fig:modalites-structurelles | matrice-contraction-affaiblissement | Montrer les combinaisons de contraction/affaiblissement retenues |
| spec/Spec/C3/LesContraintesDeValeur.lean | fig:session-automate | session-protocol-as-automata | Expliquer la progression d'un automate de protocole de session |
| spec/Spec/C3/LesContraintesDeValeur.lean | fig:session-dualite | session-protocol-as-dual-exchange | Comparer les deux extrémités d'un protocole dual |
| spec/Spec/C4/EchelleLocale.lean | fig:rexp-complexite | rexp-hierarchy-complexity | Comparer les classes de complexité des R-expressions |
| spec/Spec/C4/EchelleDeLActeur.lean | fig:arene-partition | soa-partitionning | Rendre visible la partition statique de mémoire entre fibrilles |
| spec/Spec/C4/EchelleDuSysteme.lean | fig:acteur-cycle-de-vie | virtual-actor-lca | Expliquer le cycle de vie d'un acteur virtuel |
| spec/Spec/C4/EchelleDuSysteme.lean | fig:circuit-breaker | session-circuit-breaker | Expliquer le rejet ou l'acceptation d'un message selon le tag d'état |
| spec/Spec/C6/LeProcessusDeCompilation.lean | fig:comp-process | compilation-process | Exposer les phases de la chaîne de compilation |
| spec/Spec/C7/EtudeDeCasIArchitectureReactiveNative.lean | fig:cycle-reactif | unidirectionnal-reactive-cycle | Relier les étapes du cycle réactif aux trois couches |

Ce tableau classe la **fonction attendue** d'après les déclarations et leurs textes alternatifs ; il ne valide pas encore l'exactitude visuelle des images, leur existence dans les deux formats ni la qualité de leur description longue. Les trois cas de prototype les plus informatifs semblent être : le pipeline de compilation (processus), l'automate ou la dualité du protocole de session (états/relations), et la matrice contraction/affaiblissement (représentation structurale compacte). Le choix définitif dépendra de l'inspection visuelle des fichiers réels.


## 3. Cause racine et portée de la correction

- **Cause HTML confirmée :** double application du préfixe de profondeur, due à la combinaison de l'URL produite par `Float.lean` et du `<base href>` injecté par Verso.
- **Correction fusionnée en PR #124 :** émettre `figures/<nom>.svg` sans préfixe manuel ; le `<base href>` résout alors l'URL à la racine du site. La compilation de la spécification, le contrôle d'assets, la compilation PDF et le déploiement GitHub Pages passent.
- **Contrôle ajouté :** le validateur de CI doit tenir compte de `<base href>`, vérifier chaque référence locale, contrôler la copie et le XML des SVG, et rejeter les figures sans texte alternatif. Un validateur qui résout uniquement les chemins depuis le répertoire de la page ne détecte pas ce défaut.
- **Déploiement :** le test sur l'artefact local ne suffit pas à prouver la publication. La validation CI et le déploiement après fusion doivent être vérifiés avant de clore l'anomalie.
- **PDF :** le texte alternatif est désormais transmis conditionnellement aux macros `qvalt` / `qvaltfin` si le préambule les définit. La conformité du PDF reste à confirmer sur l'artefact compilé avec ce préambule.

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
