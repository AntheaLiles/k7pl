<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

---
name: review-spec
description: Revoir une section de la spécification k7pl sur les plans conceptuel, formel, interchapitres et épistémique, sans la modifier.
---

# Review de spécification

Lire `.claude/rules/specification.md`.

Ne rien modifier au début de la revue.

Construire la chaîne :

`affirmation → définition → hypothèses → dépendances → conséquence → preuve disponible`.

Rechercher en particulier :

- termes non définis ;
- glissements de niveau ;
- hypothèses implicites ;
- théorèmes plus forts que leurs prémisses ;
- contradictions interchapitres ;
- affirmations empiriques non sourcées ;
- confusion entre spécification, implémentation et preuve.

Produire un rapport avec sévérité, emplacement, constat, justification et action proposée.

Classer chaque constat comme `FACT`, `HYPOTHESIS`, `OPEN QUESTION` ou `ACTION`.
