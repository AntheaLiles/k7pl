# Tableau de bord — le manuscrit et ce qu'il reste avant l'implémentation

**État au 1er octobre 2026.** Point d'entrée unique du suivi : il remplace `PR-02-AVANCEMENT`, `todo-manuscrit`, `plan` et les autres documents de suivi, archivés dans [`../historique/`](../historique/). Les chiffres des blocs gris sont **produits** par `python3 scripts/suivi.py dashboard` (à partir de `spec/` et de [`fiches-statuts.csv`](fiches-statuts.csv)) ; le reste est de la prose, à tenir à la main.

Lecture en trois temps : [1. où en est le manuscrit](#1-où-en-est-le-manuscrit) · [2. ce qu'il reste à faire](#2-ce-quil-reste-à-faire-avant-limplémentation-lean-4) · [3. ce qui menace la suite](#3-ce-qui-menace-la-suite).

Ce tableau a été établi **sans exécuter l'ancien outillage** : les comptes viennent du Verso, l'état des fiches des comptes rendus de séance (voir [`DECISIONS.md`](DECISIONS.md) pour ce qui n'a pas été rapproché).

---

## 1. Où en est le manuscrit

La spécification est désormais **un projet Verso** (`spec/`), compilé par `lake build` et rendu en HTML (`lake exe spec`) et en PDF (LuaLaTeX). Sa source de référence est le Verso ; l'ancien manuscrit Org-mode est figé dans [`../../archives/manuscrit-org/`](../../archives/manuscrit-org/). La conversion est fidèle : aucun texte n'a été corrigé (voir [`../../scripts/org2verso/`](../../scripts/org2verso/)).

### Mesures du manuscrit

<!-- BEGIN:mesures -->
| Mesure | Valeur |
|---|---|
| Chapitres | 12 (dont 4 annexes) |
| Sections de niveau 2 (modules) | 52 |
| Énoncés | 67 (46 theoreme, 13 proposition, 4 exigence, 2 conjecture, 2 definition) |
| Énoncés ouverts (proposition, conjecture, exigence) | 19 |
| Énoncés par niveau | 60 langage, 5 representation, 2 compilation |
| Formules | 38 |
| Figures | 13 |
| Tableaux | 27 |
| Codes sources | 7 |
| Remarques marginales (RMQ) | 59 |
| Citations | 359 |
| Œuvres citées | 250 |
| Renvois internes | 525 |
| Renvois non résolus | 0 |
| Commentaires d'auteur conservés (non rendus) | 0 |
| Notes de bas de page | 6 |
| Mots (approximatif, hors code et formules) | 124185 |
<!-- END:mesures -->

Ces nombres sont recoupés par le manuscrit lui-même : « quarante-neuf règles de typage » et « quarante-cinq constructeurs » (annexe E) sont écrits en toutes lettres et ne sont pas contredits par le reste.

### Énoncés ouverts

Un énoncé est *ouvert* quand son sceau n'est pas « théorème » ou « définition » : il dit ce qu'il tient et ce qu'il ne tient pas encore. Leur nombre **monte** à mesure que la campagne corrige — c'est voulu (un énoncé qui promettait trop dit désormais ce qu'il tient).

<!-- BEGIN:ouverts -->
| Étiquette | Statut | Niveau | Lieu | Renvois |
|---|---|---|---|--:|
| `thm:troncature_comonade` | proposition | langage | §2.3 | 1 |
| `thm:divulgation_delimitee` | proposition | langage | §2.4 | 4 |
| `thm:determinisme_observationnel` | conjecture | langage | §2.5 | 0 |
| `thm:completude_graduee` | proposition | langage | §3.1 | 0 |
| `thm:completude_verificateur` | exigence | compilation | §3.1 | 0 |
| `thm:homomorphisme_roues` | proposition | representation | §3.2 | 1 |
| `thm:representation_inobservable` | exigence | representation | §3.2 | 0 |
| `thm:coherence_subsomption` | proposition | langage | §3.6 | 3 |
| `thm:isomorphisme_memoire` | proposition | representation | §4.3 | 6 |
| `thm:introduction_unique` | proposition | langage | §4.4 | 0 |
| `thm:rejeu_binaire` | proposition | representation | §4.5 | 1 |
| `thm:revocation_ffi` | exigence | representation | §4.5 | 0 |
| `thm:traduction_metalangage` | proposition | langage | §4.6 | 11 |
| `thm:simulation` | proposition | langage | §4.6 | 1 |
| `thm:fidelite_interprete` | proposition | langage | §4.6 | 3 |
| `thm:relation_produit` | proposition | langage | §4.7 | 0 |
| `thm:hygiene_graduee` | proposition | langage | §5.2 | 0 |
| `thm:resucrage` | exigence | langage | §5.2 | 0 |
| `thm:abaissement_grades` | conjecture | compilation | §6.2 | 3 |
<!-- END:ouverts -->

Registre complet, avec les renvois : [`correspondance-enonces.md`](correspondance-enonces.md). Registre des dépendances sur du non acquis : [`registre-obligations.md`](registre-obligations.md) (instantané du 1er octobre, à regénérer — voir §3).

### La campagne PR-02 en chiffres

Six relectures, un méta-relecteur, trois études annexes : **190 lignes de suivi** (127 fiches, 27 réécritures, 29 vérifications bibliographiques, 7 arbitrages). État par lot :

<!-- BEGIN:fiches -->
| Lot | Fiches | ✅ fermées | 🟡 partielles | ⏳ à ratifier | ❓ décision | ⛔ écartées | ⬜ ouvertes |
|---|--:|--:|--:|--:|--:|--:|--:|
| `BLOQ` Bloquants | 14 | 8 | 6 | 0 | 0 | 0 | 0 |
| `STRUCT` Structurels | 23 | 14 | 3 | 0 | 0 | 0 | 6 |
| `PORT` Portée | 17 | 17 | 0 | 0 | 0 | 0 | 0 |
| `PREUVE` Dettes de preuve | 16 | 2 | 11 | 0 | 0 | 0 | 3 |
| `NOTA` Notation, comptes, renvois | 8 | 8 | 0 | 0 | 0 | 0 | 0 |
| `IMPL` Implémentation et outillage | 9 | 4 | 2 | 0 | 0 | 0 | 3 |
| `FACT` Factorisations à écrire | 24 | 12 | 4 | 0 | 2 | 2 | 4 |
| `REFUS` Factorisations refusées | 7 | 7 | 0 | 0 | 0 | 0 | 0 |
| `REECR` Réécritures d'énoncés | 27 | 26 | 1 | 0 | 0 | 0 | 0 |
| `BIB` Vérifications bibliographiques | 29 | 11 | 6 | 0 | 0 | 0 | 12 |
| `TRANS` Refontes transversales | 9 | 2 | 0 | 0 | 0 | 0 | 7 |
| `ARB-PR` Arbitrages | 7 | 5 | 0 | 1 | 1 | 0 | 0 |
| **Total** | **190** | **116** | **33** | **1** | **3** | **2** | **35** |
<!-- END:fiches -->

Détail fiche par fiche : [`FICHES-PR02.md`](FICHES-PR02.md). **Comment lire « ouverte »** : aucun compte rendu de séance ne nomme la fermeture de la fiche. L'auteur a pu fermer sans consigner ; l'état est volontairement conservateur et se corrige dans `fiches-statuts.csv`. Les fermetures *déduites* (changement de statut d'un énoncé rapproché du texte de la fiche) sont marquées comme telles et sont à confirmer.

### Les six vagues du plan, aujourd'hui

Le plan de traitement ([`pr-02-plan-de-traitement.md`](pr-02-plan-de-traitement.md), 30 septembre) ordonnait six vagues. Leur état réel :

| Vague | Contenu | État |
|---|---|---|
| 0 | sceau à deux axes, registre des obligations, table des symboles, comptes produits | ✅ close (30 septembre) |
| 1 | fondations algébriques : ℛ, ⊖, `BLOQ-03`, `BLOQ-06` | ✅ close — `BLOQ-04`, `-03`, `-06` fermées |
| 2 | périmètre du noyau (D-1, voie 2 : **formaliser la couche 2**) | ✅ décidée et écrite — couches 3, 2 et 1 au noyau formel (`BLOQ-01`, `-02`, `-13`) |
| 3 | remontées, sémantique primitive, ordre de préservation | 🟡 en cours — six des sept théorèmes repris sous concurrence, la non-interférence refondue ; restent `BLOQ-05`, `-07`, `-08`, `-09`, `-10`, `-11`, `-12`, `-14` |
| 4 | dettes de preuve et factorisations | 🟡 en cours — `FACT` : 10 fermées sur 24 ; `PREUVE` : 1 fermée, 2 partielles sur 16 |
| 5 | réécriture des énoncés (`REECR`) | ⬜ non entamée, **à faire en dernier** : les énoncés ne se stabilisent qu'une fois les objets stabilisés |

---

## 2. Ce qu'il reste à faire avant l'implémentation Lean 4

L'ordre suit le plan de traitement et les comptes rendus de séance les plus récents. Les « portes » en fin de section sont une **proposition** de critères de sortie, à valider.

### A. Ce qui demande votre décision

Détail et sources : [`DECISIONS.md`](DECISIONS.md).

| | Décision | Ce qui attend |
|---|---|---|
| `ARB-PR-07` | socle homotopique ou famille modale et graduée | l'étude d'opportunité conclut « famille modale et graduée » ; il reste à **ratifier et écrire la décision et son motif au §1.2** |
| — | **quatre imports ciblés** (théorie de modes, calf/decalf, types gradués formalisés, récursion gardée multi-horloges) | validés par vous, pas encore versés au texte : à instruire |
| `ARB-PR-06` | la revendication de préservation de bout en bout fait-elle partie des objectifs déclarés ? | si oui, `PREUVE-02` passe en tête ; sinon la revendication est restreinte |
| `ARB-PR-04` | ce que le document promet pour le rejeu bit-à-bit | le théorème est scindé (logique / binaire sous environnement reproductible) ; la décision de fond reste à écrire |
| `ARB-PR-03` | effets à portée | **position intermédiaire appliquée** (`ℰ_alg`, `ℰ_scoped`, clôture faible) : à ratifier ; `BIB-01` (Hefty Algebras) non instruit |
| `T-68` | mots des quarante-quatre primitives | dix entrées nouvelles en trois jours, chacune avec ses candidats ; le choix vous revient ([`primitives.md`](primitives.md)) |

Et la **validation des statuts déduits** dans `fiches-statuts.csv` (`confiance = deduite`, sept lignes).

### B. Ce qui demande du travail seul, dans l'ordre

1. **Fermer les bloquants restants** (`BLOQ-05`, `-07`, `-08`, `-09`, `-10`, `-11`, `-12`, `-14`). `BLOQ-05` (le niveau d'un calcul n'est produit par aucune règle) et la relation logique sur un produit conditionnent `FACT-07`, qui attend délibérément.
2. **Les dettes de preuve** (`PREUVE-01` à `-16`, 13 ouvertes et 2 partielles) — la plus lourde est la correction de ressource (`PREUVE-01`) ; les neuf énoncés ouverts sont listés au §1.
3. **Le lot `FACT`** (11 ouvertes : `-07`, `-08`, `-09`, `-10`, `-11`, `-12`, `-14`, `-16`, `-17`, `-18`, `-20`) et la consignation de `FACT-21` / `-22` dans [`factorisations-refusees.md`](factorisations-refusees.md).
4. **`STRUCT`** (18 ouvertes, 1 partielle) et **`PORT`** (6 ouvertes : `-01`, `-06`, `-07`, `-12`, `-13`, `-14`), puis **`NOTA`** (5) et **`TRANS`** (7).
5. **`IMPL`** (8 ouvertes) : exigences sur le compilateur et l'outillage. Ce sont les **entrées directes de l'implémentation Lean 4** — solveur comme boîte noire, compilation reproductible, structure des boîtes aux lettres, profil de représentation, table de propagation des singularités.
6. **`BIB`** (29 vérifications de sources externes) — se mènent en parallèle, sans bloquer le reste.
7. **`REECR`** (22 ouvertes) **en dernier**, puis relecture d'ensemble.

### C. L'ouvrage de reprise, hors fiches

* **Les anomalies relevées par l'audit de la conversion** : [`ANOMALIES.md`](ANOMALIES.md) (lettres d'annexes périmées, tableau des engagements mal formé, commentaires d'auteur obsolètes, annexes squelettiques…). Aucune n'a été corrigée : le manuscrit porte « ne rien modifier sans l'accord de l'auteur ».
* **Regénérer le PDF de référence.** Le PDF `main.pdf` hérité date du 9 septembre ; les fiches citent ses numéros de pages et d'énoncés. Le PDF courant est produit par la CI (`spec-pdf`) ; la table de correspondance [`correspondance-enonces.md`](correspondance-enonces.md) relie les numéros d'alors aux numéros d'aujourd'hui.

### D. Portes proposées avant de passer à l'implémentation

Critères de sortie suggérés — à ajuster :

| Porte | Critère | Mesure |
|---|---|---|
| P1 | plus aucun bloquant ouvert | lot `BLOQ` : 0 ouverte |
| P2 | tout énoncé ouvert a sa route et son hypothèse nommées, et aucune prose ne le dit acquis | `scripts/controle.py` (propagation) |
| P3 | décisions `ARB-PR-03`, `-04`, `-06`, `-07` et `T-68` tranchées | [`DECISIONS.md`](DECISIONS.md) |
| P4 | les huit exigences `IMPL` sont lues comme un cahier des charges de l'implémentation | lot `IMPL` : 0 ouverte, ou reportées avec motif |
| P5 | `REECR` appliqué, anomalies levées, relecture d'ensemble faite | lot `REECR` : 0 ouverte ; [`ANOMALIES.md`](ANOMALIES.md) vide |
| P6 | première version publiée de la spécification | release `spec-v0.1.0` (PDF archivé sur Zenodo) |

---

## 3. Ce qui menace la suite

### Le filet de contrôles : porté sur le Verso

Le Verso fait foi depuis le 1er octobre 2026 (décision `D-5`). Les contrôles de l'ancien outillage lisaient le Org ; ils sont **portés en Python** dans [`scripts/controles/`](../../scripts/controles/) et lancés par `python3 scripts/controle.py` (aussi en CI, job `build`) :

| Module | Ce qu'il garde |
|---|---|
| `algebre` | la loi d'action aux bornes (0 et ω, 216 triplets, auto-test : les deux mauvaises définitions de ⊖ échouent avec 10 et 14 contre-exemples), l'action à travers ∥, les quatre égalités de ω, les deux sortes de tailles |
| `notation` | Δ seul contexte, un glyphe par modalité, affirmations sur le hachage, sceau des énoncés (statut, niveau, esquisse), propagation des énoncés ouverts, routes des engagements, table normative |
| `croise` | grammaire des termes × règles de typage × liste des primitives ; comptes (49 règles, 45 constructeurs) |
| `structure` | renvois résolus, étiquettes uniques et bien préfixées, lettres d'annexe jamais écrites en dur, tableaux réguliers, aucun commentaire d'auteur enfoui, glossaire |

Déjà assurés par le rendu : renvois et clés bibliographiques (une étiquette ou une clé absente fait échouer `lake exe spec`). **Pas encore portés** : les sondes sémantiques (`bib/sondes.json` : un passage cite-t-il le bon auteur), le gel de non-régression bibliographique, la mesure de la prose contre la charte — à porter si on les juge utiles. Rappel : un contrôle qui n'a jamais été vu échouer ne vaut rien ; `algebre` s'auto-teste, les autres se mutent à la main (retirer un sceau, écrire « démontre » près d'un énoncé ouvert).

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
