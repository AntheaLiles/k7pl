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

#doc (Manual) "Structures ouvertes, effets et méta-théorie" =>
%%%
file := "c3-structures-ouvertes-effets-et"
tag := "c3-structures-ouvertes-effets-et"
%%%

{label "sec:c3-structures-ouvertes-effets-et"}
{label "sec:c3-purete-des-gestionnaires"}

Une propriété est réclamée par deux chapitres et n'était définie nulle part ; elle a son lieu ici,
où les effets sont traités.

Un _gestionnaire de couche 2 est pur_ lorsque sa fonction de transition est une application
$`(\mathsf{Message} \times \mathsf{Capacit\acute{e}s} \times \mathsf{\acute{E}tat}) \to \mathsf{\acute{E}tat}`
dont l'effet est neutre : toute source de non-déterminisme — horloge, aléa, latence — y entre comme
une capacité reçue en argument plutôt que comme une opération invoquée. {rmq}[La pureté n'est pas
une discipline que le gestionnaire s'imposerait : c'est la forme de son type, et le vérificateur la
refuse autrement.] Ce n'est donc pas une restriction sur ce qu'un acteur peut faire, mais sur
l'endroit où le non-déterminisme entre : au bord, sous forme de valeur journalisable, et non au
cœur.

Deux énoncés en dépendent, et c'est pourquoi la définition est écrite plutôt que supposée. Le
déterminisme du rejeu (chapitre 4) tient de ce que la transition est une fonction, et le cas d'usage
réactif (chapitre 7) de ce que le journal des capacités suffit à la reconstituer.

Une fois la modalité et la contrainte fixées, un type isolé est complet ; mais aucun programme ne
reste isolé. Cette section traite des trois façons dont un type s'ouvre sur autre chose que lui-même :
sur des champs qu'il ne connaît pas encore, sur un type qu'il choisit de ne pas révéler, sur un
monde extérieur qu'il ne peut qu'observer par effet. Elle referme ensuite le chapitre par les
garanties qui font de cet ensemble un système plutôt qu'un empilement.

Un enregistrement s'ouvre par une variable de rangée : ses champs, chacun annoté d'un grade de
présence — `Absent[G]` ou `Present T[G]` —, forment un monoïde sous la concaténation biaisée
`r // s`, d'élément neutre `Absent[]`. Ce grade de présence n'emprunte pas la notation
$`\mathcal{G}` par commodité : c'est le même objet, et la raison en est immédiate. Un champ est
absent ou présent une fois — jamais deux —, de sorte que le grade de présence prend ses valeurs dans
$`\{0,1\} \subset \mathcal{R}`, c'est-à-dire exactement le sous-ensemble dont le chapitre 2
(§{num "sec:c2-la-comonade-exponentielle-et"}[]) fait le fragment _affine_. L'affaiblissement y est
disponible au grade $`0`, la contraction ne s'y instancie pas, la somme sortant de l'ensemble. La
concaténation biaisée `r // s` est alors la restriction à ce fragment de la somme du semi-anneau, et
`Absent[]` son élément neutre $`0`. Un champ optionnel est donc une ressource affine, non une notion
parallèle qui lui ressemblerait.

L'inférence des rangées ne produit que des contraintes résiduelles simples, résolues par union-find.
Lorsqu'une collection hétérogène exige un type commun, c'est le joint $`\sqcup` du treillis de
précision du chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]) qui en calcule la plus
petite généralisation. La forme générale de cet enregistrement est la _paire additive dépendante_
$`(x : A)\,\&\,B`, généralisation de la conjonction additive de la logique linéaire déjà rencontrée
au chapitre 2 (§{num "sec:c2-la-comonade-exponentielle-et"}[]) : elle décrit simultanément la
substructuralité et la dépendance, ce dont K7PL possède les deux ingrédients sans les avoir
jusqu'ici réunis {cite "seflProgrammingDependentAdditive2025"}[]. Un enregistrement à champs gradués
dont le type d'un champ dépend de la valeur d'un autre est cette paire, et rien n'a besoin d'être
ajouté pour l'accueillir.

L'accès à un champ d'un enregistrement ouvert est une lentille : un couple lecture/écriture qui
compose et respecte les lois catégoriques attendues d'un foncteur, ce qui autorise leur fusion à la
compilation sans jamais matérialiser de structure intermédiaire.

Un type s'ouvre différemment lorsqu'il choisit de ne pas révéler l'un de ses paramètres : `∃a. τ`
empaquète une valeur d'un type réel mais dissimulé. L'introduction s'annote au site de définition ;
l'élimination, une simple projection `e.τ`, ne demande aucun `unpack` explicite en surface —
l'élaboration vers un langage noyau muni de `pack~/~unpack` reste interne et préserve à la fois la
solidité du typage et son effacement complet à la compilation. Cette projection implicite est
toutefois refusée lorsque le témoin du paquet porte un grade effaçable : c'est le filtrage sur
paquet effacé que le §{num "sec:c3-les-contraintes-de-valeur"}[] a dû exclure pour préserver la
canonicité {cite "johannDeepInductionInduction2020"}[], et le compilateur exige alors un `unpack`
explicite (`ERR-TYP-011`). Qualifier l'existentielle par une contrainte, `∃a. Q ∧ τ`, permet
d'empaqueter avec la valeur la preuve qu'elle satisfait $`Q` : c'est ainsi qu'un raffinement de coût
ou un effet $`\mathcal{E}` peuvent voyager cachés derrière un type existentiel, sans que leur nature
précise n'ait à être exposée à l'appelant.

Un type s'ouvre enfin sur le monde par les effets algébriques du chapitre 2
(§{num "sec:c2-algebres-coalgebres-et-points"}[]), que cette section précise en deux points.
D'abord, un effet peut être étiqueté : le foncteur $`E` porte, indexée par un grade, une famille de
transformations naturelles distinctes selon l'étiquette — deux lois de composition différentes pour
un même effet `State`, par exemple, selon que l'étiquette distingue un état neuf d'un état ancien.
Ensuite, deux effets se composent sans empiler de monades : si $`E \cong R \circ L` est la
décomposition de $`E` par l'adjonction qui l'engendre — `State s ≅ (s →) ∘ (s ×)` en est l'exemple
canonique —, alors $`E \Join F \cong R \circ F \circ L` insère $`F` dans cette décomposition et en
hérite les transformations de liaison, dès lors qu'est fournie la loi distributive graduée reliant
les deux axes.

Cette décomposition régit la _composition_ de deux familles d'effets ; leur _séquencement_ relève,
lui, du produit non commutatif de la quantale du §{num "sec:c1-axiomatique-germinale"}[], et leur
répétition de l'itération qu'elle induit — trois opérations distinctes qu'il serait fâcheux de
confondre, la première portant sur les théories d'effets, les deux autres sur leurs occurrences.
C'est le même partage que documente le plongement des systèmes d'effets fins dans un langage hôte {cite "orchardEmbeddingEffectSystems2014"}[],
où la gradation de la monade remplace l'empilement parce qu'une monade ordinaire n'offre qu'une vue
binaire, pure ou effectueuse. Gaboardi, Katsumata, Orchard, Breuvart et Uustalu {cite "gaboardiCombiningEffectsCoeffects2016"}[]
établissent que cette loi gouverne l'interaction d'un axe de ressource et d'un axe d'effet, et
qu'elle ne se déduit pas de la seule juxtaposition de leurs gradations.

Le chapitre 6 monomorphise cette composition en code direct, sans indirection. L'import dynamique —
depuis un fichier, une URL, un modèle de langage — est un effet `Import` ordinaire. Le vérificateur
de types suspend son travail, évalue l'expression importée dans un environnement aux effets
contrôlés, puis reprend le typage sur le résultat, dont la provenance est journalisée (P4) pour
rester rejouable.

Cette ouverture appelle une réserve, et elle porte sur une notion que ce document emploie sans
l'avoir définie : la _frontière de confiance_. Trois situations la franchissent, et le langage les
traite différemment sans que rien ne justifie cet écart. La Phase~0 exécute des macros avant toute
vérification, de sorte que du code d'origine arbitraire s'exécute dans le compilateur. L'effet
`Import` admet une source distante, jusqu'à un modèle de langage. Et une capacité exportée par la
passerelle FFI (chapitre~4, §{num "sec:c4-echelle-du-systeme"}[]) échappe au système de types dès
qu'elle l'a quittée.

Ce sont trois manifestations d'un même manque : trois instances d'_un seul objet_, et non trois cas
à traiter séparément. Le chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]) a posé
l'_intégrité_ comme la duale de la confidentialité. La confidentialité contraint ce qu'une flèche
peut lire et vit du côté du contexte, l'intégrité contraint ce qu'elle peut écrire et vit du côté
des effets. Il y note aussi, sans en tirer la conséquence, que c'est de ce côté-là que se dit ce que
la frontière de confiance laisse indéterminé — une macro exécutée avant vérification, un import dont
l'origine n'est pas attestée produisent des valeurs de _basse intégrité_, et rien ne les distingue
aujourd'hui des autres {cite "marshallGradedModalTypes2023"}[].

La frontière de confiance est donc un objet du jugement, non une notion extérieure à lui : elle est
le niveau d'intégrité, porté du côté de $`\mathcal{E}` comme la confidentialité l'est du côté de
$`\Delta`. Les trois franchissements deviennent trois manières d'abaisser ce niveau, et l'écart qui
n'était pas justifié cesse d'en être un — c'est la même composante, lue à trois endroits. Ce point
importe au-delà de la présentation : tant que la frontière restait hors du jugement, elle
constituait une restriction non exprimée dans celui-ci, c'est-à-dire le seul contre-exemple connu au
principe de complétude graduée du §{num "sec:c3-le-systeme-gradue"}[]. La ranger dans $`\mathcal{E}`
est ce qui rend ce principe énonçable.

Trois dispositifs répondent ensuite à la question opératoire — que faire de ce qui franchit —, et
K7PL les arrête ici. Le premier est le _confinement_ des macros. Une macro s'exécute avec des
capacités, comme tout le reste, et n'a aucune raison d'en détenir plus que le programme qu'elle
produit. La Phase 0 l'exécute donc en bac à sable complet — accès en lecture aux seules définitions
que son site d'appel a en portée, aucune écriture hors de l'arbre qu'elle construit, aucun effet du
monde extérieur. La conséquence est nette et vaut d'être acceptée plutôt que découverte : une macro
ne peut ni lire un fichier, ni interroger le réseau, ni consulter l'horloge. Ce que les systèmes de
macros usuels autorisent, celui-ci l'interdit, et c'est le prix de la vérification avant mise en
production.

Le deuxième est la _signature des paquets_, avec chaîne de confiance. Un paquet porte une signature,
et celle-ci une chaîne remontant à une racine que le projet consommateur déclare : la confiance
cesse d'être attachée à l'origine du code — une adresse, un dépôt — pour l'être à une identité
vérifiable et révocable. L'effet `Import` ne se résout qu'à une source dont la chaîne valide, et un
maillon révoqué invalide tout ce qu'il a signé.

Le troisième est la _compilation reproductible_, et son statut diffère des deux autres : elle est
visée sans être garantie. La viser signifie que rien dans la conception du compilateur n'introduit
délibérément de variabilité — pas d'horodatage dans les artefacts, pas de chemin absolu, pas d'ordre
d'itération dépendant d'une table de hachage. La garantir demanderait de contrôler l'environnement
de compilation entier, ce que ce document ne fait pas ; c'est un objectif déclaré, non une propriété
établie, et la distinction est celle qui sépare partout ailleurs ici un théorème d'une intention. Ce
qui subsiste au-delà de cette frontière doit être dit, puisque c'est la question même : rien. Une
macro s'exécute avec les capacités du compilateur, un import distant ramène du code dont l'origine
n'est pas attestée, une capacité exportée n'obéit plus au système de types. Les garanties que ce
document construit — sûreté spatiale, terminaison, déterminisme — valent _en deçà_ de cette
frontière et ne prétendent rien au-delà. Un langage qui revendique la vérification avant mise en
production doit la tracer ; celui-ci la franchit trois fois, la nomme désormais, et n'y oppose
encore aucun dispositif.

Lorsque la source est un modèle de langage, la discipline retenue veut que seule la forme des types
franchisse la frontière, jamais les valeurs. Il importe de ne pas confondre cette discipline avec
une garantie : c'est une convention d'interface, que le système de types ne démontre pas.
L'orthogonalité de P2 sépare deux axes de typage, elle n'établit aucune non-interférence — empêcher
l'information de remonter d'un niveau sensible vers un résultat observable suppose un suivi de
dépendance paramétré par un treillis de niveaux, avec assignation d'un niveau au résultat de chaque
calcul {cite "choudhuryDependentDependencyCalculus2022"}[], {cite "liuConsistencyDependentCalculus2025"}[].
K7PL ne possède pas ce mécanisme, et le §{num "sec:c1-postulats"}[] explique pourquoi il le range
hors de ses postulats.

Cette ouverture a une contrepartie diagnostique. Un trou, noté `_`, est le terme le moins précis
possible pour un type donné — le point le plus bas, sur ce type, du treillis $`\sqsubseteq` du
chapitre 2 — et le compilateur y répond par narrowing en proposant les termes qui le raffinent
jusqu'à devenir acceptables. Cette réponse n'est pas une lecture supplémentaire du système de types :
c'est une synthèse dirigée par les types et les grades, donc une recherche de preuve, avec espace de
recherche et possibilité d'échec. L'exploitation des grades y réduit effectivement l'exploration par
rapport à une synthèse purement dirigée par les types, ce qui justifie le dispositif, mais elle ne
la supprime pas {cite "hughesProgramSynthesisGraded2024"}[].

K7PL retient le schéma soustractif de gestion des ressources, dérivé du modèle de contexte
entrée-sortie de la programmation logique linéaire {cite "hughesResourcefulProgramSynthesis2021"}[],
et borne la recherche par un budget qui est lui-même un grade $`r` — conformément à P3. La
complétion d'un trou peut donc échouer par épuisement de budget, au même titre que le test par
propriétés du chapitre 6 peut échouer à trouver un contre-exemple.

Symétriquement, pour toute requête de sous-typage $`\upsilon \sqsubseteq A`, le compilateur peut
extraire du programme la tranche minimale — le sous-ensemble de la dérivation, au sens des
morphismes composés du chapitre 2 — qui suffit à expliquer pourquoi $`A` a été dérivé. Cette même
tranche répond à la question inverse aux frontières de couches : un jugement
`Δ;Γ ⊢ C at d ▷ Δ';Γ'[m]` décompose un contexte en un trou et son environnement, formalisant ce
qu'une couche laisse à une autre le soin de compléter.

Ce que ce chapitre a construit ne mérite le nom de système de types qu'à condition de satisfaire
quatre garanties, et c'est par elles qu'il se referme. La première paraît plus modeste que ne le
voudrait la tradition de Damas et Milner, et ne l'est pas : _la vérification est bidirectionnelle_,
non principale. Ce n'est pas un renoncement mais une _forme_ — celle sous laquelle un système à
tailles s'implante, adoptée par les travaux qui en font la métathéorie sans jamais la présenter
comme une réserve {cite "abelWellfoundedRecursionCopatterns2016"}[]. L'inférence principale et la
vérification bidirectionnelle ne sont pas deux degrés d'ambition sur la même échelle~: la seconde
est ce qu'on écrit quand le type porte des indices que le premier ne saurait pas synthétiser.

Toute définition de plus haut niveau porte une signature ; à partir d'elle, le compilateur vérifie
les formes d'introduction et synthétise les formes d'élimination. K7PL n'infère pas les grades d'une
définition non annotée et ne produit pas de type le plus général, parce qu'aucun système gradué
comparable ne le fait. Granule exige la même signature et range inférence et types principaux parmi
ses travaux futurs {cite "orchardQuantitativeProgramReasoning2019"}[] ; la théorie graduée
dépendante de Moon, Eades III et Orchard procède de même {cite "moonGradedModalDependent2021"}[]. Et
le typage des types linéaires indexés se réduit à une théorie du premier ordre indécidable,
traitable seulement en pratique {cite "deamorimReallyNaturalLinear2014"}[]. La terminaison de la
vérification, elle, reste garantie par un graphe de dépendance acyclique entre variables de type,
grades, dimensions et variables de rangée — une instance de plus de la terminaison structurelle du
chapitre 2.

La deuxième garantie est la stabilité par substitution, et le semi-anneau du
§{num "sec:c2-la-comonade-exponentielle-et"}[] la rend démontrable au lieu de la laisser postulée.
Substituer `let x = e1 in e2` par `e2[e1/x]` préserve le typage _parce que_ le grade $`r` porté par
`x` met le contexte de `e1` à l'échelle par $`r`, la mise à l'échelle étant la multiplication du
semi-anneau. L'ordre dans lequel plusieurs variables existentielles sont quantifiées n'affecte
jamais le résultat.

Ces garanties se paient, et le coût porte sur un seul sujet : l'ergonomie. Six charges le composent.

* Toute définition de plus haut niveau porte une signature, dont les grades par défaut et
  l'inférence locale (§{num "sec:c3-structures-ouvertes-effets-et"}[]) réduisent l'écriture au cas
  non standard.

* Un typestate se vérifie mais ne se filtre plus.

* Un invariant quantifié sur les grades doit se reformuler en contrainte close.

* Le joint du branchement rejette des programmes corrects.

* Les flux de couche 2 portent un indice de taille.

* Les délimiteurs du chapitre 5 ajoutent une marque là où d'autres langages n'en demandent aucune —
  risque de verbosité sur lequel concluent les auteurs qui ont doté des langages de description
  matérielle de types quantitatifs {cite "hughesResourcefulProgramSynthesis2021"}[].

Aucun de ces coûts n'est arbitraire : chacun achète une garantie que les postulats réclament. Mais
leur somme n'a pas été conçue, elle s'est accumulée. Deux d'entre eux ont été réduits depuis
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) ; les autres subsistent, et le total reste le
point faible du chapitre, nommé ici plutôt que passé sous silence.

::::thm (label := "thm:preservation_type")
:::title
préservation du type
:::

:::statement +titled
Stabilité du typage par réduction

Pour tout terme K7PL bien typé $`t : \tau` dont aucun type ne dépend d'une variable soumise au suivi
de ressource — la condition de séparation de P2 —, si $`t` se réduit en $`t'` ($`t \leadsto t'`) —
par évaluation ou par abaissement MLIR —, alors $`t' : \tau` :
$`\Delta \vdash t : \tau \land t \leadsto t' \implies \Delta \vdash t' : \tau`.
:::

:::proofsketch
Par induction structurelle sur la règle de réduction. La $`\beta`-réduction locale préserve le
contexte linéaire, les substitutions consommant et produisant des ressources de façon isomorphe —
argument qui n'est valide que sous la condition de séparation rappelée dans l'énoncé. L'abaissement
MLIR — défonctionnalisation et _inlining_ statique des effets — transforme les fonctions d'ordre
supérieur et les effets en tables de saut statiques, et se formule comme un isomorphisme naturel
dans _C_ au sens de P1.
:::
::::

La condition de séparation n'est pas une commodité d'énoncé. Un système quantitatif qui autorise une
dépendance de type sur une variable d'usage non nul cesse d'admettre la substitution, et l'échec se
produit sur la règle d'application {cite "atkeySyntaxSemanticsQuantitative2018"}[]. Le fragment visé
ici exclut cette configuration par construction ; le cas général relève de la même source et de la
théorie des types dépendants gradués {cite "moonGradedModalDependent2021"}[], et ce document ne le
traite pas.

Le volet abaissement, lui, est revendiqué et non démontré, et il faut le dire ainsi. La préservation
des types à travers l'abaissement d'un langage à la fois quantitatif et dépendant demeure un
problème ouvert, qui a motivé la conception de langages d'assemblage dédiés faute qu'aucun langage
existant n'y convienne {cite "HUANG"}[]. Il n'est pas hors d'atteinte pour autant : l'évaluation
d'un terme linéaire vers les morphismes d'une catégorie monoïdale symétrique, motivée précisément
par les langages dédiés qui s'expriment en diagrammes de boîtes et de fils, dispose d'une
construction {cite "BERNARDY"}[].

Ce théorème et la préservation de l'annexe (§{num "sec:annexe-presentation-formelle"}[], théorème {num "thm:preservation"}[])
ne sont pas deux formulations d'une même chose. {rmq}[Deux emboîtements de sens contraire. L'un est
plus fin, l'autre plus large, et aucun ne contient l'autre.] L'annexe est plus fine, portant les
grades, les effets et la décroissance du potentiel, là où celui-ci ne parle que du type. Celui-ci
est plus large, couvrant l'abaissement que l'annexe ne couvre pas. Pour le volet évaluation, cet
énoncé est donc un corollaire de celui de l'annexe — oublier le grade et l'effet dans la conclusion
graduée donne exactement la stabilité du type. Pour le volet abaissement, l'intersection des deux
laisse un énoncé sans démonstration, la préservation graduée à travers l'abaissement, isolé au
chapitre 6 (§{num "sec:c6-le-processus-de-compilation"}[], théorème {num "thm:abaissement_grades"}[])
plutôt que supposé acquis ici.

Trois préservations circulent donc dans ce document, et les nommer sépare ce qui est acquis de ce
qui ne l'est pas. La _préservation par évaluation_ porte les grades et les effets, et elle est
démontrée à l'annexe (théorème {num "thm:preservation"}[]). La _préservation par abaissement_ porte
les grades à travers la compilation, et elle est énoncée sans être démontrée (théorème {num "thm:abaissement_grades"}[]).
Le présent énoncé est la _préservation du type_, qui couvre les deux mouvements mais oublie le grade
; il est plus large et plus pauvre. {rmq}[Trois noms plutôt qu'un seul mot. Ce qui manque devient
alors lisible : c'est la seconde, et elle seule.] Ce qui manque à ce document est donc exactement la
seconde, et non « la préservation » en général — la nommer évite de croire la dette plus grande ou
plus petite qu'elle n'est.

S'il tient, l'abaissement cesse d'être un endroit où la garantie peut se perdre : ce que le
vérificateur a établi sur le source vaut du code produit. S'il tombe sur son volet MLIR, la garantie
s'arrête à l'entrée du compilateur, et il faut alors la rétablir en aval — par une vérification du
code produit, c'est-à-dire par le mécanisme même que le langage prétend rendre inutile.

Enfin, la substituabilité obéit à une forme généralisée du principe de Liskov : un programme $`g`
peut remplacer un programme $`f` si et seulement si la précondition de $`f` implique celle de $`g`
et la postcondition de $`g` implique celle de $`f` — vérifiable directement pour les types et les
effets, par le solveur SMT pour les contraintes de valeur. C'est cette dernière garantie qui rend
les refactorings prouvés possibles : remplacer un fragment de programme par un autre n'est légitime
que lorsque cette implication tient, et elle seule.

{bibliography}
