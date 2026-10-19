<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC0-1.0
-->

# CHECKPOINT — Chaîne formelle K7PL

Date : 2026-10-18
Branche : `infra-klean-verso-checkpoint-2026-10-18`
PR : https://github.com/AntheaLiles/k7pl/pull/232 — ouverte, non fusionnée
Base `main` observée : `3f1cbe6bad98bfd31480bf8d5f6acacfd75656c1`; aucune modification directe de `main`.
HEAD courant avant ce checkpoint : `262692237dcfc41861507d54fa0c14fc335e9b19`.

## État des étapes

- [x] Étape 0 — dépôt, branche de travail et état initial inspectés.
- [x] Étape 1 — définition K expérimentale compilée ; les deux programmes d’exemple exécutés avec les sorties attendues.
- [x] Étape 2 — export KORE→KLean réalisé et modules générés construits sous Lean 4.34.0.
- [x] Étape 3 — preservation/progress démontrés sur `SurfaceStep`; préservation `MachineTyping` démontrée sur tous les constructeurs KLean `Rewrites` du sous-langage.
- [x] Étape 4 — exposé Verso Blueprint rendu dans le nouveau chemin `spec/formal-chain/`.
- [x] Étape 5 — exemple `(+ 1 (+ 2 3))` évalué à `6` par K, trace `Rewrites` explicite et preuve de bout en bout construites.
- [x] Étape 6 — refactorisation finale, programmes `.k7`, namespaces, répertoires, manifestes Lake, workflow, documentation et REUSE validés après refactorisation.

## Validation finale de la chaîne

- CI K : [run 39172207296](https://github.com/AntheaLiles/k7pl/actions/runs/39172207296), job `117807446052`, conclusion `success` sur le commit de code `6c0f2008f613ebd8784e4cc230b208884b9ee67a`.
- Étapes confirmées vertes dans ce job : compilation de la définition K ; exécution des deux exemples ; export KORE→KLean ; compatibilité du shim ; staging des modules générés ; `lake build K7PL2Lean K7PL` ; audit d’axiomes ; `lake exe vbp build` ; création et upload de l’artefact.
- Audit Lean exact dans le journal : `K7PL.MachineSoundness.rewrites_preserve_machine_typing` dépend de `[propext]`; `K7PL.MachineSoundness.end_to_end_preservation` dépend de `[propext]`. Le garde-fou `sorryAx` a passé. Les preuves d’exemple rapportent également `[propext]`, sans `sorryAx`.
- CI générale : [run 39172207467](https://github.com/AntheaLiles/k7pl/actions/runs/39172207467), conclusion `success` sur le même commit de code. Les contrôles d’implémentation Lean, tests, REUSE, sécurité, spécification Verso, audits, rendu HTML/TeX et PDF sont validés ; les jobs de publication/statut non applicables sont `skipped`.

## Contrôle manuel de l’artefact

- Artefact : `k7pl-formal-chain-39172207296.zip`, ID `12153400819`.
- SHA-256 du ZIP : `117aa11013864f4e0834669026fe35bf526423cfa1f9c81fad162eb6fb0403e3`.
- Inspection ZIP/TAR terminée : le TAR contient 203 entrées au total et 171 fichiers réguliers. `MANIFEST.txt` comporte 171 entrées et correspond exactement aux chemins de fichiers réguliers de l’archive, sans manque ni entrée orpheline.
- Contenu contrôlé : 6 fichiers HTML Verso, 22 fichiers Lean, `K7PL/MachineSoundness.lean`, les deux `lake-manifest.json`, et `tests/examples/add.k7` ainsi que `tests/examples/select.k7`. Aucun programme `*.k7pl` ne subsiste dans l’artefact.

## Arborescence résultante

- `src/k/semantics.k` : source de sémantique K maintenue ; le fichier de définition conserve l’extension `.k`.
- `tests/examples/add.k7`, `tests/examples/select.k7` : programmes d’entrée K7PL ; l’extension requise est `.k7`.
- `proofs/K7PL/Proof.lean`, `Bridge.lean`, `MachineSoundness.lean`, `Example.lean` : preuves maintenues ; `proofs/K7PL.lean` et `proofs/lakefile.toml` fournissent le point d’entrée du package. Les modules KLean sont générés, ignorés par Git, et ne sont pas des sources manuelles.
- `spec/formal-chain/` : exposé expérimental Verso Blueprint et manifeste verrouillé, séparé de la spécification normative existante sous `spec/Spec/`.
- `docs/formal-semantics.md` et le `Makefile` à la racine documentent/exposent la chaîne ; Makefile K local sous `src/k/`.
- Les anciens répertoires `k7pl-semantics/`, `lean-k7pl/`, `blueprint-k7pl/` sont absents du tree. La recherche du tree confirmé ne retourne aucun programme `*.k7pl`.

## Reproductibilité et cause des blocages précédents

- Cause des échecs de preuve répétés : les indices de continuation incorporaient une conversion AST→KItem qui rendait les éliminations dépendantes impossibles à résoudre ; multiplier `simp` ne faisait pas progresser la preuve. Le correctif éprouvé délègue à l’injection générée par KLean et porte un témoin `EncodedExprTyping` à côté des charges K brutes des freezers.
- Cause probable du blocage Blueprint : le package ne versionnait pas son `lake-manifest.json` et `.gitignore` l’ignorait. Le guide amont du template Blueprint v4.34.0 recommande de figer les dépendances après `lake update`. Les manifestes sont désormais versionnés et copiés dans l’artefact ; le rendu fonctionne en CI.
- Manifestes : `proofs/lake-manifest.json` n’a pas de dépendances externes. `spec/formal-chain/lake-manifest.json` verrouille VersoBlueprint au commit `a1cf70667112dcffe15faea9f8783e63dd9644e8`, les révisions transitives et le package local `K7PLProofs`. REUSE réussit avec ces nouveaux fichiers.

## Portée formelle et limites qui restent ouvertes

- Le prototype ne couvre que les entiers, booléens, `(+ e1 e2)`, `(< e1 e2)` et `(select c e1 e2)`.
- KLean n’exporte pas les équations de la fonction K `typeOf` comme constructeurs de `Rewrites`. L’équivalence entre `typeOf` et le jugement Lean `HasType` reste à prouver. La fidélité de la traduction KORE→Lean, la sémantique des fonctions hookées et la correspondance normative restent des obligations séparées.
- Aucune sûreté du langage K7PL complet, de ses grades, effets, capacités ou fragments de ressources n’est revendiquée.

## Tête et reprise

- La comparaison entre le commit de code validé `6c0f2008f613ebd8784e4cc230b208884b9ee67a` et le HEAD `262692237dcfc41861507d54fa0c14fc335e9b19` confirme que les deux commits suivants ne modifient que `CHECKPOINT.md`; aucun changement de code ne sépare donc le contenu testé du HEAD actuel.
- Dernière commande validée : `lake build K7PL2Lean K7PL`, code 0, suivie de `lake exe vbp build`, code 0, dans le run K `39172207296`.
- DERNIÈRE ACTION : artefact téléchargé/extrait ; validité ZIP/TAR, SHA-256, nombre de fichiers, HTML/Lean, manifestes et correspondance exacte `MANIFEST.txt` vérifiés ; CI générale confirmée `success`.
- PROCHAINE ACTION PRÉCISE : laisser la PR #232 ouverte pour revue; ne pas fusionner ni toucher à `main` sans instruction explicite. Toute modification ultérieure du code devra relancer la CI de la chaîne formelle et la CI générale.
- INTERROMPU À L’ÉTAPE 6 — dernière commande : vérification de l’artefact `12153400819` (manifestes exacts) et contrôle de la CI générale `39172207467` (`success`) — prochaine action : revue de la PR #232 uniquement; la chaîne de refactorisation et ses critères de validation sont clos. Ne pas fusionner la PR.
