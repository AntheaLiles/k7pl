-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C1.Introduction
import Spec.C1.GuideDeLecture
import Spec.C1.Postulats
import Spec.C1.AxiomatiqueGerminale
import Spec.C1.TableNormativeDesSymboles
import Spec.C1.TableDesGlyphes

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "PROLÉGOMÈNE" =>
%%%
file := "c1-prolegomenes"
tag := "c1-prolegomenes"
%%%

{refsection "c1-prolegomenes"}

Ce chapitre répond à une question préalable : à quelles conditions ce qui suit peut-il être lu, cru et opposé au texte lui-même ? Il ne présuppose aucun autre chapitre. Il établit les quatre postulats du langage et leur expression conjointe dans un jugement de typage unique (axiomatique germinale), fixe le vocabulaire des énoncés et des évidences auquel tout l'ouvrage se tient (guide de lecture), et donne les tables normatives des symboles et des glyphes. Aucun énoncé de ce chapitre n'est modélisé ni vérifié par un outil : le chapitre pose les objets et les conventions que les chapitres suivants modélisent, chacun indiquant son outillage à son propre seuil.

{include 0 Spec.C1.Introduction}

{include 0 Spec.C1.GuideDeLecture}

{include 0 Spec.C1.Postulats}

{include 0 Spec.C1.AxiomatiqueGerminale}

{include 0 Spec.C1.TableNormativeDesSymboles}

{include 0 Spec.C1.TableDesGlyphes}
