# Correspondance des énoncés numérotés et de leurs étiquettes

Vue **produite** par `scripts/suivi.py enonces` à partir de `spec/` (le numéro est celui du compteur global de la spécification, dans l'ordre du document). Ne pas éditer ce fichier.

* **N° relu** : le numéro imprimé dans le PDF du 9 septembre 2026 que les six relecteurs ont lu, et que citent encore les fiches (« Th. 36 »). Un tiret marque un énoncé écrit depuis.
* **Renvois** : nombre de `{num}` qui pointent vers l'énoncé ; zéro ne veut pas dire inutile, seulement jamais cité.

| N° | N° relu | Étiquette | Statut | Niveau | Titre | Lieu | Renvois |
|--:|--:|---|---|---|---|---|--:|
| 1 | — | `thm:distributivite_tronquee` | theoreme | langage | distributivité du produit sur la soustraction tronquée | §2.2 | 1 |
| 2 | 33 | `thm:coherence_axiome` | theoreme | langage | compatibilité de l'action graduée | §2.2 | 11 |
| 3 | — | `thm:action_parallele` | theoreme | langage | l'action graduée traverse la mise en parallèle | §2.2 | 0 |
| 4 | 1 | `thm:terminaison_couche_3` | theoreme | langage | terminaison de la couche 3 — l'instance inductive | §2.3 | 1 |
| 5 | 2 | `thm:sedimentation` | theoreme | langage | bonne définition de la sédimentation | §2.3 | 1 |
| 6 | 3 | `thm:productivite_couche_2` | theoreme | langage | productivité de la couche 2 — l'instance coinductive | §2.3 | 1 |
| 7 | 4 | `thm:progression_polarisee` | theoreme | langage | progression, paramétrée par la couche | §2.3 | 4 |
| 8 | 5 | `thm:loi_historique` | theoreme | langage | loi distributive de l'historique | §2.3 | 0 |
| 9 | — | `thm:troncature_comonade` | proposition | langage | la troncature est un morphisme de comonades | §2.3 | 0 |
| 10 | 6 | `thm:divulgation_delimitee` | proposition | langage | divulgation délimitée | §2.4 | 4 |
| 11 | 7 | `thm:terminaison_lfp` | theoreme | langage | terminaison du point fixe déductif | §2.4 | 6 |
| 12 | 8 | `thm:raffinement` | theoreme | langage | structure de raffinement | §2.5 | 3 |
| 13 | 9 | `thm:non_interference` | theoreme | langage | non-interférence graduée, fragment séquentiel | §2.5 | 4 |
| 14 | — | `thm:determinisme_observationnel` | conjecture | langage | déterminisme observationnel | §2.5 | 0 |
| 15 | — | `thm:schema_commutation` | theoreme | langage | schéma de commutation | §2.6 | 4 |
| 16 | — | `thm:schema_preservation` | theoreme | langage | schéma de préservation par traduction | §2.6 | 2 |
| 17 | — | `thm:tri_topologique` | theoreme | langage | tri topologique | §2.6 | 2 |
| 18 | — | `thm:schema_restriction` | theoreme | langage | schéma de restriction | §2.6 | 2 |
| 19 | — | `thm:schema_reinvocation` | theoreme | langage | schéma de ré-invocation bornée | §2.6 | 0 |
| 20 | — | `thm:schema_effacement` | theoreme | langage | schéma d'effacement | §2.6 | 2 |
| 21 | — | `thm:lemme_capacite` | theoreme | langage | lemme de capacité | §2.6 | 1 |
| 22 | 10 | `thm:morphismes_modes` | theoreme | langage | la chaîne modale est une chaîne de morphismes de modes | §3.1 | 0 |
| 23 | 11 | `thm:completude_graduee` | proposition | langage | complétude graduée | §3.1 | 0 |
| 24 | — | `thm:completude_verificateur` | exigence | compilation | le vérificateur n'émet que des codes de la correspondance | §3.1 | 0 |
| 25 | 12 | `thm:deadlock_acyclique` | theoreme | langage | absence de deadlock par acyclicité du graphe de sessions | §3.2 | 0 |
| 26 | 13 | `thm:homomorphisme_roues` | proposition | representation | représentation des singularités de la théorie des roues | §3.2 | 1 |
| 27 | — | `thm:representation_inobservable` | exigence | representation | aucune liberté de représentation n'est observable | §3.2 | 0 |
| 28 | 14 | `thm:preservation_type` | theoreme | langage | préservation du type | §3.3 | 0 |
| 29 | 29 | `thm:temps_mononiveau` | theoreme | langage | le cas mononiveau redonne la forme plate | §3.4 | 1 |
| 30 | 30 | `thm:boxtimes_addition` | theoreme | langage | $`\boxtimes` généralise l'addition ponctuelle | §3.6 | 0 |
| 31 | 31 | `thm:coherence_subsomption` | proposition | langage | cohérence de la subsomption | §3.6 | 3 |
| 32 | 32 | `thm:commutation_monoide` | theoreme | langage | commutation des deux familles | §3.6 | 0 |
| 33 | — | `thm:determinisme_parallele` | theoreme | langage | déterminisme du parallélisme de couche 3 | §3.6 | 0 |
| 34 | 34 | `thm:substitution` | theoreme | langage | substitution sur trois niveaux | §3.6 | 6 |
| 35 | 35 | `thm:substitution_simultanee` | theoreme | langage | substitution simultanée — corollaire de la substitution élémentaire | §3.6 | 1 |
| 36 | 15 | `thm:isomorphisme_memoire` | proposition | representation | correspondances de disposition, transfert zéro-copie | §4.3 | 6 |
| 37 | 16 | `thm:surete_spatiale` | theoreme | langage | sûreté spatiale par capacités linéaires | §4.4 | 1 |
| 38 | — | `thm:introduction_unique` | proposition | langage | loi unique d'introduction des ressources d'écriture | §4.4 | 0 |
| 39 | 17 | `thm:determinisme_rejeu` | theoreme | langage | déterminisme logique du rejeu | §4.5 | 1 |
| 40 | — | `thm:rejeu_binaire` | proposition | representation | identité binaire du rejeu, sous environnement reproductible | §4.5 | 1 |
| 41 | 18 | `thm:liberte_initialisation` | theoreme | langage | liberté d'initialisation par DAG topologique | §4.5 | 0 |
| 42 | 19 | `thm:sync_motifs_jonction` | theoreme | langage | synchronisation atomique des motifs de jonction | §4.5 | 1 |
| 43 | 20 | `thm:surete_ffi` | theoreme | langage | sûreté FFI par la passerelle de capacité | §4.5 | 0 |
| 44 | — | `thm:revocation_ffi` | exigence | representation | révocation à la frontière étrangère | §4.5 | 0 |
| 45 | 21 | `thm:traduction_metalangage` | proposition | langage | la traduction préserve le typage | §4.6 | 11 |
| 46 | — | `thm:simulation` | proposition | langage | simulation de la relation de réduction par la traduction | §4.6 | 1 |
| 47 | 22 | `thm:fidelite_interprete` | proposition | langage | fidélité de l'interpréteur de référence | §4.6 | 3 |
| 48 | 36 | `thm:preservation` | theoreme | langage | préservation | §4.7 | 3 |
| 49 | 37 | `thm:progres` | theoreme | langage | progrès | §4.7 | 0 |
| 50 | 38 | `thm:correction_ressource` | theoreme | langage | correction de ressource | §4.7 | 0 |
| 51 | 39 | `thm:stratification_journal` | theoreme | langage | stratification du journal | §4.7 | 0 |
| 52 | — | `thm:relation_produit` | proposition | langage | relation logique sur un produit de structures ordonnées | §4.7 | 0 |
| 53 | 40 | `thm:lemme_fondamental` | theoreme | langage | lemme fondamental | §4.7 | 4 |
| 54 | 41 | `thm:commutation_traduction` | theoreme | langage | commutation de la traduction et de la substitution | §4.7 | 0 |
| 55 | 42 | `thm:image_fix` | theoreme | langage | image du point fixe déductif | §4.7 | 0 |
| 56 | 43 | `thm:cloture_sortage` | theoreme | langage | clôture du bon sortage par substitution | §4.8 | 0 |
| 57 | 44 | `thm:confinement_sortes` | theoreme | langage | confinement des canaux distingués | §4.8 | 2 |
| 58 | 23 | `thm:staticite_syntaxe` | theoreme | langage | staticité de la syntaxe | §5.2 | 1 |
| 59 | 24 | `thm:hygiene` | theoreme | langage | hygiène des expansions | §5.2 | 1 |
| 60 | — | `thm:hygiene_graduee` | proposition | langage | hygiène graduée des expansions | §5.2 | 0 |
| 61 | — | `thm:resucrage` | exigence | langage | préservation de l'α-équivalence de surface | §5.2 | 0 |
| 62 | — | `thm:elaboration` | definition | langage | élaboration | §5.3 | 2 |
| 63 | 25 | `thm:expansion_macro` | theoreme | langage | la règle d'expansion est dérivable | §5.4 | 3 |
| 64 | — | `thm:stabilisation_pipeline` | theoreme | langage | stabilisation du pipeline | §6.1 | 0 |
| 65 | 26 | `thm:interface_jugement` | definition | langage | l'interface d'une unité de compilation est son jugement | §6.2 | 0 |
| 66 | 27 | `thm:rejet_reproductible` | theoreme | langage | reproductibilité du rejet | §6.2 | 3 |
| 67 | 28 | `thm:abaissement_grades` | conjecture | compilation | l'abaissement préserve le jugement gradué | §6.2 | 3 |
