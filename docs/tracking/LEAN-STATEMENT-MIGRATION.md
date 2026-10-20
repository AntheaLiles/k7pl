<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Registre de migration contrôlée des énoncés — C8.4

**État :** le run historique #944 sur le SHA `f6624d36e875e053384c9d276a283732e3782e40` a réussi pour cette révision uniquement ; il ne certifie pas les têtes ultérieures de la PR #139, fusionnée le 11 octobre 2026 (`e9b5d2b`). Le registre actuel contient 77 objets. Les contrôles en place couvrent les 69 labels historiques, exactement les huit objets complémentaires déclarés (cinq issus de C8.4, trois de la scission de `thm:raffinement` du 12 octobre 2026), la dérive source-registre, les références directes et la conservation des niveaux pré-migration. La génération de la vue de correspondance est vérifiée par la CI ; un résultat de CI ne vaut que pour le SHA sur lequel il a été obtenu. La traçabilité bibliographique et l’attache sémantique des hypothèses restent ouvertes au titre de C8.6/C8.7.

Ce registre relie les 69 labels ratifiés aux directives spécialisées et documente les cinq objets complémentaires créés par la séparation des six blocs composites. Les labels historiques des revendications principales sont conservés afin de préserver les références existantes. Les cinq labels ajoutés sont nouveaux ; aucun résultat n’a été promu à `established`.

La migration conserve les textes mathématiques, les labels historiques, les références, les hypothèses, les niveaux historiques et les statuts épistémiques ratifiés, sauf pour les six séparations explicitement recensées ci-dessous. Les textes mathématiques et hypothèses sont déplacés seulement lorsqu’ils doivent être rattachés à l’objet séparé ; aucune prose scientifique indépendante n’est supprimée. Les obligations ouvertes demeurent ouvertes. Les corrections éditoriales indépendantes et la réduction de prose sont différées. Le contrôleur de cycles syntaxiques émet des alertes à examiner, sans conclure automatiquement à une circularité scientifique.

## Objets composites séparés

- `thm:elaboration` : définition de `Elab` dans `def:elaboration`, préservation sémantique sous le label historique `thm:elaboration`.
- `thm:interface_jugement` : définition sous le label historique ; clôture locale dans `thm:interface_jugement_cloture`.
- `thm:schema_reinvocation` : résultat sous le label historique ; compatibilité/associativité ouverte dans `req:schema_reinvocation_compatibility`.
- `thm:homomorphisme_roues` : clauses sémantiques sous le label historique ; obligation de réalisation dans `req:homomorphisme_roues_realisation`.
- `thm:sedimentation` : résultat documentaire non gradué sous le label historique ; exigence graduée ouverte dans `req:sedimentation_graduee`.
- `thm:raffinement` (décision de l'autrice du 12 octobre 2026, option a) : construction du système de raffinement sous le label historique ; ses trois lectures sont les corollaires `thm:raffinement_effacement`, `thm:raffinement_non_interference` et `thm:raffinement_precision`, chacun avec ses prémisses. Le texte des lectures et de l'esquisse est déplacé sans réécriture ; les prémisses ajoutées reprennent celles que le texte ou la revue sémantique C8 nommaient.
- `thm:preservation_type` : préservation par réduction sous le label historique ; la conjecture `thm:abaissement_grades` reste un objet distinct existant. Le passage sur MLIR a été déplacé hors de l’énoncé de préservation, sans promouvoir la conjecture.

## Numérotation et références

La migration conserve les 69 labels historiques et les références `{num}`. Le rendu spécialisé utilise les compteurs par rôle/type prévus par l’implémentation commune ; la numérotation affichée peut donc différer de l’ancien compteur global. Ce changement est intentionnel et ne change pas les cibles des références nommées. La vue [correspondance des énoncés](correspondance-enonces.md) est générée depuis `spec/` par `scripts/suivi.py enonces`; la CI exécute aussi `scripts/suivi.py all` et vérifie l’absence de dérive générée. Elle distingue le numéro historique du PDF relu du numéro ordinal d’inventaire, qui n’est pas présenté comme le numéro rendu. La build HTML/TeX/PDF confirme l’expansion/rendu du corpus ; la vérification humaine des compteurs effectivement affichés et de l’interprétation des références nommées reste requise.

## Règles de classification ratifiées (C8.0)

Cette section reprend sans réécriture les règles et les décisions transversales du registre de ratification des classifications (`docs/tracking/LEAN-STATEMENT-CLASSIFICATION-RATIFICATION.md`, supprimé après intégration ; [dernière version](https://github.com/AntheaLiles/k7pl/blob/6eb9f86b24527a0de982012233246788c2fc56d4/docs/tracking/LEAN-STATEMENT-CLASSIFICATION-RATIFICATION.md)). Le détail bloc par bloc de ce registre est porté par les colonnes de la table « Classification courante » ci-dessous, qui fait désormais référence ; les changements postérieurs (séparations C8.4, décisions de l'autrice du 12 octobre 2026) y sont signalés ligne à ligne.

**Décision ratifiée :** les classifications ci-dessous ratifient la nature documentaire, le rôle logique visé, l’état épistémique actuel, la portée et le type d’appui visible pour les 69 labels de la base examinée. Cette ratification est une décision de classification, **pas une validation des résultats mathématiques** et pas une déclaration de preuve Lean.

### Règles appliquées

- **Rôle logique** : `theorem` pour un résultat majeur visé ; `lemma` lorsqu’il sert principalement de dépendance ; `corollary` pour une conséquence directement dérivée ; `proposition` pour un autre résultat ; `conjecture` pour une revendication explicitement non établie. Le rôle ne détermine pas la vérité ni le statut épistémique.
- **État épistémique** : `under-review` lorsque la revendication reste à vérifier ; `supported` seulement lorsqu’un argument mathématique visible est suffisant au niveau de la revendication générale sans prétendre à une vérification Lean ; `proposed` pour une conjecture ou une revendication explicitement non démontrée. Aucun résultat n’est classé `established`, `refuted` ou `withdrawn` dans cette ratification.
- **Définitions et exigences** : pas de rôle logique ni d’état de vérité applicable à l’objet en tant que tel. Toute propriété de correction ou de clôture qui accompagne une définition est classée séparément.
- **Résultats de littérature** : l’attribution documentaire externe est séparée de toute revendication propre à K7PL. Une citation n’établit pas automatiquement un résultat K7PL.
- **Appui** : une esquisse textuelle n’est pas une preuve Lean. Une obligation manquante demeure une obligation, même si le rôle et la portée sont ratifiés.
- **Portée** : elle est volontairement étroite et décrit ce que l’énoncé revendique, avec ses hypothèses. Elle ne masque pas les obligations de preuve listées dans les notes d’audit.

### Décisions transversales ratifiées

1. **Les 69 blocs ont une classification documentaire décidée.** La décision porte sur les objets, leurs rôles, leurs états actuels et leurs portées. Elle ne transforme pas les esquisses en preuves.
2. **Aucune promotion à `established`.** Le seul bloc classé `supported` est `thm:tri_topologique`, parce que son argument inductif standard couvre le résultat de graphe fini annoncé. Cela n’affirme pas l’existence d’une preuve Lean ni ne valide les usages qui en dépendent.
3. **Objets composés à scinder dans la future migration :**
   - `thm:elaboration` : définition d’élaboration et propriété de préservation du sens ;
   - `thm:interface_jugement` : définition d’interface et clôture locale des formes énumérées ;
   - `thm:schema_reinvocation` : identité de ré-invocation et obligation de compatibilité contexte/effet ;
   - `thm:homomorphisme_roues` : clauses sémantiques (encodage et sélection) et exigence d’implémentation arithmétique ;
   - `thm:sedimentation` : résultat non gradué de littérature et extension graduée ouverte ;
   - `thm:preservation_type` : préservation par réduction et conjecture d’abaissement MLIR.
4. **Dépendances argumentatives non résolues :** H1 entre `thm:introduction_unique` et `thm:surete_spatiale`, la preuve de `thm:divulgation_delimitee` et le cas `Declassify`, la simulation de `thm:simulation`, les obligations de fidélité de `thm:fidelite_interprete`, et les signatures/relations encore incomplètes identifiées dans les lots B01–B11.
5. **Aucune migration source n’est autorisée par ce document seul.** La migration devra préserver texte, labels, références, hypothèses et états ; les scissions sémantiques des objets composés nécessitent une PR distincte avec traçabilité explicite et validation de build.

État au 13 octobre 2026 : les six scissions du point 3 sont faites (C8.4, voir « Objets composites séparés ») ; la scission de `thm:raffinement` s'y ajoute (décision du 12 octobre 2026).

### Suite de clôture C8 (telle que ratifiée)

- Ratification des classifications : **terminée** pour les 69 blocs, avec les six scissions conceptuelles explicitement enregistrées.
- Résolution des obligations mathématiques et argumentatives : **ouverte**.
- Implémentation de l’ontologie, validation structurelle/consistance par CI, inventaire régénéré et migration contrôlée : **ouvert**.
- Clôture C8 : interdite tant que les critères d’acceptation de la migration et de traçabilité ne sont pas satisfaits.

## Provenance et obligations restantes

La provenance bibliographique du résultat non gradué de sédimentation n’est pas encore reliée à un identifiant bibliographique résolu. Le champ `source` le marque explicitement comme non résolu ; le point 4 (traçabilité et rendus) doit établir la référence exacte. Les contrôles structurels n’établissent ni la vérité mathématique des énoncés ni l’adéquation sémantique de leurs hypothèses.

Nombre de lignes dans ce registre : **77** (69 labels historiques ratifiés + 5 objets complémentaires C8.4 + 3 corollaires issus de la scission de `thm:raffinement`).

### Obligations de clôture C8.0

Reprises de la matrice de couverture de la revue sémantique, de la revue des dépendances à risque et des registres de classification initiaux, supprimés après intégration (dernières versions : [matrice](https://github.com/AntheaLiles/k7pl/blob/0da924a3a03846e1ede4d601a14dcf79cee57b9b/docs/tracking/LEAN-SEMANTIC-AUDIT-COVERAGE-MATRIX.md), [revue des dépendances](https://github.com/AntheaLiles/k7pl/blob/5629e95130a15b66eaf753571a68e9618c13f9e5/docs/tracking/LEAN-DEPENDENCY-SEMANTIC-REVIEW.md), [registre initial](https://github.com/AntheaLiles/k7pl/blob/2a3d0041c92a949c198de5ce60ca4f36a23ab9b3/docs/tracking/LEAN-STATEMENT-CLASSIFICATION-REGISTER.md), [notes de tri](https://github.com/AntheaLiles/k7pl/blob/072292a222d3e61627769ddc0dd3294a9ac83cc0/docs/tracking/LEAN-STATEMENT-CLASSIFICATION-REVIEW.md)). La couverture documentaire des 69 labels historiques par les lots B01–B11 est complète ; elle ne vaut pas résolution des obligations. **C8.0 n'est pas clos.**

1. **H1 (sûreté spatiale).** La référence directe est unidirectionnelle (`thm:introduction_unique → thm:surete_spatiale`) : il s'agit d'une circularité argumentative potentielle, non d'un cycle syntaxique. L'origine de H1 est à établir sans justification circulaire ; trois voies sont ouvertes et aucune n'est ratifiée (voir [DECISIONS](DECISIONS.md)). H2 et H3 restent des prémisses distinctes. Détail : [audit C-08](../migration/L1-C08-MEMORY-SAFETY-AUDIT-2026-10-11.md).
2. **Divulgation délimitée.** Le cycle syntaxique `thm:lemme_fondamental ↔ thm:divulgation_delimitee` a été supprimé par restriction de portée (#117), non par preuve. Restent la relation de libération, la clôture des échappatoires, le traitement des valeurs substituées et le cas `Declassify`, ainsi que la vérification que les autres usages du lemme fondamental n'exigent pas ce cas.
3. **Représentation.** Pour `thm:representation_inobservable` : relation de représentation admissible et signatures de `repr` et `obs` (#116 a fixé la forme par invariance).
4. **Simulation et fidélité.** `thm:fidelite_interprete` dépend de l'existence d'une simulation sans référence syntaxique inverse : dette argumentative, à lever en établissant `thm:simulation` indépendamment.
5. **Nature des arêtes de dépendance.** L'extracteur ne relève que les références directes `{num "thm:…"}`. Chaque arête reste à classer : prémisse de preuve, hypothèse énoncée, résultat dérivé, obligation ouverte, citation documentaire ou mention contextuelle. Les alertes de cycle sont des diagnostics à examiner, non des preuves de circularité.
6. **Traçabilité.** Références bibliographiques et attache sémantique des hypothèses locales : ouvertes au titre de C8.6/C8.7.

Dépendances structurantes à traiter ensemble : substitution → substitution simultanée → lemme fondamental ; traduction vers le métalangage → raffinement et fidélité (préservation du typage, simulation, préservation des traces et adéquation observationnelle sont des résultats distincts) ; effets et budget (`thm:temps_mononiveau`, `thm:boxtimes_addition`, `thm:coherence_axiome`, `thm:coherence_usage`, `thm:action_parallele`, `thm:distributivite_tronquee`), qui demandent une signature explicite des opérations et de leurs domaines ; préservation du type et conjecture d'abaissement, suivies séparément ; engagements de représentation (`thm:isomorphisme_memoire`, `thm:homomorphisme_roues`, `thm:representation_inobservable`), distincts entre eux.

## Feuille de route C8 et porte de sortie

Reprise du plan des commandes d'énoncés (`LEAN-STATEMENT-COMMANDS-PLAN.md`, supprimé après intégration ; [dernière version](https://github.com/AntheaLiles/k7pl/blob/9696c27219f13ffd6b5e88bcd0f88f83c2f7b564/docs/tracking/LEAN-STATEMENT-COMMANDS-PLAN.md)). Les sections de motivation de ce plan (§ 1 à 4, 6, 7 et 9 : problème épistémique, principe de conception, ontologie préliminaire, réduction de prose, séquence, contrôles antérieurs, livrables) restent consultables dans cette dernière version. Ses décisions ratifiées (§ 10) sont dans [DECISIONS](DECISIONS.md), section « Décision d'autrice — taxonomie des énoncés C8 (9 octobre 2026) ». La « Suite de clôture C8 » ci-dessus reproduit l'état ratifié ; l'état courant est dans le tableau suivant.

| Étape | Objet | État au 13 octobre 2026 | Trace |
|---|---|---|---|
| C8.0 — inventaire | inventaire et classification de chaque bloc | classification des 69 blocs ratifiée ; **non clos** : « Obligations de clôture C8.0 » ci-dessus | ce registre ; instantané en annexe |
| C8.1 — ontologie | taxonomie ratifiée | **fait** (décisions du 9 octobre 2026) | [DECISIONS](DECISIONS.md) |
| C8.2 — extension | représentation partagée et directives spécialisées | **fait** : PR #134 fusionnée le 11 octobre 2026 (`f5a7ade`) ; CI #1024 verte sur sa tête exacte `0a2171c` | `tools/SpecExt/Theorem.lean` ; contrat dans `.claude/skills/writing-rules.md` |
| C8.3 — contrôles | contrôles structurels bloquants | **en place** depuis #134 ; voir « Contrôles mécaniques du registre ». La couverture de chacune des règles listées au plan n'a pas été réauditée lors de cette intégration | `scripts/controles/` |
| C8.4 — migration contrôlée | migration sans changement de contenu mathématique | **faite** : PR #139 fusionnée le 11 octobre 2026 (`e9b5d2b`) ; 69 labels historiques et huit objets complémentaires | ce registre |
| C8.5 — réduction de prose | après validation de la taxonomie | **non commencée** | — |
| C8.6 — traçabilité | spécification ↔ Lean ; littérature, prémisses et exemples ↔ provenance | **ouverte** (obligation de clôture 6) | — |
| C8.7 — porte de sortie | dix critères | **ouverte** : C8 n'est pas clos | — |

Texte d'origine des étapes encore ouvertes et de la contrainte scientifique du plan, reproduit sans traduction :

> ##### C8.5 — Prose reduction
>
> Only after the taxonomy is mechanically validated, perform a separate editorial pass.
>
> For every explanatory paragraph adjacent to a structured statement ask:
>
> 1. Does it add an assumption?
> 2. Does it add scope?
> 3. Does it add interpretation?
> 4. Does it add motivation?
> 5. Does it add a limitation?
> 6. Or does it merely announce the kind or evidential status of the following block?
>
> Only the sixth category is a candidate for deletion.
>
> The before/after word count is evidence of reduction, not its justification.
>
> ##### C8.6 — Traceability
>
> Extend the specification ↔ Lean inventory so that the distinction between:
>
> `normative statement → formal target → proof/evidence`
>
> and
>
> `literature result / assumption / example → provenance or local support`
>
> is explicit.
>
> This work feeds H-semantic traceability but must not be used to claim semantic correspondence merely because labels coincide.
>
> ##### C8.7 — Exit gate
>
> C8 closes only when:
>
> 1. every numbered statement has a validated kind and role;
> 2. definitions, assumptions, requirements, results, literature claims, and examples are structurally distinguishable;
> 3. local hypotheses cannot silently become global normative statements;
> 4. proof and proof-sketch blocks have validated parent kinds;
> 5. open claims remain open in generated inventories and propagation checks;
> 6. provenance requirements are enforced for literature claims;
> 7. the current statement inventory is regenerated from source;
> 8. the specification builds and renders;
> 9. the existing mathematical content is unchanged except for explicitly ratified classification;
> 10. a prose-reduction pass demonstrates that removed text was structurally redundant rather than scientifically necessary.
>
> #### 8. Scientific constraint
>
> This refactoring is documentary/formal infrastructure. It must not be used to manufacture mathematical certainty.
>
> In particular:
>
> - changing proposition → theorem is a scientific status change, not a formatting change;
> - adding a proof slot is not a proof;
> - marking a literature result as established does not make it a K7PL result;
> - turning a prose assumption into an axiom changes the explicit foundational surface and requires authorial ratification;
> - deleting prose is legitimate only when the represented information remains recoverable elsewhere.
>
> The taxonomy exists to make these distinctions harder to violate, not easier to conceal.

## Contrôles mécaniques du registre

Repris de `LEAN-STATEMENT-ONTOLOGY-CONTROLS.md`, supprimé après intégration ([dernière version](https://github.com/AntheaLiles/k7pl/blob/2bdb06e5e42857cef5c2f9084f6b6b7245bed46b/docs/tracking/LEAN-STATEMENT-ONTOLOGY-CONTROLS.md)).

- `scripts/manuscript_metrics.py` inventorie les directives historiques et spécialisées et expose la nature, le rôle logique, l’état épistémique, l’appui, la portée et les références.
- `scripts/controles/statement_ontology.py` contrôle les métadonnées des directives spécialisées ; il est intégré aux contrôles de notation (`scripts/controle.py`). Ses règles, et celles que la compilation applique déjà, sont décrites dans `.claude/skills/writing-rules.md`, section « Énoncés : directives spécialisées ».
- `scripts/controles/statement_inventory.py` compare les 77 objets sources à la table « Classification courante » de ce registre, vérifie les 69 labels historiques plus exactement huit compagnons (cinq issus de C8.4, trois de la scission de `thm:raffinement`), détecte les dérives de champs et de références, et compare chaque niveau historique à l’instantané pré-migration reproduit en annexe. `--dependency-cycles` est un diagnostic non bloquant : toute composante détectée est une alerte de revue sémantique, pas une preuve de circularité scientifique.

Ces contrôles sont mécaniques et structurels. Ils ne prouvent pas la vérité mathématique, ne valident pas une preuve écrite, ne résolvent pas automatiquement les références bibliographiques et ne vérifient pas la bonne attache argumentative d’une hypothèse locale. Aucun énoncé n’a été promu à `established`.

## Classification courante
| Label | Source | Nature | Rôle | État | Appui | Scope tag | Portée détaillée ratifiée | Niveau historique | Note de migration |
|---|---|---|---|---|---|---|---|---|
| `thm:divulgation_delimitee` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean` | result | conjecture | proposed | proofsketch | security | Proposition de non-interférence conditionnelle à l’accord sur les échappatoires ; cas Declassify et relation de libération non prouvés. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:terminaison_lfp` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean` | result | theorem | under-review | proofsketch | fixed-points | Itération monotone sur Trellis_fin de hauteur h ; vérifier hypothèses d’ordre, hauteur, borne et leastness. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `req:sedimentation_graduee` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | requirement | — | not-applicable | none | fixed-points | Extension graduée de la sédimentation; convergence ouverte | langage | Exigence ouverte séparée du résultat de littérature thm:sedimentation. |
| `thm:fenetre_grade` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | result | proposition | proposed | proofsketch | fixed-points | Réduction de fenêtres de pile à la troncature N_r ; explicitement non démontrée dans le bloc. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:loi_historique` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | result | theorem | under-review | proofsketch | fixed-points | Lois de cohérence de λ pour la comonade cofree et bialgèbre ; naturalité et équations doivent être vérifiées. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:productivite_couche_2` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | result | corollary | under-review | proofsketch | fixed-points | Production d’une observation en temps fini par anamorphisme typé ; ne signifie pas épuisement du flux. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:progression_polarisee` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | result | theorem | under-review | proofsketch | fixed-points | Principe général à deux cas de polarité : terminaison en μ, production finie d’observation en ν. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:sedimentation` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | literature | — | not-applicable | literature | literature | Résultat non gradué de points fixes imbriqués et convergence des approximations finies | langage | Esquisse explicative conservée sur l’objet documentaire ; provenance bibliographique exacte encore à résoudre. |
| `thm:terminaison_couche_3` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | result | corollary | under-review | proofsketch | fixed-points | Terminaison du pli sur μF par indice strictement décroissant ; corollaire de progression_polarisee. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:troncature_comonade` | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` | result | theorem | under-review | proofsketch | fixed-points | Lois de comonade graduée et morphisme de comonades pour la troncature, sous les définitions de N_r et δ. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:action_parallele` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | result | lemma | under-review | proofsketch | effects | Compatibilité de φ_n avec l’effet parallèle pour multiplicité entière ; budget exclu et traité séparément. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:coherence_axiome` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | result | proposition | proposed | proofsketch | effects | Compatibilité r·ψ(Δ,ε)=ψ(r·Δ,φ_r(ε)) seulement dans le domaine où les deux actions sont définies ; aucun axiome par le seul nom. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:coherence_usage` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | result | lemma | under-review | proofsketch | effects | Commutation de Scale_Usage avec ψ, sous factorisation et domaine défini ; signatures et quatre composantes à confirmer. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:distributivite_tronquee` | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` | result | lemma | under-review | proofsketch | effects | Pour u fini ou k=0 ; la preuve par cas des combinaisons finies/infinies, notamment k=ω, doit être exhaustive. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `req:schema_reinvocation_compatibility` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | requirement | — | not-applicable | none | metatheory | Ré-invocation de multiplicité n ∈ ℕ∞ ; l’associativité et la compatibilité contexte/effet sont des obligations distinctes ; au cas ω, la compatibilité est distincte et conditionnelle aux suprema qui définissent φ_ω | langage | Obligation extraite de thm:schema_reinvocation. |
| `thm:lemme_capacite` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | under-review | proofsketch | resources | Ressources linéaires / accès concurrents | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_commutation` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | under-review | proofsketch | metatheory | Substitution et transformations syntaxiques | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_effacement` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | under-review | proofsketch | metatheory | Morphism de raffinement conditionnel aux lois de commutation, préservation et fibre ; les trois conséquences ne sont pas acquittées par le seul schéma. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_preservation` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | under-review | proofsketch | metatheory | Traduction de systèmes de règles | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_reinvocation` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | under-review | none | metatheory | Ré-invocation de multiplicité n ∈ ℕ∞ : cas fini borné, cas ω traité explicitement (domaine décidé par l'autrice le 12 octobre 2026). | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:schema_restriction` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | under-review | proofsketch | metatheory | Restriction de structures | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:tri_topologique` | `spec/Spec/C2/SixSchemasDeMetatheorie.lean` | result | lemma | supported | proofsketch | graphs | Graphes finis | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:determinisme_observationnel` | `spec/Spec/C2/SystemeDeRaffinement.lean` | result | conjecture | proposed | proofsketch | operational-semantics | Conjecture conditionnelle à une politique d’ordonnancement non consultative ; le cas Guard reste ouvert. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:non_interference` | `spec/Spec/C2/SystemeDeRaffinement.lean` | result | theorem | under-review | proofsketch | security | Fragment séquentiel ; observation indexée par niveau. Ne pas étendre à la concurrence ni à la déclassification. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:raffinement` | `spec/Spec/C2/SystemeDeRaffinement.lean` | result | theorem | under-review | proofsketch | metatheory | Construction du système de raffinement, conditionnelle à une traduction fonctorielle préservant le typage ; les trois lectures sont des corollaires séparés. | langage | Classification ratifiée ; scindé le 12 octobre 2026 (décision de l'autrice, option a). La classification n’est pas une preuve mathématique. |
| `thm:raffinement_effacement` | `spec/Spec/C2/SystemeDeRaffinement.lean` | result | corollary | under-review | none | metatheory | Effacement de la Phase 8 comme action de la traduction sur les objets, sous la prémisse que la Phase 8 efface exactement grades et effets. | langage | Objet issu de la scission de thm:raffinement ; état hérité du bloc d'origine, sans promotion. Formulation des prémisses à valider par l'autrice. |
| `thm:raffinement_non_interference` | `spec/Spec/C2/SystemeDeRaffinement.lean` | result | corollary | under-review | none | security | Non-interférence du chapitre 1 comme indiscernabilité dans la base, relativement à une relation d'observation fixée sur le métalangage. | langage | Objet issu de la scission de thm:raffinement ; état hérité du bloc d'origine, sans promotion. Formulation des prémisses à valider par l'autrice. |
| `thm:raffinement_precision` | `spec/Spec/C2/SystemeDeRaffinement.lean` | result | corollary | under-review | proofsketch | graded-typing | Précision restreinte à une fibre comme ordre de la fibre, et ordre modal comme restriction à l'usage, si ⊑ porte sur grades et effets et si sa restriction est un ordre. | langage | Objet issu de la scission de thm:raffinement ; esquisse déplacée depuis le bloc d'origine. Formulation des prémisses à valider par l'autrice. |
| `thm:temps_mononiveau` | `spec/Spec/C3/GrammaireDesTypes.lean` | result | lemma | under-review | proofsketch | effects | Sous-quantale des effets concentrés à un niveau ; vérifier fermeture et signature complète des opérations. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `req:homomorphisme_roues_realisation` | `spec/Spec/C3/LesContraintesDeValeur.lean` | requirement | — | not-applicable | none | representation | Injectivité des quatre singularités et comportement de select ; l’arithmétique des valeurs encodées est une exigence de réalisation séparée | representation | Obligation de réalisation séparée de thm:homomorphisme_roues. |
| `thm:deadlock_acyclique` | `spec/Spec/C3/LesContraintesDeValeur.lean` | result | theorem | under-review | proofsketch | concurrency | Absence de blocage mutuel sous protocoles duaux et graphe de dépendances acyclique ; invariant graphe statique/dynamique à établir. 2026-10-20 : cet invariant, la simulation du graphe d'attente (Sim), est une prémisse explicite de l'énoncé (décision de l'autrice, Q3 a). | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:homomorphisme_roues` | `spec/Spec/C3/LesContraintesDeValeur.lean` | result | proposition | under-review | proofsketch | representation | Injectivité des quatre singularités et comportement de select | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:representation_inobservable` | `spec/Spec/C3/LesContraintesDeValeur.lean` | requirement | — | not-applicable | none | representation | Invariance de obs entre représentations admissibles d’une même valeur ; relation d’admissibilité et signatures de repr/obs à préciser. | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:completude_graduee` | `spec/Spec/C3/LeSystemeGradue.lean` | result | proposition | under-review | proofsketch | graded-typing | Exhaustivité uniquement sur l’inventaire fermé des codes du noyau, pas sur l’annexe illustrative ni les extensions. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:completude_verificateur` | `spec/Spec/C3/LeSystemeGradue.lean` | requirement | — | not-applicable | none | graded-typing | Implémentation du vérificateur / compilation | compilation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:morphismes_modes` | `spec/Spec/C3/LeSystemeGradue.lean` | result | proposition | under-review | proofsketch | graded-typing | Quatre morphismes pour l’instanciation donnée ; dépend de l’orientation exacte des inclusions Cont et de l’affaiblissement. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:boxtimes_addition` | `spec/Spec/C3/ReglesDeTypage.lean` | result | corollary | under-review | proofsketch | graded-typing | Égalité avec l’addition des contextes lorsque la composante temporelle est nulle et ψ est définie partout. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:coherence_subsomption` | `spec/Spec/C3/ReglesDeTypage.lean` | result | proposition | under-review | proofsketch | graded-typing | Cohérence des interprétations des dérivations d’un même terme ; isoler les faits annexes sur les jointures. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:commutation_monoide` | `spec/Spec/C3/ReglesDeTypage.lean` | result | lemma | under-review | proofsketch | graded-typing | Projection sur S sous absence de relations croisées ; le cas ω dépend de la préservation des suprema du quotient. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:determinisme_parallele` | `spec/Spec/C3/ReglesDeTypage.lean` | result | theorem | under-review | proofsketch | graded-typing | Couche 3 / parallélisme / coût | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:substitution` | `spec/Spec/C3/ReglesDeTypage.lean` | result | lemma | under-review | proofsketch | graded-typing | Substitution typée sous hypothèses explicites de mise à l’échelle d’usage, compatibilité avec ψ et conversions de grade. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:substitution_simultanee` | `spec/Spec/C3/ReglesDeTypage.lean` | result | corollary | under-review | proofsketch | graded-typing | Substitution simultanée dérivée par itération de substitution élémentaire, une liaison à la fois. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:preservation_type` | `spec/Spec/C3/StructuresOuvertesEffetsEtMetaTheorie.lean` | result | theorem | under-review | proofsketch | graded-typing | Préservation par réduction sous condition de séparation P2 ; volet MLIR est la conjecture distincte abaissement_grades. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:fidelite_interprete` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | result | theorem | under-review | proofsketch | translation | Fidélité conditionnelle sur communication, contrôle et effets ; exclut explicitement grades et raffinements. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:simulation` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | result | theorem | under-review | proofsketch | translation | Simulation avant →+ modulo équivalence structurelle, avec extension de trace ; le canal de temps et les clauses d’effet restent à établir. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:traduction_metalangage` | `spec/Spec/C4/CalculDeProcessusSousJacent.lean` | result | theorem | under-review | proofsketch | translation | Préservation du typage de chaque dérivation par traduction, sous obligations par règle et ré-invocation. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:isomorphisme_memoire` | `spec/Spec/C4/EchelleDeLActeur.lean` | result | proposition | under-review | proofsketch | interoperability | Dispositions bit-à-bit pour types primitifs de largeur fixe et versions déclarées ; pas de garantie générale entre formats. | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:determinisme_rejeu` | `spec/Spec/C4/EchelleDuSysteme.lean` | result | theorem | under-review | proofsketch | runtime | Rejeu logique observationnel, sous journal complet et gestionnaires purs ; ne conclut pas à l’identité binaire. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:liberte_initialisation` | `spec/Spec/C4/EchelleDuSysteme.lean` | result | lemma | under-review | proofsketch | runtime | Initialisation complète sous acyclicité du graphe et correspondance démontrée entre graphe statique et attentes dynamiques. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:rejeu_binaire` | `spec/Spec/C4/EchelleDuSysteme.lean` | result | corollary | under-review | proofsketch | runtime | Identité binaire seulement sous E_repro et injectivité de la représentation ; corollaire conditionnel du rejeu logique. | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:revocation_ffi` | `spec/Spec/C4/EchelleDuSysteme.lean` | requirement | — | not-applicable | none | ffi-safety | Passerelle FFI / runtime | representation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:surete_ffi` | `spec/Spec/C4/EchelleDuSysteme.lean` | result | theorem | under-review | proofsketch | ffi-safety | Exclusivité d’accès de l’acteur pendant l’appel FFI ; n’implique pas la révocation côté hôte. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:sync_motifs_jonction` | `spec/Spec/C4/EchelleDuSysteme.lean` | result | lemma | under-review | proofsketch | concurrency | Sémantique de Guard/jonction pour présence simultanée de messages ; préciser la relation exacte avec la transition. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:cloture_sortage` | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean` | result | lemma | under-review | proofsketch | graded-typing | Préservation du sortage par substitution à égalité de sortes ; l’égalité discrète simplifie l’induction mais les cas restent à contrôler. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:confinement_sortes` | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean` | result | lemma | under-review | proofsketch | graded-typing | Sortage de la traduction et confinement des canaux d’effets libres à ceux mentionnés par ε ; dépend de la traduction typée. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:introduction_unique` | `spec/Spec/C4/ModelesDeMemoire.lean` | result | proposition | under-review | proofsketch | memory-safety | Unicité d’introduction, acyclicité des destinations et terminaison ; la justification de H1 et le cas d’élimination d’arène restent ouverts. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:surete_spatiale` | `spec/Spec/C4/ModelesDeMemoire.lean` | result | theorem | under-review | proofsketch | memory-safety | Impossibilité de mutation concurrente sous H1, H2 et H3 ; H1 n’est pas justifiée indépendamment. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:commutation_traduction` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | lemma | under-review | proofsketch | translation | Équation de traduction/substitution modulo congruence structurelle cible ; conditions de fraîcheur et cas de construction à vérifier. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:correction_ressource` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | theorem | under-review | proofsketch | resource-accounting | Borne instrumentée des usages effectifs par membre et liaison ; machine instrumentée et compte partagé à définir. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:image_fix` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | theorem | under-review | proofsketch | fixed-points | Image du point fixe sur Trellis_fin de hauteur h ; dépend de terminaison_lfp et de la compatibilité de ré-invocation finie. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:lemme_fondamental` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | lemma | under-review | proofsketch | logical-relations | Fragment sans Declassify, y compris dans les images de substitution ; la déclassification reste hors portée. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:preservation` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | theorem | under-review | proofsketch | operational-semantics | Préservation du type et décroissance du potentiel le long des chaînes d’une trace partielle ; invariants concurrents à formaliser. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:progres` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | theorem | under-review | proofsketch | operational-semantics | Progrès local d’un calcul clos ; ne pas confondre avec le progrès global d’un pool et l’absence de blocage mutuel. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:relation_produit` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | lemma | under-review | proofsketch | logical-relations | Compatibilité d’une relation logique produit sous la condition sur la clause de modalité ; la composante budget reste à justifier. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:stratification_journal` | `spec/Spec/C4/SemantiqueOperationnelle.lean` | result | theorem | under-review | proofsketch | operational-semantics | Équivalence d’observation du rejeu après projection au niveau ℓ ; dépend de la sémantique des traces et de l’effacement sûr. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:expansion_macro` | `spec/Spec/C5/CeQuUneMacroDeclare.lean` | result | corollary | under-review | proofsketch | syntax | Dérivabilité de Expand par substitution et composition des effets dans l’ordre syntaxique ; corollaire de l’élaboration. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `def:elaboration` | `spec/Spec/C5/LeTheoremeDElaboration.lean` | definition | — | not-applicable | none | syntax | Fonction Surface → Noyau | langage | Compagnon de la séparation du bloc composite thm:elaboration. |
| `thm:elaboration` | `spec/Spec/C5/LeTheoremeDElaboration.lean` | result | theorem | under-review | proofsketch | syntax | Fonction Surface → Noyau ; isoler la définition de la préservation du sens et des conséquences annexes. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:hygiene` | `spec/Spec/C5/NotationsSpecialisees.lean` | result | lemma | under-review | proofsketch | syntax | Macros / substitution | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:hygiene_graduee` | `spec/Spec/C5/NotationsSpecialisees.lean` | result | conjecture | proposed | proofsketch | syntax | Commutation graduée de la métasubstitution ; le transfert des contextes/effets reste non démontré. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:resucrage` | `spec/Spec/C5/NotationsSpecialisees.lean` | requirement | — | not-applicable | none | syntax | Exigence de préservation de l’α-équivalence de surface ; l’algèbre de liaison de surface manque. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:staticite_syntaxe` | `spec/Spec/C5/NotationsSpecialisees.lean` | result | corollary | under-review | proofsketch | syntax | Aucune production de noms à l’exécution, sous la grammaire et les phases décrites ; corollaire revendiqué de l’élaboration. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:abaissement_grades` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | result | conjecture | proposed | proofsketch | compilation | Conjecture de préservation des grades par abaissement vers MLIR ; preuve règle par règle absente. | compilation | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:interface_jugement` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | definition | — | not-applicable | none | compilation | Définition de l’interface par le jugement | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:interface_jugement_cloture` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | result | proposition | under-review | proofsketch | compilation | Définition de l’interface par le jugement ; clôture limitée aux formes de déclaration énumérées | langage | Propriété séparée de la définition thm:interface_jugement. |
| `thm:rejet_reproductible` | `spec/Spec/C6/CeQueLeSolveurRetourne.lean` | result | theorem | under-review | proofsketch | compilation | Identité du diagnostic sous configuration fixe et hypothèse D_det ; déterminisme des parcours/choix à garantir. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |
| `thm:stabilisation_pipeline` | `spec/Spec/C6/LeProcessusDeCompilation.lean` | result | theorem | under-review | proofsketch | compilation | Terminaison de la boucle vérification/optimisation sous budget fini décroissant strictement à chaque modification. | langage | Classification ratifiée ; la classification n’est pas une preuve mathématique. |

## Obligations ouvertes issues de la revue sémantique C8

Cette section reprend, lot par lot, les constats des notes de revue sémantique C8 (`docs/tracking/LEAN-SEMANTIC-AUDIT-BATCH-*.md`), supprimées après intégration ; la dernière version de chaque note est indiquée par son commit. Ces constats sont des lectures de source provisoires : ils n'établissent ni ne réfutent aucun énoncé, et ne changent ni label, ni hypothèse, ni état épistémique. Dans `spec/`, seule une note `_Obligation ouverte._` est ajoutée au bloc concerné ; l'énoncé et l'esquisse sont inchangés. Toute explicitation qui modifierait un énoncé, une hypothèse ou un état reste soumise à l'accord de l'autrice.

### Lot 01 — schémas de métathéorie

Source : `spec/Spec/C2/SixSchemasDeMetatheorie.lean`. Dernière version de la note : commit `3e2f45c65e0d5a083eae9ed1bb9715aeb2392714`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:schema_commutation` | Schéma sous-spécifié : récurrence structurelle, hygiène et respect des liaisons ne fixent pas les équations de compatibilité. | Note d'obligation ouverte. **2026-10-20, owner (Q3 e) :** l'hypothèse de compatibilité de chaque clause avec la substitution entre dans l'énoncé (reprise de la PR #246) ; les obligations restent à chaque instance. | Action de `T` sur les variables et chaque constructeur, lieurs compris ; substitution sans capture ; équivalence de renommage ; condition latérale du cas du lieur. Les instances (`thm:commutation_traduction`, `thm:elaboration`) n'en sont pas déchargées par la seule citation. |
| `thm:schema_preservation` | Schéma d'induction plausible ; interface incomplète. | Note d'obligation ouverte. | Formes de jugement source et cible, traduction des contextes, obligation par règle (prémisses et conditions latérales) ; admissibilité de la composition dans le système cible effectif. |
| `thm:tri_topologique` | Résultat standard ; esquisse adéquate à ce niveau. | Aucun : l'énoncé fixe le sens des arêtes par rapport à l'ordre obtenu. | Expliciter la convention d'orientation dans les définitions de graphes qui l'emploient et préciser si les arêtes multiples sont admises ; vérifier les prémisses d'acyclicité aux sites d'usage (`thm:deadlock_acyclique`, `thm:liberte_initialisation`). |
| `thm:schema_restriction` | Pas encore justifié comme théorème générique. | Note d'obligation ouverte. | Structure ou catégorie, source et cible de `ρ_p`, action sur objets et opérations, condition exacte de stabilité ; vérification des cinq instances contre cette interface. |
| `thm:schema_reinvocation` | Composé : loi visée et obligation de compatibilité ; « fini » contredit `n ∈ ℕ∞`. | Note d'obligation ouverte. La séparation de l'obligation de compatibilité dans `req:schema_reinvocation_compatibility` était déjà faite (C8.4). Domaine de `n` décidé par l'autrice le 12 octobre 2026 : `ℕ∞` avec traitement explicite de `ω` ; énoncé, exigence et note mis à jour (voir [DECISIONS](DECISIONS.md)). | Existence des suprema qui définissent `φ_ω` ; lien entre `reinvo(ω,t)` et le service répliqué de la traduction ; lois de `Scale_Usage` et `φ_n`, associativité, unité et compatibilité, au cas fini et au cas `ω`. Aucune multiplication du budget. Le titre « ré-invocation bornée » ne couvre plus le cas `ω` : à revoir avec l'autrice. |
| `thm:schema_effacement` | La conclusion dépasse les conditions citées. | Note d'obligation ouverte. | Systèmes de raffinement et morphisme ; application dont on prend les fibres ; correspondance entre les hypothèses de `thm:raffinement` et la transformation du schéma. |
| `thm:lemme_capacite` | Argument conditionnel ; prémisses opérationnelles implicites. | Note d'obligation ouverte. | Règles d'introduction et d'accès de la capacité, règle de contraction et grades admis, notion formelle d'accès concurrents ; dire si la conclusion suit de la seule linéarité ou exige une propriété de la sémantique opérationnelle. `thm:surete_spatiale` en dépend. |

### Lot 02 — raffinement et points fixes

Sources : `spec/Spec/C2/SystemeDeRaffinement.lean`, `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean` et, pour la dépendance directe `thm:traduction_metalangage`, `spec/Spec/C4/CalculDeProcessusSousJacent.lean`. Dernière version de la note : commit `24a69e3ec85255a3ae7acb1c6a7d888bb5c0670c`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:raffinement` | Construction conditionnelle ; les trois lectures demandent des définitions et lemmes propres. | Scission décidée par l'autrice le 12 octobre 2026 (option a) : construction sous `thm:raffinement`, lectures dans `thm:raffinement_effacement`, `thm:raffinement_non_interference` et `thm:raffinement_precision`, chacune avec ses prémisses et une note d'obligation ouverte. La réserve sur l'induction de `thm:traduction_metalangage` figurait déjà dans le texte (note de bas de page). | Construction : catégories, foncteur et préservation du typage à fixer. _(i)_ : la Phase 8 efface exactement grades et effets. _(ii)_ : relation d'observation, observations admises par la cible, « même image ». _(iii)_ : propriétés d'ordre de la restriction de `⊑` à une fibre, coïncidence avec l'ordre de la fibre, morphismes verticaux. L'enrichissement sur tous les morphismes reste un engagement distinct, déjà nommé dans le texte. |
| `thm:non_interference` | Voie proposée par paramétricité ; obligations sémantiques ouvertes. | Note d'obligation ouverte. | Équivalence observationnelle (valeurs et traces) ; définition de `⟦·⟧_ℓ` et rapport à l'effacement de la Phase 8 ; interprétation relationnelle de chaque constructeur et effet ; cas du produit du grade et des communications sur canaux distingués ; exclusion de la déclassification, posée par le texte mais non portée par l'énoncé. Portée : fragment séquentiel. |
| `thm:determinisme_observationnel` | Conjecture, correctement marquée comme telle. | Note d'obligation ouverte ; état `proposed` maintenu. | Observations permises à l'ordonnanceur (hypothèse `𝒟_S`), projection de trace `π_ℓ`, équivalence entre exécutions, cas Guard. Les quatre cas faciles ne valent pas pour le cinquième. |
| `thm:sedimentation` | Bloc composé : résultat de littérature non gradué et extension graduée ouverte. | Note d'obligation ouverte. La séparation en `thm:sedimentation` (littérature) et `req:sedimentation_graduee` était déjà faite (C8.4). | Source exacte et hypothèses du résultat cité (champ `source` non résolu, point 4). Le résidu éditorial de la séparation (« (i) … repris ici ; » sans second membre) est corrigé avec l'accord de l'autrice du 12 octobre 2026 : l'énoncé dit désormais qu'il vaut pour des conteneurs non gradués et renvoie à l'exigence qui suit. |
| `req:sedimentation_graduee` | Exigence ouverte ; l'esquisse ne la décharge pas. | Note d'obligation ouverte. | Énoncé de la préservation et de la convergence pour des conteneurs gradués ; route de preuve ; contrainte d'outil (type de chemin cubique absent de l'assistant visé). |
| `thm:traduction_metalangage` (dépendance) | Plan d'induction, non preuve conduite. | Note d'obligation ouverte. | Formes de jugement source et cible ; induction règle par règle, en particulier ré-invocation finie, services répliqués, effets (composante `𝓔` non traduite), types dépendants pragmatiques et point fixe. Ne pas le traiter comme fondement vérifié parce que `thm:raffinement` le cite. |

### Lot 03 — métathéorie opérationnelle et bornes de ressource

Source : `spec/Spec/C4/SemantiqueOperationnelle.lean`. Dernière version de la note : commit `293a687f8633788a68f8ef209adf130d6d37a938`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:preservation` | Plan de preuve substantiel ; l'invariant concurrent trace/potentiel n'a pas d'interface formelle. | Note d'obligation ouverte. La lecture le long des chaînes figurait déjà dans l'énoncé. | Objet trace et son ordre ; produit `τ · ε` et lois de préservation de l'ordre de part et d'autre ; relèvement de l'inégalité séquentielle à chaque chaîne de l'ordre partiel ; dépendance explicite à la forme normale `φ_n ∘ π_S` et à la clôture de la monotonie par composition. Preuve esquissée et conditionnelle. |
| `thm:progres` | Progrès local conditionnel ; l'esquisse décrit d'abord un progrès global distinct ; deux hypothèses de réalisation sont substantielles. | Note d'obligation ouverte. | Séparer ou non le progrès local d'un calcul clos et le progrès global d'un pool, et faire entrer ou non les deux hypothèses dans l'énoncé : décision de l'autrice (voir [DECISIONS](DECISIONS.md)). Pour le progrès global : configuration du pool, critère « au moins un membre avance », prémisse d'acyclicité. Le progrès local seul n'établit pas le progrès global. |
| `thm:correction_ressource` | Invariant de machine instrumentée proposé, non prouvé par l'esquisse. | Note d'obligation ouverte. Les réserves sur la littérature (fragment simplement typé sans récursion) figuraient déjà dans le texte. | Configuration et transition instrumentées ; valeur initiale et mise à jour de `ν` par règle ; indexation par contexte et par membre ; liaisons partagées sans double compte ; cas d'usage de variable, composition, substitution et concurrence, avec les appels aux lois de cohérence de `φ` et `ψ`. La préservation non instrumentée ne l'implique pas ; ne pas promouvoir sur la base du plan ou de résultats analogues. |

### Lot 04 — rejeu observationnel et relations produit

Source : `spec/Spec/C4/SemantiqueOperationnelle.lean`. Dernière version de la note : commit `3e273538bcd1c9cafacc6f25a1a899b0068af5e4`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:stratification_journal` | Argument de projection esquissé ; les notions d'observation et de rejeu qu'il suppose ne sont pas formalisées dans le bloc. | Note d'obligation ouverte. | Relation de rejeu, alphabet des traces, action de `π♭_ℓ` sur étiquettes, valeurs et temps, fonction d'observation au niveau `ℓ`. Prémisse de non-interférence observationnelle : un pas au-dessus de `ℓ` ne doit influencer ni le contrôle ni les pas ultérieurs de niveau au plus `ℓ` ; elle n'est tenue que pour le fragment séquentiel (`thm:non_interference`) et reste conjecturale sous concurrence (`thm:determinisme_observationnel`). Portée du déterminisme invoqué pour l'unicité du rejeu. Énoncer ces prémisses ou prouver directement la préservation des observations : décision de l'autrice (voir [DECISIONS](DECISIONS.md)). |
| `thm:relation_produit` | Explicitement incomplet : le cas du budget et la compatibilité facteur par facteur restent à écrire. | Note d'obligation ouverte. | Signature des opérations et prédicat de compatibilité par facteur et pour le produit ; relation sur la composante budget et trace ; vérification de chaque opération et de la clause modale. Séparer ou non le cas du budget : décision de l'autrice (voir [DECISIONS](DECISIONS.md)). Observation hors note d'audit : l'esquisse désigne l'usage par `ℕ∞`, alors que la portée normative d'usage est `WithTop ℚ≥0` (usages rationnels admis, C2 ; `Usage` dans `Spec.C3.EffectiveKernel`) ; à harmoniser avec l'accord de l'autrice. |

### Lot 05 — commutation de la traduction et image du point fixe

Sources : `spec/Spec/C4/SemantiqueOperationnelle.lean` et, pour la dépendance directe `thm:terminaison_lfp`, `spec/Spec/C2/AdjonctionsEtEnrichissement.lean`. Dernière version de la note : commit `93a7e9a5f0269a994225dc4fc3c807452faee244`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:commutation_traduction` | Stratégie standard ; l'énoncé non restreint omet les conditions de typage et de fraîcheur dont dépend l'encodage. | Note d'obligation ouverte. | Termes bruts ou dérivations typées : décision de l'autrice (voir [DECISIONS](DECISIONS.md)). Domaine de la traduction, convention de substitution, fraîcheur du nom restreint, α-équivalence cible ; vérification par constructeur (lieurs, modalités graduées, effets). Les obligations de `thm:schema_commutation` (lot 01) ne sont pas déchargées par citation. |
| `thm:image_fix` | Construction plausible sous la hauteur finie ; typage et égalité sémantique dépendent d'interfaces de traduction et de ré-invocation inachevées. | Note d'obligation ouverte. | Clause de traduction de `fix` définie indépendamment du théorème : séparer ou non définition et théorème, décision de l'autrice (voir [DECISIONS](DECISIONS.md)). Réalisation de `f` sur tout le support fini ; borne exacte de `h` pas ; typage et bon sortage contre les clauses effectives ; compatibilité de la ré-invocation finie (`req:schema_reinvocation_compatibility`). Terminaison, typage et égalité sémantique restent distincts. |
| `thm:terminaison_lfp` (dépendance) | Argument monotone de hauteur finie reconnaissable ; structure du domaine et borne de hauteur à expliciter. | Note d'obligation ouverte. | Définition exacte de `Trellis_fin` et de son ordre ; support fini, minimum, borne supérieure, hauteur ; convention « au plus `h` étapes » ; résultat de complétude pour le plus petit point fixe. Prémisse de monotonie et exclusion des constructions non monotones conservées. Observation hors note d'audit : l'énoncé écrit « /indexée/ », italique héritée du format Org, qui s'affiche avec ses barres obliques ; correction éditoriale soumise à l'accord de l'autrice. |

### Lot 06 — préservation des sortes et confinement des canaux d'effet

Source : `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean`. Dernière version de la note : commit `cb3cf3469a3a5aac08ef84524a0b4ca8585954f0`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:cloture_sortage` | Induction directe sous la relation de substitution volontairement discrète ; aucun défaut substantiel relevé. | Note d'obligation ouverte. | Prémisse d'égalité des sortes à conserver ; substitution sans capture et renommage des noms liés conformes à l'affectation de sortes. Aucun résultat plus large (raffinement non discret) ne doit en être déduit. |
| `thm:confinement_sortes` | Argument de sortage plausible ; l'induction dépend de clauses de traduction et de propriétés d'étiquetage à expliciter. | Note d'obligation ouverte. | Obligation de sortage par règle source et préservation par clause de traduction ; prémisses d'étiquetage `φ` et de niveau des valeurs par constructeur d'effet ; absence de nom nouveau dans la ré-invocation. Dépendance réciproque avec `thm:traduction_metalangage` à consigner comme induction simultanée, ou à ordonner. Conclusion limitée à la grammaire et aux sortes définies ici. |

### Lot 07 — simulation et fidélité de l'interpréteur

Source : `spec/Spec/C4/CalculDeProcessusSousJacent.lean`. Dernière version de la note : commit `2f615cdc1fdb77a47e4af45907c871a93434fcde`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:simulation` | Explicitement non démontré ; l'ordre des événements n'est pas une conséquence de la préservation du typage. | Note d'obligation ouverte. L'esquisse avait déjà été reformulée en contrat de sept points (configurations cibles, `R_cfg`, équivalence structurelle, clauses par règle, ordre causal, commutation avec la substitution, latence de When). | Remplir le contrat ; preuve par cas, congruence et opérations à portée comprises ; conservation des événements et de leur ordre causal ; conditions de `thm:commutation_traduction` (lot 05). Reste ouvert. |
| `thm:fidelite_interprete` | Composition conditionnelle plausible ; sa prémisse principale (Sim) n'est pas prouvée, et la notion de fidélité dépasse l'implication affichée. | Note d'obligation ouverte. | Observations source et cible et relation entre elles ; sens de l'adéquation requise ; apport exact de la simulation avant. Aucune pleine abstraction ni équivalence dans les deux sens. Exclusion des grades et raffinements conservée. Observation hors note d'audit : l'énoncé dit « Alors tout est fidèle à la sémantique de K7PL », sans sujet explicite (l'interpréteur de référence, d'après le titre) ; correction éditoriale soumise à l'accord de l'autrice. |

### Lot 08 — absence de blocage mutuel et déterminisme du parallélisme

Sources : `spec/Spec/C3/LesContraintesDeValeur.lean` et `spec/Spec/C3/ReglesDeTypage.lean`. Dernière version de la note : commit `583c8d05d70d2f42b44c94d6aea273157ff7e45f`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:deadlock_acyclique` | L'invariant clé (simulation du graphe d'attente) est identifié, mais son passage de « prémisse manquante » à « par construction du typage » n'est pas formalisé. | Note d'obligation ouverte. **2026-10-20, owner (Q3 a) :** conclusion « absence de blocage mutuel » conservée ; la simulation (Sim) devient une prémisse explicite de l'énoncé ; l'argument par le typage de `Guard` reste la route pour la décharger. | Relations de dépendance statique et d'attente dynamique définies indépendamment ; invariant prouvé sur les états atteignables (Guard, émission, consommation, résidus de boîte, Timeout) ; tout cycle d'attente non terminal induit un cycle statique ; états terminaux et progression par expiration séparés du blocage mutuel. Prémisse d'acyclicité au site d'usage de `thm:tri_topologique` (lot 01). |
| `thm:determinisme_parallele` | L'inégalité de profondeur est immédiate pour des coûts positifs ; l'égalité des valeurs et la portée des effets demandent des hypothèses opérationnelles explicites. | Note d'obligation ouverte. | Sens de l'égalité des valeurs ; sémantique du parallèle et de la séquence ; terminaison, erreurs, divergence ; indépendance déduite des règles de couche 3 ; projection et ordre exacts de la comparaison. Observation hors note d'audit : l'énoncé dit que le premier calcul (parallèle) « majore » le second (séquentiel) en profondeur, alors que l'esquisse conclut `max(s₁,s₂) ≤ s₁+s₂`, soit l'inverse ; orientation à confirmer par l'autrice (voir [DECISIONS](DECISIONS.md)). |

### Lot 09 — soustraction tronquée et cohérence des actions graduées

Source : `spec/Spec/C2/ComonadeExponentielleEtFragments.lean`. Dernière version de la note : commit `e917fffd2419317901e92221bda947aa99eafcce`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:distributivite_tronquee` | Contre-argument d'exclusion solide ; la preuve positive n'énumère pas toutes les combinaisons finies/infinies de `β` et `k`. | Note d'obligation ouverte. | Énumération complète des cas sous la définition par cas de `⊖` (C2, D8 : `ω ⊖ ω = ω`). Vérification manuelle faite à l'intégration, non mécanisée : sous cette définition et `0·ω = 0`, la loi tient pour `u` fini ou `k = 0`, cas `k = ω` et `β = ω` compris ; pour `u = ω` et `k ≠ 0`, elle échoue pour `β = k` mais tient par exemple pour `β = ω`. La « nécessité » de l'énoncé (« l'égalité est fausse ») se lit donc « n'est pas une identité » ; reformulation soumise à l'accord de l'autrice. Ce lemme n'est pas une prémisse de `Scale_Usage`. |
| `thm:coherence_axiome` | Obligation de compatibilité, non résultat établi ; domaine conditionnel, opérations non entièrement définies. | Note d'obligation ouverte. | Définitions indépendantes du produit, de `ψ`, de `r·(-)`, de `φ_r` et du domaine admissible ; composante de budget sur ce domaine ; pas d'extension aux grades rationnels. Statut d'exigence ou de résultat conditionnel : décision de l'autrice, déjà ouverte au titre de `ARB-PR-04` / PR-54 (voir [DECISIONS](DECISIONS.md)). |
| `thm:coherence_usage` | Argument par composantes plausible sous la factorisation ; signatures et totalité implicites. | Note d'obligation ouverte. | Définitions à quatre composantes des contextes, effets, `ψ` et `Scale_Usage` ; même domaine des deux membres, usages rationnels et non bornés compris ; quatre égalités écrites. Reste conditionnel tant que l'interface n'est pas fixée. |

### Lot 10 — effets mononiveau, morphismes de modes et composition de contextes

Sources : `spec/Spec/C3/GrammaireDesTypes.lean`, `spec/Spec/C3/LeSystemeGradue.lean` et `spec/Spec/C3/ReglesDeTypage.lean`. Dernière version de la note : commit `4c8e81e74a5605b48ad5a8e011de768470563f70`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:temps_mononiveau` | Évaluation en `ℓ` candidate naturelle ; clôture du sous-ensemble concentré sous toute la structure de quantale à vérifier. | Note d'obligation ouverte. | Prédicat de concentration sur `κ` ; inverses mutuels ; préservation de chaque opération de la signature effective (produit séquentiel, parallèle, bornes supérieures) ; restreindre l'énoncé si la signature l'est ; lien opérationnel entre `tick` émis et support de `κ`. |
| `thm:morphismes_modes` | Les flèches suivent des triplets candidats si la définition de morphisme emploie les inclusions et la condition d'affaiblissement indiquées. | Note d'obligation ouverte. L'énoncé avait déjà été réécrit depuis l'audit : trois flèches (`M_Lin → M_Aff`, `M_Aff → M_Unr`, `M_Lin → M_Unr`), et `U_Rel` n'y est plus un mode ; l'incomparabilité Aff/Rel demandée par la note ne s'applique plus. | Conditions de morphisme avec leur sens ; `{0}` et `𝓡` idéaux de l'algèbre de grades ; contrôle des trois flèches. Reste conditionnelle aux triplets candidats ; ni inclusion d'intervalles d'usage ni sous-typage. |
| `thm:boxtimes_addition` | Preuve par composantes plausible à coût nul ; « composante temporelle nulle » et domaine de `ψ` à ajuster à la structure indexée par niveau. | Note d'obligation ouverte. | Coût temporel nul défini sur toute la famille (travail et profondeur, à chaque niveau) ; condition de liaisons communes pour `Δ₁ + Δ₂` ; domaine de `ψ` sans restriction sur ce sous-ensemble. Observation hors note d'audit : l'énoncé dit l'égalité « totale », alors que l'esquisse la conditionne aux « domaines structurels satisfaits » ; à harmoniser avec l'accord de l'autrice. |

### Lot 11 — énoncés restants et obligations transversales

Sources : les 37 labels non couverts par les lots 01 à 10, répartis dans C2 à C6. Dernière version de la note : commit `0dd701cba6ae6bdcc35377638a92c375df03be29`.

| Label | Constat provisoire | Appliqué dans `spec/` | Reste ouvert |
|---|---|---|---|
| `thm:surete_spatiale` | Argument conditionnel ; H1 supposée, non déchargée par le bloc. | Note d'obligation ouverte. | Établir H1 via `thm:introduction_unique` sans circularité (cas de l'élimination de l'arène), ou la garder comme hypothèse ; H2 et H3 distinctes. |
| `thm:introduction_unique` | Bloc composé (unicité, acyclicité, terminaison) ; cas de l'élimination de l'arène inachevé. | Note d'obligation ouverte. | Suivre les trois conclusions séparément (scission : décision de l'autrice, voir [DECISIONS](DECISIONS.md)) ; écrire le cas de l'élimination de l'arène. |
| `thm:elaboration` | Définition plus théorème de préservation sémantique. | Note d'obligation ouverte. La définition est déjà séparée dans `def:elaboration` (C8.4). | Conditions de typage et de portée de l'égalité des sens ; obligations du schéma de commutation pour cette instance. |
| `thm:staticite_syntaxe` | Théorème d'architecture appuyé sur l'inspection des phases. | Note d'obligation ouverte. | Inventaire complet des mécanismes producteurs de syntaxe (macros, `bind-to`) ; frontière de phase reliée aux règles formelles. |
| `thm:hygiene` | Commutation de substitution d'allure standard, dépendante de l'algèbre de portée. | Note d'obligation ouverte. | Fraîcheur, renommage, α-équivalence, action sur les lieurs. |
| `thm:hygiene_graduee` | Explicitement non démontrée. | Note d'obligation ouverte. État `proposed` maintenu. | Cas gradués du contexte et de l'effet ; aucune hérédité par le nom depuis `thm:hygiene`. |
| `thm:resucrage` | Exigence de surface, non résultat du noyau. | Note d'obligation ouverte. | Algèbre de liaison de surface et désucrage compositionnel. |
| `thm:expansion_macro` | Dérivation depuis la substitution plausible ; ordre d'occurrence correctement traité. | Note d'obligation ouverte. Le bloc portait déjà une note « Ce que ce théorème vaut ». | Alignement de la règle Expand sur l'ordre des occurrences et sur le lemme de substitution, métavariables répétées ou inutilisées comprises. |
| `thm:determinisme_rejeu` | Rejeu déterministe conditionnel. | Note d'obligation ouverte. La complétude du journal figure déjà comme prémisse. | Schéma du journal, relation d'observation, composantes comparées, capture des résultats de capacité. |
| `thm:rejeu_binaire` | L'identité binaire demande des prémisses de sérialisation et d'environnement plus fortes que l'égalité d'observation. | Note d'obligation ouverte. Une prémisse d'injectivité figure déjà dans l'énoncé. | Application de représentation, sérialisation déterministe, profil `E_repro`. Observation à l'intégration : l'injectivité de la représentation ne fournit pas le passage de l'égalité observationnelle à l'identité binaire, qui demande l'invariance de la représentation sur une classe d'observation (voir [DECISIONS](DECISIONS.md)). |
| `thm:liberte_initialisation` | L'ordre topologique n'exclut les attentes cycliques que si chaque initialisation termine. | Note d'obligation ouverte. | Terminaison locale ; correspondance exacte attentes / arêtes. |
| `thm:sync_motifs_jonction` | Réduction atomique plausible ; la non-vacuité des boîtes peut ne pas coder l'appariement. | Note d'obligation ouverte. | Prédicat d'appariement et transition atomique ; raffinement verrou-libre distinct. |
| `thm:surete_ffi` | Le transfert linéaire couvre le non-accès côté acteur, pas la révocation côté hôte. | Note d'obligation ouverte. La clause de révocation avait déjà été retirée du théorème. | Prémisse d'absence d'alias ou d'accès non suivi. |
| `thm:revocation_ffi` | Exigence d'implémentation correctement identifiée. | Note d'obligation ouverte. | Condition observable après retour ; tests de la passerelle. |
| `thm:completude_graduee` | Énumération finie conditionnelle à un inventaire complet et à la frontière de confiance dans le jugement. | Note d'obligation ouverte. | Table versionnée et vérifiée mécaniquement ; pas d'inférence de complétude d'implémentation. |
| `thm:completude_verificateur` | Exigence d'implémentation explicite. | Note d'obligation ouverte. | Reste séparée de la complétude logique. |
| `thm:coherence_subsomption` | L'existence des jointures ne suffit pas à la cohérence des coercions. | Note d'obligation ouverte. L'esquisse distinguait déjà jointures et coercions. | Fonctorialité du transport par famille puis par produit. Observation à l'intégration : l'esquisse désigne l'usage par `ℕ∞`, alors que la portée d'usage est `WithTop ℚ≥0` (voir aussi le lot 04). |
| `thm:commutation_monoide` | Cas fini appuyé sur la multiplicativité ; cas infini sous hypothèse de préservation des suprema. | Note d'obligation ouverte. | Respect de chaque relation de la présentation ; signatures finie et infinie exactes. |
| `thm:substitution` | Théorème conditionnel à obligations algébriques distinctes. | Note d'obligation ouverte. | Projection du grade, mise à l'échelle d'usage, itération d'effet et transport du budget suivis séparément ; cas When. |
| `thm:substitution_simultanee` | Corollaire sous contextes finis ; ordre non stable sous zones ordonnées. | Note d'obligation ouverte. | Ordre inverse par zone si les zones ordonnées sont adoptées. |
| `thm:action_parallele` | Loi par composantes routinière pour des multiplicités entières finies sur les paires travail/profondeur. | Note d'obligation ouverte. | Domaine des multiplicités et opération parallèle exacte explicités ; pas d'extension implicite aux multiplicités rationnelles ni à l'itération infinie. |
| `thm:lemme_fondamental` | Cas Declassify omis ; cycle avec `thm:divulgation_delimitee` dans l'état de base. | Note d'obligation ouverte. La portée a déjà été restreinte au fragment sans Declassify (#117) ; l'inventaire ne détecte plus de cycle syntaxique. | Substitutions apparentées, projection d'observation, clauses ; extension à la déclassification sous une relation de libération. |
| `thm:divulgation_delimitee` | Explicitement non démontrée. | Note d'obligation ouverte. État `proposed` maintenu. | Ensemble d'échappatoires, clôture, clause relationnelle de libération ; cas Declassify. |
| `thm:isomorphisme_memoire` | Transfert sans copie limité aux tableaux primitifs de largeur fixe et à un profil ABI. | Note d'obligation ouverte. L'énoncé avait déjà été restreint au profil `Π` des versions. | Contrats exacts Arrow / Cap'n Proto / MLIR (alignement, bitmap, propriété, pointeur de liste) contre versions épinglées. |
| `thm:homomorphisme_roues` | Encodage injectif et select séparés de la sémantique arithmétique. | Note d'obligation ouverte. L'obligation de réalisation est déjà séparée dans `req:homomorphisme_roues_realisation`. | Tests différentiels sur toutes les paires de singularités et combinaisons cible / compilateur. |
| `thm:representation_inobservable` | Formule de base confondant injectivité et invariance. | Note d'obligation ouverte. La formulation par invariance est en place (#116). | Relation de représentation admissible ; signatures de représentation et d'observation. |
| `thm:interface_jugement` | Définition à clôture de portée finie. | Note d'obligation ouverte. La clôture locale est séparée dans `thm:interface_jugement_cloture` (C8.4). | Portée « exactement trois » limitée aux formes énumérées ; clause de révision. |
| `thm:rejet_reproductible` | Conditionnel à une configuration de solveur fixée et à des parcours déterministes. | Note d'obligation ouverte. | Configuration comme partie de l'entrée ; tests d'identité octet à octet des diagnostics. |
| `thm:abaissement_grades` | Conjecture explicite. | Note d'obligation ouverte. État `proposed` maintenu. | Par passe : correspondance des grades, règle de typage cible, dépendance P1b. |
| `thm:stabilisation_pipeline` | Descente d'un budget fini, sous prémisses opérationnelles. | Note d'obligation ouverte. | Consommation par tour modifiant, budget non croissant, détection d'un tour sans changement ; tests. |
| `thm:terminaison_couche_3` | Instance de la progression polarisée ; repose sur le pli dépendant et un indice décroissant. | Note d'obligation ouverte. | Relation d'évaluation ; restrictions de récursion structurelle ; pas de quantification sur des fonctions arbitraires. |
| `thm:productivite_couche_2` | La productivité ne découle pas de `ω ⊖ 1 = ω` seul. | Note d'obligation ouverte. | Condition de garde ; atteinte en temps fini de chaque observation. |
| `thm:progression_polarisee` | Méta-schéma utile ; terminaison et productivité sont deux conclusions distinctes. | Note d'obligation ouverte. | Deux instances typées, mesures distinctes. |
| `thm:loi_historique` | Équations de loi distributive énoncées abstraitement. | Note d'obligation ouverte. | Types exacts des transformations ; deux diagrammes de cohérence ; préservation par troncature. |
| `thm:troncature_comonade` | Énoncé large pour tout foncteur ; preuve sur papier. | Note d'obligation ouverte. | Typage des équations en `T`, `δ`, `λ` (rang limite) ; récurrence complète ; faits standard séparés du résultat K7PL (séparation : décision de l'autrice, voir [DECISIONS](DECISIONS.md)). |
| `thm:fenetre_grade` | Identification explicitement non démontrée. | Note d'obligation ouverte. | Applications de représentation vers la fenêtre commune et retour ; coïncidence des bornes. |
| `thm:preservation_type` | Bloc composé : préservation par réduction et conjecture d'abaissement MLIR. | Note d'obligation ouverte. La conjecture `thm:abaissement_grades` est déjà un objet distinct (C8.4). | Préservation du noyau et conjecture suivies séparément, avec P2 et P1b. |

## Annexe — inventaire mécanique des énoncés existants, C8.0 (base pré-migration, figée)

Cette annexe reproduit sans modification, hors niveaux de titres, `LEAN-STATEMENT-INVENTORY.md`, supprimé après intégration ([dernière version](https://github.com/AntheaLiles/k7pl/blob/e9b5d2b282117c3bca37787e08819d801b1ef360/docs/tracking/LEAN-STATEMENT-INVENTORY.md)). Elle est **figée** : `scripts/controles/statement_inventory.py` y lit les 69 labels historiques et leurs niveaux (§ 2), et un test en épingle l'empreinte. Ses § 3 à 5 décrivent l'état au moment du relevé, non l'état courant ; la suite est tenue dans « Feuille de route C8 et porte de sortie ».

> **État : instantané historique pré-migration.** Ce relevé décrit la syntaxe héritée au commit de référence ; il ne constitue ni une classification sémantique approuvée, ni une preuve de validité mathématique. À la date de ce relevé, aucun énoncé source n'avait été modifié. La migration ratifiée est maintenant documentée dans le [registre de migration C8](LEAN-STATEMENT-MIGRATION.md).

- Référence du relevé : branche `main`, arbre Git `20a228f137f507aac9b3e8c9f2e1776f29fa635a`.
- Périmètre exploratoire : fichiers `spec/Spec/**/*.lean` contenant des directives `::::thm`.
- Méthode : lecture des directives, extraction des arguments littéraux `label`, `status`, `level`, titre et présence des créneaux `:::statement` / `:::proofsketch`.
- Les lignes désignent le début de la directive dans le fichier au commit de référence. Elles sont des repères historiques et ne correspondent plus nécessairement aux lignes courantes ; la régénération des inventaires courants fait partie du point C8.4.
- `status` est conservé comme **champ historique**, pas comme taxonomie cible. `level` est lui aussi conservé tel quel ; il ne doit pas être assimilé au futur `scope`.
- La présence de `:::proofsketch` indique uniquement une esquisse textuelle. Elle ne prouve pas qu'une preuve soit correcte, ni que Lean vérifie l'énoncé.

### 1. Contrôle de couverture de la base pré-migration

- Énoncés relevés : **69**.
- Fichiers sources recensés : **21**.
- Labels dupliqués dans ce relevé : **0**.
- Créneau `:::proofsketch` : **65 présent**, **4 absent**.

#### Répartition par statut historique

| Statut hérité | Nombre |
|---|---:|
| `conjecture` | 2 |
| `definition` | 2 |
| `exigence` | 4 |
| `proposition` | 18 |
| `theoreme` | 43 |
| **Total** | **69** |

#### Répartition par niveau historique

| Niveau hérité | Nombre |
|---|---:|
| `compilation` | 2 |
| `langage` | 62 |
| `representation` | 5 |
| **Total** | **69** |

#### Répartition par fichier

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

### 2. Inventaire détaillé

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

### 3. Classification sémantique encore requise

Les champs suivants **ne peuvent pas être déduits de façon fiable** du seul ancien `status` ou du titre. Ils restent à examiner occurrence par occurrence à partir du contenu intégral de l'énoncé et de ses dépendances :

- **Nature de l'objet** : résultat K7PL, définition, exigence, axiome/postulat, hypothèse locale, résultat de littérature, exemple/contre-exemple ou autre objet documentaire.
- **Rôle logique/expositif** : théorème, lemme, corollaire, proposition, conjecture, ou rôle différent selon l'ontologie ratifiée.
- **État épistémique** : proposé, en revue, étayé, établi, réfuté ou retiré. Les valeurs héritées ne sont pas automatiquement équivalentes à ces états.
- **Portée (`scope`)** : à déterminer séparément du `level` hérité.
- **Type d'appui** : argument textuel, esquisse de preuve, preuve rédigée complète, preuve Lean vérifiée, référence externe, ou absence d'appui explicite.
- **Hypothèses et dépendances** : prémisses locales, autres énoncés invoqués, références bibliographiques et éventuelle accroche vers `src/`.

Aucune de ces dimensions n'est remplie par inférence dans cet inventaire mécanique. La prochaine étape est une annotation sémantique contrôlée et vérifiée, puis une comparaison avec les compteurs, contrôles et rendus actuels. Le document ne doit pas être utilisé comme autorisation de migrer les énoncés.

### 4. Consommateurs à préserver

Le contrôle des dépendances a identifié au minimum les points suivants :

- `tools/SpecExt/Theorem.lean` : type interne `ThmInfo`, valeurs par défaut, rendu HTML/LaTeX, slot `proofsketch` et compteur partagé `theoreme`.
- `scripts/manuscript_metrics.py` : extraction textuelle des directives et calculs par statut/niveau, y compris la métrique des énoncés « ouverts ».
- `scripts/controles/notation.py` : liste fermée des statuts/niveaux, exigence d'esquisse pour certains objets, interdiction d'esquisse sur les exigences et propagation des références d'énoncés ouverts.
- `scripts/controles/structure.py` : préfixe `thm:`, unicité des labels et vérification des références.
- `scripts/controles/couverture.py` : couverture des énoncés par accroches vers les déclarations Lean et publication des métriques de couverture.

Cette liste est le minimum confirmé par inspection ; les références supplémentaires doivent être recherchées avant C8.2. Les règles existantes ne doivent pas être supprimées avant que leurs équivalents cibles soient testés.

### 5. Limites et contrôles de la présente étape

Ce document a été établi par rapprochement des résultats de recherche GitHub et de la lecture des fichiers sources listés. Il n'a pas encore été régénéré par un script exécuté dans l'environnement du dépôt. Avant de considérer C8.0 clos, il faut :

1. automatiser la génération du relevé depuis l'arbre de travail ;
2. vérifier que les nombres, labels, statuts, niveaux, lignes et slots concordent avec les sources ;
3. vérifier les chemins d'inclusion et rechercher les formes d'énoncés hors de `spec/Spec/**/*.lean` ;
4. faire valider la classification sémantique sans modifier les énoncés ;
5. consigner les exceptions et les dépendances non résolues.
