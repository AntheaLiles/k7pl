<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# D11 — audit des démonstrations dépendant de la loi de multiplicité

Date : 11 octobre 2026.

## Décision d’autrice

**Option A ratifiée : auditer les démonstrations et leurs dépendances avant de fixer les hypothèses exactes du lemme arithmétique.** Cet ordre de travail ne ratifie ni la loi générale ni un domaine particulier pour les multiplicités.

## Résultat provisoire de l’audit documentaire

Les traces historiques localisent les démonstrations affectées aux références « Th. 38, 41, 45, 47 (cas LET et APP), 48/27, 32 ». Cette notation n’est pas un inventaire univoque de six objets : elle mélange des numéros de théorèmes, des cas de règle et une correspondance 48/27. Le nombre et l’identité exacts des sites doivent donc être réconciliés avec les étiquettes de la source Verso courante avant toute modification scientifique.

L’audit distingue désormais trois dépendances possibles :

1. **Compatibilité d’usage factorisée.** Si le site ne fait qu’appliquer `Scale_Usage`, qui ne modifie pas le budget, la loi `n (β ⊖ k) = (n β) ⊖ (n k)` n’est pas nécessaire. La preuve attendue doit utiliser la commutation composante par composante de `Scale_Usage` et de `ψ`, sur leurs domaines définis.
2. **Répétition d’effet.** Si le site applique `φ_n` à un effet et doit établir une compatibilité avec le contexte, c’est une obligation de ré-invocation distincte. Elle ne justifie la loi budgétaire que si la dérivation transforme effectivement le budget par multiplicité et compare les deux expressions arithmétiques.
3. **Transport général.** Si le site invoque `r · ψ(Δ, ε) = ψ(r · Δ, φ_r(ε))`, il dépend de la proposition générale de compatibilité, dont les actions, domaines communs et composante budgétaire ne sont pas encore complètement définis. Le renvoi à cette proposition ne vaut pas preuve de la loi conditionnelle.

## Constats et limites

- C2 indique explicitement que la loi arithmétique n’est pas requise par `Scale_Usage` et ne doit pas être une prémisse générale de substitution.
- La règle `App` et la règle `Let` portent les deux compositions avec un effet non trivial selon le texte de C3. Les autres règles mentionnées comme éliminant une valeur utilisent un effet neutre ; leur `⊠` se réduit à l’addition ponctuelle sous l’hypothèse de coût nul.
- Le schéma de ré-invocation distingue déjà `Scale_Usage(n, Δ)` et `φ_n(ε)`, et fait de leur compatibilité une obligation séparée. Il précise que l’action contextuelle factorisée ne multiplie pas le budget.
- Les éléments consultés ne suffisent pas encore à établir une correspondance exhaustive, étiquette par étiquette, entre toutes les références historiques et les blocs Verso courants. Le présent résultat est donc un **audit documentaire provisoire**, pas la clôture de l’audit des six démonstrations.

## Actions avant de fixer le lemme

1. Établir une table de correspondance pour chaque site historique : théorème/étiquette Verso actuelle, règle ou transformation instanciée, et dépendance explicitement invoquée.
2. Pour chaque site, classer la loi budgétaire comme `requise`, `non requise`, ou `indéterminée`, avec une justification locale.
3. Ne fixer les hypothèses du lemme conditionnel qu’après cette classification ; traiter séparément les sites réellement dépendants d’une action budgétaire par multiplicité.
4. Ne modifier aucune source normative `spec/` ou `src/` dans le cadre de cette décision.

Aucune preuve Lean, exécution de tests, validation CI ou garantie d’exécution n’est revendiquée. La porte C demeure **NON SATISFAITE**.
