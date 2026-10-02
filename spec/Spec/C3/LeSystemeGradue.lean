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

#doc (Manual) "Le système gradué" =>
%%%
file := "c3-le-systeme-gradue"
tag := "c3-le-systeme-gradue"
%%%

{label "sec:c3-le-systeme-gradue"}

Traiter la modalité comme un _grade_ plutôt que comme trois cases disjointes vient de Granule, qui
généralise linéarité et affinité à un système modal gradué par un semi-anneau quelconque {cite "orchardQuantitativeProgramReasoning2019"}[].
K7PL adopte cette gradation en fixant le semi-anneau : $`\mathcal{R}` est celui du
§{num "sec:c2-la-comonade-exponentielle-et"}[], et la restriction porte non sur le porteur mais sur
le _langage de contraintes_ soumis au solveur — sommes, produits et comparaisons, sans
quantification. C'est de là que vient la prévisibilité du temps de compilation, non d'un nombre de
points ; la décidabilité, elle, n'en dépend pas et s'obtient sur un semi-anneau partiellement
ordonné arbitraire, avec normalisation et préservation des grades sous réduction {cite "abelGradedModalDependent2023"}[].
Cette économie ne suffit cependant pas à écarter la difficulté propre à la combinaison des deux
axes. La formation des types doit s'effectuer dans un contexte dont tous les usages sont annulés,
faute de quoi la substitution cesse d'être admissible {cite "atkeySyntaxSemanticsQuantitative2018"}[].
Les théories graduées dépendantes acquittent cette exigence en portant un vecteur de grades de
contexte à côté de celui du sujet {cite "moonGradedModalDependent2021"}[]. Ce que K7PL évite, il ne
l'évite pas par la petitesse de son treillis mais parce que ses types dépendants pragmatiques
n'exposent que des indices exclus du suivi de ressource.

{rmq}[Ce document a employé le même mot pour deux objets distincts. La section s'ouvre donc sur le
vocabulaire plutôt que de le laisser flotter.] Un _grade_ est un élément de l'algèbre, porté par une
_liaison_. C'est le $`r` de $`x :_r V`, et il dit combien de fois et à quelles conditions cette
liaison-ci sera employée. Une _modalité_ est un sous-ensemble distingué de cette algèbre, porté par
un _type_ : c'est le $`\text{Lin}`, $`\text{Aff}` ou $`\text{Unr}` qui dit dans quel fragment un
type vit. Un grade est une valeur, une modalité est un domaine de valeurs — et une liaison porte un
grade qui appartient à la modalité de son type. Les confondre reviendrait à confondre un nombre et
l'ensemble où il vit, ce qui passe inaperçu tant que l'ensemble est unique et cesse de passer dès
qu'il y en a trois.

Le chapitre 2 a établi $`\text{Lin} \subseteq \text{Aff} \subseteq \text{Unr}` comme trois catégories emboîtées
par restriction des règles structurelles. Ce que cette section ajoute, c'est que ces fragments sont
des sous-ensembles distingués d'un même semi-anneau de grades, et que le grade lui-même quantifie
précisément combien de fois, ou quelle fraction d'accès, une ressource peut être exercée.

Ces sous-ensembles sont des _intervalles_, et les écrire ainsi corrige une imprécision que la
notation par singletons entretenait. Une modalité dit ce qu'une ressource _peut_ subir, non ce
qu'elle subit : elle est donc un intervalle $`[m..M]` de $`\mathcal{R}`, sa borne basse disant si
l'abandon est permis et sa borne haute si la duplication l'est. Écrire $`\text{Unr} = \{\omega\}`
ferait croire qu'une ressource non restreinte doit être employée une infinité de fois~; elle peut
aussi n'être pas employée du tout, et c'est la borne basse qui le dit. La table {num "tab:modalites-intervalles"}[]
donne les quatre instances de cette unique construction.

::::k7table (label := "tab:modalites-intervalles") (align := "llllZ{1.00}")
:::caption
Les quatre modalités d'usage comme quatre intervalles d'une seule construction
:::

:::table +header
* * Modalité
  * Intervalle
  * Affaiblissement
  * Contraction
  * Lecture
* * $`\text{Lin}`
  * $`[1..1]`
  * interdit
  * interdite
  * exactement une fois
* * $`\text{Aff}`
  * $`[0..1]`
  * permis
  * interdite
  * au plus une fois
* * $`\text{Rel}`
  * $`[1..\omega]`
  * interdit
  * permise
  * au moins une fois
* * $`\text{Unr}`
  * $`[0..\omega]`
  * permis
  * permise
  * sans contrainte
:::
::::

Trois choses se lisent sur cette table que trois singletons ne portaient pas. La première est qu'il
n'y a pas quatre définitions mais _une_ construction et quatre instances, obtenues en croisant deux
booléens — l'affaiblissement est-il permis, la contraction l'est-elle. La deuxième est que le
quatrième cas existe et porte un nom : $`\text{Rel}`, pour _pertinent_, au sens de la logique de la
pertinence — une ressource qu'on peut dupliquer mais pas abandonner, ce qui est la discipline d'une
obligation qu'il faut honorer au moins une fois. Ce document ne l'emploie pas aujourd'hui, et le
nommer coûte moins que de laisser croire que trois cas épuisent la construction. La troisième est
que l'ordre $`\text{Lin} \subseteq \text{Aff} \subseteq \text{Unr}` est l'_inclusion_ des intervalles (et non le sous-typage $`\preccurlyeq` ni l'ordre de précision $`\sqsubseteq`), et
non une relation posée à côté d'eux~; $`\text{Rel}` s'y insère entre $`\text{Lin}` et $`\text{Unr}`
sans être comparable à $`\text{Aff}`. Cela fait de l'ordre un treillis à quatre éléments plutôt
qu'une chaîne à trois — et c'est la forme que la littérature graduée emploie {cite "orchardQuantitativeProgramReasoning2019"}[].

Cette identification a une conséquence que le document a jusqu'ici employée sans la démontrer. Poser
les trois fragments comme trois sous-ensembles d'un même $`\mathcal{R}` ne dit pas encore que la
chaîne de sous-typage est _dérivable_ : il faut, pour cela, exhiber les morphismes qui la
produisent. La littérature sur l'unification des systèmes gradués et sous-structurels donne le cadre
et la condition. Un _mode_ y est la donnée d'une algèbre de grades, d'un idéal de contraction et
d'un booléen d'affaiblissement. Un morphisme de modes est une application qui envoie tout grade
contractable de la source sur un contractable du but et propage l'affaiblissement vers l'avant {cite "hanukaevUnificationGradedSubstructural2026"}[].

::::thm (label := "thm:morphismes_modes")
:::title
la chaîne modale est une chaîne de morphismes de modes
:::

:::statement +titled
Les modalités d'usage sont des modes, et leurs inclusions des morphismes

Les modalités sont les modes portés par les intervalles de $`\mathcal{R}` de la
table {num "tab:modalites-intervalles"}[], et toute inclusion d'intervalles entre elles est un
morphisme de modes. La relation $`\text{Lin} \subseteq \text{Aff} \subseteq \text{Unr}` est la traduction
qu'induisent les inclusions $`[1..1] \subset [0..1] \subset [0..\omega]`, et elle est donc _dérivée_
et non axiomatisée.
:::

:::proofsketch
Les contractables de $`\text{Lin}` et de $`\text{Aff}` forment l'ensemble vide, aucun de $`1` ni de
$`0` n'admettant la contraction ; la première condition est donc satisfaite _videment_ pour les deux
inclusions. La seconde l'est par monotonie du booléen d'affaiblissement le long de la chaîne :
$`\text{Lin}` ne l'admet pas, $`\text{Aff}` l'admet par disponibilité de $`0`, $`\text{Unr}` l'admet
_a fortiori_.

_Et la structure est un treillis, non une chaîne, dès qu'on compte les quatre modes._ Le quatrième,
$`\text{Rel} = [1..\omega]`, admet la contraction et refuse l'affaiblissement : l'inclusion
$`[1..1] \subset [1..\omega]` est un morphisme — première condition vide, seconde satisfaite, aucun
des deux n'admettant l'affaiblissement — et $`[1..\omega] \subset [0..\omega]` en est un aussi. Mais
$`\text{Aff}` et $`\text{Rel}` ne sont _pas_ comparables, et le voir dit ce que chaque condition
interdit : dans un sens l'affaiblissement passerait de permis à interdit, ce que la seconde
condition refuse ; dans l'autre, un grade contractable devrait s'envoyer sur un contractable d'un
mode qui n'en a aucun, ce que la première refuse. Les deux conditions du morphisme de modes sont
donc l'une et l'autre _actives_, et la chaîne à trois éléments que ce document emploie est le
fragment totalement ordonné d'un treillis à quatre. Il faut alors dire ce que le langage atteint : les modes _atteignables_ par les opérations de dérivation sont $`\{\text{Lin}, \text{Aff}, \text{Unr}\}`, aucune règle ne produisant $`\text{Rel}`. Ce mode est un grade mathématiquement admissible, non effectivement générable ; la distinction est celle que le document applique ailleurs aux produits de grades, et elle reste à démontrer par examen des règles de production de grades.

Un corollaire mérite d'être tiré plutôt que laissé implicite, car il explique une facilité que ce
document s'est permise. Un morphisme de modes induit en général une traduction qui n'est pas
l'identité sur les types et les termes, ceux-ci portant des annotations de grade qu'il faut
transporter le long du morphisme. Ici les morphismes sont des _inclusions de sous-ensembles d'un
même_ $`\mathcal{R}` : les traductions induites sont donc des identités sur le grade, et il n'y a
rien à transporter. C'est pourquoi la chaîne s'écrit partout comme du pur sous-typage sans qu'aucune
annotation ne soit jamais convertie — ce qui était correct, mais pour une raison qui n'était pas
écrite.
:::
::::

Ce mot de _mode_ demande d'être situé, faute de quoi ce document paraîtrait seul de son espèce alors
qu'il ne l'est pas. Un cadre général existe, dont ce chapitre est une instance : un calcul des
séquents paramétré par une _théorie des modes_, où le contexte obéit aux propriétés structurelles
ordinaires tandis qu'un terme, tiré de la théorie des modes, contraint la manière dont il peut être
employé. Le cadre exprime les produits et implications non associatifs, ordonnés, linéaires,
affines, pertinents et cartésiens, les foncteurs, les (co)monades et les adjonctions — et
l'admissibilité de la coupure y est démontrée _indépendamment_ de la théorie des modes choisie {cite "licataFibrationalFrameworkSubstructural2017"}[].
Ce dernier point est le plus utile ici : ce que ce document démontre sur ses trois couches n'a pas à
être redémontré si une quatrième s'ajoutait, pourvu qu'elle s'exprime comme un mode de la même
théorie.

Des langages implantent ces modes, et l'un d'eux est en production. Un travail récent dote OCaml de
trois axes de modes — _affinité_, _unicité_ et _localité_ — pour rendre sûres l'allocation sur la
pile et la mise à jour en place, avec deux propriétés que ce document doit regarder en face. Les
modes y sont pleinement rétrocompatibles avec le code existant, et ils sont _entièrement inférés_ {cite "lorenzenOxidizingOCamlModal2024"}[].
Les grades y sont par ailleurs entrés dans Haskell, Idris et Granule, selon deux lignées distinctes
— celle où l'annotation est _pervasive_ et porte sur les types de fonctions, et celle où elle passe
par une modalité graduée {cite "liepeltSameCoeffectDifferent2026"}[]. Ce document appartient à la
seconde.

Trois différences le séparent de ces voisins, et aucune n'est un mérite en soi. Ses modes ne sont
pas trois axes d'une même dimension mais trois _couches_ d'un même calcul, chacune avec son algèbre
de grades. Ils ne sont pas inférés mais _déclarés_, par un délimiteur — choix dont le chapitre 5 dit
le prix. Et ils ne s'ajoutent pas à un langage existant : ils le constituent. La première différence
est structurelle, les deux autres sont des arbitrages, et un lecteur venu d'un de ces langages a le
droit de demander pourquoi ils ont été rendus dans ce sens.

Un mode étant la donnée d'une algèbre de grades, d'un idéal de contraction et d'un booléen
d'affaiblissement, une question se pose que ce document a rencontrée trois fois sans la reconnaître
comme une seule : celle de l'_échange_, la quatrième règle structurelle, que rien ici ne restreint.
Trois besoins indépendants la réclament. Lever l'acyclicité du graphe d'acteurs par le sous-typage
multipartite demande un cadre non commutatif, ce que le chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]) note comme une objection locale {cite "horneSessionSubtypingMultiparty2020"}[].
Emprunter une session sans la consommer repose sur un typage linéaire _ordonné_ {cite "saffrichBorrowingSessionTypes2025"}[].
Et rendre déductible, plutôt que déclarée, l'annotation de classe d'automate du chapitre 4 passe par
une caractérisation qui demande la logique affine non commutative {cite "pradicImplicitAutomataLcalculi"}[].
Trois arcs de recherche distincts, un même prix.

La voie évidente est le _contexte ordonné_, et son prix est chiffré : l'extension est conservative —
rien de ce qui est démontré ici ne serait perdu — mais elle coûte un troisième contexte et quatre
implications au lieu d'une, dont deux directionnelles {cite "polakowNaturalDeductionIntuitionistic1999"}[].
Ce document ne la retient pas, et pour une raison qui n'est pas le prix : les trois besoins portent
_trois ordres différents_ — séquentiel par session, partiel sur les durées d'emprunt, total sur les
positions —, qu'un contexte ordonné, n'en portant qu'un, confondrait.

La voie disponible, dont le prix est chiffré ci-après, est de porter l'échange comme une _donnée de mode_, au rang de l'idéal de
contraction et du booléen d'affaiblissement — une _zone_ étant alors un mode, dont l'ordre lui est
propre. Ce point se fixe ici, la solution voisine ne marchant pas : faire de la zone une composante
du grade demanderait que la mise à l'échelle ne déplace pas une liaison d'une zone à une autre, donc
$`r \cdot z = z` sur cette coordonnée, ce qui n'a pas d'unité à droite et ne fait donc pas un
semi-anneau. La zone appartient au mode, non au grade. Deux liaisons de modes distincts s'échangent
librement, faute d'ordre commun ; à l'intérieur d'un mode, l'ordre s'applique. Et la structure
existe déjà chez Grass, qui fait coexister des grades d'algèbres différentes, un mode portant la
sienne. Elle n'a pas de précédent construit — c'est un risque de recherche assumé, et le seul de ce
document —, mais elle ne confond pas ce qu'elle prétend séparer.

Cette voie n'est pas sans précédent, contrairement à ce que la note des auteurs cités laissait
croire, et le précédent apporte avec lui une contrainte que ce document doit connaître. Une
_signature de subexponentielles_ y est la donnée $`\Sigma = \langle I, \preceq, W, C, E\rangle` — un
ensemble d'étiquettes muni d'un préordre, et trois sous-ensembles disant lesquelles admettent
l'affaiblissement, la contraction et l'_échange_ {cite "kanovichSubexponentialsNoncommutativeLinear2019"}[].
C'est le mode enrichi d'une donnée d'échange, sous une forme plus simple que celle envisagée
ci-dessus : une étiquette permet l'échange ou ne le permet pas.

Deux résultats négatifs l'accompagnent, et ils forment un dilemme. La contraction _locale_ — celle
qui ne contracte que des formules adjacentes — fait perdre l'élimination des coupures. La
contraction _non locale_ la préserve, mais dès qu'une seule subexponentielle l'admet, la
dérivabilité devient _indécidable_. En cadre non commutatif, on ne peut donc avoir ensemble la
contraction et la décidabilité, ni la contraction locale et l'élimination des coupures.

Ce dilemme ne mord pas ici, et pour une raison qui n'est pas une chance. Les trois besoins qui
réclament l'échange restreint — la séquence des messages d'une session, la pile d'emprunts, la
planarité des fils — sont tous des phénomènes de _couche 1_, où la contraction est absente par
construction. La condition à retenir s'écrit donc $`E \neq \emptyset \Rightarrow C = \emptyset` pour
un même mode, et la stratification de ce document la satisfait déjà — non par prévoyance. Mais parce
que les besoins d'ordre et le besoin de duplication ne se rencontrent pas dans le même fragment. Ce
qui était une commodité d'architecture devient ici une exigence, et les systèmes sans contraction
sont en outre décidables avec des bornes de complexité établies.

Une réserve subsiste, et elle est de nature. Une subexponentielle est indexée par un _préordre_
d'étiquettes ; un grade vit dans un _semi-anneau préordonné_, où l'on additionne et multiplie. Le
cadre cité donne donc la machinerie de l'échange, non sa composition avec la gradation. Ce qui reste
à faire n'est plus de construire le prédicat, mais de le composer avec une algèbre — travail plus
petit, et d'une autre espèce.

Une condition en découle, et elle n'est pas un raccommodage : c'est ce que le besoin voulait dire,
exprimé au bon niveau. Les trois données d'un mode existent toutes pour une même raison : rendre
l'_ordre d'application_ des règles structurelles indifférent. L'idéal est clos par addition pour que
contracter trois liaisons donne le même terme quel que soit l'appariement choisi ; il contient $`0`
pour que contraction et affaiblissement commutent ; il absorbe pour que contracter puis substituer
et substituer puis contracter coïncident {cite "hanukaevUnificationGradedSubstructural2026"}[]. Un
prédicat d'échange, lui, rend l'ordre _pertinent_. Les deux ne se rencontrent qu'en un point, mais
ce point est réel : la contraction _fusionne_ deux liaisons, donc détruit l'ordre entre elles. D'où
la condition $$`q_1, q_2 \in \mathrm{Cont}(m) \quad\text{et}\quad \mathrm{Exch}(q_1, q_2),` qui se
lit sans effort. On ne fusionne deux emplois d'une ressource que si leur ordre est sans importance —
on ne fusionne pas le premier et le second message d'une session.

Son prix demande d'être situé exactement, car il n'est pas là où l'on croirait. L'échange n'est pas
une règle de K7PL : le contexte est une _application finie_ des variables vers les grades, ce dont
l'addition point par point est la marque, et l'échange y est présupposé par la représentation plutôt
qu'admis par une règle. On ne restreint donc pas une règle, on change une représentation — un
contexte à zones est une application finie vers des couples de grade et de zone, assortie d'un ordre
partiel par zone. L'addition y reste ponctuelle, et $`\boxtimes` survit sans retouche puisque
$`\psi` n'agit que sur le budget et laisse la zone inchangée.

Ce qui change est le lemme de substitution (§{num "sec:g-regles"}[], théorème {num "thm:substitution"}[]) : son
énoncé place la variable substituée à l'extrémité droite du contexte, ce qui est une notation sur
une application finie et devient une contrainte sur une zone ordonnée. Il acquiert donc une
condition de bord — la substitution est admissible pour la liaison _maximale_ de sa zone —,
condition qui n'est pas un défaut mais le contenu même de la restriction : on ne consomme pas le
second message d'une session avant le premier.

Cette condition doit alors être acquittée aux trois endroits où ce lemme sert, et les trois verdicts
diffèrent. La _préservation_ la satisfait sans hypothèse : un rédex substitue toujours dans la
liaison la plus récemment introduite, et l'ordre d'une zone suivant l'ordre d'introduction, cette
liaison est maximale — la restriction ne mord jamais là où la réduction opère, parce que la
réduction opère toujours au sommet. La _relation logique_ la satisfait au prix d'un lemme de plus :
la substitution y est simultanée, donc touche toutes les liaisons, et il faut la décomposer en
substitutions simples prises dans l'ordre inverse de la zone, ce qui demande de réénoncer le lemme
de substitution simultanée avec son _ordre d'occurrence_

Cet ordre mérite son nom, car trois constructions l'emploient sans qu'aucune ne le nomme. L'_ordre
d'occurrence_ d'un terme est l'ordre dans lequel ses liaisons y apparaissent, lu de gauche à droite.
L'expansion d'une macro s'en sert pour savoir où une métavariable se place ; une zone s'en sert pour
restreindre l'échange, deux liaisons qu'elle gouverne ne se permutant que selon lui ; et la
substitution simultanée s'en sert pour se décomposer en substitutions simples. {rmq}[Trois emplois,
un objet. Le nommer ne change aucune construction — il permet seulement de dire une fois ce que
chacune supposait.] Le nommer n'ajoute rien au langage : il permet d'écrire une fois la condition
que les trois supposaient, à savoir que cet ordre existe et qu'il est total sur les liaisons d'un
terme donné.

Le troisième emploi appelle une réserve d'une autre nature, et c'est la seule que ce document ne
peut pas lever. La _traduction_ vers le métalangage reste correcte — un terme source bien typé s'y
traduit en un terme cible bien typé, et l'extrusion de portée qu'elle emploie repose sur une
propriété de grade que l'ordre ne touche pas. Mais la composition parallèle du calcul cible est
commutative : l'ordre d'une zone n'a aucune image dans la traduction, et deux termes que l'échange
distinguerait à la source ont des traductions équivalentes. La traduction cesse donc de _refléter_
cette discipline, et la conséquence porte au-delà d'elle — toute propriété de la source dérivée de
la traduction devrait être revérifiée, l'acyclicité du chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]) en étant une. La parade connue serait de donner au
métalangage sa propre discipline d'ordre, c'est-à-dire la logique linéaire ordonnée du côté cible.
Mais c'est ce que la voie disponible évite à la source, et le payer à la cible n'est pas le payer
moins.

Encore faut-il dire ce qu'est la consommation d'une ressource linéaire, faute de quoi P3 exigerait
une libération déterministe sans indiquer par quoi elle passe. À tout type linéaire est associé un
_destructeur_ : un morphisme invoqué au point de consommation, dont l'exécution est fixée par la
structure du type et non par une politique d'exécution. Le terme est pris au sens que lui donne la
synthèse des modèles de propriété et d'emprunt des langages systèmes avec les types linéaires de la
programmation fonctionnelle, où il est expressément distingué du _finaliseur_ {cite "munch-maccagnoniResourcePolymorphism2018"}[].
Le premier est déterministe et lié au type, le second non. Seul le premier réalise P3 : le second
rendrait la libération dépendante d'un ramasse-miettes que la couche 1 n'a pas.

Trois opérations gouvernent sa propagation, et ce sont celles du semi-anneau, non celles d'un
treillis. Le _partage_ d'une ressource entre deux sous-termes somme leurs grades : une liaison
exercée à hauteur de $`r` dans l'un et de $`s` dans l'autre porte le grade $`r+s`, ce qui est la
contraction $`c_{r,s}` du §{num "sec:c2-la-comonade-exponentielle-et"}[]. La _capture_ par une
fermeture, ou plus généralement l'application d'une fonction dont l'argument porte le grade $`r`,
met le contexte de cet argument à l'échelle par $`r` — la multiplication du semi-anneau, soit
$`\delta_{r,s}` lue dans l'autre sens. Le _branchement_ seul échappe à cette discipline : les deux
branches d'un `match` étant exclusives, leurs grades ne s'additionnent pas mais se joignent par
$`\sqcup`, et ce joint est une sur-approximation assumée.

La distinction importe. Le joint est idempotent, la somme ne l'est pas : c'est parce que le partage
passe désormais par $`+` que le langage sait distinguer une ressource exercée exactement deux fois
d'une ressource d'usage libre, ce qu'un système bâti uniquement sur des opérations de treillis ne
peut structurellement pas faire. Le reste de cette section montre comment ce grade se propage, se
divise et se recompose à travers les constructions du langage.

::::figure (label := "fig:modalites-structurelles") (src := "matrice-contraction-affaiblissement") (alt := "Matrice a deux entrees, contraction en abscisse et affaiblissement en ordonnee. Trois cases sur quatre sont instanciees par K7PL — Lin en couche 1, ni contraction ni affaiblissement ; Aff en couche 2, affaiblissement seul ; Unr en couche 3, les deux. La quatrieme case, contraction sans affaiblissement, est marquee « non instancie par K7PL ».") (width := "90")
:::caption
Contraction et affaiblissement, trois modalités sur quatre combinaisons possibles
:::

:::desc
Les quatre combinaisons que la contraction et l'affaiblissement engendrent, et celle que le langage
laisse vacante.
:::
::::

La quatrième combinaison — contraction admise sans affaiblissement, la logique dite _relevante_ —
n'est instanciée par aucune modalité de K7PL. Une ressource qu'on peut dupliquer mais jamais
abandonner ne correspond à aucun besoin identifié dans les quatre postulats du chapitre 1, et le
langage ne la propose donc pas.

Grades et types ne se déterminent pas en deux passes séquentielles. Toute définition de plus haut
niveau porte une signature complète — grades compris — sur laquelle le compilateur travaille ; mais
cette signature n'a pas à être écrite en entier, et deux dispositifs l'allègent sans rien retirer au
système.

Le premier est un _grade par défaut_ propre à chaque fragment : $`\omega` dans le cartésien, $`1`
dans le linéaire, $`0` ou $`1` dans l'affine selon la forme de la liaison. Un grade omis est donc
celui du fragment ambiant, que le délimiteur a déjà annoncé (chapitre 5,
§{num "sec:c5-s-expressions-universelles"}[]) — ce qui rend silencieux le cas majoritaire, où l'on
écrit précisément dans le fragment que l'on a ouvert. Le second est l'_inférence locale_ : à
l'intérieur d'une définition annotée, grades et types des liaisons internes sont inférés, la
signature ne portant que sur la frontière. Ces deux dispositifs relèvent de l'élaboration et non du
système de types : ce que la Phase 2 reçoit est la signature complète, reconstituée, et le parcours
bidirectionnel qui suit est inchangé. L'inférence complète des modes de propriété est d'ailleurs
attestée sur un système à trois axes {cite "lorenzenOxidizingOCamlModal2024"}[] ; le renoncement de
K7PL porte sur le système gradué général, non sur cet axe.

Sur cette signature — écrite ou reconstituée — le compilateur dispose du grade attendu de chaque
liaison et procède _bidirectionnellement_. Il vérifie les formes d'introduction contre le grade
annoncé, synthétise celui des formes d'élimination, et défère au solveur SMT les contraintes
résiduelles sur $`\mathcal{R}`. C'est l'architecture qu'adoptent les systèmes gradués existants {cite "moonGradedModalDependent2021"}[], {cite "orchardQuantitativeProgramReasoning2019"}[],
et elle dispense de l'ordonnancement que la conception antérieure de K7PL imposait entre analyse de
flot et unification — ordonnancement qui n'était nécessaire que pour une inférence complète à la
Damas-Milner, à laquelle le §{num "sec:c3-structures-ouvertes-effets-et"}[] renonce. Ce que le
développeur y perd en concision d'écriture, le §{num "sec:c3-structures-ouvertes-effets-et"}[] le
nomme ; ce qu'il y gagne est un modèle de coût de compilation prévisible, et des messages d'erreur
qui pointent une signature plutôt qu'un point d'unification arbitraire.

Le cas Lin porte une propriété plus forte qu'une simple comptabilité d'usage : une valeur `Lin T`
est le témoin qu'une seule référence existe, prouvée à la compilation plutôt que vérifiée à
l'exécution. Cette unicité, empruntée à Clean, rend la mutation physique en place fonctionnellement
pure : aucune fibre ne peut observer d'état intermédiaire, puisqu'aucune autre référence ne peut
exister pour l'observer. La performance du bas niveau et la pureté mathématique (P1, P3) cessent
ainsi d'être en tension — l'une est la preuve constructive de l'autre.

Cette même unicité impose une règle de composition aux fermetures : la modalité d'une fermeture ne
peut être plus permissive que celle de la plus contrainte de ses captures, c'est-à-dire la rencontre
— au sens du treillis $`\text{Lin} \subseteq \text{Aff} \subseteq \text{Unr}` — des modalités capturées. Une
fermeture qui capture une ressource `Lin` doit elle-même être `Lin`, quelles que soient ses autres
captures. L'autoriser à être `Unr` permettrait de l'invoquer plusieurs fois, donc de dupliquer la
ressource linéaire qu'elle referme, en violation directe de l'absence de contraction (chapitre 2,
§{num "sec:c2-la-comonade-exponentielle-et"}[]). La défonctionnalisation du chapitre 6, qui remplace
chaque fermeture par un tag entier, doit préserver ce contrat : le tag hérite du grade de la
fermeture qu'il remplace.

Une seconde règle de composition régit le branchement, et elle ne se déduit pas de la première. Deux
branches d'un `match` ou d'un `cond` ne consomment pas nécessairement les mêmes ressources. K7PL
type chacune sous le même contexte gradué et retient, pour le branchement entier, le joint $`\sqcup`
des grades de ses branches — celui du treillis de précision du chapitre 2
(§{num "sec:c2-adjonctions-et-enrichissement"}[]). Une ressource consommée dans une seule branche
est donc comptée comme consommée dans toutes. Cette règle est délibérément approximative : c'est le
compromis usuel des systèmes gradués, qui retiennent l'usage maximal d'une branche plutôt que de
raisonner sur la valeur qui décide du chemin {cite "deamorimReallyNaturalLinear2014"}[]. Elle
rejette des programmes corrects — un tampon libéré dans la branche d'erreur et transmis dans la
branche nominale sera refusé, alors qu'aucune exécution ne viole la linéarité — et n'en accepte
aucun d'incorrect. Les théories à multiplicités dépendantes lèvent cette restriction en faisant
dépendre le grade de la valeur qui décide du branchement {cite "doreDependentMultiplicitiesDependent2025"}[]
; K7PL y renonce conformément à P3, au prix d'un ensemble de programmes acceptés strictement plus
petit.

Les capabilités raffinent cette même idée en grades véritablement numériques plutôt qu'en trois
points discrets. Une `WriteCap<T>` porte un grade linéaire strict, $`\mathcal{G}=1` : sa duplication
est exclue par l'absence de diagonale, comme tout objet du fragment linéaire strict. Une
`ReadCap<T>` n'est pas une fraction de cette capacité, et la distinction est essentielle : diviser
un grade linéaire produit, par la contraction du §{num "sec:c2-la-comonade-exponentielle-et"}[],
deux capacités _séparées_ — c'est ce que le tenseur sert à dire —, non deux lecteurs d'une même
région.

Le partage en lecture vit de l'autre côté de l'adjonction du
§{num "sec:c2-la-comonade-exponentielle-et"}[] : une `ReadCap<T>` est l'image, par le foncteur qui
va du fragment linéaire au fragment cartésien, de la région gouvernée par la `WriteCap`. C'est là,
où la diagonale existe, que $`N` lecteurs simultanés sont exprimables ; le grade $`r` n'y compte
plus des détenteurs mais reste ce qu'il est partout ailleurs, un indice d'usage. Le solveur SMT
(chapitre 6) vérifie alors une condition d'exclusion — aucune `WriteCap` vivante tant qu'une image
cartésienne subsiste — et non une somme de fractions.

Cette discipline, que le système de types impose ici par construction, est celle que les
architectures à faible latence atteignent par la mesure. L'algorithme idéal y est celui où un seul
fil détient toutes les écritures sur une ressource, les autres n'en lisant que les résultats {cite "thompsonDisruptorHighPerformance2011"}[].
Les deux voies convergent pour la même raison — c'est la contention en écriture qui coûte, non la
lecture.

Ce que ce paragraphe établit vaut de la mémoire, et de la mémoire seule. Le partage d'un _canal_
n'est traité nulle part dans ce document, alors que la question se pose dans les mêmes termes et
qu'elle a reçu une réponse. Un système de types linéaire ordonné, muni d'une opération explicite de
partage de la propriété d'un canal, dont le typage est décidable et la décidabilité mécanisée {cite "saffrichBorrowingSessionTypes2025"}[].
Reste à savoir si l'emprunt d'un canal relèverait du même geste — une image par le foncteur de
l'adjonction — ou d'un ordre sur le contexte ; ce document ne tranche pas.

Ce déplacement corrige une confusion que le §{num "sec:c2-la-comonade-exponentielle-et"}[], tant
qu'il restait vague, autorisait : la multiplicité d'usage et l'aliasement sont deux propriétés
distinctes, que les systèmes de modes séparent en axes distincts précisément parce qu'aucun ne
recouvre l'autre {cite "lorenzenOxidizingOCamlModal2024"}[]. Il répond aussi à une difficulté
ancienne — les modèles dénotationnels rendant compte de l'accès concurrent en lecture ont longtemps
manqué, alors même que la distinction entre phrases passives et actives était claire au niveau du
langage {cite "REDDY-PASSIVITY"}[]. Ce n'est pas la vérification qui était en défaut chez K7PL,
c'était le lieu où elle s'interprétait. Des grades à valeurs non entières ne sont ni exotiques ni un
obstacle à la métathéorie. L'analyse de sensibilité locale par coeffets dépendants {cite "sannierDependentCoeffectsLocal2026"}[]
et le suivi de l'erreur inverse en arithmétique flottante {cite "kellisonBeanLanguageBackward2025"}[]
en font l'un et l'autre un usage central. Les _data races_ ne sont donc pas détectées, elles sont
rendues inexprimables — un grade dont la somme dépasse $`1` n'a simplement pas de dérivation.

Une capabilité transversale — connexion réseau, horloge, source d'aléa — se déclare exactement de la
même façon, mais dans la signature d'une fonction plutôt que sur une région d'arène :
`:requires [NetworkCap ClockCap]` engage une dépendance dont l'absence, au site d'appel, est une
erreur de compilation (`Unsatisfied Capability`) plutôt qu'un échec à l'exécution. Cette déclaration
a une conséquence directe sur la testabilité : puisque la capacité n'est jamais qu'un grade porté
par le type, rien n'empêche de la satisfaire, en mode test, par une version déterministe — une
horloge virtuelle, un flux statique — sans toucher au corps de la fonction elle-même. Une fonction
qui déclare ses dépendances par grade se teste donc en isolation aussi naturellement qu'un calcul
pur, sans infrastructure ni double de test construit à la main.

Une destination pousse cette logique un cran plus loin : c'est une `WriteCap` non plus sur une
valeur existante, mais sur un emplacement qui n'existe pas encore. Le type `Dest T` est cette
capacité d'écriture unique vers un trou ; `Incomplete A B` décrit une structure de type $`A` dont
$`B` — un produit tensoriel de destinations — reste à remplir. Les primitives `hollow_alloc`,
`fill`, `fillLeaf`, `fillComp` et `finalize` manipulent ce grade exactement comme une `WriteCap`
ordinaire ; la finalisation, qui clôt la structure, n'est qu'un changement d'offset en $`O(1)`.
Remplir une destination par une valeur qui contiendrait elle-même une destination non résolue
créerait un cycle de dépendance. K7PL l'exclut par un paramètre d'âge $`k` sur les types linéaires,
`Lin_k T`, garantissant qu'une destination ne se remplit que par une valeur dont les destinations
propres portent un âge strictement inférieur. C'est, au niveau des types, une instance du même
principe que la mesure strictement décroissante qui fonde la terminaison des catamorphismes
(chapitre 2, §{num "sec:c2-algebres-coalgebres-et-points"}[]) : construire une structure par
destinations est un cas particulier de construction bien fondée, et les âges en sont la preuve.

Une contrainte doit être posée ici, et c'est une contrainte de _sûreté_ et non de discipline. Une
destination est _proprement linéaire_ : elle ne peut pas être affine, et elle ne peut donc pas se
relever le long de la chaîne $`\text{Lin} \subseteq \text{Aff} \subseteq \text{Unr}` posée ci-dessus. Le motif est
direct — le mode affine admet l'affaiblissement, donc l'abandon ; une destination abandonnée est un
trou jamais rempli ; et lire la structure finalisée reviendrait à lire de la mémoire non
initialisée. La distinction entre une multiplicité proprement linéaire et un mode affine est celle
que le calcul de destinations retient, et pour cette raison {cite "bagrelDestinationCalculusLinear2025"}[].
Le point s'écrit plutôt qu'il ne se suppose, la chaîne de sous-typage de ce chapitre _monte_ vers
l'affine : sans exclusion explicite, la règle générale autoriserait ce que la sûreté interdit.
`Dest T` et `Incomplete A B` sont donc hors de la portée de {sc}[SubBox] sur la composante d'usage,
et `finalize` est la seule sortie de leur linéarité.

Un même exemple traverse les trois modalités et rend visible ce qu'elles coûtent et ce qu'elles
garantissent. Une `String` est une valeur immuable, `Unr`, dont la validité UTF-8 est garantie une
fois pour toutes : elle se copie librement, au prix de ne jamais pouvoir être construite en place.
Un `StringBuilder` est `Aff` : sa construction dynamique peut être abandonnée sans finalisation si
le résultat n'est plus nécessaire, mais jamais dupliquée sans risque d'incohérence entre deux
constructions concurrentes. Un `ByteBuffer` est `Lin` : mémoire brute sous-jacente, il doit être
explicitement consommé — converti, libéré — sans quoi le compilateur le signale. Les conversions
entre les trois sont des morphismes explicites, jamais implicites, chacune préservant la garantie
propre à sa modalité de départ (P3) : on ne gagne jamais en sûreté sans le dire, on ne perd jamais
en performance sans le voir.

À l'autre extrémité, certains types rendent le grade `Unr` sûr y compris à travers une partition
réseau, en dotant leurs valeurs d'une opération de fusion $`\sqcup` commutative, associative et
idempotente — un CRDT est, au niveau du type, exactement cette structure de semi-treillis. K7PL en
fournit plusieurs instances prêtes à l'emploi — un compteur croissant (`GCounter`), un compteur
bidirectionnel (`PNCounter`), un ensemble en croissance (`GSet`), un registre à dernière écriture
gagnante (`LWWRegister`) — chacune une algèbre différente pour le même semi-treillis. Deux répliques
d'une même valeur CRDT peuvent diverger librement pendant une partition, puisque leur fusion
ultérieure ne dépend ni de l'ordre ni du nombre de répétitions. La copie libre que `Unr` autorise
cesse d'être un risque de divergence pour devenir la condition même de la convergence exigée par P4.

Une propriété d'ensemble se dégage de ce qui précède, et plusieurs passages s'y adossent sans
qu'elle ait été posée. Le jugement germinal prétend porter _toutes_ les restrictions du langage :
c'est ce qui autorise le chapitre 5 à présenter ses refus comme des conséquences plutôt que comme
des règles. Sous cette forme, l'affirmation ne se réfute pas, donc ne se démontre pas. Elle en admet
une seconde, qui se vérifie. La forme en est ancienne : Reynolds posait déjà, parmi les problèmes
ouverts d'un langage sans types déclarés, qu'un système de restrictions doit être complet au sens où
rien n'est refusé qui ne soit refusé par lui {cite "reynoldsGEDANKENSimpleTypeless1970"}[] ; ce qui
suit en est la version graduée.

::::thm (label := "thm:completude_graduee") (status := "proposition")
:::title
complétude graduée
:::

:::statement +titled
Tout refus est un échec de dérivation

Pour tout constructeur du noyau (§{num "sec:g-grammaire-termes"}[]), tout refus du vérificateur est
l'échec d'une prémisse d'une règle nommée du §{num "sec:g-regles"}[]. Autrement dit, pour ces
constructeurs, il n'existe aucune condition de bord vérifiée à côté du système de types.
:::

:::proofsketch
L'énoncé se vérifie par énumération sur une base _close_ : les codes d'erreur du noyau, et non le
catalogue entier de l'annexe {num "sec:annexe-a-codes"}[], qui se déclare illustratif et non exhaustif et dont un tiers des
codes porte sur des constructions hors du noyau — pour lesquelles l'exhibition d'une dérivation qui
échoue n'a pas de sens. L'énumération se range selon quatre catégories — grade, couche, effet,
contrainte de valeur — qui se ramènent chacune à l'absence d'une prémisse dans une règle nommée, et
elle se vérifie mécaniquement : la table à deux colonnes code ⟷ prémisse manquante sur les
constructeurs du noyau est un artefact exécutable, que le croisement des grammaires et des règles
(`scripts/controle.py`) garde.

Le sens réciproque — un programme dérivable est accepté — n'est pas un théorème : c'est une
propriété d'implémentation, énoncée ci-dessous comme exigence, et non une prémisse promue.

Une hypothèse est nécessaire et elle est nommée ici plutôt que découverte plus loin : la _frontière
de confiance_ du §{num "sec:c3-structures-ouvertes-effets-et"}[] doit être un objet du jugement.
Tant qu'elle lui reste extérieure, ses trois franchissements constituent des restrictions non
exprimées, et le théorème est faux. La ranger du côté de l'intégrité, comme le fait cette section,
est donc la condition de l'énoncé et non un aménagement de présentation.
:::
::::

::::thm (label := "thm:completude_verificateur") (status := "exigence") (level := "compilation")
:::title
le vérificateur n'émet que des codes de la correspondance
:::

:::statement +titled
Aucun refus hors de la table code ⟷ prémisse

Le vérificateur n'émet aucun code d'erreur hors de la correspondance entre codes et prémisses
manquantes. Route : mesure — chaque code émis par l'implémentation est comparé à la table — ou
démonstration, si le vérificateur est dérivé des règles.
:::
::::

Ce théorème est ce qui donne son statut à `ERR-TOP-001` (chapitre~5,
§{num "sec:c5-s-expressions-universelles"}[]) : le refus d'une imbrication de délimiteurs n'est pas
une règle de plus, c'est le nom d'un échec de dérivation. Le chapitre 5 l'affirme déjà — la
contrainte « découle directement des spécialisations du jugement germinal » — et c'est ici que
l'affirmation devient vérifiable. C'est aussi ce qui la rend transportable dans un assistant de
preuve, où une condition de bord vérifiée à côté du système ne se mécanise pas avec lui.

Ces trois lois valent des instances plates énumérées ci-dessus ; elles ne se propagent pas
gratuitement à leurs compositions. La commutativité de la fusion d'un `GSet` de `LWWRegister` ne se
déduit pas de celle du $`\sqcup` de l'ensemble : elle porte sur les registres qu'il contient, et
l'induction structurelle ordinaire n'y accède pas. Les règles d'induction standard n'induisent que
sur la structure de premier niveau et laissent intactes les données internes. L'induction _profonde_
y répond : elle induit sur toutes les données structurées présentes et se spécialise en les règles
standard {cite "johannDeepInductionInduction2020"}[]. Un CRDT composé n'hérite donc des lois de ses
constituants que sous un principe d'induction profonde sur le type composé, que la déclaration du
type doit exposer. La mécanique de réconciliation elle-même — quand et comment la fusion s'exécute
au sein de l'orchestrateur — relève du chapitre 4.
