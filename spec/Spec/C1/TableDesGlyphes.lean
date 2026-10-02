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

#doc (Manual) "Table des glyphes" =>
%%%
file := "g-table-glyphes"
tag := "g-table-glyphes"
%%%

{label "sec:g-table-glyphes"}

La table {num "tab:glyphes"}[] complète la dualité glyphe/alias construite au chapitre 5
(§{num "sec:c5-notations-specialisees"}[]) : chaque ligne est une seule _macro de la bibliothèque
standard_, montrée sous ses deux noms, strictement équivalents au niveau de l'AST. La colonne du
_point de code_ n'est pas un choix de typographie : elle est la forme normative du glyphe. Un glyphe
se déclare par son code positionnel Unicode, de sorte que la table reste vérifiable sans dépendre de
la fonte qui l'affiche, et que la cinquième règle d'admission — aucun couple de glyphes ne se
ressemble à l'œil — porte sur des objets identifiés plutôt que sur des dessins. Le glyphe n'est pas
une primitive du noyau — l'arbitrage qui le fixe est écrit au chapitre 5, et cette table en est la
table des noms, non celle des constructions.

::::k7table (label := "tab:glyphes") (align := "lllZ{1.00}")
:::caption
Glyphes de la bibliothèque standard de couche 3 et leurs alias textuels
:::

:::table +header
* * Glyphe
  * Point de code
  * Alias
  * Sémantique
* * `+`
  * `U+002B`
  * `add`
  * Somme élément par élément
* * `-`
  * `U+002D`
  * `sub`
  * Différence élément par élément
* * `×`
  * `U+00D7`
  * `mul`
  * Produit élément par élément
* * `÷`
  * `U+00F7`
  * `div`
  * Quotient élément par élément
* * `⌊`
  * `U+230A`
  * `min`
  * Minimum élément par élément
* * `⌈`
  * `U+2308`
  * `max`
  * Maximum élément par élément
* * `≠`
  * `U+2260`
  * `neq`
  * Inégalité stricte
* * `⊏`
  * `U+228F`
  * `select`
  * Sélection par indices
* * `⊔`
  * `U+2294`
  * `group`
  * Regroupement par clé
* * `⍋`
  * `U+234B`
  * `grade-up`
  * Indices du tri ascendant
* * `⍒`
  * `U+2352`
  * `grade-dn`
  * Indices du tri descendant
* * `↕`
  * `U+2195`
  * `windows`
  * Découpage en fenêtres glissantes
* * `∾`
  * `U+223E`
  * `join`
  * Concaténation verticale
* * `⊣`
  * `U+22A3`
  * `left-id`
  * Retourne l'argument de gauche
* * `⊢`
  * `U+22A2`
  * `right-id`
  * Retourne l'argument de droite
* * `⥊`
  * `U+294A`
  * `reshape`
  * Change la forme d'un tableau
* * `∧`
  * `U+2227`
  * `and`
  * Conjonction bit-à-bit
* * `∨`
  * `U+2228`
  * `or`
  * Disjonction bit-à-bit
* * `¬`
  * `U+00AC`
  * `not`
  * Négation bit-à-bit
* * `=`
  * `U+003D`
  * `eq`
  * Égalité structurée
* * `<`
  * `U+003C`
  * `lt`
  * Comparaison stricte
* * `>`
  * `U+003E`
  * `gt`
  * Comparaison stricte
* * `≤`
  * `U+2264`
  * `le`
  * Comparaison large
* * `≥`
  * `U+2265`
  * `ge`
  * Comparaison large
* * `⍟`
  * `U+235F`
  * `repeat`
  * Applique une fonction $`n` fois
* * `⊘`
  * `U+2298`
  * `compose`
  * Composition de fonctions
* * `↢`
  * `U+21A2`
  * `bind-left`
  * Applique $`f` puis $`g`
* * `↣`
  * `U+21A3`
  * `bind-right`
  * Applique $`g` puis $`f`
:::
::::

Deux lignes de cette table portent une décision de notation qu'il faut écrire, car elle s'écarte de
la source dont le reste s'inspire. Les glyphes de liaison empruntés à BQN étaient `⟜` et `⊸` ; le
second est l'implication linéaire de Girard, employée dans tout ce document au sens logique, et un
signe ne peut pas porter deux travaux. Ce n'est pas le signe logique qui cède. Les deux glyphes de
liaison ont alors été changés _ensemble_, et non le seul fautif : `bind-left` et `bind-right` sont
une paire, et une paire dont un membre garde sa forme d'emprunt quand l'autre reçoit une forme
improvisée n'est plus une paire. Le couple retenu, `↢` et `↣`, est image l'un de l'autre, chacun
tient en un point de code, et la pointe désigne le côté où l'argument s'attache. Ce qui se perd est
la familiarité pour un lecteur venu de BQN, et c'est le seul coût — un argument de familiarité, non
de devinabilité.

Trois signes de ce document servent à plusieurs endroits, et la séparation qui les rend sans danger
doit être dite plutôt que supposée. Le tourniquet `⊢` marque le jugement dans la notation
mathématique, l'identité droite dans la notation de couche 3, et le groupement non capturant dans
celle des R-expressions. Trois emplois, trois contextes que rien ne mélange — les mathématiques ne
s'écrivent pas dans un programme, et une R-expression a ses propres délimiteurs. Le sigil `#` marque
l'évaluation à la compilation et rien d'autre ; il est réservé à cet usage, et toute intention
ultérieure de l'employer pour autre chose doit céder, l'usage écrit primant l'usage projeté. Le
point `.` enfin sert la projection et la décimale, séparés par la position. Aucune de ces trois
coexistences n'est un accident, et chacune tient à ce que le langage sépare lui-même les contextes ;
c'est la même règle qui gouverne ses dix espaces de noms.

Reste la règle qui exige qu'aucun couple de glyphes ne se ressemble à l'œil. Elle était jusqu'ici un
jugement humain, et elle a désormais un _instrument_ : la norme de sécurité d'Unicode définit la
confusabilité de deux chaînes par l'égalité de leur _squelette_, transformation qui remplace chaque
caractère par le prototype que lui associe une donnée normative et versionnée {cite "UnicodeStandardV17"}[].
Deux glyphes sont donc admissibles ensemble si et seulement si leurs squelettes diffèrent, ce qui
est décidable et vérifiable par machine plutôt qu'apprécié.

L'instrument appliqué à cette table rend un résultat en deux temps, et le second est plus utile que
le premier. Aucun couple des vingt-huit ne partage un squelette : la règle est _satisfaite_ à
l'intérieur du jeu. Mais quatre de ces glyphes ont un confusable _hors_ du jeu, et deux d'entre eux
visent une cible qui est un caractère d'identifiant légal — le signe de multiplication se confond
avec la lettre `x`, la disjonction logique avec la lettre `v`. Les deux autres, une étoile cerclée
et une rune, sont sans portée pratique.

Ce que ce constat corrige n'est pas le jeu de glyphes mais la _portée de la règle_. Elle regardait à
l'intérieur du jeu quand le danger est au-dehors : un programme peut porter `x` là où son auteur
voulait le signe de multiplication, et rien ne le signalerait, l'un et l'autre étant licites à cette
position. La règle se réénonce donc en deux clauses — aucun couple du jeu ne partage un squelette,
_et_ tout glyphe dont le squelette est un caractère d'identifiant est déclaré comme tel. La seconde
clause est celle qui manquait, et c'est l'instrument qui l'a fait apparaître.

Une réserve de transport doit accompagner cet emprunt. Cette norme vise la sécurité des identifiants
et l'usurpation d'adresses, non la conception d'un jeu de glyphes~; sa donnée est calibrée sur ce
que confondent des lecteurs de langues diverses devant une chaîne isolée, non sur ce que confond un
programmeur devant une ligne de code. Elle est employée ici parce qu'elle est le seul instrument
normatif disponible, et non parce que son cadre serait le nôtre.

La table {num "tab:glyphes"}[] couvre les opérations de calcul de couche 3 ; les R-expressions
(chapitre 4, §{num "sec:c4-echelle-locale"}[]) portent leur propre vocabulaire glyphique, organisé
selon la même hiérarchie de complexité qui détermine l'automate vers lequel chaque niveau s'abaisse.

::::k7table (label := "tab:glyphes-rexp") (align := "llZ{1.00}")
:::caption
Glyphes des R-expressions, par niveau de complexité
:::

:::table +header
* * Catégorie
  * Glyphe
  * Sémantique
* * Atomes
  * `ℓ`
  * Littéral textuel
* * Atomes
  * `⊙`
  * Classe de caractères
* * Atomes
  * `℘`
  * Classe de propriété Unicode
* * Quantification
  * `◇` / `◆` / `◈`
  * Quantificateur avide / paresseux / possessif
* * Composition
  * `⊕` / `⊞`
  * Séquence / alternance
* * Composition
  * `⊢`
  * Groupement non capturant
* * Capture
  * `⋈`
  * Groupe de capture
* * Assertions
  * `⊲` / `⊳`
  * Début / fin de chaîne
* * Assertions
  * `⊴` / `⊵`
  * Frontière / non-frontière de mot
* * Assertions
  * `⇒` / `⇸`
  * Anticipation positive / négative
* * Assertions
  * `⇐` / `⇷`
  * Rétrospection positive / négative
* * Avancé
  * `⟲`
  * Référence arrière
* * Avancé
  * `∞`
  * Récursion
* * Contrôle
  * `↯`
  * Transformation de contrôle (échec, coupure, engagement...)
* * Approximatif
  * `≈` / `≈ᵘ`
  * Correspondance floue (distance de Levenshtein)
* * Binaire
  * `ß`
  * Filtrage binaire sub-octet
* * Méta
  * `⟦⟧` / `⟨⟩`
  * Annotation / composition nommée
:::
::::

{bibliography}
