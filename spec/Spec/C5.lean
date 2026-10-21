-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C5.SExpressionsUniverselles
import Spec.C5.NotationsSpecialisees
import Spec.C5.LeTheoremeDElaboration
import Spec.C5.CeQuUneMacroDeclare
import Spec.C5.MiseEnPratique

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "SYNTAXE ET MISE EN PRATIQUE" =>
%%%
file := "c5-syntaxe"
tag := "c5-syntaxe"
%%%

{refsection "c5-syntaxe"}

Ce chapitre définit la surface de K7PL sans ajouter de sémantique aux trois chapitres précédents :
une grammaire symbolique préfixée exprime les distinctions déjà établies. Ses délimiteurs indiquent
le fragment qui gouverne une expression et les frontières auxquelles ce fragment change. Ce choix
privilégie une syntaxe fixe et une compilation homogène, au prix d'une extension du noyau plus
limitée et d'un risque de verbosité.

La délimitation par régions répond au problème identifié dans les systèmes substructurels dont les
contraintes d'usage sont définies globalement : une discipline unique s'adapte mal à des domaines aux
besoins hétérogènes {cite "herlihyModularSubstructuralConstraints2026"}[]. K7PL en retient toutefois
trois fragments fixes, là où cette littérature explore la personnalisation des contraintes ; les
usages mixtes restent donc hors de portée. La seconde limite est ergonomique : dans l'étude du typage
quantitatif des circuits, les auteurs constatent que la linéarité peut imposer une verbosité excessive,
au point d'envisager de l'assouplir {cite "demuijnck-hughesWiringCircuitsEasy2023"}[]. K7PL assume ce
risque en faisant l'hypothèse que les changements de fragment sont suffisamment rares pour justifier
un marquage aux frontières plutôt qu'à chaque expression.

Ce choix a une conséquence sur la compilation. La nécessité d'un délimiteur ne peut pas toujours être
vérifiée par la syntaxe locale ou par simple comptage : elle dépend du fragment auquel appartient la
fonction appelée. Le contrôle intervient donc en Phase 1.5, après résolution des noms, plutôt qu'en
Phase 1. Un fichier isolé ne suffit pas à vérifier ce marquage ; c'est le coût assumé de cette
stratégie.

Le deuxième arbitrage concerne les glyphes. Ils ne constituent pas des primitives syntaxiques, mais
des macros de la bibliothèque standard qui s'expansent en constructions du noyau et en annotations.
Un alias textuel désigne la même macro : les deux graphies partagent donc, par construction, son
associativité, sa priorité et son expansion.

Cette décision écarte les _macros de lecture_, qui étendent l'analyseur lui-même. L'enjeu n'est pas
leur faisabilité technique, mais la stabilité de la surface du langage. Lorsque l'analyse dépend de
la configuration du programme lu, les outils qui ne l'exécutent pas — analyseurs statiques, éditeurs
et autres consommateurs du code — risquent de ne plus disposer d'une grammaire commune. C'est le
problème de l'« île » décrit dans la réflexion de Hickey sur l'histoire de Clojure
{cite "hickeyHistoryClojure2020"}[]. Avec des macros ordinaires, la grammaire reste fixe et l'AST
demeure lisible indépendamment des extensions de la bibliothèque. La staticité syntaxique est ainsi
une propriété de conception, formalisée au §{num "sec:c5-ce-qu-une-macro-declare"}[], et non une
simple convention.

Le troisième arbitrage en découle : les R- et X-expressions appartiennent à la syntaxe du noyau
plutôt qu'à une bibliothèque extensible par de nouvelles formes syntaxiques de même niveau. Le noyau
renonce ainsi à un point d'extension supplémentaire, sans interdire la création d'autres langages de
motifs. Ceux-ci se définissent en macros, dans la bibliothèque, et restent soumis aux règles communes
d'élaboration.

L'enjeu ergonomique se déplace donc vers la composition de macros-fonctions au-dessus du noyau et vers
les annotations qu'il expose. Les glyphes tacites hérités d'APL, de BQN et d'Uiua relèvent de cette
couche de bibliothèque, au même titre qu'une fonction de recherche en logique floue : ils constituent
des moyens de composition spécialisés, non des primitives supplémentaires.

Ce choix s'inscrit dans deux traditions. Pour Iverson, la notation est un outil de pensée qui façonne
les opérations intellectuelles autant qu'elle les exprime
{cite "iversonNotationToolThought1980a"}[]. Cette thèse motive l'exploration des glyphes tacites de
la couche 3, sans démontrer à elle seule leur supériorité ergonomique. La tradition Lisp apporte un
second principe : la représentation arborescente commune du code et des données permet de traiter
configuration, macro et AST comme des objets compatibles. La syntaxe parenthésée de la couche 2
s'inspire plus particulièrement de Lisps applicatifs modernes — TXR Lisp, Gerbil et LFE — dont les
usages illustrent la possibilité d'orchestrer des systèmes réels à partir de listes imbriquées.

Ces justifications conceptuelles ne suffisent pas à établir la facilité d'apprentissage de K7PL. Les
résultats empiriques disponibles éclairent certaines objections, mais leur portée doit être délimitée.

Une étude comparant six langages, dont un témoin doté de mots-clés générés aléatoirement, montre que
Java et Perl, représentatifs d'une syntaxe de tradition C, n'obtiennent pas de taux d'exactitude
significativement supérieurs à ce témoin, contrairement à Python, Ruby et Quorum
{cite "stefikEmpiricalInvestigationProgramming2013"}[]. Ce résultat affaiblit l'argument selon lequel
une syntaxe conventionnelle serait nécessairement plus accessible ; il ne démontre pas la supériorité
d'une notation symbolique. L'étude porte sur des novices, des tâches d'exactitude et un contexte
d'enseignement, non sur la composition de trains par des praticiens. Le transfert à K7PL reste donc
à établir.

Une étude contrôlée randomisée portant sur Obsidian, qui combine propriété, actifs et typestate,
fournit un résultat plus directement défavorable à l'hypothèse d'une utilisation sans surcoût
{cite "coblenzCanAdvancedType2020"}[]. Sur les vingt participants initiaux — dix par condition —,
quatorze ont été retenus pour l'analyse. Quatre participants sur dix dans la condition Obsidian,
contre un dans la condition Solidity, n'ont pas disposé de suffisamment de temps pour achever une
solution jugée satisfaisante. Un participant d'Obsidian a abandonné après une heure quinze. Sur la
tâche ouverte _Casino_, le temps moyen parmi les solutions compilantes analysées était de 64 minutes
pour Obsidian, contre 37 pour Solidity ; cette différence était statistiquement significative, mais
l'effectif était faible et les groupes comparés potentiellement biaisés par les performances aux
tâches précédentes. Les tâches antérieures ne montraient pas le même écart de temps.

La portée de ce résultat reste limitée : tutoriel bref, langage distinct de K7PL, petit effectif et
tâche complexe. Il suffit néanmoins à interdire de présenter l'utilisabilité de traits comparables
comme acquise. K7PL peut revendiquer les garanties que son système entend établir ; le coût
d'apprentissage et d'utilisation de ces garanties reste une question empirique ouverte.

Une étude complémentaire examine les obstacles à l'adoption des langages à vérification intégrée à
partir de discussions publiques de développeurs, puis d'une enquête déclarative
{cite "oliveiraWhatChallengesDevelopers2025"}[]. Elle identifie principalement une courbe
d'apprentissage abrupte et des problèmes d'utilisabilité. Ses recommandations concernent notamment
les interfaces des outils, les ressources pédagogiques et l'intégration aux environnements de
développement. Ces résultats situent les difficultés d'adoption dans l'apprentissage et l'outillage
autant que dans les garanties du langage. Ce document développe surtout le premier aspect ; le
chapitre 6 décrit le pipeline d'outillage sans prétendre en fournir une réalisation achevée. Ce
déséquilibre constitue une limite de portée, non une preuve d'utilisabilité.

La littérature empirique du nommage est elle aussi moins directement pertinente qu'il n'y paraît.
Une revue systématique consacrée à la lisibilité du code recense 54 études primaires, dont onze sur
les conventions de nommage. Aucune de ces onze études ne porte spécifiquement sur les noms de
fonctions ou de méthodes : neuf concernent les identifiants en général et deux les noms de variables
{cite "oliveiraEvaluatingCodeReadability2020"}[]. Or K7PL fixe un ensemble fini de noms de fonctions,
tandis que la littérature examine principalement des identifiants produits par les programmeurs et
régis par des conventions. Les résultats ne sont donc pas directement transposables.

Cette revue invite également à distinguer les mesures observées des perceptions déclarées : trente
études sur 54 recueillent l'opinion des participants, neuf en font leur unique variable de réponse,
37 % ne mobilisent qu'une compétence cognitive et 5 % seulement observent un indicateur physique. Un
résultat recensé va à l'encontre de l'intuition selon laquelle la brièveté faciliterait toujours la
lecture : les identifiants courts peuvent prendre davantage de temps à comprendre. La brièveté ne
constitue donc pas, à elle seule, un critère de qualité ; aucune des conventions de nommage exposées
ici ne repose sur cette hypothèse.

Les comparaisons tirées de grands corpus exigent une précaution supplémentaire. L'étude DéjàVu porte
sur 4,5 millions de projets GitHub non forkés et plus de 428 millions de fichiers, dont seulement
85 millions sont uniques. La duplication varie fortement selon les écosystèmes : environ 6 % des
fichiers JavaScript sont distincts, contre 60 % des fichiers Java
{cite "lopesDejaVuMapCode2017"}[]. Un comptage brut des conventions de nommage par langage sur un tel
corpus pondérerait différemment les écosystèmes selon leur taux de duplication et pourrait surestimer
l'homogénéité des plus dupliqués. Ce chapitre ne fonde donc aucune de ses conventions sur de telles
fréquences.

La conception d'un langage exige ainsi de distinguer les arguments formels, les choix d'ingénierie et
les résultats empiriques, sans faire passer les uns pour les autres. La littérature sur la conception
interdisciplinaire des langages insiste sur cette articulation
{cite "coblenzInterdisciplinaryProgrammingLanguage2018"}[]. Son application impose ici de rapporter
aussi les résultats défavorables, de circonscrire leur domaine de validité et de ne pas extrapoler
au-delà des populations ou des tâches étudiées. Les données disponibles ne démontrent ni la supériorité
ergonomique de la syntaxe de K7PL ni l'inutilité de ses garanties : elles identifient des hypothèses
de conception et des coûts potentiels qu'une évaluation propre au langage devra mesurer.

{include 0 Spec.C5.SExpressionsUniverselles}

{include 0 Spec.C5.NotationsSpecialisees}

{include 0 Spec.C5.LeTheoremeDElaboration}

{include 0 Spec.C5.CeQuUneMacroDeclare}

{include 0 Spec.C5.MiseEnPratique}
