<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 7 : `ARB-PR-04`, la promesse du rejeu bit à bit

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Ce dossier prolonge l'[instruction `ARB-PR-04`](../instruction-arb-pr-04-rejeu-binaire.md) (voies A à D, orientation « B puis C » appliquée le 6 octobre, à ratifier) en confrontant chaque voie au texte tel qu'il est écrit, et analyse `E_repro` à quatre composantes. Il ne tranche rien ; `spec/` n'est pas modifié ; les textes Verso du §7 sont **non appliqués**.

**Niveau de vérification.** Citations du manuscrit : lues, lignes indiquées. Les constats de cohérence entre passages sont des lectures de rédacteur. Aucun calcul ni test n'a été fait (la promesse est une exigence de réalisation, non vérifiable dans l'état du dépôt). Aucune source externe n'a été relue : `BIB-08` (IEEE 754) et `BIB-15` (Disruptor SPSC) ne sont connus que par leur fiche et par ce que le manuscrit en dit.

## 1. Question exacte

> Que promet le document du rejeu **bit à bit** ? (A) rien : seulement le rejeu logique, l'identité binaire étant une propriété d'une implémentation ; (B) l'identité binaire **sur une machine**, sous `E_repro` à quatre composantes (ordonnancement, mode d'arrondi, version de la chaîne de compilation, architecture et comportement des NaN) ; (C) l'identité binaire **par construction** pour les singularités (la charge utile d'un NaN hors de l'égalité observable, la propagation spécifiée par K7PL) ; (D) l'identité binaire **multi-acteurs** par consignation de l'ordonnancement des réceptions ? L'orientation appliquée est « B puis C », D écartée sans borne, A en repli.

## 2. État du manuscrit : six formulations de la promesse

| # | Formulation | Où (lu) |
|---|---|---|
| 1 | P4 : « Deux degrés de rejeu se distinguent, faute de quoi l'énoncé promet plus qu'il ne tient. Le rejeu _logique_ … est ce que P4 garantit … Le rejeu _bit à bit_ suppose en outre un ordonnancement, un mode d'arrondi flottant, une version de compilateur, une architecture et un comportement des NaN identiques, sur une même machine, qu'aucune clause de ce document ne fixe et que le journal ne consigne pas. **P4 énonce donc le premier ; le second est une propriété de déploiement** » | `spec/Spec/C1/Postulats.lean:185-191` |
| 2 | Chaque régime est « _binaire_ sous la seule hypothèse d'un environnement reproductible, que ce document nomme sans la fixer » | `Postulats.lean:178-180` |
| 3 | « Au replay, le runtime substitue à chaque appel non déterministe la valeur consignée, si bien que **l'exécution rejouée est, bit à bit, identique à l'originale** » (sans condition) | `spec/Spec/C4/EchelleDuSysteme.lean:113-117` |
| 4 | `thm:rejeu_binaire` (**proposition**, niveau représentation) : sous `E_repro` (ordonnancement, mode d'arrondi, version de la chaîne de compilation, architecture, NaN compris) et l'injectivité de la représentation, `Rejeu(J(H), S₀) =_bit S_final` ; esquisse : « Aucune des quatre composantes … n'est fixée par ce document, et le journal n'en consigne aucune » | `EchelleDuSysteme.lean:145-173` |
| 5 | « Ce que ce document promet du rejeu binaire tient donc en trois clauses » : identité binaire **promise sur une machine** sous `E_repro` ; pas de rejeu binaire multi-acteurs (« consigner chaque réception ferait croître le journal au rythme des messages, ce que P3 interdit tant qu'aucune borne n'est écrite ») ; charge utile d'un NaN non observable. « Si la réalisation ne peut tenir ces clauses, le repli est de ne promettre que le rejeu logique » | `EchelleDuSysteme.lean:177-189` |
| 6 | `P_repr` = « l'identité binaire de l'état observable », préservée par « **l'environnement**, sous le profil `Π` » ; le test différentiel exige l'égalité bit à bit « _seulement sous le profil déclaré_ » ; « aucune tolérance sur le rejeu logique » | `spec/Spec/C6/LeProcessusDeCompilation.lean:196-198` ; `spec/Spec/C6/StrategiesDeVerificationEtDeTest.lean:96-106` |

Autres faits lus :

| Fait | Où |
|---|---|
| `Π = ⟨v_Arrow, v_Capnp, v_MLIR, arch, mem, round, v_schéma⟩` (versions des trois spécifications de disposition, architecture et comportement NaN, modèle mémoire, mode d'arrondi, version de schéma) ; « `E_repro`, la portée “une machine” … et la convention d'élision de champ en sont **trois projections** » | `EchelleDuSysteme.lean:191-198` |
| `thm:determinisme_rejeu` (théorème) : journal **complet** ; rejeu par pli sur `J(H)` à travers les gestionnaires purs ; « il ne porte pas sur sa représentation » | `EchelleDuSysteme.lean:119-143` |
| `thm:representation_inobservable` (exigence) : cinq libertés (élision, purge, bourrage, charge utile de NaN, ordre des segments) | `spec/Spec/C3/LesContraintesDeValeur.lean:503-521` |
| P4, couche 2 : « _modulo le journal_ : l'entrelacement des acteurs est journalisé, et c'est le journal qui le restitue » | `Postulats.lean:172-173` |
| Les motifs de jonction sont rendus disjoints : choix supprimé, non journalisé | `Postulats.lean:193-199` |
| Garde : « celui que l'on retient est le premier dans l'ordre fixe des émetteurs » ; « seul le choix de la fibrille qui avance reste libre » | `spec/Spec/C4/SemantiqueOperationnelle.lean:255-259` |

### 2.1 Cinq constats de cohérence

1. **P4 ne promet pas le binaire ; le §4.5 le promet.** La formulation 1 (« P4 énonce donc le premier ; le second est une propriété de déploiement ») et la formulation 5 (« ce que ce document promet du rejeu binaire … sur une machine ») ne disent pas la même chose du **statut** : propriété de déploiement contre promesse du document. La voie « B puis C » a été écrite au §4.5 sans que P4 soit relu.
2. **La formulation 3 est inconditionnelle** (« bit à bit, identique à l'originale ») et précède les clauses conditionnelles du même §4.5. C'est le seul endroit où l'identité binaire est affirmée sans `E_repro`.
3. **`E_repro` n'est pas une projection de `Π`** telle que `Π` est écrit : `Π` porte `round` (arrondi) et `arch` (architecture et NaN) ; il ne porte ni l'ordonnancement ni la version de la **chaîne de compilation** (`v_Arrow`, `v_Capnp`, `v_MLIR` sont des versions de _spécifications de disposition_, non du compilateur ; `mem` est un modèle mémoire, non un ordonnancement). Le texte dit pourtant que `E_repro` est « une projection » de `Π`. Deux des quatre composantes n'ont pas de coordonnée.
4. **« Comportement des NaN » est à la fois une hypothèse d'environnement (4ᵉ composante de `E_repro`, voie B) et une obligation du compilateur (propagation spécifiée par K7PL, charge utile hors de l'égalité observable, voie C).** Si C tient, la composante NaN de `E_repro` est redondante : le compilateur doit se conformer aux tables, il n'est plus nécessaire de supposer le matériel (hypothèse de module `IMPL-07` : « conformité de l'abaissement aux tables de propagation »).
5. **Journal de réceptions, portée de « multi-acteurs ».** Le rejeu logique de `thm:determinisme_rejeu` rejoue « les messages journalisés `J(H)` » **d'un acteur** : la séquence de ses messages entrants fait partie de son journal. Ce que la clause exclut est donc l'**ordonnancement global** des réceptions entre acteurs, non l'ordre d'arrivée chez chaque acteur. Le texte ne dit pas cette distinction ; elle décide de ce que D coûterait (§4.4) et de ce que B promet réellement (rejeu binaire **par acteur**).

## 3. Options exhaustives

| | Voie | Ce qu'elle promet |
|---|---|---|
| `A` | logique seul | `≈_obs` ; le binaire est une propriété d'implémentation |
| `B` | binaire sous `E_repro`, une machine | identité binaire par acteur sur une architecture fixée |
| `C` | binaire par construction pour les singularités | `Injectivité` vraie par définition sur `⊥, ∞` (et `∘, δ`) |
| `B+C` | appliquée | `B` avec `C` pour les NaN (composante NaN retirée de l'hypothèse d'environnement) |
| `D` | binaire total : consigner l'ordonnancement complet des réceptions inter-acteurs | identité binaire de l'exécution globale |
| `D-loc` (ajout) | consigner **localement** (par boîte) le choix du message à chaque réception | identité binaire **par acteur**, sans ordre total ; coût proportionnel au nombre de réceptions |
| `A+C` (ajout) | logique seul pour la promesse, avec la spécification des singularités | l'égalité de couche 3 compare des classes ; aucun engagement binaire |

## 4. Pour chaque option : ce qu'elle impose, casse, coûte

### 4.1 `A`

* **Impose** : réécrire les formulations 3 et 5 (le binaire n'est plus « promis ») ; `thm:rejeu_binaire` (proposition) devient « propriété d'une implémentation » (statut `exigence`, qui ne porte pas d'esquisse selon le contrôle de sceau, `notation.py:101`). C'est **exactement ce que P4 dit déjà** (formulation 1).
* **Casse** : le test différentiel du ch. 6 conserve sa forme (« aucune tolérance sur le rejeu logique ; bit à bit sous le profil déclaré », formulation 6) ; `P_repr` reste « préservé par l'environnement ». **Rien d'écrit ne casse**, parce que le ch. 6 n'exige du bit à bit que sous `Π`.
* **Théorèmes et sceaux** : `thm:determinisme_rejeu` (théorème) inchangé ; `thm:rejeu_binaire` (proposition → exigence) ; `thm:representation_inobservable` (exigence) inchangée.
* **Grades, niveaux, sortes, simulation, préservation, non-interférence** : aucune interaction directe. Seule exception : le rejeu **stratifié** par niveau (`SemantiqueOperationnelle.lean:740-746` : « le rejeu intégral de P4 en est le cas où l'observateur atteint le niveau le plus haut ») ne dépend pas de la promesse binaire.
* **Coût** : `S` (texte). **Réponse à l'instruction (point 2)** : ce que le ch. 6 attend du rejeu binaire est borné au profil déclaré ; la voie `A` suffit à l'oracle.

### 4.2 `B`

* **Impose** : une **exigence** sur le compilateur et l'exécutif (portée « une machine », déjà celle du modèle mémoire, `EchelleDuSysteme.lean:178`) ; la fixation de `E_repro` ; la réécriture de P4 (constat 1) ; un test différentiel (exigence de réalisation). **Casse** : rien dans l'état, mais constat 3 : tant que `Π` ne porte pas l'ordonnancement ni la chaîne, `E_repro` ne s'y projette pas.
* **Théorèmes** : `thm:rejeu_binaire` reste une proposition de niveau représentation ; `P_repr` « préservé par l'environnement, sous `Π` ».
* **Coût** : `S` à `M` (texte) ; **à l'implémentation** : `L` (pipeline de validation de la Phase 9, `EchelleDuSysteme.lean:196-198`).
* **Exemple.** Même machine, même chaîne, mêmes arrondis : le journal rejoué rend une identité binaire. **Contre-exemple** : changer la version de la chaîne de compilation (réordonnancement d'instructions, contraction `fma`) change la représentation de flottants sans changer la dénotation : `E_repro` l'exclut par sa composante « version de la chaîne ».

### 4.3 `C` et `B+C`

* **Impose** : les tables de propagation (`IMPL-07`) et un abaissement SIMD qui les respecte (**correction logicielle explicite** de la propagation de charge utile, l'arithmétique matérielle ne combinant pas deux charges utiles de façon spécifiée) ; la règle d'entrée (`NaN → ⊥`, `±∞ → ∞`, `±0 → 0`) ; l'égalité de couche 3 sur les **classes** de singularités.
* **Casse** : l'écart IEEE 754 sur `∞ + ∞` (écrit) ; la conversion flottant vers roue n'est pas un aller-retour. **Dépendance** : le dossier 4 (les classes retenues : quatre, cinq ou sept) — la voie `C` vaut pour toute option du dossier 4, y compris le retrait de `∘`, `δ`.
* **Ne traite pas** : le bourrage de l'arène et l'ordre des segments après réallocation (`EchelleDuSysteme.lean:186-187`).
* **Constat 4** : sous `C`, « comportement des NaN » sort de `E_repro` et devient une obligation de **conformité** du compilateur (hypothèse de module).
* **Coût** : `S` (texte, déjà écrit au §3.2) ; réalisation `M` à `L` (correction de la propagation sur toutes les voies SIMD).

### 4.4 `D` et `D-loc`

* **`D`** : le texte (formulation 5) écarte la consignation de chaque réception parce que « le journal croîtrait au rythme des messages, ce que P3 interdit tant qu'aucune borne n'est écrite ». **Lecture à discuter** : un enregistrement par réception est de taille constante, et chaque émission coûte déjà `⟨1,1⟩` dans le type (`Send : ⟨send_m, ⟨1,1⟩⟩`, `ReglesDeTypage.lean:1421`) : le nombre de réceptions est majoré par la composante de travail des `send` du type, et le journal par ce nombre fois une constante. La borne **est donc lisible dans le type quand le travail est fini** ; elle est `ω` pour un acteur non borné (la rotation du journal, que `thm:representation_inobservable` mentionne, est alors la voie). Ce qui reste coûteux dans `D` est l'**ordre total** : le consigner demande un séquenceur global (un compteur atomique, donc un point de synchronisation que la topologie SPSC par couple (émetteur, boîte) évite, `IMPL-04`). Raisonnement de rédacteur, non vérifié.
* **`D-loc` (variante ajoutée)** : chaque acteur consigne, à chaque réception, **quel anneau a été choisi** (le choix de la garde, « premier dans l'ordre fixe des émetteurs » parmi les anneaux non vides) ; pas d'ordre total, pas de point de synchronisation (chaque consommateur écrit son journal), coût proportionnel au nombre de réceptions, `log₂` du nombre d'émetteurs par entrée. Elle donne l'identité binaire **par acteur** (constat 5) sans séquenceur global. Ce que `D-loc` ne donne pas : la reproduction de l'ordonnancement global (utile au débogage de courses, non à la correction).
* **Théorèmes touchés** : `thm:determinisme_rejeu` (inchangé : il suppose déjà le journal complet) ; `thm:rejeu_binaire` (hypothèse « ordonnancement » de `E_repro` s'allège pour l'état par acteur).
* **Coût** : `D` : `L` (séquenceur, borne) ; `D-loc` : `M` (écriture d'un format de journal et d'une règle) ; aucune n'est dans le texte aujourd'hui.

### 4.5 `A+C`

Promesse : logique seule (P4 inchangé) ; la spécification des singularités sert l'égalité de couche 3 et l'oracle du ch. 6 (comparaison sur classes). Retire du texte la formulation 5 comme « promesse » et la ramène à une **exigence** de réalisation. Coût `S`. Ne cède rien de ce que le ch. 6 demande.

## 5. `E_repro` à quatre composantes : analyse

| Composante | Qui la fixe | Coordonnée de `Π` | Vérifiable par | Remarque |
|---|---|---|---|---|
| ordonnancement | l'exécutif | **aucune** (`mem` est un modèle mémoire) | ? | pour l'état **par acteur**, l'ordre d'exécution des autres acteurs n'intervient pas si le journal local consigne l'ordre d'arrivée (constat 5) ; il intervient pour une disposition mémoire dépendant de l'allocation concurrente, que le texte ne traite pas |
| mode d'arrondi | le compilateur et l'exécutif | `round` | test différentiel (arrondi) | seule composante qui s'y projette sans réserve |
| version de la chaîne de compilation | l'environnement de build | **aucune** (`v_MLIR` est la version d'une spécification) | reproductibilité de la build | critère de « compilation reproductible » (C6 : « toute passe appliquée est déterministe », `StrategiesDeVerificationEtDeTest.lean:105-106`) |
| architecture et comportement des NaN | la machine | `arch` | test différentiel | sous la voie `C`, le comportement des NaN est une conformité du compilateur, non une hypothèse (constat 4) ; l'architecture reste (contraction `fma`, dénormalisés, ordre des opérations vectorielles) |

**Ce que l'analyse suggère** : `E_repro` aurait trois composantes réelles (arrondi, chaîne, architecture) si l'on retient `C` pour les NaN et le journal local pour l'ordre ; deux de ses quatre composantes (ordonnancement, chaîne) n'ont pas de coordonnée dans `Π`. Ce sont des lectures, non des corrections : `E_repro` « à quatre composantes » est ce que le texte dit et l'orientation appliquée.

## 6. Recommandation argumentée

1. **Garder « B puis C »** (appliquée), avec `A` en repli, et **harmoniser les six formulations** (§2) : c'est le défaut principal, plus que le choix de voie. Concrètement : (i) P4 doit dire que le binaire est une **proposition** sous `E_repro` (renvoi à `thm:rejeu_binaire`) et non « une propriété de déploiement » seulement ; (ii) la formulation 3 doit porter « sous `E_repro` » ; (iii) `Π` doit dire comment `E_repro` s'y projette (§7.3).
2. **`C` plutôt que « NaN dans `E_repro` »** : une seule des deux, pas les deux. Je recommande de **retirer « comportement des NaN » de `E_repro`** une fois `IMPL-07` ratifiée (le dossier 4 est la dépendance) et de dire que la conformité du compilateur aux tables est une hypothèse de module ; l'hypothèse d'architecture porte alors sur `fma`, dénormalisés, vectorisation.
3. **Dire que la promesse est par acteur** (constat 5, §7.2) : cela rend lisible ce que `B` promet et pourquoi l'exclusion du « multi-acteurs » ne coûte rien à la correction.
4. **`D` : rester écartée.** Si l'auteur veut un rejeu global pour le débogage, `D-loc` en est la version bon marché (consignation locale du choix d'anneau), à étudier lors de l'écriture du format de journal, non maintenant.
5. **Ne pas passer à `A` tant que la réalisation n'a pas échoué** : `A` est déjà ce que P4 dit, et ne coûte aucun énoncé ; la décision est donc réversible à tout moment (repli sans perte).
6. **Ce que la recommandation ne tranche pas** : la composante « ordonnancement » (à quoi elle sert pour l'état par acteur : une disposition mémoire sensible à l'allocation concurrente ?) ; le choix entre exigence et proposition pour `thm:rejeu_binaire`.

## 7. Formulations prêtes à écrire (non appliquées)

### 7.1 P4, paragraphe « Deux degrés de rejeu » (`Postulats.lean:185-191`, remplace la fin du paragraphe)

```
Deux degrés de rejeu se distinguent, faute de quoi l'énoncé promet plus qu'il ne tient. Le rejeu _logique_ —
même journal, même suite d'états observables — est ce que P4 garantit : il ne dépend que de la
journalisation des sources de non-déterminisme, et le système de types suffit à l'établir. Le rejeu _bit à
bit_ est énoncé au chapitre 4 (théorème {num "thm:rejeu_binaire"}[]) sous une hypothèse d'environnement
reproductible, et il ne vaut que sur une machine : il suppose un mode d'arrondi, une version de la chaîne de
compilation et une architecture identiques, que ce document ne fixe pas et que le journal ne consigne pas. Il
n'est donc pas une garantie du langage mais une propriété de conformité du compilateur et de l'exécutif à un
profil donné.
```

### 7.2 §4.5 : la portée par acteur (après « Ce que ce document promet du rejeu binaire tient donc en trois clauses »)

```
Cette promesse est _par acteur_ : le journal d'un acteur porte la suite de ses messages entrants, dans l'ordre
où il les a reçus, et le rejeu d'un acteur ne dépend d'aucun autre ordonnancement. Ce qui n'est pas promis est
la reproduction de l'ordonnancement global des réceptions entre acteurs, que seul un séquenceur commun
consignerait ; c'est lui, et non l'ordre d'arrivée chez chaque acteur, que cette clause exclut.
```

### 7.3 Profil `Π` et `E_repro` (`EchelleDuSysteme.lean:191-195`)

```
$`E_{\text{repro}}` en est la projection sur $`\mathrm{round}`, sur $`\mathrm{arch}`, et sur deux
coordonnées que le profil doit porter pour cela : la version de la chaîne de compilation
$`v_{\mathrm{chaîne}}` et l'ordonnancement $`\mathrm{ord}`. Le comportement des NaN n'est pas une coordonnée de
l'environnement : il est celui que spécifient les tables de propagation (§{num "sec:c3-les-contraintes-de-valeur"}[]),
et la conformité du compilateur à ces tables est une hypothèse de module.
```

(Le label `sec:c3-les-contraintes-de-valeur` existe, `LesContraintesDeValeur.lean:22`.)

## 8. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| ratifier « B puis C » | écriture des §7.1 à §7.3 ; `P_repr` « préservé sous `Π` » ; `ARB-PR-04` fermée |
| retirer « NaN » de `E_repro` | dépend de `IMPL-07` et du dossier 4 ; allège l'hypothèse d'environnement |
| `A` (repli) | suppression de la promesse du §4.5 ; `thm:rejeu_binaire` en exigence |
| `D-loc` | format de journal ; débogage de courses (à instruire à l'implémentation) |
| harmoniser P4 et §4.5 | cohérence des six formulations ; lecture du test différentiel |

## 9. Ce qui reste ouvert

La vérification **par test** de `Injectivité(obs, repr)` (arrondi, NaN) : exigence de réalisation ; le bourrage de l'arène et l'ordre des segments après réallocation (non traités par `C`) ; la mesure du coût de la correction logicielle de la propagation SIMD ; la lecture de IEEE 754-2019 (§6.1, §7.2) et de la note d'ingénierie du Disruptor (aucune relue ici).

## 10. Niveau de vérification

* **Lu** : `Postulats.lean:168-199`, `EchelleDuSysteme.lean:85-198`, `LeProcessusDeCompilation.lean:180-211`, `StrategiesDeVerificationEtDeTest.lean:88-108`, `LesContraintesDeValeur.lean:503-521`, `SemantiqueOperationnelle.lean:255-259, 740-746`.
* **Constats 3, 4, 5 du §2.1** : lectures de rédacteur ; le constat 3 se lit sur la liste de `Π` ; le constat 5 sur `thm:determinisme_rejeu` (« les messages journalisés `J(H)` » d'un acteur) ; **non vérifiés par un modèle**.
* **Lecture du coût de `D`** (§4.4) : raisonnement de rédacteur, non vérifié, non mesuré.
* **Sources externes** : aucune relue.

Renvois : [`instruction-arb-pr-04`](../instruction-arb-pr-04-rejeu-binaire.md) ; [04, singularités](04-singularites-comp-et-delta.md) ; [`DECISIONS.md`](../../suivi/DECISIONS.md) (`ARB-PR-04`, `IMPL-07`) ; [`hypotheses-de-module`](../../suivi/hypotheses-de-module.md).
