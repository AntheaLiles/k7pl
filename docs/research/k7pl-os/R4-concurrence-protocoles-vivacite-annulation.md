# R4 — Concurrence, protocoles, vivacité et annulation (P2)

**Question centrale :** les garanties locales de session suffisent-elles à établir la sûreté et la vivacité du système d’acteurs complet ?

## Questions

- Un DAG statique implique-t-il un graphe d’attente dynamique acyclique ? Quelle simulation le prouve ?
- Comment annulation, crash, timeout et arrêt affectent-ils ressources linéaires et protocoles ?
- Quels progrès dépendent de l’équité de l’ordonnanceur ou de l’environnement ?
- Les types de session garantissent-ils la fidélité du protocole, la terminaison ou une propriété plus faible ?
- Faut-il des protocoles globaux/multiparty en plus des sessions locales ?

## Livrable

Petit modèle multi-acteurs, invariants et contre-exemples ; relation de simulation à prouver ; séparation entre sûreté, absence de blocage, terminaison et progrès sous hypothèses d’équité.

## Prompt prêt à copier

> Analyse les garanties de session et de concurrence de K7PL. Sépare fidélité protocolaire, absence de blocage, terminaison et progrès sous équité. Examine le lien entre DAG statique et graphe dynamique d’attente et construis un contre-exemple si la simulation manque. Traite timeout, annulation, crash et récupération des ressources. Propose un modèle borné et des obligations Lean/testables.

## Sources

[Contraintes de valeur C3](../../../spec/Spec/C3/LesContraintesDeValeur.lean), [règles de typage C3](../../../spec/Spec/C3/ReglesDeTypage.lean), [sémantique C4](../../../spec/Spec/C4/SemantiqueOperationnelle.lean), [TLA+](https://lamport.azurewebsites.net/tla/tla.html).

## Critère de sortie

Les propriétés de vivacité sont formulées avec leurs hypothèses ; le lien entre vérification statique et progrès dynamique est prouvé ou marqué ouvert.