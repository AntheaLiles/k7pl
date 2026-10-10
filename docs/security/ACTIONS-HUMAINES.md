<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Actions humaines — parcours de clôture OpenSSF

| | |
|---|---|
| État | **À dérouler** : l'automatisation locale est préparée dans la PR [#129](https://github.com/AntheaLiles/k7pl/pull/129), mais la campagne OpenSSF n'est pas close. |
| Profil externe | [K7PL sur Best Practices](https://www.bestpractices.dev/en/projects/15239/baseline-2) — dernier état vérifié le 2026-10-10 : in_progress, baseline v2026.08.28, métadonnées de nom, description, licence et langages vides. |
| Mode d'emploi | Suivre les phases dans l'ordre. Ne cocher une case qu'après observation effective ; inscrire la preuve, la date et la décision dans le registre approprié. |
| Registres | [État opérationnel](OPENSSF-ROADMAP.md) · [Décisions D1–D11](DECISIONS-REQUISES.md) · [Analyse BadgeApp](BADGE-AUTOMATION.md) · [Matrice des critères](BADGE-CONFORMANCE-MATRIX.md) |

Cette liste est centrée sur les gestes, décisions et preuves qui exigent la mainteneuse. Les cases de la matrice ne sont pas des réponses enregistrées sur BadgeApp. Les rapports d'agents ne constituent pas une revue de sécurité humaine. La réussite de la CI ne prouve ni un réglage administrateur ni une publication de bout en bout.

## 0. Valider puis intégrer le socle

- [ ] **Relire et intégrer la PR #129** uniquement lorsque son dernier commit a une CI verte et que le diff est accepté. La PR reste ouverte ; aucun merge n'a été effectué par cette campagne.
- [ ] **Après fusion**, lancer une fois le workflow Security sur la branche main via GitHub Actions, ou attendre sa prochaine exécution planifiée. Vérifier que le job « Detect upstream BadgeApp criteria drift » s'exécute réellement et produit l'artefact JSON attendu.
  - unchanged : consigner la date et le SHA amont observé.
  - drift : comparer les définitions officielles, examiner leurs effets, puis proposer une mise à jour du registre dans une PR ; ne jamais régénérer silencieusement le snapshot.
  - unavailable : résultat inconclusif, pas une preuve d'absence de dérive.
- [ ] Après fusion, examiner plusieurs exécutions planifiées d'OSV-Scanner, traiter les avis éventuels et consigner le triage. Un premier scan sans résultat ne démontre pas une surveillance durable.

## 1. Compléter la fiche Best Practices BadgeApp

1. [ ] Ratifier le **périmètre du logiciel produit par le projet** avant de choisir les champs ou déclarer un critère non applicable. Voir l'annexe D de [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md).
2. [ ] Déterminer le nom public et la description à partir du projet réel ; vérifier la licence applicable aux artefacts ; mesurer les langages d'implémentation selon la définition BadgeApp plutôt que de les deviner.
3. [ ] Parcourir la [matrice critère par critère](BADGE-CONFORMANCE-MATRIX.md). Pour chaque critère, décider Met, Unmet ou N/A seulement sur la base de sa définition officielle et d'une preuve directe, datée et vérifiable. Un N/A doit être permis par la définition du critère et justifié par le périmètre ratifié.
4. [ ] Pour les réponses candidates, préparer une proposition selon le schéma de [BADGE-AUTOMATION.md](BADGE-AUTOMATION.md) et la valider avec le script scripts/ci/check_badge_proposals.py. Relire intégralement l'URL générée et chaque preuve avant de l'ouvrir.
5. [ ] Soumettre les choix **manuellement** dans [l'interface BadgeApp](https://www.bestpractices.dev/en/projects/15239/choose/edit). Ne pas utiliser les contrôles de forçage ni une écriture REST directe.
6. [ ] Après sauvegarde, relire la fiche et son export JSON depuis un accès réseau fonctionnel ; consigner la date, les réponses effectivement retenues et les éventuels écarts. Ne pas confondre proposition générée, réponse envoyée et réponse visible sur le site.

## 2. Vérifier le compte, les permissions et les paramètres GitHub

À réaliser avant tout essai de publication ou toute revendication fondée sur les réglages du dépôt.

- [ ] **Compte GitHub et Zenodo** : vérifier une 2FA résistante à l'hameçonnage, conserver des codes de récupération et documenter une procédure sûre de continuité/rotation d'accès.
- [ ] **Protection de main** : relire le ruleset actif. Décider explicitement D6 sur l'exigence de branche à jour (strict_required_status_checks_policy). Le réglage observé était false, avec zéro approbation requise ; ne pas présenter cette configuration comme une revue indépendante.
- [ ] **Règles de tags** : vérifier ou créer des règles couvrant spec-v* et v*, qui protègent création, mise à jour et suppression, interdisent les force-push et limitent le contournement. Aucun ruleset de tags n'a été confirmé par l'audit disponible.
- [ ] **Environnements** : configurer et protéger zenodo (tags de spécification uniquement) et bump-lean (branche main uniquement) ; vérifier la portée de github-pages.
- [ ] **Secrets et jetons** : déplacer les secrets de publication vers les environnements, puis supprimer les copies au niveau du dépôt ; remplacer/faire tourner BUMP_TOKEN vers un jeton limité au dépôt k7pl, avec uniquement Contents et Pull requests en lecture-écriture, sans permission Workflows et avec une expiration d'au plus 90 jours. Ne jamais afficher les valeurs de secrets dans les preuves.
- [ ] **Actions** : vérifier les permissions par défaut en lecture seule, l'approbation des workflows de forks externes et l'autorisation requise par le job status pour ouvrir sa PR générée. Ne pas désactiver l'autorisation de créer des PR sans adapter ce job.
- [ ] **Détection de menaces** : vérifier Secret scanning, Push protection et Dependabot alerts ; examiner les alertes et consigner le résultat sans publier de valeur sensible.
- [ ] **Capacités des agents (D3)** : décider les restrictions dans .claude/settings.json et les rôles des agents. Ne pas confondre instructions documentaires, configuration d'outils et garantie de sécurité ; vérifier le comportement obtenu.
- [ ] **Continuité d'accès** : vérifier les propriétaires et accès sensibles, l'accès Zenodo/ORCID et la récupération de compte. Le réglage « successor » de GitHub ne suffit pas à lui seul à assurer une continuité opérationnelle.

Les commandes de vérification API, les champs observés et les limites connues figurent dans [SECRETS-POLICY.md](SECRETS-POLICY.md) et [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md).

## 3. Ratifier les choix de gouvernance et les affirmations publiques

- [ ] **D9 — Gouvernance** : valider les rôles, les langues acceptées pour les signalements, le canal effectif du code de conduite et la décision DCO/CLA. Vérifier les liens et canaux réellement utilisables.
- [ ] **D5 — Métadonnées de publication** : corriger ou ratifier avant publication la formulation prétendant que la spécification a été vérifiée contre « l'implémentation de référence ». La preuve actuelle ne permet pas d'affirmer une correspondance spécification–implémentation qui n'a pas été observée.
- [ ] **D10 — Notes de version** : relire les notes de spec-v0.0.0-alpha.1 et décider la correction du changelog. La release existante est immuable ; ne pas tenter de la réparer en remplaçant tag ou assets.
- [ ] **D7 — Reproductibilité** : choisir l'ambition à poursuivre. Le PDF n'est pas démontré reproductible ; ne pas l'affirmer avant d'avoir épinglé et vérifié le bundle TeX, puis comparé des compilations indépendantes.
- [ ] **D8 — zizmor** : après examen des constats Code Scanning, décider séparément si le contrôle doit devenir bloquant. Ne pas le rendre bloquant uniquement pour augmenter un score.
- [ ] **D4 — Nom de fichier de la politique** : conserver l'explication de l'artefact de mesure, sauf décision explicite de renommage. Un changement destiné uniquement au score ne doit pas être présenté comme un gain de sécurité.
- [ ] **D11 — Job status** : relire ses permissions, son usage de credentials persistants et son mécanisme de poussée forcée ; décider si la conception doit évoluer, tout en conservant le fonctionnement utile de la PR de statut générée.

## 4. Éprouver release et Zenodo, sans publier prématurément

Ne pas démarrer cette phase avant les décisions D1/D5/D7/D10 et la configuration des environnements, secrets et règles de tags.

1. [ ] **D1 — DOI** : examiner l'enregistrement 10.5281/zenodo.23040451, établir son origine, déterminer s'il s'agit d'un DOI de concept ou de version et identifier son contenu. Choisir un seul canal de synchronisation (intégration native GitHub–Zenodo ou flux CI) et consigner le choix dans docs/tracking/DECISIONS.md.
2. [ ] Répéter sur le **sandbox Zenodo** le parcours contrôlé par un tag d'essai : contrôle du commit et de CI OK, build sans cache, brouillon contenant PDF, somme SHA-256 et bundle d'attestation, vérification locale puis nettoyage du brouillon et du tag d'essai avant toute publication.
3. [ ] Vérifier l'attestation depuis une machine avec accès réseau fonctionnel :
   ~~~sh
   gh attestation verify k7pl-spec.pdf --repo AntheaLiles/k7pl --bundle k7pl-spec.pdf.sigstore.json --signer-workflow AntheaLiles/k7pl/.github/workflows/release.yaml --source-ref refs/tags/spec-vX.Y.Z --source-digest "$(git rev-parse spec-vX.Y.Z^{commit})" --deny-self-hosted-runners
   ~~~
4. [ ] Relire les métadonnées et toutes les pièces du brouillon avant la publication ; vérifier le comportement d'archivage Zenodo et la provenance.
5. [ ] Seulement après résultat probant et décision explicite, effectuer la publication réelle. Le tag et les assets immuables ne sont pas réutilisables ; une erreur publiée requiert une nouvelle version.

La répétition workflow_dispatch précédente était un essai à blanc : elle n'a créé ni brouillon, ni asset, ni bundle d'attestation et n'a pas exercé le déclencheur réel par tag.

## 5. Fermer les critères qui exigent une preuve humaine ou une validation différée

- [ ] **Revue de sécurité humaine (Gold)** : conduire une revue personnelle, datée et signée couvrant exigences et frontières de sécurité. Les audits d'agents et le modèle de menace ne suffisent pas. Ne pas créer un fichier attestant cette revue avant de l'avoir réellement faite.
- [ ] **Preuves temporelles** : relever les délais de réponse aux rapports et vulnérabilités sur les fenêtres exigées ; une absence de données ou une seule exécution ne satisfait pas automatiquement ces critères.
- [ ] **OSV-Scanner** : après plusieurs exécutions planifiées sur main, documenter la couverture effective, le traitement des alertes et les éventuels échecs.
- [ ] **PDF/TeX** : si l'ambition de reproductibilité est retenue, obtenir une provenance vérifiable du bundle, épingler son empreinte et exécuter les comparaisons indépendantes avant de fermer R11/R21.
- [ ] **SBOM/SPDX (R25)** : garder ce prototype dans son chantier technique distinct ([issue #122](https://github.com/AntheaLiles/k7pl/issues/122)). Ne le qualifier ni de validé ni de conforme tant qu'un validateur SPDX indépendant n'a pas accepté le document généré et que le périmètre des artefacts couverts n'est pas établi.
- [ ] Après chaque série de décisions, mettre à jour la [matrice](BADGE-CONFORMANCE-MATRIX.md) en conservant séparées preuve du dépôt, preuve d'exploitation, réglage externe et jugement humain ; refaire une passe finale avant toute demande de niveau.

## Conditions de clôture

La campagne ne sera close qu'une fois les preuves humaines et externes enregistrées, les décisions ouvertes ratifiées, la fiche BadgeApp vérifiée après sauvegarde et les essais de publication documentés. La CI verte est nécessaire, mais elle ne remplace aucune de ces conditions.
