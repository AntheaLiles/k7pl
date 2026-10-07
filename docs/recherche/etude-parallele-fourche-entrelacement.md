<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Étude comparative : `∥` et `vmap`, fourche-jointure contre entrelacement

**Séance 32 (6 octobre 2026), partie C.** Réponse à la décision de l'auteur : « *pour faire un choix éclairé j'ai besoin d'avoir une analyse des possibilités au regard de l'état actuel du manuscrit* ».

**Statut.** Aucun choix n'est fait ici et le manuscrit (`spec/`) n'est pas modifié. La fourche-jointure est **appliquée, à ratifier** (`DECISIONS.md`) ; cette étude ne la défait pas, elle dit ce qu'elle coûte et ce que coûteraient les autres voies. L'avis du §8 est un avis, avec ses conditions de révision. Les clauses de traduction sont des esquisses non vérifiées par machine. Les faits sur le manuscrit sont vérifiés dans le dépôt ; les coûts de preuve sont des estimations de rédacteur. Étude sœur : [`etude-spawn-fil-de-temps`](etude-spawn-fil-de-temps.md) (voir §6).

## 1. En bref

**La question.** `c1 ∥ c2` et `vmap v w` sont réduits aujourd'hui par **fourche et jointure** (`eq:reductions-orientees`) : chaque branche s'exécute depuis la trace vide, et la trace de la configuration s'étend d'**un seul événement**, `π(τ₁) ∥ π(τ₂)`. L'alternative est l'**entrelacement avec une trace par branche** : les branches deviennent des fibrilles, la trace un ordre partiel dès la couche 3.

**Les variantes.**

| | Variante | En une phrase |
|---|---|---|
| `V0` | fourche-jointure à grand pas (appliquée, voie B) | un pas dont la prémisse exécute les branches ; un événement agrégé |
| `V1` | déplier en séquence (voie A, écartée) | `c1 ∥ c2 → let x ← c1 in let y ← c2 in return (x, y)` ; fausse la profondeur |
| `V2` | entrelacement (voie C) | branches en fibrilles, jointure structurelle ; `V2a` ordonnanceur libre et lemme du diamant, `V2b` politique déterministe |
| `V3` | fourche-jointure à trace structurée (hybride, **proposée ici**) | `V0` mais la trace garde les événements des branches, en composition parallèle |
| `V4` | `∥` comme sucre de `spawn`, boîte et garde | écartée par le coût |
| `V5` | sémantique de coût séparée de la réduction | écartée par le principe « un seul objet » (`sec:g-semantique`) |

**Ce qui est solide.**

1. `V1` et `V4` faussent la borne que le type annonce (profondeur de `V1`, travail et profondeur de `V4`) ; `V5` contredit un principe écrit du texte.
2. **`V0` a quatre trous indépendants du choix entre fourche et entrelacement** (§4) : `∥` n'est défini sur `ℰ₀` nulle part ; le schéma est écrit sur les triplets alors que `Par` ne dit pas « couche 3 » ; la fusion `μ₁ ⊎ μ₂` n'a pas son lemme ; la monotonie de `∥` est utilisée sans être énoncée.
3. **Le texte est ambivalent** sur ce qu'est `∥` : cinq endroits disent « entrelacement » ou « membres du multi-ensemble », un (le schéma, auquel s'accorde la clause à grands pas de la relation logique) dit « fourche-jointure », un dit « déterministe sur la couche 3 » (§2). Le choix n'ajoute donc pas une idée à un texte univoque, il tranche une ambivalence.
4. **`V0 → V3 → V2` est une suite où chaque étape raffine la précédente** par une application d'oubli (`π`) : les énoncés de l'étape `n` sont ceux de l'étape `n+1` composés avec `π`. On peut donc avancer sans jeter de preuve.

**Avis** (§8) : garder `V0` tant que ses quatre trous sont réparés (peu coûteux), passer à `V3` si l'auteur veut la trace partielle dès la couche 3 au prix le plus bas, **ne pas** faire `V2` avant que la couche 2 ait sa préservation (typage des configurations, préservation par chaîne), dont il hériterait.

## 2. Ce que le manuscrit dit aujourd'hui (faits vérifiés)

| Fait | Où |
|---|---|
| `Par` : `Δ₁ + Δ₂ ⊢ c₁ ∥ c₂ : F_{ε₁∥ε₂}(V₁ ⊗ V₂) \| ε₁ ∥ ε₂`. `Vmap` : `Δ₁ + n·Δ₂ ⊢ vmap v w : F(Vec n W) \| ⟨n·w(ε), s(ε)⟩`. **Aucune condition de couche** | `eq:regles-parallele` (§3.2, `sec:g-parallelisme`) |
| `⟨w₁,s₁⟩ · ⟨w₂,s₂⟩ = ⟨w₁+w₂, s₁+s₂⟩`, `⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁+w₂, max(s₁,s₂)⟩` ; `∥` est dit commutatif sur `ℰ₀` ; loi d'échange `(a·b) ∥ (c·d) ⊑ (a∥c)·(b∥d)` (énoncée, sans label) | `eq:cout-parallele` |
| Facteur temporel : `ℰ = ℰ₀ × (ℕ∞ × ℕ∞)^ℒ` | `eq:grammaire-types` ; `ANOM-18` |
| Fourche-jointure : prémisse `⟨cᵢ \| μ \| ∅⟩ →* ⟨return vᵢ \| μᵢ \| τᵢ⟩`, conclusion `τ · (π(τ₁) ∥ π(τ₂))` et `μ₁ ⊎ μ₂` ; `vmap` pareil sur `n` branches. « Cette orientation n'est pas la plus fidèle : l'entrelacement avec une trace par branche, ordre partiel dès la couche 3, la prolongerait » | `eq:reductions-orientees` (§4.7) |
| `μ₁`, `μ₂` « ont des supports disjoints, ce que l'addition des contextes de `Par` garantit par la linéarité des capacités d'écriture » (prose, sans lemme) | `sec:g-semantique` |
| La relation est « déterministe sur la couche 3 », « ce dont dépend le rejeu de P4 » ; elle « se relève aux configurations concurrentes … sans que le déterminisme de la couche 3 soit perdu » | introduction de `sec:g-semantique` |
| `thm:determinisme_parallele` (théorème) : mêmes valeurs, effets différents sur la profondeur « où le second majore le premier » (énoncé corrigé en séance 31). **L'esquisse parle d'entrelacement** : « l'entrelacement ne distingue aucun état » | `sec:g-parallelisme` |
| `thm:surete_spatiale` : « deux membres du multi-ensemble de calculs, composés par la règle `Par` » | `sec:c4-modeles-de-memoire` |
| P4 : couche 3 « déterministe *par construction* : deux branches parallèles n'ont aucun endroit où interférer » | `Postulats` (ch. 1) |
| P3 borne **les deux** composantes : « le travail, nombre total de pas, et la profondeur, longueur du plus long chemin de dépendances » | `Postulats` (ch. 1) |
| Sous concurrence (couche 2), `τ` « cesse d'être une suite » : ordre partiel étiqueté ; `Loc` relève les schémas de la couche 3 (`τ ◁_p τ₀`) | fin de `sec:g-couche2` ; `eq:reductions-couche2` |
| `thm:preservation` : `τ'·ε' ⊑ τ·ε`, « le long de chaque chaîne » sous concurrence ; le cas `∥` « repose sur la préservation le long des suites de pas des branches » ; **typage des configurations non écrit** | `thm:preservation` (§4.7) |
| Relation logique : la clause `F_ε V` est à grands pas (`c ⇓ (v, τ)`), égalité des traces après `π^♭_ℓ` | `eq:relation-logique` |
| `thm:action_parallele` : `φ_r(ε₁ ∥ ε₂) = φ_r(ε₁) ∥ φ_r(ε₂)`, preuve sur les deux composantes temporelles seulement | `sec:c2-la-comonade-exponentielle-et`, `thm:action_parallele` |
| « Un seul objet » : `→` est la définition de l'exécution « et rien d'autre ne l'est » | `sec:g-semantique` |
| Ordre de préservation `P_dén`, `P_grad`, `P_trace(ℓ)`, `P_repr` ; règle « une unité `ℓ`-sensible n'admet que les passes `P_trace(ℓ)` » ; elle « localise le conflit entre P3 et la non-interférence temporelle sans le résoudre » | `tab:invariants-de-passe` (§6.1, `sec:c6-le-processus-de-compilation`) |
| `thm:determinisme_observationnel` (conjecture) : mêmes projections pour deux entrelacements, sous `𝒟_𝒮` | `sec:c2-le-systeme-de-raffinement` |
| Fil de temps enfilé, journal `J_k`, projection `π^♭_ℓ`, clause de session | `eq:traduction-fils`, `thm:chaine_fils`, `eq:relation-sessions-mondes` |

**La carte des ambivalences.** Lecture entrelacée : P4 (« aucun endroit où interférer »), l'esquisse de `thm:determinisme_parallele`, `thm:surete_spatiale` (« membres du multi-ensemble »), la loi d'échange (« entrelacer ne coûte jamais plus que séquencer par tranches »), la phrase de `eq:reductions-orientees` sur la fidélité. Lecture fourche-jointure : le schéma `eq:reductions-orientees`, la clause à grands pas de la relation logique. Lecture « fonctionnelle » : « déterministe sur la couche 3 ». Les trois ne peuvent pas être toutes littéralement vraies de la même sémantique : un entrelacement libre rend `→` non fonctionnelle (le déterminisme devient alors un théorème de confluence, non une propriété de la relation).

## 3. Grille : ce que toute variante doit tenir

| | Exigence | Source |
|---|---|---|
| `F1` | **valeur** : `c₁ ∥ c₂` rend la valeur de la séquence | `thm:determinisme_parallele` |
| `F2` | **majoration de profondeur** : la séquence majore le parallèle ; la préservation `τ'·ε' ⊑ τ·ε` tient pour le contractum | `thm:determinisme_parallele`, `thm:preservation` |
| `F3` | **travail et profondeur** : les deux composantes sont bornées, et la profondeur est « le plus long chemin de dépendances » ; celle de `vmap` ne dépend pas de `n` | P3, `eq:regles-parallele` |
| `F4` | **déterminisme** de `→` en couche 3 et rejeu de P4 | `sec:g-semantique`, P4 |
| `F5` | **mémoire** : `μ₁`, `μ₂` disjoints, aucune mutation concurrente typable | `thm:surete_spatiale` |
| `F6` | **journal des effets** : trace source `τ`, journal cible `J_k`, simulation | `thm:simulation`, `eq:traduction-fils` |
| `F7` | **couche 2** : place de `spawn`, de `guard`, de `Loc`, et branches de couche 2 | `eq:reductions-couche2` |
| `F8` | **progrès** | `thm:progres` |
| `F9` | **préservation graduée** et **non-interférence** ; `P_trace(ℓ)` | `thm:preservation`, `thm:non_interference`, `tab:invariants-de-passe` |
| `F10` | **coût de preuve** et dette sur les énoncés scellés | — |

## 4. Quatre trous de `V0`, indépendants du choix

1. **`∥` sur `ℰ₀` n'est pas défini.** `eq:cout-parallele` ne définit `∥` que sur le facteur temporel ; le texte affirme que `(ℰ₀, ∥, 1)` est commutatif sans dire quelle opération c'est. `thm:determinisme_parallele` l'évite en se restreignant à la couche 3, où `ℰ₀` est neutre. Toute variante qui laisse un `∥` porter des effets de couche 2 doit définir `∥` sur `ℰ₀` (réunion, mélange commutatif des mots d'opérations : un choix de modèle).
2. **Le schéma est écrit sur les triplets.** La prémisse `⟨cᵢ | μ | ∅⟩ →* …` n'a pas de boîtes ni de pool ; `send`, `guard`, `spawn` sont des règles globales de la couche 2. Une branche qui les contient est donc **bloquée** dans la prémisse, et `c₁ ∥ c₂` ne réduit pas, sans pour autant être en attente d'un message : le progrès (sa forme globale) tombe. `Par` n'a pas de condition de couche. Il faut soit restreindre `Par` à la couche 3 (comme `thm:determinisme_parallele` le fait dans son énoncé), soit relever le schéma aux quadruplets.
3. **`μ₁ ⊎ μ₂` n'a pas son lemme.** Que `⊎` soit défini est dit en prose (« ce que l'addition des contextes garantit »). Il manque un lemme de **support** : une exécution typée sous `Δ_i` n'écrit que dans les régions de ses capacités. `thm:surete_spatiale` dit qu'aucune mutation concurrente n'est *typable*, non que l'exécution respecte son support. Sans ce lemme, la règle peut ne pas s'appliquer à un terme bien typé (progrès). Les variantes à état partagé (`V2`) en ont besoin pour chaque pas (commutation) : coût `M`, **commun à toutes les variantes**.
4. **La monotonie de `∥` est utilisée sans être énoncée** (« que ce document n'énonce pas », esquisse de `thm:preservation`). Sur les couples d'entiers elle est immédiate. Vérifié par énumération (couples de `[0, 6]²`, rédacteur) : commutativité, associativité, monotonie, `max(s₁, s₂) ≤ s₁ + s₂` composante par composante, et la loi d'échange, stricte dans certains cas.

À ces trous s'ajoute `ANOM-18` : si `κ` est une famille par niveau, `∥` agit niveau par niveau, et l'événement agrégé `π(τ₁) ∥ π(τ₂)` est une famille.

## 5. Les variantes

### 5.1 `V0` : fourche-jointure à grand pas (appliquée)

**Définition.** Règle de `eq:reductions-orientees` :

```
⟨c₁ ∥ c₂ | μ | τ⟩ → ⟨return (v₁, v₂) | μ₁ ⊎ μ₂ | τ · (π(τ₁) ∥ π(τ₂))⟩
    si ⟨cᵢ | μ | ∅⟩ →* ⟨return vᵢ | μᵢ | τᵢ⟩   (i = 1, 2)
```

`vmap` est le même schéma sur `n` branches `(force v) wᵢ`.

**Sortes et traduction.** Le fil de temps pour `∥` demande une bifurcation et une jointure de chaînes, et **aucune capacité nouvelle** (les maillons voyagent le long d'un fil, au même niveau). Esquisse, avec `L = lev(ε₁) ∪ lev(ε₂)` :

```
⟦c₁ ∥ c₂⟧_{z,t⃗,t⃗'} =
  (ν x₁ x₂)(ν (u¹_k, u¹'_k, u²_k, u²'_k)_{k∈L}) (
      ∏_{k∈L} t̄_k⟨par, u¹_k, u²_k, t'_k⟩ | ∏_{k∉L} [t_k ↔ t'_k]
    | ⟦c₁⟧_{x₁,u¹,u¹'} | ⟦c₂⟧_{x₂,u²,u²'}
    | ∏_{k∈L} (ū¹'_k⟨end⟩ | ū²'_k⟨end⟩)
    | x₁(a) & x₂(b) ▷ z̄⟨(a, b)⟩ )
```

Le gestionnaire, sur `par`, écoute `u¹` et `u²`, et ne reprend la chaîne `t'_k` qu'après avoir reçu `end` sur les deux (un motif de jonction, déjà dans `eq:metalangage`). Les `end` sont émis tout de suite : ils attendent sur le dernier maillon de chaque branche, que le gestionnaire n'écoute qu'après le dernier événement de la branche. Chaque maillon reste produit une fois et consommé une fois. Le marqueur `par` ne fuit pas sous la même condition que le `fork` de l'étude sœur (`L ⊒ niv(Δ)`, par `thm:correspondance_niveaux`). Pour `vmap`, la jonction a l'arité `n`, définie par récurrence sur `n`, qui est clos à la compilation.

**Point de fond.** Le journal cible enregistre les événements **des branches**, un par un (les agréger demanderait un collecteur local qui reçoive des maillons, ce que la ligne « recevoir » de `tab:capacites` interdit à un terme traduit, ou un gestionnaire local créé par le programme, ce que `thm:confinement_sortes` interdit). La trace source, elle, a **un événement agrégé**. La simulation relie donc `τ'` à `J` **par `π`** : `π(J') = τ'`, une relation, et non « `τ'` étend `τ` par l'image des événements du pas », qui suppose que l'image de l'événement agrégé se lise dans `τ'` (elle ne s'y lit pas : les `τᵢ` sont jetés). La clause de la simulation est à écrire sous forme existentielle.

**Ce qu'elle impose / casse.** Les quatre trous du §4. `thm:progres` pour `∥` : voir trou 2 et trou 3. Mélange d'un grand pas et d'une relation à petits pas : la préservation procède par récurrence sur la dérivation du pas, avec une sous-récurrence sur la longueur de `→*` dans les prémisses (c'est ce que l'esquisse annonce). La profondeur comme « plus long chemin de dépendances » (P3) **n'est pas démontrable** dans la sémantique source : la trace ne contient pas le graphe de dépendances, la profondeur de `∥` est définie par `max`. L'énoncé de P3 sur la profondeur est alors une convention de composition, non un théorème sur les exécutions.

**Coût de preuve.**

| Poste | |
|---|---|
| quatre trous du §4 (`∥` sur `ℰ₀` ou restriction, schéma ou restriction de `Par`, lemme de support, monotonie) | M + S + M + S |
| cas `∥` et `vmap` de `thm:preservation` | S (la récurrence existe) |
| `thm:determinisme_parallele` : l'esquisse à aligner sur la sémantique | S |
| traduction du fil pour `∥` (bifurcation et jointure) et sa simulation modulo `π` | M + M |
| clause de session : comparaison de forêts à jointure | M, commun à `V2`, `V3` |

Total : **M**, énoncés scellés intacts.

**Risques.** La sémantique source est plus grossière que la cible (agrégation), ce qui pèse sur chaque énoncé qui relie les deux (`PREUVE-03`, `PREUVE-07`). Le grand pas fige le choix « les branches ne se parlent pas » : `∥` ne pourra jamais couvrir des branches de couche 2 sans une nouvelle règle.

### 5.2 `V1` : déplier en séquence (voie A, écartée)

`c₁ ∥ c₂ → let x ← c₁ in let y ← c₂ in return (x, y)`. Le contractum a pour effet `ε₁ · ε₂`, de profondeur `s₁ + s₂`, qui ne vérifie pas `ε₁ · ε₂ ⊑ ε₁ ∥ ε₂` dès que les deux profondeurs sont non nulles : la préservation `τ'·ε' ⊑ τ·ε` est fausse pour la profondeur, et la profondeur de `vmap` dépendrait de `n`. P3 borne les deux composantes, `V1` n'en tient qu'une. Elle n'est citée que comme base : elle montre que le contenu parallèle de `∥` est **dans la profondeur**, et que toute variante doit le porter dans la trace ou dans le type.

### 5.3 `V2` : entrelacement avec une trace par branche (voie C)

**Définition.** `c₁ ∥ c₂` engendre deux fibrilles et une jointure ; `vmap` en engendre `n`. Les nœuds de bifurcation et de jointure sont **structurels** : aucun événement source, donc aucun coût ajouté (un événement de fourche coûterait `⟨1, 1⟩` et ferait dépasser `max(s₁, s₂)`, donc casserait `F2`).

```
⟨𝒫 ⊎ {p : E[c₁ ∥ c₂]} | μ | ℳ | τ⟩
    → ⟨𝒫 ⊎ {p₁ : c₁, p₂ : c₂, p : join(p₁, p₂; E)} | μ | ℳ | τ'⟩      -- λ(p₁) = λ(p₂) = λ(p), aucun événement
⟨𝒫 ⊎ {p₁ : return v₁, p₂ : return v₂, p : join(p₁, p₂; E)} | μ | ℳ | τ⟩
    → ⟨𝒫 ⊎ {p : E[return (v₁, v₂)]} | μ | ℳ | τ[λ(p₁) ≺ p, λ(p₂) ≺ p]⟩
```

(avec la notation `τ[s ≺ p]` de la règle `Guard`, et `λ(q)` le dernier événement de `q`, que « reprenant après » de `Spawn` suppose déjà.) L'arène `μ` est **commune** : pas de fusion, mais un lemme de commutation des pas indépendants.

* **`V2a`, ordonnanceur libre.** `→` n'est plus fonctionnelle en couche 3. Le déterminisme devient un théorème : **lemme du diamant** (deux pas indépendants commutent), puis confluence, puis `thm:determinisme_parallele` comme corollaire (c'est enfin le sens de son esquisse : « l'entrelacement ne distingue aucun état »). Le rejeu de P4 en couche 3 reste sans journal si la confluence tient.
* **`V2b`, politique déterministe** (gauche d'abord, ou alternance). `→` reste fonctionnelle. Mais l'adéquation d'une exécution réellement parallèle (vectorisée, plusieurs cœurs) à la sémantique demande la même confluence : `V2b` ne dispense pas du diamant, elle le cache.

**Sortes et traduction.** La même que `V0` (bifurcation de chaîne, `end`, jonction au gestionnaire) ; la différence est du côté source : chaque pas d'une branche est un pas source, chaque événement un événement source, et **l'image se lit événement par événement**, sans agrégat (`F6` : la simulation garde sa forme).

**Ce qu'elle impose.**

* Le **typage des configurations** (pool, `join`, boîtes) et la **préservation par chaîne**, que le manuscrit n'écrit pas pour la couche 2 : `V2` fait donc dépendre de choses non écrites **toute la couche 3 qui emploie `∥`**. Aujourd'hui la préservation de la couche 3 est démontrée sur les blocs `eq:reductions-pures` et `eq:reductions-effets` ; avec `V2`, tout programme qui contient `∥` en dépend aussi.
* La relation `⇓` de la relation logique (`eq:relation-logique`) doit être définie sur les configurations concurrentes, avec un ordre partiel en sortie.
* `thm:determinisme_observationnel` (conjecture) voit son périmètre grandir : tout `∥` est une source d'entrelacement. Par confluence, en couche 3 la trace-poset est indépendante de l'entrelacement, donc la conjecture y est démontrable par le diamant ; mais l'hypothèse `𝒟_𝒮` (la politique ne consulte pas de valeur haute) doit être énoncée pour la couche 3.
* **`∥` se généralise à la couche 2** : les branches peuvent émettre, recevoir, engendrer ; la jointure attend les deux. Ce serait la concurrence structurée du langage, `spawn` en étant le cas sans jointure. C'est un gain de fidélité (`F7`), et le trou 1 (`∥` sur `ℰ₀`) devient bloquant.
* **La profondeur** redevient un théorème : la profondeur d'une exécution est le poids de la plus longue chaîne de `τ`, et la chaîne qui traverse une bifurcation choisit une branche, d'où `≤ max(s₁, s₂)` plus le reste. P3 (« plus long chemin de dépendances ») y trouve sa définition.

**Coût de preuve.**

| Poste | |
|---|---|
| typage des configurations avec `join` | L (déjà dû pour la couche 2) |
| préservation par chaîne, cas `∥`, `vmap` et `join` | L (déjà due pour la couche 2) |
| lemme du diamant et confluence, avec lemme de support | M à L, **nouveau** |
| `τ` poset en couche 3, `π` sur posets, `⇓` concurrente | M |
| progrès global avec `join` | M |
| `thm:determinisme_parallele` devenu substantiel | M |
| quatre trous du §4 | M + S + M + S (le trou 3 devient le lemme de commutation) |

Total : **L**, dont la plus grande part est **de la dette déjà inscrite pour la couche 2, avancée**.

**Risques.** Faire dépendre la préservation de la couche 3 de la machinerie de la couche 2 avant qu'elle soit écrite ; non-fonctionnalité de `→` à documenter face à la phrase « déterministe sur la couche 3 » (ou politique `V2b`) ; perte de la lecture « pas de grand pas dans petits pas ». Gain : une seule notion de trace, une seule définition de la profondeur, `∥` couvrant la couche 2.

### 5.4 `V3` : fourche-jointure à trace structurée (hybride)

**Définition.** On garde la règle de `V0` (grand pas, prémisse sur triplets, `→` fonctionnelle) et on change **ce qu'on écrit dans la trace** : non l'agrégat `π(τ₁) ∥ π(τ₂)`, mais la composition parallèle des traces des branches.

```
⟨c₁ ∥ c₂ | μ | τ⟩ → ⟨return (v₁, v₂) | μ₁ ⊎ μ₂ | τ · (τ₁ ∥ τ₂)⟩
    si ⟨cᵢ | μ | ∅⟩ →* ⟨return vᵢ | μᵢ | τᵢ⟩
```

`τ` vit dans les **posets série-parallèles** : les mots en sont les chaînes, `·` est la composition série, `∥` la composition parallèle, `𝟏` l'unité. `π : SP → ℰ` est le morphisme défini par récurrence sur la structure (`π(τ·τ') = π(τ)·π(τ')`, `π(τ ∥ τ') = π(τ) ∥ π(τ')`) ; `π^♭_ℓ` se définit par récurrence aussi (filtrer les événements dans chaque composante), sans parler de sous-ordre induit.

**Ce qui change par rapport à `V0`.** (i) La trace est partielle **dès la couche 3**, mais sans pool, sans ordonnanceur, sans diamant. (ii) L'image du journal cible (forêt avec jointure, §5.1) **se lit événement par événement** : la simulation retrouve sa forme. (iii) La profondeur est le poids de la plus longue chaîne de `τ` : le lemme `profondeur(τ) = π_profondeur(τ)` est une induction sur la structure, un cas `S`, qui donne à P3 une définition indépendante de la loi de composition du typage. (iv) `thm:preservation` : son énoncé dit déjà « sous concurrence, `τ` est un ordre partiel » ; il n'est pas modifié. L'inégalité du cas `∥` est celle de `V0` composée avec `π`.

**Ce qu'elle laisse.** Les quatre trous du §4 (inchangés). Le grand pas dans une relation à petits pas. La branche de couche 2 reste exclue (`V3` ne généralise pas `∥`).

**Coût de preuve.**

| Poste | |
|---|---|
| tout `V0` | M |
| algèbre des posets série-parallèles, `π`, `π^♭`, leurs propriétés | M |
| `Loc` : placer un poset après le dernier événement de `p` | S |
| lemme profondeur = plus long chemin | S |

Total : **M**, un peu plus que `V0`, nettement moins que `V2`.

**Risques.** Une structure de données de plus à maintenir (posets série-parallèles) ; le grand pas reste à relever si `∥` doit un jour porter des branches de couche 2 ; la trace est plus fine que celle de `V0`, ce qui rend `P_trace(ℓ)` un peu plus exigeante à l'intérieur d'un `∥` (§7).

### 5.5 `V4` et `V5`, pour mémoire

**`V4`, sucre de `spawn`.** `c₁ ∥ c₂` serait `let b ← new in let _ ← spawn (let v ← c₂ in send res(v) to b) in let v₁ ← c₁ in guard b {res(v₂) ↦ …}`. Le coût : la fille émet `send` (`⟨1,1⟩`), donc le travail est `w₁ + w₂ + 1` et la profondeur `max(s₁, s₂ + 1)`, strictement plus que `ε₁ ∥ ε₂` (vérifié par énumération, §4). P3 interdit de dissimuler un coût, et `∥` ne serait plus un constructeur de la couche 3 (qui « n'a pas à être vérifiée ») mais de la couche 2. Écartée.

**`V5`, sémantique de coût séparée.** Réduire `∥` en séquence pour les valeurs (`V1`) et calculer le travail et la profondeur par un jugement à grands pas distinct. La trace ne porterait plus la profondeur, et le texte pose « un seul objet » (`sec:g-semantique`, « la relation `→` … est la définition de l'exécution, et rien d'autre ne l'est »). Écartée par principe ; l'idée recoupe les sémantiques de coût à graphes de la littérature, que ce dépôt n'a pas instruites (§9).

## 6. Rapport avec la couche 2 (`spawn`, `guard`) et avec l'étude sur `spawn`

Trois arêtes de l'ordre partiel : **bifurcation** (`spawn`), **jointure** (ce que `∥` ajoute), **message** (`τ[s ≺ p]` de `Guard`). `spawn` est une bifurcation sans jointure ; `∥` une bifurcation avec jointure ; `guard` une arête transversale.

* Sous `V2`, les trois vivent dans un même ordre partiel ; sous `V0` et `V3`, `∥` est une construction à grands pas de la couche 3 et la couche 2 a son ordre à elle.
* La traduction du fil de `∥` (bifurcation, jointure) **est** celle de `spawn` (bifurcation) avec un `end` en plus. Si l'étude sœur retient la bifurcation par maillon (`O1b`), `∥` en hérite à peu de frais ; si elle retient un fil fourni par le gestionnaire (`O3`), la jointure se fait dans le gestionnaire, qui détient déjà la filiation.
* **Le sens de « profondeur » diffère** : `Spawn` annonce la profondeur `0` pour la mère (« rien à la profondeur de la mère », `eq:regles-couche2`), la fille faisant sa profondeur de son côté ; `∥` annonce `max(s₁, s₂)`. Sur un poset unifié, la plus longue chaîne qui traverse l'arête de `spawn` peut dépasser la profondeur de la mère : « le long de chaque chaîne » de `thm:preservation` doit se lire **par fibrille** pour `spawn` et **par chemin** pour `∥`. À fixer dans tout poset unifié.
* `∥` ne se dérive pas de `spawn` (`V4`) sans coût.

## 7. Préservation graduée, `P_trace(ℓ)`, non-interférence

**`P_grad`** (le jugement gradué est préservé par les passes d'abaissement, `ARB-PR-06`). `Δ₁ + Δ₂` somme les grades : sous toutes les variantes, la partie « usage » de la préservation graduée pour `∥` se ramène au lemme de support (trou 3). `V2` ajoute à la préservation la propriété de commutation ; `V0` et `V3` l'ont dans leur fusion `μ₁ ⊎ μ₂`.

**`P_trace(ℓ)`** (la trace projetée `π_ℓ(τ)` est préservée dans une unité `ℓ`-sensible). La règle exclut déjà de ces unités les passes qui changent la trace (fusion, déforestation, inlining). Trois constats :

* Une passe qui **sérialise** un `∥` (déplier en séquence) ou qui en **crée** un (paralléliser une boucle) change la profondeur, donc `π_ℓ(τ)` : exclue de l'unité `ℓ`-sensible sous **toutes** les variantes.
* Les réécritures de la loi d'échange `(a·b) ∥ (c·d) ⊑ (a∥c)·(b∥d)` (stricte en général, vérifié) changent la profondeur : même conclusion.
* **Seule différence** : à l'intérieur d'un `∥`, `V0` n'expose que l'agrégat par branche (une passe qui réordonne des événements de même `π` y est invisible), `V3` et `V2` exposent les événements. Dans les unités `ℓ`-sensibles les passes de réécriture sont déjà exclues ; ailleurs aucune contrainte. `P_trace(ℓ)` **ne départage donc pas** les variantes, sauf pour des réordonnancements intra-branche.

**Non-interférence.** Le fragment sans communication est démontré (`thm:lemme_fondamental`), dont la clause de calcul est à grands pas (`⇓`) : elle s'accorde à `V0` et `V3` sans travail. `V2` demande de définir `⇓` sur des configurations concurrentes (trace-poset). Sous `thm:correspondance_niveaux`, les événements d'une branche sont de niveau `⊒ niv(Δ)` : la finesse de la trace (agrégat ou événements) **ne crée pas de fuite**, un niveau `ℓ` qui ne lit pas `niv(Δ)` n'en voit ni l'un ni l'autre.

## 8. Exemples

**`E1` : `vmap f [a, b, c]` avec `f = tick` (un niveau).**

| Variante | Trace |
|---|---|
| `V0` | `τ · ⟨3, 1⟩` : un événement agrégé (travail 3, profondeur 1) |
| `V3` | `τ · (t ∥ t ∥ t)` : trois événements incomparables, `π = ⟨3, 1⟩` |
| `V2` | trois fibrilles `p₁ p₂ p₃`, trois événements incomparables, jointure à trois ; même poset que `V3` |
| `V1` | `τ · t · t · t`, `⟨3, 3⟩` : profondeur qui dépend de `n` |

**`E2` : `∥` à branche de couche 2.** `c₁ = send ping() to ι`, `c₂ = tick`. `V0` et `V3` : la prémisse n'a pas de règle pour `send` en triplet, le terme est bloqué sans attendre aucun message (trou 2). `V2` : `p₁` envoie, `p₂` tique, la jointure rend `((), ())`.

**`E3` : `V4` chiffré.** `c₁ = tick`, `c₂ = tick`. `ε₁ ∥ ε₂ = ⟨2, 1⟩`. Sous `V4`, la chaîne qui traverse la fille compte son `tick` puis son `send` : la profondeur est au moins 2 (`max(1, 1+1)`) et le travail au moins 3 (les deux `tick` et le `send`), plus que `⟨2, 1⟩` (la provision de `spawn` s'y ajoute encore au travail, `eq:regles-couche2`).

## 9. Tableau comparatif

| | `V0` appliquée | `V1` séquence | `V2a` entrelacement libre | `V2b` politique fixe | `V3` hybride |
|---|---|---|---|---|---|
| `F1` valeur | par la prémisse | par construction | diamant | diamant (caché) | par la prémisse |
| `F2` profondeur | oui (`max`) | **non** | oui, par chaîne | oui, par chaîne | oui (`max`) |
| `F3` profondeur = plus long chemin | convention | non | théorème | théorème | théorème (lemme `S`) |
| `F4` `→` fonctionnelle en couche 3 | oui | oui | **non** (confluence) | oui | oui |
| `F5` mémoire | `⊎` + lemme de support | sans objet | commutation + support | idem | `⊎` + lemme de support |
| `F6` trace source | agrégat (poset de mots) | mot | poset | poset | poset série-parallèle |
| `F6` simulation | modulo `π` (existentielle) | directe | directe | directe | directe |
| `F7` branches de couche 2 | non (trou 2) | non | **oui** | oui | non |
| `F8` progrès | trous 2 et 3 | oui | global, avec `join` | idem | trous 2 et 3 |
| `F9` `P_trace(ℓ)` | grossier intra-branche | sans objet | fin | fin | fin |
| Dépend de la couche 2 non écrite | non | non | **oui** | oui | non |
| Énoncé scellé modifié | non | oui (préservation fausse) | non | non | non |
| Coût | M | S, **incorrecte** | L | L | M |

## 10. Avis, feuille de route et conditions de révision

**Avis (non décision).**

1. **Réparer `V0` dans tous les cas** : les quatre trous du §4 ne dépendent pas du choix. Ce sont des travaux petits (`S` à `M`) et ils sont dus quelle que soit la suite.
2. **`V3` est le meilleur rapport fidélité-coût** si l'auteur veut la trace partielle dès la couche 3 : elle garde la relation fonctionnelle et le grand pas, ne tire rien de la couche 2, retrouve une simulation événement par événement (ce que `V0` ne peut pas), donne à P3 sa définition de la profondeur et ne modifie aucun énoncé.
3. **`V2` : pas maintenant.** Son coût est surtout de la dette de la couche 2 avancée (typage des configurations, préservation par chaîne). Il offre en retour `∥` sur des branches de couche 2 et une seule notion de trace.
4. **Feuille de route par étapes** : `V0` (réparé) → `V3` → `V2`. À chaque étape les énoncés de la précédente sont ceux de la suivante composés avec `π` : `V3` raffine `V0` par `π : SP → ℰ`, `V2` raffine `V3` par l'oubli des fibrilles. Une preuve conduite sur l'étape `n` n'est pas jetée à l'étape `n + 1`.
5. **L'ambivalence du texte (§2) est à lever par l'auteur** : dire dans un paragraphe quelle lecture de `∥` fait foi (fourche-jointure, ou entrelacement dont la fourche-jointure est l'étape). Les cinq passages à lecture entrelacée ne sont pas faux sous `V0`, mais ils parlent d'autre chose que ce que la règle écrit.

**Conditions de révision.**

* Si l'auteur veut `∥` sur des branches de couche 2 (concurrence structurée) : `V2`.
* Si l'étude sur `spawn` retient la bifurcation par maillon : `V3` et `V2` deviennent moins chères (même mécanisme) ; la traduction de `V0` aussi.
* Si l'on exige que `→` reste fonctionnelle en couche 3 : `V0`, `V3`, `V2b` (en gardant le diamant à l'esprit pour l'adéquation parallèle).
* Si l'on exige un théorème d'ordonnancement (une borne de temps réel en fonction du travail, de la profondeur et du nombre de processeurs) : `V3` ou `V2` (il faut le poset), non `V0` ; voir §11, source non instruite.
* Si `ANOM-18` se résout par un facteur temporel scalaire : refaire le §4 et la traduction (la jonction n'aurait plus de niveaux à ranger).
* Si `thm:correspondance_niveaux` échoue sur la couche 2 : la parade « bifurquer sur les niveaux de `L` » tombe, voir l'étude sur `spawn`.

## 11. Niveau de vérification et ce qui reste à faire

**Faits sur le manuscrit.** Vérifiés dans le dépôt à la date de rédaction (labels, règles, énoncés cités d'après leur texte).

**Vérifications mécaniques menées pour cette étude** (script du rédacteur, non versionné) : sur les couples d'entiers de `[0, 6]²`, commutativité et associativité de `∥`, monotonie de `∥`, `max(s₁, s₂) ≤ s₁ + s₂`, loi d'échange (avec cas stricts), et le surcoût de `V4` (`max(s₁, s₂ + 1) > max(s₁, s₂)`). Une énumération n'est pas une preuve ; elle écarte les erreurs de signe.

**Raisonnements non vérifiés.** Les esquisses de traduction, les coûts `S`, `M`, `L`, les constats de trou (§4) sont des raisonnements du rédacteur sur le texte, sans vérification par Lean ni preuve.

**Sources externes.** Les pages des éditeurs et d'arXiv sont inaccessibles depuis la session (vérifié par requête : aucune réponse). Rien ici ne s'appuie sur un article relu pour cette étude.

| Œuvre | Ce qui en est dit | Niveau de vérification |
|---|---|---|
| Das, Hoffmann, Pfenning (2018), `dasParallelComplexityAnalysis` | types de session temporels avec complexité parallèle (travail et profondeur) ; à lire pour la composition de coûts de `∥` | titre et notice de `biblio/references.json`, note du corpus ; corps non relu ici |
| Stefan et al. (2012), `stefanAddressingCovertTermination2012` | fils séparés pour les actions dont la durée dépend de secrets ; recoupe la non-interférence sous concurrence | note du corpus (« lu partiel ») ; corps non relu ici |
| Caires et Toninho (2026), `cairesLinearSessionAbstract2026` | machine à stratégie séquentielle déterministe (d'après le manuscrit) ; sa lecture de la composition parallèle est à vérifier | citation du manuscrit ; corps non relu ici |
| Littérature sur la sémantique de coût à graphes, le glouton et l'ordonnancement vol de tâches, et les posets série-parallèles | **aucune source au dépôt** ; connaissance générale du rédacteur, non vérifiée, non citée au sens bibliographique | à instruire (fiche de recherche) si l'auteur retient `V3` ou `V2` |

**À faire, dans l'ordre.** (1) Réparer les quatre trous de `V0` (`S` à `M`). (2) Aligner l'esquisse de `thm:determinisme_parallele` sur la sémantique retenue. (3) Décider la lecture de `∥` (§10, point 5). (4) Instruire la littérature de coût parallèle avant `V3` ou `V2`.
