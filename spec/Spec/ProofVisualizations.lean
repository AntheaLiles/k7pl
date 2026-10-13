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

La compilation K7PL principale reste exécutée sous Lean 4.34.0. Le workspace
d'extraction de cette première tranche utilise Paperproof et Lean 4.29.0-rc8 ;
la provenance de chaque vue expose cette différence. La compatibilité de cet
extracteur ancien ne doit pas être généralisée aux constructions qui n'ont pas été
testées sur des sources réelles.

## Conservation sémantique de double

::::proofviz (slug := "eval-double")
::::

## Composition de la mise à l'échelle d'usage

::::proofviz (slug := "scale-usage-comp")
::::

## Projection du contexte d'usage et mise à l'échelle

::::proofviz (slug := "project-usage-context-scale")
::::
