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

#doc (Manual) "Étude de cas I : architecture réactive native" =>
%%%
file := "c7-etude-de-cas-i"
tag := "c7-etude-de-cas-i"
%%%

{label "sec:c7-etude-de-cas-i"}

Cette étude s'inscrit dans la lignée de la programmation réactive fonctionnelle et des architectures
à flux unidirectionnel — la famille dont Elm et React ont fait une pratique courante —, où l'état
d'une interface se déduit d'un flux d'événements plutôt que de se muter directement. K7PL en reprend
le principe sans en emprunter l'implémentation : le _diffing_ y devient un catamorphisme, et la
mutation du DOM une capabilité exclusive plutôt qu'une convention de cadriciel.

Une interface utilisateur est un cas de charge particulièrement sévère pour K7PL : elle doit
redessiner son état à un rythme fixe, sans qu'une pause de ramasse-miettes ne vienne jamais rompre
ce rythme, tout en laissant le développeur raisonner sur son état comme sur une simple valeur plutôt
que sur une séquence de mutations. K7PL n'y répond par aucun cadriciel séparé du langage : le cycle
réactif traverse les trois couches à chaque image, et chaque étape de ce cycle n'est qu'une instance
d'un mécanisme déjà construit.

::::figure (label := "fig:cycle-reactif") (src := "unidirectionnal-reactive-cycle") (alt := "Cycle ferme a six etapes traversant les trois couches — evenement en couche 1, flux FRP en couche 2, nouvel etat en couche 2, X-expression en couche 2, diffing en couche 3, liste de patches en couche 1, qui referme le cycle sur l'evenement.") (width := "90")
:::caption
Le cycle réactif unidirectionnel à travers les trois couches
:::

:::desc
Le trajet d'un événement à travers les trois couches, et le point où il referme le cycle sur
lui-même.
:::
::::

Un événement, capturé en couche 1, alimente un flux réactif de couche 2 — la même semicoroutine
asymétrique que le chapitre 4 (§{num "sec:c4-echelle-locale"}[]) a construite pour tout flux infini,
ici spécialisée aux événements d'interface. Ce flux produit un nouvel état, purement représenté
comme une X-expression (chapitre 5, §{num "sec:c5-notations-specialisees"}[]) plutôt que comme une
structure mutable : la couche 2 ne manipule jamais le DOM directement, elle ne fait que décrire
l'arbre qu'il devrait devenir. La réconciliation de cet arbre avec le précédent est un catamorphisme
de couche 3 (chapitre 2, §{num "sec:c2-algebres-coalgebres-et-points"}[]). Un pli dont la mesure —
la profondeur de l'arbre — décroît strictement à chaque étape, produisant un vecteur de correctifs
sur une arène linéaire plutôt qu'une nouvelle structure entière. Lorsque deux branches de l'arbre
partagent le même hachage BLAKE3 — la même déduplication canonique que le chapitre 4
(§{num "sec:c4-echelle-de-l-acteur"}[]) a établie pour l'état des acteurs —, le diffing s'arrête sur
cette branche en $`O(1)` sans la comparer nœud par nœud. Le vecteur de correctifs qui en résulte
redescend enfin en couche 1, où il est appliqué au DOM réel.

Cette dernière étape révèle que l'isolation entre couches n'est pas qu'une discipline de style. La
couche 1 détient seule la `WriteCap(DOM)`, capabilité graduée au sens du chapitre 3
(§{num "sec:c3-le-systeme-gradue"}[]), et aucune expression de couche 2 ne peut y prétendre. La
couche 2 ne contient jamais que des X-expressions, des données pures, jamais un pointeur vers le
DOM. Une fuite de pointeur DOM vers la couche 2 est ainsi rendue non typable, pas seulement
déconseillée. Les animations prolongent ce même cycle sans y ajouter de mécanisme : ce sont des
transformations pures de couche 3, pilotées par un flux temporel coinductif de couche 2 dont la
productivité (chapitre 2, §{num "sec:c2-algebres-coalgebres-et-points"}[]) garantit qu'une nouvelle
image est toujours disponible en temps fini. Les arènes de couche 1 qui portent ce cycle sont
réutilisées par rotation plutôt que libérées et réallouées : aucun ramasse-miettes ne vient
interrompre le rythme d'affichage. C'est la promesse que P3 faisait depuis le chapitre 1, tenue ici
sous une contrainte que la théorie seule ne pouvait pas mettre à l'épreuve.
