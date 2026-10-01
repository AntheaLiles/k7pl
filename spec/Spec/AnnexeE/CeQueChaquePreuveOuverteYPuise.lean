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

#doc (Manual) "E.6. Ce que chaque preuve ouverte y puise" =>
%%%
file := "g-tracabilite"
tag := "g-tracabilite"
number := false
%%%

{label "sec:g-tracabilite" (display := "E.6")}

Cette annexe n'a pas de valeur propre ; elle en a par ce qu'elle rend possible, et la traçabilité
doit être explicite pour que son achèvement soit mesurable.

Cette section a été écrite quand les trois preuves attendaient ; elle dit maintenant ce qu'elles ont
pris. La _préservation du typage par la traduction_ (chapitre 4, théorème {num "thm:traduction_metalangage"}[])
est *démontrée* (§{num "sec:g-traduction"}[]). Ses trois premiers groupes par le lemme de
commutation, et ses quatre cas résistants par le foncteur d'effacement, le système de sortes, et
l'appareil de ré-invocation bornée que les deux derniers partagent. La _non-interférence graduée_
(théorème {num "thm:non_interference"}[]) est démontrée sur le fragment sans communication, temps
compris (§{num "sec:g-relation-logique"}[]) ; son extension attend le même système de sortes. La
_divulgation délimitée_ (théorème {num "thm:divulgation_delimitee"}[]) est démontrée sous la même
réserve, la relation étant celle-là même requantifiée. _Cette réserve est levée depuis le
§{num "sec:g-sortes"}[]_ : le système de sortes rend la clause de session définissable, et les trois
preuves s'étendent à la strate qu'elles laissaient. Les trois reposent sur le lemme de substitution
et sur la loi de cohérence qu'il a réclamée. Les _règles de la loi distributive graduée_ et celles
de la _gradation indexée_ sont des règles, et appartiennent à G.3 dès qu'elles seront écrites.

Un dernier point inverse l'ordre apparent des priorités. Le métalangage du chapitre 4, qui est la
_cible_ de la traduction, est formellement présenté — grammaire, motifs, coupure — quand K7PL, qui
en est la _source_, ne l'est pas. Cette asymétrie est le vrai retard de ce document, et cette annexe
est ce qui la comble.
