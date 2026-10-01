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

#doc (Manual) "A.5. Protocoles, sessions et topologie distribuée" =>
%%%
file := "annexe-protocoles-sessions-et-topologie-distribuee"
tag := "annexe-protocoles-sessions-et-topologie-distribuee"
number := false
%%%

::::k7table (label := "tab:err-protocoles") (align := "lZ{1.00}")
:::caption
Codes rejetant une violation de protocole ou de topologie distribuée
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-TYP-007`
  * Transition de typestate invalide.
* * `ERR-TOP-009`
  * Branche `offer` non gérée dans l'implémentation d'un protocole.
* * `ERR-ACT-002`
  * Combinaison de messages non couverte par un motif de jonction.
* * `ERR-ACT-003`
  * Souscription circulaire à un flux avec politique `:block`.
* * `ERR-ARC-001`
  * Cycle dans le graphe de dépendances entre acteurs et canaux.
* * `ERR-ARC-002`
  * Seuil de centralité dépassé (God Object).
:::
::::
