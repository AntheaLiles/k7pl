<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# OpenSSF / CII Best Practices — état opérationnel

| | |
|---|---|
| État | **Automatisation #129 fusionnée ; actions humaines et preuves d'exploitation encore ouvertes** |
| Périmètre | Sécurité du dépôt, chaîne de construction/publication et préparation de l'auto-évaluation BadgeApp. Ne vaut ni certification ni revue humaine. |
| Trace de la dernière vague | [PR #129](https://github.com/AntheaLiles/k7pl/pull/129) fusionnée le 2026-10-10 à 17:09:57 UTC. HEAD `main` observé : [`86959948`](https://github.com/AntheaLiles/k7pl/commit/86959948ff36deb6e8ee0985cf22740787696720). Le run [CI #38094667153](https://github.com/AntheaLiles/k7pl/actions/runs/38094667153) est `success` à la tentative 2 après une erreur TLS à la tentative 1 ; [Scorecard #38094666898](https://github.com/AntheaLiles/k7pl/actions/runs/38094666898) réussit. La publication GitHub Pages standard a également réussi. Aucun niveau OpenSSF n'en découle. |
| Registres actifs | [Actions humaines ordonnées](ACTIONS-HUMAINES.md) · [Décisions D1–D11](DECISIONS-REQUISES.md) · [Matrice des critères](BADGE-CONFORMANCE-MATRIX.md) · [Analyse BadgeApp](BADGE-AUTOMATION.md) |
| Dossier de preuves | [Audit consolidé](OPENSSF-AUDIT.md) · [État d'implémentation](IMPLEMENTATION-STATUS.md) · [Modèle de menace](THREAT-MODEL.md) · [Cas d'assurance](ASSURANCE-CASE.md) · [Politique des secrets](SECRETS-POLICY.md) |
| Archives | [Checklist historique du 2026-10-10](../history/2026-10-10-openssf-conformance-checklist.md) · [Plan initial de remédiation](../history/2026-10-10-openssf-remediation-plan.md) · [Clôture de la vague d'automatisation](../history/2026-10-10-openssf-automation-closeout.md) |

## État observé

La PR #129 a livré et fait fusionner le contrôle de cohérence des sources BadgeApp, la génération prudente de propositions, le registre épinglé, le contrôle read-only de dérive et les tests. Sur HEAD `86959948`, la première tentative du run CI #38094667153 a échoué au téléchargement de Lean 4.34.0 pendant `Install elan` (`SSL connect error` de `releases.lean-lang.org`). La tentative 2 du même run a terminé en succès : installation Elan et dépendances Lake, build et audits Lean, vérifications Verso, contrôles de navigation/provenance, tests Python (364 unittest `scripts/ci`, 68 pytest), compilation PDF, contrôles rapides, REUSE, actionlint, zizmor, gitleaks et OSV ont réussi ; `CI OK` est vert. Cela indique une erreur TLS transitoire sur la première tentative, pas une régression de code. Le workflow a aussi déployé la spécification sur [GitHub Pages](https://anthealiles.github.io/k7pl/) et le job `Generated status` a rafraîchi la branche `automation/generated-status` à `5ca329f7c03e967287478b07e167451ed0e06894`, PR #148 restant ouverte. Ces effets font partie du workflow CI relancé ; aucun tag/release ni publication Zenodo n'a été créé. Le job « Detect upstream BadgeApp criteria drift » est toutefois resté `skipped` sur l'événement `push`/sa relance, sans artefact `badge-criteria-drift-*`. Une lecture GitHub read-only du 2026-10-11 retrouve les deux Blob SHA amont épinglés (`criteria/criteria.yml`: `7804ec1a56e6423d58b23fc67e9ec9d4a6d43e7b` ; `criteria/baseline_criteria.yml`: `b7f3742959f7197b0e83fe49c7d92de05a578ba5`). Cette observation ponctuelle ne remplace ni le job ni son artefact et ne démontre pas une surveillance durable.

Le profil [BadgeApp K7PL](https://www.bestpractices.dev/en/projects/15239/baseline-2) a été observé le 2026-10-10 en état in_progress, baseline v2026.08.28. Les champs nom, description, licence et langages sont vides. Le badge est déjà affiché dans le README. Aucun formulaire n'a été soumis et aucune réponse externe n'a été modifiée.

## Écarts qui restent ouverts

| ID | État | Condition de clôture |
|---|---|---|
| R1 / R6 — chemin réel de publication par tag | PARTIEL | Répétition en sandbox avec tag contrôlé, vérification du commit / de CI OK, brouillon et attestation ; le seul workflow_dispatch ne prouve pas le chemin tag. |
| R3 — Zenodo / DOI | PRÉPARÉ | Décision D1 sur l'origine du DOI et le canal unique ; environnement protégé et répétition sandbox. |
| R4 — mise à jour Lean | PRÉPARÉ | Environnement bump-lean protégé, jeton à privilèges minimaux et première exécution réelle lors d'une mise à jour admissible. |
| R5 / R7 — paramètres et agents | ACTION HUMAINE | Contrôles de compte, paramètres administratifs et décision D3 ; aucune configuration externe n'a été modifiée par la campagne. |
| R11 / R21 — reproductibilité PDF/TeX | PARTIEL / BLOQUÉ | Décision D7, bundle TeX identifié et vérifié indépendamment, puis comparaison de builds ; ne pas revendiquer de reproductibilité avant preuve. |
| R13 / R14 — documentation et revue humaine | PARTIEL / ACTION HUMAINE | Confronter les documents au parcours réellement testé ; revue de sécurité personnellement conduite et datée avant de revendiquer le critère Gold. |
| R25 — SBOM/SPDX | PARTIEL, distinct | La validation indépendante du document SPDX exact est acquise dans le chantier K ([PR #128](https://github.com/AntheaLiles/k7pl/pull/128), CI #891). Restent à établir le périmètre des artefacts couverts, le corpus négatif élargi et l'évaluation inter-run ; ne pas confondre validation du document et exhaustivité de la SBOM. |
| R27 — surveillance OSV | PARTIEL | Plusieurs exécutions planifiées, examen des avis et preuve de la procédure de triage. |
| R28 — fiche BadgeApp | PARTIEL / ACTION HUMAINE | Périmètre, métadonnées, examen des critères, justifications N/A autorisées, envoi humain et vérification de l'état sauvegardé. |

Les décisions D2, D4, D6, D8, D9, D10 et D11 restent décrites dans [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md) ; leur recommandation documentaire ne doit pas être interprétée comme une ratification. Les actions sont ordonnées dans [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md) pour éviter de multiplier les checklists et le suivi dupliqué.

## Règles de clôture

- Un contrôle local ou une CI verte valide uniquement les contrôles exécutés.
- La matrice est un registre interne de preuves candidates, pas l'état sauvegardé dans BadgeApp.
- Aucune écriture automatique ne pousse les réponses au badge et aucun job de dérive ne met à jour le registre épinglé.
- Aucun secret, réglage administrateur, tag, release, publication Zenodo ni réponse BadgeApp n'a été modifié par la campagne.
- Tout nouveau travail d'ingénierie doit être rattaché à un identifiant et à une preuve de sortie ; les pistes futures non engagées restent dans les archives, pas dans le registre actif.
