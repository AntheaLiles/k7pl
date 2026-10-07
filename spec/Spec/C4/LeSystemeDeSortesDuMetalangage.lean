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

#doc (Manual) "Le système de sortes du métalangage" =>
%%%
file := "g-sortes"
tag := "g-sortes"
%%%

{label "sec:g-sortes"}

Trois preuves attendaient un même objet, et le voici. Il sert le confinement des canaux distingués
(chapitre 4), la définissabilité de la projection observationnelle dans la cible, et la clause de
session de la relation logique.

# Ce qu'on emprunte, et surtout ce qu'on laisse
%%%
tag := "g-sortes-ce-qu-on-emprunte-et-surtout-ce-qu-on-laisse"
%%%

La forme est celle d'un cadre de sortes paramétrique établi pour les calculs de processus appliqués,
dont on retient exactement quatre choses : un ensemble de sortes, une fonction qui en assigne une à
chaque nom, quatre prédicats de capacité, et trois conditions de bonne formation. _Tout le reste du
cadre est laissé_, et voici quoi, faute de quoi on croirait avoir changé de cible.

::::k7table (label := "tab:g-sortes-emprunt") (align := "Z{0.39}Z{1.61}")
:::caption
Ce que le cadre de sortes paramétrique offre, et ce que K7PL en retient
:::

:::table
* * Ce que le cadre offre
  * Ce que K7PL en fait
* * environnements d'assertions, logique associée
  * *laissé* — le métalangage du chapitre 4 n'en a pas, et c'est ce qui nous épargne la difficulté connue des types de session dans ce cadre, laquelle naît de la non-monotonie de cette logique
* * algèbre de termes générale, filtrage étendu
  * *laissé* — nos objets sont des noms, et le filtrage dont nous avons besoin est celui des motifs de jonction, déjà posé
* * ensemble de sortes, fonction d'assignation
  * *retenu*
* * quatre prédicats de capacité
  * *retenu* — c'est l'instrument du confinement
* * trois conditions de bonne formation
  * *retenu*, et une quatrième ajoutée pour les jonctions
:::
::::

_La cible n'est pas changée._ Le métalangage reste celui du chapitre 4 — machine à sessions
linéaires et machine chimique réflexive. On lui ajoute une discipline de noms, et rien d'autre.

# Les sortes
%%%
tag := "g-sortes-les-sortes"
%%%

Une sorte est un couple, et c'est le même geste que pour le grade : _une_ sorte dont l'indice est
structuré, plutôt qu'une famille de sortes sans rapport entre elles.

::::formula (label := "eq:sortes") (kind := "formule")
```
\begin{align*}
\text{(genres)}\quad g &::= \mathsf{prog} \mid \mathsf{operation}_a \;(a \in \mathrm{Ops}) \mid \mathsf{temps} \mid \mathsf{maillon}\\
\text{(sortes)}\quad s &::= \langle g, \ell \rangle \in \mathcal{S} = \mathcal{G}_{\mathrm{en}} \times \mathcal{L}
\end{align*}
```

:::caption
Les sortes du métalangage : un genre, qui dit à quoi le nom sert, et un niveau, qui dit où ses
événements sont observables
:::
::::

On note $`\mathrm{gen}(s)` et $`\mathrm{niv}(s)` les deux projections, et
$`\mathcal{S}_{\mathsf{prog}} = \{s \mid \mathrm{gen}(s) = \mathsf{prog}\}`.

L'assignation suit la traduction. Un canal de programme reçoit la sorte
$`\langle \mathsf{prog}, \ell \rangle` où $`\ell` est _le niveau de ses événements_ — la borne
supérieure des niveaux qu'étiquette $`\varphi` sur les effets de communiquer dessus. Le canal
distingué de l'opération $`a` produite au niveau $`\ell` reçoit
$`\langle \mathsf{operation}_a, \ell \rangle`, et celui du temps
$`\langle \mathsf{temps}, \ell \rangle`. Un quatrième genre apparaît quand la traduction enfile le canal
de temps (§{num "sec:c4-le-calcul-de-processus"}[]) : le _maillon_ de la chaîne, que le programme
traduit crée et transmet de proche en proche, reçoit $`\langle \mathsf{maillon}, \ell \rangle` où
$`\ell` est le niveau du fil qu'il prolonge. Le genre $`\mathsf{temps}` reste celui du canal _ambiant_,
fourni par la configuration.

Ce choix demande d'être justifié plutôt que posé, car une variante s'offrait et elle est fausse. Le
niveau porté par la sorte est celui de _l'effet_, non celui du grade. Le grade est ce que la
traduction oublie (§{num "sec:c4-le-calcul-de-processus"}[]) ; le porter dans une sorte le ferait
passer dans la cible et le foncteur d'effacement cesserait d'en être un, emportant avec lui le
périmètre du théorème {num "thm:fidelite_interprete"}[]. Le niveau d'un effet, lui, vit dans
$`\mathcal{E}`, qui a une image. Il est traduit de plein droit. _Le chapitre 1 posait déjà que le
niveau agit des deux côtés — il contraint ce qu'on lit du côté du grade, il étiquette du côté de
l'effet — et c'est ici que la distinction sert pour la première fois._

Une conséquence tombe sans travail : la famille temporelle
$`\kappa \in \mathbb{N}_\infty^{\mathcal{L}}` _est_ la famille des canaux de temps, un par niveau.
Ce que le §{num "sec:g-grammaire-types"}[] avait posé pour rendre le canal temporel énonçable reçoit
ici son image.

# Les quatre capacités, et le confinement en une ligne
%%%
tag := "g-sortes-les-quatre-capacites-et-le-confinement-en-une-ligne"
%%%

::::k7table (label := "tab:capacites") (align := "Z{0.41}Z{0.75}Z{1.84}")
:::caption
Les quatre prédicats de capacité, instanciés pour K7PL
:::

:::table +header
* * Capacité
  * Instanciation
  * Ce qu'elle assure
* * émettre $`s \mathbin{\propto^-} t`
  * $`\mathrm{gen}(t) = \mathsf{prog}` et $`\mathrm{niv}(t) \sqsubseteq \mathrm{niv}(s)` ; ou $`\mathrm{gen}(s) \in \{\mathsf{temps}, \mathsf{maillon}\}`, $`\mathrm{gen}(t) = \mathsf{maillon}` et $`\mathrm{niv}(t) = \mathrm{niv}(s)`
  * on ne transmet qu'un nom de programme, jamais vers un canal plus bas que lui ; seul un fil transmet, et seulement son maillon suivant, au même niveau
* * recevoir $`s \mathbin{\propto^+} t`
  * $`\mathrm{gen}(t) = \mathsf{prog}` et $`\mathrm{niv}(t) \sqsubseteq \mathrm{niv}(s)`
  * dual ; aucun terme traduit ne reçoit un nom de fil, c'est le gestionnaire qui le fait
* * substituer $`s \mathbin{\#} s'`
  * $`s = s'`
  * la substitution ne change jamais une sorte
* * restreindre $`\mathcal{S}_\nu`
  * $`\mathcal{S}_\nu = \mathcal{S}_{\mathsf{prog}} \cup \mathcal{S}_{\mathsf{maillon}}`
  * *un programme ne peut pas créer de canal d'effet* : ni de canal d'opération, ni de canal de temps ambiant ; il crée ses canaux de continuation et les maillons de sa propre chaîne
:::
::::

Les deux dernières lignes portent tout, chacune pour une raison distincte.

_La restriction_ est le confinement lui-même. Un canal distingué n'est pas créé par un programme :
il est fourni par la configuration ambiante, et le gestionnaire d'effet est le processus qui
l'offre. Poser $`\mathcal{S}_\nu = \mathcal{S}_{\mathsf{prog}} \cup \mathcal{S}_{\mathsf{maillon}}` dit
exactement cela, et le dit en une clause vérifiable plutôt qu'en une phrase : les canaux d'opération
et le canal de temps ambiant n'y sont pas, les maillons y sont, et ils ne sont pas des canaux d'effet
mais les continuations de l'un d'eux (§{num "sec:g-sortes-fil"}[]). Avec la première ligne — on ne
transmet qu'un nom de programme, ou son propre maillon suivant — un terme traduit ne peut ni _créer_ ni
_recevoir_ un nom d'effet : il ne peut donc en mentionner aucun qu'il n'ait reçu de la traduction
elle-même.

_La substitution_ est prise discrète, et ce n'est pas une paresse : c'est ce qui rend le seul
théorème que nous ayons à redémontrer immédiat. Le cadre emprunté dérive en général deux préordres
d'usage et n'exige de la substitution qu'elle _raffine_ la sorte ; en prenant $`\#` égal à
l'égalité, ces préordres deviennent l'identité et la clôture se lit sans induction. Le typage est
déjà fait par les types de session, et les sortes n'ont pas à le refaire.

# Le bon sortage
%%%
tag := "g-sortes-le-bon-sortage"
%%%

::::formula (label := "eq:bon-sortage") (kind := "formule")
```
\begin{equation*}
\frac{\;\mathrm{sort}(a) \mathbin{\propto^-} \mathrm{sort}(b) \quad \vdash_{\mathcal{S}} P\;}{\;\vdash_{\mathcal{S}} \overline{a}\langle b\rangle.P\;}
\qquad
\frac{\;\mathrm{sort}(a) \mathbin{\propto^+} \mathrm{sort}(x) \quad \vdash_{\mathcal{S}} P\;}{\;\vdash_{\mathcal{S}} a(x).P\;}
\qquad
\frac{\;\mathrm{sort}(a) \in \mathcal{S}_\nu \quad \vdash_{\mathcal{S}} P\;}{\;\vdash_{\mathcal{S}} (\nu a)P\;}
\end{equation*}
```

```
\begin{equation*}
\frac{\;\mathrm{sort}(a_i) \mathbin{\propto^+} \mathrm{sort}(x_i) \ \ (1 \leq i \leq n) \quad \vdash_{\mathcal{S}} P\;}{\;\vdash_{\mathcal{S}} a_1(x_1) \mid \cdots \mid a_n(x_n) \triangleright P\;}
\end{equation*}
```

```
\begin{equation*}
\frac{\;\mathrm{sort}(a) = \mathrm{sort}(b) \;\;\text{ou}\;\; \bigl(\mathrm{gen}(a) \in \{\mathsf{temps}, \mathsf{maillon}\},\ \mathrm{gen}(b) = \mathsf{maillon},\ \mathrm{niv}(a) = \mathrm{niv}(b)\bigr)\;}{\;\vdash_{\mathcal{S}} [a \leftrightarrow b]\;}
\end{equation*}
```

:::caption
Le jugement de bon sortage. Les trois premières clauses sont celles du cadre emprunté ; la quatrième
est propre à K7PL, dont les motifs de jonction ne relèvent pas de la communication binaire ; la
cinquième est celle du transfert, que la traduction emploie pour passer un fil sans événement.
:::
::::

La quatrième clause est l'endroit où l'on sort du cadre emprunté, et il faut le dire. Ce cadre est
un cadre de communication _binaire_ ; ses auteurs signalent qu'ils héritent du $`\pi`-calcul
l'encodage du join-calculus plutôt que d'en traiter les primitives. Or K7PL tient l'atomicité d'un
motif de jonction pour primitive — c'est une transition de réseau de Petri consommant plusieurs
places d'un seul tenant, et c'est P1 qui le veut. On ajoute donc la clause, _qui est une conjonction
de la deuxième_, et l'on redémontre ci-dessous ce que l'on n'hérite plus.

::::thm (label := "thm:cloture_sortage")
:::title
clôture du bon sortage par substitution
:::

:::statement +titled
Substituer ne défait pas le sortage

Si $`\vdash_{\mathcal{S}} P` et si $`\sigma` est une substitution bien sortée — c'est-à-dire telle
que $`\mathrm{sort}(x) \mathbin{\#} \mathrm{sort}(\sigma x)` pour tout $`x` de son domaine — alors
$`\vdash_{\mathcal{S}} P\sigma`.
:::

:::proofsketch
Par induction sur la dérivation de $`\vdash_{\mathcal{S}} P`, et chaque cas est immédiat pour la
même raison. Comme $`\#` est l'égalité, une substitution bien sortée préserve la sorte de tout nom :
$`\mathrm{sort}(\sigma x) = \mathrm{sort}(x)`. Les cinq clauses ne portent que sur des sortes de
noms — la cinquième, celle du transfert, aussi —, et leurs prémisses sont donc littéralement inchangées.

Le cas de la jonction ne demande rien de plus que le cas de la réception, dont il est une
conjonction : si chacune des $`n` prémisses est préservée, leur conjonction l'est. _C'est le
dividende du choix de prendre $`\#` discrète_ : le cadre général n'exige de la substitution qu'elle
raffine la sorte, ce qui obligerait à vérifier que le raffinement traverse chaque clause ; l'égalité
rend la vérification vide.
:::
::::

::::thm (label := "thm:confinement_sortes")
:::title
confinement des canaux distingués
:::

:::statement +titled
Un programme traduit ne fabrique aucun canal d'effet

Pour toute dérivation $`\mathcal{D}` de $`\Delta \vdash t : A \mid \varepsilon`, la traduction
$`\llbracket \mathcal{D} \rrbracket` est bien sortée, et tout nom de genre $`\mathsf{operation}_a`
ou $`\mathsf{temps}` qui y figure est _libre_ et appartient aux opérations que $`\varepsilon`
mentionne. Aucun n'est lié, et aucun n'est transmis.
:::

:::proofsketch
Par induction parallèle à celle du théorème {num "thm:traduction_metalangage"}[], sur la même
dérivation. La sédimentation range les cas en trois groupes de coût très inégal.

_Couche 3 — aucun cas._ On y a $`\varepsilon = \emptyset` : aucun canal distingué n'existe, le terme
traduit ne mentionne que des noms de genre $`\mathsf{prog}` — et, quand la traduction enfile le fil
de temps, les maillons que la clause du `let` crée et que ses transferts consomment (§{num "sec:g-sortes-fil"}[]) —,
et le bon sortage est celui d'un terme sans effet.

_Couche 1 — un seul cas._ Le seul effet ordinaire y est $`\mathbf{tick}`, et l'usage courant y est
mononiveau ; le théorème {num "thm:temps_mononiveau"}[] fait alors s'effondrer la famille
temporelle, et les sortes en présence se réduisent à
$`\{\langle \mathsf{prog},\ell\rangle, \langle \mathsf{temps},\ell\rangle, \langle \mathsf{maillon},\ell\rangle\}`
pour un unique $`\ell`.

_Couche 2 — tous les cas._ C'est le seul lieu où l'obligation a un contenu. Les règles structurelles
et les connecteurs n'engendrent que des noms de genre $`\mathsf{prog}` et des maillons, restreignables par
$`\mathcal{S}_\nu` ; la modalité graduée aussi, un service répliqué comme un canal linéaire portant
la même sorte. Le cas de $`\mathsf{operation}_\varepsilon(v)` est celui qui produit une émission sur
un canal distingué : la clause d'émission demande
$`\mathrm{gen}(\llbracket v \rrbracket) = \mathsf{prog}`, ce que fournit l'hypothèse d'induction, et
$`\mathrm{niv}(\llbracket v \rrbracket) \sqsubseteq \ell`, ce que fournit l'étiquetage $`\varphi` —
le calcul qui produit l'effet étant de niveau $`\ell`, tout ce qu'il possède l'est aussi. Le cas des
opérations à portée passe par la ré-invocation séquentielle, qui ne crée pas de nom nouveau.

_La conclusion négative_ se lit alors sur la seule clause de restriction. Aucune règle de la
traduction ne produit un $`(\nu a)` avec $`\mathrm{gen}(a) \notin \{\mathsf{prog}, \mathsf{maillon}\}`, faute de quoi la
clause échouerait ; et la clause d'émission interdit qu'un tel nom soit transmis, un maillon ne se transmettant que le long d'un fil. Un canal distingué
ne peut donc entrer dans un terme traduit que par son contexte, c'est-à-dire par le gestionnaire qui
l'offre.
:::
::::

# Le fil de temps enfilé, et ce que les sortes en font
%%%
tag := "g-sortes-le-fil-de-temps-enfile"
%%%

{label "sec:g-sortes-fil"}

La traduction qui ordonne la trace enfile le canal de temps : chaque événement consomme le canal reçu
et rend le suivant (formule {num "eq:traduction-temps"}[], §{num "sec:c4-le-calcul-de-processus"}[]).
Mise en regard des sortes, elle butait sur deux clauses telles qu'elles étaient écrites. Émettre un
maillon $`t'` sur $`t` transmet un nom de genre $`\mathsf{temps}`, ce que l'émission interdisait (on ne
transmet qu'un nom de programme) ; et la clause du `let` lie un maillon $`t''` par restriction, ce que
la restriction interdisait (un programme ne crée pas de canal d'effet). Les deux phrases ne pouvaient
pas être vraies ensemble, et le théorème {num "thm:confinement_sortes"}[], qui dit qu'aucun nom de
genre $`\mathsf{temps}` n'est lié ni transmis, aurait été faux de la traduction même qu'il garde.

La réponse n'assouplit pas le confinement : elle sépare deux objets que le genre $`\mathsf{temps}`
confondait. Le canal de temps _ambiant_ est fourni par la configuration et écouté par le gestionnaire ;
aucun programme ne le crée, ne le reçoit ni ne le transmet, et le théorème reste vrai tel qu'il est
écrit. Les _maillons_ sont les continuations de ce canal : le programme les crée par la clause du `let`,
et ne peut que les transmettre le long d'un fil de même niveau (tableau {num "tab:capacites"}[]). Un
maillon n'est pas un canal d'effet, il en prolonge un.

Le fil est ensuite une _famille_, et la traduction doit l'être aussi. Le §{num "sec:g-sortes"}[] a
posé que la famille temporelle $`\kappa \in \mathbb{N}_\infty^{\mathcal{L}}` est la famille des canaux
de temps, un par niveau ; les clauses de la formule {num "eq:traduction-temps"}[] n'en écrivent qu'un,
ce qui est le cas mononiveau du théorème {num "thm:temps_mononiveau"}[]. Pour un treillis
$`\mathcal{L}` fini, la traduction prend une famille de fils reçus $`\vec t = (t_k)_{k \in \mathcal{L}}`
et une famille de fils rendus $`\vec t'`. Un événement d'un niveau ne touche que le fil de ce niveau ;
tous les autres fils le traversent par transfert.

::::formula (label := "eq:traduction-fils") (kind := "formule")
```
\begin{align*}
\llbracket \mathbf{tick} \rrbracket_{z,\vec t,\vec t'} &= \overline{t_{\hat\ell}}\langle (),\, t'_{\hat\ell} \rangle \mid \textstyle\prod_{k \neq \hat\ell} [t_k \leftrightarrow t'_k] \mid \overline{z}\langle () \rangle\\
\llbracket \mathsf{operation}_\varepsilon(v) \rrbracket_{z,\vec t,\vec t'} &= \overline{t_{\hat\ell}}\langle \varepsilon,\, t'_{\hat\ell} \rangle \mid \textstyle\prod_{k \neq \hat\ell} [t_k \leftrightarrow t'_k] \mid \llbracket \mathsf{operation} \rrbracket(\llbracket v \rrbracket, z)\\
\llbracket \mathsf{return}\;v \rrbracket_{z,\vec t,\vec t'} &= \overline{z}\langle \llbracket v \rrbracket \rangle \mid \textstyle\prod_{k \in \mathcal{L}} [t_k \leftrightarrow t'_k]\\
\llbracket \mathsf{let}\;x \leftarrow c_1\;\mathsf{in}\;c_2 \rrbracket_{z,\vec t,\vec t'} &= (\nu x, \vec t'')\bigl(\llbracket c_1 \rrbracket_{x,\vec t,\vec t''} \mid x(x').\llbracket c_2 \rrbracket_{z,\vec t'',\vec t'}\bigr)
\end{align*}
```

:::caption
La traduction avec le fil de temps enfilé par niveau. Le niveau $`\hat\ell` est celui de l'événement,
concentré en un seul niveau pour {sc}[Tick] et pour l'opération ; $`\mathcal{L}` est supposé fini.
:::
::::

Pour un seul niveau, la formule ({num "eq:traduction-fils"}[]) redonne celles de
({num "eq:traduction-temps"}[]), l'événement de {sc}[Tick] étant le fil lui-même. Une opération dont la
famille $`\kappa` n'est pas concentrée en un niveau n'a pas de clause : elle demande de choisir sur
quels fils son événement s'écrit, et le texte ne le dit pas. Les sortes sont celles du tableau
{num "tab:capacites"}[] : $`t_k` est de sorte $`\langle \mathsf{temps}, k\rangle` ou
$`\langle \mathsf{maillon}, k\rangle`, $`t'_k` et $`t''_k` de sorte $`\langle \mathsf{maillon}, k\rangle`.
Les constantes d'événement — le niveau, l'effet — ne sont pas des noms et échappent aux capacités.

Ce que le gestionnaire reçoit se lit alors sur les sortes. Le gestionnaire du niveau $`k` est le
processus qui reçoit un événement puis un maillon, et écoute ce maillon ; il est fourni par la
configuration comme le canal ambiant. On note $`J_k(P)` le mot des événements qu'il reçoit au long
d'une exécution de $`P`, et $`J(P) = (J_k(P))_{k \in \mathcal{L}}` le _journal_. La projection
observationnelle du §{num "sec:g-regles"}[], définie plus haut comme la suppression des événements dont
le nom est de niveau $`\not\sqsubseteq \ell`, est ici la restriction du journal aux niveaux
$`k \sqsubseteq \ell` : $`\pi^{\flat}_{\ell}(J) = (J_k)_{k \sqsubseteq \ell}`. Le mot de chaque fil est
bien défini parce que la chaîne est linéaire, ce que l'énoncé suivant précise.

::::thm (label := "thm:chaine_fils") (status := "proposition")
:::title
le fil de temps est une chaîne linéaire
:::

:::statement +titled
Chaque fil porte ses événements dans l'ordre de la trace source

Soit $`c` un calcul formé de $`\mathsf{return}`, de $`\mathsf{let}`, de $`\mathbf{tick}`, d'opérations
dont l'effet est concentré en un niveau et d'éliminations pures de valeur, dont les corps sont de même
nature. Alors $`\llbracket c \rrbracket_{z,\vec t,\vec t'}` est bien sorté ; pour chaque niveau $`k`,
$`t_k` y est consommé exactement une fois et $`t'_k` produit exactement une fois ; et tout maillon créé
par la traduction est transmis exactement une fois, le long d'un fil de même niveau, ou cible d'un
transfert. Le mot $`J_k` est donc la suite des événements de niveau $`k`, dans l'ordre où la relation
$`\to` les produit.
:::

:::proofsketch
Par induction sur $`c`, un cas par clause de ({num "eq:traduction-fils"}[]). {sc}[Tick] : $`t_{\hat\ell}`
est consommé par l'émission et $`t'_{\hat\ell}` produit par elle, la capacité d'émission étant
satisfaite puisque les deux noms ont le niveau $`\hat\ell` et que le second est un maillon ; chaque
autre niveau traverse par un transfert, bien sorté par la cinquième clause du bon sortage. L'opération
est le même cas, sous l'hypothèse que $`\llbracket \mathsf{operation} \rrbracket` ne mentionne aucun
fil — hypothèse de module, qui s'ajoute à sa totalité. {sc}[Ret] est le transfert seul. {sc}[Let] : par
hypothèse d'induction $`c_1` consomme $`\vec t` et produit $`\vec t''`, $`c_2` consomme $`\vec t''` et
produit $`\vec t'` ; chaque $`t''_k` est créé par $`(\nu \vec t'')`, de sorte de genre $`\mathsf{maillon}`,
restreignable, produit une fois et consommé une fois. Les éliminations pures traduisent leur sujet,
qui est une valeur et ne touche aucun fil, puis passent $`\vec t` et $`\vec t'` à leur corps ; quand
plusieurs corps existent, un seul s'exécute, et l'usage est linéaire dans chacun.

L'ordre se lit sur le {sc}[Let] : $`\vec t''` n'est connu du gestionnaire qu'une fois que $`c_1` l'a
émis, donc après tout événement de $`c_1`, et $`c_2` n'émet que sur ce maillon. La chaîne reproduit
ainsi l'ordre de séquencement, que la composition parallèle du métalangage, commutative, ne donnait
pas. _Cette proposition est établie sur le fragment qu'elle nomme et seulement sur lui_ : la
traduction n'a pas de clause pour l'application, pour l'opération à portée ni pour la couche 2, et
l'énoncé y reste à étendre. Pour $`\mathsf{spawn}` il ne s'étend pas tel quel : une fibrille engendrée
ouvre une chaîne de plus, et d'où vient son canal ambiant est une question que le texte ne tranche pas.
:::
::::

Trois conséquences se lisent sur cet énoncé, et aucune n'est démontrée au-delà de ce fragment. La
première est que la restriction aux maillons ne laisse pas un programme cacher ses événements : un
maillon créé qui ne serait ni transmis sur un fil ni cible d'un transfert serait un événement émis
hors de toute chaîne, et l'énoncé l'exclut sur le fragment. La deuxième est que la projection
observationnelle est _définissable dans la cible_ : c'est une restriction du journal, non une
opération sur la trace source. La troisième est que le niveau d'un fil vient de l'effet et non du grade, comme celui des autres
sortes : l'oubli des grades n'a pas à en tenir compte.

# La clause de session de la relation logique
%%%
tag := "g-sortes-la-clause-de-session-de-la-relation-logique"
%%%

Le système de sortes rend enfin définissable ce que le §{num "sec:g-relation-logique"}[] avait dû
laisser de côté, et la définition est courte parce que tout le travail est fait.

La projection observationnelle devient une _restriction de sortes_ : $`\pi^{\flat}_{\ell}` retire
d'une trace tout événement portant sur un nom de sorte $`s` telle que
$`\mathrm{niv}(s) \not\sqsubseteq \ell`. C'est la même opération sur les deux composantes de
l'effet, et la table {num "tab:deux-projections"}[] cesse d'être une coïncidence de forme :
$`\pi^{\dagger}` efface des _genres_, $`\pi^{\flat}` efface au-dessus d'un _niveau_, et ce sont les
deux projections de la sorte.

::::formula (label := "eq:relation-sessions") (kind := "formule")
```
\begin{align*}
\mathcal{R}_\ell\llbracket S \rrbracket \text{ sur un canal } a\\
\text{tel que } \mathrm{niv}(\mathrm{sort}(a)) \not\sqsubseteq \ell &= \text{la relation totale}\\[3pt]
\mathcal{R}_\ell\llbracket \mathbf{End} \rrbracket &= \text{les deux sessions sont closes}\\
\mathcal{R}_\ell\llbracket V \otimes S \rrbracket &= \text{noms émis apparentés, puis continuations apparentées}\\
\mathcal{R}_\ell\llbracket V \multimap S \rrbracket &= \text{noms reçus apparentés donnent}\\
&\phantom{{}={}}\text{continuations apparentées}\\
\mathcal{R}_\ell\llbracket \oplus\{\ell_i : S_i\} \rrbracket &= \text{même étiquette choisie, continuations apparentées}\\
\mathcal{R}_\ell\llbracket \&\{\ell_i : S_i\} \rrbracket &= \text{dual}\\
\mathcal{R}_\ell\llbracket {\bigcirc} S \rrbracket,\ \mathcal{R}_\ell\llbracket {\Box} S \rrbracket,\\
\mathcal{R}_\ell\llbracket {\Diamond} S \rrbracket &= \text{comme } S,\\
&\phantom{{}={}}\text{les événements du canal de temps de niveau } \ell \text{ étant comparés}
\end{align*}
```

:::caption
La relation logique sur les types de session, au niveau $`\ell`. Le niveau du canal décide, comme le
niveau du grade décidait sur les valeurs.
:::
::::

La première ligne est celle qui porte le second obstacle de la clause de session. Un canal créé par un calcul de niveau
$`\ell' \not\sqsubseteq \ell` a ses événements étiquetés $`\ell'`, donc une sorte que
$`\pi^{\flat}_{\ell}` efface, donc la relation totale : un observateur de niveau $`\ell` n'en
apprend rien. _C'est la même clause que celle de la modalité graduée sur les valeurs_, transposée
des grades aux sortes. Le théorème {num "thm:confinement_sortes"}[] garantit que la transposition
est licite ; sans lui, un programme pourrait fabriquer un canal dont la sorte ne dirait pas la
vérité sur ses événements.

La formule se lit à gros traits, et il faut deux précisions pour qu'elle soit une définition. La
première est le premier obstacle du §{num "sec:g-relation-logique"}[] : deux exécutions apparentées
doivent employer des noms de canaux _correspondants_. Une _correspondance_ $`\theta` est une bijection
finie entre des noms de la première exécution et des noms de la seconde, qui conserve la sorte,
$`\mathrm{sort}(\theta a) = \mathrm{sort}(a)`. Elle n'est pas donnée une fois pour toutes : elle _croît_
le long de l'exécution, chaque canal que les deux exécutions créent au même point, et dont le niveau
est $`\sqsubseteq \ell`, y entrant par sa paire de noms frais. Un canal créé à un niveau
$`\not\sqsubseteq \ell` n'y entre pas, c'est la première ligne. La relation est donc indexée par
$`\theta`. La seconde précision est la comparaison des fils : deux processus sont
$`\ell`-_comparables_ lorsque, pour chaque niveau $`k \sqsubseteq \ell`, les journaux $`J_k` de l'un et
de l'autre sont comparables pour le préfixe (§{num "sec:g-sortes-fil"}[]) ; ils sont _égaux_ quand les
deux ont terminé.

::::formula (label := "eq:relation-sessions-mondes") (kind := "formule")
```
\begin{align*}
\mathcal{R}^{\theta}_\ell\llbracket S \rrbracket_z &= \text{la relation totale} \qquad \text{si } \mathrm{niv}(\mathrm{sort}(z)) \not\sqsubseteq \ell\\[3pt]
\mathcal{R}^{\theta}_\ell\llbracket \mathbf{End} \rrbracket_z &= \{(P,P') \mid P \Downarrow \mathsf{close}_z \wedge P' \Downarrow \mathsf{close}_z \Rightarrow \pi^{\flat}_\ell(J_P) = \pi^{\flat}_\ell(J_{P'})\}\\
\mathcal{R}^{\theta}_\ell\llbracket V \otimes S \rrbracket_z &= \{(P,P') \mid P \Downarrow \overline{z}\langle y\rangle.P_1 \wedge P' \Downarrow \overline{z}\langle y'\rangle.P'_1\\
&\phantom{{}={}}\quad \Rightarrow (y,y') \in \mathcal{R}^{\theta}_\ell\llbracket V \rrbracket \wedge (P_1,P'_1) \in \mathcal{R}^{\theta}_\ell\llbracket S \rrbracket_z\}\\
\mathcal{R}^{\theta}_\ell\llbracket V \multimap S \rrbracket_z &= \{(P,P') \mid \forall \theta' \supseteq \theta,\ \forall (y,y') \in \mathcal{R}^{\theta'}_\ell\llbracket V \rrbracket,\\
&\phantom{{}={}}\quad (P\langle y\rangle,\ P'\langle y'\rangle) \in \mathcal{R}^{\theta'}_\ell\llbracket S \rrbracket_z\}\\
\mathcal{R}^{\theta}_\ell\llbracket \oplus\{\ell_i : S_i\} \rrbracket_z &= \{(P,P') \mid P \Downarrow z \triangleleft \ell_i.P_1 \wedge P' \Downarrow z \triangleleft \ell_j.P'_1\\
&\phantom{{}={}}\quad \Rightarrow i = j \wedge (P_1,P'_1) \in \mathcal{R}^{\theta}_\ell\llbracket S_i \rrbracket_z\}\\
\mathcal{R}^{\theta}_\ell\llbracket \&\{\ell_i : S_i\} \rrbracket_z &= \{(P,P') \mid \forall i,\ (P \triangleright \ell_i,\ P' \triangleright \ell_i) \in \mathcal{R}^{\theta}_\ell\llbracket S_i \rrbracket_z\}\\
\mathcal{R}^{\theta}_\ell\llbracket \mathsf{X}\,S \rrbracket_z &= \mathcal{R}^{\theta}_\ell\llbracket S \rrbracket_z \cap \{(P,P') \mid P, P' \text{ sont } \ell\text{-comparables}\} \qquad \mathsf{X} \in \{\bigcirc, \Box, \Diamond\}
\end{align*}
```

:::caption
La relation logique sur les types de session, précisée : indexée par la correspondance des noms, avec
la comparaison des fils de niveau $`\sqsubseteq \ell` ; $`P \Downarrow \alpha` dit que $`P` atteint,
par réductions, une action visible $`\alpha` sur $`z`.
:::
::::

Pour les noms échangés, $`(y,y') \in \mathcal{R}^{\theta}_\ell\llbracket V \rrbracket` se lit sur la
relation des valeurs (formule {num "eq:relation-logique"}[]) par la traduction : $`y` et $`y'` sont
les images de deux valeurs apparentées ; pour une localisation ou un canal dont le niveau est
$`\sqsubseteq \ell`, $`y' = \theta(y)` ; au-dessus de $`\ell`, la relation est totale. La clause de
réception quantifie sur toutes les extensions de $`\theta`, et c'est ce qui rend la relation stable :
si $`\theta \subseteq \theta'`, une paire apparentée sous $`\theta` l'est sous $`\theta'`, ce qui se
vérifie clause par clause. La définition est par récurrence sur $`S`, les types de valeur qui y
figurent relevant de la formule ({num "eq:relation-logique"}[]) pour leurs points fixes ; $`\mathsf{Chan}\;S`
ne contenant $`S` que comme sous-terme, la récurrence sur la paire $`(V, S)` est bien fondée.

Trois choses n'y sont pas écrites, et il faut les dire. La _délégation_, l'échange d'un canal de session
comme valeur ($`V = \mathsf{Chan}\;S'`), demande de relier aussi le processus qui tient l'autre
extrémité ; la clause ne traite que les données et les localisations. Le contenu des trois modalités
temporelles — ce que « après un délai » ou « à tout instant » veut dire à l'exécution — suppose une
horloge que la relation → n'a pas : la clause se borne à y comparer les fils, et la lecture de
$`\bigcirc`, $`\Box`, $`\Diamond` suit la lecture séquentielle retenue pour les formes temporelles, où
la durée d'attente n'est pas un pas de la relation (§{num "sec:g-semantique"}[]). Et la comparaison est _insensible à la terminaison_ : deux journaux
comparables pour le préfixe ne disent rien d'un progrès, et la version qui l'exclut est la deuxième
des incertitudes ci-dessous.

Les configurations de couche 2 s'apparentent de la même manière. Deux boîtes $`\mathcal{M}` et
$`\mathcal{M}'` sont $`\theta`-apparentées au niveau $`\ell` lorsque, pour toute paire
$`(\iota,\iota') \in \theta`, les multi-ensembles $`\mathcal{M}(\iota)` et $`\mathcal{M}'(\iota')`
sont en bijection par des messages d'étiquette égale et d'arguments apparentés, les localisations de
niveau $`\not\sqsubseteq \ell` n'étant pas contraintes. Le niveau d'une localisation est celui du calcul
qui l'a créée par {sc}[New], fixé à la création. Qu'un pas de la couche 2 conserve cet apparentement, en
étendant $`\theta` des localisations que {sc}[New] crée des deux côtés à un niveau $`\sqsubseteq \ell`,
est ce que l'induction du lemme fondamental doit établir : elle n'est pas conduite.

Le lemme fondamental (théorème {num "thm:lemme_fondamental"}[]) s'étendrait en conséquence à la strate
des sessions, ses cas nouveaux étant ceux des règles de communication, chacun appelant la clause
correspondante. _La non-interférence graduée et la divulgation délimitée restent donc bornées
au fragment sans communication_, le fragment avec communication n'ayant pas encore de règles démontrées.

# Les incertitudes, et ce qu'elles sont
%%%
tag := "g-sortes-les-incertitudes-et-ce-qu-elles-sont"
%%%

Quatre points ont été ouverts, et trois le restent ; l'enfilement du fil de temps et la précision de la
clause de session en ouvrent trois autres, numérotés à la suite. Aucun n'est une impossibilité, et ils se distinguent d'une difficulté
de preuve : ce sont des vérifications à conduire, dont l'échec obligerait à réviser une partie de ce
qui précède plutôt qu'à l'abandonner.

1. _Le niveau d'un effet ne doit dépendre du grade que par $`\varphi`._ C'est ce qui garantit que la
   sorte n'emporte rien de $`\mathcal{G}`. Si un autre chemin existait, l'effacement fuirait et le
   niveau devrait sortir de la sorte — auquel cas le second obstacle de la clause de session retomberait. _C'est la dette réelle de
   cette construction_, et la seule qui touche l'axiome.

2. _Le canal de l'ordre des messages._ La projection $`\pi^{\flat}_{\ell}` efface les événements
   au-dessus de $`\ell` et leur durée. Rien n'établit qu'elle ferme le canal formé par _l'ordre
   relatif_ des messages restants, qui est distinct de leur durée. La littérature récente sur le
   contrôle de flux en concurrence typée par sessions établit une non-interférence _sensible au
   progrès_ qui l'exclut ; il reste à vérifier si notre formulation en fait autant.

3. _Un seul niveau par processus_ — réglé. La littérature du domaine en emploie deux, une
   habilitation et un niveau courant. K7PL les a : l'habilitation est le niveau de lecture
   $`\mathrm{niv}(r)` des liaisons, le niveau courant est le niveau de production $`\hat\ell` porté
   par l'effet, et la jointure des niveaux de lecture, bornée par {sc}[Op] et {sc}[Case], est la
   règle de propagation. Il ne reste rien à vérifier ici.

4. _La mécanisation ne s'appuiera sur rien._ La méta-théorie du cadre emprunté n'est vérifiée par
   machine que pour une unique sorte de noms. Le cas d'un sortage arbitraire y est établi à la main,
   et ses auteurs signalent qu'un traitement mécanisé passant à l'échelle reste à faire. Notre
   conception a de nombreuses sortes. C'est une charge, non un obstacle.

5. _Les conditions de bonne formation du cadre emprunté n'ont pas été revérifiées pour le prédicat
   d'émission étendu._ La capacité qui transmet un maillon le long d'un fil, et la clause du
   transfert, ne dépendent que du genre et du niveau des sortes, ce qui laisse espérer qu'elles
   respectent l'équivariance sur les noms que le cadre exige ; la vérification n'est pas faite, et
   la clôture par substitution (théorème {num "thm:cloture_sortage"}[]) ne la remplace pas.

6. _L'énoncé du fil de temps ne couvre que le fragment qu'il nomme._ L'application, l'opération à
   portée et la couche 2 n'ont pas de clause de traduction du fil. Pour $`\mathsf{spawn}`, la question
   est de fond : le canal ambiant d'une fibrille engendrée ne peut venir ni du programme, qui n'en crée
   pas, ni de la mère, qui n'en transmet pas ; il vient du gestionnaire, par un protocole que le texte
   ne donne pas. Les opérations dont l'effet s'étend sur plusieurs niveaux n'ont pas de clause non
   plus.

7. _La clause de session ne traite ni la délégation ni la lecture des modalités temporelles._ La
   première demande de relier les deux extrémités d'un canal échangé ; la seconde dépend d'une horloge
   que la relation de réduction n'a pas (lecture séquentielle des formes temporelles, à ratifier).
