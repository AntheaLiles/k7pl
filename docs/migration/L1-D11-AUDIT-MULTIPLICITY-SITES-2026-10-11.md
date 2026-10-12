<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# D11 — audit des démonstrations dépendant de la loi de multiplicité

Date : 11 octobre 2026.

## Décision d’autrice

**Option A ratifiée : auditer les démonstrations et leurs dépendances avant de fixer les hypothèses exactes du lemme arithmétique.** Cet ordre de travail ne ratifie ni la loi générale ni un domaine particulier pour les multiplicités.

## Résultat provisoire de l’audit documentaire

La provenance de la liste est maintenant identifiée : la revue indépendante [`docs/peer-review/pr-02/qwen.md`](../peer-review/pr-02/qwen.md), section R-02, écrit explicitement que la loi est invoquée par « Th. 38 (`⊠` généralise +), Th. 41 (substitution), Th. 45 (correction de ressource), Th. 47 (lemme fondamental, cas LET et APP), Th. 48/27 (traduction), Th. 32 (EXPAND) ». Le reviewer qualifie cette liste de « six démonstrations ». On sait donc exactement d’où vient la notation et quelles descriptions la revue lui associe. En revanche, le numéro courant du tableau `correspondance-theoremes-org.md` n’utilise pas le même système pour tous ces identifiants ; le rapprochement ci-dessous est donc **sémantique**, pas une équivalence mécanique des nombres imprimés. Les cas LET et APP demeurent deux sous-cas d’un même Th. 47 dans la formulation du reviewer ; la notation `48/27` est conservée comme une référence double dont l’histoire reste à expliquer.

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

| Référence telle que citée dans la revue R-02 | Cible courante candidate, par le nom de l’objet | Dépendance à la loi budgétaire et action requise |
|---|---|---|
| Th. 38 — `⊠` généralise + | `thm:boxtimes_addition` (correspondance sémantique par titre ; ce n’est pas le « relu 38 » du tableau du 1er octobre) | **À établir.** Inspecter la dérivation qui relie `⊠` à `+` et relever la formule exacte de transport budgétaire ; ne pas la déduire du titre du théorème. |
| Th. 41 — substitution | `thm:substitution` (cible candidate par l’objet annoncé ; pas par le numéro courant 41) | **À établir.** Refaire la recherche dans les cas d’induction, en distinguant `Scale_Usage`, `φ_n`, `ψ` et la composante budget. |
| Th. 45 — correction de ressource | `thm:correction_ressource` (cible candidate par l’objet annoncé) | **À établir.** Identifier dans l’argument du potentiel chaque mise à jour budgétaire réellement utilisée ; l’énoncé seul n’établit pas la dépendance. |
| Th. 47 — lemme fondamental, cas LET | `thm:lemme_fondamental` (cible candidate) | **À établir séparément.** Retrouver le cas LET du proofsketch original et dire si l’équation de multiplicité budgétaire y est effectivement invoquée. |
| Th. 47 — lemme fondamental, cas APP | `thm:lemme_fondamental` (même énoncé, autre cas) | **À établir séparément.** Le cas APP compose un effet non trivial dans C3, mais cela ne prouve pas qu’il multiplie le budget ni que cette identité arithmétique est la prémisse employée. |
| Th. 48/27 — traduction | `thm:commutation_traduction` est la cible sémantique plausible d’après son intitulé courant ; l’équivalence exacte de 48 et 27 n’est pas documentée. | **Référence double non résolue.** Examiner la source qui a créé `48/27` pour déterminer si c’est une paire ancien/nouveau, deux énoncés ou une référence croisée. Inspecter ensuite la dérivation source. |
| Th. 32 — EXPAND | `thm:expansion_macro` (cible candidate par l’étiquette directe EXPAND et son intitulé) | **À établir.** La revue Qwen avertit que les effets composent dans l’ordre des occurrences. Suivre le calcul de l’expansion sans introduire une puissance budgétaire injustifiée. |

Le tableau ci-dessus fournit des **cibles courantes candidates par le nom de l’objet**, pas une table de correspondance numérique certifiée : le tableau de correspondance des numéros est un instantané daté du 1er octobre et ses colonnes « relu/courant » ne sont pas les numéros employés par la revue Qwen de R-02. Les six cibles de haut niveau sont celles explicitement énumérées par la revue ; le Th. 47 contient deux cas (LET/APP) et la notation 48/27 reste un identifiant double non expliqué. Ainsi, la provenance de la liste est retrouvée, mais les dérivations et dépendances exactes ne sont toujours pas réconciliées. **D11 demeure partiellement exécutée.**


### Sites courants à vérifier individuellement

- `thm:distributivite_tronquee` (C2) a maintenant un correspondant arithmétique explicite dans `K7pl.GradeBudget.truncated_sub_mul_compatibility`, avec le domaine exact « multiplicateur fini ou coût nul ». La compilation de cette nouvelle déclaration doit être confirmée sur la CI de la tête actuelle ; même une preuve compilée n'établirait que l’identité sur `ℕ∞`, pas sa dépendance réelle dans un théorème K7PL. D8 impose `∞ ⊖ ∞ = ∞`, ce qui conserve le contre-exemple au multiplicateur infini.
- `thm:coherence_axiome` (C2) reste une obligation générale de compatibilité dont la composante budgétaire dépend d’une action `φ_r` et de domaines communs qui ne sont pas encore définis complètement.
- `thm:coherence_usage` (C2) repose sur la séparation factorisée : `Scale_Usage` change l’usage, tandis que `ψ` change le budget. Cette loi ne demande pas la loi de multiplicité budgétaire.
- `thm:action_parallele` (C2) concerne le travail et la profondeur pour multiplicité entière finie ; son esquisse exclut explicitement la transformation du budget.
- `thm:substitution` et `thm:substitution_simultanee` (C3) séparent l’action contextuelle `Scale_Usage` de `φ_n` sur les effets. Ils ne sont pas une preuve de l’identité budgétaire.
- `thm:correction_ressource`, `thm:commutation_traduction` et `thm:expansion_macro` restent des obligations à formaliser ; il faut examiner leurs cas concrets lorsque les compteurs et effets sont explicités.

**Décision d’audit.** La provenance de la liste des six cibles de haut niveau est retrouvée dans la revue Qwen R-02. La dépendance de chaque dérivation demeure non classée jusqu’à l’inspection des passages correspondants, et la relation exacte entre les nombres `48/27` reste à expliquer. La dette porte maintenant sur le raccord preuve/cible et non plus sur l’origine de la citation. Le lemme `K7pl.GradeBudget.top_disjunct_iff_le` ne traite que la normalisation logique de D5 ; `truncated_sub_mul_compatibility` formalise le domaine arithmétique du lemme C2, tandis que `finite_multiplicity_compatibility` en fournit le cas de multiplicité finie. Aucun de ces résultats ne décide de l’usage par une preuve K7PL déterminée. D11 demeure **partiellement exécutée** jusqu’à ce que chaque site soit relié sans ambiguïté à sa dérivation source.
