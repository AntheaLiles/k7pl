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

#doc (Manual) "Comonade exponentielle et fragments" =>
%%%
file := "c2-la-comonade-exponentielle-et"
tag := "c2-la-comonade-exponentielle-et"
%%%

{label "sec:c2-la-comonade-exponentielle-et"}

L'exponentielle vient de Girard, qui distingue les fragments cartésien, affine et linéaire comme
restrictions successives de la contraction et de l'affaiblissement, et isole $`!` comme l'opérateur
les restituant à la demande. Sa traduction de l'implication intuitionniste en $`!A \multimap B`
établit que rien ne se perd à descendre au fragment linéaire — résultat dont la complétude pleine a
depuis été démontrée {cite "toninhoInterconnectabilitySessionBasedLogical2018"}[], et sur lequel
repose la sédimentation triadique tout entière. La formalisation catégorique exacte s'est révélée
plus délicate que l'énoncé logique : les premières propositions, identifiant $`!` à un foncteur muni
des isomorphismes $`!(A \& B) \cong \, !A \otimes \, !B` et $`! \top \cong I`, laissaient
sous-déterminée la compatibilité entre la comultiplication et le comonoïde induit sur chaque $`!A` —
compatibilité pourtant nécessaire à la cartésianité de la catégorie de co-Kleisli. La correction est
due à Bierman, construisant sur Seely : sa définition de _catégorie linéaire_, imposant que chaque
$`\delta_A` soit un morphisme de comonoïdes, s'est imposée, et c'est elle que cette section
instancie. Schalk en donne l'exposé avec les preuves et recense les formulations équivalentes {cite "SCHALK"}[], {cite "biermanWhatCategoricalModel1995"}[].

La lignée s'est prolongée dans une direction que K7PL suit : l'exponentielle n'est pas condamnée à
être un opérateur unique. On peut l'indexer par un semi-anneau : la contraction fusionne alors deux
usages par l'addition, et l'application met le contexte de l'argument à l'échelle par la
multiplication {cite "ghicaBoundedLinearTypes2014"}[]. La modalité obtenue porte une étiquette qui
renseigne sur l'usage du contexte {cite "brunelCoreQuantitativeCoeffect2014"}[]. Sa sémantique
catégorique complète est celle d'une comonade exponentielle linéaire _indexée_, sur une structure de
gradation plus riche qu'un semi-anneau ordinaire {cite "fukiharaGeneralizedBoundedLinear2021"}[].
Aujourd'hui, la notion de modèle est établie autour d'un objet unique, l'_adjonction
linéaire-non-linéaire_, dont il est acquis qu'elle englobe les notions antérieures — catégories de
Seely, catégories de Lafont, catégories linéaires {cite "haringtonCategoricalModelsLinear2025"}[].
C'est d'elle que part la construction qui suit, l'exponentielle en étant dérivée plutôt que posée.

Soit $`F \dashv G` une adjonction monoïdale symétrique entre le fragment cartésien et le fragment
linéaire de _C_, au sens du §{num "sec:c2-adjonctions-et-enrichissement"}[]. Deux propriétés du
semi-anneau doivent être exigées avant d'aller plus loin, car le lemme de substitution en dépend et
elles ne se déduisent pas des axiomes. La _propriété du zéro-somme_ : si $`q_1 + q_2 = 0` alors
$`q_1 = q_2 = 0`. Et la _propriété du zéro-produit_ : si $`q_1 \cdot q_2 = 0` alors $`q_1 = 0` ou
$`q_2 = 0`. Elles sont ce qui rend les substitutions bien typées {cite "HUANG"}[], et $`\mathcal{R}`
les satisfait — un produit de rationnels positifs n'est nul que si un facteur l'est, et $`\omega`
absorbe sans annuler. Les satisfaire et les exiger sont deux choses, et c'est la seconde qui compte
pour une mécanisation.

Une clause sur la composante de budget, qui exige davantage que le semi-anneau ne donne. Elle
emploie la soustraction tronquée $`\ominus`, qui n'est ni l'addition ni le produit et ne s'en dérive
pas. Sa définition demande d'être écrite par cas, et le choix entre deux candidates n'est pas
indifférent :
$`\beta \ominus k \;=\; \begin{cases} \omega & \text{si } \beta = \omega\\ 0 & \text{si } \beta < k\\ \beta - k & \text{sinon} \end{cases}`
C'est la _soustraction tronquée prolongée_ en $`\omega`, et il faut dire ce qu'elle n'est pas : _ce
n'est pas le résidu de l'addition_. Le résidu — le plus petit $`x` tel que $`k + x \ge \beta` —
rendrait $`\omega \ominus \omega = 0`, puisque $`\omega + 0 \ge \omega`. {rmq}[Deux définitions qui
coïncident sur les entiers et divergent à l'infini. Celle qu'on retient est celle qui ne promet rien
qu'elle ne tienne.] La différence n'est visible qu'en $`\omega`, et elle décide de la vérité d'une
loi que six démonstrations invoquent : l'annotation se lit comme une _borne_ et non comme une
mesure, et pour une borne $`\omega \ominus \omega = \omega` est la sur-approximation sûre, quand le
résidu annoncerait un budget nul là où rien ne le garantit.

La structure requise pour cette composante est donc un monoïde commutatif _naturellement ordonné_
muni de cette soustraction, dont la part semi-anneau n'est qu'un fragment. Les conaturels la
satisfont — d'où le fait que la question ne se pose jamais en pratique —, mais la satisfaire et
l'impliquer sont deux choses, et on exige ici ce qu'on emploie. Une structure concurrente est
écartée explicitement, étant celle qu'on propose spontanément pour un budget : le semi-anneau
tropical, où le minimum tient lieu de somme. On y gagnerait le pire cas comme opération primitive~;
on y perdrait la finitude de l'axiomatisation, aucun des semi-anneaux exotiques usuellement
considérés n'ayant de base finie pour ses équations, non plus que les semi-anneaux faibles
commutatifs idempotents qui les sous-tendent {cite "acetoAxiomatizingTropicalSemirings2001"}[]. Pour
un document dont les règles doivent se vérifier par machine, une axiomatisation infinie n'est pas un
inconvénient de présentation~: c'est un obstacle. Le choix des conaturels résidués se paie donc
d'une opération de moins et s'achète une théorie équationnelle finie.

Soit par ailleurs
$`\mathcal{R} = (\mathbb{Q}_{\ge 0} \cup \{\omega\},\,+,\, \times,\, 0,\, 1,\, \le)` est le semi-anneau
ordonné d'usage : le porteur contient les rationnels positifs — les capacités de lecture divisées
du chapitre 3 en ont besoin — et un élément absorbant $`\omega` pour l'usage non contraint. Ce
dernier n'est pas une commodité ajoutée : _restreint au sous-semi-anneau des entiers_,
$`\mathcal{R}` est le type des conaturels $`\mathbb{N}_\infty`, dual coinductif des naturels, dont
il est établi qu'ils forment un semi-anneau commutatif exponentiel {cite "xieConaturalNumbersForm2025"}[].
Quatre égalités gouvernent $`\omega` et se lisent partout sans être écrites nulle part ; les voici,
car trois démonstrations en dépendent :
$$`0 \cdot \omega = 0 \qquad \omega \cdot 0 = 0 \qquad \omega + \omega = \omega \qquad \omega \cdot \omega = \omega`
$`\omega` absorbe donc l'addition et le produit, sauf devant $`0` qui l'absorbe en retour — c'est la
convention ordinaire du sous-semi-anneau des entiers étendu, et la seule qui fasse de $`0` un grade
signifiant « jamais employé ».

La restriction est à prendre au mot et la suite s'en sert. $`\mathbb{N}_\infty \subset \mathcal{R}`
est le seul fragment du porteur dont l'ordre strict soit bien fondé : sur les rationnels il ne l'est
pas, la chaîne $`1 > 1/2 > 1/4 > \dots` ne terminant jamais. Un grade et un indice de taille vivent
donc dans la même algèbre sans y avoir les mêmes droits, et
§{num "sec:c2-algebres-coalgebres-et-points"}[] pose la clause qui les sépare.

Une conséquence borne ce que cette structure peut fournir ailleurs. $`\mathcal{R}` est naturellement
ordonné, ce qui suffit à en faire un support d'évaluation pour un moteur déductif, dont la
complexité en données s'analyse en deux temps — mise à plat du programme en un système d'équations
polynomiales, puis plus petit point fixe sur le semi-anneau {cite "zhaoEvaluatingDatalogSemirings2024"}[].
Mais les deux classes pour lesquelles cette évaluation admet des algorithmes efficaces —
semi-anneaux de rang fini, semi-anneaux absorbants totalement ordonnés — ne contiennent pas
$`\mathcal{R}` : les conaturels ne sont ni de rang fini, ni absorbants au sens où $`a + a\,b = a`.
Une extension déductive n'hériterait donc pas sa borne de coût du semi-anneau des grades. Elle
évaluerait sur un semi-anneau propre — le booléen pour les règles ordinaires, qui est de rang fini
et absorbant —, structure supplémentaire et non réemploi.

Une loi de compatibilité est formulée ici avant les règles de typage (§{num "sec:g-regles"}[]),
mais sa preuve dépend du domaine exact des deux actions. Elle relie la mise à l'échelle du contexte
et le transport de l'effet ; la partie budgétaire non ambiguë se réduit au lemme arithmétique sur
$`\mathbb{N}_\infty`, tandis que l'extension au grade complet reste à établir. Les usages ultérieurs
ne doivent invoquer cette loi qu'une fois ces actions définies.

::::thm (label := "thm:distributivite_tronquee")
:::title
distributivité du produit sur la soustraction tronquée
:::

:::statement +titled
Le facteur traverse la soustraction, sauf à l'infini

Pour tous $`u, \beta, k \in \mathbb{N}_\infty` tels que $`u \neq \omega` _ou_ $`k = 0`,
$$`u \cdot (\beta \ominus k) \;=\; (u \cdot \beta) \ominus (u \cdot k).` La restriction est
nécessaire : pour $`u = \omega` et $`k \neq 0`, l'égalité est fausse quelle que soit la valeur
donnée à $`\omega \ominus \omega`.
:::

:::proofsketch
Trois cas pour l'énoncé. Si $`u = 0`, les deux membres valent $`0`. Si $`u` est fini et $`\beta`,
$`k` finis, c'est la distributivité ordinaire sur la soustraction tronquée des naturels ; si
$`\beta = \omega`, les deux membres valent $`\omega` pour $`u \neq 0`. Si $`k = 0`, la soustraction
est l'identité des deux côtés.

_Et la nécessité de la restriction, qui est ce que l'énoncé apporte._ Prenons $`u = \omega` et
$`\beta, k` finis avec $`k \neq 0`. Pour $`\beta = k`, le membre gauche vaut $`\omega \cdot 0 = 0`
et le droit $`\omega \ominus \omega` ; l'égalité demande $`\omega \ominus \omega = 0`. Pour
$`\beta = 5` et $`k = 3`, le membre gauche vaut $`\omega \cdot 2 = \omega` et le droit
$`\omega \ominus \omega` ; l'égalité demande $`\omega \ominus \omega = \omega`. Une même expression
ne peut pas valoir les deux. _Aucune définition de $`\ominus` ne rend donc la loi vraie en
$`u = \omega`_, et ce n'est pas une affaire de convention à choisir mais une restriction à porter.
:::
::::

Ce lemme arithmétique reste disponible pour une architecture où une même multiplicité agit
simultanément sur le budget et sur l'effet. Il n'est pas requis par `Scale_Usage`, qui laisse le budget
inchangé, et il ne doit donc plus être présenté comme une prémisse générale de la substitution.
::::thm (label := "thm:coherence_axiome") (status := "proposition")
:::title
condition de compatibilité de l'action graduée
:::

:::statement +titled
Le transport commute avec la mise à l'échelle dans le domaine où les deux actions sont définies

Pour tout contexte $`\Delta`, tout effet $`\varepsilon` et tout grade $`r` appartenant au domaine
où l'action $`r\cdot(-)` sur les contextes et l'action $`\varphi_r` sur les effets sont toutes deux
définies, la compatibilité requise est
$$`r \cdot \psi(\Delta, \varepsilon) \;=\; \psi\bigl(r \cdot \Delta,\ \varphi_r(\varepsilon)\bigr).`
:::

:::proofsketch
Pour le budget, la vérification voulue compare l'action de mise à l'échelle sur $`\beta` après
transport par $`\psi` et le transport après mise à l'échelle. Si une multiplicité d'exécution entière
$`n` est associée au grade dans le domaine retenu, le candidat devient
$`n(\beta \ominus k)=n\beta\ominus nk`, sous la loi arithmétique correspondante. Cette égalité
ne peut pas être étendue aux grades d'usage rationnels sans définir séparément l'action sur le budget
et l'action $`\varphi_r` sur les effets.
:::
::::

::::thm (label := "thm:coherence_usage") (status := "proposition")
:::title
cohérence de l'action d'usage
:::

:::statement +titled
Sous la factorisation de l'indice et pour tout usage $`u \in \mathcal{R}`, l'action d'usage commute
avec le transport de l'effet dès que ce transport est défini :
$$`\operatorname{Scale}_{\mathrm{Usage}}(u,\psi(\Delta,\varepsilon))
=
\psi(\operatorname{Scale}_{\mathrm{Usage}}(u,\Delta),\varepsilon).`
:::

:::proofsketch
La fonction $`\psi` laisse inchangées les composantes d'usage, de monotonie et de niveau et n'agit que
sur le budget. L'action candidate $`\operatorname{Scale}_{\mathrm{Usage}}` multiplie uniquement la
composante d'usage et laisse le budget inchangé. Les deux compositions ont donc les mêmes quatre
composantes. Aucune action $`\varphi_u` sur les effets n'est requise, ce qui rend cette loi compatible
avec les usages rationnels.
:::
::::

La loi `coherence_usage` est maintenant la condition pertinente pour l'action contextuelle
factorisée. Le lemme de substitution et les règles `Box`/`App` peuvent l'invoquer une fois le support
d'indexation et `Scale_Usage` fixés. La relation logique, la traduction et les transformations
d'effet ne doivent pas être rétroactivement présentées comme des instances de la loi générale : elles
ont leurs propres obligations, notamment pour les ré-invocations finies.

# Interface du coût budgétaire
%%%
tag := "sec:c2-interface-cout-budgetaire"
%%%

{label "sec:c2-interface-cout-budgetaire"}

Dans l'état normatif courant, la composante temporelle est une famille de couples
$`\kappa : \mathcal{L} \to (\mathbb{N}_\infty \times \mathbb{N}_\infty)` indexée par les niveaux.
Il faut donc distinguer l'agrégation de coût et la consommation budgétaire :

::::formula (label := "eq:cost-budget-interface") (kind := "formule")
```
\begin{gather*}
Cost_{\mathcal B} : (\mathbb{N}_\infty\times\mathbb{N}_\infty)^{\mathcal L} \rightharpoonup \mathbb{N}_\infty,\\
Consume(\beta,\kappa) \;:=\; \beta \ominus Cost_{\mathcal B}(\kappa).\\
\text{avec la condition d'admissibilité }\beta=\omega\text{ ou }Cost_{\mathcal B}(\kappa)\leq\beta.
\end{gather*}
```
::::

Cette interface est complétée par les agrégateurs et la scalarisation dérivés des choix normatifs. Les propriétés à vérifier restent la conservation du coût nul, la monotonie par rapport à l'ordre temporel, la sous-additivité pour les compositions d'effets et la condition d'admissibilité de la consommation.

Sous les décisions normatives — budget scalaire et borne simultanée du travail et de la profondeur par P3 — les agrégateurs sont fixés par la somme des sous-familles finies pour le travail et le supremum ponctuel pour la profondeur. La scalarisation minimale est alors `Cost_Budget=max(W,D)`. L'alternative d'un budget vectoriel reste une extension possible, mais elle n'est pas requise par les règles actuelles.

# Scalarisation minimale du budget scalaire
%%%
tag := "sec:c2-scalarisation-minimale-budget"
%%%

{label "sec:c2-scalarisation-minimale-budget"}

Pour maintenir un budget scalaire tout en bornant simultanément le travail et la profondeur, on définit, pour $`\kappa(\ell)=\langle w_\ell,s_\ell\rangle` :

::::formula (label := "eq:cost-max-both") (kind := "formule")
```
\begin{gather*}
W(\kappa)=\sup_{\substack{F\subseteq\mathcal L\\F\ \mathrm{fini}}}\sum_{\ell\in F} w_\ell,
\qquad
D(\kappa)=\sup_{\ell\in\mathcal L} s_\ell,\\
Cost_{\mathcal B}(\kappa)=Cost_Budget(\kappa)
=\max\bigl(W(\kappa),D(\kappa)\bigr).
\end{gather*}
```
::::
La construction est monotone, vaut zéro sur l'effet nul et est sous-additive pour le séquencement comme
pour la mise en parallèle. Le travail est additif dans les deux cas ; la profondeur est additive par
séquencement et se combine par maximum en parallèle, ce qui donne les inégalités nécessaires pour
une borne scalaire.

Il possède surtout une propriété de minimalité : pour toute scalarisation scalaire `C(κ)` qui satisfait
simultanément $`W(κ)\le C(κ)` et $`D(κ)\le C(κ)`, on a
`Cost_Budget(κ)≤C(κ)`. Il s'agit donc de la plus petite borne scalaire qui
domine les deux dimensions temporelles.

Sous les deux hypothèses déjà normatives — budget scalaire et borne simultanée du travail et de la
profondeur par P3 — cette propriété détermine la plus petite scalarisation admissible. Elle ne vient
pas de la comonade et ne justifie aucune multiplication supplémentaire du grade. L'alternative d'un
budget vectoriel reste une extension architecturale possible, mais elle n'est pas requise par les
règles actuelles.

Le statut est donc celui d'une _construction dérivée sous hypothèses normatives_ : les agrégateurs, la scalarisation et la condition d'admissibilité sont fixés. L'obligation restante porte sur la preuve que le coût annoncé par chaque effet est bien celui consommé par $`\psi` lors de chaque traversée.

La composition parallèle appartient au noyau des effets exposé par le chapitre 3. La famille temporelle
$`\kappa \in (\mathbb{N}_\infty\times\mathbb{N}_\infty)^{\mathcal L}` porte, à chaque niveau,
le travail et la profondeur ; le séquencement additionne les deux composantes et la mise en parallèle
additionne les travaux en prenant le maximum des profondeurs.

L'action d'itération doit être compatible avec cette composition.

::::thm (label := "thm:action_parallele") (status := "proposition")
:::title
compatibilité de l'itération et de la mise en parallèle
:::

:::statement +titled
Pour tous effets et toute multiplicité entière $`n` du domaine de l'itération :
$$`\varphi_n(\varepsilon_1 \parallel \varepsilon_2)
=
\varphi_n(\varepsilon_1) \parallel \varphi_n(\varepsilon_2).`
:::

:::proofsketch
Sur le travail, l'identité vient de la distributivité de la multiplication entière sur l'addition.
Sur la profondeur, elle vient de la monotonie de la multiplication dans le supremum :
$`n\max(s_1,s_2)=\max(ns_1,ns_2)`.
L'énoncé ne présuppose aucune transformation du budget ; celle-ci relève de `Cost_Budget`.
:::
::::

L'interface budgétaire est désormais fixée sous les hypothèses normatives retenues. Le grade porte un budget $`\beta \in \mathbb{N}_\infty`, tandis que la composante temporelle normative est la famille $`\kappa \in (\mathbb{N}_\infty\times\mathbb{N}_\infty)^{\mathcal L}`. Les agrégateurs $`W` et $`D` et la scalarisation `Cost_Budget` sont définis ci-dessous ; la consommation reste séparée et n'intervient que lorsque l'effet traverse effectivement un contexte par $`\psi`.

Une extension concurrente pourrait ultérieurement raffiner la famille temporelle par plusieurs composantes de coût, mais cette extension n'appartient pas à la définition normative actuelle. Elle ne doit donc pas décider aujourd'hui de la structure du grade ni de la consommation budgétaire.

Le rôle du budget est ainsi séparé de la mise à l'échelle d'usage : $`Scale_{\mathrm{Usage}}` laisse la composante budgétaire inchangée, tandis que `Cost_Budget` et `Consume` décrivent la consommation provoquée par un effet effectivement traversé par $`\psi`.

Il n'est pas non plus établi qu'un usage infini soit interdit dès qu'un effet a un coût non nul. L'admissibilité dépend de la condition $`Adm` et de la valeur du budget ; aucune telle exclusion ne doit être déduite de la seule factorisation de l'index.

Le rôle de l'index doit ici être séparé du rôle de l'annotation complète. La présentation historique
utilise $`\mathcal{R}` pour le semi-anneau qui porte l'usage, et la structure exponentielle est alors
une famille

$$`\{!_u\}_{u \in \mathcal{R}}`

d'endofoncteurs sur _C_. Cette construction est compatible avec une comonade graduée indexée par un
semi-anneau d'usage {cite "fukiharaGeneralizedBoundedLinear2021"}[]. Depuis que le chapitre 3
porte cependant un grade complet $`r=\langle u,m,\ell,\beta\rangle` dans $`\mathcal{G}`, il ne
s'ensuit pas que $`\mathcal{G}` soit lui-même le semi-anneau d'indexation de la comonade. Il faudrait
pour cela définir une structure algébrique complète sur $`\mathcal{G}` et vérifier ses lois.

Le manuscrit doit donc conserver trois objets distincts tant que cette correspondance n'est pas
démontrée : $`\mathcal{R}` pour le semi-anneau d'usage, $`\mathcal{G}` pour l'annotation complète
du jugement, et la famille de modes qui gouverne les permissions structurelles. Les tests des séances
35 à 52 soutiennent désormais une architecture de référence factorisée : la comonade est indexée par
$`\mathcal{R}` et les autres composantes de $`r` sont conservées comme annotations et interfaces
orthogonales. Une indexation par un porteur plus riche reste mathématiquement possible comme
généralisation, mais elle n'est plus requise par les règles actuelles. La factorisation doit encore
être validée par les lois sémantiques de l'interface.

En conséquence, les formules ci-dessous sont l'interface attendue de la comonade d'usage. Leur
extension au grade complet $`\mathcal{G}` est une obligation de cohérence distincte.

# Interface minimale de l'exponentielle
%%%
tag := "sec:c2-interface-minimale-exponentielle"
%%%

Pour rendre cette obligation testable, on note $`I` le support effectif de l'indexation de $`!`. Une
interface minimale est constituée de

::::formula (label := "eq:interface-bang") (kind := "formule")
```
\begin{gather*}
! : I \to \operatorname{End}(\mathcal{C}),\qquad
0_I\in I,\qquad
+_I : I\times I\to I,\qquad
\cdot_I : I\times I\to I,\
w_A : !_{0_I}A\to A,\qquad
c_{i,j,A}: !_{i+_I j}A\to !_i A\otimes !_j A,\
\operatorname{coerce}_{i,j,A}: !_i A\to !_j A
\quad\text{pour les couples d'indices admissibles.}
\end{gather*}
```
::::

Les deux opérations sur les indices n'ont pas nécessairement le même rôle. $`+_I` porte la
décomposition d'une ressource exponentiée dans $`c`, tandis que $`\cdot_I` porte la composition
des morphismes dans la structure graduée. Dans une grade algebra classique, ces deux opérations
correspondent respectivement à l'addition et à la multiplication ; dans une architecture
hétérogène ou multi-objet, leur réalisation peut demander des morphismes supplémentaires.

Les obligations minimales sont alors la neutralité de $`+_I` par $`0_I`, la neutralité de
$`\cdot_I` par un indice $`1_I`, l'associativité des opérations au niveau requis par la
construction choisie, et la compatibilité de $`w`, $`c` et des coercions avec ces opérations.
Aucune de ces obligations ne fixe encore $`I`.

Le choix historique $`I=\mathcal{R}` est directement compatible avec l'interface comonadique
d'usage déjà décrite. Le choix $`I=\mathcal{G}` exige en revanche une structure algébrique
supplémentaire sur le grade complet. La syntaxe actuelle $`!_r` ne suffit donc pas à établir le
second choix.

Cette interface est introduite pour distinguer ce qui relève de l'indexation de $`!` de ce qui
relève de la mise à l'échelle des contextes. En particulier, $`r\cdot\Delta` n'est pas identifié
ici à $`\cdot_I` : cette identification reste une propriété à démontrer, et peut échouer même si
l'indexation complète est retenue.

## Candidat de factorisation de l'index complet
%%%
tag := "sec:c2-candidat-factorisation-index-complet"
%%%

{label "sec:c2-candidat-factorisation-index-complet"}

Les tests du chapitre 3 permettent de préciser l'architecture candidate sans encore la transformer en
définition normative :

::::formula (label := "eq:index-factorisation-grade-complet") (kind := "formule")
```
\begin{gather*}
\pi_U : \mathcal{G}\to\mathcal{R},
\qquad
\pi_U(\langle u,m,\ell,\beta\rangle)=u,\
\operatorname{Bang}_{\mathcal G}(r,A)
\;:=\;
!_{\pi_U(r)}A.
\end{gather*}
```
::::

La formule définit une factorisation de l'indice, pas un effacement du grade. Le type syntaxique
`!_r A` peut ainsi conserver l'annotation complète `r`, tandis que le noyau comonadique ne reçoit
que son indice d'usage. Les propriétés qui consultent m, ell ou beta restent attachées à
l'annotation et à leurs interprétations propres.

Cette lecture n'est recevable qu'avec une compatibilité des deux niveaux. Il faut notamment :

```
r \preccurlyeq r'
\;\Longrightarrow\;
\pi_U(r)\geq\pi_U(r')
```

pour que la projection de la subsomption complète porte la même direction que la coercion de
l'exponentielle d'usage, ainsi qu'une action `Scale_Usage` compatible avec `Box`, `App` et
substitution. La préservation du niveau dans l'interprétation logique et la consommation du budget
par `Consume` doivent rester indépendantes de cette projection.

Le statut est donc celui d'un _candidat d'architecture_. Il n'abolit ni les obligations de preuve de
la substitution, ni l'existence possible d'une architecture plus riche où l'indice de `!` serait
lui-même un objet multi-composante.

## Action candidate de mise à l'échelle d'usage
%%%
tag := "sec:c2-action-candidate-scale-usage"
%%%

Une fois l'indice factorisé, la mise à l'échelle contextuelle peut être isolée comme une action
sur le facteur d'usage. Le candidat est :

::::formula (label := "eq:scale-usage-grade") (kind := "formule")
```
\begin{equation*}
\operatorname{Scale}_{\mathrm{Usage}}(a,\langle u,m,\ell,\beta\rangle)
=
\langle a\cdot u,m,\ell,\beta\rangle,
\qquad a,u\in\mathcal{R}.
\end{equation*}
```
::::

Sur un contexte, l'action s'applique liaison par liaison. Elle ne définit donc aucune multiplication
scalaire du niveau, de la monotonie ou du budget. Le budget conserve sa valeur jusqu'à l'application
explicite de `Consume` par transport d'un effet.

Les lois minimales requises par les règles sont :

`Scale_Usage(1,Δ)=Δ`,

`Scale_Usage(a,Scale_Usage(b,Δ))=Scale_Usage(a·b,Δ)`,

`Scale_Usage(a,Δ₁+Δ₂)=Scale_Usage(a,Δ₁)+Scale_Usage(a,Δ₂)` lorsqu'une addition de contextes est définie,

et la monotonie de l'action par rapport à l'ordre de sous-typage sur les grades.

Ces lois portent sur l'action contextuelle. Elles ne constituent pas une définition de `MulG`, et
elles ne disent rien à elles seules de la transformation des effets par `φ_n`. Le point temporel
scalaire/bidimensionnel reste donc hors du domaine de cette action.

_Statut : candidat d'architecture._ Les lois sont vérifiées algébriquement sur la composante d'usage
et par identité sur les autres composantes ; leur emploi comme lois normatives du langage reste
conditionné par la définition finale des contextes et des conversions du grade complet.

## Clôture minimale de la gradation d'usage
%%%
tag := "sec:c2-cloture-minimale-gradation-usage"
%%%

{label "sec:c2-cloture-minimale-gradation-usage"}

Une fois le support fixé à $`I=\mathcal{R}`, la dette de gradation indexée se réduit à une famille
finie de lois. Pour les usages admissibles, il faut disposer d'une identité, d'une composition des
coercions et de la compatibilité de la comonade avec la décomposition graduée :

::::formula (label := "eq:lois-coercion-usage") (kind := "formule")
```
\begin{gather*}
\operatorname{coerce}_{u,u,A}=\operatorname{id}_{!_uA},\\
\operatorname{coerce}_{u,w,A}=\operatorname{coerce}_{v,w,A}\circ
\operatorname{coerce}_{u,v,A},\\
c_{u,v,A}:!_{u+v}A\to !_uA\otimes !_vA,\\
w_A:!_0A\to A.
\end{gather*}
```
::::

Les règles de typage ajoutent ensuite trois conditions de liaison au grade complet :

1. $`r\preccurlyeq r'` doit impliquer $`\pi_U(r)\geq\pi_U(r')` ;
2. `Box`, `App` et substitution doivent utiliser $`Scale_{\mathrm{Usage}}(\pi_U(r),-)` ;
3. les composantes restantes du grade doivent conserver leurs propres conversions et ne doivent pas
être introduites dans l'index de la comonade sans obligation indépendante.

Ces clauses constituent la clôture minimale recherchée. Elles ne prouvent pas la cohérence sémantique
de toutes les conversions ; elles isolent exactement les obligations à démontrer pour que la
factorisation $`\mathcal{G}\to\mathcal{R}\to !` soit utilisable par la substitution et `SubBox`.

Le statut de cette section est donc propositionnel : aucune multiplication globale de $`\mathcal{G}`
n'est requise pour satisfaire ces lois.

Ce que le paragraphe précédent décrit n'est donc pas une structure primitive mais le résultat d'une
composition, et l'ordre dans lequel ce chapitre l'expose reflète l'ordre dans lequel la littérature
l'a établie. Benton a montré que l'exponentielle de la logique linéaire se scinde en deux modalités
adjointes reliant une logique intuitionniste à une logique linéaire. Fujii, Katsumata et Melliès ont
établi que toute monade graduée se factorise comme une _action stricte_ transportée le long d'un
foncteur adjoint à gauche, et de deux manières — l'une généralisant Eilenberg-Moore, l'autre Kleisli {cite "fujiiFormalTheoryGraded2016"}[].
K7PL en emploie le dual, pour une comonade graduée, et retient la factorisation généralisant
Kleisli, puisque c'est la structure de Kleisli graduée que la suite de ce chapitre construit. La
conjonction des deux résultats donne, pour les modalités graduées, une paire de modalités adjointes
reliant une logique graduée à une logique linéaire graduée {cite "vollmerMixedLinearGraded2024"}[].

De cette dérivation suit ce dont le chapitre 3 aura besoin, et qui ne se lisait pas sur la comonade
seule.

Cette décomposition n'est pas une curiosité de présentation : c'est elle qui donne au chapitre 3 le
lieu où loger le partage. Une catégorie monoïdale symétrique dénote par $`\otimes` la _séparation_ —
deux objets joints par le tenseur sont deux ressources indépendantes —, et scinder un grade par la
contraction produit encore deux objets séparés, non deux vues d'une même ressource. Le partage exige
une diagonale, donc le fragment cartésien ; c'est du côté cartésien de l'adjonction qu'il vit, et
non d'une division opérée du côté linéaire. Le point vaut d'être souligné parce que la littérature
le documente en creux : faire cohabiter dans un même niveau un produit qui sépare et un produit qui
partage brise la correction, et la parade connue est la stratification à deux niveaux {cite "deamorimSeparatedSharedEffects2023"}[].
Intuitivement, dans la syntaxe complète, $`!_r A` dénote une ressource $`A` portant l'annotation $`r` ;
la construction comonadique actuellement établie porte cependant sur l'indice d'usage.

Deux précisions négatives, qui évitent au lecteur de situer _C_ ailleurs qu'elle n'est. K7PL ne
suppose pas son exponentielle _libre_ : la structure de comonoïde gradué y est donnée, non
construite comme comonoïde cocommutatif cofibre sur $`A`, de sorte que _C_ n'est pas une catégorie
de Lafont. Et K7PL ne suppose pas de biproduits finis. Ces deux abstentions vont ensemble, et il
faut dire dans quel sens : c'est la _liberté_ de l'exponentielle qui porte le risque, l'additivité
n'y suffisant pas. Une exponentielle libre jointe aux biproduits finis donne la structure de
catégorie différentielle, donc une codéréliction {cite "bluteDifferentialCategories2006"}[], {cite "lemayCoderelictionsFreeExponential2021"}[].
La réciproque est fausse, et récemment établie comme telle : une codéréliction _induit_
l'enrichissement additif, par convolution bialgébrique, de sorte que l'implication ne remonte pas —
une catégorie additive n'a pas pour autant de codéréliction. Il est en outre établi qu'une
codéréliction, lorsqu'elle existe, est _unique_, ce qui rend la vérification décidable en principe
plutôt qu'affaire d'appréciation.

L'abstention de K7PL est donc plus robuste que sa formulation ne le laissait croire, et c'est la
première qui la porte : l'exponentielle étant _donnée_ et non construite comme cofibre, aucun des
deux résultats ne s'applique. {rmq}[Ce qui protège n'est pas de refuser l'addition, c'est de refuser
la liberté de l'exponentielle. La nuance décide de quels modèles restent admissibles.] Le langage
n'a aucun usage de la structure différentielle, et n'a pas à en hériter par inadvertance ; mais un
modèle concret peut légitimement en porter davantage que le langage n'en déclare, et c'est le cas
ordinaire plutôt que l'exception.

Le gain n'est pas seulement d'expressivité, il est aussi d'économie : les trois fragments cessent
d'être des constructions parallèles pour devenir trois lectures d'un même dispositif modal. Les
opérations dont le chapitre 3 a besoin sont alors rattachées à des interfaces explicites : agrégation
des annotations, comonade indexée et mise à l'échelle. La définition complète de leur interaction reste
dépendante du support d'indexation et des actions retenues.

L'indexation par $`\mathcal{R}` n'est pas un ornement ajouté à une structure qui tiendrait sans elle :
c'est ce qui rend $`w` et $`c` opérants. Dans la présentation non graduée, chaque $`!A` porte une
structure de comonoïde commutatif vis-à-vis de $`\otimes`, l'affaiblissement et la contraction y
étant disponibles ou non — un choix binaire, qui ne permet que trois configurations. Ici, le
comonoïde est _gradué_ sur l'indice d'usage : $`w` ne s'applique qu'à $`!_0`, et $`c` ne décompose
$`!_{u+v}` qu'en respectant l'addition de l'indice. L'axiomatisation de la compatibilité entre ce comonoïde et le couple
$`(\varepsilon, \delta)` reste celle que la lignée rappelée ci-dessus a établie, indexée ; K7PL
l'adopte sans réserve dans sa version corrigée et graduée.

Une précision est nécessaire avant de construire, car l'incise « $`\otimes` restreint aux objets
exponentiés » que l'on trouve souvent recouvre une difficulté réelle. Il n'existe en général pas de
structure monoïdale sur la catégorie des coalgèbres libres — isomorphe à la catégorie de co-Kleisli
—, le tenseur ne s'y faisant pas bifoncteur faute de définition sensée sur les morphismes. La
structure de produit ne s'obtient qu'en plongeant cette catégorie dans une catégorie plus large, où
le produit tensoriel de deux objets a $`!A \otimes !B` pour objet sous-jacent {cite "SCHALK"}[].
C'est ce détour, et non une restriction, que la construction qui suit emprunte.

Chaque indice d'usage ne définit pas sa propre catégorie, et l'écrire ainsi serait faux. Ce que la
comonade graduée engendre est une _structure de Kleisli graduée_ $`\mathbf{Kl}_{\mathcal{R}}` : sur
les objets de _C_, la famille des ensembles de morphismes
$`\text{Hom}^u(A,B) := \text{Hom}_{\mathcal{C}}(\,!_u A, B)`, indexée par le semi-anneau d'usage.
Elle porte une composition
$`\text{Hom}^u(A,B) \times \text{Hom}^v(B,C) \to \text{Hom}^{u \times v}(A,C)`, donnée par
$`g \circ \, !_s f \circ \delta_{s,r}`. Le produit des indices d'usage gouverne donc la
composition dans cette structure de Kleisli graduée. Cette composition n'est pas interne à un
grade, et l'identité n'existe qu'au grade neutre, où elle est
$`\varepsilon_A`. L'action sur les contextes utilisée par K7PL est compatible avec ce calcul
d'indice, mais cette compatibilité ne constitue pas une identification avec une multiplication
globale du grade complet.

Deux indices d'usage font exception, et ce sont les seuls qui portent ici une catégorie. À l'indice neutre
$`u = 1`, la composition est interne et l'identité existe : $`\text{Hom}^1` est la catégorie de
co-Kleisli de la comonade $`!_1`. Au grade absorbant $`\omega`, le comonoïde gradué munit
$`\mathcal{C}_{!_\omega}` d'un objet terminal ($`I`, via $`w`, disponible puisque $`0 \le \omega`)
et de produits binaires ($`\otimes` restreint aux objets exponentiés, via $`c_{\omega,\omega}`, la
somme y étant absorbante). La formalisation corrigée rappelée ci-dessus établit précisément que
cette structure satisfait les lois d'une catégorie cartésienne.

Deux statuts se distinguent ici, et les confondre serait se dénigrer. Que les foncteurs d'inclusion
entre fragments soient fidèles est immédiat, vérifiable sur la construction. Que la catégorie de
co-Kleisli du grade absorbant soit authentiquement cartésienne n'est pas assumé non plus : cela suit
de la définition de catégorie linéaire retenue ci-dessus, dont la preuve est publiée et dont des
formulations équivalentes sont établies {cite "SCHALK"}[], {cite "biermanWhatCategoricalModel1995"}[].

Ce que ce document assume est le théorème de cohérence proprement dit — celui qui garantit que les
diagrammes construits à partir des isomorphismes naturels commutent —, et il l'assume comme le fait
la littérature primaire dont il reprend les constructions, qui le référence sans le redémontrer {cite "bentonLinearLcalculusCategorical1993"}[], {cite "kellyCoherenceClosedCategories1971"}[].
Deux précisions s'imposent sur cet emprunt, car il porte sur deux choses d'espèce différente que le
mot « assumer » recouvrirait sans les distinguer.

La première est que la cohérence emprunte à _deux_ régimes. Pour la part monoïdale, c'est bien un
théorème publié. La catégorie close de Kelly et Mac Lane est une catégorie munie du tenseur et de
l'exponentiation interne, d'une unité, des isomorphismes d'associativité et de symétrie et de six
diagrammes d'axiomes — structure que leurs auteurs disent non essentiellement différente d'une
monoïdale symétrique close. Leur théorème garantit la commutation de tout diagramme bâti sur ces
isomorphismes. Pour la part _graduée_, en revanche, il n'y a pas de théorème à assumer : les lois de
la comonade graduée — counité, coassociativité indexée par le produit du semi-anneau — sont posées
comme _axiomes_ de la structure. Un théorème de cohérence sert là où les isomorphismes ne sont pas
donnés commutants et doivent être prouvés tels ; ici ils le sont par définition. Assumer un théorème
et poser un axiome ne sont pas le même acte, et le lecteur a le droit de savoir lequel porte quoi.

La seconde est que la chaîne d'hypothèses de l'adjonction, telle que la littérature l'exhibe, compte
_trois_ maillons et non deux. Une comonade monoïdale sur une monoïdale symétrique donne une
structure monoïdale aux coalgèbres. La clôture de la base rend les coalgèbres libres exponentiables.
Et c'est seulement _si de plus_ la catégorie des coalgèbres libres est close par le tenseur qu'elle
est elle-même monoïdale symétrique close. Ce document pose le premier maillon par P1, dérive le
deuxième de l'adjonction monoïdale — une composée de foncteurs monoïdaux étant monoïdale —, et
acquitte le troisième par le choix de la définition de catégorie linéaire, qui l'inclut. C'est ce
troisième maillon que ce choix paie, et non un emprunt tacite. Le cas gradué s'y transpose sans rien
demander de neuf : la clause « toute puissance d'une coalgèbre libre est libre » y devient la
relation entre $`!_u A \otimes !_v A` et $`!_{u+v} A`, c'est-à-dire le comonoïde gradué posé
ci-dessus. La frontière passe là : l'agencement des briques est propre à K7PL, la sémantique de la
logique linéaire ne l'est pas.

$`\mathcal{C}_{!_\omega}` est donc cartésienne : c'est le fragment cartésien de la sédimentation
triadique, et la partie $`\Delta_{\omega}` du contexte germinal n'est que la notation, hors de
$`\mathcal{C}_{!_\omega}`, pour un objet vu à travers cette catégorie. C'est ce que le chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) annonçait en écartant la zone $`\Gamma` de la présentation
usuelle. La construction qui précède en est la justification, et c'est sur les grades — non sur une
disposition de zones — que l'adjonction dont ce paragraphe établit le côté cartésien se lit.

Les fragments et les modalités doivent maintenant être séparés en deux objets qui avaient été
rapprochés à tort. La théorie des modes contrôle les règles structurelles ; les intervalles de grades
décrivent, pour la syntaxe de K7PL, l'ensemble des annotations d'usage admissibles. Une inclusion
d'intervalles n'est donc pas, à elle seule, un morphisme de modes.

Au sens de la théorie des modes introduite par Hanukaev et Eades, un mode est un triplet
$`(R_m,\mathrm{Cont}(m),\mathrm{Weak}(m))`, où $`R_m` est une algèbre de grades, $`\mathrm{Cont}(m)`
un idéal de grades contractables et $`\mathrm{Weak}(m)` un prédicat booléen d'affaiblissement
{cite "hanukaevUnificationGradedSubstructural2026"}[]. Pour le porteur commun $`\mathcal{R}` de K7PL,
la réalisation structurale candidate est :

$$`\begin{aligned}
M_{\mathrm{Lin}}   &= (\mathcal{R},\{0\},\mathrm{false}),\\
M_{\mathrm{Aff}}   &= (\mathcal{R},\{0\},\mathrm{true}),\\
M_{\mathrm{Rel}}   &= (\mathcal{R},\mathcal{R},\mathrm{false}),\\
M_{\mathrm{Unr}}   &= (\mathcal{R},\mathcal{R},\mathrm{true}).
\end{aligned}`

Cette écriture ne remplace pas la définition des modalités syntaxiques. Elle fournit la structure
à partir de laquelle les propriétés de contraction, d'affaiblissement et de morphisme peuvent être
raisonnées séparément. Les applications identité de $`\mathcal{R}` donnent alors les morphismes

$$`M_{\mathrm{Lin}} \to M_{\mathrm{Aff}},\qquad
M_{\mathrm{Lin}} \to M_{\mathrm{Rel}},\qquad
M_{\mathrm{Aff}} \to M_{\mathrm{Unr}},\qquad
M_{\mathrm{Rel}} \to M_{\mathrm{Unr}}.`

Les deux comparaisons croisées sont interdites : l'application identité ne préserve pas
$`\mathrm{Weak}` de $`M_{\mathrm{Aff}}` vers $`M_{\mathrm{Rel}}`, et elle n'envoie pas l'ensemble
$`\mathrm{Cont}(M_{\mathrm{Rel}})=\mathcal{R}` dans $`\mathrm{Cont}(M_{\mathrm{Aff}})=\{0\}`.
La structure des modes est donc un diamant, dont la chaîne Lin–Aff–Unr n'est qu'une branche.

Les modalités syntaxiques restent, elles, des strates d'usage dans le porteur commun :

$$`U_{\mathrm{Lin}}=[1..1],\qquad
U_{\mathrm{Aff}}=[0..1],\qquad
U_{\mathrm{Rel}}=[1..\omega],\qquad
U_{\mathrm{Unr}}=[0..\omega].`

Ces ensembles ne sont pas des sous-algèbres du semi-anneau en général : $`[0..1]`, par exemple, n'est
pas clos par l'addition. Ils ne doivent donc pas être utilisés comme les $`R_m` de la définition
d'un mode. Leur inclusion ordinaire

$$`U_{\mathrm{Lin}}\subseteq U_{\mathrm{Aff}}\subseteq U_{\mathrm{Unr}},
\qquad
U_{\mathrm{Lin}}\subseteq U_{\mathrm{Rel}}\subseteq U_{\mathrm{Unr}}`

est un fait ensembliste sur les annotations d'usage. L'incomparabilité de $`U_{\mathrm{Aff}}` et
$`U_{\mathrm{Rel}}` explicite le quatrième cas sans lui attribuer, par cette seule inclusion, un
morphisme de modes.

La conséquence pour la sédimentation est méthodologique. Les foncteurs d'inclusion entre fragments
ne peuvent plus être justifiés par une simple inclusion de ces quatre intervalles. Leur existence et
leur fidélité doivent être établies à partir des règles structurelles effectivement autorisées et
de leur interprétation dans $`\mathcal{C}`. La présente section en retient donc l'existence comme
construction à vérifier, et non comme conséquence gratuite de la notation par intervalles.
::::figure (label := "fig:fragments-emboites") (src := "fragments-nestings") (alt := "Trois cadres emboites, du plus large au plus etroit — fragment cartesien, qui admet affaiblissement et contraction ; fragment affine, qui n'admet que l'affaiblissement ; fragment lineaire strict, qui n'admet ni l'un ni l'autre.") (width := "90")
:::caption
Emboîtement des trois fragments logiques par restriction successive des règles structurelles
:::

:::desc
Les trois fragments comme trois restrictions successives d'une même construction, et non comme trois
systèmes bâtis séparément.
:::
::::

La construction sémantique doit donc rester distincte de la stratification syntaxique. Les
catégories obtenues en restreignant les règles structurelles demandent un foncteur d'inclusion
défini sur les dérivations, puis une preuve de fidélité et de préservation de la dénotation. La
simple inclusion des ensembles $`U_m` n'établit aucune de ces propriétés. Les formules
$`F_{1 \to 2}` et $`F_{2 \to 3}` restent des objectifs de la construction, mais leur justification
doit désormais partir des modes structurels et du jugement, et non d'une inclusion d'intervalles.

Cette séparation referme la confusion initiale : $`\mathcal{R}` est le semi-anneau de la
gradation quantitative ; $`M_m` décrit les permissions structurelles ; $`U_m` décrit les grades
d'usage admissibles dans la syntaxe ; et les foncteurs entre fragments sont des objets sémantiques
supplémentaires. Aucun de ces quatre objets ne peut être identifié aux trois autres sans preuve.

