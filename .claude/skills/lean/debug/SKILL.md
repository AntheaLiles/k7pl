<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

---
name: debug
description: Diagnostiquer et corriger un problème Lean 4 par reproduction, réduction, hypothèse testée et régression.
---

# Diagnostic

1. reproduire l'échec ;
2. réduire le cas ;
3. distinguer erreur de code, preuve, environnement ou outillage ;
4. formuler une hypothèse falsifiable ;
5. vérifier l'hypothèse ;
6. corriger au plus petit endroit ;
7. ajouter ou renforcer une régression ;
8. rerun les contrôles.

Ne pas corriger par essais successifs non documentés.

Ne pas modifier la spécification pour masquer un défaut d'implémentation.
