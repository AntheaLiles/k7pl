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

#doc (Manual) "Axiomatique germinale" =>
%%%
file := "c1-axiomatique-germinale"
tag := "c1-axiomatique-germinale"
%%%

{label "sec:c1-axiomatique-germinale"}
{label "sec:c1-de-la-loi-distributive"}

La méthode suivie ici — poser un petit nombre de principes généraux, en dériver des règles simples,
et garder une règle générale toujours prête à arbitrer les cas que les règles particulières ne
couvrent pas — n'est pas neuve, et son précédent est industriel plutôt qu'académique. C'est celle
dont APL2 a tiré sa syntaxe, en se donnant explicitement un cadre pour ses extensions futures avant
d'en avoir besoin {cite "brownDevelopmentAPL2Syntax1985"}[]. Ce que ce précédent apporte n'est pas
une caution mais une mise en garde utile : la valeur d'une telle méthode ne se mesure pas à
l'élégance du noyau, elle se mesure à ce qu'il advient de la dixième extension.

Trois choses méritent d'être dites de ces quatre postulats avant d'en donner l'expression, et toutes
trois sont des acquis possédés sans être revendiqués.

La première porte sur ce qu'un postulat _fait_. Les quatre sont présentés ci-dessus par ce qu'ils
garantissent, et c'est la moitié de leur travail. L'autre moitié est qu'ils _ferment des portes_, et
l'histoire du langage fonctionnel le plus regardé du domaine en donne la formule. Le plus grand
bénéfice de la paresse, écrivent ses concepteurs, n'est pas la paresse mais qu'elle les a gardés
_purs_ {cite "hudakHistoryHaskellBeing2007"}[]. Un choix de conception vaut autant par ce qu'il rend
inécrivable que par ce qu'il promet, et les quatre postulats se lisent ainsi : ce ne sont pas quatre
promesses mais quatre portes fermées, dont les promesses sont la conséquence.

La deuxième porte sur ce que la gradation _dissout_. La même rétrospective note que le clivage
strict/paresseux « est devenu bien moins une décision tout-ou-rien » — Haskell y est arrivé par
accrétion, au fil de vingt ans d'annotations ajoutées une à une. K7PL n'y arrive pas, il _part_ de
là : le grade d'usage donne le régime d'évaluation comme une donnée du jugement plutôt que comme un
défaut du langage assorti d'échappatoires. La différence n'est pas de résultat mais d'ordre, et
l'ordre décide de la métathéorie — ce qui est posé se démontre, ce qui est accrété se rattrape.

La troisième est un ancêtre plus ancien qu'on ne l'attendrait. Trois des quatre problèmes ouverts
que Reynolds laissait en 1970 à un langage sans types déclarés sont, dans le vocabulaire
d'aujourd'hui, la dépendance des types aux valeurs, la non-dissimulation du coût, et le déterminisme
d'exécution — soit le lambda-Pi, P3 et P4 {cite "reynoldsGEDANKENSimpleTypeless1970"}[]. Et pour le
deuxième, il ne se contente pas de poser le problème : il _désigne_ les deux remèdes employés ici,
la discipline sur les variables et l'annotation portée par le type. Cinquante-six ans séparent
l'énoncé de sa réalisation, et rien n'oblige à faire comme si le problème était neuf.

Un quatrième point relève du même registre et concerne l'adoption plutôt que la théorie. Les
contrats d'interface de la couche 1 passent volontiers pour un détail d'ingénierie~; ils sont
davantage. Un langage qui vise un unikernel n'a pas de langage hôte, donc pas de passerelle vers un
écosystème existant : ces contrats sont ce qu'il a _à la place_, et donc son facteur d'adoption tout
entier. Le prix en est chiffré par l'histoire de Haskell, dont l'interface étrangère a demandé une
trentaine de pages de spécification, deux ans de travail et un éditeur pour aboutir, en prenant le C
comme dénominateur commun faute de mieux {cite "hudakHistoryHaskellBeing2007"}[]. Ce prix n'est pas
encore payé~; il doit au moins l'annoncer.

Les quatre postulats trouvent leur expression conjointe dans un unique jugement de typage, dont tout
le reste vérifie qu'il n'est qu'une instance ou une combinaison. Un choix de présentation y est fait :
le contexte des canaux est fondu dans le contexte linéaire $`\Delta` plutôt que tenu à part. Le
jugement compte ainsi une composante de moins, et communication et propriété relèvent d'un même
principe de disjonction. Un lecteur venu de la littérature sur la concurrence, où ce sont deux
calculs distincts, doit reconnaître dans $`\Delta` une structure qui porte les deux rôles.

Dans la catégorie ambiante _C_, les objets sont les types et les programmes purs en sont les
morphismes $`f : A \to B`. Une donnée n'est, dès lors, jamais un élément global du terminal $`1` :
c'est un élément généralisé, un morphisme $`\Gamma \to T` évalué dans un contexte $`\Gamma` dont
dépend son identité même — ce qui unifie sous une seule notion de flèche ce que d'autres langages
distinguent en valeurs et en fonctions. Par le principe dual, un acteur distribué est un type défini
comme une coalgèbre terminale $`\nu G` sur son espace d'état ; la construction de cette dualité
algèbre/coalgèbre fait l'objet du chapitre 2 (§{num "sec:c2-algebres-coalgebres-et-points"}[]).

Une conséquence de cette terminalité se tire ici, le chapitre 4 s'en servant sans y renvoyer. Que
$`\nu G` soit _terminale_ signifie que toute coalgèbre admet vers elle un unique morphisme ; deux
états qui se comportent identiquement — mêmes réponses aux mêmes messages, et récursivement — ont
donc la même image, et sont par là indiscernables. Or l'environnement d'un acteur n'interagit avec
lui que par messages, c'est-à-dire à travers cette image. Il en résulte que la structure interne
d'un état n'est pas atteignable depuis l'extérieur, non parce qu'une discipline l'interdirait mais
parce que rien dans le vocabulaire de l'interaction ne permet de la nommer. C'est ce que l'on entend
en disant qu'un acteur n'expose que son comportement observable. L'isolation par types du chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]) repose sur cet énoncé : l'isolation n'y est pas ajoutée à
l'acteur, elle est ce que sa définition lui donne. L'unification de ces deux régimes — le calcul qui
termine et l'interaction qui perdure — s'opère en un unique point fixe minimal, le jugement :

::::formula (label := "eq:axiome-germinal") (kind := "equation")
```
\begin{equation}
\Delta \vdash_{\mathcal{G}} t : A \mid \mathcal{E}
\end{equation}
```
::::

qui se lit : sous le contexte $`\Delta`, dont les grades sont pris dans l'algèbre $`\mathcal{G}`, le
terme $`t` a le type $`A` et produit les effets $`\mathcal{E}`.

Deux points de lecture doivent accompagner cette équation, faute de quoi on lui comptera des
composantes qu'elle n'a pas. Ils sont arrêtés, et le reste du document s'y conforme.

_L'indice $`\mathcal{G}` n'est pas une composante du jugement._ Il nomme l'_algèbre de grades_ en
vigueur — le semi-anneau $`\mathcal{R}` et ses opérations —, dans laquelle sont pris les grades que
portent les liaisons de $`\Delta`. C'est un paramètre du système, non une donnée du jugement : deux
dérivations ne diffèrent jamais par leur $`\mathcal{G}`, et aucune règle ne le transforme. Il est
écrit là où il éclaire — sur l'axiome, et sur les spécialisations par couche, qui restreignent
précisément l'algèbre — et omis partout où il est constant, ce qui est le cas dans tout jeu de
règles. Un $`\vdash` nu et un $`\vdash_{\mathcal{G}}` dénotent donc le même jugement.

_Il n'y a pas de composante de complexité._ Une version antérieure de ce dispositif en portait une,
notée $`\mathcal{C}` ; elle a été répartie sur les composantes existantes, et le
§{num "sec:c1-de-la-loi-distributive"}[] dit où. C'est ce qui rend les contraintes de coût
vérifiables plutôt qu'affirmées, et la répartition n'est licite qu'à une condition, énoncée et
démontrée au même endroit.

Ce jugement porte _une seule zone de contexte_, quand la littérature en emploie couramment deux. La
présentation usuelle d'un calcul linéaire-non-linéaire sépare un contexte non restreint,
traditionnellement noté $`\Gamma`, d'un contexte linéaire noté $`\Delta` ; les deux zones y
marquent, sur les contextes, l'adjonction entre fragment cartésien et fragment linéaire. K7PL n'a
pas besoin de cette séparation, parce que ses liaisons portent un grade : une liaison non restreinte
_est_ une liaison de grade $`\omega`, et la zone $`\Gamma` n'en serait que la présentation à part.
On écrit donc $`\Delta_{\omega}` là où l'usage écrirait $`\Gamma`, et l'adjonction se lit sur les
grades plutôt que sur la disposition des zones — le chapitre 2
(§{num "sec:c2-la-comonade-exponentielle-et"}[]) en construit le côté cartésien et montre que la
catégorie de co-Kleisli est ce que $`\Delta_{\omega}` dénote.

Cette économie n'est pas cosmétique : elle est ce qui permet de dire que le jugement porte trois
composantes — ce que le terme exige, ce qu'il est, ce qu'il produit — et non une liste dont la
longueur devrait se justifier. Elle a un prix, qu'il faut nommer : un lecteur venu de la littérature
linéaire-non-linéaire devra reconnaître dans $`\Delta_{\omega}` ce que ses habitudes lui font
chercher sous $`\Gamma`. Le symbole $`\Gamma` reste employé, mais au sens générique d'un contexte
quelconque dans une notation catégorique — jamais comme zone du jugement.

Chacune de ces trois composantes répond aux postulats précédents, sans qu'il faille chercher entre
elles et eux une correspondance terme à terme : les postulats sont un filtre d'évaluation, non une
nomenclature dont le jugement serait la table.

Trois objets demandent alors d'être construits, et ce ne sont pas tout à fait les trois composantes.
Le type $`A` n'en demande aucune : les types sont les objets de la catégorie ambiante, et le
paragraphe qui précède l'a dit. Restent $`\Delta`, l'algèbre $`\mathcal{G}` où ses grades sont pris,
et $`\mathcal{E}`. _Ce que le terme exige se décompose ainsi en deux_ — quelles ressources il
possède, et à quel régime il les emploie —, et c'est cette décomposition, et non une quatrième
composante, que l'on rencontre lorsque le document énumère $`\Delta`, $`\mathcal{G}` et
$`\mathcal{E}`.

Deux postulats tirent ici en sens opposés, et mieux vaut le dire que le laisser découvrir. Le
premier pose que tout programme est un morphisme d'une catégorie ambiante, cadre où les objets ne
sont déterminés qu'à isomorphisme près ; celui-ci et les énoncés de représentation déterminent au
contraire une disposition binaire. {rmq}[Un cadre qui identifie à isomorphisme près, un autre qui
distingue au bit près. Les employer ensemble demande de dire lequel gouverne quoi.] _Les garanties
de représentation de ce document ne sont donc pas invariantes par équivalence de types, et c'est
délibéré_ : le premier postulat fournit le vocabulaire de composition, celui-ci fixe ce que la
machine doit rendre. Confondre les deux ferait croire qu'une équivalence de types autorise un
changement de disposition, ce qu'aucun énoncé de représentation n'admet.

: $`\Delta`

  _le contexte gradué_, où la modalité de chaque liaison est portée par son grade. Il couvre les
  trois fragments d'un seul tenant. Au grade $`\omega` — la partie notée $`\Delta_{\omega}` —, les
  scalaires et les fonctions pures se copient librement, sans qu'aucune trace de cette duplication
  n'affecte la mémoire ; c'est la modalité `Unr` du chapitre 3, réalisée au chapitre 2 comme
  catégorie de co-Kleisli. Aux autres grades siègent les ressources qui ne se dupliquent pas
  librement : ressources uniques ou partageables et abandonnables sous condition. Les canaux y
  trouvent leur place sans qu'un contexte d'interaction séparé soit nécessaire. Un canal est une
  ressource de $`\Delta`, typée par un protocole de session (chapitre 3,
  §{num "sec:c3-les-contraintes-de-valeur"}[]) — linéaire pour un point d'accès exclusif `Chan(p)`,
  affine à contraction restreinte pour un point d'accès partagé `SharedChan(p)`.

  Ce mot de _canal_ recevra trois lectures, qui n'en font qu'une prise sous trois angles. Il désigne
  d'abord un _type_ — un protocole de session, avec ses émissions, ses réceptions et ses
  branchements (chapitre 3). Il désigne ensuite un _régime d'usage_ — le grade que porte la liaison,
  dont dépend s'il est exclusif ou partageable. Il désigne enfin, sous la traduction du chapitre 4
  (§{num "sec:c4-le-calcul-de-processus"}[]), un _canal du métalangage_ muni de sa sorte. Ces trois
  lectures se recouvrent : le type est ce que le protocole prescrit, le grade est ce que le contexte
  autorise, la sorte est l'image des deux dans le calcul cible. Un lecteur qui croirait à un
  glissement de sens entre les chapitres se tromperait ; c'est le même objet, décrit par sa forme,
  par son emploi, et par son image.

  Le partage se lit alors sans mécanisme supplémentaire. Un `SharedChan(p)` n'est pas une
  construction à part mais la même ressource à un grade admettant la contraction, et son image dans
  le métalangage est le service répliqué $`!x(y).P` — celui-là même par lequel une capacité de
  lecture se traduit. Le partage d'un canal et le partage d'une région relèvent donc du même geste,
  ce que le chapitre 3 obtient pour la mémoire par l'image cartésienne de la région. Il n'y avait
  pas deux questions, il y en avait une, posée deux fois. Un motif de jonction
  $`x(u) \mid y(v) \triangleright P` n'est ainsi rien d'autre qu'un produit tensoriel $`x \otimes y`
  consommé atomiquement dans $`\Delta` — c'est-à-dire, dans le vocabulaire de la concurrence vraie
  dont procède cette lecture {cite "prattTransitionCancellationConcurrency2003"}[], une transition
  de réseau de Petri, dont plusieurs places d'entrée sont consommées d'un seul tenant. Le
  rapprochement n'est pas ornemental : c'est dans ce cadre, étendu aux réseaux colorés, qu'un
  langage concurrent d'ordre supérieur à état partagé reçoit une interprétation compositionnelle
  adéquate {cite "castellanGeometryCausalityMultitoken2023"}[]. Sa réalisation par anneaux
  verrou-libres fait l'objet du chapitre 4, Théorie des automates
  (§{num "sec:c4-echelle-du-systeme"}[]).

: $`\mathcal{G}`

  _l'algèbre des grades de ressource_, au sens de _Granule_ {cite "orchardQuantitativeProgramReasoning2019"}[] :
  des constantes — taille de tampon, profondeur de pile, nombre d'itérations — qui statifient
  l'allocation, conformément à P3. Leur système de contraintes est construit au chapitre 3
  (§{num "sec:c3-le-systeme-gradue"}[]), leur réalisation physique au chapitre 4, leur vérification
  par un solveur au chapitre 6. Un grade particulier se note $`r` et vit dans $`\mathcal{R}` ;
  $`\mathcal{G}` désigne la structure qui les organise, et jamais l'un d'entre eux.

  Un point de statut doit être fixé ici, sous peine d'un contresens que la suite rendrait coûteux.
  Le grade porte aujourd'hui quatre composantes — usage, monotonie, niveau de confidentialité,
  budget — et ce nombre n'est _pas_ un postulat. Les postulats se posent et ne se révisent pas ; le
  grade, lui, se construit au regard des postulats, et il évolue au gré de ce que la recherche
  établit et de ce que les théories antérieures livrent. Une composante nouvelle n'est donc pas une
  entorse à justifier, mais l'usage normal d'un objet ouvert.

  Encore faut-il dire à quelles conditions, faute de quoi l'ouverture se lirait comme une licence.
  Elles sont au nombre de trois, et aucune n'est nouvelle. La composante doit être une _structure
  ordonnée_. Ses opérations doivent se définir _sur chaque facteur séparément_, l'ordre du produit
  étant pris point par point. Et elle doit se placer dans l'une des trois strates du critère
  ci-après — coeffet, effet ou raffinement —, une composante de grade étant un coeffet et se
  projetant donc sur $`\Delta`. Sous ces trois conditions, rien n'est à redémontrer : le chapitre 2
  (§{num "sec:c2-adjonctions-et-enrichissement"}[]) établit que les lois de comonade graduée passent
  au produit dès lors que chaque facteur les satisfait séparément {cite "liepeltSameCoeffectDifferent2026"}[],
  et cet argument ne dépend pas du nombre de facteurs. Le procédé a d'ailleurs été pratiqué avant
  d'être énoncé : la confidentialité est une composante ajoutée après coup, et le
  §{num "sec:c1-postulats"}[] conclut qu'elle « n'ajoute rien à l'appareil » {cite "choudhuryDependentDependencyCalculus2022"}[].

  Ces trois conditions sont insuffisantes telles qu'elles sont posées, et la décomposition qui les
  remplace est proposée à la ratification. Le grade se factorise en un facteur _module_ et un facteur
  _ordre pur_ : $`\mathcal{R} = (\mathbb{U} \times \mathfrak{B}) \times (\mathbb{M} \times \mathcal{L})`, où
  $`\mathbb{U} = \mathbb{Q}_{\geq 0} \cup \{\omega\}` est l'usage, $`\mathfrak{B} = \mathbb{N}_\infty` le budget
  muni du résidu $`\ominus` continu en $`\omega`, $`\mathbb{M}` la monotonie et $`\mathcal{L}` le niveau, ces deux
  derniers agissant trivialement. Deux projections, $`\pi_{\mathrm{mod}}` et $`\pi_{\mathrm{ord}}`, en
  découlent. Sept effets suivent : les fragments du chapitre 2 sont les images réciproques
  $`\mathcal{C}_{!_{\pi_{\mathbb{U}}^{-1}(S)}}`, de sorte que singletons et intervalles coexistent ; les grades
  fractionnaires $`1/N` sont dans le noyau formel ; $`r \cdot \Delta` est défini ; le niveau d'un calcul est
  un indice distinct de $`\mathrm{niv}(r)` (§{num "sec:g-regles"}[]) ; $`\mathcal{G}_{\text{pile}}` et
  $`\mathcal{G}_{\text{budget}}` sont des images réciproques de projections ; et, surtout, la condition de
  clôture devient vérifiable par machine : une composante nouvelle est admissible si et seulement si
  elle est un module sur $`\mathbb{U}` ou un ordre pur à action triviale.

  Cette décomposition tient lieu de cadre unificateur, et ce document n'en promet pas davantage. Une
  adjonction graduée stricte, qui absorberait coeffets et effets en un seul principe, serait fausse en
  l'état : la loi distributive qui les relie n'est qu'_affaiblie_ (théorème {num "thm:loi_distributive_conditions"}[]),
  l'opération de mise à l'échelle des effets n'étant pas un morphisme de monoïde dès que $`\mathcal{E}_0` n'est
  pas commutatif. Ce que K7PL emprunte à la théorie des modes est son vocabulaire — le mode est le
  paramètre (théorème {num "thm:morphismes_modes"}[]) — et non une réécriture du chapitre autour d'une adjonction unique.

  Une conséquence de notation en découle, réglée ici plutôt que laissée à chaque chapitre. Écrire
  les composantes d'un grade sur chaque liaison est lourd, et beaucoup de liaisons n'en contraignent
  qu'une. L'_élision_ est donc autorisée : une composante non écrite prend la valeur qui n'impose
  aucune contrainte — $`\omega` pour l'usage, la marque discrète pour la monotonie, le niveau public
  pour la confidentialité. La liaison porte alors le grade complet ; seule son écriture l'abrège, et
  rien de la structure n'est touché. Le précédent est dans P2 (§{num "sec:c1-postulats"}[]), qui
  donne déjà un grade _nul_ — une valeur, non une absence — aux variables sans signification de
  ressource.

  Une composante est exclue de cette permission, et l'exclusion est de sûreté. La valeur permissive
  du _budget_ est l'infini, c'est-à-dire une allocation non bornée : élider le budget d'une liaison
  qui alloue reviendrait à dissimuler un coût par convention, ce que P3 interdit nommément. Le
  budget s'écrit donc toujours dès qu'une liaison alloue, et il ne s'élide que là où il vaut zéro —
  pour les indices, les paramètres fantômes et les bornes, qui n'allouent rien. Une dernière
  obligation accompagne le tout, et relève d'un dispositif que le chapitre 6 possède déjà. La
  convention d'élision appartient à la signification du programme, donc à la version de schéma de
  l'artefact, faute de quoi un rejeu bit à bit (P4) reposerait sur un accord tacite entre deux
  versions du compilateur.

  Ce que l'élision ne fait pas se dit aussi, la confusion serait coûteuse. Élider une composante
  n'est pas la _restreindre_ à une algèbre plus petite. Restreindre est une opération de structure
  et non d'écriture : elle produit un autre _mode_ au sens du chapitre 3
  (§{num "sec:c3-le-systeme-gradue"}[]), et il y en a trois — $`\text{Lin}`, $`\text{Aff}`,
  $`\text{Unr}` — reliés par une chaîne de morphismes. La construction en engendre quatre ; K7PL en
  instancie trois, et l'ordre de ces trois est le fragment totalement ordonné du treillis que les
  quatre forment. Il n'en ouvre pas davantage. Le motif est chiffrable : l'addition point par point
  des contextes suppose les mêmes facteurs des deux côtés, et les jointures dont dépend la cohérence
  de la subsomption (§{num "sec:g-regles"}[], théorème {num "thm:coherence_subsomption"}[]) ne sont pas garanties
  entre modes quelconques. Un besoin nouveau se satisferait par un mode _nommé_, avec son morphisme
  vers les trois autres, et non par l'ouverture d'un treillis.

  Le prix, en revanche, doit être dit avec le critère, car un critère qui n'énonce que ce qui est
  permis fait croire l'extension gratuite. Elle est _sans preuve nouvelle_, ce qui n'est pas la même
  chose. Un produit de structures ordonnées est plus large que l'ensemble des grades qu'un programme
  peut former. Chaque facteur ajouté élargit la région des grades bien formés mais non dérivables —
  que le vérificateur doit signaler comme tels plutôt que d'échouer plus loin sur une unification
  sans issue. Une dernière mise en garde sépare deux choses que le mot « paramétrer » confond
  volontiers. Une composante de grade est une coordonnée du produit et relève de ce qui précède. Une
  donnée de _mode_ — au rang de l'idéal de contraction ou du booléen d'affaiblissement du chapitre 3
  (§{num "sec:c3-le-systeme-gradue"}[]) — n'en relève pas, les opérations point par point n'ayant
  rien à dire d'une règle structurelle.

: $`\mathcal{E}`

  _les effets algébriques_ : Chaque opération observable est une algèbre initiale, chaque
  gestionnaire (_handler_) un morphisme d'algèbres (chapitre 2,
  §{num "sec:c2-algebres-coalgebres-et-points"}[]). Les effets de K7PL ne forment pas un simple
  ensemble. L'ordre dans lequel ils surviennent porte de l'information, ce qu'un demi-treillis — la
  structure des systèmes d'effets commutatifs — ne saurait retenir. $`\mathcal{E}` est donc muni
  d'une _quantale d'effets_ {cite "gordonPolymorphicIterableSequential2021"}[]. Un monoïde ordonné
  complet dont le produit, non commutatif, dénote le séquencement, et dont l'unité est l'absence
  d'effet. Son ordre est celui du treillis de précision du chapitre 2
  (§{num "sec:c2-adjonctions-et-enrichissement"}[]), de sorte que la structure exploite l'appareil
  existant au lieu de s'y ajouter.

  Les opérations que cette quantale ordonne ne sont pas des opérations algébriques ordinaires. Les
  traits qui dépendent d'une portée délimitée ou d'une ressource allouée dynamiquement — ce que fait
  constamment la couche 2, avec ses blocs et son `StreamContext` — sortent du cadre des effets
  algébriques et relèvent des _effets à portée_, dont la théorie s'obtient par traduction dans des
  théories algébriques paramétrées {cite "matacheScopedEffectsScoped2025"}[]. L'itération induite
  s'applique donc à des blocs et non à des occurrences isolées. Cette sortie du cadre algébrique a
  un prix : ce qui se perd est la _modularité_ elle-même, sur les programmes comme sur les preuves,
  un raffinement d'implantation cessant d'être transparent. Le remède connu est la surcharge
  syntaxique, donc un dispositif de résolution de nom — prix à examiner avant d'être payé, pour un
  langage qui compte déjà dix espaces de noms {cite "vanderrestHeftyAlgebrasModular2025"}[]. Et la
  portée doit être _réifiée_ : les théories algébriques paramétrées l'encodent comme une ressource
  munie d'opérations d'ouverture et de fermeture {cite "lindleyScopedEffectsParameterized2024"}[],
  la sédimentation ne faisant que dire où cette ressource vit.

  Les continuations _multiples_ sont exclues, et rien ne le disait jusqu'ici : le mot _continuation_
  ne paraît nulle part aux trois premiers chapitres. Le motif attendu — le coût de copier des
  segments de pile — n'est pas le bon, et la littérature l'écarte explicitement. La raison est
  qu'une continuation invoquée plus d'une fois brise des lois fondamentales du raisonnement : un
  bloc de code peut alors être entré une fois et quitté deux fois, et la règle de cadre n'y survit
  pas {cite "devilhenaSeparationLogicEffect2021"}[].

  La même contrainte se lit du côté de la propriété. Le corps d'un gestionnaire pouvant être appelé
  plusieurs fois, il ne peut déplacer aucune valeur de son environnement, sans quoi un programme
  emploierait deux fois la même valeur déplacée {cite "jakefecherAlgebraicEffectsOwnership2024"}[]. {rmq}[Cette
  seconde formulation vient d'un billet de conception et non d'un travail évalué. Elle vaut pour la
  mise en forme du problème, non comme autorité.] Les deux disent que la question des continuations
  et celle de la mutation n'en font qu'une. Ce qui est perdu n'est pas de l'expressivité gratuite :
  c'est le prix d'un raisonnement qui tient.

  Reste à dire comment cette algèbre communique avec celle du contexte. La structure qui en décide
  est une _loi distributive graduée_ {cite "gaboardiCombiningEffectsCoeffects2016"}[],
  transformation naturelle
  $`\lambda_{r,\varepsilon} : !_r\,T_\varepsilon \Rightarrow T_{\varphi(r,\varepsilon)}\,!_{\psi(r,\varepsilon)}`
  dont deux fonctions portent tout le contenu. $`\varphi` dit comment l'effet est modifié lorsqu'on
  le fait passer derrière la demande ; $`\psi`, comment la demande l'est lorsqu'on la fait passer
  devant l'effet. K7PL les pose ainsi.

  Une remarque sur la _force_ de cette structure, car elle en emploie moins qu'elle n'en déclare.
  Une quantale est complète, donc distributive sur les bornes supérieures _infinies_. Ce dont on se
  sert est la composition d'un effet le long d'une _suite_ finie d'opérations. La condition qui
  gouverne ce passage est connue et caractérisée : la fonction de transition d'un automate valué
  s'étend aux mots si et seulement si la multiplication distribue sur les bornes supérieures
  _finies_, c'est-à-dire si la structure est un monoïde ordonné par treillis {cite "liFuzzyFiniteAutomata2005"}[].
  La quantale a donc plus qu'il n'en faut pour ce que les règles en font, et savoir laquelle de ses
  propriétés porte l'extension est ce qui permettra, le moment venu, de ne mécaniser que celle-là.

: $`\varphi`

  il répond à une intuition simple et la formalise : _exécuter $`n` fois un calcul dont l'effet est
  $`\varepsilon` produit l'effet $`\varepsilon` répété $`n` fois_. L'itération se fait dans la
  quantale — $`\varepsilon^n`, et non $`n\cdot\varepsilon`, l'ordre du séquencement étant préservé —
  et sur le facteur temporel par multiplication, $`n` exécutions d'un calcul de $`k` pas coûtant
  $`n\,k` pas.

  Le multiplicateur demande d'être nommé pour ce qu'il est, car deux grandeurs se confondaient ici
  et ne sont pas la même. Le _grade d'usage_ $`u` d'une liaison dit combien de fois une ressource
  est employée ; la _multiplicité d'exécution_ $`n` d'un calcul dit combien de fois ce calcul est
  lancé. La signature de $`\varphi` en découle : le grade $`r` ne détermine pas la multiplicité d'exécution, qui est fournie par le combinateur de contrôle de la règle en jeu — séquencement, parcours de vecteur, opération à portée —, de sorte que $`\varphi` est une fonction _indexée_ par ce combinateur, $`\varphi_n : \mathcal{E} \to \mathcal{E}`, et non une fonction de $`\mathcal{R} \times \mathcal{E}` seule. La seconde entraîne la première — un bloc exécuté $`n` fois emploie $`n` fois chacune de
  ses ressources — mais la réciproque est fausse, et c'est la seconde qui gouverne l'itération de
  l'effet. La distinction paraît fine et elle décide de ce qu'un gestionnaire peut faire
  (§{num "sec:g-regles"}[]) : ce qui borne une réexécution n'est pas la
  discipline de ressource de la couche, mais le budget, qui la tarife. La composante de niveau agit
  d'une autre manière : elle n'itère pas l'effet, elle l'_étiquette_. Un calcul de niveau $`\ell`
  produit un effet observable au niveau $`\ell`, ce qui est le versant d'intégrité de la dualité du
  chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]) — la confidentialité contraignant ce
  qu'on lit, l'intégrité ce qu'on écrit. La composante de monotonie n'agit pas : elle contraint les
  fonctions, non les effets.

: $`\psi`

  il est l'identité partout sauf en un point, et ce point est celui qui compte. L'usage, la
  monotonie et le niveau traversent l'effet inchangés ; le _budget_, lui, en sort diminué de ce que
  l'effet a consommé — $`\beta \ominus k`, où $`k` est la composante temporelle de $`\varepsilon`.
  C'est la seule cellule où l'effet modifie la demande, et c'est aussi la seule où la soustraction
  peut échouer : un budget insuffisant rend $`\lambda` indéfinie, et la règle qui en dérive refuse
  alors la composition au lieu de la payer.

Ces appariements se lisent mieux rassemblés, et ils sont peu nombreux.

::::k7table (label := "tab:phi-psi") (align := "Z{0.97}lZ{1.17}Z{0.86}")
:::caption
Action de chaque composante du grade sur chaque composante de l'effet
:::

:::table +header
* * Composante du grade
  * sur $`\mathcal{E}_0`
  * sur $`\mathbb{N}_\infty`
  * sens de $`\psi`
* * usage $`u`
  * itération $`\varepsilon^{n}`
  * multiplication $`k \mapsto n\,k`
  * traverse inchangé
* * niveau $`\ell`
  * étiquetage par $`\ell`
  * étiquetage par $`\ell`
  * traverse inchangé
* * monotonie $`m`
  * —
  * —
  * traverse inchangé
* * budget $`\beta`
  * —
  * —
  * $`\beta \ominus k`, partielle
:::
::::

Il reste à dire ce que $`\varphi` et $`\psi` font d'un contexte, car les règles composent des
contextes et non des grades isolés. Pour deux contextes $`\Delta_1` et $`\Delta_2` dont le second
est traversé par un effet $`\varepsilon`, on pose

::::formula (label := "eq:boxtimes") (kind := "formule")
```
\begin{equation*}
\Delta_1 \boxtimes_{\varepsilon} \Delta_2 \;=\; \Delta_1 \;+\; \psi(\Delta_2, \varepsilon)
\end{equation*}
```

:::caption
La composition de contextes, définie à partir des deux fonctions de la loi distributive
:::
::::

où l'addition est celle des grades, composante par composante, et où $`\psi` s'applique liaison par
liaison. L'opérateur est donc l'addition assortie du seul transport que $`\psi` prescrit, et ce
transport ne porte que sur le budget. Deux conséquences en découlent, et elles sont ce qui rend
l'opérateur utilisable. Il est _partiel_ : si un budget de $`\Delta_2` ne couvre pas la composante
temporelle de $`\varepsilon`, $`\psi` est indéfinie et la composition est refusée plutôt que payée.
Et il est _associatif là où il est défini_, l'addition des grades l'étant et $`\psi` n'agissant que
sur une composante qui ne rétroagit sur aucune autre. L'indice $`\varepsilon` est omis lorsque le
contexte le détermine, ce que les règles font partout.

Cette manière de poser $`\varphi` et $`\psi` décide d'une question que le chapitre 2 avait laissée
ouverte. Les deux fonctions ne mêlent jamais deux composantes du grade entre elles : chacune apparie
_une_ composante du grade à _une_ composante de l'effet, et la plupart des paires sont sans
interaction. La loi se décompose donc en un produit de lois élémentaires, une par paire agissante.
Cela répond par l'affirmative à la question de savoir si une loi définie facteur par facteur se
recolle sur le produit — elle s'y recolle parce qu'elle n'a jamais été autre chose qu'un produit.
Une cellule de la table {num "tab:phi-psi"}[] mérite d'être signalée : celle qui apparie le niveau
et le temps. Qu'un $`\mathbf{tick}` soit étiqueté par le niveau du calcul qui le produit est ce qui
rend le canal temporel énonçable, et c'est là que la preuve de non-interférence devra travailler.

De cette quantale découle une opération d'_itération_ induite, qui donne son annotation d'effet à un
flux coinductif de couche 2 (chapitre 4, §{num "sec:c4-echelle-locale"}[]) et son critère à la Phase
5 du compilateur (chapitre 6, §{num "sec:c6-le-processus-de-compilation"}[]) : sans elle, une boucle
n'aurait tout simplement pas d'effet calculable. Leur intégration au système de types et leur
composition sans pile de monades sont traitées au chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) ; leur résorption statique par _inlining_, au
chapitre 6.

Ce jugement ne porte pas de composante de coût, et ce point demande à être justifié, car les
contraintes de complexité sont une exigence de ce langage et non un ornement. Elles y sont, mais
réparties, et c'est cette répartition qui les rend vérifiables plutôt qu'affirmées. C'est ici que se
lit ce qu'est devenue la composante $`\mathcal{C}` des versions antérieures, et à quelle condition
sa disparition est légitime.

Une borne de coût met en jeu trois choses distinctes que rassembler dans une même composante
confondait. Il y a ce que l'exécution _consomme_, le temps qui passe et la mémoire prise. Il y a ce
que le terme _exige_ de son environnement, un budget et une échéance à tenir. Et il y a la
_proposition_ selon laquelle la première quantité reste sous la seconde. Les deux premières sont des
grandeurs, la troisième est un énoncé sur elles. K7PL loge chacune là où elle appartient. La
consommation est un effet, inscrite dans $`\mathcal{E}` sous la forme d'une opération
$`\mathbf{tick}` dont l'occurrence marque l'écoulement ; le budget est une exigence de contexte,
inscrite dans $`\mathcal{G}` au même titre que l'usage ; et la proposition est un _raffinement_,
déchargée par le solveur du chapitre 6 comme le sont les contraintes de valeur du chapitre 3.

Un mot sur la manière dont le temps habite $`\mathcal{E}`, car deux formes étaient concevables et
l'une d'elles n'est pas praticable. On pourrait vouloir loger $`\mathbf{tick}` _à l'intérieur_ de
l'algèbre des effets. Il faudrait alors y trouver une partie commutative — le temps s'additionne
sans égard à l'ordre, quand les effets se séquencent — et donc caractériser le centre d'une
structure qui n'a pas été construite pour cela. K7PL prend l'autre voie, qui est celle qu'emploie la
littérature dès que plusieurs dimensions de coût coexistent : $`\mathcal{E}` est un _produit_,
$`\mathcal{E}_0 \times \mathbb{N}_\infty`, dont le premier facteur garde le produit non commutatif
du séquencement et dont le second est additif, l'ordre et les opérations se prenant coordonnée par
coordonnée {cite "mannucciResourceBoundedTypeTheory2025"}[]. Le facteur temporel est écrit ici
$`\mathbb{N}_\infty` pour la lecture ; sa forme complète, posée avec la grammaire des types
(§{num "sec:g-grammaire-types"}[]), est une _famille_ de coûts temporels indexée par les niveaux, qui
compte chaque événement au niveau qui l'a produit, et dont le cas mononiveau redonne la forme plate (théorème {num "thm:temps_mononiveau"}[]) : les lois de ce
paragraphe n'en changent pas. Les deux lois ne se rencontrent jamais,
puisqu'elles n'opèrent pas sur la même composante. Qu'une opération donnée porte une étiquette dans
chaque facteur — une lecture qui coûte trois pas s'écrit $`(~read~, 3)` — ne rend pas le produit
moins direct : cela fixe seulement où elle se situe dans l'un et dans l'autre.

Une distinction manque encore, et son absence confondrait un théorème avec une obligation. Entre ce
que l'exécution consomme et ce que le budget alloue s'intercale une troisième grandeur : la _borne
synthétisée_, celle que les règles de typage calculent. Trois niveaux se lisent donc sur un jugement
— le budget, qui est ce qu'on accorde ; la borne, qui est ce que le système déduit ; le coût, qui
est ce qui advient — et deux inégalités les relient, de statuts différents {cite "mannucciResourceBoundedTypeTheory2025"}[].
Que le coût reste sous la borne est un _théorème de correction_ du système d'effets, établi une fois
pour toutes ; que la borne tienne dans le budget est une _obligation_, déchargée programme par
programme. Confondre les deux reviendrait à demander au solveur ce que la métathéorie doit fournir.

Une réserve accompagne ces trois niveaux et dit ce que le système _ne_ fait pas. {rmq}[Un lecteur
pressé conclurait le contraire de ce qui précède.] Ce que l'appareil établit est une _correction_ :
le coût reste sous la borne, et la borne sous le budget. Caractériser une _classe de complexité_
demanderait en plus une *complétude* — que toute fonction de la classe soit typable —, laquelle
exige que le langage d'indices soit exactement aussi expressif que la classe. La logique linéaire
bornée caractérise le temps polynomial parce que ses indices _sont_ des polynômes, ni plus ni moins.

Le paysage compte trois positions, et ce document est hors des deux premières. La caractérisation
_sans ressource_, où la seule discipline sur les variables donne la classe sans aucune annotation,
est complète pour le temps polynomial. La caractérisation _prédicative_, qui stratifie les données
par niveaux, en donne une autre {cite "caporasoPredicativeApproachClassification2001"}[]. K7PL est
la troisième : il annote, et son annotation ne borne pas la classe. Ce n'est pas une position
faible, c'est une position _autre_ — celle d'un langage qui veut qu'un programme dise son coût, non
d'un système qui veut prouver qu'aucun programme ne dépasse un coût.

Le point qui tranche est ailleurs, et il est simple : _dans K7PL le budget est déclaré, non borné
par le système_. Un programme qui annonce un budget démesuré et le consomme est bien typé. Le
système de types borne donc chaque programme par ce que ce programme annonce ; il ne borne pas la
_classe_ des programmes typables. La gradation indexée n'y change rien : elle permet à une borne de
dépendre d'un indice de type — le nombre de $`\mathbf{tick}` d'un parcours dépend de la longueur du
tableau —, ce qui étend ce qu'on peut dire sans restreindre ce qu'on peut écrire.

Ce qu'il en coûterait se nomme, car une distinction s'y cache que l'on confond aisément.
_Dimensionner n'est pas payer._ K7PL dimensionne : l'arène est fixée au pire cas, calculé à la
compilation, et chaque écriture y est en $`O(1)` — c'est P3. Une méthode de paiement à la manière de
LFPL fait tenir au programme un jeton par cellule allouée, de sorte qu'aucun programme n'alloue plus
qu'il n'a reçu. C'est cette seconde discipline, assortie d'une preuve par réalisabilité {cite "atkeyPolynomialTimeDependent2024"}[],
qui donne une classe. La première donne une garantie par programme, la seconde une garantie sur
l'ensemble des programmes. _K7PL prend la première et ne revendique pas la seconde._

Ce choix n'est pas propre à ce document, et le dire évite de le prendre pour un aveu : les systèmes
gradués qui suivent des coûts explicites l'énoncent comme leur position — viser des budgets
explicites plutôt que des classes de complexité. La réserve ci-dessus est donc la formulation
honnête d'un choix de famille, non le constat d'un manque.

Ce que ce déplacement gagne se mesure à ce que la version antérieure de ce dispositif ne pouvait pas
faire. Une contrainte de complexité y était un prédicat portant sur une grandeur qu'aucun mécanisme
ne tenait : le solveur vérifiait un énoncé sur le temps sans que le système de types eût la moindre
trace du temps. Rien ne pouvait donc être dit du _flux_ de cette grandeur — ni qu'une durée dépend
d'une donnée qu'elle ne devrait pas révéler, ni qu'une région n'est pas bornée. Une fois la
consommation portée par un effet, ces questions deviennent des questions de type. C'est le même
geste que celui du chapitre 2 pour la monotonie (§{num "sec:c2-adjonctions-et-enrichissement"}[]) :
ce qui était vérifié au cas par cas devient porté par la structure.

La répartition demande alors sa contrepartie, donnée ici plutôt que découverte dans une preuve.
Loger le budget d'un côté du jugement et le coût de l'autre n'est licite que si les deux moitiés
_restent solidaires sous les opérations du système_. Une seule opération menace cette solidarité :
la mise à l'échelle, c'est-à-dire l'emploi répété d'un même calcul. Si l'on multiplie une exigence
sans multiplier l'effet qu'elle traverse, les deux moitiés dérivent, et il faudrait une composante
séparée pour les tenir ensemble — ce serait $`\mathcal{C}` reparaissant.

Cette condition est la _loi de cohérence_ de $`\varphi` et $`\psi` : pour tout grade $`r`, tout
contexte $`\Delta` et tout effet $`\varepsilon`, mettre à l'échelle après transport doit revenir à
transporter après mise à l'échelle, l'effet étant échelonné du même facteur. {rmq}[Le Prolégomène
pose la condition et dit où elle est acquittée. La preuve est au §{num "sec:g-regles"}[], là où la loi sert.] Elle
est démontrée au §{num "sec:g-regles"}[] (théorème {num "thm:coherence_axiome"}[]),
là où le lemme de substitution, la relation logique et la traduction l'emploient l'une après
l'autre.

Cette loi n'ajoute rien à l'appareil : elle énonce une compatibilité entre deux fonctions déjà
posées. Mais elle est ce qui autorise le jugement à ne porter que trois composantes, et elle a été
rencontrée dans trois démonstrations indépendantes — le lemme de substitution, la relation logique
de la non-interférence, et la traduction vers le métalangage. Une loi qui sert trois fois à trois
endroits appartient aux fondations.

Ce partage n'est pas propre au coût : c'est celui qui organise le jugement tout entier, énoncé ici
une fois pour toutes. La littérature distingue une lecture _comonadique_ des ressources — ce que le
terme exige de son contexte pour s'exécuter, qu'on nomme un coeffet — et une lecture _monadique_ —
ce que son exécution produit dans le monde, qu'on nomme un effet {cite "ghicaBoundedLinearTypes2014"}[].
Ces deux lectures ne sont pas juxtaposées : elles sont les deux côtés d'une même adjonction, que le
régime d'évaluation retenu ci-après rend explicite, et sur lesquels les modalités graduées du
chapitre 2 se posent respectivement {cite "torczonEffectsCoeffectsCallbypushvalue2024"}[].

Il en résulte une organisation à trois strates, qui remplace la lecture par composantes
indépendantes. La _forme_ est l'adjonction entre valeurs et calculs. La _structure_ est faite de
deux modalités graduées, l'une sur le contexte et l'autre sur le calcul : $`\mathcal{G}` gradue la
première, $`\mathcal{E}` la seconde. Les _obligations_, enfin, sont les raffinements — propositions
portant sur ce que la structure tient, et déchargées plutôt que dérivées.

Cette organisation fournit un critère de placement dont ce document se servira à chaque extension.
Toute construction nouvelle contraint ce que le calcul _demande_, et c'est un coeffet ; ou ce qu'il
_fait_, et c'est un effet ; ou elle énonce une _proposition sur son résultat_, et c'est un
raffinement. Trois réponses, trois domiciles, et aucune quatrième place à
inventer. La clôture qui en découle est _forte_ pour les données, dont la forme est fixée par les trois composantes, et _faible_ pour les actions, qu'une extension peut composer sans s'y ranger tout à fait. C'est ce
critère, plus discriminant que la simple projection sur une liste de composantes, qui donne sa forme
à la condition de clôture énoncée ci-après.

Deux précisions doivent accompagner cette organisation, faute de quoi elle promettrait plus qu'elle
ne tient. La première porte sur l'_interaction_ des deux côtés. Poser une modalité graduée sur le
contexte et une sur le calcul ne dit rien de leur rapport, et leur juxtaposition ne le donne pas.
Qu'un calcul exige deux fois une ressource _puis_ produise un effet soit ou non la même chose que
l'inverse est une question à laquelle ni la comonade, ni la monade, ni leur produit ne répondent. La
structure qui y répond est une _loi distributive graduée_ entre les deux, dont la lecture syntaxique
est une théorie équationnelle {cite "gaboardiCombiningEffectsCoeffects2016"}[]. Le chapitre 3
(§{num "sec:c3-structures-ouvertes-effets-et"}[]) en tire les règles de composition, et ce document
ne l'instancie pas au-delà.

La seconde porte sur la nature de la gradation des effets, et elle corrige une facilité. Dès lors
que le temps est un effet, l'effet d'un terme _dépend de valeurs_ : le nombre de $`\mathbf{tick}`
d'un parcours dépend de la longueur du tableau parcouru, laquelle est un indice porté par le type.
Une monade graduée ordinaire ne suffit pas à cela, et la structure requise est une monade graduée
_indexée_ — une famille de monades graduées indexée par la base, dont les monoïdes de gradation sont
eux-mêmes indexés {cite "kuraCategoryTheoreticFrameworkDependent2026"}[]. Ce n'est pas une
complication ajoutée mais la mise au jour d'une hypothèse que ce document employait sans l'avoir
posée, et le cas type qu'en donnent les auteurs est le sien : des vecteurs indexés par leur
longueur, gradués sur les conaturels.

Une borne de coût n'a de valeur qu'à stratégie d'évaluation donnée. Le régime monadique ou
comonadique n'est pas également adapté à l'appel par valeur et à l'appel par nom {cite "CICEK"}[].
K7PL retient l'appel par poussée de valeur, cadre dans lequel la sémantique des coûts effectueux se
formule uniformément {cite "EFFCOST"}[] et où la strictesse s'exprime comme un attribut de type de
nature coeffectuelle {cite "sainatiTypingStrictness2026"}[].

Ce régime rend possible l'organisation ci-dessus plutôt que seulement souhaitable. Il sépare les
valeurs des calculs et rend explicites la monade et la comonade ambiantes : graduer la suspension
par les effets latents donne la modalité de $`\mathcal{E}`, graduer le retour par les coeffets
latents celle de $`\mathcal{G}`. Un seul geste pour les deux côtés, dont la correction conjointe est
établie et mécanisée {cite "torczonEffectsCoeffectsCallbypushvalue2024"}[].

Sa vertu propre à l'architecture en trois couches va plus loin. Les deux couches polarisées ont des
stratégies optimales _opposées_ : l'appel par nom rend la récursion plus efficace, un récurseur
pouvant terminer tôt ; l'appel par valeur rend la corécursion plus efficace, un processus corécursif
pouvant s'arrêter tôt. L'écart est asymptotique et non constant {cite "downenClassicalCorecursionMechanics2023"}[].
La couche 3, récursive, favoriserait donc l'appel par nom, et la couche 2, corécursive, l'appel par
valeur. L'appel par poussée de valeur subsumant les deux, une architecture stratifiée peut n'en
sacrifier aucune.

Cette subsomption oblige en retour à dire _sous quelle stratégie_ les énoncés d'usage valent. La
propriété du pointeur unique, tirée de la correction de ressource, est jugée raisonnable pour
l'appel par nom et _moins raisonnable_ pour l'appel par nécessité {cite "chirimarReferenceCountingComputational1996"}[].
L'analyse de cardinalité qui en est le pendant moderne est prouvée correcte au regard d'une
sémantique par nécessité {cite "sergeyModularHigherOrder2017"}[]. Or la couche 2 porte des flux
paresseux. Les énoncés d'usage valent donc _par couche_, sous la stratégie que chacune fixe —
stricte en couches 1 et 3, par nécessité en couche 2 —, et non globalement. {rmq}[C'est la
stratification qui rend la réponse écrivable. Une réponse unique ne le serait pas.]

Deux conséquences suivent. La suspension coinductive de la couche 2 devient un cas régulier, le
`yield` produisant une valeur suspendue, plutôt qu'une exception à une stratégie stricte. Et une
borne de coût se lit relativement à la polarité sous laquelle l'expression est compilée : la même
expression n'a pas la même borne dans les deux régimes.

Ce choix a une troisième vertu, et c'est la plus forte des trois. Elle est restée implicite dans
tout ce qui précède alors qu'elle est l'argument de fondation le mieux établi dont ce document
dispose.

Trois propriétés sont incompatibles deux à deux dès qu'on les veut ensemble : des effets
observables, l'élimination dépendante, et un lemme de substitution. Une théorie des types qui
possède les trois est _inconsistante_, et le résultat est démontré {cite "pedrotFireTriangleHow2020"}[].
Il est possible d'en avoir deux, jamais trois. Or K7PL a les trois ingrédients apparents : une trace
d'effets, des types qui dépendent de valeurs, et un lemme de substitution démontré au §{num "sec:g-regles"}[]. Rien dans ce document ne dit pourquoi il n'est pas
visé.

Il y échappe, et il y échappe structurellement plutôt que par une clause ajoutée. Son lemme de
substitution ne substitue que des _valeurs_ : sa seconde hypothèse est un jugement de valeur et
jamais un jugement de calcul. C'est la _thunkabilité_ que la démonstration désigne comme la sortie
du triangle — et K7PL n'a pas eu à l'ajouter, puisqu'elle _est_ la séparation des valeurs et des
calculs qu'il tient de son régime d'évaluation.

Une seconde économie, plus concrète, suit du même choix. La voie des _effets comme capacités_ — où
un gestionnaire est une capacité passée plutôt qu'une portée dynamique — obtient la sûreté d'effet
au prix d'une restriction majeure. Il y faut séparer les fonctions des valeurs et traiter toutes les
fonctions comme de _seconde classe_ {cite "brachthauserEffectsCapabilitiesEffect2020"}[]. C'est ce
que l'appel par poussée de valeur donne, et sans le demander : un calcul n'y est pas une valeur, une
suspension en est une. Cette voie s'emprunte donc sans en payer le prix de la restriction, non celui de l'allocation ou de l'indirection que les suspensions réintroduisent si l'_inlining_ ne les élimine pas systématiquement, avec l'abaissement qui
l'accompagne — style à passage de capacités et continuations itérées, avec un sous-ensemble à _coût
nul_ caractérisé par un système de types plus restrictif et une preuve qu'aucune abstraction de
gestionnaire ne subsiste dans le code produit {cite "schusterCompilingEffectHandlers2020"}[].
Conception et abaissement des effets ne sont pas deux questions, et le chapitre 6
(§{num "sec:c6-le-processus-de-compilation"}[]) hérite ici du travail du chapitre 1.

Le choix de l'appel par poussée de valeur n'est donc pas une discipline d'effets commode : c'est le
seul cadre connu où les trois propriétés coexistent sans inconsistance. Un lecteur qui demanderait
pourquoi le manuscrit ne construit pas plus directement sur une théorie des types à effets ordinaire
trouve ici la réponse, et elle est de nature et non de goût.

Reste à dire _quelle_ forme de ce cadre est retenue : il en existe deux, et le prix les sépare. La
forme simple, sans extension de Kleisli pour les fonctions dépendantes, ne suffit pas à encoder
l'appel par valeur dépendant ni l'élimination _forte_ des connecteurs positifs~; elle suffit pour
l'élimination _faible_ {cite "vakarFrameworkDependentTypes2015"}[]. Or la règle de filtrage de ce
document porte le même type de conclusion dans toutes ses branches, et ce type ne mentionne pas
l'indice examiné : K7PL n'a donc que l'élimination faible, et se tient du côté qui ne paie pas. Le
jour — et seulement le jour — où un motif devra dépendre du sujet examiné, la variante enrichie
deviendra nécessaire, et son prix est connu : perte de l'unicité du typage, donc besoin de règles de
coercition. La frontière est ainsi localisée avant d'être franchie, ce qui est tout ce qu'on peut
demander à un document qui ne la franchit pas.

Un dernier trait traverse le jugement tout entier et gagne à être énoncé une fois plutôt que
redécouvert à chaque chapitre. K7PL distingue deux _phases_ : celle de la compilation, où vivent les
preuves, les indices, les paramètres fantômes, les états de typestate et les grades eux-mêmes ; et
celle de l'exécution, où ne subsiste que ce qui produit une valeur observable.

De cette distinction découle la propriété dont dépend toute la fin du pipeline, la
_non-interférence_ : le comportement entrée-sortie d'un programme ne peut dépendre de ce qui
appartient à la phase de compilation {cite "niuCostawareLogicalFramework2022"}[]. C'est elle, et non
une simple convention d'ingénierie, qui autorise la Phase 10 du chapitre 6 à purger les blocs de
spécification sans changer le programme. C'est elle aussi qui impose la règle générale du
§{num "sec:c3-les-contraintes-de-valeur"}[] — aucun éliminateur ne discrimine sur un argument
appartenant à la phase de compilation. Les cinq mécanismes d'effacement que les chapitres suivants
emploient — grades effaçables, contraintes de valeur, typestate, existentielles, purge des
spécifications — ne sont pas cinq dispositifs, mais cinq usages de celui-ci.

Cette distinction n'est pas propre à K7PL : c'est une _modalité de nécessité_, dans la lecture par
étagement où un terme sous $`\Box` est du code disponible à la compilation plutôt qu'une valeur
d'exécution. Les λ-calculs modaux qui la formalisent sont nombreux et leur sémantique catégorique
est établie de longue date {cite "kavvosManyWorldsModal2016"}[]. K7PL n'en instancie aucun
formellement — il retient la lecture, non l'appareil —, mais la non-interférence qu'il pose ici
comme propriété y découle de la structure modale elle-même, ce qui indique par où elle se
démontrerait.

Ce jugement est le point fixe minimal de K7PL. Acteur, session, entité d'un système à composants,
tableau, capacité ne sont pas des primitives distinctes du langage. Ce sont des macro-expansions de
ce même jugement, obtenues par combinaison de ses trois composantes — $`\Delta` pour ce que le terme
exige, à la fois quelles ressources il possède et à quel grade il les emploie, $`A` pour ce qu'il
est, $`\mathcal{E}` pour ce qu'il produit. Il s'ensuit une condition de clôture : toute extension
future du langage — nouveau grade, nouvel effet, nouveau protocole de session — doit se projeter sur
ces trois composantes sans en altérer la sémantique. Cette condition n'est pas une simple discipline
de conception : c'est le critère de cohérence auquel une extension se vérifie, et le partage à trois
strates ci-dessus en donne la forme opératoire — coeffet, effet, ou raffinement. Ce critère est
_suffisant_ sous une condition, et il n'est _pas nécessaire_ ; l'énoncer comme une équivalence,
ainsi que ce document l'a longtemps fait, promettait plus qu'il ne tient.

Un second geste accompagne la condition de clôture et gouverne la manière dont ce langage obtient
ses garanties. Il mérite d'être nommé ici, faute de quoi chacun de ses emplois passerait pour une
astuce locale.

Une violation est dite _inexprimable_ lorsque le terme qui la commettrait n'a pas de dérivation —
non parce qu'une règle l'interdit, mais parce qu'aucune règle ne le produit. La garantie est alors
une propriété de la grammaire et du jeu de règles, et non le résultat d'une vérification. Il n'y a
rien à détecter, rien à surveiller à l'exécution, et rien qui puisse être contourné : ce qui n'a pas
de dérivation n'a pas d'exécution.

Ce geste se retrouve à quatre endroits de ce document, et chaque fois pour la même raison. La
_duplication_ d'une ressource linéaire est inexprimable, une contraction sur un grade unitaire
n'ayant pas de dérivation (chapitre 4). La _capture_ d'un nom par une macro l'est aussi, produire
une occurrence hors de l'index de portée reçu n'étant pas typable (chapitre 5). Le _franchissement_
d'une frontière de couche l'est par la discipline des délimiteurs. Et une _obligation indécidable_
l'est parce que le langage des obligations ne permet pas de l'écrire, plutôt que parce qu'un
vérificateur la rejetterait (chapitre 4). {rmq}[Interdire demande un gardien. Rendre inexprimable
n'en demande aucun, et c'est là toute la différence de coût.]

Les quatre se lisent comme un seul énoncé : dans la fibration des dérivations sur les termes, l'ensemble
des morphismes qui commettraient la violation est vide, $`\mathrm{Hom}(-,-) = \emptyset`, parce qu'une
prémisse manque. Il s'ensuit une obligation de présentation, qui n'est pas encore remplie : chaque
famille de codes d'erreur du compilateur doit se rattacher à la prémisse manquante qui la produit,
de sorte que les familles actuelles se réduisent à quatre diagnostics, un par mécanisme.
La table qui les apparie reste à écrire.

La suffisance d'abord. Une extension qui se range dans l'une des trois strates s'exprime par
composition et tensorisation des morphismes existants, donc reste dans _C_ — c'est P1. Portant un
grade, elle porte une borne statique — c'est P3. Portant une contrainte de valeur indépendante de sa
modalité, elle respecte P2 par construction. Mais elle ne satisfait P4 qu'à une condition
supplémentaire : un effet nouveau se projette bien sur $`\mathcal{E}` tout en introduisant une
source de non-déterminisme, si rien n'oblige à la journaliser. La projection sur les trois
composantes est donc suffisante _pourvu que tout effet non déterministe soit journalisé_, et cette
clause appartient à la condition de clôture plutôt qu'à P4 seul.

La nécessité, en revanche, ne tient pas, et un contre-exemple suffit à le montrer. Une extension
probabiliste attacherait à chaque terme un poids réel, au sens du chapitre 4
(§{num "sec:c4-echelle-du-systeme"}[]). Elle pourrait satisfaire les quatre postulats sans se ranger
dans aucune des trois strates : ce poids n'est ni une exigence de contexte, ni un effet, ni une
proposition sur un résultat. Il faudrait une strate de plus, et l'axiome devrait être révisé — ce
que la clôture annonce, et non ce qu'elle interdit. Le critère délimite donc ce qui s'ajoute _sans
révision_, non ce qui reste admissible.

Sur une composante, la clôture est en outre acquise comme résultat : les types de K7PL étant des
conteneurs indexés (chapitre 2, §{num "sec:c2-adjonctions-et-enrichissement"}[]), un nombre fixe de
constructeurs suffit à toute famille strictement positive {cite "altenkirchIndexedContainers2009"}[].

Cette unification a une seconde lecture, purement calculatoire. Le fragment
$`\Delta_{\omega} \vdash \cdot`, où tout est de grade non contraint, est un $`\lambda`-calcul
linéaire pur : c'est le micro-modèle d'exécution d'une fibre. Le fragment où des grades contraints
apparaissent relève, lui, de la traduction vers un $`\pi`-calcul enrichi de motifs de jonction : celle de la couche 2 séquentielle est un fragment d'un tel calcul, acteurs, boîtes aux lettres et jonctions étant des objets de la cible et de l'abaissement — c'est le macro-modèle
des acteurs et des clusters. K7PL se résume ainsi à l'équation fondamentale
$`K7PL = (\lambda\text{-linéaire}) \subset (\pi\text{-calcul} + \text{Join Patterns})`.

Cette équation n'est pas une devise : elle nomme une traduction, et chacun de ses termes a un
correspondant construit dans les chapitres qui suivent. Un processus est un acteur, coalgèbre
terminale d'un foncteur de comportement (chapitre 2,
§{num "sec:c2-algebres-coalgebres-et-points"}[]). Un canal est une session typée, dont la dualité se
déduit du retournement des arguments de l'implication linéaire (chapitre 3,
§{num "sec:c3-les-contraintes-de-valeur"}[]). Une réception jointe est un motif de jonction,
c'est-à-dire une transition de réseau de Petri dont plusieurs places d'entrée sont consommées d'un
seul tenant. Le séquencement des actions est le produit non commutatif de la quantale d'effets, et
son itération l'opération induite. La couche 2 n'est donc pas définie par soustraction — ni pure, ni
linéaire stricte — mais par cette liste positive : c'est un calcul de processus dont ce document
construit chaque constituant avant de les nommer ensemble. La frontière est déclarée ici, faute de quoi « couche 2 » désignerait deux objets : (a) le
fragment affine du $`\lambda`-calcul gradué, dont les règles sont écrites au
§{num "sec:g-regles"}[], et (b) le calcul de processus — acteurs, canaux, boîtes aux lettres, jonctions,
arènes, supervision — que les chapitres 4 et 7 décrivent et que la traduction construit dans la cible.
Le noyau formel contient (a) et les règles de la couche 2 concurrente écrites au
§{num "sec:g-couche2"}[] ; (b) est l'image de (a) sous la traduction, non une identification du langage
source à un langage concurrent. Le chapitre 4
(§{num "sec:c4-le-calcul-de-processus"}[]) construit ce métalangage, donne la traduction et en tire
trois conséquences — le foncteur d'effacement, celui de l'échelle du système, et la voie vers la
fidélité de l'interpréteur de référence (chapitre 6,
§{num "sec:c6-strategies-de-verification-et"}[]).

L'équation se projette directement sur la sédimentation triadique introduite ci-après — emboîtement
dont le chapitre 2 (§{num "sec:c2-algebres-coalgebres-et-points"}[]) établit qu'il est bien défini sur des types non gradués — la transposition à la gradation reste à faire —,
par un théorème propre et non par la juxtaposition de ceux qui régissent chaque couche.

Reste à dire ce qui fait qu'une couche est _correcte_ — question distincte de la bonne définition de
leur emboîtement. Une couche l'est lorsque sa composition avec la couche inférieure implémente
l'interface qu'elle expose à la couche supérieure. C'est le critère des architectures à couches
d'abstraction certifiées, où une interface est une signature d'objet plus une stratégie. La
condition que les modèles antérieurs peinaient à satisfaire — l'encapsulation de l'état — est ici
acquise, les acteurs de K7PL n'exposant que leur comportement observable (chapitre 4,
§{num "sec:c4-echelle-de-l-acteur"}[]) {cite "oliveiravaleLayeredObjectbasedGame2022"}[]. Ce critère
est ici acquis plutôt que supposé : il suit de la terminalité de la coalgèbre qui définit un acteur,
comme le chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) l'établit. La projection est alors la
suivante. Le $`\lambda`-calcul linéaire correspond aux fragments cartésien et affine — couche 3 pour
la pureté, couche 2 pour la productivité. Ce sont deux restrictions structurelles l'une de l'autre,
où les ressources sont respectivement partagées ou abandonnées. Le $`\pi`-calcul et les motifs de
jonction correspondent aux synchronisations de $`\Delta` en couche 1 (linéarité stricte) et couche 2
(affaiblissement), garantissant respectivement l'absence de _data race_ non supervisée (P3) et le
déterminisme distribué (P4).

Spécialisation par couche. Le jugement germinal n'est jamais employé sous sa forme la plus générale :
chaque couche de K7PL en est une instance, obtenue en restreignant la forme admissible de $`\Delta`,
l'algèbre $`\mathcal{G}` où ses grades sont pris, et le domaine de $`\mathcal{E}`. C'est le seul
endroit du document où l'indice $`\mathcal{G}` varie, et c'est pourquoi il y est écrit. Cette
spécialisation, et elle seule, constitue la définition formelle des trois couches du langage — les
chapitres suivants n'en développeront que le contenu, jamais une strate supplémentaire de
définition.

En couche 3 (pureté mathématique), $`\Delta` se réduit à sa partie $`\Delta_{\omega}`, toute liaison
y étant de grade non contraint. $`\mathcal{E}` y est vide. Aucun $`\mathbf{tick}` n'y est même
compté, le temps d'un calcul pur relevant de son appel et non de lui. Et $`\mathcal{G}` se réduit à
l'algèbre de pile ; c'est un $`\lambda`-calcul pur au sens strict :

::::formula (label := "eq:instance-L3") (kind := "equation")
```
\begin{equation}
\Delta_{\omega} \vdash_{\mathcal{G}} t : A \qquad \left(\mathcal{E} = \emptyset,\ \mathcal{G} = \mathcal{G}_{\text{pile}}\right)
\end{equation}
```
::::

En couche 2 (orchestration), $`\Delta` se restreint à sa forme affine et $`\mathcal{E}` redevient
actif :

::::formula (label := "eq:instance-L2") (kind := "equation")
```
\begin{equation}
\Delta_{\text{aff}} \vdash_{\mathcal{G}} t : A \mid \mathcal{E} \qquad \left(\Delta_{\text{aff}} \neq \emptyset,\ \mathcal{E} \ni \mathbf{tick}\right)
\end{equation}
```
::::

En couche 1 (infrastructure), $`\Delta` se restreint à sa forme linéaire stricte et l'échéance
temporelle se lit sur les deux composantes que la répartition lui a données — un budget fini dans
les grades, un $`\mathbf{tick}` dans les effets :

::::formula (label := "eq:instance-L1") (kind := "equation")
```
\begin{equation}
\Delta_{\text{lin}} \vdash_{\mathcal{G}} t : A \mid \mathcal{E} \qquad \left(\mathcal{G} = \mathcal{G}_{\text{budget}},\ \mathcal{E} \ni \mathbf{tick}\right)
\end{equation}
```
::::

::::figure (label := "fig:specialisation-couches") (src := "specialisation-du-jugement") (alt := "Arbre à trois branches. Le jugement germinal, Delta prouve t de type A avec effet E, se specialise en trois instances de couche — couche 3 ou le contexte est omega et l'effet vide, couche 2 ou le contexte est affine avec effet actif et tick, couche 1 ou le contexte est lineaire avec budget dans le grade et tick dans l'effet.") (width := "90")
:::caption
Spécialisation du jugement germinal en trois instances de couche
:::

:::desc
Le jugement germinal et ses trois spécialisations en vis-à-vis, pour montrer ce que chaque couche
_retire_ au jugement complet plutôt que ce qu'elle y ajoute.
:::
::::

Ces trois jugements ne sont pas trois calculs différents : ce sont trois restrictions du même
calcul, obtenues en fixant la forme admissible de $`\Delta`, l'algèbre de grades $`\mathcal{G}` et
le domaine de $`\mathcal{E}`. $`\mathcal{G}_{\text{pile}}` et $`\mathcal{G}_{\text{budget}}` sont
deux sous-algèbres de $`\mathcal{R}`, non deux valeurs : par projection du produit, $`\mathcal{G}_{\text{pile}} = \mathbb{N}_\infty \times \{\mathrm{d}\} \times \mathcal{L} \times \{0\}` (budget nul) et $`\mathcal{G}_{\text{budget}} = \mathbb{N}_\infty \times \{\mathrm{d},\mathrm{m}\} \times \mathcal{L} \times \mathbb{N}_\infty`. P3 gouverne la borne synthétisée et l'admission à la bibliothèque ; il ne gouverne ni le coût de compilation ni l'amortissement interne d'un régime de mémoire, à la condition que la borne synthétisée soit sûre. La preuve que cette restriction est
conservative — qu'elle ajoute des contraintes d'usage sans altérer la sémantique dénotationnelle
sous-jacente — repose sur l'existence de foncteurs d'inclusion fidèles
$`F_{1 \to 2} : \text{Linéaire} \hookrightarrow \text{Affine}` et
$`F_{2 \to 3} : \text{Affine} \hookrightarrow \text{Cartésien}`. La construction de ces foncteurs
est différée au chapitre 2 (§{num "sec:c2-la-comonade-exponentielle-et"}[]), mais leur existence est
déjà ce qui légitime, dans tout ce document, l'emploi du terme de _sédimentation_ plutôt que de
simple juxtaposition. Cette légitimité a une réserve : le théorème de bonne définition de la sédimentation ({num "thm:sedimentation"}[]) vaut pour des conteneurs non gradués, et sa transposition à la gradation reste à faire.

Le _sens_ de cette sédimentation est un arbitrage et non une commodité d'exposition. Elle va du plus
_contraint_ vers le plus _libre_, et l'autre lecture existe : on sait recouvrer la pureté à
l'intérieur d'un langage impur, en la capturant par une comonade. Cela donne une traduction allant
en sens inverse et préservant les égalités du calcul {cite "choudhuryRecoveringPurityComonads2020"}[].
Ce document ne la retient pas, et le motif n'est pas pédagogique. Recouvrer la pureté la rend
_relative_ : elle devient ce qu'une modalité isole d'un ambiant impur, et l'ambiant reste la
référence. K7PL exige qu'elle soit _absolue_ — la couche 2 est pure par construction, non par
soustraction —, et ce qui rend cette exigence tenable est le traitement _algébrique_ des effets. Un
effet y est une opération _ajoutée_ à un calcul pur, avec sa théorie équationnelle ; il n'est pas
une propriété ambiante dont il faudrait se déprendre. La pureté n'a donc rien à recouvrer,
puisqu'elle n'a rien perdu.

Deux conséquences suivent de ce choix, et elles se lisent partout dans la suite. La première est que
les trois foncteurs sont des _inclusions_ et non des rétractions : on monte vers le libre en
oubliant une contrainte, on ne descend pas vers le pur en capturant quelque chose. La seconde est
que la charge de la preuve change de camp. Dans la lecture inverse, il faudrait démontrer que la
modalité capture bien _toute_ la pureté. Ici, il faut démontrer qu'ajouter une opération ne détruit
rien de ce qui était acquis — ce que la théorie des effets algébriques établit, et ce que ce
document n'a donc pas à refaire.

::::k7table (label := "tab:sedimentation") (align := "lZ{1.05}lZ{0.87}Z{1.08}")
:::caption
Sédimentation triadique : fragments logiques, couches et garanties
:::

:::table +header
* * Fragment
  * Règles structurelles admises
  * Couche
  * Mécanisme catégorique
  * Garantie principale
* * Cartésien
  * Contraction et affaiblissement
  * Couche 3
  * Algèbres initiales $`\mu F`
  * Terminaison, référentialité
* * Affine
  * Affaiblissement seul
  * Couche 2
  * Coalgèbres terminales $`\nu F`
  * Productivité, effets maîtrisés
* * Linéaire
  * Aucune
  * Couche 1
  * Capabilités sous $`\otimes`
  * Ressources uniques, supervision
:::
::::

La table {num "tab:sedimentation"}[] n'anticipe qu'un résultat ; chacune de ses colonnes sera
reconstruite en son lieu propre — le mécanisme catégorique au chapitre 2, la garantie formelle au
chapitre 3 pour ce qui concerne les valeurs, au chapitre 4 pour ce qui concerne l'exécution. Elle donne
la lecture par _singletons_ de l'usage : ses trois lignes sont les fragments
$`\pi_{\mathbb{U}}^{-1}(\{\omega\})`, $`\pi_{\mathbb{U}}^{-1}(\{0,1\})` et $`\pi_{\mathbb{U}}^{-1}(\{1\})`, images
réciproques de singletons de $`\mathbb{U}` par la projection de la décomposition ci-dessus ; les modalités de type du
chapitre 3 sont, elles, des intervalles, que la table ne liste pas et dont ces trois fragments sont des cas
particuliers.

Deux lectures s'y ajoutent, qui ne se voient pas au premier passage et dont le reste du document se
sert. La première est que la sédimentation ne fait pas qu'_ordonner_ des garanties : elle
_accueille_ ce que la couche supérieure refuse. Ce qui n'entre par aucune des trois portes de
terminaison ne disparaît pas du langage, il descend en couche 2 comme effet ou comme processus.
C'est cette lecture de recours qui rend la stratification utile au programmeur, et non seulement au
métathéoricien : la couche inférieure n'est pas un fragment dégradé, c'est le lieu où va ce qui ne
se prouve pas plus haut.

La seconde tient dans la quatrième colonne, et elle porte plus loin qu'une correspondance. Les
algèbres initiales $`\mu F` sont en couche 3, les coalgèbres terminales $`\nu F` en couche 2 :
_l'axe de sédimentation est l'axe de polarité_. La couche ne dit donc pas seulement quelles règles
structurelles sont admises, elle dit si l'on est du côté inductif ou du côté coinductif — et par
conséquent laquelle des deux garanties duales, terminaison ou productivité, est celle qu'on doit
établir. Le chapitre 2 (§{num "sec:c2-algebres-coalgebres-et-points"}[]) en fait le paramètre d'un
théorème unique plutôt que d'en écrire deux, et le chapitre 4 (§{num "sec:c4-echelle-locale"}[]) en
tire son vocabulaire d'exécution. Une limite s'y lit du même coup : la couche 1 n'est ni $`\mu` ni
$`\nu`, et l'axe de polarité ne court donc que sur deux des trois couches.

Une voie reste ouverte du côté de la construction. Cette table présente la sédimentation comme une
_lecture_ — trois fragments d'une même catégorie, reliés par des inclusions fidèles. Elle pourrait
recevoir une _construction_ : la littérature des automates catégoriques bâtit des classes obtenues
en _recollant_ plusieurs régimes en une catégorie unique, avec la minimisation acquise par
conception plutôt que démontrée après coup {cite "colcombetAutomataCategoryGlued2017b"}[]. La
construction n'exige pas la structure linéaire de son exemple principal — elle est énoncée pour un
couple quelconque d'une catégorie et d'une sous-catégorie — et ce qu'elle demande à la place est un
_système de factorisation à travers_ cette sous-catégorie. Le motif de cette notion généralisée est
celui-là même qui intéresserait ce document : elle existe pour les sous-catégories closes par
quotients mais non par sous-objets, ce qu'un fragment substructurel est plausiblement. L'obligation
est donc concrète, et elle n'est pas remplie ici.

La table se prolonge enfin par la table {num "tab:dimensions"}[], qui décline cette même
stratification sur les axes d'ingénierie du langage :

::::k7table (label := "tab:dimensions") (align := "lZ{0.80}Z{1.13}Z{1.07}")
:::caption
Correspondance des dimensions d'ingénierie par couche
:::

:::table +header
* * Dimension
  * Couche 1 (Infrastructure)
  * Couche 2 (Orchestration)
  * Couche 3 (Pureté mathématique)
* * Paradigme
  * Fonctionnel bas niveau
  * Fonctionnel faible
  * Fonctionnel total
* * Syntaxe
  * `{ }`
  * `( )`
  * `[ ]`
* * Effets
  * Tous, supervisés
  * Explicites, algébriques
  * Aucun
* * Terminaison
  * Non garantie, supervisée
  * Productivité coinductive
  * Garantie par preuve statique
* * Mutation
  * Contrôlée par ownership
  * Indirecte, via effets
  * Interdite
* * Données
  * Mutables, sous ownership
  * Immuables, transitant par canaux mutables
  * Immuables (CoW si propriétaire unique)
* * Namespace
  * Lisp-2 (espaces séparés)
  * Contextuel, Lisp-1
  * Unique (tous les morphismes)
* * Mémoire
  * Arènes linéaires et ownership
  * Tas sous ownership et régions
  * Pile et régions, pointeurs tagués
* * Récursion
  * Bornée, supervisée
  * Bornée (statique ou coinductive)
  * Interdite (plis, balayages, réductions)
* * Branchement
  * `match~/~cond` (dispatch)
  * `match~/~cond` (dispatch)
  * `select` vectoriel (dispatch)
:::
::::

Ce tableau expose sous forme synoptique ce que la suite se donne pour tâche de justifier point par
point : que la stratification en trois couches n'est pas un empilement de conventions syntaxiques.
Mais la trace visible d'une seule structure catégorique vue sous trois degrés de restriction. C'est
cette trace que les chapitres 2 à 6 reconstruisent, chacun depuis son point de vue propre —
catégorique, typologique, automatique, syntaxique, calculatoire — avant que le chapitre 7 n'en
éprouve la cohérence sur des cas d'usage complets.
