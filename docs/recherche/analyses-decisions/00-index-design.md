<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Index des dossiers de décision de conception
> **Résolu le 7 octobre 2026 (relecture de la PR n° 10).** La régression de `BLOQ-12` décrite ci-dessous a été réparée avant la fusion : la règle par réunion d'étiquettes, la note de sources, le journal 02-33 et le contrôle `scripts/controles/singularites.py` sont présents dans l'état de la PR. Les mentions de « `HEAD` » et les actions « rétablir `504739d` » décrivent l'état *avant* réparation ; les hashs cités (`504739d`, `d08f92b`, `97788c3`, `5449b35`) désignent des commits fusionnés en un seul par le squash de la PR et ne sont plus atteignables.

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Sept dossiers, une même grille : question exacte ; état du manuscrit (lignes lues) ; options exhaustives ; pour chaque option ce qu'elle impose, casse et coûte ; recommandation argumentée ; formulation Verso **non appliquée** ; ce que la réponse débloque ; niveau de vérification. Aucun dossier ne modifie `spec/`.

Ce répertoire ne porte que l'index des décisions **de conception** ; un autre agent écrit l'index général.

## Tableau

| # | Élément | Recommandation (en une ligne) | Urgence | Dépend de | Fichier |
|---|---|---|---|---|---|
| 1 | `∥` et `vmap` : lecture qui fait foi | fourche-jointure (`V0`) pour ce que la relation écrit, réparée par la restriction au parallélisme **pur** (`V6`, effet `⟨1, κ⟩`) ; dire en un paragraphe que les passages « entrelacement » énoncent l'absence de dépendance ; `V3` après `Q0` ; `V2` pas maintenant | moyenne (conditionne le 2, le 5) ; la réparation de `V0` est due quelle que soit la suite | `Q0` (que veut dire « couche 3 » : fragment sans temps ou « cartésien chronométré ») ; le 3 pour `V3` | [01](01-parallele-et-vmap.md) |
| 2 | `spawn` et le fil de temps | **court terme `O4a`** (dire le périmètre, resserrer l'esquisse de `thm:confinement_sortes`) ; **cible `O1b`** (bifurcation dirigée par le type, marqueur sur les niveaux où la fille travaille) sous quatre conditions | faible (rien de scellé n'en dépend ; une promesse indue à retirer tout de suite) | le 3 (condition de `O1b`) ; le 1 (décider `∥` d'abord) ; `thm:correspondance_niveaux` sur la couche 2 | [02](02-spawn-et-fil-de-temps.md) |
| 3 | `ANOM-18` : forme du facteur temporel | `A+D` : `κ ∈ (ℕ∞ × ℕ∞)^ℒ`, `w(ε)`, `s(ε)` familles ; la convention « concentré au niveau courant » réservée aux événements **atomiques** ; clause de couplage étendue à `Spawn`, `Send`, `Move` ; `thm:temps_mononiveau` réécrit (preuve intacte) | **haute** (bon marché ; ferme la fuite par présence pour `spawn`, `send`, `move` ; condition du 2 et de `V3`) | — (indépendante) | [03](03-anom-18-facteur-temporel.md) |
| 4 | Singularités `∘`, `δ` | **rétablir d'abord `504739d`** (le `HEAD` porte une règle non associative) ; puis `D` (ensemble d'étiquettes, réunion) en réponse au mandat « à définir » ; `A` (retirer) si l'auteur ne veut livrer aucune algèbre sans source ; écarter `C` et `F` | **haute** pour le rétablissement (régression) ; moyenne pour le choix | rétablissement des 11 fichiers ; le 7 (voie `C`) | [04](04-singularites-comp-et-delta.md) |
| 5 | Sceaux de `thm:progres` et `thm:preservation` | `S3` : restreindre chaque énoncé à son périmètre démontré (garder « théorème »), porter le reste dans une proposition ; **dans tous les cas** récrire les deux énoncés (faux tels qu'écrits : contexte conservé, triplets) et reborner l'introduction de §4.7 ; `S1` en repli | moyenne (les énoncés faux et l'introduction qui annonce plus que la preuve) | le 1 (cas `∥`), le 6 (cas `wait`, `move`, `declassify`), le 3 | [05](05-sceaux-progres-preservation.md) |
| 6 | Formes temporelles, `declassify`, `at_n`, `move` | ratifier les grammaires ; `T-A` (lecture séquentielle), `D-D` (boîte au niveau abaissé) **après vérification** d'un point (la préservation de `declassify` pourrait être exacte), `L-A` (machine unique) avec définition de `@_nε`, `loc(Δ)`, `Ser(V)` ; dire que `○C` n'a pas de consommateur à la source | moyenne | le 3 (`ε[ω/k]`, couplage de `wait`) ; clauses de traduction (après 1 et 2) | [06](06-formes-temporelles-declassify-at-move.md) |
| 7 | `ARB-PR-04` : rejeu bit à bit | garder « B puis C » (`A` en repli, réversible sans perte) ; **harmoniser les six formulations** de la promesse (P4 dit « propriété de déploiement », le §4.5 dit « promise ») ; dire que la promesse est **par acteur** ; retirer « NaN » de `E_repro` une fois `IMPL-07` ratifiée ; `D` écartée, `D-loc` à étudier plus tard | moyenne-faible (appliquée ; incohérence de rédaction à lever) | le 4 (classes de singularités) | [07](07-arb-pr-04-rejeu-binaire.md) |

## Ordre de décision conseillé

1. **Rétablir `504739d`** (dossier 4, §0) : réparation, non décision.
2. **Dossier 3 (`ANOM-18`)** : décision bon marché, qui conditionne les dossiers 1 (pour `V3`), 2 et 6.
3. **Dossier 1 (`∥`)** : `Q0` et la réparation de `V0` (`V6` ou `V7`).
4. **Dossier 2 (`spawn`)** : `O4a` tout de suite (retire une promesse), `O1b` ensuite.
5. **Dossier 5 (sceaux)** : après 1 et 6, pour savoir quels cas restent hors du noyau démontré.
6. **Dossier 6** et **dossier 7** : ratifications ; le 7 après le 4.

## Constats transversaux (nouveaux par rapport aux études existantes)

* **Régression du dépôt** (dossier 4) : le commit `97788c3` a défait la correction de `BLOQ-12` (§3.2 revenu à la règle « borne supérieure », contrôle `singularites.py`, note de sources, journal 02-33 supprimés) ; la règle du `HEAD` n'est pas associative (calcul reproduit).
* **« Couche 3 » désigne deux fragments** (dossier 1) : strict (`ℰ = ∅`, aucun `tick` compté) et « cartésien chronométré » (facteur temporel sans opération) ; `sec:g-parallelisme`, `thm:determinisme_parallele` et `eq:instance-L3` ne s'accordent pas.
* **Le progrès de `∥` exige la terminaison des branches** (dossier 1, absent de l'étude) ; `thm:progres` et `thm:preservation` sont **faux tels qu'écrits** pour quelques constructeurs (dossier 5).
* **`ε_spawn`, `send`, `move` sont tous sans niveau** (dossiers 2 et 3) : la fermeture du canal temporel « par règle » n'est établie que pour `tick` et `Op`.
* **`E_repro` n'est pas une projection de `Π`** pour deux de ses quatre composantes (dossier 7) ; la promesse du binaire est formulée de six façons.

## Niveau de vérification (commun)

Les faits sur le manuscrit sont lus aux lignes citées dans chaque dossier ; les constats nouveaux sont des lectures de rédacteur, non vérifiées par machine, sauf le calcul d'associativité du dossier 4 (modèle fini, axiomes rappelés). **Aucune source externe n'a été relue** (pages d'éditeurs et d'arXiv inaccessibles : `EGRESS_BLOCKED`) ; les œuvres citées ne le sont que par leur notice de `biblio/references.json` et par ce que le manuscrit en dit. Les coûts `S`, `M`, `L` sont des estimations.

Renvois : [`DECISIONS.md`](../../suivi/DECISIONS.md) ; [`ANOMALIES.md`](../../suivi/ANOMALIES.md) ; [`reprise-agents.md`](../../suivi/reprise-agents.md).
