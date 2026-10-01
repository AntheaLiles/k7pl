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

#doc (Manual) "E.2. Grammaire des termes" =>
%%%
file := "g-grammaire-termes"
tag := "g-grammaire-termes"
number := false
%%%

{label "sec:g-grammaire-termes" (display := "E.2")}

::::formula (label := "eq:grammaire-termes") (kind := "formule")
```
\begin{align*}
\text{(valeurs)}\quad v &::= x \mid () \mid (v, v) \mid \mathsf{inj}_i\,v \mid \mathsf{box}_r\,v \mid \mathsf{thunk}\;c \mid \mathsf{pack}\,(V, v) \mid \mathsf{fold}\;v \mid [v_0,\ldots,v_{n-1}]\\
\text{(calculs)}\quad c &::= \mathsf{return}\;v \mid \mathsf{let}\;x \leftarrow c\;\mathsf{in}\;c \mid \lambda x. c \mid c\;v \mid \mathsf{force}\;v \mid \mathsf{case}\;v\;\mathsf{of}\;\{i \mapsto c\}_{i \in I}\\
&\quad \mid\; \mathsf{let}\;() = v\;\mathsf{in}\;c \mid \mathsf{let}\;(x,y) = v\;\mathsf{in}\;c \mid \langle c_i \rangle_{i \in I} \mid c.i\\
&\quad \mid\; \mathsf{unbox}\;v\;\mathsf{as}\;x\;\mathsf{in}\;c \mid \mathsf{open}\;v\;\mathsf{as}\;(\alpha,x)\;\mathsf{in}\;c \mid \mathsf{unfold}\;v\\
&\quad \mid\; \Lambda\alpha. c \mid c\,[W] \mid \mathbf{fix}\;v \mid \mathbf{declassify}_{\ell}(v) \mid \mathsf{iter}_{V}\;v\;c\\
&\quad \mid\; \mathsf{operation}_{\varepsilon}(v) \mid \mathsf{scoped}_{f}(v, c)\\
&\quad \mid\; \mathsf{delay}\;c \mid \mathsf{always}\;v \mid \mathsf{at}\;v \mid \mathsf{now}\;v \mid \mathsf{wait}\;v \mid \mathsf{when}\;x = v\;\mathsf{in}\;c\\
&\quad \mid\; \mathsf{out}\;c \mid \langle\!\langle j \mapsto c_j \rangle\!\rangle_{j \in J}\\
&\quad \mid\; c \parallel c \mid \mathsf{vmap}\;v\;v\\
&\quad \mid\; \mathsf{at}_n\;c \mid \mathsf{move}_{n \to m}\;v \mid \mathsf{try}\;c\;\mathsf{catch}\;c\\
&\quad \mid\; \mathsf{spawn}\;c \mid \mathsf{new}_E \mid \mathsf{send}\;m(\overline{v})\;\mathsf{to}\;v \mid \mathsf{guard}\;v\;\{m_i(\overline{x_i}) \mapsto c_i\}_i \mid \mathsf{free}\;v
\end{align*}
```

:::caption
Grammaire des termes, en style appel par poussée de valeur
:::
::::

Cette grammaire est complète au sens précis où chaque règle du §{num "sec:g-regles"}[] y trouve la
forme qu'elle gouverne, et réciproquement. Elle ne l'était pas : dix-sept constructeurs y manquaient
— les deux éliminations d'unité et de tenseur, l'introduction et la projection du produit négatif,
l'ouverture de l'existentiel, le dépliage, les deux formes du quantificateur universel, l'opération
à portée, le littéral de vecteur, et les six formes temporelles. L'écart s'était creusé sans
qu'aucun contrôle le voie, et c'est la faute que la Définition de Standard ML s'impute : ne pas
spécifier la syntaxe complète parce que le reste est dérivé. Un contrôle automatique compare
désormais les deux, et il échoue plutôt que de laisser l'écart se rouvrir.

Trois formes appellent une précision, car leur statut n'est pas celui des autres. $`\mathbf{tick}`
n'y figure pas et c'est délibéré~: il est une _instance_ du schéma
$`\mathsf{operation}_{\varepsilon}`, non un constructeur de plus. $`\mathsf{scoped}_{f}(v, c)` est
la forme des opérations _à portée_, qui prennent un calcul en argument et ne sont pas des effets
algébriques ordinaires~; sa règle est écrite au §{num "sec:g-regles"}[] et la structure qu'elle
suppose y est construite. Et l'expansion de macro, dont le théorème~{num "thm:expansion_macro"}[]
établit la dérivabilité, n'a pas de forme dans cette grammaire parce qu'elle n'en est pas une~: elle
opère en Phase~0, sur l'arbre, avant que cette grammaire ne s'applique.

Le vocabulaire de cette grammaire suit une règle qui explique une apparente redondance. Les
constructeurs du noyau nomment ce qu'une chose _est/~; les mots de surface nomment ce qu'un
programme en /fait_. $`\mathsf{operation}` et $`\mathsf{scoped}` sont deux espèces d'opération
d'effet, distinguées par la théorie~; `perform` et `handle` sont deux actions, invoquer et traiter~;
`handler` n'est ni l'un ni l'autre, c'est le nom d'une _valeur_. Ce ne sont donc pas deux jeux de
noms pour les mêmes objets, et aucune table de correspondance n'est due au lecteur : écrire que
$`\mathsf{operation}` « veut dire » `perform` serait faux. La même règle explique pourquoi les
abréviations qui figuraient ici jusqu'au 3 septembre ont été écartées : deux constructeurs de même
espèce doivent porter des noms de même forme, et deux abréviations de longueurs différentes n'en
sont pas.
