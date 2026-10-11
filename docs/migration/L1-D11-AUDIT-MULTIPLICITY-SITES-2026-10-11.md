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


## Addendum — rapprochement indépendant avec les étiquettes courantes

La table [correspondance des numéros imprimés et des étiquettes](../history/correspondance-theoremes-org.md) distingue le numéro relu dans le PDF de septembre et le numéro courant. Elle permet quelques rapprochements, mais **pas** une bijection pour la liste historique de la revue : celle-ci mélange les deux numérotations. Les références qui ne figurent pas dans la colonne « relu » ne doivent pas être requalifiées en identifiants courants sans examiner le passage source exact.

| Référence citée dans la revue consolidée | Correspondance que permet la table | Conclusion sur la dépendance à la loi budgétaire |
|---|---|---|
| Th. 38 | numéro relu 38 → numéro courant 53, `thm:correction_ressource` | Dépendance **indéterminée** : l’invariant instrumenté et les mises à jour de compteur ne sont pas formalisés ; la référence seule ne démontre pas l’emploi de `n(β ⊖ k)=nβ ⊖ nk`. |
| Th. 41 | numéro relu 41 → numéro courant 56, `thm:commutation_traduction` | Aucune invocation explicite de la loi arithmétique dans le bloc courant n’a été établie ; la commutation de traduction/substitution reste une obligation distincte. |
| Th. 45 | absent comme numéro relu ; le numéro courant 45 désigne `thm:boxtimes_addition` | Si l’intention est le numéro courant, le bloc ne traite que le cas d’effet de coût nul et n’exige pas la loi pour une multiplicité budgétaire générale. L’intention historique exacte reste non prouvée. |
| Th. 47 (cas LET/APP) | absent comme numéro relu ; le numéro courant 47 désigne `thm:commutation_monoide` | Le bloc courant impose une multiplicité finie pour l’identité de commutation des familles `π_S` et `φ_n`. Cela concerne l’action sur les effets ; le budget ne peut en être déduit sans définition d’une action budgétaire correspondante. Le lien exact aux cas LET/APP historiques reste à confirmer. |
| Th. 48/27 | le 48 courant désigne `thm:determinisme_parallele` ; le 27 relu désigne `thm:surete_spatiale` | Ces deux correspondances mènent à des objets distincts. La notation « 48/27 » ne permet donc pas d’identifier un seul bloc courant. |
| Th. 32 (EXPAND) | numéro relu 32 → numéro courant 47, `thm:commutation_monoide`, d’après la table imprimée | Cette correspondance n’est pas compatible avec l’étiquette EXPAND associée au numéro 32 dans une autre version de la revue. Pour l’expansion courante, l’étiquette directe est `thm:expansion_macro` (no courant 39 selon la table historique et no d’inventaire 69 dans la vue générée). Le mécanisme actuel passe par substitution et compose les effets dans l’ordre des occurrences ; aucune loi générale de multiplication du budget n’est déclarée comme prémisse. |

### Sites courants à vérifier individuellement

- `thm:distributivite_tronquee` (C2) est maintenant l’identité arithmétique distincte : le multiplicateur doit être fini, ou le coût nul. D8 impose `∞ ⊖ ∞ = ∞`, ce qui conserve le contre-exemple au multiplicateur infini.
- `thm:coherence_axiome` (C2) reste une obligation générale de compatibilité dont la composante budgétaire dépend d’une action `φ_r` et de domaines communs qui ne sont pas encore définis complètement.
- `thm:coherence_usage` (C2) repose sur la séparation factorisée : `Scale_Usage` change l’usage, tandis que `ψ` change le budget. Cette loi ne demande pas la loi de multiplicité budgétaire.
- `thm:action_parallele` (C2) concerne le travail et la profondeur pour multiplicité entière finie ; son esquisse exclut explicitement la transformation du budget.
- `thm:substitution` et `thm:substitution_simultanee` (C3) séparent l’action contextuelle `Scale_Usage` de `φ_n) sur les effets. Ils ne sont pas une preuve de l’identité budgétaire.
- `thm:correction_ressource`, `thm:commutation_traduction` et `thm:expansion_macro` restent des obligations à formaliser ; il faut examiner leurs cas concrets lorsque les compteurs et effets sont explicités.

**Décision d’audit.** Le rapprochement historique est désormais plus précis, mais ne permet toujours pas de déclarer « les six démonstrations auditées et classées ». La numérotation qui mélange des versions et des correspondances contradictoires doit rester marquée comme dette de provenance. La loi arithmétique formalisée dans `K7pl.GradeBudget` constitue un résultat mathématique candidat sur `ℕ∞), pas une décision sur l’usage par une preuve K7PL déterminée. D11 demeure **partiellement exécutée** jusqu’à ce que chaque site soit relié sans ambiguïté à sa dérivation source.
