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

#doc (Manual) "Étude de cas III : moteur déductif sur arènes colonnaires" =>
%%%
file := "c7-etude-de-cas-iii"
tag := "c7-etude-de-cas-iii"
%%%

{label "sec:c7-etude-de-cas-iii"}

Les deux études précédentes éprouvent le langage sur des contraintes de latence et d'explication.
Une troisième sollicite autre chose, et c'est la seule des trois dont le chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]) ait annoncé la possibilité sans la montrer. Un calcul dont le
coût ne se mesure pas par message mais par _convergence_, sur un volume de données qui ne tient pas
dans un cache.

Le cas retenu est une analyse statique de programme — l'accessibilité dans un graphe d'appels, dont
on veut la clôture transitive sous des règles de propagation. Les faits initiaux sont un ensemble
d'arêtes ; les règles en dérivent de nouvelles jusqu'à saturation. C'est le cas d'emploi canonique
d'un moteur déductif, et il a le mérite d'être auto-applicable : le compilateur de K7PL construit
lui-même un graphe de dépendances en Phase 2, et rien n'interdirait qu'il l'interroge de cette
façon.

La composition est celle que le chapitre 4 décrit, et aucune pièce n'y est nouvelle. Les arêtes
connues occupent une arène de couche 1, deux colonnes de sommets dans la disposition du théorème {num "thm:isomorphisme_memoire"}[].
L'analyse est un acteur de couche 2, qui reçoit les faits, calcule et répond aux requêtes. Le calcul
lui-même est un $`\mathbf{fix}` de couche 3 sur le type des relations, dont la hauteur finie tient
au nombre fini de sommets. Le théorème {num "thm:terminaison_lfp"}[] en donne la terminaison sans
qu'aucune annotation soit écrite, la fonction de dérivation étant monotone par construction.

Cette étude met en tension deux exigences que les deux premières n'opposaient pas. La couche 1 pose
l'allocation en $`O(1)` comme norme ; or une itération à point fixe fait croître ses relations à
chaque tour, et la taille finale n'est pas connue à l'entrée. La réponse n'est pas de renoncer à la
norme mais de voir où elle s'applique : l'arène est dimensionnée une fois pour le pire cas — le
carré du nombre de sommets, borné puisque celui-ci l'est —, et chaque tour n'y écrit qu'en append,
en $`O(1)` par fait dérivé. Le mot _amorti_ serait ici impropre et vaut d'être écarté :
l'amortissement suppose une réallocation dont le coût se répartit, or il n'y en a aucune. L'arène
est allouée une fois, et ce qui croît est son taux de remplissage et non sa taille. Ce n'est pas
l'allocation qui croît, c'est le taux de remplissage. La borne d'espace est donc statique et le
budget de temps se lit en nombre de tours, que la hauteur majore.

Une seconde tension, moins soluble, se rapporte au chapitre 3. L'évaluation semi-naïve exige de
distinguer à chaque tour les faits nouveaux des anciens, ce qui suppose de conserver deux versions
de la même relation. Sous une discipline linéaire stricte, cette conservation serait une duplication
interdite ; c'est la lecture graduée qui la permet, la relation de travail portant un grade non
contraint tant qu'elle demeure interne au point fixe, et redevenant linéaire à la sortie. Le passage
de l'un à l'autre est une coercion et non une exception, mais il se signale : c'est le point de
cette étude où le système gradué fait un travail qu'un système linéaire strict ne ferait pas.

Ce que cette étude n'établit pas doit être dit aussi. Elle ne comporte aucune mesure — le nombre de
tours effectif sur un graphe réel, la localité des accès en régime semi-naïf, le coût de la coercion
— et ces trois grandeurs décideront de la praticabilité. La négation stratifiée, absente ici,
changerait le tableau : une règle qui conclut de l'_absence_ d'un fait n'est pas monotone, et le
point fixe qui la contiendrait ne relèverait plus du théorème {num "thm:terminaison_lfp"}[]. La
stratification est le remède connu ; ce document ne la traite pas.

Aucun mécanisme nouveau n'a dû être introduit dans ces études : elles n'ont fait que composer ce qui
existait, ce qui est la preuve la plus convaincante que ce document puisse offrir que la
sédimentation annoncée au chapitre 1 n'était pas qu'une image. Deux réserves l'accompagnent. Trois
combinaisons ne prouvent pas qu'une combinatoire tienne partout — d'autres, non examinées,
pourraient révéler des frictions qu'aucun chapitre n'a anticipées. Et les garanties de performance
avancées ci-dessus sont des conséquences de propriétés déjà prouvées — arènes en $`O(1)`, _diffing_
borné —, non des mesures : ce document raisonne sur ce que le système de types garantit, il n'a
chronométré aucun rendu.

La distance est ainsi parcourue entre quatre postulats et un programme qui s'exécute : d'un jugement
unique à la catégorie qui l'interprète, au système de types qui en tire ses conséquences, aux
automates qui l'exécutent, à la syntaxe qui le rend écrivible, au pipeline qui le vérifie, aux cas
d'usage qui l'éprouvent. Les annexes n'ajoutent aucune construction : elles ne sont que les
références de détail convoquées sans être développées au fil du texte.
