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

Le rendu HTML construit un élément img dont l'URL est calculée comme rootPrefix traverseContext.path suivi de figures/, du nom de la figure et de .svg. Le préfixe est produit en répétant ../ selon la taille du chemin de traversal. Le générateur, dans tools/SpecMain.lean, copie spec/figures vers figures dans la sortie. C'est une hypothèse de défaut de chemin plausible, mais **pas encore un diagnostic prouvé** : il faut inspecter le HTML généré, la structure effective de html-multi, les réponses HTTP des URL d'images et le comportement sous le préfixe GitHub Pages.

Le rendu TeX de Float.lean utilise actuellement includegraphics avec width et keepaspectratio, sans transmettre le texte alternatif de FloatInfo à la commande d'inclusion et sans appel explicite visible au mécanisme de balisage de figure accessible dans ce chemin. Une macro de préambule seule ne corrige pas ce défaut si le générateur ne l'appelle pas.

Le plan interactif et son document d'architecture sont situés sous docs/tracking/. Le suivi des anomalies se trouve sous docs/tracking/ANOMALIES.md. L'anomalie ANOM-10 du registre actuel concerne l'interface Verso en anglais, pas le défaut d'images décrit ici ; ne pas réutiliser cet identifiant sans vérifier le registre. Créer ou rattacher un suivi spécifique aux figures cassées après reproduction.

Le changelog de la spécification annonce treize figures. Ce nombre sert de contrôle initial à confronter à un inventaire généré depuis les sources ; il ne constitue pas à lui seul un inventaire validé.

## 3. Hypothèses à vérifier avant toute correction

- **H1 — URL ou copie des assets :** la page HTML émise référence un chemin qui ne correspond pas à l'emplacement réel du SVG après génération ou publication.
- **H2 — base path :** le rendu fonctionne en local à la racine, mais échoue sous le préfixe du site GitHub Pages.
- **H3 — source absente ou nom différent :** le champ src du bloc Verso ne correspond pas à un fichier SVG présent dans spec/figures.
- **H4 — comportement d'affichage :** le navigateur affiche le texte alternatif parce que la ressource image échoue ; il faut le confirmer dans le réseau/console plutôt que l'inférer du seul rendu visuel.
- **H5 — accessibilité PDF :** le PDF peut être visuellement correct tout en n'exposant pas le texte alternatif dans sa structure balisée.

Aucune de ces hypothèses ne doit être marquée comme cause racine avant reproduction et test discriminant.

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
