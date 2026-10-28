-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt
import SpecExt.CodeArtifacts

open Verso.Genre Manual
open SpecExt
open SpecExt.CodeArtifacts

set_option linter.unusedVariables false

#doc (Manual) "S-expressions universelles" =>
%%%
file := "c5-s-expressions-universelles"
tag := "c5-s-expressions-universelles"
%%%

{label "sec:c5-s-expressions-universelles"}

K7PL n'a qu'une seule grammaire : l'expression symbolique préfixée, où un programme est un arbre
homogène, aussi manipulable comme donnée que comme code. Ce que cette grammaire ajoute au-dessus de
la syntaxe de Lisp est minimal et entièrement au service des trois fragments du chapitre 2 : trois
paires de délimiteurs, chacune annonçant au compilateur quelle phase de vérification s'applique à
l'expression qu'elle ouvre.

::::k7table (label := "tab:delimiteurs") (align := "llZ{0.66}Z{1.34}")
:::caption
Les trois délimiteurs comme annonces de phase
:::

:::table +header
* * Délimiteur
  * Fragment
  * Contexte du jugement germinal
  * Vérifications imposées
* * `{ ... }`
  * Linéaire
  * $`\Delta_{\text{lin}}`
  * Absence de duplication ou d'abandon ; capabilités linéaires
* * `( ... )`
  * Affine
  * $`\Delta_{\text{aff}}`, $`\mathcal{E}`
  * Productivité ; effets autorisés ; ownership du tas
* * `[ ... ]`
  * Cartésien
  * $`\Delta = \Delta_{\omega}`
  * Terminaison ; pureté ; allocation sur la pile
:::
::::

Ces trois paires ne s'imbriquent que dans un seul sens : `{ ... ( ... [ ... ] ... ) ... }`. Toute
autre inclusion est rejetée dès la lecture du texte, en Phase 0, et chacune a son code, du conteneur
le plus spécifique au plus générique : un `( )` à l'intérieur d'un `[ ]` (`ERR-TOP-001`), un `{ }` à l'intérieur d'un
`[ ]` (`ERR-TOP-002`), un `{ }` à l'intérieur d'un `( )` (`ERR-TOP-003`). Cette contrainte n'est
pas stylistique : elle découle directement des
spécialisations du jugement germinal établies au chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]). Le jugement de couche 3 n'admet que des liaisons de grade $`\omega` ; un bloc de couche 3 ne peut donc rien exiger qui soit affine ou linéaire. Le jugement de couche 1, à
l'inverse, dispose de $`\Delta_{\text{lin}}`, dont le chapitre 2
(§{num "sec:c2-la-comonade-exponentielle-et"}[]) a montré qu'il s'inclut fidèlement dans
$`\Delta_{\text{aff}}`. Un fragment de couche 2 peut donc être évalué à l'intérieur d'un contexte de
couche 1, ce contexte fournissant tout ce dont la couche 2 a besoin. La réciproque échouerait, faute
d'une ressource strictement linéaire à offrir. C'est cette même asymétrie qui permet à un calcul de
couche 3 — n'ayant besoin que de $`\Delta_{\omega}`, présent dans les trois jugements — d'être
invoqué depuis n'importe laquelle des trois couches.

La grammaire des couches s'écrit en K ({num "lst:grammaire-couches"}[]) ; chaque production en
transcrit une règle.

::::listing (label := "lst:grammaire-couches")
:::caption
La grammaire des couches, en K
:::

```K (file := "lexicon/syntax/layers.k")
```
::::

Des neuf manières de placer une paire de délimiteurs dans une autre, cette grammaire en admet six.
Les trois autres s'y ajoutent comme les productions qui lui manquent
({num "lst:inclusions-refusees"}[]) : tout texte bien parenthésé se lit alors, et chaque refus se
rattache à la règle qu'il enfreint. La définition K émet elle-même le code et le message de chaque
refus, ceux de l'annexe {num "sec:annexe-a-codes"}[] ; un texte est bien imbriqué exactement
lorsqu'elle n'en émet aucun.

::::listing (label := "lst:inclusions-refusees")
:::caption
Les trois inclusions refusées, chacune avec son code
:::

```K (file := "lexicon/syntax/crossings.k")
```
::::

Cette contrainte a été posée pour un motif de couches, et elle rend gratuitement une propriété que
voici. Une grammaire est _à pile visible_ lorsque la structure d'appel et de retour se lit dans
l'alphabet lui-même. Trois paires de délimiteurs, ouvertures et fermetures distinctes et fixées, ne
s'imbriquant que dans un seul sens : la définition est satisfaite par construction. La classe est
celle où l'analyse est linéaire, où la vérification d'imbrication est décidable, et où l'algorithme
central a été formellement vérifié {cite "jiaDerivativebasedParserGenerator2021"}[]. Le lecteur de
`lexicon/syntax/balance.k` en est une mise en œuvre : il empile chaque délimiteur ouvrant avec sa
ligne et dépile au fermant de sa paire. Il refuse ainsi, dès la lecture, un délimiteur jamais
refermé, un fermant sans ouvrant et un fermant d'une autre paire que les délimiteurs encore ouverts
(codes `ERR-DLM`, annexe {num "sec:annexe-a-codes"}[]), ainsi qu'une inclusion que la grammaire
des couches refuse. Un second trait
de cette approche compte pour un langage homoiconique : l'analyseur rend une _forêt_ de tous les
arbres valides, là où le choix priorisé d'une grammaire d'expressions d'analyse élit une lecture en
silence. Une ambiguïté devient alors une chose qu'on peut voir et refuser, plutôt qu'une chose que
l'analyseur tranche pour soi.

L'écriture d'un délimiteur doit définir la limite de sa couche, et c'est sa nature :
`{je suis en couche 1} (je suis en couche 2 [et maintenant en couche 3])`. Chaque couche a son
rôle : les types se posent en couche 1 seulement, la couche 2 orchestre et produit, la couche 3
calcule et termine. Les types servent entre autres à construire la pile, où opère la couche 3, et le
tas, où opère la couche 2 ; en définir dans l'une ou l'autre serait incohérent. Une définition
s'ouvre donc en couche 1, où se pose son type, et ses paramètres et son corps s'écrivent dans le
délimiteur de leur couche ; une déclaration qui porte un type s'écrit de même entre accolades
(§{num "sec:c5-mise-en-pratique"}[]). Il n'existe donc pas de
parenthèse ordinaire, neutre vis-à-vis des couches : `( )` est toujours le délimiteur de la couche 2,
et toute expression composée porte le délimiteur de son fragment. Le
délimiteur ne _change_, en revanche, qu'au point précis où le fragment change. Tant qu'un appel
demeure dans le fragment ambiant, il reprend le délimiteur du bloc qui l'entoure : `[ ]` dans un
bloc de couche 3, `( )` dans un bloc de couche 2. Une fonction pure, en particulier, étant
compatible par construction avec n'importe quel fragment ambiant puisqu'elle ne requiert que
$`\Delta_{\omega}`, peut être appelée depuis chacune des trois couches ; dans un bloc de couche 3,
son appel s'écrit entre crochets comme le reste du bloc. Un délimiteur autre que celui du bloc
n'apparaît qu'au site d'un appel qui franchit effectivement la frontière vers un fragment
strictement plus contraint que
l'ambiant : une couche 2 qui invoque une fonction dont la vérification exige le fragment cartésien
strict, par exemple. La frontière est ainsi aussi visible dans le texte qu'elle l'est dans le graphe
de dépendances que le principe de Flat-Wiring entend exposer.

Cette granularité décide de ce que sanctionne `ERR-TOP-001`. Une parenthèse à l'intérieur d'un
bloc `[ ]` n'y est jamais légitime : elle annonce la couche 2 dans un bloc qui n'en dispose pas, et
une opération déjà compatible avec le fragment cartésien s'y écrit entre crochets. Ce que le code
nomme est une expression dont la vérification exige une composante que le jugement ambiant ne porte
pas, un `HandlerResult` par exemple, qui suppose $`\mathcal{E}` et $`\Delta_{\text{aff}}`,
l'un et l'autre absents du jugement de couche 3. Le §{num "sec:c5-mise-en-pratique"}[] en donne un
exemple complet.

Le contrôle des délimiteurs rend la règle de portée explicite, mais il ne suffit pas à établir la propriété H3 de sûreté mémoire. H3 exige qu'aucune valeur cartésienne, fermeture duplicable, tuple, substitution ou conversion ne puisse capturer une capacité d'écriture linéaire encore accessible. La preuve doit couvrir les constructeurs et les frontières de couche effectivement admis, et rester distincte de H1 (unicité d'introduction d'une capacité) et H2 (dénotation des régions disjointes). Les rejets syntaxiques ERR-TOP-001 à ERR-TOP-003 sont un contrôle nécessaire de cette discipline, non une preuve sémantique de H3.

Deux règles de portée doivent être énoncées avant le reste, car elles sont en usage partout dans ce
chapitre et n'ont jamais été posées. Un lecteur les devine ; un vérificateur ne devine pas.

La première fixe la portée des _délimiteurs_. Ils s'appliquent aux positions où un _calcul_ est
attendu, et là seulement. En position de liaison, de motif ou de littéral, ils ne marquent aucun
fragment — un crochet qui ouvre un littéral tableau n'annonce pas la couche 3, et une accolade qui
ouvre un motif n'annonce pas la couche 1. Sans cette règle, toute la syntaxe de liaison serait
ambiguë ; avec elle, elle ne l'est pas. Elle porte sur ce qu'un délimiteur annonce, non sur son
imbrication : en position de liaison, de motif ou de littéral comme ailleurs, un délimiteur ne
s'imbrique que dans le sens que fixe la grammaire des couches.

La seconde fixe le sigil _deux-points_. Il introduit une _étiquette_, et les étiquettes forment un
espace de noms distinct de celui des variables : `:état` dans `(HandlerResult :état v :réponse r)`
n'est pas la variable `état` et ne peut pas la masquer. La règle est d'une ligne et elle referme une
classe entière d'erreurs silencieuses. Sans elle, une étiquette mal orthographiée serait une
_variable fraîche_, donc un motif qui filtre tout et ne signale rien — c'est le piège qu'une
critique classique de Standard ML relève sur les constructeurs {cite "appelCritiqueStandardML1993"}[].
Avec elle, une étiquette inconnue est une erreur, parce qu'une étiquette n'est jamais liante.

Le reste de la grammaire commune tient en quelques règles. Les identifiants s'écrivent en anglais,
en kebab-case, et les marques de contrat `?` et `!` se placent devant le nom
(`?increment-bounded`). Quatre caractères sont des sigils, lus en tête d'un atome : `#`, `:`, `?`
et `!` ; la Phase 0 en fait des attributs. `@` appartient aux motifs, et tout est motif — un type,
une construction, une trace, un effet algébrique : `@` placé devant une construction capture ce motif
et en hérite toute la construction, de sorte qu'un motif filtre directement un flux de données ou le
réseau. Les quatre annotations des R-expressions du chapitre 4 (`@linear`, `@polynomial`, `@stack`,
`@backtrack`) en sont des propriétés, et PCRE ou PEG n'y sont pas des langages étrangers : K7PL les
compile en automates, mis en production comme opérateurs atomiques par un orchestrateur ou un acteur
(§{num "sec:c4-echelle-locale"}[]). Seul, `@` est un caractère ordinaire, et `nom@domaine` n'est
pas un motif mais un texte, comme une adresse électronique. Une définition s'écrit avec le mot
primitif `def` ; `defmacro` se définit avec lui (`{def defmacro …}`) et fournit les enveloppes, et
`defn`, qui définit une fonction, en est une, c'est-à-dire `def` dont des propriétés sont déjà
remplies. Une enveloppe est une macro de couche 1, développée à la compilation et ouverte à tout
programme sous l'hygiène de `ERR-MAC-001` ; une enveloppe peut en préciser une autre en lui ajoutant
des propriétés — en K7PL rien ne s'étend, tout se précise —, chaque étape raffinant le type des
définitions qu'elle produit sans modifier celle qu'elle précise. Un train est une expression de
couche 3 : il s'écrit entre crochets, en texte, ses mots séparés par des espaces, de gauche à droite
et selon la logique des S-expressions : `[add fold div length]` est la moyenne d'un tableau. Il est
l'écriture concaténative de la couche 3 : à arité fixe, il s'exécute de droite à gauche sur la pile,
où toute exécution de couche 3 a lieu. Chaque mot
y porte une arité typée — monadique, dyadique, au plus triadique, jamais n-aire —, et c'est elle qui
permet à l'élaboration de distinguer un train d'une application ; un glyphe employé sous deux arités
porte donc un alias par arité. C'est encore l'arité de chaque mot, et non la longueur du train, qui
décide de son assemblage, selon la règle de FIXAPL {cite "lockwoodFIXAPL"}[]. Le train s'assemble de
droite à gauche : un mot monadique s'applique au résultat de ce qui est à sa droite ; un mot dyadique
précédé d'un mot forme avec lui une fourche, le mot de gauche s'appliquant aux arguments du train et
son résultat devenant l'argument gauche du mot dyadique, dont l'argument droit est le résultat de ce
qui est à sa droite ; sans mot à sa gauche, un mot dyadique prend l'argument gauche du train ; une
paire de crochets intérieure compte pour un mot. Un modifieur d'un opérande suit cet opérande, un
modifieur de deux se place entre eux, et les modifieurs se prennent avant l'assemblage du train :
`[add fold div length]` se lit `[[add fold] div length]`. Une valeur peut terminer un train :
`[sub 1]` est la fonction $`x - 1`, la valeur étant l'argument droit de `sub` et l'argument du train
son argument gauche. Un crochet n'est une application que lorsque sa tête y reçoit tous ses
arguments (`[add 1 2]`). Un mot
triadique ne figure pas dans un train : il ne fait que s'appliquer. L'écart-type s'écrit ainsi avec
un seul groupe intérieur, `[sqrt [add fold square identity sub add fold div length] div length]`
(§{num "sec:c5-mise-en-pratique"}[]). La forme en glyphes, `[+´÷≠]`, est une vue de l'éditeur, qui
remplace chaque mot par son glyphe à sa place et le colore selon son rôle, que son type indique :
valeur, fonction, modifieur d'une fonction ou modifieur de deux. Un glyphe de la table du chapitre 1 ne se lit seul que dans une suite
faite seulement de glyphes et de modifieurs, comme `+´÷≠` ; toute autre suite se lit d'un tenant,
comme un nom ou un nombre : `increment-bounded`, `x-1` et `-2` sont chacun un atome. Un glyphe écrit
dans un fichier hors d'un texte est accepté : le formateur le réécrit par son mot et le signale par
la remarque `HEY-LEX-001`, qui n'est ni une erreur ni un avertissement ; un glyphe voulu comme
caractère s'écrit
dans un texte par son nom LaTeX. L'apostrophe cite une expression, comme en Lisp : `'x` se lit
`(quote x)`. Un
nombre s'écrit en décimal, avec une fraction et un exposant facultatifs et des chiffres que `_` peut
grouper (`1_000_000`, `1.5e-3`), en rationnel (`1/3`) ou en complexe (`3+4i`), ou vaut `inf`, `-inf`
ou `nan`. Les valeurs booléennes s'écrivent `t` et `f`, deux constantes qu'aucune liaison ne peut
masquer ; un nom qui finit par `-t` ou `-f`, comme `access-f`, reste un nom ordinaire. Un drapeau
`+nom` abrège la propriété `:nom t`, et une option qui n'est pas écrite vaut `f`. Un chemin s'écrit comme un symbole dont les noms sont séparés par `/` ; un
espace s'y code en pourcent, comme dans une URL (`c/users/me/My%20Documents`). Un type s'écrit en
minuscules et n'apparaît qu'après une propriété qui l'annonce, `:num` ou `:type` par exemple
(`:num int32`). Une paire vide est la structure vide de sa couche, chaque couche étant elle-même une
structure de données — arène linéaire en couche 1, tas en couche 2, pile en couche 3 : `[]` est le
vecteur vide, `()` la liste vide et `{}` l'enregistrement ou la table vide ; elle porte les grades de
son fragment, vérifiés à la compilation. Une paire doublée, dont la paire intérieure est seule,
précise une forme propre à sa couche et reste dans la couche de sa paire simple ; l'éditeur l'affiche
en crochets blancs, de même sens : `[[ x ]]` est `⟦ x ⟧`, `(( x ))` est `⦅ x ⦆` et `{{ x }}` est
`⦃ x ⦄`. En couche 3, où la mémoire se calcule avant l'exécution, `[[ … ]]` ne contient qu'un
littéral dont la taille se connaît avant l'exécution, reconnu à sa forme et sans mot de tête : une
classe de caractères, à son nom entre deux-points (`[[:alpha:]]`), ou un intervalle, dont les bornes
sont des littéraux ou se calculent à la compilation. Un intervalle `a..b` inclut ses deux bornes
(`[[1..9]]`) ; un mot qui le suit en saute des valeurs, en prenant combien sauter et tous les
combien (`[[1..9 skip 1 2]]` vaut `1 3 5 7 9`) ; plusieurs
intervalles forment la matrice de leurs paires d'indices (`[[1..3 1..3]]`) ; des textes d'un
caractère peuvent en être les bornes (`[["a".."z"]]`). Une borne exclue, à gauche, à droite ou aux
deux, se marque par un mot dédié, qui reste à choisir. Réserver un stockage dans le cadre de la
fonction appelante, libéré avec lui, est une propriété de la déclaration (`+frame`), et appliquer une
fonction cellule par cellule, un modifieur de train (`rank`). En
couche 2, `(( … ))` est un crochet d'idiome : une fonction pure appliquée à des arguments à effet, chaque effet dans
l'ordre ; un intervalle y est une liste paresseuse, écrite dans la paire doublée de sa couche
(`((1..n))`) et reconnue à sa forme, et prend `inf` pour borne s'il est sans fin (`((1..inf))`). En
couche 1, `{{ … }}` est un type raffiné $`\{x : T \mid p\}` du chapitre 3
(§{num "sec:c3-les-contraintes-de-valeur"}[]) : une variable, un type support et un prédicat dont
le solveur décharge l'obligation de preuve. Deux
points-virgules ouvrent un
commentaire qui court jusqu'à la fin de la ligne : `;;` pour un commentaire courant, `;;;` pour un
titre et `;;;;` pour un sous-titre. Un point-virgule seul écrit juste avant un délimiteur ouvrant —
`;(`, `;[` ou `;{` — désactive l'arbre que ce délimiteur ouvre, sans rompre la syntaxe : l'arbre
désactivé reste lu et soumis aux mêmes règles d'équilibre et d'imbrication que les autres, car une
déclaration peut en faire une composante du code, à la manière d'un _quote_ ou d'un _quasiquote_ de
la famille Lisp. Partout ailleurs, un point-virgule seul est un caractère ordinaire : collé à la fin
d'un nom, il forme un atome à part (`a;` se lit `a` puis `;`), et entre deux caractères d'un nom, il
en fait partie (`a;b`). La barre verticale sépare les rangs d'un
littéral tableau : `[1 2 | 3 4]` dénote une matrice deux par deux, dont les rangs doivent avoir la
même longueur. Doublée, elle en sépare les plans, la troisième dimension :
`[1 2 | 3 4 || 5 6 | 7 8]` ; répéter un délimiteur élève son niveau sans changer sa couche. Le `let` n'introduit que des liaisons scopées, immuables et séquentielles — un `let*`
implicite ; il n'existe pas de `var`, la mutation s'exprimant ailleurs, par un `HandlerResult` en
couche 2 ou par transfert de capabilité en couche 1.

Le guillemet droit est la quatrième paire, celle du texte, et la répétition y élève aussi le niveau :
`""` suivi d'une espace, d'un délimiteur ou d'une fin de ligne est le texte vide, `"s"` un texte,
`""s""` un texte brut, et trois guillemets ouvrent un bloc. Un texte peut courir sur plusieurs
lignes, dont les sauts font partie du texte. Dans un texte, `\` échappe le caractère qui le suit, et
un échappement inconnu est refusé ; un caractère spécial s'écrit par son nom LaTeX, qui absorbe une
seule espace après lui (`\guillemetright`), un caractère invisible par l'un des noms que K7PL
ajoute à ceux de LaTeX — `\tab`, `\return`, `\nbsp`, `\shy`, `\zwsp`, `\zwnj`, `\zwj` et `\bom`,
d'autres s'ajoutant au besoin —, et tout caractère par son point de code, `\u'…'`. Dans un texte brut,
`\` reste littéral et toute séquence `%XX` se décode, comme dans une URL : un guillemet s'y écrit
`%22`, une espace initiale `%20`, et un `%` littéral `%25`.
Il n'y a pas de type caractère : un texte d'un caractère en tient lieu (`"a"`, `"μ"`,
`"\lambda"`). Un type texte s'écrit `strN` : comme dans `intN`, N compte les bits qu'il alloue à
l'encodage du texte, et `str` seul est un trou typé. Un encodage est un type raffiné de `str`,
écrit par un constructeur de type (`{str 256 utf16}`) : UTF-8 est celui que retient la résolution
d'un trou typé, et ASCII, UTF-16, UTF-32 ou celui d'Emacs s'écrivent de même. Un type raffiné porte
son étiquette et ne se déspécialise pas : un texte `utf8` n'entre pas dans un `str12`, qui n'est
pas étiqueté `utf8`, alors qu'un `str8` peut s'y ranger. Une largeur qui n'est pas un multiple de
l'unité de l'encodage est refusée dès la Phase 0 (`ERR-TYP-013`). Les graphèmes ne se comptent que dans
l'interface de développement : la longueur d'une ligne, que le formateur et l'analyseur de style
mesurent pour garder le code lisible, se compte en graphèmes. Les fichiers gardent les formes ASCII ;
l'éditeur affiche un texte brut `« s »`, comme il affiche une paire doublée en crochets blancs, `||`
en `‖` et un train en glyphes.

Un délimiteur qualifié nomme le type d'un littéral écrit dans un autre langage : `{sql|` est un seul
délimiteur ouvrant, qui attend sa paire fermante `|sql}`, et ce qu'ils encadrent est le texte de ce
langage, que K7PL ne compile pas. L'étiquette est un type de couche 1, déclaré avec une grammaire
facultative qui peut valider le littéral ; une étiquette inconnue laisse le littéral en texte
ordinaire, typé par l'étiquette tout de même, ce qui permet de prototyper avant de tout typer, et
l'avertissement `WRN-LEX-001` le signale. Les
quatre formes d'une même étiquette suivent leurs couches : `"sql|…|sql"` est un texte typé,
`{sql|…|sql}` est déclaré et vérifié à la compilation, `(sql|…|sql)` est exécuté, et `[sql|…|sql]`
est pur et termine, limité aux requêtes dont les négations se stratifient (corollaire
{num "thm:terminaison_strates"}[]). Un littéral qui contient sa propre fermante s'écrit avec un alias
de l'étiquette, second nom déclaré pour le même type. Un trou dans un littéral qualifié est un trou
typé, passé en paramètre et jamais collé dans le texte ; un texte ordinaire n'interpole jamais.
Chaque type d'étiquette déclare comment ses trous s'écrivent, et la règle n'existe qu'une fois ce
type spécifié ; `sql`, d'après le SQL standard, sera le premier. Une classe
de caractères se nomme entre deux deux-points, `:alpha:`, à part de l'étiquette `:alpha` :
`[:alpha: c]` est un prédicat, `[[:alpha:]]` ses points de code, ses bornes s'obtenant par une
fonction, `((:alpha:))` ses
points de code dans l'ordre, produits à la demande — un crochet d'idiome sans argument —, et
`{{:alpha:}}` le type raffiné des textes d'un caractère qu'elle admet ; les noms POSIX y désignent
les propriétés Unicode que leur associe l'UTS #18, et le complément d'une classe se prend parmi les
valeurs scalaires Unicode. Appliquée à un texte dont le caractère réunit plusieurs points de code,
comme un `e` suivi d'un accent combinant, une classe teste le premier, sa base.

Cinq mots-clés activent une preuve supplémentaire au moment de la vérification. Ils ne sont réservés
qu'en position de tête d'une S-expression, pour ne pas restreindre leur usage comme noms ordinaires
ailleurs. Aucun n'est un mécanisme. _Chacun est la projection nommée d'une obligation que le
jugement porte déjà_, et sert à la réclamer au site d'un appel, là où le contexte ne l'impose pas.
Le tableau {num "tab:c5-mots-cles-preuve"}[] donne, pour chacun, l'obligation projetée et le lieu où
elle est vérifiée ; aucun d'eux n'ajoute de pouvoir au vérificateur.

::::k7table (label := "tab:c5-mots-cles-preuve") (align := "lZ{0.9}Z{1.1}")
:::caption
Les cinq mots-clés de preuve, et l'obligation que chacun projette
:::

:::table +header
* * Mot-clé
  * Obligation projetée
  * Où elle est déjà vérifiée
* * `pure`
  * $`\mathcal{E} = \emptyset`
  * Phase 5, pour tout bloc de couche 3
* * `terminates`
  * une mesure strictement décroissante sur un grade
  * tout pli de couche 3
* * `event`
  * la productivité coinductive
  * tout flux de couche 2
* * `contract`
  * des pré- et post-conditions sur $`\Delta`
  * la substituabilité des refactorings prouvés
* * `logic`
  * aucune — il guide le _narrowing_
  * la résolution de contraintes, sans pouvoir ajouté
:::
::::

Aucun de ces cinq mots-clés n'introduit ainsi de preuve nouvelle : la syntaxe rend un choix
explicite, elle ne fonde rien qui ne le soit déjà.
