# K7PL — Les trois contributions propres, et l'analyse de la règle GUARD

**Objet.** Développement formel des trois pièces que le programme de concurrence identifie comme non publiées, et analyse du point de risque principal — l'opération de contexte que la règle `GUARD` requiert.

**Statut.** Matériau de travail destiné à l'intégration au manuscrit. Ce document ne remplace pas l'annexe E : il fournit les définitions, les règles et les lemmes au niveau de précision où ils doivent y figurer, avec les points de décision restés ouverts signalés comme tels.

**Établi le :** 2026-09-15.

**Conventions.** `𝕌 = ℚ≥0 ∪ {ω}` semi-anneau d'usage · `𝕄 = {d ⪯ m}` marques de monotonie · `ℒ` treillis des niveaux · `𝔅 = ℕ∞` budgets · `ℛ = 𝕌 × 𝕄 × ℒ × 𝔅` (nommage de `TRANS-02`). Les quatre projections sont `π_𝕌`, `π_𝕄`, `π_ℒ`, `π_𝔅`.

---

# Contribution A — Boîtes aux lettres × contexte gradué

## A.1 Ce qui est nouveau

Les systèmes de types à boîtes aux lettres imposent la discipline « plusieurs émetteurs, un receveur » par un appareil **externe** au typage des valeurs : une linéarité séparée pour la capacité de réception, complétée par un typage *quasi linéaire* pour maîtriser l'aliasing. K7PL possède déjà l'appareil qui rend cet ajout inutile : **la graduation**.

La contribution tient en une phrase : *dans un contexte gradué, la discipline « plusieurs émetteurs, un receveur » est l'affectation de deux grades à deux capacités, et non une discipline structurelle supplémentaire.*

| Capacité | Grade | Lecture |
|---|---|---|
| émettre vers une boîte | `u = ω` | librement duplicable, ce qui *est* « plusieurs émetteurs » |
| recevoir d'une boîte | `u = 1` | linéaire, ce qui *est* « un receveur » |
| recevoir de façon annulable | `u ∈ [0..1]` | affine — le fragment de la couche 2 |

**Conséquence immédiate.** Le typage quasi linéaire, introduit *ad hoc* dans la littérature pour gérer l'aliasing des références de boîtes, devient dans K7PL un **sous-ensemble du treillis des grades** : `{1} ∪ [0..1] ∪ {ω}`, c'est-à-dire l'union des trois fragments déjà définis par la table 6. Rien n'est ajouté ; une notion externe est absorbée.

**Symétrie à relever dans le texte.** La boîte aux lettres est le dual de l'arène :

| | plusieurs | un |
|---|---|---|
| **Arène** (`§4.3`) | lecteurs, `u = 1/N` | écrivain, `u = 1` |
| **Boîte** (`§4.5`) | émetteurs, `u = ω` | receveur, `u = 1` |

Les deux disciplines sont la même loi lue sur deux objets, ce qui prolonge `FACT-08` (`ReadCap ≃ SharedChan`) par son dual et complète `FACT-17` (loi unique d'introduction des ressources d'écriture).

## A.2 Types de boîtes et algèbre des motifs

**Motifs.** Un motif décrit la configuration de messages qu'une boîte peut contenir.

```
E ::= 0  ∣  1  ∣  m[V̄]  ∣  E · E  ∣  E + E  ∣  E*
```

`(E, ·, 1)` est un monoïde **commutatif** — une boîte est un multi-ensemble, non une file — ; `+` est le choix ; `*` la répétition. `(E, ·, +, 0, 1, *)` est une algèbre de Kleene commutative.

**Résiduel.** `E / m[V̄]` est le motif restant après retrait d'un message d'étiquette `m`. Il est **partiel** : défini seulement si `E` admet une configuration contenant `m`. C'est l'analogue commutatif de la dérivée de Brzozowski.

**Types.** Deux formateurs, l'un pour chaque capacité :

```
V ::= … ∣ Mb!E ∣ Mb?E
```

**Sous-typage.** `Mb!` est **contravariant** en `E` (qui peut émettre vers une boîte acceptant plus, peut émettre vers une boîte acceptant moins — non : l'inverse), `Mb?` est **covariant**. Précisément :

```
E ⊑ E'  ⟹  Mb!E' <: Mb!E        (moins on promet d'accepter, plus l'émetteur est contraint)
E ⊑ E'  ⟹  Mb?E  <: Mb?E'       (plus la boîte contient, plus le receveur doit traiter)
```

**Point de vigilance.** Ces deux variances s'ajoutent aux quatre directions de la table 20. Elles portent sur le *type* et non sur le grade, donc elles ne modifient pas le produit mixte — mais **elles doivent figurer dans la table 20 sous peine de reproduire exactement le défaut `BLOQ-14`** : une direction établie à l'annexe et absente du corps.

## A.3 Règles

Les grades non écrits sont neutres. `+` est l'addition ponctuelle de contextes, `⊠_ε` la composition sous effet.

```
                                                          ── NEW
              0 ⊢ new_E : F (Mb!E ⊗ Mb?E) ∣ ⟨alloc, ⟨1,1⟩⟩


        Δ₁ ⊢ v :_{⟨ω,·,ℓ,·⟩} Mb!E        Δ₂ ⊢ v̄ : V̄        m[V̄] ⊑ E        ℓ ⊒ niv(V̄)
  ──────────────────────────────────────────────────────────────────────────────────── SEND
        Δ₁ + Δ₂ ⊢ send m(v̄) to v : F 1 ∣ ⟨send_m, ⟨1,1⟩⟩


        Δ₀ ⊢ v :_{⟨1,·,ℓ,·⟩} Mb?E        E = Σ_{i∈I} mᵢ[V̄ᵢ] · Eᵢ
        Δᵢ , x̄ᵢ :₁ V̄ᵢ , y :₁ Mb?Eᵢ ⊢ cᵢ : C ∣ εᵢ        (∀ i ∈ I)
        ⨆_{i∈I} niv(mᵢ) ⊑ niv(C)                                    (†)
  ──────────────────────────────────────────────────────────────────────────────────── GUARD
        Δ₀ + (⋎_{i∈I} Δᵢ) ⊢ guard v {mᵢ(x̄ᵢ) ↦ cᵢ}_{i∈I} : C ∣ ⟨wait, ⟨0, δ⟩⟩ · (⨆_i εᵢ)


        Δ ⊢ v :₁ Mb?1
  ────────────────────────────────── FREE
        Δ ⊢ free v : F 1 ∣ ⟨dealloc, ⟨1,1⟩⟩


        Δ ⊢ c : F 1 ∣ ε
  ──────────────────────────────────────────── SPAWN
        Δ ⊢ spawn c : F 1 ∣ ⟨spawn, ⟨w(ε), 0⟩⟩
```

Trois symboles demandent leur définition : l'opérateur `⋎` de combinaison des contextes de branches (**contribution D**, §D), la clause de niveau `(†)` (§D.5), et le facteur `δ` de la latence d'attente (**contribution B**, §B.6).

## A.4 Lemmes

**Lemme A.1 (unicité du receveur).** *Dans une dérivation close, toute boîte créée par `NEW` a au plus une occurrence de `GUARD` en cours d'exécution.*
**Preuve.** `NEW` produit `Mb?E` en position linéaire du tenseur ; `SPLIT` la lie à grade 1 ; `GUARD` la consomme et rend `Mb?Eᵢ` à grade 1. La duplication exigerait une contraction, que le fragment n'admet pas au grade 1 (Th. 15). ∎
**Portée :** c'est le lemme que les systèmes à boîtes aux lettres obtiennent par une discipline séparée. Ici il est un corollaire de la table 6.

**Lemme A.2 (liberté d'émission).** *Le nombre d'occurrences de `Mb!E` n'est pas borné.*
**Preuve.** `ω + ω = ω` dans 𝕌. ∎

**Lemme A.3 (conservation des motifs).** *Si `Δ ⊢ guard v {…} : C ∣ ε` et la boîte de `v` contient une configuration décrite par `E`, alors après consommation de `mᵢ` elle est décrite par `Eᵢ`, et `Eᵢ = E / mᵢ[V̄ᵢ]`.*
**Preuve.** Par définition du résiduel et de la forme normale `Σᵢ mᵢ[V̄ᵢ]·Eᵢ`. ∎

**Lemme A.4 (absence de déchets typée).** *Une boîte n'est libérable qu'au motif `1`. Si toute dérivation close termine par `free`, aucun message n'est abandonné.*
**Portée :** énoncé absent du manuscrit, et qui règle une question que le §4.5 laisse ouverte.

**Théorème A.5 (plongement des sessions binaires).** *Il existe une traduction `⟦·⟧` des types de session `S` vers les types de boîtes telle que `Δ ⊢ c : C` dans le fragment sessions si et seulement si `⟦Δ⟧ ⊢ ⟦c⟧ : ⟦C⟧`, et `⟦·⟧` préserve les grades.*
**Statut : à démontrer.** Le résultat non gradué est établi dans la littérature — le calcul à boîtes aux lettres encode les sessions binaires étendues par jonctions et forks. **Ce qui est nouveau et à prouver, c'est la préservation des grades**, c'est-à-dire que `⟦·⟧` est un morphisme pour l'action de 𝕌. C'est une instance du schéma `FACT-01` (commutation graduée), donc le schéma en donne la forme.

## A.5 Ce que la contribution règle dans le plan PR-02

`STRUCT-04` (SPSC contre MPSC) devient sans objet : le motif est non ordonné par construction, et la question « un anneau ou plusieurs » est une question d'abaissement, non de typage. `FACT-11` (`Mailbox` comme objet unique) est réalisé. `BLOQ-13` reçoit son graphe. `IMPL-04` devient l'exigence de réaliser `GUARD` atomiquement.

---

# Contribution B — Coeffets gradués × coût travail/profondeur

## B.1 Ce qui est nouveau

Les cadres qui mesurent le coût travail/profondeur sont **non gradués** : ils n'ont pas de coeffets, donc pas d'action du grade sur le coût. Les cadres gradués ont une action du grade sur l'effet — la loi distributive `φ, ψ` du chapitre 1 — mais un coût **scalaire et séquentiel**.

La contribution : *faire agir le grade sur un coût à deux composantes, et montrer que l'action se distribue sur les deux compositions.*

## B.2 L'algèbre

Le facteur temporel devient une paire par niveau :

```
κ ∈ (ℕ∞ × ℕ∞)^ℒ ,    κ(ℓ) = ⟨w, s⟩       travail, profondeur
```

Deux compositions :

```
séquentiel   ⟨w₁,s₁⟩ · ⟨w₂,s₂⟩ = ⟨w₁ + w₂ , s₁ + s₂⟩
parallèle    ⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁ + w₂ , max(s₁,s₂)⟩
branchement  ⟨w₁,s₁⟩ ⊔ ⟨w₂,s₂⟩ = ⟨max(w₁,w₂) , max(s₁,s₂)⟩
```

**Observation B.1 — deux opérations, cinq usages.** Le coût n'a besoin que de `+` et de `max`, distribuées ainsi :

| construction | travail | profondeur |
|---|---|---|
| séquence (`LET`, `APP`) | `+` | `+` |
| branchement (`CASE`, `WITH`, `GUARD`) | `max` | `max` |
| parallèle (`PAR`) | `+` | `max` |
| itération bornée `n` (`VECE`, `SC`) | `n·` | `n·` |
| itération parallèle (`VMAP`) | `n·` | identité |

**C'est la sémantique de coût complète.** Cinq lignes, deux opérations. À inscrire au chapitre 1 comme table, à côté de la table 2 : c'est le genre d'objet que `TRANS-04` réclame et que le manuscrit n'a pas.

**Observation B.2.** Le branchement et le parallélisme partagent `max` sur la profondeur, la séquence et le parallélisme partagent `+` sur le travail. Le parallélisme n'est donc **pas** une construction nouvelle dans l'algèbre : c'est le croisement des deux qui existaient. C'est l'argument qui justifie de ne pas ajouter de composante.

## B.3 Structure : la quantale devient concurrente

`(ℰ₀, ·, 1)` monoïde non commutatif — le séquencement ordonne. `(ℰ₀, ∥, 1)` monoïde **commutatif** — le parallélisme n'ordonne pas. Les deux sont liés par la **loi d'échange** :

```
(a · b) ∥ (c · d)  ⊑  (a ∥ c) · (b ∥ d)
```

Lecture : exécuter en parallèle deux séquences coûte au plus ce que coûte la séquence des deux parallèles. L'inclusion est stricte — c'est ce qui distingue le parallélisme vrai du parallélisme synchronisé par étapes.

**`BIB-25` à instruire** : vérifier la forme exacte de la loi d'échange en algèbre de Kleene concurrente, et surtout sa compatibilité avec la **résiduation** du budget, qui n'est pas une hypothèse standard de ce cadre.

## B.4 L'action du grade — le résultat principal

**Théorème B.3 (distributivité du grade sur le parallélisme).**
*Pour tout `r ∈ ℛ` et tous effets `ε₁, ε₂` :*

```
φ_r(ε₁ ∥ ε₂)  =  φ_r(ε₁) ∥ φ_r(ε₂)
```

**Preuve.** Sur le travail, `π_𝕌(r) · (w₁ + w₂) = π_𝕌(r)·w₁ + π_𝕌(r)·w₂` par distributivité du semi-anneau. Sur la profondeur, `u · max(s₁,s₂) = max(u·s₁, u·s₂)` : `𝕌` est totalement ordonné et la multiplication par un scalaire positif y est monotone, donc elle préserve les bornes supérieures binaires. Cas `u = 0` : les deux membres valent 0. Cas `u = ω` : les deux valent `ω` dès que `max(s₁,s₂) > 0`, et 0 sinon. ∎

**Portée.** C'est l'analogue parallèle du théorème 1, et il est **plus simple** que lui : il ne fait pas intervenir `⊖`, donc il échappe au défaut `BLOQ-03`. Il est donc démontrable avant que `BLOQ-03` soit corrigé, ce qui en fait le premier résultat livrable du programme.

**Théorème B.4 (résiduation asymétrique du budget).**
*Soit `β = ⟨β_w, β_s⟩`. Alors :*

```
β ⊖ (ε₁ · ε₂)  =  (β_w ⊖ w₁ ⊖ w₂ ,  β_s ⊖ s₁ ⊖ s₂)
β ⊖ (ε₁ ∥ ε₂)  =  (β_w ⊖ w₁ ⊖ w₂ ,  min(β_s ⊖ s₁ , β_s ⊖ s₂))
```

*Autrement dit : deux branches parallèles **consomment le travail additivement et se partagent la même échéance**.*

**Preuve.** Sur le travail, `⊖` est la soustraction tronquée et `+` son inverse à droite ; l'associativité donne la forme itérée. Sur la profondeur, `β_s ⊖ max(s₁,s₂) = min(β_s ⊖ s₁, β_s ⊖ s₂)` par antitonie de `⊖` en son second argument. ∎

**Portée — c'est le contenu formel de « paralléliser ne fait pas gagner de budget ».** Le travail total est inchangé ; seule l'échéance est partagée. Un lecteur pressé conclurait l'inverse, et le §1.3 doit le dire.

## B.5 Interaction avec la composante de niveau

`κ` est indexé par `ℒ`. La composition parallèle agit **niveau par niveau** : `(κ₁ ∥ κ₂)(ℓ) = κ₁(ℓ) ∥ κ₂(ℓ)`. Deux calculs parallèles de niveaux différents n'interagissent donc pas dans le coût observable à un niveau donné.

**Corollaire B.5.** *La projection `π_ℓ` commute avec `∥`.*
**Portée :** c'est l'ingrédient qui rend `N-11` (déterminisme observationnel) énonçable — sans lui, la projection d'un coût parallèle ne serait pas définie.

## B.6 La limite, énoncée sans détour

**Le modèle travail/profondeur est compositionnel pour le parallélisme structuré, et ne l'est pas pour le passage de messages.**

La profondeur d'un `PAR` est locale : `max` des deux branches. La profondeur d'un `GUARD` ne l'est pas : elle dépend de la date à laquelle un *autre* processus émet. C'est le facteur `δ` de la règle `GUARD`, et il n'est pas déterminé par la dérivation du receveur.

**Trois traitements possibles, par ordre de préférence :**

1. **Déclarer la profondeur seulement sur le fragment structuré.** `w` est défini partout, `s` seulement en l'absence de `GUARD`. Honnête, immédiat, et suffisant pour la couche 3 et pour le travail de la couche 2.
2. **Paramétrer par une borne de livraison.** Poser `δ ⊑ δ_max` comme exigence d'environnement, versée au profil `Π` de `IMPL-06`. La profondeur redevient compositionnelle, sous une hypothèse nommée.
3. **Faire de la profondeur une propriété du graphe de dépendance** plutôt que de la dérivation. Correct, et beaucoup plus coûteux : la profondeur cesse d'être une annotation de type.

**Recommandation : (1) à l'étape 1, (2) à l'étape 4.** Ne pas promettre (3).

## B.7 Ce que la contribution règle dans le plan PR-02

`PORT-09` (amorti contre pire cas) : `β_w` et `β_s` répondent séparément, et P3 borne les deux. `NOTA-05` (`∏ᵢ` non commutatif sur un ensemble non ordonné) : `∥ᵢ` est commutatif, donc le défaut disparaît dans le cas parallèle et subsiste, correctement, dans le cas séquentiel. `STRUCT-05` (trace contre optimisation) : `P-trace(ℓ)` porte désormais sur une paire, et la fusion de boucles préserve `w` sans préserver `s` — ce qui rend la règle d'interaction énonçable.

---

# Contribution C — La localité comme modalité graduée

## C.1 Ce qui est nouveau

Les langages distribués typés traitent la localisation comme une **annotation de type** munie de règles propres. K7PL peut la traiter comme la **neuvième instance** de la construction du §2.4, ce qui la fait tomber sous la condition de clôture au lieu de la contourner.

## C.2 La structure de graduation

Soit `𝒩` l'ensemble des localisations. Les grades de localité sont des **ensembles** de localisations, pour admettre les valeurs multiplement localisées :

```
𝕃 = (𝒫(𝒩), ∩, 𝒩, ⊇)
```

- `∩` est associative, commutative, **idempotente** ;
- `𝒩` est l'unité ;
- l'ordre est `⊇` : plus de localisations = plus disponible = plus fort.

**Vérification des trois conditions d'admission du §1.4 :**

| condition | vérification |
|---|---|
| structure ordonnée | `(𝒫(𝒩), ⊇)` est un treillis complet ✓ |
| monoïde pour la composition | `(∩, 𝒩)` commutatif idempotent ✓ |
| action du semi-anneau `𝕌` | **triviale** : `r · L = L` ✓ |

**Théorème C.1 (clôture).** *La localité satisfait la condition de clôture au sens raffiné de `TRANS-02` : elle appartient au facteur « ordre pur à action triviale » du produit `(𝕌 × 𝔅) × (𝕄 × ℒ)`, et s'y adjoint sans modifier l'action scalaire.*

**Portée.** C'est `N-13`. Sa valeur dépasse K7PL : il montre que le critère d'admission du chapitre 1, une fois reformulé par `TRANS-02`, est **discriminant et vérifiable** — il accepte la localité pour une raison précise, et rejetterait une composante sans action définie.

## C.3 Le formateur et ses lois

```
V ::= … ∣ @_L V           L ∈ 𝕃
```

**Lois de comonade graduée** — à vérifier, et elles tiennent :

```
@_𝒩 V ≅ V                                (counité au grade neutre)
@_L @_{L'} V ≅ @_{L ∩ L'} V              (comultiplication)
@_L (V ⊗ W) ≅ @_L V ⊗ @_L W              (monoïdalité)
L ⊇ L'  ⟹  @_L V <: @_{L'} V             (subsomption : oublier des localisations)
```

**La quatrième ligne est le contenu formel de la panne franche.** Perdre une localisation `n ∈ L`, c'est passer de `@_L V` à `@_{L∖{n}} V`, ce qui est une coercion admissible. **La panne franche est donc une subsomption**, pas une exception — et c'est la moitié facile de `N-14`.

## C.4 Règles

```
        Δ ⊢ v : V        loc(Δ) ⊇ L
  ────────────────────────────────────── AT
        Δ ⊢ at_L v : @_L V


        Δ₁ ⊢ v : @_L V       Δ₂ , x :_r V ⊢ c : C ∣ ε       loc(c) ∈ L
  ─────────────────────────────────────────────────────────────────────── UNAT
        Δ₁ ⊠₁ Δ₂ ⊢ unat v as x in c : C ∣ ε


        Δ ⊢ v : @_L V        Ser(V)        niv(V) ⊑ ℓ_net
  ─────────────────────────────────────────────────────────────────────── MOVE
        Δ ⊢ move_{L→L'} v : F (@_{L ∪ L'} V) ∣ ⟨net_{L,L'}, ⟨c, c⟩⟩ · ⟨0, δ⟩
```

`loc(Δ)` est l'intersection des localités des liaisons employées ; `loc(c)` la localisation où le calcul s'exécute.

## C.5 Le point qu'on ne voit pas venir

**La distribution ouvre un canal d'observation que le treillis des niveaux doit comptabiliser.**

Déplacer une valeur émet, sur le réseau, l'information qu'un message de taille donnée est allé de `L` vers `L'` à une date donnée. Ce fait est observable par quiconque observe le réseau, **indépendamment du chiffrement du contenu**. La prémisse `niv(V) ⊑ ℓ_net` de `MOVE` est donc obligatoire, et elle n'est pas cosmétique : sans elle, un programme peut divulguer un secret par le simple **motif** de ses déplacements.

**Conséquence pour le manuscrit.** `MOVE` hors de cette contrainte doit passer par une déclassification explicite — c'est-à-dire par la règle (10) du §2.4. Or cette règle est fausse telle qu'imprimée (`BLOQ-11` : la clause de clôture de `𝒳` n'a pas été rétropropagée).

**Il y a donc une dépendance de la couche 1 distribuée vers une correction d'une ligne du chapitre 2.** Sans elle, la distribution est typée par une règle qui admet le blanchiment par substitution. `BLOQ-11` passe de « correction d'une ligne » à « prérequis d'une couche ».

## C.6 Ce que la contribution règle dans le plan PR-02

`STRUCT-19` (compilation/exécution comme modalité) reçoit son patron : la même construction, sur le treillis à deux points. `IMPL-06` (profil `Π`) gagne sa composante réseau. `BLOQ-11` gagne une raison supplémentaire d'être traité tôt.

---

# D — Analyse de la règle GUARD

C'est le point de risque signalé au §9 du programme de concurrence : *la règle `GUARD` demande une opération sur les contextes que l'algèbre des grades ne fournit peut-être pas.* Analyse conduite ici avant d'écrire les trente pages de l'étape 2.

## D.1 Ce que la règle doit faire

`guard v {mᵢ(x̄ᵢ) ↦ cᵢ}` bloque jusqu'à l'arrivée d'un message correspondant à l'un des motifs, puis exécute **exactement une** branche. Trois questions se posent :

1. quel contexte la règle conclut-elle, à partir des contextes `Δᵢ` des branches ?
2. quel effet, à partir des effets `εᵢ` ?
3. quelle contrainte de sécurité, sachant que *l'identité de la branche prise est elle-même une information* ?

La difficulté est que **le recours au procédé de `CASE` n'est pas disponible tel quel.** `CASE` exige un contexte `Δ₂` syntaxiquement identique dans toutes les branches (p. 248), et justifie cette exigence par le partage : une seule branche s'exécute. Mais `GUARD` lie dans chaque branche une continuation `y :₁ Mb?Eᵢ` **de type différent** — le résiduel dépend du message reçu. La partie partagée `Δᵢ` peut encore être exigée identique ; la question est de savoir si c'est trop restrictif.

## D.2 Ce que chaque composante demande

Il faut distinguer deux opérations, et le manuscrit n'en nomme qu'une.

| | sens | opération |
|---|---|---|
| **composition** (les deux usages ont lieu) | séquence, application | `Δ₁ + Δ₂`, déjà définie |
| **branchement** (un seul usage a lieu) | `CASE`, `WITH`, `GUARD` | `⋎`, **non définie** |

Composante par composante :

| Composante | Composition (les deux) | Branchement (un seul) | Motif |
|---|---|---|---|
| usage `u ∈ 𝕌` | `+` | **`max`** | il faut pouvoir fournir ce que demande la branche la plus gourmande |
| monotonie `m ∈ 𝕄` | `min` (table 20) | **`max_⪯`** | il faut exiger la monotonie si une branche la réclame |
| niveau `ℓ ∈ ℒ` | `⊔` | **`⊔`** | identique |
| budget `β ∈ 𝔅` | `⊖` séquentiel | **`max`** | il faut réserver pour le pire cas |

**Définition D.1.** `⟨u₁,m₁,ℓ₁,β₁⟩ ⋎ ⟨u₂,m₂,ℓ₂,β₂⟩ := ⟨max(u₁,u₂), max_⪯(m₁,m₂), ℓ₁ ⊔ ℓ₂, max(β₁,β₂)⟩`, étendu ponctuellement aux contextes portant les mêmes liaisons.

**Lemme D.2 (existence).** *`⋎` est définie partout et est un opérateur de demi-treillis — idempotent, commutatif, associatif.*
**Preuve.** `𝕌 = ℚ≥0 ∪ {ω}` et `𝔅 = ℕ∞` sont totalement ordonnés, donc `max` existe ; `𝕄` est une chaîne à deux éléments ; `ℒ` est un treillis. Chacune des quatre opérations est un `⊔` dans l'ordre concerné. ∎

**L'algèbre fournit donc l'opération.** Le risque signalé au §9 est levé sur ce point — mais il se déplace, et de façon instructive.

## D.3 Le résultat inattendu : un troisième ordre sur ℛ

Écrivons l'ordre dans lequel `⋎` est la borne supérieure :

```
⊴  =  (≤) × (⪯) × (≤) × (≤)
```

et rappelons celui de la table 20, vérifié p. 250 :

```
≼  =  (≥) × (⪰) × (≤) × (≤)
```

**Les deux ordres diffèrent sur exactement deux composantes : l'usage et la monotonie.**

Et ce ne sont pas deux composantes quelconques : ce sont **les deux dont la coercion « descend »** selon la table 20. Le manuscrit énonce d'ailleurs le motif sans en tirer la conséquence — disposer d'une ressource librement copiable permet de ne l'employer qu'une fois, avoir établi qu'une fonction préserve l'ordre permet de l'oublier.

**Proposition D.3.** *Sur ℛ, la position de type et la position de contexte sont contravariantes exactement sur `𝕌 × 𝕄`, et covariantes sur `ℒ × 𝔅`.*

**Lecture.** `𝕌` et `𝕄` portent des **capacités** — ce qu'on a le droit de faire. `ℒ` et `𝔅` portent des **classifications** — ce que la chose est. Une capacité offerte en abondance satisfait une demande modeste, d'où la contravariance ; une classification ne s'inverse pas.

**Ce que cela implique pour le manuscrit.** Trois ordres circulent désormais sur `ℛ` :

| Ordre | Rôle | Où il est écrit aujourd'hui |
|---|---|---|
| `⊑` | précision de l'information | table 5, p. 39 |
| `≼` | sous-typage modal, produit mixte | table 20, p. 250 |
| `⊴` | demande, combinaison de branches | **nulle part** |

**`⊴` doit entrer dans la table 5 et dans la table 20 avec sa direction.** Sans cela, le programme de concurrence reproduirait exactement le défaut `BLOQ-14` : une direction correcte à l'annexe, absente du corps, et contredite trois chapitres plus haut. La leçon de la vérification du 14 septembre s'applique à l'extension avant qu'elle ne soit écrite.

## D.4 La soundness dépend du fragment — et c'est une bonne nouvelle

`max(1, 0) = 1` : si une branche emploie `x` une fois et l'autre pas du tout, la règle conclut une demande de 1, et la branche qui n'emploie pas `x` doit **l'abandonner**.

| Fragment | Abandon licite ? | `⋎` sur l'usage |
|---|---|---|
| **cartésien** (couche 3, `u = ω`) | oui, `ω` est affaiblissable | ✓ sain, et trivial |
| **affine** (couche 2, `u ∈ [0..1]`) | oui, c'est la définition du fragment | ✓ **sain** |
| **linéaire** (couche 1, `u = 1`) | **non** | ✗ exige l'égalité, ou un `discard` explicite |

**Théorème D.4 (⋎ est indexé par le fragment).** *`⋎` est une opération saine de combinaison de branches sur les fragments affine et cartésien. Sur le fragment linéaire, la combinaison saine est l'égalité des contextes, sauf à introduire une élimination explicite.*

**Pourquoi c'est une bonne nouvelle.** La règle de branchement n'est pas uniforme, et sa variation **est** la sédimentation : chaque couche reçoit la règle que son fragment autorise, et la restriction de la couche 1 est celle que la linéarité impose partout ailleurs. Le manuscrit revendique cette architecture ; voici un endroit où elle produit un résultat au lieu de le décrire.

**Effet de bord — `CASE` est généralisable.** `CASE` exige aujourd'hui l'égalité des contextes dans tous les fragments. Par le théorème D.4, cette exigence est **inutilement forte en couches 2 et 3**, où `⋎` suffit. Deux branches d'un `case` de couche 3 peuvent employer une variable un nombre de fois différent sans rien enfreindre. L'analyse de `GUARD` améliore donc une règle existante — ce qui est le signe que l'extension entre dans la charpente au lieu de s'y ajouter.

## D.5 La clause de niveau, et le trou qu'elle révèle dans CASE

`guard` se branche sur **l'étiquette du message reçu**. Cette étiquette est une information. Si une boîte peut recevoir `tick()` public et `key(k)` secret, alors le seul fait qu'une branche plutôt que l'autre s'exécute divulgue, au niveau public, un fait de niveau secret.

D'où la prémisse `(†)` : `⨆_{i∈I} niv(mᵢ) ⊑ niv(C)`.

**Or la même prémisse manque à `CASE`.** La règle de la p. 248 se lit :

```
Δ₁ ⊢ v : ⨁ᵢ Vᵢ      Δ₂, x :₁ Vᵢ ⊢ cᵢ : C ∣ ε   (∀i)
────────────────────────────────────────────────────
Δ₁ ⊠₁ Δ₂ ⊢ case v of {i ↦ cᵢ}ᵢ : C ∣ ε
```

**Rien n'y contraint le niveau.** Un `case` sur une somme dont le constructeur est secret produit un calcul dont le comportement dépend du secret, sans que le niveau de `C` ne soit relevé. C'est exactement le constat de `BLOQ-05` — « `CASE` n'impose rien sur les niveaux » — mais l'analyse de `GUARD` en donne le **scénario de rupture le plus court** : deux branches, deux étiquettes de niveaux différents, une divulgation.

**Conclusion pour le plan.** La clause de niveau n'est pas un ajout du programme de concurrence : c'est une correction due au manuscrit séquentiel, que la concurrence rend seulement plus visible. À verser à `BLOQ-05`.

## D.6 L'effet d'un GUARD, et ce que l'attente consomme

L'effet conclu est `⟨wait, ⟨0, δ⟩⟩ · (⨆ᵢ εᵢ)`, et la conclusion compose par `⊠` et non par `+` :

```
Δ₀ ⊠_{⟨wait,⟨0,δ⟩⟩} (⋎ᵢ Δᵢ)
```

**Deux conséquences, données par le théorème B.4.**

1. **L'attente ne consomme aucun travail et consomme de la profondeur.** `⟨0, δ⟩` : attendre ne fait rien, mais retarde. C'est la formulation correcte, et elle est impossible à écrire avec le `κ` scalaire actuel — ce qui montre que les contributions B et A sont liées et non indépendantes.
2. **L'attente est retranchée du budget de profondeur des branches, pas de leur budget de travail.** `ψ` transporte `β_s ⊖ δ` sur `⋎ᵢ Δᵢ` et laisse `β_w` intact. Autrement dit : *une branche qui a attendu longtemps a moins d'échéance restante, pas moins de travail autorisé.* C'est le comportement attendu d'un système temps réel, et il tombe de l'algèbre au lieu d'être stipulé.

**Une dépendance à signaler.** `⨆ᵢ εᵢ` suppose que `ℰ₀` possède les bornes supérieures binaires. Le chapitre 1 le pose (quantale), mais `PREUVE-09` établit que la présentation par générateurs et relations de l'annexe E.3.2 produit un **monoïde quotient**, dont la complétude n'est pas acquise. **La règle `GUARD` hérite donc de la question ouverte du théorème 40.** Pour `n` fini le besoin se réduit aux bornes supérieures *finies*, que le monoïde ordonné par treillis du chapitre 1 fournit — donc `GUARD` est sûre tant que `I` est fini, ce qui est le cas de tout motif écrit. **À écrire comme condition, non à supposer.**

## D.7 Recommandation : deux temps

**Temps 1 — écrire `GUARD` avec l'égalité des contextes, plus la clause `(†)`.**
Aucune algèbre nouvelle ; identique au procédé de `CASE` ; sain dans les trois fragments ; suffisant pour tous les exemples du chapitre 7. Permet de conduire l'étape 2 du programme sans dépendre de `TRANS-02`.

**Temps 2 — introduire `⋎` comme généralisation admissible.**
Définir `⊴`, l'inscrire aux tables 5 et 20, démontrer le théorème D.4, puis énoncer que `GUARD-⋎` et `CASE-⋎` sont admissibles sur les fragments affine et cartésien. Gain d'expressivité réel, et amélioration rétroactive d'une règle existante.

**Ordre imposé :** le temps 2 dépend de `TRANS-02` (l'algèbre des grades doit avoir une définition unique avant qu'on lui ajoute un troisième ordre) et de `BLOQ-03` (`⊖` en `ω`, pour le budget). Le temps 1 n'en dépend pas.

## D.8 Les trois cas d'épreuve, à exécuter avant d'écrire

Promis au §9 du programme. Chacun tient sur une page et décide d'un point.

**T1 — usage inégal dans le fragment affine.**
Un acteur avec un tampon local affine `b`. Branche `put(x)` : emploie `b` une fois. Branche `stop()` : ne l'emploie pas.
*Attendu :* échec sous l'égalité, succès sous `⋎` avec `u(b) = 1` et abandon licite dans `stop`.
*Ce que l'échec signifierait :* que le temps 1 rend `GUARD` inutilisable pour tout acteur à état local — auquel cas `⋎` n'est pas une généralisation mais un prérequis, et l'ordre du §D.7 s'inverse.

**T2 — branchement dans le fragment linéaire.**
Une session de couche 1 offrant deux choix, dont l'un consomme une capacité linéaire.
*Attendu :* confirmation que l'égalité est requise et que le procédé existant (`WITH`, `CASE`) est déjà le bon pour la couche 1.
*Ce que l'échec signifierait :* que le partage de contexte de `WITH` est plus subtil que le manuscrit ne le dit, ce qui rouvrirait `PREUVE-01` (la clause `WITH` du théorème 45).

**T3 — étiquettes de niveaux différents.** *À exécuter en premier.*
Une boîte de motif `tick[] · key[Secret]`. Deux branches, deux niveaux.
*Attendu :* sans `(†)`, une dérivation valide divulgue ; avec `(†)`, elle est rejetée.
*Pourquoi en premier :* c'est le seul des trois dont l'échec est un trou de sécurité et non une limite d'expressivité, et il vaut aussi pour `CASE` dans le manuscrit actuel.

---

# Dossier de remise

Cinq fichiers, produits entre le 14 et le 15 septembre 2026, à transmettre ensemble.

| Fichier | Contenu | Usage |
|---|---|---|
| `K7PL_taches_consolidees_PR02.md` | 127 fiches issues des six peer-reviews, table de couverture item par item, index par théorème et par chapitre, ordre d'exécution, §19 des vérifications conduites sur le PDF | **plan de correction du manuscrit existant** |
| `K7PL_etude_opportunite_HoTT.md` | Étude d'opportunité HoTT et déclinaisons ; verdict négatif sur le socle, quatre imports retenus, conditions de falsification | **décision de cadre** — à consigner au §1.2 |
| `K7PL_programme_concurrence.md` | Décisions de conception D1–D6, noyau formel des trois couches, 14 théorèmes nouveaux, impact sur 12 théorèmes existants, ordre en 5 étapes, risques | **programme de construction** |
| `K7PL_contributions_formelles.md` *(ce fichier)* | Les trois contributions propres développées ; analyse complète de `GUARD` ; trois cas d'épreuve | **matériau d'intégration à l'annexe E** |
| `K7PL_PR.pdf` | Manuscrit évalué, 285 p. | référence |

## Ce qui doit être fait en premier, quoi qu'il arrive

1. **T3** (§D.8) — une page, et il porte sur le manuscrit actuel, pas sur l'extension.
2. **`BLOQ-02`** — trois lignes ; la règle `WHEN` imprimée est fausse et une modalité n'a pas de glyphe.
3. **`TRANS-01`** — le sceau statut × niveau ; sans lui, rien de ce qui précède n'est auditable.
4. **`TRANS-02`** — l'algèbre des grades ; tout le reste s'y appuie, y compris `⊴`.
5. **`N-02`** (déterminisme du parallélisme cartésien) — court, vrai, sans dépendance, et il retire immédiatement un tiers de la revendication.

## Trois points sur lesquels l'équipe doit trancher, et que ce dossier ne tranche pas

- **`ARB-PR-03`** — effets à portée : maintenir la distinction, ou unifier. Trois positions dans les revues.
- **`ARB-PR-05` / `ARB-PR-07`** — le cadre de rédaction du noyau. Quatre formulations concurrentes, toutes compatibles sur le fond, à réduire à une.
- **Le périmètre de `N-11`** — déterminisme observationnel sous ordonnanceur quelconque, ou sous hypothèse nommée. Décision de projet, pas décision technique, et elle fixe le coût de l'étape 3.
