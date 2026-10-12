<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Ratification D7 — domaine de ψ indépendant de Consume

**Date :** 11 octobre 2026  
**Statut :** décision conceptuelle consignée ; contrat formel et preuves ouverts.  
**Portée :** documentation de recherche ; aucun changement normatif de `spec/` ou `src/`.

## Décision ratifiée

L’autrice retient l’option B : le domaine de `ψ` est indépendant de la définissabilité de `Consume`.

Il ne faut donc pas imposer par définition que `ψ` soit définie exactement lorsque `Consume` l’est. Réciproquement, le fait que `ψ` soit définie ne prouve ni que la traversée d’un effet soit autorisée, ni que le budget soit suffisant, ni que la consommation puisse être effectuée.

## Obligations ouvertes

1. Définir le domaine et le codomaine formels de `ψ`.
2. Spécifier séparément les conditions de typage et d’autorisation qui permettent la traversée d’un effet.
3. Identifier les règles qui requièrent une consommation budgétaire définie et comment elles imposent cette précondition.
4. Établir le lien entre le coût annoncé par `Cost_Budget`, la consommation effectuée et les bornes effectives d’exécution.
5. Maintenir les preuves Lean et les validations empiriques distinctes des décisions d’autrice consignées ici.

## Statut épistémique

D7 décide uniquement l’indépendance conceptuelle des domaines. Aucune définition formelle complète, preuve Lean, validation par tests/CI ni garantie d’exécution n’est revendiquée. La porte C demeure **NON SATISFAITE**.
