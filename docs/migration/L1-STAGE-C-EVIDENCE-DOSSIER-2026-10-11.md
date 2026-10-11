<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier probant de la porte scientifique C — état au 11 octobre 2026

**Statut :** audit documentaire et formel préliminaire, non normatif.  
**Révision de référence :** [621e1485785233a5ac8be5797f22c31bd0dadccd](https://github.com/AntheaLiles/k7pl/commit/621e1485785233a5ac8be5797f22c31bd0dadccd).  
**Verdict : C NON SATISFAITE.** Le dossier localise et ordonne les obligations ; il ne les acquitte pas et ne vaut ni ratification de l’autrice ni preuve mathématique.

## 1. Périmètre et règle de preuve

L’audit confronte les registres L1 à la spécification Verso courante, aux audits sémantiques C8, aux séances 59–62 et aux artefacts réellement présents dans src/. Les conclusions se rapportent au SHA de main indiqué ci-dessus, pas à l’ancien instantané de reprise.

Les catégories sont strictement séparées. Une définition ou une règle **normative** appartient au langage, mais sa présence n’en établit pas la cohérence. Un objet **dérivé/candidat** n’est pas promu par une note de séance. Une **obligation** demeure à établir. Une **preuve sur papier** n’est valable que sous ses hypothèses explicites ; ce n’est ni une preuve Lean ni nécessairement une preuve complète de l’instance K7PL. Un bloc Verso thm et son proofsketch ne sont pas des déclarations de théorèmes Lean correspondantes. Un build, un test ou une CI ne justifie que le périmètre effectivement vérifié. Enfin, un choix sémantique ou une promotion normative demeure une **décision de l’autrice**.

### Registres et audits de référence

- [Registre des objets C](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-THEORY-OBJECTS.md), blob f56ed5088b177402d959a891002ec67f00c5fe20.
- [Sédimentation L1](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-THEORY-SEDIMENTATION.md), blob 273ffe792523ddd440d592a2dcd61c60d3e3aab9.
- [Décisions L1](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-DECISIONS.md), blob 141ca66c8b840bd9a4bb0e46412e6efb4537e18f.
- [Décisions et ratifications](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/DECISIONS.md), blob 476ac431d94b04cdf0e01ba501647c3dff77767b.
- [Plan maître](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/PROJECT-MASTER-PLAN.md), blob 5f32e74a9eadaa7838f79a2b5ceef754f6a54e0c.
- Audits C8 [B07](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-07.md), [B09](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-09.md), [B10](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-10.md), [B11](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-11.md), [matrice de couverture](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-COVERAGE-MATRIX.md), [ratification des classifications](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-STATEMENT-CLASSIFICATION-RATIFICATION.md) et [revue des dépendances](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-DEPENDENCY-SEMANTIC-REVIEW.md).

### Limite des artefacts formels actuels

Les sources spec/Spec/*.lean sont des sources Verso/SpecExt comportant des directives documentaires. Leur bloc thm ou proofsketch n’est pas une preuve Lean correspondante. La bibliothèque src/ ne comprend que des exemples séparés : une preuve arithmétique sur le doublement d’une expression et un LTS de compteur avec deux incréments. Aucun artefact dans src/ n’établit les signatures de C-01, les modes de C-02, la correction de ressource, la substitution, Sim ou H1/H2/H3. Le fichier généré [docs/STATUS.md](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/STATUS.md) annonce zéro ancrage de couplage entre énoncés/formules/règles de spec/ et src/. C’est une lacune de traçabilité formelle disponible, pas une preuve de fausseté d’un énoncé. La matrice C8 indique elle-même que sa couverture des 69 énoncés est documentaire, pas mathématique.

## 2. État GitHub pertinent

| Élément | État vérifié | Conséquence |
|---|---|---|
| main | HEAD 621e1485785233a5ac8be5797f22c31bd0dadccd. | Base de cet audit. |
| PR #54 | Fusionnée le 8 octobre ; commit de fusion 3a83e1f6b8155339d771f6bffb77d4ef0b1999df. | Livraison intégrée, mais elle ne clôt pas C. |
| PR #154 | Fusionnée le 11 octobre par fad8e11478d81f9b37f21a05650358d7e83eaec6. | RECOVERY-STATUS est dans main, mais se rapporte à l’ancien SHA 5655628693eb86eca8f8bef026a1d1f384264a71. |
| PR #148 | Fusionnée par 621e1485785233a5ac8be5797f22c31bd0dadccd pour actualiser le statut généré. | Le succès rapporté est limité au périmètre CI applicable ; le run de statut a sauté des jobs complets avec les filtres de chemins. Ne pas en déduire une preuve mathématique. |
| PR #151 | Fusionnée le 11 octobre ; évaluation bornée Lean/SPDX, chantier K. | Périmètre indépendant de C. |
| PR #153 | Ouverte, non fusionnée ; tête c77e5ae44a0c269e7a3d4f5326357edcfeffd211, base historique 86959948ff36deb6e8ee0985cf22740787696720. Divergente de main : 16 commits en avance, 40 en retard. Le diff touche L1-DECISIONS, DECISIONS et des registres de migration, mais pas L1-THEORY-OBJECTS ni ce nouveau dossier. Aucun statut ni run PR n’a été retourné pour cette tête par les vérifications effectuées. | Ne pas considérer sa fusion ou sa CI actuelle comme acquise. |
| PR #139 | Ouverte, non fusionnée ; tête 74d1a29e21e6c6b3a1392894a8c6fe3a4fb52b01, base historique 868b839998836fc96c14c1677a9c4575dfb23035. Divergente de main : 114 commits en avance, 196 en retard ; diff sur l’ontologie C8 et des sources spec/Spec/C2–C4. | Run 38121849518 réussi sur cette tête pour les jobs Lean, Verso, PDF, outillage Python et contrôles rapides ; certains jobs non centraux/publication ont été sautés. Cela valide le build de cette tête divergente, pas les affirmations mathématiques ni main. Préserver la PR et ses preuves de provenance. |

Les séances 59–62 bornent l’exploration architecturale, mais la spécification normative n’est pas harmonisée avec tous les résultats annoncés par ces séances. Aucune PR ou branche ne doit être fusionnée, supprimée ou nettoyée dans le cadre de ce dossier.

## 3. Matrice C-01 à C-09

### C-01 — Signatures des grades, usages et modes

- **Objets et source canonique :** 𝒢 = 𝓡 × 𝕄 × ℒ × 𝔅, 𝔅 = ℕ∞ ; support d’usage 𝓡 ; π_U ; Bang_𝒢 ; Scale_Usage ; φ_n ; coerce, w, c, ψ, Adm, Consume, W, D, Cost_Budget. Source principale : [C2](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C2/ComonadeExponentielleEtFragments.lean), confrontée aux [séances 21](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-21-grade-architecture.md), [43](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-43-scale-usage-interface.md) et [62](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-62-theory-object-closure-boundary.md).
- **Statuts :** les facteurs du jugement sont normatifs ; π_U et Scale_Usage restent explicitement candidats dans C2 ; Bang_𝒢 est une factorisation candidate ; Cost_Budget est dérivé sous les hypothèses scalaire/P3 ; les compatibilités demeurent des obligations. φ_n concerne la répétition effective, non une multiplication arbitraire du grade complet.
- **Signatures/domaines connus :** C2 expose 𝒢, π_U : 𝒢 → 𝓡 et Scale_Usage : 𝓡 × 𝒢 → 𝒢 agissant seulement sur l’usage. Les domaines exacts/partiels de ψ, φ_n, coerce, w et c ne sont pas tous explicités par leurs usages en prose. Cost_Budget est donné avec flèche partielle alors que max(W,D) paraît total.
- **Hypothèses :** porteurs canoniques 𝕄 et ℒ, algèbre de 𝓡, ordres/direction de ≼, domaine des multiplicités de φ_n, compatibilité de contextes et hypothèses scalaire/P3.
- **Établi / preuve disponible :** les séances 43/51/53/62 donnent l’interface de conception et des calculs algébriques conditionnels. Ce sont des notes, non une ratification normative ou une formalisation Lean de l’instance K7PL. Aucun artefact src/ pertinent n’a été trouvé.
- **Manques et dépendances :** types source/cible et domaines objet par objet ; domaines de ψ, φ_n, Adm et Consume ; cohérence du produit sans inventer un semi-anneau sur 𝒢 ; résolution de la signature partielle/totale. Dépend de C-02 à C-06.
- **Décision autrice :** ratifier ou réviser π_U, Bang_𝒢 et Scale_Usage ; confirmer les porteurs et les domaines de φ_n, ψ et Cost_Budget.
- **Critère vérifiable :** table canonique objet/type/domaine/hypothèses/règles ; chaque opération des règles est typée ; chaque partialité a un domaine explicite ; aucune loi ne découle de la signature seule.

### C-02 — Domaines et directions des relations modales

- **Objets et source canonique :** intervalles syntaxiques U_Lin/U_Aff/U_Rel/U_Unr, triplets M_m=(R_m,Cont(m),Weak(m)), sous-typage ≼, ordre de précision ⊑, π_U. Voir [C3 — morphismes des modes](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C3/LeSystemeGradue.lean#L121-L160) et [C8 B10](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-10.md).
- **Statuts :** strates syntaxiques décrites par le langage ; quatre triplets comme réalisation candidate ; thm:morphismes_modes reste une proposition avec esquisse.
- **Signatures/domaines connus :** M_Lin=(𝓡,{0},false), M_Aff=(𝓡,{0},true), M_Rel=(𝓡,𝓡,false), M_Unr=(𝓡,𝓡,true). Les flèches annoncées sont Lin→Aff, Lin→Rel, Aff→Unr, Rel→Unr ; Aff/Rel seraient incomparables. Lin ⊆ Aff ⊆ Unr est une inclusion syntaxique distincte. π_U(r) ≥ π_U(r′) sous r≼r′ est encore une autre relation.
- **Hypothèses :** contrat exact du morphisme, inclusion sur Cont, préservation de Weak, algèbre/ordre et mise en œuvre des permissions dans les règles. Rel=[1..ω] est théorique, absent des règles courantes.
- **Établi / preuve disponible :** l’esquisse justifie les flèches conditionnellement aux triplets ; B10 dit que leur réalisation par le jugement K7PL reste à vérifier. Pas de preuve Lean K7PL trouvée.
- **Manques/dépendances :** contrat et orientation de Cont ; preuve ou contre-exemple pour chaque flèche/non-flèche ; séparation entre inclusion syntaxique, sous-typage, précision et morphisme. Dépend de C-01/C3.
- **Décision autrice :** confirmer cette réalisation ou choisir explicitement une autre structure/restriction si une comparaison échoue.
- **Critère vérifiable :** matrice des comparaisons, chacune accompagnée d’un contrat et d’une preuve/contre-exemple, puis contrôle des règles. Aucune flèche ne peut être inférée des seuls intervalles.

### C-03 — coerce, w, c, conversions et Scale_Usage

- **Objets et sources :** [C2](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C2/ComonadeExponentielleEtFragments.lean), [séance 61 — coercions](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-61-coercion-transport-closure.md), [séance 53](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-53-theory-object-final-obligations.md), [C3 — substitution](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C3/ReglesDeTypage.lean#L1602-L1645).
- **Statuts :** ConvCtx est un transport syntaxique ; Conv! transporte un type via coerce ; les lois de coerce/w/c sont des obligations avec dépendance catégorique ; Scale_Usage est encore candidate dans C2.
- **Signatures/domaines :** ConvCtx transforme x:_r V en x:_r′ V si r≼r′ ; Conv! est consignée comme coerce_{π_U(r),π_U(r′),A} ; Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩. Les coercions sont définies seulement sur les paires d’indices admissibles.
- **Hypothèses :** ordre/opérations de 𝓡, domaine de coerce, naturalité de la comonade graduée, compatibilité des types contenant ! avec les conversions.
- **Établi / preuve disponible :** identité/composition de ConvCtx suivent d’une relabellisation pure, si cette définition est retenue ; Scale_Usage suit algébriquement sur le candidat. La séance 61 dit que naturalité et compatibilité w/c restent à établir.
- **Manques/dépendances :** lois identité/composition de coerce, naturalité et compatibilité w/c, types précis source/cible, transport de ! et cas Sub/SubBox. Dépend de C-01/C-02/C-06.
- **Décision autrice :** confirmer l’interface d’indexation et les hypothèses externes admissibles.
- **Critère vérifiable :** diagrammes typés/prouvés ou hypothèses externes exactes déclarées ; tous les cas de conversion figurent dans l’induction de substitution.

### C-04 — When, ψ, Adm, Consume et correction de ressource

- **Objets et sources :** §5 de [L1-THEORY-SEDIMENTATION](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-THEORY-SEDIMENTATION.md), [interface budgétaire C2](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C2/ComonadeExponentielleEtFragments.lean), [séance 55](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-55-when-budget-semantics.md) et [séance 59](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-59-when-budget-resolution.md).
- **Statuts :** When/budget sont normatifs ; ψ/Adm/Consume composent l’interface de ressource ; la correction est ouverte ; l’interprétation de P3 appliquée en séance n’est pas une décision autrice confirmée.
- **Signatures/domaines :** Δ₁ ⊠_ε Δ₂ = Δ₁ + ψ(Δ₂,ε) ; Adm(β,κ):=(β=ω)∨(Cost_Budget(κ)≤β) ; Consume(β,κ)=β⊖Cost_Budget(κ) sur le domaine admissible ; When donne κ_ω(ℓ)=⟨ω,ω⟩. Les domaines/partialités effectifs de ψ doivent être confrontés aux règles.
- **Hypothèses :** scalarisation retenue, coût/effet cohérents, compatibilité des liaisons, définition de ⊖ sur tous les cas limites, distinction latence/coût si choisie, et hypothèse de domaine sur ℒ.
- **Établi / preuve disponible :** les séances 55–62 proposent que When produise un effet non borné dont le coût est vérifié au franchissement du contexte via ψ. Elles ne prouvent pas la correction règle par règle. C2 conserve une signature partielle de Cost_Budget alors que max(W,D) paraît total.
- **Manques/dépendances :** coût de chaque règle ; When à budget fini/infini et coûts nul/fini/infinis ; domaine partagé de ψ ; cas ω⊖ω et coût ω sous budget fini. Dépend de C-01/C-05/C-06.
- **Décision autrice :** arbitrer entre attente comptée dans le budget P3 (coût ω, inadmissible au passage d’un budget fini) et latence externe hors budget d’exécution (nécessitant une distinction explicite). L’application différée via ψ/Adm/Consume dans les notes ne ratifie pas d’elle-même le sens de P3.
- **Critère vérifiable :** preuve qu’aucun franchissement inadmissible n’est typable et aucun coût masqué ; cas limites couverts ; décision P3/When explicite, reliée au contrat prouvé.

### C-05 — Agrégateurs W/D et scalarisation Cost_Budget

- **Objets et sources :** formule dans [C2](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C2/ComonadeExponentielleEtFragments.lean), [séance 60](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-60-canonical-cost-aggregators.md), [séance 53](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/history/2026-10-07-pr-02-53-theory-object-final-obligations.md).
- **Statuts :** W/D sont dérivés ; Cost_Budget=max(W,D) est dérivé sous budget scalaire et borne simultanée P3 ; les propriétés requises demeurent des obligations mathématiques.
- **Signatures/domaines :** κ(ℓ)=⟨w_ℓ,s_ℓ⟩ ; W est le supremum des sommes de travail sur les sous-familles finies de ℒ ; D est le supremum des profondeurs ; Cost_Budget=max(W,D). C2 indique toutefois Cost_B : (ℕ∞×ℕ∞)^ℒ ⇀ ℕ∞ ; ⇀ signale une partialité que la formule de max ne restreint pas. Les noms Cost_B et Cost_Budget doivent être unifiés sans changement sémantique implicite.
- **Hypothèses :** ordre/supremums de ℕ∞, addition étendue monotone, composition effective des effets, convention de supremum sur l’ensemble vide et ℒ non vide (ou convention équivalente) pour inférer le coût ω de κ_ω.
- **Établi / preuve disponible :** la séance 60 contient une dérivation sur papier conditionnelle pour monotonie, coût nul, additivité de W, bornes sur D, sous-additivité et minimalité de max. Elle n’est pas formalisée en Lean et doit correspondre aux opérations exactes du manuscrit.
- **Manques/dépendances :** déterminer le domaine total/partiel ; vérifier les lois d’ordre et de composition ; poser ℒ≠∅ ou une convention équivalente. Dépend de C-01/C-04.
- **Décision autrice :** confirmer le domaine de Cost_Budget et les hypothèses scalaire/P3. Ne pas supprimer la partialité d’après la seule note de séance.
- **Critère vérifiable :** toutes les lois prouvées sur les domaines réels ; signature sans ambiguïté ; κ_ω établi sous hypothèses explicites.

### C-06 — Substitution, conversions, actions de contexte et effets répétés

- **Objets et sources :** [C3 — thm:substitution](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C3/ReglesDeTypage.lean#L1602-L1645), [substitution simultanée](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C3/ReglesDeTypage.lean#L1693-L1725), [C8 B11](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-11.md).
- **Statuts :** substitution est une proposition conditionnelle ; la forme simultanée dépend de la première ; Scale_Usage et φ_n ont des rôles séparés.
- **Signatures/domaines :** la conclusion remplace l’action de surface r·Δ′ par Scale_Usage(π_U(r),Δ′) et porte sur terme, type indexé et effet. φ_n n’agit que sur une multiplicité effective admissible.
- **Hypothèses :** types formés sous usages effacés ; lois Scale_Usage ; commutation avec ψ ; conversions compatibles avec les constructeurs ; fraîcheur/lieurs ; domaines de φ_n/effets.
- **Établi / preuve disponible :** C3 présente un plan d’induction et des hypothèses ; B11 maintient le résultat conditionnel. Pas d’induction complète ou de preuve Lean correspondante dans src/.
- **Manques/dépendances :** cas variables/lieurs, Box, App, VECI, SC, Sub, SubBox ; conversions de ! ; ψ/contextes partagés ; effets/budgets ; ordre de substitution selon le contexte réel. Ne pas déduire une multiplicité d’exécution d’un usage rationnel. Dépend de C-01 à C-05.
- **Décision autrice :** aucun renforcement ou changement de statut sans confirmer les signatures et règles de multiplicité normatives.
- **Critère vérifiable :** induction règle par règle avec prémisses typées et fraîcheur explicite ; conversions établies ; corollaire simultané démontré ; aucune utilisation de φ_n hors domaine.

### C-07 — Réduction source, simulation Sim et adéquation

- **Objets et sources :** [C4 — simulation/fidélité](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C4/CalculDeProcessusSousJacent.lean#L299-L337), [C8 B07](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-07.md).
- **Statuts :** la réduction/traduction sont sémantiques/de représentation ; Sim est une obligation ouverte ; la fidélité cible dépend aussi de la préservation du typage et de l’adéquation cible.
- **Signatures/domaines :** configuration ⟨c | μ | τ⟩ ; chaque pas source doit produire un ou plusieurs pas cible modulo congruence, avec extension correspondante de trace. Le texte exclut les grades/raffinements de la conclusion, car la traduction les efface.
- **Hypothèses :** configurations typées, clauses de traduction des opérations/effets, invariants mémoire/trace, ordre du canal temporel, congruence, préservation du typage et adéquation observationnelle.
- **Établi / preuve disponible :** B07 est un audit documentaire provisoire ; il identifie l’obligation manquante sur l’ordre des traces/canal. Le proofsketch est un plan, non une démonstration. src/ ne formalise pas cette traduction.
- **Manques/dépendances :** cas β/communication, produits/sommes/vecteurs, effets, tick, opérations délimitées et congruence ; invariant de canal/trace ; définition exacte des observations. Une simulation avant ne prouve ni bisimulation, ni équivalence bidirectionnelle, ni pleine abstraction. Dépend de la traduction typée, de la commutation de traduction et des obligations de confinement.
- **Décision autrice :** confirmer le périmètre exact de fidélité et les observations, sans étendre la conclusion à une équivalence bidirectionnelle.
- **Critère vérifiable :** simulation typée et prouvée pour chaque règle ; invariant de trace/canal ; adéquation cible distincte ; conclusion limitée au comportement prouvé.

### C-08 — Mémoire abstraite, H1/H2/H3 et profil Π

- **Objets et sources :** [C4 — ModelesDeMemoire](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C4/ModelesDeMemoire.lean#L38-L125), [revue des dépendances](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-DEPENDENCY-SEMANTIC-REVIEW.md), [C8 B11](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-11.md), [L1-DECISIONS / ARB-PR-04](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-DECISIONS.md).
- **Statuts :** sûreté spatiale est conditionnelle à H1/H2/H3 ; introduction_unique est une proposition à preuve incomplète ; Π est un profil de représentation/exécution, pas un invariant abstrait.
- **Signatures/domaines :** H1 : au plus une introduction de WriteCap(r) par région ; H2 : Range disjoints dénotent des régions distinctes ; H3 : les délimiteurs empêchent une valeur cartésienne de capturer une capacité linéaire. Π inclut la révision de spécification, représentation/formalisation, chaîne d’exécution, architecture/matériel, paramètres d’exécution et non-déterminisme pertinent.
- **Hypothèses :** règle d’élimination de l’arène, linéarité d’introduction, définition de Range/disjonction, discipline d’imbrication et définition des revendications de reproductibilité/ABI.
- **Établi / preuve disponible :** sûreté suppose H1 ; le sketch d’introduction_unique indique que le cas d’élimination de l’arène reste à écrire. Le graphe crée une circularité argumentative potentielle pour établir H1, pas un cycle syntaxique. H2/H3 restent séparées. Les audits ne sont pas les preuves des invariants.
- **Manques/dépendances :** prouver H1 indépendamment ou garder l’hypothèse explicitement avec portée restreinte ; prouver H2/H3 distinctement ; relier les garanties concrètes à un Π versionné. Dépend de thm:lemme_capacite, des règles mémoire et du profil.
- **Décision autrice :** (A) établir H1 via une règle d’élimination explicitée, ou (B) assumer H1 comme hypothèse de modèle et réduire/laisser ouverte la revendication d’introduction unique.
- **Critère vérifiable :** voie A/B consignée ; preuve indépendante ou hypothèse H1 explicitée ; preuves distinctes H2/H3 ; claims concrets rattachés à Π sans inférence automatique vers ABI/binaire.

### C-09 — Imports et dépendances formelles externes

- **Objets et sources :** [L1-THEORY-SEDIMENTATION](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-THEORY-SEDIMENTATION.md), [L1-DECISIONS](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/docs/migration/L1-DECISIONS.md), chapitre C2 et ses références.
- **Statuts :** théories des modes et types gradués formalisés : fondations normatives déclarées ; Calf/Decalf : dépendance formelle ; récursion gardée multi-horloges : dépendance à distinguer par couche. P1a (cadre catégorique) est distinct de P1b (interprétation/correction), qui reste ouvert.
- **Signatures/domaines :** chaque usage d’un cadre externe doit identifier version/référence, fragment, hypothèses, mapping K7PL et propriété qui en est déduite.
- **Hypothèses :** correspondance effective du cadre externe avec grades, modalités, jugements, règles, effets et couches temporelles ; fragment et hypothèses empruntées explicites.
- **Établi / preuve disponible :** les registres définissent la méthode de séparation entre engagement K7PL et mécanisme externe ; la table d’instanciation complète de chaque import n’est pas établie par cette règle méthodologique.
- **Manques/dépendances :** version, hypothèses, fragment, mapping et propriété par import ; frontières visibles des hypothèses ; analyse séparée de la récursion. Dépend des objets C effectivement importés.
- **Décision autrice :** confirmer le périmètre normatif des théories des modes/types gradués et les hypothèses externes admissibles ; ne pas rendre Calf/Decalf ou la récursion gardée normatifs par facilité de formalisation.
- **Critère vérifiable :** registre des imports complet et précis, avec hypothèses et mapping ; aucune hypothèse extérieure silencieuse.

## 4. Écarts entre textes normatifs et séances

1. **Séance 62 contre C2 :** les interfaces sont dites stabilisées architecturalement, mais C2 conserve π_U et Scale_Usage comme candidats et Cost_Budget comme partielle alors que max(W,D) paraît total. La séance borne l’exploration sans promouvoir le normatif. Classe : question de représentation et décision autrice, pas preuve.
2. **Séances 59–62 contre ratification P3/When :** l’admissibilité différée via ψ/Adm/Consume est appliquée dans les notes, mais la décision P3 et la correction de ressource restent distinctes. Classe : choix normatif et obligation sémantique.
3. **Inclusion syntaxique contre morphismes de modes :** aucun morphisme ne découle de l’inclusion des intervalles. Classe : représentation et obligation mathématique.
4. **ConvCtx contre Conv! :** identité/composition de relabellisation ne prouvent pas les lois de coerce/w/c. Classe : preuve syntaxique partielle et dépendance catégorique.
5. **max(W,D) contre signature partielle :** preuve papier conditionnelle qui ne tranche pas la totalité ; le cas κ_ω dépend de ℒ non vide ou d’une convention équivalente. Classe : preuve conditionnelle et décision de domaine.
6. **Compilation Verso contre preuve mathématique :** rendu/build et ontologie valident l’outillage et la représentation. Le run #139 est sur une tête divergente. Classe : preuve d’outillage uniquement.
7. **H1 :** la sûreté l’assume ; son théorème candidat ne traite pas l’élimination de l’arène. Classe : obligation avec circularité argumentative potentielle, pas cycle syntaxique.
8. **Sim contre fidélité :** la fidélité dépend de Sim et de l’adéquation cible ; une simulation avant ne prouve pas bisimulation ou pleine abstraction. Classe : obligation sémantique.
9. **Couverture C8 contre validité :** 69 blocs couverts, mais pas 69 preuves. Classe : traçabilité documentaire.

## 5. Bloqueurs priorisés

| Priorité | Bloqueur | Motif | Travail permis à ce stade |
|---|---|---|---|
| P0 | Décisions autrice : promotion de π_U/Scale_Usage/Bang_𝒢 ; domaine de Cost_Budget ; sémantique P3/When ; choix H1. | La preuve doit porter sur un contrat retenu, non sur une sémantique inférée par l’agent. | Exposer options et conséquences ; ne rien promouvoir. |
| P1 | Contrat C-01/C-02 : porteurs, signatures, domaines et directions. | Toutes les autres preuves en dépendent. | Table des signatures et des relations séparées. |
| P1 | Interface C-04/C-05 : coût, effet, domaine, admissibilité et arithmétique aux limites. | La scalarisation seule ne prouve pas la correction de ressource. | Inventaire des cas et hypothèses, sans modifier les règles. |
| P2 | C-03 conversions catégoriques. | La relabellisation ne prouve pas la naturalité de la comonade. | Diagrammes et hypothèses externes exactes. |
| P2 | C-06 substitution. | Induction dépendante de toutes les interfaces et règles. | Arbre de preuve et inventaire exhaustif des cas. |
| P2 | C-08 H1/H2/H3. | H1 supposée et justification incomplète ; H2/H3 indépendantes. | Présenter les voies A/B sans choisir. |
| P2 | C-07 Sim. | Fidélité dépend de la trace/canal et de l’adéquation cible. | Inventaire des réductions, traductions et invariants. |
| P3 | C-09 imports. | Une référence ne prouve pas l’instance K7PL. | Références, hypothèses, mapping et propriété. |

## 6. Ordre de traitement recommandé

1. Maintenir le gel normatif : aucun changement de spec/ ou src/ dans cette passe.
2. Obtenir et consigner les décisions P0 : architecture d’indexation/action, totalité/partialité de Cost_Budget, interprétation P3/When, traitement de H1. Un report laisse explicitement l’obligation ouverte.
3. Stabiliser les contrats C-01/C-02 après ces décisions : signatures, relations distinctes, domaines et directions.
4. Démontrer C-03 et C-05 sur les objets retenus : coercions/naturalité et lois exactes des agrégateurs.
5. Traiter C-04 puis C-06 : correction de ressource, puis induction complète de substitution.
6. Décharger C-07/C-08 comme obligations distinctes et bloquantes ; instruire C-09 en parallèle sans import implicite d’hypothèses.
7. Revoir la porte C sur le SHA qui contiendra les preuves et décisions. Vérifier les critères C-01 à C-09 un à un, les statuts épistémiques et la traçabilité normative/formelle, puis obtenir une revue humaine explicite. Aucun travail D–J avant ce verdict.

## 7. Verdict à la révision auditée

**C — NON SATISFAITE.** Les séances 59–62 bornent l’exploration, mais les objets encore candidats dans C2, la divergence de signature de Cost_Budget, les obligations ouvertes et les décisions non ratifiées empêchent de considérer la porte franchie.

- Changements normatifs dans cette passe : aucun.
- Nouvel artefact Lean de preuve : aucun.
- Prochain pas autorisé : compléter et faire ratifier les décisions P0, puis préparer les preuves sur le contrat retenu.
- Interdictions : ne pas modifier spec/, ne pas démarrer D–J et ne pas modifier manuellement docs/STATUS.md.

## 8. Provenance des sources normatives examinées

- [C2 — ComonadeExponentielleEtFragments.lean](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C2/ComonadeExponentielleEtFragments.lean), blob 78786908ab8dc0b27074e81b23f05359293ea955.
- [C3 — LeSystemeGradue.lean](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C3/LeSystemeGradue.lean), blob 978544a8f6c86005383bd4d1e786951ae42b5a01.
- [C3 — ReglesDeTypage.lean](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C3/ReglesDeTypage.lean), blob 4d8ac55d37ba610d5e734ba4e4a19b71f84b1191.
- [C4 — CalculDeProcessusSousJacent.lean](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C4/CalculDeProcessusSousJacent.lean), blob 5a33a11e5b8685b7eef9cbd1e22118f66d2a6746.
- [C4 — ModelesDeMemoire.lean](https://github.com/AntheaLiles/k7pl/blob/621e1485785233a5ac8be5797f22c31bd0dadccd/spec/Spec/C4/ModelesDeMemoire.lean), blob 8df4c27f839cd723976bad54981903aafc7965e2.

**Nature de cette passe :** audit documentaire et comparaison GitHub des têtes PR pertinentes. Aucune preuve formelle nouvelle, exécution Lean locale ou ratification de l’autrice n’est revendiquée.
