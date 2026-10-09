<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

---
name: trace-spec-code
description: Construire et vérifier la traçabilité entre une propriété de la spécification, son implémentation Lean, ses preuves et ses tests.
---

# Traçabilité spec ↔ Lean

Tracer au minimum :

`section → définition → énoncé → construction Lean → preuve → test`.

Pour chaque relation, indiquer :

- fichier ;
- symbole ou label ;
- statut ;
- nature de la relation ;
- preuve disponible.

Ne pas inférer une correspondance parce que les noms se ressemblent.

Signaler les ruptures :

- spec sans formalisation ;
- formalisation sans source normative ;
- preuve d'une propriété différente ;
- test trop faible ;
- implémentation supplémentaire non spécifiée.

La traçabilité est un audit, pas une permission de modifier automatiquement la spécification.
