<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL — Plan de réalisation de l'enveloppe interactive

**Statut :** backlog de conception et de démonstration de valeur  
**Date de création :** 2026-10-08  
**Document de suivi :** les cases décrivent des actions à réaliser ou des critères à vérifier ; elles ne constituent pas des résultats acquis.

Référence : [Enveloppe interactive de présentation et d'exploration](INTERACTIVE-EXPLORATION.md).

## Objectif

Construire progressivement une enveloppe interactive de K7PL permettant d'explorer les relations entre spécification, formalisation, implémentation, preuves, tests, documentation, bibliographie, décisions et historique.

Le projet doit démontrer une amélioration réelle de la compréhension avant d'engager une infrastructure importante.

## User stories

### US-01 — Comprendre un objet de la spécification

> **As a reader**, I want to start from an element de la spécification and discover its definition, dependencies, rationale and related evidence, so that I can understand what it means without reconstructing the whole repository manually.

**Critères d'acceptation**
- [x] Un point d'entrée contextuel est présent sur chaque page rendue ; il ouvre le graphe sur cette page, puis la recherche permet de sélectionner un objet précis.
- [ ] La page présente sa définition ou son contexte immédiat.
- [ ] Les relations disponibles vers documentation, décisions, sources et vérifications sont navigables.
- [ ] Chaque relation renvoie à une source canonique.
- [x] Le prototype distingue les relations structurelles `contains` des références `references` et citations `cites` explicitement rendues ; aucune relation de preuve, d'implémentation ou de test n'est inférée.

### US-02 — Explorer le projet par relations

> **As a researcher**, I want to navigate from one project artifact to related artifacts, so that I can follow the reasoning and provenance across repository layers.

**Critères d'acceptation**
- [x] Le prototype représente plusieurs types d'objets distincts (pages, sections, figures, tableaux, listings, énoncés, bibliographie).
- [x] Les relations ont un type explicite lorsque celui-ci est connu (`contains`, `references`, `cites`).
- [x] La navigation permet de revenir au point de départ grâce au contrôle de remise à zéro du nœud sélectionné.
- [x] La provenance de la relation est affichée par un lien vers la page dans laquelle elle a été rendue ; elle reste limitée au contexte HTML, sans prétention de ligne source exacte.
- [ ] Les relations historiques ou hypothétiques sont distinguées des relations courantes.

### US-03 — Explorer le graphe de connaissance

> **As a researcher**, I want an optional graph view of K7PL's knowledge relations, so that I can discover structures that are difficult to perceive through linear documents.

**Critères d'acceptation**
- [x] Le graphe peut être ouvert depuis chaque page documentaire ; l'entrée transmet la page courante comme nœud initial, puis la liste de recherche permet de sélectionner un objet précis.
- [x] Les nœuds ne sont pas limités aux fichiers : pages, sections, figures, tableaux, listings, énoncés et entrées bibliographiques rendus sont classés séparément.
- [x] Les types d'objets sont visibles dans la liste et les nœuds ; les relations `contains`, `references` et `cites` ont des libellés distincts.
- [x] La profondeur du voisinage (1–3 niveaux) et les types de relations affichés sont contrôlables depuis l'interface.
- [x] Le nœud sélectionné expose un lien direct vers son objet dans le HTML documentaire rendu ; les liens de source des relations offrent un retour supplémentaire.
- [x] Le graphe n'est pas la seule modalité de navigation : le document Verso reste consultable, et les listes textuelles proposent les mêmes objets et relations.

### US-04 — Comprendre sans simplifier abusivement

> **As a scientific reader**, I want progressive levels of explanation, so that I can approach a complex concept without losing access to its formal details.

**Critères d'acceptation**
- [x] Une première vue introductive et conceptuelle est disponible pour l’idée directrice exposée dans C1 Introduction, avec six niveaux de lecture ; la couverture reste limitée à cette entrée.
- [x] Le niveau conceptuel distingue l’hypothèse organisatrice de la démonstration d’une propriété.
- [x] Le niveau de formalisation renvoie explicitement au système gradué (C3), sans qualifier ce renvoi de dépendance de preuve.
- [x] Le niveau « preuves et vérifications » renvoie aux stratégies de vérification et de test (C6), en conservant la distinction entre construction et propriété établie.
- [x] Chaque niveau renvoie à une ou plusieurs ancres de la spécification ; l’interface indique explicitement que le texte éditorial n’est pas normatif.

### US-05 — Relier la théorie et les matériaux de recherche

> **As a researcher**, I want to navigate from formal project objects to bibliography, notes and decisions, so that I can reconstruct the reasoning that led to the current project state.

**Critères d'acceptation**
- [x] Au moins un parcours relie les objets rendus aux entrées bibliographiques via les citations `cites`, et la navigation figure relie les figures à leurs sources de production.
- [ ] Les décisions peuvent être distinguées des observations et hypothèses.
- [ ] Les matériaux historiques sont identifiés comme tels.
- [ ] Les liens vers les matériaux sont traçables.

### US-06 — Utiliser le site comme instrument d'étude

> **As the author of K7PL**, I want the interactive representation to reduce the cognitive cost of studying my own project, so that the presentation layer becomes a research aid rather than only a publication surface.

**Critères d'acceptation**
- [ ] Un parcours de compréhension actuellement coûteux est documenté avant le prototype.
- [ ] Le même parcours est rejoué avec le prototype.
- [ ] Les difficultés supprimées et celles qui subsistent sont consignées.
- [ ] Le prototype permet d'identifier au moins une relation qui serait difficile à reconstruire manuellement.

## Actions

### P0 — Cadrage et inventaire

- [x] Actualiser l'audit des figures et moteurs de rendu ([audit figures HTML/PDF, dernière version](https://github.com/AntheaLiles/k7pl/blob/a384592abac4aef13965ab98e2494567cfd37620/docs/tracking/DIAGRAMS-AND-RENDERING-AUDIT.md) ; contenu repris dans [l'inventaire](INTERACTIVE-EXPLORATION-INVENTORY.md), § 7, et ci-dessous) : la cause du défaut HTML est documentée, les sources et sorties sont inventoriées, les rendus statiques comparés et les contrôles automatiques définis. Les points de validation PDF/UA avec la chaîne réelle, l'inspection du nouvel artefact PDF et la revue humaine restent séparément ouverts ci-dessous.
- [x] Inventorier les capacités actuelles de Verso utilisées par K7PL ; relevé des extensions, du contrat de version et de la génération dans [l'inventaire technique](INTERACTIVE-EXPLORATION-INVENTORY.md), § 1.
- [x] Inventorier les générateurs et extensions sous `tools/` et `scripts/` dans [l'inventaire technique](INTERACTIVE-EXPLORATION-INVENTORY.md), §§ 2–3.
- [x] Identifier les structures Lean actuellement disponibles pour représenter les objets documentaires et leurs limites ; voir [l'inventaire technique](INTERACTIVE-EXPLORATION-INVENTORY.md), § 2.
- [x] Identifier les mécanismes existants de génération de documentation, statuts, bibliographie et traçabilité ; voir [l'inventaire technique](INTERACTIVE-EXPLORATION-INVENTORY.md), §§ 3–4.
- [x] Cartographier les matériaux susceptibles d'entrer dans l'enveloppe (`spec/`, `src/`, `tests/`, `docs/`, bibliographie, historique et décisions) dans [l'inventaire technique](INTERACTIVE-EXPLORATION-INVENTORY.md), § 4.
- [x] Identifier les doublons de modèle qu'il serait dangereux d'introduire ; décision de ne pas créer de modèle parallèle ni de fusionner les deux stratégies de graphe sans comparaison préalable ([inventaire technique](INTERACTIVE-EXPLORATION-INVENTORY.md), § 5).

#### Sous-chantier figures et rendu HTML/PDF

- [x] Reproduire le défaut dans l'artefact HTML de CI : les 12 références de figures sortent de la racine à cause du double préfixe entre l'URL et le `<base href>` de Verso. La correction a été déployée ; le job GitHub Pages et la validation de l'artefact publié réussissent. Le navigateur de recherche ne permet pas un contrôle HTTP direct de la page en ligne.
- [x] Corriger la cause démontrée et valider le contrôle automatisé des images locales : [PR #124 fusionnée](https://github.com/AntheaLiles/k7pl/pull/124), CI complète verte (build Verso, contrôle HTML, PDF). Le déploiement GitHub Pages et la validation de l'artefact publié sont réussis ; le défaut de rendu est clos.
- [x] Inventorier les 12 figures déclarées, leurs modules, noms d'assets, sources modifiables et fonctions explicatives ; le SVG LSP non référencé est recensé comme reliquat (voir [l'inventaire](INTERACTIVE-EXPLORATION-INVENTORY.md), § 7).
- [x] Définir le contrat minimal de métadonnées : objectif explicatif, type, source/sorties, légende, alt, description longue, note de lecture, provenance, objets liés, statut épistémique et critères de validation (contrat ci-dessous).
- [x] Réaliser le POC TikZ sur trois figures, vérifier les sorties PDF/SVG et la reproductibilité, comparer les éléments sémantiques aux SVG canoniques et consigner la décision dans [les résultats du POC](tikz-poc/RESULTS.md).
- [x] Ajouter le contrat HTML d'accessibilité : alternatives courtes, descriptions longues reliées, titres/descriptions internes aux copies SVG servies par le site et descriptions longues dans le catalogue généré (PR #149).
- [x] Inspecter l'artefact HTML courant du run CI #38091879446 : 67 pages, 12 figures déclarées avec `alt` et `aria-describedby` valides ; les 12 SVG déclarés ont `role="img"`, un `<title>` et un `<desc>` non vides ainsi que des références `aria-labelledby` et `aria-describedby` concordantes. Les étapes d'enrichissement SVG et de validation HTML ont réussi.
- [x] Inspecter le PDF courant de CI #38091879446 à 120 dpi : pipeline page imprimée 242, automate page 106 et matrice page 98 ; la matrice est réunie avec sa légende/description après le correctif `minipage`, et les trois figures restent discernables en niveaux de gris.
- [x] Relancer le POC TikZ dans le run #38091879272 ; le job de compilation/conversion et de comparaison des sorties déterministes a réussi sur la tête courante.
- [x] Vérifier les artefacts HTML/PDF de la tête courante après les dernières retouches d'alt, descriptions longues et métadonnées SVG ; le rendu HTML/TeX, l'enrichissement, la validation d'assets et la compilation PDF réussissent sur le run #38091879446.
- [x] Décision de ne pas ajouter TikZJax/isomorphic-tikzjax à ce stade : les artefacts déterministes PDF/SVG répondent au besoin démontré ; aucun besoin d'édition/rendu interactif navigateur n'est établi. Réouvrir ce point seulement si un cas d'usage interactif concret est documenté.
- [x] Inspecter les artefacts HTML et PDF de CI du 10 octobre ; relever les 12 figures HTML, les alternatives présentes, les dimensions proportionnelles, et détecter dans le PDF que la matrice et sa description sont séparées par un saut de page.
- [x] Après la correction ciblée du renderer, vérifier sur le PDF #38091879446 que la matrice reste groupée avec sa légende et sa description sur la page imprimée 98.
- [x] Retrouver et réintégrer au dossier de preuve la copie archivée du préambule article (`docs/archives/outillage-org/preamble-article.tex`) et la configuration d'export (`docs/archives/outillage-org/my-export-config.el`). Le fichier source de `preamble-tikz.tex`, référencé dans un ancien document mais absent des archives consultées, n'a pas été retrouvé.
- [ ] Comparer les empreintes des copies archivées avec les fichiers locaux actuels avant de déclarer cette chaîne identique ; inspecter le PDF réellement produit par cette chaîne. L'artefact du build Verso/Tectonic inspecté annonce `Tagged: no` et ne constitue pas une validation PDF/UA.
- [x] Intégrer la génération TikZ au build canonique : un job CI dédié génère et valide les paires PDF/SVG, puis les transmet au rendu Verso ; les artefacts dérivés ne sont pas suivis dans Git.
- [ ] Faire contrôler le PDF de publication avec le préambule personnalisé réel, un validateur PDF/UA et une revue humaine avec lecteur d'écran ; ne pas revendiquer de conformité avant ces contrôles.
- [ ] Terminer la revue humaine à taille d'insertion après correction de pagination, puis décider figure par figure d'éventuels autres candidats ; aucune migration globale n'est autorisée par le seul résultat du POC.

##### Contrat minimal d'une figure utile

Repris de l'audit des figures et du rendu ([dernière version](https://github.com/AntheaLiles/k7pl/blob/a384592abac4aef13965ab98e2494567cfd37620/docs/tracking/DIAGRAMS-AND-RENDERING-AUDIT.md)).

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

##### Accessibilité des figures

Le texte alternatif doit donner la fonction ou le résultat essentiel de la figure en une phrase concise. La description longue restitue l'organisation et les relations importantes ; la note explique les conventions. Les figures ne doivent pas encoder une distinction par la couleur seule. Vérifier contraste, taille de texte, épaisseur de trait, lisibilité à l'impression et comportement en niveaux de gris.

Pour le PDF, l'intégration doit transmettre les métadonnées au backend TeX et produire une figure balisée, puis être validée sur le PDF réellement généré. Le préambule fourni par le projet est un mécanisme potentiel, pas une preuve d'accessibilité à lui seul. Pour HTML, tester la présence des attributs accessibles et la résolution de l'image ; pour un SVG intégré, vérifier également le nom accessible et l'ordre de lecture.

Une future vue graphe devra offrir une alternative navigable au clavier et une liste ou table accessible, ainsi que des liens vers les sources. Le graphe ne doit jamais être l'unique moyen d'obtenir les relations.

##### Portée des conclusions de rendu établies au 10 octobre 2026

- **Établi par les contrôles disponibles :** génération PDF/SVG déterministe ; égalité SHA-256 des trois rendus TikZ entre deux runs POC ; PDF complet compilé avec succès ; inspection visuelle de la pagination corrigée sur le PDF du run #38090151252 ; 12 images déclarées avec alternatives et descriptions longues reliées dans cet artefact HTML ; 12 SVG déclarés avec titre et description non vides ; tests du vérificateur, de l'enrichissement SVG et du catalogue passés avant les toutes dernières assertions explicites d'attributs SVG.
- **Observé sur le PDF CI inspecté :** `pdfinfo` indique `Tagged: no` et la recherche dans les octets PDF ne trouve pas `/StructTreeRoot`. Le préambule personnalisé réel n'est pas disponible dans le dépôt ; cette observation ne prouve rien sur une autre chaîne de publication.
- **Non établi :** PDF/UA sur le PDF de publication construit avec la copie locale effective du préambule, validation veraPDF du profil déclaré, lecture par un lecteur d'écran, bénéfice explicatif pour les lecteurs et revue éditoriale humaine indépendante. L'artefact de CI de la spécification utilise toujours la chaîne Tectonic standard : il ne démontre pas le résultat de la configuration Org/LuaLaTeX.
- **Périmètre externe restant :** confirmer que la copie locale de `~/.emacs.d/latex/preamble-article.tex` correspond bien à l'archive versionnée (blob `33816e66eda838c9646e40c0c46f5a21a66f444a`) et que `my-export-config.el` correspond à la source archivée (blob `ab63b5d3b11d51ffb19074f6f3d24b0819a0542b`). La version exacte de `preamble-tikz.tex`, référencée par un ancien `protocole.tex` mais absente des archives consultées, n'a pas été retrouvée ; elle n'est pas nécessaire à la génération des trois figures autonomes de K7PL.
- **Dépendance humaine/externe :** après comparaison des fichiers locaux, reconstruire le document concerné avec sa commande et ses versions réellement utilisées ; exécuter un validateur PDF/UA adapté (par exemple veraPDF configuré pour le profil PDF/UA annoncé) ; faire examiner l'arbre de structure et l'ordre de lecture par une personne utilisant un lecteur d'écran ; relire les figures au format d'insertion et en niveaux de gris.

##### Protocole reproductible du contrôle PDF/UA

Ce protocole porte sur le PDF effectivement destiné à publication, pas sur un PDF de CI construit avec une autre configuration.

1. Le contenu du préambule article a été récupéré dans [`docs/archives/outillage-org/preamble-article.tex`](../archives/outillage-org/preamble-article.tex) (blob `33816e66eda838c9646e40c0c46f5a21a66f444a`) et la configuration Org correspondante dans [`docs/archives/outillage-org/my-export-config.el`](../archives/outillage-org/my-export-config.el) (blob `ab63b5d3b11d51ffb19074f6f3d24b0819a0542b`). La configuration archivée utilise LuaLaTeX/latexmk et `\DocumentMetadata{lang=fr,pdfversion=2.0,pdfstandard=ua-2,testphase=phase-III}`, avant `\documentclass[a4paper,11pt]{article}` et `\input{~/.emacs.d/latex/preamble-article.tex}`. Un historique antérieur consigne aussi la variante `testphase={phase-III,math,graphic,table}`. Ces deux sources versionnées fournissent le contenu exact des copies archivées, mais il faut encore comparer les fichiers du poste local à ces copies ; ne pas supposer que le préambule actuel du poste est identique.
2. Vérifier dans `my-export-config.el` local le processus exact, puis comparer les empreintes SHA-256 du préambule, de la configuration, de `latexmkrc` et des polices nécessaires avec les artefacts versionnés disponibles. Recompiler le document de publication via cette chaîne exacte ; enregistrer commit, versions, commande et empreinte du PDF. Exécuter `pdfinfo "$PDF"` et conserver le résultat. Le PDF de CI de la spécification précédemment inspecté annonce `Tagged: no`, mais ce n'est pas le PDF produit par la chaîne Org/LuaLaTeX.
3. Installer veraPDF, enregistrer `verapdf --version` et exécuter `verapdf -l` pour confirmer les profils disponibles. Selon le profil de conformité visé et annoncé par le document, exécuter soit `verapdf -f ua1 "$PDF"`, soit `verapdf -f ua2 "$PDF"`, en redirigeant toute la sortie vers un rapport conservé avec le PDF et ses empreintes. Ne pas sélectionner a posteriori le profil qui donnerait le résultat le plus favorable. Voir la [documentation officielle de validation CLI veraPDF](https://docs.verapdf.org/cli/validation/).
4. Une personne responsable examine ensuite l'arbre de structure, l'association des figures balisées avec leurs textes alternatifs, l'ordre de lecture et le résultat avec un lecteur d'écran. Le validateur automatise des contrôles de profil, mais ne remplace pas ces points de contrôle humains ; voir la [portée de la validation veraPDF](https://docs.verapdf.org/validation/).
5. La même personne relit le PDF à la taille effective d'insertion et en nuances de gris, vérifie que la matrice reste groupée avec sa légende et sa description, puis consigne le résultat et les défauts restants dans ce suivi. Aucun de ces contrôles humains n'est présumé effectué par cette PR.

### P1 — Cas d'usage et démonstration de valeur

- [x] Choisir un premier parcours de provenance technique, étroit et vérifiable : figure Verso → source graphique → rendus SVG/PDF → renderer et validation CI.
- [x] Documenter le parcours cible et distinguer ses relations vérifiables des futures relations sémantiques dans [le cadrage du prototype](NAVIGATION-PROTOTYPE.md).
- [x] Définir les objets et relations strictement nécessaires à cette tranche ; aucune relation conceptuelle n'est inférée depuis la simple proximité de fichiers.
- [x] Définir les critères de validation avant la revue de l'interface (cadrage du prototype).
- [x] Produire une première représentation navigable dans le rendu HTML publié : le catalogue de provenance est généré et validé en CI, puis déployé avec succès via GitHub Pages.
- [ ] Comparer le parcours manuel actuel au parcours prototype avec des lecteurs non familiers ; le protocole, les mesures et le seuil de décision sont préenregistrés dans [le dossier de preuve de valeur](NAVIGATION-PROTOTYPE.md). Aucune mesure utilisateur n'est disponible à ce stade.
- [x] Décision de phase du 2026-10-11 : **réorienter**. Conserver la tranche de provenance, suspendre l'extension sémantique et conditionner tout élargissement à la comparaison utilisateur et à la traçabilité explicite de chaque relation.

### P2 — Modèle documentaire et sémantique

- [x] Proposer un premier vocabulaire de nœuds, de relations et de provenance dans [le modèle sémantique minimal](NAVIGATION-SEMANTIC-MODEL.md) ; il reste à le valider par un prototype.
- [x] Produire et valider en CI le graphe local C6 sur les références explicites et citations ; les ancres des pages rendues sont résolues ou font échouer la génération. La revue humaine de la valeur explicative reste ouverte.
- [x] Ajouter une seconde tranche C3 et relier les deux vues pour vérifier que le générateur s'applique à plusieurs sections sans fusionner citations et références.
- [ ] Définir et tester les catégories minimales d'objets nécessaires.
- [ ] Définir et tester les catégories minimales de relations nécessaires.
- [ ] Distinguer au minimum état courant, historique, hypothèse et preuve, sans les confondre avec l'état de validation d'une relation.
- [ ] Définir comment chaque relation conserve sa provenance dans les données générées.
- [ ] Déterminer ce qui doit être modélisé en Lean et ce qui doit rester dans les sources.
- [ ] Vérifier qu'aucun modèle intermédiaire ne devient une seconde source de vérité.

### P3 — Génération Verso

- [x] Définir le point d'entrée du générateur : `scripts/ci/build_navigation_graph.py --site ... --ref ...`, appelé par `verify.yaml`.
- [x] Exploiter le HTML généré par Verso pour les ancres, liens explicites, types de blocs et citations, sans ajouter d'extension Lean pour cette première vue.
- [x] Pour la première vue, aucun nouveau bloc Verso n'est nécessaire : le générateur dérive la navigation du HTML rendu et réutilise les métadonnées et classes existantes.
- [x] Générer une première navigation multi-niveaux reliant le catalogue de provenance et deux graphes locaux.
- [x] Préserver les liens vers les sources canoniques, avec retour vers la page Verso rendue.
- [x] Ajouter les garde-fous de génération nécessaires à la CI : références/citations et ancres rendues non résolues font échouer le build.

### US-04 — Présentation progressive : fonctionnalité d’interface et limite actuelle

Le navigateur distingue désormais deux mécanismes. Les niveaux « repère typé », « texte disponible dans le HTML rendu » et « page documentaire » affichent les informations qui existent déjà dans le rendu. Une seconde commande présente une explication éditoriale explicitement rédigée en six niveaux (introduction, vue conceptuelle, détails et limites, formalisation, preuves et vérifications, sources et provenance) pour le point d’entrée C1 Introduction. Chaque niveau lie les sections Verso utilisées ; le contenu est annoncé comme non normatif. Les autres objets affichent honnêtement l’absence d’explication associée : aucune explication n’est générée à partir des relations du graphe. L’extension de cette couverture et sa revue par l’auteure restent ouvertes.

### P4 — Graphe

- [x] Définir un modèle initial borné : nœuds de types rendus, arêtes `contains` structurelles et arêtes `references`/`cites` explicites ; provenance conservée dans `graph.json`.
- [x] Générer deux vues graphe limitées à des plages de source explicites et validées par CI.
- [x] Ajouter le réglage interactif de profondeur et les cases de filtrage par type de relation ; les nœuds et relations restent aussi disponibles en listes textuelles accessibles.
- [x] Permettre le retour du graphe vers la section Verso rendue et sa source canonique.
- [ ] Évaluer si la vue graphe améliore réellement la compréhension.

### P5 — Extension progressive

- [ ] Ajouter progressivement bibliographie et notes de recherche.
- [ ] Ajouter décisions et historique lorsque leur provenance est suffisamment structurée.
- [ ] Préparer l'intégration future de l'implémentation et des tests.
- [ ] Ajouter de nouveaux parcours de compréhension uniquement après validation du modèle.
- [ ] Documenter les limites de couverture.

## Critères d'acceptation architecturaux

- [ ] Markdown reste utilisable comme source documentaire canonique.
- [ ] GitHub reste utilisable pour contribution, revue et consultation des sources.
- [ ] La génération du site est reproductible à partir du dépôt.
- [ ] Aucun contenu présenté par le site ne devient implicitement normatif par sa seule présence dans le site.
- [ ] Toute information dérivée conserve une provenance identifiable.
- [ ] Les statuts et niveaux de certitude ne sont pas aplatis par la présentation.
- [ ] Le système ne nécessite pas une migration globale vers MDX.
- [ ] Lean n'est pas transformé en framework web généraliste.
- [ ] Les futures implémentations et tests peuvent rejoindre le modèle sans changer son principe.
- [ ] Les contrôles CI peuvent détecter une représentation générée périmée.

## Critères de clôture de la phase de démonstration

- [ ] Un cas d'usage réel est choisi et documenté.
- [ ] Le prototype couvre le parcours minimal défini.
- [ ] La provenance des éléments présentés est vérifiable.
- [ ] Une évaluation comparative du parcours avant/après est produite.
- [ ] Les bénéfices et limites sont documentés.
- [x] Une décision explicite est prise : réorienter la démonstration, maintenir la comparaison utilisateur comme prérequis à toute extension.

## Point de reprise — preuve de valeur navigation (11 octobre 2026)

Le run CI `38092815528` cité plus haut est le point de comparaison historique, antérieur à la PR #150. Cette PR est maintenant fusionnée. Son run de validation [#38093986701](https://github.com/AntheaLiles/k7pl/actions/runs/38093986701) a terminé avec succès ; la génération et la validation contrôlent désormais la fraîcheur des pages, les liens/fragments locaux et la correspondance univoque entre chaque figure du catalogue et son ancre documentaire rendue.

Cette validation établit la cohérence mécanique du HTML construit dans le run de PR. Elle ne prouve pas que le site public a été redéployé après cette correction ni que ses URL fonctionnent dans un navigateur. La validation directe du site publié, les essais clavier/mobile/sans JavaScript et la comparaison manuelle/prototype restent ouverts ; le protocole préenregistré dans [le dossier de preuve de valeur](NAVIGATION-PROTOTYPE.md) n'a pas encore été exécuté. Ne pas modifier le tableau de bord global généré `docs/STATUS.md`.

Le prochain parcours sémantique reste bloqué par cette porte de valeur d'usage : aucune relation entre définition, théorème, preuve, implémentation et test ne sera ajoutée sur la seule base des noms de modules, imports ou proximités de fichiers.
