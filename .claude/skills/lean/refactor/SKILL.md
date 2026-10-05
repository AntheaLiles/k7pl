---
name: refactor
description: Refactorer du code Lean 4 sans modifier le contrat observable ou théorique, avec preuve de non-régression.
---

# Refactoring

Identifier explicitement :

- le comportement conservé ;
- les dépendances ;
- les invariants ;
- les preuves affectées.

Refactorer par petites étapes.

Ne pas mélanger refactoring, nouvelle fonctionnalité et changement théorique.

Compiler après chaque transformation significative et exécuter les tests pertinents avant de conclure.
