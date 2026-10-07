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

#doc (Manual) "Les contraintes de valeur" =>
%%%
file := "c3-les-contraintes-de-valeur"
tag := "c3-les-contraintes-de-valeur"
%%%

{label "sec:c3-les-contraintes-de-valeur"}

Deux filiations gouvernent cette section. Les types liquides de Rondon, Kawaguchi et Jhala
établissent qu'un raffinement reste décidable si sa vérification est déléguée à un solveur plutôt
qu'intégrée à l'unification — c'est le partage que K7PL reprend entre le narrowing et la Phase 7
(chapitre 6). Le tracé exact de ce partage est assumé pour ce qu'il est : il ne suit d'aucune
nécessité logique. Certaines contraintes de taille se vérifieraient par narrowing au prix
d'annotations supplémentaires, certaines existentielles se délégueraient au solveur. Le critère
retenu est empirique et gouverné par P3 — reste au narrowing ce dont le coût de vérification est
prévisible sans recherche, part au solveur ce qui exige une exploration dont la durée ne se borne
pas syntaxiquement.

Les types dépendants pragmatiques de Xi et Pfenning montrent qu'une fraction utile de la dépendance
— tailles, indices — se vérifie sans les coûts d'annotation de la dépendance générale. C'est cette
fraction, et non le calcul des constructions, que ce chapitre adopte. Deux langages récents
confirment que l'économie n'est pas propre à K7PL : Futhark obtient la mise à jour en place d'un
tableau immuable par une simple analyse d'unicité, Dex élimine les vérifications de bornes par des
indices typés sans recourir à la dépendance complète.

Une contrainte de valeur ne dit rien de la modalité d'une ressource ; elle restreint ce que son
contenu peut légitimement être — une taille, un intervalle, un état, un protocole, une dimension
physique.

Un cas est à écarter de cette liste, où il figurait naguère sans y appartenir : la
_confidentialité_. Le niveau de sécurité d'une valeur n'est pas une contrainte sur son contenu mais
sur son usage — qui peut la lire, et ce qu'il peut en dériver —, et le chapitre 2
(§{num "sec:c2-adjonctions-et-enrichissement"}[]) le loge donc là où il appartient, dans le grade,
comme modalité sur un treillis de niveaux. Le distinguer importe, parce qu'un raffinement se
décharge au cas par cas quand un grade se propage par les règles.

Ces contraintes, en apparence hétérogènes, ne se distinguent que par le moyen de leur vérification.
Certaines s'établissent directement dans le système de types, sans engager de calcul supplémentaire.
D'autres délèguent la preuve à un solveur externe. D'autres enfin ne sont pas des propriétés fixes
mais des états qui évoluent, et se vérifient comme des automates. Dans tous les cas, une fois
établie, la contrainte disparaît du binaire — c'est la même exigence d'effacement que le chapitre 2
imposait à la modalité (P3), appliquée cette fois à la valeur.

Cet effacement n'est cependant pas gratuit. Abel, Danielsson et Eriksson {cite "abelGradedModalDependent2023"}[]
établissent que la correction d'une fonction d'extraction n'est acquise que pour une classe
restreinte de modalités. Sur les programmes ouverts, trois réserves conjointes s'y ajoutent : toutes
les variables du contexte effaçables, contexte cohérent, et filtrage interdit sur un paquet dont le
témoin est effacé. Lever cette dernière suffit à perdre la canonicité, contre-exemple à l'appui.
K7PL adopte ces trois réserves comme conditions de sa propre garantie d'effacement, la troisième
prenant la forme d'une restriction sur les existentielles
(§{num "sec:c3-structures-ouvertes-effets-et"}[]). Une voie alternative existe, qui encode
l'effacement comme distinction de phase et en tire la conservativité sur la théorie des types
sous-jacente {cite "THEOCHARIS"}[]. Ce document ne l'emprunte pas, mais elle reste disponible si la
restriction du §{num "sec:c3-structures-ouvertes-effets-et"}[] se révélait trop coûteuse.

Les contraintes de taille en sont l'illustration la plus directe : `Vector(n, T)` n'introduit aucun
mécanisme propre, elle réutilise l'isomorphisme $`\text{Hom}(\text{Fin}(n),T) \cong \text{Vec}(n,T)`
établi au chapitre 2 (§{num "sec:c2-adjonctions-et-enrichissement"}[]). Cet isomorphisme fixe la
sémantique du type, non sa représentation machine : celle-ci relève de l'abaissement (chapitre 6,
§{num "sec:c6-le-processus-de-compilation"}[]), et le choix d'empaqueter une représentation
d'exécution efficace avec des invariants effaçables reste explicite — c'est à cette condition que la
complexité de la structure résultante demeure prévisible, comme P3 l'exige {cite "allaisBuiltinTypesViewed2023"}[].
L'accès `(arr i)` porte la contrainte $`0 \le i < n` ; le compilateur en prouve la validité, ou la
transforme en `Result(T, OutOfBounds)` lorsque la preuve échoue — jamais une vérification dynamique
silencieuse. Les dimensions physiques (types SI, `Velocity = Length / Time`) suivent le même
principe par des paramètres fantômes : la contrainte est vérifiée puis intégralement effacée, sans
laisser au binaire final la moindre trace de son unité.

Lorsque la contrainte ne se laisse pas encoder aussi directement, K7PL délègue. Un type de
raffinement `{x : T | p}` engage une obligation de preuve résolue par le solveur SMT du chapitre 6,
sur des théories dédiées : `K7PL.Map` pour les cartes finies, `K7PL.SI` pour les dimensions
physiques, `K7PL.Age` pour l'ordre linéaire des destinations. Des lemmes explicites la guident si
nécessaire. Lorsque le prédicat porte sur les valeurs _internes_ à une structure — les éléments
d'une carte, les composantes d'un CRDT composé —, ces lemmes ne sont pas facultatifs. Ils sont les
principes d'induction profonde du type porteur {cite "johannDeepInductionInduction2020"}[], sans
lesquels l'obligation reste indéchargeable quel que soit le solveur. Le sous-typage entre deux
raffinements de même support n'est alors rien d'autre qu'une implication logique entre leurs
prédicats, vérifiée automatiquement.

Une famille de contraintes s'ajoute à celles-ci lorsque le prédicat porte sur une ressource
consommée plutôt que sur une valeur : l'annotation de potentiel, portée par la déclaration d'un type
de données et indiquant comment le potentiel s'y répartit. Elle n'est pas un ornement. L'analyse
automatique de ressources échange l'automatisation contre la flexibilité — les techniques
entièrement automatiques se restreignent à des familles de bornes contraintes, les bornes
dépendantes des valeurs relevant sinon de preuves écrites à la main —, et c'est l'annotation de
potentiel qui permet de sortir de ce dilemme {cite "knothLiquidResourceTypes2020"}[]. K7PL ne peut
donc revendiquer simultanément l'automatisation complète des bornes de coût, trois familles de
bornes hétérogènes selon la couche, et l'absence de toute annotation de ressource. L'inférence des
bornes n'est automatique que sur les familles que le solveur atteint, et une borne dépendante d'une
valeur demande une annotation.

Ces conditions se laissent ramener à une règle unique, et c'est sous cette forme que K7PL la retient :
_aucun éliminateur ne discrimine sur un argument appartenant à la phase de compilation_ — ni
projection existentielle sur un témoin effacé, ni `match` sur un paramètre de typestate, ni `cond`
sur un paramètre fantôme. La règle n'est pas une précaution locale : c'est ce qui rend la
non-interférence du §{num "sec:c1-axiomatique-germinale"}[] démontrable plutôt que postulée. Sa
nécessité est établie. Sans elle, un terme construit par élimination sur une donnée effacée cesse de
se réduire vers une valeur canonique {cite "DANIELSSON-ERASED"}[] ; et les cadres qui autorisent
davantage doivent restreindre ailleurs, en cantonnant certains constructeurs au code de compilation {cite "ABEL-VEZZOSI"}[].
La question symétrique — quand une valeur effacée peut-elle être ressuscitée ? — reçoit la réponse
habituelle : seulement sur un type _stable_ au sens de {cite "DANIELSSON-ERASED"}[], c'est-à-dire un
type dont un habitant se reconstruit depuis sa version effacée.

Son _statut_, en revanche, est moins bon que son contenu, et se corrige ici. Elle est ici une règle
à faire respecter, vérifiée cas par cas — trois interdictions énumérées et une quatrième à ajouter
le jour où un quatrième éliminateur apparaîtra. Une distinction de phase _synthétique_ fait mieux :
la phase y étant une proposition du contexte, la discrimination n'est pas interdite, elle est
_inexprimable_, et la conservativité dans les deux phases s'en déduit au lieu d'être vérifiée {cite "THEOCHARIS"}[].
La règle devient alors une conséquence de l'encodage plutôt qu'une condition de bord, ce qui est la
transformation que ce document a opérée ailleurs pour l'hygiène — passer d'une discipline appliquée
à une propriété du type. Le contenu ne change pas ; ce qui change est qu'il n'y aura plus de liste à
tenir à jour.

Une troisième famille de contraintes ne porte pas sur une valeur figée mais sur son évolution. Le
typestate est un paramètre de type qui suit une grammaire d'états — `File(Open)`, `File(Closed)` —
chaque transition validée par unification de ce paramètre, sans le moindre coût à l'exécution. La
règle ci-dessus en fixe le prix, et il faut l'écrire : un typestate se vérifie, il ne se filtre pas.
Un programme qui aurait besoin de brancher à l'exécution sur l'état d'un fichier doit porter un tag
explicite, lequel appartient alors à la phase d'exécution et cesse d'être gratuit. C'est le seul
point où l'effacement de K7PL restreint ce que le développeur peut écrire, et il le restreint dans
le sens de ce que le paragraphe précédent revendique. Un type de session n'en est que la version
distribuée : le même automate, sauf que ses transitions sont déclenchées par l'échange de messages
entre deux extrémités plutôt que par des appels locaux.

::::figure (label := "fig:session-automate") (src := "session-protocol-as-automata") (alt := "Automate a deux etats. De EXPECT_INT part la transition send de Int vers EXPECT_BOOL, d'ou part la transition recv de Bool vers l'etat final.") (width := "90")
:::caption
Un protocole de session comme automate à états
:::

:::desc
Un protocole vu comme la suite de ses états, avant que le
§{num "sec:c3-les-contraintes-de-valeur"}[] ne le relise comme un échange entre deux extrémités.
:::

:::note
L'automate représenté est celui du protocole `Send(Int, Recv(Bool, End))`.
:::
::::

Chaque extrémité d'un canal de session est une ressource linéaire de $`\Delta` (chapitre 2,
§{num "sec:c2-la-comonade-exponentielle-et"}[]), et le protocole qu'elle porte s'accompagne de son
dual — à un `Send(T,P)` correspond nécessairement un `Recv(T,P^⊥)` du côté opposé. Cette dualité
n'est ni une hypothèse ni même une définition : elle est une _conséquence_, et c'est ce qui permet à
ce chapitre de n'ajouter aucun constructeur de type.

La grammaire ci-dessus — $`\mathsf{Send}`, $`\mathsf{Recv}`, $`\mathsf{select}`, $`\mathsf{offer}`,
$`\mathsf{End}` — est une _syntaxe de surface_. L'élaboration la traduit en emboîtements
d'implications linéaires, seule construction que le chapitre 2 ait eu à fournir
(§{num "sec:c2-la-categorie-ambiante"}[]). La dualité tombe alors du retournement des arguments :
$`\tau_1 \multimap \tau_2` est dual de $`\tau_2 \multimap \tau_1`, *le constructeur de fonction
linéaire étant dual de lui-même*. Émettre et recevoir sont les deux lectures d'une même flèche,
selon le côté où l'on se tient. Il n'y a pas d'involution à définir, pas de squelette à munir de
duaux, pas de théorème d'adéquation à démontrer entre une involution syntaxique et une négation
catégorique. C'est la démarche minimale attestée pour ajouter des sessions à un $`\lambda`-calcul
linéaire, où l'on obtient absence de blocage et progrès global du seul système de types linéaire,
par des preuves plus courtes que celles des systèmes à constructeurs dédiés {cite "jacobsSelfDualDistillationSession2022"}[].
Un bénéfice second, et il n'est pas mince : l'ambiante _C_ n'a besoin d'aucune négation. Elle reste
une catégorie monoïdale symétrique close, cadre dans lequel les exponentielles du
§{num "sec:c2-la-comonade-exponentielle-et"}[] sont parfaitement définies — la structure sans
négation de la logique linéaire multiplicative supporte $`!` et $`?`, la relation de De Morgan y
étant remplacée par la force tensorielle {cite "bluteStorageTensorialStrength1996"}[].

Le motif est celui que la condition de clôture du chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) impose : toute extension doit se projeter sur les
composantes existantes plutôt que d'en ajouter. Faire des cinq formes de protocole autant de
constructeurs primitifs y contreviendrait — cinq primitives, une définition de dualité, une
structure catégorique et un théorème là où $`\multimap`, présent depuis le
§{num "sec:c2-la-categorie-ambiante"}[], suffit.

Une dette naît de ce choix : la préservation des types par cet encodage est établie dans la
littérature pour la grammaire de GV, non pour celle de K7PL. Ce document la revendique et ne la
démontre pas.

Deux hypothèses tombent avec cet encodage. La première voulait que _C_, restreinte aux objets
utilisés dans les protocoles, fût $`\ast`-autonome — formulation dont le quantificateur portait au
surplus sur les charges utiles, que la dualité ne touche pas, K7PL n'ayant pas de délégation de
session. La seconde, qui l'avait remplacée, munissait un squelette fini de duaux choisis. Ni l'une
ni l'autre n'a plus d'objet : il n'y a pas de squelette, seulement des flèches.

Cette absence de délégation situe par ailleurs K7PL sur le clivage qui sépare les interprétations de
la logique linéaire en types de session. Les présentations classique et intuitionniste ont engendré
des courants distincts, dont la comparaison formelle est récente, et le trait qui les départage est
le _principe de localité_ — imposé par les interprétations intuitionnistes, non par les classiques {cite "VAN-DEN-HEUVEL"}[].
Aucun message de K7PL ne transportant d'extrémité de canal, la localité y est satisfaite par
construction : le langage se range du côté intuitionniste, où la dualité n'a pas besoin de la forme
classique la plus forte.

Reste un comportement que le chapitre 4 pratique et que ce chapitre ne type pas. Une session peut
être abandonnée — le `Timeout` et le _circuit breaker_ du §{num "sec:c4-echelle-du-systeme"}[] le
font —, et la grammaire ci-dessus décrit des protocoles qui ne peuvent pas échouer. L'écart se
comble sans quitter le cadre : la logique linéaire classique s'étend conservativement de deux
modalités duales capturant une (co)monade additive, ce qui accueille non-déterminisme et abandon en
garantissant globalement progrès et fidélité {cite "cairesLinearityControlEffects2017"}[]. Le
résultat est cité pour la _forme_ de l'extension, non pour son cadre : K7PL travaille en logique
linéaire _intuitionniste_, et le chapitre 4 (§{num "sec:c4-echelle-du-systeme"}[]) dit pourquoi —
c'est de là que vient la localité des noms partagés, qu'il revendique comme structurelle.
Transporter l'extension au cadre intuitionniste est donc une obligation et non un acquis, et elle
est consignée comme telle. K7PL ne conduit pas cette extension ; il la nomme, et son encodage dans
$`\multimap` ne s'y oppose pas.

Une limite du régime asynchrone doit être connue avant d'être rencontrée. Le sous-typage de K7PL est
_modal_ — il relie les trois fragments d'usage (chapitre 1) — et ne porte pas sur les protocoles.
S'il devait un jour s'y étendre, il buterait sur un résultat établi : la vérification du sous-typage
asynchrone est indécidable, et les algorithmes déployés dans les outils existants sont corrects sans
être complets {cite "ekiciFormalisingAsynchronousSession2026"}[]. C'est une frontière du langage,
non un défaut du présent document ; elle est énoncée ici pour que le choix du régime asynchrone soit
fait en connaissance de ce qu'il ferme.

Un dernier point doit être fixé, que ce document laissait ouvert et dont la preuve d'absence de
blocage dépend : les sessions de K7PL sont _asynchrones_. Un `Send` dépose dans une boîte aux
lettres et rend la main ; un `Recv` bloque sur une boîte vide, non sur l'absence d'un correspondant
prêt. Ce régime est celui que le chapitre 4 met en œuvre par anneaux verrou-libres
(§{num "sec:c4-echelle-du-systeme"}[]), et le déclarer ici évite que le chapitre 3 raisonne en
rendez-vous pendant que le chapitre 4 transporte par messages. L'écart entre les deux régimes n'est
pas une nuance d'implémentation : c'est un écart sémantique, dont le franchissement demande un
encodage explicite par protocoles d'appel-retour {cite "castellanTwoSidesSame2019"}[]. Le graphe des
sessions ainsi obtenu doit être acyclique ; c'est cette même construction, réalisée matériellement,
qu'un runtime L1 vérifie par comparaison d'un simple tag d'état à l'exécution (chapitre 4).

Un protocole se déclare en couche 1 comme un arbre de transitions, dont le compilateur dérive
automatiquement la dualité client/serveur ({num "lst:protocole-oauth"}[]) :

::::listing (label := "lst:protocole-oauth")
:::caption
Un protocole de couche 1, dont le compilateur dérive la dualité client/serveur
:::

```
{defprotocol oauth-flow
  (send Credentials
    (offer (:success (recv Token end))
           (:denied end)))}
```
::::

Un raccourci est à écarter avant l'énoncé, car il commande la forme que celui-ci prend. Les sessions
étant asynchrones (§{num "sec:c3-les-contraintes-de-valeur"}[]), un `Recv` ne bloque pas sur
l'absence d'un `Send` correspondant mais sur une boîte aux lettres vide. La dualité garantit qu'un
`Send` est typé de l'autre côté, elle ne garantit pas qu'il ait été émis, l'émetteur pouvant être
lui-même bloqué sur un troisième canal. Un contre-exemple d'une ligne suffit à le montrer, et
explique du même coup pourquoi l'acyclicité est nécessaire : trois participants deux à deux duaux,
chacun attendant du suivant avant d'émettre vers le précédent, forment un cycle qui bloque {cite "horneSessionSubtypingMultiparty2020"}[].
La dualité établit la bonne formation des protocoles, jamais la progression, et c'est pourquoi elle
assure la fidélité de session et la sûreté de communication mais non l'absence de blocage mutuel {cite "thiemannLabeldependentSessionTypes"}[].
L'hypothèse d'acyclicité fait ici tout le travail, et figure à ce titre dans l'énoncé plutôt que
dans la preuve.

Deux appuis techniques valent d'être nommés avant la preuve, puisqu'ils bornent ce qu'elle suppose.
Le premier est que l'élimination des coupures y porte sur le seul fragment multiplicatif de la
logique linéaire — celui qu'engendrent les types de session — et non sur la logique linéaire
intuitionniste entière, dont la recherche de preuve certifiée est un problème à part entière {cite "ALLAIS-MCBRIDE"}[].
Son admissibilité n'a d'ailleurs pas à être supposée, puisqu'elle s'obtient indépendamment de la
théorie des modes dans les cadres qui paramètrent produits et implications — ordonnés, linéaires,
affines, cartésiens — par une telle théorie {cite "licataFibrationalFrameworkSubstructural2017"}[].
Le second est que la preuve procède par coinduction sur le dépliage plutôt que par induction sur la
structure, un graphe se laissant mieux traiter comme structure coinductive dès le départ, les
algorithmes de graphes n'étant pas structurellement récursifs dans leurs présentations usuelles {cite "kidneyFormalisingGraphAlgorithms2025"}[].

::::thm (label := "thm:deadlock_acyclique")
:::title
absence de deadlock par acyclicité du graphe de sessions
:::

:::statement +titled
Absence de blocage mutuel

Soit un réseau d'acteurs $`N` dont les canaux sont typés par des protocoles de session duaux au sens
qui précède, _et dont le graphe de dépendances est acyclique_ au sens du chapitre 4
(§{num "sec:c4-echelle-de-l-acteur"}[]). Alors $`N` n'atteint jamais d'état de blocage mutuel.
:::

:::proofsketch
Le jeton linéaire `Lin(SessionEndpoint)` force la progression : une session ne peut être abandonnée,
elle doit atteindre `end` ou traiter un `Timeout`. Le graphe de dépendances est acyclique par
vérification en Phase 2, un cycle produisant `ERR-ARC-001`. Par tri topologique de ce graphe
(chapitre 2, théorème {num "thm:tri_topologique"}[]) et élimination des coupures sur le fragment
multiplicatif, il existe toujours une communication réductible : une progression possible plutôt
qu'une attente circulaire. L'énoncé porte sur les états atteignables et se prouve donc par
coinduction sur le dépliage, l'acyclicité du câblage étant l'invariant qui l'amorce : aucun état
atteignable ne présente de cycle dans la relation « attend un message de ». L'étape de préservation
est ce que cette esquisse doit encore établir, et elle se réduit à un énoncé unique — la _simulation
du graphe d'attente_ : pour tous acteurs $`a` et $`b` et tout état atteignable, si $`a` attend un
message de $`b`, alors l'arête $`(a,b)` est au graphe de câblage. Sous cette simulation, tout cycle
d'attente serait un cycle de câblage, et l'acyclicité vérifiée en Phase 2 conclut.

_Cette simulation n'est plus un emprunt._ Depuis que la couche 2 a ses règles (§{num "sec:g-regles"}[],
§{num "sec:g-couche2"}[]), le graphe de câblage n'est plus un objet posé au-dehors : il est celui
des dépendances entre boîtes aux lettres, que le jugement porte. Une attente est une instance de {sc}[Guard]
sur une boîte, et la boîte y est une liaison du contexte ; l'arête d'attente est donc une arête de
dépendance par construction du typage, et non par une hypothèse à honorer. Ce qui était la prémisse
manquante de cet énoncé est devenu une lecture de ses règles.
:::
::::

Deux graphes sont en jeu, et les confondre serait l'erreur à ne pas commettre. {rmq}[Le câblage est
donné, l'attente se déplie. Traiter le second comme le premier reviendrait à lire un objet
coinductif par induction.] Le graphe de câblage du §{num "sec:c4-echelle-de-l-acteur"}[] est donné
en entier à la compilation : fini, statique, il se traite inductivement, et le tri topologique de la
Phase 2 en établit l'acyclicité une fois pour toutes. Le graphe d'attente à l'exécution se déplie
au fil des activations et n'est jamais donné. L'acyclicité du premier n'implique donc pas
mécaniquement celle du second, et c'est pourquoi l'énoncé porte sur les états atteignables et non
sur le câblage.

L'absence de blocage mutuel est donc une propriété de compilation, et non une promesse
conditionnelle : le tri topologique de la Phase 2 la décide, et aucun mécanisme d'exécution —
détection de cycle, temporisation globale — n'a à la surveiller. S'il tombe, la garantie retombe sur
le `Timeout`, c'est-à-dire sur une détection à l'exécution, ce qui la ferait sortir du système de
types et rentrer dans le coût.

::::figure (label := "fig:session-dualite") (src := "session-protocol-as-dual-exchange") (alt := "Le meme protocole vu comme un echange entre deux extremites. L'extremite A porte Send de Int puis Recv de Bool puis End, l'extremite B porte Recv de Int puis Send de Bool puis End. Deux fleches croisees figurent l'envoi de l'entier puis celui du booleen ; une note rappelle que les deux extremites se terminent ensemble.") (width := "75")
:::caption
Le même protocole, lu comme échange dual entre deux extrémités
:::

:::desc
Le protocole précédent vu depuis ses deux bouts, pour montrer que la dualité ne complète pas le type
mais le relit.
:::
::::

Quand une contrainte de valeur échoue, K7PL distingue trois régimes plutôt qu'un seul. Un état
illégal viole un invariant que le système de types rejette avant même la génération de code —
l'accès hors bornes prouvé impossible en est un cas. Un état indésirable atteint l'exécution mais
reste un échec ordinaire, représenté par un `Result`. Un état transitoire, enfin, n'est l'échec de
rien : une condition temporaire — un tampon plein — résorbable par un gestionnaire, modélisée comme
un effet algébrique (chapitre 2, §{num "sec:c2-algebres-coalgebres-et-points"}[]) plutôt que
confondue avec une erreur définitive. La théorie des roues instancie ce premier régime pour
l'arithmétique : une opération invalide ($`0/0`) ne lève pas d'exception mais produit une
singularité — $`\bot`, $`\infty`, $`\circ`, $`\delta`, constructeurs d'un type algébrique `Wheel<T>`
distinct du flottant IEEE 754 sous-jacent, dont la conversion reste explicite dans les deux sens. Les deux
premières viennent de la théorie des roues {cite "carlstromWheelsDivisionZero2004"}[] ; les deux dernières, et
leur combinaison $`\circ\delta`, sont une extension de K7PL, définie plus bas.
Ces singularités se propagent algébriquement à travers les opérations vectorielles, sans jamais
introduire de branchement ; si $`\bot` atteint la sortie d'une fonction, le résultat est simplement
l'absence de donnée — un échec prouvé plutôt que silencieux.

::::thm (label := "thm:homomorphisme_roues") (status := "proposition") (level := "representation")
:::title
représentation des singularités de la théorie des roues
:::

:::statement +titled
Encodage des singularités et masquage vectoriel

Soit $`i : \text{Wheel} \to \text{Float64}` l'encodage qui associe à chacune des cinq
singularités ($`\bot, \infty, \circ, \delta, \circ\delta`) un motif de bits déterministe dans la charge utile
d'un NaN silencieux IEEE 754. Alors (i) $`i` est injective sur ces cinq singularités ; (ii)
$`\text{select}(m, i(x), y) = i(x)` si $`m`, $`y` sinon, exactement ; (iii) l'arithmétique de
couche 3 sur les valeurs encodées est _spécifiée par K7PL_, par la table de propagation des
singularités ({num "tab:propagation-addition"}[], {num "tab:propagation-produit"}[]), et non déléguée à
IEEE 754. La réalisation de (iii) est une exigence, vérifiée par
test différentiel (§{num "sec:c6-le-processus-de-compilation"}[]).
:::

:::proofsketch
La norme IEEE 754 laisse libres les bits de charge utile d'un NaN silencieux ; K7PL y encode chaque
singularité de façon déterministe, d'où l'injectivité (i). L'égalité de couche 3 est l'identité bit
à bit sur les valeurs finies et l'égalité de classe sur les singularités, plutôt que l'égalité IEEE 754
standard, défectueuse pour `NaN`. L'opérateur `select` s'abaisse
en masquage vectoriel sans branchement ; la nature binaire du masque garantit que la charge utile de
la branche inactive est annihilée plutôt que corrompue, d'où (ii).

Ce que l'énoncé _ne dit pas_ : l'encodage n'est pas un homomorphisme de la théorie des roues vers
les flottants. En roues, $`0/0 = \bot` et $`1/0 = \infty`, un seul infini non signé ; IEEE 754 a deux infinis, $`1/{+0} = +\infty`
et $`1/{-0} = -\infty`, que l'encodage doit distinguer ou identifier explicitement ;
et la propagation de la charge utile d'un NaN à travers $`+` est seulement recommandée par la norme,
non exigée, les opérations invalides produisant le NaN par défaut. Les lois de la théorie des roues,
par exemple $`\bot + y = \bot`, ne tiennent donc sur les valeurs encodées que parce que la table de
propagation de (iii) les impose : c'est K7PL qui les spécifie, aucun effet ne dépendant de la
machine.
:::
::::

La table de propagation est celle de la théorie des roues {cite "carlstromWheelsDivisionZero2004"}[], que le texte
ci-dessus invoque : $`\bot` est la
nullité, $`0/0`, et $`\infty` l'infini non signé, $`1/0`. Quatre classes de valeurs suffisent à l'écrire — zéro,
un fini non nul $`x`, $`\infty` et $`\bot` —, et la division se ramène au produit par l'inverse, $`a/b = a \cdot (1/b)`,
avec $`1/0 = \infty`, $`1/\infty = 0`, $`1/\bot = \bot`. {rmq}[Les trois lois qu'on retient : $`\bot` absorbe
l'addition, le produit et l'inverse ; $`\infty + \infty = \bot` et $`0 \cdot \infty = \bot` ; $`\infty \cdot \infty = \infty`.
Aucun branchement n'est nécessaire pour les lire sur un vecteur de valeurs encodées.] Ces valeurs se calculent
dans la roue des fractions du corps des rationnels ou des réels, dont les éléments sont les couples $`(a, b)`
modulo les multiples non nuls, avec $`(a, b) + (c, d) = (ad + bc, bd)`, $`(a, b) \cdot (c, d) = (ac, bd)`,
$`1/(a, b) = (b, a)`, $`0 = (0, 1)`, $`\infty = (1, 0)` et $`\bot = (0, 0)` : les deux tables en sont la lecture
directe, classe par classe. La construction est celle de Carlström ; les valeurs de ces tables sont calculées ici
sur elle, et non citées d'un énoncé de l'article.

::::k7table (label := "tab:propagation-addition") (align := "lllll")
:::caption
Propagation des singularités par l'addition $`a + b` ($`a` en ligne, $`b` en colonne)
:::

:::table +header
* * $`a + b`
  * $`b = 0`
  * $`b = x`
  * $`b = \infty`
  * $`b = \bot`
* * $`a = 0`
  * $`0`
  * $`x`
  * $`\infty`
  * $`\bot`
* * $`a = x`
  * $`x`
  * fini
  * $`\infty`
  * $`\bot`
* * $`a = \infty`
  * $`\infty`
  * $`\infty`
  * $`\bot`
  * $`\bot`
* * $`a = \bot`
  * $`\bot`
  * $`\bot`
  * $`\bot`
  * $`\bot`
:::
::::

::::k7table (label := "tab:propagation-produit") (align := "lllll")
:::caption
Propagation des singularités par le produit $`a \cdot b` ($`a` en ligne, $`b` en colonne)
:::

:::table +header
* * $`a \cdot b`
  * $`b = 0`
  * $`b = x`
  * $`b = \infty`
  * $`b = \bot`
* * $`a = 0`
  * $`0`
  * $`0`
  * $`\bot`
  * $`\bot`
* * $`a = x`
  * $`0`
  * fini
  * $`\infty`
  * $`\bot`
* * $`a = \infty`
  * $`\bot`
  * $`\infty`
  * $`\infty`
  * $`\bot`
* * $`a = \bot`
  * $`\bot`
  * $`\bot`
  * $`\bot`
  * $`\bot`
:::
::::

« Fini » désigne le résultat de l'opération sur les valeurs finies, que la représentation flottante calcule.
Ce que la représentation produit hors des finis est lu par une règle d'entrée, et c'est elle qui tranche la
question des deux infinis d'IEEE 754 : le NaN, quelle que soit sa charge utile, est lu $`\bot` ; $`+\infty` et
$`-\infty` sont tous deux lus $`\infty` ; $`+0` et $`-0` sont tous deux lus $`0`. Les deux signes sont donc
_identifiés_ à l'entrée, plutôt que distingués au prix d'une division par zéro signée. Cette lecture s'accorde
avec les opérations d'IEEE 754 {cite "ieeeIEEEStandardFloatingPoint2019"}[] sur les cas singuliers — $`0/0`, $`\infty - \infty`, $`0 \cdot \infty` rendent un NaN, lu
$`\bot` ; $`x/0` rend un infini, lu $`\infty` —, et elle coûte deux choses, qu'il faut écrire. La conversion d'un
flottant vers une roue n'est pas un aller-retour sur les infinis, qu'elle identifie. Et un écart subsiste sur
l'addition : $`+\infty + (+\infty)` rend $`+\infty` en IEEE 754 quand les signes concordent, alors que la roue, qui n'a
qu'un seul infini, rend $`\bot` ($`\infty + \infty = \bot`). L'arithmétique de couche 3 suit la table et non le matériel,
selon la proposition {num "thm:homomorphisme_roues"}[] (iii) ; le test différentiel compare donc à IEEE 754 hors de ce cas. L'égalité de couche 3
compare des _classes_ de singularités, jamais la charge utile d'un NaN ; c'est ce qui rend l'injectivité de la
représentation vraie sur les singularités par définition, et non par vérification (§{num "sec:c4-echelle-du-systeme"}[]).
Les deux autres singularités du texte, $`\circ` et $`\delta`, n'ont pas de source, et on le dit. La roue des fractions
d'un corps n'a que deux éléments hors du corps, $`\infty = 1/0` et $`\bot = 0/0` ; un méadow commun
{cite "bergstraDivisionZeroCommon2015"}[], l'autre structure où la division est totale, n'a qu'une seule valeur
d'erreur, qui se propage à travers toutes les opérations. Aucune de ces sources ne porte deux classes
d'erreur distinctes de $`\bot`. $`\circ` et $`\delta` sont donc une _extension de K7PL_, que ce document définit par le
seul principe que les sources établissent, celui de la propagation absorbante, et par rien d'autre. Ce sont deux
classes d'erreur, que K7PL réserve à deux erreurs qu'un programme veut distinguer de l'indétermination $`0/0` ;
il appartient au programme de dire lesquelles, le langage n'en fixe aucune. Une erreur est un _ensemble_ non vide
d'étiquettes pris parmi $`\circ` et $`\delta` : $`\circ`, $`\delta`, et $`\circ\delta`, la classe d'une valeur qui porte les
deux. Pour $`+`, $`\cdot` et l'inverse $`1/\cdot`, une opération dont un opérande est une erreur rend l'erreur dont
l'ensemble est la _réunion_ des ensembles de ses opérandes, et la valeur de la roue est oubliée : (a) une erreur absorbe
les quatre classes de la roue, $`0`, $`x`, $`\infty` et $`\bot`, $`c \star \circ = \circ \star c = \circ`, $`1/\circ = \circ`, et de même
pour $`\delta` ; (b) $`\circ \star \circ = \circ`, $`\delta \star \delta = \delta` ; (c) $`\circ \star \delta = \delta \star \circ = \circ\delta`,
et $`\circ\delta` absorbe tout. Aucune entrée flottante ne produit une erreur : tout NaN est lu $`\bot`, et seuls les
constructeurs de `Wheel<T>` les introduisent. Deux conséquences, qu'il faut écrire. D'une part $`\bot` n'absorbe plus
les erreurs ($`\bot + \circ = \circ`) : l'axiome $`0/0 + x = 0/0` de la théorie des roues, tel que nous le
rappelons, ne tient pas pour $`x = \circ`, et l'ensemble des sept classes n'est donc _pas une roue_ ; il contient la
roue des fractions, dont les quatre classes se comportent comme dans les tables. D'autre part c'est le prix de
l'associativité : si $`\circ` absorbait $`\infty` et que $`\bot` absorbât $`\circ`, on aurait
$`(\infty + \infty) + \circ = \bot` et $`\infty + (\infty + \circ) = \circ`, et l'addition ne serait pas associative ; la
règle que ce document écrivait d'abord, la borne supérieure avec $`\circ \star \delta = \bot`, est tombée sur ce
contre-exemple. Avec la réunion, $`+` et $`\cdot` sont commutatives, associatives et ont pour neutres $`0` et $`1`, et
l'inverse est une involution multiplicative. Cela a été _vérifié par énumération_ sur la roue des fractions des
corps à 2, 3 et 5 éléments étendue de la même façon (`scripts/verif_singularites.py`), non démontré ; le même
programme vérifie les autres axiomes de la roue, tels que nous les rappelons, qui tiennent tous sauf celui de $`\bot`.
La proposition {num "thm:homomorphisme_roues"}[] n'en dépend pas, et retirer $`\circ` et $`\delta` de l'encodage (i) ne
modifierait rien d'autre.

::::thm (label := "thm:representation_inobservable") (status := "exigence") (level := "representation")
:::title
aucune liberté de représentation n'est observable
:::

:::statement +titled
Injectivité de la représentation

La représentation $`\mathrm{repr}` d'une valeur est telle que $`\mathrm{obs} \circ \mathrm{repr}` est
injective : deux exécutions qui diffèrent par une liberté représentationnelle — élision d'un champ,
purge d'un journal, bourrage, charge utile d'un NaN, ordre des segments en mémoire — ne sont pas
discernables par l'observation.
:::
::::

Exigence vérifiée par test différentiel, non démontrée. Elle absorbe cinq dispositions : l'élision est bornée par
une version de schéma, la purge par la rotation du journal, le bourrage par la règle d'abaissement,
le NaN par la proposition {num "thm:homomorphisme_roues"}[], l'ordre des segments par la
réallocation (`mremap`). Toutes disent la même chose.

L'overflow entier suit la même logique par couche : rejet statique en couche 3, où le solveur SMT
doit prouver que l'opération reste dans les bornes ; `Result(T, OverflowError)` en couche 2, où
l'origine des valeurs n'est plus toujours statiquement bornée. Dans les deux cas, aucun dépassement
silencieux n'est jamais toléré.
