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

| Référence brute / cas | Correspondance vérifiable à ce stade | Classement prudent de la loi budgétaire et action requise |
|---|---|---|
| Th. 38 | Le numéro « relu 38 » mappe au numéro courant 53, `thm:correction_ressource`. | **Indéterminée.** L’invariant instrumenté et les mises à jour de compteur ne sont pas formalisés. Examiner la dérivation originale et identifier toute équation budgétaire réellement invoquée. |
| Th. 41 | Le numéro « relu 41 » mappe au numéro courant 56, `thm:commutation_traduction`. | **Aucune invocation explicite établie.** La commutation de traduction/substitution reste une obligation distincte ; il faut inspecter la preuve source avant de classer le recours à la loi comme absent. |
| Th. 45 | 45 n’apparaît pas dans la colonne « relu » ; le numéro courant 45 est `thm:boxtimes_addition`. | **Intention historique indéterminée.** Si l’auteur visait le numéro courant, le cas d’effet nul n’exige pas la loi de multiplicité budgétaire. Ne pas attribuer cette conclusion à la référence historique sans son passage source. |
| Th. 47 — LET | 47 n’apparaît pas dans la colonne « relu » ; le numéro courant 47 est `thm:commutation_monoide`, sans correspondance établie avec ce cas LET. | **Indéterminée.** Inspecter le cas LET de la dérivation originale ; distinguer compatibilité d’effet `φ_n` et action sur le budget. |
| Th. 47 — APP | Même collision de numérotation que pour LET ; le texte C3 actuel identifie APP comme une composition à effet non trivial, mais cela ne démontre pas une transformation de budget par multiplicité. | **Indéterminée.** Inspecter le cas APP séparément ; ne pas transférer un classement du cas LET. |
| Th. 48/27 | Deux lectures possibles donnent des objets distincts : 48 courant = `thm:determinisme_parallele` ; 27 relu = numéro courant 27, `thm:surete_spatiale`. | **Référence non univoque.** Déterminer si la barre signifie un renvoi croisé, une ancienne/nouvelle numérotation ou deux sites distincts, à partir du document qui a introduit cette notation. |
| Th. 32 — EXPAND | La table historique mappe « relu 32 » vers le numéro courant 47 (`thm:commutation_monoide`), mais l’étiquette directe de l’expansion est `thm:expansion_macro` (numéro courant 39 dans cette table ; no d’inventaire 69 dans la vue générée). | **Référence contradictoire, dépendance non classée.** Utiliser l’étiquette directe pour l’analyse sémantique, puis corriger la provenance de la numérotation à partir de la source originale. L’expansion passe par substitution ; aucune dépendance à la loi budgétaire n’est encore établie. |

Ce registre compte séparément les deux cas LET/APP, mais ne prétend pas que les lignes correspondent à six objets distincts : la notation `48/27` peut elle-même désigner un ou deux sites. **Le nombre exact des sites historiques reste donc inconnu à partir des éléments présents.** Les éléments actuellement disponibles autorisent un classement local partiel, pas une déclaration que « les six preuves sont auditées ».

### Sites courants à vérifier individuellement

- `thm:distributivite_tronquee` (C2) a maintenant un correspondant arithmétique explicite dans `K7pl.GradeBudget.truncated_sub_mul_compatibility`, avec le domaine exact « multiplicateur fini ou coût nul ». La compilation de cette nouvelle déclaration doit être confirmée sur la CI de la tête actuelle ; même une preuve compilée n'établirait que l’identité sur `ℕ∞`, pas sa dépendance réelle dans un théorème K7PL. D8 impose `∞ ⊖ ∞ = ∞`, ce qui conserve le contre-exemple au multiplicateur infini.
- `thm:coherence_axiome` (C2) reste une obligation générale de compatibilité dont la composante budgétaire dépend d’une action `φ_r` et de domaines communs qui ne sont pas encore définis complètement.
- `thm:coherence_usage` (C2) repose sur la séparation factorisée : `Scale_Usage` change l’usage, tandis que `ψ` change le budget. Cette loi ne demande pas la loi de multiplicité budgétaire.
- `thm:action_parallele` (C2) concerne le travail et la profondeur pour multiplicité entière finie ; son esquisse exclut explicitement la transformation du budget.
- `thm:substitution` et `thm:substitution_simultanee` (C3) séparent l’action contextuelle `Scale_Usage` de `φ_n` sur les effets. Ils ne sont pas une preuve de l’identité budgétaire.
- `thm:correction_ressource`, `thm:commutation_traduction` et `thm:expansion_macro` restent des obligations à formaliser ; il faut examiner leurs cas concrets lorsque les compteurs et effets sont explicités.

**Décision d’audit.** Le rapprochement historique est désormais plus précis, mais ne permet toujours pas de déclarer « les six démonstrations auditées et classées » : le nombre lui-même n’est pas établi à partir de la liste mêlant LET/APP et `48/27`. La numérotation qui mélange des versions et des correspondances contradictoires reste une dette de provenance. Le lemme `K7pl.GradeBudget.top_disjunct_iff_le` ne traite que la normalisation logique de D5 ; `truncated_sub_mul_compatibility` formalise le domaine arithmétique du lemme C2, tandis que `finite_multiplicity_compatibility` en fournit le cas de multiplicité finie. Aucun de ces résultats ne décide de l’usage par une preuve K7PL déterminée. D11 demeure **partiellement exécutée** jusqu’à ce que chaque site soit relié sans ambiguïté à sa dérivation source.
