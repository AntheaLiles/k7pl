# K7PL — Programme de formalisation de la concurrence, du parallélisme et de la distribution

**Décision d'entrée :** la phrase « la couche 2 est un langage concurrent formalisé » cesse d'être une revendication et devient un théorème. Cela suppose d'écrire ce qui manque, et d'accepter ce que cela change dans ce qui existe.

**Cible arrêtée par l'auteur :**
- **couche 1** — distribuée, parallèle, concurrente ;
- **couche 2** — parallèle et concurrente ;
- **couche 3** — parallèle, avec vectorisation.

**Établi le :** 2026-09-15. Remplace la voie 1 de `BLOQ-01` (frontière noyau/cible) par la voie 2, élargie aux couches 1 et 3.

---

## 0. Le prix, énoncé d'abord

Cinq choses changent dans le manuscrit existant, dont trois sont des changements de nature et non d'échelle. Aucune n'est un obstacle ; toutes sont des coûts qu'il vaut mieux budgéter que découvrir.

1. **La trace `τ` cesse d'être une suite.** Sous concurrence, l'ordre d'occurrence des événements n'est plus total. `τ` devient un **ordre partiel étiqueté** (pomset), ou bien il faut fixer un ordonnanceur et l'inscrire dans la sémantique. Les théorèmes 43 (potentiel décroissant le long de `τ`), 46 (projection du journal) et 47 (lemme fondamental) sont réénoncés sur des pomsets. **C'est le changement le plus profond et il touche l'annexe E entière.**

2. **La non-interférence change de définition.** La non-interférence séquentielle ne survit pas à la concurrence : l'ordonnanceur entre dans le modèle d'attaquant. La notion correcte est le **déterminisme observationnel** — la projection sur un niveau ℓ doit être la même pour tous les entrelacements — ou une non-interférence possibiliste. Les théorèmes 7 et 10 changent d'énoncé, et leur preuve devient strictement plus coûteuse. **C'est le poste de dépense principal du programme.**

3. **L'algèbre des effets doit devenir un bimonoïde.** Le séquencement `·` ne suffit plus : il faut une seconde composition `∥` pour le parallélisme, avec `κ(a ∥ b) = ⟨w_a + w_b, max(s_a, s_b)⟩` là où `κ(a · b) = ⟨w_a + w_b, s_a + s_b⟩`. La quantale ℰ₀ devient une **quantale concurrente**, structure de l'algèbre de Kleene concurrente, avec sa loi d'échange. Le facteur temporel `κ ∈ ℕ∞^ℒ` devient `κ ∈ (ℕ∞ × ℕ∞)^ℒ` — travail et profondeur. Cela touche la table 2 du chapitre 1, le §2.4, et la définition du budget.

4. **Le budget `β` doit dire ce qu'il majore.** Aujourd'hui `β` est un entier. Avec travail et profondeur, il faut dire si P3 borne le travail, la profondeur, ou les deux. **Recommandation : les deux, `⊖` s'appliquant composante par composante.** Sans cela, « parallèle » redevient une affirmation d'implémentation.

5. **La distribution introduit la défaillance partielle, qui ne se type pas.** Elle se *discipline* : sessions affines avec annulation explicite, et supervision. Bonne nouvelle — c'est exactement l'extension que `BLOQ-13` réclamait déjà pour typer l'abandon de session (Timeout, disjoncteur).

**Ce que le programme ne coûte pas.** Aucune quatrième place dans le jugement. Les trois ajouts majeurs — canaux, localité, parallélisme — se rangent respectivement en **valeur graduée**, en **coeffet modal** et en **effet**. La condition de clôture du §1.4 tient, et c'est un résultat à écrire, pas une chance.

---

## 1. État exact du manuscrit, vérifié

Relevé sur `K7PL_PR.pdf` le 14 septembre 2026.

| Fait | Localisation | Conséquence |
|---|---|---|
| `V ::= b ∣ 1 ∣ V⊗V ∣ ⨁ᵢVᵢ ∣ Vec n V ∣ Arena V ∣ !ʳV ∣ U C ∣ ∃α.V ∣ μα.V` | p. 244 | **`S` n'est pas clause de `V` : aucun canal ne peut être une liaison de Δ** |
| `C ::= F_ε V ∣ V ⊸ C ∣ &ᵢCᵢ ∣ ∀α.C ∣ να.C` | p. 244 | ni `○C`, ni `□V`, ni `◇V` ; six règles concluent des types non engendrés |
| `S ::= End ∣ V⊗S ∣ V⊸S ∣ ⊕{ℓᵢ:Sᵢ} ∣ &{ℓᵢ:Sᵢ} ∣ ○S ∣ □S ∣ ◇S ∣ S` | p. 244 | production terminale vide ; huit constructeurs sans aucune règle |
| 35 constructeurs de termes, **aucune forme de communication** | p. 245 | ni émission, ni réception, ni création de canal, ni composition parallèle |
| Sémantique `→` sur `⟨c ∣ μ ∣ τ⟩`, configuration **unique** | §E.4 | pas de pool, pas d'état de canaux, `τ` est une suite |
| `ε = ⟨φ, κ⟩ ∈ ℰ₀ × ℕ∞^ℒ` | p. 244 | une seule composition, séquentielle |
| `Δ₁ + Δ₂` addition ponctuelle ; `Δ₁ ⊠_ε Δ₂` composition sous effet | p. 247 | **l'addition de contextes existe déjà — c'est le support du parallélisme** |
| `PAIR : Δ₁ + Δ₂ ⊢ (v₁,v₂) : V₁ ⊗ V₂` | p. 248 | la forme de la règle parallèle est déjà écrite, pour les valeurs |

**Lecture.** Le manuscrit possède déjà trois des quatre pièces nécessaires : le contexte gradué unique, l'addition de contextes, et l'adjonction valeurs/calculs. Ce qui manque est la quatrième — **les formes de communication et de composition parallèle**, plus la sémantique à configurations multiples. Ce n'est pas une refonte : c'est une extension, et la charpente la supporte.

---

## 2. Les six décisions de conception

À arrêter avant d'écrire une ligne. Chacune est donnée avec les options réelles et une recommandation motivée.

### D1 — Le canal est-il une valeur ?
**Options :** (a) `S` devient clause de `V` ; (b) `Chan S` comme constructeur de valeur distinct ; (c) une seconde zone de contexte.
**Recommandation : (b).** `V ::= … ∣ Chan S ∣ Mb E`. Une liaison `x :_r Chan S` porte alors sa discipline dans son **grade**, et non dans une zone séparée.
**Motif décisif :** c'est la seule option qui *réalise* ce que le §1.4 revendique déjà. La linéarité d'une session n'est pas une structure de contexte, c'est `u = 1`. L'affinité d'un canal annulable est `u ∈ [0..1]`. Le partage d'un canal de diffusion est `u = ω`. **La graduation fait le travail que la zone linéaire faisait ailleurs**, et `ARB-009` (fusion de la zone Γ) devient rétrospectivement le bon choix pour la bonne raison.
**Option (c) à écarter explicitement** avec son motif : elle défait `ARB-009` et rétablit deux zones là où le document a payé pour n'en avoir qu'une.

### D2 — Synchrone ou asynchrone ?
**État actuel :** le ch. 3 déclare l'asynchronie, le noyau ne contient que le rendez-vous synchrone de `⊸`, et le ch. 4 construit des boîtes aux lettres.
**Recommandation : asynchrone primitif, synchrone dérivé.** Les messages transitent par un état de boîtes aux lettres dans la configuration ; l'émission ne bloque pas ; la réception bloque. Le rendez-vous synchrone se dérive par émission suivie d'attente d'accusé.
**Motif :** l'inverse (synchrone primitif, asynchrone dérivé par tampons) oblige à introduire les tampons de toute façon, et rend la boîte aux lettres d'acteur inexprimable dans le noyau — ce qui est exactement la situation actuelle.

### D3 — Sessions binaires, ou boîtes aux lettres ?
Le manuscrit a besoin des deux : le ch. 3 type des protocoles binaires, le ch. 4 des acteurs à boîte aux lettres recevant de plusieurs émetteurs.
**Recommandation : les deux formateurs, une sémantique, et un théorème de plongement.** `Chan S` pour le cas binaire linéaire, `Mb E` pour le cas plusieurs-vers-un, avec l'obligation `Chan S ↪ Mb E`.
**Motif :** (cite index="112-1">le calcul à boîtes aux lettres subsume le modèle d'acteurs et permet d'analyser des réseaux à topologie dynamique mêlant différentes abstractions de concurrence ; les auteurs y encodent notamment des sessions binaires étendues par jonctions et forks</cite>. Le plongement est donc établi dans la littérature ; il reste à le transposer au contexte gradué.
**Bénéfice immédiat :** cela **résout `STRUCT-04`**. La consommation atomique multi-places d'un motif de jonction est l'opération native du type de boîte aux lettres, et non un protocole d'appariement à inventer.

### D4 — Comment se définit le graphe dont dépendent les théorèmes 17 et 24 ?
**Recommandation :** ne pas le définir à la main. (cite index="110-1">Le système de types à boîtes aux lettres suit les dépendances entre boîtes par un mécanisme de graphes de dépendance, avec des transitions étiquetées et une relation d'implication</cite>, et (cite index="106-1">les processus bien typés y sont exempts d'interblocage et n'échouent jamais sur un message inattendu</cite>.
**Conséquence :** le « graphe de câblage » de `BLOQ-13` cesse d'être un objet manquant et devient un objet **importé avec son théorème**. L'acyclicité n'est plus une hypothèse posée au ch. 3 puis non honorée : elle est la condition de typage, et l'absence d'interblocage en est le corollaire. `PREUVE-13` (lemme de simulation du graphe d'attente) est absorbé.

### D5 — Comment la localité entre-t-elle dans le jugement ?
**Options :** (a) cinquième composante de `ℛ` ; (b) modalité graduée `@` sur un demi-treillis de localisations ; (c) hors jugement, dans l'environnement.
**Recommandation : (b).** `@_n V` est une modalité comonadique graduée sur `(𝒩, ⊔)`.
**Motif décisif :** c'est la **neuvième instance** de la construction du §2.4 (« la modalité graduée sur une structure ordonnée »), donc la clôture forte tient sans révision de l'axiome. L'option (a) contredirait l'économie de `TRANS-02` et obligerait à définir une action scalaire sur les localisations, qui n'en admet pas de naturelle.
**Ancrage :** la forme est établie. (cite index="141-1">Les valeurs localisées s'écrivent `a @ l` et ne sont pas immédiatement utilisables : il faut les déballer par une fonction que seule la localisation `l` est autorisée à appliquer</cite> — c'est exactement une comonade graduée avec sa condition de bord sur l'élimination. Et (cite index="137-1">la variante à valeurs multiplement localisées permet la diffusion vers un ensemble de parties, la valeur résultante étant localisée en chacune</cite>, ce qui donne la structure de demi-treillis plutôt que d'ensemble plat.

### D6 — Que fait le parallélisme au coût ?
**Recommandation :** adopter le modèle travail/profondeur, et faire de `κ` une paire.
**Ancrage :** (cite index="128-1">calf enregistre cette structure par un monoïde de coût parallèle sur ℕ², la composition parallèle prenant la somme des travaux et le maximum des profondeurs, la source du parallélisme étant isolée dans le traitement des paires de calculs</cite>. (cite index="126-1">Le modèle usuel y est un couple travail séquentiel / profondeur parallèle</cite>.
**Motif :** sans cela, « couche 3 parallèle » reste une propriété du compilateur. Avec cela, c'est une propriété du **type**, vérifiable, et la vectorisation devient l'énoncé `span(vmap f v) = span(f)` indépendamment de `n`.

---

## 3. Le noyau formel à écrire

Écrit ici au niveau de précision où il doit figurer à l'annexe E. Les trois couches sont indépendantes et peuvent être traitées dans l'ordre indiqué.

### 3.1 Couche 3 — parallélisme déterministe et vectorisation

**C'est la pièce la plus courte, la plus sûre, et celle par laquelle commencer.**

**Algèbre.** Le facteur temporel devient `κ ∈ (ℕ∞ × ℕ∞)^ℒ`, noté `⟨w, s⟩` par niveau.

```
séquentiel :  ⟨w₁,s₁⟩ · ⟨w₂,s₂⟩ = ⟨w₁+w₂, s₁+s₂⟩
parallèle  :  ⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁+w₂, max(s₁,s₂)⟩
```

`(ℰ₀, ·, 1)` reste un monoïde non commutatif ; `(ℰ₀, ∥, 1)` est un monoïde **commutatif** ; les deux sont liés par la loi d'échange `(a·b) ∥ (c·d) ⊑ (a∥c) · (b∥d)`.

**Grammaire.** Un constructeur de calcul :

```
c ::= … ∣ c ∥ c ∣ vmap v v
```

**Règles.**

```
        Δ₁ ⊢ c₁ : F_{ε₁} V₁ ∣ ε₁        Δ₂ ⊢ c₂ : F_{ε₂} V₂ ∣ ε₂
PAR  ────────────────────────────────────────────────────────────────
        Δ₁ + Δ₂ ⊢ c₁ ∥ c₂ : F_{ε₁∥ε₂} (V₁ ⊗ V₂) ∣ ε₁ ∥ ε₂

        Δ₁ ⊢ f : U_ε (V ⊸ F_ε W)        Δ₂ ⊢ v : Vec n V
VMAP ──────────────────────────────────────────────────────────────────
        Δ₁ + (n · Δ₂) ⊢ vmap f v : F (Vec n W) ∣ ⟨n·w(ε), s(ε)⟩
```

**Trois remarques de conception.**
1. `PAR` emploie `Δ₁ + Δ₂`, exactement comme `PAIR` — **la règle existe déjà pour les valeurs, on l'étend aux calculs.**
2. `PAR` **n'est pas** `WITH`. `WITH` partage le contexte parce qu'une seule branche s'exécute ; `PAR` l'additionne parce que les deux s'exécutent. Le point mérite une remarque : c'est la différence entre `&` et `⊗`, et la confondre romprait la discipline de ressource.
3. **La profondeur de `vmap` est indépendante de `n`.** C'est la vectorisation, écrite dans le type. `VECI`/`VECE` du manuscrit gagnent leur version parallèle, et la composition `∏ᵢ` non commutative de `NOTA-05` devient `∥ᵢ`, **qui est commutative** — le défaut relevé disparaît dans le cas parallèle.

**Théorème (déterminisme du parallélisme de couche 3).** *Pour `c₁`, `c₂` de couche 3, `c₁ ∥ c₂` et `let x ← c₁ in let y ← c₂ in return (x,y)` ont la même extension, et des intensions reliées par `⟨w₁+w₂, s₁+s₂⟩ ⊒ ⟨w₁+w₂, max(s₁,s₂)⟩`.*

**Pourquoi la preuve est facile, et pourquoi c'est un vrai résultat.** La couche 3 est le fragment cartésien, sans effets autres que le coût. Deux branches parallèles ne peuvent donc pas interférer : il n'y a rien à muter, et tout est duplicable. **Le déterminisme du parallélisme de couche 3 est une conséquence du fragment, non une hypothèse supplémentaire.** C'est précisément le genre d'énoncé que le projet revendique — une propriété obtenue par la structure plutôt que par un mécanisme ajouté — et il est à portée immédiate.

### 3.2 Couche 2 — concurrence asynchrone à boîtes aux lettres

**Grammaire.**

```
V ::= … ∣ Chan S ∣ Mb E
E ::= 0 ∣ 1 ∣ m[V̄] ∣ E · E ∣ E + E ∣ E*          (motifs de boîte, commutatifs)
c ::= … ∣ spawn c ∣ new_E ∣ send m(v̄) to v ∣ guard v {mᵢ(x̄ᵢ) ↦ cᵢ}ᵢ ∣ free v
```

Les motifs `E` décrivent la configuration de messages qu'une boîte peut contenir ; `·` est la composition commutative, `+` le choix, `*` la répétition. L'opération centrale est le **résiduel** `E/m`, qui donne le motif restant après consommation d'un message étiqueté `m` — (cite index="108-1">opérateur étroitement apparenté à la dérivée de Brzozowski dans une algèbre de Kleene commutative, mais partiel</cite>.

**Règles.**

```
          Δ ⊢ c : F₁ 1 ∣ ε
SPAWN ─────────────────────────────────────────
          Δ ⊢ spawn c : F₁ 1 ∣ ⟨spawn, ⟨w(ε), 0⟩⟩

NEW   ─────────────────────────────────
          0 ⊢ new_E : F₁ (Mb E) ∣ 1

          Δ₁ ⊢ v :_r Mb E        Δ₂ ⊢ v̄ : V̄        m[V̄] ⊑ E
SEND  ──────────────────────────────────────────────────────────────
          Δ₁ + Δ₂ ⊢ send m(v̄) to v : F₁ 1 ∣ ⟨send_m, ⟨1,1⟩⟩

          Δ₀ ⊢ v :₁ Mb E    E = Σᵢ mᵢ[V̄ᵢ]·Eᵢ    Δᵢ, x̄ᵢ :₁ V̄ᵢ, y :₁ Mb Eᵢ ⊢ cᵢ : C ∣ εᵢ
GUARD ────────────────────────────────────────────────────────────────────────────────────
          Δ₀ ⊠₁ (⊔ᵢ Δᵢ) ⊢ guard v {mᵢ(x̄ᵢ) ↦ cᵢ}ᵢ : C ∣ ⊔ᵢ εᵢ

          Δ ⊢ v :₁ Mb 1
FREE  ─────────────────────────────
          Δ ⊢ free v : F₁ 1 ∣ 1
```

**Trois points de conception à noter dans le texte.**
1. `SPAWN` ajoute le travail de la tâche fille et **rien à la profondeur de la mère** : c'est le modèle fork/join, et c'est ce qui rend le coût compositionnel.
2. `GUARD` rend explicite la **continuation de motif** `y :₁ Mb Eᵢ` : consommer un message transforme le type de la boîte. C'est le typestate, et c'est ce que la couche 2 de K7PL décrit informellement au §4.5.
3. `FREE` exige `Mb 1` — une boîte vide. **C'est l'absence de déchets, et elle est typée.** Le manuscrit n'a aujourd'hui aucun énoncé correspondant.

**Sémantique.** La configuration passe de `⟨c ∣ μ ∣ τ⟩` à :

```
⟨ 𝒫 ∣ μ ∣ ℳ ∣ τ ⟩       où 𝒫 est un multi-ensemble de calculs,
                            ℳ : Loc ⇀ multi-ensemble de messages,
                            τ un ordre partiel étiqueté
```

Les règles de réduction se scindent en règles **locales** (celles du §E.4, inchangées, appliquées à un membre du pool) et **globales** (`spawn`, `send`, `guard`, `free`). La règle de congruence est la permutation du multi-ensemble.

**Obligations de preuve.** Fidélité de session, progrès global, absence d'interblocage par acyclicité du graphe de dépendance, absence de déchets. (cite index="105-1">Le système de référence est illustré par l'encodage d'objets concurrents non uniformes, de sessions binaires étendues par jonctions et forks, et de quelques jeux d'essai connus du modèle d'acteurs</cite> — les cas d'usage du ch. 7 y entrent.

**Annulation et abandon.** La couche 2 est le **fragment affine** (`ARB-003`), et l'annulation explicite de session y est donc déjà permise par le grade. L'ancrage est direct : (cite index="123-1">Exceptional GV possède un système de types affine et permet l'annulation explicite des sessions, avec fidélité de session, progrès global, absence d'interblocage et de famine, confluence et terminaison</cite>. **`BLOQ-13` point 3 — l'abandon de session pratiqué au ch. 4 et non typé — est réglé par la nature même du fragment.** C'est un argument à écrire : le Timeout et le disjoncteur ne sont pas des exceptions à la discipline, ils en sont l'usage.

### 3.3 Couche 1 — distribution, localité, défaillance

**Grammaire.**

```
V ::= … ∣ @_n V                        n ∈ 𝒩, demi-treillis de localisations
c ::= … ∣ at_n c ∣ move_{n→m} v ∣ try c catch c
```

**Règles.**

```
          Δ ⊢ c : C ∣ ε        loc(Δ) ⊒ n
AT    ───────────────────────────────────────
          @_n Δ ⊢ at_n c : @_n C ∣ @_n ε

          Δ ⊢ v : @_n V        Ser(V)        n ⊑ m
MOVE  ───────────────────────────────────────────────────────────
          Δ ⊢ move_{n→m} v : F (@_m V) ∣ ⟨net_{n,m}, ⟨c, c⟩⟩

          Δ₁ ⊢ c : C ∣ ε        Δ₂ ⊢ h : C ∣ ε'
TRY   ────────────────────────────────────────────────
          Δ₁ ⊔ Δ₂ ⊢ try c catch h : C ∣ ε ⊔ ε' ⊔ fail
```

**Le point structurel à écrire, et qui justifie tout le reste.** La distribution se décompose exactement sur les trois strates de `ARB-014` :

| Aspect de la distribution | Strate | Objet |
|---|---|---|
| *où* une valeur réside | **coeffet** | modalité graduée `@_n` sur `(𝒩, ⊔)` |
| *ce que coûte* un déplacement | **effet** | `net_{n,m}` dans ℰ₀, coût `⟨c,c⟩` |
| *ce qui est déplaçable* | **obligation de raffinement** | prédicat `Ser(V)` |

**Aucune quatrième place n'est nécessaire.** C'est la démonstration que la condition de clôture du §1.4 résiste à l'extension la plus lourde du langage, et c'est le meilleur argument que le programme puisse produire en faveur de l'architecture existante.

**Défaillance.** Elle ne se type pas ; elle se discipline en trois temps : (i) le grade affine autorise l'abandon ; (ii) `try/catch` donne la portée de récupération ; (iii) la supervision du §4.5 devient la politique. L'ancrage existe : (cite index="124-1">la première intégration formelle des types de session asynchrones et du traitement des exceptions dans un langage fonctionnel, motivée par le fait que la défaillance est omniprésente, en particulier dans les applications distribuées</cite>.

**Représentation.** Le déplacement traverse un format de transport. `E_repro` gagne donc une composante réseau, qui se range dans le profil `Π` de `IMPL-06` — aucun objet nouveau, une coordonnée de plus.

---

## 4. Les théorèmes à écrire

Quatorze énoncés nouveaux. Numérotés provisoirement `N-nn` pour ne pas préempter la renumérotation.

### 4.1 Couche 3 — cinq énoncés, tous à portée immédiate

| # | Énoncé | Difficulté | Dépend de |
|---|---|---|---|
| `N-01` | **Bimonoïde des effets.** `(ℰ₀, ·, ∥, 1, ⊑)` est une quantale concurrente : `·` associative non commutative, `∥` associative commutative, loi d'échange, distributivité sur les bornes supérieures. | moyenne | table 2 réécrite |
| `N-02` | **Déterminisme du parallélisme cartésien.** Pour `c₁, c₂` de couche 3, `c₁ ∥ c₂` et sa sérialisation ont la même extension. | **faible** | fragment cartésien, absence d'effets |
| `N-03` | **Compositionnalité travail/profondeur.** `κ(c₁ ∥ c₂) = ⟨w₁+w₂, max(s₁,s₂)⟩`, et `w` majore le coût de toute sérialisation. | faible | `N-01` |
| `N-04` | **Invariance de profondeur de la vectorisation.** `s(vmap f v) = s(f)`, indépendamment de `n`. | faible | `VMAP` |
| `N-05` | **Correction du budget parallèle.** Si `β = ⟨β_w, β_s⟩` et le jugement est dérivable, l'exécution consomme au plus `β_w` de travail et `β_s` de profondeur. | moyenne | Th. 45 étendu |

**`N-02` est le premier résultat à produire.** Il est court, il est vrai, il n'a aucune dépendance, et il transforme immédiatement « couche 3 parallèle » de revendication en théorème.

### 4.2 Couche 2 — six énoncés, le gros du travail

| # | Énoncé | Difficulté | Remplace |
|---|---|---|---|
| `N-06` | **Préservation du typage sous concurrence.** La réduction du pool préserve le jugement de chaque membre et la cohérence des motifs de boîtes. | élevée | étend Th. 43 |
| `N-07` | **Fidélité de protocole.** Tout message reçu est conforme au motif déclaré ; aucune boîte ne reçoit de message inattendu. | moyenne | nouveau |
| `N-08` | **Absence d'interblocage.** Un pool bien typé dont le graphe de dépendance est acyclique possède toujours une réduction, ou est terminé. | **importée** | **remplace le Th. 17 et acquitte `PREUVE-13`** |
| `N-09` | **Absence de déchets.** Toute boîte atteignable est libérable, c'est-à-dire de motif `1` en position terminale. | moyenne | nouveau |
| `N-10` | **Fidélité sous annulation.** L'annulation d'une session propage l'annulation à son pair ; le pool reste bien typé. | moyenne | **type le Timeout et le disjoncteur du §4.5** |
| `N-11` | **Déterminisme observationnel.** Pour tout niveau ℓ, deux entrelacements d'un même pool bien typé ont la même projection `π_ℓ(τ)`. | **la plus élevée** | **remplace Th. 10 sous concurrence** |

**`N-11` est le poste de dépense principal.** Il est la version concurrente de la non-interférence, et il n'est pas un corollaire de la version séquentielle : l'ordonnanceur devient observable, et la preuve doit quantifier sur les entrelacements. C'est la raison pour laquelle le §0 le nomme d'entrée.

### 4.3 Couche 1 — trois énoncés

| # | Énoncé | Difficulté |
|---|---|---|
| `N-12` | **Sûreté de localité.** Une valeur `@_n V` n'est éliminable que dans un calcul situé en `m ⊒ n`. Corollaire : aucun accès distant implicite. | faible |
| `N-13` | **Clôture de la distribution.** Localité, coût réseau et sérialisabilité se rangent respectivement en coeffet, effet et obligation de raffinement ; aucune quatrième composante n'est requise. | moyenne |
| `N-14` | **Progrès sous défaillance.** Un pool bien typé dont une localisation tombe atteint une configuration où chaque session pendante est annulée ou traitée. | élevée |

**`N-13` est le théorème d'architecture.** C'est lui qui justifie, rétrospectivement, la condition de clôture du chapitre 1 — et c'est le seul de la liste dont l'intérêt dépasse K7PL.

---

## 5. Ce qui casse dans l'existant

Inventaire honnête. Neuf théorèmes changent d'énoncé, trois de preuve, un devient corollaire.

| Th. | Ce qui change | Ampleur |
|---|---|---|
| **1** (loi de cohérence) | doit valoir aussi pour `∥` ; la distributivité du grade sur la composition parallèle est un cas nouveau | énoncé + preuve |
| **5** (progression) | inchangé en couche 3 ; en couche 2, la progression devient la progression du pool | énoncé |
| **7, 10** (divulgation, non-interférence) | **remplacés par `N-11`** ; l'ordonnanceur entre dans le modèle d'attaquant | **refonte** |
| **17** (absence d'interblocage) | **devient corollaire de `N-08`** ; l'hypothèse du graphe cesse d'être posée | statut |
| **20, 23** (représentation) | `E_repro` gagne une composante réseau, versée au profil `Π` | coordonnée |
| **21** (sûreté spatiale) | la disjonction des contextes doit valoir sur le pool, pas sur une dérivation ; **c'est `Δ₁ + Δ₂` qui la porte** | preuve |
| **22** (rejeu) | trois régimes à distinguer, cf. §5.1 | énoncé |
| **25** (boîte aux lettres) | **absorbé** : la consommation multi-places est l'opération native de `GUARD` | suppression |
| **43** (préservation, potentiel) | `τ` est un pomset ; le potentiel décroît le long de chaque chaîne | preuve |
| **45** (correction de ressource) | la configuration gagne un composant d'usage par membre du pool | énoncé + preuve |
| **46, 47** (projection, lemme fondamental) | réénoncés sur pomsets | preuve |
| **49** (ré-invocation bornée) | `∥ᵢ` remplace `∏ᵢ` dans le cas parallèle ; **la commutativité résout `NOTA-05`** | simplification |

### 5.1 P4 devient un énoncé à trois étages

C'est la conséquence la plus visible pour le lecteur, et elle mérite d'être écrite comme un résultat plutôt que subie comme une complication.

| Couche | Régime | Ce qui garantit le rejeu |
|---|---|---|
| **3** | déterministe **par construction** | fragment cartésien, pas d'effets — `N-02` |
| **2** | déterministe **modulo le journal** | l'entrelacement est journalisé ; `N-11` garantit que le niveau ℓ ne le voit pas |
| **1** | déterministe **modulo journal et journal de défaillances** | `N-14` |

**Le rejeu n'est donc pas une propriété uniforme du langage, mais une propriété graduée par la couche** — ce qui est précisément la thèse architecturale du manuscrit, et ce qu'il n'a pas encore les moyens de démontrer.

---

## 6. Ancrage bibliographique, pièce par pièce

Chaque pièce du programme est soit importée d'un résultat publié, soit explicitement identifiée comme contribution propre. **C'est cette table qui transforme « revendication » en « théorisé ».**

| Pièce | Ancrage | Statut |
|---|---|---|
| Boîtes aux lettres, motifs, résiduel, graphe de dépendance | de'Liguoro & Padovani, *Mailbox Types for Unordered Interactions*, ECOOP 2018 | **importé avec ses théorèmes** |
| Système algorithmique, typage quasi linéaire, vérificateur | (cite index="113-1">Fowler et al., *Special Delivery: Programming with Mailbox Types*, avec un système de types algorithmique nécessairement co-contextuel, obtenu par un usage nouveau du typage bidirectionnel arrière, prouvé correct et complet, et un vérificateur prototype</cite> | **importé, et implémentable** |
| Annulation de session, défaillance | Fowler, Lindley, Morris & Decova, *Exceptional Asynchronous Session Types*, POPL 2019 | importé |
| Coût travail/profondeur, monoïde parallèle | Niu, Sterling, Grodin & Harper, *A Cost-Aware Logical Framework*, POPL 2022, §6 | importé |
| Sémantique de profilage travail/profondeur | Blelloch & Greiner 1995, via calf | importé |
| Valeurs localisées `a @ l` | HasChor, ChorLean, valeurs multiplement localisées | importé |
| Quantale concurrente, loi d'échange | algèbre de Kleene concurrente (Hoare, Möller, Struth, Wehrman) | **à vérifier — `BIB-25`** |
| Déterminisme observationnel | littérature sur le flux d'information concurrent | **à instruire — `BIB-26`** |
| **Boîtes aux lettres × contexte gradué** | — | **contribution propre** |
| **Coeffets gradués × coût travail/profondeur** | — | **contribution propre** |
| **Localité comme neuvième instance de la modalité graduée** | — | **contribution propre** |

**Les trois dernières lignes sont la valeur scientifique du programme.** Elles sont exactement du type que le projet revendique : non pas des mécanismes nouveaux, mais des intégrations dont personne n'a encore écrit la composition. Et elles sont défendables précisément parce que tout le reste est importé.

---

## 7. Ordre d'exécution

Le graphe de dépendances impose un ordre, et il se trouve que cet ordre va du moins cher au plus cher.

```
   ÉTAPE 0 ── prérequis du plan PR-02 ──────────────────────────────
   BLOQ-02 (glyphe)  ·  BLOQ-04/TRANS-02 (algèbre des grades)
   BLOQ-05 (niveau d'un calcul)  ·  BLOQ-03 (⊖ en ω)
   « on n'étend pas une algèbre qui a deux définitions »
                              │
   ÉTAPE 1 ── couche 3 ───────▼──────────────────────────────────────
   N-01 bimonoïde · règles PAR et VMAP · N-02 · N-03 · N-04
   ≈ 8 pages · aucune dépendance sur les couches 1 et 2
   → « couche 3 parallèle » devient un théorème
                              │
   ÉTAPE 2 ── couche 2, noyau ▼──────────────────────────────────────
   D1..D4 arrêtées · grammaire · 5 règles · sémantique à pool
   N-06 · N-07 · N-08 · N-09
   ≈ 30 pages · absorbe BLOQ-01, BLOQ-13, STRUCT-04, PREUVE-13
                              │
   ÉTAPE 3 ── couche 2, sécurité ▼───────────────────────────────────
   N-11 déterminisme observationnel · pomsets · Th. 43/46/47 refaits
   ≈ 15 pages · LE poste de dépense · peut être différé, pas évité
                              │
   ÉTAPE 4 ── couche 1 ───────▼──────────────────────────────────────
   modalité @ · MOVE · TRY · N-12 · N-13 · N-14
   ≈ 15 pages · dépend de l'étape 2 pour les sessions annulables
                              │
   ÉTAPE 5 ── consolidation ──▼──────────────────────────────────────
   P4 à trois étages · profil Π étendu · renumérotation · table 1
   ≈ 10 pages
```

**Volume total : environ 78 pages de spécification nouvelle, et 14 théorèmes.** Le manuscrit passerait de 285 à ≈ 360 pages, et de 51 à 65 énoncés — dont, sous le sceau de `TRANS-01`, une proportion démontrée plus élevée qu'aujourd'hui, puisque huit des quatorze sont importés avec leur preuve.

**L'étape 1 est autonome.** Elle peut être conduite immédiatement, sans rien décider des couches 1 et 2, et elle suffit à retirer un tiers de la revendication.

---

## 8. Conséquences pour le plan PR-02

| Fiche | Devenir |
|---|---|
| `BLOQ-01` | **voie 2 retenue.** La fiche reste, sa branche « voie 1 » devient caduque et doit être marquée telle |
| `BLOQ-01a` | absorbé — les modalités temporelles reçoivent leurs clauses grammaticales à l'étape 2 |
| `BLOQ-13`, `PREUVE-13` | **absorbés par `N-08`** — le graphe est importé avec son théorème |
| `STRUCT-04` | **absorbé** — SPSC contre MPSC cesse d'être une question : le motif de boîte est non ordonné par construction |
| `FACT-11` (`Mailbox` comme objet unique) | **réalisé** — c'est `Mb E` |
| `NOTA-05` (`∏ᵢ` non commutatif) | **partiellement résolu** — `∥ᵢ` est commutatif ; `∏ᵢ` subsiste pour le cas séquentiel |
| `PORT-09` (amorti contre pire cas) | **précisé** — `β = ⟨β_w, β_s⟩` répond à la question « quoi borner » |
| `PREUVE-03` (non-interférence sessions) | **remplacé par `N-11`**, plus fort et plus coûteux |
| `STRUCT-13` (discipline d'échange) | **tranché par D1** — les contextes restent non ordonnés, les canaux sont des valeurs graduées |
| `REECR-19` | réécriture annulée : la revendication devient vraie plutôt que d'être affaiblie |
| `IMPL-04`, `IMPL-05` | requalifiés en exigences de réalisation de `N-07` et `N-10` |
| **nouvelles** | `BIB-25` quantale concurrente · `BIB-26` déterminisme observationnel · `BIB-27` mailbox types et Special Delivery · `BIB-28` EGV · `BIB-29` valeurs localisées |

---

## 9. Risques, et ce qui pourrait mal tourner

1. **`N-11` peut résister.** Le déterminisme observationnel sous ordonnanceur non spécifié est un problème difficile, et il se peut qu'il faille restreindre — à un ordonnanceur déclaré, ou à un fragment sans canaux de haut niveau. **Repli honnête :** énoncer `N-11` sous hypothèse d'ordonnancement nommée, comme `D_det` le fait déjà pour la compilation. Ne pas le promettre sans hypothèse.
2. **Le mariage graduation × boîtes aux lettres n'est pas publié.** Les deux systèmes existent, leur composition non. Le risque concret est que la règle `GUARD` demande une opération sur les contextes que l'algèbre des grades ne fournit pas — typiquement une borne inférieure `⊓` qui n'est pas définie sur les quatre composantes. **À éprouver dès l'étape 2, sur trois exemples, avant d'écrire trente pages.**
3. **Le pomset coûte plus cher qu'annoncé.** Réécrire l'annexe E sur des ordres partiels peut être un chantier plus lourd que les quinze pages estimées. **Repli :** fixer un ordonnanceur canonique, prouver sur les traces séquentielles, puis énoncer l'indépendance vis-à-vis de l'ordonnanceur comme théorème séparé — ce qui isole le coût au lieu de le diffuser.
4. **La distribution peut réveiller `E8`.** Sérialiser, c'est fixer un format binaire ; les théorèmes 20 et 23 s'étendent au réseau, et le profil `Π` grossit. Ce n'est pas un obstacle, c'est une surface d'engagement élargie — qu'il faut inscrire au registre `TRANS-05` plutôt que découvrir au ch. 7.
5. **Le volume.** Soixante-dix-huit pages, c'est un quart du manuscrit actuel. Le risque n'est pas l'échec, c'est la dilution : un document de 360 pages dont les 78 nouvelles ne seraient pas au même niveau de rigueur que les autres serait pire qu'un document de 285 pages honnête sur ses limites. **L'étape 1, seule, est un livrable cohérent ; les étapes 2 à 4 ne le sont qu'ensemble.**

---

## 10. Ce que le programme ne fait pas

- **Il ne rend pas la couche 2 déterministe.** La concurrence est non déterministe ; ce qui est garanti est que le non-déterminisme est journalisé, invisible au niveau ℓ, et rejouable. La différence doit être écrite au §1.3, faute de quoi la nouvelle revendication remplacerait l'ancienne.
- **Il ne traite pas la tolérance aux pannes byzantines**, seulement l'arrêt franc. La distinction est standard et doit être déclarée.
- **Il ne fournit pas l'ordonnanceur.** Équité, priorités et famine restent des exigences d'implémentation — mais elles deviennent des exigences *nommées*, ce qui est déjà ce que `BLOQ-13` réclamait.
- **Il ne dit rien du placement dynamique.** Les valeurs localisées supposent la localisation connue à la compilation ; le placement dynamique est un domaine de recherche actif et distinct, à laisser hors périmètre et à déclarer tel.
