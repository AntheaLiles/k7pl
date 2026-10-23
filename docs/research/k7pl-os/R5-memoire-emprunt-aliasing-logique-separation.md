# R5 — Permissions mémoire, emprunt, aliasing et logique de séparation (P2)

**Question centrale :** comment interdire les accès incompatibles à une région mémoire, y compris en concurrence et à travers FFI ?

## Questions

- Le modèle distingue-t-il lecture partagée et écriture exclusive ?
- Comment capacités, slices et permissions sont-elles transférées, fractionnées et recomposées ?
- Une valeur duplicable peut-elle capturer indirectement une capacité linéaire ?
- Quelles hypothèses relient intervalles abstraits, régions concrètes, allocations et accès machine ?
- Comment prouver les invariants des structures concurrentes, atomiques et barrières mémoire ?

## Livrable

Comparaison raisonnée avec RustBelt/Iris ; invariants pour allocation, slice, partage et composition parallèle ; obligations et contre-exemples liés aux alias et au FFI. Séparer mécanisme du langage, preuve de bibliothèque et application au runtime/matériel.

## Prompt prêt à copier

> Audite le modèle mémoire de K7PL au-delà du comptage abstrait de capacités. Compare propriété linéaire, emprunt, permissions fractionnaires et logique de séparation concurrente. Examine alias, réemprunt, valeurs duplicables, FFI, allocation et accès concurrents. Identifie les règles opérationnelles absentes et propose des invariants Lean reliés aux règles normatives.

## Sources

[Modèles mémoire C4](../../../spec/Spec/C4/ModelesDeMemoire.lean), [invariant capacité](../../../src/K7pl/MemoryCapability.lean), [intervalles](../../../src/K7pl/MemoryRange.lean), [RustBelt](https://plv.mpi-sws.org/rustbelt/), [Iris](https://iris-project.org/).

## Critère de sortie

Les règles d’introduction, transfert, fractionnement, recomposition et destruction des permissions sont définies et reliées à des preuves ; les hypothèses concrètes sont visibles.