<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# K7PL — dossier scientifique de préparation du vocabulaire du noyau

> **Statut : recherche non normative — photographie du 25 octobre 2026.** Ce dossier ne ratifie aucun lemme, token ou objet théorique. Il ne modifie ni la grammaire, ni les règles, ni les preuves, ni les macros. Révision examinée : `c88c968e66e5951bbf300efe3e39a515df8d8aa3`. Les sources historiques et leur statut sont centralisés dans l'[inventaire consolidé](core-vocabulary-historical-inventory-2026-10-25.md).

## 1. Objet et portée épistémique

Le problème n'est pas de choisir les mots les plus courts ou les plus familiers. Il consiste à déterminer le référent exact de chaque nom, à établir le niveau auquel il existe, à reconstruire ses obligations, puis à comparer des désignations sans masquer les incertitudes qui empêchent actuellement la décision.

Les statuts suivants doivent rester distincts :

| Statut | Ce qu'il permet d'affirmer | Ce qu'il ne permet pas d'affirmer |
|---|---|---|
| **Fait de la source courante** | La forme, formule, règle ou formulation est écrite dans `spec/` à la révision examinée. | Qu'elle est correcte, complète, minimale ou prouvée. |
| **Décision d'autrice ratifiée** | Une décision explicite retrouvée dans le registre courant fixe un choix et sa portée. | Que ses conséquences formelles sont démontrées ou intégrées partout. |
| **Résultat mathématique établi** | Une conclusion découle de prémisses énoncées et la démonstration correspondante est adéquate. | Qu'une compilation de document ou un contrôle structurel l'établit à sa place. |
| **État de preuve formel** | Le registre et l'artefact Lean indiquent précisément ce qui a été vérifié. | Qu'un statut `under-review`, `proofsketch` ou une compilation prouve l'énoncé. |
| **Résultat historique ou bibliographique** | Une source ou un ancien dossier rapporte une terminologie, une preuve ou une proposition dans son cadre. | Que cette proposition décrit `main` ou que l'autrice l'a ratifiée. |
| **Hypothèse de conception** | Un argument motive une option à tester ou à faire arbitrer. | Qu'il s'agit d'un fait empirique ou d'une obligation normative. |
| **Arbitrage ouvert** | Plusieurs options restent à examiner ou une dépendance interdit de trancher. | Que l'option la plus détaillée ou la plus ancienne est implicitement adoptée. |

La doctrine générale de `docs/method/doctrine.md` place les postulats et les objets théoriques avant la facilité de formalisation. Cette priorité interdit de choisir un nom qui rende un objet plus commode au prix d'une modification silencieuse de sa définition.

## 2. Révision, arborescence et méthode d'examen

- Branche observée : `main`.
- SHA observé : `c88c968e66e5951bbf300efe3e39a515df8d8aa3`.
- Commit : `test(status): align traceability assertions with unavailable-run status`, daté du 25 octobre 2026 à 09:42:54 UTC.
- Comparaison du SHA avec `main` : identique, aucun écart de commit.
- Arborescence GitHub : 745 fichiers (`tree.truncated = false`).
- Le clonage Git direct n'étant pas disponible dans l'environnement, l'examen a été mené au moyen de l'API GitHub. Les sources courtes ont été obtenues en intégralité ; pour les fichiers très longs, les sections pertinentes ont été extraites par plages. Ce dossier ne prétend pas constituer une lecture ligne par ligne des 745 fichiers du dépôt.

### 2.1 Inventaire des sources effectivement consultées

Les SHA ci-dessous sont les SHA de blob renvoyés par l'API de `main`, non des versions historiques supposées.

| Source | Blob SHA courant | Rôle et portée de lecture |
|---|---|---|
| `docs/method/doctrine.md` | `a8b5411d58b6b73a952a3f55b390da4a70d200ad` | Doctrine de décision, ordre de prévalence, méthode Arc G et récits historiques. Document long ; passages de méthode et de T‑68 ciblés. |
| `docs/tracking/primitives.md` | `91a52cd8888c42ac629aaaacff814ba0f587d139` | Registre de 602 lignes obtenu en entier ; entrées lexicales, historisation primitive/dérivé et questions temporelles examinées par plages. |
| `docs/migration/L1-T68-AUDIT.md` | `2191c3a372a7fade0e21b957c4205e6ed4ed19fd` | Audit de minimalité et dépendances ; statut lu. |
| `docs/migration/L1-DECISIONS.md` | `61106673495e1482637ee6b55e79b9cbf8602f85` | Décisions de migration ; statut `IN PROGRESS` et portée des décisions historiques examinés. |
| `docs/migration/L1-SUIVI.md` | `4d01feb5433386e40c7d9d65573afd948aa181c1` | Suivi historique et limites du périmètre contrôlé. |
| `docs/tracking/DECISIONS.md` | `2143ecf6457dfd536c772050a84350428cbb4e96` | Registre de décisions ; notamment T‑68, D‑T1 et D‑T2, et statut des décisions d'autrice. |
| `docs/tracking/PROJECT-MASTER-PLAN.md` | `de4f78b057d8fca40f1d6267d1949076507547d3` | Dépendances et état d'avancement du chantier G et de la porte C ; état daté du registre. |
| `docs/tracking/BRANCHES-STATUS.md` | `3a4d108254dc57a02b3f6e72b67755431a6c6f31` | Statut daté des branches historiques, limites de l'archive et décisions de reprise. |
| `docs/tracking/factorisations-refusees.md` | `408756802a2000c774aa913e43c29825959252c9` | Sept refus de factorisation relus comme tests négatifs de la méthode. |
| `docs/research/arc-g-methode.md` on baseline (blob `2984227d44b8c69f8ad6e346938896f5525b5ce0`; [baseline snapshot](https://github.com/AntheaLiles/k7pl/blob/c88c968e66e5951bbf300efe3e39a515df8d8aa3/docs/research/arc-g-methode.md)) → [archived copy](../history/2026-10-25-arc-g-methode.md) | Méthode historique d'Arc G ; séquence des critères et définition ancienne du périmètre. |
| `docs/research/arc-g-collecte.md` on baseline (blob `bced62622a7e35f209ac39130fe5ca998635e0dd`; [baseline snapshot](https://github.com/AntheaLiles/k7pl/blob/c88c968e66e5951bbf300efe3e39a515df8d8aa3/docs/research/arc-g-collecte.md)) → [archived copy](../history/2026-10-25-arc-g-collecte.md) | Collecte historique des terminologies CBPV, connecteurs, existentielles, gradation et effets. |
| `docs/research/t68-vocabulary-proposal-archive-pr10.md` | `3e916c68e2972d6134d42bafb1e53334d44fedf3` | Proposition issue de PR #10, avec avertissement explicite : archive non normative et non ratifiée. |
| `docs/migration/L1-PR10-ARCHIVE-RECOVERY-2026-10-14.md` | consulté sur `main` | Reprise sélective de l'archive PR #10 ; statut des morceaux et des outils écartés. |
| [archived research-question register](../history/2026-10-25-research-questions-register.md); [baseline corpus-gaps snapshot](https://github.com/AntheaLiles/k7pl/blob/c88c968e66e5951bbf300efe3e39a515df8d8aa3/docs/research/manques.md); `docs/RESEARCH.md` | consultés sur `main` | Questions ouvertes et recherches connexes ; l'ensemble n'est pas traité ici comme un corpus de preuves exhaustivement lu. |
| `docs/bibliography/a-sourcer-nommage.md` on baseline (blob `69b2bc378afdfecbc9e394e6c221e91c5038972a`; [baseline snapshot](https://github.com/AntheaLiles/k7pl/blob/c88c968e66e5951bbf300efe3e39a515df8d8aa3/docs/bibliography/a-sourcer-nommage.md)) | Liste des onze références d'études empiriques de nommage, et statut réel de leur utilité pour Arc G. |
| Dated corpus-sourcing note | The original dated note remains visibly marked historical; its removal from the old path is the only incomplete item in this hygiene pass. | Not used as current vocabulary evidence. |
| `docs/bibliography/references.json` | `47a65bd28ad6173d33f6aa771c55f4899ab48062` | Métadonnées bibliographiques, notamment Rasmussen, Oliveira, Berry et Das et al. ; JSON volumineux, entrées pertinentes extraites. |
| `docs/bibliography/decisions-bibliographiques.json` | `24fd14cc48bec69a8d9a2362d7656d645977cd29` | Décisions bibliographiques, dont les notes de lecture de Rasmussen et Vicente. |
| `spec/Spec/C1/TableDesGlyphes.lean` | `7bf9645d671f8587d725f23081f0aafc4362e145` | Table des glyphes et déclaration explicite macro/alias/AST. Fichier obtenu en entier. |
| `spec/Spec/C3/GrammaireDesTermes.lean` | `93be642a9c0ed5990f560be4657e1ff3dfafc45f` | Grammaire source des formes de valeur et de calcul ; fichier obtenu en entier. |
| `spec/Spec/C3/GrammaireDesTypes.lean` | `60df0208198163e9bf76dea24391e29d1f23834f` | Grammaire des types, des sessions, des grades et des effets ; fichier obtenu en entier. |
| `spec/Spec/C3/ReglesDeTypage.lean` | `ac11edad16bec18a96126371a624977e0659416b` | 1 795 lignes ; intro, jeu central de règles et sections temporelles, `ν`, vecteurs, couches et obligations de preuve consultés par plages. |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | consulté sur `main` | Réductions pures et effectueuses, configuration et statuts des théorèmes inspectés. |
| `spec/Spec/C5.lean`, `spec/Spec/C5/NotationsSpecialisees.lean` | consultés sur `main` | Frontière macros/notations et rôles des formes de surface. |
| `spec/Spec/C5/CeQuUneMacroDeclare.lean` | `686ba8da4d0f2b7956fb60a761d289b2ef2c8521` | Contrat des macros et obligations encore ouvertes ; fichier obtenu par l'API. |
| `spec/Spec/C5/LeTheoremeDElaboration.lean` | `d10e688e5ee5f10f7a620ad0dff49b9519ea0ac7` | Définition de l'élaboration et statut `under-review/proofsketch` du théorème. |
| `scripts/controles/croise.py` | `a3c367a8cfd3fc2139e829b534e7ca6696b76024` | Contrôle de correspondance grammaire/règles/registre ; code source obtenu en entier et logique pertinente inspectée. |
| `scripts/controles/vocabulaire.py` | `088ec6023d6ec1a780f826b2cef6db12625b3710` | Contrôle lexical ciblé sur une famille interdite ; ce n'est pas un vérificateur général de collisions sémantiques. |

### 2.2 Sources non confondues

- **Normatif courant :** les sources publiées sous `spec/`, sous réserve de leurs annotations explicites d'obligations ouvertes.
- **Registres courants :** `DECISIONS.md`, `primitives.md`, le plan directeur et l'audit de migration ; ils établissent les statuts et les tâches, mais ne remplacent pas les règles.
- **Recherche historique :** Arc G, T‑68 et les analyses de PR #10 ; utilisables comme arguments et provenance, non comme décisions actuelles.
- **Archives de branches/PR :** `docs/tracking/BRANCHES-STATUS.md` et le lot PR #10 indiquent quels fragments ne sont pas intégrés. Une archive détaillée n'a aucune autorité normative du seul fait de son détail.
- **Bibliographie :** une référence et une note de lecture ne remplacent ni la lecture de la source ni la démonstration de son applicabilité au cadre K7PL.

## 3. État de T‑68 et d'Arc G

### 3.1 Les nombres ne mesurent pas la même chose

Les sources actuelles présentent trois nombres différents, qu'il ne faut pas fusionner :

1. `docs/tracking/primitives.md` annonce **45 entrées DOING** au 8 octobre 2026. C'est le compte d'un registre.
2. La grammaire C3 annonce **46 constructeurs**, dont neuf valeurs et trente-sept calculs ; `scripts/controles/croise.py` contient également 46 entrées dans `EXPECTED`.
3. T‑68 est un audit de **minimalité et de statut ontologique**, pas un décompte de lignes. Son statut courant reste `IN PROGRESS`; il examine quelles obligations nécessitent réellement une construction normative.

Aucun de ces nombres n'est, par définition, le cardinal final des primitives conceptuelles, formelles et normatives. Les comptes de 20, 33, 44 ou ceux de la PR #10 archivée ne doivent pas être repris sans reconstruire leur base et leur unité de compte.

### 3.2 Incohérence bloquante : grammaire et `croise.py`

La formule de `spec/Spec/C3/GrammaireDesTermes.lean` contient les formes `\mathbf{fix}\;v` et `\mathbf{declassify}_{\ell}(v)`. L'ouverture de `spec/Spec/C3/ReglesDeTypage.lean` précise que les règles du point fixe déductif et de la déclassification sont données dans le corps ; les labels `eq:regle-fix` et `eq:regle-declassify` les identifient.

En revanche, le dictionnaire `EXPECTED` de `scripts/controles/croise.py` comporte 46 correspondances et n'a pas d'entrée pour `Fix` ni `Declassify`. Le parseur construit l'ensemble des règles à partir de motifs `\textsc{...}\frac`, ce qui n'englobe pas de la même manière les deux règles exposées séparément par leurs labels. La grammaire courante énumère donc **48 alternatives de terme si `fix` et `declassify` sont comptés comme les formes écrites**, soit neuf valeurs et trente-neuf calculs, alors que le commentaire et le contrôle parlent de 46 (9 + 37).

Ceci est un blocage de complétude du contrôle, pas une conclusion selon laquelle les deux formes seraient incorrectes. L'action appropriée est un audit ultérieur, distinct du présent chantier lexical : vérifier si le croisement doit être élargi pour suivre les règles définies séparément ou si une forme grammaticale doit être qualifiée autrement, puis exécuter les tests. **Aucun script n'est modifié ici.**

### 3.3 Écarts de statut qui exigent un rapprochement

| Écart observé | Ce qui est établi | Ce qui demeure ouvert |
|---|---|---|
| T‑68 / « vingt constructeurs » | `doctrine.md` contient encore un passage historique disant T‑68 clos sur vingt constructeurs ; `L1-T68-AUDIT.md` l'indique explicitement `IN PROGRESS`, et le registre reste à 45 entrées DOING. | Nettoyage/qualification de la formulation historique et clôture réelle du test de minimalité. Aucune suppression/réécriture de théorie ne découle de ce constat seul. |
| Méthode de nommage en bloc | L'archive PR #10 est explicitement étiquetée « non-normative archived research material » et « not reviewed or ratified by the author ». `DECISIONS.md` laisse l'arbitrage en bloc vs au fil de l'eau ouvert. | L'autrice choisit la méthode d'arbitrage. Le présent dossier propose des lots dépendants, sans déclarer que la méthode est ratifiée. |
| Critère « primitif si et seulement si une règle gouverne la forme » | `arc-g-methode.md` formule cette définition ancienne. | Elle est trop faible pour servir seule à T‑68 : elle confond le constructeur, la règle, l'objet théorique, la primitive formelle et la primitive normative ; elle ne traite pas les formes ayant une règle située hors du motif de contrôle. |
| `νalpha.C` | La grammaire des types contient `νalpha.C`; C3 a une section et des règles sous `eq:regles-nu` pour les formes de copatron et d'observation. | `primitives.md` conserve encore le récit de la coalgèbre terminale « à laquelle il manque ses deux règles ». Il faut vérifier la fermeture exacte de l'entrée du registre et le statut des obligations, plutôt que recopier la formulation historique. |
| `fix`, `declassify` | Les formes sont dans la grammaire et leurs règles sont annoncées au corps de C3. | Elles ne sont pas explicitement reliées au dictionnaire `EXPECTED` du contrôle croisé. La déclassification possède en outre une question ouverte de catégorie grammaticale dans D‑T1. |
| Temporalité (`always`, `at`, `now`, `wait`, `when`) | Les formes et règles sont écrites dans C3 ; les types de session portent aussi `○`, `□`, `◇`. | D‑T1 porte la catégorie des formes et la cohérence termes/types ; D‑T2 porte la représentation de l'attente de `When`. Ne pas faire arbitrer leur nom avant de résoudre les objets visés. |
| `When` et budget/ressource | P3‑B distingue la latence de l'attente environnementale du coût de l'automate déclenché ; le texte reconnaît que la correction de ressource de `When` reste à démontrer. | La représentation exacte de l'attente et la preuve de correction restent ouvertes. Un QCM lexical ne peut pas lever ce blocage. |
| `at` | Le terme de lecture d'une valeur permanente est actuellement `at v`, tandis que la localisation est `at_n c`; le registre historique signale une collision. | Décider si l'ambiguïté doit être traitée au niveau du token canonique, du lemme descriptif, ou seulement par les formes syntaxiques et les sortes. La proposition archivistique `current` n'est pas ratifiée. |
| `open` / `unpack` | La forme du noyau est `open`, et le manuscrit utilise également « open explicite » en prose. L'archive signale le conflit avec le mot-clé Lean `open`. | La portée pratique du conflit dépend du lieu où le token est parsé. L'archive propose `unpack`, sans autorité normative. |
| `slice` / « partition » | La règle consomme une capacité d'écriture sur un segment et en produit deux sur des segments disjoints ; le document signale le terme « partition » ailleurs pour `ρ = ρ₁ ⊎ ρ₂`. | Préserver la différence entre l'opération sur capacité et la relation de disjonction. |
| Recherche de nommage empirique | `a-sourcer-nommage.md` indique que les onze références de la revue ont été recensées, mais que QG‑8 à QG‑11 ont été closes sans que ces études supplémentaires soient nécessaires à Arc G. | Ces travaux peuvent éclairer une étude ergonomique ultérieure ; leur absence n'autorise pas à inventer une mesure de mémorabilité des noms du noyau. |

### 3.4 Les sept factorisations refusées comme tests négatifs

Le fichier `docs/tracking/factorisations-refusees.md` exige de conserver les distinctions suivantes :

- grade vs indice de taille ;
- comonade d'usage vs comonade cofree ;
- graphe de câblage vs graphe d'attente ;
- les deux projections ;
- tailles inductives vs coinductives ;
- les trois relations de préservation ;
- effets algébriques vs effets à portée.

Ces sept cas doivent être rejoués sur toute nouvelle tentative de simplification. La même forme syntaxique, le même symbole, la même famille d'implémentation ou une ressemblance de langage ne suffisent jamais à établir l'identité de deux notions. Pour chaque tentative future, la fiche de preuve doit nommer l'obligation préservée, celle perdue et le contre-exemple ou le théorème qui porte le verdict.

## 4. Frontière du noyau et des macros

La grammaire actuelle des termes, C3, C4 et C5 sont les sources de référence pour distinguer les constructions du noyau des formes de surface.

La table `spec/Spec/C1/TableDesGlyphes.lean` indique explicitement que chaque ligne représente une macro de la bibliothèque standard sous deux orthographes : un glyphe Unicode et un alias textuel qui donnent le même AST. Les 28 paires de cette table ne sont donc pas 28 primitives supplémentaires. Les glyphes des R‑expressions appartiennent à un autre système de notation, décrit dans C4, et ne deviennent pas pour autant des mots du noyau.

C5 distingue au moins six formes de surface : macro ordinaire, glyphe, forme sucrée, liaison `bind-to`, R/X‑expression, notation sans point. L'expansion de macro a lieu en phase 0 sur l'AST ; l'élaboration Surface→Noyau a son propre énoncé et des obligations encore marquées `under-review/proofsketch`. Les deux notions ne doivent pas être traitées comme un seul passage.

Une distinction lexicale documentée dans C3 est à préserver : le nom du constructeur formel désigne ce que l'objet **est** ; une forme de surface peut désigner ce que le programmeur **fait**. Ainsi `operation` et `scoped` sont deux espèces formelles d'opérations d'effet, tandis que `perform` et `handle` désignent des actions de surface, et `handler` désigne une valeur. La relation entre ces mots doit être tracée comme une relation entre concepts et formes d'élaboration, pas présentée comme synonymie.

## 5. Complétude ontologique : grille qui gouverne le registre

Le registre joint fournit une ligne par forme de terme de la grammaire courante, puis une seconde grille pour les formateurs de type et les objets de grade/effet. Il distingue huit catégories qui peuvent se recouper :

- **A — primitive conceptuelle** : distinction nécessaire à la théorie ; cette minimalité peut rester ouverte.
- **B — constructeur syntaxique** : alternative explicitement écrite dans la grammaire.
- **C — primitive formelle** : objet nécessaire à une formalisation ou à une propriété, sans que cela implique un token de surface.
- **D — primitive normative** : élément que la définition normative du langage doit inclure.
- **E — élément d'implémentation** : fonction, structure ou étape d'une réalisation concrète.
- **F — macro de bibliothèque** : forme de surface qui s'expanse dans le noyau.
- **G — orthographe d'une macro** : glyphe ou alias de la même macro.
- **H — concept descriptif/métalangagier** : lemme d'explication, nom d'une preuve, d'une règle ou d'une famille, sans être forcément un token.

Les catégories ne forment pas une partition exclusive et ne doivent pas être forcées en bijection. Chaque ligne signale ce qui est prouvé par le document, ce qui est un candidat et ce qui exige une vérification.

### Chaîne probatoire obligatoire

Pour toute notion avant de figer son nom :

`concept → obligation → règle → propriété requise → preuve ou justification formelle`

Pour toute proposition de factorisation/dérivation :

`construction candidate → obligations préservées → obligations perdues → contre-exemple ou démonstration → verdict`

La chaîne peut se terminer par « inconnue / non instruite ». Il vaut mieux conserver cette lacune que compléter une case à partir de l'intuition lexicale.

## 6. Critères du nommage : état et limites

### 6.1 Ancrage scientifique

C'est le critère éliminatoire. Un candidat doit désigner la construction telle que définie par la règle et la sémantique, y compris ses contraintes de grade, de ressources, de couche, de temps, d'effets et de budget. S'il suggère une opération différente ou efface une obligation nécessaire, il est inadéquat, quelle que soit sa brièveté.

L'usage historique de `fold/unfold`, `thunk/force`, `pack/unpack`, `perform/handle` ou d'autres termes du corpus peut établir un précédent de terminologie. Il ne prouve pas que leur sens est transférable sans changement au K7PL gradué. Toute généralisation doit vérifier ce que la règle ajoute à l'objet d'origine.

### 6.2 Mnémonique

Le dossier d'Arc G distingue familiarité, cohérence de famille, devinabilité, apprentissage et mesures. Les études de nommage citées par la revue Oliveira et al. portent surtout sur des noms d'identifiants dans du code existant, non sur des mots-clés de noyau imposés par les concepteurs d'un langage.

Le travail de Hofmeister, Siegmund et Holt sur la longueur des identifiants s'intéresse à des développeurs professionnels, au code C# et à une tâche de recherche de défaut ; il n'est pas une mesure de l'apprentissage de `Box`, `When` ou d'un lemme français de K7PL. Les études de styles d'identifiants ne fournissent pas davantage un classement directement transposable à des primitives.

En conséquence :
- une convention multi-langage soutient un argument de **familiarité**, pas une mesure de compréhension ;
- un composé sémantiquement transparent soutient une hypothèse de **devinabilité**, pas une preuve ;
- il n'existe dans les sources examinées aucune mesure contrôlée établissant quel nom de primitive K7PL est le plus mémorisable ;
- une expérience éventuelle devra comparer des candidats dans des tâches définies, avec population, expertise, métrique, hypothèse et protocole préenregistrés. Ce sera un chantier empirique séparé, pas un prétexte pour inventer des scores.

### 6.3 Écologique : transfert à justifier

Rasmussen (1983) distingue performances fondées sur les habiletés, les règles et les connaissances, ainsi que signaux, signes et symboles. Vicente et Rasmussen (1992) conçoivent l'interface écologique pour représenter les structures et contraintes fonctionnelles d'un système complexe ; Vicente (1999) présente Cognitive Work Analysis comme une approche d'analyse et de conception des systèmes sociotechniques, organisée autour du domaine de travail, des tâches de contrôle, des stratégies, de l'organisation/cooperation et des compétences.

Ces sources soutiennent la recherche d'une représentation qui permet de percevoir les relations fonctionnelles et les contraintes pertinentes. **Elles ne démontrent pas que le seul choix d'un nom de fonction est une interface écologique**, ni qu'un mot tel que « découpe » ou `slice` facilite effectivement le diagnostic d'un programme.

L'application au vocabulaire K7PL sera donc provisoirement une grille d'hypothèses :

1. le nom aide-t-il à identifier l'entrée et la sortie de l'opération ?
2. rend-il perceptible la ressource consommée, produite ou conservée ?
3. suggère-t-il à tort une copie, une attente, une répétition, une mutabilité ou une atomicité que la règle n'accorde pas ?
4. permet-il de distinguer les comportements qui divergent par un invariant réellement différent ?
5. permet-il à un utilisateur de prédire où regarder lorsqu'un usage est refusé ou qu'une obligation échoue ?

Chaque réponse doit citer l'obligation et la sémantique qui la rendent pertinente. Un candidat ne reçoit pas une qualité « écologique » du seul fait qu'il est concret ou imagé.

### 6.4 Ordre d'application à faire arbitrer

L'ancienne méthode Arc G énumère la non-collision, la cohérence de famille, le comportement sous les grades, le mnémonique et la brièveté, sans intégrer de manière explicite et ratifiée le transfert écologique demandé par le présent mandat. Aucun score composite n'est produit.

Deux protocoles restent raisonnables et doivent être soumis à l'autrice dans le QCM méthodologique :

- **M-A — extension séquentielle** : non-collision → exactitude scientifique → cohérence de famille et comportement sous les grades → grille écologique provisoire → argument mnémonique → brièveté.
- **M-B — priorité scientifique stricte** : non-collision → exactitude et préservation des obligations ; les critères de famille, d'écologie, de familiarité et de brièveté sont documentés ensuite sans pouvoir compenser un défaut d'exactitude.

Cette alternative est méthodologique, pas une conclusion théorique. Le protocole doit indiquer quels critères éliminent un nom et lesquels ne font que départager des candidats admissibles.

## 7. Sources scientifiques : ce qui est réellement établi

| Source | Apport vérifié | Limite de transfert |
|---|---|---|
| Rasmussen, 1983, *Skills, Rules, and Knowledge; Signals, Signs, and Symbols…*, DOI [10.1109/TSMC.1983.6313160](https://doi.org/10.1109/TSMC.1983.6313160) | Modèle des niveaux d'activité humaine et distinctions entre signaux, signes et symboles ; les symboles peuvent renvoyer à une représentation conceptuelle fonctionnelle. | Ne mesure pas la qualité de noms de constructeurs de langage. |
| Vicente & Rasmussen, 1992, *Ecological Interface Design: Theoretical Foundations*, DOI [10.1109/21.156574](https://doi.org/10.1109/21.156574) | Cadre théorique de conception d'interfaces de systèmes homme-machine complexes et représentation des relations fonctionnelles/contraintes. | Le cadre vise des interfaces qui rendent perceptible une structure du domaine, pas une liste lexicale seule. |
| Vicente, 1999, *Cognitive Work Analysis*, [éditeur](https://www.routledge.com/Cognitive-Work-Analysis-Toward-Safe-Productive-and-Healthy-Computer-Based-Work/Vicente/p/book/9780805823974) | Analyse du domaine de travail, des tâches de contrôle, des stratégies, de l'organisation et des compétences ; l'ouvrage oppose explicitement approches normative, descriptive et formative. | Permet une adaptation argumentée du cadre, pas une attribution automatique d'une note écologique à un mot. |
| Berry, 1993, *Lessons from the Design of a Standard ML Library*, DOI [10.1017/S0956796800000873](https://doi.org/10.1017/S0956796800000873) | Leçons de conception tirées d'une bibliothèque Standard ML et réflexion sur son interface. | Ne choisit pas les lemmes K7PL et ne justifie pas à lui seul toutes les formulations historiques attribuées à « Berry ». |
| Oliveira, Bruno, Madeiral & Castor, 2020, *Evaluating Code Readability and Legibility…*, DOI [10.1109/icsme46990.2020.00041](https://doi.org/10.1109/icsme46990.2020.00041) | Revue d'études centrées sur l'humain ; distinctions entre lisibilité et facilité d'identification des éléments et examen des tâches expérimentales. | Les catégories analysées ne correspondent pas directement au nommage des primitives fondamentales de K7PL. |
| Hofmeister, Siegmund & Holt, *Shorter Identifier Names Take Longer to Comprehend*, DOI [10.1007/s10664-018-9621-x](https://doi.org/10.1007/s10664-018-9621-x) | Étude de la compréhension de noms d'identifiants dans du code ; une tâche et une population définies. | Le titre ou le résultat ne peut pas être généralisé aux tokens et lemmes de K7PL sans expérience propre. |

## 8. Traçabilité vers K, TLA+ et Lean

Le registre ontologique emploie des identifiants stables de dossier, par exemple `TERM-LET`, indépendants de la syntaxe choisie dans un formalisme.

- **K Framework** : une production syntaxique ne suffit pas à établir une règle de réécriture. La correspondance entre constructeur C3 et règle de réduction C4 sera enregistrée lorsque la sémantique exécutable sera définie ; elle n'est pas déclarée existante par anticipation.
- **TLA+** : une construction de terme peut correspondre à une action, à une variable d'état, à une propriété d'invariant ou à une abstraction, mais il n'y a pas de bijection présumée avec les règles de typage.
- **Lean 4** : une déclaration peut représenter un type syntaxique, une règle inductive, une fonction d'interprétation ou un théorème. Le nom de cette déclaration dans Lean n'est pas le lemme français et n'a pas à être identique au token du langage.
- **Tests** : un test d'analyse syntaxique confirme l'acceptation/rejet d'une forme dans un implémenteur donné ; il ne prouve pas son minimalité. Une preuve Lean confirme seulement l'énoncé formalisé à partir des hypothèses effectivement définies.

Les cases inconnues du registre doivent rester « non établi » jusqu'à l'apparition d'un artefact précis et vérifié. L'égalité des noms ne vaut pas traçabilité : il faut partager un identifiant de concept et relier les obligations.

## 9. Livrables de cette branche

- [Registre ontologique](core-vocabulary-ontology-2026-10-25.md) : formes courantes, règles, statuts et dépendances.
- [Catalogue QCM](core-vocabulary-qcm-2026-10-25.md) : arbitrages individuels et groupés, avec options « Autre » et « Précision ».
- [Registre des décisions](core-vocabulary-decisions-2026-10-25.md) : historique à append-only logique et statuts non interchangeables.
- [Plan de clôture](core-vocabulary-closure-plan-2026-10-25.md) : dépendances, critères de sortie et blocages.

L'intégralité de ce lot est non normative. Il ne résout pas les écarts de contrôle identifiés, ne renomme aucun fichier ou token et ne met pas à jour les preuves. Aucun résultat de CI ou de compilation n'est revendiqué sur cette base.

## 10. Addendum vérifié au HEAD courant après fusion de la PR #306

### 10.1 Identité de la révision et périmètre

- HEAD de `main` observé le 25 octobre 2026 : `a3ac6afece9eecd53064afbd295c710fbbe7eb40` (commit de fusion de la PR #306).
- L'audit initial porte sur `c88c968e66e5951bbf300efe3e39a515df8d8aa3`. Le tree GitHub du HEAD courant contient 854 chemins, contre 745 dans la photographie initiale. Ces nombres correspondent à deux révisions différentes et ne mesurent pas le seul diff de la PR #306.
- Le contrôle `main` CI run [40190879024](https://github.com/AntheaLiles/k7pl/actions/runs/40190879024) est terminé avec une conclusion globale `success`. Le job de vérification de l'implémentation Lean a été `skipped`, et un contrôle de dérive BadgeApp également ignoré ; cette exécution n'établit donc pas la recompilation Lean complète. Wiki export, Scorecard, spec Verso, PDF et contrôles disponibles ont réussi.
- La revue GitHub a examiné les sources à la révision exacte et leurs blobs : `spec/Spec/C3/GrammaireDesTermes.lean` (93be642a9c0ed5990f560be4657e1ff3dfafc45f), `spec/Spec/C3/GrammaireDesTypes.lean` (60df0208198163e9bf76dea24391e29d1f23834f), `spec/Spec/C3/ReglesDeTypage.lean` (ac11edad16bec18a96126371a624977e0659416b), `spec/Spec/C3/EffectiveKernel.lean` (127039c7b93fee5696f2c0b1c81805ba29726bb0), `scripts/controles/croise.py` (a3c367a8cfd3fc2139e829b534e7ca6696b76024) et `docs/tracking/primitives.md` (91a52cd8888c42ac629aaaacff814ba0f587d139).

### 10.2 Conclusions sur les unités et la chaîne de couverture

1. La grammaire a **48 alternatives** de terme, réparties en 9 valeurs et 39 calculs. Le dictionnaire `EXPECTED` de `croise.py` compte 46 entrées, 9 valeurs et 37 calculs. Ses deux écarts sont `fix` et `declassify`, qui ont des équations spécifiques référencées séparément (`eq:regle-fix` et `eq:regle-declassify`) : ils ne doivent être ni supprimés ni renommés pour faire coïncider le comptage.
2. La matrice de migration qui annonce 49 occurrences et 48 noms distincts compte les occurrences de règles ; `Alw` y apparaît deux fois. Les 45 entrées `DOING` du registre `primitives.md` sont un troisième dénominateur, daté du 8 octobre 2026. Aucun de ces cardinaux n'est en contradiction avant d'avoir distingué leurs unités, mais l'absence de `fix`/`declassify` du contrôle automatisé demeure un défaut de couverture explicite.
3. La couverture AST/Lean n'est ni nulle ni complète. `spec/Spec/C3/EffectiveKernel.lean` contient de vrais inductifs : `Value` avec `var`, `unit`, `pair`, et `Computation` avec `ret`, `lam`, `app`, `let1`, ainsi que `ValueTyping` et `ComputationTyping`. Le lien de règle existe donc pour **7/48 formes**. Le module est explicitement projeté et conserve `ContextComposition` comme paramètre ; son commentaire dit qu'il ne formalise pas `⊠` complet, la consommation du budget ni `ψ`. Aucun parseur/élaboreur liant les orthographes de surface à ces constructeurs n'a été identifié dans ce lot. `ValueType` ne comprend que `base`, `unit`, `tensor` parmi les types de la grammaire.
4. C4 comprend 12 patrons purs explicites dans `eq:reductions-pures` et un treizième cas (vecteur non vide) exposé en prose ; `eq:reductions-effets` contient l'opération, l'instance `tick` du schéma d'opération, la progression interne de `scoped` et son retour interprété. Ce comptage de patrons ne peut pas être lu comme 13/48 formes « implémentées » : une introduction peut être la partie gauche d'un redex uniquement avec son éliminateur, et les couches temporelles et système requièrent une relation explicite.
5. Les tests actuels ne forment pas un corpus de conformité des 48 termes : `tests/SemanticsTest.lean` teste un LTS compteur ; les exemples `.k7` `add.k7` et `select.k7` appartiennent au sous-langage K expérimental (`Int`, `Bool`, `+`, `<`, `select`). `docs/formal-semantics.md` précise qu'il n'existe pas encore de simulation générale reliant toutes les transitions de `SurfaceStep` à KLean. Aucun des 48 IDs n'a de test dédié relié dans le registre.

### 10.3 Contradictions et lacunes prioritaires encore ouvertes

| ID | Constat | Nature | Suite requise, sans modification normative implicite |
|---|---|---|---|
| CV-COV-01 | 48 formes de surface, mais seulement 46 clés `EXPECTED`; `fix` et `declassify` sont des règles-éq. hors du motif d'extraction `\\textsc{...}\\frac`. | Lacune du contrôle de couverture. | Étendre l'audit des sources de règles et décider comment tester les deux références spéciales ; ne pas affaiblir le contrôle existant. |
| CV-COV-02 | Le fragment Lean formalise 7 formes ; la conversion surface→AST et le reste des formes ne sont pas reliés. | Couverture formelle partielle. | Ajouter à la matrice les liens exacts pour chaque forme restante ; distinguer représentation, jugement, exécution et test. |
| CV-COV-03 | L'ouverture de C4 affirme que préservation/progrès sont « démontrés », alors que les blocs des théorèmes portent `under-review` et `proofsketch`. | Contradiction entre prose et statut de preuve. | Corriger le statut documentaire sous la procédure appropriée ; ne pas déclarer la preuve mécanisée. |
| CV-COV-04 | `primitives.md` affiche une fiche DONE sur `ν` disant que ses deux règles manquent, alors que C3 contient `eq:regles-nu`, `Out` et `Cop`. | Décalage de registre historique et de source actuelle. | Comparer précisément le périmètre des règles, les hypothèses et les preuves avant de modifier le statut de la fiche. |
| CV-COV-05 | `WhenBoundary.lean` est un modèle de conservation budgétaire abstrait et non une définition de la règle opérationnelle `When`. | Modèle relié par concept, pas par transition. | Raccorder C-04/D-T2 à une observation de latence typée et à la correction des ressources. |
| CV-COV-06 | Le type `Vec` est décrit comme dérivé, mais `VecI`/`VecE` possèdent leurs règles et un parcours opérationnel. | Dérivabilité non établie par le seul nom du type. | Comparer les obligations de grade et de contexte du pli indexé à celles d'une construction candidate. |
| CV-COV-07 | `Slice`/`Cap` ont une grammaire et une règle de typage, mais aucun raccord term-level à une preuve de correction mémoire n'a été établi. | Interface mémoire partiellement formalisée. | Relier règle normative, invariant de capacité, transition mémoire et test de conformité. |
| CV-COV-08 | Les alias glyphiques sont spécifiés comme macros/AST équivalents, mais les théorèmes généraux d'expansion/hygiène restent en revue. | Frontière de phase et preuve incomplète. | Relier chaque paire à sa déclaration de macro, son AST produit et un test d'équivalence, sans la compter comme primitive nouvelle. |

### 10.4 Conventions de casse et portée du vocabulaire

- La grammaire emploie une majorité de mots de surface minuscules (`return`, `let`, `thunk`, `when`, `declassify`) mais aussi des symboles et des formes mixtes avec paramètres (`λ`, `Λ`, `iter_V`, `operation_ε`, `scoped_f`, `at_n`, `new_E`, `move_{n→m}`). Ce n'est pas une convention de casse unique.
- Le guide `.claude/skills/writing-rules.md` prescrit CamelCase pour les fichiers/modules Lean, lowerCamelCase pour fonctions/valeurs, UpperCamelCase pour types/structures/classes/namespaces, et snake_case pour les théorèmes. Les noms des règles (`Var`, `OneE`, `Slice`) sont des labels formels ; ils ne doivent pas être assimilés aux mots de surface.
- `lambda` est répertorié comme lemme dans `primitives.md`, tandis que la production de calcul actuelle écrit `λx.c` : le token observé est symbolique, non le mot ASCII `lambda`. `thunk` est un mot de surface et une règle `Th`; `when` est une forme de calcul dont la catégorie d'exécution reste à fermer malgré la décision architecturale P3-B.
- Le tableau standard de glyphes de `TableDesGlyphes.lean` comporte 28 couples glyphe/alias ; les glyphes de R-expressions appartiennent à une autre table. Ces alias appartiennent aux macros de bibliothèque et ne doivent pas être ajoutés au décompte des 48 formes du noyau.
- Aucune propriété de mémorabilité ou d'efficacité cognitive des conventions n'est déclarée mesurée. Ces critères restent des hypothèses à tester, distinctes de la correspondance formelle et de la cohérence avec les grades, les budgets et les garanties temporelles.

### 10.5 Effet de la réponse de l'autrice et ordre des travaux

Le 25 octobre 2026, l'autrice a répondu **A** à Q-METH-002 : arbitrage lexical global après audit ontologique. Cette réponse est enregistrée sous `VOC-2026-10-25-001` dans le registre de décisions. Elle fixe l'ordre de travail, pas un lexique normatif ; aucune forme n'est renommée ni ratifiée.

Ordre suivant : (1) fermer les unités de comptage et les exceptions `fix`/`declassify` dans le contrôle ; (2) terminer la matrice règle→réduction→AST→preuve→test par couche et par forme ; (3) réconcilier les statuts ν/Out/Cop, When, Vec, Slice/Cap et l'état `under-review` des théorèmes ; (4) vérifier exhaustivement les déclarations de macros, alias, consommateurs et occurrences lexicales ; (5) seulement ensuite soumettre la ratification globale des lemmes/tokens. L'exception historique `docs/bibliography/a-sourcer-manques.md` est conservée et n'est pas contournée.

### 10.6 Limites de l'exécution

Le clone Git local et les tests locaux n'ont pas pu être exécutés dans cet environnement, faute de résolution DNS vers `github.com`. L'examen des sources s'est fait via l'API GitHub sur le SHA explicite. La CI citée ci-dessus appartient au commit de base, pas aux modifications de cette branche. Ce rapport reste donc un audit **partiel**, à faire vérifier par les contrôles de la PR et par une exécution de la chaîne Lean ciblée lorsqu'elle sera déclenchée.
