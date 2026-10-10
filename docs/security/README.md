<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Sécurité et assurance de la chaîne d'approvisionnement

Ce dossier rassemble l'audit OpenSSF mené sur le dépôt et ses suites. Il traite de la **sécurité de la chaîne de construction et de
publication** (workflows, dépendances, releases, comptes). Il ne dit rien de la correction scientifique du langage : celle-ci relève de
[`../ASSURANCE.md`](../ASSURANCE.md). L'état factuel courant du dépôt est produit par la CI dans [`../STATUS.md`](../STATUS.md).

**État au 2026-10-10 : campagne reprise à la demande de la mainteneuse.** La remédiation active est réduite aux actions encore ouvertes ou partielles dans
[`OPENSSF-ROADMAP.md`](OPENSSF-ROADMAP.md). Le plan de remédiation initial et l'ancienne checklist sont désormais dans docs/history/ ; la matrice de critères est la référence d'évaluation courante. La reprise ne signifie ni conformité OpenSSF complète,
ni revue humaine de sécurité. Les actions administratives et décisions non résolues restent dans les registres dédiés.

**Document version:** 1.0.0  
**Last updated:** 2026-10-10  
**Audience:** la mainteneuse, les relecteurs, les agents.

## Identifiants de commit cités

La branche de cette campagne a été **aplatie en un seul commit** (décision de la mainteneuse, pour que `commitlint` passe sur la PR), puis fusionnée dans
`main` **par rebase** : les trois commits de la PR sont devenus `b94a4e3`, `ab070c6` et `da1abb1`. Tout identifiant de commit cité dans ce dossier qui ne
figure pas dans l'historique de `main` (par exemple `3fd82f1`, `ce606a9`, `25eb642`, `5e4edcf`, `c9372cb`, `b8ee3b6`, `cb3c7e5`, `a9b20ab`) désigne l'historique
de la branche **avant** l'aplatissement ou avant le rebase : il n'est plus joignable. Les numéros de run de CI, eux, restent valides ; `b5f6146` et `4a8c34f`
sont des commits de `main`.

## Nature des documents

Ces documents sont des **enregistrements datés** d'une campagne conduite par des agents ; ils ne sont **pas validés par la mainteneuse**
et ne deviennent pas normatifs par leur détail. Ils décrivent l'état du dépôt à la date et au commit indiqués. Ce qui change depuis (par
exemple le job `status` ajouté à `ci.yaml` sur `main` après l'audit) n'y figure que s'il est mentionné explicitement.

| Document | Rôle |
|---|---|
| [`OPENSSF-AUDIT.md`](OPENSSF-AUDIT.md) | matrice des écarts consolidée des six audits |
| [`BADGE-AUTOMATION.md`](BADGE-AUTOMATION.md) | état vérifié de BadgeApp, analyse des propositions et règle de synchronisation prudente |
| [`BADGE-CONFORMANCE-MATRIX.md`](BADGE-CONFORMANCE-MATRIX.md) | matrice de conformité critère par critère et états probatoires datés |
| `scripts/ci/check_badge_proposals.py` | contrôle local de cohérence, génération d'URL de proposition et détection read-only des dérives upstream |
| [`OPENSSF-ROADMAP.md`](OPENSSF-ROADMAP.md) | registre actif des écarts et actions encore ouvertes |
| [`IMPLEMENTATION-STATUS.md`](IMPLEMENTATION-STATUS.md) | ce qui a été fait, ce qui ne l'a pas été, et la validation réellement exécutée |
| [`DECISIONS-REQUISES.md`](DECISIONS-REQUISES.md) | décisions qui reviennent à la mainteneuse (D1 à D11) |
| [`ACTIONS-HUMAINES.md`](ACTIONS-HUMAINES.md) | réglages GitHub, compte, Zenodo, site des bonnes pratiques |
| [`THREAT-MODEL.md`](THREAT-MODEL.md) | actifs, acteurs, chemins d'attaque, privilèges des workflows |
| [`ASSURANCE-CASE.md`](ASSURANCE-CASE.md) | revendications de sécurité étayées, et celles qui ne sont pas (encore) vraies |
| [`GOVERNANCE.md`](GOVERNANCE.md) | modèle de décision, rôles réels et limites de continuité |
| [`SECRETS-POLICY.md`](SECRETS-POLICY.md) | règles de gestion des secrets et vérifications administratives encore requises |
| [`workstreams/`](workstreams/) | rapports bruts des agents : audits, changements, validations, audits finaux |

## Vocabulaire des statuts

Pour la sécurité : `VERIFIED`, `PARTIAL`, `PREPARED`, `HUMAN ACTION REQUIRED`, `BLOCKED`, `FUTURE` (voir `.claude/rules/security.md`).
Le vocabulaire de [`../METHOD.md`](../METHOD.md) (`ESTABLISHED`, `UNDER REVIEW`, …) s'applique aux affirmations scientifiques : les deux
ne se mélangent pas.


Les anciennes checklists et le plan de remédiation initial sont conservés sous [docs/history/](../history/) comme traces datées ; ils ne constituent plus des registres actifs. Les rapports de workstreams restent des pièces justificatives historiques, pas des listes de tâches à dérouler.
