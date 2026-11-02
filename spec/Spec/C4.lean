-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C4.Introduction
import Spec.C4.LocalScale
import Spec.C4.ActorScale
import Spec.C4.MemoryModels
import Spec.C4.SystemScale
import Spec.C4.UnderlyingProcessCalculus
import Spec.C4.OperationalSemantics
import Spec.C4.MetalanguageSortSystem
import Spec.C4.WhatEachOpenProofDrawsOn

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

{include 0 Spec.C4.LocalScale}

{include 0 Spec.C4.ActorScale}

{include 0 Spec.C4.MemoryModels}

{include 0 Spec.C4.SystemScale}

{include 0 Spec.C4.UnderlyingProcessCalculus}

{include 0 Spec.C4.OperationalSemantics}

{include 0 Spec.C4.MetalanguageSortSystem}

{include 0 Spec.C4.WhatEachOpenProofDrawsOn}
