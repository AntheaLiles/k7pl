-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "Le processus de compilation" =>
%%%
file := "c6-le-processus-de-compilation"
tag := "c6-le-processus-de-compilation"
%%%

{label "sec:c6-le-processus-de-compilation"}

Compiler un programme K7PL consiste à établir les obligations du jugement germinal du chapitre 1, puis à effacer les informations réservées à la compilation du binaire final. La dépendance entre les étapes est majoritairement ordonnée, mais les phases 5 (décharge des obligations) et 6 (optimisation) forment un sous-processus itératif : une optimisation peut engendrer de nouvelles obligations, qui doivent être revérifiées avant de poursuivre.

Le pipeline compte huit phases logiques de vérification et deux points de contrôle intercalaires, en 1.5 et 2.5. Il ne faut pas confondre ce compte logique avec le nombre de passes d'une implémentation. La figure décrit les dépendances principales ; elle ne signifie pas que les phases 5 et 6 s'exécutent une seule fois. Une implantation peut utiliser de nombreuses passes fines, chacune responsable d'une tâche distincte et vérifiable isolément {cite "sarkarEDUCATIONALPEARLNanopass2005", "pattersonNext700Compiler"}[].

::::figure (label := "fig:comp-process") (src := "compilation-process") (alt := "Pipeline en serpentin : huit phases principales et deux étapes intercalaires, lues en aller-retour.") (width := "90")
:::caption
Les huit phases du pipeline de compilation
:::

:::desc
Dix étapes forment un serpentin : la rangée supérieure se lit de gauche à droite ; la flèche descend
vers TermProof, puis la rangée inférieure se lit de droite à gauche jusqu'à Link ; 1.5 et 2.5 sont intercalaires.
:::
::::

Tout commence par construire l'arbre syntaxique du texte du chapitre 5 et par y désucrer les sigils
en attributs — un travail purement syntaxique, qui ne discute encore aucun des trois ordres. Une
passe de configuration lui succède aussitôt. Elle collecte, à partir des définitions d'acteurs et
des `strand` de workflow, les ressources externes que le programme engage — fichiers, URL, capacités
réseau — et en produit un manifeste validable avant même qu'un type n'ait été inféré. Une dépendance
externe manquante est ainsi découverte avant que le reste du pipeline n'ait été investi dans un
programme qui ne pourrait pas s'exécuter.

Vient alors l'établissement conjoint de la modalité $`\Delta` et du type $`A`. L'algorithme de Damas
et Milner en fournit le squelette. Sa propriété de principalité — un programme accepté reçoit le
type le plus général possible — vaut du fragment sans grade. Ce chapitre en montre l'adaptation aux
modalités et aux types dépendants pragmatiques, au prix assumé au chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) d'une vérification bidirectionnelle à signatures
obligatoires plutôt que d'une inférence principale. Puisque toute définition de plus haut niveau
porte une signature (chapitre 3, §{num "sec:c3-structures-ouvertes-effets-et"}[]), le compilateur
n'a pas à inférer le grade avant d'unifier. Il procède bidirectionnellement, vérifiant les formes
d'introduction contre les annotations et synthétisant celles des éliminations, et défère au solveur
les contraintes résiduelles sur $`\mathcal{R}`. Aucune séquentialisation entre analyse de flot et
unification n'est requise : elle ne le serait que pour une inférence complète à la Damas-Milner, à
laquelle le §{num "sec:c3-structures-ouvertes-effets-et"}[] renonce.

Ce même parcours unifie les types concrets, résout les types dépendants pragmatiques du chapitre 3
(§{num "sec:c3-les-contraintes-de-valeur"}[]) et monomorphise chaque appel générique en une copie
concrète. Unifier des types tout en ignorant encore lesquels de leurs habitants se dupliquent
librement obligerait en effet l'unification à raisonner simultanément sur deux treillis distincts,
ce que rien dans l'algorithme de Damas et Milner ne prévoit.

Cet ordre n'est toutefois que l'une des trois architectures attestées : le typage de DFuzz {cite "deamorimReallyNaturalLinear2014"}[]
exécute une passe de style Hindley-Milner puis une procédure de résolution de contraintes, tandis
que Granule {cite "orchardQuantitativeProgramReasoning2019"}[] et la théorie graduée dépendante de
Moon et al. {cite "moonGradedModalDependent2021"}[] procèdent par typage bidirectionnel adossé à un
solveur SMT, sans séquentialiser les deux treillis. K7PL retient la première pour la prévisibilité
du temps de compilation, non par contrainte algorithmique.

Lorsqu'un effet `Import` suspend cette unification — une source externe dont le type n'est pas
encore connu —, le vérificateur reprend, une fois la source résolue, exactement où il s'était
arrêté. La monomorphisation, elle, ne s'exécute qu'une seule fois : les phases suivantes n'auront
plus jamais à réinférer un type déjà rendu concret.

Une phase d'élaboration referme la composante $`A` du jugement. Les types existentiels du chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) y reçoivent leurs `pack~/~unpack` explicites,
effacés en surface mais nécessaires au cœur vérifié. Un contexte complet — portant simultanément
toutes les variables d'unification encore ouvertes — permet de résoudre chaque égalité
$`\hat\alpha := \tau` par substitution immédiate dans ce contexte plutôt que par une substitution
globale reconstruite à chaque pas. Ce qui reste, une fois cette résolution achevée, se généralise
différemment selon la couche. En couche 3, une variable non résolue reçoit par défaut le type
`Unit`, ou le programme est rejeté. En couche 2, seules les variables de rangée se généralisent, le
reste retombant sur `Unit`. En couche 1, il n'existe plus de variable d'unification à généraliser :
la linéarité stricte a déjà tout déterminé en Phase 2.

La composante $`\mathcal{E}` ne peut se vérifier qu'à présent, une fois $`A` stabilisé : tout
`perform` doit être couvert par un gestionnaire, sous peine d'une erreur immédiate (`ERR-EFF-001`),
et tout bloc `[ ]` doit satisfaire $`\mathcal{E} = \emptyset` — la vérification de pureté qui, au
chapitre 5 (§{num "sec:c5-mise-en-pratique"}[]), rejetait un `HandlerResult` égaré en couche 3. Le
narrowing déjà mobilisé en Phase 2 raffine au passage le type de chaque branche d'un `match`, de
sorte que cette vérification ne recommence rien depuis le début.

Sait-on désormais qu'un terme n'a pas d'effet caché : c'est alors, et alors seulement, que sa
terminaison ou sa productivité — la dernière propriété structurelle à établir avant le recours à un
solveur — devient une question qui a un sens. Ces deux propriétés ne font ici qu'une seule
vérification, et c'est une conséquence directe du choix arrêté au chapitre 2
(§{num "sec:c2-algebres-coalgebres-et-points"}[]). La terminaison comme la productivité y reposent
sur un indice de taille porté par le type, non sur une inspection de la syntaxe du terme. Vérifier
qu'un pli de couche 3 décroît et qu'un flux de couche 2 progresse, c'est vérifier le même jugement
sous deux polarités. Cette phase porte donc désormais une seule procédure là où elle en portait deux
— une inspection de mesure structurelle d'un côté, un contrôle de gardiennage de l'autre. Le nombre
de phases du pipeline est inchangé : c'est le contenu de celle-ci qui se simplifie, non son rang.
Pour les automates du chapitre 4 (§{num "sec:c4-echelle-locale"}[]), la complexité du motif est
validée contre son annotation, et la profondeur d'un PDA supervisé contre le grade qui la borne.

Ce qui subsiste après cette preuve structurelle — bornes numériques, débit, contraintes de rangée —
n'a rien de plus simple à établir sans aide extérieure. Un solveur pour les contraintes de rangée
les résout par ensembles disjoints, tandis que le reste est exporté vers un solveur SMT externe, sur
les théories dédiées du chapitre 3 (§{num "sec:c3-les-contraintes-de-valeur"}[]). Ces théories
doivent être nommées, faute de quoi la prévisibilité annoncée reste une intention~: l'arithmétique
linéaire sur les entiers et les rationnels pour les bornes de taille et les grades fractionnaires,
les tableaux pour les accès d'arène, les fonctions non interprétées pour les prédicats de
raffinement opaques. Toutes sont décidables, ce qui fonde l'argument de terminaison de la Phase~5 ;
leur combinaison ne l'est pas nécessairement, et la dette est ici de nommer ce sur quoi le
compilateur se restreint. Soit $`\mathcal{T}_{\text{K7PL}}` la combinaison de ces théories. Le
compilateur ne soumet au solveur que le fragment
$`\mathcal{T}_0 \subseteq \mathcal{T}_{\text{K7PL}}` dont la décidabilité est acquise ; toute
obligation hors de $`\mathcal{T}_0` est _rejetée à la compilation_ avec un code d'erreur, et jamais
soumise. Ce que ce document ne fait pas encore est de délimiter $`\mathcal{T}_0`, et l'argument de
terminaison de la Phase 5 vaut de ce fragment plutôt que de la combinaison entière. Le solveur reste
une boîte noire pour les obligations internes à une compilation, reproduites dans le même
environnement. Pour celles qui traversent la frontière de paquet, un _certificat_ est exigé : une
réponse négative ne se croit pas sur parole, les solveurs modernes sachant produire des preuves
vérifiables indépendamment. La Phase~5 porte cette clause. Une réserve porte sur l'ordre de cette phase et de la suivante. Les optimisations
que la Phase~6 conduit — déforestation, _inlining_, défonctionnalisation — transforment les
contextes et peuvent donc engendrer des contraintes de grades que la Phase~5 avait déjà déchargées~:
une boucle fusionnée multiplie les grades de ses deux corps, un appel intégré substitue son contexte
à l'échelle de son propre grade. Le pipeline suppose ici une dépendance à sens unique qui n'est pas
établie, et la conduite correcte est d'itérer les deux phases jusqu'à stabilisation plutôt que de
les enchaîner une fois. Ce que la suite linéaire décrit n'est donc pas le modèle défendu, et l'écart
se referme par un énoncé plutôt que par une figure.

::::theorem (label := "thm:stabilisation_pipeline") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "compilation")
:::title
stabilisation conditionnelle du pipeline
:::

:::statement +titled
Terminaison sous contrat de budget

Si le budget de spécialisation est fini, ne croît jamais, et si chaque tour qui modifie le terme consomme strictement au moins une unité de ce budget tandis qu'un tour sans modification est reconnu comme point fixe, alors la boucle $`\text{Vérification} \to \text{Optimisation} \to \text{Vérification}` termine en un nombre fini de tours.
:::

:::proofsketch
Le nombre de tours modifiant le terme est borné par le budget initial, puisque chaque tel tour le décrémente strictement et qu'il ne peut pas croître. Un tour sans changement termine la boucle par définition du point fixe. La conclusion dépend entièrement du respect opérationnel de ce contrat par chaque transformation, en particulier l'inlining et la monomorphisation.
:::

:::note
_Obligation ouverte._ Le contrat de budget est maintenant explicité comme hypothèse, mais il reste à prouver et à tester sur l'implémentation que chaque transformation qui modifie le terme consomme le budget, que le budget ne peut pas être réaugmenté et qu'un tour sans changement est détecté. La terminaison effective du pipeline n'est pas encore établie.
:::
::::
Le recours à un solveur externe pose enfin la question de la _stratégie_ de vérification des
obligations de budget, et l'arbitrage y est plus contraint qu'il n'en a l'air. La littérature le
pose dans ses propres termes : les techniques d'analyse de ressource _automatisées_ sont restreintes
à des familles de bornes relativement contraintes, tandis que les techniques plus _expressives_,
admettant des bornes qui dépendent des valeurs, reposent sur des preuves écrites à la main {cite "knothLiquidResourceTypes2020"}[].
Or les grades de ce document dépendent de valeurs — grades fractionnaires, rangées à grade de
présence, `Vector(n,T)` — de sorte qu'une technique purement automatisée ne les couvrirait pas ; et
l'exigence de compilation bornée du §{num "sec:c6-exigence-compilation-bornee"}[] exclut les preuves
manuelles. Le point de rencontre est donc étroit, et il a un nom : des types à raffinement augmentés
d'_annotations de potentiel_, conduisant une analyse amortie. Ce n'est pas un dispositif à ajouter —
le budget du grade _est_ un potentiel (§{num "sec:g-semantique"}[]) et les
contraintes de valeur du chapitre 3 _sont_ les raffinements —, c'est la reconnaissance que les trois
pièces du dispositif sont déjà au document sous d'autres noms.

Une brique y manque toutefois, et elle est nommée. Les analyses de ce type s'arrêtent au premier
gestionnaire : le transfert de contrôle non local entre un effet et son gestionnaire avait résisté à
toutes les techniques antérieures, et n'a reçu qu'une seule réponse automatique {cite "chuHandlingExceptionsEffects"}[].
Comme ce langage a des gestionnaires d'effets en couche 2, l'analyse de budget s'y arrêterait sans
cette pièce. Sa limite est nette et vaut d'être reprise plutôt qu'omise : elle est présentée pour un
langage fonctionnel simple, avec des listes et des fonctions de potentiel linéaires, et ses auteurs
annoncent que les idées s'appliquent plus largement — ce qui n'est pas l'établir.

Cette itération termine, mais sous une condition qu'il faut nommer. Chaque optimisation retire une
construction~: la déforestation supprime une structure intermédiaire, la défonctionnalisation une
application d'ordre supérieur, la fusion de boucles une itération. Sur ces trois-là, une mesure
entière décroît strictement et l'itération s'arrête. L'_inlining_ fait exception~: il ne retire une
indirection qu'en dupliquant un corps, de sorte que la taille du terme peut croître, et avec elle le
nombre de contraintes qu'un tour suivant engendrera. La terminaison ne suit donc pas de la seule
décroissance~; elle exige que l'intégration soit elle-même budgétée. La saturation par égalité l'est
déjà — son graphe de réécritures est borné par un grade ---, et c'est le même dispositif que
l'intégration adopte~: un _budget de spécialisation_, grade porté par l'unité de compilation, que
chaque intégration et chaque monomorphisation décrémentent, et dont l'épuisement arrête la
duplication au lieu d'échouer. Ce budget est le même objet que celui qui borne la monomorphisation,
laquelle n'est qu'une intégration dirigée par les types~: une seule décision les gouverne.
L'itération est alors un point fixe atteint en un nombre de tours borné par la somme des budgets,
chaque tour terminant puisque les trois autres optimisations font strictement décroître une mesure
entière que rien n'augmente.

Pour ne pas dépendre d'une preuve non vérifiée, chaque indice fourni par le développeur —
`invariant`, `witness`, `lemma` — est soumis, en mode `+verify`, à un test par propriétés dont le
nombre d'itérations reste lui-même un grade borné. Un indice qui échoue ainsi entraîne le rejet
immédiat de la preuve qui s'appuyait sur lui (`ERR-SMT-002`), plutôt que de laisser une incohérence
se propager jusqu'au binaire final. Lorsque la contrainte est assez simple, le joint du treillis de
précision (chapitre 2, §{num "sec:c2-adjonctions-et-enrichissement"}[]) fournit directement la plus
petite borne supérieure requise, économisant l'appel au solveur externe pour tout ce qui ne l'exige
pas réellement.
