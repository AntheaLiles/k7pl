# R2 — Compilation sûre : source → binaire (P1)

**Question centrale :** quelles preuves relient la sémantique K7PL au code machine réellement exécuté ?

## Axes

Correction du compilateur, préservation sémantique, compilation certifiée, validation de traduction, ABI, linking, optimisations, assembleur, boot, code privilégié, runtime et FFI.

- Quel fragment vertical minimal faut-il compiler et prouver en premier ?
- Quelle relation de simulation relie source, IR, backend et machine ?
- Quels événements préserver : résultats, effets, traces, ordre des messages, capacités, budgets et échecs ?
- Quel est le TCB du compilateur, de l’assembleur, du linker et du runtime ?
- Quelle valeur apporte une validation de traduction avant une preuve complète ?

## Livrable

Diagramme de la chaîne source → IR → backend → binaire → runtime, TCB, obligations par frontière, tests différentiels et feuille de route graduelle. Les étapes non prouvées doivent être nommées et associées à une stratégie de réduction du risque.

## Prompt prêt à copier

> Élabore une feuille de route de correction de compilation de K7PL. Compare CompCert, Cogent, Verve et seL4 sans confondre leurs objectifs. Définis un fragment minimal, une relation de préservation, les effets/traces à préserver et le TCB. Compare preuve complète, compilation certifiée, validation de traduction et tests différentiels. Liste les garanties impossibles à revendiquer tant que compilateur, ABI et code privilégié ne sont pas couverts.

## Sources

[CompCert](https://compcert.org/), [Cogent](https://trustworthy.systems/projects/OLD/cogent), [Verve](https://www.microsoft.com/en-us/research/publication/safe-to-the-last-instruction-automated-verification-of-a-type-safe-operating-system/), [seL4](https://sel4.systems/Verification/), [noyau effectif C3](../../../spec/Spec/C3/EffectiveKernel.lean), [sémantique C4](../../../spec/Spec/C4/SemantiqueOperationnelle.lean).

## Critère de sortie

La conformité du binaire n’est jamais inférée du seul typage source ; hypothèses et étapes non prouvées sont explicites.