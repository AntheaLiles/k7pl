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

#doc (Manual) "A.3. Terminaison et productivité" =>
%%%
file := "annexe-terminaison-et-productivite"
tag := "annexe-terminaison-et-productivite"
number := false
%%%

::::k7table (label := "tab:err-terminaison") (align := "lZ{1.00}")
:::caption
Codes émis lorsqu'un critère de terminaison ou de productivité n'est pas établi
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-TER-001`
  * Récursion générale détectée en couche 3. Utiliser un pli ou le mot-clé `terminates`.
* * `ERR-IND-001`
  * Chemin d'exécution d'un flux `@:stream` bouclant indéfiniment sans émettre.
* * `ERR-IND-003`
  * Prédicat tacite d'un `stream-subscribe` risquant de rejeter indéfiniment tous les éléments.
* * `ERR-CMP-001`
  * Constructeur non linéaire dans un contexte annoté `@linear`.
* * `ERR-CMP-004`
  * Dépassement du budget temporel alloué à l'évaluation `comptime`.
* * `ERR-STK-001`
  * Un train tacite consomme plus d'arguments que disponible, ou en laisse orphelins.
* * `ERR-STK-003`
  * Une semicoroutine dépasse la taille de pile préallouée.
* * `ERR-MEM-009`
  * Un consommateur abandonne un `StreamContext` avant épuisement.
:::
::::
