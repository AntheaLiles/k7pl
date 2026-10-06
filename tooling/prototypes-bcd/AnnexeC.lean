-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the former normative annex. Preserved as tooling material;
-- it is not part of the normative specification.

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "C. SUSHI - The K7PL's (fake)Shell" =>
%%%
file := "annexe-sushi"
tag := "annexe-sushi"
number := false
%%%

{refsection "k7-sushi"}

{label "sec:annexe-sushi" (display := "C")}

sushi est conservé comme prototype d'outillage. Il réutilise la syntaxe d'appel universelle et le REPL ; cette interprétation administrative n'est pas une propriété normative du langage.

Les combinateurs de flux mentionnés ici restent des propositions d'outillage. Ils ne constituent ni des primitives ni des composants implicites de la bibliothèque standard.
