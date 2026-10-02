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

#doc (Manual) "Ce que le solveur retourne" =>
%%%
file := "c6-ce-que-le-solveur-retourne"
tag := "c6-ce-que-le-solveur-retourne"
%%%

{label "sec:c6-ce-que-le-solveur-retourne"}
{label "sec:c6-exigence-compilation-bornee"}

Reste à dire ce que cette phase _rend_ lorsqu'elle échoue, et ce point n'est pas une question
d'outillage. P3 énonce qu'aucune abstraction ne dissimule un coût mémoire ; l'analogue à la
compilation est qu'_aucune abstraction ne dissimule un coût de vérification_. Rendre visible ce que
le solveur dépense n'est donc pas une commodité : c'est le même principe appliqué à l'autre moment,
et il commande ce qui suit. Un rejet n'est une contrainte que s'il est muet ; un refus qui nomme
l'obligation qu'il n'a pas su décider, ce qu'il y a consacré et ce qui la déciderait est une
assistance. La décision de rejeter plutôt que de dégrader n'en est pas défaite — elle reçoit ici ce
qu'elle doit comporter pour être tenable.

La mesure employée décide de tout le reste, et elle n'est pas le temps. Un délai dépend de la
machine ; il rendrait la compilation non reproductible, ce qui heurte l'objectif que ce document
s'est fixé. Un _compte de ressource reproductible_ — mesure abstraite du coût de vérification qui ne
dépend que de la formule d'entrée et de la configuration du solveur — est en revanche un grade :
déterministe, additif, décrémentable. Il se loge dans l'appareil existant sans rien y ajouter, aux
côtés du budget de spécialisation. _Le budget du solveur est un compte de ressource, jamais un
délai._

Ce que le solveur reçoit ainsi, les autres phases le recevaient déjà, et cela s'énonce une fois pour
les quatre.

> *Exigence de compilation bornée.* Tout travail de compilation est borné par un grade porté par
> l'unité de compilation, et ce grade se mesure en _compte de ressource reproductible_ — jamais en
> délai.

Ce n'est pas un postulat, et la distinction n'est pas de forme : les postulats ne bougent que sur
infaisabilité et portent sur le _langage_, quand celle-ci porte sur son _compilateur_. Un manquement
ne serait donc pas un défaut du langage mais de l'outil qui le réalise — ce qui n'en fait pas une
exigence molle, mais une exigence dont le lieu de réparation est ailleurs.

Que ce grade soit porté par l'_unité de compilation_ appelle une observation qui dépasse le
compilateur, car elle referme une question de conception restée ouverte à trois endroits du
document. Une interface de module doit énoncer trois choses : ce qu'une unité exige de son
environnement, ce qu'elle est, et ce qu'elle produit dans le monde. Le jugement germinal du chapitre
1 en porte exactement trois.

::::thm (label := "thm:interface_jugement") (status := "definition")
:::title
l'interface d'une unité de compilation est son jugement
:::

:::statement +titled
Trois obligations, trois composantes

Le jugement $`\Delta \vdash_{\mathcal{G}} t : A \mid \mathcal{E}` porte exactement les trois
obligations d'une interface : $`\Delta` dit ce que l'unité _exige_, $`A` ce qu'elle _est_,
$`\mathcal{E}` ce qu'elle _produit_. C'est une définition : l'interface _est_ le jugement. Elle s'accompagne d'une clôture _locale_ : pour les formes de déclaration énumérées dans ce chapitre, aucune obligation ne demande une quatrième composante, et aucune des trois n'est vide de contenu d'interface.
:::

:::proofsketch
L'énoncé ne se démontre pas, il se _montre_ : il s'agit de vérifier, par énumération sur les formes
de déclaration de ce chapitre, que chacune se range dans l'une des trois composantes et qu'aucune
n'en demande une quatrième. L'énumération est finie et se conduit à la lecture. La clôture ne vaut que pour ces formes : elle est suffisante, non nécessaire, et une extension qui exigerait une quatrième composante — l'extension probabiliste du chapitre 4, dont le raisonnement statique demande deux notions que K7PL n'a pas — ne la contredit pas mais appelle la clause de révision de l'axiome (chapitre 1, §{num "sec:c1-axiomatique-germinale"}[]).
:::
::::

Deux échecs historiques symétriques donnent la mesure de cet énoncé, et c'est ce qui le rend
intéressant plutôt que tautologique. {rmq}[Chacun porte deux des trois obligations, aucun les
trois.] Standard ML a des signatures riches et pas d'effets dans son interface {cite "macqueenHistoryStandardML2020"}[].
Haskell a les effets dans ses types et pas de système de modules de cette richesse {cite "hudakHistoryHaskellBeing2007"}[].
L'un et l'autre ont payé cette absence par un dispositif séparé ajouté après coup.

Ce théorème est la jonction de trois pièces que ce document écrit dans trois chapitres sans les
relier : la théorie des modules du chapitre 4, le grade porté par l'unité de compilation ci-dessus,
et le jugement à trois composantes du chapitre 1. S'il tient, une interface n'a rien à déclarer que
le jugement ne porte déjà, et le langage n'a pas de langage de modules séparé à maintenir. S'il
tombe — s'il fallait une quatrième obligation —, K7PL rejoindrait les deux échecs ci-dessus et
devrait ajouter le dispositif qu'ils ont dû ajouter.

Une conséquence pratique en découle, et elle n'est pas confortable : si le grade est dans
l'interface, alors le changer change l'interface, et les unités dépendantes recompilent. C'est une
contrainte réelle, mais elle est du bon côté — la translucidité est ici l'honnêteté, et une
interface qui cacherait le grade cacherait un coût, ce que P3 interdit.

Les quatre sites en sont les instances, et aucun n'a été ajouté pour la satisfaire.

* Le budget de spécialisation, que chaque intégration et chaque monomorphisation décrémentent.

* La saturation par égalité, dont le graphe de réécritures est borné par un grade.

* Le test par propriétés des indices, dont le nombre d'itérations est lui-même un grade.

* Le compte de ressource du solveur, le quatrième et le dernier à l'avoir reçu. _L'exigence ne
  prescrit donc rien de neuf — elle nomme ce que le pipeline faisait déjà en quatre endroits sans le
  dire nulle part._

La clause qui interdit le délai est celle qui porte tout le reste. Un délai dépend de la machine ;
deux compilations d'une même source y donneraient des résultats différents, et la reproductibilité
du rejet (théorème {num "thm:rejet_reproductible"}[]) tomberait avec l'objectif de compilation
reproductible. Un compte de ressource, lui, est un grade : déterministe, additif, décrémentable.

Ce que cette exigence achète, enfin, se lit à côté de P3 et complète ce qu'il laissait ouvert. P3
dit qu'aucune abstraction ne dissimule un coût mémoire _à l'exécution_ ; l'exigence ci-dessus dit
que rien ne peut faire diverger _la compilation_. Les deux ensemble donnent la prédictibilité que ce
document revendique — l'une pour ce qui s'exécute, l'autre pour ce qui vérifie —, et l'audit qui
avait relevé que P3 ne gouverne pas la compilation trouve ici sa réponse : ce n'était pas à P3 de le
faire.

# Ce qu'un rejet dit
%%%
tag := "c6-ce-que-le-solveur-retourne-ce-qu-un-rejet-dit"
%%%

Quatre choses, et la dernière est ce qui rend les trois premières utilisables : l'obligation non
déchargée, énoncée dans le vocabulaire de la source et non dans celui du solveur ; sa localisation ;
le compte de ressource consommé ; et l'état du solveur à l'épuisement. De cette forme suit une
propriété que le développeur peut exiger.

::::thm (label := "thm:rejet_reproductible")
:::title
reproductibilité du rejet
:::

:::statement +titled
Deux compilations de la même source disent la même chose

À configuration de solveur fixée, et sous l'hypothèse $`D_{\mathrm{det}}` — tout parcours, toute
recherche et toute graine sont des fonctions de la source et du compte de ressource —, le message de
rejet est une fonction de la source seule : deux compilations d'un même programme produisent le même
message, à l'identique.
:::

:::proofsketch
Les quatre composantes du message sont chacune fonction de la source. L'obligation et sa
localisation se lisent sur la dérivation. La vérification est bidirectionnelle et non principale
(chapitre 3) : l'énoncé n'invoque donc pas une inférence principale, mais l'hypothèse
$`D_{\mathrm{det}}`, qui rend le choix des grades par défaut indépendant de l'ordre de parcours.
Le document en possède les deux moitiés — compte reproductible, budget relevé écrit dans la
source — et $`D_{\mathrm{det}}` les assemble ; c'est une exigence sur l'implémentation, non un
théorème du système de types.
Le compte de ressource ne dépend, par construction, que de la formule soumise et de la
configuration ; il est donc identique d'une exécution à l'autre et d'une machine à l'autre. L'état à
l'épuisement est fonction du compte. Le message l'est donc aussi.

_Ce que l'énoncé ne dit pas_, et la réserve est ce qui donne son sens au choix de la mesure : deux
compilations peuvent prendre des temps différents. Elles _disent_ la même chose sans _durer_ le même
temps, et c'est exactement pourquoi la mesure retenue est un compte et non un délai.

_Ce que l'énoncé achète._ Un message qui varierait d'une compilation à l'autre ne serait pas
actionnable : un développeur ne peut pas travailler contre un avis qui change. La reproductibilité
n'est donc pas une propriété agréable de plus, c'est la condition sans laquelle les trois points qui
suivent n'auraient pas d'objet.
:::
::::

# Ce qu'un rejet propose, et pourquoi il n'y a que trois voies
%%%
tag := "c6-ce-que-le-solveur-retourne-ce-qu-un-rejet-propose-et-pour"
%%%

Le solveur reçoit exactement trois choses : une formule, des indices, une borne de ressource. Une
obligation qu'il ne décharge pas ne peut donc être secourue qu'en agissant sur l'une des trois —
_découper_ l'obligation, _fournir_ un indice, _relever_ la borne. Il n'y a pas de quatrième voie, et
ce n'est pas une limite d'imagination : c'est la clôture de ce dont la procédure dispose. Le
raisonnement est celui que le chapitre 1 tient pour les trois strates du jugement — trois entrées,
trois recours, et aucune quatrième place à inventer.

Les deux premières voies emploient ce que le document possède déjà : le découpage est une écriture,
et les indices `invariant`, `witness` et `lemma` sont soumis au test par propriétés décrit
ci-dessus. La troisième porte une contrainte, et elle est structurelle plutôt que stylistique : _le
budget relevé doit être écrit dans la source_. S'il vivait dans une configuration, la
reproductibilité que le théorème {num "thm:rejet_reproductible"}[] établit se perdrait aussitôt — le
message dépendrait d'un fichier que la source ne mentionne pas, et l'objectif de compilation
reproductible deviendrait inatteignable.

# Comment le coût se voit avant le rejet
%%%
tag := "c6-ce-que-le-solveur-retourne-comment-le-cout-se-voit-avant"
%%%

Un profil de vérification par obligation, inspectable comme les grades le sont. Le budget cesse
alors d'être un couperet pour devenir une mesure, et une mesure visible est un profileur de preuve :
le développeur voit quelles obligations coûtent, comme il voit aujourd'hui ce qu'une structure
alloue.

Une conséquence en découle, qui n'est pas affaire d'outillage. _Le profil doit être disponible sur
les compilations qui réussissent_, et pas seulement sur celles qui échouent. Un profil réservé à
l'échec n'apprendrait le coût qu'au moment où il est devenu fatal, ce que P3 refuse : une
abstraction dissimulerait son coût de vérification jusqu'au dernier instant. C'est le postulat, et
non une préférence d'ergonomie, qui commande ici la disponibilité permanente.

# Ce que devient une obligation non déchargée
%%%
tag := "c6-ce-que-le-solveur-retourne-ce-que-devient-une-obligation"
%%%

Elle se rend comme un _trou_ typé. Le chapitre 3 (§{num "sec:c3-les-contraintes-de-valeur"}[]) pose
déjà le trou comme le terme le moins précis pour un type donné, et la complétion par narrowing comme
sa réponse ; une obligation non déchargée en est un cas. Le compilateur rend alors la contrainte que
le trou doit satisfaire au lieu d'un refus, et le rejet devient un dialogue.

Une distinction achève ce point, faute de quoi on croirait la décision de rejeter revenue. _Le rejet
reste terminal au niveau de l'artefact_ — aucun binaire n'est produit, et rien de ce qui a été
arbitré n'est défait. Il cesse de l'être _au niveau de la session d'édition_, où le trou permet de
continuer à travailler sur un programme incomplet. La frontière entre l'erreur et l'incomplétude
s'efface pour l'éditeur sans s'effacer pour le compilateur, et les deux exigences qui semblaient
s'opposer tiennent ensemble.

# Sur quoi ces quatre points reposent
%%%
tag := "c6-ce-que-le-solveur-retourne-sur-quoi-ces-quatre-points-rep"
%%%

Ce document exige de lui-même que toute affirmation d'ergonomie dise si elle repose sur un effet
mesuré, une préférence esthétique ou une contrainte structurelle, et cette exigence vaut ici aussi.

::::k7table (label := "tab:statut-solveur") (align := "Z{0.80}Z{1.20}")
:::caption
Statut de chacune des affirmations de cette section
:::

:::table +header
* * Ce qui est affirmé
  * Ce sur quoi cela repose
* * le rejet est reproductible
  * *structurel* — du compte de ressource
* * il n'y a que trois voies de recours
  * *structurel* — clôture des entrées du solveur
* * le budget relevé est dans la source
  * *structurel* — sans quoi la reproductibilité se perd
* * le profil est disponible en succès
  * *structurel* — l'analogue de P3 à la compilation
* * l'obligation devient un trou
  * *structurel* — le trou et le narrowing sont déjà posés
* * ces messages sont _plus clairs_
  * *rien de tel n'est affirmé ici*
:::
::::

Aucun de ces cinq points ne repose sur un effet mesuré, et aucun n'en a besoin : ce sont des
conséquences de l'appareil. Mais _ce que ce chapitre ne peut pas établir_ est qu'un développeur
placé devant ces messages s'en sorte mieux qu'avec d'autres. Cette question est empirique, elle
appelle un protocole, et le domaine est saturé d'affirmations qui n'en ont jamais reçu. Le protocole
existe et n'attend aucun prototype ; sa conduite est la seule chose qui manque à cette section.

Toutes les composantes du jugement sont désormais établies. C'est seulement à ce titre que la
compilation peut réécrire le terme : toute réécriture doit se justifier par un argument qui lui est propre,
syntaxique ou fondé sur le modèle mémoire ; leur formulation comme isomorphismes naturels dans _C_
relève de l'obligation P1b. Quatre familles s'y rangent.

* L'adjonction curry/uncurry et l'isomorphisme de Yoneda du chapitre 2
  (§{num "sec:c2-adjonctions-et-enrichissement"}[]) en fournissent deux instances.

* La déforestation et la fusion de boucles éliminent les structures intermédiaires.

* La saturation par égalité explore un graphe de réécritures borné par un grade.

* La défonctionnalisation et l'inlining statique des effets (chapitre 2,
  §{num "sec:c2-algebres-coalgebres-et-points"}[]) achèvent d'effacer toute indirection restante.
  Les projections de Futamura, réservées aux fonctions pures de couche 3 dont la terminaison est
  déjà prouvée, spécialisent un programme par évaluation partielle sans jamais risquer d'en changer
  le sens.

L'une de ces réécritures illustre ce que la composante $`\mathcal{E}` achète concrètement. La
curryfication ne s'optimise pas sûrement dans un langage ordinaire : décider si l'on peut regrouper
les arguments d'une fonction partiellement appliquée suppose de savoir si l'évaluation d'une
expression produira un effet, et l'expérience d'une bibliothèque écrite avec soin est qu'on ne le
sait _souvent pas_ {cite "berryLessonsDesignStandard1993"}[]. Chez K7PL, la question ne demande
aucune analyse : le jugement porte la réponse, et une expression d'effet neutre est reconnue comme
telle par lecture de son type. Un obstacle documenté à l'optimisation devient une conséquence du
jugement, et c'est le genre de bénéfice qu'une composante d'effet rend sans qu'on l'ait ajoutée pour
lui.

Deux réécritures appellent une correction du même ordre, et dans les deux cas c'est le grade qui la
porte. L'_intégration_ d'abord : ce chapitre en fait une exception à la décroissance — elle ne
retire une indirection qu'en dupliquant un corps — et en conclut que sa terminaison exige d'être
budgétée. Le budget est inutile sur le fragment qui compte. N'intégrer que les fonctions _appelées
une seule fois_ donne un système rétrécissant, dont la mesure décroît par construction, normalisable
en temps linéaire et _confluent_, de sorte que le choix de l'algorithme n'affecte pas la qualité du
code final {cite "appelShrinkingLambdaExpressions1997"}[]. Or « appelée une seule fois » est ce que
la composante d'usage du grade déclare : là où un compilateur ordinaire a besoin d'une analyse pour
l'établir, le jugement gradué la porte. Le budget se restreint donc au fragment hors grade, et la
confluence est acquise sur le reste — ce qui retire l'obligation de justifier un ordre
d'intégration.

La _défonctionnalisation_ ensuite, où deux énoncés sont confondus en un. Qu'elle soit un
isomorphisme naturel établit sa transparence sémantique, et ce chapitre en tire implicitement que
son résultat est bon. La transparence vaut de la _transformation_ ; la qualité du _résultat_ dépend
d'un choix que l'isomorphisme ne détermine pas, l'unité de spécialisation — une fonction d'ordre
supérieur employée avec deux arguments fonctionnels distincts se spécialise en deux fonctions
distinctes, et il faut décider si c'est ce qu'on veut {cite "brandonBetterDefunctionalizationLambda2023"}[].
L'argument de transparence est conservé ; ce qui ne l'est pas est la conclusion de qualité qu'on en
tirait.

Deux mécanismes de cette phase ont un compte rendu attesté. Les opérations d'effet et leurs
gestionnaires compilent par le style à _passage de capacités_ combiné au passage de continuations
itéré, l'idiome que ce document possède déjà — une capacité de couche 1 étant un canal linéaire. La
technique est générale : elle engendre du code dans tout langage à fonctions de première classe,
sans hypothèse sur la cible, avec des accélérations mesurées sur les langages existants à
gestionnaires ou à opérateurs de contrôle {cite "xieGeneralizedEvidencePassing2021"}[]. Le comptage
de références, que la couche 1 emploie là où le partage est gradué, n'est pas davantage un expédient
d'implantation à côté de la théorie. La relation entre la correction du typage linéaire et celle
d'une interprétation par comptage de références est établie au niveau d'abstraction exact dont un
abaissement a besoin : assez bas pour exprimer le partage et la copie, assez haut pour ne rien dire
de la disposition mémoire {cite "reinkingPerceusGarbageFree2021"}[].

Une difficulté propre à ce document doit être ajoutée ici, et elle vient de son choix de fondation
plutôt que de sa mise en œuvre. La théorie quantitative des types marque le jugement d'un indicateur
binaire — effacé ou présent — de sorte que l'effaçabilité d'une abstraction se lit _sur le
jugement_. La théorie graduée, qui la généralise, remplace cet indicateur par une modalité $`!_q A`.
Elle gagne en équations définitionnelles, et elle perd précisément cela : il n'est plus apparent
qu'une abstraction de type $`\Pi^q x{:}A.B` sera employée à l'exécution ou non, ce qui rend
l'effacement des _fermetures de fonction_ difficile {cite "HUANG"}[]. Le coût est donc localisé et
il tombe exactement sur la phase décrite ci-dessus. Il ne remet pas en cause le choix de la
gradation : la théorie quantitative ne saurait porter les quatre composantes du grade. Mais il
oblige à dire que l'effaçabilité d'une fermeture se décide ici par la composante d'usage et non par
lecture du jugement — une décision qui est un travail d'analyse là où la théorie quantitative n'en
demandait aucun.

Deux précisions rendent cette décision moins arbitraire qu'elle n'en a l'air. La première est que
l'effaçabilité au grade nul n'est pas une _définition_ mais un lemme, démontré dans une sémantique à
tas instrumentée : deux configurations initiales qui ne diffèrent que par l'affectation de variables
graduées zéro produisent des résultats identiques {cite "felicissimoDefinitionalProofIrrelevance2025"}[].
Le résultat va d'ailleurs au-delà du zéro, et c'est ce qui sert ici : est inutilisable tout grade
$`s` pour lequel la contrainte $`q + 1 \le s` est insatisfiable. La classe des ressources effaçables
se définit donc par une contrainte du semi-anneau et non par une valeur particulière, ce qui donne à
la phase d'effacement un critère décidable plutôt qu'un cas d'espèce.

La seconde est qu'une quatrième conception de l'effacement existe, que ce document n'a pas retenue
et dont il doit dire pourquoi. L'annotation y vit au _jugement_, et la règle d'application la
compose par une rencontre plutôt que par la multiplication d'un semi-anneau — l'argument n'étant
retenu que si le terme entier l'est _et_ si l'application l'est {cite "tejiscakDependentlyTypedCalculus2020"}[].
Elle traite en outre le filtrage et les motifs forcés, que les autres conceptions laissent de côté.
Son interaction avec les univers, elle, se règle en une phrase de ses auteurs : la stratification
des univers y est _orthogonale_ au propos, et les implantations sont attendues d'apporter la leur.
C'est aussi la position de ce document, et pour la même raison — l'annotation est portée par le
jugement, non par la sorte du type —, de sorte que l'interaction ne se produit tout simplement pas.

Elle se produit ailleurs, et la même source dit où : les systèmes qui modélisent l'effacement
_indirectement_, par un univers séparé ou par l'irrélevance, en héritent les limitations, et une
partie du calcul inutile cesse d'être effaçable — un programme normalement linéaire pouvant alors
s'exécuter en temps exponentiel. Le cas d'école est celui d'un univers réservé aux propositions, où
les indices d'une famille de types, qui sont ce que ce document manipule, ne s'effacent pas.

La forme que prendrait un abaissement à types préservés est en revanche connue, et elle est
instructive parce qu'elle défait une évidence. Défonctionnaliser dans un cadre dépendant ne consiste
pas à remplacer la flèche par un type de données — cette voie, qui fonctionne du simplement typé au
polymorphe, _échoue_ en présence de dépendance. Ce qui fonctionne est de remplacer l'abstraction par
une _étiquette de première classe_ dans un calcul à contexte double : un contexte de types comme
d'ordinaire, et un contexte de _définitions d'étiquettes_ qui associe à chaque étiquette le
télescope de ses variables libres, son type et son corps. Deux contraintes le rendent sain, et elles
sont sévères : les types peuvent mentionner les étiquettes, jamais l'inverse ; et le corps d'une
étiquette se type dans le contexte des étiquettes _précédentes_, de sorte qu'aucune étiquette ne se
référence elle-même. Une boucle infinie devient ainsi mal typée — non par une analyse de
terminaison, mais parce que sa signature est mal portée. Ce document a besoin de cette forme au
moment où sa Phase 6 défonctionnalise sous des types dépendants pragmatiques, et il n'a pas d'autre
voie connue.

Le terme optimisé descend enfin vers MLIR puis LLVM : les tableaux de couche 3 vers `memref.alloc`,
les automates du chapitre 4 vers le dialecte `K7PL.FSM`. Les correspondances de disposition du
chapitre 4 (théorème {num "thm:isomorphisme_memoire"}[]) rendent cette génération de code directe _dans le domaine de ce théorème_ — les tampons de couche 3 vers Arrow, les segments de couche 2 vers Cap'n Proto, pour les scalaires primitifs —, une transposition en $`O(n)` étant requise dès qu'une liste de structures est en jeu. L'édition de liens
qui referme le pipeline purge tout bloc de spécification — doctests, assertions `comptime` — sauf en
mode `+introspect`, garantie que le DAG de dépendance rend structurelle plutôt que déclarative
(`ERR-TOP-003`). Le binaire résultant, adressé par le condensat BLAKE3 de son AST normalisé plutôt
que par un numéro de version, identifie par un seul et même condensat deux programmes dont
l'écriture diffère mais dont les arbres coïncident après normalisation — la dépendance ne se rompt
jamais silencieusement. La normalisation décide ici une égalité _syntaxique canonique_, et rien de
plus : deux programmes de même sens dont les arbres normalisés diffèrent reçoivent deux adresses,
l'équivalence sémantique n'étant pas décidable.

Un mode `+dev` n'exécute que les trois premières phases, plus une version allégée de la Phase 4,
quand un mode `+release` seul engage les phases 5 à 7. Ce cache, comme le reste du pipeline,
s'appuie sur ce même hachage pour ne recompiler que ce qui a changé. En production, le remplacement
d'un acteur ne repasse jamais par ce pipeline : l'orchestrateur substitue directement l'image
compilée par échange de pointeur, draine l'ancien acteur, et rejoue le journal Cap'n Proto pour
reconstituer l'état exact — le JIT, lui, reste exclusif au REPL interactif.

Deux choses doivent être dites de cette descente, et la première défait une crainte que le document
laissait planer. On suppose volontiers qu'une discipline de ressource s'efface au passage vers une
représentation de bas niveau, faute d'une cible capable de la porter. Ce n'est pas le cas : il
existe une extension typée de WebAssembly où le type d'une fonction est polymorphe sur les
emplacements mémoire, les tailles, les types _et les qualificateurs_ — c'est-à-dire sur les
annotations de linéarité elles-mêmes {cite "fitzgibbonsRichWasmBringingSafe2024"}[]. La couche 1
n'aurait donc pas à abandonner sa discipline pour atteindre une cible portable, et la visée déclarée
de cette extension est la situation de la passerelle du chapitre 4 : faire coexister du code sûr et
du code étranger sans que le premier perde ses garanties. La même famille de travaux porte les
gestionnaires d'effets jusqu'à cette cible {cite "phipps-costinContinuingWebAssemblyEffect2023"}[],
ce qui referme le second bout du même trajet.

La seconde est une réserve sur le choix d'infrastructure, et elle vise ce document plutôt qu'un
tiers. Écrire un dialecte de types linéaires pour une infrastructure dont le système de types est
faible coûte cher, et ce n'est pas la seule voie disponible. Une représentation intermédiaire fondée
sur le lambda-calcul et les types _dépendants_, extensible à tout niveau par des greffons qui
prennent en charge l'optimisation et l'abaissement de leurs propres axiomes, porte un grade sans
qu'il faille écrire un dialecte {cite "leissaMimIRExtensibleTypeSafe2025"}[]. Ce document a choisi
son infrastructure sans que la comparaison ait été faite, et le dire est plus honnête que de
présenter ce choix comme allant de soi. Ce qui le justifie tient à la maturité de l'outillage et non
à une supériorité technique établie.

Cet abaissement appelle un énoncé que le document n'a nulle part, et son absence n'est pas une
lacune de présentation. La stabilité du typage par réduction énoncée au chapitre 3 couvre
l'évaluation _et_ l'abaissement, mais sans grade ; la préservation graduée du §{num "sec:g-semantique"}[] (théorème {num "thm:preservation"}[])
porte les grades, mais ne couvre que l'évaluation. Rien, entre les deux, n'établit que descendre
vers MLIR préserve ce que le chapitre 1 a posé — et c'est le trajet qui relie les deux bouts de ce
document.

La forme de l'énoncé manquant est en revanche connue, et la chose a été poussée loin ailleurs : la
compilation _séparée_ a été vérifiée jusqu'au format d'exécutable lui-même {cite "wangCompCertELFVerifiedSeparate2020"}[].
La chaîne peut donc être démontrée correcte jusqu'au fichier objet, ce qui déplace la question de
l'édition de liens : elle n'est pas de savoir si un éditeur externe est évitable, mais ce que coûte
de le vérifier. Ce document ne paie pas ce coût et doit le dire.

Sa _difficulté_ mérite en revanche d'être rapportée, car ce document la rencontrera au même endroit
et pour la même raison. Elle tient à deux vues du liage qui ne se recouvrent pas. À l'étage
abstrait, un programme est une application partielle des identifiants vers les définitions : le
lieur est _insensible à l'ordre_ et peut réarranger à sa guise. À l'étage concret, les définitions
sont fondues en sections atomiques suivant un ordre particulier, et le lieur les concatène comme des
boîtes noires — l'ordre y décide du résultat. La commutativité entre liage et compilation, sur
laquelle repose toute la compilation séparée vérifiée, _casse_ à la transition entre les deux.

La solution retenue est celle qui coûte le moins, et sa forme est le vrai acquis pour ce document.
La voie naïve consisterait à donner à l'étage abstrait la vue concrète, après quoi la commutativité
devient évidente. Elle a deux prix, nommés par les auteurs : le liage de _tous_ les étages se trouve
contraint par la manière dont se lient des fichiers objets, et le cadre de compilation séparée comme
ses preuves demandent une lourde retouche. La voie légère introduit à la place une _équivalence
syntaxique_ entre programmes et démontre qu'elle commute avec les deux sortes de liage, ce qui
permet de transiter de l'un à l'autre _sans toucher à aucune preuve existante_.

Ce que ce document en retient dépasse le liage, et c'est ce qui rend cette lecture utile ici.
L'écart entre un étage insensible à l'ordre et un étage qui en dépend est celui qu'il rencontre
_deux_ fois. Une première entre l'espace de noms, sous-catégorie large sans ordre (chapitre 4,
§{num "sec:c4-echelle-du-systeme"}[]), et les sections de l'abaissement. Une seconde entre un
contexte qui est une application finie et le contexte _ordonné_ qu'une discipline d'échange
restreint imposerait (chapitre 3, §{num "sec:c3-le-systeme-gradue"}[]). Dans les deux cas, la leçon
est la même et elle est méthodologique : ne pas concrétiser l'étage abstrait, mais poser une
équivalence et démontrer qu'elle commute des deux côtés.

Reste le point propre au grade, et il n'est pas acquis. Aucune de ces vérifications ne porte sur un
langage dont le jugement _compte_ les usages~; ce qui transporte est la forme de l'énoncé et la
méthode de pontage, non un résultat sur les grades. Écrire que la méthode transporte est donc exact,
écrire que le résultat transporte serait faux. Un obstacle plus ancien se tient d'ailleurs en amont
de celui-là, et il a un nom : l'équivalence par les noms contre l'équivalence par la structure,
compliquée par la _générativité_ — une instance de module engendrant des types nouveaux. Le problème
est bien posé depuis longtemps et se traite _sans estampilles_, ce qui importe ici parce que le
hachage par lequel ce chapitre identifie ses unités est précisément une estampille {cite "leroySyntacticTheoryType1996"}[].
Ce que ce document adopte reste le hachage, pour ce qu'il donne par ailleurs — le cache et
l'équivalence sémantique de deux programmes syntaxiquement distincts —, mais il ne peut plus se
présenter comme la seule voie.

::::thm (label := "thm:abaissement_grades") (status := "conjecture") (level := "compilation")
:::title
l'abaissement préserve le jugement gradué
:::

:::statement +titled
Ce qui est garanti en haut vaut encore en bas

Si $`\Delta \vdash c : C \mid \varepsilon` et si $`\llbracket c \rrbracket` est l'image de $`c` par
l'abaissement vers MLIR, alors il existe des traductions $`\llbracket \Delta \rrbracket`,
$`\llbracket C \rrbracket` et $`\llbracket \varepsilon \rrbracket` telles que
$$`\llbracket \Delta \rrbracket \vdash \llbracket c \rrbracket : \llbracket C \rrbracket \mid \llbracket \varepsilon \rrbracket,`
et la traduction ne relâche aucune composante du grade.
:::

:::proofsketch
Instance du schéma de préservation par traduction (chapitre 2,
§{num "sec:c2-six-schemas-de-metatheorie"}[], théorème {num "thm:schema_preservation"}[]), la
traduction étant ici l'abaissement. Sa condition est que chaque règle d'abaissement envoie une
dérivation source sur une dérivation cible, et le schéma conclut. Le travail est donc par phase et
non global : chacune des passes du pipeline s'accompagne de sa propre obligation, et une passe qui
n'accomplit qu'une tâche se vérifie isolément. Le grade étant une grandeur statique, ce qu'il faut
établir n'est pas qu'aucun observateur cible ne distingue plus que la source, mais que l'annotation
portée par la source a une image dans la cible et que cette image ne l'affaiblit pas.
:::
::::

La distinction qui commande cet énoncé est celle qu'établit la littérature sur la compilation
vérifiée : préserver le _comportement_ et être _pleinement abstrait_ ne sont pas la même exigence {cite "pattersonNext700Compiler"}[],
et c'est la première qui est en jeu ici.

Ce théorème n'est pas démontré, et le projet se donne pour objectif de le démontrer : la préservation graduée de bout en bout est une revendication _déclarée_, non une réserve à abandonner. Le chemin n'en dénature pas la portée : la preuve se conduit passe par passe, sur le fragment dont les fonctions d'ordre supérieur sont monomorphisées et inlinées avant l'émission, puis s'étend à mesure que la défonctionnalisation quantitative le permet. Tant qu'elle n'est pas conduite, l'énoncé reste une conjecture et aucune prose ne le dit acquis. {rmq}[Son absence était invisible tant que deux énoncés voisins
passaient pour un seul.] Il est énoncé parce que son absence restait invisible tant que la stabilité
du chapitre 3 et la préservation du §{num "sec:g-semantique"}[] passaient pour deux formulations de la même chose. La
première est plus large sur ce qu'elle couvre, la seconde plus fine sur ce qu'elle porte : leur
intersection laisse l'abaissement gradué sans énoncé.

L'état de l'art doit être donné avec ses statuts, car ils diffèrent. La littérature fournit la forme
de la règle que cet énoncé devra porter : dans un calcul défonctionnalisé quantitatif, l'usage total
d'une étiquette est la somme des usages de chaque contexte, chacun multiplié par l'usage désigné de
son argument — soit $`\sum_i q_i \Gamma_i`, qui est la forme que $`\boxtimes` généralise. Mais les
deux moitiés n'ont pas le même statut : la défonctionnalisation dépendante est établie et publiée,
tandis que sa version quantitative est présentée comme une conjecture dont les preuves sont
annoncées et non faites {cite "HUANG"}[]. La forme est donc connue et le résultat ne l'est pas. Ce
document n'a ni à s'appuyer sur ce qui n'existe pas, ni à ignorer que la forme est disponible : il
énonce son obligation en sachant quelle règle elle devra satisfaire.

S'il tient, la garantie graduée traverse le compilateur et le binaire produit porte ce que le source
promettait. S'il tombe, le grade s'arrête à la sortie du vérificateur, et toute borne de coût
annoncée dans une interface cesse de valoir du code exécuté.

Avant cet abaissement final, l'AST aplati — table des symboles, graphe d'appel, annotations de type
et de coût — reste lui-même exportable sous forme de tableaux Arrow columnaires, selon un schéma
versionné qui en garantit la stabilité. Cette version n'est pas un simple numéro. Chaque
enregistrement déclare l'espace réservé à son bloc racine, de sorte qu'un lecteur d'une version
antérieure franchit sans le comprendre ce qu'une version ultérieure y a ajouté. Le mécanisme est
éprouvé par les encodages binaires à schéma, où la longueur de bloc déclarée est ce qui permet de
décoder un message dont le gabarit a été étendu depuis {cite "fixTradingCommunitySBE2020"}[].

L'en-tête d'un artefact K7PL porte à cette fin trois champs : un identifiant de schéma, qui désigne
la forme d'AST attendue ; une version, qui en donne la révision ; et la longueur du bloc racine, qui
borne l'espace réservé aux champs de cette révision. Un lecteur d'une révision antérieure lit les
champs qu'il connaît, puis se déplace de la longueur déclarée pour trouver la suite, sans avoir à
comprendre ce qui a été inséré entre-temps.

Une limite l'accompagne, et elle est stricte : ce qui peut être sauté ne peut jamais être ce qui est
vérifié. Le mécanisme convient à un artefact que l'on transporte, non à une dérivation que l'on
contrôle ; la re-vérification que décrit l'annexe {num "sec:annexe-sugoi"}[] porte sur l'AST entier, jamais sur les seuls
champs qu'un lecteur donné sait lire. Cette exigence n'est pas un théorème mais une règle, et elle
s'énonce par ce qu'elle interdit~: un vérificateur qui rencontre un identifiant de schéma ou une
révision qu'il ne connaît pas _rejette_ l'artefact, au lieu d'en franchir les champs inconnus. Le
mécanisme de bloc déclaré reste alors ce pour quoi il est fait — transporter un artefact vers un
lecteur qui n'a pas à tout comprendre — sans jamais servir à contrôler une dérivation. Le mode de
défaillance que cette règle ferme est précis~: un compilateur qui sauterait des champs vérifierait
un programme amputé, puis signerait le programme entier.

Cette sérialisation permet à des outils tiers — vérificateurs formels, analyseurs statiques,
assistants fondés sur un modèle de langage — de lire le programme compilé comme une donnée
structurée plutôt que comme un texte à reparser, et de proposer des corrections ou des preuves sans
jamais toucher au code source. Chaque nœud y porte un `provenance_id` — fichier, ligne, colonne,
composant d'origine — qui traverse le pipeline jusqu'au binaire final via les métadonnées
LLVM/DWARF. En cas de panne, le superviseur remonte cette chaîne de causalité jusqu'à la définition
source exacte, plutôt que de s'arrêter à l'adresse mémoire fautive.
