<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8.3 — Inventaire et contrôles bloquants de l’ontologie

**État :** migration appliquée sur la branche de travail ; validation CI exacte encore requise.

`scripts/manuscript_metrics.py` inventorie les directives historiques et spécialisées et expose la nature, le rôle logique, l’état épistémique, l’appui, la portée et les références. `scripts/controles/statement_ontology.py` contrôle les métadonnées des directives spécialisées ; il est intégré aux contrôles de notation.

La portée utilise un vocabulaire fermé : `syntax`, `metatheory`, `graphs`, `resources`, `memory-safety`, `security`, `operational-semantics`, `graded-typing`, `effects`, `logical-relations`, `translation`, `fixed-points`, `interoperability`, `concurrency`, `ffi-safety`, `representation`, `compiler-interface`, `compilation`, `resource-accounting`, `literature`, `runtime`. Les limites détaillées ratifiées sont conservées séparément dans le registre de migration.

Les contrôles vérifient les vocabulaires, la compatibilité type/rôle, la portée contrôlée, l’impossibilité de marquer une conjecture comme établie, la provenance des résultats de littérature, la référence d’un artefact Lean, les catégories de preuve autorisées, le caractère local des hypothèses et la cohérence entre preuve textuelle et créneau `:::proofsketch`.

Ces contrôles sont mécaniques et structurels. Ils ne prouvent pas la vérité mathématique, ne valident pas une preuve écrite, ne résolvent pas automatiquement les références bibliographiques et ne vérifient pas la bonne attache argumentative d’une hypothèse locale. Aucun énoncé n’a été promu à `established`. La source bibliographique du résultat non gradué de sédimentation reste à résoudre au point C8.4.