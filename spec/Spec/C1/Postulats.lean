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

#doc (Manual) "Postulats" =>
%%%
file := "c1-postulats"
tag := "c1-postulats"
%%%

{label "sec:c1-postulats"}

Le verrou n'est pas le choix entre performance, sûreté et vérification : c'est l'absence d'échelle.
Chacun des trois pôles a ses langages et chacun paie ailleurs ce qu'il obtient. Confier au
développeur la mémoire et la concurrence achète la vitesse contre des fuites et des courses
qu'aucune analyse du langage ne prévient. La discipline de propriété et d'emprunt achète la sûreté
contre de l'expressivité et de l'apprentissage ; sa synthèse formelle a été conduite sur Cyclone,
C++11, Rust et les types linéaires de Linear Lisp, Clean et Alms {cite "munch-maccagnoniResourcePolymorphism2018"}[].
Les systèmes de modes qui l'assouplissent, en séparant affinité, unicité et localité, montrent que
ce coût est réductible mais non nul {cite "lorenzenOxidizingOCamlModal2024"}[]. La dépendance
complète, enfin, prouve des propriétés arbitraires contre une charge d'annotation que ses propres
auteurs situent. Combiner suivi d'usage et dépendance impose la discipline du contexte annulé {cite "atkeySyntaxSemanticsQuantitative2018"}[],
et les systèmes gradués dépendants portent un vecteur de grades de contexte à côté de celui du sujet {cite "moonGradedModalDependent2021"}[].
Aucun ne gradue.

K7PL répond par quatre postulats immuables, qui définissent le périmètre du langage ; toute
construction qui les enfreindrait en serait par définition exclue. Ils ne sont pas dérivés d'un
principe plus général : ils sont posés, et l'on aurait pu en poser d'autres. La confidentialité en
est le cas le plus net : il montre à quelle condition un postulat absent se rattrape sans en ajouter
un. Elle et l'effacement relèvent d'une même analyse de dépendance, sous un treillis générique de
niveaux {cite "choudhuryDependentDependencyCalculus2022"}[], {cite "liuConsistencyDependentCalculus2025"}[].
Le chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]) établit que graduer une liaison sur
une structure ordonnée est un procédé unique, dont la monotonie et la confidentialité sont deux
instances. Celle-ci n'ajoute donc rien à l'appareil : elle emploie ce qui est déjà là, c'est la
forme que la clôture énoncée ci-après réclame d'une extension.

: P1

  Fonctorialité : tout programme K7PL est un morphisme dans une catégorie ambiante _C_, symétrique
  monoïdale fermée (SMCC). Ses objets sont les types ; son produit tensoriel $`\otimes` modélise la
  coexistence de ressources disjointes ; sa fermeture interne $`[A \multimap B]` représente l'espace
  des morphismes de $`A` vers $`B` comme un objet de _C_ elle-même. La composition des programmes
  n'est jamais que l'assemblage des flèches de _C_, et tout effet observable est une transformation
  naturelle entre foncteurs. Il en résulte une conséquence opérationnelle immédiate : toute
  optimisation admise du compilateur est accompagnée d'un _morphisme de correction sémantique_ dans
  _C_, qui dit en quel sens le programme transformé vaut l'original. Lorsque ce morphisme est un
  isomorphisme naturel — c'est le cas de la fusion de boucles et de l'_inlining_ —, la transparence
  est immédiate, l'optimisation ne faisant que remplacer une flèche par une flèche égale. Lorsqu'il
  ne l'est pas — la défonctionnalisation, qui préserve le sens sans être inversible —, la
  transparence tient encore, mais du morphisme et non de l'inversibilité. Confondre les deux ferait
  dépendre la correction du compilateur d'une propriété que la plupart de ses passes n'ont pas. La
  structure fine de _C_, en particulier la comonade exponentielle $`!` dont dérivent les trois
  fragments d'usage du langage, est construite au chapitre 2 (Fondements catégoriques). À ce stade,
  P1 se scinde en deux, et la scission est ce qui le rend honnête. _P1a_ est le postulat : _C_ est
  une SMCC, les types en sont les objets, le tenseur dénote la disjonction de ressources — c'est
  ce que le chapitre 2 construit, et cela n'affirme que l'ambiance catégorique dans laquelle tout le
  reste de K7PL s'interprète. _P1b_ est une obligation, nommée comme telle : il existe une
  interprétation $`\llbracket - \rrbracket_{\mathcal{C}}` des dérivations vers les morphismes de
  _C_, correcte pour la réduction. Elle n'est pas établie ; le seul foncteur que le document
  construit est celui vers le métalangage (chapitre 4). Aucun argument de correction ne repose donc
  sur P1 seul : monomorphisation, abaissement et optimisations s'appuient chacun sur un argument
  syntaxique (substitution, inversibilité des règles) ou sur le modèle mémoire, et la sûreté
  mémoire se tire de l'absence de dérivation (chapitre 4), non de la structure de _C_.

: P2

  Orthogonalité usage/valeur : la modalité d'usage d'une ressource — non restreinte (`Unr`), affine
  (`Aff`) ou linéaire (`Lin`) — est indépendante de sa contrainte de valeur : type dépendant,
  intervalle numérique, paramètre fantôme, protocole de session, dimension physique. Les deux
  familles de prédicats se combinent par un produit cartésien et non par un jeu de règles ad hoc,
  sous une unique condition de séparation. Les variables qui n'interviennent que dans la formation
  d'une contrainte de valeur — indices de taille, paramètres fantômes, bornes — sont exclues du
  suivi de ressource et portent un grade nul.

  L'orthogonalité est une orthogonalité _au niveau du jugement_, non une indépendance absolue des
  deux axes, et elle se qualifie en trois couplages nommés, qui sont des interfaces contrôlées entre
  eux, chacune justifiée séparément. Les destinations indexent la modalité linéaire par un paramètre
  d'âge $`k` (`Lin_k`) : l'indice est clos à la compilation et se lit comme la même mesure
  décroissante que l'introduction unique. L'élimination d'un existentiel interdit la projection
  implicite quand le témoin porte un grade effaçable : le typage de la valeur y dépend du grade du
  contexte, par la condition de bord de {sc}[Open]. Le point fixe déductif exige que son type soit un
  domaine ordonné à hauteur finie : la règle inspecte la structure du type de valeur pour autoriser
  l'effet.

  Cette condition n'est pas une restriction ajoutée après coup. Elle distingue les types dépendants
  pragmatiques du chapitre 3 (§{num "sec:c3-les-contraintes-de-valeur"}[]) de la dépendance
  complète, pour laquelle la littérature établit qu'un tel produit libre n'est pas disponible. La
  frontière porte sur le _moment_ et non sur le degré, et il faut l'écrire ainsi pour ne pas se voir
  prêter une limite qu'on n'a pas : un indice _clos à la compilation_ est admis, un indice
  _dépendant d'une valeur d'exécution_ ne l'est pas. K7PL a donc bien des effets indexés, sous leur
  forme statique, et la réserve ne porte que sur le second cas {cite "atkeySyntaxSemanticsQuantitative2018"}[], {cite "moonGradedModalDependent2021"}[].

  Elle vaut dans les deux sens. Un grade peut dépendre d'une valeur, pourvu que cette valeur soit
  close à la compilation : le chapitre 3 (§{num "sec:c3-le-systeme-gradue"}[]) en fait un usage
  constant, avec les grades fractionnaires $`1/N` et le paramètre d'âge `Lin_k`, et le chapitre 4
  (§{num "sec:c4-echelle-de-l-acteur"}[]) avec les segments d'arène `Range(0,k)`. {rmq}[La condition
  de clôture appartient à ce postulat et n'est empruntée à aucun autre.] C'est la clôture qui rend
  le produit libre : une valeur close ne peut pas faire dépendre un grade d'un calcul que le
  vérificateur ne saurait conduire. La dépendance n'est donc pas absente de K7PL, elle y est
  statique. Le cas où la multiplicité d'une variable dépend d'une valeur calculée à l'exécution —
  indispensable dès que le branchement ou la récursion organisent des ressources plutôt qu'ils ne
  les représentent {cite "doreDependentMultiplicitiesDependent2025"}[] — reste hors du périmètre du
  langage.

  L'ordre de précision $`\text{Unr}\,T \sqsubseteq \text{Aff}\,T \sqsubseteq \text{Lin}\,T` des
  modalités d'usage découle de cette structure pour tout type $`T`, et n'est pas une règle
  ajoutée : une ressource utilisable exactement une fois s'affaiblit en ressource abandonnable,
  elle-même utilisable sans restriction, et chaque affaiblissement est une perte de précision. Cet
  ordre n'est pas le sous-typage $`\preccurlyeq` : sur l'usage, celui-ci descend (une ressource
  librement copiable se coerce en ressource à usage unique, $`!\omega\,A <: {!}1\,A`), tandis que
  les autres composantes montent ; il est défini comme produit mixte, composante par composante, dans la table {num "tab:produit-mixte"}[] (§{num "sec:g-regles"}[]), dont la direction par composante — usage et monotonie descendent, niveau et budget montent — est ce qui fait l'inversion sur l'usage. Le chapitre 3 en tire le système de types complet. L'orthogonalité s'étend enfin à toute paire de dimensions du
  langage — types, termes, contextes, effets, grades — par une relation de précision $`\sqsubseteq`,
  dont la construction comme enrichissement catégorique de _C_ sur un treillis distributif borné est
  différée au chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]).

: P3

  Autonomie physique : aucune abstraction de K7PL ne dissimule un coût, ni de mémoire ni de temps.
  Sur le temps, le postulat borne _les deux_ composantes que le facteur temporel porte — le travail,
  qui est le nombre total de pas, et la profondeur, qui est la longueur du plus long chemin de
  dépendances. Borner le seul travail laisserait la latence libre ; borner la seule profondeur
  laisserait la consommation libre, et le budget cesserait d'être une provision. Deux précisions
  accompagnent ce postulat, et toutes deux restreignent ce qu'il promet. _Le budget est une borne
  supérieure, et l'écart à ce que le calcul consomme effectivement n'est pas borné_ en présence
  d'opérations à portée qui coupent leur bloc : une annotation dit ce que le calcul ne dépassera
  pas, non ce qu'il coûtera. Et le postulat gouverne séparément _la borne mémoire au pire cas_ et
  _la borne temporelle_, qui peut être amortie sans que la première cesse d'être au pire cas — ce
  sont deux grandeurs, et exiger d'elles le même régime serait une sévérité sans objet. {rmq}[Deux
  nombres, deux questions distinctes : combien cela coûte, et combien de temps cela prend. Un seul
  n'aurait pas répondu aux deux.] Sur la mémoire, il se lit comme suit. Pile, tas et arènes sont des
  régimes explicites, choisis par des grades de ressource — au sens de _Granule_ {cite "orchardQuantitativeProgramReasoning2019"}[]
  — plutôt que délégués à un mécanisme implicite. L'allocation en $`O(1)` est la norme attendue de
  toute structure ; toute allocation dynamique dont la taille n'est pas bornée statiquement est un
  rejet à la compilation, non une latence tolérée à l'exécution. Le système de types a ainsi pour
  obligation de statifier — c'est-à-dire de rendre calculable à la compilation la taille de — chaque
  structure qu'il admet. Cette exigence se répercute selon la couche : sur la géométrie des arènes
  et le dimensionnement des acteurs (chapitre 4), sur la borne des grades (chapitre 3), sur la
  vérification de complexité par le solveur (chapitre 6).

  Une conséquence porte sur la bibliothèque. Une borne _amortie_ dissimule un coût dans la
  distribution : une opération peut coûter cher pourvu que la moyenne tienne. Une borne _pire cas_
  ne dissimule rien. P3 interdisant de dissimuler un coût, le critère d'admission d'une structure à
  la bibliothèque est la borne pire cas, et non l'allocation en temps constant qu'on énoncerait
  spontanément. Le critère est plus fin, il est décidable structure par structure, et il exclut une
  part notable des structures purement fonctionnelles usuelles — dont plusieurs des plus élégantes,
  dont les bonnes bornes sont amorties. Il n'oblige pas pour autant à renoncer : pour la file de
  priorité, l'optimum pire cas est atteint _purement fonctionnellement_ {cite "brodalOptimalPurelyFunctional1996"}[].
  Le chapitre 4 (§{num "sec:c4-echelle-locale"}[]) hérite de ce critère pour ses arènes.

  La forme du postulat n'est pas neuve : c'est le critère que Hoare énonçait pour les _erreurs_ —
  aucun effet dépendant de la machine, inexplicable dans les termes du langage lui-même — transposé
  au _coût_ {cite "appelCritiqueStandardML1993"}[]. Ce que P3 ajoute est le déplacement d'objet, non
  le principe : un langage peut être sûr et coûteux de manière imprévisible, et la seconde faute n'a
  longtemps pas eu de nom.

: P4

  Déterminisme distribué : toute exécution distribuée de K7PL est rejouable, et _le rejeu est gradué
  par la couche_ plutôt qu'uniforme. En couche 3, il est déterministe *par construction* : le
  fragment est cartésien et sans effet, deux branches parallèles n'ont aucun endroit où interférer.
  En couche 2, il est déterministe *modulo le journal* : l'entrelacement des acteurs est journalisé,
  et c'est le journal qui le restitue. En couche 1, il l'est *modulo le journal et celui des
  défaillances*, une machine pouvant tomber sans qu'aucun type ne l'en empêche. {rmq}[Trois régimes,
  un par couche, et c'est la thèse de sédimentation appliquée à une garantie plutôt qu'à un
  fragment. Le postulat cesse de promettre uniformément ce qu'il tient diversement.] Ce n'est pas
  une complication subie : c'est la thèse architecturale de ce document, appliquée à une garantie.
  Chaque régime est en outre _logique_ par construction — il rend le même état à l'observation près
  —, et _binaire_ sous la seule hypothèse d'un environnement reproductible, que ce document nomme
  sans la fixer et dont la couche 1 ajoute une composante réseau. Les sources de non-déterminisme —
  horloge, générateur aléatoire, latence réseau — ne sont jamais des propriétés intrinsèques du
  langage : ce sont des ressources injectées dans le contexte d'exécution, puis journalisées. Le
  journal, au format Cap'n Proto, est l'unique source de vérité pour toute reconstruction d'état.

  Deux degrés de rejeu se distinguent, faute de quoi l'énoncé promet plus qu'il ne tient. Le rejeu
  _logique_ — même journal, même suite d'états observables — est ce que P4 garantit : il ne dépend
  que de la journalisation des sources de non-déterminisme, et le système de types suffit à
  l'établir. Le rejeu _bit à bit_ suppose en outre un ordonnancement, un mode d'arrondi flottant et
  une version de compilateur identiques, qu'aucune clause de ce document ne fixe et que le journal
  ne consigne pas. P4 énonce donc le premier ; le second est une propriété de déploiement, obtenue
  lorsque l'environnement d'exécution est lui-même reproductible.

  Une quatrième source aurait pu figurer dans cette liste, et son absence demande une justification :
  le déclenchement des _motifs de jonction_, qui admet en général un choix non déterministe. Elle
  n'est pas journalisée mais _supprimée_, en exigeant des motifs qu'ils soient deux à deux disjoints
  en plus d'être exhaustifs — ce qui en fait une partition, donc un choix forcé, donc pas un choix.
  Le chapitre 4 (§{num "sec:c4-le-calcul-de-processus"}[]) en donne la règle et le prix, qui est
  nul. Une source retirée par construction vaut mieux qu'une source consignée : la seconde alourdit
  le journal, la première n'existe pas.

Ce journal appelle une remarque que la confidentialité rend nécessaire, et qui pourrait passer pour
une contradiction. P4 exige qu'il consigne tout ce dont dépend le rejeu, quand un régime de niveaux
exigerait qu'il ne livre rien au-dessus du niveau de son lecteur. Depuis que le modèle mémoire a
pour portée une machine, c'est en outre le seul véhicule d'information entre machines. Les deux
exigences portent donc sur le même objet. Il ne s'agit pourtant pas d'une contradiction mais d'une
situation constituée : de nombreux systèmes ont non pas la _permission_ de divulguer mais
l'_obligation_ de le faire, et cette obligation appartient à leurs exigences de sécurité au même
titre que les interdictions {cite "chongRequiredInformationRelease2010"}[]. La journalisation de P4
en est un cas exemplaire — sans journal, pas de rejeu, donc pas de P4.

La notion qui articule les deux est la _divulgation bornée_, laquelle fournit une borne inférieure
et une borne supérieure sur ce qu'un programme divulgue, et dont il est établi qu'un système de
types de sécurité les impose l'une comme l'autre {cite "chongRequiredInformationRelease2010"}[]. Le
manuscrit ne possède aujourd'hui que des bornes supérieures ; ce qu'il lui manque est d'écrire la
borne inférieure que P4 réclame. Les trois mises en œuvre concevables — journal stratifié par
niveau, journal chiffré par niveau, rejeu dégradé au-dessus du niveau de l'observateur — deviennent
alors des réalisations d'une même spécification, à départager sur le coût plutôt que sur la
cohérence. Cette spécification n'est d'ailleurs pas à inventer : la divulgation _requise_ a reçu ses
conditions de sécurité sémantiques et son mécanisme d'application dans un cadre langagier, les
techniques de contrôle de flot ordinaires ne sachant raisonner que sur les flux permis {cite "chongRequiredInformationRelease2010"}[].
Ce qui manque est de l'écrire, non de la trouver.

Reste à dire quel _statut_ donner aux échappatoires que cette borne inférieure exige. Elles sont
traitées ici comme des exceptions à la garantie de confidentialité, ce qui laisse ouverte la
question de savoir si leur ensemble est clos — question qu'une liste ne peut pas trancher. Le
procédé retenu par la déclassification sémantique relâchée est meilleur : il n'assouplit pas la
modalité de classification, il en _ajoute une seconde_, dédiée {cite "rajaniGradedModalRelaxed2025"}[].
Transposé ici, cela signifie que la composante de niveau du grade est la modalité de classification,
et que les échappatoires nommées relèvent d'une modalité distincte plutôt que d'une exception à la
première. Le bénéfice est direct : l'ensemble des échappatoires devient énonçable comme un _type_ et
non comme une liste, et la question de sa clôture cesse d'être ouverte pour devenir une propriété de
ce type.

La borne inférieure qui manque s'énonce d'ailleurs simplement, et son énoncé désigne du même coup la
réalisation la plus naturelle. Pour chaque niveau $`\ell`, la projection du journal sur ce niveau
doit suffire à rejouer le comportement que l'observateur de niveau $`\ell` observe. Cette
formulation porte les deux bornes d'un seul tenant. Elle est une borne inférieure, puisqu'elle exige
que le journal contienne assez pour ce rejeu-là ; et une borne supérieure, puisqu'un observateur qui
ne dispose que de la projection ne peut rien apprendre au-dessus de $`\ell`. P4 devient ainsi une
famille d'exigences indexée par les niveaux, comme la non-interférence en est une (chapitre 2,
§{num "sec:c2-le-systeme-de-raffinement"}[]), et le rejeu intégral en est le cas où l'observateur
atteint le niveau le plus haut. La réalisation qu'elle appelle est le journal stratifié — non parce
qu'il serait le moins coûteux, mais parce qu'il est celui dont la structure est déjà celle de la
spécification. Rejouer un acteur revient ainsi à substituer, dans l'ordre, les valeurs journalisées
aux appels non déterministes d'origine — mécanisme détaillé au chapitre 4, dont l'isomorphisme
mémoire avec le format de journalisation est assuré à la compilation (chapitre 6).

Un mot sur la portée de P3, car un audit l'a éprouvée et en a déplacé la frontière plutôt que le
contenu. Le postulat parle de l'_exécution_ : il exige qu'aucune abstraction ne dissimule un coût à
l'exécution, et il rejette à la compilation ce qui n'y serait pas borné. Il ne gouverne donc pas le
coût de la compilation elle-même. Cette lecture n'est pas une restriction ajoutée après coup : elle
est dans la formulation même, « un rejet à la compilation, non une latence tolérée à l'exécution ».
Elle n'avait jamais été tirée, de sorte que le solveur et la synthèse dirigée par les types
figuraient parmi les régions à auditer alors qu'ils n'y appartiennent pas. Ce qu'un compilateur met
à décider ne relève pas de P3 ; ce qui n'en relève pas davantage d'aucune autre exigence, et c'est
une lacune, nommée ici plutôt que comblée à la hâte.

Une réserve de position, enfin, vaut du document entier, et sa place est ici plutôt qu'en
conclusion. Trois questions se posent à toute proposition de langage, et elles ne se confondent pas :
est-elle _démontrable_, est-elle _implantable_, est-elle _utile_. Le manuscrit traite la première et
l'aborde seule ; la deuxième a son échéance au chapitre 6, qui décrit un pipeline sans l'avoir
construit ; la troisième n'a pas d'échéance ici et n'en aura pas avant qu'un corps de programmes
existe. La critique la plus utile qu'un langage ait reçue est celle qui distingue ces trois plans et
refuse qu'un résultat sur l'un vaille argument sur les autres {cite "appelCritiqueStandardML1993"}[].
Un lecteur est donc fondé à trouver ce qui suit démontré et à le tenir néanmoins pour non acquis, et
ce n'est pas une contradiction : c'est la portée exacte de ce qui est offert.

À l'exécution, trois régions demeurent, que voici. La _transposition de disposition_ entre couches,
qui vaut aussi pour le gel d'un acteur dont l'état porte une liste de structures, est en $`O(n)` et
le restera : transposer exige de toucher chaque élément, et c'est la complexité du problème et non
celle d'une réalisation. Elle est néanmoins _bornée_, la longueur étant celle d'une arène
dimensionnée à la compilation, de sorte que l'effet $`\mathbf{tick}` qu'elle engendre est
statiquement borné — ce qui est le critère, la lettre du $`O(1)` ne l'étant pas. La _perte de borne
sous la modalité d'éventualité_ est le second cas, et il est conforme plutôt que fautif. Attendre un
événement dont la date n'est pas connue n'a pas de borne, le type le dit, et un programme qui
traverse cette modalité n'a plus de WCET de façon visible. C'est le seul endroit où K7PL accepte
l'imprévisible, et il l'accepte en le marquant.

Reste l'amortissement, et il demande d'être situé avant d'être jugé. Un seul des sept niveaux de la
hiérarchie mémoire porte un coût amorti plutôt qu'en pire cas : le tas à propriété, et il appartient
à la couche 2. La couche 1 n'en dispose pas. Ce qu'elle emploie — déduplication canonique, arènes
linéaires contiguës, mémoire linéaire pour l'interfaçage physique — est en $`O(1)` au pire cas.
C'est la conséquence de ce qu'elle fait : décrire des dispositions au bit près pour des protocoles,
des pilotes et du calcul de bas niveau ne laisse pas de place à une réallocation. L'échéance stricte
et le mécanisme amorti ne se rencontrent donc jamais.

Ce qui reste est plus étroit et de nature différente. Une opération amortie est correcte tant que la
borne que les règles synthétisent est celle de son _pire cas_ et non celle de son coût moyen. Si
l'annotation d'effet portait l'amorti, la borne synthétisée serait franchie par un pic, et la
propriété de préservation — le coût effectif reste sous la borne — deviendrait fausse. Ce n'est donc
pas une question de couche mais une _condition sur le modèle de coût_, et elle vaut partout où une
structure amortie est annotée. Elle est posée comme telle et s'instruit — la conséquence pour la
bibliothèque étant plus tranchante que la condition elle-même. Le postulat d'autonomie physique
départage donc les structures de données non par leur complexité annoncée mais par la nature de la
borne, et la littérature des structures purement fonctionnelles distingue précisément les deux
familles {cite "okasakiPurelyFunctionalData"}[]. La bibliothèque standard retiendra donc les
structures à bornes pire cas et écartera celles dont les bornes ne sont qu'amorties — non parce que
les secondes seraient mauvaises. Mais parce qu'annoncer la moyenne quand l'appelant a besoin du
maximum est ce que P3 interdit.

Conséquence — la logique de séparation comme ciment. Le produit tensoriel de _C_ n'est pas seulement
une opération de typage : il porte une lecture spatiale immédiate. Écrire $`P \otimes Q`, c'est
affirmer que les ressources attestées par $`P` et par $`Q` occupent des régions mémoire disjointes —
c'est la logique de séparation. Cette lecture n'est pas ajoutée à P1 : elle en est la traduction
directe dès lors que $`\otimes` est interprété comme composition de ressources physiques plutôt que
comme simple produit de types.

Cette disjonction fonde à elle seule deux des quatre postulats précédents. Dans le fragment linéaire
— celui où aucune règle de contraction n'est admise (chapitre 2,
§{num "sec:c2-la-comonade-exponentielle-et"}[]) —, il n'existe aucun morphisme de duplication
$`A \to A \otimes A`, la diagonale catégorique. Aucune valeur ne peut donc apparaître dupliquée dans
un terme sans passer par un mécanisme de partage explicite, les grades fractionnaires du chapitre 3
(§{num "sec:c3-le-systeme-gradue"}[]). Deux références actives ne peuvent en particulier jamais
désigner la même région physique sans que cette coïncidence soit elle-même typée.

C'est l'absence de _data race_ exigée par P4, et la garantie de sûreté mémoire exigée par P3. Ni
l'une ni l'autre n'est une propriété vérifiée après coup sur le langage : toutes deux se déduisent
de deux faits, et non d'un seul — l'absence de diagonale dans _C_, qui interdit de _dupliquer_ une
capacité, et l'unicité de son introduction, qui interdit d'en _créer deux_ pour la même région.

Le théorème qui les porte est établi au chapitre 4 (§{num "sec:c4-modeles-de-memoire"}[]), là où les
fibrilles et les arènes existent. Deux fibrilles exécutées en parallèle sous des contextes disjoints
ne peuvent détenir la même capacité d'écriture, et aucune opération mutante concurrente n'est donc
typable. {rmq}[Le Prolégomène énonce ce que le document devra tenir. Il ne le tient pas lui-même.]
Ce chapitre en retient l'obligation, non la preuve.
