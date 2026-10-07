<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 3 : `ANOM-18`, la forme complète du facteur temporel (`ℓ̂(ε_spawn)`, `thm:temps_mononiveau`)

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Ce dossier est l'analyse complète de `ANOM-18` (⬜ dans [`ANOMALIES.md`](../../suivi/ANOMALIES.md)), qui conditionne les dossiers [1](01-parallele-et-vmap.md) et [2](02-spawn-et-fil-de-temps.md). Il ne tranche rien ; `spec/` n'est pas modifié ; les textes Verso du §7 sont **non appliqués**.

**Niveau de vérification.** Toutes les citations du manuscrit sont lues dans les fichiers, aux lignes indiquées. Les raisonnements sur les effets sont de rédacteur ; **aucun** n'est vérifié par machine (le dépôt ne porte pas de modèle Lean de ces quantales). Aucune source externe n'a été relue ; voir le §10.

## 1. Question exacte

> Quelle est la **forme complète du facteur temporel** `κ` d'un effet `ε = ⟨φ, κ⟩` ? `ℕ∞` (nu) ? `ℕ∞^ℒ` (famille, travail seul) ? `(ℕ∞ × ℕ∞)^ℒ` (famille de couples travail et profondeur) ? Et, conséquence directe, **que vaut `ℓ̂(ε_spawn)`** pour `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩`, et que devient l'énoncé de `thm:temps_mononiveau` ?

## 2. État actuel du manuscrit : six écritures du facteur temporel

Chaque ligne a été lue.

| # | Écriture | Où (lu) |
|---|---|---|
| F1 | `ℰ₀ × ℕ∞`, « écrit ici `ℕ∞` pour la lecture ; sa forme complète … est une _famille_ de coûts temporels indexée par les niveaux, qui compte chaque événement au niveau qui l'a produit, et dont le cas mononiveau redonne la forme plate » | `spec/Spec/C1/AxiomatiqueGerminale.lean:478-485` |
| F2 | `κ ∈ ℕ∞^ℒ`, « le séquencement additionne les familles composante par composante ; l'unité est la famille nulle ; `φ_n` multiplie chaque composante par `n` » | `spec/Spec/C3/GrammaireDesTypes.lean:121-129` ; aussi `LeSystemeDeSortesDuMetalangage.lean:107-108` et `:299` |
| F3 | `ε ∈ ℰ = ℰ₀ × (ℕ∞ × ℕ∞)^ℒ` (formule `eq:grammaire-types`) | `GrammaireDesTypes.lean:46` |
| F4 | `thm:temps_mononiveau` (**théorème**, sceau par défaut) : si tous les ticks sont au niveau `ℓ`, « la restriction de `ℰ` aux tels effets est isomorphe, comme quantale ordonnée, à `ℰ₀ × ℕ∞` » ; preuve par `κ ↦ κ(ℓ)`, bijection avec `ℕ∞` | `GrammaireDesTypes.lean:133-153` |
| F5 | `Tick : ⟨𝟏, δ_ℓ̂⟩` (famille de Kronecker, un seul pas au niveau `ℓ̂`) | `spec/Spec/C3/ReglesDeTypage.lean:213`, 240-241 |
| F6 | couples **sans indice de niveau** : `Par : ε₁ ∥ ε₂` avec `⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁+w₂, max(s₁,s₂)⟩` « par niveau » (légende) ; `Vmap : ⟨n·w(ε), s(ε)⟩` ; `Spawn : ⟨spawn, ⟨w(ε), 0⟩⟩` ; `Send : ⟨send_m, ⟨1,1⟩⟩` ; `move : ⟨net_{n,m}, ⟨c,c⟩⟩` | `ReglesDeTypage.lean:1286-1295` (légende 1294), 1317, 1413, 1421 ; `SemantiqueOperationnelle.lean:173, 180, 279` ; `ReglesDeTypage.lean:1500` |
| F7 | le budget : `β ⊖ k` « où `k` est la composante temporelle de `ε` », `β ∈ ℕ∞` ; mais ailleurs « le budget qu'une liaison porte en est un couple lui aussi, et `ψ` le décroît composante par composante » | `ReglesDeTypage.lean:117-118`, `AxiomatiqueGerminale.lean:378` ; `spec/Spec/C2/ComonadeExponentielleEtFragments.lean` (paragraphe qui suit `thm:action_parallele`) |

Les trois endroits que `ANOMALIES.md` relevait (prose, `thm:temps_mononiveau`, §4.8 : `ℕ∞^ℒ` ; formule : `(ℕ∞×ℕ∞)^ℒ` ; schémas : couple sans niveau) sont F2-F4, F3 et F6. **Trois ajouts de ce dossier** : F1 (le chapitre 1 écrit `ℕ∞` nu, avec renvoi à la forme complète), F5 (`Tick` est un scalaire par niveau, non un couple) et F7 (le budget est scalaire dans une lecture, couple dans l'autre).

**Les notations `w(ε)` et `s(ε)` ne sont définies nulle part** : `grep` ne les trouve que dans `Vmap` (1317), `Spawn` (1413) et le schéma de `spawn` (173). Elles sont lues comme « la composante travail » et « la composante profondeur » de `κ`, mais de quel type (nombre ou famille) le texte ne le dit pas.

### 2.1 Conséquences constatées de l'indétermination

1. **`ℓ̂(ε_spawn)` n'est pas défini.** `ℓ̂(ε)` est « la borne inférieure des niveaux où `κ` est non nulle, et `⊤` si `κ = 0` » (`ReglesDeTypage.lean:237-238`). Pour `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩`, le support de `κ` n'est pas défini : si `⟨w(ε), 0⟩` est un couple de nombres, quel niveau porte-t-il ? Si c'est une famille, lequel ?
2. **`Spawn` n'a pas de clause de couplage** (`niv(Δ) ⊑ ℓ̂(ε)` figure dans `Case`, 205, et `Op`, 211, pas dans `Spawn`, 1413). Le même constat vaut pour **`Send`** (1421) et **`Move`** (1525). La clause de `Case` (`niv(Δ₁) ⊑ ℓ̂(ε)`, où `ε` est l'effet commun des branches) ne contraint donc pas un `case` sur un secret dont une branche fait `spawn`, `send` ou `move` : `ℓ̂` de leur effet est indéfini. **La fermeture du canal temporel « par règle » (`ReglesDeTypage.lean:245-246`) n'est établie que pour `tick` et les opérations de `Op`.**
3. **`thm:temps_mononiveau` est faux tel qu'écrit si `κ` est un couple.** Son énoncé identifie les effets concentrés à `ℰ₀ × ℕ∞` ; si `κ ∈ (ℕ∞×ℕ∞)^ℒ`, la restriction est isomorphe à `ℰ₀ × (ℕ∞ × ℕ∞)`. La **preuve** (`κ ↦ κ(ℓ)`) ne change pas ; l'**énoncé** change. C'est un **théorème scellé** : la correction demande l'accord de l'auteur.
4. **`thm:chaine_fils` et la traduction (`eq:traduction-fils`)** sont écrits sur `ℕ∞^ℒ`, un événement concentré en `ℓ̂`. Pour un effet non concentré (`spawn`, `vmap`, `∥`), la traduction « n'a pas de clause : elle demande de choisir sur quels fils son événement s'écrit, et le texte ne le dit pas » (`LeSystemeDeSortesDuMetalangage.lean:324-326`).
5. **Le budget** : `β ⊖ k` avec `β` scalaire et `k` « la composante temporelle » suppose un `k` scalaire ; avec une famille ou un couple de familles, il faut dire comment une famille agit sur un budget par liaison.
6. **P3** (« borne les deux composantes que le facteur temporel porte : le travail, et la profondeur », `Postulats.lean:130-132`) exclut toute forme qui perdrait l'une des deux.

## 3. Options exhaustives

| | Option | Forme de `κ` | Remarque |
|---|---|---|---|
| `A` | famille de couples, `w(ε)` et `s(ε)` **familles** (projections `ℰ → ℕ∞^ℒ`), `⟨a, b⟩` le couple de familles | `(ℕ∞ × ℕ∞)^ℒ ≅ ℕ∞^ℒ × ℕ∞^ℒ` | c'est `eq:grammaire-types` ; les schémas se relisent, rien de nouveau n'est introduit |
| `B` | famille de travaux seule | `ℕ∞^ℒ` | contredit P3 (la profondeur disparaît du type) et `Vmap`, `Par` |
| `B'` | travail par niveau, profondeur globale | `ℕ∞^ℒ × ℕ∞` | profondeur aveugle aux niveaux : une profondeur de branche secrète fuit par la profondeur |
| `C` | couple sans niveau | `ℕ∞ × ℕ∞` | abandonne la famille ; ruine la clause de couplage de `Case`, `thm:temps_mononiveau`, `eq:traduction-fils`, `π^♭_ℓ` |
| `D` | couple d'un événement **concentré au niveau courant** (la lecture que `ANOMALIES.md` mentionne) | `(ℕ∞ × ℕ∞)^ℒ`, événements atomiques concentrés | cohérent pour les événements atomiques ; **insuffisant pour `spawn`, `vmap`, `∥`** (§4.4) |
| `A+D` | `A`, avec la convention `D` **réservée aux événements atomiques** (`tick`, `send`, `move`, opérations) : leur niveau `ℓ̂` est un paramètre de la règle, couplé par `niv(Δ) ⊑ ℓ̂` ; les événements agrégés (`spawn`, `vmap`, `∥`) sont des familles | `(ℕ∞ × ℕ∞)^ℒ` | **recommandée** |

## 4. Pour chaque option : ce qu'elle impose, casse, coûte

### 4.1 `A` et `A+D`

* **Impose** (liste exhaustive des endroits à relire, §7 pour le texte) :
  1. définir `w, s : ℰ → ℕ∞^ℒ` (les deux projections) et le couple `⟨a, b⟩ : k ↦ ⟨a(k), b(k)⟩` ;
  2. `Tick` : `⟨𝟏, δ_ℓ̂⟨1,1⟩⟩` (un pas de travail, un de profondeur, au niveau `ℓ̂`) ; le scalaire `δ_ℓ̂` de `ReglesDeTypage.lean:213` n'est pas un couple ;
  3. `Send`, `Move` (et `net`) : mêmes écritures `δ_ℓ̂⟨1,1⟩`, `δ_ℓ̂⟨c,c⟩`, avec **un paramètre `ℓ̂`** et la clause `niv(Δ) ⊑ ℓ̂` comme `Op` ;
  4. `Spawn` : inchangé dans sa forme, `w(ε)` étant la famille des travaux de la fille et `0` la famille nulle ; `ℓ̂(ε_spawn) = ℓ̂(ε)` lorsque le support de `w(ε)` est celui de `κ(ε)` (vrai si `s ≤ w` composante par composante, ce que la définition de la profondeur donne) ; clause de couplage : `niv(Δ) ⊑ ℓ̂(ε)` ;
  5. `Vmap` : `⟨n·w(ε), s(ε)⟩` est un couple de familles ; son effet complet est `⟨φ, ·⟩` avec `φ` neutre sous la restriction du dossier 1 (`V6`) ;
  6. `thm:temps_mononiveau` : énoncé réécrit (`ℰ₀ × (ℕ∞ × ℕ∞)`), preuve inchangée ;
  7. prose : GrammaireDesTypes 126 (`ℕ∞^ℒ` → `(ℕ∞×ℕ∞)^ℒ`), LeSystemeDeSortes 107-108 et 299 (idem), ch.1 478-485 (une phrase) ;
  8. budget (F7) : décider `k`.
* **Théorèmes et sceaux touchés** : `thm:temps_mononiveau` (énoncé, théorème) ; `thm:action_parallele` (aucun changement : la preuve est « sur les deux composantes temporelles », vraie point par point) ; `thm:chaine_fils` (proposition : la prose « famille `ℕ∞^ℒ` » se relit) ; règles `Tick`, `Send`, `Move`, `Spawn`, `Vmap` (notation).
* **Grades.** Le grade `⟨u, m, ℓ, β⟩` n'est pas touché ; `φ_r` (mise à l'échelle) agit point par point (`thm:action_parallele`). `ψ(Δ, ε)` exige de dire comment `κ` agit sur `β` (point 8).
* **Niveaux.** `ℓ̂` est défini pour tout effet (support de `κ`, ou `⊤` si `κ = 0`). La clause de couplage s'étend de `Case`/`Op` à `Spawn`/`Send`/`Move` : **la fermeture du canal temporel par règle devient complète** (constat 2 du §2.1).
* **Sortes et traduction.** Le fil enfilé par niveau est inchangé ; la clause de `spawn` se projette sur `lev(ε)` (dossier 2, §2.2 point 2) ; `∥` et `vmap` aussi (jonction sur `lev(ε₁) ∪ lev(ε₂)`).
* **Simulation, préservation.** L'ordre est point par point ; la préservation `τ'·ε' ⊑ τ·ε` se lit par niveau ; aucun cas nouveau.
* **Non-interférence.** `π^♭_ℓ` (restriction aux niveaux `k ⊑ ℓ`) s'applique aux deux composantes sans modification.
* **Coût** : `S` pour chacun des points 1 à 7 (énoncés ou notations) ; `M` pour le point 8 si l'on veut une définition propre du budget ; **aucune preuve neuve** hors le point 6 (une phrase).
* **Exemple.** `ε_spawn` pour une fille qui fait un `tick` au niveau `H` et un au niveau `⊥` : `w(ε) = δ_H·1 + δ_⊥·1`, `ε_spawn = ⟨spawn, (δ_H + δ_⊥)·⟨1,0⟩⟩`, `ℓ̂ = ⊥ ⊓ H = ⊥` ; sous `Case` sur un secret de niveau `H`, la clause `H ⊑ ⊥` **échoue** : le `spawn` est refusé, ce qui est la protection voulue.

### 4.2 `B` et `B'`

* `B` supprime la profondeur du type : `Vmap` (`s(ε)`), `Par` (`max`), P3 (« les deux composantes ») et `thm:action_parallele` (deux composantes) tombent. Écartée.
* `B'` garde la profondeur mais la rend aveugle aux niveaux : une branche à profondeur secrète (ex. une boucle bornée par un secret exécutée à un niveau haut) fait varier la profondeur globale que lit un observateur de niveau bas. **Fuite temporelle par la profondeur** ; la non-interférence temporelle (`π^♭_ℓ`) cesse de pouvoir porter sur les deux composantes. Écartée.

### 4.3 `C`

Abandonne la famille : la clause de couplage `niv(Δ) ⊑ ℓ̂(ε)` n'a plus d'objet (`ℓ̂` n'est plus défini), `eq:traduction-fils` n'a plus de `t_k`, `thm:temps_mononiveau` est vide. Cela contredit le chapitre 1 (« compte chaque événement au niveau qui l'a produit »). Écartée.

### 4.4 `D` seule

La lecture « couple d'un événement concentré au niveau courant » est celle que `ANOMALIES.md` propose en note. Elle est exacte pour un **événement atomique** (`tick`, `send`, `move`, opération) : son niveau est le paramètre `ℓ̂` de la règle. Elle est **fausse pour un événement agrégé** :

* `spawn` : l'événement porte `w(ε)`, **le travail de toute la fille**. Concentré en un niveau `ℓs` (le niveau « courant » de la mère), il comptabilise à `ℓs` un travail que la fille fera à d'autres niveaux. La préservation `τ'·ε' ⊑ τ·ε` est un ordre **point par point** : un tick de la fille au niveau `k ≠ ℓs` ne serait couvert ni par la provision (à `ℓs`), ni, après le pas, par `ε` (déjà décompté). La préservation tombe pour toute fille multiniveau. Sous `A`, la provision est répartie comme le travail de la fille ; la préservation tient niveau par niveau.
* `vmap` et `∥` : leurs effets sont des familles par construction (somme ou maximum point par point) ; les concentrer en un niveau les rendrait faux dès que deux branches travaillent à deux niveaux.
* « Niveau courant » n'est pas défini : `ReglesDeTypage.lean:248` dit que « le niveau courant du processus est celui que porte son effet », or l'effet de `spawn` n'en porte pas encore. La définition est circulaire.

## 5. Sous-questions, à trancher avec `A+D`

* **`Q1`, le budget (F7).** `ψ(Δ, ε)` agit sur `β ∈ ℕ∞` par `β ⊖ k`. Avec `κ ∈ (ℕ∞×ℕ∞)^ℒ`, trois lectures de `k` : (i) **totale** : `k = (Σ_k w_k(ε), Σ_k s_k(ε))`, le budget étant un couple ; (ii) **par niveau** : le grade porte son niveau `ℓ` et `k = κ(ℓ)` (le budget d'une liaison de niveau `ℓ` ne décroît que des événements de niveau `ℓ`) ; (iii) **travail seul**, profondeur à part. La lecture (i) est la plus sûre (une borne supérieure) et reprend « le budget … est un couple » du chapitre 2. Elle surestime la profondeur : la profondeur réelle d'un chemin qui change de niveau est au plus `Σ_k s_k`, non exacte. **À écrire explicitement.**
* **`Q2`, la profondeur est-elle par niveau exacte ?** Sous `A`, `s_k` est la plus longue chaîne **d'événements de niveau `k`** ; la séquence additionne, `∥` prend le maximum point par point. La plus longue chaîne globale vaut au plus `Σ_k s_k` et au moins `max_k s_k`. P3 parle du « plus long chemin de dépendances » : sous `A`, c'est un **majorant** par niveau, et il faut le dire (une phrase), sauf à définir la profondeur globale comme `max` ou `Σ` par convention.

## 6. Recommandation argumentée

1. **`A+D`.** C'est la lecture qui (i) est celle de `eq:grammaire-types` et de `Par`/`Vmap` (aucun de leurs schémas ne change) ; (ii) donne un support à `κ`, donc un `ℓ̂(ε_spawn)` (`= ℓ̂(ε)` de la fille), sans niveau arbitraire ; (iii) étend la clause de couplage à `Spawn`, `Send`, `Move` (la fermeture du canal temporel par règle devient complète) ; (iv) ne coûte qu'un énoncé scellé réécrit (`thm:temps_mononiveau`, preuve intacte) ; (v) est la seule des options qui tient P3 sans fuite temporelle par la profondeur.
2. **Réserver la convention « concentré au niveau courant » aux événements atomiques**, avec `ℓ̂` paramètre de la règle (comme `Tick`). Écrire pour `spawn`, `vmap`, `∥` le couple de familles, non un couple concentré.
3. **Lever `Q1` en faveur de (i)** (budget en couple, décrément total) et `Q2` en écrivant la profondeur par niveau comme majorant ; ce sont deux phrases, non des preuves.
4. **Ordre.** `ANOM-18` est la **condition** de `O1b` (dossier 2) et de `V3` (dossier 1) ; elle n'est pas la condition de `V0` réparée ni de `O4a`. La décider tôt : elle est bon marché et elle ferme le trou de fuite de `Case` pour `spawn`, `send`, `move`.
5. **Alternative si l'auteur préfère ne pas toucher un théorème scellé** : écrire `thm:temps_mononiveau` pour le facteur « travail » seul (`ℰ₀ × ℕ∞`) et dire que la profondeur suit la même bijection ; c'est vrai mais laisse l'énoncé en deçà de la forme complète.

## 7. Formulations prêtes à écrire (non appliquées)

### 7.1 Définition des projections et des couples (ch. 3, `GrammaireDesTypes.lean`, en remplacement des lignes 121-129)

```
Le quatrième porte sur le facteur temporel de l'effet, et il rectifie ce que ce texte écrivait.
Le chapitre 1 (§{num "sec:c1-axiomatique-germinale"}[]) pose que le niveau _étiquette_ l'effet, et
sur ses deux composantes ; il signale en outre que la cellule appariant le niveau et le temps est
celle qui rend le canal temporel énonçable. Un facteur temporel réduit à un $`\mathbb{N}_\infty` nu
ne peut pas porter cela : il compte des pas sans dire à quel niveau ils ont été faits. C'est donc
une _famille_ de couples $`\kappa \in (\mathbb{N}_\infty \times \mathbb{N}_\infty)^{\mathcal{L}}`,
$`\kappa(k) = \langle w_k, s_k \rangle` étant le _travail_ et la _profondeur_ des événements de niveau
$`k`. On note $`w(\varepsilon), s(\varepsilon) \in \mathbb{N}_\infty^{\mathcal{L}}` les deux projections de
$`\kappa`, et $`\langle a, b \rangle` la famille $`k \mapsto \langle a(k), b(k) \rangle` ; $`\delta_k\langle a, b \rangle`
est la famille qui vaut $`\langle a, b \rangle` en $`k` et $`\langle 0, 0 \rangle` ailleurs. Un
$`\mathbf{tick}`, un envoi, un déplacement sont des événements _atomiques_ : ils sont comptés à un niveau
$`\hat\ell` qui est un paramètre de leur règle. La mise en parallèle, l'application vectorisée et
l'engendrement d'une tâche sont des événements _agrégés_ : leur effet est la famille que donnent les
formules du §{num "sec:g-parallelisme"}[], niveau par niveau. L'ordre reste celui du produit, point par point ;
le séquencement additionne les familles composante par composante ; l'unité est la famille nulle ; et
l'itération $`\varphi_n` multiplie chaque composante par $`n`. La profondeur $`s_k` est la plus longue
chaîne d'événements de niveau $`k` ; la plus longue chaîne tous niveaux confondus est majorée par
$`\sum_k s_k`, et cette somme est la profondeur que les budgets décomptent.
```

### 7.2 `thm:temps_mononiveau` (énoncé réécrit ; la preuve est la même, appliquée à des couples)

```
Si tous les $`\mathbf{tick}` d'un calcul sont produits à un même niveau $`\ell`, la famille
$`\kappa` est concentrée en $`\ell`, et la restriction de $`\mathcal{E}` aux tels effets est
isomorphe, comme quantale ordonnée, à $`\mathcal{E}_0 \times (\mathbb{N}_\infty \times \mathbb{N}_\infty)`.
```

Preuve : « L'application `κ ↦ κ(ℓ)` est une bijection entre les familles concentrées en `ℓ` et `ℕ∞ × ℕ∞`, d'inverse `⟨a,b⟩ ↦ δ_ℓ⟨a,b⟩`. Elle préserve l'addition et l'ordre, définis point par point […] » (le reste est inchangé).

### 7.3 Règles `Tick`, `Send`, `Move`, `Spawn` (notation et couplage)

```
\textsc{Tick}\;\frac{\;}{\;\mathbf{0} \vdash \mathbf{tick} : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathbf{1}, \delta_{\hat\ell}\langle 1, 1\rangle\rangle\;}
\qquad
\textsc{Send}\;\frac{\;\Delta_1 \vdash v :_r \mathsf{Mb}\;E \quad \Delta_2 \vdash \overline{v} : \overline{V} \quad m[\overline{V}] \sqsubseteq E \quad \mathrm{niv}(\Delta_1 + \Delta_2) \sqsubseteq \hat\ell\;}{\;\Delta_1 + \Delta_2 \vdash \mathsf{send}\;m(\overline{v})\;\mathsf{to}\;v : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathsf{send}_m,\ \delta_{\hat\ell}\langle 1, 1 \rangle \rangle\;}
```

```
\textsc{Spawn}\;\frac{\;\Delta \vdash c : F_{\mathbf{1}} \mathbf{1} \mid \varepsilon \qquad \mathrm{niv}(\Delta) \sqsubseteq \hat\ell(\varepsilon)\;}{\;\Delta \vdash \mathsf{spawn}\;c : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathsf{spawn},\ \langle w(\varepsilon),\ 0 \rangle \rangle\;}
```

(`Move` : `⟨net_{n,m}, δ_ℓ̂⟨c, c⟩⟩` avec `niv(Δ) ⊑ ℓ̂`.) Texte d'accompagnement :

```
Le niveau de production $`\hat\ell` d'un envoi ou d'un déplacement est choisi comme celui d'un
$`\mathbf{tick}`, et la même clause de couplage le borne : on n'émet que d'un niveau au moins égal à
celui de ce qu'on lit. Pour $`\mathsf{spawn}`, l'effet annoncé est le travail de la fille, famille
$`w(\varepsilon)` : son niveau de production est celui de la fille, et la clause rejette un
$`\mathsf{case}` sur un secret dont une branche engendrerait une tâche qui produirait en deçà.
```

### 7.4 Ch. 1, une phrase (`AxiomatiqueGerminale.lean:481-485`)

Remplacer « est une _famille_ de coûts temporels indexée par les niveaux » par « est une _famille de couples_ travail et profondeur indexée par les niveaux » et renvoyer à `thm:temps_mononiveau`.

## 8. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| `A+D` | `ℓ̂(ε_spawn)`, la clause de couplage de `Spawn`, `Send`, `Move` (canal temporel fermé par règle partout) ; `lev(ε)` pour `O1b` (dossier 2) ; la jonction par niveaux de `∥` pour `V3` (dossier 1) ; la clause de traduction d'un événement agrégé ; la relecture de `thm:correspondance_niveaux` sur la couche 2 ; le décrément de budget `ψ` |
| `thm:temps_mononiveau` réécrit | cohérence ch. 1, ch. 3, ch. 4 sur la forme du facteur |
| reste fermé tant que `ANOM-18` ouverte | `O1b`, `V3`, la clause de couplage des événements de couche 2 |

## 9. Ce qui reste ouvert après la décision

`Q1` et `Q2` (§5) si l'auteur ne retient pas les lectures proposées ; la preuve de `thm:correspondance_niveaux` sur la couche 2 (non conduite) ; une vérification par machine de la structure de quantale sur `ℰ₀ × (ℕ∞ × ℕ∞)^ℒ` (aucune n'existe dans le dépôt).

## 10. Niveau de vérification

* **Manuscrit** : lignes lues, labels contrôlés.
* **Constats 2 et 3 du §2.1** : lectures de rédacteur des règles et de l'énoncé ; non vérifiées par machine.
* **Sources externes** : aucune relue. Le produit de quantales `ℰ₀ × ℕ∞` est attribué dans le manuscrit à `mannucciResourceBoundedTypeTheory2025` (notice seule) ; je ne vérifie pas que cette source porte une famille indexée par des niveaux.
* **Coûts** : estimations.

Renvois : [`ANOMALIES.md`](../../suivi/ANOMALIES.md) (`ANOM-18`) ; [01](01-parallele-et-vmap.md) ; [02](02-spawn-et-fil-de-temps.md) ; [05, sceaux](05-sceaux-progres-preservation.md).
