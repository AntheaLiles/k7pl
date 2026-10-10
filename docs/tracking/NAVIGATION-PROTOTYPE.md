<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Prototype de navigation — provenance des figures

**Statut :** catalogue généré en CI et déployé sur GitHub Pages ; comparaison d'usage et revue humaine encore ouvertes.  
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

- [x] Le build complet génère la page et les ancres des 12 figures (CI verte).
- [x] Les douze figures déclarées sont recensées sans entrée inventée ni source manquante (génération CI réussie).
- [x] Le catalogue produit les liens vers la déclaration, la source graphique canonique et les rendus disponibles ; les SVG locaux sont validés par la CI.
- [ ] Le lien depuis la figure et le retour vers le rendu fonctionnent dans le site publié.
- [ ] Le catalogue reste lisible sur mobile, au clavier et sans dépendance JavaScript.
- [ ] Une revue humaine confirme l'utilité du parcours par rapport à l'ouverture manuelle des fichiers.
- [ ] Le parcours est réversible : depuis le catalogue, on revient à la source canonique puis à la page de spécification.

## Étape suivante

Après validation de cette tranche, choisir un deuxième parcours qui traverse des objets sémantiques — par exemple définition, théorème, preuve et test — et vérifier que chaque relation est explicitement étayée par les sources. Ne pas transformer le catalogue de figures en graphe de connaissances par simple extension des liens de fichiers.

## Audit statique de l'artefact publié — 11 octobre 2026

Le point de départ vérifiable est le commit `5d437c52dc7204dce03794af127c86c8f9970067` de `main`, construit par le run CI [#38092815528](https://github.com/AntheaLiles/k7pl/actions/runs/38092815528). Le job « Spécification Verso » et le job « Publication GitHub Pages » ont terminé avec succès. L'artefact `github-pages` associé (ID `11684802525`) a été récupéré puis inspecté localement ; il contient 67 pages HTML, dont les trois pages de navigation.

Sur le seul sous-ensemble des trois pages générées, l'analyse statique a suivi 53 liens locaux : aucun fichier ciblé manquant et aucune ancre HTML ciblée non résolue. En inspectant également les 67 pages et leur `<base href>` relatif, les 12 figures possèdent chacune exactement un lien d'entrée vers la bonne carte du catalogue. Les liens sources GitHub des pages étaient épinglés au SHA du build. Les trois pages n'utilisent pas de balise `script` ; les interactions concernées sont des liens HTML natifs. Le catalogue contient une règle CSS responsive à 560 px ; les graphes conservent une zone défilable horizontalement pour le SVG large. Ce constat établit une propriété des fichiers générés, pas une validation par navigateur ni une mesure d'utilisabilité.

**Limite du test de déploiement.** L'artefact chargé depuis Actions est celui remis au job Pages ; cela ne prouve pas, à lui seul, que chaque URL publique répond actuellement correctement. La consultation directe du site et l'ouverture de ses fichiers dans un navigateur de test ont été bloquées dans cette session. Le parcours réel sur le domaine publié, l'usage clavier, l'affichage mobile effectif et le test explicite avec JavaScript désactivé restent donc à vérifier par une personne disposant d'un navigateur fonctionnel. L'absence de script dans ces trois pages et leurs liens natifs rendent le mode sans JavaScript plausible, mais ne remplacent pas l'essai réel.

L'audit a détecté un défaut de réversibilité dans l'artefact courant : le catalogue proposait la déclaration canonique, la source graphique et les rendus, mais pas de lien direct vers l'ancre de la figure dans la page documentaire rendue. Le correctif proposé dans la [PR #150](https://github.com/AntheaLiles/k7pl/pull/150) ajoute ce retour et fait échouer le build si le label de la figure ne correspond pas à une unique ancre rendue. Ce lien n'est pas présent dans l'artefact `main` inspecté ci-dessus ; il ne sera tenu pour publié qu'après fusion autorisée et nouveau déploiement réussi.

## Comparaison falsifiable à mener avant d'étendre le prototype

Aucune session avec utilisateur n'a été menée pour ce compte rendu. Les mesures statiques ci-dessus ne permettent donc pas de revendiquer une réduction du temps de recherche, une meilleure compréhension ou un gain pédagogique. Le protocole suivant doit être enregistré avant la première session, puis appliqué sans modifier les critères en fonction des résultats.

**Tâche unique.** Partir de la figure du processus de compilation (`fig:comp-process`) dans la page rendue C6. Retrouver, consigner et justifier par liens six éléments : (1) déclaration `spec/Spec/C6/LeProcessusDeCompilation.lean`, ligne exacte ; (2) source graphique canonique `spec/figures/tikz/compilation-pipeline.tex` ; (3) sorties `spec/figures/compilation-process.svg` et PDF si présent ; (4) renderer `tools/SpecExt/Float.lean` ; (5) workflow de validation `.github/workflows/verify.yaml` ; (6) retour vers la figure précise de la page documentaire rendue. Une réponse est correcte seulement si le chemin/identifiant et la destination concordent avec la source, et non parce que le nom de fichier semble plausible.

**Conditions comparées.** Recruter huit lecteurs qui n'ont pas construit le prototype et ne connaissent pas ce sous-parcours ; affecter aléatoirement quatre personnes à chaque condition. Condition A : départ dans la page documentaire puis recherche manuelle dans le dépôt GitHub et ses fichiers. Condition B : départ sur la même figure puis utilisation du lien « Sources et rendus », du catalogue et du retour documentaire du prototype. Une seule condition par personne évite qu'un premier essai enseigne le chemin à utiliser lors du second. Le résultat restera exploratoire : huit personnes ne donnent pas une base pour généraliser à tous les lecteurs de K7PL.

**Mesures à enregistrer pour chaque session.** Temps entre l'affichage de la figure et la remise des six éléments avec retour correct ; nombre de transitions entre pages/fichiers ; ouverture de sources incorrectes ou homonymes ; réponses exactes/incomplètes ; demandes d'aide ; retour au mauvais objet ou absence de retour. Définir avant les sessions ce qui constitue une réponse exacte, utiliser le même délai maximal de cinq minutes et ne pas aider avant la fin du délai. Consigner les résultats individuels anonymisés et les écarts de protocole, pas seulement une moyenne.

**Règle de décision préenregistrée.** Ne poursuivre la tranche de provenance que si l'exactitude n'est pas inférieure à celle du parcours manuel et si la médiane du temps parmi les réussites baisse d'au moins 20 %, ou si le taux d'achèvement exact s'améliore d'au moins 25 points de pourcentage sans augmentation des erreurs de sélection de source. Si ces conditions ne sont pas satisfaites, arrêter l'extension fonctionnelle et conserver seulement les liens qui auront une utilité démontrée. Ces seuils sont une règle locale de décision de projet, pas un seuil statistique publié ni une preuve de significativité. Publier aussi les temps bruts, les échecs et les cas où le parcours manuel est plus rapide.

**Décision provisoire de phase : RÉORIENTER.** Garder le catalogue étroit de provenance et ses contrôles de traçabilité ; suspendre toute augmentation du graphe jusqu'à la comparaison ci-dessus. Le bénéfice d'usage n'est pas encore démontré. La tranche a un coût de maintenance réduit (HTML statique et aucun JavaScript d'exécution), mais cette faible complexité ne suffit pas à établir son utilité.

## Limites d'interprétation

Le graphe C6/C3 formalise uniquement des rôles `num`/`cite` explicites sur deux plages de texte fixées, plus une chaîne de génération technique documentée par le manifeste TikZ et la CI. Une citation ne devient pas une prémisse ; une référence Verso ne devient pas une dépendance de preuve ; un import ne devient pas une justification scientifique. Aucun lien `tested-by` ou `implemented-by` n'est produit par heuristique. Le parcours « définition → théorème → preuve → implémentation → test » reste une tranche future séparée, bloquée tant que la valeur du prototype présent et l'attestation de chaque relation requise ne sont pas établies.
