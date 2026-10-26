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
autre inclusion est rejetée en Phase 3, et chacune a son code, du conteneur le plus spécifique au
plus générique : un `( )` à l'intérieur d'un `[ ]` (`ERR-TOP-001`), un `{ }` à l'intérieur d'un
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
central a été formellement vérifié {cite "jiaDerivativebasedParserGenerator2021"}[]. Un second trait
de cette approche compte pour un langage homoiconique : l'analyseur rend une _forêt_ de tous les
arbres valides, là où le choix priorisé d'une grammaire d'expressions d'analyse élit une lecture en
silence. Une ambiguïté devient alors une chose qu'on peut voir et refuser, plutôt qu'une chose que
l'analyseur tranche pour soi.

Il n'existe pas de parenthèse ordinaire, neutre vis-à-vis des couches : `( )` est toujours le
délimiteur de la couche 2, et toute expression composée porte le délimiteur de son fragment. Le
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

Le reste de la grammaire commune tient en quelques règles. Le point-virgule ouvre un commentaire, sa
répétition en indiquant la portée — `;` en ligne, `;;` pour un bloc, `;;;` pour une section, `;;;;`
pour un module — et sa mise entre parenthèses, crochets ou accolades désactive l'arbre entier qui
suit sans rompre la syntaxe. La barre verticale sépare les rangs d'un littéral tableau :
`[1 2 | 3 4]` dénote une matrice deux par deux, dont les rangs doivent avoir la même longueur. Le
`let` n'introduit que des liaisons scopées, immuables et séquentielles — un `let*` implicite ; il
n'existe pas de `var`, la mutation s'exprimant ailleurs, par un `HandlerResult` en couche 2 ou par
transfert de capabilité en couche 1.

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
