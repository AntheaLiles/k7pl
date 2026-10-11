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

#doc (Manual) "Ce qu'une macro déclare" =>
%%%
file := "c5-ce-qu-une-macro-declare"
tag := "c5-ce-qu-une-macro-declare"
%%%

{label "sec:c5-ce-qu-une-macro-declare"}

Une macro de bibliothèque expose une interface, et il faut dire de quoi elle est faite. Faute de
quoi la seule manière de savoir ce qu'une macro fait serait de l'expanser, et une bibliothèque
tierce deviendrait inauditable. La reproductibilité que le bac à sable achète ne servirait alors à
rien : on saurait l'expansion reproductible sans savoir ce qu'elle produit.

Une chose se déduit avant même d'être déclarée, et il vaut la peine de la retirer de l'interface
plutôt que de l'y laisser par prudence : la _spécialisation_. Les liens entre une macro générale et
ses variantes sont de deux espèces seulement — poser deux termes égaux l'un à l'autre, ce qui est
une contraction, et poser un terme égal à l'identité, ce qui est une substitution d'unité et non un
affaiblissement. La structure qui en résulte est l'_ordre d'instance_ sur les termes, calculable par
filtrage dans un sens et par anti-unification dans l'autre {cite "hoekstraCombinatorNdimensionalArray"}[].
Un compilateur peut donc _dériver_ quelle spécialisation s'applique à un site d'appel, au lieu de la
faire déclarer par l'auteur de la bibliothèque. Ce que l'interface doit porter est ce qui ne se
déduit pas ; la hiérarchie de spécialisation, elle, se calcule.

La forme de cette interface n'est pas à inventer. _Une déclaration de macro est le jugement germinal
porté d'un étage_ — ce que l'expansion exige, ce qu'elle est, ce qu'elle produit — et les trois
composantes s'y instancient sans qu'aucun mécanisme nouveau soit requis. Ce paragraphe l'établit
composante par composante, puis en tire la règle de typage d'une expansion, laquelle se révèle
_dérivable_ plutôt que posée.

# Les trois composantes, au niveau macro
%%%
tag := "c5-ce-qu-une-macro-declare-les-trois-composantes-au-niveau-m"
%%%

$`\Delta` — _ce que l'expansion exige de ses arguments_. C'est ici que se referme la question que le
théorème {num "thm:hygiene"}[] laissait ouverte. Une macro qui place son argument en $`k` positions
le duplique, et cette duplication n'est pas anodine : si l'argument dénote une ressource de grade
linéaire, l'expansion l'emploierait $`k` fois. Une macro déclare donc, _par métavariable_, un grade
$`r` — et ce grade n'est pas d'une nouvelle espèce. _C'est le scalaire par lequel l'expansion
multiplie le contexte de l'appelant_, exactement le $`r \cdot \Delta` que le lemme de substitution
gouverne.

$`A` — _ce qu'elle est_. Le type déjà donné, précisé de ce que l'arbre porte : l'AST étant
intrinsèquement indexé par la portée _et par le type_, une macro a le type
$`\mathsf{AST}\,\Gamma\,A_1 \to \cdots \to \mathsf{AST}\,\Gamma\,A_n \to \mathsf{AST}\,(\Gamma, \overline{x})\,B`.
L'extension de portée $`\overline{x}` y est la déclaration d'anaphore du paragraphe précédent ; elle
appartient à cette composante et non à une autre.

$`\mathcal{E}` — _ce qu'elle produit_, et c'est ici qu'un piège attend. _Il y a deux effets et non
un._ L'effet de l'_expansion_ est vide : une macro ne peut ni lire un fichier, ni interroger le
réseau, ni consulter l'horloge, et c'est ce qui rend l'expansion reproductible. L'effet du _code
produit_ ne l'est pas. Confondre les deux reviendrait à confondre le lieu de la contrainte et le
lieu du mécanisme. C'est le second qu'une interface déclare.

Pour chaque métavariable $`x_i`, soit $`n_i = \operatorname{occ}_i(m)` le nombre d'occurrences
effectives dans le corps. Le grade $`r_i` reste une _borne d'usage_ et sert à mettre le contexte
de l'argument à l'échelle ; $`n_i` est, lui, un _compte syntaxique entier_ qui détermine combien
de copies de son effet apparaissent dans le code produit. Ces deux nombres ne doivent pas être
confondus.

# La règle d'expansion, qui n'est pas une règle
%%%
tag := "c5-ce-qu-une-macro-declare-la-regle-d-expansion-qui-n-est-pa"
%%%

::::formula (label := "eq:regle-expansion") (kind := "formule")
```
\begin{equation*}
\textsc{Expand}\;\frac{\;m : (x_i :_{r_i} \mathsf{AST}\,\Gamma\,A_i)_{i \leq n} \Rightarrow \mathsf{AST}\,(\Gamma,\overline{x})\,B \mid \varepsilon_{\mathrm{body}} \qquad \Delta_i \vdash t_i : A_i \mid \varepsilon_i\;}{\;\boxtimes_{i}\,\operatorname{Scale}_{\mathrm{Usage}}(\pi_U(r_i),\Delta_i) \;\vdash\; m(t_1,\ldots,t_n) : B \;\mid\; \varepsilon_{\mathrm{body}} \cdot \varepsilon_{i_1}\cdot\ldots\cdot\varepsilon_{i_k}\;}
\end{equation*}
```

:::caption
Typage d'une expansion de macro. On note $`\operatorname{Occ}(m)=(i_1,\ldots,i_k)` la suite des
occurrences des métavariables dans l'ordre du corps. Le produit des effets d'arguments respecte cet
ordre et est donc celui de la quantale, potentiellement non commutatif. $`\varepsilon_{\mathrm{body}}`
est l'effet déclaré du code produit hors arguments ; l'effet de l'expansion elle-même,
$`\varepsilon_{\mathrm{exp}} = \mathbf{1}`, est un lemme du bac à sable, non une déclaration.
:::
::::
::::corollary (label := "thm:expansion_macro") (level := "langage") (role := "corollary") (state := "under-review") (evidence := "proofsketch") (scope := "syntax")
:::title
la règle d'expansion est dérivable
:::

:::statement +titled
Une macro n'ajoute rien au noyau

La règle {sc}[Expand] n'est pas un axiome du système : elle se dérive du lemme de substitution
(théorème {num "thm:substitution"}[]) appliqué à chaque occurrence du corps, puis de la composition
séquentielle des effets dans l'ordre syntaxique des occurrences. La mise à l'échelle du contexte
et la composition séquentielle des effets sont traitées séparément comme dans l'architecture factorisée.
C'est
l'instance du théorème d'élaboration (théorème {num "thm:elaboration"}[]) où la forme de surface
est un appel de macro.
:::

:::proofsketch
Une expansion est une suite de substitutions. Pour chaque occurrence du corps, le lemme de
substitution fournit le contexte mis à l'échelle par le grade déclaré de la métavariable, après
projection sur l'usage. Le regroupement des contextes selon chaque argument donne la composition
des $`\operatorname{Scale}_{\mathrm{Usage}}(\pi_U(r_i),\Delta_i)` annoncée par la règle, parce que
le grade déclaré borne les occurrences admises.

Sur les effets, si $`\operatorname{Occ}(m)=(i_1,\ldots,i_k)`, la substitution répétée produit
$`\varepsilon_{i_1}\cdot\ldots\cdot\varepsilon_{i_k}`, précédé de
$`\varepsilon_{\mathrm{body}}`. L'ordre syntaxique est conservé. Puisque la quantale est non
commutative, il est en général incorrect de regrouper toutes les occurrences d'un même argument
sous une puissance $`\varphi_{n_i}(\varepsilon_i)` : un tel regroupement demanderait une hypothèse
supplémentaire de commutation ou une structure d'ordonnancement différente.

Le grade $`r_i` n'a donc pas besoin d'être transformé en multiplicité d'effet. La mise à l'échelle
du contexte relève de $`\operatorname{Scale}_{\mathrm{Usage}}` ; l'effet du code produit résulte de
la composition des effets effectivement introduits aux positions d'occurrence.
:::

_Ce que ce théorème vaut._ Il montre que l'expansion se déduit du noyau sans nouvelle règle primitive :
la condition de clôture est portée par la substitution sur les contextes, tandis que les effets du
code produit résultent de leur composition dans l'ordre des occurrences. Une extension qui introduirait
un mécanisme différent de duplication ou d'ordonnancement devrait cependant fournir sa propre loi de
transport d'effet.
::::
# Ce que le vérificateur contrôle avant expansion
%%%
tag := "c5-ce-qu-une-macro-declare-ce-que-le-verificateur-controle-a"
%%%

C'est le critère auquel cette interface se juge, et il est rempli : les quatre contrôles portent sur
le _corps de la macro_, sont syntaxiques, et se font _une fois pour toutes_ à la définition. Un site
d'appel ne lit ensuite que la déclaration.

::::k7table (label := "tab:c5-controles-avant-expansion") (align := "lZ{1.33}Z{0.67}")
:::caption
Les quatre contrôles que le vérificateur porte sur le corps de la macro avant expansion
:::

:::table
* * 1
  * le grade $`r_i` majore le nombre d'occurrences de $`x_i` dans le corps
  * comptage
* * 2
  * l'effet $`\varepsilon_{\mathrm{body}}` majore les opérations du corps hors occurrences des arguments
  * lecture des opérations employées
* * 3
  * la couche déclarée admet les opérations du corps
  * appartenance
* * 4
  * l'extension de portée déclarée est celle que le corps opère
  * comparaison d'index
:::
::::

_C'est ce qui rend une bibliothèque tierce auditable_ : la macro est vérifiée à sa définition, et
chaque appel fait confiance à une déclaration dont on sait qu'elle a été contrôlée.

# Trois choix, et ce qui les décide
%%%
tag := "c5-ce-qu-une-macro-declare-trois-choix-et-ce-qui-les-decide"
%%%

Le grade déclaré est une *borne* et non un compte exact, et cette fois la raison n'est pas seulement
la cohérence avec les arbitrages antérieurs. Un corps de macro qui _branche_ — plaçant son argument
dans une alternative et pas dans l'autre — n'a pas de compte exact : la borne est le maximum sur les
branches, et c'est la seule quantité calculable statiquement. Or c'est déjà la règle du noyau, le
grade d'un $`\mathsf{case}` étant le joint de ses branches. _Le niveau macro n'invente donc pas sa
règle, il applique celle d'en dessous._

La couche est *déclarée*, non inférée. L'inférer demanderait d'inspecter le corps, ce qui est
possible mais contraire à l'objet : une interface se lit, elle ne se calcule pas. La déclaration est
en revanche _vérifiée_ contre le corps, par le contrôle 3 ci-dessus — déclarée et contrôlée, comme
le grade l'est.

Le *polymorphisme en grade* est admis, et sous une restriction. Sans lui, deux macros ne différant
que par le grade de leur argument devraient être écrites deux fois, ce qu'aucune bibliothèque ne
supporterait. Une macro peut donc quantifier sur une variable de grade, mais _en position préfixe
seulement_ : la quantification est instanciée au site d'appel, où le grade est connu, de sorte que
tout contrôle se ramène à une instance close. Admettre un rang supérieur ferait porter au
vérificateur des contraintes de grade à variables sous quantificateur, dont la décidabilité n'est
pas acquise — et P3 veut qu'aucune obligation de compilation ne le soit pas.

# La limite, et elle est réelle
%%%
tag := "c5-ce-qu-une-macro-declare-la-limite-et-elle-est-reelle"
%%%

Une macro peut _analyser_ son argument plutôt que le placer : inspecter sa forme et brancher dessus,
tradition Lisp dont ce chapitre se réclame. Le nombre d'occurrences dépend alors de l'argument, et
non plus du seul corps.

Une partie du cas est couverte, et par un appareil que le document possède déjà : la gradation étant
_indexée_ (chapitre 1, §{num "sec:c1-axiomatique-germinale"}[]), un grade déclaré peut être une
fonction d'un indice porté par le _type_ de l'argument — la longueur d'un vecteur littéral, par
exemple. C'est la quatrième fois que l'indexation paie un cas qu'on croyait hors de portée.

_Ce qui reste dehors est nommé plutôt que passé sous silence_ : une macro qui branche sur la _forme
syntaxique_ de son argument — selon qu'il est un littéral ou une variable — n'est pas couverte, sa
dépendance ne passant par aucun indice de type. Une telle macro doit déclarer le maximum sur les
formes possibles, ou se voir refusée. K7PL prend la première voie et la déclare imprécise : c'est le
même arbitrage que partout ailleurs dans ce document — sur-approximer plutôt que renoncer.

Cette même métaprogrammation absorbe des protocoles binaires hérités sans qu'aucun automate n'ait à
être écrit à la main. Le développeur exprime, de façon déclarative en couche 2, les en-têtes, les
tailles de champs et l'ordre des octets d'un protocole existant. Le système de macros en dérive à la
compilation le `{deftype}` correspondant ainsi que le DFA de validation optimisé (chapitre 4,
§{num "sec:c4-echelle-locale"}[]). Une bibliothèque pour un protocole legacy n'est, de ce point de
vue, qu'une macro parmi d'autres — jamais un module distinct nécessitant du code non vérifié.
