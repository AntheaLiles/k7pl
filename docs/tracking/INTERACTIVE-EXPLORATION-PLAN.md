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

- [ ] Traiter l'audit préparatoire des figures et moteurs de rendu ([audit figures HTML/PDF](DIAGRAMS-AND-RENDERING-AUDIT.md)) : établir la cause du défaut HTML, inventori­er les sources et sorties, comparer les moteurs et définir les contrôles d'accessibilité.
- [ ] Inventorier les capacités actuelles de Verso utilisées par K7PL.
- [ ] Inventorier les générateurs et extensions sous `tools/`.
- [ ] Identifier les structures Lean actuellement disponibles pour représenter les objets documentaires.
- [ ] Identifier les mécanismes existants de génération de documentation, statuts, bibliographie et traçabilité.
- [ ] Cartographier les matériaux susceptibles d'entrer dans l'enveloppe : `spec/`, `src/`, `tests/`, `docs/`, bibliographie, historique et décisions.
- [ ] Identifier les doublons de modèle qu'il serait dangereux d'introduire.

#### Sous-chantier figures et rendu HTML/PDF

- [x] Reproduire le défaut dans l'artefact HTML de CI : les 12 références de figures sortent de la racine à cause du double préfixe entre l'URL et le `<base href>` de Verso. La correction a été déployée ; le job GitHub Pages et la validation de l'artefact publié réussissent. Le navigateur de recherche ne permet pas un contrôle HTTP direct de la page en ligne.
- [x] Corriger la cause démontrée et valider le contrôle automatisé des images locales : [PR #124 fusionnée](https://github.com/AntheaLiles/k7pl/pull/124), CI complète verte (build Verso, contrôle HTML, PDF). Le déploiement GitHub Pages et la validation de l'artefact publié sont réussis ; `ANOM-17` peut être clos.
- [ ] Inventorier chaque figure, sa source canonique, ses sorties et sa fonction explicative.
- [ ] Définir les métadonnées minimales : objectif explicatif, alt, description longue, note de lecture, provenance et objets liés.
- [ ] Comparer sur trois figures représentatives la chaîne existante, TikZ/PGFPlots et TikZJax/isomorphic-tikzjax.
- [ ] Vérifier la transmission des métadonnées d'accessibilité au PDF et valider le fichier réellement généré.
- [ ] Décider explicitement si TikZ devient une option de création ciblée ; ne pas engager de migration globale sans bénéfice démontré.

### P1 — Cas d'usage et démonstration de valeur

- [ ] Choisir un parcours de compréhension réel et suffisamment représentatif.
- [ ] Documenter le parcours actuel dans le dépôt.
- [ ] Définir les objets et relations strictement nécessaires à ce parcours.
- [ ] Définir les critères d'évaluation avant de développer l'interface.
- [ ] Produire une première représentation navigable avec le minimum d'infrastructure.
- [ ] Comparer le parcours actuel et le parcours prototype.
- [ ] Décider explicitement si la démonstration justifie la poursuite du projet.

### P2 — Modèle documentaire et sémantique

- [ ] Définir les catégories minimales d'objets nécessaires.
- [ ] Définir les catégories minimales de relations nécessaires.
- [ ] Distinguer au minimum état courant, historique, hypothèse et preuve.
- [ ] Définir comment chaque relation conserve sa provenance.
- [ ] Déterminer ce qui doit être modélisé en Lean et ce qui doit rester dans les sources.
- [ ] Vérifier qu'aucun modèle intermédiaire ne devient une seconde source de vérité.

### P3 — Génération Verso

- [ ] Définir le point d'entrée du générateur.
- [ ] Déterminer quelles fonctionnalités peuvent être obtenues avec Verso existant.
- [ ] Développer uniquement les extensions nécessaires au prototype.
- [ ] Générer une première navigation multi-niveaux.
- [ ] Préserver les liens vers les sources canoniques.
- [ ] Ajouter les garde-fous de génération nécessaires à la CI.

### P4 — Graphe

- [ ] Définir le modèle de graphe à partir des relations sémantiques.
- [ ] Générer une première vue graphe limitée au cas d'usage démontré.
- [ ] Ajouter filtrage ou limitation de profondeur si nécessaire.
- [ ] Permettre le retour du graphe vers la vue documentaire.
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
- [ ] Une décision explicite est prise : poursuivre, réorienter ou abandonner l'industrialisation.
