<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R9 — Model checking, contre-exemples et traçabilité

**Date de l’étude :** 2026-10-24  
**Instantané audité :** `AntheaLiles/k7pl@f2f3df2a8598a16fdb7899b42c641e3c57665a09`  
**Statut :** dossier de recherche non normatif. Le modèle borné proposé est un prototype d’exploration ; son équivalence avec la sémantique K7PL n’est pas établie. Les propriétés générales de session, d’annulation, de coût et de compilation restent à démontrer.

## 1. Résultat

Le workflow recommandé combine quatre outils avec des rôles séparés : TLA+/TLC pour explorer les états atteignables d’un protocole concurrent fini ; Apalache pour des recherches symboliques à longueur bornée ; tests à état pour confronter une implémentation à un modèle de référence ; Lean pour prouver les propriétés retenues une fois les relations sémantiques définies. Ces résultats ne sont pas interchangeables.

Le prototype livré dans [models/R9ActorCancellation.tla](models/R9ActorCancellation.tla) représente un acteur A, un service B, une requête, une demande d’annulation et un effet externe validé au plus une fois. Il rend visible une distinction critique : **demander l’annulation n’équivaut pas à recevoir l’accusé d’annulation**. Si la requête a été acceptée, le commit et l’interruption peuvent être deux transitions concurrentes. Le modèle autorise soit l’interruption avant commit, soit le commit avant accusé. Il impose qu’un accusé d’annulation ne soit pas émis après validation de l’effet.

Les fichiers du modèle comprennent une [configuration nominale](models/R9ActorCancellation.cfg), une [configuration négative](models/R9-NaiveCancelClaim.cfg) et un [vecteur de test](models/R9-CancelRace-Test-Vector.md). Le job [R9 TLA+ model check du workflow CI](../../.github/workflows/ci.yaml) exécute les deux configurations avec un JAR TLC identifié et vérifié par SHA-256 et SHA-1. Les runs [CI #1998](https://github.com/AntheaLiles/k7pl/actions/runs/40083251090) et [CI #2001](https://github.com/AntheaLiles/k7pl/actions/runs/40083746248) ont confirmé le résultat nominal et le contre-exemple attendu. La portée reste celle du modèle borné décrit ci-dessous : ces résultats n’établissent pas sa correspondance avec la sémantique normative complète de K7PL.

## 2. Constats K7PL au snapshot audité

| Source | Constat utile | Obligation qui reste ouverte |
|---|---|---|
| [C3 — règles de typage](https://github.com/AntheaLiles/k7pl/blob/f2f3df2a8598a16fdb7899b42c641e3c57665a09/spec/Spec/C3/ReglesDeTypage.lean) | Les jugements et contraintes de typage sont des objets à relier aux propriétés observées. | La correspondance avec la sémantique opérationnelle ne découle pas des noms de déclarations. |
| [C4 — sémantique opérationnelle](https://github.com/AntheaLiles/k7pl/blob/f2f3df2a8598a16fdb7899b42c641e3c57665a09/spec/Spec/C4/SemantiqueOperationnelle.lean) | Les transitions manipulent calcul, état d’arène et trace d’effets ; la concurrence exige un ordre partiel sur les chaînes pertinentes. P3-B sépare la latence d’attente environnementale du coût du déclenchement. | La représentation exacte de l’observation d’attente reste une obligation d’interface. Le modèle de R9 ne la ratifie pas. |
| [C-07 — audit de simulation](https://github.com/AntheaLiles/k7pl/blob/f2f3df2a8598a16fdb7899b42c641e3c57665a09/docs/migration/C-07-SIMULATION-AUDIT.md) | L’audit signale un contrat de simulation avant qui n’est pas défini sur toutes les configurations et traces et n’est pas démontré règle par règle. | Une trace TLC ne ferme pas C-07 et ne prouve pas la préservation de la sémantique source. |
| [R0 — menace et assurance](R0-threat-model-assurance-matrix.md) | Chaque propriété doit déclarer adversaire, observations, hypothèses, mécanisme et cas de falsification. | Le modèle borné ne fixe pas l’architecture ni le périmètre de confiance. |
| [R4 — concurrence et annulation](R4-concurrency-protocols-liveness-cancellation.md) | Le dossier distingue sûreté, absence de blocage, terminaison et progrès sous hypothèses d’équité. | Les invariants de sûreté ne prouvent pas la vivacité. |
| [R6 — budgets et WCET](R6-grades-budgets-WCET-real-time.md) | Le budget abstrait doit être relié aux règles opérationnelles, à l’ordonnanceur et à la cible. | Le crédit fini du prototype n’est ni du temps mural, ni un coût machine, ni un WCET. |
| [R7 — pannes et persistance](R7-failures-linear-resources-persistence.md) | État volatil, journal, checkpoint, effets externes, ressources et incarnation sont des dimensions distinctes. | Le modèle d’annulation ne couvre pas crash, stockage durable ou reprise complète. |
| [ASSURANCE.md](../../wiki/assurance.md) | Les preuves, tests, analyses et justificatifs de reproductibilité sont des catégories de résultats distinctes ; la traçabilité globale demeure partielle. | Une réussite de CI ou de test ne démontre pas à elle seule une correspondance. |

Le modèle est limité à un protocole local. Il ne formalise pas la totalité des acteurs, capacités, sessions, effets, règles d’échec, FFI ou du modèle temporel K7PL.

## 3. Trois workflows

### 3.1 TLA+ / TLC puis TLAPS au besoin

TLA+ décrit les états, transitions et propriétés temporelles d’un système concurrent ou distribué. TLC explore explicitement le graphe des états atteignables pour les constantes et domaines finis configurés. Il peut restituer une séquence qui mène à un état ne satisfaisant pas un invariant ou à un blocage. TLAPS sert à faire vérifier des preuves TLA+ lorsque l’objectif dépasse l’exploration d’une instance finie.

**Forces :** actions d’interleaving explicites, traces lisibles, vérification d’invariants et détection de blocage ; bon ajustement au protocole d’acteurs et canaux.

**Limites :** l’exhaustivité ne concerne que le modèle, les hypothèses et les domaines fournis. Une transition absente ou une abstraction erronée échappe à l’exploration. Une preuve TLAPS dépend aussi de ses énoncés et prémisses.

**Rôle proposé :** premier filtre pour les protocoles, l’annulation, les messages dupliqués, les commits et les budgets entiers bornés.

### 3.2 TLA+ / Apalache

Apalache encode des exécutions TLA+ bornées comme des contraintes résolues par un solveur SMT. Il convient en complément lorsque les contraintes arithmétiques ou les domaines symboliques deviennent plus importants.

**Forces :** contraintes SMT explicites ; exploration symbolique jusqu’à une longueur donnée ; contrôle d’invariants inductifs dans les modes pris en charge.

**Limites :** « aucun contre-exemple trouvé jusqu’à k pas » ne démontre rien pour les traces plus longues. La documentation officielle qualifie le projet d’expérimental et définit un sous-ensemble de constructions prises en charge.

**Rôle proposé :** deuxième voie sur les mêmes cas, en enregistrant solveur, version, longueur et paramètres. Ne pas remplacer les traces TLC lisibles quand l’espace d’états est petit.

### 3.3 Lean et tests à état

Lean peut représenter une relation de transition finie et prouver des propriétés sur celle-ci dans le kernel. Il faut toutefois écrire le modèle et les preuves ; une trace TLC ne se transforme pas automatiquement en théorème. Les tests à état, par exemple avec Hypothesis, génèrent des séquences d’actions et comparent une implémentation à un modèle de référence. Ils peuvent réduire un cas reproductible, sans parcourir nécessairement tous les comportements.

**Forces :** Lean rattache les propriétés formelles au socle de confiance K7PL ; les tests à état confrontent une API réelle à l’oracle et donnent des régressions concrètes.

**Limites :** un modèle Lean doit lui aussi être relié à un engagement normatif. Des tests générés ne sont pas une exploration exhaustive ni une preuve générale.

**Rôle proposé :** conserver un format de trace stable, créer des tests d’oracle à partir de traces, les jouer sur le modèle puis sur le runtime disponible et relier les propriétés générales à des théorèmes Lean, sans confondre ces couches.

| Étape | Outil ou artefact | Résultat | Statut |
|---|---|---|---|
| Exploration explicite | TLA+ / TLC | États atteignables, invariants, traces et blocages | Modèle préparé ; exécution TLC à faire |
| Contrôle symbolique | Apalache | Recherche bornée par longueur et solveur | Comparaison prévue, non exécutée |
| Trace conservée | Vecteur R9 et export JSON futur | ID stable, états, actions, oracle et empreinte | Vecteur manuel disponible ; export TLC absent |
| Régression | Test à état ou test du runtime | Comportement concret contre oracle | Scénarios spécifiés, API cible non disponible dans ce travail |
| Preuve générale | Lean ou preuve TLA+ | Propriété rattachée aux sources et hypothèses | Obligations ouvertes |

## 4. Modèle et invariants

Le modèle est défini dans [R9ActorCancellation.tla](models/R9ActorCancellation.tla). L’acteur A et le service B disposent chacun d’un crédit initial de deux unités. Il n’y a qu’une requête ; les domaines sont bornés pour rendre l’exploration finie.

| Variable | Domaine | Rôle |
|---|---|---|
| aState | Ready, Waiting, CancelRequested, Cancelled, Completed | Phase de l’acteur |
| bState | Idle, Handling, IdleAfterCancel, Done | Phase du service |
| requestState | None, Pending, Accepted, Cancelled, Committed | État de requête |
| cancelRequested | Booléen | Demande émise |
| cancelAck | Booléen | Accusé confirmant que le commit n’a pas eu lieu |
| effectCount | 0 ou 1 | Nombre d’effets validés |
| budget | Fonction sur A et B, valeurs 0 à 2 | Crédit abstrait restant |
| trace | Séquence finie d’événements | Observations de ce modèle |

Chaque transition coûte une unité : Send, Accept, RequestCancellation, CancelPending, InterruptAccepted ou Commit. Une action requérant du crédit est désactivée si le crédit est nul. Ce compteur abstrait ne représente pas des cycles CPU ni un délai environnemental.

Actions :
- **Send** fait passer la requête de None à Pending.
- **Accept** la fait passer à Accepted et le service commence son traitement.
- **RequestCancellation** émet une demande, sans confirmer que le service l’a acceptée.
- **CancelPending** annule une requête qui n’a pas été acceptée.
- **InterruptAccepted** arrête un travail accepté avant le commit.
- **Commit** valide l’effet et termine le service si le commit gagne la course.

Invariants :
1. **TypeOK** : domaines des variables respectés.
2. **BudgetInRange** : crédits dans l’intervalle fini, sans débit d’un crédit nul.
3. **CancelAckSound** : un accusé implique requestState = Cancelled, aState = Cancelled et effectCount = 0.
4. **CommitStateConsistent** : effectCount = 1 implique requestState = Committed, aState = Completed et bState = Done.
5. **EffectAtMostOnce** : effectCount reste dans {0, 1}.

Ces invariants portent uniquement sur la sûreté de ce modèle. Il n’y a ni hypothèse d’équité, ni preuve de progrès universel, ni analyse WCET. La sémantique de l’annulation utilisée ici est une hypothèse de recherche, pas un ajout à la spécification normative.

## 5. Contre-exemple attendu et conversion en tests

Le témoin suivant a été produit par TLC avec la configuration négative. La même séquence apparaît dans les runs [CI #1998](https://github.com/AntheaLiles/k7pl/actions/runs/40083251090) et [CI #2001](https://github.com/AntheaLiles/k7pl/actions/runs/40083746248) ; le tableau ci-dessous en normalise les états et le crédit restant.

La propriété candidate **NoCommitAfterCancelRequest** dit : dès que cancelRequested vaut vrai, aucun effet ne peut être validé. C’est plus fort que « l’accusé d’annulation confirme qu’aucun effet n’a été validé ».

| État | Action | aState | bState | requestState | cancelRequested | cancelAck | effectCount | Budget (A, B) |
|---|---|---|---|---|---:|---:|---:|---|
| S0 | Init | Ready | Idle | None | faux | faux | 0 | (2, 2) |
| S1 | Send | Waiting | Idle | Pending | faux | faux | 0 | (1, 2) |
| S2 | Accept | Waiting | Handling | Accepted | faux | faux | 0 | (1, 1) |
| S3 | RequestCancellation | CancelRequested | Handling | Accepted | vrai | faux | 0 | (0, 1) |
| S4 | Commit | Completed | Done | Committed | vrai | faux | 1 | (0, 0) |

La séquence Send → Accept → CancelRequest → EffectCommit réfute l’hypothèse trop forte. Les invariants nominaux restent cohérents : aucun accusé n’a été émis, un seul effet est validé et les crédits ne deviennent pas négatifs.

### Résultats observés dans la CI

- **Configuration nominale :** TLC termine sans erreur ; 9 états générés, 9 états distincts, file d’attente vide et profondeur maximale de recherche 5. Les invariants déclarés dans le fichier de configuration nominale sont satisfaits sur l’ensemble fini accessible.
- **Configuration négative :** TLC indique que l’invariant NoCommitAfterCancelRequest n’est pas satisfait et produit la séquence Send → Accept → CancelRequest → EffectCommit. La recherche s’interrompt au premier contre-exemple : 9 états générés, 9 distincts, 3 encore en file et profondeur de recherche complète annoncée égale à 5. Ce résultat est attendu et est traité comme une réussite du test négatif par le job CI.
- **Environnement :** la sortie TLC indique « TLC2 Version 2.19 of 08 August 2024 ». Le workflow télécharge le JAR depuis la release v1.7.4 de TLA+ Tools et vérifie son SHA-256 (936a262061c914694dfd669a543be24573c45d5aa0ff20a8b96b23d01e050e88) et son SHA-1 (bee4a54f3ee3d4afc347c3240ec2d9e93b075104).

Ce contrôle valide le modèle TLA+ et les invariants qu’il contient pour cette instance finie. Il ne prouve ni que le modèle couvre tous les comportements normatifs de K7PL, ni que son abstraction d’annulation correspond au contrat réel du runtime.

Le fichier [R9-CancelRace-Test-Vector.md](models/R9-CancelRace-Test-Vector.md) conserve le témoin et son oracle. La configuration [R9-NaiveCancelClaim.cfg](models/R9-NaiveCancelClaim.cfg) demande au model checker de chercher le contre-exemple attendu ; [R9ActorCancellation.cfg](models/R9ActorCancellation.cfg) ne vérifie que les invariants nominaux.

| ID de test | Séquence | Oracle |
|---|---|---|
| R9-TEST-CANCEL-ACK-01 | Send → RequestCancellation → CancelPending | Accusé émis ; aucun effet validé. |
| R9-TEST-CANCEL-ACK-02 | Send → Accept → RequestCancellation → InterruptAccepted | Accusé après interruption ; aucun effet validé. |
| R9-TEST-CANCEL-RACE-03 | Send → Accept → RequestCancellation → Commit | Résultat Completed, aucun accusé ; effet validé une fois. |
| R9-TEST-BUDGET-04 | Action tentée avec crédit nul | Transition désactivée ou épuisement déclaré selon contrat ; aucune valeur négative. |
| R9-TEST-TRACE-05 | Rejouer le témoin depuis S0 | Oracle et trace restent attachés au même identifiant de cas. |

Ces lignes spécifient des tests futurs ; elles ne décrivent pas une API K7PL déjà exécutée. L’intégration devra appeler le runtime réel, collecter les événements, comparer le résultat à l’oracle et conserver la configuration exacte.

### Commandes reproductibles

Avec un JAR TLC identifié et vérifié, depuis le dossier du modèle :

~~~sh
java -cp tla2tools.jar tlc2.TLC -config R9ActorCancellation.cfg R9ActorCancellation
java -cp tla2tools.jar tlc2.TLC -config R9-NaiveCancelClaim.cfg R9ActorCancellation
~~~

Le premier lancement doit vérifier les invariants nominaux ; le second doit trouver un contre-exemple à NoCommitAfterCancelRequest. Pour retenir l’export réel, enregistrer la version et l’empreinte du JAR, les paramètres, les constantes, le nombre d’états, le code retour et le fichier JSON de trace produit par TLC.

Exemple de commande symbolique de départ :

~~~sh
apalache-mc check --config=R9ActorCancellation.cfg --length=8 --inv=TypeOK,CancelAckSound,CommitStateConsistent R9ActorCancellation.tla
~~~

La borne 8 n’établit aucune propriété pour une longueur illimitée. L’exécution Apalache n’est pas attestée par ce rapport.

## 6. Convention de traçabilité

La traçabilité doit être bidirectionnelle : du besoin vers ses obligations et preuves, et de chaque résultat formel ou test vers le besoin soutenu. Les identifiants R9 proposés sont des identifiants de recherche, pas des identifiants normatifs.

| Identifiant | Sens | Artefact ou oracle |
|---|---|---|
| R9-MOD-CANCEL-01 | Modèle abstrait de la course annulation/commit | R9ActorCancellation.tla, constantes et empreinte |
| R9-INV-ACK-01 | Un accusé implique l’absence d’effet validé | CancelAckSound ; R9-TEST-CANCEL-ACK-01/02 |
| R9-INV-COMMIT-01 | Un effet validé correspond à un état terminal cohérent | CommitStateConsistent ; R9-TEST-CANCEL-RACE-03 |
| R9-HYP-CANCEL-01 | Hypothèse trop forte : une demande rend tout commit impossible | NoCommitAfterCancelRequest ; témoin S0–S4 |
| R9-TEST-BUDGET-01 | Un débit ne rend pas le crédit négatif | BudgetInRange ; R9-TEST-BUDGET-04 |
| R9-OBL-C07-TRACE-01 | Définir la projection des événements source, cible et trace observable | Audit C-07 ; état OPEN au snapshot audité |
| R9-OBL-C4-WAIT-01 | Relier l’observation d’attente à une représentation exacte | Décision P3-B et obligation C-04/C-07 |
| R9-OBL-LEAN-01 | Relier chaque propriété stabilisée à une définition et un théorème Lean | Assurance C3/C5/C6 ; traçabilité globale partielle |

Chaque exécution doit enregistrer :
- l’identifiant du modèle et du contrôle ;
- le SHA du dépôt, l’empreinte du modèle et celles des configurations ;
- les versions et empreintes des outils, les paramètres, constantes, solveur et borne ;
- l’état final, le compte d’états, la trace éventuelle et le code retour ;
- les identifiants des tests dérivés et leur oracle ;
- les liens vers les règles normatives, définitions Lean, théorèmes, tests et décisions ;
- la catégorie du résultat : exploration d’un modèle fini, recherche bornée, test, preuve Lean ou revue ;
- les hypothèses et restrictions de portée.

Il faut proscrire trois assimilations : un identifiant lexical ne constitue pas une correspondance sémantique ; un test passé ne couvre pas tous les comportements ; un invariant d’un modèle borné ne démontre pas la propriété du système complet.

## 7. Limites et critères de sortie

Limites :
- annulation et point de commit sont des hypothèses à confronter à la règle normative exacte ;
- le modèle n’inclut ni multi-participants, ni duplication des messages, ni crash durable, ni révocation de capacités, ni FFI adversarial ;
- la trace reste abstraite ; sa correspondance avec les événements source et cible est ouverte ;
- TLC, Apalache, tests à état et Lean n’ont pas été exécutés ensemble sur ce prototype ; aucun résultat d’outil non observé n’est déclaré ;
- le CI vérifie désormais la syntaxe du modèle et les invariants spécifiés pour cette instance bornée. Il ne vérifie pas la correspondance sémantique avec K7PL ; la réussite du job ne doit pas être interprétée comme une preuve sur le système complet.

Critères de sortie — état après les exécutions CI :

1. **Atteint pour le modèle borné :** TLC a vérifié les invariants nominaux et reproduit le témoin attendu ; la version de l’outil, les empreintes et les runs sont référencés.
2. **À poursuivre si un modèle de référence ou un runtime devient disponible :** exécuter les oracles de test sur ce composant et relier les traces observées à la projection normative.
3. **Ouvert :** relier modèle, propriétés, témoins, tests, exigences normatives, définitions Lean et théorèmes par une correspondance sémantique, pas par la seule identité des noms.
4. **Ouvert séparément :** étudier la vivacité avec des hypothèses d’équité explicites.
5. **Ouvert :** fermer les obligations C-07 et C4 concernant les configurations, les états, les traces et la représentation de l’attente.

R9 fournit maintenant un modèle borné dont l’exploration TLC est exécutée et intégrée à la CI. La preuve de correspondance avec la sémantique normative et l’exécution K7PL demeure une obligation distincte. Aucun statut de preuve global n’est promu et aucune étape aval de K7PL n’est autorisée par ce rapport.

## 8. Références méthodologiques

- Leslie Lamport, [TLA+ — ressources de référence](https://lamport.azurewebsites.net/tla/tla.html).
- [TLA+ Tools](https://lamport.azurewebsites.net/tla/tools.html), présentation de TLC, TLAPS et Apalache.
- [TLC explicit-state model checker](https://docs.tlapl.us/using:tlc:start).
- Apalache, [manuel](https://apalache-mc.org/docs/apalache/index.html) et [exécution / BMC](https://apalache-mc.org/docs/apalache/running.html).
- Cousineau et al., [TLA+ Proofs / TLAPS](https://lamport.azurewebsites.net/pubs/tlaps.pdf).
- Hypothesis, [tests à état et génération de séquences](https://hypothesis.readthedocs.io/en/latest/stateful.html).
- NIST, [SP 800-160 Vol. 1 Rev. 1 — Systems Security Engineering](https://csrc.nist.gov/pubs/sp/800/160/v1/r1/final). Cette référence méthodologique n’atteste aucune propriété du système K7PL.
