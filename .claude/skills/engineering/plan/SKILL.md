<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

---
name: plan
description: Transformer une demande k7pl en plan d'exécution avec dépendances, frontières de fichiers et critères de vérification.
---

# Planification

Transformer la demande en tâches atomiques.

Pour chaque tâche :

- objectif ;
- précondition ;
- fichiers concernés ;
- dépendances ;
- agent/skill adapté ;
- critère de réussite.

Créer un graphe lorsque les tâches traversent plusieurs domaines.

Ne pas déclarer une tâche prête si une définition, hypothèse, API ou décision nécessaire manque.
