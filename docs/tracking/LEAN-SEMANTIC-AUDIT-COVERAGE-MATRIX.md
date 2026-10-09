<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Matrice de couverture de la revue sémantique

**État :** matrice de pilotage provisoire ; ne vaut ni ratification des classifications ni validation mathématique.  
**Référence source :** inventaire mécanique C8.0, 69 labels dans 21 fichiers ; références de lignes et dépendances revérifiées après fusion des PR #111, #114, #116 et #117.  
**But :** relier chaque bloc source aux notes de revue, aux dépendances directes explicites extraites des références `{num "thm:…"}`, et aux risques sémantiques prioritaires. Les dépendances documentaires implicites et les dépendances bibliographiques ne sont pas toutes capturées par ce graphe syntaxique.

## 1. Couverture des blocs

| Lot | Couverture | État |
|---|---|---|
| B01–B09 | 29 labels uniques environ ; certains blocs sont volontairement réexaminés comme dépendances dans plusieurs lots | Notes fusionnées ; constats provisoires |
| B10 | `thm:temps_mononiveau`, `thm:morphismes_modes`, `thm:boxtimes_addition` | Fusionné ([PR #111](https://github.com/AntheaLiles/k7pl/pull/111)) |
| B11 | Les 37 labels restants de l'inventaire, sans modifier les sources | Fusionné ([PR #114](https://github.com/AntheaLiles/k7pl/pull/114)) |
| Total de couverture documentaire | 69 labels uniques rattachés à une note B01–B11 | Complet au niveau de la couverture documentaire ; pas au niveau de la preuve mathématique |

Le nombre de mentions dans les lots est supérieur au nombre de labels uniques parce que certains résultats sont relus comme dépendances de plusieurs blocs. Les recouvrements ne constituent pas des blocs supplémentaires.

## 2. Matrice détaillée

| Label | Source | Lot(s) de revue | État du lot | Dépendances directes explicites | Risque principal |
|---|---|---|---|---|---|
| `thm:schema_commutation` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:35` | B01, B05 | Fusionné (PR d'audit) | — | — |
| `thm:schema_preservation` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:63` | B01 | Fusionné (PR d'audit) | — | — |
| `thm:tri_topologique` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:88` | B01 | Fusionné (PR d'audit) | — | — |
| `thm:schema_restriction` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:111` | B01 | Fusionné (PR d'audit) | — | — |
| `thm:schema_reinvocation` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:150` | B01, B05 | Fusionné (PR d'audit) | — | — |
| `thm:schema_effacement` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:188` | B01 | Fusionné (PR d'audit) | `thm:schema_commutation`, `thm:schema_preservation`, `thm:raffinement` | — |
| `thm:lemme_capacite` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean:227` | B01 | Fusionné (PR d'audit) | — | — |
| `thm:surete_spatiale` | `spec/Spec/C4/ModelesDeMemoire.lean:41` | B11 | Fusionné (PR #114) | `thm:lemme_capacite` | H1 est une prémisse que l'autre bloc prétend établir |
| `thm:introduction_unique` | `spec/Spec/C4/ModelesDeMemoire.lean:99` | B11 | Fusionné (PR #114) | `thm:surete_spatiale` | Circularité argumentative H1; cas d'élimination d'arène manquant |
| `thm:elaboration` | `spec/Spec/C5/LeTheoremeDElaboration.lean:30` | B11 | Fusionné (PR #114) | `thm:schema_commutation` | — |
| `thm:raffinement` | `spec/Spec/C2/SystemeDeRaffinement.lean:52` | B01, B02 | Fusionné (PR d'audit) | `thm:traduction_metalangage` | — |
| `thm:non_interference` | `spec/Spec/C2/SystemeDeRaffinement.lean:152` | B02 | Fusionné (PR d'audit) | — | — |
| `thm:determinisme_observationnel` | `spec/Spec/C2/SystemeDeRaffinement.lean:191` | B02 | Fusionné (PR d'audit) | — | — |
| `thm:staticite_syntaxe` | `spec/Spec/C5/NotationsSpecialisees.lean:126` | B11 | Fusionné (PR #114) | — | — |
| `thm:hygiene` | `spec/Spec/C5/NotationsSpecialisees.lean:217` | B11 | Fusionné (PR #114) | — | — |
| `thm:hygiene_graduee` | `spec/Spec/C5/NotationsSpecialisees.lean:241` | B11 | Fusionné (PR #114) | `thm:expansion_macro` | — |
| `thm:resucrage` | `spec/Spec/C5/NotationsSpecialisees.lean:261` | B11 | Fusionné (PR #114) | — | Exigence; algèbre de liaison de surface absente |
| `thm:determinisme_rejeu` | `spec/Spec/C4/EchelleDuSysteme.lean:118` | B11 | Fusionné (PR #114) | — | — |
| `thm:rejeu_binaire` | `spec/Spec/C4/EchelleDuSysteme.lean:144` | B11 | Fusionné (PR #114) | `thm:determinisme_rejeu`, `thm:schema_restriction` | — |
| `thm:liberte_initialisation` | `spec/Spec/C4/EchelleDuSysteme.lean:320` | B11 | Fusionné (PR #114) | `thm:tri_topologique` | — |
| `thm:sync_motifs_jonction` | `spec/Spec/C4/EchelleDuSysteme.lean:469` | B11 | Fusionné (PR #114) | — | — |
| `thm:surete_ffi` | `spec/Spec/C4/EchelleDuSysteme.lean:548` | B11 | Fusionné (PR #114) | — | — |
| `thm:revocation_ffi` | `spec/Spec/C4/EchelleDuSysteme.lean:575` | B11 | Fusionné (PR #114) | — | Exigence d'implémentation hors du seul système de types |
| `thm:temps_mononiveau` | `spec/Spec/C3/GrammaireDesTypes.lean:123` | B10 | Fusionné (PR #111) | — | — |
| `thm:morphismes_modes` | `spec/Spec/C3/LeSystemeGradue.lean:130` | B10 | Fusionné (PR #111) | — | — |
| `thm:completude_graduee` | `spec/Spec/C3/LeSystemeGradue.lean:521` | B11 | Fusionné (PR #114) | — | — |
| `thm:completude_verificateur` | `spec/Spec/C3/LeSystemeGradue.lean:555` | B11 | Fusionné (PR #114) | — | Exigence d'implémentation, pas théorème établi |
| `thm:boxtimes_addition` | `spec/Spec/C3/ReglesDeTypage.lean:103` | B10 | Fusionné (PR #111) | — | — |
| `thm:coherence_subsomption` | `spec/Spec/C3/ReglesDeTypage.lean:386` | B11 | Fusionné (PR #114) | — | — |
| `thm:commutation_monoide` | `spec/Spec/C3/ReglesDeTypage.lean:726` | B11 | Fusionné (PR #114) | — | — |
| `thm:determinisme_parallele` | `spec/Spec/C3/ReglesDeTypage.lean:1319` | B08 | Fusionné (PR d'audit) | — | — |
| `thm:substitution` | `spec/Spec/C3/ReglesDeTypage.lean:1605` | B11 | Fusionné (PR #114) | — | — |
| `thm:substitution_simultanee` | `spec/Spec/C3/ReglesDeTypage.lean:1696` | B11 | Fusionné (PR #114) | `thm:substitution` | — |
| `thm:preservation` | `spec/Spec/C4/SemantiqueOperationnelle.lean:137` | B03 | Fusionné (PR d'audit) | — | — |
| `thm:progres` | `spec/Spec/C4/SemantiqueOperationnelle.lean:195` | B03 | Fusionné (PR d'audit) | — | — |
| `thm:correction_ressource` | `spec/Spec/C4/SemantiqueOperationnelle.lean:290` | B03 | Fusionné (PR d'audit) | — | — |
| `thm:stratification_journal` | `spec/Spec/C4/SemantiqueOperationnelle.lean:393` | B04 | Fusionné (PR d'audit) | — | — |
| `thm:relation_produit` | `spec/Spec/C4/SemantiqueOperationnelle.lean:535` | B04 | Fusionné (PR d'audit) | `thm:troncature_comonade` | — |
| `thm:lemme_fondamental` | `spec/Spec/C4/SemantiqueOperationnelle.lean:561` | B11 | Fusionné (PR #114) | `thm:substitution`, `thm:substitution_simultanee` | Portée restreinte au fragment sans `Declassify` ; extension à la déclassification non prouvée |
| `thm:commutation_traduction` | `spec/Spec/C4/SemantiqueOperationnelle.lean:717` | B05, B07 | Fusionné (PR d'audit) | `thm:schema_commutation`, `thm:substitution` | — |
| `thm:image_fix` | `spec/Spec/C4/SemantiqueOperationnelle.lean:792` | B05 | Fusionné (PR d'audit) | `thm:terminaison_lfp` | — |
| `thm:isomorphisme_memoire` | `spec/Spec/C4/EchelleDeLActeur.lean:142` | B11 | Fusionné (PR #114) | — | — |
| `thm:expansion_macro` | `spec/Spec/C5/CeQuUneMacroDeclare.lean:96` | B11 | Fusionné (PR #114) | `thm:substitution`, `thm:elaboration` | — |
| `thm:deadlock_acyclique` | `spec/Spec/C3/LesContraintesDeValeur.lean:274` | B08 | Fusionné (PR d'audit) | `thm:tri_topologique` | — |
| `thm:homomorphisme_roues` | `spec/Spec/C3/LesContraintesDeValeur.lean:350` | B11 | Fusionné (PR #114) | — | — |
| `thm:representation_inobservable` | `spec/Spec/C3/LesContraintesDeValeur.lean:384` | B11 | Fusionné (PR #114, correction dans [PR #116](https://github.com/AntheaLiles/k7pl/pull/116)) | — | Relation de représentations admissibles et types de `repr`/`obs` à préciser |
| `thm:interface_jugement` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean:60` | B11 | Fusionné (PR #114) | — | — |
| `thm:rejet_reproductible` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean:132` | B11 | Fusionné (PR #114) | — | — |
| `thm:abaissement_grades` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean:463` | B11 | Fusionné (PR #114) | `thm:schema_preservation` | Conjecture; obligations par passe non acquittées |
| `thm:terminaison_couche_3` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:132` | B11 | Fusionné (PR #114) | `thm:progression_polarisee` | — |
| `thm:sedimentation` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:216` | B02 | Fusionné (PR d'audit) | — | Résultat de littérature + obligation graduée ouverte |
| `thm:productivite_couche_2` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:294` | B11 | Fusionné (PR #114) | `thm:progression_polarisee` | L'absorption à ω ne prouve pas à elle seule la productivité |
| `thm:progression_polarisee` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:342` | B11 | Fusionné (PR #114) | — | — |
| `thm:loi_historique` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:454` | B11 | Fusionné (PR #114) | — | — |
| `thm:troncature_comonade` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:526` | B11 | Fusionné (PR #114) | — | — |
| `thm:fenetre_grade` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:576` | B11 | Fusionné (PR #114) | `thm:troncature_comonade` | Correspondance des trois fenêtres non démontrée |
| `thm:traduction_metalangage` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:151` | B02, B06 | Fusionné (PR d'audit) | — | — |
| `thm:simulation` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:299` | B07 | Fusionné (PR d'audit) | `thm:commutation_traduction`, `thm:fidelite_interprete` | Dépendance argumentative à la fidélité; trace/canal temporel à préciser |
| `thm:fidelite_interprete` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:340` | B07 | Fusionné (PR d'audit) | `thm:traduction_metalangage`, `thm:schema_effacement` | Conditionnelle à Sim; préservation du typage seule insuffisante |
| `thm:stabilisation_pipeline` | `spec/Spec/C6/LeProcessusDeCompilation.lean:155` | B11 | Fusionné (PR #114) | — | — |
| `thm:cloture_sortage` | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean:187` | B06 | Fusionné (PR d'audit) | — | — |
| `thm:confinement_sortes` | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean:214` | B06 | Fusionné (PR d'audit) | `thm:traduction_metalangage`, `thm:temps_mononiveau` | — |
| `thm:divulgation_delimitee` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean:234` | B11 | Fusionné (PR #114) | `thm:non_interference` | Cas `Declassify` et relation sensible à la divulgation restent à prouver |
| `thm:terminaison_lfp` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean:378` | B05 | Fusionné (PR d'audit) | — | — |
| `thm:distributivite_tronquee` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:125` | B09 | Fusionné (PR d'audit) | — | — |
| `thm:coherence_axiome` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:158` | B09 | Fusionné (PR d'audit) | — | — |
| `thm:coherence_usage` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:182` | B09 | Fusionné (PR d'audit) | — | — |
| `thm:action_parallele` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:280` | B11 | Fusionné (PR #114) | — | — |
| `thm:preservation_type` | `spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean:253` | B11 | Fusionné (PR #114) | `thm:abaissement_grades` | Bloc composé : réduction vs abaissement MLIR conjectural |

## 3. Graphe des dépendances et risques

### Cycle syntaxique résolu sur `main`

La [PR #117](https://github.com/AntheaLiles/k7pl/pull/117) est fusionnée et sa CI a réussi. Le lemme fondamental est limité au fragment sans `Declassify` (y compris dans les images de substitution) et sa référence retour à `thm:divulgation_delimitee` a été supprimée. Le cycle syntaxique est donc résolu par restriction de portée, pas par démonstration du cas manquant. `thm:divulgation_delimitee` reste ouvert : sa relation sensible à la divulgation et son cas `Declassify` ne sont pas prouvés.

### Circularité argumentative sans cycle syntaxique

- `thm:introduction_unique → thm:surete_spatiale` est la seule référence directe. Toutefois, la sûreté suppose H1 tandis que l'introduction prétend établir H1 et laisse l'élimination d'arène à écrire. Il faut un argument indépendant pour H1.
- `thm:simulation` renvoie à `thm:fidelite_interprete` comme au résultat qui utilise l'hypothèse Sim ; le théorème de fidélité dépend à son tour de l'existence d'une simulation, sans référence syntaxique inverse. Il s'agit d'une dette argumentative et non du cycle syntaxique rapporté par l'extracteur. La simulation doit être établie indépendamment, notamment pour l'ordre de trace/canal temporel.

### Dépendances structurantes à traiter ensemble

- **Substitution et relation logique :** `thm:substitution` → `thm:substitution_simultanee` → `thm:lemme_fondamental` ; les lois de mise à l'échelle, le transport d'effet et les cas de modalité doivent être distingués.
- **Traduction et fidélité :** `thm:traduction_metalangage` → `thm:raffinement` / `thm:fidelite_interprete` ; préservation du typage, simulation de réduction, préservation des traces et adéquation observationnelle sont des résultats distincts.
- **Effets et budget :** `thm:temps_mononiveau`, `thm:boxtimes_addition`, `thm:coherence_axiome`, `thm:coherence_usage`, `thm:action_parallele` et `thm:distributivite_tronquee` exigent une signature explicite des opérations et de leurs domaines.
- **Abaissement et préservation :** `thm:preservation_type` doit être suivi comme bloc composé ; son volet de réduction ne valide pas la conjecture `thm:abaissement_grades`.
- **Représentation :** `thm:isomorphisme_memoire`, `thm:homomorphisme_roues` et `thm:representation_inobservable` portent des engagements d'ABI et d'observabilité distincts. La [PR #116](https://github.com/AntheaLiles/k7pl/pull/116) a corrigé la formule pour exprimer l'invariance des observations entre représentations admissibles d'une même valeur. La définition de cette admissibilité et les types de `repr`/`obs` restent à préciser.

## 4. Décision de préparation à la migration

À ce stade, **aucun bloc n'est certifié prêt pour migration sémantique** par la seule existence d'une note de revue. Le tableau prouve la couverture documentaire, pas la résolution des obligations. Les classifications du registre restent provisoires.

Avant C8.0, il reste à :
1. faire ratifier la classification rôle/état de chaque bloc, en particulier les exigences et les blocs composés ;
2. établir H1 indépendamment ou conserver explicitement son statut d'hypothèse normative/architecturale, sans raisonnement circulaire ;
3. formaliser la relation de divulgation et traiter le cas `Declassify` sans promouvoir son statut avant preuve ;
4. préciser les représentations admissibles et les signatures de `repr`/`obs` pour `thm:representation_inobservable` ;
5. régénérer l'inventaire mécanique et le contrôle de dérive sur `main`, puis vérifier les références bibliographiques et les hypothèses locales ;
6. seulement après ratification des classifications et validation des obligations, planifier la migration contrôlée en préservant labels, références, texte, hypothèses et statuts, avec toute correction éditoriale dans une PR séparée.

**Conclusion :** la couverture documentaire des 69 labels est complète. Le cycle syntaxique lemme fondamental/divulgation a été supprimé par restriction explicite de portée ; cela ne prouve pas la divulgation. La revue sémantique n'est pas close : plusieurs obligations restent ouvertes, notamment H1 et la dépendance argumentative simulation/fidélité. La migration n'est pas encore autorisée par cette matrice.
