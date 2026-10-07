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

#doc (Manual) "A.6. Distinction de phase et métaprogrammation" =>
%%%
file := "annexe-distinction-de-phase-et-metaprogrammation"
tag := "annexe-distinction-de-phase-et-metaprogrammation"
number := false
%%%

Ces quatre codes protègent l'invariant énoncé au chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) : le comportement observable d'un programme ne dépend
jamais de ce qui appartient à la phase de compilation. C'est cet invariant qui autorise la Phase 10 à
purger les blocs de spécification sans changer le programme ; le violer rendrait l'effacement
incorrect, et non pas seulement imprudent.

::::k7table (label := "tab:err-phase") (align := "lZ{1.00}")
:::caption
Codes protégeant la distinction de phase et l'hygiène des macros
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-TYP-011`
  * Projection implicite `e.τ` sur un paquet existentiel dont le témoin porte un grade effaçable (chapitre 3, §{num "sec:c3-structures-ouvertes-effets-et"}[]). C'est un filtrage sur donnée effacée, qui ferait perdre la canonicité. Exiger un `unpack` explicite, ou rendre le témoin non effaçable.
* * `ERR-TYP-012`
  * Éliminateur discriminant à l'exécution sur un argument de la phase de compilation — `match` sur un paramètre de typestate, `cond` sur un paramètre fantôme, filtrage sur une dimension physique (chapitre 3, §{num "sec:c3-les-contraintes-de-valeur"}[]). Porter un tag explicite, qui appartient alors à la phase d'exécution et cesse d'être gratuit.
* * `ERR-MAC-001`
  * Macro dont l'expansion introduit une liaison capturable par le site d'appel sans l'avoir déclarée. L'anaphore n'est pas interdite, elle doit être visible : annoter la macro de `binds` pour étendre explicitement son index de portée (chapitre 5, §{num "sec:c5-mise-en-pratique"}[]).
* * `ERR-MAC-002`
  * Macro annotée `binds` dont l'expansion n'introduit aucune liaison. Retirer l'annotation, qui alourdit la signature sans contrepartie.
:::
::::
