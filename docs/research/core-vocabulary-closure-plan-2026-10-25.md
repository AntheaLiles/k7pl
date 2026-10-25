<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# K7PL — plan de clôture du chantier vocabulaire du noyau

> Plan non normatif. Baseline : main @ c88c968e66e5951bbf300efe3e39a515df8d8aa3. Aucun point ne vaut autorisation de modifier la théorie ou de fusionner une PR.

## 1. Principe de progression

Le chantier doit fermer les objets avant de fermer les noms. Chaque étape a un critère de sortie observable, un responsable de décision, les preuves requises et un livrable traçable. Une étape peut rester bloquée ; il ne faut pas la contourner par une décision lexicale.

## 2. Lots et dépendances

| Phase | Objectif | Travaux | Sortie vérifiable | Bloqueurs / dépendances |
|---|---|---|---|---|
| P0 — snapshot | Figer l'état d'observation. | SHA de main, tree, statuts de sources, liens permanents et inventaire initial. | Révision identifiée et toute conclusion rattachée à une source. | Déjà réalisé pour le dossier au SHA indiqué. |
| P1 — cohérence d'inventaire | Fermer l'écart grammaire/contrôle croisé. | Reconstituer toutes les formes de terme, inclure les deux règles exposées séparément (fix et declassify) dans l'audit de couverture ; examiner la table EXPECTED, les regex de labels, les règles sans forme, les formes sans entrée et les règles de type/session. Exécuter les contrôles existants dans un clone local lors d'un chantier distinct. | Liste explicite de toutes les formes/règles et verdict pour chaque divergence ; le contrôle détecte désormais les omissions connues ou documente précisément son périmètre. | Action de correction/outillage hors du présent lot documentaire. Aucune modification de scripts autorisée par ce dossier. |
| P2 — clôture ontologique | Déterminer les primitives nécessaires avant de leur attribuer un nom définitif. | Pour chaque objet : concept → obligation → règle → propriété → preuve/justification. Rejouer REFUS-01 à REFUS-07 ; auditer Vec, ν/Out/Cop, fix, declassify, Del/Alw/Now/Wait/When, Slice/Cap. | Chaque candidat a le statut A–H, les obligations préservées/perdues, les preuves existantes et les inconnues clairement distinctes. | Porte C, D-T1/D-T2, preuve de ressources de When, et complétude du contrôle croisé. |
| P3 — protocole de nommage | Définir la méthode d'arbitrage. | Répondre à Q-METH-001 sur le rang écologique et Q-METH-002 sur les lots vs instruction progressive ; définir le caractère éliminatoire de chaque critère. | Ordre séquentiel ratifié, aucune note composite non justifiée, critères et limites archivés. | Décision de l'autrice ; les sources d'Arc G n'ont pas rangé explicitement le critère écologique dans un ordre ratifié. |
| P4 — noms de familles stables | Instruire d'abord les décisions dont la cohérence dépend d'un couplage. | Famille A : Pack/Open, Fold/Unfold, Gen/Inst, With/Proj, Box/Unbox ; familles B : Op/Sc, opération/perform/handle/handler ; famille C : at/at_n, always/now/wait/when/delay ; famille D : VecI/VecE/vmap/pli indexé ; famille E : new/send/guard/free/slice et capabilities. | Questions liées décidées ensemble lorsque la définition le demande ; synonymie non imposée quand l'obligation diverge. | P2 doit établir les concepts ; When et les catégories temporelles sont différés. |
| P5 — consultation progressive | Recueillir des choix lisibles et traçables. | Première consultation : valeurs, sommes et calculs simples (Q-TERM-001–024). Deuxième : fix, déclassification, effets, vecteurs (Q-TERM-025–029). Troisième : temps et coinduction (Q-TERM-030–037, uniquement après fermeture des blocages). Quatrième : parallélisme, lieu, tâches et capacités (Q-TERM-038–048). Questions K séparées Q-TOKEN-001–007. | Chaque réponse enregistrée dans VOC-… ; « Autre » ajoute les mêmes évaluations ; « Précision » crée une tâche distincte. | Ne demander aucun choix de nom comme si l'existence normative était décidée lorsque P2 reste ouvert. |
| P6 — justification et contre-épreuve | Transformer le choix en argument vérifiable. | Pour chaque terme choisi, tester sens exact, collision d'espace de noms, cohérence de famille, changement de grade/modalité, ambiguïtés à la lecture ; si l'argument mnémonique reste ambigu, garder l'incertitude. Évaluer des contre-exemples de noms trompeurs. | Décision justifiée ou objection explicitement maintenue ; candidates rejetées conservées avec raisons. | Aucune preuve empirique de mémorabilité de mots-clés K7PL n'est disponible. Une expérimentation serait un protocole séparé. |
| P7 — autorisation d'intégration normative | Appliquer les décisions ratifiées. | Après accord explicite, modifier uniquement les sources autorisées, mettre à jour registre/glossaire/index et liaisons de grammaire/règle ; vérifier que les macros glyphes restent des macros et que les alias produisent le même AST. | PR dédiée, diff limité, conventional commit, liens valides et registres actualisés. | Aucune intégration normative autorisée par le présent dossier seul. |
| P8 — validation formelle et traçabilité | Vérifier chaque chaîne correspondante. | Pour chaque ID, relier syntaxe, règle de typage, réduction, K, transition/invariant TLA+, représentation Lean, test/preuve. Exécuter les compilations et tests pertinents ; identifier les obligations non prouvées. | Rapport avec commandes/résultats observés et SHA ; aucun statut « vérifié » si le résultat est absent. | K/TLA+ ne sont pas déjà supposés implémentés ; compilation de Verso n'est pas preuve de correction sémantique. |

## 3. Ordre des familles de consultation

### Lot A — formes de valeur et structure pure

- Q-TERM-001 à 009 : variable, unité, paire, somme, modalité, suspension, existentiel, point fixe inductif et vecteur littéral.
- Q-TERM-010 à 024 : return/let, λ/application/force, case, éliminateurs, quantification universelle.
- Couplages impératifs : Pair/Split ; Inj/Case ; Pack/Open ; Fold/Unfold ; Gen/Inst ; Box/Unbox. Avec/Proj doivent être traités comme une famille, mais la dualité de mots ne remplace pas l'étude des règles.

### Lot B — constructions dont la minimalité et les contraintes formelles changent le choix

- Q-TERM-025 et 026 : fix et declassify, après correction de l'inventaire et instruction de D-T1.
- Q-TERM-027, 039 et Q-TOKEN-004/005 : vecteur, itération, application vectorisée ; ne pas fusionner tant que la conservation des effets indexés et des grades par position n'est pas démontrée.
- Q-TERM-028/029 et Q-TOKEN-007 : operation/scoped et les formes de surface ; REFUS-07 demeure un test obligatoire.

### Lot C — temporalité et coinduction (bloqué)

- Q-TERM-030 à 035 : delay, always, lecture permanente, now, wait, when ; la cohérence type/terme et le protocole d'attente priment le choix lexical.
- Q-TERM-036/037 : out et copatrons ; rapprocher les règles présentes du texte résiduel de primitives.md.
- Une réponse lexicale préférée sur When ne ferme ni D-T1/D-T2 ni la preuve de correction.

### Lot D — concurrence, lieux et capacités

- Q-TERM-038–042 : parallèle, vmap, lieu, move, try.
- Q-TERM-043–047 : spawn, new, send, guard, free, avec D-P2 à garder visible pour Guard.
- Q-TERM-048 + Q-TOKEN-006 : slice / Cap / partition, sans assimiler partition de segments à la relation de disjonction du calcul de grades.

## 4. Critères de sortie globaux

La préparation est close seulement si :
1. les sources normatives, historiques et bibliographiques ont un rôle explicite ;
2. l'écart 46/48 de la grammaire et du contrôle est résolu, ou clairement scindé en une obligation de correction et une décision de périmètre argumentée ;
3. toutes les formes C3 ont une correspondance testable avec les règles et toutes les règles sans constructeur sont identifiées ;
4. primitives conceptuelles, formelles, normatives, constructions de grammaire, macros/alias, éléments d'implémentation et lemmes descriptifs sont distincts ;
5. les sept factorisations refusées ont été rejouées contre les nouvelles propositions ;
6. le protocole Arc G et la portée de l'évaluation écologique sont explicitement ratifiés ou restent ouverts ;
7. chaque lemme encore ouvert possède un QCM, et chaque token séparément ouvert dispose de sa question liée ;
8. chaque réponse de l'autrice a une entrée de décision non destructive et une trace vers les questions dépendantes ;
9. aucun argument de familiarité ou d'écologie n'est présenté comme résultat mesuré sans étude ;
10. les dépendances K/TLA+/Lean sont liées par identifiants et obligations plutôt que par uniformité artificielle des noms ;
11. l'autorisation d'intégration normative et les résultats de validation proviennent d'actes et d'artefacts ultérieurs identifiés.

## 5. Limites de clôture

La documentation du questionnaire peut être prête alors que le vocabulaire reste non stabilisé. La stabilisation n'est pas acquise par la présence de tous les QCM : elle exige les décisions de l'autrice, les obligations scientifiques traitées, l'intégration explicitement autorisée et la vérification des artefacts affectés. Une CI verte prouverait que les contrôles exécutés ont réussi, non que les lemmes choisis sont sémantiquement supérieurs.
