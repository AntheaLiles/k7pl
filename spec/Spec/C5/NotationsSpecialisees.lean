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

#doc (Manual) "Notations spécialisées" =>
%%%
file := "c5-notations-specialisees"
tag := "c5-notations-specialisees"
%%%

{label "sec:c5-notations-specialisees"}

Trois familles de notations se posent sur cette grammaire commune, chacune pour une raison distincte :
la concision du calcul tacite, la performance des motifs structurés, et l'introspection du
compilateur sur son propre AST.

La couche 3 admet, en plus de l'écriture nommée, une notation point-free héritée d'APL, de BQN et
d'Uiua. Chaque opération de la bibliothèque standard y porte un glyphe Unicode concis et un alias
textuel strictement équivalent au niveau de l'AST. `⌊` et `min`, `⊏` et `select` dénotent une seule
et même macro : l'éditeur peut afficher l'un ou l'autre sans toucher au programme sous-jacent. Un
service d'édition qui calcule sa réponse depuis les types plutôt que depuis le texte a son précédent
opérationnel {cite "bourMerlinLanguageServer"}[].

Cette dualité suit la règle de Stroustrup : la concision au glyphe pour qui la pratique, l'explicite
à l'alias pour qui découvre. La formule suppose sans le dire que le choix appartient au _lecteur_,
et il faut le dire, car cela commande ce que l'outillage doit porter. Le style dépend en réalité des
choix des auteurs _et_ de ceux des lecteurs, distinctement, et un dispositif qui ne servirait que
les seconds ne rendrait qu'une moitié du service {cite "cohenCodeStyleSheets2025"}[]. La même source
signale que la difficulté technique n'est pas la sélection de l'affichage mais la _mise en page_ des
blocs imbriqués — remarque qui vise une syntaxe à expressions symboliques plus que toute autre, et
qui est donc à porter au compte de ce chapitre plutôt qu'à celui d'un outillage futur.

Les trains composent ces primitifs sans nommer leurs arguments — un 2-train `(f g)` dénote
`λx. f(g(x))`, un 3-train `(f g h)` dénote la fourche `λx. (f x) g (h x)` — tandis que les
modifieurs `´` (pli), `¨` (chacun), `↢` (liaison gauche) transforment une fonction en une autre. Les
blocs concaténatifs comme `[dup * +]`, dans la tradition de Forth et Factor, portent leur effet de
pile directement dans leur type : `[dup *]` a l'effet `(1 – 2)`.

Le nombre d'opérations qu'une telle bibliothèque peut porter est la seule grandeur non bornée de
tout le nommage de ce langage, et il faut dire tout de suite qu'aucun seuil ne se cite. La
littérature ne rend pas de nombre au-delà duquel le coût de vocabulaire dominerait. Ni la revue de
la lisibilité, ni celle des messages d'erreur, ni les deux rétrospectives de langages dont le
vocabulaire a crû sur un demi-siècle. Celle d'APL, écrite en deux temps à quarante-deux ans
d'intervalle, et celle du C++, qui sont des témoignages de concepteurs et vont d'ailleurs en sens
contraire {cite "falkoffEvolutionAPL1978,huiAPL19782020,stroustrupThrivingCrowdedChanging2020"}[].
Le budget de la bibliothèque est donc une décision de conception, à assumer comme telle, et non un
seuil emprunté. Ce qui existe à la place n'est pas un plafond mais un prix unitaire : la carte de
justesse par jeton estime la justesse d'un novice _jeton par jeton_, et dit lesquels coûtent plutôt
que combien sont de trop {cite "stefikEmpiricalInvestigationProgramming2013"}[]. C'est l'instrument
à employer si ce budget doit un jour se défendre par la mesure.

Un dernier bénéfice de la forme choisie ne passe pas par la lisibilité : elle rend le code
_retrouvable_. Les outils de recherche syntaxique exploitent la structure d'arbre du code et sont à
ce titre plus expressifs que la recherche par chaîne ou par expression régulière. Leur limite est
que la requête doive être un fragment complet et analysable, ce qui rend inutile toute requête en
cours de frappe, et le travail qui lève cette limite le fait en ne demandant qu'un découpage en
jetons, avec des jokers conscients de l'arbre construits sur des _automates d'arbres_ {cite "matuteSyntacticCodeSearch2024"}[].
Une syntaxe à expressions symboliques y est structurellement favorable : tout fragment y est déjà un
arbre, et le jeton de tête suffit à désigner la forme cherchée. Le mécanisme invoqué est celui-là
même dont le chapitre 4 fait sa théorie, de sorte que le langage porte déjà les moyens de son propre
outil de recherche.

Les R-expressions et les X-expressions — dont le chapitre 4 (§{num "sec:c4-echelle-locale"}[]) a
déjà donné la sémantique d'exécution pour les premières — sont des types de données intégrés au
langage, avec une syntaxe qui leur est propre plutôt qu'une bibliothèque que l'utilisateur pourrait
redéfinir. Cette syntaxe bénie a un prix, nommé au §{num "sec:c5-s-expressions-universelles"}[] ;
son bénéfice immédiat est de permettre au compilateur des optimisations qu'aucune construction
générique ne rendrait possibles — la fusion d'un motif R-expression et d'un flux X-expression en un
seul automate `K7PL.FSM`, sans conversion intermédiaire en chaîne de caractères. Une X-expression
s'écrit `(tag-symbole [attributs] enfants...)` ; ses attributs occupent un espace de pile linéaire
de couche 3, si bien qu'un calcul de couche 2 destiné à y figurer doit d'abord être matérialisé par
un `let` avant d'être injecté, sous peine de la même erreur `ERR-TOP-001` rencontrée au
§{num "sec:c5-s-expressions-universelles"}[].

La métaprogrammation exploite enfin l'homoiconicité elle-même. Une macro est une fonction pure de
couche 2 qui reçoit un AST et en retourne un autre, exécutée en Phase 0 avant toute vérification.
L'évaluation `comptime`, marquée par le sigil `#`, exécute du code pur de couche 2 ou 3 pour
produire une constante déposée directement dans la section binaire `.rodata`.

Deux modèles répondent chacun à une moitié du problème. Terra montre qu'un langage de
métaprogrammation de haut niveau peut engendrer à la compilation du code bas niveau optimisé —
exactement le rapport qu'entretient la couche 2 avec les couches 1 et 3 quand elle génère leurs
structures. Racket montre que cette génération ne reste sûre que si les phases sont strictement
isolées, un effet de bord du macro-système ne pouvant contaminer le code produit : c'est la
discipline d'hygiène reprise ici.

L'isolation ne suffit cependant pas à garantir la modularité : l'expansion de macro est une
_élaboration_ au sens de la littérature sur les effets d'ordre supérieur. Celle-ci établit que les
opérations prenant des calculs en argument — ce qu'un gestionnaire est — brisent la modularité des
effets algébriques lorsqu'on les encode naïvement, l'encodage n'appartenant alors à aucune interface
d'effet. Mais elle établit aussi qu'une élaboration convenablement structurée la rétablit, en se
composant par cas séparés {cite "bachpoulsenHeftyAlgebrasModular2023"}[]. Ce que K7PL perd ici, il
le perd donc par le choix de son encodage et non par une impossibilité. K7PL ne garantit pas cette
modularité, et ce défaut n'est pas indépendant du précédent : c'est parce qu'une opération
introduite par macro n'appartient à aucune interface qu'on ne peut ni la confiner ni raisonner sur
ce qu'elle fait. Modulariser l'élaboration — en donnant aux opérations d'ordre supérieur une
interface propre plutôt qu'en les encodant — servirait donc les deux à la fois, la modularité et le
confinement.

Encore faut-il dire de quel type est cet AST, faute de quoi l'hygiène resterait une discipline
d'implémentation plutôt qu'une propriété. L'AST de K7PL est l'algèbre initiale d'une signature à
opérateurs liants, intrinsèquement indexée par la portée — soit une instance directe du $`\mu F`
construit au chapitre 2 (§{num "sec:c2-algebres-coalgebres-et-points"}[]), et non un mécanisme
supplémentaire. Cette formulation n'est pas un raffinement théorique : c'est elle qui rend
génériques, une fois pour toutes et preuves comprises, les parcours que le compilateur répète
autrement pour chaque opération — renommage, substitution, désucrage, impression {cite "allaisTypeScopeSafe2018"}[].
Elle fournit en outre au système de macros l'objet formel qu'il manipule sans le nommer : la
métavariable, et l'opération de métasubstitution qui l'accompagne, dont découle un raisonnement
équationnel du second ordre sur les expansions. Le lemme de substitution s'y obtient par
construction plutôt que par preuve séparée {cite "fioreFormalMetatheorySecondorder2022"}[].

Une seconde propriété suit de la même construction, et elle décide de ce que le compilateur peut
faire plutôt que de ce que le programmeur peut écrire.

::::thm (label := "thm:staticite_syntaxe")
:::title
staticité de la syntaxe
:::

:::statement +titled
La syntaxe est fixée avant toute exécution

Aucune construction de K7PL ne calcule un nom ; toute opération d'espace de noms vit au niveau
macro, où elle est typée par `binds`. Par conséquent la syntaxe d'un programme est fixée à l'issue
de la Phase 0, et aucune exécution ne la modifie.
:::

:::proofsketch
Par inspection de la grammaire, en quatre points. La seule construction qui produit un arbre est la
_macro_, fonction pure de couche 2 d'un AST vers un AST. Elle s'exécute en Phase 0, en bac à sable,
avant toute vérification et donc avant toute exécution du programme. Son type porte la portée, de
sorte qu'elle ne peut produire d'occurrence hors de l'index qu'elle reçoit — c'est l'hygiène
ci-dessus. Et aucune règle du jugement germinal ne construit un nom à partir d'une valeur : les noms
sont des données de la dérivation, non de l'évaluation.

Un seul cas demande d'être regardé, car c'est le seul endroit du langage où un nom soit _produit_
plutôt que lu : la résolution de `bind-to` par recherche dirigée par le type
(§{num "sec:c5-mise-en-pratique"}[]). Elle ne menace pas l'énoncé, s'achevant elle aussi en Phase 0
— une recherche ambiguë y est refusée plutôt que résolue arbitrairement.
:::
::::

Ce que ce théorème ajoute n'est pas une garantie de plus mais un _second_ bénéfice au même
dispositif. Le chapitre 3 justifie le confinement de la Phase 0 par la sûreté : une macro n'a aucune
raison de détenir plus de capacités que le programme qu'elle produit. Il achète aussi la
compilabilité statique, et le document ne le dit nulle part. La comparaison rend la chose nette : ce
qui empêche APL d'être compilé statiquement tient en une phrase de ses concepteurs — la syntaxe
d'une instruction après exécution peut différer de ce qu'elle était avant {cite "saalConsiderationsDesignCompiler1978"}[].
Cette phrase est inécrivable pour K7PL, et elle l'est par théorème.

Une condition supplémentaire doit être nommée, car on la confond aisément avec le confinement
lui-même. Qu'une valeur soit close à la compilation ne suffit pas à rendre libre le produit engendré
par le métaniveau. Il y faut la _générativité_, l'axiome qui internalise le fait qu'un métaprogramme
ne peut pas inspecter la structure des termes du niveau objet. C'est de lui, non de la clôture, que
se tire la fermeture de l'univers des sommes de produits par la somme dépendante {cite "kovacsClosurefreeFunctionalProgramming2024"}[].
La formulation juste n'est donc pas que la valeur soit close, mais que le métaniveau soit
_paramétrique_ en l'objet. C'est ce que le confinement de la Phase 0 réalise, et le dire ainsi évite
d'attribuer à la clôture un travail qu'elle ne fait pas.

L'hygiène des macros cesse alors d'être un dispositif pour devenir un théorème : une macro bien
typée reçoit un AST indexé par une portée et ne peut produire d'occurrence hors de cet index, de
sorte qu'une capture accidentelle n'est pas évitée mais inexprimable. C'est la garantie par
inexpressibilité du chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]), appliquée ici à la capture
de nom. La seconde occurrence est ailleurs et de même forme — une violation de couche n'est pas
refusée par une règle, elle échoue à se dériver faute de la ressource que le jugement ambiant ne
porte pas. Ce que ces deux cas ajoutent au critère du chapitre 1 est le lieu où la structure porte
l'interdit : l'index d'un préfaisceau ici, la ressource d'un contexte là.

Et il faut en écrire le revers, qui se paie exactement où le gain se prend. Une violation
inexprimable ne se _diagnostique_ pas : il n'y a rien à refuser, donc rien à expliquer, et le
lecteur reçoit un échec de dérivation là où une règle de rejet aurait produit un message. C'est ce
que la stratification des diagnostics de l'annexe des codes d'erreur doit compenser, et c'est
pourquoi elle n'est pas un ornement.

K7PL conserve néanmoins l'anaphore délibérée — la macro qui introduit intentionnellement une liaison
destinée au corps de son site d'appel, tradition Lisp dont ce chapitre se réclame. Elle passe par
une extension explicite de l'index de portée, `binds`, qui apparaît dans le type de la macro.
L'anaphore n'est ni interdite ni silencieuse, elle est visible dans la signature, selon la même
règle que ce document applique aux délimiteurs, au typestate et aux capabilités — rendre coûteux et
lisible plutôt qu'interdire. En interne, chaque variable porte un nom et un indice à la De Bruijn :
le nom préserve la lisibilité des messages d'erreur, l'indice résout le masquage sans renommage
coûteux, et il ne s'affiche que lorsqu'il est non nul — une variable jamais masquée reste, à
l'écran, un nom nu.

Que `binds` figure dans le _type_ plutôt que dans la mise en œuvre a une conséquence que ce chapitre
gagnerait à revendiquer, car elle dissout un défaut de composition documenté. Les techniques
d'hygiène qui traitent l'anaphore par extraction obligent toutes les macros liant un même
identifiant à être définies _avec connaissance les unes des autres_. Deux macros anaphoriques
écrites indépendamment ne se composent pas, et le défaut est reconnu dans la tradition même dont ce
chapitre se réclame {cite "clingerHygienicMacroTechnology"}[]. Mettre la portée dans le type
l'élimine plutôt que le contourne : deux macros dont les signatures déclarent chacune ce qu'elles
lient se composent parce que leurs index de portée se composent, sans qu'aucune ait à connaître
l'autre. Ce n'est pas une amélioration ergonomique, c'est un défaut de modularité qui cesse
d'exister.

Un précédent industriel existe sur le dispositif voisin — le délimiteur qui annonce un régime plutôt
qu'une construction. F# a introduit `async { … }` comme une réinterprétation _localisée_ des
constructions de contrôle existantes, plutôt que comme un jeu de primitives nouvelles, et la forme
est devenue un standard de fait bien au-delà de ce langage {cite "symeEarlyHistory2020"}[]. K7PL
emploie la même figure aux mêmes fins de lisibilité. Ce qui y est neuf n'est donc pas le délimiteur
mais ce qu'il annonce : chez F# un régime d'évaluation, ici un _grade_, donc quelque chose que le
système de types vérifie plutôt qu'une convention que le compilateur interprète.

La forme de ce théorème dit d'où il vient.

::::thm (label := "thm:hygiene")
:::title
hygiène des expansions
:::

:::statement +titled
La métasubstitution commute avec la substitution

Pour tout terme à métavariables $`M`, toute métasubstitution $`\theta` et toute substitution
$`\sigma` portant sur les variables d'objet, $$`(M\,\theta)[\sigma] \;=\; (M[\sigma])\,\theta`
lorsque $`\sigma` ne touche aucune variable liée par $`M`. Il en résulte qu'aucune expansion ne
capture : une occurrence libre dans l'argument d'une macro reste libre dans le résultat.
:::

:::proofsketch
L'AST étant l'algèbre initiale d'une signature à opérateurs liants, intrinsèquement indexée par la
portée, un terme est un élément d'un préfaisceau sur les contextes et la substitution en est
l'action fonctorielle. L'égalité ci-dessus est alors la naturalité de cette action, et se démontre
par récurrence sur $`M` : les cas des opérateurs sont donnés par la fonctorialité, celui d'une
métavariable par sa définition, et celui d'un lieur par le décalage d'indice que l'indexation par la
portée impose.
:::
::::

::::thm (label := "thm:hygiene_graduee") (status := "proposition")
:::title
hygiène graduée des expansions
:::

:::statement +titled
La même commutation, au grade déclaré

L'énoncé précédent porte sur l'AST non gradué. Sa version graduée — chaque métavariable $`x_i`
portant son grade déclaré $`r_i`, et la conclusion le contexte $`\boxtimes_i (r_i \cdot \Delta_i)` —
est la même commutation, au contexte et à l'effet près.
:::

:::proofsketch
Le théorème {num "thm:expansion_macro"}[] la referme par le lemme de
substitution et la loi de compatibilité de l'action ; l'énoncé n'était simplement pas étendu. Non
démontré ici.
:::
::::

::::thm (label := "thm:resucrage") (status := "exigence")
:::title
préservation de l'α-équivalence de surface
:::

:::statement +titled
Resucrage

L'α-équivalence de surface est préservée par l'expansion. Cette propriété ne se déduit pas de
l'énoncé sur l'AST : elle demande une algèbre de liaison de surface, que le document n'a pas.
:::
::::

Ce que cet énoncé rend inexprimable importe plus que ce qu'il évite. {rmq}[Pas une discipline
appliquée, un type qui ne laisse pas la question se poser.] La conclusion n'est pas qu'une capture
est évitée par un renommage. Mais qu'elle est inécrivable : produire une occurrence hors de l'index
de portée reçu demanderait un terme qui n'est pas dans le préfaisceau. Le macro-système n'a donc pas
de discipline d'hygiène à appliquer.

Deux limites le bornent, et toutes deux sont délibérées. La première est qu'il porte sur l'AST non
gradué, c'est-à-dire sur l'image du foncteur d'effacement du chapitre 4
(§{num "sec:c4-le-calcul-de-processus"}[]). Une macro qui emploie deux fois son argument le
duplique, ce qui est une contraction et n'est licite qu'au grade $`\omega`. L'énoncé gradué suppose
donc de savoir ce qu'une macro déclare de ses arguments, question que ce document laisse ouverte. La
seconde touche à ce que le mot _hygiène_ promet d'ordinaire : l'énoncé porte sur la métasubstitution
dans l'AST du noyau, quand le but usuel est la préservation de l'$`\alpha`-équivalence de surface —
qu'un programme et son renommage aient la même expansion telle que le programmeur la lit. Celle-ci
ne s'en déduit pas sans une algèbre de liaison de la surface, que ce document n'a pas construite. La
difficulté est connue sous le nom de _resucrage_ : reconduire une propriété établie au noyau jusqu'à
la forme de surface demande que le désucrage soit lui-même compositionnel, et cette exigence ne va
pas de soi {cite "pombrioHygienicResugaringCompositional"}[].

Une inquiétude s'écarte en revanche, et elle porterait sur la fondation plutôt que sur la surface.
Manipuler des noms frais — ce que fait toute construction qui choisit un nom — pourrait sembler
exiger une forme d'axiome du choix. Il n'en est rien : dans les ensembles nominaux, tout élément a
un support fini et l'ensemble des noms est infini, de sorte qu'un nom frais existe toujours, et
c'est le quantificateur de fraîcheur qui dispense du choix {cite "pittsNominalSetsNames2013"}[]. Le
coût de la fraîcheur est donc nul du côté de la fondation, et entier du côté de la mécanisation — ce
que le chapitre 6 discute.

S'il tient, le macro-système hérite de l'hygiène sans avoir à la faire respecter, et une
bibliothèque tierce ne peut pas capturer un nom du programme qui l'appelle. S'il tombe, il faut
réintroduire un mécanisme de renommage à l'expansion, c'est-à-dire une discipline à vérifier plutôt
qu'une propriété du type.

Cet énoncé est une instance du schéma de commutation (chapitre 2,
§{num "sec:c2-six-schemas-de-metatheorie"}[], théorème {num "thm:schema_commutation"}[]), la
transformation étant ici l'expansion et les deux niveaux le méta et l'objet. Un langage à trois
strates produit des énoncés de cette forme parce que chacune doit traverser l'autre sans la
déformer, et c'est le schéma qui porte cette raison une fois pour toutes.

Une économie accompagne cet énoncé et vaut d'être signalée, car elle retire un travail qu'on
attendrait. L'expansion a lieu en Phase 0, dans le bac à sable où une macro ne peut ni lire un
fichier, ni interroger le réseau, ni consulter l'horloge : $`\mathcal{E} = \emptyset` pendant toute
l'expansion. _L'hygiène n'interagit donc pas avec les effets_, et la démonstration n'a aucun cas
d'effet à traiter. C'est la distinction de phase qui paie ici, et non une clause ajoutée.

Reste à dire de quoi la visibilité de l'anaphore est faite, faute de quoi `binds` resterait un mot.
Une macro y déclare, dans son type, l'_extension_ de l'index de portée qu'elle opère : là où une
macro ordinaire a le type $`\mathsf{AST}\,\Gamma \to \mathsf{AST}\,\Gamma`, une macro anaphorique
qui introduit les liaisons $`\overline{x}` a le type
$`\mathsf{AST}\,\Gamma \to \mathsf{AST}\,(\Gamma, \overline{x})`. L'index de portée du résultat
n'est pas celui de l'argument, et cet écart _est_ la déclaration. Un appelant lit donc dans la
signature ce que la macro va lier chez lui, et le théorème ci-dessus vaut inchangé — il porte sur
l'index reçu, quel qu'il soit.
