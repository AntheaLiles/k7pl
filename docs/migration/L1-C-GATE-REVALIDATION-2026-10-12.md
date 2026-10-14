<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Réévaluation indépendante de sortie — porte scientifique C (12 octobre 2026)

**Verdict : PORTE C NON SATISFAITE. Aucun GO D–J.**

Ce constat porte sur les objets, règles, décisions et preuves de la branche candidate, et non sur son seul état GitHub. Il ne transforme pas une difficulté technique ou une lacune de mécanisation en décision d'autrice. Il enregistre ce qui peut être justifié à partir de l'état inspecté et isole les dépendances qui empêchent le passage de modèles abstraits à des règles effectives.

## 1. Révisions et état GitHub vérifiés

- `main` : `200b6935f5622e93d9add104e1f0e46dae6f6e6b`.
- Branche candidate de la PR #170 : `research/c01-interface-ratification-2026-10-11`. La révision du code source revalidée après correction du lemme Lean est `7f2e535c8f36fa87652d64623e1a168e477e3d13` ; la présente mise à jour ne change que ce dossier d'audit et le registre de la PR.
- PR [#170](https://github.com/AntheaLiles/k7pl/pull/170) : ouverte, non draft, base `main`, `mergeable=true`, `mergeable_state=clean`, 112 commits d'avance et 0 de retard sur `main` à la tête de code validée. Ces faits Git ne concluent rien sur la porte scientifique.
- Les PR #171–#180 sont fusionnées **dans les branches parentes de la chaîne de recherche** ; #181 est fusionnée dans sa branche parente D11. Elles ne sont pas intégrées à `main` parce que la PR #170 demeure ouverte et non fusionnée.
- Le run CI complet sur la révision de code `7f2e535c8f36fa87652d64623e1a168e477e3d13` est [#38283308785](https://github.com/AntheaLiles/k7pl/actions/runs/38283308785), conclu `success` le 12 octobre 2026. Les jobs Build/tests Lean, lint, audits d'axiomes (implémentation et tests), Verso, PDF, Python, TikZ, contrôles rapides, REUSE, sécurité et `CI OK` ont réussi ; les seuls jobs ignorés l'ont été par la classification d'impact prévue. Le run antérieur [#38282825852](https://github.com/AntheaLiles/k7pl/actions/runs/38282825852) a échoué sur le premier essai du nouveau lemme : lint `unnecessarySimpa` et application incorrecte de `WithTop.coe_ne_top`. Ces erreurs ont été corrigées dans `7f2e535c…`, dont le build, le lint et l'audit d'axiomes ont ensuite passé. Cette CI verte valide la compilation du code et les contrôles configurés, pas les propriétés K7PL dont les preuves n'existent pas.
- L'audit indépendant du 11 octobre et le dossier probant du 11 octobre sont des snapshots historiques. Ils ne décrivent ni les têtes de branches actuelles ni le résultat CI de la révision actuelle.

## 2. Décisions de l'autrice prises en compte

| Décision | Lecture retenue | Limite non levée par la décision |
|---|---|---|
| C-01 interfaces | `π_U`, `Bang_𝒢` et `Scale_Usage` sont des interfaces de référence ; l'action ne modifie que l'usage. | La ratification n'est pas la preuve de naturalité, d'instanciation des règles ou de cohérence comonadique. |
| Modes structurels | `Lin`, `Aff`, `Unr` dans le périmètre ; `Rel` hors périmètre normatif courant. | Pas de preuve que les jugements effectifs respectent les permissions. |
| D3 | `Cost_Budget` est total sur le domaine conventionné, `max(W,D)`. | Reste à prouver la correspondance avec le domaine et les transitions effectives. |
| D4 | `sup ∅ = 0`; le domaine des niveaux peut être vide. | La définition mathématique seule ne prouve pas les règles de consommation. |
| D5 | `Adm(β,κ)` exprime la couverture `Cost_Budget(κ) ≤ β`. | La préservation par les règles n'est pas prouvée. |
| D6 | `Consume` est partielle, définie seulement avec preuve d'admissibilité. | Aucun site d'appel opérationnel n'est prouvé correct. |
| D7 | Le domaine de `ψ` est indépendant de la définissabilité de `Consume`. | Domaine et codomaine complets, règle de traversée et correction restent à établir. |
| D8 | Soustraction tronquée globale, avec budget infini conservé (`∞ ⊖ k = ∞`). | Les appels par couche et transitions effectives ne sont pas instanciés. |
| D9–D10 | La compatibilité par multiplicité est restreinte et conditionnelle ; `n=∞` n'est pas admis par défaut ; toute loi globale reste une piste. | Les sites historiques de dépendance doivent être audités avant de prétendre que ces hypothèses y suffisent. |
| D11 | Auditer les sites de preuve et leurs dépendances avant de fixer plus largement le domaine de multiplicité. | La provenance de l'audit est mieux tracée, mais la substitution et la traduction restent sans preuve Lean. |
| P3-B / budget option C | La latence environnementale de `When` est distincte du coût du corps déclenché ; validation statique, respect des bornes à l'exécution et garde-fous par couche sont des objectifs distincts. | Le type concret de l'observation de latence n'est pas ratifié ; l'orchestrateur et sa sémantique ne sont pas mécanisés. |

Les décisions enregistrées ne sont pas étendues au-delà de leur formulation. Aucune représentation de latence, restriction de la substitution ou validation H1/H2/H3 n'est inventée ici.

## 3. État des critères C-01 à C-09

| Lot | Résultat établi à cette révision | Blocage scientifique pour la sortie |
|---|---|---|
| **C-01 — PARTIEL** | `UsageScale` formalise un grade à quatre coordonnées, `π_U`, l'action sur l'usage, identité/composition et quelques lois sur porteurs/contextes non typés. `BudgetTransport` prouve une commutation/conservation pour une instance paramétrique de contexte. | Pas d'ordre complet du grade ni de correspondance aux règles ; `coerce`, `w`, `c`, `φ_n` et les lois comonadiques ne sont pas prouvés ensemble sous leurs domaines normatifs. |
| **C-02 — PARTIEL** | `StructuralModes` prouve des morphismes Lin→Aff→Unr au niveau d'un ordre abstrait idéal/prédicat. | Pas de correspondance entre ces permissions et le jugement/règles C3 effectivement mécanisés. |
| **C-03 — PARTIEL** | Les sources Verso délimitent les conversions et obligations. | Aucune formalisation des jugements de conversion K7PL dans `src/` ; identité, composition, naturalité, counité/comultiplication et transports effectifs non prouvés. |
| **C-04 — OUVERT** | `GradeBudget` formalise `Adm` et une consommation partielle au niveau profil ; `WhenBoundary` sépare observation abstraite et profil du corps, et prouve conservation à partir d'un certificat fourni. Un nouveau lemme refuse un coût infini sous budget naturel fini. | Le site d'appel de la règle `When` n'existe pas en Lean ; pas de preuve opérationnelle que les règles construisent le profil visé, vérifient `Adm`, appellent `Consume` dans son domaine et préservent la borne. |
| **C-05 — PARTIEL** | Le modèle `K = (ℕ∞ × ℕ∞)^L`, `W`, `D`, `max(W,D)`, monotonie, cas vides, nullité, bornes, minimalité scalaire et plusieurs lois de profil séquentiel/parallèle sont formalisés. La soustraction et conservation arithmétiques sont prouvées sur leur domaine. | Les profils sont définis, mais ne sont pas la mesure calculée par les règles/effets effectifs : il manque l'instanciation opérationnelle et ses théorèmes de correction. |
| **C-06 — OUVERT** | Audit d'inventaire : 49 occurrences des règles de typage, et distinction `Pair`/`Inj`. | Aucune induction Lean sur les constructeurs K7PL ; le résultat Verso reste `under-review/proofsketch`. |
| **C-07 — OUVERT** | La source exprime une cible de simulation avant et évite à juste titre les termes bisimulation/pleine abstraction. | `src/K7pl/Semantics.lean` est un compteur LTS ; pas de configurations K7PL, relation sur traces, observables, règles de traduction ni preuve locale par règle. |
| **C-08 — OUVERT** | `MemoryRange` prouve un sous-lemme sur plages ; `MemoryCapability` prouve l'unicité abstraite de ressources et l'absence de double capacité sous un invariant de contexte agrégé. | Aucun lien prouvé vers `Arena`, `WriteCap`, `alloc_range`, `Par` ou les règles effectives de mémoire ; H1/H2/H3 ne sont pas closes. |
| **C-09 — PARTIEL** | `lakefile.lean` épingle Lean/mathlib/cslib/verso à `v4.34.0` ; l'usage de CSLib dans le code concerne le LTS de compteur ; Verso porte la source documentaire. | Le mapping complet dépendance → hypothèses/fragments → concept K7PL → contrat d'instanciation n'est pas réalisé pour toutes les affirmations catégoriques, modales, temporelles et mémoire. |

## 4. Contrôle des règles effectives et des déclarations Lean

La source `spec/Spec/C3/ReglesDeTypage.lean` contient 49 occurrences de règles. La matrice complémentaire [L1-C-EFFECTIVE-RULE-EVIDENCE-MATRIX-2026-10-12.md](L1-C-EFFECTIVE-RULE-EVIDENCE-MATRIX-2026-10-12.md) les recense une à une et les qualifie comme non représentées par une règle effective dans `src/`. C'est une constatation de couverture formelle absente, pas une preuve d'incohérence mathématique du langage.

Dans les dix fichiers `src/K7pl*.lean` inspectés, une recherche textuelle des déclarations au niveau supérieur `axiom`, `sorry` ou `admit` n'a renvoyé aucun match. Ce contrôle lexical ne remplace pas une inspection des axiomes des théorèmes, et ne transforme pas les modèles génériques en théorèmes K7PL. Le job CI Lean valide la compilation de la bibliothèque et des cibles configurées, pas la présence d'une preuve de substitution, de simulation ou de sûreté mémoire qui n'y est pas définie.

## 5. Modification Lean réalisée dans cette reprise

Dans `src/K7pl/GradeBudget.lean`, deux théorèmes ont été ajoutés après `admK_iff_coverage` :

- `finite_budget_rejects_unbounded_cost` : un profil de coût `∞` ne peut pas être admissible pour un budget naturel fini ;
- `admitted_finite_budget_has_finite_cost` : sous la même admissibilité, le coût d'un profil soumis à un budget naturel est différent de `∞`.

Ils rendent explicite un cas-limite demandé pour C-04/C-05, dans le modèle `K`. Ils n'établissent ni que toutes les règles K7PL passent par `admK`, ni la correction opérationnelle de `Consume`.

## 6. Validations et reproductibilité

- Version de Lean déclarée : `leanprover/lean4:v4.34.0`; dépendances Lake épinglées dans `lakefile.lean`.
- Le run complet vérifié pour le code source candidat est [#38283308785](https://github.com/AntheaLiles/k7pl/actions/runs/38283308785), `success` sur `7f2e535c8f36fa87652d64623e1a168e477e3d13`. La correction de preuve ne repose pas sur un `sorry`, `admit` ou axiome ajouté.
- La nouvelle preuve a bien été compilée, lintée et incluse dans l'audit d'axiomes sur le SHA `7f2e535c8f36fa87652d64623e1a168e477e3d13`. La présente modification est documentaire ; la vérification GitHub de cette nouvelle tête documentaire doit rester verte avant toute fusion.
- L'environnement de cette reprise ne dispose pas de `lean`/`lake` et ne peut pas résoudre `github.com` pour un clone local. La validation exécutable dépend donc de GitHub Actions ; aucune compilation locale n'est revendiquée.
- Ne pas éditer `docs/STATUS.md` à la main : son statut est généré. Aucune fusion ni modification directe de `main` n'a été effectuée.

## 7. Verdict de sortie

**C-01 à C-09 ne sont pas tous satisfaits. Porte C NON FINALISÉE / NON SATISFAITE ; GO D–J non justifié.**

Les bloqueurs ne sont pas seulement documentaires. L'absence de syntaxe/jugements/règles K7PL en Lean empêche de prouver la correction des règles effectives, et le projet ne contient pas l'induction de substitution, le contrat de simulation ou l'instanciation des invariants mémoire exigés par les critères de sortie. Le run CI complet est désormais vert sur la révision de code ci-dessus ; il ne ferme pas les obligations scientifiques que la matrice identifie.

La faiblesse principale restante est l'écart entre les interfaces/modèles déjà prouvés et le calcul effectif décrit en Verso. La prochaine action indispensable est de construire ou d'identifier le noyau Lean des jugements et règles effectives, puis d'y prouver progressivement préservation des usages/modes/budgets, substitution et simulation, avec l'instanciation mémoire et les contrats externes. Cette étape ne peut être remplacée par davantage de fiches d'audit.


## 8. Décisions et obligations strictement résiduelles

Les décisions ratifiées D3–D11 et P3-B sont intégrées ci-dessus sans élargissement. Les blocages restants ne sont pas tous des décisions : la plupart sont des obligations techniques de formalisation et de preuve.

- **C-03 :** la compatibilité typée de `coerce`, `w`, `c`, `Sub` et `SubBox`, ainsi que les lois comonadiques et le passage d'un index complet à l'index projeté, doivent être prouvés dans la même instance que les règles. Le dossier courant signale aussi l'ambiguïté de `0·Δ` par rapport à `Scale_Usage(0,Δ)`; elle ne doit pas être tranchée par ce rapport.
- **C-04/C-07 :** P3-B fixe la séparation entre latence environnementale et coût d'exécution ; le type/carrier concret de l'observation de latence n'est pas ratifié. Sans ce choix, les observables de trace ne peuvent pas être finalisés de façon conforme.
- **C-06/C-07 :** substitution et simulation exigent un noyau Lean effectif (syntaxe, jugements, dérivations, configurations, transitions et observables) qui n'existe pas dans `src/K7pl/`. Une bibliothèque d'interfaces paramétriques ne fournit pas ces règles manquantes.
- **C-08 :** les audits accessibles n'établissent pas de ratification suffisante des options H1 ni des contrats concrets de H2/H3 et du profil de représentation Π. Les choix qui touchent la portée de la garantie mémoire doivent être ratifiés au lieu d'être inférés.
- **C-09 :** le rôle/version des dépendances est partiellement tracé ; les hypothèses importées et le contrat d'instanciation de chaque affirmation normative ne sont pas tous reliés à une preuve K7PL effective.

**Autocritique :** le progrès réalisé dans cette reprise est circonscrit : ajout d'un lemme Lean sur le refus d'un coût infini sous budget naturel fini, matrice traçable des 49 occurrences C3, test d'alignement, et revalidation indépendante de l'état Git/CI. Il n'ajoute pas le noyau de règles manquant. Présenter ce lot comme la « réalisation complète de C » serait donc scientifiquement incorrect.
