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
Ce qui suit dans ce chapitre décrit des formes, non des mécanismes.] Le mot _élaboration_ désigne ici la traduction Surface → Noyau ; la phase de résolution du pipeline (§{num "sec:c6-le-processus-de-compilation"}[], point de contrôle 2.5) résout des variables d'unification, et n'est pas une élaboration au sens du théorème {num "thm:elaboration"}[].  L'expansion de macro est la Phase 0 du pipeline : elle opère sur l'arbre ; la figure du chapitre 6 ne la porte pas encore, et reste à corriger.

::::definition (label := "def:elaboration") (level := "langage") (state := "not-applicable") (evidence := "none") (scope := "syntax")
:::title
fonction d’élaboration
:::

:::statement +titled
Fonction d’élaboration

Soit $`\mathrm{Elab} : \mathsf{Surface} \to \mathsf{Noyau}` la fonction d'élaboration.
:::
::::

::::theorem (label := "thm:elaboration") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "syntax")
:::title
élaboration
:::

:::statement +titled
Une forme de surface n'a que le sens du terme qu'elle élabore

Pour toute
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
l'ordre dans lequel on élabore et on substitue. La partie quantitative relève du lemme de substitution et de l'action de mise à l'échelle
factorisée $`\operatorname{Scale}_{\mathrm{Usage}}`. Les formes qui effectuent explicitement une
ré-invocation finie ajoutent leur obligation propre sur $`\varphi_n` ; cette obligation ne peut être
étendue par défaut aux grades complets ni aux usages rationnels.
:::
:::note
_Obligation ouverte._ La définition de $`\mathrm{Elab}` est déjà séparée de ce théorème. Restent à
énoncer les conditions de typage et de portée sous lesquelles l'égalité des sens est démontrée, et à
décharger pour cette instance les obligations du schéma de commutation, que sa citation ne décharge
pas.
:::
::::
Si le théorème d'élaboration est établi sous ses hypothèses effectives, il pourra soutenir des résultats sur la staticité de la syntaxe et sur l'expansion des macros. Leur statut ne découle toutefois pas de la seule définition récursive de l'élaboration : chaque instance doit satisfaire les obligations de commutation, de substitution et de préservation du sens. La correction de la défonctionnalisation relève en outre d'un argument de compilation distinct.

Le tableau {num "tab:c5-formes-de-surface"}[] rassemble les six formes, ce qu'elles écrivent et ce qu'elles élaborent. Il décrit les correspondances prévues ; il ne dispense pas de vérifier chaque instance.

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
