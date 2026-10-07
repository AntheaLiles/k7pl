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

#doc (Manual) "Sémantique opérationnelle" =>
%%%
file := "g-semantique"
tag := "g-semantique"
%%%

{label "sec:g-semantique"}

Cette section et les deux suivantes portent la sémantique sur laquelle les énoncés des chapitres 2
à 4 se raisonnent, après la grammaire et les règles de typage du chapitre 3
(§{num "sec:g-regles"}[]). La relation de réduction est donnée schéma par schéma, une réduction
par forme d'élimination. La préservation et le progrès sont démontrés, le second sous deux
hypothèses nommées, sur les constructeurs que la relation réduit, et le lemme de substitution l'est
également au chapitre 3.

Le cadre est fixé, et la relation peut l'être aussi. Une _configuration_ est un triplet
$`\langle c \mid \mu \mid \tau \rangle` où $`c` est un calcul, $`\mu` un état d'arène — une
application des régions vers leur contenu — et $`\tau` une _trace d'effets_, mot de la quantale
accumulant ce qui a été produit. La relation $`\longrightarrow` est définie par les schémas
suivants, donnés en style à petits pas.

Les schémas se rangent en trois familles, écrites toutes plutôt que représentées par une : une
relation donnée « par exemples » ne supporte pas la récurrence dont la préservation a besoin, et
c'est la récurrence qui manquait.

Les réductions _pures_ ne touchent ni $`\mu` ni $`\tau`. Elles se lisent une par forme
d'élimination, et il y en a exactement une par règle d'élimination du §{num "sec:g-regles"}[] — la
correspondance étant ce qui rendra la preuve de préservation mécanique.

::::formula (label := "eq:reductions-pures") (kind := "formule")
```
% Un equation qui enveloppe un aligned, et non un align* : le corps y renvoie par
% \eqref{eq:reductions-pures}, ce qui demande UN numéro pour le bloc entier. Un
% align* n'en produit aucun et le renvoi sortait en « ?? ». Le #+NAME: ci-dessus
% ne suffit pas : org n'engendre pas de \label pour un bloc export, il le recopie.
\begin{equation*}
\begin{aligned}
\mathsf{let}\;x \leftarrow \mathsf{return}\;v\;\mathsf{in}\;c &\longrightarrow c[v/x] &
\mathsf{force}\;(\mathsf{thunk}\;c) &\longrightarrow c\\
(\lambda x. c)\;v &\longrightarrow c[v/x] &
\mathsf{let}\;() = ()\;\mathsf{in}\;c &\longrightarrow c\\
\mathsf{let}\;(x,y) = (v_1,v_2)\;\mathsf{in}\;c &\longrightarrow c[v_1/x,\,v_2/y] &
\mathsf{case}\;(\mathsf{inj}_i\,v)\;\mathsf{of}\;\{j \mapsto c_j\} &\longrightarrow c_i[v/x]\\
\langle c_j \rangle_{j \in I}.\,i &\longrightarrow c_i &
\mathsf{unbox}\;(\mathsf{box}_r\,v)\;\mathsf{as}\;x\;\mathsf{in}\;c &\longrightarrow c[v/x]\\
\mathsf{open}\;(\mathsf{pack}(W,v))\;\mathsf{as}\;(\alpha,x)\;\mathsf{in}\;c &\longrightarrow c[W/\alpha,\,v/x] &
\mathsf{unfold}\;(\mathsf{fold}\;v) &\longrightarrow v\\
(\Lambda\alpha. c)\,[W] &\longrightarrow c[W/\alpha] &
\mathsf{iter}_{V}\;[\,]\;c &\longrightarrow \mathsf{return}\;()
\end{aligned}
\end{equation*}
```

:::caption
Les réductions pures : une par forme d'élimination, chacune consommant l'introduction qui lui
correspond
:::
::::

Deux d'entre elles appellent un mot. Le parcours d'un vecteur non vide se déplie en une étape et une
suite,
$`\mathsf{iter}_{V}\;[v_0,\ldots,v_{n-1}]\;c \longrightarrow \mathsf{let}\;\_ \leftarrow c[v_0/x]\;\mathsf{in}\;\mathsf{iter}_{V}\;[v_1,\ldots,v_{n-1}]\;c`,
ce qui est la lecture opérationnelle du produit $`\prod_{i<n}\varepsilon(i)` que {sc}[VecE]
synthétise — l'effet du parcours se compose donc pas à pas, et non d'un coup. Et le point fixe
déductif se déplie sur son argument un nombre de fois que fixe le type, la terminaison étant assurée
par la finitude du treillis plutôt que par la forme du terme (schéma plus bas).

Les réductions _effectueuses_ étendent la trace et peuvent modifier l'arène.

::::formula (label := "eq:reductions-effets") (kind := "formule")
```
% Même motif que le bloc précédent, et pour la même raison : \eqref{eq:reductions-effets}
% renvoie au bloc dans son ensemble, donc il lui faut un numéro et un \label explicite.
\begin{equation*}
\begin{aligned}
\langle \mathsf{operation}_\varepsilon(v) \mid \mu \mid \tau\rangle &\longrightarrow \langle \mathsf{return}\;w \mid \mu' \mid \tau\cdot\varepsilon\rangle\\
&\qquad \text{où } (w,\mu') = \llbracket \mathsf{operation} \rrbracket(v,\mu)\\
\langle \mathbf{tick} \mid \mu \mid \tau\rangle &\longrightarrow \langle \mathsf{return}\;() \mid \mu \mid \tau\cdot\langle \mathbf{1}, \delta_\ell\rangle\rangle\\
&\qquad \ell \text{ étant le niveau du calcul}\\
\langle \mathsf{scoped}_{f}(v,\,c) \mid \mu \mid \tau\rangle &\longrightarrow \langle \mathsf{scoped}_{f}(v,\,c') \mid \mu' \mid \tau'\rangle\\
&\qquad \text{si } \langle c \mid \mu \mid \tau\rangle \longrightarrow \langle c' \mid \mu' \mid \tau'\rangle\\
\langle \mathsf{scoped}_{f}(v,\,\mathsf{return}\;w) \mid \mu \mid \tau\rangle &\longrightarrow{}\\
&\qquad \langle \mathsf{return}\;\llbracket \mathsf{operation} \rrbracket(v,w) \mid \mu \mid \tau\rangle
\end{aligned}
\end{equation*}
```

:::caption
Les réductions à effet : la trace s'étend du grade que l'opération déclare
:::
::::

L'opération à portée est la seule dont la réduction ait deux règles, et c'est la contrepartie exacte
de ce que {sc}[Sc] annonce. Son effet étant une _fonction_ de celui de son argument, elle doit voir
cet argument s'exécuter avant de conclure. Elle est donc un contexte d'évaluation, et non un pas.

Ces blocs ne réduisaient pas tous les constructeurs de la grammaire des termes
(§{num "sec:g-grammaire-termes"}[]). Ce qui suit écrit les schémas que le texte des chapitres 2 à 4
détermine déjà ; puis cinq autres, que le texte ne détermine pas et qui sont écrits sur l'orientation que
l'instruction des décisions recommande, _proposés à la ratification_ ; enfin les six autres, que la correction
des grammaires a rendus écrivables (déclassification, formes temporelles, localisation, déplacement), eux aussi
proposés à la ratification (table {num "tab:couverture-reductions"}[]).

Trois réductions pures s'ajoutent. Le point fixe déductif se déplie _exactement_ $`h` fois depuis le
plus petit élément, $`h` étant la hauteur du type $`S` que la règle ({num "eq:regle-fix"}[]) lui
associe : l'image du point fixe (théorème {num "thm:image_fix"}[]) interdit la sortie anticipée, pour
que la durée ne dépende pas de la donnée, et la finitude du treillis
(théorème {num "thm:terminaison_lfp"}[]) assure que $`h` itérations atteignent le plus petit point
fixe. Le copatron se déplie sous l'observation, avec lui-même pour appel corécursif (règle {sc}[Cop],
§{num "sec:g-nu"}[]). Et la portée de récupération rend le résultat de son corps quand celui-ci est
terminal (règle {sc}[Try], §{num "sec:g-couche1"}[]).

::::formula (label := "eq:reductions-pures-suite") (kind := "formule")
```
\begin{equation*}
\begin{aligned}
\mathbf{fix}\;f &\longrightarrow \mathsf{let}\;x_1 \leftarrow f\,\bot_S\;\mathsf{in}\;\mathsf{let}\;x_2 \leftarrow f\,x_1\;\mathsf{in}\;\cdots\\
&\qquad \cdots\;\mathsf{let}\;x_h \leftarrow f\,x_{h-1}\;\mathsf{in}\;\mathsf{return}\;x_h\\
&\qquad h \text{ la hauteur de } S,\ \text{et } \mathsf{return}\;\bot_S \text{ si } h = 0\\[4pt]
\mathsf{out}\;\langle\!\langle j \mapsto c_j \rangle\!\rangle_{j \in J} &\longrightarrow \langle c_j[\mathsf{thunk}\;\langle\!\langle j \mapsto c_j \rangle\!\rangle/x] \rangle_{j \in J}\\[4pt]
\mathsf{try}\;t\;\mathsf{catch}\;h &\longrightarrow t \qquad t \text{ terminal}
\end{aligned}
\end{equation*}
```

:::caption
Réductions pures de plus : le point fixe, le copatron sous l'observation, la récupération qui n'a pas
eu lieu d'être
:::
::::

Trois lectures accompagnent ces schémas, et aucune n'est un choix. Le plus petit élément $`\bot_S` est
celui que le chapitre 2 pose sur les quatre clauses de $`\mathsf{Trellis}_{\text{fin}}`, et que la
traduction note déjà $`\llbracket \bot \rrbracket` ; la fonction monotone $`f` s'applique comme une
fonction, son thunk éventuel étant forcé, et n'a pas d'effet, la règle écrivant $`\mathcal{E} = \emptyset`.
La variable $`x` du copatron est celle que la règle {sc}[Cop] lie implicitement à la branche, sous la forme
d'un thunk : le schéma lui substitue un thunk du copatron, et la branche l'emploie par $`\mathsf{force}\;x`. Et un calcul est _terminal_ s'il est de la forme
$`\mathsf{return}\;v`, $`\lambda x. c`, $`\Lambda\alpha. c`, $`\langle c_i\rangle_{i\in I}` ou
$`\langle\!\langle j \mapsto c_j \rangle\!\rangle_{j \in J}` : les deux dernières introductions de calcul
n'étaient pas nommées dans l'énoncé du progrès.

Les réductions de la couche 2 sont les cinq règles _globales_ que le §{num "sec:g-couche2"}[]
annonçait sans les écrire, et la règle locale qui les complète. Une configuration est
$`\langle \mathcal{P} \mid \mu \mid \mathcal{M} \mid \tau \rangle` : $`\mathcal{P}` est un
multi-ensemble de _fibrilles_ $`p : c`, $`\mathcal{M}` associe à chaque localisation $`\iota` le
multi-ensemble de ses messages, et $`\tau` est l'ordre partiel étiqueté des événements. Une
localisation est une valeur d'exécution de type $`\mathsf{Mb}\;E`, que la grammaire des valeurs ne
liste pas : c'est la seule extension que ces règles supposent. Chaque message porte l'événement de son
émission, $`m(\overline{v})@s`, et $`\tau \triangleleft_p e` note l'ordre $`\tau` étendu de l'événement
$`e`, placé après tout ce que la fibrille $`p` a déjà produit.

::::formula (label := "eq:reductions-couche2") (kind := "formule")
```
\begin{equation*}
\begin{aligned}
&\langle \mathcal{P} \uplus \{p : \mathsf{spawn}\;c\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : \mathsf{return}\;(),\ q : c\} \mid \mu \mid \mathcal{M} \mid \tau \triangleleft_p \varepsilon_{\mathsf{spawn}}\rangle\\
&\qquad q \text{ frais, reprenant après } \varepsilon_{\mathsf{spawn}} = \langle \mathsf{spawn}, \langle w(\varepsilon), 0 \rangle\rangle,\\
&\qquad \varepsilon \text{ étant l'effet de } c\\[6pt]
&\langle \mathcal{P} \uplus \{p : \mathsf{new}_E\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : \mathsf{return}\;\iota\} \mid \mu \mid \mathcal{M}[\iota \mapsto \varnothing] \mid \tau\rangle\\
&\qquad \iota \notin \mathrm{dom}\,\mathcal{M}\\[6pt]
&\langle \mathcal{P} \uplus \{p : \mathsf{send}\;m(\overline{v})\;\mathsf{to}\;\iota\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : \mathsf{return}\;()\} \mid \mu \mid \mathcal{M}[\iota \mapsto \mathcal{M}(\iota) \uplus \{m(\overline{v})@s\}] \mid \tau \triangleleft_p s\rangle\\
&\qquad s = \langle \mathsf{send}_m, \langle 1, 1 \rangle\rangle,\ \iota \in \mathrm{dom}\,\mathcal{M}\\[6pt]
&\langle \mathcal{P} \uplus \{p : \mathsf{guard}\;\iota\;\{m_i(\overline{x_i}) \mapsto c_i\}_i\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : c_k[\overline{v}/\overline{x_k},\, \iota/y]\} \mid \mu \mid \mathcal{M}[\iota \mapsto B] \mid \tau[\,s \prec p\,]\rangle\\
&\qquad \mathcal{M}(\iota) = B \uplus \{m_k(\overline{v})@s\}\\[6pt]
&\langle \mathcal{P} \uplus \{p : \mathsf{free}\;\iota\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : \mathsf{return}\;()\} \mid \mu \mid \mathcal{M} \setminus \iota \mid \tau\rangle\\
&\qquad \mathcal{M}(\iota) = \varnothing
\end{aligned}
\end{equation*}
```

```
\begin{equation*}
\begin{aligned}
&(\textsc{Loc})\quad \langle \mathcal{P} \uplus \{p : c\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : c'\} \mid \mu' \mid \mathcal{M} \mid \tau \triangleleft_p \tau_0\rangle\\
&\qquad \text{si } \langle c \mid \mu \mid \varnothing\rangle \longrightarrow \langle c' \mid \mu' \mid \tau_0\rangle
\end{aligned}
\end{equation*}
```

:::caption
Les cinq règles globales de la couche 2 et la règle locale : engendrer, créer une boîte, émettre,
recevoir sous garde, libérer
:::
::::

Chaque schéma se lit sur le texte qui le précède. L'émission ne bloque pas et la réception bloque
(§{num "sec:g-couche2"}[]) : {sc}[Send] ajoute au multi-ensemble sans condition, {sc}[Guard] n'a de
pas que si un message d'une des branches est présent. Le message consommé fait entrer son événement
d'émission dans l'ordre : c'est l'appariement libération-acquisition du
§{num "sec:c4-echelle-du-systeme"}[], qui établit l'antériorité entre deux fils. {sc}[Free] ne
s'applique qu'à une boîte vide, ce que la règle de typage garantit en exigeant
$`\mathsf{Mb}\;\mathbf{1}` ; la règle {sc}[Loc] relève à la configuration concurrente les schémas de
couche 3, qui y restent déterministes. La relation de la couche 2 ne l'est pas : le choix de la
fibrille qui avance, et celui du message que consomme une garde quand plusieurs conviennent, ne sont
pas fixés par ces schémas.

Cinq autres schémas sont écrits sur l'orientation retenue, et chacun se lit avec la réserve qu'il l'est
sans que le texte le dicte. La mise en parallèle et l'application vectorisée se réduisent par _fourche et
jointure_ : les branches s'exécutent chacune depuis la trace vide, et la trace de la configuration
s'étend d'un seul événement, la composition parallèle des produits de leurs traces
($`\pi(\tau)` est le produit, dans la quantale, des événements du mot $`\tau`). C'est la lecture de la profondeur
que le type annonce — le maximum des profondeurs, non leur somme —, que le dépliage en séquence aurait
perdue. La découpe d'une capacité substitue à ses deux variables un jeton sans contenu : la sûreté spatiale
reste une propriété du typage, et l'arène n'a rien à lire. La garde consomme d'un seul tenant tous les
messages de son motif conjonctif. Enfin la défaillance d'une portée de récupération est un pas de
l'environnement, qui rend la main au recours en inscrivant l'événement de défaillance, sans défaire ce que le
corps avait écrit.

::::formula (label := "eq:reductions-orientees") (kind := "formule")
```
\begin{equation*}
\begin{aligned}
&\langle c_1 \parallel c_2 \mid \mu \mid \tau\rangle \longrightarrow \langle \mathsf{return}\;(v_1,v_2) \mid \mu_1 \uplus \mu_2 \mid \tau\cdot\bigl(\pi(\tau_1)\parallel\pi(\tau_2)\bigr)\rangle\\
&\qquad \text{si } \langle c_i \mid \mu \mid \varnothing\rangle \longrightarrow^{*} \langle \mathsf{return}\;v_i \mid \mu_i \mid \tau_i\rangle\ (i=1,2)\\[6pt]
&\langle \mathsf{vmap}\;v\;[w_0,\ldots,w_{n-1}] \mid \mu \mid \tau\rangle \longrightarrow \langle \mathsf{return}\;[u_0,\ldots,u_{n-1}] \mid \textstyle\biguplus_{i<n} \mu_i \mid \tau\cdot\mathop{\parallel}_{i<n}\pi(\tau_i)\rangle\\
&\qquad \text{si } \langle (\mathsf{force}\;v)\;w_i \mid \mu \mid \varnothing\rangle \longrightarrow^{*} \langle \mathsf{return}\;u_i \mid \mu_i \mid \tau_i\rangle\ (i<n)\\[6pt]
&\mathsf{slice}\;\kappa\;\mathsf{as}\;(x,y)\;\mathsf{in}\;c \longrightarrow c[\kappa/x,\,\kappa/y]\\[6pt]
&\langle \mathcal{P} \uplus \{p : \mathsf{guard}\;\iota\;\{p_i \mapsto c_i\}_i\} \mid \mu \mid \mathcal{M} \mid \tau\rangle\\
&\quad \longrightarrow \langle \mathcal{P} \uplus \{p : c_k[\overline{v_1}/\overline{x_{k1}},\ldots,\overline{v_r}/\overline{x_{kr}},\, \iota/y]\} \mid \mu \mid \mathcal{M}[\iota \mapsto B] \mid \tau[\,s_1 \prec p,\ldots,s_r \prec p\,]\rangle\\
&\qquad p_k = m_1(\overline{x_{k1}}) \mathbin{\&}\cdots\mathbin{\&} m_r(\overline{x_{kr}}),\quad \mathcal{M}(\iota) = B \uplus \{m_1(\overline{v_1})@s_1,\ldots,m_r(\overline{v_r})@s_r\}\\[6pt]
&\langle \mathsf{try}\;c\;\mathsf{catch}\;h \mid \mu \mid \tau\rangle \longrightarrow \langle h \mid \mu \mid \tau\cdot\mathsf{fail}\rangle
\end{aligned}
\end{equation*}
```

:::caption
Fourche et jointure, découpe sans contenu, garde à motif conjonctif, défaillance de l'environnement
:::
::::

Les lectures sont les suivantes. Les deux écritures $`\mu_1` et $`\mu_2` ont des supports disjoints, ce que
l'addition des contextes de {sc}[Par] garantit par la linéarité des capacités d'écriture, de sorte que
$`\mu_1 \uplus \mu_2` est l'arène $`\mu` mise à jour des deux. Le jeton $`\kappa` est une valeur
d'exécution comme les localisations de la couche 2 : close, sans contenu, typée $`\mathsf{Cap}\;\rho` pour
tout segment $`\rho`, et elle n'apparaît que par la réduction d'une découpe ; elle est effacée avec les grades.
Quand plusieurs messages conviennent au motif de la garde, celui que l'on retient est le premier dans l'ordre fixe des
émetteurs, que la structure de la boîte du §{num "sec:c4-echelle-du-systeme"}[] impose ; seul le choix de la
fibrille qui avance reste libre. La défaillance peut survenir à tout moment avant la fin du corps, et elle ne
rend pas l'arène : le grade affine de la couche 2 autorise l'abandon de ce que le corps détenait. Cette
orientation n'est pas la plus fidèle pour la mise en parallèle : l'entrelacement avec une trace par branche,
ordre partiel dès la couche 3, la prolongerait, et c'est elle que la fourche et la jointure préparent.

Les six schémas qui restaient sans règle le sont devenus quand la grammaire a été corrigée : les introductions
temporelles et la localisation sont des valeurs (§{num "sec:g-grammaire-termes"}[]), de sorte que leurs
éliminations ont un sujet qui peut être une valeur close, et que la déclassification a un argument valeur. Ils sont
écrits sur l'orientation la plus étroite, celle d'une machine unique : les lieux et les niveaux sont des
étiquettes de type, et l'horloge vit dans la trace et dans la traduction, non dans la configuration.

::::formula (label := "eq:reductions-modalites") (kind := "formule")
```
\begin{equation*}
\begin{aligned}
&\mathsf{at}\;(\mathsf{always}\;w) \longrightarrow \mathsf{return}\;w\\[4pt]
&\mathsf{wait}\;(\mathsf{next}\;u) \longrightarrow \mathsf{return}\;u\\[4pt]
&\mathsf{when}\;x = \mathsf{now}\;w\;\mathsf{in}\;c \longrightarrow c[w/x]\\[4pt]
&\mathbf{declassify}_{\ell'}(\mathsf{box}_r\,w) \longrightarrow \mathsf{return}\;(\mathsf{box}_{r[\ell']}\,w)\\[4pt]
&\mathsf{at}_n\;(\mathsf{return}\;w) \longrightarrow \mathsf{return}\;(\mathsf{loc}_n\,w)\\[4pt]
&\langle \mathsf{move}_{n \to m}\;(\mathsf{loc}_n\,w) \mid \mu \mid \tau\rangle \longrightarrow \langle \mathsf{return}\;(\mathsf{loc}_m\,w) \mid \mu \mid \tau\cdot\langle \mathsf{net}_{n,m}, \langle c, c\rangle\rangle\rangle
\end{aligned}
\end{equation*}
```

:::caption
Les éliminations des modalités et la déclassification : consommer l'introduction qui leur correspond
:::
::::

Les lectures sont les suivantes. Les cinq premiers schémas sont purs, sans événement : le temps et les niveaux
n'y sont pas observés, et la durée d'une attente n'est pas un pas de la relation. Le pas $`\mathsf{wait}` est
celui où l'horloge de session avance, et c'est la traduction, non la source, qui le compte ; la relation $`\to` ne
porte donc pas la durée d'attente, qui reste visible sur le canal de temps de la cible. La déclassification
rend une boîte dont seul le niveau du grade change, sans événement : c'est le cas où la préservation graduée ne
tient pas telle quelle, le contractum ne se dérivant que dans un contexte dont les niveaux sont abaissés, et la
ligne de préservation ci-dessous le dit. La localisation enveloppe le résultat de l'étiquette de lieu, et ne
déplace rien : la configuration n'a pas de lieu courant, et le coût du déplacement est celui de
$`\mathsf{move}`, qui seul inscrit l'événement réseau, de coût $`\langle c, c \rangle`. Le contexte d'évaluation
$`\mathsf{at}_n\,E` relève le premier de ces schémas aux sous-calculs de la localisation, et
$`\mathsf{delay}\;c` est un calcul terminal, introduction de $`{\bigcirc}C`.

::::k7table (label := "tab:couverture-reductions") (align := "Z{0.55}Z{0.45}Z{2.0}")
:::caption
Les constructeurs de calcul et leur schéma de réduction : ce qui est écrit, ce qui est instruit
:::

:::table +header
* * Constructeur
  * Schéma
  * Ce qui le détermine, ou ce qui manque
* * éliminations et opérations des blocs ({num "eq:reductions-pures"}[]) et ({num "eq:reductions-effets"}[])
  * écrit
  * une par règle d'élimination du §{num "sec:g-regles"}[]
* * $`\mathbf{fix}`, $`\mathsf{out}` et le copatron, $`\mathsf{try}` à corps terminal
  * écrit ({num "eq:reductions-pures-suite"}[])
  * images du point fixe, règles {sc}[Cop] et {sc}[Try]
* * $`\mathsf{spawn}`, $`\mathsf{new}`, $`\mathsf{send}`, $`\mathsf{free}`, et $`\mathsf{guard}` à un message
  * écrit ({num "eq:reductions-couche2"}[])
  * les « règles globales » du §{num "sec:g-couche2"}[]
* * $`\mathsf{guard}` à motif conjonctif
  * écrit, à ratifier ({num "eq:reductions-orientees"}[])
  * la règle {sc}[Guard] porte des motifs conjonctifs ; le choix du message suit la structure de la boîte
* * $`\mathsf{try}` quand le corps défaille
  * écrit, à ratifier ({num "eq:reductions-orientees"}[])
  * la défaillance n'est pas un terme du langage : pas de l'environnement, sans retour en arrière
* * $`\mathbf{declassify}`
  * écrit, à ratifier ({num "eq:reductions-modalites"}[])
  * le contractum n'est pas typable dans le même contexte : la préservation graduée y tient à l'abaissement près
* * $`\mathsf{at}`, $`\mathsf{wait}`, $`\mathsf{when}` (introductions : $`\mathsf{always}`, $`\mathsf{now}`, $`\mathsf{next}`, valeurs ; $`\mathsf{delay}`, terminal)
  * écrit, à ratifier ({num "eq:reductions-modalites"}[])
  * lecture séquentielle : la configuration n'a pas d'horloge, la durée d'attente vit dans la trace de la cible
* * $`\parallel`, $`\mathsf{vmap}`
  * écrit, à ratifier : fourche et jointure ({num "eq:reductions-orientees"}[])
  * le déplier en séquence majorerait la profondeur que le type annonce ; reste l'entrelacement avec une trace par branche
* * $`\mathsf{at}_n`, $`\mathsf{move}_{n \to m}` (introduction : $`\mathsf{loc}_n`, valeur)
  * écrit, à ratifier ({num "eq:reductions-modalites"}[])
  * machine unique : le lieu est une étiquette de type, la configuration n'a pas de lieu courant
* * $`\mathsf{slice}`
  * écrit, à ratifier ({num "eq:reductions-orientees"}[])
  * jeton de capacité sans contenu ; la règle ne donne pas le découpage dans le terme, et le typage le porte
:::
::::

Reste la _congruence_, qui dit où un pas peut avoir lieu. Les contextes d'évaluation sont
$`E ::= [\,] \mid \mathsf{let}\;x \leftarrow E\;\mathsf{in}\;c \mid E\,v \mid E.i \mid E\,[W] \mid \mathsf{out}\;E \mid \mathsf{try}\;E\;\mathsf{catch}\;h \mid \mathsf{scoped}_{f}(v, E) \mid \mathsf{at}_n\,E`,
et la règle est celle qu'on attend : si
$`\langle c \mid \mu \mid \tau\rangle \longrightarrow \langle c' \mid \mu' \mid \tau'\rangle` alors
$`\langle E[c] \mid \mu \mid \tau\rangle \longrightarrow \langle E[c'] \mid \mu' \mid \tau'\rangle`.
La projection, l'instanciation, l'observation et la portée de récupération ont un _calcul_ pour
sujet, et leurs contextes manquaient aux blocs qui les réduisent : sans $`E.i` et $`E\,[W]`, un
sujet qui n'est pas encore sous sa forme d'introduction aurait bloqué.
Cette grammaire de contextes est courte, et sa brièveté n'est pas fortuite : en appel par poussée de
valeur, les arguments sont déjà des valeurs, de sorte qu'il n'y a rien à évaluer sous une paire, une
injection ou un thunk. _L'ordre d'évaluation est donc fixé par la grammaire des termes et non par un
choix de contextes_, ce qui est l'économie que ce style achète et la raison pour laquelle il a été
retenu au chapitre 1.

Trois exigences contraignent cette relation, et elles viennent du corps plutôt que d'un choix de
présentation. Elle est _déterministe_ sur la couche 3, ce que la totalité de cette couche permet et
ce dont dépend le rejeu de P4. Elle rend l'écoulement du temps _observable_, puisque
$`\mathbf{tick}` étend la trace et que c'est sur cette trace que les bornes de coût et la
non-interférence temporelle se liront. Et elle se relève aux configurations concurrentes de la
couche 2 — plusieurs calculs, une arène partagée, une trace par fibrille — sans que le déterminisme
de la couche 3 soit perdu, propriété que la machine abstraite désignée au chapitre 4 possède {cite "cairesLinearSessionAbstract2026"}[].

Deux propriétés font de cette relation autre chose qu'une description, et la relation étant
écrite pour les constructeurs que le texte détermine (table {num "tab:couverture-reductions"}[]),
elles se démontrent sur ceux-là. La _préservation_ dit que le type et la borne
d'effet sont maintenus, la seconde ne pouvant que décroître à mesure que la trace s'allonge. Le
_progrès_ dit qu'un calcul bien typé qui n'est pas terminal peut avancer. Ensemble, ils donnent la
correction du système d'effets : le coût effectif reste sous la borne synthétisée, ce que le
chapitre 1 distingue de l'obligation déchargée par le solveur.

::::thm (label := "thm:preservation")
:::title
préservation
:::

:::statement +titled
Le type se conserve, le potentiel ne croît pas

Si $`\Delta \vdash c : C \mid \varepsilon` et
$`\langle c \mid \mu \mid \tau\rangle \longrightarrow \langle c' \mid \mu' \mid \tau'\rangle`, alors
il existe $`\varepsilon'` tel que $`\Delta \vdash c' : C \mid \varepsilon'` et
$`\tau'\cdot\varepsilon' \sqsubseteq \tau\cdot\varepsilon`.

Sous concurrence, $`\tau` est un ordre partiel étiqueté et non une suite ; la décroissance s'entend
alors _le long de chaque chaîne_ de cet ordre, et non d'une position à la suivante. Les deux
lectures coïncident sur le fragment séquentiel, où toute paire d'événements est comparable.
:::

:::proofsketch
Par récurrence sur la dérivation de la réduction, avec un cas par schéma de
({num "eq:reductions-pures"}[]) et ({num "eq:reductions-effets"}[]).

_Réductions pures._ Chacune consomme une introduction sous son élimination, et la dérivation de
typage du rédex se décompose donc en la prémisse de l'introduction et celle de l'élimination. Le
lemme de substitution du §{num "sec:g-regles"}[] appliqué à ces deux prémisses donne exactement le
jugement du contractum, avec le même effet : $`\varepsilon' = \varepsilon` et $`\tau' = \tau`, de
sorte que l'inégalité est une égalité. Le cas de {sc}[Unbox] est le seul à employer la forme graduée
du lemme, la liaison y étant de grade $`r` et le contexte de l'argument multiplié d'autant, ce qui
est l'hypothèse $`r\cdot\Delta'` du lemme. Le cas de {sc}[Open] emploie sa condition de bord :
$`\alpha \notin \mathrm{fv}(\Delta_1 \boxtimes_{\mathbf{1}} \Delta_2) \cup \mathrm{fv}(\varepsilon) \cup \mathrm{fv}(C)` garantit que la substitution de type ne touche ni la conclusion, ni les contextes, ni l'effet.

_Réductions à effet._ Pour $`\mathsf{operation}_\varepsilon(v)`, la règle {sc}[Op] donne
$`F_{\mathbf{1}} W \mid \varepsilon` et le contractum $`\mathsf{return}\;w` reçoit
$`F_{\mathbf{1}} W \mid \mathbf{1}` par {sc}[Ret]. Alors
$`\tau'\cdot\varepsilon' = (\tau\cdot\varepsilon)\cdot\mathbf{1} = \tau\cdot\varepsilon` : le
potentiel est _transféré_ de l'annotation vers la trace, non consommé. Le cas de $`\mathbf{tick}` en
est l'instance où $`\varepsilon = \langle \mathbf{1}, \delta_\ell\rangle`.

_Opérations à portée._ Le premier schéma est une congruence et relève du cas suivant. Le second
termine sur $`\mathsf{return}` : l'hypothèse de {sc}[Sc] donne $`f(\varepsilon_c)` et le contractum
est pur, d'effet $`\mathbf{1}` ; l'inégalité
$`\tau \cdot \mathbf{1} \sqsubseteq \tau \cdot f(\varepsilon_c)` tient puisque $`\mathbf{1}` est le
neutre et l'ordre compatible avec le produit. _C'est le seul endroit où l'inégalité est stricte_, et
c'est correct : un gestionnaire qui intercepte un effet le retire, donc le potentiel provisionné
n'est pas dépensé.

_Congruence._ Par hypothèse de récurrence sur le sous-calcul, plus la monotonie du produit de la
quantale : si $`\varepsilon_1' \sqsubseteq \varepsilon_1` alors
$`\varepsilon_1'\cdot\varepsilon_2 \sqsubseteq \varepsilon_1\cdot\varepsilon_2`, ce qui est la loi
de quantale du §{num "sec:c1-axiomatique-germinale"}[]. Pour le contexte $`\mathsf{scoped}_f(v,E)`,
il faut de plus que $`f` soit monotone : elle l'est, tout élément de $`\mathcal{M}` étant de la
forme normale $`\varphi_n \circ \pi_S` dont les deux facteurs le sont.

_Schémas ajoutés_ ({num "eq:reductions-pures-suite"}[] et {num "eq:reductions-couche2"}[]). Le point
fixe se déplie en une suite de `let` dont chaque liaison est de grade $`\mathbf{1}` et d'effet neutre :
le contractum se dérive par {sc}[Let], {sc}[App] et {sc}[Ret], avec $`\varepsilon' = \varepsilon`, à
condition que $`\bot_S` soit un terme typable de type $`S`, ce que le chapitre 2 pose sans l'écrire. La
récupération qui n'a pas eu lieu rend un terminal $`t` que la prémisse de {sc}[Try] type sous l'effet
$`\varepsilon`, et $`\varepsilon \sqsubseteq \varepsilon \sqcup \varepsilon' \sqcup \mathsf{fail}` ; mais
cette prémisse porte le contexte $`\Delta_1` quand la conclusion porte $`\Delta_1 \sqcup \Delta_2`, et
l'affaiblissement par la jointure y est requis, dont le théorème {num "thm:coherence_subsomption"}[]
reste ouvert. Le copatron demande de substituer à $`x` un thunk du copatron : la prémisse de
{sc}[Cop] le veut de taille $`i`, le rédex le donne de taille $`i + 1`, et la règle de sous-typage des tailles,
écrite, comble l'écart ; la liaison de $`x` étant un thunk, c'est-à-dire une valeur, le lemme de substitution
s'applique, et ce cas se dérive par {sc}[Th], {sc}[Sub] et ce lemme. _Les deux autres ne sont donc pas démontrés_, et
l'énoncé ci-dessus ne l'est que pour les blocs ({num "eq:reductions-pures"}[]) et
({num "eq:reductions-effets"}[]). Les cinq règles globales de la couche 2 demandent en outre de typer
les configurations — chaque localisation porte le type $`\mathsf{Mb}\;E` de ses messages en attente —,
ce que ce document n'écrit pas : la préservation n'y est pas démontrée non plus.

_Schémas orientés_ ({num "eq:reductions-orientees"}[]). La découpe : le jeton est typé
$`\mathsf{Cap}\;\rho_1` et $`\mathsf{Cap}\;\rho_2`, comme la prémisse de {sc}[Slice] l'exige, et le lemme de
substitution donne le contractum avec le même effet. La défaillance : le recours $`h` se type sous
$`\Delta_2`, et l'inégalité d'effet est
$`\tau\cdot\mathsf{fail}\cdot\varepsilon' \sqsubseteq \tau\cdot(\varepsilon \sqcup \varepsilon' \sqcup \mathsf{fail})` ;
l'affaiblissement par la jointure y est requis comme pour la réussite. La fourche et la jointure : chaque
branche se conserve par récurrence sur sa suite de pas, d'où $`\pi(\tau_i) \sqsubseteq \varepsilon_i`, et la
monotonie de $`\parallel` — que ce document n'énonce pas — donne
$`\tau\cdot(\pi(\tau_1)\parallel\pi(\tau_2)) \sqsubseteq \tau\cdot(\varepsilon_1\parallel\varepsilon_2)`, le
contractum $`\mathsf{return}\;(v_1,v_2)` étant d'effet neutre ; pour $`\mathsf{vmap}`, le même argument sur
$`n` branches. La garde à motif conjonctif demande, comme celle à un message, de typer les configurations.
_Ces cas ne sont pas démontrés en détail_ : ils reposent sur la préservation le long des suites de pas des
branches, établie seulement pour les constructeurs que la relation réduit déjà.

_Schémas des modalités_ ({num "eq:reductions-modalites"}[]). Trois se dérivent exactement : $`\mathsf{at}\,(\mathsf{always}\;w)`
a pour prémisse celle de {sc}[Alw], qui type $`w` dans le contexte même du rédex ;
$`\mathsf{when}\;x = \mathsf{now}\;w` se conclut par le lemme de substitution, l'effet $`\varepsilon` du contractum étant
majoré par $`\varepsilon[\omega/k]` de la conclusion ; $`\mathsf{at}_n\,(\mathsf{return}\;w)` se type par {sc}[Loc]
dans le contexte $`@_n\Delta`, l'effet neutre étant majoré par $`@_n\mathbf{1}`. Trois ne se dérivent pas
sans un lemme que ce document n'écrit pas. $`\mathsf{wait}\,(\mathsf{next}\;u)` : le sujet se type dans $`{\bigcirc}\Delta`
et le contractum dans $`\Delta`, puisque l'attente a fait avancer l'horloge ; la préservation y est énoncée _au contexte
avancé près_, ce que la lecture séquentielle ne trace pas. $`\mathsf{move}` : le sujet se type dans $`@_n\Delta` et le
contractum dans $`@_m\Delta` ; les deux coïncident parce que le contexte d'une valeur sérialisable est de grades nuls,
$`\mathsf{Ser}(V)` excluant les ressources, ce qui est un lemme à établir. $`\mathbf{declassify}` : la boîte rendue porte
le niveau abaissé et son contexte se dérive avec des niveaux abaissés ; _c'est le seul cas où la préservation
graduée est fausse en l'état, et elle doit l'être_ : une déclassification divulgue, et le théorème de
divulgation délimitée ({num "thm:divulgation_delimitee"}[]) est ce qui la borne. La préservation de ce cas s'entend donc à
l'abaissement près.
:::
::::

La quantité que cet énoncé fait décroître décide d'une question qu'on croirait devoir traiter à
part.

::::thm (label := "thm:progres")
:::title
progrès
:::

:::statement +titled
Un calcul bien typé qui n'est pas terminal avance, et le pool avec lui

Soit $`\vdash c : C \mid \varepsilon` dans le contexte vide. Alors $`c` est terminal — de la forme
$`\mathsf{return}\;v`, $`\lambda x. c_0`, $`\Lambda\alpha. c_0`, $`\langle c_i\rangle_{i\in I}`,
$`\langle\!\langle j \mapsto c_j \rangle\!\rangle_{j \in J}` ou $`\mathsf{delay}\;c_0` — ou bien il existe
$`\langle c' \mid \mu' \mid \tau'\rangle` tel que
$`\langle c \mid \mu \mid \tau\rangle \longrightarrow \langle c' \mid \mu' \mid \tau'\rangle`, et ce
pour tout $`\mu` et tout $`\tau`.
:::

:::proofsketch
_La forme globale de l'énoncé, d'abord._ Sous concurrence, le progrès ne porte pas sur un calcul
mais sur le multi-ensemble $`\mathcal{P}` : celui-ci avance s'il contient au moins un membre
réductible. Un membre bloqué sur {sc}[Guard] ne contredit donc pas le progrès tant qu'un autre peut
avancer, et le cas où _tous_ sont bloqués est exactement le blocage mutuel, que l'acyclicité du
graphe de dépendances exclut (chapitre 3). Le progrès global est ainsi la conjonction du progrès
local, ci-dessous, et de cette exclusion.

_Le progrès local_, par récurrence sur la dérivation de typage, à l'aide du lemme des formes
canoniques. Ce lemme donne la forme de toute valeur close : $`()` au type $`\mathbf{1}`, une paire
au type $`V_1 \otimes V_2`, un $`\mathsf{inj}_i\,v` au type $`\bigoplus_{i\in I} V_i`, un
$`\mathsf{thunk}` au type $`U_\varepsilon C`, un $`\mathsf{box}_r` au type $`!_r V`, un
$`\mathsf{pack}` au type $`\exists\alpha.V`, un $`\mathsf{fold}` au type $`\mu\alpha.V`, un $`\mathsf{always}` au type
$`{\Box}V`, un $`\mathsf{now}` au type $`{\Diamond}V`, un $`\mathsf{next}` au type $`{\bigcirc}V` et un $`\mathsf{loc}_n` au type $`@_n V`. Ce lemme
s'établit par inspection des règles d'introduction, qui sont dirigées par la syntaxe et dont aucune
n'est admissible pour deux types distincts.

Les cas d'introduction donnent des termes terminaux. Chaque cas d'élimination examine son sujet :
s'il est déjà une valeur, la forme canonique fournit le rédex correspondant et le schéma de
({num "eq:reductions-pures"}[]) s'applique ; sinon, l'hypothèse de récurrence donne un pas et la
congruence le relève, le sujet étant en position d'évaluation dans les contextes $`E`. Les
opérations à effet avancent inconditionnellement, comme le point fixe, qui se déplie toujours.
Sous concurrence, une garde dont la boîte ne contient aucun message attendu est bloquée : c'est le cas
que la forme globale ci-dessus renvoie à l'acyclicité du graphe de dépendances.

L'induction ne porte que sur les formes que les blocs ({num "eq:reductions-pures"}[]),
({num "eq:reductions-pures-suite"}[]), ({num "eq:reductions-effets"}[]) et
({num "eq:reductions-couche2"}[]) réduisent, plus celles que les formules ({num "eq:reductions-orientees"}[]) et
({num "eq:reductions-modalites"}[]), proposées à la ratification, ajoutent : la déclassification, les éliminations
temporelles, la localisation et le déplacement y ont un schéma, et leur cas du progrès se lit comme les autres,
la forme canonique de leur sujet fournissant le rédex. Aucun de ces cas n'est conduit en détail.
La liste des formes terminales de l'énoncé nomme désormais $`\Lambda\alpha. c`, le copatron et
$`\mathsf{delay}\;c`, qui sont des calculs clos qu'aucun schéma ne réduit ; et l'énoncé porte sur un calcul bien typé quelconque, quand la preuve
ne couvre que les constructeurs ci-dessus.

_Deux hypothèses sont nécessaires et il vaut mieux les déclarer que de les supposer._ La première
est que $`\llbracket \mathsf{operation} \rrbracket` soit _totale_ sur les arguments bien typés : le
progrès d'une opération à effet est une propriété de sa réalisation, non du système de types, et une
opération partielle le briserait. La seconde porte sur l'arène, dont ce document ne donne pas la
règle d'élimination (§{num "sec:g-regles"}[]) : le progrès y est conditionné à la conformité de
l'abaissement, qui est une propriété du compilateur. La transcription en assistant de preuve portera
donc ces deux points comme hypothèses de module, et non comme lemmes.
:::
::::

La forme de l'énoncé de préservation mérite qu'on s'y arrête à son tour, car elle décide d'une
question qu'on croirait devoir traiter à part. La quantité qu'il fait décroître n'est pas le coût
d'un pas mais $`\tau\cdot\varepsilon`, c'est-à-dire _ce qui a été produit composé avec ce que le
type autorise encore_. C'est la forme d'un potentiel au sens de la méthode du même nom : une
grandeur attachée à la configuration, qui ne croît jamais, et dont la valeur initiale borne le coût
de toute l'exécution.

La conséquence en est une propriété que ce document n'a pas à demander séparément. Une opération
dont le coût réel dépasse sa part moyenne reste admissible pourvu que $`\varepsilon'` diminue
d'autant — c'est le paiement d'un potentiel accumulé, et la préservation l'autorise puisqu'elle ne
contraint que la somme. _L'annotation d'effet n'a donc pas à porter le pire cas de chaque opération
pour que la borne soit correcte._ Elle doit seulement rendre $`\tau\cdot\varepsilon` décroissant, ce
qui est la préservation elle-même et non une condition supplémentaire.

Cette lecture n'est pas une analogie. La littérature sur l'analyse amortie établit qu'une théorie
des types la supporte à quatre conditions {cite "rajaniUnifyingTypetheoryHigherorder2021"}[] : un
constructeur associant un potentiel fantôme à un type, des raffinements assez précis pour relier le
potentiel à l'état, une représentation des coûts, et l'interdiction de dupliquer un type porteur de
potentiel. La dernière est la plus contraignante : dupliquer un potentiel une seule fois suffit à
ruiner l'analyse.

K7PL satisfait les quatre, et trois d'entre elles par des objets qu'il possédait sans les avoir lus
ainsi. Le budget porté par le grade est le potentiel, provisionné et non encore consommé, que
$`\psi` décrémente de ce que l'effet coûte. Les contraintes de valeur du chapitre 3 sont les
raffinements. Le coût est représenté comme un effet, ce qui est le choix que cette littérature
retient également. Et la quatrième condition tient par la stratification plutôt que par une clause :
le seul mécanisme amorti du langage vit en couche 2, dont le fragment est affine, quand la couche 1
est linéaire et que la couche 3, où la duplication serait libre, n'a pas d'effets du tout.
_L'affinité requise est donc acquise là où un potentiel serait porté, et pour une raison
structurelle._

Les trois niveaux que le chapitre 1 distingue — budget, borne synthétisée, coût effectif — sont
ainsi ceux-là mêmes que cette littérature emploie, sous d'autres noms. Deux directions restent
ouvertes et sont signalées à la section sur ce que chaque preuve ouverte y puise (§{num "sec:g-tracabilite"}[]) : l'analyse amortie en présence d'effets {cite "chuHandlingExceptionsEffects"}[],
qui est le cadre exact de ce langage, et les systèmes admettant des classes arbitraires de fonctions
de potentiel {cite "walchAutomatedAmortisedAnalysis"}[], utiles si le budget se révélait trop
rigide. La vérification de coût relative à une spécification consciente du coût {cite "grodinAbstractionFunctionsTypes"}[]
recoupe pour sa part le système de raffinement du chapitre 2.

Une question demeure, et elle est plus grave que celles-là parce qu'elle porte sur ce que le grade
_veut dire_. La configuration de réduction porte un état d'arène $`\mu` et une trace d'effets
$`\tau` ; elle ne porte rien qui compte les usages de variables. La préservation dit que le type se
conserve et que le potentiel ne croît pas ; le progrès dit qu'un calcul bien typé avance. Aucun des
deux ne dit que le grade _compte ce qu'il prétend compter_. Il est jusqu'ici une grandeur purement
statique, qu'aucun énoncé ne relie à un comportement observable — et c'est P3 qui l'exige, le
postulat interdisant de dissimuler un coût et le grade en étant la mesure. Un grade relié à rien
d'observable dissimulerait tout.

::::thm (label := "thm:correction_ressource")
:::title
correction de ressource
:::

:::statement +titled
Le grade borne les usages effectifs

Étendre la configuration d'un compteur d'usages $`\kappa`, de sorte que la relation devienne
$`\langle \mathcal{P} \mid \mu \mid \mathcal{M} \mid \tau \mid \kappa\rangle \longrightarrow \langle \mathcal{P}' \mid \mu' \mid \mathcal{M}' \mid \tau' \mid \kappa'\rangle`,
où $`\kappa` compte les accès effectifs à chaque liaison _par membre du multi-ensemble_, et où le
compte d'une liaison partagée est la somme des comptes de ceux qui la détiennent. Alors pour tout
$`\Delta \vdash c : C \mid \varepsilon` et toute exécution depuis $`c`, liaison par liaison,
$$`\kappa(x) \;\leq\; \text{la composante d'usage du grade de } x \text{ dans } \Delta.`
:::

:::proofsketch
La configuration est celle d'une machine instrumentée : les accès au tas correspondent aux
références de variables, et la machine les suit. L'induction est celle de la préservation, avec un
cas par règle et la charge supplémentaire de montrer que $`\kappa` ne dépasse jamais l'annotation —
ce qui est immédiat aux règles qui n'emploient pas la variable, et se ramène à la loi de cohérence
de $`\varphi` et $`\psi` à celles qui composent deux contextes.
:::
::::

La forme de machine instrumentée est empruntée à un système modal gradué où elle a déjà servi {cite "erikssonGradedModalType2025"}[].
Ce théorème n'est pas un de plus : trois propriétés en descendent, et deux figurent déjà à ce
document sous une forme non graduée — la sûreté du typage, la non-interférence des ressources non
pertinentes, et la propriété du _pointeur unique_ pour les ressources linéaires, celle qui autorise
la mise à jour en place, donc celle dont l'arène dépend {cite "choudhuryGradedDependentType2021"}[].
C'est ce qui en fait le plus lourd du programme et le plus rentable.

Deux réserves accompagnent la forme, et elles viennent des travaux qui l'ont établie ailleurs. {rmq}[Une
forme à suivre, non un résultat à transporter. La distinction décide de ce qu'on peut invoquer.] La
première est qu'établir un tel énoncé a exigé, dans un système gradué dépendant, une restriction sur
le filtrage que la sûreté non graduée n'exigeait pas : c'est un coût à anticiper plutôt qu'à
découvrir. La seconde est que les résultats disponibles {cite "mannucciResourceBoundedTypeTheory2025"}[]
valent du fragment simplement typé sans récursion.

Une remarque de méthode décide de l'architecture de la preuve plutôt que de son contenu. Le grade
portant plusieurs composantes qu'on voudrait mesurer différemment, la voie économique consiste en
une extraction unique du programme vers une récurrence, puis en une interprétation par composante —
le choix de l'interprétation étant le choix de la mesure — plutôt qu'en un théorème par composante {cite "kavvosRecurrenceExtractionFunctional"}[].
Le grade n'étant pas clos (§{num "sec:c1-axiomatique-germinale"}[]), cette factorisation n'est pas
seulement économique : un théorème par composante devrait être rouvert à chaque extension, une
interprétation de plus ne rouvre rien.

S'il tient, le grade cesse d'être une annotation déclarative pour devenir une borne vérifiée sur
l'exécution, et la mise à jour en place de l'arène en descend. S'il tombe, le grade ne majore plus
rien : il reste une intention, et les trois propriétés qui en descendent doivent être établies
chacune pour soi.

# Un seul objet, et ce qu'une machine serait
%%%
tag := "g-semantique-un-seul-objet-et-ce-qu-une-machine-serait"
%%%

Une question de présentation reste, tranchée ici plutôt que laissée à l'implémenteur. La littérature
sur la construction de compilateurs recommande volontiers de donner, à côté des règles de typage,
une _machine abstraite_ à grands pas et à environnements, avec une règle de machine par règle de
typage. L'argument principal en est qu'on évite ainsi d'avoir à démontrer un lemme de substitution.

Cet argument ne porte pas ici, et il faut dire pourquoi. Le lemme de substitution est _déjà
démontré_ (§{num "sec:g-regles"}[]), et il ne l'a pas été pour la sémantique opérationnelle mais
pour les relations logiques du §{num "sec:g-relation-logique"}[] et pour la traduction vers le
métalangage, qui en ont besoin quelle que soit la présentation retenue. Le coût que la machine à
environnements permettrait d'éviter est donc un coût déjà payé, et payé pour autre chose.

Ce document retient donc _un seul objet_ : la relation $`\longrightarrow` ci-dessus est la
définition de l'exécution, et rien d'autre ne l'est. Une machine à environnements, si elle vient,
sera une construction du chapitre 6 — une optimisation d'implantation, dont la correction se
démontrera _par rapport à_ cette relation plutôt que de la remplacer. La première implantation,
elle, n'a pas à être efficace : elle a à être fidèle, et son office est de vérifier les exemples,
comme Reynolds l'a fait pour GEDANKEN en traduisant sa définition formelle en un interprète qu'il
qualifiait lui-même d'extrêmement inefficace.

Trois objets sont en jeu, et leurs liens doivent être tenus ensemble : une sémantique _construite_,
la relation $`\to` ci-dessus ; une sémantique _empruntée_, la machine à sessions linéaires atteinte par la
traduction $`\llbracket \cdot \rrbracket` ; une sémantique _invoquée_, la catégorie ambiante. La relation
$`\to` est primitive ; la traduction lui est reliée par la simulation du théorème
{num "thm:simulation"}[] ; la catégorie ambiante est requalifiée en vocabulaire (postulat P1a), son
interprétation restant l'obligation P1b. Chaque lien manquant est invisible quand on lit un seul
objet : c'est en les tenant ensemble que l'incohérence apparaîtrait.

Une troisième chose existe pourtant, que ni les règles ni la relation ne portent, et l'omettre
serait la léguer à l'improvisation. Un vérificateur dispose d'une grande liberté dans l'_ordre_ où
il parcourt l'arbre de syntaxe, et cet ordre décide de la localité des messages d'erreur bien plus
que le jeu de règles. Les ordres de parcours que les descriptions théoriques emploient par défaut
n'ont pas été conçus dans ce but, et l'expérience de la famille ML l'établit largement. Cet ordre
n'est ni une règle ni un pas de réduction : il appartient à la spécification de l'outillage —
interprète, formateur, analyseur, serveur de langage — que le chapitre 7 renvoie à un second temps.
_Ce renvoi est ici rendu explicite, pour qu'il soit un choix et non un oubli._

Ce renvoi a un coût, qu'il faut dire : un théorème en dépend. La reproductibilité du rejet
(théorème {num "thm:rejet_reproductible"}[]) suppose l'hypothèse $`D_{\mathrm{det}}`, qui
rassemble trois choix que la spécification de l'outillage doit donc fixer, et non plus laisser : (a)
l'_ordre de parcours_ de l'arbre de syntaxe, qui décide de la localité des messages ; (b) l'_ordre de
recherche_ du narrowing et de la synthèse dirigée par les grades, qui est une recherche de preuve,
avec espace de recherche et possibilité d'échec ; (c) la _graine_ du test par propriétés des indices
`invariant`, `witness` et `lemma`, exécution randomisée intégrée à la compilation. Chacun doit être
une fonction de la source et du compte de ressource. L'ordre de parcours cesse ainsi d'être un
renvoi à l'outillage : il est un objet de la spécification, sous cette hypothèse seulement.

# La stratification du journal
%%%
tag := "g-semantique-la-stratification-du-journal"
%%%

La trace $`\tau` qu'une configuration accumule est le journal, et la projection dont P4 a besoin est
$`\pi^{\flat}_{\ell}`. L'énoncé que le chapitre 4 formule se laisse alors écrire, et se démontre.

::::thm (label := "thm:stratification_journal")
:::title
stratification du journal
:::

:::statement +titled
La projection d'un niveau suffit à rejouer ce niveau

Soit une exécution
$`\langle c \mid \mu \mid \varnothing\rangle \longrightarrow^{*} \langle c' \mid \mu' \mid \tau\rangle`
d'un programme bien typé. Pour tout niveau $`\ell`, rejouer depuis $`\pi^{\flat}_{\ell}(\tau)`
produit, pour un observateur de niveau $`\ell`, la même observation que rejouer depuis $`\tau`.
L'énoncé porte les deux bornes : la projection contient assez pour ce rejeu, et rien de ce qui
excède $`\ell`.
:::

:::proofsketch
Par récurrence sur la suite de réductions, en distinguant les deux formes de pas que la sémantique
donne.

_Un pas pur_ ne touche pas la trace. Il est donc identique des deux côtés, et l'hypothèse de
récurrence se transporte sans rien.

_Un pas effectueux_ étend la trace de $`\varepsilon = \langle \varphi, \kappa\rangle`. Le chapitre 1
pose que le niveau étiquette l'effet sur ses deux composantes ; deux cas se présentent donc, et ils
sont exclusifs. Si l'opération est étiquetée en $`\ell' \leq \ell`, $`\pi^{\flat}_\ell` la conserve
et conserve sa composante temporelle, de sorte que les deux traces coïncident sur ce pas. Si elle
est étiquetée en $`\ell' \not\leq \ell`, $`\pi^{\flat}_\ell` l'efface _et_ annule sa composante
temporelle ; or l'observateur de niveau $`\ell` ne distingue par hypothèse aucune valeur graduée
au-dessus de $`\ell`, et il ne peut pas davantage en compter la durée, celle-ci ayant été retirée.
Le pas est donc invisible des deux côtés.

_La borne inférieure_ suit du premier cas : tout pas que l'observateur distingue est conservé par la
projection, donc le rejeu depuis $`\pi^{\flat}_\ell(\tau)` ne manque rien. _La borne supérieure_
suit du second : aucun pas au-dessus de $`\ell` ne subsiste, ni par lui-même ni par sa durée, donc
le rejeu n'apprend rien de plus. _L'unicité du rejeu_ est acquise par le déterminisme que la
relation impose à la couche 3, lequel est ce dont P4 dépend.

Reste que l'argument suppose l'étiquetage effectif de chaque opération par le niveau du calcul qui
la produit. C'est ce que la loi distributive prescrit et ce que la famille indexée porte ; ce n'est
pas une hypothèse ajoutée mais la structure de $`\mathcal{E}`.
:::
::::

Deux remarques closent ce point. La première est que le rejeu intégral de P4 en est le cas où
l'observateur atteint le niveau le plus haut, la projection devenant l'identité~: P4 n'est pas
affaibli par la stratification, il en est l'instance supérieure. La seconde est que la réalisation
qu'appelle cet énoncé — le journal stratifié — n'est pas choisie pour son coût mais parce que sa
structure _est_ celle de la projection~: journaliser par niveau, c'est n'avoir rien à projeter au
moment du rejeu.

::::thm (label := "thm:correspondance_niveaux") (status := "proposition")
:::title
correspondance des niveaux de lecture et de production
:::

:::statement +titled
Un calcul n'émet d'événement qu'à un niveau au moins égal à celui de ce qu'il lit

Si $`\Delta \vdash c : C \mid \varepsilon` et si $`\langle c \mid \mu \mid \tau \rangle \to^{*} \langle c' \mid \mu' \mid \tau \cdot \tau' \rangle`,
alors tout événement de $`\tau'` a un niveau $`\hat\ell \sqsupseteq \mathrm{niv}(\Delta)`. Autrement dit, le tick
dont dépend un secret n'est jamais étiqueté en deçà du secret.
:::

:::proofsketch
Par préservation (théorème {num "thm:preservation"}[]), chaque contractum reste typable avec une borne
d'effet qui ne fait que décroître, de sorte qu'il suffit de la propriété sur le pas. Pour
{sc}[Tick], le contexte est nul, donc $`\mathrm{niv}(\mathbf{0}) = \bot \sqsubseteq \hat\ell`. Pour {sc}[Op]
et {sc}[Case], c'est exactement la clause de couplage $`\mathrm{niv}(\Delta) \sqsubseteq \hat\ell(\varepsilon)`. Les
autres règles composent des contextes dont le niveau est la jointure de ceux des prémisses, et la
sous-effet {sc}[Sub] ne peut qu'abaisser la borne $`\hat\ell` jusqu'à la clause. Non démontrée en
détail : l'induction doit encore traiter les règles de couche 2.
:::
::::

Cette proposition est le lemme de correspondance que la distinction de $`\ell` et de $`\hat\ell`
rend énonçable ; elle fait de l'exclusion de $`\varphi_\ell` hors de la quantale un résultat dérivé.
Elle n'exige pas d'indexer le jugement par le niveau : la correspondance est portée par les clauses des
règles {sc}[Op], {sc}[Case] et {sc}[Tick], et se lit sur chaque nœud de la dérivation, où le contexte
$`\Delta` et l'effet $`\varepsilon` sont tous deux présents.

# La relation logique, définie
%%%
tag := "g-relation-logique"
%%%

{label "sec:g-relation-logique"}

Le lemme de substitution rend trois inductions conduisibles, et deux d'entre elles partagent le même
objet : une relation logique. On la définit ici une fois, et on la quantifie deux fois — c'est
l'économie que la clôture du lemme de substitution avait annoncée, et elle se réalise.

Fixons un niveau d'observation $`\ell \in \mathcal{L}`. La relation se définit par récurrence sur la
grammaire des types (§{num "sec:g-grammaire-types"}[]), et elle porte _deux familles_ et non une.
C'est le point qu'il faut établir avant les clauses, car il n'était pas prévu.

Le jugement germinal sépare ce que le terme exige, $`\Delta` gradué, de ce qu'il produit,
$`\mathcal{E}`. Or le niveau vit des deux côtés : dans le grade d'une liaison, où il dit ce qu'un
observateur a le droit de _lire_. Et dans la famille temporelle de l'effet, où il dit à quel niveau
un pas a été _fait_. Une relation qui n'indexerait que le premier côté ne dirait rien des traces, et
la non-interférence deviendrait inénonçable — son hypothèse porte sur les entrées, sa conclusion sur
les exécutions. La relation a donc une clause de valeurs, indexée par le grade, et une clause de
calculs, indexée par l'effet ; ce sont les deux versants du même $`\ell`, lus dans deux composantes
distinctes du jugement.

::::formula (label := "eq:relation-logique") (kind := "formule")
```
\begin{align*}
\mathcal{R}_\ell\llbracket b \rrbracket &= \{(w,w)\} \quad \text{(les bases sont observables)}\\
\mathcal{R}_\ell\llbracket \mathbf{1} \rrbracket &= \{((),())\}\\
\mathcal{R}_\ell\llbracket V_1 \otimes V_2 \rrbracket &= \mathcal{R}_\ell\llbracket V_1 \rrbracket \times \mathcal{R}_\ell\llbracket V_2 \rrbracket\\
\mathcal{R}_\ell\llbracket V_1 \oplus V_2 \rrbracket &= \{(\mathsf{inj}_i\,v,\ \mathsf{inj}_i\,v') \mid (v,v') \in \mathcal{R}_\ell\llbracket V_i \rrbracket\}\\
\mathcal{R}_\ell\llbracket \mathsf{Vec}\;n\;V \rrbracket &= \text{point par point, à longueur égale}\\
\mathcal{R}_\ell\llbracket !_{r} V \rrbracket &= \begin{cases} \mathcal{R}_\ell\llbracket V \rrbracket & \text{si } \mathrm{niv}(r) \sqsubseteq \ell\\[2pt] \text{la relation totale} & \text{sinon}\end{cases}\\
&\phantom{{}={}}\text{\emph{l'unique clause qui décide}}\\
\mathcal{R}_\ell\llbracket U_{\varepsilon}\,C \rrbracket &= \{(\mathsf{thunk}\;c,\ \mathsf{thunk}\;c') \mid (c,c') \in \mathcal{R}_\ell\llbracket C \rrbracket\}\\
\mathcal{R}_\ell\llbracket \exists \alpha. V \rrbracket &= \textstyle\bigcup_{\mathcal{S}} \{(\mathsf{pack}(W,v), \mathsf{pack}(W',v'))\\
&\phantom{{}={}}\quad \mid (v,v') \in \mathcal{R}_\ell\llbracket V \rrbracket[\mathcal{S}/\alpha]\}\\
\mathcal{R}_\ell\llbracket \mu\alpha. V \rrbracket &= \text{le plus petit point fixe de la clause, la positivité l'assurant}\\[4pt]
\mathcal{R}_\ell\llbracket F_{\varepsilon} V \rrbracket &= \{(c,c') \mid \text{si } c \Downarrow (v,\tau) \text{ et } c' \Downarrow (v',\tau')\\
&\phantom{{}={}}\quad \text{alors } (v,v') \in \mathcal{R}_\ell\llbracket V \rrbracket \text{ et } \pi^{\flat}_{\ell}(\tau) = \pi^{\flat}_{\ell}(\tau')\}\\
\mathcal{R}_\ell\llbracket V \multimap C \rrbracket &= \{(c,c') \mid \forall (v,v') \in \mathcal{R}_\ell\llbracket V \rrbracket,\\
&\phantom{{}={}}\quad (c\,v,\ c'\,v') \in \mathcal{R}_\ell\llbracket C \rrbracket\}\\
\mathcal{R}_\ell\llbracket C_1 \,\&\, C_2 \rrbracket &= \text{composante par composante}\\
\mathcal{R}_\ell\llbracket \forall \alpha. C \rrbracket &= \textstyle\bigcap_{\mathcal{S}} \mathcal{R}_\ell\llbracket C \rrbracket[\mathcal{S}/\alpha]\\
\mathcal{R}_\ell\llbracket \nu\alpha. C \rrbracket &= \text{le plus grand point fixe : la bisimilarité au niveau } \ell
\end{align*}
```

:::caption
La relation logique au niveau $`\ell`, par récurrence sur la grammaire des types : la clause de la
modalité graduée est la seule qui décide, les autres se contentent de la propager
:::
::::

Quatre remarques, dont trois économisent un travail que l'on croirait devoir faire.

_La clause de la modalité graduée est la seule qui décide_, et c'est là que le grade paie. Un
observateur de niveau $`\ell` lit ce que le niveau du grade lui accorde, et rien d'autre ;
au-dessus, la relation est totale, ce qui signifie exactement qu'aucune information n'en descend.
Comme le $`!_r` est _une_ modalité dont l'indice est un quadruplet, la clause n'inspecte que la
troisième composante — et le chapitre 1 établit que $`\varphi` et $`\psi` ne mêlent jamais deux
composantes du grade entre elles. La relation est donc bien définie sur la structure produit sans
qu'il faille rien vérifier de plus : c'est la première des deux conditions de la clause de session, et elle est acquise par un résultat
déjà écrit.

_La relation sur les contextes ne demande aucune définition nouvelle._ Deux substitutions closes
$`\gamma, \gamma'` sont dites $`\mathcal{R}_\ell\llbracket \Delta \rrbracket`-apparentées lorsque,
pour chaque liaison $`x :_r V` de $`\Delta`, le couple $`(\gamma x, \gamma' x)` appartient à
$`\mathcal{R}_\ell\llbracket !_r V \rrbracket`. Le grade d'une liaison _est_ sa modalité, de sorte
que la clause de contexte est la clause de modalité appliquée liaison par liaison. Une présentation
à deux zones aurait ici demandé deux clauses, et c'est un dividende inattendu de l'économie du
chapitre 1.

_La clause de calcul emploie la projection observationnelle, et non la conservatrice._ Deux calculs
sont apparentés lorsque leurs traces coïncident _après_ $`\pi^{\flat}_{\ell}`, qui retire les
opérations au-dessus de $`\ell` et le temps qu'elles ont consommé. Employer $`\pi^{\dagger}`
laisserait un observateur bas compter les pas d'un calcul haut, et ouvrirait dans la preuve le canal
que la preuve ferme. La distinction posée au §{num "sec:g-regles"}[] n'était donc pas une précaution :
c'est ici qu'elle sert, et elle y est indispensable.

_La clause coalgébrique est déjà justifiée._ Pour $`\nu\alpha. C`, la relation est la bisimilarité,
et le chapitre 1 en tire la conséquence dont on a besoin : la terminalité fait que deux états au
même comportement observable sont indiscernables, l'environnement n'atteignant un acteur que par
messages. La clause ne postule donc pas l'indiscernabilité, elle la reçoit de la définition même de
l'acteur.

# Le lemme fondamental, et ce qu'il coûte
%%%
tag := "g-semantique-le-lemme-fondamental-et-ce-qu-il-coute"
%%%

::::thm (label := "thm:relation_produit") (status := "proposition")
:::title
relation logique sur un produit de structures ordonnées
:::

:::statement +titled
La relation d'un produit se définit composante par composante

Soit $`\mathcal{R} = \prod_i \mathcal{R}_i` un produit de structures ordonnées dont chaque facteur
admet une relation logique compatible. Si la clause décisive de la modalité, celle de
$`!^r V`, n'inspecte qu'une composante de $`r`, alors $`\mathcal{R}` admet une relation logique
compatible, définie composante par composante.
:::

:::proofsketch
On pose la relation du produit comme l'intersection des relations tirées en arrière par les
projections. La compatibilité avec chaque opération — action de $`\varphi` et $`\psi`, composition,
unité — se vérifie composante par composante, puisque ces opérations agissent sans jamais mêler deux
composantes (§{num "sec:c1-de-la-loi-distributive"}[]). La clause de $`!^r V` n'inspectant que la
troisième composante, elle se lit sur la seule relation du facteur de confidentialité, les autres
facteurs la traversant inchangés. Facteur par facteur : sur l'_usage_ $`\mathbb{N}_\infty`, la clause de $`!^r V` compare des comptes et la relation d'un facteur est celle du lemme de ce facteur, $`\varphi` et $`\psi` y étant la multiplication ; sur la _monotonie_ (deux points), la relation est l'égalité, la marque ne modifiant pas le terme ; sur le _niveau_, c'est la clause décisive, la relation y est celle du treillis $`\mathcal{L}` indexée par le niveau d'observation $`\ell` ; sur le _budget_, $`\psi` le diminue sans toucher la valeur, donc la relation de valeur est inchangée et la condition porte sur la trace. Les quatre cas sont immédiats. Pour le budget, $`\psi` agit de la même façon sur les deux substitutions, l'effet $`\varepsilon` étant commun aux deux exécutions ; il diminue les budgets d'autant sans toucher la valeur, et la relation de valeur est donc inchangée. La condition porte sur la trace, que la clause de niveau projette, et elle est acquise par le lemme de substitution. Ce qui est établi ici est une _compatibilité_ et non seulement une
non-interaction : c'est ce que la remarque de la section affirmait sans le dire. Le détail pour chaque
facteur reste à écrire.
:::
::::

::::thm (label := "thm:lemme_fondamental")
:::title
lemme fondamental
:::

:::statement +titled
Tout terme bien typé préserve la relation

Si $`\Delta \vdash c : C \mid \varepsilon` et si $`\gamma,\gamma'` sont
$`\mathcal{R}_\ell\llbracket \Delta \rrbracket`-apparentées, alors
$`(\gamma c,\ \gamma' c) \in \mathcal{R}_\ell\llbracket C \rrbracket`.
:::

:::proofsketch
Par induction sur la dérivation. Le lemme de substitution (théorème {num "thm:substitution"}[]) y
intervient deux fois, et de deux manières qu'il vaut de distinguer.

_Il intervient d'abord pour que l'énoncé ait un sens._ L'application de $`\gamma` à $`c` est une
substitution simultanée, et l'hypothèse d'induction porte sur un jugement dont le contexte a été
composé. Sans le lemme, on ne sait pas que $`\gamma c` est typé, ni à quel contexte ; la conclusion
n'est pas fausse, elle n'est pas énonçable. C'est la forme simultanée
(théorème {num "thm:substitution_simultanee"}[]) qui est employée ici, et non la forme simple : la
distinction est sans effet aujourd'hui, le contexte étant une application finie, et elle en aurait
un sous une discipline d'échange, où l'ordre de séquentialisation cesse d'être indifférent.

_Il intervient ensuite dans les cas de composition._ Pour {sc}[Let] et {sc}[App], le calcul conclu
se forme sur $`\Delta_1 \boxtimes (r\cdot\Delta_2)`, et recoller les deux hypothèses d'induction
demande que la mise à l'échelle traverse la composition : c'est la loi de cohérence la compatibilité
de l'action graduée (théorème {num "thm:coherence_axiome"}[]). Le budget d'une exigence et le coût
de l'effet qu'elle traverse doivent être multipliés ensemble, et le théorème dit que l'ordre des
deux opérations est indifférent.

_Les cas ordinaires._ Les connecteurs se traitent en dépliant la clause correspondante de la
relation, laquelle a été écrite pour cela. {sc}[Box] et {sc}[Unbox] passent par la clause de la
modalité : si le niveau du grade est sous $`\ell`, l'hypothèse d'induction donne la conclusion ;
sinon la relation totale la donne sans hypothèse. Les quantificateurs emploient la paramétricité, le
$`\forall` par intersection sur les relations candidates et le $`\exists` par réunion. {sc}[Sub] se
traite par monotonie de chaque composante dans sa propre direction.

_Le cas de l'effet_, qui est le seul propre à cette preuve. Une $`\mathsf{operation}_\varepsilon(v)`
étend la trace de $`\varepsilon`, dont la composante temporelle est comptée au niveau du calcul qui
la produit (§{num "sec:g-grammaire-types"}[]). Si ce niveau excède $`\ell`, $`\pi^{\flat}_{\ell}`
efface l'opération _et_ sa durée, et les deux traces restent égales après projection. Sinon les deux
exécutions font le même pas, l'argument étant apparenté par hypothèse d'induction. _C'est ici que la
famille indexée paie_ : un compteur temporel nu ne permettrait pas de distinguer les deux sous-cas,
et la preuve s'arrêterait sur le canal temporel.

_Le cas {sc}[Declassify] n'est pas traité_, et cette lacune est l'énoncé du
théorème {num "thm:divulgation_delimitee"}[] plutôt qu'un défaut de celui-ci : voir plus bas.
:::
::::

La non-interférence graduée (théorème {num "thm:non_interference"}[]) s'en déduit en une ligne,
donnée ici pour montrer que rien d'autre n'est employé. Soit un programme dont une entrée est liée
au grade $`r` avec $`\mathrm{niv}(r) \not\sqsubseteq \ell`, et dont le résultat est de niveau
$`\ell`. Deux valeurs quelconques de cette entrée sont apparentées, la clause de modalité y rendant
la relation totale ; le lemme fondamental donne alors des résultats apparentés, donc _égaux_ au
niveau $`\ell`, et des traces égales après $`\pi^{\flat}_{\ell}`. L'égalité des traces est ce qui
ferme le canal temporel, et elle vient de la projection observationnelle plutôt que d'un argument
séparé.

_Une seule relation, indexée par le treillis._ Ce que le niveau indexe est tout ce que la relation
contient : $`\ell \mapsto \mathcal{R}_\ell\llbracket A \rrbracket` est la seule famille dont ce
chapitre ait besoin, et trois énoncés en sont des lectures. La non-interférence graduée est la relation
nue appliquée à deux entrées de niveau supérieur à $`\ell` ; la divulgation délimitée est la même relation
sous l'hypothèse $`\mathcal{X}` ; le lemme fondamental est la preuve qu'elles partagent. Cette famille
n'est pas monotone en $`\ell`, et il ne faut pas lui prêter cette propriété : sur un type de fonction
$`V \multimap C`, abaisser le niveau agrandit à la fois l'ensemble des arguments à traiter et la relation
que les résultats doivent satisfaire, de sorte qu'aucune inclusion ne vaut en général. La préservation
(théorème {num "thm:preservation"}[]) n'en fait pas partie : elle porte sur un pas d'une exécution et non
sur deux exécutions apparentées, et son analogue serait une relation unaire sur les configurations, qui
n'est pas écrite ici.

## Ce qui n'est pas démontré, et il faut le dire précisément
%%%
tag := "g-semantique-le-lemme-fondamental-et-ce-qu-il-coute-ce-qui-n"
%%%

La grammaire des types (§{num "sec:g-grammaire-types"}[]) compte une troisième strate, les types de session, et la relation ci-dessus ne
la traite pas. Ce n'est pas un oubli de rédaction : c'est le second obstacle de la clause de session, et il est le même que celui de l'extension aux canaux.

Le manque se localise en deux points, nommés plutôt que rassemblés sous « l'extension aux canaux ».
Le premier est que les clauses de session — $`\mathbf{End}`, l'émission, la réception, les
branchements, les trois modalités temporelles — se laissent écrire par récurrence comme les autres.
Mais que leur bonne définition suppose que deux exécutions apparentées emploient des noms de canaux
_correspondants_. Le second, qui est le vrai, est qu'un canal créé par un calcul de niveau supérieur
à $`\ell` ne doit pas être observable en deçà, et que rien dans la relation telle qu'elle est écrite
ne l'assure. Il y faut le système de sortes du métalangage, qui est l'objet que cette extension devait construire : il l'est
(§{num "sec:g-sortes"}[]), avec la correspondance des noms et le fil de temps enfilé, et la clause de session y est
écrite (formule {num "eq:relation-sessions-mondes"}[]). La relation de cette section reste définie sur les deux
premières strates, et la non-interférence l'est autant : ce qui manque est l'induction du lemme fondamental sur les
règles de communication, que ni la proposition {num "thm:chaine_fils"}[], bornée à un fragment, ni la clause ne remplacent.

L'énoncé honnête est donc celui-ci. _La non-interférence graduée est démontrée pour le fragment sans
communication_, temps compris — ce qui est plus que ce que la plupart des systèmes gradués
établissent, le canal temporel y étant le plus souvent laissé de côté — _et elle attend, pour le
fragment avec canaux, un objet unique partagé avec la preuve de traduction_. Un seul travail reste,
et il sert deux théorèmes.

# La divulgation délimitée, ou le même argument quantifié deux fois
%%%
tag := "g-semantique-la-divulgation-delimitee-ou-le-meme-argument-qu"
%%%

L'énoncé du théorème {num "thm:divulgation_delimitee"}[] diffère du précédent par sa seule
quantification : deux états qui s'accordent sur ce que voit l'observateur de niveau $`\ell` _et sur
la valeur de chaque expression d'échappatoire_ produisent des exécutions indiscernables à ce niveau.
On ne construit donc pas de seconde relation ; on renforce celle-ci.

Deux substitutions sont dites $`\mathcal{X}`-apparentées lorsqu'elles sont apparentées au sens
précédent et que, pour toute expression $`e \in \mathcal{X}`, $`\gamma e` et $`\gamma' e` s'évaluent
à la même valeur. Le lemme fondamental se rejoue mot pour mot sous cette hypothèse renforcée, _et un
seul cas change_ — celui que le théorème {num "thm:lemme_fondamental"}[] laissait de côté.

Sous la relation nue, {sc}[Declassify] met la preuve en échec, et de la manière la plus nette. La
règle conclut en $`!_{\ell'} A` avec $`\ell' \leq \ell` à partir d'un $`!_{\ell} A`, de sorte qu'un
couple apparenté par la relation _totale_ devrait ressortir apparenté par une relation d'_égalité_.
Rien ne le donne, et c'est correct : une déclassification divulgue, et un théorème qui la
traverserait sans hypothèse serait faux. Sous la relation renforcée, la condition de bord de la
règle — $`e \in \mathcal{X}` — fait que l'hypothèse ajoutée s'applique exactement à cet argument, et
le cas se ferme. _La différence entre les deux théorèmes est donc un cas d'une induction, et cette
mesure est exacte_ : ce que l'ensemble d'échappatoires libère est ce que ce cas consomme, ni plus ni
moins.

## Le blanchiment, et la condition que le lemme de substitution fait apparaître
%%%
tag := "g-semantique-la-divulgation-delimitee-ou-le-meme-argument-qu-2"
%%%

Le mode de défaillance contre lequel cette formulation a été construite est l'attaque par
blanchiment, où l'on fait transiter par une échappatoire une valeur qu'elle n'était pas censée
révéler. Il faut vérifier que la preuve mord dessus, et la vérification donne un résultat que le
document ne porte pas.

La règle exige $`e \in \mathcal{X}`, condition _syntaxique_ et non sémantique : il ne suffit pas que
l'argument soit égal à une échappatoire, il faut qu'il en soit une. C'est ce qui bloque le
blanchiment ordinaire, où l'attaquant calculerait une valeur haute qui coïncide avec une expression
autorisée. La formulation est donc bien celle qu'il fallait.

Mais le lemme de substitution en révèle un contournement que la règle n'exclut pas. Substituer dans
un terme donne $`\mathbf{declassify}_{\ell'}(e)[v/x] = \mathbf{declassify}_{\ell'}(e[v/x])`, et
_rien ne garantit que $`e[v/x]` appartienne encore à $`\mathcal{X}`_. Si $`\mathcal{X}` contient une
expression à variable libre, un appelant peut y substituer ce qu'il veut et déclassifier une valeur
que la déclaration ne couvrait pas — l'échappatoire devient un gabarit plutôt qu'une permission.
Symétriquement, si $`e[v/x] \notin \mathcal{X}`, la substitution détruit la dérivation, et le lemme
de substitution serait faux sur ce cas.

La condition qui résout les deux d'un coup est que $`\mathcal{X}` soit un ensemble d'expressions
_closes_, évaluées dans l'état initial. La substitution y est alors l'identité, le lemme passe, et
l'échappatoire désigne une valeur déterminée avant l'exécution plutôt qu'une forme à remplir. C'est
la lecture que retient la littérature dont l'énoncé est repris {cite "sabelfeldModelDelimitedInformation2004"}[],
et elle n'est pas une restriction gênante : une politique de déclassification qui ne saurait pas
dire _quoi_ elle divulgue ne serait pas une politique. La règle du chapitre 2 porte désormais cette
clause, par la prémisse $`\mathrm{fv}(v) = \emptyset` : l'écart de formalisation relevé au chantier est refermé.

# La traduction vers le métalangage : ce que le lemme solde
%%%
tag := "g-traduction"
%%%

{label "sec:g-traduction"}

La troisième induction est celle du théorème {num "thm:traduction_metalangage"}[], et le lemme de
substitution y joue un rôle différent : il ne sert pas à typer la conclusion mais à commuter avec la
traduction.

::::thm (label := "thm:commutation_traduction")
:::title
commutation de la traduction et de la substitution
:::

:::statement +titled
Traduire un terme substitué, c'est substituer dans la traduction

Pour tout $`c`, tout $`v` et toute variable $`x`, et modulo la congruence structurelle du calcul
cible,
$$`\llbracket c[v/x] \rrbracket_z \;\equiv\; (\nu x)\bigl(\llbracket c \rrbracket_z \;\mid\; \overline{x}\langle \llbracket v \rrbracket \rangle\bigr).`
:::

:::proofsketch
Instance du schéma de commutation (chapitre 2, théorème {num "thm:schema_commutation"}[]), la
transformation étant la traduction. Par induction sur $`c`, en parallèle avec la dérivation que le
théorème {num "thm:substitution"}[] fournit. Le cas de la variable emploie ses deux sous-cas : si
$`c = x`, la coupure se réduit et rend $`\llbracket v \rrbracket` ; sinon $`x` n'est pas libre et la
restriction s'élimine par la loi de portée. Les cas de composition emploient l'extrusion de portée,
licite puisque le lemme de substitution garantit que $`x` n'apparaît que dans la prémisse où son
grade est non nul.
:::
::::

Cette commutation est ce que le cas de l'application réclamait, et elle rend mécaniques les trois
premiers des quatre groupes de l'induction.

Le _premier groupe_, les cas de couche 3, se traite par la seconde voie que l'instruction avait
désignée. Le fragment séquentiel déterministe de la cible étant le lambda-calcul en style à passage
de continuations, et K7PL retenant l'appel par poussée de valeur, la transformée se lit sans détour.
Le _deuxième_, les connecteurs ordinaires, suit le schéma, les quatre règles de l'adjonction fixant
où les coupures se placent. Le _troisième_, la modalité graduée, envoie une liaison de grade
$`\omega` sur un service répliqué et toute autre sur un canal linéaire. Et le grade fini $`n` sur
une ré-invocation séquentielle, selon l'arbitrage du 4 août. Traduire $`r \cdot \Delta`, c'est
ré-invoquer $`r` fois la traduction de $`\Delta`, dont le coût est $`\varphi_r` de celui d'une
invocation — l'égalité entre les deux manières de compter est la compatibilité de l'action graduée
(théorème {num "thm:coherence_axiome"}[]).

Du _quatrième groupe_, les cas résistants, deux se soldent et deux restent.

Le cas (a), les types dépendants pragmatiques, se ramène à une composition : les raffinements sont
effacés à la compilation, le foncteur d'effacement du chapitre 2 (théorème {num "thm:schema_effacement"}[]) le justifie, et il reste à vérifier que
la composée préserve le typage — ce que le lemme de substitution donne, l'effacement commutant avec
la substitution puisqu'il n'agit pas sur les termes. Le cas (d), les opérations à portée, est réglé
par la ré-invocation séquentielle et sa clause est écrite.

Le cas (c), les canaux distingués, est réglé par le système de sortes (§{num "sec:g-sortes"}[]). Le
théorème {num "thm:confinement_sortes"}[] établit que la traduction ne produit que des termes bien
sortés, et qu'aucun canal distingué n'y est lié ni transmis.

## Le point fixe déductif, et pourquoi son image est celle du cas (d)
%%%
tag := "g-traduction-le-point-fixe-deductif-et-pourquoi-son-image-es"
%%%

Le cas (b) reste, et ce qu'il ne demande _pas_ vient d'abord : sa formulation initiale promettait un
travail qui n'a pas lieu d'être.

_La terminaison n'est pas en cause._ Le théorème {num "thm:terminaison_lfp"}[] l'établit déjà : la
suite $`x_0 = \bot`, $`x_{n+1} = f(x_n)` est croissante, stationnaire en au plus $`h` étapes, et sa
limite est le plus petit point fixe. Ce que le cas (b) réclame est l'_image_ de $`\mathbf{fix}` dans
le métalangage, non la convergence de son itération.

_Le semi-treillis n'a pas besoin d'une interprétation nouvelle._ C'est le second constat, et il
dissout la moitié du cas. $`\mathsf{Trellis}_{\text{fin}}` est engendré par quatre clauses
(§{num "sec:g-grammaire-types"}[]) — un type de base à porteur fini, l'unité, une somme ou un
produit de deux tels types, un vecteur de longueur finie — et _la traduction traite déjà ces quatre
formes_. Le porteur $`\llbracket S \rrbracket` existe donc sans qu'on ajoute rien. Quant à la
structure d'ordre, le chapitre 2 la pose sur ces types : l'élément neutre est l'ensemble vide, le
joint est l'union, la hauteur est le cardinal du plus grand support. L'ordre $`\sqsubseteq`, le
joint $`\sqcup` et le minimum $`\bot` sont alors des _fonctions définissables_ par récurrence sur
les quatre clauses, l'égalité y étant décidable — non des primitives à ajouter à la cible. _Ce qui
paraissait une interprétation à donner était une définition à écrire._

Reste l'image de l'opérateur lui-même, et l'appareil qu'elle réclame est déjà là.

::::thm (label := "thm:image_fix")
:::title
image du point fixe déductif
:::

:::statement +titled
Une itération à nombre de tours fixé, du même appareil que la ré-invocation séquentielle

Soit $`\Delta \vdash \mathbf{fix}\,f : S \mid \emptyset` avec $`S \in \mathsf{Trellis}_{\text{fin}}`
de hauteur $`h`. Alors
$$`\llbracket \mathbf{fix}\,f \rrbracket_z \;=\; \bigl(\text{ré-invocation séquentielle de } \llbracket f \rrbracket \text{ exactement } h \text{ fois, depuis } \llbracket \bot \rrbracket \bigr)`
est un terme bien typé et bien sorté du métalangage, et sa valeur est
$`\llbracket \mathrm{lfp}(f) \rrbracket`.
:::

:::proofsketch
_Le mécanisme n'est pas nouveau._ Le cas (d) a tranché qu'une liaison de grade fini $`n` se traduit
par un canal linéaire ré-invoqué $`n` fois en séquence. Ici $`n = h`, connu à la compilation puisque
$`h` se calcule sur la forme du type. _Les deux cas résistants qui restaient partagent donc un seul
appareil_, ce que l'instruction de cette entrée avait prévu.

_Le typage_ suit de l'hypothèse : $`\llbracket f \rrbracket` a pour type
$`\llbracket S \rrbracket \multimap \llbracket S \rrbracket`, et une composition de $`h` copies de
ce type est de type $`\llbracket S \rrbracket \multimap \llbracket S \rrbracket`. Appliquée à
$`\llbracket \bot \rrbracket`, elle donne $`\llbracket S \rrbracket`.

_Le bon sortage_ est immédiat : l'itération ne crée que des canaux de continuation, de genre
$`\mathsf{prog}`, donc restreignables ; aucun canal distingué n'y figure, ce qui est cohérent avec
$`\mathcal{E} = \emptyset` — un opérateur sans effet n'a pas de canal d'effet à mentionner.

_La valeur_ est celle du théorème {num "thm:terminaison_lfp"}[] : la suite étant stationnaire au
plus tard au rang $`h`, appliquer $`f` exactement $`h` fois donne le plus petit point fixe, les
applications postérieures à la stabilisation étant l'identité.
:::
::::

## Ce que ce cas apprend, et qui n'était pas prévu
%%%
tag := "g-traduction-ce-que-ce-cas-apprend-et-qui-n-etait-pas-prevu"
%%%

Une remarque doit accompagner cette image, car elle corrige une facilité et fait travailler ensemble
deux résultats qu'on croyait indépendants.

L'esquisse du théorème {num "thm:terminaison_lfp"}[] note que « _l'égalité décidable de $`S` détecte
ce rang_ » — c'est-à-dire qu'on pourrait sortir de l'itération dès la stabilisation. C'est vrai, et
_la traduction ne doit pas le faire_. Une sortie anticipée rendrait la durée de $`\mathbf{fix}\,f`
dépendante de la donnée sur laquelle il itère, donc observable. C'est le canal temporel que la
projection observationnelle et le théorème {num "thm:lemme_fondamental"}[] ferment. _Itérer jusqu'au
bout n'est donc pas une approximation grossière que l'on tolérerait faute de mieux : c'est ce que la
non-interférence exige_, et P3 le veut pour la même raison — un nombre de tours fixé est
prédictible, un nombre de tours dépendant de la donnée ne l'est pas.

Deux exigences que rien n'obligeait à se rencontrer donnent donc ici la même prescription. C'est
aussi la réponse à une objection qu'un lecteur pressé formulerait : la borne $`h` est celle du type
et non du calcul, une itération réelle convergeant souvent bien plus tôt. C'est exact, et la
différence n'est pas un gaspillage à corriger — elle est le prix de la prédictibilité, et le
document le paie sciemment.

Une seconde remarque, plus mince. L'évaluation _semi-naïve_, que le chapitre 4 signale comme ce qui
rend une extension déductive praticable, n'a pas d'image ici et n'en demande pas. Elle est une
optimisation de l'_évaluation_, justifiée par le fait qu'elle calcule la même limite en exploitant
la différence entre deux éléments consécutifs de la chaîne ; la traduction, elle, interprète la
_dénotation_. Les deux s'accordent par le même argument de chaîne croissante, et confondre les deux
niveaux ferait porter à la traduction une charge qui appartient au compilateur.

## Ce que la clôture de (b) achève
%%%
tag := "g-traduction-ce-que-la-cloture-de-b-acheve"
%%%

Les quatre cas résistants sont réduits à des objets construits, et l'induction entière est planifiée : les groupes 1 à 3 par le
lemme de commutation, (a) par composition avec le foncteur d'effacement, (c) par le système de
sortes, (b) et (d) par le même appareil de ré-invocation bornée. _Le théorème {num "thm:traduction_metalangage"}[]
n'est pas pour autant conduit_ : l'induction est planifiée, ses cas résistants réduits, mais elle n'est pas menée à son terme, et la dette de fidélité que le chapitre 6 nommait — « établir que
$`\llbracket \cdot \rrbracket` préserve le typage » — reste ouverte, plus étroite qu'elle ne l'était.
