<!-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Checkpoint — formalisation Lean par domaine

**Branche de correction :** `fix/lean-domain-proof-audit-2026-11-01`  
**Base :** `main` à `2fbf609f6f3e67ffe011a3f28fd247526684155a`  
**Tête parent :** `44471f2c8ef7c5bb6fba9067dee7f0344279eb5b`  
**Statut :** correctifs d'audit publiés ; compilation Lean et audit exact à confirmer sur cette tête.

## Correctifs de l'audit PR #320 (2026-11-01)

- **B1 :** `disjoint_irreflexive` utilise désormais `Nat.not_lt_of_ge
  r.valid h` dans les deux branches ; la contradiction exploite la validité
  de la plage au lieu d'appliquer `Nat.lt_irrefl` à deux champs distincts.
- **M2 :** `maxHeartbeats=10000000` est rétabli dans les trois bibliothèques
  Lake. Les trois sont déclarées `default_target` ; le passage TOML → DSL ne
  change donc plus silencieusement la limite ni le périmètre du build par défaut.
- **m1/m2 :** le plan donne les quatre intervalles exacts de C2 ; le commentaire
  de séparation décrit le lemme `disjoint_ne` et n'annonce plus un lemme H2
  que le module ne prouve pas.
- **m3 :** le périmètre de 30 déclarations est ventilé en 12 ré-expositions,
  4 correspondances définitionnelles et 14 contenus de preuve nouveaux.
- **M5 approfondi :** `src/K7pl/` et
  `spec/Spec/C3/EffectiveKernel.lean` déclenchent maintenant `axiom_audit`
  via les `read_inputs` du registre ; un test Deno couvre ces chemins.
  `cache_determinants` reste déclaratif à cette révision et n'est pas une clé
  de cache effective.
- **M1 :** le run `41248858168` sur le parent a été annulé pendant le build
  KLean généré ; l'audit des axiomes et le Blueprint ont été ignorés. Les
  résultats Deno/Python observés sur le parent ne valent pas validation de la
  tête de correction. Aucun build Lean local n'est disponible ici.

## Fait dans cette tranche

- création des racines théoriques `Grades`, `Structural`, `Memory` et
  `Metatheory`, sans dossier `proofs/K7PL/` ;
- réutilisation de `K7pl.UsageScale`, `K7pl.StructuralModes`,
  `K7pl.MemoryCapability`,
  `K7pl.MemoryRange`, `K7pl.GradeBudget` et `Spec.C3.EffectiveKernel` ;
- correspondance bidirectionnelle des grades de la spécification et de
  l'implémentation, intervalles d'usage, morphismes de modes existants,
  contrat budgétaire `ℕ∞`, lois de séparation des plages, invalidation d'une
  référence par génération, préservation de l'unicité des capacités d'écriture,
  exclusion de doubles écrivains et préservation d'invariant sur traces finies ;
- déplacement des anciens fichiers KLean dans `archive/KLean/`, où ils
  demeurent compilables mais explicitement historiques ;
- raccordement du projet Lake, de la chaîne CI, de l'audit d'axiomes et de
  l'archivage de preuves.

## À vérifier sur la tête de correction

1. Build `K7PL2Lean`, `KLeanArchive` et `K7PLProofs`, avec la limite de
   heartbeats restaurée.
2. Exactitude des 30 ensembles d'axiomes en matching exact ; ne modifier le
   contrat qu'après observation de `#print axioms` et justification explicite.
3. Compilation de la formal-chain/Blueprint après déplacement des imports.
4. Tests Deno/Python, validation du registre, test d'impact des sources
   importées, REUSE et packaging de l'évidence.
5. Vérifier que les changements de `src/K7pl/` et du noyau C3 déclenchent bien
   `axiom_audit` dans la sortie de l'impact classifier.

## Non réalisé / hors portée

Pas de simulation K↔Lean↔TLA, de preuve H1/H2/H3, de sûreté spatiale générale,
de sémantique mémoire concurrente, de preuve de progrès ou terminaison
complète, ni de ratification normative.
