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

#doc (Manual) "Stratégies de vérification et de test" =>
%%%
file := "c6-strategies-de-verification-et"
tag := "c6-strategies-de-verification-et"
%%%

{label "sec:c6-strategies-de-verification-et"}

Cet ordre est présenté comme nécessaire, et il ne l'est pas également partout. Que la modalité
précède l'inférence des types concrets tient à un argument précis (chapitre 3,
§{num "sec:c3-le-systeme-gradue"}[]) qui ne vaut que pour une unification à la Damas-Milner,
d'autres architectures s'en dispensant. Que la vérification de pureté précède la preuve de
terminaison l'est moins : un argument structurel de décroissance sur une algèbre initiale ne dépend
pas, en rigueur, de l'absence d'effets. L'ordre retenu simplifie l'implémentation et regroupe les
vérifications par nature ; à cet endroit précis, c'est un choix d'ingénierie présenté comme une
contrainte logique.

La vérification décrite au §{num "sec:c6-le-processus-de-compilation"}[] a pour conséquence de vider
de leur sens la plupart des catégories usuelles de test, en les faisant coïncider avec des
mécanismes déjà établis plutôt qu'avec des pratiques séparées. Un test unitaire, dans cette lecture,
est _couvert pour partie_ par un type de raffinement vérifié par le solveur SMT de la Phase 5. Un
test d'intégration l'est par la vérification du DAG topologique du chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]). Un test de résilience l'est par l'arbre de supervision
lui-même, dont la politique de redémarrage (chapitre 4, §{num "sec:c4-echelle-du-systeme"}[])
encaisse la panne plutôt que de la simuler. Une part de ce que le développeur écrirait ailleurs
comme suite de tests est donc vérifiée une fois pour toutes à la compilation. Le mot _couvre_ est
ici plus juste que le mot _est_, et la nuance n'est pas de prudence. Un test d'intégration éprouve
des propriétés que la structure statique n'exprime pas ; un arbre de supervision est une structure
de contrôle et non la propriété de résilience elle-même. Le test de propriétés reste donc nécessaire
là où l'obligation n'a pas de forme statique, et l'oracle de référence demeure une hypothèse de
confiance. Écrire l'équivalence plutôt que le recouvrement ferait passer pour démontré ce qui n'est
qu'espéré.

Les doctests occupent, dans ce paysage, une position particulière : le compilateur les exécute comme
des tests unitaires ordinaires pendant la Phase 1, avant toute génération de code, ce qui en fait la
seule forme de test dont l'échec bloque la compilation elle-même plutôt qu'une exécution ultérieure.
En mode `+strict-tdd`, un symbole public sans doctest associé est lui-même rejeté — la documentation
devient une obligation de preuve comme une autre, vérifiée avec le même sérieux que le jugement
lui-même.

Un résidu dynamique subsiste néanmoins, et ce chapitre ne prétend pas l'éliminer : la falsification
des indices SMT par test de propriétés (§{num "sec:c6-le-processus-de-compilation"}[], Phase 5),
activée en mode `+verify`, reste un test au sens classique du terme — une exécution qui pourrait
échouer, plutôt qu'une preuve qui ne le peut pas. Le chemin nominal de K7PL est statique de bout en
bout ; ce résidu en est la seule exception assumée, et il ne porte que sur les indices qu'un
développeur a lui-même fournis, jamais sur le cœur du système de types.

Une seconde exception, d'un autre ordre, tient à l'oracle lui-même : l'interpréteur de référence est
supposé sémantiquement correct par construction, sans qu'aucune preuve ne relie son comportement à
la sémantique catégorique des chapitres 1 et 2. C'est une hypothèse de confiance, non un théorème.

Elle n'est pas hors d'atteinte pour autant. Trois techniques attestées s'y appliquent. Les prédicats
logiques pour la logique linéaire intuitionniste, par lesquels s'établit la complétude pleine de la
traduction de Girard {cite "hasegawaGirardTranslationLogical2000"}[]. La bisimilarité applicative,
définie coinductivement pour les λ-calculs à état et adaptée à un interpréteur qui en manipule {cite "RITTER-PITTS"}[].
Et la traduction vers un métalangage en π-calcul, interprété une fois pour toutes, où correction et
adéquation se raisonnent au niveau du métalangage {cite "CASTELLAN-PI"}[].

Une quatrième voie se signale pour ce qu'elle prouve de faisabilité plutôt que pour être suivie : le
même objet — un interpréteur de référence servant d'oracle à un testeur — a été construit et
_entièrement vérifié_ ailleurs, pour exactement cet usage {cite "wattWasmRefisabelleVerifiedMonadic2023"}[].
L'hypothèse de confiance énoncée ci-dessus n'est donc pas une limite de principe : elle a un prix,
et ce prix a été payé au moins une fois.

C'est la troisième voie que ce document retient, et le chapitre 4
(§{num "sec:c4-le-calcul-de-processus"}[]) la construit : le métalangage y est défini, la traduction
donnée, et sa préservation du typage énoncée en théorème. La dette change alors de nature. Il ne
s'agit plus de prouver l'interpréteur correct construction par construction, mais d'établir que la
traduction préserve le typage — le métalangage étant interprété une fois pour toutes, correction et
adéquation s'y raisonnent {cite "cairesLinearSessionAbstract2026"}[]. Cette dette-là reste ouverte,
et elle est plus étroite : le théorème {num "thm:traduction_metalangage"}[] l'énonce et n'en donne
qu'une esquisse, et la fidélité elle-même demande en outre la simulation du théorème {num "thm:simulation"}[], qui l'accompagne.

Sa portée, en revanche, ne l'est plus. Le §{num "sec:c4-le-calcul-de-processus"}[] étend le
métalangage pour que les effets y aient une image, sous la forme de communications sur des canaux
distingués. Un interpréteur prouvé fidèle l'est donc à la structure de communication, au contrôle
_et_ aux effets, dont le temps. Ce que ce choix déplace n'est pas la difficulté mais son lieu : la
discipline qui garantit qu'aucun programme traduit n'accède aux canaux distingués reste à écrire, et
elle conditionne la valeur de l'énoncé.

Reste le protocole du test différentiel, que ce chapitre invoque sans l'avoir écrit. Il compare, sur
un même programme, l'exécution du binaire optimisé et celle de l'interpréteur de référence. Le
corpus est composé de trois sources — les doctests, les cas d'étude du chapitre 7, et des
programmes engendrés par propriété à graine fixée et consignée —, et chaque cas porte son profil
de représentation $`\Pi`. La comparaison se fait sur l'observation et la trace d'effets modulo la
congruence du métalangage : aucune tolérance sur le rejeu logique ; sur la représentation, l'égalité
bit à bit n'est exigée que sous le profil déclaré. Un écart est classé — erreur du compilateur,
erreur de l'oracle, ou ambiguïté de la spécification — et bissecté phase par phase du pipeline,
puis réduit au plus petit programme qui le reproduit, lequel rejoint le corpus de non-régression.
Le test est reproductible si chaque passe appliquée est déterministe et que la trace est respectée
au niveau du binaire testé : c'est le critère opérationnel de la compilation reproductible.
Tant que la fidélité de l'oracle n'est pas démontrée, un écart n'est pas une preuve contre le
compilateur, et son absence n'en est pas une pour lui.

{bibliography}
