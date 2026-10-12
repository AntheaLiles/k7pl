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
- [ ] Un élément identifiable de la spécification peut constituer un point d'entrée.
- [ ] La page présente sa définition ou son contexte immédiat.
- [ ] Les relations disponibles vers documentation, décisions, sources et vérifications sont navigables.
- [ ] Chaque relation renvoie à une source canonique.
- [ ] Le prototype ne présente pas comme établi un lien qui n'est pas démontré.

### US-02 — Explorer le projet par relations

> **As a researcher**, I want to navigate from one project artifact to related artifacts, so that I can follow the reasoning and provenance across repository layers.

**Critères d'acceptation**
- [ ] Le prototype représente plusieurs types d'objets distincts.
- [ ] Les relations ont un type explicite lorsque celui-ci est connu.
- [ ] La navigation permet de revenir au point de départ.
- [ ] La provenance de chaque relation peut être retrouvée.
- [ ] Les relations historiques ou hypothétiques sont distinguées des relations courantes.

### US-03 — Explorer le graphe de connaissance

> **As a researcher**, I want an optional graph view of K7PL's knowledge relations, so that I can discover structures that are difficult to perceive through linear documents.

**Critères d'acceptation**
- [ ] Le graphe peut être ouvert depuis un objet ou un parcours.
- [ ] Les nœuds ne sont pas limités aux fichiers.
- [ ] Les types d'objets et de relations sont distinguables.
- [ ] La profondeur ou le périmètre affiché peut être limité.
- [ ] Un nœud du graphe permet de revenir à une vue documentaire.
- [ ] Le graphe n'est pas la seule modalité de navigation.

### US-04 — Comprendre sans simplifier abusivement

> **As a scientific reader**, I want progressive levels of explanation, so that I can approach a complex concept without losing access to its formal details.

**Critères d'acceptation**
- [ ] Une vue introductive existe pour le prototype.
- [ ] Une vue conceptuelle explicite les notions principales.
- [ ] La formalisation reste accessible.
- [ ] Les preuves, tests ou limites disponibles restent accessibles.
- [ ] Les simplifications pédagogiques ne remplacent pas les sources canoniques.

### US-05 — Relier la théorie et les matériaux de recherche

> **As a researcher**, I want to navigate from formal project objects to bibliography, notes and decisions, so that I can reconstruct the reasoning that led to the current project state.

**Critères d'acceptation**
- [ ] Au moins un parcours relie un objet formel à une source ou note pertinente.
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

- [x] Actualiser l'audit des figures et moteurs de rendu ([audit figures HTML/PDF](DIAGRAMS-AND-RENDERING-AUDIT.md)) : la cause du défaut HTML est documentée, les sources et sorties sont inventoriées, les rendus statiques comparés et les contrôles automatiques définis. Les points de validation PDF/UA avec la chaîne réelle, l'inspection du nouvel artefact PDF et la revue humaine restent séparément ouverts ci-dessous.
- [ ] Inventorier les capacités actuelles de Verso utilisées par K7PL.
- [ ] Inventorier les générateurs et extensions sous `tools/`.
- [ ] Identifier les structures Lean actuellement disponibles pour représenter les objets documentaires.
- [ ] Identifier les mécanismes existants de génération de documentation, statuts, bibliographie et traçabilité.
- [ ] Cartographier les matériaux susceptibles d'entrer dans l'enveloppe : `spec/`, `src/`, `tests/`, `docs/`, bibliographie, historique et décisions.
- [ ] Identifier les doublons de modèle qu'il serait dangereux d'introduire.

#### Sous-chantier figures et rendu HTML/PDF

- [x] Reproduire le défaut dans l'artefact HTML de CI : les 12 références de figures sortent de la racine à cause du double préfixe entre l'URL et le `<base href>` de Verso. La correction a été déployée ; le job GitHub Pages et la validation de l'artefact publié réussissent. Le navigateur de recherche ne permet pas un contrôle HTTP direct de la page en ligne.
- [x] Corriger la cause démontrée et valider le contrôle automatisé des images locales : [PR #124 fusionnée](https://github.com/AntheaLiles/k7pl/pull/124), CI complète verte (build Verso, contrôle HTML, PDF). Le déploiement GitHub Pages et la validation de l'artefact publié sont réussis ; `ANOM-17` peut être clos.
- [x] Inventorier les 12 figures déclarées, leurs modules, noms d'assets, sources modifiables et fonctions explicatives ; le SVG LSP non référencé est recensé comme reliquat (voir l'inventaire de l'audit).
- [x] Définir le contrat minimal de métadonnées : objectif explicatif, type, source/sorties, légende, alt, description longue, note de lecture, provenance, objets liés, statut épistémique et critères de validation (audit, §5).
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

- [ ] Définir le point d'entrée du générateur.
- [ ] Déterminer quelles fonctionnalités peuvent être obtenues avec Verso existant.
- [ ] Développer uniquement les extensions nécessaires au prototype.
- [x] Générer une première navigation multi-niveaux reliant le catalogue de provenance et deux graphes locaux.
- [x] Préserver les liens vers les sources canoniques, avec retour vers la page Verso rendue.
- [x] Ajouter les garde-fous de génération nécessaires à la CI : références/citations et ancres rendues non résolues font échouer le build.

### P4 — Graphe

- [ ] Définir le modèle de graphe à partir des relations sémantiques.
- [x] Générer deux vues graphe limitées à des plages de source explicites et validées par CI.
- [ ] Ajouter filtrage ou limitation de profondeur si nécessaire.
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

Le run CI `38092815528` construit et déploie les trois pages de navigation ; l'inspection de son artefact Pages montre 67 pages HTML et 53 liens locaux valides dans le sous-ensemble de navigation, sans ancre locale visée manquante. C'est une vérification reproductible de l'artefact, pas un test utilisateur ni une preuve de bon fonctionnement des URL publiques.

Une correction de réversibilité et un contrôle automatique des liens/fraîcheur sont préparés dans la [PR #150](https://github.com/AntheaLiles/k7pl/pull/150). Après validation de la PR et déploiement, refaire l'inspection du nouvel artefact. Maintenir ouvertes la comparaison manuelle/prototype, l'essai réel mobile/clavier/sans JavaScript et la revue de valeur humaine. Ne pas modifier le tableau de bord global généré `docs/STATUS.md`.

Le prochain parcours sémantique est bloqué, pas autorisé par défaut : aucune relation entre définition, théorème, preuve, implémentation et test ne sera ajoutée sur la seule base des noms de modules, imports ou proximités de fichiers.
