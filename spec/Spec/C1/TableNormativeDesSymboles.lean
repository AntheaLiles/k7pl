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

#doc (Manual) "Table normative des symboles" =>
%%%
file := "c1-table-normative"
tag := "c1-table-normative"
%%%

{label "sec:c1-table-normative"}

Cette table fixe les symboles de référence partagés entre chapitres et leur sens normatif. Une notation locale supplémentaire peut être introduite dans une section, à condition d'être définie à son premier emploi et de ne pas redéfinir un symbole déjà fixé ici. {rmq}[La distinction entre $`\Delta`
et $`\Gamma` est celle qui coûte le plus cher à enfreindre : elle sépare ce que le langage exige de
ce que la métathéorie manipule.]

::::k7table (label := "tab:c1-symboles") (align := "lZ{1.0}")
:::caption
Les symboles du document et l'objet que chacun dénote
:::

:::table +header
* * Symbole
  * Objet dénoté
* * $`\Delta`
  * contexte gradué du jugement K7PL
* * $`\Gamma`
  * contexte catégorique ou métathéorique, _jamais_ une zone du jugement
* * $`\mathcal{R}`
  * semi-anneau ordonné de la composante d'usage des grades
* * $`\mathcal{G}`
  * porteur complet des grades, produit des composantes d'usage, de monotonie, de niveau et de budget
* * $`r,\ q`
  * grades individuels
* * $`\mathbb{N}_\infty`
  * conaturels, sous-semi-anneau bien fondé où vivent les indices de taille
* * $`M,\ I(M),\ F_M`
  * mode, intervalle admissible, fragment engendré
* * $`A,\ B,\ C`
  * types
* * $`t,\ c`
  * termes, calculs
* * $`\varepsilon,\ \mathcal{E}`
  * effet individuel, effet composé
* * $`\mathcal{X}`
  * ensemble d'échappatoires de la divulgation délimitée
* * $`\sqsubseteq`
  * ordre de précision de l'information
* * $`\preccurlyeq`
  * sous-typage modal, produit mixte sur les quatre composantes
* * $`\varphi_n`, $`\psi(\Delta,\varepsilon)`
  * transformation de l'effet par multiplicité effective, et transformation d'un contexte sous un effet
* * $`\Phi_{\mathrm{dist}}`, $`\Psi_{\mathrm{grade}}`
  * interfaces de niveau grade de la loi distributive graduée ; distinctes de $`\varphi_n` et de $`\psi`
* * $`\Delta_1 + \Delta_2`
  * addition ponctuelle de contextes
* * $`\boxtimes_\varepsilon`
  * composition de contextes sous effet
* * $`A \otimes B`
  * tenseur de types, constructeur du langage
* * $`\otimes_{\mathcal{C}}`
  * tenseur de la catégorie ambiante, qui dénote la disjonction de ressources
* * $`\ell,\ \hat\ell`
  * niveau de lecture (troisième composante d'un grade) ; niveau de production (indice de la famille d'un effet)

* * $`!_r`
  * modalité de ressource
* * $`\bigcirc,\ \Box,\ \Diamond`
  * modalités temporelles — délai, permanence, éventualité
* * $`\llbracket - \rrbracket`
  * traduction vers le métalangage
:::
::::

Un mot sur le partage des glyphes modaux, car deux relectures indépendantes l'ont demandé en sens
contraires. La ressource porte $`!` et non $`\Box` : c'est le glyphe de l'exponentielle depuis
Girard, un lecteur le reconnaît sans l'apprendre, et il ne se confond avec rien. Le carré reste au
temps, où la nécessité modale lui donne son meilleur titre. Ce document a longtemps écrit les deux
pour le même objet — l'exponentielle ici, le carré indicé aux règles de typage —, ce qui était le vrai défaut,
l'un ou l'autre valant mieux que les deux.

{bibliography}
