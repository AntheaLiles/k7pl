1. Reconstruction du problème
1.1. Question scientifique fondamentale
Le document K7PL cherche à résoudre un problème d'architecture des langages de programmation : comment garantir simultanément l'absence de fuite/course mémoire (O(1) pire cas), le déterminisme distribué rejouable et la vérifiabilité statique des coûts, sans imposer de rupture de paradigme ou de changement de langage entre le bas niveau (infrastructure), l'orchestration (processus) et le calcul pur ?
Le document pose l'hypothèse qu'il n'est pas nécessaire d'arbitrer arbitrairement sur le triangle de compromis « performance / sûreté / vérification », à condition d'exprimer ces trois exigences comme des instances d'une unique structure algébrique graduée. L'invariant global à préserver est la préservation de la structure catégorique à travers une adjonction Value \dashv Computation (Call-by-Value-Pushing / PBV) où les coûts, la confidentialité et l'usage sont suivis comme des coeffets et des effets gradués.
1.2. Objet central
L'objet germinal du système est le jugement de typage à trois composantes :

Cet objet unifie sous une seule forme :
 * Ce que le terme exige : le contexte gradué \Delta (ressources, canaux) et son algèbre de grades G (coeffets).
 * Ce que le terme est : le type A dans la catégorie ambiante \mathcal{C} (Symmetric Monoidal Closed Category).
 * Ce que le terme produit : la quantale d'effets \mathcal{E} (opérations algébriques + temps/ticks).
Plusieurs mécanismes présentés séparément sont des instances directes de cet objet :
 * Les canaux de communication et protocoles de session : ce sont simplement des liaisons dans \Delta portées par des grades d'usage Lin (exclusif) ou Aff (partagé via contraction).
 * Les régions mémoire et arènes : ce sont des domaines de disjonction spatiale induits par le produit tensoriel \otimes de \mathcal{C} au grade Lin.
 * Les trois couches du langage (Couches 1, 2, 3) : ce ne sont pas trois sous-langages, mais des restrictions syntaxiques et algébriques du même jugement par la sélection de G et \mathcal{E}.
1.3. Architecture des niveaux
Le document déploie son architecture sur cinq niveaux formels :
 * Sémantique catégorique (Niveau 0) : la catégorie SMCC \mathcal{C} avec comonade exponentielle ! et lois d'adjonction PBV.
 * Système de types et de grades (Niveau 1) : le jugement gradué, l'algèbre de grades G = (u, m, l, \beta) et la quantale d'effets \mathcal{E} = \epsilon_0 \times \mathbb{N}_\infty.
 * Stratification par couches (Niveau 2) : la sédimentation triadique (Couche 3 : pureté/inductif, Couche 2 : orchestration/coinductif, Couche 1 : infrastructure/linéaire).
 * Calcul cible / Métalangage (Niveau 3) : la traduction vers le \pi-calcul enrichi de motifs de jonction (Join Patterns).
 * Runtime et Exécution physique (Niveau 4) : le modèle mémoire acquisition-libération, l'allocation en arène et la journalisation Cap'n Proto.
2. Cartographie conceptuelle globale & Analyse d'unification
Le document établit deux sous-systèmes conceptuels développés indépendamment :
et, dans la section dédiée aux effets et à l'exécution :
L'analyse de ces deux chaînes montre les isomorphismes structurels suivants :
 * A \cong A' : l'adjonction PBV entre Value et Computation est exactement le pendant dual de la séparation entre Coeffet (ce que le contexte fournit) et Effet (ce que le calcul produit).
 * B \cong B' : l'action de G sur \mathcal{E} via la loi distributive graduée \lambda_{r,\epsilon} : !_r T_\epsilon \Rightarrow T_{\phi(r,\epsilon)} !_{\psi(r,\epsilon)} unifie le suivi des ressources physiques et le suivi des consommations temporelles.
 * C \cong C' : l'absence de data-race (garantie spatiale) et le déterminisme de rejeu distribué (garantie temporelle) sont les deux projections de l'absence de diagonale A \to A \otimes A dans le fragment non-duplicable de \mathcal{C}.
3. Recherche systématique des duplications, collisions et glissements
3.1. Collisions notationnelles et conceptuelles
 * Collision sur le symbole G : G dénote à la fois la structure de l'algèbre de grades globale dans le jugement (\vdash_G) et des instances de sous-algèbres spécifiques par couche (G_{pile}, G_{budget}). De plus, G est réutilisé dans la description des coalgèbres d'acteurs (\nu G).
   
   
   Danger : La confusion masque le fait que l'acteur est un objet de la catégorie \mathcal{C} alors que l'algèbre de grades est une méta-structure opérant sur les dérivations.
 * Collision sur la notion de canal : Le terme « canal » dénote simultanément un type de protocole de session, une capacité d'accès dans \Delta portée par un grade, et une primitive de synchronisation dans le \pi-calcul cible.
3.2. Sur-affirmations et équivalences trop fortes
 * Sur-affirmation sur l'isolation par types : Le document affirme au §4.5 que l'isolation par types remplace l'isolation par unité de gestion mémoire (MMU) « par construction » grâce à la terminalité de la coalgèbre d'acteur.
   Défaillance : La terminalité garantit l'indiscernabilité comportementale au niveau logique, mais ne prouve pas l'absence de canaux cachés physiques (cache, temps d'exécution, faute matérielle) si le matériel sous-jacent ne supporte pas d'isolation matérielle.
 * Affirmation « gratuitement / sans coût » : Le document prétend au §1.4 que l'appel par poussée de valeur permet d'obtenir la sûreté des gestionnaires d'effets « sans en payer le prix ». L'analyse montre que la restriction impose que tous les calculs effectuels soient encapsulés sous des suspensions (Thunk), ce qui réintroduit une charge d'allocation ou d'indirection à l'exécution si le compilateur ne parvient pas à les éliminer systématiquement par inlining.
4. Analyse de la chaîne de preuves, de compilation et d'exécution
Le pipeline de compilation de K7PL est présenté comme une suite de transformations préservant les invariants. L'analyse des dépendances révèle le cycle de dépendance d'invariants suivant :
 * Rupture de la chaîne : La phase 3 (résolution des effets) calcule l'itération des effets dans la quantale \mathcal{E} à partir des bornes calculées sur les boucles et les récursions. Cependant, la phase 6 (inlining et résorption statique) modifie la structure du graphe de contrôle et élimine des suspensions. Si l'évaluation des coûts dans la quantale est réalisée en Phase 3 sur la syntaxe de surface avant inlining, la borne de complexité calculée ne correspond pas au code réel généré en Phase 8 (abaissement vers l'infrastructure). Il existe une dépendance circulaire non résolue entre l'optimisation par inlining et la certification du budget temporalisé par le solveur.
5. Hiérarchie des problèmes (Fiches de critique structurées)
[DEF-01] Subtypage modal inversé et rupture de la sûreté mémoire
 * Localisation : Chapitre 1, Section 1.3, Postulat P2 (page 11).
 * Énoncé actuel : « Le sous-typage modal Lin T <: Aff T <: Unr T découle de cette structure pour tout type T, et n'est pas une règle ajoutée : une ressource utilisable exactement une fois s'affaiblit en ressource abandonnable, elle-même utilisable sans restriction. »
 * Diagnostic : Inversion complète de la relation de subtypage/subsomption sur les capacités de ressources.
 * Nature : A — Défaut bloquant.
 * Pourquoi c'est réellement un problème : Le subtypage A <: B signifie que toute valeur de type A peut être fournie là où un type B est attendu. Si Aff T <: Unr T, une fonction exigeant un argument Unr T (qu'elle a le droit de dupliquer N fois via la règle de contraction) peut recevoir une ressource Aff T (qui ne tolère aucune duplication). Le récepteur dupliquera la ressource affine, créant un aliasing sauvage sur une région mémoire non partagée. Cela détruit directement l'absence de data-race (P4) et la sûreté mémoire sans ramasse-miettes (P3).
 * Ce qui reste valide : La hiérarchie d'affaiblissement des contraintes existe, mais elle s'exerce dans le sens inverse sur les types, ou sur l'ordre du préordre des grades : une ressource illimitée (Unr) possède plus de capacités et peut être utilisée là où une ressource affine (Aff) ou linéaire (Lin) est demandée (en renonçant à la dupliquer ou à la détruire).
 * Contre-exemple / Scénario de rupture :
   
 * Correction minimale : Inverser formellement la relation de subtypage sur les types modaux :
   
   
   ou reformuler la relation sur les grades dans le semi-anneau : 1 \le_{grade} \text{aff} \le_{grade} \omega, la subsomption de typage inversant l'ordre des grades.
 * Conséquences interchapitres : Réécriture des règles de subsomption du système de types au Chapitre 3 (§3.1) et mise à jour de la preuve de conservation du typage à l'Annexe E.
 * Gain conceptuel : Rétablissement immédiat de la cohérence avec la sémantique des catégories de co-Kleisli et la logique linéaire standard.
[DEF-02] Incomplétude formelle de la loi distributive graduée \phi(r, \epsilon)
 * Localisation : Chapitre 1, Section 1.4, Axiomatique germinale (pages 24-25).
 * Énoncé actuel : « \phi dit comment l'effet est modifié lorsqu'on le fait passer derrière la demande [...] L'itération se fait dans la quantale - \epsilon^n[...]Le grade d'usage u d'une liaison dit combien de fois une ressource est employée ; la multiplicité d'exécution n d'un calcul dit combien de fois ce calcul est lancé [...] c'est la seconde qui gouverne l'itération de l'effet. »
 * Diagnostic : Signature formelle sous-déterminée. \phi est introduite comme une fonction \phi : G \times \mathcal{E} \to \mathcal{E}, prenant un grade r \in G et un effet \epsilon \in \mathcal{E}. Or, la définition explicite de \phi utilise une variable n (multiplicité d'exécution du calcul), tout en affirmant explicitement que n \notin G et n \neq u. \phi(r, \epsilon) est donc incapable de calculer \epsilon^n à partir de ses seuls arguments.
 * Nature : B — Défaut structurel.
 * Pourquoi c'est réellement un problème : La transformation naturelle \lambda_{r,\epsilon} : !_r T_\epsilon \Rightarrow T_{\phi(r,\epsilon)} !_{\psi(r,\epsilon)} fonde l'ensemble de l'interaction entre les coeffets (grades) et les effets (quantale). Si \phi dépend d'un paramètre externe non présent dans G, la loi distributive n'est pas bien définie sur l'algèbre de grades.
 * Ce qui reste valide : L'intuition qu'une boucle ou une réexécution itère l'effet produit.
 * Contre-exemple : Soit un terme t sous le grade r = (u=1, m=\text{disc}, l=\text{pub}, \beta=100). La fonction \phi(r, \text{tick}) doit retourner le nouvel effet. Sans l'information sur le nombre d'itérations n de la boucle entourant t, \phi ne peut pas décider si le résultat est \text{tick}^1, \text{tick}^{10} ou \text{tick}^\infty.
 * Correction minimale : Incorporer la multiplicité d'itération/d'exécution n comme une coordonnée explicite de la composante d'usage dans G, ou faire de \phi une fonction indexée par le combinateur de contrôle :
   
 * Conséquences interchapitres : Corriger la Table 2 du Chapitre 1, la construction de la loi distributive au Chapitre 2 (§2.4) et la vérification des boucles au Chapitre 6 (§6.1).
 * Gain conceptuel : Clarification stricte de la frontière entre le grade d'une ressource en mémoire et la multiplicité d'exécution d'un bloc de code.
[DEF-03] Sur-extension du domaine de rejeu bit-à-bit sous P4
 * Localisation : Chapitre 1, Section 1.3, Postulat P4 (page 12).
 * Énoncé actuel : « Le rejeu est logique par construction [...] et binaire sous la seule hypothèse d'un environnement reproductible [...] Les sources de non-déterminisme [...] ne sont jamais des propriétés intrinsèques du langage [...] déclenchement des motifs de jonction [...] est supprimé en exigeant des motifs qu'ils soient deux à deux disjoints en plus d'être exhaustifs. »
 * Diagnostic : Confusion entre déterministe au niveau logique et reproductible bit-à-bit au niveau de la représentation physique.
 * Nature : C — Défaut de portée.
 * Pourquoi c'est réellement un problème : Exiger que les motifs de jonction soient deux à deux disjoints garantit qu'aucun choix non-déterministe n'existe lors de la sélection d'une règle de réduction (match). Cependant, dans une exécution concurrente sur multi-cœurs (Couche 1/2), l'ordre d'arrivée des messages sur des canaux partagés non reliés par une jonction modifie l'ordre d'allocation des structures dans l'arène partagée. Même si les états observables sont logiquement équivalents, la disposition exacte des octets en mémoire (adresses des pointeurs d'arène, fragmentation) diverge. P4 promet donc le rejeu bit-à-bit sous une condition insuffisante.
 * Ce qui reste valide : Le rejeu logique (séquence d'états observables identiques) est entièrement garanti par la journalisation Cap'n Proto.
 * Contre-exemple : Deux acteurs A et B envoient indépendamment un message à un acteur C. C traite les messages au fur et à mesure et les stocke dans une arène contiguë. L'ordre d'arrivée (A \text{ puis } B) ou (B \text{ puis } A) dépend de la latence du bus d'interconnexion (non journalisée car hors jonction). L'état logique de C est le même ensemble \{A, B\}, mais le sous-traitant mémoire possède l'agencement (A, B) dans le premier cas et (B, A) dans le second. Le rejeu bit-à-bit échoue.
 * Correction minimale : Restreindre explicitement l'affirmation de rejeu bit-à-bit au périmètre d'un unique fil d'exécution déterministe ou imposer que l'ordonnancement complet des réceptions inter-acteurs soit consigné dans le journal si le rejeu bit-à-bit est exigé.
 * Conséquences interchapitres : Modification des exigences du journaliseur au Chapitre 4 (§4.6) et au Chapitre 6 (§6.3).
 * Gain conceptuel : Alignement strict entre le modèle théorique et la réalité physique de l'architecture matérielle.
[DEF-04] Tension non résolue entre appel par poussée de valeur (PBV), types dépendants et effets indexés
 * Localisation : Chapitre 1, Section 1.4, Axiomatique germinale (pages 29-31).
 * Énoncé actuel : Le document affirme que le cadre PBV résout l'incompatibilité fondamentale établie par Castellan et al. entre effets observables, élimination dépendante et lemme de substitution, car « son lemme de substitution ne substitue que des valeurs ».
 * Diagnostic : Hypothèse implicite d'invariance des coûts par substitution.
 * Nature : D — Dette de preuve.
 * Pourquoi c'est réellement un problème : S'il est vrai que substituer une valeur préserve la consistance logique du système de types, le document autorise les types à dépendre d'indices de taille (N \in \mathbb{N}) qui modifient les annotations d'effets (ex: un parcours de tableau effectue N ticks). Lorsqu'on substitue une valeur d'indice N, l'effet du calcul évolue (tick^N). Pour que le lemme de substitution soit valide sur le jugement d'effet \Delta \vdash_G t : A \mid \mathcal{E}, il faut prouver que la quantale d'effets et l'itération \epsilon^n sont stables par substitution d'indices. Cette preuve est déclarée comme découlant du théorème 1 de l'Annexe E, mais l'Annexe ne traite que le cas des termes sans dépendance d'indices dynamiques.
 * Ce qui reste valide : L'isolation des calculs par Thunk en PBV empêche l'inconsistance logique directe (le paradoxe de Girard ou la perte de confluence).
 * Correction minimale : Formuler explicitement le lemme de substitution d'indices comme une propriété séparée et restreindre les indices intervenant dans les effets aux termes clos à la compilation.
 * Conséquences interchapitres : Annexe E (Théorème 1) à étendre pour couvrir la substitution d'indices dans la quantale.
[DEF-05] Duplication théorique de la sédimentation triadique
 * Localisation : Chapitre 1, Section 1.4, Spécialisation par couche (pages 35-37).
 * Énoncé actuel : Les trois couches du langage sont définies par trois équations distinctes (Eq. 2, 3, 4), puis résumées par une table de fragments logiques (Table 3), puis ré-expliquées via l'axe de polarité inductif/coinductif (\mu F vs \nu F).
 * Diagnostic : Duplication conceptuelle. Le document redémontre la cohérence des trois couches sous trois vocabulaires formels différents sans donner l'abstraction sous-jacente.
 * Nature : B — Défaut structurel.
 * Pourquoi c'est réellement un problème : Présenter la sédimentation sous trois angles juxtaposés (restriction de G, polarité PBV, et inclusions fonctorielles F_{1\to 2}, F_{2\to 3}) donne l'impression qu'il s'agit de trois mécanismes indépendants à maintenir cohérents entre eux. Si l'un des trois évolue (ex: ajout d'un mode de ressource), les deux autres présentations risquent de diverger.
 * Correction minimale : Remplacer la triple présentation par la formalisation de la sédimentation comme une unique famille de modes gradués sur la catégorie ambiante \mathcal{C}, où la polarité PBV détermine automatiquement les règles structurelles admises et le domaine de la quantale d'effets.
 * Gain conceptuel : Élimination de 4 pages de redondance normative et unification des preuves de conservation par couche.
6. Factorisations transversales & Abstractions manquantes
6.1. Cause racine commune aux symptômes
Les problèmes identifiés ([DEF-01] subtypage inversé, [DEF-02] paramètre caché dans \phi, [DEF-05] duplication de la sédimentation) ont une unique cause racine : l'absence d'une formalisation explicite de l'adjonction graduée entre la comonade des coeffets et la monade des effets dans le cadre PBV.
Le document traite les coeffets (G), les effets (\mathcal{E}) et les contraintes de valeur comme trois dimensions parallèles qui se « rencontrent » dans le jugement germinal. En réalité, le cadre PBV (Call-by-Value-Pushing) définit canoniquement une adjonction entre la catégorie des valeurs \mathcal{V} et la catégorie des calculs \mathcal{C} :
Les trois couches, les régimes d'usage (Unr, Aff, Lin) et les propagations d'effets ne sont que des instances de l'enrichissement de cette adjonction par un monade/comonade graduée distributive.
6.2. Du schéma N règles au principe unique
Au lieu de définir séparément :
 * Les 3 formes de spécialisation du jugement (Eq. 2, 3, 4),
 * Les 2 fonctions de la loi distributive (\phi et \psi),
 * Les 3 règles d'inclusion fonctorielle (F_{1\to 2}, F_{2\to 3}),
 * Les 5 mécanismes d'effacement de phase (grades, contraintes, typestate, existentielles, specs),
Le système se factorise en 1 principe et 3 instances :
 * Principe unique : Un unique monadique/comonadique gradué sur l'adjonction PBV F \dashv U, où la graduation est prise dans le produit cartésien d'algèbres ordonnées G \times \mathcal{E}.
 * Instances :
   * Instance Couche 3 : restriction de la graduation au point minimal d'effet (\mathcal{E} = \emptyset) et maximal de structure (G = Unr).
   * Instance Couche 2 : graduation restreinte à l'affinité (G = Aff) et aux effets coinductifs/productifs (\mathcal{E} = \text{tick}).
   * Instance Couche 1 : graduation restreinte à la linéarité stricte (G = Lin) et au budget physique borneur.
Tous les mécanismes d'effacement (§3.2) deviennent alors l'unique foncteur d'oubli de la graduation (effacement des coeffets et des indices de compilation lors de l'abaissement vers le calcul cible).
7. Verdict global
Réponses aux questions canoniques
 * Architecture conceptuelle réelle : Un langage fonctionnel typé par adjonction PBV graduée, traduisible vers un \pi-calcul à motifs de jonction, visant à éliminer le besoin d'un ramasse-miettes tout en garantissant des bornes de temps pire cas et le rejeu logique des exécutions.
 * Noyau théorique le plus fort : L'utilisation de l'appel par poussée de valeur (PBV) comme articulation structurelle pour faire coexister la dépendance des types aux valeurs, la traçabilité des coûts et la pureté des effets sans tomber dans l'inconsistance métathéorique.
 * Abstractions manquantes : L'adjonction graduée unifiée F_r \dashv U_\epsilon synthétisant coeffets et effets, et la formalisation stricte de la substitution d'indices dans la quantale.
 * Défauts bloquants : L'inversion de la relation de subtypage modal (Lin <: Aff <: Unr), qui détruit la sûreté mémoire et la garantie d'absence de courses de données s'il est implémenté tel quel.
 * Affirmations à affaiblir : La promesse de rejeu bit-à-bit sous P4 (à restreindre au rejeu logique ou à conditionner par un ordonnanceur consigné), et la prétention d'isolation sans MMU « par construction ».
┌──────────────────────────────────────────────────────────────────────────────────┐
│ EVALUATION QUALITATIVE GLOBALE DE LA SPECIFICATION K7PL                          │
├───────────────────┬──────────────────────────────────────────────────────────────┤
│ Dimension         │ Appréciation qualitative argumentée                          │
├───────────────────┼──────────────────────────────────────────────────────────────┤
│ Architecture      │ TRÈS ELEVÉE. Vision unificatrice remarquable via PBV et      │
│                   │ la sédimentation en trois couches. Le découpage est net.     │
├───────────────────┼──────────────────────────────────────────────────────────────┤
│ Cohérence         │ MOYENNE. Incohérence bloquante sur le subtypage modal [DEF-01]│
│                   │ et paramètre manquant dans la loi distributive [DEF-02].     │
├───────────────────┼──────────────────────────────────────────────────────────────┤
│ Solidité preuves  │ INCOMPLÈTE. Annexe E valable sur le fragment non-dép. mais   │
│                   │ dette de preuve majeure sur la substitution d'indices [DEF-04]│
├───────────────────┼──────────────────────────────────────────────────────────────┤
│ Factorisation     │ REDONDANTE. Triple présentation inutile de la sédimentation.  │
│                   │ Gain de 15% de taille possible par abstraction PBV unique.   │
├───────────────────┼──────────────────────────────────────────────────────────────┤
│ Mécanisabilité    │ BONNE. L'explicitation des trois routes d'engagements (R2)   │
│                   │ rend la spécification directement traduisible dans Agda/Coq. │
└───────────────────┴──────────────────────────────────────────────────────────────┘

Recommandation prioritaire : Corriger immédiatement la relation de subtypage modal (Unr <: Aff <: Lin) et intégrer la multiplicité d'itération dans l'algèbre des grades avant tout gel du jeu de règles de typage du Chapitre 3.
