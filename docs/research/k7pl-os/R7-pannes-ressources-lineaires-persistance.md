# R7 — Pannes, annulation, ressources linéaires et persistance (P3)

**Question centrale :** comment capacités, messages et journaux se comportent-ils lorsque les acteurs échouent, sont annulés ou redémarrent ?

## Questions

- Une ressource linéaire est-elle consommée, rendue ou transférée lors d’une annulation ?
- Que devient une capacité si une opération échoue entre deux étapes ?
- Les journaux suffisent-ils à rejouer l’exécution et expliquer les effets externes ?
- Quelle est la sémantique d’un crash pendant une écriture ou une publication ?
- Quelles hypothèses concernent stockage, ordre d’écriture, flush et matériel ?

## Livrable

Machine à états du cycle de vie des acteurs et ressources, points de crash, invariants de récupération et tests de panne/reprise. Séparer preuves formelles, tests et hypothèses matérielles.

## Prompt prêt à copier

> Analyse la sémantique K7PL en présence de crash, annulation, timeout et redémarrage. Suis capacités, messages, budgets et journaux à travers les points de panne. Propose règles de transfert/nettoyage, invariants de reprise et scénarios de crash consistency. Distingue replay déterministe, auditabilité et cohérence transactionnelle ; précise ce qui dépend du runtime, du stockage et du matériel.

## Sources

[Sémantique C4](../../../spec/Spec/C4/SemantiqueOperationnelle.lean), [architecture système C4](../../../spec/Spec/C4/EchelleDuSysteme.lean), [contraintes de valeur C3](../../../spec/Spec/C3/LesContraintesDeValeur.lean), [ASSURANCE.md](../../ASSURANCE.md).

## Critère de sortie

Les effets et ressources ont un comportement défini lors d’échec ; replay n’est pas confondu avec persistance atomique.