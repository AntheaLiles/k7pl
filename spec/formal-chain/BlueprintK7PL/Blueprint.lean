-- SPDX-FileCopyrightText: 2026 K7PL contributors
-- SPDX-License-Identifier: CECILL-2.1
import Verso
import VersoManual
import VersoBlueprint
import VersoBlueprint.Commands.Graph
import VersoBlueprint.Commands.Summary
import BlueprintK7PL.Chapters.Semantics

open Verso.Genre
open Verso.Genre.Manual
open Informal

#doc (Manual) "K7PL — Sémantique et preuves du sous-langage" =>

Ce Blueprint documente une première chaîne expérimentale autour d’un sous-ensemble
de K7PL. La sémantique opérationnelle est compilée par K Framework, le KORE généré
est exporté par `klean`, puis Lean vérifie les preuves du sous-langage et un témoin
de transition KLean concret.

{include 0 BlueprintK7PL.Chapters.Semantics}

{blueprint_graph}
{blueprint_summary}
