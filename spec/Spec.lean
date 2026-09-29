-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import Spec.Introduction
import Spec.Expressions

open Verso.Genre Manual

#doc (Manual) "K7PL : KonSept Programming Language" =>
%%%
authors := ["Cyprien PIERRE"]
shortTitle := "K7PL"
%%%

_A three-layered functional programming language._

Ce document décrit le langage k7pl.
Il est écrit en Verso : chaque chapitre est un module Lean,
et les exemples de code sont vérifiés à la compilation.

{include 1 Spec.Introduction}

{include 1 Spec.Expressions}
