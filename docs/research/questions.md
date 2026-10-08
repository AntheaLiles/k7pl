# K7PL — les ensembles de questions de recherche

28 août 2026

## QUESTIONS DE RECHERCHE

### \[DONE\] \[#A\] La catégorie que le chapitre 2 emploie est-elle celle de CO-KLEISLI ou celle d'EILENBERG-MOORE ?

    ARC: A | QUID: QA-1 | REF

Close le 28 août par relecture du chapitre 2, sans ouvrir de source. Le chapitre retient explicitement la factorisation de Kleisli, construit la catégorie de co-Kleisli comme réalisation de la partie non contrainte du contexte, anticipe la difficulté du tenseur sur les coalgèbres libres en écrivant que la catégorie obtenue est isomorphe à la catégorie de co-Kleisli, et donne le produit comme tenseur restreint. Ma question supposait un écart entre le chapitre et une source ; il n'y en a pas, et j'avais signalé sans relire.

#### Suivi d'avancement

1.  \[DONE\] le manuscrit lui-même

### \[DONE\] \[#A\] Le produit de cette catégorie est-il `×` ou `⊗` ?

    ARC: A | QUID: QA-2 | REF

Le produit est le tenseur restreint, et le chapitre 2 le dit. Close en même temps que la précédente, et par le même moyen.

#### Suivi d'avancement

1.  \[DONE\] le manuscrit lui-même

### \[DONE\] \[#A\] La factorisation de Fujii-Katsumata-Melliès que c1 retient — « celle généralisant Kleisli » — est-elle compatible avec l'énoncé de cartésianité du chapitre 2 ?

    ARC: A | QUID: QA-3 | REF

Oui. La factorisation généralisant Kleisli que retient le chapitre 1 est compatible avec l'énoncé de cartésianité du chapitre 2, puisque celui-ci porte sur la catégorie de co-Kleisli et non sur celle d'Eilenberg-Moore. Les trois questions tombaient ensemble et la fausse alerte est retirée.

#### Suivi d'avancement

1.  \[DONE\] le manuscrit lui-même

### \[DONE\] \[#A\] Une comonade linéaire exponentielle graduée a-t-elle des OPÉRATIONS canoniques au delà de `extract` et `duplicate` ? *Les morphismes de sous-gradation en sont-ils ?*

    ARC: A | QUID: QA-4 | REF

Oui, et la réponse est plus forte qu'attendu. Toute catégorie de Lafont à biproduits finis est une catégorie différentielle, et la codéréliction y est unique : si l'exponentielle est libre et que la catégorie a des biproduits finis, l'opération existe qu'on la veuille ou non. La question devient donc celle de savoir si la catégorie ambiante de K7PL est de Lafont et si elle a des biproduits finis. La polarisation de l'appel par poussée de valeur paraît l'en protéger, puisque la somme indexée est un type de valeur et la conjonction additive un type de calcul, de sorte qu'ils ne peuvent pas coïncider en un biproduit. À vérifier, car la question porte sur la catégorie ambiante et non sur la grammaire.

#### Suivi d'avancement

1.  \[DONE\] lemayCoderelictionsFreeExponential2021

### \[DONE\] \[#A\] La décomposition `□_r A = Grd_r (Lin A)` de Vollmer transporte-t-elle à `!_ω` ?

    ARC: A | QUID: QA-5 | REF

Oui, et sans rien demander — la lecture du 2 septembre le rend immédiat, et donne au passage la forme générale. LA RÉSOLUTION D'UNE COMONADE GRADUÉE EST UN LEMME, non un cas par cas. Une adjonction L ⊣ R : M → C et une ACTION MONOÏDALE STRICTE ⊙ : R × C → C induisent ensemble la comonade graduée □\_r = L(r ⊙ R(−)). Le Grd_r du document est L(r ⊙ −), le Lin est R. L'ACTION EST DÉFINIE UNIFORMÉMENT SUR R. ω n'est qu'un élément de R comme les autres, et rien dans la résolution ne le distingue : le transport à !\_ω est le cas r = ω du même énoncé. La question supposait qu'il fallait le vérifier ; il n'y a rien à vérifier. ET LA LECTURE DONNE PLUS QUE LA RÉPONSE. Le système entier se lit comme la logique linéaire/non-linéaire de Benton COMPOSÉE AVEC UNE ACTION QUI AJOUTE LA GRADATION. La gradation n'est donc pas une propriété de la catégorie mais quelque chose qu'on y compose — ce qui sépare nettement ce qui relève de la structure de ce qui relève du paramétrage, et sert directement QA-28.

#### Suivi d'avancement

1.  \[DONE\] vollmerMixedLinearGraded2024

### \[DONE\] \[#A\] Benton 1993 pose l'adjonction LNL. Quelles de ses HYPOTHÈSES le chapitre 2 emprunte-t-il sans les avoir énoncées ?

    ARC: A | QUID: QA-6 | REF

Lecture faite le 2 septembre, et la réponse est plus favorable que la question ne le supposait : le chapitre énonce ses hypothèses, mais par un RACCOURCI dont la lecture donne la forme dépliée. LES HYPOTHÈSES SONT UNE CHAÎNE, et c'est le théorème 5 de la source qui l'exhibe. Un : si une catégorie monoïdale symétrique porte une comonade MONOÏDALE, le tenseur induit une structure monoïdale symétrique sur la catégorie des coalgèbres. Deux : si elle est en outre monoïdale symétrique CLOSE, toute coalgèbre libre y est exponentiable, et toute puissance d'une coalgèbre libre est une coalgèbre libre. Trois, et c'est un « si de plus » distinct : si la catégorie des coalgèbres libres est close par le tenseur, alors elle est elle-même monoïdale symétrique close. CE QUE K7PL POSE ET CE QU'IL DÉRIVE. La monoïdale symétrique close est P1, donc posée. La comonade monoïdale n'est pas assumée : elle se DÉRIVE de l'adjonction monoïdale symétrique F ⊣ G que le chapitre pose, une composée de foncteurs monoïdaux étant monoïdale. Le chapitre est donc en règle sur les deux premiers maillons. LE TROISIÈME MAILLON EST LE POINT, et le chapitre le franchit par un autre chemin : il adopte la définition de CATÉGORIE LINÉAIRE, qui bundle la condition, et renvoie à sa preuve publiée. Ce n'est pas un emprunt tacite — le chapitre écrit qu'il ne l'assume pas et d'où cela suit — mais le lecteur ne voit pas que c'est ce maillon-là qui est en jeu. ET LE CAS GRADUÉ SE TRANSPOSE, ce que la source ne dit pas puisqu'elle n'a qu'un seul point d'exclamation. Sa clause « toute puissance d'une coalgèbre libre est une coalgèbre libre » devient, en gradué, la relation entre !\_r A ⊗ !\_s A et !<sub>r+s</sub> A — c'est-à-dire exactement le COMONOÏDE GRADUÉ que le chapitre pose. La généralisation ne demande donc rien de neuf ; elle remplace une clause par une structure déjà là. CE QUI RESTE, ET C'EST UNE PHRASE : dire que le troisième maillon est celui que la définition de catégorie linéaire acquitte. Porté au programme.

#### Suivi d'avancement

1.  \[DONE\] bentonLinearLcalculusCategorical1993

### \[DONE\] \[#A\] La cohérence au sens de Kelly et Mac Lane est l'un des huit ENGAGEMENTS du document. Le fonds permet-il de le tenir ?

    ARC: A | QUID: QA-7 | REF

La pièce est au fonds depuis le 1er septembre, et sa lecture DÉCOMPOSE l'engagement au lieu de le tenir ou de le manquer d'un bloc. CE QUE LA PIÈCE COUVRE. Sa catégorie close est une catégorie munie de ⊗ et de \[−,−\], d'un objet I, des isomorphismes naturels d'associativité et de symétrie, et de six diagrammes d'axiomes — structure que les auteurs disent eux-mêmes « non essentiellement différente » d'une monoïdale symétrique close. Son théorème garantit que tout diagramme construit à partir de ces isomorphismes commute. C'est exactement ce que le chapitre 2 déclare assumer, et c'est exactement ce que la pièce établit : le premier engagement est TENU pour sa part monoïdale. CE QU'ELLE NE COUVRE PAS, ET POURQUOI CE N'EST PAS UN MANQUE. Elle ne dit rien des diagrammes où entre l'exponentielle graduée. Mais la cohérence y est d'une autre nature : les lois de la comonade graduée — counité, coassociativité indexée par le produit du semi-anneau — sont POSÉES comme axiomes de la structure, non déduites. Un théorème de cohérence sert là où les isomorphismes ne sont pas donnés commutants et doivent être prouvés tels ; ici ils le sont par définition. D'OÙ LA RÉPONSE, ET ELLE DEMANDE UNE PRÉCISION AU MANUSCRIT. L'engagement se tient en DEUX pièces d'espèce différente — un THÉORÈME assumé pour la part monoïdale, des AXIOMES posés pour la part graduée — et le chapitre les présente aujourd'hui comme une seule chose assumée. Assumer un théorème publié et poser un axiome ne sont pas le même acte, et le lecteur a le droit de savoir lequel porte quoi. LE MANQUE DE CORPUS A1 SE REFERME AVEC CELA : il annonçait que la pièce « ferme la moitié de l'engagement ». C'est juste, et l'autre moitié n'avait pas besoin d'être fermée par une pièce.

#### Suivi d'avancement

1.  \[DONE\] kellyCoherenceClosedCategories1971

2.  \[DONE\] bentonLinearLcalculusCategorical1993

### \[DONE\] \[#A\] L'enrichissement sur les préordres est le second engagement, et « rien » ne le tient. Quelle source l'établirait pour la part qui excède l'ordre des fibres ?

    ARC: A | QUID: QA-8 | REF

La question était mal posée, et c'est la relecture du 2 septembre qui l'établit — non une recherche. Elle cherchait une source pour « l'enrichissement sur un treillis distributif borné ». Or le chapitre 2 déclare deux choses distinctes que la question confondait. L'ENRICHISSEMENT est sur les PRÉORDRES, et le chapitre l'écrit lui-même : l'exigence que la composition et le tenseur soient monotones est « très exactement la structure d'une catégorie enrichie sur les préordres ». Rien n'y excède l'ordre des fibres, donc rien n'est à sourcer. LE TREILLIS est une assertion SÉPARÉE, portant sur les catégories d'artefacts, et elle était SUR-ENGAGÉE. La rencontre paraissait une fois — dans la phrase qui la déclare — et n'était jamais employée ; la distributivité était nommée dans la même phrase et jamais invoquée ; le joint servait sept fois. LE MANUSCRIT DÉCLARE DÉSORMAIS UN DEMI-TREILLIS SUPÉRIEUR BORNÉ, ce qui est ce qui sert. Un manque de corpus se referme par une correction et non par une recherche, et c'est la seconde fois que cet arc en fait l'expérience. Ce que la source citée établit, et qui suffit : les lois passent au produit dès lors que chaque facteur les satisfait séparément.

#### Suivi d'avancement

1.  \[DONE\] dissoute par A.2.8, portée au manuscrit le 2 septembre

### \[DONE\] \[#A\] `F_{1→2}` et `F_{2→3}` sont-ils les SHIFTS adjoints de la logique adjointe ?

    ARC: A | QUID: QA-9 | REF

Oui, mais la présentation du chapitre 1 est à RETOURNER, et la lecture du 2 septembre dit pourquoi. CE QUE LA SOURCE EST. La logique adjointe est un SCHÉMA, paramétré par un préordre de modes et une application monotone qui assigne à chaque mode son ensemble de propriétés structurelles parmi l'affaiblissement et la contraction. Les shifts ne s'y DÉRIVENT pas : ils sont donnés par les règles du schéma, et l'élimination des coupures en tire immédiatement la conservativité de l'extension sur tous les modes. K7PL EST UNE INSTANCE DE CE SCHÉMA, ET LITTÉRALEMENT. Le préordre des modes est Lin ≤ Aff ≤ Unr, et l'application monotone est celle qui donne l'ensemble vide à Lin, l'affaiblissement seul à Aff, l'affaiblissement et la contraction à Unr. C'est exactement le paramétrage de la source. D'OÙ LA RÉPONSE, ET LE RETOURNEMENT. La question demandait si les inclusions FIDÈLES du chapitre 1 admettent les adjoints que la logique adjointe exige — objection juste, une inclusion fidèle n'étant pas la moitié d'une adjonction. Mais l'ordre de présentation est inverse : ce sont les SHIFTS qui sont premiers, donnés par le schéma, et les inclusions sont ce que les shifts induisent. Poser les inclusions puis chercher leurs adjoints, c'est se donner une charge que le schéma évite. LA CONDITION EST UNE, ET C'EST CELLE DE C-15. Le schéma repose sur une DÉCLARATION D'INDÉPENDANCE : une preuve au mode k ne peut dépendre que d'hypothèses aux modes m ≥ k. C'est la même condition que la fuite de contraction réclamait, et qui a été portée au théorème de sûreté spatiale le 2 septembre. Deux questions, une condition — ce qui est le meilleur signe qu'elle est la bonne. UNE PIÈCE À SOURCER, RELEVÉE EN CHEMIN. Les auteurs écrivent qu'ils autorisent TOUJOURS l'échange, « bien que rien ne s'oppose à un cadre encore plus général », et renvoient à une référence. C'est la seconde source indépendante à désigner cette généralisation et à s'arrêter au bord — après la note 3 de Grass. Elle intéresse directement ARB-1.

#### Suivi d'avancement

1.  \[DONE\] PCPR18AdjointLogic

### \[DONE\] \[#A\] La condition `σ(m) ⊇ σ(k)` de ADJ est-elle exactement la sédimentation de K7PL ?

    ARC: A | QUID: QA-10 | REF

Oui, exactement. La couche cartésienne admet affaiblissement et contraction, la couche affine l'affaiblissement seul, la couche linéaire aucun des deux, et la monotonie exigée par la logique adjointe est satisfaite. Ce que le chapitre 1 appelle une lecture s'écrit en six symboles et devient une condition vérifiable.

#### Suivi d'avancement

1.  \[DONE\] PCPR18AdjointLogic

### \[DONE\] \[#A\] `F_{2→3}` est-il la traduction de Choudhury-Krishnaswami, qui préserve `βη` ?

    ARC: A | QUID: QA-11 | REF

Non, et l'écart est instructif. La traduction de Choudhury et Krishnaswami va de l'impur vers le pur en CAPTURANT la pureté, quand le foncteur du chapitre 1 est une inclusion du plus contraint vers le moins contraint. Les deux mouvements ne sont pas le même, et le sens de la sédimentation s'en trouve inversé selon qu'on la lit dans un sens ou dans l'autre.

#### Suivi d'avancement

1.  \[DONE\] choudhuryRecoveringPurityComonads2020

### \[DONE\] \[#A\] Le mode STRICT `σ(m) = {C}` — contraction sans affaiblissement — a-t-il un usage que K7PL rejetterait à tort ?

    ARC: A | QUID: QA-12 | REF

Oui, et il a trois usages dans le document. Le mode contraction sans affaiblissement est le régime d'une obligation : une ressource duplicable qu'on ne peut pas jeter, donc qu'on doit employer au moins une fois. Il porte le nom de relevant, du nom de la logique de la pertinence, et Granule l'écrit comme l'intervalle de un à l'infini. Le porteur de K7PL l'exprime sans extension, comme un quatrième sous-ensemble distingué du semi-anneau. Trois usages existants l'attendent : la journalisation qu'exige le déterminisme distribué, une capacité qu'on doit rendre, un canal qu'on doit lire.

#### Suivi d'avancement

1.  \[DONE\] orchardQuantitativeProgramReasoning2019

2.  \[DONE\] PCPR18AdjointLogic

### \[DONE\] \[#A\] L'extension conservative que ADJ démontre en général couvre-t-elle le cas où les modes portent des ALGÈBRES DE GRADES ?

    ARC: A | QUID: QA-13 | REF

La question se ferme par l'arbitrage du 2 septembre, et pas comme elle l'attendait — elle demandait une extension, l'arbitrage la refuse. CE QU'ELLE DEMANDAIT. La logique adjointe ne gradue pas ; Grass unifie substructurel et gradué. L'articulation des deux n'est écrite nulle part, et la question posait qu'il en dépendait l'élimination des coupures pour les trois couches. CE QUE LA LECTURE DE VOLLMER RÉSOUT. L'articulation EST écrite, et sous une forme meilleure que celle qu'on cherchait : le système entier se lit comme la logique linéaire/non-linéaire COMPOSÉE AVEC UNE ACTION qui ajoute la gradation. La gradation ne se mêle pas à la structure adjointe, elle s'y compose — de sorte qu'il n'y a pas d'extension à démontrer conservative, mais deux étages à distinguer. ET LA QUESTION DE FOND EST TRANCHÉE PAR AILLEURS. Que les modes portent des algèbres différentes est ce que Grass permet et ce que K7PL REFUSE DE GÉNÉRALISER : trois modes, une chaîne de morphismes, et rien de plus. Le cas général que la question voulait couvrir n'a donc pas à l'être, puisque le document ne s'y place pas. CE QUI RESTE, ET C'EST PLUS PETIT QUE LA QUESTION : l'élimination des coupures pour les trois couches se démontre sur la chaîne, où les morphismes existent, et non sur un treillis quelconque.

#### Suivi d'avancement

1.  \[DONE\] vollmerMixedLinearGraded2024

2.  \[DONE\] tranchée par l'arbitrage du 2 septembre

### \[DONE\] \[#C\] La sédimentation gagnerait-elle à être présentée dans le sens de Choudhury — partir de l'impur et CAPTURER la pureté — plutôt que dans le sens actuel ?

    ARC: A | QUID: QA-14 | REF

NON. ARBITRAGE D'ANTHEA DU 3 SEPTEMBRE : la sédimentation va du CONTRAINT vers le LIBRE, la pureté devant être ABSOLUE et soutenue par les effets algébriques. ET LA QUESTION N'ÉTAIT PAS PÉDAGOGIQUE, ce que l'arbitrage révèle. Je l'avais classée en type C, portant sur l'exposition du chapitre 2 plutôt que sur sa substance. C'était mal la poser : le sens de la sédimentation décide de ce que la PURETÉ EST, et ce n'est pas une question d'exposition. LE MOTIF, TEL QU'IL SE DÉPLIE. Recouvrer la pureté à l'intérieur d'un langage impur la rend RELATIVE — elle devient ce qu'une comonade isole d'un ambiant impur, et l'ambiant reste la référence. La retenir absolue demande l'ordre inverse : la couche 2 est pure par CONSTRUCTION et non par soustraction. CE QUI REND CETTE EXIGENCE TENABLE EST LE TRAITEMENT ALGÉBRIQUE DES EFFETS, et c'est là que l'arbitrage se referme sur lui-même. Un effet algébrique est une opération AJOUTÉE à un calcul pur, munie de sa théorie équationnelle ; il n'est pas une propriété ambiante dont il faudrait se déprendre. La pureté n'a donc rien à recouvrer, puisqu'elle n'a rien perdu. DEUX CONSÉQUENCES PORTÉES AU CHAPITRE 1. Les trois foncteurs sont des INCLUSIONS et non des rétractions : on monte vers le libre en oubliant une contrainte, on ne descend pas vers le pur en capturant. Et la charge de la preuve change de camp — dans la lecture inverse il faudrait montrer que la modalité capture TOUTE la pureté ; ici il faut montrer qu'ajouter une opération ne détruit rien, ce que la théorie des effets algébriques établit et que ce document n'a donc pas à refaire. LA SOURCE EST DONC CITÉE POUR CE QU'ELLE ÉCARTE, emploi légitime qu'il fallait rendre explicite : elle établit que l'autre voie EXISTE et fonctionne, ce qui transforme le choix de ce document en arbitrage plutôt qu'en ignorance.

#### Suivi d'avancement

1.  \[DONE\] choudhuryRecoveringPurityComonads2020

### \[DONE\] \[#A\] Les trois échelles du chapitre 4 sont-elles le MÊME foncteur ?

    ARC: A | QUID: QA-15 | REF

NON, et c'est une meilleure réponse que oui — la lecture du 2 septembre la donne avec ce qui la remplace. POURQUOI NON. Un automate est un foncteur d'une catégorie d'entrée vers une catégorie de sortie, et les trois échelles de K7PL diffèrent par les DEUX : l'échelle locale produit une valeur, celle de l'acteur une observation et un état suivant, celle du système une transition de processus. Elles ne sont donc pas trois instances d'un même foncteur obtenues en changeant la seule sortie. CE QUI EST VRAI À LA PLACE, ET QUI PORTE PLUS LOIN. Elles sont trois foncteurs RELIÉS PAR DES ADJONCTIONS RELEVÉES. La source établit le relèvement d'une adjonction entre catégories de sortie en une adjonction entre catégories d'automates ; les couches de K7PL étant reliées par des shifts adjoints (QA-9), leurs échelles le sont par relèvement. CE QUE LE CHAPITRE DOIT DONC ÉCRIRE. Non pas « trois échelles d'une même chose », qui est faux, ni « trois choses distinctes », qui perdrait l'unité — mais trois foncteurs reliés par des adjonctions que le cadre RELÈVE au lieu qu'on les construise. La démonstration commune que la question espérait existe, sous cette forme.

#### Suivi d'avancement

1.  \[DONE\] colcombetAutomataMinimizationFunctorial2020

### \[DONE\] \[#A\] La minimisation fonctorielle de Colcombet-Petrişan donne-t-elle le théorème qui manque à QA-15 ?

    ARC: A | QUID: QA-16 | REF

Oui, et elle donne plus fort que ce que la question demandait. Lecture faite le 2 septembre. LE PATRON D'ABORD. Un automate y est un FONCTEUR d'une catégorie d'entrée — qui spécifie le type des langages et des machines — vers une catégorie de sortie, qui spécifie le type des valeurs produites. Ce que la question voulait vérifier est que les trois échelles de K7PL diffèrent par leur seule catégorie de sortie. ET LE TROISIÈME RÉSULTAT DE LA SOURCE REND CETTE VÉRIFICATION SUPERFLUE. Elle établit comment RELEVER UNE ADJONCTION entre catégories de valeurs de sortie en une adjonction entre catégories d'automates. Il n'est donc pas nécessaire que les trois échelles soient le même foncteur : il suffit que leurs catégories de sortie soient reliées par des adjonctions, et le relèvement est un théorème du cadre plutôt qu'une construction à faire. CE QUE CELA DONNE À K7PL. Les trois couches sont reliées par des shifts adjoints — c'est ce que QA-9 vient d'établir. Leurs catégories de sortie le sont donc aussi, et le relèvement fournit les adjonctions entre les trois échelles sans qu'on ait à les construire. La sédimentation reçoit ainsi, du côté des automates, la même structure qu'elle a du côté des modes. LA SOURCE DONNE EN OUTRE des conditions SUFFISANTES sur la catégorie de sortie pour que la minimisation soit garantie, et unifie déterminisation, minimisation et algèbres syntaxiques. C'est le cadre où l'annotation de classe du chapitre 4 se laisserait démontrer plutôt que déclarer.

#### Suivi d'avancement

1.  \[DONE\] colcombetAutomataMinimizationFunctorial2020

### \[DONE\] \[#A\] Le RECOLLEMENT — une catégorie obtenue en recollant plusieurs régimes — est-il la forme des trois couches ?

    ARC: A | QUID: QA-17 | REF

La construction NE DEMANDE PAS la structure linéaire, et ce qu'elle demande à la place est nommé, précis et vérifiable. Lecture faite le 2 septembre, et elle répond à la question que la première lecture avait laissée ouverte. LES ESPACES VECTORIELS SONT UN EXEMPLE, NON UNE EXIGENCE. La théorie est énoncée pour un couple quelconque d'une catégorie C et d'une sous-catégorie S, les auteurs traitant côte à côte les cas (Set, Set_fin), (Vec, Vec_fin) et celui, nouveau, des espaces recollés. Les hypothèses du théorème de minimisation sont : un SYSTÈME DE FACTORISATION À TRAVERS S SUR C, et l'existence d'un automate initial et d'un automate final pour le langage. ET LE MOTIF DE LA GÉNÉRALISATION EST EXACTEMENT CELUI QUI INTÉRESSE K7PL. Les auteurs écrivent que leur catégorie recollée est close par QUOTIENTS mais, en général, PAS PAR SOUS-OBJETS — et que c'est « la raison importante de cette extension de la notion standard de factorisation ». La notion généralisée existe précisément pour les sous-catégories qui ne sont pas sages, ce qui est la situation d'un fragment substructurel. CE QUI RESTE À K7PL EST DONC UNE OBLIGATION CONCRÈTE et non une question de transport : établir un système de factorisation à travers la sous-catégorie des fragments. Ce n'est ni acquis ni hors d'atteinte, et c'est vérifiable — là où « le recollement transporte-t-il » ne l'était pas. CE QUE CELA ACHÈTERAIT, ET LES DEUX PIÈCES S'EMBOÎTENT. Le lemme 7 établit que les systèmes de factorisation RELÈVENT aux catégories d'automates ; l'autre pièce donne les conditions suffisantes sur la catégorie de sortie pour que la minimisation soit garantie, et le relèvement des adjonctions. Établir la factorisation sur les fragments donnerait donc la minimisation des automates par-dessus le marché. UNE RÉSERVE À VÉRIFIER AVANT D'ÉCRIRE : que les fragments de K7PL soient clos par quotients et non par sous-objets est PLAUSIBLE — l'affaiblissement se lit comme un quotient — mais ce n'est pas établi ici. C'est la première chose à regarder si la voie est prise.

#### Suivi d'avancement

1.  \[DONE\] colcombetAutomataCategoryGlued2017b

2.  \[DONE\] colcombetAutomataMinimizationFunctorial2020

### \[DONE\] \[#A\] Les conteneurs indexés préservent les plus petits et plus grands points fixes. Cette préservation transporte-t-elle aux versions GRADUÉES ?

    ARC: A | QUID: QA-18 | REF

Les foncteurs de conteneur préservent les plus petits et les plus grands points fixes, et ce résultat est formalisé sans supposer l'unicité des preuves d'identité, dans la catégorie sauvage des types. La réserve que j'avais posée sur l'extensionnalité postulée de la bisimulation est donc levée. Mais la transposition à la gradation n'est pas établie : les résultats valent sur des types, non sur des types gradués, et c'est exactement ce que K7PL demande. Et la technique qui rend la preuve possible est le type de chemin de Cubical Agda, que LEAN 4 n'a pas. La question est répondue dans son cadre et ouverte dans le nôtre, et elle enchaîne trois arcs : le verdict de T-68 sur la coalgèbre terminale dépend de la transposition graduée, qui dépend de la faisabilité en LEAN 4.

#### Suivi d'avancement

1.  \[DONE\] damatoFormalisingInductiveCoinductive2024

2.  \[DONE\] altenkirchIndexedContainers2015

### \[DONE\] \[#A\] Un hylomorphisme traverse une frontière de couche. La DÉFORESTATION est-elle alors une transformation qui fait disparaître un franchissement, et se démontre-t-elle comme telle ?

    ARC: A | QUID: QA-19 | REF

Oui, et le franchissement n'est pas accompagné d'un objet : il EST cet objet. Un hylomorphisme naît d'un anamorphisme suivi d'un catamorphisme, donc d'une production puis d'une consommation, et la structure intermédiaire entre les deux est ce que la déforestation supprime. Chez K7PL l'anamorphisme produit en couche 2 sur la coalgèbre terminale et le catamorphisme consomme en couche 3 sur l'algèbre initiale. La déforestation fait donc disparaître le franchissement par construction, et cela se démontre comme la suppression de l'objet intermédiaire.

#### Suivi d'avancement

1.  \[DONE\] yangFantasticMorphismsWhere2022

### \[DONE\] \[#A\] Combien de schémas de récursion sont PRIMITIFS, et lesquels se dérivent ?

    ARC: A | QUID: QA-20 | REF

Deux, et les schémas nommés se composent à partir d'elles. Downen, Johnson-Freyd et Ariola isolent la récursion primitive et la récursion noethérienne, chacune avec son principe d'induction, et montrent que les schémas complexes sont des compositions de ces deux structures pour une large classe de types de données et de co-données. Hinze et Wu arrivent au même endroit par un autre chemin : le pli adjoint, paramétré par une adjonction et une loi distributive, subsume le zoo. Deux cadres unifiants convergents, et ni l'un ni l'autre ne compte les schémas nommés parmi les primitives.

#### Suivi d'avancement

1.  \[DONE\] downenStructuresStructuralRecursion

2.  \[DONE\] hinzeUnifyingStructuredRecursion2016

### \[DONE\] \[#A\] `tab:dimensions` écrit « plis, balayages, réductions » pour la couche 3. Un BALAYAGE est-il un catamorphisme, ou relève-t-il de l'accumulation générique ?

    ARC: A | QUID: QA-21 | REF

Non. Un balayage produit la suite de ses résultats intermédiaires, ce qu'un catamorphisme pur ne fait pas : c'est un pli accumulateur, que Hinze range parmi les schémas subsumés par le pli adjoint. La table des dimensions met donc une forme générale, une de ses instances et un synonyme sur trois colonnes de même rang.

#### Suivi d'avancement

1.  \[DONE\] yangFantasticMorphismsWhere2022

2.  \[DONE\] hinzeUnifyingStructuredRecursion2016

### \[DONE\] \[#A\] La corécursion primitive de Downen et Ariola donne-t-elle à la couche 2 sa primitive de production ?

    ARC: A | QUID: QA-22 | REF

Oui. L'étude est guidée par la dualité, et chaque structure de récursion a une forme duale donnant des paires parfaitement symétriques de types de données et de co-données. La duale de la récursion primitive est la corécursion primitive, et c'est la primitive de production que la couche 2 emploie sans la nommer.

#### Suivi d'avancement

1.  \[DONE\] downenStructuresStructuralRecursion

### \[DONE\] \[#A\] La relation de précision `⊑` construite comme enrichissement sur un treillis distributif borné a-t-elle les propriétés que le chapitre 3 lui prête ?

    ARC: A | QUID: QA-23 | REF

Elle était bloquée par QA-8, qui est dissoute ; elle se ferme avec elle, et deux résultats du 2 septembre lui donnent en outre ce que la question demandait vraiment. LA STRUCTURE EST UN DEMI-TREILLIS SUPÉRIEUR BORNÉ, non un treillis distributif borné. Les propriétés que le document prête à `⊑` sont donc exactement celles qu'il emploie — l'ordre, le joint, le minimum — et pas davantage. ET LES JOINTURES SONT VÉRIFIÉES, non supposées. Le produit mixte du sous-typage est `(≥) × (⪰) × (≤) × (≤)`, et un produit d'ordres a ses jointures si chaque facteur a les siennes : minimum sur l'usage, chaîne à deux éléments sur la monotonie, joint du treillis sur le niveau, maximum sur le budget. C'est la condition du théorème de cohérence de la subsomption, désormais au manuscrit. DE QUEL ORDRE IL S'AGIT EST DIT AUSSI, et ce n'était pas verbal. Deux théories de l'information portent le même mot : celle de Shannon ordonne par ce qu'on SAIT, celle de Scott par ce qui est DÉFINI. La précision compare des raffinements, donc ce qu'un type garantit : elle est du côté de Shannon, et les deux ordres n'ont pas les mêmes propriétés de complétude.

#### Suivi d'avancement

1.  \[DONE\] dissoute avec QA-8 ; jointures vérifiées par A.3.7, ordre nommé par C-10

### \[DONE\] \[#A\] Le grade ne vit-il que dans l'ACCEPTATION ?

    ARC: A | QUID: QA-24 | REF

Oui, le grade peut ne vivre que dans l'acceptation, et la famille des automates valués le montre : la structure de grade n'a pas à traverser tout l'automate, elle peut n'apparaître qu'à la condition d'acceptation. La décision bibliographique du 9 août consigne ce résultat et le rattache aux chapitres 3 et 4. Ce que la question demandait implicitement — le grade doit-il être partout — reçoit donc un contre-exemple, et c'est une famille emboîtée.

#### Suivi d'avancement

1.  \[DONE\] belohlavekDeterminismFuzzyAutomata2002

### \[DONE\] \[#A\] Les conaturels forment un semi-anneau commutatif exponentiel. Cette structure suffit-elle à \`𝒢_budget\` ?

    ARC: A | QUID: QA-25 | REF

NON, mais la justification doit être corrigée au regard de la définition désormais normative. Le budget emploie une consommation \`β ⊖ k\` distincte des opérations du semi-anneau d'usage. La spécification définit cette opération comme une soustraction tronquée prolongée : \`ω ⊖ k = ω\`, \`0\` lorsque \`β < k\`, et \`β-k\` dans le cas fini restant. Elle ne doit donc pas être qualifiée de résidu de l'addition : en particulier, la convention \`ω ⊖ ω = ω\` diverge du résidu usuel sur \`ℕ∞\`, qui donnerait \`0\` pour le plus petit complément.

La structure requise reste donc plus riche qu'un simple semi-anneau : elle comprend l'ordre du budget, l'opération de consommation et la condition d'admissibilité portée par \`ψ\`. La compatibilité arithmétique avec une multiplicité d'exécution entière est une propriété séparée ; elle ne transforme pas \`⊖\` en multiplication de grade.

La seconde partie reste également distincte : le budget est utilisé comme borne de coût dans \`ψ\`, alors que l'usage détermine la disponibilité structurelle des dépendances. La séance 36 (\`docs/history/2026-10-07-pr-02-36-budget-factorisation-test.md\`) établit qu'aucune règle du fragment \`Box\`, \`App\`, \`SubBox\`, substitution et \`Sc\` ne fournit de contre-exemple à une \`Scale_Usage\` qui laisse le budget invariant.

#### Suivi d'avancement

1.  \[DONE\] le manuscrit lui-même et vérification de la définition effective de \`⊖\`

### \[DONE\] \[#A\] Le semi-anneau de K7PL a-t-il besoin d'un plus grand élément `∞` ?

    ARC: A | QUID: QA-26 | REF

Non, et le chapitre 2 répond déjà. L'élément infini n'est postulé par Brunel que pour les points fixes ; K7PL interdisant la récursion générale, l'économie est possible. La question était mal posée : elle demandait au fonds ce que le document tranchait.

#### Suivi d'avancement

1.  \[DONE\] brunelCoreQuantitativeCoeffect2014

### \[DONE\] \[#A\] Les grades FRACTIONNAIRES `1/N` sortent des semi-anneaux de Brunel et de Vollmer. Quelle structure les accueille ?

    ARC: A | QUID: QA-27 | REF

Le chapitre 2 donne le semi-anneau avec les rationnels positifs et l'infini, ce qui accueille les grades fractionnaires sans structure supplémentaire. Question mal posée, close par relecture.

#### Suivi d'avancement

1.  \[DONE\] le manuscrit lui-même

### [IN REVIEW] [#A] Toute liaison a-t-elle besoin des QUATRE composantes `⟨u, m, ℓ, β⟩` ?

    ARC: A | QUID: QA-28 | REF

Reprise le 7 octobre. La distinction entre deux questions est conservée : ÉLIDER une composante à l'écriture est une convention de présentation ; RESTREINDRE la structure disponible est une question de mode. La formulation antérieure identifiait à tort les intervalles `Lin`, `Aff` et `Unr` à des sous-algèbres ou à des modes. C'est désormais corrigé : `𝕌 = ℚ≥0 ∪ {ω}` porte la composante d'usage, `𝒢 = 𝕌 × 𝕄 × ℒ × 𝔅` porte le grade complet, et les intervalles d'usage sont des domaines syntaxiques. Les modes structurels sont des structures supplémentaires de la forme `(R_m, Cont(m), Weak(m))`.

Une composante nouvelle doit donc satisfaire non seulement les conditions d'ordre et de composition du produit, mais aussi la condition d'action scalaire requise par les règles. Cette dernière n'est pas encore résolue : l'usage contient des rationnels positifs alors que le budget est porté par `ℕ∞`, de sorte qu'une action globale `𝕌 × 𝔅 → 𝔅` n'est pas disponible sans convention supplémentaire. La décision d'élision du budget reste inchangée ; la question de l'action graduée doit être instruite séparément avant de déclarer le noyau complètement fermé.

#### Suivi d'avancement

1.  \[DONE\] vollmerMixedLinearGraded2024

2.  \[DONE\] arbitrage d'Anthea, 2 septembre
### \[DONE\] \[#A\] Le support fini coûte-t-il l'axiome du choix sur les constructions de K7PL qui CHOISISSENT un nom, un témoin ou une branche ?

    ARC: A | QUID: QA-29 | REF

NON, et pour une raison qui est le résultat central du domaine plutôt qu'une propriété de K7PL. LE QUANTIFICATEUR DE FRAÎCHEUR EST CE QUI DISPENSE DU CHOIX. Dans les ensembles nominaux, tout élément a un support fini et l'ensemble des noms est infini, de sorte qu'un nom frais existe toujours ; et « il existe un nom frais tel que P » y équivaut à « pour tout nom frais, P ». Choisir un nom frais n'est donc pas un choix : les deux quantificateurs coïncident, et n'importe lequel convient. LES TROIS SITES DE LA QUESTION, UN PAR UN. Choisir un NOM relève exactement de ce quantificateur. Choisir un TÉMOIN — l'élimination existentielle, dont la règle Open porte la condition α ∉ fv(C) — est une condition de fraîcheur et relève du même. Choisir une BRANCHE n'est pas un choix du tout : la branche est déterminée par l'étiquette d'injection, la règle Case ne choisissant rien. UNE RÉSERVE, ET LE DOCUMENT L'A DÉJÀ LEVÉE SANS LE SAVOIR. Ce qui coûterait un choix serait une construction devant sélectionner dans un ensemble infini NON SUPPORTÉ. K7PL en a un candidat : la recherche dirigée par le type qui résout bind-to. Or le chapitre 5 pose qu'une recherche AMBIGUË EST REFUSÉE EN PHASE 0 plutôt que résolue arbitrairement — c'est-à-dire que le seul endroit où un choix aurait été nécessaire est celui où le document refuse au lieu de choisir. LA DISCIPLINE QUI ÉVITE LE CHOIX EST DONC DÉJÀ ÉCRITE, et pour un autre motif que celui-ci. C'est le genre de coïncidence qui vaut d'être relevée : une exigence de cohérence rend au passage une propriété de fondation.

#### Suivi d'avancement

1.  \[DONE\] pittsNominalSetsNames2013

### \[DONE\] \[#A\] Les catégories différentielles et leurs comonades ont-elles un rapport avec la gradation, ou est-ce une homonymie ?

    ARC: A | QUID: QA-30 | REF

Ce n'est pas une homonymie, c'est une implication. Le rapport entre les catégories différentielles et l'exponentielle n'est pas une ressemblance de vocabulaire : toute catégorie de Lafont à biproduits finis EST différentielle. La question se ramène donc à la précédente, et les deux se répondent ensemble.

#### Suivi d'avancement

1.  \[DONE\] lemayCoderelictionsFreeExponential2021

### [IN REVIEW] [#A] Le grade complet `⟨u,m,ℓ,β⟩` doit-il être une algèbre globale, une annotation hétérogène, ou un indice comonadique enrichi ?

    ARC: A | QUID: QA-31 | REF

Reprise le 7 octobre. Quatre architectures sont désormais distinguées. (A) Le produit `𝒢` reçoit une structure algébrique complète et porte directement `!_r`, `r·Δ` et `φ_r`. (B) La comonade reste indexée par `𝕌`, les composantes `m`, `ℓ` et `β` étant des annotations orthogonales du jugement ; la signification exacte de `!_r` doit alors être reconstruite. (C) Le grade est traité comme une structure hétérogène ou multimodale, chaque dimension conservant son algèbre et les transports étant gouvernés par des morphismes explicites. L'architecture C est directement proche des constructions de grades hétérogènes de Bianchini et al. (ECOOP 2023, DOI 10.4230/LIPIcs.ECOOP.2023.3) et de GRASS (Hanukaev & Eades, 2026, DOI 10.48550/ARXIV.2605.17112).

Le test des signatures ajoute un résultat plus précis. L'obstacle ne porte pas sur le produit de grade algebras en général : Bianchini et al. montrent qu'une construction de grades hétérogènes peut être obtenue à partir de plusieurs algèbres. Le problème de K7PL est l'adéquation entre les opérations réellement demandées. L'agrégation des contextes, une éventuelle multiplication de `𝒢`, l'action `Scale` et la consommation budgétaire `⊖` doivent désormais être traitées comme quatre familles distinctes.

Le niveau de confidentialité est le discriminant principal identifié par la séance 28. Les règles utilisent `⊔` pour des agrégations conservatrices ; une construction standard d'algèbre de grades à partir d'un treillis distributif associe plutôt `⊔` à l'addition et `⊓` à la multiplication sous l'ordre usuel. Une dualisation est possible en principe, mais elle modifie alors la relation entre l'ordre algébrique et l'ordre de confidentialité du sous-typage. Aucune de ces voies n'est encore démontrée compatible avec K7PL.

Le critère concernant `Usage` et `Exec` reste inchangé et non négociable : `u = 1/N` peut représenter une capacité de lecture sans représenter une fraction d'exécution. Toute définition de `φ_r` par `ε^u` est donc limitée à un domaine où une multiplicité entière est explicitement associée à `u`.

La décision de `TRANS-02` reste ouverte. A, A2 et C demeurent en concurrence. Le prochain test doit fixer, pour le fragment minimal, les signatures et lois de `AggG`, `MulG`, `Scale`, `⊖`, `!`, `≼` et `c`, puis vérifier les interactions nécessaires à `Box`, `App` et substitution.
### \[IN REVIEW\] \[#A\] Quelle sorte de scalaire porte réellement l'action `Scale` de `Box` et `App` ?

    ARC: A | QUID: QA-32 | REF

Les séances 35 à 52 ont réduit la question à une architecture factorisée. Le noyau de `!` est porté
par le semi-anneau d'usage `𝓡`, via `π_U : 𝒢 → 𝓡`, tandis que `𝒢` conserve les annotations complètes.

`Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩` est l'action contextuelle de référence pour `Box`, `App`,
substitution et le contexte de `Sc`. Les répétitions effectives restent portées par `φ_n` sur les
effets ; le langage actuel ne requiert pas un nouvel objet `Scale_Exec` agissant sur le grade complet.

Les lois d'identité, de composition, de distribution sur l'agrégation, de commutation avec `ψ` et de
monotonie sont établies sur le candidat. Les deux dettes restantes concernent la compatibilité de
ces lois avec les conversions `Sub`/`SubBox` et l'interaction avec `When`.

Le problème n'est donc plus de choisir un scalaire global unique, mais de vérifier la fonctorialité
des conversions et la cohérence sémantique des transformations temporelles.

#### Suivi d'avancement

1.  \[DONE\] architecture factorisée et lois de `Scale_Usage`
2.  \[IN REVIEW\] conversions de grade complet et interaction avec `When`
### \[DONE\] \[#A\] La grammaire CBPV de Levy suffit-elle, ou faut-il `dCBPV+` ?

    ARC: B | QUID: QB-1 | REF

La forme simple suffit, et la frontière est localisable au caractère près. Le système sans extension de Kleisli pour les fonctions dépendantes ne suffit pas à encoder l'appel par valeur dépendant ni l'élimination FORTE des connecteurs positifs ; il suffit pour l'élimination faible. Or la règle de filtrage de l'annexe G porte le même type de conclusion dans toutes ses branches, et ce type ne mentionne pas l'indice. K7PL n'a donc que l'élimination faible et se tient du côté le moins cher. La variante enrichie deviendra nécessaire le jour, et seulement le jour, où un motif dépendra du sujet examiné.

#### Suivi d'avancement

1.  \[DONE\] vakarFrameworkDependentTypes2015

2.  \[DONE\] Thesisqmwphd

3.  \[DONE\] pedrotFireTriangleHow2020

### \[DONE\] \[#A\] Si c'est `dCBPV+`, le prix — perte d'unicité du typage, donc besoin de sous-typage — est-il déjà payé par P2 ?

    ARC: B | QUID: QB-2 | REF

Le prix n'est pas payé, mais il n'est pas non plus dû, puisque la question précédente place K7PL du côté qui ne le doit pas. S'il le devenait, la source en donne le détail : perte de l'unicité du typage, le type d'un calcul devenant plus spécifié à mesure que des effets s'exécutent ; règles de coercion à ajouter pour sauver la préservation ; et un TYPAGE MINIMAL à la place de l'unicité. Le sous-typage de K7PL couvre la première part ; le typage minimal n'existe pas et serait le théorème à écrire. Obligation datée, non exigible aujourd'hui.

#### Suivi d'avancement

1.  \[DONE\] vakarFrameworkDependentTypes2015

### \[DONE\] \[#A\] Le noyau porte-t-il `∃` ?

    ARC: B | QUID: QB-3 | REF

Oui. Le chapitre 3 pose un langage noyau muni des deux termes de l'existentiel, et Vákář en donne le cadre pour l'appel par poussée de valeur. Les deux termes sont des termes de connecteur, non des primitives distinctes. Close le 28 août avec les trois autres points de stabilité.

#### Suivi d'avancement

1.  \[DONE\] vakarFrameworkDependentTypes2015

### \[DONE\] \[#A\] `tick` est-il une instance du schéma `perform`, ou un constructeur à part ?

    ARC: B | QUID: QB-4 | REF

Une instance du schéma. Torczon en fait un constructeur séparé mais précise ne décrire qu'un seul effet par simplicité ; rien n'oblige K7PL à le séparer, et le chapitre 1 le nomme d'ailleurs une opération. La liste perd une entrée et gagne en uniformité.

#### Suivi d'avancement

1.  \[DONE\] torczonEffectsCoeffectsCallbypushvalue2024

### \[DONE\] \[#A\] Le délimiteur de couche EST-il le shift de ADJ ?

    ARC: B | QUID: QB-5 | REF

Non, et la réponse a été corrigée deux fois. Le délimiteur n'est pas un terme de franchissement : le mode de la logique adjointe est, chez K7PL, la composante d'usage du grade, et en changer est du SOUS-TYPAGE, gouverné par des règles qui existent déjà. Les deux shifts de mode ont été retirés de la liste des primitives le 28 août, arbitrage rendu.

#### Suivi d'avancement

1.  \[DONE\] PCPR18AdjointLogic

2.  \[DONE\] orchardQuantitativeProgramReasoning2019

### \[DONE\] \[#A\] Le sous-typage modal de P2 et l'affaiblissement sont-ils la MÊME règle ?

    ARC: B | QUID: QB-6 | REF

Non, ce sont deux règles, et la source dit leur rapport exact. La subsomption pose que les grades ne sont que des bornes supérieures de l'usage réel ; l'affaiblissement introduit une variable inutilisée au grade nul. Leur COMPOSITION rend l'effet que le document attribue à une seule règle : une variable inutilisée peut être introduite à n'importe quel grade supérieur ou égal à zéro, en affaiblissant puis en subsumant. Et zéro n'a pas à être le plus petit élément : l'affaiblissement est gouverné par un prédicat de mode et par le choix du préordre.

#### Suivi d'avancement

1.  \[DONE\] hanukaevUnificationGradedSubstructural2026

2.  \[DONE\] melliesFunctorsAreType2015

### \[DONE\] \[#A\] Les règles INTERSTITIELLES de K7PL — sous-typage modal, sous-gradation — commutent-elles avec les introductions ?

    ARC: B | QUID: QB-7 | REF

Oui, et la vérification est bien plus courte que trente-trois commutations. Le sous-typage est le fragment VERTICAL du typage — les deux jugements ont exactement le même sens chez Melliès et Zeilberger. La commutation des règles interstitielles avec les introductions est donc la condition qui définit un système de raffinement MONOÏDAL : deux carrés commutatifs, l'un pour le tenseur, l'autre pour l'unité. Deux carrés à vérifier, et le reste suit par fonctorialité.

#### Suivi d'avancement

1.  \[DONE\] melliesFunctorsAreType2015

### \[DONE\] \[#A\] Quelle est la forme exacte de la règle d'application quand le contexte est gradué et que l'effet traverse ?

    ARC: B | QUID: QB-8 | REF

La part coeffet de la forme est unanime dans trois sources : le contexte de l'argument est MULTIPLIÉ par le grade que la flèche exige, puis combiné à celui du terme fonction. C'est ce que l'annexe G écrit, et elle n'a rien à corriger là-dessus. La différence porte sur l'opérateur de combinaison : les trois sources emploient l'addition ponctuelle du semi-anneau, l'annexe G emploie la composition que la loi distributive graduée gouverne. Et c'est justifié, puisque aucune des trois n'a d'effet qui traverse tandis que K7PL en a un. Il en résulte une obligation que le document ne pose pas : établir que sa composition COÏNCIDE avec l'addition ponctuelle lorsque l'effet est trivial, faute de quoi rien ne garantit qu'elle généralise la forme reçue au lieu de s'en écarter.

#### Suivi d'avancement

1.  \[DONE\] hanukaevUnificationGradedSubstructural2026

2.  \[DONE\] hughesProgramSynthesisGraded2024

3.  \[DONE\] choudhuryGradedDependentType2021

4.  \[DONE\] kuraCategoryTheoreticFrameworkDependent2026

### \[DONE\] \[#A\] La partialité de `⊠` — un budget insuffisant rend `ψ` indéfinie — se présente-t-elle comme une PRÉMISSE de règle ou comme une condition de bord ?

    ARC: B | QUID: QB-9 | REF

Ni l'un ni l'autre, et c'est la troisième forme que le document n'avait pas envisagée. Grass impose que dans tout jugement dérivable, chaque mode du contexte soit supérieur ou égal au mode de conclusion — la déclaration d'indépendance de Pruiksma et Pfenning, déjà présente dans LNL. La bonne définition des multiplications scalaires en est une CONSÉQUENCE, donc une présupposition structurelle du jugement, ni prémisse ni condition de bord. C'est la moins coûteuse des trois.

#### Suivi d'avancement

1.  \[DONE\] hanukaevUnificationGradedSubstructural2026

2.  \[DONE\] PCPR18AdjointLogic

### \[DONE\] \[#A\] Le CBPV impose que les effets latents ne soient PAS dans les types de fonction. K7PL le respecte-t-il partout, ou une annexe l'enfreint-elle ?

    ARC: B | QUID: QB-10 | REF

Non, il ne le respecte pas : sa flèche porte un effet latent, que la règle d'application compose avec l'effet d'évaluation du terme fonction. Et c'est correct. La source, qui doit traiter l'évaluation paresseuse, a besoin de DEUX annotations — celle de l'argument et celle de la fonction. K7PL n'en porte qu'une, et l'économie est exactement celle que la séparation valeur/calcul procure, l'argument étant une valeur donc sans effet à consigner. La règle est juste ; ce qui manque au document est la phrase qui dit pourquoi.

#### Suivi d'avancement

1.  \[DONE\] mcdermottExtendedCallbypushvalueReasoning2019

### \[DONE\] \[#A\] Les cinq mécanismes d'effacement sont-ils cinq usages d'un seul, comme c1 l'affirme ?

    ARC: B | QUID: QB-11 | REF

Oui, et la source donne la forme que le chapitre 1 n'énonce pas. L'effacement EST une distinction de phase, encodée comme une proposition qui peut figurer dans un contexte. Un mécanisme, une forme précise, un encodage. L'affirmation du chapitre est donc juste et lui manquait son énoncé.

#### Suivi d'avancement

1.  \[DONE\] THEOCHARIS

### \[DONE\] \[#A\] La non-interférence entre phases se démontre-t-elle par la structure MODALE, comme c1 l'indique sans le faire ?

    ARC: B | QUID: QB-12 | REF

Elle se démontre comme une CONSERVATIVITÉ, et c'est la forme précise de ce que le chapitre indique sans le faire : ce qu'on peut prouver en présence de l'effacement, on pouvait le prouver sans lui, et réciproquement dans la phase effacée. La source l'établit dans les deux phases, par la théorie des modèles des théories algébriques du second ordre.

#### Suivi d'avancement

1.  \[DONE\] THEOCHARIS

### \[DONE\] \[#A\] Les théories de type modales graduées formalisées — Abel, Eriksson — donnent-elles un modèle de référence pour l'effacement de K7PL ?

    ARC: B | QUID: QB-13 | REF

Oui, et c'est le modèle de référence le plus proche que le fonds porte. Théorie dépendante, graduée, avec hiérarchie d'univers, avec effacement, avec machine abstraite, et mécanisée en Agda. Deux résultats de correction y sont établis, dont l'un révèle un théorème qui manque à K7PL.

#### Suivi d'avancement

1.  \[DONE\] erikssonGradedModalType2025

2.  \[DONE\] abelGradedModalDependent2023

### \[DONE\] \[#A\] L'irrélevance définitionnelle et l'effacement sont-ils le même mécanisme ?

    ARC: B | QUID: QB-14 | REF

Pour le grade nul, oui, et ce n'est pas une définition mais un lemme : deux configurations initiales qui ne diffèrent que par l'affectation de variables graduées zéro produisent des résultats identiques, démontré dans une sémantique à tas instrumentée. La source généralise au-delà du zéro : est inutilisable tout grade s pour lequel la contrainte q + 1 \<= s est insatisfiable. La classe des ressources effaçables est donc définie par une contrainte du semi-anneau, non par une valeur particulière.

#### Suivi d'avancement

1.  \[DONE\] choudhuryGradedDependentType2021

2.  \[DONE\] felicissimoDefinitionalProofIrrelevance2025

### \[DONE\] \[#A\] « Aucun éliminateur ne discrimine sur un argument de phase de compilation » : cette règle générale a-t-elle une contrepartie dans la littérature, et sous quel nom ?

    ARC: B | QUID: QB-15 | REF

Elle en a une, et la comparaison révèle que la règle du document est la CONSÉQUENCE et non la cause. Le document interdit qu'un éliminateur discrimine sur un argument de phase de compilation, et il l'énonce comme une règle à faire respecter, vérifiée cas par cas — pas de projection sur un témoin effacé, pas de filtrage sur un paramètre de typestate, pas de conditionnelle sur un paramètre fantôme. La distinction de phase synthétique fait mieux : la phase étant une proposition du contexte, la discrimination n'est pas interdite, elle est INEXPRIMABLE, et la conservativité dans les deux phases s'en déduit. Le document a la bonne règle et le mauvais statut pour elle.

#### Suivi d'avancement

1.  \[DONE\] THEOCHARIS

### \[DONE\] \[#A\] Les univers et l'effacement interagissent-ils d'une manière que K7PL rencontrerait ?

    ARC: B | QUID: QB-16 | REF: tejiscakDependentlyTypedCalculus2020

Le fonds porte quatre conceptions de l'effacement et non trois. Tejiščák en est la quatrième : l'annotation vit au JUGEMENT, et la règle d'application la compose par une rencontre plutôt que par la multiplication d'un semi-anneau, l'argument n'étant retenu que si le terme entier l'est et si l'application l'est. Elle traite en outre le filtrage et les motifs forcés, que les trois autres ne traitent pas. L'interaction avec les univers reste à comparer, et c'est ce qui laisse la question ouverte. OUI, MAIS SEULEMENT POUR LES APPROCHES QUI ENCODENT L'EFFACEMENT DANS LES UNIVERS — et K7PL n'en est pas. CE QUE LA SOURCE ÉTABLIT, ET ELLE LE DIT DÈS SON RÉSUMÉ. Les systèmes dépendants actuels n'effacent pas de façon satisfaisante parce qu'ils modélisent l'effacement INDIRECTEMENT, par les univers de types ou par l'irrélevance ; ce faisant ils imposent à l'effacement les limitations de ces moyens-là. Le coût est chiffré en nature : une partie du calcul inutile ne peut plus être effacée, et des programmes idiomatiques restent asymptotiquement sous-optimaux — un programme normalement linéaire pouvant s'exécuter en temps exponentiel. LE CAS D'ÉCOLE EST NOMMÉ. Un assistant obtient l'effacement par un univers SÉPARÉ, réservé aux propositions ; les valeurs de types non propositionnels — les indices d'une famille de types, précisément ce que K7PL manipule — ne peuvent pas s'effacer ainsi. Les tentatives pour contourner par une monade d'effacement butent sur trois choses que la source énumère : une inconsistance de l'axiome d'injectivité si le constructeur va des types vers les propositions, un bruit syntaxique d'entrée et de sortie de monade, et une perte de contextualité en développement interactif. ET L'AUTEUR TRANCHE L'INTERACTION LUI-MÊME, EN UNE PHRASE. La stratification des univers est ORTHOGONALE à son propos, et il attend des implantations qu'elles apportent la leur. CE QUE K7PL RENCONTRE, DONC, ET C'EST UNE ABSENCE D'INTERACTION PLUTÔT QU'UNE INTERACTION. Le grade n'est pas un univers : il vit sur la LIAISON, non sur la sorte du type, et l'effaçabilité au grade nul est un lemme de la sémantique opérationnelle et non une propriété de la place du type dans une hiérarchie. Ce document est donc du côté où l'interaction n'a pas lieu, et il y est pour la même raison que la source — l'annotation est portée par le jugement. CE QUE CELA COÛTE, ET IL FAUT LE DIRE : la stratification des univers reste ENTIÈREMENT à faire, et ce n'est pas cette question qui la fera. Elle est orthogonale, ce qui veut dire qu'elle ne se déduit de rien de ce qui précède.

#### Suivi d'avancement

1.  \[DONE\] tejiscakDependentlyTypedCalculus2020

2.  \[DONE\] abelGradedModalDependent2023

### \[DONE\] \[#A\] La condition de séparation de P2 — les variables de formation portent un grade nul — est-elle celle de la théorie des types quantitative d'Atkey ?

    ARC: B | QUID: QB-17 | REF

Oui, c'est celle de GraD, et ses deux concurrentes sont nommées avec leur coût. La théorie quantitative désactive le contrôle de ressource dans les types, ce qui borne le raisonnement qu'on peut y mener. Abel et Moon tiennent des comptes séparés pour les types et pour les termes, pour une comptabilité plus lourde et un bénéfice moindre. GraD emploie les mêmes règles partout et jette les usages non pertinents au calcul de la ressource totale, ce qui est exactement la condition du document.

#### Suivi d'avancement

1.  \[DONE\] choudhuryGradedDependentType2021

### \[DONE\] \[#A\] Une valeur close à la compilation suffit-elle à rendre le produit LIBRE, ou faut-il une condition de plus ?

    ARC: B | QUID: QB-18 | REF

Non, il faut une condition de plus, et elle a un nom : la GÉNÉRATIVITÉ. C'est l'axiome qui internalise le fait qu'un métaprogramme ne peut pas inspecter la structure des termes du niveau objet, et c'est de lui, non de la clôture, que se tire la fermeture de l'univers des sommes de produits par la somme dépendante. La bonne formulation n'est donc pas que la valeur soit close mais que le métaniveau soit PARAMÉTRIQUE en l'objet.

#### Suivi d'avancement

1.  \[DONE\] kovacsClosurefreeFunctionalProgramming2024

### \[DONE\] \[#A\] Les multiplicités DÉPENDANTES sont hors périmètre. Le fonds confirme-t-il que c'est un choix et non une facilité ?

    ARC: B | QUID: QB-19 | REF

C'est un choix, et le motif est maintenant établi : ce n'est pas une impossibilité démontrée mais une frontière non ouverte. La source qui va le plus loin dans cette direction écrit que les grades de première classe sont un travail à venir, et donne l'obstacle — on ne peut pas employer de termes arbitraires comme grades dans l'implantation, si bien que des grades particuliers ont dû être choisis à la main pour la comultiplication. Aucune des quatre théories dépendantes graduées du fonds ne les traite, et l'une dit pourquoi.

#### Suivi d'avancement

1.  \[DONE\] moonGradedModalDependent2021

2.  \[DONE\] choudhuryGradedDependentType2021

### \[DONE\] \[#A\] Les types indexés par la longueur et les conaturels : la gradation INDEXÉE qu'exige un effet dépendant de valeurs est-elle celle de Kura ?

    ARC: B | QUID: QB-20 | REF

Elle est connue depuis 2026 et elle porte un nom : les MONADES GRADUÉES INDEXÉES. Les auteurs posent le même diagnostic que l'annexe G dans les mêmes termes — les cadres catégoriques pour les monades graduées ne supportent pas les effets qui dépendent des valeurs du programme — et donnent la généralisation qui les supporte, inspirée de la vue fibrée et de la sémantique des théories dépendantes. Le document a donc raisonné juste et travaillait sans sa référence. Une borne à connaître : les formules de la source n'admettent que des termes de valeur terrestres, ni abstraction ni fonction récursive ni effet générique, ce qui suffit à un indice de vecteur mais non à un effet indexé par le résultat d'un appel.

#### Suivi d'avancement

1.  \[DONE\] kuraCategoryTheoreticFrameworkDependent2026

2.  \[DONE\] altenkirchIndexedContainers2015

### \[DONE\] \[#A\] Le paramètre d'ÂGE `Lin_k T` est-il une contrainte de valeur au sens de P2, ou un mécanisme à part ?

    ARC: B | QUID: QB-21 | REF

C'est une contrainte de valeur au sens de P2, et non un mécanisme à part. Chez Bagrel et Spiwack le mode est une PAIRE — une multiplicité et un âge — et l'âge a son algèbre, donnée en table : il se multiplie en s'ajoutant, et il s'additionne en rendant l'infini dès que les deux âges diffèrent. L'âge compte combien de portées imbriquées séparent l'origine d'une destination de son emploi. La source porte en outre un avertissement contre la forme du document : les systèmes à âges en nombre fini sont extraordinairement faciles à rater, et il s'est révélé plus simple d'en concevoir un avec une infinité d'âges exacts.

#### Suivi d'avancement

1.  \[DONE\] bagrelDestinationCalculusLinear2025

### \[DONE\] \[#A\] `Dest T` et `Incomplete A B` sont-ils des types que le NOYAU doit connaître, ou une bibliothèque suffit-elle ?

    ARC: B | QUID: QB-22 | REF

Le noyau doit les connaître, et trois faits l'établissent, dont aucun ne se contourne par une bibliothèque posée sur un noyau inchangé. La grammaire des VALEURS doit changer, une valeur pouvant porter des destinations libres mais aucun trou libre, et une fonction aucun trou du tout. La sûreté exige le suivi des âges, qui est une composante de mode, donc du jugement. Et la sûreté du typage a demandé une preuve mécanisée en Coq. La source ajoute une interdiction que K7PL doit inscrire : la destination ne peut pas être affine, sous peine de lire de la mémoire non initialisée.

#### Suivi d'avancement

1.  \[DONE\] bagrelDestinationCalculusLinear2025

### \[DONE\] \[#A\] Le foncteur d'effacement du système de raffinement a-t-il les propriétés qu'un système de raffinement exige dans la littérature ?

    ARC: B | QUID: QB-23 | REF

La question tombe : un système de raffinement EST un foncteur, littéralement, et aucune condition supplémentaire n'est exigée. Le foncteur d'effacement en est un par le seul fait d'être un foncteur. Ce qui reste à décider est autre chose et le document ne le demande pas : le foncteur est-il une FIBRATION. Le critère est exact — pour tout morphisme et tout raffinement de son but, il existe un tiré-en-arrière — et c'est cette propriété, non la qualité de système de raffinement, qui donnerait l'INFÉRENCE du meilleur raffinement d'un terme effacé.

#### Suivi d'avancement

1.  \[DONE\] melliesFunctorsAreType2015

### \[DONE\] \[#A\] La COHÉRENCE — un programme valide a exactement une signification — est-elle une obligation de métathéorie ou une condition d'erreur ?

    ARC: B | QUID: QB-24 | REF

C'est une obligation de métathéorie, et sa preuve a une forme connue : interpréter chaque sous-typage par une fonction de conversion, éliminer réflexivité et transitivité des dérivations, puis pousser la subsomption à travers les introductions jusqu'à l'unicité des dérivations. La condition est la JOINTURE, et la source le dit pour les sommes comme pour le choix non déterministe. Or le commentaire de la règle de filtrage de l'annexe G s'appuie déjà sur l'existence de bornes supérieures pour justifier que toutes les branches portent le même effet : le document emploie la condition de cohérence sans savoir qu'elle en est une.

#### Suivi d'avancement

1.  \[DONE\] schwinghammerCoherenceSubsumptionMonadic2009

### [IN REVIEW] [#A] Le sous-typage modal `Lin T <: Aff T <: Unr T` est-il dérivable de la structure, ou faut-il l'axiomatiser ?,,    ARC: B | QUID: QB-25 | REF,,Conclusion corrigée le 7 octobre : la recherche bibliographique est close sur le cadre des modes, mais la conclusion normative précédente était trop forte. La littérature définit un mode par une algèbre de grades, un idéal de contraction et un prédicat d'affaiblissement ; elle ne définit pas un mode comme un intervalle de grades. La réécriture de C3 sépare donc les strates syntaxiques `Lin=[1..1]`, `Aff=[0..1]`, `Rel=[1..ω]`, `Unr=[0..ω]` des modes structurels candidats `M_Lin`, `M_Aff`, `M_Rel`, `M_Unr`. Sous cette instanciation candidate, l'identité du porteur commun réalise les morphismes `Lin→Aff`, `Lin→Rel`, `Aff→Unr` et `Rel→Unr`, tandis que `Aff` et `Rel` sont incomparables. Ce résultat est propositionnel et conditionnel : il reste à établir que le jugement et les règles de K7PL réalisent effectivement ces structures. Le fait n'autorise donc pas encore à déclarer que `Lin T <: Aff T <: Unr T` est dérivé des seules inclusions d'intervalles.,#### Suivi d'avancement

1.  \[DONE\] hanukaevUnificationGradedSubstructural2026

### \[DONE\] \[#A\] Le narrowing par les trous `_` et la synthèse dirigée par les types : quel est le coût réel, et le budget le borne-t-il vraiment ?

    ARC: B | QUID: QB-26 | REF

Le coût est négatif : le grade PAIE la synthèse au lieu de la charger. Sur quarante-six programmes de référence, dont plusieurs récursions sur des types de données récursifs, la majorité exigent moins d'exploration qu'une synthèse purement dirigée par les types, et moins d'exemples d'entrée-sortie. Le motif est celui du document : les contraintes de grade réduisent le nombre de programmes typables, donc l'espace de recherche. La technique qui rend la chose praticable est nommée — la focalisation d'Andreoli, qui fixe un ordre sur les règles inversibles — et l'article en donne les règles et leur correction.

#### Suivi d'avancement

1.  \[DONE\] hughesProgramSynthesisGraded2024

### \[DONE\] \[#A\] Une sémantique à grands pas et à environnements élimine-t-elle les lemmes de substitution pour un calcul GRADUÉ, ou seulement pour le CBPV simple ?

    ARC: B | QUID: QB-27 | REF

La question est réglée autrement qu'elle ne se posait. Une sémantique à grands pas et à environnements élimine bien le besoin d'un lemme de substitution, mais K7PL a déjà démontré le sien, et pour autre chose : les relations logiques et la traduction en ont besoin quelle que soit la présentation. L'argument perd donc sa force, et le document retient un seul objet, la relation à petits pas.

#### Suivi d'avancement

1.  \[DONE\] torczonEffectsCoeffectsCallbypushvalue2024

### \[DONE\] \[#A\] La correspondance « une règle de machine par règle de typage » tient-elle en présence de trois couches ?

    ARC: B | QUID: QB-28 | REF

La recherche est close et la réponse est conditionnelle. La correspondance tient dans les deux sources, et dans les deux elle sert à la même chose : établir la correction de ressource contre une machine qui compte. Chez K7PL la relation de réduction ne compte rien, si bien que la question n'est pas de style mais dépend du théorème manquant. Maintenue en cours parce qu'elle se referme avec A.3.6 et non avant, et elle n'attend plus aucune lecture. TRANCHÉE le 3 septembre : LE THÉORÈME QU'ELLE ATTENDAIT EXISTE, et la conditionnelle se résout. La réponse était conditionnelle et sa condition est levée. La correspondance « une règle de machine par règle de typage » sert, dans les deux sources, à établir la correction de ressource contre une machine qui COMPTE ; la relation de réduction de ce document ne comptait rien, de sorte que la question dépendait d'un théorème manquant. CE THÉORÈME EST ÉCRIT. Il étend la configuration d'un COMPTEUR D'USAGES, et établit que pour toute exécution et liaison par liaison, le compte des accès effectifs reste sous la composante d'usage du grade. La machine compte donc désormais, et la correspondance a l'objet qu'il lui fallait. CE QUE CELA RÈGLE POUR LES TROIS COUCHES, ET C'EST LA PART PROPRE À LA QUESTION. La correspondance ne se dédouble pas par couche : le compteur est posé sur la relation de réduction du NOYAU, que les trois couches partagent — elles ne sont pas trois calculs mais trois restrictions du même. Une règle de machine par règle de typage tient donc en présence de trois couches parce qu'il n'y a qu'un jeu de règles, et que la couche se lit sur la forme du contexte plutôt que sur la règle.

#### Suivi d'avancement

1.  \[DONE\] erikssonGradedModalType2025

2.  \[DONE\] choudhuryGradedDependentType2021

### \[DONE\] \[#A\] Les formalisations existantes — Coq pour Torczon, Agda pour les algèbres hefty, Nominal Isabelle pour les psi-calculi — laquelle est la plus proche de ce que LEAN 4 devra porter ?

    ARC: B | QUID: QB-29 | REF

Elles existent et elles sont PARTIELLES, ce qui est le renseignement utile. GraD mécanise en Coq la substitution, l'affaiblissement, la préservation et le progrès, et publie les scripts ; la correction de ressource, elle, reste sur papier. C'est exactement la frontière que l'arc K rencontrera : les propriétés syntaxiques passent, celle qui relie le grade à un comportement observable ne passe pas encore.

#### Suivi d'avancement

1.  \[DONE\] choudhuryGradedDependentType2021

2.  \[DONE\] torczonEffectsCoeffectsCallbypushvalue2024

3.  \[DONE\] abelPOPLMarkReloadedMechanizing2019

### \[DONE\] \[#A\] Les preuves par relations logiques, telles que Torczon les conduit, transportent-elles aux quatre inductions déjà démontrées à la main ?

    ARC: B | QUID: QB-30 | REF

Elles transportent, et le coût est chiffré : quatre-vingt-dix-sept lignes de Beluga pour la normalisation forte, cent quatre-vingt-douze pour la correction de la définition inductive. Ce qui coûte n'est pas l'idée mais l'infrastructure — extensions de contexte, affaiblissement et échange, substitutions et renommages simultanés — et pour K7PL c'est un plancher et non une estimation, ses contextes étant gradués donc chacune de ces opérations portant en plus une condition algébrique. Les auteurs rapportent aussi que l'ajout de quelques règles de réduction pour les sommes disjointes a doublé la preuve de correction, ce qui conforte par un second motif l'indexation de la règle de filtrage. LEAN 4 ne figure pas parmi les trois environnements comparés.

#### Suivi d'avancement

1.  \[DONE\] abelPOPLMarkReloadedMechanizing2019

### \[DONE\] \[#A\] La hiérarchie déterministe / non déterministe / à pile a-t-elle un compte rendu catégorique dans le fonds ?

    ARC: C | QUID: QC-1 | REF

Oui, et la hiérarchie n'est pas celle que la question supposait. Au niveau coalgébrique elle est déterministe, non déterministe, ALTERNANT, et elle est indexée par le choix du FONCTEUR, lequel décide sur quoi l'automate opère — mots, arbres, arbres de branchement non borné, systèmes de transitions étiquetés. Sous une hypothèse unique, que le foncteur préserve les produits fibrés faibles, la classe des langages reconnaissables est close par réunion, intersection et projection, et un automate alternant se transforme en un non déterministe équivalent de taille bornée exponentiellement. Boccali donne l'autre coupe, où le passage du déterministe au non déterministe est un changement de base bicatégorique et l'accessibilité une extension de Kan. Le manque consigné sur l'étage à pile s'en trouve reformulé : la question n'est plus s'il existe un compte rendu mais quel foncteur donne cet étage.

#### Suivi d'avancement

1.  \[DONE\] kupkeCoalgebraicAutomataTheory2008

2.  \[DONE\] boccaliBicategoriesAutomataAutomata2023

3.  \[DONE\] loregianAutomataCoalgebrasCategories2024

### \[DONE\] \[#A\] Le lien entre l'algèbre de grades `𝒢` et la borne mémoire de l'automate est opérationnel. Peut-il devenir STRUCTUREL ?

    ARC: C | QUID: QC-2 | REF

Oui, et par deux voies compatibles dont la seconde est citable sans réserve. Grodin et Harper lisent l'analyse amortie dans une CATÉGORIE D'ALGÈBRES DE COÛT, où la fonction de potentiel devient un morphisme de coalgèbres, donc un objet du langage et non une astuce de preuve, et où les arguments d'amortissement se composent dans la catégorie indexée des coalgèbres. Le cadre est le calcul par poussée de valeur, celui du document. Cela touche directement l'histomorphisme du chapitre 4, dont la borne d'historique par un grade est une borne amortie énoncée sans être nommée. La première voie, par enrichissement sur les ensembles filtrés, reste valide et porte sa réserve de généalogie.

#### Suivi d'avancement

1.  \[DONE\] grodinAmortizedAnalysisCoalgebra2024

2.  \[DONE\] cataltepeTimeComplexityDeterministic2026

### \[DONE\] \[#A\] Les expressions régulières valuées dans un monoïde ordonné par treillis (Li et Pedrycz) donnent-elles le cadre des R-expressions graduées ?

    ARC: C | QUID: QC-3 | REF

Oui, et sous forme d'ÉQUIVALENCE, ce qui est mieux qu'un cadre. Le théorème 3.1 donne trois conditions équivalentes, dont la première est que la structure des valeurs soit un monoïde ordonné par treillis, c'est-à-dire que la multiplication distribue sur les bornes supérieures finies, et les deux autres sont deux formes de l'extension de la fonction de transition aux mots. La source donne l'échelle complète, du monoïde partiellement ordonné jusqu'à la quantale pour la distributivité infinie. L'annexe G travaille déjà sur des quantales ordonnées : elle a plus qu'il n'en faut, et la source dit quelle part de cette force y sert.

#### Suivi d'avancement

1.  \[DONE\] liFuzzyFiniteAutomata2005

### \[DONE\] \[#A\] Un automate à pile borné a-t-il une caractérisation par grades plutôt que par annotation ?

    ARC: C | QUID: QC-4 | REF

Oui, et la caractérisation par discipline a DEUX BRANCHES dont une seule exige la planarité. La branche des automates implicites caractérise les classes d'automates par la discipline de type, mais demande la logique affine non commutative ; le prix de l'y suivre est maintenant chiffré, l'extension étant conservative mais coûtant un troisième contexte et quatre implications au lieu d'une, dont deux directionnelles. La branche de la logique linéaire bornée n'exige rien de tel : la gradation de la modalité exponentielle porte la borne, la complexité de l'élimination des coupures s'analysant en fonction de cette gradation, et la théorie des types à ressources bornées y ajoute un théorème de correction de coût sous BUDGET. C'est cette seconde branche qui est celle de K7PL, et elle est ouverte.

#### Suivi d'avancement

1.  \[DONE\] fukiharaGeneralizedBoundedLinear2021

2.  \[DONE\] mannucciResourceBoundedTypeTheory2025

3.  \[DONE\] pradicImplicitAutomataLcalculi

4.  \[DONE\] polakowNaturalDeductionIntuitionistic1999

### \[DONE\] \[#A\] La minimisation d'un automate gradué a-t-elle un sens pour K7PL, et lequel ?

    ARC: C | QUID: QC-5 | REF

Elle en a un, et il est précis. La réalisation de Nerode existe et est unique à isomorphisme près pour les langages de multiensembles, et un multiensemble est un compte d'occurrences, donc la composante d'usage du grade : minimaliser un automate gradué, c'est en construire la réalisation minimale du comportement, ce qui donne un critère d'identité entre deux automates construits différemment. Heerdt en donne la version générale sous hypothèses modestes, avec les effets de bord en paramètre et une procédure de déterminisation. Et Bojańczyk ajoute que la minimalisation des automates déterministes survit au cadre nominal indépendamment de la symétrie des données.

#### Suivi d'avancement

1.  \[DONE\] yadavGeneralCategoricalFramework2022

2.  \[DONE\] heerdtTreeAutomataAlgebras2019

3.  \[DONE\] bojanczykAutomataTheoryNominal2014

### \[DONE\] \[#A\] L'apprentissage d'automates — approche algébrique, approche catégorique — a-t-il un usage pour la SYNTHÈSE dirigée par les types du chapitre 3 ?

    ARC: C | QUID: QC-6 | REF

Un usage indirect, et un argument d'unité que le document n'emploie pas. Le cadre d'apprentissage est paramétrique en une MONADE, dont les langages sortés, les langages nominaux avec liaison et les fonctions de coût sont trois instances — soit les sortes de K7PL, son hygiène et son budget, trois traits que le document traite en trois endroits. Pour la synthèse proprement dite, le cadre donne l'inférence d'un automate à partir d'observations, ce qui est le pendant côté comportement de ce que la synthèse dirigée par les grades fait côté type. Le fonds porte en outre l'apprentissage dans la classe même où la syntaxe de K7PL se trouve, ce qui rapproche les deux versants ; cette pièce reste à lire.

#### Suivi d'avancement

1.  \[DONE\] urbatAutomataLearningAlgebraic2020

2.  \[DONE\] jiaVstarLearningVisibly2024

3.  \[DONE\] heerdtCategoricalFrameworkLearning2022

### \[DONE\] \[#A\] Les automates à actions de groupe et les ensembles nominaux : la structure liante de K7PL rencontre-t-elle cette littérature ?

    ARC: C | QUID: QC-7 | REF

Elle la rencontre, et la rencontre est utilisable : les définitions classiques sont reprises telles quelles, une seule hypothèse changeant, la finitude devenant la FINITUDE PAR ORBITES, et un théorème de Myhill-Nerode s'obtient pour alphabets infinis. Mais elle porte un avertissement qui vise le chapitre 4. Divers résultats classiques échouent dans ce cadre, et le premier nommé est que LA DÉTERMINISATION STANDARD ÉCHOUE, la construction de l'ensemble des parties finies ne préservant pas la finitude par orbites. Or le chapitre annote d'un coût polynomial les motifs qui se résolvent par un automate non déterministe, ce qui suppose la déterminisation.

#### Suivi d'avancement

1.  \[DONE\] bojanczykAutomataTheoryNominal2014

2.  \[DONE\] bojanczykAutomataGroupActions2011

3.  \[DONE\] pittsNominalSetsNames2013

### \[DONE\] \[#A\] Un transducteur est-il le bon modèle pour l'abaissement d'une couche vers l'autre ?

    ARC: C | QUID: QC-8 | REF

Oui, avec une réserve de forme qui coûte. La direction difficile de la preuve compile les termes en TRANSDUCTEURS PLANAIRES RÉVERSIBLES À DEUX SENS ; un transducteur à un sens ne suffit pas, et deux sens veut dire que la lecture peut revenir en arrière, ce qui n'est pas gratuit pour un abaissement en flux. Les machines à cordes en donnent une seconde lecture, où le transducteur est un foncteur qui envoie les morphismes d'une catégorie sur des recettes de construction de morphismes d'une autre. Un point technique à retenir si le modèle est repris : l'interprétation n'identifie pas les termes bêta-équivalents, elle transforme les bêta-réductions en inégalités.

#### Suivi d'avancement

1.  \[DONE\] pradicImplicitAutomataLcalculi

2.  \[DONE\] cataltepeTimeComplexityDeterministic2026

### \[DONE\] \[#A\] Quelle CLASSE de grammaire la syntaxe de K7PL exige-t-elle, une fois les délimiteurs de couche et l'arité fixe posés ?

    ARC: C | QUID: QC-9 | REF

Celle des grammaires À PILE VISIBLE, et le document y est déjà sans le savoir. Une grammaire est de cette classe quand la structure d'appel et de retour se lit dans l'alphabet même ; or le chapitre 5 pose trois paires de délimiteurs qui ne s'imbriquent que dans un seul sens, avec ouverture et fermeture distinctes et fixées. La contrainte a été choisie pour un motif de couches, et elle rend gratuitement une classe où l'analyse est linéaire, la vérification d'imbrication décidable, et l'algorithme central formellement vérifié en Coq. Les grammaires d'expressions d'analyse, que le chapitre 4 offre par ailleurs dans son interface de filtrage, restent pertinentes pour les motifs de l'utilisateur, avec l'avertissement sur la réordonnabilité indécidable.

#### Suivi d'avancement

1.  \[DONE\] jiaDerivativebasedParserGenerator2021

2.  \[DONE\] fordParsingExpressionGrammars

### \[DONE\] \[#A\] Un train sans délimiteurs est analysable si les arités sont fixes — V-1 l'établit. Quelle classe d'analyseur cela demande-t-il exactement ?

    ARC: C | QUID: QC-10 | REF

La réponse est tranchée et elle est défavorable à la voie qu'on aurait prise par défaut. L'analyse à mémoïsation donne le temps linéaire, mais son auteur nomme lui-même l'inconvénient principal : l'utilisation d'ESPACE est proportionnelle à la TAILLE DE L'ENTRÉE et non à la profondeur maximale de récursion, deux grandeurs qui peuvent différer de plusieurs ordres de grandeur, et sa défense est comparative, non absolue. L'analyse par dérivée d'une grammaire à pile visible donne le même temps linéaire avec une PILE, donc un espace proportionnel à la profondeur d'imbrication. Sur le postulat qui interdit de dissimuler un coût, la seconde domine la première, et la syntaxe de K7PL est déjà dans sa classe.

#### Suivi d'avancement

1.  \[DONE\] fordPackratParsingSimple

2.  \[DONE\] jiaDerivativebasedParserGenerator2021

### \[DONE\] \[#A\] La vérification d'imbrication `ERR-TOP-001` est purement syntaxique et descend en Phase 1. Le fonds confirme-t-il que cette classe de vérification est décidable en temps linéaire ?

    ARC: C | QUID: QC-11 | REF

La question conflait deux choses, et les deux ont maintenant leur réponse. Ce que la règle sanctionne n'est pas syntaxique : le chapitre 5 rejette en Phase 2 une expression dont la vérification exige une composante que le jugement ambiant ne porte pas, et aucune phase syntaxique ne décide cela. Mais l'ordre d'imbrication des trois paires de délimiteurs, lui, est syntaxique, et il tombe exactement dans les grammaires à pile visible : reconnaissance en temps linéaire, algorithme central vérifié en Coq, et une forêt de tous les arbres valides plutôt qu'une lecture élue en silence.

#### Suivi d'avancement

1.  \[DONE\] jiaDerivativebasedParserGenerator2021

### \[DONE\] \[#A\] Le lexeur de K7PL — huit caractères structurels et l'espace — pose-t-il un problème d'ambiguïté que la littérature aurait déjà rencontré ?

    ARC: C | QUID: QC-12 | REF

Le problème disparaît avec la séparation qui le produit : la source réunit lexical et hiérarchique en une grammaire unique, si bien qu'il n'y a pas d'analyseur lexical séparé où une ambiguïté pourrait naître. La littérature a bien rencontré le problème, et deux fois plutôt qu'une : la source cite deux langages où l'ambiguïté a dû être tranchée par une MÉTARÈGLE INFORMELLE inscrite dans la spécification, la plus longue correspondance chez l'un, la préférence pour la définition chez l'autre. C'est précisément ce que le choix priorisé et les prédicats syntaxiques permettent d'écrire au lieu de le dire.

#### Suivi d'avancement

1.  \[DONE\] fordParsingExpressionGrammars

### \[DONE\] \[#A\] Quelle est la classe de complexité de la vérification de grades de K7PL ?

    ARC: D | QUID: QD-1 | REF

La question porte sur la VÉRIFICATION et non sur l'inférence, que K7PL ne tente pas. Elle se décompose en deux parts. La part structurelle est bidirectionnelle et dirigée par la syntaxe, donc linéaire en la taille du terme, et sa terminaison est garantie par un graphe de dépendance acyclique entre variables de type, grades, dimensions et variables de rangée (c3). La part de contraintes est exportée au solveur, donc bornée par les théories nommées en QD-3. Aucune classe de complexité n'est caractérisée, et c'est cohérent : la doctrine du budget déclaré vaut à la compilation comme à l'exécution, le grade étant porté par l'unité de compilation (c6). Le document est cohérent sur ce point et ne le dit pas ; acquis à revendiquer.

#### Suivi d'avancement

1.  \[DONE\] torczonEffectsCoeffectsCallbypushvalue2024

2.  \[DONE\] orchardQuantitativeProgramReasoning2019

### \[DONE\] \[#A\] L'inférence de grades est-elle décidable ?

    ARC: D | QUID: QD-2 | REF

Écartée par conception, et c3 le dit avec trois précédents : K7PL n'infère pas les grades d'une définition non annotée et ne produit pas de type le plus général, parce qu'aucun système gradué comparable ne le fait — Granule range inférence et types principaux parmi ses travaux futurs, la théorie graduée dépendante de Moon, Eades III et Orchard procède de même, et le typage des types linéaires indexés se réduit à une théorie du premier ordre indécidable. La question n'est pas ouverte : elle est refusée, avec son motif.

#### Suivi d'avancement

1.  \[DONE\] orchardQuantitativeProgramReasoning2019

### \[DONE\] \[#A\] Le solveur du chapitre 6 décharge des contraintes de raffinement. Quelle théorie SMT ces contraintes habitent-elles, et est-elle décidable ?

    ARC: D | QUID: QD-3 | REF

Répondue par c6, qui nomme les trois théories : arithmétique linéaire sur les entiers et les rationnels pour les bornes de taille et les grades fractionnaires, théorie des tableaux pour les accès d'arène, fonctions non interprétées pour les prédicats de raffinement opaques. Toutes sont décidables, ce qui fonde l'argument de terminaison de la Phase 5. Deux réserves sont nommées par le document lui-même : leur combinaison n'est pas nécessairement décidable et le fragment employé n'est pas caractérisé ; et le solveur est traité comme une boîte noire dont aucun certificat n'est réclamé, une réponse négative étant crue sur parole. Ce sont deux items de travail, non deux questions ouvertes.

#### Suivi d'avancement

1.  \[DONE\] répondue par le corps, sans source externe

### \[DONE\] \[#A\] L'arithmétique de Presburger suffit-elle aux bornes de taille de P3 ?

    ARC: D | QUID: QD-4 | REF

Presburger n'est pas la question. Le langage de contraintes de c3 comporte des produits, donc il excède l'arithmétique de Presburger ; et c3 distingue explicitement ce que la restriction achète — la prévisibilité du temps de compilation — de la décidabilité, qui vient d'ailleurs et s'obtient sur un semi-anneau partiellement ordonné arbitraire. Reste à vérifier que la source de décidabilité couvre bien les produits de VARIABLES et non des seuls produits par des constantes.

#### Suivi d'avancement

1.  \[DONE\] répondue par le corps, sans source externe

### \[DONE\] \[#A\] La recherche de preuve dirigée par les types du chapitre 3 « peut échouer par épuisement de budget ». Cet échec est-il DÉCIDABLE, ou seulement semi-décidable ?

    ARC: D | QUID: QD-5 | REF

Décidable, et c'est précisément ce que le budget achète. Une recherche non bornée est semi-décidable : on ne sait pas distinguer « pas encore trouvé » de « n'existe pas ». Une recherche budgétée s'arrête, et l'arrêt est un fait observable. c6 emploie la même mécanique pour la spécialisation : l'épuisement arrête la duplication au lieu d'échouer. Le budget ne rend pas la recherche complète — un programme légitime peut être refusé faute de budget — il la rend terminante. C'est un échange de complétude contre décidabilité.

#### Suivi d'avancement

1.  \[DONE\] répondue par le corps, sans source externe

### \[DONE\] \[#A\] La compilation bornée — « aucune obligation de compilation ne doit être indécidable » — est-elle vérifiable, ou est-ce une intention ?

    ARC: D | QUID: QD-6 | REF

Établie, et c6 conduit l'argument en entier. Trois optimisations font strictement décroître une mesure entière : déforestation, défonctionnalisation, fusion de boucles. L'inlining fait exception puisqu'il duplique un corps. D'où un budget de spécialisation, grade porté par l'unité de compilation, que chaque intégration et chaque monomorphisation décrémentent et dont l'épuisement arrête la duplication au lieu d'échouer. L'itération des Phases 5 et 6 est alors un point fixe atteint en un nombre de tours borné par la somme des budgets. Le chapitre ajoute que ces deux phases doivent itérer jusqu'à stabilisation et non s'enchaîner une fois.

#### Suivi d'avancement

1.  \[DONE\] répondue par le corps, sans source externe

### \[DONE\] \[#A\] TXR mesure 36 → 14 instructions selon le niveau d'optimiseur. K7PL a-t-il une mesure équivalente à produire pour sa borne de compilation ?

    ARC: D | QUID: QD-7 | REF

L'unité est choisie et c6 la donne : tout travail de compilation est borné par un grade porté par l'unité de compilation, et ce grade se mesure en compte de ressource reproductible, jamais en délai — ce qui est P4 appliqué à la mesure elle-même. Le nombre attend un prototype, comme dix des douze entrées empiriques. TRANCHÉE le 3 septembre : L'UNITÉ EST CHOISIE, LE NOMBRE ATTEND UN PROTOTYPE, ET CE N'EST PAS UNE QUESTION OUVERTE. CE QUI EST ÉTABLI. Tout travail de compilation est borné par un grade porté par l'unité de compilation, et ce grade se mesure en COMPTE DE RESSOURCE REPRODUCTIBLE, jamais en délai — ce qui est le postulat de déterminisme appliqué à la mesure elle-même. La mesure de la source, elle, compte des INSTRUCTIONS selon le niveau d'optimiseur : c'est la même espèce d'unité, et la comparaison sera donc possible. POURQUOI CELA CLÔT LA QUESTION PLUTÔT QUE DE LA LAISSER OUVERTE. Ce qui manque n'est ni une source ni une décision : c'est une EXÉCUTION. Le projet n'a pas de compilateur, et dix des douze entrées empiriques du programme sont dans le même cas. Une question dont la réponse attend un prototype n'est pas une question de recherche ouverte, c'est un poste de mesure déclaré.

#### Suivi d'avancement

1.  \[DONE\] références à identifier

### \[DONE\] \[#A\] K7PL exclut la récursion générale dans les trois couches. Quelle CLASSE de fonctions reste exprimable ?

    ARC: D | QUID: QD-8 | REF

Le document ne le dit pas en un endroit, mais il le dit en trois : les trois critères de terminaison sont trois portes d'entrée. L'algèbre initiale, où toute itération de couche 3 est un pli dépendamment typé sur le plus petit point fixe d'un conteneur. La coalgèbre terminale, qui fonde la productivité des flux et des acteurs. Le point fixe déductif sur un treillis fini, stationnaire en au plus la hauteur du treillis, dont la règle se lit sur le grade et non sur la forme du terme. Ce qui n'entre par aucune porte n'est pas exprimable. Borne basse : au moins System F, la couche 3 portant la quantification universelle, plus les types inductifs et les indices de taille. Borne haute : totales, et rien que totales — la couche 3 n'est pas Turing-complète. La classe exacte dépend de la force de l'appareil des tailles, que le document ne fixe pas ; la pinner est une décision de mécanisation, non de conception. Quatre sorties sont nommées : la négation stratifiée, que c7 signale explicitement ; la recherche non bornée ; le point fixe sur treillis de hauteur infinie ; l'interprète d'un langage Turing-complet. Toutes ont le même remède architectural — ce qui n'entre par aucune porte descend en couche 2, comme effet ou comme processus. La sédimentation a donc une seconde fonction, qui n'est écrite nulle part : elle accueille ce que la couche supérieure refuse.

#### Suivi d'avancement

1.  \[DONE\] abelWellfoundedRecursionCopatterns2016

2.  \[DONE\] hinzeUnifyingStructuredRecursion2016

### \[DONE\] \[#A\] Le document déclare ne pas caractériser une classe de complexité — « le budget est DÉCLARÉ, non borné par le système ». Cette position a-t-elle un nom dans la littérature ?

    ARC: D | QUID: QD-9 | REF

La position de K7PL n'est pas dans la complexité implicite : elle en est l'extérieur assumé. Le paysage a trois positions. La caractérisation sans ressource, de Bellantoni-Cook et Leivant, où la seule discipline sur les variables donne la classe sans aucune annotation — complète pour le temps polynomial, et muette sur le coût d'un programme donné. La caractérisation par indices, dont la logique linéaire bornée est le type, où les indices sont des polynômes. Et le budget déclaré, qui est la position de K7PL : correction par programme, aucune borne sur la classe des programmes typables. Les deux premières bornent l'ensemble des programmes, la troisième borne chaque programme par ce qu'il annonce. Ce n'est pas un degré moindre de la même chose, c'est un autre objet. Le nom juste n'est pas complexité implicite mais système de coût déclaré et vérifié.

#### Suivi d'avancement

1.  \[DONE\] caporasoPredicativeApproachClassification2001

### \[DONE\] \[#A\] La logique linéaire bornée caractérise le temps polynomial parce que ses indices SONT des polynômes. Quelle serait la condition pour que K7PL caractérise quelque chose ?

    ARC: D | QUID: QD-10 | REF

Le manuscrit donne la condition générale — que le langage d'indices soit exactement aussi expressif que la classe — et la réponse locale est une raison de ne pas le faire. Contrairement à ce que j'avais d'abord cru, l'obstacle n'est pas la condition de clôture de P2 : c1 dit qu'une borne peut dépendre d'un indice de taille, donc être polynomiale en la taille d'entrée. L'obstacle est que le système ne rejette rien sur le fondement de la taille du budget. Caractériser le temps polynomial exigerait deux choses ensemble : restreindre le langage de budget aux polynômes, et rejeter tout budget déclaré hors de ce langage — ce second point manquant entièrement. Et le prix serait exactement celui-là : tout programme dont la borne légitime est exponentielle deviendrait inécrivable, alors qu'une compilation, une recherche exhaustive ou un solveur en sont. La réserve du chapitre 1 cesse d'être un aveu pour devenir un choix dont le prix est chiffré.

#### Suivi d'avancement

1.  \[DONE\] répondue par le corps, sans source externe

### \[DONE\] \[#A\] La terminaison de la couche 3 est « garantie par preuve statique ». Par quel critère exactement, et ce critère est-il complet ?

    ARC: D | QUID: QD-11 | REF

Le critère est la terminaison fondée sur les types, avec indices de taille et récurrence bien fondée sur les ordinaux. c2 le pose déjà : la garantie repose non sur un critère syntaxique d'arguments plus petits mais sur les types seuls, parce qu'une mesure structurelle décroissante n'est pas disponible sur un type imbriqué. Il est complet là où le gardiennage syntaxique ne l'est pas : Abel et Pientka établissent que le gardiennage échoue sur les programmes d'ordre supérieur, où la productivité d'une fonction dépend du comportement d'une autre, et qu'il n'est pas compositionnel — les deux limites tenant au manque d'information dans une vérification purement syntaxique.

#### Suivi d'avancement

1.  \[DONE\] abelWellfoundedRecursionCopatterns2016

### \[DONE\] \[#A\] Les trois critères de terminaison du document sont ARRÊTÉS. Le fonds en connaît-il un quatrième que le projet gagnerait à admettre ?

    ARC: D | QUID: QD-12 | REF

Le quatrième critère que le fonds connaît est le gardiennage syntaxique employé par Coq et Agda, et il est inférieur pour les deux raisons ci-dessus. Rien à admettre. En revanche le fonds apporte autre chose : la productivité devient une instance de la terminaison dès que les objets infinis sont construits par copatrons, d'où un traitement unifié de la récursion et de la corécursion. c2 affirme la même chose catégoriquement sans en tirer la conséquence opérationnelle.

#### Suivi d'avancement

1.  \[DONE\] abelWellfoundedRecursionCopatterns2016

### \[DONE\] \[#A\] Les théorèmes d'incomplétude posent-ils une limite à ce que la mécanisation en LEAN 4 pourra établir sur K7PL lui-même ?

    ARC: D | QUID: QD-13 | REF

La réponse utile n'est pas que Gödel borne, mais que ce qui sera admis doit être listé. Trois points. La dépendance est relative et il faut l'écrire : une mécanisation établit la métathéorie de K7PL relativement à la cohérence de la théorie de LEAN, ce qui n'est pas une limite propre à K7PL. La force requise est atteinte : démontrer la normalisation forte d'un système aussi fort que System F exige une métathéorie plus forte que l'arithmétique du second ordre, et la théorie des types de LEAN l'est. Et la limite réelle est d'ingénierie, non de logique : ce sont les deux hypothèses de module du théorème de progrès — totalité des réalisations d'opérations, conformité de l'abaissement pour l'arène — qui seront admises et non démontrées.

#### Suivi d'avancement

1.  \[DONE\] répondue par le corps, sans source externe

### \[DONE\] \[#C\] Peut-on rendre certaines violations de grade INEXPRIMABLES plutôt que détectées ?

    ARC: D | QUID: QD-14 | REF

Le geste existe déjà dans le document, deux fois, et il n'est pas nommé. Le théorème d'hygiène conclut qu'une capture n'est pas évitée par un renommage mais inécrivable, produire une occurrence hors de l'index de portée reçu demanderait un terme qui n'est pas dans le préfaisceau. Et l'audit des primitives a établi qu'une violation de couche n'est pas détectée par une règle : elle échoue à se dériver, faute de la ressource que le jugement ambiant ne porte pas. La question devient donc une question de généralisation, non d'invention, et le critère est net : partout où une garantie est aujourd'hui portée par une règle de rejet plutôt que par la forme du jugement. L'inventaire des codes d'erreur du document est la revue à faire. TRANCHÉE le 3 septembre : OUI, ET LE DOCUMENT LE FAIT DÉJÀ DEUX FOIS SANS LE NOMMER. LE PREMIER GESTE EST AU THÉORÈME D'HYGIÈNE. Une capture accidentelle n'y est pas ÉVITÉE par un renommage : elle est INEXPRIMABLE. Produire une occurrence hors de l'index de portée reçu demanderait un terme qui n'est pas dans le préfaisceau, et un tel terme ne s'écrit pas. LE SECOND EST À L'AUDIT DES PRIMITIVES. Une violation de couche n'est pas DÉTECTÉE par une règle qui la refuserait : elle échoue à se DÉRIVER, faute de la ressource que le jugement ambiant ne porte pas. Il n'y a pas de règle de rejet, il y a une absence de règle d'acceptation. D'OÙ LA RÉPONSE, ET ELLE EST UN CRITÈRE PLUTÔT QU'UN OUI. Une violation devient inexprimable quand ce qui l'interdit est porté par la STRUCTURE de l'objet — l'index d'un préfaisceau, la ressource d'un contexte — et non par une clause qui l'examine. La différence se lit à un signe : dans le premier cas aucun message d'erreur n'est possible, puisqu'il n'y a rien à refuser. CE QUE CELA COÛTE, ET C'EST LE REVERS QU'IL FAUT ÉCRIRE. Une violation inexprimable ne se DIAGNOSTIQUE pas. Le lecteur reçoit un échec de dérivation, non une explication, et c'est précisément ce que la stratification signal / règle / connaissance de l'annexe des codes d'erreur doit compenser. Rendre inexprimable est un gain de sûreté et une perte de diagnostic, et les deux se paient au même endroit.

#### Suivi d'avancement

1.  \[DONE\] clingerHygienicMacroTechnology

### \[DONE\] \[#A\] Le treillis distributif borné de la précision `⊑` est-il le bon cadre, ou un préordre suffirait-il ?

    ARC: E | QUID: QE-1 | REF

Un préordre suffit, et le document le dit lui-même sans en tirer la conséquence. Trois constats, tous vérifiables sur le texte. Premier : l'ENRICHISSEMENT est déclaré sur les préordres — le chapitre 2 écrit que l'exigence de monotonie de la composition et du tenseur est très exactement la structure d'une catégorie enrichie sur les préordres. Deuxième : le treillis distributif borné est affirmé à part, sur les catégories d'artefacts syntaxiques, et de cette structure le document n'emploie que l'ordre, le joint et le minimum — le joint sept fois, dont l'annexe où il est une fonction DÉFINISSABLE par récurrence et non une primitive. Troisième : la RENCONTRE apparaît une seule fois dans tout le manuscrit, dans la phrase qui la déclare, et n'est jamais employée ; la DISTRIBUTIVITÉ est nommée dans la même phrase et jamais invoquée. Un demi-treillis supérieur borné suffit donc partout, et le théorème de raffinement établit d'ailleurs que la part fibre par fibre n'est pas un engagement du tout mais ce qu'un système de raffinement possède par construction.

#### Suivi d'avancement

1.  \[DONE\] melliesFunctorsAreType2015

2.  \[DONE\] huntReconcilingShannonScott2023

3.  \[DONE\] DATAFUN

### \[DONE\] \[#A\] Le théorème de point fixe employé pour l'extension déductive est-il celui de Tarski, et ses hypothèses sont-elles vérifiées ?

    ARC: E | QUID: QE-2 | REF

Oui, c'est celui de Knaster et Tarski, le document le nomme, et ses hypothèses sont vérifiées et écrites. Le treillis fini y porte un plus petit élément et une hauteur bornée, la fonction est monotone par typage et non par vérification sur le terme, et l'égalité décidable détecte la stationnarité. La chaîne issue du plus petit élément est croissante, stationnaire en au plus la hauteur, et sa limite est le plus petit point fixe puisque tout point fixe majore cette chaîne. Le document porte en outre sa propre réserve, que la borne est celle du type et non du calcul. La question était de contrôle, et le contrôle passe.

#### Suivi d'avancement

1.  \[DONE\] DATAFUN

### \[DONE\] \[#A\] La théorie des domaines donne-t-elle au coût une sémantique dénotationnelle, comme Kavvos l'obtient pour ses récurrences ?

    ARC: E | QUID: QE-3 | REF

Oui, et en DEUX temps, ce qui est la partie utile. D'abord une extraction syntaxique du programme vers une récurrence, avec un théorème de borne : tout programme source est borné par la récurrence extraite. Ensuite une sémantique dénotationnelle du langage des récurrences, qui abstrait les types inductifs vers une notion de TAILLE, le choix de l'interprétation étant le choix de la mesure — le constructeur de nœud interprété par le maximum donne la hauteur, par l'addition le nombre de nœuds. Le tout dans le calcul par poussée de valeur. C'est une quatrième source de la famille du théorème manquant, et sa particularité est de factoriser en deux ce que les autres font d'un coup, ce qui permettrait une extraction et quatre interprétations pour les quatre composantes du grade.

#### Suivi d'avancement

1.  \[DONE\] kavvosRecurrenceExtractionFunctional

2.  \[DONE\] dannerDenotationalSemanticsFoundation2022

3.  \[DONE\] cutlerDenotationalRecurrenceExtraction2020

### \[DONE\] \[#A\] L'ordre inversé du semi-anneau tropical a-t-il un usage pour `𝒢_budget` ?

    ARC: E | QUID: QE-4 | REF

Un usage possible et un prix connu. On y gagnerait le minimum comme somme ; on y perdrait la finitude de l'axiomatisation, car AUCUN des semi-anneaux exotiques usuellement considérés n'a de base finie pour ses équations, ni les semi-anneaux faibles commutatifs idempotents qui les sous-tendent. Conséquence d'implantation : un normaliseur d'égalités de grades par réécriture ne peut pas être complet sur une telle structure, quel que soit le soin mis aux règles. Mais la décision n'est pas perdue, les auteurs donnant des caractérisations des équations valides et la description des algèbres libres. Le budget actuel, ordonné par l'ordre croissant et composé par soustraction tronquée partielle, n'est pas littéralement tropical et échappe donc à l'avertissement tant qu'il le reste.

#### Suivi d'avancement

1.  \[DONE\] acetoAxiomatizingTropicalSemirings2001

### \[DONE\] \[#A\] Les métriques comportementales et les logiques quantitatives donnent-elles une notion de DISTANCE entre programmes gradués, et K7PL en aurait-il l'usage ?

    ARC: E | QUID: QE-5 | REF

Oui, et la forme du lien est ce qui compte : ce n'est pas une métrique posée à côté d'une logique, c'est une métrique CARACTÉRISÉE par une logique, au sens d'un théorème de Hennessy-Milner énonçant que la distance induite par la logique quantitative coïncide avec la distance comportementale. Pour K7PL, cela dit ce qu'il faudrait pour avoir une distance entre programmes gradués : non pas définir la distance, mais exhiber la logique quantitative dont elle serait la distance induite. La généralisation coalgébrique se fait en PARAMÉTRANT LE TYPE DE BRANCHEMENT, qui est le même paramètre que le foncteur de la théorie universelle des automates. Réserve de statut : un rapport de séminaire est un état des lieux, non une source de résultat.

#### Suivi d'avancement

1.  \[DONE\] konigBehaviouralMetricsQuantitative2025

### \[DONE\] \[#A\] Le pipeline de compilation en huit phases est un graphe. Ses propriétés — acyclicité, ordre topologique — sont-elles vérifiées ou supposées ?

    ARC: E | QUID: QE-6 | REF

La question suppose un graphe là où le document a une CHAÎNE, et cela change la réponse. Le chapitre 6 décrit un ordre strictement séquentiel, chaque phase n'étant là que parce que la précédente devait être acquise avant elle, et l'ordre est argumenté phase par phase par une dépendance nommée — la modalité et le type avant l'élaboration, l'élaboration avant les effets, les effets avant la terminaison, la terminaison avant le solveur. Sur une chaîne, l'acyclicité est triviale et l'ordre topologique est l'ordre lui-même : il n'y a rien à vérifier. Il reste UN endroit où un cycle existe réellement, et le chapitre le nomme : l'itération d'optimisation, où l'intégration ne retire une indirection qu'en dupliquant un corps, si bien que la taille du terme peut croître et avec elle le nombre de contraintes du tour suivant. Le chapitre y répond par un budget. La propriété est donc supposée là où elle est triviale et argumentée là où elle ne l'est pas ; ce qui manque est seulement de dire que le pipeline est une chaîne et non un graphe.

#### Suivi d'avancement

1.  \[DONE\] vérification interne au manuscrit

### \[DONE\] \[#A\] Le DAG de spécialisation des combinateurs de Hoekstra a-t-il une structure algébrique, au delà de la lecture substructurelle qu'on en a faite ?

    ARC: E | QUID: QE-7 | REF

Elle en a une, elle est classique, et la lecture sous-structurelle n'en couvre que la moitié. Les arêtes du graphe sont de deux espèces, que l'auteur distingue par le trait : poser deux termes ÉGAUX l'un à l'autre, ce qui est une contraction ; et poser un terme égal au combinateur IDENTITÉ, ce qui n'est pas un affaiblissement mais une substitution d'unité. La structure est donc l'ORDRE D'INSTANCE sur les termes — un combinateur est spécialisation d'un autre quand il en est une instance par substitution — ordre bien connu, calculable par filtrage dans un sens et par anti-unification dans l'autre. Conséquence directe pour le document : un compilateur peut DÉRIVER quelle spécialisation s'applique au lieu de la faire déclarer. Réserve de statut : mémoire de maîtrise, à employer pour la structure et non comme autorité.

#### Suivi d'avancement

1.  \[DONE\] hoekstraCombinatorNdimensionalArray

### \[DONE\] \[#A\] La formalisation d'algorithmes de graphes par coinduction éclaire-t-elle la terminaison des parcours de la couche 3 ?

    ARC: E | QUID: QE-8 | REF

Elle l'éclaire, et la réponse est un déplacement de couche. Un graphe y est une fonction des sommets vers des ensembles pondérés NON NÉCESSAIREMENT FINIS, générique sur une large classe de poids, et les algorithmes deviennent des transformations de graphes. Les poids génériques sont des grades, et leur classe admissible est à comparer à l'algèbre du document. La non-finitude des voisinages est ce qui rend le traitement coinductif : un parcours de graphe n'a pas d'indice décroissant puisque le graphe peut être cyclique, et sa terminaison ne vient donc pas d'une décroissance mais d'une PRODUCTIVITÉ. Il relève de la couche 2, non de la couche 3 — c'est la lecture de recours de la sédimentation, appliquée à un cas concret.

#### Suivi d'avancement

1.  \[DONE\] kidneyFormalisingGraphAlgorithms2025

2.  \[DONE\] erwigInductiveGraphsFunctional2001

### \[DONE\] \[#A\] La déduplication canonique de la couche 1 est un partage de graphe. A-t-elle un compte rendu formel dans le fonds ?

    ARC: E | QUID: QE-9 | REF

Elle en a un, et il tient en deux temps dont le second est un obstacle de forme. Le premier : observer que deux sous-termes sont LE MÊME OBJET, et non seulement égaux, coûte la transparence référentielle, et la sortie usuelle est de restreindre à certains types. Le second est meilleur et il est démontré : le partage s'exprime comme un COEFFET, donc comme un grade, avec préservation par réduction du type, du partage et des modificateurs, et détection statique de l'unicité et de l'immuabilité par-dessus. Mais les auteurs signalent que ce sont des coeffets NON STRUCTURELS, qui ne se calculent pas variable par variable, la manière dont une variable est employée pouvant affecter les coeffets d'autres variables. Or le grade de K7PL est strictement par variable. Le dispositif qui contourne l'obstacle est nommé : des LIENS, ensemble attaché à chaque variable, le partage étant l'intersection non vide. C'est une composante ensembliste à ajouter, non une valeur de plus dans le quadruplet.

#### Suivi d'avancement

1.  \[DONE\] gillTypesafeObservableSharing

2.  \[DONE\] bianchiniCoeffectsSharingMutation2022

3.  \[DONE\] grabmayerMaximalSharingLam

### \[DONE\] \[#A\] L'analyse de dépendances entre modules — pour la compilation séparée — rencontre-t-elle le problème des noms introduits au niveau supérieur (question 21) ?

    ARC: E | QUID: QE-10 | REF

Elle le rencontre, ce problème a un nom — la GÉNÉRATIVITÉ — et la source établit qu'il se traite sans estampilles. Le problème est ancien et bien posé : l'équivalence par les noms contre l'équivalence par la structure, compliquée par la générativité, où une instance de module engendre des types nouveaux, et par les contraintes de partage, où deux types sont contraints à venir de la même instance. Un compte rendu purement syntaxique et typé suffit, et il est démontré équivalent à la description par estampilles. Reste ouvert ce que le document a de particulier : ses noms sont engendrés par un langage de macros TYPÉ, ce que la source n'a pas et ne traite pas.

#### Suivi d'avancement

1.  \[DONE\] leroySyntacticTheoryType1996

### \[DONE\] \[#A\] La sémantique des jeux donne des modèles pleinement abstraits pour les références d'ordre supérieur et le contrôle. K7PL, qui a des capacités et pas de continuations, y gagnerait-il un modèle ?

    ARC: E | QUID: QE-11 | REF

Oui, et le fonds porte le modèle de la combinaison exacte du document. La géométrie de l'interaction multi-jetons interprète ensemble l'ordre supérieur, la concurrence et la mémoire partagée, par une machine de réseaux de Petri colorés dont l'adéquation est démontrée, et établit une COÏNCIDENCE entre la description causale engendrée opérationnellement et celle que l'interprétation dénotationnelle donne. Une seconde source traite le cas des capabilités, et elle touche un manque que le document nomme lui-même : la vérification dynamique de contrats aux frontières entre code vérifié et code non fiable s'obtient par des capabilités LINÉAIRES, et le résultat est la compilation pleinement abstraite. C'est le troisième des trois franchissements de la frontière de confiance, celui de la passerelle vers le code étranger, et la non-duplicabilité y est portée par le matériel plutôt que par le typage — différence qui compte pour K7PL, dont la garantie est statique et ne vaut donc que du code qu'il compile.

#### Suivi d'avancement

1.  \[DONE\] castellanGeometryCausalityMultitoken2023

2.  \[DONE\] vanstrydonckLinearCapabilitiesFully2019

3.  \[DONE\] RITTER-PITTS

### \[DONE\] \[#A\] La sémantique des jeux « en couches et par objets » — dont le critère de correction d'une couche vient — s'applique-t-elle aux trois couches de K7PL, ou seulement à l'acteur ?

    ARC: E | QUID: QE-12 | REF

Elle s'y applique, et elle donne au critère de sédimentation sa forme publiée et sa LOI DE COMPOSITION, que le document n'a pas. Une interface de couche s'y modélise comme un type d'objet — une signature de couche — plus une stratégie d'objet ; une implantation est une application régulière au sens de Reddy, de la signature inférieure vers la supérieure ; et elle est CERTIFIÉE quand sa composition avec la stratégie de la couche inférieure implémente celle de la couche supérieure. Le problème que la source résout est celui que l'arène pose : la compositionnalité y était restreinte par le défaut d'ENCAPSULATION DE L'ÉTAT, et la sortie est de définir la sémantique sur les seuls comportements observables. Enfin, les couches certifiées y synthétisent la sémantique des jeux, le calcul de raffinement et les effets algébriques — les trois que le document a sans les avoir présentés comme une synthèse.

#### Suivi d'avancement

1.  \[DONE\] oliveiravaleLayeredObjectbasedGame2022

### \[DONE\] \[#A\] Les types de session et la sémantique des jeux sont « deux faces d'une même pièce ». Cette identification apporte-t-elle quelque chose aux protocoles du chapitre 3 ?

    ARC: E | QUID: QE-13 | REF

Elle apporte, mais pas ce qu'on attendait : l'identification était connue, et l'apport est de combler un ÉCART SÉMANTIQUE entre la SYNCHRONIE du calcul de sessions et l'ASYNCHRONIE de la sémantique des jeux, par un modèle fondé sur les structures d'événements. Or c'est exactement la situation du document : le chapitre 3 spécifie des protocoles par alternance stricte d'émission et de réception, donc synchrones, et le chapitre 4 les réalise sur des anneaux à producteur et consommateur uniques, donc asynchrones. Le franchissement se fait sans être nommé. La source donne l'encodage qui le justifie — les stratégies synchrones s'encodent fidèlement dans les asynchrones par PROTOCOLES D'APPEL ET DE RETOUR, ce qui induit automatiquement un encodage au niveau des processus. Le modèle est pleinement abstrait pour la congruence barbelée et vraiment concurrent.

#### Suivi d'avancement

1.  \[DONE\] castellanTwoSidesSame2019

### \[DONE\] \[#A\] La géométrie de l'interaction multi-jetons interprète un langage concurrent d'ordre supérieur à état partagé. Est-ce le modèle du chapitre 4 ?

    ARC: E | QUID: QE-14 | REF

Oui, c'est le modèle du chapitre 4, et l'appariement est étroit plutôt qu'analogique : ordre supérieur, concurrence et mémoire partagée sont les trois traits que le chapitre combine et les trois que la source interprète. Ce qu'elle apporte au-delà du modèle est une machine — des réseaux de Petri colorés — dont l'adéquation est démontrée, et la coïncidence entre la description causale qu'elle engendre opérationnellement et celle que l'interprétation en jeux concurrents donne dénotationnellement.

#### Suivi d'avancement

1.  \[DONE\] castellanGeometryCausalityMultitoken2023

### \[DONE\] \[#C\] La théorie des jeux au sens économique — décision sous incertitude — a-t-elle un usage pour K7PL ?

    ARC: E | QUID: QE-15 | REF

Non, et il vaut d'écrire pourquoi plutôt que de laisser la question ouverte. La théorie des jeux au sens économique modélise la décision d'agents aux préférences opposées sous incertitude ; la sémantique des jeux au sens de cet arc modélise un programme comme stratégie face à son environnement, sans préférence ni gain. L'homonymie est complète et la parenté nulle. Aucune des quatorze autres questions ne dépend de celle-ci, et le fonds n'a rien à en dire. Close par écartement motivé.

#### Suivi d'avancement

1.  \[DONE\] écartement motivé, sans référence

### \[DONE\] \[#A\] Le choix de règle d'un motif de jonction est NON DÉTERMINISTE, et c'est une propriété intrinsèque du métalangage. Or c1 énumère les sources de non-déterminisme en disant qu'elles ne sont « jamais des propriétés intrinsèques du langage ». LAQUELLE DES DEUX ISSUES : motifs déterministes, ou choix de règle journalisé ?

    ARC: F | QUID: QF-1 | REF

Le non-déterminisme est réel, il est intrinsèque, et la source primaire l'énonce en toutes lettres : les règles de réaction d'une même définition de jonction définissent des comportements en concurrence, avec un CHOIX NON DÉTERMINISTE du processus gardé à déclencher lorsque plusieurs motifs sont satisfaits. Le chapitre 1 énumère les sources de non-déterminisme et n'y met pas celle-ci, alors qu'elle est la seule qui vienne du métalangage lui-même et non de l'environnement. Mais la tension se dissout au lieu de s'arbitrer, et la question suivante dit comment.

#### Suivi d'avancement

1.  \[DONE\] maAlgebraicPatternMatching2008

2.  \[DONE\] fournetReflexiveCHAMJoincalculus1996

### \[DONE\] \[#A\] Si l'on choisit le déterminisme, quelle politique de sélection ?

    ARC: F | QUID: QF-2 | REF

Aucune, et c'est la bonne réponse. Deux politiques existent et la source les a employées toutes les deux. La POLITIQUE DU PREMIER MOTIF, celle du filtrage à la ML, rendrait l'ordre d'écriture des clauses sémantiquement significatif — pour une réaction concurrente, cela revient à faire décider par la mise en page quel couple de messages est consommé, ce qu'aucun postulat du document ne tolérerait. La seconde est de PARTITIONNER les valeurs filtrées en ensembles disjoints, ce qui rend le choix forcé et le déterminisme gratuit. Or K7PL vérifie déjà STATIQUEMENT l'exhaustivité de ses motifs : exiger en plus la DISJONCTION donne une partition, donc le déterminisme, sans politique de sélection ni ordre significatif. L'exemple du chapitre 4 est d'ailleurs déjà une partition, ses deux clauses portant sur des canaux distincts. Ce qui manque n'est pas un mécanisme mais la règle qui l'exige.

#### Suivi d'avancement

1.  \[DONE\] maAlgebraicPatternMatching2008

### \[DONE\] \[#A\] Si l'on choisit la journalisation, quel est le surcoût du journal, et P3 le tolère-t-il ?

    ARC: F | QUID: QF-3 | REF

La question tombe avec la précédente : si la disjonction des motifs est exigée, il n'y a pas de choix à journaliser, donc pas de surcoût à évaluer. Le journal du chapitre 4 conserve ce qu'il conservait déjà — les valeurs tirées d'une source non déterministe, horloge et générateur, transitant par un contexte implicite unique — et rien de plus. Le postulat d'autonomie physique n'a donc pas à tolérer un coût nouveau, ce qui est le meilleur des cas et non un arbitrage. À rouvrir seulement si la disjonction était refusée.

#### Suivi d'avancement

1.  \[DONE\] conséquence des questions voisines

### \[DONE\] \[#A\] Le rejeu LOGIQUE que P4 garantit survit-il à un métalangage non déterministe, ou faut-il descendre au rejeu bit à bit ?

    ARC: F | QUID: QF-4 | REF

Il survit, et sous la même condition que les trois précédentes. Le théorème de déterminisme du rejeu repose sur la pureté des gestionnaires et sur la journalisation des capacités non déterministes ; il ne dit rien du choix entre règles de réaction, qui n'est pas une capacité mais une propriété du métalangage. Sous disjonction des motifs, ce choix n'existe plus et le théorème couvre tout ce qu'il doit couvrir, au niveau LOGIQUE. Sans elle, le rejeu logique ne suffit pas et il faudrait journaliser la règle élue, ce qui est le rejeu bit à bit sous un autre nom. La disjonction est donc ce qui sépare les deux régimes, et c'est une seule décision qui règle QF-1 à QF-4.

#### Suivi d'avancement

1.  \[DONE\] fournetReflexiveCHAMJoincalculus1996

2.  \[DONE\] maAlgebraicPatternMatching2008

### \[DONE\] \[#A\] Le métalangage est-il une INSTANCE des psi-calculi ?

    ARC: F | QUID: QF-5 | REF

Plausiblement oui, et la question devient vérifiable plutôt qu'ouverte. Le cadre étend les psi-calculi par des MOTIFS abstraits et un filtrage, et ajoute des SORTES au langage des termes de données ; il représente directement plusieurs calculs de processus existants, et les systèmes de transitions obtenus sont ISOMORPHES aux originaux à bisimulation forte près — garantie plus forte qu'un encodage, rien n'étant perdu ni ajouté par le passage au cadre. Le métalangage de K7PL a des motifs de jonction, qui sont des motifs, et des sortes. Ce qui reste est d'exhiber l'instance.

#### Suivi d'avancement

1.  \[DONE\] borgstromSortedSemanticFramework2016

### \[DONE\] \[#A\] Les SORTES de `sortes.org` satisfont-elles les critères suffisants de préservation du sujet que Borgström donne ?

    ARC: F | QUID: QF-6 | REF

Les critères existent et ils sont énumérables — une FONCTION DE SORTE équivariante sur les noms, les termes et les motifs ; QUATRE PRÉDICATS DE COMPATIBILITÉ, un par rôle, pour émettre, recevoir, être substitué par, et être lié par restriction de nom ; et un PRÉORDRE DE SOUS-SORTE qui absorbe les changements de sorte sous substitution. Sur les noms, la sorte est exigée unique, comme le type d'un terme dans un lambda-calcul à la Church. Mais il n'y a rien à vérifier, et c'est le vrai renseignement : l'annexe G écrit elle-même que le système de sortes du métalangage est l'objet qu'une tâche DOIT CONSTRUIRE, et que tant qu'il n'est pas posé la relation logique n'est définie que sur deux strates. Les critères ne sont donc pas une vérification à conduire mais une SPÉCIFICATION complète à laquelle construire. Et l'objet est PORTANT : la même page porte l'énoncé que la non-interférence graduée n'est démontrée que pour le fragment SANS COMMUNICATION, faute précisément de ce système.

#### Suivi d'avancement

1.  \[DONE\] borgstromSortedSemanticFramework2016

### \[DONE\] \[#A\] Le filtrage généralisé DÉCOUPLÉ de la substitution évite-t-il les encodages que Ma et Maranget doivent construire ?

    ARC: F | QUID: QF-7 | REF

La question se renverse, et le renversement est le renseignement. Elle suppose qu'un filtrage découplé de la substitution éviterait les encodages de la source ; les auteurs disent l'inverse de ce que cette supposition attend. Leur extension est LISSE précisément parce que le filtrage de jonction et le filtrage de valeurs reposent tous deux sur la substitution classique, la semi-unification. Découpler ne dispenserait donc pas de l'encodage : cela retirerait la raison pour laquelle l'extension était lisse. Et l'encodage qu'ils construisent — transformer les définitions étendues en définitions ordinaires plus filtrage ML — sert à l'EFFICACITÉ de la mise en œuvre, en déléguant le travail au compilateur de filtrage ML, non à la définition du calcul.

#### Suivi d'avancement

1.  \[DONE\] maAlgebraicPatternMatching2008

### \[DONE\] \[#A\] La machine chimique réflexive et le join-calcul : l'équivalence que le document EMPRUNTE est-elle exactement celle dont il a besoin ?

    ARC: F | QUID: QF-8 | REF

Elle l'est, mais ce sont DEUX résultats et le document les cite comme un. Le premier est l'équi-expressivité du join-calcul et du pi-calcul, à congruence barbelée faible près, obtenue en exhibant des encodages pleinement abstraits dans les deux directions ; c'est lui qui autorise à dire que le document emprunte un calcul et n'en propose pas un. Le second est la théorie équationnelle du join-calcul lui-même, dont l'énoncé de fidélité du chapitre 6 a besoin. Une nuance de statut est à ne pas perdre : les auteurs écrivent qu'on peut S'ATTENDRE à ce que l'essentiel de la métathéorie du pi-calcul se transporte au join-calcul. C'est une attente, non un théorème, et tout appui de K7PL sur un résultat du pi-calcul ainsi transporté est à conduire ou à retirer.

#### Suivi d'avancement

1.  \[DONE\] fournetReflexiveCHAMJoincalculus1996

### \[DONE\] \[#A\] La traduction de Cervesato — les constructeurs du join-calcul comme formes dérivées sur `⊗`, `1`, `∃`, `∀`, `!`, `⊸` — est-elle celle du chapitre 4 ?

    ARC: F | QUID: QF-9 | REF

C'est bien celle dont le document a besoin, et elle porte en outre une exception dont la correction est gratuite. La source fonde la réécriture de multi-ensembles sur les règles gauches de la logique linéaire, ce qui donne à la boîte aux lettres de l'acteur la sémantique que le chapitre 4 suppose sans la nommer, et elle ABANDONNE LA DISTINCTION entre éléments et règles de réécriture — même trait que la réflexion de la machine chimique, où messages et motifs sont de même nature. Les coupures y sont admissibles. L'EXCEPTION vise la réplication : la loi qui identifie l'exponentielle à sa décomposition en une copie et l'exponentielle n'est PAS dérivable comme équivalence, seul un sens l'étant ; l'auteur en conclut que l'encodage, ou la logique linéaire elle-même, ne capture pas fidèlement l'exécution du pi-calcul traditionnelle. La correction ne coûte rien : ne garder que la MOITIÉ de la loi, le dépliage à sens unique, ce qui correspond exactement à la règle gauche de l'exponentielle et transforme la propriété en CORRESPONDANCE EXACTE. Ce qu'on abandonne est d'implantation difficile de toute façon ; ce qu'on gagne est l'exactitude dont l'énoncé de fidélité du chapitre 6 a besoin.

#### Suivi d'avancement

1.  \[DONE\] cervesatoLogicalMeetingPoint2004

2.  \[DONE\] fournetReflexiveCHAMJoincalculus1996

### \[DONE\] \[#A\] Les cinq formes de protocole se dérivent de `⊸`. Leurs OPÉRATIONS se dérivent-elles de même, comme la table de van den Heuvel le suggère ?

    ARC: F | QUID: QF-10 | REF

Elles s'en dérivent, et la lecture rapporte bien plus que la table. Les auteurs construisent un système englobant les interprétations classique et intuitionniste de la logique linéaire et caractérisent les fragments qui coïncident avec chacune. Leur résultat central pour K7PL n'est pas la dérivation des opérations mais la ligne de partage : la différence entre les deux présentations tient à l'imposition de la LOCALITÉ DES NOMS PARTAGÉS, que l'intuitionniste impose et que la classique n'impose pas ; la classique est strictement plus expressive, étant plus permissive ; et l'intuitionniste interdit aussi les envois vides sur des canaux reçus, les deux contraintes découlant de l'exigence qu'un jugement intuitionniste porte exactement un canal à droite. Cette lecture met au jour une incohérence interne du document, portée au programme d'ajustement.

#### Suivi d'avancement

1.  \[DONE\] heuvelComparingSessionType2024

### \[DONE\] \[#A\] Le sous-typage de session et la compatibilité multipartite : K7PL en a-t-il besoin, ou ses sessions sont-elles binaires par construction ?

    ARC: F | QUID: QF-11 | REF

Ses sessions sont binaires par construction, et le document a raison de le dire ; mais il en a besoin le jour où il lève l'acyclicité, et la condition de remplacement a une forme exacte que la source donne. Le sous-typage y est plus souple que le standard, un fil unique pouvant être remplacé par plusieurs fils parallèles qui remplissent son rôle, et quatre résultats sont établis par élimination des coupures : le système est algorithmique, les processus multipartites compatibles et SANS COURSE sont sans interblocage, le sous-typage est correct pour la substitution, et les types globaux sont OPTIONNELS. Le document écrit que ce qui remplacerait l'acyclicité est une condition vérifiable statiquement et nomme la liberté de course ; l'énoncé exact est ici.

#### Suivi d'avancement

1.  \[DONE\] horneSessionSubtypingMultiparty2020

2.  \[DONE\] toninhoInterconnectabilitySessionBasedLogical2018

### \[DONE\] \[#A\] La terminaison ÉQUITABLE des sessions asynchrones a-t-elle un rapport avec la productivité de la couche 2 ?

    ARC: F | QUID: QF-12 | REF

Le rapport n'est pas celui que la question attendait, et il est plus important. Sous modèle mémoire faible, les notions usuelles d'équité entre FILS SONT INSUFFISANTES pour la vivacité, et il faut une propriété de plus, l'ÉQUITÉ MÉMOIRE : le système mémoire doit exécuter équitablement ses propres étapes de propagation. Le modèle acquisition-libération est l'un des quatre pour lesquels la condition déclarative est établie équivalente à la notion opérationnelle. Or le chapitre 4 pose un invariant de vivacité pour la supervision, et une notification par compteur SONDÉ, sous acquisition-libération et avec des barrières fixées à la publication et à la consommation et NULLE PART AILLEURS. Les auteurs rapportent que plusieurs implantations d'exclusion mutuelle SE BLOQUENT si trop peu de barrières sont employées. L'invariant du document est donc conditionnel à une hypothèse qu'il ne pose pas.

#### Suivi d'avancement

1.  \[DONE\] lahavMakingWeakMemory2021

### \[DONE\] \[#A\] Les session coalgebras donnent-elles le pont entre le chapitre 3 (types) et le chapitre 4 (automates) que QA-15 réclame ?

    ARC: F | QUID: QF-13 | REF

Oui, et l'arc E l'a déjà établi. Les types de session SONT des états de coalgèbres, dans une description sans syntaxe de la concurrence par sessions, et la dualité des protocoles — que le chapitre 3 pose comme définition — s'y retrouve comme CONSÉQUENCE. Le pont que les chapitres 3 et 4 affirment sans le construire existe donc littéralement. Une seconde source comble l'écart voisin, entre la synchronie des protocoles du chapitre 3 et l'asynchronie de leur réalisation sur anneaux au chapitre 4, par un encodage en protocoles d'appel et de retour. Les deux sont portées au programme d'ajustement.

#### Suivi d'avancement

1.  \[DONE\] keizerSessionCoalgebrasCoalgebraic2021

2.  \[DONE\] castellanTwoSidesSame2019

### \[DONE\] \[#A\] La récursion structurelle POUR les types de session — *Talking Bananas* — donne-t-elle les schémas de la couche 2 ?

    ARC: F | QUID: QF-14 | REF

Oui, et elle demande une correction du métalangage que la doctrine du document réclamait déjà. Les auteurs ajoutent à un lambda-calcul linéaire concurrent les types récursifs et les CATAMORPHISMES, suivant la sémantique des algèbres initiales, et les types de session récursifs en NAISSENT au lieu d'être posés — la récursion étant caractérisée par des plis plutôt que par un opérateur de point fixe ARBITRAIRE. Or la grammaire du métalangage porte un point fixe arbitraire, seule exception à la règle que le chapitre 2 applique partout ailleurs. Trois gains suivent. Cette approche RÉSOUT des problèmes de longue date dans le traitement de la DUALITÉ pour les types de session récursifs, problème que le document a sans le mentionner. La terminaison en présence de types récursifs positifs s'obtient par traduction en style par continuations vers un lambda-calcul non concurrent, donc par appel aux résultats de normalisation séquentiels. Et l'extension préserve la connexion entre réduction et ÉLIMINATION DES COUPURES, qui est la forme de l'énoncé de fidélité du chapitre 6.

#### Suivi d'avancement

1.  \[DONE\] lindleyTalkingBananasStructural2016

### \[DONE\] \[#A\] L'emprunt appliqué aux sessions : une session peut-elle être empruntée sans être consommée, et K7PL le veut-il ?

    ARC: F | QUID: QF-15 | REF

Oui, elle le peut, et le prix est nommé — c'est le TYPAGE LINÉAIRE ORDONNÉ, avec une opération explicite de partage de la propriété d'un canal. La sémantique est établie par une traduction préservant les types vers un calcul fonctionnel sans interblocage, d'où sûreté du typage et absence d'interblocage ; une version algorithmique donne la décidabilité de la vérification, avec une traduction mécanisée et vérifiée. Et le prix est le MÊME que celui de deux autres questions du projet : l'arc C a établi que la caractérisation d'une classe d'automates par la discipline de type exige la non-commutativité, et le sous-typage multipartite qui lèverait l'acyclicité est non commutatif lui aussi. Trois besoins indépendants, un seul prix, traité chaque fois comme une objection locale.

#### Suivi d'avancement

1.  \[DONE\] saffrichBorrowingSessionTypes2025

### \[DONE\] \[#A\] Le modèle mémoire acquisition-libération et sa portée d'UNE MACHINE : le fonds donne-t-il la borne exacte de ce qui est garanti ?

    ARC: F | QUID: QF-16 | REF

Il la donne, et le document l'a déjà correctement posée : le modèle acquisition-libération gouverne la mémoire partagée d'UNE MACHINE, le cœur n'étant pas une portée distincte puisque deux fibrilles d'un même cœur ne s'exécutent pas simultanément, et l'inter-machine relevant du journal. Ce que le fonds ajoute est ce que cette portée ne couvre pas. La borne de sûreté est complétée par une borne de VIVACITÉ, qui demande l'équité mémoire en plus de l'équité entre fils. Et la vérification d'une file bornée concurrente sous modèle faible existe au fonds, avec son dispositif — les vues formant un treillis, l'antériorité s'exprimant comme un transfert de vue.

#### Suivi d'avancement

1.  \[DONE\] lahavMakingWeakMemory2021

2.  \[DONE\] mevelFormalVerificationConcurrent2021

### \[DONE\] \[#A\] La conformité de l'abaissement au modèle mémoire déclaré est un ENGAGEMENT que « rien » ne tient. Que faudrait-il pour le tenir ?

    ARC: F | QUID: QF-17 | REF

Il faudrait une LOGIQUE PARAMÉTRÉE PAR LE MODÈLE MÉMOIRE, et non une vérification a posteriori du code engendré. La source en donne une, dont les assertions portent des vues munies d'une structure de treillis et où une relation d'antériorité s'exprime comme un transfert de vue ; l'anneau y est prouvé une fois, mécaniquement, sous le modèle faible. C'est la forme que prendrait l'engagement. La voie empirique existe aussi et elle est complémentaire, mais elle ne remplace pas la preuve : une méta-étude des travaux antérieurs révèle des résultats de faible reproductibilité, si bien qu'un test non réglé ne donne pas une confiance faible mais une confiance illusoire.

#### Suivi d'avancement

1.  \[DONE\] mevelFormalVerificationConcurrent2021

2.  \[DONE\] kirkhamFoundationsEmpiricalMemory2020

### \[DONE\] \[#A\] L'isolation par types plutôt que par unité de gestion mémoire est un engagement appuyé sur « une réalisation déployée, non une preuve ». Le fonds a-t-il la preuve ?

    ARC: F | QUID: QF-18 | REF

L'engagement n'est pas faux : il est vrai d'un cadre que la cible ne satisfait pas. Les travaux sur la sûreté robuste portent sur des langages à modèle mémoire ABSTRAIT, où l'on cache un emplacement en ne le partageant simplement pas, et où le bac à sable est inutile. Or K7PL vise un unikernel, donc un modèle mémoire CONCRET, où le code non fiable peut DEVINER OU CALCULER les adresses du code fiable et les déréférencer — ce qui est, écrivent les auteurs, ce qui justifie le bac à sable. L'alternative est donc explicite : ou bien restreindre l'affirmation d'isolation au code compilé et au modèle abstrait, ou bien adjoindre un mécanisme de confinement au niveau concret, dont la source recense les familles. Ce que le document ne peut pas faire est de conserver l'affirmation sans dire de quel modèle mémoire elle parle.

#### Suivi d'avancement

1.  \[DONE\] sammlerHighlevelBenefitsLowlevel2020

### \[DONE\] \[#A\] Les anneaux verrou-libres et le motif Disruptor : leur correction est-elle établie dans le fonds, ou empruntée à une note d'ingénierie ?

    ARC: F | QUID: QF-19 | REF

Elle est établie au fonds, et deux fois plutôt qu'une. La file bornée concurrente est vérifiée sous modèle mémoire faible, mécaniquement, dans une logique de séparation dédiée : ce n'est donc pas un objet dont la correction serait empruntée à une note d'ingénierie, et il faut citer la preuve là où le document cite la note. Et sur la propriété que le document se refuse à revendiquer — la localité au sens de Herlihy et Wing — la source qu'il cite pour l'avertissement DÉMONTRE le remède : l'enveloppe de Karoubi donne une formulation nouvelle de la linéarisabilité, qui ne repose ni sur l'atomicité ni directement sur l'antériorité, et d'où les auteurs tirent des preuves algébriques simples de la propriété de localité et d'un analogue du raffinement observationnel.

#### Suivi d'avancement

1.  \[DONE\] mevelFormalVerificationConcurrent2021

2.  \[DONE\] oliveiravaleCompositionalTheoryLinearizability2023

### \[DONE\] \[#A\] Le test de cohérence mémoire empirique donne-t-il un protocole pour G-06 ?

    ARC: F | QUID: QF-20 | REF

Oui, et il porte un avertissement plus utile que le protocole. La méthodologie proposée règle les routines de sollicitation et analyse de grands nombres d'observations, ce qui donne des résultats de plus haute confiance plus vite ; elle est validée sur trois processeurs graphiques de trois fabricants. L'avertissement est que les auteurs justifient ce besoin par une méta-étude des travaux antérieurs, laquelle révèle des résultats de FAIBLE REPRODUCTIBILITÉ et un emploi inefficace du temps de test. Les observations qui comptent sont extrêmement rares et de nature probabiliste : sans protocole réglé, l'absence d'observation ne distingue pas l'impossibilité de l'improbabilité, et le point de contrôle donne alors une confiance illusoire plutôt que faible.

#### Suivi d'avancement

1.  \[DONE\] kirkhamFoundationsEmpiricalMemory2020

### \[DONE\] \[#B\] La coupe LISIBILITÉ / LÉGIBILITÉ tient-elle dans la littérature évaluée par les pairs, ou est-ce une distinction de praticiens ?

    ARC: G | QUID: QG-1 | REF

Elle tient, elle est dans la littérature évaluée par les pairs, et les deux définitions y sont écrites. La LISIBILITÉ est ce qui rend un programme plus ou moins facile à lire et comprendre par un développeur ; la LÉGIBILITÉ est ce qui influence la facilité d'IDENTIFIER LES ÉLÉMENTS d'un programme. Ce n'est donc pas une distinction de praticien mais une distinction posée dans une revue systématique d'études sur sujets humains, dont l'apport propre est que personne n'avait examiné comment les études les évaluent.

#### Suivi d'avancement

1.  \[DONE\] oliveiraEvaluatingCodeReadability2020

### \[DONE\] \[#B\] L'anti-superlativisme — « une notation n'est lisible que POUR UNE TÂCHE » — est-il une conclusion établie ou une position ?

    ARC: G | QUID: QG-2 | REF

C'est une position, mais elle reçoit un appui MÉTHODOLOGIQUE solide plutôt qu'une démonstration. Les auteurs relèvent que les études évaluent la lisibilité au moyen de tâches de compréhension et de variables de réponse DIFFÉRENTES, et que c'est en analysant ces tâches et ces variables qu'on identifie les limites des évaluations antérieures. Si les tâches diffèrent et que les résultats en dépendent, un jugement de lisibilité sans tâche n'a pas de référent : c'est la raison pour laquelle la position est difficile à réfuter, non la preuve qu'elle est vraie.

#### Suivi d'avancement

1.  \[DONE\] oliveiraEvaluatingCodeReadability2020

2.  \[DONE\] greenCognitiveDimensionsAchievements2006

### \[DONE\] \[#B\] La divergence PRÉFÉRENCE / PERFORMANCE mesurée par Miara se retrouve-t-elle ailleurs, et sur quels traits ?

    ARC: G | QUID: QG-3 | REF

Elle se retrouve, et sur un trait précis : les tableaux de notation séparent PROGRAMMEURS et NON-PROGRAMMEURS, et les deux colonnes ne coïncident pas. Pour les boucles, elles se renversent — for est dernier chez les non-programmeurs à deux virgule treize et ne figure plus du tout en queue chez les programmeurs, dont la queue est duplicate, foreach et echo. Pour la conditionnelle et l'affectation en revanche, les deux colonnes s'accordent. La divergence n'est donc pas générale : elle est portée par des traits particuliers, et la boucle est le premier.

#### Suivi d'avancement

1.  \[DONE\] stefikEmpiricalInvestigationProgramming2013

### \[DONE\] \[#B\] L'ancienneté déplace le jugement d'un demi-point par an. Cette régression a-t-elle été répliquée ?

    ARC: G | QUID: QG-4 | REF

La pente existe, elle est dans cette source même, et la retrouver la RÉDUIT plutôt qu'elle ne la confirme. LA RÉGRESSION, TEXTUELLEMENT. y = 5,37838 + 0,56818 x, où x est le nombre d'années d'expérience DÉCLARÉE en C++ et y la note d'intuitivité portée sur une question C++, échelle de Likert à onze points. Test omnibus F(1, 1492) = 143,1, p \< 0,001. Le demi-point par an du projet est exact à deux centièmes près. TROIS BORNES QUE LE CHIFFRE SEUL NE PORTE PAS, ET CHACUNE COMPTE. Le coefficient de détermination multiple vaut 0,08754 et l'ajusté 0,08693 : l'ancienneté explique moins d'un DIXIÈME de la variance des notes, et les neuf dixièmes restants sont ailleurs. Un seul langage est concerné, et les auteurs l'écrivent — leur échantillon n'avait généralement d'expérience qu'en C++, et ils n'ont donc pas comparé ce résultat aux autres langages. L'ancienneté est DÉCLARÉE par le sujet et non mesurée. LA RÉPLICATION N'EXISTE PAS AU FONDS, et le fonds porte de quoi le dire plutôt que de le supposer : la revue systématique de la lisibilité, cinquante-quatre études primaires dépouillées, n'en recense aucune. CE QUE LE DOCUMENT DOIT EN FAIRE. La phrase juste n'est pas « l'ancienneté déplace le jugement d'un demi-point par an », qui énonce une loi, mais « sur un échantillon de programmeurs C++, la note d'intuitivité du C++ monte d'environ un demi-point par année d'expérience déclarée, ce qui explique moins d'un dixième de la variance ». La seconde est plus longue, et c'est le prix de son exactitude.

#### Suivi d'avancement

1.  \[DONE\] stefikEmpiricalInvestigationProgramming2013

### \[DONE\] \[#B\] La devinabilité d'un mot-clé — `for` 2,13 contre `loop` 6,30 — a-t-elle des mesures concurrentes ?

    ARC: G | QUID: QG-5 | REF

Elles existent, elles sont dans cette source, et les deux valeurs du projet sont exactes : colonne des non-programmeurs, for à deux virgule treize en queue de tableau et loop à six virgule trente en tête. Le tableau complet en dit davantage. En tête chez les non-programmeurs, repeat à six virgule quatre-vingt-huit et again à six virgule quarante-trois ; en queue, while à deux virgule trente-sept, presque aussi mal noté que for. Et la colonne des programmeurs renverse tout : loop à sept virgule quatre-vingt-huit, repeat à sept virgule quarante-neuf, et for absent de la queue. La pénalité de for est un effet de novice que l'expérience efface.

#### Suivi d'avancement

1.  \[DONE\] stefikEmpiricalInvestigationProgramming2013

### \[DONE\] \[#B\] Le coût de l'aliasing mesuré par Coblenz — 4 h contre 12 h — a-t-il été reproduit ?

    ARC: G | QUID: QG-6 | REF

Le chiffre du projet est à corriger, et le résultat réel est plus important que lui. Les quatre heures ne sont pas une mesure mais le BUDGET de session accordé à chaque participant. Le résultat est que la condition à types avancés — propriété, actifs, typestate — a pris PLUS de temps, avec une VARIANCE ÉLEVÉE, et que quatre participants sur dix n'avaient plus assez de leurs quatre heures pour être satisfaits de leur solution, contre un seul dans la condition témoin ; un a abandonné après une heure quinze. C'est la mesure du fonds la plus proche du pari de K7PL, et elle ne le soutient pas. Sa portée est bornée — dix participants par condition, quatorze analysés, tutoriel bref, et le langage évalué n'est pas K7PL — mais le fonds ne porte aucune mesure favorable en regard.

#### Suivi d'avancement

1.  \[DONE\] coblenzCanAdvancedType2020

### \[DONE\] \[#B\] Les dimensions cognitives sont un cadre de DISCUSSION, non de conception ni de validation. Le fonds confirme-t-il cette limite, et donne-t-il un cadre qui, lui, conçoive ?

    ARC: G | QUID: QG-7 | REF

Il le confirme, et par la plume de l'auteur du cadre. Green écrit que l'intention était de fournir des OUTILS DE DISCUSSION, pour élever le niveau du discours entre des choisisseurs et des utilisateurs qui sont spécialistes d'un domaine sans être informaticiens ni psychologues, en donnant des termes formant une courte liste de contrôle ; et il résume que l'intention d'origine était d'améliorer la pratique de conception en rendant plus facile de PARLER de l'utilisabilité. Le cadre est donc un instrument de conversation par la volonté de son auteur, et l'employer comme cadre de conception ou de validation est un emploi qu'il n'a jamais revendiqué.

#### Suivi d'avancement

1.  \[DONE\] greenCognitiveDimensionsAchievements2006

2.  \[DONE\] petreCognitiveDimensionsNotation2006

### \[DONE\] \[#B\] Que sait-on de la longueur d'un identifiant et de la compréhension ?

    ARC: G | QUID: QG-8 | REF

LA DIRECTION EST CONNUE ET ELLE EST L'INVERSE DE L'INTUITION ; LA GRANDEUR NE L'EST PAS. CE QUE LE FONDS PERMET D'ÉTABLIR. La revue systématique de la lisibilité recense les études primaires sur la longueur des identifiants et en donne les références exactes. Deux portent directement, et l'une des deux énonce son résultat dans son titre : les identifiants COURTS prennent PLUS de temps à comprendre. C'est un travail évalué par les pairs, publié deux fois — en conférence puis en revue. CE QUE LE FONDS NE PERMET PAS. Aucune des études primaires n'est au fonds. Rapporter une direction depuis un titre est licite ; rapporter une taille d'effet depuis un titre ne l'est pas, et cette question demande la seconde. Maintenue en cours pour cette raison, et pour elle seule. CE QUE LA REVUE APPREND SUR LA QUALITÉ DE LA PREUVE, ET QUI VAUT POUR LES QUATRE QUESTIONS DE NOMMAGE. Sur les cinquante-quatre études, l'opinion personnelle sert de variable de réponse dans trente, et dans neuf elle est la SEULE. Trente-sept pour cent n'exercent qu'une seule compétence cognitive. Cinq pour cent seulement observent un signe physique. La base est donc dominée par le déclaratif. CE QUE LA DIRECTION CHANGE POUR L'ARC, ET C'EST UNE CONVERGENCE. Le temps 4 place la BRIÈVETÉ en dernier critère et lui fait ne rien trancher. La littérature empirique va dans le même sens et pour une raison mesurée, non par ordre de méthode : raccourcir un nom ne le rend pas plus rapide à comprendre. TRANCHÉE le 3 septembre. LA QUESTION EST CLOSE POUR CE QUE K7PL EN A BESOIN, ET LE RÉSIDU N'EST PLUS UNE QUESTION MAIS UNE LACUNE D'ACCÈS. CE QUI EST ÉTABLI ET NE BOUGERA PAS. La direction est connue, elle est l'inverse de l'intuition, et elle vient d'un travail évalué publié deux fois — en conférence puis en revue. Raccourcir un nom ne le rend pas plus rapide à comprendre. CE QUI RESTE, ET POURQUOI CE N'EST PLUS UNE QUESTION DE L'ARC. La taille de l'effet demande de lire trois pièces qui ne sont pas au fonds. Or QG-11 a établi qu'AUCUNE des onze n'a pour objet les noms de FONCTIONS, qui sont ce que ce langage choisit ; elles portent sur les identifiants d'utilisateur, que le langage ne gouverne pas. Lire ces trois pièces compléterait un dossier, non un verdict. ET LE CRITÈRE QUI EN DÉPENDAIT A DÉJÀ ÉTÉ RÉTROGRADÉ. Le temps 4 a fait du mnémonique une CONVERGENCE D'USAGE et non une mesure ; la brièveté n'a rien tranché au temps 5. Une mesure de taille d'effet ne changerait donc aucun arbitrage rendu. STATUT DU RÉSIDU : livrable bibliographique, dix DOI vérifiés, à bib/A-SOURCER-nommage.md. Il ne bloque aucun théorème, aucun engagement, aucune décision.

#### Suivi d'avancement

1.  \[DONE\] oliveiraEvaluatingCodeReadability2020

2.  \[DONE\] trois pièces à verser — voir bib/A-SOURCER-nommage.md

### \[DONE\] \[#B\] Que sait-on du style de casse, et l'effet est-il de taille utile ?

    ARC: G | QUID: QG-9 | REF

TROIS ÉTUDES EXISTENT, AUCUNE N'EST AU FONDS, ET LA QUESTION SE POSE MAL POUR K7PL. LES TROIS PIÈCES, IDENTIFIÉES PAR LA REVUE SYSTÉMATIQUE. Une étude de 1994 sur l'effet du style de nommage et de l'expertise ; une de 2005 sur le style de nommage et la documentation ; et une de 2013 sur l'impact du style d'identifiant sur l'EFFORT et la compréhension, qui court sur cinquante-huit pages de revue et qui est la seule à mesurer un effort plutôt qu'une opinion. La question « l'effet est-il de taille utile » ne peut être tranchée sans les lire. CE QUI DÉPLACE LA QUESTION, ET C'EST PROPRE À K7PL. Ces études comparent la casse chameau et le tiret bas sur des identifiants d'UTILISATEUR. K7PL n'impose rien sur les identifiants d'utilisateur. Ce qu'il fixe, ce sont ses propres mots-clés et ses étiquettes — et pour ceux-là la casse n'est pas une convention typographique mais une MARQUE LEXICALE que le langage sépare lui-même, c'est-à-dire le cas vérifiable par outil de QG-12. CONSÉQUENCE. Même lues, ces trois études n'atteindraient pas le noyau. Elles atteindraient une recommandation de style à l'usage des utilisateurs, qui est un autre document. TRANCHÉE le 3 septembre, ET C'EST CELLE DES TROIS QUI SE FERME LE PLUS FRANCHEMENT. LA QUESTION NE PORTE PAS SUR CE QUE K7PL GOUVERNE. Les trois études comparent la casse chameau et le tiret bas sur des identifiants d'UTILISATEUR. K7PL n'impose rien sur les identifiants d'utilisateur. Ce qu'il fixe, ce sont ses mots-clés et ses étiquettes — et pour ceux-là la casse n'est pas une convention typographique mais une MARQUE LEXICALE que le langage sépare lui-même, donc le cas vérifiable par outil de QG-12. CONSÉQUENCE, ET ELLE ÉTAIT DÉJÀ ÉCRITE. Même lues, ces trois études n'atteindraient pas le noyau : elles atteindraient une recommandation de style à l'usage des utilisateurs, qui est un autre document. La question est donc close ici et rouverte ailleurs, si ce document-là s'écrit un jour. STATUT DU RÉSIDU : trois pièces au livrable bibliographique, dont une seule mesure un EFFORT plutôt qu'une opinion.

#### Suivi d'avancement

1.  \[DONE\] oliveiraEvaluatingCodeReadability2020

2.  \[DONE\] trois pièces à verser — voir bib/A-SOURCER-nommage.md

### \[DONE\] \[#B\] Les abréviations : coût mesuré, ou opinion attestée ?

    ARC: G | QUID: QG-10 | REF

COÛT MESURÉ, ET SUR UNE TÂCHE QUI N'EST PAS UNE TÂCHE D'OPINION. LES DEUX PIÈCES. Une étude de 2013 compare noms abrégés et noms en mots pleins sur une tâche de CORRECTION DE FAUTE — donc du côté de la justesse, non du déclaratif, ce qui la place dans la minorité méthodologiquement solide de la revue. Et l'étude sur la longueur des identifiants de QG-8, dont le titre porte le résultat. LA DIRECTION EST DONC CONNUE ET ELLE VA CONTRE L'ABRÉVIATION. Ce n'est pas une opinion attestée : c'est une mesure, sur une tâche instrumentée, publiée deux fois. CE QUI MANQUE, ET POURQUOI LA QUESTION RESTE EN COURS. Ni l'une ni l'autre n'est au fonds ; la taille de l'effet et ses conditions ne peuvent donc pas être rapportées. La question demandait « coût mesuré ou opinion attestée », et cette part-là est tranchée — mesuré. Ce qui reste ouvert est le combien. CE QUE K7PL EN TIRE DÈS MAINTENANT. Ses propres noms sont ceux du noyau. Deux d'entre eux sont des abréviations et le temps 4 les avait déjà signalés par un autre chemin : le nom court de l'opération d'effet et celui du gestionnaire, que le critère de cohérence de famille rejette. La littérature les rejette aussi, et par une mesure. Deux critères indépendants qui condamnent les deux mêmes noms. TRANCHÉE le 3 septembre. LA PART QUE LA QUESTION DEMANDAIT EST RÉPONDUE ; CE QUI RESTE EST UN CHIFFRE, NON UN VERDICT. LA QUESTION ÉTAIT « COÛT MESURÉ, OU OPINION ATTESTÉE ». La réponse est MESURÉ, et sur une tâche de correction de faute — donc du côté de la justesse et non du déclaratif, ce qui la place dans la minorité méthodologiquement solide de la revue. Cette part-là est close. CE QUI RESTE EST LE COMBIEN, et il ne commande rien. K7PL a déjà agi sur ce que la direction impose : les deux abréviations du noyau ont été écartées au temps 5, remplacées par des mots pleins. Elles l'ont été par DEUX critères indépendants — la cohérence de famille, et cette mesure. Une taille d'effet ne rendrait pas la décision plus juste, elle la rendrait plus chiffrée. ET C'EST LE MEILLEUR CAS DE FIGURE POUR UNE LACUNE : la mesure manquante confirmerait une décision déjà prise pour une autre raison. STATUT DU RÉSIDU : deux pièces au livrable bibliographique.

#### Suivi d'avancement

1.  \[DONE\] oliveiraEvaluatingCodeReadability2020

2.  \[DONE\] deux pièces à verser — voir bib/A-SOURCER-nommage.md

### \[DONE\] \[#B\] Le nommage des FONCTIONS diffère-t-il du nommage des variables dans les mesures ?

    ARC: G | QUID: QG-11 | REF

RÉPONSE NÉGATIVE, ET LE FONDS PERMET DE LA RENDRE SANS LIRE LES ÉTUDES. CE QUI EST VÉRIFIÉ. La revue systématique cite onze travaux comme la littérature du nommage. Aucun des onze n'est titré sur les noms de FONCTIONS ni de MÉTHODES. Neuf portent sur les identifiants en général ; deux nomment explicitement les VARIABLES, dont l'un sur le cas des variables à une seule lettre. La distinction que la question demande n'a donc pas été mesurée sur ce corpus, et la littérature généralise de la variable à l'identifiant sans le déclarer. RÉSERVE DE PORTÉE, ET ELLE EST RÉELLE. Ce constat porte sur les TITRES de onze références, non sur leur contenu. Une étude titrée sur les identifiants peut contenir une strate sur les noms de fonctions. Ce qui est établi est qu'aucune n'en fait son objet. CE QUE CELA CHANGE POUR K7PL, ET C'EST L'INVERSE DE CE QU'ON ATTENDRAIT. Là où la littérature n'a rien, le langage a beaucoup. Les noms de fonctions du noyau sont en nombre FINI et fixés une fois par le concepteur ; les noms de variables sont écrits par l'utilisateur, en nombre non borné, et ne se gouvernent que par convention. Les deux ne relèvent pas du même problème : l'un est un choix de conception, l'autre une règle à faire respecter. Aucune mesure faite sur le second ne transporte au premier. ET C'EST UNE RAISON DE PLUS DE NE PAS FONDER LE CRITÈRE MNÉMONIQUE SUR CETTE LITTÉRATURE. Le temps 4 l'avait déjà rétrogradé en convergence d'usage faute de mesure qui départage. On voit ici qu'il n'aurait même pas eu le bon objet.

#### Suivi d'avancement

1.  \[DONE\] oliveiraEvaluatingCodeReadability2020

### \[DONE\] \[#A\] Quelle convention de nommage est VÉRIFIABLE par un outil, et laquelle ne l'est pas ?

    ARC: G | QUID: QG-12 | REF

La réponse se lit sur la méthode d'ouverture plutôt que sur le fonds, et elle est nette. Une convention de nommage est VÉRIFIABLE PAR UN OUTIL si et seulement si l'espace de noms qu'elle gouverne est séparé par le LANGAGE — par une marque lexicale ou par une position — car l'outil peut alors décider de l'appartenance sans deviner l'intention. C'est l'acquis de Berry sous sa forme opératoire : la convention typographique ne sert que là où le langage ne tranche pas, donc là précisément où elle N'EST PAS vérifiable. Sur les dix espaces de noms recensés, ceux que le langage sépare — étiquettes par le deux-points de tête, mots-clés par la position de tête de S-expression, glyphes et alias par identité de macro — donnent des conventions vérifiables ; les autres donnent des conventions qui ne le sont pas et qui relèvent de la revue humaine.

#### Suivi d'avancement

1.  \[DONE\] établi sur la méthode d'ouverture

### \[DONE\] \[#B\] La recherche syntaxique de code — chercher par la forme plutôt que par le texte — dit-elle quelque chose sur ce qui rend un identifiant retrouvable ?

    ARC: G | QUID: QG-13 | REF

Elle en dit quelque chose, et ce qu'elle dit DÉPLACE la question : la retrouvabilité ne tient pas à l'identifiant, elle tient à la forme. CE QUE LA SOURCE ÉTABLIT. Les outils d'analyse syntaxique légère exploitent la structure d'ARBRE du code, ce qui les rend plus expressifs que la recherche par chaîne ou par expression régulière ; à la différence des cadres qui manipulent explicitement l'arbre de syntaxe, leurs langages de requête RESSEMBLENT au langage source. La limite de l'état de l'art est que la requête doit être un fragment COMPLET ET ANALYSABLE, ce qui rend inutile toute spécification en cours de frappe. Les auteurs proposent une architecture qui ne demande qu'un DÉCOUPAGE EN JETONS, avec des jokers conscients de l'arbre, construits sur des AUTOMATES D'ARBRES. CE QUE K7PL EN TIRE, EN DEUX POINTS DONT LE SECOND N'ÉTAIT PAS PRÉVU. La retrouvabilité tient à la possibilité d'écrire une requête PARTIELLE qui ressemble au source. Une syntaxe à S-expressions y est favorable pour une raison structurelle : tout fragment y est déjà un arbre, et le jeton de tête suffit à désigner la forme. C'est un argument pour la syntaxe du document qui ne passe pas par la lisibilité. Le mécanisme est l'AUTOMATE D'ARBRE, qui est l'objet du chapitre 4. Le langage porte donc déjà la théorie de son propre outil de recherche, et ce recoupement n'avait pas été relevé. RÉSERVE. La source mesure la couverture de requêtes, non la performance humaine. Elle instruit ce qu'un OUTIL peut faire, pas ce qu'un LECTEUR retrouve, et la question portait sur les deux.

#### Suivi d'avancement

1.  \[DONE\] matuteSyntacticCodeSearch2024

### \[DONE\] \[#B\] Les duplicats de code à grande échelle : que révèlent-ils sur ce que les gens nomment de la même manière ?

    ARC: G | QUID: QG-14 | REF

La source ne répond pas à la question telle qu'elle est posée, et elle en répond une meilleure. Le résumé, illisible au premier passage, est venu avec la reconstruction de l'index. CE QU'ELLE MESURE. Quatre millions et demi de projets non forkés sur GitHub, plus de 428 millions de fichiers en Java, C++, Python et JavaScript, pour 85 millions de fichiers UNIQUES : soixante-dix pour cent du code de GitHub est le clone d'un fichier déjà créé. La variation entre écosystèmes est d'un ORDRE DE GRANDEUR — JavaScript ne compte que six pour cent de fichiers distincts, Java soixante. Entre neuf et trente et un pour cent des projets ont au moins quatre cinquièmes de leurs fichiers trouvables ailleurs. CE QU'ELLE NE DIT PAS. Rien sur les NOMS. Elle mesure la duplication de FICHIERS, non la convergence des noms, et la question telle qu'elle était posée n'a pas de réponse ici. Le compte n'est pas la réponse, et il faut le dire plutôt que de forcer le rapprochement. CE QU'ELLE DIT ET QUI VAUT MIEUX — UN RÉSULTAT DE MÉTHODE. Toute étude de nommage conduite sur un corpus GitHub compte le même fichier jusqu'à plusieurs fois, et le facteur de sur-comptage varie d'un ordre de grandeur selon le langage. Une comparaison de conventions ENTRE LANGAGES tirée d'un tel corpus est donc confondue par la duplication, et le SENS du biais se lit : elle surestime l'homogénéité de JavaScript par rapport à celle de Java. Les auteurs signalent eux-mêmes que ces taux ont des implications pour qui analyse de grandes bases de code. POUR L'ARC. C'est une raison de plus de ne pas chercher le critère mnémonique dans les grands corpus, et elle est indépendante des deux autres — celle de QG-11, qui dit que la littérature n'a pas le bon objet, et celle du temps 4, qui dit qu'elle n'a pas de mesure qui départage.

#### Suivi d'avancement

1.  \[DONE\] lopesDejaVuMapCode2017

### \[DONE\] \[#B\] Les jeux de glyphes non ASCII : existe-t-il une mesure de leur coût d'apprentissage, ou seulement des témoignages ?

    ARC: G | QUID: QG-15 | REF: falkoffEvolutionAPL1978, huiAPL19782020, iversonNotationToolThought1980a, stefikEmpiricalInvestigationProgramming2013

SEULEMENT DES TÉMOIGNAGES, ET LA MEILLEURE MESURE DE L'ARC NE PORTE PAS SUR LES GLYPHES. CE QUI A ÉTÉ CHERCHÉ, ET CE QUE LE FONDS REND. La lignée d'APL de 1978 à 2020, la thèse d'Iverson sur la notation comme outil de pensée, et un essai sur le symbole comme condition de la compréhension. Tous sont des témoignages de concepteurs ou des essais, aucun n'est une mesure d'apprenants. ET LA PRÉCISION QUI VAUT MIEUX QUE L'ABSENCE. La mesure la plus solide de tout l'arc — les taux d'exactitude de novices sur six langages, dont un témoin aux mots-clés tirés au hasard — porte sur des MOTS-CLÉS, et son témoin lui-même est en ASCII. Le résultat qui retire un appui à l'argument de la syntaxe familière ne dit donc RIEN des glyphes, et le manuscrit le dit déjà à l'endroit où il l'invoque. LE COÛT D'APPRENTISSAGE D'UN JEU DE GLYPHES NON ASCII N'A DONC PAS DE MESURE, et c'est une lacune de la littérature et non du fonds. Elle se déclare comme telle, au même titre que le budget de vocabulaire : ce que le document avance ici est un pari, et il est écrit comme un pari.

#### Suivi d'avancement

1.  \[DONE\] lacune de littérature déclarée

### \[DONE\] \[#A\] La cinquième règle d'admission — aucun couple de glyphes ne se ressemble à l'œil — a-t-elle un instrument ?

    ARC: G | QUID: QG-16 | REF: UnicodeStandardV17

OUI, ET C'EST UNE NORME PLUTÔT QU'UNE MÉTHODE — machine-lisible, versionnée, et le résultat de son application CORRIGE LA PORTÉE DE LA RÈGLE. L'INSTRUMENT. La norme de sécurité d'Unicode définit la confusabilité de deux chaînes par l'égalité de leur SQUELETTE : une transformation qui met la chaîne en forme normale de décomposition, retire les caractères ignorables par défaut, remplace chaque caractère par le prototype qu'une donnée normative lui associe, et renormalise. Deux glyphes sont admissibles ensemble si et seulement si leurs squelettes diffèrent. La donnée est un fichier versionné — v17.0.0, daté du 22 juillet 2025 — de six mille cinq cent soixante-cinq lignes. LE RÉSULTAT, CONDUIT SUR LES VINGT-HUIT GLYPHES DE LA TABLE. Zéro collision INTERNE : la règle est satisfaite. Quatre confusables SORTANTS, et deux sont graves — le signe de multiplication se confond avec la lettre x, la disjonction logique avec la lettre v. Les deux autres, une étoile cerclée et une rune islandaise, sont sans portée. ET C'EST LE SECOND TEMPS QUI COMPTE. La règle regardait à l'intérieur du jeu quand le danger est au-dehors : un programme peut porter x là où son auteur voulait le signe de multiplication, et rien ne le signalerait — les deux sont licites à cette position, et x est le nom de variable le plus employé qui soit. La règle se réénonce en DEUX clauses : aucun couple du jeu ne partage un squelette, ET tout glyphe dont le squelette est un caractère d'identifiant est déclaré comme tel. RÉSERVE DE TRANSPORT, ÉCRITE DANS LE MANUSCRIT. La norme vise la sécurité des identifiants et l'usurpation, non la conception d'un jeu de glyphes ; sa donnée est calibrée sur ce que confondent des lecteurs de langues diverses devant une chaîne isolée, non sur ce que confond un programmeur devant une ligne de code. Elle est employée parce qu'elle est le seul instrument normatif disponible, non parce que son cadre serait le nôtre. PORTÉ à l'annexe G.7, avec un CONTRÔLE qui rejoue la vérification à chaque passe sur un extrait local conservé avec sa provenance.

#### Suivi d'avancement

1.  \[DONE\] UnicodeStandardV17, appliqué et instrumenté

### \[DONE\] \[#B\] La mise en page sémantiquement portante, sur marque explicite : y a-t-il des mesures, ou seulement l'exemple d'Uiua ?

    ARC: G | QUID: QG-17 | REF: miaraProgramIndentationComprehensibility1983, cohenCodeStyleSheets2025

PAS DE MESURE, ET L'UNIQUE RÉSULTAT VOISIN EST ISOLÉ ET NON RÉPLIQUÉ. CE QUE LE FONDS PORTE. Sur la mise en page en général, l'optimum d'indentation de deux à quatre espaces, résultat de 1983 dont les auteurs eux-mêmes ouvrent en notant que de nombreuses études ne confirment pas le consensus, et qu'une mesure antérieure trouvait l'effet de l'indentation SEULE non significatif. Aucune réplication postérieure au fonds. Sur la mise en page PORTANTE — celle où la disposition change le sens — rien. ET LE MÉCANISME EXISTE SANS LA MESURE, ce qui est le motif récurrent de cet arc. Les feuilles de style pour le texte de programme montrent qu'on peut styler depuis l'arbre et les types, et leurs auteurs signalent que la difficulté technique n'est pas la sélection mais la MISE EN PAGE des blocs imbriqués — remarque qui vise une syntaxe à expressions symboliques plus que toute autre. Le document a donc le mécanisme, l'avertissement technique, et aucune mesure d'effet. CONSÉQUENCE. Une mise en page sémantiquement portante sur marque explicite est concevable et implantable ; elle n'est pas soutenue par une mesure, et le document ne doit pas laisser croire le contraire.

#### Suivi d'avancement

1.  \[DONE\] miaraProgramIndentationComprehensibility1983

2.  \[DONE\] cohenCodeStyleSheets2025

### \[DONE\] \[#B\] L'indentation : l'optimum 2-4 espaces de Miara a-t-il été retesté depuis 1983 ?

    ARC: G | QUID: QG-18 | REF

Pas dans le fonds, et la source elle-même est plus nuancée que le chiffre qu'on lui prête. Les auteurs ouvrent en écrivant que le consensus est que l'indentation aide la compréhension BIEN QUE DE NOMBREUSES ÉTUDES NE LE CONFIRMENT PAS, et rapportent dans leur propre revue que Weissman avait trouvé l'effet principal de l'indentation SEULE non significatif dans aucune de ses mesures, une interaction significative apparaissant en revanche avec le commentaire. L'optimum de deux à quatre espaces est donc l'hypothèse et le résultat de cette étude de 1983, dans une littérature dont elle note qu'elle ne soutient pas le consensus. Aucune réplication postérieure n'est au fonds.

#### Suivi d'avancement

1.  \[DONE\] miaraProgramIndentationComprehensibility1983

### \[DONE\] \[#A\] Le glyphe se DÉRIVE-t-il de la place dans une hiérarchie ?

    ARC: G | QUID: QG-19 | REF

PARTIELLEMENT, ET LA PART QUI SE DÉRIVE N'EST PAS CELLE QU'ON ATTENDAIT. LE GLYPHE LUI-MÊME NE SE DÉRIVE PAS, et la raison est structurelle plutôt que contingente. Un glyphe est l'orthographe d'une MACRO DE BIBLIOTHÈQUE — c'est l'arbitrage du chapitre 5 — et la bibliothèque est le seul poste de nommage NON BORNÉ du langage, celui-là même dont le budget se déclare faute de seuil. Dériver un glyphe d'une place dans une hiérarchie suppose la hiérarchie CLOSE ; celle-ci ne l'est pas, et ne peut pas l'être sans fermer la bibliothèque. MAIS LA CATÉGORIE SE DÉRIVE, ET LE DOCUMENT LE FAIT DÉJÀ SANS LE DIRE. La seconde table de glyphes, celle des R-expressions, est organisée par NIVEAU DE COMPLEXITÉ — atomes, quantification, composition, capture, assertions, avancé, contrôle, approximatif, binaire, méta — et ce niveau est exactement celui qui détermine vers quel automate le motif s'abaisse. La place dans la hiérarchie ne donne donc pas le DESSIN du glyphe, elle donne sa FAMILLE, et la famille est ce que la cohérence de forme doit respecter. CE QUE CELA REND POUR L'ARC. La question demandait une dérivation et la réponse est une CONTRAINTE : le glyphe est libre, sa famille ne l'est pas. C'est la forme la plus forte que le critère de cohérence de famille puisse prendre sur les glyphes, et elle est déjà appliquée là où une hiérarchie existe.

#### Suivi d'avancement

1.  \[DONE\] établi sur les deux tables de glyphes du document

### \[DONE\] \[#B\] Combien de FONCTIONS une bibliothèque standard peut-elle offrir avant que le coût de vocabulaire ne domine ?

    ARC: G | QUID: QG-20 | REF

LE SEUIL N'EXISTE PAS DANS LA LITTÉRATURE, ET LA QUESTION SE REFORMULE. CE QUI A ÉTÉ CHERCHÉ. Taille d'API et utilisabilité, taille de bibliothèque standard, taille du langage, taille de vocabulaire, mémoire de travail et charge cognitive, apprentissage et courbe d'apprentissage. Aucune sonde ne rend de seuil, et les deux revues systématiques que l'arc a dépouillées — cinquante-quatre études sur la lisibilité, un demi-siècle sur les messages d'erreur — n'en portent pas non plus. L'absence est donc constatée sur un fonds instruit, non supposée. CE QUE LE FONDS PORTE À LA PLACE, ET QUI N'EST PAS RIEN. Deux récits historiques de langages dont le vocabulaire a crû, et ils vont en sens contraire. Le C++ raconte une communauté passée d'environ trois millions à quatre millions et demi de développeurs sur la période même où le langage grossissait le plus. L'APL raconte l'inverse : plusieurs dizaines d'implantations nées et enterrées en quarante ans. Ce sont des TÉMOIGNAGES, ils ne se comparent pas, et aucun ne rend un nombre. CE QUE CELA COMMANDE AU DOCUMENT. Le budget de la bibliothèque est une DÉCISION DE CONCEPTION et doit se déclarer comme telle. La formulation à retenir n'est pas « au-delà de tant de fonctions le coût de vocabulaire domine », qui invoquerait un seuil que personne n'a mesuré, mais « nous fixons tant, et voici sur quoi ». ET UN INSTRUMENT EXISTE, QUI N'EST PAS UNE MESURE DE SEUIL ET VAUT MIEUX. La carte de justesse par jeton de Stefik et Siebert estime la justesse d'un novice JETON PAR JETON. Elle ne dit pas combien de jetons sont de trop ; elle dit lesquels coûtent. Un budget se dépense mieux quand on connaît le prix de chaque poste que quand on connaît le plafond, et c'est la seule voie instrumentée que l'arc ait trouvée.

#### Suivi d'avancement

1.  \[DONE\] lacune de corpus déclarée, et l'instrument substitué

### \[DONE\] \[#B\] Combien de SIGNES peuvent les porter ? *Question 3b, et elle dépend du budget.*

    ARC: G | QUID: QG-21 | REF

MÊME VERDICT QUE QG-20 SUR LA MESURE, ET UNE BORNE QUE LA QUESTION N'AVAIT PAS VUE. LA MESURE N'EXISTE PAS. Aucune source du fonds ne rend un nombre de signes au-delà duquel l'apprentissage bascule. L'APL est le seul cas historique d'un jeu de glyphes tenu sur un demi-siècle, et ses deux récits successifs sont des témoignages de concepteurs, non des mesures d'apprenants. LA QUESTION NE DÉPEND PAS SEULEMENT DU BUDGET, ET C'EST LE POINT. Elle avait été posée comme subordonnée à QG-20 — d'abord combien de fonctions, ensuite combien de signes pour les porter. Or le nombre de signes est borné INDÉPENDAMMENT par la cinquième règle d'admission : aucun couple de glyphes ne doit se ressembler à l'œil. Cette règle borne le jeu par le bas, quel que soit le budget de fonctions, et elle est la seule borne du document qui puisse recevoir un instrument. C'est QG-16, et l'ordre de dépendance entre les deux questions s'en trouve inversé. CE QUI RESTE À FAIRE. Instruire QG-16 avant de revenir ici. Tant que la cinquième règle n'a pas d'instrument, le nombre de signes ne se discute pas — il se déclare, comme le budget.

#### Suivi d'avancement

1.  \[DONE\] lacune de corpus déclarée, et la dépendance à QG-16 relevée

### \[DONE\] \[#B\] Le facteur deux de Denny — 710,7 s contre 324,9 s — tient-il hors du contexte pédagogique ?

    ARC: G | QUID: QG-22 | REF

Le facteur est exact et significatif, et il ne transporte pas — les auteurs le disent avant nous. Sept cent dix virgule sept secondes pour le groupe aux messages d'origine contre trois cent vingt-quatre virgule neuf pour le groupe aux messages réécrits, sur neuf mille cinq cent quatre-vingt-quatre soumissions, les distributions différant significativement à moins d'un pour mille. Les trois questions de recherche reçoivent une réponse positive. Mais les auteurs ouvrent en écrivant que les résultats de ce courant sont MITIGÉS et que la comparaison directe entre études est difficile, celles-ci portant sur des enrichissements de nature différente et rapportant selon des MÉTRIQUES DIFFÉRENTES. Le facteur deux vaut de cette expérience et de son contexte pédagogique, non du principe général.

#### Suivi d'avancement

1.  \[DONE\] dennyErrorMessageReadability2020

### \[DONE\] \[#B\] Les quatre facteurs de lisibilité d'un message — longueur, jargon, structure, vocabulaire — transportent-ils vers le français ?

    ARC: G | QUID: QG-23 | REF

Les quatre facteurs ne sont pas ÉTABLIS, et il faut le dire ainsi plutôt que de les présenter comme acquis. LE FONDS DONNE UNE REVUE SYSTÉMATIQUE, ET SON RÉSULTAT D'ENSEMBLE COMMANDE LES CINQ QUESTIONS SUR LES MESSAGES. Un demi-siècle de littérature, 651 articles retournés, 448 inspectés à la main, dix lignes directrices généralisées qui englobent vingt des vingt-deux propositions des quatre travaux qui avaient tenté une synthèse. ET LE VERDICT SUR LA PREUVE EST SÉVÈRE : « la plupart de ces suggestions, en particulier dans les années soixante, soixante-dix, quatre-vingt et quatre-vingt-dix, reposaient sur des ANECDOTES OU L'OPINION D'EXPERTS ». Les auteurs classent leurs articles selon le type de preuve présentée, et n'appellent EMPIRIQUES que ceux qui apportent une preuve expérimentale. LE CAS DE LA LISIBILITÉ EST EXEMPLAIRE ET IL VAUT POUR TOUTES. C'est la première des dix lignes directrices ; la source fondatrice la pose comme critère qu'un bon message doit satisfaire, et « ne fournit AUCUN MÉCANISME POUR L'ÉVALUER ». Un critère nommé depuis cinquante ans et jamais opérationnalisé. CE QUE K7PL PEUT DONC INVOQUER, ET CE QU'IL NE PEUT PAS. Il peut invoquer une CONVERGENCE D'OPINION EXPERTE, qui est réelle et documentée sur dix lignes directrices. Il ne peut pas invoquer un effet mesuré des quatre facteurs — longueur, jargon, structure, ton — car aucun n'a de mesure isolée au fonds. LA FORMULATION JUSTE EST DONC : ces quatre facteurs sont ceux que la littérature recommande, non ceux dont on a mesuré l'effet. La différence n'est pas rhétorique — elle décide de ce qu'un relecteur peut opposer.

#### Suivi d'avancement

1.  \[DONE\] beckerCompilerErrorMessages2019

### \[DONE\] \[#A\] Un message qui porte la DÉRIVATION PARTIELLE est-il mesurablement meilleur, ou est-ce une hypothèse ?

    ARC: G | QUID: QG-24 | REF

Question sans réponse mesurée, et la revue explique pourquoi il n'y en aura pas de sitôt. LE FONDS DONNE UNE REVUE SYSTÉMATIQUE, ET SON RÉSULTAT D'ENSEMBLE COMMANDE LES CINQ QUESTIONS SUR LES MESSAGES. Un demi-siècle de littérature, 651 articles retournés, 448 inspectés à la main, dix lignes directrices généralisées qui englobent vingt des vingt-deux propositions des quatre travaux qui avaient tenté une synthèse. ET LE VERDICT SUR LA PREUVE EST SÉVÈRE : « la plupart de ces suggestions, en particulier dans les années soixante, soixante-dix, quatre-vingt et quatre-vingt-dix, reposaient sur des ANECDOTES OU L'OPINION D'EXPERTS ». Les auteurs classent leurs articles selon le type de preuve présentée, et n'appellent EMPIRIQUES que ceux qui apportent une preuve expérimentale. LE CAS DE LA LISIBILITÉ EST EXEMPLAIRE ET IL VAUT POUR TOUTES. C'est la première des dix lignes directrices ; la source fondatrice la pose comme critère qu'un bon message doit satisfaire, et « ne fournit AUCUN MÉCANISME POUR L'ÉVALUER ». Un critère nommé depuis cinquante ans et jamais opérationnalisé. CE QUI EST PROPRE À CETTE QUESTION. Porter la DÉRIVATION PARTIELLE dans un message est un dispositif que la littérature des messages d'erreur ne connaît pas : elle porte sur des langages sans dérivation à montrer. Aucune mesure ne peut donc exister, faute d'objet. CE QUE CELA IMPLIQUE POUR LE DOCUMENT. Si le chapitre 6 veut porter la dérivation partielle, il le fera sur un argument de CONCEPTION et non de mesure — et devra dire lequel. L'argument disponible est celui de la stratification : un message qui montre où la dérivation s'arrête dit au lecteur à quel NIVEAU il doit intervenir, ce qui est la question de QG-25.

#### Suivi d'avancement

1.  \[DONE\] beckerCompilerErrorMessages2019

### \[DONE\] \[#A\] La stratification SIGNAL / RÈGLE / CONNAISSANCE d'un message a-t-elle un précédent ?

    ARC: G | QUID: QG-25 | REF

La stratification a un précédent, mais il vient d'une autre discipline que celle des messages d'erreur — et c'est ce qui la rend intéressante. LE FONDS DONNE UNE REVUE SYSTÉMATIQUE, ET SON RÉSULTAT D'ENSEMBLE COMMANDE LES CINQ QUESTIONS SUR LES MESSAGES. Un demi-siècle de littérature, 651 articles retournés, 448 inspectés à la main, dix lignes directrices généralisées qui englobent vingt des vingt-deux propositions des quatre travaux qui avaient tenté une synthèse. ET LE VERDICT SUR LA PREUVE EST SÉVÈRE : « la plupart de ces suggestions, en particulier dans les années soixante, soixante-dix, quatre-vingt et quatre-vingt-dix, reposaient sur des ANECDOTES OU L'OPINION D'EXPERTS ». Les auteurs classent leurs articles selon le type de preuve présentée, et n'appellent EMPIRIQUES que ceux qui apportent une preuve expérimentale. LE CAS DE LA LISIBILITÉ EST EXEMPLAIRE ET IL VAUT POUR TOUTES. C'est la première des dix lignes directrices ; la source fondatrice la pose comme critère qu'un bon message doit satisfaire, et « ne fournit AUCUN MÉCANISME POUR L'ÉVALUER ». Un critère nommé depuis cinquante ans et jamais opérationnalisé. CE QUI EST PROPRE À CETTE QUESTION. La distinction SIGNAL / RÈGLE / CONNAISSANCE n'est pas une invention de la littérature des messages : c'est la taxonomie de Rasmussen sur les niveaux de contrôle cognitif, et le fonds la porte. Aucune des dix lignes directrices de la revue ne la nomme. D'OÙ LA RÉPONSE, EN DEUX TEMPS. Le précédent existe et il est solide, mais il est HORS de la littérature des messages ; l'appliquer aux messages d'un compilateur serait un transport, et il devrait être justifié comme tel. C'est faisable — la taxonomie porte sur ce qu'un opérateur fait d'une information, ce qu'un message d'erreur est — mais ce n'est pas acquis.

#### Suivi d'avancement

1.  \[DONE\] beckerCompilerErrorMessages2019

### \[DONE\] \[#B\] Un message de CONTRAINTE — « rétablis l'invariant » — se compare-t-il à un message de correction locale, et sur quelle mesure ?

    ARC: G | QUID: QG-26 | REF

Aucune comparaison mesurée n'existe, et la revue permet de le dire avec certitude plutôt que par défaut. LE FONDS DONNE UNE REVUE SYSTÉMATIQUE, ET SON RÉSULTAT D'ENSEMBLE COMMANDE LES CINQ QUESTIONS SUR LES MESSAGES. Un demi-siècle de littérature, 651 articles retournés, 448 inspectés à la main, dix lignes directrices généralisées qui englobent vingt des vingt-deux propositions des quatre travaux qui avaient tenté une synthèse. ET LE VERDICT SUR LA PREUVE EST SÉVÈRE : « la plupart de ces suggestions, en particulier dans les années soixante, soixante-dix, quatre-vingt et quatre-vingt-dix, reposaient sur des ANECDOTES OU L'OPINION D'EXPERTS ». Les auteurs classent leurs articles selon le type de preuve présentée, et n'appellent EMPIRIQUES que ceux qui apportent une preuve expérimentale. LE CAS DE LA LISIBILITÉ EST EXEMPLAIRE ET IL VAUT POUR TOUTES. C'est la première des dix lignes directrices ; la source fondatrice la pose comme critère qu'un bon message doit satisfaire, et « ne fournit AUCUN MÉCANISME POUR L'ÉVALUER ». Un critère nommé depuis cinquante ans et jamais opérationnalisé. CE QUI EST PROPRE À CETTE QUESTION. Un message de CONTRAINTE — « rétablis l'invariant » — suppose que le lecteur sache ce qu'est l'invariant, donc qu'il opère au niveau de la RÈGLE ou de la CONNAISSANCE. Un message de FAIT — « la ligne 12 attend un entier » — opère au niveau du SIGNAL. Les deux ne s'adressent donc pas au même lecteur, et les comparer globalement n'aurait pas de sens. LA QUESTION EST DONC MAL POSÉE, et sa reformulation est plus utile : à quel NIVEAU un message doit-il s'adresser, sachant que le niveau dépend de ce que le lecteur sait déjà. C'est QG-25, et les deux questions n'en font qu'une.

#### Suivi d'avancement

1.  \[DONE\] beckerCompilerErrorMessages2019

### \[DONE\] \[#A\] Un LSP qui rend des glyphes à partir d'ASCII a-t-il un précédent documenté ?

    ARC: G | QUID: QG-27 | REF

Il en a un, et il généralise le dispositif au lieu de le reproduire. Des feuilles de style pour le texte de programme, dont les règles SÉLECTIONNENT des éléments de l'arbre syntaxique abstrait pour styler leur représentation visuelle, le langage de sélecteurs généralisant les constructions essentielles de CSS aux types de données algébriques. Le glyphe et son alias sont le cas le plus simple — une dimension, deux valeurs — quand la source style sur trois axes que K7PL possède : structure de la syntaxe abstraite, INFORMATION DE TYPE STATIQUE, et valeurs d'exécution. Deux points que le chapitre 5 n'a pas posés en sortent : le style y dépend des choix des AUTEURS ET DES LECTEURS distinctement, alors que la règle de Stroustrup invoquée suppose sans le dire que le choix appartient au lecteur ; et la difficulté technique n'est pas la sélection mais la MISE EN PAGE des blocs imbriqués, ce qui vise une syntaxe à S-expressions plus que toute autre.

#### Suivi d'avancement

1.  \[DONE\] cohenCodeStyleSheets2025

2.  \[DONE\] bourMerlinLanguageServer

### \[DONE\] \[#B\] Les ligatures de fonte : mesure d'effet, ou préférence ?

    ARC: G | QUID: QG-28 | REF: cohenCodeStyleSheets2025, oliveiraEvaluatingCodeReadability2020

PRÉFÉRENCE, ET LA QUESTION SE REFERME SUR LE MÊME MOTIF QUE QG-17. Le fonds porte le MÉCANISME et non la mesure. Les feuilles de style pour le texte de programme établissent qu'on peut styler depuis l'arbre de syntaxe, l'information de type statique et les valeurs d'exécution, et en donnent l'implantation ; elles ne mesurent pas l'effet du style sur la compréhension. CE QUI TRANCHE MAINTENANT ET NE TRANCHAIT PAS AVANT. La question demandait mesure d'effet ou préférence, et je la maintenais en cours faute d'une source de mesure. Trois instructions indépendantes ont depuis établi que cette mesure n'existe pas dans la classe de questions à laquelle elle appartient : la revue de la lisibilité n'en porte pas, l'indentation n'a qu'un résultat isolé de 1983 non répliqué, et la mise en page portante n'a rien. Une quatrième recherche ne rendrait pas ce que trois n'ont pas rendu. LA LIGATURE EST DONC UNE PRÉFÉRENCE, ce qui ne la disqualifie pas — elle relève de l'affichage, que le dispositif glyphe/alias confie au lecteur, et un choix d'affichage n'a pas à être mesuré pour être offert. Ce qui serait fautif est de l'annoncer comme un gain de compréhension.

#### Suivi d'avancement

1.  \[DONE\] cohenCodeStyleSheets2025

### \[DONE\] \[#A\] Que doit contenir un message d'erreur pour être exploitable SANS serveur de langage ? *Le pendant, côté diagnostic, de la garantie ASCII.*

    ARC: G | QUID: QG-29 | REF

Les dix lignes directrices de la revue en sont la matière, et elles sont utilisables telles quelles — sous la réserve d'évidence ci-dessous. LE FONDS DONNE UNE REVUE SYSTÉMATIQUE, ET SON RÉSULTAT D'ENSEMBLE COMMANDE LES CINQ QUESTIONS SUR LES MESSAGES. Un demi-siècle de littérature, 651 articles retournés, 448 inspectés à la main, dix lignes directrices généralisées qui englobent vingt des vingt-deux propositions des quatre travaux qui avaient tenté une synthèse. ET LE VERDICT SUR LA PREUVE EST SÉVÈRE : « la plupart de ces suggestions, en particulier dans les années soixante, soixante-dix, quatre-vingt et quatre-vingt-dix, reposaient sur des ANECDOTES OU L'OPINION D'EXPERTS ». Les auteurs classent leurs articles selon le type de preuve présentée, et n'appellent EMPIRIQUES que ceux qui apportent une preuve expérimentale. LE CAS DE LA LISIBILITÉ EST EXEMPLAIRE ET IL VAUT POUR TOUTES. C'est la première des dix lignes directrices ; la source fondatrice la pose comme critère qu'un bon message doit satisfaire, et « ne fournit AUCUN MÉCANISME POUR L'ÉVALUER ». Un critère nommé depuis cinquante ans et jamais opérationnalisé. CE QUI EST PROPRE À CETTE QUESTION, ET C'EST UNE CONTRAINTE QUE K7PL S'IMPOSE. Un message exploitable SANS serveur de langage doit se suffire à lui-même : pas de renvoi à une inspection interactive, pas de « survolez pour voir le type ». C'est plus exigeant que ce que la littérature suppose, la plupart de ses travaux portant sur des environnements d'enseignement où l'outillage est présent. LE FONDS NE PORTE DONC PAS LA RÉPONSE À LA QUESTION TELLE QUE K7PL LA POSE. Il porte les dix lignes directrices, qui sont un point de départ, et la mesure de leur appui empirique, qui est faible. Le reste est une décision de conception, et elle devra s'assumer comme telle.

#### Suivi d'avancement

1.  \[DONE\] beckerCompilerErrorMessages2019

### \[DONE\] \[#C\] La forme `def nom` suivie de propriétés `:clé valeur` se prête-t-elle à une saisie assistée en formulaire, et cela se conçoit-il plutôt que se mesure-t-il ?

    ARC: G | QUID: QG-30 | REF

ELLE S'Y PRÊTE, ET CELA SE CONÇOIT PLUTÔT QUE DE SE MESURER — ce que la question anticipait, et le fonds le confirme par le vide. CE QUI SE CONÇOIT, ET LE MOTIF EST CELUI DE QG-12. Une forme composée d'un mot-clé de tête et d'une suite de couples clé-valeur est un ENREGISTREMENT dont le langage sépare lui-même les champs : la clé est une étiquette, marquée lexicalement par le deux-points de tête, donc reconnaissable sans deviner l'intention. Un outil peut en dresser la liste, en vérifier l'exhaustivité contre la signature, et en proposer la saisie champ par champ — exactement parce que l'espace de noms est séparé par le LANGAGE et non par une convention typographique. CE QUI NE SE MESURE PAS. Aucune source du fonds ne compare la saisie en formulaire à la saisie libre pour un langage de programmation, et la classe de questions à laquelle celle-ci appartient — les mesures d'outillage — est celle dont l'arc a établi qu'elle est la plus pauvre. CONSÉQUENCE, ET ELLE EST DE RANG C COMME LA QUESTION. La forme est favorable à la saisie assistée par CONSTRUCTION, et le dire est licite ; annoncer un gain d'ergonomie ne le serait pas.

#### Suivi d'avancement

1.  \[DONE\] établi sur la règle des étiquettes et l'inventaire des espaces de noms

### \[DONE\] \[#A\] Quels langages ont retiré un trait signature, et qu'est-il arrivé ?

    ARC: H | QUID: QH-1 | REF: hudakHistoryHaskellBeing2007, macqueenHistoryStandardML2020, huiAPL19782020

Oui, et le motif est constant : ce qui se retire n'est presque jamais un TRAIT, c'est une PROMESSE que le trait portait. LES CAS AU FONDS. Haskell a retiré la promesse que la paresse serait le régime unique, et sa rétrospective note que le clivage strict/paresseux « est devenu bien moins une décision tout-ou-rien ». Standard ML a retiré des garanties de son système de modules au fil des révisions. APL a retiré des glyphes entre 1978 et 2020, mais ses auteurs présentent ces retraits comme des CORRECTIONS DE NOTATION et non comme des pertes de fonction. CE QUE K7PL EN TIRE, ET C'EST UNE MISE EN GARDE PLUTÔT QU'UN ACQUIS. Les traits que ce document pourrait un jour retirer ne sont pas ses délimiteurs ni ses glyphes — ce sont les promesses attachées au grade : que quatre composantes suffisent, que le régime est le même à trois échelles, que la borne est pire cas. Deux de ces trois ont été relâchées le 2 septembre même, et l'histoire dit que c'est l'ordre normal des choses. RÉSERVE : trois cas ne font pas une loi, et les trois sont des langages fonctionnels ou de tableaux. Le motif est plausible, non établi.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] Quels langages ont livré leur propre outillage, et à quel moment de leur vie ?

    ARC: H | QUID: QH-2 | REF: hudakHistoryHaskellBeing2007, hickeyHistoryClojure2020, symeEarlyHistory2020

Tard, et toujours après l'adoption — ce qui est le résultat, et il est défavorable à une intuition courante. LE MOTIF. Aucun des trois langages dont le fonds porte la rétrospective n'a livré son outillage avec sa première définition. L'outillage vient quand des utilisateurs existent, et il est façonné par ce qu'ils font plutôt que par ce que les concepteurs avaient prévu. CE QUE CELA DIT DU CHAPITRE 6, qui décrit un pipeline sans l'avoir construit : ce n'est pas un retard mais l'ordre habituel. Ce qui serait un défaut serait de figer maintenant des décisions d'outillage que l'usage n'a pas informées — et le document ne le fait pas, son chapitre 6 décrivant des ORDRES DE VÉRIFICATION plutôt que des passes. LA LIMITE DE L'ARGUMENT : trois cas, tous de langages nés en laboratoire ou en entreprise avec un public captif. Un langage sans public n'a pas ce luxe.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] Quels langages ont changé de syntaxe APRÈS adoption, et à quel coût ?

    ARC: H | QUID: QH-3 | REF: brownDevelopmentAPL2Syntax1985, huiAPL19782020

Oui, et le cas documenté est APL2, dont le développement de la syntaxe est un rapport d'ingénierie et non une rétrospective d'auteur — ce qui en fait la source la plus utile de l'arc. LE COÛT EST DIT PAR LA MÉTHODE PLUTÔT QUE PAR UN CHIFFRE. Les auteurs posent quelques principes généraux, en dérivent des règles simples, et gardent une règle générale toujours prête à arbitrer les cas que les règles particulières ne couvrent pas — en se donnant explicitement un CADRE POUR LES EXTENSIONS FUTURES avant d'en avoir besoin. CE QUE K7PL EN TIRE, ET C'EST PORTÉ AU CHAPITRE 1 : le précédent n'est pas une caution mais une mise en garde. La valeur d'une telle méthode ne se mesure pas à l'élégance du noyau, elle se mesure à ce qu'il advient de la dixième extension.

#### Suivi d'avancement

1.  \[DONE\] reporté le 2 septembre depuis le travail de l'arc

### \[DONE\] \[#A\] Les langages à jeu de glyphes — APL, J, K, BQN, Uiua — ont-ils une histoire commune de leur adoption et de leur rejet ?

    ARC: H | QUID: QH-4 | REF: falkoffEvolutionAPL1978, iversonNotationToolThought1980a, huiAPL19782020

Oui, et l'histoire commune est celle d'une thèse plutôt que d'un jeu de signes : la notation ne décrit pas la pensée, elle la façonne. Le fonds porte la lignée d'APL de 1978 à 2020. MAIS L'ARC A TROUVÉ MIEUX QU'UNE HISTOIRE — IL A TROUVÉ UN TROU. Deux des trois langages sur lesquels le chapitre 5 fonde sa notation tacite, BQN et Uiua, N'ONT AUCUNE PUBLICATION ÉVALUÉE PAR LES PAIRS. C'est un fait sur le domaine et non une lacune du fonds, et il est consigné comme tel au fichier des manques. CONSÉQUENCE DE MÉTHODE : la collecte de vocabulaire s'y fait sur la documentation de référence, source primaire mais non évaluée. Acceptable pour relever un vocabulaire, inacceptable pour appuyer une affirmation empirique.

#### Suivi d'avancement

1.  \[DONE\] reporté le 2 septembre depuis le travail de l'arc

### \[DONE\] \[#A\] Les langages à discipline de ressource — Cyclone, Rust, Clean, Alms, Mercury — qu'ont-ils abandonné en route et pourquoi ?

    ARC: H | QUID: QH-5 | REF

TRANCHÉE le 3 septembre : MANQUE DE CORPUS CONFIRMÉ SUR UN INDEX PROPRE, et ce point compte. LA SONDE A ÉTÉ REFAITE APRÈS LE RÉEXPORT, qui a corrigé deux mille cinq cents titres de contenant. C'était la condition pour que l'absence soit crédible : une sonde par titre sur un index où les titres sont ceux des revues ne rend rien, et je l'avais pris pour une absence à d'autres endroits. LE RÉSULTAT EST LE MÊME ET IL EST DÉSORMAIS FIABLE. Cinq entrées répondent, toutes des travaux de THÉORIE qui mentionnent ces langages en passant — régions monadiques, polymorphisme de ressource, propriété linéaire. Aucune rétrospective, aucun retour d'expérience, aucun récit de ce qui a été abandonné. CE QUE LA QUESTION DEMANDAIT — ce qu'une discipline de ressource fait RENONCER, dit par ceux qui l'ont vécu — n'est pas dans la littérature académique, qui publie des systèmes et non des renoncements. C'est une lacune de LITTÉRATURE et non de fonds, et elle se déclare.

#### Suivi d'avancement

1.  \[DONE\] références à identifier

### \[DONE\] \[#A\] Les langages à trois couches ou à modes : y en a-t-il, et qu'en disent leurs auteurs ?

    ARC: H | QUID: QH-6 | REF: licataFibrationalFrameworkSubstructural2017, lorenzenOxidizingOCamlModal2024, liepeltSameCoeffectDifferent2026, ceulemansBiSikkelMultimodeLogical2025, hanukaevUnificationGradedSubstructural2026

IL Y EN A, ET MA CONCLUSION PRÉCÉDENTE ÉTAIT FAUSSE. J'avais écrit que le fonds portait la logique adjointe — la THÉORIE des modes — et rien sur des langages qui l'auraient implantée, et proposé à Anthea de tenir K7PL pour seul de son espèce. Le fonds en porte plusieurs, dont un en PRODUCTION. LE CADRE GÉNÉRAL D'ABORD, car il commande le reste. Un calcul des séquents paramétré par une THÉORIE DES MODES, où le contexte obéit aux propriétés structurelles ordinaires tandis qu'un terme tiré de la théorie des modes contraint la manière dont il peut être employé. Il exprime les produits et implications non associatifs, ordonnés, linéaires, affines, pertinents et cartésiens, les foncteurs, les (co)monades et les adjonctions, les variables n-linéaires et les implications groupées. ET L'ADMISSIBILITÉ DE LA COUPURE Y EST DÉMONTRÉE INDÉPENDAMMENT DE LA THÉORIE DES MODES, ce qui est le résultat le plus utile pour ce document : ce qui est démontré sur trois couches n'a pas à être redémontré si une quatrième s'ajoutait, pourvu qu'elle s'exprime comme un mode de la même théorie. LE LANGAGE EN PRODUCTION. OCaml doté de trois AXES DE MODES — affinité, unicité, localité — pour rendre sûres l'allocation sur la pile et la mise à jour en place d'immuables. Deux propriétés que K7PL doit regarder en face : les modes y sont pleinement RÉTROCOMPATIBLES avec le code existant, et ils sont ENTIÈREMENT INFÉRÉS. Les auteurs disent viser à porter à OCaml les bénéfices de Rust. LES AUTRES. Les grades sont entrés dans Haskell, Idris et Granule, selon DEUX LIGNÉES distinctes — celle où l'annotation est pervasive et porte sur les types de fonctions, et celle où elle passe par une modalité graduée ; K7PL appartient à la seconde, et le dire situe le document dans une taxonomie existante plutôt que dans un vide. Une théorie des types MULTIMODE est par ailleurs embarquée comme bibliothèque dans un assistant de preuve, avec extraction vers le métalangage. Et un système unifie le gradué et le substructurel en un seul, ce que le document connaissait déjà. CE QUI SÉPARE K7PL DE CES VOISINS, ET AUCUNE DES TROIS DIFFÉRENCES N'EST UN MÉRITE EN SOI. Ses modes ne sont pas trois axes d'une même dimension mais trois COUCHES d'un même calcul, chacune avec son algèbre de grades — différence structurelle. Ils sont DÉCLARÉS par un délimiteur et non inférés — arbitrage, dont le chapitre 5 dit le prix. Et ils CONSTITUENT le langage au lieu de s'ajouter à un langage existant — arbitrage aussi, et c'est celui qui coûte l'écosystème. PORTÉ au chapitre 3, en tête de la section du système gradué.

#### Suivi d'avancement

1.  \[DONE\] licataFibrationalFrameworkSubstructural2017

2.  \[DONE\] lorenzenOxidizingOCamlModal2024

3.  \[DONE\] liepeltSameCoeffectDifferent2026

### \[DONE\] \[#A\] Quel langage a réussi son BOOTSTRAP, et qu'est-ce que cela lui a coûté en conception ?

    ARC: H | QUID: QH-7 | REF

TRANCHÉE le 3 septembre : MÊME VERDICT ET MÊME MOTIF QUE LA PRÉCÉDENTE, sur un index désormais propre. LA SONDE REND UNE SEULE ENTRÉE, et elle porte sur les macros et l'expansion partielle, non sur l'amorçage d'un compilateur. Le fonds ne porte aucun récit d'amorçage réussi ni son coût de conception. ET LE MOT LUI-MÊME A DÉJÀ PIÉGÉ CE PROJET UNE FOIS : deux occurrences trouvées à l'arc H étaient des HOMONYMES — une technique de structure de données, non l'amorçage d'un compilateur. La sonde a donc été écrite sur le mécanisme et non sur le mot, et elle ne rend rien. CE QUE CELA LAISSE. Le chapitre 6 décrit un amorçage sans pouvoir s'appuyer sur un précédent documenté. Ce n'est pas une faute : c'est une position à assumer, et elle est de même nature que les postmortems de projets abandonnés — la littérature académique publie ce qui marche, et l'amorçage se raconte dans des billets et des listes de diffusion que ce fonds ne collecte pas.

#### Suivi d'avancement

1.  \[DONE\] références à identifier

### \[DONE\] \[#B\] Les langages nés d'une thèse : combien ont survécu, et qu'ont-ils fait de leur spécification ?

    ARC: H | QUID: QH-8 | REF: hoekstraCombinatorNdimensionalArray, hughesProgramSynthesisGraded2024

MANQUE DE CORPUS DÉCLARÉ, et il vaut mieux le dire que de forcer une réponse sur des sources qui ne portent pas la question. CE QUE LE FONDS A : des travaux ISSUS de thèses — une bibliothèque de tableaux en Smalltalk, la synthèse dirigée par les grades. Ce sont des sources primaires, non une étude du phénomène. CE QU'IL N'A PAS : une rétrospective sur le devenir des langages nés d'une thèse, ni sur ce qu'ils ont fait de leur spécification. La question porte sur une population, et le fonds n'en porte que des individus. CE QUE LES DEUX PIÈCES DONNENT QUAND MÊME, et ce n'est pas rien : elles montrent le passage d'une thèse à un artefact utilisable, et l'une porte la réserve qui convient — une mémoire de maîtrise s'emploie pour sa STRUCTURE et non comme autorité. PRIORITÉ BASSE ET ASSUMÉE. Le manque ne bloque ni un engagement ni un théorème : c'est un appui de conception, utile pour situer le projet et non pour établir ce qu'il démontre. Groupé avec les cinq autres manques de l'arc.

#### Suivi d'avancement

1.  \[DONE\] instruit ; manque de corpus déclaré, priorité basse

### \[DONE\] \[#B\] Les études contrôlées sur la sûreté mémoire : que mesurent-elles réellement ?

    ARC: H | QUID: QH-9 | REF: kirkhamFoundationsEmpiricalMemory2020

Elles mesurent moins qu'on ne croit, et le résultat le plus utile de l'arc est de dire POURQUOI. LES OBSERVATIONS QUI COMPTENT SONT EXTRÊMEMENT RARES ET DE NATURE PROBABILISTE. Une méta-étude des travaux antérieurs relève des résultats de FAIBLE REPRODUCTIBILITÉ et un emploi inefficace du temps de test. D'OÙ LA CONCLUSION, QUI EST PORTÉE AU CHAPITRE 6 : sans protocole de réglage des routines de sollicitation, l'absence d'observation ne distingue pas l'IMPOSSIBLE de l'IMPROBABLE. Une campagne non réglée ne donne pas une confiance faible — elle donne une confiance ILLUSOIRE, ce qui est pire.

#### Suivi d'avancement

1.  \[DONE\] reporté le 2 septembre depuis le travail de l'arc

### \[DONE\] \[#B\] Le ramasse-miettes contre la propriété : l'étude de Coblenz conclut que « l'essentiel du bénéfice vient de la SIMPLIFICATION ARCHITECTURALE ». Est-ce isolé ?

    ARC: H | QUID: QH-10 | REF: coblenzCanAdvancedType2020, coblenzGarbageCollectionMakes2022

La conclusion tient, et elle est défavorable au document — ce qui est la raison de la porter plutôt que de l'omettre. LA MESURE. Un essai contrôlé randomisé sur la propriété, les actifs et le typestate — le jeu de traits même de K7PL — trouve la condition à types avancés PLUS LENTE, à variance élevée, quatre participants sur dix n'ayant plus assez de leurs quatre heures pour se déclarer satisfaits contre un seul au témoin, et un abandon après une heure quinze. SA PORTÉE EST BORNÉE et il faut le dire aussi : dix participants par condition, quatorze analysés, tutoriel bref, langage évalué distinct. Mais AUCUNE MESURE FAVORABLE NE LUI FAIT PENDANT au fonds. CE QUE LE DOCUMENT PEUT ET NE PEUT PAS DIRE, désormais écrit au chapitre 5 : il peut invoquer ce que ses traits GARANTISSENT, non leur utilisabilité. L'omettre aurait été la faute que sa méthode bibliographique interdit.

#### Suivi d'avancement

1.  \[DONE\] reporté le 2 septembre depuis le travail de l'arc

### \[DONE\] \[#B\] Les migrations à grande échelle — COBOL vers Java, et autres — disent-elles quelque chose sur ce qui rend un langage adoptable ?

    ARC: H | QUID: QH-11 | REF: ciborowskaContemporaryCOBOLDevelopers2021, sneedMigratingCOBOLJava2010, mateosCOBOLSystemsMigration2019

LE MANQUE DÉCLARÉ ÉTAIT FAUX SUR CE POINT, et c'est la première chose à écrire. Il disait que le fonds porte la THÉORIE de ces sujets et non leur HISTOIRE. Le fonds porte en réalité une vingtaine de travaux sur la migration COBOL, dont un rapport industriel de migration vers Java. La sonde qui avait conclu au manque cherchait le NOM de la question et non son OBJET — c'est la faute des langages à modes, refaite. RÉPONSE À LA QUESTION POSÉE : PRESQUE RIEN, et il faut voir pourquoi. Les migrations documentées sont des travaux d'OUTILLAGE — réingénierie, conversion automatique, encapsulation derrière une interface, mesure d'antipatrons sur les interfaces engendrées. Elles décrivent comment on QUITTE un langage, jamais pourquoi on en ADOPTE un. Une migration ne se décide pas sur l'attrait de la cible mais sur le coût de rester, ce qui en fait un mauvais témoin de l'adoptabilité. CE QUE LE FONDS DONNE QUAND MÊME, et c'est le résultat utile. Une étude de 2021 sur les développeurs COBOL contemporains rapporte deux faits liés : une pénurie critique de main-d'œuvre à mesure que la génération en place part à la retraite, et une disponibilité publique limitée de ressources d'apprentissage qui met les entrants en difficulté sur les tâches de maintenance ordinaires. Ce que la migration ne dit pas de l'adoption, la démographie le dit de la SURVIE — un langage ne meurt pas de ses défauts techniques, il meurt de ne plus renouveler ses praticiens, et ce renouvellement dépend de ce qui est disponible pour apprendre. POUR K7PL, ET LA CONSÉQUENCE EST DÉSAGRÉABLE. Un langage à trois couches sur fondements catégoriels a par construction une voie d'entrée étroite. L'acquis du chapitre 1 qui fait des contrats de la couche 1 un facteur d'adoption vise le bon endroit, mais il vise le praticien DÉJÀ là ; ce que cette étude ajoute est que le facteur décisif se joue en amont, sur ce qu'un entrant peut trouver pour apprendre.

#### Suivi d'avancement

1.  \[DONE\] ciborowskaContemporaryCOBOLDevelopers2021

2.  \[DONE\] sneedMigratingCOBOLJava2010

3.  \[DONE\] mateosCOBOLSystemsMigration2019

### \[DONE\] \[#A\] Les enquêtes auprès des praticiens du code NON SÛR : où sont-ils le moins assurés ?

    ARC: H | QUID: QH-12 | REF: oliveiraWhatChallengesDevelopers2025, coblenzCanAdvancedType2020

La question demandait une enquête sur le code NON SÛR ; le fonds en porte une mieux ciblée, sur les barrières à l'adoption des langages À VÉRIFICATION INTÉGRÉE — c'est-à-dire la classe où K7PL se range. LA MÉTHODE EST DOUBLE, et c'est ce qui la rend utilisable : analyse par modélisation thématique des discussions de développeurs sur des forums publics, complétée d'une ENQUÊTE DÉCLARATIVE. Les deux ensemble disent ce que les praticiens font et ce qu'ils en disent, qui n'est jamais tout à fait la même chose. LES OBSTACLES RELEVÉS SONT DEUX, ET AUCUN N'EST THÉORIQUE : la COURBE D'APPRENTISSAGE abrupte, et des problèmes d'UTILISABILITÉ. Les recommandations qui en découlent portent sur l'interface des outils et sur ce qui accompagne le langage, non sur le langage lui-même. CE QUE CELA DIT À K7PL, ET C'EST UNE MISE EN GARDE PLUS QU'UN APPUI. Ce qui freine l'adoption de sa classe n'est pas ce qu'il démontre — c'est ce qu'il coûte à apprendre et ce que son outillage donne. Or ce document consacre sa substance au premier et renvoie le second au chapitre 6, qui décrit un pipeline sans l'avoir construit. Le déséquilibre est assumé ailleurs, sous la réserve de position ; il est ici MESURÉ. ET IL S'ACCORDE AVEC LA SEULE AUTRE MESURE DU FONDS sur le jeu de traits du document, qui trouve la condition à types avancés plus lente et à variance élevée. Deux études de méthodes différentes concluent au même endroit : le coût est à l'apprentissage.

#### Suivi d'avancement

1.  \[DONE\] oliveiraWhatChallengesDevelopers2025

### \[DONE\] \[#A\] Les rétrospectives d'auteurs — HOPL et équivalents — sur ce qu'ils REGRETTENT : y a-t-il un motif récurrent ?

    ARC: H | QUID: QH-13 | REF: hudakHistoryHaskellBeing2007, macqueenHistoryStandardML2020, hickeyHistoryClojure2020, symeEarlyHistory2020, appelCritiqueStandardML1993

Oui, et le motif est net : les rétrospectives regrettent moins des TRAITS que des ABSENCES DE FRONTIÈRE. Cinq sont au fonds, quatre de HOPL et une critique contemporaine. QUATRE ACQUIS EN SONT TIRÉS ET PORTÉS AU MANUSCRIT. Les postulats ferment des portes, et c'est leur fonction — « le plus grand bénéfice de la paresse n'est pas la paresse, mais qu'elle nous a gardés PURS ». Le grade dissout un tout-ou-rien que Haskell a atteint par accrétion. Le délimiteur-régime a son précédent industriel dans le bloc asynchrone de F#, ce qui est neuf chez K7PL étant qu'il annonce un GRADE. Et un langage à surface extensible par l'analyseur devient une ÎLE pour tout ce qui le lit sans l'exécuter. ET UNE RÉSERVE DE POSITION, la plus utile des cinq : trois questions se posent à toute proposition de langage — est-elle DÉMONTRABLE, est-elle IMPLANTABLE, est-elle UTILE — et un résultat sur l'une ne vaut pas argument sur les autres. Portée au chapitre 1.

#### Suivi d'avancement

1.  \[DONE\] reporté le 2 septembre depuis le travail de l'arc

### \[DONE\] \[#A\] Les postmortems de projets de langage abandonnés : qu'est-ce qui tue un langage ?

    ARC: H | QUID: QH-14 | REF: endresEarlyLanguageCompiler2013, ciborowskaContemporaryCOBOLDevelopers2021

UNE PIÈCE, ET C'EST UNE RÉTROSPECTION PERSONNELLE. Endres raconte les développements de langages et de compilateurs des laboratoires européens d'IBM jusque vers 1970, Algol 60 et PL/I au premier plan, et il donne la cause de leur arrêt : à la suite de la décision de dégroupage de 1969, l'activité sur les langages y a considérablement diminué et d'autres travaux ont été engagés. CE QUE CE CAS ÉTABLIT, ET C'EST TOUT CE QU'IL ÉTABLIT. Un programme de langage peut s'arrêter sans qu'aucun défaut du langage soit en cause : une décision commerciale sur la facturation des logiciels a suffi. La cause n'est pas dans l'objet, elle est dans ce qui le finance. CE QU'IL N'ÉTABLIT PAS, et il faut le dire au lieu de généraliser. Un cas ne fait pas une réponse à « qu'est-ce qui tue un langage ». La question porte sur une POPULATION de projets abandonnés ; le fonds n'en porte qu'un récit, à la première personne, par un participant. C'est une source primaire sur un épisode, non une étude du phénomène. UNE SECONDE CAUSE, DOCUMENTÉE AILLEURS ET DE NATURE DIFFÉRENTE. L'étude de 2021 sur les développeurs COBOL décrit une mort par tarissement plutôt que par décision : la génération en place part à la retraite, les ressources publiques d'apprentissage sont rares, les entrants peinent sur les tâches ordinaires. Le langage n'est pas arrêté, il cesse d'être praticable. DEUX CAUSES, DEUX TEMPORALITÉS, ET AUCUNE N'EST TECHNIQUE. L'une est brutale et vient du financeur ; l'autre est lente et vient de la démographie. Que ni l'une ni l'autre ne relève des propriétés du langage est le seul énoncé général que ces deux pièces autorisent. MANQUE DE CORPUS MAINTENU pour l'étude de population. Priorité A REQUALIFIÉE EN APPUI DE CONCEPTION : la question n'engage aucun théorème ni aucune obligation du corps, elle sert à situer le projet.

#### Suivi d'avancement

1.  \[DONE\] endresEarlyLanguageCompiler2013

2.  \[DONE\] ciborowskaContemporaryCOBOLDevelopers2021

### \[DONE\] \[#B\] La conception de langage interdisciplinaire : que dit la littérature sur le fait de mêler théorie et ergonomie, et sur ses échecs ?

    ARC: H | QUID: QH-15 | REF: coblenzInterdisciplinaryProgrammingLanguage2018

La littérature existe et elle est explicite : mêler théorie des types et méthode empirique n'est pas une commodité mais une discipline, avec ses conditions. CE QUE CELA VAUT POUR CE PROJET est moins une source qu'une CONTRAINTE DE MÉTHODE, et elle a été appliquée : la seule mesure du fonds portant sur le jeu de traits de K7PL lui est défavorable, et elle est écrite avec sa portée bornée plutôt qu'omise. UNE RÈGLE EN EST TIRÉE, qui vaut de tout l'arc : une mesure défavorable se cite dans le même paragraphe que la thèse qu'elle vise, non en note. La citer ailleurs serait la neutraliser sans la contredire.

#### Suivi d'avancement

1.  \[DONE\] reporté le 2 septembre depuis le travail de l'arc

### \[DONE\] \[#A\] Les huit phases du chapitre 6 ont-elles un précédent dans la littérature, et sous quel découpage ?

    ARC: I | QUID: QI-1 | REF: sarkarEDUCATIONALPEARLNanopass2005, pattersonNext700Compiler

Il en a un, et il ne contredit pas le découpage : il en dit la nature. La source critique le compilateur structuré en un PETIT NOMBRE DE PASSES MONOLITHIQUES — difficile à comprendre, difficile à maintenir, où même un développeur expérimenté introduit des défauts subtils en modifiant une passe — et recommande une collection de passes TRÈS FINES n'accomplissant chacune QU'UNE SEULE TÂCHE, structure qui ALIGNE L'IMPLANTATION SUR L'ORGANISATION LOGIQUE. Or les huit phases du chapitre ne sont pas des passes d'implantation mais des ORDRES DE VÉRIFICATION, chacun supposant le précédent acquis. Huit phases logiques et beaucoup plus de passes d'implantation ne sont donc pas en tension : c'est exactement la configuration recommandée. Et cela rejoint l'objectif de compositionnalité de la correction — une passe qui n'accomplit qu'une tâche se vérifie isolément — deux sources recommandant la même chose pour deux raisons distinctes.

#### Suivi d'avancement

1.  \[DONE\] sarkarEDUCATIONALPEARLNanopass2005

2.  \[DONE\] pattersonNext700Compiler

### \[DONE\] \[#A\] La Phase 8 purge les blocs de spécification. Cette purge est-elle CORRECTE au sens de la non-interférence entre phases, et le fonds donne-t-il la preuve type ?

    ARC: I | QUID: QI-2 | REF: THEOCHARIS, erikssonGradedModalType2025

Elle l'est, et la forme de sa correction a été trouvée à l'arc B sans qu'on la rapporte ici. L'effacement y est une DISTINCTION DE PHASE, encodée comme une proposition qui peut figurer dans un contexte, et la propriété qui en fait la correction est une CONSERVATIVITÉ, établie DANS LES DEUX PHASES : ce qu'on peut prouver en présence de l'effacement, on pouvait le prouver sans lui, et réciproquement dans la phase effacée. C'est exactement ce qu'une purge doit garantir — que retirer les blocs de spécification ne change ni ce que le programme fait ni ce qu'on peut en établir. Le fonds porte donc la propriété ; ce qui manque au document est de l'énoncer pour SA purge, et l'arc B l'a déjà porté au programme.

#### Suivi d'avancement

1.  \[DONE\] THEOCHARIS

2.  \[DONE\] erikssonGradedModalType2025

### \[DONE\] \[#A\] La compilation reproductible est un ENGAGEMENT « visé, non garanti ». Que faudrait-il pour le garantir, et quel est le coût ?

    ARC: I | QUID: QI-3 | REF

Le fonds ne porte RIEN sur la compilation reproductible : la sonde, conduite sur l'enregistrement complet, ne rend aucune pièce. L'engagement reste donc ce que le document en dit — visé, non garanti — et l'arc ne peut ni le tenir ni le chiffrer. Consigné comme manque de corpus.

#### Suivi d'avancement

1.  \[DONE\] sonde négative, conduite sur l'enregistrement complet

### \[DONE\] \[#A\] L'isomorphisme mémoire avec le format de journalisation est assuré à la compilation. Comment se vérifie-t-il ?

    ARC: I | QUID: QI-4 | REF: SpecificationsApacheArrow, CAPNPROTO-SPEC

La vérification est un contrôle de DISPOSITION, et le document en donne la forme sans en donner la procédure : le théorème d'isomorphisme mémoire énonce que trois dispositions coïncident bit à bit sur les scalaires de largeur fixe, et cesse de valoir dès que l'élément est une structure. Un tel énoncé se vérifie mécaniquement par comparaison de tailles, d'alignements et d'ordres de champs, à partir des spécifications des formats. Ce que le fonds ne porte pas est ces spécifications elles-mêmes ni aucune mesure : la sonde, conduite sur l'enregistrement complet, ne rend rien sur les formats colonnaires. Maintenue en cours pour ce motif, et le manque est consigné. TRANCHÉE le 3 septembre PAR LA LECTURE DES DEUX SPÉCIFICATIONS, qui sont désormais citables. LA VÉRIFICATION EST UNE COMPARAISON DE TROIS ENTIERS PAR TYPE, et c'est ce qui la rend décidable à la compilation. La coïncidence bit à bit n'est pas une propriété à prouver au cas par cas : c'est une égalité entre trois FORMULES DE DISPOSITION, chacune donnée par une spécification normative. Trois nombres la déterminent — la largeur de créneau, l'alignement exigé, l'ordre des champs. LES DEUX SPÉCIFICATIONS PUBLIENT CES TROIS NOMBRES. Arrow recommande un alignement sur huit ou soixante-quatre octets et l'IMPOSE lorsque la donnée est sérialisée pour une communication entre processus. Cap'n Proto aligne tout objet sur des mots de huit octets et chaque primitif sur un multiple de sa propre taille. Le vérificateur n'a donc rien à inspecter d'une représentation : il compare des entiers que les documents lui donnent. PORTÉ au chapitre 4, dans l'esquisse du théorème d'isomorphisme.

#### Suivi d'avancement

1.  \[DONE\] établi sur le document, sonde de corpus négative

### \[DONE\] \[#A\] La résorption statique de l'itération par *inlining* : quelle borne, et vérifiée comment ?

    ARC: I | QUID: QI-5 | REF: appelShrinkingLambdaExpressions1997

La borne ne s'obtient pas par un BUDGET mais par une RESTRICTION DE LA RÈGLE, et le grade la décide gratuitement. Pour éviter les optimisations spéculatives qui font exploser la taille du code, il suffit de n'employer que des règles RÉTRÉCISSANTES, garanties de rendre le programme plus petit : élimination de variable morte, propagation de constante, et une règle bêta restreinte qui n'intègre que les fonctions APPELÉES UNE SEULE FOIS. Sur ce fragment la mesure décroît par construction, la normalisation est en temps LINÉAIRE, et une preuve de CONFLUENCE montre que le choix de l'algorithme n'affecte pas la qualité du code final — ce qui retire au chapitre l'obligation de justifier son ordre d'intégration. Or appelée une seule fois est exactement ce que la composante d'usage du grade déclare : là où un compilateur ordinaire a besoin d'une analyse, le jugement gradué le PORTE. Le budget que le chapitre prescrit ne serait nécessaire qu'en dehors de ce fragment.

#### Suivi d'avancement

1.  \[DONE\] appelShrinkingLambdaExpressions1997

### \[DONE\] \[#A\] Quelle représentation intermédiaire porte une discipline de RESSOURCE sans la perdre ?

    ARC: I | QUID: QI-6 | REF: leissaMimIRExtensibleTypeSafe2025, kovachIndexedStreamsFormal2023

Une représentation intermédiaire fondée sur le lambda-calcul et les TYPES DÉPENDANTS, extensible à n'importe quel niveau par des greffons qui prennent en charge l'optimisation et l'abaissement de leurs propres axiomes. Un système de types dépendant porte un grade sans qu'il faille écrire un dialecte pour cela. Trois études de cas atteignent les performances de l'état de l'art, dont un greffon de filtrage par expressions régulières — précisément l'objet que le chapitre 4 abaisse en automate.

#### Suivi d'avancement

1.  \[DONE\] leissaMimIRExtensibleTypeSafe2025

2.  \[DONE\] kovachIndexedStreamsFormal2023

### \[DONE\] \[#A\] Les grades survivent-ils à l'abaissement, ou sont-ils effacés comme les preuves ?

    ARC: I | QUID: QI-7 | REF: pattersonNext700Compiler, fitzgibbonsRichWasmBringingSafe2024

Ils survivent si la traduction le veut, et ce n'est pas une fatalité mais une propriété du compilateur. Un compilateur PRÉSERVANT LES TYPES envoie un terme de type donné sur un terme d'un TYPE DE TRADUCTION ; la question devient donc si ce type de traduction porte le grade. Et une cible où c'est possible existe déjà : une extension typée de WebAssembly où le QUALIFICATEUR DE LINÉARITÉ est un paramètre de type, sur lequel une fonction peut être polymorphe au même titre que sur les emplacements et les tailles. L'abaissement peut donc conserver la discipline de ressource, et le choix de l'effacer serait un choix.

#### Suivi d'avancement

1.  \[DONE\] pattersonNext700Compiler

2.  \[DONE\] fitzgibbonsRichWasmBringingSafe2024

### \[DONE\] \[#A\] MLIR et ses dialectes : existe-t-il un dialecte pour les types linéaires, et sinon, que coûte d'en écrire un ?

    ARC: I | QUID: QI-8 | REF: leissaMimIRExtensibleTypeSafe2025, fitzgibbonsRichWasmBringingSafe2024

La question se déplace avant de se répondre. Écrire un dialecte de types linéaires pour une infrastructure dont le système de types est faible coûte cher et n'est pas la seule voie : le fonds porte une représentation intermédiaire DÉPENDAMMENT TYPÉE et extensible par greffons, et une extension de la cible où la linéarité est déjà un paramètre de type. Le document a choisi son infrastructure sans que le fonds porte la comparaison ; c'est cette comparaison qui manque, non un dialecte.

#### Suivi d'avancement

1.  \[DONE\] leissaMimIRExtensibleTypeSafe2025

2.  \[DONE\] fitzgibbonsRichWasmBringingSafe2024

### \[DONE\] \[#A\] Le comptage de références comme interprétation calculatoire de la logique linéaire : est-ce la voie d'abaissement de la couche 1 ?

    ARC: I | QUID: QI-9 | REF: chirimarReferenceCountingComputational1996, reinkingPerceusGarbageFree2021

C'est une voie démontrée et non conjecturée : la relation entre la correction du typage linéaire et la correction d'une interprétation par comptage de références est établie précisément, au niveau d'abstraction exact dont un abaissement a besoin — assez bas pour exprimer le partage et la copie, assez haut pour ne rien dire de la disposition mémoire. La source porte en outre un AVERTISSEMENT qui vise une propriété rencontrée à deux autres arcs : la prétention que les valeurs de type linéaire ont exactement UN POINTEUR est raisonnable pour l'appel par NOM et moins raisonnable pour l'appel par NÉCESSITÉ. Or la couche 2 porte des flux paresseux, et le document ne dit pas sous quelle stratégie il revendique cette propriété.

#### Suivi d'avancement

1.  \[DONE\] chirimarReferenceCountingComputational1996

2.  \[DONE\] reinkingPerceusGarbageFree2021

### \[DONE\] \[#A\] La correction d'un abaissement se démontre-t-elle par simulation, par relation logique, ou par traduction certifiée ?

    ARC: I | QUID: QI-10 | REF: pattersonNext700Compiler

Les trois voies existent et elles ne visent pas la même chose, ce qui est le renseignement. La PRÉSERVATION DU COMPORTEMENT dit que le programme compilé fait ce que le source faisait. La PLEINE ABSTRACTION dit davantage — deux composants source contextuellement équivalents se compilent en deux composants cibles contextuellement équivalents — et c'est elle qui garantit que les abstractions du langage source ne sont pas violées après compilation vers une cible de bas niveau. Le chapitre 6 énonce une fidélité sans dire laquelle des deux il revendique, alors qu'elles ne coûtent pas la même chose et que la seconde est celle qu'il faut quand le code compilé côtoiera du code étranger — ce qui est le cas d'un unikernel à passerelle.

#### Suivi d'avancement

1.  \[DONE\] pattersonNext700Compiler

### \[DONE\] \[#A\] Les compilateurs certifiés — CompCert et sa descendance — quelle part de leur méthode transporte à un langage à grades ?

    ARC: I | QUID: QI-11 | REF: pattersonNext700Compiler, wangCompCertELFVerifiedSeparate2020

La part qui transporte est identifiée et le fonds est riche — vingt-sept pièces de cette lignée, dont la compilation séparée vérifiée jusqu'au format d'exécutable, la préservation d'optimisations par simulations de blocs, et l'extraction vérifiée. Ce qui transporte à coup sûr est la FORME de l'énoncé : préservation du comportement ou pleine abstraction, et le compilateur préservant les types comme moyen de faire survivre une information de typage. Ce qui reste à établir est le point propre au grade : aucune de ces vérifications ne porte sur un langage dont le jugement compte les usages, et la question de savoir si leur méthode de simulation résiste à une composante quantitative n'a pas été instruite. Maintenue en cours : c'est un dépouillage à conduire, non une source à trouver. TRANCHÉE le 3 septembre PAR LA LECTURE, et ce qui transporte est plus précis qu'une forme d'énoncé. CE QUI TRANSPORTE, ET C'EST TROIS CHOSES ET NON UNE. La FORME de l'énoncé, d'abord : la compilation séparée vérifiée repose sur la COMMUTATIVITÉ entre liage et compilation — si des modules se compilent séparément et se lient à la source, les compilés se lient à la cible pour donner la compilation du lié. La DIFFICULTÉ, ensuite, et elle est nommée : deux vues du liage ne se recouvrent pas. À l'étage abstrait un programme est une application partielle des identifiants vers les définitions, donc le lieur est INSENSIBLE À L'ORDRE et réarrange à sa guise ; à l'étage concret les définitions sont fondues en sections atomiques suivant un ordre particulier, concaténées comme des boîtes noires, et l'ordre décide du résultat. La commutativité CASSE à la transition. LA MÉTHODE DE PONTAGE, enfin, et c'est le vrai acquis. La voie naïve — donner à l'étage abstrait la vue concrète — a deux prix que les auteurs chiffrent : le liage de TOUS les étages se trouve contraint par le format de bas niveau, et il faut retoucher lourdement le cadre et ses preuves. La voie légère pose une ÉQUIVALENCE SYNTAXIQUE entre programmes et démontre qu'elle commute avec les deux sortes de liage, SANS toucher à aucune preuve existante. ET CE QUE K7PL EN TIRE DÉPASSE LE LIAGE. L'écart entre un étage insensible à l'ordre et un étage qui en dépend, il le rencontre DEUX fois : entre l'espace de noms — sous-catégorie large, sans ordre — et les sections de l'abaissement ; et entre un contexte qui est une application finie et le contexte ORDONNÉ qu'une discipline d'échange restreint imposerait. La leçon est la même aux deux endroits : ne pas concrétiser l'étage abstrait, mais poser une équivalence et démontrer qu'elle commute des deux côtés. CE QUI NE TRANSPORTE PAS, ET IL FAUT LE DIRE. Aucune de ces vérifications ne porte sur un langage dont le jugement COMPTE les usages. Ce qui transporte est la forme de l'énoncé et la méthode de pontage, non un résultat sur les grades — écrire l'inverse serait faux. PORTÉ au chapitre 6.

#### Suivi d'avancement

1.  \[DONE\] pattersonNext700Compiler

2.  \[DONE\] wangCompCertELFVerifiedSeparate2020

### \[DONE\] \[#A\] La compilation dirigée par les types des effets à rangées : comment `perform` et `handle` compilent-ils réellement ?

    ARC: I | QUID: QI-12 | REF: schusterCompilingEffectHandlers2020, xieGeneralizedEvidencePassing2021

Par le STYLE À PASSAGE DE CAPACITÉS combiné au passage de continuations ITÉRÉ, et c'est l'idiome que le document a déjà, une capacité de couche 1 y étant un canal linéaire. Les auteurs mesurent des accélérations significatives sur les langages existants à gestionnaires ou à opérateurs de contrôle, et leur technique est générale : elle engendre du code dans tout langage à fonctions de première classe, donc sans hypothèse sur la cible.

#### Suivi d'avancement

1.  \[DONE\] schusterCompilingEffectHandlers2020

2.  \[DONE\] xieGeneralizedEvidencePassing2021

### \[DONE\] \[#A\] Les gestionnaires d'effets compilés en coroutines, ou en CPS : quel est le coût mesuré de chaque voie ?

    ARC: I | QUID: QI-13 | REF: schusterCompilingEffectHandlers2020

La question du coût mesuré reçoit une réponse meilleure que des mesures : un SOUS-ENSEMBLE À COÛT NUL, caractérisé par le TYPE. Les auteurs raffinent leur langage par un système de types plus restrictif, donnent une traduction DIRIGÉE PAR LES TYPES qui insère des annotations d'ÉTAGEMENT, et DÉMONTRENT qu'aucune abstraction ni application liée aux gestionnaires ne subsiste dans le programme traduit. C'est la méthode du document appliquée à la compilation — la garantie portée par le type, non espérée de l'optimiseur — et c'est ce que le postulat d'autonomie physique réclame. Convergence à noter avec l'arc E : Kovács élimine les fermetures par étagement dans une théorie à deux niveaux, Schuster élimine les gestionnaires par étagement dans un type raffiné ; le document a un second niveau, la Phase 0, et ne le revendique pas.

#### Suivi d'avancement

1.  \[DONE\] schusterCompilingEffectHandlers2020

### \[DONE\] \[#A\] La défonctionnalisation est annoncée comme « sémantiquement transparente par construction » puisqu'elle est un isomorphisme naturel. Cette affirmation tient-elle en présence d'effets ?

    ARC: I | QUID: QI-14 | REF: brandonBetterDefunctionalizationLambda2023

La transparence est acquise et la qualité ne l'est pas ; le chapitre en fait un seul énoncé alors que ce sont deux. Que la défonctionnalisation soit un isomorphisme naturel garantit la transparence de la TRANSFORMATION. Mais son RÉSULTAT dépend d'un choix que l'isomorphisme ne détermine pas : l'UNITÉ DE SPÉCIALISATION. Selon qu'on spécialise par définition de plus haut niveau ou autrement, la même transformation rend un code de premier ordre différent — une fonction d'ordre supérieur employée avec deux arguments fonctionnels distincts se spécialisant en deux fonctions distinctes. Le chapitre peut donc garder son argument de transparence, à condition de ne plus en tirer que le résultat serait bon.

#### Suivi d'avancement

1.  \[DONE\] brandonBetterDefunctionalizationLambda2023

### \[DONE\] \[#A\] La transposition de disposition est en `O(n)` et bornée. Le fonds donne-t-il des mesures pour des cas comparables — Arrow, Cap'n Proto, SBE ?

    ARC: I | QUID: QI-15 | REF: SpecificationsApacheArrow, CAPNPROTO-SPEC, fixTradingCommunitySBE2020

Réponse CORRIGÉE. J'avais conclu que le fonds ne portait ni les spécifications ni aucune mesure ; les trois spécifications sont au corpus avec leur PDF, dans la section des documents segmentés que la sonde n'avait pas ouverte. Ce qui reste vrai est qu'aucune MESURE de transposition n'y figure, et que la borne linéaire annoncée est une conséquence de la forme de l'opération plutôt qu'un résultat sourcé. Maintenue en cours : les spécifications sont là et le dépouillage reste à faire. NON, ET LA RÉPONSE NÉGATIVE EST MEILLEURE QUE CE QUE LA QUESTION CHERCHAIT. AUCUNE DES SPÉCIFICATIONS NE PUBLIE DE MESURE DE TRANSPOSITION. La lecture est faite et le constat est net : ce sont des documents de FORMAT, qui définissent des dispositions et non des performances. LA BORNE LINÉAIRE N'EN A PAS BESOIN, et c'est le point. Elle est une conséquence de la FORME de l'opération — lire n créneaux, en écrire n — et non un résultat expérimental. La présenter comme sourcée serait emprunter à ces documents une autorité qu'ils ne revendiquent pas. CE QU'ILS DONNENT À LA PLACE EST UN MOTIF DE CONCEPTION CHIFFRÉ, et il vaut d'être rapporté comme tel. Cap'n Proto refuse d'encoder une liste de structures comme une liste de pointeurs parce que cela coûterait un pointeur de plus PAR ÉLÉMENT et serait moins favorable au cache. C'est une justification de disposition, non une mesure de transposition, et la distinction est écrite au chapitre 4. LE MANQUE DE CORPUS QUI PORTAIT CETTE QUESTION EST DONC UNE LACUNE DE LITTÉRATURE : il n'existe pas de mesure à trouver, parce que ce n'est pas ce que ces documents mesurent.

#### Suivi d'avancement

1.  \[DONE\] SEG-arrowArrowColumnarFormat2024

2.  \[DONE\] SEG-vardaProtoDocumentationSchema2024

### \[DONE\] \[#A\] Le zéro-copie « vaut sur les scalaires et se paie sur les structures ». Cette frontière est-elle celle que la littérature des formats constate ?

    ARC: I | QUID: QI-16 | REF: SpecificationsApacheArrow, CAPNPROTO-SPEC

Réponse CORRIGÉE, même motif. La frontière que le théorème trace se démontre sur les définitions des formats — dès que l'élément cesse d'être un scalaire, l'un décompose la donnée en un tampon PAR CHAMP quand l'autre impose une liste composite où les champs d'un même élément sont ADJACENTS — et ces définitions sont au corpus, non hors de lui. Il devient donc possible de vérifier que la frontière est bien celle qu'elles tracent, ce que je disais impossible. Maintenue en cours pour la durée du dépouillage. OUI, ET LES DEUX SPÉCIFICATIONS LE DISENT DANS LEURS PROPRES TERMES. La frontière que le théorème trace est exactement celle que les définitions de format tracent. CÔTÉ SCALAIRE, LA COÏNCIDENCE EST LITTÉRALE. Un tableau primitif Arrow est « un unique tampon de mémoire CONTIGU dont la taille totale vaut au moins la largeur de créneau multipliée par la longueur du tableau » ; une liste primitive Cap'n Proto est « serrée », ses éléments empaquetés les uns contre les autres. L'élément d'indice i est au décalage i fois la largeur dans les deux cas. ET LE BITMAP DE VALIDITÉ S'OMET, ce que la spécification autorise en toutes lettres : « les tableaux dont le compte de nuls vaut zéro PEUVENT choisir de ne pas allouer le bitmap de validité ». Il est par ailleurs « alloué de façon contiguë mais n'a pas besoin d'être adjacent en mémoire au tampon de valeurs » — les deux conditions du théorème, à la lettre. CÔTÉ STRUCTURE, LA DIVERGENCE EST TOUT AUSSI EXPLICITE, ET C'EST LE POINT DE LA QUESTION. Arrow : « physiquement, un tableau de structures a un tableau enfant PAR CHAMP ; les tableaux enfants sont INDÉPENDANTS et n'ont pas besoin d'être adjacents en mémoire ». Cap'n Proto impose l'inverse : une liste de structures s'encode en composite — un mot d'étiquette suivi des structures contiguës — et les auteurs disent pourquoi ils refusent la liste de pointeurs, qui coûterait un pointeur par élément et serait moins favorable au cache. LA FRONTIÈRE EST DONC CELLE QUE LA LITTÉRATURE DES FORMATS CONSTATE, et non une commodité du document. Dès que l'élément cesse d'être un scalaire, l'un décompose par CHAMP et l'autre groupe par ÉLÉMENT : ce sont deux dispositions transposées l'une de l'autre, et aucune transposition n'est gratuite.

#### Suivi d'avancement

1.  \[DONE\] SEG-arrowArrowColumnarFormat2024

2.  \[DONE\] SEG-vardaProtoDocumentationSchema2024

### \[DONE\] \[#A\] L'allocation en `O(1)` comme norme : quelles structures de données la respectent réellement, et lesquelles K7PL doit-il exclure ?

    ARC: I | QUID: QI-17 | REF: brodalOptimalPurelyFunctional1996, okasakiPurelyFunctionalData

Le critère n'est pas l'allocation en temps constant, c'est le PIRE CAS, et cette précision change la liste. Une borne AMORTIE dissimule un coût dans la distribution — une opération peut coûter cher pourvu que la moyenne tienne — quand une borne pire cas ne dissimule rien. Le postulat d'autonomie physique interdisant de dissimuler un coût, la bibliothèque doit retenir les structures à bornes PIRE CAS et écarter celles dont les bonnes bornes sont amorties, ce qui exclut une part notable des structures purement fonctionnelles usuelles, dont plusieurs des plus élégantes. Ce critère est plus fin que celui de la question et il est décidable sur chaque structure.

#### Suivi d'avancement

1.  \[DONE\] brodalOptimalPurelyFunctional1996

2.  \[DONE\] okasakiPurelyFunctionalData

### \[DONE\] \[#A\] Les files de priorité purement fonctionnelles et autres structures optimales : lesquelles sont compatibles avec P3 ?

    ARC: I | QUID: QI-18 | REF: brodalOptimalPurelyFunctional1996

Celles dont les bornes sont PIRE CAS, et pour la file de priorité l'optimum est atteint purement fonctionnellement : recherche du minimum, insertion et fusion en temps pire cas CONSTANT, suppression du minimum en temps pire cas logarithmique — bornes asymptotiquement optimales parmi les files fondées sur la comparaison. La construction se dérive des files binomiales en trois pas, et le troisième mérite d'être noté pour l'architecture : autoriser une file à en CONTENIR d'autres, emboîtement structurel qui ne coûte rien asymptotiquement. Le critère n'oblige donc pas à renoncer à la structure, seulement à en choisir la bonne réalisation.

#### Suivi d'avancement

1.  \[DONE\] brodalOptimalPurelyFunctional1996

### \[DONE\] \[#A\] Le WCET et le modèle matériel : l'engagement G-06 attend un modèle. Le fonds en donne-t-il un utilisable ?

    ARC: I | QUID: QI-19 | REF

Le fonds ne porte RIEN sur le temps d'exécution au pire cas ni sur les modèles matériels qui le fondent : la sonde ne rend aucune pièce. Le point de contrôle G-06 attend donc un modèle que le corpus n'a pas, et l'arc F a par ailleurs établi que la voie empirique qui s'y substituerait donne une confiance illusoire sans protocole réglé. Consigné comme manque de corpus, et c'est le plus sérieux de l'arc.

#### Suivi d'avancement

1.  \[DONE\] sonde négative, conduite sur l'enregistrement complet

### \[DONE\] \[#A\] Quel est le SOUS-ENSEMBLE minimal de K7PL dans lequel écrire son compilateur ?

    ARC: I | QUID: QI-20 | REF

La réponse se lit sur le document et elle est plus nette qu'attendu. Un compilateur est un programme qui lit une entrée non bornée, maintient des tables, et itère jusqu'à un point fixe ; il ne peut donc pas vivre en couche 3, qui interdit la récursion générale et n'a que le pli sur un plus petit point fixe. Il vit en COUCHE 2, dont le point fixe déductif est précisément un opérateur total sur les treillis de hauteur finie et dont les flux portent l'itération. Le sous-ensemble minimal est donc la couche 2 avec l'opérateur de point fixe, les effets d'entrée-sortie confinés à la couche 1 par capacités, et la couche 3 pour les parties qui terminent — le filtrage, les plis sur l'arbre syntaxique. Ce n'est pas un sous-ensemble à définir mais une répartition à écrire.

#### Suivi d'avancement

1.  \[DONE\] établi sur le document, sonde de corpus négative

### \[DONE\] \[#A\] Un langage sans récursion générale peut-il héberger son propre compilateur ?

    ARC: I | QUID: QI-21 | REF

Oui, et le document en porte déjà les trois moyens sans les avoir réunis pour cette question. Le pli dépendamment typé termine par un indice décroissant, ce qui couvre tout parcours d'arbre syntaxique. Le point fixe déductif est TOTAL sur les treillis de hauteur finie, ce qui couvre les analyses par itération jusqu'à saturation — inférence, propagation, résolution de contraintes — qui sont l'essentiel du travail d'un compilateur. Et les flux coinductifs couvrent la lecture d'une entrée non bornée par productivité plutôt que par terminaison. Ce qu'un compilateur fait et qui ne rentre dans aucun des trois n'a pas été identifié, et l'établir serait le contenu d'une preuve plutôt que d'une lecture.

#### Suivi d'avancement

1.  \[DONE\] établi sur le document, sonde de corpus négative

### \[DONE\] \[#A\] L'amorçage par un interprète de référence : la fidélité de cet interprète est un ENGAGEMENT du document — « une voie désignée, non parcourue ». Que faut-il pour la parcourir ?

    ARC: I | QUID: QI-22 | REF: wattWasmRefisabelleVerifiedMonadic2023

L'engagement est tenable, il a été tenu ailleurs pour exactement cet usage, et son prix est chiffré. Le chapitre reconnaît que son interprète de référence est SUPPOSÉ sémantiquement correct par construction, sans preuve le reliant à la sémantique catégorique, et nomme cela une hypothèse de confiance. La source présente le même objet — un interprète de référence servant d'oracle à un testeur — mais ENTIÈREMENT VÉRIFIÉ, et adopté dans l'industrie à ce titre. L'écart entre l'hypothèse et la preuve vaut environ cinq mille cinq cents lignes, plus deux mille cinq cents pour les extensions de sémantique. Et le dispositif est MONADIQUE, ce qui n'est pas un détail : un interprète monadique sépare la structure du calcul de l'effet, donc c'est la forme la plus proche d'un noyau par poussée de valeur à effets algébriques, et celle où la preuve serait la plus courte.

#### Suivi d'avancement

1.  \[DONE\] wattWasmRefisabelleVerifiedMonadic2023

### \[DONE\] \[#A\] Les descripteurs d'exécutable écrits dans le langage lui-même — la voie de Lone Lisp — suppriment-ils vraiment le besoin d'un langage de configuration ?

    ARC: I | QUID: QI-23 | REF: wangCompCertELFVerifiedSeparate2020

La pièce nommée dans la question n'est pas au fonds, et la sonde sur l'enregistrement complet ne la rend pas. Ce que le fonds porte est mieux pour la question de fond : la compilation séparée VÉRIFIÉE jusqu'au format d'exécutable, ce qui établit que la chaîne peut être démontrée correcte jusqu'au fichier objet — donc que la question n'est pas de savoir si un éditeur de liens externe est évitable, mais ce que coûte de le vérifier ou de le remplacer. Maintenue en cours : la lecture reste à conduire. TRANCHÉE le 3 septembre, ET LA QUESTION SE RETOURNE. ELLE DEMANDAIT SI ÉCRIRE LES DESCRIPTEURS DANS LE LANGAGE SUPPRIME LE BESOIN D'UN LANGAGE DE CONFIGURATION. La réponse est NON, et le motif est structurel plutôt que contingent : ce n'est pas le langage de configuration qui fait la difficulté, c'est la SENSIBILITÉ À L'ORDRE du format concret. CE QUE LA LECTURE ÉTABLIT. Un lieur d'objets fond les définitions en sections atomiques suivant un ordre particulier et les concatène comme des boîtes noires ; l'ordre décide du résultat. Un étage abstrait, lui, voit une application partielle des identifiants vers les définitions et réarrange à sa guise. Écrire les descripteurs dans le langage ne fait pas disparaître cet écart : il le DÉPLACE à l'intérieur du langage, où il faudra encore le démontrer. ET LA VOIE NAÏVE EST CELLE QUE LA QUESTION SUGGÉRAIT SANS LE SAVOIR. Donner à l'étage abstrait la vue concrète rend la commutativité évidente — et coûte deux choses que les auteurs nomment : le liage de tous les étages contraint par le format de bas niveau, et une retouche lourde du cadre et de ses preuves. C'est exactement ce qu'un descripteur écrit dans le langage impose si le langage doit en porter l'ordre. LA VOIE ÉCONOME EST L'AUTRE, et elle vaut réponse : garder l'étage abstrait SANS ordre, et ponter par une équivalence syntaxique dont on démontre qu'elle commute avec les deux liages. CE QUI RESTE VRAI DE L'INTUITION DE DÉPART : la chaîne PEUT être démontrée correcte jusqu'au fichier objet, cela a été fait. La question n'était donc pas de savoir si un éditeur de liens externe est évitable, mais ce que coûte de le vérifier ou de le remplacer — et le coût est chiffré.

#### Suivi d'avancement

1.  \[DONE\] wangCompCertELFVerifiedSeparate2020

### \[DONE\] \[#A\] L'interface avec un OS étranger se fait par contrats de couche 1. Quels précédents de FFI typée linéairement le fonds porte-t-il ?

    ARC: I | QUID: QI-24 | REF: vanstrydonckLinearCapabilitiesFully2019, fitzgibbonsRichWasmBringingSafe2024

Le fonds en porte deux, et ils se complètent. Le premier traite la vérification dynamique de contrats aux FRONTIÈRES entre code vérifié et code non fiable par des capabilités LINÉAIRES, et obtient la compilation PLEINEMENT ABSTRAITE — avec une différence à retenir, la non-duplicabilité y étant tenue par le MATÉRIEL et non par le typage, ce qui compte pour un document dont la garantie est statique et ne vaut donc que du code qu'il compile. Le second donne une extension typée de la cible où le QUALIFICATEUR DE LINÉARITÉ est un paramètre de type, sur lequel une fonction peut être polymorphe au même titre que sur les emplacements et les tailles, avec pour visée l'interopérabilité sûre et à grain fin en mémoire partagée. Les contrats de couche 1 ont donc leurs deux précédents : l'un pour la frontière, l'autre pour la cible.

#### Suivi d'avancement

1.  \[DONE\] vanstrydonckLinearCapabilitiesFully2019

2.  \[DONE\] fitzgibbonsRichWasmBringingSafe2024

### \[DONE\] \[#A\] WASM et WASI comme cible : le modèle de composants change-t-il ce que la couche 1 doit exposer ?

    ARC: I | QUID: QI-25 | REF: fitzgibbonsRichWasmBringingSafe2024, phipps-costinContinuingWebAssemblyEffect2023

Il le change en mieux que prévu. Le fonds porte une extension typée de la cible où le type d'une fonction est polymorphe sur les emplacements mémoire, les tailles, les TYPES et les QUALIFICATEURS — c'est-à-dire les annotations de LINÉARITÉ. La couche 1 n'aurait donc pas à effacer sa discipline pour exposer quoi que ce soit. Et la visée de cette extension est exactement la situation de la passerelle du chapitre 4 : interopérabilité sûre et à grain fin en MÉMOIRE PARTAGÉE, qui est le lieu où l'arc E a placé le troisième franchissement de la frontière de confiance.

#### Suivi d'avancement

1.  \[DONE\] fitzgibbonsRichWasmBringingSafe2024

2.  \[DONE\] phipps-costinContinuingWebAssemblyEffect2023

### \[DONE\] \[#A\] Le langage des gestionnaires EST-il la couche 2 ?

    ARC: J | QUID: QJ-1 | REF: vanderrestHeftyAlgebrasModular2025, brachthauserEffectsCapabilitiesEffect2020

Presque, et l'écart est exactement ce que le chapitre 1 reconnaît sans en dire le prix. Le langage des gestionnaires est celui des effets ALGÉBRIQUES, où chaque opération observable est une algèbre initiale et chaque gestionnaire un morphisme d'algèbres — ce que le document pose. Mais la couche 2 fait constamment ce qui en sort : les traits dépendant d'une portée délimitée ou d'une ressource allouée dynamiquement relèvent des effets à PORTÉE, et le chapitre le dit. La couche 2 est donc le langage des gestionnaires PLUS les effets à portée, et cette addition n'est pas gratuite.

#### Suivi d'avancement

1.  \[DONE\] vanderrestHeftyAlgebrasModular2025

2.  \[DONE\] brachthauserEffectsCapabilitiesEffect2020

### \[DONE\] \[#A\] Les algèbres HEFTY donnent-elles l'élaboration modulaire des effets d'ordre supérieur dont la couche 2 aurait besoin ?

    ARC: J | QUID: QJ-2 | REF: vanderrestHeftyAlgebrasModular2025

Elles le donnent, et elles nomment d'abord ce qui est perdu. Le bénéfice des effets algébriques est la MODULARITÉ : un programme se définit contre une INTERFACE d'opérations, l'implantation se raffine sans changer ni recompiler le programme, et les preuves équationnelles héritent de la même modularité. Les opérations d'ORDRE SUPÉRIEUR — celles qui prennent des calculs en argument — la brisent : encodées en termes d'effets algébriques, elles ne sont plus encapsulées dans une interface, si bien qu'un raffinement d'implantation induit des changements aux programmes ET aux preuves. Le remède proposé est la SURCHARGE SYNTAXIQUE, formalisée par les algèbres heftues. Le prix est donc un dispositif de résolution de nom, ce qui, pour un langage dont l'arc G recense dix espaces de noms, est à examiner avant d'être payé.

#### Suivi d'avancement

1.  \[DONE\] vanderrestHeftyAlgebrasModular2025

### \[DONE\] \[#A\] Un gestionnaire peut-il être une valeur de première classe sans casser P4 ?

    ARC: J | QUID: QJ-3 | REF: brachthauserEffectsCapabilitiesEffect2020

Dans la conception qui traite les effets comme des capacités, non : pour garantir la sûreté d'effet, les auteurs SÉPARENT LES FONCTIONS DES VALEURS et traitent toutes les fonctions comme de SECONDE CLASSE. Un gestionnaire n'y est donc pas une valeur de première classe. Mais la question ne se pose pas ainsi pour K7PL : la restriction que ces auteurs doivent IMPOSER est exactement ce que le calcul par poussée de valeur DONNE — un calcul n'y est pas une valeur, une suspension en est une. La seconde classe des fonctions y est la distinction valeur/calcul, non une contrainte ajoutée. Le postulat de rejouabilité n'est donc pas menacé, et l'acquis n'est pas revendiqué.

#### Suivi d'avancement

1.  \[DONE\] brachthauserEffectsCapabilitiesEffect2020

### \[DONE\] \[#A\] Les effets à PORTÉE encodés comme ressources ouvertes/fermées : la sédimentation suffit-elle, ou faut-il davantage ?

    ARC: J | QUID: QJ-4 | REF: lindleyScopedEffectsParameterized2024, bagrelDestinationCalculusLinear2025

La sédimentation ne suffit pas, et la source dit ce qu'il faut de plus. Le cadre est celui des THÉORIES ALGÉBRIQUES PARAMÉTRÉES, qui étendent les théories ordinaires d'opérations à LIAISON DE VARIABLE sur un type abstrait de paramètres ; les portées y sont réalisées en les encodant comme des RESSOURCES munies d'opérations d'OUVERTURE et de FERMETURE, par analogie avec les descripteurs de fichier. Ordonner les couches ne réifie rien : la sédimentation dit où une portée vit, elle ne la rend pas manipulable. C'est une construction à ajouter, non un ordre à invoquer. Et cela recoupe l'arc F, où le calcul de destinations exige un ÂGE comptant les portées imbriquées : deux besoins, une même exigence — la portée doit être un objet et non un contexte implicite.

#### Suivi d'avancement

1.  \[DONE\] lindleyScopedEffectsParameterized2024

2.  \[DONE\] bagrelDestinationCalculusLinear2025

### \[DONE\] \[#A\] Les continuations ne sont pas algébriques. K7PL les exclut de fait ; faut-il l'écrire, et quelle expressivité cela coûte-t-il ?

    ARC: J | QUID: QJ-5 | REF: devilhenaSeparationLogicEffect2021

Il faut l'écrire, et le motif à donner est meilleur que celui qu'on aurait invoqué. Le mot continuation ne paraît nulle part aux chapitres 1, 2 et 3 : l'exclusion est un silence, non un arbitrage. Or de Vilhena et Pottier écartent explicitement l'explication attendue — on pourrait croire la restriction aux continuations à UN SEUL USAGE motivée par le coût, servir plusieurs invocations demandant de copier des segments de pile — et donnent la vraie raison : permettre à une continuation d'être invoquée plus d'une fois BRISE CERTAINES LOIS FONDAMENTALES DU RAISONNEMENT SUR LES PROGRAMMES, car si une continuation peut être appelée deux fois, alors un bloc de code peut être ENTRÉ UNE FOIS ET QUITTÉ DEUX FOIS. Ce qui se perd n'est donc pas de l'expressivité gratuite : c'est ce que la règle de cadre ne survivrait pas.

#### Suivi d'avancement

1.  \[DONE\] devilhenaSeparationLogicEffect2021

### \[DONE\] \[#A\] La logique de séparation pour les gestionnaires : donne-t-elle le raisonnement que P1 promet en lisant `⊗` comme séparation ?

    ARC: J | QUID: QJ-6 | REF: devilhenaSeparationLogicEffect2021

Elle le donne, elle est mécanisée, et elle porte DEUX prix dont le second vise directement K7PL. La spécification d'un fragment y inclut un PROTOCOLE décrivant les effets qu'il peut effectuer et les réponses qu'il peut attendre, et les règles incluent celles de la logique de séparation, dont la RÈGLE DE CADRE — qui est le raisonnement que P1 promet en lisant le tenseur comme séparation. Premier prix : la règle de liaison est RESTREINTE aux contextes neutres. Second prix : les auteurs posent eux-mêmes leurs limites — absence de concurrence à MÉMOIRE PARTAGÉE, absence de continuations multiples, absence d'EFFETS NOMMÉS MULTIPLES. Or le document a une arène partagée et des effets nommés multiples. La logique, telle qu'elle est, ne couvre donc pas son cas.

#### Suivi d'avancement

1.  \[DONE\] devilhenaSeparationLogicEffect2021

### \[DONE\] \[#A\] Le modèle des ESPACES DE CAPACITÉ valide-t-il `thm:surete_spatiale` ?

    ARC: J | QUID: QJ-7 | REF: devilhenaSeparationLogicEffect2021, choudhuryRecoveringPurityComonads2020

Le théorème tient sur ce qu'il énonce, et sa preuve est courte parce qu'elle n'emploie qu'un trait : la capacité d'écriture est une ressource linéaire, le fragment linéaire strict ne porte aucun morphisme de duplication, donc la ressource consommée par une fibrille est structurellement retirée du contexte de l'autre. Rien à redire. Ce que le fonds n'a pas encore rendu est le MODÈLE d'espaces de capacité que la question nomme, et la sonde n'a pas retrouvé la pièce sous ce titre. Ce qui s'en rapproche le plus est la logique de séparation pour gestionnaires, dont la règle de cadre est la forme sémantique de la disjonction que le théorème exploite syntaxiquement — mais elle exclut la mémoire partagée, donc le cas de l'arène. Maintenue en cours. TRANCHÉE le 3 septembre : LE MODÈLE EXISTE, IL EST AU FONDS, ET IL VALIDE LA DISCIPLINE SANS VALIDER L'ÉNONCÉ. LE MODÈLE, TROUVÉ SUR L'INDEX AUX TITRES CORRIGÉS. Un ESPACE DE CAPACITÉ est un ensemble muni d'une relation de POIDS qui assigne à chaque valeur les ensembles de capacités qu'elle peut détenir. Un morphisme d'espaces de capacité est une fonction qui PRÉSERVE LES POIDS : les capacités du résultat sont bornées par celles des arguments. Les auteurs le disent en toutes lettres — les fonctions préservant le poids sont PRÉCISÉMENT celles qui sont sûres du point de vue des capacités : elles n'ont ni accès non autorisé ni autorité ambiante. CE QUE CELA VALIDE, ET C'EST LA DISCIPLINE. Que la faculté de produire un effet se contrôle par la détention d'une permission, et qu'un programme soit sûr s'il ne produit aucun effet dont il n'a pas la capacité, reçoit ici une sémantique DÉNOTATIONNELLE et non seulement une discipline syntaxique. C'est le cadre dans lequel la capacité d'écriture de ce document est une ressource. CE QUE CELA NE VALIDE PAS, ET LA DISTINCTION EST NETTE. L'objet du modèle est la PERMISSION DE PRODUIRE UN EFFET ; l'objet du théorème est la DISJONCTION DE RÉGIONS MÉMOIRE. Deux fibrilles qui ne partagent aucune capacité d'écriture ne partagent aucune région, mais cette implication est une propriété du langage — la capacité EST le droit sur la région — et non un théorème du modèle. Le modèle valide donc la MÉTHODE, non l'énoncé. ET UNE RÉSERVE QUI TIENT À UN ARBITRAGE DÉJÀ RENDU, ce qui est le point le plus utile. Ce modèle sert un système qui RECOUVRE la pureté par une comonade depuis un ambiant impur — la direction que l'arbitrage du 3 septembre écarte, la pureté devant être absolue. L'adopter comme sémantique importerait la lecture RELATIVE de la pureté que le document refuse. Il se cite donc pour la notion de sûreté capacitaire, non comme modèle du document. LE THÉORÈME, LUI, TIENT SUR CE QU'IL ÉNONCE et sa preuve n'emploie qu'un trait : le fragment linéaire strict ne porte aucun morphisme de duplication, donc la ressource consommée par une fibrille est structurellement retirée du contexte de l'autre.

#### Suivi d'avancement

1.  \[DONE\] devilhenaSeparationLogicEffect2021

### \[DONE\] \[#A\] Le passage explicite de capacités — System Ξ — est-il une voie d'abaissement pour les effets de K7PL ?

    ARC: J | QUID: QJ-8 | REF: brachthauserEffectsCapabilitiesEffect2020, schusterCompilingEffectHandlers2020

Oui, et c'est la même voie que l'arc I a trouvée du côté de la compilation — une seule équipe l'a traitée des deux côtés. La sémantique des effets comme capacités est donnée par traduction vers un calcul en style à passage EXPLICITE de capacités ; et la compilation depuis ce style, combinée au passage de continuations itéré, donne des accélérations mesurées ainsi qu'un sous-ensemble à coût NUL caractérisé par un système de types plus restrictif, avec preuve qu'aucune abstraction de gestionnaire ne subsiste. La conception et l'abaissement des effets sont donc une seule question, et elle a une réponse.

#### Suivi d'avancement

1.  \[DONE\] brachthauserEffectsCapabilitiesEffect2020

2.  \[DONE\] schusterCompilingEffectHandlers2020

### \[DONE\] \[#A\] « Effects as capabilities » met dans le COEFFET ce que les autres mettent dans l'effet, au prix du raisonnement sur la pureté. K7PL, qui a les deux, échappe-t-il vraiment au prix, ou le paie-t-il ailleurs ?

    ARC: J | QUID: QJ-9 | REF: brachthauserEffectsCapabilitiesEffect2020

Le prix est nommé par les auteurs et K7PL ne le paie pas. Mettre l'effet dans le coeffet exige, chez eux, de séparer les fonctions des valeurs et de rendre toutes les fonctions de SECONDE CLASSE — c'est ce qui garantit la sûreté d'effet. Or cette séparation est le cadre même du document, où un calcul n'est pas une valeur et où une suspension en est une. Ce que les auteurs imposent, le calcul par poussée de valeur le donne. La question du raisonnement sur la pureté se reformule donc : elle ne coûte pas une restriction nouvelle, elle est déjà payée par le choix du noyau.

#### Suivi d'avancement

1.  \[DONE\] brachthauserEffectsCapabilitiesEffect2020

### \[DONE\] \[#A\] Les capacités matérielles — CHERI et sa descendance — ont-elles un rapport avec les capacités de K7PL, ou est-ce une homonymie ?

    ARC: J | QUID: QJ-10 | REF

Le fonds ne porte RIEN sur les capacités matérielles : la sonde, conduite sur l'enregistrement complet, ne rend aucune pièce sur CHERI ni sur cette famille. La question ne peut donc être tranchée, et elle importe — l'arc E a établi qu'une source fait tenir la non-duplicabilité d'une capacité par le MATÉRIEL là où K7PL la fait tenir par le typage, et l'alternative entre support matériel et enveloppement dynamique reste ouverte faute de cette littérature. Consigné comme manque de corpus.

#### Suivi d'avancement

1.  \[DONE\] sonde négative, conduite sur l'enregistrement complet

### \[DONE\] \[#A\] Le polymorphisme de ressource de Munch-Maccagnoni : K7PL en est-il une instance ?

    ARC: J | QUID: QJ-11 | REF: munch-maccagnoniResourcePolymorphism2018

Non, et pour un motif qui vaut d'être écrit : la proposition suppose un ramasse-miettes comme mode d'allocation par défaut, les valeurs ramassées pouvant s'employer sans restriction en contexte possédant comme en contexte empruntant. C'est le contraire du postulat d'autonomie physique. La notion qui transporte est en revanche la bonne — le POLYMORPHISME DE RESSOURCE, une bibliothèque écrite une fois et employable sous plusieurs disciplines — et chez K7PL c'est le polymorphisme sur le GRADE, qui est plus fort, la discipline y étant un paramètre du type et non un mode d'allocation. Réserve de statut : rapport de recherche et proposition, non un système formel.

#### Suivi d'avancement

1.  \[DONE\] munch-maccagnoniResourcePolymorphism2018

### \[DONE\] \[#A\] Les systèmes de MODES qui séparent affinité, unicité et localité montrent que le coût de la discipline est « réductible mais non nul ». Où K7PL se situe-t-il sur cette échelle ?

    ARC: J | QUID: QJ-12 | REF: oconnorCogentUniquenessTypes2021, bagrelDestinationCalculusLinear2025

Le coût est réductible, et la source montre par où : la discipline ne s'AJOUTE pas au coût de vérification, elle en RETIRE une part. Le système de types d'unicité y élimine le besoin d'un support d'exécution de confiance ou d'un ramasse-miettes tout en garantissant la sûreté mémoire — donc une part entière de ce qu'il faudrait vérifier disparaît avec lui. Et le dispositif qui rend le reste supportable est architectural : DEUX SÉMANTIQUES pour un même langage, l'une impérative pour engendrer du code efficace, l'autre purement fonctionnelle pour le raisonnement équationnel, reliées par un THÉORÈME DE RAFFINEMENT dont le compilateur PRODUIT la preuve. C'est un précédent pour un document qui adosse aujourd'hui sa confiance à un oracle de test différentiel.

#### Suivi d'avancement

1.  \[DONE\] oconnorCogentUniquenessTypes2021

2.  \[DONE\] bagrelDestinationCalculusLinear2025

### \[DONE\] \[#A\] « Mutation is local and explicit » : ce traitement de la mutation par effets contrôlés et propriété linéaire recoupe-t-il la sédimentation ?

    ARC: J | QUID: QJ-13 | REF: jakefecherAlgebraicEffectsOwnership2024, devilhenaSeparationLogicEffect2021

Cela recoupe, et la contrainte trouvée est la même que celle des continuations, vue d'un autre angle. Le corps d'un gestionnaire pouvant être appelé PLUSIEURS FOIS, il ne peut DÉPLACER aucune valeur de son environnement — sans quoi un programme peut employer deux fois la même valeur déplacée. C'est la restriction d'usage unique reformulée en termes de propriété, et elle explique pourquoi le document doit trancher la question des continuations avant celle de la mutation : les deux sont la même contrainte. Réserve de statut : la source est un billet de conception de langage, non un article évalué ; elle vaut pour la formulation du problème, non comme autorité.

#### Suivi d'avancement

1.  \[DONE\] jakefecherAlgebraicEffectsOwnership2024

2.  \[DONE\] devilhenaSeparationLogicEffect2021

### \[DONE\] \[#A\] Le suivi d'emprunts par expressions régulières : donne-t-il un algorithme utilisable pour la vérification de la couche 1 ?

    ARC: J | QUID: QJ-14 | REF: nowackiTrackingBorrowsRegular

Oui, il est décidable, il est en production, et il est mécanisé dans l'assistant que le document envisage. Les CHEMINS D'ACCÈS y sont suivis par des EXPRESSIONS RÉGULIÈRES : les dérivées de Brzozowski expriment les conséquences d'un emprunt sur l'accessibilité, l'étoile de Kleene résume les chaînes d'emprunt issues des appels et des boucles, et la vérification d'aliasing se réduit à la VACUITÉ D'UN LANGAGE RÉGULIER. Le dispositif s'étend aux vecteurs et aux types énumérés, et il a remplacé en production un analyseur par interprétation abstraite qui confondait inférence et vérification et n'était justifié qu'informellement. La dérivée revient ici pour la troisième fois dans le projet, après le foncteur dérivée des coalgèbres et l'analyse par dérivée des grammaires à pile visible : ce n'est plus une coïncidence, c'est un outil.

#### Suivi d'avancement

1.  \[DONE\] nowackiTrackingBorrowsRegular

### \[DONE\] \[#A\] Les régions monadiques : sont-elles une alternative aux arènes, ou la même chose sous un autre nom ?

    ARC: J | QUID: QJ-15 | REF: fluetMonadicRegions2006, kiselyovLightweightMonadicRegions

Ni l'une ni l'autre, et la distinction vaut d'être écrite. Une ARÈNE est une DISPOSITION — bloc contigu, composants rangés par famille, références qui sont des décalages. Une RÉGION est une DISCIPLINE DE PORTÉE — quand une allocation cesse d'être atteignable. Le document a besoin des deux et n'a nommé que la première. Ce qui transporte est une économie : les auteurs montrent que la complication habituelle des systèmes à régions est EN PRINCIPE INUTILE, le POLYMORPHISME PARAMÉTRIQUE ORDINAIRE suffisant, et l'établissent par une traduction préservant les types ET le sens vers une variante monadique du Système F. Le noyau portant déjà de la quantification, la portée d'arène serait une application du polymorphisme existant plutôt qu'un appareil de plus.

#### Suivi d'avancement

1.  \[DONE\] fluetMonadicRegions2006

2.  \[DONE\] kiselyovLightweightMonadicRegions

### \[DONE\] \[#A\] L'analyse de CARDINALITÉ d'ordre supérieur, modulaire, est-elle ce que le grade d'usage `u` calcule ?

    ARC: J | QUID: QJ-16 | REF: sergeyModularHigherOrder2017

C'est la même grandeur calculée en sens inverse. L'analyse de cardinalité INFÈRE du programme combien de fois une chose est employée, trouve de nombreuses suspensions à entrée unique et lambdas à un coup, et le fait modulairement, avec preuve de correction et mesures dans un compilateur de production. Le grade d'usage EXIGE la même information du programme et refuse ce qui ne s'y conforme pas. La comparaison chiffre ce que le document gagne : là où un compilateur optimisant a besoin d'une analyse entière, de sa preuve et de ses mesures, le jugement gradué porte l'information par construction. Un rappel s'y ajoute, et c'est le troisième arc où il revient : la correction est établie au regard d'une sémantique par NÉCESSITÉ, et le document ne dit nulle part sous quelle stratégie ses énoncés d'usage valent.

#### Suivi d'avancement

1.  \[DONE\] sergeyModularHigherOrder2017

### \[DONE\] \[#A\] Quelle formalisation existante est la plus proche de ce que LEAN 4 devra porter ?

    ARC: K | QUID: QK-1 | REF: nowackiTrackingBorrowsRegular, erikssonGradedModalType2025, abelGradedModalDependent2026

La réponse s'inverse par rapport à ce que l'instruction de l'arc K avait conclu. Il existe bien une mécanisation LEAN au fonds, et elle est substantielle : trente-neuf mille lignes, preuve de correction vérifiée par machine, vérificateur de types algorithmique exécutable éprouvé contre un compilateur de production, zéro axiome. Son objet — un système de types d'EMPRUNT dont la correction repose sur la préservation et l'affaiblissement — est proche de ce que K7PL devra porter, et sa ventilation par règle de typage rend l'estimation transportable. Les formalisations les plus proches SUR LE FOND restent en Agda, la théorie modale graduée avec univers, effacement et machine abstraite ; mais la question portait sur ce que l'assistant devra PORTER, et de ce point de vue le précédent existe.

#### Suivi d'avancement

1.  \[DONE\] nowackiTrackingBorrowsRegular

2.  \[DONE\] erikssonGradedModalType2025

3.  \[DONE\] abelGradedModalDependent2026

### \[DONE\] \[#A\] Les quatre inductions démontrées à la main : leur structure de preuve transporte-t-elle telle quelle ?

    ARC: K | QUID: QK-2 | REF: allaisTypeScopeSafe2018, nowackiTrackingBorrowsRegular, abelPOPLMarkReloadedMechanizing2019

La question est périmée dans son nombre et instruite dans son fond. Elle parlait de QUATRE inductions ; le document en compte désormais bien davantage — quarante-quatre théorèmes, dont dix écrits le 2 septembre. CE QUI TRANSPORTE, ET C'EST LA PART LA PLUS GROSSE. Les quatre inductions du document procèdent toutes par récurrence sur la dérivation, avec un cas par règle. C'est la forme dont le facteur d'échelle est connu : une mécanisation de référence compte 153 lemmes couvrant 41 CAS — un par règle de typage — chacun rétablissant les 35 champs de son invariant d'état. K7PL a trente-sept règles, et l'estimation transporte presque telle quelle. CE QUI NE TRANSPORTE PAS, ET LA JOURNÉE DU 2 SEPTEMBRE L'A AJOUTÉ. Le lemme de substitution a reçu une CONDITION DE BORD conditionnelle — la liaison maximale de sa zone — et une forme SIMULTANÉE distincte, avec son ordre de séquentialisation. Une induction qui se conduisait par récurrence simple demande désormais, sous la discipline d'échange, une récurrence sur le CARDINAL du contexte en plus de celle sur la dérivation. Deux récurrences imbriquées ne sont pas une récurrence. ET UN COÛT D'INFRASTRUCTURE DOMINE LE RESTE, celui que l'arc B avait chiffré : ce qui coûte n'est pas l'idée de la preuve mais les extensions de contexte, l'affaiblissement, l'échange, les substitutions simultanées. Pour K7PL c'est un PLANCHER, ses contextes étant gradués — et l'approche générique de la syntaxe liante est ce qui le retire, en dérivant ces parcours une fois pour toutes. RÉPONSE : la structure transporte, le facteur d'échelle est connu, et le seul écart est celui que le 2 septembre a créé — la substitution simultanée ordonnée, qui est un lemme de plus et non une difficulté de plus.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre, après réécriture du lemme de substitution

### \[DONE\] \[#A\] Les relations logiques comme types : donnent-elles la méthode pour la non-interférence de K7PL ?

    ARC: K | QUID: QK-3 | REF: gregersenMechanizedLogicalRelations2021, algehedSimpleNoninterferenceParametricity2019, bowmanNoninterferenceFree

Elles la donnent, et le fonds porte la version mécanisée pour la variante que le document peut viser — la non-interférence INSENSIBLE À LA TERMINAISON. Le motif que les auteurs invoquent est celui du document : les langages modernes ont des types riches, types d'ordre supérieur, références, types abstraits, et à mesure que la complexité du système croît, croît la charge d'en prouver la correction. C'est exactement la situation d'un jugement à trois composantes et quatre grades.

#### Suivi d'avancement

1.  \[DONE\] gregersenMechanizedLogicalRelations2021

2.  \[DONE\] algehedSimpleNoninterferenceParametricity

3.  \[DONE\] bowmanNoninterferenceFree

### \[DONE\] \[#A\] La mécanisation de la syntaxe liante — approches nominale, de de Bruijn, à portée sûre — laquelle ?

    ARC: K | QUID: QK-4 | REF: allaisTypeScopeSafe2018, fioreFormalMetatheorySecondorder2022, pittsNominalSetsNames2013

La question suppose un choix entre trois concurrentes ; le fonds montre qu'elles ne sont pas au même niveau, et que deux d'entre elles se COMPOSENT au lieu de se disputer. CE QUI EST COMMUN AUX TROIS SOURCES, ET C'EST LE VRAI PROBLÈME. Les trois nomment le même adversaire : le CODE DE PLOMBERIE. Renommage, substitution évitant la capture, désucrage, impression — réécrits pour chaque implantation, puis UNE SECONDE FOIS pour les preuves de correction. Ce n'est pas la difficulté de la liaison qui coûte, c'est sa répétition. L'APPROCHE À PORTÉE SÛRE EST CELLE DE L'IMPLANTATION. Un univers expressif de syntaxes à liaison, où les parcours s'implantent UNE FOIS POUR TOUTES par programmation générique et où les propriétés se DÉRIVENT. C'est le choix que le document a déjà fait sans le nommer comme tel : son AST est l'algèbre initiale d'une signature à opérateurs liants, intrinsèquement indexée par la portée. L'APPROCHE PAR SIGNATURE EN EST LE PROLONGEMENT NATUREL, et le fonds la porte : un cadre qui traduit la description d'une signature à opérateurs liants en un développement, avec le lemme de substitution obtenu PAR CONSTRUCTION plutôt que par preuve séparée. C'est ce que le chapitre 5 invoque pour son hygiène. L'APPROCHE NOMINALE N'EST PAS UNE CONCURRENTE : C'EST LA MÉTATHÉORIE. Elle ne dit pas comment implanter, elle dit ce que « frais » veut dire, et QA-29 a établi ce qu'elle rend — le quantificateur de fraîcheur, qui fait que choisir un nom frais n'est pas un choix. On ne choisit pas entre elle et les deux autres, on s'en sert pour justifier ce qu'elles font. LES INDICES DE DE BRUIJN, ENFIN, NE SONT PAS UNE APPROCHE MAIS UNE REPRÉSENTATION, et le document la retient déjà EN INTERNE — chaque variable porte un nom et un indice, le nom pour les messages d'erreur, l'indice pour le masquage. Le nom n'est donc pas un choix de mécanisation mais une donnée d'ergonomie conservée à côté. RÉPONSE : portée sûre pour l'implantation, signature pour la dérivation des preuves, nominal pour la métathéorie, de Bruijn en interne. Quatre couches et non quatre concurrentes, et le document les emploie déjà toutes les quatre sans l'avoir écrit.

#### Suivi d'avancement

1.  \[DONE\] allaisTypeScopeSafe2018

2.  \[DONE\] fioreFormalMetatheorySecondorder2022

3.  \[DONE\] pittsNominalSetsNames2013

### \[DONE\] \[#A\] Les univers de syntaxes à portée et à type sûrs : réduisent-ils le coût de la mécanisation d'un langage à plusieurs fragments ?

    ARC: K | QUID: QK-5 | REF: allaisTypeScopeSafe2018

Oui, et c'est le remède exact au coût que l'arc B avait chiffré. Un univers expressif de syntaxes à liaison permet d'implanter les parcours à portée sûre UNE FOIS POUR TOUTES par programmation générique, et d'en DÉRIVER les propriétés. Le problème visé est nommé dans les mêmes termes que le jeu d'épreuves de mécanisation : le code de plomberie — renommage, substitution, désucrage, impression — réécrit pour chaque implantation PUIS ENCORE pour les preuves. Pour un langage à plusieurs fragments, trois couches et un métalangage sont quatre descriptions et non quatre développements. Réserve : le développement est en Agda, et ce qui en transporte à l'assistant envisagé reste ouvert.

#### Suivi d'avancement

1.  \[DONE\] allaisTypeScopeSafe2018

### \[DONE\] \[#A\] Que coûte, en pratique mesurée, la mécanisation d'un système de types de cette taille ? Le document a une NOTE DE COÛT du 7 août ; le fonds permet-il de la calibrer ?

    ARC: K | QUID: QK-6 | REF: nowackiTrackingBorrowsRegular, abelPOPLMarkReloadedMechanizing2019

Le fonds la porte, elle est en LEAN, et elle transporte presque telle quelle. Trente-neuf mille lignes de Lean non vides et non commentées, deux cent soixante-sept validations, ZÉRO axiome ni déclaration en suspens ; les preuves de correction dominent à vingt-trois mille lignes, soit cinquante-neuf pour cent. La ventilation est le renseignement utile : langage, expressions régulières et sémantique deux mille sept cents ; règles de typage cinq mille huit cent dix ; PRÉSERVATION dix mille deux cent soixante-dix ; AFFAIBLISSEMENT sept mille deux cent trente ; autres preuves cinq mille cinq cents. Et le facteur d'échelle est nommé : la préservation compte cent cinquante-trois lemmes couvrant QUARANTE ET UN CAS, un par règle de typage, chacun rétablissant les trente-cinq champs de l'invariant d'état bien typé. K7PL a TRENTE-SEPT règles de typage. Le délai — environ un mois avec un assistant de preuve automatisé — porte sa réserve : un délai conditionnel à un dispositif d'assistance n'est pas une mesure de la difficulté intrinsèque.

#### Suivi d'avancement

1.  \[DONE\] nowackiTrackingBorrowsRegular

2.  \[DONE\] abelPOPLMarkReloadedMechanizing2019

### \[DONE\] \[#A\] La définition OPAQUE et l'irrélevance : quelles précautions LEAN 4 impose-t-il que le document ignore ?

    ARC: K | QUID: QK-7 | REF: HUANG, THEOCHARIS, nowackiTrackingBorrowsRegular

La lecture de QTAL le 2 septembre donne la réponse, et elle n'est pas une liste de précautions d'assistant mais un fait de théorie qui les commande toutes. LE FAIT. La théorie quantitative marque le jugement d'un indicateur binaire — effacé ou présent — de sorte que l'effaçabilité d'un terme SE LIT SUR LE JUGEMENT. La théorie graduée, que K7PL emploie, remplace cet indicateur par une modalité ; elle gagne en équations définitionnelles et perd cela. Il n'est plus apparent qu'une abstraction sera employée à l'exécution. CE QUE CELA IMPOSE. Toute précaution d'assistant sur l'irrélevance suppose de savoir CE QUI EST IRRÉLEVANT ; dans un cadre gradué, cela ne se lit pas, cela se calcule. La question n'est donc pas « quelles précautions l'assistant impose » mais « quelle analyse le document doit fournir pour que la question ait un sens dans son cadre ». ET LA DÉFINITION OPAQUE RELÈVE DE LA MÊME CHOSE. Une définition opaque est un terme dont on cache le corps ; savoir si son effacement est licite demande de savoir si son grade est nul, ce qui est une propriété du CONTEXTE d'emploi et non du terme. Un assistant qui offre l'opacité ne peut donc pas décider seul. LA VOIE QUI EXISTE, ET ELLE EST AU FONDS. La distinction de phase SYNTHÉTIQUE rend la discrimination sur une donnée effacée non pas interdite mais INEXPRIMABLE, et la conservativité dans les deux phases s'en déduit. C'est ce que C-5 porte au chapitre 3, et c'est ce qui rendrait la question décidable dans le cadre du document plutôt que dans celui de l'assistant. RÉPONSE : la précaution que le document ignore n'est pas propre à un assistant — c'est que la gradation lui coûte la LISIBILITÉ de l'effaçabilité, et qu'il doit la regagner par une analyse ou par la distinction de phase synthétique.

#### Suivi d'avancement

1.  \[DONE\] HUANG, lu en entier le 2 septembre

### \[DONE\] \[#A\] Le profil de vérification du solveur est commandé par P3. Quelle STRATÉGIE — SMT, types liquides, interprétation abstraite — pour quelle classe d'obligation ?

    ARC: K | QUID: QK-8 | REF: knothLiquidResourceTypes2020, walchAutomatedAmortisedAnalysis

La stratégie est celle des TYPES DE RESSOURCE LIQUIDES, et le motif est un arbitrage que la source pose elle-même. L'ARBITRAGE, DANS SES TERMES. Les techniques AUTOMATISÉES sont restreintes à des familles de bornes relativement contraintes ; les techniques de preuve plus EXPRESSIVES, qui admettent des bornes dépendant des valeurs, reposent sur des preuves écrites à la main. Les types liquides combinent les deux. POURQUOI CELA TRANCHE POUR K7PL. Ses grades DÉPENDENT DE VALEURS — les grades fractionnaires, les rangées à grade de présence, Vector(n,T). Une technique purement automatisée ne les couvrirait pas ; une technique à preuves manuelles contredirait l'exigence de compilation bornée du chapitre 6. Le point de rencontre est donc contraint, et il n'y en a qu'un au fonds. UNE SECONDE PIÈCE EN DONNE LE VERSANT INFÉRENCE : un système de types générique permettant le raisonnement modulaire et l'inférence de bornes optimales, sur des structures purement fonctionnelles. C'est ce dont la bibliothèque du chapitre 4 aurait besoin.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] Les types de ressource liquides donnent-ils la forme des obligations de budget ?

    ARC: K | QUID: QK-9 | REF: knothLiquidResourceTypes2020

OUI, et la forme est celle que K7PL emploie déjà sans le savoir. CE QUE LA SOURCE DONNE. Les types de ressource liquides augmentent les types à raffinement d'ANNOTATIONS DE POTENTIEL pour conduire une analyse amortie, et emploient les raffinements logiques pour prouver automatiquement des bornes précises de consommation. POURQUOI L'AJUSTEMENT EST EXACT. Le budget du grade EST un potentiel — l'annexe l'établit en montrant que la quantité que la préservation fait décroître a la forme d'un potentiel au sens de la méthode du même nom. Les raffinements sont les contraintes de valeur du chapitre 3. Les trois pièces du dispositif sont donc au document, sous d'autres noms. ET LA SOURCE PERMET D'ANNOTER LES DÉCLARATIONS DE STRUCTURE pour dire où le potentiel est stocké, ce qui est le pendant exact du grade porté par une liaison. CE QUI RESTE : vérifier que le passage aux grades FRACTIONNAIRES, que le chapitre 3 emploie, ne sort pas du cadre — la source travaille sur des potentiels dont la nature n'est pas dite ici.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] L'analyse de ressource automatique pour les exceptions et les effets : est-ce la brique manquante entre `ℰ` et le solveur ?

    ARC: K | QUID: QK-10 | REF: chuHandlingExceptionsEffects

OUI, c'est la brique manquante, et elle existe — mais elle est jeune et son périmètre est étroit. CE QUE LA SOURCE ÉTABLIT. C'est la PREMIÈRE analyse automatique de bornes de ressource qui supporte le transfert de contrôle NON LOCAL entre exceptions ou effets et leurs gestionnaires. Les auteurs notent que ce cas avait résisté à toutes les techniques antérieures, qui fonctionnent pourtant sur une large classe de programmes. POURQUOI C'EST LA BRIQUE DE K7PL. Le langage a des gestionnaires d'effets algébriques en couche 2, et son budget est une borne de ressource. Sans cette pièce, l'analyse de budget s'arrête au premier gestionnaire. ET ELLE ÉTEND L'AARA, c'est-à-dire l'analyse amortie automatique par les types — la même famille que les types liquides de QK-9. Les deux pièces se composent donc au lieu de se concurrencer. LA LIMITE EST NETTE ET ELLE EST DITE : présentée pour un langage fonctionnel simple, avec des listes et des fonctions de potentiel LINÉAIRES. Les auteurs annoncent que les idées s'appliquent plus largement ; l'annoncer n'est pas l'établir.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] Une obligation indécidable doit être rejetée. Comment le compilateur le CONSTATE-t-il avant de lancer le solveur ?

    ARC: K | QUID: QK-11 | REF: THEOCHARIS

Il ne le constate pas, et c'est la bonne réponse — le document emploie déjà la parade sans l'avoir nommée comme telle. LA QUESTION SUPPOSAIT UNE DÉTECTION. Elle demandait comment le compilateur remarque qu'une obligation est indécidable avant de tenter de la décharger. Aucun compilateur ne le peut : décider si une obligation est décidable est lui-même indécidable en général. CE QUE LE DOCUMENT FAIT À LA PLACE, et il le fait déjà au chapitre 4 : il RESTREINT LE LANGAGE DES OBLIGATIONS. La décidabilité y revient en bornant les prédicats numériques, de sorte qu'une obligation indécidable n'est pas rejetée — elle est INEXPRIMABLE. C'EST LA MÊME FIGURE QUE C-5, ET ELLE EST DEVENUE UN PATRON DU PROJET. La règle des éliminateurs ne dit pas « on interdit de discriminer sur une phase de compilation » mais « la discrimination y est inexprimable ». Rendre inexprimable plutôt qu'interdire, c'est ce qui retire une liste à tenir à jour. CE QUI RESTE À ÉCRIRE : que la restriction du chapitre 4 est la RÉPONSE à cette question, et non une précaution locale. Une phrase.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] La divulgation BORNÉE — borne inférieure ET supérieure — a-t-elle une réalisation de référence ?

    ARC: K | QUID: QK-12 | REF: chongRequiredInformationRelease2010, rajaniGradedModalRelaxed2025

Oui, et en DEUX pièces d'espèce différente — la spécification et le mécanisme — toutes deux au fonds et toutes deux déjà citées au chapitre 1. LA SPÉCIFICATION. Les techniques de contrôle de flot savent raisonner sur les flux PERMIS et non sur les flux REQUIS ; la pièce introduit la spécification et l'application de la divulgation REQUISE dans un cadre langagier, avec des conditions de sécurité sémantiques. C'est exactement la borne inférieure que P4 réclame et que le chapitre 1 dit lui manquer. LE MÉCANISME. Une théorie des types modale graduée pour la déclassification sémantique relâchée, bâtie sur un calcul qui a déjà une monade graduée pour la CLASSIFICATION et qui lui AJOUTE une modalité dédiée à la déclassification, avec un modèle par relation logique. C'est ce que C-30 porte au chapitre 1, et c'est ce qui rend l'ensemble des échappatoires énonçable comme un type. CE QUE LEUR CONJONCTION DONNE À K7PL, ET IL NE L'A PAS ENCORE. La borne supérieure y est acquise — c'est la non-interférence graduée. La borne inférieure a sa spécification. Et le mécanisme qui les tient ensemble est une seconde modalité, non un assouplissement de la première. Les trois mises en œuvre que le chapitre 1 énumère — journal stratifié, journal chiffré, rejeu dégradé — deviennent alors des réalisations d'une spécification unique, à départager sur le coût. CE QUI RESTE : écrire la borne inférieure. Ce n'est plus une recherche.

#### Suivi d'avancement

1.  \[DONE\] chongRequiredInformationRelease2010

2.  \[DONE\] rajaniGradedModalRelaxed2025

### \[DONE\] \[#A\] La non-interférence appliquée à la composante TEMPORELLE : le fonds donne-t-il le modèle qui referme la fuite ?

    ARC: K | QUID: QK-13 | REF: smithNewTypeSystem2001, zagieboyloUsingInformationFlow2019, stefanAddressingCovertTermination2012

Le fonds donne le modèle, et il donne aussi son PRIX et l'endroit exact où K7PL se trouve. Les trois ensemble valent mieux que le modèle seul. LE MODÈLE. Pour un langage impératif multi-fils à ordonnancement probabiliste, la propriété visée est la NON-INTERFÉRENCE PROBABILISTE, et un système de types suffit à la garantir. SON PRIX, ET IL EST NOMMÉ PAR LA SOURCE ELLE-MÊME. Les systèmes antérieurs l'obtenaient au prix de RESTRICTIONS SÉVÈRES, imposées précisément pour empêcher les fuites par le temps. La non-interférence temporelle ne s'ajoute donc pas à un système de types : elle en restreint l'expressivité, et savoir de combien est la question de conception. ET L'ENDROIT OÙ K7PL SE TROUVE EST DOCUMENTÉ COMME UN TROU. Les langages de description matérielle à contrôle de flot savent éliminer les canaux de temporisation ; les langages logiciels savent garantir la non-interférence ; mais les deux sont construits INDÉPENDAMMENT, et il n'existe aucune abstraction pour composer leurs garanties. K7PL vise un unikernel, c'est-à-dire précisément la jonction des deux. CE QUE LE DOCUMENT A DÉJÀ, ET QU'IL N'A PAS REVENDIQUÉ ICI. Le remède aux canaux de TERMINAISON est dans son architecture — un acteur est un fil à état privé, la composante de niveau du grade est l'étiquette courante. Le canal de TEMPORISATION est un autre canal, et ce remède ne le ferme pas. RÉPONSE : le modèle existe, son coût est une perte d'expressivité à chiffrer, et la composition matériel-logiciel dont K7PL a besoin n'a pas d'abstraction connue. C'est une réserve à écrire, non un manque à combler.

#### Suivi d'avancement

1.  \[DONE\] smithNewTypeSystem2001

2.  \[DONE\] zagieboyloUsingInformationFlow2019

### \[DONE\] \[#A\] La déclassification par échappatoires nommées : l'ensemble des échappatoires n'est pas dit CLOS (F-10). Quelle source impose ou lève cette clôture ?

    ARC: K | QUID: QK-14 | REF: rajaniGradedModalRelaxed2025

DISSOUTE le 2 septembre par un item de la passe d'ajustement, et sans recherche. LA QUESTION. L'ensemble des échappatoires de déclassification n'est pas dit clos, et une liste ne peut pas trancher sa propre clôture. CE QUI A CHANGÉ. C-30 établit que la déclassification n'est pas une EXCEPTION à la modalité de classification mais une MODALITÉ DISTINCTE, ajoutée à côté d'elle — le procédé de la déclassification sémantique relâchée. La composante de niveau du grade est la modalité de classification ; les échappatoires relèvent d'une seconde. D'OÙ LA RÉPONSE. L'ensemble des échappatoires devient énonçable comme un TYPE et non comme une liste, et sa clôture cesse d'être une question ouverte pour devenir une propriété de ce type — vérifiable par les moyens ordinaires. Porté au chapitre 1. UNE QUESTION FERMÉE PAR UN CHANGEMENT DE STATUT PLUTÔT QUE PAR UNE PIÈCE. C'est le quatrième cas de la journée.

#### Suivi d'avancement

1.  \[DONE\] instruit le 2 septembre

### \[DONE\] \[#A\] Le calcul de dépendance dépendante et son cousin l'indistinguabilité : lequel modélise l'axe de confidentialité de K7PL ?

    ARC: K | QUID: QK-15 | REF: choudhuryDependentDependencyCalculus2022, rajaniGradedModalRelaxed2025

C'est le calcul de dépendance qui modélise l'axe, et sa forme est précise : un opérateur modal de POSSIBILITÉ gradué par une étiquette de sécurité, souvent appelé monade graduée dans ce cadre, pour suivre et contrôler le flot d'information dans un calcul fonctionnel noyau, avec sa sémantique catégorique. La composante de niveau du grade de K7PL est cette monade graduée. La version dépendante existe au fonds et étend le cadre aux types qui dépendent de valeurs, ce qui est la situation du chapitre 3.

#### Suivi d'avancement

1.  \[DONE\] choudhuryDependentDependencyCalculus2022

2.  \[DONE\] rajaniGradedModalRelaxed2025

### \[DONE\] \[#A\] La déclassification sémantique RELÂCHÉE par modalités graduées : est-ce le dispositif que l'axe confidentialité cherche ?

    ARC: K | QUID: QK-16 | REF: rajaniGradedModalRelaxed2025

Oui, et le point de conception est net : la déclassification demande une modalité DE PLUS, non un relâchement de celle qui existe. Les auteurs héritent la monade graduée de classification et lui AJOUTENT une nouvelle modalité dédiée à la déclassification, le critère retenu s'inspirant de la divulgation délimitée et de la non-interférence relâchée — les deux notions dont le document a besoin pour sa divulgation bornée. Conséquence pour K7PL : ses échappatoires nommées devraient être une modalité distincte et non une exception à la première, ce qui rend leur ensemble énonçable comme un TYPE plutôt que comme une liste — et referme du même coup la question de savoir s'il est clos.

#### Suivi d'avancement

1.  \[DONE\] rajaniGradedModalRelaxed2025

### \[DONE\] \[#A\] Les canaux de terminaison et de temps en flot d'information concurrent : K7PL les ferme-t-il, ou les borne-t-il seulement à ce que le typage voit ?

    ARC: K | QUID: QK-17 | REF: stefanAddressingCovertTermination2012

Il ne fait ni l'un ni l'autre aujourd'hui, et le moyen de les borner est à portée. Le canal de terminaison a une bande passante LIMITÉE en séquentiel et devient BIEN PLUS DANGEREUX en concurrent — ce qui autorise déjà une garantie PAR COUCHE plutôt qu'une garantie globale, forme la plus honnête dont le document dispose. Le remède des auteurs est de combattre le feu par le feu : placer les actions potentiellement non terminantes, ou celles dont le temps dépend de valeurs secrètes, dans des FILS SÉPARÉS portant chacun une ÉTIQUETTE COURANTE qui suit la sensibilité des données observées et restreint les emplacements où le fil peut écrire. Or un acteur est un fil à état privé et la composante de niveau du grade est cette étiquette : le dispositif se lit presque terme à terme dans le document, sans y être revendiqué ni imposé.

#### Suivi d'avancement

1.  \[DONE\] stefanAddressingCovertTermination2012

### DOING \[#B\] Les cônes intégrables portent-ils une exponentielle GRADUÉE sur ℛ ?

    ARC: F | QUID: QF-21 | REF

Question ouverte par le focus route 4 du 9 septembre 2026, et c'est la SEULE que ce focus laisse ouverte. Elle est posée ici plutôt que dans un livrable pour qu'elle se réévalue avec les autres, et non le jour où quelqu'un se rappellera d'un fichier.

CE QUI EST ACQUIS, ET QU'IL NE FAUT PAS REFAIRE. Les cônes intégrables forment un modèle de la logique linéaire, et la théorie de l'intégration qui leur manquait — l'ingrédient qui interprète les primitives d'échantillonnage — est développée, pour l'appel par valeur comme pour l'appel par poussée de valeur. L'extension probabiliste de K7PL ne demande donc aucun connecteur nouveau : l'échantillonnage est une opération algébrique ordinaire, et le régime d'évaluation retenu au chapitre 1 est celui que le résultat vise.

CE QUI BLOQUE. Ce modèle offre DEUX comonades exponentielles — l'une sur les fonctions stables et mesurables, l'autre sur les fonctions analytiques intégrables — et aucune n'est graduée. Le jugement germinal n'en demande pas une : il en demande une famille indexée par ℛ, avec déréliction au seul grade neutre, comultiplication indexée par le produit et contraction indexée par la somme. Rien n'établit que les constructions graduées se transportent à ce cadre, la littérature des cônes visant la sémantique probabiliste et non la sémantique quantitative des ressources.

CE QUI ROUVRE LA QUESTION, et il suffit d'un des trois. Un travail qui gradue une exponentielle de cônes, ou qui transporte au cadre des cônes la construction de modalité graduée sur une structure ordonnée. Une décision de faire entrer l'inférence probabiliste au périmètre, qui rendrait le modèle nécessaire plutôt que souhaitable. Ou un modèle concret retenu pour *C* par une autre voie, dont il faudrait alors vérifier qu'il porte l'échantillonnage.

CE QUI NE LA ROUVRE PAS. Le fait qu'un modèle porte des biproduits finis, ni qu'il soit enrichi sur les monoïdes commutatifs. Le focus a établi que l'implication va de la codéréliction vers l'additivité et non l'inverse, et que la codéréliction est unique : ce qui décide est la LIBERTÉ de l'exponentielle, non son additivité. Le chapitre 2 le dit désormais.

POURQUOI CE N'EST PAS URGENT. L'inférence probabiliste est déclarée hors périmètre. Rien n'oblige à lui trouver un modèle, et le focus a montré qu'elle ne demanderait aucun mécanisme neuf le jour où on la prendrait. Ce qui reste ouvert n'est pas un obstacle : c'est une question dont on sait maintenant qu'elle est la seule.

#### Suivi d'avancement

1.  \[DONE\] ehrhardIntegrationCones2025

2.  \[TODO\] le pont entre gradation et cônes — aucune source identifiée à ce jour
