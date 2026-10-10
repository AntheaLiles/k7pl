<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Modèle sémantique minimal pour la navigation K7PL

**Statut :** proposition de conception, à valider par un prototype dérivé.  
**Périmètre immédiat :** références explicites de la spécification et citations ; aucune relation vers l'implémentation ou les tests n'est inventée.

## 1. Principes

Le graphe est une vue dérivée des sources canoniques, pas une base de données à maintenir en parallèle. Chaque nœud et chaque arête doivent être traçables vers une déclaration, une référence explicite, une dépendance de build ou un résultat de validation.

Trois distinctions sont impératives :

- **Relation explicite** : le texte source référence un label ou une clé bibliographique, par exemple avec le rôle Verso `num` ou `cite`.
- **Relation structurelle** : un objet appartient à une section ou un module, ou un module importe un autre module. Elle décrit l'organisation du dépôt, pas une justification scientifique.
- **Provenance de génération** : une source graphique produit un artefact, ou une déclaration Verso référence un rendu validé par la CI. Elle décrit la chaîne de production, pas une relation conceptuelle.

La proximité de deux objets dans un fichier, un nom ressemblant ou un import indirect ne suffit jamais à créer une relation sémantique.

## 2. Identité des nœuds

| Type | Identifiant candidat | Source canonique |
|---|---|---|
| Section ou objet étiqueté | label Verso stable, préfixé par son espace de noms | déclaration Lean/Verso portant le label |
| Figure, tableau, formule, listing | label Verso ; asset comme attribut secondaire | déclaration Verso et source graphique |
| Citation bibliographique | clé bibliographique stable | base bibliographique du dépôt |
| Module ou fichier | chemin relatif au dépôt | fichier versionné |
| Test | chemin du test et, si nécessaire, identifiant du test | fichier de test |
| Artefact généré | chemin de sortie et type d'artefact | source + recette de build |

Un numéro affiché dans le document (par exemple « 3.2 ») n'est pas un identifiant stable : il dépend de l'ordre et de la structure du document. Les labels et chemins canoniques doivent servir d'identité ; les numéros sont des propriétés de présentation.

## 3. Types d'arêtes initiaux

| Relation | Source de preuve | Sens affiché |
|---|---|---|
| `references` | rôle Verso `num` avec label cible | le texte pointe explicitement vers un objet |
| `cites` | rôle Verso `cite` avec clé bibliographique | le texte cite une source |
| `declared-in` | emplacement de la déclaration dans un fichier | l'objet est déclaré dans ce fichier |
| `renders-to` | déclaration de figure et nom d'asset | la figure utilise ce rendu |
| `generated-from` | manifeste source + génération vérifiée en CI | l'artefact est produit depuis cette source |
| `imports` | commande Lean `import` | un module dépend d'un autre module |
| `tested-by` | association explicite à un test, si elle existe | un objet est couvert par ce test |

Les relations `references` et `cites` sont des références documentaires explicites, pas des preuves de dépendance logique. `imports` décrit une dépendance de compilation, pas une justification. `tested-by` ne sera pas produit par heuristique sur les noms de fichiers : si aucune association explicite et vérifiable n'existe, le graphe doit l'indiquer comme indisponible plutôt que l'inventer.

## 4. Provenance et validation des arêtes

Chaque arête doit conserver au minimum :

- un identifiant source et un identifiant cible ;
- un type de relation ;
- une provenance : chemin et ligne, label, clé bibliographique ou manifeste de build ;
- une base de relation : explicite, structurelle ou issue d'une génération ;
- un état de validation : extraite, validée par la CI ou revue humainement.

Le statut épistémique d'une proposition (théorème, conjecture, hypothèse, résultat de littérature) est une propriété distincte de l'état de validation d'une arête. Ces deux dimensions ne doivent pas être fusionnées dans un badge unique.

Si la provenance ne peut pas être retrouvée, l'arête ne doit pas être affichée comme fait. Une relation manquante est préférable à une relation plausible mais non démontrée.

## 5. Première tranche sémantique proposée

Après le catalogue de provenance des figures, la prochaine tranche peut porter sur les références explicites et les citations d'une section existante, par exemple `sec:c3-le-systeme-gradue` dans `spec/Spec/C3/LeSystemeGradue.lean`. Cette section contient des références `num` vers des sections et un théorème, ainsi que des citations `cite` vers des clés bibliographiques.

Le prototype doit représenter uniquement ces arêtes explicites, chacune avec un lien vers son emplacement source. Il ne doit pas déduire que les références citées sont des prémisses formelles, ni que les théorèmes référencés sont des dépendances de preuve. Le résultat sera une vue locale, navigable dans les deux sens, et non encore un graphe exhaustif de K7PL.

## 6. Génération et validation

Le graphe doit être construit au moment du build depuis les sources existantes. Aucun fichier JSON/YAML manuel ne doit devenir une deuxième source de vérité pour les références déjà exprimées dans Verso. Un éventuel mécanisme d'annotation pour les relations absentes ne sera introduit qu'après identification d'un cas concret et avec une provenance explicite.

Critères d'acceptation du premier prototype :

- [ ] les nœuds ont des identifiants stables indépendants de leur numéro de présentation ;
- [ ] chaque arête explicite conserve le fichier, la ligne et le label ou la clé source ;
- [ ] les références non résolues sont signalées et ne deviennent pas des liens inventés ;
- [ ] les citations restent distinctes des références à des objets de la spécification ;
- [ ] la vue retourne à la source canonique et à la vue documentaire ;
- [ ] les tests couvrent les labels manquants, les références non résolues, les citations multiples et les ancres ;
- [ ] le prototype n'ajoute aucune dépendance d'exécution au site publié ;
- [ ] une revue humaine confirme que la vue aide à comprendre les relations sans exagérer leur portée.

## 7. Hors périmètre explicite

Ce modèle ne prétend pas encore relier formellement les propositions Lean aux implémentations et aux tests. Cette relation doit être recherchée dans les annotations et conventions existantes ; elle ne doit pas être supposée. L'accessibilité PDF/UA des figures reste un chantier distinct.
