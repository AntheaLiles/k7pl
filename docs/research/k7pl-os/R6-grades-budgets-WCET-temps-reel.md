<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R6 — Grades, budgets, WCET et temps réel (P3)

**Date d’évaluation :** 2026-10-23  
**Instantané audité :** `AntheaLiles/k7pl`, branche `main`, commit `ed03d4a86543eea0addf551747a8a81a43843127`  
**Statut :** rapport de recherche non normatif. Aucune garantie temporelle de K7PL n’est déclarée acquise.

## 1. Résultat exécutif

Les artefacts inspectés établissent des résultats arithmétiques utiles sur les profils temporels et les budgets abstraits. Ils ne suffisent pas à établir une borne du temps réel d’un programme K7PL compilé et exécuté sur une cible donnée.

Le module `src/K7pl/GradeBudget.lean` définit un profil `TemporalProfile L := L → ℕ∞ × ℕ∞`, agrège le travail par supremum des sommes sur des ensembles finis de niveaux, agrège la profondeur par supremum des profondeurs par niveau et définit le coût scalaire comme leur maximum. Il démontre notamment la monotonie de ces agrégats, la conservation arithmétique du budget sous une précondition d’admissibilité et plusieurs lois de soustraction tronquée. Le module précise toutefois que le profil n’est pas encore relié au domaine normatif K, aux règles opérationnelles, au jugement d’effets, à `Consume`, à la substitution ni à un théorème de correction des ressources.

Le module `src/K7pl/UsageScale.lean` formalise séparément la forme à quatre coordonnées du grade — usage, monotonie, niveau et budget — et l’action de mise à l’échelle sur la seule coordonnée usage. Ses propres commentaires indiquent que les lois abstraites ne prouvent pas encore que les règles de typage K7PL préservent les contrats correspondants.

Il faut donc maintenir cinq niveaux distincts :

1. **Coût abstrait prouvé** : borne calculée dans un modèle mathématique explicite.
2. **Coût opérationnel** : borne sur les étapes ou transitions d’une sémantique d’exécution identifiée.
3. **Coût machine** : borne sur les instructions du binaire, avec une correspondance prouvée entre source, code généré et modèle machine.
4. **WCET** (*worst-case execution time*) : borne supérieure temporelle sounde pour un binaire, un matériel et une configuration spécifiés.
5. **Respect d’échéance** : conclusion obtenue en composant WCET, périodes, échéances, priorités, préemption, interférences et modèle d’ordonnancement.

Une preuve au niveau 1 ne produit pas automatiquement une garantie aux niveaux 2 à 5. Une mesure ou un benchmark ne prouve pas non plus une borne supérieure pour tous les chemins d’exécution.

## 2. Périmètre et méthode

L’étude se limite aux artefacts versionnés et aux sources scientifiques citées. Elle ne modifie ni les engagements normatifs ni le modèle d’exécution. Les conclusions sont classées comme constat de source, résultat formel local, inférence conditionnelle ou obligation ouverte.

Sources du dépôt :

- [C2 — Adjonctions et enrichissement](../../../spec/Spec/C2/AdjonctionsEtEnrichissement.lean)
- [Modèle Lean des budgets](../../../src/K7pl/GradeBudget.lean)
- [Mise à l’échelle des grades](../../../src/K7pl/UsageScale.lean)
- [Dossier de concurrence R4](R4-concurrence-protocoles-vivacite-annulation.md)
- [Rapport compilation source → binaire R2](R2-source-to-binary-correctness.md)
- [Dossier d’assurance scientifique](../../ASSURANCE.md)

Les fichiers Lean sont lus comme des artefacts formels, mais ce rapport ne relance pas `lake build` et ne prétend pas certifier leur état de compilation. Les conclusions mathématiques citées ci-dessous décrivent les déclarations présentes dans le snapshot ; l’état CI d’une PR reste une preuve de l’exécution des contrôles configurés, pas une preuve d’une garantie temps réel globale.

## 3. Audit du modèle K7PL présent

### 3.1 Profil, travail et profondeur

`GradeBudget.lean` définit :

- `workAggregate κ` : supremum des sommes de travail sur tous les ensembles finis de niveaux ;
- `depthAggregate κ` : supremum de la profondeur par niveau ;
- `costBudget κ := max (workAggregate κ) (depthAggregate κ)`.

Le module prouve la monotonie de ces fonctions, leur valeur nulle pour le profil nul, la propriété de plus petite borne scalaire commune et une loi de conservation du budget sous admissibilité. Il expose aussi un porteur `K L`, puis des wrappers nommés `costBudgetK`, `admK` et `consumeK`. Ces wrappers rendent l’interface explicite, mais leurs commentaires précisent que le lien avec les règles opérationnelles n’est pas établi.

La scalarisation `max(W,D)` doit être interprétée avec soin. Elle combine une mesure de travail agrégé et une mesure de profondeur ; elle n’est pas, sans hypothèses supplémentaires, un temps mural. En particulier :

- le travail peut représenter une quantité d’opérations, sans durée machine calibrée ;
- la profondeur représente une chaîne de dépendances seulement si les règles qui la calculent capturent effectivement les dépendances ;
- le maximum travail/profondeur n’est pas une formule générale de durée sur une machine réelle ;
- la durée sous exécution parallèle dépend du nombre de cœurs, du placement, de la préemption, de la contention, des synchronisations et du comportement du runtime.

Le choix normatif `Cost_Budget = max(W,D)` doit donc rester un coût abstrait tant qu’une interprétation opérationnelle et une preuve de correspondance ne précisent pas ce qu’il borne.

### 3.2 Budget, admissibilité et consommation

Le module représente le budget par `ℕ∞` et définit une soustraction tronquée. `profileConsume` exige un témoin de `profileAdmissible`, puis le théorème de conservation montre, dans ce modèle arithmétique, que le résiduel plus le coût annoncé retrouve le budget initial.

C’est un bon contrat d’interface : la consommation n’est définie qu’avec une preuve d’admissibilité. Ce résultat ne prouve pas que chaque règle d’évaluation calcule le coût réel, qu’elle appelle cette interface, ni qu’aucune primitive ne consomme davantage que son coût annoncé. Il ne détermine pas non plus si le budget est un quota CPU, une borne d’opérations, une quantité de travail, un quota de temps sur une fenêtre ou une enveloppe d’énergie.

La distinction est importante pour les ressources concurrentes. Un quota de CPU sur une période limite le temps consommé par une tâche dans une fenêtre, mais ne garantit pas qu’une opération isolée finira avant son échéance. Un budget logique peut être épuisé avant une échéance sans dire si la tâche a été préemptée, bloquée sur un canal, suspendue par une interruption ou ralentie par la mémoire.

### 3.3 Coordonnées du grade et effets

`UsageScale.lean` fixe la forme `usage × monotonicity × level × budget`. Les théorèmes de mise à l’échelle établissent que l’action transforme usage et préserve les trois autres coordonnées. Cette séparation est structurellement utile : une transformation d’usage ne devrait pas modifier implicitement un budget temporel.

Il reste à prouver la correspondance entre cette structure générique et le grade normatif, puis à relier les grades aux effets, aux règles de typage et aux règles d’exécution. Une valeur de budget dans un grade n’est pas, par sa seule présence dans un type, une réservation effective de temps processeur ou une borne de durée.

L’analyse doit également distinguer :
- **budget déclaré** : valeur annotée dans la source ;
- **budget statiquement vérifié** : propriété démontrée pour les programmes couverts par le système formel ;
- **quota exécuté** : limite imposée par le runtime ou le noyau ;
- **coût observé** : mesure issue d’une expérience ;
- **WCET certifié** : borne sounde sur les exécutions du binaire sous un modèle matériel donné.

Ces termes ne sont pas interchangeables.

## 4. Ce qu’exige une garantie WCET

Une analyse WCET sounde combine généralement plusieurs éléments dont aucun ne peut être omis par simple convention de nommage.

### 4.1 Programme et chemins

Il faut borner les boucles, récursions, appels indirects et chemins atteignables. Les contraintes de type et les grades peuvent aider à exclure des chemins ou à fournir des bornes de multiplicité, à condition que les règles de langage et la sémantique opérationnelle le démontrent. Une preuve de terminaison seule ne fournit pas une borne numérique assez précise pour un WCET.

Les hypothèses doivent couvrir les primitives, allocations, collecteurs, appels système, FFI, pilotes et routines natives. Une opération non bornée ou dont le coût est inconnu doit être exclue de la portée de la garantie ou recevoir un contrat conservateur explicite.

### 4.2 Compilation et binaire

La borne doit se rattacher au code exécuté. Il faut soit une chaîne de compilation vérifiée qui préserve le modèle pertinent, soit une validation de traduction et une analyse sur le binaire réel. La correction fonctionnelle d’un compilateur ne suffit pas, à elle seule, à prouver la correction d’une borne de temps : les transformations doivent aussi préserver ou relier les coûts, ou la borne doit être recalculée au niveau machine.

La chaîne d’assurance doit préciser le format du binaire, l’architecture, le jeu d’instructions, les options de compilation, les bibliothèques, le runtime et la configuration exacte. Cette exigence recoupe R2 : la préservation sémantique et la neutralité de coût sont deux obligations différentes.

### 4.3 Microarchitecture et environnement

Une borne sur le temps réel exige un modèle du matériel et de son état : latences des instructions, pipelines, caches, prédiction de branche, mémoire, contention, bus, DMA, fréquence et états d’énergie. Il faut expliciter les effets des interruptions, fautes de page, défauts de cache, E/S et interférences d’autres cœurs. Si ces éléments ne sont pas bornés, le résultat n’est pas un WCET dur pour la configuration en question.

L’analyse statique doit être conservative sur les chemins réalisables et les états matériels. Les mesures sont utiles pour valider un modèle, détecter des écarts et comparer des configurations ; elles ne remplacent pas la démonstration d’une borne supérieure pour tous les cas admis.

### 4.4 Ordonnancement et échéances

Même avec un WCET par tâche, la faisabilité temporelle reste une propriété du système planifié. Elle dépend des périodes, échéances relatives, priorités, coûts de commutation, sections non préemptibles, blocages, règles de partage, migrations et interférences. Pour des tâches sporadiques ou des acteurs concurrents, il faut également préciser les hypothèses d’arrivée et la manière dont les opérations synchrones et asynchrones consomment du temps.

Il faut distinguer au moins :
- terminaison : l’exécution finit ;
- borne de nombre d’étapes : le nombre de transitions est borné ;
- borne de coût abstrait : le coût dans le modèle est borné ;
- borne WCET : la durée machine est bornée ;
- faisabilité d’ordonnancement : les échéances sont satisfaites sous le modèle donné ;
- quota temporel : la consommation CPU sur une fenêtre ne dépasse pas un budget.

R4 traite déjà la distinction entre sûreté, blocage, terminaison et progrès sous hypothèses d’équité. R6 ajoute la dimension quantitative ; il ne doit pas convertir une propriété de progrès en garantie d’échéance sans argument temporel supplémentaire.

## 5. Résultats de la littérature et valeur pour K7PL

### 5.1 Analyse WCET au niveau binaire : seL4

Les travaux de Sewell, Kam et Heiser sur seL4 décrivent une analyse WCET à haute assurance qui établit des bornes de chemins et écarte des chemins impossibles pour le binaire analysé. La documentation de recherche seL4 souligne que ces résultats sont attachés à des plateformes et configurations déterminées ; ils ne s’étendent pas automatiquement à une nouvelle architecture ou à une configuration multicœur.

Sources :
- Sewell, Kam et Heiser, *Complete, high-assurance determination of loop bounds and infeasible paths for WCET analysis*, RTAS 2016, référencé dans la [bibliographie officielle seL4](https://sel4.systems/Research/publications.html).
- [seL4 verification — WCET et compilation](https://www.trustworthy.systems/projects/OLD/seL4-verification/).
- [Caveats de configuration seL4](https://github.com/seL4/seL4/blob/master/CAVEATS.md).

**Valeur pour K7PL :** modèle d’assurance à prendre comme référence pour la séparation entre preuve fonctionnelle, analyse du binaire, configuration matérielle et bornes de temps. Ce n’est pas une preuve que le modèle de grade actuel peut être converti directement en WCET.

### 5.2 Budget CPU, période et capacité d’ordonnancement : seL4 MCS

La documentation MCS de seL4 décrit des contextes d’ordonnancement autorisés par capacités, avec budget et période, et un mécanisme d’application d’une limite de temps CPU. Elle fournit un modèle concret pour distinguer quota temporel et coût intrinsèque d’une opération.

Sources :
- [Tutoriel officiel seL4 MCS](https://docs.sel4.systems/Tutorials/mcs.html).
- Lyons, McLeod, Almatary et Heiser, *Scheduling contexts: A principled, light-weight OS mechanism for managing time*, référencé par [seL4](https://sel4.systems/Research/publications.html).

La documentation et les notes de projet indiquent que la portée des preuves varie selon configuration et plateforme ; les mécanismes MCS ne doivent pas être présentés comme une garantie universelle ou automatiquement vérifiée pour toute cible.

**Valeur pour K7PL :** étudier le temps comme une ressource explicitement autorisée, attribuée et débitée au niveau du noyau, tout en conservant une preuve distincte du coût de chaque opération et de la faisabilité globale.

### 5.3 Correction de compilation : CompCert et CakeML

CompCert fournit une preuve de correction sémantique pour un compilateur C vérifié et documente les passes et architectures couvertes. CakeML fournit un autre exemple de chaîne de compilation formellement vérifiée. Ces projets montrent comment découper la preuve par étapes et relier les représentations intermédiaires.

Sources :
- [CompCert — documentation et développement Coq](https://compcert.org/doc/).
- Tan et al., *A New Verified Compiler Backend for CakeML*, ICFP 2016, [DOI 10.1145/2951913.2951924](https://doi.org/10.1145/2951913.2951924).

**Limite :** la correction sémantique n’est pas à elle seule un théorème de préservation du coût. K7PL devrait définir une relation de coût et prouver une borne de simulation ou recourir à une analyse WCET sur le binaire généré.

### 5.4 Analyse statique abstraite et sensibilité aux chemins

La littérature WCET utilise l’interprétation abstraite pour calculer des bornes conservatrices, notamment pour les caches et les chemins de contrôle. Un travail présenté à PLDI 2026 étudie une analyse des caches sensible aux chemins pour améliorer la précision tout en conservant la sûreté des bornes.

Source : Xiao, Sun, Zhang, Zhan et Ju, *Path-Sensitive Abstract Interpretation for WCET Estimation*, PLDI 2026, [DOI 10.1145/3808252](https://doi.org/10.1145/3808252).

**Valeur pour K7PL :** les grades et les preuves de bornes peuvent fournir des informations de contrôle et de multiplicité à l’analyseur, mais il faut prouver que ces informations sont complètes et compatibles avec les chemins du binaire. Une borne de type polynomial ou un potentiel amorti est utile pour la complexité, mais ne remplace pas l’analyse du matériel.

## 6. Architecture d’assurance proposée

L’architecture recommandée est une chaîne à obligations explicites, sans supposer que le grade unique doive porter toute la preuve.

| Niveau | Artefact requis | Proposition à établir | État dans le snapshot |
|---|---|---|---|
| G0 — norme | Définition de travail, profondeur, budget et composition | Les quantités et domaines sont sans ambiguïté | Partiel ; le coût scalaire est explicite |
| G1 — sémantique | Sémantique opérationnelle instrumentée par coût | Chaque transition débite un coût conforme à sa règle | Ouvert |
| G2 — composition | Théorèmes sur séquencement, branchement, boucle, appel, concurrence | Le coût du programme borne le coût de ses composants | Partiel au niveau arithmétique générique |
| G3 — typage | Règles de grade et effets reliées à la sémantique | Tout programme bien typé satisfait son contrat abstrait | Ouvert |
| G4 — compilation | Relation source/IR/binaire et validation des coûts | La borne survit à la compilation ou est recalculée | Non établi par les artefacts étudiés |
| G5 — analyse machine | Analyse WCET pour cible et configuration | La borne couvre toutes les exécutions admises du binaire | À sélectionner et intégrer |
| G6 — ordonnancement | Modèle de tâches, échéances et interférences | Les échéances sont satisfaites sous les hypothèses annoncées | Ouvert |
| G7 — exécution | Paramètres noyau/runtime, mesures et surveillance | Le système exécuté correspond à la configuration analysée | Ouvert |

Cette chaîne autorise des résultats utiles avant une garantie de bout en bout. Par exemple, K7PL peut prouver une borne abstraite sans revendiquer de WCET ; un analyseur peut fournir une borne machine sans prouver que toutes les règles normatives l’impliquent ; un ordonnanceur peut appliquer un quota sans garantir une échéance individuelle.

Le grade ne doit pas devenir une collection de coordonnées ajoutées au fil des lacunes. Le choix doit distinguer :
- les propriétés du langage et de la sémantique ;
- les preuves de composition ;
- les contrats des primitives et FFI ;
- les propriétés de la compilation ;
- l’analyse de la cible matérielle ;
- l’ordonnancement et les mécanismes du noyau.

## 7. Questions ouvertes et obligations formelles

### O1 — Définition de la quantité abstraite

Définir formellement ce que représentent (W), (D), `Cost_Budget` et le budget : unités, domaine, composition et comportement pour récursion, boucles, appels, blocages et concurrence. Préciser si (D) est une profondeur de dépendance, une longueur de chemin ou autre chose.

### O2 — Coût opérationnel

Définir une sémantique instrumentée `stepCost` ou une relation `⟨e, σ⟩ →[c] ⟨e', σ'⟩`. Prouver que chaque transition est comptabilisée, y compris allocation, synchronisation, exceptions, appels système et opérations de bibliothèque. Les événements d’attente doivent être distingués du temps CPU et du temps mural.

### O3 — Composition

Établir les lois de coût pour séquencement, branchement, appels, récursion, concurrence et annulation. En concurrence, distinguer travail total et chemin critique. Définir les hypothèses nécessaires pour que le maximum travail/profondeur soit une borne pertinente dans le modèle abstrait choisi.

### O4 — Préservation par le typage

Relier le jugement normatif de grade et d’effets au coût opérationnel. Prouver une propriété du type : si (e) est bien typé sous un contrat de coût (b), alors toute exécution couverte consomme au plus (b) dans le modèle abstrait. La forme exacte dépend de la sémantique et du traitement des calculs non terminants.

### O5 — Primitives, FFI et runtime

Attribuer des contrats conservateurs aux primitives et appels externes. Si un appel ne dispose pas d’une borne, le programme englobant ne peut pas hériter d’une garantie WCET dure sans autre restriction. Définir comment les coûts d’allocation, collecte mémoire, E/S et pilotes sont facturés.

### O6 — Source vers binaire

Choisir une chaîne de compilation et établir soit la préservation de la borne de coût, soit un recalcul sounde sur le binaire. Les optimisations dites sans surcoût doivent être justifiées séparément : absence d’allocation, coût d’instrumentation, code généré, appels runtime et mesure comparative.

### O7 — Matériel et WCET

Choisir une cible exacte et une configuration contrôlée. Documenter modèle de cache, mémoire, interruptions, DMA, fréquence, état d’énergie et interférences. Définir le rôle d’un analyseur statique et les éléments de son propre modèle qui doivent être vérifiés ou placés dans le périmètre de confiance.

### O8 — Ordonnancement

Choisir le modèle de tâches et de préemption, les priorités, périodes, échéances, blocages, coût des commutations et politique de partage CPU. Prouver la faisabilité sous ces hypothèses ; ne pas inférer une échéance satisfaite de la seule preuve qu’un programme termine.

### O9 — Observabilité et mesure

Définir les benchmarks reproductibles et les configurations de référence. Mesurer latence, dispersion, coûts d’instrumentation et régressions de performance. Ces résultats servent à calibrer et falsifier le modèle, mais doivent rester classés comme mesures, non comme bornes universelles.

## 8. Contre-exemples adversariaux

Les cas suivants doivent devenir des tests déterministes ou des modèles bornés. Un test qui passe est une preuve sur le cas exercé seulement ; il ne ferme pas l’obligation générale.

1. **Boucle bornée dans le modèle, primitive externe sans borne** : le coût du corps ne dispose d’aucun contrat pour l’appel FFI.
2. **Terminaison sans borne utile** : une récursion termine, mais la borne numérique disponible est trop faible ou absente.
3. **Branchement** : le coût déclaré ne couvre qu’une branche alors que l’autre est atteignable.
4. **Concurrence** : le travail total est borné, mais une contention ou un blocage non borné retarde la tâche.
5. **Attente sur canal** : le temps d’attente dépend d’un autre acteur ou de l’environnement ; il n’est pas assimilé au coût CPU local.
6. **Allocation et récupération** : un coût moyen est utilisé à la place d’une borne couvrant la collecte ou la fragmentation.
7. **Interruption** : le modèle omet des interruptions admises dans la configuration.
8. **Cache froid** : la borne suppose implicitement un cache chaud alors que le chemin réel peut subir des défauts.
9. **SMP** : l’analyse un cœur est extrapolée à plusieurs cœurs malgré la contention partagée.
10. **Optimisation du compilateur** : une transformation préserve la sortie fonctionnelle mais modifie la structure de coût ou l’allocation.
11. **Instrumentation** : le coût mesuré comprend le traceur, puis est attribué au programme sans séparation.
12. **Quota CPU** : un budget par période est présenté comme une garantie de fin avant une échéance.
13. **Échéances** : chaque tâche respecte isolément son WCET, mais le jeu de tâches est non faisable sous l’ordonnanceur choisi.
14. **État matériel** : la borne est réutilisée avec une fréquence, une mémoire ou une révision de processeur différente.
15. **Budget infini** : le cas `⊤` passe l’admissibilité arithmétique mais ne donne aucune borne finie exploitable en temps réel.
16. **Coût nul déclaré** : une primitive est marquée de coût nul alors qu’elle déclenche un travail runtime ou un appel système.

## 9. Plan expérimental priorisé

**P0 — Fixer le vocabulaire et les unités.** Écrire une note de définition qui sépare nombre d’étapes, travail, profondeur, coût abstrait, coût machine, quota CPU, WCET et échéance. Aucun engagement de temps réel ne doit être formulé avant cette clarification.

**P1 — Petit fragment vertical.** Définir une sémantique instrumentée pour un sous-ensemble exécutable : constantes, séquencement, branchement, boucle bornée, appel pur et primitive dotée d’un contrat explicite. Prouver la borne abstraite pour ce fragment, puis la tester contre un interpréteur de référence.

**P2 — Tracer les coûts.** Ajouter des traces reproductibles qui séparent étapes sémantiques, instructions ou compteurs disponibles et temps mural. Documenter l’écart et l’influence de l’instrumentation. Ne pas utiliser les mesures comme preuve d’une borne supérieure.

**P3 — Sélectionner une cible.** Choisir une architecture et un profil d’exécution adaptés aux contraintes de K7PL. Évaluer les outils WCET disponibles pour ce binaire et cette configuration, leurs hypothèses et les parties du modèle non couvertes. Ne pas présumer qu’un outil ciblant une architecture donnée couvre MLIR ou la cible finale sans adaptation.

**P4 — Composition temps réel.** Construire un jeu de tâches minimal avec WCET, période, échéance, priorité, blocages et règles de préemption explicites. Vérifier la faisabilité sous le modèle retenu et comparer avec un modèle borné de l’ordonnanceur.

**P5 — Chaîne d’assurance.** Relier contrat normatif → preuve Lean → sémantique instrumentée → artefact compilé → analyse WCET → configuration de déploiement. Tout lien absent doit être enregistré comme une obligation ouverte.

## 10. Grille de clôture

R6 ne pourra être considéré comme fermé que lorsque les critères applicables seront documentés avec leurs preuves et limites :

- [ ] Définition sans ambiguïté de (W), (D), `Cost_Budget`, unités et domaines.
- [ ] Correspondance démontrée entre le profil normatif et le porteur Lean.
- [ ] Sémantique instrumentée couvrant toutes les transitions du fragment retenu.
- [ ] Théorèmes de composition pour séquencement, branchement, boucles, appels et concurrence dans le périmètre.
- [ ] Contrats pour primitives, runtime, FFI et opérations système, ou exclusion explicite du périmètre.
- [ ] Relation de correction de coût ou analyse au niveau binaire.
- [ ] Matériel, firmware, configuration et hypothèses d’interférence précisément identifiés.
- [ ] Analyse WCET sounde et portée de ses hypothèses documentées.
- [ ] Modèle d’ordonnancement et preuve de faisabilité des échéances ciblées.
- [ ] Tests adversariaux, expériences reproductibles et séparation claire entre résultats prouvés et mesurés.
- [ ] Chaîne de traçabilité complète pour chaque affirmation temporelle publiée.

## 11. Conclusion

Le modèle Lean existant est un socle d’arithmétique de budgets abstraits, pas encore un modèle de temps réel de bout en bout. Sa valeur est de rendre certaines lois et préconditions vérifiables et de fournir un point de départ pour la composition. La prochaine étape scientifique n’est pas d’ajouter d’emblée une coordonnée de grade supplémentaire : il faut définir les quantités, instrumenter une sémantique minimale et prouver le lien entre les contrats abstraits et les coûts réellement consommés.

La garantie la plus forte ne sera disponible qu’en composant preuve du langage, preuve de compilation ou validation de traduction, analyse WCET du binaire sur une cible fixée et preuve de faisabilité de l’ordonnancement. Jusqu’à cette composition, la formulation exacte est : **bornes arithmétiques abstraites disponibles ; correspondance opérationnelle partielle ou ouverte ; WCET et échéances du système K7PL non établis par les artefacts étudiés.**
