<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Enveloppe interactive de présentation et d'exploration de K7PL

**Statut :** projet architectural proposé  
**Date :** 2026-10-08  
**Audience :** chercheurs, contributeurs, reviewers et lecteurs de K7PL.

## Intention

K7PL assume une complexité importante : spécification, formalisation, implémentation, preuves, tests, documentation, bibliographie, notes de recherche, décisions et historique constituent un ensemble de connaissances fortement interconnectées.

Cette complexité ne doit ni être masquée ni artificiellement simplifiée. Le projet doit en revanche rendre cette complexité explorable et intelligible.

L'objectif est donc d'étudier puis de construire une **enveloppe interactive de présentation et d'exploration de K7PL**, fondée sur Lean et Verso, qui permette de naviguer entre les différents niveaux du projet, d'en comprendre les relations et, lorsque cela est pertinent, d'interagir avec certains artefacts.

Ce projet ne vise pas une migration globale de Markdown vers MDX. Markdown et GitHub restent des supports canoniques de documentation, de collaboration et de versionnement. L'enveloppe interactive constitue une couche de présentation et d'exploration au-dessus des sources existantes.

## Principe architectural

Lean doit être étudié comme un langage permettant de transformer un **modèle documentaire et sémantique formel** en une représentation navigable du projet.

Il ne s'agit pas de développer un framework web généraliste en Lean. Il s'agit d'exploiter les structures déjà présentes dans K7PL pour produire, avec Verso et ses extensions, une représentation connaissant les objets et relations propres au projet.

Le modèle cible est :

    K7PL
      ├── spec/                  formalisation normative
      ├── src/                   implémentation
      ├── tests/                 vérification comportementale
      ├── docs/                  documentation et assurance
      ├── bibliographie          sources scientifiques
      └── historique / décisions provenance
                │
                ▼
        modèle documentaire
          et sémantique
                │
                ▼
       transformation en Lean
                │
                ▼
          Verso + générateur
                │
        ┌───────┼────────┐
        ▼       ▼        ▼
      lecture navigation graphe
        │       │        │
        └───────┼────────┘
                ▼
        compréhension /
        exploration

Le site ne devient pas une nouvelle source de vérité : il rend navigables les relations entre les sources canoniques.

## Finalité scientifique et pédagogique

Le projet répond à un besoin à la fois externe et interne. Un lecteur doit pouvoir comprendre un projet complexe sans que la vulgarisation détruise les distinctions importantes ; l'auteur doit également pouvoir étudier K7PL sans être contraint de reconstruire mentalement ses relations à partir d'une multitude de fichiers.

L'interactivité recherchée est donc principalement **épistémique**. Elle doit aider à répondre à des questions comme :

- pourquoi cet objet existe-t-il ?
- à quelle notion ou décision est-il rattaché ?
- quelle source le justifie ?
- quelle formalisation lui correspond ?
- quelles propriétés sont prouvées ?
- quelle implémentation ou quel test lui est associé ?
- quelles limites ou incertitudes lui sont attachées ?

Un parcours cible est par exemple :

    énoncé
      → définition
      → documentation
      → décision
      → source bibliographique
      → preuve ou propriété
      → implémentation
      → test

Le parcours inverse doit également être possible lorsque les relations sont disponibles.

## Vue graphe

Le site pourra proposer une vue du graphe de connaissance, inspirée des usages de Logseq, Roam ou Obsidian, mais adaptée aux objets scientifiques et formels de K7PL.

Cette vue ne doit pas être un simple graphe de fichiers. Elle doit pouvoir représenter des relations sémantiques telles que :

    définition ──utilisée par──→ théorème
         │
         ├──justifiée par──→ source
         ├──documentée par──→ note
         ├──liée à──→ décision
         ├──implémentée par──→ code
         └──vérifiée par──→ test

Le graphe est un mode d'exploration complémentaire, pas nécessairement le mode principal de lecture.

## Niveaux de présentation

L'enveloppe devra pouvoir offrir plusieurs profondeurs de lecture :

1. **Introduction** — pourquoi l'objet existe et à quel problème il répond.
2. **Vue conceptuelle** — notions et relations essentielles.
3. **Vue détaillée** — définitions, dépendances et décisions.
4. **Formalisation** — artefacts Lean/Verso concernés.
5. **Preuves et vérifications** — propositions, preuves, tests et résultats disponibles.
6. **Sources et provenance** — bibliographie, notes, historique et décisions.

Chaque niveau doit pouvoir renvoyer vers la source canonique correspondante.

## GitHub et enveloppe interactive

GitHub reste la plateforme native de versionnement, contribution, revue, discussion et consultation des sources.

L'enveloppe interactive a une fonction différente :

> GitHub expose principalement comment le projet est construit ; l'enveloppe interactive doit faciliter la compréhension de la manière dont les artefacts du projet sont reliés.

Les deux représentations doivent rester liées et ne pas diverger sémantiquement.

## Démonstration de valeur

Aucune infrastructure complète ne doit être construite avant une démonstration de valeur.

Le premier cas devra partir d'un parcours réel aujourd'hui difficile, par exemple :

> partir d'un élément de la spécification, comprendre pourquoi il existe, identifier les concepts dont il dépend, retrouver sa justification, les décisions associées, les matériaux documentaires pertinents et les éléments de vérification disponibles.

Le prototype devra comparer le parcours actuel dans le dépôt avec le parcours rendu possible par l'enveloppe.

Le critère principal est la **qualité de compréhension obtenue**, et non le nombre de fonctionnalités graphiques.

## Contraintes architecturales

- Markdown reste un format documentaire canonique lorsqu'il est approprié.
- GitHub reste la surface native de contribution et de revue.
- Lean ne doit pas devenir un framework web généraliste.
- Le site doit être régénérable à partir du dépôt.
- Les informations présentées doivent rester traçables vers leurs sources.
- Une génération interactive ne doit pas créer une seconde base documentaire divergente.
- Les futurs implémentations et tests doivent pouvoir rejoindre le modèle sans refonte conceptuelle.
- La complexité du projet doit être rendue navigable, pas supprimée.
- MDX n'est pas un objectif architectural ; il ne sera retenu que si un besoin démontré le justifie.

## Questions de recherche-développement

Le projet doit notamment déterminer :

1. quelles structures de K7PL constituent déjà un modèle documentaire ou sémantique exploitable ;
2. ce que Verso fournit déjà pour construire cette enveloppe ;
3. quelles extensions peuvent être réalisées proprement dans l'écosystème Lean/Verso ;
4. quelles informations doivent être explicitement modélisées pour rendre les relations navigables ;
5. quelles interactions apportent réellement une valeur épistémique ;
6. comment représenter le graphe sans réduire le projet à un graphe de fichiers ;
7. comment préserver provenance, statut et niveau de preuve dans la présentation ;
8. comment mesurer le gain réel de compréhension.

## Hors périmètre initial

Le projet ne comprend pas initialement :

- la migration générale de `.md` vers `.mdx` ;
- la réécriture de GitHub ou de son wiki ;
- le développement d'un framework web généraliste ;
- la modélisation exhaustive de tous les artefacts K7PL ;
- une visualisation graphique pour chaque type de document ;
- la production d'une seconde source documentaire indépendante.

La première étape est un prototype ciblé, évalué sur un parcours de compréhension réel.
