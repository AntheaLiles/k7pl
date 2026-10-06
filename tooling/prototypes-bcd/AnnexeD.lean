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

#doc (Manual) "D. SUGOI" =>
%%%
file := "annexe-sugoi"
tag := "annexe-sugoi"
number := false
%%%

{refsection "k7-sugoi"}

{label "sec:annexe-sugoi" (display := "D")}

`sugoi` suit la même syntaxe d'appel universelle que `sushi` (annexe {num "sec:annexe-sushi"}[]), appliquée cette fois à la
gestion de paquets plutôt qu'à l'administration système. Ses indicateurs — `+i~/~+install`,
`+r~/~+remove`, `+u~/~+upgrade`, `+s~/~+search`, `+v~/~+verify`, entre autres — n'introduisent
aucune convention nouvelle, seulement des grades booléens désucrés comme n'importe quel autre
indicateur du chapitre 5 (§{num "sec:c5-s-expressions-universelles"}[]).

Ce que `sugoi` distribue n'est jamais du texte source mais du code porteur de preuve. Chaque paquet
embarque l'AST normalisé, ses descripteurs topologiques et ses théorèmes SMT résiduels, accompagnés de leurs certificats, que le
compilateur local vérifie intégralement avant toute installation : relancer le solveur serait une répétition, non une vérification, un solveur local de version, d'options ou de graine différentes pouvant répondre autrement. C'est la Phase 5 que le
chapitre 6 (§{num "sec:c6-le-processus-de-compilation"}[]) décrit pour un programme ordinaire,
appliquée à une dépendance externe plutôt qu'au texte que le développeur écrit lui-même.
L'identification d'un paquet par le hachage BLAKE3 de son AST normalisé, et non par un numéro de
version, est l'adressage par contenu que le chapitre 6
(§{num "sec:c6-le-processus-de-compilation"}[]) établit pour tout module K7PL. Deux paquets dont
l'écriture diffère mais dont les arbres normalisés coïncident partagent un seul condensat : la
confusion de version est éliminée structurellement plutôt que disciplinée par convention. La mise à
jour transactionnelle d'un paquet en production emprunte, enfin, exactement le mécanisme de
redémarrage à chaud des acteurs virtuels (chapitre 4, §{num "sec:c4-echelle-du-systeme"}[]) : image
compilée substituée par échange de pointeur, ancien acteur drainé, journal rejoué.

Cette vérification ne porte pas que sur la preuve : `sugoi +deploy` soumet également le paquet au
contrat de capacités matérielles du nœud cible (chapitre 4, §{num "sec:c4-echelle-du-systeme"}[])
avant toute installation. Si l'abaissement MLIR du paquet exige une extension absente — un jeu
d'instructions vectorielles, un accélérateur déclaré par `:gpu-offload` —, le déploiement est rejeté
avant même d'être tenté, plutôt que de produire un binaire qui échouerait à l'exécution sur le
matériel visé.
