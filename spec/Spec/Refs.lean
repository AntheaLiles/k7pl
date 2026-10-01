-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.Refs.ListeDesFigures
import Spec.Refs.ListeDesTableaux
import Spec.Refs.ListeDesFormules
import Spec.Refs.ListeDesCodesSources
import Spec.Refs.ListeDesGlosses
import Spec.Refs.ListeDesAcronymes
import Spec.Refs.Index

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "REFERENCES DU DOCUMENT" =>
%%%
file := "refs"
tag := "refs"
%%%

{refsection "refs"}

{label "sec:references-du-document"}

{include 0 Spec.Refs.ListeDesFigures}

{include 0 Spec.Refs.ListeDesTableaux}

{include 0 Spec.Refs.ListeDesFormules}

{include 0 Spec.Refs.ListeDesCodesSources}

{include 0 Spec.Refs.ListeDesGlosses}

{include 0 Spec.Refs.ListeDesAcronymes}

{include 0 Spec.Refs.Index}
