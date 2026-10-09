<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Revue sémantique des dépendances à risque

**État :** note de revue provisoire, à ratifier.  
**Périmètre :** deux situations relevées dans les blocs `::::thm` actifs.  
**Règle :** cette note distingue les références syntaxiques des dépendances réelles de preuve. Elle ne modifie ni les énoncés sources ni leur statut épistémique.

## 1. Résumé des constats

| Cas | Références directes observées | Nature du problème | Conclusion autorisée |
|---|---|---|---|
| `thm:surete_spatiale` / `thm:introduction_unique` | `thm:introduction_unique → thm:surete_spatiale` | Circularité argumentative autour de H1, mais pas de cycle syntaxique | Revue sémantique requise ; ne pas compter comme cycle détecté |
| `thm:lemme_fondamental` / `thm:divulgation_delimitee` | `thm:lemme_fondamental → thm:divulgation_delimitee` et `thm:divulgation_delimitee → thm:lemme_fondamental` | Cycle syntaxique ; le sens des deux arêtes n’est pas identique | Bloquant pour l’affirmation d’une preuve complète ; statuts à laisser ouverts |

## 2. H1 — sûreté spatiale et introduction unique

Sources : `spec/Spec/C4/ModelesDeMemoire.lean`, labels `thm:surete_spatiale` et `thm:introduction_unique`.

Le théorème de sûreté spatiale pose H1 — au plus une capacité d’écriture par région — parmi ses hypothèses. Son esquisse explique que H1 exclut l’introduction de deux capacités distinctes sur une même région. Le théorème d’introduction unique prétend établir cette propriété, mais la désigne comme « hypothèse H1 du théorème `thm:surete_spatiale` ». Son esquisse ajoute que le cas d’élimination de l’arène reste à écrire et que H1 en dépend.

La référence directe est unidirectionnelle : le bloc d’introduction unique cite le théorème de sûreté ; le bloc de sûreté ne cite pas le bloc d’introduction unique par label. Il s’agit donc d’une circularité argumentative potentielle, pas d’un cycle dans le graphe syntaxique.

### Décision à prendre

Il faut établir d’où vient H1, sans utiliser le résultat qu’elle conditionne comme sa propre justification. Les voies possibles à examiner sont :

1. **Compléter la preuve de la règle d’élimination de l’arène.** Si cette règle permet réellement de dériver l’unicité, `thm:introduction_unique` pourrait fournir un résultat indépendant, puis devenir une dépendance de `thm:surete_spatiale`.
2. **Conserver H1 comme hypothèse normative ou architecturale.** Dans ce cas, le théorème d’introduction unique ne peut pas être présenté comme établi par la seule hypothèse qu’il prétend justifier ; sa portée doit être restreinte ou son statut laissé ouvert.
3. **Reformuler les objets et les prémisses après revue des règles.** À envisager seulement si les deux énoncés parlent en réalité de niveaux différents d’unicité.

Aucune de ces voies n’est ratifiée ici. H2 (disjonction des intervalles) et H3 (sens d’imbrication des délimiteurs) doivent rester explicites et distinctes ; la résolution de H1 ne les élimine pas.

## 3. Déclassification — lemme fondamental et divulgation délimitée

Sources : `spec/Spec/C4/SemantiqueOperationnelle.lean`, label `thm:lemme_fondamental` ; `spec/Spec/C2/AdjonctionsEtEnrichissement.lean`, label `thm:divulgation_delimitee`.

Le croquis du lemme fondamental traite les cas ordinaires, puis indique que le cas `Declassify` n’est pas traité et renvoie à `thm:divulgation_delimitee`. L’énoncé du lemme fondamental reste pourtant formulé pour tout terme bien typé. La divulgation délimitée, de son côté, dit explicitement que son croquis n’est pas une preuve et propose une route par paramétricité qui utilise le lemme fondamental et la non-interférence.

Le graphe contient donc bien deux références directes. Leur rôle n’est toutefois pas symétrique :
- l’arête du lemme fondamental vers la divulgation est une référence à la lacune laissée dans son esquisse, pas une prémisse positive de preuve ;
- l’arête de la divulgation vers le lemme fondamental est une dépendance explicite de l’argument proposé.

Ce cycle syntaxique ne suffit pas à démontrer une circularité mathématique formelle ; il établit en revanche que la documentation actuelle ne présente pas encore une dérivation complète et ordonnée des deux résultats.

### Architectures possibles à examiner

1. **Lemme fondamental pour le langage de base.** Restreindre explicitement le lemme fondamental au fragment sans `Declassify`, puis prouver séparément l’admissibilité de la déclassification et la divulgation délimitée. Cette option exige de réexaminer les théorèmes de non-interférence qui dépendent du lemme.
2. **Lemme fondamental paramétré par une relation de libération.** Formuler le cas `Declassify` avec une condition locale de compatibilité ou d’admissibilité, prouver le lemme sous cette condition, puis établir que la construction de divulgation la satisfait.
3. **Résultat auxiliaire indépendant.** Isoler un lemme de paramétricité ou de clôture des échappatoires, démontré sans utiliser le lemme fondamental complet, puis l’utiliser pour établir la divulgation et compléter le cas `Declassify`.

Ces options sont des architectures de preuve candidates, pas des résultats validés. Il faut vérifier leur compatibilité avec la définition des échappatoires, leur clôture, la substitution, la non-interférence et le sens exact de « tout terme bien typé ».

### Décision à prendre

Avant la migration des commandes :
- décider si `thm:lemme_fondamental` porte sur le langage entier ou seulement sur le fragment de base ;
- expliciter le statut du cas `Declassify` (hypothèse locale, obligation ouverte, ou cas démontré) ;
- établir une séquence de dépendances acyclique pour les résultats effectivement prouvés ;
- conserver `thm:divulgation_delimitee` comme non démontré tant qu’une preuve complète n’a pas été fournie et revue.

## 4. Conséquences pour C8

1. Le détecteur de cycles syntaxiques doit signaler le couple lemme fondamental / divulgation délimitée, mais pas le couple sûreté spatiale / introduction unique.
2. La détection syntaxique ne remplace pas la classification des arêtes : preuve, hypothèse, obligation ouverte, citation ou mention contextuelle.
3. Les classifications candidates des quatre énoncés restent provisoires. Aucun ne doit être automatiquement promu à l’état `established`.
4. La migration mécanique ne doit pas résoudre ces questions en changeant silencieusement l’ordre des références, les hypothèses ou les textes.
5. C8.0 reste ouvert jusqu’à résolution documentée de ces points et revue intégrale des énoncés, hypothèses et esquisses concernés.

## 5. Vérifications effectuées

- Lecture des blocs complets `thm:surete_spatiale`, `thm:introduction_unique`, `thm:lemme_fondamental` et `thm:divulgation_delimitee`.
- Extraction des références directes `{num "thm:..."}` dans chacun des blocs.
- Distinction explicite entre cycle syntaxique et circularité argumentative.
- Aucun changement apporté aux sources mathématiques.


## 6. Compound blocks that must not inherit one status

A separate reading of four complete blocks confirms that a single future command kind and epistemic state cannot safely represent all of their contents. These are decomposition candidates for a later, explicitly reviewed source migration; no split is performed here.

### `thm:sedimentation` — literature result plus open graded requirement

The surrounding prose attributes the non-graded nested fixed-point result to the literature and cites Kurz and others. The statement then distinguishes two cases: (i) non-graded containers, described as a literature result reused here; (ii) graded containers, explicitly an open requirement. The proof sketch presents the route for convergence but does not establish the graded case.

**Candidate decomposition:** retain a literature-result object with bibliographic provenance for the non-graded case; represent the graded case as a scoped requirement or open conjecture only after the author decides whether it is a desired property or a mathematical claim. Preserve the dependency between them without transferring the literature result's epistemic status to the graded case.

### `thm:preservation_type` — preservation theorem plus MLIR-lowering conjecture

The statement's first claim is type preservation under the P2 separation condition. It then identifies the MLIR-lowering volet as `thm:abaissement_grades`, explicitly “non démontré”. The sketch distinguishes ordinary reduction from MLIR defunctionalisation/inlining and states that obligation P1b is not established.

**Candidate decomposition:** one result for preservation by reduction, with P2 as an explicit premise; a separate open conjecture or requirement for MLIR lowering, with P1b and per-pass obligations attached to that object. Do not let the first result's evidence or state propagate to the second.

### `thm:elaboration` — definition plus semantic-preservation property

The block is marked `status := "definition"`, but its statement also claims that every surface form has no independent meaning beyond the elaborated core term. Its sketch argues from recursive definition and the commutation schema to semantic invariance, and includes further quantitative caveats.

**Candidate decomposition:** define `Elab` as a function from surface syntax to core terms; express preservation of meaning and commutation with substitution as separate result objects, each with explicit assumptions. Keep the quantitative and finite-reinvocation caveats attached to the result they constrain, rather than silently treating them as consequences of the definition.

### `thm:interface_jugement` — definition plus finite-forms closure claim

The block is marked as a definition and defines an interface as a judgment with three components. It also asserts a closure property over the declaration forms enumerated in the chapter: no fourth component is required and none of the three is empty. The proof sketch says the property is established by finite enumeration and limits its scope to those forms.

**Candidate decomposition:** define the interface/judgment correspondence separately from a proposition about closure for the currently enumerated declaration forms. Encode the finite scope explicitly. The text's note that a probabilistic extension may require revision must remain as a limitation, not be dropped during prose reduction.

### Acceptance condition for these cases

Before migration, the classification review must decide for each component its object kind, logical role where applicable, epistemic state, scope, evidence/provenance, and normative effect. The split must preserve labels and cross-references deliberately, and must not be carried out as a mechanical edit before those decisions are ratified.
