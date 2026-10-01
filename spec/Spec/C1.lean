-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C1.Introduction
import Spec.C1.GuideDeLecture
import Spec.C1.Postulats
import Spec.C1.AxiomatiqueGerminale
import Spec.C1.TableNormativeDesSymboles

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "PROLÉGOMÈNE" =>
%%%
file := "c1-prolegomenes"
tag := "c1-prolegomenes"
%%%

{refsection "c1-prolegomenes"}

{include 0 Spec.C1.Introduction}

{include 0 Spec.C1.GuideDeLecture}

{include 0 Spec.C1.Postulats}

{include 0 Spec.C1.AxiomatiqueGerminale}

{include 0 Spec.C1.TableNormativeDesSymboles}
