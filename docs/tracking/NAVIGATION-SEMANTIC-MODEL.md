<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Modèle sémantique minimal pour la navigation K7PL

**Statut :** premier prototype exécuté en CI ; validation de la valeur d'usage et extension du modèle encore ouvertes.  
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

La première tranche exécutable porte sur les lignes 22–50 de `spec/Spec/C6/LeProcessusDeCompilation.lean`. Elle relie la section à sa figure explicitement référencée et aux sources bibliographiques citées dans son introduction, puis ajoute la provenance technique de la figure validée par le POC TikZ. Une seconde tranche, lignes 22–50 de `spec/Spec/C3/LeSystemeGradue.lean`, vérifie la réutilisation du générateur sur des références vers une autre section et plusieurs citations. Les deux vues se relient mutuellement ; chacune reste volontairement bornée.

Le prototype représente uniquement les arêtes `num` et `cite` présentes dans cette plage source, chacune avec un lien vers son emplacement source exact. Les labels canoniques sont résolus vers les ancres des pages HTML produites par Verso ; une ancre manquante ou ambiguë fait échouer la génération. Le graphe revient à la section rendue et expose aussi sa source Lean/Verso. La provenance figure → source TikZ → SVG/PDF est un autre type d'arête, étayé par le manifeste et la CI. Le graphe ne déduit pas que les citations sont des prémisses formelles ni que les références sont des dépendances de preuve.

Le modèle source-vers-graphe actuel reste un petit ensemble de vues C6/C3 limité à des plages source explicites. Une vue de navigation plus large peut également être produite à partir du HTML Verso rendu : elle expose les catégories structurelles et les liens visibles, mais n'est pas un inventaire exhaustif de toutes les relations scientifiques. La plage C3 n'est pas représentative de toutes les références de la section.

## 6. Génération et validation

Le graphe doit être construit au moment du build depuis les sources existantes. Aucun fichier JSON/YAML manuel ne doit devenir une deuxième source de vérité pour les références déjà exprimées dans Verso. Un éventuel mécanisme d'annotation pour les relations absentes ne sera introduit qu'après identification d'un cas concret et avec une provenance explicite.

Critères d'acceptation du premier prototype :

- [x] les nœuds ont des identifiants stables fondés sur les labels et les clés bibliographiques, indépendants de leur numéro de présentation ;
- [x] chaque arête explicite conserve le fichier, la ligne et le label ou la clé source ;
- [x] les références non résolues sont signalées et ne deviennent pas des liens inventés ;
- [x] les citations restent distinctes des références à des objets de la spécification ;
- [x] la vue retourne à la source canonique et à la page documentaire rendue ;
- [x] les tests couvrent les labels sources absents, les références/citations non résolues, plusieurs clés bibliographiques dans une citation et les ancres manquantes ;
- [x] le prototype n'ajoute aucune dépendance d'exécution au site publié ;
- [ ] une revue humaine confirme que la vue aide à comprendre les relations sans exagérer leur portée.

## 7. Explications progressives dans l’interface

Les textes de lecture graduée constituent une couche éditoriale distincte des arêtes du graphe. Leur catalogue est tenu dans [`navigation_explanations.py`](../../scripts/ci/navigation_explanations.py) : chaque entrée indique son nœud cible et fournit, pour chaque niveau, des liens vers les ancres Verso canoniques. Le catalogue ne crée aucune relation entre objets et ne modifie ni le statut normatif ni le statut de preuve des sources. Le validateur vérifie que les nœuds cibles, textes de niveau et destinations HTML/ancres existent. Lorsqu’aucune entrée ne cible un objet, l’interface le signale au lieu d’inventer une explication.

La couverture initiale est volontairement limitée au point d’entrée « Introduction » de C1. Elle démontre le mécanisme, sans prétendre que l’ensemble des concepts K7PL bénéficie déjà de niveaux rédigés ou validés humainement.

## 8. Hors périmètre explicite

Ce modèle ne prétend pas encore relier formellement les propositions Lean aux implémentations et aux tests. Cette relation doit être recherchée dans les annotations et conventions existantes ; elle ne doit pas être supposée. L'accessibilité PDF/UA des figures reste un chantier distinct.

## 9. Audit de traçabilité et limite du prototype — 11 octobre 2026

Le générateur courant fait trois choses distinctes et ne doit pas les fusionner :

1. `references` est extrait d'un rôle Verso `num` vers un label résolu dans les déclarations canoniques ; la provenance conservée est le fichier source, la ligne, le label cible, le fichier et la ligne de la déclaration.
2. `cites` est extrait d'un rôle Verso `cite` vers une clé existante de `docs/bibliography/references.json` ; la provenance est la ligne de citation et la clé bibliographique.
3. La chaîne figure → source TikZ → rendu SVG/PDF → renderer/workflow est une **provenance de génération**, fondée sur la correspondance exacte `canonical_verso` du manifeste et sur les étapes de build CI. Elle ne signifie pas que le code du renderer démontre une propriété de la figure.

La vue C6/C3 ne produit pas d'arêtes `imports`, `tested-by` ou `implemented-by`. La simple présence d'une commande `import`, d'un fichier de test au nom similaire, d'une citation ou d'un objet voisin n'est pas suffisante pour inférer un lien scientifique. Les dépendances structurelles éventuelles devront être conservées dans une catégorie distincte et explicitement typées ; elles ne font pas partie des arêtes scientifiques actuelles.

Le contrôle de sortie ajouté à la CI vérifie que les trois pages existent, qu'elles portent la révision attendue, que chaque lien local cible un fichier existant et que toute ancre HTML locale ciblée apparaît une seule fois. Les liens GitHub `blob` sont contrôlés contre la révision du build, le chemin canonique existant et, lorsqu'un fragment `L<n>` est présent, les lignes réellement disponibles. Des tests négatifs couvrent la cible Verso absente, la référence/citation non résolue, l'ancre rendue absente, les liens/ancres locaux cassés et la sortie périmée. Ces contrôles valident la cohérence mécanique des liens, non la pertinence scientifique d'une relation.

La couche de validation d'une arête (extraite, passée dans la CI, revue par une personne) reste orthogonale au statut épistémique du contenu visé (proposition, hypothèse, résultat publié, preuve). La CI ne peut pas accorder une validation humaine.

Le choix de phase est **réorienter** : ne pas étendre le modèle à définition → théorème → preuve → implémentation → test avant résultat positif de la comparaison d'usage du prototype étroit et avant identification de relations explicites ou de métadonnées canoniques capables de les attester.


## 10. Contrat d’affichage du contexte — 13 octobre 2026

Le panneau « Texte rendu disponible » ne doit pas se limiter au titre d’une section lorsqu’un contexte rédactionnel immédiat est disponible. Le générateur extrait désormais les paragraphes qui suivent le titre jusqu’au titre suivant, avec une longueur maximale ; il ne présente pas le texte d’une sous-section comme contexte de sa section parente. Cet extrait est une aide à l’orientation tirée du HTML rendu : ce n’est ni une définition formellement identifiée, ni une relation du graphe, ni une attestation du statut épistémique de l’objet. Le lien vers la source documentaire canonique reste indispensable.

La vue SVG positionne maintenant tous les niveaux sélectionnés, de 1 à 3. La limite de voisinage à 24 nœuds demeure volontaire : le rendu peut être tronqué, tandis que la liste et les relations textuelles continuent de fournir une navigation alternative. Les tests de régression couvrent l’arrêt de l’extrait au prochain titre et la prise en charge du troisième niveau.

Ces corrections améliorent le comportement de l’interface ; elles ne ferment pas la revue humaine de sa valeur, la vérification du site public sur navigateur mobile/clavier ni le protocole comparatif d’utilisabilité.
