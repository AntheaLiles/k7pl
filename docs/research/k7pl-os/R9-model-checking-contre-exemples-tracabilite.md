# R9 — Model checking, contre-exemples et traçabilité (P3, transversal)

**Question centrale :** quels outils révèlent des erreurs de protocole avant la preuve Lean, et comment rendre les liens spécification–formalisation–tests auditables ?

## Questions

- Quels modèles bornés d’acteurs, canaux, annulations et budgets sont utiles ?
- Quels invariants et contre-exemples deviennent obligations Lean ou tests de régression ?
- Comment relier un énoncé normatif à Lean sans assimiler lien lexical et preuve ?
- Quelle tranche verticale minimale réunit sémantique, typage, traces et tests ?
- Quel nouvel outil entre dans le TCB ?

## Livrable

Comparer deux ou trois workflows ; définir un modèle borné, ses invariants, la conversion des contre-exemples en tests et une convention de traçabilité. Les prototypes doivent rester sur une branche séparée avec critères reproductibles.

## Prompt prêt à copier

> Évalue un workflow combinant modèle borné (TLA+/TLC/TLAPS ou alternatives), recherche de contre-exemples, tests différentiels et Lean. Choisis un scénario d’acteurs/canaux, définis invariants et cas de panne, transforme les contre-exemples en tests et relie les obligations aux identifiants normatifs et déclarations Lean. Distingue exploration et confiance accordée au kernel Lean ; ne réduis pas la traçabilité à une correspondance lexicale.

## Sources

[TLA+](https://lamport.azurewebsites.net/tla/tla.html), [TLAPS](https://lamport.azurewebsites.net/pubs/tlaps.pdf), [STATUS.md](../../STATUS.md), [ASSURANCE.md](../../ASSURANCE.md), [règles de typage C3](../../../spec/Spec/C3/ReglesDeTypage.lean).

## Critère de sortie

Les outils exploratoires produisent contre-exemples et obligations explicites ; ils ne remplacent pas les preuves Lean ni la clôture de l’étape C.