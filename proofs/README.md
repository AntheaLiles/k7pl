<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Couche de preuves K7PL

Ce package Lake rassemble les preuves Lean maintenues de la chaîne sémantique expérimentale.
`K7PL/Proof.lean` définit le jugement structurel `HasType` et `SurfaceStep`, avec les théorèmes
`preservation` et `progress`. `K7PL/Bridge.lean` relie des pas concrets à la relation générée.
`K7PL/MachineSoundness.lean` prouve la préservation de `MachineTyping` pour les constructeurs
de la relation KLean `Rewrites`, y compris les frames de continuation. `K7PL/Example.lean`
contient les témoins concrets de bout en bout.

Les modules KLean sont générés pendant la construction sous `K7PL2Lean/` et
`K7PL2Lean.lean`; ils sont ignorés par Git et ne sont pas des sources maintenues. À partir de
la racine du dépôt, `make proof` compile K, génère et adapte KLean, copie les modules générés
dans ce package, puis lance `lake build`.

Limite formelle : le sous-langage contient des entiers, booléens, addition, comparaison et
`select`. KLean n'encode pas les équations de la fonction K `typeOf` comme constructeurs de
`Rewrites`; aucune équivalence entre `typeOf` et le jugement `HasType` n'est revendiquée.
Ce résultat ne constitue pas une preuve de sûreté du K7PL complet.
