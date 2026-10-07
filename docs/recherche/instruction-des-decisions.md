<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Instruction des décisions en attente — réponses que K7PL porte déjà

Instruction tenue **en parallèle des correctifs** (6 octobre 2026), pour que l'arbitrage final se fasse
sur des réponses déjà visibles dans le texte et les travaux. Ce document **ne tranche pas** : chaque
entrée donne la réponse naturelle, ce qui la soutient, ce qui s'y oppose, et ce que la décision
déclencherait. Les décisions sont listées dans [`../suivi/DECISIONS.md`](../suivi/DECISIONS.md).

## État au 6 octobre 2026 (séance 32)

Les orientations ci-dessous ont été **appliquées**, sauf deux (`spawn` et `∥`, qui font l'objet d'études comparatives sans choix), quand elles ne
dénaturaient pas le projet ; les quatre qui restaient en attente après la séance 31 (`STRUCT-06`, `BLOQ-12` pour `∘` et `δ`, les grammaires de
`ANOM-17`, `spawn`) ont été tranchées par l'auteur en séance 32, sauf `spawn`. Chaque décision est
marquée « à ratifier » dans [`../suivi/DECISIONS.md`](../suivi/DECISIONS.md), avec l'endroit du manuscrit et la
[séance 31](../journal/2026-10-06-pr-02-31-orientations-appliquees.md).

| Entrée | État | Où |
|---|---|---|
| `STRUCT-16` | appliquée | §3.1 |
| `IMPL-04` | appliquée | §4.5 |
| `IMPL-07` / `BLOQ-12` | appliquée ; `∘` et `δ` **définis** en séance 32 (extension de K7PL, sans source) | §3.2 |
| `ARB-PR-04` | appliquée (B puis C) | §4.5, §1.2 |
| `FACT-12` / `STRUCT-01` | appliquée | §1.4 |
| `FACT-14` | appliquée | §2.4 |
| `ARB-PR-03` | inchangée (à ratifier depuis le 1er octobre) | — |
| `STRUCT-06` | **tranchée par l'auteur** (séance 32) : toutes les phases renumérotées, 0 à 10 sans fraction ; la recommandation « 1.5 » entrait en collision avec Phase 1.5 | fig. 11, ch. 1 à 7 |
| `D-7` | appliquée | annexes B à D |
| imports ciblés, `T-68` | pas de décision d'auteur (cadre arrêté ; ordre de finition arrêté) | `primitives.md` |
| `ANOM-17` : `slice`, `∥` et `vmap`, `guard`, défaillance de `try`, points de forme | appliquées | §3.2, §4.7 |
| `ANOM-17` : `declassify`, formes temporelles, `at_n`, `move` | **grammaires corrigées** en séance 32 (décision de l'auteur) ; schémas écrits | §3.3, §4.7 |
| `ANOM-17` : `spawn`, fil de temps | **en attente** : étude comparative écrite, pas de choix ([`etude-spawn-fil-de-temps`](etude-spawn-fil-de-temps.md)) | — |
| `ANOM-17` : `∥` et `vmap` | fourche et jointure appliquées ; **étude comparative** de l'entrelacement ([`etude-parallele-fourche-entrelacement`](etude-parallele-fourche-entrelacement.md)) | §4.7 |
| `ANOM-09`, `ANOM-10` | **rédigées** en séance 32 (décision de l'auteur) | `tools/SpecExt/` |

## `STRUCT-16` — les grades `Rel`

* **Réponse naturelle :** garder la grammaire des grades telle qu'elle est, et dire que le mode d'un
  contexte n'est pas calculé mais **attaché à la couche**, donc au délimiteur : `{ }` linéaire,
  `( )` affine, `[ ]` cartésien (§5.1). `Rel = [1..ω]` est un grade admissible de l'algèbre mais **aucune
  zone du langage ne l'instancie**.
* **Ce qui la soutient :** la table de sédimentation (ch. 1) fixe un fragment par couche ; la règle
  d'imbrication à sens unique ne laisse aucune quatrième zone ; `u ∈ ℕ∞` libre est nécessaire pour `Lin_k`
  et `1/N`, qu'une restriction de la grammaire casserait.
* **Ce qui s'y oppose :** une extension future (relevant, au sens de la logique pertinente) trouverait la
  grammaire prête mais le système de zones fermé ; c'est le coût d'ouverture voulu par le §1.4.
* **Effet :** `STRUCT-16` se ferme par un paragraphe (modes atteignables = ceux des trois délimiteurs).

## `IMPL-04` — boîtes aux lettres

* **Réponse naturelle :** **un anneau SPSC par couple (émetteur, boîte) et une file de jonction par
  acteur.** Le texte écrit déjà que la boîte est « un multi-ensemble stocké dans un anneau SPSC » et
  que la jonction se réduit « par échange atomique de pointeurs, verrou-libre » (§4.5) ; `Mailbox = Σ_c Bag(Cap(c))`
  est indexée par canal, donc par émetteur.
* **Ce qui la soutient :** le Disruptor SPSC n'exige ni verrou ni compare-and-swap (`BIB-15`) ; le
  join-calculus connaît la file de jonction (`BIB-04`) ; la capacité d'écriture est linéaire (`Slice`),
  donc un seul émetteur par anneau.
* **Ce qui s'y oppose :** MPSC simplifierait la topologie au prix du compare-and-swap, contraire à P3 ;
  le nombre d'anneaux croît avec le nombre d'émetteurs (borne mémoire à écrire par grade).
* **Effet :** débloque `BIB-04`, `BIB-27` (types de boîtes aux lettres : graphe de dépendance), `FACT-11`.

## `IMPL-07` / `BLOQ-12` — singularités

> **Séance 32.** L'auteur a tranché : définir `∘` et `δ` et sourcer les propagations. Fait : tables de `⊥` et `∞` calculées sur la roue des fractions
> (Carlström 2004, notice confirmée, corps non lu : les pages sont bloquées) ; écart d'IEEE 754 sur `∞ + ∞` écrit ; `∘` et `δ` définis comme extension de K7PL,
> absorbante, **sans source** (aucune des sources atteintes ne porte deux classes d'erreur distinctes de `⊥`). Journal §A.2.

* **Réponse naturelle :** la table de propagation est celle de la **théorie des roues** — `0/0 = ⊥`,
  `1/0 = ∞`, `⊥` absorbante pour `+` et `×` — **plus une règle explicite** pour les deux infinis de
  IEEE 754 (identifier `±∞` en `∞` à l'entrée, ou les distinguer et s'interdire la division par zéro signé).
  Correction notée : la fiche `BLOQ-12` plaçait `1/0 = ⊥`, ce qui est faux (`BIB`, 6 octobre).
* **Ce qui la soutient :** le Th. 18 renvoie déjà à une table spécifiée par K7PL ; la voie C
  d'`ARB-PR-04` (spécifier la propagation) en dépend ; la charge utile NaN n'est que recommandée par
  IEEE 754 (`BIB-08`), donc K7PL ne peut pas s'y fier.
* **Ce qui s'y oppose :** `∘` et `δ` (les deux autres singularités du texte) n'ont pas de contrepartie
  standard dans la théorie des roues à notre connaissance : à définir ou à retirer.
* **Effet :** ferme `BLOQ-12`, rend `Injectivité(obs, repr)` vraie sur les singularités.

## `ARB-PR-04` — rejeu bit-à-bit

* **Réponse naturelle :** voie **B puis C** ([instruction](instruction-arb-pr-04-rejeu-binaire.md)),
  confortée par `IMPL-07` (C) et `BIB-08` (la propagation est optionnelle selon l'architecture : B).

## `FACT-12` / `STRUCT-01` — cadre unificateur

* **Réponse naturelle :** ne **pas** réécrire le chapitre 1 autour d'une adjonction graduée unifiée ;
  prendre de la théorie de modes (`BIB-10`) le **vocabulaire** (le mode est le paramètre) et de
  `TRANS-02` la décomposition module × ordre, qui fournit déjà la structure que `STRUCT-01` réclame.
  `ARB-PR-05` a retenu le cadre du manuscrit et écarté `FACT-21` et `FACT-22`.
* **Constat nouveau (6 octobre) :** la loi distributive n'est qu'*affaiblie* (φ_n n'est pas un morphisme
  de monoïde dans une quantale non commutative) : une unification « tout est une adjonction graduée stricte »
  serait fausse en l'état. Argument de plus pour ne pas la promettre.
* **Effet :** `FACT-12` et `STRUCT-01` se ferment en renvoyant à `TRANS-02` ratifiée.

## `FACT-14` — structures monotones

* **Réponse naturelle :** `STRUCT-17` a déjà distingué les trois notions (fonction, domaine,
  ensemble de règles) ; le « cadre unique » n'ajoute pas de mécanisme. **Fermer `FACT-14` comme satisfaite
  par `STRUCT-17`.**

## `ARB-PR-03` — effets à portée

* **Réponse naturelle :** garder `ℰ_alg` / `ℰ_scoped` et la clôture faible ; `BIB-01` (*Hefty Algebras*) reste
  non instruit. Le constat sur la loi distributive affaiblie (ci-dessus) conforte de ne pas élargir la
  structure des opérations à portée avant que le besoin de modularité soit établi.

## `STRUCT-06` — numérotation des phases

> **Séance 32.** L'auteur a tranché : renuméroter toutes les phases. Fait : 0 à 10, une étape par numéro, sans fraction, trois points de contrôle en pointillés
> (Expansion 1, ConfigAnalysis 2, Résolution 4). Journal §A.1, avec la table ancien → nouveau.

* **Réponse naturelle :** expansion = **phase 1.5**. Elle suit l'analyse (l'expansion opère sur l'arbre),
  n'impose aucune renumérotation, et reprend la convention fractionnaire déjà employée pour les points de
  contrôle 1.5 et 2.5.
* **Correction (6 octobre) :** cette recommandation suppose que 1.5 est libre, et elle ne l'est pas : la figure 11 porte
  déjà **Phase 1.5 : ConfigAnalysis**, où le texte range la vérification d'acyclicité. Restent une décimale de plus
  (1.25) ou Parse = 0 puis Expansion = 1 (neuf mentions de « Phase 0 » deviennent « Phase 1 »). Question laissée à l'auteur.

## `D-7` — annexes B, C, D squelettiques

* **Réponse naturelle :** publier la première version avec un bandeau « esquisse » explicite sur les trois
  annexes, plutôt que de les écrire avant la release ; le corps du texte n'en dépend pas (le chapitre 7 ne
  fait que les citer). À condition que la release porte `ANOM-04` comme réserve connue.

## Imports ciblés et `T-68`

* **Imports :** le cadre est confirmé pour I1 à I4 (`BIB-10`, `-20`, `-21`, `-22`) ; seul I3 demande une
  lecture du corps (`BIB-21`, restriction sur l'égalité définitionnelle contre le produit mixte).
* **`T-68` :** avant-dernier ; `slice` est provisoire. Aucune réponse naturelle à tirer du texte : le choix
  des mots est éditorial.

## `ANOM-17` — les constructeurs dont la réduction n'est pas déterminée par le texte

> **Séance 32.** Les grammaires sont corrigées (décision de l'auteur) ; `declassify`, les formes temporelles, `at_n` et `move` ont leurs schémas
> (`eq:reductions-modalites`). Ce qui suit est l'instruction qui a précédé : la voie retenue pour `declassify` n'est pas la B de l'orientation (une
> étiquette) mais une boîte rendue au niveau abaissé ; pour les formes temporelles, la voie A ; pour `at_n` et `move`, la voie A. `spawn` et `∥`
> restent à l'étude ([`etude-spawn-fil-de-temps`](etude-spawn-fil-de-temps.md), [`etude-parallele-fourche-entrelacement`](etude-parallele-fourche-entrelacement.md)). Journal §A.3.

Instruction du 6 octobre 2026 (séance 29). La relation → compte désormais, en plus des blocs d'origine,
les schémas que les chapitres 2 à 4 déterminent (point fixe borné, copatron sous l'observation, `try` à corps
terminal, les cinq règles globales de la couche 2 et la règle locale ; formules `eq:reductions-pures-suite` et
`eq:reductions-couche2`). Pour les constructeurs ci-dessous, **aucun schéma n'a été écrit** : le texte ne le
fixe pas, ou le fixerait de façon contradictoire. Chaque entrée dit pourquoi, quelles voies existent, ce que
chacune coûte. Aucune n'est tranchée ; la dernière ligne de chaque entrée est l'orientation qui dérange le
moins le texte, à confirmer.

### `declassify` — en attente (défaut de grammaire, voir la séance 31)

* **Constat :** la règle (`eq:regle-declassify`) donne `Δ ⊢ e : !_ℓ A`, `e ∈ 𝒳`, `ℓ' ≤ ℓ` ⊢
  `declassify_ℓ'(e) : !_ℓ' A`. Aucun contractum n'est typable par les règles : le sous-typage sur le niveau
  *monte* seulement (`tab:produit-mixte`), or déclassifier descend. Ensuite, la grammaire porte
  `declassify_ℓ(v)` (une valeur), la règle une expression `e` close « évaluée dans l'état initial ».
* **Voie A, identité à l'exécution** (`declassify_ℓ'(v) → return v`) : les grades sont effacés à la Phase 8,
  donc la valeur ne change pas. Coûte la préservation *graduée* : le contractum garde le type `!_ℓ A`, la
  préservation ne tient qu'« à l'effacement près ». C'est l'écart que le texte reconnaît déjà (le lemme
  fondamental « ne traite pas » ce cas).
* **Voie B, étiquette d'exécution :** une forme de valeur `declass_ℓ'(w)`, typée par la règle elle-même, que le
  rédex produit. Préserve le typage et donne un cas à la clause décisive de la relation logique ; coûte une
  forme de valeur de plus (formes canoniques, substitution, grammaire).
* **Voie C, opération à effet :** la déclassification est une opération dont `⟦operation⟧` réalise
  l'abaissement, donc un événement du journal. Cohérente avec « on ne libère que ce qu'on nomme », mais
  contredit la règle donnée sans effet.
* **Orientation :** B si la préservation graduée de bout en bout (`ARB-PR-06`) doit couvrir la
  déclassification, A sinon. Tranche aussi la question « valeur ou expression `e ∈ 𝒳` ».

### Les six formes temporelles (`delay`, `always`, `at`, `now`, `wait`, `when`) — en attente

* **Constat 1, la catégorie :** `always v`, `now v` et `delay c` sont rangés parmi les *calculs* de la
  grammaire, mais `at v`, `wait v` et `when x = v` attendent une *valeur* de type `□V`, `◇V`, `○◇V`. Aucune des
  neuf formes de valeur n'habite ces types : sur un terme clos, `at`, `wait` et `when` ne peuvent jamais se
  réduire, et le progrès ne peut pas tenir. Ce n'est pas un trou de schéma, c'est un défaut de grammaire.
* **Constat 2, l'horloge :** les trois modalités sont dans la grammaire des *sessions*, et leur contenu temporel
  vit dans la traduction (canal de temps). La configuration `⟨c | μ | τ⟩` n'a pas d'horloge : ni « à tout
  instant », ni « après un délai » n'ont de sens opérationnel dans la relation.
* **Voie A, lecture séquentielle :** ranger `always v` et `now v` parmi les valeurs, lire les trois modalités
  comme l'identité dans la relation (le temps vit dans la trace et la traduction) ; schémas
  `at (always v) → return v`, etc. Minimal ; la durée d'attente n'est plus observable à la source.
* **Voie B, horloge dans la configuration :** un compteur par niveau, `delay c` attend un pas, `wait` et `when`
  attendent la disponibilité. Donne un sens aux bornes de `◇` (`ε[ω/k]`) ; ajoute un composant à toutes les
  configurations et change le statut de `tick`.
* **Voie C, renvoi au métalangage :** la relation → ne réduit pas ces formes, la traduction leur donne leur sens
  et la simulation ne les porte pas. Aucun travail de schéma ; le progrès reste borné.
* **Orientation :** corriger d'abord le constat 1 (ranger les introductions parmi les valeurs, ce qui modifie la
  grammaire du chapitre 3 donc demande l'accord de l'auteur), puis A pour la couche 3 et C pour le reste.

### `∥` et `vmap` — voie B appliquée, à ratifier (la C est reportée)

* **Constat :** `c1 ∥ c2` et `let x ← c1 in let y ← c2 in return (x,y)` rendent la même valeur
  (`thm:determinisme_parallele`) ; seule la profondeur diffère, `max(s1,s2) ≤ s1+s2`. Déplier `∥` en séquence
  est donc correct pour la valeur mais **fait croître** la borne que le type annonce (`ε1·ε2` contre `ε1 ∥ ε2`),
  ce que la préservation (`τ'·ε' ⊑ τ·ε`) interdit. Les deux compositions de coût sont écrites, la trace n'a
  pas de composition parallèle. (Relevé de forme : l'énoncé du théorème dit que le premier effet « majore » le
  second, quand la preuve donne l'inégalité inverse.)
* **Voie A, déplier en séquence :** schéma trivial ; la préservation ne vaut plus que sur le travail (la
  composante profondeur est perdue), et la profondeur de `vmap` (indépendante de `n`) n'est plus une propriété de
  l'exécution.
* **Voie B, fourche-jointure :** un pas `⟨c1 ∥ c2 | μ | τ⟩ → ⟨return (v1,v2) | μ' | τ·(τ1 ∥ τ2)⟩` dont la
  prémisse exécute les branches (grand pas). Préserve la profondeur ; mêle un grand pas à une relation à petits
  pas, et il faut fusionner les arènes `μ1 ⊎ μ2` (disjointes par les capacités).
* **Voie C, entrelacement avec traces par branche :** les branches deviennent des fibrilles de couche 3, la
  trace un ordre partiel comme en couche 2 (la règle `Loc` s'y réutilise). La plus fidèle ; elle porte la
  machinerie de la couche 2 jusqu'à la couche 3, et rend l'ordre partiel nécessaire dès le fragment cartésien.
* **Orientation :** C, puisque `τ` doit déjà devenir un ordre partiel en couche 2 et que `thm:preservation`
  l'annonce ; B comme étape.

### `at_n`, `move_{n→m}` et la défaillance de `try` — la défaillance est appliquée (A), `at_n` et `move` en attente

* **Constat :** aucune valeur de la grammaire ne porte `@_n V`, et `at_n c` produit `@_n C` sans élimination ;
  la configuration n'a pas de lieu courant. `move` rend `v` inchangée (`Ser(V)`) au type `@_m V` : le contractum
  n'est pas typable par les règles (même obstacle que `declassify`, une étiquette qui change). La défaillance
  n'est pas un terme (« la défaillance ne se type pas ») : elle est une transition de l'environnement, dont la
  règle (`try c catch h → h` avec l'événement `fail`) dépend de ce que devient l'état laissé par `c`.
* **Voie A, machine unique :** les lieux sont des étiquettes de type, `at_n c → c`, `move v → return v` avec
  l'événement `net`, la défaillance est un pas non déterministe sans retour en arrière. Aucune sémantique
  répartie ; suffit à la préservation si une forme de valeur étiquetée existe (cf. `declassify`, voie B).
* **Voie B, configuration indexée par lieu :** chaque fibrille a un lieu, `at_n` la déplace, `move` copie la
  valeur sérialisée ; la défaillance détruit les fibrilles d'un lieu. Le plus fidèle à « l'hypothèse
  d'environnement gagne une composante réseau » ; il faut décider si `μ` est par lieu (la mémoire n'est pas
  partagée entre machines, §4.5).
* **Orientation :** A, `μ` étant déjà « une arène par machine » ; la voie B quand la couche 1 sera formalisée
  pour elle-même.

### `slice` — voie B appliquée, à ratifier

* **Constat :** la règle exige `ρ = ρ1 ⊎ ρ2` mais le terme ne dit pas où couper ; aucune valeur n'habite
  `Cap ρ`. Le mot est provisoire (`T-68`).
* **Voie A, annoter le terme :** `slice_{ρ1,ρ2} v as (x,y) in c`. Fixe la coupure ; modifie la grammaire
  (un constructeur annoté de plus, comme `iter_V`).
* **Voie B, capacité sans contenu :** une capacité est un jeton linéaire effacé à l'exécution ;
  `slice v as (x,y) in c → c[κ/x, κ'/y]`. Rien à annoter ; la sûreté spatiale reste une propriété de typage et
  l'arène n'a rien à lire.
* **Orientation :** B, qui est la lecture de `thm:surete_spatiale` (la preuve de grade devient une partition
  mémoire *statique*) ; à lier à `T-68`.

### `guard` : consommation multi-places et choix du message — voie A appliquée, à ratifier

* **Constat :** `thm:sync_motifs_jonction` dit que la réaction `J = x | y ▷ P` consomme deux messages d'un
  seul tenant et que c'est « l'opération native de `Guard` ». Or la règle `Guard` a une branche par *message*
  `m_i(x̄_i)` (une somme `Σ m_i[V_i]·E_i`), pas un produit de messages : la consommation de deux messages n'est
  pas une forme de `Guard`. Le schéma écrit consomme un message. Ensuite, quand plusieurs messages
  conviennent, le choix est celui de la structure de boîte (`IMPL-04`) : multi-ensemble sans ordre, ou file par
  émetteur.
* **Voie A :** étendre `Guard` (grammaire et règle) à des motifs `m1(x̄1) & m2(x̄2)` ; le schéma consomme les
  deux d'un coup. **Voie B :** garder `Guard` à un message et dériver la jonction (réception de `m1` puis de
  `m2`, avec la boîte résiduelle), au prix de l'atomicité que le théorème revendique.
* **Orientation :** A (la jonction est le motif du chapitre 4) ; le choix du message suit `IMPL-04`.

### `spawn` : comptabilité du travail — voie A, déjà écrite

* **Constat :** `Spawn` annonce `⟨spawn, ⟨w(ε), 0⟩⟩` à la mère (le travail de la fille), et la fille inscrit
  ensuite ses propres événements : le travail est compté deux fois si on somme les traces. La borne de chaque
  chaîne reste correcte ; c'est le *total* qui ne se lit pas comme une somme.
* **Voie A :** la trace de la mère porte l'événement de provision, celle de la fille ses événements réels, et
  le total est le maximum par chaîne. **Voie B :** la fille *consomme* la provision (un événement par pas de la
  fille, aucun à la mère). La voie A est celle écrite.

### `spawn` et le fil de temps de la fibrille engendrée (`PREUVE-03`) — en attente

* **Constat :** le fil de temps enfilé (`eq:traduction-fils`) est une chaîne *linéaire* : une fibrille, un fil.
  Une fibrille engendrée ouvre une chaîne de plus, et le programme ne peut ni créer ni recevoir un canal de temps
  *ambiant* (confinement). La traduction de `spawn` n'est pas écrite.
* **Voie A, bifurcation par maillon :** l'événement `spawn` que la mère émet porte, avec son propre maillon
  suivant, un second maillon créé par elle pour la fille ; le gestionnaire écoute deux chaînes. Le système de
  sortes l'admet presque tel quel (le maillon est de genre `maillon`, créé par le programme) ; il faut autoriser
  l'émission de deux maillons à la fois, et le gestionnaire doit pouvoir bifurquer. Donne l'ordre partiel de
  la couche 2 comme *arbre de chaînes*.
* **Voie B, fil fourni :** la fille reçoit du gestionnaire un canal ambiant neuf, par un protocole de demande sur
  le fil de la mère. Maintient « un canal ambiant n'est jamais créé par un programme » ; ajoute un protocole que le
  texte ne donne pas.
* **Voie C, fil partagé :** la fille émet sur la chaîne de la mère. Rompt la linéarité (deux producteurs sur un
  maillon) et ordonne totalement ce que la couche 2 veut partiel.
* **Orientation :** A.

### Points de forme relevés, sans choix à faire — formes terminales, sous-typage des tailles et énoncé du parallèle corrigés

* La liaison implicite `x` du copatron (`Cop`) a un type de *calcul* ; le lemme de substitution est énoncé pour
  des valeurs. Il faut soit un lemme pour les variables de calcul, soit lire `x` comme un thunk.
* Le sous-typage des tailles (`νC⟨i+1⟩ <: νC⟨i⟩`) n'est pas écrit ; le schéma du copatron en dépend.
* L'énoncé du progrès liste les formes terminales sans `Λα.c` ni copatron.
* `thm:terminaison_lfp` dit que le grade d'effet de `fix f` est une fonction de l'indice de `S`, la règle écrit
  `ℰ = ∅`. Le schéma écrit n'émet aucun événement, ce qui suit la règle.
* Le plus petit élément `⊥_S` n'a pas de terme dans la grammaire des valeurs, la traduction le note `⟦⊥⟧`.
* La simulation dit « au moins un pas » (`→⁺`) ; `spawn`, `new` et la réussite de `try` pourraient ne
  correspondre à aucun pas du métalangage (`→*`).
