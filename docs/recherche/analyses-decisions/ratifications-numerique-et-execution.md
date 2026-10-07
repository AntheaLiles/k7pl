<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Ratifications : le numérique et l'exécution (rejeu, singularités, boîtes aux lettres)
> **Résolu le 7 octobre 2026 (relecture de la PR n° 10).** La régression de `BLOQ-12` décrite ci-dessous a été réparée avant la fusion : la règle par réunion d'étiquettes, la note de sources, le journal 02-33 et le contrôle `scripts/controles/singularites.py` sont présents dans l'état de la PR. Les mentions de « `HEAD` » et les actions « rétablir `504739d` » décrivent l'état *avant* réparation ; les hashs cités (`504739d`, `d08f92b`, `97788c3`, `5449b35`) désignent des commits fusionnés en un seul par le squash de la PR et ne sont plus atteignables.

Fiches traitées : `ARB-PR-04` (voie B puis C), `IMPL-07` et `BLOQ-12` (tables de propagation, règle d'entrée, `∘` et `δ`), `IMPL-04` (topologie des boîtes aux lettres). Elles portent sur le §3.2 (`spec/Spec/C3/LesContraintesDeValeur.lean`), le §4.5 (`spec/Spec/C4/EchelleDuSysteme.lean`), le §4.7 (`C4/SemantiqueOperationnelle.lean`) et le postulat P4 (`C1/Postulats.lean`).

**Niveau de vérification.**

* Lecture directe du Verso aux lignes citées, de l'instruction (`instruction-des-decisions.md`, `instruction-arb-pr-04-rejeu-binaire.md`), des journaux 31 et 32 (§A.2), du CSV.
* **Calculs refaits** : (a) les deux tables de propagation, recalculées à la main sur la construction par couples du texte ; (b) les lois de monoïde sur l'extension `∘`/`δ`, testées par un petit programme (hors dépôt) sur la roue des fractions du corps à trois éléments, plus `∘` et `δ` ; (c) une recherche exhaustive sur toutes les tables d'absorption par classe. Le programme teste aussi sept lois de la théorie des roues **telles que je les retiens de mémoire** : ce n'est pas une lecture de l'article de Carlström, **dont je n'ai pas lu le corps** (aucune source externe n'est atteignable, et je n'en cite aucune de mémoire comme preuve). Ce que le texte dit de Carlström et de Bergstra–Ponse est repris sous sa propre réserve (notice confirmée, corps non lu).
* **Rien n'a été compilé.** Les corrections sont des textes proposés, **non appliqués**.

Portes concernées : P1 (aucun bloquant : `BLOQ-12`), P3 (`ARB-PR-04` appliquée, à ratifier), P4 (huit exigences `IMPL` : `IMPL-04` et `-07` à ratifier).

## Avertissement préalable : le texte analysé pour `BLOQ-12` est celui du `HEAD`, qui a régressé

Le texte de `LesContraintesDeValeur.lean:483-501` que j'ai lu et analysé ci-dessous (règle « borne supérieure », associativité affirmée) est celui de la **séance 32**. Le dépôt a porté, le 7 octobre, une **séance 33** (commits `d08f92b` et `504739d` : `docs/journal/2026-10-07-pr-02-33-sources-des-singularites.md`, `docs/recherche/sources-singularites.md`, `scripts/verif_singularites.py`, `scripts/controles/singularites.py`) qui avait **déjà constaté la non-associativité**, réécrit les règles de `∘` et `δ` comme **réunion d'étiquettes** (`∘δ` cinquième singularité, `⊥` n'absorbe plus les erreurs, l'extension « n'est pas une roue », dit le texte) et branché un contrôle des tables. Le commit `97788c3` (« étudier le fil de temps de la fibrille engendrée par `spawn` ») a **défait** cette correction (les quinze fichiers de `d08f92b` et les cinq de `504739d`) : ces fichiers ne sont plus dans l'arbre courant. Le dossier [`04-singularites-comp-et-delta.md`](04-singularites-comp-et-delta.md) (agent « conception ») le relève aussi, §0, et recommande de **rétablir `504739d`** avant toute décision.

Ce que cela change pour ce fichier : (a) mon constat de non-associativité est **confirmé indépendamment** par la séance 33 (même contre-exemple, `(∞ + ∞) + ∘`) ; (b) la variante « `⊥` étiqueté » de mes alternatives est celle que la séance 33 a écrite (réunion d'étiquettes) ; (c) **le verdict ci-dessous se lit en deux temps** : sur le `HEAD` actuel, `∘` et `δ` ne se ratifient pas ; une fois `504739d` rétabli, la définition par réunion d'étiquettes se ratifie (ou se retire, au choix de l'auteur) ; (d) la fiche `IMPL-07` n'est pas touchée (les tables des quatre classes sont les mêmes dans les deux états). Le niveau de vérification des sources de la séance 33 est celui du journal : **aucun corps d'article lu**.

## `BLOQ-12` : les singularités `∘` et `δ`, et le Th. 18 requalifié

### Ce qui a été appliqué

* Séance 31 (commit `d346425`) : `thm:homomorphisme_roues` réécrit en proposition de représentation (`status := "proposition"`) ; l'arithmétique des singularités devient une spécification de K7PL (tables).
* Séance 32 §A.2 (commit `ebb2348`), `LesContraintesDeValeur.lean:483-501` : `∘` et `δ` **définis** comme extension de K7PL, sans source : deux classes d'erreur absorbantes, distinctes entre elles et de `⊥` ; (a) elles absorbent `0`, `x`, `∞` (`c + ∘ = ∘`, `c·∘ = ∘`, `1/∘ = ∘`) ; (b) `∘ ⋆ ∘ = ∘` ; (c) `∘ ⋆ δ = ⊥`, et `⊥` absorbe `∘` et `δ` ; le résultat est « la borne supérieure des classes d'erreur de ses opérandes », et « `+` et `·` restent commutatives et associatives sur les six classes ».
* Décision de l'auteur (6 octobre) : « Les singularités sont à définir, leurs propagations réelles sont à sourcer dans les références. » Le texte dit lui-même que la propriété « que les lois de la roue tiennent sur cette extension n'est pas vérifiée contre l'article de Carlström » et que retirer `∘` et `δ` de l'encodage « ne modifierait rien d'autre ».
* L'alternative laissée à l'auteur : retirer `∘` et `δ`.

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* La correction `1/0 = ∞`, `0/0 = ⊥` (et non `1/0 = ⊥`) est faite.
* `thm:homomorphisme_roues` est bien une proposition sans homomorphisme : (i) injectivité de l'encodage sur les singularités, (ii) `select` exact, (iii) arithmétique spécifiée par les tables. Il ne dépend pas de `∘`/`δ`, comme le texte le dit (et comme je le vérifie : seules les lignes (i) et l'énumération « quatre singularités » en parlent).
* `∘` et `δ` n'apparaissent que dans ce paragraphe de `LesContraintesDeValeur.lean` (grep des occurrences de `Wheel` et `singularit` dans `spec/Spec` : le §4.5 ne parle que de « classes de singularités »). **Leur retrait est donc local**, ce qui fait de l'alternative de l'auteur une option à très faible coût.

**Défauts relevés.**

1. **Le texte affirme une propriété fausse : `+` et `·` ne sont pas associatives sur les six classes** (vérification à la main, sur les règles du texte seules, sans aucune référence extérieure).
   * Addition : `(∞ + ∞) + ∘ = ⊥ + ∘ = ⊥` (table : `∞ + ∞ = ⊥` ; clause (c) : `⊥` absorbe `∘`), mais `∞ + (∞ + ∘) = ∞ + ∘ = ∘` (clause (a) : `∘` absorbe `∞`). Deux résultats distincts pour le même terme.
   * Produit : `(0 · ∞) · ∘ = ⊥ · ∘ = ⊥` (table : `0·∞ = ⊥`), mais `0 · (∞ · ∘) = 0 · ∘ = ∘`.
   * La cause est structurelle : la clause « le résultat est la borne supérieure des classes d'erreur des opérandes » suppose que les classes `0`, `x`, `∞` n'ont **pas** de classe d'erreur, or `∞ + ∞` et `0·∞` en produisent une (`⊥`). Un `⊥` produit par l'opération ne se comporte pas comme un `⊥` entré. Programme de test : sur la roue du corps à trois éléments, l'associativité échoue pour 12 triplets, dont `(0, ∞, ∘)`.
2. **Il n'existe pas d'absorption par classe qui répare cela tout en gardant les lois de la roue.** Recherche exhaustive (les 128 tables d'absorption par classe : pour chacune des classes `0`, `x`, `∞`, `∘` absorbe ou rend `⊥`, séparément pour `+` et pour `·` ; `1/∘ ∈ {∘, ⊥}` ; `δ` symétrique de `∘`, `∘ ⋆ δ = ⊥`, `⊥` absorbant) : aucune ne satisfait ensemble commutativité, associativité et les sept lois de roue que je retiens de mémoire. La seule extension non dégénérée qui satisfasse les lois de monoïde et la plupart de ces lois demande `∞ + ∘ = ⊥` et `1/∘ = ⊥`, ce qui contredit les clauses (a) du texte ; et même celle-ci échoue sur la loi `(x + y)z + 0z = xz + yz` et sur la multiplicativité de l'inverse, `/(xy) = /x · /y`. **Réserve** : ce second constat dépend de ma mémoire des axiomes de Carlström, que je n'ai pas relus ; seul le premier (non-associativité) ne dépend d'aucun axiome.
3. **Le test de ma mémoire sur la roue de base est positif** (le programme vérifie les sept lois, plus commutativité, associativité et involution de `/`, sur les cinq éléments de la roue du corps à trois éléments : zéro échec). Ce n'est pas une preuve que ces lois sont celles de l'article ; c'est une indication que je ne les ai pas mal retenues.
4. **Le texte rédige lui-même la réserve** (« non vérifié contre l'article de Carlström »). La vérification demandée par la fiche est donc, pour moi, plus qu'une formalité : elle échoue sur un point (associativité) que n'importe quel lecteur peut vérifier avec les tables du texte.
5. **L'énoncé « Aucune des sources atteintes ne porte deux classes d'erreur distinctes de `⊥` »** est exact au sens des notices (une roue : un `⊥` ; un méadow commun : une valeur d'erreur) ; il fait de `∘`/`δ` une invention de K7PL, ce que le texte assume. Le motif d'usage donné (« deux erreurs qu'un programme veut distinguer de `0/0` ») n'est fondé par aucun exemple du manuscrit : je n'ai trouvé aucune occurrence de `∘`/`δ` dans les chapitres 4 à 7, les études de cas ou les codes d'erreur de l'annexe A.

### Alternatives écartées et pourquoi

| Alternative | Pourquoi écartée (par l'auteur ou par l'instruction) |
|---|---|
| Tout `NaN` lu `⊥`, rien d'autre (pas de `∘`, `δ`) | c'est l'option « retirer » laissée à l'auteur ; elle est la plus pauvre en classes, la seule à être couverte par les sources lues (notices) |
| `∘` et `δ` comme `⊥` étiquetés (couples valeur-étiquette) | non écrite ; rend la propagation associative (union d'étiquettes) mais `⊥` n'absorbe plus `∘` (la loi `0/0 + x = 0/0` de la roue échoue dès que `x` porte une étiquette) ; ce n'est donc plus une roue, seulement un produit d'une roue par un demi-treillis |
| Absorption simple `∘`, `δ` (ce qui est écrit) | non associative (défaut 1) |

### Risque si on ratifie

**Élevé pour `∘` et `δ`** : on ratifie une définition dont une affirmation explicite (« associatives sur les six classes ») est fausse et qu'aucune source ne couvre. **Faible pour `⊥` et `∞`** : ces deux classes et leurs tables sont calculées sur la construction de la roue des fractions et je les ai recalculées (voir `IMPL-07`).

### Risque si on refuse

Faible. Retirer `∘` et `δ` est local (une phrase de la proposition, un paragraphe de définition) ; rien d'autre ne les emploie. Le seul coût est de perdre deux classes que le texte dit réservées « à des erreurs qu'un programme veut distinguer » sans en donner d'usage.

### Ce que la ratification débloque ou ferme

* `BLOQ-12` : la fiche reste « partielle » pour la porte **P1** (« 3 partielles dont `BLOQ-12` à la définition de `∘` et `δ` » au tableau de bord) ; la retirer ou la corriger la ferme.
* Dépendance : `IMPL-07` dépend de `BLOQ-12` (`depend = BLOQ-12`). Retirer `∘`/`δ` ne touche pas les tables de `IMPL-07` (leurs quatre classes sont inchangées).
* `ARB-PR-04` (voie C) n'en dépend que pour `⊥` et `∞`.

### Verdict recommandé

**Ratifier le traitement de `⊥` et `∞` ; ne pas ratifier la définition de `∘` et `δ` du `HEAD` (règle « borne supérieure », non associative).** Deux sorties : **(1) rétablir la séance 33** (`504739d`) et ratifier la **réunion d'étiquettes** (associative, dite « pas une roue » dans le texte, contrôlée par `singularites.py`), recommandation de [`04-singularites-comp-et-delta.md`](04-singularites-comp-et-delta.md) ; **(2) retirer `∘` et `δ`** de l'encodage (alternative de l'auteur). Les deux sont compatibles avec mon analyse ; (1) garde les deux classes d'erreur sans source au prix d'une extension qui n'est pas une roue, (2) est la plus pauvre et la seule entièrement couverte par les sources lues. **Je recommande (1) si l'auteur veut garder deux classes distinctes et (2) sinon ; je ne recommande pas de garder le texte du `HEAD`.**

### Correction minimale proposée (non appliquée)

**Voie recommandée (retrait).**

* `LesContraintesDeValeur.lean:344-347` : remplacer « `⊥`, `∞`, `∘`, `δ`, constructeurs d'un type algébrique `Wheel<T>` … Les deux premières viennent de la théorie des roues ; les deux dernières sont une extension de K7PL, définie plus bas. » par « `⊥` et `∞`, constructeurs d'un type algébrique `Wheel<T>` distinct du flottant IEEE 754 sous-jacent, dont la conversion reste explicite dans les deux sens ; ils viennent de la théorie des roues. »
* `:360-362` : « chacune des quatre singularités (`⊥`, `∞`, `∘`, `δ`) » devient « chacune des deux singularités (`⊥`, `∞`) » ; « injective sur ces quatre singularités » devient « … sur ces deux singularités ».
* `:483-501` (paragraphe « Les deux autres singularités du texte ») : remplacer par :

> K7PL ne définit pas d'autre classe d'erreur que `⊥` : une roue n'a que deux éléments hors du corps, `∞ = 1/0` et `⊥ = 0/0`, et un méadow commun, l'autre structure où la division est totale, n'a qu'une seule valeur d'erreur. Deux classes d'erreur supplémentaires, absorbantes et distinctes de `⊥`, ont été envisagées et écartées : la règle d'absorption la plus simple n'y est pas associative (`(∞ + ∞) + ∘ = ⊥` mais `∞ + (∞ + ∘) = ∘`), et aucune source lue ne définit une telle extension.

**Voie alternative (si l'auteur garde `∘`, `δ`)** : remplacer la clause « `+` et `·` restent commutatives et associatives sur les six classes » par la définition associative la plus simple que j'aie trouvée à la recherche exhaustive (pour les lois de monoïde seulement, pas pour la distributivité de la roue) : `∘` et `δ` absorbent `0` et `x` pour l'addition, `x` pour le produit ; `∞ + ∘ = ⊥`, `0·∘ = ∞·∘ = ⊥` et `1/∘ = ⊥` (même chose pour `δ`) ; `∘ ⋆ δ = ⊥` ; `⊥` absorbe. Ce choix **n'est pas une roue** (la loi `(x + y)z + 0z = xz + yz` et la multiplicativité de l'inverse y échouent pour certains triplets) et **le texte ne devra plus dire que les lois de la roue tiennent**. **Texte conjectural, vérifié seulement par le programme de test ; décision de modèle réservée à l'auteur.**

## `IMPL-07` : tables d'addition et de produit, règle d'entrée Float64 → roue

### Ce qui a été appliqué

* Séance 31 (commit `d346425`), §3.2 (`LesContraintesDeValeur.lean:389-482`) : `tab:propagation-addition` et `tab:propagation-produit` sur les classes `0`, `x`, `∞`, `⊥` ; règle d'entrée : NaN lu `⊥`, `±∞` lus `∞` (identifiés), `±0` lus `0` ; l'égalité de couche 3 compare les classes ; séance 32 : valeurs calculées sur la roue des fractions, écart d'IEEE 754 sur `∞ + ∞` écrit.
* Orientation de l'instruction : la table est celle de la théorie des roues, plus une règle explicite pour les deux infinis (les identifier ou les distinguer).

### Relecture critique face au manuscrit actuel

**Ce qui tient (recalculé à la main).** Sur la construction du texte (couples `(a, b)` modulo les multiples non nuls, somme `(ad + bc, bd)`, produit `(ac, bd)`, `0 = (0,1)`, `∞ = (1,0)`, `⊥ = (0,0)`) :

* addition : `0 + ∞ = (1,0) = ∞`, `x + ∞ = ∞`, `∞ + ∞ = (0,0) = ⊥`, `⊥` absorbant, `0 + x = x` : les seize cases de `tab:propagation-addition` sont exactes ;
* produit : `0·∞ = (0,0) = ⊥`, `x·∞ = (a,0) = ∞`, `∞·∞ = ∞`, `0·x = 0`, `⊥` absorbant : les seize cases de `tab:propagation-produit` sont exactes ;
* inverse : `1/0 = ∞`, `1/∞ = 0`, `1/⊥ = ⊥`, comme écrit.

Ces tables, restreintes aux classes `0`, `x`, `∞`, `⊥`, sont donc correctes **sous réserve de la lecture de la case « fini »** (voir plus bas), et indépendantes de `∘`/`δ`.

**Défauts relevés.**

1. **La case « fini » masque deux comportements distincts.** `x + x'` (deux finis non nuls) peut valoir `0` : la classe `x` n'est pas fermée pour `+` ; le texte l'indique en écrivant « fini » et en précisant que « fini » est « le résultat de l'opération sur les valeurs finies que la représentation flottante calcule » (`:470-471`). Mais **en flottant, le résultat peut aussi sortir des finis** : `1e308 + 1e308` rend `+∞` en IEEE 754 (dépassement de capacité), `x·x'` aussi. La table dit « fini » ; le matériel rend `∞`, lu `∞` par la règle d'entrée : la table et le matériel diffèrent, et le texte n'écrit pas ce cas. Le test différentiel prévu (« hors de ce cas », `:480`) ne l'exclut pas non plus. C'est un trou, pas une erreur de la table : le dépassement de capacité flottant n'a pas de contrepartie dans la roue des fractions d'un corps (qui n'en a pas). **Non résolu dans le texte.** (L'overflow entier est traité à `:523-526`, pas le flottant.)
2. **L'écart d'IEEE 754 est cité pour `∞ + ∞` mais il porte aussi sur la soustraction.** `+∞ − (−∞)` rend `+∞` en IEEE 754 ; en roue, `−∞ = ∞` (identification des deux infinis) et `∞ − ∞ = ∞ + ∞ = ⊥`. Le texte ne parle que de l'addition de même signe (`:477-480`) ; la précision à faire est « addition de deux infinis de même signe et soustraction de deux infinis de signes opposés ».
3. **Un même objet, deux représentations de `∞`.** L'encodage `i` (`thm:homomorphisme_roues` (i)) représente `∞` par un motif de bits **dans la charge utile d'un NaN**, et la règle d'entrée lit l'**infini IEEE** comme `∞`. Les deux sont cohérents (l'un est la représentation interne des valeurs `Wheel`, l'autre le mode de lecture du matériel), mais le texte ne dit nulle part ce que devient un `∞` encodé qui traverse une opération matérielle. Sa réponse est l'exigence (iii) : l'arithmétique est « spécifiée par K7PL, non déléguée à IEEE 754 », donc réalisée par le compilateur ; c'est une exigence de la réalisation, et non un fait démontré.
4. **La règle d'entrée donne le sens `Float64 → Wheel` ; le sens `Wheel → Float64` est dit « explicite »** (`:345`) sans être spécifié : quel infini IEEE rend `∞` ? Le texte dit seulement que la conversion « n'est pas un aller-retour sur les infinis » (`:477`).
5. **La division** est ramenée au produit par l'inverse, `a/b = a·(1/b)`, ce qui est la définition de la roue ; `x/x = 1 + 0x/x` vaut `1` pour `x` fini non nul et `⊥` pour `0` et `∞` : cohérent avec IEEE 754 (`∞/∞` et `0/0` rendent NaN), pas écrit.
6. **Dépendance à `BLOQ-12`** : si `∘`/`δ` sont retirées, le paragraphe `:483-501` change, les tables ne changent pas.

### Alternatives écartées et pourquoi

* **Distinguer `+∞` et `−∞`** (au prix d'une division par zéro signée) : écartée ; la roue a un seul infini non signé et la distinction ferait sortir K7PL de la théorie des roues.
* **Déléguer la propagation à IEEE 754** : écartée ; la propagation de la charge utile d'un NaN n'est que recommandée par la norme (`BIB-08`, texte), donc K7PL ne peut pas s'y fier.
* **Tables sur davantage de classes** (`+0`, `−0`, `±∞`) : non écrite ; elles auraient contredit la lecture « roue ».

### Risque si on ratifie

Faible pour les tables (recalculées). Moyen pour la formulation : on ratifie « test différentiel hors du cas `∞ + ∞` » alors que le dépassement de capacité et la soustraction d'infinis opposés échappent aussi à la table ; le test différentiel prévu aura donc des écarts imprévus.

### Risque si on refuse

Moyen : `ARB-PR-04` (voie C) perdrait ce qui rend `Injectivité(obs, repr)` vraie par définition sur les singularités ; il faudrait retomber sur la voie A (rejeu logique seul) ou sur une vérification par test de l'injectivité.

### Ce que la ratification débloque ou ferme

Ferme `IMPL-07` (porte **P4** : une des deux exigences `IMPL` encore à ratifier) ; soutient `ARB-PR-04` (voie C) ; dépend de `BLOQ-12` au CSV (le CSV demande de fermer `BLOQ-12` d'abord, ce que le retrait de `∘`/`δ` permet sans toucher aux tables).

### Verdict recommandé

**Ratifier avec correction** : tables et règle d'entrée, oui ; ajouter les deux précisions (défauts 1 et 2) pour que le test différentiel d'`IMPL-03` ne découvre pas ces écarts à la réalisation.

### Correction minimale proposée (non appliquée)

À `LesContraintesDeValeur.lean:477-480`, remplacer « Et un écart subsiste sur l'addition : `+∞ + (+∞)` rend `+∞` en IEEE 754 quand les signes concordent, alors que la roue, qui n'a qu'un seul infini, rend `⊥` (`∞ + ∞ = ⊥`). » par :

> Et deux écarts subsistent. Sur l'addition de deux infinis de même signe (et la soustraction de deux infinis de signes opposés), IEEE 754 rend un infini, alors que la roue, qui n'a qu'un seul infini, rend `⊥` (`∞ + ∞ = ⊥`). Et la case « fini » des tables est le résultat sur les valeurs finies : le dépassement de capacité d'une somme ou d'un produit de finis rend un infini en IEEE 754, lu `∞`, alors que la roue d'un corps n'en a pas.

et « le test différentiel compare donc à IEEE 754 hors de ce cas » par « … hors de ces deux cas ». Une phrase sur la conversion inverse, après la règle d'entrée : « La conversion d'une roue vers un flottant rend `NaN` pour `⊥` et `+∞` pour `∞`. » **(choix de modèle de l'auteur ; je ne sais pas lequel il retient.)**

## `ARB-PR-04` : le rejeu binaire, voie B puis C

### Ce qui a été appliqué

* Séance 31 (commit `d346425`), §4.5 (`EchelleDuSysteme.lean:145-198`) et ch. 1 (`Postulats.lean:166-190`) : `E_repro` à quatre composantes (ordonnancement, mode d'arrondi, version de la chaîne, architecture et comportement des NaN) ; promesse de l'identité binaire **sur une machine** ; pas de rejeu binaire multi-acteurs (journal non borné, contraire à P3) ; la charge utile d'un NaN hors de l'égalité observable (voie C) ; repli sur le rejeu logique (voie A) si la réalisation ne tient pas.
* Séance 31 a aussi corrigé le texte qui disait « aucune des trois composantes » alors que l'énoncé en listait quatre.
* Profil de représentation `Π` (`EchelleDuSysteme.lean:191-198`, `IMPL-06`) : `E_repro`, la portée « une machine » et l'élision de champ en sont trois projections.
* Source : l'orientation « B puis C » de `instruction-arb-pr-04-rejeu-binaire.md` §4.

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* Les quatre composantes sont écrites de la même manière en trois endroits (énoncé de `thm:rejeu_binaire`, `:153-154` ; esquisse, `:171-172` ; clause de promesse, `:177-180`) et au postulat P4 (`Postulats.lean:188-190`). Le compte est cohérent.
* La proposition `thm:rejeu_binaire` est sous hypothèse d'injectivité, nommée ; l'esquisse le dit.
* La voie C est cohérente avec §3.2 : l'égalité de couche 3 compare les classes (`LesContraintesDeValeur.lean:480-482`) et le §4.5 dit que l'injectivité « reste à vérifier pour le bourrage de l'arène et l'ordre des segments après réallocation, que cette clause ne traite pas ».
* La portée « une machine » est celle que le modèle mémoire déclare déjà (`:472-480` : le modèle acquisition-libération ne gouverne que la mémoire partagée d'une machine).
* Le repli (voie A) est écrit.

**Défauts relevés.**

1. **P4 et le §4.5 ne disent pas la même chose du journal en couche 2.** Le postulat P4 écrit : « En couche 2, il est déterministe _modulo le journal_ : l'entrelacement des acteurs est journalisé, et c'est le journal qui le restitue » (`Postulats.lean:172-173`). Le §4.5 écrit : « L'ordonnancement complet des réceptions entre acteurs n'est pas consigné, et la promesse ne s'étend pas à un rejeu binaire multi-acteurs » (`EchelleDuSysteme.lean:181-182`). Les deux se concilient (le rejeu logique n'a besoin que de l'entrelacement observable ; le rejeu binaire multi-acteurs demanderait toutes les réceptions) mais le texte ne le dit pas, et un lecteur de P4 croit que l'entrelacement est entièrement journalisé.
2. **« Promise » contre « propriété de déploiement ».** Le §4.5 (`:177`) dit « L'identité binaire est promise sur une machine » ; P4 (`Postulats.lean:188-192`) dit que le rejeu bit à bit est « une propriété de déploiement », que P4 « énonce donc le premier [rejeu logique] ». Ces deux formulations coexistent ; la proposition est conditionnelle (`E_repro`), donc la « promesse » n'est qu'une promesse **sous hypothèse**, ce qui est la lecture de P4 ; le mot « promise » du §4.5 est plus fort que celui de P4.
3. **L'ordonnancement est à la fois une composante de `E_repro` et un objet non consigné.** `E_repro` suppose l'ordonnancement « identique entre l'exécution et le rejeu » (`:153-154`), et le journal ne consigne pas l'ordonnancement entre acteurs (`:181-182`). Sur une machine, cela veut dire que l'identité binaire multi-acteurs est exclue **sauf** si l'ordonnanceur est lui-même déterministe (un fait de déploiement) ; le texte ne dit pas si « ordonnancement » dans `E_repro` désigne l'ordre intra-acteur (fixé par la sémantique) ou l'ordonnancement entre fibrilles (fait de déploiement). La différence décide si le rejeu binaire sur une machine, avec plusieurs acteurs, est promis ou non.
4. **« La charge utile d'un NaN n'est pas observable »** (`:183`) est dit alors que l'encodage `i` (`thm:homomorphisme_roues` (i)) **place la classe de singularité dans la charge utile d'un NaN** (`LesContraintesDeValeur.lean:360-362`). Ce qui n'est pas observable est la charge utile **au-delà du code de classe** ; ce que l'égalité compare est la classe, qui est lue dans la charge. La phrase du §4.5 doit dire « au-delà du code de classe ».
5. **Dépendance à `IMPL-07`/`BLOQ-12`** : la voie C ne repose que sur `⊥` et `∞` (classes lues) ; le retrait de `∘`/`δ` ne la touche pas.
6. **Points laissés ouverts par le texte** : bourrage, ordre des segments après `mremap`, purge à la rotation du journal sont dits « à vérifier » (`:186-187`) ; la borne du journal pour la voie D n'est pas écrite (voie D écartée tant qu'aucune borne).
7. **Une phrase du §4.5 promet l'identité binaire sans condition** : « si bien que l'exécution rejouée est, bit à bit, identique à l'originale » (`EchelleDuSysteme.lean:113-117`), paragraphe qui précède `thm:determinisme_rejeu` et ne mentionne ni `E_repro` ni la portée « une machine ». Elle contredit la clause de promesse (`:177-189`) et P4 (`Postulats.lean:188-192`). Relevé aussi, avec cinq autres formulations de la même promesse, par le dossier [`07-arb-pr-04-rejeu-binaire.md`](07-arb-pr-04-rejeu-binaire.md) (agent « conception »), dont les conclusions convergent avec les défauts 1 à 4 : garder « B puis C » avec repli sur A, **harmoniser les formulations**, dire la portée de la promesse (par acteur), et noter que `E_repro` n'est pas une projection de `Π` pour deux de ses quatre composantes. Ce dossier recommande d'harmoniser les six formulations ; ma correction minimale ci-dessous ne traite que quatre d'entre elles.

### Alternatives écartées et pourquoi

| Voie | Pourquoi écartée |
|---|---|
| A, logique seul | gardée comme **repli** ; elle retire P4-bit du ch. 1 et prive l'oracle de test différentiel (ch. 6) du rejeu binaire |
| C seule (exclure la charge NaN) | ne traite ni le bourrage ni `mremap` ; elle est ici l'étape qui rend l'injectivité vraie sur les singularités |
| D, binaire total | écartée tant qu'aucune borne du journal n'est écrite : P3 interdit un journal qui croît au rythme des messages |

### Risque si on ratifie

Moyen. On ratifie une promesse binaire dont trois conditions (ordonnancement, bourrage, `mremap`) ne sont pas fixées par le document ; le risque est qu'une lecture rapide fasse croire à plus que ce que la proposition dit (défauts 1 à 3). Il est atténué par le repli explicite sur la voie A.

### Risque si on refuse

Moyen à élevé : refuser B puis C revient à choisir A ou D. A retire `P_repr` de l'ordre de préservation (`STRUCT-05`/`TRANS-04` : « `P_repr` : l'identité binaire de l'état observable ») et le critère de la compilation reproductible perd sa branche binaire. D est écartée faute de borne.

### Ce que la ratification débloque ou ferme

* Ferme `ARB-PR-04` → porte **P3** (« décisions `ARB-PR-03`, `-04`, `-06`, `-07` tranchées ou ratifiées » : `-06`, `-07` tranchées, `-03` appliquée à ratifier).
* Donne leur statut de « conformité du compilateur » aux théorèmes de disposition et de rejeu binaire (profil `Π`).
* Porte `P_repr` de l'ordre de préservation (`STRUCT-05`/`TRANS-04`).
* Lie `IMPL-07` et `BLOQ-12` (voie C).

### Verdict recommandé

**Ratifier (voie B puis C) avec correction** : trois retouches de rédaction (défauts 1, 3, 4) qui n'engagent aucune décision de fond ; le repli sur A reste inscrit.

### Correction minimale proposée (non appliquée)

* `Postulats.lean:172-173`, après « l'entrelacement des acteurs est journalisé, et c'est le journal qui le restitue » : ajouter « (ce qu'il faut pour le rejeu logique ; le rejeu binaire entre acteurs demanderait de consigner chaque réception, ce que le chapitre 4 (§`sec:c4-echelle-du-systeme`) écarte) ».
* `EchelleDuSysteme.lean:153-154` : après « ordonnancement », préciser « (celui des fibrilles d'une même machine ; l'ordre dans chaque acteur est fixé par la sémantique) » ; si l'auteur préfère l'autre lecture, écrire « (l'ordre intra-acteur seul est promis) ». **Choix de portée réservé à l'auteur.**
* `EchelleDuSysteme.lean:183` : « la charge utile d'un NaN n'est pas observable » devient « la charge utile d'un NaN, au-delà du code de classe qu'elle porte, n'est pas observable ».
* `EchelleDuSysteme.lean:177` : « L'identité binaire est promise » devient « L'identité binaire est promise, sous `E_repro`, ».
* `EchelleDuSysteme.lean:116-117`, remplacer « si bien que l'exécution rejouée est, bit à bit, identique à l'originale » par « si bien que l'exécution rejouée rend le même état à l'observation près, et bit à bit identique à l'originale sous l'hypothèse d'un environnement reproductible (théorème `thm:rejeu_binaire`) ».

## `IMPL-04` : un anneau SPSC par couple (émetteur, boîte), une file de jonction par acteur

### Ce qui a été appliqué

* Séance 31 (commit `93c5501`), `EchelleDuSysteme.lean:505-538` : « un anneau SPSC par couple (émetteur, boîte), et une file de jonction par acteur » ; la capacité d'écriture d'un canal est linéaire, donc un anneau n'a qu'un producteur ; l'acteur est l'unique consommateur ; aucune extrémité n'a besoin de comparer-et-échanger ; l'appariement atomique de deux messages revient à avancer deux curseurs de consommation que l'acteur est seul à écrire ; plusieurs messages convenant : examen dans l'ordre fixe des identifiants d'émetteur (le journal restitue ce choix) ; MPSC écarté (comparer-et-échanger, P3) ; borne mémoire connue à la compilation par le graphe de câblage, chaque anneau ayant pour capacité un grade ; la boîte créée par `New` porte le sien.
* `SemantiqueOperationnelle.lean:257-258` : « celui que l'on retient est le premier dans l'ordre fixe des émetteurs ».
* Source : instruction (`IMPL-04`) ; objet `Mailbox` posé par `FACT-11` (fermée) ; support cité : Disruptor (`thompsonDisruptorHighPerformance2011`), join-calculus (`fournetReflexiveCHAMJoincalculus1996`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* L'argument principal (un producteur par anneau grâce à la linéarité de la capacité d'écriture ; un consommateur unique ; donc ni verrou ni comparer-et-échanger) est cohérent avec la règle `Guard` à motifs conjonctifs (`ANOM-17`, voie A) et avec le modèle acquisition-libération du §4.5.
* La borne par `graphe de câblage` est cohérente avec `thm:liberte_initialisation` et le tri topologique du §4.5 (graphe acyclique et donné en entier, `:343-355`).
* La restitution du choix par le journal est cohérente avec P4 (aucune source de non-déterminisme supplémentaire).

**Défauts relevés.**

1. **Contradiction interne du §4.7.** `SemantiqueOperationnelle.lean:213-215` dit que la relation de couche 2 n'est pas déterministe : « le choix de la fibrille qui avance, et celui du message que consomme une garde quand plusieurs conviennent, ne sont pas fixés par ces schémas ». Trente lignes plus bas (`:257-258`, ajouté en séance 31) : « celui que l'on retient est le premier dans l'ordre fixe des émetteurs […] ; seul le choix de la fibrille qui avance reste libre ». La première phrase est périmée.
2. **Canaux partagés : plusieurs émetteurs par canal.** Le §4.5 dit que « l'indexation de `Mailbox` par canal est cette même partition » (celle d'un anneau par producteur) parce que la capacité d'écriture est linéaire (`:524-526`). Mais le ch. 1 (`AxiomatiqueGerminale.lean:173-174, 186-190`) admet `SharedChan(p)` « affine à contraction restreinte » : plusieurs détenteurs de capacités d'écriture sur un même canal. Il y aurait alors un anneau par émetteur et non par canal ; la boîte `Σ_c Bag(Cap(c))` indexée par canal n'est plus la partition par émetteur. Le texte ne dit pas comment les deux se composent.
3. **Borne mémoire.** « Cette borne mémoire est connue à la compilation : le graphe de câblage est donné en entier, et chaque anneau a une capacité qui est un grade » (`:537-538`) suppose que le nombre d'émetteurs de chaque boîte est connu. Pour `SharedChan` à contraction non bornée, ou pour une boîte créée à l'exécution par `New` (« porte le sien »), ce nombre dépend de l'exécution. La borne vaut si la contraction est bornée par un grade (« contraction restreinte ») ; ce n'est pas écrit à cet endroit. **Je n'ai pas relu les règles de typage de `New`/`Send`** pour savoir si le nombre d'émetteurs y est borné ; absence de résultat, pas preuve du contraire.
4. **L'esquisse de `thm:sync_motifs_jonction` n'est pas alignée sur le texte ajouté.** L'esquisse dit « la réduction consomme les deux messages simultanément par échange atomique de pointeurs » (`:506-507`) ; le paragraphe suivant (`:530-533`) dit que consommer deux messages revient à avancer deux curseurs que l'acteur est seul à écrire. Ce sont deux mécanismes différents ; la seconde description est suffisante (pas de concurrence sur les curseurs de consommation), la première promet un échange atomique que personne n'exige. L'atomicité observable est celle de l'acteur seul observateur.
5. **Le soutien cité par l'instruction est inexact.** L'instruction dit « le Disruptor SPSC n'exige ni verrou ni compare-and-swap (`BIB-15`) » ; au CSV, `BIB-15` est fermée sur **une file à plusieurs producteurs et consommateurs, OCaml multicœur (Mével–Jourdan)**, dont la différence avec l'anneau à curseur unique est « écrite au §4.2 ». Le support de l'argument est la source Disruptor (texte), non `BIB-15`.
6. **Les deux fiches liées ne sont pas lues dans leur corps.** `BIB-04` (join-calculus) et `BIB-27` (types de boîtes aux lettres) sont partielles (« confirmé ; théorème d'interblocage à lire ») : le texte appuie son vocabulaire dessus sans que le corps ait été lu ; le CSV demande de les lire avant de ratifier `IMPL-04` (`suite = ratifier la topologie ; lire le corps de BIB-04 et BIB-27`). Je ne peux pas les lire ici (aucune source externe atteignable).

### Alternatives écartées et pourquoi

| Alternative | Pourquoi écartée |
|---|---|
| MPSC (une file à plusieurs producteurs par boîte) | demande un comparer-et-échanger, contraire à P3 ; simplifierait la topologie |
| un anneau par boîte, partagé, protégé par un verrou | contraire à P3 |
| boîte comme multi-ensemble sans ordre de choix (non déterminisme) | le choix devient une source de non-déterminisme à journaliser, ce que « source retirée par construction » (P4) évite |

### Risque si on ratifie

Moyen. L'idée est sûre pour les canaux à capacité d'écriture exclusive ; elle est sous-spécifiée pour les canaux partagés et les boîtes créées à l'exécution (défauts 2 et 3), et l'esquisse du théorème d'atomicité promet un mécanisme que le paragraphe suivant ne reprend pas (défaut 4). Le §4.7 se contredit sur le choix du message tant que le défaut 1 n'est pas corrigé : c'est la plus visible.

### Risque si on refuse

Moyen : la structure physique de la boîte retombe sans réponse, `Guard` à motifs conjonctifs perd la sémantique de son choix (« suit `IMPL-04` »), l'appariement atomique de `thm:sync_motifs_jonction` retombe sur « protocole à construire », que le texte dit précisément ne pas être.

### Ce que la ratification débloque ou ferme

Ferme `IMPL-04` → porte **P4** ; contribue à `BIB-04` et `BIB-27` (leur confirmation de vocabulaire se fait sur la topologie écrite) ; `FACT-11` est déjà fermée. N'intervient pas dans P1, P3. Fixe le choix du message de `Guard` pour `ANOM-17` (`guard` à motif conjonctif).

### Verdict recommandé

**Ratifier avec correction** : défaut 1 (obligatoire : contradiction de texte) ; défauts 2, 3, 4 (précisions) ; défaut 6 reste à faire hors session (lecture des sources), à tenir comme condition **non remplie** de la fiche (la ratification de la topologie peut précéder la lecture des deux articles, que le CSV pose comme suite et non comme condition d'écriture).

### Correction minimale proposée (non appliquée)

* `SemantiqueOperationnelle.lean:214-215`, remplacer « La relation de la couche 2 ne l'est pas : le choix de la fibrille qui avance, et celui du message que consomme une garde quand plusieurs conviennent, ne sont pas fixés par ces schémas. » par :

> La relation de la couche 2 ne l'est pas : le choix de la fibrille qui avance n'est pas fixé par ces schémas ; celui du message que consomme une garde quand plusieurs conviennent l'est par la structure de la boîte (§`sec:c4-echelle-du-systeme`), qui les examine dans l'ordre fixe des émetteurs.

* `EchelleDuSysteme.lean:506-507` (esquisse de `thm:sync_motifs_jonction`), remplacer « par échange atomique de pointeurs, garantissant l'atomicité verrou-libre sans synchronisation supplémentaire » par « en avançant les deux curseurs de consommation que l'acteur est seul à écrire, ce qui garantit l'atomicité verrou-libre sans synchronisation supplémentaire ».
* `EchelleDuSysteme.lean:524-526`, après « l'indexation de `Mailbox` par canal est cette même partition » : « pour un canal à capacité d'écriture exclusive ; un canal partagé (`SharedChan`) a un anneau par détenteur de capacité, et son nombre est borné par le grade de contraction qu'il autorise ».
* `EchelleDuSysteme.lean:537-538`, ajouter : « (le nombre d'émetteurs d'une boîte est borné par la contraction que son type autorise, y compris pour une boîte créée par `New`) ». **Texte conjectural : à vérifier contre la règle `New` avant adoption.**
