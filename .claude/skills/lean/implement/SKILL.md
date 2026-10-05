---
name: implement
description: Implémenter une construction ou fonctionnalité Lean 4 correspondant à une propriété déjà spécifiée.
---

# Implémentation Lean

Lire `.claude/rules/lean.md`.

Avant d'écrire :

1. identifier le contrat venant de la spécification ;
2. localiser la frontière d'implémentation ;
3. rechercher les abstractions existantes ;
4. définir le test ou l'invariant attendu.

Implémenter sans étendre le périmètre.

Ne pas modifier `spec/` pour rendre l'implémentation plus commode.

Valider avec les outils du projet.
