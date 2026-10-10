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

#doc (Manual) "Six schémas de métathéorie" =>
%%%
file := "c2-six-schemas-de-metatheorie"
tag := "c2-six-schemas-de-metatheorie"
%%%

{label "sec:c2-six-schemas-de-metatheorie"}

Six énoncés reviennent dans ce document sous des habillages différents, et chacun est démontré ici
une fois pour toutes. Ce ne sont pas des théorèmes sur K7PL mais sur la forme de ses démonstrations :
les chapitres qui suivent les instancient plutôt qu'ils ne les refont. {rmq}[Écrire le schéma avant
ses instances évite d'écrire trois fois la même récurrence, et rend visible ce qu'elles partagent.]

Le premier gouverne toute transformation qui traverse une substitution. L'expansion d'une macro, le
désucrage d'une forme de surface, la traduction vers le métalangage et l'abaissement vers la
représentation intermédiaire ont ceci de commun qu'ils sont définis par récurrence sur la structure
des termes et qu'ils doivent commuter avec la substitution — faute de quoi le sens dépendrait de
l'ordre dans lequel on transforme et on substitue.

::::lemma (label := "thm:schema_commutation") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "Substitution et transformations syntaxiques")
:::title
schéma de commutation
:::

:::statement +titled
Transformer puis substituer, ou l'inverse

Soit $`T` une transformation définie par récurrence sur la structure des termes, qui n'introduit
aucune variable libre et respecte les liaisons. Alors, à renommage près des variables liées,
$$`T \circ \text{subst} \;=\; \text{subst} \circ T.`

Le schéma est paramétré par trois données, et les nommer dit ce qu'une instance doit fournir : le
_langage objet_ sur lequel $`T` opère ; les _règles de construction_ par lesquelles la récurrence
procède ; et la _discipline de liaison_, qui fixe l'ordre d'occurrence et l'évitement de capture.
:::

:::proofsketch
Par récurrence sur le terme. Les cas des constructeurs sont immédiats, $`T` y étant définie
composante par composante. Le seul cas non immédiat est celui du lieur : il demande que la variable
substituée ne soit pas capturée par le lieur que $`T` produit, ce que l'hypothèse d'hygiène fournit.
:::

::::
Le deuxième gouverne les traductions d'un système de règles vers un autre. Il dit ce qu'il faut
établir, et rien de plus : non pas que la traduction préserve le jugement, mais que chaque règle de
la source a une dérivation pour image.

::::lemma (label := "thm:schema_preservation") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "Traduction de systèmes de règles")
:::title
schéma de préservation par traduction
:::

:::statement +titled
Une traduction dérivante préserve le jugement

Soit $`\llbracket \cdot \rrbracket` une traduction d'un système de règles vers un autre. Si l'image
de chaque règle de la source est une _dérivation_ de la cible, alors toute dérivation
$`\mathcal{D}_s : \Delta_s \vdash t_s` a pour image une dérivation
$`\mathcal{D}_t : \Delta_t \vdash \llbracket t_s \rrbracket`.
:::

:::proofsketch
Par récurrence sur $`\mathcal{D}_s`. Chaque règle fournit sa dérivation image par hypothèse ; la
composition de dérivations étant admissible dans la cible, les images se recollent. Le travail réel
d'une instance est donc d'exhiber une dérivation par règle, et l'énoncé général n'a pas à être
refait.
:::

::::
Le troisième est un fait de théorie des graphes, employé deux fois par ce document et qu'il serait
vain de démontrer deux fois.

::::lemma (label := "thm:tri_topologique") (level := "langage") (role := "lemma") (state := "supported") (evidence := "proofsketch") (scope := "Graphes finis")
:::title
tri topologique
:::

:::statement +titled
Un graphe fini acyclique s'ordonne

Tout graphe orienté fini et acyclique admet un ordre total de ses sommets tel que toute arête aille
d'un sommet plus petit vers un sommet plus grand.
:::

:::proofsketch
Par récurrence sur le nombre de sommets. Un graphe fini acyclique non vide possède un sommet sans
prédécesseur : sinon, en remontant les prédécesseurs, la finitude force la répétition d'un sommet,
donc un cycle. Ce sommet est placé en tête, et l'hypothèse d'induction ordonne le reste.
:::

::::
Un quatrième schéma gouverne tout ce qui, dans ce document, _retire_. Cinq constructions
l'instancient sans qu'aucune ne le nomme, et leur parenté n'est aujourd'hui qu'une ressemblance de
forme.

::::lemma (label := "thm:schema_restriction") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "Restriction de structures")
:::title
schéma de restriction
:::

:::statement +titled
Retirer sans déformer

Soit $`p` un critère sur les éléments d'une structure, et $`\rho_p` l'opération qui retire ceux que
$`p` exclut. Si $`p` est _stable par les opérations de la structure_ — l'image d'un élément retenu
ne contient que des éléments retenus — alors $`\rho_p` est un morphisme : elle commute à la
composition et préserve l'identité.
:::

:::proofsketch
Par récurrence sur la structure. Le seul cas non immédiat est celui d'une opération dont un argument
est retiré et l'autre non ; la stabilité de $`p` l'exclut, puisqu'elle demande que le retrait d'un
élément entraîne celui de tout ce qui en dépend. C'est cette condition, et elle seule, qui sépare
une restriction d'une mutilation.
:::

::::
Cinq constructions en sont des instances, et les reconnaître comme telles dispense de vérifier cinq
fois la même chose. La _projection conservatrice_ retire les opérations d'une sorte et garde le
temps ; la _projection observationnelle_ retire ce qui excède un niveau, temps compris ;
l'_effacement indexé_ retire ce qui est gradué au-dessus d'un niveau ; la _restriction d'un espace
de noms_ retire les arêtes hors d'une dimension ; et la _purge de spécification_ de la dernière
phase de compilation retire les blocs qui n'ont servi qu'à vérifier. {rmq}[Cinq retraits, une
condition. Ce qui change d'une instance à l'autre est le critère, jamais l'argument.]

Ce que le schéma apporte n'est pas l'économie de cinq preuves, c'est la _condition_ qu'elles
partagent et qu'aucune n'énonçait : une restriction n'est un morphisme que si son critère est
stable. Les deux projections du chapitre suivant diffèrent précisément par leur critère, et c'est
pourquoi les confondre ouvrirait le canal que l'une d'elles prétend fermer — ce n'est pas une
coïncidence malheureuse mais une conséquence du schéma.

Un cinquième schéma gouverne tout ce qui, dans ce document, _répète_. Cinq mécanismes font la même
chose sous cinq noms, et aucun ne renvoie aux autres.

::::thm (label := "thm:schema_reinvocation")
:::title
schéma de ré-invocation bornée
:::

:::statement +titled
Employer $`n` fois, c'est invoquer $`n` fois en séquence
:::

Pour $`t` de contexte $`\Delta` et d'effet $`\varepsilon`, et pour un entier fini $`n \in \mathbb{N}_\infty`,
la ré-invocation $`\mathsf{reinvo}(n,t)` combine deux actions distinctes : le contexte est mis à
l'échelle par $`\operatorname{Scale}_{\mathrm{Usage}}(n,\Delta)` et l'effet devient
$`\varphi_n(\varepsilon)`. L'associativité requiert séparément la composition des mises à l'échelle
et celle des transformations d'effet ; l'unité est $`n=1`.

:::proofsketch
La mise à l'échelle du contexte est celle de la modalité factorisée. La loi de coût est l'action
$`\varphi_n` sur les effets. Leur compatibilité constitue une obligation propre à la ré-invocation
finie ; elle n'est pas une instance automatique d'une loi uniforme sur le grade complet. Sur le
budget, cette compatibilité reste distincte de $`Scale_Usage` et ne doit pas introduire une
multiplication du budget tant qu'aucune telle action n'est définie.
:::
::::

Certaines constructions en sont des instances directes : la traduction d'un grade fini, le parcours
d'un vecteur, l'opération à portée et l'image bornée du point fixe déductif. L'expansion d'une macro
n'en est pas une instance directe : elle conserve l'ordre des occurrences des arguments et compose
leurs effets sans convertir le grade déclaré en multiplicité d'effet.
{rmq}[Le schéma décrit une ré-invocation homogène ; la macro relève d'un schéma plus général de
substitution séquentielle. Les deux partagent l'action contextuelle d'usage, mais leurs obligations
sur les effets sont différentes.]


Un sixième schéma est le plus général des six, et il absorbe une part des précédents. Tout ce qui,
dans ce document, _traduit une représentation riche vers une représentation plus pauvre_ —
l'élaboration de la syntaxe de surface, l'effacement de la dernière phase, l'abaissement vers la
représentation intermédiaire, la traduction vers le métalangage — obéit au même énoncé.

::::lemma (label := "thm:schema_effacement") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "Morphism de raffinement conditionnel aux lois de commutation, préservation et fibre ; les trois conséquences ne sont pas acquittées par le seul schéma.")
:::title
schéma d'effacement
:::

:::statement +titled
Une transformation hygiénique est un morphisme de systèmes de raffinement

Soit $`T` une transformation définie par récurrence sur la structure, n'introduisant aucune variable
libre et respectant les liaisons. Alors $`T` induit un morphisme de systèmes de raffinement : elle
envoie une dérivation sur une dérivation, commute à la substitution, et ce qu'elle oublie est
exactement la fibre.
:::

:::proofsketch
Trois conditions, et chacune est déjà établie. La commutation à la substitution est le
théorème {num "thm:schema_commutation"}[]. L'envoi des dérivations sur des dérivations est le
théorème {num "thm:schema_preservation"}[], dont la condition est que l'image de chaque règle soit
une dérivation. Que l'oubli soit une fibre est le théorème {num "thm:raffinement"}[], qui construit
le système de raffinement dont la traduction est le foncteur.
:::

::::
Quatre constructions en sont des instances, et la quatrième est celle qui coûtait le plus cher : la
fidélité de l'interpréteur de référence. Elle cesse d'être une propriété à établir construction par
construction pour devenir la vérification de trois conditions sur une transformation. {rmq}[Ce qui
demandait une induction par construction demande désormais trois conditions par transformation.
C'est le même travail divisé par le nombre de constructions.]

Ce schéma dit en outre _ce qu'il ne faut pas confondre_, et c'est son second usage. Préserver le
typage, simuler l'exécution et être correct vis-à-vis de la machine sont trois énoncés distincts~;
le schéma établit le premier, et les deux autres demeurent. Les glissements entre eux sont la classe
d'erreur que ce document a le plus de mal à éviter, parce que les trois s'énoncent avec les mêmes
mots.

Un septième énoncé mérite le même traitement, et il porte sur les capacités plutôt que sur les
termes. Le chapitre 4 l'emploie deux fois — pour la mémoire partagée et pour la frontière étrangère
— et l'argument y est le même à un mot près.

::::lemma (label := "thm:lemme_capacite") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "Ressources linéaires / accès concurrents")
:::title
lemme de capacité
:::

:::statement +titled
Deux accès concurrents n'ont pas de dérivation

Soit une ressource $`r` dont l'accès n'est dérivable que d'une liaison portant $`\text{Cap}(r)`. Si
$`\text{Cap}(r)` est de grade linéaire, alors aucun terme ne dérive deux accès concurrents à $`r`.
:::

:::proofsketch
Deux accès concurrents demanderaient deux occurrences de $`\text{Cap}(r)` dans le même contexte,
donc une contraction sur une liaison de grade $`1` : la somme des grades vaudrait $`2`, et la règle
de contraction n'est disponible qu'aux grades qui l'admettent. Il n'y a pas de dérivation, et la
garantie ne coûte donc aucune vérification.
:::

::::
{bibliography}
