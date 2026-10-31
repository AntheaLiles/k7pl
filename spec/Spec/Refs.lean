-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.Refs.FigureList
import Spec.Refs.TableList
import Spec.Refs.FormulaList
import Spec.Refs.SourceCodeList
import Spec.Refs.GlossList
import Spec.Refs.AcronymList
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

{include 0 Spec.Refs.FigureList}

{include 0 Spec.Refs.TableList}

{include 0 Spec.Refs.FormulaList}

{include 0 Spec.Refs.SourceCodeList}

{include 0 Spec.Refs.GlossList}

{include 0 Spec.Refs.AcronymList}

{include 0 Spec.Refs.Index}
