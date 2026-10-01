-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C3.LeSystemeGradue
import Spec.C3.LesContraintesDeValeur
import Spec.C3.StructuresOuvertesEffetsEtMetaTheorie
import Spec.C3.GrammaireDesTypes
import Spec.C3.GrammaireDesTermes
import Spec.C3.ReglesDeTypage

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "THÉORIE DES TYPES" =>
%%%
file := "c3-types"
tag := "c3-types"
%%%

{refsection "c3-types"}

Le chapitre 2 a construit l'appareil catégorique ; celui-ci en tire le système que le développeur
écrit. Il n'y ajoute aucune construction : une seule décision, P2, épuise la question — tout type de
K7PL est le produit d'une modalité d'usage et d'une contrainte de valeur, variant indépendamment
l'une de l'autre. La modalité, trace au niveau des types de la stratification en trois fragments
(§{num "sec:c2-la-comonade-exponentielle-et"}[]), détermine si une ressource se copie librement,
s'abandonne sans y avoir touché, ou doit être consommée exactement une fois. La contrainte de valeur
ne dit rien de l'usage et tout du contenu : taille, intervalle, état, protocole, dimension physique.
Aucune des deux ne conditionne l'autre — sous la seule condition de séparation posée par P2, que le
§{num "sec:c3-les-contraintes-de-valeur"}[] respecte en n'admettant que des indices exclus du suivi
de ressource. De chaque notion, ce chapitre ne retient que ce qu'elle est en tant que type ; la
manière dont elle s'exécute relève du chapitre 4, séparation qui prolonge au niveau du document
l'orthogonalité qu'il construit au niveau des types.

{include 0 Spec.C3.LeSystemeGradue}

{include 0 Spec.C3.LesContraintesDeValeur}

{include 0 Spec.C3.StructuresOuvertesEffetsEtMetaTheorie}

{include 0 Spec.C3.GrammaireDesTypes}

{include 0 Spec.C3.GrammaireDesTermes}

{include 0 Spec.C3.ReglesDeTypage}
