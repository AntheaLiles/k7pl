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

#doc (Manual) "A.1. Frontières de couches et discipline de composition" =>
%%%
file := "annexe-frontieres-de-couches-et-discipline-de-composition"
tag := "annexe-frontieres-de-couches-et-discipline-de-composition"
number := false
%%%

::::k7table (label := "tab:err-frontieres") (align := "lZ{1.00}")
:::caption
Codes rejetant une composition qui franchit une frontière de couche
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-TOP-001`
  * Structure de couche 2 `( )` instanciée dans un bloc de couche 3 `[ ]`. Déplacer le calcul dans un `let` de couche 2 en amont.
* * `ERR-TOP-002`
  * Structure de couche 1 `{ }` instanciée dans un bloc de couche 3 `[ ]`. Même correction.
* * `ERR-TOP-003`
  * Un nœud marqué comme bloc de spécification (doctest, assertion `comptime`) est référencé par un chemin de production. Isoler la spécification hors du graphe de dépendance de production.
* * `ERR-TOP-005`
  * Projection tensorielle synchrone (réseau de Leech) demandée en couche 2. La retourner via un `HandlerResult`.
* * `ERR-TOP-011`
  * Aucun composant ne correspond au filtre topologique d'une projection de namespace.
* * `ERR-POL-001`
  * Distribution dynamique ou table virtuelle détectée. Utiliser une résolution `comptime` ou des variantes monomorphes.
* * `ERR-TYP-010`
  * Deux implémentations pour la même paire (type, trait).
:::
::::
