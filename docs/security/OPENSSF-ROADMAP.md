<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# OpenSSF / CII Best Practices — état opérationnel

| | |
|---|---|
| État | **Préparation technique prête à relire ; conformité globale non achevée** |
| Périmètre | Sécurité du dépôt, chaîne de construction/publication et préparation de l'auto-évaluation BadgeApp. Ne vaut ni certification ni revue humaine. |
| Branche de travail | [PR #129](https://github.com/AntheaLiles/k7pl/pull/129), ouverte sur main ; ne pas considérer ses changements comme intégrés avant fusion. |
| Registres actifs | [Actions humaines ordonnées](ACTIONS-HUMAINES.md) · [Décisions D1–D11](DECISIONS-REQUISES.md) · [Matrice des critères](BADGE-CONFORMANCE-MATRIX.md) · [Analyse BadgeApp](BADGE-AUTOMATION.md) |
| Dossier de preuves | [Audit consolidé](OPENSSF-AUDIT.md) · [État d'implémentation](IMPLEMENTATION-STATUS.md) · [Modèle de menace](THREAT-MODEL.md) · [Cas d'assurance](ASSURANCE-CASE.md) · [Politique des secrets](SECRETS-POLICY.md) |
| Archives | [Checklist historique du 2026-10-10](../history/2026-10-10-openssf-conformance-checklist.md) · [Plan initial de remédiation](../history/2026-10-10-openssf-remediation-plan.md) · [Clôture de la vague d'automatisation](../history/2026-10-10-openssf-automation-closeout.md) |

## État observé

La PR #129 prépare le contrôle local de cohérence des sources BadgeApp, le générateur prudent de propositions, le registre de critères épinglé, la détection read-only de dérive amont et les tests correspondants. La CI de la tête antérieure 1b5950350588742f2b0681e37565f85d70527d98 a réussi le run [38059644310](https://github.com/AntheaLiles/k7pl/actions/runs/38059644310). La présente consolidation documentaire impose une nouvelle exécution CI ; seul son résultat sur le nouveau head pourra être retenu.

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
| R25 — SBOM/SPDX | PARTIEL, distinct | Validation indépendante et décision de périmètre ; chantier séparé de la présente automatisation BadgeApp (issue #122). |
| R27 — surveillance OSV | PARTIEL | Plusieurs exécutions planifiées, examen des avis et preuve de la procédure de triage. |
| R28 — fiche BadgeApp | PARTIEL / ACTION HUMAINE | Périmètre, métadonnées, examen des critères, justifications N/A autorisées, envoi humain et vérification de l'état sauvegardé. |

Les décisions D2, D4, D6, D8, D9, D10 et D11 restent décrites dans [DECISIONS-REQUISES.md](DECISIONS-REQUISES.md) ; leur recommandation documentaire ne doit pas être interprétée comme une ratification. Les actions sont ordonnées dans [ACTIONS-HUMAINES.md](ACTIONS-HUMAINES.md) pour éviter de multiplier les checklists et le suivi dupliqué.

## Règles de clôture

- Un contrôle local ou une CI verte valide uniquement les contrôles exécutés.
- La matrice est un registre interne de preuves candidates, pas l'état sauvegardé dans BadgeApp.
- Aucune écriture automatique ne pousse les réponses au badge et aucun job de dérive ne met à jour le registre épinglé.
- Aucun secret, réglage administrateur, tag, release, publication Zenodo ni réponse BadgeApp n'a été modifié par la campagne.
- Tout nouveau travail d'ingénierie doit être rattaché à un identifiant et à une preuve de sortie ; les pistes futures non engagées restent dans les archives, pas dans le registre actif.
