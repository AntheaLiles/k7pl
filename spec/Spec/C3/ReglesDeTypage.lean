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

#doc (Manual) "Règles de typage" =>
%%%
file := "g-regles"
tag := "g-regles"
%%%

{label "sec:g-regles"}

Deux règles sont données au corps : celle du point fixe déductif ({num "eq:regle-fix"}[]) et celle
de la déclassification ({num "eq:regle-declassify"}[]). Les autres sont données ici, en quatre
groupes, dans l'ordre où l'induction du chapitre 4 (§{num "sec:c4-le-calcul-de-processus"}[]) les
rencontre. Ce qui suit n'est plus un inventaire mais un jeu. Chaque groupe a son coût, et c'est ce
compte qui a réduit ce qui paraissait un chantier ouvert à une liste bornée de décisions.

Les règles _structurelles_ se réduisent à une seule, et c'est le premier gain de la gradation. Dans
un système gradué, l'affaiblissement et la contraction ne sont pas des règles mais des conséquences
de l'arithmétique des grades : affaiblir, c'est produire une liaison au grade nul ; contracter,
c'est additionner deux grades. La règle de variable les absorbe donc toutes deux, en exigeant que
toutes les liaisons du contexte portent le grade nul sauf celle qu'on emploie, laquelle porte
l'unité. L'échange est admissible pour une raison distincte et qui tient à un choix ancien : les
contextes ne sont pas ordonnés, l'encodage des protocoles dans l'implication linéaire (chapitre 3)
ayant précisément permis d'éviter le produit ordonné qu'ils auraient exigé. Une règle primitive
donc, et trois propriétés à établir.

Les règles des _connecteurs_ sont les plus nombreuses — une introduction et une élimination par
constructeur des trois grammaires, soit une quarantaine — et les plus routinières. Six seulement
demandent de l'attention. Les quatre de l'adjonction entre valeurs et calculs portent le régime
d'évaluation et fixent où les effets s'accumulent. Celles du quantificateur existentiel comptent
double, car c'est par elles que passe la preuve de non-interférence : le témoin caché y est
l'abstraction que la paramétricité transforme en indiscernabilité. Et les trois modalités
temporelles n'ont pas de forme héritée — leur combinaison avec la gradation est propre à ce langage,
et leurs règles sont à concevoir plutôt qu'à transcrire.

Les règles _propres à K7PL_ sont moins nombreuses qu'annoncé, et pour une raison simple : les
sessions n'y contribuent rien. Un protocole étant une syntaxe de surface sur l'implication linéaire,
ses règles sont celles de cette implication, et la dualité tombe du retournement des arguments
plutôt que d'un jeu propre. Restent donc deux groupes. L'introduction et l'élimination de la
modalité graduée, où le contexte est multiplié par le grade à l'entrée et divisé à la sortie — c'est
là que vit toute la discipline de ressource. Et les opérations à effet, dont la règle compose par le
produit de la quantale, avec la réserve que le chapitre 3 a posée. Les opérations à portée prennent
un calcul en argument et ne sont pas des effets algébriques ordinaires~; leur forme est fixée plus
bas (§{num "sec:g-scoped"}[]), l'effet y devenant une fonction de l'effet de l'argument plutôt
qu'une constante.

Les règles de _sous-typage_, enfin, sont peu nombreuses et recèlent le seul piège de l'ensemble. Ce
sont les coercions que la structure ordonnée du grade autorise, une par composante, plus leur
composition. Le piège est que _la direction de la coercion n'est pas la même pour toutes_. Sur
l'usage, elle descend : disposer d'une ressource librement copiable permet de ne l'employer qu'une
fois, et $`!_\omega A` se coerce donc en $`!_1 A`. Sur la monotonie, elle descend aussi : avoir
établi qu'une fonction préserve l'ordre permet de l'oublier. Sur le niveau de confidentialité, elle
_monte_ : une donnée publique peut être traitée comme secrète, jamais l'inverse — c'est le sens même
de la garantie. Et sur le budget, elle monte également : un calcul qui exige peu s'emploie là où
l'on offre davantage. Deux composantes descendent, deux montent, et prendre le produit des ordres
sans y regarder inverserait la garantie de confidentialité. L'ordre du sous-typage n'est donc pas
l'ordre du grade mais son produit mixte, et cette distinction doit figurer dans les règles plutôt
que dans un commentaire.

Ce qui suit donne le jeu central. Les conventions sont celles-ci. $`\Delta` est un contexte gradué
$`x_1 :_{r_1} V_1, \ldots` ; $`r\cdot\Delta` multiplie tous ses grades par $`r`.
$`\Delta_1 + \Delta_2` les additionne composante par composante, _à condition qu'ils portent les
mêmes liaisons_. La condition s'écrit $`0\cdot\Delta_1 = 0\cdot\Delta_2`, l'annulation des grades ne
laissant que les couples variable-type, et sans elle l'addition point par point n'est pas définie {cite "HUANG"}[]
; $`\mathbf{0}` est le contexte de grades nuls. Enfin $`\Delta_1 \boxtimes_\varepsilon \Delta_2`
note la composition que la loi distributive du chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) gouverne, définie au chapitre 1
(§{num "sec:c1-de-la-loi-distributive"}[], équation {num "eq:boxtimes"}[]) par
$`\Delta_1 + \psi(\Delta_2, \varepsilon)` : l'addition assortie du transport que $`\varphi` et
$`\psi` prescrivent.

Une précision de notation, qui n'en est pas une de forme. $`\boxtimes` _dépend de l'effet traversé_,
et l'omettre laisserait le lecteur le reconstituer à chaque règle. L'indice est donné par le
séquencement, et sans ambiguïté : c'est l'effet du calcul qui s'exécute _le premier_, celui dont
l'exigence du second doit traverser le coût.

Le relever une fois pour toutes fait apparaître un fait que l'absence d'indice dissimulait. _Deux
règles seulement portent un indice non trivial_ : {sc}[Let], où c'est $`\varepsilon_1`, l'effet du
calcul lié ; et {sc}[App], où c'est $`\varepsilon_0`, celui du terme fonction. Les neuf autres — {sc}[Unbox], {sc}[Open], {sc}[OneE], {sc}[Split], {sc}[Case], {sc}[When], {sc}[Sc], {sc}[VecE],
et le lemme de substitution — éliminent toutes une _valeur_, dont l'effet est neutre. Par le lemme
ci-après, leur $`\boxtimes` _est_ l'addition ponctuelle. La composition graduée n'a donc de contenu
propre qu'aux deux endroits où un calcul précède un autre calcul, ce qui est exactement là où l'on
attendait qu'elle en eût, et nulle part ailleurs. Les règles portent désormais leur indice, et une
mécanisation n'aura ni à le deviner ni à traiter neuf cas là où deux suffisent.

::::thm (label := "thm:boxtimes_addition")
:::title
$`\boxtimes` généralise l'addition ponctuelle
:::

:::statement +titled
L'addition est le cas sans coût temporel

Pour tous contextes $`\Delta_1, \Delta_2` et tout effet $`\varepsilon` dont la composante temporelle
est nulle, $$`\Delta_1 \boxtimes_\varepsilon \Delta_2 \;=\; \Delta_1 + \Delta_2,` et l'égalité est
_totale_ : $`\psi(\cdot,\varepsilon)` y est définie partout.
:::

:::proofsketch
Par la définition ({num "eq:boxtimes"}[]),
$`\Delta_1 \boxtimes_\varepsilon \Delta_2 = \Delta_1 + \psi(\Delta_2, \varepsilon)`. La table de
l'action de $`\varphi` et $`\psi` (§{num "sec:c1-de-la-loi-distributive"}[]) donne celle de
$`\psi` : elle traverse inchangé sur l'usage, le niveau et la monotonie, et n'agit que sur le
budget, par $`\beta \ominus k` où $`k` est la composante temporelle de $`\varepsilon`. Si $`k = 0`
alors $`\beta \ominus 0 = \beta`, la soustraction tronquée dans $`\mathbb{N}_\infty` ayant $`0` pour
neutre à droite. Donc $`\psi(\Delta_2,\varepsilon) = \Delta_2` sur les quatre composantes.

La totalité suit du même calcul : la soustraction tronquée n'échoue que lorsque le budget ne couvre
pas le coût, et à coût nul elle est définie partout. C'est le seul point de cette section où $`\psi`
soit totale, et il vaut d'être relevé.
:::
::::

Ce lemme n'est pas une commodité de calcul : il situe K7PL par rapport à la forme reçue. Des
présentations indépendantes des systèmes gradués écrivent la règle d'application en multipliant le
contexte de l'argument par le grade que la flèche exige, puis en le combinant à celui du terme
fonction par l'_addition ponctuelle_ du semi-anneau {cite "hanukaevUnificationGradedSubstructural2026"}[], {cite "hughesProgramSynthesisGraded2024"}[].
K7PL écrit $`\Delta_1 \boxtimes_{\varepsilon_0} (r\cdot\Delta_2)`, et le lemme dit que les deux
formes coïncident dès que l'effet ne coûte rien. Or aucune d'elles n'a d'effet qui traverse le
coeffet : leur composante temporelle est identiquement nulle, et leur $`\boxtimes` _est_ leur $`+`.
Elles n'ont donc pas fait un autre choix — elles travaillent dans le cas où les deux opérateurs se
confondent, et n'avaient aucune raison d'en distinguer deux. K7PL généralise la forme reçue plutôt
qu'il ne s'en écarte, et c'est l'effet traversant qui l'y oblige.

::::formula (label := "eq:jeu-regles") (kind := "formule")
```
\begin{gather*}
\textsc{Var}\;\frac{\;}{\;\mathbf{0}\cdot\Delta,\, x :_{1} V \;\vdash\; x : V\;}
\qquad
\textsc{Ret}\;\frac{\;\Delta \vdash v : V\;}{\;\Delta \vdash \mathsf{return}\;v : F_{\mathbf{1}} V \mid \mathbf{1}\;}
\\[8pt]
\textsc{Th}\;\frac{\;\Delta \vdash c : C \mid \varepsilon\;}{\;\Delta \vdash \mathsf{thunk}\;c : U_\varepsilon C\;}
\end{gather*}
```

```
\begin{equation*}
\textsc{Let}\;\frac{\;\Delta_1 \vdash c_1 : F_{\varepsilon_1} V \mid \varepsilon_1 \qquad \Delta_2,\, x:_1 V \vdash c_2 : C \mid \varepsilon_2\;}{\;\Delta_1 \boxtimes_{\varepsilon_1} \Delta_2 \vdash \mathsf{let}\;x \leftarrow c_1\;\mathsf{in}\;c_2 : C \mid \varepsilon_1 \cdot \varepsilon_2\;}
\qquad
\textsc{Fo}\;\frac{\;\Delta \vdash v : U_\varepsilon C\;}{\;\Delta \vdash \mathsf{force}\;v : C \mid \varepsilon\;}
\end{equation*}
```

```
\begin{gather*}
\textsc{Box}\;\frac{\;\Delta \vdash v : V\;}{\;r\cdot\Delta \vdash \mathsf{box}_r\,v : !_r V\;}
\\[8pt]
\textsc{Unbox}\;\frac{\;\Delta_1 \vdash v : !_r V \qquad \Delta_2,\, x :_r V \vdash c : C \mid \varepsilon\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} \Delta_2 \vdash \mathsf{unbox}\;v\;\mathsf{as}\;x\;\mathsf{in}\;c : C \mid \varepsilon\;}
\end{gather*}
```

```
\begin{gather*}
\textsc{Lam}\;\frac{\;\Delta,\, x :_r V \vdash c : C \mid \varepsilon\;}{\;\Delta \vdash \lambda x.c : V_r \multimap_\varepsilon C \mid \mathbf{1}\;}
\\[8pt]
\textsc{App}\;\frac{\;\Delta_1 \vdash c : V_r \multimap_\varepsilon C \mid \varepsilon_0 \qquad \Delta_2 \vdash v : V\;}{\;\Delta_1 \boxtimes_{\varepsilon_0} (r\cdot\Delta_2) \vdash c\,v : C \mid \varepsilon_0 \cdot \varepsilon\;}
\end{gather*}
```

```
\begin{equation*}
\textsc{Pair}\;\frac{\;\Delta_1 \vdash v_1 : V_1 \qquad \Delta_2 \vdash v_2 : V_2\;}{\;\Delta_1 + \Delta_2 \vdash (v_1,v_2) : V_1 \otimes V_2\;}
\qquad
\textsc{Inj}\;\frac{\;\Delta \vdash v : V_i \qquad i \in I\;}{\;\Delta \vdash \mathsf{inj}_i\,v : \textstyle\bigoplus_{j \in I} V_j\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Pack}\;\frac{\;\Delta \vdash v : V[W/\alpha]\;}{\;\Delta \vdash \mathsf{pack}\,(W,v) : \exists\alpha.V\;}
\qquad
\textsc{Open}\;\frac{\;\Delta_1 \vdash v : \exists\alpha.V \quad \Delta_2,\, x:_1 V \vdash c : C \mid \varepsilon \quad \alpha \notin \mathrm{fv}(C)\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} \Delta_2 \vdash \mathsf{open}\;v\;\mathsf{as}\;(\alpha,x)\;\mathsf{in}\;c : C \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{One}\;\frac{\;}{\;\mathbf{0}\cdot\Delta \vdash () : \mathbf{1}\;}
\qquad
\textsc{OneE}\;\frac{\;\Delta_1 \vdash v : \mathbf{1} \qquad \Delta_2 \vdash c : C \mid \varepsilon\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} \Delta_2 \vdash \mathsf{let}\;() = v\;\mathsf{in}\;c : C \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Split}\;\frac{\;\Delta_1 \vdash v : V_1 \otimes V_2 \qquad \Delta_2,\, x :_{1} V_1,\, y :_{1} V_2 \vdash c : C \mid \varepsilon\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} \Delta_2 \vdash \mathsf{let}\;(x,y) = v\;\mathsf{in}\;c : C \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Case}\;\frac{\;\Delta_1 \vdash v : \textstyle\bigoplus_{i \in I} V_i \qquad \Delta_2,\, x :_{1} V_i \vdash c_i : C \mid \varepsilon \;\;(\forall i \in I) \qquad \mathrm{niv}(\Delta_1) \sqsubseteq \hat\ell(\varepsilon)\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} \Delta_2 \vdash \mathsf{case}\;v\;\mathsf{of}\;\{i \mapsto c_i\}_{i \in I} : C \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Op}\;\frac{\;\Delta \vdash v : V_{\mathsf{operation}} \qquad \mathrm{niv}(\Delta) \sqsubseteq \hat\ell(\varepsilon)\;}{\;\Delta \vdash \mathsf{operation}_\varepsilon(v) : F_{\mathbf{1}} W \mid \varepsilon\;}
\qquad
\textsc{Tick}\;\frac{\;}{\;\mathbf{0} \vdash \mathbf{tick} : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathbf{1}, \delta_{\hat\ell}\rangle\;}
\qquad
\textsc{Del}\;\frac{\;\Delta \vdash c : C \mid \varepsilon\;}{\;{\bigcirc}\Delta \vdash \mathsf{delay}\;c : {\bigcirc}C \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Sub}\;\frac{\;\Delta \vdash c : C \mid \varepsilon \qquad C <: C' \qquad \varepsilon \sqsubseteq \varepsilon'\;}{\;\Delta \vdash c : C' \mid \varepsilon'\;}
\qquad
\textsc{SubBox}\;\frac{\;r \preccurlyeq r'\;}{\;!_r V <: !_{r'} V\;}
\end{equation*}
```

:::caption
Le jeu de règles central : variable, adjonction, modalité graduée, effets et sous-typage
:::
::::

Deux niveaux circulent dans ces règles, et ils ne sont pas le même ordre. Le _niveau de lecture_
$`\ell` est la troisième composante d'un grade $`r` : ce qu'une liaison $`x :_r V` donne le droit
de lire, et $`\mathrm{niv}(\Delta) = \bigsqcup_{x :_r V \in \Delta} \mathrm{niv}(r)` est celui d'un
contexte. Le _niveau de production_ $`\hat\ell` est celui auquel un événement est observable : la
famille $`\kappa` d'un effet $`\varepsilon = \langle \varphi, \kappa \rangle` est indexée par lui, et
$`\hat\ell(\varepsilon)` en désigne la borne inférieure des niveaux où $`\kappa` est non nulle — et
$`\top` si $`\kappa = 0`, un effet sans événement temporel n'ayant rien à protéger. Le premier est
contravariant (le niveau d'un contexte monte avec ce qu'il lit), le second covariant ; les écrire
$`\ell` et $`\hat\ell` évite que « $`\ell \sqsubseteq \ell` » ne soit inénonçable. {sc}[Tick]
choisit son niveau de production $`\hat\ell`, et l'effet $`\langle \mathbf{1}, \delta_{\hat\ell}\rangle` est
bien formé, $`\kappa` étant une famille et non un nombre. Ce choix serait libre, donc contournable,
sans la clause de couplage que portent {sc}[Op] et {sc}[Case] : un calcul n'inspecte ni ne
transmet que des valeurs dont le niveau de lecture est au plus son niveau de production. Un
`case` sur une somme secrète dont les branches produiraient des ticks publics est ainsi
rejeté, et le canal temporel que ce document déclare fermé l'est par règle. La correspondance est
_dérivée_ et non décidée : l'exclusion de $`\varphi_\ell` hors de la quantale des effets
n'est plus une clause négative posée à la main. Le niveau courant du processus est celui que
porte son effet ; il n'est donc pas nécessaire de l'indexer en plus dans le jugement.

Trois de ces règles ne demandent rien, et sont écrites plutôt qu'omises : une règle absente est un
cas manquant dans toute induction — et le lemme de substitution du §{num "sec:g-regles"}[] procède
par récurrence sur la dérivation. {sc}[One] et {sc}[OneE] donnent l'unité ; {sc}[Split] élimine le
tenseur ; {sc}[Case] élimine la somme. Deux points seulement s'y décident. Le premier est que {sc}[Case]
_partage_ son contexte entre les branches au lieu de l'additionner, une seule d'entre elles
s'exécutant : c'est le même trait que {sc}[With] au §{num "sec:g-regles"}[], et il est correct pour
la même raison. Le second est que toutes les branches y portent le _même_ effet ; cela ne restreint
rien, {sc}[Sub] permettant de relever chacune jusqu'à leur borne supérieure, et l'écrire ainsi évite
d'introduire un joint dans la règle. Cet argument suppose l'existence de cette borne supérieure,
c'est-à-dire l'existence de _jointures_ — et c'est la condition du théorème {num "thm:coherence_subsomption"}[]
ci-après, dont la vérification est faite au §{num "sec:g-regles"}[]. L'argument employé ici est donc
déjà celui du théorème, et il n'était pas dit qu'il l'était : relever une branche jusqu'à un joint
et démontrer que deux dérivations coïncident demandent la même structure.

La forme _indexée_ de {sc}[Case] n'est pas un raffinement de présentation, et il faut dire pourquoi
elle a été préférée à la forme binaire que ce texte écrivait. Un gestionnaire d'acteur a autant
de branches qu'il reçoit d'espèces de messages. L'encoder par une cascade de sommes binaires
rendrait le nombre de branches dépendant d'un ordre arbitraire, et le typage d'un protocole
dépendrait de la manière dont on a associé les alternatives. Les types de session de cette même
grammaire portaient d'ailleurs déjà la forme indexée, $`\oplus\{\ell_i : S_i\}` : c'étaient les
types de valeur et de calcul qui faisaient exception. La somme et la conjonction additive sont donc
indexées partout, et {sc}[Inj], {sc}[With] et {sc}[Proj] le sont avec elles.

Un second motif appuie ce choix, indépendant du premier, et la mécanisation étant un objectif
déclaré : le coût de preuve. Une mécanisation de référence rapporte que l'ajout de quelques règles
de réduction pour les sommes disjointes a _doublé_ la preuve de correction, le seul lemme de
confluence recevant treize cas de plus, dont plusieurs répétitifs {cite "abelPOPLMarkReloadedMechanizing2019"}[].
Un schéma indexé donne un cas d'induction là où une cascade de binaires en donne autant que de
branches. Deux raisons indépendantes — la fidélité au protocole d'un acteur, et le coût de la preuve
— arrivent donc au même choix, ce qui est le meilleur statut qu'un choix de présentation puisse
avoir.

Ce passage à l'indexation oblige à dire ce que l'ensemble d'indices $`I` peut être, question que la
forme binaire dissimulait. La réponse tient en deux temps, et c'est le prédicat de treillis fini qui
la porte. Aucune restriction n'est imposée à $`I` dans la grammaire : une somme sur un ensemble
infini d'étiquettes est un type licite, et il le faut, un gestionnaire pouvant recevoir des messages
d'un type non borné. La restriction apparaît là où elle est nécessaire, dans
$`\mathsf{Trellis}_{\text{fin}}`, dont la clause exige explicitement que $`I` soit fini — sans quoi
l'itération de l'opérateur de point fixe cesserait de terminer. _La contrainte est ainsi portée par
le jugement qui en a besoin, et non par la grammaire qui n'en a que faire_, ce qui est la règle que
ce document s'applique partout ailleurs.

La flèche $`V_r \multimap_\varepsilon C` porte _une_ annotation, et il vaut la peine de dire
pourquoi une seule suffit, car ce n'est pas le cas général. Un calcul par poussée de valeur pur ne
demande aucune annotation sur la flèche. Une extension qui doit traiter l'évaluation paresseuse en
demande _deux_ — celle de l'argument et celle de la fonction —, l'argument y étant un calcul
suspendu dont l'effet reste à consigner {cite "mcdermottExtendedCallbypushvalueReasoning2019"}[].
Ici l'argument est une _valeur_, donc sans effet propre : il n'y a rien à annoter de son côté, et
$`\varepsilon` ne dit que ce que le corps produira. C'est encore la séparation valeur/calcul qui
paie, et l'économie se lit sur la forme même de la flèche.

Trois autres règles portent l'essentiel et méritent un mot. {sc}[Box] et {sc}[Unbox] sont le lieu de
toute la discipline de ressource : entrer sous la modalité multiplie le contexte par le grade, en
sortir le restitue à la liaison. {sc}[App] est celle où la loi distributive se manifeste. L'argument
y voit son contexte multiplié par la demande que la fonction exprime : c'est $`\varphi` à l'œuvre
sur un cas concret. Et {sc}[Open] porte sa condition de bord, $`\alpha` n'apparaissant pas dans le
type de sortie : c'est elle qui rend le témoin inatteignable, et c'est sur elle que la preuve de
non-interférence s'appuiera.

La relation $`\preccurlyeq` de {sc}[SubBox] n'est pas l'ordre du grade mais le produit _mixte_
annoncé plus haut. Le décrire ne suffit pas à une transcription, qui demande la relation elle-même ;
on la pose donc composante par composante, chacune avec sa direction et l'opération de composition
qui l'accompagne.

::::k7table (label := "tab:produit-mixte") (align := "lZ{1.37}lZ{0.81}Z{0.81}")
:::caption
Le produit mixte du sous-typage, sa direction et son opération de composition par composante
:::

:::table +header
* * Composante
  * Direction de la coercion
  * Relation
  * Composition
  * Monotone pour
* * usage $`u`
  * descend, $`\omega` se coerce en $`1`
  * $`u \geq u'`
  * multiplication du semi-anneau
  * l'ordre naturel et son opposé
* * monotonie $`m`
  * descend, une preuve s'oublie
  * $`m \succeq m'`
  * minimum des deux marques
  * l'ordre descendant
* * niveau $`\ell`
  * monte, public vers secret
  * $`\ell \leq \ell'`
  * joint du treillis
  * l'ordre du treillis
* * budget $`\beta`
  * monte, exiger peu s'emploie là où l'on offre plus
  * $`\beta \leq \beta'`
  * soustraction $`\ominus`
  * l'ordre croissant
:::
::::

Autrement dit $`\preccurlyeq` est le produit
$`({\geq}) \times ({\succeq}) \times ({\leq}) \times ({\leq})` sur $`\mathcal{R}`, et non l'ordre de
précision $`\sqsubseteq` dont il diffère sur deux composantes. L'écrire autrement inverserait la
garantie de confidentialité, qui est la seule des quatre dont le sens dépende de la direction.

La dernière colonne n'est pas décorative : c'est elle qui porte la vérification du
§{num "sec:g-regles"}[]. Les lois de la comonade graduée ne mentionnent l'ordre que par une exigence
de monotonie de la composition, et chaque ligne la satisfait _dans sa propre direction_. La
condition à retenir n'est donc pas que l'ordre soit uniforme, mais que pour chaque composante
l'opération et la direction aient été choisies ensemble.

Cette table donne aussi, et c'est moins attendu, la condition d'une propriété que le système possède
sans l'avoir énoncée. {sc}[Sub] et {sc}[SubBox] sont deux règles _interstitielles_. Elles
s'appliquent en tout point d'une dérivation, de sorte que plusieurs dérivations typent le même
programme dès qu'elles existent. Rien n'a jusqu'ici établi qu'elles s'accordent, c'est-à-dire que
ces dérivations dénotent la même chose.

::::thm (label := "thm:coherence_subsomption") (status := "proposition")
:::title
cohérence de la subsomption
:::

:::statement +titled
Un programme valide a exactement une signification

Si deux dérivations typent le même terme, leurs interprétations coïncident.
:::

:::proofsketch
En trois temps : interpréter chaque sous-typage par une fonction de conversion ; éliminer
réflexivité et transitivité des dérivations ; pousser la subsomption à travers les règles
d'introduction jusqu'à l'unicité des dérivations.

_Ce que la suite établit, et ce qu'elle n'établit pas._ L'ordre du sous-typage possède ses
_jointures_ : un produit d'ordres les possède si et seulement si chaque facteur les possède, prises
composante par composante, et les quatre facteurs les ont — l'usage sous $`\geq` comme minima de
l'ordre naturel de $`\mathbb{N}_\infty`, la monotonie sous $`\succeq` comme chaîne à deux éléments,
le niveau par définition du treillis, le budget sous $`\leq` comme maxima.

Mais _l'existence de jointures n'est pas la cohérence des coercions_, et cette esquisse confondait
les deux. Un ordre peut avoir ses jointures sans que les fonctions de conversion associées
commutent : ce qu'il faut est que, pour tous $`r \sqsubseteq s \sqsubseteq t`, la conversion
composée de $`r` vers $`t` égale la conversion directe, et que la conversion de $`r` vers lui-même
soit l'identité. C'est une condition sur les _coercions_, non sur l'ordre, et elle reste à établir :
facteur par facteur d'abord, puis par fermeture sur le produit, le composé de quatre familles
cohérentes l'étant si les quatre le sont.

_Réduction établie._ Chaque facteur est un préordre, donc une catégorie mince : entre deux grades il
y a au plus une flèche, et deux dérivations de $`r \preccurlyeq r'` désignent la même. Si la
conversion est définie comme le transport le long de cette flèche, la cohérence énoncée se ramène à
la fonctorialité de ce transport — identité en $`r \preccurlyeq r`, composition en
$`r \preccurlyeq s \preccurlyeq t` — à vérifier pour chacune des quatre familles, puis à clore par
produit, la fonctorialité d'un produit de catégories l'étant composante par composante. Il reste à
écrire la définition de la conversion de chaque facteur ; tant qu'elle ne l'est pas, la proposition
demeure une proposition.
:::
::::

La forme de cette preuve est celle qu'emploie la cohérence de la subsomption pour un calcul
monadique {cite "schwinghammerCoherenceSubsumptionMonadic2009"}[]. La condition qu'elle demande est
acquise ici sans qu'aucune structure nouvelle soit requise, et ce texte employait déjà ces jointures
aux branchements sans savoir qu'elles conditionnaient un théorème.

Une réserve de portée doit être notée maintenant plutôt qu'au moment où l'on voudrait s'en passer. {rmq}[Les
universels bornés ou les jointures, pas les deux. La question se posera le jour où les
quantificateurs demanderont une borne.] La règle de Breazu-Tannen pour les universels bornés, qui
autorise le sous-typage contravariant des bornes, est incompatible avec l'existence des jointures.
K7PL a des universels et des sommes ; s'il veut un jour borner ses quantificateurs, il devra
renoncer à l'un des deux.

S'il tient, un programme accepté a exactement une signification, et le vérificateur peut choisir
n'importe quelle dérivation sans changer le sens du programme. S'il tombe, deux dérivations d'un
même terme pourraient dénoter deux choses, et l'énoncé de correction de la traduction perdrait son
objet.

{rmq}[Le chapitre 5 invoque une propriété du même nom. Ce n'est pas le même objet, et la
ressemblance des énoncés est ce qui rend la confusion facile.] Le chapitre 5
(§{num "sec:c5-mise-en-pratique"}[]) emploie le mot dans un autre sens : la cohérence y conditionne
la _résolution d'une recherche_ dirigée par le type, celle-ci porte sur des _dérivations de
subsomption_. Le schéma d'énoncé est le même — un programme valide a exactement une signification —
et il est employé deux fois dans ce document pour deux objets distincts. Que la preuve ci-dessus
s'étende à la recherche est une question ouverte, et elle n'est pas traitée ici.

# Les deux autres modalités temporelles
%%%
tag := "g-regles-les-deux-autres-modalites-temporelles"
%%%

Elles n'ont pas de forme héritée, et il faut donc les concevoir. Ce qui les détermine est moins leur
logique — qui est celle des modalités de nécessité et de possibilité sur un ordre linéaire — que
leur interaction avec la gradation, qui est propre à ce langage.

La modalité $`\Box` dit qu'une valeur est disponible _à tout instant_. Son introduction exige donc
que rien dans son contexte ne cesse de l'être, faute de quoi la valeur ne pourrait pas être
reproduite plus tard. C'est le patron de la promotion, et il n'est pas fortuit qu'il ressemble à
celui de la modalité d'usage. La modalité $`\Diamond` dit qu'une valeur _finira_ par être
disponible, sans dire quand. Elle s'introduit de deux façons — ce qui est là est éventuellement là,
et ce qui sera là après un délai est éventuellement là — et son élimination porte la contrainte qui
compte. On ne peut rien conclure d'un délai non borné qui ne soit lui-même non borné, de sorte que
le résultat reste sous $`\Diamond`.

::::formula (label := "eq:regles-temporelles") (kind := "formule")
```
\begin{equation*}
\textsc{Alw}\;\frac{\;{\Box}\Delta \vdash v : V\;}{\;{\Box}\Delta \vdash \mathsf{always}\;v : {\Box}V\;}
\qquad
\textsc{Alw}^{-}\;\frac{\;\Delta \vdash v : {\Box}V\;}{\;\Delta \vdash \mathsf{at}\;v : V\;}
\qquad
\textsc{Now}\;\frac{\;\Delta \vdash v : V\;}{\;\Delta \vdash \mathsf{now}\;v : {\Diamond}V\;}
\end{equation*}
```

```
\begin{gather*}
\textsc{Wait}\;\frac{\;\Delta \vdash v : {\bigcirc}{\Diamond}V\;}{\;\Delta \vdash \mathsf{wait}\;v : {\Diamond}V\;}
\\[8pt]
\textsc{When}\;\frac{\;\Delta_1 \vdash v : {\Diamond}V \qquad {\Box}\Delta_2,\, x :_r V \vdash c : {\Diamond}C \mid \varepsilon\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} ({\Box}\Delta_2) \vdash \mathsf{when}\;x = v\;\mathsf{in}\;c : {\Diamond}C \mid \varepsilon[\,\omega/k\,]\;}
\end{gather*}
```

:::caption
Règles des modalités « toujours » et « éventuellement », et la perte de borne qu'attendre coûte
:::
::::

La substitution $`\varepsilon[\omega/k]` dans {sc}[When] est le point où ces règles rencontrent
l'algèbre des effets, et elle demande d'abord d'être définie. Le facteur temporel étant une famille
indexée par les niveaux (§{num "sec:g-grammaire-types"}[]), la substitution ne remplace pas un
nombre par un autre : elle envoie la famille sur l'élément maximal,
$`\langle \varphi, \kappa\rangle[\omega] = \langle \varphi, \top\rangle` où $`\top(\ell) = \omega`
pour tout $`\ell`. La perte porte sur _tous_ les niveaux et non sur celui de l'attente seule, et
c'est correct : attendre un événement de date non bornée retarde ce qui suit à tout niveau, non pas
seulement au sien. C'est la sur-approximation sûre, et la seule.

Cela dit, elle se lit pour ce qu'elle dit. Attendre un événement dont la date n'est pas bornée porte
la composante temporelle de l'effet à $`\omega` : la borne de coût est _perdue_, et elle l'est
explicitement plutôt que silencieusement. C'est la contrepartie exacte de ce que $`\Diamond` achète
— l'inévitabilité sans l'échéance —, et le fait que $`\mathcal{R}` soit le type des conaturels donne
à cette perte une valeur plutôt qu'une exception. Un programme qui traverse un $`\Diamond` n'a plus
de WCET, ce qui est vrai et doit se voir dans son type.

Une SECONDE contrainte manque à cette règle, et la source qui la donne la porte explicitement. La
règle publiée contraint deux choses là où celle-ci n'en contraint qu'une. Sur la conclusion, le type
offert doit être de la forme « retardable d'un nombre fini d'étapes, puis communicable à un instant
arbitraire » — c'est ce que $`\Diamond C` exprime ici, et cette part est acquise. Mais elle
contraint aussi le CONTEXTE : tout canal du contexte doit être d'une forme qui admet elle-même un
report indéfini, ce que la modalité duale de $`\Diamond` exprime {cite "dasParallelComplexityAnalysis"}[].
Le motif est nommé par les auteurs et il est décisif : puisque le processus peut attendre une durée
indéfinie, la communication sur la conclusion _et sur tout canal du contexte_ doit pouvoir être
reportée d'autant. Un canal du contexte porteur d'une échéance fixe serait rompu par cette attente.

Cette contrainte manque ici, et son absence n'est pas neutre : elle rend la règle {sc}[When] _trop
permissive_. Elle admet un contexte dont une liaison porterait une borne temporelle stricte, alors
que l'attente peut la dépasser — de sorte que la conclusion promettrait une borne que le contexte ne
peut pas tenir. La correction est directe et se dit en une clause : exiger de chaque liaison du
contexte qu'elle soit sous la modalité duale, c'est-à-dire indéfiniment reportable. Elle est
désormais appliquée, et la duale porte un nom que le document avait déjà.

Cette contrainte est désormais posée, et il faut dire comment : _aucun connecteur n'a été ajouté_.
La duale que la règle réclame — une ressource disponible maintenant et encore après une attente de
durée non bornée — est exactement ce que $`{\Box}` dénote déjà, « disponible à tout instant ». Le
document a longtemps cherché un symbole pour un objet qu'il possédait.

La coïncidence n'est pas fortuite, et elle se lit sur la règle d'introduction de $`{\Box}`, qui
exige déjà un contexte $`{\Box}\Delta`. Cette exigence _est_ la condition de report : on ne peut
promettre une disponibilité permanente qu'à partir de ressources elles-mêmes permanentes. {rmq}[La
règle portait la contrainte depuis le début ; c'est la règle d'attente qui ne l'invoquait pas.
Chercher un connecteur neuf revenait à ignorer celui dont on disposait.] La règle {sc}[When] invoque
donc cette modalité plutôt que d'en introduire une nouvelle, et sa conclusion tient ce qu'elle
promet.

Deux conséquences, et la seconde est un coût qui disparaît.

La première est que la coercion $`{\Box}S \to S` existe déjà sous le nom $`\mathsf{at}` : ce qui est
disponible à tout moment l'est en particulier maintenant, et la réciproque est fausse — c'est ce qui
donne son contenu à la modalité.

La seconde est que _la grammaire des types ne gagne rien_. Une rédaction antérieure inscrivait ici
le coût d'un connecteur ajouté et le justifiait en le projetant sur la composante de contexte du
jugement germinal. Le coût n'existe pas : la condition de clôture n'est pas seulement tenue, elle
est tenue _sans dépense_, ce qui est le cas le plus favorable qu'elle puisse connaître.

Deux remarques closent ce point. La première est que $`\Box` et $`\bigcirc` suffisent aux couches 1
et 2, dont les calendriers sont bornés par construction. $`\Diamond` n'est requis que là où un
transducteur produit à un rythme que son entrée ne détermine pas, cas que le chapitre 4 signale. La
seconde est que $`\Box` ressemble à la modalité d'usage sans lui être identique : l'une porte sur le
temps, l'autre sur le nombre d'emplois, et leur parenté est celle que le chapitre 2 énonce entre
toutes les modalités graduées sur une structure ordonnée — même patron, structures distinctes.

# Les opérations à portée
%%%
tag := "g-scoped"
%%%

{label "sec:g-scoped"}

La règle {sc}[Op] vaut d'une opération algébrique ordinaire, qui reçoit une valeur et rend un
calcul. Celles qui reçoivent un _calcul_ — un gestionnaire, un bloc délimité — n'entrent pas dans ce
moule, et le chapitre 3 signale depuis longtemps qu'elles ne sont pas des effets algébriques
ordinaires. Leur forme est celle de la règle {sc}[Sc] ci-dessous.

::::formula (label := "eq:regle-portee") (kind := "formule")
```
\begin{equation*}
\textsc{Sc}\;\frac{\;\Delta_1 \vdash v : V_{\mathsf{operation}} \qquad \Delta_2 \vdash c : C \mid \varepsilon_c \qquad f = \varphi_n \circ \pi_S \in \mathcal{M}\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} (n\cdot\Delta_2) \vdash \mathsf{scoped}_{f}(v,\,c) : F_{\mathbf{1}} W \mid f(\varepsilon_c)\;}
\end{equation*}
```

:::caption
La forme d'une opération à portée : son effet est une fonction de l'effet de son argument
:::
::::

Ce qui distingue cette règle de {sc}[Op] tient entièrement à $`f`. L'effet d'une opération à portée
n'est pas une constante mais une _fonction de l'effet de son argument_ : un gestionnaire qui
intercepte une exception retire cet effet, un gestionnaire qui rejoue son bloc le double, un
gestionnaire qui l'ignore l'annule. Le grade d'effet devient donc fonctionnel, et c'est la même
généralisation que celle qu'exigent les effets dépendants — à ceci près que l'indice y parcourt les
valeurs quand il parcourt ici les effets eux-mêmes. On pourrait croire que la gradation indexée du
chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) suffit à porter cette forme. Le
§{num "sec:g-regles"}[] montre qu'il n'en est rien, l'une indexant sur les valeurs et l'autre sur
les effets, et qu'une structure propre est requise — un monoïde de transformateurs agissant sur
l'algèbre des effets.

Une distinction s'impose ici, et la mise en parallèle est ce qui la rend nécessaire. L'algèbre des
effets porte deux fragments qu'il faut nommer : $`\mathcal{E}_{\text{alg}}`, celui des opérations
algébriques ordinaires, qui se composent par le séquencement _et_ par la mise en parallèle ; et
$`\mathcal{E}_{\text{scoped}}`, celui des opérations à portée, dont l'effet est une _fonction_ de
l'effet de son argument et que le monoïde de transformateurs gouverne.

Ce que la seconde composition révèle est que ces deux fragments ne se comportent pas pareillement
sous elle. Deux effets algébriques se mettent en parallèle sans rien demander. Deux opérations à
portée ne le peuvent qu'une fois leurs transformateurs appliqués, les fonctions ne se composant pas
en parallèle comme des valeurs. _La clôture est donc faible sur ce fragment, et il faut l'écrire
ainsi_ : les opérations à portée se projettent bien sur la composante d'effet du jugement, mais
elles y entrent par une structure que les opérations ordinaires n'ont pas. {rmq}[Ranger l'exception
plutôt que de la nier. Une clôture qu'on déclarerait forte là où elle est faible serait une clôture
qu'on ne pourrait plus invoquer ailleurs.] Les unifier sous une même machinerie serait une
uniformisation abusive ; les tenir pour deux mécanismes étrangers serait oublier qu'ils partagent
leur place dans le jugement. Ils partagent la place et diffèrent par la structure, et c'est ce que
la nomenclature doit dire.

Le contexte du bloc y est multiplié par $`n`, et cette multiplication est ce qui fait sortir le bloc
du fragment de sa couche : un bloc rejoué deux fois porte des grades que le fragment affine n'admet
pas. Ce n'est pas une entorse mais un déplacement, et le paragraphe sur la sédimentation le justifie
— ce qui borne une réexécution est le budget et non la discipline de ressource, le premier tarifant
ce que la seconde interdirait sans le mesurer.

## Le monoïde des transformateurs
%%%
tag := "g-scoped-le-monoide-des-transformateurs"
%%%

La règle quantifie sur $`\mathcal{M}`, qu'il faut donc poser. Avant de le faire, il faut situer cet
objet _par rapport à ce que la littérature appelle une opération à portée_, faute de quoi on
croirait construire la même chose.

La littérature définit une opération à portée sur une monade $`T`, d'arité $`k`, comme une famille
$`\sigma_A : (TA)^k \to TA` naturelle en $`A` {cite "matacheScopedEffectsScoped2025"}[]. Elle agit
donc sur des _calculs_, et les travaux récents en donnent une théorie complète en traitant les
portées comme des _ressources_ ouvertes et fermées par des opérations dédiées, dans le cadre des
théories algébriques paramétrées. Ce n'est pas ce que $`\mathcal{M}` est. Un système de types
n'annote pas des calculs, il annote leurs effets~; $`\mathcal{M}` est donc l'_ombre au niveau des
annotations_ de ce que la littérature définit au niveau des calculs — ce qu'une opération à portée
fait subir à l'annotation, non ce qu'elle fait au calcul.

Cette différence de niveau porte une condition, écrite ici plutôt que laissée implicite. La règle {sc}[Sc]
donne à $`\mathsf{scoped}_f(v,c)` l'effet $`f(\varepsilon_c)`, c'est-à-dire une fonction de la seule
annotation de son argument. Pour que cela soit correct, il faut que l'action de $`\sigma` sur les
annotations _se factorise par l'annotation_ : deux calculs de même effet doivent donner, sous la
même opération à portée, des effets égaux. Rien ne le garantit a priori, et ce document ne l'établit
pas. C'est une réserve de portée réelle, inscrite à la nouvelle entrée de travaux qui la porte.

Ceci posé, deux familles suffisent à engendrer $`\mathcal{M}`, et chacune correspond à une forme de
gestionnaire réalisable.

La première est l'_itération_. Pour $`n \in \mathbb{N}_\infty`, $`\varphi_n` envoie
$`\langle \varepsilon_0, k\rangle` sur $`\langle \varepsilon_0^{\,n},\, n\,k\rangle`. Elle n'est pas
une famille nouvelle : c'est l'action que la loi distributive du chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) exerce déjà sur l'effet, lue comme une application de
$`\mathcal{E}` dans lui-même. Et elle est un morphisme de monoïdes, ce qui est le premier fait à
retenir : $`\varphi_n \circ \varphi_m = \varphi_{nm}`, puisque
$`(\varepsilon^m)^n = \varepsilon^{nm}` et $`n(mk) = (nm)k` ; $`\varphi_1` est l'identité, et
$`\varphi_0` envoie tout sur l'unité.

La seconde est la _rétraction_. Pour un ensemble $`S` d'opérations, $`\pi_S` efface de
$`\varepsilon_0` les occurrences des opérations de $`S` et laisse les autres dans leur ordre, sans
toucher au facteur temporel. Elle est idempotente et $`\pi_S \circ \pi_T = \pi_{S \cup T}`. Que le
facteur temporel soit laissé intact demande un mot : intercepter une opération ne réduit pas la
borne de coût, qui reste une sur-approximation. C'est un choix de _sûreté contre finesse_, et il va
dans le sens où l'on veut se tromper.

::::formula (label := "eq:monoide") (kind := "formule")
```
\begin{align*}
\mathcal{M} &\;=\; \langle\, \varphi_n,\ \pi_S \;\mid\; n \in \mathbb{N}_\infty,\ S \subseteq \mathrm{Ops} \,\rangle \;\subseteq\; \mathrm{End}_{\text{mon}}(\mathcal{E})\\
\varphi_n \circ \varphi_m &\;=\; \varphi_{nm} \qquad\qquad \pi_S \circ \pi_T \;=\; \pi_{S \cup T} \qquad\qquad \varphi_n \circ \pi_S \;=\; \pi_S \circ \varphi_n
\end{align*}
```

:::caption
Le monoïde des transformateurs d'effets, ses deux familles de générateurs et ses trois lois
:::
::::

Les trois exigences que la vérification du §{num "sec:g-regles"}[] avait posées sont satisfaites, et
se vérifient une à une plutôt qu'elles ne s'affirment. L'identité est $`\varphi_1`, qui est un
générateur, et c'est le gestionnaire transparent. La composition est celle des gestionnaires
imbriqués, et la clôture tient par construction d'un sous-monoïde engendré. L'action préserve
l'ordre parce que chaque générateur le préserve — l'itération dans une quantale et la multiplication
dans $`\mathbb{N}_\infty` sont monotones, l'effacement l'est aussi — et parce qu'une composée
d'applications monotones l'est.

### La troisième loi, et la condition sous laquelle elle tient
%%%
tag := "g-scoped-le-monoide-des-transformateurs-la-troisieme-loi-et"
%%%

La commutation des deux familles n'est pas gratuite, et c'est elle qui décide de tout le reste. Le
calcul est court. D'un côté
$`\varphi_n(\pi_S\langle \varepsilon_0, k\rangle) = \langle (\pi_S \varepsilon_0)^n,\, n\,k\rangle`
; de l'autre
$`\pi_S(\varphi_n\langle \varepsilon_0, k\rangle) = \langle \pi_S(\varepsilon_0^{\,n}),\, n\,k\rangle`.
Les facteurs temporels coïncident, et les deux applications sont donc égales si et seulement si

::::formula (label := "eq:commutation") (kind := "equation")
```
\begin{equation}
\pi_S(\varepsilon_0^{\,n}) \;=\; (\pi_S\,\varepsilon_0)^{\,n}
\end{equation}
```
::::

c'est-à-dire si et seulement si $`\pi_S` est un morphisme de la quantale. Or l'effacement l'est dès
lors qu'aucune relation de la présentation de $`\mathcal{E}_0` ne lie une opération effacée à une
opération conservée : sur une présentation libre, $`\pi_S` est l'unique morphisme prolongeant
$`\mathrm{op} \mapsto \mathbf{1}` pour $`\mathrm{op} \in S`, et il satisfait
$`\pi_S(\alpha\beta) = \pi_S(\alpha)\,\pi_S(\beta)` par définition. Le cas $`n = \omega` demande en
outre que $`\pi_S` préserve les bornes supérieures, ce qu'un morphisme de quantale fait.

_Ce document tient donc la commutation pour acquise sur une présentation sans relation croisée, et
la signale comme une condition et non comme un fait général._ Une extension de $`\mathcal{E}_0` qui
introduirait une équation reliant une opération interceptable à une opération conservée romprait la
commutation, donc les formes normales, donc la décidabilité de l'appartenance à $`\mathcal{M}`.
C'est le point où ce monoïde est fragile.

### La commutation, démontrée
%%%
tag := "g-scoped-le-monoide-des-transformateurs-la-commutation-demon"
%%%

L'énoncé se pose pour ce qu'il est, trois choses en dépendant : les formes normales, donc la
décidabilité de l'appartenance, donc la vérifiabilité de la règle.

::::thm (label := "thm:commutation_monoide")
:::title
commutation des deux familles
:::

:::statement +titled
Sous une condition sur la présentation

Soit $`\mathcal{E}_0` présentée par un ensemble d'opérations $`\mathrm{Ops}` et un ensemble de
relations $`\mathrm{Rel}`, et soit $`S \subseteq \mathrm{Ops}`. Si aucune relation de
$`\mathrm{Rel}` ne fait intervenir à la fois une opération de $`S` et une opération de
$`\mathrm{Ops} \setminus S`, alors (i) $`\pi_S` est un morphisme de monoïdes ordonnés, et pour tout
$`n` _fini_, $$`\pi_S \circ \varphi_n \;=\; \varphi_n \circ \pi_S ;` (ii) si de plus $`\mathcal{E}_0` est
une quantale et que le quotient préserve les suprema — exigence sur $`\mathcal{E}_0`, nommée comme
telle —, l'égalité vaut pour $`n = \omega`.
:::

:::proofsketch
En deux temps, dont le premier ne suppose aucune complétude.

_$`\pi_S` est bien définie._ Sur le monoïde libre $`\mathrm{Ops}^{*}`, l'application
$`\mathrm{op} \mapsto \mathbf{1}` pour $`\mathrm{op} \in S` et $`\mathrm{op} \mapsto \mathrm{op}`
sinon se prolonge d'une seule manière en un morphisme de monoïdes, lequel satisfait
$`\pi_S(\alpha\beta) = \pi_S(\alpha)\,\pi_S(\beta)` par construction. Ce morphisme descend au
quotient par $`\mathrm{Rel}` si et seulement si il respecte chaque relation. Une relation dont
toutes les lettres sont dans $`S` devient $`\mathbf{1} = \mathbf{1}` ; une relation dont aucune
lettre n'y est se transporte inchangée ; une relation mixte est exclue par hypothèse. Il n'en reste
aucune à vérifier. La monotonie vient de ce que $`\mathcal{E}_0` est un monoïde ordonné par treillis,
dont le produit distribue sur les bornes supérieures _finies_.

_La commutation à $`n` fini._ $`\pi_S(\varepsilon^n) = (\pi_S\varepsilon)^n` par récurrence
immédiate depuis la multiplicativité, sans complétude. Sur le facteur temporel, $`\pi_S` agit comme
l'identité et $`\varphi_n` par $`k \mapsto n\,k` : deux applications dont l'une est l'identité
commutent. Les deux composantes commutant, le couple commute.

_Le cas $`n = \omega`._ Il emploie $`\varepsilon^\omega = \bigvee_m \varepsilon^m` et exige que
$`\pi_S` préserve les suprema. Cette préservation n'est pas gratuite : étendre $`\pi_S` par
$`\pi_S(\bigvee_i \alpha_i) = \bigvee_i \pi_S(\alpha_i)` présuppose ce qu'il s'agit d'établir. Elle
est donc posée comme hypothèse (ii) sur $`\mathcal{E}_0`, et non démontrée. Pour un ensemble fini
d'étiquettes — le seul cas qu'un motif de boîte puisse écrire, que la règle {sc}[Guard] emploie —
le besoin se réduit aux bornes supérieures finies, que le monoïde ordonné par treillis fournit : cette
condition s'écrit sur la règle, elle n'est pas supposée.
:::
::::

La réserve est dans l'hypothèse et non dans la preuve, ce qui est la bonne place. Une extension de
$`\mathcal{E}_0` qui poserait une équation reliant une opération interceptable à une opération
conservée romprait la commutation, donc les formes normales, donc la décidabilité. _La condition
doit voyager avec l'algèbre des effets, non rester dans cette page._

### Deux projections, et non une
%%%
tag := "g-scoped-le-monoide-des-transformateurs-deux-projections-et"
%%%

La rétraction $`\pi_S` laisse le facteur temporel intact. C'est le bon choix pour ce à quoi le
monoïde sert — une borne de coût doit sur-approximer, et garder le temps d'une opération interceptée
fait errer du côté sûr. Mais la même forme sert ailleurs à un tout autre usage, et là ce choix est
faux.

Projeter une trace au niveau $`\ell`, c'est en retirer ce qu'un observateur de ce niveau ne voit
pas, et c'est l'opération dont la stratification du journal et la non-interférence ont besoin.
Effacer les _opérations_ de niveau supérieur sans effacer leur _durée_ laisserait un observateur bas
compter les pas qu'elles ont coûtés. La projection observationnelle doit donc retirer aussi le
temps, quand la projection conservatrice doit le garder. Les deux sont des instances du schéma de
restriction (chapitre~2, §{num "sec:c2-six-schemas-de-metatheorie"}[], théorème {num "thm:schema_restriction"}[]),
et c'est lui qui dit pourquoi les confondre serait fatal : un schéma commun n'autorise pas à
identifier deux critères, et c'est le critère qui fait toute la différence entre fermer le canal
temporel et l'ouvrir.

::::k7table (label := "tab:deux-projections") (align := "Z{0.91}Z{0.80}Z{0.84}Z{1.45}")
:::caption
Les deux projections, de même forme sur les effets et de traitement opposé sur le temps
:::

:::table +header
* * Projection
  * sur $`\mathcal{E}_0`
  * sur le temps
  * Emploi
* * $`\pi^{\dagger}_S` — conservatrice
  * efface $`S`
  * garde $`k`
  * typage des gestionnaires, $`\mathcal{M}`
* * $`\pi^{\flat}_{\ell}` — observationnelle
  * efface au-dessus de $`\ell`
  * retire le temps effacé
  * observation, journal, relation logique
:::
::::

Les deux coïncident exactement lorsqu'aucune opération effacée ne consomme de temps, et
$`\pi^{\dagger}` majore $`\pi^{\flat}` partout ailleurs. Employer la première là où la seconde est
requise ouvrirait le canal temporel dans la démonstration même qui prétend le fermer.

### La seconde projection, définie
%%%
tag := "g-scoped-le-monoide-des-transformateurs-la-seconde-projectio"
%%%

Le facteur temporel étant une famille indexée par les niveaux (§{num "sec:g-grammaire-types"}[]),
$`\pi^{\flat}_{\ell}` se définit sans rien ajouter : elle efface de $`\varphi` les opérations
étiquetées au-dessus de $`\ell`, et annule les composantes de $`\kappa` d'indice supérieur à
$`\ell`. Ce que voit l'observateur de niveau $`\ell` est donc, des deux côtés, ce qui lui est
accessible — et rien de ce qui a été effacé ne subsiste par sa durée.

La commutation démontrée plus haut vaut pour les deux projections, et pour la même raison. Sur
$`\mathcal{E}_0` l'argument est celui du théorème ; sur le facteur temporel, $`\pi^{\dagger}` agit
comme l'identité et $`\pi^{\flat}` comme une restriction, or l'une et l'autre commutent avec la
multiplication scalaire de $`\varphi_n`, qui opère point par point. Les formes normales survivent
donc au passage à la seconde projection, et avec elles la décidabilité.

Une remarque sur l'exclusion de $`\varphi_\ell` du monoïde. Sous cette forme, l'étiquetage joint le
niveau du calcul à celui de l'effet et ne peut donc que le _relever_ ; il ne saurait déclassifier
par lui-même. L'exclusion décidée plus haut n'en est pas moins la bonne : l'admettre obligerait à
démontrer, pour chaque transformateur, qu'il ne relève jamais que vers le haut, quand l'exclure rend
la question sans objet. C'est un choix conservateur, et il est écrit comme tel plutôt que présenté
comme une nécessité.

### Formes normales, et ce qu'elles achètent
%%%
tag := "g-scoped-le-monoide-des-transformateurs-formes-normales-et-c"
%%%

Les trois lois suffisent à normaliser. Tout mot en les générateurs se réduit à
$`\varphi_n \circ \pi_S`, où $`n` est le produit des exposants rencontrés et $`S` la réunion des
ensembles effacés ; et $`\varphi_0` absorbe toute rétraction, puisque
$`\varphi_0 \circ \pi_S = \varphi_0`. Un élément de $`\mathcal{M}` est donc soit $`\varphi_0`, soit
un couple $`(n, S)` avec $`n \geq 1`, et l'égalité de deux transformateurs se décide sur ce couple.

C'est ce qui rend la règle {sc}[Sc] vérifiable. Un gestionnaire déclare son $`f` ; le système
vérifie qu'il appartient à $`\mathcal{M}`, ce qui revient à le mettre en forme normale ; et cette
vérification est décidable. Sans les formes normales, l'appartenance à un sous-monoïde de
$`\mathrm{End}(\mathcal{E})` ne le serait pas, et la règle serait ininspectable.

### Ce que le monoïde ne contient pas, et pourquoi
%%%
tag := "g-scoped-le-monoide-des-transformateurs-ce-que-le-monoide-ne"
%%%

Une troisième famille aurait pu y figurer et n'y figure pas. La loi distributive fait aussi agir le
_niveau_ sur l'effet, en l'étiquetant : un calcul de niveau $`\ell` produit un effet observable au
niveau $`\ell`. L'application $`\varphi_\ell` correspondante est un endomorphisme monotone de
$`\mathcal{E}`, et rien dans la construction n'interdirait de l'admettre.

Elle est exclue, et c'est une décision de sûreté plutôt que d'économie. Un gestionnaire qui pourrait
ré-étiqueter le niveau d'un effet déclassifierait — par une porte que la déclassification délimitée
du chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]) ne contrôle pas, puisqu'elle ne
contrôle que l'échappatoire nommée. Admettre $`\varphi_\ell` dans $`\mathcal{M}` rouvrirait donc
l'attaque de blanchiment que la déclassification ferme, et le ferait à l'endroit exact où la preuve
de non-interférence est le plus fragile, celui du canal temporel. _Le monoïde n'itère et n'efface ;
il n'étiquette pas._

## Ce que les couches en font
%%%
tag := "g-scoped-ce-que-les-couches-en-font"
%%%

Le monoïde est un, et les couches n'en reçoivent pas des versions différentes : elles en admettent
des parties différentes, et ces parties sont des conséquences de leur spécialisation plutôt que des
définitions à poser. Trois énoncés suffisent à le dire.

Le premier est immédiat et il ferme une question plutôt qu'il n'en ouvre une. La couche 3 pose
$`\mathcal{E} = \emptyset` ; or il n'existe qu'une application de l'ensemble vide dans lui-même,
l'identité. _La couche 3 n'admet aucune opération à portée, et ce n'est pas une restriction qu'on
lui impose mais une conséquence de n'avoir pas d'effets._ Rien n'est à écrire pour elle.

Le deuxième porte sur les deux autres couches, et il déplace la question là où elle appartient. Un
transformateur $`\varphi_n \circ \pi_S` est admissible sur un calcul de composante temporelle $`k`,
dans un contexte de budget $`\beta`, si et seulement si $`\beta \ominus n\,k` est défini —
c'est-à-dire si le budget couvre les $`n` exécutions. Ce n'est pas le fragment de la couche qui
borne la réexécution, c'est son budget. La couche 1 porte une échéance stricte et borne donc $`n`
plus serré que la couche 2, qui porte un budget sans échéance ; l'inclusion des transformateurs
admissibles suit cet ordre.

Le troisième est une mise en garde, et elle vaut d'être écrite parce que l'inverse se croit
volontiers. Les fragments de ressource s'emboîtent en allant de la couche 1 vers la couche 3. Les
transformateurs admissibles s'emboîtent dans un autre ordre, la couche 3 étant la plus pauvre. _Les
deux stratifications ne s'alignent pas_, et l'image d'une sédimentation où tout se déposerait dans
le même sens ne vaut que sur l'axe des ressources. Le chapitre 1 la donne d'ailleurs pour une
lecture et non pour un théorème ; ce paragraphe en fixe la borne.

## Ce que la construction ne lève pas
%%%
tag := "g-scoped-ce-que-la-construction-ne-leve-pas"
%%%

Une réserve accompagne cette règle, et le fait d'avoir construit $`\mathcal{M}` ne la lève pas.
Encoder une opération à portée de cette façon revient à en faire une _élaboration_, et une
élaboration écrite naïvement n'appartient à aucune interface d'effet : on ne peut alors en raffiner
l'implémentation sans recompiler. Il faut aussitôt ajouter ce que ce document affirmait à tort être
établi, car la littérature ne s'arrête pas à ce constat — elle le _résout_. Les algèbres de
surcharge syntaxique donnent des élaborations modulaires, composables une à une, des effets d'ordre
supérieur vers les effets algébriques primitifs {cite "bachpoulsenHeftyAlgebrasModular2023"}[]. La
perte de modularité n'est donc pas une impossibilité de principe. C'est le prix d'un encodage
particulier — et il faut dire lequel des deux est le choix, faute de quoi l'énoncé paraît se
contredire. _L'encodage est le choix ; la perte en est la conséquence nécessaire._ K7PL retient le
monoïde de transformateurs, et cette structure entraîne la perte, elle ne coexiste pas avec elle. La
raison s'en voit maintenant. Un gestionnaire est identifié à l'action qu'il exerce, c'est-à-dire à
sa forme normale $`(n, S)`, et non à une signature qu'il satisfairait. Deux implémentations qui
n'agissent pas identiquement sur l'effet ne sont pas interchangeables, quelle que soit leur
ressemblance par ailleurs. La règle donne donc un typage correct et non une modularité, et K7PL ne
revendique que le premier.

### Mesure ou borne, et la factorisation que l'écart décide
%%%
tag := "g-scoped-ce-que-la-construction-ne-leve-pas-mesure-ou-borne"
%%%

Une condition reste, que la construction de $`\mathcal{M}` suppose sans la nommer. Pour qu'un
transformateur agisse sur l'_annotation_ d'un calcul, il faut que son action _se factorise_ par
cette annotation : deux calculs de même effet doivent recevoir, sous la même opération à portée, le
même effet. Rien ne l'impose a priori, et la littérature donne trois opérations canoniques —
semi-déterminisme, état local, coupure — dont le comportement dépend du calcul et non seulement de
son effet.

La condition tient ou non selon ce qu'on lit dans une annotation, et c'est cette lecture qu'il faut
fixer.

* Lue comme une *mesure* — ce que le calcul coûte —, _la factorisation échoue_. L'opération
  $`\mathsf{once}`, qui retient la première branche d'un calcul non déterministe, en donne le
  contre-exemple : deux calculs de même effet total peuvent avoir des premières branches de coûts
  différents, et le résultat n'est alors pas fonction de l'annotation seule.

* Lue comme une *borne* — ce que le calcul ne dépassera pas —, _elle tient_. L'action de
  $`\varphi_n \circ \pi_S` sur la borne est correcte parce qu'elle sur-approxime : le coût réel de
  $`\mathsf{scoped}_f(v, c)` reste sous ce que le monoïde calcule, quel que soit le calcul que
  l'annotation recouvre.

_Or ce document lit déjà l'annotation comme une borne_, et le §{num "sec:g-semantique"}[] le dit
sans le nommer : la préservation fait décroître $`\tau\cdot\varepsilon`, ce qui n'a de sens que si
$`\varepsilon` majore ce qui reste à produire. La factorisation est donc acquise, sous la lecture
que le document pratique — il fallait seulement en tirer la conséquence.

La classe des opérations à portée que K7PL revendique se caractérise alors sans détour : _ce sont
celles dont l'action sur la borne appartient à $`\mathcal{M}`_. L'appartenance se décide par mise en
forme normale $`(n, S)`, et c'est ce qui rend la règle {sc}[Sc] inspectable. On ne caractérise donc
pas cette classe par une propriété sémantique difficile à vérifier, mais par une appartenance à un
monoïde à formes normales.

Le prix doit être écrit. Un gestionnaire qui _réduit_ le coût n'en reçoit aucun crédit : sa borne
reste celle du calcul non coupé. C'est imprécis, et c'est sûr. _C'est l'arbitrage déjà rendu pour
$`\pi^{\dagger}`_, la projection conservatrice qui garde le facteur temporel d'une opération effacée
— une borne de coût doit errer du côté sûr, et le document le décide ici pour la seconde fois, pour
la même raison.

# Les deux vérifications
%%%
tag := "g-regles-les-deux-verifications"
%%%

Deux points restaient à établir sur le jeu qui précède. Les conduire donne un résultat dans chaque
sens, et le second corrige ce que le §{num "sec:g-regles"}[] avançait.

## La première : le produit mixte et les lois de la modalité
%%%
tag := "g-regles-les-deux-verifications-la-premiere-le-produit-mixte"
%%%

Le sous-typage coerce dans deux directions opposées selon la composante — descendant sur l'usage et
sur la monotonie, montant sur le niveau et sur le budget. La question est de savoir si les lois de
la comonade graduée y survivent, c'est-à-dire si la counité et la comultiplication restent
naturelles lorsque l'ordre n'est pas uniforme.

Elles y survivent, et la raison est que les lois ne mentionnent l'ordre que par une exigence : que
l'opération de composition des grades soit _monotone_ pour l'ordre dont les coercions se servent. Il
suffit donc de vérifier cette monotonie composante par composante, chacune dans _sa_ direction. Sur
l'usage, la multiplication du semi-anneau est monotone pour l'ordre naturel comme pour son opposé —
si $`a \geq b` alors $`a\,c \geq b\,c`. Sur le niveau, l'opération de composition est le joint du
treillis, monotone pour l'ordre du treillis, qui est la direction montante retenue. Sur le budget,
la composition soustrait, et soustraire une même quantité préserve l'ordre. Sur la monotonie,
l'opération est le minimum des deux marques, monotone pour l'ordre descendant.

Chaque composante est donc monotone dans la direction que son sous-typage emploie, et le produit
l'est pour le produit des directions. La condition à retenir n'est pas que l'ordre soit uniforme,
mais que _pour chaque composante, l'opération et la direction aient été choisies ensemble_ — ce qui
est le cas, et n'est pas un accident. C'est la même exigence qui fait de chaque composante une
modalité graduée sur une structure ordonnée au sens du chapitre 2
(§{num "sec:c2-adjonctions-et-enrichissement"}[]).

## La seconde : la fonction des opérations à portée
%%%
tag := "g-regles-les-deux-verifications-la-seconde-la-fonction-des-o"
%%%

Le §{num "sec:g-regles"}[] avance que la fonction $`f` d'une opération à portée se ramène à la
gradation indexée, sous réserve de vérification. La vérification est négative.

Les deux constructions généralisent bien le même trait — un grade qui est une fonction plutôt qu'une
constante — mais elles n'indexent pas sur le même objet. La gradation indexée est un foncteur
contravariant de la catégorie de base vers celle des monades graduées : son indice parcourt les
_valeurs_, et c'est ce qui permet à l'effet d'un parcours de dépendre de la longueur parcourue. La
fonction $`f` d'une opération à portée transforme un grade d'effet en un autre : son indice, si l'on
veut employer ce mot, parcourt les _effets_. Un foncteur depuis la base ne fournit pas cela ; il
faudrait que la base contienne l'algèbre des effets, ce qui n'a pas de sens dans la construction
retenue.

Ce que la structure requiert est autre chose, et plus modeste : que les transformateurs admissibles
forment un _monoïde d'endomorphismes_ agissant sur l'algèbre des effets. L'identité y est le
gestionnaire transparent, la composition celle des gestionnaires imbriqués, et l'action doit
préserver l'ordre pour que le sous-typage des effets traverse une portée. C'est une structure
supplémentaire, non une instance de celle du chapitre 1.

Deux conséquences en découlent. La première est que les opérations à portée coûtent au langage une
pièce de plus qu'annoncé, et la §{num "sec:g-regles"}[] le dit désormais. La seconde est que ce coût
éclaire la réserve de modularité : un monoïde d'endomorphismes n'est pas une interface d'effet, et
c'est précisément pourquoi on ne peut raffiner l'implémentation d'un gestionnaire sans recompiler {cite "bachpoulsenHeftyAlgebrasModular2023"}[].
La réserve n'était pas une prudence, elle était la conséquence de la structure.

# Les connecteurs restants
%%%
tag := "g-regles-les-connecteurs-restants"
%%%

Six connecteurs manquaient au jeu — $`\mathsf{Vec}`, $`\mathsf{Arena}`, les points fixes $`\mu` et
$`\nu`, la conjonction additive, le quantificateur universel — et ce texte affirmait qu'ils
suivaient mécaniquement les patrons déjà écrits, leur absence étant une économie de place et non une
difficulté. Les écrire vérifie cette affirmation, et _elle ne tient pas tout à fait_. Trois d'entre
eux suivent en effet mécaniquement ; les trois autres ne suivent pas, et chacun pour une raison qui
vaut d'être connue.

## Les trois qui suivent
%%%
tag := "g-regles-les-connecteurs-restants-les-trois-qui-suivent"
%%%

Les points fixes se replient et se déplient sans que le grade intervienne, la récursion étant portée
par le type et non par la ressource. Le quantificateur universel est le dual de l'existentiel déjà
écrit, sa condition de bord portant sur la variable de type et non sur le contexte.

::::formula (label := "eq:connecteurs-mecaniques") (kind := "formule")
```
\begin{equation*}
\textsc{Fold}\;\frac{\;\Delta \vdash v : V[\mu\alpha.V/\alpha]\;}{\;\Delta \vdash \mathsf{fold}\;v : \mu\alpha.V\;}
\qquad
\textsc{Unfold}\;\frac{\;\Delta \vdash v : \mu\alpha.V\;}{\;\Delta \vdash \mathsf{unfold}\;v : V[\mu\alpha.V/\alpha]\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Gen}\;\frac{\;\Delta \vdash c : C \mid \varepsilon \qquad \alpha \notin \mathrm{fv}(\Delta)\;}{\;\Delta \vdash \Lambda\alpha.c : \forall\alpha.C \mid \varepsilon\;}
\qquad
\textsc{Inst}\;\frac{\;\Delta \vdash c : \forall\alpha.C \mid \varepsilon\;}{\;\Delta \vdash c\,[W] : C[W/\alpha] \mid \varepsilon\;}
\end{equation*}
```

:::caption
Les connecteurs qui suivent les patrons déjà posés
:::
::::

## Le point fixe coinductif
%%%
tag := "g-nu"
%%%

{label "sec:g-nu"}

Le connecteur $`\nu\alpha.C` figurait à la grammaire des types sans qu'aucune règle de terme ne
l'habite, et c'était le seul de dix-neuf dans ce cas. Ce qui suit l'habite, et la forme retenue
n'est pas celle que l'on attendrait.

La forme catégorique — un anamorphisme depuis une coalgèbre, dont l'unicité donne la productivité —
était disponible et le chapitre 2 la construit déjà. Elle n'est pourtant pas retenue au noyau, et
pour une raison interne au document plutôt que d'ergonomie. Le théorème {num "thm:progression_polarisee"}[]
énonce la progression pour un calcul « dont le type porte un indice de taille décroissant au sens de
$`p(\ell)` », et sa preuve dit que l'argument « ne dépend pas de la polarité : c'est le même des
deux côtés ». _Ce théorème présuppose donc déjà l'indice de taille du côté coinductif._ Prouver la
productivité par la terminalité donnerait à la couche 2 un argument différent de celui de la couche
3, et l'unification que le théorème revendique cesserait d'en être une. La forme dimensionnée
n'ajoute rien : elle écrit ce que l'énoncé central suppose.

Un type coinductif porte donc un indice de taille, noté $`\nu\alpha.C\,\langle i \rangle`, qui
compte les observations restant disponibles. L'indice est un grade, pris dans la _sorte coinductive_
$`\mathbb{S}_\nu = \mathbb{N}_\infty` que le chapitre 2
(§{num "sec:c2-algebres-coalgebres-et-points"}[]) distingue de la sorte inductive. $`\omega` y est
admis, et c'est lui qui type un flux non terminé : l'absorption $`\omega \ominus 1 = \omega` laisse
une observation toujours disponible, là où une taille finie $`n` en borne le nombre à $`n`. Aucun
type ne porte les deux sortes.

::::formula (label := "eq:regles-nu") (kind := "formule")
```
\begin{equation*}
\textsc{Out}\;\frac{\;\Delta \vdash c : \nu\alpha.C\,\langle i+1 \rangle \mid \varepsilon\;}{\;\Delta \vdash \mathsf{out}\;c : C[\nu\alpha.C\,\langle i \rangle/\alpha] \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Cop}\;\frac{\;\bigl(\Delta,\ x :_{1} \nu\alpha.C\,\langle i \rangle \;\vdash\; c_j : C_j\,\langle i \rangle \mid \varepsilon \bigr)_{j \in J}\;}{\;\Delta \vdash \langle\!\langle j \mapsto c_j \rangle\!\rangle_{j \in J} : \nu\alpha.C\,\langle i+1 \rangle \mid \varepsilon\;}
\end{equation*}
```

:::caption
Les deux règles du point fixe coinductif. L'observation consomme une unité de taille ; le copatron
en produit une.
:::
::::

Un point de lecture avant tout le reste, car la question se pose immédiatement. Comment {sc}[Out]
s'instancie-t-il sur un flux de taille $`\omega`, dont la prémisse demande $`\langle i+1 \rangle` ?
Par $`\omega + 1 = \omega`, qui est l'une des quatre égalités du chapitre 2 : la prémisse est
satisfaite avec $`i = \omega`, et la conclusion rend un type de taille $`\omega` encore. _Une
observation sur un flux infini laisse un flux infini_, et la règle n'a pas eu à être modifiée pour
le dire — c'est la sorte qui porte la différence. Sur une taille finie $`n`, la même règle épuise le
flux en $`n` observations, ce qui est le comportement voulu d'un flux borné.

Trois choses se lisent ensuite sur ces deux règles, et la troisième est celle qui compte.

La première est que l'appel corécursif est _disponible_ dans chaque branche, sous la liaison $`x`,
mais à une taille strictement inférieure. C'est la décroissance, et elle est un fait de typage :
aucune inspection de la syntaxe du terme n'a lieu, aucun gardien n'est posé, et la garantie tient du
jugement seul. Le critère est ainsi le dual exact de celui qui borne le pli de couche 3, comme le
théorème {num "thm:progression_polarisee"}[] l'affirmait sans encore le pouvoir.

La deuxième est que le contexte n'est pas mis à l'échelle. Chaque branche du copatron reçoit le même
$`\Delta`, pour la même raison que la conjonction additive : une seule observation est faite à la
fois, et les autres branches ne sont pas exécutées. Le copatron est un connecteur additif, et il en
suit le patron sans exception.

La troisième est que l'anamorphisme n'est pas perdu, il est _dérivé_. Étant donné une coalgèbre
$`v : U(V \multimap C[V/\alpha])`, le copatron
$`\langle\!\langle j \mapsto (\mathsf{out}\,(\mathsf{force}\;v))\,.j \rangle\!\rangle` définit un
terme de type $`U(V \multimap \forall i.\,\nu\alpha.C\,\langle i \rangle)`, quantifié sur toutes les
tailles. La forme catégorique reste donc disponible aux démonstrations, sans être une primitive que
la métathéorie devrait porter. C'est le régime que le chapitre 5 réserve aux glyphes, appliqué ici à
un schéma de récursion.

## Les trois qui ne suivent pas
%%%
tag := "g-regles-les-connecteurs-restants-les-trois-qui-ne-suivent-p"
%%%

La _conjonction additive_ est le premier écart, et le plus net. Tous les connecteurs écrits
jusqu'ici composent deux contextes en les additionnant ou en les faisant passer par $`\boxtimes` ;
la conjonction additive, elle, _partage_ le même contexte entre ses deux composantes, puisqu'une
seule sera consommée. Sa règle n'est donc pas une instance des patrons précédents mais leur
exception, et c'est ce qui distingue l'additif du multiplicatif. L'écrire comme un patron de plus
aurait fait perdre la distinction.

::::formula (label := "eq:connecteurs-propres") (kind := "formule")
```
\begin{equation*}
\textsc{With}\;\frac{\;\Delta \vdash c_i : C_i \mid \varepsilon \;\;(\forall i \in I)\;}{\;\Delta \vdash \langle c_i \rangle_{i \in I} : \textstyle\mathop{\&}_{i \in I} C_i \mid \varepsilon\;}
\qquad
\textsc{Proj}\;\frac{\;\Delta \vdash c : \textstyle\mathop{\&}_{j \in I} C_j \mid \varepsilon \qquad i \in I\;}{\;\Delta \vdash c.i : C_i \mid \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{VecI}\;\frac{\;\Delta \vdash v_i : V \;\;(i < n)\;}{\;n\cdot\Delta \vdash [v_0,\ldots,v_{n-1}] : \mathsf{Vec}\;n\;V\;}
\qquad
\textsc{VecE}\;\frac{\;\Delta_1 \vdash v : \mathsf{Vec}\;n\;V \quad \Delta_2,\, x :_{r} V \vdash c : C \mid \varepsilon(i)\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} (n\cdot\Delta_2) \vdash \mathsf{iter}_{V}\;v\;c : C \mid \textstyle\prod_{i<n}\varepsilon(i)\;}
\end{equation*}
```

:::caption
La conjonction additive partage son contexte au lieu de l'additionner, et l'arène le multiplie par
sa longueur
:::
::::

Le _vecteur_ est le deuxième écart, et il est plus intéressant que le premier. Construire un vecteur
de longueur $`n` à partir d'un même contexte le multiplie par $`n`, et le parcourir compose $`n`
effets qui _ne sont pas les mêmes_. C'est ici, et non dans un exemple, que la gradation indexée du
chapitre 1 devient nécessaire, l'effet du parcours étant une famille indexée par la position et non
une constante. Le vecteur n'est donc pas un connecteur de plus : c'est le premier site où
l'indexation mord, et son élimination emploie exactement le facteur $`n\cdot\Delta` que la
ré-invocation séquentielle de la traduction retrouvera.

L'_arène_ est le troisième, et son écart n'est pas de forme mais de portée. Une arène est une
région, et ce qui la gouverne — l'allocation en $`O(1)`, la libération à la sortie de portée, la
disjonction des régions que le produit tensoriel dénote — appartient au modèle mémoire du chapitre 4
et non au seul jeu de règles. Sa règle d'introduction se lit comme celle d'une modalité graduée dont
l'indice est une taille. Son élimination demande la conformité de l'abaissement, laquelle est une
propriété du compilateur et non du système de types. _Ce document ne la donne donc pas ici_, et le
dit : la transcription en assistant de preuve devra la poser depuis le chapitre 4, ou l'admettre
comme paramètre.

## Le parallélisme de couche 3
%%%
tag := "g-parallelisme"
%%%

{label "sec:g-parallelisme"}

Le facteur temporel d'un effet n'est pas un nombre mais un _couple_, et c'est ce que le parallélisme
demande. $`\kappa = \langle w, s \rangle` porte le _travail_ — le nombre total de pas, quelle que
soit la façon dont ils se répartissent — et la _profondeur_, la longueur du plus long chemin de
dépendances. Deux compositions les gouvernent, et leur différence est tout le contenu du
parallélisme.

::::formula (label := "eq:cout-parallele") (kind := "formule")
```
\begin{align*}
\langle w_1, s_1 \rangle \cdot \langle w_2, s_2 \rangle &= \langle w_1 + w_2,\ s_1 + s_2 \rangle\\
\langle w_1, s_1 \rangle \parallel \langle w_2, s_2 \rangle &= \langle w_1 + w_2,\ \max(s_1, s_2) \rangle
\end{align*}
```

:::caption
Séquencement et mise en parallèle du coût, par niveau
:::
::::

$`(\mathcal{E}_0, \cdot, 1)` reste un monoïde non commutatif — l'ordre des effets compte.
$`(\mathcal{E}_0, \parallel, 1)` en est un _commutatif_ — l'ordre de deux branches parallèles ne
compte pas, et c'est précisément ce qu'on veut dire en les mettant en parallèle. Les deux sont liés
par la loi d'échange
$`(a \cdot b) \parallel (c \cdot d) \sqsubseteq (a \parallel c) \cdot (b \parallel d)`, qui dit
qu'entrelacer ne coûte jamais plus que séquencer par tranches.

Un constructeur de calcul et un combinateur suffisent à l'exprimer.

::::formula (label := "eq:regles-parallele") (kind := "formule")
```
\begin{equation*}
\textsc{Par}\;\frac{\;\Delta_1 \vdash c_1 : F_{\varepsilon_1} V_1 \mid \varepsilon_1 \qquad \Delta_2 \vdash c_2 : F_{\varepsilon_2} V_2 \mid \varepsilon_2\;}{\;\Delta_1 + \Delta_2 \vdash c_1 \parallel c_2 : F_{\varepsilon_1 \parallel \varepsilon_2} (V_1 \otimes V_2) \mid \varepsilon_1 \parallel \varepsilon_2\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Vmap}\;\frac{\;\Delta_1 \vdash v : U_\varepsilon (V \multimap F_\varepsilon W) \qquad \Delta_2 \vdash w : \mathsf{Vec}\;n\;V\;}{\;\Delta_1 + (n \cdot \Delta_2) \vdash \mathsf{vmap}\;v\;w : F\,(\mathsf{Vec}\;n\;W) \mid \langle n \cdot w(\varepsilon),\ s(\varepsilon) \rangle\;}
\end{equation*}
```

:::caption
La mise en parallèle et l'application vectorisée. La profondeur de {sc}[Vmap] ne dépend pas de $`n`.
:::
::::

Trois remarques, et la troisième est le résultat.

La première est que {sc}[Par] compose ses contextes par l'_addition_, exactement comme la règle de
la paire. Rien n'est inventé : la règle existait pour les valeurs, elle est étendue aux calculs.

La deuxième est que {sc}[Par] _n'est pas_ la conjonction additive, et les confondre serait l'erreur.
La conjonction additive partage son contexte parce qu'une seule branche s'exécutera ; {sc}[Par]
l'additionne parce que les deux s'exécutent. {rmq}[Le partage dit « l'une ou l'autre » ; l'addition
dit « l'une et l'autre ». C'est la même différence qu'entre le choix et la coexistence.] C'est la
différence entre le choix et la coexistence de ressources, et elle se lit sur la composition des
contextes.

La troisième est que _la profondeur de $`\mathsf{vmap}` ne dépend pas de $`n`_. C'est la
vectorisation, écrite dans le type plutôt que promise par le compilateur : appliquer une fonction à
un vecteur de longueur $`n` coûte $`n` fois son travail et une seule fois sa profondeur. Un
programme qui l'écrit dit qu'il est vectorisable, et le vérificateur le tient.

::::thm (label := "thm:determinisme_parallele")
:::title
déterminisme du parallélisme de couche 3
:::

:::statement +titled
Mettre en parallèle ne change pas ce qui est calculé

Pour $`c_1` et $`c_2` de couche 3, les calculs $`c_1 \parallel c_2` et
$`\mathsf{let}\;x \leftarrow c_1\;\mathsf{in}\;\mathsf{let}\;y \leftarrow c_2\;\mathsf{in}\;\mathsf{return}\,(x,y)`
rendent la même valeur. Leurs effets diffèrent sur la seule composante de profondeur, où le premier
majore le second.
:::

:::proofsketch
La couche 3 est le fragment cartésien, et son seul effet est le coût : deux branches parallèles
n'ont donc aucune opération par laquelle interférer, et il n'y a rien à ordonner. Formellement,
l'égalité des valeurs suit de ce que $`\varepsilon_1` et $`\varepsilon_2` y ont une composante
d'effet neutre, de sorte que l'entrelacement ne distingue aucun état. La différence de profondeur
est celle des deux compositions : $`\max(s_1, s_2) \le s_1 + s_2`.
:::
::::

Ce que cet énoncé achète mérite d'être dit, car il est facile et n'en est pas moins un résultat. _Le
parallélisme de couche 3 n'a pas besoin d'être vérifié_ : il est sûr par la structure du fragment,
et non par une analyse d'indépendance que le compilateur conduirait. Là où un langage ordinaire doit
prouver que deux tâches ne se marchent pas dessus, celui-ci n'a pas d'endroit où elles le
pourraient.

## La couche 2 — concurrence asynchrone à boîtes aux lettres
%%%
tag := "g-couche2"
%%%

{label "sec:g-couche2"}

Le chapitre 4 décrit des acteurs, des boîtes aux lettres et des motifs de jonction ; le noyau formel
n'en portait rien, et la couche 2 n'y avait ni constructeur ni type habitable. Ce qui suit l'écrit,
et l'_asynchronie est primitive_ : l'émission ne bloque pas, la réception bloque, et le rendez-vous
synchrone se dérive d'une émission suivie d'une attente. L'inverse obligerait à introduire les
tampons de toute façon, et laisserait la boîte aux lettres hors du noyau — ce qui était la
situation.

Deux constructeurs de valeur entrent, et ils portent leur discipline dans leur _grade_ plutôt que
dans une seconde zone de contexte. Une liaison $`x :_1 \mathsf{Chan}\;S` est linéaire parce que son
grade vaut un, et non parce qu'elle vivrait dans une zone linéaire ; un canal annulable porte un
grade affine, un canal de diffusion un grade non contraint. {rmq}[Ce que le chapitre 1 revendiquait
— une seule zone de contexte — n'est tenu que si la discipline des canaux y entre par le grade.
C'est ici que la revendication se paie ou se perd.]

::::formula (label := "eq:motifs-boite") (kind := "formule")
```
\begin{align*}
\text{(valeurs)}\quad V &::= \dots \mid \mathsf{Chan}\;S \mid \mathsf{Mb}\;E\\
\text{(motifs)}\quad E &::= 0 \mid 1 \mid m[\overline{V}] \mid E \cdot E \mid E + E \mid E^{*}
\end{align*}
```

:::caption
Les canaux de session et les boîtes aux lettres, avec l'algèbre des motifs
:::
::::

L'opération centrale n'est aucune de ces cinq : c'est le _résiduel_ $`E / m`, qui donne le motif
restant après consommation d'un message $`m`. C'est lui qui fait d'une boîte un objet à état typé
plutôt qu'un sac : consommer transforme le type, et le type dit ce qu'il reste à recevoir.

::::formula (label := "eq:regles-couche2") (kind := "formule")
```
\begin{equation*}
\textsc{Spawn}\;\frac{\;\Delta \vdash c : F_{\mathbf{1}} \mathbf{1} \mid \varepsilon\;}{\;\Delta \vdash \mathsf{spawn}\;c : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathsf{spawn},\ \langle w(\varepsilon),\ 0 \rangle \rangle\;}
\qquad
\textsc{New}\;\frac{\;\;}{\;0 \vdash \mathsf{new}_E : F_{\mathbf{1}} (\mathsf{Mb}\;E) \mid \mathbf{1}\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Send}\;\frac{\;\Delta_1 \vdash v :_r \mathsf{Mb}\;E \qquad \Delta_2 \vdash \overline{v} : \overline{V} \qquad m[\overline{V}] \sqsubseteq E\;}{\;\Delta_1 + \Delta_2 \vdash \mathsf{send}\;m(\overline{v})\;\mathsf{to}\;v : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathsf{send}_m,\ \langle 1, 1 \rangle \rangle\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Guard}\;\frac{\;\Delta_0 \vdash v :_1 \mathsf{Mb}\;E \quad E = \textstyle\sum_i m_i[\overline{V_i}] \cdot E_i \quad \bigl(\Delta_i,\ \overline{x_i} :_1 \overline{V_i},\ y :_1 \mathsf{Mb}\;E_i \vdash c_i : C \mid \varepsilon_i\bigr)_i\;}{\;\Delta_0 \boxtimes_{\mathbf{1}} \bigl(\textstyle\bigsqcup_i \Delta_i\bigr) \vdash \mathsf{guard}\;v\;\{m_i(\overline{x_i}) \mapsto c_i\}_i : C \mid \textstyle\bigsqcup_i \varepsilon_i\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Free}\;\frac{\;\Delta \vdash v :_1 \mathsf{Mb}\;\mathbf{1}\;}{\;\Delta \vdash \mathsf{free}\;v : F_{\mathbf{1}} \mathbf{1} \mid \mathbf{1}\;}
\end{equation*}
```

:::caption
Engendrer, créer une boîte, émettre, recevoir sous garde, libérer
:::
::::

Trois points de conception méritent d'être lus sur ces règles, et le troisième est celui qu'aucun
énoncé du manuscrit ne portait.

{sc}[Spawn] ajoute le travail de la tâche fille et _rien à la profondeur de la mère_. C'est le
modèle de la bifurcation et de la jonction, et c'est ce qui rend le coût compositionnel : engendrer
une tâche ne rallonge pas le chemin critique de celui qui l'engendre, il augmente la facture totale.

{sc}[Guard] rend explicite la _continuation de motif_, $`y :_1 \mathsf{Mb}\;E_i` : consommer un
message transforme le type de la boîte. C'est l'état porté par le type, et c'est ce que le chapitre
4 décrit en prose sans pouvoir l'écrire. La consommation multi-places d'un motif de jonction en est
l'opération native, et non un protocole d'appariement à inventer.

{sc}[Free] exige $`\mathsf{Mb}\;\mathbf{1}`, c'est-à-dire une boîte _vide_. L'absence de déchets
devient donc une propriété de typage : un acteur ne peut pas disparaître en laissant des messages
non lus, parce que le terme qui le libérerait n'a pas de dérivation. {rmq}[Une garantie que le
manuscrit ne revendiquait pas, et qu'il obtient en écrivant la règle qui lui manquait.] C'est une
garantie que le manuscrit ne portait sous aucune forme.

La configuration de la machine change en conséquence, et c'est le prix annoncé. Elle passe d'un
triplet à $`\langle \mathcal{P} \mid \mu \mid \mathcal{M} \mid \tau \rangle`, où $`\mathcal{P}` est
un multi-ensemble de calculs, $`\mathcal{M}` associe à chaque localisation un multi-ensemble de
messages, et où $`\tau` _cesse d'être une suite_ : sous concurrence, l'ordre d'occurrence des
événements n'est plus total, et la trace devient un ordre partiel étiqueté. Les règles de réduction
se scindent alors en locales — celles qui précèdent, appliquées à un membre du multi-ensemble — et
globales, qui sont les cinq ci-dessus ; la congruence est la permutation du multi-ensemble.

## La couche 1 — distribution, localité, défaillance
%%%
tag := "g-couche1"
%%%

{label "sec:g-couche1"}

La distribution est l'extension la plus lourde que ce langage ait à porter, et c'est pourquoi elle
est le meilleur argument en faveur de la condition de clôture : _elle se décompose exactement sur
les trois strates, sans en réclamer une quatrième_.

::::k7table (label := "tab:g-distribution") (align := "Z{1.0}lZ{1.0}")
:::caption
Les trois aspects de la distribution et la strate où chacun se range
:::

:::table +header
* * Aspect
  * Strate
  * Objet
* * _où_ une valeur réside
  * coeffet
  * la modalité graduée $`@_n` sur le demi-treillis des localisations
* * ce que _coûte_ un déplacement
  * effet
  * $`\mathsf{net}_{n,m}` dans la quantale, de coût $`\langle c, c \rangle`
* * ce qui est _déplaçable_
  * raffinement
  * le prédicat $`\mathsf{Ser}(V)`
:::
::::

La première ligne mérite d'être soulignée, car elle décide du reste. $`@_n` est une _modalité
graduée sur une structure ordonnée_ — la huitième instance du procédé que le chapitre 2
(§{num "sec:c2-adjonctions-et-enrichissement"}[]) construit unefois pour toutes. {rmq}[Neuf
instances d'un même procédé. Une dixième ne demanderait rien de plus, et c'est ce qu'on attend d'une
construction qui porte.] Loger la localité dans une cinquième composante du grade l'aurait rendue
spéciale ; l'écrire comme une instance la rend ordinaire, et c'est ce qu'elle doit être.

::::formula (label := "eq:regles-couche1") (kind := "formule")
```
\begin{equation*}
\textsc{At}\;\frac{\;\Delta \vdash c : C \mid \varepsilon \qquad \mathrm{loc}(\Delta) \sqsupseteq n\;}{\;@_n \Delta \vdash \mathsf{at}_n\;c : @_n C \mid @_n \varepsilon\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Move}\;\frac{\;\Delta \vdash v : @_n V \qquad \mathsf{Ser}(V) \qquad n \sqsubseteq m\;}{\;\Delta \vdash \mathsf{move}_{n \to m}\;v : F\,(@_m V) \mid \langle \mathsf{net}_{n,m},\ \langle c, c \rangle \rangle\;}
\end{equation*}
```

```
\begin{equation*}
\textsc{Try}\;\frac{\;\Delta_1 \vdash c : C \mid \varepsilon \qquad \Delta_2 \vdash h : C \mid \varepsilon'\;}{\;\Delta_1 \sqcup \Delta_2 \vdash \mathsf{try}\;c\;\mathsf{catch}\;h : C \mid \varepsilon \sqcup \varepsilon' \sqcup \mathsf{fail}\;}
\end{equation*}
```

:::caption
Localiser un calcul, déplacer une valeur, récupérer d'une défaillance
:::
::::

Le coût d'un déplacement est $`\langle c, c \rangle` : le travail et la profondeur y sont égaux,
parce qu'un transfert ne se parallélise pas avec lui-même. C'est le seul endroit du langage où les
deux composantes coïncident par nature, et non par accident.

_La défaillance ne se type pas._ Elle se discipline, en trois temps qui existent déjà : le grade
affine de la couche 2 autorise l'abandon, {sc}[Try] donne la portée de récupération, et la
supervision du chapitre 4 en devient la politique. Vouloir la typer reviendrait à promettre qu'une
machine ne tombe pas, ce qu'aucun système de types ne peut tenir.

Une conséquence de représentation, et elle est mince. Un déplacement traverse un format de
transport, de sorte que l'hypothèse d'environnement reproductible gagne une composante réseau. C'est
une coordonnée de plus au profil matériel, et aucun objet nouveau.

## Ce que la vérification apprend
%%%
tag := "g-regles-les-connecteurs-restants-ce-que-la-verification-app"
%%%

Trois connecteurs sur six suivaient les patrons, trois n'y entraient pas. L'affirmation qu'ils
étaient tous mécaniques était donc trop large, et l'épreuve le montre : une induction qui les aurait
traités par « comme ci-dessus » aurait manqué le partage de contexte de l'additif et l'indexation du
vecteur, c'est-à-dire deux des endroits où le système fait un travail qu'un système ordinaire ne
fait pas.

Le monoïde des transformateurs est construit au §{num "sec:g-regles"}[] ; ce qui reste ouvert n'est
plus son contenu mais une condition sur lui, la commutation de ses deux familles, qui tient sur une
présentation sans relation croisée et se romprait sur une autre.

# Le lemme de substitution
%%%
tag := "g-regles-le-lemme-de-substitution"
%%%

Aucune des inductions ouvertes n'aboutit sans lui, et sa forme est contrainte par la gradation
indexée : il porte sur trois niveaux à la fois, le terme, le type et le grade.

Si $`\Delta,\, x :_r V_i \vdash c : C \mid \varepsilon(i)` et $`\Delta' \vdash v : V_j`, alors
$`\Delta \boxtimes_{\mathbf{1}} (r\cdot\Delta') \vdash c[v/x] : C[j/i] \mid \varepsilon(j)`.

Deux clauses le conditionnent. La première est celle que le chapitre 3 pose : la formation des types
s'effectue dans un contexte dont tous les usages sont annulés, faute de quoi un type pourrait
dépendre d'une ressource consommée et la substitution cesserait d'être admissible. La seconde tient
au facteur $`r\cdot\Delta'` : substituer une valeur employée $`r` fois multiplie les exigences de
son contexte d'autant, ce qui est la contrepartie de {sc}[App] et doit être vérifié cohérent avec
elle.

## La loi de cohérence que l'induction réclame
%%%
tag := "g-regles-le-lemme-de-substitution-la-loi-de-coherence-que-l"
%%%

Conduire l'induction fait apparaître un besoin que le chapitre 1 ne formule pas, posé ici avant la
preuve plutôt que découvert dedans. Toutes les règles qui composent deux contextes — {sc}[Let], {sc}[App], {sc}[Unbox], {sc}[Open], {sc}[Sc]
— obligent, dans le cas de substitution, à faire commuter la multiplication d'un contexte par un
grade avec le transport que $`\psi` opère. Ces deux opérations ne commutent pas librement.

Le calcul est court et il désigne la difficulté. $`\psi` n'agit que sur le budget, par
$`\beta \ominus k` où $`k` est la composante temporelle de l'effet traversé. Multiplier ensuite par
un usage $`u` donne $`u\,(\beta \ominus k)`, c'est-à-dire $`u\beta \ominus u\,k`. Multiplier d'abord
et transporter ensuite donne $`u\beta \ominus k`. _Les deux diffèrent_, et la seconde sous-facture :
elle ne retranche qu'un exemplaire du coût là où le calcul est employé $`u` fois.

Ce qui les réconcilie est déjà écrit ailleurs. $`\varphi` dit qu'employer $`u` fois un calcul
d'effet $`\varepsilon` produit $`\varepsilon^{u}`, dont la composante temporelle est $`u\,k`. Il
suffit donc de transporter avec l'effet _multiplié_ plutôt qu'avec l'effet nu.

Cette loi n'était pas écrite quand ce texte l'a réclamée, et c'est ici qu'elle l'est. Le
chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) en pose l'obligation — elle est ce qui autorise
le jugement à ne porter que trois composantes — sans la démontrer. La démonstration a son lieu là où
la loi sert, et elle sert trois fois dans cette section.

Les deux membres coïncident sur toutes les composantes du grade sauf le budget, sans rien demander,
puisque $`\psi` y est l'identité et que la multiplication y opère de part et d'autre : l'usage se
multiplie, la monotonie prend le minimum, le niveau prend le joint. L'énoncé est formulé ainsi
plutôt qu'en dénombrant les composantes, parce que leur nombre n'est pas fixé
(§{num "sec:c1-axiomatique-germinale"}[]) : ce qui porte l'argument est que le budget est la seule
composante où $`\psi` agisse, non qu'il en reste trois. Notons $`u` la composante d'usage de $`r` et
$`k` celle du temps dans $`\varepsilon`. Le membre gauche vaut $`u\,(\beta \ominus k)` ; le membre
droit vaut $`u\beta \ominus u\,k`, puisque $`\varphi_r` porte la composante temporelle à $`u\,k`.
L'égalité est donc celle de la distributivité du produit sur la soustraction tronquée, qui vaut dans
$`\mathbb{N}_\infty` pour tout $`u` : pour $`u = 0` les deux membres sont nuls ; pour $`u` fini elle
se vérifie par cas selon que $`\beta \geq k` ou non ; pour $`u = \omega` les deux membres valent
$`\omega` dès que $`\beta > k`, et $`0` sinon. La partialité se transporte de la même manière : le
membre gauche est défini si et seulement si le droit l'est, les deux s'annulant ensemble lorsque le
budget ne couvre pas le coût.

::::formula (label := "eq:coherence-axiome") (kind := "formule")
```
\begin{equation*}
r \cdot \psi(\Delta, \varepsilon) \;=\; \psi\bigl(r \cdot \Delta,\ \varphi_r(\varepsilon)\bigr)
\end{equation*}
```

:::caption
La condition sous laquelle la contrainte de complexité peut être répartie sur les deux autres
composantes : multiplier une exigence et multiplier l'effet qu'elle traverse sont la même chose
:::
::::

Cette égalité est la _compatibilité de l'action graduée_, et elle n'est pas démontrée ici. Elle ne
demande que l'arithmétique du semi-anneau des grades, de sorte que son lieu est le chapitre 2
(§{num "sec:c2-la-comonade-exponentielle-et"}[], théorème {num "thm:coherence_axiome"}[]), où elle
est établie une fois pour les quatre démonstrations qui l'emploient — le lemme de substitution, la
relation logique, la traduction et l'expansion des macros.

## Le lemme, démontré
%%%
tag := "g-regles-le-lemme-de-substitution-le-lemme-demontre"
%%%

::::thm (label := "thm:substitution")
:::title
substitution sur trois niveaux
:::

:::statement +titled
Terme, type et grade ensemble

Si $`\Delta,\, x :_r V_i \vdash c : C \mid \varepsilon(i)` et $`\Delta' \vdash v : V_j`, alors
$$`\Delta \boxtimes_{\mathbf{1}} (r\cdot\Delta') \;\vdash\; c[v/x] : C[j/i] \mid \varepsilon(j),`
sous les deux clauses posées ci-dessus : la formation des types s'effectue dans un contexte d'usages
annulés, et $`\varphi` et $`\psi` satisfont la loi de
cohérence (théorème {num "thm:coherence_axiome"}[]).
:::

:::proofsketch
Par induction sur la dérivation de $`\Delta,\, x :_r V_i \vdash c : C \mid \varepsilon(i)`. Les
trente-quatre règles se rangent en cinq groupes, dont trois ne demandent rien.

_La variable, et c'est le cas qui porte le facteur $`r`._ Deux sous-cas exclusifs. Si $`c = x`, la
règle {sc}[Var] impose que toutes les autres liaisons soient au grade nul et que celle-ci soit à
l'unité : donc $`\Delta = \mathbf{0}` et $`r = 1`. La conclusion demandée devient
$`\mathbf{0} \boxtimes_{\mathbf{1}} \Delta' \vdash v : V_j`, soit $`\Delta' \vdash v : V_j`, qui est
l'hypothèse. Si $`c = y \neq x`, la même règle impose $`r = 0` ; la substitution ne fait rien, et
$`0\cdot\Delta' = \mathbf{0}` laisse $`\Delta \boxtimes_{\mathbf{1}} \mathbf{0} = \Delta`. _Le
facteur $`r` est donc ce qui compte les emplois de la variable substituée_, et l'énoncé sans ce
facteur serait faux dès ce premier cas.

_Les règles structurelles ne fournissent aucun cas_, l'affaiblissement et la contraction n'étant pas
des règles mais de l'arithmétique de grades. C'est le premier gain de la gradation, et il retire
d'emblée les deux cas les plus pénibles d'une preuve de substitution ordinaire.

_Les règles à contextes additionnés_ — {sc}[Pair], {sc}[Inj] — séparent $`x` entre les deux
prémisses, $`r = r_1 + r_2`. Les deux hypothèses d'induction se recombinent par distributivité du
produit sur la somme dans le semi-anneau des grades,
$`(r_1 + r_2)\cdot\Delta' = r_1\cdot\Delta' + r_2\cdot\Delta'`.

_Les règles à contextes composés_ — {sc}[Let], {sc}[App], {sc}[Unbox], {sc}[Open], {sc}[Sc] — sont
le cœur. Prenons {sc}[App], les autres suivant le même schéma. La conclusion y est
$`\Delta_1 \boxtimes (r'\cdot\Delta_2)`, de sorte que $`x` s'y répartit selon $`r = r_1 + r'\,r_2`.
Recombiner les deux hypothèses d'induction demande
$`r'\cdot(\Delta_2' \boxtimes r_2\Delta') = (r'\Delta_2') \boxtimes (r'r_2\Delta')`, c'est-à-dire
précisément que la mise à l'échelle traverse $`\boxtimes` : c'est le théorème de cohérence, et il
n'y a rien d'autre à vérifier.

_Les règles de sous-typage_ {sc}[Sub] et {sc}[SubBox] se traitent par le fait que le produit mixte
est préservé par les opérations de composition, chaque composante étant monotone dans sa propre
direction. _Les modalités temporelles_ demandent un mot pour {sc}[When], qui envoie la composante
temporelle sur $`\omega` : la loi de cohérence y vaut encore, les deux membres s'annulant ensemble.

_Les trois niveaux._ La substitution du terme donne $`c[v/x]` ; celle du type donne $`C[j/i]` ;
celle du grade donne $`\varepsilon(j)`. Les deux dernières se font ensemble parce que l'indice est
le même, et la première clause — formation des types dans un contexte d'usages annulés — est ce qui
garantit qu'aucun type ne dépend d'une ressource consommée, faute de quoi $`C[j/i]` ne serait pas
formé dans le contexte conclu.

_Une condition de bord, si l'échange venait à être restreint._ L'énoncé place $`x` à l'extrémité
droite du contexte. Sur une application finie des variables vers les grades — ce que $`\Delta` est
ici, l'addition point par point en étant la marque —, cette écriture est une notation et non une
contrainte. Elle en deviendrait une sous la discipline d'échange envisagée au chapitre 3
(§{num "sec:c3-le-systeme-gradue"}[]) : la substitution ne serait alors admissible que pour la
liaison _maximale_ de sa zone. Le lemme ne s'en trouverait pas faux, mais moins général, et la
restriction serait le contenu même de la discipline plutôt qu'un défaut — on ne consomme pas le
second message d'une session avant le premier.
:::
::::

Une forme simultanée en découle, et elle n'est pas un corollaire immédiat sous la discipline
ci-dessus.

::::thm (label := "thm:substitution_simultanee")
:::title
substitution simultanée — corollaire de la substitution élémentaire
:::

:::statement +titled
Fermer un terme, une liaison à la fois

Soit $`\Delta \vdash c : C \mid \varepsilon` et $`\gamma` une substitution qui associe à chaque
liaison $`x_k :_{r_k} V_k` de $`\Delta` une valeur $`\Delta_k \vdash v_k : V_k`. Alors
$$`\textstyle\boxtimes_{\mathbf{1}}\,_k (r_k \cdot \Delta_k) \;\vdash\; \gamma c : C \mid \varepsilon,`
et la dérivation s'obtient en appliquant le théorème {num "thm:substitution"}[] une fois par
liaison.
:::

:::proofsketch
Par récurrence sur le cardinal de $`\Delta`, chaque pas retirant une liaison. Le cas de base est le
contexte vide, où $`\gamma c = c`. Le pas emploie le théorème {num "thm:substitution"}[] et rien
d'autre, la recomposition des contextes étant la sienne. Cet énoncé n'a donc pas de contenu propre
au-delà de ce qui suit, et il est un corollaire plutôt qu'un théorème : seul le lemme élémentaire
est à mécaniser, l'itération s'en déduisant.

_Ce que l'énoncé doit fixer, et c'est tout son contenu._ L'_ordre_ dans lequel les liaisons sont
retirées est indifférent tant que le contexte est une application finie ; il cesse de l'être sous
une discipline d'échange, où une liaison non maximale dans sa zone n'est pas substituable. La
récurrence se conduit alors dans l'_ordre inverse_ de chaque zone : on retire d'abord la maximale,
ce qui rend maximale la suivante, et ainsi jusqu'à épuisement. Cet ordre existe toujours, un ordre
partiel sur un ensemble fini ayant toujours un élément maximal, et $`\gamma` fermant le terme,
toutes les liaisons sont bien retirées. C'est le seul point où la forme simultanée demande davantage
que la forme simple.
:::
::::

Une remarque sur le statut de ce qui précède. La démonstration est conduite à la main et n'a pas été
vérifiée par machine. Elle ne comporte pas de cas passé sous silence — les trente-quatre règles s'y
rangent toutes —, mais la vérification cas par cas des connecteurs routiniers y est faite par schéma
plutôt qu'un à un, et c'est ce qu'une mécanisation éprouverait.

Deux familles s'ajoutent à cet inventaire, que le corps nomme sans les donner et qui n'appartiennent
à aucun des quatre groupes ci-dessus.

La première est celle de la _loi distributive graduée_, qui gouverne le passage d'une exigence de
contexte à un effet et réciproquement. Sa forme est celle d'une transformation naturelle entre les
deux modalités,
$`\lambda_{r,\varepsilon} : !_r \circ T_\varepsilon \Rightarrow T_{\varphi(r,\varepsilon)} \circ !_{\psi(r,\varepsilon)}`,
où $`\varphi` et $`\psi` disent comment chaque côté est modifié par le passage de l'autre. Deux
règles en dérivent : l'une permet de commuter une demande et un effet en payant le prix que
$`\varphi` et $`\psi` fixent, l'autre interdit de le faire lorsque ce prix n'est pas défini. Ce sont
ces deux fonctions qui portent tout le contenu — les poser, c'est décider si exiger deux fois une
ressource puis produire un effet est la même chose que l'inverse, et à quel coût.

La seconde est celle de la _gradation indexée_. Une monade graduée ordinaire donne à chaque terme un
grade d'effet fixe ; ici le grade dépend des indices que porte le contexte, et la règle doit donc
lire ces indices. Un parcours de $`\mathsf{Vec}\;n\;A` n'a pas un grade d'effet, il a une _famille_
de grades indexée par $`n`, et la règle d'application doit substituer dans cette famille l'indice
effectif de son argument. Il en résulte que la substitution opère sur deux niveaux à la fois — le
terme et le grade — et que le lemme de substitution du paragraphe précédent doit être énoncé pour
les deux ensemble, faute de quoi il ne dit rien du cas qui compte.

Les deux règles que cette famille exige se laissent écrire dès maintenant, puisqu'elles ne dépendent
que de la grammaire. La première est l'application, où l'indice effectif de l'argument est substitué
dans la famille de grades de la fonction :

::::formula (label := "eq:regle-app-indexee") (kind := "equation")
```
\begin{equation}
\frac{\;\Delta_1 \vdash f : (x{:}_r A_i) \multimap_{\varepsilon(i)} B \qquad \Delta_2 \vdash v : A_j\;}{\;\Delta_1 \boxtimes_{\mathbf{1}} (r\cdot\Delta_2) \vdash f\,v : B[j/i] \mid \varepsilon(j)\;}
\end{equation}
```
::::

où $`\boxtimes` note la composition des contextes que la loi distributive gouverne. La seconde est
le lemme de substitution, énoncé sur les deux niveaux : si
$`\Delta, x{:}_r A_i \vdash t : B \mid \varepsilon(i)` et $`\Delta' \vdash v : A_j`, alors
$`\Delta \boxtimes (r\cdot\Delta') \vdash t[v/x] : B[j/i] \mid \varepsilon(j)` — le facteur $`r`
étant celui de la liaison substituée, comme dans l'énoncé qui ouvre cette section. Sa forme
ordinaire — celle qui ne substitue que dans le terme et le type — serait ici vraie et sans emploi,
puisqu'elle ne dirait rien du grade, qui est ce dont dépend le cas intéressant.

Le facteur $`r` n'est pas un ornement, et l'omettre rendrait l'énoncé faux dans le seul sens qui
compte. La règle {sc}[App] conclut sur $`\Delta_1 \boxtimes (r\cdot\Delta_2)` : une fonction qui
déclare consommer son argument $`r` fois multiplie d'autant les exigences du contexte qui le
produit. Le lemme en est la contrepartie, puisque substituer est ce que l'application fait en
réduisant. S'il concluait sur $`\Delta \boxtimes \Delta'`, la réduction de $`(\lambda x.c)\,v`
produirait un terme typable dans un contexte strictement plus faible que celui où l'application
l'était, et la préservation serait fausse. Les deux énoncés de cette section portent donc le même
facteur, et la règle d'application indexée aussi.
