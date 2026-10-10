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

#doc (Manual) "Échelle de l'acteur" =>
%%%
file := "c4-echelle-de-l-acteur"
tag := "c4-echelle-de-l-acteur"
%%%

{label "sec:c4-echelle-de-l-acteur"}

Trois filiations se rejoignent ici. Le modèle d'acteurs de Hewitt, Bishop et Steiger donne la brique :
une entité dont le comportement se définit par la réaction à un message plutôt que par un état
partagé — ce que le chapitre 2 reformule en coalgèbre terminale. Le calcul de processus communicants
de Hoare complète l'intuition côté communication, un canal typé dont l'alternance stricte d'émission
et de réception fonde la dualité des protocoles du chapitre 3 et la synchronisation par anneaux
verrou-libres du §{num "sec:c4-echelle-du-systeme"}[]. Pony montre enfin, plus près de K7PL, qu'un
modèle d'acteurs zéro-copie et sans ramasse-miettes peut reposer sur des capacités de référence
prouvées à la compilation plutôt que sur un arbitrage à l'exécution — la lecture graduée que ce
chapitre hérite du §{num "sec:c3-le-systeme-gradue"}[].

La coalgèbre terminale qui définit un acteur (chapitre 2,
§{num "sec:c2-algebres-coalgebres-et-points"}[]) a besoin d'un lieu où loger son espace d'état ;
cette section décrit ce lieu et les opérations qui le maintiennent cohérent d'un pas de transition
au suivant.

Ce lieu est privé, et il vaut la peine de dire ce que cette privauté rapporte. K7PL ne se passe pas
d'état global par hygiène : dans une sémantique par objets, l'état n'est pas caché par convention,
il est partie de la structure interne d'un objet et *ne joue aucun rôle dans son comportement
observable* — ce qui rend la localité et la mono-filature d'un acteur modélisables au lieu d'être
postulées {cite "REDDY-GLOBAL"}[]. C'est la même discipline que le chapitre 3 applique aux valeurs,
transposée aux processus : ce qui n'est pas observable n'a pas à être décrit.

Deux acquis suivent de cette configuration, et sont revendiqués ici plutôt que redécouverts. Le
premier tient à la conjonction d'un fil à état privé et d'une composante de niveau dans le grade. Le
_canal de terminaison_ — la fuite d'information par le fait qu'un calcul termine ou non — a une
bande passante limitée en séquentiel et devient bien plus dangereux en concurrent, ce qui autorise
déjà une garantie par couche plutôt que globale. Le remède publié consiste à placer les actions
potentiellement non terminantes, ou celles dont le temps dépend de valeurs sensibles, dans des fils
séparés portant chacun une _étiquette courante_ qui suit la sensibilité observée et restreint où le
fil peut écrire {cite "stefanAddressingCovertTermination2012"}[]. Or un acteur _est_ un fil à état
privé, et la composante de niveau du grade _est_ cette étiquette. Le dispositif se lit presque terme
à terme dans ce document sans y avoir été imposé.

Une réserve doit accompagner cet acquis, car elle porte sur un canal _voisin et distinct_. Le canal
de terminaison n'est pas le canal de _temporisation_, et le remède ci-dessus ne ferme que le
premier. Pour le second, la propriété visée est la non-interférence probabiliste, qu'un système de
types suffit à garantir — mais les systèmes qui l'obtiennent le font au prix de restrictions
_sévères_, imposées précisément pour empêcher les fuites par le temps {cite "smithNewTypeSystem2001"}[].
La non-interférence temporelle ne s'ajoute donc pas à un système de types : elle en restreint
l'expressivité, et de combien est une question de conception que ce document n'a pas tranchée. S'y
ajoute un trou documenté dans lequel ce langage se place exactement : les descriptions matérielles à
contrôle de flot savent éliminer les canaux de temporisation, les langages logiciels savent garantir
la non-interférence. Mais les deux se construisent indépendamment et il n'existe aucune abstraction
pour _composer_ leurs garanties {cite "zagieboyloUsingInformationFlow2019"}[]. Un unikernel est la
jonction des deux.

Le second tient au pont entre les deux vocabulaires que ce chapitre emploie sans les relier. Il pose
que l'espace d'état d'un acteur est une instance de coalgèbre terminale, et le chapitre 3 pose les
types de session ; le pont entre les deux est affirmé et non construit. Il l'a été ailleurs, et
littéralement : les types de session _sont_ des états de coalgèbres, et la dualité des protocoles,
que le chapitre 3 pose comme définition, s'y obtient comme conséquence {cite "keizerSessionCoalgebrasCoalgebraic2021"}[].
C'est l'unification que ce chapitre annonce en ouverture, appliquée à l'endroit précis où il ne l'a
pas faite.

Un mot de vocabulaire s'impose avant d'y venir, car ce chapitre nomme une chose et en emploie deux.
Une _arène_ est une *disposition* — un bloc contigu, des composants rangés par famille, des
références qui sont des décalages. Une _région_ est une *discipline de portée* — le moment où une
allocation cesse d'être atteignable. Ce document a besoin des deux et n'a nommé que la première, de
sorte que la seconde s'y devine sans jamais s'y écrire. La nommer ne coûte pas l'appareil qu'on
redoute : la complication habituelle des systèmes à régions est en principe inutile, le
polymorphisme paramétrique ordinaire y suffisant, par une traduction qui préserve les types et le
sens {cite "fluetMonadicRegions2006"}[]. Le noyau portant déjà de la quantification, la portée
d'arène est une application du polymorphisme existant et non un dispositif de plus.

Cet espace d'état suit une architecture à composants (ECS) : les composants d'une même famille sont
rangés contigument, en tableau de structures inversé (SoA), dans une arène PIA — un bloc où toute
référence n'est qu'un offset relatif, jamais un pointeur absolu. Cela rend la mobilité de l'arène
entière $`O(1)` par `mremap` ou RDMA, sans qu'aucune référence n'ait à être réécrite. Un offset n'y
est cependant pas un entier ordinaire : il est statiquement teinté par la capabilité de la région
dont il provient. Le système de types (chapitre 3, §{num "sec:c3-le-systeme-gradue"}[]) interdit dès
lors à un offset issu d'une `ReadCap` sur une région d'indexer une autre région. La confusion entre
deux objets d'une même arène SoA est ainsi rendue non typable, plutôt que détectée à l'exécution.

Chaque entité de cet espace est référencée par un `EntityRef` de 64 bits — 32 bits d'index, 32 bits
de génération. La destruction procède par échange avec le dernier élément (_swap-and-pop_) pour
préserver la contiguïté de l'arène en $`O(1)`, tandis que l'incrément de génération à chaque
réutilisation d'un index prévient structurellement la confusion ABA. Une référence pendante vers un
index recyclé porte encore l'ancienne génération, et se distingue donc de la nouvelle occupante sans
qu'aucune vérification supplémentaire ne soit nécessaire.

C'est ici que les grades fractionnaires du chapitre 3 (§{num "sec:c3-le-systeme-gradue"}[]) trouvent
leur réalisation physique. Une arène est statiquement partitionnée en segments d'index contigus, un
par fibrille concurrente : la fibrille $`A` reçoit `WriteCap(Arena<T>, Range(0,k))`, la fibrille
$`B` reçoit `WriteCap(Arena<T>, Range(k+1,2k))`, et ces zones d'écriture ne se chevauchent jamais.
La preuve de grade établie à la compilation devient ici une partition mémoire effective, alignée sur
64 octets et placée sur le nœud NUMA local des cœurs assignés pour éliminer le _false sharing_. Le
parallélisme sans mutex de K7PL n'est rien d'autre que cette correspondance rendue explicite : un
type prouvé disjoint occupe une mémoire physiquement disjointe.

::::figure (label := "fig:arene-partition") (src := "soa-partitionning") (alt := "Une arene SoA figuree comme un seul bloc contigu, coupee en deux segments — segment 0 a k et segment k+1 a 2k. Chaque segment est rattache a une capacite d'ecriture distincte, WriteCap de la fibrille A et WriteCap de la fibrille B.") (width := "90")
:::caption
Partitionnement statique d'une arène SoA entre fibrilles concurrentes (SWMR)
:::

:::desc
Ce que devient en mémoire une preuve de disjonction établie à la compilation.
:::
::::

Le passage d'un état de la coalgèbre au suivant traverse enfin une promotion à deux vitesses. Un
`HandlerResult` est produit par un gestionnaire de couche 2 dont le corps calcule en couche 3, sur
des tableaux dont la disposition est celle d'Arrow. Il est d'abord validé, puis transféré vers
l'arène canonique de couche 1 ; ce transfert franchit une frontière de fragment et acquitte à ce
titre la transposition que le théorème {num "thm:isomorphisme_memoire"}[] signale. L'arène en
calcule un condensat cryptographique (BLAKE3), déterministe et _résistant aux collisions_. La
comparaison de deux condensats déjà calculés est en $`O(1)` ; leur calcul sur une structure de
taille $`n` est en $`O(n)`, payé une fois à la construction. Sous l'hypothèse de résistance aux
collisions — qui est une hypothèse cryptographique déclarée, non un théorème du langage —, l'égalité
des condensats vaut égalité structurelle, et la déduplication s'y ramène. La transition
$`\text{out} : \nu G \to G(\nu G)` du chapitre 2 n'est, physiquement, que ce commit suivi de ce
hachage. Les objets canoniques devenus orphelins sont purgés lors de la rotation du journal plutôt
que par un ramasse-miettes. Pour les structures continues de grande taille, une projection
optionnelle sur le réseau de Leech accélère l'indexation vectorielle approchée, sans jamais s'y
substituer à l'égalité exacte que le hachage garantit.

Cette identité de format n'est pas propre à la promotion canonique : elle vaut de bout en bout entre
l'arène et le réseau.

::::proposition (label := "thm:isomorphisme_memoire") (level := "representation") (role := "proposition") (state := "under-review") (evidence := "proofsketch") (scope := "interoperability")
:::title
correspondances de disposition, transfert zéro-copie
:::

:::statement +titled
Domaine exact du transfert sans copie

Soit $`T` un type scalaire primitif de largeur fixe, et $`\Pi = \langle v_{\mathrm{Arrow}}, v_{\mathrm{Capnp}}, v_{\mathrm{MLIR}} \rangle` les versions des trois spécifications, avec un ordre des octets déclaré (_little-endian_ ni pour l'un ni pour l'autre invariant portable sans déclaration). Alors les trois dispositions suivantes
coïncident bit à bit, la coïncidence étant vérifiée à la compilation par comparaison de trois entiers — largeur de créneau, alignement, ordre des champs — pour la version de schéma de l'artefact : le tampon de valeurs d'un `Vec n T` de couche 3 ; le tampon de valeurs d'un
tableau Arrow de type $`T` et de longueur $`n`, son _bitmap de validité_ étant omis ; et la charge
utile d'une liste primitive Cap'n Proto de $`n` éléments de $`T`. Le transfert d'un pointeur y
dispense de toute copie, à une condition et non par conséquence : le tampon doit déjà être un segment de message aligné, ce que l'arène produit, et l'écriture d'un mot de pointeur de liste reste requise côté Cap'n Proto.

Hors de ce domaine, la coïncidence cesse, et pour une raison unique : dès que l'élément n'est plus
un scalaire mais une structure, Arrow décompose la donnée en un tampon par champ tandis que Cap'n
Proto impose une liste composite où les champs d'un même élément sont adjacents. Les deux
dispositions sont alors transposées l'une de l'autre.
:::

:::proofsketch
Un tableau primitif Arrow est un unique tampon contigu dont la taille vaut au moins la largeur de
créneau multipliée par la longueur, et son bitmap de validité peut être omis lorsque le compte de
nuls est nul : la couche 3 étant totale, un `Vec n T` n'a jamais de valeur absente. Une liste Cap'n
Proto d'éléments non composites est de son côté un tableau plat de valeurs. Les trois
représentations sont donc le même tableau contigu, et l'alignement sur 64 bits de l'abaissement MLIR
satisfait le minimum de 8 octets qu'Arrow impose à la sérialisation. Hors de ce domaine, Cap'n Proto
exige qu'une liste de structures soit encodée en composite — disposition orientée ligne — quand
Arrow répartit les mêmes données en un tampon par champ ; aucun réencodage local ne les réconcilie,
et le passage de l'une à l'autre est une transposition en $`O(n)`.
:::

::::
Les deux spécifications sont normatives sur ce point, et c'est d'elles que l'énoncé tire sa forme.
Arrow définit le tampon primitif contigu et l'omission licite du bitmap de validité quand le compte
de nuls est nul {cite "SpecificationsApacheArrow"}[]. Cap'n Proto définit la liste plate de valeurs,
l'encodage du pointeur distinguant les largeurs d'un bit à huit octets, et impose la disposition
composite dès que l'élément est une structure — un mot d'étiquette suivi des structures contiguës,
chacune portant sa section de données puis sa section de pointeurs {cite "CAPNPROTO-SPEC"}[].

La vérification se fait donc à la compilation, et il faut dire comment. {rmq}[Trois entiers par
type, comparés. Pas une inspection de représentation.] La coïncidence bit à bit n'est pas une
propriété à prouver au cas par cas. C'est une égalité entre trois formules de disposition, et trois
nombres la déterminent pour un type donné — la largeur de créneau, l'alignement exigé, l'ordre des
champs. Les deux spécifications les publient : Arrow recommande un alignement sur huit ou
soixante-quatre octets et l'impose lorsque la donnée est sérialisée pour une communication entre
processus. Cap'n Proto aligne tout objet sur des mots de huit octets et chaque primitif sur un
multiple de sa propre taille. La comparaison est décidable.

Ce que les spécifications ne donnent pas ne doit pas leur être prêté. Aucune des deux ne publie de
mesure de transposition. La borne linéaire annoncée ici tient à la forme de l'opération — lire $`n`
créneaux, en écrire $`n` — et non à un résultat expérimental.[^fn1]

[^fn1]: Ce qu'elles donnent à la place est un motif de conception chiffré. Cap'n Proto refuse d'encoder une liste de structures comme une liste de pointeurs, parce que cela coûterait un pointeur de plus par élément et serait moins favorable au cache. C'est une justification de disposition, non une mesure.

S'il tient, trois conséquences suivent. La couche 3 échange ses tableaux de scalaires sans copie, ce
qui est son usage principal. La couche 2 échange ses messages sans copie tant qu'ils sont bornés —
P3 interdisant le franchissement de segment, aucun _far pointer_ n'est engendré — et tant que leurs
listes sont primitives. Et le franchissement de la frontière entre couches coûte une transposition
dès qu'une liste de structures est en jeu, coût qui tombe exactement là où le délimiteur change
(chapitre 5, §{num "sec:c5-s-expressions-universelles"}[]) : une frontière, une marque, un prix.
S'il tombe — si les dispositions cessaient de coïncider sur les scalaires —, le zéro-copie
disparaîtrait du langage, et avec lui l'argument selon lequel l'arène et le réseau partagent un seul
format. Le zéro-copie de K7PL n'est de toute façon pas une propriété globale : il vaut sur les
scalaires, et se paie sur les structures.
