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
\text{(genres)}\quad g &::= \mathsf{prog} \mid \mathsf{operation}_a \;(a \in \mathrm{Ops}) \mid \mathsf{temps}\\
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
$`\langle \mathsf{temps}, \ell \rangle`.

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
  * $`\mathrm{gen}(t) = \mathsf{prog}` et $`\mathrm{niv}(t) \sqsubseteq \mathrm{niv}(s)`
  * on ne transmet jamais qu'un nom de programme, et jamais vers un canal plus bas que lui
* * recevoir $`s \mathbin{\propto^+} t`
  * idem
  * dual
* * substituer $`s \mathbin{\#} s'`
  * $`s = s'`
  * la substitution ne change jamais une sorte
* * restreindre $`\mathcal{S}_\nu`
  * $`\mathcal{S}_\nu = \mathcal{S}_{\mathsf{prog}}`
  * *un programme ne peut pas créer de canal d'effet*
:::
::::

Les deux dernières lignes portent tout, chacune pour une raison distincte.

_La restriction_ est le confinement lui-même. Un canal distingué n'est pas créé par un programme :
il est fourni par la configuration ambiante, et le gestionnaire d'effet est le processus qui
l'offre. Poser $`\mathcal{S}_\nu = \mathcal{S}_{\mathsf{prog}}` dit exactement cela, et le dit en
une clause vérifiable plutôt qu'en une phrase. Avec la première ligne — on ne transmet qu'un nom de
programme — un terme traduit ne peut ni _créer_ ni _recevoir_ un nom d'effet : il ne peut donc en
mentionner aucun qu'il n'ait reçu de la traduction elle-même.

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

:::caption
Le jugement de bon sortage. Les trois premières clauses sont celles du cadre emprunté ; la quatrième
est propre à K7PL, dont les motifs de jonction ne relèvent pas de la communication binaire.
:::
::::

La quatrième clause est l'endroit où l'on sort du cadre emprunté, et il faut le dire. Ce cadre est
un cadre de communication _binaire_ ; ses auteurs signalent qu'ils héritent du $`\pi`-calcul
l'encodage du join-calculus plutôt que d'en traiter les primitives. Or K7PL tient l'atomicité d'un
motif de jonction pour primitive — c'est une transition de réseau de Petri consommant plusieurs
places d'un seul tenant, et c'est P1 qui le veut. On ajoute donc la clause, _qui est une conjonction
de la deuxième_, et l'on redémontre ci-dessous ce que l'on n'hérite plus.

::::lemma (label := "thm:cloture_sortage") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "graded-typing")
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
$`\mathrm{sort}(\sigma x) = \mathrm{sort}(x)`. Les quatre clauses ne portent que sur des sortes de
noms, et leurs prémisses sont donc littéralement inchangées.

Le cas de la jonction ne demande rien de plus que le cas de la réception, dont il est une
conjonction : si chacune des $`n` prémisses est préservée, leur conjonction l'est. _C'est le
dividende du choix de prendre $`\#` discrète_ : le cadre général n'exige de la substitution qu'elle
raffine la sorte, ce qui obligerait à vérifier que le raffinement traverse chaque clause ; l'égalité
rend la vérification vide.
:::

::::
::::lemma (label := "thm:confinement_sortes") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "graded-typing")
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
traduit ne mentionne que la sorte $`\mathsf{prog}`, et le bon sortage est celui d'un terme sans
effet.

_Couche 1 — un seul cas._ Le seul effet ordinaire y est $`\mathbf{tick}`, et l'usage courant y est
mononiveau ; le théorème {num "thm:temps_mononiveau"}[] fait alors s'effondrer la famille
temporelle, et les sortes en présence se réduisent à
$`\{\langle \mathsf{prog},\ell\rangle, \langle \mathsf{temps},\ell\rangle\}` pour un unique $`\ell`.

_Couche 2 — tous les cas._ C'est le seul lieu où l'obligation a un contenu. Les règles structurelles
et les connecteurs n'engendrent que des noms de genre $`\mathsf{prog}`, restreignables par
$`\mathcal{S}_\nu` ; la modalité graduée aussi, un service répliqué comme un canal linéaire portant
la même sorte. Le cas de $`\mathsf{operation}_\varepsilon(v)` est celui qui produit une émission sur
un canal distingué : la clause d'émission demande
$`\mathrm{gen}(\llbracket v \rrbracket) = \mathsf{prog}`, ce que fournit l'hypothèse d'induction, et
$`\mathrm{niv}(\llbracket v \rrbracket) \sqsubseteq \ell`, ce que fournit l'étiquetage $`\varphi` —
le calcul qui produit l'effet étant de niveau $`\ell`, tout ce qu'il possède l'est aussi. Le cas des
opérations à portée passe par la ré-invocation séquentielle, qui ne crée pas de nom nouveau.

_La conclusion négative_ se lit alors sur la seule clause de restriction. Aucune règle de la
traduction ne produit un $`(\nu a)` avec $`\mathrm{gen}(a) \neq \mathsf{prog}`, faute de quoi la
clause échouerait ; et la clause d'émission interdit qu'un tel nom soit transmis. Un canal distingué
ne peut donc entrer dans un terme traduit que par son contexte, c'est-à-dire par le gestionnaire qui
l'offre.
:::

::::
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

Le lemme fondamental (théorème {num "thm:lemme_fondamental"}[]) s'étend en conséquence à la strate
des sessions, ses cas nouveaux étant ceux des règles de communication, chacun réglé par la clause
correspondante. _La non-interférence graduée et la divulgation délimitée restent donc bornées
au fragment sans communication_, le fragment avec communication n'ayant pas encore de règles démontrées.

# Les incertitudes, et ce qu'elles sont
%%%
tag := "g-sortes-les-incertitudes-et-ce-qu-elles-sont"
%%%

Quatre points ont été ouverts, et trois le restent. Aucun n'est une impossibilité, et ils se distinguent d'une difficulté
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
