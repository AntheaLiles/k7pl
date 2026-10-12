<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8.3 — Inventaire et contrôles bloquants de l’ontologie

**État :** le run historique #944 sur le SHA `f6624d36e875e053384c9d276a283732e3782e40` a réussi pour ce seul commit. Il ne certifie aucune tête ultérieure ; consulter les checks CI associés au SHA courant de la PR #139 avant de décider de la fusion. Aucune fusion n’a été effectuée.

`scripts/manuscript_metrics.py` inventorie les directives historiques et spécialisées et expose la nature, le rôle logique, l’état épistémique, l’appui, la portée et les références. `scripts/controles/statement_ontology.py` contrôle les métadonnées des directives spécialisées ; il est intégré aux contrôles de notation.

Le contrôle de migration compare les 74 objets sources au registre courant, vérifie les 69 labels historiques plus exactement cinq compagnons, détecte les dérives de champs et références, et compare chaque niveau historique au snapshot pré-migration. `--dependency-cycles` est un diagnostic non bloquant : toute composante détectée est une alerte de revue sémantique, pas une preuve de circularité scientifique.

La portée utilise un vocabulaire fermé : `syntax`, `metatheory`, `graphs`, `resources`, `memory-safety`, `security`, `operational-semantics`, `graded-typing`, `effects`, `logical-relations`, `translation`, `fixed-points`, `interoperability`, `concurrency`, `ffi-safety`, `representation`, `compiler-interface`, `compilation`, `resource-accounting`, `literature`, `runtime`. Les limites détaillées ratifiées sont conservées séparément dans le registre de migration.

Les contrôles vérifient les vocabulaires, la compatibilité type/rôle, la portée contrôlée, l’impossibilité de marquer une conjecture comme établie, la provenance des résultats de littérature, la référence d’un artefact Lean, les catégories de preuve autorisées, le caractère local des hypothèses et la cohérence entre preuve textuelle et créneau `:::proofsketch` (une esquisse explicative peut accompagner un objet de littérature sans remplacer sa provenance bibliographique).

Ces contrôles sont mécaniques et structurels. Ils ne prouvent pas la vérité mathématique, ne valident pas une preuve écrite, ne résolvent pas automatiquement les références bibliographiques et ne vérifient pas la bonne attache argumentative d’une hypothèse locale. Aucun énoncé n’a été promu à `established`. La source bibliographique du résultat non gradué de sédimentation reste à résoudre au point C8.4.