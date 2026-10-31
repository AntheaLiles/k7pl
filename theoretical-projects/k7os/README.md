# Dossiers de recherche — K7PL et conception d’un OS

Dix dossiers autonomes (R0–R9) cadrent les recherches nécessaires pour évaluer les garanties d’un système d’exploitation envisagé en K7PL. Ils sont préparatoires : ils ne modifient pas implicitement la spécification normative et ne déclarent aucune garantie acquise.

Le [registre provisoire des évolutions à instruire dans la spécification](SPEC-DELTA-REGISTER.md) consolide les apports de R0–R9, les décisions de conception déjà exprimées et les obligations normatives ou de preuve à examiner. Il est non normatif et ne constitue pas encore une autorisation de réécrire les chapitres concernés.

Le dossier [K7OS — Exploration conjointe](K7OS-JOINT-EXPLORATION.md) conserve les choix d'architecture système, mécanismes, profils et cibles déjà étudiés lorsque ceux-ci ne doivent pas figurer comme prescriptions universelles de K7PL. Il complète le registre sans le remplacer : aucune architecture de K7OS n'est ratifiée par ces documents.

Les rapports R4 et R5 ont été intégrés à `main` par les PR [#286](https://github.com/AntheaLiles/k7pl/pull/286) et [#287](https://github.com/AntheaLiles/k7pl/pull/287) le 2026-10-24. Leur statut reste non normatif ; la fusion des rapports ne clôt pas leurs obligations formelles.


| ID | Sujet | Priorité |
|---|---|---:|
| [R0](R0-brief-threat-model-assurance-matrix.md) | Modèle de menace et matrice d’assurance | P0 |
| [R1](R1-brief-authority-capabilities-revocation-FFI.md) | Autorité, capacités et révocation FFI | P1 |
| [R2](R2-brief-safe-compilation-source-to-binary.md) | Correction de compilation source → binaire | P1 |
| [R3](R3-confidentiality-integrity-non-interference.md) | Confidentialité, intégrité et non-interférence — rapport exécuté | P1 |
| [R4](R4-concurrency-protocols-liveness-cancellation.md) | Protocoles, vivacité et annulation | P2 || [R5](R5-memory-borrowing-aliasing-separation-logic.md) | Permissions mémoire et logique de séparation | P2 |
| [R6](R6-grades-budgets-WCET-real-time.md) | Grades, budgets et WCET — rapport exécuté | P3 |
| [R7](R7-failures-linear-resources-persistence.md) | Pannes, ressources linéaires et persistance — rapport exécuté | P3 |
| [R8](R8-operating-systems-comparison.md) | Comparaison d’OS et d’architectures voisines — rapport exécuté | P2, parallèle |
| [R9](R9-model-checking-counterexamples-traceability.md) | Model checking, contre-exemples et traçabilité — exploration TLC bornée exécutée ; lien sémantique K7PL ouvert | P3, transversal |## Executed reports

- [R0 — Threat Model and Assurance Matrix](R0-threat-model-assurance-matrix.md): audited snapshot of 2026-10-23; non-normative, with architecture gates and open proof obligations.

## Ordre de lancement

Commencer par R0. R1, R2 et R3 peuvent ensuite progresser en parallèle ; R8 peut être lancé dès le départ. R4 et R5 approfondissent concurrence et mémoire. R6 et R7 dépendent du modèle d’exécution retenu. R9 soutient tous les chantiers sans remplacer les preuves Lean.

## Règles communes

- Revalider le SHA courant de main, les statuts et les sources avant chaque étude.
- Distinguer spécifié, formalisé, prouvé, implémenté, testé, mesuré et déployé.
- Un lien lexical entre identifiant normatif et déclaration Lean n’est pas une preuve de correspondance sémantique.
- Ne pas ajouter une coordonnée au grade simplement parce qu’une propriété manque : déterminer si le besoin relève du langage, des preuves de composition, du compilateur, du runtime, du noyau ou du matériel.
- Le tableau de bord du dépôt indique que l’étape C est ouverte. Ces recherches ne constituent pas une autorisation de démarrer les étapes aval.

Chaque rapport doit présenter sources primaires, date/version, hypothèses, résultats, limites, contre-exemples, obligations restantes et recommandations priorisées.

## Executed report — R1

- [R1 — Authority, Capabilities, Revocation, and FFI Boundaries](R1-authority-capabilities-ffi-boundaries.md): source-grounded authority model, revocation semantics, FFI contracts, adversarial cases, and open enforcement obligations. Non-normative.

## Executed report — R2

- [R2 — Source-to-Binary Correctness and Zero-Overhead Assurance](R2-source-to-binary-correctness.md): source-grounded pipeline audit, semantic-preservation contract, TCB boundaries, and a staged performance-assurance plan. Non-normative.


## Executed report — R5

- [R5 — Memory permissions, borrowing, aliasing and separation logic](R5-memory-borrowing-aliasing-separation-logic.md): audits the grade/capability distinction, spatial safety and H1/H2/H3 premises, borrowing, alias provenance, FFI and weak-memory obligations. Non-normative; end-to-end memory safety remains unestablished.

## Executed report — R4

- [R4 — Concurrency, protocols, liveness and cancellation](R4-concurrency-protocols-liveness-cancellation.md): analysis of the static dependency DAG versus the dynamic wait graph, local/global progress, fairness assumptions, cancellation, timeout and recovery contracts. Non-normative; liveness remains conditional where the semantics or fairness model is open.

## Executed report — R6

- [R6 — Grades, budgets, WCET and real-time constraints](R6-grades-budgets-WCET-real-time.md): audit of the Lean budget model, cost semantics, compilation-to-binary obligations, WCET analysis, scheduling feasibility, and adversarial cases. Non-normative; no end-to-end timing guarantee is claimed.


## Executed report — R7

- [R7 — Crashes, linear resources and persistence](R7-failures-linear-resources-persistence.md): audit of actor replay, durable logs/checkpoints, resource recovery, external side effects, crash consistency, and fault-injection scenarios. Non-normative; no end-to-end crash-recovery guarantee is claimed.

## Executed report — R8

- [R8 — OS and neighbouring architectures](R8-operating-systems-comparison.md): comparison of Theseus, Tock, Genode, CHERIoT RTOS, seL4, MirageOS, Verve, Cogent and adjacent designs, extended with TempleOS, Oberon, GNU Hurd, Multics, FreeBSD, PICK, DBOS, Plan 9, Inferno, A2/Bluebottle, 9front, Harvey, MINIX 3, QNX Neutrino, OpenBSD pledge/unveil, Qubes OS, Redox and k23. Also distinguishes Medley Interlisp as a development environment and separates OS isolation from runtime and database architecture. Non-normative; no target architecture is ratified.


## R9 — Model checking et traçabilité

- [R9 — Model checking, contre-exemples et traçabilité](R9-model-checking-counterexamples-traceability.md) : comparaison TLA+/TLC, Apalache, Lean et tests à état ; modèle borné d’annulation vérifié par TLC en CI. La configuration nominale passe sur 9 états accessibles et la configuration négative reproduit le témoin attendu. La correspondance avec la sémantique normative K7PL reste ouverte.