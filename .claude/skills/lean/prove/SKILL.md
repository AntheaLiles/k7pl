<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

---
name: prove
description: Construire une preuve Lean 4 pour une propriété déjà clarifiée, sans modifier silencieusement la théorie.
---

# Prouver en Lean

Lire `.claude/rules/lean.md` et `.claude/rules/verification.md`.

Avant de prouver :

- identifier exactement l'objectif ;
- vérifier les hypothèses ;
- rechercher les lemmes existants ;
- vérifier les API avec Lean.

Préférer une preuve claire et minimale.

Ne pas affaiblir l'énoncé pour obtenir une preuve plus facile. Si l'énoncé semble faux ou surdimensionné, arrêter la construction et signaler le problème.

Après modification :

`lake build` puis les contrôles pertinents.
