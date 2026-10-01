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

#doc (Manual) "C. SUSHI - The K7PL's (fake)Shell" =>
%%%
file := "annexe-sushi"
tag := "annexe-sushi"
number := false
%%%

{refsection "k7-sushi"}

{label "sec:annexe-sushi" (display := "C")}

`sushi` ne définit aucune grammaire qui lui soit propre : c'est la syntaxe d'appel universelle du
chapitre 5 (§{num "sec:c5-s-expressions-universelles"}[]) —
`(fonction arg₁ arg₂ +flag -flag :clé valeur)` — appliquée à l'administration système plutôt qu'au
calcul applicatif, et le REPL de l'annexe {num "sec:annexe-lsp-repl"}[] comme surface d'interaction. La commande
`(list :type-fichier mp3)` n'est, en ce sens, ni plus ni moins qu'un appel de fonction ordinaire
dont le résultat s'affiche tabulairement. Qu'elle coïncide, par ailleurs, avec une commande shell
POSIX et une requête relationnelle n'est pas une coïncidence heureuse mais la conséquence directe du
principe d'homoiconicité (P1) : une seule syntaxe, trois lectures.

Les utilitaires POSIX usuels — `sed`, `awk`, `xargs` — y sont remplacés par des combinateurs de flux
(`stream-sed`, `stream-awk`, `spawn-fibrilles`) opérant directement sur les R-expressions du
chapitre 4 (§{num "sec:c4-echelle-locale"}[]). Un filtre shell n'est ainsi qu'un motif compilé en
automate, avec les mêmes garanties de terminaison et de complexité que n'importe quel usage de
`match` en couche 3.
