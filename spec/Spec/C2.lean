-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C2.AmbientCategory
import Spec.C2.ExponentialComonadAndFragments
import Spec.C2.AlgebrasCoalgebrasAndFixedPoints
import Spec.C2.AdjunctionsAndEnrichment
import Spec.C2.RefinementSystem
import Spec.C2.SixMetatheorySchemas

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "FONDEMENTS CATÉGORIQUES" =>
%%%
file := "c2-fondements"
tag := "c2-fondements"
%%%

{refsection "c2-fondements"}

Ce chapitre pose les fondements catégoriques du langage. Il établit la catégorie ambiante, la comonade exponentielle et
la sédimentation en fragments qu'elle induit. Il décrit également la dualité des algèbres et des coalgèbres, les
adjonctions et l'enrichissement, le système de raffinement et son foncteur d'effacement, et dégage six schémas de
métathéorie réutilisés dans tout l'ouvrage. Ses énoncés sont établis par des démonstrations rédigées et des esquisses de
preuve ; aucun module Lean ne les formalise à ce stade.

{include 0 Spec.C2.AmbientCategory}

{include 0 Spec.C2.ExponentialComonadAndFragments}

{include 0 Spec.C2.AlgebrasCoalgebrasAndFixedPoints}

{include 0 Spec.C2.AdjunctionsAndEnrichment}

{include 0 Spec.C2.RefinementSystem}

{include 0 Spec.C2.SixMetatheorySchemas}
