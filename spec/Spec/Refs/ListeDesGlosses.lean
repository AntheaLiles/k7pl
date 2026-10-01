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

#doc (Manual) "Liste des glosses" =>
%%%
file := "refs-liste-des-glosses"
tag := "refs-liste-des-glosses"
%%%

: abaissement

  Traduction d'un programme vers une représentation de plus bas niveau, qui doit préserver ce que
  les vérifications antérieures ont établi.

: acteur virtuel

  Acteur qui n'est qu'une adresse logique tant qu'il est inactif, son état étant persisté et sa
  mémoire rendue jusqu'à sa réactivation.

: adressage par contenu

  Identification d'un artefact par l'empreinte de son contenu plutôt que par un numéro de version,
  deux artefacts équivalents portant alors le même nom.

: affaiblissement

  Règle structurelle qui autorise à abandonner une liaison sans l'employer.

: algèbre initiale

  Plus petit point fixe d'un foncteur, dont l'unique morphisme vers toute autre algèbre fonde la
  terminaison des plis.

: anamorphisme

  Dépli défini par l'unique morphisme entrant dans une coalgèbre terminale, dont la productivité
  suit de la terminalité.

: anaphore

  Liaison qu'une macro introduit délibérément à destination du corps de son site d'appel, déclarée
  dans son type plutôt que silencieuse.

: appel par poussée de valeur

  Régime d'évaluation qui sépare les valeurs des calculs, et où toute fonction reçoit une valeur et
  rend un calcul.

: arène

  Bloc de mémoire contigu où toute référence est un décalage relatif et jamais un pointeur absolu,
  ce qui rend son déplacement indépendant de son contenu.

: axiomatique germinale

  Ensemble minimal d'énoncés dont dérivent la forme du jugement et l'algèbre des grades, et qui fixe
  ce qu'une extension du langage a le droit d'ajouter.

: boîte aux lettres

  Objet de communication recevant des messages de plusieurs émetteurs sans les ordonner, et dont le
  type dit quelle configuration de messages il admet.

: budget

  Composante du grade qui majore le coût d'un calcul, et dont la valeur est provisionnée avant
  l'exécution plutôt que mesurée après elle.

: canal

  Ressource de couche 1 par laquelle deux calculs échangent, dont le type décrit le protocole et
  dont la détention est linéaire.

: capabilité

  Valeur de couche 1 qui autorise un accès et dont la détention est la seule voie vers cet accès, la
  perdre revenant à perdre le droit.

: catamorphisme

  Pli défini par l'unique morphisme sortant d'une algèbre initiale, dont la terminaison suit de
  l'initialité plutôt que d'une vérification.

: circuit breaker de session

  Rejet d'un message non conforme au protocole attendu avant tout réveil de la fibrille
  destinataire, de sorte que le rejet ne lui coûte rien.

: coalgèbre terminale

  Plus grand point fixe d'un foncteur, dont l'unique morphisme depuis toute autre coalgèbre fonde la
  productivité des flux.

: code d'erreur

  Identifiant d'un motif de rejet, formé du préfixe `ERR`, d'un segment de trois lettres désignant
  l'invariant protégé et d'un numéro d'ordre.

: cofibrille

  Fibrille de couche 2, nommée ainsi en prose lorsque l'on veut souligner qu'elle est bornée par la
  productivité et non par la décroissance d'un indice.

: comonade graduée

  Famille d'endofoncteurs indexée par un semi-anneau, munie d'une counité et d'une coassociativité
  indexée par le produit, qui interprète la ressource portée par un contexte.

: composante du jugement

  Chacune des trois parties que porte le jugement germinal — le contexte gradué, le type, l'effet —
  et dont une couche donnée peut n'employer qu'une partie.

: condition de clôture

  Contrainte qui borne les extensions admissibles du langage, en exigeant qu'une notion nouvelle
  s'obtienne des constructions déjà posées plutôt que d'un mécanisme ajouté.

: confusion ABA

  Défaut par lequel une référence recyclée est prise pour la référence d'origine, l'état ayant fait
  aller et retour entre deux valeurs.

: contraction

  Règle structurelle qui autorise à employer une même liaison plus d'une fois.

: contrainte de valeur

  Restriction portant sur ce que le contenu d'une valeur peut être — une taille, un intervalle, un
  état, un protocole, une dimension physique — indépendamment de la modalité qui gouverne son usage.

: copatron

  Forme de définition par les observations que l'on peut faire d'un objet, plutôt que par les
  constructeurs dont il est bâti.

: déclassification

  Autorisation nommée de faire descendre une donnée d'un niveau de confidentialité vers un niveau
  inférieur, accordée point par point plutôt que par une permission générale.

: défonctionnalisation

  Remplacement des fonctions de première classe par des étiquettes et un branchement, qui rend le
  programme exécutable sans indirection.

: déforestation

  Élimination des structures intermédiaires qu'une composition de plis construirait, de sorte que le
  résultat se calcule en un seul parcours.

: délimiteur

  Paire de signes qui marque, au site d'un appel, le fragment dans lequel l'expression appelée se
  vérifie.

: destructeur

  Morphisme invoqué au point de consommation d'une ressource linéaire, dont l'exécution est fixée
  par la structure du type et non par une politique d'exécution.

: dualité

  Relation entre les deux extrémités d'un même type de session, l'émission de l'une répondant à la
  réception de l'autre.

: échange

  Règle structurelle qui autorise à permuter deux liaisons du contexte sans changer la dérivation.

: effacement

  Disparition, dans le binaire produit, de tout ce qui n'a servi qu'à la vérification, de sorte que
  la garantie ne coûte rien à l'exécution.

: effet algébrique

  Effet présenté par les opérations qui l'engendrent et par les équations qu'elles satisfont,
  indépendamment de toute interprétation particulière.

: engagement

  Promesse que le document fait au lecteur sur un point qu'il n'a pas encore établi, et qu'un
  théorème ou une réserve explicite devra plus tard tenir ou lever.

: espace de noms

  Sous-catégorie large du graphe des modules, close par composition, qui isole une partie du graphe
  sans en projeter le reste.

: estampille

  Marque attachée à une unité de compilation qui atteste de quelle définition elle provient, et par
  laquelle deux unités se reconnaissent compatibles.

: fibrille

  Coroutine sans pile propre, compilée en machine à états, qui porte l'exécution d'un automate ou
  d'un pli et dont la borne vient du type plutôt que de l'ordonnanceur.

: finaliseur

  Procédure de libération dont le moment d'exécution dépend d'un ramasse-miettes, et dont le langage
  se passe au profit du destructeur.

: Flat-Wiring

  Principe de conception exigeant que le graphe des dépendances d'un programme soit lisible dans son
  texte, sans qu'aucune liaison ne se cache derrière une indirection.

: fragment

  Sous-ensemble d'un système logique obtenu en interdisant certaines règles structurelles, et qui
  reste clos pour les règles qu'il conserve.

: frontière de confiance

  Point où du code ou une donnée d'origine non vérifiée entre dans le programme, et au-delà duquel
  les garanties du système de types ne valent plus.

: gabarit

  Définition statique d'un acteur, dont chaque instance dynamique hérite le type d'état et les
  garanties établies à la compilation.

: générativité

  Axiome interdisant à un métaprogramme d'inspecter la structure des termes du niveau objet, et dont
  se tire la clôture de l'univers engendré.

: gestionnaire

  Interprétation d'une famille d'opérations d'effet vers un type de résultat, qui donne un sens à
  chacune et referme le calcul qu'elles ouvraient.

: grade

  Élément de l'algèbre que pose l'axiomatique germinale, porté par une liaison, et qui dit combien
  de fois et sous quelles conditions cette liaison sera employée.

: histomorphisme

  Pli qui accède, à chaque pas, à l'historique des résultats déjà calculés plutôt qu'au seul
  résultat immédiat.

: hygiène

  Propriété d'un système de macros dont l'expansion ne capture jamais une liaison du site d'appel,
  ni n'expose les siennes.

: hylomorphisme

  Composition d'un dépli et d'un pli, qui consomme un flux et le replie en un état fini sans
  construire la structure intermédiaire.

: indice de taille

  Grade porté par un type, pris dans l'une des deux sortes que la polarité détermine, et dont le
  comportement d'un jugement au suivant établit la terminaison ou la productivité sans inspecter le
  terme.

: instantané

  État d'un acteur figé et persisté à un instant donné, à partir duquel le rejeu du journal reprend.

: journal

  Suite ordonnée et persistée des messages reçus, qui suffit à reconstituer l'état d'un acteur par
  rejeu.

: jugement germinal

  Forme unique de dérivation dont les trois couches du langage sont des spécialisations, portant
  conjointement le contexte de ressources, le type et les effets.

: localisation

  Élément du demi-treillis où réside une valeur, porté par une modalité graduée et donc fixé au
  typage plutôt que choisi à l'exécution.

: loi distributive graduée

  Donnée qui gouverne l'interaction de l'axe des ressources et de l'axe des effets, et qui ne se
  déduit pas de la juxtaposition de leurs gradations.

: macro

  Fonction pure qui reçoit un arbre de syntaxe et en rend un autre, exécutée avant toute
  vérification et sans accès au monde extérieur.

: modalité d'usage

  Sous-ensemble distingué de l'algèbre des grades, porté par un type, qui dit dans quel fragment ce
  type vit.

: mode

  Donnée d'une algèbre de grades, d'un idéal de contraction et d'un booléen d'affaiblissement, qui
  fixe les règles structurelles admissibles sur les liaisons qu'il gouverne.

: modèle mémoire

  Ensemble des ordres d'accès qu'une machine garantit entre deux fils d'exécution, et sur lequel
  repose toute affirmation de concurrence.

: monomorphisation

  Remplacement de chaque appel générique par une copie spécialisée aux types concrets de son site,
  avant toute optimisation ultérieure.

: morphisme de modes

  Application entre deux modes qui envoie tout grade contractable de la source sur un grade
  contractable du but et propage l'affaiblissement vers l'avant.

: motif de boîte

  Expression décrivant les configurations de messages qu'une boîte peut contenir, composée par une
  opération commutative, un choix et une répétition.

: motif de jonction

  Règle qui ne se déclenche qu'à l'arrivée d'une combinaison de messages, et dont la couverture de
  toutes les combinaisons se vérifie statiquement.

: narrowing

  Procédure de résolution qui restreint pas à pas l'ensemble des valeurs qu'une variable peut
  prendre, jusqu'à décider si une contrainte est satisfiable.

: non-interférence

  Propriété d'un programme dont le comportement observable à un niveau de confidentialité donné ne
  dépend d'aucune donnée d'un niveau supérieur.

: notation tacite

  Écriture d'une composition de fonctions sans nommer leurs arguments, héritée de la tradition des
  langages à tableaux.

: observation

  Consommation d'une unité de taille sur un objet coinductif, qui en expose un cran de structure.

: opération à portée

  Opération d'effet qui prend un calcul en argument, et dont l'effet est une fonction de l'effet de
  cet argument plutôt qu'une constante.

: oracle

  Interpréteur de référence tenu pour correct, contre lequel chaque transformation du compilateur
  optimisant se compare.

: orchestrateur

  Coalgèbre dont l'état est composé des états de tous les acteurs qu'elle supervise, et qui décide
  de leur activation et de leur redémarrage.

: phase

  Étape du processus de compilation qui suppose acquis tout ce qu'établissent les précédentes, et
  dont l'échec rejette le programme.

: postulat

  Énoncé fondateur que le langage tient pour acquis sans le démontrer, et dont tout le reste dépend
  ; le document en compte quatre, notés P1 à P4.

: profondeur

  Composante du facteur temporel mesurant la longueur du plus long chemin de dépendances, et que la
  mise en parallèle laisse inchangée au lieu de l'additionner.

: quantale

  Monoïde ordonné complet, dont le produit dénote ici le séquencement de deux effets et dont l'unité
  dénote leur absence.

: relation de précision

  Ordre partiel entre artefacts syntaxiques, où un terme est inférieur à un autre lorsqu'il en est
  une version moins précise.

: reportabilité

  Propriété d'une ressource disponible à tout instant, qu'une attente de durée non bornée ne peut
  pas invalider, et que la modalité de permanence dénote.

: réserve

  Restriction que le document énonce sur la portée d'un de ses résultats, pour empêcher qu'on lui
  prête plus qu'il n'établit.

: résiduel

  Motif restant après consommation d'un message, et par lequel le type d'une boîte se transforme à
  chaque réception.

: R-expression

  Expression décrivant un motif à reconnaître, compilée en automate, et qui unifie sous une seule
  interface le filtrage structurel et les grammaires.

: sédimentation

  Emboîtement des trois couches par restriction successive des règles structurelles, chacune étant
  le fragment de la précédente qui renonce à une liberté.

: semi-anneau

  Ensemble muni d'une addition et d'une multiplication associatives, la seconde distribuant sur la
  première, sans exiger d'opposé pour l'addition.

: sérialisabilité

  Propriété d'une valeur dont la représentation survit à un transport entre localisations, et sans
  laquelle un déplacement n'est pas dérivable.

: S-expression

  Expression parenthésée dont le premier élément est l'opérateur et les suivants ses arguments, et
  qui sert de syntaxe d'appel universelle au langage.

: sorte de taille

  Chacun des deux domaines où vit un indice de taille — l'un sans plus grand élément, pour la
  polarité inductive, l'autre avec, pour la coinductive — qu'aucun type ne porte ensemble.

: système de raffinement

  Foncteur qui projette des dérivations sur les termes qu'elles typent, et dont les fibres portent
  les jugements d'un même terme.

: test différentiel

  Comparaison systématique du résultat d'un programme optimisé et de celui du même programme
  interprété, employée pour détecter une optimisation fautive.

: train

  Suite de fonctions composées par juxtaposition, dont l'arité de l'assemblage se lit sur le nombre
  de termes.

: tranche minimale

  Plus petit sous-ensemble d'une dérivation qui suffit à expliquer pourquoi un jugement a été
  obtenu, extrait pour rendre un diagnostic lisible.

: travail

  Composante du facteur temporel comptant le nombre total de pas d'un calcul, indépendamment de leur
  répartition.

: trou

  Terme le moins précis possible pour un type donné, écrit à la place d'une expression que le
  développeur laisse au compilateur le soin de proposer.

: type de raffinement

  Type formé d'un support et d'un prédicat sur ses habitants, dont la vérification engage une
  obligation de preuve résolue hors du système de types.

: type de session

  Type qui décrit la suite ordonnée des émissions et des réceptions qu'un canal admet, et dont la
  violation se rejette à la compilation.

: typestate

  Discipline par laquelle le type d'une valeur change au fil des opérations qu'elle subit, de sorte
  qu'une opération hors d'état devient non typable.

: X-expression

  Expression décrivant une donnée arborescente en couche 2, sans pointeur vers la structure qu'elle
  finira par produire.

: zone

  Mode muni d'un ordre qui lui est propre, de sorte que deux liaisons qu'il gouverne ne s'échangent
  que selon cet ordre, quand deux liaisons gouvernées par des modes distincts s'échangent librement.
