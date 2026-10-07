<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Index des analyses de ratification
> **Résolu le 7 octobre 2026 (relecture de la PR n° 10).** La régression de `BLOQ-12` décrite ci-dessous a été réparée avant la fusion : la règle par réunion d'étiquettes, la note de sources, le journal 02-33 et le contrôle `scripts/controles/singularites.py` sont présents dans l'état de la PR. Les mentions de « `HEAD` » et les actions « rétablir `504739d` » décrivent l'état *avant* réparation ; les hashs cités (`504739d`, `d08f92b`, `97788c3`, `5449b35`) désignent des commits fusionnés en un seul par le squash de la PR et ne sont plus atteignables.

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Ce dossier porte la part **ratifications** : pour chaque fiche au statut `a-ratifier` (les quinze lignes de [`fiches-statuts.csv`](../../suivi/fiches-statuts.csv)) et pour chaque décision « appliquée, non confirmée » de [`DECISIONS.md`](../../suivi/DECISIONS.md), une relecture critique du texte appliqué face au manuscrit actuel, avec un verdict et une correction minimale rédigée (non appliquée). Les décisions de **conception** (`∥` et `vmap`, `spawn`, `ANOM-18`, `∘` et `δ`, sceaux, formes temporelles, rejeu) sont dans l'index voisin [`00-index-design.md`](00-index-design.md), écrit par un autre agent ; les deux séries se recoupent sur `BLOQ-12`, `ARB-PR-04`, les sceaux et les schémas des modalités (voir « Recoupements »).

**Rien n'est modifié** : ni `spec/`, ni `fiches-statuts.csv`, ni le contenu de `DECISIONS.md` (un renvoi vers ce dossier y est ajouté). L'auteur décide.

## Niveau de vérification (commun)

* Les faits sur le manuscrit sont **lus dans le Verso** aux lignes citées dans chaque fichier (un grep par défaut ou par recoupement ; pas de supposition sur ce que le texte dit). Les corrections proposées sont des textes **non appliqués** ; ceux qui touchent un choix de modèle sont marqués « conjectural » et réservés à l'auteur.
* **Rien n'a été compilé** (ni `lake build`, ni `lualatex`, ni `tectonic`). Les vérifications mathématiques sont faites à la main, et, pour les singularités, par un petit programme hors dépôt (roue des fractions du corps à trois éléments ; **axiomes de la roue rappelés de mémoire, non relus**).
* **Aucune source externe n'a été relue** (accès fermé depuis la session). Les œuvres citées par le manuscrit ne le sont que par leur notice de `biblio/references.json` et ce que le manuscrit en dit.
* **Incident à signaler.** Plusieurs agents écrivent dans le même répertoire de travail. Un commit de ce chantier (`5449b35`) a supprimé par erreur les fichiers de l'agent « conception » ; ils ont été **restaurés** (commit `2587358`). Le commit `97788c3` avait de même défait la séance 33 (sources des singularités, associativité de `∘` et `δ`) : cette régression n'est **pas** réparée à la date de cet index (voir `BLOQ-12`).

## Les fichiers

| Fichier | Fiches et décisions |
|---|---|
| [`ratifications-pipeline-et-preuves.md`](ratifications-pipeline-et-preuves.md) | `STRUCT-06` (avec `REECR-16`), `STRUCT-05` et `TRANS-04` |
| [`ratifications-grades-et-cadre.md`](ratifications-grades-et-cadre.md) | `STRUCT-16`, `TRANS-02`, `FACT-12`, `STRUCT-01`, `FACT-14`, `PREUVE-05` |
| [`ratifications-numerique-et-execution.md`](ratifications-numerique-et-execution.md) | `ARB-PR-04`, `IMPL-07`, `BLOQ-12`, `IMPL-04` |
| [`ratifications-effets-et-fermetures.md`](ratifications-effets-et-fermetures.md) | `ARB-PR-03` (cas `BIB-01`), les sept fermetures déduites, `FACT-09`, `BIB-17` |
| [`ratifications-anom-17.md`](ratifications-anom-17.md) | `ANOM-17` (cinq lignes, points de forme, grammaires), `PREUVE-04`, `TRANS-06`, `ANOM-09`, `ANOM-10`, `D-7`, sceaux de `thm:progres` et `thm:preservation` |

## Tableau : fiche, verdict recommandé, dépendances, fichier

Verdicts : **R** ratifier ; **R+c** ratifier avec correction ; **R-bloc** ratifier avec une autre fiche ; **N** ne pas ratifier telle quelle ; **—** rien à ratifier. « Q » marque une **question de modèle** que seul l'auteur peut trancher et qui conditionne la correction.

### Les quinze fiches `a-ratifier` du CSV

| Fiche | Verdict | Pourquoi (une ligne) | Dépend de / lié à | Fichier |
|---|---|---|---|---|
| `ARB-PR-04` | **R+c** (B puis C) | texte cohérent ; six formulations de la promesse à harmoniser, portée de « ordonnancement » à dire, phrase sans condition au §4.5 | `IMPL-07`, `BLOQ-12` (voie C) ; lié à `STRUCT-05` (`P_repr`) ; porte P3 | [numérique](ratifications-numerique-et-execution.md) |
| `BLOQ-12` | **N** pour `∘`, `δ` du `HEAD` ; **R** pour `⊥`, `∞` | la règle « borne supérieure » n'est pas associative (contre-exemple vérifié) ; la séance 33 l'avait corrigée, `97788c3` l'a défaite | rétablir `504739d` d'abord ; Q : garder deux classes (réunion d'étiquettes) ou les retirer | [numérique](ratifications-numerique-et-execution.md) ; [dossier 04](04-singularites-comp-et-delta.md) |
| `IMPL-07` | **R+c** | tables des quatre classes recalculées : exactes ; la case « fini » masque le dépassement de capacité flottant, l'écart IEEE touche aussi la soustraction | `BLOQ-12` (n'est pas bloquée par lui) ; soutient `ARB-PR-04` ; porte P4 | [numérique](ratifications-numerique-et-execution.md) |
| `IMPL-04` | **R+c** | topologie saine ; contradiction du §4.7 sur le choix du message, canaux partagés et borne mémoire sous-spécifiés, esquisse de `thm:sync_motifs_jonction` non alignée | `BIB-04`, `BIB-27` (lecture hors session) ; `guard` conjonctif ; porte P4 | [numérique](ratifications-numerique-et-execution.md) |
| `STRUCT-06` | **R+c** | numérotation vérifiée ; `ERR-TOP-001` attribuée à deux phases, résolution des noms sans phase | — (indépendante) | [pipeline](ratifications-pipeline-et-preuves.md) |
| `STRUCT-05` | **R+c** (avec `TRANS-04`) | déclaration cohérente ; la règle omet inlining et défonctionnalisation, le marquage d'une unité n'est pas défini ; preuve de `thm:stabilisation_pipeline` fausse telle qu'écrite | `TRANS-04` ; les trois lemmes de compatibilité restent à écrire | [pipeline](ratifications-pipeline-et-preuves.md) |
| `TRANS-04` | **R+c** (avec `STRUCT-05`) | idem | `STRUCT-05` | [pipeline](ratifications-pipeline-et-preuves.md) |
| `STRUCT-16` | **R+c** | `u ∈ ℕ∞` ne contient pas `1/N` ; zone de mode contre modalité de liaison à distinguer | usage `ℕ∞` ou `ℚ≥0 ∪ {ω}` (Q, constat T1) ; `TRANS-02` | [grades](ratifications-grades-et-cadre.md) |
| `TRANS-02` | **R+c** | principe sain ; « sept effets » n'en liste que six, `{0,1}` appelé singleton, action de `𝕌` sur `𝔅` non écrite (Q), `1 ⊑ ε` non posé | `PREUVE-05` ; Q : action sur le budget | [grades](ratifications-grades-et-cadre.md) |
| `FACT-12` | **R-bloc** (avec `TRANS-02`) | non-promesse correcte ; l'inversion d'ordre de `STRUCT-01` est acceptée, non résorbée | `TRANS-02` | [grades](ratifications-grades-et-cadre.md) |
| `STRUCT-01` | **R-bloc** (avec `TRANS-02`) | idem | `TRANS-02` | [grades](ratifications-grades-et-cadre.md) |
| `FACT-14` | **R** | trois notions distinguées ; défauts voisins (`⊥_S` des sommes, `thm:terminaison_lfp`) à traiter à part | — | [grades](ratifications-grades-et-cadre.md) |
| `PREUVE-05` | **R+c** | loi affaiblie correcte ; esquisse de (C) fausse à l'étape `ω` (résultat vrai), compatibilité avec `δ` non dérivée ; `1 ⊑ ε` | débloque `PREUVE-04` ; soutient `FACT-12` | [grades](ratifications-grades-et-cadre.md) |
| `ARB-PR-03` | **R+c** | position intermédiaire retenue ; « `φ_n` morphisme de monoïdes » contredit `thm:loi_distributive_conditions` ; collision de notation `ℳ` | `BIB-01` ; porte P3 | [effets](ratifications-effets-et-fermetures.md) |
| `FACT-09` | **R** (appariement) ; annexe A : **reporter** | 48 codes sur 48, 17 de non-dérivabilité (comptes refaits) ; deux codes sous une phase sans objet | — | [effets](ratifications-effets-et-fermetures.md) |

### Autres décisions « à ratifier » de `DECISIONS.md`

| Élément | Verdict | Pourquoi | Dépend de / lié à | Fichier |
|---|---|---|---|---|
| `BIB-01` (*Hefty Algebras*) | **R** « reste non instruit », option b (étiqueter le niveau de vérification, unifier les deux clés) | le manuscrit s'appuie déjà sur la notice en quatre endroits | `ARB-PR-03` ; instruction impossible hors session | [effets](ratifications-effets-et-fermetures.md) |
| sept fermetures déduites : `REECR-02`, `-06`, `-07`, `-11`, `-25` | **R-bloc** | texte attendu présent, vérifié ; `REECR-25` par un autre passage (annexe D retirée) | — | [effets](ratifications-effets-et-fermetures.md) |
| … `PORT-16` | **R+c** | sceau conforme ; pas de ligne dans `tab:engagements` | — | [effets](ratifications-effets-et-fermetures.md) |
| … `PORT-08` | **R+c** | `Sens` non défini, « corollaire » dénoncé encore dans le texte | — | [effets](ratifications-effets-et-fermetures.md) |
| `BIB-17` | **R+c** | deux formulations du lieu de l'invalidation, « devrait » contre « doit » | `thm:revocation_ffi` | [effets](ratifications-effets-et-fermetures.md) |
| `ANOM-17` : `slice` | **R** | source du premier jeton à nommer | arène (élimination non écrite) | [anom-17](ratifications-anom-17.md) |
| `ANOM-17` : `∥`, `vmap` | **R** comme étape | `μ₁ ⊎ μ₂` à préciser ; la voie C reste en question | [dossier 01](01-parallele-et-vmap.md) | [anom-17](ratifications-anom-17.md) |
| `ANOM-17` : `guard` conjonctif | **R+c** | contradiction du §4.7 ; disjonction des motifs conjonctifs | `IMPL-04` | [anom-17](ratifications-anom-17.md) |
| `ANOM-17` : défaillance de `try` | **R+c** | condition « corps non terminal » absente | — | [anom-17](ratifications-anom-17.md) |
| `ANOM-17` : `spawn`, comptabilité | **N** telle quelle | double comptage du travail sur la chaîne de la fille : l'inégalité de préservation y semble fausse | [dossier 02](02-spawn-et-fil-de-temps.md) (fil de temps) | [anom-17](ratifications-anom-17.md) |
| `ANOM-17` : points de forme | **R** | formes canoniques à compléter | — | [anom-17](ratifications-anom-17.md) |
| `ANOM-17` : grammaires, schémas des modalités | **R** ; `declassify` **R+c** avec Q | 𝒳 : ensemble de valeurs ou d'expressions ? | `PREUVE-04` ; [dossier 06](06-formes-temporelles-declassify-at-move.md) | [anom-17](ratifications-anom-17.md) |
| `PREUVE-04`, `TRANS-06` | **R** (`TRANS-06`) ; `PREUVE-04` reste partielle | six remontées présentes ; `ANOM-18` ouverte | `PREUVE-05`, Q de 𝒳 | [anom-17](ratifications-anom-17.md) |
| `ANOM-09`, `ANOM-10` | **R** sous condition | compilation par `tectonic` non vue | CI avant P6 | [anom-17](ratifications-anom-17.md) |
| `D-7` | **—** | tranchée et exécutée par l'auteur (`d84021f`) ; ligne à retirer de « À ratifier » | — | [anom-17](ratifications-anom-17.md) |
| sceaux `thm:progres`, `thm:preservation` | **R** (passage à proposition) ou `S3` ; **réécrire l'énoncé de la préservation dans tous les cas** | énoncé faux pour `wait`, `move`, `declassify` ; formes canoniques incomplètes ; trois renvois disent « démontrée » | [dossier 05](05-sceaux-progres-preservation.md) | [anom-17](ratifications-anom-17.md) |

Décompte des **quinze fiches** du CSV : **aucune** n'est à refuser en bloc ; **deux** se ratifient sans correction (`FACT-14` ; `FACT-09` pour l'appariement) ; **deux** (`FACT-12`, `STRUCT-01`) se ratifient avec `TRANS-02`, sans correction propre ; **dix** avec une correction de rédaction (`ARB-PR-04`, `IMPL-07`, `IMPL-04`, `STRUCT-06`, `STRUCT-05`, `TRANS-04`, `STRUCT-16`, `TRANS-02`, `PREUVE-05`, `ARB-PR-03`) ; **une** (`BLOQ-12`) est à ne pas ratifier telle qu'écrite pour une partie de son contenu (`∘`, `δ`). Sur les autres décisions : un défaut de fond à lever avant de ratifier (`spawn`, comptabilité), une question de modèle (`declassify`, 𝒳), une ligne sans objet (`D-7`).

## Les questions de modèle, qui sont à l'auteur

Ces cinq points ne se règlent pas par de la rédaction ; chacun conditionne une correction.

1. **Le porteur de l'usage** : `ℚ≥0 ∪ {ω}` (ch. 1 et 2) ou `ℕ∞` (ch. 3) ; et ce que devient l'action d'un usage fractionnaire sur le budget (`STRUCT-16`, `TRANS-02`).
2. **`∘` et `δ`** : les retirer, ou les garder par réunion d'étiquettes (séance 33, à rétablir), ou une autre règle associative.
3. **Le statut de 𝒳** : ensemble de valeurs closes ou d'expressions évaluées dans l'état initial ; décide si `declassify` ne porte que sur des constantes (`ANOM-17`, `PREUVE-04`).
4. **La portée de « ordonnancement »** dans `E_repro` : intra-acteur, ou entre fibrilles d'une machine (`ARB-PR-04`).
5. **La comptabilité de `spawn`** : provision consommée par la fille (voie B) ou lue net (voie A) (`ANOM-17`).

## Ordre de ratification proposé

L'ordre suit les dépendances, et place d'abord ce qui est sans risque.

**Étape 0 : réparer, hors décision.** Rétablir la séance 33 (`504739d`, voir `BLOQ-12`) ; décider ensuite si `∘` et `δ` restent.

**Étape 1 : en bloc, sans risque.** `FACT-14`, `STRUCT-06` (avec la correction d'`ERR-TOP-001`), `FACT-09` (appariement seulement), les cinq `REECR`, `BIB-17`, `D-7` (retirer la ligne), `BIB-01` (option b), `ANOM-17` points de forme. Aucune n'a de dépendance non résolue.

**Étape 2 : le numérique, dans cet ordre.** `BLOQ-12` (`⊥`, `∞` ; puis `∘`, `δ` selon l'étape 0) → `IMPL-07` → `ARB-PR-04` ; en parallèle `IMPL-04` (avec la correction du §4.7) et `ARB-PR-03` (avec la correction de `φ_n`). Ces cinq ferment les portes **P3** (`ARB-PR-03`, `-04`) et **P4** (`IMPL-04`, `-07`).

**Étape 3 : le cadre des grades.** Trancher d'abord les questions 1 (usage) ; puis `PREUVE-05` (avec la correction de l'esquisse et `1 ⊑ ε`) → `TRANS-02` → `STRUCT-16`, `FACT-12`, `STRUCT-01` **en bloc**.

**Étape 4 : l'ordre de préservation.** `STRUCT-05` et `TRANS-04` **en bloc** : ratifier la déclaration avec les corrections (règle complète, marquage à définir) ; les trois lemmes de compatibilité restent à écrire (la fiche ne se ferme pas à la ratification).

**Étape 5 : les schémas de réduction, après les décisions de conception.** `slice`, `guard`, `try`, grammaires et schémas purs des modalités ; puis `∥` et `vmap` (après le dossier 01) ; `spawn` seulement après la vérification du double comptage ; `declassify` après la question 3 ; enfin **les sceaux**, qui dépendent de ce que les cas restants démontrent.

**Étape 6 : avant la release (P6).** `ANOM-09`, `ANOM-10` après une exécution de la CI avec `tectonic`.

### Ratifications qui peuvent se faire en bloc

| Bloc | Fiches | Raison |
|---|---|---|
| B1, sans risque | `FACT-14`, `STRUCT-06`, `FACT-09` (appariement), `REECR-02`, `-06`, `-07`, `-11`, `-25`, `BIB-17`, `BIB-01` (option b), `D-7` | texte présent et vérifié, ou correction de rédaction seule, aucune dépendance |
| B2, numérique | `BLOQ-12`, `IMPL-07`, `ARB-PR-04` | la voie C d'`ARB-PR-04` repose sur les tables ; `BLOQ-12` et `IMPL-07` ne diffèrent que par les classes `∘`, `δ` |
| B3, cadre des grades | `TRANS-02`, `FACT-12`, `STRUCT-01`, `STRUCT-16` | `FACT-12` et `STRUCT-01` n'attendent que `TRANS-02` ; `STRUCT-16` partage la question du porteur de l'usage |
| B4, préservation | `STRUCT-05`, `TRANS-04` | mêmes lignes de texte, même correction |
| B5, schémas simples | `slice`, `guard`, `try`, points de forme, schémas purs des modalités | corrections locales, sans question de modèle |
| B6, fermetures déduites | `REECR-02`, `-06`, `-07`, `-11`, `-25` (cinq) ; `PORT-16`, `PORT-08` après correction | cinq sur sept sont sûres ; deux demandent un mot |

## Recoupements avec l'index de conception

| Sujet | Ce fichier | Dossier de conception | Accord |
|---|---|---|---|
| `∘`, `δ` (`BLOQ-12`) | non-associativité de la règle du `HEAD` (contre-exemple) ; retirer ou rétablir la séance 33 | [04](04-singularites-comp-et-delta.md) : rétablir `504739d`, puis réunion d'étiquettes | **convergent** (même contre-exemple, confirmé par la séance 33) |
| `ARB-PR-04` | six formulations, portée de l'ordonnancement, `NaN` dans la charge | [07](07-arb-pr-04-rejeu-binaire.md) : garder B puis C, harmoniser six formulations, promesse par acteur | **convergent** |
| sceaux | énoncé de la préservation faux pour trois schémas ; proposition ou `S3` | [05](05-sceaux-progres-preservation.md) : `S3`, réécrire dans tous les cas | **convergent** sur la réécriture ; **divergent** sur le sceau (choix de l'auteur) |
| schémas des modalités, `declassify` | 𝒳 valeur ou expression ; préservation du type de `declassify` pourrait être exacte | [06](06-formes-temporelles-declassify-at-move.md) : « après vérification » (la préservation de `declassify` pourrait être exacte) | **convergent** |
| `∥`, `spawn` | ratifier la fourche-jointure comme étape ; double comptage de `spawn` | [01](01-parallele-et-vmap.md), [02](02-spawn-et-fil-de-temps.md) : options, ordre `∥` avant `spawn` | **complémentaire** : les dossiers 01 et 02 posent la décision, ce fichier dit ce que la ratification des voies appliquées engage |
| facteur temporel | signalé comme `ANOM-18` ouverte | [03](03-anom-18-facteur-temporel.md) : `A+D`, `κ ∈ (ℕ∞ × ℕ∞)^ℒ` | **à joindre** : bon marché, conditionne `V3` et `O1b` |

## Renvois

[`DECISIONS.md`](../../suivi/DECISIONS.md) · [`RESTE-A-FAIRE.md`](../../suivi/RESTE-A-FAIRE.md) · [`ANOMALIES.md`](../../suivi/ANOMALIES.md) · [`instruction-des-decisions`](../instruction-des-decisions.md) · [`reprise-agents.md`](../../suivi/reprise-agents.md)
