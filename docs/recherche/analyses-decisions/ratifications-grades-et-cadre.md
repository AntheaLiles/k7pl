<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Ratifications : le grade, les modes et le cadre unificateur

Fiches traitées : `STRUCT-16` (modes et `Rel`), `TRANS-02` (décomposition module × ordre), `FACT-12` et `STRUCT-01` (pas d'adjonction graduée unifiée, cadre), `FACT-14` (monotonie), `PREUVE-05` (loi distributive affaiblie). Elles portent sur le chapitre 1 §1.4 (`spec/Spec/C1/AxiomatiqueGerminale.lean`), le chapitre 2 (`C2/ComonadeExponentielleEtFragments.lean`, `C2/AdjonctionsEtEnrichissement.lean`), le chapitre 3 (`C3/LeSystemeGradue.lean`, `C3/ReglesDeTypage.lean`, `C3/GrammaireDesTypes.lean`) et le chapitre 5 (`C5/SExpressionsUniverselles.lean`).

**Niveau de vérification.** Lecture directe du Verso aux lignes citées, de `fiches-statuts.csv`, de `DECISIONS.md`, de l'instruction, des journaux 24, 25, 31 et 32, et des fiches d'origine (`docs/relectures/pr-02/taches-consolidees.md`). **Rien n'a été compilé ; aucune source externe n'a été relue** (les références citées par le manuscrit, Licata et al., Hanukaev, Gaboardi et al., etc., ne sont pas relues ici : je ne vérifie que ce que le manuscrit en dit). Les vérifications mathématiques ci-dessous (contre-exemples, comptes) sont les miennes, refaites à la main ; elles sont marquées comme telles. Les corrections proposées sont des textes **non appliqués** (le manuscrit porte « ne rien modifier sans l'accord de l'auteur »).

**Trois constats transversaux**, qui touchent plusieurs fiches de ce fichier, sont donnés d'abord.

* **T1. Le facteur d'usage n'est pas le même d'un chapitre à l'autre.** Le ch. 1 (`AxiomatiqueGerminale.lean:233`) et le ch. 2 (`ComonadeExponentielleEtFragments.lean:88`) posent l'usage `𝕌 = ℚ≥0 ∪ {ω}` ; le ch. 2 ajoute que les rationnels sont là parce que « les capacités de lecture divisées du chapitre 3 en ont besoin ». Le ch. 3 (`GrammaireDesTypes.lean:45`) écrit `ℛ = ℕ∞ × {d ⪯ m} × ℒ × ℬ`, usage dans `ℕ∞`, et le paragraphe de `STRUCT-16` (`LeSystemeGradue.lean:148`) dit que la grammaire laisse « u ∈ ℕ∞ libre » parce que `Lin_k` et **`1/N`** en ont besoin. Or `1/N ∉ ℕ∞`. Et le ch. 3 dit lui-même, plus bas (`LeSystemeGradue.lean:405-420`), qu'une `ReadCap<T>` « n'est pas une fraction » de la capacité d'écriture : le partage en lecture vit de l'autre côté de l'adjonction, au grade `ω`. La justification d'avoir `ℚ≥0` dans le porteur est donc contredite par le ch. 3.
* **T2. Aucun texte ne définit l'action de `𝕌` sur le budget `𝔅`.** `TRANS-02` dit que `𝔅 = ℕ∞` est un « module sur `𝕌` » et que `r·Δ` est défini grâce à cela (effet iv). Un `ℚ≥0` n'agit pas sur `ℕ∞` par multiplication (`(1/2)·1 ∉ ℕ∞`). J'ai cherché « module sur », « action de », « action triviale » dans `spec/Spec` : aucune définition de l'action. Tant qu'elle n'est pas écrite, « module sur `𝕌` » est une affirmation, pas un fait.
* **T3. `1 ⊑ ε` est employé sans être posé.** L'unité de la quantale d'effets (l'absence d'effet) est supposée plus petite que tout effet : c'est ce qu'emploie `SemantiqueOperationnelle.lean:414` (`τ·1 ⊑ τ·f(ε_c)` « puisque `1` est le neutre et l'ordre compatible avec le produit », ce qui ne suffit que si `1 ⊑ f(ε_c)`) et ce dont a besoin la preuve de `thm:loi_distributive_conditions` (voir `PREUVE-05`). Je n'ai pas trouvé d'endroit où ce fait soit énoncé (grep de « absence d'effet »).

## `STRUCT-16` : le mode est attaché à la couche ; `Rel` admissible, jamais instancié

### Ce qui a été appliqué

* Séance 31 (commit `93c5501`), `LeSystemeGradue.lean:148`, dans la preuve de `thm:morphismes_modes` : le mode d'un contexte n'est pas calculé, il est attaché à la couche, donc au délimiteur (`{ }` linéaire, `( )` affine, `[ ]` cartésien, `tab:delimiteurs` au ch. 5) ; la règle d'imbrication à sens unique ne laisse aucune quatrième zone ; `Rel = [1..ω]` est un grade admissible, non générable ; la grammaire des grades laisse `u ∈ ℕ∞` libre, voulu, pour `Lin_k` et `1/N` ; la preuve « se réduit à constater que les trois délimiteurs sont les seuls producteurs de zones ».
* Réponse à la fiche d'origine (G/§10) : établir `Reachable_K7PL ⊆ {Lin, Aff, Unr}` et que les opérations de dérivation ne produisent jamais `Rel`.

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* La table `tab:modalites-intervalles` (quatre intervalles) et `thm:morphismes_modes` sont cohérents entre eux : `Aff` et `Rel` ne sont pas comparables, le treillis est à quatre éléments, la chaîne à trois en est le fragment totalement ordonné (vérifié sur le texte : les deux conditions du morphisme de modes sont bien refusées dans chaque sens).
* Le ch. 5 porte bien la table des délimiteurs avec le contexte du jugement de chacun (`Δ_lin`, `Δ_aff, ℰ`, `Δ_ω`, `SExpressionsUniverselles.lean:30-53`) et la règle d'imbrication à sens unique (`:55`). Le renvoi `tab:delimiteurs` résout.
* Le chapitre 1 dit déjà que la construction engendre quatre modes et que K7PL en instancie trois (`AxiomatiqueGerminale.lean:274-280`) : le paragraphe de `STRUCT-16` est cohérent avec lui.

**Défauts relevés.**

1. **« u ∈ ℕ∞ libre … `1/N` en a besoin » est faux tel qu'écrit** (constat T1) : `1/N` n'est pas dans `ℕ∞`. Soit l'usage est `ℚ≥0 ∪ {ω}` partout (et la grammaire du ch. 3, ligne 45, doit être corrigée), soit les fractions sortent du porteur (et le ch. 2, ch. 1 §1.4 effet iii et `Postulats.lean:106` doivent l'être). L'argument de `STRUCT-16` (« une restriction de la grammaire casserait `Lin_k` et `1/N` ») est juste dans son principe (ne pas restreindre la grammaire) mais sa justification par `1/N` repose sur la forme ambiguë.
2. **Confusion entre mode de zone et modalité de liaison.** Le texte identifie le mode d'un contexte avec les modalités de la table (`Lin = [1..1]`, etc.). Mais une zone `{ }` n'est pas faite de liaisons de grade `1` seulement : le ch. 1 dit que le grade `ω` « se copie librement » dans tous les fragments (`AxiomatiqueGerminale.lean:165-170`) et le ch. 5 que `Δ_ω` est « présent dans les trois jugements » (`SExpressionsUniverselles.lean:64-66`). Le mode d'une zone désigne les règles structurelles qu'elle admet, la modalité d'une liaison l'intervalle d'usage qu'elle permet ; la phrase « le mode d'un contexte est attaché à la couche » les mêle. Ce n'est pas une erreur de fond (les deux coïncident au sens que l'on veut), c'est une précision à donner pour que « aucune règle ne produit `Rel` » ait un sens vérifiable : il faut dire *de quoi* `Rel` est absent (des zones, pas des liaisons).
3. **La preuve (« se réduit à constater que les trois délimiteurs sont les seuls producteurs de zones »)** s'appuie sur la grammaire du ch. 5, dont rien ne dit qu'elle est complète au sens voulu (aucune autre forme n'ouvre une zone). Je n'ai pas vérifié, dans les chapitres 3 et 5, qu'aucune règle (par exemple la règle d'imbrication `ERR-TOP-001`, ou les opérations de lecture partagée) n'ouvre un contexte de mode nouveau ; je n'en ai pas trouvé, mais c'est une absence de résultat de lecture, pas une preuve.
4. Le renvoi du §1.4 « le mode est le paramètre (théorème `thm:morphismes_modes`) » (`AxiomatiqueGerminale.lean:248-249`) attribue au théorème une idée qui est dite en prose en `LeSystemeGradue.lean:161-170` (cadre de Licata et al.), le théorème parlant de la chaîne modale. Retouche de renvoi.

### Alternatives écartées et pourquoi

* **Restreindre la grammaire des grades aux modes déclarables** : écartée, elle casserait `Lin_k` et les grades fractionnaires (texte, instruction).
* **Calculer le mode du contexte** (inférence des modes à la OCaml modal) : écartée au profit de la déclaration par délimiteur (`LeSystemeGradue.lean:181-186`, « choix dont le chapitre 5 dit le prix »).
* **Retirer `Rel` de la table** : écartée au nom de l'honnêteté (le texte préfère le nommer plutôt que laisser croire que trois cas épuisent la construction, `:102-103`).
* **Instancier `Rel`** (pertinence) : hors périmètre ; le texte dit qu'une extension future trouverait la grammaire prête et le système de zones fermé.

### Risque si on ratifie

Faible, à condition de corriger le défaut 1 : sans cela on ratifie une phrase qui se contredit sur `1/N`. Le reste (un paragraphe de justification) n'engage pas d'autre énoncé du manuscrit.

### Risque si on refuse

Moyen : la fiche d'origine (établir que `Rel` n'est pas atteignable) retombe ouverte, et le passage « algèbre développée sur la structure générale, garanties sur le sous-ensemble exposé » redevient un trou. Refuser par préférence pour une extension à la pertinence demanderait de rouvrir `tab:delimiteurs` et la règle d'imbrication.

### Ce que la ratification débloque ou ferme

Ferme `STRUCT-16`. Aucune autre fiche n'en dépend au CSV (colonne `depend` vide). N'intervient dans aucune des portes P1 à P6 autrement que par le lot `STRUCT` (relecture d'ensemble de P5).

### Verdict recommandé

**Ratifier avec correction** (défaut 1, obligatoire ; défauts 2 et 4, retouches).

### Correction minimale proposée (non appliquée)

À `LeSystemeGradue.lean:148`, remplacer « La grammaire des grades laisse en revanche `u ∈ ℕ∞` libre, et c'est voulu : les grades `Lin_k` et `1/N` en ont besoin » par :

> La grammaire des grades laisse en revanche l'usage libre dans le porteur de l'algèbre (`ℚ≥0 ∪ {ω}`, chapitre 2), et c'est voulu : les grades `Lin_k` et les grades fractionnaires en ont besoin, qu'une restriction de la grammaire aux modes déclarables casserait.

**À condition que** la grammaire du ch. 3 (`GrammaireDesTypes.lean:45`) soit alignée (usage `𝕌`) ; c'est le sujet du constat T1 et de la correction de `TRANS-02` ci-dessous. Si l'auteur préfère `ℕ∞` partout, la phrase devient : « … les grades `Lin_k` en ont besoin » et les fractions sortent du texte.

Précision (défaut 2), à ajouter après « le mode d'un contexte n'est pas calculé, il est _attaché à la couche_, donc au délimiteur » :

> (c'est le mode de la _zone_, c'est-à-dire l'ensemble des règles structurelles qu'elle admet, qu'il s'agit de borner ; une zone linéaire ou affine contient aussi des liaisons de grade `ω`, qui s'y copient librement, sans que cela en fasse une zone cartésienne)

Renvoi (défaut 4) : remplacer « (théorème `thm:morphismes_modes`) » par « (§`sec:c3-le-systeme-gradue`, et le théorème `thm:morphismes_modes` pour la chaîne) » à `AxiomatiqueGerminale.lean:248-249`.

## `TRANS-02` : décomposition module × ordre

### Ce qui a été appliqué

* Séance 25 (commit `b39358f`) : `AxiomatiqueGerminale.lean:230-249`. `ℛ = (𝕌 × 𝔅) × (𝕄 × ℒ)`, avec `𝕌 = ℚ≥0 ∪ {ω}`, `𝔅 = ℕ∞` muni d'un résidu `⊖` continu en `ω`, `𝕄` monotonie et `ℒ` niveau « agissant trivialement » ; deux projections ; « sept effets » ; critère machine de la clôture.
* Séance 32 §A.5 : les fragments du ch. 2 et la table de sédimentation lus comme images réciproques (`ComonadeExponentielleEtFragments.lean:411-418`, `AxiomatiqueGerminale.lean:932-939`) ; remontée du facteur temporel (`TRANS-06`).
* Le texte dit encore deux fois que la décomposition est « proposée à la ratification » / « (à ratifier) » (`AxiomatiqueGerminale.lean:230-231`, `ComonadeExponentielleEtFragments.lean:411`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* La décomposition est cohérente avec la table `tab:phi-psi` : `ψ` n'agit que sur le budget (`β ⊖ k`), le niveau étiquette sans itérer, la monotonie n'agit pas. C'est précisément la bipartition « module (usage, budget) » / « ordre pur (monotonie, niveau) » ; `𝔅` reçoit l'action de `𝕌` par `φ`/`ψ`, ce qui est la seule interaction de la table.
* Les sous-algèbres `𝒢_pile = ℕ∞ × {d} × ℒ × {0}` et `𝒢_budget = ℕ∞ × {d,m} × ℒ × ℕ∞` (`AxiomatiqueGerminale.lean:874`) sont bien des images de projections (effet vi).
* L'ancien critère (trois conditions : structure ordonnée, opérations facteur par facteur, strate) est encore là (`:218-228`) et est déclaré insuffisant (`:230`) ; le nouveau critère (module sur `𝕌` ou ordre pur à action triviale) est plus étroit et vérifiable. Le passage lit bien comme un remplacement.

**Défauts relevés.**

1. **« Sept effets suivent » : le texte n'en énumère que six.** `AxiomatiqueGerminale.lean:236-242` : (1) les fragments sont des images réciproques, singletons et intervalles coexistent ; (2) `1/N` dans le noyau formel ; (3) `r·Δ` défini ; (4) le niveau d'un calcul est un indice distinct de `niv(r)` ; (5) `𝒢_pile` et `𝒢_budget` images de projections ; (6) la clôture vérifiable par machine. La fiche d'origine en comptait sept : le septième (« la table 6 dit laquelle des deux lectures elle donne ») a été écrit, mais ailleurs (`:935-939`, paragraphe sous `tab:sedimentation`). Le compte du texte est donc faux de un, ou la liste incomplète.
2. **La table de sédimentation et le chapitre 2 appellent « singletons » des ensembles dont l'un est une paire.** `AxiomatiqueGerminale.lean:935-937` : « ses trois lignes sont les fragments `π⁻¹({ω})`, `π⁻¹({0,1})` et `π⁻¹({1})`, images réciproques de singletons de `𝕌` » ; `ComonadeExponentielleEtFragments.lean:414` : « Les singletons `{1}`, `{0,1}` et `{ω}` ». `{0,1}` n'est pas un singleton. Erreur de mot, sans conséquence logique, mais elle est dans la phrase qui est censée clarifier la coexistence des deux lectures.
3. **`{0,1}` n'est pas `[0..1]`.** Le ch. 3 définit `Aff = [0..1]` (intervalle de `ℛ`), donc, avec `𝕌 ⊇ ℚ≥0`, contenant tous les grades fractionnaires entre 0 et 1. Le ch. 1 et le ch. 2 lisent `Aff` comme `π⁻¹({0,1})`. Le texte dit que les fragments logiques sont « des cas particuliers » des intervalles : c'est exact comme inclusion d'ensembles, mais cela revient à dire que le fragment catégorique affine (usage `0` ou `1` seulement) est strictement plus petit que la modalité de type `Aff` du ch. 3. Le texte n'en tire pas la conséquence (une liaison de grade `1/2` est dans `Aff` du ch. 3, hors de `𝒞_{!_{{0,1}}}`) ; il dit seulement que « la notation par intervalles fait foi pour les types ».
4. **Constat T2 : l'action de `𝕌` sur `𝔅` n'est écrite nulle part.** « `𝔅` module sur `𝕌` » est le cœur du critère de clôture ; l'effet (iii) `1/N` dans le noyau formel et l'effet (iv) `r·Δ` défini en dépendent. Avec `r = 1/N` et un budget `β ∈ ℕ∞`, `r·β` n'est pas défini sans arrondi, et un arrondi (plafond, plancher) ne donne pas un module : la distributivité sur l'addition de `𝕌` échoue (avec le plafond, `(1/2 + 1/2)·1 = 1` alors que `1/2·1 + 1/2·1 = 1 + 1 = 2` ; calcul fait à la main). Deux sorties : prendre `𝔅 = ℚ≥0 ∪ {ω}`-valué (mais `⊖` et les bornes entières de `Vec n T`, `n·Δ` perdent leur lecture), ou restreindre `r·Δ` aux `r` entiers pour la composante budget et dire quelle est l'action des fractions sur le budget (par exemple : triviale, ou non définie, une capacité fractionnaire n'allouant rien).
5. **Constat T1** : la décomposition fixe `𝕌 = ℚ≥0 ∪ {ω}`, la grammaire du ch. 3 écrit `ℕ∞`. Les sous-algèbres `𝒢_pile`, `𝒢_budget` du même paragraphe écrivent `ℕ∞` pour le premier facteur : cohérent avec la grammaire, pas avec `𝕌`.
6. **L'ordre des facteurs diffère** : la décomposition `(𝕌 × 𝔅) × (𝕄 × ℒ)` et les produits `ℕ∞ × {d} × ℒ × {0}` de `𝒢_pile` (usage, monotonie, niveau, budget) ne se lisent comme la même structure qu'à permutation près ; c'est dit nulle part. Cosmétique.
7. **Le contre-exemple de la fiche `STRUCT-01` n'est pas couvert.** L'extension probabiliste (composition multiplicative qui n'est pas celle du semi-anneau des grades) tombait sous le critère reformulé sur la modalité, avec une difficulté propre. Le critère de `TRANS-02` (module sur `𝕌` ou ordre pur à action triviale) ne dit pas dans lequel des deux cas elle tombe. Ce n'est pas un défaut de `TRANS-02` mais une question laissée ouverte par la fiche d'origine, que la ratification ne règle pas.

### Alternatives écartées et pourquoi

* **Garder les trois conditions d'admission** : écartées, insuffisantes (instruction, fiche).
* **Une décomposition à quatre facteurs indépendants** (usage, budget, monotonie, niveau, produits simples) : écartée, parce que le budget interagit avec l'usage par `ψ` et `φ` ; ce n'est pas un produit libre. Le texte le dit par « module ».
* **`𝕌 = ℕ∞`** : écartée par le ch. 2 pour les capacités fractionnaires ; mais voir T1 : le ch. 3 la rétablit.
* **Le critère par adjonction graduée unifiée** : voir `FACT-12`.

### Risque si on ratifie

Moyen. On ratifie une décomposition dont deux pièces sont soit non écrites (l'action `𝕌 → 𝔅`) soit en désaccord entre chapitres (porteur de l'usage). Le risque est de ratifier le principe (module × ordre) et de laisser croire que « module sur `𝕌` » est vérifié. Il est atténué si la ratification est assortie de la correction : le principe est sain, l'énoncé précis doit suivre.

### Risque si on refuse

Moyen à élevé : `TRANS-02` répare « sept critiques dont deux bloquantes » (fiche) ; `BLOQ-03`, `BLOQ-04`, `NOTA-01`, `STRUCT-14` s'y appuient. Revenir aux trois conditions rouvrirait la fermeture du critère d'admission, et les remontées de la séance 32 (`TRANS-06`, six conditions portées aux ch. 1 à 3) perdraient une de leurs pièces.

### Ce que la ratification débloque ou ferme

* Ferme `TRANS-02`, et permet de fermer `FACT-12` et `STRUCT-01` (qui n'attendent que cela : `depend = TRANS-02`).
* Ne ferme aucune porte P1 à P6 seule ; elle libère la relecture d'ensemble du lot `STRUCT` (P5).
* La correction T1/T2 est le préalable de toute mécanisation de `ℛ` (le solveur du ch. 6 raisonne sur `ℛ`).

### Verdict recommandé

**Ratifier avec correction** : le principe de la décomposition est le bon ; corriger le compte (défaut 1) et le mot (défaut 2) et écrire l'action de `𝕌` sur `𝔅` (défaut 4) avant de dire « module ». Les défauts 3, 5, 6 sont des alignements.

### Correction minimale proposée (non appliquée)

(a) `AxiomatiqueGerminale.lean:236`, « Sept effets suivent » devient « Six effets suivent » **ou** ajouter, après « les fractionnaires `1/N` sont dans le noyau formel ; », le membre manquant : « la table de sédimentation dit laquelle des deux lectures elle donne (paragraphe sous la table `tab:sedimentation`) ; ». Je recommande la seconde forme, qui garde le compte de la fiche.

(b) `AxiomatiqueGerminale.lean:935-937` : remplacer « images réciproques de singletons de `𝕌` » par « images réciproques de parties de `𝕌` (un singleton ou une paire) » ; et `ComonadeExponentielleEtFragments.lean:414` : « Les singletons `{1}`, `{0,1}` et `{ω}` » devient « Les parties `{1}`, `{0,1}` et `{ω}` ».

(c) Avant la phrase « Deux projections… » (`:235`), ajouter :

> L'action de `𝕌` sur `𝔅` est la multiplication sur les usages entiers et `ω`, et n'est pas définie sur les usages fractionnaires : une capacité fractionnaire n'alloue rien, donc `r·β` n'est exigé que pour `r ∈ ℕ ∪ {ω}`. [ou : l'action d'un usage fractionnaire sur le budget est triviale.]

(La seconde formulation ne contredit pas `thm:loi_distributive_conditions` ; la première oblige à dire où `r·Δ` n'est pas défini. **C'est un choix de modèle, qui est celui de l'auteur ; je n'ai pas de recommandation de fond.**)

(d) Aligner la grammaire du ch. 3 (`GrammaireDesTypes.lean:45`) sur `𝕌` : `r ::= ⟨u, m, ℓ, β⟩ ∈ ℛ = 𝕌 × {d ⪯ m} × ℒ × ℬ`, ou, si `ℕ∞` est conservé, supprimer les fractions des ch. 1 et 2.

(e) Une fois ratifiée, retirer les mentions « proposée à la ratification » (`AxiomatiqueGerminale.lean:230-231`) et « (à ratifier) » (`ComonadeExponentielleEtFragments.lean:411`).

(f) Dans le ch. 1 (après la définition de la quantale d'effets, vers `:299-304`), poser une fois pour toutes : « l'unité `1` est le plus petit élément de la quantale (l'absence d'effet est la moindre des bornes) », fait que le ch. 4 (`SemantiqueOperationnelle.lean:414`) et `thm:loi_distributive_conditions` emploient sans le dire (constat T3).

## `FACT-12` et `STRUCT-01` : pas d'adjonction graduée unifiée, la décomposition tient lieu de cadre

### Ce qui a été appliqué

* Séance 31 (commit `93c5501`, journal 31 « `FACT-12` / `STRUCT-01` »), `AxiomatiqueGerminale.lean:244-249` : « Cette décomposition tient lieu de cadre unificateur, et ce document n'en promet pas davantage. Une adjonction graduée stricte … serait fausse en l'état : la loi distributive … n'est qu'_affaiblie_ ; … ce que K7PL emprunte à la théorie des modes est son vocabulaire — le mode est le paramètre — et non une réécriture du chapitre autour d'une adjonction unique. »
* `ARB-PR-05` (ratifiée par l'auteur) avait déjà retenu le cadre du manuscrit et écarté `FACT-21`, `FACT-22` (`factorisations-refusees.md`). Les deux fiches se ferment « en renvoyant à `TRANS-02` ratifiée » (instruction).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* L'argument que l'adjonction stricte serait fausse est correct, et il est vérifié par le texte du §3.2 (`thm:loi_distributive_conditions`, quatrième condition) : `(εδ)^n ≠ ε^nδ^n` quand `ε`, `δ` ne commutent pas (calcul refait : dans le monoïde libre sur deux lettres, `(ab)² = abab ≠ aabb`).
* La phrase ne promet rien qu'elle ne tienne : pas de réécriture du ch. 1 ; le vocabulaire des modes est celui du ch. 3 (`LeSystemeGradue.lean:161-170`, 188-189).
* Cohérence avec `TRANS-02` : la décomposition donne bien la « structure que `STRUCT-01` réclame » (un critère de placement sur la modalité, non sur le jugement) pour le critère de clôture.

**Défauts relevés.**

1. **L'« inversion d'antériorité » de `STRUCT-01` n'est pas résorbée, elle est déclarée acceptée.** La fiche d'origine demandait de poser au §1.4, **avant** le jugement, la notion de discipline et de présenter le jugement comme un système à paramètres. Le texte garde l'ordre (jugement d'abord, `AxiomatiqueGerminale.lean:68-104`, puis la décomposition à `:230`) et le §2.4 énonce encore « sous sa forme générale » le procédé que le §1.4 emploie (`AdjonctionsEtEnrichissement.lean:124`). Ce que la ratification ferme n'est donc pas « l'ordre » mais « la promesse d'un cadre unifié » ; la fiche `STRUCT-01` se ferme par une décision de **ne pas** réordonner.
2. **Trois exceptions locales de la fiche (zone d'échange, donnée de mode, modalité `•`).** La zone d'échange et la donnée de mode sont traitées dans le texte comme données de mode (`LeSystemeGradue.lean:206-215, 188-190`), ce qui suit la fiche. La modalité `•` (fiche : « §E.3.1, elle est ajoutée ») : je n'ai pas vérifié dans le Verso l'état de ce point (grep de `•` non fait) ; **non vérifié**.
3. **Renvoi** : « (théorème `thm:morphismes_modes`) » pour « le mode est le paramètre » : voir `STRUCT-16` défaut 4.
4. `FACT-12` dit « adjonction graduée unifiant coeffets et effets » ; le texte appliqué dit qu'elle est fausse « en l'état ». C'est plus fort qu'un « non promis » : le texte affirme une fausseté pour la version stricte, et la preuve de cette fausseté est le défaut de morphisme de `φ_n`. La phrase est juste ; elle ne dit pas qu'une version **faible** (laxe) de l'adjonction pourrait être vraie. Ne pas fermer cette porte est un choix de rédaction : elle n'est ni promise ni exclue.

### Alternatives écartées et pourquoi

* **Réécrire le ch. 1 autour d'une adjonction graduée unique** (`FACT-12`, `FACT-21`, `FACT-22`) : écartée, fausse en l'état (affaiblissement de la loi distributive) et écartée par `ARB-PR-05`.
* **Poser le système de modes avant le jugement** (action de `STRUCT-01`) : écartée par l'instruction (« ne pas réécrire le chapitre 1 ») ; coût ≈ trois paragraphes réordonnés (fiche), refusé pour ne pas déstabiliser le chapitre.
* **Ne rien dire** : écartée, la fiche constate un défaut de niveau dans l'énoncé de la clôture, corrigé par `TRANS-02`.

### Risque si on ratifie

Faible. On ratifie une non-promesse ; le risque est de laisser une inversion d'ordre de lecture que la fiche d'origine jugeait « la plus rentable après `BLOQ-07` ». Le coût réel de ne pas réordonner est de pédagogie, pas de preuve.

### Risque si on refuse

Moyen : refuser reviendrait à demander soit la réécriture du chapitre (qui a un coût élevé, et que `ARB-PR-05` a déjà refusée), soit une promesse d'adjonction que le texte sait fausse. Aucun de ces deux ne se défend.

### Ce que la ratification débloque ou ferme

Ferme `FACT-12` et `STRUCT-01` ; conditionnée à `TRANS-02`. N'intervient dans aucune porte seule ; contribue à P5 (relecture d'ensemble).

### Verdict recommandé

**Ratifier avec `TRANS-02`** (et ses corrections). Pas de correction propre à ces deux fiches, hors le renvoi du défaut 3.

### Correction minimale proposée (non appliquée)

Un renvoi : `AxiomatiqueGerminale.lean:248-249`, remplacer « le mode est le paramètre (théorème `thm:morphismes_modes`) » par « le mode est le paramètre (§`sec:c3-le-systeme-gradue`) ». Et, pour rendre honnête la fermeture de `STRUCT-01`, ajouter à la fin du paragraphe `:244-249` :

> L'ordre d'exposition (le jugement avant la notion générale de modalité graduée que le chapitre 2 énonce) est conservé : il est celui de la lecture, non celui de la dépendance.

## `FACT-14` : pas de cadre unique des structures monotones

### Ce qui a été appliqué

* Séance 31, `AdjonctionsEtEnrichissement.lean:372` : « Le mot "monotone" recouvre dans ce document trois notions qu'il faut tenir distinctes, une quatrième, la marque de monotonie du grade, étant une composante et non une propriété. […] Aucun cadre unique ne les réunit, et ce n'est pas un manque : elles ne partagent aucun mécanisme, seulement un mot. »
* Fiche fermée comme « satisfaite par `STRUCT-17` » (CSV : `STRUCT-17` fermée).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* Les trois notions sont définies dans la même phrase (fonction monotone `f : S →_mon S` ; domaine ordonné `S ∈ Trellis_fin` ; ensemble de règles monotone) et la quatrième est écartée comme composante.
* Leur interaction est dite : les règles d'un programme monotone « se compilent en fonctions monotones sur un domaine ordonné, dont le point fixe est défini ». La preuve de `thm:terminaison_lfp` emploie la marque du grade (« c'est ici, et seulement ici, que la marque du grade sert », `:393`) : cohérent avec « composante, non propriété ».
* La règle `Fix` (`eq:regle-fix`) est bien celle qui articule ces notions : la flèche porte la marque (4), l'ensemble est un `Trellis_fin` (2), la fonction préserve l'ordre (1).

**Défauts relevés.**

1. **« Trois notions, une quatrième » : le compte est ambigu.** Une lecture rapide compte quatre notions ; le texte en compte trois (propriétés) plus une composante. Aucun défaut de fond.
2. **`Trellis_fin` pour les sommes** : la clause « une somme finie — l'élément neutre étant l'ensemble vide, le joint l'union » (`:366-368`) est à peine cohérente (l'élément neutre d'une somme de types n'est pas l'ensemble vide). La séance 32 l'a signalé comme non écrit (`⊥_S` n'a pas de terme dans la grammaire des valeurs). Sans rapport avec la ratification de `FACT-14`, mais sur le même passage ; **à ne pas laisser croire résolu**.
3. **L'énoncé de `thm:terminaison_lfp`** dit que le grade d'effet de `fix f` est « une fonction de l'indice que porte `S` », la règle écrit `ℰ = ∅` (constat déjà fait en séance 32). Même remarque : voisin, non lié.
4. Rien dans le texte ne dit qu'un *cadre unique* serait faux ; il dit seulement qu'il n'est pas nécessaire (« ce n'est pas un manque »). C'est suffisant pour fermer la fiche telle qu'elle était posée.

### Alternatives écartées et pourquoi

* **Cadre unique de la monotonie** (fiche d'origine, D/6.4) : écarté parce que les trois notions « ne partagent aucun mécanisme » (texte) ; l'unifier ajouterait une abstraction sans rien démontrer de plus.
* **Renommer les notions** : non retenu ici ; relève de `T-68` (vocabulaire).

### Risque si on ratifie

Très faible : on ratifie une distinction de vocabulaire déjà écrite.

### Risque si on refuse

Faible mais non nul : la fiche resterait ouverte pour un cadre que ni le texte ni l'instruction ne justifient.

### Ce que la ratification débloque ou ferme

Ferme `FACT-14`. Aucune dépendance au CSV, aucune porte.

### Verdict recommandé

**Ratifier.** Les défauts 2 et 3 sont voisins : à traiter comme anomalies distinctes (le `⊥_S` des sommes, la phrase de `thm:terminaison_lfp`), non comme conditions de la ratification.

### Correction minimale proposée (non appliquée)

Aucune pour `FACT-14`. Pour le défaut 2, si l'auteur le souhaite : remplacer « ou une somme finie » par « ou une somme finie de types de `Trellis_fin` munis d'un plus petit élément commun, par exemple un produit fini » **(texte conjectural : le choix du modèle de la somme est celui de l'auteur, la séance 32 l'a laissé ouvert)**.

## `PREUVE-05` : la loi distributive affaiblie, `λ` écrite

### Ce qui a été appliqué

* Séance 24 (commit `eb0ba92`), `ReglesDeTypage.lean:1021-1069` : `λ_{r,ε} : !_r T_ε ⇒ T_{φ_n(ε)} !_{ψ(r,ε)}`, `φ_n(ε) = ε^n`, `thm:loi_distributive_conditions` (sceau « théorème »), trois conditions (U) unité, (C) composition, (N) naturalité, vérifiées ; quatrième condition (morphisme de monoïde) fausse, d'où la loi **affaiblie** ; séance 31 : retenue (la loi stricte demanderait de restreindre `ℰ₀` à une partie commutative).
* `AxiomatiqueGerminale.lean:246-249` y renvoie.

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* La quatrième condition est bien fausse hors partie commutative (contre-exemple refait ci-dessus) et vraie sur le facteur temporel (`k ↦ nk` additif), comme le dit le texte.
* La phrase « les règles du jeu n'emploient jamais cette condition : elles mettent à l'échelle un corps entier, jamais la moitié d'une séquence » est vérifiable sur les règles : `Let` n'a pas de mise à l'échelle (`ReglesDeTypage.lean:151`), `App` met à l'échelle le contexte de l'argument `r·Δ₂` (`:169`), et `Sc` met à l'échelle un corps entier (`:562`). Aucune règle ne distribue une mise à l'échelle sur un produit d'effets (lu sur les règles citées ; je n'ai pas relu les cinquante-trois).
* La conclusion pratique (« déplacer un bloc mis à l'échelle de part et d'autre d'une frontière de séquence change l'annotation d'effet, et aucune règle ne le fait ») est correcte.

**Défauts relevés (le premier est une erreur dans la preuve d'un énoncé scellé « théorème »).**

1. **La preuve de (C) pour `ω` est incomplète et sa formule intermédiaire est fausse** (vérification faite à la main).
   * L'esquisse dit : « `(ε^ω)^m = ⋁_k ε^{km}`, égal à `ε^ω` pour `m ≥ 1` ». La formule `⋁_k ε^{km}` est celle de `(ε^m)^ω`, non de `(ε^ω)^m`. Le bon développement (distributivité du produit sur les bornes supérieures) donne `(ε^ω)^m = ⋁_{k₁,…,k_m} ε^{k₁+…+k_m} = ⋁_j ε^j = ε^ω` pour `m ≥ 1` (toute puissance `j` s'obtient avec `k₁ = j` et les autres nuls). Le résultat est donc vrai, la justification donnée est fausse.
   * Le cas **`n = ω`, `m` fini ≥ 2** n'est pas traité : il demande `φ_ω(φ_m(ε)) = (ε^m)^ω = ⋁_k ε^{mk}` égal à `φ_{ωm}(ε) = ε^ω = ⋁_j ε^j`. Dans une quantale quelconque c'est faux : dans les ensembles de mots avec `ε = {a}`, `⋁_k ε^{2k} = {a^{2k}}` ne contient pas `a`. Il devient vrai si `1 ⊑ ε` pour tout `ε` (alors `ε^j ⊑ ε^{j+1}` et la suite est cofinale). C'est le constat T3 : l'hypothèse n'est pas posée.
   * Conclusion : (C) tient **sous l'hypothèse `1 ⊑ ε`** (que le reste du manuscrit emploie), pas sur les seules propriétés de quantale que la preuve invoque. Le sceau « théorème » demande que l'hypothèse soit écrite.
2. **« de sorte que `λ` est compatible avec la comultiplication `δ_{r,s}` » n'est pas dérivé.** (C) est une loi sur la famille `φ_n` (indexée par la multiplicité d'exécution `n`) ; `δ_{r,s}` est la comultiplication de la comonade graduée en `r`. Le texte dit lui-même, au ch. 1, que « le grade `r` ne détermine pas la multiplicité d'exécution » (`AxiomatiqueGerminale.lean:363`) : la passerelle entre `n` et `r` qui rendrait (C) équivalente à la compatibilité avec `δ` n'est pas écrite. Je n'ai pas trouvé de preuve de cette compatibilité dans `spec/Spec` ; **elle peut exister ailleurs et m'avoir échappé**, mais ce n'est pas dans les trois lignes de l'esquisse.
3. **Statut de `(N)`** : la preuve (« les deux membres ne diffèrent que par l'annotation ») est une phrase ; `λ` « naturelle en le type » dit que `λ` ne regarde pas le type, ce qui est un fait de définition. Acceptable pour une proposition ; léger pour un théorème.
4. **`LET` et `APP`** (fiche : « vérifier que `LET` et `APP` les emploient correctement ») : `Let` utilise `ψ` (transport du budget par `ε₁`) mais **ni** `φ_n` ni la loi complète ; `App` met à l'échelle par `r` puis transporte par `ε₀`, et son effet `ε₀·ε` n'emploie pas `φ_n` non plus. La loi `λ` complète n'est donc invoquée par aucune des deux ; ce qu'elles emploient est `ψ` et la propriété de cohérence du théorème `thm:coherence_axiome` (texte, `:1064-1065`). La phrase de la fiche (« `Let` et `App` la supposaient ») est vraie au sens où elles supposent `ψ` bien défini ; le texte le dit (« la seule propriété qu'elles invoquent est la loi de cohérence du théorème `thm:coherence_axiome` »). **Je n'ai pas relu `thm:coherence_axiome`** : à vérifier avant de ratifier « relire LET/APP ».

### Alternatives écartées et pourquoi

* **Loi stricte** (morphisme de monoïde) : écartée, demande `ℰ₀` commutatif, or le séquencement est non commutatif par construction (la quantale d'effets, §1.4).
* **Loi stricte sur une partie commutative** (facteur temporel) : retenue comme extension possible, nommée dans le texte.
* **Retirer la loi distributive du jeu** : écartée, `Let`/`App` ont besoin du transport `ψ`.

### Risque si on ratifie

Moyen. On ratifie un énoncé scellé « théorème » dont l'esquisse a une erreur à l'étape `ω` et une hypothèse non posée. Le risque est de figer ce sceau avant de corriger. La ratification de l'**orientation** (loi affaiblie, pas stricte) n'est pas en cause ; c'est celle de la **preuve** qui l'est.

### Risque si on refuse

Moyen : refuser la loi affaiblie reviendrait à exiger la loi stricte, donc à restreindre `ℰ₀` à une partie commutative, ce que le séquencement refuse (fiche, instruction) ; ou à retirer l'énoncé, ce qui rouvre le trou que `PREUVE-05` comblait (une loi « nommée et employée sans que ses conditions soient écrites »).

### Ce que la ratification débloque ou ferme

Ferme `PREUVE-05`, et débloque `PREUVE-04` (`depend = PREUVE-05` au CSV : le lemme fondamental de la divulgation délimitée). Soutient `FACT-12`/`STRUCT-01` (argument de l'adjonction stricte fausse). N'est pas une porte en soi ; `PREUVE-04` conditionne P2 (route nommée).

### Verdict recommandé

**Ratifier la loi affaiblie ; corriger l'esquisse de (C) (défaut 1) et retirer ou démontrer la compatibilité avec `δ` (défaut 2) avant de laisser le sceau « théorème ».** Le sceau est conservé si (C) est corrigée avec l'hypothèse `1 ⊑ ε` ; sinon le passer à « proposition » (ce que le suivi propose déjà pour deux autres énoncés).

### Correction minimale proposée (non appliquée)

Remplacer l'esquisse de (C) à `ReglesDeTypage.lean:1049-1053` par :

> (C) : dans un monoïde, `ε^{nm} = (ε^m)^n` par récurrence sur `n`. Pour `ω`, on emploie que l'unité `1` est le plus petit élément de la quantale (chapitre 1) : alors `ε^k ⊑ ε^{k+1}` pour tout `k`, donc `ε^ω = ⋁_k ε^k` est aussi la borne supérieure de toute sous-suite cofinale de puissances, en particulier de `(ε^{m})^k = ε^{mk}` pour `m ≥ 1`, ce qui donne `φ_ω ∘ φ_m = φ_ω`. Pour `φ_m ∘ φ_ω`, la distributivité du produit sur les bornes supérieures donne `(ε^ω)^m = ⋁_{k₁,…,k_m} ε^{k₁+…+k_m} = ε^ω` pour `m ≥ 1`, et `(ε^ω)^0 = 1 = φ_0 ∘ φ_ω`.

Remplacer la phrase « de sorte que `λ` est compatible avec la comultiplication `δ_{r,s}` » (`:1042-1043`) par : « ce qui est la composition des multiplicités d'exécution ; la compatibilité avec la comultiplication de la comonade graduée demande en outre de relier `n` au grade `r`, ce que les règles font cas par cas ».

Ajouter au ch. 1 (voir `TRANS-02`, correction (f)) l'énoncé de `1 ⊑ ε`.

(Ces textes sont conjecturaux : j'ai refait la vérification à la main, mais la forme exacte est à confirmer par l'auteur ; la seconde phrase décrit ce que je lis dans les règles, non une preuve.)
