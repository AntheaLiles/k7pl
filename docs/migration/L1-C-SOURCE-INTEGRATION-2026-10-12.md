<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Intégration des sources C-01–C-09 et dossier des preuves restantes

Date : 12 octobre 2026.

**Statut :** intégration proposée dans la PR #170 ; porte scientifique C **NON SATISFAITE**. Ce document trace les changements et les obligations ouvertes ; il ne constitue pas une preuve de correction.

## 1. Révisions et méthode de fusion

L'intégration part de `main` au commit `8258e0d50ea8e981b742fe7a123311063b27ed3d` et de la tête précédente de PR #170 `0d575f75d08f9826ff64c9fbe3f0045ccfb355f9`. La branche d'audit D3–D11 `research/d11-audit-multiplicity-sites-2026-10-11` était 51 commits en avance et 16 en retard sur `main`. Elle n'est donc pas fusionnée en bloc : les notes D3–D11, les documents d'audit et la brique arithmétique sont portés de façon sélective sur l'arbre de la PR, pour ne pas réintroduire des versions plus anciennes des fichiers divergents.

La PR reste ouverte ; aucune fusion vers `main` n'est opérée. `docs/STATUS.md` est généré et n'est pas modifié à la main.

## 2. Changements de source et périmètre

- `spec/Spec/C1/AxiomatiqueGerminale.lean` distingue les interfaces de la loi distributive au niveau grade (`Φ_dist`, `Ψ_grade`) de l'opération de contexte `ψ`. La loi de cohérence demeure une obligation, pas un théorème acquis.
- `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` reflète les signatures de référence de `π_U`, `Bang_𝒢` et `Scale_Usage`, `Cost_Budget` total sous contrat, `sup ∅=0`, `Adm` normalisée en comparaison de couverture, `Consume` partielle, le domaine de `ψ` conceptuellement indépendant et la convention globale D8.
- `spec/Spec/C2/CategorieAmbiante.lean` sépare le cadre catégorique abstrait P1a de l'interprétation et de la correction de l'instance K7PL P1b.
- `spec/Spec/C3/LeSystemeGradue.lean` consigne les modes de référence `M_Lin`, `M_Aff`, `M_Unr`. `M_Rel` reste une piste et ne devient pas une permission des règles actuelles.
- `spec/Spec/C3/ReglesDeTypage.lean` présente `Scale_Usage` comme interface de référence, conserve la séparation de `ψ` et de la transformation d'effet, et garde le théorème de substitution `under-review/proofsketch`. L'inventaire des 49 occurrences de règles et sa matrice ne sont pas une preuve d'induction.
- `spec/Spec/C4/SemantiqueOperationnelle.lean` sépare la latence environnementale P3-B du coût d'exécution de l'automate déclenché sans inventer de type d'observation non ratifié.
- `spec/Spec/C4/CalculDeProcessusSousJacent.lean` borne `Sim` comme objectif de simulation avant sur configurations complètes ; le contrat de relation et la preuve règle par règle restent à fournir.
- `spec/Spec/C4/ModelesDeMemoire.lean` conserve H1 sous revue et la lacune d'élimination de l'arène ; H2 et H3 restent des obligations distinctes.
- `spec/Spec/C5/SExpressionsUniverselles.lean` explicite que le test de délimitation ERR-TOP ne prouve pas l'énoncé sémantique H3.
- `src/K7pl/GradeBudget.lean`, `src/K7pl/UsageScale.lean`, `src/K7pl/StructuralModes.lean`, `src/K7pl/MemoryRange.lean`, `src/K7pl/MemoryCapability.lean` et `src/K7pl/WhenBoundary.lean`, importés par `src/K7pl.lean`, formalisent le modèle de budget, l’action d’usage, les permissions de mode, l’arithmétique d’intervalles, l’invariant abstrait de capacité et l’interface paramétrique `When`. Les fichiers `spec/Spec/*.lean` restent des sources documentaires Verso ; ils ne sont pas des définitions formelles Lean du système K7PL.

## 3. Portée exacte de la preuve Lean

`K7pl.GradeBudget` formalise la soustraction tronquée prolongée sur `ℕ∞`, l'identité pour multiplicité naturelle finie, le contre-exemple pour multiplicité infinie, le cas coût nul et `top_disjunct_iff_le` (équivalence d'ordre requise pour normaliser D5). `truncated_sub_mul_compatibility` correspond au domaine exact du lemme arithmétique C2 : multiplicité finie ou coût nul.

Le module définit aussi un profil générique `TemporalProfile L = L → ℕ∞ × ℕ∞`, puis `workAggregate` (supremum des sommes sur sous-ensembles finis), `depthAggregate` (supremum des profondeurs) et `costBudget = max(workAggregate, depthAggregate)`. Sont aussi formalisés la monotonie de W/D/max, les bornes par les supremums, la nullité de W/D/Cost_Budget pour le profil nul, le cas des niveaux vides et la minimalité de `max(W,D)` parmi les bornes scalaires communes. Le lemme `truncatedSub_add_of_le` établit que la consommation résiduelle plus le coût recouvre le budget lorsqu’il est admissible. `profileAdmissible` et `profileConsume` encodent le principe de couverture et la partialité de D5–D6 avec un témoin de précondition, puis `profileConsume_conservation` prouve l’identité de conservation sur ce domaine.

Le porteur `K = (ℕ∞ × ℕ∞)^ℒ` est désormais nommé explicitement par l’alias Lean `K L`, et les wrappers `costBudgetK`, `admK`, `consumeK` exposent le raccord de type et d’interface avec C2. Les égalités définitoires et la conservation sur le domaine admis sont prouvées pour ce porteur. Ce raccord reste toutefois **un modèle de référence**, pas une formalisation du jugement de typage ni des transitions opérationnelles : il reste à prouver que les règles concrètes préservent `Adm`, invoquent `Consume` uniquement sur son domaine, et que les agrégateurs correspondent aux mesures effectivement observées.

Le fichier `src/K7pl/GradeBudget.lean` formalise `K`, `Cost_Budget`, `Adm` et `Consume`, ainsi que l’identité de conservation sur son domaine admis. Il ajoute désormais `BudgetBoundaryCertificate`, un contrat qu’une règle concrète doit instancier pour prouver l’admissibilité et le résidu exact ; la présence de ce contrat ne prouve pas encore qu’une règle `When` ou une autre règle l’instancie.

Sous le contrat `[Monoid U]`, Lean vérifie identité, composition, conservation de la monotonie/niveau/budget et préservation du support. `Usage := WithTop ℚ≥0` est instancié avec `piU`, `bangGrade` (factorisation de l’indice exponentiel par `π_U`), l’action spécialisée et les conventions de produits avec `⊤` de C2. `usage_mul_add`, `usage_mul_mono_left`, `projectUsageContext_scale` et `scaleUsageVector_add` prouvent l’additivité et la monotonie au niveau du porteur et de son contexte d’usages projeté. `scaleUsageContext_transportBudget_commute` prouve que l’action d’usage commute avec tout transport de contexte qui modifie exclusivement les budgets ; le raccord à la fonction normative `ψ` exige encore de prouver que son instance respecte ce contrat. `bangGrade` reste une famille fournie en paramètre ; aucun axiome de comonade ni morphisme `coerce/w/c` n’est encore prouvé, et le sous-typage du grade complet ainsi que le raccord aux règles restent ouverts.

Le module `K7pl.StructuralModes` formalise une structure abstraite `Mode R := (Ideal R, R → Prop)` et la condition d’un morphisme préservant les permissions, puis prouve les morphismes `Lin → Aff`, `Aff → Unr` et `Lin → Unr`. Le candidat `Rel = (⊤, false)` est séparé des modes de référence ; le module prouve que `Aff → Rel` n’est pas un morphisme selon ce contrat. Ces résultats sont paramétriques dans un semi-anneau `R` : ils ne prouvent pas encore l’instance normative K7PL ni que les règles de typage réalisent les permissions déclarées. La compilation de toutes les nouvelles déclarations doit être confirmée sur le SHA exact de la CI.

Le module contient désormais `truncated_sub_mul_compatibility`, dont les hypothèses correspondent au domaine arithmétique de `thm:distributivite_tronquee` : la multiplicité est finie ou le coût soustrait est nul. Cette identité arithmétique n’est pas une prémisse K7PL tant que la dépendance réelle d’une dérivation n’a pas été établie.

## 4. Matrice adversariale C-01 à C-09

| Lot | Ce qui est établi ou mieux délimité | Preuve ou décision qui manque |
|---|---|---|
| **C-01 — interfaces** | `Usage := WithTop ℚ≥0`, `π_U`, `bangGrade` et `Scale_Usage` sont formalisés comme interface paramétrique ; identite, composition, préservation des autres coordonnées, additivité/monotonie et commutation avec un transport de budget uniquement sont prouvées dans ce modèle. | Définir l’ordre complet du grade et les domaines canoniques ; prouver naturalité et compatibilité de `coerce`, `w`, `c`, les lois comonadiques et relier ces interfaces aux règles réelles. |
| **C-02 — modes** | `K7pl.StructuralModes` encode un mode comme idéal de contraction plus prédicat d’affaiblissement, et prouve Lin→Aff→Unr ainsi que Lin→Unr. Rel reste explicitement un candidat hors périmètre normatif ; Aff→Rel est impossible sous le contrat donné. | Instancier `R` par le support normatif, vérifier l’ordre des permissions contre les règles et prouver que les jugements/règles imposent effectivement ces modes. L’inclusion des intervalles d’usage ne suffit pas. |
| **C-03 — conversions** | Les contrats textuels des transports de contexte et de l'exponentielle factorisée sont distingués. | Prouver les lois de `ConvCtx`, `Conv!`, `coerce`, `Sub` et `SubBox`, la naturalité et la compatibilité avec `w/c`; rattacher toute hypothèse externe à une instance K7PL vérifiée. |
| **C-04 — When et correction de ressource** | `K7pl.WhenBoundary.TriggeredRun` sépare le type abstrait d’observation de latence du profil d’exécution ; sa conservation dépend d’un `BudgetBoundaryCertificate` sur le profil du corps. Le coût chargé est invariant sous changement d’observation lorsque le profil du corps est égal. | La règle opérationnelle `When`, l’orchestrateur, l’observation de trace et la relation avec `ψ` ne sont pas encore liés à ce contrat ; la précondition `Adm` doit rester prouvée par le site d’appel. |
| **C-05 — agrégateurs** | Les définitions génériques `TemporalProfile`, `workAggregate`, `depthAggregate` et `costBudget` correspondent aux formules de C2 ; monotonie de W/D/max, borne de chaque composante par son supremum, coût du profil nul et propriété de borne scalaire minimale de `max(W,D)` sont maintenant déclarés dans Lean. | Rattacher ce type au domaine canonique `K`, vérifier l'équivalence des opérations avec les définitions normatives et prouver les lois de composition séquentielle/parallèle effectivement requises. Une définition générique et sa compilation ne prouvent pas la correction des traversées K7PL. |
| **C-06 — substitution** | L'esquisse différencie `Pair` et `Inj`, signale les obligations de fraîcheur et l'inventaire de 49 occurrences. | Induction formelle par constructeur et conversion ; preuves pour les contextes partagés, effets, `ψ`, `When` et préconditions. Le contrôle de matrice n'est pas la preuve du théorème. |
| **C-07 — simulation** | `Sim` est décrit comme objectif de simulation avant sur configurations complètes, sans revendication de bisimulation ou de pleine abstraction. | Définir configurations source/cible, relation, traces, observables, canaux et clauses de traduction ; prouver la simulation pour chaque règle et pas de réduction visé. |
| **C-08 — mémoire** | `K7pl.MemoryCapability.allocate_preserves_unique` montre que l’allocation conserve l’invariant par région « arène + capacités d’écriture ≤ 1 » ; `no_double_writer` en dérive l’exclusivité sous addition des contextes. `K7pl.MemoryRange.disjoint_ne` traite séparément le sous-lemme d’identité d’intervalles. | Ces preuves portent sur un modèle abstrait de comptes, pas sur les règles K7PL `Arena`/`WriteCap`/`alloc_range`/`Par`. Le lien de H1 à l’introduction effective, H2 à la sémantique des régions et H3 à l’interdiction de capture restent ouverts. |
| **C-09 — dépendances** | Le cadre abstrait P1a est séparé de l'interprétation et de la correction de l'instance K7PL P1b. | Pour chaque import : hypothèses, version, fragment, mapping et obligation ; une citation ne transfère pas sa preuve automatiquement à K7PL. |

## 5. CI et règle d'interprétation

Sur l'ancienne tête `0d575f75d08f9826ff64c9fbe3f0045ccfb355f9`, le run [#38179081311](https://github.com/AntheaLiles/k7pl/actions/runs/38179081311) était vert au niveau agrégé, mais les jobs d'implémentation Lean, de build Verso, de PDF, d'assets TikZ et de tests Python étaient ignorés par la classification d'impact. Ce run ne valide donc pas les sources intégrées ici.

Après chaque modification de la branche, vérifier sur le SHA exact les jobs `Implémentation Lean`, `Spécification Verso`, `PDF de la spécification`, `TikZ figure assets` et `Tests de l’outillage Python`. Le succès de la CI précédente ne se transfère pas à un nouveau SHA. Même une CI entièrement verte établirait seulement que les contrôles exécutés passent ; elle ne fermerait pas C-01 à C-09.

## 6. Verdict

**La porte scientifique C reste NON SATISFAITE.** Cette tranche matérialise les décisions, délimite les affirmations et ajoute une preuve arithmétique ciblée ; elle ne donne pas de preuve formelle des interfaces K7PL, de la correction de ressource, de la substitution, de la simulation ou du modèle mémoire. La liste R-02 est sourcée dans [la revue indépendante Qwen, R-02](../peer-review/pr-02/qwen.md), mais la comparaison des proofsketches courants donne un résultat adverse plus précis : aucun usage direct de la loi de multiplicité n’est visible dans `boxtimes_addition` (cas d’effet nul), `substitution` (action `Scale_Usage` factorisée), `commutation_traduction` ou `expansion_macro` (effets composés dans l’ordre des occurrences). `correction_ressource` reste indéterminée faute de transitions instrumentées détaillées ; le cas APP du lemme fondamental reste conditionnel à une ré-invocation réelle d’effet par `φ_n`. Ce constat ne réfute pas une dépendance d’une version historique non retrouvée. Th. 47 est séparé en cas LET/APP et `48/27` reste une référence double non expliquée. L’audit D11 demeure partiel jusqu’à l’alignement des dérivations historiques sur les sources précises.


## 7. C-01 — pont formel explicite pour ψ et Scale_Usage (12 octobre 2026)

Le nouveau module `src/K7pl/BudgetTransport.lean` donne une instance explicite,
au niveau des interfaces, de la cohérence C2 entre `Scale_Usage` et `ψ`.
Le prédicat `psiAdmissible` exige que chaque liaison présente ait un budget
couvrant le coût scalaire du profil traversé. `psiContext` requiert cette preuve
en argument et soustrait le coût uniquement à la composante budgétaire.

Les obligations formelles ajoutées sont :

- `psiAdmissible_scale` : une mise à l'échelle d'usage préserve le domaine admissible de `ψ` ;
- `psiContext_scale_commute` : l'action `Scale_Usage` commute avec cette instance de `ψ`, sous certificat d'admissibilité ;
- `psiContext_binding_conserves_budget` : pour chaque liaison présente, le budget résiduel plus le coût facturé égale le budget initial.

Le module est importé par le point d'entrée `src/K7pl.lean`, pour que la construction
soit soumise à la compilation d'implémentation Lean. Ce résultat comble un écart entre
le transport générique de budget et la loi d'interface C2 ; il ne ferme pas la preuve
opérationnelle. La fonction `ψ` normative doit encore être identifiée à cette instance,
les conditions structurelles de son domaine doivent être intégrées, et les règles
effectives `Box`, `App`, `Let`, `When` et la substitution doivent établir leurs
certificats au site d'appel. Le profil temporel facturé n'est toujours pas relié à
la trace d'exécution instrumentée.

**État à la création de cet addendum :** compilation et CI sur la nouvelle tête en attente.
La porte C reste NON SATISFAITE ; aucun GO D–J n'est déduit de ces résultats d'interface.
