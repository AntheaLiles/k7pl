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

#doc (Manual) "Le théorème d'élaboration" =>
%%%
file := "c5-le-theoreme-d-elaboration"
tag := "c5-le-theoreme-d-elaboration"
%%%

{label "sec:c5-le-theoreme-d-elaboration"}

Ce chapitre décrit six façons d'écrire ce que le noyau exécute : la macro ordinaire, le glyphe, la
forme sucrée, la liaison par `bind-to`, les R-expressions et X-expressions, la notation sans point.
Elles n'ont pas la même origine ni le même usage, et elles ont un seul et même statut. Plutôt que de
le redire six fois, ce document l'énonce ici et l'invoque ensuite. {rmq}[Une seule loi, six emplois.
Ce qui suit dans ce chapitre décrit des formes, non des mécanismes.] Le mot _élaboration_ désigne ici la traduction Surface → Noyau ; la phase de résolution du pipeline (§{num "sec:c6-le-processus-de-compilation"}[], point de contrôle de la Phase 4) résout des variables d'unification, et n'est pas une élaboration au sens du théorème {num "thm:elaboration"}[].  L'expansion de macro est la Phase 1 du pipeline : elle opère sur l'arbre, donc après l'analyse syntaxique, qui est la Phase 0, et avant la configuration (Phase 2) ; la figure du chapitre 6 numérote ses onze étapes de 0 à 10 sans fraction.

::::thm (label := "thm:elaboration") (status := "definition")
:::title
élaboration
:::

:::statement +titled
Une forme de surface n'a que le sens du terme qu'elle élabore

Soit $`\mathrm{Elab} : \mathsf{Surface} \to \mathsf{Noyau}` la fonction d'élaboration. Pour toute
forme de surface $`s`,
$$`\mathrm{Elab}(s) = t \;\wedge\; \Delta \vdash t : A \mid \mathcal{E} \;\Longrightarrow\; \mathrm{Sens}(s) = \mathrm{Sens}(t).`
Aucune forme de surface n'a de sens propre, et aucune n'en ajoute au noyau.
:::

:::proofsketch
$`\mathrm{Elab}` est définie par récurrence sur la syntaxe de surface et n'émet que des termes du
noyau ; elle n'introduit aucune variable libre et respecte les liaisons. Elle est donc justiciable
du schéma de commutation (chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:schema_commutation"}[]), qui donne
$`\mathrm{Elab} \circ \text{subst} = \text{subst} \circ \mathrm{Elab}` : le sens ne dépend pas de
l'ordre dans lequel on élabore et on substitue. La compatibilité de l'action graduée
(théorème {num "thm:coherence_axiome"}[]) en donne la part quantitative, les grades de la forme de
surface se transportant sur ceux du terme sans se relâcher.
:::
::::

Trois conséquences en découlent, et elles dispensent d'autant d'arguments locaux. La _staticité de
la syntaxe_ (théorème {num "thm:staticite_syntaxe"}[]) en est un corollaire : si aucune forme de
surface n'a de sens propre, aucune n'étend la grammaire du noyau. La _dérivabilité de l'expansion_
(théorème {num "thm:expansion_macro"}[]) en est l'instance pour les macros. Et la transparence de la
défonctionnalisation, que le chapitre 6 emploie, en est l'instance pour une passe du compilateur —
le morphisme de correction que le premier postulat réclame étant ici l'identité sur le sens.

Le tableau {num "tab:c5-formes-de-surface"}[] rassemble les six formes, ce qu'elles écrivent et ce
qu'elles élaborent. Chacune tombe sous le théorème qui précède, et aucune ne demande d'argument
propre.

::::k7table (label := "tab:c5-formes-de-surface") (align := "lZ{1.0}Z{1.0}")
:::caption
Les six formes de surface du langage et leur image dans le noyau
:::

:::table +header
* * Forme
  * Ce qu'elle écrit
  * Image dans le noyau
* * macro ordinaire
  * une abréviation nommée, paramétrée
  * le corps substitué, par le lemme de substitution
* * glyphe
  * un point de code Unicode
  * la macro de bibliothèque que la table des glyphes lui associe
* * forme sucrée
  * une écriture familière d'une construction du noyau
  * la construction elle-même, sans reste
* * liaison `bind-to`
  * l'attachement d'un nom à une position d'argument
  * une application dont l'argument est nommé
* * R-expression, X-expression
  * une notation dense pour un motif fréquent
  * la S-expression correspondante
* * notation sans point
  * une composition écrite sans nommer l'argument
  * la composition explicite du noyau
:::
::::
