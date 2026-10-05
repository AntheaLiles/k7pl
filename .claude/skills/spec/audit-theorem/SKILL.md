---
name: audit-theorem
description: Auditer la portée, les hypothèses et le statut de preuve d'un théorème ou énoncé de k7pl.
---

# Audit d'énoncé

Décomposer :

`énoncé → termes → hypothèses → conclusion → contre-exemples → portée`.

Vérifier la différence entre :

- validité logique ;
- plausibilité ;
- argument informel ;
- formalisation Lean ;
- preuve Lean.

Chercher activement un contre-exemple lorsque l'énoncé peut être invalidé par une hypothèse manquante.

Ne pas reformuler l'énoncé comme conséquence de l'implémentation.

La sortie doit permettre à un autre agent de décider si l'on doit prouver, restreindre, conditionner ou laisser ouvert l'énoncé.
