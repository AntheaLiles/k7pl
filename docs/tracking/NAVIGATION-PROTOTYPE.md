<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Prototype de navigation — provenance des figures et relations documentaires

**Statut :** les catalogues statiques de provenance et le graphe de navigation HTML sont générés et contrôlés en CI ; les tests humains et la comparaison d'usage restent ouverts.  
**Périmètre :** provenance technique des figures et navigation documentaire dérivée du HTML. Les graphes sémantiques C6/C3 restent des vues distinctes et bornées ; aucun graphe de preuve général n’est revendiqué.

## Cas d'usage retenu

Un lecteur rencontre une figure dans la spécification et veut répondre à quatre questions sans fouiller manuellement le dépôt :

1. où cette figure est-elle déclarée dans Verso ?
2. quelle source graphique la produit ou la maintient ?
3. quels rendus HTML/SVG et PDF sont publiés ?
4. quel code et quelle validation de CI interviennent dans leur production ?

Ce cas est volontairement plus étroit que le parcours cible « énoncé → définition → justification → preuve → implémentation → test ». Il repose sur des relations déjà vérifiables dans le dépôt et permet de tester la navigation aller-retour sans inventer de liens conceptuels. Il ne suffit donc pas, à lui seul, à démontrer la valeur du futur graphe de connaissance.

## Comportement du prototype

Chaque figure de la spécification expose un lien « Sources et rendus ». Il ouvre un catalogue HTML statique, généré pendant le build, qui recense les déclarations de figures trouvées dans le répertoire spec/Spec.

Pour chaque déclaration, le catalogue relie :
- l'emplacement exact de la déclaration Verso ;
- le fichier source graphique canonique : le manifeste TikZ pour les trois figures réimplémentées, ou le fichier draw.io homonyme pour les autres ;
- le SVG publié et, lorsqu'il existe, le PDF ;
- le renderer tools/SpecExt/Float.lean, le workflow de CI et le manifeste de sources TikZ.

Les liens vers GitHub sont épinglés à la révision ayant produit la page. Le catalogue utilise seulement HTML/CSS natifs : pas de bibliothèque JavaScript, de service distant ou de dépendance d'exécution supplémentaire. Les vignettes restent des liens vers les SVG complets.

## Source de vérité et limites

Le catalogue est un artefact dérivé, jamais édité manuellement. Il extrait le label, le nom d'asset et le texte alternatif des déclarations Verso. Les sources graphiques restent canoniques dans leurs formats respectifs ; le manifeste TikZ ne décrit que les correspondances nécessaires à la génération des trois figures TikZ.

Le générateur échoue si une déclaration ne fournit pas label, asset ou texte alternatif, si une source canonique ou un SVG manque, ou si les labels/noms d'assets sont dupliqués. Le contrôle HTML de CI vérifie également les images locales de la page générée.

Ce catalogue représente la **provenance technique des figures**. Il n'affirme pas que deux concepts sont sémantiquement liés parce qu'ils apparaissent dans le même fichier ou dans une même figure. Les relations entre définitions, théorèmes, preuves, implémentations et tests nécessiteront un modèle séparé, avec provenance et statut épistémique explicites.

## Critères de validation

- [x] Le build complet génère la page et les ancres des 12 figures (CI verte).
- [x] Les douze figures déclarées sont recensées sans entrée inventée ni source manquante (génération CI réussie).
- [x] Le catalogue produit les liens vers la déclaration, la source graphique canonique et les rendus disponibles ; les SVG locaux sont validés par la CI.
- [ ] Le lien depuis la figure et le retour vers le rendu fonctionnent dans le site publié.
- [ ] Le catalogue reste lisible sur mobile, au clavier et sans dépendance JavaScript.
- [ ] Une revue humaine confirme l'utilité du parcours par rapport à l'ouverture manuelle des fichiers.
- [x] La réversibilité du HTML généré est contrôlée : le catalogue renvoie vers l'ancre unique de la page documentaire et le validateur CI refuse les ancres absentes ou ambiguës (PR #150, run #38093986701). Le test du site public dans un navigateur reste ouvert.

## Étape suivante

Après validation de cette tranche, choisir un deuxième parcours qui traverse des objets sémantiques — par exemple définition, théorème, preuve et test — et vérifier que chaque relation est explicitement étayée par les sources. Ne pas transformer le catalogue de figures en graphe de connaissances par simple extension des liens de fichiers.

## Comparaison falsifiable à mener avant d'étendre le prototype

Aucune session utilisateur n'est consignée à ce jour. Les contrôles statiques imposés par la CI (voir le [plan](INTERACTIVE-EXPLORATION-PLAN.md), « Portes ouvertes de la navigation ») ne permettent donc pas de revendiquer une réduction du temps de recherche, une meilleure compréhension ou un gain pédagogique. Le protocole suivant doit être enregistré avant la première session, puis appliqué sans modifier les critères en fonction des résultats.

**Tâche unique.** Partir de la figure du processus de compilation (`fig:comp-process`) dans la page rendue C6. Retrouver, consigner et justifier par liens six éléments : (1) déclaration `spec/Spec/C6/LeProcessusDeCompilation.lean`, ligne exacte ; (2) source graphique canonique `spec/figures/tikz/compilation-pipeline.tex` ; (3) sorties `spec/figures/compilation-process.svg` et PDF si présent ; (4) renderer `tools/SpecExt/Float.lean` ; (5) workflow de validation `.github/workflows/verify.yaml` ; (6) retour vers la figure précise de la page documentaire rendue. Une réponse est correcte seulement si le chemin/identifiant et la destination concordent avec la source, et non parce que le nom de fichier semble plausible.

**Conditions comparées.** Recruter huit lecteurs qui n'ont pas construit le prototype et ne connaissent pas ce sous-parcours ; affecter aléatoirement quatre personnes à chaque condition. Condition A : départ dans la page documentaire puis recherche manuelle dans le dépôt GitHub et ses fichiers. Condition B : départ sur la même figure puis utilisation du lien « Sources et rendus », du catalogue et du retour documentaire du prototype. Une seule condition par personne évite qu'un premier essai enseigne le chemin à utiliser lors du second. Le résultat restera exploratoire : huit personnes ne donnent pas une base pour généraliser à tous les lecteurs de K7PL.

**Mesures à enregistrer pour chaque session.** Temps entre l'affichage de la figure et la remise des six éléments avec retour correct ; nombre de transitions entre pages/fichiers ; ouverture de sources incorrectes ou homonymes ; réponses exactes/incomplètes ; demandes d'aide ; retour au mauvais objet ou absence de retour. Définir avant les sessions ce qui constitue une réponse exacte, utiliser le même délai maximal de cinq minutes et ne pas aider avant la fin du délai. Consigner les résultats individuels anonymisés et les écarts de protocole, pas seulement une moyenne.

**Règle de décision préenregistrée.** Ne poursuivre la tranche de provenance que si l'exactitude n'est pas inférieure à celle du parcours manuel et si la médiane du temps parmi les réussites baisse d'au moins 20 %, ou si le taux d'achèvement exact s'améliore d'au moins 25 points de pourcentage sans augmentation des erreurs de sélection de source. Si ces conditions ne sont pas satisfaites, arrêter l'extension fonctionnelle et conserver seulement les liens qui auront une utilité démontrée. Ces seuils sont une règle locale de décision de projet, pas un seuil statistique publié ni une preuve de significativité. Publier aussi les temps bruts, les échecs et les cas où le parcours manuel est plus rapide.

**Décision provisoire de phase : RÉORIENTER.** Garder le catalogue étroit de provenance et ses contrôles de traçabilité ; suspendre toute augmentation du graphe jusqu'à la comparaison ci-dessus. Le bénéfice d'usage n'est pas encore démontré. La tranche a un coût de maintenance réduit (HTML statique et aucun JavaScript d'exécution), mais cette faible complexité ne suffit pas à établir son utilité.

## Limites d'interprétation

Le graphe C6/C3 formalise uniquement des rôles `num`/`cite` explicites sur deux plages de texte fixées, plus une chaîne de génération technique documentée par le manifeste TikZ et la CI. Une citation ne devient pas une prémisse ; une référence Verso ne devient pas une dépendance de preuve ; un import ne devient pas une justification scientifique. Aucun lien `tested-by` ou `implemented-by` n'est produit par heuristique. Le parcours « définition → théorème → preuve → implémentation → test » reste une tranche future séparée, bloquée tant que la valeur du prototype présent et l'attestation de chaque relation requise ne sont pas établies.


## Couverture du navigateur relationnel — état au 13 octobre 2026

Le générateur `scripts/ci/navigation_graph/build_navigation_graph.py` parcourt les fichiers HTML rendus sous le répertoire de sortie Verso, à l'exclusion du sous-répertoire `navigation/` qu'il produit lui-même. Il ajoute une entrée contextuelle à chaque page documentaire rendue, avec un paramètre qui transmet la page de départ. Cette boucle porte sur l'ensemble des sorties HTML générées, donc sur les pages des chapitres présents au build ; elle ne constitue pas la preuve qu'une URL publique donnée a été ouverte et testée.

Le graphe est lui aussi dérivé de l'ensemble de ces pages. Il représente les pages, titres/sections, figures, tableaux, listings, énoncés et entrées bibliographiques reconnus par les marqueurs HTML existants. Les arêtes `contains` décrivent la hiérarchie documentaire ; `references` et `cites` viennent de liens explicites rendus. Le générateur échoue lorsqu'une référence interne de cette portée ne peut pas être résolue. Il n'infère toujours pas de relations de preuve, d'implémentation ou de test.

Il faut distinguer la couverture de navigation de la couverture éditoriale progressive :
- l'entrée de navigation et la possibilité de rechercher/sélectionner des objets sont produites pour l'ensemble des pages HTML rendues ;
- les explications en six niveaux sont rédigées manuellement et attachées seulement aux cibles inscrites dans `scripts/ci/navigation_graph/navigation_explanations.py` ;
- sur `main` (PR #208), deux entrées disposent de ces explications : l'idée directrice de C1 Introduction et les distinctions grade/modalité/mode de C3 ;
- pour les autres objets, l'interface doit annoncer l'absence d'une explication dédiée et proposer le retour à la source canonique. Elle ne génère pas de vulgarisation à partir des seules arêtes.

Le graphe interactif requiert JavaScript pour charger `navigation/graph.json`. Les pages Verso, le catalogue de figures et les vues sémantiques statiques restent disponibles comme solutions de navigation distinctes ; elles ne constituent pas une version sans JavaScript du graphe complet. La liste des objets et des relations fournit une alternative textuelle au dessin SVG, mais l'accessibilité et l'utilité doivent encore être évaluées sur le site publié, au clavier et sur mobile.

### Contrat du code

- `build_graph` extrait les nœuds et les trois catégories d'arêtes autorisées à partir des pages rendues ; il exclut les sorties de navigation générées pour éviter l'auto-alimentation.
- `normalize_target` applique la résolution d'URL de Verso, y compris le `base href` et les destinations de type répertoire lorsqu'un `index.html` existe.
- `section_context` extrait un contexte textuel borné pour une section, jusqu'au titre suivant ; ce texte n'est ni une définition normativement identifiée ni une relation sémantique.
- `resolve_authored_explanations` rattache uniquement les explications explicitement cataloguées à leurs destinations HTML canoniques.
- `inject_navigation_link` ajoute le point d'entrée de manière idempotente à chaque page rendue.
- [`check_navigation_graph_output.py`](../../scripts/ci/navigation_graph/check_navigation_graph_output.py) et ses tests contrôlent notamment les ancres, liens, nœuds, arêtes, marqueurs de fraîcheur et renvois des explications.

Le contrat technique du composant, ses limites et ses commandes de validation sont décrits dans [scripts/ci/navigation_graph/README.md](../../scripts/ci/navigation_graph/README.md). Les docstrings et commentaires du générateur explicitent également les contrats principaux. Ce travail de documentation n'implique pas que chaque comportement visuel ait été validé humainement.
