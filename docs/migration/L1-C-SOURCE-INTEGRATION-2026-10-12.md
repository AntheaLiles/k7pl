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
- `src/K7pl/GradeBudget.lean`, importé par `src/K7pl.lean`, est la seule brique de preuve Lean directe de cette tranche. Les fichiers `spec/Spec/*.lean` sont des sources documentaires Verso ; ils ne sont pas des définitions formelles Lean du système K7PL.

## 3. Portée exacte de la preuve Lean

`K7pl.GradeBudget` formalise la soustraction tronquée prolongée sur `ℕ∞`, l'identité pour multiplicité naturelle finie, le contre-exemple pour multiplicité infinie, le cas coût nul et `top_disjunct_iff_le` (équivalence d'ordre requise pour normaliser D5). `truncated_sub_mul_compatibility` correspond au domaine exact du lemme arithmétique C2 : multiplicité finie ou coût nul.

Le module définit aussi un profil générique `TemporalProfile L = L → ℕ∞ × ℕ∞`, puis `workAggregate` (supremum des sommes sur sous-ensembles finis), `depthAggregate` (supremum des profondeurs) et `costBudget = max(workAggregate, depthAggregate)`. Les monotonies et le cas d'un ensemble de niveaux vide sont formalisés. Ces fonctions ne sont **pas encore reliées au domaine canonique K** ni aux jugements K7PL : elles matérialisent le contrat mathématique sur un type de profils, sans prouver la conformité de l'instance normative. La compilation de toutes les nouvelles déclarations doit être confirmée sur le SHA exact de la CI.

Le module contient désormais `truncated_sub_mul_compatibility`, dont les hypothèses correspondent au domaine arithmétique de `thm:distributivite_tronquee` : la multiplicité est finie ou le coût soustrait est nul. La compilation de cette déclaration doit être confirmée par la CI de la tête exacte. Le module ne formalise toujours pas le jugement K7PL, `Adm`, le domaine partiel de `Consume`, `ψ`, `When`, `Scale_Usage`, `W`, `D`, `Cost_Budget`, la substitution, la correction de ressource ou la simulation. Le théorème arithmétique ne peut servir de prémisse à une règle que si la dépendance réelle de cette règle et toutes les hypothèses du lemme sont établies.

## 4. Matrice adversariale C-01 à C-09

| Lot | Ce qui est établi ou mieux délimité | Preuve ou décision qui manque |
|---|---|---|
| **C-01 — interfaces** | Les signatures de référence et la distinction entre interfaces de grade et opération de contexte sont écrites explicitement dans les sources. | Formalisation Lean des interfaces et preuves des lois de `Scale_Usage`; identité, composition, naturalité et compatibilité de `coerce`, `w` et `c` sur des domaines canoniques. |
| **C-02 — modes** | Le périmètre de référence retient Lin/Aff/Unr et laisse Rel hors des règles actuelles. | Définir les algèbres, idéaux, permissions et contrat des morphismes ; prouver leur correspondance aux règles. Les inclusions d'intervalles ne suffisent pas. |
| **C-03 — conversions** | Les contrats textuels des transports de contexte et de l'exponentielle factorisée sont distingués. | Prouver les lois de `ConvCtx`, `Conv!`, `coerce`, `Sub` et `SubBox`, la naturalité et la compatibilité avec `w/c`; rattacher toute hypothèse externe à une instance K7PL vérifiée. |
| **C-04 — When et budget** | D3–D8 et P3-B sont reflétés dans les sources : coût total sous contrat, supremum vide nul, couverture, consommation partielle, domaine indépendant de `ψ`, soustraction globale et latence séparée du coût d'exécution. `top_disjunct_iff_le` formalise seulement la normalisation d'ordre sous `ℕ∞`. | Définir formellement `Adm` et `Cost_Budget`, relier leur typage aux règles, définir l'observation de latence et prouver règle par règle l'admissibilité des traversées et l'absence de coût d'exécution masqué. P3-B ne prouve ni déclenchement ni vivacité environnementale. |
| **C-05 — agrégateurs** | Les définitions génériques `TemporalProfile`, `workAggregate`, `depthAggregate` et `costBudget` correspondent aux formules de C2 ; monotonie de W/D/max et cas vide sont maintenant déclarés dans Lean. | Rattacher ce type au domaine canonique `K`, vérifier l'équivalence des opérations avec les définitions normatives et prouver les lois de composition/bornes effectivement requises. Une définition générique et sa compilation ne prouvent pas la correction des traversées K7PL. |
| **C-06 — substitution** | L'esquisse différencie `Pair` et `Inj`, signale les obligations de fraîcheur et l'inventaire de 49 occurrences. | Induction formelle par constructeur et conversion ; preuves pour les contextes partagés, effets, `ψ`, `When` et préconditions. Le contrôle de matrice n'est pas la preuve du théorème. |
| **C-07 — simulation** | `Sim` est décrit comme objectif de simulation avant sur configurations complètes, sans revendication de bisimulation ou de pleine abstraction. | Définir configurations source/cible, relation, traces, observables, canaux et clauses de traduction ; prouver la simulation pour chaque règle et pas de réduction visé. |
| **C-08 — mémoire** | H1 reste `under-review/proofsketch` et la lacune d'élimination de l'arène est visible ; H2 et H3 sont séparées. | Prouver H1 ou l'assumer explicitement avec portée réduite ; prouver H2/H3 séparément et relier la représentation à un profil `Π` versionné. |
| **C-09 — dépendances** | Le cadre abstrait P1a est séparé de l'interprétation et de la correction de l'instance K7PL P1b. | Pour chaque import : hypothèses, version, fragment, mapping et obligation ; une citation ne transfère pas sa preuve automatiquement à K7PL. |

## 5. CI et règle d'interprétation

Sur l'ancienne tête `0d575f75d08f9826ff64c9fbe3f0045ccfb355f9`, le run [#38179081311](https://github.com/AntheaLiles/k7pl/actions/runs/38179081311) était vert au niveau agrégé, mais les jobs d'implémentation Lean, de build Verso, de PDF, d'assets TikZ et de tests Python étaient ignorés par la classification d'impact. Ce run ne valide donc pas les sources intégrées ici.

Après chaque modification de la branche, vérifier sur le SHA exact les jobs `Implémentation Lean`, `Spécification Verso`, `PDF de la spécification`, `TikZ figure assets` et `Tests de l’outillage Python`. Le succès de la CI précédente ne se transfère pas à un nouveau SHA. Même une CI entièrement verte établirait seulement que les contrôles exécutés passent ; elle ne fermerait pas C-01 à C-09.

## 6. Verdict

**La porte scientifique C reste NON SATISFAITE.** Cette tranche matérialise les décisions, délimite les affirmations et ajoute une preuve arithmétique ciblée ; elle ne donne pas de preuve formelle des interfaces K7PL, de la correction de ressource, de la substitution, de la simulation ou du modèle mémoire. La source de la liste D11 est retrouvée dans [la revue indépendante Qwen, R-02](../peer-review/pr-02/qwen.md), qui nomme six cibles de haut niveau ; Th. 47 y contient deux cas (LET/APP) et `48/27` reste une référence double. L’audit D11 demeure partiel jusqu’à ce que chaque dérivation soit reliée à sa cible Verso courante et sa dépendance réelle soit vérifiée.