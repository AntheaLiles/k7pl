# R1 — Autorité, capacités et révocation aux frontières FFI (P1)

**Question centrale :** les permissions typées peuvent-elles devenir une discipline d’autorité effective depuis la source jusqu’au composant ou périphérique appelé ?

## Questions

Comparer capacités logicielles, capacités noyau et capacités matérielles ; moindre privilège, atténuation, délégation, révocation, domaines de protection, handles générationnels et autorité sur MMIO, IRQ, DMA et mémoire physique.

- Qu’est-ce qui empêche de fabriquer, copier ou réutiliser une autorité révoquée ?
- Une capacité linéaire est-elle imposée à l’exécution ou seulement vérifiée statiquement ?
- Après transfert d’un buffer au FFI, qu’est-ce qui empêche l’appelant de garder un alias après retour, erreur ou annulation ?
- Qui applique l’autorité indépendamment du typage source ?
- Peut-on établir l’absence d’escalade sous composition et délégation ?

## Livrable

Modèle d’autorité, invariants, scénarios adverses et répartition des obligations entre types, runtime, compilateur, noyau et matériel. Le critère de sortie est un mécanisme d’application pour chaque garantie critique ; la révocation ne doit pas dépendre de la bonne volonté du code appelé.

## Prompt prêt à copier

> Évalue si les capacités typées et linéaires de K7PL soutiennent une architecture de moindre privilège. Compare capacités logicielles, noyau et matérielles, délégation, atténuation et révocation. Construis des scénarios FFI, alias après retour, annulation, identifiants recyclés et accès périphériques. Propose les invariants formels et indique les mécanismes exigeant table de handles, noyau ou matériel. Ne traite pas une capacité de type comme une capacité protégée sans preuve d’application.

## Sources

- [Postulats C1](../../spec/Spec/C1/Postulats.lean)
- [Grades C2](../../spec/Spec/C2/AdjonctionsEtEnrichissement.lean)
- [Modèles mémoire C4](../../spec/Spec/C4/ModelesDeMemoire.lean)
- [Invariant mémoire abstrait](../../src/K7pl/MemoryCapability.lean)
- [Genode](https://www.genode.org/documentation/genode-foundations/25.05/architecture/Capability-based_security.html), [CHERIoT RTOS](https://github.com/CHERIoT-Platform/cheriot-rtos/blob/main/docs/architecture.md), [seL4](https://sel4.systems/Verification/)

## Critère de sortie

Chaque garantie d’autorité a une frontière d’application, des hypothèses explicites et un scénario de violation à tester.