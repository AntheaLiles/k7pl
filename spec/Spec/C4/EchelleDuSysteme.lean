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

Cette section décrit le modèle abstrait du système et les obligations qui en découlent.
Les descriptions d'environnements d'exécution, de disposition mémoire, de synchronisation et de
persistance qui suivent sont des exemples de réalisation, non des exigences architecturales de K7PL.
Elles ne suffisent pas, à elles seules, à établir la conformité d'une implémentation ni la portée
d'une garantie normative.

Le modèle abstrait doit distinguer les états des acteurs, leurs transitions et les interactions avec
l'environnement. À la frontière d'une interface étrangère, le contrat doit spécifier les valeurs
et effets exposés ainsi que les conditions de retour et d'échec. La déclaration de cette interface
porte un attribut explicite `unsafe` : il signale les obligations propres à cette frontière et
n'autorise ni un mode d'exécution non sûr général ni l'affaiblissement des invariants du code K7PL.
L'attribut est porté par la liste d'attributs de la déclaration dans la notation à expressions
symboliques. L'élaboration doit le préserver jusqu'à la vérification de l'interface et rejeter une
déclaration étrangère qui ne le porte pas. Cet attribut ne confère aucun droit sur l'état interne
protégé. La préservation de
ces invariants doit être établie pour toutes les transitions autorisées par le contrat, y compris les
transitions d'échec ; elle ne suppose pas que le service étranger respecte fonctionnellement son
contrat.

Par défaut, l'état interne protégé comprend tout état dont K7PL assure la représentation, les
transitions, l'autorité, l'intégrité ou la durée de vie. Cela inclut notamment l'état des acteurs ;
les régions mémoire, les capacités, l'identité et la durée de vie des objets ; les messages, les
boîtes aux lettres et les états de protocole ; l'état de l'orchestrateur et de l'ordonnanceur ; les
instantanés et les journaux ; ainsi que les budgets et le contexte temporel gérés par K7PL. Cette
énumération illustre la règle générale et ne limite pas sa portée aux catégories citées. Le contrat
peut exposer des valeurs, observations ou opérations déterminées ; cette exposition n'accorde aucun
droit supplémentaire au-delà de ce qu'il autorise explicitement. Les chemins d'échec, d'annulation,
de reprise et de restauration sont soumis à la même exigence de préservation.

Ces exigences ne sélectionnent aucun mécanisme de séparation concret. Le modèle abstrait ne
démontre pas à lui seul qu'une implémentation native empêche un code étranger d'accéder à des
adresses internes : cette correspondance et les restrictions effectives imposées à l'exécution
restent des obligations de conformité propres à l'implémentation et au profil visé.

Un acteur virtuel est une adresse logique dans le modèle abstrait. Le cycle de vie distingue les
états actif et inactif et exige la préservation de l'état observable lors des transitions. Une
réalisation peut sérialiser l'état inactif dans un instantané journalisé, restituer sa mémoire puis
rejouer les messages consignés lors de la réactivation. L'instantané, le journal, la restitution
physique et l'atomicité de l'activation sont des choix de réalisation ; les coûts et les limites de
capacité dépendent du profil retenu.

::::figure (label := "fig:acteur-cycle-de-vie") (src := "virtual-actor-lca") (alt := "Cycle à deux états. Un point initial mène à Désactivé. De Désactivé vers Actif, l'activation charge l'instantané et rejoue le journal. Sur Actif, une boucle figure le traitement de message. D'Actif vers Désactivé, l'inactivité gèle l'état, le persiste et libère la mémoire.") (width := "90")
:::caption
Exemple de cycle de vie par instantané et rejeu
:::

:::desc
Ce schéma illustre une réalisation possible par instantané et rejeu ; il ne fixe pas la
représentation exigée par le modèle abstrait.
:::
::::

Pour une réalisation fondée sur des instantanés, le coût du gel dépend du format de l'état et du
journal. La possibilité d'un transfert sans copie dépend de la correspondance entre la représentation
et le journal ; elle n'est pas garantie pour toutes les représentations. Un format compatible avec la disposition en colonnes peut
permettre un transfert de segment ; une liste de structures peut nécessiter une transposition en
$`O(n)`. Ces coûts décrivent des représentations déterminées, non une propriété générale du cycle
de vie.

Une réalisation peut employer le modèle LMAX Disruptor : un compteur 64 bits incrémenté par le
producteur et sondé par le consommateur, avec publication en _release_ et consommation en _acquire_.
Ce schéma est un exemple d'implémentation, non une exigence du modèle abstrait. L'absence d'appel
système, d'endormissement ou de sémaphore et les coûts annoncés doivent être vérifiés pour la
réalisation retenue.

La note d'ingénierie citée documente une réalisation de file et ses mesures, mais ne constitue pas
une preuve de correction. Les travaux sur les files bornées concurrentes sous modèle mémoire faible
présentent des preuves mécaniques en logique de séparation, où l'ordre entre accès est exprimé par
un transfert de vue {cite "mevelFormalVerificationConcurrent2021"}[]. Ces preuves portent sur le modèle
et l'implémentation qu'elles étudient ; elles ne valident pas automatiquement une réalisation K7PL.

Pour une file concurrente fondée sur un modèle mémoire faible, le progrès du consommateur peut
dépendre d'une hypothèse d'équité mémoire : le système mémoire propage équitablement les écritures
publiées {cite "lahavMakingWeakMemory2021"}[]. Cette hypothèse ne découle pas de la seule présence
de barrières. Les résultats cités portent sur des modèles déterminés ; ils n'établissent pas la
correction d'une réalisation K7PL qui n'a pas été spécifiée. Le choix des barrières et la preuve de
progrès restent des obligations de raffinement.

Dans un profil qui retient la persistance avec rejeu, les sources non déterministes — horloge,
générateur aléatoire et autres entrées de l'environnement — doivent être consignées dans le journal
puis remplacées par les valeurs enregistrées lors du rejeu. Le résultat observationnel attendu dépend
de la complétude du journal et de la fidélité du runtime ; il ne découle pas de la seule persistance.
L'identité bit à bit est une propriété distincte, conditionnée par le profil de représentation $`\Pi`
et les hypothèses $`E_{\text{repro}}` ; elle n'est pas intrinsèque à la persistance ni au langage.

::::theorem (label := "thm:determinisme_rejeu") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "runtime")
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

:::note
_Obligation ouverte._ La complétude du journal est une prémisse explicite de l'énoncé. Restent à
définir le schéma du journal, la relation $`\approx_{\text{obs}}` et les composantes d'état
comparées, puis à montrer que le rejeu substitue exactement les résultats de capacité consignés.
:::
::::
::::corollary (label := "thm:rejeu_binaire") (level := "representation") (role := "corollary") (state := "under-review") (evidence := "proofsketch") (scope := "runtime")
:::title
identité binaire du rejeu, sous environnement reproductible
:::

:::statement +titled
Le pas que la pureté ne franchit pas

Sous l'hypothèse $`E_{\text{repro}}` — ordonnancement, mode d'arrondi flottant, version de la
chaîne de compilation et architecture, comportement des NaN compris, identiques entre l'exécution et
le rejeu — et sous l'hypothèse $`H_{\text{repr}}` d'invariance de la représentation — deux états
atteignables observationnellement égaux ont la même représentation sous le profil $`\Pi` :
$`x \approx_{\text{obs}} y \Rightarrow \operatorname{repr}_{\Pi}(x) = \operatorname{repr}_{\Pi}(y)`
—, l'égalité du théorème précédent est une identité binaire :
$`\text{Rejeu}(J(H), S_0) =_{\text{bit}} S_{\text{final}}`.
:::

:::proofsketch
Sous $`E_{\text{repro}}`, la représentation d'une valeur dénotée est fonction de la seule chaîne de
compilation, et l'ordre d'évaluation est fixé ; l'égalité observationnelle du
théorème {num "thm:determinisme_rejeu"}[] se transporte alors, par $`H_{\text{repr}}`, en identité
de représentation.

_Trois rejeux, une seule relation._ Ce document en distingue trois — le rejeu logique, l'identité
binaire, et le rejeu stratifié par niveau du §{num "sec:g-semantique"}[] — et ils ne sont pas trois notions mais _trois
instances de la même_ : l'égalité modulo une projection. Le premier projette sur l'observation, le
deuxième sur la représentation, le troisième sur un niveau. Les trois sont donc des instances du
schéma de restriction (chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:schema_restriction"}[]), et ce qui les sépare est leur critère, non leur forme.
Une hypothèse supplémentaire est en outre requise ici et le dire évite de la découvrir : l'identité
binaire demande que la représentation soit _invariante_ par l'équivalence observationnelle, ce
qu'est $`H_{\text{repr}}`, faute de quoi deux états observationnellement égaux pourraient avoir deux
images distinctes ; l'injectivité de la représentation ne le donne pas. Aucune des trois
composantes de $`E_{\text{repro}}` n'est fixée par ce document, et le journal n'en consigne
aucune : l'hypothèse est portée par l'environnement d'exécution, non par le langage.
:::

:::note
_Obligation ouverte._ Restent à définir l'application de représentation
$`\operatorname{repr}_{\Pi}` et une sérialisation déterministe, à fixer le profil
$`E_{\text{repro}}`, et à établir $`H_{\text{repr}}` pour le profil visé : c'est l'invariance de la
représentation, et non son injectivité, qui fait passer de l'égalité observationnelle à l'identité
binaire. Hypothèses d'environnement et conclusion binaire sont à suivre séparément.
:::
::::
Ces hypothèses éparses se rassemblent en un seul objet, le _profil de représentation_
$`\Pi = \langle v_{\mathrm{Arrow}}, v_{\mathrm{Capnp}}, v_{\mathrm{MLIR}}, \mathrm{arch}, \mathrm{mem}, \mathrm{round}, v_{\mathrm{schéma}} \rangle` : versions des trois
spécifications de disposition, architecture et comportement NaN, modèle mémoire, mode d'arrondi,
version de schéma. $`E_{\text{repro}}`, la portée « une machine » du modèle mémoire et la convention
d'élision de champ en sont trois projections. Il en résulte que les théorèmes de disposition
({num "thm:isomorphisme_memoire"}[]) et de rejeu binaire ({num "thm:rejeu_binaire"}[]) sont des
propriétés de _conformité du compilateur_ à un profil donné, vérifiées par le pipeline de validation
de la phase 7, et non des théorèmes du calcul des types.

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
K7PL énonce l'absence de blocage sous la simulation du graphe d'attente
(théorème {num "thm:deadlock_acyclique"}[]) ; il n'établit ni le progrès global, que des systèmes
linéaires minimaux obtiennent du seul typage {cite "jacobsSelfDualDistillationSession2022"}[], ni la
terminaison équitable, propriété qu'appellerait son régime asynchrone {cite "PADOVANI"}[].

Le modèle abstrait ne fixe pas le mécanisme d'isolation entre acteurs. Les garanties de typage
peuvent établir des propriétés logiques d'accès dans le modèle ; elles ne démontrent pas, à elles
seules, l'absence de canaux cachés ni l'inaccessibilité physique de la mémoire. Un espace
d'adressage partagé, une isolation assurée par le compilateur ou un modèle de composants comme
WebAssembly constituent des options de réalisation aux hypothèses distinctes
{cite "groupWebAssemblySpecification,groupWebAssemblySpecAddendum,groupWebAssemblyCodeMetadata"}[].
Aucune n'est imposée ici. Toute réalisation doit établir sa correspondance avec les invariants du
modèle et les hypothèses d'exécution qu'elle retient.

::::lemma (label := "thm:liberte_initialisation") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "runtime")
:::title
liberté d'initialisation par DAG topologique
:::

:::statement +titled
Câblage complet sans interblocage

Si le graphe de dépendances $`G` des acteurs et canaux est acyclique — vérifié en Phase 1.5
(chapitre 6, §{num "sec:c6-le-processus-de-compilation"}[]) —, la phase d'initialisation atteint un
état entièrement câblé sans interblocage : $`\text{Acyclique}(G) \implies \exists` un tri
topologique $`T` tel que $`\forall n \in T`, l'initialisation de $`n` se termine sans blocage.
:::

:::proofsketch
Un interblocage à l'initialisation impliquerait une attente circulaire, correspondant
structurellement à un cycle dans $`G` ; la Phase 1.5 calcule le tri topologique de $`G` et échoue la
compilation si un cycle est détecté (`ERR-ARC-001`). Étant donné $`G` acyclique, le tri topologique
existe (chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:tri_topologique"}[]) et l'ordre qu'il donne est l'ordre d'initialisation : chaque
nœud n'y est atteint qu'après ses dépendances, jusqu'au câblage complet.
:::

:::note
_Obligation ouverte._ L'acyclicité donne un ordre, non la terminaison de chaque initialisation :
restent à poser la terminaison locale de l'initialisation d'un nœud et la correspondance exacte
entre attentes dynamiques et arêtes de $`G`.
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
garantie, dont le non-respect entraîne une erreur de compilation. La modestie ne vaut d'ailleurs pas de
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

Le modèle abstrait définit les canaux typés, les messages admissibles et les transitions de
communication ; il ne fixe ni la représentation du transport ni le coût de chaque opération. Un
anneau SPSC borné et alloué avant exécution, ou une table d'entrées, sont des réalisations possibles.
L'absence de verrou, le coût des retraits groupés et la correction concurrente doivent être justifiés
pour la représentation et la cible retenues. Un motif de jonction $`x(u) \mid y(v) \triangleright P`
décrit les messages requis par une transition sans imposer un masquage binaire ou un automate concret.
La couverture syntaxique des combinaisons doit être établie par une analyse statique du motif. Un
modèle de performance, éventuellement exprimé en PEPA (_Performance Evaluation Process Algebra_,
Hillston) {cite "hillstonCompositionalApproachPerformance"}[], peut analyser un comportement
quantifié ; il ne remplace ni l'analyse de couverture, ni la définition sémantique du motif, ni la
preuve de raffinement :

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

Un acteur peut exprimer l'attente simultanée d'un résultat et d'une échéance par deux clauses d'un
même motif. Dans le profil qui adopte la couverture exhaustive, les combinaisons admissibles non
couvertes sont à rejeter en compilation ; l'analyse exacte dépend du prédicat d'appariement qui reste
à formaliser.

Une réalisation qui utilise une file en mémoire partagée doit respecter le modèle mémoire choisi.
Les tailles des lignes de cache et les mesures prises pour limiter le faux partage dépendent de la
cible ; séparer les curseurs de production et de consommation peut être utile, mais ce choix
d'implantation n'est pas imposé par l'équation source. Les barrières effectivement émises doivent
être justifiées par le modèle mémoire et le raffinement de la réalisation.

Le modèle mémoire utilisé par une réalisation doit être déclaré explicitement. SPIR-V illustre un
mécanisme de sélection, sans imposer sa syntaxe à K7PL {cite "SPIRV"}[]. Le modèle retenu pour les
opérations de mémoire partagée est acquisition-libération : une libération ordonne les accès qui la
précèdent, une acquisition ordonne ceux qui la suivent, et leur appariement établit l'antériorité
entre deux fibrilles. Ce choix ne définit pas de profil matériel et ne fournit pas de borne de temps
absolue. Toute borne de temps d'exécution chiffrée devra nommer le profil auquel elle s'applique.
Pour la réalisation choisie, les barrières nécessaires et suffisantes doivent être justifiées par la
preuve de raffinement et les hypothèses de progrès, non par le seul comptage des opérations.

Dans un profil où plusieurs fibrilles partagent la mémoire d'une même instance d'exécution, le
modèle acquisition-libération gouverne cette mémoire partagée. Entre instances distinctes, l'ordre
des messages dépend du protocole de communication retenu ; le journal est une option, non une
architecture imposée. Le modèle abstrait ne fixe ni le nombre de machines, ni la hiérarchie de caches,
ni le nombre de cœurs. Toute garantie temporelle chiffrée doit déclarer le profil qui lui donne un
référentiel.

::::lemma (label := "thm:sync_motifs_jonction") (level := "langage") (role := "lemma") (state := "under-review") (evidence := "proofsketch") (scope := "concurrency")
:::title
transition de jonction sur appariement admissible
:::

:::statement +titled
Condition nécessaire à une transition

Soit $`J \triangleq x\langle u \rangle \mid y\langle v \rangle \triangleright P` un motif de
jonction. Une transition $`M \xrightarrow{J} P` n'est autorisée que si $`M` contient
simultanément un appariement de messages sur $`x` et $`y` compatible avec le motif et
satisfaisant ses conditions de garde. La seule présence de messages sur chacun des deux canaux est
nécessaire, mais ne suffit pas à caractériser la transition. Le prédicat d'appariement et la règle
complète de consommation restent à formaliser.
:::

:::proofsketch
La règle {sc}[Guard] (§{num "sec:g-couche2"}[]) relie le motif à la consommation de ressources
linéaires ; le produit tensoriel $`x \otimes y` exprime l'exigence simultanée des deux
messages. Cet argument ne définit ni le choix d'un appariement admissible ni la réalisation
atomique de la consommation. Un anneau SPSC, un masquage binaire ou un échange atomique de
pointeurs sont des choix d'implémentation ; aucun ne découle de la règle abstraite et chacun
demande une preuve de raffinement.
:::

:::note
_Obligation ouverte._ Formaliser le prédicat d'appariement — types, motifs, charges et gardes —,
la sélection des messages et la transition qui les consomme ensemble sans double consommation.
La propriété sémantique ne démontre ni l'atomicité d'une réalisation ni son absence de verrou.
:::
::::

La boîte aux lettres abstraite est un multi-ensemble de ressources linéaires indexé par canal,
$`\mathsf{Mailbox} = \Sigma_{c \in \mathsf{Chan}}\,\mathsf{Bag}(\mathsf{Cap}(c))`. La relation de
transition doit définir l'appariement et la consommation conjointe des messages retenus ; la
représentation et la primitive atomique éventuelles relèvent du raffinement.
Quatre résultats de ce document en sont des lectures : l'activation
conditionnelle ci-dessus ; le circuit breaker de session, qui compare le tag d'un message à ce que la
boîte attend ; la ré-invocation séquentielle d'un grade fini ; et la traduction d'un service répliqué
$`!x(y).P`. Il suffit de poser l'objet une fois pour que chacun s'énonce comme sa restriction ; la
reprise de leurs énoncés sur cette définition unique reste à faire.

L'énoncé est _local_ : il porte sur une jonction prise isolément. {rmq}[L'atomicité locale est
esquissée, la localité ne l'est pas. Les deux mots se ressemblent et ne disent pas la même chose.]
La propriété dont l'architecture a besoin est distincte et ne s'en déduit pas — la _localité_ au
sens de Herlihy et Wing, c'est-à-dire la conservation de la correction lorsque des objets corrects
sont composés horizontalement, ce que le graphe de câblage fait par construction. Son traitement
compositionnel est un problème à part entière, dont la formulation connue ne repose ni sur
l'atomicité ni directement sur l'ordre _happens-before_, et qui signale qu'un modèle compositionnel
naïf produit des comportements émergents à l'élément neutre {cite "oliveiravaleCompositionalTheoryLinearizability2023"}[].
K7PL revendique l'atomicité de la transition dans le modèle abstrait, non la localité compositionnelle.
Cette propriété ne prouve ni l'absence de verrou ni un coût constant par activation ; ces garanties
dépendent du raffinement, de l'ordonnanceur et du profil d'exécution retenu.

Dans le modèle abstrait, un message dont l'étiquette d'état ne correspond pas au protocole attendu
est rejeté avant la reprise de l'acteur. Une lecture de tag, une comparaison entière et un échange de
pointeur sont une réalisation possible, non une prescription du langage ; les opérations exactes et
leur coût dépendent du runtime. Le comportement du pair distant en cas de rejet reste non spécifié.

::::figure (label := "fig:circuit-breaker") (src := "session-circuit-breaker") (alt := "Diagramme de séquence à trois lignes de vie : pair distant, runtime de couche 1 et fibrille de l'acteur. Le pair envoie un message avec un tag d'état. Si le tag est conforme, le runtime réveille la fibrille qui traite le message ; sinon, il rejette localement le message sans réveiller la fibrille. Les opérations de rejet sont payées par le runtime.") (width := "90")
:::caption
Exemple de circuit breaker de session : rejet avant reprise de l'acteur
:::

:::desc
Ce diagramme illustre une réalisation possible : un message conforme déclenche le traitement de
l'acteur, tandis qu'un tag non conforme est rejeté avant sa reprise. Il ne fixe ni les opérations du
runtime ni la réponse du pair distant.
:::
::::

Le modèle abstrait ne fixe ni le protocole de transport ni le format des jetons d'autorisation.
Noise pour l'établissement de session et Biscuit pour les jetons sont des options de réalisation ;
leurs coûts et propriétés de sécurité doivent être établis indépendamment des grades K7PL. Les
contraintes d'alignement et de placement NUMA de l'arène des acteurs sont précisées dans
« EchelleDeLActeur ». D'autres grades matériels, par exemple SIMD ou GPU, ainsi que leur résolution
par l'orchestrateur, ne sont pas définis par ce passage.

Lorsque la communication franchit la frontière du système lui-même, vers un système d'exploitation
hôte, le contrat doit préciser la propriété du tampon transféré par la passerelle VirtIO {cite "VIRTIO"}[].
Le protocole VirtIO définit une _virtqueue_ composée de zones distinctes — table de descripteurs,
anneau disponible côté pilote, anneau utilisé côté périphérique —, mais cette organisation ne prouve
pas à elle seule que l'hôte ne conserve aucun accès après le retour. La réalisation doit établir les
conditions de transfert, de restitution et de révocation ; le mécanisme qui garantit ces propriétés
reste ouvert.

Le système de types peut retirer une capacité du contexte qu'il gouverne, mais ne suffit pas à
révoquer un accès déjà accordé à un composant étranger. Des protocoles d'accès distant emploient
notamment des mécanismes explicites d'invalidation {cite "recioRemoteDirectMemory2007a"}[], sans que
cet exemple impose une réalisation à K7PL. Le contrat de frontière doit garantir qu'une capacité
révoquée ne permet plus d'accès ; le mécanisme qui établit cette propriété reste ouvert. Cette
frontière FFI, l'exécution des macros avant vérification et l'importation de sources externes
(chapitre 5, §{num "sec:c5-mise-en-pratique"}[]) sont trois cas distincts dont les autorités,
les effets et les garanties doivent être précisés à leur niveau respectif.

::::theorem (label := "thm:surete_ffi") (level := "langage") (role := "theorem") (state := "under-review") (evidence := "proofsketch") (scope := "ffi-safety")
:::title
retrait de capacité d’écriture dans le contexte linéaire
:::

:::statement +titled
Disponibilité de la capacité pendant l’appel

Dans le modèle abstrait, si l’appel FFI transfère `WriteCap(B)` du contexte linéaire de l’acteur
à celui de la passerelle, cette capacité n’est plus disponible dans le contexte de l’acteur pendant
l’appel. Toute opération dont le typage exige cette capacité est donc rejetée dans ce contexte.
:::

:::proofsketch
Le transfert retire `WriteCap(B)` du contexte linéaire de l’acteur et la confie à la passerelle.
L’élimination de coupure conserve ce retrait pendant l’appel ; une dérivation qui exige cette
capacité ne peut donc pas être construite à partir du contexte de l’acteur.
:::

:::note
_Portée de l’énoncé._ Cette esquisse concerne uniquement la capacité `WriteCap(B)` dans le modèle
abstrait. Elle ne démontre ni l’absence d’autres droits ou alias vers le tampon ni la conformité
d’un appel natif. La révocation après retour relève de l’exigence distincte qui suit.
:::
::::
::::requirement (label := "thm:revocation_ffi") (level := "representation") (state := "not-applicable") (evidence := "none") (scope := "ffi-safety")
:::title
révocation à la frontière étrangère
:::

:::statement +titled
Ce que le système de types ne peut pas tenir seul

Après le retour de la passerelle, l'interface étrangère ne doit plus pouvoir accéder à $`B`, selon
le contrat de transfert défini pour cet appel. Cette clause n'est pas un théorème du langage : le
typage retire une capacité du contexte d'un terme qu'il gouverne, mais ne révoque pas à lui seul un
accès détenu par un composant étranger. La réalisation doit établir cette propriété. La représentation
des références, le mécanisme de restitution ou de révocation et les moyens de vérification restent
ouverts ; aucun mécanisme particulier n'est imposé ici.
:::

:::note
_Obligation ouverte._ Restent à définir la condition observable après le retour et à vérifier que
la réalisation de la passerelle empêche tout accès ultérieur non autorisé au tampon transféré. Le
mécanisme de vérification et de révocation reste ouvert ; cette exigence ne se vérifie pas par le typage.
:::
::::
Le retrait d’une capacité du contexte typé et la révocation d’un accès déjà accordé sont des
obligations distinctes ; la seconde exige un argument de sûreté propre à la frontière
{cite "gouniSecurityReasoningSubstructural2026"}[].


Rien de ce qui précède n'a besoin d'être réinventé pour la programmation probabiliste : elle en est
une spécialisation directe. Chaque pièce y a déjà son nom.

* Une particule est un acteur éphémère, activé sur un cœur inactif le temps de son calcul puis
  désactivé sans laisser de trace.

* L'arène qui porte ses $`N` échantillons, au format Arrow, est une arène PIA de plus, dimensionnée
  par un grade $`r`.

* `sample` et `observe` sont des effets algébriques ordinaires (chapitre 2,
  §{num "sec:c2-algebres-coalgebres-et-points"}[]) orchestrant des fonctions de vraisemblance pures
  de couche 3.

* Une réalisation peut stocker les poids d'importance dans des registres atomiques de l'arène ;
  le coût $`O(1)` et l'absence de verrou doivent alors être établis pour le profil retenu.

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
dans le modèle de coût, ce qui la laisse compatible avec un référentiel de coût à déclarer pour chaque profil. Le présent
chapitre ne fixe ni machine cible ni hiérarchie de caches. Son régime de communication est asynchrone au sens du $`\pi`-calcul asynchrone, c'est-à-dire celui que
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
