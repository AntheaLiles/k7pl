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

Chaque pièce de K7PL est fondée et s'articule avec ses voisines. Reste une question plus exigeante :
l'ensemble tient-il lorsqu'un programme réel sollicite plusieurs mécanismes à la fois, sous une
contrainte que la théorie prise pièce par pièce ne rencontre jamais — un budget de temps par image,
une bibliothèque utilisable sans connaître ses usages futurs ? Deux études de cas y répondent,
sollicitant la pile entière depuis deux angles.

{include 0 Spec.C7.EtudeDeCasIArchitectureReactiveNative}

{include 0 Spec.C7.EtudeDeCasIIDeveloppementInteractifEt}

{include 0 Spec.C7.EtudeDeCasIIIMoteurDeductifSurArenes}
