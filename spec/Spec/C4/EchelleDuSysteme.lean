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

#doc (Manual) "Échelle du système" =>
%%%
file := "c4-echelle-du-systeme"
tag := "c4-echelle-du-systeme"
%%%

{label "sec:c4-echelle-du-systeme"}

À l'échelle du système, la coalgèbre qui produit l'état suivant n'est plus celle d'un acteur isolé,
mais celle de l'orchestrateur tout entier, dont l'état est composé des états de tous les acteurs
qu'il supervise. Le foncteur qui l'engendre est exhibé au §{num "sec:c4-le-calcul-de-processus"}[] :
sous la lecture de la couche 2 comme calcul de processus, un système est un terme — composition
parallèle d'acteurs sous restriction des canaux privés —, et le foncteur cherché est le produit des
foncteurs de comportement individuels, restreint aux transitions que la topologie de coupures
autorise. Cette section suit quatre questions que doit résoudre une telle coalgèbre à grande
échelle. Comment ses composants naissent et persistent. Comment la forme de leur assemblage reste
vérifiable plutôt qu'arbitraire. Comment ils communiquent entre eux et vers l'extérieur. Et, en
clôture, ce que cette machinerie offre sans rien y ajouter à un domaine qui semblait lui être
étranger.

Les acteurs s'exécutent en anneau 0 dans un unikernel, tous dans le même espace d'adressage
physique, sans changements de contexte ni purges de TLB — l'isolation entre eux repose, _pour le
code compilé par K7PL_, entièrement sur les preuves du système de types plutôt que sur une unité de
gestion mémoire. Cet énoncé demande d'être borné, faute de quoi il promet plus qu'il ne tient. Les
résultats de sûreté robuste sur lesquels il s'appuie portent sur des langages à modèle mémoire
_abstrait_, où cacher un emplacement se fait en ne le partageant pas, et où un bac à sable serait
effectivement inutile. Un unikernel a un modèle _concret_ : du code non fiable peut y deviner ou
calculer une adresse et la déréférencer, ce qui justifie le bac à sable {cite "sammlerHighlevelBenefitsLowlevel2020"}[].
L'affirmation n'est donc pas fausse, elle est vraie d'un cadre que la cible ne satisfait pas
entièrement. Elle vaut du _code que K7PL compile_, dont le typage exclut la fabrication d'adresse,
et non du code étranger que la passerelle FFI introduit. Pour celui-là, un confinement concret reste
nécessaire, et ce document ne le fournit pas.

Une voie existe pourtant, et sa forme importe autant que son existence : la vérification dynamique
de contrats aux _frontières_ entre code vérifié et code non fiable, par des capabilités linéaires,
obtient la compilation pleinement abstraite {cite "vanstrydonckLinearCapabilitiesFully2019"}[]. La
différence à retenir est celle qui décide de ce que ce document peut en tirer : la non-duplicabilité
y est tenue par le _matériel_ et non par le typage. Une garantie statique comme celle de ce document
ne vaut que du code qu'elle a typé~; une capabilité linéaire matérielle vaut de tout code, y compris
étranger. Les deux ne sont donc pas concurrentes mais complémentaires, et la passerelle est
l'endroit où la seconde prendrait le relais de la première.

Un acteur virtuel n'est, lui, qu'une adresse logique. Un acteur inactif se désactive, son état
persisté en un instantané journalisé et sa mémoire restituée, si bien qu'un nombre d'entités que la
mémoire physique ne pourrait jamais héberger simultanément trouve place dans le système. Réactiver
un acteur n'est jamais qu'une reprise de sa coalgèbre à l'endroit exact où elle s'était arrêtée.
L'orchestrateur charge l'instantané, rejoue les messages consignés depuis, puis relâche le handler —
une activation atomique, bornée par la taille de l'instantané, elle-même un grade $`r`.

::::figure (label := "fig:acteur-cycle-de-vie") (src := "virtual-actor-lca") (alt := "Cycle a deux etats. De Desactivé vers Actif, l'activation charge l'instantane et rejoue le journal. Sur Actif, une boucle figure le traitement de message. D'Actif vers Desactivé, l'inactivite gèle l'état, le persiste et libère la memoire.") (width := "90")
:::caption
Cycle de vie d'un acteur virtuel
:::

:::desc
Les deux états d'un acteur virtuel et les deux transitions qui les relient, dont la reprise de
coalgèbre à l'activation.
:::
::::

Le _gel_ qui précède la persistance tient son coût du théorème {num "thm:isomorphisme_memoire"}[]
plutôt que d'une convention. Un état d'acteur dont les champs sont des scalaires ou des tableaux de
scalaires se persiste par transfert de segment, sans copie ni traduction — sa disposition est déjà
celle du journal. Un état contenant une liste de structures exige au contraire une transposition en
$`O(n)`, la disposition colonnaire de la couche 3 ne coïncidant pas avec la liste composite du
format de journal. Le gel n'est donc pas une étape uniforme : il est gratuit sur le premier cas,
linéaire sur le second, et c'est la forme de l'état — non sa taille — qui décide.

La notification entre fibrilles qui accompagne ce cycle emprunte le modèle LMAX Disruptor : un
compteur 64 bits, incrémenté par le producteur et sondé par le consommateur, avec un ordre mémoire
asymétrique — _release_ à la publication, _acquire_ à la consommation — qui élimine tout appel
système, tout endormissement de fil, tout sémaphore.

La source citée pour ce modèle est une note d'ingénierie, et elle est citée à bon droit pour ce
qu'elle établit : un choix de conception et ses mesures. Elle ne démontre pas la correction de
l'anneau, et il ne faut pas lui faire dire ce qu'elle ne dit pas. La correction d'une file bornée
concurrente sous modèle mémoire faible est, elle, vérifiée mécaniquement dans une logique de
séparation dédiée, dont les assertions portent des _vues_ munies d'une structure de treillis,
l'antériorité s'y exprimant comme un transfert de vue {cite "mevelFormalVerificationConcurrent2021"}[].
C'est cette preuve qui porte la correction ; la note porte l'ingénierie. Les deux objets ne sont pas
pour autant les mêmes : la file prouvée admet plusieurs producteurs et plusieurs consommateurs sous le
modèle mémoire d'OCaml multicœur, quand l'anneau décrit ici n'a qu'un producteur et un consommateur et
un seul curseur. Le transport de l'une à l'autre n'est pas nul, et il n'est pas fait.

Ce dispositif appelle une hypothèse que l'invariant de vivacité de ce chapitre suppose sans la
nommer, et l'omission n'est pas anodine. Sous modèle mémoire faible, les notions usuelles d'équité
entre _fils_ sont insuffisantes pour établir qu'un consommateur qui sonde finit par voir ce qu'un
producteur a publié. Il y faut l'_équité mémoire_, à savoir que le système mémoire exécute
équitablement ses propres étapes de propagation {cite "lahavMakingWeakMemory2021"}[]. La condition
est établie pour le modèle acquisition-libération, qui est celui retenu ici — c'est un des quatre
pour lesquels elle l'est —, de sorte que l'invariant tient. Mais il tient _sous cette hypothèse_, et
non par la seule pose des deux barrières. Le mode de défaillance est documenté et il est concret :
plusieurs implantations publiées d'exclusion mutuelle se bloquent lorsque trop peu de barrières sont
employées. Ce chapitre en pose deux — à la publication et à la consommation — et écrit qu'il n'y en
a aucune ailleurs. Cette économie est correcte, et c'est l'équité mémoire qui la rend correcte
plutôt que le comptage des barrières.

Cette persistance n'a de valeur que si elle rend le système rejouable (P4). Tout ce que l'exécution
pourrait tirer d'une source non déterministe — horloge, générateur aléatoire — transite par un
contexte implicite unique, passé silencieusement à chaque appel mais dont toute modification est
explicite et journalisée. Au replay, le runtime substitue à chaque appel non déterministe la valeur
consignée, si bien que l'exécution rejouée est, bit à bit, identique à l'originale.

::::thm (label := "thm:determinisme_rejeu")
:::title
déterminisme logique du rejeu
:::

:::statement +titled
Reproduction de l'état final à l'observation près

Soit $`J` un journal _complet_ : une fonction d'observation lui associe à chaque événement extérieur observable de l'historique $`H` une entrée, de sorte que tout le non-déterminisme y est consigné — c'est un paramètre de l'hypothèse de rejeu, et non une conséquence de la pureté. Pour tout acteur $`A` d'historique d'exécution $`H`, rejouer les messages journalisés $`J(H)` à
travers les gestionnaires purs de $`A` produit un état final observationnellement égal à
l'original : $`\text{Rejeu}(J(H), S_0) \approx_{\text{obs}} S_{\text{final}}`.
:::

:::proofsketch
Les gestionnaires de couche 2 sont des fonctions pures
$`(\text{Message} \times \text{État}) \to \text{HandlerResult}` (chapitre 3,
§{num "sec:c3-purete-des-gestionnaires"}[]). Les opérations non déterministes sont injectées comme
capacités et journalisées comme entrées factuelles $`C` ; au rejeu, le runtime substitue les appels
de capacité par les valeurs journalisées. L'application
$`(\text{Message} \times C \times \text{État}) \to \text{État}` étant pure et référentiellement
transparente, le pli sur $`J(H)` est déterministe et égale l'exécution originale terme à terme.
L'argument porte sur la fonction, donc sur la valeur dénotée ; il ne porte pas sur sa
représentation.
:::
::::

::::thm (label := "thm:rejeu_binaire") (status := "proposition") (level := "representation")
:::title
identité binaire du rejeu, sous environnement reproductible
:::

:::statement +titled
Le pas que la pureté ne franchit pas

Sous l'hypothèse $`E_{\text{repro}}` — ordonnancement, mode d'arrondi flottant, version de la
chaîne de compilation et architecture, comportement des NaN compris, identiques entre l'exécution et le rejeu — et sous l'hypothèse d'injectivité de la représentation sur les valeurs observables, l'égalité du théorème précédent
est une identité binaire : $`\text{Rejeu}(J(H), S_0) =_{\text{bit}} S_{\text{final}}`.
:::

:::proofsketch
Sous $`E_{\text{repro}}`, la représentation d'une valeur dénotée est fonction de la seule chaîne de
compilation, et l'ordre d'évaluation est fixé ; l'égalité observationnelle du
théorème {num "thm:determinisme_rejeu"}[] se transporte alors en identité de représentation.

_Trois rejeux, une seule relation._ Ce document en distingue trois — le rejeu logique, l'identité
binaire, et le rejeu stratifié par niveau du §{num "sec:g-semantique"}[] — et ils ne sont pas trois notions mais _trois
instances de la même_ : l'égalité modulo une projection. Le premier projette sur l'observation, le
deuxième sur la représentation, le troisième sur un niveau. Les trois sont donc des instances du
schéma de restriction (chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:schema_restriction"}[]), et ce qui les sépare est leur critère, non leur forme.
Une hypothèse supplémentaire est en outre requise ici et le dire évite de la découvrir : l'identité
binaire demande que la représentation soit _injective_ sur les valeurs observables, faute de quoi
deux dénotations distinctes pourraient partager une image. Aucune des quatre composantes de
$`E_{\text{repro}}` n'est fixée par ce document, et le journal n'en consigne aucune : l'hypothèse
est portée par l'environnement d'exécution, non par le langage.
:::
::::

Ce que ce document promet du rejeu binaire tient donc en trois clauses. L'identité binaire est promise
_sur une machine_, qui est la portée que le modèle mémoire de ce chapitre déclare déjà, et sous
$`E_{\text{repro}}` à quatre composantes : ordonnancement, mode d'arrondi, version de la chaîne de compilation,
architecture et comportement des NaN ; entre machines, c'est le journal qui porte l'ordre, et le rejeu y reste
logique. L'ordonnancement complet des réceptions entre acteurs n'est pas consigné, et la promesse ne s'étend pas
à un rejeu binaire multi-acteurs : consigner chaque réception ferait croître le journal au rythme des messages,
ce que P3 interdit tant qu'aucune borne n'est écrite. Enfin la charge utile d'un NaN n'est pas observable :
l'égalité de couche 3 compare les classes de singularités, et leur propagation est spécifiée par K7PL
(tables {num "tab:propagation-addition"}[] et {num "tab:propagation-produit"}[]), de sorte que l'injectivité de
la représentation est vraie sur les singularités par définition. Elle reste à vérifier pour le bourrage de
l'arène et l'ordre des segments après réallocation, que cette clause ne traite pas. Si la réalisation ne peut
tenir ces clauses, le repli est de ne promettre que le rejeu logique, et l'identité binaire redevient une
propriété d'une implémentation.

Ces hypothèses éparses se rassemblent en un seul objet, le _profil de représentation_
$`\Pi = \langle v_{\mathrm{Arrow}}, v_{\mathrm{Capnp}}, v_{\mathrm{MLIR}}, \mathrm{arch}, \mathrm{mem}, \mathrm{round}, v_{\mathrm{schéma}} \rangle` : versions des trois
spécifications de disposition, architecture et comportement NaN, modèle mémoire, mode d'arrondi,
version de schéma. $`E_{\text{repro}}`, la portée « une machine » du modèle mémoire et la convention
d'élision de champ en sont trois projections. Il en résulte que les théorèmes de disposition
({num "thm:isomorphisme_memoire"}[]) et de rejeu binaire ({num "thm:rejeu_binaire"}[]) sont des
propriétés de _conformité du compilateur_ à un profil donné, vérifiées par le pipeline de validation
de la Phase 9, et non des théorèmes du calcul des types.

La supervision surveille cette continuité par battements de cœur et applique des politiques de
redémarrage garanties par un invariant de vivacité : un acteur en panne finit toujours par redevenir
actif. Après une partition réseau, deux répliques d'un même acteur convergent en appliquant la
fusion algébrique que leur type CRDT porte déjà (chapitre 3, §{num "sec:c3-le-systeme-gradue"}[]).
La convergence n'est pas surveillée depuis l'extérieur : elle est une conséquence du type lui-même,
invoquée au moment voulu.

Cette population d'acteurs ne s'assemble pas librement. Le compilateur construit, en amont de toute
exécution, le graphe de dépendances entre gabarits d'acteurs et le prouve acyclique. Cette
construction suppose une condition que ce document laissait implicite et qu'il faut écrire : *le
type d'état est unique par gabarit d'acteur*. Cette acyclicité n'est pas ajoutée par K7PL : elle est
ce que produit toute composition fondée sur la logique linéaire, dont il est établi que les réseaux
d'interconnexion engendrés sont strictement moins expressifs que ceux d'un calcul de sessions
multipartites, et qu'ils excluent les interconnexions circulaires entre trois participants ou plus {cite "toninhoInterconnectabilitySessionBasedLogical2018"}[].

C'est cette unicité qui identifie un nœud du graphe, et c'est elle qui rend aboutissante la
recherche du gestionnaire décrite au chapitre 5 (§{num "sec:c5-mise-en-pratique"}[]). La preuve
d'acyclicité est portée par un paramètre fantôme sur le type de l'acteur : chaque instance dynamique
hérite de l'acyclicité de son gabarit, sans qu'aucune vérification circulaire ne soit recalculée à
l'exécution.

Un point de vocabulaire doit être fixé ici, car ce document a employé les deux et ce ne sont pas
deux façons de dire la même chose. La composition _est_ la coupure, et la coupure est l'endroit où
la logique linéaire classique et l'intuitionniste diffèrent — un canal à droite, ou plusieurs. La
classique est strictement plus expressive ; mais la _localité des noms partagés_ est imposée par
l'intuitionniste et non par la classique, celle-ci interdisant en outre les envois vides sur canaux
reçus, et les deux contraintes découlent de la même exigence d'exactement un canal à droite {cite "heuvelComparingSessionType2024"}[].
Or ce chapitre revendique la localité comme une propriété _structurelle_ et non comme une discipline
maintenue. Elle vient donc du typage _intuitionniste_, et c'est celui-ci que K7PL retient partout :
au chapitre 3 pour les types de session, et ici pour le métalangage. Ce qui se paie en retour est
l'expressivité que la classique aurait donnée, et ce prix est le même que celui de l'acyclicité — il
est payé une fois, pour deux bénéfices.

Son coût est triple. Elle exclut les boucles de rétroaction, construction centrale du flot de
données, que les flux monoïdaux interprètent en formant une catégorie à rétroaction {cite "dilavoreMonoidalStreamsDataflow2022"}[].
Elle prive le langage d'une _trace_, donc de la voie canonique vers une partie compacte close — la
construction Int, qui plonge toute catégorie tracée dans une catégorie tortile {cite "HASEGAWA-TRACED"}[].
Et elle exclut les topologies circulaires elles-mêmes.

Une remarque s'impose avant d'aller plus loin, car elle écarte une objection que ce document s'était
faite à lui-même. On pourrait croire qu'une extension déductive — un moteur de règles
relationnelles, dont les définitions se rappellent mutuellement — exigerait des interconnexions
circulaires et mettrait donc l'acyclicité en défaut. Il n'en est rien : la récursion d'un tel moteur
n'est pas un cycle de communication mais le plus petit point fixe d'une fonction monotone, calculé
par itération locale depuis le plus petit élément d'un semi-treillis (chapitre 2,
§{num "sec:c2-adjonctions-et-enrichissement"}[]). Un ensemble de règles se compile en un terme de
point fixe porté par un gabarit unique, dont les relations sont des arènes de couche 1 — la
représentation restant paramétrique, sous les seules propriétés que l'évaluation semi-naïve
incrémentale réclame {cite "sahebolamriBringYourOwn2023"}[]. Le graphe de gabarits reste acyclique
sans qu'aucune concession lui soit faite, et la clôture du chapitre 1 n'est pas mise à l'épreuve :
le point fixe se projette sur $`\Delta` et $`\mathcal{G}` comme n'importe quel pli.

La compilation d'un tel ensemble tient en trois temps, et rien n'y est propre au langage. Les
prédicats extensionnels — les faits donnés — deviennent des arènes de couche 1, une par prédicat,
dans la disposition colonnaire du théorème {num "thm:isomorphisme_memoire"}[]. Les règles deviennent
une fonction $`f` d'un tuple de relations dans lui-même, chaque règle contribuant l'union de ce
qu'elle dérive. Cette fonction est monotone par construction, puisqu'ajouter des faits ne peut qu'en
faire dériver davantage, et son grade porte donc la marque du
§{num "sec:c2-adjonctions-et-enrichissement"}[] sans que le programmeur ait à l'écrire. Le programme
entier est alors $`\mathbf{fix}\,f`, dont le théorème {num "thm:terminaison_lfp"}[] garantit la
terminaison dès que le domaine est de hauteur finie — ce qu'un univers de constantes fini assure.

Deux précisions achèvent le tableau. L'itération naïve recalcule à chaque tour ce qu'elle savait
déjà ; l'évaluation _semi-naïve_ ne considère que les faits nouveaux du tour précédent, et c'est
elle qui rend le dispositif praticable. Elle n'est pas une optimisation extérieure au cadre : elle
exploite la différence entre deux éléments consécutifs de la chaîne croissante, différence que
l'ordre fournit. Et le semi-anneau sur lequel cette évaluation se fait n'est pas $`\mathcal{R}` — le
§{num "sec:c2-la-comonade-exponentielle-et"}[] l'a noté — mais un semi-anneau propre à l'extension,
le booléen pour des règles ordinaires : une structure supplémentaire, non un réemploi.

Cette restriction répond en outre à une question que le chapitre 6 aurait rencontrée sans elle :
comment un compilateur constate-t-il qu'une obligation est indécidable _avant_ de tenter de la
décharger. Il ne le constate pas, et il ne le peut pas — décider si une obligation est décidable est
lui-même indécidable en général. Ce qui vaut est ce que fait cette section : restreindre le _langage
des obligations_, de sorte qu'une obligation indécidable ne soit pas rejetée mais _inexprimable_.
C'est la garantie par inexpressibilité du chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]),
appliquée ici au langage des obligations, et elle a le bénéfice qui lui est propre — rendre
inexprimable plutôt qu'interdire retire une liste de cas à tenir à jour.

Une frontière doit en revanche être fixée, et elle est stricte. Un tel moteur augmenté
d'arithmétique entière et de négation stratifiée serait _indécidable_. La décidabilité ne revient
qu'en restreignant les prédicats numériques à des bornes maximales ou minimales et sous une
condition de linéarité limitant la multiplication, et la complexité ne retombe aux bornes usuelles —
polynomiale en la taille des données — que sous une exigence supplémentaire de stabilité {cite "kaminskiComplexityExpressivePower2022"}[].
Une extension déductive de K7PL se tiendrait donc sous ces trois restrictions, ou renoncerait à
l'arithmétique : hors d'elles, ce n'est pas la prédictibilité que le langage perdrait, c'est la
décidabilité.

L'acyclicité est enfin _levable_, et le prix en est mieux connu qu'il n'y paraît. Il n'exige pas de
type global : la compatibilité multipartite s'établit sans qu'aucun type ne chorégraphie les
processus, et l'on peut même vérifier des protocoles pour lesquels aucun type global n'existe {cite "horneSessionSubtypingMultiparty2020"}[].
Ce qui remplace l'acyclicité est une condition supplémentaire, vérifiable statiquement — liberté de
course, formulée comme un problème d'inférence de types, ou annotations de priorité sur les canaux
dont le typage est décidable et la décidabilité mécanisée {cite "saffrichBorrowingSessionTypes2025"}[].
L'extension reste hors périmètre ici ; mais elle ne coûterait pas ce que ce document annonçait, et
la localité de l'architecture n'y serait pas engagée.

Reste à dire pourquoi ce document ne l'emprunte pas, et la raison n'est pas la prudence : elle suit
de choix déjà arrêtés ailleurs. Depuis que la couche 2 se lit comme un calcul de processus
(§{num "sec:c4-le-calcul-de-processus"}[]), l'acyclicité n'est plus une hypothèse mais une
conséquence — un terme y est un arbre de coupures, et un arbre n'a pas de cycle. Admettre des
interconnexions circulaires produirait des termes qui ne sont pas des arbres, donc hors de l'image
de la traduction, donc hors de portée de l'énoncé de fidélité que le chapitre 6 en tire. Et la
localité, qui est l'une des deux modifications définissant le calcul cible et ce qui le rend
distribuable, cesserait d'être acquise par construction pour redevenir une discipline à maintenir.
Le cadre qui lève l'acyclicité est en outre non commutatif, ce qui rouvrirait la question du produit
ordonné que l'encodage des protocoles dans $`\multimap` (chapitre 3) a précisément permis d'éviter.

Les trois coûts recensés plus haut changent donc de statut. Ils ne sont pas des concessions que K7PL
ferait faute de mieux, mais les conséquences d'une architecture dont l'acyclicité, la localité et la
commutativité limitée sont trois faces. Les lever demanderait de défaire ces trois choix ensemble,
et non d'ajouter une règle de composition.

Deux choix voisins appellent le même traitement : le régime asynchrone du chapitre 3 écarte le
rendez-vous synchrone, exprimable par encodage en appel-retour {cite "castellanTwoSidesSame2019"}[]
au prix d'un aller-retour, et le critère d'atomicité des jonctions exclut par construction les
objets concurrents qui ne se linéarisent pas, dont il en existe d'utiles {cite "oliveiravaleCompositionalTheoryLinearizability2023"}[].
K7PL établit l'absence de blocage ; il n'établit ni le progrès global, que des systèmes linéaires
minimaux obtiennent du seul typage {cite "jacobsSelfDualDistillationSession2022"}[], ni la
terminaison équitable, propriété qu'appellerait son régime asynchrone {cite "PADOVANI"}[].

L'isolation entre acteurs procède du même déplacement : la garantie vient d'une preuve du
compilateur et non d'un mécanisme d'exécution. La stratégie est celle de Singularity, qui a établi
que des processus isolés logiciellement peuvent partager un espace d'adressage tout en restant
incapables de se corrompre, dès lors que le compilateur a vérifié leurs propriétés d'accès. Le gain
est l'élimination des changements de contexte et des purges de TLB. Le prix est que tout le poids de
l'isolation se déplace vers la correction du compilateur, là où une MMU la maintiendrait
indépendamment de tout bogue en amont. La terminalité de la coalgèbre qui définit un acteur garantit l'indiscernabilité comportementale _logique_, non l'absence de canaux cachés physiques. C'est un pari, non une conséquence, mais il n'est pas isolé.
Le modèle de composants de WebAssembly en donne une réalisation déployée : la mémoire linéaire y est
bornée par construction, les valeurs franchissent la frontière par un modèle d'interface plutôt que
par des pointeurs, et aucun composant n'atteint la mémoire d'un autre sans unité de gestion mémoire {cite "groupWebAssemblySpecification,groupWebAssemblySpecAddendum,groupWebAssemblyCodeMetadata"}[].
Ces deux postulats ont un coût d'expressivité assumé et non démontré : P3 exclut les algorithmes
dont la terminaison n'est pas structurellement évidente, P4 les ordonnancements non déterministes
que certains systèmes sensibles à la latence préfèrent.

::::thm (label := "thm:liberte_initialisation")
:::title
liberté d'initialisation par DAG topologique
:::

:::statement +titled
Câblage complet sans interblocage

Si le graphe de dépendances $`G` des acteurs et canaux est acyclique — vérifié en Phase 2
(chapitre 6, §{num "sec:c6-le-processus-de-compilation"}[]) —, la phase d'initialisation atteint un
état entièrement câblé sans interblocage : $`\text{Acyclique}(G) \implies \exists` un tri
topologique $`T` tel que $`\forall n \in T`, l'initialisation de $`n` se termine sans blocage.
:::

:::proofsketch
Un interblocage à l'initialisation impliquerait une attente circulaire, correspondant
structurellement à un cycle dans $`G` ; la Phase 2 calcule le tri topologique de $`G` et échoue la
compilation si un cycle est détecté (`ERR-ARC-001`). Étant donné $`G` acyclique, le tri topologique
existe (chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:tri_topologique"}[]) et l'ordre qu'il donne est l'ordre d'initialisation : chaque
nœud n'y est atteint qu'après ses dépendances, jusqu'au câblage complet.
:::
::::

Les espaces de noms se lisent sur ce même graphe : un namespace en retient la restriction à une
dimension choisie — la pureté, l'effet, le couplage — ce qui remplace la hiérarchie de dossiers
physiques par une lecture purement logique du graphe de types. Le graphe lui-même se traite
fonctionnellement : une représentation inductive où un graphe est une fonction des sommets vers des
ensembles pondérés — non nécessairement finis, et génériques sur une large classe de poids — fait
des algorithmes de graphes des transformations de graphes {cite "erwigInductiveGraphsFunctional2001"}[].
Les poids génériques y sont des grades, ce qui rapproche cette représentation de ce document plus
que ne le ferait une bibliothèque de graphes ordinaire.

Ce rapport est fonctoriel, mais dans le sens inverse de celui qu'on lui prête d'ordinaire. Soit
$`\mathcal{D}` la catégorie librement engendrée par le graphe des dépendances — objets les modules,
morphismes les chemins de dépendance — et $`\mathcal{D}_{|k}` celle engendrée par le seul
sous-graphe des arêtes de dimension $`k`. L'identité d'un module est le chemin vide, présent dans
les deux ; et la composition de deux chemins d'arêtes de dimension $`k` est un chemin d'arêtes de
dimension $`k`, puisque la concaténation ne quitte pas le sous-graphe. L'inclusion
$`\mathcal{D}_{|k} \hookrightarrow \mathcal{D}` est donc un foncteur, et il est fidèle : deux
chemins distincts du sous-graphe le restent dans le graphe entier. Un namespace _est_ une
sous-catégorie large, et c'est son inclusion qui est fonctorielle.

L'opération inverse ne l'est pas, et c'est pourquoi le mot de projection induisait en erreur :
envoyer $`\mathcal{D}` vers $`\mathcal{D}_{|k}` demanderait de dire ce que devient une arête d'une
autre dimension, et rien ne le prescrit. Le namespace ne projette pas le graphe, il en isole une
partie close par composition.

Deux métriques, calculées sur ce graphe, avertissent d'une architecture qui se dégrade sans pour
autant l'interdire. L'instabilité, rapport du _fan-out_ à la somme des _fan-in_ et _fan-out_,
signale un module trop dépendant d'autrui. La centralité, fraction des plus courts chemins
traversant un module donné, signale un objet devenu un point de passage obligé. Ces deux métriques
sont des avertissements et non des garanties : rien n'établit qu'un score élevé corresponde à un
défaut, seulement qu'il y corrèle dans la pratique observée ailleurs. Seule l'acyclicité est ici une
garantie, dont la violation est une erreur de compilation. La modestie ne vaut d'ailleurs pas de
toute grandeur calculée : la stabilité numérique, elle, est démontrable dans le cadre du langage et
ne reste un avertissement que faute d'avoir été instrumentée.

Deux précisions sur leur statut. Ces métriques sont des algorithmes de graphes, qui ne sont pas
structurellement récursifs {cite "kidneyFormalisingGraphAlgorithms2025"}[] : elles ne relèvent donc
pas du catamorphisme de couche 3 (chapitre 2, §{num "sec:c2-algebres-coalgebres-et-points"}[]) et
s'exécutent dans le compilateur, non dans le langage. Et le traitement inductif du graphe de câblage
— tri topologique sur une structure finie donnée en entier — est légitime pour cette raison précise,
qui ne vaut pas du graphe d'attente à l'exécution. Celui-ci se déplie et relève de la coinduction,
comme le chapitre 3 (§{num "sec:c3-les-contraintes-de-valeur"}[]) l'établit pour l'absence de
blocage mutuel en régime permanent.

Ce statut d'avertissement n'est pas une fatalité pour toutes les métriques du langage : la stabilité
numérique, en particulier, est à portée du système de types plutôt que de la seule heuristique. Des
bornes saines sur l'erreur inverse, inférées automatiquement et coïncidant avec les bornes
théoriques du pire cas, s'obtiennent en combinant un système de coeffets gradués avec la linéarité
stricte {cite "kellisonBeanLanguageBackward2025"}[] — soit exactement l'appareil dont la couche 1
dispose déjà, $`\mathcal{G}` pour la gradation et le fragment linéaire pour la stricte consommation.
L'extension n'est pas conduite dans ce document ; elle n'exigerait aucun mécanisme nouveau.

Les machines à états composables décrivent enfin cette même topologie de façon exécutable plutôt que
descriptive. Chaque handler d'acteur en est une, et les combinateurs séquentiel, parallèle,
alternatif ou de rétroaction qui les assemblent reconstituent le DAG des dépendances. La génération
de diagrammes d'architecture n'est donc pas un outil séparé du langage, mais une interprétation
supplémentaire de cette même description.

La communication entre ces acteurs réalise, à l'exécution, ce que le chapitre 3 avait établi comme
type. Un canal typé s'échange sur un anneau SPSC sans verrou, dont toute la mémoire est allouée au
démarrage — P3 appliqué au transport {cite "thompsonDisruptorHighPerformance2011"}[]. Ses entrées
sont tabulées plutôt que chaînées, de sorte qu'un retrait groupé ne coûte pas plus qu'un retrait
unitaire {cite "DPDK-RING"}[]. C'est cette seconde propriété, non l'absence de verrou, qui fonde la
borne de coût du transport. Un motif de jonction $`x(u) \mid y(v) \triangleright P`, produit
tensoriel de $`\Delta` abaissé en automate, se résout par un simple masquage binaire — encore un DFA
compilé, au sens du §{num "sec:c4-echelle-locale"}[]. L'exhaustivité d'un tel motif se vérifie par
une analyse stochastique — PEPA (_Performance Evaluation Process Algebra_, Hillston) {cite "hillstonCompositionalApproachPerformance"}[]
— qui calcule si toute combinaison de messages possible est bien couverte
({num "lst:motif-jonction"}[]) :

::::listing (label := "lst:motif-jonction")
:::caption
Un motif de jonction, dont la couverture des combinaisons de messages se vérifie statiquement
:::

```
(define-join-pattern traite-resultat
  ((msg-fini id resultat) (traite-succes resultat))
  ((msg-tic delai)        (traite-abandon id)))
```
::::

Un acteur attendant simultanément un résultat et l'expiration d'une horloge n'a besoin d'aucune
conditionnelle : les deux issues sont deux clauses du même motif, et l'absence de couverture d'une
combinaison de messages est une erreur de compilation plutôt qu'un cas oublié à l'exécution.

Deux conditions matérielles gouvernent ce dispositif, et elles doivent être posées avant l'énoncé
qui en dépend. Les processeurs réordonnent instructions, charges et stockages : rendre les
changements visibles dans l'ordre entre deux fils exige des _barrières mémoire_, que le compilateur
émet en plus de celles du matériel {cite "thompsonDisruptorHighPerformance2011"}[]. Et la ligne de
cache, communément 64 octets, étant la granularité des protocoles de cohérence, deux variables
indépendantes qu'elle héberge se comportent en contention comme une seule — le _faux partage_. Les
curseurs de production et de consommation d'un anneau occupent donc des lignes distinctes,
contrainte que la représentation SoA n'impose pas et que l'abaissement doit garantir.

Sur le premier point, K7PL suit la discipline de SPIR-V, qui ne définit pas un modèle mémoire mais
en _sélectionne_ un, par une instruction unique en tête de module fixant conjointement adressage et
modèle mémoire {cite "SPIRV"}[]. Le modèle devient ainsi explicite et vérifiable au lieu d'être
déduit du code, et plusieurs cibles restent possibles sans que la sémantique du langage en dépende.
Le modèle retenu est _acquisition-libération_ : une libération ordonne les accès qui la précèdent,
une acquisition ceux qui la suivent, et leur appariement établit l'antériorité entre deux fils. Une
conséquence doit être écrite au moment où le modèle est choisi, plutôt que découverte au moment où
une borne serait chiffrée. Sélectionner un modèle mémoire ne nomme pas la _machine_ contre laquelle
les bornes de ce document valent, et une borne de temps d'exécution au pire cas n'a pas de sens
absolu : elle vaut d'un profil matériel — un jeu d'instructions, une hiérarchie de caches, un nombre
de cœurs. Ce document ne pose pas ce profil et n'en a pas besoin, n'ayant chiffré aucune borne.
_Toute borne chiffrée qu'il porterait un jour serait donc relative à un profil, et devrait le
nommer._ La réserve est ici plutôt qu'à l'endroit où elle deviendrait nécessaire, faute de quoi un
lecteur prêterait à ces bornes une portée que le modèle seul ne leur donne pas. C'est le plus faible
qui suffise à la discipline du chapitre 3 — une écriture exclusive, des lectures partagées —, et il
fixe les barrières : libération à la publication d'un message, acquisition à sa consommation, aucune
ailleurs. La cohérence séquentielle coûterait davantage sans rien apporter à un transport où la
propriété interdit déjà l'écriture concurrente.

La _portée_ de ces contraintes se déduit de l'architecture plutôt qu'elle ne se choisit. {rmq}[Une
seule portée à déclarer là où SPIR-V en distingue plusieurs, et c'est la stratification qui la
donne.] Le modèle acquisition-libération gouverne la mémoire partagée d'une _machine_. C'est là, et
là seulement, que deux fibrilles voient le même anneau et que la question de l'ordre se pose. Entre
machines, aucune mémoire n'est partagée — la communication passe par le journal, dont l'ordre relève
de P4 et non du modèle mémoire. Le cœur n'est pas davantage une portée distincte : deux fibrilles
d'un même cœur ne s'exécutent pas simultanément, et l'ordre du programme y suffit. Le comptage de
$`\mathbf{tick}` acquiert par là le référentiel qui lui manquait — une machine, sa hiérarchie de
caches, son protocole de cohérence.[^fn2]

[^fn2]: La conformité du code engendré au modèle déclaré est une propriété de l'abaissement, qui se vérifie sur un compilateur et non dans un document.

::::thm (label := "thm:sync_motifs_jonction")
:::title
synchronisation atomique des motifs de jonction
:::

:::statement +titled
Activation conditionnelle synchrone

Soit $`J \triangleq x\langle u \rangle \mid y\langle v \rangle \triangleright P` un motif de
jonction. L'acteur réagit par $`P` si et seulement si des messages pour $`x` et $`y` sont
simultanément présents dans la boîte aux lettres $`M` :
$`M(x) \neq \emptyset \land M(y) \neq \emptyset \iff M \xrightarrow{J} P`.
:::

:::proofsketch
La consommation simultanée n'est pas un protocole d'appariement à construire : c'est l'opération
native de la règle {sc}[Guard] (§{num "sec:g-couche2"}[]), dont la prémisse décompose le
motif de la boîte en $`\sum_i P_i \cdot E_i`, chaque $`P_i` étant un produit de messages, et dont la
conclusion rend la continuation de motif. Le motif $`J` est une coupure de logique linéaire exigeant $`x` et $`y`
simultanément — le produit tensoriel $`x \otimes y` du chapitre 1
(§{num "sec:c1-axiomatique-germinale"}[]) — et la boîte aux lettres est un multi-ensemble de
ressources linéaires stocké dans des anneaux SPSC, un par émetteur (voir la structure de la boîte, ci-dessous). Le compilateur abaisse $`J` en automate évalué par
masquage binaire de l'occupation des anneaux ; la réduction consomme les deux messages simultanément par échange
atomique de pointeurs, garantissant l'atomicité verrou-libre sans synchronisation supplémentaire.
:::
::::

Cette boîte est un seul objet, $`\mathsf{Mailbox} = \Sigma_{c \in \mathsf{Chan}}\,\mathsf{Bag}(\mathsf{Cap}(c))` :
un multi-ensemble de ressources linéaires indexé par canal, muni d'une règle de consommation
atomique multi-places. Quatre résultats de ce document en sont des lectures : l'activation
conditionnelle ci-dessus ; le circuit breaker de session, qui compare le tag d'un message à ce que la
boîte attend ; la ré-invocation séquentielle d'un grade fini ; et la traduction d'un service répliqué
$`!x(y).P`. Il suffit de poser l'objet une fois pour que chacun s'énonce comme sa restriction :
l'activation conditionnelle est la consommation atomique multi-places sur $`\mathsf{Bag}(\mathsf{Cap}(c))`
pour deux canaux ; le circuit breaker est la comparaison du tag d'un message à l'indice de la somme ; la
ré-invocation d'un grade fini est le service répliqué $`n` fois sur un canal de la boîte ; la
traduction $`!x(y).P` en est la restriction au grade $`\omega`. La reprise formelle de leurs énoncés sur
cette définition unique reste à faire : c'est une réécriture, non une découverte.

La structure physique de cette boîte tient en une phrase : _un anneau SPSC par couple (émetteur, boîte), et une
file de jonction par acteur_. La capacité d'écriture d'un canal est linéaire, de sorte qu'un anneau n'a qu'un
producteur, et la boîte n'a qu'un consommateur, l'acteur qui la détient ; l'indexation de $`\mathsf{Mailbox}`
par canal est cette même partition. Aucune des deux extrémités n'a besoin de comparer-et-échanger, et les deux
barrières de ce chapitre — libération à la publication, acquisition à la consommation — suffisent. La file de
jonction est l'état que l'acteur tient pour ses motifs en attente, au sens du calcul de jonction
{cite "fournetReflexiveCHAMJoincalculus1996"}[] : pour chaque motif, l'ensemble des anneaux non vides dont il a besoin,
lisible par masquage binaire. L'appariement atomique n'est alors pas un protocole entre pairs : l'acteur étant
l'unique consommateur de ses anneaux, consommer deux messages revient à avancer deux curseurs de consommation que
lui seul écrit, et les producteurs, qui ne lisent ce curseur que pour savoir s'il reste de la place, tolèrent de
le voir en retard. Quand plusieurs anneaux portent un message qui convient au motif, l'acteur les examine dans
l'ordre fixe des identifiants d'émetteur : le choix est une fonction de l'état de la boîte, que le journal
restitue, et non une source de non-déterminisme de plus. Deux coûts se nomment. Une file à plusieurs producteurs
simplifierait la topologie, mais au prix d'un comparer-et-échanger que P3 refuse ; et le nombre d'anneaux croît avec
celui des émetteurs. Cette borne mémoire est connue à la compilation : le graphe de câblage est donné en entier, et
chaque anneau a une capacité qui est un grade ; une boîte créée à l'exécution par {sc}[New] porte le sien.

L'énoncé est _local_ : il porte sur une jonction prise isolément. {rmq}[L'atomicité locale est
démontrée, la localité ne l'est pas. Les deux mots se ressemblent et ne disent pas la même chose.]
La propriété dont l'architecture a besoin est distincte et ne s'en déduit pas — la _localité_ au
sens de Herlihy et Wing, c'est-à-dire la conservation de la correction lorsque des objets corrects
sont composés horizontalement, ce que le graphe de câblage fait par construction. Son traitement
compositionnel est un problème à part entière, dont la formulation connue ne repose ni sur
l'atomicité ni directement sur l'ordre _happens-before_, et qui signale qu'un modèle compositionnel
naïf produit des comportements émergents à l'élément neutre {cite "oliveiravaleCompositionalTheoryLinearizability2023"}[].
K7PL revendique donc l'atomicité locale et non la localité.

S'il tient, l'activation conditionnelle d'un acteur ne coûte aucun verrou et se lit sur le type de
son motif. S'il tombe, il faut une synchronisation à l'exécution pour apparier les messages, et le
coût constant par activation que le chapitre 4 annonce tombe avec lui.

La dualité des protocoles de session, elle, se vérifie au moment où un message arrive : le runtime
lit le tag d'état placé en tête du message et le compare au protocole attendu. En cas de désaccord,
le message est rejeté — un _circuit breaker_ — avant même que la fibre de l'acteur ne soit
réveillée, de sorte qu'une désynchronisation malveillante ou accidentelle ne coûte qu'une lecture de
tag, une comparaison entière et un échange de pointeur. La sécurité du transport prolonge cette même
discipline : les prises de contact du protocole Noise sont elles-mêmes des DFA de couche 3, en temps
constant et sans allocation, et l'autorisation repose sur des jetons de capacité — Biscuit — dont la
vérification, parce qu'ils sont des types linéaires, se réduit à leur consommation par l'acteur qui
les détient. Le placement matériel de ces acteurs obéit au même principe déclaratif que leurs
capabilités logiques : `:numa-local`, `:cache-aligned`, `:simd-capable` et `:gpu-offload` sont des
grades que l'orchestrateur résout en affectations physiques concrètes au déploiement, rejetant
celui-ci si aucun nœud du cluster ne les satisfait.

Lorsque la communication franchit la frontière du système lui-même, vers un système d'exploitation
hôte, la même discipline s'applique une dernière fois. La propriété d'un tampon transféré par la
passerelle VirtIO {cite "VIRTIO"}[] reste une capabilité linéaire, que l'hôte ne peut retenir après
le retour — la frontière change de nature, le mécanisme qui la traverse ne change pas. Le modèle y
est structurel plutôt que conventionnel : une _virtqueue_ se compose de trois zones à propriétaire
déclaré — table de descripteurs, anneau disponible côté pilote, anneau utilisé côté périphérique —,
de sorte que la propriété se lit dans l'endroit où l'on écrit {cite "VIRTIO"}[].

Une opération manque cependant : le système de types sait retirer une capacité de son contexte, non
la _révoquer_ chez un pair qui l'a reçue. Les protocoles d'accès distant y pourvoient par une
invalidation explicite, signal du protocole annulant l'étiquette d'une région préalablement annoncée {cite "recioRemoteDirectMemory2007a"}[].
Le destructeur d'une capacité exportée (chapitre 3, §{num "sec:c3-le-systeme-gradue"}[]) devrait
invalider localement l'étiquette de la région qu'il a annoncée : dans ces protocoles l'invalidation s'exécute
chez le propriétaire de la région, sur sa demande ou sur celle de l'accédant, et c'est l'exportateur qui est
propriétaire. Faute de quoi P3 cesse de valoir au-delà de la frontière. C'est le troisième point où
ce document franchit une frontière de confiance sans l'avoir tracée — les deux autres étant
l'exécution de macros avant vérification et l'importation depuis une source distante (chapitre 5,
§{num "sec:c5-mise-en-pratique"}[]).

::::thm (label := "thm:surete_ffi")
:::title
sûreté FFI par la passerelle de capacité
:::

:::statement +titled
Exclusivité d'accès à la frontière d'exécution

Si un acteur transfère la propriété d'un tampon $`B` à la passerelle FFI pour un appel étranger,
_l'acteur ne peut accéder à $`B` pendant l'exécution de l'appel_.
:::

:::proofsketch
Le tampon $`B` est modélisé par une capacité linéaire `WriteCap(B)` ; l'appel FFI est une coupure du
contexte linéaire qui transfère cette capacité de l'acteur vers la passerelle. Par élimination de
coupure, `WriteCap(B)` disparaît du contexte de l'acteur — toute tentative d'accès ultérieur y est
structurellement rejetée, non détectée après coup.

_Ce que cet énoncé ne dit plus, et pourquoi il a cessé de le dire._ Une seconde clause y figurait :
que le système hôte ne puisse accéder à $`B` après le retour. Elle ne suit pas de la même preuve, et
la remarque qui suit la réfute : le système de types sait _retirer_ une capacité du contexte d'un
terme qu'il gouverne, il ne sait pas la _révoquer_ chez un pair qu'il ne gouverne pas. C'est une
contrainte sur une sortie, non sur une entrée, et elle relève de l'exigence ci-après plutôt que de
ce théorème. Au retour, la passerelle restitue la capacité à l'acteur.
:::
::::

::::thm (label := "thm:revocation_ffi") (status := "exigence") (level := "representation")
:::title
révocation à la frontière étrangère
:::

:::statement +titled
Ce que le système de types ne peut pas tenir seul

Après le retour de la passerelle, le système hôte ne doit plus accéder à $`B`. Cette clause n'est
pas un théorème du langage : le typage retire une capacité du contexte d'un terme qu'il gouverne, il
ne la révoque pas chez un pair qu'il ne gouverne pas. Elle est une _exigence_ sur la réalisation de
la passerelle, qui doit invalider la référence côté hôte — par une table de poignées, une
génération, ou un mécanisme équivalent — et dont la vérification sort du système de types.
:::
::::

Les deux clauses de cet énoncé n'ont pas le même statut, et le dire évite de leur prêter la même
force. {rmq}[Une contrainte d'entrée se démontre, une contrainte de sortie s'organise. Seule la
première est ici un théorème.] Que l'acteur perde l'accès est une contrainte sur une _entrée_, et
elle suit de l'élimination de coupure. Que l'hôte ne le retienne pas est une contrainte sur une
_sortie_ — sur ce qu'un tiers peut encore faire après coup —, et la directionalité de la restriction
est ce qui sépare les deux régimes de raisonnement substructurel. Capabilités, bac à sable et
protocoles d'autorisation relèvent du second, dont la sûreté demande un argument dédié {cite "gouniSecurityReasoningSubstructural2026"}[].
La seconde clause repose donc sur la discipline de représentation de la passerelle — l'hôte n'ayant
détenu que des offsets relatifs bornés par le cycle de vie de la passerelle plutôt qu'un pointeur
absolu — et non sur le système de types.

S'il tient, la frontière d'exécution cesse d'être un trou dans la discipline de propriété : elle en
est un cas. S'il tombe sur sa seconde clause, l'appel étranger redevient un point où une capacité
peut fuir, et le postulat de sûreté mémoire s'arrête à la passerelle.

::::figure (label := "fig:circuit-breaker") (src := "session-circuit-breaker") (alt := "Diagramme de sequence a trois lignes de vie — pair distant, runtime de couche 1, fibrille de l'acteur. Le pair envoie un message portant un tag d'etat. Un cadre alternatif separe les deux cas — si le tag est conforme au protocole attendu, le runtime reveille la fibrille qui traite le message ; sinon le runtime rejette, et la fibrille n'est jamais reveillee, a cout nul pour elle.") (width := "90")
:::caption
Le circuit breaker de session : rejet avant réveil de la fibre
:::

:::desc
L'ordre des opérations au rejet : ce qui se décide avant que la fibrille ne soit réveillée, et ce
que le rejet lui coûte.
:::
::::

Rien de ce qui précède n'a besoin d'être réinventé pour la programmation probabiliste : elle en est
une spécialisation directe. Chaque pièce y a déjà son nom.

* Une particule est un acteur éphémère, activé sur un cœur inactif le temps de son calcul puis
  désactivé sans laisser de trace.

* L'arène qui porte ses $`N` échantillons, au format Arrow, est une arène PIA de plus, dimensionnée
  par un grade $`r`.

* `sample` et `observe` sont des effets algébriques ordinaires (chapitre 2,
  §{num "sec:c2-algebres-coalgebres-et-points"}[]) orchestrant des fonctions de vraisemblance pures
  de couche 3.

* Les poids d'importance vivent dans des registres atomiques de l'arène, accessibles en $`O(1)` sans
  verrou.

* La libération des ressources, le calcul terminé, est la restitution de l'arène et jamais un
  ramasse-miettes. L'architecture en trois couches absorbe donc l'infrastructure d'exécution de
  l'inférence probabiliste sans mécanisme dédié. Le raisonnement statique sur un programme
  probabiliste, en revanche, demande deux notions dont K7PL ne dispose pas. Le coût, d'abord : en
  présence d'effets probabilistes la grandeur pertinente est le coût _espéré_, et le coût au mieux
  ou au pire pour le non-déterminisme — analyses distinctes, dont chacune a dû être établie
  séparément avant qu'un cadre général ne les unifie {cite "EFFCOST"}[] —, tandis que la seule borne
  de coût de la couche 2 est un débit déterministe.

Ce débit demande à être dit, et la manière de le dire n'est pas celle qu'on attendrait. Un débit est
un rapport — des messages par unité de temps —, et une algèbre d'effets ne divise pas. Il ne
s'exprime donc pas comme une grandeur calculée mais comme un _calendrier déclaré dans le type_, au
moyen de trois modalités sur l'ordre linéaire des instants : $`\bigcirc A`, qui dit qu'un $`A` sera
disponible au pas suivant ; $`\Box A`, qu'il l'est à tout instant ; $`\Diamond A`, qu'il le sera
sans qu'on dise quand {cite "dasParallelComplexityAnalysis"}[]. Un flux dont chaque continuation
porte un $`\bigcirc` a un débit d'un message par pas, et cela se lit sur son type sans qu'aucun
rapport soit formé. La latence d'un pipeline est le nombre de $`\bigcirc` que traverse le type du
processus qui le compose. Lorsque le calendrier n'est pas bornable statiquement — un transducteur
qui compresse son entrée émet à un rythme que l'entrée seule ne détermine pas —, $`\Diamond` prend
le relais et énonce l'inévitabilité sans l'échéance.

Ces trois constructeurs sont la quatrième instance du procédé du chapitre 2
(§{num "sec:c2-adjonctions-et-enrichissement"}[]), l'ordre étant ici celui du temps. Deux raisons
rendent leur emprunt direct plutôt qu'analogique. L'analyse dont ils proviennent est paramétrique
dans le modèle de coût, ce qui la laisse compatible avec le référentiel que le
§{num "sec:c4-echelle-du-systeme"}[] vient de fixer — une machine, sa hiérarchie de caches. Et son
régime de communication est asynchrone au sens du $`\pi`-calcul asynchrone, c'est-à-dire celui que
le chapitre 3 a retenu. Ce que K7PL n'emprunte pas est la sémantique de réécriture temporisée sur
laquelle leur correction est établie : la nôtre reste à écrire.

Une dernière remarque borne ce que ces modalités permettent de revendiquer. Rendre le temps
structurel ouvre la possibilité d'énoncer qu'une durée ne dépend pas d'une donnée qu'elle ne devrait
pas révéler — la non-interférence appliquée à la composante temporelle plutôt qu'aux valeurs. Cette
possibilité a une limite, et elle n'est pas dans le langage : un canal temporel se referme
complètement au niveau du jeu d'instructions, par une conception du matériel qui contrôle le temps
au moyen du flot d'information, et les travaux qui l'établissent opèrent à l'échelle du système
entier. K7PL peut donc fermer les canaux que son système de types _voit_ — ceux qu'une branche
conditionnelle ou une itération à borne variable ouvrent dans le programme —, non ceux que le
matériel ouvre sous lui. Un cache dont le temps de réponse dépend de ce qui y a été écrit reste
invisible au typage. La revendication est donc bornée par la plateforme, exactement comme le
référentiel du modèle mémoire l'a été au §{num "sec:c4-echelle-du-systeme"}[], et cette borne doit
accompagner tout énoncé de non-interférence temporelle plutôt que le suivre.

La terminaison, ensuite : sur un calcul randomisé, un type utile atteste une probabilité $`q` de
réduction vers une valeur, éventuellement strictement inférieure à $`1` {cite "antonelliCurryHowardMeet2022"}[].
La journalisation de P4 rend le rejeu déterministe ; elle ne fournit aucun raisonnement sur la
distribution.

Ces deux notions sont déclarées hors périmètre, au même titre que l'extension Datalog envisagée au
chapitre 4. Hors périmètre, et non hors d'atteinte : les cônes mesurables modélisent la logique
linéaire intuitionniste, et la théorie de l'intégration qui leur manquait — l'ingrédient qui
interprète les primitives d'échantillonnage, pour l'appel par valeur comme pour l'appel par poussée
de valeur — a été développée {cite "ehrhardIntegrationCones2025"}[]. K7PL ayant retenu le CBPV
(§{num "sec:c1-axiomatique-germinale"}[]), c'est son propre régime d'évaluation qui rend cette
extension disponible. Ce que ce chapitre établit est plus étroit que ce qu'une lecture rapide y
verrait : l'inférence probabiliste n'avait besoin d'aucun mécanisme qu'elle ne possédât déjà.
