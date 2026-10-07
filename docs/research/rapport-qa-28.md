# QA-28 — toute liaison a-t-elle besoin des quatre composantes du grade ?

*Rapport d'instruction, 2 septembre 2026 — confronté aux postulats, puis à l'axiome, puis au manuscrit*

## CE QUE L'INSTRUCTION A CHANGÉ À LA QUESTION, AVANT D'Y RÉPONDRE

> ***LA QUESTION EN CONTIENT DEUX, ET ELLES N'ONT NI LE MÊME PRIX NI LA MÊME RÉPONSE.***

|  |  |  |
|----|----|----|
| ***Q1 — ÉLIDER*** | *une liaison porte les quatre composantes, mais la notation en omet certaines* | ***question de NOTATION*** |
| ***Q2 — RESTREINDRE*** | *une liaison porte une ALGÈBRE plus petite sur une composante, ou n'en porte pas du tout* | ***question de STRUCTURE*** |

*La formulation d'origine — « toute liaison a-t-elle BESOIN des quatre » — les confond, et c'est pourquoi elle paraissait un simple arbitrage de notation avec un « coût de régularité » vague.*

***ET LA SECONDE EXISTE DÉJÀ DANS LE DOCUMENT, SOUS UN AUTRE NOM.*** /~Lin~, `Aff` et `Unr` sont trois sous-ensembles distingués d'un même semi-anneau — `{1}`, `{0,1}`, `{ω}↓` — c'est-à-dire trois algèbres plus petites sur la composante d'usage. Ce sont des MODES au sens de Grass, et le théorème des trois morphismes les relie. Q2 ne demande donc pas de construire un dispositif : elle demande s'il faut GÉNÉRALISER celui-là à un nombre quelconque de modes, sur un nombre quelconque de composantes./

## CE QUE LA LECTURE APPORTE — *Vollmer, lu le 2 septembre*

*La résolution d'une comonade graduée est établie : une adjonction `L ⊣ R : M → C` et une ACTION MONOÏDALE STRICTE `⊙ : R × C → C` induisent ensemble la comonade graduée `□_r = L(r ⊙ R(−))`.*

> \*/LA GRADATION N'EST PAS UNE PROPRIÉTÉ DE LA CATÉGORIE : C'EST UNE ACTION QU'ON Y COMPOSE. Le système entier se lit comme la logique linéaire/non-linéaire de Benton COMPOSÉE AVEC UNE ACTION QUI AJOUTE LA GRADATION./\*

:CITATION: `cite:@vollmerMixedLinearGraded2024` *(fonds, PDF, lu le 2 septembre)*

***CONSÉQUENCE DIRECTE SUR LA QUESTION, ET C'EST CE QUI SÉPARE Q1 DE Q2.***

|  |  |
|----|----|
| ***Q1 — élider*** | *l'action reste celle de `R` tout entier. On ne touche pas à la structure, on choisit ce qu'on écrit* |
| ***Q2 — restreindre*** | *l'action devient celle d'un `R'` plus petit. C'est une AUTRE action, donc une autre comonade graduée, donc un autre mode* |

*Cela referme au passage QA-5 : la décomposition transporte à `!_ω` sans rien demander, `ω` n'étant qu'un élément de `R` comme les autres et l'action étant définie uniformément.*

## PREMIER TEMPS — *LES QUATRE POSTULATS*

### P1, fonctorialité — *indifférent à Q1, exigeant sur Q2*

|  |  |
|----|----|
| ***Q1*** | ***rien à payer***. *La catégorie est la même, l'action est la même, seule l'écriture change* |
| ***Q2*** | ***une construction à fournir***. *Deux liaisons d'algèbres différentes doivent pouvoir se rencontrer sous le même tenseur. Il y faut un morphisme d'algèbres induisant une transformation naturelle entre les deux actions — et pas seulement pour la chaîne `Lin <: Aff <: Unr`, mais pour CHAQUE PAIRE de modes réellement employée* |

*P1 n'est violé par aucune des deux. Mais Q2 réclame un travail que le document n'a pas : le théorème des trois morphismes couvre une chaîne, pas un treillis de modes.*

### P2, orthogonalité usage/valeur — *le postulat parle, et il parle de la FORME*

*P2 énonce que les deux familles de prédicats « ne se combinent pas par un jeu de règles ad hoc mais par un SIMPLE PRODUIT CARTÉSIEN », sous une seule condition de séparation.* *Stricto sensu, il gouverne le produit *usage × valeur*, et les quatre composantes du grade sont toutes du côté usage : P2 ne les vise pas directement.* ***MAIS LE DOCUMENT A CHOISI DE SUIVRE LA MÊME FIGURE À L'INTÉRIEUR DU GRADE — un produit de structures ordonnées, opérations facteur par facteur. Q2 s'en écarte, Q1 non.***

***ET P2 DONNE MIEUX QU'UN ARGUMENT DE FORME : IL DONNE UN PRÉCÉDENT.*** /Sa condition de séparation exclut du suivi de ressource les variables qui n'interviennent que dans la formation d'une contrainte de valeur — indices de taille, paramètres fantômes, bornes — et pose qu'elles « portent donc un GRADE NUL »./

> ***LE DOCUMENT A DONC DÉJÀ UNE CLASSE DE LIAISONS QUI NE PORTENT AUCUNE SIGNIFICATION DE RESSOURCE, ET IL LES TRAITE PAR UNE VALEUR — ZÉRO — ET NON PAR UNE ABSENCE.***

*C'est exactement la réponse Q1, appliquée par anticipation au cas le plus net. Le précédent est dans le postulat lui-même.*

### P3, autonomie physique — *LE POSTULAT QUI DÉCIDE, ET IL INTERDIT UNE CHOSE PRÉCISE*

> ***« Aucune abstraction de K7PL ne dissimule un coût mémoire. \[…\] Toute allocation dynamique dont la taille n'est pas bornée statiquement est un rejet à la compilation. »***

/Élider une composante suppose une valeur conventionnelle pour ce qui n'est pas écrit, et la seule convention cohérente est la valeur qui n'impose AUCUNE CONTRAINTE — la plus permissive. Or elle diffère selon la composante, et l'une d'elles est fatale :/

|  |  |  |  |
|----|----|----|----|
| *usage* | *valeur permissive* `ω` | *absorbante pour `+` et `×`* | ***sans danger*** |
| *monotonie* | *discrète* | *neutre pour le minimum* | ***sans danger*** |
| *niveau* | *public, `⊥`* | *neutre pour le joint* | ***sans danger*** |
| ***budget*** | ***∞*** | *absorbant pour `⊖`* | ***INTERDIT PAR P3*** |

\*/UN BUDGET ÉLIDÉ EST UN BUDGET INFINI, DONC UNE ALLOCATION NON BORNÉE, DONC UN REJET À LA COMPILATION. Élider le budget d'une liaison qui alloue, c'est dissimuler un coût par convention — ce que P3 nomme exactement comme la faute qu'il interdit./\*

*Et la restriction vaut des DEUX options : sous Q2, une liaison dont l'algèbre ne porte pas le budget est pire encore, la contrainte n'y étant pas fausse mais INEXPRIMABLE.*

***LA SORTIE EST NETTE ET ELLE EST DÉJÀ DANS P2.*** /Les liaisons à grade nul — indices, fantômes, bornes — n'allouent rien. Leur budget n'est pas ∞ mais 0, et l'élider ne dissimule aucun coût puisqu'il n'y en a pas. La classe où l'élision est licite est donc déjà nommée par le document./

### P4, déterminisme distribué — *indifférent, à une obligation près*

/Aucune des deux options n'introduit de source de non-déterminisme. Mais si l'élision repose sur une CONVENTION, cette convention appartient à la signification du programme, et un rejeu bit à bit exige qu'elle soit stable./ \*/OBLIGATION : la convention d'élision doit être portée par la version de schéma de l'artefact, que le chapitre 6 possède déjà — identifiant de schéma, révision, longueur du bloc racine. Une ligne, et elle relève d'un dispositif existant./\*

## DEUXIÈME TEMPS — *L'AXIOME ET LA CONDITION DE CLÔTURE*

/Le jugement germinal porte trois composantes, et la condition de clôture exige que toute extension se projette sur elles sans en altérer la sémantique, le critère opératoire étant le placement en coeffet, effet ou raffinement./

|  |  |
|----|----|
| ***les deux options se projettent sur*** `Δ` | *un grade est un coeffet, partiel ou non* |
| ***aucune n'introduit d'effet*** | *la clause supplémentaire — tout effet non déterministe est journalisé — est sans objet* |

***L'AXIOME ADMET LES DEUX ET NE DÉCIDE PAS. C'est un résultat et non une lacune : la condition de clôture est faite pour dire ce qui est admissible, non pour arbitrer entre deux admissibles.***

/Une remarque toutefois, qui vaut d'être portée : le chapitre 1 pose désormais que le grade est CONSTRUIT et non postulé, avec trois conditions d'extension — structure ordonnée, opérations facteur par facteur, placement dans une strate. Q2 satisfait la troisième et la première ; elle échoue à la DEUXIÈME dès que deux liaisons de modes différents doivent être additionnées, l'addition point par point supposant les mêmes facteurs des deux côtés./

## TROISIÈME TEMPS — *LE RESTE DU MANUSCRIT*

### Ce que Q1 touche — *peu, et c'est vérifiable*

|  |  |
|----|----|
| *les règles de typage* | *inchangées : le grade est complet, seule la présentation l'abrège* |
| `Δ₁ + Δ₂` *et* `r·Δ` | *inchangées, les opérations portant sur les valeurs conventionnelles comme sur les autres* |
| `⊑_{<:}` | *inchangé ; la comparaison d'un grade complet et d'un grade abrégé passe par la convention* |
| ***les jointures de A.3.7*** | ***intactes***, *donc le théorème de cohérence de la subsomption tient* |
| `thm:coherence_axiome` | *son énoncé dit « trois des quatre composantes » ; à réénoncer « toutes sauf le budget », ce qui est plus général et non moins vrai* |
| *l'effacement de la Phase 8* | *inchangé* |
| ***l'interface d'une unité*** | ***inchangée***, *toutes les unités portant la même algèbre* |

***UNE SEULE PHRASE À RÉÉNONCER, ET UNE CONVENTION PAR COMPOSANTE À FIXER.***

### Ce que Q2 touche — *beaucoup, et deux points sont graves*

|  |  |
|----|----|
| `Δ₁ + Δ₂` | ***indéfinie entre modes différents***. *L'addition point par point suppose les mêmes facteurs* |
| ***les jointures de*** `⊑_{<:}` | ***menacées***. *Un joint entre deux modes n'existe que si le treillis des modes en a un — et rien ne l'établit* |
| ***A.3.7*** | ***en péril***. *Sa condition est l'existence des jointures ; si elles tombent entre modes, le théorème de cohérence de la subsomption tombe avec* |
| ***A.3.3, l'interface*** | ***l'édition de liens devient dépendante du mode***. *Deux unités qui ne portent pas les mêmes composantes ne s'apparient que par un morphisme de modes, qui doit exister pour chaque paire employée* |
| ***A.3.8*** | *le théorème couvre une CHAÎNE de trois modes ; Q2 demande un treillis quelconque, ce qui n'est pas la même preuve* |
| *la syntaxe de surface* | *doit distinguer une composante ABSENTE d'une composante à sa valeur permissive, sous peine d'ambiguïté avec Q1* |

***LES DEUX POINTS GRAVES SONT LES JOINTURES ET L'ÉDITION DE LIENS. Le premier met en péril un théorème écrit aujourd'hui ; le second change la sémantique des modules.***

## CE QUE JE RETIENS, ET CE QUE JE RECOMMANDERAIS

> ***Q1 EST BON MARCHÉ ET DÉJÀ PRÉCÉDENTÉ. Q2 EST CHER, ET IL EST DÉJÀ FAIT — SOUS LE NOM DE LA CHAÎNE MODALE, ET SEULEMENT POUR ELLE.***

|  |  |  |
|----|----|----|
| ***Q1 — élider*** | ***adopter*** | *trois conditions : une convention par composante, l'interdiction d'élider le BUDGET pour toute liaison qui alloue, et la convention portée par la version de schéma. Le précédent est dans P2, qui donne déjà un grade nul aux liaisons sans signification de ressource* |
| ***Q2 — restreindre*** | ***ne pas généraliser*** | *le document a trois modes et un théorème qui les relie ; les généraliser coûte les jointures, l'édition de liens et une preuve que A.3.8 ne donne pas. Si un besoin précis apparaît, il vaudra mieux ajouter UN mode nommé que d'ouvrir le treillis* |

***ET LA RAISON DE FOND EST CELLE QUE LE DOCUMENT SUIT DÉJÀ SEPT FOIS : PARAMÉTRER, NE PAS AJOUTER.*** /Q1 ne fait qu'abréger une instance de la construction existante. Q2 ajoute des constructions. Le 2 septembre a tranché trois arbitrages dans ce sens, et la même figure se présente ici une quatrième fois./

### LA QUESTION QUE JE POSERAIS EN RETOUR, SI VOUS N'EN VOULEZ QU'UNE

> ***Existe-t-il une liaison de K7PL qui ait besoin d'une composante d'usage AUTRE que `ℕ∞`, `{1}`, `{0,1}` ou `{ω}↓` ?***

*Si la réponse est non, Q2 n'a pas d'objet et Q1 suffit. Si elle est oui, la pièce à ajouter est un MODE NOMMÉ, avec son morphisme vers les trois autres — pas un treillis ouvert.* *Et il vaut mieux poser la question ainsi qu'en termes de « composantes nécessaires », parce que ce qui coûte n'est pas le NOMBRE de composantes mais le nombre d'ALGÈBRES qui doivent coexister.*
