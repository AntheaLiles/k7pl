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

#doc (Manual) "A.7. Contraintes de valeur et preuves résiduelles" =>
%%%
file := "annexe-contraintes-de-valeur-et-preuves-residuelles"
tag := "annexe-contraintes-de-valeur-et-preuves-residuelles"
number := false
%%%

::::k7table (label := "tab:err-contraintes") (align := "lZ{1.00}")
:::caption
Codes émis lorsqu'une contrainte de valeur reste indécidée
:::

:::table +header
* * Code
  * Déclencheur et correction
* * `ERR-SMT-001`
  * Intervalle du témoin contredisant les contraintes inférées.
* * `ERR-SMT-002`
  * `invariant` ou `witness` invalidé par un test de falsification.
* * `ERR-DPL-001`
  * Transformation pure manquante entre l'ancien et le nouveau schéma lors d'un hot-reload.
* * `ERR-PKG-003`
  * Preuve SMT d'un paquet invalidée à la re-vérification locale.
* * `ERR-CMP-002`
  * Incompatibilité de débit producteur/consommateur sans stratégie d'ajustement.
* * `ERR-TYP-005`
  * Singularité non gérée : la division renvoie `Result<Float64, Singularity>`, exigeant un filtrage exhaustif en couche 2.
* * `ERR-SLC-001`
  * Requête de tranche invalide.
* * `ERR-ROW-001`
  * Conflit de rangée.
* * `ERR-FLD-001`
  * Conflit de présence de champ.
:::
::::

{bibliography}
