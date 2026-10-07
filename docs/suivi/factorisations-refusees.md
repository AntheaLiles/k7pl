# Factorisations refusées — et pourquoi

## Pourquoi ce fichier existe

Une campagne de relecture produit deux listes : ce qu'il faut factoriser, et ce qu'il ne faut pas. La seconde est la plus facile à perdre, parce qu'elle ne laisse aucune trace dans le document — un refus bien exécuté ressemble à une absence.

Sept fusions ont été examinées et refusées. Chacune était tentante, et six des sept l'étaient parce que les objets qu'elle rapprochait *ont la même forme*. C'est précisément le cas où la factorisation est dangereuse : elle masque une différence d'obligations sous une ressemblance de notation.

## REFUS-01 — le grade et l'indice de taille

**La tentation.** Les deux vivent dans le même semi-anneau, se notent pareillement et se composent pareillement. Le chapitre 2 écrit même qu'une taille *est* un grade.

**Le motif du refus.** Un indice de taille doit être pris dans un fragment dont l'ordre strict est bien fondé ; un grade n'a pas cette obligation, et le porteur contient des rationnels dont l'ordre ne l'est pas. Mêmes objets, ordres différents, obligations différentes.

**Où le manuscrit le dit.** Chapitre 2, à la clause de bonne formation : tout indice de taille est pris dans l'une des deux sortes, et un grade quelconque n'est pas une taille recevable.

## REFUS-02 — la comonade d'usage et la comonade cofree

**La tentation.** Ce chapitre construit une comonade graduée et sa structure de Kleisli ; l'histomorphisme réclame une comonade. On pourrait croire le second dérivable de la première.

**Le motif du refus.** Ce sont deux comonades et deux rôles. Celle qu'un histomorphisme demande est la comonade cofree du foncteur de motif, celle qui accumule l'historique ; la modalité d'usage dit combien de fois une ressource est employée. Aucune raison qu'elles se confondent, et une donnée structurelle supplémentaire sépare la seconde de la première.

**Où le manuscrit le dit.** Chapitre 2, §2.3 : « Deux comonades, deux rôles, et aucune raison qu'elles se confondent. »

## REFUS-03 — le graphe de câblage et le graphe d'attente

**La tentation.** Mêmes sommets, mêmes arêtes à l'œil, et l'un sert à établir une propriété de l'autre.

**Le motif du refus.** Leurs régimes de définition sont opposés. Le câblage est donné en entier à la compilation : fini, statique, il se traite inductivement. L'attente se déplie au fil des activations et n'est jamais donnée : c'est un objet coinductif. Traiter le second comme le premier reviendrait à lire un objet coinductif par induction.

**Ce que ce refus a valu.** C'est le seul endroit du document où une preuve *nomme* l'étape qui lui manquait au lieu de la supposer acquise. La simulation du graphe d'attente y a été écrite comme une prémisse, puis établie le 1er octobre quand la couche 2 a reçu ses règles — l'arête d'attente étant devenue une arête de dépendance par construction du typage.

## REFUS-04 — les deux projections

**La tentation.** Même forme, même notation à un indice près, et toutes deux projettent.

**Le motif du refus.** Leurs emplois sont *opposés*. L'une est conservatrice, l'autre observationnelle, et employer la première là où la seconde est requise ouvrirait le canal temporel dans la démonstration même qui prétend le fermer. Mêmes objets, invariants contraires.

## REFUS-05 — les tailles inductives et coinductives

**La tentation.** Un seul théorème de progression gouverne les deux polarités ; il semble donc naturel qu'un seul domaine de tailles les porte.

**Le motif du refus, et c'est une erreur que j'ai commise.** Le 9 septembre, j'ai unifié le domaine parce que le schéma était unifié — et la conséquence a été qu'aucun processus non terminé ne restait typable. L'unification du *schéma* n'entraîne pas celle de l'*objet*. La bonne factorisation est : un schéma, deux instances de sortes.

**La leçon, qui vaut au-delà de ce cas.** Une factorisation réussie à un niveau invite à en tenter une au niveau d'en dessous. C'est précisément là qu'il faut s'arrêter et vérifier ce que l'objet doit satisfaire.

## REFUS-06 — les trois préservations

**La tentation.** Trois énoncés portent le même nom, et deux d'entre eux ont des hypothèses voisines.

**Le motif du refus.** Leurs emboîtements sont de sens contraire et aucun ne contient l'autre. L'un est plus fin — il porte les grades, les effets et la décroissance du potentiel — et plus étroit ; l'autre est plus large — il couvre l'abaissement — et plus pauvre.

**À conserver explicitement.** Le document a résisté à cette fusion avant qu'on la lui propose, et il a eu raison. C'est le seul des sept refus qui était déjà acquis.

## REFUS-07 — les effets algébriques et les effets à portée

**La tentation.** Ils occupent la même place dans le jugement — la composante d'effet — et une machinerie unique existe dans la littérature qui les traiterait ensemble.

**Le motif du refus.** Une opération à portée a pour effet une *fonction* de l'effet de son argument, là où une opération ordinaire a un effet constant. La mise en parallèle l'a rendu visible : deux effets algébriques s'y composent sans rien demander, deux opérations à portée ne le peuvent qu'une fois leurs transformateurs appliqués.

**Ce qui est retenu à la place.** Ni l'unification ni la séparation, mais le rangement : les deux fragments sont nommés, ils partagent leur place dans le jugement, ils diffèrent par la structure, et la clôture est déclarée *faible* sur le second. Une clôture qu'on déclarerait forte là où elle est faible serait une clôture qu'on ne pourrait plus invoquer ailleurs.

## Ce que les sept ont en commun

Six sur sept rapprochaient des objets de *même forme*. C'est le signal à retenir : la ressemblance de notation est ce qui rend une fusion tentante, et elle n'est jamais ce qui la justifie.

Ce qui justifie une factorisation est que les objets aient les mêmes *obligations*. Ce qui l'interdit est qu'ils aient les mêmes formes et des obligations différentes — et c'est le cas le plus fréquent, parce qu'une notation bien choisie fait justement ressembler ce qui joue un rôle analogue.

## Deux cadres d'ensemble, écartés par arbitrage (`FACT-21`, `FACT-22`)

Ces deux-là ne sont pas des fusions d'objets mais des **cadres de rédaction** proposés par la relecture : une architecture à cinq couches de preuve (`FACT-21`) et une formulation fibrée bimodale du jugement (`FACT-22`). `ARB-PR-05` (journal de la séance 7, 1er octobre 2026) a retenu le cadre du manuscrit, ratifié : le jugement germinal à trois composantes, la sédimentation des trois couches, l'effacement en dernière phase. Choisir celui-là ne coûte rien ; en choisir un autre coûte une réécriture pour un gain nul, les quatre cadres se recouvrant largement. Les deux propositions sont donc **documentées comme écartées** plutôt qu'écrites.

Deux éléments postérieurs confortent le refus, sans en être le motif. La loi distributive qui relie coeffets et effets n'est qu'*affaiblie* (`thm:loi_distributive_conditions`, séance 24) : un cadre fibré strict qui l'absorberait serait faux en l'état. Et les objectifs chiffrés que `FACT-22` annonçait (quatorze théorèmes en moins, trente-neuf règles de typage ramenées à vingt-quatre) n'ont pas été vérifiés ; le manuscrit en compte aujourd'hui cinquante. Ce qui est pris de ces cadres tient en un mot : le vocabulaire de la théorie de modes (le mode est le paramètre), et la décomposition module × ordre de `TRANS-02`, écrite au §1.4.
