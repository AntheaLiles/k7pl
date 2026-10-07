# Tableau de bord — le manuscrit et ce qu'il reste avant l'implémentation

**État au 6 octobre 2026.** Point d'entrée unique du suivi : il remplace `PR-02-AVANCEMENT`, `todo-manuscrit`, `plan` et les autres documents de suivi, archivés dans [`../historique/`](../historique/). Les chiffres des blocs gris sont **produits** par `python3 scripts/suivi.py dashboard` (à partir de `spec/` et de [`fiches-statuts.csv`](fiches-statuts.csv)) ; le reste est de la prose, à tenir à la main.

Lecture en trois temps : [1. où en est le manuscrit](#1-où-en-est-le-manuscrit) · [2. ce qu'il reste à faire](#2-ce-quil-reste-à-faire-avant-limplémentation-lean-4) · [3. ce qui menace la suite](#3-ce-qui-menace-la-suite).

Ce tableau a été établi **sans exécuter l'ancien outillage** : les comptes viennent du Verso, l'état des fiches des comptes rendus de séance (voir [`DECISIONS.md`](DECISIONS.md) pour ce qui n'a pas été rapproché).

---

## 1. Où en est le manuscrit

La spécification est désormais **un projet Verso** (`spec/`), compilé par `lake build` et rendu en HTML (`lake exe spec`) et en PDF (Tectonic). Sa source de référence est le Verso ; l'ancien manuscrit Org-mode est figé dans [`../../archives/manuscrit-org/`](../../archives/manuscrit-org/). La conversion est fidèle : aucun texte n'a été corrigé (voir [`../../scripts/org2verso/`](../../scripts/org2verso/)).

### Mesures du manuscrit

<!-- BEGIN:mesures -->
| Mesure | Valeur |
|---|---|
| Chapitres | 9 (dont 1 annexes) |
| Sections de niveau 2 (modules) | 52 |
| Énoncés | 72 (49 theoreme, 15 proposition, 4 exigence, 2 conjecture, 2 definition) |
| Énoncés ouverts (proposition, conjecture, exigence) | 21 |
| Énoncés par niveau | 65 langage, 5 representation, 2 compilation |
| Formules | 46 |
| Figures | 12 |
| Tableaux | 32 |
| Codes sources | 6 |
| Remarques marginales (RMQ) | 60 |
| Citations | 365 |
| Œuvres citées | 253 |
| Renvois internes | 628 |
| Renvois non résolus | 0 |
| Commentaires d'auteur conservés (non rendus) | 0 |
| Notes de bas de page | 6 |
| Mots (approximatif, hors code et formules) | 134766 |
<!-- END:mesures -->

Ces nombres sont recoupés par le manuscrit lui-même : « cinquante règles de typage » et « quarante-six constructeurs » (§3.1) sont écrits en toutes lettres et ne sont pas contredits par le reste.

### Énoncés ouverts

Un énoncé est *ouvert* quand son sceau n'est pas « théorème » ou « définition » : il dit ce qu'il tient et ce qu'il ne tient pas encore. Leur nombre **monte** à mesure que la campagne corrige — c'est voulu (un énoncé qui promettait trop dit désormais ce qu'il tient).

<!-- BEGIN:ouverts -->
| Étiquette | Statut | Niveau | Lieu | Renvois |
|---|---|---|---|--:|
| `thm:fenetre_grade` | proposition | langage | §2.3 | 0 |
| `thm:divulgation_delimitee` | proposition | langage | §2.4 | 5 |
| `thm:determinisme_observationnel` | conjecture | langage | §2.5 | 0 |
| `thm:completude_graduee` | proposition | langage | §3.1 | 0 |
| `thm:completude_verificateur` | exigence | compilation | §3.1 | 0 |
| `thm:homomorphisme_roues` | proposition | representation | §3.2 | 3 |
| `thm:representation_inobservable` | exigence | representation | §3.2 | 0 |
| `thm:coherence_subsomption` | proposition | langage | §3.6 | 6 |
| `thm:isomorphisme_memoire` | proposition | representation | §4.3 | 7 |
| `thm:introduction_unique` | proposition | langage | §4.4 | 0 |
| `thm:rejeu_binaire` | proposition | representation | §4.5 | 2 |
| `thm:revocation_ffi` | exigence | representation | §4.5 | 0 |
| `thm:traduction_metalangage` | proposition | langage | §4.6 | 11 |
| `thm:simulation` | proposition | langage | §4.6 | 2 |
| `thm:fidelite_interprete` | proposition | langage | §4.6 | 3 |
| `thm:correspondance_niveaux` | proposition | langage | §4.7 | 0 |
| `thm:relation_produit` | proposition | langage | §4.7 | 0 |
| `thm:chaine_fils` | proposition | langage | §4.8 | 2 |
| `thm:hygiene_graduee` | proposition | langage | §5.2 | 0 |
| `thm:resucrage` | exigence | langage | §5.2 | 0 |
| `thm:abaissement_grades` | conjecture | compilation | §6.2 | 4 |
<!-- END:ouverts -->

Registre complet, avec les renvois : [`correspondance-enonces.md`](correspondance-enonces.md). Registre des dépendances sur du non acquis : [`registre-obligations.md`](registre-obligations.md) (instantané du 1er octobre, à regénérer — voir §3).

### La campagne PR-02 en chiffres

Six relectures, un méta-relecteur, trois études annexes : **190 lignes de suivi** (127 fiches, 27 réécritures, 29 vérifications bibliographiques, 7 arbitrages). État par lot :

<!-- BEGIN:fiches -->
| Lot | Fiches | ✅ fermées | 🟡 partielles | ⏳ à ratifier | ❓ décision | ⛔ écartées | ⬜ ouvertes |
|---|--:|--:|--:|--:|--:|--:|--:|
| `BLOQ` Bloquants | 14 | 11 | 2 | 1 | 0 | 0 | 0 |
| `STRUCT` Structurels | 23 | 19 | 0 | 4 | 0 | 0 | 0 |
| `PORT` Portée | 17 | 17 | 0 | 0 | 0 | 0 | 0 |
| `PREUVE` Dettes de preuve | 16 | 9 | 5 | 1 | 0 | 0 | 1 |
| `NOTA` Notation, comptes, renvois | 8 | 8 | 0 | 0 | 0 | 0 | 0 |
| `IMPL` Implémentation et outillage | 9 | 6 | 1 | 2 | 0 | 0 | 0 |
| `FACT` Factorisations à écrire | 24 | 18 | 1 | 3 | 0 | 2 | 0 |
| `REFUS` Factorisations refusées | 7 | 7 | 0 | 0 | 0 | 0 | 0 |
| `REECR` Réécritures d'énoncés | 27 | 27 | 0 | 0 | 0 | 0 | 0 |
| `BIB` Vérifications bibliographiques | 29 | 22 | 6 | 0 | 0 | 0 | 1 |
| `TRANS` Refontes transversales | 9 | 7 | 0 | 2 | 0 | 0 | 0 |
| `ARB-PR` Arbitrages | 7 | 5 | 0 | 2 | 0 | 0 | 0 |
| **Total** | **190** | **156** | **15** | **15** | **0** | **2** | **2** |
<!-- END:fiches -->

Détail fiche par fiche : [`FICHES-PR02.md`](FICHES-PR02.md). **Comment lire « ouverte »** : aucun compte rendu de séance ne nomme la fermeture de la fiche. L'auteur a pu fermer sans consigner ; l'état est volontairement conservateur et se corrige dans `fiches-statuts.csv`. Les fermetures *déduites* (changement de statut d'un énoncé rapproché du texte de la fiche) sont marquées comme telles et sont à confirmer.

### Les six vagues du plan, aujourd'hui

Le plan de traitement ([`pr-02-plan-de-traitement.md`](pr-02-plan-de-traitement.md), 30 septembre) ordonnait six vagues. Leur état au 6 octobre 2026 :

| Vague | Contenu | État |
|---|---|---|
| 0 | sceau à deux axes, registre des obligations, table des symboles, comptes produits | ✅ close |
| 1 | fondations algébriques : ℛ, ⊖, `BLOQ-03`, `BLOQ-06` | ✅ close |
| 2 | périmètre du noyau (D-1, voie 2 : formaliser la couche 2) | ✅ décidée et écrite |
| 3 | remontées, sémantique primitive, ordre de préservation | 🟡 les bloquants sont tous corrigés dans le Verso ; trois restent partiels (`BLOQ-05`, `-07`, `-12`), chacun suspendu à une preuve ou à une décision |
| 4 | dettes de preuve et factorisations | 🟡 `FACT` et `PREUVE` : énoncés nets partout, preuves conduites nulle part de bout en bout ; voir [`RESTE-A-FAIRE.md`](RESTE-A-FAIRE.md) |
| 5 | réécriture des énoncés (`REECR`) | ✅ 26 sur 27 closes ; `REECR-16` attend la numérotation de la phase d'expansion (`STRUCT-06`) et la figure 11 |

L'annexe E est fondue dans le manuscrit depuis le 1er octobre (`STRUCT-23`) : les annexes restantes sont A à D.

---

## 2. Ce qu'il reste à faire avant l'implémentation Lean 4

**La vue à jour est [`RESTE-A-FAIRE.md`](RESTE-A-FAIRE.md)** : toutes les fiches non closes, classées par nature du travail (décision, ratification, conception, preuve, rédaction, outillage, recherche), avec leur avancement estimé, leur prochaine étape et ce dont elles dépendent. Elle est produite par `python3 scripts/suivi.py reste` à partir de `fiches-statuts.csv`. Ce qui suit en donne la lecture d'ensemble.

### A. Ce qui demande votre décision

Détail et sources : [`DECISIONS.md`](DECISIONS.md) (tranchées, à ratifier, en attente, une ligne par décision). **Analyses détaillées face au manuscrit de chaque élément à trancher** (demande de l'auteur du 6 octobre) : [`analyses-decisions/`](../recherche/analyses-decisions/README.md). **Tranchées** : socle modal et gradué (`ARB-PR-07`), préservation graduée comme objectif (`ARB-PR-06`), première release en P6 avec `T-68` juste avant, annexe E fondue, `BLOQ-05` et `BLOQ-07` (options validées), troncature additive, et les décisions de l'auteur de la séance 32 (numérotation des phases, singularités, grammaires, index et interface HTML, vocabulaire en bloc). **Appliquées, à ratifier** : `ARB-PR-04` (voie B puis C), `IMPL-07`, `IMPL-04`, `STRUCT-16`, `FACT-12`, `FACT-14`, `STRUCT-01`, `PREUVE-05` (loi affaiblie), `D-7` (bandeau « esquisse »), les schémas de `ANOM-17`, et, séance 32, `STRUCT-06` (phases 0 à 10), `BLOQ-12` (`∘` et `δ`), les grammaires de `ANOM-17`, `ANOM-09` et `ANOM-10`, `PREUVE-04`, `TRANS-02`, `TRANS-06`, `FACT-09` ; en plus de `ARB-PR-03`, `STRUCT-05` / `TRANS-04` et des sept fermetures déduites.

**Ce qui attend réellement** (la question exacte est dans `DECISIONS.md`) :

| | Question | Pourquoi |
|---|---|---|
| `ANOM-17` | `spawn` : bifurcation par maillon pour le fil de temps ? Étude comparative écrite, sans choix : [`etude-spawn-fil-de-temps`](../recherche/etude-spawn-fil-de-temps.md) | étend le système de sortes et le gestionnaire ; même question pour l'application |
| `ANOM-17` | `∥` : fourche-jointure ou entrelacement par branche ? Étude comparative écrite, sans choix : [`etude-parallele-fourche-entrelacement`](../recherche/etude-parallele-fourche-entrelacement.md) (à lire en premier : elle conditionne `spawn`) | trace partielle dès la couche 3 |
| `T-68` | ratifier **en bloc** la proposition de [`t68-vocabulaire-en-bloc`](../recherche/t68-vocabulaire-en-bloc.md) (table de renommage prête : [`t68-table-de-renommage`](t68-table-de-renommage.md) ; **analyse détaillée face au manuscrit** : [`t68-vocabulaire-face-au-manuscrit`](../recherche/analyses-decisions/t68-vocabulaire-face-au-manuscrit.md)) | **avant-dernier** dans l'ordre de finition : le renommage vient après la ratification |

Et la **validation des statuts déduits** dans `fiches-statuts.csv` (`confiance = deduite`).

### B. Ce qui se poursuit sans décision

Par ordre de rendement ; chaque ligne renvoie à ses fiches dans [`RESTE-A-FAIRE.md`](RESTE-A-FAIRE.md).

1. **Preuves à écrire.** Les énoncés sont nets ; manquent les clauses de traduction (`PREUVE-07`), le facteur budget (`PREUVE-11`), l'élimination de l'arène (`PREUVE-12`, `BLOQ-09`), la vérification de la troncature pour chaque conteneur (`PREUVE-08`).
2. **Travaux de conception** : la loi distributive et la gradation indexée (`PREUVE-05`, `-06`, `STRUCT-20`, `-21`), puis les refontes `TRANS` ; ce sont eux qui bloquent le plus de fiches en aval.
3. **Recherches** : 19 fiches `BIB` à instruire en lisant le corps des articles ; elles se mènent en parallèle.
4. **Outillage** : arités effectives et table code ⟷ prémisse (`IMPL-08`, `FACT-09`) ; non-régression bibliographique et mesure de la prose à porter.

### C. L'ouvrage de reprise, hors fiches

* **Les anomalies relevées par l'audit de la conversion** : [`ANOMALIES.md`](ANOMALIES.md). Les anomalies du manuscrit ont été corrigées dans le Verso depuis le 1er octobre ; restent `ANOM-04` (annexes squelettiques : bandeau « esquisse » posé, à ratifier), `ANOM-09` et `-10` (outils extérieurs, non bloquantes) et `ANOM-17` (couverture de la relation de réduction : partielle).
* **Regénérer le PDF de référence.** Le PDF `main.pdf` hérité date du 9 septembre ; les fiches citent ses numéros de pages et d'énoncés. Le PDF courant est produit par la CI (`spec-pdf`) ; la table de correspondance [`correspondance-enonces.md`](correspondance-enonces.md) relie les numéros d'alors aux numéros d'aujourd'hui.

### D. Portes proposées avant de passer à l'implémentation

Critères de sortie suggérés — à ajuster :

| Porte | Critère | Mesure | État |
|---|---|---|---|
| P1 | plus aucun bloquant ouvert | lot `BLOQ` : 0 ouverte | 🟡 11 fermées, 3 partielles (`BLOQ-05` et `-07` suspendues à `PREUVE-03` et `-07` ; `BLOQ-12` à la définition de `∘` et `δ`) |
| P2 | tout énoncé ouvert a sa route et son hypothèse nommées, et aucune prose ne le dit acquis | `scripts/controle.py` (propagation) | ✅ contrôle vert |
| P3 | décisions `ARB-PR-03`, `-04`, `-06`, `-07` tranchées ou ratifiées | [`DECISIONS.md`](DECISIONS.md) | 🟡 `-06`, `-07` tranchées ; `-03` et `-04` appliquées, à ratifier |
| P4 | les huit exigences `IMPL` sont lues comme un cahier des charges de l'implémentation | lot `IMPL` : 0 ouverte, ou reportées avec motif | 🟡 6 fermées, 2 à ratifier (`IMPL-04`, `-07`), `IMPL-08` partielle (outil) |
| P5 | `REECR` appliqué, anomalies levées, relecture d'ensemble faite | lot `REECR` : 0 ouverte ; [`ANOMALIES.md`](ANOMALIES.md) sans anomalie ouverte | 🟡 `REECR` 26/27 ; anomalies : `ANOM-04`, `-09`, `-10`, `-17` ; relecture d'ensemble à faire |
| `T-68` | vocabulaire des primitives choisi (avant-dernier dans l'ordre de finition, juste avant P6) | [`primitives.md`](primitives.md) | ⬜ proposition préparée, rien n'est renommé |
| P6 | première version publiée de la spécification | release `spec-v0.1.0` (PDF archivé sur Zenodo) | ⬜ après P1 à P5 et `T-68` ; décidée le 1er octobre |

---

## 3. Ce qui menace la suite

### Le filet de contrôles : porté sur le Verso

Le Verso fait foi depuis le 1er octobre 2026 (décision `D-5`). Les contrôles de l'ancien outillage lisaient le Org ; ils sont **portés en Python** dans [`scripts/controles/`](../../scripts/controles/) et lancés par `python3 scripts/controle.py` (aussi en CI, job `build`) :

| Module | Ce qu'il garde |
|---|---|
| `algebre` | la loi d'action aux bornes (0 et ω, 216 triplets, auto-test : les deux mauvaises définitions de ⊖ échouent avec 10 et 14 contre-exemples), l'action à travers ∥, les quatre égalités de ω, les deux sortes de tailles |
| `notation` | Δ seul contexte, un glyphe par modalité, affirmations sur le hachage, sceau des énoncés (statut, niveau, esquisse), propagation des énoncés ouverts, routes des engagements, table normative |
| `croise` | grammaire des termes × règles de typage × liste des primitives ; comptes (50 règles, 46 constructeurs) |
| `structure` | renvois résolus, étiquettes uniques et bien préfixées, lettres d'annexe jamais écrites en dur, tableaux réguliers, aucun commentaire d'auteur enfoui, glossaire |

Déjà assurés par le rendu : renvois et clés bibliographiques (une étiquette ou une clé absente fait échouer `lake exe spec`). Le module `semantique` porte les 17 sondes (un passage cite-t-il le bon auteur : à son premier passage il a trouvé une citation perdue par la réécriture du théorème de divulgation délimitée, rétablie), le vocabulaire de l'axiome et l'interdiction des citations numériques écrites à la main. **Pas encore portés** : le gel de non-régression bibliographique et la mesure de la prose contre la charte. Rappel : un contrôle qui n'a jamais été vu échouer ne vaut rien ; `algebre` s'auto-teste, les autres se mutent à la main (retirer un sceau, écrire « démontre » près d'un énoncé ouvert).

### Où écrire pendant la finition

Dans `spec/` (Verso) ; le convertisseur `scripts/org2verso` ne sert plus qu'à rejouer l'instantané Org archivé.

### Publication

* **Fusionner la branche déploie le vrai manuscrit sur GitHub Pages.** Avant ce changement, le site présentait des chapitres d'exemple.
* Une release `spec-vX.Y.Z` archive le PDF sur Zenodo (workflow `lean.yaml`, job `zenodo`). La première version ne doit partir qu'avec une décision explicite (porte P6).

---

## Tenir ce tableau à jour

```sh
python3 scripts/suivi.py check       # la table des statuts couvre toutes les fiches, et elles seules
python3 scripts/suivi.py all         # regénère FICHES-PR02.md, correspondance-enonces.md et les blocs ci-dessus
python3 scripts/manuscript_metrics.py summary     # mesures du manuscrit
```

À chaque séance : mettre à jour `fiches-statuts.csv` (une ligne par fiche, avec la preuve : le compte rendu de séance), lancer `suivi.py all`, relire la prose des sections 1 à 3, consigner la séance dans [`../journal/`](../journal/).
