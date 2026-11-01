-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "Discussion empirique" =>
%%%
file := "c5-empirical-discussion"
tag := "c5-empirical-discussion"
%%%

{label "sec:c5-empirical-discussion"}

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
{cite "coblenzCanAdvancedType2020"}[]. Sur les vingt participants initiaux (dix par condition),
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
