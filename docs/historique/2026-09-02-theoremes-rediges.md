# K7PL — les théorèmes rédigés, prêts pour la passe d'ajustement

*Ouvert le 2 septembre 2026, après les quatre décisions et la vérification A.2.6*

> Archivé le 2026-10-01 : ce document décrit l'état du 2 septembre 2026 et a été remplacé par [le tableau de bord](../suivi/TABLEAU-DE-BORD.md). Il est conservé pour la trace, tel qu'écrit alors ; les noms de fichiers et les commandes qu'il cite désignent l'ancien arbre de travail (Org-mode).

## CE QUI COMMANDE LA LECTURE

> ***A.2.6 EST PASSÉE. K7PL GÉNÉRALISE LA FORME REÇUE, IL NE S'EN ÉCARTE PAS.***

/C'était la vérification qui commandait tout : elle ne coûtait rien si elle passait et coûtait le chapitre 2 si elle échouait. Elle passe, et l'équation qui la règle était déjà écrite au chapitre 1 depuis le début — personne n'avait fait le rapprochement./

## A.2.6 — *`\boxtimes` GÉNÉRALISE L'ADDITION PONCTUELLE* **— VÉRIFIÉ**

### L'énoncé

    Lemme (l'addition est le cas sans coût temporel).
    Pour tous contextes Δ₁, Δ₂ et tout effet ε dont la composante temporelle est nulle,
        Δ₁ ⊠_ε Δ₂  =  Δ₁ + Δ₂.
    En particulier l'égalité vaut pour l'effet neutre, et elle est TOTALE en ce point.

### L'esquisse, et elle tient en trois renvois

|  |  |
|----|----|
| **1** | *Le chapitre 1 DÉFINIT l'opérateur, à* `eq:boxtimes` : **Δ₁ ⊠\_ε Δ₂ = Δ₁ + ψ(Δ₂, ε)**. *L'opérateur EST l'addition, assortie du transport* |
| **2** | `tab:phi-psi` *donne l'action de ψ : elle traverse inchangé sur l'usage, le niveau et la monotonie, et n'agit que sur le BUDGET, par `β ⊖ k` où k est la composante temporelle de ε* |
| **3** | *Si k = 0 alors `β ⊖ 0 = β`, la soustraction tronquée dans `ℕ∞` ayant 0 pour neutre à droite. Donc ψ(Δ₂, ε) = Δ₂ sur les quatre composantes, et l'opérateur se réduit à l'addition* |

***Et le point k = 0 est le seul où ψ soit TOTALE.*** /Le chapitre 1 note que la soustraction peut échouer — « un budget insuffisant rend λ indéfinie, et la règle qui en dérive refuse alors la composition au lieu de la payer ». À k = 0 elle ne peut pas échouer. Le lemme n'a donc AUCUNE condition de bord, ce qui est rare dans ce chapitre et vaut d'être dit./

### Le corollaire, qui est ce que l'arc B demandait

    Corollaire. Sur le fragment sans effet, la règle App de K7PL
        Δ₁ ⊠ (r·Δ₂)   se lit   Δ₁ + r·Δ₂,
    qui est littéralement la règle des trois sources.

:CITATIONS: `cite:@hanukaevUnificationGradedSubstructural2026`, `cite:@hughesProgramSynthesisGraded2024`, `cite:@choudhuryGradedDependentType2021`

***ET LA VÉRIFICATION EXPLIQUE EN OUTRE POURQUOI LES TROIS SOURCES ÉCRIVENT UNE ADDITION.*** /Aucune des trois n'a d'effet qui traverse le coeffet ; leur composante temporelle est donc identiquement nulle ; leur `⊠` EST leur `+`. Elles n'ont pas fait un autre choix que K7PL — elles sont dans le cas où les deux opérateurs coïncident, et n'avaient aucune raison d'en distinguer deux./

/Ce qui referme l'obligation dans le bon sens : le document n'a pas à se justifier d'un écart, il a à écrire une généralisation. Une phrase suffit, et elle est plus favorable que celle qu'on craignait d'avoir à écrire./

### **LIEU D'INSERTION** : *près de la loi distributive graduée, au chapitre 3, avec renvoi à `eq:boxtimes`.*

### UNE TROUVAILLE DE CHEMIN, ET ELLE PÈSE SUR LA MÉCANISATION

> ***L'INDICE DE `\boxtimes` EST ÉCRIT AU CHAPITRE 1 ET OMIS PARTOUT AILLEURS.***

/Le chapitre 1 écrit `⊠_ε` — l'opérateur dépend de l'effet traversé, et sa définition le montre. L'annexe formelle écrit `⊠` nu, à quinze occurrences et dans onze règles de typage. Le chapitre 5 écrit `⊠_i`, indicé par la métavariable et non par l'effet./ /L'indice est RECOUVRABLE dans chaque règle par le séquencement — dans `Let` c'est `ε₁`, l'exigence du second calcul traversant l'effet du premier ; dans `App` c'est `ε₀`, celui du terme fonction. Mais il n'est écrit nulle part, et « recouvrable par le lecteur » n'est pas une définition./ \*/POUR LA MÉCANISATION C'EST UN COÛT DIRECT ET CHIFFRABLE : chacune des onze règles qui composent deux contextes devra dire quel effet indexe son `⊠`, et un choix implicite ne se transporte pas dans un assistant de preuve./\* *ACTION : porter l'indice dans l'annexe. C'est une notation, pas une conception — mais c'est exactement le genre d'omission qui coûte une semaine à la mécanisation et rien maintenant.* **À porter au bloc C comme C-38.**

## A.3.5 — *LE PLI DE K7PL EST-IL UN PLI ADJOINT ?* **— INSTRUIT, et la réponse est NON**

### La réponse tient en une phrase du chapitre 2, et elle y est depuis le début

> ***Le pli adjoint est paramétré par une ADJONCTION, donc par des foncteurs, donc par des `map`. Le pli de K7PL « NE DÉPEND D'AUCUNE FONCTION `map` ». Il n'est donc pas une instance.***

:CITATIONS: `cite:@hinzeUnifyingStructuredRecursion2016`, `cite:@fuDependentlyTypedFolds2018`, `cite:@birdGeneralisedFoldsNested1999`

/Le chapitre 2 écarte explicitement le pli généralisé de Bird et Paterson — trop étroit, il « ne peut plus décrire que des transformations naturelles » — et retient le PLI DÉPENDAMMENT TYPÉ, qui est défini par récursion bien fondée, existe pour tout type imbriqué, ne dépend d'aucun `map`, et se spécialise en le pli d'ordre supérieur traditionnel./ ***OR C'EST LE PLI DE BIRD ET PATERSON QUE HINZE SUBSUME, ET C'EST PRÉCISÉMENT CELUI QUE K7PL A REMPLACÉ POUR INSUFFISANCE.***

|  |  |
|----|----|
| ***le pli adjoint*** | *généralise PAR L'ADJONCTION — catégorique, et il donne accès au zoo* |
| ***le pli dépendamment typé*** | *généralise PAR LA RÉCURSION BIEN FONDÉE — théorique des types, et il donne les types imbriqués sans `map`* |

***DEUX GÉNÉRALISATIONS DU MÊME PLI ORDINAIRE, QUI SE RENCONTRENT EN BAS ET DIVERGENT EN HAUT. Aucune ne contient l'autre.***

***CONSÉQUENCE SUR R-61, ET ELLE INVERSE L'ATTENTE :*** /~tab:dimensions~ ne porte PAS une entrée et dix instances. La réponse négative n'est pas une déception — c'est un acquis à revendiquer. Le pli de K7PL est plus général que le zoo dans la direction qui l'intéresse, les types imbriqués, et le document a déjà écrit pourquoi sans en tirer l'argument./

### Mais l'instruction trouve mieux que ce qu'elle cherchait, et c'est du côté du COMONADE

*Le résumé de Hinze et Wu dit ce que l'article ajoute au pli adjoint, et cela n'était pas dans la question :* ***« des bêtes plus exotiques comme les schémas de récursion issus de COMONADES se sont révélées insaisissables »*** *— et l'article les obtient, par les deux dérivations canoniques d'adjonctions à partir des (co)monades.*

> ***K7PL A LA COMONADE. K7PL A LA CATÉGORIE DE CO-KLEISLI. K7PL EMPLOIE L'HISTOMORPHISME. Les trois sont au document, et rien ne les relie.***

|  |  |
|----|----|
| *la comonade exponentielle graduée* `!_r` | *chapitre 2, section de la comonade* |
| *la catégorie de co-Kleisli* `C_{!_r}` | *chapitre 2, avec ses `Hom(!_r A, B)` et la multiplication du grade le long de la composition* |
| *l'histomorphisme* | *chapitre 4, et c'est l'objet de A.2.7 — dont la borne est amortie* |

***L'HISTOMORPHISME EST LE SCHÉMA DE RÉCURSION ISSU D'UNE COMONADE PAR EXCELLENCE, et Hinze et Wu le dérivent de l'adjonction canonique de cette comonade. K7PL a la comonade dont il faudrait partir.***

/Ce n'est pas la même question que R-61 et elle est meilleure : non pas « le pli de K7PL est-il adjoint » — non — mais « l'histomorphisme de K7PL se dérive-t-il de son propre `!_r` par la construction de Hinze et Wu ». Si oui, la borne amortie de A.2.7 et le schéma qui la porte viennent du même objet, et `!_r` cesse d'être seulement la modalité d'usage pour devenir aussi la source du schéma de récursion de la couche 2./

### LE SECOND TEMPS EST FAIT — *lu le 2 septembre, et la réponse est encore NON*

|  |  |
|----|----|
| ***la question*** | *l'histomorphisme de K7PL se dérive-t-il de son propre `!_r` par la construction d'Eilenberg–Moore ?* |
| ***la réponse*** | ***NON. La comonade qu'un schéma issu de comonade demande est la comonade COFREE du foncteur de motif — celle qui accumule l'historique. `!_r` est la modalité d'usage. Deux comonades, deux rôles.*** |

/Les deux dérivations canoniques sont nommées par la source : Kleisli donne les catamorphismes monadiques, Eilenberg–Moore donne les schémas issus de comonades. L'histomorphisme est le cas où la comonade est la cofree. La gradation n'y entre pas./

#### MAIS LA LECTURE TROUVE DEUX CHOSES QUE LA QUESTION NE CHERCHAIT PAS

> ***UNE LOI DISTRIBUTIVE MANQUE AU DOCUMENT, ET UNE BORNE ANNONCÉE N'EST PAS CELLE DE LA CONSTRUCTION DIRECTE.***

|  |  |
|----|----|
| **1** | *Un schéma issu de comonade exige une LOI DISTRIBUTIVE `λ : F ∘ N ⇒ N ∘ F` de l'endofoncteur sur la comonade, sous deux conditions de cohérence, et c'est elle qui fait de l'algèbre et de la coalgèbre de contexte une λ-BIALGÈBRE. K7PL emploie l'histomorphisme sans l'avoir posée. Elle est DISTINCTE de la loi distributive graduée du chapitre 1, qui distribue la modalité de grade sur la monade d'effet — ce qui répond à R-62 par la négative* |
| **2** | ***La dérivation directe est QUADRATIQUE*** — *le corps du pli applique l'algèbre au résultat d'une trace. La version linéaire, qui n'invoque l'algèbre qu'une fois par niveau, demande un travail supplémentaire et un résultat séparé. ANNONCER UNE BORNE SANS DIRE DE LAQUELLE DES DEUX ON PARLE DISSIMULE UN FACTEUR, ce que P3 interdit* |

\*/LE SECOND POINT TOUCHE UN POSTULAT ET NON UNE PRÉSENTATION. Il est porté au chapitre 2 avec l'obligation qui en découle : la borne annoncée est celle de la version linéaire, et sa dérivation est due au même titre que la loi distributive./\* *R-61 se ferme par la négative et R-62 aussi. Ce que la lecture rend en échange vaut mieux que ce qu'elle cherchait : deux obligations nommées là où il n'y avait qu'une classification manquée.*

### R-62 — *les deux lois distributives sont-elles une seule ?* **— la question devient tranchable**

*Le pli adjoint est paramétré par une adjonction ET UNE LOI DISTRIBUTIVE. K7PL a une loi distributive graduée,* `λ_{r,ε} : □_r ∘ T_ε ⇒ T_{φ(r,ε)} ∘ □_{ψ(r,ε)}`. \*/CE SONT DEUX OBJETS DIFFÉRENTS — celle de Hinze relie un foncteur à l'adjonction, celle de K7PL relie la modalité de grade à la monade d'effet. La question n'est donc pas « sont-elles la même » mais « celle de K7PL est-elle la loi distributive du pli adjoint qu'on obtiendrait de `!_r` »./\* *Formulée ainsi elle se vérifie ; formulée comme avant elle ne se vérifiait pas. À conduire avec la lecture ci-dessus, dont elle est le second temps.*

## A.3.10, OBLIGATION 3 — *LES TROIS ORDRES SE DISENT-ILS PAR LE MÊME PRÉDICAT ?* **— INSTRUIT**

### Pourquoi celle-ci passe en premier

/C'est la moins chère des trois obligations et la plus discriminante : elle se vérifie sur ce qui est déjà écrit aux arcs, sans rien construire, et un échec rend les deux autres sans objet. Et elle porte l'objection même que l'arbitrage 1 avait retenue CONTRE le contexte ordonné — que les trois besoins portent trois ordres différents qu'un contexte ordonné confondrait./ ***L'OBJECTION SE RETOURNE-T-ELLE CONTRE LA VOIE RETENUE ? C'est la vraie question, et il vaut mieux la poser franchement que la contourner.***

### Les trois ordres, et ils ne sont pas de la même espèce

|  |  |  |
|----|----|----|
| ***séquence de messages*** | *les communications d'une session s'effectuent dans l'ordre du protocole* | *ni total ni partiel : SÉQUENTIEL PAR SESSION, et deux sessions distinctes ne se contraignent pas* |
| ***pile d'emprunts*** | *un emprunt de durée courte ne se permute pas devant un emprunt de durée longue* | ***ORDRE PARTIEL***, *porté par la durée de vie* |
| ***planarité de fils*** | *les fils ne se croisent pas* | ***ORDRE TOTAL*** *sur les positions, et l'échange y est interdit ENTIÈREMENT* |

***TROIS ESPÈCES D'ORDRE : séquentiel par classe, partiel, total. L'objection est fondée, et un contexte ordonné les confondrait bien — il n'a qu'UN ordre pour tout le contexte.***

### Et c'est exactement là que la forme paramétrée s'en sépare

> ***Un contexte ordonné porte UN ordre. Un prédicat d'échange porte UNE ZONE PAR LIAISON, et chaque zone porte SON ordre.***

*Forme proposée, sur le patron de Grass — la contraction y est un idéal, l'affaiblissement un booléen, et l'échange serait une relation binaire sur les grades :*

    Exch(r, s)  vaut  si  zone(r) ≠ zone(s),
                ou   si  l'ordre propre à cette zone ne contraint pas r et s.

|  |  |
|----|----|
| ***session*** | *zone = l'identité de session ; ordre = celui du protocole* |
| ***emprunt*** | *zone = la région d'emprunt ; ordre = celui des durées de vie* |
| ***planarité*** | *zone = le fragment planaire ; ordre = total, donc `Exch` y est partout faux* |

\*/LES TROIS ORDRES NE SONT PAS CONFONDUS : ILS SONT TROIS INSTANCIATIONS DE LA ZONE. C'est la réponse à l'obligation 3, et c'est la même figure que les trois autres décisions du 2 septembre — paramétrer, ne pas ajouter./\* *Et la planarité y entre comme le cas dégénéré, non comme une exception : une zone dont l'ordre est total est une zone où l'échange n'a jamais lieu, ce qui est la logique ordonnée.* :APPUI: `cite:@polakowNaturalDeductionIntuitionistic1999` *(fonds, PDF — lecture à conduire, l'arc C l'avait laissée en arbitrage)*

### CE QUE CETTE INSTRUCTION NE FAIT PAS, ET IL FAUT LE DIRE

|  |  |
|----|----|
| ***obligation 3 : PASSE*** | *les trois ordres se disent par un prédicat unique paramétré par la zone. Le risque de confusion est écarté, et pour une raison précise — l'ordre vit dans la zone, non dans le contexte* |
| ***obligation 1 : non traitée*** | *que le quadruplet enrichi satisfasse encore les lois de mode. Demande la lecture de Grass sur ses conditions de mode* |
| ***obligation 2 : non traitée, et c'est le point de rupture attendu*** | ***l'admissibilité de la substitution sous un contexte où l'échange est restreint. Le lemme de substitution du document use de la permutation libre des hypothèses, et rien ne dit qu'il y survit*** |

***LA ZONE EST UNE PROPOSITION DE FORME, PAS UN RÉSULTAT. Elle est de moi et d'aucune source : personne n'a construit ce prédicat, ce qui était le risque annoncé et reste entier.***

/Une distinction que l'instruction a fait apparaître et qui n'était pas vue : la ZONE serait une composante de GRADE — donc elle relève de B-17 et s'ajoute librement —, tandis que le PRÉDICAT est une donnée de MODE — donc il relève de Grass et se paie séparément./ ***DEUX CHOSES ÉTAIENT CONFONDUES SOUS « PARAMÉTRER LE GRADE », ET UNE SEULE EST GRATUITE.***

### OBLIGATION 2 — *LA SUBSTITUTION* — **instruite le 2 septembre, et le point de rupture n'est pas où on le cherchait**

#### Le fait, et il change la question

> \*/L'ÉCHANGE N'EST PAS UNE RÈGLE DE K7PL. Le mot ne paraît nulle part au manuscrit comme règle structurelle, et l'annexe nomme les siennes : « l'affaiblissement et la contraction n'étant pas des règles mais de l'arithmétique de grades »./\*

/On ne restreint pas ce qui n'existe pas. L'échange est *présupposé* par la REPRÉSENTATION : le contexte est une application finie des variables vers les grades, ce que `Δ₁ + Δ₂` « les additionne composante par composante » ne dit pas autrement — une addition point par point n'a de sens que sur des applications, non sur des suites./ ***LE COÛT DE 1C N'EST DONC PAS DANS LA PREUVE DE SUBSTITUTION. IL EST DANS LA REPRÉSENTATION DES CONTEXTES, ET C'EST PLUS PROFOND.*** *Une suite ordonnée ne s'additionne pas point par point ; `⊠`, qui est `Δ₁ + ψ(Δ₂, ε)`, en dépend directement.*

#### Où le lemme mord réellement

*L'énoncé est* `Δ, x :_r V_i ⊢ c` : /la variable substituée est à l'extrémité DROITE du contexte. Sur une application finie, cette écriture est une notation et non une contrainte — toute liaison peut être présentée en dernier. Sur un contexte à échange restreint, elle devient une contrainte réelle : une liaison prise au milieu d'une zone ordonnée ne se déplace pas./ ***LE LEMME NE SE DÉMONTRE DONC PAS DIFFÉREMMENT — IL CESSE D'ÊTRE GÉNÉRAL. C'est cela, le point de rupture, et il est plus net que « la preuve casse ».***

#### Ce que la forme à ZONES rend, et elle rend beaucoup

|  |  |
|----|----|
| ***le contexte*** | *reste une application finie, des variables vers un couple (grade, zone), assortie d'un ordre partiel PAR ZONE* |
| ***l'addition*** | *reste ponctuelle : la zone est portée comme une donnée, et additionner deux liaisons d'une même variable exige la même zone* |
| ***`⊠`*** | ***survit sans retouche***, *puisque `ψ` n'agit que sur le budget — `tab:phi-psi` le donne — et laisse donc la zone inchangée* |
| ***l'échange*** | *libre ENTRE zones, restreint DANS une zone* |

> ***LE LEMME REDEVIENT ÉNONÇABLE, AU PRIX D'UNE CONDITION DE BORD : la substitution est admissible pour la liaison MAXIMALE de sa zone.***

/Et cette condition n'est pas un défaut : elle EST le contenu de la restriction. On ne consomme pas le second message d'une session avant le premier, et un lemme qui l'autoriserait serait faux du besoin qu'il sert. La restriction se lit du bon côté./

#### LE PRIX RÉEL, ET IL EST À DIRE

|  |  |
|----|----|
| **1** | ***La condition de bord doit être ACQUITTÉE À CHAQUE EMPLOI*** — *elle l'est ci-après, et les trois verdicts diffèrent* |
| **2** | *La représentation des contextes change, ce qui touche l'annexe entière et non un théorème. C'est un coût de mécanisation, pas de conception* |
| **3** | *Le cas `Var` du lemme impose `Δ = 0` et `r = 1` quand `c = x` : sur une zone ordonnée, il faut vérifier que la liaison unique restante est bien maximale — trivialement vrai, mais à écrire* |

#### LES TROIS EMPLOIS, ACQUITTÉS UN PAR UN — *2 septembre*

1.  EMPLOI 1 — *la préservation* — **PASSE, et automatiquement**

    /L'esquisse dit ce qu'il faut : « chacune consomme une introduction sous son élimination, et la dérivation de typage du rédex se décompose donc en la prémisse de l'introduction et celle de l'élimination »./ ***UN RÉDEX SUBSTITUE TOUJOURS DANS LA LIAISON LA PLUS RÉCEMMENT INTRODUITE.*** /Dans `let x ← c₁ in c₂`, `x` est la liaison que le `let` ajoute au contexte de `c₂` ; dans `(λx.c) v`, de même. Or l'ordre d'une zone suit l'ordre d'introduction — le message `n` est lié après le message `n−1`, l'emprunt le plus récent est au sommet de la pile./ *Donc « la plus récemment introduite » et « maximale dans sa zone » désignent la même liaison, et la condition de bord est satisfaite par la FORME des rédex, sans hypothèse à ajouter.* ***C'est le meilleur résultat possible pour cet emploi : la restriction ne mord jamais là où la réduction opère, parce que la réduction opère toujours au sommet.***

2.  EMPLOI 2 — *la relation logique* — **PASSE, à un prix qui doit être écrit**

    /Deux rôles, et un seul est concerné. Dans les cas de composition, c'est la loi de cohérence qui sert et non la condition de bord : rien à acquitter. Mais le lemme intervient d'abord « pour que l'énoncé ait un sens », et là `γ` est une substitution SIMULTANÉE sur tout le contexte./ ***UNE SUBSTITUTION SIMULTANÉE TOUCHE TOUTES LES LIAISONS, DONC PAS SEULEMENT LA MAXIMALE.*** /Elle se rattrape, et d'une seule manière : la décomposer en substitutions simples prises dans l'ORDRE INVERSE de la zone — la maximale d'abord, puis la suivante, qui devient maximale une fois la première retirée. Chaque pas satisfait alors la condition./ **Ce que cela coûte, et il faut le dire** : /le lemme de substitution SIMULTANÉE cesse d'être un corollaire immédiat du lemme simple ; il faut le réénoncer avec son ordre de séquentialisation. C'est un lemme de plus, court, mais il n'existe pas aujourd'hui./ *Et `γ` ferme le terme, de sorte que toutes les liaisons sont substituées et que la séquentialisation est toujours possible — ce qui ne serait pas acquis d'une substitution partielle.*

3.  EMPLOI 3 — *la traduction vers le métalangage* — **PASSE POUR LA CORRECTION, et le reste est une PERTE**

    > ***LA COMPOSITION PARALLÈLE DU CALCUL CIBLE EST COMMUTATIVE. L'ORDRE D'UNE ZONE N'A DONC AUCUNE IMAGE DANS LA TRADUCTION.***

    /La traduction envoie chaque liaison sur un canal et compose les processus par `|`, dont la congruence structurelle donne la commutativité. Deux termes source qui ne différeraient que par une permutation interdite par l'échange auraient donc des traductions équivalentes./

    |  |  |
    |----|----|
    | ***ce qui survit*** | *la CORRECTION : un terme source bien typé se traduit en un terme cible bien typé, et l'extrusion de portée reste licite, la garantie qu'elle emploie étant une propriété de GRADE — `x` n'apparaît que là où son grade est non nul — que l'ordre ne touche pas* |
    | ***ce qui se perd*** | ***la traduction cesse de REFLÉTER la discipline d'échange. La cible admet des comportements que la source interdit*** |

    ***ET C'EST LA CONSÉQUENCE QUI COMPTE : TOUTE PROPRIÉTÉ DE LA SOURCE DÉRIVÉE DE LA TRADUCTION DOIT ÊTRE REVÉRIFIÉE.*** /Le chapitre 4 en dérive au moins une — l'acyclicité, obtenue de ce qu'un terme cible est un arbre de coupures. Un argument qui descend vers un modèle plus grossier ne remonte pas de lui-même./ /La parade existe et elle a un nom : donner au métalangage sa propre discipline d'ordre, ce qui est la logique linéaire ordonnée du côté cible. Mais c'est précisément ce que la voie retenue évitait à la source, et le payer à la cible n'est pas le payer moins./

4.  LES PROPRIÉTÉS DÉRIVÉES DE LA TRADUCTION, REVÉRIFIÉES — *et le test est simple*

    > ***UN ARGUMENT QUI DESCEND D'UNE PROPRIÉTÉ UNIVERSELLE DE LA CIBLE VERS L'IMAGE DE LA SOURCE EST SÛR. UN ARGUMENT QUI REMONTE DE LA CIBLE POUR CARACTÉRISER LA SOURCE NE L'EST PAS.***

    /Et un fait décide de presque tout : la restriction d'échange est une discipline STATIQUE — elle RETIRE des termes, elle n'en distingue pas deux. Deux termes source qui différeraient par une permutation interdite ne sont pas deux termes : l'un n'est pas typable, donc n'existe pas. La traduction ne confond donc aucune distinction de la source ; ce qu'elle perd est que son IMAGE cesse d'être caractérisée, des termes cibles n'ayant aucune préimage légale./

    |  |  |  |
    |----|----|----|
    | ***l'acyclicité*** *(c4)* | ***SURVIT*** | *« un terme y est un arbre de coupures, et un arbre n'a pas de cycle » est une propriété UNIVERSELLE des termes cibles bien typés. Elle vaut a fortiori de l'image. L'argument descend* |
    | ***l'effacement*** *(c4, conséquence 1)* | ***SURVIT*** | *`⟦·⟧` est le foncteur du système de raffinement : il oublie `𝒢` et `ℰ`. Perdre en outre l'ordre ne lui fait rien, un foncteur de raffinement n'ayant pas à être PLEIN. Ce qui compterait serait qu'il cesse d'être fidèle sur les distinctions de la source, et il ne le cesse pas* |
    | ***la fidélité de l'interpréteur*** *(c4, conséquence 3)* | ***SURVIT*** | *la correction se raisonne au niveau du métalangage et se transporte parce que la traduction est une correspondance OPÉRATIONNELLE. Une restriction qui porte sur la FORMATION des termes est invisible à une correspondance de réduction, et l'interpréteur ne voit jamais un terme illégal* |
    | ***le foncteur de l'orchestrateur*** *(c4, conséquence 2)* | ***NE SURVIT PAS TEL QUEL*** | ***c'est le seul argument qui REMONTE.*** *Le foncteur est lu sur la cible — « le produit des foncteurs de comportement individuels, restreint aux transitions que la topologie de coupures autorise ». La topologie de coupures ne porte pas l'ordre, donc le foncteur obtenu ADMET des transitions que la source interdit* |

    ***LE VERDICT EST DONC : TROIS SUR QUATRE PASSENT, ET LE QUATRIÈME EST UNE SUR-APPROXIMATION ET NON UNE ERREUR.*** /Le foncteur lu sur la cible est trop grand ; la coalgèbre de l'orchestrateur en est une SOUS-coalgèbre. Pour établir l'EXISTENCE du foncteur, cela suffit ; pour en tirer une propriété de sûreté, non — une sur-approximation ne démontre pas une sûreté./ *ACTION : restreindre explicitement ce foncteur par la discipline d'échange, que la cible ne porte pas. Une phrase, mais elle doit être écrite là où le foncteur est exhibé.*

#### ***VERDICT SUR L'OBLIGATION 2 : ELLE NE TOMBE PAS, ET LE RISQUE EST DÉPLACÉ.***

/Ce qu'on craignait — une preuve qui casse — n'arrive pas. Ce qu'on trouve est un coût de représentation et une condition de bord à acquitter trois fois. C'est plus lourd qu'une phrase et beaucoup moins grave qu'un échec./

### OBLIGATION 1 — *LE QUADRUPLET RESTE-T-IL UN MODE* — **instruite, et A.3.8 survit**

/La condition de morphisme de modes est explicite : tout grade contractable de la source s'envoie sur un contractable du but, et l'affaiblissement se propage vers l'avant. Un mode enrichi d'un prédicat d'échange ajoute une troisième condition de la même famille — si `Exch(r,s)` vaut à la source, il doit valoir à l'image./ \*/POUR LES TROIS MORPHISMES DE A.3.8, C'EST TRIVIALEMENT SATISFAIT : `Lin`, `Aff` et `Unr` diffèrent sur la contraction et l'affaiblissement, non sur l'ordre. Le prédicat d'échange y est le même, et une inclusion préserve ce qui ne change pas./\* *A.3.8 survit donc à l'extension sans être réécrit, ce qui n'allait pas de soi : un théorème démontré avant une extension de la structure qu'il gouverne doit être revérifié, et celui-ci passe.*

#### LA LECTURE EST FAITE — *et elle donne la MÉTHODE, dont la condition se déduit*

*Un mode y est bien le triplet `(R_m, Cont(m), Weak(m))`. Ce que la lecture apprend est POURQUOI `Cont(m)` doit être un idéal, et le motif est unique pour les trois conditions :*

|  |  |
|----|----|
| *clôture par addition* | *contracter trois variables demande de CHOISIR UN ORDRE — `x₁` avec `x₂` puis `x₃`, ou `x₂` avec `x₃` puis `x₁`. La clôture rend les deux ordres possibles, « et les dérivations résultantes doivent être considérées égales »* |
| *`0 ∈ Cont(m)`* | *pour que contraction et affaiblissement s'emploient dans les deux ordres avec le même résultat* |
| *idéal, donc absorbant* | *pour que contracter puis substituer et substituer puis contracter donnent le même terme* |

> ***LES TROIS CONDITIONS D'UN MODE EXISTENT POUR UNE SEULE RAISON : RENDRE L'ORDRE D'APPLICATION INDIFFÉRENT.***

#### ***ET C'EST EXACTEMENT CE QU'UN PRÉDICAT D'ÉCHANGE FAIT CESSER***

/Un prédicat d'échange est, par définition, une donnée qui rend l'ordre PERTINENT. L'ajouter au mode n'est donc pas ajouter une quatrième donnée de la même espèce : c'est ajouter une donnée qui va contre le principe des trois autres. Le dire ainsi est plus sévère que « personne ne l'a fait », et c'est le vrai contenu de la note 3 des auteurs./ /Mais la sévérité désigne aussi la sortie, et elle est précise. Les trois conditions assurent l'indifférence d'ordre pour la CONTRACTION et l'AFFAIBLISSEMENT ; le prédicat contraint la PERMUTATION. Ce sont des opérations distinctes, et elles ne se rencontrent qu'en un point : la contraction FUSIONNE deux liaisons, donc détruit l'ordre entre elles./

    Condition dérivée (compatibilité de l'idéal et du prédicat).
    Deux grades ne se contractent que s'ils sont mutuellement contractables ET mutuellement
    échangeables :
        q₁, q₂ ∈ Cont(m)   ET   Exch(q₁, q₂).

***ET SA LECTURE EST JUSTE : on ne fusionne deux emplois d'une ressource que si leur ordre est sans importance. On ne fusionne pas le premier et le second message d'une session.*** *La condition n'est donc pas un raccommodage : c'est ce que le besoin voulait dire depuis le début, exprimé au bon niveau.*

#### VERDICT SUR L'OBLIGATION 1

|  |  |
|----|----|
| ***les morphismes*** | ***acquis*** — *A.3.8 survit sans être réécrit* |
| ***les lois de mode*** | ***tiennent, sous UNE condition dérivée*** — *la compatibilité de `Cont(m)` et de `Exch`, qui se lit comme la restriction elle-même* |
| ***la commutation*** | ***FAITE ci-après, et elle corrige une erreur de ma part*** |

#### LE CALCUL DE COMMUTATION — *fait, et il CORRIGE ce que j'avais écrit*

*Le calcul de la source, refait avec le prédicat. Soient* `ρ, r ⊙ Γ, x:A ⊢ e:B` *et* `σ, q₁, q₂ ⊙ Δ, z₁:T, z₂:T ⊢ t:A` *avec `q₁, q₂ ∈ Cont(m)`.*

|  |  |
|----|----|
| ***voie 1*** | *contracter d'abord — demande `Exch(q₁, q₂)` — puis substituer* |
| ***voie 2*** | *substituer d'abord, ce qui donne `r·q₁` et `r·q₂`, puis contracter — demande \*/~Exch(r·q₁, r·q₂)~\** |

\*/LA CONDITION EST DONC LA STABILITÉ DU PRÉDICAT PAR MISE À L'ÉCHELLE : `Exch(q₁,q₂) ⟹ Exch(r·q₁, r·q₂)`, exactement comme `Cont(m)` absorbe la multiplication en tant qu'idéal./\* *La symétrie est parfaite, et c'est bon signe : le prédicat doit être à l'échange ce que l'idéal est à la contraction.*

1.  ***ET C'EST ICI QUE J'AVAIS TORT***

    *J'ai écrit plus haut que la ZONE serait une composante de GRADE, donc couverte gratuitement par le critère de B-17. Le calcul le dément.* /Une composante de grade est une coordonnée d'un SEMI-ANNEAU, donc munie d'une multiplication à unité bilatère. Pour que la mise à l'échelle ne déplace pas une liaison d'une zone à une autre, il faudrait `r · z = z` sur cette coordonnée. Or une telle multiplication n'a pas d'unité à droite — `x · 1 = 1 ≠ x` — et ne fait donc pas un semi-anneau./

    > ***LA ZONE N'EST PAS UNE COMPOSANTE DE GRADE. ELLE EST LE MODE LUI-MÊME.***

    /Et c'est déjà dans la structure de la source, que l'acquis B-7 relève sans en tirer ceci : Grass fait coexister des grades d'ALGÈBRES DIFFÉRENTES, un mode portant sa propre algèbre. Une zone est donc un mode ; deux liaisons de modes distincts s'échangent librement, faute d'ordre commun ; à l'intérieur d'un mode, `Exch` s'applique./ \*/LA STABILITÉ PAR MISE À L'ÉCHELLE DEVIENT ALORS AUTOMATIQUE : `r` et `q` vivent dans la même algèbre, donc dans le même mode, donc dans la même zone. Le produit ne sort pas de la zone parce qu'il n'a pas où sortir./\*

2.  CE QUE LA CORRECTION COÛTE, ET CE QU'ELLE RAPPORTE

    |  |  |
    |----|----|
    | ***elle coûte*** | *la gratuité. La zone ne relève plus du critère de B-17 : ce n'est pas une coordonnée qui s'ajoute sans preuve, c'est une structure de MODE, qui se paie au prix de Grass* |
    | ***elle rapporte*** | *la difficulté de semi-anneau disparaît, la stabilité par mise à l'échelle devient automatique, et le dispositif se loge dans une structure que la source POSSÈDE DÉJÀ au lieu d'en demander une nouvelle* |
    | ***et elle confirme*** | *la distinction posée le 2 septembre — une composante de grade et une donnée de mode ne se paient pas au même prix — en montrant que je l'avais moi-même mal appliquée. La zone était du second côté depuis le début* |

    ***VERDICT : LA COMMUTATION TIENT, ET LE CALCUL A SERVI À AUTRE CHOSE QU'À LA VÉRIFIER — il a déplacé la zone du grade vers le mode, ce qu'aucune des trois instructions n'avait vu.*** \*/LE RISQUE DE 1C EST DONC ENTIÈREMENT INSTRUIT. Aucune des trois obligations ne tombe. Ce qui reste est du travail nommé : un calcul de commutation, une sur-approximation à restreindre, et une dérivation linéaire à établir./\*

#### LA DÉRIVATION LINÉAIRE DE L'HISTOMORPHISME — *ce qu'elle demande*

/La source dit ce qui manque et où le chercher : la construction directe applique l'algèbre au résultat d'une TRACE, d'où le comportement quadratique ; la version linéaire « collapse » le schéma en un pli qui n'invoque l'algèbre qu'UNE FOIS PAR NIVEAU, et le détail en est renvoyé à un travail antérieur des mêmes auteurs, hors du périmètre de la pièce lue./ ***CE N'EST DONC PAS UNE RECHERCHE MAIS UNE PIÈCE À VERSER.*** /L'obligation, pour K7PL, est double : obtenir la dérivation linéaire, et vérifier qu'elle survit à la TRONCATURE par le grade `r` — un pli qui n'invoque l'algèbre qu'une fois par niveau sur un historique tronqué à `r` niveaux reste linéaire en la taille de l'entrée, mais l'écrire demande de refaire le collapse sous la troncature./ :A_VERSER: *Hinze et Wu, 2013 — la dérivation linéaire. À chercher au fonds, sinon à sourcer*

## A.3.8 — *LES TROIS MORPHISMES DE MODES* **— RÉDIGÉ, et la preuve est plus courte qu'annoncé**

### L'énoncé

    Théorème (la chaîne modale est une chaîne de morphismes de modes).
    Les trois fragments Lin, Aff, Unr sont les trois modes portés par les sous-ensembles
        {1}  ⊂  {0,1}  ⊂  {ω}↓     de ℛ,
    et les deux inclusions sont des morphismes de modes. La chaîne Lin <: Aff <: Unr
    en est la traduction induite.

:CITATION: `cite:@hanukaevUnificationGradedSubstructural2026` *(fonds, PDF, lu en partie)* *Le chapitre 3 pose déjà les trois sous-ensembles ; le chapitre 2 pose déjà la chaîne comme « pendant exact » de la stratification catégorique. Ce qui manquait est le lien.*

### L'esquisse — *deux conditions, et l'une est vide deux fois*

*La condition de morphisme de modes est explicite chez Grass : tout grade CONTRACTABLE de la source s'envoie sur un contractable du but, et l'AFFAIBLISSEMENT se propage vers l'avant.*

|  |  |  |  |
|----|----|----|----|
| ***mode*** | ***sous-ensemble*** | ***contractables*** | ***affaiblissement*** |
| `Lin` | `{1}` | *aucun* | *non* |
| `Aff` | `{0,1}` | *aucun* | ***oui*** — *le 0 est disponible* |
| `Unr` | `{ω}↓` | ***ω*** | ***oui*** |
| ***condition 1*** | *satisfaite VIDEMENT deux fois : les contractables de `Lin` et de `Aff` forment l'ensemble vide, et toute fonction envoie le vide où l'on veut* |  |  |
| ***condition 2*** | *satisfaite par monotonie du booléen d'affaiblissement le long de la chaîne : non → oui → oui* |  |  |

***LA PREUVE EST DONC DE DEUX LIGNES, ET C'EST L'ARC B QUI L'AVAIT ANNONCÉ : « ce n'est plus une question de recherche, c'est une preuve à écrire ».***

### Le corollaire qui referme le transport gradué de l'arc A

*Grass établit qu'un morphisme de modes induit une TRADUCTION qui n'est pas l'identité sur les types et les termes, ceux-ci portant des annotations de grade à transporter le long du morphisme.*

> ***ICI LES MORPHISMES SONT DES INCLUSIONS DE SOUS-ENSEMBLES D'UN MÊME `ℛ`, DONC LES TRADUCTIONS INDUITES SONT DES IDENTITÉS SUR LE GRADE. Le transport est trivial.***

/Et c'est CELA qui explique ce que le document faisait sans le dire : il écrit la chaîne comme du pur sous-typage, sans jamais transporter d'annotation, et il avait raison — mais par accident, la trivialité du transport n'étant nulle part énoncée./ \*/L'ÉCRIRE FERME DEUX CHOSES D'UN COUP : la dérivation de la chaîne, et la question du transport gradué restée ouverte à l'arc A. Elle ne se ferme pas par une construction mais par le constat que dans ce cas-ci il n'y a rien à transporter./\*

### **LIEU D'INSERTION** : *chapitre 2, au voisinage de la stratification catégorique ; le corollaire au chapitre 3, où la chaîne est employée.*

## A.3.7 — *LA COHÉRENCE DE LA SUBSOMPTION* **— RÉDIGÉ, et sa condition est VÉRIFIÉE**

### L'énoncé

    Théorème (unicité de la signification).
    Un programme valide a exactement une signification, quelle que soit la dérivation qui le type.

:CITATION: `cite:@schwinghammerCoherenceSubsumptionMonadic2009` — `10.1017/S0956796808006886` *(fonds, PDF, lu)* *K7PL a DEUX règles interstitielles —* `Sub` *sur les calculs,* `SubBox` *sur les grades — et plusieurs dérivations typent le même programme dès qu'elles existent. Rien n'énonce qu'elles s'accordent.*

### L'esquisse, et la source en donne la forme

|  |  |
|----|----|
| **1** | *interpréter chaque sous-typage par une FONCTION DE CONVERSION* |
| **2** | *éliminer réflexivité et transitivité des dérivations* |
| **3** | *pousser la subsomption à travers les règles d'introduction, jusqu'à l'unicité des dérivations* |

### LA CONDITION EST L'EXISTENCE DE JOINTURES, ET ELLE EST SATISFAITE — *vérifié le 2 septembre*

/L'annexe pose `⊑_{<:}` comme le PRODUIT MIXTE `(≥) × (⪰) × (≤) × (≤)` sur `ℛ`, chaque composante ayant sa direction propre. Un produit d'ordres a ses jointures si et seulement si chaque facteur a les siennes, prises composante par composante./

|  |  |  |
|----|----|----|
| *usage* `u` | *ordre `≥`* | \*/jointure = MINIMUM dans l'ordre naturel de/ `ℕ∞` — *existe* |
| *monotonie* `m` | *ordre `⪰` sur deux points* | \*/chaîne à deux éléments/ — *existe* |
| *niveau* `ℓ` | *ordre `≤` du treillis* `ℒ` | \*/jointure du treillis/ — *existe par définition* |
| *budget* `β` | *ordre `≤` sur* `ℕ∞` | \*/jointure = MAXIMUM/ — *existe* |

***LES QUATRE FACTEURS ONT LEURS JOINTURES BINAIRES, DONC `⊑_{<:}` AUSSI. La condition de la preuve est acquise, et elle ne demande aucune structure nouvelle.***

/Et cela s'accorde exactement avec A.2.8, qui avait établi sur le texte que le document n'emploie JAMAIS la rencontre et sept fois le joint. Deux constats indépendants, même conclusion : c'est un DEMI-TREILLIS SUPÉRIEUR qu'il faut, et c'est ce qu'il y a./ ***L'ANNEXE EMPLOYAIT DÉJÀ CES JOINTURES SANS SAVOIR QU'ELLES ÉTAIENT LA CONDITION D'UN THÉORÈME QU'ELLE N'AVAIT PAS ÉNONCÉ. C'est l'item C-3, et il se referme ici.***

### L'avertissement de portée, à écrire avec le théorème et non après

*La règle de Breazu-Tannen pour les universels bornés — celle qui permet le sous-typage contravariant des bornes — est INCOMPATIBLE avec ces jointures. K7PL a des universels et des sommes.* ***S'IL VEUT UN JOUR BORNER SES QUANTIFICATEURS, IL DEVRA ABANDONNER L'UN DES DEUX. Le dire au moment où l'on acquiert les jointures coûte une phrase ; le découvrir plus tard coûte le théorème.***

### **LIEU D'INSERTION** : *annexe formelle, immédiatement après `SubBox` et `tab:produit-mixte`, qui en portent les données.*

## A.3.1 — *LA COMPLÉTUDE GRADUÉE* **— RÉDIGÉ, avec une DÉPENDANCE que l'ordre n'avait pas vue**

### L'énoncé, et il faut le rendre réfutable

/La forme d'origine — « toute valeur est permise dans tout contexte dont elle satisfait le grade et la couche ; et il n'existe aucune restriction qui ne soit exprimée dans le jugement » — se lit comme une déclaration d'intention. Sous cette forme elle ne se réfute pas, donc elle ne se démontre pas./

    Théorème (complétude graduée, forme réfutable).
    L'ensemble des programmes REJETÉS par le vérificateur est exactement l'ensemble des
    programmes pour lesquels AUCUNE dérivation n'existe.
    Autrement dit : aucun rejet n'a lieu hors du système de types.

:SOURCE: *le principe de complétude de Reynolds, 1970, dans sa version graduée* :CITATION: `cite:@reynoldsGEDANKENSimpleTypeless1970` *(fonds, PDF)* ***SOUS CETTE FORME, LE THÉORÈME EST VÉRIFIABLE PAR ÉNUMÉRATION : chaque code d'erreur du vérificateur doit être une dérivation qui échoue, et non une condition de bord vérifiée à côté.***

### Ce que le théorème rend, et c'est ce que c5 affirme sans preuve

/~ERR-TOP-001~ — le rejet d'une imbrication de délimiteurs — « découle directement des spécialisations du jugement germinal », écrit le chapitre 5. C'est une conséquence revendiquée et non démontrée. Le théorème la démontre : `ERR-TOP-001` est le nom d'un échec de dérivation, non une règle de plus./ *L'audit des dix-huit l'a vérifié À LA MAIN sur les quatre catégories ; le passer en théorème est ce qui le rend transportable en LEAN.* **R-55.**

### ***LA DÉPENDANCE, ET ELLE EST BLOQUANTE***

> ***A.3.1 NE PEUT PAS ÊTRE ÉNONCÉ AVANT QUE A.2.2 SOIT TRANCHÉ, PARCE QUE A.2.2 EST UN CONTRE-EXEMPLE CONNU À A.3.1.***

/A.2.2 le dit dans ces termes : la frontière de confiance est « le seul manquement réel à la complétude graduée que l'audit des dix-huit ait trouvé », avec trois franchissements « traités différemment sans que rien ne justifie cet écart » — la Phase 0, l'effet `Import`, la capacité exportée par la passerelle FFI./ ***TROIS RESTRICTIONS QUI NE SONT PAS DANS LE JUGEMENT. Énoncer A.3.1 sans les traiter serait énoncer un théorème dont on connaît le contre-exemple.*** *ACTION D'ORDRE : A.2.2 remonte AVANT A.3.1. L'ordre d'exécution du programme ne le disait pas, et il le dira.*

### UNE HOMONYMIE À NE PAS COMMETTRE, ET JE VIENS D'EN COMMETTRE UNE AUTRE LE MÊME JOUR

/Le chapitre 5 invoque la COHÉRENCE — « le fait qu'un programme valide ait exactement une signification » — comme propriété conditionnante de la recherche dirigée par le type qui résout `bind-to`, avec trois citations, et conclut : « la cohérence est une condition d'erreur, non une obligation de métathéorie »./ *C'est mot pour mot l'énoncé de A.3.7.* ***MAIS CE NE SONT PAS LE MÊME OBJET, ET LE DIRE IMPORTE PLUS QUE LE RAPPROCHEMENT.*** /A.3.7 porte sur les dérivations de SUBSOMPTION ; le chapitre 5 porte sur la résolution d'une RECHERCHE. Deux instances d'un même schéma d'énoncé, non deux formulations d'un même théorème./ /Ce qu'on peut écrire sans transporter : le document énonce DEUX FOIS le schéma « un programme valide a exactement une signification », à deux endroits, pour deux objets, sans le remarquer. Que la preuve de A.3.7 s'étende ou non à la recherche est une question distincte, et elle n'est pas instruite./ :CITATIONS: `cite:@racordonStateCoherenceLand2025`, `cite:@BOTTU`, `cite:@schrijversCOCHISStableCoherent2019`

## A.3.2 — *LA STATICITÉ DE LA SYNTAXE* **— RÉDIGÉ**

### L'énoncé

    Théorème (la syntaxe est fixée avant toute exécution).
    Aucune construction de K7PL ne calcule un nom ; toute opération d'espace de noms vit au
    niveau macro, où elle est typée par `binds` ; par conséquent la syntaxe d'un programme
    est FIXÉE avant toute exécution.

:SOURCE: `cite:@saalConsiderationsDesignCompiler1978` *(fonds)* *« La syntaxe d'une instruction APRÈS exécution peut être DIFFÉRENTE de ce qu'elle était AVANT » — c'est ce qui rend APL non compilable statiquement, et cette phrase est* **inécrivable** *pour K7PL.*

### L'esquisse — *par inspection, et elle est courte*

|  |  |
|----|----|
| **1** | *La seule construction qui produit un AST est la MACRO, fonction pure de couche 2 qui reçoit un AST et en retourne un autre* |
| **2** | *Elle s'exécute en PHASE 0, dans un bac à sable, AVANT toute exécution du programme* |
| **3** | *Son type porte la portée : un AST indexé par une portée ne peut produire d'occurrence hors de cet index — c'est `binds`, et c'est déjà le théorème d'hygiène* |
| **4** | *Aucune règle du jugement germinal ne construit un nom à partir d'une valeur* |

***LA CONCLUSION SUIT : après la Phase 0, l'arbre ne change plus. C'est la compilabilité statique, et c'est ce que le chapitre 3 achète sans le compter.***

### Ce que le théorème ajoute, et c'est l'argument que le document n'a pas fait

*Le chapitre 3 justifie le confinement de la Phase 0 par la ***SÛRETÉ***. Il achète aussi la ***COMPILABILITÉ***, et personne ne le dit.* *Deux bénéfices pour un dispositif, dont un seul est revendiqué — et c'est le second qui parle au lecteur venu d'un langage dynamique.*

### La réserve à porter, et elle est nommée dans le document

/~bind-to~ est « la seule construction du langage dont l'existence ne se déduise pas du jugement germinal ». Le chapitre 5 la traite en montrant que ce n'est pas une primitive mais un accès de champ, la seconde composante étant remplie par recherche dirigée par le type./ ***ET CETTE RECHERCHE A LIEU EN PHASE 0 — « une recherche ambiguë est refusée en Phase 0 plutôt que résolue arbitrairement ». Elle ne menace donc PAS la staticité : elle s'achève avant l'exécution.*** *À vérifier tout de même à la rédaction, parce que c'est le seul endroit du langage où un nom est PRODUIT plutôt que lu, et qu'un théorème de staticité doit avoir regardé ce cas-là.*

### **LIEU D'INSERTION** : *chapitre 5, à la section de la métaprogrammation ; l'argument de compilabilité au chapitre 3, où le confinement est justifié.*

## A.3.6 — *LA CORRECTION DE RESSOURCE* **— RÉDIGÉ, et c'est le plus lourd**

### Ce que le document a, et ce qui manque

|  |  |
|----|----|
| *la configuration de réduction porte* | **un état d'arène** `μ` *et* **une trace d'effets** `τ` |
| *elle ne porte pas* | ***un compteur d'usages de variables*** |

/~thm:preservation~ dit que le type se conserve et que le potentiel ne croît pas ; `thm:progres` dit qu'un calcul bien typé avance. Ni l'un ni l'autre ne dit que le GRADE COMPTE CE QU'IL PRÉTEND COMPTER./ \*/LE GRADE EST DONC UNE GRANDEUR PUREMENT STATIQUE, ET P3 LE RÉCLAME : le postulat exige que rien ne dissimule un coût, et le grade EST la mesure de ce coût. Un grade relié à rien d'observable dissimulerait tout./\*

### L'énoncé

    Théorème (correction de ressource).
    Étendre la configuration d'un compteur d'usages κ, de sorte que la relation devienne
        ⟨ c | μ | τ | κ ⟩ ⟶ ⟨ c' | μ' | τ' | κ' ⟩,
    où κ compte les accès effectifs à chaque liaison. Alors pour tout Δ ⊢ c : C | ε,
    toute exécution depuis c satisfait, liaison par liaison,
        κ(x)  ≤  la composante d'usage du grade de x dans Δ.

### Quatre sources indépendantes, et chacune donne une pièce différente

|  |  |  |
|----|----|----|
| `cite:@erikssonGradedModalType2025` | ***la FORME*** | *une machine qui compte : les accès au tas correspondent aux références de variables, et la machine les suit* |
| `cite:@choudhuryGradedDependentType2021` | ***les CONSÉQUENCES*** | *GraD en dérive trois propriétés — sûreté du typage, non-interférence des ressources non pertinentes, et PROPRIÉTÉ DU POINTEUR UNIQUE pour les linéaires, celle qui autorise la mise à jour en place, donc celle qui intéresse l'arène* |
| `cite:@mannucciResourceBoundedTypeTheory2025` | ***le MOT*** | *un treillis de ressources sous BUDGET, avec théorème de correction de coût. Des quatre, la seule dont l'énoncé emploie le même mot que K7PL pour la même chose* |
| `cite:@kavvosRecurrenceExtractionFunctional` | ***la FACTORISATION*** | *extraction syntaxique vers une récurrence avec théorème de borne, puis sémantique dénotationnelle du langage des récurrences. Et le tout dans le calcul par poussée de valeur* |

***LA FACTORISATION DE KAVVOS EST CE QU'IL FAUT SUIVRE, ET LA DÉCISION DU 2 SEPTEMBRE LA REND NÉCESSAIRE ET NON PLUS SEULEMENT ÉCONOME.*** /Une extraction et UNE INTERPRÉTATION PAR COMPOSANTE, plutôt qu'un théorème par composante : le grade étant ouvert, un théorème par composante devrait être rouvert à chaque extension, une interprétation de plus ne rouvre rien./

### Trois avertissements, tous portés par les sources

|  |  |
|----|----|
| **1** | *GraD n'a établi la correction qu'au prix d'une RESTRICTION SUR LE FILTRAGE que la sûreté non graduée n'exigeait pas. Retenu au bloc C sous C0* |
| **2** | *Mannucci ne vaut que pour le fragment simplement typé SANS RÉCURSION. Ce n'est pas un résultat à transporter mais une forme à suivre* |
| **3** | ***Ce théorème n'est pas un de plus : TROIS AUTRES EN DESCENDENT, et deux sont déjà au document sous forme non graduée. C'est ce qui en fait le plus lourd et le plus rentable*** |

### **LIEU D'INSERTION** : *annexe formelle, après `thm:preservation` et `thm:progres`, dont il étend la configuration.*

## A.3.4 — *L'ABAISSEMENT PRÉSERVE LES GRADES* **— RÉDIGÉ**

### D'où vient la lacune

/A.1.2 l'a révélée : `thm:preservation_type` du chapitre 3 couvre « par évaluation OU PAR ABAISSEMENT MLIR », sans grade ; l'énoncé gradué de l'annexe, `thm:preservation`, ne couvre que l'ÉVALUATION./ ***ISOLER LE VOLET ABAISSEMENT — ce que A.1.2 demande — FAIT APPARAÎTRE QU'IL N'A PAS D'ÉNONCÉ GRADUÉ. Rien n'établit que descendre vers MLIR préserve les grades.***

### L'énoncé

    Théorème (l'abaissement préserve le jugement gradué).
    Si Δ ⊢ c : C | ε et si ⟦c⟧ est son image par l'abaissement vers MLIR,
    alors il existe une traduction ⟦Δ⟧, ⟦C⟧, ⟦ε⟧ telle que
        ⟦Δ⟧ ⊢ ⟦c⟧ : ⟦C⟧ | ⟦ε⟧,
    et la traduction ne relâche aucune des quatre composantes du grade.

### Pourquoi c'est celui qui relie les deux bouts du document

/C'est une lacune de CONTINUITÉ, exactement le genre que la doctrine demande de chercher : le chapitre 1 pose le grade, le chapitre 6 descend vers MLIR, et rien ne dit que ce qui a été garanti en haut survit en bas./ /Et l'arc I l'avait déjà à demi refermé : les grades survivent SI la traduction préserve les types. La condition est donc connue ; ce qui manque est de l'écrire comme un énoncé plutôt que comme une observation./ \*/APPUI DISPONIBLE ET NON EMPLOYÉ : le critère de compilation à préservation de types, et la distinction entre pleine abstraction et préservation de comportement/ — `cite:@pattersonNext700Compiler`.

### **LIEU D'INSERTION** : *chapitre 6, à la descente vers MLIR ; avec renvoi depuis le chapitre 3, où `thm:preservation_type` devient un corollaire pour le seul volet évaluation.*

## A.3.3 — *L'INTERFACE D'UNE UNITÉ DE COMPILATION EST SON JUGEMENT* **— RÉDIGÉ**

### L'énoncé

    Théorème (le jugement EST l'interface).
    Δ ⊢_𝒢 t : A ∣ ℰ porte exactement les trois choses qu'une interface doit énoncer :
        ce que l'unité EXIGE (Δ),  ce qu'elle EST (A),  ce qu'elle PRODUIT (ℰ).

:CITATIONS: `cite:@macqueenHistoryStandardML2020`, `cite:@hudakHistoryHaskellBeing2007` *(fonds, PDF)*

### Trois pièces dans trois chapitres, et rien ne les relie

|                                             |                |
|---------------------------------------------|----------------|
| *la théorie des modules*                    | **chapitre 4** |
| *le grade porté par l'unité de compilation* | **chapitre 6** |
| *le jugement à trois composantes*           | **chapitre 1** |

***LE THÉORÈME EST LA JONCTION. Et il referme R-48 : si le grade est dans l'interface, le changer change l'interface, donc les dépendants recompilent — LA TRANSLUCIDITÉ EST L'HONNÊTETÉ.*** **R-65.**

### L'esquisse, et elle se conduit par les deux échecs symétriques

*SML §5.7 et Haskell §8.2 sont les deux échecs, et ils sont symétriques : l'un a des signatures riches sans effets, l'autre des effets sans signatures. K7PL a les deux dans un seul jugement.* *L'idée écartée de Milner, 1983, donne le troisième point de comparaison.* \*/L'ESQUISSE N'EST PAS UNE PREUVE MAIS UNE MONSTRATION : montrer que les trois obligations d'une interface s'écrivent chacune dans une composante, et qu'aucune ne déborde. C'est vérifiable par énumération sur les formes de déclaration du chapitre 6./\*

### **LIEU D'INSERTION** : *chapitre 6, à la section des unités de compilation, avec renvois vers les chapitres 1 et 4.*

## A.1.3 — *LA PROGRESSION, PARAMÉTRÉE PAR LA COUCHE* **— RÉDIGÉ, décision 2C**

### Les deux énoncés que le document a déjà, et ce qu'ils ont en commun

|  |  |
|----|----|
| `thm:terminaison_couche_3` | *« Terminaison par pli dépendamment typé » — un pli sur `μF` dont le type porte un indice de taille `i`, l'appel récursif un indice strictement inférieur. La décroissance est un FAIT DE TYPAGE* |
| `thm:productivite_couche_2` | *« Progression par anamorphisme typé » — un flux `s : S → νG` dont le type porte un indice de taille décroissant AU SENS DUAL, produit une valeur observable en un nombre fini d'étapes* |

***LE CHAPITRE 2 ÉCRIT DÉJÀ LE RAPPROCHEMENT, DEUX FOIS ET DANS LES DEUX SENS*** : *« la même idée lue deux fois — une fois dans *C*, une fois dans *C* opposée », et « le critère est ici LE DUAL EXACT de celui de la terminaison, et pour la même raison ».* *Il ne restait qu'à faire ce qu'il annonce.*

### L'énoncé paramétré

    Théorème (progression, paramétrée par la couche).
    Soit ℓ une couche polarisée et p(ℓ) sa polarité, donnée par tab:sedimentation :
        p(3) = μ        p(2) = ν
    Soit F un conteneur. Un calcul de couche ℓ défini sur p(ℓ)F par un schéma dont le type
    porte un indice de taille décroissant AU SENS DE p(ℓ) progresse en un nombre fini d'étapes,
    la progression s'entendant :
        en p = μ, jusqu'à ÉPUISEMENT de la structure        — c'est la terminaison ;
        en p = ν, jusqu'à PRODUCTION d'une observation      — c'est la productivité.

:CITATION: `cite:@abelWellfoundedRecursionCopatterns2016` *(fonds, PDF)* — *« la productivité devient une INSTANCE de la terminaison », et un traitement UNIFIÉ de la récursion et de la corécursion*

### L'esquisse — *une induction, lue deux fois*

/Par bien-fondation de l'ordre sur les tailles, dans `C` pour `p = μ` et dans `C` opposée pour `p = ν`. La décroissance étant un fait de typage et non une inspection syntaxique, l'argument ne dépend pas de la forme du terme, donc il ne dépend pas de la polarité : c'est le même argument, et c'est pourquoi le document pouvait écrire « pour la même raison » sans le démontrer./ ***LES DEUX INSTANCES SE RETROUVENT VERBATIM en spécialisant `ℓ`, ce qui est le critère qu'une paramétrisation doit satisfaire : ne rien perdre de ce qu'elle remplace.***

### ***LE MOT QUI PORTE TOUT LE TRAVAIL, ET IL FAUT LE DIRE***

> ***Les deux conclusions actuelles ne sont pas littéralement duales : l'une dit « l'évaluation termine », l'autre « produit une valeur observable en un nombre fini d'étapes ».***

*Trouver le mot dont ces deux-là sont les lectures EST le travail de A.1.3, et c'était le risque annoncé de l'option 2C. Je propose ***PROGRESSION***, avec ses deux lectures explicitement écrites dans l'énoncé — épuisement d'un côté, production de l'autre.* /Le mot n'est pas neutre : le document a déjà un `thm:progres` à l'annexe, qui dit qu'un calcul bien typé avance. La parenté est réelle et non fortuite, mais ce n'est PAS le même théorème — celui-ci porte sur les schémas de récursion, celui-là sur la relation de réduction. À distinguer explicitement à la rédaction, sous peine de fabriquer l'homonymie qu'on vient de corriger ailleurs./

### ***LA LIMITE DU PARAMÈTRE, ET ELLE CONFIRME LE VOCABULAIRE***

/La sédimentation a TROIS couches, la polarité en a DEUX pôles. La couche 1 — linéaire, capabilités sous `⊗` — n'est ni `μ` ni `ν` : elle n'a pas de théorème de progression de cette famille, et elle n'en a pas besoin, ses ressources étant uniques et non parcourues./ ***LE PARAMÈTRE COURT DONC SUR LES DEUX COUCHES POLARISÉES, NON SUR LES TROIS.***

> ***ET C'EST EXACTEMENT LA FRONTIÈRE QUE LE VOCABULAIRE D'EXÉCUTION PORTE DÉJÀ : la FIBRILLE couvre les couches 2 et 3, la FIBRE est la couche 1 et porte un autre mot.***

/Le vocabulaire avait raison avant le théorème : il donne un mot séparé là où la polarité s'arrête, et un seul mot là où elle s'applique. C'est la confirmation de ARB-3 par un chemin indépendant, et elle vaut d'être écrite parce qu'elle transforme un choix de nommage en une lecture de la théorie./

### **LIEU D'INSERTION** : *chapitre 2, à la place des deux théorèmes actuels, qui deviennent ses deux instances nommées. `tab:sedimentation` reçoit au chapitre 1 la mention qu'elle porte la polarité (A.2.3).*

## A.1.1 — *LA FUSION DES DEUX THÉORÈMES DE COHÉRENCE* **— RÉDIGÉ, purement mécanique**

### Le constat, vérifié une fois de plus le 2 septembre

|  |  |
|----|----|
| `c1:259` | `\begin{theorem}[cohérence de φ et ψ]\label{thm:coherence_axiome}` |
| `annexe:656` | `\begin{theorem}[cohérence de φ et ψ]\label{thm:coherence_phi_psi}` |
| *les deux* | `r · ψ(Δ, ε) = ψ(r · Δ, φ_r(ε))` |

*Même titre, même énoncé, même formule. Et l'annexe cite déjà celui de c1 à sa ligne 681 — le document sait, à un endroit, qu'il les a tous les deux.*

### L'action, et les renvois sont relevés

***GARDER `thm:coherence_axiome`. SUPPRIMER `thm:coherence_phi_psi`. REDIRIGER LES TROIS RENVOIS DE L'ANNEXE — lignes 695, 1047 et 1190.*** *Ce sont les trois seuls ; la sonde a été faite sur les deux étiquettes à la fois, dans tout `src/`.*

### L'effet sur les comptages, et il ne se prend PAS d'avance

*Le document a 33 théorèmes, non 34. Le contrôle en compte aujourd'hui 34 et il a raison, la fusion n'étant pas faite.* \*/LE PLANCHER DU CONTRÔLE S'AJUSTE APRÈS LA FUSION, JAMAIS AVANT. L'ajuster d'avance ferait passer un contrôle sur un document qui n'a pas encore changé, ce qui est exactement ce qu'un contrôle doit empêcher./\*

## LE CRITÈRE D'EXTENSION DU GRADE — *ARB-4, et il se lit sur B-17*

### Ce qui est acquis, et ce qui reste à écrire

/B-17 établit que l'ouverture du grade est DÉJÀ démontrée au chapitre 2 — le produit se compose coordonnée par coordonnée — et déjà PRATIQUÉE au chapitre 1, la confidentialité y étant une composante ajoutée après coup et déclarée conforme./ ***IL NE RESTE DONC PAS UNE PERMISSION À ACCORDER MAIS UN CRITÈRE À ÉNONCER.***

### Le critère, en trois conditions

    Une composante nouvelle s'ajoute au grade sans rien redémontrer si et seulement si :
      (1) elle est une STRUCTURE ORDONNÉE ;
      (2) ses opérations se définissent COORDONNÉE PAR COORDONNÉE, l'ordre du produit
          étant pris point par point ;
      (3) elle se place dans l'une des trois strates du critère du chapitre 1 —
          coeffet, effet, ou raffinement — une composante de grade étant un coeffet,
          donc se projetant sur Δ.

:CITATIONS: `cite:@liepeltSameCoeffectDifferent2026`, `cite:@choudhuryDependentDependencyCalculus2022` *(fonds, PDF)*

### Le prix, que le chapitre 2 donne aussi et qu'il faut porter avec le critère

/« Un produit de structures ordonnées est plus LARGE que l'ensemble des grades qu'un programme peut effectivement former » — des grades existent dans le produit sans être DÉRIVABLES, faute que les coordonnées croissent au même rythme./ \*/CHAQUE COMPOSANTE NOUVELLE ÉLARGIT CETTE RÉGION. Le vérificateur doit signaler une annotation bien formée et non dérivable comme telle, plutôt que d'échouer plus loin sur une unification qui n'aboutira pas./\* /Le critère et son prix s'écrivent ensemble : un critère qui n'énonce que ce qui est permis fait croire que l'extension est gratuite, et elle ne l'est pas — elle est SANS PREUVE NOUVELLE, ce qui n'est pas la même chose./

### La mise en garde de nature, tirée de l'instruction de A.3.10

> ***UNE COMPOSANTE DE GRADE ET UNE DONNÉE DE MODE NE SE PAIENT PAS AU MÊME PRIX, et « paramétrer le grade » les confondait.***

|  |  |
|----|----|
| ***composante de GRADE*** | *coordonnée du produit — l'âge, le lien, la zone. Couverte par le critère ci-dessus, donc SANS PREUVE NOUVELLE* |
| ***donnée de MODE*** | *le prédicat d'échange, au même rang que l'idéal de contraction et le booléen d'affaiblissement. NON couverte : les opérations point par point n'ont rien à dire d'une règle structurelle* |

*C'est A.3.10, et c'est le seul item du programme qui puisse échouer.*

### **LIEU D'INSERTION** : *chapitre 1, à l'endroit où le grade est introduit, avec renvoi vers la section du produit au chapitre 2 qui en porte la preuve.*
