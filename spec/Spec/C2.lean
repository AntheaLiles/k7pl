-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C2.CategorieAmbiante
import Spec.C2.ComonadeExponentielleEtFragments
import Spec.C2.AlgebresCoalgebresEtPointsFixes
import Spec.C2.AdjonctionsEtEnrichissement
import Spec.C2.SystemeDeRaffinement
import Spec.C2.SixSchemasDeMetatheorie

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "FONDEMENTS CATÉGORIQUES" =>
%%%
file := "c2-fondements"
tag := "c2-fondements"
%%%

{refsection "c2-fondements"}

Le chapitre précédent a posé sans les construire les objets sur lesquels reposent les quatre
postulats. Rien de ce qui suit n'est propre à K7PL : chaque construction appartient au corpus
stabilisé de la sémantique catégorique de la logique linéaire, et l'apport de ce chapitre est d'y
identifier exactement les briques dont les postulats ont besoin — ni plus, ni moins — puis de les
assembler dans l'ordre où elles s'appellent. Ce parti de conservation se paie en asymétries de
preuve, signalées au fil du texte.

Une remarque d'orientation, qui commande la lecture du chapitre entier. On y construit un système de
types de la manière intrinsèque — les types sont des objets de _C_, les termes des morphismes —
alors que l'architecture du langage est extrinsèque de bout en bout. Un jugement à trois composantes
porté au-dessus d'un terme, dont la Phase 10 retire tout ce qui appartient à la compilation. Cet
écart n'est pas une gêne à surmonter, c'est la définition même d'un _système de raffinement de
types_ — un foncteur de la catégorie des dérivations vers celle des termes sous-jacents {cite "melliesFunctorsAreType2015"}[]
— et ce chapitre construit le domaine de ce foncteur.

Chacune des quatre sections qui suivent y contribue par une pièce, et la cinquième les rassemble. La
catégorie ambiante donne les objets et les flèches au-dessus desquels les dérivations se portent. La
comonade exponentielle et ses fragments donnent les morphismes verticaux, ceux qui ne changent rien
au terme sous-jacent et tout à ce qu'il exige. Les algèbres et coalgèbres donnent les schémas de
définition que ce foncteur devra préserver. L'enrichissement donne l'ordre dans lequel deux
dérivations de même image se comparent. Le §{num "sec:c2-le-systeme-de-raffinement"}[] montre alors
que ces quatre pièces sont celles d'un système de raffinement, et ce que cette lecture dispense de
poser séparément.

{include 0 Spec.C2.CategorieAmbiante}

{include 0 Spec.C2.ComonadeExponentielleEtFragments}

{include 0 Spec.C2.AlgebresCoalgebresEtPointsFixes}

{include 0 Spec.C2.AdjonctionsEtEnrichissement}

{include 0 Spec.C2.SystemeDeRaffinement}

{include 0 Spec.C2.SixSchemasDeMetatheorie}
