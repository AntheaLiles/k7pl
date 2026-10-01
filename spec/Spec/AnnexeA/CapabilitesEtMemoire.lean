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

#doc (Manual) "A.4. Capabilités et mémoire" =>
%%%
file := "annexe-capabilites-et-memoire"
tag := "annexe-capabilites-et-memoire"
number := false
%%%

::::k7table (label := "tab:err-capabilites") (align := "Z{0.35}Z{1.65}")
:::caption
Codes protégeant la discipline de capabilité et la sûreté mémoire
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-MEM-004`
  * Emprunt mutable d'un état canonique. Cloner ou utiliser la copie-sur-écriture de couche 3.
* * `ERR-MEM-006`
  * Pointeur absolu dans une arène de couche 1. Utiliser un offset relatif.
* * `ERR-TYP-006`
  * Point de session ou ressource `Lin T` abandonnée avant `end`.
* * `ERR-CMP-003`
  * Abandon implicite en couche 2 d'une structure à destructeur non constant. Exiger une libération explicite par lot.
* * `ERR-TOP-006`
  * Barrière mémoire manquante sur une écriture de canal inter-cœurs.
* * `ERR-TOP-007`
  * Réallocation structurelle d'une arène pendant qu'une vue de couche 2 l'emprunte.
* * `ERR-TOP-008`
  * Une vue `tref` s'échappe de son cadre local. Matérialiser par `vec`.
* * `ERR-FFI-001` / `ERR-TYP-008`
  * Fuite d'un descripteur ou d'un `ForeignHandle` via la passerelle FFI.
:::
::::
