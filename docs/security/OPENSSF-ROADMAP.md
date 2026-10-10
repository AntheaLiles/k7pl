<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# OpenSSF — registre des travaux encore ouverts

| | |
|---|---|
| État | **REPRISE EN COURS** au 2026-10-10 — actions documentaires et vérifications sûres actives ; opérations sensibles toujours soumises à autorisation |
| Périmètre | Remédiation de sécurité et de chaîne d'approvisionnement du dépôt ; ne vaut ni certification OpenSSF, ni validation humaine de sécurité |
| Règle | Ce registre ne contient que les actions encore ouvertes, partielles, préparées mais non exécutées de bout en bout, ou bloquées |
| Historique | [Plan détaillé archivé au 2026-10-10](OPENSSF-ROADMAP-HISTORY-2026-10-10.md) · [Audit consolidé](OPENSSF-AUDIT.md) · [État de mise en œuvre](IMPLEMENTATION-STATUS.md) · [Analyse du badge](BADGE-AUTOMATION.md) · [Matrice critère par critère](BADGE-CONFORMANCE-MATRIX.md) |
| Actions humaines | [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md) · [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md) |

## 1. Résultat vérifié à la reprise

La PR #121 a été fusionnée le 2026-10-10 à 09:45:53 UTC (merge commit `7754c4944abb46b6f87d3783c5158b3706542ff2`). La tête `main` auditée est `d3dd39b4e4265490b58dd7dba8bfe076a39e7e6f`. Le run CI [38053761245](https://github.com/AntheaLiles/k7pl/actions/runs/38053761245) et le run Scorecard [38053760969](https://github.com/AntheaLiles/k7pl/actions/runs/38053760969) sont réussis sur cette tête ; les tests détaillés Lean/Verso/PDF et l'outillage Python ont été ignorés dans ce run documentaire.

La répétition `Release` `workflow_dispatch` du 2026-10-10 ([run 38037872705](https://github.com/AntheaLiles/k7pl/actions/runs/38037872705), commit `1d8339b`) est un essai à blanc : aucun événement de tag n'a été testé et aucun brouillon, asset ou bundle d'attestation n'a été créé. La release publique `spec-v0.0.0-alpha.1` du 2026-09-29 est immuable et contient zéro asset. L'archivage Zenodo n'a pas été éprouvé de bout en bout.

Le ruleset de branche `PR on main` a été relu via API le 2026-10-10 : PR obligatoire, check `CI OK`, historique linéaire, aucune approbation requise et contrôles de statut non stricts. La lecture API de la protection de branche renvoie 403 ; aucun ruleset de tags n'est retourné par l'endpoint consulté. Ces limites sont inscrites dans la nouvelle analyse [BADGE-AUTOMATION.md](BADGE-AUTOMATION.md).

Le profil BadgeApp K7PL reste `in_progress` : les métadonnées de nom, description, licence et langages sont vides ; les URLs du site et du dépôt sont déjà présentes. Le badge est déjà affiché dans `README.md`. La [matrice critère par critère](BADGE-CONFORMANCE-MATRIX.md) et le registre humain distinguent les preuves du dépôt des réponses effectivement enregistrées sur BadgeApp.

## 2. Registre actif : uniquement les écarts non clos

| ID | Sujet | État | Ce qui manque pour clore honnêtement |
|---|---|---|---|
| R1 | Flux de release : tag, contrôles, reconstruction sans cache, brouillon avec PDF, somme et attestation | PARTIAL | Essai contrôlé sur un tag de test, création du brouillon, vérification locale de l'attestation ; aucune publication réelle sans validation humaine préalable |
| R3 | Publication Zenodo et synchronisation des artefacts | PREPARED | Décision D1 sur l'origine et l'identifiant du DOI ; environnement protégé ; tests et répétition sur le sandbox Zenodo |
| R4 | Mise à jour automatique de Lean (`bump-lean`) | PREPARED | Environnement protégé ; examen des permissions et du manifeste ; exécution réelle lors d'un bump admissible |
| R5 | Paramètres de sécurité GitHub et du compte | HUMAN ACTION REQUIRED | Vérifier règles de tags, protections d'environnements, secrets, permissions Actions, secret scanning, 2FA et continuité d'accès ; consigner les observations |
| R6 | Déclenchement réel de la release par tag et contrôle d'appartenance à `main` / `CI OK` | PARTIAL | Tester le chemin d'événement tag dans des conditions contrôlées ; le succès de `workflow_dispatch` ne suffit pas |
| R7 | Limitation des capacités de fusion et d'écriture des agents | HUMAN ACTION REQUIRED | Décision D3, mise en œuvre explicite dans `.claude/settings.json` et vérification du comportement des agents ; ne pas confondre convention et garantie technique |
| R11 | Reproductibilité du PDF | PARTIAL | Le PDF n'est pas démontré reproductible ; pinner et vérifier le bundle TeX puis comparer des compilations indépendantes avant toute revendication |
| R13 | Documentation publique du parcours de release | PARTIAL | Relecture finale de README, CONTRIBUTING, SECURITY, CHANGELOG et documentation des workflows à la lumière du parcours réel ; ne pas décrire la release comme éprouvée de bout en bout |
| R14 | Revue de sécurité humaine et validation des revendications | HUMAN ACTION REQUIRED | Revue personnelle, datée et signée par la mainteneuse ; les rapports d'agents ne constituent pas une revue indépendante |
| R21 | Épinglage et vérification du bundle TeX de Tectonic | BLOCKED | Source d'artefact et empreinte de confiance indépendamment vérifiables ; la tentative précédente était bloquée par l'accès réseau de la session |
| R25 | Prototype SBOM SPDX 2.3 | PARTIAL | Générer le document sur le manifeste courant, le valider avec un parseur/validateur SPDX indépendant, examiner les résultats et décider séparément s'il doit entrer dans la release |
| R27 | Surveillance des vulnérabilités des dépendances Lake par OSV-Scanner | PARTIAL | Confirmer plusieurs exécutions planifiées, le comportement en cas d'échec et le traitement des avis ; le premier scan sans résultat n'est pas une preuve de couverture durable |
| R28 | Fiche Best Practices BadgeApp : métadonnées et réponses par critère | PARTIAL / ACTION HUMAINE REQUIRED | Valider le périmètre du produit ; décider nom, description, licence ; mesurer les langages ; examiner les preuves par critère et enregistrer explicitement les réponses. La fiche actuelle est `in_progress`, avec quatre métadonnées vides. Voir `BADGE-AUTOMATION.md` et `BADGE-CONFORMANCE-MATRIX.md`. |

## 3. Décisions humaines encore à traiter

Les décisions ouvertes restent consignées dans [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md). Les plus sensibles avant toute publication sont :

- **D1** — établir l'origine du DOI Zenodo et choisir un canal de publication unique ;
- **D2** — confirmer la procédure de publication humaine en deux temps et conserver l'immuabilité ;
- **D3** — décider et appliquer les restrictions des agents ;
- **D5** — valider la formulation des métadonnées publiques avant leur archivage irréversible ;
- **D6** — décider si les checks de `main` doivent être stricts ;
- **D7** — borner explicitement la revendication de reproductibilité ;
- **D9** — valider gouvernance, langue des signalements, DCO et canal du code de conduite ;
- **D10** — terminer les notes de release et l'état pre-release de la version de spécification ;
- **D11** — trancher la conception et les permissions du job `status`.

L'essai de zizmor est maintenant réalisé dans la CI ; la question encore ouverte est son éventuel caractère bloquant, pas son introduction initiale.

## 4. Travaux différés, hors du registre actif

Les idées non engagées — double compilation quotidienne, remplacement de `lean-action`, `lean4checker`, tags signés, fuzzing et tests par propriétés — ne sont pas des actions de la campagne en cours. Elles restent dans le snapshot historique pour ne pas gonfler le registre actif. Elles ne sont ni déclarées accomplies, ni engagées pour la prochaine étape.

## 5. Pilotage et limites de la reprise

La campagne reprend à la demande de la mainteneuse le 2026-10-10. Les corrections de suivi et les vérifications non sensibles sont actives dans cette branche. La reprise ne vaut pas autorisation de modifier des paramètres administratifs, déplacer des secrets, publier une release, créer un tag de production ou enregistrer des changements irréversibles dans Zenodo ou BadgeApp.

Toute proposition de statut de conformité doit être reliée à une preuve précise et datée. Aucun critère ne devient `SATISFAIT` par ajout de documentation seule ; aucune revue d'agent ne remplace une revue humaine responsable. Ne pas fusionner la PR issue de cette campagne sans l'autorisation de la mainteneuse.

La recherche suivante reste distincte : [issue #122 — outils Lean pour l'assurance de conformité de projet](https://github.com/AntheaLiles/k7pl/issues/122). Elle n'autorise aucune modification implicite de la spécification K7PL.