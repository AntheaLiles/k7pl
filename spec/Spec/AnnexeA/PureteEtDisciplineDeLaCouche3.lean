-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "A.2. Pureté et discipline de la couche 3" =>
%%%
file := "annexe-purete-et-discipline-de-la-couche-3"
tag := "annexe-purete-et-discipline-de-la-couche-3"
number := false
%%%

::::k7table (label := "tab:err-purete") (align := "lZ{1.00}")
:::caption
Codes protégeant la pureté et la totalité de la couche 3
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-PUR-001`
  * Opération à effet à l'intérieur d'un bloc `pure` ou d'un bloc `[ ]` de couche 3.
* * `ERR-EFF-001`
  * Effet algébrique sans gestionnaire associé. Définir un gestionnaire ou retirer le `perform`.
* * `ERR-LOG-001`
  * Conditionnelle impérative détectée. Utiliser `match`, `cond` ou `select`.
* * `ERR-TOP-010`
  * Fonction impure, suffixée `!`, appelée à l'intérieur d'un bloc pur de couche 3.
* * `ERR-TYP-009`
  * Fonction suffixée `?` contenant un effet algébrique non géré.
:::
::::
