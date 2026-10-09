<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C8 — Matrice de couverture de la revue sémantique

**État :** matrice de pilotage provisoire ; ne vaut ni ratification des classifications ni validation mathématique.  
**Référence source :** inventaire mécanique C8.0, 69 labels dans 21 fichiers.  
**But :** relier chaque bloc source aux notes de revue, aux dépendances directes explicites extraites des références `{num "thm:…"}`, et aux risques sémantiques prioritaires. Les dépendances documentaires implicites et les dépendances bibliographiques ne sont pas toutes capturées par ce graphe syntaxique.

## 1. Couverture des blocs

| Lot | Couverture | État |
|---|---|---|
| B01–B09 | 29 labels uniques environ ; certains blocs sont volontairement réexaminés comme dépendances dans plusieurs lots | Notes fusionnées ; constats provisoires |
| B10 | `thm:temps_mononiveau`, `thm:morphismes_modes`, `thm:boxtimes_addition` | [PR #111](https://github.com/AntheaLiles/k7pl/pull/111), ouverte ; CI relancée et verte après erreurs réseau Docker Hub |
| B11 | Les 37 labels restants de l'inventaire, sans modifier les sources | [PR #114](https://github.com/AntheaLiles/k7pl/pull/114), ouverte |
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
| `thm:surete_spatiale` | `spec/Spec/C4/ModelesDeMemoire.lean:41` | B11 | PR #114 ouverte | `thm:lemme_capacite` | H1 est une prémisse que l'autre bloc prétend établir |
| `thm:introduction_unique` | `spec/Spec/C4/ModelesDeMemoire.lean:99` | B11 | PR #114 ouverte | `thm:surete_spatiale` | Circularité argumentative H1; cas d'élimination d'arène manquant |
| `thm:elaboration` | `spec/Spec/C5/LeTheoremeDElaboration.lean:30` | B11 | PR #114 ouverte | `thm:schema_commutation` | — |
| `thm:raffinement` | `spec/Spec/C2/SystemeDeRaffinement.lean:52` | B01, B02 | Fusionné (PR d'audit) | `thm:traduction_metalangage` | — |
| `thm:non_interference` | `spec/Spec/C2/SystemeDeRaffinement.lean:152` | B02 | Fusionné (PR d'audit) | — | — |
| `thm:determinisme_observationnel` | `spec/Spec/C2/SystemeDeRaffinement.lean:191` | B02 | Fusionné (PR d'audit) | — | — |
| `thm:staticite_syntaxe` | `spec/Spec/C5/NotationsSpecialisees.lean:126` | B11 | PR #114 ouverte | — | — |
| `thm:hygiene` | `spec/Spec/C5/NotationsSpecialisees.lean:217` | B11 | PR #114 ouverte | — | — |
| `thm:hygiene_graduee` | `spec/Spec/C5/NotationsSpecialisees.lean:241` | B11 | PR #114 ouverte | `thm:expansion_macro` | — |
| `thm:resucrage` | `spec/Spec/C5/NotationsSpecialisees.lean:261` | B11 | PR #114 ouverte | — | Exigence; algèbre de liaison de surface absente |
| `thm:determinisme_rejeu` | `spec/Spec/C4/EchelleDuSysteme.lean:118` | B11 | PR #114 ouverte | — | — |
| `thm:rejeu_binaire` | `spec/Spec/C4/EchelleDuSysteme.lean:144` | B11 | PR #114 ouverte | `thm:determinisme_rejeu`, `thm:schema_restriction` | — |
| `thm:liberte_initialisation` | `spec/Spec/C4/EchelleDuSysteme.lean:320` | B11 | PR #114 ouverte | `thm:tri_topologique` | — |
| `thm:sync_motifs_jonction` | `spec/Spec/C4/EchelleDuSysteme.lean:469` | B11 | PR #114 ouverte | — | — |
| `thm:surete_ffi` | `spec/Spec/C4/EchelleDuSysteme.lean:548` | B11 | PR #114 ouverte | — | — |
| `thm:revocation_ffi` | `spec/Spec/C4/EchelleDuSysteme.lean:575` | B11 | PR #114 ouverte | — | Exigence d'implémentation hors du seul système de types |
| `thm:temps_mononiveau` | `spec/Spec/C3/GrammaireDesTypes.lean:123` | B10 | PR #111 ouverte | — | — |
| `thm:morphismes_modes` | `spec/Spec/C3/LeSystemeGradue.lean:130` | B10 | PR #111 ouverte | — | — |
| `thm:completude_graduee` | `spec/Spec/C3/LeSystemeGradue.lean:521` | B11 | PR #114 ouverte | — | — |
| `thm:completude_verificateur` | `spec/Spec/C3/LeSystemeGradue.lean:555` | B11 | PR #114 ouverte | — | Exigence d'implémentation, pas théorème établi |
| `thm:boxtimes_addition` | `spec/Spec/C3/ReglesDeTypage.lean:103` | B10 | PR #111 ouverte | — | — |
| `thm:coherence_subsomption` | `spec/Spec/C3/ReglesDeTypage.lean:386` | B11 | PR #114 ouverte | — | — |
| `thm:commutation_monoide` | `spec/Spec/C3/ReglesDeTypage.lean:726` | B11 | PR #114 ouverte | — | — |
| `thm:determinisme_parallele` | `spec/Spec/C3/ReglesDeTypage.lean:1319` | B08 | Fusionné (PR d'audit) | — | — |
| `thm:substitution` | `spec/Spec/C3/ReglesDeTypage.lean:1605` | B11 | PR #114 ouverte | — | — |
| `thm:substitution_simultanee` | `spec/Spec/C3/ReglesDeTypage.lean:1696` | B11 | PR #114 ouverte | `thm:substitution` | — |
| `thm:preservation` | `spec/Spec/C4/SemantiqueOperationnelle.lean:137` | B03 | Fusionné (PR d'audit) | — | — |
| `thm:progres` | `spec/Spec/C4/SemantiqueOperationnelle.lean:195` | B03 | Fusionné (PR d'audit) | — | — |
| `thm:correction_ressource` | `spec/Spec/C4/SemantiqueOperationnelle.lean:290` | B03 | Fusionné (PR d'audit) | — | — |
| `thm:stratification_journal` | `spec/Spec/C4/SemantiqueOperationnelle.lean:393` | B04 | Fusionné (PR d'audit) | — | — |
| `thm:relation_produit` | `spec/Spec/C4/SemantiqueOperationnelle.lean:535` | B04 | Fusionné (PR d'audit) | `thm:troncature_comonade` | — |
| `thm:lemme_fondamental` | `spec/Spec/C4/SemantiqueOperationnelle.lean:561` | B11 | PR #114 ouverte | `thm:substitution`, `thm:substitution_simultanee`, `thm:divulgation_delimitee` | Cycle syntaxique avec divulgation délimitée; cas Declassify absent |
| `thm:commutation_traduction` | `spec/Spec/C4/SemantiqueOperationnelle.lean:715` | B05, B07 | Fusionné (PR d'audit) | `thm:schema_commutation`, `thm:substitution` | — |
| `thm:image_fix` | `spec/Spec/C4/SemantiqueOperationnelle.lean:790` | B05 | Fusionné (PR d'audit) | `thm:terminaison_lfp` | — |
| `thm:isomorphisme_memoire` | `spec/Spec/C4/EchelleDeLActeur.lean:142` | B11 | PR #114 ouverte | — | — |
| `thm:expansion_macro` | `spec/Spec/C5/CeQuUneMacroDeclare.lean:96` | B11 | PR #114 ouverte | `thm:substitution`, `thm:elaboration` | — |
| `thm:deadlock_acyclique` | `spec/Spec/C3/LesContraintesDeValeur.lean:274` | B08 | Fusionné (PR d'audit) | `thm:tri_topologique` | — |
| `thm:homomorphisme_roues` | `spec/Spec/C3/LesContraintesDeValeur.lean:350` | B11 | PR #114 ouverte | — | — |
| `thm:representation_inobservable` | `spec/Spec/C3/LesContraintesDeValeur.lean:384` | B11 | PR #114 ouverte | — | Formule d'injectivité ne formalise pas l'invariance représentationnelle annoncée |
| `thm:interface_jugement` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean:60` | B11 | PR #114 ouverte | — | — |
| `thm:rejet_reproductible` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean:132` | B11 | PR #114 ouverte | — | — |
| `thm:abaissement_grades` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean:463` | B11 | PR #114 ouverte | `thm:schema_preservation` | Conjecture; obligations par passe non acquittées |
| `thm:terminaison_couche_3` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:132` | B11 | PR #114 ouverte | `thm:progression_polarisee` | — |
| `thm:sedimentation` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:216` | B02 | Fusionné (PR d'audit) | — | Résultat de littérature + obligation graduée ouverte |
| `thm:productivite_couche_2` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:294` | B11 | PR #114 ouverte | `thm:progression_polarisee` | L'absorption à ω ne prouve pas à elle seule la productivité |
| `thm:progression_polarisee` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:342` | B11 | PR #114 ouverte | — | — |
| `thm:loi_historique` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:454` | B11 | PR #114 ouverte | — | — |
| `thm:troncature_comonade` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:526` | B11 | PR #114 ouverte | — | — |
| `thm:fenetre_grade` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:576` | B11 | PR #114 ouverte | `thm:troncature_comonade` | Correspondance des trois fenêtres non démontrée |
| `thm:traduction_metalangage` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:151` | B02, B06 | Fusionné (PR d'audit) | — | — |
| `thm:simulation` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:299` | B07 | Fusionné (PR d'audit) | `thm:commutation_traduction`, `thm:fidelite_interprete` | Dépendance argumentative à la fidélité; trace/canal temporel à préciser |
| `thm:fidelite_interprete` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:340` | B07 | Fusionné (PR d'audit) | `thm:traduction_metalangage`, `thm:schema_effacement` | Conditionnelle à Sim; préservation du typage seule insuffisante |
| `thm:stabilisation_pipeline` | `spec/Spec/C6/LeProcessusDeCompilation.lean:155` | B11 | PR #114 ouverte | — | — |
| `thm:cloture_sortage` | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean:187` | B06 | Fusionné (PR d'audit) | — | — |
| `thm:confinement_sortes` | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean:214` | B06 | Fusionné (PR d'audit) | `thm:traduction_metalangage`, `thm:temps_mononiveau` | — |
| `thm:divulgation_delimitee` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean:234` | B11 | PR #114 ouverte | `thm:lemme_fondamental`, `thm:non_interference` | Cycle syntaxique avec lemme fondamental; preuve non conduite |
| `thm:terminaison_lfp` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean:378` | B05 | Fusionné (PR d'audit) | — | — |
| `thm:distributivite_tronquee` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:125` | B09 | Fusionné (PR d'audit) | — | — |
| `thm:coherence_axiome` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:158` | B09 | Fusionné (PR d'audit) | — | — |
| `thm:coherence_usage` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:182` | B09 | Fusionné (PR d'audit) | — | — |
| `thm:action_parallele` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:280` | B11 | PR #114 ouverte | — | — |
| `thm:preservation_type` | `spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean:253` | B11 | PR #114 ouverte | `thm:abaissement_grades` | Bloc composé : réduction vs abaissement MLIR conjectural |

## 3. Graphe des dépendances et risques

### Cycle syntaxique détecté

`thm:lemme_fondamental → thm:divulgation_delimitee → thm:lemme_fondamental`.

Le cycle est bloquant pour toute affirmation selon laquelle les deux preuves sont complètes. Les deux esquisses ne peuvent pas se justifier mutuellement. Options encore ouvertes : (A) prouver le lemme fondamental pour le fragment sans `Declassify`, puis traiter séparément l'extension ; (B) paramétrer le lemme fondamental par une relation/condition de divulgation et prouver le cas `Declassify` ; (C) établir un lemme auxiliaire indépendant de clôture/paramétricité. La décision exige une ratification explicite avant toute modification de source.

### Circularité argumentative sans cycle syntaxique

- `thm:introduction_unique → thm:surete_spatiale` est la seule référence directe. Toutefois, la sûreté suppose H1 tandis que l'introduction prétend établir H1 et laisse l'élimination d'arène à écrire. Il faut un argument indépendant pour H1.
- `thm:simulation` renvoie à `thm:fidelite_interprete` comme au résultat qui utilise l'hypothèse Sim ; le théorème de fidélité dépend à son tour de l'existence d'une simulation, sans référence syntaxique inverse. Il s'agit d'une dette argumentative et non du cycle syntaxique rapporté par l'extracteur. La simulation doit être établie indépendamment, notamment pour l'ordre de trace/canal temporel.

### Dépendances structurantes à traiter ensemble

- **Substitution et relation logique :** `thm:substitution` → `thm:substitution_simultanee` → `thm:lemme_fondamental`; les lois de mise à l'échelle, le transport d'effet et les cas de modalité doivent être distingués.
- **Traduction et fidélité :** `thm:traduction_metalangage` → `thm:raffinement` / `thm:fidelite_interprete`; préservation du typage, simulation de réduction, préservation des traces et adéquation observationnelle sont des résultats distincts.
- **Effets et budget :** `thm:temps_mononiveau`, `thm:boxtimes_addition`, `thm:coherence_axiome`, `thm:coherence_usage`, `thm:action_parallele` et `thm:distributivite_tronquee` exigent une signature explicite des opérations et de leurs domaines.
- **Abaissement et préservation :** `thm:preservation_type` doit être suivi comme bloc composé ; son volet de réduction ne valide pas la conjecture `thm:abaissement_grades`.
- **Représentation :** `thm:isomorphisme_memoire`, `thm:homomorphisme_roues` et `thm:representation_inobservable` portent des engagements d'ABI et d'observabilité distincts ; les tests de l'implémentation ne remplacent pas la formulation de la propriété.

## 4. Décision de préparation à la migration

À ce stade, **aucun bloc n'est certifié prêt pour migration sémantique** par la seule existence d'une note de revue. Le tableau prouve la couverture documentaire, pas la résolution des obligations. Les classifications du registre restent provisoires.

Avant C8.0, il reste à :
1. obtenir la fusion par le mainteneur des PR #111 et #114 après leurs vérifications ;
2. faire ratifier la classification rôle/état de chaque bloc, en particulier les exigences et les blocs composés ;
3. choisir une architecture acyclique pour le lemme fondamental et la divulgation, et établir H1 indépendamment ;
4. corriger par PR distincte la formulation de `thm:representation_inobservable`, après définition de `repr`, `obs` et de l'équivalence représentationnelle voulue ;
5. exécuter à nouveau l'inventaire et le contrôle de dérive sur le `main` actualisé, puis vérifier les liens bibliographiques et les hypothèses locales ;
6. seulement ensuite, planifier une migration contrôlée en préservant labels, références, texte, hypothèses et statut, avec toute correction éditoriale séparée.

**Conclusion :** la couverture de revue source-level peut être considérée complète une fois les lots B10 et B11 fusionnés. La revue sémantique n'est pas close : plusieurs preuves sont incomplètes, un cycle syntaxique et deux circularités argumentatives sont ouverts, et la migration n'est pas encore autorisée par cette matrice.
