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

#doc (Manual) "Système de raffinement" =>
%%%
file := "c2-le-systeme-de-raffinement"
tag := "c2-le-systeme-de-raffinement"
%%%

{label "sec:c2-le-systeme-de-raffinement"}

Les quatre sections précédentes ont construit des objets qui, pris un à un, appartiennent au corpus
de la sémantique de la logique linéaire. Prises ensemble, elles font autre chose, et c'est ce que
cette section établit : elles sont les constituants d'un unique foncteur, dont trois dispositifs que
ce document obtenait séparément ne sont que trois lectures.

Le cadre est celui des systèmes de raffinement de types {cite "melliesFunctorsAreType2015"}[]. On y
part d'un foncteur $`p : \mathcal{D} \to \mathcal{T}`, où $`\mathcal{T}` est une catégorie de
_termes sous-jacents_ et $`\mathcal{D}` une catégorie de _dérivations_ au-dessus d'eux. Les objets
de $`\mathcal{D}` que $`p` envoie sur un même objet de $`\mathcal{T}` en sont les _raffinements_.
Ils forment la _fibre_ au-dessus de cet objet, et les morphismes de $`\mathcal{D}` que $`p` envoie
sur une identité y sont les morphismes _verticaux_ — ceux qui ne changent rien au terme et tout à ce
qu'on en sait.

Ce geste — indexer une famille par une base et raisonner fibre par fibre — est employé trois fois
dans ce document, et la parenté vaut d'être signalée puisqu'elle n'est pas une coïncidence. Les
fibres de ce système de raffinement en sont le premier emploi ; la famille d'effacements par niveau
de sécurité, construite ci-après, le deuxième ; et la gradation indexée des effets, que le chapitre
1 (§{num "sec:c1-axiomatique-germinale"}[]) vient de poser, le troisième. Cette dernière notion est
elle-même inspirée de la vue fibrée et destinée à donner la sémantique d'un système à raffinements {cite "kuraCategoryTheoreticFrameworkDependent2026"}[]
— c'est-à-dire de ce que le présent théorème établit être K7PL.

Ce que K7PL possède déjà est ce triplet. La catégorie des termes est celle du métalangage construit
au chapitre 4 (§{num "sec:c4-le-calcul-de-processus"}[]) ; celle des dérivations est faite des
jugements de K7PL, avec leurs composantes $`\mathcal{G}` et $`\mathcal{E}` ; et le foncteur est la
traduction $`\llbracket \cdot \rrbracket`, qui envoie une dérivation sur un processus sans emporter
ni les grades ni les effets. C'est cette dernière propriété — le foncteur oublie ce que la Phase 8
efface — qui fait de l'ensemble un système de raffinement et non une simple traduction.

::::thm (label := "thm:raffinement")
:::title
structure de raffinement
:::

:::statement +titled
Trois dispositifs, une seule structure

Soit $`\mathcal{T}` la catégorie du métalangage, $`\mathcal{D}` celle des dérivations de K7PL, et
$`\llbracket \cdot \rrbracket` la traduction du théorème {num "thm:traduction_metalangage"}[]. _Si_
$`\llbracket \cdot \rrbracket` est un foncteur préservant le typage — dette unique que ce théorème acquitte —, alors
$`(\mathcal{D}, \mathcal{T}, \llbracket \cdot \rrbracket)` est un système de raffinement de types,
et il s'ensuit que :

_(i)_ l'effacement de la Phase 8 est l'action de $`\llbracket \cdot \rrbracket` sur les objets ;

_(ii)_ la non-interférence du chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) est l'énoncé que
$`\mathcal{T}` ne distingue pas deux dérivations de même image ;

_(iii)_ la relation de précision $`\sqsubseteq`, restreinte aux objets d'une même fibre, est l'ordre
de cette fibre, et l'ordre de précision modal $`\mathrm{Unr} \sqsubseteq \mathrm{Aff} \sqsubseteq \mathrm{Lin}` en est la
restriction à la dimension d'usage.
:::

:::proofsketch
Que $`\llbracket \cdot \rrbracket` soit un foncteur est le contenu du
théorème {num "thm:traduction_metalangage"}[] : il envoie une composition de dérivations sur la
coupure correspondante et l'identité sur l'identité. La fibre au-dessus d'un type $`S` du
métalangage est faite des types de K7PL d'image $`S` ; deux tels types ne peuvent différer que par
ce que le foncteur n'emporte pas, c'est-à-dire par leurs grades et par les effets latents qu'ils
portent. Or c'est précisément sur ces dimensions que le
§{num "sec:c2-adjonctions-et-enrichissement"}[] définit $`\sqsubseteq`, et l'ordre annoncé y est
donc l'ordre de la fibre plutôt qu'une structure ajoutée. Les morphismes verticaux sont les
foncteurs d'inclusion du §{num "sec:c2-la-comonade-exponentielle-et"}[] : passer de
$`\mathrm{Lin}\,T` à $`\mathrm{Unr}\,T` ne change pas le terme, seulement ce qu'on s'autorise à en
faire, et l'inclusion se projette donc sur une identité.
:::
::::

S'il tient, il dispense de poser ce que le §{num "sec:c2-adjonctions-et-enrichissement"}[]
présentait comme un engagement structurel. {rmq}[Une seconde justification du sous-typage modal,
indépendante de la stratification et plus élémentaire qu'elle.] Sur la part qui compare des objets
d'une même fibre, l'ordre de précision cesse d'être un engagement. Il est ce qu'un système de
raffinement possède par construction, et le sous-typage modal, présenté au chapitre 1 comme une
conséquence de la stratification, en reçoit une seconde justification.

Il ne dispense pas de tout poser pour autant. L'enrichissement de K7PL est plus fort que l'ordre des
fibres : il étend $`\sqsubseteq` à tous les morphismes de _C_ et exige que la composition et le
tenseur soient monotones, ce qui est un énoncé sur la catégorie entière et non sur ses seules
fibres. Cette part-là demeure un engagement. Et s'il tombe — si la traduction
$`\llbracket \cdot \rrbracket` n'était pas un foncteur, ou emportait ce qu'elle est censée oublier
—, les trois lectures se disjoignent. L'effacement, la non-interférence et l'ordre de précision
redeviennent trois dispositifs à établir séparément.[^fn4]

[^fn4]: L'ensemble repose sur le théorème {num "thm:traduction_metalangage"}[], dont l'induction n'est qu'esquissée. Tant qu'elle n'est pas conduite, ce théorème hérite de la même réserve.

La clause du grade fini demande un mot, car elle a été choisie contre une autre qui paraissait plus
simple. Traduire une liaison de grade $`n` par $`n` canaux distincts eût été immédiat, et c'est ce
que le premier postulat interdit. Le produit tensoriel modélise la coexistence de ressources
_disjointes_, de sorte que $`n` canaux affirmeraient $`n` régions séparées là où la source ne décrit
qu'une ressource touchée $`n` fois. La traduction se serait trompée sur la topologie mémoire, et
l'aurait fait dans le sens qui compte. La ré-invocation séquentielle dit l'inverse et dit vrai : une
ressource, une région, $`n` emplois ordonnés. Elle satisfait du même coup les deux autres postulats
que la question engageait — l'allocation reste en $`O(1)` et statiquement bornée, et l'ordre des
emplois est fixé par construction plutôt que soumis à un choix qu'il faudrait journaliser. Le grade
demeure enfin du côté de ce que le terme _exige_, sans migrer dans la forme de ce qu'il _est_, ce
que la partition du jugement germinal réclame.

Une généralisation s'impose, que la lecture qui précède rend naturelle et que le chapitre 1
réclamait sans savoir la formuler. L'effacement de la Phase 8 est binaire : ce qui appartient à la
compilation disparaît, ce qui appartient à l'exécution demeure. C'est un treillis à deux points, et
rien n'oblige à s'y tenir. Si l'on se donne un treillis de niveaux $`(\mathcal{L}, \leq)` — celui-là
même sur lequel le §{num "sec:c2-adjonctions-et-enrichissement"}[] fait porter la modalité de
confidentialité —, le foncteur unique devient une _famille indexée_
$`\{\llbracket \cdot \rrbracket_\ell\}_{\ell \in \mathcal{L}}`, celui d'indice $`\ell` retirant tout
ce qui est gradué au-dessus de $`\ell` et conservant le reste. La distinction de phase en est
l'instance à deux points, la compilation étant le niveau haut et l'exécution le niveau bas.

Ce déplacement a une conséquence qui vaut d'être dite, car elle change ce qu'un énoncé de sécurité
doit prouver. La non-interférence cesse d'être une propriété unique pour devenir une famille : pour
chaque $`\ell`, deux dérivations de même image sous $`\llbracket \cdot \rrbracket_\ell` sont
indiscernables par un observateur de niveau $`\ell`. L'effacement de la Phase 8 en est le cas où
$`\mathcal{L}` n'a que deux points, et la confidentialité le cas où il en a davantage — un seul
mécanisme, deux emplois. Ce document ne conduit pas la preuve de cette famille d'énoncés ; il en
fixe la forme, qui est la moitié du travail et celle qui décide de l'autre.

Il désigne en revanche la voie, car trois sont disponibles et leur coût diffère. La _paramétricité_
est celle qui réemploie le plus de ce qui précède. Elle produit des théorèmes utiles sur les
programmes à partir de leurs seuls types, sans rien devoir à leur contenu. Une preuve de
non-interférence en a été tirée pour une variante du calcul de dépendance auquel le chapitre 1
(§{num "sec:c1-postulats"}[]) rattache la confidentialité, par une construction modulaire s'appuyant
sur l'encodage de l'abstraction de données au moyen de types _existentiels_ {cite "algehedSimpleNoninterferenceParametricity2019"}[].

K7PL possède ces existentielles et en fait déjà le moyen de cacher un témoin (chapitre 3,
§{num "sec:c3-structures-ouvertes-effets-et"}[]). Il ne manque que le lien : la paramétricité
transforme l'abstraction en indiscernabilité, et l'indiscernabilité _est_ la non-interférence. Un
énoncé obtenu de cette façon serait le quatrième de même espèce dans ce document, après la
terminaison, la productivité et la monotonie — tous portés par les types, aucun par une inspection
du terme.

::::thm (label := "thm:non_interference")
:::title
non-interférence graduée, fragment séquentiel
:::

:::statement +titled
Une famille d'énoncés, un par niveau

Pour tout niveau $`\ell \in \mathcal{L}` et toutes dérivations $`d_1, d_2` de même image sous
$`\llbracket \cdot \rrbracket_\ell`, les termes sous-jacents sont observationnellement équivalents
pour un observateur de niveau $`\ell`. En particulier, aucune valeur graduée en
$`\ell' \not\leq \ell` n'influence ce qu'un tel observateur distingue.
:::

:::proofsketch
La voie est celle de la paramétricité, et l'argument tient en trois pas. Le premier consiste à lire
la modalité $`!_\ell` comme une abstraction de données : une valeur graduée en $`\ell` est une
valeur dont la représentation est cachée à qui n'atteint pas $`\ell`, ce qui s'encode par un type
existentiel. Le deuxième pas est la paramétricité elle-même, qui associe à chaque type une relation
et garantit que tout terme bien typé préserve cette relation, sans que le contenu du terme
intervienne. Le troisième est le choix de la relation : on prend, à chaque niveau $`\ell`,
l'identité sur ce qui est gradué en deçà de $`\ell` et la relation totale au-delà. Un terme bien
typé préservant cette relation ne peut alors faire dépendre sa partie basse de sa partie haute, ce
qui est l'énoncé.
:::
::::

Cet énoncé porte sur le fragment séquentiel, et il faut dire pourquoi il ne s'étend pas de lui-même.
_La non-interférence séquentielle ne survit pas à la concurrence._ Deux calculs qui ne se
distinguent par aucune valeur peuvent se distinguer par le _moment_ où ils rendent la main : un
secret qui gouverne la durée d'une branche gouverne l'ordre dans lequel l'ordonnanceur sert les
autres, et cet ordre est observable. L'ordonnanceur entre donc dans le modèle d'attaquant, ce qu'un
énoncé sur les seules valeurs ne peut pas voir. {rmq}[Le secret ne fuit pas par ce qui est calculé
mais par quand cela l'est. Aucune relation sur les valeurs ne l'attrape.]

La notion qui lui succède sous concurrence est le _déterminisme observationnel_ : pour un niveau
donné, deux entrelacements d'un même ensemble de calculs bien typés ont la même projection à ce
niveau. Elle est strictement plus forte, et elle n'est pas un corollaire de la précédente.

::::thm (label := "thm:determinisme_observationnel") (status := "conjecture")
:::title
déterminisme observationnel
:::

:::statement +titled
L'entrelacement ne dit rien de plus que les valeurs

Soit $`\mathcal{S}` une politique d'ordonnancement, et $`\mathcal{P}` un multi-ensemble de calculs
bien typés. Sous l'hypothèse $`\mathcal{D}_{\mathcal{S}}` — la politique ne consulte aucune valeur
de niveau $`\ell' \not\leq \ell` —, deux exécutions de $`\mathcal{P}` qui diffèrent par le seul
entrelacement ont la même projection $`\pi_\ell(\tau)` de leur trace.
:::

:::proofsketch
Non conduite. La voie est la bisimulation : montrer que la relation « même projection au niveau
$`\ell` » est préservée par chaque pas de réduction, pour chacune des cinq règles globales du §{num "sec:g-regles"}[]. Les quatre premières s'y prêtent, leur effet sur la trace étant local. {sc}[Guard] est le
cas qui résiste, puisqu'il choisit une branche en fonction d'un message dont le niveau peut excéder
$`\ell`.
:::
::::

L'hypothèse $`\mathcal{D}_{\mathcal{S}}` est nommée plutôt que supposée, et c'est délibéré. Le
déterminisme observationnel sous ordonnanceur quelconque est un problème ouvert, et le promettre
sans hypothèse serait promettre ce qu'on ne sait pas tenir. Ce document énonce donc la propriété
_sous une politique déclarée_, exactement comme il conditionne le rejeu binaire à un environnement
reproductible — deux hypothèses de même nature, portées par l'exécution et non par le langage, et
nommées toutes deux.

Ce que cela coûte est inscrit : la divulgation délimitée et la non-interférence, qui étaient deux
théorèmes du fragment séquentiel, ne couvrent plus la couche 2 ni la couche 1. Ce que cela gagne est
qu'aucune des deux ne prétend les couvrir.

Deux autres voies étaient disponibles — relations logiques mécanisées, normalisation — et rien
n'oblige à celle-ci sinon l'économie. {rmq}[Le quatrième énoncé de la même espèce, et non un
raisonnement d'une autre nature greffé sur les trois premiers.] La paramétricité tire ses théorèmes
des seuls types, ce qui est la position que ce document tient pour la terminaison, la productivité
et la monotonie. Elle emploie en outre des existentielles que K7PL possède, et elle a été conduite
sur une variante du calcul de dépendance auquel le chapitre 1 rattache la confidentialité {cite "algehedSimpleNoninterferenceParametricity2019"}[].

L'esquisse ne conduit pas la preuve, et trois points y résisteraient. Le choix de la relation doit
être vérifié compatible avec le produit du grade (§{num "sec:c2-adjonctions-et-enrichissement"}[]) :
une relation par facteur ne donne pas automatiquement une relation sur le produit. Les effets, qui
ont désormais une image dans le métalangage (chapitre 4, §{num "sec:c4-le-calcul-de-processus"}[]),
demandent que la relation s'étende aux communications sur les canaux distingués, faute de quoi
l'énoncé ne couvrirait pas les fuites par le temps. Et la déclassification en est une exception
délibérée, dont le théorème {num "thm:divulgation_delimitee"}[] donne la mesure : l'énoncé ci-dessus
vaut des programmes sans échappatoire, celui-là des programmes qui en ont. S'il tient, la
non-interférence de K7PL devient une famille indexée par le treillis, dont l'effacement de la Phase
8 est l'instance à deux points. S'il tombe, chaque niveau de confidentialité demande son propre
argument, et la gradation ne fait plus l'économie qu'elle promet.

Une conséquence de méthode se lit sur cette structure, et elle vaut pour la suite du document. Les
raffinements de valeur du chapitre 3 (§{num "sec:c3-les-contraintes-de-valeur"}[]) — un entier dont
on sait qu'il est positif, un tableau dont on sait la taille — sont l'instance éponyme de ce cadre,
et non un mécanisme parallèle : ils habitent les mêmes fibres, au-dessus des mêmes termes. Il en va
de même des bornes de coût que le chapitre 1 loge dans la strate des obligations. Une proposition
sur un résultat est un raffinement au sens strict, et la troisième strate du jugement germinal est
cette fibre lue comme un lieu où déposer des propositions. Le langage n'a donc pas trois façons de
dire quelque chose de plus sur un terme — il en a une, employée à trois hauteurs.
