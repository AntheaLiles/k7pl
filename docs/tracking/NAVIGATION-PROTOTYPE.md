<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Prototype de navigation — provenance des figures

**Statut :** première tranche verticale en validation CI.  
**Périmètre :** navigation de provenance des figures, et non graphe sémantique général.

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

- [ ] Le build complet génère la page et toutes ses cibles d'ancrage.
- [ ] Les douze figures déclarées sont recensées sans entrée inventée ni source manquante.
- [ ] Chaque figure mène à sa déclaration et à sa source graphique canonique ; les rendus existants sont accessibles.
- [ ] Le lien depuis la figure et le retour vers le rendu fonctionnent dans le site publié.
- [ ] Le catalogue reste lisible sur mobile, au clavier et sans dépendance JavaScript.
- [ ] Une revue humaine confirme l'utilité du parcours par rapport à l'ouverture manuelle des fichiers.
- [ ] Le parcours est réversible : depuis le catalogue, on revient à la source canonique puis à la page de spécification.

## Étape suivante

Après validation de cette tranche, choisir un deuxième parcours qui traverse des objets sémantiques — par exemple définition, théorème, preuve et test — et vérifier que chaque relation est explicitement étayée par les sources. Ne pas transformer le catalogue de figures en graphe de connaissances par simple extension des liens de fichiers.
