<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Instruction en C des constats scientifiques de l'archive PR #10

**Révision instruite :** `main`, SHA `99a7375e764e86b3c19c19be82accd8db6096a91` (13 octobre 2026). Aucun fichier de `spec/` ni de `src/` ne change jusqu'à `06f8466`.
**Archive :** branche `valuable/claude/lean4-reuse-init-qvzlcg`, commit `d39d012`, PR #10 fermée sans fusion ; revue de l'archive dans [`BRANCHES-STATUS.md`](../tracking/BRANCHES-STATUS.md), section 5.
**Mandat :** décision de l'autrice du 13 octobre 2026 : « instruire en C les constats scientifiques de l'archive ».
**Verdict global : aucun objet C n'est fermé ; porte C NON SATISFAITE.** Rapport non normatif. Aucune modification du manuscrit n'est faite ni présentée comme faite ; aucune décision d'autrice n'est inférée.

## 0. Méthode et statut

Les constats de l'archive portaient souvent sur un texte que l'archive avait elle-même modifié ensuite (schémas des séances 29 et 32, genre `maillon`, `eq:traduction-fils`, `thm:chaine_fils`). Aucun de ces ajouts n'est dans `main`. Chaque constat est donc rejugé contre le seul texte de `main`.

Quatre revues antagonistes, en lecture seule, ont instruit les constats le 14 octobre 2026. Leurs arguments sont des **esquisses papier, non mécanisées**. Les contre-exemples ont en outre été recalculés sur des modèles finis par des scripts hors dépôt ; ce calcul vérifie les exemples, il ne prouve rien en général. Aucun Lean de `src/` ne couvre les objets instruits : `src/K7pl/Semantics.lean` est un LTS jouet, `src/K7pl/WhenBoundary.lean` un contrat comptable qui « ne définit pas la règle opérationnelle `When` », `src/K7pl/GradeBudget.lean` ne traite ni `φ_n`, ni `w`, `s`, `δ`.

Verdicts employés : **confirmé** (contre-exemple ou argument explicite), **infirmé**, **dépend d'un choix** (options et conséquences), **indéterminé** (ce qui manque).

| § | Constat | Verdict | Objets |
|---|---|---|---|
| 1 | `φ_n` et morphisme de monoïde | confirmé dans le modèle libre ; portée dépendant du sens de `End_mon` ; **défaut nouveau au cas ω** | C-01, C-03, C-06, C-09 |
| 2 | monotonie en `ℓ` de la relation logique | confirmé sur l'univers non restreint ; aucun énoncé de `main` ne l'invoque | C-02, C-07, C-09 |
| 3 | formes temporelles et `thm:progres` | confirmé pour `delay` ; dépend d'un choix pour `always`/`now` ; indéterminé pour `when` | C-04, C-07 |
| 4 | formes terminales de `thm:progres` ; `Guard` et jonction | confirmé | C-07 |
| 5 | `spawn`, `send`, `guard` : traduction, couplage, `w`/`s`, `Tick` | confirmé textuellement ; conséquences dépendant d'un choix | C-01, C-05, C-07 ; étape F |
| 6 | singularités des roues (`1/0`, règle de réunion) | phrase de la spec inexacte ; affirmations de la note de recherche inexactes pour `main` | D (BLOQ-12, IMPL-07), frontière C5 |
| 7 | constats connexes, absents de l'archive | à instruire séparément | C-01, C-04, C-06, C-07 |

## 1. `φ_n` et morphisme de monoïde

**Archive.** Séance 24 (`docs/journal/2026-10-06-pr-02-24-loi-distributive.md`, l. 10-14) et `docs/recherche/instruction-des-decisions.md` (l. 94-96) : `φ_n(ε) = ε^n` ne serait pas un morphisme de monoïde dans une quantale non commutative, car `(εδ)^n ≠ ε^n δ^n` ; la loi distributive serait donc « affaiblie ».

**`main`.**
- `spec/Spec/C3/ReglesDeTypage.lean`, l. 638-645 : `φ_n` envoie `⟨ε₀,k⟩` sur `⟨ε₀^n, nk⟩` ; « elle est un morphisme de monoïdes », justifié par `φ_n ∘ φ_m = φ_{nm}`, `φ_1 = id`, `φ_0` constant à l'unité.
- l. 657 (`eq:monoide`) : `ℳ = ⟨φ_n, π_S⟩ ⊆ End_mon(ℰ)` ; l. 846-855 : formes normales `(n,S)`, égalité décidée sur ce couple.
- `ℰ₀` est **non commutatif par définition** : `spec/Spec/C1/AxiomatiqueGerminale.lean`, l. 281-283 et 447-454 ; `ReglesDeTypage.lean`, l. 1271 ; `π_S` garde les opérations « dans leur ordre » (l. 647-649). Le facteur temporel est additif, donc commutatif.
- Loi distributive : `AxiomatiqueGerminale.lean`, l. 317-321 (`λ_{r,ε}`, « loi distributive graduée ») ; l. 340 restreint la relation entre `φ_n` et `Φ_dist` « aux cas et hypothèses explicitement démontrés », alors que `ReglesDeTypage.lean`, l. 639-641, les identifie.

**Analyse.**
- *(a) Multiplicativité.* Dans la présentation libre (`Ops ⊇ {a,b}`, `Rel = ∅`, quantale `P(Ops*)`), `φ₂(ab) = abab` et `φ₂(a)φ₂(b) = aabb` sont distincts et incomparables : pour `n ≥ 2`, `φ_n` n'est pas un endomorphisme de monoïde de `(ℰ,·,1)`, ni lax. La formule universelle de l'archive est trop forte : dans `P(M)` pour la bande à zéro à gauche `M = {1,a,b}`, quantale non commutative, `φ_n = id` est multiplicatif.
- *(b) Ce que prouve la justification.* `φ_n ∘ φ_m = φ_{nm}` établit au mieux que `n ↦ φ_n` est un morphisme de `(ℕ∞,·,1)` dans `(End(ℰ),∘,id)`, pas la multiplicativité de chaque `φ_n`. Les indices internes favorisent la lecture « monotone » de `End_mon` : `AdjonctionsEtEnrichissement.lean`, l. 385 (`→_mon`), `ReglesDeTypage.lean`, l. 667-673 et 864, `SemantiqueOperationnelle.lean`, l. 185. En lecture « monotone », l'inclusion `eq:monoide` tient ; en lecture « monoïde », elle est fausse pour `n ≥ 2`.
- *(c) Défaut nouveau, absent de l'archive : la loi d'action échoue au cas ω.* Avec `ε^ω = ⋁_m ε^m` (`SixSchemasDeMetatheorie.lean`, l. 184 ; domaine `ℕ∞` décidé le 12 octobre 2026), `(ε^m)^ω = ⋁_j ε^{mj}`. Pour `ε = {a}`, `a ∉ ({a}²)^ω` alors que `a ∈ {a}^ω` : `φ_ω ∘ φ_m ≠ φ_{ωm} = φ_ω` pour `2 ≤ m < ω`, même dans la quantale commutative à une lettre. Seule l'inégalité `φ_ω ∘ φ_m ⊑ φ_ω` tient. L'égalité revient si `1 ⊑ ε` pour tout `ε`, hypothèse que le texte emploie implicitement (`SemantiqueOperationnelle.lean`, l. 176) mais ne pose pas. Conséquences : formes normales `(n,S)` et décidabilité de `ℳ` ; associativité de `req:schema_reinvocation_compatibility` au cas ω ; compatibilité de `λ` avec `δ_{r,s}`. L'audit [C-06](L1-C06-SUBSTITUTION-AUDIT-2026-10-11.md) (§ « Lois déjà dérivables ») présente la composition comme dérivable sans cette réserve.
- *(d) Loi distributive.* Sous (i) l'identification `Φ_dist(n,·) = φ_n`, (ii) un `Ψ_grade` qui ne modifie pas la multiplicité (non spécifié) et (iii) un axiome de compatibilité avec `μ` de forme stricte, le carré exige `(εδ)^n = ε^n δ^n`, faux dans le modèle libre. Le diagnostic « loi affaiblie » de l'archive est correct sous ces trois conditions. L'axiome exact de Gaboardi et al. (ICFP 2016, doi 10.1145/2951913.2951939) n'a pas pu être relu.
- *Dépendances.* Touchés : `eq:monoide`, C3 l. 642, formes normales, `thm:schema_reinvocation` (ω), `λ` de C1. Non touchés : `thm:commutation_monoide` (multiplicativité de `π_S` seulement), règle Sc (monotonie seulement), Inj, `thm:coherence_axiome`.

**Verdict.** Confirmé dans le modèle libre ; la fausseté de `eq:monoide` dépend du sens de `End_mon` ; défaut nouveau au cas ω, confirmé. Statut : esquisse papier, recalculée sur mots de longueur ≤ 12.

**Obligations.**
- **O-φ1.** Fixer le sens de `End_mon` dans `eq:monoide`.
- **O-φ2.** Prouver ou restreindre `φ_n ∘ φ_m = φ_{nm}` au cas ω, puis en tirer formes normales `(n,S)`, décidabilité de `ℳ` et compatibilité de `λ` avec `δ`.
- **O-φ3.** Établir le statut de `λ` vis-à-vis de `μ` (stricte, affaiblie, restreinte à une partie commutative) sous les axiomes exacts de la source citée, et recenser toute règle ou preuve qui l'emploie.
- **O-φ4.** Les preuves de cas (Sc, ré-invocation) n'emploient que la monotonie de `φ_n`, jamais sa multiplicativité.

**Décisions d'autrice.** D-φ1 (sens de `End_mon`), D-φ2 (statut de `λ`), D-φ3 (cas ω) : voir [`DECISIONS.md`](../tracking/DECISIONS.md).

## 2. Monotonie en `ℓ` de la relation logique

**Archive.** Séance 28 (`docs/journal/2026-10-06-pr-02-28-troncature-et-conformite.md`, l. 51-54) : une monotonie en `ℓ` serait fausse sur les types de fonction.

**`main`.** Les clauses de `ℛ_ℓ` sont identiques à celles de l'archive (`spec/Spec/C4/SemantiqueOperationnelle.lean`, l. 500-521). `main` n'énonce aucune monotonie en `ℓ` : `thm:non_interference`, `thm:lemme_fondamental`, `thm:divulgation_delimitee` et `thm:stratification_journal` sont posés niveau par niveau. `FACT-07` est ouverte (`docs/tracking/fiches-statuts.csv`, l. 95).

**Analyse.** Pour `L ⊏ H`, `b` à deux valeurs et `niv(r_H) = H` :
- sens `ℓ ⊑ ℓ′ ⇒ ℛ_ℓ ⊆ ℛ_ℓ′` : faux dès `!_{r_H} b` (relation totale en `L`, égalité en `H`) ;
- sens `ℓ ⊑ ℓ′ ⇒ ℛ_ℓ′ ⊆ ℛ_ℓ` : se démontre par induction aux types positifs (avec `π♭_ℓ = π♭_ℓ ∘ π♭_ℓ′`, plausible mais non énoncé), échoue au cas `⊸` par contravariance. Témoin : la fonction qui rend la valeur de base de son argument, au type `!_{r_H} b ⊸ F b`.
- Réserve : ce témoin déclassifie et n'est probablement pas bien typé ; l'univers de termes de `ℛ_ℓ` n'est pas fixé (`SemantiqueOperationnelle.lean`, l. 657-659). Sur les termes bien typés, la question reste ouverte aux types d'ordre supérieur.

**Verdict.** Confirmé sur l'univers non restreint ; indéterminé sur les termes bien typés ; aucun énoncé de `main` invalidé.

**Obligation.** **O-ℓ1.** Toute preuve qui transporte une relation entre niveaux (`FACT-07`, `thm:divulgation_delimitee`, extension concurrente) doit soit prouver l'inclusion sur l'univers des termes bien typés, à définir, soit adopter une clause de fonction quantifiant sur les niveaux inférieurs (variante de type Kripke, non sourcée ici, lemme fondamental à reprouver), soit s'en passer.

**Décision d'autrice.** D-ℓ (forme de l'indexation de `FACT-07`).

## 3. Formes temporelles et `thm:progres`

**Archive.** `docs/recherche/instruction-des-decisions.md`, § « Les six formes temporelles », et séance 29 : `at`, `wait`, `when` attendent des valeurs de types que nulle valeur n'habite, donc ne se réduisent jamais sur un terme clos.

**`main`.**
- Grammaire des termes (`spec/Spec/C3/GrammaireDesTermes.lean`, l. 27 et 33) : `delay c | always v | at v | now v | wait v | when x = v in c` sont des **calculs**.
- Grammaire des types (`GrammaireDesTypes.lean`, l. 42-44) : ni `□V`, ni `◇V`, ni `○V`, ni `○C`, ni `◇C` ; `○ □ ◇` n'existent que sur les sessions.
- Règles (`ReglesDeTypage.lean`) : `Del` (l. 231), `Alw` (l. 488), `Alw⁻` (l. 490), `Now` (l. 492), `Wait` (l. 498), `When` (l. 500). `Alw`, `Alw⁻`, `Now`, `Wait` concluent sans `| ε`, au format d'un jugement de valeur.
- Réductions (`SemantiqueOperationnelle.lean`, l. 50-61 et 88-95) : aucun schéma pour ces six formes ; contextes `E ::= [] | let x ← E in c | E v | scoped_f(v,E)` (l. 110) ; l. 39 annonce pourtant « exactement une [réduction] par règle d'élimination ».
- `thm:progres` (l. 201-214) : terminaux `return v`, `λx.c₀`, `⟨c_i⟩_{i∈I}`.

**Analyse** (hypothèse de contexte : `○∅ = □∅ = ∅`, non écrite).
- `delay` : `delay (return ())` se type par `One`, `Ret`, `Del`, n'est pas terminal, et aucun schéma ni contexte ne s'applique : **`thm:progres` est faux tel qu'énoncé sur ce terme.** Seule échappatoire, dire que `○(F₁1)` n'est pas un type, auquel cas `Del` conclut un non-type.
- `always`, `now` : en lecture « calcul », `always ()` et `now ()` sont bloqués ; en lecture « valeur », le lemme des formes canoniques devient faux (`at (always ())` est une valeur close de type `1` distincte de `()`).
- `at`, `wait` : aucun terme clos de ces formes n'est typable en lecture « calcul » ; le progrès vaut pour eux par vacuité. Le reste du constat de l'archive (aucune réduction sur terme clos) est exact.
- `when` : aucune dérivation close du corps de type `◇C` n'a été trouvée ; à confirmer par induction. P3-B rend l'attente voulue en intention, mais la configuration `⟨c ∣ μ ∣ τ⟩` n'a pas de composante d'environnement (l. 30-32) et l'énoncé n'a pas de forme « en attente ».

**Verdict.** Confirmé pour `delay` ; dépend d'un choix pour `always`/`now` ; infirmé pour `at`/`wait` comme cause ; indéterminé pour `when`.

**Obligations.**
- **T1.** Fixer la catégorie syntaxique et le format de jugement de chaque forme temporelle ; ajouter les types correspondants à la grammaire.
- **T2.** Pour chaque élimination, un schéma de réduction ou une exclusion explicite du domaine de `→`.
- **T3.** Étendre le lemme des formes canoniques aux types temporels retenus.
- **T4.** Dire si `delay c` est terminal.
- **T5.** Pour `when`, après P3-B, fixer la forme de l'attente environnementale dans la configuration ou dans l'énoncé du progrès, puis établir qu'un corps de type `◇C` est dérivable.

**Décisions d'autrice.** D-T1 (catégorie de `always`/`now`), D-T2 (représentation de l'attente de `When`).

## 4. Formes terminales de `thm:progres` et jonction de `Guard`

**Archive.** Séance 29 : la liste des formes terminales omet `Λα.c` et le copatron ; `Guard` a une branche par message.

**Analyse sur `main`.**
- `Λα.return ()` (`Ret` puis `Gen`, `ReglesDeTypage.lean`, l. 1080) est clos, typé, absent de la liste terminale et non réductible (seul `(Λα.c)[W]` est un rédex, `SemantiqueOperationnelle.lean`, l. 60) : **confirmé**.
- Copatron (`Cop`, l. 1129) : avec un indice vide, `⟨⟨⟩⟩` est typé et bloqué, comme `out ⟨⟨⟩⟩` ; avec `J = {1}`, le témoin dépend de l'affaiblissement. Défaut annexe : `x` y est liée à un type de calcul.
- Contextes d'évaluation : `E` n'a ni `E.i` ni `E[W]` ; `(let y ← return () in let () = y in Λα.return ())[W]` est bloqué.
- Autres calculs clos sans pas local : `return () ∥ return ()`, `try (return ()) catch (return ())`, `new_E`, `spawn (return ())`, `at_n (return ())`. L'énoncé local ne restreint pas son domaine.
- `Unfold` (l. 1074) type un calcul au format valeur, alors que `unfold (fold v) → v` produit une valeur.
- `Guard` (l. 1407) lie un seul message par branche ; l. 1431-1432 et l'esquisse de `thm:sync_motifs_jonction` (`EchelleDuSysteme.lean`, l. 500-503) revendiquent la consommation multi-places comme « opération native ». Deux gardes imbriquées consomment `x` même si `y` n'arrive jamais. Aucune règle de réduction n'est écrite pour `guard` ni pour les quatre autres règles globales (l. 1446).
- La demande de l'archive de « rétrograder le sceau » est sans objet sous la taxonomie C8 (`under-review`, `proofsketch`), mais l'énoncé tel qu'écrit est réfuté par ces témoins.

**Verdict.** Confirmé (le copatron sous condition d'indice vide ou d'affaiblissement).

**Obligations C-07.P.**
- **P1.** Aligner la liste terminale sur les règles d'introduction de calcul retenues (`Ret`, `Lam`, `With`, `Gen`, `Cop`, et `Del`/`Alw`/`Now` selon D-T1).
- **P2.** Compléter `E` ou justifier l'absence de `E.i` et `E[W]`.
- **P3.** Pour chaque règle d'élimination (`Out`, `Fix`, `Declassify`, `Alw⁻`, `Wait`, `When`…), un schéma ou une exclusion de domaine.
- **P4.** Délimiter le domaine de l'énoncé local (fragment séquentiel, ou constructeurs globaux traités comme rédex de pool).
- **P5.** Écrire les règles globales `Spawn`, `New`, `Send`, `Guard`, `Free`, ou les exclure explicitement.
- **P6.** Rendre l'esquisse de `thm:sync_motifs_jonction` conforme à la forme réelle de `Guard`.

**Décisions d'autrice.** D-P1 (énoncé de `thm:progres`), D-P2 (jonction).

## 5. `spawn`, `send`, `guard`

**Archive.** `docs/recherche/analyses-decisions/02-spawn-et-fil-de-temps.md` (§ 2.2) et `03-anom-18-facteur-temporel.md` (§ 2).

**Analyse sur `main`.**
- *Traduction.* `thm:confinement_sortes` (`spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean`, l. 220-255) revendique « Couche 2 — tous les cas », alors qu'aucune clause `⟦·⟧` n'existe pour `spawn`, `send`, `guard`, `new`, `free` : **confirmé**. Constat nouveau : `Spawn` (`ReglesDeTypage.lean`, l. 1393) remplace la composante `φ` de la fille par `spawn` ; sous une traduction compositionnelle, `⟦spawn (operation_{⟨a,0⟩}(v))⟧` contient un nom libre `operation_a` que `ε_spawn` ne mentionne pas, ce qui contredit la seconde clause de l'énoncé si « mentionne » désigne le support de `φ` : **dépend d'un choix**.
- *Couplage.* Les clauses `niv(Δ) ⊑ ℓ̂(ε)` ne figurent que dans `Case` (l. 221) et `Op` (l. 227) ; `Spawn`, `Send` (l. 1401) et `Move` (l. 1496) n'en ont pas, alors que l. 258-262 dit le canal temporel « fermé par règle ». `ℓ̂` n'est pas défini pour `⟨1,1⟩`, `⟨c,c⟩`, `⟨w(ε),0⟩`. `Send` ne relie pas le niveau de la charge à celui de la boîte : **confirmé textuellement**, conséquences dépendant de la lecture de ces couples.
- *`w`, `s`.* Employés dans `Vmap` (l. 1289) et `Spawn` sans définition : **confirmé**. Deux lectures : projections `ℰ → ℕ∞^ℒ` (le niveau est conservé) ou agrégats scalaires de type `W` (le niveau est perdu). Collision de noms avec l'agrégateur `W` (C-05) et la counité `w_A`.
- *`Tick`.* `⟨1, δ_ℓ̂⟩` (l. 229), `δ` non défini ; cohérent seulement si `δ_ℓ` est à valeurs dans `ℕ∞ × ℕ∞`. Résidu contradictoire : `LeSystemeDeSortesDuMetalangage.lean`, l. 103-104, écrit encore `κ ∈ ℕ∞^ℒ`, contre `(ℕ∞ × ℕ∞)^ℒ` (`GrammaireDesTypes.lean`, l. 46 et 109-117).

**Partage C / F / E.** Relèvent de C : définitions de `w`, `s`, `δ`, `ℓ̂` ; résidu `ℕ∞^ℒ` ; délimitation du domaine de `thm:confinement_sortes`, de `Sim` et de `thm:progres` ; sur-revendication de `thm:sync_motifs_jonction` ; formes temporelles ; `at_n`, `move`, `try` (couche 1). Relèvent de F : traduction de `spawn`, règles globales et configuration de pool, clauses de couplage comme conditions de typage, jonction de `Guard`, progrès global. Relèvent de E : réductions et profondeur de `∥` et `vmap`.

**Obligations.**
- **S1.** Restreindre explicitement le domaine de `thm:confinement_sortes` et de `Sim` aux règles dont la traduction est écrite ; définir « opérations que `ε` mentionne » ; décider si la traduction de `spawn` contient celle de la fille.
- **S2.** Définir `w`, `s`, le codomaine de `δ_ℓ` et `ℓ̂` pour les effets à couple sans niveau ; supprimer ou justifier le résidu `κ ∈ ℕ∞^ℒ` ; vérifier si « fermé par règle » tient sans clause de couplage.

**Décisions d'autrice.** D-S1 (`w`, `s`), D-S2 (couplage ou réduction de la revendication), D-S3 (délimiter maintenant en C ou attendre F).

## 6. Singularités des roues (D, BLOQ-12)

Le chantier D reste bloqué par la porte C ; cette section ne choisit aucune des alternatives (i) à (iv) de [`sources-singularites.md`](../research/sources-singularites.md).

**`1/0` dans une roue.** `spec/Spec/C3/LesContraintesDeValeur.lean`, l. 402-404, écrit « En roues `x/0 = ⊥`, donc `1/0 = ⊥` ». Dans la roue des fractions d'un corps, `1/0 = [1,0] = ∞`, `0/0 = [0,0] = ⊥`, et `x/0 = ∞` pour `x` fini non nul ; plus généralement, si `1/0 = 0/0` dans une roue, alors `0 = /⊥ = ⊥` et la roue est triviale. La loi « `x/0 = ⊥` pour tout `x` » est celle des *common meadows*. La phrase provient de la revue externe `docs/peer-review/pr-02/qwen.md`, l. 498, reprise sans vérification. La conclusion de la note (l'encodage n'est pas un homomorphisme vers IEEE 754) reste vraie avec un contre-exemple correct : `∞ + ∞ = ⊥` dans la roue contre `+∞` en IEEE 754, ou `1/0 ↦ +∞`, qui n'est pas un NaN alors que l'encodage met `∞` dans une charge utile de NaN. Statut : calculé sur la construction rappelée (corps finis, `ℤ/4`, `ℤ/6`, `ℚ`) et dérivé sur papier ; résumés concordants de Bergstra et Tucker (WADT 2020, LNCS 12669, doi 10.1007/978-3-030-73785-6_2 : « 1/0 = ∞ ») ; **le corps de l'article de Carlström (MSCS 14(1), 2004, doi 10.1017/S0960129503004110) n'a pas pu être lu** (accès réseau refusé). Renvois pendants dans le même requirement : « (iii) » (l. 397 et 407) alors que la proposition n'a plus que (i) et (ii), et « la table de propagation des singularités », absente de `main` (IMPL-07 ouverte). Correction du manuscrit soumise à l'autrice dans [`DECISIONS.md`](../tracking/DECISIONS.md).

**Règle de réunion d'étiquettes.** `spec/` ne contient aucune définition de `∘` ni de `δ` comme singularités, aucune règle de combinaison, ni table de propagation : seuls `LesContraintesDeValeur.lean`, l. 352 et 366-368, nomment les quatre singularités. La règle de réunion n'a été écrite que par `927a6fd` (branches `split/pr10-3-singularites` et `split/pr10-4-manuscrit-semantique`, non fusionnées). Les affirmations contraires de la note de recherche et de l'en-tête de `scripts/verif_singularites.py` sont corrigées dans la même PR que ce dossier ; le script ne lit aucun fichier de `spec/`, ses calculs ne dépendent pas de cette affirmation.

**Compléments de calcul reproduits** (modèle fini, axiomes rappelés) : sous la règle de la borne supérieure, le produit n'est pas associatif non plus (`(0·∞)·∘ = ⊥`, `0·(∞·∘) = ∘`), et trois autres axiomes échouent ; avec la priorité fixe (iii), seul `0/0 + x = 0/0` échoue (GF(2), GF(3), GF(5)) ; avec l'option (iv), échouent `/(xy) = /x /y` et `/(x + 0y) = /x + 0y`. Aucune règle essayée ne garde tous les axiomes avec une classe d'erreur supplémentaire ; ce n'est pas démontré pour toute extension.

**Obligations D / IMPL-07.**
- **W1.** Le test différentiel exclut ou traite explicitement les cas où la roue et IEEE 754 divergent (`∞ + ∞`, encodage de `∞` en NaN, charge utile des NaN).
- **W2.** L'arithmétique matérielle ne fixe pas la charge utile du résultat de deux NaN (recommandation, non exigence d'IEEE 754) : `+` sur les valeurs encodées exige une correction logicielle, quelle que soit l'option.
- **W3.** Les symboles `∘` et `δ` des singularités entrent en collision avec la composition, `δ_ℓ` et `δ_{r,s}` ; à traiter avec T-68 si les classes sont gardées.
- **W4.** Lire Carlström 2004 dès que l'accès le permet : toutes les valeurs dites « calculées » dépendent du rappel des axiomes.

## 7. Constats connexes, absents de l'archive

1. **Règle `When` modifiée sans trace.** Le commit `6371e19` (12 octobre 2026) a changé la conclusion de `When` de `ε[ω/k]` en `ε` (`ReglesDeTypage.lean`, l. 500). [`L1-THEORY-OBJECTS.md`](L1-THEORY-OBJECTS.md), § 4, et l'audit [C-04](L1-C04-WHEN-RESOURCE-CONTRACT-2026-10-11.md), § 1.1, décrivent encore l'ancienne règle. Changement normatif à tracer.
2. **`thm:action_parallele` sur `ℰ₀`.** L'esquisse (`ComonadeExponentielleEtFragments.lean`, l. 326-330) ne traite que le facteur temporel ; sur `ℰ₀`, la loi d'échange (`ReglesDeTypage.lean`, l. 1275) ne donne que `φ_n(ε₁) ∥ φ_n(ε₂) ⊑ φ_n(ε₁ ∥ ε₂)`.
3. **Congruence de `scoped` dans `thm:preservation`.** Le pas interne (`SemantiqueOperationnelle.lean`, l. 92-93) émet l'effet du sous-calcul sans le transformer : la préservation exige `δ · f(ε′) ⊑ f(δ · ε′)`, pas seulement la monotonie de `f` (l. 184-186). L'inégalité échoue pour `π_{a}` et `φ_0` dès qu'une opération interceptée vérifie `a ⋢ 1`, et pour `φ_2` dans le modèle libre ; conditionné à l'ordre des traces, non défini (l. 189-196).
4. **Contrôle mécanique aveugle.** `scripts/controles/croise.py`, l. 47-52, classe `Alw`, `Alw⁻`, `Now`, `Wait` en « calcul » sans vérifier le format de la conclusion. Contrôles discriminants proposés, non implémentés : (a) toute règle dont le constructeur est classé « calcul » conclut par `| ε` (aurait échoué sur `Alw`, `Alw⁻`, `Now`, `Wait`, `Unfold`) ; (b) tout constructeur introduit par une règle d'introduction de calcul figure dans la liste terminale de `thm:progres`, ou en est explicitement exclu.

## 8. Actions restantes

- **HUMAN ACTION REQUIRED :** décisions D-φ1 à D-φ3, D-ℓ, D-T1, D-T2, D-P1, D-P2, D-S1 à D-S3 et correction `1/0`, consignées dans [`DECISIONS.md`](../tracking/DECISIONS.md).
- **BLOCKED :** lecture de Carlström 2004 et de Gaboardi et al. 2016 (accès réseau refusé depuis l'environnement de revue).
- **FUTURE :** mécanisation Lean des contre-exemples (`delay (return ())`, `Λα.return ()`, `φ₂(ab)`), une fois la syntaxe et le typage C3 formalisés ; contrôles (a) et (b) du § 7.
