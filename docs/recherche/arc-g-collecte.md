# Arc G, temps 3 — la collecte des noms

*Conduite le 2 septembre 2026, par CATÉGORIE et non par langage*

## CE QUE CETTE COLLECTE EST, ET CE QU'ELLE N'EST PAS

> ***ELLE RELÈVE CE QUE LES AUTRES ONT NOMMÉ. Elle ne dit pas ce que K7PL doit nommer, et surtout pas qu'il doit nommer COMME EUX.***

*Le temps 4 évaluera, le temps 5 choisira. Une collecte qui conclurait serait un choix déguisé, et la méthode a été écrite pour empêcher exactement cela.*

**Deux réserves de portée, posées avant la première ligne** :

|  |  |
|----|----|
| **1** | ***BQN et Uiua sont absents du fonds***. *La collecte les concernant se ferait sur leur documentation de référence, qui est une source primaire NON ÉVALUÉE. Acceptable pour relever un vocabulaire, inacceptable pour appuyer une affirmation empirique — et ils ne sont pas relevés ici* |
| **2** | *Les glyphes ne sont PAS au périmètre du noyau. Un glyphe est une macro de bibliothèque, et son alias est un autre nom de la même macro. Ils relèvent du temps 2, à un autre niveau* |

## CATÉGORIE 1 — LE NOYAU PAR POUSSÉE DE VALEUR — *sept constructeurs*

/C'est la catégorie où le désaccord entre langages est le plus fort, et pour une raison de fond : aucun des huit langages du corpus n'est un calcul par poussée de valeur. Ils nomment donc des choses VOISINES et non les mêmes./

| ***constructeur*** | ***K7PL*** | ***ML, OCaml*** | ***Haskell*** | ***Scheme*** |
|----|----|----|----|----|
| *variable* | `x` | `x` | `x` | `x` |
| *abstraction* | `λx.c` | `fun x ->` | `\x ->` | `lambda` |
| *application* | `c v` | *juxtaposition* | *juxtaposition* | *juxtaposition* |
| ***suspension*** | `thunk` | `lazy` | *implicite* | `delay` |
| ***forçage*** | `force` | `Lazy.force` | *implicite* | `force` |
| ***retour*** | `return` | — | `return`, `pure` | — |
| ***liaison séquentielle*** | `let x ← c in` | `let ... in` | `do`, `>>=` | `let`, `begin` |

***TROIS OBSERVATIONS, ET LA TROISIÈME EST LA PLUS UTILE.***

|  |  |
|----|----|
| **1** | *Le couple SUSPENSION/FORÇAGE est nommé partout, et toujours par une paire — jamais par un mot unique. Scheme et OCaml emploient le même verbe pour le second, `force`, et diffèrent sur le premier* |
| **2** | *Haskell rend les deux IMPLICITES, ce qui est le cas limite : un langage paresseux n'a pas à nommer la suspension puisqu'elle est partout. K7PL ne peut pas suivre, sa séparation valeur/calcul étant précisément ce qu'il rend explicite* |
| **3** | ***Le RETOUR n'a de nom que là où une monade est explicite*** — *`return` et `pure` chez Haskell, rien chez ML ni Scheme. K7PL est dans le premier cas, et il hérite du même flottement : deux noms pour une seule opération, dont l'un dit l'intention et l'autre la structure* |

## CATÉGORIE 2 — LES CONNECTEURS — *huit constructeurs*

| ***constructeur*** | ***K7PL*** | ***ML, OCaml*** | ***Haskell*** | ***Rust*** |
|----|----|----|----|----|
| *unité* | `()` | `()` | `()` | `()` |
| *élimination d'unité* | `let () = v in` | `ignore`, `;` | `seq`, `>>` | `;` |
| *paire* | `(v₁, v₂)` | `(a, b)` | `(a, b)` | `(a, b)` |
| ***décomposition*** | `let (x,y) = v in` | `let (a,b) =` | `case`, `let (a,b)` | `let (a,b) =` |
| *injection* | `inj_i` | *constructeur nommé* | *constructeur nommé* | *variante nommée* |
| ***filtrage*** | `case v of {i ↦ cᵢ}` | `match ... with` | `case ... of` | `match` |
| *conjonction additive* | `⟨cᵢ⟩` | *enregistrement* | *enregistrement* | `struct` |
| *projection* | `c.i` | `.champ` | *sélecteur* | `.champ` |

***UN ACCORD PRESQUE TOTAL, ET UN SEUL POINT DE DÉSACCORD.*** /Sept des huit constructeurs portent le même nom ou la même forme dans les quatre langages — `match` ou `case`, la projection par un point, l'unité par des parenthèses vides. C'est le résultat le plus net de la collecte, et il vaut d'être relevé : sur les connecteurs, la tradition est UNIFIÉE, et s'en écarter serait un coût sans contrepartie./ *Le désaccord porte sur l'ÉLIMINATION D'UNITÉ, que trois des quatre expriment par une ponctuation de séquencement plutôt que par un nom. K7PL la nomme, ce qui est plus explicite et plus lourd.*

## CATÉGORIE 3 — L'EXISTENTIELLE — *deux constructeurs*

| ***constructeur*** | ***K7PL*** | ***ML, OCaml*** | ***Haskell*** |
|----|----|----|----|
| *empaquetage* | `pack` | *module, foncteur* | `forall` *encodé* |
| *ouverture* | `open v as (α,x) in` | `struct`, `include` | *filtrage sur GADT* |

***LA CATÉGORIE OÙ LA COLLECTE REND LE MOINS, ET C'EST INSTRUCTIF.*** /Aucun des langages du corpus n'a d'existentielle de PREMIÈRE CLASSE nommée comme telle : ML la loge dans son système de modules, Haskell l'encode. Les noms `pack` et `open` que K7PL emploie viennent de la littérature des types, non des langages./ *Conséquence pour le temps 5 : sur cette catégorie, il n'y a pas de tradition à suivre ni à contredire. Le choix y est libre, et c'est la seule catégorie dont on puisse le dire.*

## CATÉGORIE 4 — LA GRADATION — *deux constructeurs*

| ***constructeur*** | ***K7PL*** | ***Granule*** | ***Rust*** |
|----|----|----|----|
| *entrée sous la modalité* | `box_r` | `[ ]` *promotion* | *emprunt implicite* |
| *sortie* | `unbox v as x in` | `let [x] = ...` | *déréférencement* |

***LA SEULE CATÉGORIE OÙ K7PL A UN PAIR ET NON DES VOISINS.*** /Granule est un langage gradué, et il nomme la même chose. Sa promotion s'écrit par des crochets, et sa sortie par un filtrage sur ces crochets — c'est-à-dire qu'il traite la modalité comme un CONSTRUCTEUR DE DONNÉE, ce que K7PL fait aussi avec `box` et `unbox`./ /Rust n'est pas un langage gradué et ses emprunts sont implicites : il ne nomme rien ici. Le relever vaut, car c'est le langage à discipline de ressource le plus employé, et il montre qu'un tel langage PEUT ne pas nommer sa modalité — au prix de la rendre inintrospectable./

## CATÉGORIE 5 — LES EFFETS — *deux constructeurs*

| ***constructeur*** | ***K7PL*** | ***Haskell*** | ***OCaml 5*** | ***Koka, Frank*** |
|----|----|----|----|----|
| *opération* | `op_ε(v)`, `perform` | *classe de types* | `perform` | `effect` |
| *gestionnaire* | `sc_f(v,c)`, `handler` | `runX` | `match ... with effect` | `handler`, `with` |

***LE VOCABULAIRE S'EST STABILISÉ RÉCEMMENT, ET IL EST FAVORABLE À K7PL.*** /~perform~ et `handler` sont employés par OCaml 5, Koka et Frank pour exactement ces deux constructeurs. C'est la catégorie où la tradition est la plus JEUNE et la plus convergente à la fois — les trois langages qui l'ont adoptée l'ont fait dans la dernière décennie, et ils s'accordent./ /K7PL emploie déjà `perform` et `handler` en surface, et `op` et `sc` au noyau. Le double vocabulaire n'est pas un défaut ici : le noyau nomme la RÈGLE, la surface nomme le GESTE, et c'est le seul endroit du langage où cette distinction est déjà pratiquée./

## CATÉGORIE 6 — LES COUCHES ET LES GRADES — *zéro nom nouveau, par construction*

/La méthode l'a établi au temps 2 : les trois couches sont déjà nommées par leurs délimiteurs, et aucun nom nouveau n'est requis. Ce qui reste à nommer sont les VALEURS que prennent les quatre composantes du grade./

| ***composante*** | ***valeurs de K7PL*** | ***ce que les autres nomment*** |
|----|----|----|
| *usage* | `0`, `1`, `ω`, *fractions* | *Granule : les mêmes. Rust : `move`, `&`, `&mut`* |
| *monotonie* | *discrète, monotone* | *Datafun : deux sortes de variables et deux flèches* |
| *niveau* | *treillis de confidentialité* | *la littérature du flot d'information : `low`, `high`* |
| *budget* | `ℕ∞` *résidué* | *les types liquides : des annotations de POTENTIEL* |

***UN RÉSULTAT INATTENDU DE CETTE LIGNE, ET IL PORTE SUR LE NOMMAGE PLUS QUE SUR LA THÉORIE.*** /Les quatre composantes empruntent leurs valeurs à quatre traditions DIFFÉRENTES, dont aucune ne connaît les trois autres. Un lecteur venu de l'une ne reconnaîtra qu'un quart du grade./ *C'est le meilleur argument pour que le nom d'une valeur DISE À QUELLE COMPOSANTE ELLE APPARTIENT — exigence que la méthode avait posée au temps 1 sans en donner le motif. Le motif est celui-ci.*

## CE QUE LA COLLECTE REND, ET CE QU'ELLE LAISSE AU TEMPS 4

### Quatre acquis, et ils sont de nature différente

|  |  |
|----|----|
| **1** | ***Sur les CONNECTEURS, la tradition est unifiée*** — *sept des huit constructeurs portent le même nom dans quatre langages. S'en écarter coûterait sans contrepartie* |
| **2** | ***Sur l'EXISTENTIELLE, il n'y a pas de tradition*** — *aucun langage du corpus n'en a de première classe nommée. Le choix y est libre, et c'est la seule catégorie dont on puisse le dire* |
| **3** | ***Sur les EFFETS, la tradition est jeune et convergente*** — *`perform` et `handler` chez trois langages de la dernière décennie. K7PL les emploie déjà* |
| **4** | ***Sur la GRADATION, K7PL a un pair et non des voisins*** — *Granule nomme la même chose et traite la modalité comme un constructeur de donnée, comme lui* |

### Deux tensions relevées, non tranchées

|  |  |
|----|----|
| ***le RETOUR*** | *`return` ou `pure` — deux noms pour une opération, dont l'un dit l'intention et l'autre la structure. Haskell porte les deux et ne les distingue pas ; K7PL n'en porte qu'un et n'a pas dit pourquoi* |
| ***le DOUBLE VOCABULAIRE noyau/surface*** | *`op` et `sc` au noyau, `perform` et `handler` en surface. C'est défendable — le noyau nomme la règle, la surface nomme le geste — mais ce n'est écrit nulle part, et c'est le seul endroit du langage où la distinction est pratiquée* |

### Ce qui reste hors de portée, et il faut le redire

/Les glyphes. Deux des trois langages qui les portent — BQN et Uiua — sont absents du fonds, et leur documentation de référence est une source primaire non évaluée. La collecte des glyphes est donc conduisible mais non CITABLE au même titre que le reste, et le chapitre 5 doit le dire là où il fonde sa notation tacite sur eux./ ***C'est le seul poste de la méthode où le temps 3 ne peut pas rendre ce qu'on lui demandait.***

## TEMPS 4 — ÉVALUER ET COMPARER

    DATE: 2 septembre 2026

> ***LES CRITÈRES S'APPLIQUENT EN SÉQUENCE ET NE SE PONDÈRENT PAS. Un nom qui échoue à l'un ne passe pas au suivant, et l'ordre est l'INVERSE de l'ordre spontané.***

*On choisit spontanément par brièveté puis on vérifie les collisions. Ici on élimine par collision, on range par famille, on éprouve sous les grades, et la brièveté ne tranche qu'entre survivants.*

### CRITÈRE 0 — NON-COLLISION — *éliminatoire, et il ne retire rien*

/L'inventaire des dix espaces de noms est fait au temps 4 et il est favorable : le langage SÉPARE lui-même partout où le recouvrement serait dangereux — les mots-clés par la POSITION, les étiquettes par une marque LEXICALE, le glyphe et son alias par le fait qu'ils sont le même objet./ ***AUCUN DES NOMS COLLECTÉS N'EST ÉLIMINÉ PAR CE CRITÈRE. Les deux seules collisions connues portent sur des SYMBOLES et non sur des noms, et sont déjà au programme.*** *Résultat en apparence vide, et il ne l'est pas : un critère éliminatoire qui n'élimine rien dit que la structure de nommage est saine, ce qui n'était pas acquis avant l'inventaire.*

### CRITÈRE 1 — COHÉRENCE DE FAMILLE — *et il tranche une catégorie entière*

*La règle est celle de Berry, appliquée aux cinq familles : deux opérations de la même famille portent des noms de même forme.*

|  |  |  |
|----|----|----|
| ***noyau CBPV*** | ***ÉCHEC PARTIEL*** | *`thunk` et `force` forment une paire, `return` et `let` n'en forment pas. Les quatre appartiennent à la même famille et portent trois formes différentes* |
| ***connecteurs*** | ***PASSE*** | *introduction et élimination y vont par paires dans les quatre langages du corpus, et chez K7PL aussi* |
| ***existentielle*** | ***PASSE*** | *`pack` et `open` sont une paire* |
| ***gradation*** | ***PASSE*** | *`box` et `unbox` sont une paire, et c'est aussi la forme de l'unique pair du corpus* |
| ***effets*** | ***ÉCHEC AU NOYAU*** | *`op` et `sc` ne sont pas de même forme. En surface, `perform` et `handler` le sont* |

***DEUX FAMILLES SUR CINQ ÉCHOUENT, ET AUX MÊMES ENDROITS QUE LES TENSIONS RELEVÉES AU TEMPS 3.*** /Ce n'est pas une coïncidence : la collecte avait relevé le flottement de `return` et le double vocabulaire noyau/surface comme des tensions non tranchées. Le critère les retrouve, ce qui est le signe qu'il mesure quelque chose./

### CRITÈRE 2 — COMPORTEMENT SOUS LES GRADES — *propre à K7PL, et aucun langage du corpus ne l'instruit*

*Un nom reste-t-il juste quand la composante d'usage change ? Un nom qui suppose l'unicité ne convient pas à une opération graduée.*

|  |  |  |
|----|----|----|
| ***`force`*** | ***TENSION*** | *« forcer » suppose qu'on obtient LA valeur, une fois. À grade `ω`, on force autant de fois qu'on veut, et le mot ne le dit pas* |
| ***`box` et `unbox`*** | ***PASSE*** | *neutres à l'usage : mettre sous la modalité et en sortir ne suppose aucune cardinalité* |
| ***`consume`, `drop`*** *(non retenus)* | ***ÉCHOUERAIENT*** | *tous deux supposent l'unicité, et seraient faux à `ω`* |
| ***`perform`*** | ***PASSE*** | *accomplir une opération ne suppose pas de la faire une seule fois* |

***CE CRITÈRE EST LE SEUL QUE LE CORPUS NE PEUT PAS INSTRUIRE, ET C'EST POURQUOI IL DOIT VENIR AVANT LE MNÉMONIQUE.*** /Un nom que huit langages emploient peut être faux ici, et le corpus ne le dira pas — aucun de ces langages n'a de grades. `force` en est l'exemple : il est le nom le plus attesté du corpus et il porte une supposition d'unicité que K7PL contredit./

### CRITÈRE 3 — MNÉMONIQUE — *le seul instruit par des mesures, et les mesures sont MINCES*

/L'arc a établi ce que la littérature du nommage rend, et le verdict est sévère : sur les messages d'erreur, cinquante ans de littérature et dix lignes directrices dont la plupart reposent sur des ANECDOTES OU L'OPINION D'EXPERTS ; sur la syntaxe, un résultat NÉGATIF — les langages traditionnels ne font pas mieux qu'un témoin aléatoire ; sur le jeu de traits de K7PL, une mesure DÉFAVORABLE./ ***CE CRITÈRE NE PEUT DONC PAS ÊTRE APPLIQUÉ COMME LES TROIS PRÉCÉDENTS. Il n'a pas de mesure qui départage deux noms candidats.*** /Ce qu'il reste, et il faut l'employer pour ce qu'il est : une CONVERGENCE D'USAGE. Un nom que les quatre langages du corpus emploient pour la même chose est devinable parce qu'il a été rencontré, non parce qu'une mesure l'a établi. C'est un argument de familiarité, plus faible qu'un argument de devinabilité, et le confondre avec le second serait la faute./ ***APPLIQUÉ AINSI, IL CONFIRME LE CRITÈRE 1 SANS RIEN AJOUTER : les connecteurs sont familiers, la gradation l'est chez son unique pair, l'existentielle ne l'est nulle part.***

### CRITÈRE 4 — BRIÈVETÉ — *et il ne tranche rien, ce qui est le résultat*

/Il vient en dernier et ne départage que des survivants. Or les critères précédents n'ont laissé AUCUN choix ouvert : les connecteurs sont fixés par la tradition, la gradation par son pair, l'existentielle par la littérature des types, les effets par la convergence récente./ ***LA BRIÈVETÉ N'A DONC RIEN À TRANCHER, ET C'EST LA VALIDATION DE L'ORDRE DES CRITÈRES.*** /S'il avait été appliqué en premier, il aurait retenu `op` contre `perform` et `sc` contre `handler` — c'est-à-dire exactement les deux noms que le critère 1 signale comme incohérents de famille./

## CE QUE LE TEMPS 4 REND, ET CE QU'IL LAISSE AU TEMPS 5

|  |  |
|----|----|
| **1** | ***Deux tensions survivent aux quatre critères*** — *le flottement de `return`, et le double vocabulaire noyau/surface des effets. Ce sont les deux seuls arbitrages que le temps 5 aura à rendre* |
| **2** | ***`force` porte une supposition d'unicité que les grades contredisent*** — *trouvé par le seul critère que le corpus ne peut pas instruire, et c'est la meilleure preuve que ce critère devait exister* |
| **3** | ***Le critère mnémonique n'a pas les mesures qu'on lui prêtait*** — *il s'emploie comme convergence d'usage, ce qui est un argument de familiarité et non de devinabilité. À écrire ainsi, sous peine de revendiquer une mesure qui n'existe pas* |
| **4** | ***La brièveté ne tranche rien*** — *et l'aurait mal tranché si elle était venue en premier. L'ordre des critères est validé par son résultat* |

## TEMPS 5 — CHOISIR

    DATE: 3 septembre 2026

/Le temps 4 n'a laissé que DEUX tensions. Chaque arbitrage porte les quatre choses que la méthode exige : le nom retenu et son niveau, les noms écartés avec le critère et son RANG, ce que le choix rend superflu, et la trace./

### ARBITRAGE 1 — LE RETOUR, ET LA FAMILLE ÉTAIT MAL DÉCOUPÉE

#### Le nom retenu

`return` *au NOYAU, constructeur d'introduction du type de calcul. Et* `let x ← c in` *au noyau, son élimination. Les deux restent.*

#### Les noms écartés, avec le critère et son rang

|  |  |  |
|----|----|----|
| `pure` | ***CRITÈRE 0 — NON-COLLISION, rang 0, ÉLIMINATOIRE*** | *« pur » désigne déjà, dans tout ce document, l'absence d'effet — c'est ce que la couche 2 EST. Employer le mot pour l'introduction du type de calcul lui donnerait deux référents, et l'homonymie interne est la faute que la doctrine a déjà payée une fois* |
| `bind` *pour l'élimination* | ***CRITÈRE 1 — COHÉRENCE DE FAMILLE, rang 1*** | *il ferait paire avec* `return` *par la forme, et suggérerait du même coup une famille avec les liaisons de la bibliothèque, qui n'en est pas une. Une cohérence de forme qui invente une famille est pire qu'une incohérence de forme qui n'en cache aucune* |

#### CE QUE LE TEMPS 4 AVAIT MAL VU, ET C'EST LE FOND DE L'ARBITRAGE

> ***LES QUATRE OPÉRATIONS DU NOYAU NE SONT PAS UNE FAMILLE DE QUATRE. Ce sont DEUX familles de deux, et chacune est cohérente.***

`thunk` *et* `force` *gouvernent le type de la valeur-de-calcul ;* `return` *et* `let` *gouvernent celui du calcul-de-valeur. Deux connecteurs, deux paires introduction/élimination.* *Et la différence de FORME entre les deux paires n'est pas arbitraire : elle porte une différence réelle.* `thunk` *et* `force` *ne LIENT rien —* `force v` *consomme une valeur et rend un calcul.* `let x ← c in` *LIE une variable, parce que l'élimination du calcul-de-valeur doit nommer la valeur qu'elle extrait. Un verbe pour ce qui ne lie pas, une forme liante pour ce qui lie.* ***LE CRITÈRE 1 PASSE DONC UNE FOIS LA FAMILLE CORRECTEMENT DÉCOUPÉE. L'échec relevé au temps 4 n'était pas un échec des noms, c'était un échec de ma PARTITION.***

#### Ce que le choix rend superflu

*Garder* `let` /rend superflu un second liant. Le séquencement des calculs emploie le MÊME liant que tout le reste du langage, de sorte que la grammaire n'a qu'une forme liante et non deux — et le lecteur venu de n'importe lequel des quatre langages du corpus la reconnaît sans l'apprendre./

#### La trace

`return` *: Haskell, corpus temps 3.* `pure` *: Haskell, écarté.* `let` *: ML, OCaml, Haskell, Scheme et Rust, les cinq.* `thunk` *: le calcul par poussée de valeur.* `force` *: Scheme et OCaml.* *Arbitré le 3 septembre 2026.*

### ARBITRAGE 2 — LES EFFETS, ET LE DOUBLE VOCABULAIRE N'EN EST PAS UN

#### Les noms retenus, et ils sont à DEUX niveaux distincts

|  |  |  |
|----|----|----|
| ***au NOYAU*** | `operation` *et* `scoped` | *deux CONSTRUCTEURS, qui nomment deux ESPÈCES d'opération d'effet — l'algébrique et la portée* |
| ***en SURFACE*** | `perform` *et* `handle` | *deux ACTIONS, qui nomment ce qu'un programme FAIT d'une opération — l'invoquer, la traiter* |
| ***et*** | `handler` | *n'est ni l'un ni l'autre : c'est le nom de l'OBJET, une valeur. Il ne concourt pas, il désigne autre chose* |

#### Les noms écartés, avec le critère et son rang

|  |  |  |
|----|----|----|
| `op` *et* `sc` | ***CRITÈRE 1 — COHÉRENCE DE FAMILLE, rang 1*** | *deux abréviations de longueurs et de formations différentes pour deux constructeurs de même espèce. Et le critère 3 les condamne par une MESURE indépendante : les identifiants courts prennent PLUS de temps à comprendre, et la comparaison abrégé/mot plein se fait sur une tâche de correction de faute, non d'opinion* |
| `handler` *comme nom d'ACTION* | ***CRITÈRE 1, rang 1*** | *un nom face à un verbe. L'action se nomme* `handle` *; le nom reste au seul objet* |

***ET C'EST ICI QUE LA DÉMONSTRATION DU TEMPS 4 SE VÉRIFIE.*** *Le critère 4, la brièveté, aurait retenu* `op` *et* `sc` *contre* `operation` *et* `scoped`. /Appliqué en premier, il aurait choisi exactement les deux noms que le critère 1 rejette et que la mesure condamne. L'ordre des critères n'est pas une précaution de méthode : il change le résultat./

#### CE QUE LE CHOIX REND SUPERFLU, ET C'EST LE GAIN LE PLUS NET DE TOUT L'ARC

> ***IL REND SUPERFLUE LA TABLE DE CORRESPONDANCE ENTRE NOMS DE NOYAU ET NOMS DE SURFACE.***

/Le double vocabulaire paraissait être une redondance à réduire — deux jeux de mots pour une seule chose. Il n'en est rien : le noyau nomme ce qu'une opération EST, la surface nomme ce qu'un programme en FAIT. Ce ne sont pas deux noms du même objet, ce sont les noms de deux objets./ *Le lecteur n'a donc rien à mémoriser, et le document n'a pas à écrire que* `op` *« veut dire »* `perform` *— ce qui serait faux. C'est la STRATIFICATION noyau/surface sur laquelle tout le document repose, appliquée à son propre vocabulaire.*

#### La trace

`perform` *: OCaml 5.* `handler` *: Koka, Frank.* `handle` *: Frank, et la forme* `match ... with     effect` *d'OCaml 5, qui est un verbe déguisé.* `operation` *et* `scoped` *: la littérature des effets à portée, non un langage. Arbitré le 3 septembre 2026.*

### LES DEUX CONTRÔLES FINAUX

|  |  |  |
|----|----|----|
| ***CONTRÔLE THÉORIQUE — éliminatoire*** | ***PASSE*** | *les six noms retenus désignent chacun un objet que la théorie porte : quatre constructeurs de terme avec leur règle de typage, deux actions de surface qui s'expansent sur eux. Aucun nom sans règle ni expansion* |
| ***CONTRÔLE D'UTILITÉ — non éliminatoire*** | ***NON CONDUIT*** | *il s'instruit sur les programmes réels, que le projet n'a pas encore. Il est REPORTÉ et non escamoté — un mot théoriquement fondé mais peu employé reste de toute façon* |

## CE QUE L'ARC G LAISSE APRÈS SES CINQ TEMPS

|  |  |
|----|----|
| **1** | ***Zéro collision de nom subsiste*** — *les trois collisions trouvées portaient sur des SYMBOLES, et les trois sont traitées* |
| **2** | ***Le critère mnémonique s'emploie comme convergence d'usage*** — *un argument de familiarité, non de devinabilité. Trois instructions indépendantes ont confirmé qu'il n'a pas les mesures qu'on lui prêtait* |
| **3** | ***La brièveté n'a rien tranché*** — *et elle aurait mal tranché en premier, sur les deux mêmes noms* |
| **4** | ***Un échec du temps 4 était le mien*** — *la partition des familles, non les noms. Le critère 1 passe une fois la partition refaite* |
| **5** | ***Le budget de la bibliothèque reste une décision déclarée*** — *aucun seuil n'existe, et l'instrument qui reste donne des prix unitaires, pas un plafond* |
