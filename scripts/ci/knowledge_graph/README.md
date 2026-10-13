<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Graphe de navigation documentaire K7PL

Ce répertoire contient le générateur et le validateur du **graphe de navigation documentaire** produit à partir du HTML rendu par Verso, son catalogue d'explications éditoriales et les tests correspondants.

Le terme *graphe de navigation* est volontaire : l'artefact aide à parcourir la structure documentaire et les liens explicites. Il ne constitue pas un graphe complet de connaissances scientifiques, un graphe de preuves ou une base d'autorité parallèle.

## Chaîne de génération

1. `lake exe spec --output _out/spec --with-tex` produit le HTML multipage canonique de la spécification.
2. `build_navigation_graph.py --site _out/spec/html-multi --ref "$GITHUB_SHA"` parcourt les pages HTML rendues, à l'exclusion de `navigation/` qui est son propre répertoire de sortie.
3. Le générateur écrit `navigation/graph.json` et `navigation/index.html`, puis injecte un lien contextuel depuis chaque page HTML documentaire vers le navigateur, en transmettant la page d'origine comme point de départ.
4. `check_navigation_graph_output.py --site _out/spec/html-multi --ref "$GITHUB_SHA"` valide la cohérence de la page et du graphe générés. Le contrôle voisin `scripts/ci/check_navigation_outputs.py` vérifie également la tranche de navigation statique des figures et des graphes sémantiques.
5. Le workflow `.github/workflows/verify.yaml` orchestre la génération, la validation, l'artefact HTML et la publication GitHub Pages lorsqu'elle est demandée par l'événement de build.

Les sorties sous `navigation/` sont générées et ne doivent pas être éditées manuellement.

## Types de données réellement produits

### Nœuds

Les nœuds sont extraits des marqueurs du HTML Verso et de sa structure : pages documentaires, sections/titres, figures, tableaux, listings, énoncés, entrées bibliographiques et ancres de repli. Leur destination conserve un chemin vers la page HTML et, le cas échéant, son fragment. Le contexte textuel d'une section est un extrait borné du HTML rendu, arrêté au titre suivant ; il ne doit pas être traité comme une définition normative.

### Relations

- `contains` décrit la hiérarchie structurelle des titres et objets documentaires.
- `references` provient des liens de renvoi internes rendus explicitement par Verso.
- `cites` provient des liens de citation bibliographique rendus explicitement.

La provenance associe les relations à la page et aux éléments du lien qui les ont fait extraire. Les références internes de la portée reconnue qui ne peuvent pas être résolues font échouer la génération ; elles ne sont pas simplement supprimées.

Le générateur **n'infère pas** les relations `proves`, `implemented-by`, `tested-by`, ni un statut épistémique. Les imports Lean, les noms similaires et la proximité de fichiers ne suffisent pas à établir de telles relations.

## Rôle des fichiers

- `build_navigation_graph.py` : analyse les pages HTML, normalise les URL en tenant compte du `base href` de Verso, construit les nœuds/arêtes, rend l'interface HTML/SVG et injecte les liens de navigation de façon idempotente.
- `navigation_explanations.py` : catalogue éditorial écrit et versionné manuellement. Chaque explication déclare explicitement sa cible et fournit six niveaux de lecture avec liens vers les sources canoniques. Ce contenu est non normatif et n'ajoute pas d'arêtes au graphe.
- `check_navigation_graph_output.py` : vérifie les marqueurs de révision, les nœuds, les arêtes, les destinations, les ancres, les liens de navigation et les sources des explications.
- `test_navigation_graph.py` : tests du parseur, de la résolution des références/citations, de la navigation contextuelle et du catalogue d'explications.
- `test_navigation_graph_output.py` : tests du validateur de l'artefact publié.
- `__init__.py` : rend les tests découvrables par `python3 -m unittest discover -s scripts/ci -p 'test_*.py'`.

Le générateur de graphes sémantiques `scripts/ci/build_semantic_graph.py` est volontairement séparé : il part de plages source Verso explicites (notamment les rôles `num` et `cite`) pour publier deux vues C6/C3 bornées. Le catalogue de provenance des figures est également un mécanisme séparé. Ces mécanismes n'ont ni les mêmes entrées ni les mêmes garanties ; ce répertoire ne les fusionne pas.

## Interface et limites

L'interface interactive charge `navigation/graph.json` avec JavaScript et propose la recherche, la sélection d'un objet, un voisinage jusqu'à trois niveaux, des filtres par relation, les sources des relations et des listes textuelles alternatives au dessin SVG. Une note `noscript` prévient lorsque JavaScript est désactivé et renvoie aux documents et vues statiques disponibles ; le graphe complet n'est pas une application sans JavaScript.

Les explications progressives sont aujourd'hui rédigées pour deux cibles seulement : l'idée directrice de C1 Introduction et les distinctions grade/modalité/mode de C3. Pour tout autre nœud, l'interface indique qu'aucune explication dédiée n'est disponible et propose la source canonique au lieu de fabriquer une vulgarisation.

La génération et les tests vérifient la cohérence mécanique du HTML ; ils ne prouvent pas l'utilité pour le lecteur, l'accessibilité réelle dans un navigateur, la lisibilité sur mobile ni le bon fonctionnement du site public. Ces points restent consignés comme actions humaines dans `docs/security/ACTIONS-HUMAINES.md` et dans le plan de suivi interactif.

## Développement et validation

Depuis la racine du dépôt :

```sh
python3 -m unittest discover -s scripts/ci -p 'test_*.py'
python3 scripts/ci/knowledge_graph/build_navigation_graph.py --site _out/spec/html-multi --ref local
python3 scripts/ci/knowledge_graph/check_navigation_graph_output.py --site _out/spec/html-multi --ref local
```

Les deux commandes du générateur et du validateur supposent que la sortie HTML multipage existe déjà. En CI, `--ref` reçoit le SHA exact qui produit l'artefact, ce qui permet de détecter les sorties périmées. Ne pas substituer une sortie locale construite depuis un autre SHA à cette preuve de fraîcheur.

Voir aussi :
- [Architecture de l'enveloppe interactive](../../../docs/tracking/INTERACTIVE-EXPLORATION.md)
- [Plan fonctionnel et critères d'acceptation](../../../docs/tracking/INTERACTIVE-EXPLORATION-PLAN.md)
- [Inventaire technique](../../../docs/tracking/INTERACTIVE-EXPLORATION-INVENTORY.md)
- [Prototype et limites de validation](../../../docs/tracking/NAVIGATION-PROTOTYPE.md)
- [Modèle sémantique minimal](../../../docs/tracking/NAVIGATION-SEMANTIC-MODEL.md)
