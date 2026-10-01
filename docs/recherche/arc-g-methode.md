# Arc G — la méthode de nommage

*Phase d'ouverture, cinq temps. Écrite le 31 août 2026, AVANT toute lecture de l'arc.*

## CE QUI GOUVERNE CETTE MÉTHODE

> ***L'ARC G EXIGE UNE MÉTHODE, ET CETTE MÉTHODE EST ELLE-MÊME UN LIVRABLE.*** — *Anthea, 28 août*

Deux prérequis la précèdent et sont acquis. Le premier est celui de R-54 : écrire du pseudocode suppose une idée assez solide des mots, donc cette méthode vient avant l'écriture. Le second est celui de l'arc D, dont la clôture assurait la complétude des besoins de mots de fonctions à recenser.

Deux acquis l'attendaient, et ils fixent le cadre plutôt que le contenu.

|  |  |
|----|----|
| ***BERRY*** | *les conventions de nommage font partie de l'INTERFACE UTILISATEUR d'une bibliothèque ; le même nom pour la même opération partout ; et la convention typographique ne sert QUE là où le langage ne tranche pas lui-même* |
| ***APPEL*** | *le contre-exemple : « il n'y a aucune distinction syntaxique entre constructeurs et variables », donc un constructeur mal orthographié devient une variable qui filtre tout, et le compilateur l'accepte* |

De ces deux acquis suit l'ordre des temps : on ne juge une convention typographique qu'après avoir établi ce que le langage sépare lui-même. C'est pourquoi le temps 4 ouvre sur l'inventaire des espaces de noms, et non sur les critères esthétiques.

## TEMPS 1 — CONSTITUER LE PÉRIMÈTRE

### Ce qu'il faut nommer, et d'où la liste vient

Trois provenances, comme la doctrine les fixe, et chacune donne une catégorie de nature différente.

#### La part STRUCTURELLE — sortie du noyau, T-68

Le contrôle croisé de la grammaire et du jeu de règles la rend mécaniquement, sans arbitrage d'opinion : **trente-trois constructeurs de termes, dont neuf valeurs et vingt-quatre calculs**, gouvernés par trente-sept règles de typage dont quatre ne gouvernent aucun terme.

La revue des primitives les range en cinq familles, et c'est ce rangement qui donne les catégories de nommage plutôt que la liste plate :

|  |  |  |  |
|----|----|----|----|
| 1 | ***noyau CBPV*** | **7** | *variable, abstraction, application, suspension, forçage, retour, liaison séquentielle* |
| 2 | ***connecteurs*** | **8** | *unité et son élimination, paire et sa décomposition, injection et filtrage, conjonction additive et projection* |
| 3 | ***existentielle*** | **2** | *empaquetage, ouverture* |
| 4 | ***gradation*** | **2** | *entrée sous la modalité, sortie* |
| 5 | ***effets*** | **2** | *opération, gestionnaire* |

/Vingt et une entrées à la revue pour trente-trois constructeurs : l'écart est celui des formes indexées, du vecteur et des modalités temporelles, qui n'ont pas d'entrée propre à la revue. Le périmètre STRUCTUREL est donc de trente-trois, et le périmètre de FAMILLES est de cinq./

#### La part CALCULATOIRE — sortie de l'arc D

L'arc D est clos à douze questions sur quatorze, et sa sortie utile ici est négative autant que positive : elle borne ce qui doit être nommé en disant ce qui ne peut pas exister. La sédimentation y a reçu sa seconde lecture — elle n'ordonne pas seulement des garanties, elle ACCUEILLE ce que la couche supérieure refuse. Le périmètre calculatoire est donc à établir par couche, non globalement, et une opération refusée en couche 3 n'est pas absente du langage : elle est nommée ailleurs.

#### La part de RÉGIME — les couches et les grades

Trois couches, trois paires de délimiteurs, et un grade à quatre composantes.

|                |         |             |                                 |
|----------------|---------|-------------|---------------------------------|
| ***couche 1*** | `{ … }` | *linéaire*  | *capabilités, arène, transfert* |
| ***couche 2*** | `( … )` | *affine*    | *effets, sessions, acteurs*     |
| ***couche 3*** | `[ … ]` | *cartésien* | *pur, terminant, sur la pile*   |

Le grade porte l'usage, la marque de monotonie, le niveau de confidentialité et le budget. Chacune de ces quatre composantes est un axe de nommage : *les valeurs qu'elle prend doivent être nommées, et leur nom doit dire à quelle composante elles appartiennent.*

### Ce qui N'EST PAS au périmètre, et pourquoi le dire

Les glyphes de la couche 3 ne sont pas des primitives : le chapitre 5 l'établit, un glyphe est une MACRO de la bibliothèque standard, et son alias textuel n'est pas une autre notation mais un autre NOM DE LA MÊME MACRO. Ils appartiennent donc au temps 2, à un autre niveau, et non au périmètre du noyau. *Cette exclusion est le premier gain de la méthode : sans elle, on chercherait un nom de noyau pour chaque opération de bibliothèque, et le périmètre serait sans borne.*

## TEMPS 2 — ÉTABLIR LE BESOIN

### Trois niveaux, et la règle qui décide auquel une chose appartient

|  |  |
|----|----|
| ***PRIMITIVE DU NOYAU*** | *ce qu'une règle de typage gouverne et qu'aucune macro ne peut produire. Le contrôle croisé en fixe le nombre : trente-trois. Ce nombre ne se négocie pas au nommage — il se négocie à la revue primitive/dérivé, ailleurs* |
| ***MACRO DE BIBLIOTHÈQUE*** | *ce qui s'expanse en constructions du noyau. Nombre non borné a priori, et c'est là que la question du budget de vocabulaire se pose* |
| ***GLYPHE*** | *une ORTHOGRAPHE de macro, jamais un objet de plus. Le besoin en glyphes est donc un sous-ensemble du besoin en macros, jamais un besoin propre* |

**La règle de décision** : une chose est primitive si et seulement si une règle de typage la gouverne. Toute autre chose est macro. Un glyphe n'est jamais qu'une seconde orthographe d'une macro existante.

### Le besoin en NOMBRE, par catégorie

|  |  |  |  |
|----|----|----|----|
| ***structurel*** | *trente-trois constructeurs* | ***noms fixés par le noyau*** | *borné* |
| ***familles*** | *cinq* | *préfixes ou marques de famille* | *borné* |
| ***grades*** | *quatre composantes* | *les valeurs de chacune* | *borné* |
| ***couches*** | *trois* | *déjà nommées par les délimiteurs* | ***zéro nom nouveau*** |
| ***bibliothèque*** | *non borné* | *macro + glyphe optionnel* | ***À BUDGÉTER — c'est QG-20 et QG-21*** |

***LE SEUL POSTE NON BORNÉ EST LA BIBLIOTHÈQUE, ET C'EST DONC LE SEUL QUI DEMANDE UN BUDGET.*** *Les quatre autres sont fixés par la théorie, et le nommage y est un travail de choix, non de dimensionnement.*

## TEMPS 3 — COLLECTER

### Ce qu'il faut collecter

Pour chaque catégorie du temps 1, les noms que les langages du corpus emploient pour la même chose. La doctrine en nomme huit : APL, BQN, Uiua, Scheme, ML, Haskell, Clojure, Rust.

### Inventaire de DISPONIBILITÉ, établi le 31 août

|  |  |  |
|----|----|----|
| ***APL*** | **43 pièces** | *disponible, avec les manuels de référence et les recueils d'idiomes* |
| ***Scheme et Lisp*** | **178** | *largement disponible* |
| ***Haskell*** | **105** | *largement disponible* |
| ***ML et OCaml*** | **33** | *disponible* |
| ***Rust*** | **26** | *disponible* |
| ***Forth et Factor*** | **25** | *disponible* |
| ***Clojure*** | **3** | *mince mais présent, dont l'histoire du langage* |
| ***BQN*** | ***ZÉRO*** | ***ABSENT DU FONDS*** |
| ***Uiua*** | ***ZÉRO*** | ***ABSENT DU FONDS*** |

***DEUX DES TROIS LANGAGES SUR LESQUELS LE CHAPITRE 5 FONDE SA NOTATION TACITE SONT ABSENTS DU FONDS.*** /Le chapitre écrit que les glyphes de la couche 3 sont « hérités à travers APL puis BQN et Uiua » ; seule la source d'APL est là. La seule pièce du fonds qui touche la tradition combinatoire des langages de tableaux modernes est un mémoire de maîtrise, déjà dépouillé à l'arc E, et il survole BQN sans en être une source./ **Consigné comme manque de corpus.** /Le temps 3 est donc conduisible pour sept catégories sur neuf, et la collecte des glyphes — qui est le poste le plus visible du chapitre 5 — est celle qui manque de sources./

### L'ordre de la collecte

Par CATÉGORIE et non par langage : pour chaque constructeur du noyau, relever le nom dans chacun des langages disponibles, puis passer au suivant. Collecter langage par langage produirait des listes incomparables.

## TEMPS 4 — ÉVALUER ET COMPARER

### ITEM OBLIGATOIRE, et il vient avant les critères : l'inventaire des espaces de noms

/La doctrine le pose : « combien K7PL a-t-il d'espaces de noms, lesquels se recouvrent, et lesquels le langage sépare-t-il lui-même ? » C'est le contre-exemple d'Appel qui commande, et l'acquis de Berry qui en fait le préalable — la convention typographique ne sert QUE là où le langage ne tranche pas lui-même./

**Inventaire établi sur le texte, le 31 août.**

|  |  |  |  |
|----|----|----|----|
| ***1*** | ***variables*** | *liaisons ordinaires, `let`, abstractions* | — |
| ***2*** | ***étiquettes*** | *introduites par le deux-points de tête* | ***séparé LEXICALEMENT*** |
| ***3*** | ***cinq mots-clés*** | `pure`, `terminates`, `event`, `contract`, `logic` | ***séparé PAR POSITION*** |
| ***4*** | ***macros de bibliothèque*** | *glyphe et alias textuel* | ***UN SEUL espace, deux orthographes*** |
| ***5*** | ***modifieurs tacites*** | `´`, `¨`, `⊸` | ***COLLISION connue*** |
| ***6*** | ***types*** | *position syntaxique propre* | *séparé par la position* |
| ***7*** | ***effets et opérations*** | *portés par la trace* | *séparé par le jugement* |
| ***8*** | ***champs et composants*** | *arène en tableau de structures inversé* | *séparé par la structure* |
| ***9*** | ***espaces de noms de modules*** | *restriction du graphe de dépendances à une dimension* | *séparé par le graphe* |
| ***10*** | ***sigils*** | `#` pour l'évaluation à la compilation | ***COLLISION d'intention connue*** |

#### Ce que l'inventaire rend, et c'est favorable

***LE LANGAGE SÉPARE LUI-MÊME DANS TOUS LES CAS OÙ LE RECOUVREMENT SERAIT DANGEREUX.*** Les cinq mots-clés recouvrent volontairement les variables et sont séparés par la POSITION — ils ne sont réservés qu'en tête de S-expression, précisément pour ne pas restreindre leur emploi comme noms ordinaires ailleurs. Les étiquettes sont séparées par une marque LEXICALE, le deux-points de tête. Le glyphe et son alias ne se recouvrent pas : ils sont le même objet. \*/Le piège d'Appel est donc fermé par construction là où il mordait — un constructeur mal orthographié est une étiquette mal orthographiée, et une étiquette inconnue est une erreur, non une variable qui filtre tout./\* *Encore faut-il que le document l'ÉCRIVE : c'est l'item C3 du programme d'ajustement, la règle des étiquettes étant en usage et jamais énoncée.*

#### Les DEUX collisions connues, et elles sont déjà au programme

|  |  |  |
|----|----|----|
| ***C8*** | `⊸` | *implication linéaire ET alias de liaison à gauche. Le symbole ne bouge pas — il est de Girard — donc l'emprunt à la notation tacite cède* |
| ***C9*** | `#` | *l'évaluation à la compilation est écrite ; « croisillon ou nombre » est une intention. La charge de bouger revient à l'intention* |

*Aucune autre collision n'a été trouvée. C'est un résultat, non une absence de recherche : les dix espaces ont été passés un par un.*

### LES CRITÈRES, dans l'ordre où ils s'appliquent

/Ils ne se pondèrent pas : ils s'appliquent en séquence, et un nom qui échoue à l'un ne passe pas au suivant. La doctrine le pose pour les deux contrôles finaux — un mot utile qui ne passe pas la vérification théorique n'entre pas — et le principe vaut pour toute la chaîne./

|  |  |  |
|----|----|----|
| ***0*** | ***NON-COLLISION*** | *le nom n'entre en collision dans aucun des dix espaces, ou la collision est levée par une séparation que le LANGAGE porte. Éliminatoire* |
| ***1*** | ***COHÉRENCE DE FAMILLE*** | *deux opérations de la même famille des cinq portent des noms de même forme. C'est la règle de Berry — le même nom pour la même opération partout — appliquée à l'échelle de la famille* |
| ***2*** | ***COMPORTEMENT SOUS LES GRADES*** | *le nom reste juste quand la composante d'usage change. Un nom qui suppose l'unicité ne convient pas à une opération graduée. Critère PROPRE à K7PL, qu'aucun langage du corpus n'a eu à poser* |
| ***3*** | ***MNÉMONIQUE*** | *devinable sans connaître le langage. C'est le critère que le corpus empirique instruit, et le seul dont l'arc puisse rendre des MESURES plutôt que des avis* |
| ***4*** | ***BRIÈVETÉ*** | *vient en dernier, et non en premier. Une brièveté qui coûte la devinabilité est un mauvais échange, et le corpus donne de quoi le chiffrer* |

***L'ORDRE COMPTE ET IL EST L'INVERSE DE L'ORDRE SPONTANÉ.*** /On choisit spontanément par brièveté puis on vérifie les collisions ; ici on élimine par collision, on range par famille, on éprouve sous les grades, et la brièveté ne tranche qu'entre survivants./

## TEMPS 5 — CHOISIR

### La forme de l'arbitrage

/La doctrine fixe le point qui compte : le choix doit dire ce qu'il rend SUPERFLU, non ce qu'il interdit. C'est la forme que le projet emploie déjà pour ses arbitrages théoriques, et elle se transporte ici sans changement./

Un arbitrage de nommage porte donc quatre choses, et pas une de moins :

|  |  |  |
|----|----|----|
| 1 | ***LE NOM RETENU*** | *et son niveau — primitive, macro, glyphe* |
| 2 | ***LES NOMS ÉCARTÉS*** | *avec, pour chacun, le critère auquel il a échoué et le rang de ce critère* |
| 3 | ***CE QUE LE CHOIX REND SUPERFLU*** | *quelle autre construction, quelle autre convention, quelle autre règle devient inutile parce que ce nom-ci a été pris* |
| 4 | ***LA TRACE*** | *date, et la source de chaque nom collecté* |

### Les deux contrôles finaux, et ils sont deux et non un

> ***LE FOISONNEMENT VIENT EN DERNIER, ET IL EST SOUMIS À DEUX CONTRÔLES, NON UN. Un mot utile qui ne passe pas la vérification théorique n'entre pas.***

|  |  |
|----|----|
| ***CONTRÔLE D'UTILITÉ*** | *le mot sert-il à quelque chose qu'on écrit réellement ? Instruit par les programmes de R-54, donc APRÈS que la méthode a livré ses mots* |
| ***CONTRÔLE THÉORIQUE*** | *le mot désigne-t-il un objet que la théorie porte ? Un nom sans règle de typage ni expansion de macro ne désigne rien* |

*Le second est éliminatoire et le premier ne l'est pas : un mot théoriquement fondé mais peu employé reste ; un mot utile mais sans fondement ne rentre pas.*

## CE QUE CETTE PHASE A DÉJÀ PRODUIT, avant toute lecture

|  |  |
|----|----|
| 1 | ***Le périmètre structurel est BORNÉ et connu : trente-trois constructeurs, cinq familles*** |
| 2 | ***Un seul poste de nommage est non borné — la bibliothèque — donc un seul demande un budget*** |
| 3 | ***Les glyphes sortent du périmètre du noyau : ce sont des orthographes de macros, pas des objets*** |
| 4 | ***Dix espaces de noms recensés ; le langage sépare lui-même partout où le recouvrement mordrait*** |
| 5 | ***Deux collisions connues, toutes deux déjà au programme d'ajustement — et aucune autre*** |
| 6 | ***Un critère PROPRE à K7PL qu'aucun langage du corpus n'a eu à poser : le comportement sous les grades*** |
| 7 | ***Un manque de corpus : BQN et Uiua, deux des trois sources nommées de la notation tacite, sont absents du fonds*** |

*Le septième est le seul qui coûte. Les six autres réduisent le travail de l'arc plutôt qu'ils ne l'augmentent, ce qui est ce qu'une phase d'ouverture doit faire.*
