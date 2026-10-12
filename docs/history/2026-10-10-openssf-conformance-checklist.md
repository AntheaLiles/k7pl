<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Archive — OpenSSF Best Practices et OSPS Baseline (2026-10-10)

> **Archive historique.** Cette checklist de travail a été déplacée de docs/tracking/ le 2026-10-10 car elle dupliquait le suivi de conformité. Ses cases et constats reflètent un inventaire de travail daté, pas l'état actuel de chaque critère ni les réponses enregistrées sur BadgeApp. Pour le suivi courant, utiliser [la matrice de critères](../security/BADGE-CONFORMANCE-MATRIX.md), [la feuille de route](../security/OPENSSF-ROADMAP.md) et [les actions humaines](../security/ACTIONS-HUMAINES.md).

> **Périmètre et méthode.** Cette checklist reprend les critères Passing, Silver, Gold et OpenSSF OSPS Baseline Levels 1–3 fournis pour l'audit K7PL. Les identifiants entre crochets sont les identifiants de critères OpenSSF. Les critères répétés à plusieurs niveaux sont conservés à leur niveau d'origine.
>
> **Lecture des cases.** Une case cochée signifie qu'une preuve actuelle identifiable dans le dépôt semble satisfaire le critère documentaire ou technique. Elle ne vaut pas auto-certification OpenSSF : les critères qui exigent une preuve opérationnelle, une configuration GitHub, une mesure, une activité sur une période donnée ou une décision de périmètre restent à vérifier. Une case non cochée signifie « à instruire », pas nécessairement « absent ».
>
> **Règle d'audit.** Pour chaque critère, consigner une preuve précise (fichier, workflow, réglage vérifié, résultat daté ou URL), puis choisir : satisfait, partiel, non satisfait ou N/A justifié. Ne jamais déclarer N/A sans justification spécifique au périmètre K7PL. Les réglages administratifs GitHub ne sont pas prouvés par la seule présence de documentation dans le dépôt.
>
> Sources de travail : [audit OpenSSF](../security/OPENSSF-AUDIT.md), [feuille de route OpenSSF](../security/OPENSSF-ROADMAP.md), [dossier d'assurance](../security/ASSURANCE-CASE.md), [évaluation des outils](../security/TOOLING-EVALUATION.md).

## Tableau de bord d'audit

**Dernière réévaluation documentaire : 2026-10-10 — PR #121 fusionnée ; état du profil BadgeApp et preuves CI relus.**
Les cases de cette checklist constituent un inventaire interne de preuves candidates. Une case cochée ne signifie pas que la réponse a été soumise ou acceptée sur BadgeApp. Le profil [K7PL](https://www.bestpractices.dev/en/projects/15239/baseline-2) reste `in_progress` (critères `v2026.08.28`) et affiche `(Name Unknown)` ; nom, description, licence et langages sont vides. Les paramètres administratifs, les critères temporels et les revendications de revue humaine restent à vérifier. Voir [l'analyse de l'automatisation](../security/BADGE-AUTOMATION.md) et [la matrice critère par critère](../security/BADGE-CONFORMANCE-MATRIX.md). Ne choisir `N/A` qu'après décision explicite de périmètre et justification propre au critère.

- [ ] Passer en revue chaque critère et joindre une preuve.
- [ ] Séparer les critères du logiciel publié, ceux du dépôt et ceux de la gouvernance/configuration GitHub.
- [ ] Justifier explicitement chaque N/A dans la colonne de suivi ou dans une section dédiée.
- [ ] Distinguer les éléments contrôlés par CI des engagements humains et des preuves d'activité.
- [ ] Mettre à jour les cases et les références après chaque PR fusionnée.
- [ ] Refaire une vérification complète avant toute demande de badge.

## Passing

### Basics — site, licence et documentation

- [x] [description_good] Le README décrit brièvement K7PL et le problème visé.
- [x] [interact] Le README indique comment obtenir le dépôt, signaler un problème et contribuer.
- [x] [contribution] Le processus de contribution par issue, branche, PR et CI est documenté.
- [x] [contribution_requirements] Les exigences de contribution et règles de rédaction sont référencées.
- [x] [floss_license] Les résultats du projet sont couverts par des licences FLOSS/libres explicites.
- [ ] [floss_license_osi] Vérifier et documenter l'approbation OSI des licences retenues, ou expliquer les nuances de chaque artefact.
- [x] [license_location] Les licences sont maintenues dans LICENSE/LICENSES et les fichiers portent des identifiants SPDX.
- [x] [documentation_basics] README, guide de contribution, architecture et documentation de spécification sont présents.
- [x] [documentation_interface] La spécification décrit l'interface externe prévue ; vérifier la suffisance du détail au regard de l'état réellement publié.
- [x] [sites_https] Les URLs officielles principales utilisent HTTPS.
- [x] [discussion] Issues et pull requests GitHub fournissent des discussions publiques indexables.
- [ ] [english] Vérifier l'aptitude réelle à recevoir et traiter des rapports/commentaires en anglais ; la documentation principale est largement francophone.
- [ ] [maintained] Vérifier les preuves d'activité récentes et définir une règle de maintien durable.

### Change Control — dépôt, versions, notes de version

- [x] [repo_public] Le dépôt GitHub est public.
- [x] [repo_track] Git enregistre les changements, auteurs et dates.
- [x] [repo_interim] Les branches et PR permettent l'examen de versions intermédiaires.
- [x] [repo_distributed] Git est utilisé.
- [x] [version_unique] Les versions et tags de spécification/implémentation ont des schémas distincts documentés.
- [x] [version_semver] Le projet documente des tags de version au format X.Y.Z.
- [ ] [version_tags] Vérifier l'existence et la politique d'étiquetage de chaque release destinée aux utilisateurs.
- [ ] [release_notes] Non satisfait à ce stade : les journaux existent, mais l'audit relève une release sans notes humaines complètes et le flux n'a pas été éprouvé de bout en bout.
- [ ] [release_notes_vulns] Définir la procédure pour mentionner les vulnérabilités connues corrigées dans les notes de release, ou justifier N/A quand applicable.

### Reporting — rapports de bogues et vulnérabilités

- [x] [report_process] Les issues GitHub permettent de soumettre des rapports.
- [x] [report_tracker] Le dépôt utilise les issues pour suivre les tâches et anomalies.
- [ ] [report_responses] Mesurer les accusés de réception des rapports sur la fenêtre temporelle exigée.
- [ ] [enhancement_responses] Mesurer les réponses aux demandes d'amélioration sur la fenêtre exigée.
- [x] [report_archive] Issues et réponses restent publiquement consultables.
- [x] [vulnerability_report_process] SECURITY.md documente le signalement de vulnérabilités.
- [x] [vulnerability_report_private] SECURITY.md décrit le signalement privé GitHub.
- [ ] [vulnerability_report_response] Vérifier les données de délai de réponse sur six mois, ou justifier N/A en l'absence de rapports.

### Quality — build, tests, évolution et avertissements

- [x] [build] Le dépôt fournit un build automatisé Lean/Lake pour le code et la spécification.
- [x] [build_common_tools] Le build s'appuie sur Lean, elan et Lake.
- [x] [build_floss_tools] La chaîne de construction documentée repose sur des outils libres.
- [x] [test] Les tests Lean et Python sont publiquement disponibles et leur exécution est documentée.
- [x] [test_invocation] Les tests sont invoqués par la commande standard du projet `lake test` et par pytest pour les outils Python.
- [ ] [test_most] Mesurer la couverture et identifier les zones non testées ; ne pas inférer une couverture élevée de la seule existence de tests.
- [x] [test_continuous_integration] GitHub Actions exécute les contrôles sur les PR.
- [x] [test_policy] CONTRIBUTING.md indique quand les changements doivent être accompagnés de tests.
- [ ] [tests_are_added] Vérifier les PR récentes pour démontrer que la politique de test a été appliquée.
- [x] [tests_documented_added] Les instructions de contribution mentionnent les tests et contrôles attendus.
- [x] [warnings] `warningAsError` est activé sur les bibliothèques et les exécutables Lean `mainTest` et `spec` via `lakefile.lean` ; PR #98 fusionnée et CI de PR passée.
- [x] [warnings_fixed] Les cibles Lean déclarées dans `lakefile.lean` utilisent les ensembles d'options avec `warningAsError` ; la CI de PR #98 est passée.
- [x] [warnings_strict] `lakefile.lean` applique les options strictes aux bibliothèques et exécutables du dépôt ; la CI de PR #98 est passée.

### Security — conception, cryptographie, livraison et secrets

- [ ] [know_secure_design] Identifier la preuve que le mainteneur principal connaît les principes de conception sécurisée ; la documentation seule ne prouve pas la compétence.
- [ ] [know_common_errors] Identifier la preuve de connaissance des vulnérabilités courantes et des mitigations pertinentes pour le projet.
- [ ] [crypto_published] Déterminer si le logiciel produit utilise de la cryptographie ; justifier N/A si aucun usage.
- [ ] [crypto_call] Déterminer si le logiciel appelle des fonctions cryptographiques ; justifier N/A si hors périmètre.
- [ ] [crypto_floss] Vérifier la disponibilité d'une implémentation FLOSS pour toute fonctionnalité cryptographique, ou N/A.
- [ ] [crypto_keylength] Vérifier les longueurs de clés et possibilités de configuration, ou N/A.
- [ ] [crypto_working] Vérifier l'absence de cryptographie cassée dans les mécanismes par défaut, ou N/A.
- [ ] [crypto_weaknesses] Vérifier l'absence d'algorithmes/modes à faiblesses sérieuses, ou N/A.
- [ ] [crypto_pfs] Vérifier l'usage éventuel de protocoles d'accord de clés, ou N/A.
- [ ] [crypto_password_storage] Vérifier si le produit stocke des mots de passe d'utilisateurs externes, ou N/A.
- [ ] [crypto_random] Vérifier la génération de clés/nonces si le produit en génère, ou N/A.
- [x] [delivery_mitm] HTTPS est utilisé pour le dépôt, les canaux de documentation et les distributions connues.
- [x] [delivery_unsigned] Aucun téléchargement de hash depuis HTTP n'est décrit dans le flux de distribution ; confirmer lors de l'audit de release.
- [ ] [vulnerabilities_fixed_60_days] Vérifier les avis et vulnérabilités ouvertes, avec dates et sévérités.
- [ ] [vulnerabilities_critical_fixed] Définir/évaluer la pratique de correction rapide des vulnérabilités critiques.
- [ ] [no_leaked_credentials] Contrôles gitleaks/CI présents ; vérifier leur portée, leurs exceptions et l'absence de secrets valides.

### Analysis — analyses statique et dynamique

- [ ] [static_analysis] Identifier une analyse statique FLOSS adaptée à Lean au-delà du lint et des avertissements ; sinon fournir une justification N/A étayée.
- [ ] [static_analysis_common_vulnerabilities] Évaluer les outils SAST pour Lean et documenter les limites ; l'audit existant indique qu'aucun outil ne couvre actuellement Lean.
- [ ] [static_analysis_fixed] Définir comment traiter les vulnérabilités exploitables de sévérité moyenne ou supérieure si une analyse adaptée en trouve.
- [ ] [static_analysis_often] Déterminer si une analyse statique pertinente peut être exécutée à chaque commit ou quotidiennement.
- [ ] [dynamic_analysis] Évaluer une analyse dynamique adaptée aux livrables avant release, ou justifier N/A.
- [ ] [dynamic_analysis_unsafe] Le cœur est en Lean, non en langage mémoire-non-sûr connu ; confirmer le périmètre de tout code auxiliaire et justifier N/A si applicable.
- [ ] [dynamic_analysis_enable_assertions] Évaluer les assertions d'exécution pour les tests/analyses dynamiques.
- [ ] [dynamic_analysis_fixed] Définir le traitement des vulnérabilités trouvées par analyse dynamique, ou N/A motivé.

## Silver

### Basics — prérequis, gouvernance, continuité

- [ ] [achieve_passing] Obtenir d'abord le badge Passing.
- [x] [contribution_requirements] Les règles de contribution sont documentées et référencées.
- [ ] [dco] Choisir et mettre en place un mécanisme DCO/CLA ou justifier formellement l'absence actuelle de ce mécanisme.
- [x] [governance] Le modèle de gouvernance et la prise de décision sont documentés dans [GOVERNANCE.md](../security/GOVERNANCE.md) ; la continuité et la revue indépendante restent des écarts.
- [x] [code_of_conduct] CODE_OF_CONDUCT.md est présent.
- [x] [roles_responsibilities] Les rôles clés, responsabilités et attribution actuelle sont documentés dans [GOVERNANCE.md](../security/GOVERNANCE.md) ; les rôles de second mainteneur/relecteur restent vacants.
- [ ] [access_continuity] Préparer une procédure de continuité permettant à une autre personne de reprendre le dépôt, les issues et les releases sous une semaine.
- [ ] [bus_factor] Le projet est actuellement porté par une seule personne ; planifier une voie réaliste vers un facteur de bus de 2 sans prétendre que le critère est déjà satisfait.

### Documentation et accessibilité

- [x] [documentation_roadmap] Une feuille de route OpenSSF et des plans de travail sont présents ; vérifier que l'horizon documenté couvre au moins un an et le périmètre produit.
- [x] [documentation_architecture] Une architecture et des documents de conception sont présents.
- [x] [documentation_security] SECURITY.md et les documents d'assurance décrivent les limites et attentes de sécurité.
- [x] [documentation_quick_start] README.md fournit un démarrage et des commandes de build/test.
- [ ] [documentation_current] Vérifier la cohérence des docs avec l'état actuel et fermer les défauts connus.
- [ ] [documentation_achievements] Préparer le mécanisme pour afficher le badge dans les 48 heures après obtention ; ne pas afficher un badge non obtenu.
- [ ] [accessibility_best_practices] Auditer l'accessibilité des sites, documents et résultats, puis consigner les limites.
- [ ] [internationalization] Déterminer si l'i18n s'applique à la nature du langage et à ses interfaces ; justifier la décision.
- [ ] [sites_password_security] Les sites sont fournis par GitHub Pages/GitHub ; confirmer qu'aucun site K7PL ne stocke des mots de passe externes, sinon auditer le stockage.

### Change Control — versions antérieures

- [ ] [maintenance_or_update] Définir la politique de maintenance des versions anciennes ou justifier N/A tant qu'aucun produit versionné n'est distribué.

### Reporting — suivi et réponse aux vulnérabilités

- [x] [report_tracker] GitHub Issues est disponible pour le suivi individuel.
- [ ] [vulnerability_report_credit] Vérifier les rapports résolus sur 12 mois et l'attribution du crédit, ou N/A si aucun rapport résolu.
- [x] [vulnerability_response_process] SECURITY.md décrit le processus de réponse et les délais annoncés ; vérifier la cohérence avec la procédure réelle.

### Quality — normes, build, dépendances, tests

- [x] [coding_standards] CONTRIBUTING.md renvoie aux règles de rédaction Lean/Verso et à Conventional Commits.
- [ ] [coding_standards_enforced] Vérifier l'application automatique de chaque norme pertinente et documenter les parties non automatisables.
- [ ] [build_standard_variables] N/A possible si aucun binaire natif conventionnel n'est produit ; documenter la justification.
- [ ] [build_preserve_debug] N/A possible si le projet n'a pas de système d'installation/binaire natif ; documenter la justification.
- [ ] [build_non_recursive] N/A possible si aucune installation/build natif concerné ; documenter la justification.
- [ ] [build_repeatable] Évaluer la reproductibilité bit à bit des artefacts effectivement générés ; les builds identiques observés ne suffisent pas à eux seuls.
- [ ] [installation_common] Le projet ne fournit pas encore un mécanisme d'installation utilisateur classique ; définir N/A ou une stratégie.
- [ ] [installation_standard_variables] N/A si aucun système d'installation pertinent ; consigner la justification.
- [x] [installation_development_quick] CONTRIBUTING.md décrit l'installation de l'environnement de développement et des tests.
- [x] [external_dependencies] lake-manifest.json liste les dépendances Lake de manière exploitable.
- [ ] [dependency_monitoring] Partiel : le premier run OSV-Scanner a extrait 14 paquets et n'a rapporté aucun avis connu ; la PR configure aussi une exécution hebdomadaire. La couverture OSV, la répétition planifiée et la procédure de triage restent à vérifier avant de considérer la surveillance établie.
- [x] [updateable_reused_components] Les versions Lean/Mathlib/CSLib/Verso sont épinglées et mises à jour par un workflow documenté ; vérifier la facilité de mise à jour de toutes les dépendances.
- [ ] [interfaces_current] Rechercher les API obsolètes dans la pile et documenter la décision.
- [x] [automated_integration_testing] CI exécute des suites et produit des statuts de réussite/échec.
- [ ] [regression_tests_added50] Examiner les bogues corrigés sur six mois et démontrer que les tests de régression couvrent au moins 50 % des corrections.
- [ ] [test_statement_coverage80] Mesurer la couverture de statements si un outil FLOSS pertinent existe pour Lean ; sinon documenter l'analyse et la justification N/A.

### New functionality, warnings and security

- [x] [test_policy_mandated] La politique de contribution prévoit des tests pour les changements pertinents ; confirmer que le caractère obligatoire est formulé sans ambiguïté.
- [x] [tests_documented_added] CONTRIBUTING.md documente les contrôles attendus lors d'une PR.
- [x] [warnings_strict] `lakefile.lean` applique les options strictes aux bibliothèques et exécutables du dépôt ; la CI de PR #98 est passée.
- [ ] [implement_secure_design] Faire le lien entre les principes du modèle de menace et les mécanismes de conception réellement implémentés.
- [ ] [crypto_weaknesses] Voir l'analyse Passing ; N/A uniquement après examen du périmètre.
- [ ] [crypto_algorithm_agility] Déterminer si l'agilité cryptographique est applicable ; sinon N/A motivé.
- [ ] [crypto_credential_agility] Déterminer si le logiciel gère des identifiants/clefs privées ; sinon N/A motivé.
- [ ] [crypto_used_network] Déterminer si le logiciel produit utilise le réseau ; sinon N/A motivé.
- [ ] [crypto_tls12] Déterminer si le logiciel produit utilise TLS ; sinon N/A motivé.
- [ ] [crypto_certificate_verification] Si TLS est utilisé par le produit, vérifier la validation de certificat par défaut ; sinon N/A.
- [ ] [crypto_verification_private] Si TLS est utilisé, vérifier la validation avant l'envoi d'informations privées ; sinon N/A.
- [ ] [signed_releases] Le flux de release doit signer cryptographiquement les résultats destinés à un usage large et expliquer la vérification ; actuellement, le flux n'a pas été éprouvé de bout en bout.
- [ ] [version_tags_signed] Évaluer la signature des tags importants.
- [ ] [input_validation] Définir les frontières d'entrée non fiables et vérifier validation/rejet ; N/A uniquement si aucune entrée contrainte n'existe.
- [ ] [hardening] Identifier les mécanismes de durcissement réellement applicables à l'implémentation Lean et aux scripts.
- [ ] [assurance_case] Le dossier existe mais indique lui-même que le critère n'est pas encore satisfait : le modèle de menace, les frontières de confiance et l'application des principes doivent être validés et reliés à des preuves.
- [ ] [static_analysis_common_vulnerabilities] Voir le critère Passing ; choisir un outil SAST pertinent ou motiver N/A.
- [ ] [dynamic_analysis_unsafe] Examiner les langages et composants réellement livrés ; justifier N/A si aucun langage mémoire-non-sûr.
 
## Gold

### Prérequis et gouvernance

- [ ] [achieve_silver] Obtenir d'abord le badge Silver.
- [ ] [bus_factor] Le facteur de bus doit être au moins 2.
- [ ] [contributors_unassociated] Développer au moins deux contributions significatives de personnes non associées.
- [ ] [copyright_per_file] REUSE/SPDX est en place ; vérifier que chaque fichier source a un avis de copyright adapté et que les exceptions sont justifiées.
- [x] [license_per_file] REUSE/SPDX fournit des déclarations de licence par fichier, sous réserve que le contrôle REUSE passe.

### Change Control — dépôt et accès

- [x] [repo_distributed] Le dépôt utilise Git.
- [ ] [small_tasks] Identifier et étiqueter des tâches d'entrée accessibles aux nouveaux contributeurs.
- [ ] [require_2FA] Vérifier le réglage GitHub imposant la 2FA aux personnes pouvant modifier le dépôt ou accéder aux rapports privés.
- [ ] [secure_2FA] Vérifier que la 2FA utilisée repose sur des mécanismes résistants à l'usurpation, ou consigner l'écart.

### Quality — revue et reproductibilité

- [x] [code_review_standards] CONTRIBUTING.md documente une liste d'auto-revue et indique explicitement qu'elle ne remplace pas une revue indépendante.
- [ ] [two_person_review] Le dépôt reconnaît qu'aucune revue humaine indépendante n'a lieu actuellement ; le critère ne peut pas être coché sans évolution réelle de l'équipe.
- [ ] [build_reproducible] Évaluer si le build est reproductible au sens OpenSSF, ou justifier N/A si aucune construction pertinente n'a lieu.

### Tests

- [x] [test_invocation] Les commandes d'exécution des tests sont documentées.
- [x] [test_continuous_integration] GitHub Actions automatise les tests et validations.
- [ ] [test_statement_coverage90] Mesurer la couverture de statements à 90 % si un outil FLOSS adapté existe ; sinon justifier N/A.
- [ ] [test_branch_coverage80] Mesurer la couverture de branches à 80 % si un outil FLOSS adapté existe ; sinon justifier N/A.

### Sécurité et analyse dynamique

- [ ] [crypto_used_network] Déterminer l'applicabilité aux résultats logiciels et documenter N/A si nécessaire.
- [ ] [crypto_tls12] Déterminer l'applicabilité TLS et documenter N/A si nécessaire.
- [ ] [hardened_site] Vérifier les en-têtes de sécurité des sites web pertinents (GitHub, Pages et distribution) et consigner les réglages/limites.
- [ ] [security_review] Dater et conserver une revue de sécurité couvrant exigences et frontières de sécurité dans la fenêtre de cinq ans.
- [ ] [hardening] Évaluer et appliquer les mécanismes de durcissement pertinents.
- [ ] [dynamic_analysis] Appliquer une analyse dynamique aux releases majeures, ou justifier N/A.
- [ ] [dynamic_analysis_enable_assertions] Évaluer les assertions d'exécution et leur activation lors de l'analyse dynamique.

## OpenSSF OSPS Baseline Level 1

- [ ] [osps_ac_01_01] Exiger une authentification multifacteur pour accéder aux ressources sensibles du dépôt.
- [ ] [osps_ac_02_01] Assigner manuellement les permissions des nouveaux collaborateurs ou appliquer le moindre privilège par défaut.
- [x] [osps_ac_03_01] Le ruleset actif « PR on main » impose un flux de PR et interdit le fast-forward ; sa configuration a été relue le 2026-10-09.
- [x] [osps_ac_03_02] Le ruleset actif « PR on main » contient la règle `deletion`, qui protège la branche par défaut contre la suppression.
- [ ] [osps_br_01_01] Assainir et valider les métadonnées non fiables utilisées par les pipelines CI/CD.
- [ ] [osps_br_01_03] Partiel : plusieurs contrôles utilisent des permissions restreintes et `persist-credentials: false` ; il faut vérifier systématiquement tous les workflows et chemins de code non fiable.
- [ ] [osps_br_03_01] Vérifier que toutes les URLs officielles sont servies exclusivement par des canaux chiffrés.
- [ ] [osps_br_03_02] Vérifier l'authenticité cryptographique des canaux de distribution officiels.
- [x] [osps_br_07_01] Gitleaks est intégré à la CI ; vérifier aussi la protection des données sensibles et les éventuelles exceptions.
- [ ] [osps_do_01_01] À la première release, fournir un guide utilisateur pour toutes les fonctions de base.
- [x] [osps_do_02_01] Les issues et instructions de contribution documentent le signalement des défauts.
- [x] [osps_gv_02_01] GitHub Issues et PR fournissent un mécanisme public de discussion.
- [x] [osps_gv_03_01] CONTRIBUTING.md décrit le processus de contribution.
- [x] [osps_le_02_01] La licence du code source est déclarée ; vérifier la conformité OSI/FSF des licences retenues.
- [x] [osps_le_02_02] Les licences des artefacts du projet sont déclarées ; vérifier leur conformité OSI/FSF.
- [x] [osps_le_03_01] Les licences sont dans LICENSE/LICENSES.
- [ ] [osps_le_03_02] Vérifier que chaque release inclut sa licence avec les artefacts source correspondants.
- [x] [osps_qa_01_01] Le dépôt source est publiquement lisible à une URL stable.
- [x] [osps_qa_01_02] Git conserve publiquement les modifications, auteurs et dates.
- [x] [osps_qa_02_01] lake-manifest.json répertorie les dépendances directes/transitives Lake ; vérifier la couverture des autres écosystèmes.
- [ ] [osps_qa_04_01] Documenter les codebases faisant partie du projet si le projet comporte plusieurs dépôts constitutifs.
- [ ] [osps_qa_05_01] À vérifier par inventaire du dépôt et contrôle automatisé ; la checklist ne contient pas encore de preuve exhaustive.
- [ ] [osps_qa_05_02] Vérifier l'absence de binaires non révisables dans l'historique actif et définir une règle.
- [x] [osps_vm_02_01] SECURITY.md indique le canal de contact de sécurité.

## OpenSSF OSPS Baseline Level 2

- [x] [osps_ac_04_01] Les workflows définissent des permissions minimales au niveau global ; vérifier qu'aucun job ne les élargit sans nécessité.
- [ ] [osps_br_02_01] Chaque release officielle doit avoir un identifiant unique ; vérifier l'application réelle à toutes les releases.
- [ ] [osps_br_04_01] Chaque release officielle doit contenir un changelog fonctionnel et de sécurité lisible.
- [ ] [osps_br_05_01] Standardiser l'ingestion des dépendances dans les pipelines là où un outil standard est disponible.
- [ ] [osps_br_06_01] Signer les releases ou fournir un manifeste signé contenant les hashes de chaque artefact.
- [x] [osps_do_06_01] CONTRIBUTING.md décrit la sélection, l'obtention et le suivi des dépendances.
- [x] [osps_do_07_01] CONTRIBUTING.md décrit les dépendances et commandes de construction.
- [ ] [osps_gv_01_01] Documenter les membres ayant accès aux ressources sensibles, sans exposer de données sensibles.
- [x] [osps_gv_01_02] [GOVERNANCE.md](../security/GOVERNANCE.md) décrit les rôles et responsabilités actuels, sans prétendre qu'une équipe existe.
- [x] [osps_gv_03_02] Le guide de contribution indique les exigences d'acceptabilité.
- [ ] [osps_le_01_01] Mettre en place une attestation légale de contribution à chaque commit (par exemple DCO), ou justifier l'écart.
- [x] [osps_qa_03_01] Le ruleset actif « PR on main » exige le status check `CI OK` et ne définit aucun acteur de contournement ; la politique exigeant une mise à jour stricte de la branche reste désactivée.
- [x] [osps_qa_06_01] CI exécute des tests/validations avant fusion des PR.
- [ ] [osps_sa_01_01] Documenter les actions et acteurs de l'ensemble du système livré avant une release pertinente.
- [ ] [osps_sa_02_01] Partiel : la spécification décrit l'interface prévue du langage, mais la couverture de toutes les interfaces des artefacts effectivement publiés reste à établir.
- [ ] [osps_sa_03_01] Avant une release, réaliser une évaluation de sécurité du logiciel et conserver la preuve.
- [x] [osps_vm_01_01] SECURITY.md décrit le signalement et un délai initial annoncé ; renforcer la politique de divulgation coordonnée si nécessaire.
- [x] [osps_vm_03_01] Un canal privé de signalement GitHub est documenté.
- [ ] [osps_vm_04_01] Définir la publication des données de vulnérabilité découvertes, y compris le cas où il n'y en a aucune.

## OpenSSF OSPS Baseline Level 3

- [ ] [osps_ac_04_02] Définir les permissions minimales pour chaque job CI/CD, sans héritage plus large que nécessaire.
- [ ] [osps_br_01_04] Assainir et valider les entrées de collaborateurs de confiance utilisées par les pipelines.
- [ ] [osps_br_02_02] Associer explicitement tous les artefacts d'une release à son identifiant unique.
- [x] [osps_br_07_02] [SECRETS-POLICY.md](../security/SECRETS-POLICY.md) documente stockage, moindre privilège, exposition, révocation/rotation et vérifications opérationnelles ; la configuration réelle reste à vérifier.
- [ ] [osps_do_03_01] Documenter comment vérifier l'intégrité et l'authenticité des artefacts de release.
- [ ] [osps_do_03_02] Documenter comment vérifier l'identité attendue de l'auteur ou du processus de release.
- [ ] [osps_do_04_01] Définir la portée et la durée du support de chaque release.
- [ ] [osps_do_05_01] Définir quand une version cesse de recevoir des mises à jour de sécurité.
- [ ] [osps_gv_04_01] Documenter la revue des collaborateurs avant d'accorder des permissions élevées aux ressources sensibles.
- [ ] [osps_qa_02_02] Fournir un SBOM pour tous les artefacts compilés livrés en release.
- [ ] [osps_qa_04_02] Si plusieurs dépôts composent une release, imposer à chaque sous-projet des exigences de sécurité au moins équivalentes.
- [x] [osps_qa_06_02] CONTRIBUTING.md décrit quand les tests et contrôles sont exécutés ; renforcer la documentation des déclencheurs si besoin.
- [x] [osps_qa_06_03] La politique de tests pour changements majeurs est documentée ; rendre l'exigence explicite et obligatoire si nécessaire.
- [ ] [osps_qa_07_01] Exiger une approbation humaine non-auteur avant chaque fusion sur la branche principale ; impossible à satisfaire honnêtement avec une seule personne sans élargir l'équipe.
- [ ] [osps_sa_03_02] Un modèle de menace existe, mais il n'est pas encore validé comme analyse complète de surface d'attaque et de chemins critiques avant release.
- [ ] [osps_vm_04_02] Produire un document VEX pour les vulnérabilités de composants déclarées non exploitables.
- [ ] [osps_vm_05_01] Documenter des seuils de remédiation pour les constats SCA liés aux vulnérabilités et licences.
- [ ] [osps_vm_05_02] Exiger la résolution ou la justification des violations SCA avant toute release.
- [ ] [osps_vm_05_03] Évaluer automatiquement chaque changement au regard d'une politique de dépendances malveillantes/vulnérables et bloquer les violations sauf exception documentée.
- [ ] [osps_vm_06_01] Documenter les seuils de remédiation des constats SAST.
- [ ] [osps_vm_06_02] Évaluer automatiquement chaque changement au regard d'une politique SAST et bloquer les violations sauf exception documentée.

## Registre de preuves et décisions N/A

État vérifié le 2026-10-09. Ce registre consigne les constats vérifiables à distance ; il ne remplace pas les contrôles de compte, de sécurité ou de publication qui exigent une action humaine.

| Identifiant | État (satisfait/partiel/non satisfait/N/A) | Preuve ou justification | Action, responsable, échéance |
|---|---|---|---|
| `warnings`, `warnings_fixed`, `warnings_strict` | satisfait (configuration) | `lakefile.lean` applique `warningAsError` aux bibliothèques et exécutables Lean ; PR #98 fusionnée et CI de PR passée. | Réévaluer après modification des cibles Lean ; mainteneuse, continu |
| `osps_ac_03_01`, `osps_ac_03_02`, `osps_qa_03_01` | partiel | Ruleset actif « PR on main » : règles `deletion`, `non_fast_forward`, PR requise, historique linéaire, status check `CI OK`, aucun acteur de contournement. Le nombre d'approbations requises est 0 et `strict_required_status_checks_policy` vaut `false`. | Décider si l'on exige des branches à jour ; approbation indépendante impossible sans second mainteneur. Mainteneuse, avant demande de badge |
| `require_2FA`, `secure_2FA`, `osps_ac_01_01` | non vérifié | La lecture du ruleset ne permet pas de vérifier la MFA du compte ni les paramètres d'accès aux ressources sensibles. | Vérifier MFA résistante au phishing et settings du compte ; mainteneuse, avant demande de badge |
| `version_tags`, `signed_releases`, `osps_br_03_02`, `osps_do_03_01`, `osps_do_03_02` | partiel | Une release publiée `spec-v0.0.0-alpha.1` existe, est immuable et n'a aucun asset. `.github/workflows/release.yaml` prévoit un brouillon avec PDF, SHA-256 et attestation Sigstore, mais ce flux révisé n'a pas été exécuté de bout en bout. | Répéter le flux sur une release d'essai/sandbox puis vérifier les attestations avant publication ; mainteneuse, avant prochaine release |
| `release_notes`, `osps_br_04_01` | partiel | La release existante a des notes générées à partir de PR ; le nouveau workflow extrait désormais une section de `spec/CHANGELOG.md`, mais le processus n'a pas encore été éprouvé de bout en bout. | Vérifier le contenu de notes de release lisibles et de sécurité lors de la répétition ; mainteneuse, avant prochaine release |
| `dependency_monitoring`, `osps_qa_02_01` | partiel | Run 37951599075 : 14 paquets extraits, code 0, `No issues found`, SARIF publié dans Code Scanning. La PR ajoute un scan hebdomadaire, mais les exécutions récurrentes et la couverture des avis OSV ne sont pas encore démontrées. L'entrée reste un format de scan personnalisé, non une SBOM SPDX/CycloneDX. | Examiner le premier run planifié, vérifier la couverture des avis et définir le triage ; mainteneuse, après fusion et première exécution hebdomadaire |
| `osps_qa_05_01`, `osps_qa_05_02` | non vérifié | Aucun inventaire exhaustif des binaires et fichiers générés, y compris dans l'historique actif, n'est référencé ici. | Produire un inventaire automatisé et définir une règle de dépôt ; mainteneuse, prochaine vague qualité |
| `dco`, `osps_le_01_01` | non satisfait / décision requise | Aucun mécanisme DCO/CLA n'est actuellement décrit comme obligatoire ; le projet est porté par une seule personne, mais cela ne suffit pas à prouver l'origine légale de contributions futures. | Décider DCO/CLA ou politique proportionnée et mettre en œuvre ; mainteneuse, avant contributions externes substantielles |
| `access_continuity`, `bus_factor`, `osps_qa_07_01` | bloqué structurellement à ce stade | La gouvernance documente une seule mainteneuse ; une approbation indépendante ne peut être simulée par une automatisation. | Identifier une seconde personne de confiance et formaliser la continuité ; mainteneuse, sans échéance fictive |
| `crypto_*` | décision de périmètre requise | La checklist ne démontre pas encore quelles fonctions cryptographiques, TLS, clés ou mots de passe appartiennent aux artefacts livrés. | Inventorier les interfaces et dépendances du produit puis motiver chaque N/A ; mainteneuse, avant auto-évaluation |
| `static_analysis`, `dynamic_analysis`, `test_statement_coverage80` | partiel / à instruire | Lint, avertissements et tests existent ; aucune preuve d'un SAST adapté à Lean ni d'une mesure de couverture statement pertinente n'est enregistrée. | Documenter les outils évalués et leurs limites ; ne pas annoncer de seuil sans mesure, mainteneuse |
| `workflow_static_analysis` | préparé, CI à confirmer | PR en cours : zizmor est ajouté à `security.yaml` pour analyser `.github/`, avec version fixée et résultats non bloquants dans Code Scanning. Ce n'est pas un SAST du code Lean. | Confirmer le job, examiner les constats et documenter les exceptions ; ne pas bloquer avant triage, mainteneuse |


## Ordre de traitement proposé

1. **Valider l'inventaire et les preuves** : confronter les cases pré-cochées aux fichiers et réglages actuels ; contrôler les workflows complets et les paramètres GitHub.
2. **Fermer les écarts documentaires à faible risque** : gouvernance/rôles, critères de contribution, politique de tests, réponse aux vulnérabilités, secrets, releases et instructions de vérification.
3. **Fermer les écarts automatisables** : contrôle de dépendances/SCA, secrets, règles de permissions CI, validation des releases, vérifications de licences et couverture des tests si outil pertinent.
4. **Décider les critères techniques et N/A** : cryptographie, installation, reproductibilité, SAST Lean, fuzzing/analyse dynamique, SBOM et VEX.
5. **Traiter séparément les critères structurels** : continuité, bus factor, contributeurs non associés, revue à deux personnes et MFA. Ne pas simuler une approbation indépendante avec un agent.
6. **Réévaluer les niveaux** : Passing d'abord, puis Silver et Gold ; les Baseline Levels doivent être suivis en parallèle comme référentiel distinct, sans les confondre avec les badges FLOSS Best Practices.
