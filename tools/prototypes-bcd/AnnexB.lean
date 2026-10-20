-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the former normative annex. Preserved as tooling material;
-- it is not part of the normative specification.

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "B. SPECIFICATION LSP {amp}[] REPL" =>
%%%
file := "annexe-lsp-repl"
tag := "annexe-lsp-repl"
number := false
%%%

{refsection "k7-lsp-repl"}

{label "sec:annexe-lsp-repl" (display := "B")}

Le protocole LSP et le REPL sont ici conservés comme prototypes d'outillage. Leur comportement est décrit à partir de mécanismes établis dans la spécification, sans que l'existence de ces outils constitue une propriété normative de K7PL.

Le serveur LSP expose quatre services : complétion par narrowing, diagnostic fondé sur une tranche minimale de dérivation, visualisation d'une machine à états et refactoring soumis à la relation de substituabilité généralisée.

Le REPL est un prototype d'évaluation interactive s'appuyant sur le mode JIT. Le Replay Debugger charge le journal d'un acteur et rejoue sa séquence de messages à travers ses gestionnaires purs. La pureté et le déterminisme sémantique ne suffisent toutefois pas à garantir une identité bit-à-bit générale : toute revendication de reproductibilité doit être formulée relativement à un profil d'exécution Π conformément au traitement d'ARB-PR-04. Une identité binaire éventuelle est donc une propriété expérimentale d'un pipeline concret, et non une propriété générale du langage.
