<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R7 — Pannes, ressources linéaires et persistance (P3)

**Date d’évaluation :** 2026-10-23  
**Instantané audité :** `AntheaLiles/k7pl`, branche `main`, commit `fca400806f0a1fdb02d8c1d27abf81870a227790`  
**Statut :** rapport de recherche non normatif. Les propriétés de reprise et de durabilité restent à spécifier et à établir pour une cible donnée.

## 1. Résultat exécutif

C4 décrit un cycle de vie d’acteur virtuel fondé sur un instantané journalisé, la libération de mémoire lorsque l’acteur est inactif, puis la réactivation par chargement de l’instantané et rejeu des événements ultérieurs. Cette architecture est un point de départ, mais elle ne suffit pas à établir la reprise après toute panne.

L’énoncé `thm:determinisme_rejeu` est explicitement marqué `under-review` avec `proofsketch`. Son texte requiert un journal complet et laisse ouvertes la définition du schéma de journal, la relation d’équivalence d’observation et la preuve que les résultats des opérations non déterministes ou externes sont substitués correctement lors du rejeu. `thm:rejeu_binaire` ajoute des hypothèses de conformité de représentation et d’environnement. Ces énoncés ne constituent donc pas, à eux seuls, une preuve de durabilité du stockage, de reprise après une coupure d’alimentation, ni d’exécution unique des effets externes.

L’audit du code Lean confirme la limite de périmètre. `src/K7pl/Semantics.lean` précise que son système de transitions porte sur un compteur et n’est pas la sémantique opérationnelle de K7PL. `src/K7pl/MemoryCapability.lean` formalise un invariant abstrait de comptage de capacités, tout en déclarant ne pas représenter les règles opérationnelles `Arena`, `WriteCap`, `alloc_range` ou `Par`. Les modules étudiés ne fournissent pas de protocole exécutable de journalisation, d’écriture durable et de récupération.

La conclusion est ainsi limitée : **la spécification décrit un modèle de rejeu et de cycle de vie ; la correspondance avec un protocole de stockage crash-consistent et avec la récupération des ressources linéaires demeure ouverte.**

Trois propriétés doivent être séparées tout au long du dossier :

1. **Rejeu déterministe** : reconstituer un état logique à partir d’une histoire complète sous des hypothèses explicites.
2. **Durabilité et cohérence après panne** : déterminer ce qui peut être observé après redémarrage lorsque des écritures ont été interrompues, réordonnées ou non rendues persistantes.
3. **Sûreté des effets externes** : éviter la perte, la duplication ou la répétition contradictoire d’une opération lorsque le système s’arrête entre l’effet et son enregistrement.

Aucune de ces propriétés n’entraîne automatiquement les deux autres.

## 2. Périmètre et méthode

Le rapport confronte les passages normatifs, les prototypes Lean disponibles et les travaux de référence sur la cohérence après panne, les journaux durables et le rejeu. Il sépare les engagements écrits, les modèles formels locaux, les preuves annoncées, les hypothèses de plateforme et les composants encore absents.

Sources du dépôt :

- [C4 — Échelle du système](../../spec/Spec/C4/EchelleDuSysteme.lean)
- [C4 — Sémantique opérationnelle](../../spec/Spec/C4/SemantiqueOperationnelle.lean)
- [C3 — Contraintes de valeur](../../spec/Spec/C3/LesContraintesDeValeur.lean)
- [C3 — Règles de typage](../../spec/Spec/C3/ReglesDeTypage.lean)
- [C4 — Dossier de concurrence R4](R4-concurrence-protocoles-vivacite-annulation.md)
- [C4 — Dossier de sûreté mémoire R5](R5-memoire-emprunt-aliasing-logique-separation.md)
- [R0 — Modèle de menace et matrice d’assurance](R0-threat-model-assurance-matrix.md)
- [Dossier d’assurance scientifique](../../wiki/assurance.md)

L’examen du répertoire `src/K7pl` au snapshot audité trouve des modèles Lean et des interfaces abstraites, non un runtime de persistance prêt à être vérifié. Le prototype de sémantique est lui-même circonscrit à un compteur. Ce rapport n’a pas relancé `lake build` ni exécuté une implantation du stockage ; il ne prétend donc ni certifier la compilation du snapshot ni attester de comportements expérimentaux non observés.

## 3. Constat sur K7PL

### 3.1 Cycle de vie décrit en C4

C4 présente un acteur virtuel inactif comme un état dont l’instantané est écrit dans un journal tandis que la mémoire est restituée. Lors d’une activation, l’orchestrateur charge l’instantané et rejoue les messages enregistrés depuis ce point. Le texte présente la reprise comme une continuation de la coalgèbre de l’acteur à l’endroit où elle s’était arrêtée.

Il reste à définir ce que signifient concrètement « journalisé », « persisté », « atomique » et « au point exact » dans les cas de panne. Par exemple, un snapshot créé en mémoire ou écrit dans le cache du système d’exploitation n’est pas nécessairement durable après perte d’alimentation. De même, le fait de consigner un message ne prouve pas à lui seul que l’effet associé a été appliqué, ni que son résultat a été enregistré durablement.

Le cycle de vie doit distinguer au moins les événements suivants : état de l’acteur gelé, données écrites, données rendues persistantes selon le contrat de stockage, référence au nouveau snapshot publiée, mémoire libérée, reprise autorisée et historique appliqué. Si ces événements ne sont pas ordonnés par un protocole précis, une panne peut laisser le journal et le snapshot à des étapes différentes.

### 3.2 Statut du rejeu logique

`thm:determinisme_rejeu` énonce une égalité observationnelle entre l’état final original et celui reconstruit par pli sur un historique `J(H)`. La preuve esquissée repose sur des gestionnaires purs et sur l’enregistrement de tous les résultats non déterministes utilisés par ces gestionnaires.

L’obligation ouverte du texte est explicite : définir le schéma du journal, l’équivalence d’observation et les composantes de l’état comparées, puis montrer que le rejeu substitue exactement les résultats consignés. Cette prémisse est substantielle. Si une lecture d’horloge, une réponse réseau, un résultat de périphérique, une arrivée de message ou un choix d’ordonnancement affecte la branche exécutée mais ne figure pas dans l’histoire, le rejeu peut diverger.

Même avec un historique complet et un rejeu logique correct, il faut préciser quels effets sont rejoués et lesquels sont seulement relus depuis le journal. Un rejeu qui refait un appel externe peut modifier le monde extérieur une seconde fois. Pour reconstruire l’état logique, il doit normalement réutiliser le résultat durable de cet appel plutôt que le relancer ; une nouvelle tentative de l’appel relève d’un protocole de récupération distinct.

### 3.3 Représentation binaire

`thm:rejeu_binaire` conditionne l’identité de représentation à un profil `Π`, à un environnement reproductible et à une hypothèse d’invariance de représentation. Le texte classe ces garanties comme propriétés de conformité du compilateur à un profil, non comme simples conséquences du système de types.

R7 ne transforme donc pas le rejeu logique en garantie d’identité binaire. Il faut que le format d’instantané, les versions de schéma, la disposition des valeurs, les paramètres de compilation et l’architecture correspondent au contrat de compatibilité choisi. Une mise à jour de logiciel qui change le format peut requérir une migration de données validée ; la désérialisation réussie n’établit pas, en elle-même, l’équivalence sémantique de l’état migré.

### 3.4 Défaillance, abandon et ressources affines

C3 indique que la défaillance n’est pas éliminée par le typage : le régime affine autorise l’abandon, `Try` délimite la récupération et la supervision choisit une politique. Ce cadrage reconnaît qu’une machine peut s’arrêter. Il ne fixe pas encore, pour chaque catégorie de ressource, ce qui se passe lors d’un crash brutal, d’un timeout, d’une annulation coopérative ou d’un redémarrage.

L’abandon logique d’une liaison ne doit pas être assimilé à la libération réelle d’un verrou, d’un bail, d’une capacité de périphérique ou d’un message en attente. Une annulation peut permettre à du code de nettoyage de s’exécuter ; un arrêt brutal ne le permet pas. Un timeout indique qu’une réponse attendue n’est pas arrivée à temps ; il ne démontre pas que l’opération sous-jacente n’a pas eu lieu.

R5 identifie déjà l’écart entre l’invariant abstrait de capacités et les règles opérationnelles effectives. Après redémarrage, la même difficulté revient sous une autre forme : restaurer une capacité linéaire depuis un instantané peut recréer un droit encore détenu par un ancien acteur, ou au contraire abandonner une ressource sans mécanisme pour la récupérer. L’invariant doit couvrir le cycle durable complet, pas seulement le comptage en mémoire.

### 3.5 Le journal opérationnel n’est pas encore un protocole de stockage

Dans C4, une configuration opérationnelle est présentée comme `⟨c | μ | τ⟩`, avec le calcul, l’état d’arène et une trace d’effets. Cette trace est un objet sémantique. Sa présence ne fixe pas son format sur disque, la granularité atomique d’un enregistrement, l’ordre des écritures, le moment du `flush`, la reconnaissance d’une écriture tronquée, la récupération d’une fin de journal ni la politique de rotation et de purge.

Un historique d’événements peut suffire à un rejeu si sa complétude et son ordre sont garantis ; il peut être insuffisant pour revenir d’un crash si les données elles-mêmes n’ont pas atteint le stockage durable. Inversement, un journal durable peut permettre un retour cohérent à l’état précédent sans fournir le rejeu logique d’un calcul externe déterministe.

### 3.6 État des preuves disponibles

| Proposition | Preuve disponible dans le snapshot | Limite pour R7 |
|---|---|---|
| Rejeu logique, `thm:determinisme_rejeu` | Énoncé et esquisse `proofsketch`, état `under-review` | Schéma et complétude du journal, observation et substitution des résultats restent à établir |
| Rejeu binaire, `thm:rejeu_binaire` | Corollaire et esquisse `proofsketch`, état `under-review` | Dépend du profil de représentation et des hypothèses d’environnement |
| Préservation de ressources mémoire | Modèle de comptage abstrait dans `MemoryCapability.lean` | Pas le cycle de vie effectif des ressources lors de panne et récupération |
| Budget par profil | Arithmétique générique dans `GradeBudget.lean` et interface dans `BudgetTransport.lean` | Ne spécifie pas si une tentative interrompue reste débitée ni comment éviter un remboursement artificiel après reprise |
| Récupération du système après crash | Description architecturale en C4 | Aucun modèle de stockage avec transitions de crash et preuve de raffinement n’est attaché au runtime dans le périmètre examiné |

## 4. Définir le modèle de panne avant toute garantie

Une garantie de récupération n’est précise qu’après définition de l’adversité couverte. Au moins cinq niveaux doivent être distingués :

| Niveau | Événement | Hypothèse distincte à écrire |
|---|---|---|
| F0 | Annulation coopérative d’une tâche | Le runtime continue à exécuter le protocole d’annulation jusqu’à sa fin ou son délai d’arrêt |
| F1 | Crash d’un worker ou d’un acteur | La mémoire volatile de l’instance disparaît ; l’instance peut redémarrer ailleurs |
| F2 | Redémarrage du noyau ou de la machine | Les données durablement écrites survivent selon le contrat de stockage ; les caches volatils sont perdus |
| F3 | Coupure d’alimentation pendant les écritures | Certaines écritures peuvent être incomplètes ou visibles dans un ordre différent si le modèle de stockage le permet |
| F4 | Perte, corruption ou restauration d’une ancienne copie | Le système détecte ou accepte explicitement ces cas ; les checksums seuls ne garantissent pas l’authenticité |
| F5 | Partition réseau et reprise d’une ancienne instance | Deux instances peuvent agir concurremment ; la politique d’autorité et de clôture de l’ancienne instance doit être définie |

Les propriétés prouvées sous F1 ne valent pas automatiquement sous F3 ou F4. Un modèle qui suppose qu’un appel de persistance est toujours fiable ne couvre pas les pannes où le matériel ou le contrôleur ne respecte pas cette hypothèse. Ces conditions doivent apparaître dans la portée de la garantie, pas seulement dans la documentation de déploiement.

## 5. Protocole de récupération à spécifier

Le protocole suivant est une proposition d’architecture pour les futurs modèles et expériences, pas une règle normative ajoutée à K7PL. Sa finalité est de rendre visibles les points de commit et les états incertains.

### 5.1 Enregistrement et checkpoint

Chaque événement durable devrait porter au minimum un identifiant stable, une séquence monotone, une version de schéma, le type d’événement, la charge utile ou une référence vérifiée à celle-ci, ainsi qu’un mécanisme de détection d’enregistrement incomplet. La chaîne de journaux doit préciser comment l’ordre est établi et comment les enregistrements invalides en fin de fichier sont traités.

Un checkpoint doit annoncer le préfixe d’événements qu’il couvre. La récupération choisit le dernier checkpoint valide et durable, puis rejoue le préfixe validé strictement postérieur à son numéro de séquence. La rotation ne doit pas supprimer les journaux nécessaires avant que le checkpoint de remplacement et sa référence de publication soient durables selon les garanties de la cible.

Un protocole typique doit distinguer :
1. construction du contenu du nouveau checkpoint ;
2. synchronisation du contenu selon le contrat de stockage ;
3. publication de la référence à ce checkpoint ;
4. synchronisation des métadonnées nécessaires à la récupération ;
5. conservation de l’ancien checkpoint jusqu’à validation du nouveau ;
6. purge des anciens segments seulement après preuve qu’ils ne sont plus requis.

L’ordre précis des opérations, la signification de la synchronisation et la sémantique du renommage dépendent du système de fichiers, du système d’exploitation, du contrôleur et du périphérique ciblés. Le rapport ne traite aucun nom d’appel système comme une garantie portable sans cette hypothèse.

### 5.2 Opérations locales et effets externes

Un journal local ne peut pas, seul, rendre atomique une opération avec un service externe indépendant. Considérons une commande qui débite un compte distant. Si le débit réussit mais que l’acteur s’arrête avant d’inscrire le résultat dans son journal, la reprise ignore si le débit a eu lieu. Réexécuter peut débiter deux fois ; ne pas réexécuter peut perdre une opération qui n’a jamais été effectuée.

Les options à examiner sont : clé d’idempotence stable acceptée et conservée par le service distant ; transaction distribuée si les participants la prennent réellement en charge ; protocole de boîte d’envoi persistante (*outbox*) associé à une déduplication réceptrice ; ou état explicite « résultat inconnu » réconcilié par une requête fiable au service. Une clé d’idempotence est utile seulement si le service destinataire en définit la portée, la durée de conservation et le comportement en cas de charge utile différente.

Les sémantiques « au plus une tentative », « au moins une tentative » et « un seul effet logique » doivent être séparées. Un transport peut livrer un message plusieurs fois tandis que la couche durable ne consigne qu’un résultat terminal par identifiant. Cela ne prouve pas que le corps d’une opération externe n’a été exécuté qu’une seule fois.

### 5.3 Propriété, capacités et fencing

Une ressource linéaire durable doit posséder un état de cycle de vie explicite : créée, réservée, transférée, engagée, libérée ou placée en récupération. Les transitions autorisées doivent préciser leur point de linéarisation et leur effet au redémarrage.

Un identifiant de ressource et une génération croissante peuvent prévenir la réutilisation d’une ancienne référence, à condition que le destinataire vérifie cette génération. De même, une époque de propriétaire (*fencing token*) peut interdire à une instance ancienne de continuer des opérations après perte de bail, si chaque opération protégée est effectivement validée contre cette époque. Un simple heartbeat ou l’expiration locale d’un timeout ne suffit pas à prouver qu’un ancien propriétaire a cessé d’agir.

L’invariant central à viser est la conservation de l’autorité : chaque ressource doit avoir un état durable unique — détenue par une instance autorisée, transférée par un commit confirmé, libérée, ou marquée pour récupération — sans état où deux instances peuvent toutes deux agir comme propriétaire. Il faut aussi un chemin de récupération des ressources de l’instance disparue afin qu’un verrou ou un canal ne reste pas bloqué indéfiniment. Cette propriété n’est pas encore démontrée par l’invariant de comptage abstrait de R5.

### 5.4 Budgets lors des tentatives et des reprises

La politique de débit des budgets est déterminante. Si un budget représente le travail total effectivement consommé, le coût d’une tentative échouée ne disparaît pas à la restauration d’un snapshot antérieur. Si le budget représente le coût logique d’une action validée, une tentative répétée peut ne pas être débitée une seconde fois au compte logique, mais la consommation réelle de CPU, d’E/S et de temps doit être comptabilisée ailleurs pour R6.

Le système doit donc choisir et distinguer au moins :
- coût d’une tentative physique ;
- coût d’un événement logique validé ;
- coût de la procédure de récupération ;
- coût de réconciliation et des opérations répétées ;
- coût durable attribué au processus ou à son propriétaire.

Une restauration qui restitue le budget précédant une action déjà exécutée pourrait permettre de répéter indéfiniment un effet payant tout en conservant le même budget déclaré. Inversement, débiter le même coût logique à chaque rejeu peut épuiser artificiellement le contrat. La sémantique de budget ne doit pas être décidée par les détails de l’implémentation du snapshot.

### 5.5 Annulation et timeout

La transition d’annulation doit identifier quels effets peuvent encore se produire après la demande, quelles ressources sont libérées, quelles messages attendent encore et quand le runtime peut déclarer l’opération terminée. Si le processus est déjà tombé, les nettoyages du programme ne s’exécutent pas : la récupération doit partir des états durables et réconcilier les opérations non résolues.

Le timeout est une observation de délai, pas une preuve d’absence d’effet. Quand le résultat de l’appel est inconnu, il faut un état explicite « indéterminé » plutôt qu’un retour implicite à l’état antérieur. La politique peut ensuite interroger, dédupliquer, compenser ou escalader selon le contrat de l’opération. Les compensations ne sont pas un rollback universel : une action irréversible, une notification envoyée ou une commande matérielle peut ne pas avoir d’inverse exact.

### 5.6 Partition, CRDT et ressource exclusive

C4 évoque la convergence de répliques par fusion CRDT après une partition. Cette convergence peut être adaptée à l’état répliqué dont la fusion possède les propriétés algébriques spécifiées. Elle ne résout pas automatiquement la propriété exclusive d’une capacité, l’allocation d’un identifiant unique ou l’envoi unique d’un ordre à un périphérique.

Le modèle doit séparer l’état fusionnable des droits exclusifs, des séquences de commit et des effets externes. Les droits d’écriture ou leases nécessitent une règle d’autorité explicite — par exemple une génération clôturant les anciens propriétaires — et une hypothèse de coordination adaptée. Fusionner deux snapshots ne suffit pas si chacun a émis un effet non réversible avant la convergence.

## 6. Modèle d’état et invariants à formaliser

Une première formalisation devrait garder des composants distincts plutôt que de traiter le journal comme l’état entier :

- (V) : état volatile de l’acteur actif ;
- (C) : dernier checkpoint validé, avec sa génération et le numéro du préfixe durable couvert ;
- (J) : journal durable, éventuellement avec une fin partielle ;
- (R) : registre d’allocations, d’autorités, de générations et de transferts de ressources ;
- (E) : effets externes et leurs identifiants idempotents/résultats connus ;
- (B) : budgets et comptabilité des tentatives, événements logiques et récupération ;
- (I) : incarnation ou époque courante de l’acteur, utilisée pour reconnaître les anciennes instances.

L’état de récupération doit inclure une phase explicite : validation du stockage, choix du checkpoint, rejeu du journal, réconciliation des opérations incertaines, reconstruction des droits, puis passage autorisé à l’état actif. Les opérations externes ne doivent pas être émises avant que le protocole sache comment identifier et résoudre une répétition possible.

Invariants candidats :

| ID | Invariant | Énoncé à établir |
|---|---|---|
| R7-I1 | Préfixe durable | Tout événement admis au rejeu appartient à un préfixe complet et validé du journal |
| R7-I2 | Cohérence checkpoint/journal | Le checkpoint correspond à un préfixe durable ; le rejeu commence strictement après ce préfixe |
| R7-I3 | Conservation des ressources | Chaque ressource a un état logique unique, y compris pendant transfert, crash et récupération |
| R7-I4 | Clôture d’ancienne instance | Une incarnation périmée ne peut plus produire un effet accepté après qu’une nouvelle époque est engagée |
| R7-I5 | Idempotence de réception | Rejouer ou livrer à nouveau un identifiant déjà validé n’applique pas une seconde fois l’effet logique |
| R7-I6 | État incertain visible | Un crash entre effet externe et enregistrement ne se traduit ni par un succès fictif, ni par un échec certain sans preuve |
| R7-I7 | Conservation budgétaire | La reprise ne réinitialise pas un budget physique déjà consommé ; les coûts logiques et physiques restent distincts |
| R7-I8 | Refinement de récupération | Chaque état après récupération correspond à un état admis par la spécification, selon l’équivalence d’observation déclarée |
| R7-I9 | Compatibilité de snapshot | Le chargement ou la migration d’un snapshot respecte le profil de représentation et la version de schéma annoncés |
| R7-I10 | Récupération bornée | La vivacité de reprise est conditionnée par des hypothèses explicites sur stockage, supervision, réseau et disponibilité des dépendances |

Ces invariants doivent être formulés comme propositions avec des hypothèses énumérées, puis reliés aux transitions normatives ou à une spécification de runtime. Le tableau constitue une liste de travail, non l’annonce de résultats déjà démontrés.

## 7. Références et conséquences pour K7PL

### 7.1 FSCQ et Crash Hoare Logic

Le projet FSCQ du MIT illustre une méthode adaptée : le comportement après crash fait partie de la spécification du système de fichiers, et la preuve Coq porte sur les transitions de panne et de redémarrage. Les travaux ultérieurs distinguent aussi les garanties transactionnelles de garanties de durabilité différée. Cette distinction est importante : même une interface qui tolère la disparition de certaines écritures reste formalisable si son contrat indique lesquelles peuvent être perdues.

Sources :
- [FSCQ — File-system verification, MIT CSAIL](https://www.csail.mit.edu/research/fscq-file-system-verification)
- Chen et al., [Using Crash Hoare Logic for Certifying the FSCQ File System, SOSP 2015](https://pdos.csail.mit.edu/projects/fscq.html)

**Conséquence pour K7PL :** inclure un opérateur de crash et une relation de récupération dans le modèle de stockage abstrait. Spécifier les postconditions possibles après crash pour chaque opération plutôt que supposer que les écritures sont toutes durables ou toutes absentes.

### 7.2 SQLite : commit, WAL et hypothèses du support

La documentation SQLite détaille un protocole concret de commit, de rollback et de journal de pré-écriture (WAL). Elle expose les hypothèses matérielles et de système d’exploitation requises, notamment le rôle des flushes, des écritures de secteurs et du journal de récupération. Elle documente également des tests de panne simulée où l’ordre, l’incomplétude ou la corruption des écritures varient.

Sources :
- [SQLite — Atomic Commit](https://www.sqlite.org/atomiccommit.html)
- [SQLite — Write-Ahead Log file format and checkpoint algorithm](https://sqlite.org/fileformat.html#the_write_ahead_log)

**Conséquence pour K7PL :** choisir un protocole concret ou une abstraction équivalente et lister ses hypothèses de durabilité. Le fait que le runtime écrive un log ne suffit pas ; il faut définir le point de commit, l’ordre durable, la détection d’une fin partielle et le comportement de récupération. Des tests de panne doivent compléter le raisonnement, pas le remplacer.

### 7.3 Temporal : replay et effets d’activité

La documentation Temporal sépare l’historique ordonné utilisé pour reconstruire l’état du workflow des activités qui interagissent avec l’extérieur. Le code du workflow est rejoué à partir de l’histoire ; les résultats d’activités déjà consignés sont réutilisés. Une activité peut néanmoins être retentée si un worker s’arrête après avoir exécuté l’effet externe mais avant que le service reçoive sa confirmation, ce qui rend l’idempotence une exigence pratique pour ces appels.

Sources :
- [Temporal — Workflow replay](https://docs.temporal.io/workflows)
- [Temporal — Error handling and idempotent activities](https://docs.temporal.io/develop/python/best-practices/error-handling)

**Conséquence pour K7PL :** séparer le code de décision rejoué du transport d’effets externes. L’histoire doit consigner des résultats réutilisables ; les effets externes doivent porter une identité stable et un protocole de reprise explicite. Ne pas employer « exactement une fois » sans préciser si la propriété vise la livraison, l’exécution du code, l’enregistrement durable ou l’effet métier.

## 8. Scénarios adversariaux

Ces scénarios devraient devenir des modèles bornés et des tests de panne. Chacun doit vérifier l’état restauré, les événements joués, les ressources détenues et les effets externes, avec une assertion distincte pour les budgets.

1. Crash avant que le record de commande soit durable.
2. Crash après durabilité de l’intention mais avant émission de l’effet.
3. Effet externe appliqué, suivi d’un crash avant consignation du résultat.
4. Écriture de journal interrompue au milieu d’un enregistrement.
5. Écritures de données et marqueur de commit persistés dans un ordre inattendu.
6. Snapshot écrit mais référence de publication absente ou incomplète.
7. Référence au nouveau snapshot durable alors que son contenu ne l’est pas.
8. Rotation qui supprime le seul journal nécessaire avant validation du snapshot de remplacement.
9. Message livré deux fois avec un identifiant déjà validé.
10. Annulation après effet externe mais avant acquittement.
11. Timeout alors que le service distant a appliqué l’opération mais que sa réponse est perdue.
12. Ancienne instance qui reprend après expiration d’un bail et agit en parallèle avec la nouvelle.
13. Capacité de lecture ou d’écriture restaurée alors qu’une ancienne référence reste utilisable.
14. Capacité oubliée lors de la récupération, laissant un verrou ou une ressource exclusivement détenue impossible à récupérer.
15. Budget physique remis à sa valeur antérieure après reprise et utilisation répétée de la même opération.
16. Même coût logique débité plusieurs fois par le rejeu, jusqu’à épuisement artificiel du budget.
17. Snapshot écrit par une version de schéma différente, puis chargé ou migré sans validation de la sémantique.
18. Checksum correct mais contenu provenant d’un snapshot ancien restauré après une mise à jour autoritaire.
19. Deux répliques fusionnent un état CRDT tout en ayant chacune émis une commande externe exclusive.
20. Source aléatoire, horloge, ordre d’arrivée ou résultat de périphérique non consigné et produisant un chemin de rejeu différent.
21. Message acquitté avant que l’effet et son état soient durablement consignés.
22. Appel FFI ou callback en cours lorsque le runtime annule la tâche ou l’acteur.
23. Corruption d’un segment de log sans signalement, puis acceptation silencieuse d’un état restauré.
24. Échec répété du processus de récupération, avec libération prématurée des ressources ou reprise déclarée active malgré des opérations non réconciliées.

Un test qui passe donne une preuve sur le scénario exercé. La garantie générale demande une abstraction couvrant l’ensemble des points de panne autorisés et un argument reliant cette abstraction au stockage réel.

## 9. Plan de travail priorisé

**P0 — Figer le vocabulaire et le modèle de faute.** Distinguer annulation coopérative, crash d’acteur, redémarrage de machine, perte d’alimentation, corruption, partition et restauration d’ancienne copie. Préciser l’état durable attendu après chaque catégorie.

**P1 — Définir le journal et le checkpoint.** Fixer le schéma, les numéros de séquence, le traitement des enregistrements partiels, la règle de commit et le lien entre checkpoint et préfixe durable. Définir l’équivalence d’observation et le contenu de l’histoire nécessaire au rejeu.

**P2 — Modèle de transition avec crash.** Étendre un modèle de système minimal avec états volatile/durable, opérations de journal, points de crash et transition de récupération. Prouver R7-I1 et R7-I2 dans ce modèle. TLA+/TLC peut servir à explorer les entrelacements bornés ; ces résultats ne remplacent pas une preuve de raffinement ou une analyse du support physique.

**P3 — Propriété et ressources linéaires.** Ajouter au modèle les allocations, transferts, abandons, détenteurs, générations et ressources en récupération. Prover l’unicité d’autorité en considérant aussi les anciennes incarnations. Relier ensuite ces règles aux obligations de R5 sur les capacités et les régions mémoire.

**P4 — Effets externes et idempotence.** Spécifier le protocole entre intention, exécution externe, résultat et acquittement. Pour chaque type d’effet, indiquer si l’opération est idempotente, transactionnelle, compensable, interrogeable ou susceptible d’un résultat inconnu. Tester les duplications et la perte d’acquittement.

**P5 — Budgets de reprise.** Définir la comptabilité des tentatives réelles, des opérations logiques validées et du travail de récupération. Prouver qu’un retour arrière ne réinitialise pas un quota physique déjà consommé. Aligner ce contrat sur les résultats de R6 sans confondre coût abstrait, CPU et temps mural.

**P6 — Crash tests sur la cible.** Injecter un arrêt à chaque frontière d’écriture, publication, transfert de capacité et émission externe. Redémarrer ensuite depuis l’état de stockage résultant ; comparer les invariants, les ressources et les observations à l’oracle formel. Documenter précisément la machine, le système de fichiers, les options de synchronisation et les limites des tests.

**P7 — Chaîne de preuve.** Relier spécification normative → modèle abstrait avec crash → preuve Lean ou modèle vérifié → implémentation du stockage/runtime → tests d’injection de panne → configuration de déploiement. Tout maillon manquant demeure une obligation ouverte.

## 10. Grille de clôture

R7 ne pourra être fermé que lorsque les critères applicables auront une preuve ou une mesure explicitement qualifiée :

- [ ] Modèle de faute et hypothèses du stockage identifiés.
- [ ] Schéma du journal, de ses séquences et de ses enregistrements partiels défini.
- [ ] Point de commit et ordre de durabilité précisés pour checkpoint, journal et référence publiée.
- [ ] Relation entre checkpoint et préfixe d’événements validé prouvée.
- [ ] Théorème de rejeu lié à un historique effectivement complet et à une équivalence d’observation définie.
- [ ] Transitions de crash et de récupération intégrées au modèle formel.
- [ ] Conservation et transfert des ressources linéaires prouvés à travers panne et redémarrage.
- [ ] Anciennes incarnations clôturées ou contraintes par une époque vérifiée au point d’effet.
- [ ] Politique de reprise et de déduplication définie pour chaque famille d’effet externe.
- [ ] État « résultat inconnu » couvert lorsque effet et journal ne sont pas atomiques.
- [ ] Comptabilité des budgets physiques, logiques et de récupération séparée.
- [ ] Compatibilité des snapshots et migrations reliée au profil de représentation.
- [ ] Tests d’injection de panne reproductibles et rapportant leurs hypothèses et limites.
- [ ] Traçabilité de chaque garantie publiée jusqu’aux preuves, à l’implémentation et à la configuration réellement examinées.

## 11. Conclusion

Le cycle de vie C4 et le rejeu fournissent une architecture conceptuelle pour reprendre l’exécution d’un acteur. La preuve esquissée de rejeu est néanmoins conditionnée par la complétude du journal et laisse ses composantes essentielles à définir. L’arithmétique de budgets et l’invariant abstrait de capacités n’établissent pas encore le comportement des ressources lors d’une panne brutale.

La priorité n’est pas de promettre un rejeu « exact » en général, mais de définir ce qui est durable, ce qui peut être perdu, ce qui est rejoué, ce qui est répété et ce qui demeure incertain après chaque classe de panne. Le résultat visé doit être composé d’une preuve de reprise sur un modèle de stockage, de contrats pour les effets externes, d’invariants de conservation des ressources et de tests sur la cible. Jusqu’à cette composition, K7PL dispose d’une description du rejeu logique et d’obligations identifiées ; une garantie de crash consistency de bout en bout n’est pas établie par les artefacts étudiés.
