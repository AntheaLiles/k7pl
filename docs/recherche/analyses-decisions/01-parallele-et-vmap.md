<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 1 : `∥` et `vmap`, la lecture qui fait foi

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Ce dossier **synthétise et prolonge** l'étude [`etude-parallele-fourche-entrelacement`](../etude-parallele-fourche-entrelacement.md) (variantes `V0` à `V5`) ; il ne la recopie pas, il y renvoie par ses paragraphes (§ de l'étude) et ajoute ce qu'elle ne disait pas.

**Statut.** Aucune décision n'est prise ici et `spec/` n'est pas modifié. Les textes Verso du §7 et du §8 sont **non appliqués**. Les faits sur le manuscrit sont lus dans les fichiers cités (fichier, ligne ou label) ; les coûts `S`, `M`, `L` sont des estimations de rédacteur ; les clauses de traduction sont des esquisses non vérifiées par machine. Niveau de vérification des sources externes : voir le §10.

## 1. Question exacte

> Quelle est la **lecture qui fait foi** de `c₁ ∥ c₂` et de `vmap v w` : (i) une **fourche suivie d'une jointure** à grand pas (`V0`, appliquée, à ratifier), (ii) la même règle mais avec une **trace structurée** qui garde les événements des branches (`V3`), ou (iii) un **entrelacement** des branches en fibrilles avec une trace par branche (`V2`) ? Et, quelle que soit la réponse, quelle **réparation** de `V0` faut-il écrire pour les trous que le texte laisse ouverts ?

Ce n'est pas un choix entre deux idées sur un texte univoque : le texte dit aujourd'hui les deux (§2.2). Trancher, c'est donc d'abord **écrire un paragraphe de lecture** (§7).

## 2. État actuel du manuscrit

### 2.1 Faits lus (fichier, ligne)

| Fait | Où (lu) |
|---|---|
| Règles `Par` et `Vmap` : `Δ₁ + Δ₂ ⊢ c₁ ∥ c₂ : F_{ε₁∥ε₂}(V₁ ⊗ V₂) \| ε₁ ∥ ε₂` ; `Δ₁ + n·Δ₂ ⊢ vmap v w : F(Vec n W) \| ⟨n·w(ε), s(ε)⟩`. **Aucune condition de couche** | `spec/Spec/C3/ReglesDeTypage.lean:1308-1325`, label `eq:regles-parallele` |
| Coût : `⟨w₁,s₁⟩·⟨w₂,s₂⟩ = ⟨w₁+w₂, s₁+s₂⟩` ; `⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁+w₂, max(s₁,s₂)⟩` ; `(ℰ₀, ∥, 1)` « commutatif » ; loi d'échange `(a·b) ∥ (c·d) ⊑ (a∥c)·(b∥d)` « entrelacer ne coûte jamais plus que séquencer par tranches » | même fichier, 1286-1305, label `eq:cout-parallele` |
| La section s'intitule « Le parallélisme de couche 3 » | même fichier, 1273 (`sec:g-parallelisme`) |
| `thm:determinisme_parallele` (théorème) : « Pour `c₁` et `c₂` de couche 3 » mêmes valeurs ; effets différents sur la seule profondeur, « où le second majore le premier » ; esquisse : « l'entrelacement ne distingue aucun état » | même fichier, 1343-1365 |
| Fourche-jointure : prémisse `⟨cᵢ \| μ \| ∅⟩ →* ⟨return vᵢ \| μᵢ \| τᵢ⟩`, conclusion `τ·(π(τ₁) ∥ π(τ₂))` et `μ₁ ⊎ μ₂` ; `vmap` sur `n` branches `(force v) wᵢ` | `spec/Spec/C4/SemantiqueOperationnelle.lean:230-250`, label `eq:reductions-orientees` |
| « Les écritures μ₁ et μ₂ ont des supports disjoints, ce que l'addition des contextes de `Par` garantit par la linéarité des capacités d'écriture » (prose, pas de lemme) | même fichier, 252-254 |
| « Cette orientation n'est pas la plus fidèle pour la mise en parallèle : l'entrelacement avec une trace par branche, ordre partiel dès la couche 3, la prolongerait, et c'est elle que la fourche et la jointure préparent » | même fichier, 260-262 |
| La relation est « déterministe sur la couche 3 », « ce dont dépend le rejeu de P4 » ; elle « se relève aux configurations concurrentes … sans que le déterminisme de la couche 3 soit perdu » | même fichier, 357-364 |
| Préservation, cas `∥` : « la monotonie de `∥` — que ce document n'énonce pas — donne … » ; les cas fourche-jointure « ne sont pas démontrés en détail » ; typage des configurations non écrit | même fichier, 373 (énoncé), 446-455 (cas) |
| Progrès : forme globale sur le pool ; « l'induction ne porte que sur les formes que les blocs … réduisent » ; aucun cas conduit en détail pour les formules orientées | même fichier, 477-515 |
| Couche 3 : « `Δ` se réduit à sa partie `Δ_ω` … `ℰ` y est vide. Aucun `tick` n'y est même compté, le temps d'un calcul pur relevant de son appel et non de lui » | `spec/Spec/C1/AxiomatiqueGerminale.lean:824-826`, label `eq:instance-L3` (829) |
| « La couche 3 pose `ℰ = ∅` … n'admet aucune opération à portée » | `spec/Spec/C3/ReglesDeTypage.lean:874-877` |
| `thm:surete_spatiale` : « deux membres du multi-ensemble de calculs, composés par la règle `Par` … sous des contextes additionnés », avec capacités d'écriture **linéaires** | `spec/Spec/C4/ModelesDeMemoire.lean:41-52` |
| P4 : couche 3 « déterministe *par construction* : le fragment est cartésien et sans effet, deux branches parallèles n'ont aucun endroit où interférer » ; couche 2 « modulo le journal : l'entrelacement des acteurs est journalisé » | `spec/Spec/C1/Postulats.lean:168-173` |
| « Le parallélisme étant déterministe quand la couche 2 porte l'entrelacement » (axe de la concurrence, la couche 3 est la plus pauvre) | `spec/Spec/C1/GuideDeLecture.lean:156-157` |
| `thm:determinisme_observationnel` (conjecture) : « deux entrelacements d'un même ensemble de calculs » ont la même projection sous `𝒟_𝒮` | `spec/Spec/C2/SystemeDeRaffinement.lean:188-202` |
| `thm:action_parallele` : `φ_r(ε₁ ∥ ε₂) = φ_r(ε₁) ∥ φ_r(ε₂)`, preuve sur les deux composantes temporelles seulement | `spec/Spec/C2/ComonadeExponentielleEtFragments.lean:186-205` |
| Loc : `⟨c\|μ\|∅⟩ → ⟨c'\|μ'\|τ₀⟩` donne `τ ◁_p τ₀` (relève un pas de couche 3 à la configuration concurrente) | `spec/Spec/C4/SemantiqueOperationnelle.lean:196-203`, `eq:reductions-couche2` |
| `thm:terminaison_couche_3` : un pli dépendamment typé atteint une forme normale ; énoncé conditionnel (« s'il tient ») | `spec/Spec/C2/AlgebresCoalgebresEtPointsFixes.lean:132-164` |

### 2.2 La carte des ambivalences, complétée

L'étude (§2, « carte des ambivalences ») en relevait trois lectures. Trois constats **nouveaux** s'y ajoutent, lus aux endroits ci-dessus :

1. **Trois endroits ne disent pas la même chose du temps en couche 3.** Le chapitre 1 écrit que `ℰ` est vide et qu'aucun `tick` n'y est compté (`AxiomatiqueGerminale.lean:824-826`) ; la section du parallélisme écrit que la couche 3 « a pour seul effet le coût » et que `c₁ ∥ c₂` et la séquence « diffèrent sur la seule composante de profondeur » (`ReglesDeTypage.lean:1358-1359`) ; l'exemple `E1` de l'étude (`vmap f [a,b,c]` avec `f = tick`) suppose des `tick` dans le parallèle. Si la couche 3 stricte ne compte aucun pas, `ε₁ ∥ ε₂` y vaut `∅ ∥ ∅` et la différence de profondeur est **vide** : elle n'apparaît que lorsqu'un appelant de couche 2 ou 1 compte les pas d'un sous-calcul pur. Le texte dit donc « couche 3 » pour deux fragments distincts : la couche 3 stricte (`ℰ = ∅`, `κ` absent) et le **fragment sans opération de `ℰ₀`, mais avec facteur temporel** (« cartésien chronométré »).
2. **`thm:surete_spatiale` emploie `Par` avec des capacités d'écriture linéaires** (`ModelesDeMemoire.lean:41-56`), alors que `Par` est présentée comme la règle de la couche 3, dont les liaisons sont toutes de grade `ω` (`AxiomatiqueGerminale.lean:824`) et qui n'a aucune opération. Il y a donc au moins **deux emplois de `Par`** : le parallélisme pur de la section de couche 3, et la composition de contextes d'un multi-ensemble de calculs à capacités linéaires (couche 2 ou 1).
3. **Le progrès de `∥` exige la terminaison des branches.** La prémisse de la fourche-jointure demande `⟨cᵢ|μ|∅⟩ →* ⟨return vᵢ|μᵢ|τᵢ⟩`. Une branche qui ne rend pas la main (divergence, ou blocage sur une règle globale) rend `c₁ ∥ c₂` **sans pas** alors qu'il n'est pas terminal : le progrès tombe, même si la branche, elle, avance. Pour la couche 3, c'est `thm:terminaison_couche_3` qui doit le garantir, or il est énoncé sur `⇝^k` de plis (non sur `→`) et sous un « s'il tient ». Ce point est **absent de l'étude** (qui ne relève que le blocage sur règle globale, trou 2).

### 2.3 Les quatre trous de `V0`, relus

Les quatre trous de l'étude (§4) sont confirmés par les lectures ci-dessus. Pour chacun : le constat, la **réparation rédigée** (au §7), et ce que le constat 2.2 y change.

| # | Trou | Constat relu | Réparation (§7) |
|---|---|---|---|
| T1 | `∥` n'est défini sur `ℰ₀` nulle part | `grep` : `∥` n'est défini que sur le couple temporel (1286) ; `ε ∈ ℰ₀ × (ℕ∞×ℕ∞)^ℒ` (`GrammaireDesTypes.lean:46`) ; `(ℰ₀, ∥, 1)` « commutatif » est affirmé sans opération | `R1` (restreindre) ou `R1'` (définir) |
| T2 | schéma sur les triplets, `Par` sans condition de couche | `Loc` ne relève que les pas qui réussissent depuis `⟨c\|μ\|∅⟩` ; une branche avec `send`, `guard` ou `spawn` est bloquée dans la prémisse (ces schémas sont globaux : `eq:reductions-couche2`) | `R2` (condition de `Par`) |
| T3 | `μ₁ ⊎ μ₂` sans lemme de support | prose seule (252-254). **Si `φ = 1` (aucune opération de `ℰ₀`), `μᵢ = μ` et le trou disparaît** : l'arène n'est jamais écrite | `R3` (lemme, ou suppression de `⊎`) |
| T4 | monotonie de `∥` non énoncée | l'esquisse de `thm:preservation` l'avoue (450) ; immédiate sur les couples | `R4` |
| T5 (nouveau) | progrès : les branches doivent terminer | constat 3 du §2.2 | `R5` |

## 3. Options exhaustives

Les variantes de l'étude, reprises avec leur sort ; ajouts signalés.

| | Variante | Sort proposé |
|---|---|---|
| `V0` | fourche-jointure à grand pas, trace agrégée (appliquée) | **garder, réparée** |
| `V1` | déplier en séquence | écartée (préservation fausse sur la profondeur : `ε₁·ε₂ ⋢ ε₁∥ε₂`) |
| `V2a` | entrelacement libre, lemme du diamant | plus tard, sous conditions (§6) |
| `V2b` | entrelacement à politique déterministe | idem (elle cache le diamant) |
| `V3` | fourche-jointure à trace structurée (posets série-parallèles) | **cible à décider après la question préalable `Q0`** |
| `V4` | `∥` comme sucre de `spawn` + boîte + garde | écartée (surcoût chiffré à l'étude, §5.5 et exemple `E3`) |
| `V5` | sémantique de coût séparée | écartée (contredit « un seul objet », `sec:g-semantique`) |
| `V6` (ajout) | `V0` **restreinte au parallélisme pur** : `Par` et `Vmap` exigent un effet de la forme `⟨1, κ⟩` ; `∥` sur `ℰ₀` n'est pas défini car jamais appliqué | option de **réparation**, compatible avec `V0`, `V3` |
| `V7` (ajout) | `V0` **généralisée** : `∥` défini sur `ℰ₀` (mélange commutatif des mots d'opérations), schéma relevé aux quadruplets | option de réparation, préalable à `V2` |

`V6` et `V7` ne sont pas des variantes de sémantique mais deux **réparations** de `V0` (trous T1 à T3) ; elles se croisent avec `V0`, `V3`, `V2`.

## 4. Pour chaque option : ce qu'elle impose et ce qu'elle casse

La grille `F1` à `F10` est celle de l'étude (§3) ; je ne la redonne pas, je renvoie aux tableaux de l'étude (§5 et §9) pour `V0`, `V1`, `V2`, `V3`. Ce qui suit est ce que **ce dossier ajoute** : les interactions avec les énoncés scellés, les grades, les niveaux et les sortes.

### 4.1 `V0` réparée (`V6` ou `V7`)

* **Théorèmes et sceaux touchés.** `thm:determinisme_parallele` (théorème) : son énoncé reste vrai ; son **esquisse** change (elle parle d'entrelacement ; sous `V0` l'égalité des valeurs vient de la prémisse, §7.4). `thm:preservation` (théorème, mais voir le dossier 5) : cas `∥` et `vmap` à conduire, `S` si la monotonie est énoncée. `thm:progres` : cas `∥` à conduire, avec `R5`. `thm:surete_spatiale` : **à relire** si `V6` (voir `R1`). `thm:action_parallele` : inchangé.
* **Grades.** `Δ₁ + Δ₂` somme les grades : en couche 3 stricte tout est `ω`, la somme est neutre ; pour des capacités linéaires la somme porte la disjonction (`thm:surete_spatiale`). `Vmap` multiplie `Δ₂` par `n`.
* **Niveaux.** `V0` n'expose qu'un événement agrégé : `P_trace(ℓ)` y est grossière à l'intérieur d'une branche (étude §7). Aucune fuite créée : les événements d'une branche sont de niveau `⊒ niv(Δ)` (`thm:correspondance_niveaux`, proposition, induction non conduite sur la couche 2).
* **Sortes et traduction.** Bifurcation et jointure de chaînes, aucune capacité nouvelle (étude §5.1). La simulation se lit modulo `π`, sous forme existentielle (`π(J') = τ'`).
* **Simulation.** `thm:simulation` est une proposition bornée au fragment sans `∥` : rien n'est cassé, et rien n'est acquis. Le cas `∥` est un `→⁺` (la jonction est une communication).
* **Préservation graduée (`ARB-PR-06`).** La partie « usage » se ramène au lemme de support (T3) : avec `V6`, au lemme trivial `μ' = μ`.
* **Non-interférence.** La clause de calcul de la relation logique est à grands pas (`⇓`, `eq:relation-logique`) : elle s'accorde à `V0` sans travail.
* **Exemples.** `E1` de l'étude : `V0` donne `τ·⟨3,1⟩`. **Contre-exemple de T2** : `c₁ = send ping() to ι`, `c₂ = tick` : sous `V6` ce terme n'est pas typable avec `Par` (effet non neutre), c'est le comportement voulu ; sous `V0` non réparée, il est bien typé et bloqué.

### 4.2 `V3`

* **Ce qu'elle impose en plus** : une algèbre de posets série-parallèles et le morphisme `π : SP → ℰ` (étude §5.4). **Sceaux** : aucun énoncé modifié.
* **Interaction nouvelle avec `Q0`.** Le gain de `V3` est une trace partielle « dès la couche 3 ». Or, si la couche 3 stricte a `ℰ = ∅` et ne compte aucun pas (`AxiomatiqueGerminale.lean:824-826`), la trace d'un `∥` de couche 3 stricte est **vide** : `V3` ne gagne rien là. Elle ne gagne que sur le « cartésien chronométré » ou lorsque des branches portent des événements `tick` comptés par un appelant. **`V3` n'a donc d'intérêt que si le texte fixe que le parallélisme chronométré existe** (réponse `Q0-b` du §5).
* **Coût de preuve** : `V0` plus `M` (étude §5.4) ; je n'ai pas de raison de le réviser.

### 4.3 `V2` (a et b)

* **Impose** : typage des configurations avec `join`, préservation par chaîne (non écrits pour la couche 2), diamant, `⇓` concurrente. Coût `L`, surtout de la dette de la couche 2 avancée.
* **Casse** : « déterministe sur la couche 3 » (`SemantiqueOperationnelle.lean:358`) cesse d'être une propriété de la relation (`V2a`) ; P4 « aucun endroit où interférer » devient un théorème de confluence.
* **Gagne** : `∥` sur des branches de couche 2 (exemple `E2` de l'étude), une seule notion de trace, `P3` (« plus long chemin de dépendances ») démontrable.
* **Interaction avec le constat 3 du §2.2.** Sous `V2` le progrès de `∥` ne demande plus la terminaison des branches (les pas sont petits). C'est un avantage réel de `V2` que l'étude ne chiffre pas.

## 5. Question préalable `Q0`

Avant de choisir `V3`, l'auteur doit trancher ce que « couche 3 » veut dire dans `sec:g-parallelisme` :

* **`Q0-a`** : le parallélisme de couche 3 est **purement sémantique** (même valeur, aucun coût compté) : la profondeur et le travail ne se lisent que lorsqu'un appelant les compte. Alors `V3` est sans objet, `V0` réparée suffit, et la phrase « leurs effets diffèrent sur la profondeur » de `thm:determinisme_parallele` se reformule « sous un appelant qui compte les pas ».
* **`Q0-b`** : il existe un **fragment cartésien chronométré** (pas d'opération de `ℰ₀`, mais `tick` et facteur temporel) : c'est ce que `sec:g-parallelisme`, `E1` et la loi d'échange supposent. Alors `eq:instance-L3` doit le dire (une phrase) et `V3` a un sens.

La recommandation du §6 retient `Q0-b`, parce que c'est ce que **l'esquisse de `thm:determinisme_parallele`, la loi d'échange et la règle `Vmap` (profondeur indépendante de `n`) écrivent déjà** ; ces trois endroits n'ont de contenu que si un facteur temporel existe là où `∥` s'emploie. Cela dépend aussi d'`ANOM-18` (dossier 3).

## 6. Recommandation argumentée

1. **Lecture qui fait foi : fourche-jointure (`V0`) pour ce que la relation écrit, et le dire.** Les cinq passages à lecture entrelacée (P4, esquisse de `thm:determinisme_parallele`, `thm:surete_spatiale`, loi d'échange, phrase de fidélité) ne sont pas faux sous `V0` : ils énoncent que, **entre la fourche et la jointure, aucune dépendance n'existe**, de sorte que tout ordre d'exécution (recouvrement compris) rend le même résultat. C'est une assertion sur l'**absence de dépendance**, que la fourche-jointure formalise par l'exécution indépendante des deux branches. Le paragraphe de lecture du §7 le dit en une fois et supprime l'ambivalence sans toucher un énoncé.
2. **Réparer `V0` par `V6`, non par `V7`.** `V6` (parallélisme pur : effet `⟨1, κ⟩`) règle T1, T2 et T3 d'un seul geste (`∥` sur `ℰ₀` n'est jamais utilisé, la branche ne peut pas contenir de règle globale, l'arène n'est pas écrite) pour un coût **`S`** (étude : `M + S + M` pour les trois). Elle est **conforme à tout ce qui est écrit en couche 3** (P4, `thm:determinisme_parallele`, section « Le parallélisme de couche 3 »). Son prix : `thm:surete_spatiale` ne peut plus invoquer `Par` pour des capacités d'écriture linéaires ; il se reformule sur la **somme des contextes d'un multi-ensemble de fibrilles** (couche 2), ce qui est ce qu'il démontre (l'esquisse parle de l'addition des contextes). C'est une **modification minimale d'un énoncé scellé** : elle demande l'accord de l'auteur.
3. **`V3` : oui, si `Q0-b`, mais après** la ratification de `V0` réparée. C'est la suite naturelle de l'étude (`V0 → V3 → V2`, chaque étape raffinant la précédente par `π`). Elle donne à P3 sa définition de la profondeur (« plus long chemin ») sans toucher d'énoncé.
4. **`V2` : pas maintenant.** Elle dépend de la couche 2 non écrite (typage des configurations, préservation par chaîne) ; elle est la **bonne cible** si l'auteur veut `∥` sur des branches de couche 2. Conditions de révision : celles de l'étude (§10).
5. **Ordre de décision** : `∥` d'abord, puis `spawn` (dossier 2). Sous `V0` réparée, le choix pour `spawn` est libre ; sous `V2`, `O1b` devient quasi obligatoire.

**Ce que la recommandation ne tranche pas** : `Q0` (a ou b), et le choix entre `V6` et `V7`, qui dépend de la réponse à : « l'auteur veut-il un jour `∥` sur des branches qui écrivent l'arène ou communiquent ? » Si oui, `V7` puis `V2` ; si non, `V6` suffit.

## 7. Formulations prêtes à écrire (non appliquées)

Chaque bloc donne le **texte Verso** et l'endroit. Les étiquettes citées existent.

### 7.1 Paragraphe de lecture (après `eq:reductions-orientees`, §4.7, en remplacement de la dernière phrase du paragraphe « Les lectures sont les suivantes »)

```
Lecture de la mise en parallèle. Les schémas de $`\parallel` et de $`\mathsf{vmap}` sont une _fourche
suivie d'une jointure_ : chacune des branches s'exécute depuis la trace vide, sans rien lire de ce que
l'autre écrit, et le calcul ne reprend qu'une fois toutes les branches rendues. Les passages de ce
document qui parlent d'entrelacement, de membres d'un multi-ensemble ou d'un endroit où deux branches
interféreraient se lisent comme une seule assertion : _entre la fourche et la jointure, les branches
n'ont aucune dépendance_. Tout ordre d'exécution, leur recouvrement dans le temps compris, rend donc le
même résultat, et la relation $`\longrightarrow` n'en choisit aucun : elle les identifie. Elle
reste fonctionnelle sur ce fragment, ce que le rejeu de P4 demande. L'entrelacement avec une trace par
branche, ordre partiel dès la couche 3, n'est pas une autre lecture mais un _raffinement_ : l'événement
agrégé $`\pi(\tau_1)\parallel\pi(\tau_2)` y est remplacé par la composition parallèle des traces
$`\tau_1\parallel\tau_2`, dont il est l'image par $`\pi`, et chaque énoncé de ce chapitre s'y transporte
en le composant avec $`\pi`.
```

### 7.2 `R1` et `R2` : condition de `Par` et de `Vmap` (variante `V6`), après `eq:regles-parallele`

```
La mise en parallèle ne s'applique qu'à des calculs _purs_, c'est-à-dire dont l'effet est de la forme
$`\langle \mathbf{1}, \kappa \rangle` : leur composante d'opérations est neutre et seul leur facteur
temporel est non nul. Pour deux tels effets,
$`\langle \mathbf{1}, \kappa_1 \rangle \parallel \langle \mathbf{1}, \kappa_2 \rangle = \langle \mathbf{1}, \kappa_1 \parallel \kappa_2 \rangle`,
l'opération $`\parallel` n'étant ainsi définie que sur le facteur temporel, où elle est donnée par la
formule ({num "eq:cout-parallele"}[]). Le monoïde commutatif $`(\mathcal{E}_0, \parallel, \mathbf{1})` que
le texte annonçait est alors le monoïde trivial, et l'annonce se réduit à la commutativité de $`\parallel`
sur les couples. Une branche qui émet, reçoit ou engendre n'est donc pas typable sous {sc}[Par] : la
concurrence structurée entre calculs à effets relève de la couche 2.
```

Condition de bord dans `Par` : prémisses `ε₁ = ⟨1, κ₁⟩`, `ε₂ = ⟨1, κ₂⟩`. Corollaire à écrire dans le texte du §4.7 : « les μᵢ valent μ ; l'arène de la conclusion est μ » (la jointure `μ₁ ⊎ μ₂` devient `μ`).

### 7.3 `R3` (si `V7` : lemme de support), à l'endroit de `thm:surete_spatiale`

```
::::thm (label := "thm:support_parallele") (status := "proposition")
:::title
support d'une exécution typée
:::

:::statement +titled
Une exécution n'écrit que dans les régions de ses capacités

Si $`\Delta \vdash c : F_\varepsilon V \mid \varepsilon` et
$`\langle c \mid \mu \mid \varnothing\rangle \longrightarrow^{*} \langle c' \mid \mu' \mid \tau'\rangle`,
alors $`\mu'` et $`\mu` coïncident hors des régions $`r` pour lesquelles $`\Delta` porte
$`\mathsf{WriteCap}(r)`.
:::

:::proofsketch
Par récurrence sur la suite de pas. Seules les opérations de $`\mathcal{E}_0` modifient l'arène
(schéma des opérations, $`\llbracket \mathsf{operation} \rrbracket`), et leur typage exige la capacité
d'écriture de la région qu'elles touchent ; la sûreté spatiale
({num "thm:surete_spatiale"}[]) donne la disjonction de $`\Delta_1` et $`\Delta_2`.
:::
::::
```

(Sous `V6`, ce lemme est vide : `μ' = μ`.)

### 7.4 `R4`, `R5` et l'esquisse de `thm:determinisme_parallele`

Lemme `R4` à placer après `eq:cout-parallele` (énoncé de monotonie, preuve par composantes) :

```
Les deux opérations sont _monotones_ composante par composante : si $`a \sqsubseteq a'` et
$`b \sqsubseteq b'` alors $`a \cdot b \sqsubseteq a' \cdot b'` et $`a \parallel b \sqsubseteq a' \parallel b'`.
Pour $`\parallel` c'est la monotonie de l'addition et du maximum sur $`\mathbb{N}_\infty`. La préservation
l'emploie au cas de la mise en parallèle.
```

`R5` (progrès) : ajouter à l'énoncé de `thm:progres` ou à son esquisse, après « Deux hypothèses sont nécessaires » :

```
Une troisième hypothèse porte sur la mise en parallèle : la prémisse de sa règle demande que chaque
branche atteigne une forme terminale. Pour un calcul de couche 3 c'est la terminaison du théorème
({num "thm:terminaison_couche_3"}[]) ; elle n'est pas démontrée au sens de la relation $`\longrightarrow`,
et la transcription en assistant de preuve la portera comme hypothèse de module.
```

Esquisse de `thm:determinisme_parallele` (remplace celle de 1357-1362), sous `V0` réparée :

```
La règle de la fourche et de la jointure ({num "eq:reductions-orientees"}[]) exécute chaque branche depuis
la même arène, et les effets étant de la forme $`\langle \mathbf{1}, \kappa \rangle`, aucune ne l'écrit :
$`\mu_1 = \mu_2 = \mu`. La relation étant fonctionnelle sur ce fragment, les valeurs rendues sont celles de
l'exécution de $`c_1` puis de $`c_2` depuis $`\mu`, ce qu'est la séquence. La différence de profondeur est
celle des deux compositions : $`\max(s_1, s_2) \le s_1 + s_2`.
```

## 8. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| lecture fait foi (`V0` réparée) | écriture de `R1` à `R5` ; esquisse de `thm:determinisme_parallele` alignée ; clause de traduction de la fourche-jointure (`PREUVE-07`, `BLOQ-07`) ; clause de `∥` dans `PREUVE-03` |
| `Q0-b` + `V3` | définition de la profondeur par le plus long chemin (P3) ; simulation événement par événement ; analyse de coût parallèle citée (à instruire, §10) |
| `V2` | `∥` sur branches de couche 2 ; une seule notion de trace avec `spawn` ; dépend des dossiers 2 et 3 |
| ordre | le dossier 2 (`spawn`) se tranche après celui-ci ; le dossier 3 (`ANOM-18`) conditionne `V3` |

## 9. Ce qui reste ouvert après la décision

Les clauses de traduction (esquisses seulement) ; la préservation et le progrès des cas `∥`, `vmap` (non conduits) ; la lecture du corps de Das, Hoffmann et Pfenning avant `V3` ou `V2` ; le sort de `thm:surete_spatiale` si `V6`.

## 10. Niveau de vérification

* **Faits sur le manuscrit** : lus dans les fichiers cités, aux lignes indiquées, à la date de rédaction (6 octobre 2026) ; les labels cités existent (contrôlés par `grep`).
* **Constats nouveaux (§2.2)** : lectures de rédacteur, **non vérifiées par machine**. Le constat 1 (le temps en couche 3) repose sur trois citations lues ; le constat 3 (progrès et terminaison) sur la forme de la prémisse de `eq:reductions-orientees`.
* **Coûts `S`, `M`, `L`** : estimations non mesurées.
* **Sources externes** : les pages d'éditeurs et d'arXiv sont inaccessibles depuis la session ; **aucune source n'a été relue** pour ce dossier. Les œuvres de l'étude (Das, Hoffmann, Pfenning 2018 ; Stefan et al. 2012 ; Caires et Toninho 2026) ne sont connues que par leur notice et par ce que le manuscrit en dit.

Renvois : étude [`etude-parallele-fourche-entrelacement`](../etude-parallele-fourche-entrelacement.md) ; décisions [`DECISIONS.md`](../../suivi/DECISIONS.md) ; anomalies [`ANOMALIES.md`](../../suivi/ANOMALIES.md) (`ANOM-17`, `ANOM-18`) ; dossier voisin : [02, spawn et fil de temps](02-spawn-et-fil-de-temps.md).
