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

#doc (Manual) "Adjonctions et enrichissement" =>
%%%
file := "c2-adjonctions-et-enrichissement"
tag := "c2-adjonctions-et-enrichissement"
%%%

{label "sec:c2-adjonctions-et-enrichissement"}

La fermeture de _C_, construite en §{num "sec:c2-la-categorie-ambiante"}[] comme l'adjonction
$`(- \otimes A) \dashv [A \multimap -]`, n'est pas qu'une clause de définition : c'est elle qui
légitime, au chapitre 6, l'effacement du curryfiage à la compilation. La bijection naturelle de
l'équation {num "eq:adjonction-tenseur-hom"}[] identifie, pour tout $`\Gamma`, une fonction de deux
arguments $`\Gamma \otimes A \to B` à sa forme curryfiée $`\Gamma \to [A \multimap B]` — les deux
dénotent le même élément, de part et d'autre d'un isomorphisme naturel, donc sémantiquement
transparent au sens de P1a, et la correction de la compilation de cette équivalence relève de P1b, non établie (chapitre 1). Un programme K7PL à plusieurs arguments admet ainsi indifféremment une
présentation curryfiée, en fermetures successives, ou une présentation directe
$`(X \otimes Y \otimes Z) \to R`. La monomorphisation du chapitre 6, qui compile systématiquement
vers la seconde, n'est donc pas une heuristique risquant d'altérer le sens du programme : l'argument
est syntaxique — chaque présentation se transforme en l'autre par substitution, les règles de
l'abstraction et de l'application étant inversibles —, et ne requiert pas l'interprétation P1b. C'est le
choix, parmi les représentants d'une même classe d'isomorphisme, de celui qui n'alloue aucune
fermeture intermédiaire, conformément à P3.

Une seconde conséquence de la fermeture concerne la représentation des tableaux, et elle appelle
d'abord une déclaration sur la classe à laquelle appartiennent les types de K7PL — car c'est cette
classe, et non un artifice local, qui la rend possible.

Les types de K7PL sont des _conteneurs indexés_. La notion syntaxiquement riche de famille
strictement positive s'y réduit à une théorie noyau munie d'un *nombre fixe* de constructeurs de
types, les conteneurs indexés en fournissant les formes normales, et cette réduction s'obtient sans
étendre la théorie noyau {cite "altenkirchIndexedContainers2009"}[]. Trois conséquences en
découlent, énoncées ici plutôt que redécouvertes au chapitre 3. D'abord la condition de clôture
posée au chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) cesse d'être une discipline de
conception pour devenir un résultat, du moins sur le versant qui concerne la _grammaire des types_.
Un nombre fixe de constructeurs suffit à toute famille strictement positive, de sorte qu'aucune
extension n'a besoin d'en ajouter un.

Le mot est fixé ici, ce chapitre lui donnant trois emplois : les _composantes du jugement_ sont les
trois du chapitre 1, $`\Delta`, $`A` et $`\mathcal{E}` ; les _composantes du grade_ sont les
coordonnées de son produit ; et les _constructeurs de la théorie noyau_ sont ce dont il est question
dans cette phrase. Ce sont ces derniers dont le nombre est fixe, et cela ne dit rien du nombre des
deux autres.

Ensuite les familles indexées que le chapitre 3 emploie — `Vector(n,T)`, les rangées à grade de
présence, `Incomplete A B` dont la forme change à chaque remplissage — sont admises d'office, sans
qu'aucune primitive ne soit ajoutée pour les accueillir. Enfin, et c'est ce dont le
§{num "sec:c2-algebres-coalgebres-et-points"}[] a besoin, *les conteneurs préservent les plus petits
et les plus grands points fixes* {cite "damatoFormalisingInductiveCoinductive2024"}[] : $`\mu F` et
$`\nu G` restent l'un et l'autre dans la classe, et leur emboîtement aussi.

Cela posé, un tableau de taille $`n` sur $`T` n'est pas un conteneur distinct des fonctions : c'est
un élément de $`\text{Hom}(\text{Fin}(n), T)`, où $`\text{Fin}(n)` est le coproduit de $`n` copies
de l'unité, $`\text{Fin}(n) = \underbrace{I \oplus \dots \oplus I}_{n}`. Puisque le foncteur
$`\text{Hom}(-, T)` transforme les coproduits en produits, et que les éléments globaux
$`\text{Hom}(I,T)` s'identifient aux valeurs de $`T` elles-mêmes, il vient

::::formula (label := "eq:yoneda-tableau") (kind := "equation")
```
\begin{equation}
\text{Hom}(\text{Fin}(n), T) \;\cong\; \text{Hom}(I,T)^n \;\cong\; T^n \;=\; \text{Vec}(n,T).
\end{equation}
```
::::

C'est cette lecture — un conteneur fini est déterminé par la façon dont il s'observe depuis un objet
représentable, l'intuition centrale du lemme de Yoneda — que la théorie des types du chapitre 3
exploite pour encoder les contraintes de taille sans recourir à des types dépendants complets :
`Vec n T` n'est pas un type primitif supplémentaire, c'est une notation pour
$`\text{Hom}(\text{Fin}(n), T)`.

La dernière structure que _C_ doit porter est la relation de précision $`\sqsubseteq` annoncée au
chapitre 1 (P2). Sur chaque catégorie d'artefacts syntaxiques — types, termes, contextes, effets,
grades — $`\sqsubseteq` est un _demi-treillis supérieur borné_, de joint $`\sqcup` et d'élément
minimal : $`A \sqsubseteq B` se lit « $`A` est une version au plus aussi précise que $`B` ».
Pourquoi cette structure et pas une plus riche ? Une version antérieure de ce texte déclarait un
treillis distributif borné et l'engagement était plus lourd que l'usage. Le joint sert : aux
branchements du chapitre 3, où il sur-approxime les effets d'un filtrage, et à la relation de
sous-typage du §{num "sec:g-regles"}[], dont le théorème {num "thm:coherence_subsomption"}[] montre qu'il
conditionne la cohérence. La rencontre ne sert nulle part, et la distributivité n'est invoquée par
aucune démonstration. Déclarer moins n'affaiblit donc rien~; cela retire seulement une dette de
justification qu'aucun résultat ne réclamait.

Il faut en revanche dire de quel _ordre_ il s'agit, car deux théories de l'information portent le
même mot sans être le même ordre. Celle de Shannon ordonne par ce qu'on _sait_ — des relations
d'équivalence sur le domaine, formant un treillis complet —, celle de Scott par ce qui est _défini_,
au sens du progrès du calcul {cite "huntReconcilingShannonScott2023"}[]. La relation de précision
compare des raffinements, donc ce qu'un type _garantit_ : elle est du côté de Shannon. La
conséquence n'est pas verbale, les deux ordres n'ayant pas les mêmes propriétés de complétude — et
il n'est pas indifférent que la composante de niveau du grade emploie ce même treillis, redécouvert
plusieurs fois dans la littérature du flot d'information.

K7PL étend cette relation aux morphismes de _C_ eux-mêmes et exige que la composition et le tenseur
soient monotones : si $`f \sqsubseteq f'` et $`g \sqsubseteq g'`, alors
$`g \circ f \sqsubseteq g' \circ f'` et $`f \otimes g \sqsubseteq f' \otimes g'`. C'est la structure
d'une catégorie enrichie sur les préordres — _C_ ne perd rien de sa structure ordinaire, elle gagne
un ordre compatible sur chaque ensemble de morphismes parallèles et sur ses objets.

Cette exigence de monotonie ne pèse pas sur chaque primitive séparément : elle est portée par les
types, au même titre que l'usage l'est par les grades. Le grade d'une liaison acquiert à cette fin
une seconde composante, _discrète_ ou _monotone_, et une fonction dont le grade porte la seconde
marque est astreinte à préserver $`\sqsubseteq`. Le procédé est celui de Datafun, qui suit la
monotonie par les types en distinguant deux sortes de variables et deux flèches {cite "DATAFUN"}[].
K7PL n'en retient pas la présentation à deux zones, qu'il a écartée au chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]), mais l'idée que la monotonie est une propriété déclarée
et vérifiée plutôt qu'une charge de preuve reconduite à chaque extension. Une construction nouvelle
n'a donc pas à démontrer qu'elle respecte l'ordre : elle porte un grade qui l'y oblige, ou n'en
porte pas et se voit refuser l'accès aux constructions qui l'exigent.

Ce procédé n'est pas propre à la monotonie, et s'énonce une fois dans sa forme générale. Soit
$`(P, \preceq)` une structure ordonnée. Une _modalité graduée sur $`P`_ est une famille de comonades
$`\{!_p\}_{p \in P}` sur _C_, indexée par $`P`, telle que $`p \preceq q` induise une coercion
$`!_q A \to !_p A` et que l'ordre gouverne la composition. Le grade d'une liaison porte alors une
composante dans $`P`, et la contrainte que cette composante exprime est toujours de la même forme :
une flèche graduée en $`p` ne peut employer que ce qui est disponible en deçà de $`p`.

Ce procédé a plus d'instances que le document ne le laisse voir, et les compter est ce qui mesure sa
portée. Les voici toutes, avec la structure ordonnée que chacune prend pour paramètre.

::::k7table (label := "tab:c2-instances-gradation") (align := "lZ{1.0}Z{1.0}")
:::caption
Les instances du procédé de gradation, et la structure ordonnée de chacune
:::

:::table +header
* * Modalité
  * Structure ordonnée
  * Ce que la contrainte dit
* * usage
  * le semi-anneau des grades
  * combien de fois une ressource est employée
* * monotonie
  * l'ordre à deux points
  * si une flèche respecte l'ordre de son argument
* * confidentialité
  * le treillis des niveaux
  * ce qu'un observateur d'un niveau peut distinguer
* * budget
  * les conaturels sous l'ordre inverse
  * ce qu'un calcul ne dépassera pas
* * temps, délai
  * l'ordre des instants
  * qu'une ressource sera disponible au pas suivant
* * temps, permanence
  * le même, en permanence
  * qu'elle l'est à tout instant
* * temps, éventualité
  * le même, sans borne
  * qu'elle le sera sans qu'on dise quand
* * localité
  * le demi-treillis des localisations
  * où une valeur réside
* * présence
  * le monoïde des champs
  * si un champ d'un enregistrement est là
:::
::::

Neuf instances, et aucune n'a demandé de mécanisme propre. {rmq}[Neuf applications d'une
construction écrite une fois. C'est la mesure de ce que le procédé vaut, et elle ne se lisait nulle
part.] Deux données complètent le tableau sans être des modalités, et il faut dire pourquoi : le
_mode_ — une algèbre, un idéal de contraction, un booléen d'affaiblissement — fixe les règles
structurelles admissibles plutôt qu'une contrainte sur les liaisons ; et la _zone_ y ajoute un ordre
propre. Ce sont les paramètres du procédé, non ses produits.

Ce que ce tableau établit n'est pas une économie d'écriture, c'est la _portée_ de la condition de
clôture. Une extension qui réclamerait une dixième modalité ne demanderait rien de neuf — il lui
suffirait de nommer sa structure ordonnée. C'est ce que la distribution a fait, et c'est pourquoi
elle a pu entrer sans quatrième place dans le jugement.

Deux instances suffisent à montrer que la forme est la bonne. La monotonie est la modalité sur
l'ordre à deux points $`\{\text{discret} \prec \text{monotone}\}` : une flèche graduée _monotone_ ne
peut employer ses arguments que d'une manière qui préserve $`\sqsubseteq`, et la coercion
descendante dit qu'une fonction monotone s'emploie partout où une fonction quelconque est admise. La
_confidentialité_ est la modalité sur un treillis de niveaux $`(\mathcal{L}, \leq)` : une flèche
graduée en $`\ell` ne peut employer que des valeurs de niveau au plus $`\ell`, et la coercion monte
l'information sans jamais la redescendre. Le mécanisme est identique, seule change la structure
ordonnée sur laquelle il opère {cite "marshallGradedModalTypes2023"}[] — de sorte que la
confidentialité n'ajoute pas un axe au langage mais instancie celui que la monotonie a ouvert.

Un dispositif reste à mentionner, sans lequel cette modalité serait impraticable et avec lequel elle
est fragile. Un programme utile doit parfois _abaisser_ délibérément un niveau — vérifier un mot de
passe consiste à révéler un bit d'une valeur secrète, et le refuser rendrait le langage
inutilisable. Ce mécanisme, la _déclassification_, coerce le niveau vers le bas et sert
d'échappatoire au régime ordinaire. Son risque propre porte un nom : l'_attaque par blanchiment_, où
l'échappatoire est employée pour faire sortir davantage que ce qu'elle était censée libérer, une
valeur secrète transitant par la fonction déclassifiante sous un déguisement quelconque {cite "sabelfeldModelDelimitedInformation2004"}[].
Il en résulte que spécifier la déclassification demande deux choses et non une : une règle qui
l'autorise, et une garantie de bout en bout qui borne ce qu'elle peut libérer — la _divulgation
délimitée_, dont il est établi qu'un système de types l'impose. Une règle sans cette garantie
rendrait le grade de confidentialité contournable par construction, et ce document ne donne pour
l'instant ni l'une ni l'autre. Il donne les deux ici.

La règle procède par _échappatoires nommées_ plutôt que par une permission générale de déclassifier.
Une déclaration fixe un ensemble fini $`\mathcal{X}` d'expressions — les échappatoires — dont
chacune énonce ce qui est autorisé à sortir : le résultat de la comparaison d'un mot de passe, la
somme d'une colonne, le rang d'un enchérisseur. Ces expressions sont _closes_,
$`\forall e \in \mathcal{X},\ \mathrm{fv}(e) = \emptyset`, et évaluées dans l'état initial : une
échappatoire ouverte ouvrirait un contournement par substitution, puisque
$`\mathbf{declassify}_{\ell'}(e)[v/x] = \mathbf{declassify}_{\ell'}(e[v/x])` sans que
$`e[v/x] \in \mathcal{X}`, et l'attaquant ferait comparer le secret à une valeur de son choix
(§{num "sec:g-semantique"}[]). La règle ne s'applique qu'à elles :

::::formula (label := "eq:regle-declassify") (kind := "equation")
```
\begin{equation}
\frac{\;\Delta \vdash_{\mathcal{G}} e : !_{\ell}\,A \qquad e \in \mathcal{X} \qquad \ell' \leq \ell\;}{\;\Delta \vdash_{\mathcal{G}} \mathbf{declassify}_{\ell'}(e) : !_{\ell'}\,A\;}
\end{equation}
```
::::

Ce que cette règle laisse ouvert est ce qu'une garantie doit fermer : rien n'y interdit qu'une
valeur secrète quelconque transite par une échappatoire sous un déguisement, et l'échappatoire
libérerait alors bien plus que ce qu'elle nomme. La garantie qui l'écarte s'énonce sur les
exécutions plutôt que sur les dérivations.

::::thm (label := "thm:divulgation_delimitee") (status := "proposition")
:::title
divulgation délimitée
:::

:::statement +titled
Une échappatoire ne libère que ce qu'elle nomme

Soit $`P` un programme bien typé dont les déclassifications portent sur l'ensemble d'échappatoires
$`\mathcal{X}`. Alors pour tout niveau $`\ell` et tous états initiaux $`s_1, s_2` qui coïncident sur
ce que l'observateur de niveau $`\ell` voit _et sur la valeur de chaque expression de
$`\mathcal{X}`_, les exécutions $`P(s_1)` et $`P(s_2)` sont indiscernables à ce niveau.
:::

:::proofsketch
Non démontré : l'énoncé est une proposition, et ce croquis n'en est que le plan. La quantification
est ce qui porte l'énoncé. On n'exige pas que deux états indiscernables au niveau $`\ell` produisent
des sorties indiscernables — ce serait la non-interférence, que la déclassification viole par
construction — mais que deux états qui s'accordent _en outre_ sur les échappatoires le fassent. La
route est la paramétricité par les existentielles : on construit la relation logique qui relie deux
états s'accordant sur $`\ell` et sur $`\mathcal{X}`, et le lemme fondamental
(théorème {num "thm:lemme_fondamental"}[]) l'étend à tout programme bien typé. Elle suppose la clause
de clôture des échappatoires posée plus haut (chaque $`e \in \mathcal{X}` est close), faute de quoi
la substitution ouvrirait le contournement par blanchiment, et le lemme de non-interférence du
théorème {num "thm:non_interference"}[] pour les cas où aucune déclassification n'est employée.
:::
::::

Le mode de défaillance que cette formulation ferme est celui contre lequel elle a été construite. {rmq}[C'est
la quantification, et elle seule, qui distingue cet énoncé de la non-interférence.] Dans l'attaque
par blanchiment, on fait transiter par une échappatoire une valeur qu'elle n'était pas censée
révéler — comparer un secret non pas au mot de passe attendu mais à une valeur choisie par
l'attaquant. Un tel programme échoue à l'énoncé, puisque deux états s'accordant sur la comparaison
légitime peuvent différer sur celle-là. S'il tient, le grade de confidentialité reste une garantie
de bout en bout malgré l'échappatoire. S'il tombe, il devient contournable par construction, et la
déclassification doit être retirée du langage ou confinée à un mécanisme hors du système de types.

Cet énoncé est celui de la divulgation délimitée {cite "sabelfeldModelDelimitedInformation2004"}[],
transposé au régime gradué de ce chapitre. Ce document en reprend la formulation et n'en conduit pas
la preuve pour K7PL. Il note en revanche que la voie est celle de la non-interférence graduée (théorème {num "thm:non_interference"}[]), la
quantification sur les états s'obtenant par la relation qu'une lecture paramétrique fournit.

Deux conséquences en découlent, dont la seconde est celle qui compte. La première est que
$`\mathcal{R}` n'est pas un semi-anneau plat portant des composantes hétéroclites, mais un produit
de structures ordonnées dont chacune contribue sa modalité : l'usage sur $`\mathbb{N}_\infty`, la
monotonie sur deux points, la confidentialité sur $`\mathcal{L}`. La seconde est que ce dispositif a
une _duale_ dont le langage a également besoin. La confidentialité contraint ce qu'une flèche peut
_lire_, et vit donc du côté du contexte, où les coeffets se posent ; l'_intégrité_ contraint ce
qu'elle peut _écrire_, et vit du côté des effets {cite "marshallGradedModalTypes2023"}[]. Les deux
côtés de l'adjonction du chapitre 1 portent ainsi les deux propriétés. C'est du côté de l'intégrité
que se dit ce que la frontière de confiance du chapitre 5 (§{num "sec:c5-mise-en-pratique"}[])
laisse aujourd'hui indéterminé. Une macro exécutée avant vérification, un import dont l'origine
n'est pas attestée, produisent des valeurs de basse intégrité, et rien pour l'instant ne les
distingue des autres.

Deux autres instances de ce même procédé achèvent de montrer qu'il est le bon, et toutes deux
touchent au coût. Le _budget_ que le chapitre 1 loge dans le grade est une modalité graduée sur un
treillis de ressources, où la composition séquentielle et le branchement au pire cas sont deux
opérations distinctes — l'une additionne, l'autre prend le maximum — et où $`!_r A` se lit « un $`A`
réalisable sous le budget $`r` » {cite "mannucciResourceBoundedTypeTheory2025"}[]. Sa formulation
naturelle est celle d'un _intérieur gradué_, donc d'une comonade, ce qui confirme qu'elle appartient
au côté du contexte et non à celui des effets.

Une seconde lecture du même budget existe, dénotationnelle plutôt que modale, et elle vaut d'être
signalée pour ce qu'elle prouve de faisabilité. Le coût d'un programme se ramène d'abord par
extraction syntaxique à une _récurrence_, avec un théorème de borne : tout programme source est
majoré par la récurrence extraite. Le langage des récurrences reçoit ensuite une sémantique
dénotationnelle qui abstrait les types de données {cite "dannerDenotationalSemanticsFoundation2022,cutlerDenotationalRecurrenceExtraction2020"}[].
Le budget de ce document n'est donc pas seul de son espèce : ce qu'il fait porter au type, cette
voie le fait porter à une dénotation, et les deux se rejoignent sur le point qui compte — une borne
établie sur la _forme_ du programme plutôt que mesurée sur son exécution.

Le _temps_ est la quatrième : une modalité sur l'ordre linéaire des instants, dont le chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]) tire les calendriers de la couche 2. Quatre structures
ordonnées, quatre modalités, un seul procédé — c'est la forme que prend ici la condition de clôture.

Que le grade soit un produit n'est pas un pari de ce document. Composer plusieurs structures de
gradation en munissant le produit de l'ordre _point par point_ est une construction standard des
systèmes gradués, employée précisément pour combiner des analyses indépendantes en une seule {cite "liepeltSameCoeffectDifferent2026"}[].
Les lois de comonade graduée y passent parce que chaque coordonnée les satisfait et que les
opérations sont définies coordonnée par coordonnée. Ce qui vaut ici du grade vaut de l'algèbre des
effets, dont le chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) fait un produit par le même
geste.

Une conséquence en découle, et elle porte sur ce qu'un développeur peut écrire. Un produit de
structures ordonnées est plus _large_ que l'ensemble des grades qu'un programme peut effectivement
former, et pour une raison de fond : les coordonnées ne croissent pas au même rythme. La contraction
additionne dans le facteur d'usage tout en saturant dans un facteur borné, de sorte qu'un grade dont
la première composante s'est incrémentée sans que la seconde ait saturé ne s'obtient ni par usage de
variable, ni par contraction {cite "liepeltSameCoeffectDifferent2026"}[]. De tels grades existent
dans le produit sans être _dérivables_.

La distinction entre le domaine des grades et ceux que la dérivation habite n'est donc pas un détail
de présentation, et deux conséquences pratiques en découlent. Une annotation écrite à la main peut
être bien formée sans correspondre à aucun programme, et le vérificateur doit le signaler comme tel
plutôt que d'échouer plus loin sur une unification qui n'aboutira pas. Et l'approximation par
l'ordre — remplacer un grade par un majorant — est parfois le seul moyen d'atteindre une région du
produit, ce qui rattache la question au joint des branchements du chapitre 3
(§{num "sec:c3-le-systeme-gradue"}[]) : ce que ce joint sur-approxime, il le fait pour la même
raison.

Ce second axe n'est pas gratuit et son bénéfice principal est ailleurs qu'ici. Une fonction monotone
d'un type dans lui-même admet un plus petit point fixe dès que ce type possède un plus petit élément
et une borne supérieure — un _semi-treillis_ —, et ce point fixe se calcule par itération depuis le
plus petit élément. Trois conditions le rendent effectif : le plus petit élément, la décidabilité de
l'égalité pour détecter l'arrêt, et la hauteur finie du type pour garantir la terminaison {cite "DATAFUN"}[].
Cette dernière est la position même de K7PL sur la terminaison (P3), appliquée à un opérateur que le
langage ne possède pas encore ; Le §{num "sec:c4-echelle-du-systeme"}[] en tire ce qu'une extension
déductive y gagnerait ; il reste à donner ici l'opérateur lui-même.

Sa règle de typage se lit sur le grade et non sur la forme du terme, ce qui est la manière propre à
ce langage :

::::formula (label := "eq:regle-fix") (kind := "equation")
```
\begin{equation}
\frac{\;\Delta \vdash_{\mathcal{G}} f : S \to_{\text{mon}} S \qquad S \in \mathsf{Trellis}_{\text{fin}}\;}{\;\Delta \vdash_{\mathcal{G}} \mathbf{fix}\;f : S \mid \mathcal{E} = \emptyset\;}
\end{equation}
```
::::

où $`\to_{\text{mon}}` note une flèche dont le grade porte la marque monotone, et où
$`\mathsf{Trellis}_{\text{fin}}` rassemble les types satisfaisant les trois conditions nommées
ci-dessus. K7PL ne les exprime pas par un mécanisme de classes, qu'il ne possède pas : ce sont des
conditions _syntaxiques_ sur la forme du type, décidables à la lecture de sa définition. Un type y
appartient s'il est un ensemble fini sur un type d'égalité décidable, ou un produit fini de tels
types, ou une somme finie — l'élément neutre étant l'ensemble vide, le joint l'union, et la hauteur
le cardinal du plus grand support. Cette restriction est plus étroite que la condition sémantique,
et c'est délibéré : elle est vérifiable sans preuve, à la manière dont le
§{num "sec:c2-algebres-coalgebres-et-points"}[] approche la bonne fondation par un indice de taille.

::::thm (label := "thm:terminaison_lfp")
:::title
terminaison du point fixe déductif
:::

:::statement +titled
Un troisième critère de terminaison, porté par le type

Soit $`S \in \mathsf{Trellis}_{\text{fin}}` de hauteur $`h`, et $`f : S \to_{\text{mon}} S`. Alors
la suite $`x_0 = \bot`, $`x_{n+1} = f(x_n)` est croissante, stationnaire en au plus $`h` étapes, et
sa limite est le plus petit point fixe de $`f`. L'opérateur $`\mathbf{fix}` est donc total sur
$`\mathsf{Trellis}_{\text{fin}}`. La borne $`h` dépend du type $`S`, ce qui fait de cet énoncé un
cas de gradation /indexée/ au sens du chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]). Le grade
d'effet de $`\mathbf{fix}\,f` n'est pas une constante mais une fonction de l'indice que porte $`S`.
:::

:::proofsketch
La croissance s'obtient par récurrence : $`x_0 = \bot \sqsubseteq x_1` puisque $`\bot` est minimal,
et si $`x_n \sqsubseteq x_{n+1}` alors $`f(x_n) \sqsubseteq f(x_{n+1})` par monotonie de $`f` —
c'est ici, et seulement ici, que la marque du grade sert : elle dispense de vérifier la monotonie
sur le terme, puisque le typage l'a déjà exigée. Une chaîne strictement croissante dans un ordre de
hauteur $`h` ne peut compter plus de $`h` pas ; la suite est donc stationnaire au plus tard au rang
$`h`, et l'égalité décidable de $`S` détecte ce rang. La valeur atteinte est un point fixe par
stationnarité, et le plus petit par le théorème de Knaster et Tarski, tout point fixe majorant la
chaîne issue de $`\bot`.
:::
::::

C'est le troisième critère de terminaison de ce document, et les trois sont de même nature. {rmq}[Trois
critères, un seul geste. La garantie se lit sur le type, jamais sur la forme du terme.] Le pli
dépendamment typé termine parce que son type porte un indice décroissant, la coinduction produit
parce que son type porte une taille, et `fix` termine parce que son type est de hauteur finie. Aucun
des trois n'inspecte la syntaxe du terme, ce qui est la position que P3 énonce. S'il tient,
l'opérateur n'affaiblit pas la garantie de terminaison de la couche 3 mais l'étend à un schéma
qu'elle n'atteignait pas ; s'il tombe, le point fixe déductif doit sortir du langage, et l'extension
déductive du chapitre 4 avec lui.

Deux réserves bornent l'énoncé. La borne $`h` est celle du type et non du calcul : une itération
peut converger bien plus tôt, et rien n'est dit du nombre d'itérations effectif — une borne serrée
relèverait de la strate des obligations, comme toute proposition sur un résultat. Et l'hypothèse de
monotonie porte plus qu'il n'y paraît : une règle qui conclut de l'absence d'un fait — la négation
stratifiée du chapitre 7 (§{num "sec:c7-etude-de-cas-iii"}[]) — n'est pas monotone, et le point fixe
qui la contiendrait ne relèverait pas de cet énoncé.[^fn3] Elle est nommée ici, où elle borne le
théorème, plutôt que cinq chapitres plus loin, où elle ne ferait que le constater.

[^fn3]: La stratification est le remède connu. Ce document ne la traite pas, et la restriction est donc réelle plutôt que théorique.

Cette monotonie a une conséquence directe, la garantie de gradualité statique : si
$`\Delta' \sqsubseteq \Delta` et $`e' \sqsubseteq e`, toute dérivation de $`\Delta \vdash e : A` se
projette en une dérivation de $`\Delta' \vdash e' : A'` pour un type $`A' \sqsubseteq A`. L'esquisse
en est immédiate : la dérivation de $`\Delta \vdash e : A` s'obtient par composition et
tensorisation de règles élémentaires. Remplacer, dans cette composition, chaque prémisse par une
prémisse $`\sqsubseteq`-inférieure produit, par monotonie, une composition encore valide, dont le
type résultant ne peut qu'avoir perdu en précision. Dégrader une entrée ne casse donc jamais le
typage : elle ne fait que dégrader, de façon prévisible, ce qui en dépend.

Cette structure ne referme pas seule la construction du chapitre : le
§{num "sec:c2-le-systeme-de-raffinement"}[] en montre l'origine. L'ordre de précision modal
$`\text{Unr} \sqsubseteq \text{Aff} \sqsubseteq \text{Lin}` du chapitre 1 est la restriction de
$`\sqsubseteq` à la seule dimension des modalités d'usage. Une modalité est d'autant plus précise
qu'elle contraint davantage l'usage. Ce n'est pas le sous-typage $`\preccurlyeq` des règles de typage, qui
descend sur l'usage ($`!\omega\,A <: {!}1\,A`) : les deux ordres sont opposés sur cette seule
composante. Les foncteurs d'inclusion du §{num "sec:c2-la-comonade-exponentielle-et"}[] réalisent
catégoriquement cette stratification sur les fragments eux-mêmes. Types dépendants, raffinements, sessions et existentielles,
dont le chapitre 3 tire parti de cette même relation sur chacune de leurs propres dimensions, ne
feront qu'instancier, pour un artefact syntaxique après l'autre, ce même treillis.
