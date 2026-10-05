<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CECILL-2.1
-->

---
name: verification
description: Vérifier qu'un changement k7pl satisfait réellement son contrat et que les contrôles couvrent les erreurs pertinentes.
---

# Vérification globale

Comparer :

`intention → changement → contrôle → résultat`.

Exécuter les contrôles nécessaires et examiner les résultats réels.

Chercher les angles morts : propriété non testée, test sans oracle, preuve d'un autre énoncé, validation trop locale.

Classer le résultat `VERIFIED`, `PARTIAL`, `BLOCKED` ou `NOT VERIFIED`.
