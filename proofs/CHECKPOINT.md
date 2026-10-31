<!-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Checkpoint — formalisation Lean par domaine

**Branche :** `feat/lean-domain-proof-architecture-2026-10-31`  
**Base :** `main` à `2fbf609f6f3e67ffe011a3f28fd247526684155a`  
**Statut :** sources initiales publiées ; compilation et audit CI à confirmer.

## Fait dans cette tranche

- création des racines théoriques `Grades`, `Structural`, `Memory` et
  `Metatheory`, sans dossier `proofs/K7PL/` ;
- réutilisation directe de `Spec.C3.EffectiveKernel` pour `Usage`,
  `Grade`, `π_U` et `Scale_Usage` ;
- lemmes locaux sur intervalles d'usage, scaling, modes candidats, budget fini,
  partition de régions, invalidation d'une référence par génération et
  préservation d'invariant sur traces finies ;
- déplacement des anciens fichiers KLean dans `archive/KLean/`, où ils
  demeurent compilables mais explicitement historiques ;
- raccordement du projet Lake, de la chaîne CI, de l'audit d'axiomes et de
  l'archivage de preuves.

## À vérifier dans la CI

1. Résolution de la dépendance locale vers la bibliothèque racine K7PL.
2. Compilation Lean de chaque domaine et des modules KLean archivés.
3. Exactitude de l'audit `#print axioms` ; ajuster le contrat seulement si
   l'axiome observé est justifié et explicitement approuvé.
4. Compilation de la formal-chain/Blueprint après déplacement des imports.
5. Test du paquet d'évidence, des chemins impact et de REUSE.

## Non réalisé / hors portée

Pas de simulation K↔Lean↔TLA, de preuve H1/H2/H3, de sûreté spatiale générale,
de sémantique mémoire concurrente, de preuve de progrès ou terminaison
complète, ni de ratification normative.
