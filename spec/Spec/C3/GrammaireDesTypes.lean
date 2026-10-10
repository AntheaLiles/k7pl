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

#doc (Manual) "Grammaire des types" =>
%%%
file := "g-grammaire-types"
tag := "g-grammaire-types"
%%%

{label "sec:g-grammaire-types"}

Les sections qui suivent écrivent ce que le corps décrit sans le poser : la grammaire des types et
des termes, puis le jeu des règles de typage. Elles sont la fondation des preuves — la préservation
du typage par la traduction, la non-interférence graduée, la divulgation délimitée, les règles de la
loi distributive et celles de la gradation indexée sont des inductions ou des relations logiques, et
se définissent _par récurrence sur une grammaire ou sur un jeu de règles_. Les deux grammaires sont
écrites, la somme et la conjonction additive sous leur forme indexée ; le jeu de règles est complet
pour les constructeurs du noyau, à une exception déclarée — l'arène, dont l'élimination relève du
modèle mémoire et non du système de types. La sémantique opérationnelle et ses théorèmes suivent au
chapitre 4 (§{num "sec:g-semantique"}[]).

Les types se rangent en trois strates, conformément au chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) : les types de valeur, les types de calcul, et les
modalités graduées qui les relient. La séparation des deux premières est celle qu'impose l'appel par
poussée de valeur, et la grammaire ci-dessous la porte.

::::formula (label := "eq:grammaire-types") (kind := "formule")
```
\begin{align*}
\text{(valeurs)}\quad V &::= b \mid @_n V \mid \mathbf{1} \mid V \otimes V \mid \textstyle\bigoplus_{i \in I} V_i \mid \mathsf{Vec}\;n\;V \mid \mathsf{Arena}\;V \mid \mathsf{Cap}\;\rho \mid !_{r} V \mid U_{\varepsilon}\,C \mid \exists \alpha. V \mid \mu\alpha. V\\
\text{(calculs)}\quad C &::= F_{\varepsilon}\,V \mid V \multimap C \mid \textstyle\mathop{\&}_{i \in I} C_i \mid \forall \alpha. C \mid \nu\alpha. C\\
\text{(sessions)}\quad S &::= \mathbf{End} \mid V \otimes S \mid V \multimap S \mid \oplus\{\ell_i : S_i\} \mid \&\{\ell_i : S_i\} \mid {\bigcirc} S \mid {\Box} S \mid {\Diamond} S\\
\text{(grades)}\quad r &::= \langle u, m, \ell, \beta \rangle \in \mathcal{G} = \mathcal{R} \times \{\mathrm{d} \preceq \mathrm{m}\} \times \mathcal{L} \times \mathcal{B}\\
\text{(effets)}\quad \varepsilon &::= \langle \varphi, \kappa \rangle \in \mathcal{E} = \mathcal{E}_0 \times (\mathbb{N}_\infty \times \mathbb{N}_\infty)^{\mathcal{L}}
\end{align*}
```

:::caption
Grammaire des types : trois strates, le grade comme quadruplet, l'effet comme produit d'une quantale
et d'une famille temporelle indexée par les niveaux
:::
::::

Dans cette notation, `\mathcal{R}` désigne uniquement le semi-anneau porteur de la composante d'usage,
tandis que `\mathcal{G}` désigne le produit des quatre composantes du grade. `\mathbb{N}_\infty` reste
le sous-semi-anneau réservé aux indices de taille et ne doit pas remplacer `\mathcal{R}` dans la
grammaire générale des grades.

Cette grammaire est _complète_ au sens précis où elle est croisée avec le jeu de règles, et le
compte n'est plus une opinion : cinquante règles de typage, dont quatre ne gouvernent aucun
constructeur de terme ; quarante-six constructeurs de termes, dont neuf valeurs et trente-sept
calculs. Le croisement est vérifié mécaniquement à chaque construction du document, et il fait
échouer celle-ci dès qu'un constructeur apparaît dans une règle sans figurer à la grammaire, ou
l'inverse. Les quatre règles sans constructeur ne sont pas une anomalie : ce sont les deux règles de
sous-typage, qui s'appliquent à tout terme sans en former, et les deux règles structurelles de
formation de contexte. Une grammaire qui ne serait pas croisée avec ses règles ne serait pas
incomplète — elle serait invérifiable, ce qui est pire, puisque rien ne signalerait l'écart.

Trois points appellent un commentaire, car ils fixent des choix que le corps a pris sans les écrire
sous cette forme. Le premier est que $`!_r` est _une_ modalité et non quatre : sa syntaxe accepte un
grade complet comme indice, dont les composantes sont l'usage, la marque de monotonie, le niveau de
confidentialité et le budget. La correspondance de cet indice avec le support de la comonade graduée est désormais testée par
le candidat $`\mathcal{G} \xrightarrow{\pi_U} \mathcal{R} \xrightarrow{!} End(\mathcal{C})` du
§{num "sec:c2-candidat-factorisation-index-complet"}[]. La notation conserve le grade complet comme
annotation, tandis que le noyau comonadique reçoit son indice d'usage. Le statut reste celui d'une
architecture candidate tant que les coercions du grade complet et la substitution ne sont pas
entièrement vérifiées. Le deuxième est que les types de session portent les trois modalités temporelles
du §{num "sec:c4-echelle-du-systeme"}[], ce qui est la manière dont le débit s'exprime. Le troisième
est que $`\mathsf{Trellis}_{\text{fin}}`, condition de l'opérateur de point fixe, se lit sur cette
grammaire. Le dire en prose ne suffit pas à une induction, qui a besoin d'un prédicat ; on le pose
donc par les quatre clauses qui l'engendrent, et par rien d'autre.

::::formula (label := "eq:trellis-fin") (kind := "formule")
```
\begin{gather*}
\frac{\;b \text{ de porteur fini, égalité décidable}\;}{\;\mathsf{Trellis}_{\text{fin}}(b)\;}
\qquad
\frac{\;}{\;\mathsf{Trellis}_{\text{fin}}(\mathbf{1})\;}
\\[8pt]
\frac{\;\mathsf{Trellis}_{\text{fin}}(V_1) \quad \mathsf{Trellis}_{\text{fin}}(V_2)\;}{\;\mathsf{Trellis}_{\text{fin}}(V_1 \otimes V_2)\;}
\qquad
\frac{\;\mathsf{Trellis}_{\text{fin}}(V) \quad n < \omega\;}{\;\mathsf{Trellis}_{\text{fin}}(\mathsf{Vec}\;n\;V)\;}
\\[8pt]
\frac{\;\mathsf{Trellis}_{\text{fin}}(V_i)\;(\forall i \in I) \quad I \text{ fini}\;}{\;\mathsf{Trellis}_{\text{fin}}(\textstyle\bigoplus_{i \in I} V_i)\;}
\end{gather*}
```

:::caption
Le prédicat de treillis fini, défini par induction sur la grammaire des types de valeur
:::
::::

Aucune autre clause. En particulier $`!_r`, $`U_{\varepsilon}\,C`, l'existentiel et le point fixe $`\mu` n'y
entrent pas, et ce n'est pas un oubli : un porteur qui les admettrait cesserait d'être fini, et
l'itération de l'opérateur de point fixe cesserait de terminer.

Le quatrième porte sur le facteur temporel de l'effet, et il rectifie ce que ce texte écrivait.
Le niveau étiquette l'effet sur ses deux composantes. Un facteur temporel réduit à un entier nu ne
peut pas porter simultanément le travail et la profondeur ; la forme normative est donc une famille
de couples
$`\kappa \in (\mathbb{N}_\infty\times\mathbb{N}_\infty)^{\mathcal L}` indexée par les niveaux,
un $`\mathbf{tick}` étant compté au niveau du calcul qui le produit. L'ordre reste celui du produit,
point par point ; le séquencement additionne les couples composante par composante ; la mise en
parallèle additionne les travaux et prend le maximum des profondeurs ; l'itération $`\varphi_n`
multiplie chaque composante par $`n`.

Cette forme rend explicite la décision du noyau : le parallélisme appartient à l'algèbre des effets,
et non à une nouvelle composante du grade. Le budget reste une annotation de contexte ; sa relation
avec les deux composantes temporelles est traitée séparément par $`Cost_{\mathcal B}`.

::::lemma (label := "thm:temps_mononiveau") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "Sous-quantale des effets concentrés à un niveau ; vérifier fermeture et signature complète des opérations.")
:::title
le cas mononiveau redonne la forme plate
:::

:::statement +titled
Une généralisation qui ne coûte rien où elle ne sert pas

Si tous les $`\mathbf{tick}` d'un calcul sont produits à un même niveau $`\ell`, la famille
$`\kappa` est concentrée en $`\ell`, et la restriction de $`\mathcal{E}` aux tels effets est
isomorphe, comme quantale ordonnée, à
$`\mathcal{E}_0 \times (\mathbb{N}_\infty\times\mathbb{N}_\infty)`.
:::

:::proofsketch
L'application $`\kappa \mapsto \kappa(\ell)` est une bijection entre les familles concentrées
en $`\ell` et $`\mathbb{N}_\infty\times\mathbb{N}_\infty`, d'inverse
$`(w,s) \mapsto \langle w,s\rangle \delta_{\ell}`. Elle préserve l'addition et l'ordre,
définis point par point, ainsi que la multiplication scalaire de $`\varphi_n`.
Elle est donc un isomorphisme de quantales ordonnées sur ce sous-ensemble, lequel est clos par
produit et par borne supérieure puisque la concentration en $`\ell` l'est.
:::
:
::::
La lecture qu'il faut en faire est celle que le chapitre 1 a déjà pratiquée sur les contextes. Une
zone non restreinte n'était pas une seconde zone mais la partie de grade $`\omega` de la première ;
un compteur de pas nu n'est pas une seconde notion mais la famille concentrée en un niveau. Là où le
langage n'emploie qu'un niveau — la couche 1 dans son usage ordinaire, tout programme qui ne mêle
pas les confidentialités —, la généralisation est invisible.
