-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.AnnexeE.GrammaireDesTypes
import Spec.AnnexeE.GrammaireDesTermes
import Spec.AnnexeE.ReglesDeTypage
import Spec.AnnexeE.SemantiqueOperationnelle
import Spec.AnnexeE.LeSystemeDeSortesDuMetalangage
import Spec.AnnexeE.CeQueChaquePreuveOuverteYPuise
import Spec.AnnexeE.TableDesGlyphes

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "E. PRESENTATION FORMELLE" =>
%%%
file := "annexe-semantique"
tag := "annexe-semantique"
number := false
%%%

{refsection "k7-semantique"}

{label "sec:annexe-presentation-formelle" (display := "E")}

:::comment
```
Annexe de présentation formelle. Ce fichier est une SOURCE : il porte les citations sous leur clé symbolique et se destine à être assemblé dans la spécification par le #+INCLUDE: qui s'y trouve. Il ne s'exporte pas seul.
```
:::

:::comment
```
Cette annexe n'est pas exportée. Elle porte du matériau de chantier — protocole de travail, structure des axes, travaux empiriques — qui n'a pas sa place dans un document publié. Les sections G.1 à G.4, en revanche, sont de la spécification : elles migreront vers une annexe exportée dès que le jeu de règles sera écrit, c'est-à-dire dès que G.3 cessera d'être un inventaire. Jusque-là, les publier reviendrait à publier une grammaire sans ses règles.
```
:::

Cette annexe porte ce que le corps du document décrit sans le poser : la grammaire des types et des
termes, le jeu des règles de typage, et la sémantique opérationnelle sur laquelle les énoncés des
chapitres 2 à 4 se raisonnent. Sa nécessité n'est pas de commodité. Cinq travaux ouverts — la
préservation du typage par la traduction, la non-interférence graduée, la divulgation délimitée, les
règles de la loi distributive, celles de la gradation indexée — sont des inductions ou des relations
logiques, et l'un comme l'autre se définissent _par récurrence sur une grammaire ou sur un jeu de
règles_. Tant que ces objets ne sont pas écrits, ces preuves n'ont pas de support, et ce document
préfère le dire que de produire des raisonnements qui en auraient l'apparence.

L'état de cette annexe doit être annoncé sans détour. Les deux grammaires y sont écrites, la somme
et la conjonction additive sous leur forme indexée. Le jeu de règles est complet pour les
constructeurs du noyau, à une exception déclarée — l'arène, dont l'élimination relève du modèle
mémoire et non du système de types. La relation de réduction est donnée schéma par schéma, une
réduction par forme d'élimination, et non plus par représentants. La préservation et le progrès sont
démontrés, le second sous deux hypothèses nommées. Le lemme de substitution l'est également.

Ce qui reste ouvert est donc d'une autre nature que ce que cette annexe annonçait il y a peu. Ce ne
sont plus des objets manquants mais des propriétés à établir sur des objets écrits : la préservation
du typage par la traduction, la non-interférence graduée, la divulgation délimitée, les règles de la
loi distributive et celles de la gradation indexée. Chacune est une induction ou une relation
logique, et chacune a désormais le support dont elle a besoin.

{include 0 Spec.AnnexeE.GrammaireDesTypes}

{include 0 Spec.AnnexeE.GrammaireDesTermes}

{include 0 Spec.AnnexeE.ReglesDeTypage}

{include 0 Spec.AnnexeE.SemantiqueOperationnelle}

{include 0 Spec.AnnexeE.LeSystemeDeSortesDuMetalangage}

{include 0 Spec.AnnexeE.CeQueChaquePreuveOuverteYPuise}

{include 0 Spec.AnnexeE.TableDesGlyphes}
