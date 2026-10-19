-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C7.EtudeDeCasIArchitectureReactiveNative
import Spec.C7.EtudeDeCasIIDeveloppementInteractifEt
import Spec.C7.EtudeDeCasIIIMoteurDeductifSurArenes

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "INTÉGRATION PRATIQUE ET CAS D'USAGE" =>
%%%
file := "c7-integration"
tag := "c7-integration"
%%%

{refsection "c7-integration"}

Ce chapitre présente trois études de cas qui composent plusieurs mécanismes de K7PL : une architecture réactive, un environnement de développement interactif et un moteur déductif sur arènes. Elles illustrent des scénarios d'intégration ; elles ne constituent pas, à elles seules, une preuve générale de correction ni une validation empirique des performances.

{include 0 Spec.C7.EtudeDeCasIArchitectureReactiveNative}

{include 0 Spec.C7.EtudeDeCasIIDeveloppementInteractifEt}

{include 0 Spec.C7.EtudeDeCasIIIMoteurDeductifSurArenes}
