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

Les trois chapitres précédents ont défini K7PL sans montrer à quoi il ressemble sur une page.
Celui-ci comble l'écart sans introduire le moindre contenu sémantique nouveau : une seule grammaire
— l'expression symbolique préfixée — porte à sa surface les distinctions déjà établies. Un
délimiteur n'invente rien ; il annonce au compilateur, au seul endroit où cette annonce a un coût,
lequel des trois fragments gouverne l'expression qu'il ouvre. Deux réserves portent sur le
dispositif plutôt que sur son réglage. La délimitation par régions répond bien au défaut des
systèmes substructurels bâtis sur une discipline globale unique, mal adaptée aux motifs d'usage
hétérogènes {cite "herlihyModularSubstructuralConstraints2026"}[]. Mais ce travail tient pour acquis
que les contraintes soient personnalisables, quand K7PL en fige trois — choix défendable pour un
langage autonome, qui n'en exclut pas moins les usages mixtes. Et là où le typage quantitatif a été
appliqué aux netlists, les auteurs concluent sur le risque que la linéarité rende le langage
inutilement verbeux, jusqu'à envisager d'y renoncer {cite "demuijnck-hughesWiringCircuitsEasy2023"}[].
C'est le risque principal du dispositif, que ce chapitre ne conjure qu'en pariant sur la rareté des
changements de fragment.

Trois arbitrages en découlent, dont le prix est nommé plutôt que caché. Un délimiteur marque les
points où le fragment change, non chaque expression : lecture conforme au principe de Flat-Wiring.
Mais qui interdit de vérifier le marquage par simple comptage, décider si un délimiteur est requis
supposant de connaître le fragment de la fonction appelée. Le marquage est donc vérifié en Phase
1.5, après résolution des noms, et non en Phase 1 : un fichier isolé ne suffit pas à l'établir, ce
qui est le prix de la lecture retenue.

Le deuxième porte sur le statut des glyphes, et il détermine la place qu'ils occupent dans le
langage. Un glyphe n'est pas une notation primitive : c'est une _macro_ de la bibliothèque standard,
qui s'expanse en constructions du noyau portant l'algorithme et ses annotations. Son alias textuel
n'est pas une autre notation mais un autre nom de la même macro, de sorte qu'associativité et
priorité sont celles de l'expansion — identiques par construction, quelle que soit l'orthographe
employée.

La solution que ce choix écarte serait la plus naturelle dans la tradition dont ce chapitre se
réclame : faire du glyphe une _macro de lecture_, c'est-à-dire une extension de l'analyseur
lui-même. L'argument contre est de portée et non de mécanique. Un langage dont la surface est
extensible par l'analyseur devient une _île_ — l'outillage extérieur, les analyseurs statiques, les
éditeurs, tout ce qui lit du code sans l'exécuter, cesse de pouvoir le lire {cite "hickeyHistoryClojure2020"}[].
Un glyphe qui est une macro ordinaire laisse la grammaire fixe et l'AST lisible par quiconque ; une
macro de lecture les rend dépendants du programme lu. C'est le même motif qui fait de la staticité
de la syntaxe un théorème plutôt qu'une convention (§{num "sec:c5-ce-qu-une-macro-declare"}[]).

La conséquence dépasse la question de l'affichage : la difficulté de K7PL est de comprendre le noyau
et ses annotations, et l'ergonomie vient de macro-fonctions composées que des experts préparent
au-dessus de lui, comme le ferait une bibliothèque. Les glyphes tacites hérités d'APL, BQN et Uiua
sont de cet ordre, au même titre qu'une recherche en logique floue : de l'outillage de bibliothèque,
non des primitives du langage.

Ce pari appelle un état de la mesure, écrit ici plutôt qu'attendu d'un relecteur. L'argument adverse
le plus courant — la syntaxe conventionnelle serait plus accessible — perd son appui. Une mesure des
taux d'exactitude de novices sur six langages, dont un témoin aux mots-clés tirés au hasard de la
table ASCII, trouve que les langages à syntaxe traditionnelle de type C, Perl et Java ne donnent
_pas_ de taux significativement supérieurs à ce témoin, tandis que ceux qui s'en écartent, si {cite "stefikEmpiricalInvestigationProgramming2013"}[].
Le résultat est négatif et non positif : il retire un appui à l'objection, il n'établit pas qu'un
glyphe vaille mieux qu'un mot. Et son cadre — des novices, des tâches d'exactitude, un contexte
d'enseignement — n'est pas celui d'un praticien qui compose des trains. La question du transport
doit donc être posée dans la même phrase que la citation, et elle reste ouverte.

La mesure qui porte le plus directement sur ce document lui est en revanche _défavorable_, et
l'omettre serait la faute que sa méthode bibliographique interdit. Un essai contrôlé randomisé sur
la propriété, les actifs et le typestate — le jeu de traits même de ce langage — trouve la condition
à types avancés plus _lente_, à variance élevée. Quatre participants sur dix n'y ont plus assez de
leurs quatre heures pour se déclarer satisfaits, contre un seul au témoin, et un abandon survient
après une heure quinze {cite "coblenzCanAdvancedType2020"}[]. La portée en est bornée — dix
participants par condition, quatorze analysés, un tutoriel bref, un langage évalué distinct de
celui-ci — mais aucune mesure favorable ne lui fait pendant. Ce document ne peut donc pas invoquer
l'utilisabilité de ses traits comme un acquis : ce qu'il peut invoquer est ce qu'ils _garantissent_,
et la question de leur coût d'apprentissage reste posée.

Une seconde étude, de méthode différente, conclut au même endroit — et c'est cette convergence qui
donne au constat son poids. Elle porte sur les barrières à l'adoption des langages _à vérification
intégrée_, c'est-à-dire la classe où celui-ci se range, et procède en deux temps : modélisation
thématique de discussions de développeurs sur des forums publics, puis enquête déclarative. Les deux
obstacles qu'elle relève ne sont pas théoriques — une courbe d'apprentissage abrupte, et des
problèmes d'utilisabilité — et ses recommandations portent sur l'interface des outils et sur ce qui
accompagne le langage, non sur le langage lui-même {cite "oliveiraWhatChallengesDevelopers2025"}[].
Ce qui freine l'adoption de cette classe n'est donc pas ce qu'elle démontre, mais ce qu'elle coûte à
apprendre et ce que son outillage donne. Ce document consacre sa substance au premier et renvoie le
second au chapitre 6, qui décrit un pipeline sans l'avoir construit ; le déséquilibre est assumé au
chapitre 1 comme une réserve de position, et il est ici mesuré.

Reste à dire ce que la littérature empirique du _nommage_ apporte à ces choix, et la réponse est :
moins qu'on ne l'attendrait, pour une raison d'objet. Une revue systématique de la lisibilité,
cinquante-quatre études primaires dépouillées, recense onze travaux comme la littérature du nommage.
Aucun des onze n'a pour objet les noms de _fonctions_ ou de _méthodes_, neuf portant sur les
identifiants en général et deux nommant explicitement les variables {cite "oliveiraEvaluatingCodeReadability2020"}[].

Or ce que ce chapitre choisit, ce sont des noms de fonctions, en nombre fini et fixés une fois ; ce
que la littérature mesure, ce sont des noms de variables, écrits par l'utilisateur et gouvernés par
convention. Les deux ne relèvent pas du même problème, et aucune mesure faite sur le second ne se
transporte au premier.

La même revue ajoute une raison de prudence sur la qualité de la preuve : l'opinion personnelle sert
de variable de réponse dans trente des cinquante-quatre études et en est la seule dans neuf,
trente-sept pour cent n'exercent qu'une compétence cognitive, et cinq pour cent seulement observent
un signe physique. Un point survit pourtant au tri, et il va contre l'intuition : les identifiants
_courts_ prennent _plus_ de temps à comprendre. La brièveté n'est donc pas un critère de choix, et
ce chapitre ne l'invoque nulle part comme tel.

Une dernière précaution vise les arguments tirés de grands corpus, que ce chapitre s'interdit et
qu'il faut dire pourquoi. Sur quatre millions et demi de projets non forkés de GitHub, plus de
quatre cent vingt-huit millions de fichiers ne comptent que quatre-vingt-cinq millions de fichiers
_uniques_. Sept fichiers sur dix sont donc le clone d'un fichier déjà créé, et le taux varie d'un
ordre de grandeur entre écosystèmes : six pour cent de fichiers distincts en JavaScript, soixante en
Java {cite "lopesDejaVuMapCode2017"}[]. Une comparaison de conventions de nommage _entre langages_
tirée d'un tel corpus compte donc le même fichier un nombre de fois qui dépend du langage, et le
sens du biais est connu : elle surestime l'homogénéité des écosystèmes les plus dupliqués. Aucune
des conventions posées ici ne s'appuie sur un tel comptage.

Une dernière remarque porte sur la méthode plutôt que sur les résultats, et elle explique pourquoi
ces quatre paragraphes existent. Mêler théorie des types et méthode empirique n'est pas une
commodité de présentation mais une discipline, avec ses conditions, et la littérature de la
conception de langage interdisciplinaire les énonce {cite "coblenzInterdisciplinaryProgrammingLanguage2018"}[].
La condition appliquée ici est la plus exigeante : rapporter la mesure _défavorable_ au même titre
que les autres, alors qu'elle porte sur le jeu de traits de ce document et qu'aucune mesure
favorable ne lui fait pendant. Un chapitre qui ne citerait que ce qui l'arrange ne ferait pas de la
conception interdisciplinaire, il en emprunterait le vocabulaire.

Le troisième suit du deuxième. Faire des R- et X-expressions une syntaxe bénie plutôt qu'une
bibliothèque interdit d'en ajouter une troisième _au même niveau_ : le noyau choisit l'homogénéité
de compilation sur l'extensibilité, et n'offre pas de point d'extension. Cela ne ferme pas
l'extension du langage, cela en déplace le lieu — un troisième langage de motifs s'écrit en macros,
dans la bibliothèque, où il est soumis aux mêmes règles que tout le reste.

Deux traditions le portent. Celle d'Iverson soutient qu'une notation bien conçue ne décrit pas la
pensée mais la façonne {cite "iversonNotationToolThought1980a"}[]. Elle justifie le pari le plus
visible du chapitre : les glyphes tacites de la couche 3, hérités à travers APL puis BQN et Uiua, ne
sont pas un raccourci pour experts mais une autre manière d'exprimer une composition, souvent plus
courte à raisonner. Celle de Lisp, où code et donnée partagent une représentation arborescente,
permet de traiter une configuration, une macro et l'AST qu'un outil consulte comme un seul objet. La
syntaxe parenthésée de la couche 2 doit plus précisément aux Lisps applicatifs modernes — TXR Lisp,
Gerbil, LFE — qu'à la tradition générale, eux seuls ayant montré qu'une liste imbriquée reste
praticable pour orchestrer des systèmes réels.

{include 0 Spec.C5.SExpressionsUniverselles}

{include 0 Spec.C5.NotationsSpecialisees}

{include 0 Spec.C5.LeTheoremeDElaboration}

{include 0 Spec.C5.CeQuUneMacroDeclare}

{include 0 Spec.C5.MiseEnPratique}
