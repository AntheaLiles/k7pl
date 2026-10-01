# Étude d'opportunité — HoTT et ses déclinaisons comme socle unificateur de K7PL

**Question posée :** la théorie homotopique des types et une ou plusieurs de ses déclinaisons (linéaire, dépendante, cubique, dirigée) peuvent-elles servir d'algèbre et de syntaxe unificatrices pour tout ou partie du socle théorique de K7PL — grades, tick, budget, types, fragments ?

**Établie le :** 2026-09-15, sur la base du manuscrit `K7PL_PR.pdf` (285 p.), des six peer-reviews PR-02 et d'un relevé bibliographique conduit le même jour.

---

## 0. Verdict en une page

**Sur le tout : fausse bonne idée.** Quatre obstacles sont dirimants, dont trois sont des conflits de fond et non des difficultés d'ingénierie.

1. **L'univalence rend inexprimable ce que K7PL doit prouver.** Dans une théorie compatible avec l'univalence, tout énoncé définissable est invariant par équivalence. Or les théorèmes 18, 20 et 23 du manuscrit, et l'ensemble `E_repro`, sont précisément des énoncés **non invariants par isomorphisme** : ils affirment que deux représentations équivalentes coïncident *bit à bit*, ou qu'elles ne coïncident pas. Le résultat phare de l'axe représentation en HoTT s'intitule littéralement *Internalizing Representation Independence with Univalence* — c'est le théorème que K7PL ne veut pas.
2. **Le transport a un coût que P3 interdit de dissimuler.** L'opération centrale de HoTT convertit une égalité de types en une coercion effective. Son coût dépend de la structure du chemin et n'est ni constant ni, en général, statiquement borné. Le budget `β` de K7PL devrait le compter ; aucune théorie publiée ne le fait.
3. **L'assistant de preuve visé est structurellement incompatible.** Lean impose l'irrélevance définitionnelle des preuves et l'élimination des sous-singletons, ce qui contredit l'univalence. Adopter un socle HoTT revient à abandonner Lean et Mathlib pour Agda cubique, Rocq-HoTT ou rzk.
4. **Aucune brique de HoTT ne fournit l'objet dont K7PL a besoin.** Le semi-anneau ordonné agissant sur le contexte — le cœur de K7PL — n'existe dans aucune variante de HoTT. Il faudrait de toute façon l'importer de la famille *graduée*, et la combinaison graduation × univalence n'a, à ce jour, aucune existence dans la littérature.

**Sur des parties : quatre imports réellement rentables**, dont deux seulement appartiennent à HoTT au sens strict, et aucun en position de socle.

| # | Import | Ce qu'il règle dans le plan PR-02 | Famille | Maturité |
|---|---|---|---|---|
| I1 | **Théorie de modes** (Licata–Shulman–Riley, MTT) | `STRUCT-01`, `STRUCT-02`, `FACT-12`, `ARB-PR-05` | modale, non univalente | publiée, **déjà citée [6] par le manuscrit** |
| I2 | **calf / decalf** (phase distinction + coût) | `STRUCT-05`, `STRUCT-19`, `PORT-09`, `PORT-10`, `FACT-02`, `PREUVE-01` | modale, CBPV, Agda | publiée POPL 22 et 24, formalisée |
| I3 | **Théorie des types graduée formalisée** (Abel–Danielsson–Eriksson) | cible `Decidable`, `TRANS-02`, effacement, `FACT-06` | graduée | publiée ICFP 23, formalisée Agda |
| I4 | **Récursion gardée multi-horloges** (CloTT) | `BLOQ-06`, `ARB-PR-02`, `BLOQ-01a`, `STRUCT-04` | modale, variante cubique disponible | publiée, implémentation Agda gardée |

**Le seul usage légitime de HoTT au sens strict** est ponctuel et instrumental : la théorie cubique **sans types Glue** (`XTT`) pour acquitter la dette `PREUVE-16` / `BIB-14` (transposition graduée du théorème 3), que le manuscrit identifie lui-même comme réclamant un type de chemin cubique. En position d'outil de preuve, jamais de socle — et dans cette variante précisément, parce qu'elle conserve l'extensionnalité fonctionnelle et les quotients **sans** l'univalence, donc sans l'obstacle n° 1.

**Lecture d'ensemble.** La question « HoTT pour K7PL ? » souffre d'un défaut de découpage. Ce qui attire l'auteur vers HoTT — un cadre où les modalités, les effacements, les cohérences et les tailles coinductives seraient traités par un seul appareil — a bien été développé par la communauté HoTT, mais **est séparable de l'univalence**, et l'a été. La bonne cible n'est pas HoTT : c'est la famille **modale et graduée** qui a poussé à côté d'elle, dont K7PL cite déjà trois membres et dont il est déjà, sans le dire, un descendant.

---

## 1. Ce que « HoTT » recouvre : six briques séparables

L'erreur d'analyse la plus fréquente consiste à traiter HoTT comme un bloc. Ce n'en est pas un. Six briques, historiquement solidaires et logiquement indépendantes :

| Brique | Contenu | Dépend de |
|---|---|---|
| **B1 — types identité proof-relevants** | `Id_A(x,y)` comme type, `J`, transport, structure de ∞-groupoïde | rien (MLTT) |
| **B2 — univalence** | `(A ≃ B) ≃ (A = B)` ; les types équivalents sont égaux | B1 |
| **B3 — types inductifs supérieurs** | cercle, suspension, troncations, quotients | B1 |
| **B4 — modalités** | Rijke–Shulman–Spitters, cohésion, MTT, cadre fibré LSR | rien — s'ajoute à MLTT comme à HoTT |
| **B5 — calcul cubique** | intervalle, opérations de Kan, types Glue, calcul de l'univalence | B1 ; **B2 ⟸ Glue** |
| **B6 — la famille dérivée non univalente** | STC, distinctions de phase, calf/decalf, XTT | B4, parfois B5 sans Glue |

Trois faits décisifs pour la suite.

**(a) B2 est séparable de B5.** <cite index="75-1">Dans la théorie cubique, ce sont les types Glue qui rendent l'univalence démontrable ; on peut les retirer et postuler l'unicité des preuves d'identité sans perdre l'extensionnalité fonctionnelle ni les types quotients inductifs</cite>. <cite index="74-1">Le nLab enregistre le même fait sous la forme de théories cubiques, telles XTT, où l'unicité des preuves d'identité est un théorème et non un axiome, la canonicité étant préservée</cite>. **Il existe donc un « cubique sans univalence ».** C'est la seule porte d'entrée cubique compatible avec K7PL.

**(b) B4 n'a jamais eu besoin de B2.** Le cadre fibré de Licata, Shulman et Riley est un cadre pour les logiques **sous-structurelles et modales**, non homotopiques — <cite index="1-1">il est publié à FSCD 2017 et le manuscrit de K7PL le cite déjà</cite> (référence [6], §3.1). MTT est une théorie des types dépendants multimodale sans engagement univalent.

**(c) B6 est le lieu où se trouve ce que K7PL cherche.** La distinction de phase, l'effacement, le coût, la restriction par niveau : toute cette machinerie a été construite par des gens formés en HoTT, dans des théories qui ne postulent pas l'univalence.

---

## 2. Ce que K7PL demande à son socle

Dix exigences, extraites du manuscrit et vérifiées sur le PDF.

| # | Exigence | Localisation | Nature |
|---|---|---|---|
| **E1** | Une algèbre de grades à quatre composantes, dont une portée par un semi-anneau ordonné résidué et deux par de simples ordres | p. 48 (`ℛ = ℚ≥0 ∪ {ω}`), p. 244 (`ℛ = ℕ∞ × {d⪯m} × ℒ × ℬ`) | **algébrique** |
| **E2** | Un sous-typage à produit mixte — deux composantes descendent, deux montent — avec cohérence des coercions | p. 247, table 20 p. 250, Th. 39 | algébrique + preuve |
| **E3** | Trois fragments sous-structurels avec foncteurs d'inclusion fidèles | §2.2, table 3, table 6 | algébrique |
| **E4** | Des effets gradués `⟨φ, κ⟩` portant un coût temporel, avec budget résidué (`⊖`) et loi distributive `φ, ψ` | p. 244, p. 248 (`TICK`), table 2 | **algébrique + syntaxique** |
| **E5** | Non-interférence indexée par un treillis de niveaux, **temps compris** | §2.4, §E.4.4, §E.5.5 | preuve |
| **E6** | Un noyau à poussée de valeur (CBPV), adjonction `F ⊣ U`, effets sur les calculs seuls | p. 244, p. 248 | **syntaxique** |
| **E7** | Polarité μ/ν avec critère de terminaison et de productivité | §2.3, Th. 2, 4, 5 | preuve |
| **E8** | **Représentation observable au bit près** : coïncidence de disposition, rejeu binaire, encodage des singularités | Th. 18 p. 107, Th. 20 p. 128, Th. 23 p. 135, `E_repro` | **anti-invariant** |
| **E9** | Typage décidable, mécanisation visée en Lean 4 / Mathlib | §6.2, RMQ 14, plan du projet | outillage |
| **E10** | Sessions, acteurs, boîtes aux lettres, jonctions | §3.2, §4.5 | syntaxique |

**E8 est l'exigence qui décide de toute l'étude.** Elle n'est pas accessoire : elle porte P4, elle porte le postulat de coût P3 via la table de propagation, et elle est le lieu où K7PL revendique sa différence avec les langages à modèle mémoire abstrait.

---

## 3. Confrontation objet par objet

Réponse directe à la question telle qu'elle est posée — grades, tick, poids, types, fragments.

### 3.1 Les grades (`E1`)

**Ce que HoTT apporte : rien.** Aucune des six briques ne contient de semi-anneau agissant sur le contexte. La structure de HoTT est celle d'un ∞-topos ; la structure dont K7PL a besoin est celle d'un module sur un semi-anneau ordonné (cf. `TRANS-02`).

**Ce que la famille voisine apporte : tout.** <cite index="21-1">Grtt développe une théorie des types dépendants paramétrée par un semi-anneau décrivant le flux de données dans les termes *et* dans les types, corrigeant l'incapacité de QTT à suivre l'usage au niveau des types</cite>. Et <cite index="17-1">la théorie d'Abel, Danielsson et Eriksson est paramétrée par une modalité — une sorte de semi-anneau partiellement ordonné — dont les éléments suivent l'usage des variables dans les termes et les types ; elle est entièrement formalisée en Agda</cite>, <cite index="24-1">avec préservation du typage, normalisation et décidabilité de l'égalité définitionnelle établies par relation logique de Kripke</cite>.

**Une réserve importante pour K7PL** : <cite index="24-1">ce cadre ne prend pas en charge les instances qui affectent l'égalité définitionnelle</cite>. Il faut donc vérifier que le produit mixte de K7PL n'en est pas une — il ne semble pas l'être, les quatre composantes n'intervenant que dans les prémisses et non dans la conversion, mais **c'est une vérification à conduire, pas une évidence**.

**Verdict grades :** HoTT nulle part, graduation partout. `TRANS-02` reste la bonne correction, et son horizon de mécanisation est Abel–Danielsson–Eriksson, pas HoTT.

### 3.2 Le tick et le budget (`E4`) — le point le plus intéressant de l'étude

Ici se joue une homonymie et une vraie découverte.

**L'homonymie.** La théorie des types à horloges possède une notion de *tick*, et ce n'est pas celle de K7PL. <cite index="103-1">Dans CloTT, `▷^κ A` est le type d'une donnée retardée d'un pas sur l'horloge κ, l'introduction et l'élimination se faisant par abstraction et application de ticks selon des règles à la Fitch</cite>. Le tick y est une **assumption de contexte pour le retard**, pas un compteur de coût. Confondre les deux serait une erreur de niveau exactement du genre que le plan PR-02 traque.

**La découverte.** Le formalisme qui correspond au `tick` de K7PL existe, il est récent, il est formalisé, et il est bâti sur CBPV — c'est-à-dire sur le noyau même de K7PL. <cite index="9-1">calf et decalf reposent sur une distinction formelle de phase entre l'extension et l'intension d'un programme — son comportement pur, distinct de son coût mesuré par une primitive effectueuse de comptage de pas — et le système de types garantit que le comportement n'est pas affecté par la comptabilité du coût</cite>. <cite index="13-1">La présentation est une version allégée de l'appel par poussée de valeur, où thunk et force sont des identités, les deux niveaux étant reliés par une paire de modalités</cite>. <cite index="14-1">calf implémente deux techniques fondamentales d'analyse d'algorithmes : la méthode des relations de récurrence et la méthode du physicien pour l'analyse amortie</cite>.

Chaque élément de cette description correspond à un objet du manuscrit :

| Objet de K7PL | Correspondant dans calf/decalf | Fiche PR-02 concernée |
|---|---|---|
| `tick : F₁ 1 ∣ ⟨1, δ_ℓ⟩` | primitive `step` de comptage | `BLOQ-05`, `NOTA-02` |
| budget `β`, résiduation `⊖`, potentiel du Th. 43 | méthode du physicien, analyse amortie | `PORT-09`, `PORT-10`, `PREUVE-01` |
| distinction compilation / exécution | distinction de phase `¶ext` | `STRUCT-19` |
| famille des projections `π_ℓ`, `π†`, effacement de phase | modalités de phase, ouverte/fermée | `FACT-02` |
| non-interférence temporelle | <cite index="15-1">la non-interférence figure parmi les mots-clés du projet calf</cite> | `PREUVE-03` |
| ordres `⊑`, `≼`, composante de monotonie | <cite index="16-1">decalf munit chaque type d'un préordre intrinsèque, une borne de coût devenant un programme parmi d'autres</cite> | `STRUCT-17`, `FACT-14` |
| adjonction `F_ε ⊣ U_ε` | les deux modalités reliant valeurs et calculs | `STRUCT-21` |

**Le théorème 45 — la dette la plus lourde du manuscrit selon `PREUVE-01` — est exactement le théorème que calf est construit pour donner.** La question « le grade compte-t-il ce qu'il prétend compter ? » est la question de l'adéquation du compteur de pas au coût effectif, et la distinction de phase est la réponse : le comportement est prouvé indépendant de la comptabilité, donc la comptabilité peut être supprimée sans changer le comportement, ce qui est la moitié de l'énoncé recherché.

**Réserve honnête.** calf est un cadre logique pour *analyser* des programmes, pas un système de types pour un langage. Le transport de son appareil vers K7PL demande de traiter ce que calf ne traite pas : les coeffets gradués sur le contexte. Personne n'a publié la combinaison. Mais le point de départ est bien meilleur que HoTT, et le coût d'entrée est bien plus faible, parce que **calf parle déjà CBPV et K7PL aussi**.

### 3.3 Les types et les fragments (`E3`, `E6`)

**La déclinaison linéaire de HoTT ne fait pas ce que son nom suggère.** LHoTT est une extension de HoTT par des formateurs de types linéaires, mais son « linéaire » désigne les spectres, pas les ressources. <cite index="3-1">Le système ajoute à MLTT une modalité ♮ simultanément monade et comonade, puis un tenseur monoïdal, une unité et un hom interne qui capturent abstraitement des constructions sur les spectres, ce qui conduit à une théorie « bunchée » où les contextes ont une structure arborescente</cite>. <cite index="53-1">L'application visée est la programmation quantique avec contrôle classique et portes protégées topologiquement, la sémantique étant une extension homotopique de celle de Proto-Quipper</cite>.

Trois conséquences pour K7PL :

1. **Il n'y a pas de graduation.** LHoTT distingue linéaire et non linéaire ; elle ne compte pas les usages, n'a pas de fragment affine, pas de `1/N`, pas de `ω`.
2. **La syntaxe est plus lourde, pas plus légère.** Les contextes bunchés arborescents remplaceraient le contexte gradué plat que K7PL a obtenu au prix d'une décision explicite (`ARB-009`, fusion de la zone Γ). **Adopter LHoTT reviendrait à défaire l'une des rares simplifications que le manuscrit a réussies.**
3. **Le cadre n'est pas stabilisé.** <cite index="2-1">Riley note lui-même que LHoTT n'entre actuellement dans aucun des deux cadres existants — ni MTT, ni le cadre fibré</cite>. C'est un aveu de l'auteur, pas une critique extérieure.

**Les autres théories dépendantes linéaires** — Vákár, Krishnaswami–Pradic–Benton, Fu–Kishida–Selinger — résolvent le même problème hors HoTT et sans univalence. <cite index="59-1">Le cadre le plus général disponible, celui d'Aberlé, se présente lui-même comme un travail préliminaire sur un système d'intégration des types dépendants dans les systèmes sous-structurels</cite> : intéressant, trop jeune pour porter une spécification.

**Verdict fragments :** la voie LSR, que le manuscrit cite déjà, fait le travail que `STRUCT-01` demande — ranger la zone d'échange, la donnée de mode et la modalité `•` comme paramètres d'un système de modes — **sans aucune dépendance homotopique**.

### 3.4 La représentation (`E8`) — l'obstacle dirimant

C'est ici que l'affaire se tranche.

L'univalence a une conséquence structurelle : **tout prédicat définissable devient invariant par équivalence**. C'est son intérêt en mathématiques, et c'est ce qui la rend impraticable ici. <cite index="37-1">Le transport est l'opération qui envoie les égalités entre types sur des coercions entre ces types</cite> ; le programme de recherche correspondant, mené par Angiuli, Cavallo, Mörtberg et Zeuner, s'intitule *Internalizing Representation Independence with Univalence*.

Or les théorèmes 18, 20 et 23 de K7PL affirment, respectivement :
- qu'un encodage particulier des singularités dans les bits de charge utile d'un NaN est fidèle (p. 107) ;
- que trois dispositions mémoire coïncident **bit à bit** pour les scalaires et **ne coïncident pas** pour les listes de structures (p. 128) ;
- qu'une égalité observationnelle se transporte en **identité de représentation** sous `E_repro` (p. 135).

Aucun des trois n'est invariant par isomorphisme. Le second est même, dans sa moitié négative, l'affirmation que deux types équivalents **ne sont pas** interchangeables. Dans un langage interne univalent, cet énoncé n'est pas faux : il n'est pas énonçable.

**On pourrait objecter** que l'univalence porterait sur le métalangage de mécanisation et non sur le langage objet, et que rien n'interdit de parler de représentation dans un métalangage univalent. C'est juste, et c'est même ce que fait la communauté. Mais alors HoTT n'est plus « algèbre et syntaxe unificatrices du socle » : elle est un assistant de preuve parmi d'autres, et l'argument d'unification tombe. **La question posée était celle du socle ; à cette question, E8 répond non.**

### 3.5 Les modalités temporelles et les tailles coinductives (`E7`, `BLOQ-06`)

Seul endroit où une déclinaison proche de HoTT règle un **bloquant** identifié par les relecteurs.

Le manuscrit exclut ω des indices de taille (p. 57) au motif qu'<cite index="24-1">un assistant majeur admet une plus grande taille réflexive dont on tire une preuve du type vide</cite> — et `BLOQ-06` établit que cette clause vide le domaine des acteurs et flux non bornés. Or la récursion gardée résout la productivité **sans indices de taille du tout** : <cite index="95-1">dans sa version multi-horloges, elle permet de programmer et de raisonner sur les types coinductifs en encodant dans les types la condition de productivité requise pour les définitions récursives</cite>, et <cite index="97-1">CloTT a reçu une sémantique de réduction satisfaisant normalisation forte, confluence et canonicité, ce qui établit que la productivité peut effectivement être encodée dans les types</cite>.

La correspondance avec K7PL est étroite et non forcée :

| K7PL | Récursion gardée |
|---|---|
| `○C` (délai), règle `DEL` | `▷^κ A`, règles à la Fitch |
| `□S` (permanence) | quantification sur les horloges `∀κ` |
| indice de taille `i ∈ ℕ∞ ∖ {ω}` | **rien — la productivité est dans le type** |
| Th. 22, équivalence de rejeu | <cite index="102-1">la bisimulation comme type de chemin pour les types récursifs gardés</cite> |

**Réserve à porter au dossier.** <cite index="101-1">Un travail récent note que les types gardés évitent les manipulations algébriques de paramètres de taille, tout en ajoutant que les types de taille fonctionneraient peut-être aussi bien</cite>. Ce n'est donc pas une supériorité établie, c'est une alternative crédible. Et la variante la plus outillée, <cite index="99-1">Clocked Cubical Type Theory, est la première à combiner récursion gardée multi-horloges, types inductifs supérieurs et univalence</cite> — c'est-à-dire qu'elle réintroduit l'obstacle n° 1. **Il faut donc viser CloTT sans cubique, ou cubique sans Glue.**

### 3.6 Les sessions et la couche 2 (`E10`)

HoTT n'a rien. La bonne référence est, une fois de plus, dans la famille graduée : <cite index="90-1">un travail sur Granule montre comment les types modaux gradués peuvent être mobilisés à côté des types de session pour réintroduire de façon précise divers comportements de concurrence non linéaires dans un système à base linéaire</cite>. C'est **exactement** le problème de `BLOQ-01` voie 2 et de `STRUCT-04`. Du côté dépendant, <cite index="86-1">TLL_C étend une théorie des types linéaire dépendante à deux niveaux par la concurrence à base de sessions, les types de session pouvant spécifier des propriétés des messages communiqués</cite>.

### 3.7 La monotonie (`𝕄`) et la théorie dirigée

Tentation : la composante de monotonie est un ordre, la théorie dirigée des types étudie les morphismes non inversibles, donc allons-y. **Mauvaise idée, pour une raison de dimension.**

La monotonie de K7PL est une propriété du premier ordre de fonctions sur des posets finis (`Trellis_fin`, hauteur `h`). La théorie dirigée est un appareil pour les ∞-catégories : <cite index="78-1">Rzk implémente un raffinement de la théorie simpliciale des types de Riehl et Shulman pour le raisonnement synthétique sur les ∞-catégories</cite>, et <cite index="85-1">le projet se décrit lui-même comme un prototype précoce expérimental</cite>. <cite index="79-1">Les preuves y sont parfois trop détaillées, l'outil n'ayant pas encore développé de sucre syntaxique, de paramètres implicites, de tactiques ou de classes de types</cite>.

Utiliser une ∞-catégorie synthétique pour exprimer « cette fonction préserve un ordre » est un marteau-pilon sur une punaise. **`FACT-14` (cadre unique des structures monotones) se règle en une demi-page de définitions ordinaires.**

### 3.8 La cohérence des coercions (`E2`) — l'argument pro-HoTT le plus sérieux, et pourquoi il ne tient pas

Il faut lui donner sa pleine force. Le théorème 39 est un **problème de cohérence** : deux dérivations de sous-typage du même terme doivent dénoter la même chose (`STRUCT-07`, `PREUVE-10`). Or la cohérence est le terrain natal de HoTT : la théorie a précisément été construite pour que les diagrammes de cohérence de dimension supérieure soient engendrés plutôt que postulés. L'argument est donc sérieux, et il mérite mieux qu'un rejet de principe.

Il ne tient pas, pour une raison précise. **La relation `≼` de K7PL est un préordre** — <cite index="24-1">le produit `(≥) × (⪰) × (≤) × (≤)` sur ℛ, comme l'écrit la table 20</cite>. La catégorie qu'un préordre engendre est *mince* : au plus une flèche entre deux objets. Dans une catégorie mince, **il n'y a aucune obligation de cohérence au-dessus de la dimension 1**. La difficulté réelle est de montrer que l'assignation `dérivation ↦ coercion` se factorise par la relation, c'est-à-dire qu'elle est indépendante de la dérivation — un énoncé unidimensionnel.

Et l'ironie mérite d'être relevée : la réponse homotopique à ce problème serait de tronquer `≼` en proposition. Or **l'univers `Prop` de Lean, avec son irrélevance définitionnelle, fournit cette troncature gratuitement et définitionnellement** — la fonctionnalité même qui rend Lean anti-HoTT. <cite index="46-1">Lean traite toutes les preuves d'une proposition comme identiques, ce qui signifie qu'une égalité a au plus une preuve, et cette propriété est anti-HoTT</cite>. Pour le problème de cohérence de K7PL, l'outil le plus direct est donc celui que l'adoption de HoTT ferait perdre.

---

## 4. Les quatre obstacles, en détail

### O1 — Invariance par équivalence contre déterminisme de représentation
Développé au §3.4. **Dirimant.** Il ne s'agit pas d'une difficulté technique mais d'une opposition de projet : l'univalence est un axiome d'indépendance à la représentation ; P4 et le théorème 20 sont un engagement de détermination de la représentation.

### O2 — Le coût du transport contre P3
P3 interdit à K7PL « tout effet dépendant de la machine, inexplicable dans les termes du langage lui-même », et le manuscrit applique ce critère jusqu'à sa propre théorie (§2.3 p. 65). Le transport cubique est une opération dont le coût dépend de la structure du chemin et du type transporté. Dans un langage où le budget `β` doit majorer le coût, chaque transport devrait déclarer le sien. **Aucune théorie publiée ne fournit de borne de coût pour le transport**, et la littérature sur le coût en type dépendant — calf, decalf — travaille précisément dans des cadres où l'univalence n'est pas postulée. Ce n'est pas un hasard.

### O3 — Incompatibilité avec l'outillage visé
<cite index="43-1">L'élimination des sous-singletons, propriété par laquelle certains types inductifs de `Prop` peuvent éliminer vers tous les niveaux d'univers, est la fonctionnalité de `Prop` inconsistante avec l'univalence</cite>. <cite index="41-1">Poser naïvement l'univalence pour l'égalité de Lean est inconsistant, et définir un type d'égalité dans `Type` ne suffit pas à s'en sortir, l'égalité proof-irrelevante de `Prop` permettant de prouver l'équivalence des deux</cite>.

Conséquence pratique : un socle HoTT impose d'abandonner Lean et Mathlib. Le manuscrit signale déjà, en sens inverse, que <cite index="24-1">le type de chemin cubique n'est pas offert par l'assistant visé</cite> (RMQ 14). **La contrainte est donc déjà connue de l'auteur ; l'étude ne fait que la chiffrer.** Le coût n'est pas marginal : c'est le remplacement d'une bibliothèque mathématique mûre par un écosystème plus étroit.

### O4 — La brique manquante
Aucune variante de HoTT ne fournit de semi-anneau de grades. La combinaison graduation × univalence n'existe pas dans la littérature relevée. Le résultat le plus proche est **MTT□**, unification de la théorie cubique et de MTT : <cite index="71-1">chaque mode y est une copie de la théorie cubique plutôt que de MLTT, les modes étant reliés par des adjoints droits dépendants arbitraires</cite>. C'est modal et cubique — ni gradué, ni sous-structurel. Les auteurs relèvent au passage un avertissement qui vaut pour K7PL : <cite index="71-1">ajouter la réflexion de l'égalité à MTT perturberait la décidabilité du typage</cite>, ce qui concerne directement la cible `Decidable` du projet.

### O5 — La dimension supérieure est du travail en pure perte (non dirimant, mais coûteux)
Tous les types de K7PL sont des ensembles au sens homotopique, ou le deviendront : ce sont des scalaires, des vecteurs, des arènes, des protocoles. Aucune construction du manuscrit ne produit de type dont les chemins d'ordre deux soient non triviaux. Adopter un socle où chaque type porte une structure de ∞-groupoïde, c'est payer un appareil dont K7PL n'utiliserait que le niveau zéro — et payer surtout les **obligations** correspondantes dans toutes les preuves.

---

## 5. Examen des déclinaisons, une par une

| Déclinaison | Ce qu'elle apporte à K7PL | Ce qu'elle coûte | Verdict |
|---|---|---|---|
| **HoTT « du livre »** (univalence axiomatique) | rien sur E1–E7 ; casse E8 | canonicité perdue, Lean perdu | ✗ |
| **Cubique CCHM / Cubical Agda** | calcul de l'univalence, extensionnalité, quotients | O1, O2, O3 | ✗ comme socle |
| **Cubique sans Glue (XTT)** | chemins calculatoires, extensionnalité, quotients, **sans univalence** | Lean perdu | ✓ **en outil ponctuel** — `PREUVE-16` |
| **LHoTT** (Riley) | linéarité + identité ; mais « linéaire » = spectres | contextes bunchés, pas de graduation, cadre non stabilisé | ✗ |
| **Dependent linear TT** (Vákár, KPB, FKS) | intégration linéaire/dépendante hors HoTT | pas de graduation ; syntaxe à deux zones | ~ référence utile |
| **Aberlé, substructural DTT** | cadre général sous-structurel dépendant | préliminaire | ~ à surveiller |
| **MTT / MTT□** | multimodalité, adjoints droits dépendants | pas de graduation ni de sous-structuralité | ✓ **pour `STRUCT-01`** |
| **Cadre fibré LSR** | modes, sous-structuralité, admissibilité de la coupure indépendante de la théorie des modes | non dépendant | ✓✓ **déjà cité [6]** |
| **Grtt** (Moon–Eades–Orchard) | graduation dans termes *et* types | pas d'implémentation mûre | ✓ conceptuel |
| **GrTT formalisé** (Abel–Danielsson–Eriksson) | semi-anneau partiellement ordonné, universe, effacement, **Agda, décidabilité** | pas d'instances touchant l'égalité définitionnelle | ✓✓ **patron de mécanisation** |
| **QTT / Idris 2** | précédent industriel du semi-anneau `{0,1,ω}` | usage seul, pas de niveau ni de budget | ~ précédent |
| **calf / decalf** | coût, phase, amorti, préordre intrinsèque, CBPV | ne traite pas les coeffets | ✓✓✓ **meilleur candidat E4** |
| **CloTT / gardé multi-horloges** | productivité sans tailles, `▷` = `○`, bisimulation = chemin | variante outillée passe par le cubique | ✓✓ **règle `BLOQ-06`** |
| **Dirigée / simpliciale (RSTT, Rzk)** | ordres comme morphismes | ∞-catégories pour un poset ; outil expérimental | ✗ |
| **Granule sessions + gradué** | sessions non linéaires dans une base linéaire graduée | non dépendant | ✓✓ **pour `STRUCT-04`** |
| **TLL_C** | sessions dépendantes, vérification relationnelle | à deux niveaux | ✓ pour `BLOQ-01` voie 2 |

---

## 6. Les quatre imports rentables, par ordre d'exécution

### I1 — Théorie de modes (LSR / MTT) pour ranger les onze modalités
**Ce que cela règle :** `STRUCT-01` (inversion d'antériorité), `STRUCT-02` (ℳ hors des trois strates), `FACT-12` (adjonction graduée unifiée), et fournit une réponse à `ARB-PR-05` (choix du cadre de rédaction).
**Pourquoi c'est peu coûteux :** le manuscrit cite déjà le cadre en [6], au §3.1, et pour la bonne raison — le mode y est le **paramètre**, et l'admissibilité de la coupure y est démontrée indépendamment de la théorie des modes. Ce qui manque n'est pas la référence mais son emploi : K7PL possède onze instances d'une même construction (huit modalités graduées selon le décompte de la revue CLAUDE, plus la zone d'échange, la donnée de mode et la modalité `•`) et les traite en onze endroits.
**Ce que cela ne donne pas :** la graduation. LSR range les modes ; il ne compte pas les usages. Les deux appareils se composent, ils ne se remplacent pas.
**Aucune dépendance homotopique.**

### I2 — calf / decalf pour le tick, le budget et la distinction de phase
**Ce que cela règle :** `STRUCT-05` (trace contre optimisation), `STRUCT-19` (compilation/exécution comme modalité), `PORT-09` (amorti contre pire cas), `PORT-10` (borne contre mesure), `FACT-02` (schéma de restriction), et donne une route à `PREUVE-01` (théorème 45).
**Pourquoi c'est le résultat principal de l'étude :** le point d'accroche est exact. Les deux systèmes sont bâtis sur CBPV ; les deux séparent valeurs et calculs par une adjonction ; les deux mesurent le coût par une primitive de pas ; les deux ont besoin que le comportement soit indépendant de la comptabilité. La différence est que calf le **démontre** et que K7PL l'**énonce**.
**Le travail réel :** K7PL a des coeffets gradués sur le contexte, calf n'en a pas. La combinaison n'est pas publiée. Deux stratégies :
- *stratégie basse* — importer la distinction de phase et la méthode du physicien comme **appareil de preuve** pour le théorème 45 restreint à la composante d'usage et à la couche 1, comme `PREUVE-01` le recommande déjà ;
- *stratégie haute* — poser la combinaison graduée × phasée comme objet de recherche propre, ce qui est une contribution publiable mais change la nature du projet.
**La stratégie basse suffit pour le manuscrit.** La haute est un travail de thèse.

### I3 — Le patron de mécanisation gradué formalisé
**Ce que cela règle :** la cible `Decidable` du projet, l'effacement (`FACT-06`), et donne un précédent chiffré pour `TRANS-02`.
**Pourquoi c'est le bon patron :** une théorie des types dépendants paramétrée par un semi-anneau partiellement ordonné, formalisée de bout en bout, avec normalisation et décidabilité de l'égalité définitionnelle établies par relation logique de Kripke, et une fonction d'extraction qui retire le contenu effaçable. C'est, à la structure des grades près, la forme de ce que K7PL veut mécaniser.
**Trois écarts à instruire :**
1. le semi-anneau y est unique, K7PL en a un produit à quatre composantes dont deux ne sont pas des semi-anneaux (`TRANS-02`) ;
2. la restriction déclarée — pas d'instances affectant l'égalité définitionnelle — doit être confrontée au produit mixte ;
3. la formalisation est en Agda ; la transposer en Lean est possible mais n'est pas gratuite.
**Conséquence pour le projet :** la cible Lean 4 / Mathlib reste tenable, mais **le patron de preuve à copier est en Agda**, et le coût de transposition doit être budgété plutôt que découvert.

### I4 — Récursion gardée pour la productivité, en remplacement de la clause de taille
**Ce que cela règle :** `BLOQ-06` (la clause `i ∈ ℕ∞ ∖ {ω}` vide le domaine des acteurs et flux), `ARB-PR-02`, `BLOQ-01a` (les modalités temporelles concluent des types non engendrés), et donne un cadre à `STRUCT-04`.
**Pourquoi c'est mieux qu'une correction locale :** `BLOQ-06` propose de scinder les tailles en deux sortes, `𝕊_μ` et `𝕊_ν`. C'est correct et suffisant. La récursion gardée propose autre chose : **supprimer l'indice de taille du côté coinductif**, la productivité devenant une propriété du type par la modalité de retard. K7PL a déjà la modalité — c'est `○` — et ses règles `DEL`, `ALW`, `NOW`, `WAIT`, `WHEN` sont, à la lecture, des règles à la Fitch mal formées faute de clauses grammaticales (cf. `BLOQ-01a`, `BLOQ-02`). **Les réparer en visant CloTT revient au même travail, avec un précédent formel et une normalisation forte en prime.**
**Réserve :** l'alternative n'est pas établie comme supérieure, et la variante la mieux outillée réintroduit le cubique. À instruire avant de trancher, pas à adopter d'office.

### I5 (ponctuel) — Cubique sans Glue pour la seule dette du théorème 3
**Ce que cela règle :** `PREUVE-16` / `BIB-14`, c'est-à-dire la transposition graduée de la préservation des points fixes par les conteneurs, dont le manuscrit dit lui-même qu'elle réclame un type de chemin cubique que l'assistant visé n'offre pas.
**Pourquoi la variante sans Glue :** elle conserve l'extensionnalité fonctionnelle et les quotients — tout ce dont la preuve a besoin — et abandonne l'univalence, donc l'obstacle O1. K7PL n'a jamais besoin de transporter le long d'une équivalence de types ; il a besoin de raisonner extensionnellement sur des familles indexées.
**Statut :** outil de preuve pour une dette isolée. **En aucun cas un socle.** Et la question reste ouverte de savoir si la preuve est faisable autrement — ce qui serait préférable, et que `BIB-14` demande précisément de vérifier.

---

## 7. Conditions de falsification

Cette étude conclut par la négative sur la question principale. Voici ce qui la retournerait, énoncé d'avance pour que le verdict soit révisable plutôt que définitif.

| Condition | Ce qui changerait |
|---|---|
| **K7PL abandonne E8** — plus de coïncidence bit à bit, plus de rejeu binaire, `P4` restreint au rejeu logique | O1 tombe. L'obstacle principal disparaît, et la question devient celle du coût de O2 et O3 seuls. **C'est une décision de projet, pas une question technique.** |
| **Publication d'une théorie graduée × univalente avec typage décidable** | O4 tombe. Aucun signe à ce jour ; MTT□ est le plus proche et n'est ni gradué ni sous-structurel. |
| **Borne de coût publiée pour le transport cubique** | O2 tombe. Rien dans la littérature relevée. |
| **La cible de mécanisation passe de Lean à Agda cubique** | O3 tombe, au prix de Mathlib. À évaluer indépendamment : la question « Lean ou Agda » se pose pour K7PL même sans HoTT, et le patron I3 est en Agda. |
| **La couche 1 devient un langage de circuits quantiques** | LHoTT devient pertinente, et le rapport s'inverse entièrement. |
| **Le manuscrit produit un type dont les chemins d'ordre deux sont non triviaux** | O5 tombe. Aucun candidat dans les 285 pages. |

**La première ligne est la seule qui dépende de l'auteur.** Si la revendication de représentation devait être abandonnée pour d'autres raisons — et `PORT-01`, `PORT-04` et `ARB-PR-04` du plan PR-02 en réduisent déjà la portée —, alors l'étude mérite d'être refaite.

---

## 8. Coût comparé

Chiffrage relatif, en pages de spécification à réécrire et en dépendances nouvelles. Les ordres de grandeur sont indicatifs.

| Option | Pages à réécrire | Dépendances nouvelles | Dettes soldées | Dettes créées |
|---|---|---|---|---|
| **Socle HoTT complet** | ch. 1, 2, 3 et annexe E, soit ≈ 150 p. | univalence, cubique, assistant à changer | aucune des 14 bloquantes | E8 inexprimable ; coût du transport ; Lean perdu |
| **Socle LHoTT** | idem + contextes bunchés | LHoTT, cadre non stabilisé | aucune | défait `ARB-009` ; pas de graduation |
| **I1 théorie de modes** | §1.4, §2.4, §3.1, ≈ 5 p. | aucune (référence déjà citée) | `STRUCT-01`, `STRUCT-02`, `FACT-12` | aucune |
| **I2 calf, stratégie basse** | §1.3, §E.3.2, §E.4, ≈ 8 p. | une famille de résultats à citer | route pour `PREUVE-01`, `PORT-09`, `PORT-10`, `STRUCT-19` | une hypothèse de phase à nommer |
| **I3 patron gradué formalisé** | 0 p. de spécification ; travail de mécanisation | Agda pour le patron | cible `Decidable` crédibilisée | transposition Lean à budgéter |
| **I4 récursion gardée** | §2.3, §E.1, §E.3.1, ≈ 10 p. | CloTT | `BLOQ-06`, `BLOQ-01a`, `ARB-PR-02` | décision à instruire (I4 ou `BLOQ-06` tel quel) |
| **I5 cubique sans Glue, ponctuel** | 0 p. | un assistant secondaire pour une preuve | `PREUVE-16` | outil hors chaîne principale |

**Rapport le plus favorable : I1 puis I2.** Environ treize pages de réécriture, aucune dépendance lourde, et le recouvrement avec les corrections que les six relecteurs demandaient déjà est presque total — ce qui est le signe qu'on ne fait pas entrer un corps étranger.

---

## 9. Fiches à verser au plan de correction PR-02

À intégrer au fichier `K7PL_taches_consolidees_PR02.md`.

| Fiche | Contenu | Lot |
|---|---|---|
| `ARB-PR-07` | **Trancher : socle HoTT, ou famille modale et graduée ?** La présente étude conclut pour la seconde. La décision doit être écrite au §1.2 du manuscrit avec son motif, car elle sera reposée à chaque relecture. | Arbitrages |
| `BIB-20` | calf et decalf (Niu–Sterling–Grodin–Harper 2022 ; Grodin–Niu–Sterling–Harper 2024) — distinction de phase, comptage de pas, méthode du physicien, préordre intrinsèque. **Priorité haute** : route pour `PREUVE-01`. | Bibliographie |
| `BIB-21` | Théorie des types graduée formalisée (Abel–Danielsson–Eriksson, ICFP 23, et version étendue 2026) — patron de mécanisation, et **vérifier la restriction « pas d'instances affectant l'égalité définitionnelle » contre le produit mixte de la table 20**. | Bibliographie |
| `BIB-22` | Récursion gardée multi-horloges (CloTT, Bahr–Grathwohl–Møgelberg) et bisimulation comme type de chemin (Møgelberg–Veltri) — alternative à la clause de taille, à instruire avec `ARB-PR-02`. | Bibliographie |
| `BIB-23` | Granule, types de session et types modaux gradués — précédent direct pour `STRUCT-04` et pour `BLOQ-01` voie 2 ; et TLL_C pour la version dépendante. | Bibliographie |
| `BIB-24` | Cubique sans types Glue (XTT et variantes) — seule porte cubique compatible avec E8 ; à confronter à `BIB-14` avant d'engager `PREUVE-16`. | Bibliographie |
| `FACT-24` | **Le système de modes comme unique lieu des onze modalités.** Énoncer une fois la discipline (mode, ordre, famille de comonades graduées), puis instancier. Fusionne `STRUCT-01`, `STRUCT-02` et `FACT-12` en une seule écriture. | Factorisations |
| `PORT-17` | **Écrire au §1.3 que K7PL n'est pas invariant par équivalence de représentation, et que c'est délibéré.** Le manuscrit revendique aujourd'hui simultanément une sémantique catégorique abstraite (P1) et une détermination de représentation (P4, Th. 20, Th. 23) sans dire que les deux exigences tirent en sens opposé. C'est la formulation propre de ce que `BLOQ-08` relève déjà. | Portée |

**`PORT-17` est le seul apport de cette étude au diagnostic du manuscrit lui-même** : les six relecteurs avaient vu que 𝒞 n'interprète rien (`BLOQ-08`) ; aucun n'avait relevé que le manuscrit ne *peut pas* avoir à la fois un modèle invariant et une garantie de représentation, et que cela mérite d'être écrit comme une décision plutôt que subi comme une tension.

---

## 10. Ce que cette étude n'a pas fait

1. **Aucune tentative de traduction effective.** Conclure qu'un socle ne convient pas est plus rapide que le prouver. Ce qui est établi ici, ce sont des obstacles et des correspondances, pas une impossibilité formelle.
2. **La littérature relevée est celle qui bordait la question**, une douzaine de recherches conduites le 15 septembre 2026. Les travaux de 2026 sont particulièrement susceptibles d'avoir bougé ; `BIB-21` mentionne une version étendue de 2026 qu'il faudrait lire, et non seulement citer.
3. **L'évaluation de calf contre K7PL repose sur les descriptions publiées**, pas sur une lecture du développement Agda. La correspondance objet par objet du §3.2 est une hypothèse de travail argumentée, pas un résultat vérifié.
4. **Le chiffrage du §8 est indicatif.** Il ordonne les options ; il ne budgète pas un chantier.
5. **La question « Lean ou Agda » n'est pas tranchée ici.** Elle se pose indépendamment de HoTT, et l'import I3 la rouvre légitimement.
