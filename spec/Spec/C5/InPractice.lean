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

#doc (Manual) "Mise en pratique" =>
%%%
file := "c5-mise-en-pratique"
tag := "c5-mise-en-pratique"
%%%

{label "sec:c5-mise-en-pratique"}

Écrire du K7PL, c'est choisir, à chaque expression, le fragment le moins permissif que la tâche
autorise, et laisser les délimiteurs en porter la trace. Avant de composer les trois couches sur un
exemple complet, un mot sur ce que la notation tacite du §{num "sec:c5-notations-specialisees"}[]
donne à voir une fois débarrassée de ses noms. La moyenne d'un tableau s'écrit
`[fold add div length]` : plier par addition, diviser par la longueur ; l'éditeur l'affiche `[´+÷≠]`,
chaque mot remplacé par son glyphe à sa place. Son écart-type s'écrit
`[sqrt [[fold add [square [identity sub [fold add div length]]]] div length]]`, affiché
`[√[[´+[²[⊢-[´+÷≠]]]]÷≠]]` : la même moyenne soustraite à chaque élément, élevée au carré, repliée
et divisée à son tour, puis passée à la racine. Aucun argument n'y est nommé ; le train se lit comme
une composition de fonctions plutôt que comme une suite d'instructions, ce que le
§{num "sec:c5-notations-specialisees"}[] annonçait.

Cette section construit maintenant un exemple unique — un compteur borné, répliqué en acteur — en
remontant des trois couches jusqu'à leur composition, puis en examinant l'erreur la plus commune à
leur frontière.

Le cœur du calcul est une fonction pure de couche 3 ({num "lst:fonction-pure"}[]). Sa définition
s'ouvre en couche 1, où se pose son type ; ses paramètres et son corps s'écrivent entre crochets :

::::listing (label := "lst:fonction-pure")
:::caption
Le cœur du calcul : une fonction pure de couche 3, totale et sans effet
:::

```
{defn ?increment-bounded :type {function int32 int32 {result int32 overflow}}
  [value bound]
  [select [< value bound]
          [Ok [+ value 1]]
          [Err Overflow]]}
```
::::

Le préfixe `?` engage le contrat du chapitre 3 (§{num "sec:c3-structures-ouvertes-effets-et"}[]) :
cette fonction ne peut ni déclencher d'effet ni paniquer, elle ne peut que retourner une valeur —
ici un `Result`, puisque le débordement reste une issue normale du calcul plutôt qu'une exception à
lever.

Autour de ce calcul, une couche 2 orchestre l'effet observable : recevoir un message, appeler la
fonction pure, décrire le nouvel état sans jamais le muter directement ({num "lst:gestionnaire"}[]).

::::listing (label := "lst:gestionnaire")
:::caption
La couche 2 orchestre l'effet observable sans jamais muter l'état directement
:::

```
{defhandler counter-handler :type …
  (message state)
  (match message
    ((Increment n)
     (match [?increment-bounded [view state value] [view state bound]]
       ((Ok new-value)
        (HandlerResult :state (set state value new-value) :response (Ok new-value)))
       ((Err e)
        (HandlerResult :state state :response (Err e))))))}
```
::::

Le calcul de couche 3 est appelé depuis la couche 2, ce qui est légitime : le pur s'invoque de
partout (§{num "sec:c5-s-expressions-universelles"}[]). C'est cette frontière, seule, que les
crochets de l'appel signalent ; à l'intérieur, les lectures de l'état par la lentille `view`
s'écrivent elles aussi entre crochets, puisqu'elles se vérifient dans le fragment cartésien de
l'appel. Le gestionnaire s'ouvre en couche 1, comme toute définition ; son corps, qui ne quitte
jamais la couche 2, s'écrit entre parenthèses, le délimiteur de la couche 2 — y compris la mise à
jour de l'état par la lentille `set`, qui préserve le champ `bound` inchangé sans qu'aucun
`HandlerResult` n'ait besoin de le répéter.

L'acteur lui-même n'est qu'une déclaration : aucune logique n'y figure directement, seulement la
topologie et le rattachement du gestionnaire ({num "lst:acteur"}[]).

::::listing (label := "lst:acteur")
:::caption
L'acteur ne porte que sa topologie et le rattachement de son gestionnaire
:::

```
{defactor Counter
  {field value :num int}
  {field bound :num int}
  (bind-to counter-handler)}
```
::::

La forme `bind-to` appelle une remarque, car elle est la seule construction du langage dont
l'existence ne se déduise pas du jugement germinal. Elle déclare une association que rien n'oblige à
déclarer, contrevenant à la fois à la clôture du chapitre 1 et au principe de ce chapitre. Elle
n'est donc pas une primitive. Un acteur _est_ la paire additive dépendante
$`(\text{état} : S)\,\&\,\text{Handler}(S)` du chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]), et `bind-to` n'est qu'un accès de champ. Lorsque
le programmeur l'omet, l'élaborateur remplit la seconde composante par recherche dirigée par le type
— technique dont la propriété conditionnante est la _cohérence_, le fait qu'un programme valide ait
exactement une signification {cite "racordonStateCoherenceLand2025"}[], et dont la preuve formelle
en présence de non-déterminisme est récente et non triviale {cite "BOTTU"}[], {cite "schrijversCOCHISStableCoherent2019"}[].
Ici elle ne coûte rien : la structure fixe le sens, la recherche n'est qu'un sucre, et une recherche
ambiguë est refusée en Phase 1 plutôt que résolue arbitrairement. La cohérence est une condition
d'erreur, non une obligation de métathéorie. L'unicité du type d'état par gabarit (chapitre 4,
§{num "sec:c4-echelle-du-systeme"}[]) est la condition sous laquelle le sucre aboutit ; la voie
modulaire, où l'association est portée par une structure plutôt que déduite, est activement conçue
ailleurs {cite "VIVIEN"}[].

Ici, les champs portent un type et s'écrivent donc entre accolades, en couche 1 ; `bind-to`
s'écrit entre parenthèses, le délimiteur de la couche 2, que le bloc de couche 1 admet. Le type
`int`, sans largeur, est un trou typé que l'élaboration résout dans la famille des entiers : à la
plus petite largeur qui contient toutes les valeurs que le solveur sait borner, le programme étant
refusé si le solveur n'en borne aucune (`ERR-SMT-003`) : le développeur précise alors son intention
dans le code. Ces
trois déclarations respectent la forme descendante
`{ ... ( ... [ ... ] ... ) ... }` du §{num "sec:c5-s-expressions-universelles"}[] : `bind-to` relie
l'acteur à son gestionnaire, qui appelle lui-même le calcul pur — chaque frontière franchie porte le
délimiteur du fragment vers lequel elle mène, et pas une de plus.

L'erreur la plus commune consiste à faire remonter, dans l'autre sens, une construction qui suppose
un effet à l'intérieur d'un bloc `[ ]` ({num "lst:erreur-remontee"}[]) :

::::listing (label := "lst:erreur-remontee")
:::caption
L'erreur la plus commune : une construction à effet remontée dans un bloc pur, rejetée par
ERR-TOP-001
:::

```
{defn ?increment-bounded :type …
  [value bound]
  [Ok (HandlerResult :state value :response (Ok value))]}  ;; rejeté : ERR-TOP-001
```
::::

La parenthèse n'est pas ici en cause comme simple notation : dans ce même bloc, un appel à `select`
ou à `view` s'écrit entre crochets sans rien enfreindre, et la parenthèse ne s'y trouve que parce que
`HandlerResult` est une construction de couche 2. Ce qui est rejeté, c'est que
`HandlerResult` suppose un état d'acteur et un effet de couche 2 — $`\mathcal{E}` et
$`\Delta_{\text{aff}}` — dont le jugement de couche 3 ne dispose tout simplement pas ($`\Delta = \Delta_{\omega}`, chapitre 1, §{num "sec:c1-axiomatique-germinale"}[]). Aucun délimiteur ne
pourrait rendre cet appel légitime, puisqu'aucune transition vers la couche 2 n'est permise depuis
la couche 3. Ce n'est pas une erreur de notation que le bon crochet aurait évitée, c'est une
impossibilité structurelle que la notation ne fait que rendre visible.

{bibliography}
