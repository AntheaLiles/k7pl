<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# OpenSSF Best Practices Badge — état vérifié et automatisation maîtrisée

**Date d'observation : 2026-10-10.** Ce document examine la fiche OpenSSF Best Practices de K7PL et les moyens de proposer des mises à jour. Il ne déclare ni conformité, ni certification, ni obtention d'un niveau du badge.

## 1. État réellement observé

| Objet | État vérifié | Preuve et limite |
|---|---|---|
| Dépôt | Public, branche par défaut `main`, tête `d3dd39b4e4265490b58dd7dba8bfe076a39e7e6f`. | [Commit de tête](https://github.com/AntheaLiles/k7pl/commit/d3dd39b4e4265490b58dd7dba8bfe076a39e7e6f). |
| PR #121 | Fusionnée le 2026-10-10 à 09:45:53 UTC, commit de fusion `7754c4944abb46b6f87d3783c5158b3706542ff2`. | [PR #121](https://github.com/AntheaLiles/k7pl/pull/121). Le registre actif disait encore qu'elle était ouverte. |
| Issue #122 | Ouverte ; la recherche Lean reste distincte du chantier OpenSSF. | [Issue #122](https://github.com/AntheaLiles/k7pl/issues/122). Elle n'autorise pas implicitement des changements de la spécification ou de l'implémentation. |
| PR ouverte #125 | Mise à jour automatique de `docs/STATUS.md`, toujours ouverte. | [PR #125](https://github.com/AntheaLiles/k7pl/pull/125). Ce chantier ne modifie pas cette PR. |
| CI actuelle | Le check `CI OK` a réussi sur `d3dd39b`. | [Run 38053761245](https://github.com/AntheaLiles/k7pl/actions/runs/38053761245). Actionlint, commitlint, gitleaks, REUSE, zizmor, préparation/scan OSV et contrôles rapides ont réussi. Les jobs détaillés Lean/Verso/PDF et Python ont été ignorés pour ce changement documentaire : ce run n'est pas une validation complète de release. |
| Vérification complète planifiée | Le workflow `Full Verification` a réussi le 2026-10-10 sur le commit de fusion `7754c4944abb46b6f87d3783c5158b3706542ff2`. | [Run 38043274260](https://github.com/AntheaLiles/k7pl/actions/runs/38043274260) : implémentation Lean, tests Python, spécification Verso, PDF et résultat global ont tous réussi. Cette preuve s'applique à ce SHA, non au SHA `d3dd39b` du changement documentaire ultérieur. |
| Vérification complète périodique | Le workflow `Full Verification` planifié a réussi le 2026-10-10 sur le commit de fusion `7754c4944abb46b6f87d3783c5158b3706542ff2`. | [Run 38043274260](https://github.com/AntheaLiles/k7pl/actions/runs/38043274260) : implémentation Lean, tests Python, spécification Verso, PDF et résultat de vérification ont tous réussi. Cette preuve s'applique à ce SHA, pas au SHA `d3dd39b` du changement documentaire suivant. |
| Scorecard | Workflow réussi sur la même tête. | [Run 38053760969](https://github.com/AntheaLiles/k7pl/actions/runs/38053760969). Le succès du workflow ne signifie pas que chaque sous-score est satisfaisant. |
| Release manuelle | La répétition `workflow_dispatch` du 2026-10-10 a réussi sur `1d8339b`. | [Run 38037872705](https://github.com/AntheaLiles/k7pl/actions/runs/38037872705). C'est un essai à blanc : aucun tag, brouillon, asset ou bundle d'attestation n'a été testé. |
| Release publiée | `spec-v0.0.0-alpha.1`, publiée le 2026-09-29, immuable, **0 asset**. | [Release](https://github.com/AntheaLiles/k7pl/releases/tag/spec-v0.0.0-alpha.1). Ne prouve pas la livraison du PDF, de son hash, d'une attestation ou d'une archive Zenodo. |
| Ruleset de branche | « PR on main » est actif : PR obligatoire, suppression/force-push interdits, historique linéaire, check `CI OK` requis. Les approbations requises sont à 0 et `strict_required_status_checks_policy=false`. Aucun acteur de contournement n'est déclaré. | [Ruleset 24138119](https://github.com/AntheaLiles/k7pl/rules/24138119), lu via API le 2026-10-10. L'API `branches/main/protection` répond 403 : les autres paramètres administratifs ne sont pas considérés vérifiés. |
| Règles de tags | La lecture `GET /repos/AntheaLiles/k7pl/rulesets?targets=tag` a retourné une liste vide. | Réponse API du 2026-10-10 ; il manque une règle observable protégeant la création/le déplacement des tags. |
| Fiche BadgeApp | `in_progress`, Baseline Level 2, critères `v2026.08.28`. Le nom affiché est **(Name Unknown)** ; nom, description, licence et langages d'implémentation sont vides. URL du site et URL du dépôt déjà renseignées. | [Fiche K7PL](https://www.bestpractices.dev/en/projects/15239/baseline-2). Les réponses n'ont pas été réauditées et enregistrées critère par critère. |
| Badge dans README | Le badge Best Practices est **déjà présent** dans `README.md`. | [README](https://github.com/AntheaLiles/k7pl/blob/main/README.md). Ce n'est plus une action ouverte. |
| Fichiers d'automatisation BadgeApp | Aucun `.bestpractices.json`, `.project.d/bestpractices.json` ou `security-insights.yml` dans l'arbre `main` inspecté. | Arbre Git récursif du 2026-10-10 ; aucune synchronisation K7PL dédiée n'est configurée. |
| Paramètres du compte/secrets/environnements | Non vérifiés exhaustivement. | Ils exigent une lecture d'administration. La documentation versionnée et le succès d'une CI n'établissent pas leurs valeurs. |

## 2. Analyse intégrale de `automation-proposals.md`

Source : [`ossf/best-practices-badge/docs/automation-proposals.md`](https://github.com/ossf/best-practices-badge/blob/main/docs/automation-proposals.md), blob observé `bbb419361123307628a32ebedff906d8b7b870a3`. L'historique GitHub consulté montre notamment un commit du 2026-06-04 (`e54e969f78`, clarification des chemins JSON et des clés OSPS), après l'introduction de la documentation en avril 2026. Le site BadgeApp observé pour K7PL sert la version Baseline `v2026.08.28`. Le document est donc une description vivante de l'implémentation, pas la preuve d'une API versionnée ou d'une compatibilité garantie.

### 2.1 Mécanismes, pertinence et décision

| Proposition | Description et pertinence pour K7PL | Décision |
|---|---|---|
| URL de proposition avec formulaire éditable | Préremplit des champs sur la fiche et les met en évidence. La personne autorisée peut accepter, modifier, ignorer ou rejeter. Aucun enregistrement n'a lieu avant soumission explicite. C'est le mécanisme privilégié pour une aide externe. | **Retenir comme sortie**, jamais comme écriture automatique. |
| Champs non-critères | La documentation cite `name`, `description`, `license` et `implementation_languages`. Ils s'appliquent aux sections du badge. | Pertinents, mais seuls les champs sans ambiguïté peuvent être proposés ; nom/description/licence exigent une décision de périmètre. |
| Champs de critères | `<criterion>_status` et `<criterion>_justification`. Metal emploie les IDs courts (ex. `floss_license`), Baseline emploie des IDs OSPS normalisés en minuscules avec underscores (ex. `osps_ac_03_01`). | Automatiser la préparation et la validation de la paire, après contrôle des IDs et de la version courante du critère. |
| Valeurs de statut | `?`, `N/A`, `Unmet`, `Met`, insensibles à la casse et aux espaces périphériques ; les valeurs invalides sont ignorées. Tous les critères n'autorisent pas `N/A`. | Refuser une proposition invalide. Aucune valeur `Met` sans preuve attachée ; aucun `N/A` sans justification d'applicabilité documentée. |
| Champ existant différent | Par défaut, une proposition n'écrase pas une réponse non inconnue ; la divergence est signalée visuellement. | Garder ce mode non forcé. |
| `overrides` | Paramètre de forçage pouvant remplacer les réponses existantes ; le statut forcé entraîne aussi la justification liée. | **Interdit** dans les outils K7PL. Il permettrait de supplanter un jugement humain. |
| `reanalyze=1` et « Chief » | Relance des automatismes internes de BadgeApp. Ces suggestions restent des sorties de l'application, pas une preuve indépendante. | Ne pas déclencher par défaut ; examiner toute suggestion avant de la retenir. |
| `.bestpractices.json` | Accepté à la racine ou dans `.project.d/`. Dans ce fichier, `?` / `unknown` signifient « aucune information » et sont ignorés, contrairement à `?` dans une URL qui réinitialise explicitement une réponse. | Potentiellement utile après ratification des faits. Ne pas l'introduire maintenant : il deviendrait une source de déclarations prématurées. |
| `security-insights.yml` | Autre source potentielle de propositions examinée par BadgeApp. | Non retenu pour l'instant : fichier absent, valeur additionnelle non démontrée et risque de redondance. |
| API REST GET | `GET /projects/NUMBER.json` permet de relire l'état sauvegardé. La documentation API encourage la lecture. | Prévoir une vérification après soumission humaine. Le lecteur Web utilisé pendant cet audit n'a pas pu récupérer directement cet endpoint JSON ; son contenu n'est donc pas cité comme observé. |
| API REST PUT | Permet des modifications authentifiées, mais le projet BadgeApp indique préférer les propositions relues, précisément car REST contourne l'interface de revue. | **Ne pas utiliser** pour mettre à jour la fiche K7PL. |

### 2.2 Détails de validation et de comportement

- Avec l'ID connu, le lien d'entrée documenté est [`/en/projects/15239/choose/edit`](https://www.bestpractices.dev/en/projects/15239/choose/edit). La forme sans ID permet de fournir `as=edit` et l'URL du projet encodée ; la page retrouve la fiche et redirige vers la section choisie.
- Les valeurs de query string doivent être encodées en UTF-8. Les champs sont validés en fonction de la section : un champ inconnu ou hors section peut être silencieusement ignoré. Un futur générateur doit vérifier les IDs contre la source actuelle des critères, et non seulement normaliser les libellés.
- Les statuts et justifications sont couplés : pas de statut proposé avec une justification qui décrit un autre statut. N'envoyer ni justification vide ambiguë, ni preuve générique si une URL ou un artefact exact est disponible.
- L'enregistrement humain est la limite de confiance : ni l'URL générée, ni la fiche préremplie, ni une analyse automatique ne signifient que l'état a été sauvegardé ou que le critère est effectivement satisfait.
- La documentation `automation-proposals.md` ne suffit pas à conclure que la syntaxe reste stable pour toujours. Au moment de chaque usage, relever la date/version de critères affichée et vérifier les IDs réellement acceptés.

## 3. Métadonnées : source de vérité, contrôle de cohérence et synchronisation

| Champ | État externe actuel | Source candidate et contrôle nécessaire |
|---|---|---|
| `name` | Vide ; `(Name Unknown)`. | `README.md` : « K7PL - KonSept Programming Language » ; `CITATION.cff:title` : « K7PL - KonSept Programming Language's Specification ». **Décision humaine requise** : le badge couvre-t-il le projet langage ou la spécification comme livrable principal ? |
| `description` | Vide. | README, site Pages et `CITATION.cff:abstract`. La citation précise qu'aucune conformité de la spécification à l'implémentation n'est revendiquée. Préparer un texte bref qui n'insinue pas que le langage est complet ou que sa conformité est prouvée ; approbation humaine nécessaire. |
| `license` | Vide. | `LICENSE.md`, `LICENSES/`, `REUSE.toml`, `CITATION.cff:license`. La politique distingue CeCILL-2.1 (logiciel), CeCILL-C (bibliothèques K7PL), CC-BY-4.0 (spécification/documentation) et CC0-1.0 (infrastructure/métadonnées). Ne pas réduire à une licence unique avant de fixer le périmètre du produit déclaré. |
| `implementation_languages` | Vide. | Calcul reproductible depuis les fichiers de la tête Git auditée, par GitHub Linguist / API des langages ou méthode équivalente documentée, puis contrôle humain des langages qui comptent comme implémentation. La lecture de l'endpoint de statistiques langages n'a pas été permise par le connecteur courant : aucun ordre des langages n'est inventé ici. |
| URL du site | Déjà renseignée. | `CITATION.cff:url` et README : `https://anthealiles.github.io/k7pl/`. Contrôle de cohérence automatisable ; pas une cible de la query string documentée. |
| URL du dépôt | Déjà renseignée. | `CITATION.cff:repository-code` et README : `https://github.com/AntheaLiles/k7pl`. Contrôle de cohérence automatisable ; pas une cible de la query string documentée. |

### 3.1 Contrat de synchronisation recommandé

1. **Sources de vérité** : faits vérifiables dans les fichiers du dépôt et dans les observations datées de GitHub ; décision ratifiée pour le périmètre du projet. Aucune heuristique de nommage ou de langage ne tranche une décision de fond.
2. **Registre des preuves** : identifiant de critère tel qu'il existe dans la version active, statut candidat, justification, chemin/URL, SHA Git, date de contrôle, run CI pertinent, limites connues et nature de la preuve (automatique, documentaire ou humaine).
3. **Sortie** : rapport CI et, si l'on a assez d'informations, URL de proposition non forcée. Aucun jeton BadgeApp en CI, aucune écriture REST, aucune validation de formulaire automatisée.
4. **Cohérence** : vérifier l'alignement README/CFF/licences ; refuser de produire la proposition si le nom, le périmètre, la licence ou les langages sont contradictoires ; valider le champ, la section, la valeur du statut et la justification.
5. **Déclencheurs** : commencer par une action manuelle. Après stabilisation, exécuter un contrôle à la modification des fichiers sources concernés et, si utile, périodiquement pour signaler les dérives. La CI signale ; elle ne corrige pas la fiche.
6. **Post-enregistrement** : l'autrice soumet dans le formulaire, puis vérifie la fiche publique et son export JSON depuis un client qui y accède. Enregistrer l'écart entre proposition et réponse réellement sauvegardée.
7. **Preuves à conserver** : SHA du dépôt, IDs et URLs des runs, version/date des critères, rapport de propositions, URL générée sans cookie/session, décision humaine et instantané post-soumission. Ne jamais stocker les identifiants ou sessions.
8. **Manifeste futur** : `.bestpractices.json` peut être ajouté lorsque les réponses ont une source de vérité stable ; il doit être une projection contrôlée de faits ratifiés, pas une seconde source concurrente.

## 4. Matrice de conformité — points immédiatement vérifiables

La matrice critère par critère, reprenant tout l'inventaire interne Passing/Silver/Gold et OSPS Baseline L1–L3, est dans [`BADGE-CONFORMANCE-MATRIX.md`](BADGE-CONFORMANCE-MATRIX.md). Le tableau ci-dessous détaille les sujets prioritaires qui déterminent directement la suite. « Satisfait » porte seulement sur la propriété précisée ; cela ne signifie pas que la réponse est enregistrée sur BadgeApp.

| Critère / sujet | Statut | Preuve du 2026-10-10 ou preuve source | Limite |
|---|---|---|---|
| Métadonnée `name` | ACTION HUMAINE REQUISE | Fiche BadgeApp `(Name Unknown)`, README et CFF portent des titres différents. | Décider si l'objet du badge est le projet langage ou la spécification. |
| Métadonnée `description` | ACTION HUMAINE REQUISE | Champ externe vide ; résumé de CFF limite explicitement les revendications. | Rédiger et valider une description factuelle. |
| Métadonnée `license` | ACTION HUMAINE REQUISE | Champ externe vide ; politique multi-licences dans `LICENSE.md`. | Définir d'abord le périmètre déclaré. |
| Métadonnée `implementation_languages` | À VÉRIFIER | Champ externe vide ; mesure de composition non accessible pendant cette vérification. | Calculer et relire les langages et leur ordre. |
| `repo_public`, `repo_track` | SATISFAIT | API GitHub, visibilité publique, tête Git `d3dd39b` observées le 2026-10-10. | Séparer la preuve du dépôt de la réponse sauvegardée du badge. |
| `contribution` | SATISFAIT | `CONTRIBUTING.md`, flux public issues/PR et check CI observés le 2026-10-10. | Revalider la réponse de la fiche avec le critère courant. |
| `license_location` | SATISFAIT | `LICENSE.md`, `LICENSES/`; REUSE réussi dans [CI 38053761245](https://github.com/AntheaLiles/k7pl/actions/runs/38053761245). | Ne décide pas la métadonnée `license` unique. |
| `build`, `test_continuous_integration` | SATISFAIT | Workflows versionnés ; check `CI OK` réussi dans [run 38053761245](https://github.com/AntheaLiles/k7pl/actions/runs/38053761245). | Les jobs Lean/Verso/PDF étaient ignorés dans ce run documentaire ; ne pas en déduire un build complet sur ce SHA. |
| `warnings` | PARTIEL | Options strictes dans `lakefile.lean` ; cibles Lean ignorées dans le run CI actuel. | Citer/rejouer l'exécution complète la plus récente après modification de code pertinente. |
| `version_unique` / `osps_br_02_01` | PARTIEL | Release `spec-v0.0.0-alpha.1` unique, immuable, publiée le 2026-09-29. | `CITATION.cff` annonce `0.0.0-alpha.2` ; l'écart de fraîcheur doit être traité avant la prochaine release. |
| `release_notes` / `osps_br_04_01` | NON SATISFAIT | [Release actuelle](https://github.com/AntheaLiles/k7pl/releases/tag/spec-v0.0.0-alpha.1) sans asset ; notes à revoir dans D10. | Revue humaine des notes existantes ; aucune publication n'est engagée. |
| `signed_releases` / `osps_br_06_01` | NON SATISFAIT | La release a zéro asset ; le run manuel [38037872705](https://github.com/AntheaLiles/k7pl/actions/runs/38037872705) n'a créé aucune attestation. | Tester un tag contrôlé, puis vérifier indépendamment le brouillon et l'attestation. |
| `dependency_monitoring` / OSV | PARTIEL | Préparation/scan OSV réussi dans le [run CI 38053761245](https://github.com/AntheaLiles/k7pl/actions/runs/38053761245). | Un scan sans avis n'établit ni continuité, ni couverture exhaustive, ni triage durable. |
| `no_leaked_credentials` | PARTIEL | Gitleaks réussi dans le run CI 38053761245. | Le succès ne prouve pas la configuration de secret scanning ou l'absence de secrets déjà compromis. |
| `static_analysis` | PARTIEL | lint Lean et zizmor des workflows présents ; job zizmor réussi dans le run 38053761245. | zizmor audite les workflows, pas le code Lean en tant que SAST ; les rapports d'agents ne constituent pas une revue humaine. |
| `osps_ac_03_01` | SATISFAIT | Ruleset actif, règle `pull_request`, lecture API du 2026-10-10. | Les approbations humaines restent à zéro. |
| `osps_ac_03_02` | SATISFAIT | Règle `deletion` du même ruleset. | Les autres paramètres de protection ne sont pas tous observés. |
| `osps_qa_03_01` | PARTIEL | Le ruleset exige `CI OK`. | `strict_required_status_checks_policy=false` : la mise à jour de branche stricte n'est pas imposée. |
| `osps_qa_06_01` | SATISFAIT | PR obligatoire, check `CI OK` requis et réussi le 2026-10-10. | Réévaluer la liste de checks réellement couverte à toute évolution de CI. |
| `osps_qa_02_02` (SBOM pour artefacts) | NON SATISFAIT | Prototype SPDX 2.3 non validé par parseur indépendant et non intégré à la release, selon le registre actif. | Valider la sortie, examiner les limites et décider séparément de l'intégration. |
| `require_2FA`, `osps_ac_01_01` | ACTION HUMAINE REQUISE | Paramètres d'authentification non observés par l'API disponible. | Vérifier les réglages administratifs et consigner le constat sans divulguer de données sensibles. |
| `two_person_review`, `bus_factor` | NON SATISFAIT | Gouvernance et registre indiquent une mainteneuse unique, sans revue humaine indépendante. | Nécessite une évolution de l'équipe ; ne pas simuler une revue. |
| `dco`, `security_review`, `osps_sa_03_01` | ACTION HUMAINE REQUISE | Décisions D9 et registre de revue non ratifiés ; les rapports d'agents ne valent pas revue humaine. | Décider/conduire et dater la revue avant toute déclaration. |
| Reproductibilité PDF / `build_reproducible` | PARTIEL | Paramètres déterministes existent, mais le bundle TeX n'est pas épinglé/validé et aucune double compilation PDF indépendante n'est prouvée. | Interdiction de déclarer la reproductibilité avant preuve comparative. |

Aucun `N/A` n'est décidé maintenant : la définition du produit livré doit être ratifiée avant d'exclure des critères relatifs à la cryptographie, à l'installation, aux interfaces ou au déploiement.

## 5. Plan d'action priorisé

### P0 — avant toute publication
1. Tester le vrai événement de tag dans un cadre contrôlé ; vérifier appartenance à `main`, check `CI OK`, reconstruction sans cache, création du brouillon avec PDF/hash/attestation et vérification locale.
2. Trancher D1/D2/D5/D10 : origine du DOI, canal Zenodo, métadonnées figées et notes de release ; répéter sur sandbox avant toute écriture en production.
3. Vérifier avec droits administratifs les environnements `zenodo` / `bump-lean`, protections, secrets, tags, 2FA et permissions réelles. Cette PR ne modifie aucun paramètre sensible.
4. Valider la sortie du prototype SPDX par un parseur indépendant avant toute revendication ou intégration.

### P1 — déclarer honnêtement le projet
1. Ratifier le périmètre ; résoudre `name`, `description` et `license`, puis calculer les langages de manière reproductible.
2. Revoir tous les critères du profil, section par section, avec preuves datées ; ne choisir `N/A` que si le critère le permet et que l'applicabilité est argumentée.
3. Traiter les décisions de gouvernance, DCO, restrictions d'agents, approbation stricte, continuité et revue de sécurité humaine.

### P2 — automatiser sans modifier les déclarations
1. Après décision, générer une URL de proposition et un rapport local ; tester l'encodage URL, les IDs autorisés, le couplage statut/justification et l'interdiction de `overrides`.
2. Ajouter un contrôle CI non bloquant de dérive des métadonnées source. Il émet une alerte et une proposition ; il ne pousse aucune réponse vers BadgeApp.
3. N'introduire `.bestpractices.json` ou `security-insights.yml` que si un contrat de source de vérité est stable et validé.

### P3 — continuité
1. Vérifier la répétition des scans OSV, le comportement en cas d'échec et le triage des avis.
2. Conserver les rapports Scorecard/zizmor avec leur commit et l'ID du run ; distinguer audit de workflows et SAST du produit Lean.
3. Réévaluer après changement des critères ; enregistrer la version du critère et la date.

| Automatisable après revue | Décision humaine / droits nécessaires |
|---|---|
| Produire des rapports/URLs de proposition, contrôler les fichiers sources, valider les IDs et l'encodage, détecter une dérive, archiver les preuves CI, lancer un parseur SPDX indépendant. | Définir le produit visé, ratifier les métadonnées, enregistrer les réponses, décider des `N/A`, vérifier paramètres 2FA/secrets/environnements/tags, choisir le DOI, publier, valider les notes, conduire et signer une revue de sécurité. |

## 6. Sources primaires

- [Automation proposals](https://github.com/ossf/best-practices-badge/blob/main/docs/automation-proposals.md), blob `bbb419361123307628a32ebedff906d8b7b870a3`.
- [API BadgeApp](https://github.com/ossf/best-practices-badge/blob/main/docs/api.md), [critères Metal](https://www.bestpractices.dev/en/criteria), [fiche Baseline Level 2 K7PL](https://www.bestpractices.dev/en/projects/15239/baseline-2).
- [CI actuelle](https://github.com/AntheaLiles/k7pl/actions/runs/38053761245), [Scorecard actuel](https://github.com/AntheaLiles/k7pl/actions/runs/38053760969), [répétition Release](https://github.com/AntheaLiles/k7pl/actions/runs/38037872705), [release existante](https://github.com/AntheaLiles/k7pl/releases/tag/spec-v0.0.0-alpha.1).
- Registres du dépôt : [OPENSSF-ROADMAP.md](OPENSSF-ROADMAP.md), [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md), [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md), [OPENSSF-CHECKLIST.md](../tracking/OPENSSF-CHECKLIST.md).
