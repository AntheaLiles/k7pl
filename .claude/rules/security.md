<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# Règles de sécurité et d'assurance

Le dépôt doit privilégier la sécurité réelle plutôt que l'optimisation d'un score.

Ne jamais fabriquer :

- revue ou approbation ;
- contributeur ;
- signature ;
- provenance ;
- SBOM ;
- preuve de reproductibilité ;
- contrôle SAST ;
- conformité Scorecard ou CII.

Toujours distinguer :

`VERIFIED` · `PREPARED` · `HUMAN ACTION REQUIRED` · `BLOCKED` · `FUTURE`.

Les workflows avec écritures GitHub, secrets ou permissions élevées doivent être examinés avant modification.

Les agents d'assurance ne doivent pas imposer de changement d'architecture du langage lorsqu'un contrôle documentaire ou CI suffit.
