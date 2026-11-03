-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C5.UniversalSExpressions
import Spec.C5.SpecialisedNotations
import Spec.C5.ElaborationTheorem
import Spec.C5.WhatAMacroDeclares
import Spec.C5.InPractice
import Spec.C5.EmpiricalDiscussion

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "SYNTAXE ET MISE EN PRATIQUE" =>
%%%
file := "c5-syntaxe"
tag := "c5-syntaxe"
%%%

{refsection "c5-syntaxe"}

Ce chapitre définit la surface de K7PL sans ajouter de sémantique aux trois chapitres précédents : une grammaire
symbolique préfixée exprime les distinctions déjà établies. Ses délimiteurs indiquent le fragment qui gouverne une
expression et les frontières auxquelles ce fragment change. Ce choix privilégie une syntaxe fixe et une compilation
homogène, au prix d'une extension du noyau plus limitée et d'un risque de verbosité.

La surface définie dans ce chapitre est implémentée avec le Framework K ; les définitions exécutables du dépôt
(`src/k/`) portent la grammaire, la lecture des couches et les codes de refus que l'annexe {num "sec:annexe-a-codes"}[]
définit normativement.

La délimitation par régions répond au problème identifié dans les systèmes substructurels dont les contraintes d'usage
sont définies globalement : une discipline unique s'adapte mal à des domaines aux besoins hétérogènes
{cite "herlihyModularSubstructuralConstraints2026"}[]. K7PL en retient toutefois trois fragments fixes, là où cette
littérature explore la personnalisation des contraintes ; les usages mixtes restent donc hors de portée. La seconde
limite est ergonomique : dans l'étude du typage quantitatif des circuits, les auteurs constatent que la linéarité peut
imposer une verbosité excessive, au point d'envisager de l'assouplir {cite "demuijnck-hughesWiringCircuitsEasy2023"}[].
K7PL assume ce risque en faisant l'hypothèse que les changements de fragment sont suffisamment rares pour justifier un
marquage aux frontières plutôt qu'à chaque expression.

Ce choix a une conséquence sur la compilation. La nécessité d'un délimiteur ne peut pas toujours être vérifiée par la
syntaxe locale ou par simple comptage : elle dépend du fragment auquel appartient la fonction appelée. Le contrôle doit
donc intervenir en Phase 1.5, après résolution des noms, plutôt qu'en Phase 1. Un fichier isolé ne suffit pas à vérifier
ce marquage ; c'est le coût assumé de cette stratégie.

Le deuxième arbitrage concerne les glyphes. Ils ne constituent pas des primitives syntaxiques, mais des macros de la
bibliothèque standard qui s'expansent en constructions du noyau et en annotations. Un alias textuel vaut la même macro :
les deux graphies partagent donc, par construction, son associativité, sa priorité et son expansion.

Cette décision écarte les _macros de lecture_, qui étendent l'analyseur lui-même. L'enjeu n'est pas leur faisabilité
technique, mais la stabilité de la surface du langage. Lorsque l'analyse dépend de la configuration du programme lu, les
outils qui ne l'exécutent pas (analyseurs statiques, éditeurs et autres consommateurs du code) risquent de ne plus
disposer d'une grammaire commune. C'est le problème de l'« île » décrit dans la réflexion de Hickey sur l'histoire de
Clojure {cite "hickeyHistoryClojure2020"}[]. Avec des macros ordinaires, la grammaire reste fixe et l'AST demeure
lisible indépendamment des extensions de la bibliothèque. La staticité syntaxique est ainsi une propriété de conception,
formalisée au §{num "sec:c5-ce-qu-une-macro-declare"}[], et non une simple convention.

Le troisième arbitrage en découle : les R- et X-expressions appartiennent à la syntaxe du noyau plutôt qu'à une
bibliothèque extensible par de nouvelles formes syntaxiques de même niveau. Le noyau renonce ainsi à un point
d'extension supplémentaire, sans interdire la création d'autres langages de motifs. Ceux-ci se définissent en macros,
dans la bibliothèque, et doivent rester soumis aux règles communes d'élaboration.

L'enjeu ergonomique se déplace donc vers la composition de macros-fonctions au-dessus du noyau et vers les annotations
qu'il expose. Les glyphes tacites hérités d'APL, de BQN et d'Uiua relèvent de cette couche de bibliothèque, au même
titre qu'une fonction de recherche en logique floue : ils constituent des moyens de composition spécialisés, non des
primitives supplémentaires.

Ce choix s'inscrit dans deux traditions. Pour Iverson, la notation est un outil de pensée qui façonne les opérations
intellectuelles autant qu'elle les exprime {cite "iversonNotationToolThought1980a"}[]. Cette thèse motive l'exploration
des glyphes tacites de la couche 3, sans démontrer à elle seule leur supériorité ergonomique. La tradition Lisp apporte
un second principe : la représentation arborescente commune du code et des données permet de traiter configuration,
macro et AST comme des objets compatibles. La syntaxe parenthésée de la couche 2 s'inspire plus particulièrement de
Lisps applicatifs modernes (TXR Lisp {cite "kylhekuTxrReferenceManual"}[], Gerbil {cite "gerbilSchemeReference"}[], LFE
{cite "lispFlavoredErlang"}[]), dont les usages illustrent la possibilité d'orchestrer des systèmes réels à partir de
listes imbriquées.

{include 0 Spec.C5.UniversalSExpressions}

{include 0 Spec.C5.SpecialisedNotations}

{include 0 Spec.C5.ElaborationTheorem}

{include 0 Spec.C5.WhatAMacroDeclares}

{include 0 Spec.C5.InPractice}

{include 0 Spec.C5.EmpiricalDiscussion}
