---
name: test
description: Concevoir des tests Lean 4 qui vérifient réellement une propriété identifiable de k7pl.
---

# Tests

Pour chaque test, écrire mentalement :

`la propriété X doit être vraie ; le test doit échouer si Y est cassé`.

Choisir entre :

- exemple ;
- test de rejet ;
- propriété ;
- invariant ;
- contrôle métathéorique.

Éviter les tests qui ne font qu'exécuter du code sans oracle utile.

Une propriété déjà prouvée ne devient pas plus vraie parce qu'elle possède un test ; les deux artefacts ont des rôles différents.
