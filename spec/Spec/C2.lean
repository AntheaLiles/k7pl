-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C2.CategorieAmbiante
import Spec.C2.ComonadeExponentielleEtFragments
import Spec.C2.AlgebresCoalgebresEtPointsFixes
import Spec.C2.AdjonctionsEtEnrichissement
import Spec.C2.SystemeDeRaffinement
import Spec.C2.SixSchemasDeMetatheorie

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "FONDEMENTS CATÉGORIQUES" =>
%%%
file := "c2-fondements"
tag := "c2-fondements"
%%%

{refsection "c2-fondements"}

Ce chapitre répond à la question fondatrice du langage : quelle structure algébrique unique peut porter à la fois la graduation des usages et la sédimentation en trois fragments ? Il présuppose les postulats et les conventions du chapitre 1, ainsi que les rudiments de la théorie des catégories. Il établit la catégorie ambiante, la comonade exponentielle et la sédimentation en fragments qu'elle induit, la dualité des algèbres et des coalgèbres avec leurs points fixes, les adjonctions et l'enrichissement qui relient valeurs et calculs, le système de raffinement et son foncteur d'effacement, et il dégage six schémas de métathéorie réutilisés dans tout l'ouvrage. Les énoncés de ce chapitre sont établis par des démonstrations rédigées et des esquisses de preuve consignées dans le texte ; aucun module Lean de la spécification ne les formalise à ce stade, et leur statut suit en chaque lieu le vocabulaire du guide de lecture.

{include 0 Spec.C2.CategorieAmbiante}

{include 0 Spec.C2.ComonadeExponentielleEtFragments}

{include 0 Spec.C2.AlgebresCoalgebresEtPointsFixes}

{include 0 Spec.C2.AdjonctionsEtEnrichissement}

{include 0 Spec.C2.SystemeDeRaffinement}

{include 0 Spec.C2.SixSchemasDeMetatheorie}
