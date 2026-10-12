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

| Référence source R-02 | Cible sémantique courante candidate | Revue adverse du proofsketch courant | Dépendance historique |
|---|---|---|---|
| Th. 38 — `⊠` généralise + | `thm:boxtimes_addition` dans C3, cible par intitulé plutôt que par numéro. | Le sketch traite uniquement l’effet temporel nul, via `β ⊖ 0 = β`. Il ne présente ni multiplicité `n`, ni budget multiplié, ni l’identité `n(β ⊖ k)=nβ ⊖ nk`. | **Pas d’usage direct établi dans le sketch courant.** Vérifier si R-02 visait un autre passage ou une ancienne version. |
| Th. 41 — substitution | `thm:substitution` dans C3. | Le sketch courant invoque les lois de `Scale_Usage`, sa commutation avec `ψ`, l’additivité/composition contextuelles et les conversions. Il sépare `φ_n` sur les effets de l’action sur le contexte ; il ne dérive pas la loi budgétaire. | **Pas de prémisse budgétaire directe établie.** Formaliser l’induction et comparer avec la version historique exacte. |
| Th. 45 — correction de ressource | `thm:correction_ressource` dans C4. | Le statement introduit une sémantique instrumentée et le compteur `ν`. Le sketch n’explicite ni transitions instrumentées par règle, ni mises à jour du compteur, ni équation budgétaire détaillée. | **Indéterminée.** La correction de ressource n’est pas démontrée par le sketch ; expliciter les transitions avant de décider si le lemme arithmétique est nécessaire. |
| Th. 47 — lemme fondamental, cas LET | `thm:lemme_fondamental` dans C4. | Le sketch s’appuie sur substitution et commutation de `Scale_Usage` avec `ψ`; il n’utilise pas explicitement une multiplication de budget dans le cas LET. | **Pas d’usage direct établi.** Retrouver le cas historique et distinguer transport de contexte et ré-invocation d’effet. |
| Th. 47 — lemme fondamental, cas APP | `thm:lemme_fondamental` dans C4, même énoncé mais cas distinct. | Le sketch actuel évoque une obligation supplémentaire seulement si une construction ré-invoque effectivement un effet par `φ_n`, avec compatibilité budgétaire à définir. | **Conditionnelle et non démontrée.** Ne pas inférer de la composition d’effet qu’une action de multiplicité sur le budget est automatiquement utilisée. |
| Th. 48/27 — traduction | `thm:commutation_traduction` dans C4 est la cible sémantique candidate. | Le sketch invoque induction sur le terme, substitution et loi de portée/extrusion ; aucune utilisation directe de l’identité budgétaire n’y apparaît. | **Usage direct non établi ; notation double non résolue.** Identifier pourquoi R-02 note `48/27`. |
| Th. 32 — EXPAND | `thm:expansion_macro` dans C5. | Le sketch compose les effets dans l’ordre syntaxique des occurrences. La non-commutativité de la quantale interdit généralement de regrouper les occurrences en `φ_n(ε_i)` sans hypothèse supplémentaire. Le grade déclaré met à l’échelle le contexte par `Scale_Usage`, pas directement l’effet ou le budget. | **Pas d’usage direct établi dans le sketch courant.** L’affirmation R-02 pourrait concerner une autre version ou un autre passage, à retrouver. |

R-02 affirme que la loi intervient dans six démonstrations de haut niveau ; la liste développe LET et APP comme deux sous-cas du Th. 47, et conserve `48/27` comme référence double dont la relation n’est pas documentée. Les intitulés fournissent des cibles sémantiques plausibles, pas une équivalence certifiée entre numéros historiques et étiquettes actuelles. Dans le proofsketch courant, un usage direct de la loi de multiplicité n’est pas établi pour `boxtimes_addition`, `substitution`, `commutation_traduction` et `expansion_macro` ; `correction_ressource` et le cas APP restent indéterminés ou conditionnels faute de dérivation détaillée. Ce constat adverse ne réfute pas une dépendance dans une version historique non retrouvée, mais interdit de présenter cette dépendance comme vérifiée sur les sources courantes. **D11 demeure partiellement exécutée.**



### Sites courants à vérifier individuellement

- `thm:distributivite_tronquee` (C2) a un correspondant Lean `K7pl.GradeBudget.truncated_sub_mul_compatibility`, valide sur `ℕ∞` sous `u ≠ ⊤ ∨ k = 0`. Ce résultat ne rattache pas l’identité à une règle K7PL.
- `thm:coherence_axiome` (C2) reste une obligation générale de compatibilité : `φ_r`, son domaine et les actions communes aux deux membres ne sont pas encore entièrement définis.
- `thm:coherence_usage` (C2) relève de la factorisation actuelle : `Scale_Usage` agit sur l’usage, `ψ` transporte le budget. Le sketch n’exige pas la loi de multiplicité budgétaire.
- `thm:action_parallele` (C2) traite le travail et la profondeur pour une multiplicité naturelle finie ; son sketch exclut explicitement toute transformation du budget.
- `thm:substitution` et `thm:substitution_simultanee` (C3) restent `under-review/proofsketch`. Le sketch courant appelle les lois de `Scale_Usage`, `ψ` et les conversions, sans démontrer l’identité de multiplicité budgétaire.
- `thm:correction_ressource` et `thm:lemme_fondamental` (C4) restent à prouver règle par règle et avec une sémantique instrumentée explicite. La dépendance budgétaire de leurs cas n’est pas établie.
- `thm:commutation_traduction` (C4) invoque substitution et loi de portée, sans appel direct au lemme arithmétique dans le sketch courant.
- `thm:expansion_macro` (C5) conserve l’ordre des occurrences pour les effets et ne regroupe pas en général sous `φ_n`, du fait de la non-commutativité ; le sketch courant ne fait pas de la loi de multiplicité budgétaire une prémisse.

**Décision d’audit.** La provenance de la liste R-02 est retrouvée, mais le lien entre ces affirmations historiques et les preuves actuelles n’est pas établi. Quatre proofsketches courants ne montrent pas d’usage direct de la loi budgétaire ; deux obligations substantielles restent indéterminées ou conditionnelles. Le lemme `K7pl.GradeBudget.top_disjunct_iff_le` traite seulement la normalisation de D5 sous `ℕ∞` ; `truncated_sub_mul_compatibility` établit une identité arithmétique sur `ℕ∞`, sans prouver qu’une dérivation K7PL en dépend. **D11 demeure partiellement exécutée** tant que chaque affirmation historique ne peut être rattachée à une version source et à une dérivation détaillée.