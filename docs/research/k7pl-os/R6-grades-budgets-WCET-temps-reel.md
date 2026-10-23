# R6 — Grades, budgets, WCET et temps réel (P3)

**Question centrale :** les budgets K7PL bornent-ils le coût d’une exécution réelle, et quelles hypothèses faut-il pour une garantie temps réel ?

## Questions

- Les budgets sont-ils des bornes prouvées, annotations ou profils abstraits ?
- Comment comptabiliser primitives, FFI, interruptions, contention et E/S ?
- Quelle cible et quel modèle de coût sont retenus ?
- Comment composer coûts, préemption, priorités et équité ?
- Parle-t-on de WCET dur, borne probabiliste, moyenne ou simple budget logique ?

## Livrable

Modèle de coût explicite, séparation entre borne abstraite et borne mesurée, stratégie WCET et hypothèses sur matériel/ordonnanceur. Relier les profils au jugement d’effets et de consommation sans supposer ce lien établi.

## Prompt prêt à copier

> Évalue la portée des grades et budgets temporels de K7PL. Distingue travail, profondeur, coût abstrait, coût machine et WCET. Définis les hypothèses sur cible, caches, interruptions, E/S, ordonnanceur, FFI et contention. Audite le lien entre profils et jugement d’effets/consommation ; propose des obligations vérifiables. Ne revendique pas le temps réel à partir d’une borne abstraite non reliée au matériel.

## Sources

[Grades C2](../../../spec/Spec/C2/AdjonctionsEtEnrichissement.lean), [modèle de budgets](../../../src/K7pl/GradeBudget.lean), [ASSURANCE.md](../../ASSURANCE.md).

## Critère de sortie

Le type de garantie temporelle est nommé et relié à un modèle de coût et ses hypothèses ; sinon la borne est qualifiée d’abstraite.