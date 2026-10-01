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

#doc (Manual) "Étude de cas II : développement interactif et bibliothèque" =>
%%%
file := "c7-etude-de-cas-ii"
tag := "c7-etude-de-cas-ii"
%%%

{label "sec:c7-etude-de-cas-ii"}

Cette seconde étude s'inscrit dans une tradition plus ancienne, celle des environnements qui
répondent au programme incomplet plutôt que de se taire jusqu'à ce qu'il soit fini : les trous typés
d'un assistant de preuve, le rejeu déterministe d'un débogueur temporel. K7PL n'y invente rien ; il
montre que ces pratiques, d'ordinaire portées par des outils séparés du langage, se déduisent du
système de types et de la journalisation déjà construits.

Un système de vérification n'est utile au développement quotidien que s'il explique ses refus autant
qu'il les prononce. Cette seconde étude de cas montre que K7PL n'a besoin d'aucun outil
supplémentaire pour cela : l'explication est déjà contenue dans les mécanismes des chapitres 3 et 4,
il ne restait qu'à les mettre à la disposition du développeur au moment où il en a besoin.

Un trou, écrit `_`, est le point le moins précis du treillis de précision pour le type attendu
(chapitre 3, §{num "sec:c3-structures-ouvertes-effets-et"}[]). Lorsqu'un développeur en laisse un
dans son code, le compilateur ne se contente pas de le signaler, il propose, par narrowing, les
termes qui le raffinent jusqu'à devenir acceptables — la même tranche minimale de dérivation qui
explique un message d'erreur explique tout aussi bien une suggestion de complétion, puisque l'une et
l'autre s'obtiennent par la même extraction de sous-dérivation. Lorsqu'un comportement inattendu
survient à l'exécution, le Replay Debugger n'a besoin d'aucune instrumentation ajoutée après coup.
Le journal Cap'n Proto que le chapitre 4 (§{num "sec:c4-echelle-du-systeme"}[]) a construit pour la
reprise après panne est ce dont un débogueur temporel a besoin pour rejouer, mettre en pause et
faire défiler l'exécution. La pureté des gestionnaires (chapitre 3,
§{num "sec:c3-purete-des-gestionnaires"}[]) garantit que ce rejeu reproduit fidèlement l'original,
sans divergence entre les deux exécutions.

La bibliothèque standard, enfin, ne propose aucune vérité qui échapperait au chapitre 3.
`Decimal128` est un type de raffinement garantissant l'absence d'erreur de représentation décimale
pour les calculs financiers. `Timestamp`, `Duration` et `TimeWindow(T, n, unit)` sont des types
dépendants pragmatiques paramétrés par une unité, au même titre que les dimensions physiques du
chapitre 3 (§{num "sec:c3-les-contraintes-de-valeur"}[]). Le module `stdunit` instancie ce même
mécanisme de contrainte de valeur pour les unités du système international, érigé en bibliothèque
plutôt qu'écrit à la main à chaque usage. Une bibliothèque, dans K7PL, n'est jamais qu'une
collection de contraintes déjà nommées.
