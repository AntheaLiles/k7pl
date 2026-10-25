<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7OS — Dossier d'exploration conjointe

**Nom de travail :** K7OS (*KonSept Operating System*).  
**Statut :** portefeuille non normatif de cibles, variantes et obligations d'étude.  
**Révision de travail :** PR [#300](https://github.com/AntheaLiles/k7pl/pull/300), base `main@76d8c1c5cb54ebaa6ab43d78b53979f63a0de8fd`, au 2026-10-24.  
**Sources principales :** dossiers de recherche R0–R9 et registre [SPEC-DELTA-REGISTER.md](SPEC-DELTA-REGISTER.md).

## 1. Finalité et règle de conservation

Ce dossier préserve les cibles architecturales, les mécanismes candidats et les questions déjà étudiés dans le cadre de K7PL, en vue de l'exploration conjointe de K7OS. Leur retrait d'un texte normatif du langage ne signifie ni abandon du sujet ni réfutation de l'option : il peut simplement indiquer qu'elle relève de l'architecture d'OS, d'un profil concret, du runtime, de la plateforme ou de la base de confiance plutôt que de la sémantique générale du langage.

Le dossier n'arrête pas d'architecture, ne remplace pas la spécification K7PL et ne transforme aucune hypothèse en garantie. Il conserve le contexte, les bénéfices attendus, les limites déjà identifiées et les preuves ou décisions encore nécessaires. Toute décision de retenir une variante comme architecture de référence devra être explicite ; les choix ayant un impact normatif sur K7PL devront suivre le processus de décision du projet.

### Légende de statut

- **Cible historique à conserver** : variante déjà présente dans la conception ou explicitement étudiée ; elle doit rester dans l'espace des possibles.
- **Exigence K7PL à préserver** : contrainte déjà normative dans la spécification courante ; ce dossier ne la rétrograde pas.
- **Mécanisme candidat** : technique étudiée, non encore sélectionnée.
- **Obligation ouverte** : définition, preuve, raffinage, mesure ou validation manquante.
- **Décision d'architecture différée** : arbitrage à faire lorsque le périmètre fonctionnel, le profil de menace et la plateforme sont suffisamment établis.

Les termes « prévu », « candidat », « décrit » et « étudié » désignent des états de recherche et non des résultats démontrés.

## 2. Profil architectural initial à ne pas perdre

### 2.1 Variante unikernel à domaine d'adressage partagé

La conception antérieure de l'échelle système décrivait des acteurs exécutés en anneau 0, dans un espace d'adressage physique partagé, sans séparation mutuelle reposant sur la MMU. L'argument de sûreté attribuait aux types K7PL la protection des composants compilés conformément au langage. Cette proposition forme une **cible historique à conserver**, pas une décision à effacer du dossier architectural.

Les coûts qu'elle visait à éviter ou réduire sont notamment les changements de domaine, les transitions de privilège, les commutations de contexte et les invalidations de TLB. Un domaine d'exécution spécialisé peut aussi réduire la surface logicielle réellement embarquée et permettre des appels internes directs.

Cette voie reste conditionnée à une frontière de confiance stricte : un système de types ne contraint pas, par lui-même, du code natif arbitraire, de l'assembleur, un pilote non conforme, une chaîne de compilation fautive, un composant privilégié compromis ou un périphérique capable de DMA. Dans un espace partagé sans mécanisme de protection supplémentaire, ces composants doivent soit appartenir à la base de confiance, soit être limités par un mécanisme dont l'efficacité est établie. Le typage ne doit jamais être présenté comme un confinement du code auquel ses règles ne s'appliquent pas.

**À mesurer si cette variante est prototypée :** coût des appels directs, transitions et IPC ; empreinte ; latence et variabilité ; coût de gestion des acteurs ; comportement en cas de panne d'un composant ; étendue exacte de la base de confiance ; conséquences d'un défaut natif ou d'un accès DMA non autorisé.

### 2.2 Variantes de comparaison — aucune n'est présélectionnée

| Variante à comparer | Références du dossier R8 | Avantage à évaluer | Limite ou condition déjà identifiée |
|---|---|---|---|
| Langage sûr dans un espace partagé | Theseus ; capsules de Tock | Échanges directs, séparation statique des composants, coût réduit | Forte dépendance au langage, au compilateur et à la discipline du code natif ; Tock combine cette voie avec des processus protégés |
| Unikernel spécialisé et modulaire | MirageOS ; Unikraft | Image ciblée, dépendances choisies au build, déploiement spécialisé | La spécialisation et les frontières d'API ne créent pas une isolation entre bibliothèques d'un même domaine |
| Micro-noyau et services à capacités | seL4 ; Genode ; Zircon/Fuchsia ; QNX Neutrino ; MINIX 3 | Domaines de protection, IPC et autorité explicites, possibilité de redémarrer un service isolément | Coût des frontières et des échanges ; garantie dépendante du noyau, de la configuration, des pilotes et du TCB |
| Compartiments à capacités matérielles | CHERIoT RTOS ; familles de mécanismes CHERI | Bornes et permissions de mémoire imposées par le matériel, transitions contrôlées | Nécessite une plateforme compatible ; chargeur, allocateur, transitions et configuration restent critiques |
| Code système vérifié ou raffiné | Verve ; Cogent | Relier abstraction, règles de typage, bas niveau et compilation | Couverture limitée par les langages et interfaces effectivement modélisés ; la chaîne restante doit être déclarée |
| Système multicœur de type multikernel | Barrelfish | Communication inter-cœurs explicite, état répliqué et prise en compte de topologies hétérogènes | Demande des contrats sur messages, cohérence, réplication, pannes de communication et coûts de coordination |
| Modularité dans un environnement plus large | Redox ; GNU Hurd ; FreeBSD ; OpenBSD pledge/unveil ; Qubes OS | Comparer séparation des services, confinement et granularité de la politique | Les frontières et garanties diffèrent ; ne pas transposer un mécanisme sans son modèle de privilèges et ses hypothèses |

R8 contient aussi des contrepoints historiques et conceptuels — TempleOS, Oberon, Multics, PICK, DBOS, Plan 9, Inferno, A2/Bluebottle, 9front, Harvey, Medley Interlisp et k23. Ils sont conservés comme matière comparative, non comme candidats équivalents : certains éclairent l'environnement de développement, les espaces de noms, la structuration des services ou les modèles de données plutôt qu'une architecture de sécurité moderne. Aucun benchmark commun ne permet de classer ces systèmes par performance.

**Décision différée :** choisir le profil de référence après avoir fixé le type de déploiement (embarqué, machine dédiée ou environnement virtualisé), les adversaires admis, la politique de code natif, la portée des pannes et les cibles matérielles.

## 3. Contraintes K7PL qui doivent rester visibles dans K7OS

Cette section distingue les contraintes actuelles du langage de leurs choix de réalisation. Elle n'autorise pas à les affaiblir au motif que certains détails concrets ont été retirés de C4.

### 3.1 Invariants des couches

- **Couche 3 :** calcul cartésien et pur (`𝓔 = ∅`) ; les calculs valides terminent sous les schémas récursifs admis ; le coût de pile est statiquement gradué. Le statut `under-review` d'une preuve ne diminue pas cette exigence normative.
- **Couche 2 :** chaque observation exigée doit être productive en temps fini sous la garde de productivité correspondante. Cela ne garantit ni la terminaison du flux entier, ni la sélection de l'acteur par l'ordonnanceur, ni la visibilité d'une publication sous toute mémoire faible.
- **Progression :** sûreté, progrès local, progrès global, absence de blocage, absence de famine, terminaison, terminaison équitable et respect d'échéance restent des propriétés séparées avec leurs propres hypothèses.
- **Budget :** le budget abstrait ne vaut pas à lui seul quota CPU, WCET, durée murale ou garantie d'échéance.

### 3.2 Représentation mémoire des acteurs

La représentation ECS/SoA/PIA, les segments d'indices contigus, les zones d'écriture disjointes, l'alignement de 64 octets, le placement NUMA local et l'exigence de parallélisme sans mutex sont des contraintes normatives présentes dans la spécification d'acteur courante. Elles ne sont pas retirées par le déplacement des choix d'architecture système vers ce dossier.

Il reste toutefois à distinguer et relier formellement :
1. la disjonction exprimée par les types et capacités ;
2. l'identité sémantique des régions et la provenance des références ;
3. la disposition physique, l'alignement et le placement NUMA ;
4. les opérations de lecture/écriture, atomiques et de synchronisation réellement émises ;
5. la correspondance entre l'exécution abstraite et la machine cible.

La conformité d'une représentation physique ne découle pas de la seule preuve d'une propriété arithmétique ou d'un comptage abstrait de capacités.

### 3.3 Références d'entité et déduplication

La sûreté d'`EntityRef` doit continuer à garantir qu'une référence périmée ou invalide n'autorise aucun accès ni effet sur une autre entité. L'encodage index/génération (par exemple deux mots de 32 bits) reste une option de représentation, pas une garantie à lui seul. La validation sur chaque accès, le recyclage, le débordement/réinitialisation de génération et la restauration d'état demandent un contrat.

BLAKE3 est étudié comme filtre de comparaison, pas comme fonction injective : une égalité de condensat doit être suivie d'une comparaison structurelle exacte lorsque le contrat requiert une déduplication exacte. Cela sépare le choix performant d'implémentation de la propriété sémantique visée.

## 4. Autorité, mémoire et frontières de confiance

### 4.1 Modèles d'autorité à ne pas confondre

R1 et R5 distinguent au moins la possession d'une valeur linéaire, une capacité logicielle protégée, un objet-capacité du noyau et une capacité matérielle. Ces niveaux ne sont pas interchangeables. Un compteur Lean de jetons établit un résultat dans le modèle arithmétique qu'il représente ; il ne prouve pas que chaque opération du binaire vérifie une autorité effective.

À conserver comme obligations autonomes :

- H1 : introduction unique des capacités d'écriture pour une région ;
- H2 : relation entre les plages numériques, leur provenance et l'identité réelle des régions ;
- H3 : impossibilité pour une valeur duplicable de capturer indirectement une autorité mémoire linéaire ;
- bornes et durée de vie des accès ; création, découpage, recomposition, destruction et recyclage ;
- emprunt partagé, emprunt mutable, réemprunt, suspension et restitution des droits ;
- alias, callbacks, références retenues après retour FFI et opérations déjà en vol pendant une révocation ;
- modèle mémoire faible, atomiques et synchronisations, distincts des seules permissions de lecture/écriture.

Ces obligations ne justifient pas de choisir immédiatement Rust, une logique de séparation particulière ou des permissions fractionnaires. R5 demande d'abord une algèbre minimale de ressources, sa liaison à la mémoire concrète et des règles source suffisantes.

### 4.2 FFI et composants natifs

R0/R1 imposent de conserver deux profils de confiance : **natif conforme à son contrat** et **natif potentiellement hostile**. Le contrat d'interface doit décrire les représentations, les effets, les erreurs, la propriété et la durée de vie, l'aliasing, les callbacks, la réentrance, les threads, l'autorité transmise et les conditions de révocation.

L'annotation `unsafe`, la signature typée et la capacité abstraite ne sont pas, individuellement, des mécanismes de confinement. Des mécanismes de sandbox, de domaines de protection, de tables de handles, de signatures de paquets, de chaîne de confiance et de révocation de clés ont été étudiés comme moyens possibles de réduire le risque ; ils ne constituent ni un paquet unique obligatoire ni une preuve de sûreté en soi.

La proposition de sandbox de phase 0 (interdire par défaut les accès fichiers, réseau et horloge), les chaînes de signature et leur révocation ont été retirées d'une prescription trop concrète de la spécification, mais doivent rester dans l'espace d'évaluation des profils du compilateur et du runtime. Il faudra comparer le coût, les privilèges, les voies de contournement, le modèle de clés, la révocation et les garanties résiduelles. L'objectif de compilation reproductible demeure un objectif d'assurance tant que ses critères exacts et sa chaîne de confiance ne sont pas validés.

### 4.3 Périphériques et DMA

La cible K7OS doit expliciter qui peut programmer les périphériques, écrire les registres MMIO, recevoir les interruptions, lire ou écrire les buffers et conserver les mappings après révocation. Les options comprennent désactivation du DMA pour les périphériques non fiables, IOMMU/SMMU configuré et contrôlé, confinement par processus/pilote, ou capacités matérielles si la plateforme les fournit.

Ce sont des options de mise en œuvre à analyser selon la plateforme et le modèle de menace. Sans isolation DMA effectivement appliquée, un système CPU-safe ne peut pas prétendre isoler les zones mémoire qu'un périphérique peut modifier librement.

## 5. Exécution d'acteurs, concurrence et protocoles

### 5.1 Graphe statique, attentes dynamiques et équité

Le graphe statique de dépendances et le graphe d'attente dynamique ne doivent pas être confondus. La prémisse `Sim` reste le pont ouvert pour relier les attentes atteignables à des arêtes du graphe statique, notamment pour `Guard`, émission, consommation, états résiduels de boîte et `Timeout`. L'acyclicité donne un ordre topologique ; elle n'établit pas, seule, terminaison de tous les initialiseurs, progrès global ou absence de famine.

La productivité locale de couche 2 doit rester distincte de l'équité de l'ordonnanceur, de la propagation mémoire, de la livraison des messages, de la disponibilité d'une horloge ou du succès d'une reprise. Sous mémoire faible, un consommateur en polling peut continuer à sonder sans observer la publication du producteur si les hypothèses de propagation ne le garantissent pas.

### 5.2 Files et primitives de synchronisation candidates

Les anneaux SPSC, files sans verrou, barrières acquire/release, structures de type LMAX Disruptor, files de messages et mécanismes d'ordonnancement sont préservés comme candidats à prototype et à mesure. Ils ne doivent pas être traités comme interchangeables : chacun suppose une topologie de producteurs/consommateurs, un modèle mémoire, un protocole de propriété, une politique de débordement et un contrat de progrès.

La comparaison doit couvrir :
- correction fonctionnelle des échanges et absence de courses incompatibles ;
- relation entre les atomiques du code source, l'ordre mémoire du modèle et les instructions du binaire ;
- visibilité des publications et hypothèses d'équité ;
- coût par message, débit, latence, contention, affinité et comportement NUMA ;
- annulation, fermeture, reprise après panne et libération des ressources.

PEPA ou d'autres modèles de performance peuvent analyser des hypothèses quantitatives ; ils ne remplacent pas le contrat de sûreté ni la preuve sémantique des protocoles.

### 5.3 Annulation, expiration et commits

Le modèle borné R9 conserve un contre-exemple utile : une demande d'annulation peut arriver après acceptation d'une requête mais avant son commit, et ne garantit pas qu'un commit soit encore impossible. Un accusé d'annulation doit refléter l'état effectivement atteint, pas la seule émission de la demande. La sémantique précise des états, des effets externes, de l'acquittement et des courses doit être décidée avant d'en faire un contrat runtime.

Pour `When`, la latence d'attente d'un événement environnemental reste distincte du coût d'exécution de l'automate déclenché et de `Cost_Budget`. Un timeout exige un modèle d'horloge et une règle d'arbitrage entre expiration et arrivée du message ; aucun de ces points ne se déduit de l'acyclicité du graphe.

## 6. Supervision, panne, instantanés et persistance

La conception système a utilisé un superviseur, des battements de cœur, un cycle d'acteur désactivé/actif, le chargement d'instantanés, un journal/rejeu de messages et des attentes de convergence après redémarrage. Ces idées sont préservées comme **cibles de récupération**, sans garantie de durabilité ou de restauration complète implicite.

Avant de choisir une politique, séparer au minimum :
- erreur applicative et échec coopératif ;
- crash-stop et crash-restart ;
- perte d'alimentation et crash du domaine complet ;
- corruption d'état, rollback et restauration d'un snapshot ancien ;
- partition ou perte du transport ;
- panne de périphérique et état DMA restant ;
- crash avant/après journalisation, commit ou effet externe.

Il faut spécifier l'état volatile/durable, l'ordre et le préfixe durable du journal, les checkpoints, les points de commit, les identifiants de requête, les doublons, les retries, l'idempotence ou compensation des effets externes, le sort des capacités linéaires et l'origine des ressources lors de la reprise. Rejouer un journal logique ne prouve ni la durabilité du support ni l'exécution exactement une fois d'un effet externe. Restaurer un snapshot ne doit pas réactiver une référence, une génération ou une capacité qui devrait être périmée.

## 7. Grades, budget et temps réel

Conserver les trois étages distincts relevés par R6 :

1. **Coût abstrait K7PL** : notamment travail et profondeur. Le choix documentaire `Cost_Budget = max(W,D)` demeure une métrique logique, pas une mesure murale.
2. **Quota ou admission runtime/noyau** : politique qui réserve, comptabilise et limite le CPU, la mémoire, les messages ou les ressources partagées.
3. **WCET et faisabilité temporelle** : analyse dépendante d'une cible, d'un compilateur, de la mémoire/cache, des interruptions, du DMA, des charges concurrentes, de l'ordonnanceur et de l'horloge.

Aucun de ces étages ne se déduit automatiquement du précédent. Les budgets non dépensés, les tentatives échouées, les interruptions, l'attente environnementale et les reprises doivent avoir une règle de comptabilisation précise avant qu'une échéance soit présentée comme garantie.

Les exigences normatives existantes de représentation (dont alignement et placement NUMA) restent distinctes d'une garantie WCET. Il faudra mesurer et prouver séparément les propriétés pertinentes au profil cible.

## 8. Démarrage, chaîne d'approvisionnement et base de confiance

R0 conserve le firmware et la chaîne de démarrage comme frontière à expliciter. Le dossier initial peut exclure ces composants de la garantie démontrée, mais doit alors poser une précondition vérifiable sur l'état initial et sur les composants de confiance. Les exclusions ne doivent pas devenir des hypothèses tacites.

Les pistes déjà étudiées comprennent authentification d'image/configuration, anti-rollback, mesure et attestation de l'état, gestion des clés, mise à jour/récupération, versions d'outils et dépendances épinglées, provenance de build, intégrité des caches/artefacts et reconstruction reproductible. Chaque piste est une cible d'évaluation ; aucune chaîne de démarrage ou solution de signature n'est sélectionnée ici.

## 9. Confidentialité, observables et canaux auxiliaires

R3 exige de définir ce qu'un observateur peut distinguer, en tenant compte selon le profil des valeurs, erreurs, contrôle, présence et ordre de messages, durée, consommation de ressources, logs et états persistants. Confidentialité et intégrité sont différentes ; elles ne découlent pas de la pureté de la couche 3 ou d'une sûreté mémoire locale.

Les canaux temporels et auxiliaires ont été séparés du premier périmètre normatif. Cela ne signifie pas qu'ils sont supprimés des objectifs de K7OS : ils restent des dimensions d'étude distinctes. Il faut identifier l'observateur, sa résolution, la co-résidence, les ressources partagées, les déclassifications acceptées et les objectifs quantitatifs éventuels. Les mécanismes de temps constant, partitionnement de ressources ou ordonnancement contrôlé sont à évaluer selon le profil, sans revendiquer une absence générale de canaux cachés.

## 10. Chaîne source vers binaire et méthode d'assurance

La cible de compilation reste une chaîne à relier explicitement : source K7PL, élaboration, IR interne, MLIR, LLVM IR, assembleur/code machine, édition de liens, runtime et configuration de déploiement. La relation à établir doit couvrir, selon la propriété revendiquée, résultat fonctionnel, mémoire, autorité, traces d'effets, messages, erreurs, coûts et observations temporelles. Une étape non prouvée doit être nommée dans le TCB ou compensée par une validation de traduction/tests différentiels dont la portée est explicitée.

Le dossier R9 fournit un modèle TLA+/TLC borné de course d'annulation et un vecteur de test. Il est utile pour falsifier une revendication trop forte et dériver des tests. Il ne démontre pas l'équivalence entre le modèle borné et la sémantique K7PL complète. Toute nouvelle exploration devra conserver modèle, bornes, paramètres, versions, trace témoin, oracle de test et relation de projection vers la sémantique source.

La traçabilité visée est bidirectionnelle entre exigences, définition sémantique, hypothèses, théorèmes, modèle borné, tests, configuration d'outil et artefact. Il faut distinguer preuve Lean vérifiée, exploration bornée, test, mesure, hypothèse, objectif et résultat ouvert.

## 11. Carte de traçabilité vers R0–R9 et SPEC-D-01…25

| Domaine K7OS conservé | Sources de recherche | Deltas à instruire dans le registre |
|---|---|---|
| Profils de menace, isolation, TCB, frontières et démarrage | R0, R1, R8 | D-01–D-03, D-05, D-16, D-20, D-23–D-24 |
| Unsafe, contrats FFI, capacités et autorité réelle | R1, R5 | D-04–D-08, D-20 |
| Confidentialité, intégrité, observables et canaux auxiliaires | R0, R3, R8 | D-03, D-09–D-10, D-18–D-20 |
| Attentes dynamiques, sessions, progrès et équité | R4, R9 | D-11–D-12, D-18, D-25 |
| Annulation, timeout, erreurs, commit et récupération | R4, R7, R9 | D-13, D-16–D-17, D-25 |
| Mémoire, régions, emprunt, alias, références et DMA | R1, R5, R8 | D-05–D-08, D-18–D-19, D-23 |
| Grades, budget, coûts, quota, WCET et performance | R2, R6, R8 | D-14–D-15, D-19, D-22–D-24 |
| Pannes, journal, snapshot, reprise et effets externes | R4, R7, R9 | D-06, D-13, D-16–D-17, D-21, D-25 |
| Source, IR, compilation, TCB et traçabilité | R2, R6, R9 | D-18–D-22, D-25 |
| Comparaison architecturale et critères de falsification | R0, R8, R9 | D-23–D-25 |

La carte organise le travail ; elle ne crée aucune obligation normative supplémentaire et ne ferme aucune preuve.

## 12. Décisions à reporter et déclencheurs d'un QCM

Aucun QCM d'architecture n'est requis pour préserver et documenter ces options. Un QCM devient nécessaire avant une décision qui réduit réellement l'espace des possibles, notamment :

1. **Profil d'isolation de référence :** espace partagé et TCB élargi ; processus/domaines de protection ; compartiments matériels ; variante hybride.
2. **Cible matérielle :** ISA, disponibilité de MMU/MPU/PMP/IOMMU et éventuellement capacités CHERI, modèle multicœur et périphériques visés.
3. **Contrat de démarrage :** composants inclus dans le TCB initial et garanties exigées de la chaîne firmware/boot/update.
4. **Persistance :** garanties nominales de reprise, modèle de crash, durabilité et politique pour les effets externes.
5. **Temps réel :** profil d'exécution auquel la garantie est promise et relation exigée entre grade, quota, WCET et échéance.
6. **Réseau et sécurité des protocoles :** contrats à assurer avant de choisir ou d'exiger un mécanisme tel que Noise ou Biscuit.

Ces décisions doivent être prises à partir d'une matrice qui compare garanties attendues, coût mesuré, complexité du TCB, hypothèses et preuve disponible. La présence d'un mécanisme dans ce dossier indique qu'il a été étudié, pas qu'il est retenu.

## 13. Sources internes

- [R0 — Threat Model and Assurance Matrix](R0-threat-model-assurance-matrix.md)
- [R1 — Authority, Capabilities, Revocation, and FFI Boundaries](R1-authority-capabilities-ffi-boundaries.md)
- [R2 — Source-to-Binary Correctness](R2-source-to-binary-correctness.md)
- [R3 — Confidentialité, intégrité et non-interférence](R3-confidentialite-integrite-non-interference.md)
- [R4 — Concurrence, protocoles, vivacité et annulation](R4-concurrence-protocoles-vivacite-annulation.md)
- [R5 — Permissions mémoire, emprunt, aliasing et logique de séparation](R5-memoire-emprunt-aliasing-logique-separation.md)
- [R6 — Grades, budgets, WCET et temps réel](R6-grades-budgets-WCET-temps-reel.md)
- [R7 — Pannes, ressources linéaires et persistance](R7-pannes-ressources-lineaires-persistance.md)
- [R8 — Comparaison d'OS et d'architectures voisines](R8-comparaison-systemes-exploitation.md)
- [R9 — Model checking, contre-exemples et traçabilité](R9-model-checking-contre-exemples-tracabilite.md)
- [Registre provisoire des évolutions de la spécification K7PL](SPEC-DELTA-REGISTER.md)

## 14. Historique des décisions de cadrage

- 2026-10-24 — Les choix concrets de réalisation sont conservés ici plutôt que de figurer comme prescriptions universelles du langage ; leur retrait de la spécification ne vaut pas abandon comme cibles d'étude.
- 2026-10-24 — Aucune architecture, ISA, frontière de privilège, solution DMA, chaîne de démarrage ou mécanisme de persistance n'est ratifié par ce dossier.
