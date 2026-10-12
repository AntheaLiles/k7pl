<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# L1 — extraction propositionnelle du corpus suivi

État : **IN PROGRESS**.

Ce registre qualifie les propositions issues des 13 sources historiques de docs/suivi/, désormais représentées dans les emplacements courants classés (principalement docs/tracking/). Il ne déplace ni ne réécrit les sources. Les instantanés historiques, propositions, hypothèses et contradictions ne sont pas promus comme faits courants. Réconciliation ciblée effectuée le 2026-10-11 contre `main` @ `86959948ff36deb6e8ee0985cf22740787696720`, puis contre la candidate PR #153 @ `9c34e7aaa99e00809c00d56812ab2160b55c276d` (run CI `38131422345`, succès). L1 reste IN PROGRESS : les trois anomalies ciblées ne remplacent pas la revue propositionnelle complète des 13 sources.

| Source | Propositions / faits migrables | Destination | État | Action |
|---|---|---|---|---|
| DECISIONS.md | D-1 : voie 2, formalisation de la couche 2. Les décisions et ratifications historiques doivent être distinguées des états courants ; D-7 reste ouvert dans le registre central. Les lignes « décisions postérieures » n'équivalent pas à une ratification de l'autrice. | ARCHITECTURE / RESEARCH / ASSURANCE | décision historique + ouvert | comparer les décisions pertinentes à la source courante et conserver les désaccords |
| DECISIONS.md | ARB-PR-07 est dit tranché vers la famille modale et graduée ; ARB-PR-06 est simultanément dit arrêté et encore soumis à décision ; D-8 est dit décidé mais l'anomalie source le donne encore à décider. | ASSURANCE | contradiction | ne pas promouvoir avant réconciliation |
| TABLEAU-DE-BORD.md | Verso = source courante ; Org = archive. Les métriques et blocs générés doivent rester générés. Les énoncés ouverts ne doivent pas être décrits comme acquis. | ARCHITECTURE / METHOD / STATUS / ASSURANCE | décision + fait généré | vérifier contre outils actuels |
| TABLEAU-DE-BORD.md | P1–P6 sont proposés comme portes : aucun bloquant, routes/hypothèses explicites, arbitrages tranchés, IMPL explicite, réécritures/anomalies closes, release. | ASSURANCE / METHOD | proposition | conserver comme candidat, pas comme norme ratifiée |
| FICHES-PR02.md | Registre détaillé des arbitrages, preuves, factorisations, réécritures, bibliographie et refontes. ARB-PR-03 à ratifier, ARB-PR-04 décision ; ARB-PR-05/06/07 déclarés fermés. Plusieurs REECR sont seulement déduites. | peer-review / ASSURANCE | provenance + statuts | réconcilier avec DECISIONS |
| registre-obligations.md | Instantané Org du 1er octobre ; 9 énoncés ouverts et une dépendance explicite lemme_fondamental → divulgation_delimitee. Règle : le statut faible se propage aux dépendants. | ASSURANCE / archive | historique + règle | comparer aux générateurs actuels |
| registre-empirique.md | G-01 et G-05 sont des protocoles définis, pas des résultats ; G-06 requalifie les bornes matérielles comme relatives à un profil ; G-02, G-07–G-12 sont des travaux futurs. | RESEARCH / ASSURANCE | protocole / agenda | distinguer protocole et mesure |
| hypotheses-de-module.md | Hypothèses de formalisation : totalité de operation, abaissement d'arène, D_det, Sim, traduction temporelle, E_repro et profil Π. Obstacles : métathéorie multi-sortes, type de chemin cubique, absence de certificat du solveur, transposition Agda. | ASSURANCE / RESEARCH | hypothèse / limitation | tracer vers modules et preuves |
| factorisations-refusees.md | Sept factorisations refusées. Le cas général documenté : même forme ne suffit pas ; ce sont les obligations qui justifient une factorisation. REFUS-05 fournit un contre-exemple d'unification erronée des tailles. | METHOD / ASSURANCE / archive | preuve + méthode | conserver comme corpus adversarial |
| Registre d'anomalies de conversion (retiré le 2026-10-12) | Le croisement avec `main` confirme : les renvois normatifs B/C/D sont retirés ; le code d'index et sa garde CI sont présents ; le glossaire contient les trois entrées de couche ; la traduction des chaînes HTML/JS prises en charge et ses tests sont présents. Le rendu visuel cité historiquement a été inspecté sur la candidate PR #153, pas sur le SHA actuel de `main`. D-7 reste un choix éditorial de l'autrice ; l'API upstream de locale est une amélioration séparée, non implémentée. | `docs/migration/L1-DECISIONS.md`; `docs/migration/L5-VALIDATION.md`; `docs/tracking/DECISIONS.md`; archive | audit de conversion / preuve / décision | statut historique réconcilié ; ne pas réutiliser les anciennes coches comme validation courante | source retirée du suivi actif, éléments conservés dans leurs registres d'origine |
| primitives.md | Inventaire des noms, symboles, familles, règles et candidats. La source courante déclare 45 entrées `DOING` au 2026-10-08 ; « 44 » est un cardinal historique, non une démonstration du nombre de primitives normatives. Les noms temporels restent à arbitrer. | ARCHITECTURE / RESEARCH | inventaire / ouvert | reconstruire le cardinal depuis la grammaire, les règles, obligations et constructions dérivées/refusées ; ne pas présupposer 44 ni assimiler les 45 lignes à 45 primitives |
| primitives.md | Le vecteur est traité comme type dérivé ; la coalgèbre terminale comme primitive avec règles à écrire ; fix comme point fixe borné sur treillis fini ; codéréliction écartée sous hypothèses de modèle. La règle when du diamant est jugée trop permissive et sa réparation offre trois options. | ARCHITECTURE / ASSURANCE | décisions + dette | vérifier contre spec ; décision auteur requise pour when |
| DECISIONS.md / FICHES-PR02.md | Des états historiques peuvent encore se contredire pour ARB-PR-06 et ARB-PR-07 ; les anciens comptes doivent être recalculés depuis les sources courantes. D-8 n'est plus un résidu : les trois entrées de couche sont présentes dans la source du glossaire. | ASSURANCE | contradiction historique + fait courant | réconcilier les deux décisions proposition par proposition ; ne pas extrapoler les anciens comptes |

## Contradictions détectées

1. ARB-PR-06 est fermé dans FICHES-PR02 mais encore soumis à décision dans DECISIONS/TABLEAU-DE-BORD ; cette contradiction reste à rapprocher proposition par proposition.
2. ARB-PR-07 est fermé dans FICHES-PR02 et DECISIONS mais apparaît encore à ratifier dans TABLEAU-DE-BORD ; aucun changement de statut n'est inféré par la migration seule.
3. D-8 est maintenant appliqué dans `spec/Spec/Refs/ListeDesGlosses.lean` : les entrées `couche 1`, `couche 2` et `couche 3` sont présentes ; la contradiction de statut de l'ancien registre est historique.
4. D-7/ANOM-04 est une contradiction de statut substantielle : L1-DECISIONS affirmait une décision arrêtée, alors que docs/tracking/DECISIONS.md maintient le choix des annexes ouvert. Ce dossier qualifie l'affirmation antérieure de non ratifiée et remet la décision à l'autrice.
5. Le registre historique des obligations ne doit pas être opposé aux comptes générés depuis spec/ sans recalculer les énoncés au SHA courant.
6. Les statuts déduits doivent conserver leur niveau de confiance et ne pas devenir des faits établis par simple migration.

## Critère de sortie L1

Chaque source doit avoir été qualifiée au niveau propositionnel ; chaque proposition courante doit avoir une destination et une provenance ; les éléments historiques, hypothétiques, ouverts, obsolètes ou contradictoires doivent rester explicitement classés.

La prochaine opération sans décision auteur est le rapprochement des propositions « à vérifier » avec ARCHITECTURE, RESEARCH, METHOD, ASSURANCE et spec/. Aucune réécriture normative ne doit précéder ce rapprochement.
