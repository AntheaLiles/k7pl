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
file := "c4-introduction"
tag := "c4-introduction"
%%%

Le chapitre 3 a dit ce qu'est un type ; celui-ci dit comment un programme s'exécute. Un type de
session, un typestate, une capabilité restent ce que le chapitre 3 en a dit ; ce chapitre en donne
le modèle d'exécution. La dichotomie qu'Ousterhout établit entre langages système et langages de
liaison éclaire le rôle qu'y tient la couche 2 : elle n'est ni l'un ni l'autre isolément. Mais le
langage de liaison qui connecte les primitives des couches 1 et 3 sans jamais en exécuter les
effets.

Une unité se signale avant même de descendre aux échelles, et ce chapitre gagnerait à la revendiquer
plutôt qu'à la laisser paraître fortuite. Trois traits que ce document traite en trois endroits
distincts — le système de _sortes_ du métalangage, l'_hygiène_ et son $`\alpha`-équivalence, et le
_budget_ porté par le grade — sont trois instances d'un même paramètre. Un cadre d'apprentissage
d'automates paramétré en une monade a pour instances les langages sortés, les langages nominaux avec
liaison, et les fonctions de coût {cite "urbatAutomataLearningAlgebraic2020,heerdtCategoricalFrameworkLearning2022"}[].
Ce sont les trois. L'argument d'unité est donc disponible, et il n'est pas décoratif : trois traits
qui partagent un paramètre partagent aussi ce qu'on peut démontrer d'eux.

Une précision sur ce que « la même forme à trois échelles » veut dire au juste, car la formule est
vraie dans un sens et fausse dans un autre. Un automate se lit comme un _foncteur_ d'une catégorie
d'entrée — qui spécifie le type des langages et des machines — vers une catégorie de sortie, qui
spécifie le type des valeurs produites {cite "colcombetAutomataMinimizationFunctorial2020"}[]. Les
trois échelles ci-après ne sont pas trois instances d'un même foncteur obtenues en changeant la
seule sortie. Elles diffèrent par les deux, l'échelle locale produisant une valeur, celle de
l'acteur une observation et un état suivant, celle du système une transition de processus.

Ce qui les unit est plus fort qu'une identité de foncteur, et c'est un théorème plutôt qu'une
construction. La même source établit comment _relever_ une adjonction entre catégories de valeurs de
sortie en une adjonction entre catégories d'automates. Les trois couches étant reliées par les
shifts adjoints du chapitre 1, leurs catégories de sortie le sont aussi, et le relèvement fournit
les adjonctions entre les trois échelles sans qu'on ait à les construire. La sédimentation reçoit
ainsi, du côté des automates, la structure qu'elle a déjà du côté des modes — et ce qui se démontre
à une échelle se transporte aux autres le long de ces adjonctions, ce qui est ce que la formule
voulait dire.

Ce modèle d'exécution se retrouve à trois échelles, et la précision qui précède dit dans quel sens
il s'y répète. Le chapitre 2 a construit la coalgèbre terminale $`\nu F` comme le point fixe portant
la productivité : un état, une observation qu'il produit, un état suivant qu'il détermine. C'est ce
schéma que ce chapitre retrouve, à trois reprises. D'abord dans le plus petit automate qui reconnaît
un motif ou exécute un pli (§{num "sec:c4-echelle-locale"}[], échelle locale). Puis dans l'acteur,
dont l'espace d'état tout entier est une instance de cette même coalgèbre
(§{num "sec:c4-echelle-de-l-acteur"}[], échelle de l'acteur). Enfin dans l'orchestrateur, qui
supervise une constellation d'acteurs comme une coalgèbre dont l'état est composé d'états d'acteurs
(§{num "sec:c4-echelle-du-systeme"}[], échelle du système). Ce que les trois partagent est donc le
_schéma_ de la coalgèbre, et ce qui les relie sont les adjonctions relevées — non une identité de
foncteur, que le paragraphe précédent écarte.

Ce motif porte d'ailleurs un nom que ce document n'emploie pas et qui lui vaudrait sa métathéorie :
un acteur est une définition par _copatrons_. Sa conjonction additive $`\Pi_{i \in I}`, introduite
par $`\langle c_i \rangle` et éliminée par $`c.i`, est la forme d'un objet défini non par ce qu'il
contient mais par la famille de ses _observations_. C'est ce qu'un acteur est : un état auquel on ne
pose que des questions. La métathéorie de cette forme est faite, dans le même cadre à tailles que le
chapitre 2 emploie pour sa terminaison {cite "abelWellfoundedRecursionCopatterns2016"}[] : ce
document n'a donc pas à la construire, seulement à reconnaître qu'il s'en sert.
