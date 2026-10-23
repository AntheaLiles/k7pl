# R3 — Confidentialité, intégrité et non-interférence (P1)

**Question centrale :** quelles observations un acteur peut-il distinguer ou provoquer via valeurs, messages, ordre, durée et effets de bord ?

## Questions

- La propriété compare-t-elle deux exécutions qui diffèrent uniquement par une donnée secrète ou une entrée de confiance ?
- Messages, ordre, blocage, terminaison, erreurs, budgets et temps sont-ils observables ?
- Quelles exceptions sont admises : déclassification ou endorsement explicites ?
- Comment traiter communications, acteurs concurrents, FFI et primitives matérielles ?
- Une discipline constant-time est-elle nécessaire pour certains secrets ?

## Livrable

Définir les observables et relations d’équivalence entre exécutions ; expliciter hypothèses et exclusions ; fournir des contre-exemples pour les canaux hors périmètre ; proposer des obligations formelles graduelles. Séparer confidentialité, intégrité, non-interférence et résistance aux canaux auxiliaires.

## Prompt prêt à copier

> Évalue la portée des grades de confidentialité/intégrité de K7PL. Définis une propriété relationnelle et ses observables, dont messages, ordre, terminaison, erreurs et temps. Analyse communications, déclassification, endorsement, FFI et concurrence. Compare non-interférence et vérification constant-time par comparaison de deux exécutions. Propose des énoncés minimaux et indique les garanties impossibles sans modèle temporel et matériel.

## Sources

[Grades C2](../../../spec/Spec/C2/AdjonctionsEtEnrichissement.lean), [schémas de métathéorie C2](../../../spec/Spec/C2/SixSchemasDeMetatheorie.lean), [ct-verif](https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/almeida), [ASSURANCE.md](../../ASSURANCE.md).

## Critère de sortie

Observables, exceptions, hypothèses et limites sont explicites ; aucun grade isolé n’est présenté comme preuve d’une confidentialité globale.