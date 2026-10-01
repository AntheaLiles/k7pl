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

#doc (Manual) "Catégorie ambiante" =>
%%%
file := "c2-la-categorie-ambiante"
tag := "c2-la-categorie-ambiante"
%%%

{label "sec:c2-la-categorie-ambiante"}

Une catégorie monoïdale symétrique fermée est la donnée d'une catégorie _C_, d'un bifoncteur
$`\otimes : \mathcal{C} \times \mathcal{C} \to \mathcal{C}`, d'un objet unité $`I`, d'isomorphismes
naturels d'associativité et d'unité satisfaisant les identités de cohérence usuelles (pentagone,
triangle), d'un isomorphisme naturel de symétrie
$`\sigma_{A,B} : A \otimes B \xrightarrow{\sim} B \otimes A` involutif, et, pour la fermeture, d'un
adjoint à droite $`[A \multimap -]` au foncteur $`- \otimes A` pour chaque objet $`A` : une
bijection naturelle

::::formula (label := "eq:adjonction-tenseur-hom") (kind := "equation")
```
\begin{equation}
\text{Hom}(\Gamma \otimes A, B) \;\cong\; \text{Hom}(\Gamma, [A \multimap B])
\end{equation}
```
::::

qui identifie une fonction de deux arguments à sa forme curryfiée. C'est cette structure, et rien de
plus, que K7PL prend pour catégorie ambiante _C_ : ses objets sont les types du langage, ses
morphismes $`A \to B` sont les programmes purs de type $`A` vers $`B`, l'unité $`I` est le type sans
ressource, et $`[A \multimap B]` est le type des fonctions de $`A` vers $`B`.

Un terme dans un contexte n'est alors qu'un cas particulier de morphisme. Si
$`\Gamma = A_1 \otimes \dots \otimes A_n` dénote la combinaison tensorielle des types d'un contexte
de typage — $`\Gamma` étant ici l'objet de _C_ et jamais la zone du jugement, que le chapitre 1
réserve à $`\Delta` —, un jugement $`\Gamma \vdash t : T` n'est rien d'autre qu'un morphisme
$`t : \Gamma \to T` de _C_ ; une donnée close n'est que le cas particulier où $`\Gamma = I`. Cette
lecture, déjà annoncée au chapitre 1, unifie sous une seule notion — la flèche de _C_ — ce qu'une
présentation naïve distinguerait en valeurs, en fonctions et en termes ouverts.

Le choix d'une structure symétrique plutôt que cartésienne n'est pas cosmétique : c'est lui qui
porte toute la lecture spatiale du tenseur. Une catégorie cartésienne fournit, pour tout objet $`A`,
des projections $`A \otimes A \to A` et une diagonale $`A \to A \otimes A` — deux familles de
morphismes disponibles inconditionnellement, quel que soit $`A`. Rien, dans la définition d'une SMCC
générale, ne garantit leur existence : un objet $`A` quelconque de _C_ n'a, a priori, ni projection
ni diagonale. C'est précisément cette absence qui rend $`\otimes` apte à modéliser la disjonction de
ressources plutôt que leur simple groupement : écrire $`P \otimes Q` engage, dans une SMCC
générique, exactement les ressources attestées par $`P` et par $`Q`, ni plus — rien ne permet d'en
extraire une copie supplémentaire — ni moins — rien ne permet d'en oublier une partie sans la
consommer. La logique de séparation évoquée au chapitre 1 n'est donc pas une lecture ajoutée à la
structure monoïdale. Elle en est le comportement par défaut, dès lors qu'on ne suppose pas — ce que
K7PL se garde de faire pour l'ensemble de _C_ — que le tenseur coïncide avec un produit cartésien.

C'est ce même défaut de projections et de diagonale qui, en creux, définit le fragment linéaire
strict de la couche 1 : _C_ elle-même, sans aucune structure additionnelle, est déjà ce fragment.
Restituer sélectivement ces deux opérations est le rôle de la comonade exponentielle, construite à
la section suivante.
