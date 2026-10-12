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

#doc (Manual) "Calcul de processus sous-jacent" =>
%%%
file := "c4-le-calcul-de-processus"
tag := "c4-le-calcul-de-processus"
%%%

{label "sec:c4-le-calcul-de-processus"}

Les trois échelles qui précèdent ont été décrites l'une après l'autre, chacune avec sa structure
propre. Reste à dire ce qu'elles sont _ensemble_, et le chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) l'a annoncé sous la forme d'une équation : la couche 2
relève d'un $`\pi`-calcul enrichi de motifs de jonction. Cette section fait de cette équation une
construction. Ce qu'elle apporte est une _lecture_, dans laquelle acteurs, sessions, jonctions et
effets cessent d'être quatre mécanismes voisins pour devenir les constructeurs d'un même calcul — et
le §{num "sec:g-couche2"}[] en écrit depuis peu les règles, de sorte que cette lecture a
désormais un appareil sous elle plutôt qu'au-dessus d'elle. {rmq}[La lecture précédait les règles,
ce qui est l'ordre de la découverte et non celui de la justification. Les règles étant écrites, les
deux coïncident.]

Ce métalangage n'est pas une invention de ce document, et le dire évite un malentendu que l'équation
du chapitre 1 pourrait entretenir. Écrire « $`\pi`-calcul augmenté de motifs de jonction » suggère
une extension, dont il faudrait justifier ce qu'elle ajoute ; il s'agit en réalité d'une
_présentation alternative_ du même pouvoir expressif. Le calcul obtenu en ajoutant la réflexion à la
machine chimique abstraite {cite "berryChemicalAbstractMachine1992"}[] est prouvé équivalent au
$`\pi`-calcul, à congruence barbelée faible près, et sa métathéorie est établie {cite "fournetReflexiveCHAMJoincalculus1996"}[].
Ce document emprunte donc un calcul, il n'en propose pas un.

Une seconde parenté rend _vérifiable_ ce qui serait resté une ressemblance. Il existe une extension
des psi-calculi par motifs abstraits et filtrage, munie de _sortes_ sur le langage des termes de
données, qui représente directement plusieurs calculs de processus existants {cite "borgstromSortedSemanticFramework2016"}[].
Le métalangage de ce document en est plausiblement une instance, et les conditions qui le
décideraient sont énumérables plutôt qu'appréciables : une fonction de sorte équivariante sur les
noms, les termes et les motifs~; quatre prédicats de compatibilité, un par rôle — émettre, recevoir,
être substitué par, être lié par restriction de nom~; et un préordre de sous-sorte. La question de
savoir si les sortes de ce document satisfont ces conditions n'est donc pas ouverte au sens où l'on
ne saurait par où commencer : elle est ouverte au sens où le calcul reste à faire.

Ce qu'il en emprunte comprend la théorie équationnelle dont il a besoin. Raisonner sur une
traduction suppose de savoir quand deux processus sont le même, et cette relation est disponible.
Une équivalence observationnelle y est définie puis établie _pleinement abstraite_ vis-à-vis de la
congruence barbelée faible, les techniques employées étant celles de la bisimulation faible {cite "fournetReflexiveCHAMJoincalculus1996"}[].
C'est elle qui donnera son sens à l'énoncé de fidélité du chapitre 6.

Le métalangage a pour types les propositions de la logique linéaire intuitionniste — celles-là mêmes
que le chapitre 3 emploie comme types de session — et pour termes les processus suivants :

::::formula (label := "eq:metalangage") (kind := "equation")
```
\begin{equation}
\begin{aligned}
P, Q \;::=\;& \overline{x}\langle v\rangle.P \;\mid\; x(y).P \;\mid\; x \triangleleft \ell.P \;\mid\; x \triangleright \{\ell_i : P_i\} \\
       \mid\;& (\nu x{:}S)(P \mid Q) \;\mid\; J \triangleright P \;\mid\; !x(y).P \;\mid\; \mathbf{fix}\,X\langle v\rangle.P \;\mid\; \mathbf{0}
\end{aligned}
\end{equation}
```
::::

où $`J ::= x_1(y_1) \,\&\, \cdots \,\&\, x_n(y_n)` est un _motif de jonction_, consommant $`n`
messages d'un seul tenant. Les quatre premières formes sont l'émission et la réception, la sélection
et l'offre de branchement ; la cinquième est la _coupure_, seule forme de composition, qui lie deux
processus sur un canal privé de type $`S` ; la septième est le service répliqué ; la huitième le
point fixe introduit au §{num "sec:c2-adjonctions-et-enrichissement"}[].

Chacune traduit un mécanisme déjà construit, et l'intérêt de la lecture est que cette correspondance
est exhaustive : il n'y a rien dans la couche 2 qui n'y figure, et rien qui y figure sans emploi.

Deux réglages restent à fixer sur cette grammaire, et tous deux retirent du non-déterminisme plutôt
qu'ils n'en ajoutent. Le premier porte sur les _motifs de jonction_. Les règles de réaction d'une
définition de jonction décrivent des comportements en concurrence, et leur déclenchement admet en
général un choix non déterministe — source que le chapitre 1 ne compte pas parmi les siennes. Deux
politiques existent : celle du _premier motif_ rendrait l'ordre d'écriture des clauses
sémantiquement significatif, de sorte que la mise en page déciderait quel couple de messages est
consommé. La _partition en ensembles disjoints_ rend le choix forcé, et donc inexistant {cite "maAlgebraicPatternMatching2008"}[].
K7PL retient la seconde, et le coût en est nul : le compilateur vérifie déjà statiquement
l'exhaustivité des motifs, de sorte que la disjonction est une vérification du même ordre, faite au
même endroit.

Le second porte sur le _point fixe_. La grammaire ci-dessus en donne un opérateur arbitraire, et
c'est la seule exception à la règle que ce document applique partout ailleurs — la couche 3 interdit
la récursion générale et exprime toute itération comme un pli sur le plus petit point fixe. Aucune
raison n'est donnée à cette exception, et il n'y en a pas de bonne : ajouter à un lambda-calcul
linéaire concurrent les types récursifs et les _catamorphismes_, en suivant la sémantique des
algèbres initiales, y fait _naître_ les types de session récursifs au lieu de les postuler {cite "lindleyTalkingBananasStructural2016"}[].
Le point fixe du métalangage devrait donc être un catamorphisme, comme celui de la couche 3, et
l'exception disparaître.

* Un _acteur_ est un point fixe gardé par une réception. La coalgèbre terminale du
  §{num "sec:c2-algebres-coalgebres-et-points"}[] — un état $`S`, une transition
  $`S \to (\text{Msg} \Rightarrow S \times \text{Out})` — s'écrit
  $`\mathbf{fix}\,X\langle s\rangle.\, a(m).\, \llbracket H \rrbracket(s,m)`, où le gestionnaire
  produit l'état suivant qu'il repasse à $`X`. Le point fixe _est_ la finalité de la coalgèbre, lue
  sur les termes plutôt que sur les objets.

* Un _canal de session_ est un canal du calcul, et son type est le protocole. La dualité, dérivée au
  chapitre 3 du retournement des arguments de $`\multimap`, est ici celle des deux extrémités d'une
  coupure : le processus qui offre $`S` et celui qui l'emploie sont les deux prémisses d'une même
  règle.

* Un _motif de jonction_ est la construction $`J \triangleright P`, et son atomicité est celle de la
  règle. Les $`n` messages sont consommés en une seule transition, ce que le théorème {num "thm:sync_motifs_jonction"}[]
  énonce et ce que le §{num "sec:c4-echelle-locale"}[] rapproche d'une transition de réseau de
  Petri.

* Le _séquencement des effets_ est le préfixage : $`\overline{x}\langle v\rangle.P` ordonne
  l'émission avant $`P`, et cet ordre ne commute pas. C'est ce que la quantale d'effets du chapitre
  3 dénote par son produit non commutatif ; le préfixe du calcul en est la forme syntaxique.

* Une _capacité_ de couche 1 est un canal linéaire, et une capacité de lecture un service répliqué —
  la distinction entre l'usage unique et l'usage libre y devient celle entre $`x(y).P` et
  $`!x(y).P`, c'est-à-dire le grade. Le service répliqué se déplie toutefois _à sens unique_, et ce
  n'est pas un arrangement de présentation. La loi de réplication — l'équivalence entre
  l'exponentielle et sa décomposition en une copie et l'exponentielle — n'est pas dérivable en
  logique linéaire, seul un sens l'est {cite "cervesatoLogicalMeetingPoint2004"}[]. La conséquence
  relevée par cette littérature est qu'un encodage qui supposerait l'équivalence ne capture pas
  fidèlement l'exécution du calcul de processus telle qu'elle est traditionnellement définie. La
  correction ne coûte rien ici : on garde la moitié qui se dérive, sous forme d'un dépliage à sens
  unique, et l'énoncé de fidélité du chapitre 6 s'énonce sur cette moitié.

* La _composition d'un système_ est un emboîtement de coupures. C'est ce qui explique l'acyclicité
  du §{num "sec:c4-echelle-du-systeme"}[] sans qu'elle ait à être postulée : un terme est un arbre
  de coupures, et un arbre n'a pas de cycle.

Un second principe d'architecture y trouve son fondement, et ce document le posait jusqu'ici sans
appui. La _localité_ — un acteur n'accède qu'à son propre état, aucune mémoire n'est partagée entre
machines, et le modèle mémoire du §{num "sec:c4-echelle-du-systeme"}[] a pour portée une machine —
n'est pas une discipline que K7PL s'imposerait par prudence. C'est l'une des deux modifications qui
définissent le calcul dans lequel il se traduit : on l'obtient de la machine chimique générique en
imposant la localité et en ajoutant la réflexion, et c'est cela qui rend le modèle _consistant avec
la distribution_ {cite "fournetReflexiveCHAMJoincalculus1996"}[]. Ce que le chapitre 4 décrit comme
un choix d'architecture est donc une propriété du calcul sous-jacent, et l'ordre des raisons s'en
trouve inversé. La localité n'est pas imposée à un modèle qui pourrait s'en passer, elle est ce qui
rend ce modèle distribuable.

Cette dernière remarque suggère l'énoncé que cette section doit à la lecture qu'elle propose.

::::theorem (label := "thm:traduction_metalangage") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "translation")
:::title
la traduction préserve le typage
:::

:::statement +titled
Adéquation typée de la lecture par processus

Il existe une traduction $`\llbracket \cdot \rrbracket` des dérivations de K7PL vers les termes du
métalangage, telle que pour tout jugement $`\Delta \vdash_{\mathcal{G}} t : A \mid \mathcal{E}` et
tout canal frais $`z`,
$$`\llbracket t \rrbracket_z \;\vdash\; \llbracket \Delta \rrbracket_{\mathcal{G}},\; z : \llbracket A \rrbracket`
soit un séquent dérivable du métalangage, où $`\llbracket \Delta \rrbracket_{\mathcal{G}}` envoie
chaque liaison de grade $`\omega` sur un service répliqué, chaque liaison de grade $`n` fini sur un
canal linéaire _ré-invoqué $`n` fois en séquence_, et toute autre sur un canal linéaire simple.
:::

:::proofsketch
Par induction sur la dérivation. Les cas de la couche 3 sont ceux de la traduction usuelle des
propositions comme sessions : une abstraction devient une réception, une application une coupure sur
un canal frais, un couple une émission suivie du reste. Les cas de la couche 2 suivent les six
correspondances ci-dessus, chacune envoyant une règle de K7PL sur une règle du calcul — l'acteur sur
le point fixe gardé, la jonction sur $`J \triangleright P`, le séquencement sur le préfixage. La
composante $`\mathcal{G}` dirige le choix entre canal linéaire et service répliqué, ce qui est
licite parce que le grade $`\omega` est l'image du fragment cartésien. La composante $`\mathcal{E}`
n'est pas traduite : elle n'a pas de contrepartie dans le calcul.
:::

::::
Une seconde voie existe pour les cas de la couche 3, plus directe, et elle rejoint un choix déjà
fait. Le fragment séquentiel déterministe du calcul cible est essentiellement le $`\lambda`-calcul
en style à passage de continuations, de sorte que toute transformée CPS y plonge le
$`\lambda`-calcul {cite "fournetReflexiveCHAMJoincalculus1996"}[] — et K7PL a retenu l'appel par
poussée de valeur, cadre où cette transformée se lit sans détour. L'inclusion qu'affirme l'équation
du chapitre 1 cesse ainsi d'être une affirmation pour devenir un plongement nommé.

L'esquisse ne conduit pas l'induction cas par cas, et deux points y résisteraient. {rmq}[L'obstacle
est de conduire la traduction, non de trouver une cible. Celle-ci existe et porte ce qu'il faut.]
Les types dépendants pragmatiques du §{num "sec:c3-les-contraintes-de-valeur"}[] demandent des
quantificateurs du second ordre que le métalangage doit posséder — fragment disponible avec sa
propre théorie de l'équivalence comportementale {cite "pierceBehavioralEquivalencePolymorphic2000"}[].
Et le point fixe du §{num "sec:c2-adjonctions-et-enrichissement"}[] suppose que le semi-treillis
d'arrivée soit lui-même interprété. Une machine abstraite pour sessions linéaires correspondant à la
logique linéaire classique, étendue de quantificateurs du second ordre et de types inductifs,
fournit l'un et l'autre, avec une stratégie d'évaluation séquentielle déterministe dérivée de la
focalisation et une adéquation établie dans les deux sens {cite "cairesLinearSessionAbstract2026"}[].
C'est elle que ce document désigne comme interprétation du métalangage, sans conduire ici la
vérification.

S'il tient, correction et adéquation se raisonnent une fois au niveau du métalangage et non
construction par construction de K7PL — c'est l'économie que ce chapitre revendique. S'il tombe,
chaque construction du langage redemande son propre argument de correction, et la dette de fidélité
du chapitre 6 redevient aussi large qu'elle en avait l'air.

Les trois conséquences qui précèdent supposent une induction que ce document doit maintenant
conduire, au moins dans son plan. Elle porte sur la dérivation, et se range en quatre groupes selon
ce que chaque règle engage.

Le premier groupe est celui des règles _structurelles_, et il ne demande rien. L'affaiblissement
envoie sur l'affaiblissement du séquent, la contraction sur la duplication d'un service répliqué —
laquelle est licite exactement quand le grade vaut $`\omega`, ce qui est l'hypothèse de la règle
source. L'échange n'a pas d'image, les contextes du métalangage étant des ensembles.

Le deuxième est celui des _connecteurs_, et il suit la traduction usuelle des propositions comme
sessions. L'abstraction devient une réception, l'application une coupure sur canal frais, le couple
une émission suivie de la continuation, la projection une sélection, le branchement une offre.
Chaque règle envoie sur une règle, et la préservation du typage y est immédiate puisque les types
sont les mêmes objets de part et d'autre.

Le troisième est celui des règles _propres à K7PL_, et c'est là que l'induction fait un travail. Un
acteur envoie sur un point fixe gardé par une réception, sa coalgèbre terminale devenant la finalité
de ce point fixe. Un motif de jonction envoie sur la construction homonyme, dont l'atomicité est
celle de la règle. Le séquencement d'effets envoie sur le préfixage, et c'est ici que la marque de
non-commutativité du produit de la quantale trouve son image~: préfixer n'est pas commutatif non
plus. Un effet devient une émission sur le canal distingué de sa sorte, et l'opération
$`\mathbf{tick}` une émission sur celui du temps. Une capacité linéaire devient un canal linéaire,
une capacité de lecture un service répliqué — le choix étant dicté par le grade, ce qui est licite
puisque le grade $`\omega` est l'image du fragment cartésien.

Le quatrième groupe est celui des _cas résistants_, au nombre de quatre, et ils se nomment. Les
types dépendants pragmatiques demandent un fragment du second ordre, disponible avec sa théorie de
l'équivalence {cite "pierceBehavioralEquivalencePolymorphic2000"}[]~; la traduction y envoie un
indice sur une variable de type quantifiée, et la préservation demande que la quantification du
métalangage soit assez riche pour porter les contraintes que le solveur décharge — ce que ce
document n'établit pas. L'opérateur de point fixe déductif demande que le semi-treillis d'arrivée
soit lui-même interprété, faute de quoi son image n'a pas de type~; la machine à sessions linéaires
possède les types inductifs nécessaires {cite "cairesLinearSessionAbstract2026"}[], mais
l'interprétation du treillis y reste à donner. Et les canaux distingués demandent que la traduction
ne produise que des termes _bien sortés_, une sorte étant réservée aux effets et interdite au
programme traduit~; c'est une propriété de la traduction elle-même, vérifiable par une induction
parallèle sur la même dérivation, et non une hypothèse supplémentaire. Le quatrième ne résiste pas
aujourd'hui mais résisterait _demain_, et c'est le seul dont ce document sache qu'il ne pourra pas
le lever. Si la discipline d'échange restreint envisagée au chapitre 3
(§{num "sec:c3-le-systeme-gradue"}[]) était adoptée, une zone de contexte porterait un ordre~; or la
composition parallèle du métalangage est _commutative_, et un ordre ne survit pas à une image
commutative. La traduction resterait _correcte_ — l'extrusion de portée qu'elle emploie repose sur
une propriété de grade que l'ordre ne touche pas —. Mais elle cesserait de transporter l'ordre, de
sorte qu'une propriété établie sur la zone ordonnée ne se lirait plus sur l'image. C'est une _perte_
et non un échec, et la nommer maintenant coûte moins que de la découvrir en adoptant la discipline :
elle est l'un des prix de cette adoption, et il n'était pas compté.

Reste à dire ce qu'on fait du métalangage une fois la traduction établie, car c'est là que
l'économie se réalise. On ne l'interprète qu'une fois. Une machine abstraite pour les sessions
linéaires, dont la stratégie d'évaluation est séquentielle et déterministe et dont l'adéquation est
prouvée dans les deux sens, en fournit l'interprétation {cite "cairesLinearSessionAbstract2026"}[]~;
l'équivalence observationnelle du calcul, pleinement abstraite vis-à-vis de la congruence barbelée
faible, en fournit la théorie des programmes {cite "fournetReflexiveCHAMJoincalculus1996"}[].
Correction et adéquation se raisonnent donc à ce niveau, une fois pour toutes, et non construction
par construction de K7PL. C'est ce que signifiait, au chapitre 6
(§{num "sec:c6-strategies-de-verification-et"}[]), l'affirmation que la dette de fidélité est plus
étroite qu'elle n'y paraissait~: elle se réduit à la préservation du typage par
$`\llbracket \cdot \rrbracket`, dont le plan qui précède donne l'induction sans la mener à son
terme.

Trois conséquences se lisent sur cette traduction, et c'est en cela qu'elle vaut mieux qu'une
reformulation.

La première concerne l'_effacement_. Le chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[])
signale que l'architecture de K7PL est un système de raffinement de types, soit un foncteur des
dérivations vers les termes sous-jacents, sans exhiber ce foncteur. C'est
$`\llbracket \cdot \rrbracket` : une dérivation de K7PL porte $`\mathcal{G}` et $`\mathcal{E}` ; son
image ne les porte pas. L'effacement de la Phase 8 n'est donc pas une opération de compilation qu'il
faudrait justifier séparément — c'est l'action de ce foncteur sur les objets, et la non-interférence
du chapitre 1 est l'énoncé que le métalangage ne voit pas la dérivation.

La deuxième concerne l'_échelle du système_. Le §{num "sec:c4-echelle-du-systeme"}[] pose que
l'orchestrateur est une coalgèbre sans exhiber le foncteur qui l'engendre. Sous la traduction, un
système est un terme — composition parallèle d'acteurs sous restriction des canaux privés —, et le
foncteur cherché est celui dont la coalgèbre finale interprète ce terme. Le produit des foncteurs de
comportement individuels, restreint aux transitions que la topologie de coupures autorise. Ce n'est
pas une nouvelle construction, c'est la lecture de la composition parallèle comme opération sur les
coalgèbres.

Une restriction doit toutefois y être ajoutée à la main, et c'est la seule des trois conséquences
qui en demande une. Cet argument _remonte_ de la cible vers la source, quand les deux autres en
descendent. Or la topologie de coupures ne porte pas les disciplines que la cible ne connaît pas —
l'ordre d'une zone d'échange (chapitre 3, §{num "sec:c3-le-systeme-gradue"}[]) en est une. Le
foncteur ainsi obtenu _admet donc des transitions que la source interdit_ : c'est une
sur-approximation, dont la coalgèbre de l'orchestrateur est une sous-coalgèbre. Cela suffit à
établir que le foncteur existe et quelle forme il a ; cela ne suffirait pas à en tirer une propriété
de sûreté, une sur-approximation ne démontrant jamais une sûreté.

La troisième concerne la _fidélité de l'interpréteur_ de référence (chapitre 6,
§{num "sec:c6-strategies-de-verification-et"}[]). L'interpréteur est fidèle si ses transitions sont
celles du métalangage. Comme celui-ci est interprété une fois pour toutes, correction et adéquation
se raisonnent à son niveau et non sur chaque construction de K7PL. Cette remarque se laisse porter
jusqu'à un énoncé, qui dit ce qu'un interpréteur de référence garantit et ce qu'il ne garantit pas.

::::theorem (label := "thm:simulation") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "translation")
:::title
simulation de la relation de réduction par la traduction
:::

:::statement +titled
Chaque pas de K7PL est suivi par au moins un pas du métalangage

$`\langle c \mid \mu \mid \tau \rangle \to \langle c' \mid \mu' \mid \tau' \rangle` entraîne
$`\llbracket c \rrbracket \to^{+} \llbracket c' \rrbracket` modulo $`\equiv`, et la trace
$`\tau'` étend $`\tau` par l'image des événements du pas.
:::

:::proofsketch
Par induction sur la dérivation du pas, en suivant le terme image. Les réductions pures se rangent
en trois groupes. (1) Les $`\beta`-réductions — application, `let` sur `return`, `force` sur `thunk`,
`unbox` sur `box`, `open` sur `pack`, instanciation — traduisent la coupure d'une introduction et
d'une élimination : la traduction de gauche se réduit en un pas de communication vers
$`(\nu x)(\llbracket c \rrbracket \mid \overline{x}\langle \llbracket v \rrbracket \rangle)`, qui est
$`\llbracket c[v/x] \rrbracket` modulo $`\equiv` par le théorème
{num "thm:commutation_traduction"}[]. (2) Les éliminations de produit, de somme, de conjonction
additive, d'unité, de vecteur vide et de repli sont des communications sur un canal linéaire suivies
d'un aiguillage, un pas chacune. (3) Le parcours d'un vecteur non vide se déplie en deux pas, comme
dans la source. La congruence se transporte directement : un contexte d'évaluation se traduit en un
contexte de séquentialisation, et $`\to^{+}` y est stable.

Reste la trace, qui est le point délicat. La composition parallèle du métalangage est commutative, et
ne distingue pas deux événements que la source ordonne. Deux émissions $`\overline{t}\langle\rangle`
sur un même canal de temps ne seraient donc pas ordonnées par la seule coupure du `let`. L'énoncé
n'est vrai que si la traduction _enfile_ le canal de temps : chaque événement consomme le canal reçu et
rend le canal suivant, de sorte que le préfixage de la séquence impose l'ordre. C'est une exigence sur
la traduction, non une conséquence de la préservation du typage ; avec elle, les cas
$`\mathbf{tick}` et $`\mathsf{operation}_\varepsilon` sont chacun un pas de communication qui étend
la trace d'un événement. Sans elle, le contre-exemple $`\mathsf{let}\;x \leftarrow \mathbf{tick}\;\mathsf{in}\;\mathbf{tick}`
est une trace à deux événements non ordonnés. L'opération à portée se traduit en un contexte, et se
traite comme un `let`. Non démontrée : les clauses de traduction pour les opérations et pour $`\mathbf{tick}`
ne sont données qu'en prose, et la proposition est l'hypothèse Sim du théorème
{num "thm:fidelite_interprete"}[], et elle en est aussi la dette.
:::

::::
::::theorem (label := "thm:fidelite_interprete") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "translation")
:::title
fidélité de l'interpréteur de référence
:::

:::statement +titled
Une réduction, et son périmètre exact

Supposons la traduction $`\llbracket \cdot \rrbracket` préservant le typage
(théorème {num "thm:traduction_metalangage"}[]) et l'interprétation du métalangage adéquate
vis-à-vis de son équivalence observationnelle, et _sous l'hypothèse Sim_ d'un théorème de simulation reliant la relation $`\to` du §{num "sec:g-semantique"}[] à la réduction du métalangage : $`\langle c \mid \mu \mid \tau \rangle \to \langle c' \mid \mu' \mid \tau' \rangle` entraîne $`\llbracket c \rrbracket \to^{+} \llbracket c' \rrbracket` modulo $`\equiv`, la trace s'étendant en conséquence. Alors tout
est fidèle à la sémantique de K7PL sur la structure de communication, sur le contrôle _et sur les
effets_. Il ne l'est pas sur les grades ni sur les raffinements, que la traduction oublie par
construction.
:::

:::proofsketch
La préservation du typage ne suffit pas à elle seule : un terme bien typé peut avoir plusieurs images bien typées de comportements distincts, et la composition parallèle du métalangage, commutative, ne distingue pas deux traces $`\tau_1 \cdot \tau_2` et $`\tau_2 \cdot \tau_1` que la source ordonne. C'est pourquoi l'énoncé porte Sim : la relation $`\to` du §{num "sec:g-semantique"}[] est _la_ définition de l'exécution, et la fidélité n'est relative à elle que par ce théorème, qui reste à établir (c'est une induction sur la même dérivation que la préservation du typage). Sim n'est pas prouvée ici : l'énoncé est conditionnel, et l'engagement « fidélité de l'interpréteur » reste ouvert tant qu'elle ne l'est pas.

La fidélité se factorise, et c'est tout l'argument. Elle est une instance du schéma d'effacement
(chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:schema_effacement"}[]) : la traduction étant définie par récurrence et
hygiénique, elle induit un morphisme de systèmes de raffinement, et il n'y a donc pas une propriété
à établir construction par construction mais trois conditions à vérifier sur une transformation. Un
interpréteur de référence n'interprète pas K7PL : il interprète le métalangage. Le chemin d'un
programme à son observation passe donc par $`\llbracket \cdot \rrbracket` puis par l'interprétation
du métalangage. Si la première préserve le typage, un programme bien typé donne un terme bien typé ;
si la seconde est adéquate, le comportement observable de ce terme s'accorde à sa dénotation. La
composée l'est donc aussi, et aucune construction de K7PL n'a besoin d'être traitée séparément.

Le périmètre demande deux précisions, dont la première corrige ce que ce document a longtemps écrit.
Les _effets_ sont couverts : depuis que la composante $`\mathcal{E}` reçoit une image – un effet
devenant une émission sur le canal distingué de sa sorte, et $`\mathbf{tick}` une émission sur celui
du temps –, ce qui échappait au métalangage ne lui échappe plus. La réserve ancienne, qui bornait la
fidélité à la communication et au contrôle, est levée par cette extension et non par le présent
énoncé.

Ce qui reste hors du périmètre y reste _par construction_ et non par défaut : la traduction
n'emporte ni les grades ni les raffinements, et c'est cet oubli qui fait d'elle un système de
raffinement plutôt qu'une simple traduction. Un interpréteur fidèle ne dira donc rien de ce qu'une
discipline de ressource garantit – il n'a pas à le dire, ces garanties étant établies avant
l'exécution et effacées à la Phase 8.
:::

::::
La dette qu'il reste à acquitter n'est donc plus « prouver l'interpréteur correct » mais « établir
que $`\llbracket \cdot \rrbracket` préserve le typage », ce que le théorème {num "thm:traduction_metalangage"}[]
énonce, dont l'induction est planifiée et non conduite.

Une réserve doit fermer cette section, car la lecture a un coût que sa commodité pourrait masquer.
La composante $`\mathcal{E}` n'a pas d'image dans le métalangage : ce qui s'y raisonne est la
structure de communication et de contrôle, non les effets — ni, par conséquent, le temps, que le
chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) y a logé sous la forme d'une opération
$`\mathbf{tick}`. Un interpréteur prouvé fidèle au métalangage ne serait donc prouvé fidèle qu'à
cette part-là, et les garanties de la Phase 3 comme celles de la Phase 7 resteraient à établir
ailleurs. Il faut se garder d'en tirer que les effets échapperaient à tout traitement structurel :
ils sont gradués comme le contexte l'est, et la correction conjointe des deux gradations est un
résultat établi sur ce régime d'évaluation {cite "torczonEffectsCoeffectsCallbypushvalue2024"}[]. Ce
qui échappe au métalangage échappe au métalangage, non au système de types.

Cette réserve n'a pas à être définitive, et ce document choisit de ne pas s'y tenir. Un effet peut
se traduire dans un calcul de processus, et par un procédé classique : une opération à effet devient
une communication sur un canal _distingué_, réservé à cet effet et non accessible au programme
traduit. Émettre sur le canal du temps est ce que $`\mathbf{tick}` devient ; un gestionnaire d'effet
devient un processus qui offre une session sur ce canal. Le métalangage porte alors $`\mathcal{E}`
comme il porte déjà $`\Delta`, la traduction devient totale sur les trois composantes, et la
fidélité d'un interpréteur cesse d'être partielle.

Deux conséquences accompagnent ce choix, et la seconde est un coût. La première est que la
non-interférence temporelle devient énonçable _dans_ le métalangage : dire qu'une durée ne dépend
pas d'un secret revient à dire que les communications sur le canal du temps sont indiscernables, ce
qui est une propriété du calcul et non une propriété à établir en dehors de lui. La seconde est que
le métalangage grossit — il faut une discipline pour les canaux distingués, qui garantisse qu'aucun
programme traduit n'y accède directement. Cette discipline n'a pas à être inventée : le calcul cible
emploie déjà un système de _sortes_ sur les canaux, dont le traitement des motifs de jonction est le
premier usage, et où l'on ne considère que les processus bien sortés {cite "fournetReflexiveCHAMJoincalculus1996"}[].
Il suffit d'y réserver une sorte aux canaux d'effet et d'exiger qu'aucun terme issu de la traduction
ne la mentionne. La charge se ramène donc à un cas de l'induction plutôt qu'elle ne s'y ajoute :
établir que la traduction produit des termes bien sortés. Le chapitre 6
(§{num "sec:c6-strategies-de-verification-et"}[]) mesure ce que ce choix change pour la dette de
fidélité.

{bibliography}
