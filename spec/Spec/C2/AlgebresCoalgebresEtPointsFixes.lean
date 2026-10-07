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

#doc (Manual) "Algèbres, coalgèbres et points fixes" =>
%%%
file := "c2-algebres-coalgebres-et-points"
tag := "c2-algebres-coalgebres-et-points"
%%%

{label "sec:c2-algebres-coalgebres-et-points"}

Terminaison et productivité sont, du point de vue catégorique, la même idée lue deux fois — une fois
dans _C_, une fois dans _C_ opposée. Cette section construit les deux points fixes qui portent
respectivement ces deux garanties : l'algèbre initiale, qui fonde la terminaison des calculs finis
de la couche 3, et la coalgèbre terminale, qui fonde la productivité des flux et des acteurs de la
couche 2.

Soit $`F : \mathcal{C} \to \mathcal{C}` un endofoncteur. Une $`F`-algèbre est un couple
$`(A, \alpha : F(A) \to A)` ; un morphisme de $`F`-algèbres $`(A,\alpha) \to (B,\beta)` est une
flèche $`f : A \to B` telle que $`f \circ \alpha = \beta \circ F(f)`. Lorsqu'elle existe, l'algèbre
initiale $`\mu F` — munie de sa structure $`\text{in} : F(\mu F) \to \mu F`, qui est un isomorphisme
(lemme de Lambek) — est initiale parmi les $`F`-algèbres : pour toute algèbre $`(A,\alpha)`, il
existe un unique morphisme d'algèbres de $`\mu F` vers $`A`, le catamorphisme induit par $`\alpha`,
caractérisé par

::::formula (label := "eq:catamorphisme") (kind := "equation")
```
\begin{equation}
\text{cata}(\alpha) \circ \text{in} = \alpha \circ F(\text{cata}(\alpha)).
\end{equation}
```
::::

Pour $`F(X) = I \oplus (A \otimes X)`, $`\mu F` est le type des listes finies de $`A` et
$`\text{cata}(\alpha)` n'est autre que le pli usuel. C'est ce schéma, dans la forme générale que
l'esquisse ci-après précise, que la couche 3 autorise comme unique forme de récursion. Parce que
$`\mu F` n'est construite qu'à partir des constructeurs finis portés par $`F`, tout catamorphisme
termine en un nombre d'étapes borné par la taille de son argument. La terminaison n'est pas vérifiée
après coup : elle est une conséquence de l'initialité.

Le catamorphisme ne suffit pas à porter cette récursion. Dès qu'un type imbriqué apparaît — un type
paramétré dont la récursion s'accompagne d'un changement du paramètre, ce dont `Incomplete A B` est
le cas limite —, le pli ordinaire ne décrit plus que des transformations naturelles, limitation trop
étroite pour l'usage {cite "birdGeneralisedFoldsNested1999"}[]. K7PL retient donc la forme générale,
le pli dépendamment typé : il est défini par récursion bien fondée, existe pour tout type imbriqué,
ne dépend d'aucune fonction `map`, et se spécialise en le pli d'ordre supérieur traditionnel {cite "fuDependentlyTypedFolds2018"}[].
Le catamorphisme de l'équation {num "eq:catamorphisme"}[] en demeure le cas particulier, celui où le
paramètre ne change pas. Ce dispositif porte à lui seul ce que le langage obtenait par trois —
l'itération, le principe d'induction qui découle de sa définition, et la vérifiabilité formelle des
programmes ainsi définis {cite "fuDependentlyTypedFolds2018"}[] —, ce qui sert la condition de
clôture du chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]).

Ce choix place K7PL en dehors d'une classification reçue. {rmq}[Deux généralisations du même pli
ordinaire, qui se rencontrent en bas et divergent en haut. Aucune ne contient l'autre.] La
littérature a unifié un large zoo de schémas de récursion sous le _pli adjoint_, paramétré par une
adjonction et une loi distributive, et le pli généralisé de Bird et Paterson figure parmi les
schémas ainsi subsumés {cite "hinzeUnifyingStructuredRecursion2016"}[]. Le pli de K7PL n'en est pas
une instance, et pour une raison qui tient en un mot : une adjonction est faite de foncteurs, donc
de fonctions `map`, quand le pli dépendamment typé n'en dépend d'aucune. L'une donne l'accès au zoo,
l'autre donne les types imbriqués, et K7PL a retenu la seconde parce que c'est celle dont il a
besoin.

Une question reste alors ouverte que la classification par le pli adjoint ne pose pas : combien de
schémas sont primitifs, et lesquels se dérivent. La réponse est deux. La récursion primitive et la
récursion nœthérienne sont les deux structures, chacune munie de son principe d'induction, et les
schémas complexes se composent à partir d'elles pour une large classe de types {cite "downenStructuresStructuralRecursion"}[].
Ce résultat est guidé par la dualité, et chaque structure de récursion y a une forme duale, donnant
des paires parfaitement symétriques de types de données et de co-données. Ce document en tire
directement sa primitive de production : la duale de la récursion primitive est la corécursion
primitive, et c'est elle que la couche 2 emploie sans l'avoir nommée. Deux primitives et non un zoo,
avec les schémas nommés comme compositions — c'est la forme d'économie que la condition de clôture
du chapitre 1 réclame.

Une seconde lecture de la même source referme une question que la première laissait ouverte, et la
réponse est négative. Cette source obtient les schémas issus de comonades — dont l'histomorphisme
employé plus bas — par les deux dérivations canoniques d'adjonctions à partir des comonades. Les
catamorphismes monadiques viennent de la construction de Kleisli, et les schémas issus de comonades
de celle d'Eilenberg–Moore. Ce chapitre construisant une comonade exponentielle graduée et sa
structure de Kleisli graduée, on pourrait croire l'histomorphisme dérivable de $`!_r`. Il ne l'est
pas : la comonade qu'un tel schéma demande est la comonade cofree du foncteur de motif, celle qui
accumule l'historique, quand $`!_r` est la modalité d'usage. Deux comonades, deux rôles, et aucune
raison qu'elles se confondent.

Le critère de terminaison, lui, ne peut pas être une mesure structurelle décroissante. La profondeur
restante de $`x` n'est pas disponible sur un type imbriqué, l'appel récursif y portant sur une autre
instance du paramètre : la mesure n'a plus de domaine fixe et sa décroissance ne signifie plus rien.
La garantie doit donc reposer sur les types seuls, ce que la littérature nomme terminaison fondée
sur les types {cite "matthesRecursionNestedDatatypes2008"}[]. K7PL l'adopte à peu de frais : une
taille est un ordinal, un ordinal est un grade, et $`\mathcal{R}`
(§{num "sec:c2-la-comonade-exponentielle-et"}[]) porte déjà $`\omega`. Le peu de frais a toutefois
un prix, et c'est une clause de bonne formation qu'il faut écrire plutôt que supposer. Il y a _deux
sortes de tailles_, et les confondre est l'erreur que la clause doit écarter. {rmq}[Une sorte par
polarité. Ce n'est pas une prudence ajoutée : c'est la distinction que la dualité impose, et qu'on
avait manquée.]

$$`\mathbb{S}_\mu \;=\; \mathbb{N}_\infty \setminus \{\omega\} \qquad\qquad \mathbb{S}_\nu \;=\; \mathbb{N}_\infty`

La _taille inductive_ $`\mathbb{S}_\mu` exclut $`\omega`, et la raison tient en une ligne : un ordre
strict bien fondé est irréflexif, de sorte que $`\omega < \omega` est faux, quand un plus grand
élément employé comme taille inductive demanderait précisément qu'il soit vrai. Elle gouverne le
pli, le dépli et la hauteur des treillis finis.

La _taille coinductive_ $`\mathbb{S}_\nu` retient $`\omega`, et c'est ce qui la rend utile. Le côté
coinductif ne demande pas une bien-fondation mais sa duale : un plus grand élément absorbant le
décrément, $`\omega \ominus 1 = \omega`. Un flux qui ne s'arrête jamais porte la taille $`\omega`,
en rend une observation à chaque pas, et reste de taille $`\omega` après. Les rationnels sont exclus
des deux sortes, leur ordre strict n'étant bien fondé dans aucun sens.

La clause qui importe n'est donc pas l'exclusion de $`\omega`, c'est la _disjonction_ : *aucun type
ne porte les deux sortes*. C'est exactement la leçon de la source qui motive la prudence — un
assistant de preuve majeur partage une seule sorte de taille entre les deux polarités, et l'on y
construit depuis dix ans un type à la fois inductif et coinductif dont se tire une preuve du type
vide {cite "agdadevelopersAgdaSizedTypes2026"}[]. Le défaut y est le partage, non l'infini. Un grade
quelconque n'est pas une taille recevable, et c'est cette clause — non l'appartenance à
$`\mathcal{R}` — que le théorème de progression invoque, dans chacune de ses deux instances et selon
la sorte qui lui revient. Le paramorphisme linéaire — pli donnant accès à la fois au résultat
récursif et à la sous-structure d'origine {cite "seflProgrammingDependentAdditive2025"}[] — entre
sous le même critère, sa taille décroissant identiquement.

::::thm (label := "thm:terminaison_couche_3")
:::title
terminaison de la couche 3 — l'instance inductive
:::

:::statement +titled
Terminaison par pli dépendamment typé

Soit $`F` un conteneur représentant les structures de données finies de couche 3. Pour toute
fonction $`f : \mu F \to A` obtenue comme pli dépendamment typé, l'évaluation de $`f` sur tout
$`x : \mu F` atteint une forme normale en un nombre fini d'étapes :
$`\forall f : \mu F \to A,\ \forall x : \mu F,\ \exists k \in \mathbb{N},\ \exists v,\ f(x) \leadsto^k v`.
:::

:::proofsketch
La couche 3 interdit la récursion générale, et toute itération s'y exprime comme un pli dépendamment
typé sur $`\mu F`, plus petit point fixe du conteneur $`F`, dont les habitants sont bien fondés par
construction. Le type du pli porte un indice de taille $`i`, et celui de l'appel récursif un indice
strictement inférieur. C'est l'hypothèse du théorème {num "thm:progression_polarisee"}[], dont cet
énoncé est l'instance en $`p = \mu` ; l'argument général y est conduit une fois et n'est pas repris
ici. Ce qui est propre à cette instance est le domaine : la décroissance porte sur des types
imbriqués, où aucune mesure structurelle n'est disponible, et c'est ce que le pli dépendamment typé
achète. Le paramorphisme linéaire est admis au même titre.
:::
::::

S'il tient, la terminaison de la couche 3 cesse d'être une obligation de preuve séparée : elle
devient une lecture du jugement de typage, et la Phase 4 de la compilation
(§{num "sec:c6-le-processus-de-compilation"}[]) n'a rien à vérifier que le typage n'ait déjà établi.
S'il tombe — si un pli dépendamment typé pouvait porter un indice décroissant sans terminer —, la
couche 3 devrait revenir à un critère syntaxique d'arguments plus petits, lequel n'est pas
disponible sur les types imbriqués. Le langage perdrait alors soit les types imbriqués, soit la
terminaison garantie ; c'est le prix exact de ce théorème, et il n'y a pas de troisième terme.

Ce chapitre établit la correction de son interprétation et non sa complétude, et la distinction
n'est pas anodine. Sur une extension naturelle de la catégorie linéaire, l'interprétation immédiate
manque de complétude, et la recouvrer suppose d'exploiter les propriétés comonadiques de
l'exponentielle {cite "gaboardiWhatModelSemantically2014"}[]. Ce que la complétude apporterait se
dit, puisqu'elle n'est pas prise en charge ici : elle établirait qu'un morphisme de _C_ qui n'est
l'image d'aucun terme n'existe pas, donc que le modèle ne contient rien que le langage ne sache
écrire. Sans elle, la correction garantit que tout programme accepté a un sens, non que tout sens
exprimable dans le modèle corresponde à un programme — ce qui suffit à ce que ce document fait, et
ne suffirait pas à en tirer un résultat de définissabilité.

Deux constructions du langage vont porter le même nom sans être le même objet, et mieux vaut poser
la distinction ici. {rmq}[Le même nom, deux existences. L'une tient à la forme d'un foncteur,
l'autre à la complétude d'un ordre.] Le $`\mu F` de cette section est le plus petit point fixe d'un
foncteur. Une algèbre initiale, dont les habitants sont des arbres finis et dont l'existence tient à
la positivité stricte du conteneur. Le chapitre 4 emploiera un autre plus petit point fixe, celui
d'une fonction monotone d'un type dans lui-même, qui n'est pas une algèbre initiale mais la limite
d'une chaîne croissante dans un ordre. Son existence tient à la complétude de cet ordre et non à la
forme d'un foncteur, et sa terminaison à une propriété métrique — la hauteur — plutôt qu'à la bonne
fondation d'une structure. Les deux sont des points fixes et des plus petits, et là s'arrête la
ressemblance. Le §{num "sec:c2-adjonctions-et-enrichissement"}[] construit le second.

Dualement, une $`F`-coalgèbre est un couple $`(A, \alpha : A \to F(A))` ; un morphisme de
$`F`-coalgèbres $`(A,\alpha) \to (B,\beta)` est $`f : A \to B` tel que
$`F(f) \circ \alpha = \beta \circ f`. La coalgèbre terminale $`\nu F` — munie de
$`\text{out} : \nu F \to F(\nu F)`, isomorphisme dual du lemme de Lambek — est terminale parmi les
$`F`-coalgèbres : pour toute coalgèbre $`(A,\alpha)`, il existe un unique morphisme de coalgèbres de
$`A` vers $`\nu F`, l'anamorphisme induit par $`\alpha`, caractérisé par

::::formula (label := "eq:anamorphisme") (kind := "equation")
```
\begin{equation}
\text{out} \circ \text{ana}(\alpha) = F(\text{ana}(\alpha)) \circ \alpha.
\end{equation}
```
::::

Pour $`F(X) = A \otimes X`, $`\nu F` est le type des flux infinis de $`A` et $`\text{ana}(\alpha)`
engendre le flux élément par élément depuis un état initial.

Le théorème qui précède porte sur une couche prise isolément. Or la thèse du chapitre 1 n'est pas
que les couches existent séparément, c'est qu'elles s'emboîtent : du fini pur à l'intérieur de
l'infini productif. Cet emboîtement demande son propre énoncé, et il n'est pas gratuit — sur des
points fixes imbriqués, approcher l'objet en itérant sur l'un des deux seulement ne converge pas, et
il faut itérer sur les deux simultanément {cite "kurzApproximationNestedFixpoints2015"}[]. Deux
propriétés y pourvoient. Les conteneurs préservent les plus petits et les plus grands points fixes
(§{num "sec:c2-adjonctions-et-enrichissement"}[]) {cite "damatoFormalisingInductiveCoinductive2024,altenkirchIndexedContainers2015"}[],
de sorte que l'emboîtement ne sort pas de la classe où le théorème précédent a été établi. Et une
version coalgébrique du lemme de Bekič réduit le système simultané à un point fixe unique, dont
l'objet visé est la coalgèbre finale {cite "kurzApproximationNestedFixpoints2015"}[].

::::thm (label := "thm:sedimentation")
:::title
bonne définition de la sédimentation
:::

:::statement +titled
Convergence des points fixes imbriqués

Soient $`F` et $`G` des conteneurs, $`F` engendrant les structures finies de couche 3 et $`G` l'état
des générateurs de couche 2. Alors l'objet $`\nu Y.\, G(\mu X.\, F(X,Y))` est bien défini, et la
suite de ses approximations finies converge vers lui. Cet énoncé vaut en deux temps : (i) pour des
conteneurs _non gradués_, résultat de la littérature, repris ici ; (ii) pour des conteneurs
_gradués_, c'est une exigence ouverte, dont la route est une démonstration et dont la contrainte
d'outil est nommée (note ci-dessous).
:::

:::proofsketch
Les conteneurs préservant les deux points fixes, $`\mu X.\, F(X,Y)` est encore un conteneur en $`Y`,
et $`\nu Y.\, G(-)` appliqué à celui-ci reste dans la classe. Reste la convergence, qui ne se déduit
pas de l'itération sur un seul des deux points fixes : elle s'obtient en traitant le système comme
simultané, sa réduction à un point fixe unique donnant l'objet visé pour coalgèbre finale, limite de
ses approximations finies.
:::
::::

S'il tient, c'est lui — et non la juxtaposition des énoncés par couche — qui autorise le chapitre 1
à parler de sédimentation : l'emboîtement est un objet, pas une figure de style. S'il tombe, les
deux couches restent l'une et l'autre bien fondées, mais rien ne garantit plus que leur emboîtement
le soit, et la sédimentation redevient une thèse à établir cas par cas.

La préservation invoquée ici a été établie deux fois, et les deux cadres ne se recouvrent pas. {rmq}[Le
résultat existe, la version graduée n'existe pas encore. C'est là que ce document met sa demande.]
Le second l'obtient dans la catégorie sauvage des types, c'est-à-dire sans supposer l'unicité des
preuves d'identité {cite "altenkirchIndexedContainers2015"}[], de sorte que la réserve qu'on
pourrait opposer — celle d'une extensionnalité postulée — tombe. Ce qui ne tombe pas est que ces
résultats valent sur des types et non sur des types gradués. La transposition à la gradation reste à
faire, et c'est ce que ce document demande.[^fn1]

[^fn1]: La technique qui rend la preuve possible est le type de chemin d'une théorie cubique, que l'assistant visé au chapitre 6 n'offre pas.

Un schéma manque encore, et il est celui que la couche 2 exécute le plus souvent. Un gestionnaire
d'acteur consomme un flux de messages et le replie en un état fini : c'est un anamorphisme suivi
d'un catamorphisme, autrement dit un _hylomorphisme_ — la généralisation commune des deux, dont les
formes simples ne sont que des cas particuliers {cite "yangFantasticMorphismsWhere2022"}[]. Sa
terminaison ne découle ni du premier théorème, dont l'entrée n'est pas bien fondée, ni du second,
dont la sortie n'est pas un flux. Elle vient d'ailleurs, et K7PL en dispose déjà : un gestionnaire
traite un message par activation, et le nombre d'activations par tour d'ordonnancement est borné par
un grade $`r` (chapitre 4, §{num "sec:c4-echelle-locale"}[]). L'hylomorphisme de couche 2 est donc
borné par un grade — ce qui est exactement P3, appliqué au schéma de récursion plutôt qu'à
l'allocation.

La productivité coinductive qu'exige la couche 2 des flux et des acteurs — produire une valeur
observable en temps fini, même si le calcul dans son entier ne termine jamais — est la garantie
duale de la terminaison : à chaque étape, $`\text{out}` expose un élément de $`F(\nu F)` sans qu'il
soit nécessaire d'avoir épuisé $`\alpha`. C'est cette construction que le chapitre 1 anticipait en
définissant un acteur distribué comme une coalgèbre terminale $`\nu G` sur son espace d'état.
L'espace d'état joue le rôle de $`A`, et $`G` décrit, pour chaque état, l'observation immédiate
qu'il produit et l'état suivant qu'il détermine.

Les flux infinis de couche 2 sont modélisés par $`\nu G`, le plus grand point fixe du conteneur
$`G`, pris dans $`\mathcal{C}` et non dans une catégorie cartésienne — ce qui n'est pas un détail,
puisque les flux de K7PL transportent des ressources et non des valeurs pures, un message consommé
ne pouvant l'être deux fois. Ce sont donc des flux monoïdaux, au sens où les flux ordinaires donnent
une sémantique au flot de données avec fonctions pures quand leur généralisation monoïdale la donne
pour des théories de processus {cite "dilavoreMonoidalStreamsDataflow2022"}[].

Le critère de progression y est le dual exact de celui de la terminaison, et pour la même raison :
un gardiennage purement syntaxique — exiger que l'appel corécursif soit précédé d'un `yield` — n'est
pas compositionnel, puisqu'il interdit à une occurrence corécursive d'apparaître sous une opération
définie antérieurement {cite "xieConaturalNumbersForm2025"}[], c'est-à-dire sous n'importe quel
combinateur défini par l'utilisateur. Or la couche 2 est d'ordre supérieur et composable, et la
restriction y mordrait sur le cas courant plutôt que sur l'exception. K7PL retient donc un critère
porté par les types : le type du flux est indexé par une taille, et le `yield` fait décroître cet
indice au sens dual, chaque observation consommant une unité de profondeur d'approximation. C'est la
formulation par types dimensionnés, sur laquelle repose le traitement coinductif usuel des automates
et des langages formels, et qui s'accompagne du filtrage par copatrons comme forme définitionnelle
naturelle du `yield` {cite "ABEL-COALG"}[].

::::thm (label := "thm:productivite_couche_2")
:::title
productivité de la couche 2 — l'instance coinductive
:::

:::statement +titled
Progression par anamorphisme typé

Soit $`G` un foncteur représentant l'état d'un générateur de flux de couche 2, par exemple
$`G(X) = A \otimes X`. Un flux $`s : S \to \nu G` obtenu comme anamorphisme, dont le type porte un
indice de taille décroissant au sens dual, produit une valeur observable en un nombre fini d'étapes.
:::

:::proofsketch
Instance en $`p = \nu` du théorème {num "thm:progression_polarisee"}[], l'argument étant le même lu
dans $`\mathcal{C}^{\text{op}}`. Ce qui est propre à cette instance est la conclusion : le type de
$`s` est indexé par une taille, chaque `yield` en fait décroître l'indice au sens dual, et déplier
$`\nu G` produit donc au moins un élément de $`G(\nu G)` avant tout appel récursif ultérieur. C'est
une observation en temps fini, non un épuisement.
:::
::::

S'il tient, les deux volets de la Phase 4 de la compilation
(§{num "sec:c6-le-processus-de-compilation"}[]) cessent d'être deux vérifications distinctes. La
décroissance d'un pli de couche 3 et la progression d'un flux de couche 2 sont deux lectures d'un
même jugement de typage, sous deux polarités.[^fn2] S'il tombe, la couche 2 doit revenir au
gardiennage syntaxique. Elle perd avec lui la composition des combinateurs définis par
l'utilisateur, c'est-à-dire l'essentiel de ce qui fait d'elle une couche d'ordre supérieur.

[^fn2]: La Phase 3, qui établit la pureté, n'est pas concernée.

Ce que ce choix évite ne se voit pas sur l'énoncé, et mérite donc d'être dit. {rmq}[Le critère se
compose parce qu'il est un jugement, non parce qu'on aurait vérifié qu'il se compose.] Les deux
assistants de preuve les plus employés achoppent l'un et l'autre à cet endroit, pour des raisons
différentes : chez le premier la coinduction est réputée cassée, la règle de garde n'étant pas
compatible avec la conversion. Chez le second, l'inductif et le coinductif ne se mêlent pas de façon
compositionnelle. Un critère porté par les types, et non par une analyse syntaxique de garde,
échappe aux deux {cite "abelWellfoundedRecursionCopatterns2016"}[]. Ce n'est pas un raffinement de
confort, c'est la raison pour laquelle ce document peut mêler ses deux polarités sans clause
supplémentaire.

Les deux énoncés qui précèdent ne sont pas deux théorèmes, et ils ont été écrits comme les deux
instances qu'ils sont. Leurs hypothèses sont la même — un indice de taille décroissant porté par le
type —, leur bien-fondation est la même, et ce qui les distingue n'est pas l'argument mais le côté
où on le lit. Voici cet argument, écrit une fois, la couche étant le paramètre. Le procédé est celui
d'Abel et Pientka, qui obtiennent un traitement unifié de la récursion et de la corécursion en
faisant de la productivité une _instance_ de la terminaison plutôt qu'un critère parallèle {cite "abelWellfoundedRecursionCopatterns2016"}[].

::::thm (label := "thm:progression_polarisee")
:::title
progression, paramétrée par la couche
:::

:::statement +titled
Une seule idée, lue selon la polarité de la couche

Soit $`\ell` une couche polarisée et $`p(\ell)` sa polarité, donnée par la table de sédimentation du
chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) : $`p(3) = \mu` et $`p(2) = \nu`. Soit $`F` un
conteneur.

Un calcul de couche $`\ell` défini sur $`p(\ell)F` par un schéma dont le type porte un indice de
taille décroissant _au sens de_ $`p(\ell)` _progresse_ en un nombre fini d'étapes, la progression
s'entendant : en $`p = \mu`, jusqu'à épuisement de la structure — c'est la terminaison ; en
$`p = \nu`, jusqu'à production d'une observation — c'est la productivité.
:::

:::proofsketch
Le schéma a _deux instances de sortes_, et non un seul ordre lu deux fois — ce qu'une rédaction
antérieure affirmait à tort, l'ordre opposé de $`\mathbb{N}` n'étant pas bien fondé.

En $`p = \mu`, la mesure est prise dans $`\mathbb{S}_\mu` et _décroît_ strictement dans un ordre
bien fondé : toute chaîne décroissante y est finie, donc l'évaluation atteint une forme normale.

En $`p = \nu`, la mesure est prise dans $`\mathbb{S}_\nu` et la conclusion est duale : chaque
observation consomme une unité, et l'on ne demande pas que la suite des tailles s'épuise mais que
_chaque pas soit atteint en temps fini_. Pour une taille finie, c'est la décroissance elle-même ;
pour $`\omega`, c'est l'absorption $`\omega \ominus 1 = \omega`, qui garantit qu'une observation
reste toujours disponible. Un flux non terminé est ainsi typable, et c'est ce que la couche 2
demande.

Ce qui est commun aux deux instances, et qui fait le schéma, est que la mesure est portée par le
_type_ et non inspectée sur la syntaxe du terme : l'argument ne dépend donc pas de la forme du
terme. Ce qui les sépare est la sorte, et elle est déterminée par la polarité.

Le théorème est donc un _schéma de méta-théorème_ à deux instanciations, dont les conclusions ne
sont pas identiques : en couche 3 on démontre l'épuisement d'une structure finie, en couche 2
l'apparition d'une observation en temps fini. Le mot « progression » est choisi pour couvrir les
deux, il n'affirme pas qu'elles ont la même conclusion sémantique, et rien n'est à déduire de l'une
pour l'autre au-delà du schéma.
:::
::::

S'il tient, les deux théorèmes précédents cessent d'être deux théorèmes : ils se retrouvent en
spécialisant $`\ell` — le théorème {num "thm:terminaison_couche_3"}[] pour $`\ell = 3`, le théorème {num "thm:productivite_couche_2"}[]
pour $`\ell = 2` — et rien de ce qu'ils établissent n'est perdu, le traitement des types imbriqués
d'un côté et la non-compositionnalité du gardiennage syntaxique de l'autre restant les difficultés
propres à chaque instance. S'il tombe, le langage garde ses deux garanties mais perd le fait
qu'elles n'en font qu'une, et avec lui l'économie que la condition de clôture réclame.

Trois remarques sur cet énoncé, dont deux fixent sa portée. La première est que le mot _progression_
y est choisi et non trouvé : les deux conclusions d'origine — l'évaluation termine, une valeur
observable est produite — ne sont pas littéralement duales, et il fallait un terme dont elles soient
les deux lectures. {rmq}[À ne pas confondre avec le théorème de progrès du §{num "sec:g-semantique"}[], qui porte sur
la relation de réduction et non sur les schémas de récursion. La parenté est réelle, l'objet ne
l'est pas.] Le théorème de progrès du §{num "sec:g-semantique"}[] porte
un nom voisin et un autre objet.

La deuxième est que le paramètre court sur les _deux couches polarisées_ et non sur les trois. La
couche 1 n'est ni $`\mu` ni $`\nu` : ses ressources sont uniques et ne sont pas parcourues, de sorte
qu'elle n'a pas de théorème de progression de cette famille et n'en a pas besoin. Le chapitre 4
(§{num "sec:c4-echelle-locale"}[]) en tire une conséquence de vocabulaire qui n'est pas cosmétique.
Le régime d'exécution des couches 2 et 3 porte un seul nom, puisqu'un seul théorème les gouverne,
tandis que la couche 1 en porte un autre.

La troisième est que la distinction entre les deux instances _se voit dans la machine_, ce qui
interdit d'y voir une abstraction gratuite. L'instance $`\mu` est bornée par un indice décroissant
porté par le type et n'a besoin d'aucun objet à l'exécution. L'instance $`\nu` est bornée par une
taille maximale de pile que le compilateur calcule à l'avance et loge dans un contexte fixe. Un
paramètre dont les deux valeurs diffèrent matériellement n'est pas une commodité de présentation.

Cette dualité n'est pas une analogie mais une identité catégorique : une $`F`-algèbre dans _C_ est
une $`F^{\text{op}}`-coalgèbre dans $`\mathcal{C}^{\text{op}}` — la même paire $`(A, \alpha)`, la
flèche $`\alpha` étant simplement lue dans l'autre sens — et l'initialité dans _C_ correspond à la
terminalité dans $`\mathcal{C}^{\text{op}}`. Terminaison et productivité ne sont donc pas deux
propriétés qu'il faudrait établir séparément pour chaque couche : ce sont la même propriété —
existence et unicité d'un morphisme vers ou depuis un point fixe — énoncée dans deux catégories
duales l'une de l'autre.

::::figure (label := "fig:dualite-algebre-coalgebre") (src := "co-algebra-duality") (alt := "Deux categories en vis-a-vis. A gauche la categorie C porte l'algebre initiale mu F, de structure in qui envoie F de mu F sur mu F, et fonde la terminaison. A droite la categorie C oppose porte la coalgebre terminale nu F, de structure out qui envoie nu F sur F de nu F, et fonde la productivite. Une fleche relie les deux et porte « meme construction, lue dans la categorie opposee ».") (width := "90")
:::caption
Dualité algèbre initiale / coalgèbre terminale, dans C et C^op
:::

:::desc
La terminaison et la productivité mises face à face : une seule propriété, lue dans deux catégories
duales l'une de l'autre.
:::
::::

Pour partager des sous-calculs sans rompre la terminaison — le cas de la programmation dynamique —,
le catamorphisme s'étend à l'histomorphisme. Le pli s'effectue non sur $`F(A)` mais sur
$`F(\text{Cofree}_F(A))`, où la comonade cofree $`\text{Cofree}_F` annote chaque sous-terme de
l'historique de tous les résultats déjà calculés en dessous de lui. L'histomorphisme reste un
catamorphisme — sur un foncteur enrichi, non sur un principe de récursion distinct — et sa
terminaison en hérite directement. K7PL borne seulement, par un grade $`r`, la profondeur de
l'historique conservé, pour que cet enrichissement demeure lui-même en mémoire $`O(1)`. La loi distributive $`\lambda` que l'instance historique réclame n'est pas une conséquence gratuite de $`!^r` : c'est une structure dérivée, nécessaire à cette seule instance, et la factorisation se lit _noyau plus instance historique_.

Deux choses doivent être ajoutées ici, car la présentation ci-dessus est correcte mais incomplète,
et l'une des deux touche un postulat. La première est que l'histomorphisme relève d'une classe
caractérisée — les _schémas de récursion issus d'une comonade_ —, doublement générique : paramétrée
par le type de données $`\mu F` _et_ par une comonade $`N`, l'histomorphisme s'obtenant lorsque $`N`
est la comonade cofree. Cette classe ne se réduit pas à un pli sur un foncteur enrichi : elle exige
une _loi distributive_ $`\lambda : F \circ N \Rightarrow N \circ F` de l'endofoncteur sur la
comonade, soumise à deux conditions de cohérence, et c'est elle qui fait de l'algèbre $`\mathit{in}`
et de la coalgèbre de contexte une $`\lambda`-bialgèbre — une algèbre et une coalgèbre de porteur
commun {cite "hinzeUnifyingStructuredRecursion2016"}[]. Ce document emploie l'histomorphisme sans
avoir posé cette loi ; elle lui est due, et elle est distincte de la loi distributive graduée du
chapitre 1, qui distribue la modalité de grade sur la monade d'effet et non un foncteur de motif sur
une comonade d'historique. Autant l'écrire ici que la laisser en dette.

::::thm (label := "thm:loi_historique")
:::title
loi distributive de l'historique
:::

:::statement +titled
Ce que la comonade cofree doit vérifier pour porter le pli

Soit $`F` un conteneur et $`N = \text{Cofree}_F` la comonade cofree associée, de counité $`\epsilon`
et de comultiplication $`\delta`. La transformation naturelle
$`\lambda : F \circ N \Rightarrow N \circ F` satisfait les deux conditions de cohérence
$$`\epsilon \circ F \cdot \lambda = F \circ \epsilon \qquad\text{et}\qquad \delta \circ F \cdot \lambda = N\circ\lambda \cdot \lambda\circ N \cdot F\circ\delta,`
et l'algèbre $`\mathit{in}` de $`\mu F` forme avec la coalgèbre de contexte une
$`\lambda`-bialgèbre, c'est-à-dire une algèbre et une coalgèbre de porteur commun.
:::

:::proofsketch
La première condition dit que distribuer l'historique hors du foncteur puis en extraire la valeur
courante revient à l'extraire à l'intérieur ; la seconde, que distribuer puis dupliquer le contexte
revient à dupliquer à l'intérieur puis distribuer. Elles se vérifient sur la comonade cofree par les
lois de counité et de coassociativité, la trace du foncteur fournissant la comultiplication. La
troncature à $`r` niveaux les préserve, chacune étant une équation entre transformations naturelles
dont les deux membres se tronquent au même rang.
:::
::::

L'énoncé n'est pas propre à ce document : c'est celui de la classe des schémas issus de comonades,
dont l'histomorphisme est l'instance où $`N` est la cofree {cite "hinzeUnifyingStructuredRecursion2016"}[].
Ce qui est propre à K7PL est le grade $`r` qui borne la profondeur de l'historique conservé, et
c'est la seule moitié de l'obligation que ce document ait à acquitter. S'il tient, l'histomorphisme
de K7PL est un schéma caractérisé et sa terminaison s'hérite de celle du catamorphisme. S'il tombe,
l'histomorphisme redevient une définition ad hoc, dont la terminaison doit être établie à part et
dont rien ne garantit qu'elle se compose.

La seconde touche P3, et elle interdit de tenir la borne pour acquise. La dérivation directe d'un
tel schéma est _quadratique_, le corps du pli appliquant l'algèbre au résultat d'une trace ; obtenir
une version linéaire, qui n'invoque l'algèbre qu'une fois par niveau, demande un travail
supplémentaire et un résultat séparé. Annoncer une borne sans dire de laquelle des deux versions on
parle reviendrait à dissimuler un facteur, ce que le postulat d'autonomie physique interdit. La
borne annoncée ici est donc celle de la version linéaire, et voici comment on l'obtient.

Une chose de plus doit être dite sur la nature de cette borne, car elle est nommée à mi-mot. Une
borne d'historique par un grade est une borne _amortie_ : elle ne majore pas ce que coûte un niveau,
elle majore ce que coûte l'ensemble des niveaux rapporté à leur nombre. Ce document l'énonce sans
employer le mot, ce qui laisserait croire à une borne au pire cas par étape. Or l'analyse amortie a
un compte rendu catégorique dans le cadre même de ce document, le calcul par poussée de valeur. Elle
se lit dans une catégorie d'_algèbres de coût_ où la fonction de potentiel devient un morphisme de
coalgèbres — donc un objet du langage et non une astuce de preuve — et où les arguments
d'amortissement se composent dans la catégorie indexée des coalgèbres {cite "grodinAmortizedAnalysisCoalgebra2024"}[].
Le grade qui borne l'historique est donc un potentiel, et le dire ainsi n'ajoute aucun mécanisme :
cela nomme celui qui était déjà là, et cela rend la borne composable pour la même raison que les
autres constructions de ce chapitre le sont.

Le procédé est une _transposition_, et il tient à une correspondance biunivoque entre les solutions
du schéma et les homomorphismes de $`\lambda`-bialgèbres {cite "hinzeHistoDynamorphismsRevisited2013"}[].
Plutôt que de calculer $`f : \mu F \to B` directement — ce que la forme naïve fait en appliquant
l'algèbre au résultat d'une trace, d'où le comportement quadratique —, on calcule son transposé
$`h : \mu F \to F^\infty B`, qui construit la _table entière_ des réponses, et l'on prend la tête :
$`f = \mathit{head}^\infty \cdot h`. Or $`h` est un homomorphisme d'algèbres depuis l'algèbre
initiale, c'est-à-dire un _pli_. L'algèbre n'est donc invoquée qu'une fois par nœud, et l'on
retrouve la définition usuelle de l'histomorphisme, obtenue ici plutôt que posée.

La seconde moitié de l'obligation est propre à ce document, et la troncature s'y révèle un avantage
plutôt qu'une gêne. K7PL ne travaille pas sur $`F^\infty` mais sur son tronqué à $`r` niveaux, qui
est une comonade _graduée_ de la même famille que $`!_r` — sa comultiplication porte la somme des
profondeurs, non le produit du semi-anneau, et la coassociativité y survit (théorème
{num "thm:troncature_comonade"}[]). Le pli visite alors chaque nœud une fois en y maintenant une fenêtre de profondeur
$`r`. Le travail par nœud est en $`O(r)` et le total en $`O(n \cdot r)`, donc linéaire en la taille
de l'entrée à grade fixé — et $`r` étant un grade, ce facteur est connu à la compilation, ce que P3
exige. L'espace, lui, passe de $`O(n)` pour la table entière à $`O(r)` pour la fenêtre : c'est la
borne mémoire que cette section annonce, et c'est la troncature qui la donne.

::::thm (label := "thm:troncature_comonade")
:::title
la troncature est un morphisme de comonades
:::

:::statement +titled
La troncature préserve les lois de comonade, pour tout foncteur

Soit $`F` un endofoncteur, en particulier un conteneur. La convention de remplissage est
l'_écartement_ : $`N_0 A = A` et $`N_{r+1} A = A \times F(N_r A)`, la structure plus profonde étant
écartée et non remplacée. La troncature $`T_{r,n} : N_n \Rightarrow N_r` ($`r \le n`) est définie par
$`T_{0,n} = \mathit{head}` et $`T_{r+1,n+1}(a,t) = (a, F(T_{r,n})\,t)`, et $`T_r : N \Rightarrow N_r`
sur $`N = \text{Cofree}_F` par la même récurrence sur la structure déroulée. Pour tout $`F`, sans
autre hypothèse : (i) $`N_r`, de counité $`\epsilon = \mathit{id} : N_0 \Rightarrow \mathit{Id}` et de
comultiplication $`\delta_{r,s} : N_{r+s} \Rightarrow N_r N_s`, est une comonade graduée par le monoïde
additif des profondeurs $`(\mathbb{N}, +, 0)` ; (ii) $`T_r` est un morphisme de comonades de $`N` vers
$`N_r` ; (iii) $`\lambda_0 = \mathit{id}` et $`\lambda_{r+1} = \langle F\,\mathit{fst},\ F(\lambda_r)\circ F\,\mathit{snd} \rangle`
définissent $`\lambda_r : F N_r \Rightarrow N_r F`, avec $`\lambda_r \circ F(T_r) = T_r \circ \lambda`, qui
satisfait les deux conditions de cohérence de la loi distributive. Aucune restriction de la classe des
conteneurs admissibles n'est requise.
:::

:::proofsketch
Le point de difficulté est le _rang frontière_ : $`N_r \delta_{s,u}` et $`\delta_{r,s} N_u` appliquent
deux troncatures à des profondeurs différentes. La convention d'écartement le lève : la troncature
n'invente aucune valeur, elle est définie par la récurrence ci-dessus, et les identités se démontrent
par récurrence sur le rang extérieur, en ne mobilisant que la fonctorialité de $`F`. La comultiplication
est définie par $`\delta_{0,s} = \mathit{id}` et $`\delta_{r+1,s}(a,t) = (T_{s,s+r+1}(a,t),\ F(\delta_{r,s})\,t)`.
Elle porte la _somme_ des profondeurs, non leur produit : la fenêtre extérieure de $`r` niveaux porte en
chacun de ses nœuds une fenêtre intérieure de $`s` niveaux, et ces fenêtres se recouvrent, de sorte que
$`r+s` niveaux sont nécessaires pour la construire. Trois récurrences suffisent. (a) Les troncatures
forment une tour : $`T_{r,s} \circ T_{s,n} = T_{r,n}` et $`T_{n,n} = \mathit{id}`, d'où l'idempotence de la
troncature rapportée au rang $`r`, sans condition sur $`F`. (b) La troncature commute à $`\delta` :
$`T_{s,n}^{N_u} \circ \delta_{n,u} = \delta_{s,u} \circ T_{u+s,u+n}`. (c) Les lois de comonade : la counité
est immédiate au rang $`0`, et au rang $`r+1` la première composante est la troncature de la racine,
la seconde se ramène à l'hypothèse de récurrence par fonctorialité de $`F` ; la coassociativité
$`N_r(\delta_{s,u}) \circ \delta_{r,u+s} = \delta_{r,s}^{N_u} \circ \delta_{r+s,u}` est la même récurrence sur $`r`,
la première composante étant égalée par (b). La condition $`T_r \circ F = F \circ T_{r-1}` n'est pas une
hypothèse sur $`F` : c'est la clause de définition de la troncature. Pour $`\lambda_r`, la première
condition ($`\mathit{head}\circ\lambda_r = F(\mathit{head})`) se lit sur la première composante ; la seconde
($`\delta_{r,s}\circ\lambda_{r+s} = N_r(\lambda_s)\circ\lambda_r\circ F(\delta_{r,s})`) se démontre par récurrence
sur $`r`, au rang $`0` par $`\delta_{0,s} = \mathit{id}`, au rang $`r+1` par la commutation de $`\lambda` à
la troncature. Les deux conditions de cohérence de la comonade cofree non tronquée sont un résultat de
la littérature ; la préservation par troncature est le seul point propre à K7PL. La démonstration est
sur papier : elle n'a pas été mécanisée. Les bornes $`O(r)` en espace et $`O(n \cdot r)` en temps de ce
qui suit reposent sur cette structure.
:::
::::


::::thm (label := "thm:fenetre_grade") (status := "proposition")
:::title
une fenêtre est un grade
:::

:::statement +titled
Toute fenêtre sur un objet coinductif est un grade connu à la compilation

La troncature à $`r` niveaux d'un objet coinductif, la borne de profondeur de pile d'un automate à pile
et la taille de pile précalculée d'un `StreamContext` sont trois instances de la même fenêtre : un
entier $`r` qui borne la profondeur observée, porté par le grade et donc connu à la compilation.
:::

:::proofsketch
La troncature est la comonade graduée $`N_r` du théorème {num "thm:troncature_comonade"}[], dont $`r`
est l'indice. La pile d'un automate et celle d'un `StreamContext` sont des fenêtres sur la
configuration, dont le grade est la profondeur maximale que le solveur vérifie. Le lemme est la
réduction des deux dernières à la première ; non démontrée ici, elle donne à P3 sa forme générale.
:::
::::

La troncature n'est pas propre à ce pli : elle est la même fenêtre sur un objet coinductif que la
borne de profondeur de pile de l'automate à pile (chapitre 4) et la taille de pile précalculée du
`StreamContext`. Un lemme de troncature unique les couvre — _une fenêtre est un grade_ — et donne à
P3 sa forme générale : toute fenêtre est un grade, tout grade est connu à la compilation. Les trois
énoncés lui seront ramenés ; le lemme n'est pas encore écrit à part.

Les effets algébriques de la couche 2 sont un cas particulier de cette même construction. Pour une
signature d'opérations $`\Sigma`, la syntaxe d'un calcul effectueux de type de retour $`A` est
l'algèbre initiale $`\mu F` pour $`F(X) = A \oplus \Sigma(X)` — un arbre dont les feuilles sont des
valeurs de type $`A` et les nœuds internes des opérations de $`\Sigma` à poursuivre. Un gestionnaire
(_handler_) pour $`\Sigma`, ciblant un type de résultat $`R`, n'est rien d'autre qu'une $`F`-algèbre
sur $`R` : une interprétation du retour ($`A \to R`) et une interprétation de chaque opération
($`\Sigma(R) \to R`), assemblées par la propriété universelle du coproduit. Exécuter un calcul avec
ce gestionnaire est alors exactement le catamorphisme induit par cette algèbre — Plotkin et Power en
donnent la formulation qui fonde cette lecture.

Cette lecture a un domaine : les gestionnaires de K7PL sont bornés par les délimiteurs du chapitre
5, donc par une portée, et une portée n'est pas une opération algébrique. Ils relèvent à ce titre
des effets _à portée_, dont la caractérisation passe par des théories algébriques paramétrées mêlant
opérations à portée et opérations algébriques {cite "matacheScopedEffectsScoped2025"}[] — la
correspondance entre monades et théories algébriques que cette notion suppose faisant elle-même
l'objet d'un traitement général, par monades à arités et théorèmes de nerf {cite "bergerMonadsAritiesTheir2012"}[].
La lecture par $`F`-algèbre n'en est pas invalidée : elle est paramétrée.

C'est ce même schéma qui, au chapitre 6, permet l'_inlining_ statique des gestionnaires : un
catamorphisme dont l'algèbre est connue à la compilation se spécialise sans reste, sans jamais
recourir à une table de dispatch dynamique.
