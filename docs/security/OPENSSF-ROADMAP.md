<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# OpenSSF — registre des travaux encore ouverts

| | |
|---|---|
| État | **PAUSE TEMPORAIRE** au 2026-10-10 |
| Périmètre | Remédiation de sécurité et de chaîne d'approvisionnement du dépôt ; ne vaut ni certification OpenSSF, ni validation humaine de sécurité |
| Règle | Ce registre ne contient que les actions encore ouvertes, partielles, préparées mais non exécutées de bout en bout, ou bloquées |
| Historique | [Plan détaillé archivé au 2026-10-10](../history/2026-10-10-openssf-roadmap-snapshot.md) · [Audit consolidé](OPENSSF-AUDIT.md) · [État de mise en œuvre](IMPLEMENTATION-STATUS.md) |
| Actions humaines | [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md) · [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md) |

## 1. Résultat de la campagne avant la pause

La mainteneuse rapporte que la PR #120 est fusionnée, que `CI OK` passe sur `main`, et que le workflow `Release` a été lancé manuellement sur `main` et a réussi. La PR #121 met à jour la traçabilité de cette répétition ; elle reste volontairement non fusionnée au moment de cette mise à jour.

La répétition manuelle constitue un **essai à blanc**. Elle confirme le chemin de contrôles et de construction exercé par `workflow_dispatch`, notamment le build sans cache. Elle ne prouve pas le déclenchement par tag, la création réelle du brouillon, l'émission et la vérification d'une attestation, la publication, ni l'archivage Zenodo. Les réglages GitHub, du compte et de Zenodo n'ont pas été confirmés par cette exécution.

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

## 5. Règle de pause

La campagne OpenSSF est **mise en pause**, pas déclarée entièrement conforme ni définitivement close. Aucune tâche proactive de remédiation supplémentaire n'est engagée avant sa réouverture explicite, sauf incident de sécurité ou exigence nécessaire à une publication envisagée. Les actions humaines irréversibles ne doivent jamais être exécutées automatiquement.

La question de recherche suivante est séparée : [issue #122 — outils Lean pour l'assurance de conformité de projet](https://github.com/AntheaLiles/k7pl/issues/122). Elle ne constitue pas une revendication de conformité OpenSSF et ne doit pas modifier implicitement la spécification K7PL.
