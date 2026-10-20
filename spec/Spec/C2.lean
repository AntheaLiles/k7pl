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

{include 0 Spec.C2.CategorieAmbiante}

{include 0 Spec.C2.ComonadeExponentielleEtFragments}

{include 0 Spec.C2.AlgebresCoalgebresEtPointsFixes}

{include 0 Spec.C2.AdjonctionsEtEnrichissement}

{include 0 Spec.C2.SystemeDeRaffinement}

{include 0 Spec.C2.SixSchemasDeMetatheorie}
