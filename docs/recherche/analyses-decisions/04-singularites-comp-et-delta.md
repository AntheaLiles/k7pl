<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 4 : les singularités `∘` et `δ` (`BLOQ-12`, `IMPL-07`)
> **Résolu le 7 octobre 2026 (relecture de la PR n° 10).** La régression de `BLOQ-12` décrite ci-dessous a été réparée avant la fusion : la règle par réunion d'étiquettes, la note de sources, le journal 02-33 et le contrôle `scripts/controles/singularites.py` sont présents dans l'état de la PR. Les mentions de « `HEAD` » et les actions « rétablir `504739d` » décrivent l'état *avant* réparation ; les hashs cités (`504739d`, `d08f92b`, `97788c3`, `5449b35`) désignent des commits fusionnés en un seul par le squash de la PR et ne sont plus atteignables.

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Mandat antérieur de l'auteur (séance 32) : « Les singularités sont à définir, leurs propagations réelles sont à sourcer dans les références. » Ce dossier compare les quatre sorties : **retirer**, **priorité fixe**, **`∘ + ∞ = ⊥`**, **garder l'ensemble d'étiquettes**. Il ne tranche rien et ne modifie pas `spec/` ; les textes Verso du §7 sont **non appliqués**.

## 0. Avertissement préalable : l'état du dépôt a régressé

**À lire avant tout le reste.** Le commit `504739d` (et `d08f92b` avant lui) a écrit la correction de `BLOQ-12` : les erreurs `∘`, `δ` y sont des **ensembles d'étiquettes combinés par réunion** (`∘δ` cinquième singularité), parce que la règle de la séance 32 (« borne supérieure, `∘ ⋆ δ = ⊥` ») n'est **pas associative**. Le commit `97788c3` (« étudier le fil de temps de la fibrille engendrée par `spawn` »), par la suite, **a défait cette correction** : `git show --stat 97788c3` montre `docs/recherche/sources-singularites.md` (−63 lignes), `docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md` (−50), `scripts/controles/singularites.py` (−112), `scripts/verif_singularites.py` (−142), `spec/Spec/C3/LesContraintesDeValeur.lean` (54 lignes modifiées, retour à la « borne supérieure »), `biblio/references.json` (−10), `tools/SpecBib.lean`, `spec/CHANGELOG.md`, `CHANGELOG.md`, `docs/bibliographie/verifications-pr02.md`. C'est la signature d'un commit construit sur un index périmé (plusieurs agents écrivent sur la même branche). **Aujourd'hui, `HEAD` porte la règle fausse** ; la règle corrigée est lisible par `git show 504739d:<chemin>`.

Je n'ai pas pu rétablir ces fichiers moi-même (mes écritures git sont refusées par la session, voir le rapport). **Action pour le coordinateur** : restaurer ces onze chemins depuis `504739d` (`git checkout 504739d -- <chemins>`), relire `git diff 504739d 97788c3 -- docs/suivi` avant de toucher aux fiches de suivi (leurs modifications ont pu en suivre d'autres).

Je **confirme la correction par un calcul indépendant** (§4) : la règle « borne supérieure » viole l'associativité de `+` et de `·` ; la réunion d'étiquettes ne la viole pas.

**Niveau de vérification.** Textes du manuscrit : lus, soit au `HEAD` (§2.1), soit à `504739d` (§2.2). Calculs du §4 : script du rédacteur (`scratchpad`, non versionné), **modèle fini** (roue des fractions de GF(5), plus les classes d'erreur), **axiomes de la roue tels que rappelés** par la séance 33, non lus dans le texte de Carlström (accès fermé : EGRESS_BLOCKED, journal 02-33 §A). Aucune source externe n'a été relue.

## 1. Question exacte

> `∘` et `δ` sont deux « classes d'erreur » que le manuscrit ajoute à `⊥` et `∞` de la théorie des roues : elles n'ont **aucune source** (aucune des sources atteintes ne porte deux classes d'erreur distinctes de `⊥`). Que faire : (A) les **retirer** de l'encodage ; (B) une **priorité fixe** (`∘ ≻ δ ≻ ⊥`) ; (C) **renoncer à ce que `∘` absorbe `∞`** (`∘ + ∞ = ⊥`) ; (D) **garder l'ensemble d'étiquettes** (réunion, `∘δ` cinquième singularité) ?

## 2. État du manuscrit

### 2.1 Au `HEAD` (régressé)

| Fait | Où (lu) |
|---|---|
| `∘`, `δ` : deux classes d'erreur « propagées par la borne supérieure » ; `∘ ⋆ δ = ⊥`, `⊥` absorbe `∘` et `δ` ; « `+` et `·` restent commutatives et associatives sur les six classes » | `spec/Spec/C3/LesContraintesDeValeur.lean:483-501` |
| `thm:homomorphisme_roues` (proposition de niveau représentation) : encodage de **quatre** singularités `⊥, ∞, ∘, δ` dans la charge utile d'un NaN ; (i) injectivité, (ii) `select`, (iii) arithmétique « spécifiée par K7PL » par les tables | même fichier, 352-387 |
| Deux tables (addition, produit) sur les classes `0, x, ∞, ⊥` ; règle d'entrée `NaN → ⊥`, `±∞ → ∞`, `±0 → 0` ; écart IEEE 754 sur `∞ + ∞` écrit | même fichier, 389-482 |
| « Aucune entrée flottante ne produit `∘` ni `δ` : tout NaN est lu `⊥` » ; « retirer `∘` et `δ` de l'encodage (i) ne modifierait rien d'autre » | même fichier, 498-501 |
| `thm:representation_inobservable` (exigence) : « charge utile d'un NaN » parmi les libertés non observables | même fichier, 503-521 |
| Profil `Π = ⟨v_Arrow, v_Capnp, v_MLIR, arch, mem, round, v_schéma⟩` ; `E_repro` à quatre composantes dont « comportement des NaN » ; « l'égalité de couche 3 compare les classes de singularités, et leur propagation est spécifiée par K7PL » | `spec/Spec/C4/EchelleDuSysteme.lean:153-198` |
| `∘`, `δ` n'apparaissent **nulle part ailleurs** dans `spec/Spec` (`grep`), ni à la table des symboles | `grep -rn` sur `spec/Spec` |

### 2.2 À `504739d` (corrigé, supprimé par `97788c3`)

| Fait | Où (lu avec `git show 504739d:…`) |
|---|---|
| Une erreur est un **ensemble non vide d'étiquettes** parmi `∘`, `δ` (`∘`, `δ`, `∘δ`) ; `+`, `·`, `1/·` rendent la **réunion** des étiquettes des opérandes, la valeur de la roue étant oubliée ; (a) une erreur absorbe `0`, `x`, `∞`, `⊥` ; (b) `∘⋆∘ = ∘`, `δ⋆δ = δ` ; (c) `∘⋆δ = ∘δ`, et `∘δ` absorbe tout | `LesContraintesDeValeur.lean` à `504739d`, 483-504 |
| « `⊥` n'absorbe plus les erreurs (`⊥ + ∘ = ∘`) : l'axiome `0/0 + x = 0/0` … ne tient pas pour `x = ∘`, et l'ensemble des sept classes n'est donc _pas une roue_ ; il contient la roue des fractions » | idem |
| Contre-exemple de la règle abandonnée : `(∞ + ∞) + ∘ = ⊥` mais `∞ + (∞ + ∘) = ∘` | idem |
| `thm:homomorphisme_roues` : **cinq** singularités `⊥, ∞, ∘, δ, ∘δ` | idem, 352-372 |
| Note de sources : tableau œuvre par œuvre (Carlström, Setzer, Bergstra–Ponse, Bergstra 2019, Anderson–Reis, IEEE 754-2019, Goguen, Schwartz), tous au niveau « notice » ou « résumé », « corps lu : jamais atteint » ; quatre alternatives laissées à l'auteur | `docs/recherche/sources-singularites.md` à `504739d` |
| Contrôle `scripts/controles/singularites.py` : recalcule les tables sur la roue des fractions de GF(5), rejoue l'énumération de l'algèbre des erreurs (`scripts/verif_singularites.py`) | à `504739d` |

### 2.3 Deux constats de ce dossier

1. **Le contrôle `singularites.py` n'est plus branché** (fichier supprimé par `97788c3`) : aujourd'hui, rien ne garde les tables contre une dérive.
2. **Collision de notations.** `δ` désigne déjà `δ_ℓ` (famille de Kronecker de `Tick`, `ReglesDeTypage.lean:213`), `δ_{r,s}` (comultiplication de la comonade graduée, `LeSystemeGradue.lean:320`, `AlgebresCoalgebresEtPointsFixes.lean:540`) et `∘` la composition ; ni `∘` ni `δ` (singularités) ne figure à la table normative des symboles. Un lecteur doit deviner dans quel sens `δ` est pris. Cela plaide pour des noms de classes d'erreur distincts (question de vocabulaire, à joindre à `T-68`).

## 3. Options exhaustives

| | Option | Classes | Idée |
|---|---|---|---|
| `A` | **retirer** `∘`, `δ` de l'encodage | `0, x, ∞, ⊥` (4) | seules les classes de la roue |
| `B` | **priorité fixe** `∘ ≻ δ ≻ ⊥` | `0, x, ∞, ⊥, δ, ∘` (6) | quotient de `D` : `∘δ ↦ ∘` |
| `C` | **`∘ + ∞ = ⊥`** : `∘` n'absorbe que les finis | 6 | l'absorption de `∞` est abandonnée |
| `D` | **garder l'ensemble d'étiquettes** (réunion) | 7 (`0, x, ∞, ⊥, ∘, δ, ∘δ`) | produit de la roue par le semi-treillis des étiquettes, valeur oubliée |
| `E` (ajout) | `D` avec **une seule** étiquette | 5 | `∘` seul ; `δ` retiré |
| `F` (ajout, pour mémoire) | **borne supérieure** (la règle du `HEAD`) | 6 | `∘ ⋆ δ = ⊥`, `⊥` absorbe les erreurs |

`F` est incluse pour montrer pourquoi elle est écartée.

## 4. Vérification par calcul (rédacteur)

Modèle : roue des fractions de GF(5) (sept classes : les cinq éléments de GF(5), `∞ = (1,0)`, `⊥ = (0,0)` ; somme `(ad+bc, bd)`, produit `(ac, bd)`, inverse `(b, a)`), étendue selon chaque option. Axiomes testés, **tels que le journal 02-33 les rappelle** (non relus dans Carlström) : monoïdes commutatifs `(+, 0)` et `(·, 1)` ; `//x = x` ; `/(xy) = /x /y` ; `xz + yz = (x+y)z + 0z` ; `(x + yz)/y = x/y + z + 0y` ; `0·0 = 0` ; `(x + 0y)z = xz + 0y` ; `/(x + 0y) = /x + 0y` ; `0/0 + x = 0/0`. Les triplets sont énumérés exhaustivement.

| Option | Axiomes violés | Violations (extrait) |
|---|---|---|
| `A` (roue seule) | aucun | — |
| `D` réunion | **seulement** `0/0 + x = 0/0` (pour `x` étiqueté) | l'extension « n'est pas une roue » |
| `E` une étiquette | seulement `0/0 + x = 0/0` | idem |
| `B` priorité fixe | seulement `0/0 + x = 0/0` ; **associative** | `(∞+∞)+∘ = ∘ = ∞+(∞+∘)` |
| `C` `∘+∞ = ⊥` | `/(xy) = /x /y` et `/(x + 0y) = /x + 0y` ; **garde** `0/0 + x = 0/0` | `/(∘·∞) = ⊥` mais `/∘ · /∞ = ∘ · 0 = ∘` |
| `F` borne sup. (`HEAD`) | **associativité de `+` et de `·`**, `xz + yz = (x+y)z + 0z`, `(x + yz)/y = …`, `(x + 0y)z = …` | `(∞+∞)+∘ = ⊥` mais `∞+(∞+∘) = ∘` ; `(0·∞)·∘ = ⊥` mais `0·(∞·∘) = ∘` |

Deux lectures :

* **`F` est fausse**, ce qui confirme le journal 02-33 et le commit `d08f92b` : le manuscrit du `HEAD` affirme « associatives sur les six classes », or l'associativité de `+` échoue (4 triplets sur le modèle) et celle de `·` (8). Les trois autres axiomes de la liste échouent aussi.
* **Aucune des options testées ne conserve tous les axiomes de la roue avec une classe d'erreur supplémentaire** : `D`, `E`, `B` perdent `0/0 + x = 0/0` ; `C` garde cet axiome mais perd la multiplicativité de l'inverse. Je ne démontre pas qu'aucune extension ne le puisse ; je dis que les quatre règles naturelles testées ne le font pas. L'énumération porte sur `GF(5)` : ce n'est pas une preuve pour tous les corps.

## 5. Pour chaque option : ce qu'elle impose, casse, coûte

La colonne « énoncés » liste les endroits du manuscrit à toucher. `∘`, `δ` n'étant nulle part ailleurs que dans le §3.2, **les conséquences sont locales**.

| | `A` retirer | `B` priorité | `C` `∘+∞=⊥` | `D` réunion | `F` borne sup. |
|---|---|---|---|---|---|
| `thm:homomorphisme_roues` (proposition) | (i) sur **deux** singularités `⊥, ∞` ; titre inchangé | (i) sur quatre | (i) sur quatre | (i) sur **cinq** | (i) sur quatre (état `HEAD`) |
| tables du §3.2 | inchangées | inchangées (4 classes) ; règles `∘`, `δ` en prose | idem | inchangées ; règles en prose (réunion) | inchangées |
| paragraphe 483-501 | supprimé ; phrase du §3.2 d'introduction retouchée | réécrit (priorité) | réécrit | **déjà écrit à `504739d`** | faux |
| profil `Π`, `E_repro` | inchangés | inchangés | inchangés | inchangés (égalité de classes) | inchangés |
| `IMPL-07` (tables et règle d'entrée) | inchangé ; test différentiel hors `∞+∞` | + test des erreurs | + test | + test (réunion = OU de bits) | — |
| `BLOQ-12` | se ferme : « extension retirée » | à ratifier (extension, sans source) | idem | idem | — |
| contrôle `singularites.py` | tables seules | + énumération des erreurs | idem | **déjà écrit** (énumération de l'algèbre des erreurs) | échoue |
| encodage NaN (charge utile) | 2 motifs | 4 motifs (3 codes + ⊥) | 4 | 5 motifs (étiquettes = drapeaux de bits) | 4 |
| symboles | `∘`, `δ` disparaissent (la collision tombe) | restent | restent | restent | restent |
| sources | seulement calculé / résumé | aucune pour `∘`, `δ` | aucune | aucune | aucune |
| coût | `S` | `S` | `S` | `S` (texte déjà écrit) | — |

* **Sceaux.** `thm:homomorphisme_roues` est déjà une **proposition** ; aucun changement de sceau ne découle d'aucune option. `thm:representation_inobservable` est une exigence, inchangée.
* **Grades, niveaux, sortes, simulation, préservation, non-interférence** : **aucune interaction.** Les singularités vivent dans l'arithmétique de couche 3 sur `Wheel<T>`, hors du jugement gradué et des sortes. Le seul lien est P4 (le rejeu binaire) : l'identité binaire exige que la propagation soit spécifiée, ce que le texte fait pour toutes les options sauf si l'on s'en remet au matériel.
* **Réalisation, raisonnement non vérifié.** La réunion `D` s'implémente par OU de drapeaux dans la charge utile (une étiquette par bit), ce qui est sans branchement ; mais l'arithmétique matérielle ne combine pas deux charges utiles par OU (le NaN rendu est un des deux opérandes, ou le NaN par défaut, selon l'architecture) : `+` sur valeurs encodées doit donc passer par une correction explicite, **pour toutes les options**. Je n'ai pas mesuré ce coût.
* **Exemples.** `D` : `∘ + δ = ∘δ`, `∘δ + ∞ = ∘δ`, `⊥ + ∘ = ∘` ; `B` : `∘ + δ = ∘`, `δ + ⊥ = δ` ; `C` : `∘ + ∞ = ⊥`, `∘ + 0 = ∘`. **Contre-exemple** : `F` : `(∞ + ∞) + ∘ = ⊥`, `∞ + (∞ + ∘) = ∘`.

## 6. Recommandation argumentée

1. **Rétablir d'abord** l'état de `504739d` (§0) : le `HEAD` porte une règle démontrablement fausse. C'est une réparation, non une décision.
2. **Option `D` (garder l'ensemble d'étiquettes)**, comme réponse au mandat de l'auteur. Raisons : (i) l'auteur a écrit « à définir », non « à retirer » ; (ii) `D` est la seule définition **symétrique et sans arbitraire** (le semi-treillis libre sur les étiquettes) qui reste associative ; (iii) elle perd un seul axiome de la roue, que le texte dit ; (iv) elle s'étend à `n` étiquettes sans changer de forme, quand `B` demande un ordre total ; (v) le texte et le contrôle sont déjà écrits.
3. **Option `A` si l'auteur préfère ne livrer aucune algèbre sans source** pour `spec-v0.1.0` : elle ferme `BLOQ-12`, réduit `thm:homomorphisme_roues` à deux singularités et supprime la collision de notations ; elle ne coûte que du texte (`S`), et rien ne dépend de `∘` ni de `δ` ailleurs dans le manuscrit. Le besoin de distinguer des erreurs est déjà servi par `Result(T, E)` (état indésirable, §3.2 ouverture). **Le prix** : l'arithmétique de couche 3 n'a plus de classe d'erreur étiquetable. Ce n'est pas la lecture du mandat, mais c'est la plus prudente.
4. **Écarter `C`** (casse la multiplicativité de l'inverse, c'est-à-dire un axiome constitutif) et **`F`** (non associative). **`B`** est acceptable (c'est un quotient de `D`, asymétrique) si l'on veut trois codes de charge utile au lieu de cinq ; la perte d'information (`∘δ ↦ ∘`) est le prix.
5. **Renommer** `∘` et `δ` si `D` ou `B` sont retenus (collisions de §2.3) ; à joindre à la ratification en bloc de `T-68`.
6. **Ce que la recommandation ne tranche pas** : la **lecture des axiomes dans Carlström** (aucun corps lu) qui pourrait changer la liste des axiomes testés ; elle ne change pas le constat sur `F`.

## 7. Formulations prêtes à écrire (non appliquées)

### 7.1 Option `D` : paragraphe des erreurs (remplace `LesContraintesDeValeur.lean:483-501` au `HEAD`)

Le texte intégral est celui de `504739d` (lignes 483-504) ; il se rétablit par `git checkout 504739d -- spec/Spec/C3/LesContraintesDeValeur.lean` sans autre modification. Les passages décisifs :

```
Une erreur est un _ensemble_ non vide d'étiquettes pris parmi $`\circ` et $`\delta` : $`\circ`, $`\delta`, et
$`\circ\delta`, la classe d'une valeur qui porte les deux. Pour $`+`, $`\cdot` et l'inverse $`1/\cdot`, une
opération dont un opérande est une erreur rend l'erreur dont l'ensemble est la _réunion_ des ensembles de ses
opérandes, et la valeur de la roue est oubliée : (a) une erreur absorbe les quatre classes de la roue, $`0`, $`x`,
$`\infty` et $`\bot` ; (b) $`\circ \star \circ = \circ`, $`\delta \star \delta = \delta` ; (c)
$`\circ \star \delta = \delta \star \circ = \circ\delta`, et $`\circ\delta` absorbe tout. […] D'une part $`\bot`
n'absorbe plus les erreurs : l'axiome $`0/0 + x = 0/0` de la théorie des roues, tel que nous le rappelons, ne tient
pas pour $`x = \circ`, et l'ensemble des sept classes n'est donc _pas une roue_ ; il contient la roue des
fractions, dont les quatre classes se comportent comme dans les tables.
```

et `thm:homomorphisme_roues` : « cinq singularités (`⊥, ∞, ∘, δ, ∘δ`) », (i) « injective sur ces cinq singularités ».

### 7.2 Option `A` : retirer (remplace 344-347, 360-363, 483-501)

Introduction (ligne 342-347) :

```
La théorie des roues instancie ce premier régime pour l'arithmétique : une opération invalide ($`0/0`) ne
lève pas d'exception mais produit une singularité — $`\bot` ou $`\infty`, constructeurs d'un type algébrique
`Wheel<T>` distinct du flottant IEEE 754 sous-jacent, dont la conversion reste explicite dans les deux sens
{cite "carlstromWheelsDivisionZero2004"}[]. Un programme qui veut distinguer plusieurs sortes d'erreurs ne le
fait pas dans l'arithmétique : il emploie `Result(T, E)`.
```

Proposition : « Soit `i : Wheel → Float64` l'encodage qui associe à chacune des deux singularités (`⊥`, `∞`) un motif de bits déterministe […] Alors (i) `i` est injective sur ces deux singularités ; […] ». Et le paragraphe 483-501 est remplacé par :

```
Seules deux classes de la roue ne sont pas des valeurs : $`\infty` et $`\bot`. Ce document n'en définit pas
d'autres. Les propagations ci-dessus sont calculées sur la roue des fractions, non citées d'un énoncé de
l'article de Carlström ; ce qui n'est attesté que par le résumé de la source est dit tel dans le journal des
sources.
```

### 7.3 Option `B` : priorité fixe (si retenue)

```
Les deux classes d'erreur $`\circ` et $`\delta` sont ordonnées : $`\circ` l'emporte sur $`\delta`, qui l'emporte
sur $`\bot`. Une opération dont un opérande est une erreur rend la plus haute des erreurs de ses opérandes ;
$`\circ \star \delta = \circ`. $`+` et $`\cdot` sont commutatives et associatives (vérifié par énumération sur la
roue des fractions des corps à 2, 3 et 5 éléments, non démontré) ; $`\bot` n'absorbe pas les erreurs.
```

## 8. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| rétablir `504739d` | contrôle de propagation, note de sources, journal 02-33, notice IEEE 754-2019 dans la bibliographie |
| `D` ou `B` ou `A` | fermeture de `BLOQ-12` ; `IMPL-07` : tables, règle d'entrée, test différentiel à l'implémentation ; ratification de `thm:homomorphisme_roues` |
| `A` | disparition de la collision de notations `δ`, `∘` |
| lecture de Carlström (accès) | confrontation de la liste d'axiomes rappelée |

## 9. Ce qui reste ouvert

La vérification des axiomes sur **toute** extension (ici : quatre règles sur GF(5)) ; la lecture de Carlström 2004 et de Bergstra 2019 (autres valeurs d'erreur) ; la mesure du coût de la correction logicielle de la propagation des charges utiles de NaN ; le choix des noms.

## 10. Niveau de vérification

* **Manuscrit** : lignes lues, au `HEAD` et à `504739d` (commandes `git show`, lecture seule).
* **Calculs** : script du rédacteur, modèle fini, axiomes rappelés ; les résultats du tableau du §4 sont ceux d'une exécution (non versionnée) du 6 octobre 2026. Ils reproduisent le constat du journal 02-33 (`(∞+∞)+∘ ≠ ∞+(∞+∘)`).
* **Sources externes** : **aucune relue** ; les notices viennent de `docs/recherche/sources-singularites.md` (état `504739d`) et sont au niveau « notice » ou « résumé ».

Renvois : [`DECISIONS.md`](../../suivi/DECISIONS.md) (`BLOQ-12`, `IMPL-07`) ; [07, `ARB-PR-04`](07-arb-pr-04-rejeu-binaire.md) (la propagation spécifiée soutient la voie C) ; [`instruction-des-decisions`](../instruction-des-decisions.md).
