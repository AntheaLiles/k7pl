-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C4.Introduction
import Spec.C4.EchelleLocale
import Spec.C4.EchelleDeLActeur
import Spec.C4.ModelesDeMemoire
import Spec.C4.EchelleDuSysteme
import Spec.C4.CalculDeProcessusSousJacent
import Spec.C4.SemantiqueOperationnelle
import Spec.C4.LeSystemeDeSortesDuMetalangage
import Spec.C4.CeQueChaquePreuveOuverteYPuise

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "THÉORIE DES AUTOMATES" =>
%%%
file := "c4-automates"
tag := "c4-automates"
%%%

{refsection "c4-automates"}

{include 0 Spec.C4.Introduction}

{include 0 Spec.C4.EchelleLocale}

{include 0 Spec.C4.EchelleDeLActeur}

{include 0 Spec.C4.ModelesDeMemoire}

{include 0 Spec.C4.EchelleDuSysteme}

{include 0 Spec.C4.CalculDeProcessusSousJacent}

{include 0 Spec.C4.SemantiqueOperationnelle}

{include 0 Spec.C4.LeSystemeDeSortesDuMetalangage}

{include 0 Spec.C4.CeQueChaquePreuveOuverteYPuise}
