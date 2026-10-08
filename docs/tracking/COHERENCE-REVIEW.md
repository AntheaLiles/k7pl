<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# K7PL — Coherence review

**Date de la revue :** 2026-10-08  
**Nature :** revue indépendante de cohérence entre les énoncés du dépôt, l'arbre réel, les générateurs, les registres, la CI, les métadonnées publiques et la PR #54.  
**Règle :** ce document transforme la revue en backlog traçable. Il ne constitue pas la résolution des écarts.  
**Source :** rapport d'analyse indépendant fourni le 2026-10-08 ; instantané principal `main` = `da699c89b7881dba1ce091b7f8c15fad9210d615`, PR #54 = `0fab8e563bc96e6d8f9608acee734ba549694d61`.

## Légende

- [ ] **BLOQUANT** — empêche un flux déclaré : CI, fusion ou publication.
- [ ] **MAJEUR** — un artefact actif, une métadonnée publique ou un registre affirme un état contredit par les faits.
- [ ] **MINEUR** — dérive locale, pointeur mort ou métadonnée périmée sans conséquence décisionnelle immédiate.
- [ ] **INFO** — nuance ou risque latent.
- [x] **VÉRIFIÉ** — point de conformité à préserver ; aucune correction attendue.

Les cases restent décochées tant que le correctif n'a pas été réalisé et vérifié. Pour les items INFO de décision, la case n'est cochée qu'après décision explicite et mise en cohérence des artefacts concernés.

## 1. PR #54 — prérequis avant toute fusion

- [x] **G-01 — BLOQUANT.** Corriger le backtick parasite dans `spec/Spec/C3/ReglesDeTypage.lean:1591`, après `{sc}[Sc]`, qui désapparie la syntaxe Verso et fait échouer `lake build Spec`. **Acceptation :** la syntaxe est valide et la CI « Spécification Verso » passe.
- [x] **G-02 — MAJEUR.** Normaliser les environ 106 délimiteurs mathématiques parasites de la PR #54 : remplacer les formes LaTeX `$\`…\`$` / `$$\`…\`$$` par la convention Verso `$\`…\`` / `$$\`…\``. **Acceptation :** aucun délimiteur orphelin sur `spec/Spec/` et rendu PDF/HTML propre.
- [x] **G-03 — MAJEUR.** Corriger les 18 spans contenant des doubles antislashs introduits dans les formules de la PR #54. **Acceptation :** aucun `\\` parasite dans les spans mathématiques concernés et rendu mathématique vérifié.
- [x] **G-04 — MAJEUR.** Rebaser/reconstruire la PR #54 sur le `main` post-réorganisation documentaire et remapper les chemins : `docs/journal/`→`docs/history/`, `docs/suivi/`→`docs/tracking/`, `docs/recherche/`→`docs/research/`, `biblio/`→`docs/bibliography/`. Régénérer `tools/SpecBib.lean`. **Acceptation :** aucun répertoire hérité n'est réintroduit ; mergeable et CI verts.
- [x] **G-05 — MAJEUR.** Répercuter les changements de statuts de la PR dans `docs/tracking/fiches-statuts.csv`, notamment la réouverture de BLOQ-04, puis régénérer les vues. **Acceptation :** CSV, vues générées et contenu scientifique sont cohérents après une nouvelle génération.
- [x] **G-06 — MAJEUR.** Enregistrer dans `spec/CHANGELOG.md` les quatre rétrogradations de sceau et la création de `thm:coherence_usage`, et inscrire leur ratification dans `DECISIONS.md`. **Acceptation :** chaque changement de statut est traçable par une décision et un changelog ; aucune promotion/rétrogradation silencieuse.
- [x] **G-07 — MAJEUR.** Réparer la structure de `questions.md` autour de QA-28/QA-31/QA-32 et ratifier explicitement la réouverture de QA-28, décision d'auteur antérieure. **Acceptation :** structure Markdown intacte, statut des questions cohérent avec doctrine et registre des décisions.
- [x] **G-08 — MINEUR.** Supprimer l'inversion de dépendance par laquelle `main` référence `docs/migration/L1-THEORY-OBJECTS.md`, actuellement fourni seulement par la PR #54. **Acceptation :** toute référence de `main` pointe vers un artefact présent dans `main`, ou son absence est explicitement assumée.

  **Décision :** l'absence dans `main` est explicitement assumée comme dépendance de fusion de PR #54 : le fichier est désormais présent dans la branche reconstruite et sera introduit avec la fusion ; aucun autre artefact actif n'est déplacé vers l'ancien arbre.
- [x] **G-09 — MINEUR.** Documenter le ré-ancrage des sondes sémantiques de `sondes.json` et justifier pourquoi il s'agit d'un affinage du contrôle et non d'un assouplissement. **Acceptation :** l'origine, la raison et l'effet des nouveaux ancrages sont enregistrés.

  **Réalisation :** `coordonnee par coordonnee` → `point par point` et `combiner des analyses independantes` → `combiner plusieurs analyses independantes`. Les clés et la fenêtre de 700 caractères restent inchangées ; les nouveaux passages correspondent au libellé effectivement présent dans l'artefact contrôlé. Le contrôle reste donc aussi strict sur l'ancrage et l'attribution, sans élargissement de la fenêtre ni baisse de précision.
- [x] **G-10 — INFO.** Mettre à jour la narration de la PR #54 (« un seul commit ») et son état CI dès que la branche est stabilisée. **Acceptation :** description et historique de la PR décrivent l'état réellement soumis.

## 2. Vérité des vues et artefacts générés

- [x] **F-01 — MAJEUR.** Rendre `docs/tracking/correspondance-enonces.md` reproductible depuis `spec/`. Trancher la langue des vues générées, l'implanter dans `scripts/suivi.py`, régénérer la vue et éliminer les divergences 67/68, `thm:fenetre_grade`, `thm:troncature_comonade`, `thm:resucrage` et la numérotation. **Acceptation :** une génération depuis l'arbre courant produit exactement le fichier commis.
- [x] **F-02 — MAJEUR.** Rendre `docs/tracking/FICHES-PR02.md` reproductible et conforme à son générateur, notamment pour la langue des statuts. **Acceptation :** `suivi.py all` ne produit aucune différence.
- [x] **F-03 — MAJEUR.** Décider du statut de `docs/tracking/registre-obligations.md` : soit le régénérer depuis `spec/`, soit le requalifier explicitement comme historique et le sortir de la navigation active. **Acceptation :** aucun instantané historique n'est présenté comme registre courant.
- [x] **F-04 — MINEUR.** Supprimer ou réparer les références au « bloc ouverts » du tableau de bord et le code mort `refresh_block()`. **Acceptation :** les pointeurs de suivi correspondent à une fonctionnalité réellement présente.
- [ ] **F-07 — MINEUR.** Corriger `scripts/generate_status.py` pour lire `version := v!"…"` dans `lakefile.lean`. **Acceptation :** `STATUS.md` affiche `0.1.0` au lieu de `unknown`.
- [ ] **F-08 — MINEUR.** Remplacer les quatre faux « faits » de vérification de `STATUS.md` par les résultats réels des jobs, ou reformuler explicitement la valeur comme agrégation. Traiter le cas `skipped == success`. **Acceptation :** chaque ligne de statut représente réellement ce qui a été exécuté sur le commit concerné.


> **Réalisation du lot 2 (2026-10-08).** Les vues `FICHES-PR02.md` et `correspondance-enonces.md` ont été régénérées depuis leurs sources. La CI a effectivement exécuté la garde O4 sur la PR #72 ; sa première exécution a détecté la dérive de la correspondance (69 énoncés dans l'arbre courant contre 68 dans la vue committée), puis la sortie exacte du générateur a été appliquée. Le registre d'obligations est désormais explicitement historique et hors navigation active. `generate_status.py` lit désormais la syntaxe Lake `v!"…"` et le statut CI reçoit les résultats réels des jobs ; F-07/F-08 restent ouverts jusqu'à la régénération effective de `docs/STATUS.md` sur `main`.
### Câblage CI associé

- [x] **F-01/F-02 — O4.** Ajouter en CI `suivi.py check`, régénération et `git diff --exit-code docs/tracking/` lorsque `spec/**` ou `docs/tracking/fiches-statuts.csv` change. **Acceptation :** une vue générée périmée fait échouer la CI.
- [x] **F-29a — MINEUR.** Vérifier que cette garde est effectivement appelée par la CI et pas seulement couverte par des tests unitaires.

## 3. Contrôles morts, non câblés ou trop permissifs

- [ ] **F-05 — MAJEUR.** Câbler `scripts/controles/indexation.py` dans `scripts/controle.py`, ou supprimer le module et sa revendication de contrôle actif. Corriger au passage son mode d'import standalone si le contrôle est conservé. **Acceptation :** l'indexation fait partie de la vérification réellement exécutée.
- [ ] **F-06 — MAJEUR.** Réparer `scripts/ci/check_documentation_architecture.py` : distinguer les chemins hérités réellement interdits des références historiques/légitimes à `archives/`, purger ou annoter les références actives héritées, puis appeler la garde dans la CI. **Acceptation :** la garde passe sur l'arbre réel et détecte effectivement une réintroduction de chemin legacy.
- [x] **F-11 — MINEUR.** Exécuter `scripts/inventory_legacy.py` pour produire `docs/migration/LEGACY-INVENTORY.md`, ou corriger `docs/migration/README.md` pour ne pas prétendre que L0 est établi. **Acceptation :** le registre L0 commis est la sortie réelle du générateur ou le statut est explicitement non établi.

  **Réalisation du lot 3 (en cours de vérification CI).** `indexation.py` est désormais appelé par `scripts/controle.py` et un garde lexical couvre les trois classes de régression G-01/G-02/G-03. La garde d'architecture documentaire est appelée par `verify.yaml` et conserve les répertoires historiques/migration hors du scan ; la revue de cohérence elle-même est explicitement une surface d'audit. L'inventaire L0 reste déclaré non établi tant que le générateur n'a pas été exécuté. Les règles actives et les références des surfaces actives ont été remappées vers `docs/bibliography/`, `docs/tracking/`, `docs/research/`, `docs/method/` et `docs/history/` ; les documents historiques restent exclus de cette garde.
- [ ] **G-01/G-02/G-03 — prévention.** Ajouter dans `scripts/controle.py` un contrôle lexical léger sur parité des backticks, délimiteurs mathématiques Verso et doubles antislashs dans les spans. **Acceptation :** la classe d'erreurs de la PR #54 est détectée avant `lake build Spec`.
- [x] **F-24 — MAJEUR.** Corriger la règle active `.claude/skills/writing-rules.md` qui prescrit `biblio/references.json` ; utiliser `docs/bibliography/references.json` et la commande de génération actuelle. **Acceptation :** aucune instruction active ne recrée l'ancien arbre bibliographique.
- [x] **F-25 — MINEUR.** Nettoyer les autres chemins hérités des surfaces actives : `.claude/rules/project.md`, `spec/CHANGELOG.md`, docstring de `couverture.py`, références security datées, et harmoniser la taxonomie des statuts de validation. **Acceptation :** les références actives sont exactes et les citations historiques sont explicitement traitées comme telles.

## 4. Changelog, anomalies et registres de décision

- [x] **F-09 — MAJEUR.** Réconcilier `spec/CHANGELOG.md` avec l'état réel de l'index : décider du sort de `split/pr10-1`, fusionner ou retirer la revendication `{printindex}`, puis aligner ANOM-09/ANOM-10. **Acceptation :** le changelog ne revendique aucun comportement absent de `main`.
- [x] **F-10 — MINEUR.** Mettre à jour `ANOMALIES.md` : ANOM-09/10, ANOM-04, ANOM-16 et tous les pointeurs morts vers B/C/D/E. **Acceptation :** les statuts d'anomalies, leurs références et les décisions associées décrivent l'état réel.
- [x] **F-12 — MINEUR.** Corriger le lien/libellé de `DASHBOARD.md` pour que la référence à L1-SUIVI corresponde réellement à son contenu. **Acceptation :** le texte du lien décrit le document effectivement ciblé.
- [x] **F-13 — MINEUR.** Corriger `PROJECT-MASTER-PLAN.md` : supprimer/réparer la référence à L1-THEORY-OBJECTS absent de `main` et ne plus maintenir manuellement une baseline SHA présentée comme fait courant. **Acceptation :** baseline et références sont vérifiables automatiquement ou explicitement non dynamiques.
- [x] **F-14 — MINEUR.** Réconcilier `DECISIONS.md` avec les décisions postérieures au 1er octobre, notamment extraction B/C/D, ARB-PR-04, D8 et P1-P6. **Acceptation :** le registre central redevient un point d'entrée fiable des décisions.
- [x] **F-15 — MINEUR.** Résoudre l'écart « 44 primitives » vs 45 entrées DOING relevé par T-68. **Acceptation :** tout document actif présente le cardinal démontré ou le marque explicitement comme hypothèse à vérifier.
- [x] **F-16 — MINEUR.** Corriger les occurrences « trente-quatre règles » et l'incohérence « cinq groupes »/« quatre groupes » dans `ReglesDeTypage.lean`, sur `main` puis dans la PR. **Acceptation :** le texte et les comptes produits par `controle.py` sont cohérents.
- [x] **F-17 — MINEUR.** Décider du sort de `spec/figures/services-lsp.{svg,pdf}` et `sources/services-lsp.drawio`, reliquats non référencés. **Acceptation :** assets supprimés, déplacés vers le prototype historique, ou explicitement inventoriés.
- [x] **F-18 — INFO.** Clarifier dans `spec/CHANGELOG.md` que les comptes 59/38/13/27/7 décrivent un état de conversion historique et non l'état courant, ou dater/segmenter `Unreleased`. **Acceptation :** aucun lecteur ne peut interpréter ces comptes comme les mesures actuelles.

**Réalisation du lot 4 (2026-10-08).** Le changelog distingue désormais l'index courant de ses limitations de rendu ; ANOM-09/10 restent ouvertes comme anomalies distinctes. ANOM-16 est explicitement résolue sans duplication du sous-titre dans les métadonnées. Le registre des décisions documente les états postérieurs au 1er octobre, dont l'extraction B/C/D, ARB-PR-04, D8 et P1–P6. Le registre des primitives établit 45 entrées `DOING`. Les reliquats `services-lsp` recherchés ne sont pas présents dans l'arbre courant. Les formulations obsolètes « trente-quatre règles » / « cinq groupes » ont été retirées de la spécification, et la baseline SHA du master plan est maintenant explicitement non dynamique.

## 5. Métadonnées publiques, release et provenance

- [x] **F-19 — MAJEUR.** Corriger `CITATION.cff` et `zenodo.json` pour ne plus affirmer que chaque exemple est compilé contre une implémentation de référence inexistante. Décrire la limite réelle : spécification contrôlée par Lean, implémentation de référence en cours, couverture de couplage actuelle nulle. **Acceptation :** aucune métadonnée publique ne sur-affirme la conformance.
- [x] **F-20 — MAJEUR.** Élucider et documenter le record Zenodo `10.5281/zenodo.23040451` : archive source GitHub du 2026-09-29, DOI de concept, absence de PDF, indépendance vis-à-vis du flux `sync_zenodo.py`. **Acceptation :** le prochain flux de release sait quel concept/version il doit publier et ne crée pas de collision sémantique avec l'enregistrement existant.
- [x] **F-21 — MINEUR.** Corriger `README.md` : nombre réel d'annexes et portée exacte de la publication Pages. Conserver la mention exacte de l'alpha sans PDF. **Acceptation :** le README décrit l'arbre et le déclencheur de publication réels.
- [x] **F-22 — MINEUR.** Décider si le badge fair-software est calculé ou manuel et aligner son affichage sur le texte « 4 sur 5 » et sur `.howfairis.yml`. **Acceptation :** badge, score revendiqué et mécanisme sont mutuellement cohérents.
- [x] **F-23 — INFO.** Préserver les conformités vérifiées : Pages HTTP 200, badge SWH résolu, DOI résolu vers Zenodo ; ne pas régresser ces pointeurs lors des corrections de métadonnées.
- [x] **F-33 — INFO.** Décider/documenter l'intention de `publication_type: workingpaper` dans `zenodo.json` contre `technicalnote` dans `zenodo.files.json`. **Acceptation :** le type de publication est cohérent ou la distinction est explicitée.

**Réalisation du lot 5 (2026-10-08).** Les métadonnées publiques ne revendiquent plus de conformance entre spécification et implémentation : Lean contrôle la spécification, tandis que le couplage avec l'implémentation reste non revendiqué. `zenodo.json` et `zenodo.files.json` utilisent `technicalnote`. Le DOI `10.5281/zenodo.23040451` est documenté comme enregistrement externe dont le rôle exact doit être vérifié humainement ; le flux ne l'utilise jamais implicitement et exige `ZENODO_CONCEPT_RECID`. Le README corrige le nombre d'annexes (quatre) et la portée de Pages. Le badge fair-software est explicitement manuel à 4/5, avec l'exemption de registre documentée dans `.howfairis.yml`. Les pointeurs DOI, SWH et Pages existants n'ont pas été modifiés.

## 6. Documentation, langue et discipline contributive

- [ ] **F-26 — MINEUR.** Décider si les messages de commit doivent réellement être exclusivement en français. Si oui, outiller le contrôle ; sinon, corriger `CONTRIBUTING.md` et les règles Claude pour assumer le bilinguisme. **Acceptation :** règle et pratique historique sont compatibles.
- [ ] **F-27 — MINEUR.** Décider si #64/#66 nécessitaient une entrée de changelog et, si oui, enregistrer les changements CI manquants. **Acceptation :** la checklist CONTRIBUTING et le changelog sont alignés avec la pratique réelle.
- [ ] **F-28 — INFO.** Corriger la formulation « fusion par rebase » si la politique voulue est seulement l'historique linéaire, puisque le ruleset autorise merge/rebase/squash. **Acceptation :** CONTRIBUTING décrit exactement la politique imposée par GitHub.
- [ ] **F-31 — INFO.** Actualiser ou automatiser la date « Last updated » de `docs/README.md` et harmoniser l'absence de date/version dans `docs/PROVENANCE.md`. **Acceptation :** les métadonnées de fraîcheur suivent une convention unique.
- [ ] **F-32 — INFO.** Harmoniser les deux parcours de lecture déclarés dans `README.md` et `docs/README.md`. **Acceptation :** un seul parcours canonique est publié, ou les différences sont justifiées.

## 7. Hygiène des branches et matériau scientifique non fusionné

- [ ] **F-30 — MINEUR.** Auditer les 18 branches distantes et statuer sur chacune : suppression, archivage, fusion ou abandon explicite. Porter notamment une décision sur `split/pr10-1` et les groupes 3-6, ainsi que sur le matériau scientifique de `claude/lean4-reuse-init-qvzlcg`. **Acceptation :** aucun matériau scientifique unique n'est laissé dans une branche sans statut documenté.
- [ ] **F-09/F-30 — dépendance.** Décider explicitement si le travail `Index.lean` / `{printindex}` de `split/pr10-1` est repris, remplacé ou abandonné. **Acceptation :** `spec/CHANGELOG.md`, ANOM-09/10 et les branches racontent la même histoire.

## 8. Synthèse des garanties CI à préserver

- [x] **Contre-épreuve.** REUSE : 438/438 fichiers conformes, Spec 3.3.
- [x] **Contre-épreuve.** Manifeste : 14 paquets connus et cohérents avec `lakefile`/`lean-toolchain`.
- [x] **Contre-épreuve.** Tests `scripts/ci` : 285 tests OK.
- [x] **Contre-épreuve.** Tests `tests/python` : 38 tests OK.
- [x] **Contre-épreuve.** Contrôles du manuscrit sur `main` : groupes Structure, Algèbre, Notation, Croisement, Sémantique et Couverture verts.
- [x] **Contre-épreuve.** Comptes STATUS de l'instantané : 47 théorèmes, 19 ouverts, 39 formules, 50 règles, 4/4/62 fichiers.
- [x] **Contre-épreuve.** `tools/SpecBib.lean` est identique à la régénération depuis `docs/bibliography/references.json`.
- [x] **Contre-épreuve.** 190 fiches correspondent à 190 statuts.
- [x] **Contre-épreuve.** Questions : 225 entrées, 224 closes, une seule ouverte, cohérente avec `DECISIONS.md`.
- [x] **Contre-épreuve.** Ruleset `main` : CI OK requis, 0 approbation, historique linéaire, pas de bypass.
- [x] **Contre-épreuve.** ANOM-01/05/06/07/08 sont effectivement corrigées dans `spec/`.
- [x] **Contre-épreuve.** Renvois internes du manuscrit : 519 renvois, 0 non résolu.
- [x] **Contre-épreuve.** Flux de release alpha sans PDF : cohérent avec README/CONTRIBUTING/SECURITY et la release GitHub.
- [x] **Contre-épreuve.** Pages et badge SWH accessibles.
- [x] **Contre-épreuve.** Audits sécurité : statuts PARTIAL/PREPARED/BLOCKED assumés, sans fabrication de preuve de reproductibilité.
- [x] **Contre-épreuve.** Workflows décrits : bump Lean mensuel, full quotidien, Scorecard hebdomadaire, cooldown Dependabot, environnement Zenodo, release draft + SHA-256 + Sigstore.
- [x] **Contre-épreuve.** Périmètre annoncé de la PR #54 : pas de modification des singularités et pas de reprise de ∥/spawn.

Ces conformités sont des invariants de non-régression : les corriger ailleurs ne doit pas les dégrader.

## 9. Ordre d'exécution proposé

Cette section ne résout aucun item ; elle fixe seulement les dépendances entre correctifs.

- [ ] **P0 — Fusion PR #54 impossible tant que G-01 est BLOQUANT.**
- [ ] **P1 — Stabiliser G-01/G-02/G-03 puis ajouter leur garde préventive.**
- [ ] **P2 — Rebaser #54 et résoudre G-04 ; ensuite seulement régénérer les vues et statuts G-05.**
- [ ] **P3 — Ratifier les changements scientifiques G-06/G-07 avant de considérer la PR comme scientifiquement stabilisée.**
- [ ] **P4 — Réparer F-01/F-02/F-03/F-04 et câbler O4 ; la vérité des artefacts générés devient une propriété de CI.**
- [ ] **P5 — Câbler F-05/F-06 et produire L0 ; aucune garde annoncée comme active ne doit rester morte.**
- [ ] **P6 — Réparer F-07/F-08 et les registres F-10/F-11/F-12/F-13/F-14/F-15/F-16/F-17.**
- [ ] **P7 — Nettoyer les métadonnées publiques F-19/F-20/F-21/F-22/F-33 avant toute release.**
- [ ] **P8 — Statuer sur F-26/F-27/F-28/F-30/F-31/F-32 et fermer les branches/workstreams sans statut.**
- [ ] **P9 — Rejouer la contre-épreuve de la section 8 après chaque lot majeur.**

## 10. Critère de clôture de la revue

La revue ne sera considérée comme clôturée que lorsque :

- [ ] tous les BLOQUANTS sont résolus et vérifiés ;
- [ ] tous les MAJEURS ont un correctif vérifié ou une décision d'abandon explicitement ratifiée ;
- [ ] les MINEURS ont été corrigés, requalifiés ou acceptés avec justification ;
- [ ] les INFO ont reçu une décision lorsqu'ils impliquent une politique ou une affirmation publique ;
- [ ] les vues déclarées générées sont effectivement reproductibles ;
- [ ] les contrôles annoncés comme actifs sont réellement câblés et verts ;
- [ ] les métadonnées publiques ne sur-affirment plus la réalité du projet ;
- [ ] la PR #54, si elle est maintenue, est rebasée sur l'architecture courante, scientifiquement tracée et CI-verte ;
- [ ] la contre-épreuve de non-régression de la section 8 reste verte.

## 11. Index de correspondance

| ID | Domaine | Sévérité |
|---|---|---|
| F-01 | vues générées | MAJEUR |
| F-02 | vues générées | MAJEUR |
| F-03 | registre obligations | MAJEUR |
| F-04 | pointeurs dashboard | MINEUR |
| F-05 | contrôle indexation | MAJEUR |
| F-06 | garde architecture | MAJEUR |
| F-07 | statut version | MINEUR |
| F-08 | statut CI | MINEUR |
| F-09 | changelog/index | MAJEUR |
| F-10 | anomalies | MINEUR |
| F-11 | migration/L0 | MINEUR |
| F-12 | dashboard | MINEUR |
| F-13 | master plan | MINEUR |
| F-14 | décisions | MINEUR |
| F-15 | primitives/T-68 | MINEUR |
| F-16 | règles de typage | MINEUR |
| F-17 | assets figures | MINEUR |
| F-18 | changelog comptes | INFO |
| F-19 | métadonnées conformance | MAJEUR |
| F-20 | Zenodo | MAJEUR |
| F-21 | README/release | MINEUR |
| F-22 | fair-software | MINEUR |
| F-23 | DOI/SWH/Pages | INFO |
| F-24 | bibliographie | MAJEUR |
| F-25 | chemins hérités | MINEUR |
| F-26 | langue commits | MINEUR |
| F-27 | changelog CI | MINEUR |
| F-28 | politique merge | INFO |
| F-29 | garanties CI | MINEUR |
| F-30 | branches/workstreams | MINEUR |
| F-31 | fraîcheur docs | INFO |
| F-32 | parcours lecture | INFO |
| F-33 | type Zenodo | INFO |
| F-34 | incohérence historique | INFO |
| G-01 | syntaxe Verso | BLOQUANT |
| G-02 | délimiteurs math | MAJEUR |
| G-03 | doubles antislashs | MAJEUR |
| G-04 | migration chemins PR | MAJEUR |
| G-05 | vues PR/CSV | MAJEUR |
| G-06 | sceaux/ratisation | MAJEUR |
| G-07 | QA/Markdown | MAJEUR |
| G-08 | dépendance main/PR | MINEUR |
| G-09 | sondes sémantiques | MINEUR |
| G-10 | narration PR | INFO |

**Total : 44 écarts F-01…F-34 et G-01…G-10, plus 20 points de contre-épreuve/invariants CI.**
