<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Sécurité et assurance de la chaîne d'approvisionnement

Ce dossier rassemble l'audit OpenSSF mené sur le dépôt et ses suites. Il traite de la **sécurité de la chaîne de construction et de
publication** (workflows, dépendances, releases, comptes). Il ne dit rien de la correction scientifique du langage : celle-ci relève de
[`../ASSURANCE.md`](../ASSURANCE.md). L'état factuel courant du dépôt est produit par la CI dans [`../STATUS.md`](../STATUS.md).

**Document version:** 1.0.0  
**Last updated:** 2026-10-06  
**Audience:** la mainteneuse, les relecteurs, les agents.

## Nature des documents

Ces documents sont des **enregistrements datés** d'une campagne conduite par des agents ; ils ne sont **pas validés par la mainteneuse**
et ne deviennent pas normatifs par leur détail. Ils décrivent l'état du dépôt à la date et au commit indiqués. Ce qui change depuis (par
exemple le job `status` ajouté à `ci.yaml` sur `main` après l'audit) n'y figure que s'il est mentionné explicitement.

| Document | Rôle |
|---|---|
| [`OPENSSF-AUDIT.md`](OPENSSF-AUDIT.md) | matrice des écarts consolidée des six audits |
| [`OPENSSF-ROADMAP.md`](OPENSSF-ROADMAP.md) | plan de remédiation priorisé et répartition des fichiers |
| [`IMPLEMENTATION-STATUS.md`](IMPLEMENTATION-STATUS.md) | ce qui a été fait, ce qui ne l'a pas été, et la validation réellement exécutée |
| [`DECISIONS-REQUISES.md`](DECISIONS-REQUISES.md) | décisions qui reviennent à la mainteneuse (D1 à D11) |
| [`ACTIONS-HUMAINES.md`](ACTIONS-HUMAINES.md) | réglages GitHub, compte, Zenodo, site des bonnes pratiques |
| [`THREAT-MODEL.md`](THREAT-MODEL.md) | actifs, acteurs, chemins d'attaque, privilèges des workflows |
| [`ASSURANCE-CASE.md`](ASSURANCE-CASE.md) | revendications de sécurité étayées, et celles qui ne sont pas (encore) vraies |
| [`workstreams/`](workstreams/) | rapports bruts des agents : audits, changements, validations, audits finaux |

## Vocabulaire des statuts

Pour la sécurité : `VERIFIED`, `PARTIAL`, `PREPARED`, `HUMAN ACTION REQUIRED`, `BLOCKED`, `FUTURE` (voir `.claude/rules/security.md`).
Le vocabulaire de [`../METHOD.md`](../METHOD.md) (`ESTABLISHED`, `UNDER REVIEW`, …) s'applique aux affirmations scientifiques : les deux
ne se mélangent pas.
