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

#doc (Manual) "Guide de lecture" =>
%%%
file := "c1-guide-de-lecture"
tag := "c1-guide-de-lecture"
%%%

Quatre mots ont ici un sens fixe et ne s'emploient pas l'un pour l'autre. Les énoncés qui suivent
sont de forces très inégales, et c'est à ces mots qu'on les reconnaît. Un _postulat_ est posé et non
dérivé : les quatre du chapitre 1 sont de cette espèce, et ils servent de filtre d'évaluation plutôt
que de nomenclature. Un _théorème_ est démontré ou esquissé, dans un environnement nommé, sa réserve
écrite dans l'esquisse. Un _engagement_ est tenu pour vrai sans démonstration, et le dit ; la liste
en est donnée ci-dessous, exhaustive et courte. Une _lecture_ est une analogie organisatrice, sans
force démonstrative : le mot sert quand une structure éclaire sans engager.

Trois mots complètent ces quatre, que ce document emploie constamment et qu'il serait malhonnête de
laisser hors de la convention. Une _réserve_ borne la portée d'un résultat, pour empêcher qu'on lui
prête plus qu'il n'établit. Une _obligation_ est une preuve à fournir au vérificateur, portée par un
terme et non par le document. Une _exigence_ est une contrainte que l'implémentation doit
satisfaire, et dont ni la démonstration ni la réfutation n'appartiennent à ce texte.

Cette convention a une conséquence que le lecteur peut exiger : là où aucun de ces sept mots
n'apparaît, l'énoncé est une conséquence de ce qui précède, et le renvoi qui l'accompagne dit d'où
il vient.

Il y a onze engagements, et leur brièveté est en soi une donnée : la plupart de ce qui en fut un au
cours de la rédaction est devenu soit un théorème, soit une réserve explicite.

::::k7table (label := "tab:engagements") (align := "Z{1.06}lZ{0.74}l")
:::caption
Les onze engagements, ce qu'ils affirment, ce qui les tient et par où ils se lèveront
:::

:::table +header
* * Engagement
  * Où
  * Ce qui le tient
  * Route
* * La cohérence au sens de Kelly et Mac Lane
  * §{num "sec:c2-la-comonade-exponentielle-et"}[]
  * La littérature primaire le référence sans le redémontrer
  * littérature
* * L'enrichissement sur les préordres, pour la part qui excède l'ordre des fibres
  * §{num "sec:c2-adjonctions-et-enrichissement"}[]
  * Rien ; le théorème {num "thm:raffinement"}[] en dérive l'autre part
  * démonstration
* * L'isolation par types plutôt que par unité de gestion mémoire
  * §{num "sec:c4-echelle-du-systeme"}[]
  * Une réalisation déployée, non une preuve
  * mesure
* * La conformité de l'abaissement au modèle mémoire déclaré
  * §{num "sec:c4-echelle-du-systeme"}[]
  * Rien ; c'est une propriété du compilateur
  * démonstration
* * La fidélité de l'interpréteur de référence
  * §{num "sec:c6-strategies-de-verification-et"}[]
  * Le théorème {num "thm:traduction_metalangage"}[], démontré à l'annexe {num "sec:annexe-presentation-formelle"}[]
  * démonstration (levée)
* * Le coût d'expressivité de P3 et P4, inférieur au bénéfice
  * §{num "sec:c1-postulats"}[]
  * Un pari, dont le protocole de mesure est écrit et non conduit
  * mesure
* * La reproductibilité de la compilation
  * §{num "sec:c5-mise-en-pratique"}[]
  * Visée, non garantie — et le document l'écrit
  * mesure
* * La rareté des changements de fragment, qui borne la verbosité des délimiteurs
  * §{num "sec:c5-s-expressions-universelles"}[]
  * Un pari, mesurable dès le gel de la syntaxe et non encore mesuré
  * mesure
* * La correction de ressource — le grade tient ce qu'il annonce
  * §{num "sec:annexe-presentation-formelle"}[]
  * Rien ; l'énoncé est posé, sa preuve reste à conduire
  * démonstration
* * L'accord entre la réduction et son interprétation
  * §{num "sec:c2-la-categorie-ambiante"}[]
  * Rien ; c'est ce qui relierait la machine au modèle
  * démonstration
* * L'existence de l'interprétation $`\llbracket - \rrbracket_{\mathcal{C}}`
  * §{num "sec:c2-la-categorie-ambiante"}[]
  * Rien ; le premier postulat la suppose sans la construire
  * démonstration
:::
::::

Aucun de ces engagements n'est caché : chacun est signalé là où il est pris, et la table {num "tab:engagements"}[]
ne fait que les rassembler. Ils ne sont pas de même nature. Les deux paris sur l'usage — le coût
d'expressivité des deux postulats, et la rareté des changements de fragment — ne se tranchent que
par une mise à l'épreuve, et ce document écrit désormais laquelle plutôt que de la laisser à
imaginer. Le second se mesure _sur du texte_, sans rien exécuter : on écrit un corpus de programmes
représentatifs, on compte les franchissements de fragment par millier de lignes, et on rapporte ce
nombre à celui des expressions. La mesure est disponible dès que la syntaxe est gelée, et elle
n'attend aucun prototype. Le premier demande le noyau exécutable : on relève les programmes du
corpus que les deux postulats rejettent, et l'on regarde pour chacun s'il existe une reformulation
acceptée — ce qui rend un _taux de rejet sans reformulation disponible_, et non une opinion. Écrire
ces deux protocoles ne les acquitte pas ; cela dit ce qu'un pair devrait refaire pour les
contredire. Les autres sont des propositions dont on saurait dire ce qu'il faudrait pour les
établir.

Une règle gouverne désormais cette table, et elle vaut d'être posée parce qu'un engagement qui ne
dit pas comment il se lèvera n'est pas un engagement mais un aveu. {rmq}[Trois routes seulement. Une
quatrième — « on verra » — n'en est pas une.] _Tout engagement de ce document nomme la route par
laquelle il se lèvera, et il n'y en a que trois._ La _littérature_ : l'énoncé est déjà établi
ailleurs, et il suffit de le référencer dans sa source primaire plutôt que de le redémontrer. La
_démonstration_ : il ne l'est pas, et ce document ou sa mécanisation doit le prouver — auquel cas
l'engagement porte le nom du théorème qui l'acquittera. La _mesure_ : il ne se démontre pas du tout,
étant un énoncé sur l'usage ou sur une réalisation, et l'engagement porte alors le protocole qui le
trancherait.

Trois conséquences suivent, et la première a déjà joué. Un engagement dont la route est la
démonstration _cesse d'être un engagement le jour où le théorème est écrit_ : la fidélité de
l'interpréteur de référence en est sortie, l'annexe ayant démontré que la traduction préserve le
typage. La table le dit maintenant, et le disait mal auparavant — un document qui ne relit pas ses
engagements finit par s'accuser de dettes qu'il a payées. La deuxième est qu'un engagement dont la
route est la mesure ne se lèvera jamais par la lecture, et qu'il est vain de l'y attendre. La
troisième est qu'un engagement _sans route nommée_ est une anomalie : il en reste un dans cette
table, l'enrichissement sur les préordres pour la part qui excède l'ordre des fibres, et sa route
est la démonstration — le théorème {num "thm:raffinement"}[] en dérive l'autre part, et rien
n'établit encore celle-là.

Une lecture est une analogie qui organise sans engager. Il n'en reste que deux, et c'est le résultat
d'un travail. La plupart des analogies de la première rédaction ont été soit démontrées — le
namespace comme inclusion fonctorielle, l'orchestrateur comme coalgèbre, le grade de présence comme
fragment affine — soit requalifiées en réserve.

La _sédimentation triadique_ est une lecture : que les trois couches se « déposent » l'une sur
l'autre est une image, et ce qui la soutient formellement est l'inclusion des fragments, qui est
autre chose. Cette réserve a désormais une mesure : l'inclusion tient sur l'axe des ressources et
s'inverse sur _deux_ autres. Sur celui des effets, où la couche 3 est la plus pauvre puisqu'elle
n'en a aucun ; et sur celui de la concurrence, où elle est la plus pauvre également, son
parallélisme étant déterministe quand la couche 2 porte l'entrelacement
(§{num "sec:annexe-presentation-formelle"}[]). Une image qui ne vaut que sur un axe doit dire
lequel. La _couche 2 comme langage de liaison_, au sens d'Ousterhout, en est une seconde : elle
situe le rôle sans rien en dériver.
