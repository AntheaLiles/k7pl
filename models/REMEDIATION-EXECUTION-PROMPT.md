# Prompt — poursuivre la remédiation TLA+ K7PL P0–P4

Tu interviens sur le dépôt AntheaLiles/k7pl, dans le cadre de la PR #319 et de la branche fix/tla-ci-unified-suite-2026-10-31.

## Mission

Poursuivre les travaux définis dans :
- models/REMEDIATION-ROADMAP-P0-P4.md (priorités et critères de sortie) ;
- models/CHECKPOINT.md (état vérifié et prochaine action) ;
- models/CHAPTER-COVERAGE.md (matrice de couverture vivante) ;
- models/OPEN-GATES.md (décisions sémantiques encore ouvertes) ;
- models/WORK-PLAN.md (périmètre et critères d'acceptation des modèles) ;
- models/FORMAL-ARCHITECTURE.md (frontière K/TLA+/Lean) ;
- wiki/assurance.md (registre central des théorèmes et gaps).

Le but n'est pas de faire passer artificiellement la CI au vert. Il est d'obtenir des modèles exécutables, des propriétés non vacues, une couverture traçable et des revendications proportionnées à l'évidence.

## Contraintes impératives du dépôt

- Travaille exclusivement sur une branche de PR, jamais directement sur main.
- Commence par vérifier le head exact, la base, les commits, les PR qui touchent les mêmes fichiers et les runs CI associés. N'utilise pas un ancien rapport comme substitut à l'état du dépôt.
- Ne force-push pas, ne contourne aucune protection et ne fusionne aucune PR.
- Respecte Conventional Commits/CommitLint, Deno 2.9.x et les contrôles REUSE/SPDX du dépôt.
- Ne réduis pas les propriétés, ne retire pas d'invariant, n'ajoute pas de CONSTRAINT uniquement pour faire terminer TLC, n'augmente pas les timeouts pour masquer un espace infini, n'ajoute pas continue-on-error, || true ou autre masquage.
- Ne transforme jamais une recommandation en clause normative. Toute décision de langage doit être tracée vers Verso et explicitement ratifiée par le processus normal du projet.
- Utilise les documents générés comme sorties de pipeline quand le dépôt les définit ainsi ; ne les édite pas manuellement hors de leur source prévue.

## Phase 1 — P0 : établir la validation réelle

1. Récupère le dernier head de PR #319 et les runs de ce SHA exact. Les résultats connus sur un head antérieur ne remplacent jamais une validation du head courant. Si un run est en attente, annulé ou absent, ne le déclare pas validé.
2. Le dernier run TLC complet observé est 41306284770 sur head 29845511f018b80da543b975a995b477d4ba9cb4 : 15/18 positifs et 17/21 négatifs ont atteint leur résultat attendu. Sept profils restent bloquants : TLA-02 positif/négatif (TypeOK compare le sentinel string NoPairValue avec un tuple), TLA-07 positif et trois négatifs (erreur de parsing dans WriteCell ligne 126), TLA-12 positif (AdvanceFrame ne spécifie pas complètement frameOverrun). Le run 41307048438 sur le head suivant a été annulé. Au snapshot courant, le head 6a2180cbb1b3fb0e6ce5cee84455e2bb0789cb02 a un run CI 41307410463 en attente ; vérifier le run associé au SHA final de la PR avant tout verdict.
3. Inspecte le run D01/R9/TLA-01..16 et son artefact. Vérifie les 39 profils un par un :
   - 18 positifs : TLC doit terminer et afficher son diagnostic de model checking sans erreur ;
   - 21 négatifs : TLC doit terminer sur le diagnostic exact de violation de l'invariant déclaré dans TLC-PROFILES.json ;
   - parsing, semantic analysis, ASSUME faux, TypeOK, timeout, mauvaise violation ou arrêt incomplet = échec.
4. Vérifie le nombre d'états, le nombre d'états distincts, la profondeur et l'épuisement de la file pour chaque profil. Distingue un modèle exploré d'un modèle qui n'a pratiquement qu'un état initial.
5. Vérifie que les traces négatives suivent les actions attendues et correspondent aux JSON d'attente. Le JSON reste un oracle rédigé tant qu'il n'est pas comparé à une trace TLC observée.
6. Passe également en revue les contrôles négatifs D01/R9 : leur prédicat shell doit prouver la violation attendue et ne pas accepter un simple échec de parser ou une mention non probante de l'invariant.
7. Vérifie l'artefact complet, le digest TLC, les logs et les sommes de contrôle. Vérifie que l'artefact D01 séparé reste consommé par k-smoke.
8. Exécute les contrôles locaux et CI pertinents : Deno fmt/check/lint/test, validation du registre, contrôles Python en shadow, REUSE, CommitLint, actionlint, tests Lean/K/Verso concernés.
9. Corrige tous les défauts P0 par des changements sémantiquement justifiés. Ne marque aucun profil validé avant observation du run exact.

## Phase 2 — P1 : contrôler la non-vacuité et la sensibilité des propriétés

Traite chaque point du §4 de models/REMEDIATION-ROADMAP-P0-P4.md :
- TLA-03 : rendre une terminaison valide atteignable dans le profil positif sans autoriser l'exécution après terminaison.
- TLA-07 : ne pas prétendre vérifier la préservation des droits à partir de cellules disjointes et constantes ; définir d'abord l'ownership et les opérations pertinentes.
- TLA-12 : obtenir une décision explicite sur le sort d'un patch préparé après révocation ; modéliser la révocation entre HandleEvent et ApplyPatch.
- TLA-01 : distinguer cycle d'attente, deadlock, timeout activable, timeout effectivement pris, livraison externe et progrès.
- TLA-05 : séparer les propriétés substantielles des conséquences définitionnelles.
- TLA-09 : ne pas compter une conséquence arithmétique des limites comme une validation indépendante de la loi générale.
- TLA-11 : ne pas présenter un seul pas comme une exploration générale de traces.
- TLA-16 : maintenir la distinction entre protocole abstrait atomique et implémentation à mémoire faible.

Pour chaque propriété, produis une table : invariant, transition qui la met réellement à l'épreuve, hypothèses du positif, contrôle négatif, résultat TLC, vacuité/limite, revendication autorisée. Si un contrôle négatif n'est pas sémantiquement valable, explique pourquoi au lieu de l'ajuster pour obtenir un échec arbitraire.

Ne supprime aucun invariant pour améliorer les statistiques. Si une propriété est définitionnelle, conserve-la éventuellement comme vérification de cohérence mais ne la compte pas comme couverture protocolaire indépendante.

## Phase 3 — P2 : spécification et décisions ouvertes

- Revalide chaque clause sur le main courant ; PR #311 non fusionnée et ses noms anglais ne sont pas une source normative actuelle.
- Pour tout modèle, trace clause Verso stable, module, invariant/propriété, transition, hypothèses, bornes, omissions et statut d'évidence.
- Ferme d'abord les décisions pertinentes de OPEN-GATES.md : capacité/région, révocation, partage de canal, contrat FFI/Import, fairness et relation K/TLA+/Lean.
- Garde H1–H3 comme obligations de typage/métathéorie/Lean ; ne les déclare pas couverts par TLA-07.
- Définis une relation KState/TLAState et le mapping des transitions avant toute revendication de simulation. Distingue safety et liveness ; le transfert de liveness nécessite des conditions de fairness et de non-divergence.
- N'ajoute aucun TLA-17 sans clause normative actuelle, question falsifiable, état/transitions, hypothèses, bornes et plan d'évidence.

## Phase 4 — P3 : raffinements concrets

N'ouvre les travaux MMU, IOMMU, DMA, cycle de vie des pages physiques, remanence, weak memory, ABI/FFI, supervision ou persistance que si le contrat cible est défini.

- MMU et IOMMU sont deux systèmes distincts ; les relier par l'ownership des pages physiques et l'achèvement des invalidations.
- Définis le protocole de réclamation des pages avant d'affiner les caches de traduction.
- Pour le weak memory, identifie langage runtime, compilateur, primitives atomiques et ISA avant de choisir un checker tel que GenMC.
- Une preuve TLC sous hypothèses matérielles n'est pas une preuve du matériel réel.
- Relie tout modèle concret à l'abstraction logique par une relation explicite et testable.

## Phase 5 — P4 : intégrations conditionnelles

N'active Noise, CRDT/réplication, backpressure, compilation concurrente, capacités OS, probabilités ou outils symboliques/déductifs que si le périmètre correspondant est réellement sélectionné.

- TLA+ ne prouve pas la sécurité cryptographique des primitives.
- Un G-set à deux répliques connectées ne constitue pas un modèle de transport distribué général.
- PRISM exige une propriété probabiliste définie.
- Apalache doit annoncer ses bornes et son solveur.
- TLAPS n'est utilisé que pour une obligation déductive qui le justifie ; Lean reste l'outil principal des théorèmes généraux.

## Documentation et checkpoint

Après chaque lot validé :
1. Mets à jour CHAPTER-COVERAGE.md pour la couverture, les hypothèses et les gaps.
2. Mets à jour OPEN-GATES.md uniquement lorsqu'une question ou une décision évolue ; ne ferme pas une gate sans décision justifiée.
3. Mets à jour WORK-PLAN.md pour l'état des modèles et critères d'acceptation.
4. Mets à jour MODEL-DEPENDENCIES.md pour les contrats d'interface, sans prétendre à une composition implicite.
5. Mets à jour TOOLCHAIN-CI.md si l'outillage ou les preuves CI changent.
6. Mets à jour REMEDIATION-ROADMAP-P0-P4.md pour le statut exact des actions et leurs preuves.
7. Mets à jour CHECKPOINT.md avec le SHA, les fichiers modifiés, commandes, résultats, erreurs et prochaine action.
8. Mets à jour README.md si l'index ou les statuts publics changent.
9. Maintiens les documents uniquement à leur domicile de vérité ; wiki/assurance.md reste le registre central des gaps/théorèmes.

Le registre .github/ci/components.yaml et ses tests doivent classer les documents de programme comme documentation-only. Une modification d'un document ne doit pas relancer les 39 profils sans motif explicite ; les TLA modules, configurations et vecteurs exécutables doivent, eux, déclencher le contrôle requis.

## Livrable attendu

À la fin, fournis :
- commits et SHA de la branche ;
- liste des fichiers modifiés et raison ;
- matrice P0–P4 (fait, en cours, bloqué, différé) avec preuve ;
- résultats exacts de chaque profil TLC et lien vers les artefacts ;
- résultats Deno/Python/REUSE/CommitLint/Lean/K/Verso ;
- décisions sémantiques requises de l'auteur, clairement séparées des corrections mécaniques ;
- gaps restants, limites de généralisation et prochaine action.

Ne fusionne pas la PR. Ne dis pas « tout est vert » sans preuve CI sur le SHA courant.