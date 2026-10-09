# Inventaire mécanique des énoncés existants — C8.0

> **État : inventaire de référence provisoire, à valider.** Ce relevé décrit la syntaxe héritée ; il ne constitue ni une classification sémantique approuvée, ni une preuve de validité mathématique. Aucun énoncé source n'a été modifié pour produire ce document.

- Référence du relevé : branche `main`, arbre Git `20a228f137f507aac9b3e8c9f2e1776f29fa635a`.
- Périmètre exploratoire : fichiers `spec/Spec/**/*.lean` contenant des directives `::::thm`.
- Méthode : lecture des directives, extraction des arguments littéraux `label`, `status`, `level`, titre et présence des créneaux `:::statement` / `:::proofsketch`.
- Les lignes désignent le début de la directive dans le fichier au commit de référence. Toute modification des sources peut les décaler ; il faudra régénérer le relevé avant migration.
- `status` est conservé comme **champ historique**, pas comme taxonomie cible. `level` est lui aussi conservé tel quel ; il ne doit pas être assimilé au futur `scope`.
- La présence de `:::proofsketch` indique uniquement une esquisse textuelle. Elle ne prouve pas qu'une preuve soit correcte, ni que Lean vérifie l'énoncé.

## 1. Contrôle de couverture

- Énoncés relevés : **69**.
- Fichiers sources recensés : **21**.
- Labels dupliqués dans ce relevé : **0**.
- Créneau `:::proofsketch` : **65 présent**, **4 absent**.

### Répartition par statut historique

| Statut hérité | Nombre |
|---|---:|
| `conjecture` | 2 |
| `definition` | 2 |
| `exigence` | 4 |
| `proposition` | 18 |
| `theoreme` | 43 |
| **Total** | **69** |

### Répartition par niveau historique

| Niveau hérité | Nombre |
|---|---:|
| `compilation` | 2 |
| `langage` | 62 |
| `representation` | 5 |
| **Total** | **69** |

### Répartition par fichier

| Source | Énoncés |
|---|---:|
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 7 |
| `spec/Spec/C4/ModelesDeMemoire.lean` | 2 |
| `spec/Spec/C5/LeTheoremeDElaboration.lean` | 1 |
| `spec/Spec/C2/SystemeDeRaffinement.lean` | 3 |
| `spec/Spec/C5/NotationsSpecialisees.lean` | 4 |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 6 |
| `spec/Spec/C3/GrammaireDesTypes.lean` | 1 |
| `spec/Spec/C3/LeSystemeGradue.lean` | 3 |
| `spec/Spec/C3/ReglesDeTypage.lean` | 6 |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 8 |
| `spec/Spec/C4/EchelleDeLActeur.lean` | 1 |
| `spec/Spec/C5/CeQuUneMacroDeclare.lean` | 1 |
| `spec/Spec/C3/LesContraintesDeValeur.lean` | 3 |
| `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | 3 |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 7 |
| `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | 3 |
| `spec/Spec/C6/LeProcessusDeCompilation.lean` | 1 |
| `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean` | 2 |
| `spec/Spec/C2/AdjonctionsEtEnrichissement.lean` | 2 |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | 4 |
| `spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean` | 1 |
| **Total** | **69** |

## 2. Inventaire détaillé

Le statut et le niveau sont les valeurs explicites présentes dans la directive ; en l'absence d'argument, la valeur par défaut de l'implémentation actuelle est reportée (`theoreme` et `langage`). Le titre est transcrit du créneau `:::title`, avec espaces normalisés.

| Source | Ligne | Label | Statut historique | Niveau historique | Titre | Esquisse |
|---|---:|---|---|---|---|---|
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 35 | `thm:schema_commutation` | theoreme | langage | schéma de commutation | oui |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 63 | `thm:schema_preservation` | theoreme | langage | schéma de préservation par traduction | oui |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 88 | `thm:tri_topologique` | theoreme | langage | tri topologique | oui |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 111 | `thm:schema_restriction` | theoreme | langage | schéma de restriction | oui |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 150 | `thm:schema_reinvocation` | theoreme | langage | schéma de ré-invocation bornée | oui |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 188 | `thm:schema_effacement` | theoreme | langage | schéma d'effacement | oui |
| `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | 227 | `thm:lemme_capacite` | theoreme | langage | lemme de capacité | oui |
| `spec/Spec/C4/ModelesDeMemoire.lean` | 41 | `thm:surete_spatiale` | theoreme | langage | sûreté spatiale par capacités linéaires | oui |
| `spec/Spec/C4/ModelesDeMemoire.lean` | 99 | `thm:introduction_unique` | proposition | langage | loi unique d'introduction des ressources d'écriture | oui |
| `spec/Spec/C5/LeTheoremeDElaboration.lean` | 30 | `thm:elaboration` | definition | langage | élaboration | oui |
| `spec/Spec/C2/SystemeDeRaffinement.lean` | 52 | `thm:raffinement` | theoreme | langage | structure de raffinement | oui |
| `spec/Spec/C2/SystemeDeRaffinement.lean` | 152 | `thm:non_interference` | theoreme | langage | non-interférence graduée, fragment séquentiel | oui |
| `spec/Spec/C2/SystemeDeRaffinement.lean` | 191 | `thm:determinisme_observationnel` | conjecture | langage | déterminisme observationnel | oui |
| `spec/Spec/C5/NotationsSpecialisees.lean` | 126 | `thm:staticite_syntaxe` | theoreme | langage | staticité de la syntaxe | oui |
| `spec/Spec/C5/NotationsSpecialisees.lean` | 217 | `thm:hygiene` | theoreme | langage | hygiène des expansions | oui |
| `spec/Spec/C5/NotationsSpecialisees.lean` | 241 | `thm:hygiene_graduee` | proposition | langage | hygiène graduée des expansions | oui |
| `spec/Spec/C5/NotationsSpecialisees.lean` | 261 | `thm:resucrage` | exigence | langage | préservation de l'α-équivalence de surface | non |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 118 | `thm:determinisme_rejeu` | theoreme | langage | déterminisme logique du rejeu | oui |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 144 | `thm:rejeu_binaire` | proposition | representation | identité binaire du rejeu, sous environnement reproductible | oui |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 320 | `thm:liberte_initialisation` | theoreme | langage | liberté d'initialisation par DAG topologique | oui |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 469 | `thm:sync_motifs_jonction` | theoreme | langage | synchronisation atomique des motifs de jonction | oui |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 548 | `thm:surete_ffi` | theoreme | langage | sûreté FFI par la passerelle de capacité | oui |
| `spec/Spec/C4/EchelleDuSysteme.lean` | 575 | `thm:revocation_ffi` | exigence | representation | révocation à la frontière étrangère | non |
| `spec/Spec/C3/GrammaireDesTypes.lean` | 123 | `thm:temps_mononiveau` | theoreme | langage | le cas mononiveau redonne la forme plate | oui |
| `spec/Spec/C3/LeSystemeGradue.lean` | 130 | `thm:morphismes_modes` | proposition | langage | ordre structurel des modes | oui |
| `spec/Spec/C3/LeSystemeGradue.lean` | 521 | `thm:completude_graduee` | proposition | langage | complétude graduée | oui |
| `spec/Spec/C3/LeSystemeGradue.lean` | 555 | `thm:completude_verificateur` | exigence | compilation | le vérificateur n'émet que des codes de la correspondance | non |
| `spec/Spec/C3/ReglesDeTypage.lean` | 103 | `thm:boxtimes_addition` | theoreme | langage | $`\boxtimes` généralise l'addition ponctuelle | oui |
| `spec/Spec/C3/ReglesDeTypage.lean` | 386 | `thm:coherence_subsomption` | proposition | langage | cohérence de la subsomption | oui |
| `spec/Spec/C3/ReglesDeTypage.lean` | 726 | `thm:commutation_monoide` | theoreme | langage | commutation des deux familles | oui |
| `spec/Spec/C3/ReglesDeTypage.lean` | 1319 | `thm:determinisme_parallele` | theoreme | langage | déterminisme du parallélisme de couche 3 | oui |
| `spec/Spec/C3/ReglesDeTypage.lean` | 1605 | `thm:substitution` | proposition | langage | substitution sur trois niveaux | oui |
| `spec/Spec/C3/ReglesDeTypage.lean` | 1696 | `thm:substitution_simultanee` | theoreme | langage | substitution simultanée — corollaire de la substitution élémentaire | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 137 | `thm:preservation` | theoreme | langage | préservation | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 195 | `thm:progres` | theoreme | langage | progrès | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 290 | `thm:correction_ressource` | theoreme | langage | correction de ressource | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 393 | `thm:stratification_journal` | theoreme | langage | stratification du journal | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 535 | `thm:relation_produit` | proposition | langage | relation logique sur un produit de structures ordonnées | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 561 | `thm:lemme_fondamental` | theoreme | langage | lemme fondamental | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 717 | `thm:commutation_traduction` | theoreme | langage | commutation de la traduction et de la substitution | oui |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 792 | `thm:image_fix` | theoreme | langage | image du point fixe déductif | oui |
| `spec/Spec/C4/EchelleDeLActeur.lean` | 142 | `thm:isomorphisme_memoire` | proposition | representation | correspondances de disposition, transfert zéro-copie | oui |
| `spec/Spec/C5/CeQuUneMacroDeclare.lean` | 96 | `thm:expansion_macro` | theoreme | langage | la règle d'expansion est dérivable | oui |
| `spec/Spec/C3/LesContraintesDeValeur.lean` | 274 | `thm:deadlock_acyclique` | theoreme | langage | absence de deadlock par acyclicité du graphe de sessions | oui |
| `spec/Spec/C3/LesContraintesDeValeur.lean` | 350 | `thm:homomorphisme_roues` | proposition | representation | représentation des singularités de la théorie des roues | oui |
| `spec/Spec/C3/LesContraintesDeValeur.lean` | 384 | `thm:representation_inobservable` | exigence | representation | aucune liberté de représentation n'est observable | non |
| `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | 60 | `thm:interface_jugement` | definition | langage | l'interface d'une unité de compilation est son jugement | oui |
| `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | 132 | `thm:rejet_reproductible` | theoreme | langage | reproductibilité du rejet | oui |
| `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | 463 | `thm:abaissement_grades` | conjecture | compilation | l'abaissement préserve le jugement gradué | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 132 | `thm:terminaison_couche_3` | theoreme | langage | terminaison de la couche 3 — l'instance inductive | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 216 | `thm:sedimentation` | theoreme | langage | bonne définition de la sédimentation | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 294 | `thm:productivite_couche_2` | theoreme | langage | productivité de la couche 2 — l'instance coinductive | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 342 | `thm:progression_polarisee` | theoreme | langage | progression, paramétrée par la couche | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 454 | `thm:loi_historique` | theoreme | langage | loi distributive de l'historique | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 526 | `thm:troncature_comonade` | theoreme | langage | la troncature est un morphisme de comonades | oui |
| `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | 576 | `thm:fenetre_grade` | proposition | langage | une fenêtre est un grade | oui |
| `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | 151 | `thm:traduction_metalangage` | proposition | langage | la traduction préserve le typage | oui |
| `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | 299 | `thm:simulation` | proposition | langage | simulation de la relation de réduction par la traduction | oui |
| `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | 340 | `thm:fidelite_interprete` | proposition | langage | fidélité de l'interpréteur de référence | oui |
| `spec/Spec/C6/LeProcessusDeCompilation.lean` | 155 | `thm:stabilisation_pipeline` | theoreme | langage | stabilisation du pipeline | oui |
| `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean` | 187 | `thm:cloture_sortage` | theoreme | langage | clôture du bon sortage par substitution | oui |
| `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean` | 214 | `thm:confinement_sortes` | theoreme | langage | confinement des canaux distingués | oui |
| `spec/Spec/C2/AdjonctionsEtEnrichissement.lean` | 234 | `thm:divulgation_delimitee` | proposition | langage | divulgation délimitée | oui |
| `spec/Spec/C2/AdjonctionsEtEnrichissement.lean` | 381 | `thm:terminaison_lfp` | theoreme | langage | terminaison du point fixe déductif | oui |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | 125 | `thm:distributivite_tronquee` | theoreme | langage | distributivité du produit sur la soustraction tronquée | oui |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | 158 | `thm:coherence_axiome` | proposition | langage | condition de compatibilité de l'action graduée | oui |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | 182 | `thm:coherence_usage` | proposition | langage | cohérence de l'action d'usage | oui |
| `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | 280 | `thm:action_parallele` | proposition | langage | compatibilité de l'itération et de la mise en parallèle | oui |
| `spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean` | 253 | `thm:preservation_type` | theoreme | langage | préservation du type | oui |

## 3. Classification sémantique encore requise

Les champs suivants **ne peuvent pas être déduits de façon fiable** du seul ancien `status` ou du titre. Ils restent à examiner occurrence par occurrence à partir du contenu intégral de l'énoncé et de ses dépendances :

- **Nature de l'objet** : résultat K7PL, définition, exigence, axiome/postulat, hypothèse locale, résultat de littérature, exemple/contre-exemple ou autre objet documentaire.
- **Rôle logique/expositif** : théorème, lemme, corollaire, proposition, conjecture, ou rôle différent selon l'ontologie ratifiée.
- **État épistémique** : proposé, en revue, étayé, établi, réfuté ou retiré. Les valeurs héritées ne sont pas automatiquement équivalentes à ces états.
- **Portée (`scope`)** : à déterminer séparément du `level` hérité.
- **Type d'appui** : argument textuel, esquisse de preuve, preuve rédigée complète, preuve Lean vérifiée, référence externe, ou absence d'appui explicite.
- **Hypothèses et dépendances** : prémisses locales, autres énoncés invoqués, références bibliographiques et éventuelle accroche vers `src/`.

Aucune de ces dimensions n'est remplie par inférence dans cet inventaire mécanique. La prochaine étape est une annotation sémantique contrôlée et vérifiée, puis une comparaison avec les compteurs, contrôles et rendus actuels. Le document ne doit pas être utilisé comme autorisation de migrer les énoncés.

## 4. Consommateurs à préserver

Le contrôle des dépendances a identifié au minimum les points suivants :

- `tools/SpecExt/Theorem.lean` : type interne `ThmInfo`, valeurs par défaut, rendu HTML/LaTeX, slot `proofsketch` et compteur partagé `theoreme`.
- `scripts/manuscript_metrics.py` : extraction textuelle des directives et calculs par statut/niveau, y compris la métrique des énoncés « ouverts ».
- `scripts/controles/notation.py` : liste fermée des statuts/niveaux, exigence d'esquisse pour certains objets, interdiction d'esquisse sur les exigences et propagation des références d'énoncés ouverts.
- `scripts/controles/structure.py` : préfixe `thm:`, unicité des labels et vérification des références.
- `scripts/controles/couverture.py` : couverture des énoncés par accroches vers les déclarations Lean et publication des métriques de couverture.

Cette liste est le minimum confirmé par inspection ; les références supplémentaires doivent être recherchées avant C8.2. Les règles existantes ne doivent pas être supprimées avant que leurs équivalents cibles soient testés.

## 5. Limites et contrôles de la présente étape

Ce document a été établi par rapprochement des résultats de recherche GitHub et de la lecture des fichiers sources listés. Il n'a pas encore été régénéré par un script exécuté dans l'environnement du dépôt. Avant de considérer C8.0 clos, il faut :

1. automatiser la génération du relevé depuis l'arbre de travail ;
2. vérifier que les nombres, labels, statuts, niveaux, lignes et slots concordent avec les sources ;
3. vérifier les chemins d'inclusion et rechercher les formes d'énoncés hors de `spec/Spec/**/*.lean` ;
4. faire valider la classification sémantique sans modifier les énoncés ;
5. consigner les exceptions et les dépendances non résolues.
