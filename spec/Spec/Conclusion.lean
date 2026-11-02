-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "APOGOMÈNES" =>
%%%
file := "apogomene"
tag := "apogomene"
%%%

{refsection "apogomene"}

{label "sec:apogomene"}

Cette partie conclut la spécification. Elle établit le bilan de ce que les chapitres précédents ont arrêté, construit ou
nommé, exigence par exigence et maturité par maturité. Elle fixe également ce que le document n'établit pas et le
programme que dessinent les objets restés nommés. Elle n'introduit aucun énoncé nouveau et ne relève d'aucun outillage
propre : elle relit, avec leurs statuts, des constructions outillées dans leurs chapitres.

L'ouvrage partait d'une hypothèse : la performance du bas niveau, la sûreté de la mémoire sans ramasse-miettes ni
comptage de références et la résilience ne forment pas un triangle de compromis, parce que les trois exigences
s'expriment comme instances d'une même structure algébrique et se graduent dans un seul langage. À l'issue du parcours,
l'hypothèse a changé de statut sans changer de contenu. La structure est posée : un jugement unique, gradué par un
semi-anneau d'usage enrichi d'une coordonnée monotone, d'un niveau de confidentialité et d'un budget, et trois fragments
d'un même système, cartésien pur et terminant, affine à effets algébriques, linéaire strict, qui sont des domaines de
cette gradation et non trois langages juxtaposés. Chaque exigence y a reçu une expression : la performance, par la
couche linéaire et ses arènes ; la sûreté, par la discipline d'usage qui fait de la validité mémoire une propriété du
typage ; la résilience, par les effets algébriques de la couche affine et l'isolation entre composants. Ce qui suit dit,
dans les termes mêmes du chapitre 1, ce qui de cette construction est arrêté, ce qui est construit sans être éprouvé, et
ce qui reste nommé sans être posé.

Sont arrêtés, au sens du chapitre 1 (ils ne changeront plus sans révision de l'axiomatique), les objets que
l'introduction annonçait sous ce statut, et le parcours n'en a déplacé aucun : le jugement à trois composantes et sa
strate d'obligations ; la sédimentation en trois fragments et son origine dans le semi-anneau ; le système de
raffinement et son foncteur d'effacement ; les correspondances de disposition et leur domaine exact ; le modèle mémoire
acquisition-libération et sa portée d'une machine ; les trois critères de terminaison ; l'encodage des protocoles dans
l'implication linéaire. C'est sur eux que portent les définitions normatives des chapitres, et c'est à eux que les
objets construits ensuite se raccordent.

Sont construits, sans être éprouvés, l'extension déductive et son opérateur de point fixe, les modalités temporelles et
le débit qu'elles expriment, l'axe de confidentialité et sa modalité graduée, la déclassification par échappatoires
nommées, le métalangage et la traduction vers lui. Le jeu de règles de typage est complet pour les constructeurs du
noyau (§{num "sec:g-regles"}[]) : ce qui reste à établir n'en est plus l'existence mais les propriétés (la préservation,
la cohérence de la subsomption, la complétude des refus), énoncées avec leurs obligations aux lieux où elles sont
posées. La traduction vers le métalangage appelle une réserve propre : correcte pour les termes, elle ne reflète pas la
discipline d'ordre des zones (§{num "sec:c3-le-systeme-gradue"}[]), et toute propriété de la source dérivée d'elle
demande à être revérifiée.

Restent nommés, sans être posés, les deux objets que l'introduction désignait : la loi distributive graduée entre les
deux côtés de l'adjonction (§{num "sec:c1-de-la-loi-distributive"}[]) et la gradation indexée par les valeurs. Leur
absence n'est pas diffuse : elle suspend des énoncés identifiés. Sans la loi distributive, la composition des contextes
gradués repose sur des cas démontrés séparément, non sur une loi générale ; sans la gradation indexée, le branchement
retient le joint des grades de ses branches (§{num "sec:c3-le-systeme-gradue"}[]), approximation délibérée qui refuse
des programmes corrects. Les dépendances sont connues dans les deux cas, et c'est ce qui distingue ce programme d'une
dette : le document sait ce qu'il cherche, et chaque preuve ouverte nomme l'objet dont elle attend la construction.

Ce que le document n'établit pas se dit avec la même netteté. Il ne comporte aucune mesure : ses garanties de
performance sont des conséquences des propriétés du système de types, et les études de cas portent elles-mêmes la
réserve qui vaut pour l'ouvrage entier, trois combinaisons de mécanismes ne prouvant pas qu'une combinatoire tienne
partout (§{num "sec:c7-etude-de-cas-iii"}[]). Il ne décrit pas davantage une implémentation complète : le noyau effectif
du chapitre 3, les définitions K du chapitre 5 et les modèles TLA+ du chapitre 4 sont des fragments outillés, tenus par
le continuum de vérification du chapitre 6, non une chaîne menant d'un texte source à un programme exécuté.

L'exigence de rédaction posée au chapitre 1 vaut pour cette conclusion comme pour le reste : aucun statut n'y est
annoncé au delà de l'état des définitions et des preuves. Le bilan tient alors en trois phrases. La performance et la
sûreté ont reçu, dans la gradation, une expression commune dont les fondements sont arrêtés et le système de types
construit. La résilience est construite dans ses mécanismes et reste la moins éprouvée des trois exigences. Et le
programme qui demeure est nommé : deux objets, dont la construction fermerait les preuves que ce document laisse
ouvertes en les nommant.
