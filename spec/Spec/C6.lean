-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import Spec.C6.LeProcessusDeCompilation
import Spec.C6.CeQueLeSolveurRetourne
import Spec.C6.StrategiesDeVerificationEtDeTest

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "COMPILATION ET VÉRIFICATION" =>
%%%
file := "c6-compilation"
tag := "c6-compilation"
%%%

{refsection "c6-compilation"}

Un texte conforme à la syntaxe du chapitre 5 doit encore devenir un terme vérifié. Les trois ordres
que le jugement germinal distingue — la propriété des ressources, le grade auquel elles sont
employées, les effets produits — y sont chacun établis et les raffinements déchargés, avant que tout
ce qui les a établis ne s'efface du binaire. C'est l'objet de ce chapitre, et il ne procède pas par
liste : l'ordre dans lequel les composantes se vérifient n'est pas arbitraire, chacune supposant la
précédente acquise.

La méthodologie suivie ne prétend à aucune originalité — grammaire EBNF, sémantique opérationnelle
formalisée dans un cadre comme K Framework, preuves de sûreté et de vivacité vérifiées par un
assistant comme LEAN4. C'est la discipline ordinaire de tout langage qui refuse de laisser sa
sémantique dépendre de son implémentation de référence. Ce que K7PL en tire spécifiquement est un
oracle de _differential testing_, un interpréteur naïf servant de témoin contre lequel chaque
transformation du compilateur optimisant se compare, de sorte qu'aucune phase d'optimisation ne
corrompe silencieusement la sémantique que les vérifications antérieures viennent d'établir.

Cette discipline a un coût, et il est mesuré plutôt qu'estimé : une mécanisation de taille
comparable existe dans l'assistant visé, et elle compte trente-neuf mille lignes non vides et non
commentées, deux cent soixante-sept validations, _zéro_ axiome ni déclaration en suspens, les
preuves de correction en occupant vingt-trois mille — soit près de trois cinquièmes du total {cite "nowackiTrackingBorrowsRegular"}[].
Ce n'est pas seulement un ordre de grandeur : la pièce traite le suivi d'emprunts par des
_expressions régulières_, les dérivées de Brzozowski exprimant les conséquences d'un emprunt sur
l'accessibilité et l'étoile de Kleene résumant les chaînes d'accès — c'est-à-dire l'appareil même du
chapitre 4, employé sur le problème du chapitre 3. La formalisation la plus proche de ce que ce
document devra porter n'est donc pas à construire, elle est à transposer, et le grade y remplacerait
l'emprunt.

Trois pièces couvrent par ailleurs la propriété la plus difficile à mécaniser de ce document. La
non-interférence _insensible à la terminaison_ — la variante qu'un langage total peut viser —
s'établit par relations logiques, et le fonds en porte la version mécanisée {cite "gregersenMechanizedLogicalRelations2021"}[],
ainsi que deux constructions qui la dérivent de la paramétricité plutôt que de la poser {cite "algehedSimpleNoninterferenceParametricity2019,bowmanNoninterferenceFree"}[].
Le motif invoqué par leurs auteurs est celui de ce document : les langages modernes ont des types
riches — ordre supérieur, références, types abstraits — et c'est cette richesse, non la propriété
elle-même, qui rend la preuve à la main impraticable.

Ce dispositif a une forme plus forte, nommée ici plutôt que laissée au lecteur. Un oracle de test
est supposé correct sans qu'aucune preuve ne le relie à la sémantique catégorique des chapitres 1 et
2 ; le témoin n'est donc pas neutre. La forme plus forte consiste à assigner _deux_ sémantiques au
même langage — l'une impérative, propre à engendrer du code efficace, l'autre purement
fonctionnelle, commode au raisonnement équationnel — et à les relier par un théorème de raffinement
qui permet au compilateur de _produire une preuve_ plutôt qu'un rapport de test. Elle est déployée
sur des composants de système d'exploitation, et elle vient avec un second acquis qui vaut pour ce
document. La discipline d'unicité ne s'ajoute pas au coût de vérification, elle en retire une part,
en éliminant le support d'exécution de confiance {cite "oconnorCogentUniquenessTypes2021"}[]. Ce
document retient l'oracle par économie de moyens, et il tient l'écart pour une dette et non pour un
choix.

Une précision de méthode s'y ajoute, qui porte sur la valeur de ce que le test rend. Lorsqu'un test
vise un comportement de modèle mémoire, les observations qui comptent sont extrêmement rares et de
nature probabiliste, de sorte qu'une campagne non réglée donne une confiance _illusoire_ plutôt que
faible : sans protocole, l'absence d'observation ne distingue pas l'impossible de l'improbable. Une
méta-étude des travaux antérieurs y relève des résultats de faible reproductibilité et un emploi
inefficace du temps de test {cite "kirkhamFoundationsEmpiricalMemory2020"}[]. Ce que le point de
contrôle doit donc porter n'est pas le principe du test différentiel — qui ne se discute pas — mais
le _protocole de réglage_ des routines de sollicitation, sans lequel un rapport vert ne veut rien
dire.

{include 0 Spec.C6.LeProcessusDeCompilation}

{include 0 Spec.C6.CeQueLeSolveurRetourne}

{include 0 Spec.C6.StrategiesDeVerificationEtDeTest}
