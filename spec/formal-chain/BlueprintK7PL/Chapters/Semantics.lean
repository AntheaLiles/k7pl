-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
-- SPDX-License-Identifier: CC-BY-4.0
import Verso
import VersoManual
import VersoBlueprint
import K7PL.Proof
import K7PL.Bridge
import K7PL.Example
import K7PL.MachineSoundness
import K7PL.NativeBoundary

open Verso.Genre
open Verso.Genre.Manual
open Informal

#doc (Manual) "Sémantique opérationnelle et sûreté des types" =>

:::group "subset"
Périmètre de la tranche expérimentale de formalisation.
:::

:::definition "prefix_subset" (parent := "subset") (lean := "K7PL.Proof.exampleProgram")
Le prototype prend en charge les littéraux entiers et booléens, l’addition
`(+ e1 e2)`, la comparaison `(< e1 e2)` et la sélection `(select c e1 e2)`.
Les expressions utilisent la notation symbolique préfixée du chapitre 5 de la
spécification K7PL. Le programme source `tests/examples/add.k7` contient
`(+ 1 (+ 2 3))` et se réduit à `6`.
:::

:::definition "surface_step" (parent := "subset")
`SurfaceStep` est une relation à petits pas définie sur l’AST Lean émis par KLean.
Elle encode l’évaluation gauche-à-droite de l’addition et de la comparaison,
ainsi que l’évaluation de la seule condition de `select`. Ce n’est pas la
relation de configuration complète `Rewrites` générée par KLean.
:::

:::theorem "surface_preservation" (parent := "subset") (lean := "K7PL.Proof.preservation")
**Préservation expressionnelle.** Si `e` a le type `τ` et que `SurfaceStep e e'`,
alors `e'` a également le type `τ`. Ce théorème est prouvé par induction sur
la dérivation de `SurfaceStep`.
:::

:::proof "surface_preservation"
L’audit `#print axioms` rapporte que `K7PL.Proof.preservation` ne dépend d’aucun axiome.
:::

:::theorem "surface_progress" (parent := "subset") (lean := "K7PL.Proof.progress")
**Progression expressionnelle.** Toute expression bien typée est une valeur ou
peut effectuer un pas `SurfaceStep`. Le résultat est limité au jugement `HasType`
et à la relation expressionnelle de ce sous-langage.
:::

:::proof "surface_progress"
L’audit `#print axioms` rapporte que `K7PL.Proof.progress` ne dépend d’aucun axiome.
:::

:::definition "generated_k_semantics" (parent := "subset")
`src/k/semantics.k` définit la sémantique K exécutable du sous-langage. K la
compile vers KORE ; `klean` génère `Rewrites` sur des configurations K complètes,
avec les transitions heat/cool et les frames de continuation. Les équations de
la fonction K `typeOf` ne sont pas encodées comme des règles reliées à `HasType`.
:::

:::theorem "machine_preservation" (parent := "subset") (lean := "K7PL.MachineSoundness.rewrites_preserve_machine_typing")
**Préservation machine.** Chaque pas généré `Rewrites s s'` préserve le type
porté par une configuration `MachineTyping`, y compris lors des changements
de focus et du retour depuis les frames de continuation.
:::

:::proof "machine_preservation"
Le workflow CI compile le théorème sur les constructeurs générés et bloque si
`sorryAx` apparaît. L’audit `#print axioms` rapporte `[propext]`.
:::

:::theorem "machine_end_to_end" (parent := "subset") (lean := "K7PL.MachineSoundness.end_to_end_preservation")
**Préservation de bout en bout.** Une exécution `Rewrites` entre configurations
initiales d’expressions bien typées conserve le type structurel `HasType`.
:::

:::proof "machine_end_to_end"
Le décodage utilise l’invariant `MachineTyping`. Aucune équivalence entre le
jugement Lean `HasType` et la fonction K `typeOf` n’est revendiquée.
:::

:::theorem "root_add_klean_safety" (parent := "subset") (lean := "K7PL.Example.root_add_klean_preserves_type")
Pour l’expression `(+ 1 2)`, Lean relie la règle d’addition KLean générée à la
sortie entière `3`. Ce témoin explicite utilise `Rewrites.k7AddEval`.
:::

:::proof "root_add_klean_safety"
Le pont d’exemple rapporte `[propext]`; la CI interdit `sorryAx`.
:::

:::theorem "nested_add_end_to_end" (parent := "subset") (lean := "K7PL.Example.add_example_end_to_end")
Pour `tests/examples/add.k7`, K réduit `(+ 1 (+ 2 3))` à `6`; Lean compose
une trace explicite de transitions `Rewrites` et vérifie le type de l’entrée
et de la sortie.
:::

:::proof "nested_add_end_to_end"
Cet exemple est un témoin concret en complément du théorème général de
préservation machine pour le sous-langage ; il ne démontre pas la sûreté du
langage K7PL complet.
:::

:::definition "d01_native_boundary_model" (parent := "subset")
Le modèle de profil K7OS, extrait séparément depuis le document Verso, représente
un appel natif conforme, une écriture native refusée sous une hypothèse abstraite
de frontière appliquée et la même écriture lorsqu'aucune frontière n'est appliquée.
Ce modèle est non normatif et n'ajoute pas de syntaxe au langage K7PL.
:::

:::theorem "d01_boundary_preservation" (parent := "subset") (lean := "K7PL.NativeBoundary.enforcedBoundary_trace_preserves_protected")
Pour le modèle de transition abstrait D-01, toute trace finie du profil à frontière
appliquée préserve la valeur de l'état protégé.
:::

:::proof "d01_boundary_preservation"
Lean vérifie la preuve par induction sur la trace. Elle porte sur le modèle explicite
K7PL.NativeBoundary.Step, pas sur du code natif arbitraire ni sur un mécanisme
matériel particulier.
:::

:::theorem "d01_unconfined_trace_replay" (parent := "subset") (lean := "K7PL.NativeBoundary.unconfined_native_write_trace_replay")
Le témoin TLC d'une écriture native non confinée est rejoué comme une trace Lean exacte :
état initial `(protected=0, service=0)`, action `nativeWrite(1)`, état final
`(protected=1, service=0)`.
:::

:::proof "d01_unconfined_trace_replay"
La preuve Lean construit une transition `Step` puis ferme la trace avec `Steps.nil`.
Le modèle TLC limité au même domaine fini doit fournir le même événement final.
Cette liaison reste un témoin précis, pas un théorème de projection pour toutes les traces.
:::

:::theorem "d01_unconfined_counterexample" (parent := "subset") (lean := "K7PL.NativeBoundary.unconfined_native_write_counterexample")
Le profil partagé sans frontière appliquée admet une écriture native qui modifie
l'état protégé. Ce contre-exemple interdit d'inférer la protection du seul système
de types quand le code étranger peut écrire arbitrairement dans le domaine partagé.
:::

:::proof "d01_unconfined_counterexample"
Le témoin est prouvé atteignable dans le modèle Lean. TLC doit en outre trouver
l'état violant ProtectedIntegrity dans la configuration négative. Le modèle K
exécute séparément les cas conforme, confiné et non confiné. Ces exécutions ne
constituent pas encore une simulation formelle entre les trois représentations.
:::

:::definition "d01_evidence_boundary" (parent := "subset")
TLC explore exhaustivement les états du modèle fini et de sa configuration ; Lean
prouve un énoncé sur son propre système de transition ; K exécute le modèle sous
krun. Aucun résultat TLC n'est injecté comme axiome Lean et aucune preuve Lean
n'est déduite du seul succès CI. La relation de projection K↔TLA+↔Lean demeure
une obligation distincte.
:::
