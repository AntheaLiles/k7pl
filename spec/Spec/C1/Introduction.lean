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

#doc (Manual) "Introduction" =>
%%%
file := "c1-introduction"
tag := "c1-introduction"
%%%

Un système logiciel contemporain est sommé de tenir trois promesses à la fois : s'exécuter au plus
près du matériel, ne corrompre ni sa propre mémoire ni celle d'un pair concurrent, et se laisser
vérifier avant d'être mis en production. Aucune n'est neuve ; leur conjonction l'est.

Elle résiste parce qu'on la pense comme un arbitrage : on choisit un point sur un triangle de
compromis et l'on hérite des faiblesses de ce point. K7PL part d'une autre hypothèse — si les trois
exigences s'expriment comme instances d'une même structure algébrique, il ne s'agit plus de choisir
mais de _graduer_, dans un seul langage et sans changer de paradigme, le niveau de rigueur payé
localement. Chaque notion propre au langage est définie ici avant d'être employée ; seuls les
rudiments de la théorie des catégories sont supposés connus.

Trois maturités se distinguent dans ce qui suit. {rmq}[Le lecteur est en droit de savoir laquelle il
lit. Les termes employés ici sont tous définis en leur lieu.]

_Arrêté_ — ne changera plus sans révision de l'axiomatique. Le jugement à trois composantes et sa
strate d'obligations. La sédimentation en trois fragments et son origine dans le semi-anneau. Le
système de raffinement et son foncteur d'effacement. Les correspondances de disposition et leur
domaine exact. Le modèle mémoire acquisition-libération et sa portée d'une machine. Les trois
critères de terminaison. L'encodage des protocoles dans l'implication linéaire.

_Construit, non éprouvé_ — la construction est faite, l'épreuve ne l'est pas. L'extension déductive
et son opérateur de point fixe ; les modalités temporelles et le débit qu'elles expriment ; l'axe de
confidentialité et sa modalité graduée ; la déclassification par échappatoires nommées ; le
métalangage et la traduction vers lui.

_Nommé, non posé_ — le document sait qu'il en a besoin et ne l'a pas donné. La loi distributive
graduée entre les deux côtés de l'adjonction ; la gradation indexée qu'exigent les effets dépendant
de valeurs ; le jeu de règles de typage lui-même, dont l'absence est ce qui suspend les quatre
preuves ouvertes.

Cette troisième catégorie n'est pas une liste de manques : c'est l'état d'un chantier dont les
objets sont identifiés et les dépendances connues. Un programme de recherche se distingue d'une
dette en ce qu'il sait ce qu'il cherche.

Une exigence tient d'un bout à l'autre, et le lecteur est fondé à l'opposer au texte. Aucune
affirmation ne figure sans qu'un postulat, un théorème ou une construction établie la porte, et ce
qui n'est pas porté est nommé comme tel.
