-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

#doc (Manual) "Traces tactiques extraites" =>
%%%
file := "proof-visualizations"
tag := "proof-visualizations"
%%%

# Visualisations de preuves Lean

Les vues ci-dessous sont des observations documentaires dérivées des états de buts
et des hypothèses rapportés par l'extracteur Paperproof. Elles complètent les sources
Lean sans s'y substituer. Elles ne constituent ni une preuve indépendante, ni une
validation de correspondance entre une déclaration Lean et un énoncé normatif.

La compilation K7PL principale et le workspace d'extraction sont tous deux
épinglés sur Lean 4.34.0. La CI a confirmé l'extraction des trois premières cibles
sélectionnées sous cette version. Les deux exemples supplémentaires ci-dessous
élargissent le corpus ; leur statut d'extraction doit être établi par la CI de ce
commit. Cela ne constitue pas une garantie de prise en charge universelle des
constructions Lean.

## Conservation sémantique de double

::::proofviz (slug := "eval-double")
::::

## Composition de la mise à l'échelle d'usage

::::proofviz (slug := "scale-usage-comp")
::::

## Projection du contexte d'usage et mise à l'échelle

::::proofviz (slug := "project-usage-context-scale")
::::

## Compatibilité de la multiplication finie avec la consommation de budget

::::proofviz (slug := "grade-budget-finite-multiplicity")
::::

## Préservation de l’unicité après allocation d’une capacité

::::proofviz (slug := "memory-capability-allocate-unique")
::::
