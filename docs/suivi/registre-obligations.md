# Registre des obligations

> Instantané du 1er octobre 2026, produit par `outils/registre.py` du manuscrit Org (voir `archives/outillage-org/`). Les lieux cités sont les anciens fichiers `.org` ; les énoncés ouverts à jour sont le bloc « ouverts » du [tableau de bord](TABLEAU-DE-BORD.md), les hypothèses de module sont dans [`hypotheses-de-module.md`](hypotheses-de-module.md), et le reste à faire dans [`RESTE-A-FAIRE.md`](RESTE-A-FAIRE.md).

## Ce qui reste ouvert

Les énoncés dont le statut n'est pas acquis, et par quelle route ils se lèveront. Un énoncé qui change de statut change ici sans que personne n'ait à y penser.

| O | Étiquette | Statut | Niveau | Route | Dont dépendent |
|----|----|----|----|----|----|
| O-01 | `thm:abaissement_grades` | conjecture | compilation | démonstration | aucun |
| O-02 | `thm:coherence_subsomption` | proposition | langage | démonstration | aucun |
| O-03 | `thm:completude_graduee` | proposition | langage | démonstration | aucun |
| O-04 | `thm:determinisme_observationnel` | conjecture | langage | démonstration | aucun |
| O-05 | `thm:divulgation_delimitee` | proposition | langage | démonstration | 1 énoncé(s) |
| O-06 | `thm:homomorphisme_roues` | proposition | representation | démonstration | aucun |
| O-07 | `thm:isomorphisme_memoire` | proposition | representation | démonstration | aucun |
| O-08 | `thm:rejeu_binaire` | proposition | representation | démonstration | aucun |
| O-09 | `thm:revocation_ffi` | exigence | representation | mesure | aucun |

## L'ensemble des énoncés

| Étiquette | Statut | Niveau | Cite | Cité par | Lieu |
|----|----|----|----|----|----|
| `thm:abaissement_grades` | conjecture | compilation | 1 | 0 | c6-compilation.org |
| `thm:action_parallele` | theoreme | langage | 0 | 0 | c2-fondements.org |
| `thm:boxtimes_addition` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:cloture_sortage` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:coherence_axiome` | theoreme | langage | 1 | 5 | c2-fondements.org |
| `thm:coherence_subsomption` | proposition | langage | 0 | 0 | K7_Semantique.org |
| `thm:commutation_monoide` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:commutation_traduction` | theoreme | langage | 2 | 0 | K7_Semantique.org |
| `thm:completude_graduee` | proposition | langage | 0 | 0 | c3-types.org |
| `thm:confinement_sortes` | theoreme | langage | 2 | 0 | K7_Semantique.org |
| `thm:correction_ressource` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:deadlock_acyclique` | theoreme | langage | 1 | 0 | c3-types.org |
| `thm:determinisme_observationnel` | conjecture | langage | 0 | 0 | c2-fondements.org |
| `thm:determinisme_parallele` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:determinisme_rejeu` | theoreme | langage | 0 | 1 | c4-automates.org |
| `thm:distributivite_tronquee` | theoreme | langage | 0 | 1 | c2-fondements.org |
| `thm:divulgation_delimitee` | proposition | langage | 0 | 1 | c2-fondements.org |
| `thm:elaboration` | definition | langage | 2 | 1 | c5-syntaxe.org |
| `thm:expansion_macro` | theoreme | langage | 3 | 0 | c5-syntaxe.org |
| `thm:fidelite_interprete` | theoreme | langage | 2 | 0 | c4-automates.org |
| `thm:homomorphisme_roues` | proposition | representation | 0 | 0 | c3-types.org |
| `thm:hygiene` | theoreme | langage | 0 | 0 | c5-syntaxe.org |
| `thm:image_fix` | theoreme | langage | 1 | 0 | K7_Semantique.org |
| `thm:interface_jugement` | definition | langage | 0 | 0 | c6-compilation.org |
| `thm:isomorphisme_memoire` | proposition | representation | 0 | 0 | c4-automates.org |
| `thm:lemme_capacite` | theoreme | langage | 0 | 1 | c2-fondements.org |
| `thm:lemme_fondamental` | theoreme | langage | 4 | 0 | K7_Semantique.org |
| `thm:liberte_initialisation` | theoreme | langage | 1 | 0 | c4-automates.org |
| `thm:loi_historique` | theoreme | langage | 0 | 0 | c2-fondements.org |
| `thm:morphismes_modes` | theoreme | langage | 0 | 0 | c3-types.org |
| `thm:non_interference` | theoreme | langage | 0 | 0 | c2-fondements.org |
| `thm:preservation` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:preservation_type` | theoreme | langage | 0 | 0 | c3-types.org |
| `thm:productivite_couche_2` | theoreme | langage | 1 | 0 | c2-fondements.org |
| `thm:progres` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:progression_polarisee` | theoreme | langage | 0 | 2 | c2-fondements.org |
| `thm:raffinement` | theoreme | langage | 1 | 1 | c2-fondements.org |
| `thm:rejet_reproductible` | theoreme | langage | 0 | 0 | c6-compilation.org |
| `thm:rejeu_binaire` | proposition | representation | 2 | 0 | c4-automates.org |
| `thm:revocation_ffi` | exigence | representation | 0 | 0 | c4-automates.org |
| `thm:schema_commutation` | theoreme | langage | 0 | 3 | c2-fondements.org |
| `thm:schema_effacement` | theoreme | langage | 3 | 1 | c2-fondements.org |
| `thm:schema_preservation` | theoreme | langage | 0 | 2 | c2-fondements.org |
| `thm:schema_reinvocation` | theoreme | langage | 1 | 0 | c2-fondements.org |
| `thm:schema_restriction` | theoreme | langage | 0 | 1 | c2-fondements.org |
| `thm:sedimentation` | theoreme | langage | 0 | 0 | c2-fondements.org |
| `thm:stabilisation_pipeline` | theoreme | langage | 0 | 0 | c6-compilation.org |
| `thm:staticite_syntaxe` | theoreme | langage | 0 | 0 | c5-syntaxe.org |
| `thm:stratification_journal` | theoreme | langage | 0 | 0 | K7_Semantique.org |
| `thm:substitution` | theoreme | langage | 1 | 4 | K7_Semantique.org |
| `thm:substitution_simultanee` | theoreme | langage | 1 | 1 | K7_Semantique.org |
| `thm:surete_ffi` | theoreme | langage | 0 | 0 | c4-automates.org |
| `thm:surete_spatiale` | theoreme | langage | 1 | 0 | c4-automates.org |
| `thm:sync_motifs_jonction` | theoreme | langage | 0 | 0 | c4-automates.org |
| `thm:temps_mononiveau` | theoreme | langage | 0 | 1 | K7_Semantique.org |
| `thm:terminaison_couche_3` | theoreme | langage | 1 | 0 | c2-fondements.org |
| `thm:terminaison_lfp` | theoreme | langage | 0 | 1 | c2-fondements.org |
| `thm:traduction_metalangage` | theoreme | langage | 0 | 3 | c4-automates.org |
| `thm:tri_topologique` | theoreme | langage | 0 | 2 | c2-fondements.org |

## Ce qui repose sur du non acquis

Les énoncés qui citent au moins un énoncé ouvert. Aucun n'est faux ; chacun hérite du statut le plus faible de ce qu'il invoque.

- `thm:lemme_fondamental` s'appuie sur `thm:divulgation_delimitee`

> 59 énoncés, dont 9 ouverts. 1 énoncé(s) reposent sur un énoncé ouvert.
