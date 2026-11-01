-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C1
import Spec.C2
import Spec.C3
import Spec.C4
import Spec.C5
import Spec.C6
import Spec.C7
import Spec.Refs
import Spec.AnnexeA
import Spec.ProofVisualizations
import Spec.CodeArtifacts

open Verso.Genre Manual
open SpecExt

#doc (Manual) "K7PL : KonSept Programming Language" =>
%%%
authors := ["Cyprien PIERRE"]
shortTitle := "K7PL"
%%%

{texsetup}

*A functional layered programming language*

*Cyprien PIERRE* — [ORCID 0009-0009-9040-6795](https://orcid.org/0009-0009-9040-6795)

DOI : [10.5281/zenodo.23040451](https://doi.org/10.5281/zenodo.23040451) · Source : [github.com/AntheaLiles/k7pl](https://github.com/AntheaLiles/k7pl)

{ccby}[] © Cyprien PIERRE 2026. Cette spécification est publiée sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

*Résumé*

Cette spécification définit K7PL, un langage de programmation fonctionnel en couches, et l'état exact de ce qui y est établi.

Le point de départ est une conjonction de trois exigences. Premièrement, la performance bas niveau : exécution native et parallélisme comme régimes ordinaires. Deuxièmement, la sûreté de la mémoire, obtenue sans ramasse-miettes ni comptage de références : un programme doit pouvoir s'exécuter près du matériel sans que son exécution, ou celle d'un pair, corrompe la mémoire. Troisièmement, la résilience : exécution durable et isolation entre composants. Là où la conception de langages traite ordinairement cette conjonction comme un arbitrage entre compromis, K7PL la traite comme un problème de graduation : les trois exigences s'y expriment comme instances d'une même structure algébrique, et un unique jugement de typage, gradué par un semi-anneau d'usage enrichi (coordonnée monotone, niveau de confidentialité, budget), règle localement le niveau de rigueur de chaque fragment. Le langage se sédimente en trois couches qui sont des fragments d'un même système : cartésienne pure et terminante, affine à effets algébriques, linéaire stricte.

C'est de ces trois exigences que découlent les recherches qui fondent le langage : théorie des catégories, théorie des types et théorie des automates, exposées aux chapitres 2, 3 et 4. L'ouvrage procède des prolégomènes et postulats (chapitre 1) vers la pratique : syntaxe et mise en pratique (chapitre 5), compilation et vérification (chapitre 6), intégration et études de cas (chapitre 7). Il suppose connus les rudiments de la théorie des catégories ; chaque notion propre au langage y est définie avant d'être employée.

Le statut de chaque affirmation est une donnée du texte, non une impression de lecture : les énoncés sont qualifiés par un vocabulaire d'états et d'évidences fixé au chapitre 1, et l'ouvrage distingue en permanence ce qui est arrêté, ce qui est construit sans être encore éprouvé, et ce qui est nommé sans être encore posé. Au premier rang des objets nommés figurent la loi distributive graduée entre les deux côtés de l'adjonction et la gradation indexée par les valeurs, dont dépend la clôture des preuves ouvertes. Le lecteur pressé peut s'en tenir au présent résumé, à l'introduction et aux tables de maturité ; le lecteur qui implémente trouvera le normatif dans les définitions, les règles, les tables et les codes d'erreur (annexe {num "sec:annexe-a-codes"}[]), tenus distincts des justifications qui les accompagnent.

{include 0 Spec.C1}

{include 0 Spec.C2}

{include 0 Spec.C3}

{include 0 Spec.C4}

{include 0 Spec.C5}

{include 0 Spec.C6}

{include 0 Spec.C7}

{include 0 Spec.Refs}

{include 0 Spec.AnnexeA}

{include 0 Spec.ProofVisualizations}

{include 0 Spec.CodeArtifacts}

