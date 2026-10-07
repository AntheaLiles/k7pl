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

#doc (Manual) "Index" =>
%%%
file := "refs-index"
tag := "refs-index"
%%%

L'index recense ce dont le document _traite_ en plusieurs endroits distincts, non ce qu'il mentionne :
un concept traité une seule fois se trouve par la table des matières, et un mot présent partout ne se
cherche pas. Chaque terme est suivi des pages du PDF où il apparaît et, dans la version HTML, des
sections correspondantes. Les occurrences sont reconnues dans le texte à la génération, sans balisage
à la main (pluriel et casse indifférents).

{printindex}
