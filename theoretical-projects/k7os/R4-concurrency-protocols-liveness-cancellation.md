<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R4 — Concurrence, protocoles, vivacité et annulation

**Statut : étude non normative.** Révision de base : `main` à `4aea67661b049161689acb2163cfa1ebed1b5d5d` (2026-10-23). Le rapport n’altère pas les règles normatives et ne transforme pas les blocs `under-review` ou `proofsketch` du manuscrit en preuves mécanisées.

## 1. Résultat exécutif

K7PL possède les ingrédients d'une discipline de concurrence : sessions duales, canaux asynchrones, boîtes aux lettres typées, motifs de jonction, grades affines pour l'abandon, gestion d'erreur par `Try`, supervision et redémarrage. L'obligation principale reste cependant le lien entre le graphe de dépendances connu à la compilation et les attentes réellement atteignables lors de l'exécution. Le texte formule ce lien dans la prémisse `Sim` du théorème `thm:deadlock_acyclique`, mais précise encore que cette prémisse doit être prouvée pour `Guard`, émission, consommation, états résiduels de boîte et `Timeout`.

Les conclusions principales sont les suivantes.

1. **L'absence de blocage est conditionnelle.** Le théorème de C3 `thm:deadlock_acyclique` est marqué `under-review` et `proofsketch`. Il requiert que chaque attente dynamique soit représentée par une arête du graphe statique acyclique. Le tri topologique prouve l'existence d'un ordre de construction ; il ne démontre pas, à lui seul, cette correspondance sémantique.
2. **Le progrès n'est ni l'absence de blocage ni la terminaison.** Le théorème C4 `thm:progres` précise que son énoncé principal porte sur un calcul clos local. Le progrès d'un pool de tâches exige des objets supplémentaires, ainsi que la totalité des opérations et la conformité de l'arène. La preuve reste esquissée.
3. **La fidélité de session ne donne pas la progression.** Le protocole dual assure la compatibilité des échanges typés, mais ne garantit pas que l'émetteur atteigne son émission. C3 donne un contre-exemple à trois participants qui attendent chacun avant d'émettre.
4. **Annulation et panne ne sont pas entièrement intégrées à la sémantique des sessions.** C3 décrit un protocole qui ne représente pas l'échec, tout en autorisant l'abandon affine, `Timeout` et un circuit breaker dans les chapitres système. `Try` traite un effet `fail`, mais le contrat complet de l'annulation, de ses ressources, des messages déjà en boîte et du pair distant reste à établir.
5. **La vivacité dépend de l'environnement.** L'équité du scheduler ne garantit pas que l'horloge, le système mémoire, le transport ou le processus de reprise fasse son travail. Les textes de K7PL reconnaissent notamment une hypothèse d'équité mémoire pour la file concurrente. La propriété doit rendre ces hypothèses explicites.
6. **La reprise supervisée est un objectif architectural, pas encore une garantie globale prouvée.** Le texte évoque battements de cœur, instantanés, rejeu de journal, redémarrage et convergence CRDT. Les conditions sous lesquelles un acteur revient à l'état actif, un journal est complet ou un message est traité une seule fois doivent être isolées et reliées à R7 (pannes et persistance).

Recommandation immédiate : ne pas ajouter une primitive générale de concurrence avant d'avoir défini une configuration multi-acteurs commune, les événements terminaux, les transitions de panne et d'annulation, et l'invariant reliant graphes statique et dynamique. Commencer par une abstraction bornée exécutable pour faire apparaître les cas limites, puis formaliser le contrat non borné dans Lean. Un model checker ne remplace pas la preuve générale ; une preuve de sûreté locale ne remplace pas l'exploration temporelle.

## 2. Périmètre examiné et statuts

Sources K7PL consultées à la révision de base :

- [C3 — contraintes de valeur, sessions asynchrones et `thm:deadlock_acyclique`](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C3/ValueConstraints.lean#L190-L355)
- [C3 — règles de typage et noyau de la couche 2](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C3/TypingRules.lean#L1350-L1530)
- [C3 — grammaire des types](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C3/TypeGrammar.lean)
- [C4 — progrès opérationnel](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/OperationalSemantics.lean#L195-L255)
- [C4 — modèle d'acteur](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/ActorScale.lean#L25-L85)
- [C4 — supervision, dépendances, initialisation et concurrence](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/SystemScale.lean#L55-L110)
- [C4 — graphe statique et initialisation](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/SystemScale.lean#L200-L375)
- [C4 — jonction atomique et contrat encore ouvert](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/SystemScale.lean#L490-L540)
- [C4 — contrat de simulation vers le métalangage](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/C4/UnderlyingProcessCalculus.lean#L280-L325)
- [Annexe A.5 — codes d'erreur protocolaires et topologiques](https://github.com/AntheaLiles/k7pl/blob/4aea67661b049161689acb2163cfa1ebed1b5d5d/spec/Spec/AnnexA/ProtocolsSessionsAndDistributedTopology.lean)

Les blocs de théorème mentionnés dans les fichiers Verso portent leur statut éditorial déclaré. Ils ne sont pas des déclarations Lean vérifiées par le noyau du seul fait qu'ils se trouvent dans des fichiers `.lean`. Ce rapport est une analyse documentaire ; les scénarios de test ci-dessous sont proposés, non exécutés.

## 3. Distinguer les propriétés

Le vocabulaire de sûreté concurrente doit séparer au moins les propriétés suivantes.

| Propriété | Contrat à établir | Ce qu'elle ne garantit pas à elle seule |
|---|---|---|
| Fidélité de session | Chaque communication respecte le protocole et le type résiduel du canal | Qu'un message attendu soit effectivement produit |
| Sûreté de communication | Pas de tag, charge utile ou branche incompatible avec le protocole | Absence de blocage |
| Progrès local | Un calcul clos non terminal peut réduire, sous ses hypothèses d'exécution | Progrès du pool, équité ou terminaison |
| Progrès global | Tout état système non terminal a une transition pertinente, interne ou environnementale | Que chaque acteur obtienne sa part de CPU |
| Absence de blocage mutuel | Aucun état atteignable non terminal ne laisse tous les composants définitivement en attente | Absence de livelock ou de famine |
| Absence de famine | Chaque composant admissible finit par obtenir les étapes requises | Terminaison de l'ensemble du système |
| Terminaison | Toute exécution maximale admissible finit | Terminaison si la définition autorise des événements environnementaux qui n'arrivent jamais |
| Terminaison équitable | Toute exécution satisfaisant une hypothèse d'équité déclarée est finie | Une borne de temps ou une échéance |
| Absence de messages orphelins | Chaque message envoyé est consommé ou éliminé selon un contrat explicite | Absence de blocage si un message attendu n'est jamais envoyé |
| Récupération | Après une panne admissible, le système revient à un état spécifié | Reprise sans duplication, perte d'état ou divergence |

Un calcul peut toujours être capable d'avancer (progrès) sans terminer (divergence). Un système peut être exempt de blocage mutuel tout en laissant un acteur affamé. Une communication conforme au protocole peut attendre indéfiniment le pair qui doit produire son message. Ces propriétés exigent donc des énoncés et des preuves distincts.

## 4. Graphe statique contre graphe d'attente dynamique

### 4.1 Ce que le graphe statique permet

C4 décrit un graphe de dépendances entre gabarits d'acteurs et canaux, calculé en compilation. `thm:liberte_initialisation` revendique qu'un graphe acyclique permet un tri topologique et un câblage complet sans blocage à l'initialisation. Or l'obligation ouverte située dans le même bloc précise que l'acyclicité fournit un ordre, mais ne prouve pas que chaque initialiseur termine ni que toutes les attentes d'exécution correspondent exactement à une arête statique.

Cette distinction est décisive : un tri topologique ordonne un graphe fini déjà donné. Il ne démontre pas que le graphe contient toutes les causes d'attente possibles. Il faut aussi distinguer la finitude de l'étape d'initialisation de la progression ultérieure des acteurs. La preuve d'un ordre de construction n'est pas une preuve que toute attente à l'exécution se résout.

### 4.2 Le contrat Sim

Le théorème C3 `thm:deadlock_acyclique` est formulé sur un réseau d'acteurs typés par des protocoles duaux et dont le graphe statique de dépendances est acyclique. Il ajoute la prémisse `Sim` :

> si un acteur `a` attend un message de `b` dans un état atteignable, alors l'arête `(a,b)` figure dans le graphe statique.

Sous cette prémisse, un cycle d'attente dynamique induirait un cycle statique ; l'acyclicité l'exclurait. Cette implication est pertinente, mais la prémisse est exactement le pont sémantique à démontrer.

La note du même théorème le dit explicitement : il faut définir séparément les relations de dépendance statique et d'attente dynamique, puis établir l'invariant sur tous les états atteignables avec des cas pour `Guard`, émission, consommation, types résiduels de boîte et `Timeout`. Le commentaire qui affirme que la couche 2 permet maintenant de lire cette simulation « par construction » ne décharge pas cette obligation : aucune induction règle par règle n'est fournie dans ce bloc.

### 4.3 Contre-exemple structurel : arête manquante

Considérons un graphe de construction statique avec une unique arête `A → B`. Cette relation suffit à ordonner l'initialisation des gabarits. Si le graphe ne représente pas une attente de communication ajoutée par une branche ou un motif de réception, l'exécution peut néanmoins atteindre deux instances où `A₁` attend un message de `B₁` et `B₁` attend un message de `A₁`. Le graphe statique est acyclique, le graphe d'attente est cyclique.

Ce scénario n'est pas présenté comme une exécution actuelle de K7PL. Il montre pourquoi le contrat `Sim` est nécessaire : soit le compilateur refuse une telle configuration parce que toutes les attentes sont déjà représentées, soit la preuve de `Sim` doit démontrer qu'elle est inaccessible. Le tri topologique seul ne tranche pas.

Un contre-exemple connexe apparaît directement dans C3 : trois participants dont chacun attend le suivant avant d'émettre vers le précédent se bloquent, même si les extrémités des sessions sont duales deux à deux. Le typage local garantit la forme des interactions, pas l'atteignabilité de l'émission attendue.

### 4.4 Conditions minimales pour fermer Sim

- Définir les nœuds et arêtes du graphe statique : gabarits ou instances, canaux, sens des dépendances, gardes, dépendances environnementales et relations de création.
- Définir un état système atteignable : état de chaque acteur, protocole résiduel de chaque boîte, messages présents, timers, tâches engendrées et état de supervision.
- Définir précisément « attend » et « peut progresser », notamment pour `Guard` multi-place, un message incompatible, une boîte vide, une attente de `Timeout` et une terminaison normale.
- Définir la projection reliant une attente d'instance à une arête statique, puis prouver sa préservation sous chaque transition.
- Montrer que le mapping préserve assez de structure pour qu'un cycle dans le graphe d'attente induise un cycle interdit dans le graphe statique.
- Traiter séparément les états terminaux, les attentes devant se résoudre par un événement externe, les pannes et les expirations de délai.

Le graphe statique et le graphe dynamique ne doivent pas être confondus ni par nom ni par représentation. Si les dépendances dynamiques ne se projettent pas dans le DAG, l'absence de blocage doit être obtenue autrement : détection d'attente, politique de timeout, ordonnancement ou restrictions protocolaires plus fortes.

## 5. Sessions locales et composition multipartite

C3 choisit des protocoles de session comme syntaxe de surface de l'implication linéaire ; la dualité est obtenue par le retournement des arguments et non par un second système de règles. Le texte indique cependant que la préservation de l'encodage est connue pour la grammaire de GV, mais reste à démontrer pour celle de K7PL. La dualité et l'encodage syntaxique ne suffisent donc pas à établir une propriété système complète.

Le modèle déclaré est **asynchrone** : `Send` dépose un message dans la boîte et rend la main ; `Recv` bloque sur une boîte vide. Il ne faut pas appliquer sans traduction des résultats obtenus dans un modèle synchrone où l'émetteur et le récepteur progressent par rendez-vous. Le texte de C3 identifie précisément ce risque d'écart sémantique.

La conception a au moins trois voies possibles ; il ne faut pas en imposer une avant l'évaluation :

1. **Sessions locales et DAG, avec Sim prouvée.** Conserver l'architecture actuelle si son expressivité suffit. Cela demande la preuve de correspondance graphe statique / graphe dynamique et des cas corrects pour les branchements, les jonctions et les instances répliquées.
2. **Protocole global et projection locale.** Décrire une chorégraphie multiparty puis établir que les comportements locaux en sont des projections compatibles. Cette voie aide à vérifier des interactions impliquant plusieurs acteurs, mais ajoute des obligations de projection, de fusion des branches et de correspondance opérationnelle.
3. **Sessions locales plus analyse comportementale.** Garder des protocoles locaux et valider des propriétés globales avec une analyse de graphe ou un model checker ; le résultat doit être borné au modèle et à l'espace d'états analysés.

Ces approches ne sont pas interchangeables. Les résultats récents sur les types de session multiparty montrent que la fidélité et la vivacité requièrent une relation d'association ou de correspondance entre comportements globaux et locaux ; un type local par paire ne la remplace pas automatiquement.

## 6. Timeout, annulation et ressources

### 6.1 Décalage dans le texte normatif

C3 indique que la grammaire des sessions décrit des protocoles qui ne peuvent pas échouer, alors que `Timeout` et le circuit breaker du chapitre 4 peuvent interrompre une session. Le même texte relève que l'extension de logique linéaire susceptible de représenter abandon et non-déterminisme n'est pas transportée dans le cadre intuitionniste retenu : ce transfert reste une obligation, pas un acquis.

D'autre part, la couche 2 autorise un canal annulable de grade affine, et `Try` compose les effets du calcul protégé et du gestionnaire avec `fail`. Ces mécanismes donnent des points d'entrée, mais ne définissent pas à eux seuls la sémantique de l'annulation : `Try` n'est pas implicitement un gestionnaire de toute panne du runtime ou de tout partenaire disparu.

### 6.2 Contrat d'annulation requis

Pour une annulation demandée, un timeout ou une panne, la spécification doit préciser :

- si l'arrêt est local, propagé aux descendants, communiqué au pair, ou coordonné à l'échelle d'une session ;
- si l'acteur attend la fin des enfants engendrés par `Spawn`, les abandonne ou les transfère au superviseur ;
- le sort des messages déjà envoyés, messages partiellement consommés et boîtes non vides ;
- la restitution ou la destruction des capacités, buffers, timers et autres ressources linéaires ;
- l'état terminal observable : fini normalement, annulé, en erreur, en panne ou en récupération ;
- la course entre complétion et annulation, et l'idempotence d'une seconde demande ;
- l'effet d'une annulation sur l'état résiduel du protocole du pair ;
- la propagation des erreurs : lesquelles sont capturées par `Try`, lesquelles déclenchent un redémarrage, et lesquelles sortent du modèle.

C3 précise que `Free` exige une boîte vide, ce qui interdit de libérer une boîte typée avec des messages non lus. Cette contrainte doit être conciliée explicitement avec l'abandon d'un canal et l'annulation d'une session : vider, déplacer, consommer ou jeter les messages doit être une transition reconnue avec un contrat de ressource. L'affinité autorise à ne pas utiliser une ressource ; elle ne spécifie pas automatiquement ce qui advient aux messages en attente ou au partenaire distant.

### 6.3 Temps et événements externes

Un `Timeout` n'est pas une preuve de terminaison : il produit un événement qui permet une branche de reprise ou d'échec. Sa progression dépend d'un modèle temporel et de l'hypothèse que l'événement d'expiration finit par devenir actif. L'arbitrage entre message reçu et expiration doit être défini ; autrement, deux exécutions à mêmes messages peuvent suivre des chemins différents sans que la relation soit précisée.

P3-B maintient par ailleurs la latence d'attente environnementale de `When` séparée du coût d'exécution de l'automate déclenché et de `Cost_Budget`. R4 doit conserver cette séparation : une observation temporelle utilisée dans une preuve de vivacité ne doit pas être ajoutée implicitement à la facture d'exécution. La représentation exacte de cette latence reste une obligation d'interface du texte actuel.

## 7. Crash, superviseur et récupération

C4 décrit un cycle de vie désactivé/actif, le chargement d'un instantané, la relecture de messages consignés, un superviseur à battements de cœur, et le retour attendu d'un acteur après panne. Cette architecture doit séparer quatre modèles :

- **Crash-stop** : le participant tombe et ne redémarre pas dans l'exécution étudiée.
- **Crash-restart** : il redémarre avec un état persistant et éventuellement un journal.
- **Partition** : les participants restent actifs mais ne peuvent pas échanger ; la reconnexion peut arriver, ou non.
- **Panne du superviseur ou de la persistance** : le mécanisme qui devait rétablir le service devient lui-même indisponible.

Une garantie « l'acteur redevient actif » n'est valide que si les hypothèses qui la rendent possible sont dites : panne finie ou politique de retry bornée, superviseur vivant, ressources disponibles, stockage durable, connectivité rétablie pour le cas de partition, et progrès de l'ordonnanceur. Si les pannes peuvent se répéter sans fin, une garantie inconditionnelle de retour à l'état actif ne suit pas d'un heartbeat.

Le rejeu requiert lui aussi un contrat précis : journal complet, ordre des événements stable, représentation des réponses non déterministes, politique de déduplication, et distinction entre « effet externe exécuté » et « confirmation enregistrée ». Après une panne entre l'effet et l'enregistrement de son résultat, le rejeu peut sinon répéter cet effet. La conception de journal durable et de ressources persistantes relève de R7, mais les états de protocole et l'effet du crash sur les sessions doivent être définis ici.

La convergence d'un type CRDT après partition n'établit pas, seule, le rétablissement du service ni la terminaison des demandes. Elle exige au minimum les hypothèses de convergence du type, une voie de communication future et un mode d'exécution qui finit par appliquer les messages nécessaires.

## 8. Équité : scheduler, mémoire, communication et environnement

L'équité est une hypothèse sur les exécutions, non un synonyme de progression. Pour K7PL, au moins quatre couches sont à différencier.

| Couche | Hypothèse possible | Lacune si elle manque |
|---|---|---|
| Scheduler | Équité faible d'une étape continûment activable, ou équité forte si elle est activable infiniment souvent | Un acteur peut être affamé alors qu'une transition reste possible |
| Mémoire partagée | Les propagations requises finissent par être visibles | Un consommateur peut ne pas observer une publication dans le modèle faible |
| Transport | Les messages admis finissent par être livrés ou la perte est gérée | Un protocole attend un message perdu indéfiniment |
| Environnement | Timer, I/O ou événement déclencheur survient selon une hypothèse | `When` ou la branche de timeout reste en attente pour toujours |

C4 note explicitement qu'un raisonnement sur la file sans verrou a besoin d'équité mémoire, pas seulement d'équité entre threads. Ce point doit rester dans les hypothèses de l'invariant de vivacité et de sa réalisation mémoire.

Les travaux TLA+ de Lamport distinguent sûreté et vivacité et montrent qu'un objectif comme la terminaison exige des hypothèses d'équité sur les actions. La faiblesse ou la force de l'équité compte : si une étape devient activable de façon intermittente, l'équité faible peut ne pas suffire. Une preuve formelle doit donc nommer les actions concernées, ce que signifie « activable », et les hypothèses qui ne dépendent pas du programme.

La **terminaison équitable** peut être la propriété appropriée pour une communication asynchrone, mais ce n'est pas une terminaison sans hypothèses : la notion d'exécution équitable doit être formellement fixée. Elle doit également tenir compte des messages envoyés tôt, des messages orphelins et de la famine, sans être confondue avec l'absence de cycle statique.

## 9. Modèle borné proposé

Pour produire des contre-exemples reproductibles, définir un modèle fini indépendant de l'implémentation concrète.

### État

- Un ensemble fini d'acteurs, chacun avec un état de contrôle : `Init`, `Running`, `Blocked(guard)`, `Done`, `Cancelled`, `Crashed` ou `Restarting`.
- Un protocole résiduel par canal et une boîte aux lettres de capacité finie contenant un multiensemble de tags et charges utiles abstraites.
- Des états de ressources : capacité disponible, transférée, consommée ou libérée ; aucun pointeur réel n'est nécessaire pour le premier modèle.
- Des timers avec un nombre fini de valeurs abstraites, permettant de représenter « non expiré », « expiré » et les courses de réception/expiration.
- Un superviseur, des instantanés simplifiés, un journal d'événements et un indicateur de partition.
- Un ordonnanceur non déterministe, plus des paramètres d'équité explicites.

### Transitions minimales

`Send` dépose un message selon la règle et la capacité de la boîte ; `Guard/Recv` consomme les messages attendus et fait évoluer le protocole résiduel ; `Spawn` crée une tâche ; `Finish` libère seulement les ressources permises ; `Timeout` déclenche la branche spécifiée ; `Cancel` exécute le contrat d'annulation ; `Crash` rend un participant indisponible ; `Restart` relit son état durable ; `Deliver` modélise la livraison réseau ; `Schedule` choisit une transition activable.

Le modèle doit conserver les distinctions entre terminaison normale, annulation, erreur, blocage mutuel, attente environnementale et état de reprise. Une seule valeur booléenne « bloqué » ferait perdre précisément les cas à analyser.

### Propriétés à vérifier

- Fidélité protocolaire et compatibilité de chaque message avec l'état résiduel.
- Conservation des capacités et absence de libération d'une boîte non vide, sauf transition explicite de nettoyage.
- Absence de cycle d'attente dans tous les états atteignables, ou détection et récupération selon le contrat.
- Progrès global sans affirmer la terminaison.
- Famine, absence de messages orphelins et terminaison équitable sous les hypothèses nommées.
- Retour d'un acteur après la classe de panne autorisée, sans prétendre couvrir les pannes exclues.
- Comportement déterminé des courses entre message, expiration, annulation, crash et reprise.

L'exploration bornée sert à trouver des traces témoins et à valider la formulation des invariants. Elle ne démontre pas le résultat sur un nombre arbitraire d'acteurs, des files non bornées ou toutes les stratégies d'ordonnancement. Toute généralisation nécessite une abstraction prouvée ou une preuve séparée.

## 10. Scénarios adverses à tester

Les tests ci-dessous sont des exigences de conception. Ils ne sont pas présentés comme exécutés sur un runtime K7PL.

| ID | Scénario | Attente discriminante |
|---|---|---|
| T1 | Trois participants ont des sessions duales par paire, chacun attendant avant d'émettre vers le précédent | Le cycle est rejeté ou le contre-exemple est détecté avant exécution |
| T2 | Graphe d'initialisation acyclique, mais une garde attend une dépendance dynamique non représentée | La preuve ou le test met en défaut le lien supposé entre graphes |
| T3 | Un `Guard` multi-place reçoit un message requis mais pas l'autre | Aucun état n'est déclaré activable sans l'appariement complet et les gardes |
| T4 | Un producteur monopolise une boîte ou un consommateur est activable par intermittence | La propriété distingue équité faible, équité forte et famine |
| T5 | Un message et un `Timeout` deviennent possibles dans la même fenêtre | L'arbitrage est défini ; le protocole résiduel reste valide |
| T6 | Annulation pendant une attente avec messages déjà dans la boîte | Le nettoyage et le devenir du pair sont définis, sans ressource silencieusement perdue |
| T7 | Parent annulé après `Spawn`, enfant toujours actif | Le contrat dit si l'enfant survit, s'arrête ou passe au superviseur |
| T8 | Crash entre un effet externe et l'écriture de sa confirmation au journal | Le rejeu n'introduit ni répétition ni omission non couverte par le contrat |
| T9 | Message reçu puis acteur arrêté avant l'enregistrement de l'état résiduel | La reprise ne réapplique pas une transition de façon incohérente |
| T10 | Panne définitive du superviseur ou crashes répétés sans fin | La propriété de récupération ne promet pas un retour inconditionnel |
| T11 | Émission visible au modèle local, mais propagation mémoire différée sans hypothèse d'équité mémoire | L'invariant est conditionné au modèle mémoire exact |
| T12 | `Free` sur une boîte non vide après une annulation | Le typage refuse l'état ou une transition explicite de nettoyage vide la boîte |
| T13 | Partition prolongée puis rétablissement de la connectivité | Les conditions de convergence et de retour à l'activité sont vérifiées séparément |
| T14 | File pleine, dépassement de capacité, perte de message ou message du mauvais tag | La politique de rétropression, rejet, retry ou erreur est déterministe au niveau du contrat |

Ajouter, pour chaque scénario, la trace d'états minimale, le statut terminal attendu et l'hypothèse environnementale requise. Une passe de tests ne démontre pas le théorème général ; un échec doit fournir une trace reproductible.

## 11. Architecture de preuve et ordre des travaux

### P1 — fermer la sémantique

1. Définir une configuration complète multi-acteurs : contrôles, état mémoire, boîtes, protocole résiduel, tâches engendrées, timers, supervision et événements.
2. Donner des transitions distinctes pour réussite, attente, terminaison, annulation, timeout, crash et reprise.
3. Définir la projection d'attente et prouver `Sim` par induction sur les transitions et les états atteignables, sans dériver l'arête attendue du fait même que le typage l'exige.
4. Réviser `thm:liberte_initialisation` pour inclure la terminaison locale des initialisateurs et la correspondance des attentes avec les dépendances.
5. Isoler le progrès local de `thm:progres`, le progrès global du pool, l'absence de blocage et la terminaison équitable ; nommer toutes les prémisses d'opération totale et de conformité du compilateur.

### P2 — protocoles et fautes

6. Formaliser l'état résiduel des boîtes et les règles effectives `Send`, `Guard`, `Free`, `Timeout` et `Cancel`, y compris le devenir des messages pendants.
7. Définir le contrat du superviseur et les classes de panne couvertes ; lier le rejeu à un journal complet et au traitement des effets externes, en coordination avec R7.
8. Définir les hypothèses d'équité de scheduler, mémoire, transport et environnement dans une formule temporelle vérifiable.
9. Décider si les sessions locales avec graphe acyclique couvrent les protocoles multipartites visés. Si oui, documenter l'expressivité exclue ; sinon, évaluer une projection globale ou une analyse comportementale additionnelle.

### P3 — preuve et contre-exemples reproductibles

10. Construire le modèle fini ci-dessus dans TLA+/TLC ou un outil comparable, l'utiliser pour explorer T1–T14 et archiver les contre-exemples.
11. Formaliser dans Lean les configurations, transitions, relation graphe statique / dynamique et invariants de ressources ; prouver le résultat non borné dans le périmètre explicitement retenu.
12. Relier les énoncés à la sémantique source et à sa traduction. Le contrat C4 de simulation vers le métalangage reste lui-même un bloc `under-review`/`proofsketch`, de sorte qu'une preuve locale du réseau abstrait ne suffit pas à prouver le comportement de l'implémentation compilée.

L'ordre est intentionnel : ajouter une preuve de vivacité avant de définir les états bloqués, les transitions environnementales et les annulations conduirait à un théorème dont le modèle ignore précisément les cas difficiles.

## 12. Matrice de statut

| Revendication | État sur la base examinée | Ce qu'il faut avant clôture |
|---|---|---|
| Dualité et typage local de session | Décrits dans C3 ; préservation de l'encodage K7PL non démontrée dans le texte | Preuve de typage et correspondance avec la sémantique asynchrone |
| Absence de blocage mutuel | `thm:deadlock_acyclique` sous revue, conditionnel à `Sim` | Relation formelle entre graphe statique et attente dynamique, préservée par toutes les transitions |
| Initialisation depuis un DAG | `thm:liberte_initialisation` sous revue ; terminaison locale ouverte | Terminaison de chaque initialiseur et correspondance complète des dépendances |
| Progrès local | `thm:progres` sous revue ; hypothèses d'opérations totales et de conformité d'arène | Preuve sous hypothèses et énoncé limité au calcul clos concerné |
| Progrès du pool | Reconnu distinct dans la note de C4 ; pas déduit du progrès local | Modèle système et preuve d'existence d'une transition pertinente |
| Terminaison et absence de famine | Non établies pour la concurrence asynchrone globale | Propriété temporelle et hypothèses d'équité explicites |
| Annulation et timeout | Mécanismes mentionnés ; sémantique complète des sessions et ressources ouverte | Transitions, dualité après abandon, nettoyage et traitement des messages |
| Crash/restart | Architecture décrite ; retour à l'activité dépend de l'environnement et de la persistance | Classes de panne, hypothèses de disponibilité, contrat du journal et preuve de reprise |
| Absence de messages orphelins | `Free` exige une boîte vide ; interaction avec abandon à spécifier | Consommation ou nettoyage défini par transition, puis preuve d'invariant |
| Correction de la file et du scheduler | Hypothèse d'équité mémoire explicitement signalée pour le modèle de file choisi | Relier le modèle mémoire au code généré et déclarer l'hypothèse d'équité |

## 13. Sources externes et portée des résultats

- Leslie Lamport, [PlusCal Tutorial — Liveness](https://lamport.azurewebsites.net/tla/tutorial/session9.html) et [Safety, Liveness, and Fairness](https://lamport.azurewebsites.net/tla/safety-liveness.pdf). Distingue les propriétés de sûreté des obligations temporelles et traite l'équité faible/forte comme des hypothèses explicites.
- Luca Padovani et Gianluigi Zavattaro, [*Fair Termination of Asynchronous Binary Sessions*](https://doi.org/10.1145/3803862), *ACM Transactions on Programming Languages and Systems* 48(2), publié le 12 mai 2026. Montre qu'une terminaison de session asynchrone peut nécessiter une équité formalisée, avec absence de famine et de messages orphelins ; la version complète de l'article distingue aussi une variante décidable plus restreinte.
- Omer Keskin, Nobuko Yoshida et Rob van Glabbeek, [*Formally Verified Liveness with Multiparty Session Types in Rocq*](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITP.2026.4), ITP 2026. Preuve mécanisée de vivacité dans un cadre MPST synchrone, avec relation entre types globaux et locaux ; c'est une méthode comparative, pas une preuve transférable telle quelle au modèle asynchrone K7PL.
- Adam D. Barwell, Alceste Scalas, Nobuko Yoshida et Fangyi Zhou, [*Generalised Multiparty Session Types with Crash-Stop Failures*](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CONCUR.2022.35), CONCUR 2022. Intègre les crashes dans la sémantique des sessions, explicite les hypothèses de fiabilité et utilise le model checking pour des propriétés telles que l'absence de blocage et la vivacité.
- Ping Hou, Nicolas Lagaillardie et Nobuko Yoshida, [*Fearless Asynchronous Communications with Timed Multiparty Session Protocols*](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ECOOP.2024.19), ECOOP 2024. Articule protocoles multiparty, temps, affinité et timeout, utile pour isoler le contrat absent autour de l'abandon et des échéances.

Ces travaux établissent des résultats dans leurs modèles précis. Ils servent à choisir des obligations et méthodes de vérification pour K7PL ; ils ne transfèrent pas automatiquement leurs garanties au langage ou à son runtime.

---
**Conclusion :** le cœur de R4 n'est pas l'ajout d'une nouvelle coordonnée de grade. C'est la preuve du pont entre topologie statique et attentes dynamiques, puis la définition des événements et hypothèses sous lesquels progrès, annulation et récupération sont des propriétés exactes. Jusqu'à la preuve de `Sim` et à la fermeture de ces contrats, l'absence de blocage, la vivacité globale et le retour garanti après panne restent conditionnels.
