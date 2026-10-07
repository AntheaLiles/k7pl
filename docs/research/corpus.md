# K7PL — le corpus, et ce qu'il permet de lire

28 août 2026

> Les résumés d'éditeurs que portait le fichier d'origine (blocs `ABSTRACT`) sont retirés : ce sont des textes de tiers. Les synthèses et les analyses sont celles de l'auteur.

## ÉTAT AU 3 SEPTEMBRE — *à lire avant tout ce qui suit*

> \*/IL N'Y A PLUS QU'UN SEUL INVENTAIRE. Le partage entre un « fonds-projet » de quatre cents clés et une « bibliothèque » de quatre mille est CADUC, et avec lui les comptes que les sections datées ci-dessous rapportent./\*

***LA HIÉRARCHIE, ET C'EST LA RÈGLE D'ANTHEA.*** `bib/K7PL-Biblio/refs-pour-citations.bib` est la RÉFÉRENCE ABSOLUE — clés, titres, résumés, dates, identifiants — et l'on passe toujours par là. 4 326 entrées. `bib/K7PL-Biblio/K7PL-Biblio.bib` ne se consulte que pour retrouver le CHEMIN D'UN PDF, et pour rien d'autre : ses chemins sont relatifs, quand ceux de la référence sont absolus sur la machine d'Anthea. 4 325 entrées, l'écart étant `UnicodeStandardV17`, qui n'a pas de pièce jointe.

***LE RDF N'EXISTE PLUS***, supprimé le 3 septembre, l'export en deux fichiers BibTeX le rendant sans objet. Le champ `:RDF:` que portent les fiches ci-dessous n'est plus lu par aucun outil : c'est une donnée d'histoire, conservée, et non un état à maintenir.

***CE QUI EST VRAI AUJOURD'HUI*** : 249 clés citées au manuscrit, toutes présentes au fonds et toutes lisibles au registre ; 4 290 PDF dont le chemin existe réellement sur le disque.

***POURQUOI LES SECTIONS SUIVANTES SONT CONSERVÉES TELLES QUELLES.*** Elles portent chacune leur date et le raisonnement qui a produit leur compte. Les réécrire effacerait la trace de ce qui a été cru, or plusieurs leçons de méthode viennent précisément de comptes qui se sont révélés faux. Elles se lisent comme des instantanés, jamais comme l'état courant.

## LE RECENSEMENT RÉEL — *établi le 28 août sur les sources, non sur la mémoire*

Ce recensement corrige un chiffre que j'avais donné trop bas. Il distingue cinq ensembles qui ne se recouvrent que partiellement, et il donne pour chacun la mesure prise sur le fichier plutôt que sur le souvenir.

Le corpus de recherche est l'export Zotero : 4 308 entrées lisibles, dont 4 122 portent un PDF. C'est ce dans quoi on cherche, et il n'est pas destiné à être lu en entier.

Le fonds est refs.bib : 407 entrées, toutes présentes dans l'export. 281 portent un PDF, 126 n'en portent pas — dont une trentaine sont des spécifications et des pages web, légitimement sans PDF, et 96 sont des articles, thèses ou chapitres. L'état « un seul PDF manque » que nous avions atteint valait pour la liste de sourçage de bib/A-CHARGER.md, et il est exact : sur ses dix-huit clés, dix-sept ont leur PDF et seule arntzenius2025FiniteFunctionalProgramming n'en a pas, paywallée sans version auteur. Il ne valait pas pour le fonds entier.

Les traces d'exploration par clé de citation donnent 257 clés distinctes : 126 citées au manuscrit, 122 désignées au chantier par un marqueur cite, 95 portant une décision bibliographique datée dont le motif est l'enseignement consigné le jour du dépouillement, et 27 en attente d'import dans Zotero. L'union sans double compte est de 257, dont 214 sont au fonds et 43 n'existent que dans l'export.

Les documents segmentés forment un quatrième ensemble que les clés ne voient pas. Dix-sept dossiers de corpus/ et ref/ ont été découpés en documents constitutifs, puis chaque document identifié par sa page de titre, son colophon et ses identifiants : 283 documents distincts, dont 72 étaient déjà au fonds et 211 ne l'étaient pas. La répartition des manquants par identifiant disponible est de 117 DOI, 28 arXiv, 16 URL et 60 par titre seul. Ces documents ont leur PDF, puisqu'ils viennent des dossiers eux-mêmes ; ils n'ont pas été importés dans Zotero et n'ont pas été dépouillés. Ils sont recensés ci-dessous sous des clés préfixées SEG-, qui sont des clés de travail et non des clés Zotero.

La littérature grise forme le cinquième ensemble, et elle n'a pas de clés du tout. Le fichier OLD/chantier/litterature-grise.org porte 6 561 lignes et 154 sections de dépouillement : trente-cinq fils de discussion dépouillés selon une fiche unique conçue avant lecture, des articles techniques, la documentation de plusieurs langages à glyphes, et une campagne autonome en trois phases. Ces sources ont produit des enseignements consignés — le paradoxe d'adoption, le critère de premier contact, le coût d'un mot-clé au noyau, l'échappatoire de Rust, le fil qui attaque la prémisse de l'inexprimable — mais elles ne sont pas des références bibliographiques et ne peuvent pas être citées comme telles.

Le total exploré, sans double compte, est donc de l'ordre de cinq cents pièces : 257 par clé, 211 par segmentation, et une quarantaine de sources grises nommées. Le chiffre de 269 que j'ai donné plus tôt ne comptait que la première colonne.

## APPORT DU 1er SEPTEMBRE — *passe manuelle d'Anthea sur le RDF*

Analysé le 1er septembre en comparant le RDF exporté ce jour au registre du 28 août. Le fonds a DEUX inventaires et ils ne mesurent pas la même chose : le RDF est la bibliothèque entière, quatre mille trois cent vingt et une entrées ; refs.bib est le FONDS-PROJET, quatre cents clés, et c'est lui que le contrôle interroge.

### L'apport en chiffres

|  |  |
|----|----|
| ***22 entrées nouvelles*** | *dont les six manques sourcés la veille, plus les deux clés de langages de tableaux* |
| ***129 PDF nouveaux*** | *sur des entrées qui n'en déclaraient AUCUN. Aucun PDF récupéré au sens d'un chemin réparé : ce sont des collectes* |
| ***9 clés disparues*** | *dont sept par renommage en bibliothèque, et DEUX qui ont cassé une citation* |

### Ce qui compte le plus : VINGT-HUIT RÉFÉRENCES CITÉES DEVIENNENT VÉRIFIABLES

Sur les cent vingt-neuf PDF nouveaux, vingt-huit portent sur des références CITÉES AU MANUSCRIT et qui n'avaient jusqu'ici aucun PDF au fonds. Elles étaient donc citées sans être consultables, ce qui est exactement ce que la méthode bibliographique du projet interdit. Parmi elles, plusieurs sont des appuis de THÉORÈME ou d'ARGUMENT : la cohérence de Kelly et Mac Lane, les catégories monoïdales closes tracées, la sémantique par objets de Reddy et sa passivité, les conteneurs indexés, la syntaxe et la sémantique de la théorie quantitative, la machine chimique, les catégories différentielles, les flux monoïdaux pour le flot de données, la complexité du datalog à limites, la spécification VirtIO, et la note du Disruptor. *Les citer restait licite ; les vérifier ne l'était pas. Ce n'est plus le cas.*

### Ce qui a cassé, et c'est réparé à une clé près

Deux clés citées ont disparu du fonds-projet par renommage en bibliothèque. Le contrôle les a arrêtées, ce qui est son office.

|  |  |
|----|----|
| `DISRUPTOR` | *→ `thompsonDisruptorHighPerformance2011` — renommée au manuscrit, la nouvelle clé étant AU fonds-projet. Réparé* |
| `WASM` | *→ `groupWebAssemblySpecification` — renommée au manuscrit, mais la nouvelle clé n'est PAS au fonds-projet. ****Une action reste due, et elle est dans Zotero***** |

### Les segmentés : quarante-sept des soixante-dix-huit sont désormais au RDF

Rapprochement par titre, seuil de correspondance à quatre-vingts pour cent. Quarante-sept des soixante-dix-huit entrées segmentées sans identifiant ont désormais une entrée de bibliothèque, dont les TROIS SPÉCIFICATIONS DE FORMAT que le théorème d'isomorphisme mémoire invoque — Arrow, Cap'n Proto et SBE. Trente et une restent absentes. *Leur clé de corpus reste toutefois la clé SEG-, et leur clé de bibliothèque est autre : les deux inventaires ne se sont pas rejoints, ils se sont recouverts. Un rapprochement des clés reste à faire.*

## LES RÉFÉRENCES À CITER

### reynoldsGEDANKENSimpleTypeless1970

    AUTHORS: John C. Reynolds | DATE: 1970 | TITLE: GEDANKEN — a simple typeless language based on the principle of completeness and the reference concept | REVUE: Communications of the ACM 13(5) | IDENTIFIANT: 10.1145/362349.362364 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 : ancêtre des postulats ; A.3.1 complétude graduée | SYNTHESE: t

#### \[DONE\] Le principe de complétude, et sa version graduée

Toute valeur permise dans un contexte l'est dans tout autre contexte signifiant. K7PL restreint par la couche et par le grade ; la question est de savoir si ces restrictions sont ad hoc ou si elles sont le contenu du jugement. Sous la seconde lecture le principe se reformule : aucune restriction qui ne soit exprimée dans le jugement. C'est un énoncé vérifiable contre la liste des primitives, et il dit que délimiteurs et grades doivent être les seules restrictions. Proposé comme théorème à créer (A.3.1).

#### \[DONE\] Problème ouvert (3) : le coût en pile de la complétude

Reynolds : un inconvénient sérieux du principe de complétude est l'élimination de toute discipline de pile, de sorte que tout le stockage doit être récupéré par ramasse-miettes. Il imagine deux remèdes : des facilités de langage pour indiquer les contextes où une discipline de pile est applicable, et une analyse de programme appuyée sur des déclarations de type. Ce sont exactement les délimiteurs de couche et les grades de K7PL. P3 est donc la réponse à un problème posé en 1970 par celui qui l'a identifié, avec les deux moyens qu'il avait désignés.

#### \[DONE\] Problème ouvert (4) : les effets sans perdre l'indépendance à l'ordre

Reynolds décrit le choix entre imposer un ordre fixe d'évaluation ou admettre des interprétations indéterminées, puis espère une troisième voie : une forme limitée de traits impératifs ajoutée à un langage applicatif sans détruire l'indépendance à l'ordre d'évaluation. C'est la définition des effets algébriques, et c'est P4.

#### \[DONE\] Problème ouvert (1) : ajouter les types sans détruire la généralité

Qualifié de problème théorique majeur. Reynolds précise la difficulté : si un enregistrement est traité comme une fonction, il faut pouvoir spécifier que le codomaine dépend de l'argument. C'est le cahier des charges d'un type dépendant, et K7PL part du λΠ.

#### \[DONE\] La méthode de démonstration par exemples

L'originalité réside dans les traits exclus, et le but est de démontrer que ces exclusions n'altèrent pas la généralité ; à cette fin l'article inclut de nombreux exemples de programmation. Cela donne son statut à R-54 : écrire du pseudocode n'est pas un complément ergonomique, c'est la forme que prend la démonstration. Et l'ordre suivi par Reynolds est celui qu'Anthea a arbitré : notation fixée d'abord, exemples ensuite.

#### \[DONE\] La première implantation est une transcription

Une implantation complète mais extrêmement inefficace, produite en traduisant la définition formelle en LISP, et servant à vérifier tous les exemples. Fidélité et non performance. C'est la version la moins coûteuse du versant implantation que R-42 dit manquer, et elle est accessible à un auteur seul.

### hudakHistoryHaskellBeing2007

    AUTHORS: Paul Hudak, John Hughes, Simon Peyton Jones, Philip Wadler | DATE: 2007 | TITLE: A History of Haskell: being lazy with class | REVUE: HOPL III | IDENTIFIANT: 10.1145/1238844.1238856 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 : B1, B2, B15 ; A.3.3 interface ; Q21 ; Q23 | SYNTHESE: t

#### \[DONE\] La paresse a un coût en espace, et le remède est de rendre la strictesse écrivable

Le coût principal n'est pas le facteur constant de l'appel par nécessité mais l'imprévisibilité du comportement en espace, y compris pour des programmeurs expérimentés, avec un enjeu qui dépasse le facteur constant. La prévalence des fuites d'espace a conduit à ajouter des traits stricts, seq et les types de données stricts. C'est le quatrième appui de P3 et le plus fort, car il vient du trait définitoire du langage.

#### \[DONE\] Le clivage strict/paresseux cesse d'être tout-ou-rien

Les auteurs concluent que le clivage est devenu bien moins une décision tout-ou-rien. Haskell y est arrivé par accrétion ; le grade de K7PL pose la position intermédiaire comme structure. Argument que le document ne fait pas.

#### \[DONE\] Une contrainte vaut par ce qu'elle rend impossible

Le plus grand bénéfice de la paresse n'est peut-être pas la paresse mais qu'elle a gardé le langage pur, la tentation des effets non restreints étant presque irrésistible dans un langage par valeur. Le chapitre 1 de K7PL présente ses postulats par ce qu'ils garantissent, jamais par la porte commode qu'ils ferment.

#### \[DONE\] Un objectif n'est pas un mécanisme

La sémantique formelle était un objectif explicite, avec la Définition de SML en modèle, et n'a jamais été atteinte : non par choix, mais parce que la tâche n'a jamais semblé la plus urgente et que personne ne l'a entreprise. SML y est arrivé parce qu'il avait un critère d'achèvement. R-53 : quel est celui de K7PL, et est-il écrit ?

#### \[DONE\] Le système de modules, et l'abandon des interfaces

Le système de modules est un mécanisme de contrôle d'espace de noms, rien de plus, spécifié séparément du système de types. Les interfaces, présentes jusqu'en 1.3, sont abandonnées en 1.4 ; il en résulte que le langage manque d'un moyen formellement vérifié d'annoncer l'interface qu'un module supporte. Avec SML, cela fait deux échecs symétriques dont la perte commune est une interface vérifiée et stable entre unités de compilation.

#### \[DONE\] L'espace de noms plat mord tôt

Deux bibliothèques de collections ne peuvent pas toutes deux employer le nom Map. Corrigé par des noms hiérarchiques empruntés à Java. R-64 : le mécanisme de namespace de K7PL est une vue sur le graphe de dépendances et ne désambiguïse pas les noms.

#### \[DONE\] L'interface étrangère, chiffrée

Des mécanismes ad hoc et spécifiques à chaque implantation, puis un effort de standardisation traitant C comme plus petit dénominateur commun. Trente pages, deux ans, et la volonté d'une seule personne pour le conduire. Ordre de grandeur pour l'arbitrage 26b.

#### \[DONE\] La loi de Wadler sur les commentaires

La sémantique est discutée moitié moins que la syntaxe, elle-même moitié moins que la syntaxe lexicale, elle-même moitié moins que la syntaxe des commentaires. L'arbitrage 23 a clos la question en trois lignes ; c'est le sujet sur lequel un projet peut se perdre le plus longtemps.

#### \[DONE\] Deux mécanismes de comité qui valident deux pratiques

Un critère semi-formel employé comme filtre — la question rituelle de la compositionnalité — a rendu plus difficile l'infiltration de traits ad hoc, ce qui est l'office de la condition de clôture. Et un Tsar de la syntaxe, habilité à trancher les seules matières syntaxiques : une question de syntaxe se clôt par un terminateur, non par consensus.

### berryLessonsDesignStandard1993

    AUTHORS: Dave Berry | DATE: 1993 | TITLE: Lessons from the design of a Standard ML library | REVUE: Journal of Functional Programming 3(4) | IDENTIFIANT: 10.1017/S0956796800000873 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 ou c6 : B7 ; arc G nommage ; facture de T-68 | SYNTHESE: t

#### \[DONE\] La facture d'un noyau minimal

La Définition de SML ne définit, tout à fait intentionnellement, que quelques opérations de base ; cette base initiale n'est pas adéquate pour de vrais programmes, si bien que les implémenteurs ont ajouté les leurs et que les implantations sont devenues incompatibles. C'est la dette que contracte le geste de T-68, et elle se paie dans la définition ou N fois dans les implantations. La surface au-dessus des primitives de K7PL est plus grande que celle de SML.

#### \[DONE\] Écrire une bibliothèque est le test le moins cher d'un langage

Les concepteurs devraient essayer d'écrire quelques bibliothèques dans leur langage, autant que des applications, de sorte que les problèmes soient attrapés tôt. Berry en a tiré que le système de modules de SML, explicitement conçu pour la programmation en grand, n'y parvient pas sans foncteurs d'ordre supérieur — insuffisance invisible dans la sémantique et dans les théorèmes. Fonde R-54.

#### \[DONE\] Le nommage est l'interface utilisateur d'une bibliothèque

Un schéma de noms cohérent évite d'avoir à retenir des noms différents pour des fonctions similaires. Trois règles : le même nom pour la même opération partout ; la qualification de module rend la répétition redondante ; et la convention typographique ne sert que là où le langage ne sépare pas lui-même les espaces de noms.

#### \[DONE\] La curryfication et l'ordre d'évaluation

L'optimisation d'une application curryfiée complète n'est pas sûre en présence d'effets, car l'ordre des effets change, et souvent on ne peut pas savoir si une expression produira un effet de bord. Chez K7PL le jugement le dit : l'optimisation est décidable. Acquis du système d'effets, à revendiquer en deux phrases.

#### \[DONE\] Un choix sémantique élégant peut coûter au contact du matériel

La Définition définit une exception séparée par opération arithmétique, ce qui ne correspond pas aux exceptions matérielles de la plupart des processeurs et réduit l'efficacité des implantations. Cinquième appui de P3.

#### \[DONE\] Ce que la Définition laisse imprécis diverge

La Définition dit ce qui arrive quand on lit un flux fermé, sans définir ce que fermé veut dire. Troisième instance du même mécanisme, après la surcharge chez SML et le statut des noms de champs au R7RS.

### appelCritiqueStandardML1993

    AUTHORS: Andrew W. Appel | DATE: 1993 | TITLE: A critique of Standard ML | REVUE: Journal of Functional Programming 3(4) | IDENTIFIANT: 10.1017/S0956796800000836 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 : B5, B16 ; c5 : règle des étiquettes | SYNTHESE: t

#### \[DONE\] Les trois questions, et K7PL en traite une

Les deux questions les plus importantes sur un langage sont : est-il implantable, est-il utile. K7PL en traite une troisième, est-il démontrable. Ce n'est pas un défaut mais un état à nommer, avec le calendrier de sa levée : T-69, puis l'arc G, puis R-54, puis l'interprète fidèle.

#### \[DONE\] Pourquoi les théorèmes ne suffiront pas

Les bons côtés d'un langage sont généraux et importants ; ses défauts tendent à être étroits, techniques et sans grand intérêt théorique, et ils affectent tous l'utilisabilité. Un projet qui se valide uniquement par ses théorèmes accumulera exactement la classe de défauts que les théorèmes ne regardent pas. Troisième motif indépendant pour R-54.

#### \[DONE\] P3 est le critère de sécurité de Hoare étendu aux ressources

Appel ouvre sa section sur la sûreté par Hoare 1973 : aucune erreur ne peut donner lieu à des effets dépendants de la machine ou de l'implantation, inexplicables dans les termes du langage lui-même. Ce que Hoare exige du comportement, P3 l'exige du coût.

#### \[DONE\] Le piège du constructeur mal orthographié

Il n'y a aucune distinction syntaxique entre constructeurs et variables, donc tout identifiant non déclaré comme constructeur est interprété comme une variable qui filtre n'importe quoi : un constructeur mal orthographié est accepté par le compilateur. Le remède connu est la convention de casse de Prolog, adoptée par Haskell. Règle générale : là où deux espaces de noms se recouvrent sans que le langage les sépare, une faute de frappe devient un programme bien typé.

#### \[DONE\] Ce qu'un implémenteur valorise, dans son ordre

Liste par ordre décroissant d'importance : la sûreté d'abord, le ramasse-miettes ensuite ; le polymorphisme, l'inférence et les fonctions d'ordre supérieur viennent après. Le trait de vitrine n'est pas celui qui décide un praticien.

### macqueenHistoryStandardML2020

    AUTHORS: David MacQueen, Robert Harper, John Reppy | DATE: 2020 | TITLE: The History of Standard ML | REVUE: HOPL IV | IDENTIFIANT: 10.1145/3386336 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c2 : le langage Bare ; Q21 ; Q30 ; A.3.3 ; C1 | SYNTHESE: t

#### \[DONE\] Le langage Bare, précédent exact de T-68

Le Core est divisé en un ensemble essentiel et minimal de constructions, le langage Bare, dont le reste est dérivé, de sorte que la sémantique n'a à traiter que les constructions du Bare. C'est le geste de T-68, en 1990.

#### \[DONE\] Et son coût : la grammaire complète reste due

Le même article impute à ce geste le premier défaut de la Définition : il n'y a pas de spécification de la syntaxe complète, de nombreux traits étant définis comme formes dérivées, et la grammaire est ambiguë en plusieurs endroits. La liste des primitives borne la sémantique, pas la syntaxe.

#### \[DONE\] Le critère d'achèvement

La conception n'était pas considérée comme terminée tant que la définition n'était pas complète. T-69 n'est donc pas un supplément mais la condition d'achèvement. Et la question de Milner : qu'est-ce que cela signifie, pour un langage, d'exister.

#### \[DONE\] La compilation séparée, jamais standardisée

La conception ne traite pas la question ; la Définition spécifie un programme comme une séquence linéaire de déclarations de niveau supérieur. Les dépendances portent sur l'interface et sur l'implantation, la translucidité de l'appariement de signatures étant la cause nommée. L'idée de Milner en 1983 — une directive déclarant les identifiants employés mais non définis, autorisant la précompilation — a été écartée. Toutes les solutions ultérieures sont liées à une implantation, et le manque de standardisation a coûté la portabilité.

#### \[DONE\] Les messages d'erreur de types

Plus de quarante publications dont quatre thèses. Beaucoup impliquent une instrumentation, c'est-à-dire l'annotation des structures avec des informations de type ou de localisation — ce qu'un vérificateur à règles possède déjà. L'ordre de parcours employé par les descriptions théoriques n'a pas été conçu pour de bons messages et n'est pas optimal ; les vérificateurs ont une grande liberté sur cet ordre, et elle décide de la localité. Enfin le flux à longue distance peut être interrompu par les frontières de module.

#### \[DONE\] L'égalité polymorphe, que deux concepteurs voulaient retirer

Piège de performance caché, temps proportionnel à la taille, et notion souvent fausse pour une abstraction de données. Harper et MacQueen ont suggéré son retrait lors de la Définition révisée.

#### \[DONE\] Les omissions avouées et l'interface étrangère

Trois omissions : la syntaxe complète, le mécanisme d'assemblage, l'interface avec le code étranger. Pour cette dernière, la cause nommée est la pluralité des modèles de compilation — les compilateurs par lots lient statiquement, les interprètes dynamiquement. K7PL vise un unikernel et n'en a qu'un.

### clingerHygienicMacroTechnology

    AUTHORS: William D. Clinger, Mitchell Wand | DATE: 2020 | TITLE: Hygienic macro technology | REVUE: HOPL IV | IDENTIFIANT: 10.1145/3386330 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c5 : B12 binds ; note de thm:hygiene ; R-49 | SYNTHESE: t

#### \[DONE\] Rabbit 1977, troisième précédent de T-68

Le compilateur ne traite qu'un petit ensemble de base reflétant la sémantique du lambda-calcul, toutes les constructions traditionnelles étant des macros sur cet ensemble, et le code produit est aussi bon que celui des compilateurs traditionnels. Steele ajoute que l'approche permet une implantation rapide de constructions nouvelles sans sacrifier l'efficacité : le noyau minimal est un atout d'évolution.

#### \[DONE\] Le coût de l'expansion n'est borné par rien

L'algorithme de Kohlbecker est quadratique pour les macros récursives et exponentiel sur un exemple que l'article donne, fait peu connu. Son inefficacité asymptotique a limité son influence. P3 porte sur le coût à l'exécution ; celui-ci est un coût de compilation, et le confinement de la Phase 0 chez K7PL porte sur les capacités et non sur le coût. R-49.

#### \[DONE\] L'échappement contrôlé, et ce qui arrive s'il n'est pas conçu

Certaines macros lient implicitement des identifiants destinés au site d'appel : une macro d'enregistrement qui engendre des accesseurs, une boucle qui lie exit. L'extraction de Petrofsky permet de les définir sans violer la condition d'hygiène, mais elle est difficile, quadratique, et surtout non composable : toutes les macros qui lient un même identifiant doivent être définies avec connaissance les unes des autres. Le binds de K7PL, en mettant l'extension de portée dans le type, dissout ce défaut.

#### \[DONE\] Ce qu'un théorème d'hygiène doit énoncer

Ce qu'on cherchait à empêcher, ce sont les captures inadvertantes ; contrarier les captures délibérées n'était pas un objectif, la capture délibérée étant tenue pour une technique légitime. Il est facile de prendre une définition vague de l'hygiène et d'en conclure à tort, d'où une appréciation renouvelée de l'importance des preuves rigoureuses. Clinger et Rees avaient revendiqué l'hygiène forte sans preuve pendant trente ans. Le chapitre 5 de K7PL est exactement à cette position et y est arrivé par sa méthode propre.

#### \[DONE\] Une ambiguïté de définition est une divergence en sursis

Le R7RS ne dit pas si les noms de champs sont des symboles ou des identifiants, ce qui change le comportement des macros et divise les éditeurs. Même mécanisme que la surcharge chez SML.

### hickeyHistoryClojure2020

    AUTHORS: Rich Hickey | DATE: 2020 | TITLE: A history of Clojure | REVUE: HOPL IV | IDENTIFIANT: 10.1145/3386321 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c5 : B13 glyphes ; c1 : B15 ; QH-14 | SEGMENT: SEG-hickeyHistoryClojure2020 | DOSSIER: corpus/N-ergonomie-esthetique.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] L'obstacle à l'adoption est le déploiement, pas la syntaxe

L'obstacle premier à l'adoption par des professionnels est l'acceptabilité pour les développeurs et les décideurs, et la réponse de Clojure est l'hébergement : entrer en douce comme une bibliothèque Java. Avec Oz, cela fait deux Lisps hors du courant majoritaire, deux issues opposées, et la différence désignée par les auteurs eux-mêmes n'est pas l'orthographe. K7PL vise un unikernel et n'a pas d'hôte : les contrats d'interface de couche 1 sont ce qu'il a à la place.

#### \[DONE\] Les macros de lecture, refusées délibérément

Elles donnent à l'utilisateur tout pouvoir de créer un langage de sa spécification, mais de tels langages sont des îles, car lire une donnée exige alors un code spécifique. Hickey se dit certain que l'écosystème de bibliothèques composable n'aurait pas émergé. C'est l'argument qui manquait à l'arbitrage 15 : le glyphe de K7PL est une macro de bibliothèque avec alias, non une macro de lecture.

#### \[DONE\] La lecture doit être une fonction pure du texte

Le lecteur à internement crée une interaction avec état entre la lecture et l'environnement d'exécution, brisant la nature fonctionnelle de texte vers structures de données, et gênant le contrôle de l'évaluation par les macros. D'où le bien-fondé de déclarer un glyphe par son point de code : un point de code est une donnée du texte, pas une consultation d'environnement.

#### \[DONE\] Les délimiteurs de Clojure ne marquent pas de régime

Vecteurs et tables sont ajoutés au lecteur comme littéraux de données ; Clojure emploie occasionnellement les vecteurs dans sa syntaxe de langage, mais ce n'est pas pour cela qu'ils sont là. Comme chez Oz, les mêmes paires font un travail différent du nôtre.

#### \[DONE\] Le regret des transducteurs

La présence de conj dans les fonctions de réduction enchevêtre la transformation essentielle avec un processus concret ; en le passant en argument on obtient des objets qui se composent par composition ordinaire, sans souci du contexte final, et qui dispensent d'un compilateur suffisamment intelligent. Hickey conclut qu'il les mettrait tout en bas s'il refaisait le langage. Meilleure réponse à QH-1 : le regret porte sur une décomposition trouvée trop tard, non sur un trait de trop.

#### \[DONE\] La plainte chronique porte sur les messages d'erreur des macros

Les utilisateurs rapportent perpétuellement leur insatisfaction quant aux messages du compilateur et des diverses macros. Dans une architecture où tout ce qui est au-dessus du noyau est macro, toute erreur sort d'une expansion. Quatrième source sur la question 30, et la plus directement dirigée sur l'architecture de T-68.

#### \[DONE\] Deux points de gouvernance

La stabilité vient de la position dans la pile : le langage étant au fond des programmes, il ne pouvait pas être un laboratoire, et le changement cassant est strenuously évité. Et l'open source engendre des présomptions de développement collaboratif qui peuvent contredire le maintien d'une singularité de vision.

### vanroyHistoryOzMultiparadigm2020

    AUTHORS: Peter Van Roy, Seif Haridi, Christian Schulte, Gert Smolka | DATE: 2020 | TITLE: A history of the Oz multiparadigm language | REVUE: HOPL IV | IDENTIFIANT: 10.1145/3386333 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 : P3 par l'explicité ; R-42 | SYNTHESE: t

#### \[DONE\] L'explicité comme leçon d'échec, non comme choix a priori

Quatre opérations rendues implicites au départ ont été retirées après usage : la concurrence, l'état mutable, la paresse, la recherche. Sur la paresse : la rendre explicite simplifie grandement le raisonnement sur la complexité. C'est P3, tiré d'un retour d'expérience de trente ans.

#### \[DONE\] Implémenteur ET théoricien

La méthodologie combinait implantation efficace et sémantique formelle simple, ce qui a été possible parce que les développeurs étaient à la fois des implémenteurs pratiques et des informaticiens théoriciens. Brooks reprochait à Common Lisp d'être conçu par des implémenteurs seuls ; K7PL est théoricien seul. R-42 se précise : la réserve n'est pas le risque de la théorie mais l'absence du versant implantation.

#### \[DONE\] Changer de syntaxe après adoption

Le remède connu est un langage frère sur la même machine — Elixir sur la machine d'Erlang — et non une révision en place. Répond à QH-3.

#### \[DONE\] Deux rapprochements retirés le 28 août

Les trois paires de délimiteurs d'Oz servent des constructeurs de données — enregistrements, listes, fonctions — et non un marquage de couche : le rapprochement avec K7PL ne tient pas, et R-44 est retirée avec son motif. Et le seuil créé par sa syntaxe ne se transporte pas : Oz inventait sa forme, K7PL hérite de celle de Lisp. Correction d'Anthea : les mots sont proches, le contexte décide de leur poids.

### brooksCritiqueCommonLISP1984

    AUTHORS: Rodney A. Brooks, Richard P. Gabriel | DATE: 1984 | TITLE: A critique of Common LISP | REVUE: ACM Symposium on LISP and Functional Programming | IDENTIFIANT: 10.1145/800055.802015 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 : P3, R-42, la méthode de T-68 | SYNTHESE: t

#### \[DONE\] Quatre critères, dont le premier est la méthode de T-68

Concision intellectuelle : un langage doit tenir tout entier dans la tête d'un programmeur, ce qui s'obtient par la régularité et par une approche disciplinée de l'introduction des primitives. Puis la simplicité du compilateur, chiffrée à un homme-an au maximum ; l'efficacité à l'exécution, où un petit programme doit tourner dans une petite quantité de mémoire ; et la facilité de programmation, où le programmeur ne doit pas être forcé à un grand nombre de déclarations.

#### \[DONE\] Le cas documenté qui motive P3

La généralité même de la conception, avec ses profils d'efficacité différents selon l'architecture, travaille contre la portabilité. L'exemple est l'arithmétique d'indexation d'un tableau général, recalculée à chaque tour sur une machine et cachée sur une autre. Un coût invisible dans la sémantique, énorme ici et nul là.

#### \[DONE\] La composition du groupe a un effet technique

Conçu par des implémenteurs avec des croyances sur ce qui est possible, plutôt que par des utilisateurs avec des croyances sur ce qui est probable ; et il n'y avait pas de voix forte des implémenteurs travaillant sur du matériel standard. K7PL est dans une troisième position, conçu depuis un cadre théorique, dont le risque symétrique vaut d'être nommé.

### symeEarlyHistory2020

    AUTHORS: Don Syme | DATE: 2020 | TITLE: The Early History of F# | REVUE: HOPL IV | IDENTIFIANT: 10.1145/3386325 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c5 : B14 délimiteur-régime ; c3 : R-47 | SYNTHESE: t

#### \[DONE\] Le délimiteur qui réinterprète, devenu standard industriel

F# est le premier langage à introduire une modalité async permettant la réinterprétation localisée des constructions de contrôle existantes : convertir du synchrone en asynchrone demande d'entourer le code de async { }. C'est le travail des délimiteurs de couche de K7PL, et cette fois le rapprochement porte sur la fonction et non sur les mots. Le mécanisme est devenu standard de fait dans six langages. Ce qui est neuf chez K7PL n'est pas le geste mais que le régime soit un grade.

#### \[DONE\] Le troisième concepteur à regretter l'égalité structurelle générique

La comparaison générique héritée d'OCaml aurait pu être omise : implantation compliquée par les cas limites comme NaN, et implications de performance. Le remède nommé est « ou fortement contraint », c'est-à-dire porté par une contrainte de type. Avec SML, cela fait trois concepteurs sur deux langages à vingt-trois ans d'intervalle.

#### \[DONE\] Aucun mécanisme presque-général

Les paramètres de type résolus statiquement, conçus pour la seule surcharge d'opérateurs, ont été repris comme mécanisme de contrainte analogue aux classes de Haskell, y compris inappropriément par des débutants ; et il est devenu difficile de corriger sans casser du code existant. Les utilisateurs exploitent toute généralité partielle : un mécanisme est soit général et spécifié, soit franchement particulier. R-57.

#### \[DONE\] La fermeture coûte la continuité

La plus grande faute est que ni .NET ni le langage n'étaient en source ouverte, avec pour effet une discontinuité : les premiers contributeurs partis ne pouvaient plus contribuer. Hickey dit que l'ouverture coûte la vision ; le compromis que les deux décrivent est vision tenue, dépôt ouvert, arbitre nommé.

### brownDevelopmentAPL2Syntax1985

    AUTHORS: James A. Brown | DATE: 1985 | TITLE: A development of APL2 syntax | REVUE: IBM Journal of Research and Development 29(1), p. 37-48 | IDENTIFIANT: DOI non trouvé | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1 : B3 architecture de la méthode ; c5 : ERR-TOP-001, arbitrage 15 | SYNTHESE: t

#### \[DONE\] Chercher la mesure qui rend la règle inutile

Les questions auraient pu être résolues en stipulant de nouvelles règles couvrant les cas, suivies d'une vérification d'absence d'ambiguïté ; au lieu de quoi APL2 emploie la force de liaison, qui rassemble en une seule mesure tous les concepts de syntaxe. Version constructive de la leçon de la question 4 : une position se défend mieux par ce qu'elle rend superflu.

#### \[DONE\] La hiérarchie linéaire contre la matrice

Toute grammaire de précédence se décrit par une matrice, mais même une petite matrice est difficile à retenir et à appliquer en pratique ; d'où une hiérarchie linéaire de classes syntaxiques. La règle d'imbrication de K7PL est de cette forme, et voici son motif ergonomique.

#### \[DONE\] Le nom est un jeton atomique

Les noms sont des unités d'écriture atomiques et indivisibles, même quand ils demandent plus d'un caractère ; une fois identifiés ils sont les jetons de la syntaxe et leur structure n'est plus jamais d'intérêt. C'est le principe sous lequel glyphe et alias ASCII sont deux orthographes du même jeton, donc sous lequel l'arbitrage 15 est fondé.

#### \[DONE\] Ce qui opère sur les noms n'est pas une fonction

La flèche d'affectation ne peut être ni une fonction ni un opérateur, puisque ceux-ci opèrent sur des valeurs et non sur des noms ; elle est dans une classe syntaxique séparée. Critère de tri pour la liste des primitives.

#### \[DONE\] L'architecture de la méthode

Quelques principes généraux, énonçables en règles simples faciles à appliquer, la règle générale étant toujours prête à arbitrer toute ambiguïté ; et les principes donnent un cadre sous lequel d'autres extensions se jugent. C'est l'ordre de prévalence et la condition de clôture, avec un précédent industriel de 1985.

### saalConsiderationsDesignCompiler1978

    AUTHORS: Harry J. Saal | DATE: 1978 | TITLE: Considerations in the design of a compiler for APL | REVUE: IBM Santa Teresa Laboratory, TR 03.045 | IDENTIFIANT: rapport interne, pas de DOI | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: A.3.2 staticité de la syntaxe ; arc I | SYNTHESE: t

#### \[DONE\] Les traits d'espace de noms empêchent l'analyse statique

Les instructions APL ne peuvent pas être analysées statiquement du fait des effets de localisation dynamique ; pire, du fait de traits comme la fixation dynamique de fonctions, on ne peut pas analyser une instruction avant de l'exécuter — la syntaxe après exécution peut différer de celle d'avant. La cause est nommée : ces traits concernent l'espace de noms des objets, plutôt que d'être orientés valeur. Cette phrase est inécrivable pour K7PL, et c'est ce que le confinement de la Phase 0 achète.

#### \[DONE\] Un langage sans hôte livre son environnement

Un processeur pour un langage conventionnel s'appuie sur les composants du système hôte ; les implantations APL fournissent en plus un éditeur, un débogueur, un stockage de bibliothèque et l'accès aux fichiers. Cette attitude explique en grande mesure la ressemblance entre les technologies d'implantation de constructeurs différents. K7PL vise un unikernel : ses implantations convergeraient, au prix de devoir livrer cet environnement.

#### \[DONE\] L'optimisation par reconnaissance d'idiome, et son coût

Reconnaître un usage idiomatique permet de le traiter comme une seule opération sans créer de résultat intermédiaire ; mais ces optimisations demandent du temps de compilation et rendent difficile la corrélation du code traduit avec le source. Troisième source sur cette perte, après le désucrage et les messages de macros.

### griswoldSuggestedRevisionsAdditions1974

    AUTHORS: Ralph E. Griswold | DATE: 1974 | TITLE: Suggested revisions and additions to the syntax and control mechanisms of SNOBOL4 | REVUE: ACM SIGPLAN Notices 9(2) | IDENTIFIANT: 10.1145/987298.987299 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: R-56 format général ; arbitrage 23 par contraste | SYNTHESE: t

#### \[DONE\] Une position privilégiée bloque les extensions

La nature positionnelle du sujet et son rôle unique dans l'instruction sont responsables, plus que toute autre chose, de la syntaxe anomale. Le point crucial est que filtrage, remplacement et affectation ne s'effectuent que sur le sujet : ces trois opérations ne sont pas représentées par le format d'expression, et cet écart constitue un obstacle de fait au développement des mécanismes de contrôle. Critère : une opération qui ne s'écrit pas dans le format général est une dette.

#### \[DONE\] Un même symbole pour deux travaux est une dette

La manifestation la plus apparente est l'emploi des mêmes symboles pour des opérations différentes selon le contexte : le signe égal dénote l'affectation dans une position et une partie du remplacement dans une autre ; les blancs dénotent tour à tour filtrage, concaténation et partie du remplacement. L'arbitrage 23 garde le point-virgule pour deux rôles parce que c'est le même objectif : le critère est l'unité de l'objectif, non l'économie de caractères.

#### \[DONE\] Quand la forme générale ne va pas au cas courant

Certaines instructions, comme celles réduites à un seul appel de fonction, ont mérité la qualification de dégénérées. Même symptôme que la verbosité d'Oz sur la lambda.

### perlisTranscriptsPresentations1978

    AUTHORS: Wexelblat (dir.), et les auteurs des langages présentés | DATE: 1978 | TITLE: History of programming languages — actes de la conférence ACM SIGPLAN History of Programming Languages, 1er au 3 juin 1978 | REVUE: Academic Press / ACM | IDENTIFIANT: ISBN 978-0-12-745040-7 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: arc H : les retours d'expérience de première main, par les auteurs des langages | SYNTHESE: nil — à dépouiller

#### \[TODO\] Dépouiller les sessions qui portent sur la SYNTAXE et sur son évolution après adoption

Deux questions du projet y trouveraient leur matière historique : ce qu'un langage peut réviser de sa syntaxe une fois adopté, et ce que ses auteurs disent avoir regretté. L'arc H a établi ce point sur d'autres sources ; celle-ci est de première main.

### griswoldHistorySNOBOLProgramming

    AUTHORS: Ralph E. Griswold | DATE: 1978 | TITLE: A history of the SNOBOL programming languages | REVUE: ACM Computing Surveys | IDENTIFIANT: 10.1145/960118.808393 | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: quatrième critère de tri ; arc G | SYNTHESE: t

#### \[DONE\] La référence indirecte est une faute avouée

Si la référence indirecte était utile en l'absence de moyens plus directs de représenter les relations structurelles, sa continuation dans SNOBOL4 était probablement une faute. La référence indirecte est le calcul d'un nom à l'exécution : c'est le même défaut que Brown et Saal nomment, et cette fois c'est le concepteur qui le qualifie de faute. Le quatrième critère de tri a donc trois sources indépendantes.

#### \[DONE\] Un choix syntaxique mineur peut coûter disproportionnément

Quelques aspects mineurs de la syntaxe ont causé des problèmes tout à fait disproportionnés par rapport à leur importance apparente, l'usage des blancs étant le plus notable. Confirme le diagnostic de 1974 quatre ans plus tard. Huitième critère implicite pour l'arc G : un choix syntaxique qui paraît sans conséquence est celui qu'il faut instruire le plus.

### kingHistoryGroovyProgramming

    AUTHORS: Paul King | DATE: 2020 | TITLE: A history of the Groovy programming language | REVUE: HOPL IV | IDENTIFIANT: 10.1145/3386326 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: R-66 glyphes définissables ; arc G | SYNTHESE: t

#### \[DONE\] Les opérateurs définissables par l'utilisateur, refusés

Le choix de proscrire les définitions d'opérateurs personnalisés est réinterrogé de temps en temps, et maintenu : si les programmeurs inventent trop de symboles illisibles, du code d'art ASCII inmaintenable peut en résulter. Chez K7PL un glyphe est une macro de bibliothèque et les macros sont ouvertes, donc un utilisateur peut définir un glyphe par construction. R-66, et trois issues : ouvrir et l'assumer, réserver le jeu de glyphes à la bibliothèque, ou distinguer le glyphe fermé de l'alias ouvert.

#### \[DONE\] La mémoire du projet

Certains aspects des discussions de conception ne sont pas préservés, notamment les directions écartées pour des raisons valables, ce qui rend difficile de transmettre plus tard pourquoi une suggestion a déjà été essayée. C'est ce que le journal de dépouillement conserve chez nous : chaque arbitrage avec sa trace, chaque rétractation avec son motif.

#### \[DONE\] Deux coûts qui ne nous atteignent pas ou nous atteignent

Les chaînes de commandes produisent de jolis DSL mais sont l'une des plus grandes causes d'ambiguïté de la grammaire, demandant des règles de précédence et des prédicats sémantiques : la forme Lisp n'a pas de précédence, ce coût est structurellement absent. En revanche, chaque point d'extension a le potentiel de compliquer le support d'outillage, et l'arbitrage 15 fait du LSP un livrable.

#### \[TODO\] Le reste de l'article

Évolution du GDK, transformations d'AST, compatibilité Java, nature statique d'un langage dynamique, tests, santé du projet. Non lu.

### hinzeUnifyingStructuredRecursion2016

    AUTHORS: Ralf Hinze, Nicolas Wu | DATE: 2016 | TITLE: Unifying structured recursion schemes — An Extended Study | REVUE: Journal of Functional Programming 26 | IDENTIFIANT: 10.1017/S0956796815000258 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: A.3.5 ; C11 tab:dimensions | SYNTHESE: t

#### \[DONE\] Le zoo, et il est fini

Côté pli : catamorphisme, paramorphisme, histomorphisme, zygomorphisme, mutumorphisme, plis à paramètres, plis accumulateurs, plis généralisés de Bird et Paterson pour les types imbriqués. Côté dépli : anamorphisme, apomorphisme, futumorphisme. Dix noms, et la liste est close par l'article. C'est le premier morceau de périmètre livré à l'arc G, et il est entier.

#### \[DONE\] Le pli adjoint unifie

Les plis adjoints sont paramétrés par une adjonction et une loi distributive qui connecte une structure de données à une structure de contrôle ; ils subsument les plis accumulateurs, les mutumorphismes et les plis généralisés. Les catamorphismes monadiques viennent de l'adjonction de Kleisli, les schémas depuis comonades de celle d'Eilenberg-Moore. Une primitive, dix instances : c'est le geste de T-68 appliqué à tab:dimensions.

#### \[TODO\] Le pli de K7PL est-il un pli adjoint ?

c2 emploie déjà les plis généralisés de Bird et Paterson, que Hinze range parmi les subsumés, donc K7PL est au moins à ce niveau. Reste à établir s'il atteint le pli adjoint, et ce qui lui manque sinon. R-61. Exige de dépouiller le corps technique.

#### \[TODO\] Les deux lois distributives du projet sont-elles une seule ?

Celle de Hinze relie un foncteur de données à un foncteur de contrôle ; celle de K7PL relie l'axe des grades à celui des effets. La forme est la même, les objets ne le sont pas. R-62.

### abelWellfoundedRecursionCopatterns2016

    AUTHORS: Andreas Abel, Brigitte Pientka | DATE: 2016 | TITLE: Well-founded recursion with copatterns and sized types | REVUE: Journal of Functional Programming 26 | IDENTIFIANT: 10.1017/S0956796816000022 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2 : A.1.3, B8 ; c3 : B9 ; c4 : B11 | SYNTHESE: t

#### \[DONE\] La productivité est une instance de la terminaison

Les objets infinis étant construits par copatrons, la réécriture standard devient fortement normalisante même pour les définitions corécursives, d'où un traitement unifié de la récursion et de la corécursion. c2 dit la même chose catégoriquement ; c'est ici la version opérationnelle, celle qu'un compilateur exécute. Candidat de fusion pour thm:terminaison_couche_3 et thm:productivite_couche_2.

#### \[DONE\] Le gardiennage syntaxique est inférieur, et K7PL l'a évité

Coq et Agda emploient une vérification syntaxique de gardiennage, dont les limites connues sont l'ordre supérieur — la productivité d'une fonction dépendant du comportement d'une autre — et la non-compositionnalité, toutes deux dues au manque d'information sur les arguments. Les types portent déjà cette information. c2 a fait ce choix et ne dit nulle part ce qu'il évite : dans Coq la coinduction est cassée, et Agda ne mêle pas inductif et coinductif de façon compositionnelle.

#### \[DONE\] Un acteur est une définition par copatrons

Un copatron définit un objet infini par ce qu'on peut en observer plutôt que par ses constructeurs. Le produit négatif indexé de K7PL, avec son introduction et sa projection, est exactement cela, et R-24 l'avait rendu indexé parce qu'un gestionnaire a autant de branches que de messages. Rattachement de l'acteur à un dispositif dont la métathéorie est faite.

#### \[DONE\] Profondeur n'est pas taille

Un flux n'a pas de taille, n'étant pas une structure d'arbre en mémoire ; il n'existe que comme processus livrant des éléments à la demande. La notion utile est la profondeur, nombre d'observations qu'on peut faire sûrement. Le budget du grade de K7PL mesure-t-il une taille ou une profondeur ? R-63.

#### \[DONE\] Deux propriétés de leur preuve qui tombent juste

La normalisation étant prouvée par candidats de réductibilité, le système admet le non-déterminisme et ne repose pas sur la couverture. P4 injecte du non-déterminisme, et le case de K7PL a été écrit sur un ensemble d'indices arbitraire : les deux décisions sont compatibles avec cette méthode de preuve.

#### \[DONE\] Le typage bidirectionnel est une forme, non un renoncement

Les règles sont formulées comme un algorithme de vérification bidirectionnelle, implantable tel quel, et l'ont été dans MiniAgda. c3 fait le même choix et le présente comme une modestie ; c'est la forme sous laquelle un système à tailles s'implante.

### caporasoPredicativeApproachClassification2001

    AUTHORS: Salvatore Caporaso, Emanuele Covino, Giovanni Pani | DATE: 2001 | TITLE: A predicative approach to the classification problem | REVUE: Journal of Functional Programming 11(1) | IDENTIFIANT: 10.1017/S0956796800003841 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1 : B6 réserve de complexité | SYNTHESE: t

#### \[DONE\] Le paysage de la complexité implicite

Situe la caractérisation sans ressource de Bellantoni-Cook et Leivant, où la seule discipline sur les variables — normales contre sûres — donne la classe, sans annotation. Avec la caractérisation par indices de la logique linéaire bornée, cela fait deux positions qui bornent l'ensemble des programmes. K7PL en occupe une troisième : le budget déclaré, qui borne chaque programme par ce qu'il annonce. La réserve de c1 cesse d'être un aveu pour devenir un choix, et son prix est nommé — caractériser exigerait de rejeter tout budget hors du langage polynomial, donc de rendre inécrivable tout programme à borne exponentielle légitime.

#### \[TODO\] Le corps technique

Hiérarchie T-alpha, opérateurs non limités, hiérarchie à croissance lente. Non dépouillé.

### pombrioHygienicResugaringCompositional

    AUTHORS: Justin Pombrio, Shriram Krishnamurthi | DATE: 2015 | TITLE: Hygienic Resugaring of Compositional Desugaring | REVUE: ICFP 2015 | IDENTIFIANT: 10.1145/2784731.2784755 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: A.2.1 portée de thm:hygiene | SYNTHESE: t

#### \[DONE\] Le problème que T-68 crée

Une fois un programme désucré il est bien plus difficile à reconnaître, et quand le désucrage est suivi d'une phase qui réécrit les termes il n'y a aucun moyen simple de voir les termes réécrits dans leur syntaxe d'origine ; cela viole l'abstraction que le sucre devrait fournir. T-68 range tout ce qui dépasse le noyau en sucre : c'est la description de notre exposition.

#### \[DONE\] La compositionnalité est ce qui achète le rapport d'erreur

Pour que le resucrage fonctionne, le désucrage doit être compositionnel, c'est-à-dire paramétrique en ses sous-termes : la fonction peut être Turing-complète, mais elle ne doit pas sonder le contenu des sous-termes. Une macro qui ne sonde pas ses sous-termes est un foncteur sur ses sous-termes, donc P1 appliqué à l'expansion. c5 exige les macros pures ; la pureté n'est pas la compositionnalité. R-51.

#### \[DONE\] Ce qu'un théorème d'hygiène doit viser

Les approches traditionnelles ont souffert de l'incapacité d'énoncer une spécification générale, la difficulté étant que le vrai but est la préservation de la α-équivalence, définie seulement pour le langage noyau. Herman et Wand préconisent que les macros spécifient la structure de liaison qu'elles introduisent — c'est le binds de c5. Le théorème 3 de l'article porte sur la α-équivalence de surface ; thm:hygiene porte sur l'AST du noyau. R-52.

### orchardQuantitativeProgramReasoning2019

    AUTHORS: Dominic Orchard, Vilem-Benjamin Liepelt, Harley Eades III | DATE: 2019 | TITLE: Quantitative program reasoning with graded modal types | REVUE: ICFP 2019 | IDENTIFIANT: 10.1145/3341714 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3 : C5 intervalles, C6 Relevant ; arc G | SYNTHESE: t

#### \[DONE\] Le quatrième mode s'appelle Relevant

Les usages linéaire, affine et relevant s'expriment respectivement par les intervalles \[1..1\], \[0..1\] et \[1..infini\]. Le mode duplicable mais non jetable — contraction sans affaiblissement — porte le nom de la logique de la pertinence. Mnémonique et usuel, dans l'ordre de préférence de l'arbitrage 23. QA-12.

#### \[DONE\] Les quatre modalités sont une construction et quatre instances

Granule les présente comme des intervalles sur les entiers naturels étendus, et en dérive une affinité plus permissive et une pertinence plus restrictive. c3 les présente comme trois sous-ensembles distingués. Le mouvement fondateur du projet — une seconde notion est un cas particulier de la première — n'a pas été fait ici. Et la comparaison corrige une imprécision : le non-restreint autorise l'abandon autant que la duplication, ce que \[0..infini\] dit et {omega} ne dit pas.

#### \[DONE\] La même doctrine glyphe et alias

Les notations unicode ont leurs contreparties ASCII, et la documentation contient une table complète d'équivalences. C'est l'annexe des glyphes de K7PL, trait pour trait, dans le langage le plus proche.

#### \[DONE\] Sa notation nous est fermée

Les deux emplois structurels de Granule sont les crochets pour la modalité graduée, en type comme en promotion, et les accolades pour le groupe de quantification. Ce sont les délimiteurs de couche 3 et de couche 1 de K7PL. Le langage le plus proche a une notation largement intransportable, et c'est le prix chiffré de la doctrine des délimiteurs. La forme Lisp le rachète : un constructeur de type est une tête, et une tête ne coûte rien à l'alphabet.

### levyCallbypushvalueSubsumingParadigm1999

    AUTHORS: Paul Blain Levy | DATE: 1999 | TITLE: Call-by-push-value: a subsuming paradigm | REVUE: TLCA 1999 | IDENTIFIANT: 10.1007/3-540-48959-2_17 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c1, annexe G.2 : la grammaire du noyau | SYNTHESE: t

#### \[DONE\] La grammaire du noyau

Types de valeur et types de calcul séparés, reliés par deux modalités : U qui fait d'un calcul une valeur, F qui fait d'une valeur un calcul. Termes : variable, abstraction, application, thunk, force, return, liaison séquentielle. Ce sont les sept premières entrées de la liste des primitives de K7PL.

#### \[DONE\] La séparation valeur/calcul est ce qui rend l'ordre d'évaluation lisible

En appel par poussée de valeur les arguments sont déjà des valeurs, de sorte que l'ordre d'évaluation est fixé par la grammaire des termes et non par un choix de contextes. C'est ce qui rend la grammaire des contextes d'évaluation de K7PL si courte.

#### \[TODO\] La traduction des deux régimes d'appel

Non dépouillée pour elle-même.

### Thesisqmwphd

    AUTHORS: Paul Blain Levy | DATE: 2001 | TITLE: Call-By-Push-Value | REVUE: thèse, Queen Mary | IDENTIFIANT: aucun | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: annexe G : arbitrage dCBPV- / dCBPV+ | SYNTHESE: t

#### \[TODO\] dCBPV- ou dCBPV+

L'arbitrage reste ouvert et il est signalé comme répercussion pour le chapitre 1.

#### \[DONE\] Les valeurs complexes sont éliminables, et le cas dépendant y fait exception

Le chapitre quatre de la thèse démontre que les valeurs complexes sont éliminables du calcul simplement typé, ce qui autorise à ne définir la sémantique opérationnelle que sur les calculs qui en sont dépourvus. La généralisation dépendante ne les élimine pas de la même façon : on les exclut des calculs sur lesquels la sémantique opérationnelle est définie, mais on les laisse figurer DANS LEURS TYPES. La distinction est nette et K7PL doit la faire au même endroit.

#### \[DONE\] La machine de la thèse est celle de l'annexe G, et cela conforte l'arbitrage rendu

La sémantique à petits pas y est donnée par une machine dont la configuration est un couple d'un calcul et d'une pile compatible, la pile portant elle-même un type. C'est la forme retenue à l'annexe G après l'arbitrage sur le nombre d'objets, et elle est ici celle de la source fondatrice.

### torczonEffectsCoeffectsCallbypushvalue2024

    AUTHORS: Cassia Torczon et al. | DATE: 2024 | TITLE: Effects and Coeffects in Call-by-Push-Value | REVUE: OOPSLA 2024 | IDENTIFIANT: 10.1145/3689750 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: annexe G : le jeu de règles, le style de la machine | SYNTHESE: t

#### \[DONE\] Le patron du jugement à trois composantes

Contexte gradué, type, effet : la forme du jugement germinal de K7PL. Et le traitement séparé des deux axes, que la loi distributive relie.

#### \[DONE\] Le style de machine, et pourquoi K7PL ne le suit pas

Torczon recommande une machine à grands pas et à environnements, une règle de machine par règle de typage, pour éviter d'avoir à démontrer un lemme de substitution. K7PL a déjà démontré ce lemme, et pour autre chose : les relations logiques et la traduction en ont besoin. L'argument perd sa force, et le document retient un seul objet — la relation à petits pas.

#### \[DONE\] tick est une opération, pas un constructeur

Torczon en fait un constructeur séparé mais précise ne décrire qu'un seul effet par simplicité. Rien n'oblige K7PL à le séparer : c'est une instance du schéma perform. R-37.

### brunelCoreQuantitativeCoeffect2014

    AUTHORS: Aloïs Brunel, Marco Gaboardi, Damiano Mazza, Steve Zdancewic | DATE: 2014 | TITLE: A core quantitative coeffect calculus | REVUE: ESOP 2014 | IDENTIFIANT: 10.1007/978-3-642-54833-8_19 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c2, annexe G : la modalité graduée et ses règles | SYNTHESE: t

#### \[DONE\] Box et Unbox, et rien d'autre

La déréliction et la promotion sont des règles, non des termes ; la contraction n'est pas une opération mais l'addition des contextes dans les règles binaires. La modalité graduée n'ajoute donc que deux constructeurs.

#### \[DONE\] Le patron d'une opération à effet

Chaque instance vient avec quatre choses : type source, type cible, grade, carte sémantique. C'est ce qui fait de perform un schéma spécifié et non un mécanisme presque-général.

#### \[DONE\] L'infini du semi-anneau ne sert qu'aux points fixes

Brunel ne postule l'élément infini que pour les points fixes. K7PL interdisant la récursion générale, l'économie est possible. R-27.

### vollmerMixedLinearGraded2024

    AUTHORS: Michael Vollmer et al. | DATE: 2024 | TITLE: A mixed linear and graded logic: proofs, terms, and models | REVUE: 2024 | IDENTIFIANT: 10.4230/LIPIcs.CSL.2025.32 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c2 : la décomposition de l'exponentielle | SYNTHESE: t

#### \[DONE\] L'exponentielle graduée se décompose

La modalité graduée se lit comme la composition d'une modalité de gradation et d'une modalité linéaire. Avec Benton, cela établit que l'exponentielle non restreinte de K7PL n'est pas une structure primitive mais le résultat d'une composition. R-23, et premier précédent d'admission par dérivation du critère de c3.

#### \[DONE\] Les deux règles structurelles gardées

Un seul jeu de règles logiques linéaires, plus des règles structurelles gardées par le mode. C'est ce qui allège T-69 : trois couches ne demandent pas trois jeux de règles.

### PCPR18AdjointLogic

    AUTHORS: Klaas Pruiksma, William Chargin, Frank Pfenning, Jason Reed | DATE: 2018 | TITLE: Adjoint Logic | REVUE: rapport, Carnegie Mellon University | IDENTIFIANT: aucun | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c5 : C15 fuite de contraction ; R-35 | SYNTHESE: t

#### \[DONE\] La sédimentation de K7PL est un préordre de modes

Couche 3 admet affaiblissement et contraction, couche 2 l'affaiblissement seul, couche 1 aucun des deux ; la monotonie exigée par la logique adjointe est satisfaite. Ce que c1 appelle une lecture s'écrit en six symboles et devient une condition vérifiable.

#### \[DONE\] Un seul jeu de règles logiques

Les règles définissant les connecteurs additifs et multiplicatifs sont simplement les règles linéaires pour tous les modes, puisque les règles structurelles sont séparées. Résultat le plus utile pour T-69.

#### \[DONE\] La déclaration d'indépendance, et le contre-exemple

Une preuve d'une proposition de mode k ne peut dépendre que d'hypothèses de mode supérieur ou égal. Sans elle, l'article donne une fausse preuve qui dérive la contraction pour les propositions linéaires : la contraction de la couche cartésienne fuit vers la couche linéaire, et la sûreté spatiale tombe. c5 justifie sa règle d'imbrication sans jamais montrer ce qui casse.

#### \[DONE\] K7PL est une instance graduée, non une instance

La logique adjointe remplace les deux zones par une présupposition sur les modes ; K7PL les remplace par des grades. Deux généralisations du même problème. L'élimination des coupures n'est donc pas acquise gratuitement mais sous réserve de l'articulation entre modes et algèbres de grades, que ni ADJ ni Grass ne couvrent seuls.

#### \[DONE\] Le mode strict

La logique adjointe admet la contraction sans affaiblissement, régime d'une obligation. C'est le mode que Granule nomme relevant, et le porteur de K7PL l'exprime comme sous-ensemble distingué. QA-12.

### hanukaevUnificationGradedSubstructural2026

    AUTHORS: Hanukaev et al. | DATE: 2026 | TITLE: A unification of graded and substructural logics | REVUE: 2026 | IDENTIFIANT: 10.48550/ARXIV.2605.17112 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c2 : l'espace des modes | SEGMENT: SEG-hanukaevUnificationGradedSubstructural2026 | DOSSIER: corpus/lot-J-confidentialite.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] La zone unique de K7PL a une place dans cet espace

Le mode unique de K7PL se situe dans l'espace que ce cadre décrit, et la phrase qui le situe est une répercussion pour le chapitre 1.

#### \[TODO\] Le corps technique

Non dépouillé.

#### \[DONE\] Grass : le mode est un TRIPLET, et cela reregle deux questions de K7PL

Un mode y est (R, Cont(m), Weak(m)) : une algebre de grades, un IDEAL de grades mutuellement contractables, et un booleen d'affaiblissement. La logique adjointe n'avait que deux booleens ; l'ideal donne un controle plus fin, et la condition d'ideal n'est pas posee, elle se deduit de ce qu'on exige de la contraction. Les quatre modes U = (T, T, vrai), R = (T, T, faux), A = ({0,1}, {0}, vrai) et L = (N, {0}, faux) redonnent respectivement l'intuitionniste, le pertinent, l'affine et le lineaire. Ce sont exactement les valeurs que K7PL donne a la composante d'usage de son grade. Grass admet en outre des grades venus d'ALGEBRES DIFFERENTES sur des variables differentes. Le grade a quatre composantes de K7PL est un cas particulier de cela : la meme algebre produit affectee a toute variable. C'est plus simple et c'est defendable, mais le document ne dit pas que c'est un choix. Substitution et preservation du typage par les conversions beta et eta y sont demontrees ; la semantique categorique subsume LNL, la logique adjointe et mGL.

#### \[DONE\] Le sous-typage modal est un MORPHISME DE MODES, et la condition est explicite

Un morphisme phi : m -\> n exige deux choses : que tout grade contractable de m s'envoie sur un contractable de n, et que Weak(m) implique Weak(n). Il donne alors une TRADUCTION : tout jugement derivable sous m se retraduit sous n. C'est la reponse a la question de savoir si la chaine lineaire, affine, non restreint se derive ou s'axiomatise. Elle se derive, mais d'une obligation que K7PL n'a jamais acquittee : il faut EXHIBER les morphismes d'algebres de grades entre ses trois usages. Le document pose la chaine ; la source dit ce qu'il faut montrer pour l'avoir. Et la source ajoute ce que l'arc A cherchait : la traduction n'est pas l'identite sur les types et les termes, parce que certains portent des annotations de grade qu'il faut TRANSPORTER le long de phi. Le transport gradue de l'arc A est donc deja nomme ici, et sa correction s'y demontre par recurrence.

#### \[DONE\] L'affaiblissement et le sous-typage sont deux regles qui se COMPOSENT

La question etait de savoir s'ils sont la meme regle. Ils ne le sont pas, et la source dit precisement leur rapport : la subsomption pose que les grades ne sont que des BORNES SUPERIEURES de l'usage reel ; l'affaiblissement introduit une variable inutilisee au grade nul. Leur composition rend l'effet que K7PL attribue a une seule regle : une variable inutilisee peut etre introduite a n'importe quel grade q superieur ou egal a zero, en affaiblissant puis en subsumant. Deux regles, un effet. La source releve aussi que zero n'a pas a etre le plus petit element : l'affaiblissement est gouverne par le predicat et par le choix du preordre, non par la seule place de zero.

#### \[DONE\] L'independance rend la multiplication scalaire BIEN DEFINIE, et c'est une troisieme forme de reponse

Grass impose que dans tout jugement derivable, chaque mode du contexte soit superieur ou egal au mode de conclusion. C'est la declaration d'independance de Pruiksma et Pfenning, et LNL la portait deja. La ou K7PL hesite entre une premisse et une condition de bord pour la partialite de la multiplication de contextes, Grass n'a ni l'une ni l'autre : la bonne definition des multiplications scalaires est une CONSEQUENCE de l'independance, donc une presupposition structurelle du jugement. C'est la forme de reponse que le document n'avait pas envisagee, et c'est la moins couteuse des trois.

### liepeltSameCoeffectDifferent2026

    AUTHORS: Vilem-Benjamin Liepelt et al. | DATE: 2026 | TITLE: Same coeffect, different base: connecting two dominant approaches to graded types | REVUE: 2026 | IDENTIFIANT: 10.1145/3828697 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2 : les deux présentations de la gradation | SYNTHESE: t

#### \[TODO\] Quelle base K7PL emploie

À établir.

### fujiiFormalTheoryGraded2016

    AUTHORS: Soichiro Fujii, Shin-ya Katsumata, Paul-André Melliès | DATE: 2016 | TITLE: Towards a formal theory of graded monads | REVUE: FoSSaCS 2016 | IDENTIFIANT: 10.1007/978-3-662-49630-5_30 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2 : la monade graduée | SYNTHESE: t

#### \[DONE\] La monade graduée comme structure d'effet

Indexation par un monoïde, et lois correspondantes. C'est ce que ℰ porte chez K7PL.

#### \[TODO\] La théorie formelle elle-même

Non dépouillée.

### plotkinHandlersAlgebraicEffects2009a

    AUTHORS: Gordon Plotkin, Matija Pretnar | DATE: 2009 | TITLE: Handlers of algebraic effects | REVUE: ESOP 2009 | IDENTIFIANT: 10.1007/978-3-642-00590-9_7 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c3, annexe G : perform et handle | SYNTHESE: t

#### \[DONE\] perform est un constructeur, handle un déconstructeur

Une opération est un schéma de construction ; un gestionnaire applique l'unique homomorphisme garanti par l'universalité, du modèle libre vers un modèle défini par le programmeur. C'est la dix-huitième primitive et le schéma qui l'accompagne.

#### \[DONE\] La réserve des deux langages

Les auteurs notent qu'un besoin naturel de deux langages apparaît, un gestionnaire étant un modèle et non un terme ordinaire. La question de savoir si la couche 2 est ce second langage reste ouverte.

### lindleyScopedEffectsParameterized2024

    AUTHORS: Sam Lindley et al. | DATE: 2024 | TITLE: Scoped effects as parameterized algebraic theories | REVUE: 2024 | IDENTIFIANT: 10.1007/978-3-031-57262-3_1 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c3, annexe G.3.2 : les opérations à portée | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Il n'y a pas d'obstacle de principe

Les effets à portée entrent dans un cadre algébrique paramétré. R-9 : la portée délimitée n'est pas un opérateur mais une ressource, ouverte et fermée.

#### \[DONE\] L'effet d'une opération à portée est une fonction de celui de son argument

C'est ce qui distingue la règle des opérations à portée de celle des opérations ordinaires, et ce qui exige un monoïde de transformateurs.

#### \[DONE\] La sédimentation ne suffit PAS, et la source dit ce qu'il faut de plus

Ordonner les couches ne réifie rien. Ce que le cadre demande est que la PORTÉE ELLE-MÊME devienne un objet du calcul — une ressource, munie de deux opérations, ouvrir et fermer — sur laquelle des opérations à liaison de variable peuvent porter. La sédimentation dit où une portée vit ; elle ne la rend pas manipulable. C'est une construction à ajouter, non un ordre à invoquer.

#### \[DONE\] Et cela recoupe un résultat de l'arc F

Le calcul de destinations exige un ÂGE qui compte les portées imbriquées entre l'origine d'une destination et son emploi. Ici, la portée devient une ressource à ouvrir et fermer. Deux arcs, deux besoins, une même exigence : la portée doit être un objet et non un contexte implicite.

### forsterExpressivePowerUserdefined2017

    AUTHORS: Yannick Forster, Ohad Kammar, Sam Lindley, Matija Pretnar | DATE: 2016 | TITLE: On the expressive power of user-defined effects | REVUE: ICFP 2016 | IDENTIFIANT: 10.1145/3110257 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: Q50 : les frontières d'expressivité | SYNTHESE: t

#### \[DONE\] Une frontière d'expressivité dépend du système de types où on la mesure

Les auteurs notent que leur argument échoue avec des changements simples du système de types, tels que le polymorphisme et les types inductifs. K7PL a des types inductifs et des conteneurs indexés : la frontière pourrait ne pas tenir chez lui. R-36, à vérifier avant de revendiquer les frontières de couche de la question 50.

### choudhuryRecoveringPurityComonads2020

    AUTHORS: Vikraman Choudhury, Neel Krishnaswami | DATE: 2020 | TITLE: Recovering purity with comonads and capabilities | REVUE: ICFP 2020 | IDENTIFIANT: 10.1145/3408993 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c2, c5 : la traduction entre couches | SYNTHESE: t

#### \[DONE\] La traduction du fragment pur

Fournit le patron de la traduction que c1 appelle F de la couche 2 vers la couche 3. R-33.

### heijltjesFunctionalMachineCalculus2023

    AUTHORS: Willem Heijltjes | DATE: 2023 | TITLE: The functional machine calculus | REVUE: 2023 | IDENTIFIANT: http://entics.episciences.org/10513 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: famille 3 : l'encodage des effets | SEGMENT: SEG-barrettFunctionalMachineCalculus2022 | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[TODO\] L'encodage des effets

Relevé comme alternative, non instruit.

### kavvosRecurrenceExtractionFunctional

    AUTHORS: G. A. Kavvos et al. | DATE: 2020 | TITLE: Recurrence extraction for functional programs through call-by-push-value | REVUE: POPL 2020 | IDENTIFIANT: 10.1145/3371083 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1 : le coût comme effet | SYNTHESE: t

#### \[DONE\] Le coût se traite en appel par poussée de valeur

Le cadre est celui de K7PL, et l'extraction de récurrence est ce que le budget approche par un autre bord.

#### \[TODO\] La méthode d'extraction

Non dépouillée.

#### \[DONE\] Le coût reçoit une sémantique dénotationnelle, en DEUX temps

D'abord une extraction syntaxique, d'un programme vers une récurrence, avec un THÉORÈME DE BORNE : tout programme source est borné par la récurrence qu'on en extrait. Ensuite une sémantique dénotationnelle du langage des récurrences, qui abstrait les types de données inductifs vers une notion de TAILLE. Et le choix de l'interprétation EST le choix de la mesure : interpréter le constructeur de nœud par le maximum donne la hauteur d'un arbre, par l'addition donne son nombre de nœuds. Le tout passe par le calcul par poussée de valeur, cadre du document.

#### \[DONE\] Une QUATRIÈME source pour le théorème manquant, et la plus ancienne

Le théorème de borne est de la même famille que les trois autres recensées aux arcs B et C : relier une grandeur statique à une grandeur opérationnelle. Sa particularité est de FACTORISER en deux — extraire, puis interpréter — ce que les autres font d'un coup. Pour K7PL, dont le grade porte quatre composantes qu'on voudrait mesurer différemment, la factorisation est précisément ce qui permettrait d'avoir une extraction et quatre interprétations.

### munch-maccagnoniResourcePolymorphism2018

    AUTHORS: Guillaume Munch-Maccagnoni | DATE: 2018 | TITLE: Resource polymorphism | REVUE: 2018 | IDENTIFIANT: arXiv:1803.02796 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c3 : le destructeur | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Destructeur et finaliseur ne sont pas la même chose

Le premier est déterministe et lié au type, le second non. C'est le premier seul qui réalise P3, le second rendant la libération dépendante d'un ramasse-miettes que la couche 1 n'a pas.

#### \[DONE\] K7PL n'en est pas une INSTANCE, et la raison est que la proposition suppose ce qu'il refuse

Le cadre suppose un ramasse-miettes comme mode d'allocation par défaut, les valeurs ramassées pouvant s'employer sans restriction en contexte possédant comme en contexte empruntant. C'est le contraire du postulat d'autonomie physique. La notion qui transporte est en revanche la bonne, et c'est le POLYMORPHISME DE RESSOURCE lui-même : une bibliothèque écrite une fois et employable sous plusieurs disciplines. Chez K7PL, c'est le polymorphisme sur le GRADE, et il est plus fort — la discipline y est un paramètre du type et non un mode d'allocation.

#### \[DONE\] Ce que la proposition rapporte quand même

Elle nomme la visée qui est aussi celle du document — automatique ET PRÉDICTIBLE — et elle recense les langages où les questions de type ont déjà été instruites pour cette combinaison. C'est un point d'entrée bibliographique, non un résultat à citer.

### wadlerPropositionsSessions2012

    AUTHORS: Philip Wadler | DATE: 2012 | TITLE: Propositions as sessions | REVUE: ICFP 2012 | IDENTIFIANT: 10.1145/2364527.2364568 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c3 : l'encodage des protocoles | SEGMENT: SEG-wadlerPropositionsSessions2012 | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Les protocoles se dérivent de l'implication linéaire

Les cinq formes de protocole ne sont pas des constructeurs primitifs : elles se dérivent, et la dualité tombe du retournement des arguments. R-18, et c'est ce qui permet à c3 de dire que l'implication suffit.

#### \[DONE\] Les sessions ne contribuent aucune règle

Un protocole étant une syntaxe de surface sur l'implication linéaire, ses règles sont celles de cette implication.

### VAN-DEN-HEUVEL

    AUTHORS: Bas van den Heuvel, Jorge A. Pérez | DATE: 2024 | TITLE: Comparing session type systems derived from linear logic | REVUE: 2024 | IDENTIFIANT: 10.1016/j.jlamp.2024.101004 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3 : le choix du système de sessions | SYNTHESE: t

#### \[TODO\] Quel système K7PL emploie

À établir.

### cervesatoLogicalMeetingPoint2004

    AUTHORS: Iliano Cervesato, Andre Scedrov | DATE: 2004 | TITLE: The logical meeting point of multiset rewriting and process algebra | REVUE: 2004 | IDENTIFIANT: DOI à chercher | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : les motifs de jonction | SEGMENT: SEG-report | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | FUSION: 3 entrées réunies le 1er septembre | SYNTHESE: t

#### \[TODO\] Le point de rencontre logique

Non dépouillé.

#### \[DONE\] La boîte aux lettres de l'acteur reçoit sa sémantique logique

Le chapitre 4 pose que la boîte aux lettres est un multi-ensemble de ressources linéaires. La source donne à la réécriture de multi-ensembles sa sémantique par les règles gauches de la logique linéaire, ce qui est exactement le fondement que cette phrase suppose sans le nommer. Et l'abandon de la distinction entre éléments et règles est le même trait que la RÉFLEXION de la machine chimique : messages et motifs de jonction y sont de même nature.

#### \[DONE\] L'EXCEPTION est identifiée, et elle vise la réplication

L'équivalence qui ne passe pas est la loi de réplication, l'équivalence entre l'exponentielle et sa décomposition en une copie et l'exponentielle. L'auteur l'écrit sans détour : cette équivalence, lue comme dérivabilité mutuelle, N'EST PAS DÉRIVABLE en logique linéaire, seul le sens inverse l'étant. Conséquence qu'il tire : l'encodage, ou peut-être la logique linéaire elle-même, ne capture pas fidèlement l'exécution du pi-calcul telle qu'elle est traditionnellement définie. Il note que le même problème est signalé par trois autres travaux.

#### \[DONE\] Et la correction est GRATUITE, ce qui en fait un cadeau plutôt qu'un défaut

L'auteur observe que la lecture de droite à gauche de cette équivalence est D'IMPLANTATION DIFFICILE, ce qui suggère un modèle d'exécution où l'on ne garde QUE LA MOITIÉ de la loi, sous la forme d'un dépliage à sens unique — le service répliqué se déplie en lui-même parallèlement à une copie, jamais l'inverse. Cette moitié correspond exactement à la règle gauche de l'exponentielle, et l'auteur écrit qu'elle TRANSFORME LA PROPRIÉTÉ EN CORRESPONDANCE EXACTE. Pour K7PL, la conséquence est directe et peu coûteuse : le service répliqué du métalangage doit se déplier à sens unique, non par une équivalence. Ce qu'on abandonne est difficile à implanter de toute façon ; ce qu'on gagne est l'exactitude dont l'énoncé de fidélité du chapitre 6 a besoin.

#### \[DONE\] Un point à vérifier que cela ouvre

Le document lit la capacité de lecture comme un service répliqué, donc l'exponentielle comme le grade non restreint. Si la loi de réplication ne vaut qu'à sens unique dans le calcul, il faut vérifier ce qu'il en est dans la théorie équationnelle du GRADE, où l'usage non restreint est traité comme une valeur du semi-anneau et non comme une exponentielle.

### maAlgebraicPatternMatching2008

    AUTHORS: Qin Ma, Luc Maranget | DATE: 2008 | TITLE: Algebraic pattern matching in join calculus | REVUE: 2008 | IDENTIFIANT: 10.2168/LMCS-4(1:7)2008 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : la compilation des motifs de jonction | SEGMENT: SEG-maAlgebraicPatternMatching2008 | DOSSIER: corpus/join-calculus-pi-calcul.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Le schéma de compilation

Un motif de jonction se résout par masquage binaire, donc par un automate fini compilé. R-19.

#### \[DONE\] Le NON-DÉTERMINISME est une propriété de la définition de jonction, et la source l'énonce

Les règles de réaction d'une même définition de jonction définissent des comportements EN CONCURRENCE, avec un choix NON DÉTERMINISTE du processus gardé à déclencher lorsque plusieurs motifs sont satisfaits. C'est exactement la tension que l'arc porte, énoncée par la source primaire sur les motifs de jonction. Le chapitre 1 énumère des sources de non-déterminisme et n'y met pas celle-ci.

#### \[DONE\] DEUX politiques de sélection existent, et la source les a employées toutes les deux

La première est la POLITIQUE DU PREMIER MOTIF, celle du filtrage à la ML, qui est déterministe. Les auteurs la nomment comme l'écart à combler : il y a un fossé entre le filtrage de jonction, non déterministe, et le filtrage à la ML, déterministe. La seconde est leur solution, et c'est la meilleure pour K7PL : PARTITIONNER LES VALEURS FILTRÉES EN ENSEMBLES DISJOINTS. Dans leur exemple de pile, ce sont le singleton de la liste vide et l'ensemble des listes non vides. Une politique du premier motif rendrait l'ORDRE D'ÉCRITURE des clauses sémantiquement significatif, ce qui, pour une réaction concurrente, revient à faire décider par la mise en page quel couple de messages est consommé. La partition ne le fait pas.

#### \[DONE\] Et K7PL a déjà de quoi payer la seconde

Le document vérifie STATIQUEMENT l'exhaustivité de ses motifs de jonction — toute combinaison de messages doit être couverte. Exiger en plus la DISJONCTION donne une partition, donc le déterminisme, sans politique de sélection ni ordre significatif. L'exemple du document est d'ailleurs déjà une partition, ses deux clauses portant sur des canaux distincts. Ce qui manque n'est pas le mécanisme mais la règle qui l'exige.

#### \[DONE\] Un renversement de la question sur le découplage

La question de l'arc suppose qu'un filtrage découplé de la substitution éviterait les encodages de la source. Les auteurs disent l'inverse de ce que cette supposition attend : leur extension est LISSE précisément parce que le filtrage de jonction et le filtrage de valeurs reposent tous deux sur la substitution classique, la semi-unification. Découpler ne dispenserait donc pas de l'encodage : cela retirerait la raison pour laquelle l'extension était lisse. L'encodage qu'ils construisent sert à l'EFFICACITÉ de la mise en œuvre, non à la définition.

### borgstromSortedSemanticFramework2016

    AUTHORS: Johannes Borgström et al. | DATE: 2016 | TITLE: A sorted semantic framework for applied process calculi | REVUE: 2016 | IDENTIFIANT: 10.2168/LMCS-12(1:8)2016 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: annexe G.5 : le système de sortes du métalangage | SEGMENT: SEG-borgstromSortedSemanticFramework2016 | DOSSIER: corpus/join-calculus-pi-calcul.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Nécessité nominale, sortes, filtrage généralisé

Le cadre découple le filtrage de motifs de la substitution, ce qui est ce dont le métalangage a besoin. R-19b.

#### \[DONE\] Le confinement des canaux distingués

Le système de sortes rend énonçable la clôture du bon sortage par substitution, et le confinement des canaux.

#### \[DONE\] Le cadre EST celui des psi-calculi, et il porte ce que les deux questions demandent

Les auteurs étendent leur travail antérieur sur les psi-calculi par des MOTIFS abstraits et un filtrage, et ajoutent des SORTES au langage des termes de données, en donnant des CRITÈRES SUFFISANTS pour que la préservation du sujet ait lieu. Les deux questions de l'arc trouvent donc leur source dans la même pièce : le cadre d'instanciation, et les critères que les sortes doivent satisfaire.

#### \[DONE\] La forme de l'instanciation, et ce qu'elle garantit

Le cadre représente directement plusieurs calculs de processus existants, et les systèmes de transitions obtenus sont ISOMORPHES aux originaux à bisimulation forte près. C'est une garantie plus forte qu'un encodage : rien n'est perdu ni ajouté par le passage au cadre. Pour K7PL, la question devient donc vérifiable : exhiber l'instance, et le reste suit.

#### \[DONE\] Une LIMITE de la mécanisation, et elle vise l'arc K

Les propriétés standard de congruence et de structure de la bisimulation sont démontrées, et la preuve est vérifiée par machine en Isabelle nominal DANS LE CAS D'UNE SORTE DE NOMS UNIQUE. Le métalangage de K7PL a plusieurs sortes. La partie mécanisée du résultat ne couvre donc pas son cas, et c'est à consigner au dossier de la mécanisation plutôt qu'à découvrir en la conduisant.

#### \[DONE\] Les critères sont ÉNUMÉRABLES, et les voici

La définition des paramètres de tri demande une FONCTION DE SORTE équivariante, définie sur les noms, les termes et les motifs, et QUATRE PRÉDICATS DE COMPATIBILITÉ, un par rôle : peut servir à ÉMETTRE, peut servir à RECEVOIR, peut être SUBSTITUÉ PAR, peut être LIÉ PAR RESTRICTION DE NOM. Sur les noms, la sorte est exigée unique — un nom est d'une sorte si et seulement s'il appartient à l'ensemble de noms de cette sorte, ce que les auteurs rapprochent des lambda-calculs à la Church, où tout terme bien formé a un type unique. S'y ajoute un PRÉORDRE DE SOUS-SORTE, dont l'exemple des auteurs montre l'emploi : le cas intéressant est celui où une substitution CHANGE la sorte d'un terme, et il est admis parce que la sorte d'arrivée précède celle de départ dans ce préordre.

#### \[DONE\] Mais il n'y a rien à vérifier, et c'est le vrai renseignement

L'annexe G écrit que le système de sortes du métalangage est l'objet qu'une tâche DOIT CONSTRUIRE, et que tant qu'il n'est pas posé, la relation logique est définie sur deux strates seulement. Les sortes de K7PL n'existent donc pas encore. Les critères ne sont pas une vérification à conduire mais une SPÉCIFICATION à laquelle construire, et elle est complète : une fonction, quatre prédicats, un préordre.

#### \[DONE\] Ce que cette construction débloque, et ce n'est pas mince

La même page de l'annexe porte l'énoncé honnête que le document se donne : la non-interférence graduée est démontrée POUR LE FRAGMENT SANS COMMUNICATION. Le motif est nommé — un canal créé par un calcul d'un niveau supérieur ne doit pas être observable en deçà, et rien dans la relation telle qu'elle est écrite ne l'assure. Le système de sortes est donc un objet PORTANT : le construire étend un théorème du document au-delà du fragment où il est aujourd'hui borné.

### curienIntroductionLinearLogic2005

    AUTHORS: Pierre-Louis Curien | DATE: 2005 | TITLE: Introduction to linear logic and ludics, part II | REVUE: 2005 | IDENTIFIANT: arXiv:cs/0501039 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c2, annexe G : les règles des connecteurs | SEGMENT: SEG-curienIntroductionLinearLogic2005 | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Les règles des connecteurs, à la source

Fournit la présentation dont l'annexe G tire ses patrons d'introduction et d'élimination. R-3.

### diaz-caroAlgebraicExtensionIntuitionistic2025a

    AUTHORS: Alejandro Díaz-Caro et al. | DATE: 2025 | TITLE: An algebraic extension of intuitionistic linear logic | REVUE: 2025 | IDENTIFIANT: 10.1093/logcom/exaf053 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2 : variante | SYNTHESE: t

#### \[TODO\] L'extension algébrique

Non dépouillée.

### ehrhardEffectsCallbypushvalueLinear

    AUTHORS: Thomas Ehrhard | DATE | TITLE: Effects in call-by-push-value, from a linear logic point of view | REVUE | IDENTIFIANT: DOI à chercher | REF.BIB: nil | RDF: t | PDF: t | LU: t | A-CITER-SUR: c2 : Kleisli ou Eilenberg-Moore | SYNTHESE: t

#### \[DONE\] La fausse alerte, et sa leçon

J'avais lu chez Ehrhard que la catégorie d'Eilenberg-Moore est cartésienne, comparé à mon souvenir de c2, et signalé un écart sans relire le chapitre. c2 dit explicitement retenir la factorisation de Kleisli, anticipe la difficulté du tenseur sur les coalgèbres libres, et donne le produit comme tenseur restreint. Répercussion 6 retirée. Règle élargie : avant d'ouvrir une source, lire le chapitre que la question touche.

### vakarFrameworkDependentTypes2015

    AUTHORS: Matthijs Vákář | DATE: 2015 | TITLE: A framework for dependent types and effects | REVUE: 2015 | IDENTIFIANT: arXiv à chercher | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3 : les types dépendants sur CBPV | SEGMENT: SEG-vakarFrameworkDependentTypes2016 | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] L'existentielle appartient au noyau

c3 pose un langage noyau muni de pack et unpack ; Vákář en donne le cadre. Les deux termes sont des termes de connecteur, non des primitives distinctes. R-20.

#### \[DONE\] La ligne de partage est nommée, et K7PL se situe du côté le moins cher

Deux systèmes, et la différence tient à un principe. Le premier, sans extension de Kleisli pour les fonctions dépendantes, NE SUFFIT PAS à encoder l'appel par valeur dépendant, ni les règles d'élimination FORTES, c'est-à-dire dépendantes, des connecteurs positifs en appel par nom. Le second ajoute ce principe et obtient les deux traductions. Le critère est donc précis : il faut le second dès qu'un motif d'élimination dépend du sujet examiné. Or la règle de filtrage de l'annexe G porte le MÊME type de conclusion dans toutes ses branches, et ce type ne mentionne pas l'indice de la branche. K7PL n'a donc que l'élimination faible, et le premier système lui suffit. C'est un arbitrage rendu, et il est favorable : la forme simple tient, et l'on sait exactement où est la frontière.

#### \[DONE\] Et le prix du second, si K7PL le franchit un jour

La source l'énonce sans détour : selon les effets considérés, on peut PERDRE L'UNICITÉ DU TYPAGE, le type d'un calcul devenant plus spécifié à mesure que certains effets s'exécutent. Cela se formalise par une notion de sous-typage, et il peut falloir ajouter des règles de COERCION pour sauver la préservation. Ce qui remplace l'unicité est nommé : un TYPAGE MINIMAL. K7PL a déjà du sous-typage, donc une part du prix est acquittée. Il n'a pas de typage minimal, et c'est ce qui manquerait le jour où il éliminerait dépendamment. Question close, obligation datée.

#### \[DONE\] Un détail de placement qui vaut d'être noté

Les connecteurs se formulent naturellement d'un côté ou de l'autre : les sommes dépendantes et l'identité opèrent sur les types cartésiens, les produits dépendants sur les types linéaires. C'est une contrainte de placement que le document n'énonce pas et à laquelle il se conforme.

### brachthauserEffectsCapabilitiesEffect2020

    AUTHORS: Jonathan Immanuel Brachthäuser et al. | DATE: 2020 | TITLE: Effects as capabilities: effect handlers and lightweight effect polymorphism | REVUE: OOPSLA 2020 | IDENTIFIANT: 10.1145/3428194 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3 : capacités et effets | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[TODO\] Capacité et effet

Relevé, non instruit.

#### \[DONE\] Le prix est LOURD, et il est écrit : toutes les fonctions deviennent de SECONDE CLASSE

Pour garantir la sûreté d'effet, les auteurs SÉPARENT LES FONCTIONS DES VALEURS et traitent toutes les fonctions comme de seconde classe. C'est une restriction majeure, et elle répond du même coup à la question de savoir si un gestionnaire peut être une valeur de première classe : dans cette conception, non.

#### \[DONE\] Mais K7PL NE PAIE PAS CE PRIX, et la raison est structurelle

La restriction que les auteurs doivent IMPOSER — séparer les fonctions des valeurs — est exactement ce que le calcul par poussée de valeur DONNE. Un calcul n'y est pas une valeur ; une suspension en est une. La seconde classe des fonctions y est la distinction valeur/calcul, non une contrainte ajoutée. Le document peut donc prendre la voie des effets comme capacités sans en payer le prix, et c'est un acquis de son cadre qu'il ne revendique pas.

#### \[DONE\] Et l'arc I et l'arc J posaient la même question

Le calcul cible est celui-là même que la compilation des gestionnaires en style à passage de capacités emploie, avec son sous-ensemble à coût nul caractérisé par le type. La question de l'abaissement des effets et celle de leur conception sont donc une seule question, et une seule équipe l'a traitée des deux côtés.

### yangFantasticMorphismsWhere2022

    AUTHORS: Zhixuan Yang, Nicolas Wu | DATE: 2022 | TITLE: Fantastic morphisms and where to find them: a guide to recursion schemes | REVUE: MPC 2022 | IDENTIFIANT: 10.1007/978-3-031-16912-0_9 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: C11 tab:dimensions ; A.3.5 | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[TODO\] Confronter à Hinze et Wu

Deux guides du même zoo ; il faut établir lequel sert le mieux la question de savoir si le pli de K7PL est adjoint.

#### \[DONE\] L'hylomorphisme est le schéma universel, et il matérialise le franchissement

Un hylomorphisme naît d'un anamorphisme suivi d'un catamorphisme : produire une structure puis la consommer. Les auteurs écrivent que tous les schémas de leur article se définissent comme des cas particuliers d'hylomorphismes, et citent un procédé mécanique pour y transformer presque toute fonction récursive de la pratique. La structure intermédiaire entre la production et la consommation est l'objet que la déforestation supprime : le franchissement de couche n'est donc pas accompagné d'un objet, il EST cet objet. Chez K7PL, l'anamorphisme produit en couche 2 sur la coalgèbre terminale et le catamorphisme consomme en couche 3 sur l'algèbre initiale ; un hylomorphisme traverse donc bien une frontière, et la déforestation la fait disparaître par construction.

#### \[DONE\] Trois cadres unifiants convergent, et ils ne disent pas la même chose

Le pli adjoint de Hinze et Wu unifie par une adjonction et une loi distributive. Les deux structures de Downen, Johnson-Freyd et Ariola unifient par deux principes d'induction dont les schémas se composent. Et Yang et Wu rapportent que tous les schémas se comprennent uniformément comme des hylomorphismes munis d'une coalgèbre récursive ou d'une algèbre corécursive, par les comonades de Capretta et al. puis les adjonctions et paires conjuguées de Hinze et al. Les trois convergent sans se confondre : le premier et le troisième donnent une FORME unique, le second donne deux PRINCIPES qui la justifient. La réponse au compte des primitives est donc une forme et deux principes, non deux formes.

#### \[DONE\] Un balayage n'est pas un catamorphisme

La table des dimensions écrit plis, balayages et réductions sur un même plan. Un balayage produit la suite de ses résultats intermédiaires, ce qu'un catamorphisme pur ne fait pas : c'est un pli accumulateur, que Hinze range parmi les schémas subsumés par le pli adjoint. La table met donc une forme générale, une de ses instances, et un synonyme sur trois colonnes de même rang.

#### \[TODO\] Le catalogue des schémas

Paramorphisme, apomorphisme, histomorphisme, futumorphisme, zygomorphisme, mutumorphisme, métamorphisme, avec leurs exemples de programmation et leurs duaux. C'est le matériau qui permettrait de dire, pour chaque entrée de la table des dimensions, de quel schéma elle est le nom. Non dépouillé.

### hermanTheoryHygienicMacros2008

    AUTHORS: David Herman, Mitchell Wand | DATE: 2008 | TITLE: A theory of hygienic macros | REVUE: ESOP 2008 | IDENTIFIANT: 10.1007/978-3-540-78739-6_4 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c5 : l'appui de binds | SYNTHESE: t

#### \[DONE\] Les macros spécifient leur structure de liaison

Pombrio le résume ainsi : le vrai but de l'hygiène est la préservation de la α-équivalence, mais celle-ci n'est définie que pour le noyau ; d'où la préconisation que les macros déclarent ce qu'elles lient. C'est le binds de c5. La clé était au fonds avec le bon motif, et il lui manquait la source qui dit que ce motif est le nôtre.

#### \[TODO\] La théorie elle-même

Non dépouillée.

### altenkirchIndexedContainers2015

    AUTHORS: Thorsten Altenkirch, Neil Ghani, Peter Hancock, Conor McBride, Peter Morris | DATE: 2015 | TITLE: Indexed containers | REVUE: Journal of Functional Programming 25 | IDENTIFIANT: 10.1017/S095679681500009X | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: T-68 : statut de Vec, de mu et de nu | SYNTHESE: t

#### \[DONE\] Le vecteur est un type dérivé, et il a une forme normale

Vec n V est une famille strictement positive indexée par sa longueur. L'article établit que toute telle famille s'interprète par un conteneur indexé, lequel se construit dans un noyau à nombre fixe de constructeurs — produit dépendant, somme dépendante, W-type — sans que ce noyau ait à être étendu. Le vecteur n'est donc pas un constructeur de type de plus : c'est une instance, et l'article en donne la forme normale.

#### \[DONE\] Mais la règle de K7PL n'est pas celle du conteneur, et l'écart est le grade

La réduction porte sur les TYPES. Les deux règles de K7PL portent autre chose : l'introduction multiplie le contexte par la longueur, et l'élimination compose n effets qui ne sont pas les mêmes, ce que l'annexe signale comme le premier site où l'indexation graduée mord. Aucune réduction de conteneur ne donne cette arithmétique. Le verdict est donc double et il faut le dire en deux temps : le TYPE Vec est dérivé ; le CONSTRUCTEUR ne l'est pas, et la primitive dont il est une instance est le pli indexé GRADUÉ, que la liste ne nomme pas.

#### \[DONE\] La coalgèbre terminale se dérive de l'algèbre initiale, sous conditions

L'article dérive les M-types indexés des W-types indexés, et ceux-ci des W-types ordinaires. Si cette chaîne vaut chez K7PL, alors nu se dérive de mu, et avec lui toute la productivité de la couche 2. Deux réserves l'empêchent d'être acquise : la dérivation suppose une théorie extensionnelle, et l'article lui-même postule l'extensionnalité de la bisimulation plutôt que de la démontrer. Et rien n'établit que la chaîne survive à la gradation. C'est une question de recherche réelle, non une hypothèse à prendre : si elle aboutit, la liste perd deux constructeurs et la couche 2 gagne un fondement ; si elle échoue, nu est primitif et il faut dire pourquoi.

#### \[TODO\] Les constructions formelles

Foncteurs indexés comme monade relative, algèbres initiales paramétrées, dérivation des W-types indexés. Non dépouillées.

### bahrModalFRPAll2022

    AUTHORS: Patrick Bahr | DATE: 2022 | TITLE: Modal FRP for all: functional reactive programming without space leaks in Haskell | REVUE: Journal of Functional Programming 32 | IDENTIFIANT: 10.1017/S0956796822000132 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: T-68 : les formes temporelles ; c1 : la zone unique | SYNTHESE: t

#### \[DONE\] Deux modalités temporelles suffisent, là où K7PL en emploie trois

Rattus a un pas différé et une modalité de stabilité, avec leurs introductions et éliminations : quatre termes. K7PL en a six, répartis sur trois modalités. La modalité de stabilité de Rattus est celle de K7PL : elle transforme un type quelconque en type transportable dans le futur, et son introduction exige que le contexte ne contienne que du stable — ce qui est exactement la forme de la règle de K7PL. La différence porte donc sur la troisième modalité, et c'est elle qu'il faut instruire.

#### \[DONE\] Le contexte à jetons, et c'est l'économie que le chapitre 1 revendique

Rattus emploie un système à la Fitch qui étend le contexte de typage avec des jetons pour éviter la lourdeur syntaxique d'un système à double contexte, et parmi ses trois simplifications figure le passage d'un seul type de jeton au lieu de deux. Le chapitre 1 de K7PL revendique la même économie pour une autre raison — une liaison non restreinte est une liaison de grade non contraint, donc la seconde zone n'est pas nécessaire. Deux projets indépendants, deux motifs différents, une même suppression du double contexte.

#### \[DONE\] La stabilité est une propriété de type, non une annotation

Un type est stable s'il ne contient ni le pas différé ni de type fonction ; la modalité de stabilité en fabrique un à partir de n'importe quel type. La condition sur les fonctions est instructive : elles peuvent porter des valeurs temporelles dans leur clôture, et sont donc exclues d'office. K7PL ne dit nulle part quels de ses types sont stables ni pourquoi.

#### \[TODO\] La métathéorie et l'incorporation en Haskell

Non dépouillées.

### bahrDiamondsAreNot2021

    AUTHORS: Patrick Bahr, Christian Uldal Graulund, Rasmus Ejlers Møgelberg | DATE: 2021 | TITLE: Diamonds are not forever: liveness in reactive programming with guarded recursion | REVUE: POPL 2021, Proc. ACM Program. Lang. 5 | IDENTIFIANT: 10.1145/3434283 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: T-68 : le diamant et les trois formes ; conflit point fixe / LTL | SYNTHESE: t

#### \[DONE\] Le diamant n'est pas primitif : il est une instance de l'opérateur until

Le type des événements qui DOIVENT arriver s'encode comme le diamant de la logique temporelle, et le diamant lui-même s'encode comme l'unité until A. Les deux termes que K7PL nomme now et wait sont alors les termes de until instanciés à l'unité : now est le now de until, et wait est le wait de until appliqué à l'unité. K7PL prend donc le dérivé pour primitif, avec trois termes, et n'a pas le primitif dont ils dérivent.

#### \[DONE\] Deux pas différés, et les confondre casse la terminaison

L'article distingue le pas de la récursion gardée, qui admet un point fixe, et le pas de la logique temporelle, qui est une sous-modalité du premier. L'inclusion du second dans le premier existe ; l'inverse n'existe pas, et c'est précisément cette absence qui empêche de prendre un point fixe pour construire un élément divergent du diamant. Identifier les deux, ce que fait une lecture naïve, détruit la garantie de terminaison que le diamant est censé porter.

#### \[DONE\] K7PL est dans la configuration du conflit, et il ne le dit pas

Le langage a un opérateur de point fixe et des modalités de logique temporelle sur ses types de session, ce qui est exactement la combinaison que l'article déclare en conflit. Il n'a qu'un seul pas différé et ne dit nulle part s'il sert la récursion gardée, la logique temporelle, ou les deux. Il échappe probablement au conflit pour une raison qu'il ne donne pas : son point fixe n'est pas celui de Nakano mais une itération sur un treillis de hauteur finie, dont la terminaison vient du treillis et non d'une garde modale. Cela demande à être vérifié et écrit, faute de quoi la garantie repose sur une coïncidence.

#### \[DONE\] Deux types d'événement, et K7PL n'en distingue qu'un

L'événement qui PEUT arriver et l'événement qui DOIT arriver sont deux types distincts — possiblement non terminant et terminant — le premier étant le point fixe gardé de la somme, le second le diamant. Il existe une inclusion du second dans le premier et pas l'inverse. Les types de session de K7PL portent le diamant sans porter cette distinction.

#### \[TODO\] Le langage Lively RaTT et sa métathéorie

Non dépouillés.

### rajaniGradedModalRelaxed2025

    AUTHORS: Vineet Rajani, Alex Coleman, Hrutvik Kanabar | DATE: 2025 | TITLE: A graded modal approach to relaxed semantic declassification | REVUE: IEEE Computer Security Foundations Symposium 38 | IDENTIFIANT: 10.1109/CSF64896.2025.00032 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: T-68 : statut de declassify ; c2 : divulgation délimitée | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] La déclassification n'est pas dérivable de la classification

Le calcul dont l'article part possède déjà une monade graduée pour classer l'information, et il faut lui AJOUTER une modalité pour déclassifier. C'est la réponse à la question que la revue de T-68 posait : declassify n'est pas une forme dérivée de la composante de confidentialité du grade, il demande sa propre modalité. K7PL le traite déjà comme primitif, avec sa règle et son théorème de divulgation délimitée, et ce traitement est le bon.

#### \[DONE\] Et deux choses restent à écrire, que l'article nomme

L'interaction entre la nouvelle modalité et la monade graduée se fait par des LOIS DISTRIBUTIVES, et la modalité ne forme une comonade que sous des conditions que l'article énonce. K7PL a déjà une loi distributive entre son axe de ressource et son axe d'effet, et la forme convient ; mais il ne dit ni que la déclassification interagit avec le grade par une loi de ce genre, ni sous quelles conditions sa modalité est une comonade. Deux items pour la passe de rédaction.

#### \[TODO\] Le modèle par relation logique

Non dépouillé.

#### \[DONE\] La déclassification demande une modalité DE PLUS, non un relâchement de celle qui existe

C'est le point de conception, et il est net. Les auteurs n'assouplissent pas la modalité de classification : ils en ajoutent une seconde, dédiée. La composante de NIVEAU du grade de K7PL est la monade graduée de la classification. Ses échappatoires nommées de déclassification devraient donc être une modalité DISTINCTE, non une exception à la première — ce qui rend l'ensemble des échappatoires énonçable comme un type plutôt que comme une liste.

#### \[DONE\] Le critère est nommé et il a deux ancêtres

Le critère de déclassification retenu s'inspire de la divulgation délimitée et de la non-interférence relâchée. Ce sont les deux notions dont le document a besoin pour sa divulgation BORNÉE, et elles sont réunies ici dans un cadre gradué avec ses relations logiques.

### dasParallelComplexityAnalysis

    AUTHORS: Das et al. | DATE: 2018 | TITLE: Parallel complexity analysis with temporal session types | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3236786 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] C'est la configuration exacte de K7PL, et elle a été traitée

Types de session binaires, correspondance de Curry-Howard avec la logique linéaire intuitionniste, trois modalités temporelles suivant, toujours et éventuellement, et un modèle de coût paramétrique : c'est point par point ce que K7PL a construit à ses chapitres 3 et 4, et ce que son annexe formalise. La correction est établie par progrès et préservation, qui sont précisément les deux propriétés que l'annexe vient de démontrer. Le document ne cite pas cette source et refait le chemin.

#### \[DONE\] Les trois modalités sont primitives ici, et cela corrige un verdict que j'avais rendu

J'avais conclu de la littérature sur la programmation réactive que le diamant est dérivé d'un opérateur until et que K7PL prenait le dérivé pour primitif. Ce verdict était mal transporté : il vaut pour le diamant de la logique temporelle en cadre de récursion gardée, non pour le diamant des types de session. Das et al. ajoutent les trois modalités conservativement comme constructeurs de types de session, sans until, et ce sont bien des primitives dans ce cadre. K7PL est dans ce cadre et non dans l'autre. Sixième faute de transport de la campagne, et toujours la même : une conclusion juste dans son cadre, appliquée hors de lui.

#### \[DONE\] Mais les deux diamants ne sont pas le même, et les auteurs le disent

Un processus qui offre le diamant promet seulement que, s'il termine, il fournira éventuellement le type promis. Cela exprime un non-déterminisme sur la date, non une propriété stricte de vivacité, et les auteurs écrivent que leur diamant est de ce fait plus faible que celui de la logique temporelle usuelle. La cause est nommée : ils n'imposent pas la terminaison et admettent la récursion non restreinte.

#### \[DONE\] Et la condition qui restaure le sens fort est celle que K7PL satisfait

Les auteurs poursuivent : restreint à un fragment purement logique, SANS RÉCURSION NON RESTREINTE, le sens usuel est PLEINEMENT RESTAURÉ. K7PL interdit la récursion générale dans ses trois couches. Son diamant est donc le diamant fort, celui de la vivacité, là où celui de la source est faible. C'est un acquis, il vient d'une restriction que le langage s'impose déjà pour une autre raison, et le document ne le dit nulle part. À écrire, et c'est le genre d'acquis qui vaut cher : une contrainte posée pour la terminaison paie une seconde fois en force de garantie temporelle.

#### \[DONE\] La règle d'élimination du diamant est incomplète chez K7PL, et la source dit de quoi

La règle des auteurs porte DEUX contraintes, et la raison en est donnée : parce que le client peut devoir attendre une durée indéfinie, la règle doit garantir que la communication sur le canal de sortie ET sur tout canal du contexte peut aussi être différée indéfiniment. D'où le résultat contraint à rester sous le diamant après un nombre fini de pas, et tout canal du contexte contraint à être sous toujours après un nombre fini de pas. La règle de K7PL porte la première contrainte et pas la seconde. Sans elle, un canal du contexte pourrait exiger une communication à date fixe pendant que le client attend indéfiniment, et la garantie temporelle tomberait. C'est une lacune de règle, elle est précise, et elle est réparable en une ligne.

#### \[TODO\] La sémantique de réécriture de multi-ensembles datée

C'est la méthode par laquelle les auteurs établissent progrès et préservation pour cette combinaison, et K7PL vient d'établir les siennes par une autre voie. La comparaison n'a pas été faite.

#### \[TODO\] Les exemples et le modèle de coût

Débit d'un flux, latence d'un pipeline, temps de réponse d'une file, envergure d'un programme parallèle. Non dépouillés, et ce sont exactement les grandeurs que le chapitre 4 de K7PL veut exprimer.

### damatoFormalisingInductiveCoinductive2024

    AUTHORS: Damato et al. | DATE: 2024 | TITLE: Formalising inductive and coinductive containers | REVUE: International Conference on Interactive Theorem Proving | IDENTIFIANT: arXiv:2409.02603 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La préservation vaut pour les deux points fixes, et la réserve que j'avais posée tombe

J'avais noté que la dérivation des M-types depuis les W-types repose sur une extensionnalité de la bisimulation que la source de 2015 postule plutôt que de démontrer. Cette réserve est levée : les auteurs formalisent les deux résultats sans supposer l'unicité des preuves d'identité, et le type de chemin de Cubical Agda rend démontrable ce qui était postulé. Les foncteurs de conteneur préservent les algèbres initiales et les coalgèbres terminales, et c'est formalisé.

#### \[DONE\] Mais la technique demande une extensionnalité que l'assistant visé n'a pas

Les auteurs sont explicites : en théorie des types intensionnelle, et donc en Agda ordinaire, on ne va pas loin avec les types coinductifs — beaucoup d'égalités y sont impossibles à démontrer, exactement comme les égalités sur les types fonction, et cela demande une forme d'extensionnalité. Cubical Agda la rend démontrable par son type de chemin. La mécanisation de K7PL vise LEAN 4, qui est intensionnel, qui a l'extensionnalité fonctionnelle par ses quotients mais qui n'a ni type de chemin ni types coinductifs natifs. Le résultat dont K7PL a besoin existe donc, et il est démontré par une technique que son assistant ne supporte pas.

#### \[DONE\] D'où une chaîne de dépendance que le plan ne portait pas

Le verdict de T-68 sur la coalgèbre terminale dépend de la question de l'arc A — la préservation transporte-t-elle à la gradation — laquelle dépend d'une question de l'arc K — la preuve se transporte-t-elle en LEAN 4. Trois arcs enchaînés pour un constructeur. L'intuition d'Anthea était juste : T-68 ne se referme pas sans les arcs.

#### \[TODO\] La transposition à un cadre gradué

Les résultats valent dans la catégorie sauvage des types, sans gradation. Rien n'établit qu'un foncteur de conteneur GRADUÉ préserve encore les deux points fixes, et c'est ce que K7PL demande. Question de recherche ouverte, et c'est la plus lourde de la revue primitive/dérivé.

### downenStructuresStructuralRecursion

    AUTHORS: Paul Downen, Philip Johnson-Freyd, Zena M. Ariola | DATE: 2015 | TITLE: Structures for structural recursion | REVUE: ICFP 2015 | IDENTIFIANT: 10.1145/2784731.2784762 (à vérifier) | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: T-68 : QA-20, QA-22 ; tab:dimensions | SYNTHESE: t

#### \[DONE\] Le zoo se compose à partir de deux structures, et cela répond à la question du compte

La question était de savoir combien de schémas de récursion sont primitifs. La réponse de cette source est deux : la récursion primitive et la récursion noethérienne, chacune avec son principe d'induction. Les schémas complexes ne sont pas des primitives mais des COMPOSITIONS de ces deux structures. Avec le pli adjoint de Hinze et Wu, qui unifie le zoo par une adjonction et une loi distributive, cela fait deux cadres unifiants convergents, et ni l'un ni l'autre ne compte les schémas nommés parmi les primitives.

#### \[DONE\] Et la dualité donne à la couche 2 sa primitive de production

Chaque structure de récursion a une forme duale, et les auteurs en font le principe de leur étude plutôt qu'une remarque. La duale de la récursion primitive est la corécursion primitive, et c'est la primitive de production que la couche 2 emploie sans la nommer. La table des dimensions, qui met plis, balayages et réductions sur un même plan, doit donc porter deux structures et leurs duales, non une liste de schémas.

#### \[TODO\] Les structures elles-mêmes, et leur composition

Le développement montre comment les structures se composent pour former les schémas complexes. C'est ce qui permettrait de dire, pour chaque entrée de la table des dimensions, de quelle composition elle est le nom. Non dépouillé.

### gaboardiCombiningEffectsCoeffects2016

    AUTHORS: Gaboardi et al. | DATE: 2016 | TITLE: Combining effects and coeffects via grading | REVUE: Proceedings of the 21st ACM SIGPLAN International Conference on Functional Programming | IDENTIFIANT: 10.1145/2951913.2951939 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La loi distributive de K7PL a un nom, et c'est celui-ci

Le document parle d'une loi distributive graduée reliant l'axe des grades et celui des effets, et cite déjà cette source au chapitre 3. C'est bien la même : la loi distributive graduée entre une comonade graduée par les coeffets et une monade graduée par les effets, introduite ici comme concept neuf. Le document emprunte donc un objet nommé et daté, et il le cite ; ce qui manque est de dire que c'est cet objet-là, et non une loi distributive générique.

#### \[DONE\] Et cela tranche une confusion que j'allais installer

J'avais rapproché cette loi de celle qui paramètre le pli adjoint de Hinze et Wu, en notant que la forme est la même. Elle ne l'est pas au sens qui compte : celle de Hinze relie un foncteur de DONNÉES à un foncteur de CONTRÔLE, celle-ci relie une comonade de RESSOURCE à une monade d'EFFET. Deux lois distributives, deux paires de foncteurs, et il faut les nommer différemment sous peine d'une confusion coûteuse. R-62 est close, et la réponse est deux.

#### \[DONE\] La lecture producteur et consommateur, qui vaut d'être reprise

Les auteurs présentent les deux axes comme les deux vues d'un programme : ce qu'il produit sur son contexte et ce qu'il en exige, le programme comme producteur et comme consommateur. C'est exactement ce que le jugement germinal porte dans ses trois composantes, et c'est une formulation plus parlante que celle du document.

#### \[TODO\] Le calcul et sa sémantique

Les instanciations que les auteurs donnent pour décrire diverses interactions entre un programme et son contexte d'évaluation. Non dépouillées, et elles diraient si la combinaison de K7PL en est une.

#### \[DONE\] La loi distributive graduée, et pourquoi une monade ordinaire ne suffit pas

Effets et coeffets sont deux aspects complémentaires du comportement d'un programme : les premiers CHANGENT le contexte d'exécution, les seconds lui font des DEMANDES. La source donne la structure qui décide de leur rencontre — une loi distributive graduée entre la comonade et la monade, dont la lecture syntaxique est une théorie équationnelle. C'est l'appareil central du chapitre 1, et le document en dépend plus que d'aucune autre pièce sur cet axe : les deux fonctions de la loi portent tout le contenu de la composition, l'une disant comment l'effet est modifié en traversant la modalité, l'autre comment la modalité l'est en traversant l'effet. Le motif de fond, à retenir : une monade ordinaire n'offre qu'une vue BINAIRE — pur ou effectueux — quand un grade demande une échelle.

### lemayCoderelictionsFreeExponential2021

    AUTHORS: Lemay | DATE: 2021 | TITLE: Coderelictions for free exponential modalities | REVUE: LIPIcs, Volume 211, CALCO 2021 | IDENTIFIANT: 10.4230/LIPIcs.CALCO.2021.19 (à vérifier) | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La codéréliction n'est pas optionnelle : elle est forcée

La question était de savoir si une comonade exponentielle graduée a des opérations canoniques au-delà de l'extraction et de la duplication. La réponse est oui, et elle est plus forte qu'attendu : toute catégorie de Lafont à biproduits finis EST une catégorie différentielle, et la codéréliction y est unique. Autrement dit, si l'exponentielle est libre et que la catégorie a des biproduits finis, la structure différentielle existe qu'on la veuille ou non.

#### \[DONE\] Et la question des catégories différentielles n'est donc pas une homonymie

Je l'avais posée comme telle : les catégories différentielles ont-elles un rapport avec la gradation, ou le mot est-il seulement voisin. Le rapport est une implication, pas une ressemblance. La question devient : la catégorie ambiante de K7PL est-elle de Lafont, et a-t-elle des biproduits finis.

#### \[DONE\] Et la polarisation de l'appel par poussée de valeur paraît l'en protéger

Un biproduit demande que le produit et la somme coïncident. Chez K7PL ils ne peuvent pas : la somme indexée est un type de VALEUR et la conjonction additive un type de CALCUL, et la grammaire les sépare par polarité. La catégorie n'aurait donc pas de biproduits finis, et la structure différentielle ne serait pas forcée. Si cela se confirme, c'est un acquis d'un genre rare : une décision prise pour l'ordre d'évaluation a une conséquence catégorique que personne n'avait cherchée. À vérifier avant de s'en réjouir, car la question porte sur la catégorie AMBIANTE et non sur la grammaire, et le lien entre les deux n'est pas immédiat.

### erikssonGradedModalType2025

    AUTHORS: Oskar Eriksson | DATE: 2025 | TITLE: Graded modal type theory, formalized | REVUE: thèse de licence, University of Gothenburg | IDENTIFIANT: aucun (thèse) | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: QB-13, QB-28 ; A.3 nouveau théorème de correction de ressource | SEGMENT: SEG-erikssonGradedModalType2025 | DOSSIER: corpus/lot-J-confidentialite.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] C'est le modèle de référence que la question demandait

La question était de savoir si les théories de type modales graduées formalisées donnent un modèle de référence pour le nôtre. Celle-ci le donne : dépendante, graduée, avec univers, avec effacement, avec machine abstraite, et mécanisée. C'est le point de comparaison le plus proche que le fonds porte pour l'appareil de grades du document.

#### \[DONE\] Et elle révèle un théorème qui manque, et il touche le troisième postulat

La correction de ressource y est établie PAR UNE MACHINE QUI COMPTE : les accès au tas correspondent aux références de variables, et la machine les suit. Chez K7PL, la relation de réduction porte un état d'arène et une trace d'effets, et rien qui compte les usages de variables. Le grade est donc une grandeur purement statique, et aucun énoncé ne la relie à un comportement observable. La préservation et le progrès ne disent rien de cela : ils disent que le type se conserve et que le potentiel ne croît pas, non que le grade compte ce qu'il prétend compter. C'est d'autant plus notable que le postulat d'autonomie physique exige que rien ne dissimule un coût, et que le grade EST la mesure de ce coût. Théorème à créer : la correction de ressource, et sa forme est donnée — étendre la configuration d'un compteur d'usages et montrer que le grade le borne.

#### \[TODO\] Les deux articles qui composent la thèse

Une théorie des types dépendante graduée avec univers et effacement, formalisée ; et une théorie correcte en ressources avec récursion, formalisée. Non dépouillés, et le second est celui dont le théorème manquant a besoin.

### THEOCHARIS

    AUTHORS: Constantine Theocharis, Edwin Brady | DATE: 2026 | TITLE: Type theory with erasure | REVUE: arXiv:2605.00655 | IDENTIFIANT: arXiv:2605.00655 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: QB-11, QB-12, QB-14, QB-15 ; c1 les cinq mécanismes d'effacement | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] L'effacement est une distinction de phase, et cela donne sa forme à ce que c1 affirme

Le chapitre 1 affirme que les cinq mécanismes d'effacement sont cinq usages d'un seul, sans dire lequel. Cette source donne la forme : l'effacement EST une distinction de phase, encodée comme une proposition dans le contexte. Un mécanisme, une forme, et un encodage précis. C'est l'énoncé qui manquait à l'affirmation du chapitre.

#### \[DONE\] Et la non-interférence entre phases est une conservativité

Le chapitre 1 indique que la non-interférence entre phases se démontre par la structure, sans le faire. Ici le résultat est la conservativité sur la théorie des types de Martin-Löf DANS LES DEUX PHASES, ce qui est la forme précise de ce que le document veut dire : ce qu'on peut prouver en présence de l'effacement, on pouvait le prouver sans lui, et réciproquement dans la phase effacée.

#### \[DONE\] Un avertissement sur la méthode, et K7PL est du bon côté

Les auteurs écrivent que l'analyse globale pour détecter heuristiquement les données non pertinentes devient FRAGILE ET IMPRÉVISIBLE dès que les capacités d'abstraction des types dépendants sont non bornées. K7PL n'est pas dans ce cas : son effacement est l'action d'un foncteur, celui du système de raffinement, donc structurel et non heuristique. C'est un acquis, et le document ne le formule pas ainsi.

#### \[TODO\] Les modèles et l'extraction par recollement

Le modèle en préfaisceaux qui produit du lambda-calcul non typé, et sa correction par recollement. C'est la forme que prendrait une preuve de correction de l'effacement de la Phase 8. Non dépouillé.

## RÉFÉRENCES RÉCUPÉRÉES DEPUIS LE REGISTRE DES DÉCISIONS ET LE MANUSCRIT

#### \[TODO\] Doublon Zotero à fusionner

Doublon Zotero : meme oeuvre que THEOCHARIS, sous un second DOI. Les deux entrees coexistent depuis la synchronisation. A FUSIONNER DANS ZOTERO, en gardant celle dont le DOI est celui de l'editeur.

### ABEL-COALG

    AUTHORS: Abel | DATE: 2016 | TITLE: Equational Reasoning about Formal Languages in Coalgebraic Style | REVUE: Equational reasoning about formal languages in coalgebraic style | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### ABEL-VEZZOSI

    AUTHORS: Abel et al. | DATE | TITLE: Compiling programs with erased univalence | REVUE: Compiling programs with erased univalence | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### ALLAIS-MCBRIDE

    AUTHORS: Allais et McBride | DATE | TITLE: Certified proof search for intuitionistic linear logic | REVUE: Leibniz international proceedings in informatics | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### ARROW-SPEC

    AUTHORS | DATE | TITLE: Apache Arrow | REVUE: Apache Arrow | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### AutomataAlgebrasCategories

    AUTHORS: Adamek et Trnkova | DATE: 1990 | TITLE: Automata and algebras in categories | REVUE: Mathematics and Its Applications | IDENTIFIANT: ISBN 978-0-7923-0010-6 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: t

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### Axiomatic_domain_theory_in_categories_of

    AUTHORS | DATE: 1994 | TITLE: Axiomatic_domain_theory_in_categories_of | REVUE: Axiomatic Domain Theory in Categories of Partial Maps | IDENTIFIANT: 10.1017/cbo9780511526565 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### BERNARDY

    AUTHORS: Bernardy et Spiwack | DATE | TITLE: Evaluating linear functions to symmetric monoidal categories | REVUE: Evaluating linear functions to symmetric monoidal categories | IDENTIFIANT: 10.1145/3471874.3472980 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### BOTTU

    AUTHORS: Bottu et al. | DATE | TITLE: Coherence of type class resolution | REVUE: Coherence of type class resolution | IDENTIFIANT: 10.1145/3341695 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### CAPNPROTO-SPEC

    AUTHORS | DATE | TITLE: Cap'n proto: encoding spec | REVUE: Cap'n proto: encoding spec | IDENTIFIANT: https://capnproto.org/encoding.html | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### CASTELLAN-PI

    AUTHORS | DATE | TITLE: Game semantics: easy as pi — introducing programming game semantics | REVUE: Game semantics: easy as pi — introducing programming game semantics | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### CICEK

    AUTHORS | DATE: 2016 | TITLE: Cost-analysis: how do monads and comonads differ? | REVUE: Cost-analysis: how do monads and comonads differ? | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### DANIELSSON-ERASED

    AUTHORS | DATE | TITLE: Logical properties of a modality for erasure | REVUE: Logical properties of a modality for erasure | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### DATAFUN

    AUTHORS: Arntzenius et Krishnaswami | DATE | TITLE: Datafun a functional datalog | REVUE: Datafun: a functional datalog | IDENTIFIANT: 10.1145/2951913.2951948 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### DISRUPTOR

    AUTHORS | DATE: 2011 | TITLE: Disruptor: high performance alternative to bounded queues for exchanging data between concurrent threads | REVUE: Disruptor: high performance alternative to bounded queues for exchanging data between concurrent threads | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### DPDK-RING

    AUTHORS | DATE | TITLE: DATA Plane Development Kit | REVUE: DATA Plane Development Kit | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### EFFCOST

    AUTHORS | DATE | TITLE: The compositional essence of effectful cost analyses: categorical foundations and fibered logical relations | REVUE: The compositional essence of effectful cost analyses: categorical foundations and fibered logical relations | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### HASEGAWA-TRACED

    AUTHORS | DATE: 2007 | TITLE: On traced monoidal closed categories | REVUE: On traced monoidal closed categories | IDENTIFIANT: 10.1017/s0960129508007184 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### HUANG

    AUTHORS | DATE: 2023 | TITLE: QTAL: a quantitatively and dependently typed assembly language | REVUE: QTAL: a quantitatively and dependently typed assembly language | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### PADOVANI

    AUTHORS | DATE: 2026 | TITLE: ACM Transactions on Programming Languages and Systems | REVUE: ACM Transactions on Programming Languages and Systems | IDENTIFIANT: 10.1145/3803862 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### PreviewCoalton022026

    AUTHORS | DATE: 2026 | TITLE: The Coalton Programming Language | REVUE: The Coalton Programming Language | IDENTIFIANT: https://coalton-lang.github.io/20260312-coalton0p2/ | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

l'arité fixe en production, et les 99 % ; P-1 et question 4

### REDDY-GLOBAL

    AUTHORS | DATE: 1997 | TITLE: J. of Lisp and Symbolic Computation | REVUE: J. of Lisp and Symbolic Computation | IDENTIFIANT: 10.1007/978-1-4757-3851-3_9 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### REDDY-PASSIVITY

    AUTHORS | DATE: 1994 | TITLE: Proceedings Ninth Annual IEEE Symposium on Logic in Computer Science | REVUE: Proceedings Ninth Annual IEEE Symposium on Logic in Computer Science | IDENTIFIANT: 10.1109/LICS.1994.316055 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### RITTER-PITTS

    AUTHORS: Ritter et Pitts | DATE: 1994 | TITLE: A fully abstract translation between a λ-calculus with reference types and standard ML | REVUE: A fully abstract translation between a λ-calculus with reference types and standard ML | IDENTIFIANT: 10.1007/bfb0014067 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### SBE-SPEC

    AUTHORS | DATE: 2020 | TITLE: Simple binary encoding (SBE) | REVUE: Simple binary encoding (SBE) | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### SCHALK

    AUTHORS | DATE: 2004 | TITLE: What is a categorical model for linear logic? | REVUE: What is a categorical model for linear logic? | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### SPIRV

    AUTHORS | DATE | TITLE: SPIR-V specification | REVUE: SPIR-V specification | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### THEOCHARIS

    AUTHORS: Theocharis et Brady | DATE: 2026 | TITLE: Type theory with erasure | REVUE: Type theory with erasure | IDENTIFIANT: 10.4230/LIPICS.FSCD.2026.31 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### VIRTIO

    AUTHORS | DATE | TITLE: Virtual I/O device (VIRTIO) specification | REVUE: Virtual I/O device (VIRTIO) specification | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### VIVIEN

    AUTHORS | DATE: 2026 | TITLE: Jfla 2026 | REVUE: Jfla 2026 | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### WASM

    AUTHORS | DATE | TITLE: WebAssembly core specification | REVUE: WebAssembly core specification | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### abelGradedModalDependent2023

    AUTHORS: Abel et al. | DATE: 2023 | TITLE: A graded modal dependent type theory with a universe and erasure, formalized | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3607862 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### abolpourBLgeneralFuzzyAutomata2012

    AUTHORS: Abolpour et Zahedi | DATE: 2012 | TITLE: BL-general fuzzy automata and accept behavior | REVUE: BL-general fuzzy automata and accept behavior | IDENTIFIANT: 10.1007/s12190-010-0466-8 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

ÉCART LEVÉ le 9 août. Écartée à tort le 8 — j'avais jugé sur le mot « flou » et sur la revue, non sur le contenu. Une BL-algèbre est un treillis borné + monoïde commutatif + résiduation : la structure d'une algèbre de grades. Et l'article démontre, au-dessus de cette structure, que la réduction minimale de la partie accessible est la réalisation minimale. Fiche dans chantier/arc-theorique.org.

### abolpourGeneralFuzzyAutomata

    AUTHORS: Abolpour et Zahedi | DATE | TITLE: General fuzzy automata based on complete residuated lattice-valued | REVUE: General fuzzy automata based on complete residuated lattice-valued | IDENTIFIANT: 10.22111/IJFS.2017.3435 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie et DÉPOUILLÉE le 9 août : isomorphismes de catégories entre automates valués dans un treillis résidué et automates non déterministes ordinaires. Versant catégorique des deux précédentes.

### abramskyCorrectedExpandedVersion

    AUTHORS: Abramsky et Jung | DATE: 1994 | TITLE: Domain Theory, Corrected and expanded version | REVUE: Handbook for Logic in Computer Science | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: t

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### algehedSimpleNoninterferenceParametricity2019

    AUTHORS: Algehed and Bernardy | DATE: 2019 | TITLE: Simple noninterference from parametricity | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3341693 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### allaisBuiltinTypesViewed2023

    AUTHORS: Allais | DATE: 2023 | TITLE: Builtin types viewed as inductive families | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-031-30044-8_5 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### allaisTypeScopeSafe2018

    AUTHORS: Allais et al. | DATE: 2018 | TITLE: A type- and scope-safe universe of syntaxes with binding their semantics and proofs | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1017/S0956796820000076 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] C'est le remède exact au coût que l'arc B avait chiffré

L'arc B avait établi, sur le jeu d'épreuves de mécanisation par relations logiques, que ce qui coûte n'est pas l'idée de la preuve mais l'INFRASTRUCTURE : extensions de contexte, affaiblissement et échange, substitutions et renommages simultanés. La source nomme exactement cette liste comme le code de plomberie qu'elle supprime, et elle supprime aussi sa réécriture DU CÔTÉ DES PREUVES. Deux arcs, un problème et sa solution, dans le même fonds.

#### \[DONE\] Ce que cela vaut pour un langage à plusieurs fragments

Un univers de syntaxes est paramétré par une description ; trois couches et un métalangage sont quatre descriptions, non quatre développements. C'est la réduction de coût que la question demandait, et elle est du bon ordre de grandeur.

#### \[TODO\] Vérifier l'assistant visé

Le développement est conduit en Agda. La question de savoir ce qui transporte à l'assistant que le document envisage reste ouverte, et elle s'ajoute au manque déjà consigné sur la coinduction.

### altenkirchIndexedContainers2009

    AUTHORS | DATE: 2009 | TITLE: 2009 24th Annual IEEE Symposium on Logic In Computer Science | REVUE: 2009 24th Annual IEEE Symposium on Logic In Computer Science | IDENTIFIANT: 10.1109/LICS.2009.33 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### antonelliCurryHowardMeet2022

    AUTHORS: Antonelli et al. | DATE: 2022 | TITLE: Curry and howard meet borel | REVUE: Proc. 37th annu. ACM/IEEE symp. Logic in computer science (LICS '22) | IDENTIFIANT: 10.1145/3531130.3533361 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### DATAFUN

    AUTHORS: Arntzenius et Krishnaswami | DATE: 2016 | TITLE: Datafun a functional datalog | REVUE: Datafun: a functional datalog | IDENTIFIANT: 10.1145/3022670.2951948 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Doublon Zotero à fusionner

Doublon Zotero : meme oeuvre que DATAFUN, sous un second DOI. Les deux entrees coexistent depuis la synchronisation. A FUSIONNER DANS ZOTERO, en gardant celle dont le DOI est celui de l'editeur.

### asaiCompilingReflectiveLanguage2015

    AUTHORS | DATE: 2015 | TITLE: ACM SIGPLAN Notices | REVUE: ACM SIGPLAN Notices | IDENTIFIANT: 10.1145/2775053.2658775 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

une sémantique modifiable interdit le compilateur autonome ; question 16

### asaiReflectionDirectStyle2012

    AUTHORS: Asai | DATE: 2012 | TITLE: Reflection in direct style | REVUE: ACM SIGPLAN Notices | IDENTIFIANT: 10.1145/2189751.2047882 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

le coût d'un niveau d'interprétation, payé même sans l'employer ; question 16

### atkeyPolynomialTimeDependent2024

    AUTHORS: Atkey | DATE: 2024 | TITLE: Polynomial Time and Dependent Types | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3632918 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

T-51 close : la réserve de complexité est réénoncée au ch.1 et cite cette référence pour la voie par réalisabilité. Le maintien n'a plus d'objet.

### atkeySyntaxSemanticsQuantitative2018

    AUTHORS | DATE: 2018 | TITLE: Proceedings of the 33rd Annual ACM/IEEE Symposium on Logic in Computer Science | REVUE: Proceedings of the 33rd Annual ACM/IEEE Symposium on Logic in Computer Science | IDENTIFIANT: 10.1145/3209108.3209189 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Ce que la théorie quantitative donne à ce document, et ce qu'elle lui refuse

La source pose une théorie des types qui enregistre, pour chaque variable d'un jugement, une information d'USAGE, et lui donne une sémantique de réalisabilité par une variante des algèbres combinatoires linéaires. C'est la fondation dont la gradation de ce document est la généralisation. Ce que le document en retient est un REFUS et non un acquis : dans le cadre de la dépendance complète, le produit libre qu'on voudrait n'est pas disponible. Cette limite est citée au chapitre 1 pour borner ce que le grade peut porter, et elle est ce qui justifie que la couche 3 ne soit pas pleinement dépendante. La lecture reste PARTIELLE : la sémantique de réalisabilité n'a pas été dépouillée, et elle serait la voie si la question de la complétude du grade se reposait.

### bachpoulsenHeftyAlgebrasModular2023

    AUTHORS: Bach Poulsen and Van Der Rest | DATE: 2023 | TITLE: Hefty algebras modular elaboration of higher-order algebraic effects | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3571255 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Ce qui rétablit la modularité que les effets d'ordre supérieur brisent

Les effets algébriques et leurs gestionnaires sont modulaires parce qu'un programme s'écrit contre une INTERFACE d'opérations déclarées, dont l'implantation se raffine sans recompiler. Les opérations d'ordre supérieur — celles qui prennent un calcul en argument — sortent de ce cadre et brisent la propriété. La source donne des élaborations MODULAIRES, composables cas par cas, des effets d'ordre supérieur vers les effets algébriques primitifs. Le document lui doit un diagnostic et son remède : un monoïde d'endomorphismes n'est pas une interface d'effet, et c'est précisément pourquoi on ne peut pas raffiner un gestionnaire sans recompiler ; mais une élaboration convenablement structurée rétablit ce qui était perdu. Trois emplois au manuscrit, tous sur le même axe : l'expansion de macro est une élaboration au sens de cette littérature.

### balanFinitaryFunctorsSet2011

    AUTHORS: Balan et Kurz | DATE: 2011 | TITLE: Finitary functors from set to preord and poset | REVUE: Algebra and coalgebra in computer science | IDENTIFIANT: 10.1007/978-3-642-22944-2_7 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### beckerCompilerErrorMessages2019

    AUTHORS: Becker et al. | DATE: 2019 | TITLE: Compiler error messages considered unhelpful the landscape of text-based programming error message | REVUE: Proceedings of the Working Group Reports on Innovation and Technology in Computer Science Education | IDENTIFIANT: 10.1145/3344429.3372508 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — les quatre articles de Becker, Denny et Prather sur les messages d'erreur, dont je n'avais que les trois noms. Sert la question 30. REÇUE, NON ENCORE DÉPOUILLÉE.

### beckertEvaluatingUsabilityInteractive

    AUTHORS: Beckert et Grebing | DATE | TITLE: Evaluating the usability of interactive veriﬁcation systems | REVUE: Evaluating the usability of interactive veriﬁcation systems | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Synchronisée sans emploi

Entrée synchronisée depuis Zotero sans emploi au corps. À citer ou à retirer lors de la prochaine synchronisation ; aucune décision de fond n'est prise ici.

### belohlavekDeterminismFuzzyAutomata2002

    AUTHORS: Bělohlávek | DATE: 2002 | TITLE: Determinism and fuzzy automata | REVUE: Information Sciences | IDENTIFIANT: 10.1016/S0020-0255(02)00192-5 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

le grade peut ne vivre que dans l'acceptation ; famille emboîtée ; chapitres 3 et 4

### bennettPrinciplesInteractionDesign2015

    AUTHORS: Bennett et Hoffman | DATE: 2015 | TITLE: Principles for interaction design, part 3 spanning the creativity gap | REVUE: Principles for interaction design, part 3: spanning the creativity gap | IDENTIFIANT: http://ieeexplore.ieee.org/document/7320928/ | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

une grille générique redécrit le problème ; contrainte sur ce que T-61 produit

### bentonLinearLcalculusCategorical1993

    AUTHORS: Benton et al. | DATE: 1993 | TITLE: Linear λ-calculus and categorical models revisited | REVUE: Computer science logic | IDENTIFIANT: 10.1007/3-540-56992-8_6 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### bergerMonadsAritiesTheir2012

    AUTHORS: Berger et al. | DATE: 2011 | TITLE: Monads with arities and their associated theories | REVUE: Journal of Pure and Applied Algebra | IDENTIFIANT: 10.1016/j.jpaa.2012.02.039 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### berryChemicalAbstractMachine1992

    AUTHORS | DATE: 1992 | TITLE: Theoretical Computer Science | REVUE: Theoretical Computer Science | IDENTIFIANT: 10.1016/0304-3975(92)90185-I | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### biermanWhatCategoricalModel1995

    AUTHORS: Bierman | DATE: 1995 | TITLE: What is a categorical model of intuitionistic linear logic | REVUE: Typed Lambda Calculi and Applications | IDENTIFIANT: 10.1007/BFb0014046 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### bilkovaProofSystemsMoss2014

    AUTHORS: Bílková et al. | DATE: 2014 | TITLE: Proof systems for moss' coalgebraic logic | REVUE: Theoretical Computer Science | IDENTIFIANT: 10.1016/j.tcs.2014.06.018 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: t

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### birdGeneralisedFoldsNested1999

    AUTHORS | DATE: 1999 | TITLE: Generalised folds for nested datatypes | REVUE: Generalised folds for nested datatypes | IDENTIFIANT: 10.1007/s001650050047 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### blackwellFiftyYearsPsychology2019

    AUTHORS: Blackwell et al. | DATE: 2019 | TITLE: Fifty years of the psychology of programming | REVUE: Fifty years of the psychology of programming | IDENTIFIANT: https://linkinghub.elsevier.com/retrieve/pii/S1071581919300795 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Doublon Zotero à fusionner

DOUBLON : cette pièce a déjà été dépouillée le 7 août dans le corpus charge cognitive et HCI, sous une autre entrée. Arrivée une seconde fois dans le lot cognition.zip. À FUSIONNER lors de la prochaine synchronisation Zotero.

### bluteDifferentialCategories2006

    AUTHORS | DATE: 2006 | TITLE: Differential categories | REVUE: Differential categories | IDENTIFIANT: https://www.cambridge.org/core/product/identifier/S0960129506005676/type/journal_article | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### bluteStorageTensorialStrength1996

    AUTHORS: Blute et al. | DATE: 1996 | TITLE: ! and  – storage as tensorial strength | REVUE: ! and ? – storage as tensorial strength | IDENTIFIANT: https://www.cambridge.org/core/product/identifier/S0960129500001055/type/journal_article | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### boccaliBicategoriesAutomataAutomata2023

    AUTHORS: Boccali et al. | DATE: 2023 | TITLE: Bicategories of automata, automata in bicategories | REVUE: Electronic Proceedings in Theoretical Computer Science | IDENTIFIANT: 10.4204/EPTCS.397.1 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

#### \[DONE\] Le déterministe et le non déterministe sont un CHANGEMENT DE BASE, non deux théories

Les auteurs définissent les machines de Mealy et de Moore À L'INTÉRIEUR d'une bicatégorie, puis spécialisent celle-ci : catégories, relations, profoncteurs. Le passage du déterministe au non déterministe est ce changement de base, une relation étant une fonction non déterministe. C'est la moitié de la réponse que la question demandait, et c'est la bonne moitié : elle dit que les deux premiers étages de la hiérarchie ne sont pas deux constructions mais une construction sur deux bases.

#### \[DONE\] L'accessibilité est une EXTENSION DE KAN, et cela intéresse la minimalisation

La propriété universelle de l'accessibilité s'y interprète comme une extension de Kan, ce qui donne une notion nouvelle de morphisme entre automates, que les auteurs appellent entrelaceurs. L'accessibilité est la première des deux étapes de toute minimalisation — écarter les états inaccessibles, puis fusionner les indiscernables. En avoir la propriété universelle donne la première étape sans calcul.

#### \[DONE\] Ce que la source NE donne PAS, et c'est un manque de corpus

Le troisième étage — l'automate à pile — n'est pas traité. Ni ici, ni dans les autres pièces catégoriques du corpus T-65 relevées à ce jour. La hiérarchie que le chapitre 4 annonce en trois étages n'a donc de compte rendu catégorique que pour deux. À consigner comme manque.

### bojanczykAutomataGroupActions2011

    AUTHORS: Bojanczyk et al. | DATE: 2011 | TITLE: Automata with group actions | REVUE: 2011 IEEE 26th Annual Symposium on Logic in Computer Science | IDENTIFIANT: 10.1109/LICS.2011.48 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### bojanczykAutomataTheoryNominal2014

    AUTHORS: Bojańczyk et al. | DATE: 2014 | TITLE: Automata theory in nominal sets | REVUE: Logical Methods in Computer Science | IDENTIFIANT: 10.2168/LMCS-10(3:4)2014 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

#### \[DONE\] La bonne notion de finitude est la FINITUDE PAR ORBITES, et elle suffit à transporter la théorie

Le cadre remplace le groupe des permutations de noms par le groupe d'automorphismes de l'alphabet, généralisant les ensembles nominaux de Gabbay et Pitts. Les définitions classiques sont reprises telles quelles, la finitude étant seulement relâchée en FINITUDE PAR ORBITES. Un théorème de Myhill-Nerode est obtenu pour alphabets infinis. La structure liante de K7PL rencontre donc bien cette littérature, et la rencontre est utilisable : les définitions ne changent pas, une seule hypothèse change.

#### \[DONE\] Un AVERTISSEMENT qui vise directement l'annotation polynomiale du chapitre 4

Les auteurs écrivent que divers résultats classiques ÉCHOUENT dans le cadre nominal, pour deux motifs. La construction de l'ensemble des parties finies ne préserve pas la finitude par orbites, si bien que LA DÉTERMINISATION STANDARD DES AUTOMATES ÉCHOUE. Et l'axiome du choix fait défaut, même dans sa forme finie par orbites. Le chapitre 4 annote d'un coût polynomial les motifs qui se résolvent par un automate non déterministe, ce qui suppose que la déterminisation existe. Si les automates de K7PL portent des noms — et la question se pose, l'hygiène et l'alpha-équivalence étant au document — cette annotation est à revérifier.

#### \[DONE\] Ce qui SURVIT, en revanche, et c'est la minimalisation

Les auteurs notent que leurs modèles admettent la minimalisation des automates déterministes INDÉPENDAMMENT de la symétrie des données. La ligne de partage est donc nette et utile : minimaliser oui, déterminiser non. C'est exactement l'inverse de ce qu'un lecteur supposerait, et c'est pourquoi il faut l'écrire.

### cairesLinearSessionAbstract2026

    AUTHORS | DATE: 2026 | TITLE: ACM Transactions on Programming Languages and Systems | REVUE: ACM Transactions on Programming Languages and Systems | IDENTIFIANT: 10.1145/3819583 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La machine abstraite qui interprète le métalangage, une fois pour toutes

Une machine abstraite pour les programmes à types de session correspondant à la logique linéaire classique, dont l'apport est d'être DÉTERMINISTE — dérivée par une analyse fine de la conversion de preuves et de la focalisation, là où le modèle de base interprète naturellement les programmes comme des systèmes concurrents. C'est la pièce qui rend l'économie du chapitre 6 possible. Le métalangage n'est interprété qu'UNE fois, et correction comme adéquation se raisonnent à ce niveau plutôt que construction par construction de K7PL. Le document lui doit trois choses distinctes : le déterminisme de la couche 3 sous arène partagée, les types inductifs que l'opérateur de point fixe déductif réclame, et l'interprétation unique qui réduit la dette de fidélité. Une réserve subsiste et elle est écrite au chapitre 4 : l'interprétation du semi-treillis d'arrivée reste à donner.

### cairesLinearityControlEffects2017

    AUTHORS: Caires et Pérez | DATE: 2017 | TITLE: Linearity, control effects, and behavioral types | REVUE: Programming Languages and Systems | IDENTIFIANT: 10.1007/978-3-662-54434-1_9 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### castellanGeometryCausalityMultitoken2023

    AUTHORS: Castellan and Clairambault | DATE: 2023 | TITLE: The geometry of causality multi-token geometry of interaction and its causal unfolding | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3571217 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le modèle couvre exactement la combinaison du chapitre 4

Géométrie de l'interaction MULTI-JETONS et son dépliage causal, pour un langage d'ordre supérieur à MÉMOIRE PARTAGÉE et concurrent. La machine est faite de réseaux de Petri colorés, son adéquation est démontrée. Le chapitre 4 combine l'ordre supérieur, la concurrence et une arène partagée. C'est la même combinaison, et la source en donne un modèle plutôt qu'une analogie.

#### \[DONE\] Le résultat qui compte est une COÏNCIDENCE entre l'opérationnel et le dénotationnel

La machine engendre OPÉRATIONNELLEMENT une description causale du comportement des programmes aux types d'ordre supérieur, et cette description COÏNCIDE avec celle que donne dénotationnellement l'interprétation en jeux concurrents. C'est la forme de résultat que K7PL cherche partout ailleurs sans la nommer : relier ce que la machine fait à ce que la structure dit. Elle est ici obtenue pour la causalité ; elle manque au document pour le grade.

### castellanTwoSidesSame2019

    AUTHORS: Castellan et Yoshida | DATE: 2019 | TITLE: Two sides of the same coin session types and game semantics a synchronous side and an asynchronous | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3290340 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] L'identification tient, et elle rapporte l'ENCODAGE dont le document a besoin

Les auteurs posent que les deux formalismes décrivent le même concept — des programmes ouverts à passage de messages suivant des protocoles — les jeux représentant les protocoles et les programmes comme stratégies, les types de session spécifiant les protocoles et les processus bien typés modélisant les programmes. Mais l'apport n'est pas l'identification, qui était connue. C'est de combler un ÉCART SÉMANTIQUE entre la SYNCHRONIE du calcul de sessions et l'ASYNCHRONIE de la sémantique des jeux, par un modèle fondé sur les structures d'événements. Or c'est exactement la situation de K7PL : le chapitre 3 spécifie des protocoles par alternance stricte d'émission et de réception, donc synchrones, et le chapitre 4 les réalise sur des anneaux à producteur et consommateur uniques, donc asynchrones. Le document franchit cet écart sans le nommer.

#### \[DONE\] L'encodage est par PROTOCOLES D'APPEL ET DE RETOUR, et c'est nommable

Les auteurs proposent un encodage fidèle des stratégies synchrones dans les stratégies asynchrones par protocoles d'appel et de retour, lequel induit automatiquement un encodage au niveau des processus. C'est la justification que le passage du chapitre 3 au chapitre 4 réclame et n'a pas. À porter au programme.

#### \[DONE\] Le modèle est PLEINEMENT ABSTRAIT, et vraiment concurrent

Première interprétation vraiment concurrente et pleinement abstraite, pour la congruence barbelée, du calcul de sessions synchrone ; avec définissabilité finie des stratégies asynchrones par le calcul de sessions interne, et un prototype qui calcule l'interprétation.

### cataltepeTimeComplexityDeterministic2026

    AUTHORS: Cataltepe et Kosoy | DATE: 2026 | TITLE: Time complexity for deterministic string machines | REVUE: Time complexity for deterministic string machines | IDENTIFIANT: 10.48550/arXiv.2405.06043 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

#### \[DONE\] La contrainte de complexité devient STRUCTURELLE par un ENRICHISSEMENT

Le grief de départ est celui du chapitre 4 : la complexité mesurée sur le NOMBRE D'ÉTATS peut être exponentielle alors que la description est courte. Les auteurs y répondent par un langage compositionnel qui construit les automates comme des transformations entre catégories, représentables en diagrammes de cordes, et qui reflète la complexité de DESCRIPTION. Et la contrainte de complexité y est portée par la structure : les catégories sont ENRICHIES SUR LES ENSEMBLES FILTRÉS, et c'est l'enrichissement qui porte la borne. C'est la réponse à la question posée, et elle emploie un procédé que le document a déjà dans son vocabulaire, puisque sa relation de précision est elle-même construite par enrichissement.

#### \[DONE\] La mémoire non constante a une forme, et elle est de second ordre

Les machines à cordes sont elles-mêmes des morphismes d'une catégorie, si bien qu'une machine peut en CRÉER une autre à l'exécution : c'est ainsi que le cadre modélise les calculs demandant plus que de la mémoire constante. La distinction entre automate borné et automate à pile cesse alors d'être une étiquette pour devenir un niveau : ne pas créer de machine, ou en créer. C'est la caractérisation structurelle que la question du chapitre 4 cherchait.

#### \[DONE\] Une réserve sur le statut de la source, et il faut la porter

Les auteurs formalisent des définitions ESQUISSÉES dans un billet de forum sur l'alignement des intelligences artificielles, et le cadre en vient. La formalisation est publiée et vérifiable ; la généalogie ne l'est pas. À employer pour la forme du résultat, non comme autorité établie, et à recouper avant citation au corps.

### choFrameworkDebuggingAutomated2024

    AUTHORS: Cho et al. | DATE: 2024 | TITLE: A framework for debugging automated program verification proofs via proof actions | REVUE: Computer aided verification | IDENTIFIANT: 10.1007/978-3-031-65627-9_17 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Synchronisée sans emploi

Entrée synchronisée depuis Zotero sans emploi au corps. À citer ou à retirer lors de la prochaine synchronisation ; aucune décision de fond n'est prise ici.

### chongRequiredInformationRelease2010

    AUTHORS | DATE: 2010 | TITLE: 2010 23rd IEEE Computer Security Foundations Symposium | REVUE: 2010 23rd IEEE Computer Security Foundations Symposium | IDENTIFIANT: 10.1109/CSF.2010.22 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### choudhuryGradedDependentType2021

    AUTHORS: Choudhury, Eades III, Eisenberg et Weirich | DATE: 2021 | TITLE: A graded dependent type system with a usage-aware semantics | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3434331 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c3, annexe G : la condition de séparation, la non-interférence du zéro, la correction de ressource, la restriction sur le filtrage | SYNTHESE: t

#### \[DONE\] GraD : la condition de séparation de K7PL est celle de la source, et ses deux concurrentes sont nommées

Trois conceptions coexistent pour marier gradation et dépendance, et la source les compare. La théorie quantitative des types désactive le contrôle de ressource dans les types, ce qui borne ce qu'on peut y raisonner. Abel et Moon tiennent des comptes SÉPARÉS pour les types et pour les termes, au prix d'une comptabilité supplémentaire pour un bénéfice moindre. GraD emploie les MÊMES RÈGLES pour le pertinent et pour ce qui ne l'est pas, et jette les usages non pertinents au moment de calculer la ressource du terme entier. La condition de séparation de K7PL, où les variables de formation portent un grade nul, est la troisième : c'est le trait de GraD, et le document n'a pas à l'inventer. La source nomme aussi ce que ce choix coûte : la théorie quantitative, en transformant les types tenseurs linéaires en produits ordinaires, supporte la somme forte ; GraD n'en dit rien, et K7PL non plus.

#### \[DONE\] La NON-INTERFÉRENCE DU ZÉRO est un théorème, et K7PL en a besoin

Deux configurations initiales qui ne diffèrent que par l'affectation de variables graduées zéro produisent des résultats identiques. Démontré dans la sémantique à tas. C'est la forme exacte du lien entre effacement et irrélevance que le chapitre 1 affirme sans le démontrer : pour le grade nul, ce ne sont pas deux mécanismes, et ce n'est pas une définition, c'est un lemme. Et la source généralise : n'est pas seulement inutilisable le grade nul, mais tout grade s pour lequel la contrainte q + 1 \<= s est insatisfiable. La classe des ressources effaçables est donc définie par une contrainte, non par une valeur, ce qui la rend paramétrable par le semi-anneau.

#### \[DONE\] Une seule correction de ressource, trois conséquences

Le théorème de correction montre la bonne comptabilité de l'usage contre la sémantique instrumentée ; la sûreté du typage, la non-interférence des ressources non pertinentes et la propriété du pointeur unique pour les ressources linéaires s'en DÉRIVENT toutes les trois. Cela change le poids du théorème manquant identifié à l'arc B : la correction de ressource n'est pas un théorème de plus, c'est celui dont trois autres descendent. Le bloc A.3.6 du programme d'ajustement s'en trouve renforcé, et il a maintenant deux sources indépendantes. La propriété du pointeur unique dit qu'une ressource linéaire est désignée par exactement un pointeur à l'exécution ; c'est elle qui autorise la mise à jour en place, donc elle intéresse directement l'arène.

#### \[DONE\] Un AVERTISSEMENT sur la règle de filtrage, et K7PL y échappe par accident

La source signale avoir dû imposer, pour obtenir la correction de ressource, une restriction sur l'analyse de cas que la sûreté du typage NON graduée n'exigeait pas : la règle porte un grade q sur le sujet examiné, avec la contrainte que un soit inférieur ou égal à q, autrement dit que chaque branche consomme le sujet au moins une fois. La règle de filtrage de l'annexe G lie son sujet au grade un, fixe. Elle satisfait donc la contrainte, mais trivialement : elle FIXE ce que la source PARAMÈTRE. Le document ne dit nulle part que c'est un choix ni ce qu'il coûte, et ce qu'il coûte est une branche qui ignorerait sa charge utile sous un usage linéaire. À porter au programme d'ajustement, bloc C.

#### \[DONE\] La mécanisation existe, et elle est partielle

Substitution, affaiblissement, préservation et progrès sont mécanisés en Coq et publiés. Ce n'est pas la correction de ressource, qui reste sur papier, et c'est exactement la frontière que l'arc K rencontrera.

### pedrotFireTriangleHow2020

    AUTHORS: Pédrot et Tabareau | DATE: 2020 | TITLE: The fire triangle: how to mix substitution, dependent elimination, and effects | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3371126 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c3, annexe G : le théorème d'impossibilité auquel K7PL échappe, et par quoi | SYNTHESE: t

#### \[DONE\] Le théorème, et ce que K7PL en risque

L'énoncé se prouve en quelques lignes par l'égalité de Leibniz : l'élimination dépendante donne que le prédicat vaut sur une variable ; la substitution le transporte à un terme effectueux ; la conversion rend alors faux égal vrai, dont l'élimination dépendante tire l'absurde. K7PL a les trois : une trace d'effets au jugement, des types qui dépendent de valeurs, et un lemme de substitution démontré. Rien au document ne dit pourquoi il n'est pas visé.

#### \[DONE\] Il y échappe, et c'est PAR SON LEMME DE SUBSTITUTION

La sortie que les auteurs décrivent est de rendre explicite l'absence d'effet, par la notion de THUNKABILITÉ : tous les termes étant alors thunkables, tous les prédicats sont linéaires, et l'on récupère à la fois la substitution et la grande élimination dépendante. Or l'énoncé de substitution de l'annexe G ne substitue que des VALEURS : sa seconde hypothèse est un jugement de valeur, jamais de calcul. La thunkabilité n'a pas à être ajoutée à K7PL, elle y est structurelle — c'est la séparation valeur/calcul elle-même. Le document a donc la propriété et ne la revendique pas. À porter au bloc B, et c'est le plus lourd des acquis non revendiqués : *le calcul par poussée de valeur n'est pas un choix de discipline d'effets, c'est le seul cadre connu où substitution, élimination dépendante et effets coexistent sans inconsistance*.

#### \[DONE\] La restriction se place différemment selon la stratégie, et cela nomme le prix des autres

En appel par nom, c'est l'élimination dépendante qui doit être restreinte ; en appel par valeur, c'est la substitution. Le calcul par poussée de valeur permet de ne restreindre ni l'une ni l'autre, au prix d'un liage dépendant particulier dont le type de conclusion est lui-même un liage, puisqu'il faut évaluer le terme dans le type aussi. C'est le seul point où K7PL paie : s'il veut un jour éliminer dépendamment, il lui faudra cette forme et non la sienne.

### vakarEffectfulTreatmentDependent2016

    AUTHORS: Vákář | DATE: 2016 | TITLE: An effectful treatment of dependent types | REVUE: arXiv | IDENTIFIANT: arXiv:1603.04298 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à lire — variante courte du cadre, à comparer au précédent | SEGMENT: SEG-vakarEffectfulTreatmentDependent2016 | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[TODO\] Établir si c'est un doublon d'exposition ou un apport distinct

### mcdermottExtendedCallbypushvalueReasoning2019

    AUTHORS: McDermott et Mycroft | DATE: 2019 | TITLE: Extended call-by-push-value: reasoning about effectful programs and evaluation order | REVUE: ESOP, LNCS | IDENTIFIANT: 10.1007/978-3-030-17184-1_9 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: annexe G : la forme de la flèche et ce que la séparation valeur/calcul lui épargne | SYNTHESE: t

#### \[DONE\] La flèche de K7PL porte un effet latent, et c'est correct pour une raison qu'il ne donne pas

La règle d'abstraction de l'annexe G conclut sur une flèche annotée du grade de la liaison et de l'effet latent ; la règle d'application compose cet effet latent avec celui de l'évaluation du terme fonction. La source, elle, a besoin de deux annotations : l'effet de l'ARGUMENT, requis par l'évaluation paresseuse, et l'effet latent de la fonction. K7PL n'en porte qu'une, et l'économie est exactement celle que la séparation valeur/calcul procure : l'argument y étant une valeur, il n'a pas d'effet à consigner. La règle est donc juste, mais le document ne dit pas ce qui la rend juste, et c'est le genre de silence qui coûte à la relecture.

#### \[DONE\] Une borne du cadre, qu'il vaut de connaître avant de la rencontrer

Le calcul par poussée de valeur ne peut pas encoder l'appel par nécessité, parce que la réduction d'un sous-terme y provoque celle de toutes les copies issues d'une substitution, ce qui se formule d'ordinaire par un état mutable. Si K7PL veut un jour une évaluation à la demande sur sa couche paresseuse, ce n'est pas une extension de bibliothèque : c'est une primitive de plus au noyau, et la source en donne la forme et la théorie équationnelle.

### schwinghammerCoherenceSubsumptionMonadic2009

    AUTHORS: Schwinghammer | DATE: 2009 | TITLE: Coherence of subsumption for monadic types | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796808006886 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3, annexe G : la cohérence comme obligation, et la condition de jointure qu'elle exige | SYNTHESE: t

#### \[DONE\] La cohérence est une obligation de métathéorie, et sa preuve a une forme

Un programme valide doit avoir exactement une signification, et cela ne va pas de soi quand plusieurs dérivations le typent. La preuve procède en éliminant la réflexivité et la transitivité des dérivations, puis en poussant la subsomption à travers les règles d'introduction jusqu'à obtenir l'unicité des dérivations que le théorème exploite. K7PL a deux règles interstitielles et n'a jamais énoncé qu'elles sont cohérentes. C'est une création à porter au programme d'ajustement.

#### \[DONE\] La condition est la JOINTURE, et l'annexe G s'en sert déjà sans le dire

La preuve pour les sommes repose sur l'existence de jointures dans le système de types, et la source le dit deux fois — pour le cas des sommes et pour le choix non déterministe. Or le commentaire de la règle de filtrage de l'annexe G justifie que toutes les branches portent le même effet en disant que la sous-gradation permet de relever chacune jusqu'à leur borne supérieure. C'est l'existence de jointures, employée comme argument, sans que le document sache qu'elle est la condition de cohérence. La quantale des effets les a ; il reste à l'écrire là où l'argument s'en sert.

#### \[DONE\] Un avertissement sur les bornes du sous-typage

La règle plus générale de Breazu-Tannen pour les universels bornés, qui permet le sous-typage contravariant des bornes, est INCOMPATIBLE avec l'existence des jointures dont les sommes ont besoin. K7PL a des universels et des sommes. S'il veut un jour borner ses quantificateurs, la source dit lequel des deux il devra abandonner.

### bagrelDestinationCalculusLinear2025

    AUTHORS: Bagrel et Spiwack | DATE: 2025 | TITLE: Destination calculus: a linear lambda-calculus for purely functional memory writes | REVUE: PACMPL OOPSLA | IDENTIFIANT: 10.1145/3720423 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3, c4, annexe G : la destination et la structure incomplète au noyau, le paramètre d'âge, l'interdiction de l'affine | SYNTHESE: t

#### \[DONE\] Le mode est une PAIRE, multiplicité et âge, et cela réunit deux questions du document

Un mode y est un couple : une multiplicité, un ou oméga, et un âge, qui compte combien de portées imbriquées séparent l'origine d'une destination de son emploi. Les deux composantes ont leurs opérations, données en table : l'âge se multiplie en s'ajoutant, et il s'additionne en rendant l'infini dès que les deux âges diffèrent. Le paramètre d'âge que le chapitre 3 traite comme un mécanisme à part n'en est donc pas un : c'est une composante de mode au sens de P2, exactement comme l'usage, avec son algèbre.

#### \[DONE\] La destination et la structure incomplète sont des types du NOYAU, et trois faits l'établissent

Les auteurs les nomment les deux traits les plus saillants de leur CALCUL, non d'une bibliothèque. Trois raisons s'y lisent, et aucune ne se contourne par-dessus un noyau inchangé. La grammaire des valeurs doit changer : une valeur peut porter des destinations libres mais aucun trou libre, et une fonction ne peut contenir de trou libre du tout. C'est une condition sur la forme des valeurs, donc sur le noyau. La sûreté exige le suivi des âges, qui est une composante de mode, donc du jugement. Et la sûreté du typage a demandé une preuve mécanisée, ce qui n'est pas le régime d'une bibliothèque.

#### \[DONE\] Une INTERDICTION que K7PL doit inscrire : la destination ne peut pas être affine

La source oppose sa multiplicité un, proprement linéaire, au mode affine de Lorenzen qui admet l'affaiblissement, et donne le motif en toutes lettres : la linéarité propre importe pour les destinations sous peine de lire de la mémoire non initialisée. K7PL a une modalité affine et une chaîne de sous-typage qui monte du linéaire vers elle. Si une destination peut être relevée en affine, elle peut être abandonnée sans être remplie, et l'arène rend un mot indéterminé. Contrainte à écrire, et elle est de sûreté, non de style.

#### \[DONE\] Un AVERTISSEMENT sur le nombre d'âges, et il vise directement la forme retenue au chapitre 3

Il faut au minimum trois âges — la portée courante, la portée précédente exactement, et au moins un âge générique pour le reste, dont les destinations ne peuvent rien faire de sûr. Et la source ajoute ceci, qui est l'avertissement : les systèmes à âges en nombre FINI sont extraordinairement faciles à rater, et il s'est révélé bien plus simple d'en concevoir un avec une infinité d'âges exacts. Le paramètre du chapitre 3 est indexé par un entier ; s'il est borné, c'est le cas que la source déconseille. À trancher, et l'arbitrage est documenté.

#### \[DONE\] Ce que la localité de Rust ne suffit pas à faire

Les modes de localité — local, global — sont présentés par leurs auteurs comme une simplification drastique du système de durées de vie de Rust. La source les juge trop faibles pour suivre la portée des destinations : si deux portées imbriquées reçoivent le même mode, on ne peut plus rien en faire de sûr. C'est une réponse à la tentation de reprendre un mécanisme connu, et elle est motivée par un contre-exemple.

### kovacsClosurefreeFunctionalProgramming2024

    AUTHORS: Kovács | DATE: 2024 | TITLE: Closure-free functional programming in a two-level type theory | REVUE: PACMPL ICFP | IDENTIFIANT: 10.1145/3674648 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c3 : la condition qui manque à la valeur close, et une garantie de compilation qui ressemble à P3 | SYNTHESE: t

#### \[DONE\] La valeur close ne suffit pas : la condition qui manque s'appelle la GÉNÉRATIVITÉ

La théorie est compatible avec un axiome de générativité, qui internalise le fait que les métaprogrammes ne peuvent pas inspecter la structure des termes du niveau objet. C'est de cet axiome, et non de la clôture, que se tire la fermeture de l'univers des sommes de produits par le type somme dépendante. La question du chapitre 3 recevait donc une mauvaise réponse : ce n'est pas d'être close à la compilation qui rend le produit libre, c'est que le métaniveau soit PARAMÉTRIQUE en l'objet.

#### \[DONE\] Une garantie de compilation formulée comme K7PL formule P3

Le grief des auteurs contre l'état de l'art est que les outils d'abstraction reposent sur l'optimiseur généraliste pour atteindre une performance acceptable, et que l'utilisateur n'a qu'un contrôle indirect et fragile sur le code engendré. C'est le postulat d'autonomie physique dans une autre langue, et la réponse est de même nature que celle de K7PL : porter la garantie dans le système de types plutôt que dans le compilateur.

### tejiscakDependentlyTypedCalculus2020

    AUTHORS: Tejiščák | DATE: 2020 | TITLE: A dependently typed calculus with pattern matching and erasure inference | REVUE: PACMPL ICFP | IDENTIFIANT: 10.1145/3408973 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1 : une quatrième conception de l'effacement, distincte des trois déjà recensées | SYNTHESE: t

#### \[DONE\] Une quatrième position dans l'espace des conceptions

Le fonds portait trois manières de marier gradation et effacement — la théorie quantitative qui désactive le contrôle dans le fragment nul, les comptes séparés d'Abel et Moon, les règles communes de GraD. Celle-ci en est une quatrième, où l'annotation vit au jugement et où la composition est une rencontre. Elle intéresse K7PL sur un point précis : elle traite le filtrage, et les motifs FORCÉS, que les trois autres ne traitent pas.

#### \[TODO\] Comparer sur l'interaction avec les univers

Question ouverte, et c'est ce qui reste à lire ici.

### kuraCategoryTheoreticFrameworkDependent2026

    AUTHORS: Kura et al. | DATE: 2026 | TITLE: A category-theoretic framework for dependent effect systems | REVUE: A category-theoretic framework for dependent effect systems | IDENTIFIANT: arXiv:2601.14846 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La gradation indexée a un nom, une sémantique et une date

L'annexe G pose qu'une monade graduée ordinaire donne à chaque terme un grade d'effet fixe, alors que le parcours d'un vecteur n'a pas un grade mais une FAMILLE de grades indexée par sa longueur, et que la règle d'application doit substituer dans cette famille l'indice effectif de son argument. La source confirme le diagnostic dans les mêmes termes — les monades graduées ne supportent pas les effets dépendant des valeurs — et donne la construction qui les supporte. Le document a donc raisonné juste et travaillait sans sa référence.

#### \[DONE\] Une borne du cadre, à connaître avant de s'y appuyer

Les formules du système n'admettent que des termes de valeur TERRESTRES : ni abstraction, ni fonction récursive, et les effets génériques y sont exclus, seules les opérations sans effet étant permises. Si K7PL veut indexer un grade par une valeur calculée, la sémantique de la source ne le couvre pas telle quelle. La question ne se pose pas pour un indice de vecteur ; elle se posera pour un effet indexé par le résultat d'un appel.

### abelPOPLMarkReloadedMechanizing2019

    AUTHORS: Abel, Allais, Hameer, Momigliano, Schäfer et Stark | DATE: 2019 | TITLE: POPLMark reloaded: mechanizing proofs by logical relations | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796819000170 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: arc K, annexe G : le coût réel de la mécanisation par relations logiques, et ce qui le fait croître | SYNTHESE: t

#### \[DONE\] La méthode transporte, et le coût est chiffré

La preuve de normalisation forte tient en quatre-vingt-dix-sept lignes de Beluga, la correction de la définition inductive en cent quatre-vingt-douze. Ce ne sont pas des ordres de grandeur prohibitifs, et c'est le renseignement que la question demandait. Ce qui coûte n'est pas l'idée de la preuve mais l'infrastructure : les extensions de contexte, les propriétés des contextes comme l'affaiblissement et l'échange, les substitutions et renommages simultanés. Les auteurs le disent en propres termes, et c'est ce que leur jeu d'épreuves mesure au-delà de la simple représentation des liaisons. Pour K7PL, la conséquence est immédiate et défavorable : ses contextes sont GRADUÉS, si bien que chacune de ces opérations porte en plus une condition algébrique. Le coût nommé par la source est donc un plancher, non une estimation.

#### \[DONE\] Le facteur de croissance, et il conforte l'indexation de la règle de filtrage

Les auteurs rapportent que l'ajout de quelques règles de réduction pour les sommes disjointes a doublé la preuve de correction, le lemme de confluence ayant dû recevoir treize cas de plus, plusieurs répétitifs. L'annexe G a rendu sa somme INDEXÉE plutôt que binaire, pour un motif de protocole. La source ajoute un motif de mécanisation qui pointe dans le même sens : un schéma de cas indexé donne un cas d'induction, une cascade de sommes binaires en donne autant que de branches. L'arbitrage est conforté par une seconde raison, indépendante de la première.

#### \[DONE\] Ce que la source ne dit pas, et qui intéresse l'arc K

Les trois environnements comparés sont Beluga, Coq et Agda. LEAN 4 n'y figure pas, et le manque déjà consigné sur la coinduction en LEAN 4 s'en trouve élargi : aucune des trois données de coût ne se transporte sans hypothèse à l'assistant que le document envisage.

### moonGradedModalDependent2021

    AUTHORS: Moon et al. | DATE: 2021 | TITLE: Graded modal dependent type theory | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-030-72019-3_17 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le motif du hors-périmètre est donné, et ce n'est pas une impossibilité

La source, qui va le plus loin dans cette direction, écrit que les grades de première classe sont un TRAVAIL À VENIR, et donne l'obstacle : on ne peut pas employer des termes arbitraires comme grades dans l'implantation, si bien que des grades particuliers ont dû être choisis à la main pour la comultiplication. Les multiplicités dépendantes sont donc hors périmètre par frontière non ouverte, non par impossibilité démontrée. C'est ce que la question demandait, et le fonds ne portait pas le motif avant cette lecture.

#### \[DONE\] Un bénéfice du grade que le document ne revendique pas

Les auteurs emploient la gradation pour OPTIMISER LA PROCÉDURE DE VÉRIFICATION DE TYPE elle-même, et rapportent que l'expérience donne la preuve que les grades peuvent y servir ; une étude complète des optimisations dirigées par les grades reste à venir. Joint à la synthèse dirigée par les grades, cela fait deux sources indépendantes disant que le grade se paie dans l'outillage. Le document présente le grade comme un coût de rigueur ; il a de quoi le présenter comme un actif.

### fordParsingExpressionGrammars

    AUTHORS: Ford | DATE: 2004 | TITLE: Parsing expression grammars: a recognition-based syntactic foundation | REVUE: POPL | IDENTIFIANT: 10.1145/964001.964011 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4, c5 : la classe de grammaire, la réunion du lexical et du hiérarchique, et l'avertissement sur ce qu'on échange | SYNTHESE: t

#### \[DONE\] La question de l'ambiguïté lexicale tombe, parce que la séparation qui la produit disparaît

La source réunit lexical et hiérarchique en une grammaire unique. Les huit caractères structurels de K7PL et l'espace ne posent donc pas de problème d'analyse lexicale séparée, puisqu'il n'y a pas d'analyseur lexical séparé. La source cite deux langages où l'ambiguïté a dû être tranchée par une MÉTARÈGLE INFORMELLE dans la spécification — la plus longue correspondance chez Haskell, la préférence pour la définition ailleurs. Le choix priorisé, la répétition gloutonne et les prédicats syntaxiques donnent les moyens de dire précisément ce qu'une métarègle disait vaguement.

#### \[DONE\] Ce qu'on échange, et c'est un AVERTISSEMENT que le chapitre 4 doit porter

On n'échange pas une question décidable contre une question décidable. La source le dit : à la place de déterminer si deux alternatives d'une grammaire hors contexte sont ambiguës, le concepteur doit déterminer si deux alternatives d'un choix priorisé peuvent être RÉORDONNÉES sans changer le langage — question souvent évidente, parfois non, et INDÉCIDABLE en général. Le chapitre 4 offre les grammaires d'expressions d'analyse dans son interface de filtrage. Il doit donc porter cet avertissement, sans quoi il vend une propriété qu'il n'a pas.

### fordPackratParsingSimple

    AUTHORS: Ford | DATE: 2002 | TITLE: Packrat parsing: simple, powerful, lazy, linear time | REVUE: ICFP | IDENTIFIANT: 10.1145/581478.581483 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : la garantie de temps linéaire pour l'annotation @linear de l'interface de filtrage | SYNTHESE: t

#### \[TODO\] Vérifier ce que coûte la garantie de temps linéaire en ESPACE

La garantie s'obtient par mémoïsation de tous les résultats intermédiaires, ce qui échange du temps contre de l'espace. Le postulat d'autonomie physique interdit de dissimuler ce genre de coût ; il faut donc savoir lequel c'est avant d'annoncer du temps linéaire.

#### \[DONE\] Le coût est en ESPACE, l'auteur le dit lui-même, et il heurte le postulat

L'auteur nomme l'inconvénient principal : la consommation d'ESPACE. La borne asymptotique dans le pire cas est la même que celle des algorithmes classiques, linéaire en la taille de l'entrée, mais l'utilisation d'espace est proportionnelle à la TAILLE DE L'ENTRÉE et non à la profondeur maximale de récursion — deux grandeurs qui peuvent différer de plusieurs ordres de grandeur. Sa défense est comparative et non absolue : pour un compilateur optimisant, le coût de stockage ne dépasse probablement pas celui des phases suivantes. Le postulat d'autonomie physique interdit de dissimuler un coût. Une annotation de temps linéaire qui repose sur cette technique nomme le temps et tait l'espace, et l'espace tu est celui qui croît avec le fichier plutôt qu'avec l'imbrication.

#### \[DONE\] La comparaison qui décide, et elle est défavorable à la mémoïsation

L'analyse par dérivée d'une grammaire à pile visible donne le même temps linéaire avec une PILE, donc un espace proportionnel à la profondeur d'imbrication et non à la longueur du fichier. C'est la grandeur que la mémoïsation abandonne. Sur le postulat qui gouverne le projet, la seconde technique domine donc la première, et la syntaxe de K7PL est déjà dans sa classe.

### jiaDerivativebasedParserGenerator2021

    AUTHORS: Jia, Kumar et Tan | DATE: 2021 | TITLE: A derivative-based parser generator for visibly pushdown grammars | REVUE: PACMPL OOPSLA | IDENTIFIANT: 10.1145/3485528 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4, c5 : la classe où la syntaxe de K7PL se trouve déjà, et une alternative qui domine celle du chapitre sur le postulat | SYNTHESE: t

#### \[DONE\] La syntaxe de K7PL EST déjà à pile visible, et elle ne le sait pas

Une grammaire est à pile visible quand la structure d'appel et de retour se lit dans l'alphabet même, sans analyse. Or le chapitre 5 pose trois paires de délimiteurs qui ne s'imbriquent que dans un seul sens : l'ouverture et la fermeture sont des caractères distincts et fixés. C'est la définition de la classe, satisfaite par construction. Le document a choisi la contrainte pour un motif de couches, et il en tire gratuitement une classe de langages où l'analyse est linéaire, la vérification d'imbrication décidable, et l'algorithme formellement vérifié. Acquis à revendiquer, et il coûte une phrase.

#### \[DONE\] L'ambiguïté est SURFACÉE au lieu d'être tranchée, ce qui n'est pas la même chose

L'analyseur accepte les grammaires ambiguës et rend une FORÊT de tous les arbres valides. Les grammaires d'expressions d'analyse, que le chapitre 4 offre, font l'inverse : le choix priorisé élit silencieusement une lecture et ne dit pas qu'une autre existait. Pour un langage dont le postulat interdit de dissimuler ce qui coûte, la différence n'est pas de commodité. Une forêt dit au programmeur que sa grammaire est ambiguë ; un choix priorisé le lui cache.

#### \[DONE\] Un traducteur existe, donc le choix n'est pas exclusif

Une grammaire hors contexte étiquetée se convertit en grammaire à pile visible de façon correcte, les actions sémantiques étant portées dans les arbres de la traduite. K7PL n'a donc pas à choisir entre offrir des grammaires générales à ses utilisateurs et tenir une garantie linéaire : la voie de la traduction existe et elle est publiée.

### jiaVstarLearningVisibly2024

    AUTHORS: Jia et al. | DATE: 2024 | TITLE: V-Star: learning visibly pushdown grammars from program inputs | REVUE: à renseigner depuis Zotero | IDENTIFIANT: 10.1145/3656458 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir — l'apprentissage dans la classe où la syntaxe de K7PL se trouve | SYNTHESE: t

#### \[TODO\] Établir si l'apprentissage sert la synthèse du chapitre 3 ou seulement la rétro-ingénierie de formats

### grodinAmortizedAnalysisCoalgebra2024

    AUTHORS: Grodin et Harper | DATE: 2024 | TITLE: Amortized analysis via coalgebra | REVUE: ENTICS, MFPS | IDENTIFIANT: 10.46298/entics.14797 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : la borne de coût comme structure, dans le cadre même du document | SYNTHESE: t

#### \[DONE\] Une seconde voie pour rendre la borne STRUCTURELLE, et de meilleure généalogie

La question de l'arc demandait si le lien entre l'algèbre de grades et la borne mémoire peut cesser d'être opérationnel. Une première réponse le faisait par enrichissement sur les ensembles filtrés, dans une source dont la généalogie est un billet de forum. Celle-ci le fait par une CATÉGORIE D'ALGÈBRES DE COÛT, dans le calcul par poussée de valeur, sous la signature de Harper. Les deux réponses sont compatibles et la seconde est citable sans réserve.

#### \[DONE\] La fonction de potentiel devient un MORPHISME, et cela touche l'histomorphisme du chapitre 4

Le chapitre 4 écrit que l'histomorphisme adjoint à la machine un accumulateur d'historique dont la profondeur reste bornée par un grade plutôt que de croître avec l'entrée. C'est une borne amortie énoncée sans être nommée. La source donne le moyen de l'énoncer : la fonction de potentiel, qui est le dispositif classique de l'analyse amortie, y devient un morphisme de coalgèbres, donc un objet du langage et non une astuce de preuve.

#### \[DONE\] La composition des arguments d'amortissement, et ce qu'elle promet aux couches

Les arguments se composent dans la catégorie indexée des coalgèbres, ce qui permet d'implanter une structure amortie au moyen d'autres. C'est ce dont une bibliothèque de K7PL aurait besoin pour que les bornes annoncées à une couche survivent à leur emploi dans une autre. Aucune source du fonds ne l'avait donné.

### keizerSessionCoalgebrasCoalgebraic2021

    AUTHORS: Keizer, Basold et Pérez | DATE: 2021 | TITLE: Session coalgebras: a coalgebraic view on session types and communication protocols | REVUE: ESOP, LNCS | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_14 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3, c4 : le pont entre le type de session et la coalgèbre de l'acteur | SEGMENT: SEG-keizerSessionCoalgebrasCoalgebraic2021 | DOSSIER: corpus/lot-J-confidentialite.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Le pont que le document trace en prose existe littéralement

Le chapitre 4 pose que l'espace d'état d'un acteur est une instance de la coalgèbre terminale du chapitre 2, et le chapitre 3 pose les types de session. Le document affirme donc un pont entre les deux sans le construire. La source le construit : les types de session SONT des états de coalgèbres, et la dualité des protocoles, que le chapitre 3 pose comme définition, s'y retrouve comme conséquence. C'est l'unification que le document annonce en ouverture de chapitre — une seule forme répétée à trois échelles — appliquée au cas où il ne l'a pas faite.

### polakowNaturalDeductionIntuitionistic1999

    AUTHORS: Polakow et Pfenning | DATE: 1999 | TITLE: Natural deduction for intuitionistic non-commutative linear logic | REVUE: TLCA, LNCS 1581 | IDENTIFIANT: 10.1007/3-540-48959-2_21 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3 : le prix exact de la non-commutativité, si K7PL veut la caractérisation implicite | SYNTHESE: t

#### \[DONE\] Le prix est chiffré, et il est structurel plutôt que théorique

L'extension est CONSERVATIVE : rien de ce que K7PL démontre aujourd'hui ne serait perdu. C'est la bonne nouvelle et elle n'était pas acquise. Le prix est ailleurs, et il est de taille. Il faut un TROISIÈME CONTEXTE — intuitionniste, linéaire, ordonné — et QUATRE implications au lieu d'une : l'intuitionniste, la linéaire, et DEUX implications ordonnées, selon qu'on prend l'hypothèse à gauche ou à droite du contexte ordonné, ce qui est la distinction du calcul de Lambek. K7PL a une flèche. Il en aurait quatre, et deux d'entre elles seraient directionnelles.

#### \[DONE\] Ce qui rend l'arbitrage possible, et il revient à Anthea

La question n'est plus s'il existe une voie mais si l'on veut payer ce prix pour rendre déductible une annotation que le programmeur écrit aujourd'hui à la main. Le document a une doctrine qui tranche ce genre de cas : une construction, plusieurs instances. Trois arrows de plus est le contraire de cela. L'arbitrage est donc probablement rendu d'avance par la doctrine, mais il vaut d'être écrit plutôt que supposé.

### mairsonFUNCTIONALPEARLLinear2004

    AUTHORS: Mairson | DATE: 2004 | TITLE: Linear lambda calculus and PTIME-completeness | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796804005131 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir — la complexité intrinsèque du fragment linéaire | SYNTHESE: t

#### \[TODO\] Établir la borne inférieure que la complétude pour le temps polynomial impose

### acetoAxiomatizingTropicalSemirings2001

    AUTHORS: Aceto, Ésik et Ingólfsdóttir | DATE: 2001 | TITLE: Axiomatizing tropical semirings | REVUE: FoSSaCS, LNCS | IDENTIFIANT: 10.1007/3-540-45315-6_3 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, annexe G : un avertissement sur la composante de budget, s'il fallait la rendre tropicale | SYNTHESE: t

#### \[DONE\] AUCUN de ces semi-anneaux n'a de base FINIE pour ses équations

Le résultat vaut pour tous les semi-anneaux exotiques usuellement considérés, et il vaut aussi pour les semi-anneaux faibles commutatifs idempotents qui les sous-tendent. Conséquence pour K7PL, et elle est d'implantation : un normaliseur d'égalités de grades par réécriture ne peut pas être complet sur une telle structure, quel que soit le soin mis à écrire les règles. Ce n'est pas une question de qualité de mise en œuvre, c'est un fait de la théorie.

#### \[DONE\] Mais la décision n'est pas perdue pour autant, et il faut le dire aussi

Les auteurs donnent des CARACTÉRISATIONS des équations valides, la description explicite des algèbres libres des variétés engendrées, et des résultats d'axiomatisation relative. La distinction à tenir est donc : pas d'axiomatisation équationnelle finie, mais une théorie caractérisée. Une procédure de décision reste possible, par un autre moyen que la réécriture.

#### \[DONE\] Ce que cela dit de la composante de budget telle qu'elle est

Le budget de K7PL est ordonné par l'ordre croissant et composé par une soustraction tronquée, PARTIELLE. Ce n'est pas littéralement le semi-anneau tropical, et l'avertissement ne s'applique donc pas tel quel. Il s'applique à la question posée, qui est de savoir s'il faut ADOPTER l'ordre inversé du tropical. La réponse est : on y gagnerait le minimum comme somme, on y perdrait la finitude de l'axiomatisation. L'arbitrage est documenté.

### huntReconcilingShannonScott2023

    AUTHORS: Hunt et Sands | DATE: 2023 | TITLE: Reconciling Shannon and Scott with a lattice of computable information | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3571740 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2, c3 : quel ordre la relation de précision est, des deux qui portent ce nom | SYNTHESE: t

#### \[DONE\] La question posée à l'ordre de précision se précise, et elle a deux réponses possibles

Le document construit une relation de précision et l'enrichit sur un treillis distributif borné. La question était de savoir si ce cadre est le bon ou si un préordre suffirait. La lecture la déplace, et pour le mieux : avant de savoir si le treillis suffit, il faut savoir DE QUEL ORDRE il s'agit. Ordonner par ce qu'on SAIT — des partitions, des relations d'équivalence, un treillis complet — n'est pas ordonner par ce qui est DÉFINI. Les deux se disent plus informatif et ne coïncident pas. La relation de précision de K7PL compare des raffinements de types, donc ce qu'un type garantit : c'est du côté de Shannon plutôt que de Scott. Rien au document ne le dit, et la conséquence n'est pas verbale, puisque les deux ordres n'ont pas les mêmes propriétés de complétude.

#### \[DONE\] Un troisième emploi, du côté du flot d'information

Les auteurs notent que la structure de Shannon a été redécouverte plusieurs fois indépendamment en sécurité et en flot d'information, et sert de fondement au raisonnement sur celui-ci. K7PL a une composante de NIVEAU dans son grade, ordonnée par un treillis, et destinée au flot d'information. C'est le même treillis, et le document le construit sans la référence qui l'établit.

### gillTypesafeObservableSharing

    AUTHORS: Gill | DATE: 2009 | TITLE: Type-safe observable sharing in Haskell | REVUE: Haskell Symposium | IDENTIFIANT: 10.1145/1596638.1596653 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : ce que coûte l'observation du partage, et pourquoi la déduplication ne peut pas être gratuite | SYNTHESE: t

#### \[DONE\] La déduplication canonique n'est pas une optimisation neutre, et la source dit pourquoi

Observer que deux sous-termes sont le même objet, et non seulement égaux, c'est observer une propriété de la représentation et non de la valeur. Toute solution directe y perd la transparence référentielle, ce qui est le prix nommé par la source. La déduplication canonique de la couche 1 de K7PL est cette observation. Le document la présente comme un partage de graphe sans dire ce que l'observabilité de ce partage coûte, ni si elle est observable du tout depuis le langage.

#### \[DONE\] La sortie retenue par la source, et elle indique la forme de la réponse

La restriction à des types particuliers, plus un argument que le compromis est acceptable sur ces types-là. K7PL a de quoi faire mieux qu'un argument : il a des grades. Si le partage n'est observable que sous une modalité, la transparence référentielle est préservée là où la modalité est absente. Ce n'est pas dans le document, et c'est une piste plutôt qu'un résultat.

### konigBehaviouralMetricsQuantitative2025

    AUTHORS: König, Mardare, Panangaden, Rot et Clerc | DATE: 2025 | TITLE: Behavioural metrics and quantitative logics (Dagstuhl Seminar 24432) | REVUE: Dagstuhl Reports | IDENTIFIANT: doi:10.4230/DagRep.14.10.58 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2, c3 : la distance entre programmes gradués, avec la réserve qu'un rapport de séminaire n'est pas un résultat | SEGMENT: SEG-konigBehaviouralMetricsQuantitative2025 | DOSSIER: ref/Q1-Composition-des-modalités.pdf | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] La notion de distance existe, et elle est appariée à une logique

La réponse à la question est oui, et la forme du lien est nommée : ce n'est pas une métrique posée à côté d'une logique, c'est une métrique CARACTÉRISÉE par une logique, au sens d'un théorème de Hennessy-Milner. Pour K7PL, cela dit ce qu'il faudrait pour avoir une distance entre programmes gradués : non pas définir la distance, mais exhiber la logique quantitative dont elle est la distance induite.

#### \[DONE\] La généralisation coalgébrique, et c'est la troisième fois que ce paramètre revient

Un des défis identifiés est la généralisation aux coalgèbres, en PARAMÉTRANT LE TYPE DE BRANCHEMENT du système considéré. C'est le même paramètre que celui de la théorie universelle des automates, où le foncteur décide sur quoi l'automate opère. Trois arcs, trois domaines, un seul paramètre.

#### \[DONE\] Réserve sur le statut, à tenir

Un rapport de séminaire recense des exposés et des défis ; il ne démontre rien. Citable comme état des lieux, non comme source d'un résultat, et à remplacer par les articles qu'il recense le jour où un résultat sera nécessaire.

### leroySyntacticTheoryType1996

    AUTHORS: Leroy | DATE: 1996 | TITLE: A syntactic theory of type generativity and sharing | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796800001945 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : les noms engendrés par les modules, et le fait que les estampilles sont éliminables | SYNTHESE: t

#### \[DONE\] Les estampilles sont ÉLIMINABLES, et c'est ce que la question demandait

Le problème est ancien et bien posé par la source : l'équivalence par les NOMS contre l'équivalence par la STRUCTURE, et les deux mécanismes qui la compliquent — la générativité, par quoi une instance de module engendre des types nouveaux, et les contraintes de partage, par quoi deux types sont contraints à venir de la même instance. La réponse de la source est qu'un compte rendu syntaxique et typé suffit, et qu'il est équivalent au compte rendu par estampilles. Un compilateur séparé n'a donc pas besoin d'un mécanisme de noms engendrés à l'exécution du compilateur.

#### \[DONE\] Ce que cela règle pour K7PL, et ce que cela laisse ouvert

Le chapitre 4 traite les espaces de noms comme de grandes sous-catégories du graphe de dépendances, et les macros y engendrent des noms en Phase 0. La question était de savoir si l'analyse de dépendances pour la compilation séparée rencontre ce problème de noms. Elle le rencontre, c'est la générativité, et la source établit qu'il se traite sans estampilles. Reste ouvert ce que le document a de particulier : ses noms sont engendrés par un langage de macros TYPÉ, ce que SML n'a pas, et la source ne dit rien de ce cas.

### hoekstraCombinatorNdimensionalArray

    AUTHORS: Hoekstra | DATE: 2022 | TITLE: A combinator, n-dimensional array library in Smalltalk | REVUE: mémoire de maîtrise, Ryerson University | IDENTIFIANT: sans DOI — mémoire universitaire | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c5 : la structure du DAG de spécialisation, et le fait qu'elle est calculable | SYNTHESE: t

#### \[DONE\] La relation de spécialisation est engendrée par DEUX opérations, et il les distingue graphiquement

Les arêtes du graphe sont de deux espèces seulement, et l'auteur les code par le trait. Le trait plein : deux termes sont posés ÉGAUX l'un à l'autre. Le trait pointillé : un terme est posé égal au combinateur IDENTITÉ. Le trait mixte combine les deux. Poser deux arguments égaux est une CONTRACTION ; poser un argument à l'identité n'est pas un affaiblissement mais une substitution d'unité. La lecture sous-structurelle est donc exacte pour la première espèce d'arête et inexacte pour la seconde.

#### \[DONE\] La structure algébrique existe et elle est classique : c'est l'ordre d'INSTANCE

Un combinateur est spécialisation d'un autre quand il en est une instance par substitution. Le graphe est donc l'ordre d'instance sur les termes, ordre bien connu, calculable par filtrage dans un sens et par ANTI-UNIFICATION dans l'autre, la généralisation la moins générale donnant les bornes. Ce n'est pas une structure de plus à inventer : c'est celle que tout système de réécriture emploie déjà. La conséquence pour K7PL est directe — un compilateur peut DÉRIVER quelle spécialisation s'applique au lieu de la faire déclarer.

#### \[DONE\] Une preuve indirecte que l'ordre est régulier

L'auteur rapporte avoir identifié et NOMMÉ des combinateurs qui manquaient à la littérature. On ne repère un trou que dans une structure régulière ; c'est un indice, non une démonstration, mais il va dans le sens de la lecture par l'ordre d'instance.

### bianchiniCoeffectsSharingMutation2022

    AUTHORS: Bianchini, Dagnino, Giannini, Zucca et Servetto | DATE: 2022 | TITLE: Coeffects for sharing and mutation | REVUE: PACMPL OOPSLA | IDENTIFIANT: 10.1145/3563319 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3, c4 : le partage se dit par un grade, mais pas par un grade de la forme de celui de K7PL | SYNTHESE: t

#### \[DONE\] La voie : le partage EST exprimable comme un grade, et c'est démontré

Le partage n'est pas une propriété qu'on constate après coup mais une composante que le jugement porte, calculée de bas en haut en combinant celles des sous-termes par un jeu fixé d'opérateurs algébriques. Les auteurs en tirent la préservation par réduction — le type, le partage et les modificateurs sont préservés — puis, par-dessus, l'unicité et l'immuabilité détectées statiquement. Pour K7PL, cela déplace la question du partage : ce n'est pas une affaire de représentation à documenter, c'est une composante de grade à ajouter, et une source montre qu'elle porte ses théorèmes.

#### \[DONE\] L'OBSTACLE, et il vise la forme du grade de K7PL

Les auteurs signalent que leur exemple est significatif parce qu'il donne des COEFFETS NON STRUCTURELS, *qui ne peuvent pas se calculer variable par variable, la manière dont une variable est employée pouvant affecter les coeffets d'autres variables*. Or le grade de K7PL est strictement par variable : le contexte associe à chaque liaison un grade, et rien ne relie deux liaisons entre elles. Le partage ne s'y exprime donc pas tel quel, et ce n'est pas une lacune d'écriture mais une propriété de la forme retenue.

#### \[DONE\] Le dispositif qui contourne l'obstacle, et il est simple

Une représentation globale par graphe conviendrait mais ne serait pas par variable ; il faut donc, écrivent les auteurs, une représentation par variable qui supporte encore la somme et la multiplication scalaire. Le dispositif est celui des LIENS : un ensemble dénombrable de liens, chaque variable en portant un ensemble, deux variables partageant lorsqu'elles ont un lien commun ; plus un lien distingué qui dénote la connexion au résultat. C'est la forme de ce qu'il faudrait ajouter à K7PL pour dire le partage : non pas une valeur de plus dans le quadruplet, mais une composante ENSEMBLISTE dont l'intersection non vide est le fait relationnel.

#### \[DONE\] Ce que les auteurs revendiquent, et ce qu'ils ne revendiquent pas

Ils précisent ne pas proposer une conception nouvelle de la gestion mémoire, mais une preuve de concept que les coeffets peuvent servir de base à de telles fonctionnalités. À employer comme précédent de méthode, non comme conception à reprendre.

### vanstrydonckLinearCapabilitiesFully2019

    AUTHORS: Van Strydonck, Piessens et Devriese | DATE: 2019 | TITLE: Linear capabilities for fully abstract compilation of separation-logic-verified code | REVUE: PACMPL ICFP | IDENTIFIANT: 10.1145/3341688 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3, c6 : le troisième des trois franchissements de la frontière de confiance, celui de la passerelle FFI | SYNTHESE: t

#### \[DONE\] Le troisième franchissement de la frontière de confiance reçoit son traitement

Le chapitre 3 nomme lui-même une notion qu'il emploie sans l'avoir définie, avec trois franchissements traités différemment sans que rien ne justifie l'écart : la Phase 0, l'effet d'importation, et la capacité exportée par la passerelle vers le code étranger. La source traite exactement le troisième, et elle le traite par le moyen que K7PL a déjà : la LINÉARITÉ de la capabilité. Ce qui manque au document n'est donc pas un mécanisme mais la propriété que ce mécanisme achète, et elle est nommée — la pleine abstraction de la compilation.

#### \[DONE\] Ce que la linéarité achète précisément, et pourquoi elle et pas autre chose

Le problème est qu'un appel sortant ne doit pas accéder aux ressources que le module vérifié possède. Une capabilité copiable ne le garantit pas, puisque le non fiable pourrait en conserver un exemplaire au-delà de l'appel. La non-duplicabilité est donc la propriété qui ferme la frontière, et les auteurs la font tenir par le MATÉRIEL plutôt que par le typage. C'est une différence à noter pour K7PL, dont la garantie est statique : elle vaut du code qu'il compile, non du code étranger qui la reçoit.

#### \[DONE\] Une conséquence pour l'unikernel, et elle n'est pas dans le document

Si la garantie de non-duplication doit survivre au franchissement, il faut ou bien un support matériel de capabilités, ou bien un enveloppement dynamique au point de sortie. Le document ne dit ni l'un ni l'autre, et l'alternative est celle que la source pose.

### lahavMakingWeakMemory2021

    AUTHORS: Lahav, Namakonov, Oberhauser, Podkopaev et Vafeiadis | DATE: 2021 | TITLE: Making weak memory models fair | REVUE: PACMPL OOPSLA | IDENTIFIANT: 10.1145/3485475 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : l'invariant de vivacité de la supervision, qui suppose une hypothèse qu'il ne nomme pas | SYNTHESE: t

#### \[DONE\] L'invariant de vivacité de K7PL suppose une hypothèse qu'il ne nomme pas

Le chapitre 4 pose que la supervision applique des politiques de redémarrage garanties par un invariant de vivacité — un acteur en panne finit toujours par redevenir actif. Et la notification entre fibrilles y est un compteur incrémenté par le producteur et SONDÉ par le consommateur, sous un modèle acquisition-libération. Un consommateur qui sonde est une boucle d'attente, et sa vivacité sous modèle faible est exactement le cas que la source traite. L'équité entre fils ne suffit pas ; il faut l'équité mémoire, et le modèle acquisition-libération est l'un des quatre pour lesquels les auteurs l'établissent. L'invariant du document est donc conditionnel à une hypothèse qu'il ne pose pas.

#### \[DONE\] Le risque n'est pas théorique, et les auteurs le chiffrent

Ils rapportent que plusieurs implantations d'exclusion mutuelle existantes SE BLOQUENT si trop peu de barrières sont employées, et qu'un algorithme publié contient un tel défaut de terminaison, dont ils donnent une version simplifiée. Le chapitre 4 pose au contraire que le modèle acquisition-libération est le plus faible qui suffise et fixe les barrières — libération à la publication, acquisition à la consommation, AUCUNE AILLEURS. C'est précisément la configuration où le défaut décrit apparaît, et rien au document ne vérifie qu'elle y échappe.

#### \[DONE\] Ce que la source permet de dire, et c'est un gain

Leur condition préserve la correction des transformations locales et du schéma de compilation vers x86-TSO, et permet les premières preuves formelles de terminaison d'implantations d'exclusion mutuelle sous modèle faible déclaratif. K7PL peut donc énoncer sa vivacité correctement plutôt que de la retirer : il lui faut nommer l'équité mémoire comme hypothèse, au même titre que l'équité de l'ordonnanceur.

### mevelFormalVerificationConcurrent2021

    AUTHORS: Mével et Jourdan | DATE: 2021 | TITLE: Formal verification of a concurrent bounded queue in a weak memory model | REVUE: PACMPL ICFP | IDENTIFIANT: 10.1145/3473571 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : la vérification de l'anneau, et la forme que prendrait la conformité de l'abaissement | SYNTHESE: t

#### \[DONE\] L'anneau du chapitre 4 a son précédent vérifié, et sous le bon modèle

Le document repose sur un anneau à producteur et consommateur uniques, mémoire allouée au démarrage, sous acquisition-libération. La source vérifie exactement cet objet — une file bornée concurrente — sous un modèle faible, et la vérification est mécanisée. Ce n'est donc pas un objet dont la correction serait empruntée à une note d'ingénierie : le fonds en porte une preuve, et il faut la citer là où le document cite la note.

#### \[DONE\] Le dispositif à retenir : l'antériorité est un TRANSFERT DE VUE

Les vues forment un treillis, et dire que deux points sont ordonnés, c'est transférer une vue de l'un à l'autre. La logique distingue une assertion persistante disant que le fil courant possède la connaissance d'une vue, et une assertion objective où la vue ambiante a été substituée. Pour K7PL, cela donne la forme que prendrait l'engagement de conformité de l'abaissement : non pas une propriété à vérifier sur le code engendré, mais une logique paramétrée par le modèle mémoire, dans laquelle l'anneau se prouve une fois.

### kirkhamFoundationsEmpiricalMemory2020

    AUTHORS: Kirkham et al. | DATE: 2020 | TITLE: Foundations of empirical memory consistency testing | REVUE: PACMPL OOPSLA | IDENTIFIANT: 10.1145/3428294 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6, G-06 : le protocole de test, et l'avertissement sur ce qu'un test non réglé vaut | SYNTHESE: t

#### \[DONE\] Le protocole demandé existe, et il a une forme

Régler les paramètres de sollicitation plus efficacement, ce qui donne des résultats de plus haute confiance plus vite. La démarche est présentée avec ses données empiriques, sur trois processeurs graphiques de trois fabricants, la portabilité de la méthode étant établie à travers eux.

#### \[DONE\] L'AVERTISSEMENT, et il vise ce qu'un test non réglé vaudrait

Les auteurs justifient le besoin par une MÉTA-ÉTUDE des travaux antérieurs, laquelle révèle des résultats de FAIBLE REPRODUCTIBILITÉ et un emploi inefficace du temps de test. Un test de cohérence mémoire conduit sans protocole réglé ne donne donc pas une confiance faible : il donne une confiance ILLUSOIRE, puisque l'absence d'observation d'un comportement rare ne distingue pas son impossibilité de son improbabilité. C'est ce que le point de contrôle du document doit inscrire.

### sammlerHighlevelBenefitsLowlevel2020

    AUTHORS: Sammler et al. | DATE: 2020 | TITLE: The high-level benefits of low-level sandboxing | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3371100 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4, c6 : la portée exacte de l'isolation par les types, et où elle cesse | SYNTHESE: t

#### \[DONE\] La portée de l'isolation par les types est nommée, et elle s'arrête là où l'unikernel commence

L'engagement du document est l'isolation par les types plutôt que par unité de gestion mémoire. La source dit exactement dans quel cadre cet argument vaut : celui d'un modèle mémoire abstrait, où ne pas partager un emplacement suffit à le cacher. Or K7PL vise un unikernel, donc un modèle mémoire concret, où l'adresse se calcule. Dans ce cadre, ne pas partager une référence ne suffit plus, et la source dit que c'est ce qui justifie le bac à sable. L'engagement n'est donc pas faux : il est vrai d'un cadre que la cible ne satisfait pas.

#### \[DONE\] Ce que cela oblige à écrire

Ou bien K7PL restreint son affirmation d'isolation au code qu'il compile et au modèle abstrait, ou bien il adjoint un mécanisme de confinement au niveau concret, et la source recense les familles disponibles — isolation logicielle des fautes, étiquetage architectural, capabilités mémoire matérielles. Ce que le document ne peut pas faire est de conserver l'affirmation sans dire de quel modèle mémoire elle parle.

### jacobsDeadlockfreeSeparationLogic2024

    AUTHORS: Jacobs, Hinrichsen et Krebbers | DATE: 2024 | TITLE: Deadlock-free separation logic: linearity yields progress for dependent higher-order message passing | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3632889 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c3, c4 : la linéarité comme source du progrès, et une relation de sous-protocole | SYNTHESE: t

#### \[DONE\] La relation de sous-protocole est ce que le chapitre 3 appelle sous-typage de session

Elle est variante dans les deux directions, se spécialisant en émission et s'abstrayant en réception, et elle s'applique en profondeur dans un protocole. C'est la structure que le document emploie sans l'avoir posée, et la source la donne avec ses règles.

#### \[TODO\] Établir le rapport entre le progrès par linéarité et la productivité de la couche 2

Point ouvert : la source obtient le progrès de la linéarité, le document obtient la productivité d'un indice de taille. Savoir si ce sont deux chemins vers le même énoncé demande une lecture des conditions de garde.

### dolanMemoryModelMulticore

    AUTHORS: Dolan, Sivaramakrishnan et Madhavapeddy | DATE: 2018 | TITLE: Bounding data races in space and time — a memory model for multicore OCaml | REVUE: PLDI | IDENTIFIANT: 10.1145/3192366.3192421 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir — le précédent d'un langage déployé qui déclare son modèle mémoire | SYNTHESE: t

#### \[TODO\] Extraire par une autre voie et dépouiller le compromis retenu

### lindleyTalkingBananasStructural2016

    AUTHORS: Lindley et Morris | DATE: 2016 | TITLE: Talking bananas: structural recursion for session types | REVUE: ICFP | IDENTIFIANT: 10.1145/2951913.2951921 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c2, c3, c4 : le point fixe du métalangage devrait être un CATAMORPHISME, et la dualité récursive en dépend | SEGMENT: SEG-lindleyTalkingBananasStructural2016 | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Le point fixe du métalangage devrait être un CATAMORPHISME, et la doctrine du document le demande déjà

La grammaire du métalangage porte un opérateur de point fixe arbitraire. Or les auteurs remplacent exactement cela par le pli, en suivant la sémantique des algèbres initiales, et les types de session récursifs en naissent naturellement. C'est la doctrine que le chapitre 2 applique partout ailleurs — la couche 3 interdit la récursion générale et exprime toute itération comme un pli sur le plus petit point fixe. Le métalangage fait exception à cette règle sans qu'aucune raison ne soit donnée.

#### \[DONE\] Ce que le pli RÉSOUT, et le document a le problème sans le savoir

Les auteurs écrivent que cette approche principielle de la récursion RÉSOUT DES PROBLÈMES DE LONGUE DATE dans le traitement de la DUALITÉ pour les types de session récursifs. Le chapitre 3 dérive sa dualité du retournement des arguments de l'implication linéaire, et ses protocoles récurrent. La combinaison naïve des deux est précisément ce qui pose problème dans la littérature, et le document ne le mentionne pas.

#### \[DONE\] La terminaison en présence de types récursifs, par une voie que le document n'a pas

La concurrence de GV est caractérisée par une traduction en style par continuations vers un lambda-calcul NON concurrent, la réduction de GV étant simulée par la réduction complète du lambda-calcul. Il en résulte que GV RESTE TERMINANT en présence de types récursifs positifs, et que l'argument s'étend au polymorphisme et aux types non linéaires par appel aux résultats de normalisation des lambda-calculs séquentiels. C'est un troisième critère de terminaison, obtenu par réduction au cas séquentiel, là où le document en a trois qui reposent tous sur le type.

#### \[DONE\] Et la connexion que le chapitre 6 réclame est préservée

Les auteurs étendent aussi un calcul de processus typé par sessions fondé sur la logique linéaire par des types récursifs, et montrent que cela PRÉSERVE LA CONNEXION entre la réduction dans GV et l'ÉLIMINATION DES COUPURES dans ce calcul. C'est la forme de l'énoncé de fidélité du chapitre 6, établie pour le cas récursif.

### stefikEmpiricalInvestigationProgramming2013

    AUTHORS: Stefik et Siebert | DATE: 2013 | TITLE: An empirical investigation into programming language syntax | REVUE: An empirical investigation into programming language syntax | IDENTIFIANT: 10.1145/2534973 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c5 : le pari des glyphes, et ce que la convention vaut réellement | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

le placebo syntaxique et la carte d'exactitude par jeton ; protocole et P-3

#### \[DONE\] La syntaxe conventionnelle ne fait PAS mieux que le hasard, et c'est mesuré

Les auteurs écrivent avoir été surpris : les langages à syntaxe traditionnelle de type C — Perl et Java — n'ont PAS donné de taux d'exactitude significativement supérieurs à ceux du langage aux mots-clés tirés au hasard, tandis que les langages qui s'en écartent — Quorum, Python, Ruby — l'ont fait. Pour K7PL, cela retire son appui au principal argument contre le pari des glyphes. « La syntaxe familière est plus facile » n'est pas une hypothèse neutre : elle est testée et elle échoue, du moins pour cette population et cette tâche.

#### \[DONE\] Les chiffres de la question sont exacts, et le tableau en dit plus qu'eux

Pour les boucles, colonne des NON-programmeurs : en tête repeat à 6,88, again à 6,43, loop à 6,30 ; en queue foreach à 2,99, while à 2,37 et for à 2,13. Le projet avait donc raison sur les deux valeurs. Mais la colonne des PROGRAMMEURS renverse le tableau : loop à 7,88, repeat à 7,49, cycle à 6,65 en tête, et for ne figure plus du tout en queue, laquelle est duplicate à 4,67, foreach à 4,35, echo à 4,13. La pénalité de for est donc un effet de NOVICE que l'expérience efface, et c'est un résultat plus utile que la valeur brute.

#### \[DONE\] L'échec de la convention est LOCALISÉ, ce qui vaut mieux qu'un verdict global

Il ne frappe pas partout. Pour les conditionnelles, if est en tête dans les deux populations — 6,89 chez les non-programmeurs, 8,37 chez les programmeurs. Pour l'affectation, le signe égal est en tête dans les deux, hors des intervalles de confiance de tous les autres à une exception près. Pour la concaténation, le plus est en tête dans les deux. La convention tient donc pour la conditionnelle, l'affectation et la concaténation, et elle échoue pour la BOUCLE — où les deux mots-clés les plus universels de la programmation sont les deux plus mal notés par ceux qui ne programment pas.

#### \[DONE\] La question de transport, et il faut la poser

Le cadre est celui de NOVICES, sur des tâches d'exactitude et des notes d'intuitivité, en contexte d'enseignement. K7PL ne vise pas des novices. Ce que le résultat autorise est donc négatif et non positif : il retire un argument contre l'écart à la convention ; il n'établit pas qu'un glyphe soit meilleur qu'un mot pour un praticien expérimenté.

### oliveiraEvaluatingCodeReadability2020

    AUTHORS: Oliveira, Bruno, Madeiral et Castor | DATE: 2021 | TITLE: Evaluating code readability and legibility: an examination of human-centric studies | REVUE: ICSME | IDENTIFIANT: arXiv:2110.00785 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c5 : la coupe lisibilité/légibilité, et pourquoi une notation ne se juge que pour une tâche | SEGMENT: SEG-oliveiraEvaluatingCodeReadability2020 | DOSSIER: corpus/N-ergonomie-esthetique.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] La coupe tient, elle est dans la littérature évaluée par les pairs, et les deux définitions sont écrites

La LISIBILITÉ est ce qui rend un programme plus ou moins facile à LIRE ET COMPRENDRE par un développeur. La LÉGIBILITÉ est ce qui influence la FACILITÉ D'IDENTIFIER LES ÉLÉMENTS d'un programme. Ce n'est donc pas une distinction de praticien : elle est posée dans une revue systématique, et l'apport propre de l'article est que personne n'avait examiné COMMENT les études les évaluent.

#### \[DONE\] Ce qui soutient l'anti-superlativisme, et il faut dire à quel titre

Les auteurs relèvent que ces études évaluent la lisibilité et la légibilité au moyen de TÂCHES DE COMPRÉHENSION ET DE VARIABLES DE RÉPONSE DIFFÉRENTES, et que l'analyse de ces tâches et de ces variables permet d'identifier les limites des évaluations antérieures. C'est un appui MÉTHODOLOGIQUE à la position selon laquelle une notation n'est lisible que pour une tâche : si les tâches diffèrent et que les résultats en dépendent, un jugement de lisibilité sans tâche n'a pas de référent. Ce n'est pas une démonstration de la position, c'est la raison pour laquelle elle est difficile à réfuter.

### greenCognitiveDimensionsAchievements2006

    AUTHORS: Green, Blandford, Church, Roast et Clarke | DATE: 2006 | TITLE: Cognitive dimensions: achievements, new directions, and open questions | REVUE: Journal of Visual Languages and Computing | IDENTIFIANT: 10.1016/j.jvlc.2006.04.004 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c5 : la limite du cadre, et elle est posée par son auteur | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] La limite est confirmée, et c'est l'auteur qui la pose

Green écrit que l'intention était de fournir des OUTILS DE DISCUSSION, pour élever le niveau du discours entre choisisseurs et utilisateurs qui sont spécialistes d'un domaine sans être informaticiens, spécialistes de l'interaction ou psychologues — en donnant des termes à employer dans la discussion, formant une courte liste de contrôle, pour qu'il soit plus facile de converser sans avoir à expliquer ce qu'on entend à chaque pas. Et il résume : l'intention d'origine était d'améliorer la pratique de conception en rendant plus facile de PARLER de l'utilisabilité à un niveau d'abstraction approprié. Le cadre est donc un instrument de conversation, par la volonté de son auteur. L'employer comme cadre de conception ou de validation est un emploi qu'il n'a jamais revendiqué.

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — numéro spécial du Journal of Visual Languages and Computing 17 (2006) sur les dimensions cognitives, fourni à la place de « Ten Years of Cognitive Dimensions » qui en est l'avant-propos et n'a pu être isolé. REÇUE, NON ENCORE DÉPOUILLÉE.

### dennyErrorMessageReadability2020

    AUTHORS: Denny, Prather et Becker | DATE: 2020 | TITLE: Error message readability and novice debugging performance | REVUE: ITiCSE | IDENTIFIANT: 10.1145/3341525.3387384 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : le gain mesuré d'un message plus lisible, et la borne de ce que la mesure autorise | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Le facteur deux est exact, et il est significatif

Les étudiants du groupe aux messages d'origine ont passé en moyenne sept cent dix virgule sept secondes sur la tâche, contre trois cent vingt-quatre virgule neuf pour le groupe aux messages réécrits. Les distributions diffèrent significativement, par un test de rangs signés, à moins d'un pour mille. Les trois questions de recherche reçoivent une réponse positive : les nouveaux messages sont plus lisibles selon des métriques objectives ; presque tous les étudiants déclarent les lire et les trouvent plus utiles ; et deux profils distincts de comportement de débogage se dégagent, les nouveaux messages diminuant significativement le temps et l'effort.

#### \[DONE\] L'AVERTISSEMENT des auteurs, qui borne ce qu'on peut en tirer

Ils ouvrent en écrivant que les résultats de ce courant de recherche sont actuellement MITIGÉS, et que la comparaison directe entre études est difficile parce qu'elles portent sur des enrichissements de nature différente et rapportent leurs résultats SELON DES MÉTRIQUES DIFFÉRENTES. Le facteur deux vaut donc de cette expérience et de son contexte — un cours de première année — et non du principe général qu'un message réécrit vaut mieux. C'est un résultat solide et local, non un résultat transportable.

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — les quatre articles de Becker, Denny et Prather sur les messages d'erreur, dont je n'avais que les trois noms. Sert la question 30. REÇUE, NON ENCORE DÉPOUILLÉE.

### coblenzCanAdvancedType2020

    AUTHORS: Coblenz et al. | DATE: 2020 | TITLE: Can advanced type systems be usable? An empirical study of ownership, assets, and typestate in Obsidian | REVUE: PACMPL OOPSLA | IDENTIFIANT: 10.1145/3428200 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c3 : la seule mesure du fonds portant sur le jeu de traits que K7PL retient, et elle est défavorable | SYNTHESE: t

#### \[DONE\] Le résultat est défavorable, et il faut l'écrire tel quel

Les participants de la condition à types avancés ont mis PLUS de temps, avec une VARIANCE ÉLEVÉE, et quatre d'entre eux n'avaient plus assez de leurs quatre heures pour être satisfaits de leur solution — contre un seul dans l'autre condition. Un participant a abandonné après une heure quinze. Les auteurs nomment les deux causes de l'écart : la rapidité de la condition témoin, et la forte variance des temps requis par les tâches antérieures dans la condition à types avancés. C'est la mesure du fonds la plus proche du pari de K7PL — propriété, actifs, typestate — et elle ne le soutient pas.

#### \[DONE\] Ce qui borne la portée, et il faut le dire aussi, sans en faire une excuse

L'effectif est petit — dix par condition, quatorze analysés. Les participants ont une expérience médiane de cinq à neuf années. Le tutoriel est bref au regard de ce qu'un langage à typestate demande. Et le langage évalué n'est pas K7PL. La conclusion honnête est donc que le fonds ne porte AUCUNE mesure favorable au pari, une mesure défavorable de petite taille, et qu'il serait malhonnête de citer la seconde comme une réfutation ou de l'omettre comme une gêne.

### miaraProgramIndentationComprehensibility1983

    AUTHORS: Miara, Musselman, Navarro et Shneiderman | DATE: 1983 | TITLE: Program indentation and comprehensibility | REVUE: Communications of the ACM | IDENTIFIANT: 10.1145/358589.358675 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c5 : l'optimum d'indentation, et l'état réel de la preuve derrière lui | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] L'optimum est bien de cette source, mais le tableau qu'elle dresse est plus nuancé que le chiffre

Les auteurs ouvrent en écrivant que le CONSENSUS de la communauté est que l'indentation aide la compréhension, BIEN QUE DE NOMBREUSES ÉTUDES NE LE CONFIRMENT PAS. Et ils rapportent, dans leur propre revue, que Weissman avait trouvé que l'effet principal de l'indentation SEULE n'était significatif dans AUCUNE de ses mesures, une interaction significative apparaissant en revanche avec le commentaire. Le chiffre de deux à quatre espaces est donc l'hypothèse et le résultat de cette étude-ci, dans une littérature dont l'auteur note lui-même qu'elle ne soutient pas le consensus. Le citer sans cette nuance surpondère un résultat isolé de 1983.

#### \[TODO\] Chercher une réplication postérieure

Le fonds n'en porte aucune. La question de l'arc demandait précisément si le résultat avait été retesté depuis ; la réponse pour le fonds est non.

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — la référence classique sur l'indentation et la compréhension. Sert la question 48. REÇUE, NON ENCORE DÉPOUILLÉE.

### cohenCodeStyleSheets2025

    AUTHORS: Cohen et al. | DATE: 2025 | TITLE: Code style sheets: CSS for code | REVUE: à renseigner depuis Zotero | IDENTIFIANT: 10.1145/3720421 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c5 : le précédent de l'affichage dissocié du texte, et il généralise le dispositif du chapitre | SYNTHESE: t

#### \[DONE\] Le dispositif du chapitre 5 est le cas le plus simple d'un mécanisme qui existe

Le chapitre pose que le glyphe et son alias textuel sont la même macro, et que l'environnement peut afficher l'un ou l'autre sans jamais toucher au programme. C'est un cas particulier : une seule dimension, deux valeurs. La source généralise, et sur trois axes que K7PL possède déjà — la structure de la syntaxe abstraite, l'INFORMATION DE TYPE STATIQUE, et les valeurs d'exécution correspondantes. Un langage dont le jugement porte des grades et des effets a donc bien plus à afficher que deux orthographes.

#### \[DONE\] Un point de conception que le chapitre n'a pas posé

Les auteurs font dépendre le style des choix des AUTEURS ET DES LECTEURS d'un programme, distinctement. Le chapitre 5 ne dit pas à qui appartient le choix entre glyphe et alias — à celui qui écrit, à celui qui lit, ou au projet. La règle de Stroustrup qu'il invoque — la concision au glyphe pour qui la pratique, l'explicite à l'alias pour qui découvre — suppose que le choix appartient au LECTEUR. Ce n'est pas écrit, et cela change ce que l'outillage doit porter.

#### \[DONE\] Une contrainte technique à retenir

Les auteurs signalent que les programmes étant fortement imbriqués, un point clé de leur conception est un algorithme de mise en page rendant les blocs de texte imbriqués et multilignes PLUS COMPACTEMENT que les systèmes à boîtes existants. Une syntaxe à S-expressions est plus imbriquée que la moyenne. Si K7PL veut cet affichage, la mise en page est le problème, non la sélection.

### pattersonNext700Compiler

    AUTHORS: Patterson et Ahmed | DATE: 2019 | TITLE: The next 700 compiler correctness theorems (functional pearl) | REVUE: PACMPL ICFP | IDENTIFIANT: 10.1145/3341689 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : la forme de l'énoncé de correction d'un abaissement, et ce qui distingue deux ambitions | SYNTHESE: t

#### \[DONE\] Deux ambitions distinctes, et le document n'a pas dit laquelle il vise

La première est la PRÉSERVATION DU COMPORTEMENT — le programme compilé fait ce que le programme source faisait. La seconde est la PLEINE ABSTRACTION — deux composants source contextuellement équivalents se compilent en deux composants cibles contextuellement équivalents, ce qui garantit que les abstractions du langage source ne sont pas violées après compilation vers une cible de bas niveau. Le chapitre 6 énonce une fidélité sans dire laquelle des deux il revendique. Or elles ne coûtent pas la même chose et ne protègent pas contre la même chose : la seconde est ce qu'il faut quand le code compilé côtoiera du code étranger, ce qui est le cas d'un unikernel avec passerelle.

#### \[DONE\] Le compilateur PRÉSERVANT LES TYPES est la forme qui répond à la question des grades

Un compilateur préservant les types envoie un terme source de type donné sur un terme cible d'un TYPE DE TRADUCTION. C'est la forme sous laquelle une information de typage survit à l'abaissement au lieu d'être effacée avec les preuves. La question de savoir si les grades survivent à l'abaissement se reformule donc ainsi : le type de traduction porte-t-il le grade ? Si oui ils survivent, si non ils s'effacent, et c'est une propriété de la traduction, non une fatalité.

#### \[DONE\] La compositionnalité est un objectif de conception, non une propriété acquise

Les auteurs la posent comme ce qu'on voudrait : chaque passe vérifiable isolément. Le pipeline du chapitre 6 est une chaîne de huit phases dont l'ordre est argumenté par des dépendances ; c'est le cadre où cet objectif a le plus de chances d'être tenu, et le document ne le revendique pas.

### schusterCompilingEffectHandlers2020

    AUTHORS: Schuster, Brachthäuser et Ostermann | DATE: 2020 | TITLE: Compiling effect handlers in capability-passing style | REVUE: PACMPL ICFP | IDENTIFIANT: 10.1145/3408975 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : la voie de compilation des gestionnaires, et un sous-ensemble à coût NUL caractérisé par le type | SYNTHESE: t

#### \[DONE\] La voie retenue est celle que K7PL a déjà, et ce n'est pas une coïncidence

Le style à passage de capacités est l'idiome du document : une capacité de couche 1 y est un canal linéaire, et les effets se passent comme des capacités. La source établit que c'est la combinaison de ce style avec le passage de continuations itéré qui donne les accélérations. La technique est générale et engendre du code dans TOUT langage à fonctions de première classe, ce qui la rend transportable sans hypothèse sur la cible.

#### \[DONE\] Un sous-ensemble à COÛT NUL, caractérisé PAR LE TYPE et non par l'optimiseur

Les auteurs identifient un sous-ensemble de programmes où la performance s'améliore encore et où l'élimination de l'abstraction de gestionnaire est GARANTIE. Pour le capturer formellement, ils raffinent leur langage par un SYSTÈME DE TYPES PLUS RESTRICTIF, donnent une traduction DIRIGÉE PAR LES TYPES qui insère des annotations d'ÉTAGEMENT, et DÉMONTRENT qu'aucune abstraction ni application liée aux gestionnaires ne subsiste dans le programme traduit. C'est la méthode du document appliquée à la compilation : la garantie est portée par le type, non espérée de l'optimiseur. Et c'est ce que le postulat d'autonomie physique réclame — un coût nul démontré sur un fragment nommé vaut mieux qu'un coût faible espéré partout.

#### \[DONE\] Une convergence avec l'arc E qu'il faut nommer

Kovács élimine les fermetures d'exécution par l'ÉTAGEMENT dans une théorie des types à deux niveaux ; Schuster élimine les abstractions de gestionnaire par l'ÉTAGEMENT dans un système de types raffiné. Deux problèmes, deux équipes, un même dispositif. Le document a un second niveau — la Phase 0, où les macros s'exécutent avant toute vérification. C'est l'endroit où ces deux techniques se logeraient, et il ne le revendique pas.

### chirimarReferenceCountingComputational1996

    AUTHORS: Chirimar, Gunter et Riecke | DATE: 1996 | TITLE: Reference counting as a computational interpretation of linear logic | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796800001660 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4, c6 : la voie d'abaissement de la couche 1, et l'avertissement sur le pointeur unique | SYNTHESE: t

#### \[DONE\] La voie existe et elle est démontrée, non conjecturée

La relation entre le typage linéaire et la correction du comptage de références est établie précisément, et le niveau d'abstraction choisi est exactement celui dont un abaissement a besoin : assez bas pour dire le partage, assez haut pour ne pas parler de disposition.

#### \[DONE\] UN AVERTISSEMENT, et il vise une propriété que deux autres arcs ont rencontrée

La revue de l'article le pose sans détour : on a prétendu, pour plusieurs langages fondés sur la logique linéaire, que les valeurs de type linéaire ont EXACTEMENT UN POINTEUR vers elles. Cette prétention est RAISONNABLE POUR L'APPEL PAR NOM, et MOINS RAISONNABLE POUR L'APPEL PAR NÉCESSITÉ. Or l'arc B a trouvé la même propriété chez Choudhury, sous le nom de propriété du pointeur unique, présentée comme une conséquence de la correction de ressource. Et la couche 2 de K7PL porte des flux paresseux. La propriété dépend donc de la STRATÉGIE D'ÉVALUATION, et le document ne dit pas sous quelle stratégie il la revendique.

### leissaMimIRExtensibleTypeSafe2025

    AUTHORS: Leißa, Ullrich, Meyer et Hack | DATE: 2025 | TITLE: MimIR: an extensible and type-safe intermediate representation for the DSL age | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3704840 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : la représentation intermédiaire, et une alternative que le document n'a pas envisagée | SYNTHESE: t

#### \[DONE\] Une alternative à l'infrastructure retenue, et elle est plus proche du besoin

Le document abaisse vers une infrastructure à dialectes dont le système de types est faible, et la question de l'arc était ce que coûterait d'y écrire un dialecte pour les types linéaires. La source déplace la question : il existe une représentation intermédiaire dont le système de types est DÉPENDANT, donc capable de porter un grade sans dialecte à écrire. Et l'une des trois études de cas est un greffon de filtrage par expressions régulières — précisément l'objet que le chapitre 4 abaisse en automate.

#### \[DONE\] Ce que le modèle à greffons change pour l'architecture

Un greffon y étend le compilateur ET prend en charge l'optimisation et l'abaissement de ses propres axiomes. C'est la même discipline que le document applique à sa bibliothèque, où un glyphe est une macro qui porte son algorithme et ses annotations. À instruire avant de figer la cible : le document a choisi son infrastructure sans que le fonds porte la comparaison.

### fitzgibbonsRichWasmBringingSafe2024

    AUTHORS: Fitzgibbons, Paraskevopoulou, Mushtak, Thalakottur, Sulaiman Manzur et Ahmed | DATE: 2024 | TITLE: RichWasm: bringing safe, fine-grained, shared-memory interoperability down to WebAssembly | REVUE: PACMPL PLDI | IDENTIFIANT: 10.1145/3656444 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : la cible, et le fait que la LINÉARITÉ y existe déjà | SYNTHESE: t

#### \[DONE\] La cible sait déjà porter la linéarité, ce qui change ce que la couche 1 doit exposer

La question de l'arc était de savoir si le modèle de composants change ce que la couche 1 doit exposer. La réponse trouvée est meilleure : il existe une extension de la cible où le qualificateur de linéarité est un PARAMÈTRE DE TYPE, sur lequel une fonction peut être polymorphe au même titre que sur les emplacements et les tailles. Un abaissement vers cette cible ne perdrait donc pas la discipline de ressource, et la question de savoir si les grades survivent y reçoit une réponse constructive plutôt qu'une conjecture.

#### \[DONE\] La visée de la source est celle de la passerelle du document

Interopérabilité SÛRE ET À GRAIN FIN en MÉMOIRE PARTAGÉE, ce qui est exactement la situation de la passerelle vers un système hôte que le chapitre 4 décrit, et le lieu où l'arc E a placé le troisième franchissement de la frontière de confiance.

### sergeyModularHigherOrder2017

    AUTHORS: Sergey, Vytiniotis, Peyton Jones et Breitner | DATE: 2017 | TITLE: Modular, higher-order cardinality analysis in theory and practice | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796817000016 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c3 : ce que le grade d'usage déclare, une analyse l'infère — et la comparaison est instructive | SYNTHESE: t

#### \[DONE\] Ce que le grade DÉCLARE, l'analyse l'INFÈRE, et c'est la même grandeur

Les deux calculent combien de fois une chose est employée. La différence est de sens : l'analyse la déduit du programme et peut se tromper par excès de prudence ; le grade l'exige du programme et refuse ce qui ne s'y conforme pas. La comparaison est utile au document parce qu'elle chiffre ce qu'il gagne : le compilateur optimisant a besoin d'une analyse entière, de sa preuve de correction et de ses mesures, pour obtenir une information que le jugement gradué porte par construction.

#### \[DONE\] Un rappel de stratégie, et c'est le troisième arc où il revient

La correction est établie au regard d'une sémantique par NÉCESSITÉ. Les propriétés d'usage dépendent de la stratégie d'évaluation, comme l'arc I l'a trouvé pour le pointeur unique et comme l'arc B l'avait rencontré chez Choudhury. Le document ne dit nulle part sous quelle stratégie ses énoncés d'usage valent, alors que sa couche 2 porte des flux paresseux et son noyau une séparation valeur/calcul.

### stefanAddressingCovertTermination2012

    AUTHORS: Stefan, Russo, Buiras, Levy, Mitchell et Mazières | DATE: 2012 | TITLE: Addressing covert termination and timing channels in concurrent information flow systems | REVUE: ICFP | IDENTIFIANT: 10.1145/2364527.2364557 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c4 : les canaux de terminaison et de temps, et un remède que l'architecture du document porte déjà | SEGMENT: SEG-stefanAddressingCovertTermination2012 | DOSSIER: corpus/lot-J-confidentialite.txt | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Le remède est de placer le risque dans un FIL À PART, porteur d'une étiquette

Les auteurs tirent parti de la concurrence pour atténuer les canaux qu'elle aggrave : ils placent les actions potentiellement non terminantes, ou celles dont le temps peut dépendre de valeurs secrètes, dans des FILS SÉPARÉS. Chaque fil porte une ÉTIQUETTE COURANTE qui suit la sensibilité des données qu'il a observées et restreint les emplacements où il peut écrire.

#### \[DONE\] Et l'architecture du document porte déjà les deux pièces

Un acteur est un fil à état privé ; la composante de NIVEAU du grade est une étiquette qui suit la sensibilité. Le dispositif de la source se lit donc presque terme à terme dans le document — sauf qu'il n'y est pas revendiqué, et que rien n'y place explicitement l'action non terminante dans son propre acteur. La question de savoir si K7PL ferme ces canaux ou les borne reçoit donc sa réponse : il ne fait ni l'un ni l'autre aujourd'hui, et le moyen de faire le second est à portée.

#### \[DONE\] Une gradation du danger, à retenir pour l'énoncé

Le canal de terminaison est de bande passante limitée en séquentiel et dangereux en concurrent. Un document qui a trois couches dont une seule est concurrente peut donc énoncer une garantie PAR COUCHE plutôt qu'une garantie globale, et c'est la forme la plus honnête dont il dispose.

### nowackiTrackingBorrowsRegular

    AUTHORS: Nowacki et al. | DATE: 2026 | TITLE: Tracking borrows with regular expressions | REVUE: Tracking borrows with regular expressions | IDENTIFIANT: 10.1145/3839521 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: c3, c6, arc K : l'algorithme d'emprunt, ET la seule mécanisation LEAN du fonds, avec sa note de coût | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie et DÉPOUILLÉE le 9 août. Deux emplois distincts : les expressions régulières comme vérificateur de propriété lui-même — dérivées de Brzozowski, étoile de Kleene, aliasing réduit à la vacuité décidable — et le chiffre de mécanisation de première main (39 000 lignes de Lean en un mois), porté à chantier/mecanisation.org.

#### \[DONE\] L'algorithme demandé existe, il est décidable, et il est en production

La vérification d'aliasing se ramène à la vacuité d'un langage régulier. Le dispositif s'étend naturellement aux vecteurs et aux types énumérés. Il a remplacé l'analyseur d'origine d'un langage déployé en conservant la compatibilité complète. Le contraste avec ce qu'il remplace est instructif : l'analyseur antérieur procédait par interprétation abstraite sur un domaine de graphes d'emprunt, ce qui CONFONDAIT INFÉRENCE ET VÉRIFICATION et n'était justifié qu'informellement, rendant difficile d'en extraire un système de types propre, sans parler d'une preuve de correction vérifiée.

#### \[DONE\] La DÉRIVÉE revient pour la troisième fois, et cela vaut d'être noté

L'arc C avait relevé que la dérivée relie le versant catégorique et le versant syntaxique — foncteur dérivée dont on prend les coalgèbres d'un côté, analyse par dérivée des grammaires à pile visible de l'autre. Elle revient ici pour la vérification d'emprunts. Trois domaines du projet, un seul dispositif. Ce n'est plus une coïncidence à trois, c'est un outil.

#### \[DONE\] ET C'EST LA SEULE MÉCANISATION LEAN DU FONDS, ce qui renverse un manque écrit la veille

L'instruction de l'arc K avait conclu, sonde à l'appui, que le fonds ne portait AUCUNE formalisation dans l'assistant que le document envisage. C'était faux, et pour la même cause que deux fois déjà : la sonde cherchait le nom de l'assistant dans les TITRES, et ce titre-ci ne le porte pas. La pièce est mécanisée en Lean, avec preuve de correction vérifiée par machine, vérificateur exécutable éprouvé contre le compilateur de production, et ZÉRO axiome ni déclaration en suspens.

#### \[DONE\] La NOTE DE COÛT que l'arc K cherchait, et elle transporte presque directement

Trente-neuf mille lignes de Lean non vides et non commentées, deux cent soixante-sept validations, sans aucun axiome. Les preuves de correction dominent, à vingt-trois mille lignes, soit cinquante-neuf pour cent. La ventilation est le renseignement : langage, expressions régulières et sémantique deux mille sept cents ; règles de typage cinq mille huit cent dix ; PRÉSERVATION dix mille deux cent soixante-dix ; AFFAIBLISSEMENT sept mille deux cent trente ; autres preuves cinq mille cinq cents. Et le facteur d'échelle est nommé : le théorème de préservation compte cent cinquante-trois lemmes couvrant QUARANTE ET UN CAS, un par règle de typage, chacun rétablissant les trente-cinq champs de l'invariant d'état bien typé. K7PL a TRENTE-SEPT règles de typage. L'estimation transporte donc presque telle quelle, et c'est la seule du fonds qui le fasse.

#### \[DONE\] Le délai, et sa réserve

Le développement a été conduit en environ un mois avec un assistant de preuve automatisé, et les auteurs le présentent comme l'une des plus grandes mécanisations de métathéorie assistées de ce genre à ce jour. Réserve à porter : un délai obtenu par un dispositif d'assistance est un délai conditionnel à ce dispositif, non une mesure de la difficulté intrinsèque.

### devilhenaSeparationLogicEffect2021

    AUTHORS: de Vilhena et Pottier | DATE: 2021 | TITLE: A separation logic for effect handlers | REVUE: PACMPL POPL | IDENTIFIANT: 10.1145/3434314 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c3 : le raisonnement par séparation pour les gestionnaires, son prix, et pourquoi les continuations multiples sont exclues | SYNTHESE: t

#### \[DONE\] Le raisonnement existe et il est mécanisé, avec DEUX prix nommés

Le premier est que la règle de liaison est RESTREINTE aux contextes dits neutres. Ce n'est pas une commodité de présentation : c'est la contrepartie de la présence des gestionnaires. Le second est la liste des limites que les auteurs posent eux-mêmes : absence de concurrence à MÉMOIRE PARTAGÉE, absence de continuations multiples, absence d'effets NOMMÉS MULTIPLES. Or K7PL a une arène partagée et des effets nommés multiples. La logique, telle qu'elle est, ne couvre donc pas son cas, et c'est à écrire plutôt qu'à supposer.

#### \[DONE\] L'exclusion des continuations multiples n'est PAS un choix de performance

Les auteurs écartent l'explication attendue. On pourrait croire la restriction motivée par le coût — servir plusieurs invocations demanderait de copier des segments de pile — mais la motivation réelle est plus fondamentale : permettre à une continuation d'être invoquée plus d'une fois BRISE CERTAINES LOIS FONDAMENTALES DU RAISONNEMENT SUR LES PROGRAMMES. La formule qui le dit tient en une ligne : si une continuation peut être appelée deux fois, alors un bloc de code peut être ENTRÉ UNE FOIS ET QUITTÉ DEUX FOIS. C'est ce que K7PL doit écrire s'il exclut les continuations, et le motif est meilleur que celui qu'il aurait invoqué.

### vanderrestHeftyAlgebrasModular2025

    AUTHORS: van der Rest et Bach | DATE: 2025 | TITLE: Hefty algebras: modular elaboration of higher-order effects | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796825000024 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c2 : l'élaboration modulaire, et ce que les opérations d'ordre supérieur brisent | SYNTHESE: t

#### \[DONE\] Ce que le document perd sans le dire, et ce que la source lui rend

Le chapitre 1 reconnaît que les traits dépendant d'une portée délimitée ou d'une ressource allouée dynamiquement — ce que la couche 2 fait constamment — sortent du cadre des effets algébriques. Il ne dit pas ce que cette sortie COÛTE. La source le dit : c'est la modularité elle-même, et elle se perd sur les programmes ET sur les preuves. Un raffinement d'implantation cesse d'être transparent.

#### \[DONE\] Le prix du remède est nommé, et il est syntaxique

La solution est une SURCHARGE, donc un dispositif de résolution de nom, non une construction sémantique de plus. Pour un langage dont l'arc G recense dix espaces de noms et dont la doctrine veut que le langage sépare lui-même, c'est un prix à examiner avant d'être payé.

### fluetMonadicRegions2006

    AUTHORS: Fluet et Morrisett | DATE: 2006 | TITLE: Monadic regions | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796806005944 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c4 : régions et arènes ne sont pas la même chose, et la discipline de portée coûte moins qu'on ne croit | SYNTHESE: t

#### \[DONE\] Ce n'est ni une alternative ni la même chose, et la distinction est nette

Une ARÈNE est une DISPOSITION — un bloc contigu, des composants rangés par famille, des références qui sont des décalages. Une RÉGION est une DISCIPLINE DE PORTÉE — quand une allocation cesse d'être atteignable. Le document a besoin des deux et n'a nommé que la première.

#### \[DONE\] Ce qui transporte, et c'est une économie

La discipline de portée ne demande pas un système de types et d'effets dédié : le polymorphisme paramétrique suffit, et la traduction qui l'établit préserve les types ET le sens. Pour K7PL, dont le noyau porte déjà de la quantification, la portée d'arène serait donc une application du polymorphisme existant plutôt qu'un appareil de plus. À instruire avant d'écrire quoi que ce soit sur la portée des arènes.

### oconnorCogentUniquenessTypes2021

    AUTHORS: O'Connor, Chen, Rizkallah, Amani, Lim, Murray, Nagashima, Sewell et Keller | DATE: 2021 | TITLE: Cogent: uniqueness types and certifying compilation | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S095679682100023X | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c6 : DEUX sémantiques pour un langage, reliées par un théorème de raffinement que le compilateur PRODUIT | SYNTHESE: t

#### \[DONE\] DEUX sémantiques pour un langage, et un théorème qui les relie

La première est IMPÉRATIVE, propre à engendrer du C efficace. La seconde est PUREMENT FONCTIONNELLE, offrant une interface commode au raisonnement équationnel et à la vérification des propriétés de plus haut niveau. Un THÉORÈME DE RAFFINEMENT les relie, et il permet au COMPILATEUR DE PRODUIRE UNE PREUVE. C'est un précédent d'architecture pour un document qui a trois couches et qui adosse aujourd'hui sa confiance à un oracle de test différentiel. Un raffinement démontré vaut mieux qu'un témoin exécuté, et la forme existe.

#### \[DONE\] Le coût de la discipline, et la formule que la question citait

Le cadre existe précisément parce que la preuve de correction de composants de bas niveau coûte cher, et il vise à réduire ce coût. La discipline d'unicité y est le moyen : elle supprime le support d'exécution de confiance, donc une part entière de ce qu'il faudrait vérifier. C'est la lecture à retenir pour K7PL : la discipline ne s'ajoute pas au coût de vérification, elle en retire une part.

### appelShrinkingLambdaExpressions1997

    AUTHORS: Appel et Jim | DATE: 1997 | TITLE: Shrinking lambda expressions in linear time | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796897002839 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : la borne de l'intégration, et le fait que le GRADE la décide gratuitement | SYNTHESE: t

#### \[DONE\] La borne ne s'obtient pas par un BUDGET mais par une RESTRICTION DE LA RÈGLE

Le chapitre 6 pose que l'intégration fait exception à la décroissance, ne retirant une indirection qu'en dupliquant un corps, et que sa terminaison exige donc d'être BUDGÉTÉE. La source montre que le budget est inutile sur le fragment qui compte : si l'on n'intègre que les fonctions appelées UNE SEULE FOIS, la mesure décroît par construction, et l'ensemble est confluent en temps linéaire.

#### \[DONE\] ET LE GRADE DÉCIDE CETTE RESTRICTION GRATUITEMENT

« Appelée une seule fois » est exactement ce que la composante d'usage du grade déclare. Là où un compilateur ordinaire a besoin d'une analyse pour identifier les fonctions à appel unique, le jugement gradué le PORTE. La restriction d'Appel et Jim est donc lisible sur le type de K7PL, sans analyse. Le budget que le chapitre 6 prescrit ne serait nécessaire que pour l'intégration des fonctions employées plusieurs fois — c'est-à-dire hors du fragment que le grade nomme.

#### \[DONE\] La confluence, et ce qu'elle dispense de décider

Le choix de l'algorithme de normalisation n'affecte pas la qualité du code final. Un compilateur n'a donc pas à justifier son ORDRE d'intégration sur ce fragment, ce qui retire une obligation au chapitre 6.

### sarkarEDUCATIONALPEARLNanopass2005

    AUTHORS: Sarkar, Waddell et Dybvig | DATE: 2005 | TITLE: A nanopass framework for compiler education | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796804005733 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : le précédent du découpage, et ce qu'il dit du rapport entre organisation logique et implantation | SYNTHESE: t

#### \[DONE\] Le précédent existe et il ne contredit PAS les huit phases, il en dit la nature

Les huit phases du chapitre 6 ne sont pas des passes d'implantation : ce sont des ORDRES DE VÉRIFICATION, chacun supposant le précédent acquis, dans un ordre que rien ne permet d'inverser. C'est l'organisation LOGIQUE. La source dit précisément que l'implantation doit s'ALIGNER sur cette organisation, en étant beaucoup plus fine qu'elle. Huit phases logiques et beaucoup plus de passes d'implantation ne sont donc pas en tension : c'est la configuration que la source recommande.

#### \[DONE\] Et cela rejoint l'objectif de compositionnalité trouvé plus tôt dans l'arc

Chaque passe n'accomplissant qu'une tâche, elle se vérifie isolément — ce qui est exactement l'objectif que Patterson et Ahmed posent pour la correction d'un compilateur, et que le document ne revendique pas. Deux sources indépendantes recommandent donc la même chose pour deux raisons différentes : l'une pour la maintenabilité, l'autre pour la vérifiabilité.

### wattWasmRefisabelleVerifiedMonadic2023

    AUTHORS: Watt et al. | DATE: 2023 | TITLE: WasmRef-Isabelle: a verified monadic interpreter and industrial fuzzing oracle for WebAssembly | REVUE: PACMPL PLDI | IDENTIFIANT: 10.1145/3591224 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : l'ORACLE du document est une hypothèse de confiance ; ici il est démontré, et le coût est chiffré | SYNTHESE: t

#### \[DONE\] L'engagement du chapitre 6 est tenable, il a été tenu ailleurs, et son prix est connu

Le chapitre reconnaît que son interprète de référence est SUPPOSÉ sémantiquement correct par construction, sans qu'aucune preuve ne relie son comportement à la sémantique catégorique, et nomme cela une hypothèse de confiance. La source montre le même objet — un interprète de référence servant d'oracle à un testeur différentiel — mais VÉRIFIÉ, et adopté en production à ce titre. L'écart entre l'hypothèse et la preuve est donc chiffré : environ cinq mille cinq cents lignes.

#### \[DONE\] Le dispositif est MONADIQUE, ce qui n'est pas un détail

Un interprète monadique sépare la structure du calcul de l'effet qu'il produit. Pour un document dont le noyau est un calcul par poussée de valeur et dont les effets sont algébriques, c'est la forme la plus proche de sa propre sémantique — donc celle où la preuve reliant l'interprète à la sémantique catégorique serait la plus courte.

### brandonBetterDefunctionalizationLambda2023

    AUTHORS: Brandon et al. | DATE: 2023 | TITLE: Better defunctionalization through lambda set specialization | REVUE: PACMPL PLDI | IDENTIFIANT: 10.1145/3591260 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c6 : la transparence de la défonctionnalisation vaut de la transformation, non de son RÉSULTAT | SYNTHESE: t

#### \[DONE\] La transparence sémantique ne dit rien de la QUALITÉ, et le chapitre les confond

Le chapitre 6 tient la défonctionnalisation pour sémantiquement transparente par construction, étant un isomorphisme naturel. C'est vrai de la TRANSFORMATION. Mais la source montre que le résultat dépend d'un choix qui n'est pas déterminé par l'isomorphisme : l'UNITÉ DE SPÉCIALISATION. Selon qu'on spécialise par définition de plus haut niveau ou autrement, la même transformation rend un code de premier ordre différent, plus ou moins gros et plus ou moins rapide. La transparence est donc acquise et la qualité ne l'est pas ; ce sont deux énoncés et le chapitre n'en fait qu'un.

### brodalOptimalPurelyFunctional1996

    AUTHORS: Brodal et Okasaki | DATE: 1996 | TITLE: Optimal purely functional priority queues | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S095679680000201X | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: c1, c4 : le critère de compatibilité avec P3 est le PIRE CAS, et l'optimum existe | SYNTHESE: t

#### \[DONE\] Le critère de compatibilité avec le postulat est le PIRE CAS, non l'amorti

C'est le point qui décide et il ne figure nulle part au document. Une borne AMORTIE dissimule un coût dans la distribution : une opération peut coûter cher pourvu que la moyenne tienne. Une borne PIRE CAS ne dissimule rien. Le postulat d'autonomie physique interdit de dissimuler un coût. La bibliothèque de K7PL doit donc retenir les structures à bornes pire cas et écarter celles dont les bonnes bornes sont amorties — ce qui exclut une part notable des structures purement fonctionnelles usuelles, dont plusieurs des plus élégantes.

#### \[DONE\] Et l'optimum existe, ce qui rend le critère praticable

Pour la file de priorité, la borne pire cas optimale est atteinte et purement fonctionnelle. Le critère n'oblige donc pas à renoncer à la structure, seulement à en choisir la bonne réalisation. Le troisième pas de la construction mérite d'être noté pour l'architecture : autoriser une file à en CONTENIR d'autres, ce qui est un emboîtement structurel qui ne coûte rien asymptotiquement.

### choudhuryDependentDependencyCalculus2022

    AUTHORS: Choudhury et al. | DATE: 2022 | TITLE: A dependent dependency calculus | REVUE: Programming Languages and Systems | IDENTIFIANT: arXiv:2201.11040 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SEGMENT: SEG-choudhuryDependentDependencyCalculus2022 | DOSSIER: ref/Q1-Composition-des-modalités.pdf | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### chuHandlingExceptionsEffects

    AUTHORS: Chu et al. | DATE: 2026 | TITLE: Handling exceptions and effects with automatic resource analysis | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3798207 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### coblenzGarbageCollectionMakes2022

    AUTHORS: Coblenz et al. | DATE: 2022 | TITLE: Garbage collection makes rust easier to use a randomized controlled trial of the bronze garbage col | REVUE: Proceedings of the 44th International Conference on Software Engineering | IDENTIFIANT: 10.1145/3510003.3510107 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

coût mesuré de la propriété sans ramasse-miettes ; chapitres 3 et 4 ; question 49

### colcombetAutomataCategoryGlued2017b

    AUTHORS: Colcombet et Petrişan | DATE: 2017 | TITLE: Automata in the category of glued vector spaces | REVUE: LIPIcs, Volume 83, MFCS 2017 | IDENTIFIANT: 10.4230/LIPICS.MFCS.2017.52 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

minimisation par construction ; le RECOLLEMENT comme forme des trois couches ; chapitre 4

### colcombetAutomataMinimizationFunctorial2020

    AUTHORS: Colcombet et Petrişan | DATE: 2020 | TITLE: Automata minimization a functorial approach | REVUE: Logical Methods in Computer Science | IDENTIFIANT: 10.23638/LMCS-16(1:32)2020 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie et DÉPOUILLÉE le 9 août — la source qu'Iwaniack étend. Un automate est un FONCTEUR ; ce qui varie d'une échelle à l'autre est la catégorie de SORTIE. Minimisation par extensions de Kan et système de factorisation ; déterminisation par relèvement de l'adjonction de Kleisli. C'est la réponse à la question 1 et elle en change l'objet.

### colcombetLearningAutomataTransducers2021

    AUTHORS: Colcombet et al. | DATE: 2021 | TITLE: Learning automata and transducers a categorical approach | REVUE: LIPIcs, Volume 183, CSL 2021 | IDENTIFIANT: 10.4230/LIPICS.CSL.2021.15 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

la noethérianité comme seule condition ajoutée ; chapitre 4

### dagitUsingCognitiveDimensions2006

    AUTHORS: Dagit et al. | DATE: 2006 | TITLE: Using cognitive dimensions advice from the trenches | REVUE: Journal of Visual Languages &amp; Computing | IDENTIFIANT: 10.1016/j.jvlc.2006.04.006 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — numéro spécial du Journal of Visual Languages and Computing 17 (2006) sur les dimensions cognitives, fourni à la place de « Ten Years of Cognitive Dimensions » qui en est l'avant-propos et n'a pu être isolé. REÇUE, NON ENCORE DÉPOUILLÉE.

### danvyIntensionsExtensionsReflective1988

    AUTHORS: Danvy et Malmkjaer | DATE: 1988 | TITLE: Intensions and extensions in a reflective tower | REVUE: Proceedings of the 1988 ACM conference on LISP and functional programming | IDENTIFIANT: 10.1145/62678.62725 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

la tour formalisée ; partir de la sémantique et dériver l'implantation

### deamorimReallyNaturalLinear2014

    AUTHORS: De Amorim et al. | DATE: 2014 | TITLE: Really natural linear indexed type checking | REVUE: Proceedings of the 26nd 2014 International Symposium on Implementation and Application of Functional Languages | IDENTIFIANT: 10.1145/2746325.2746335 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le prix des indices dépendants, et pourquoi ce document ne le paie pas

Les systèmes de types linéaires INDEXÉS combinent le linéaire avec un langage d'indices au niveau des types, ce qui permet des analyses plus fines — complexité implicite, confidentialité différentielle. Faire dépendre les indices des valeurs est l'extension naturelle, et la source en donne le prix. Le document lui doit deux choses, et les deux sont des BORNES. La première : le typage des types linéaires indexés se réduit à une théorie du premier ordre INDÉCIDABLE, traitable seulement en pratique — ce qui explique pourquoi le fragment de contraintes du chapitre 3 exclut la quantification. La seconde : le compromis usuel des systèmes gradués consiste à retenir l'usage MAXIMAL d'une branche plutôt que de raisonner sur la valeur qui décide du chemin, approximation délibérée que le document adopte et doit assumer.

### deamorimSeparatedSharedEffects2023

    AUTHORS: de Amorim et Hsu | DATE: 2023 | TITLE: Separated and shared effects in higher-order languages | REVUE: Separated and shared effects in higher-order languages | IDENTIFIANT: 10.48550/ARXIV.2303.01616 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### demuijnck-hughesWiringCircuitsEasy2023

    AUTHORS | DATE: 2023 | TITLE: LIPIcs.ECOOP.2023.8 | REVUE: LIPIcs, Volume 263, ECOOP 2023 | IDENTIFIANT: 10.4230/LIPICS.ECOOP.2023.8 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### dennyDesigningProgrammingError2021

    AUTHORS: Denny et al. | DATE: 2021 | TITLE: On designing programming error messages for novices readability and its constituent factors | REVUE: Proceedings of the 2021 CHI Conference on Human Factors in Computing Systems | IDENTIFIANT: 10.1145/3411764.3445696 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — les quatre articles de Becker, Denny et Prather sur les messages d'erreur, dont je n'avais que les trois noms. Sert la question 30. REÇUE, NON ENCORE DÉPOUILLÉE.

### dilavoreMonoidalStreamsDataflow2022

    AUTHORS | DATE: 2022 | TITLE: Monoidal streams for dataflow programming | REVUE: Monoidal streams for dataflow programming | IDENTIFIANT: 10.1145/3531130.3533365 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### doreDependentMultiplicitiesDependent2025

    AUTHORS: Doré | DATE: 2025 | TITLE: Dependent multiplicities in dependent linear type theory | REVUE: Dependent multiplicities in dependent linear type theory | IDENTIFIANT: 10.1145/3747531 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### downenClassicalCorecursionMechanics2023

    AUTHORS: Downen and Ariola | DATE: 2023 | TITLE: Classical (co)recursion Mechanics | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796822000168 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### edgeCorrelatesCognitiveDimensions2006

    AUTHORS: Edge et Blackwell | DATE: 2006 | TITLE: Correlates of the cognitive dimensions for tangible user interface | REVUE: Journal of Visual Languages &amp; Computing | IDENTIFIANT: 10.1016/j.jvlc.2006.04.005 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — numéro spécial du Journal of Visual Languages and Computing 17 (2006) sur les dimensions cognitives, fourni à la place de « Ten Years of Cognitive Dimensions » qui en est l'avant-propos et n'a pu être isolé. REÇUE, NON ENCORE DÉPOUILLÉE.

### ehrhardIntegrationCones2025

    AUTHORS: Ehrhard et Geoffroy | DATE: 2025 | TITLE: Integration in cones | REVUE: Integration in cones | IDENTIFIANT: https://lmcs.episciences.org/10815 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### ekiciFormalisingAsynchronousSession2026

    AUTHORS | DATE: 2026 | TITLE: Formalising asynchronous session subtyping | REVUE: Formalising asynchronous session subtyping | IDENTIFIANT: 10.1145/3815176 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### falkoffEvolutionAPL1978

    AUTHORS | DATE: 1978 | TITLE: ACM SIGPLAN Notices | REVUE: ACM SIGPLAN Notices | IDENTIFIANT: 10.1145/960118.808372 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

les quatre espèces de la simplicité ; la valence ambiguë comme conséquence du jeu de caractères ; chapitre 5, P-1

### fioreFormalMetatheorySecondorder2022

    AUTHORS: Fiore et Szamozvancev | DATE: 2022 | TITLE: Formal metatheory of second-order abstract syntax | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3498715 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### flattComposableCompilableMacros2002

    AUTHORS: Flatt | DATE: 2002 | TITLE: Composable and compilable macros you want it when | REVUE: Proceedings of the seventh ACM SIGPLAN international conference on Functional programming | IDENTIFIANT: 10.1145/581478.581486 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

la séparation de phases doit être imposée par le langage ; macros de bibliothèque

### fontaineAutomataCoalgebrasApproach2010

    AUTHORS: Fontaine et al. | DATE: 2010 | TITLE: Automata for coalgebras an approach using predicate liftings | REVUE: Automata, languages and programming | IDENTIFIANT: 10.1007/978-3-642-14162-1_32 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### fournetReflexiveCHAMJoincalculus1996

    AUTHORS: Fournet et Gonthier | DATE: 1996 | TITLE: The reflexive CHAM and the join-calculus | REVUE: The reflexive CHAM and the join-calculus | IDENTIFIANT: 10.1145/237721.237805 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le document emprunte DEUX résultats et les présente comme un

Le premier est l'équi-expressivité : le join-calcul et le pi-calcul ont le même pouvoir expressif, à congruence barbelée faible près, résultat obtenu en exhibant des encodages PLEINEMENT ABSTRAITS dans les deux directions. Le second est la théorie équationnelle du join-calcul lui-même, dont le document a besoin pour son énoncé de fidélité. Les deux sont dans la source ; ce sont deux résultats et le document les cite comme un.

#### \[DONE\] Une nuance de statut à ne pas perdre

Les auteurs écrivent qu'on peut S'ATTENDRE à ce que l'essentiel de la métathéorie du pi-calcul se transporte directement au join-calcul. C'est une attente, non un théorème. Si K7PL s'appuie sur un résultat du pi-calcul transporté à son métalangage, ce transport n'est pas couvert par la source, et il faut ou bien le conduire ou bien ne pas s'y appuyer.

#### \[DONE\] La localité est bien l'une des deux modifications, et le document a raison sur ce point

Le modèle s'obtient en ajoutant la réflexion à la machine chimique, et il est présenté comme consistant avec la mobilité et la distribution. Le renversement que le chapitre 4 opère — la localité n'est pas imposée à un modèle qui pourrait s'en passer, elle est ce qui le rend distribuable — est fidèle à la source.

### fuDependentlyTypedFolds2018

    AUTHORS: Fu et Selinger | DATE: 2018 | TITLE: Dependently typed folds for nested data types | REVUE: Dependently typed folds for nested data types | IDENTIFIANT: 10.48550/ARXIV.1806.05230 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### fuInductionPrincipleNested2023

    AUTHORS: Fu et Selinger | DATE: 2023 | TITLE: Towards an induction principle for nested data types | REVUE: Logic, language, information, and computation | IDENTIFIANT: 10.1007/978-3-031-39784-4_15 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: t

#### \[TODO\] Ce que la référence rend

Fu et Selinger, « Towards an Induction Principle for Nested Data Types » — oeuvre distincte de fuDependentlyTypedFolds2018, ajoutee dans Zotero et pas encore citee.

### fukiharaGeneralizedBoundedLinear2021

    AUTHORS: Fukihara et Katsumata | DATE: 2021 | TITLE: Generalized bounded linear logic and its categorical semantics | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-030-71995-1_12 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La complexité se porte PAR LE GRADE, et sans restreindre l'échange

La logique linéaire bornée gradue la modalité exponentielle, et sa généralisation adopte pour cela un PSEUDO-SEMI-ANNEAU MULTI-OBJETS comme système de gradation. Les auteurs en analysent la complexité de l'ÉLIMINATION DES COUPURES, et le point est là : la complexité est fonction de la gradation. C'est la seconde branche de la caractérisation par discipline, et c'est celle de K7PL. La première, celle des automates implicites, exige la non-commutativité ; celle-ci n'exige rien de tel, la gradation de l'exponentielle suffisant à porter la borne.

#### \[DONE\] Une convergence à trois qu'il faut nommer

La structure catégorique qui interprète la modalité y est une COMONADE EXPONENTIELLE LINÉAIRE INDEXÉE. Trois lieux indépendants arrivent donc à la même forme : les monades graduées INDEXÉES pour les effets dépendant des valeurs, les comonades exponentielles linéaires INDEXÉES pour la gradation bornée, et la gradation indexée que l'annexe G a introduite sur son propre diagnostic. Le document a la structure aux trois endroits et ne dit pas que c'est la même. C'est un acquis d'unité, pas une coïncidence.

#### \[DONE\] Le pseudo-semi-anneau multi-objets, et l'écho avec l'arc B

Le système de gradation y est multi-objets, c'est-à-dire que les grades ne viennent pas tous de la même algèbre. C'est le trait que Grass porte aussi, où des grades d'algèbres différentes coexistent sur des variables différentes. Deux traditions distinctes — la logique linéaire bornée et la logique graduée sous-structurelle — y arrivent séparément. Le grade à quatre composantes de K7PL, produit d'une seule algèbre, est le cas particulier des deux.

### gabbayNewApproachAbstract2002

    AUTHORS: Gabbay et Pitts | DATE: 2002 | TITLE: A new approach to abstract syntax with variable binding | REVUE: Formal Aspects of Computing | IDENTIFIANT: 10.1007/s001650200016 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie et dépouillée le 9 août — la SOURCE de la chaîne nominale, dont Kurz et al. et Bojańczyk et al. partent tous deux. Donne la fraîcheur a \# x, le quantificateur N, l'abstraction d'atome, et le fait que les classes d'alpha-équivalence sont un ensemble INDUCTIF et non un quotient. C'est la forme que thm:hygiene devrait prendre. À citer quand l'hygiène sera réécrite.

### gaboardiWhatModelSemantically2014

    AUTHORS | DATE: 2014 | TITLE: What is a model for a semantically linear -calculus? | REVUE: What is a model for a semantically linear -calculus? | IDENTIFIANT: 10.1093/logcom/exs023 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### ghicaBoundedLinearTypes2014

    AUTHORS: Ghica et Smith | DATE: 2014 | TITLE: Bounded linear types in a resource semiring | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-642-54833-8_18 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### gibsonEcologicalApproachVisual2015

    AUTHORS: Gibson | DATE: 2015 | TITLE: The ecological approach to visual perception classic edition | REVUE: Psychology Press classic editions | IDENTIFIANT: ISBN 978-1-84872-578-2 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

l'affordance de première main ; la MÉSINFORMATION comme troisième mode de défaillance ; P-4

### gordonPolymorphicIterableSequential2021

    AUTHORS: Gordon | DATE: 2021 | TITLE: Polymorphic iterable sequential effect systems | REVUE: Polymorphic iterable sequential effect systems | IDENTIFIANT: arXiv:1808.02010 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### gouniSecurityReasoningSubstructural2026

    AUTHORS | DATE: 2026 | TITLE: Proc. ACM Program. Lang. | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3776669 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### greenUsabilityAnalysisVisual1996

    AUTHORS: Green et Petre | DATE: 1996 | TITLE: Usability analysis of visual programming environments a ‘cognitive dimensions’ framework | REVUE: Journal of Visual Languages &amp; Computing | IDENTIFIANT: 10.1006/jvlc.1996.0009 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

cadre des dimensions cognitives, lu de première main ; chapitre 5 et T-61

### grodinAbstractionFunctionsTypes

    AUTHORS: Grodin et al. | DATE: 2026 | TITLE: Abstraction functions as types modular verification of cost and behavior in dependent type theory | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3776673 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### hadhrawiSystematicLiteratureReview

    AUTHORS: Hadhrawi et al. | DATE | TITLE: A systematic literature review of cognitive dimensions | REVUE: A systematic literature review of cognitive dimensions | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — numéro spécial du Journal of Visual Languages and Computing 17 (2006) sur les dimensions cognitives, fourni à la place de « Ten Years of Cognitive Dimensions » qui en est l'avant-propos et n'a pu être isolé. REÇUE, NON ENCORE DÉPOUILLÉE.

### haringtonCategoricalModelsLinear2025

    AUTHORS: Harington et Mimram | DATE: 2025 | TITLE: ∞-categorical models of linear logic | REVUE: LIPIcs, Volume 337, FSCD 2025 | IDENTIFIANT: 10.70675/2d5d0b08z0383z441cz828cz3d092fccf5af | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### hasegawaGirardTranslationLogical2000

    AUTHORS: Hasegawa | DATE: 2000 | TITLE: Girard translation and logical predicates | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796899003615 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### heerdtCategoricalFrameworkLearning2022

    AUTHORS: Heerdt et al. | DATE: 2022 | TITLE: A categorical framework for learning generalised tree automata | REVUE: A categorical framework for learning generalised tree automata | IDENTIFIANT: 10.1007/978-3-031-10736-8_4 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### heerdtTreeAutomataAlgebras2019

    AUTHORS: Heerdt et al. | DATE: 2019 | TITLE: Tree automata as algebras minimisation and determinisation | REVUE: LIPIcs, Volume 139, CALCO 2019 | IDENTIFIANT: 10.4230/LIPIcs.CALCO.2019.6 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Corpus T-65, DÉPOUILLÉE le 9 août : minimalisation générale sous hypothèses modestes, et les effets de bord comme paramètre du cadre avec procédure de déterminisation. Fiche dans chantier/arc-theorique.org.

### herlihyModularSubstructuralConstraints2026

    AUTHORS | DATE: 2026 | TITLE: Proceedings of the 25th ACM SIGPLAN International Conference on Generative Programming: Concepts and Experiences | REVUE: Proceedings of the 25th ACM SIGPLAN International Conference on Generative Programming: Concepts and Experiences | IDENTIFIANT: 10.1145/3814885.3816411 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### herzeelReflectionMasses2008

    AUTHORS: Herzeel et al. | DATE: 2008 | TITLE: Reflection for the masses | REVUE: Self-sustaining systems | IDENTIFIANT: 10.1007/978-3-540-89275-5_6 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

l'absorption ; la coupe réflexion structurelle / procédurale ; chapitre 5, B6

### heuvelComparingSessionType2024

    AUTHORS: Heuvel et Pérez | DATE: 2024 | TITLE: Comparing session type systems derived from linear logic | REVUE: Comparing session type systems derived from linear logic | IDENTIFIANT: 10.48550/ARXIV.2401.14763 | REF.BIB: nil | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Doublon Zotero à fusionner

Doublon Zotero : meme oeuvre que VAN-DEN-HEUVEL, sous un second DOI. Les deux entrees coexistent depuis la synchronisation. A FUSIONNER DANS ZOTERO, en gardant celle dont le DOI est celui de l'editeur.

#### \[DONE\] La ligne de partage entre les deux présentations est la LOCALITÉ, et le document se tient des deux côtés

Les auteurs construisent un système qui englobe les interprétations classique et intuitionniste de la logique linéaire, et caractérisent les fragments qui coïncident avec chacune. Leur résultat central pour K7PL : la différence entre les deux tient à l'imposition de la LOCALITÉ DES NOMS PARTAGÉS, que l'intuitionniste impose et que la classique n'impose pas. Ils établissent en outre que la classique est STRICTEMENT PLUS EXPRESSIVE, étant plus permissive, et découvrent que l'intuitionniste interdit aussi les envois vides sur des canaux reçus — les deux contraintes découlant de l'exigence que le jugement intuitionniste porte exactement un canal à droite.

#### \[DONE\] UNE INCOHÉRENCE INTERNE que cette lecture met au jour

Le chapitre 4 écrit, au paragraphe sur l'acyclicité, que celle-ci est ce que produit toute composition fondée sur la logique linéaire CLASSIQUE. Il écrit, deux sections plus loin, que le métalangage a pour types les propositions de la logique linéaire INTUITIONNISTE, celles-là mêmes que le chapitre 3 emploie. Et le chapitre 3 invoque la classique pour l'abandon de session. Ce ne sont pas deux façons de dire la même chose. La composition EST la coupure, et la coupure est précisément où les deux présentations diffèrent — un canal à droite, ou plusieurs. Le document revendique par ailleurs la localité comme propriété structurelle. Si le métalangage est intuitionniste, la localité vient du typage mais l'argument d'acyclicité par la classique ne s'applique pas tel quel ; si la composition est classique, la localité ne vient pas du typage et doit venir d'ailleurs — de la machine chimique, ce que le document dit aussi. L'une des deux mentions est à corriger, et la source dit laquelle selon ce que le document veut garder.

### horneSessionSubtypingMultiparty2020

    AUTHORS: Horne | DATE: 2020 | TITLE: Session subtyping and multiparty compatibility using circular sequents | REVUE: International Conference on Concurrency Theory | IDENTIFIANT: 10.4230/LIPIcs.CONCUR.2020.12 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Ce que la source rend, et le document ne le rapporte qu'en partie

Une théorie de la preuve structurelle pour les sessions multipartites, exploitant la logique NON COMMUTATIVE, laquelle capture explicitement l'ordre de séquence des messages. Le sous-typage y est plus souple que le standard : un fil unique peut être remplacé par plusieurs fils parallèles qui remplissent son rôle. Quatre résultats sont établis, tous par élimination des coupures : le système est algorithmique ; les processus multipartites compatibles et SANS COURSE sont sans interblocage ; le sous-typage est correct pour le principe de substitution ; et les types globaux y sont OPTIONNELS.

#### \[DONE\] La condition de remplacement est exactement celle que le document cherche

Le document écrit que ce qui remplacerait l'acyclicité est une condition supplémentaire vérifiable statiquement, et nomme la liberté de course. La source la donne dans son énoncé : compatibilité multipartite plus absence de course donne l'absence d'interblocage. Ce qui manque au document n'est donc pas la condition mais sa forme exacte, et elle est ici.

### hughesProgramSynthesisGraded2024

    AUTHORS: Hughes et Orchard | DATE: 2024 | TITLE: Program synthesis from graded types | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-031-57262-3_4 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu. \* \* \*

D O N E

L e

g r a d e

n e

c o u t e

p a s

a

l a

s y n t h e s e ,

i l

l a

P A Y E

L a

q u e s t i o n

e t a i t

c e l l e

d u

c o u t

r e e l

d u

r e m p l i s s a g e

d e

t r o u s

d i r i g e

p a r

l e s

t y p e s

d a n s

u n

l a n g a g e

g r a d u e .

L a

s o u r c e

r e p o n d

p a r

u n e

e v a l u a t i o n

s u r

q u a r a n t e

- 

s i x

p r o g r a m m e s

d e

r e f e r e n c e ,

d o n t

p l u s i e u r s

f o n c t i o n s

r e c u r s i v e s

s u r

d e s

t y p e s

d e

d o n n e e s

r e c u r s i f s ,

l a

m a j o r i t e

e x i g e n t

M O I N S

d ' e x p l o r a t i o n

q u ' u n e

s y n t h e s e

p u r e m e n t

d i r i g e e

p a r

l e s

t y p e s ,

e t

m o i n s

d ' e x e m p l e s

d ' e n t r e e

- 

s o r t i e .

L e

m o t i f

e s t

s i m p l e

e t

i l

e s t

c e l u i

d e

K 7 P L

l e s

c o n t r a i n t e s

d e

g r a d e

r e d u i s e n t

l e

n o m b r e

d e

p r o g r a m m e s

t y p a b l e s ,

d o n c

l ' e s p a c e

d e

r e c h e r c h e .

U n e

a s s o m p t i o n

d o n t

l e

g r a d e

i n t e r d i t

l ' u s a g e

n ' e s t

m e m e

p a s

c o n s i d e r e e .

L a

t e c h n i q u e

q u i

r e n d

l a

c h o s e

p r a t i c a b l e

e s t

n o m m e e

l a

F O C A L I S A T I O N

d ' A n d r e o l i ,

q u i

f i x e

u n

o r d r e

s u r

l e s

r e g l e s

i n v e r s i b l e s

e t

s u p p r i m e

l e

n o n

- 

d e t e r m i n i s m e

d e s

b r a n c h e s

q u i

n e

d i f f e r e n t

q u e

p a r

c e t

o r d r e .

C ' e s t

c e

q u e

K 7 P L

d e v r a

i m p l a n t e r ,

e t

l ' a r t i c l e

e n

d o n n e

l e s

r e g l e s

f o c a l i s e e s

e t

l e u r

p r e u v e

d e

c o r r e c t i o n .

L a

s o u r c e

t r a i t e

l e

p r o b l e m e

d e

l a

g e s t i o n

d e s

r e s s o u r c e s ,

e t

r e t a r g e t e

l ' a l g o r i t h m e

v e r s

l e s

t y p e s

l i n e a i r e s

d e

G H C

9 .

### hughesResourcefulProgramSynthesis2021

    AUTHORS: Hughes et Orchard | DATE: 2021 | TITLE: Resourceful program synthesis from graded linear types | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-030-68446-4_8 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### huiAPL19782020

    AUTHORS: Hui et Kromberg | DATE: 2020 | TITLE: APL since 1978 | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3386319 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

la section « Names » est la question 2 ; le chiffrage des opérateurs ; chapitre 5, P-2

### ignjatovicDeterminizationFuzzyAutomata2008

    AUTHORS: Ignjatović et al. | DATE: 2008 | TITLE: Determinization of fuzzy automata with membership values in complete residuated lattices | REVUE: Determinization of fuzzy automata with membership values in complete residuated lattices | IDENTIFIANT: https://linkinghub.elsevier.com/retrieve/pii/S0020025507003866 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie et DÉPOUILLÉE le 9 août. Seconde équivalence : la déterminisation donne un automate fini si et seulement si le réduit semi-anneau de l'algèbre de grades est localement fini (théorème 4.2). Et la congruence de Nerode floue. Même échéance que Li et Pedrycz.

### iversonNotationToolThought1980a

    AUTHORS: Iverson | DATE: 1980 | TITLE: Notation as a tool of thought | REVUE: Communications of the ACM | IDENTIFIANT: 10.1145/358896.358899 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

les cinq caractères d'une notation ; l'économie à trois termes ; chapitre 5

### iwaniackAutomatesTopossiques

    AUTHORS: Iwaniack | DATE: 2025 | TITLE: Automates topossiques | REVUE: Automates topossiques | IDENTIFIANT: 10.70675/db751a45zd591z4819za546z64d602ae7d91 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### jacobsSelfDualDistillationSession2022

    AUTHORS: Jacobs | DATE: 2022 | TITLE: A self-dual distillation of session types | REVUE: LIPIcs, Volume 222, ECOOP 2022 | IDENTIFIANT: 10.4230/LIPICS.ECOOP.2022.23 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### johannDeepInductionInduction2020

    AUTHORS: Johann et Polonsky | DATE: 2020 | TITLE: Deep induction induction rules for (truly) nested types | REVUE: LNCS | IDENTIFIANT: 10.1007/978-3-030-45231-5_18 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] L'induction profonde, et ce qu'elle rend obligatoire

Les règles d'induction standard n'induisent que sur la structure de PREMIER NIVEAU d'une donnée, laissant sans traitement les données internes à cette structure. L'induction PROFONDE induit sur toutes les données structurées présentes et se spécialise en les règles standard. Le document lui doit un renversement de statut. Les lemmes qu'il fallait fournir pour raisonner sur des structures imbriquées — une liste dans une carte, les composantes d'un CRDT composé — n'étaient pas des commodités : ce sont les PRINCIPES D'INDUCTION PROFONDE du type porteur, et les omettre laisse le raisonnement incomplet. Un troisième emploi la relie au chapitre 3 : le filtrage sur paquet effacé que la canonicité oblige à exclure est très exactement ce que l'induction profonde demanderait.

### kaminskiComplexityExpressivePower2022

    AUTHORS | DATE: 2021 | TITLE: The complexity and expressive power of limit datalog | REVUE: The complexity and expressive power of limit datalog | IDENTIFIANT: 10.1145/3495009 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### kavvosManyWorldsModal2016

    AUTHORS: Kavvos | DATE: 2016 | TITLE: The many worlds of modal λ-calculi I. Curry-howard for necessity, possibility and time | REVUE: The many worlds of modal λ-calculi: I. Curry-howard for necessity, possibility and time | IDENTIFIANT: 10.48550/ARXIV.1605.08106 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### kellisonBeanLanguageBackward2025

    AUTHORS: Kellison et al. | DATE: 2025 | TITLE: Bean a language for backward error analysis | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3729324 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### kellyCoherenceClosedCategories1971

    AUTHORS | DATE: 1971 | TITLE: Journal of Pure and Applied Algebra | REVUE: Journal of Pure and Applied Algebra | IDENTIFIANT: 10.1016/0022-4049(71)90013-2 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### kidneyFormalisingGraphAlgorithms2025

    AUTHORS: Kidney and Wu | DATE: 2025 | TITLE: Formalising Graph Algorithms with Coinduction | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3704892 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Les algorithmes de graphes deviennent des TRANSFORMATIONS, et les poids sont génériques

Un graphe y est une fonction des sommets vers des ensembles PONDÉRÉS non nécessairement finis, et la construction est générique sur une large classe de poids. Les algorithmes sont reformulés comme des transformations de graphes. Deux choses intéressent K7PL. Les poids génériques sont des grades, et la classe des poids admissibles est à comparer à l'algèbre du document. Et la non-finitude des voisinages est ce qui rend le traitement coinductif, donc ce qui répond à la question de la terminaison des parcours : elle ne vient pas d'une décroissance mais d'une productivité.

#### \[DONE\] Ce que cela vaut pour la couche 3

La couche 3 interdit la récursion générale et fait terminer ses plis par un indice décroissant. Un parcours de graphe n'a pas d'indice décroissant, le graphe pouvant être cyclique. La source dit par où sortir : ne pas chercher une terminaison mais une productivité, et traiter le parcours en couche 2 plutôt qu'en couche 3. C'est la lecture de RECOURS de la sédimentation, déjà relevée à l'arc D, appliquée à un cas concret.

### knothLiquidResourceTypes2020

    AUTHORS: Knoth et al. | DATE: 2020 | TITLE: Liquid resource types | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3408988 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### kupkeClosurePropertiesCoalgebra2005

    AUTHORS: Kupke et Venema | DATE: 2005 | TITLE: Closure properties of coalgebra automata | REVUE: 20th Annual IEEE Symposium on Logic in Computer Science (LICS' 05) | IDENTIFIANT: 10.1109/LICS.2005.10 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### kupkeCoalgebraicAutomataTheory2008

    AUTHORS: Kupke et Venema | DATE: 2008 | TITLE: Coalgebraic automata theory basic results | REVUE: Logical Methods in Computer Science | IDENTIFIANT: 10.2168/LMCS-4(4:10)2008 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

#### \[DONE\] La théorie des automates se généralise à un FONCTEUR, sous une hypothèse unique

Les auteurs portent les résultats centraux au niveau des coalgèbres, pour tout foncteur d'ensembles qui préserve les PRODUITS FIBRÉS FAIBLES. Sous cette seule hypothèse, la classe des langages reconnaissables de coalgèbres est close par réunion, intersection et projection ; et un automate non déterministe qui accepte une coalgèbre en accepte une finie de la taille de l'automate. Le résultat technique principal transforme un automate ALTERNANT en un non déterministe équivalent, de taille bornée exponentiellement.

#### \[DONE\] Cela REFORMULE le manque consigné sur le troisième étage, et l'améliore

Le manque était énoncé ainsi : le corpus ne donne pas de compte rendu catégorique de l'automate à pile. La lecture le corrige. Au niveau coalgébrique, la hiérarchie n'est pas déterministe, non déterministe, à pile — elle est déterministe, non déterministe, alternant, INDEXÉE PAR LE CHOIX DU FONCTEUR, lequel décide sur quoi l'automate opère : mots, arbres, arbres de branchement non borné, systèmes de transitions étiquetés. La question n'est donc plus s'il existe un compte rendu, mais QUEL FONCTEUR donne l'étage à pile et s'il préserve les produits fibrés faibles. C'est une question précise, à la portée d'un dépouillage, là où le manque était formulé comme une absence.

### kupkeCoalgebraicSemanticsModal2011

    AUTHORS: Kupke et Pattinson | DATE: 2011 | TITLE: Coalgebraic semantics of modal logics an overview | REVUE: Theoretical Computer Science | IDENTIFIANT: 10.1016/j.tcs.2011.04.023 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### kurzAlphacorecursionPrincipleInfinitary2012

    AUTHORS: Kurz et al. | DATE: 2012 | TITLE: An alpha-corecursion principle for the infinitary lambda calculus | REVUE: Coalgebraic methods in computer science | IDENTIFIANT: 10.1007/978-3-642-32784-1_8 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### kurzApproximationNestedFixpoints2015

    AUTHORS: Kurz et al. | DATE: 2015 | TITLE: Approximation of nested fixpoints - a coalgebraic view of parametric dataypes | REVUE: Conference on Algebra and Coalgebra in Computer Science | IDENTIFIANT: 10.4230/LIPIcs.CALCO.2015.205 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### liFuzzyFiniteAutomata2005

    AUTHORS: Li et Pedrycz | DATE: 2005 | TITLE: Fuzzy finite automata and fuzzy regular expressions with membership values in lattice-ordered monoid | REVUE: Fuzzy finite automata and fuzzy regular expressions with membership values in lattice-ordered monoids | IDENTIFIANT: https://linkinghub.elsevier.com/retrieve/pii/S0165011405001600 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie et DÉPOUILLÉE le 9 août. Donne la réponse à la question 3 de T-65 sous forme d'ÉQUIVALENCE : la fonction de transition s'étend aux mots si et seulement si la composition des grades distribue sur les bornes de l'ordre (théorème 3.1). Plus le théorème de Kleene au-dessus d'un monoïde ordonné par treillis. À citer au corps quand la question 3 sera écrite.

#### \[DONE\] Le théorème 3.1, dans sa forme exacte, et l'échelle qu'il ouvre

Trois conditions équivalentes. La première est que la structure des valeurs soit un MONOÏDE ORDONNÉ PAR TREILLIS, c'est-à-dire que la multiplication distribue sur les bornes supérieures FINIES. La deuxième et la troisième sont deux formes de l'extension de la fonction de transition aux mots. La source donne l'échelle complète, et elle vaut d'être connue : monoïde partiellement ordonné, puis monoïde ordonné par treillis pour la distributivité finie, puis QUANTALE pour la distributivité infinie, avec un étage intermédiaire dénombrable. L'annexe G travaille déjà sur des quantales ordonnées. Elle a donc plus qu'il n'en faut pour l'extension aux mots, et la source dit exactement quelle part de cette force y sert. C'est un acquis à revendiquer, pas une lacune.

### licataFibrationalFrameworkSubstructural2017

    AUTHORS: Licata et al. | DATE: 2017 | TITLE: A fibrational framework for substructural and modal logics | REVUE: International Conference on Formal Structures for Computation and Deduction | IDENTIFIANT: 10.4230/LIPIcs.FSCD.2017.25 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### liuConsistencyDependentCalculus2025

    AUTHORS: Liu et al. | DATE: 2025 | TITLE: Consistency of a dependent calculus of indistinguishability | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3704843 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### loregianAutomataCoalgebrasCategories2024

    AUTHORS: Loregian | DATE: 2024 | TITLE: Automata and coalgebras in categories of species | REVUE: Coalgebraic methods in computer science | IDENTIFIANT: 10.1007/978-3-031-66438-0_4 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

#### \[DONE\] Les automates généralisés d'Adámek et Trnková, et le foncteur DÉRIVÉE

L'auteur étudie les automates généralisés dans la catégorie des espèces de Joyal, et d'abord les coalgèbres du foncteur DÉRIVÉE et de l'opérateur d'homogénéité d'Euler qui naît de l'adjonction correspondante. La théorie donne des exemples non triviaux de 2-anneaux différentiels. Deux choses en sortent. La première est l'identification de la pièce fondatrice du corpus : les automates généralisés sont ceux d'Adámek et Trnková, dont la monographie est au fonds et non lue. La seconde est un fil qui relie trois lectures de cet arc : la DÉRIVÉE est ici un endofoncteur dont on prend les coalgèbres, et c'est le même dispositif que l'analyse par dérivée des grammaires à pile visible. Le pont entre le versant catégorique et le versant syntaxique de l'arc passe par là, et rien au document ne le note.

### lorenzenOxidizingOCamlModal2024

    AUTHORS: Lorenzen et al. | DATE: 2024 | TITLE: Oxidizing OCaml with Modal Memory Management | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3674642 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### loukanovaSemanticInformationType2012

    AUTHORS: Loukanova | DATE: 2012 | TITLE: Semantic information with type theory of acyclic recursion | REVUE: Active media technology | IDENTIFIANT: 10.1007/978-3-642-35236-2_39 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Fournie le 9 août et DÉPOUILLÉE — fiche dans chantier/arc-theorique.org. Elle donne à B6 la notion de ce qu'une macro PRÉSERVE (synonymie référentielle) et la condition qui l'achète (fonction de rang). Sera citée au corps quand B6 recevra sa sémantique ; maintenue d'ici là.

### mannucciResourceBoundedTypeTheory2025

    AUTHORS: Mannucci et Thuro | DATE: 2025 | TITLE: Resource-bounded type theory compositional cost analysis via graded modalities | REVUE: Resource-bounded type theory: compositional cost analysis via graded modalities | IDENTIFIANT: arXiv:2512.06952 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Une TROISIÈME source pour le théorème manquant, et c'est la plus proche de la forme de K7PL

Les termes y sont typés avec des bornes SYNTHÉTISÉES, tirées d'un treillis de ressources abstrait muni de son ordre, de sa composition, de sa jointure et de son plus petit élément, ce qui donne un traitement uniforme du temps, de la mémoire, du gaz et des coûts propres à un domaine. Une modalité de faisabilité GRADUÉE y est introduite, avec ses lois de counité et de monotonie. Et le résultat principal est un théorème de CORRECTION DE COÛT : si un terme clos a une borne synthétisée sous un BUDGET, son coût opérationnel est borné par cette borne. Le grade de K7PL porte une composante de budget. Des trois sources qui portent maintenant le théorème manquant, celle-ci est la seule dont l'énoncé emploie le même mot pour la même chose.

#### \[DONE\] La limite de la source, et elle est nette

Le théorème vaut pour le FRAGMENT SIMPLEMENT TYPÉ SANS RÉCURSION. K7PL a la récursion et la dépendance. Ce n'est donc pas un résultat à transporter mais une FORME à suivre, et c'est déjà beaucoup : le modèle syntaxique est donné dans un topos de préfaisceaux indexé par les bornes, l'extraction du coût y est une transformation naturelle, les formes canoniques s'obtiennent par réification, et le modèle syntaxique est initial parmi les modèles bornés en ressources.

#### \[DONE\] Ce que cela ajoute au programme d'ajustement

Le bloc A.3.6 portait deux sources, l'une comptant les accès au tas, l'autre instrumentant une sémantique à tas. Celle-ci en donne une troisième, sur le versant COÛT plutôt que USAGE, avec un treillis de ressources là où les deux autres ont un semi-anneau. Les trois disent la même chose sous trois formes : le grade doit être relié à une grandeur observable. Le document ne le fait nulle part.

### marshallGradedModalTypes2023

    AUTHORS: Marshall et Orchard | DATE: 2023 | TITLE: Graded modal types for integrity and confidentiality | REVUE: Graded modal types for integrity and confidentiality | IDENTIFIANT: 10.48550/ARXIV.2309.04324 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Confidentialité et intégrité, et pourquoi l'une manque au document

Un système gradué suit diverses propriétés du comportement d'un programme en annotant les types. Le cas d'école est le flot d'information, où les types sont gradués par un treillis de niveaux de sécurité ; mais la littérature n'y traite qu'un aspect, la CONFIDENTIALITÉ. L'INTÉGRITÉ — une sortie de confiance ne doit pas dépendre d'une entrée non fiable — est l'omission que la source répare, en montrant qu'inverser l'ordre du treillis ne suffit pas à la traiter. Le document lui doit sa distinction la plus utile sur cet axe : la confidentialité contraint ce qu'un programme peut LIRE et vit du côté du contexte, où les coeffets se posent ; l'intégrité contraint ce qu'il peut ÉCRIRE et vit du côté des effets. Le mécanisme est le même, seule change la structure ordonnée. Et elle rend une LACUNE visible : une entrée non vérifiée, un import dont l'origine n'est pas attestée produisent des valeurs de basse intégrité, que rien ne distingue aujourd'hui des autres.

### matacheScopedEffectsScoped2025

    AUTHORS: Matache et al. | DATE: 2025 | TITLE: Scoped effects, scoped operations, and parameterized algebraic theories | REVUE: ACM Transactions on Programming Languages and Systems | IDENTIFIANT: 10.1145/3731678 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Les opérations à portée, et la forme exacte de leur définition

Les effets algébriques caractérisent les monades par des opérations et des axiomes équationnels, mais de nombreux traits de programmation utiles n'y entrent pas. Les opérations À PORTÉE sont de ceux-là, et la source en donne la théorie par traduction dans des théories algébriques PARAMÉTRÉES, mêlant opérations à portée et opérations algébriques. Le document lui doit la définition qu'il emploie, et il vaut de la citer sous sa forme exacte : une opération à portée sur une monade, d'arité donnée, est une famille de fonctions naturelle en son paramètre, allant de la puissance de la monade vers la monade. C'est la pièce qui justifie que le gestionnaire du noyau ne soit PAS un effet algébrique ordinaire, ce que le chapitre 3 signalait sans en avoir la théorie.

### matthesRecursionNestedDatatypes2008

    AUTHORS | DATE: 2008 | TITLE: Logic and Theory of Algorithms | REVUE: Logic and Theory of Algorithms | IDENTIFIANT: 10.1007/978-3-540-69407-6_47 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### melesNewProgrammingStyles2026

    AUTHORS: Mélès | DATE: 2026 | TITLE: New programming styles suggested by human languages | REVUE: New programming styles suggested by human languages | IDENTIFIANT: https://www.mdpi.com/2409-9287/11/2/55 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

les quatre niveaux de dérivation d'une langue ; question 41

### melliesFunctorsAreType2015

    AUTHORS: Melliès et Zeilberger | DATE: 2015 | TITLE: Functors are type refinement systems | REVUE: ACM SIGPLAN Notices | IDENTIFIANT: 10.1145/2775051.2676970 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Un systeme de raffinement EST un foncteur, et rien d'autre n'est exige

La definition est litterale : un systeme de raffinement est un foncteur U : D -\> T. Il n'y a pas de condition supplementaire a verifier, et la question posee au chapitre 3 tombe : le foncteur d'effacement de K7PL est un systeme de raffinement par le seul fait d'etre un foncteur. Ce qui reste a decider est autre chose : le foncteur est-il une FIBRATION. La source donne le critere, et il est exact : U est une fibration si et seulement si, pour tout morphisme f et tout raffinement T de son but, il existe un tire-en-arriere de T le long de f. C'est cette propriete-la, et non la qualite de systeme de raffinement, qui donnerait a K7PL l'INFERENCE des raffinements : le meilleur raffinement d'un terme efface. Le document en a besoin et ne le demande pas.

#### \[DONE\] Le sous-typage est un cas du typage, et cela range les regles interstitielles

La source pose que les deux jugements, celui du sous-typage et celui du typage par l'identite, ont exactement le meme sens. Le sous-typage n'est donc pas une couche posee sur le typage, il en est le fragment VERTICAL. Les regles interstitielles de K7PL, sous-typage modal et sous-gradation, sont ainsi des morphismes verticaux, et la question de leur commutation avec les introductions cesse d'etre une verification cas par cas. Elle devient la condition qui definit un systeme de raffinement MONOIDAL : deux carres commutatifs, l'un pour le produit tensoriel, l'autre pour l'unite, que la source ecrit. K7PL doit donc verifier deux carres, et non trente-trois commutations.

### miliusCategorytheoreticSolutionRecursive2006

    AUTHORS: Milius et Moss | DATE: 2006 | TITLE: The category-theoretic solution of recursive program schemes | REVUE: Theoretical Computer Science | IDENTIFIANT: 10.1016/j.tcs.2006.07.002 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### niuCostawareLogicalFramework2022

    AUTHORS: Niu et al. | DATE: 2021 | TITLE: A cost-aware logical framework | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3498670 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### oliveiraWhatChallengesDevelopers2025

    AUTHORS: Oliveira et al. | DATE: 2025 | TITLE: What challenges do developers face when using verification-aware programming languages | REVUE: 2025 IEEE 36th International Symposium on Software Reliability Engineering (ISSRE) | IDENTIFIANT: 10.1109/ISSRE66568.2025.00031 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: t

#### \[TODO\] Synchronisée sans emploi

Entrée synchronisée depuis Zotero sans emploi au corps. À citer ou à retirer lors de la prochaine synchronisation ; aucune décision de fond n'est prise ici.

### oliveiravaleCompositionalTheoryLinearizability2023

    AUTHORS: Oliveira Vale et al. | DATE: 2023 | TITLE: A Compositional Theory of Linearizability | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3571231 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le document cite cette source pour son AVERTISSEMENT et manque qu'elle DÉMONTRE ce qu'il renonce à revendiquer

L'avertissement est correctement rapporté : l'interaction avec l'élément neutre de la composition peut produire des comportements ÉMERGENTS, ce qui entrave la compositionnalité. Et le chapitre 4 en conclut, honnêtement, que K7PL revendique l'atomicité locale et non la localité. Or la source résout ce qu'elle signale. La théorie des catégories y répond par l'ENVELOPPE DE KAROUBI, et cette construction se révèle profondément liée à la linéarisabilité, dont elle donne une formulation nouvelle. Les auteurs en tirent des preuves algébriques nouvelles et simples de LA PROPRIÉTÉ DE LOCALITÉ, et d'un analogue de l'équivalence avec le raffinement observationnel. La propriété que le document se refuse à revendiquer est démontrée dans la pièce qu'il cite pour dire pourquoi il s'en refuse.

#### \[DONE\] La formulation nouvelle ne repose ni sur l'atomicité ni sur l'antériorité, et cela sert K7PL

Les auteurs soulignent que leur formulation ne repose PAS sur l'atomicité ni directement sur l'ordre d'antériorité, et qu'elle n'est possible que grâce à la compositionnalité — linéarisabilité et compositionnalité étant intrinsèquement liées. C'est ce qui la rend transportable à K7PL, dont l'atomicité locale est démontrée sur un cas et dont la composition est un arbre de coupures. La voie vers la localité ne passe donc pas par un renforcement de l'atomicité mais par la structure de composition, que le document possède déjà. Et les techniques sont connectées à une logique de programme simple, correcte vis-à-vis de cette linéarisabilité généralisée.

### oliveiravaleLayeredObjectbasedGame2022

    AUTHORS: Oliveira Vale et al. | DATE: 2022 | TITLE: Layered and object-based game semantics | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3498703 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le critère de correction d'une couche a une forme PUBLIÉE, et elle est composable

Une interface de couche s'y modélise comme un TYPE D'OBJET, appelé signature de couche, accompagné d'une STRATÉGIE D'OBJET. Une implantation de couche est une application régulière au sens de Reddy, allant d'un objet portant la signature de la couche inférieure vers un objet portant celle de la couche supérieure. Et le critère : une implantation de couche est CERTIFIÉE quand sa composition avec la stratégie d'objet de la couche inférieure implémente la stratégie de la couche supérieure. C'est le critère de sédimentation de K7PL, énoncé formellement et muni de sa loi de composition. Le document a le critère et n'a pas la loi.

#### \[DONE\] Le problème que la source résout est celui que l'ARÈNE pose

Les auteurs écrivent que dans les modèles antérieurs de couches d'abstraction certifiées, la compositionnalité est restreinte par le défaut d'ENCAPSULATION DE L'ÉTAT, et que leur apport est de définir la sémantique des interfaces et des implantations uniquement sur leurs comportements OBSERVABLES. L'idée reprise est celle de Reddy : modéliser un langage impératif non par des fonctions sur des états globaux, mais par des objets et leurs comportements observables. K7PL a une arène partagée traversant ses trois couches. C'est précisément l'état dont le défaut d'encapsulation restreint la compositionnalité, et la source dit par quoi le remplacer.

#### \[DONE\] Ce que la synthèse rassemble, et c'est le trépied du document

Les couches d'abstraction certifiées y synthétisent trois choses : la sémantique des jeux, le CALCUL DE RAFFINEMENT et les EFFETS ALGÉBRIQUES. Le document a les trois — la stratification, la relation de précision, les effets algébriques — et ne les a jamais présentés comme une synthèse. C'est un acquis d'architecture, non une coïncidence de vocabulaire.

### orchardEmbeddingEffectSystems2014

    AUTHORS: Orchard and Petricek | DATE: 2014 | TITLE: Embedding effect systems in Haskell | REVUE: Proc. 2014 ACM SIGPLAN Symp. Haskell (haskell '14) | IDENTIFIANT: 10.1145/2633357.2633368 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### petreCognitiveDimensionsNotation2006

    AUTHORS: Petre | DATE: 2006 | TITLE: Cognitive dimensions ‘beyond the notation’ | REVUE: Journal of Visual Languages &amp; Computing | IDENTIFIANT: 10.1016/j.jvlc.2006.04.003 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — numéro spécial du Journal of Visual Languages and Computing 17 (2006) sur les dimensions cognitives, fourni à la place de « Ten Years of Cognitive Dimensions » qui en est l'avant-propos et n'a pu être isolé. REÇUE, NON ENCORE DÉPOUILLÉE.

### pierceBehavioralEquivalencePolymorphic2000

    AUTHORS: Pierce et Sangiorgi | DATE: 2000 | TITLE: Behavioral equivalence in the polymorphic pi-calculus | REVUE: Journal of the ACM | IDENTIFIANT: 10.1145/337244.337261 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### pittsNominalLogicFirst2003

    AUTHORS: Pitts | DATE: 2003 | TITLE: Nominal logic, a first order theory of names and binding | REVUE: Information and Computation | IDENTIFIANT: 10.1016/S0890-5401(03)00138-X | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

échange plutôt que renommage ; équivariance ; quantificateur de fraîcheur ; mécanisation

### pittsNominalSetsNames2013

    AUTHORS: Pitts | DATE: 2013 | TITLE: Nominal sets names and symmetry in computer science | REVUE: Nominal sets: names and symmetry in computer science | IDENTIFIANT: 10.1017/CBO9781139084673 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

manuel du domaine, dont le sujet déclaré est la LOCALITÉ ; consulté par chapitres

### pradicImplicitAutomataLcalculi

    AUTHORS: Pradic et Price | DATE | TITLE: Implicit automata in λ-calculi III aﬃne planar string-to-string functions ⋆ | REVUE: Implicit automata in λ-calculi III: aﬃne planar string-to-string functions ⋆ | IDENTIFIANT: 10.46298/entics.14804 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

#### \[DONE\] Un PROGRAMME entier dit que l'annotation du chapitre 4 pourrait être un THÉORÈME

La série des automates implicites cherche à caractériser des classes d'automates par la DISCIPLINE DE TYPE des termes qui les définissent, non par une annotation portée à la main. Le théorème 1.1 en donne un exemple net : les fonctions de chaîne à chaîne définissables en logique affine non commutative, calculant sur le codage de Church, coïncident exactement avec les transductions du premier ordre. Les articles précédents de la série font de même pour les langages sans étoile et les transductions régulières. Le chapitre 4 annote ses constructeurs — linéaire pour un automate déterministe, polynomial pour un non déterministe, exponentiel pour une pile ou du retour arrière. La littérature dit que cette classe peut se DÉDUIRE au lieu de se déclarer, ce qui transformerait une obligation du programmeur en conséquence du type.

#### \[DONE\] Mais la discipline qui donne la caractérisation n'est PAS celle de K7PL

La caractérisation demande la logique affine NON COMMUTATIVE, c'est-à-dire une restriction de l'échange. K7PL restreint l'affaiblissement et la contraction par sa composante d'usage, et ne restreint pas l'échange — Grass note d'ailleurs que l'échange peut se restreindre pour obtenir des logiques non commutatives et écarte le cas. Le programme est donc pertinent et non applicable en l'état. Ce qui manque est nommé : une composante de planarité, ou une raison de s'en passer.

#### \[DONE\] Le transducteur est le bon modèle, mais PAS le transducteur à un sens

La direction difficile de la preuve compile les termes en TRANSDUCTEURS PLANAIRES RÉVERSIBLES À DEUX SENS. Un transducteur à un sens ne suffit pas. Pour l'abaissement d'une couche vers l'autre, la réponse est donc oui avec une réserve de forme, et la réserve est celle qui coûte : deux sens veut dire que la lecture peut revenir en arrière, ce qui n'est pas gratuit pour un abaissement en flux. Un point technique à retenir si le modèle est repris : l'interprétation n'identifie pas les termes bêta-équivalents, elle transforme les bêta-réductions en INÉGALITÉS, l'unité du produit tensoriel de la catégorie employée n'étant pas un objet terminal.

### pratherFirstStepsPredicting2023

    AUTHORS: Prather et al. | DATE: 2023 | TITLE: First steps towards predicting the readability of programming error messages | REVUE: Proceedings of the 54th ACM Technical Symposium on Computer Science Education V. 1 | IDENTIFIANT: 10.1145/3545945.3569791 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — les quatre articles de Becker, Denny et Prather sur les messages d'erreur, dont je n'avais que les trois noms. Sert la question 30. REÇUE, NON ENCORE DÉPOUILLÉE.

### prattTransitionCancellationConcurrency2003

    AUTHORS | DATE: 2003 | TITLE: Mathematical Structures in Computer Science | REVUE: Mathematical Structures in Computer Science | IDENTIFIANT: 10.1017/S0960129503004031 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### racordonStateCoherenceLand2025

    AUTHORS: Racordon et al. | DATE: 2025 | TITLE: On the state of coherence in the land of type classes | REVUE: On the state of coherence in the land of type classes | IDENTIFIANT: https://programming-journal.org/2025/10/15 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### rajaniUnifyingTypetheoryHigherorder2021

    AUTHORS: Rajani et al. | DATE: 2021 | TITLE: A unifying type-theory for higher-order (amortized) cost analysis | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3434308 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### ramNeutrosophicAutomataReverse

    AUTHORS: Ram et al. | DATE | TITLE: Neutrosophic automata and reverse neutrosophic automata | REVUE: Neutrosophic automata and reverse neutrosophic automata | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

ÉCART PARTIELLEMENT LEVÉ le 9 août. L'article reste mince et sans résultat employable — le jugement de tenue tenait. Mais sa BIBLIOGRAPHIE est une carte vers la littérature des automates valués dans un monoïde ordonné, dont Li et Pedrycz 2005 sur les expressions régulières floues à valeurs dans un monoïde ordonné par treillis. Conservée à ce titre.

### rasmussenSkillsRulesKnowledge1983

    AUTHORS: Rasmussen | DATE: 1983 | TITLE: Skills, rules, and knowledge; signals, signs, and symbols, and other distinctions in human performan | REVUE: Skills, rules, and knowledge; signals, signs, and symbols, and other distinctions in human performance models | IDENTIFIANT: http://ieeexplore.ieee.org/document/6313160/ | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

SRK de première main ; un niveau d'abstraction AJOUTE ; causes de bas en haut ; questions 30 et 50

### recioRemoteDirectMemory2007a

    AUTHORS | DATE: 2007 | TITLE: A remote direct memory access protocol specification | REVUE: A remote direct memory access protocol specification | IDENTIFIANT: 10.17487/rfc5040 | REF.BIB: t | RDF: t | PDF: nil | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### sabelfeldModelDelimitedInformation2004

    AUTHORS: Sabelfeld et Myers | DATE: 2004 | TITLE: A model for delimited information release | REVUE: Software Security - Theories and Systems | IDENTIFIANT: 10.1007/978-3-540-37621-7_9 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] La divulgation délimitée, et ce qu'elle exige de plus qu'un déclassement

La source pose l'énoncé que le document reprend : un programme ne doit pas libérer davantage que ce que sa politique de déclassement était censée libérer. La formulation compte autant que le principe — elle exclut le cas où une valeur secrète transite par la fonction déclassifiante sous un déguisement quelconque, ce qu'une simple permission de déclasser n'exclut pas. Le document lui doit la lecture qu'il retient au chapitre 1 pour la frontière entre le journal et les niveaux : ce n'est pas la permission de divulguer qui se type, c'est la QUANTITÉ divulguée. RÉSERVE DE FONDS, à lever au prochain export : le résumé porté par l'index est celui d'un tout autre article — un défaut d'outil de récupération de métadonnées, non de la source. Cette synthèse est écrite sur les emplois du manuscrit et sur la correction déjà faite dans Zotero, non sur ce résumé.

### saffrichBorrowingSessionTypes2025

    AUTHORS: Saffrich et al. | DATE: 2025 | TITLE: Borrowing from session types | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3763173 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] L'emprunt de session existe, et il est fondé sur le TYPAGE LINÉAIRE ORDONNÉ

Les auteurs proposent une interface fondée sur l'emprunt, incarnée dans un calcul noyau, dont le système de types est fondé sur le typage linéaire ORDONNÉ, avec une opération explicite de partage de la propriété d'un canal. La sémantique est établie par une traduction préservant les types vers un calcul fonctionnel sans interblocage, d'où sûreté du typage et absence d'interblocage ; et une version algorithmique donne la décidabilité de la vérification, avec une traduction mécanisée et vérifiée depuis le langage externe. Réponse à la question : oui, une session peut être empruntée sans être consommée, et le prix est nommé.

#### \[DONE\] Le prix est le MÊME que celui de deux autres questions, et c'est cela qu'il faut voir

Le typage ordonné est une restriction de l'échange. Or l'arc C a établi que la caractérisation d'une classe d'automates par la discipline de type exige la non-commutativité ; et le sous-typage multipartite que le document cite pour lever l'acyclicité est lui aussi non commutatif, ce que le document note. Trois besoins indépendants, un seul prix. Le document traite la non-commutativité comme une objection locale à chaque fois qu'elle se présente, et non comme une décision d'architecture unique. C'est la remarque la plus utile de cet arc.

### sahebolamriBringYourOwn2023

    AUTHORS: Sahebolamri et al. | DATE: 2023 | TITLE: Bring your own data structures to datalog | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3622840 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### sainatiTypingStrictness2026

    AUTHORS: Sainati et al. | DATE: 2026 | TITLE: Typing strictness | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3776657 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### sannierDependentCoeffectsLocal2026

    AUTHORS | DATE: 2026 | TITLE: Proc. ACM Program. Lang. | REVUE: Proc. ACM Program. Lang. | IDENTIFIANT: 10.1145/3776670 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### schrijversCOCHISStableCoherent2019

    AUTHORS: Schrijvers et al. | DATE: 2019 | TITLE: COCHIS stable and coherent implicits | REVUE: Journal of Functional Programming | IDENTIFIANT: 10.1017/S0956796818000242 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### seflProgrammingDependentAdditive2025

    AUTHORS | DATE: 2025 | TITLE: Trends in Functional Programming | REVUE: Trends in Functional Programming | IDENTIFIANT: 10.1007/978-3-031-74558-4_5 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### shiQEDContextObservation2025a

    AUTHORS | DATE | TITLE | REVUE | IDENTIFIANT: à renseigner depuis Zotero | REF.BIB: nil | RDF: nil | PDF: nil | LU: nil | A-CITER-SUR: à établir | SYNTHESE: t

#### \[TODO\] Synchronisée sans emploi

Entrée synchronisée depuis Zotero sans emploi au corps. À citer ou à retirer lors de la prochaine synchronisation ; aucune décision de fond n'est prise ici.

### smithReflectionSemanticsLISP1984

    AUTHORS | DATE: 1984 | TITLE: Proceedings of the 11th ACM SIGACT-SIGPLAN symposium on Principles of programming languages - POPL '84 | REVUE: Proceedings of the 11th ACM SIGACT-SIGPLAN symposium on Principles of programming languages - POPL '84 | IDENTIFIANT: 10.1145/800017.800513 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: t

#### \[DONE\] Ce que la référence rend

alignement de catégories ; l'évaluation comme franchissement de niveau ; question 51

### tanEfficientPrecisePointsto2017

    AUTHORS: Tan et al. | DATE: 2017 | TITLE: Efficient and precise points-to analysis modeling the heap by merging equivalent automata | REVUE: Proceedings of the 38th ACM SIGPLAN Conference on Programming Language Design and Implementation | IDENTIFIANT: 10.1145/3062341.3062360 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### thiemannLabeldependentSessionTypes

    AUTHORS: Thiemann and Vasconcelos | DATE: 2020 | TITLE: Label-dependent session types | REVUE: Proceedings of the ACM on Programming Languages | IDENTIFIANT: 10.1145/3371135 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### toninhoInterconnectabilitySessionBasedLogical2018

    AUTHORS: Toninho et Yoshida | DATE: 2018 | TITLE: Interconnectability of session-based logical processes | REVUE: ACM Transactions on Programming Languages and Systems | IDENTIFIANT: 10.1145/3242173 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

#### \[DONE\] Le document cite cette source pour sa LIMITE et manque le REMÈDE qu'elle porte

La limite est correctement rapportée : l'interconnectabilité de la logique linéaire classique est strictement moins expressive que celle d'une session multipartite unique, et cela s'étend au passage de canaux d'ordre supérieur et à la réplication, aucun de ces traits n'enrichissant l'interconnectabilité. Mais la section 8 du même article développe une extension de la composition, la MULTICOUPURE, qui permet des topologies d'interconnexion plus riches EN PRÉSERVANT L'ABSENCE D'INTERBLOCAGE, et — le point qui décide — SANS MODIFIER LES TYPES NI LA SYNTAXE. Le document écrit que l'acyclicité est levable et que le prix en est mieux connu qu'il n'y paraît, puis cite pour ce prix deux autres sources dont l'une est non commutative. La voie la moins chère est dans la source qu'il cite déjà pour la contrainte.

#### \[DONE\] Une TROISIÈME voie, et K7PL l'a peut-être déjà sans le savoir

Les auteurs rapportent que l'interprétation intuitionniste peut encoder le comportement des sessions multipartites, à congruence barbelée typée près, en ajoutant un participant supplémentaire — un ORCHESTRATEUR — qui médie toutes les interactions entre rôles, ce qui réalise le réseau par une topologie EN ARBRE. C'est la forme que K7PL a déjà : un arbre de coupures avec un superviseur. La réserve des auteurs est que cet encodage ne préserve pas l'interconnectabilité des types globaux, quand le leur la préserve. Trois voies donc, avec trois prix connus : garder l'acyclicité, prendre la multicoupure, ou passer par un orchestrateur.

### urbatAutomataLearningAlgebraic2020

    AUTHORS: Urbat et Schröder | DATE: 2020 | TITLE: Automata learning an algebraic approach | REVUE: Proceedings of the 35th Annual ACM/IEEE Symposium on Logic in Computer Science | IDENTIFIANT: 10.1145/3373718.3394775 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Corpus T-65, DÉPOUILLÉE le 9 août : cadre paramétrique en une MONADE, dont les langages sortés, les langages nominaux avec liaison et les fonctions de coût sont trois instances — soit nos sortes, notre hygiène et notre budget. Fiche dans chantier/arc-theorique.org.

#### \[DONE\] Trois traits de K7PL sont trois INSTANCES du même cadre

Le cadre d'apprentissage y est paramétrique en une MONADE, et les auteurs en donnent des instances : les langages sortés, les langages nominaux avec liaison, et les fonctions de coût. Ce sont les sortes de K7PL, son hygiène et son budget. Trois traits que le document traite séparément se retrouvent ici comme trois choix du même paramètre, ce qui est un argument d'unité qu'il n'emploie pas.

#### \[DONE\] Un usage pour la synthèse, et il est indirect

La question était l'usage pour la synthèse dirigée par les types. La réponse est qu'un cadre d'apprentissage paramétrique donne, pour chaque instance, une procédure d'inférence d'automate à partir d'observations — ce qui est le pendant, du côté du comportement, de ce que la synthèse dirigée par les grades fait du côté du type. Les deux se rejoindraient sur un même exemple ; aucune source du fonds ne les a encore rejoints, et c'est une question ouverte plutôt qu'un manque.

### venemaAutomataFixedPoint2006

    AUTHORS: Venema | DATE: 2006 | TITLE: Automata and fixed point logic a coalgebraic perspective | REVUE: Information and Computation | IDENTIFIANT: 10.1016/j.ic.2005.06.003 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Cartographiée, non lue

Corpus T-65 (convergence automate et catégories), fourni le 7 août et CARTOGRAPHIÉ avant lecture — voir chantier/arc-theorique.org. L'entrée est en bibliographie parce que la pièce est au corpus ; elle sera citée quand elle sera dépouillée, ou écartée avec son motif.

### vicenteCognitiveWorkAnalysis1999a

    AUTHORS: Vicente | DATE: 1999 | TITLE: Cognitive work analysis toward safe, productive, and healthy computer-based work | REVUE: Cognitive work analysis: toward safe, productive, and healthy computer-based work | IDENTIFIANT: 10.1201/b12457 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

normatif / descriptif / FORMATIF ; donne son statut à P-4

### walchAutomatedAmortisedAnalysis

    AUTHORS: Walch | DATE: 2026 | TITLE: Automated amortised analysis of skew heaps and leftist heaps | REVUE: Automated amortised analysis of skew heaps and leftist heaps | IDENTIFIANT: 10.1007/978-3-032-32537-2_5 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### weissOxideEssenceRust2021

    AUTHORS: Weiss et al. | DATE: 2021 | TITLE: Oxide the essence of rust | REVUE: Oxide: the essence of rust | IDENTIFIANT: 10.48550/arXiv.1903.00982 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

capabilités linéaires et permissions fractionnaires au niveau source ; chapitre 3

### weissRustDistilledExpressive2018

    AUTHORS: Weiss et al. | DATE: 2018 | TITLE: Rust distilled an expressive tower of languages | REVUE: Rust distilled: an expressive tower of languages | IDENTIFIANT: 10.48550/arXiv.1806.02693 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

le critère de Felleisen pour les frontières de couche ; chapitres 1 et 2, question 50

### wrightUsingVisualizationVisualization2013a

    AUTHORS: Wright et al. | DATE: 2013 | TITLE: Using visualization for visualization an ecological interface design approach to inputting data | REVUE: Using visualization for visualization: an ecological interface design approach to inputting data | IDENTIFIANT: https://linkinghub.elsevier.com/retrieve/pii/S0097849313000150 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

les trois principes de l'interface écologique appliqués à une DÉCOUVERTE ; questions 43 à 46

### xieConaturalNumbersForm2025

    AUTHORS: Xie et Bense | DATE: 2025 | TITLE: The conatural numbers form an exponential commutative semiring | REVUE: Proceedings of the 10th ACM SIGPLAN International Workshop on Type-Driven Development | IDENTIFIANT: 10.1145/3759538.3759654 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### yadavGeneralCategoricalFramework2022

    AUTHORS: Yadav et Tiwari | DATE: 2022 | TITLE: A general categorical framework of minimal realization theory for a fuzzy multiset language | REVUE: A general categorical framework of minimal realization theory for a fuzzy multiset language | IDENTIFIANT: https://www.hindawi.com/journals/mpe/2022/2798898/ | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Corpus T-65, DÉPOUILLÉE le 9 août : réalisation de Nerode existante et unique à isomorphisme près pour les langages multiensembles — et « multiensemble » veut dire compte d'usage, donc la composante u de notre grade. Fiche dans chantier/arc-theorique.org.

#### \[DONE\] La réalisation minimale existe et est unique, et le multiensemble EST le compte d'usage

Réalisation de Nerode existante et unique à isomorphisme près pour les langages de multiensembles. Or un multiensemble est un compte d'occurrences, donc la composante d'usage du grade. La minimalisation d'un automate gradué a donc un sens pour K7PL, et le sens est précis : c'est la réalisation minimale du comportement, unique à isomorphisme près, ce qui donne un critère d'identité entre deux automates que le document construirait différemment.

### zhaoEvaluatingDatalogSemirings2024

    AUTHORS: Zhao et al. | DATE: 2024 | TITLE: Evaluating datalog over semirings a grounding-based approach | REVUE: Evaluating datalog over semirings: a grounding-based approach | IDENTIFIANT: 10.1145/3651591 | REF.BIB: t | RDF: t | PDF: t | LU: t | A-CITER-SUR: citée au manuscrit | SYNTHESE: nil — abstract d'export, non analysé

#### \[DONE\] Ce que la référence rend

Citée au manuscrit. L'emploi et le motif se lisent au point de citation ; aucune décision bibliographique séparée n'a été prise, la citation en tenant lieu.

### zhuFuzzingSurveyRoadmap2022

    AUTHORS: Zhu et al. | DATE: 2022 | TITLE: Fuzzing a survey for roadmap | REVUE: ACM Computing Surveys | IDENTIFIANT: 10.1145/3512345 | REF.BIB: t | RDF: t | PDF: t | LU: partiel | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Ce que la référence rend

HOMONYMIE : arrivée dans Zhu.zip avec l'article recherché, mais il s'agit d'un autre Zhu et le sujet — le fuzzing — ne touche aucune question ouverte. ÉCARTÉE, et consignée pour que le lot soit intégralement rendu compte.

### zhuLearningProgrammingChallenges2022

    AUTHORS: Zhu et al. | DATE: 2022 | TITLE: Learning and programming challenges of rust a mixed-methods study | REVUE: Proceedings of the 44th International Conference on Software Engineering | IDENTIFIANT: 10.1145/3510003.3510164 | REF.BIB: t | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Reçue, non dépouillée

Livrée le 9 août — l'analyse de tâche cognitive sur 110 erreurs de propriété, connue jusqu'ici par la seule revue de Ferdowsi. Sert les questions 30 et 39. REÇUE, NON ENCORE DÉPOUILLÉE.

## DOCUMENTS SEGMENTÉS DEPUIS corpus/ ET ref/ — *identifiés, non importés, non lus*

### SEG-datalog

    AUTHORS: Borraz-Sanchez, C.; Ma, J.; Klabjan, D.; Pasalic, E.; Aref, M. | DATE | TITLE: Algebraic Modeling in Datalog | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-datalog | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### ceriWhatYouAlways1989

    AUTHORS: Ceri, Stefano; Gottlob, Georg; Tanca, Letizia | DATE: 1989 | TITLE: What You Always Wanted to Know About Datalog (And Never Dared to Ask) | REVUE: IEEE Transactions on Knowledge and Data Engineering 1(1), 1989 | IDENTIFIANT: doi:10.1109/69.43410 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-ceriWhatAlwaysWanted1989 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### satoLinearAlgebraicApproach2017

    AUTHORS: Sato, Taisuke | DATE: 2017 | TITLE: A Linear Algebraic Approach to Datalog Evaluation | REVUE: Theory and Practice of Logic Programming 17(3), 2017 | IDENTIFIANT: doi:10.1017/S1471068417000023 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-satoLinearAlgebraicApproach2017 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-cateRightAdjointsDatalog2024

    AUTHORS: ten Cate, Balder; Dalmau, Victor; Oprsal, Jakub | DATE: 2024 | TITLE: Right-Adjoints for Datalog Programs | REVUE: ICDT 2024, 2024 | IDENTIFIANT: doi:10.4230/LIPIcs.ICDT.2024.10 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-cateRightAdjointsDatalog2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### alvianoDisjunctiveDatalogExistential2012

    AUTHORS: Alviano, M.; Faber, W.; Leone, N.; Manna, M. | DATE: 2012 | TITLE: Disjunctive Datalog with Existential Quantifiers: Semantics, Decidability, and Complexity Issues | REVUE: Theory and Practice of Logic Programming 12(4-5), 2012 | IDENTIFIANT: arXiv:1210.2316 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-alvianoDisjunctiveDatalogWith2012 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### yuFlowLogRethinkingDatalog2026

    AUTHORS: Yu, Zhenghong; Zhao, Hangdong; Hou, Wanzhu; Koutris, Paraschos | DATE: 2026 | TITLE: FlowLog: Re-thinking Datalog for Fast and Extensible Static Analysis | REVUE: arXiv, 2026 | IDENTIFIANT: arXiv:2607.23971 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-yuFlowlogThinkingDatalog2026 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-lutzOntologyMediatedQuerying2017

    AUTHORS: Lutz, Carsten; Sabellek, Leif | DATE: 2017 | TITLE: Ontology-Mediated Querying with the Description Logic EL: Trichotomy and Linear Datalog Rewritability | REVUE: IJCAI 2017, 2017 | IDENTIFIANT: doi:10.24963/ijcai.2017/173 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-lutzOntologyMediatedQuerying2017 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-lean

    AUTHORS: Tantow, J.; Gerlach, L.; Mennicke, S.; Krotzsch, M. | DATE | TITLE: Verifying Datalog Reasoning with Lean | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec tantowVerifyingDatalogReasoning2024 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-lean | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### rudolphExpressivityDatalogVariants2016

    AUTHORS: Rudolph, Sebastian; Thomazo, Michael | DATE: 2016 | TITLE: Expressivity of Datalog Variants - Completing the Picture | REVUE: IJCAI 2016, 2016 | IDENTIFIANT: url:https://inria.hal.science/hal-01302832v1 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-rudolphExpressivityDatalogVariants2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-ceylanComplexityResultsProbabilistic2016

    AUTHORS: Ceylan, Ismail Ilkan; Lukasiewicz, Thomas; Penaloza, Rafael | DATE: 2016 | TITLE: Complexity Results for Probabilistic Datalog+/- | REVUE: ECAI 2016, 2016 | IDENTIFIANT: doi:10.3233/978-1-61499-672-9-1414 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-ceylanComplexityResultsProbabilistic2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-foustoucosDatalogModalLogic2009

    AUTHORS: Foustoucos, Eugenie; Guessarian, Irene | DATE: 2009 | TITLE: Inf-Datalog, Modal Logic and Complexities | REVUE: RAIRO - Theoretical Informatics and Applications 43(1), 2009 | IDENTIFIANT: doi:10.1051/ita/2008030 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-foustoucosDatalogModalLogic2009 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-yanakievaDatalogFrameworkConflict2026

    AUTHORS: Yanakieva, Elena; Bieniusa, Annette; Dumbrava, Stefania | DATE: 2026 | TITLE: A Datalog Framework for Conflict-Free Replicated Data Types | REVUE: Theory and Practice of Logic Programming, 2026 | IDENTIFIANT: doi:10.1017/S1471068426100556 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-yanakievaDatalogFrameworkConflict2026 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### fanBuildingDatalogSystems2022

    AUTHORS: *Building Datalog Systems for Efficient and Scalable Data Analytics* | DATE: 2022 | TITLE: Building datalog systems for efficient and scalable data analytics | REVUE: Fan, Zhiwei | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-analytics | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-incrementaux

    AUTHORS: Pacak, Andre | DATE | TITLE: Incremental Datalog (these : type checkers incrementaux, donnees structurees, frontend fonctionnel, debogage) | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec pacakIncrementalDatalog2023 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-incrementaux | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### mazuranExtendingPowerDatalog2013

    AUTHORS: Mazuran, Mirjana; Serra, Edoardo; Zaniolo, Carlo | DATE: 2013 | TITLE: Extending the power of datalog recursion | REVUE: The VLDB Journal 22(4), 2013 | IDENTIFIANT: doi:10.1007/s00778-012-0299-1 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-mazuranExtendingPowerDatalog2013 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-programs

    AUTHORS: Leone, N.; Manna, M.; Terracina, G.; Veltri, P. | DATE | TITLE: Efficiently Computable Datalog-exists Programs | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-programs | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-gilrayDatalogWithFirst2024

    AUTHORS: Gilray, T.; Sahebolamri, A.; Sun, Y.; Kunapaneni, S.; Kumar, S.; Micinski, K. | DATE: 2024 | TITLE: Datalog with First-Class Facts | REVUE: arXiv / VLDB, 2024 | IDENTIFIANT: arXiv:2411.14330 | REF.BIB: nil | RDF: t — apparié le 3 septembre avec gilrayDatalogFirstclassFacts2024a | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-gilrayDatalogWithFirst2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-concepts

    AUTHORS: Krotzsch, Markus | DATE | TITLE: Modern Datalog: Concepts, Methods, Applications | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec krotzschModernDatalog2024 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-concepts | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### saccaDataExchangeDatalog2012

    AUTHORS: *Data Exchange in Datalog is mainly a Matter of Choice* | DATE: 2012 | TITLE: Data exchange in datalog is mainly a matter of choice | REVUE: Sacca, Domenico; Serra, Edoardo | IDENTIFIANT: 10.1007/978-3-642-32925-8_16 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-choice | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-abiteboulDataFunctionsDatalog1988

    AUTHORS: Abiteboul, Serge; Hull, Richard | DATE: 1988 | TITLE: Data Functions, Datalog and Negation (Extended Abstract) | REVUE: SIGMOD 1988, 1988 | IDENTIFIANT: doi:10.1145/50202.50213 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-abiteboulDataFunctionsDatalog1988 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### khamisDatalogWonderland2022

    AUTHORS: Abo Khamis, M.; Ngo, H. Q.; Pichler, R.; Suciu, D.; Wang, Y. R. | DATE: 2022 | TITLE: Datalog in Wonderland | REVUE: SIGMOD Record 51(2), 2022 | IDENTIFIANT: doi:10.1145/3552490.3552492 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-khamisDatalogWonderland2022 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-roncaStreamReasoningTemporal2018

    AUTHORS: Ronca, A.; Kaminski, M.; Cuenca Grau, B.; Motik, B.; Horrocks, I. | DATE: 2018 | TITLE: Stream Reasoning in Temporal Datalog | REVUE: AAAI 2018, 2018 | IDENTIFIANT: doi:10.1609/aaai.v32i1.11544 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-roncaStreamReasoningTemporal2018 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-quantification

    AUTHORS: Lanzinger, M.; Nissl, M.; Sallinger, E.; Walega, P. A. | DATE | TITLE: Temporal Datalog with Existential Quantification | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec lanzingerTemporalDatalogExistential2022 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-quantification | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### imranFastDatalogEvaluation2022

    AUTHORS: Imran, M.; Gevay, G. E.; Quiane-Ruiz, J.-A.; Markl, V. | DATE: 2022 | TITLE: Fast datalog evaluation for batch and stream graph processing | REVUE: World Wide Web 25, 2022 | IDENTIFIANT: doi:10.1007/s11280-021-00960-w | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-imranFastDatalogEvaluation2022 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-gilrayCompilingDataParallel2021

    AUTHORS: Gilray, Thomas; Kumar, Sidharth; Micinski, Kristopher | DATE: 2021 | TITLE: Compiling Data-Parallel Datalog | REVUE: CC 2021, 2021 | IDENTIFIANT: doi:10.1145/3446804.3446855 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-gilrayCompilingDataParallel2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-zhaoFlowlogEfficientExtensible2025

    AUTHORS: Zhao, H.; Yu, Z.; Rao, S.; Frisk, S.; Fan, Z.; Koutris, P. | DATE: 2025 | TITLE: FlowLog: Efficient and Extensible Datalog via Incrementality | REVUE: arXiv, 2025 | IDENTIFIANT: arXiv:2511.00865 | REF.BIB: nil | RDF: t — apparié le 3 septembre avec zhaoFlowLogEfficientExtensible2025a | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-zhaoFlowlogEfficientExtensible2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-shkapskyDataAnalyticsWith2016

    AUTHORS: Shkapsky, A.; Yang, M.; Interlandi, M.; Chiu, H.; Condie, T.; Zaniolo, C. | DATE: 2016 | TITLE: Big Data Analytics with Datalog Queries on Spark | REVUE: SIGMOD 2016, 2016 | IDENTIFIANT: doi:10.1145/2882903.2915229 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-shkapskyDataAnalyticsWith2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-gottlobComplexityAcyclicConjunctive2001

    AUTHORS: Gottlob, Georg; Leone, Nicola; Scarcello, Francesco | DATE: 2001 | TITLE: The Complexity of Acyclic Conjunctive Queries | REVUE: Journal of the ACM 48(3), 2001 | IDENTIFIANT: doi:10.1145/371316.371343 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/datalog.txt | SEGMENT: SEG-gottlobComplexityAcyclicConjunctive2001 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/datalog.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SpecificationsApacheArrow

    AUTHORS: Apache Arrow | DATE: 2024 | TITLE: Arrow Columnar Format (version 1.5) | REVUE: Apache Software Foundation, 2024 | IDENTIFIANT: url:https://arrow.apache.org/docs/format/Columnar.html | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/formats-arrow-capnproto-sbe.txt | SEGMENT: SEG-arrowArrowColumnarFormat2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/formats-arrow-capnproto-sbe.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### CAPNPROTO-SPEC

    AUTHORS: Varda, Kenton (Cap’n Proto project) | DATE: 2024 | TITLE: Cap'n Proto documentation (schema language, encoding spec, RPC protocol) | REVUE: capnproto.org, 2024 | IDENTIFIANT: url:https://capnproto.org/ | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/formats-arrow-capnproto-sbe.txt | SEGMENT: SEG-vardaProtoDocumentationSchema2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/formats-arrow-capnproto-sbe.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### fixTradingCommunitySBE2020

    AUTHORS: FIX Trading Community | DATE: 2020 | TITLE: Simple Binary Encoding (SBE) Technical Specification, Version 1.0 with Errata | REVUE: FIX Trading Community, 2020 | IDENTIFIANT: url:https://www.fixtrading.org/standards/sbe/ | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/formats-arrow-capnproto-sbe.txt | SEGMENT: SEG-communitySimpleBinaryEncoding2020 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/formats-arrow-capnproto-sbe.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### piercePictProgrammingLanguage1997

    AUTHORS: *Pict: A Programming Language Based on the Pi-Calculus* | DATE: 1997 | TITLE: Pict: a programming language based on the pi-calculus | REVUE: Pierce, Benjamin C.; Turner, David N. | IDENTIFIANT: 10.7551/mitpress/5641.003.0022 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-piCalculus | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### sakayoriWiringPicalculusDenotational2026

    AUTHORS: Sakayori, Ken; Sangiorgi, Davide; Castellan, Simon; Clairambault, Pierre | DATE: 2026 | TITLE: Wiring the pi-calculus to Denotational Semantics | REVUE: arXiv, 2026 | IDENTIFIANT: arXiv:2605.18496 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-sakayoriWiringCalculusDenotational2026 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### gutkouvasLanguagesLogicsTypes2016

    AUTHORS: Gutkovas, Ramunas | DATE: 2016 | TITLE: Languages, Logics, Types and Tools for Concurrent System Modelling | REVUE: Uppsala University (Acta Universitatis Upsaliensis 1392), 2016 | IDENTIFIANT: url:http://urn.kb.se/resolve?urn=urn:nbn:se:uu:diva-300029 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-gutkovasLanguagesLogicsTypes2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### parrowModalLogicsNominal2021

    AUTHORS: Parrow, J.; Borgstrom, J.; Eriksson, L.-H.; Gutkovas, R.; Weber, T. | DATE: 2021 | TITLE: Modal Logics for Nominal Transition Systems | REVUE: Logical Methods in Computer Science 17(1), 2021 | IDENTIFIANT: doi:10.23638/LMCS-17(1:6)2021 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-parrowModalLogicsNominal2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### gutkouvasSessionTypeUnreliable2017

    AUTHORS: *A Session Type System for Unreliable Broadcast Communication* | DATE: 2017 | TITLE: A session type system for unreliable broadcast communication | REVUE: Gutkovas, Ramunas; Kouzapas, Dimitrios; Gay, Simon J. | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-communication | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-mIPE

    AUTHORS: Silva, Frederico; Aguiar, Marilton | DATE | TITLE: Um ambiente computacional para processamento de imagens com alto desempenho no contexto do Projeto M-IPE | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec silvaAmbienteComputacional2010 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-mIPE | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-paralela

    AUTHORS: Milanes, Anolan; Barbosa, Ayala; Meira, Wagner; Ferreira, Renato | DATE | TITLE: Oportunidades para o uso de linguagens interpretadas em plataformas de computacao paralela | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec milanesOportunidadesLinguagens2010 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-paralela | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-distribuida

    AUTHORS: Librelotto, Giovani Rubert; Vizzotto, Juliana Kaizer; Augustin, Iara | DATE | TITLE: Um Compilador para a Linguagem Reativa Sincrona Distribuida | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-distribuida | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-cMTJava

    AUTHORS: Echevarria, Marcos Goncalves; Du Bois, Andre Rauber | DATE | TITLE: Um sistema de versionamento adiantado para a linguagem CMTJava | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-cMTJava | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-machine

    AUTHORS: Formiga, Andrei de A.; Lins, Rafael D. | DATE | TITLE: Efficient Implementation of the Pi-Calculus on the Java Virtual Machine | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec formigaEfficientImplementationPi2010 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-machine | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-shumskyProcessesConstructionCalculus2014

    AUTHORS: Shumsky, Leonid; Roslovtsev, Vladimir; Wolfengagen, Viacheslav | DATE: 2014 | TITLE: Processes Construction and pi-calculus-based Execution and Tracing | REVUE: ICEIS 2014, 2014 | IDENTIFIANT: doi:10.5220/0004972304480453 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-shumskyProcessesConstructionCalculus2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### syropoulosFuzzyChemicalAbstract2009

    AUTHORS: Syropoulos, Apostolos | DATE: 2009 | TITLE: Fuzzy Chemical Abstract Machines | REVUE: arXiv, 2009 | IDENTIFIANT: arXiv:0903.3513 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-syropoulosFuzzyChemicalAbstract2009 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### slawomirModelCheckingProcesses2014

    AUTHORS: Maludzinski, Slawomir; Dobrowolski, Grzegorz | DATE: 2014 | TITLE: Model Checking Processes Specified in Join-Calculus Algebra | REVUE: Computer Science 15(1), 2014 | IDENTIFIANT: doi:10.7494/csci.2014.15.1.61 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-maludzinskiModelCheckingProcesses2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-fournetJoinCalculusLanguage2000

    AUTHORS: Fournet, Cedric; Gonthier, Georges | DATE: 2000 | TITLE: The Join Calculus: a Language for Distributed Mobile Programming | REVUE: APPSEM 2000, LNCS 2395, 2002 | IDENTIFIANT: doi:10.1007/3-540-45699-6_6 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/join-calculus-pi-calcul.txt | SEGMENT: SEG-fournetJoinCalculusLanguage2000 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/join-calculus-pi-calcul.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-allianceWebassemblyComponentModel2024

    AUTHORS: Bytecode Alliance | DATE: 2024 | TITLE: The WebAssembly Component Model (documentation) | REVUE: Bytecode Alliance, 2024 | IDENTIFIANT: url:https://component-model.bytecodealliance.org/ | REF.BIB: nil | RDF: t — apparié le 3 septembre avec WebAssemblyComponentModel | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/L1-wasm-rdma-spirv.txt | SEGMENT: SEG-allianceWebassemblyComponentModel2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/L1-wasm-rdma-spirv.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### thompsonDisruptorHighPerformance2011

    AUTHORS: Thompson, M.; Farley, D.; Barker, M.; Gee, P.; Stewart, A. | DATE: 2011 | TITLE: LMAX Disruptor: High performance alternative to bounded queues for exchanging data between concurrent threads | REVUE: LMAX Exchange, 2011 | IDENTIFIANT: url:https://lmax-exchange.github.io/disruptor/disruptor.html | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/L1-wasm-rdma-spirv.txt | SEGMENT: SEG-thompsonLmaxDisruptorHigh2011 | SYNTHESE: t

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/L1-wasm-rdma-spirv.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

#### \[DONE\] L'anneau sans verrou, et les trois choses distinctes que le document lui doit

Document d'ingénierie plutôt qu'article évalué, et c'est son statut : il décrit une réalisation éprouvée en production, non un résultat démontré. Le document lui doit trois appuis qu'il vaut mieux séparer. Le premier est un principe d'architecture : l'algorithme idéal est celui où un seul fil détient TOUTES les écritures sur une ressource, les autres n'en lisant que les résultats — ce qui est la discipline de l'acteur, retrouvée par un autre chemin. Le deuxième est le transport lui-même, un anneau à producteur et consommateur uniques, sans verrou, dont toute la mémoire est allouée au démarrage : P3 appliqué au transport. Le troisième est un COÛT et non un gain — rendre les changements visibles dans l'ordre entre deux fils exige des barrières mémoire, que le compilateur émet en plus de celles du matériel. La borne de coût du transport ne repose pas sur cette source mais sur la tabulation des entrées, qui vient d'ailleurs.

### SEG-huttelFoundationsSessionTypes2016

    AUTHORS: Huttel, H.; Lanese, I.; Vasconcelos, V. T.; Caires, L.; Carbone, M.; Denielou, P.-M.; Mostrous, D.; Padovani, L.; Ravara, A.; Tuosto, E.; Torres Vieira, H.; Zavattaro, G. | DATE: 2016 | TITLE: Foundations of Session Types and Behavioural Contracts | REVUE: ACM Computing Surveys 49(1), 2016 | IDENTIFIANT: doi:10.1145/2873052 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-B-acyclicite-sessions.txt | SEGMENT: SEG-huttelFoundationsSessionTypes2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-B-acyclicite-sessions.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-garavelEquivalenceCheckingYears2022

    AUTHORS: Garavel, Hubert; Lang, Frederic | DATE: 2022 | TITLE: Equivalence Checking 40 Years After: A Review of Bisimulation Tools | REVUE: LNCS 13560, 2022 | IDENTIFIANT: doi:10.1007/978-3-031-15629-8_13 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-B-acyclicite-sessions.txt | SEGMENT: SEG-garavelEquivalenceCheckingYears2022 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-B-acyclicite-sessions.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-gotsmanProvingThatBlocking2009

    AUTHORS: Gotsman, A.; Cook, B.; Parkinson, M.; Vafeiadis, V. | DATE: 2009 | TITLE: Proving That Non-Blocking Algorithms Don't Block | REVUE: POPL 2009, 2009 | IDENTIFIANT: doi:10.1145/1480881.1480886 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-B-acyclicite-sessions.txt | SEGMENT: SEG-gotsmanProvingThatBlocking2009 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-B-acyclicite-sessions.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### niCertifiedAssemblyProgramming2006

    AUTHORS: Ni, Zhaozhong; Shao, Zhong | DATE: 2006 | TITLE: Certified Assembly Programming with Embedded Code Pointers | REVUE: POPL 2006, 2006 | IDENTIFIANT: doi:10.1145/1111037.1111066 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-B-acyclicite-sessions.txt | SEGMENT: SEG-niCertifiedAssemblyProgramming2006 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-B-acyclicite-sessions.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### mohammedDetectingNonConstantTime2018

    AUTHORS: *Detecting Non-Constant Time Code in Cryptography Libraries Using a Static Information Flow Analysis* | DATE: 2018 | TITLE: Detecting non-constant time code in cryptography libraries using a static information flow analysis | REVUE: Mohammed, Adam | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-analysis | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-russoSecuringInteractionBetween2006

    AUTHORS: Russo, Alejandro; Sabelfeld, Andrei | DATE: 2006 | TITLE: Securing Interaction between Threads and the Scheduler | REVUE: CSFW 2006, 2006 | IDENTIFIANT: doi:10.1109/CSFW.2006.29 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-russoSecuringInteractionBetween2006 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-russoSecurityMultithreadedPrograms2006

    AUTHORS: Russo, Alejandro; Sabelfeld, Andrei | DATE: 2006 | TITLE: Security for Multithreaded Programs under Cooperative Scheduling | REVUE: PSI 2006, LNCS 4378, 2007 | IDENTIFIANT: doi:10.1007/978-3-540-70881-0_43 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-russoSecurityMultithreadedPrograms2006 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-russoClosingInternalTiming2006

    AUTHORS: Russo, A.; Hughes, J.; Naumann, D.; Sabelfeld, A. | DATE: 2006 | TITLE: Closing Internal Timing Channels by Transformation | REVUE: ASIAN 2006, LNCS 4435, 2006 | IDENTIFIANT: doi:10.1007/978-3-540-77505-8_10 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-russoClosingInternalTiming2006 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### tsaiLibrarySecureMultithreaded2007

    AUTHORS: Tsai, Ta-chung; Russo, Alejandro; Hughes, John | DATE: 2007 | TITLE: A Library for Secure Multi-threaded Information Flow in Haskell | REVUE: CSF 2007, 2007 | IDENTIFIANT: doi:10.1109/CSF.2007.6 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-tsaiLibrarySecureMulti2007 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### zagieboyloUsingInformationFlow2019

    AUTHORS: Zagieboylo, Drew; Suh, G. Edward; Myers, Andrew C. | DATE: 2019 | TITLE: Using Information Flow to Design an ISA that Controls Timing Channels | REVUE: CSF 2019, 2019 | IDENTIFIANT: doi:10.1109/CSF.2019.00026 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-zagieboyloUsingInformationFlow2019 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-kashyapTimingTerminationSensitive2011

    AUTHORS: Kashyap, Vineeth; Wiedermann, Ben; Hardekopf, Ben | DATE: 2011 | TITLE: Timing- and Termination-Sensitive Secure Information Flow: Exploring a New Approach | REVUE: IEEE S&P 2011, 2011 | IDENTIFIANT: doi:10.1109/SP.2011.19 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-kashyapTimingTerminationSensitive2011 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-heiserTowardsProvableTiming2020

    AUTHORS: Heiser, Gernot; Murray, Toby; Klein, Gerwin | DATE: 2020 | TITLE: Towards Provable Timing-Channel Prevention | REVUE: ACM SIGOPS Operating Systems Review 54(1), 2020 | IDENTIFIANT: doi:10.1145/3421473.3421481 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-heiserTowardsProvableTiming2020 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### almeidaMatosTypingSecureInformation2006

    AUTHORS: *Typing Secure Information Flow: Declassification and Mobility* | DATE: 2006 | TITLE: Typing secure information flow: declassification and mobility | REVUE: Almeida Matos, Ana | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-mobility | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### banerjeeExpressiveDeclassificationPolicies2008

    AUTHORS: Banerjee, Anindya; Naumann, David A.; Rosenberg, Stan | DATE: 2008 | TITLE: Expressive Declassification Policies and Modular Static Enforcement | REVUE: IEEE S&P 2008, 2008 | IDENTIFIANT: doi:10.1109/SP.2008.20 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-banerjeeExpressiveDeclassificationPolicies2008 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-declassification

    AUTHORS: Rajani, Vineet; Coleman, Alex; Kanabar, Hrutvik | DATE | TITLE: A graded modal approach to relaxed semantic declassification | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec rajaniGradedModalRelaxed2025 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-declassification | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### abelGradedModalDependent2026

    AUTHORS: Abel, Andreas; Danielsson, Nils Anders; Eriksson, Oskar | DATE: 2026 | TITLE: A graded modal dependent type theory with erasure, formalized | REVUE: Journal of Functional Programming (version etendue), 2026 | IDENTIFIANT: arXiv:2603.29716 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-abelGradedModalDependent2026 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### schellingerhoutHigherAlgebraSimplicial2025

    AUTHORS: *Higher Algebra in Simplicial Homotopy Type Theory* | DATE: 2025 | TITLE: Higher algebra in simplicial homotopy type theory | REVUE: Schellingerhout, Rob | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-accessible

    AUTHORS: Felicissimo, T.; Leray, ?; Pujet, L.; Tabareau, N.; Tanter, E.; Winterhalter, T. | DATE | TITLE: Definitional Proof Irrelevance Made Accessible | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec felicissimoDefinitionalProofIrrelevance2025 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-accessible | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### huneauExploringBlurredChoice2025

    AUTHORS: *Exploring blurred choice axioms for constructive reverse mathematics* | DATE: 2025 | TITLE: Exploring blurred choice axioms for constructive reverse mathematics | REVUE: Huneau, Timothee; Forster, Yannick; Kirst, Dominik; van Gool, Sam | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-mathematics | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### forsterConstructiveMathematicsWithout2025

    AUTHORS: *Constructive mathematics without any choice* | DATE: 2025 | TITLE: Constructive mathematics without any choice | REVUE: Forster, Yannick; Kirst, Dominik | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-choice | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### quNaiveEncodingRussell2025

    AUTHORS: *A Naive Encoding of Russell's Paradox in Type Theory* | DATE: 2026 | TITLE: A Naive Encoding of Russell's Paradox in Type Theory | REVUE: Qu, Zhuoyuan | IDENTIFIANT: 10.48550/ARXIV.2601.00811 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-bryantTechniquesVerifiedPropositional2025

    AUTHORS: Bryant, Harry; Lawrence, Andrew; Seisenberger, Monika; Setzer, Anton | DATE: 2025 | TITLE: Techniques for Verified Propositional SMT Proof Checking | REVUE: Zenodo, 2025 | IDENTIFIANT: doi:10.5281/zenodo.15149629 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-bryantTechniquesVerifiedPropositional2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### ohlssonInformalizationAdvancedMathematics2025

    AUTHORS: *Informalization of Advanced Mathematics: A Case Study with Homotopy Type Theory* | DATE: 2025 | TITLE: Informalization of advanced mathematics: a case study with homotopy type theory | REVUE: Ohlsson, May; Ranta, Aarne | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### schonlankTowardsFaceTT2025

    AUTHORS: *Towards FaceTT: a generalization of intensional type systems with Glue* | DATE: 2025 | TITLE: Towards FaceTT: a generalization of intensional type systems with glue | REVUE: Schonlank, Tex; Nuyts, Andreas; Devriese, Dominique | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-glue | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### huaPolynomialFunctorsPiClans2025

    AUTHORS: *Polynomial functors in pi-clans for the semantics of type theory* | DATE: 2025 | TITLE: Polynomial functors in pi-clans for the semantics of type theory | REVUE: Hua, Joseph; Xu, Yiming | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### speightImpredicativeEncodingsLinear2025

    AUTHORS: *Impredicative Encodings of Linear Types* | DATE: 2025 | TITLE: Impredicative encodings of linear types | REVUE: Speight, Sam; van der Weide, Niels | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-types | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-computation

    AUTHORS: Pope, Jeremy | DATE | TITLE: An Intermediate Representation for Quantum Computation | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec popeIntermediateRepresentationQuantum2025 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-computation | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### wehrConstructiveReverseMathematics2025

    AUTHORS: *Constructive Reverse Mathematics of Cyclic Proof Theory* | DATE: 2025 | TITLE: Constructive reverse mathematics of cyclic proof theory | REVUE: Wehr, Dominik; Kirst, Dominik | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-analysis

    AUTHORS: Molena, Lorenzo; Turek-Grzybowski, Marcin Jan; Borsetto, Riccardo | DATE | TITLE: A Cubical Path from Algebra to Analysis | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec molenaCubicalPathAlgebra2025 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-analysis | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### swanCounterexamplesCubicalSets2025

    AUTHORS: *Counterexamples in Cubical Sets* | DATE: 2025 | TITLE: Counterexamples in cubical sets | REVUE: Swan, Andrew W. | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-sets | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### coquandCumulativeHierarchiesUniverses2025

    AUTHORS: *Cumulative hierarchies of universes and their equivalence in dependent type theory* | DATE: 2025 | TITLE: Cumulative hierarchies of universes and their equivalence in dependent type theory | REVUE: Coquand, Thierry; Sterbac, Raphael | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-marshallShortPaperGraded2023

    AUTHORS: Marshall, Daniel; Orchard, Dominic | DATE: 2023 | TITLE: Short Paper: Graded Modal Types for Integrity and Confidentiality | REVUE: PLAS 2023, 2023 | IDENTIFIANT: doi:10.1145/3623759.3624550 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-marshallShortPaperGraded2023 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### wangTypePurposeLimitation2023

    AUTHORS: *A Type System for Purpose Limitation* | DATE: 2023 | TITLE: A type system for purpose limitation | REVUE: Wang, Chengyuan | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-limitation | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-cortinasSimpleNoninterferenceNormalization2019

    AUTHORS: Tome Cortinas, Carlos; Valliappan, Nachiappan | DATE: 2019 | TITLE: Simple Noninterference by Normalization | REVUE: PLAS 2019, 2019 | IDENTIFIANT: doi:10.1145/3338504.3357342 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-cortinasSimpleNoninterferenceNormalization2019 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-fruminCompositionalInterferenceFine2021

    AUTHORS: Frumin, Dan; Krebbers, Robbert; Birkedal, Lars | DATE: 2021 | TITLE: Compositional Non-Interference for Fine-Grained Concurrent Programs | REVUE: IEEE S&P 2021, 2021 | IDENTIFIANT: doi:10.1109/SP40001.2021.00003 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-fruminCompositionalInterferenceFine2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-silverSemanticsNoninterferenceWith2023

    AUTHORS: Silver, Lucas; He, Paul; Cecchetti, Ethan; Hirsch, Andrew K.; Zdancewic, Steve | DATE: 2023 | TITLE: Semantics for Noninterference with Interaction Trees | REVUE: ECOOP 2023, 2023 | IDENTIFIANT: doi:10.4230/LIPIcs.ECOOP.2023.29 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-silverSemanticsNoninterferenceWith2023 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### yoshidaProgrammingLanguagesSystems2021

    AUTHORS: Yoshida, Nobuko (ed.) | DATE: 2021 | TITLE: Programming Languages and Systems - ESOP 2021 (actes, LNCS 12648) | REVUE: Springer, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-yoshidaProgrammingLanguagesSystems2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-abdullaDecidabilityVerificationUnder2021

    AUTHORS: Abdulla, P. A.; Atig, M. F.; Godbole, A.; Krishna, S.; Vafeiadis, V. | DATE: 2021 | TITLE: The Decidability of Verification under PS 2.0 | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_1 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-abdullaDecidabilityVerificationUnder2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### athaiyaDataFlowAnalysis2021

    AUTHORS: Athaiya, Snigdha; Komondoor, Raghavan; Narayan Kumar, K. | DATE: 2021 | TITLE: Data Flow Analysis of Asynchronous Systems using Infinite Abstract Domains | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_2 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-athaiyaDataFlowAnalysis2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### baillotTypesComplexityParallel2021

    AUTHORS: Baillot, Patrick; Ghyselen, Alexis | DATE: 2021 | TITLE: Types for Complexity of Parallel Computation in Pi-Calculus | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_3 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-baillotTypesComplexityParallel2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-beillahiCheckingRobustnessBetween2021

    AUTHORS: Beillahi, Sidi Mohamed; Bouajjani, Ahmed; Enea, Constantin | DATE: 2021 | TITLE: Checking Robustness Between Weak Transactional Consistency Models | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_4 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-beillahiCheckingRobustnessBetween2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### beringerVerifiedSoftwareUnits2021

    AUTHORS: Beringer, Lennart | DATE: 2021 | TITLE: Verified Software Units | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_5 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-beringerVerifiedSoftwareUnits2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### charetonAutomatedDeductiveVerification2021

    AUTHORS: Chareton, C.; Bardin, S.; Bobot, F.; Perrelle, V.; Valiron, B. | DATE: 2021 | TITLE: An Automated Deductive Verification Framework for Circuit-building Quantum Programs | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_6 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-charetonAutomatedDeductiveVerification2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### dasNestedSessionTypes2021

    AUTHORS: Das, Ankush; DeYoung, Henry; Mordido, Andreia; Pfenning, Frank | DATE: 2021 | TITLE: Nested Session Types | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_7 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-dasNestedSessionTypes2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### farinaCoupledRelationalSymbolic2021

    AUTHORS: Farina, Gian Pietro; Chong, Stephen; Gaboardi, Marco | DATE: 2021 | TITLE: Coupled Relational Symbolic Execution for Differential Privacy | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_8 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-farinaCoupledRelationalSymbolic2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### gaboardiGradedHoareLogic2021

    AUTHORS: Gaboardi, Marco; Katsumata, Shin-ya; Orchard, Dominic; Sato, Tetsuya | DATE: 2021 | TITLE: Graded Hoare Logic and its Categorical Semantics | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_9 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-gaboardiGradedHoareLogic2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-goldsteinJudgeTestCover2021

    AUTHORS: Goldstein, Harrison; Hughes, John; Lampropoulos, Leonidas; Pierce, Benjamin C. | DATE: 2021 | TITLE: Do Judge a Test by its Cover: Combining Combinatorial and Property-Based Testing | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_10 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-goldsteinJudgeTestCover2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-haslbeckDollarsMoreVerified2021

    AUTHORS: Haslbeck, Maximilian P. L.; Lammich, Peter | DATE: 2021 | TITLE: For a Few Dollars More: Verified Fine-Grained Algorithm Analysis Down to LLVM | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_11 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-haslbeckDollarsMoreVerified2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-ishShalomTimeComplexityBounds2021

    AUTHORS: Ish-Shalom, Oren; Itzhaky, Shachar; Rinetzky, Noam; Shoham, Sharon | DATE: 2021 | TITLE: Run-time Complexity Bounds Using Squeezers | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_12 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-ishShalomTimeComplexityBounds2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### jaberCompleteTraceModels2021

    AUTHORS: Jaber, Guilhem; Murawski, Andrzej S. | DATE: 2021 | TITLE: Complete trace models of state and control | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_13 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-jaberCompleteTraceModels2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### lundenCorrectnessSequentialMonte2021

    AUTHORS: Lunden, Daniel; Borgstrom, Johannes; Broman, David | DATE: 2021 | TITLE: Correctness of Sequential Monte Carlo Inference for Probabilistic Programming Languages | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_15 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-lundenCorrectnessSequentialMonte2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### makDensitiesAlmostSurely2021

    AUTHORS: Mak, Carol; Ong, C.-H. Luke; Paquet, Hugo; Wagner, Dominik | DATE: 2021 | TITLE: Densities of Almost Surely Terminating Probabilistic Programs are Differentiable Almost Everywhere | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_16 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-makDensitiesAlmostSurely2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### moosbruggerAutomatedTerminationAnalysis2021

    AUTHORS: Moosbrugger, Marcel; Bartocci, Ezio; Katoen, Joost-Pieter; Kovacs, Laura | DATE: 2021 | TITLE: Automated Termination Analysis of Polynomial Probabilistic Programs | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_18 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-moosbruggerAutomatedTerminationAnalysis2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### paquetBayesianStrategiesProbabilistic2021

    AUTHORS: Paquet, Hugo | DATE: 2021 | TITLE: Bayesian strategies: probabilistic programs as generalised graphical models | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_19 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-paquetBayesianStrategiesProbabilistic2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### jaberTemporalRefinementsGuarded2021

    AUTHORS: Jaber, Guilhem; Riba, Colin | DATE: 2021 | TITLE: Temporal Refinements for Guarded Recursive Types | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_20 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-jaberTemporalRefinementsGuarded2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-ricciottiQueryLiftingLanguage2021

    AUTHORS: Ricciotti, Wilmer; Cheney, James | DATE: 2021 | TITLE: Query Lifting: Language-integrated query for heterogeneous nested collections | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_21 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-ricciottiQueryLiftingLanguage2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-vakarReverseHigherTypes2021

    AUTHORS: Vakar, Matthijs | DATE: 2021 | TITLE: Reverse AD at Higher Types: Pure, Principled and Denotationally Correct | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_22 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-vakarReverseHigherTypes2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### youSoundCompleteConcolic2021

    AUTHORS: You, Shu-Hung; Findler, Robert Bruce; Dimoulas, Christos | DATE: 2021 | TITLE: Sound and Complete Concolic Testing for Higher-order Functions | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_23 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-youSoundCompleteConcolic2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-pagelStrongSeparationLogic2021

    AUTHORS: Pagel, Jens; Zuleger, Florian | DATE: 2021 | TITLE: Strong-Separation Logic | REVUE: ESOP 2021, 2021 | IDENTIFIANT: doi:10.1007/978-3-030-72019-3_24 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/lot-J-confidentialite.txt | SEGMENT: SEG-pagelStrongSeparationLogic2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/lot-J-confidentialite.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### barszczTyperClassePolymorphisme2021

    AUTHORS: Barszcz, Jean-Alexandre | DATE: 2021 | TITLE: Typer a de la classe : le polymorphisme ad hoc dans un langage avec des types dependants et de la metaprogrammation | REVUE: Universite de Montreal, 2021 | IDENTIFIANT: url:https://papyrus.bib.umontreal.ca/ | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-barszczTyperClassePolymorphisme2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### melesApprochePhilologiqueLangages2016

    AUTHORS: Meles, Baptiste | DATE: 2016 | TITLE: Approche philologique des langages de programmation | REVUE: Technique et Science Informatiques 35(2), 2016 | IDENTIFIANT: doi:10.3166/tsi.35.237-254 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-melesApprochePhilologiqueLangages2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### fontaineProgrammationDespaceIntelligent2012

    AUTHORS: *Programmation d'espace intelligent par l'utilisateur final* | DATE: 2012 | TITLE: Programmation d'espace intelligent par l'utilisateur final | REVUE: Fontaine, Emeric | IDENTIFIANT: 10.70675/79b926edz3ba5z48d5zb863z6fa92dbe4a36 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-final | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### yakdanHelpingJohnnyAnalyze2016

    AUTHORS: Yakdan, K.; Dechand, S.; Gerhards-Padilla, E.; Smith, M. | DATE: 2016 | TITLE: Helping Johnny to Analyze Malware: A Usability-Optimized Decompiler and Malware Analysis User Study | REVUE: IEEE S&P 2016, 2016 | IDENTIFIANT: doi:10.1109/SP.2016.18 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-yakdanHelpingJohnnyAnalyze2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### stefikEmpiricalStudiesProgramming2011

    AUTHORS: Stefik, A.; Gellenbeck, E. | DATE: 2011 | TITLE: Empirical studies on programming language stimuli | REVUE: Software Quality Journal 19(1), 2011 | IDENTIFIANT: doi:10.1007/s11219-010-9106-7 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-stefikEmpiricalStudiesProgramming2011 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### detienneConceptionReutilisationLogiciels1996

    AUTHORS: Detienne, Francoise | DATE: 1996 | TITLE: La conception et reutilisation de logiciels : l'approche de l'Ergonomie Cognitive | REVUE: INRIA RR-2902, 1996 | IDENTIFIANT: url:https://inria.hal.science/inria-00073807 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-detienneConceptionReutilisationLogiciels1996 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### depazRoleAestheticsUnderstanding2023

    AUTHORS: Depaz, Pierre | DATE: 2023 | TITLE: The role of aesthetics in understanding source code | REVUE: Universite Sorbonne Nouvelle (ED120 - THALIM), 2023 | IDENTIFIANT: url:https://gitlab.com/periode/thesis | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-depazRoleAestheticsUnderstanding2023 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### srbHaskellLikeSExpression2015

    AUTHORS: *Haskell-Like S-Expression-Based Language Designed for an IDE* | DATE: 2015 | TITLE: Haskell-like S-expression-based language designed for an IDE | REVUE: Srb, Michal | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-iDE | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-syntax

    AUTHORS: Palmer, James Dean | DATE | TITLE: Ginger: Implementing a new Lisp family syntax | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-syntax | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### bradyDriftScriptDomainspecificLanguage2026

    AUTHORS: Brady, Seamus | DATE: 2026 | TITLE: DriftScript: A Domain-Specific Language for Programming Non-Axiomatic Reasoning Agents | REVUE: arXiv, 2026 | IDENTIFIANT: arXiv:2604.00043 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-bradyDriftscriptDomainSpecific2026 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-composition

    AUTHORS: Scudder, Jeffrey Alan | DATE | TITLE: KidLisp: A Minimal Lisp for Generative Art with Social Composition | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-composition | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### mohammadiPelProgrammingLanguage2025

    AUTHORS: *Pel: A Programming Language for Orchestrating AI Agents* | DATE: 2025 | TITLE: Pel: a programming language for orchestrating AI agents | REVUE: Mohammadi, Behnam | IDENTIFIANT: 10.2139/ssrn.5202892 | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-agents | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-ullrichBeyondNotationsHygienic2022

    AUTHORS: Ullrich, Sebastian; de Moura, Leonardo | DATE: 2022 | TITLE: Beyond Notations: Hygienic Macro Expansion for Theorem Proving Languages | REVUE: Logical Methods in Computer Science 18(2), 2022 | IDENTIFIANT: doi:10.46298/lmcs-18(2:1)2022 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-ullrichBeyondNotationsHygienic2022 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-language

    AUTHORS: Liu, Xiao; Wu, Dinghao | DATE | TITLE: From Natural Language to Programming Language | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec liuFromNaturalLanguage2019 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-language | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-schanzerAccessibleBasedProgramming2019

    AUTHORS: Schanzer, E.; Bahram, S.; Krishnamurthi, S. | DATE: 2019 | TITLE: Accessible AST-Based Programming for Visually-Impaired Programmers | REVUE: SIGCSE 2019, 2019 | IDENTIFIANT: doi:10.1145/3287324.3287499 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-schanzerAccessibleBasedProgramming2019 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-bellVisualizingSonifyingAbstract2025

    AUTHORS: Bell, J.; Deschamps, A.; Kapoor, E.; Karki, S.; Kim, J.; Moreno Gonzalez, N.; Pitchford, W.; Sturua, E.; Wade, C. | DATE: 2025 | TITLE: Visualizing and Sonifying Abstract Syntax Trees for Accessibility | REVUE: ACM, 2025 | IDENTIFIANT: doi:10.1145/3770761.3777158 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-bellVisualizingSonifyingAbstract2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### rivestSimplePublicKey2025

    AUTHORS: Rivest, R.; Eastlake 3rd, D. | DATE: 2025 | TITLE: Simple Public Key Infrastructure (SPKI) S-Expressions (RFC 9804) | REVUE: IETF, 2025 | IDENTIFIANT: doi:10.17487/RFC9804 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-rivestSimplePublicInfrastructure2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-bannisterConfluentOrthogonalDrawings2016

    AUTHORS: Bannister, M. J.; Brown, D. A.; Eppstein, D. | DATE: 2016 | TITLE: Confluent Orthogonal Drawings of Syntax Diagrams | REVUE: arXiv / GD 2016, 2015 | IDENTIFIANT: arXiv:1509.00818 | REF.BIB: nil | RDF: t — apparié le 3 septembre avec bannisterConfluentOrthogonalDrawings2015 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-bannisterConfluentOrthogonalDrawings2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### amonCreatingHumanReadable2020

    AUTHORS: Amon, Tod; Loffredo, Tim | DATE: 2020 | TITLE: Creating Human Readable Path Constraints from Symbolic Execution | REVUE: NDSS BAR 2020, 2020 | IDENTIFIANT: doi:10.14722/bar.2020.23006 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-amonCreatingHumanReadable2020 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### moldovanAutoGraphImperativestyleCoding2018

    AUTHORS: Moldovan, D.; Decker, J. M.; Wang, F.; Johnson, A. A.; Lee, B. K.; Nado, Z.; Sculley, D.; Rompf, T.; Wiltschko, A. B. | DATE: 2019 | TITLE: AutoGraph: Imperative-style Coding with Graph-based Performance | REVUE: SysML 2019, 2019 | IDENTIFIANT: arXiv:1810.08061 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-moldovanAutographImperativeStyle2019 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-marronTowardProgrammingLanguages2023

    AUTHORS: Marron, Mark | DATE: 2023 | TITLE: Toward Programming Languages for Reasoning: Humans, Symbolic Systems, and AI Agents | REVUE: Onward! 2023, 2023 | IDENTIFIANT: doi:10.1145/3622758.3622895 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-marronTowardProgrammingLanguages2023 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-weidmannBridgingSyntaxSemantics2022

    AUTHORS: Weidmann, T. B.; Thorgeirsson, S.; Su, Z. | DATE: 2022 | TITLE: Bridging the Syntax-Semantics Gap of Programming | REVUE: Onward! 2022, 2022 | IDENTIFIANT: doi:10.1145/3563835.3567668 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-weidmannBridgingSyntaxSemantics2022 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-marceauValuesGrowTrees2011

    AUTHORS: Marceau, G.; Fisler, K.; Krishnamurthi, S. | DATE: 2011 | TITLE: Do Values Grow on Trees? Expression Integrity in Functional Programming | REVUE: ICER 2011, 2011 | IDENTIFIANT: doi:10.1145/2016911.2016926 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-marceauValuesGrowTrees2011 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### vernaHDRDynamicProgramming2020

    AUTHORS: Verna, Didier | DATE: 2020 | TITLE: (Dynamic (programming paradigms)) Performance and expressivity | REVUE: LRDE / EPITA (HDR), 2020 | IDENTIFIANT: url:https://hal.science/hal-02988180v1 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-vernaDynamicProgrammingParadigms2020 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### saiuGNUEpsilon2012

    AUTHORS: Saiu, Luca | DATE: 2012 | TITLE: GNU epsilon: an extensible programming language | REVUE: Universite Paris 13 / Paris Nord, 2012 | IDENTIFIANT: url:https://theses.hal.science/tel-00702922 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-saiuEpsilonExtensibleProgramming2012 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### thorgeirssonElectroencephalographyStudyCognitive2024

    AUTHORS: Thorgeirsson, S.; Zhang, C.; Weidmann, T. B.; Weidmann, K.-H.; Su, Z. | DATE: 2024 | TITLE: An Electroencephalography Study on Cognitive Load in Visual and Textual Programming | REVUE: ICER 2024, 2024 | IDENTIFIANT: doi:10.1145/3632620.3671124 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-thorgeirssonElectroencephalographyStudyCognitive2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### coblenzInterdisciplinaryProgrammingLanguage2018

    AUTHORS: Coblenz, M.; Aldrich, J.; Myers, B. A.; Sunshine, J. | DATE: 2018 | TITLE: Interdisciplinary Programming Language Design | REVUE: Onward! 2018, 2018 | IDENTIFIANT: doi:10.1145/3276954.3276965 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-coblenzInterdisciplinaryProgrammingLanguage2018 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-notations

    AUTHORS: Green, Thomas R. G. | DATE | TITLE: Cognitive Dimensions of Notations | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec greenCognitiveDimensionsNotations1989 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-notations | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-weidmannElephantSyntaxComparative2025

    AUTHORS: Weidmann, T. B.; Thorgeirsson, S.; Weidmann, K.-H.; Wang, A. Y.; Su, Z. | DATE: 2025 | TITLE: The Elephant in the Syntax: A Comparative Study of Semantics-First, Block-Based, and Textual Programming | REVUE: ACM, 2025 | IDENTIFIANT: doi:10.1145/3772318.3791667 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-weidmannElephantSyntaxComparative2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### myersUsabilityProgrammingLanguages2016

    AUTHORS: Myers, B. A.; Burnett, M.; Stefik, A.; et al. | DATE: 2016 | TITLE: Usability of Programming Languages: Special Interest Group (SIG) meeting at CHI 2016 | REVUE: CHI 2016 Extended Abstracts, 2016 | IDENTIFIANT: doi:10.1145/2851581.2886434 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-myersUsabilityProgrammingLanguages2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-alexandronScenarioBasedProgramming2014

    AUTHORS: Alexandron, G.; Armoni, M.; Gordon, M.; Harel, D. | DATE: 2014 | TITLE: Scenario-Based Programming: Reducing the Cognitive Load, Fostering Abstract Thinking | REVUE: ICSE Companion 2014, 2014 | IDENTIFIANT: doi:10.1145/2591062.2591167 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/N-ergonomie-esthetique.txt | SEGMENT: SEG-alexandronScenarioBasedProgramming2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/N-ergonomie-esthetique.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### mostrousAffineSessions2014

    AUTHORS: Mostrous, Dimitris; Vasconcelos, Vasco Thudichum | DATE: 2014 | TITLE: Affine Sessions | REVUE: COORDINATION 2014, 2014 | IDENTIFIANT: doi:10.1007/978-3-662-43376-8_8 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-mostrousAffineSessions2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### castagnaFoundationsSessionTypes2009

    AUTHORS: Castagna, G.; Dezani-Ciancaglini, M.; Giachino, E.; Padovani, L. | DATE: 2009 | TITLE: Foundations of Session Types | REVUE: PPDP 2009, 2009 | IDENTIFIANT: doi:10.1145/1599410.1599437 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-castagnaFoundationsSessionTypes2009 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-bauerHottLibraryFormalization2017

    AUTHORS: Bauer, A.; Gross, J.; Lumsdaine, P. L.; Shulman, M.; Sozeau, M.; Spitters, B. | DATE: 2017 | TITLE: The HoTT Library: A formalization of homotopy type theory in Coq | REVUE: CPP 2017, 2017 | IDENTIFIANT: doi:10.1145/3018610.3018615 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-bauerHottLibraryFormalization2017 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-resolution

    AUTHORS: Laparra, Egoitz; Rigau, German | DATE | TITLE: Sources of Evidence for Implicit Argument Resolution | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec laparraSourcesEvidence2013 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-resolution | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-modularity

    AUTHORS: Dreyer, Derek | DATE | TITLE: Thesis Proposal: Effective Type Theory for Modularity | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-modularity | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### sterlingLogicalRelationsTypes2021

    AUTHORS: Sterling, Jonathan; Harper, Robert | DATE: 2021 | TITLE: Logical Relations as Types: Proof-Relevant Parametricity for Program Modules | REVUE: Journal of the ACM 68(6), 2021 | IDENTIFIANT: doi:10.1145/3474834 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-sterlingLogicalRelationsTypes2021 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### fuProofRelevantCorecursive2016

    AUTHORS: Fu, P.; Komendantskaya, E.; Schrijvers, T.; Pond, A. | DATE: 2016 | TITLE: Proof Relevant Corecursive Resolution | REVUE: FLOPS 2016, 2016 | IDENTIFIANT: doi:10.1007/978-3-319-29604-3_9 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-fuProofRelevantCorecursive2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-gonthierMakeProofAutomation2011

    AUTHORS: Gonthier, G.; Ziliani, B.; Nanevski, A.; Dreyer, D. | DATE: 2011 | TITLE: How to Make Ad Hoc Proof Automation Less Ad Hoc | REVUE: ICFP 2011, 2011 | IDENTIFIANT: doi:10.1145/2034773.2034798 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/Q4ter-sessions-sous-typage.txt | SEGMENT: SEG-gonthierMakeProofAutomation2011 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/Q4ter-sessions-sous-typage.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-poulsenHeftyAlgebrasModular2025

    AUTHORS: Bach Poulsen, Casper; van der Rest, Cas | DATE: 2025 | TITLE: Hefty Algebras: Modular Elaboration of Higher-Order Effects | REVUE: Journal of Functional Programming 35, 2025 | IDENTIFIANT: doi:10.1017/S0956796825100142 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/S1-hefty-algebras-JFP.txt | SEGMENT: SEG-poulsenHeftyAlgebrasModular2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/S1-hefty-algebras-JFP.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-matacheScopedEffectsParameterized2024

    AUTHORS: Matache, C.; Lindley, S.; Moss, S.; Staton, S.; Wu, N.; Yang, Z. | DATE: 2024 | TITLE: Scoped Effects as Parameterized Algebraic Theories | REVUE: ESOP 2024, 2024 | IDENTIFIANT: doi:10.1007/978-3-031-57262-3_1 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/S1-scoped-effects-theories-algebriques-parametrees.txt | SEGMENT: SEG-matacheScopedEffectsParameterized2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/S1-scoped-effects-theories-algebriques-parametrees.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-bonnaireSergeantPracticalOptionalTypes2016

    AUTHORS: Bonnaire-Sergeant, A.; Davies, R.; Tobin-Hochstadt, S. | DATE: 2016 | TITLE: Practical Optional Types for Clojure | REVUE: ESOP 2016, 2016 | IDENTIFIANT: doi:10.1007/978-3-662-49498-1_4 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/S3-typed-clojure-esop16.txt | SEGMENT: SEG-bonnaireSergeantPracticalOptionalTypes2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/S3-typed-clojure-esop16.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### kiczalesMOPConcepts1991

    AUTHORS: Kiczales, G.; des Rivieres, J.; Bobrow, D. G. | DATE: 1991 | TITLE: MOP: Concepts (The Art of the Metaobject Protocol, chapitre en ligne) | REVUE: ALU / MIT Press, 1991 | IDENTIFIANT: url:http://mop.lisp.se/www.alu.org/mop/concepts.html | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/S4-mop-concepts.txt | SEGMENT: SEG-kiczalesConceptsMetaobjectProtocol1991 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/S4-mop-concepts.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### hondaMultipartyAsynchronousSession2008

    AUTHORS: Honda, Kohei; Yoshida, Nobuko; Carbone, Marco | DATE: 2008 | TITLE: Multiparty Asynchronous Session Types | REVUE: POPL 2008, 2008 | IDENTIFIANT: doi:10.1145/1328438.1328472 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-hondaMultipartyAsynchronousSession2008 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### nanjoFixpointLogicDependent2018

    AUTHORS: Nanjo, Y.; Unno, H.; Koskinen, E.; Terauchi, T. | DATE: 2018 | TITLE: A Fixpoint Logic and Dependent Effects for Temporal Property Verification | REVUE: LICS 2018, 2018 | IDENTIFIANT: doi:10.1145/3209108.3209204 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-nanjoFixpointLogicDependent2018 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-heintzeSlamCalculusProgramming1998

    AUTHORS: Heintze, Nevin; Riecke, Jon G. | DATE: 1998 | TITLE: The SLam Calculus: Programming with Secrecy and Integrity | REVUE: POPL 1998, 1998 | IDENTIFIANT: doi:10.1145/268946.268976 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-heintzeSlamCalculusProgramming1998 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-smithTypeSystemSecure2001

    AUTHORS: Smith, Geoffrey | DATE: 2001 | TITLE: A New Type System for Secure Information Flow | REVUE: CSFW 2001, 2001 | IDENTIFIANT: doi:10.1109/CSFW.2001.930141 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-smithTypeSystemSecure2001 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### smithSecureInformationFlow1998

    AUTHORS: Smith, Geoffrey; Volpano, Dennis | DATE: 1998 | TITLE: Secure Information Flow in a Multi-threaded Imperative Language | REVUE: POPL 1998, 1998 | IDENTIFIANT: doi:10.1145/268946.268975 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-smithSecureInformationFlow1998 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### bizjakGuardedDependentType2016

    AUTHORS: Bizjak, A.; Grathwohl, H. B.; Clouston, R.; Mogelberg, R. E.; Birkedal, L. | DATE: 2016 | TITLE: Guarded Dependent Type Theory with Coinductive Types | REVUE: FoSSaCS 2016, 2016 | IDENTIFIANT: doi:10.1007/978-3-662-49630-5_2 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-bizjakGuardedDependentType2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-boulierNextSyntacticalModels2017

    AUTHORS: Boulier, Simon; Pedrot, Pierre-Marie; Tabareau, Nicolas | DATE: 2017 | TITLE: The Next 700 Syntactical Models of Type Theory | REVUE: CPP 2017, 2017 | IDENTIFIANT: doi:10.1145/3018610.3018620 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-boulierNextSyntacticalModels2017 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### leijenTypeDirectedCompilation2017

    AUTHORS: Leijen, Daan | DATE: 2017 | TITLE: Type Directed Compilation of Row-Typed Algebraic Effects | REVUE: POPL 2017, 2017 | IDENTIFIANT: doi:10.1145/3009837.3009872 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-leijenTypeDirectedCompilation2017 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-jeffreyTypesLinearTime2012

    AUTHORS: Jeffrey, Alan | DATE: 2012 | TITLE: LTL Types FRP: Linear-time Temporal Logic Propositions as Types, Proofs as Functional Reactive Programs | REVUE: PLPV 2012, 2012 | IDENTIFIANT: doi:10.1145/2103776.2103783 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-jeffreyTypesLinearTime2012 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### blutEntropicHopfAlgebras2002

    AUTHORS: Blute, Richard F.; Lamarche, Francois; Ruet, Paul | DATE: 2002 | TITLE: Entropic Hopf Algebras and Models of Non-Commutative Logic | REVUE: Theory and Applications of Categories 10(17), 2002 | IDENTIFIANT: url:http://www.tac.mta.ca/tac/volumes/10/17/10-17abs.html | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-bluteEntropicHopfAlgebras2002 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-swamyDependentTypesMulti2016

    AUTHORS: Swamy, N.; Hritcu, C.; Keller, C.; Rastogi, A.; Delignat-Lavaud, A.; Forest, S.; Bhargavan, K.; Fournet, C.; Strub, P.-Y.; Kohlweiss, M.; Zinzindohoue, J.-K.; Zanella-Beguelin, S. | DATE: 2016 | TITLE: Dependent Types and Multi-monadic Effects in F | REVUE: POPL 2016, 2016 | IDENTIFIANT: doi:10.1145/2837614.2837655 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-swamyDependentTypesMulti2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### lionTimeAwareCompilation2025

    AUTHORS: Lion, Benjamin; Nowak, David | DATE: 2025 | TITLE: Time Aware Compilation Verified: A Category-Theoretic Approach in Rocq | REVUE: ACM (ICFP/OOPSLA), 2025 | IDENTIFIANT: doi:10.1145/3742875.3754693 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-lionTimeAwareCompilation2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### erneTensorProductsRelation2016

    AUTHORS: Erne, Marcel; Picado, Jorge | DATE: 2016 | TITLE: Tensor Products and Relation Quantales | REVUE: arXiv, 2016 | IDENTIFIANT: arXiv:1612.05694 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: corpus/T-39-temps-quantales-coeffets.txt | SEGMENT: SEG-erneTensorProductsRelation2016 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier corpus/T-39-temps-quantales-coeffets.txt. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-fredrikssonTowardsNativeHigher2014

    AUTHORS: Fredriksson, Olle; Ghica, Dan R.; Wheen, Bertram | DATE: 2014 | TITLE: Towards native higher-order remote procedure calls | REVUE: IFL 2014, 2015 | IDENTIFIANT: doi:10.1145/2746325.2746332 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q1-Composition-des-modalités.pdf | SEGMENT: SEG-fredrikssonTowardsNativeHigher2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q1-Composition-des-modalités.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### gengFormalizationOpaqueDefinitions2025

    AUTHORS: *Formalization of Opaque Definitions for a Dependent Type Theory* | DATE: 2025 | TITLE: Formalization of opaque definitions for a dependent type theory | REVUE: Geng, Eve | IDENTIFIANT: 10.1145/3759538.3759653 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q1-Composition-des-modalités.pdf | SEGMENT: SEG-theory | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q1-Composition-des-modalités.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### chenSynQEmbeddedDSL2025

    AUTHORS: Chen, Rui; Sander, Ingo | DATE: 2025 | TITLE: SynQ: An Embedded DSL for Synchronous System Design with Quantitative Types | REVUE: arXiv, 2025 | IDENTIFIANT: arXiv:2505.02883 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q1-Composition-des-modalités.pdf | SEGMENT: SEG-chenSynqEmbeddedSynchronous2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q1-Composition-des-modalités.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### demuijnck-hughesTypeTheoryLanguage2023

    AUTHORS: de Muijnck-Hughes, Jan; Allais, Guillaume; Brady, Edwin | DATE: 2023 | TITLE: Type Theory as a Language Workbench | REVUE: arXiv / EVCS 2023, 2023 | IDENTIFIANT: arXiv:2301.12852 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q1-Composition-des-modalités.pdf | SEGMENT: SEG-muijnckHughesTypeTheoryLanguage2023 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q1-Composition-des-modalités.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-biendarraFoundationalDatatypesRecursion2017

    AUTHORS: Biendarra, J.; Blanchette, J. C.; Bouzy, A.; Desharnais, M.; Fleury, M.; Holzl, J.; Kuncar, O.; Lochbihler, A.; Meier, F.; Panny, L.; Popescu, A.; Sternagel, C.; Thiemann, R.; Traytel, D. | DATE: 2017 | TITLE: Foundational (Co)datatypes and (Co)recursion for Higher-Order Logic | REVUE: FroCoS 2017, 2017 | IDENTIFIANT: doi:10.1007/978-3-319-66167-4_1 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q2-Frontière-Algèbre-Coalgèbre.pdf | SEGMENT: SEG-biendarraFoundationalDatatypesRecursion2017 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q2-Frontière-Algèbre-Coalgèbre.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### longMutationLocalExplicit2026

    AUTHORS: *Mutation Is Local and Explicit: Controlled Effects and Linear Ownership in the Japl Programming Language* | DATE: 2026 | TITLE: Mutation is local and explicit: controlled effects and linear ownership in the japl programming language | REVUE: Long, Matthew | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-language | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### krishnanStructureValue2026

    AUTHORS: *On the Structure of Value: Value, Information, and the Cartesian Degeneracy* | DATE: 2026 | TITLE: On the structure of value: value, information, and the cartesian degeneracy | REVUE: Krishnan, Anantha | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-value | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### arntzenius2025FiniteFunctionalProgramming

    AUTHORS: *Finite Functional Programming, or, LAMBDA: The Ultimate Predicate* | DATE: 2025 | TITLE: Finite functional programming, or, LAMBDA: the ultimate predicate | REVUE: Arntzenius, Michael; Willsey, Max | IDENTIFIANT: 10.1007/978-981-92-0184-6_1 | REF.BIB: nil | RDF: t | PDF: nil | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-programming | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-bottoniStrategiesSpatioTemporal2024

    AUTHORS: Bottoni, Paolo; Labella, Anna; Perelli, Giuseppe | DATE: 2024 | TITLE: Strategies in Spatio-Temporal Logics for Multi-agent Systems | REVUE: Springer LNCS, 2024 | IDENTIFIANT: doi:10.1007/978-3-031-73709-1_18 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-bottoniStrategiesSpatioTemporal2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### schreiberQuantizationLinearHomotopy2014

    AUTHORS: Schreiber, Urs | DATE: 2014 | TITLE: Quantization via Linear Homotopy Types | REVUE: arXiv, 2014 | IDENTIFIANT: arXiv:1402.7041 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-schreiberQuantizationLinearHomotopy2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### ikonicoffCartesianDifferentialComonads2021

    AUTHORS: Ikonicoff, Sacha; Lemay, Jean-Simon Pacaud | DATE: 2023 | TITLE: Cartesian Differential Comonads and New Models of Cartesian Differential Categories | REVUE: arXiv, 2023 | IDENTIFIANT: arXiv:2108.04304 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-ikonicoffCartesianDifferentialComonads2023 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### kavvosTwoDimensionalKripke2024

    AUTHORS: Kavvos, G. A. | DATE: 2024 | TITLE: Two-dimensional Kripke Semantics II: Stability and Completeness | REVUE: MFPS 2024 (ENTICS vol. 4), 2024 | IDENTIFIANT: url:https://entics.episciences.org | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-kavvosDimensionalKripkeSemantics2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-melliesAsynchronousGamesFully2005

    AUTHORS: Mellies, Paul-Andre | DATE: 2005 | TITLE: Asynchronous Games 4: A Fully Complete Model of Propositional Linear Logic | REVUE: LICS 2005, 2005 | IDENTIFIANT: doi:10.1109/LICS.2005.6 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-melliesAsynchronousGamesFully2005 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### selingerBriefSurveyQuantum2004

    AUTHORS: Selinger, Peter | DATE: 2004 | TITLE: A Brief Survey of Quantum Programming Languages | REVUE: FLOPS 2004, 2004 | IDENTIFIANT: doi:10.1007/978-3-540-24754-8_1 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-selingerBriefSurveyQuantum2004 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### baezPhysicsTopologyLogic2009

    AUTHORS: Baez, John C.; Stay, Mike | DATE: 2009 | TITLE: Physics, Topology, Logic and Computation: A Rosetta Stone | REVUE: arXiv, 2009 | IDENTIFIANT: arXiv:0903.0340 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-baezPhysicsTopologyLogic2009 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-lineaires

    AUTHORS: Kerjean, Marie | DATE | TITLE: Espaces reflexifs de fonctions lisses : un compte rendu logique des equations aux derivees partielles lineaires | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-lineaires | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-hylandGamesGraphsSequentially2002

    AUTHORS: Hyland, Martin; Schalk, Andrea | DATE: 2002 | TITLE: Games on Graphs and Sequentially Realizable Functionals (Extended Abstract) | REVUE: LICS 2002, 2002 | IDENTIFIANT: doi:10.1109/LICS.2002.1029828 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-hylandGamesGraphsSequentially2002 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### ehrhardBayesianNetworksProofnets2024

    AUTHORS: Ehrhard, Thomas; Faggian, Claudia; Pagani, Michele | DATE: 2024 | TITLE: Bayesian Networks and Proof-Nets: a proof-theoretical account of Bayesian Inference | REVUE: arXiv, 2024 | IDENTIFIANT: arXiv:2412.20540 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-ehrhardBayesianNetworksProof2024 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-ehrigRoleCategoryTheory1995

    AUTHORS: Ehrig, Hartmut; Grosse-Rhode, Martin; Wolter, Uwe | DATE: 1995 | TITLE: On the Role of Category Theory in the Area of Algebraic Specifications | REVUE: WADT 1995, LNCS 1130, 1996 | IDENTIFIANT: doi:10.1007/3-540-61629-2_31 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-ehrigRoleCategoryTheory1995 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### bonchiTapeDiagramsMonoidal2025

    AUTHORS: Bonchi, Filippo; Cioffo, Cipriano Junior; Di Giorgio, Alessandro; Di Lavore, Elena | DATE: 2025 | TITLE: Tape Diagrams for Monoidal Monads | REVUE: arXiv, 2025 | IDENTIFIANT: arXiv:2503.22819 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-bonchiTapeDiagramsMonoidal2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### pascucciCompositionCorrectness2019

    AUTHORS: *Composition and Correctness of Heterogeneous Planning Systems* | DATE: 2019 | TITLE: Composition and correctness of heterogeneous planning systems | REVUE: Pascucci, Nicholas | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-systems | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### lemayPropertiesCharacterisationsCofree2022

    AUTHORS: Lemay, Jean-Simon Pacaud | DATE: 2025 | TITLE: Properties and Characterisations of Cofree Cartesian Differential Categories | REVUE: arXiv, 2025 | IDENTIFIANT: arXiv:2210.13886 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-lemayPropertiesCharacterisationsCofree2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-abstract

    AUTHORS: Benaissa, Zine El-Abidine; Moggi, Eugenio; Taha, Walid; Sheard, Tim | DATE | TITLE: A Categorical Analysis of Multi-Level Languages (Extended Abstract) | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec benaissaCategoricalAnalysis1998 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-abstract | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-stehrRewritingLogicUnifying2128

    AUTHORS: Stehr, Mark-Oliver; Meseguer, Jose; Olveczky, Peter Csaba | DATE: 2128 | TITLE: Rewriting Logic as a Unifying Framework for Petri Nets | REVUE: LNCS 2128, 2001 | IDENTIFIANT: doi:10.1007/3-540-45541-8_9 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-stehrRewritingLogicUnifying2128 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### barbarossaDialecticaDifferentiation2025

    AUTHORS: *On Dialectica and Differentiation, via Categories* | DATE: 2025 | TITLE: On dialectica and differentiation, via categories | REVUE: Barbarossa, Davide | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-differentiation | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### baltagDynamiclogicalPerspectiveQuantum2008

    AUTHORS: Baltag, Alexandru; Smets, Sonja | DATE: 2008 | TITLE: A Dynamic-Logical Perspective on Quantum Behavior | REVUE: Studia Logica 89(2), 2008 | IDENTIFIANT: doi:10.1007/s11225-008-9126-5 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-baltagDynamicLogicalPerspective2008 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### ehrigApplicationsCategoryTheory1998

    AUTHORS: Ehrig, Hartmut; Grosse-Rhode, Martin; Wolter, Uwe | DATE: 1998 | TITLE: Applications of Category Theory to the Area of Algebraic Specification in Computer Science | REVUE: Applied Categorical Structures 6(1), 1998 | IDENTIFIANT: doi:10.1023/A:1008688122154 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-ehrigApplicationsCategoryTheory1998 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-oHearnObjectsInterferenceYoneda1995

    AUTHORS: O'Hearn, Peter W.; Reddy, Uday S. | DATE: 1995 | TITLE: Objects, Interference, and the Yoneda Embedding | REVUE: Electronic Notes in Theoretical Computer Science 1, 1995 | IDENTIFIANT: doi:10.1016/S1571-0661(04)00013-6 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-oHearnObjectsInterferenceYoneda1995 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### laudaFrobeniusAlgebrasPlanar2005

    AUTHORS: Lauda, Aaron D. | DATE: 2005 | TITLE: Frobenius algebras and planar open string topological field theories | REVUE: arXiv, 2005 | IDENTIFIANT: arXiv:math/0508349 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf | SEGMENT: SEG-laudaFrobeniusAlgebrasPlanar2005 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q3-GestionEtatGlobal-CatégoriesMonoïdales.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-paykinLinearProducerConsumer2014

    AUTHORS: Paykin, Jennifer; Zdancewic, Steve | DATE: 2014 | TITLE: A Linear/Producer/Consumer Model of Classical Linear Logic | REVUE: LINEARITY 2014, EPTCS 176, 2015 | IDENTIFIANT: doi:10.4204/EPTCS.176.2 | REF.BIB: nil | RDF: t — vérifié par DOI contre le RDF le 3 septembre | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-paykinLinearProducerConsumer2014 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### depaivaDialecticaCategoriesLambek2018

    AUTHORS: de Paiva, Valeria; Eades III, Harley | DATE: 2018 | TITLE: Dialectica Categories for the Lambek Calculus | REVUE: arXiv, 2018 | IDENTIFIANT: arXiv:1801.06883 | REF.BIB: nil | RDF: t | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-paivaDialecticaCategoriesLambek2018 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-diazCaroAlgebraicExtensionIntuitionistic2025

    AUTHORS: Diaz-Caro, Alejandro; Ivnisky, Malena; Malherbe, Octavio | DATE: 2025 | TITLE: An Algebraic Extension of Intuitionistic Linear Logic: The LS!-Calculus and Its Categorical Model | REVUE: arXiv, 2025 | IDENTIFIANT: arXiv:2504.12128 | REF.BIB: nil | RDF: t — apparié le 3 septembre avec diaz-caroAlgebraicExtensionIntuitionistic2025a | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-diazCaroAlgebraicExtensionIntuitionistic2025 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### saccaDataExchangeDatalog2012-2

    AUTHORS: Sacca, Domenico; Serra, Edoardo | DATE | TITLE: Data Exchange in Datalog is mainly a Matter of Choice | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec saccaDataExchangeDatalog2012 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-choice | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-quantification-2

    AUTHORS: Lanzinger, M.; Nissl, M.; Sallinger, E.; Walega, P. A. | DATE | TITLE: Temporal Datalog with Existential Quantification | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec lanzingerTemporalDatalogExistential2022 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-quantification | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### gutkouvasSessionTypeUnreliable2017-2

    AUTHORS: Gutkovas, Ramunas; Kouzapas, Dimitrios; Gay, Simon J. | DATE | TITLE: A Session Type System for Unreliable Broadcast Communication | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec gutkouvasSessionTypeUnreliable2017 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-communication | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-mIPE-2

    AUTHORS: Silva, Frederico; Aguiar, Marilton | DATE | TITLE: Um ambiente computacional para processamento de imagens com alto desempenho no contexto do Projeto M-IPE | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec silvaAmbienteComputacional2010 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-mIPE | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-paralela-2

    AUTHORS: Milanes, Anolan; Barbosa, Ayala; Meira, Wagner; Ferreira, Renato | DATE | TITLE: Oportunidades para o uso de linguagens interpretadas em plataformas de computacao paralela | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec milanesOportunidadesLinguagens2010 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-paralela | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-distribuida-2

    AUTHORS: Librelotto, Giovani Rubert; Vizzotto, Juliana Kaizer; Augustin, Iara | DATE | TITLE: Um Compilador para a Linguagem Reativa Sincrona Distribuida | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-distribuida | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-cMTJava-2

    AUTHORS: Echevarria, Marcos Goncalves; Du Bois, Andre Rauber | DATE | TITLE: Um sistema de versionamento adiantado para a linguagem CMTJava | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-cMTJava | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-machine-2

    AUTHORS: Formiga, Andrei de A.; Lins, Rafael D. | DATE | TITLE: Efficient Implementation of the Pi-Calculus on the Java Virtual Machine | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec formigaEfficientImplementationPi2010 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-machine | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-ehrigRoleCategoryTheory1995-2

    AUTHORS: Ehrig, Hartmut; Grosse-Rhode, Martin; Wolter, Uwe | DATE: 1995 | TITLE: On the Role of Category Theory in the Area of Algebraic Specifications | REVUE: WADT 1995, LNCS 1130, 1996 | IDENTIFIANT: doi:10.1007/3-540-61629-2_31 | REF.BIB: nil | RDF: nil | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-ehrigRoleCategoryTheory1995 | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

### SEG-abstract-2

    AUTHORS: Benaissa, Zine El-Abidine; Moggi, Eugenio; Taha, Walid; Sheard, Tim | DATE | TITLE: A Categorical Analysis of Multi-Level Languages (Extended Abstract) | REVUE: — champ libéré : il portait les auteurs (interversion du segmenteur, corrigée le 3 septembre) | IDENTIFIANT: titre seul — identifiant à établir | REF.BIB: nil | RDF: t — apparié le 3 septembre avec benaissaCategoricalAnalysis1998 | PDF: t | LU: nil | A-CITER-SUR: à établir | DOSSIER: ref/Q4.pdf | SEGMENT: SEG-abstract | SYNTHESE: nil — abstract d'export, non analysé

#### \[TODO\] Importer dans Zotero puis dépouiller

Identifié le 27 août par segmentation du dossier ref/Q4.pdf. Statut : PDF disponible, référence non importée, contenu non lu. À importer par son identifiant, puis à dépouiller selon la question qu'il sert.

## LITTÉRATURE GRISE — *dépouillée, non citable*

### GRIS-LlganceATroisLieuxEtDeuxCamps

    AUTHORS | DATE | TITLE: L'ÉLÉGANCE A TROIS LIEUX ET DEUX CAMPS — et T-61 peut cesser de chercher une définition unique | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Les trois lieux, et ils ne se confondent pas

|  |  |
|----|----|
| *l'outil* | le langage lui-même — sa grammaire, sa régularité |
| *le résultat* | le code écrit dans ce langage |
| *la spécification* | le document qui le définit, ***et il se mesure en pages*** |

**Et la distinction outil/résultat est défendue dans le fil, contre un contradicteur** : « l'existence du David de Michel-Ange (résultat) ne rend pas le ciseau élégant (outil), et la question portait sur les langages élégants (outils) et non les programmes élégants (résultats). \[…\] Traduit en Brainfuck, l'existence même de la traduction ne rendrait Brainfuck ni plus ni moins élégant. » *Position opposée, tenue dans le même fil* : « le code élégant est un code qui fait exactement ce qu'on veut, de façon simple et directe, sans effets de bord non voulus. *Les langages de programmation élégants sont ceux qui rendent facile d'écrire du code élégant.* » ***Deux positions incompatibles, chacune défendue, dans un fil qui cherche une définition.*** **C'EST LE RÉSULTAT LE PLUS UTILE DE T-63 POUR T-61** : l'élégance ne résiste pas à la définition parce qu'elle serait floue, mais ***parce que le mot désigne trois choses qui varient indépendamment***. **T-61 doit donc dire DE QUOI il parle avant de chercher un critère.** **DÉNOMBREMENT** : un fil, 30 approbations, 26 messages, treize ans d'âge. *Aucune de ces positions n'est majoritaire ; ce qui est établi, c'est qu'elles coexistent.*

#### Et la meilleure formulation négative du fil

> « Une grammaire raisonnablement petite et *régulière*, construite de telle façon que les programmes s'y écrivent avec un minimum d'irritation et soient esthétiquement plaisants pour des programmeurs humains. Un langage élégant est ***cohérent dans sa forme et son nommage***, et assez petit pour être appris. ***Un langage inélégant est arbitraire et surprenant***, ou excessivement complexe. »

Avec un exemple opératoire : « un langage qui a un seul opérateur d'addition est plus élégant qu'un langage qui en a quatre, un pour chaque combinaison de nombres pairs et impairs ». ***« Arbitraire et surprenant » est testable là où « élégant » ne l'est pas.*** Et c'est le même critère que LFE énonce pour les noms — « il ne devrait pas surprendre le lecteur » — et que le critère de non-perturbation de TXR vise par un autre chemin. **Le nommage est explicitement nommé comme composante de l'élégance. C'est un appui pour P-3.** **À noter, et c'est piquant** : deux participants du fil s'embrouillent sur le mot « régulier », l'un l'entendant comme *régularité*, l'autre comme *langage régulier* au sens formel. ***Une collision de vocabulaire au milieu d'une tentative de définition*** — ce qui illustre le problème plutôt qu'il ne le résout.

### GRIS-LeParadoxeDAdoption

    AUTHORS | DATE | TITLE: LE PARADOXE D'ADOPTION — quatre formulations indépendantes, et il faut cesser de le contourner | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Le même constat, quatre fois, par des chemins étrangers

|  |  |
|----|----|
| 1 | T-57, fil TXR — « c'est peut-être objectivement simple, mais ce n'est pas du tout un langage simple » / « simple mais pas facile » |
| 2 | T-57, témoin des cent langages — Tcl « beau dans sa simplicité », Rebol « minuscule mais puissant, *qui n'a pas tout à fait pris* » |
| 3 | T-63, fil du mieux pensé — « les mieux pensés sont pour l'essentiel inemployés » |
| 4 | T-63, fil francophone — « les meilleurs langages ne sont pas les plus adoptés » |

***Et Lisp est nommément cité dans deux d'entre elles, du côté « bien pensé et inemployé ».*** **CE QUE K7PL DOIT EN FAIRE** : P-5 pose trois voies d'adoption — compréhension aisée, forte expressivité, et l'élégance indéfinie. ***Le dépouillement montre qu'aucune des trois ne prédit l'adoption***, et que la qualité de conception y est au mieux neutre. **Ce n'est pas une raison d'abandonner l'exigence de conception.** C'en est une de ***cesser de la présenter comme un moyen d'adoption***, ce que P-5 fait implicitement. *Bien concevoir se justifie autrement — et il faudra dire comment.* **Question neuve.**

### GRIS-UneCritiqueMthodologique798Approbations

    AUTHORS | DATE | TITLE: UNE CRITIQUE MÉTHODOLOGIQUE À 798 APPROBATIONS — et elle vise notre propre billet | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-CeQueP3AchteAUnNom

    AUTHORS | DATE | TITLE: CE QUE P-3 ACHÈTE A UN NOM — et c'est un étranger qui le donne | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeCritreDePremierContactEtLispYchoue

    AUTHORS | DATE | TITLE: LE CRITÈRE DE PREMIER CONTACT, ET LISP Y ÉCHOUE — le relevé le plus inconfortable | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeCotDUnMotClAuNoyau

    AUTHORS | DATE | TITLE: LE COÛT D'UN MOT-CLÉ AU NOYAU — nommé par un lispien, et nous ne l'avions pas | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LArbitrage3EstNommCommeSourceDlgance

    AUTHORS | DATE | TITLE: L'ARBITRAGE 3 EST NOMMÉ COMME SOURCE D'ÉLÉGANCE — par des utilisateurs, deux fois | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LesGroupesEEtFSontFaits

    AUTHORS | DATE | TITLE: Les groupes E et F sont FAITS — le 10 août, et la section leur est consacrée plus bas | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-Slap

    AUTHORS | DATE | TITLE: SLAP — quelqu'un a construit NOTRE combinaison, et cela vaut une fiche entière | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Ce que c'est

L'auteur décrit son langage comme une chimère, en cinq lignes :

> « *terse* : tacite comme APL, J, K — *safe* : système de types linéaire fort comme Rust — *small* : spécification simple comme Lisp, Forth — *fast* : mémoire manuelle comme C, Zig — *easy* : effets gérés comme Elm, Roc. »

***Ce sont exactement les cinq engagements de K7PL.*** Couche 3 tacite d'inspiration APL ; couche 1 linéaire ; noyau minimal en expressions symboliques ; sédimentation sans ramasse-miettes ; système d'effets. **Aucun autre système du dépouillement ne combine les cinq.** **Et sa devise est la nôtre** : « *le vrai pouvoir de Slap est ce qu'il ne PEUT PAS faire* ».

#### LE RÉSULTAT PRINCIPAL — *la structuralité refusée se manifeste comme erreur de type*

    42 box dup
    -- TYPE ERROR: dup requires copyable type, got box

    42 box drop
    -- TYPE ERROR: drop requires copyable type, got box

***La contraction et l'affaiblissement sont refusés au grade linéaire, et le refus s'énonce sur l'opération de pile elle-même.*** Ce que notre grade note par $`u`$, Slap le rend visible à l'endroit exact où la faute s'écrit — sur `dup` et sur `drop`, qui sont des mots ordinaires du langage. **C'est un point d'ergonomie que le projet n'avait pas envisagé** : *le message d'erreur d'une discipline linéaire est lui-même une décision de conception*. Dire « `dup` exige un type copiable » plutôt que « violation de la contrainte de grade » est un choix de vocabulaire qui décide de ce qu'un débutant comprend. **À verser à T-60.** Et l'interface qui remplace les opérations refusées est de quatre verbes : `lend`, `mutate`, `clone`, `free`. « Cette interface prévient les problèmes classiques : double libération, usage après libération, et oubli de libération. » *Quatre verbes pour ce que notre algèbre traite par un grade — à comparer en phase de construction.*

#### LE MODE DE PROPRIÉTÉ EST DÉCLARÉ DANS L'EFFET, PAR ARGUMENT — *et c'est la réponse à la question 13*

Les langages à pile typés annotent les « effets de pile ». Slap y met le mode :

    'square (dup mul)
      [int lent in  int move out]
        effect check def

    'pal ((dup reverse cat) mutate)
      [ 'a list 't own in
        'a list 't own out ]
        effect check def

***`lent`, `move`, `own` — le mode de propriété est écrit à côté du type, argument par argument.*** Et le régime est exactement celui de B6 :

> « Le vérificateur de types de Slap les *infère automatiquement* pour vous, mais vous pouvez les ajouter pour plus de *clarté ou d'application*. »

***Inféré par défaut, déclarable, et la déclaration est VÉRIFIÉE.*** **C'est le régime que B6 a arrêté pour le grade — « déclaré puis vérifié » — attesté dans un langage qui fonctionne.** **La question 13 reçoit donc sa septième réponse, et c'est la plus proche de nous** : ni métadonnée attachée, ni option de slot, ni mot-clé dans la liste — *une annotation d'effet portant type et mode ensemble, par argument, optionnelle et contrôlée*.

#### Trois relevés qui touchent P-1, P-2 et l'exigence de compilation

- ***Le tacite a une porte de sortie nommée.*** « Ceux qui abhorrent la manipulation tacite de pile peuvent employer `let` à la place » — et les deux versions du même programme sont données côte à côte. **Notre couche 3 devra dire si elle offre cette porte, et C-1 ne l'a pas tranché.**
- ***Le glyphe est annoncé comme un AJOUT, la forme en mots étant première.*** « J'ajouterai éventuellement des glyphes à la Uiua pour que vous vous sentiez magicien » — puis les deux formes en regard, `(swap over plus) repeat drop` et `(: ↷ +) ⍥ ↘`. **C'est P-2, avec l'ordre inverse de celui que V-3 a retenu** : ici la source porte les mots, le glyphe est le raffinement. *Une troisième position sur la question, à consigner.*
- ***Le coût est rendu visible plutôt que masqué.*** « La pile est souvent plus lente que le tas. ***La sémantique transparente de Slap vous force à raisonner sur de tels compromis.*** » **Cinquième occurrence du principe de visibilité**, et la première qui porte sur la mémoire.

#### Et un point qui rejoint T-63 par un autre chemin

« `slap.c` fait ~2 000 misérables lignes de C99. \[…\] Si l'architecture de Slap tient dans mon cerveau de la taille d'un pois, elle tiendra sûrement dans le vôtre. » ***La réimplémentabilité comme objectif de conception affiché*** — c'est exactement le critère d'élégance proposé par le fil « l'apocalypse des compilateurs », et il recoupe les minimalistes de T-57. **Trois sources indépendantes convergent sur ce critère ; il est le seul du dépouillement à être à la fois opératoire et chiffrable.**

### GRIS-Futhark

    AUTHORS | DATE | TITLE: FUTHARK — le datum le plus proche de notre architecture à trois couches | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA PHRASE QUI COMPTE

Futhark n'a pas la récursion parce qu'elle ne fonctionne pas sur processeur graphique. On pourrait imaginer une règle disant « récursion permise, sauf dans du code qui finit sur un GPU ». L'auteur explique pourquoi il ne l'a pas fait :

> « Ce qui est plus difficile, c'est de *spécifier précisément* une telle règle. \[…\] \*/nous ne voulons pas compliquer le système de types pour suivre si une fonction contient une récursion/\*. \[…\] Le fait qu'un programme *puisse* être compilé pour un GPU signifie que \*/les restrictions du langage sont composées de l'UNION des restrictions de toutes les cibles supportées/\*. »

#### CE QUE CELA ÉTABLIT POUR K7PL — *et c'est le meilleur appui que l'architecture ait reçu*

K7PL a trois couches aux capacités différentes — linéaire, affine, pure sans effets — et des délimiteurs qui disent où l'on est. ***Futhark décrit exactement ce qui arrive quand on refuse ce dispositif : les restrictions s'additionnent au lieu de se localiser.*** **Le prix de notre choix est nommé par la même phrase** : « compliquer le système de types pour suivre » où le code s'exécute. ***C'est précisément ce que fait notre système de sortes, et ce que coûtent nos délimiteurs.*** **Deux architectures, deux prix, tous deux énoncés** : l'union des restrictions d'un côté, la complication du système de types de l'autre. \*/Le document n'avait jamais posé l'alternative en ces termes, et elle est la meilleure justification des délimiteurs de couche que l'arc possède./\* **À écrire au corps.**

#### UN CAS DE SYNTAXE QUI BLOQUE UNE SÉMANTIQUE — *et il vise la falsification d'arc*

Sur la récursion mutuelle, refusée :

> « Il n'y a pas de raison profonde. En fait, ***l'obstacle principal est qu'il nous faudrait trouver une SYNTAXE pour indiquer que deux fonctions font partie du même “groupe de liaison”***, ou quel que soit le nom qu'on lui donne. »

***Une fonctionnalité sémantique bloquée par l'absence d'une notation, et l'auteur le dit platement.*** **C'est un contre-exemple direct à la falsification écrite avant lecture** — celle qui dit que l'arc travaillerait sur une variable secondaire. *Ici la notation n'est pas secondaire : elle est l'obstacle.*

#### Et deux maximes de conception qui parlent à la règle de tête

- « en Futhark nous préférons ***ne faire que des promesses que nous pouvons tenir*** ». **Deuxième occurrence de la discipline de promesse**, après les trois degrés d'engagement de Coalton ;
- après avoir admis que sa règle sur les fonctions d'ordre supérieur récursives est un contrôle *syntaxique* et « un peu ad hoc » : « c'est au moins une règle *simple*, et ***je préfère nettement des règles légèrement rigides à des règles subtiles mais plus souples*** ». **Un contrôle syntaxique préféré à un contrôle sémantique, explicitement, pour la simplicité.** *Venant d'un chercheur en compilation, cela vaut d'être noté : la simplicité de la RÈGLE peut l'emporter sur sa généralité, et c'est un arbitrage que la phase 4 rencontrera.*
- Enfin, l'inquiétude de celui qui ajoute la fonctionnalité : « je suis un peu inquiet que les futurs programmeurs Futhark tendent à recourir à la récursion même quand ce n'est pas le bon outil ». ***Ajouter une capacité crée le risque de son mésusage, dit par celui qui l'ajoute.*** **Même famille que la question 17.**

### GRIS-Matklad

    AUTHORS | DATE | TITLE: MATKLAD — une sonde de falsification pour la sédimentation, et un argument POUR la notation | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Le cas

« Le contre-exemple central de la sûreté mémoire, le cas le plus difficile à résoudre, *n'a rien à voir avec les destructeurs ni le tas*. » Il s'agit d'une union étiquetée : on l'initialise en variante `A`, on prend un pointeur vers son intérieur, on écrase l'union avec la variante `B`, puis on emploie le pointeur. « Le pointeur est toujours typé `A`, mais les octets qu'il désigne appartiennent maintenant à `B` : *une confusion de types*. » **Et cela casse aussi Ada.** **CE QUE CELA DEMANDE À K7PL** : notre sédimentation traite la propriété et le transfert de couche. *Elle ne dit rien d'un pointeur INTÉRIEUR à un type somme qui survivrait à un ré-étiquetage.* **C'est une sonde précise, et elle porte sur un acquis.** *À instruire — ce n'est pas une question de syntaxe, mais elle atterrit sur l'arc précédent.*

#### ET L'ARGUMENT QUI VISE LA FALSIFICATION D'ARC

> « Le plus gros manquement de l'industrie en matière de sûreté mémoire est de ne pas avoir écouté Walter Bright \[sur la plus grosse erreur du C, les tableaux qui se dégradent en pointeurs\]. ***Je parie que si nous avions eu la syntaxe `char a[..]` vers C11, bon nombre de problèmes ne se seraient pas produits !*** »

***UNE NOTATION EST NOMMÉE COMME CE QUI AURAIT PRÉVENU UNE CLASSE ENTIÈRE DE FAILLES.*** Par quelqu'un dont le métier est l'outillage de compilation, à propos du langage le plus employé de l'industrie. **C'est le contre-argument le plus fort que le dépouillement ait produit à la falsification d'arc.** /Elle disait : peut-être les griefs portent-ils sur l'outillage et l'écosystème plutôt que sur la notation. Voici un cas où la notation est tenue pour la cause, et l'enjeu n'est pas le confort mais la sécurité./ **STATUT DE LA FALSIFICATION : affaiblie, non écartée.**

### GRIS-DeuxMesuresPourLeTransfertDeCouche2Vers3

    AUTHORS | DATE | TITLE: DEUX MESURES POUR LE TRANSFERT DE COUCHE 2 VERS 3 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] La disposition des données vaut jusqu'à trente fois

:SOURCE: Farid Zakaria, « Every byte matters », 1er juin 2026 (source primaire) L'article mesure l'écart entre *tableau de structures* et *structure de tableaux* sur une itération qui ne lit qu'un octet par élément : « nous observons jusqu'à ***30 fois*** d'amélioration quand la structure fait 1 Kio ». Et pour les accès aléatoires, un escalier : la *taille totale du jeu de travail* détermine le palier de cache, 3 ns à 512 éléments contre 163 ns à 131 072. **CE QUE CELA DONNE À K7PL** : le passage de couche 2 vers 3 est documenté comme « préparation des données de flux sur le tas de couche 2, versées dans les tableaux de la pile ad hoc ». ***C'est exactement le choix que cet article mesure, et l'écart est d'un facteur trente.*** **Cela donne une magnitude aux directives de représentation** — le `repr` de Coalton, qui « aide à la compatibilité au prix d'occasions d'optimisation ». *Une déclaration de disposition n'est pas un confort : c'est un facteur trente, et elle a donc sa place dans la source.*

#### Le transfert sans copie est un patron de production

:SOURCE: Eclipse iceoryx2, page de présentation (source primaire) « Un producteur *emprunte une tranche* de mémoire partagée et y écrit son message directement. Une fois. iceoryx2 remet à chaque consommateur *une référence vers cette mémoire exacte, non un duplicat*. » Résultat annoncé : latence plate indépendante de la taille, sous la microseconde, zéro copie, « plus de 1000 fois plus rapide pour de gros messages ». **C-1 concluait que le passage couche 2 vers 3 « n'est pas une copie mais un transfert de propriété », et que $`\omega`$ y est sûr *parce que l'exclusivité a été établie avant le transfert*.** \*/Voici le même patron en production, à l'échelle industrielle, avec ses chiffres : un écrivain, beaucoup de lecteurs par référence, après que l'exclusivité d'écriture a été consommée./\* **Le vocabulaire est le nôtre — « emprunte une tranche » — et il ne vient pas de la théorie des types.**

### GRIS-WhyLispIsDifferent

    AUTHORS | DATE | TITLE: « WHY LISP IS DIFFERENT » — la syntaxe y est UN point sur douze, et il est porté au crédit | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Ce que le texte fait

Un praticien chevronné de Common Lisp énumère ce qui rend Lisp « moins compatible avec le monde extérieur actuel ». **Douze points.** Onze portent sur le *runtime* et la *représentation* : ramasse-miettes et taux d'allocation élevé ; liaison tardive et redéfinition à chaud ; « Lisp, dans ses types de données standard, *ne se soucie pas beaucoup de la disposition des données* — les champs sont d'ordinaire des pointeurs, ce qui peut être inefficace » ; objets typés portant leur étiquette, d'où des entiers plus courts que le mot machine ; cohérence du tas ; pagination ; CLOS incompatible avec le paradigme d'envoi de messages ; interfaces de fonctions étrangères extensives et non normalisées ; et « *il y a peu de culture de contrôles statiques au niveau du code* — il faut donc vraiment charger le logiciel dans un Lisp pour l'inspecter ». **Le douzième, en entier** :

> « Lisp a une syntaxe de surface différente. Le code Lisp n'est pas orienté vers les lignes, mais vers les expressions symboliques — une syntaxe de sérialisation de données. *Le code peut être lu sans analyse syntaxique extensive, simplement en employant le lecteur Lisp.* »

#### CE QUE CELA ÉTABLIT — *et c'est la donnée la plus embarrassante pour l'arc*

\*/Quand un expert de Common Lisp écrit le texte canonique sur l'étrangeté de Lisp, la syntaxe occupe un point sur douze, elle est décrite neutrement, et l'unique conséquence qu'il en tire est un AVANTAGE./\* Tout le reste est mémoire, représentation, dynamisme et infrastructure. **Il faut cependant lire précisément ce que le texte demande** : il traite de la *compatibilité avec l'extérieur*, non de l'*ergonomie pour celui qui écrit*. Ce sont deux questions distinctes, et la falsification de l'arc porte sur la seconde. ***Le texte ne la tranche donc pas — mais il rappelle qu'un praticien interrogé sur « pourquoi Lisp est à part » ne répond pas « les parenthèses ».*** **STATUT DE LA FALSIFICATION : elle reste ouverte, et ce texte pèse de son côté.**

#### ET UN RETOURNEMENT — *trois de ses douze faiblesses sont exactement ce que K7PL vise*

|  |  |
|----|----|
| « ne se soucie pas de la disposition des données ; les champs sont des pointeurs » | notre sédimentation et les tableaux de couche 3 — *et l'article « every byte matters » chiffre l'écart à trente fois* |
| « peu de culture de contrôles statiques ; il faut charger le logiciel pour l'inspecter » | K7PL est un Lisp *statiquement vérifié*, et le solveur travaille avant chargement |
| ramasse-miettes exigeant, taux d'allocation élevé | la sédimentation supprime le ramasse-miettes |

***Le texte lit donc comme un cahier des charges auquel K7PL répond sur trois points, sans le savoir.*** **C'est le meilleur cadrage disponible de ce que ce projet apporte à la famille** — et il ne porte sur aucune question de notation. *À écrire quelque part : ce que K7PL change de Lisp n'est pas d'abord sa syntaxe.*

### GRIS-LeFilC3

    AUTHORS | DATE | TITLE: LE FIL C3 — ce qu'une discipline de durée de vie doit acheter, et pourquoi la portée ne suffit pas | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Le critère, énoncé nettement

Un article propose de remplacer la vérification d'emprunt par des *arènes à portée lexicale*. Le fil le démonte, et la meilleure réponse pose le critère :

> « Le problème majeur que résolvent les durées de vie à la Rust, ou un vrai ramasse-miettes, ou le comptage de références, ***n'est pas la fuite*** — une stratégie courante sur gros système est de ne jamais libérer. ***C'est de continuer à détenir des références vers de la mémoire après la fin de vie de l'objet qu'elle contenait.*** C'est cela qui devient exploitable. »

Et sa conséquence : « du point de vue de la sûreté mémoire, ***fuir est toujours plus sûr que laisser un pointeur pendant accessible*** ». **POUR K7PL** : la sédimentation doit être jugée sur le *pendant*, non sur la *fuite*. *Le document ne l'a jamais énoncé en ces termes, et c'est le bon.*

#### LA PORTÉE LEXICALE NE SUFFIT PAS, ET L'AUTEUR DE LA PROPOSITION L'ADMET

Interrogé sur l'échappement hors de l'arène, il répond :

> « C'est possible (***pour l'instant aucune analyse statique ne vous en empêchera***), et c'est le même problème que si vous l'aviez fait en C++. \[…\] La mémoire pointée sera raturée : vous obtiendrez `0xAAAAAAAA` à la déréférence, mais elle reste valide. »

Et l'objection décisive : raturer ne résout rien — « l'allocateur système de Darwin met déjà à zéro à la libération, *pas même en mode débogage, mais par défaut*. Le problème d'un pointeur pendant n'est pas la fuite du contenu, c'est ***l'usage concurrent ultérieur d'un même emplacement par des pointeurs sans rapport*** ».

#### LE CAS D'ORDRE SUPÉRIEUR — *et il force la discipline DANS LE TYPE*

Le même contradicteur construit le cas qui clôt la discussion : deux fonctions de même signature, l'une allouant durablement, l'autre dans l'arène ; puis une fonction qui reçoit *l'une ou l'autre* en paramètre et retourne son résultat depuis une arène.

> « *Vous ne pouvez pas vous analyser statiquement hors de ce problème général.* »

***Parce que la durée de vie du pointeur retourné dépend de QUELLE fonction a été passée — donc d'une information qui doit être portée par le TYPE de ce paramètre.*** **C'EST L'ARGUMENT LE PLUS DIRECT QUE LE DÉPOUILLEMENT AIT PRODUIT EN FAVEUR DE NOTRE CHOIX.** Un dispositif de portée — arène, bloc, délimiteur — ne peut pas suivre une durée de vie à travers un argument fonctionnel. *Un grade porté par le type le peut.* **À écrire au corps, en regard de l'exigence de sédimentation.**

### GRIS-LeavingRustGamedev

    AUTHORS | DATE | TITLE: « LEAVING RUST GAMEDEV » — trois ans, deux jeux publiés, et l'échappatoire est ~clone()~ | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Pourquoi ce document compte plus que les autres

C'est le seul témoignage du dépouillement portant sur ***l'abandon d'un langage à discipline de propriété, après usage professionnel prolongé***. L'auteur programme depuis vingt ans, a publié des jeux sous Unity, Unreal et Godot, a écrit son propre moteur, et anticipe l'objection :

> « Je dis tout cela pour dissiper l'idée qu'il n'y aurait pas eu assez d'efforts \[…\]. \*/L'argument numéro un que j'entends quand quelqu'un pointe des problèmes de Rust est, sur le ton de la plaisanterie : « vous n'avez simplement pas assez d'expérience pour apprécier cela »./\* »

**C'EST UN POINT DE MÉTHODE QUI NOUS VISE.** K7PL imposera une discipline de grade. ***La réponse réflexe à toute doléance sur une discipline stricte est « vous n'êtes pas encore assez bon ».*** **Il faut décider MAINTENANT ce qui comptera comme une plainte recevable**, avant d'être en position de la refuser. *Question de méthode, à porter au protocole d'ergonomie.*

#### LE RÉSULTAT — *« l'abstraction n'est pas un choix », et l'échappatoire est gratuite en apparence*

Le cas est minuscule : une interface où l'on veut sortir un `if` d'un bloc imbriqué, et donc passer à la fois une référence sur un champ et la structure entière.

> « Et là on se fait taper sur les doigts : croyais-je vraiment pouvoir passer `self` tout en empruntant un champ de `self` ? Même après des années de Rust, *j'emploie encore trop de mon cerveau à penser à l'interface ou au jeu, et trop peu à penser à comment structurer mon code*. \[…\] ***C'est un bon exemple de la façon dont Rust se heurte à la manière la plus naturelle de faire les choses.*** \[…\] Je ne veux pas dépenser mes cycles cérébraux à savoir quelles parties de l'interface ont besoin de quelles parties de l'état. »

**La solution retenue est d'ajouter `.clone()`** :

> « Tout fonctionne, le vérificateur d'emprunt est content, et ***on clone une chaîne à chaque image***. Cela n'apparaîtra pas au profileur, donc au fond peu importe. Mais c'est particulièrement triste, pour un langage qui vise tant la vitesse et l'optimalité, de devoir gaspiller des cycles à réallouer de la mémoire plus souvent qu'on ne le voudrait, ***juste pour rester productif***. \[…\] Beaucoup de problèmes se résolvent simplement par une copie supplémentaire. \[…\] C'est une surprise pour beaucoup de gens à qui j'ai appris Rust. Leur réponse habituelle est : *« attends, je croyais que Rust était censé être très rapide et efficace »*. »

#### CE QUE CELA DEMANDE À K7PL — *et c'est la question 17 appliquée à notre propre discipline*

\*/L'échappatoire d'une discipline de propriété n'est ni un drapeau, ni un `unsafe`, ni un budget relevé. C'est la COPIE — ordinaire, sûre, invisible au profileur, et donc gratuite en apparence./\* La question 17 demande ce qui empêcherait les échappatoires de devenir la norme. Nos réponses portent sur le mode de vérification, les indices du développeur et le budget relevé — *toutes des constructions que l'on voit*. **Aucune ne traite le cas où l'échappatoire est une opération banale du langage.** **QUESTION NEUVE, ET ELLE EST STRUCTURELLE** : *quelle est la `clone()` de K7PL, et se voit-elle ?* Une copie au grade $`\omega`$ sera écrivable ; sera-t-elle *comptée* ? Le budget relevé doit être écrit dans la source — ***une copie de confort le doit-elle aussi ?*** **STATUT** : ce n'est pas une objection à la sédimentation, c'est la découverte de son point de fuite. *Il vaut mieux l'avoir vu avant d'écrire la syntaxe que trois ans après.*

#### ET UNE SIXIÈME OCCURRENCE DE L'OUTIL COMME PRÉCONDITION

Dans la section des points positifs, sur l'analyseur de code : « *je serais à 100 % incapable d'écrire du Rust sans lui désormais* ». Suivi de l'aveu que c'est « l'un des serveurs de langage les plus cassés » qu'il ait employés, et qu'il plante depuis plus d'un an. ***Une discipline de propriété devient impraticable sans un outil, et cet outil est fragile.*** **Sixième occurrence de la question 15**, après Coalton livrant son éditeur, CLOG livrant le sien, Emacs prescrivant par `apropos`, Lone faisant modifier un éditeur de liens, et le glyphe `ƒ` qui ne se saisit que dans *mine*. ***Ce n'est plus une régularité : c'est une contrainte de conception.***

#### Ce que l'article porte au crédit, et il faut le dire

« *Si ça compile, ça marche souvent tout simplement.* \[…\] La plus grande force de Rust est de loin que, quand on écrit du code qui lui convient, les choses vont *très* bien, et ***le langage guide l'utilisateur sur le bon chemin***. » Et une mesure : après effort d'optimisation des deux côtés, Rust reste devant C# d'un facteur 1,5 à 2,5. ***« Le langage guide l'utilisateur sur le bon chemin » est exactement ce que P-4 vise.*** **Le même document dit donc que la discipline guide ET qu'elle se heurte à la manière naturelle de faire.** *Les deux sont vrais, et la phase de construction devra vivre avec.*

### GRIS-LeBilletIvre

    AUTHORS | DATE | TITLE: LE BILLET IVRE — deux lignes utiles sur des milliers | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-MakeInvalidStatesUnrepresentableConsideredHa

    AUTHORS | DATE | TITLE: « MAKE INVALID STATES UNREPRESENTABLE » CONSIDERED HARMFUL — le fil qui attaque notre prémisse | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Pourquoi il compte

K7PL rend inécrivables des états d'usage illicites — c'est ce que fait un grade. \*/Voici quatre-vingt-dix-neuf messages sur le principe même, et ils ne le rejettent pas : ils le DÉLIMITENT./\* **C'est plus utile qu'une approbation.**

#### LE RÉSULTAT — *la découpe est le monde clos contre le monde ouvert, et elle est spontanée*

Le message le mieux approuvé pose le test :

> « L'important, dans “rendre les états illégaux inexprimables”, est de réfléchir très soigneusement à ce qu'on entend par *illégal*. Beaucoup de choses sont indésirables ou contredisent la logique actuelle du programme. \*/Mais si elles peuvent arriver dans le monde réel, et que votre programme doit les représenter, vous ne pouvez pas les rendre inexprimables./\* \[…\] En revanche, si quelque chose est *vraiment incohérent au niveau logique*, alors vous devriez l'interdire. »

Et une réponse ramène l'objection à sa juste taille : « l'article s'intitule “rendre les états invalides inexprimables, considéré nuisible”, mais il porte en fait sur ***pourquoi rendre les états VALIDES inexprimables est nuisible***. » **Puis la formulation qui tranche, avec vingt-cinq approbations** :

> « Cela revient en dernière analyse aux systèmes en ***monde clos contre monde ouvert***. Nous devrions absolument restreindre l'espace d'états au minimum dans les bases de code qui sont “closes” et sur lesquelles on peut raisonner efficacement, tout en rendant les systèmes “ouverts” aussi résilients que possible. \[…\] ***Un bon langage devrait servir les deux approches.*** Même dans un système ouvert, *votre moteur d'expressions régulières aura une machine à états bien définie*. »

Avec l'analogie qui la rend opératoire, quarante-neuf approbations : « cela me rappelle la règle empirique entre exception et assertion. On lève une exception quand on reçoit une entrée invalide *de l'extérieur* ; on déclenche une assertion quand une donnée *interne* viole un invariant. ***Les états invalides inexprimables sont du côté de l'assertion.*** »

#### CE QUE K7PL EN RETIENT — *nos trois couches SONT cette partition, et nous ne l'avions pas dit*

La couche 3 est pure et sans effets — *monde clos*. Les couches 1 et 2 portent les effets, les entrées-sorties, le contact avec l'extérieur — *monde ouvert*. \*/Nos délimiteurs marquent donc exactement la frontière que ce fil réclame d'un « bon langage », et personne ici ne l'avait formulé ainsi./\* **C'est une lecture de l'architecture que le projet n'avait pas**, et elle vient d'un fil qui attaque le principe. /Elle donne aussi une raison de plus de ne pas céder sur l'arbitrage 1 : le délimiteur ne marque pas seulement un régime de vérification, il marque le passage du clos à l'ouvert./ **À écrire au corps.** **ET LE TEST EST TRANSPOSABLE** : *une contrainte de grade est-elle logiquement incohérente à violer, ou seulement indésirable ?* Employer deux fois une ressource linéaire est incohérent — bon candidat. ***Mais toute contrainte de budget qui reflète une exigence changeante est, selon ce fil, un mauvais candidat à l'inexprimable.*** **À confronter au budget $`\beta`$ : est-il de la première espèce ou de la seconde ?** **Question neuve.**

#### ET UNE PHRASE QUI VISE LA QUESTION 30

« Le terrain intermédiaire flou est quand la logique du programme n'a aucun moyen de traiter l'état invalide, mais que le programme doit tout de même échouer élégamment et donner un message d'erreur informatif. \*/Les compilateurs ne devraient certainement pas essayer de compiler des programmes invalides, mais donner de bons messages d'erreur pour les programmes invalides est important et peut être assez compliqué./\* » **La question 30 — que dit le message d'erreur d'une discipline linéaire — reçoit ici son appui le plus explicite, et il vient d'un fil sur la modélisation, non sur l'ergonomie.**

### GRIS-Microfeatures

    AUTHORS | DATE | TITLE: MICROFEATURES — le fil où le kebab-case est défendu en tête, avec l'objection nommée et réfutée | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT POUR P-3

Les deux messages les mieux approuvés du fil portent sur le nommage.

> « Entièrement d'accord sur le kebab-case. ***C'est une amélioration de confort d'une ampleur inhabituelle.*** J'ajouterais l'autorisation d'employer `?` dans un identifiant : `user-record-valid?` est parfaitement clair, comme fonction ou comme variable. » **(55)**

> « L'argument que j'entends contre le kebab-case est qu'il rend impossible d'écrire la soustraction `foo-bar`, mais… ***c'est… une bonne chose, en fait ?*** Pourquoi concevons-nous notre syntaxe spécifiquement pour accommoder de mauvaises habitudes de lisibilité ? Mettez une espace et n'en parlons plus. La même logique vaut pour le point d'interrogation dans les identifiants. ***S'il n'y a pas d'espace autour, cela fait partie de l'identifiant.*** » **(56, le mieux approuvé du fil)**

***P-3 reçoit donc son soutien le plus direct, et l'objection standard y est nommée puis retournée.*** **STATUT** : opinion attestée, largement approuvée sur un forum de pairs. *Ce n'est pas une mesure ; c'est une constituante.*

#### LA RÈGLE GÉNÉRALISÉE, ET ELLE EST CELLE DE KONEKO

Poussé sur la cohérence, le même auteur va au bout, avec vingt-neuf approbations : « Tous les opérateurs mathématiques sont-ils sensibles à l'espace ? ***Oui, bien sûr !*** Il n'y a aucune raison d'interdire `tla+` comme identifiant, ni `km/h` pour une variable de vitesse, sinon “c'est comme ça depuis des décennies”. » ***C'est exactement la règle de Koneko — tout caractère peut entrer dans un identifiant, l'espace sépare — et voici sa CONSTITUANTE.*** **La question 23 dispose maintenant des deux versants** : la fiche Koneko en donnait le coût — `(1 2)` échoue, « le nom `(1` n'est pas défini » — et ce fil en donne la défense argumentée. **L'objection sérieuse est également au fil** : « le kebab-case vaut-il de menues erreurs quand on ne tape pas correctement ? Je formate mes opérateurs avec des espaces, mais il m'arrive de mitrailler du code sans espaces ***et de compter sur mon formateur pour corriger***. » — à quoi il est répondu que le compilateur signalerait un identifiant inconnu. ***Le point qui reste*** : *un formateur ne peut pas remettre une espace qu'il ne sait pas manquante*. **Une notation sensible à l'espace transfère au compilateur ce que l'outil faisait.** **Et l'auteur de l'objection concède ce qui nous concerne** : « le kebab-case est bien, mais proprement réservé aux Lisps. »

#### LA CATASTROPHE ATTESTÉE — *seconde occurrence après `char a[..]`*

Le fil rapporte l'anecdote du Fortran, où les espaces sont ignorées : `DO 15 I = 1.100` au lieu de `DO 15 I = 1,100` est lu comme une affectation à une variable `DO15I`, et la sonde est perdue. ***Un défaut de notation avec une conséquence nommée et catastrophique.*** \*Avec le pari de matklad sur `char a[..]`, cela fait deux cas où une décision de notation est tenue pour la cause d'un dommage majeur.\* *La falsification de l'arc s'affaiblit encore : ce n'est pas une variable secondaire.*

#### ET DEUX RELEVÉS QUI VISENT LE JEU DE GLYPHES

- ***L'interdit qu'il faut retenir.*** Sur la proposition d'employer le trait d'union ASCII dans les identifiants et le signe moins Unicode pour la soustraction : « ***nous ne devrions jamais, jamais employer deux symboles visuellement similaires pour des choses différentes***. Oui, le compilateur avertira, mais je voudrais fortement décourager d'engager cette voie. » **C'est une règle d'admission de plus pour un jeu de glyphes**, et elle est négative : *aucun couple de glyphes ne doit se ressembler à l'œil*. À joindre aux quatre règles de TXR.
- ***Un précédent pour V-3.*** Le langage Fortress rendait typographiquement certains identifiants — `QQ` affiché ℚ, `RR64` affiché ℝ64 — avec des règles de rendu pour l'impression et l'édition. ***La source portait le texte, l'outil affichait le symbole.*** **C'est le sens de bascule que V-3 a retenu, avec un précédent de quinze ans.** *Le projet a été abandonné, ce qu'il faut noter aussi.*

### GRIS-LeFilDuBilletIvre

    AUTHORS | DATE | TITLE: LE FIL DU BILLET IVRE — une phrase qui résume tout le problème de T-61 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] L'élégance et la charge du lecteur, en deux répliques

> « Il croyait qu'il était difficile de faire quelque chose d'astucieux. Or ***faire compliqué est FACILE ; faire simple, concis et compréhensible, voilà ce qui est difficile***. »

Et la réponse immédiate, qui donne le cas :

> « Cela me rappelle une ligne de Perl que j'ai écrite il y a des années. Elle exploitait des subtilités de la façon dont Perl traite les retours de groupes d'expressions régulières et les tables de hachage. ***Elle était élégante. Elle exigeait aussi une page entière de commentaires expliquant ce qu'elle faisait.*** »

***« Elle était élégante. Elle exigeait une page de commentaires. »*** **C'est l'énoncé le plus ramassé du divorce que T-61 doit traiter** : l'élégance de l'artefact et le coût pour le lecteur varient indépendamment, et le même auteur peut tenir les deux jugements sur la même ligne. *Le fil sur l'élégance donnait deux camps ; celle-ci montre qu'une seule personne peut être dans les deux à la fois.*

#### LA DISTINCTION QUOI/POURQUOI — *et elle dit ce que la docstring de C-2 doit porter*

Le fil discute longuement du code « auto-documenté ». La position qui l'emporte :

> « Le code “auto-documenté”, c'est presque toujours des sornettes. \[…\] Mais ***la différence est dans CE QU'ON documente***. J'aime commenter *pourquoi* j'ai fait quelque chose d'une certaine façon. Les commentaires qu'il ne faut probablement pas mettre sont ceux qui décrivent *ce que* le code fait, comme “~// récupérer tous les utilisateurs~” quand la ligne est littéralement `userRepository.GetAll()`. »

**Lisons ce que l'exemple suppose** : `userRepository.GetAll()` n'a pas besoin de commentaire ***parce qu'il est bien nommé***. ***Un bon nom supprime le besoin de documenter le QUOI ; il ne reste que le POURQUOI.*** **C'EST LA DEVINABILITÉ DE P-3, VUE DEPUIS LA DOCUMENTATION, ET CELA TRANCHE UN POINT DE C-2** : la docstring d'une macro K7PL doit porter le *pourquoi* — le motif de conception, le compromis retenu — puisque le nom et les déclarations de B6 portent déjà le *quoi*. *Sans cela, la fente de documentation se remplira de paraphrases.* **À retenir pour la phase 5.** Et une contrepartie du même fil, à consigner : « les commentaires et la documentation sont presque aussi importants que le code. Si vous ne pouvez pas prendre le temps d'écrire un commentaire sur une fonction, vous ne devriez pas écrire cette fonction. »

#### Enfin, une mise en garde sur la portée de tout ceci

« La programmation est un artisanat. Ce n'est pas une science. ***Et presque toute “règle” est une règle empirique, une ligne directrice, ou un état de l'art convenu sur le moment.*** » **À garder en tête au moment d'écrire les règles de validation de la phase 5** : *le dépouillement a produit beaucoup de règles ; aucune n'a le statut des trente-deux théorèmes.*

### GRIS-DoINotLikeRubyAnymore

    AUTHORS | DATE | TITLE: « DO I NOT LIKE RUBY ANYMORE ? » — le désamour d'un langage choisi pour sa beauté | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Pourquoi ce fil est le plus utile à T-61

Ruby est ***le*** langage adopté pour son esthétique. C'est le fil le mieux approuvé du recueil — 118 points, 103 messages — et son message de tête, avec 85 approbations, vient de quelqu'un qui a vingt ans de pratique.

#### LE RÉSULTAT — *une beauté qui n'est pas TENUE n'est pas une propriété du langage*

> « C'est un langage agréable, assurément, mais ***après quelques dizaines de milliers de lignes il devient impossible à gérer***. Ajoutez seulement deux ingénieurs inexpérimentés et tout se défait. Vous menez une bataille constante pour du bon code et ***le langage ne vous aide pas*** : pas de ségrégation au niveau des paquets, pas de système de types, aucun moyen d'imposer des interfaces, des définitions de méthodes implicites partout… vous avez des contournements pour tout cela, ***mais ils sont tous non idiomatiques et personne ne les emploie***. ***Il est aussi facile d'écrire du “beau” code que du mauvais*** : il faut se tenir à un sous-ensemble choisi du langage et y être vigilant. »

***« Il est aussi facile d'écrire du beau code que du mauvais. »*** **C'EST LA RÉPONSE À T-61 QUE L'ARC CHERCHAIT.** *L'élégance rendue POSSIBLE et l'élégance TENUE sont deux choses, et seule la seconde est une propriété du langage.* Ruby offre la première au plus haut degré, et un praticien de vingt ans dit qu'elle ne survit ni à l'échelle ni à l'équipe. **Et cela rejoint exactement la question 19** — laquelle de nos conventions sera vérifiée. *Une convention non tenue dérive ; une beauté non tenue dérive aussi, et pour la même raison.* **Le corollaire est plus dur encore** : les contournements existent, mais « ils sont non idiomatiques et personne ne les emploie ». ***Une échappatoire socialement indisponible ne compte pas comme une solution.*** **Question 17 vue par l'autre bout.**

#### ET UNE ATTAQUE DIRECTE À L'AXE « FACILITÉ D'ÉCRITURE » DE P-5

Du même message : « ***vous êtes dans l'état « je veux que ce soit stable et efficace » bien plus longtemps que dans l'état « il faut prototyper vite »***, donc il n'y a pas de sens à optimiser pour le second. Si vous mettez une semaine de plus pour arriver sur le marché avec un langage lent à écrire et statiquement typé, il n'arrivera rien de mal à votre entreprise. » **P-5 pose que les langages s'adoptent lorsqu'ils sont aisés à comprendre. Ce message dit que la facilité d'écriture est une variable de courte durée, et que l'arc long est ailleurs.**

#### LA FALSIFICATION D'ARC, ÉNONCÉE ICI À SON MAXIMUM

> « À mon avis, le typage statique et la vérification à la compilation ont un impact ***négligeable*** sur la productivité. Ce qui a un impact massif, de l'ordre de ***cent fois***, c'est la qualité de ***l'écosystème*** — cadriciels, bibliothèques, documentation, forums. »

Avec l'énigme honnête que l'auteur ajoute : « pourquoi, pour le développement web en particulier, les meilleures bibliothèques ont-elles historiquement été celles de langages sans vérification à la compilation ? *Je ne sais pas.* » Et la réponse qu'on lui fait, seize approbations : « c'est très, très facile d'aller de zéro à ***quelque chose-qui-marche-presque-si-on-plisse-les-yeux*** en Python ou en Ruby, comparé à Java ou Rust. \[…\] Ils ont réussi l'expérience de sortie de boîte. » **STATUT DE LA FALSIFICATION : c'est ici qu'elle est la mieux argumentée du dépouillement.** /Elle n'est pas démontrée — c'est une opinion, chiffrée à la louche — mais elle est tenue par quelqu'un qui donne ses exemples et avoue ce qu'il ne comprend pas, ce qui la rend sérieuse./

#### ET LE RÉSULTAT DE STRUCTURE — *trois registres temporels, et ils se dissocient*

En rapprochant ce fil des précédents, une découpe apparaît que le projet n'avait pas :

|  |  |  |  |
|----|----|----|----|
| 1 | *le premier regard* | puis-je lire ce code sans connaître le langage ? | fil francophone sur le pire langage ; le lecteur de TXR ; ***Lisp échoue*** |
| 2 | *la première heure* | puis-je aller de zéro à quelque chose qui marche presque ? | ce fil ; ***Ruby et Python gagnent*** |
| 3 | *le long terme* | cela tient-il à cent mille lignes avec des collègues moyens ? | ce fil ; ***Ruby perd*** |

***Les trois sont indépendants, et chaque langage cité en gagne un en perdant un autre.*** Ada remporte le vote esthétique et n'est pas employé ; Ruby gagne le deuxième registre et perd le troisième ; Lisp perd le premier. **T-61 doit donc dire NON SEULEMENT de quoi il parle — l'outil, le résultat, la spécification — MAIS AUSSI À QUELLE ÉCHÉANCE.** *C'est la seconde moitié de la structure que ce versant apporte, et les deux ensemble expliquent pourquoi le mot ne se laisse pas définir.*

### GRIS-WhyIMLeavingElm

    AUTHORS | DATE | TITLE: « WHY I'M LEAVING ELM » — on ne quitte pas un langage pour sa syntaxe, on le quitte pour sa frontière | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] CE QUE CELA DEMANDE À K7PL — *deux points, et le second est neuf*

1.  ***La frontière fermée est un motif d'abandon attesté.*** Elm refuse l'échappement vers son hôte ; Coalton l'autorise avec une promesse et une liste de capture, et sert en production. \*Notre question 26 — que déclare un franchissement de couche — reçoit ici son enjeu : ce n'est pas un raffinement, c'est ce qui décide si les gens restent.\*
2.  ***« Des privilèges encodés dans le logiciel lui-même ».*** L'arbitrage 3 pose que le noyau n'offre aucun point d'extension et que tout se fait en bibliothèque. **Reste la question que personne n'a posée : QUI CONTRÔLE LA BIBLIOTHÈQUE STANDARD ?** /Si l'extension passe nécessairement par elle, alors la politique d'admission de la bibliothèque EST la politique d'extension du langage — et c'est de cela qu'Elm est mort./ **C'est la forme de gouvernance de la question 18, et elle ne s'était jamais présentée.** **Question neuve.**

### GRIS-HareLangageCentAns

    AUTHORS | DATE | TITLE: « HARE, LANGAGE À CENT ANS » — et une démonstration que l'argument du mérite est infalsifiable | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] CE QUE CELA ÉTABLIT, ET C'EST UN AVERTISSEMENT DE MÉTHODE

***Toute explication après coup de la victoire d'un langage peut être racontée de n'importe quel langage qui a gagné.*** La parodie le démontre en trois lignes. **Conséquence pour P-5 et pour T-61** : les récits d'adoption fondés sur le mérite sont structurellement infalsifiables tels qu'on les formule d'ordinaire. *La seule forme de preuve qui compterait est le déplacement d'un occupant dans un environnement hostile* — ce que l'anecdote du Macintosh revendique, et ce que la parodie revendique pour JavaScript. **À porter aux précautions du billet aux pairs** : ne pas demander « pourquoi tel langage a-t-il réussi », question qui produira des récits ; demander ***des cas où une décision a été prise puis regrettée***, qui produit des faits. **C'était déjà la règle du brouillon ; ce fil en donne la démonstration.**

### GRIS-ErrorHandlingInGo

    AUTHORS | DATE | TITLE: « ERROR HANDLING IN GO » — et la réaction au VOCABULAIRE de la théorie, qui nous vise | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Le résultat principal, et il n'était pas prévisible

Le fil discute d'une notation abrégeant la vérification d'erreur en Go. Au milieu, une réaction que le dépouillement n'avait jamais rencontrée :

> « Pour l'amour du ciel, faut-il étiqueter des méthodes logicielles vieilles de cinquante ans avec ***un terme mal employé de théorie des catégories*** ? » **(18 approbations)**

Et la défense, mieux approuvée encore : « le terme *monade* s'applique bien ici, même sans toute sa puissance. Nous devrions nous réjouir que de vieilles techniques soient comprises sous un autre angle. Comprendre les monades m'a aidé à voir des motifs dans le code que j'écris tous les jours. » **(22)** — à quoi il est répondu : « *pour moi, c'est juste prétentieux* ». ***LES DEUX CAMPS SONT SUBSTANTIELLEMENT APPROUVÉS. La communauté est partagée, pas unanime.***

#### CE QUE CELA DEMANDE À K7PL — *trois endroits où le vocabulaire théorique affleure*

Le projet repose sur des fondations catégoriques : modalités graduées, quantale d'effets, loi distributive. ***Voici attestée la réaction que provoque le fait de NOMMER une construction par son nom catégorique, dans un forum technique, chez des praticiens compétents.*** Trois endroits où cela nous concerne, et aucun n'avait été identifié :

1.  ***les messages du vérificateur*** — question 30. Dire « violation de la contrainte de grade » ou dire, comme Slap, « `dup` exige un type copiable ». *Le second n'exige aucune théorie du lecteur ; le premier lui en demande.*
2.  ***le lexique de surface du langage*** — les noms des formes, des directives, des propriétés. \*Si le nom d'une construction dit sa théorie, il fait payer la théorie à qui veut seulement l'employer.\*
3.  ***le billet aux pairs*** — le brouillon prévoit quatre phrases sur K7PL. \*Ce fil dit que mentionner les fondations peut coûter le lecteur, et qu'un tiers substantiel de l'auditoire le prendra pour de la prétention.\* *À trancher dans le billet : les fondations catégoriques n'y ont probablement pas leur place.*

**STATUT** : opinion attestée, deux camps, forum de pairs. ***Ce n'est pas un verdict sur la théorie — c'est un fait sur sa RÉCEPTION, et le second se conçoit indépendamment de la première.***

#### ET UN SECOND RELEVÉ — *une notation offre, un type oblige*

Le premier message du fil objecte à la notation proposée :

> « Cela ***m'ôte la possibilité de cesser de m'inquiéter*** qu'une entrée non vérifiée soit immédiatement rejetée. Je dois désormais vérifier que tout le traitement ultérieur contient bien l'appel — et s'il manque une seule fois, je traite probablement une entrée qui n'a pas été contrôlée. »

Et la réponse : « cela peut se régler par le système de types » — en rendant la suite *inaccessible* tant que le contrôle n'a pas eu lieu, plutôt qu'en la rendant *commode*. ***Une notation OFFRE ; un type OBLIGE.*** **Troisième occurrence de ce motif**, après « il est aussi facile d'écrire du beau code que du mauvais » chez Ruby et « une convention non tenue dérive » à la question 19. *Les trois disent la même chose sur trois objets différents — l'esthétique, la convention, la vérification d'erreur.* **C'est un principe, et il devrait être écrit comme tel.**

### GRIS-RethinkdbWhyWeFailed

    AUTHORS | DATE | TITLE: « RETHINKDB : WHY WE FAILED » — la correction seule n'est pas une position | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-WeCanDoBetterThanSql

    AUTHORS | DATE | TITLE: « WE CAN DO BETTER THAN SQL » — rendement faible, et un renvoi utile | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeRsultatQuiDomineTousLesAutres

    AUTHORS | DATE | TITLE: LE RÉSULTAT QUI DOMINE TOUS LES AUTRES | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-CeQueLaCampagneOuvreEtQuiNtaitPasPrvu

    AUTHORS | DATE | TITLE: CE QUE LA CAMPAGNE OUVRE, ET QUI N'ÉTAIT PAS PRÉVU | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Un atelier entier consacré à la question de P-4

PLATEAU — « évaluation et utilisabilité des langages de programmation et de leurs outils » — onze éditions, actes publics. ***Le projet ignorait qu'il existait une communauté de recherche sur exactement sa question.*** **C'est le gisement le plus important identifié, et il n'est pas dépouillé.**

#### Un instrument transposable

Les *cartes d'exactitude par jeton* de Stefik localisent, dans une syntaxe donnée, les endroits où les novices échouent. ***C'est un instrument, pas un résultat, et il s'appliquerait à K7PL.*** **À porter au protocole d'ergonomie, qui n'a pour l'instant que le magicien d'Oz.**

#### Un cimetière diagnostiqué

Le projet *Readable* nomme les tentatives ratées de rendre Lisp lisible — M-expressions, IACL2, Dylan — et la cause : elles n'étaient ni génériques ni homoiconiques. ***Trois dérivations indépendantes des mêmes critères d'admission d'une notation*** — TXR, le projet Readable, et le fil sur les microfonctionnalités. **Ils peuvent être tenus pour établis.**

#### Et trois critères opératoires pour T-61, tous chiffrables

|  |  |
|----|----|
| 1 | ***la réimplémentabilité*** — trois sources : le fil de l'apocalypse des compilateurs, les minimalistes, Slap |
| 2 | ***un programme peut-il employer tout le langage ?*** — le critère de Kernighan, rapporté par Lippert |
| 3 | ***le volume de la spécification*** — Scheme en sept pages, l'inférence de ML en une, TXR en 951 |

***Aucun n'est la concision ni la familiarité, et les trois donnent un nombre.*** **T-61 dispose donc d'une base, ce qui n'était pas le cas il y a une semaine.**

### GRIS-CeQueLaCampagneNePeutPasDire

    AUTHORS | DATE | TITLE: CE QUE LA CAMPAGNE NE PEUT PAS DIRE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtCeQueJeNeFeraiPasSansInstruction

    AUTHORS | DATE | TITLE: Et ce que je ne ferai pas sans instruction | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] HAO ET GLASSMAN, LU AU FOND — *la source la plus riche de la campagne, et elle COUPE contre notre dessin*

:SOURCE: Rebecca L. Hao et Elena L. Glassman, « Approaching Polyglot Programming: What Can We Learn from Bilingualism Studies? », PLATEAU 2019, sept pages, accès libre — *article de positionnement, qui RECENSE des mesures sans en produire*

1.  LE RÉSULTAT QUI COUPE — *la SIMILITUDE augmente l'interférence, et nos trois couches sont maximalement similaires*

    Parmi les acquis de psycholinguistique que l'article recense :

    > « ***Une langue plus proche de la langue voulue s'est révélée avoir davantage d'influence sur elle qu'une langue plus éloignée.*** »

    **Lisons ce que cela dit de K7PL.** Nos trois couches partagent les expressions symboliques, le lecteur, le lexique, la mise en page. ***Elles sont aussi proches que deux langues peuvent l'être — donc, selon ce résultat, le CAS LE PIRE pour l'interférence.*** **Et le second acquis aggrave le premier** : les interférences dynamiques — « brèves intrusions » d'une langue dans l'autre — « sont plus susceptibles de survenir ***quand on est stressé, fatigué ou ému*** ». ***Un lecteur fatigué appliquera les règles de la couche 2 à un fragment de couche 3, et la ressemblance des trois couches l'y invite.*** **C'EST LA SONDE LA PLUS SÉRIEUSE QUE LA CAMPAGNE AIT PRODUITE CONTRE LE DESSIN ACTUEL.** /Elle ne conteste pas l'architecture — les couches sont un fait sémantique — mais son EXPRESSION : si le délimiteur est la seule marque distinguant trois régimes par ailleurs identiques à l'œil, il porte à lui seul une charge que la littérature dit lourde./ **Deux issues, et il faut choisir** : ou bien le délimiteur est renforcé — plus visible, plus redondant — ou bien les couches se distinguent davantage en surface. ***Le document n'a jamais envisagé la seconde, et l'arbitrage 1 suppose la première sans le dire.*** **À instruire.**

2.  ET LE RÉSULTAT QUI SAUVE — *commuter aux frontières de phrase coûte moins*

    > « Des nourrissons manifestent une charge cognitive par dilation pupillaire involontaire et fixations oculaires lorsqu'ils entendent des changements de langue. Ces effets étaient toutefois ***réduits lorsqu'on allait d'une langue non dominante vers la dominante, et lorsque le changement de langue franchissait une frontière de phrase***. »

    ***Commuter à une frontière structurelle coûte moins que commuter en son milieu.*** **C'est un argument MESURÉ pour l'arbitrage 1, et il en précise la formulation.** /L'arbitrage dit que le délimiteur marque le point où le fragment change. Ce résultat dit OÙ ce point doit tomber : sur une frontière de forme, jamais à l'intérieur d'une expression./ **Et il ajoute une asymétrie de sens** : le coût est moindre en allant du *non dominant* vers le *dominant*. /Pour nous : entrer dans la couche 3 depuis la couche 2 — du familier vers le spécialisé — serait le sens coûteux, et en sortir le sens économique. À vérifier, mais c'est une prédiction testable./

3.  L'ASYMÉTRIE DU CONTRÔLE — *le coût est dans la SORTIE, non dans l'entrée*

    > « Une étude récente suggère que ***désactiver une langue exige un contrôle cognitif, tandis qu'activer une nouvelle langue peut ne pas en exiger***. \[…\] Des bilingues langue des signes-anglais présentaient une activité accrue dans les aires du contrôle cognitif ***en désactivant une langue, mais pas en en activant une***. »

    Et, contre l'intuition : « employer les deux langues simultanément n'entraînait pas nécessairement un coût cognitif supérieur à produire une seule langue ». ***Ce n'est pas la coactivation qui coûte, c'est la SUPPRESSION.*** **Conséquence pour nos délimiteurs, et elle est neuve** : entrer dans un fragment de couche 3 est bon marché ; ***en sortir — c'est-à-dire cesser d'appliquer ses règles — est ce qui coûte***. *Le projet a toujours pensé le délimiteur par son ouverture. Ce résultat dit que sa FERMETURE est le moment coûteux.* **Aucun document ne l'a envisagé.**

4.  UNE MESURE SUR LES PROJETS MULTI-LANGAGES, ET ELLE VISE NOS COUCHES

    L'article recense Kochhar et al., 2016, appliquant à un corpus de projets GitHub populaires la méthode de Ray et al. :

    > « Ils ont trouvé qu'en général, \*/les projets employant davantage de langages de programmation étaient plus sujets aux bogues, en particulier pour les bogues de MÉMOIRE, de CONCURRENCE et d'ALGORITHMIQUE/\*. »

    **Les trois catégories nommées sont exactement ce que nos couches 1 et 2 traitent.** ***La réserve est de taille et il faut la tenir*** : K7PL est *un* langage à trois régimes, non trois langages ; le corpus mesure des projets employant des langages distincts avec des chaînes d'outils distinctes. **Mais le mécanisme invoqué par l'article — le changement de code — est présent dans les deux cas, et c'est ce mécanisme qui est étudié.** *À consigner comme avertissement, non comme réfutation.*

5.  DEUX APPORTS DE MÉTHODE, DIRECTEMENT UTILISABLES

    1.  ***Une taxinomie des granularités de commutation***, que le projet n'avait pas : « commuter à l'intérieur d'une ligne, commuter à chaque ligne, commuter aux *blocs logiques* — là où l'auteur a stylistiquement inséré une ligne vide pour la lisibilité — et commuter entre fichiers ». **Quatre échelles.** *Le chapitre 5 ne dit à aucune d'elles où nos délimiteurs tombent, et c'est une question qui se pose maintenant.*
    2.  ***Un protocole transposable*** : « pour étudier si lire et comprendre du code multilingue entraîne un coût cognitif, nous pourrions présenter des programmes en différentes langues et observer l'oculométrie ou la dilation pupillaire ». **Le protocole d'ergonomie n'avait que le magicien d'Oz ; en voici un second, et il mesure exactement notre question.**

    **Et une observation utile pour l'amorçage** : le changement de code, « bien qu'il ne soit ni conscient ni intentionnel, ***est souvent gouverné par des règles : il y a des motifs systématiques à la façon dont et au moment où les locuteurs commutent*** ». /Un lecteur commute donc naturellement, et selon des règles. La question 25 n'est pas de lui apprendre à commuter — c'est de lui faire voir où./

6.  DÉNOMBREMENT ET STATUT

    **Article de positionnement, sept pages, quatre questions ouvertes, vingt et une références.** ***Il ne produit aucune mesure : il en recense, et propose des méthodes.*** **Sa valeur pour nous est double et il faut la dire exactement** : /le cadre et le vocabulaire d'une part — changement de code, interférence, modes de parole, granularités — et d'autre part QUATRE résultats mesurés qu'il rapporte de la psycholinguistique et de l'étude de Kochhar./ **Aucun de ces résultats ne porte sur des langages de programmation, sauf le dernier.** /C'est la réserve, et elle est la même que pour Stefik : le cadre est solide, le transfert est une hypothèse./

#### FERDOWSI, « THE USABILITY OF ADVANCED TYPE SYSTEMS » — *la source la plus conséquente de tout le dépouillement*

:SOURCE: Kasra Ferdowsi, examen de recherche, 27 avril 2022 — *revue de littérature sur l'utilisabilité des types linéaires et de propriété, avec Rust comme cas d'étude*

1.  Pourquoi elle domine

    C'est ***la seule source qui recense, avec leurs dénombrements, les mesures faites sur une discipline du même genre que la nôtre***. **Elle ne parle pas de syntaxe : elle parle de ce que coûte, à des humains, un système de types qui refuse des programmes.** *Elle est donc à l'arc ce que Stefik est à la notation.*

2.  LE RÉSULTAT PRINCIPAL — *LA PROPRIÉTÉ SEULE NE COÛTE RIEN DE MESURABLE ; C'EST L'ALIASING QUI COÛTE*

    Étude contrôlée de Coblenz et al., 2021, sur ***428 étudiants*** de deuxième année, deux semaines de cours sur Rust puis un devoir exigeant une bonne compréhension de la propriété. Deux groupes tirés au sort : l'un avec les types de la bibliothèque standard, l'autre avec `Bronze`, une enveloppe à ramasse-miettes admettant davantage de motifs d'aliasing.

    > « Les étudiants employant `Bronze` ont mis en moyenne ***le tiers du temps***, et avaient environ ***2,44 fois plus de chances d'achever le devoir***. Fait intéressant, \*/la différence de temps n'apparaissait QUE dans la seconde partie de la tâche, celle qui impliquait de l'aliasing et de la mutabilité complexes. La première partie, centrée sur la seule PROPRIÉTÉ, ne montrait aucune différence significative entre les groupes./\* »

    ***LA DERNIÈRE PHRASE EST LE RÉSULTAT MESURÉ LE PLUS IMPORTANT DE TOUT LE DÉPOUILLEMENT POUR K7PL.*** **Lisons-la.** *La discipline de propriété, seule, ne produit aucun surcoût mesurable. Le surcoût — d'un facteur trois — apparaît quand s'y ajoutent l'aliasing et la mutabilité complexes.* **Or c'est précisément ce que notre architecture en couches réduit par construction** : la couche 3 est pure et sans effets — *ni mutabilité, ni aliasing observable* — et la couche 1 est linéaire, donc sans partage. ***Le lieu mesuré de la douleur est celui que nos couches retirent.*** **C'est l'argument empirique le plus fort en faveur de l'architecture, et il ne vient pas de nous.** *RÉSERVE : l'étude porte sur des étudiants de deuxième année après deux semaines de cours, et sur Rust. Le transfert est une hypothèse, non un acquis.*

3.  LA CAUSE, ET ELLE VISE NOTRE SOLVEUR — *« la malédiction de l'incomplétude »*

    > « Les règles de propriété sont simples et faciles à apprendre, mais les vérifier statiquement, “comme la plupart des propriétés intéressantes de programmes”, est indécidable. La mise en œuvre de ces règles dans le vérificateur d'emprunt est donc ***nécessairement incomplète***, et ***beaucoup des problèmes d'utilisabilité viennent de cet ÉCART entre la compréhension qu'a le programmeur des règles et la capacité du vérificateur à les prouver***. »

    Et la citation qui l'illustre : « \*/Je peux enseigner les trois règles de la propriété en un seul cours à une salle d'étudiants. Mais les caprices du vérificateur d'emprunt me font encore trébucher chaque fois que j'emploie Rust !/\* » **L'article donne les cas.** Deux programmes qui font la même chose, un seul passe. Et deux lignes « ***presque identiques au niveau des types, dont une seule passe, vraisemblablement à cause d'un détail d'implémentation*** ». ***C'EST EXACTEMENT LA SITUATION QUI ATTEND K7PL.*** \*Nos règles de grade sont simples ; notre solveur sera incomplet ; et l'écart entre « ce que les règles autorisent » et « ce que le solveur sait prouver » est le lieu où la douleur se logera.\* **Le document a une exigence de compilation bornée et un profil de vérification.** /Il n'a jamais dit à quoi ressemble un programme légal selon les règles mais rejeté par le solveur, ni ce qu'on répond à son auteur./ ***Question neuve, et c'est la plus sérieuse que la campagne ait produite pour l'arc précédent.***

4.  LES MESSAGES D'ERREUR — *deux résultats mesurés, et ils condamnent l'approche locale*

    **Coblenz et al., partie qualitative** : les messages de `rustc` suggèrent des corrections, mais « ***ces corrections sont toujours LOCALES et ne fournissent aucun retour de conception de haut niveau***, qui serait pourtant utile pour opérer le changement de perspective. Au mieux, elles amenaient les étudiants à effectuer ***une chaîne de corrections locales aboutissant à un code qui compile sans qu'ils comprennent pourquoi***. Au pire, elles pouvaient être ***cycliques*** — “des choses comme : retire le `&`, puis après l'avoir retiré, essaie d'en ajouter un” ». Conclusion des auteurs : les messages de Rust « n'aident ni à la conception ni à la compréhension ». **Zhu et al., analyse de tâche cognitive sur 110 erreurs de propriété**, comparant les étapes des experts au contenu du message : « pour la plupart des erreurs le message contenait toute l'information pertinente, mais ***pour 32 erreurs il n'expliquait pas “les étapes clés du calcul d'une durée de vie ou d'une relation d'emprunt”***, 10 autres n'expliquaient pas la relation entre deux annotations, et 9 comment une règle de sûreté s'applique à une construction donnée. » **ET LA CAUSE PROFONDE EST UN DÉSACCORD DE NIVEAU.** Les auteurs de l'étude sur `Bronze` concluent que « ***l'essentiel du bénéfice du ramasse-miettes vient de la SIMPLIFICATION ARCHITECTURALE*** » et que « la conception a contribué significativement à l'écart de performance ». ***Une discipline qui force des décisions ARCHITECTURALES ne peut pas s'expliquer par des diagnostics LOCAUX.*** **C'est la réponse à la question 30, et elle est plus exigeante que prévu** : il ne s'agit pas de choisir le vocabulaire du message — « `dup` exige un type copiable » contre « violation de contrainte de grade » — *il s'agit de savoir si le diagnostic parle au niveau où se situe la faute*. **Un budget dépassé n'est pas une faute locale : c'est une décision de structure.**

5.  LE MOT « INTERFÉRENCE » REVIENT, PAR UN AUTRE CHEMIN — *et c'est la seconde occurrence indépendante*

    Shrestha et al., 2020, ont codé 450 messages de forum sur 18 langages et interrogé 16 professionnels. Ils empruntent à la psychologie le terme d'***interférence*** : « quand ***une connaissance antérieure perturbe le rappel d'une information nouvellement apprise*** ». Cela va de l'indexation à zéro ou à un jusqu'aux différences exigeant un « changement de perspective ». \*/Deux articles de cette campagne, venus de littératures différentes — psycholinguistique du bilinguisme et psychologie de l'apprentissage — emploient le même mot pour le même phénomène, et tous deux s'appliquent à nous./\* **Le terme est donc établi, et il devrait entrer au vocabulaire du projet.**

6.  LA CHAÎNE DE DÉNOMBREMENTS, POUR MÉMOIRE

    |  |  |
    |----|----|
    | Zeng et Crichton, analyse de contenu de 18 retours d'expérience | le vérificateur d'emprunt est ***la deuxième plainte la plus fréquente*** — ***la première étant les versions du compilateur, donc l'OUTILLAGE*** |
    | Fulton et al., 16 entretiens puis 178 réponses | la courbe d'apprentissage est le plus sérieux obstacle à l'adoption, et « le plus grand défi était spécifiquement le vérificateur d'emprunt » |
    | Enquête de la communauté Rust, ***8 323 réponses*** | ***les durées de vie sont le sujet le plus difficile à apprendre*** |
    | Zhu et al., 100 questions de forum | la cause la plus fréquente de violation est le « calcul complexe de durée de vie », ***74 cas sur 100*** |
    | Qin et al., cinq systèmes, cinq bibliothèques, deux bases de vulnérabilités | des bogues bloquants viennent d'une mauvaise compréhension des durées de vie, ***chez des développeurs expérimentés*** |

    **DEUX CHOSES À RETENIR, ET LA SECONDE EST À NOTRE AVANTAGE.**

    1.  ***La première plainte n'est pas le système de types, c'est l'outillage.*** /À consigner honnêtement : cela pèse du côté de la falsification que la campagne a par ailleurs écartée pour la notation./
    2.  ***Le point de douleur nommé n'est pas la propriété, c'est la DURÉE DE VIE*** — l'appareil des annotations `'a`, de leur élision, de leur calcul. **K7PL n'a pas de durées de vie.** /Il a des grades et un transfert de couche. C'est une différence structurelle réelle, et elle porte précisément sur ce que la littérature mesure comme le plus coûteux./

## LE CORPUS CHARGE COGNITIVE, HCI ET CONCEPTION DE LANGAGE — *vingt-neuf articles, fournis le 7 août*

**Ce corpus recouvre exactement ce que la campagne autonome avait identifié sans pouvoir l'atteindre.** *Il change la nature de l'entrée : T-63 cessait d'être une collecte de doléances pour devenir une revue de littérature.*

### GRIS-Cartographie

    AUTHORS | DATE | TITLE: CARTOGRAPHIE — faite avant lecture, comme l'instrument l'exige | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Ce qui vise nos questions ouvertes, par ordre de proximité

|  |  |
|----|----|
| ***« The Hidden Burden of Keywords »***, Mason et Seton | notre LEXIQUE, et la langue du lecteur |
| ***« Identifier Names, Comprehension and Code Metrics »***, Herka | P-3, revue de littérature |
| ***« Measuring the Impact of Lexical and Structural Inconsistencies on Developers' Cognitive Load »*** | P-3 et la cohérence |
| ***« Cognitive Load in Programming Education: Easing the Burden on Beginners with REXX »***, Winkler et Flatscher | *cite Stefik et Siebert* |
| ***« Evaluating Code Readability and Legibility »***, Oliveira et al. | T-61, et il distingue LISIBILITÉ et LÉGIBILITÉ |
| ***« Ecological Design-Based Research for Computer Science Education »*** | le cadre écologique de P-4 |
| ***« A Survey of Metaprogramming Languages »***, Lilis et Savidis | B6 et les macros, taxinomie |
| ***« Usability Evaluation of Domain-Specific Languages »***, Rodrigues et al. | l'utilisabilité d'un langage dédié — nos couches |
| ***« An EEG Study on Cognitive Load in Visual and Textual Programming »*** | notation mesurée à l'électroencéphalogramme |
| ***« Fifty years of the Psychology of Programming »***, Blackwell, Petre et Church | la rétrospective du domaine lui-même |

#### Ce qui outille le protocole d'ergonomie

*« Measuring the Cognitive Load of Software Developers: A Systematic Mapping »* ; *« A Survey on Measuring Cognitive Workload in Human-Computer Interaction »*, Kosch et al. ; *« Flipping the Assessment of Cognitive Load »*, Mason et Simon ; *« Examining Factors Influencing Cognitive Load of Computer Programmers »* ; et *« Cognitive Load Theory in the Context of Teaching and Learning Computer Programming: A Systematic Review »*, Berssanette et de Francisco. ***Cinq sources de méthode, dont deux revues systématiques et une enquête sur les instruments de mesure.*** **Le protocole n'avait que le magicien d'Oz et deux idées glanées ; il a maintenant un socle.**

#### Ce qui sert T-60 et l'apprentissage

*« Students' Misconceptions and Other Difficulties in Introductory Programming »*, Qian et Lehman ; *« Towards an Analysis of Program Complexity From a Cognitive Perspective »* ; *« Comparing Cognitive Load Among Undergraduate Students Programming in Python and the Visual Language Algot »* ; l'article de synthèse sur les langages à blocs.

#### Et le reste, noté sans être classé

*« Clarifying and Differentiating Discoverability »* — qui touche la question 25, l'amorçage — deux articles sur l'*expérience du programmeur* comme champ, une revue comparative sur la programmation par aspects, un article de génie des langages, et une longue revue sur les langages destinés aux enfants.

### GRIS-PremireFiche

    AUTHORS | DATE | TITLE: PREMIÈRE FICHE — « THE HIDDEN BURDEN OF KEYWORDS », et elle vise notre lexique de plein fouet | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT DE CONCEPTION, ET IL EST CONTRE-INTUITIF

L'étude oppose deux familles de mots-clés : ceux qui ***réemploient un mot anglais courant*** — `class`, `if`, `else` — et ceux qui sont ***tronqués ou construits*** — `def`, `elif`, `__init__`. Et la prédiction théorique qu'elle éprouve mérite d'être citée entière :

> « ***Les termes construits n'offrent aucun avantage de schéma à quiconque***, puisque ni les anglophones natifs ni les étudiants pour qui l'anglais est une langue additionnelle ne disposent de structures préexistantes en mémoire à long terme pour ces constructions nouvelles. La théorie de la charge cognitive prédit donc que \*/le bagage linguistique devrait affecter différemment la performance sur les mots-clés RÉEMPLOYÉS — où la disponibilité du schéma varie — mais pas nécessairement sur les mots-clés CONSTRUITS, où tous les apprenants affrontent une nouveauté équivalente/\*. »

***UN MOT-CLÉ EMPRUNTÉ À L'ANGLAIS COURANT AVANTAGE LES ANGLOPHONES ET CRÉE DEUX CLASSES DE LECTEURS. UN TERME CONSTRUIT EST ÉQUITABLE.*** **C'est exactement l'inverse de l'intuition qui gouverne la conception des langages**, et cela vise K7PL directement. *P-2 veut « une variante en anglais » pour chaque glyphe. P-3 veut un nommage impératif « action-portée », qui est une construction grammaticale anglaise.* **Ce que cela change** : le choix entre un lexique en mots anglais courants et un lexique en termes forgés n'est pas un choix de goût. ***C'est un choix d'ÉQUITÉ entre lecteurs, et le corpus dit que le terme forgé est le choix équitable.*** /Cela ne tranche pas — un terme forgé est plus difficile pour TOUT LE MONDE, ce qui est un coût global contre un coût réparti — mais cela pose l'arbitrage dans les bons termes, et le document ne l'avait jamais posé./ **Question neuve, et elle touche P-2, P-3 et le lexique de la phase 5.**

#### LE RÉSULTAT EMPIRIQUE, ET IL EST SOMBRE

> « Les résultats ont révélé ***aucune amélioration significative de l'exactitude d'identification*** — semaine 1 : 39,80 % ; semaine 6 : 48,16 % — ***ni de l'exactitude de classification*** — 40 % aux deux moments — ***malgré un enseignement intensif***. La charge cognitive extrinsèque rapportée a significativement ***AUGMENTÉ*** de la semaine 1 à la semaine 6 (p = 0,039 ; d = 0,99), ***contredisant les prédictions de la théorie de la charge cognitive selon lesquelles l'automatisation des schémas réduit la charge extrinsèque avec l'expérience***. »

Et la conclusion des auteurs : « les résultats brossent un tableau ***préoccupant*** : après six semaines d'enseignement intensif — environ dix-huit heures d'enseignement direct plus une pratique substantielle — ***les étudiants n'ont montré aucune amélioration mesurable*** de leur capacité à identifier ou classer les mots-clés de Python. » **Et un détail qui frappe** : « ***100 % des étudiants*** ayant identifié des mots-clés ont aussi manqué des occurrences répétées, ce qui indique un traitement incomplet universel ». ***Reconnaître les mots-clés d'un langage est bien plus difficile que quiconque ne le suppose, et le schéma ne se forme pas en six semaines.***

#### ET LE RÉSULTAT QUI PARLE À ANTHEA DIRECTEMENT

« Les étudiants pour qui l'anglais est une langue additionnelle ont rapporté une charge cognitive ***intrinsèque significativement plus élevée*** (p = 0,030 ; d = 0,91) et une exactitude d'identification marginalement plus faible (p = 0,058 ; d = −0,54). » \*Le cadrage de T-63 avait relevé que six fils du recueil Reddit étaient francophones et que c'était « la seule fenêtre sur une communauté qui ne programme pas dans la langue de ses mots-clés ».\* ***En voici la version mesurée : la barrière est réelle, elle est chiffrée, et elle persiste après un enseignement substantiel.*** *Un concepteur francophone écrivant un langage à mots-clés anglais impose donc à sa propre communauté un surcoût que la littérature documente.* **À porter au corps, et à la question du lexique.**

#### DÉNOMBREMENT ET RÉSERVES

**27 étudiants — 15 en langue additionnelle, 12 natifs — un cours, un langage, six semaines.** *Petit effectif ; les tailles d'effet sont grandes mais l'étude est exploratoire et ses auteurs le disent.* **Elle porte sur des NOVICES et sur la RECONNAISSANCE de mots-clés, non sur la compréhension de programmes par des praticiens.** ***Ce qu'elle établit solidement*** : que la question du lexique est mesurable, qu'elle a un versant d'équité linguistique, et que l'intuition « un mot anglais courant est plus facile » est au mieux incomplète. ***Ce qu'elle n'établit pas*** : ce qu'il faut faire à la place.

### GRIS-HerkaIdentifierNamesComprehensionAndCodeMetr

    AUTHORS | DATE | TITLE: HERKA, « IDENTIFIER NAMES, COMPREHENSION AND CODE METRICS » — P-3 a une littérature, et elle est fragile | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Ce que l'existence de cette revue établit

***Trente-cinq études sur quarante-deux ans portant sur les noms d'identifiants et la cognition du programmeur.*** **La question de P-3 n'est donc pas neuve, elle est instruite depuis 1979, et le projet l'ignorait entièrement.** Et le motif que la revue rappelle : « quel que soit le modèle de compréhension retenu — descendant, ascendant ou opportuniste — ***les programmeurs passent un temps significatif à lire les identifiants***, ce qui souligne leur rôle crucial dans la compréhension ». *À rapprocher du chiffre déjà relevé : les identifiants sont 70 % du code source.*

#### LE CORRECTIF, ET IL VISE NOTRE PROPRE BASE DE PREUVES

La discussion de la revue est pour l'essentiel une critique méthodologique du domaine : signalement incomplet des procédures expérimentales — « il devient difficile ou impossible pour d'autres chercheurs de répliquer l'étude » — sur-recours aux projets libres, absence totale de code industriel fermé, homogénéité des cultures de programmation représentées. **Et surtout ceci, qui nous concerne directement** :

> « Plusieurs études employaient des métriques fondées sur des catalogues pour évaluer la qualité des identifiants. \[…\] De telles métriques sont ***intrinsèquement subjectives***, dépendant de perceptions individuelles ou collectives plutôt que de critères objectifs. \[…\] \*/Les perceptions de la qualité d'un identifiant diffèrent largement selon les communautés, les langages et les paradigmes. Un identifiant tenu pour de grande qualité dans un contexte peut être jugé médiocre dans un autre./\* Se fier à des métriques fondées sur l'opinion ou le consensus pour évaluer la qualité d'un identifiant peut donc conduire à des jugements peu fiables. »

***IL FAUT LIRE CELA CONTRE NOTRE PROPRE DOSSIER.*** **Le soutien de P-3 réuni jusqu'ici est de deux natures** : *deux mesures* — l'oculométrie de Sharif et Maletic, la proportion de 70 % — et ***beaucoup de consensus*** : les deux messages les mieux approuvés du fil sur les microfonctionnalités, le guide de style de LFE, la prescription d'Emacs, la devinabilité tirée d'un fil de forum. ***Or cette revue dit précisément que le consensus est un mauvais juge en cette matière, et que la qualité d'un identifiant est relative à une communauté.*** **Ce n'est pas une réfutation de P-3 — c'est un rappel sur le poids de ses appuis.** /Les deux mesures tiennent ; le reste est de l'opinion attestée, et l'instrument le disait déjà. Cette revue ajoute qu'en matière de nommage, l'opinion attestée vaut moins qu'ailleurs./ **À écrire dans P-3, faute de quoi le dossier paraîtra plus solide qu'il n'est.**

### GRIS-OliveiraEtAlEvaluatingCodeReadabilityAndLegi

    AUTHORS | DATE | TITLE: OLIVEIRA ET AL., « EVALUATING CODE READABILITY AND LEGIBILITY » — la distinction que T-61 cherchait | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT — *deux mots, deux choses, et l'arc les confondait*

> « \[…\] la ***LISIBILITÉ*** du code, c'est-à-dire ***ce qui rend un programme plus ou moins facile à lire et à saisir*** par des développeurs, et la ***LÉGIBILITÉ*** du code, c'est-à-dire ***ce qui influence la facilité à IDENTIFIER LES ÉLÉMENTS d'un programme***. »

***Identifier les éléments, et saisir le sens, sont deux opérations distinctes, et la littérature leur donne deux noms.*** **RELISONS TOUT LE DÉPOUILLEMENT AVEC CETTE DISTINCTION, ET IL SE RANGE.**

|  |  |
|----|----|
| la parenthèse, le glyphe, le délimiteur, la casse d'un identifiant, l'espace significative | ***LÉGIBILITÉ*** |
| le grade, la couche, l'effet, ce que le programme fait | ***LISIBILITÉ*** |

- Joswig : « le code peut être lu sans analyse syntaxique extensive » → ***légibilité***, et c'est un crédit ;
- le lecteur francophone : « le LISP quand on ne connaît pas, on ne comprend pas grand-chose » → ***légibilité***, et c'est un débit ;
- Ruby : « il est aussi facile d'écrire du beau code que du mauvais » → ***lisibilité*** ;
- « je préfère écrire du Lisp, mais Python est plus facile à lire » → ***les deux à la fois***, et c'est pourquoi la phrase paraissait insaisissable.

***T-61 disposait de trois LIEUX et de trois ÉCHÉANCES. Voici la troisième dimension, et c'est celle qui coupe à l'intérieur de la lisibilité.*** **Le mot désignait neuf choses ; il en désigne dix-huit, et c'est un progrès — chacune est maintenant nommable.** **ET UNE CONSÉQUENCE IMMÉDIATE POUR L'ARC** : /la plupart de nos questions ouvertes portent sur la LÉGIBILITÉ — les questions 23, 24, 27, la place du glyphe, le budget de caractères. Nos acquis les plus solides — l'arbitrage 3, la discipline de grade, les couches — portent sur la LISIBILITÉ./ **Ce sont deux chantiers, et les confondre explique une partie de la difficulté qu'a eue l'arc à se cadrer.**

#### ET UN CONSTAT DE MÉTHODE, POUR LE PROTOCOLE D'ERGONOMIE

Sur les 54 études recensées : « la plupart évaluent la lisibilité et la légibilité en mesurant ***l'exactitude des résultats des sujets (83,3 %)*** ou en leur demandant simplement ***leur opinion (55,6 %)***. Certaines études (***16,7 %***) s'appuient ***exclusivement*** sur cette dernière variable. Il y a encore peu d'études qui suivent des signes physiques, comme les régions d'activation cérébrale (***5 %***). » **Une étude sur six ne repose que sur l'opinion.** *C'est le même avertissement que celui de Herka, chiffré.* **Et cela fixe l'ambition du protocole d'ergonomie : mesurer l'exactitude sur une tâche est la méthode dominante, elle est accessible, et elle vaut mieux que le questionnaire.** **Enfin, une remarque des auteurs qu'il faut retenir** : « certaines variables sont ***multi-facettes*** — par exemple l'exactitude ». *Une bonne réponse peut venir d'une bonne compréhension ou d'une devinette heureuse, et le protocole devra en tenir compte.*

### GRIS-BlackwellPetreEtChurchFiftyYearsOfThePsychol

    AUTHORS | DATE | TITLE: BLACKWELL, PETRE ET CHURCH, « FIFTY YEARS OF THE PSYCHOLOGY OF PROGRAMMING » — et le champ nous dit que notre question est mal posée | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT DOMINANT DE TOUT LE CORPUS — *L'ANTI-SUPERLATIVISME*

**L'arc demande depuis T-57 : quelle notation est meilleure ?** *Le domaine a répondu à cette question en 1973, dans son tout premier article, et il a passé cinquante ans à la confirmer.*

> « Des affirmations apparemment universelles sur l'essence cognitive de la programmation pouvaient aisément se confondre avec des plaidoyers en faveur de tel langage ou paradigme, au motif qu'ils seraient plus “naturels”. \*/Cette conclusion n'était pas conforme aux premiers résultats du domaine — dont l'article de 1973 de Sime, Green et Guest, qui avait observé précisément le contraire : que la meilleure forme de représentation pour un problème donné dépendait de LA STRUCTURE DE CE PROBLÈME./\* »

**Et le mot que le domaine s'est donné pour désigner l'erreur** : le ***SUPERLATIVISME*** — la croyance « qu'un langage ou un trait de langage particulier serait ***universellement supérieur*** ». Green et al. lui opposent en 1991 la position dite ***adéquation-inadéquation*** (*match-mismatch*), « qui tient compte de l'accessibilité de l'information ***pour une tâche donnée*** ». ***IL N'Y A PAS DE MEILLEURE NOTATION. IL Y A DES NOTATIONS QUI CONVIENNENT À DES TÂCHES.*** **Ce résultat range rétrospectivement tout le dépouillement de T-57 et de T-63.** /Les parenthèses de Lisp, les mots-clés de Cognate, la pile de Koneko, les blocs, l'APL : chacune de ces disputes oppose des gens qui font des tâches différentes, et le corpus dit qu'aucun camp n'a tort. « Le LISP quand on ne connaît pas » et « le code peut être lu sans analyse syntaxique extensive » sont deux mesures d'adéquation à deux tâches, non deux jugements contradictoires sur un même objet./ **ET LA CONSÉQUENCE POUR L'ARC EST DIRECTE** : ***une question de la forme « faut-il le glyphe ou le mot ? » est mal posée tant que la TÂCHE n'est pas nommée.*** *Nos questions ouvertes 23, 24, 27 sont toutes de cette forme. Elles doivent être reformulées avec leur tâche.* **Le dépouillement a passé une campagne entière à chercher le camp qui a raison. Le domaine dit qu'il n'y en a pas — et cela vaut mieux qu'une réponse, parce que c'est une méthode.**

#### L'INSTRUMENT QUE LE DOMAINE A PRODUIT — *les dimensions cognitives des notations*

De cette révision est né le cadre des ***dimensions cognitives des notations*** (Green et Petre, 1996), « ***devenu le travail le plus cité du domaine***, et aussi la publication la plus citée de la revue d'informatique où il a paru ». La méthode : « identifier ***les traits de conception des outils de programmation qui sont cognitivement pertinents***, et les rapporter aux ***types particuliers de tâches*** pour lesquels ils sont bénéfiques ou non, avec les compromis associés ». **ET LA REMARQUE DES AUTEURS EST PLUS UTILE ENCORE, PARCE QU'ELLE EST DÉSABUSÉE** : le legs du cadre tient « ***indépendamment du fait que la part “cognitive” de cette théorie soit bien moins pertinente que la théorie IMPLICITE DE LA CONCEPTION qu'elle incarne*** ». *Autrement dit : ce qui a servi, ce n'est pas la psychologie — c'est d'avoir donné aux concepteurs une grille de vocabulaire pour discuter leurs compromis.* **C'est exactement ce que T-61 cherche à faire pour l'élégance, et le précédent est établi.**

#### ET UN AVERTISSEMENT SUR CE QU'ON PEUT ATTENDRE DE CETTE LITTÉRATURE

> « ***Peu des théories qui en résultent ont été définitives***, et dans l'ensemble, on a plutôt ajouté des idées qu'on n'en a renversé. ***Beaucoup de questions n'ont pas été résolues de façon concluante, mais c'est apparemment là le propre de la discipline.*** »

**À poser franchement dans l'instrument.** /Le projet a abordé ce corpus en espérant y trouver des arbitrages. Les auteurs du domaine disent qu'il n'en fournit pas, et qu'il n'est pas fait pour cela./ **Ce qu'il fournit : du vocabulaire, des méthodes de mesure, et des réfutations d'intuitions fausses.** *Les trois nous ont déjà servi. Aucun arbitrage ne viendra de là, et c'est une raison de plus pour que le protocole d'ergonomie existe.*

### GRIS-IsseverCatalbasEtDuranExaminingFactorsInflue

    AUTHORS | DATE | TITLE: ISSEVER, CATALBAS ET DURAN, « EXAMINING FACTORS INFLUENCING COGNITIVE LOAD OF COMPUTER PROGRAMMERS » — la question 41 confirmée par une autre route, e | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT, ET IL TOMBE EXACTEMENT SUR NOTRE QUESTION 41

L'étude convertit la langue maternelle de chaque programmeur en une variable quantitative — la ***distance linguistique*** à l'anglais, empruntée à la linguistique — puis mesure la part de chaque facteur personnel dans la charge cognitive observée à l'oculomètre.

> « L'un des résultats importants et ***neufs*** de cette étude est que \*/la distance linguistique entre la langue maternelle d'un programmeur et l'anglais a un effet significatif sur la charge cognitive (15,404 %)/\*. »

**Le classement complet des facteurs personnels** :

|                                         |                |
|-----------------------------------------|----------------|
| âge                                     | 18,047 %       |
| ***distance linguistique à l'anglais*** | ***15,404 %*** |
| \[…\]                                   |                |
| sexe                                    | 0,255 %        |

***LA LANGUE MATERNELLE DU LECTEUR EST LE DEUXIÈME FACTEUR PERSONNEL DE CHARGE COGNITIVE, DERRIÈRE L'ÂGE, ET SOIXANTE FOIS DEVANT LE SEXE.*** **ET C'EST UNE CONFIRMATION INDÉPENDANTE.** /Mason et Seton mesuraient 27 étudiants novices par questionnaire de charge ; Issever et al. mesurent 216 programmeurs par oculométrie, sur un jeu de données qu'ils n'ont pas constitué, avec une méthode entièrement différente. Deux routes, deux instruments, deux populations — même résultat./ **La question 41 cesse d'être une question ouverte fondée sur une seule étude exploratoire.** ***Elle repose maintenant sur deux mesures convergentes, et elle est la seule question de l'arc dans ce cas.*** Les auteurs concluent : « nous avons observé que non seulement la langue maternelle parlée, mais aussi ***la distance linguistique de cette langue à l'anglais***, affectaient significativement la charge cognitive ». /RÉSERVE : l'analyse de corrélation canonique établit une part de variance, non un mécanisme. Elle ne dit pas que ce sont les MOTS-CLÉS qui coûtent — la documentation, les messages d'erreur, les noms d'identifiants et la littérature technique sont tous en anglais. C'est un faisceau, pas une imputation./ **Mais le faisceau vise notre lexique, et il est chiffré.**

### GRIS-ThorgeirssonEtAlAnElectroencephalographyStud

    AUTHORS | DATE | TITLE: THORGEIRSSON ET AL., « AN ELECTROENCEPHALOGRAPHY STUDY ON COGNITIVE LOAD IN VISUAL AND TEXTUAL PROGRAMMING » — la nouveauté d'une notation ne coûte pa | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT, ET IL EST RASSURANT POUR UN LANGAGE NEUF

Les sujets connaissaient Python et découvraient Algot — une notation visuelle — après une brève introduction.

> « Les étudiants ont obtenu ***des résultats significativement meilleurs*** en programmant avec Algot, mais ***les niveaux de charge cognitive étaient similaires selon les deux instruments***. Nos résultats fournissent des indices que, dans le domaine testé, \*/Algot peut être appris rapidement, et que les étudiants ne le trouvent pas plus exigeant cognitivement que de travailler dans un langage familier/\*. »

***UNE NOTATION INCONNUE, APRÈS UNE BRÈVE INTRODUCTION, N'A PAS COÛTÉ PLUS DE CHARGE QU'UNE NOTATION CONNUE.*** **Cela vise une objection que le dépouillement a rencontrée partout** : *« votre notation est étrange, donc elle coûtera » — le reproche fait à Lisp, à l'APL, à Koneko, à Cognate.* \*Ce résultat dit que l'étrangeté d'une notation, prise seule, ne se traduit pas mécaniquement en charge mesurable.\* **ET IL FAUT LE LIRE AVEC L'ANTI-SUPERLATIVISME, QUI EST DANS LE MÊME CORPUS.** /Algot n'est pas « meilleur » ; il est mieux adéquat à une tâche de récursion pour des débutants. Les auteurs le disent eux-mêmes en réserve : « à mesure que les tâches deviennent plus difficiles, il est probable que les étudiants aient besoin de davantage d'exposition à Algot »./

#### ET UN AVERTISSEMENT DE MÉTHODE QUI VAUT POUR NOTRE PROTOCOLE

Les deux instruments — électroencéphalogramme et questionnaire — ne concordent pas. Sur le volet Python : « nous avons trouvé une ***corrélation NÉGATIVE*** entre les valeurs de puissance thêta et la moyenne des composantes intrinsèque et extrinsèque du questionnaire : ρ de Spearman = −0,532 ; p = 0,0075 ». ***Deux mesures de la même charge, sur les mêmes sujets, au même moment, vont en sens contraire.*** **C'est la troisième source du corpus à dire la même chose** : /Oliveira et al. — une étude sur six ne repose que sur l'opinion ; Fakhoury et al. — les trois mesures ne corrèlent pas ; et ici, deux instruments s'opposent./ \*Le protocole d'ergonomie devra donc mesurer L'EXACTITUDE ET LE TEMPS SUR UNE TÂCHE, et traiter tout questionnaire de charge comme un complément, jamais comme la mesure principale.\*

### GRIS-FakhouryEtAlMeasuringTheImpactOfLexicalAndSt

    AUTHORS | DATE | TITLE: FAKHOURY ET AL., « MEASURING THE IMPACT OF LEXICAL AND STRUCTURAL INCONSISTENCIES » — un nom qui ment contamine tout ce qui l'entoure | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT PRINCIPAL, ET IL EST PLUS FORT QUE CE QUE P-3 SUPPOSAIT

> « Les résultats montrent que l'existence d'***incohérences LEXICALES*** dans le code source ***augmente significativement la charge cognitive*** éprouvée par les participants, \*/non seulement sur les identifiants impliqués dans l'incohérence, mais DANS TOUT L'EXTRAIT DE CODE/\*. Nous n'avons pas trouvé de preuve statistique que les incohérences ***structurelles*** augmentent la charge cognitive moyenne ; ***cependant, les deux types d'incohérences dégradent la performance en temps et en taux de réussite***. »

***UN SEUL NOM QUI MENT NE COÛTE PAS LOCALEMENT : IL EMPOISONNE LA LECTURE DE TOUT LE FRAGMENT.*** **C'est un résultat de contamination, et le projet ne l'avait pas envisagé.** /P-3 traite le nommage comme une question de qualité pièce par pièce — chaque nom bon ou mauvais dans son coin. Cette mesure dit qu'un mauvais nom a une portée qui déborde son occurrence : le lecteur, une fois trompé, se défie du reste./ **ET LA DISSYMÉTRIE ENTRE LEXICAL ET STRUCTUREL EST INSTRUCTIVE.** /Ce qui coûte en CHARGE, c'est le nom ; ce qui coûte en TEMPS et en ÉCHEC, c'est aussi la structure. Deux effets distincts, deux instruments pour les voir./ **Rapporté à la coupe d'Oliveira : l'incohérence lexicale frappe la LISIBILITÉ, l'incohérence structurelle frappe la LÉGIBILITÉ.** **ET CELA RÉPOND EN PARTIE À LA RÉSERVE DE HERKA.** /Herka disait que les métriques de qualité d'identifiant fondées sur le consensus sont peu fiables. Fakhoury et al. ne demandent l'avis de personne : ils mesurent l'oxygénation du cortex préfrontal pendant une tâche. Le résultat n'est donc pas du consensus — c'est une mesure, et elle porte sur la COHÉRENCE, qui est vérifiable sans juger du goût./ **P-3 tient mieux si sa règle est formulée en cohérence — un nom ne doit pas mentir — qu'en qualité — un nom doit être bon.**

#### ET LE TROISIÈME AVERTISSEMENT DE MÉTHODE, LE PLUS NET DU CORPUS

« Enfin, nous observons que \*/la difficulté auto-rapportée de la tâche, la charge cognitive et la durée de fixation NE CORRÈLENT PAS et paraissent mesurer des aspects différents de la difficulté de la tâche/\*. » ***Trois instruments, trois mesures indépendantes, et rien ne dit lequel a raison.*** **Le protocole d'ergonomie ne pourra donc pas parler de « la » charge.** *Il devra dire quelle mesure il emploie, et ne comparer que des mesures de même nature.*

### GRIS-LilisEtSavidisASurveyOfMetaprogrammingLangua

    AUTHORS | DATE | TITLE: LILIS ET SAVIDIS, « A SURVEY OF METAPROGRAMMING LANGUAGES » — où se situe B6, et ce que la taxinomie révèle | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA TAXINOMIE — *quatre axes, et K7PL se place sur chacun*

L'enquête classe les langages de métaprogrammation selon quatre axes indépendants. **Le document de K7PL n'avait jamais situé ses macros dans un espace de conception ; le voici.**

|  |  |  |  |
|----|----|----|----|
| 1 | ***modèle de métaprogrammation*** | systèmes de macros ; réflexion et génération dynamique ; protocoles de métaobjets ; programmation par aspects ; programmation générative ; multi-étage | ***K7PL : système de macros*** |
| 2 | ***phase d'évaluation*** | prétraitement ; compilation ; exécution | ***K7PL : compilation*** |
| 3 | ***localisation de la source*** | enchâssée dans le programme, ou externe | ***K7PL : enchâssée*** |
| 4 | ***relation méta-langage / langage objet*** | identique ; extension ; langage entièrement distinct | ***K7PL : identique*** |

**ET L'AXE 3 A UNE SUBDIVISION QUE LE PROJET N'AVAIT PAS NOMMÉE, ET QUI EST EXACTEMENT NOTRE `thm:hygiene`.** Pour les métaprogrammes enchâssés, trois façons de transformer le programme cible :

1.  ***insensible au contexte*** — « remplacer seulement l'invocation du métacode par le code engendré » ;
2.  ***sensible au contexte*** — « affecter l'invocation du métacode ***et les fragments de code liés à ce contexte*** » ;
3.  ***global*** — « affecter le programme entier, quelle que soit la localisation du métaprogramme ».

***L'hygiène est le choix de l'option 1, et l'ARB-018 est le bac à sable qui l'impose.*** \*Le projet le savait ; il ne savait pas que c'était un axe de classification reconnu, ni que les deux autres options existaient comme choix de conception assumés ailleurs.\* /Cela vaut pour B6 : notre `thm:expansion_macro` énonce une propriété de l'option 1. Le théorème gagne à être présenté comme le CHOIX d'un point dans un espace connu, et non comme une évidence./

#### CE QUE L'ENQUÊTE ÉTABLIT SUR LE FOND

« La métaprogrammation a été, est et restera un sujet de recherche important, car elle constitue ***une solution de réutilisation souple et puissante*** face à la taille et à la complexité toujours croissantes des systèmes logiciels. » Et le constat de volume : « ***la quantité de métacode écrit croît exponentiellement ces dernières années*** ». **C'est un appui pour la place que K7PL donne aux macros — les macros comme glyphes de bibliothèque —, et un appui de nature différente de tous ceux réunis jusqu'ici** : /ni doléance de forum, ni mesure sur des sujets, mais un recensement de ce que les langages font effectivement./ ***RÉSERVE, ET ELLE EST IMPORTANTE*** : **cette enquête ne mesure rien sur des humains.** /Elle dit ce qui existe et comment le classer ; elle ne dit pas ce que la métaprogrammation coûte à lire. Sur ce point le dépouillement n'a toujours qu'un seul appui — les doléances recueillies sur les macros de Common Lisp — et le corpus n'en apporte pas d'autre./

### GRIS-LeVersantMthode

    AUTHORS | DATE | TITLE: LE VERSANT MÉTHODE — cinq sources, et elles arment le protocole d'ergonomie | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] KOSCH ET AL., « A SURVEY ON MEASURING COGNITIVE WORKLOAD IN HCI » — *l'instrument dominant, et sa dette cachée*

:SOURCE: Thomas Kosch, Jakob Karolus, Johannes Zagermann, Harald Reiterer, Albrecht Schmidt, Paweł W. Woźniak, *ACM Computing Surveys* 55(13s), article 283, juillet 2023 — 39 pages

**L'enquête recense les mesures de charge mentale employées en interaction humain-machine et en tire une catégorisation destinée à choisir la sienne.** *C'est exactement l'outil qui manquait au protocole.* **ET SON DEUXIÈME MANQUE IDENTIFIÉ NOUS CONCERNE DIRECTEMENT** — « ***la dette cachée du NASA-TLX*** » :

> « Un résultat clé de notre revue est que ***le domaine s'appuie de façon prépondérante sur les questionnaires, et particulièrement sur le NASA-TLX***. \[…\] On pourrait risquer d'affirmer qu'il est devenu ***un standard local*** pour la communauté. \[…\] La communauté a appliqué l'échelle dans des modalités et des contextes variés, ***conduisant à des déviations individuelles dans l'interprétation subjective du NASA-TLX***. \[…\] Malgré ces avantages, ***la fiabilité et la reproductibilité sont limitées*** lorsqu'on échantillonne des individus. »

**Le motif de sa domination est historique, non méthodologique** : « nombre de pionniers de l'interaction humain-machine venaient de l'ergonomie des facteurs humains », et le NASA-TLX y était l'usage. ***Un standard par héritage, tenu par sa commodité — « simple d'usage », « résultats rapidement obtenus ».*** **ET LA RECOMMANDATION EST DE COMBINER** : les travaux antérieurs suggèrent « de combiner le NASA-TLX avec d'autres mesures pour en accroître la signification ». ***C'est le quatrième avertissement convergent du corpus sur les instruments.*** /Oliveira : une étude sur six ne repose que sur l'opinion. Fakhoury : les trois mesures ne corrèlent pas. Thorgeirsson : deux instruments s'opposent. Kosch : l'instrument dominant l'est par habitude./ **RÈGLE POUR LE PROTOCOLE, ET ELLE EST MAINTENANT ADOSSÉE À QUATRE SOURCES** : \*/la mesure principale sera l'exactitude et le temps sur une tâche ; tout questionnaire de charge est un complément déclaré comme tel./\*

#### RODRIGUES, CAMPOS ET ZORZO, « USABILITY EVALUATION OF DOMAIN-SPECIFIC LANGUAGES » — *et le biais qu'ils découvrent est le nôtre*

:SOURCE: Ildevana P. Rodrigues, Márcia de Borba Campos, Avelino F. Zorzo, PUCRS, revue systématique de littérature, 2017

**La revue cherche les problèmes rencontrés dans l'usage des langages dédiés. Elle n'en trouve presque pas — et c'est en expliquant pourquoi qu'elle devient précieuse.**

> « Comme indiqué plus haut, la plupart des études ne rapportent pas de gros problèmes dans l'usage d'un langage dédié. \[…\] Cependant, \*/la plupart des auteurs qui évaluent LEUR PROPRE langage ne rapportent pas de problèmes, puisqu'ils l'emploient dans des domaines où ils avaient déjà rencontré des problèmes avec un langage généraliste — donc ils ont construit ce langage précisément pour les éviter/\*. »

***UN CONCEPTEUR QUI ÉVALUE SON PROPRE LANGAGE NE TROUVE PAS DE PROBLÈMES, PARCE QU'IL L'A FAIT POUR RÉSOUDRE CEUX QU'IL CONNAISSAIT.*** **C'est la description exacte de la situation d'Anthea, et du risque du protocole d'ergonomie.** /K7PL est né de problèmes que sa conceptrice a rencontrés ; il les résout ; une évaluation conduite par elle, sur des tâches qu'elle choisit, les retrouvera résolus. Le résultat sera vrai et sans valeur./ **ET LA RÈGLE QUI EN DÉCOULE EST DURE, MAIS ELLE EST CLAIRE** : \*/le protocole d'ergonomie doit faire choisir les tâches par quelqu'un d'autre, ou les tirer d'un corpus existant que le projet n'a pas constitué./\* *Sans quoi il ne mesurera que la cohérence de K7PL avec ses propres motifs.* **Un second résultat, plus banal mais utile** : Barisic et al. observent « un grand taux d'erreur chez les utilisateurs inexpérimentés », que les auteurs attribuent au « ***manque de retour que l'outil fournit à l'utilisateur*** » — s'ils avaient eu ce retour, « ils auraient pu corriger avant de rendre ». *Le même point que la question 30, par une autre porte.*

#### BERSSANETTE ET DE FRANCISCO, « COGNITIVE LOAD THEORY IN TEACHING AND LEARNING PROGRAMMING » — *les quatre effets nommés, et deux d'entre eux sont des leviers de conception*

:SOURCE: João Henrique Berssanette, Antonio Carlos de Francisco, *IEEE Transactions on Education* 65(3), août 2022 — revue systématique de 33 études

\*La revue recense ce que la théorie de la charge cognitive a produit d'utilisable en enseignement de la programmation. Deux effets nous concernent directement, parce qu'ils portent sur la MISE EN PAGE et sur l'ORDRE, non sur la pédagogie.\*

- ***L'EFFET D'ATTENTION PARTAGÉE*** — « il survient lorsque des étudiants qui étudient une information ***intégrée*** font mieux que ceux qui étudient la même information présentée en format d'attention partagée. \[…\] Cela survient quand les étudiants sont forcés de \*/diviser leur attention et d'intégrer mentalement plusieurs sources d'information physiquement ou temporellement distinctes, chacune étant essentielle à la compréhension/\*. Ce processus d'intégration mentale engendre une charge élevée et ***doit être évité***. » ***CELA VISE NOTRE GRADE.*** **Le grade ~r = ⟨u, m, ℓ, β⟩** /est une information essentielle à la compréhension d'un fragment. S'il est déclaré ailleurs que là où il agit, le lecteur doit intégrer mentalement deux sources séparées, et c'est l'effet d'attention partagée./ **Le document n'a jamais posé la question de la PROXIMITÉ de l'annotation de grade à son usage.** *C'est une question de conception, elle est nommée dans la littérature, et elle a un sens de réponse : rapprocher.*
- ***L'EFFET DES ÉLÉMENTS ISOLÉS*** — « il survient dans des phases isolées suivies de phases où les éléments interagissent, de telle sorte que ***les apprenants puissent d'abord apprendre les éléments isolés, puis les interactions entre les éléments appris précédemment***, sans surcharger la mémoire de travail. » ***C'EST LA DESCRIPTION DE NOTRE ARCHITECTURE EN COUCHES, LUE COMME UNE PROGRESSION.*** **La couche 3 est pure ; la couche 2 ajoute l'affine ; la couche 1 ajoute le linéaire.** /Un lecteur peut apprendre chacune isolément avant d'affronter leur interaction. C'est un argument pédagogique en faveur des couches que le projet n'avait pas formulé, et il est nommé./

/Les deux autres effets recensés — l'effet de l'exemple travaillé, très présent, et l'effet de modalité, dont « les résultats dans le domaine de la programmation renforcent le besoin de mieux l'étudier » — portent sur l'enseignement, et relèvent de T-60./ **ET UNE RÉSERVE DES AUTEURS, HONNÊTE** : la revue « partage les limites les plus communes de la méthode systématique, tels que la couverture de la recherche et les biais possibles ».

#### MASON, SIMON, COOPER ET WILKS, « FLIPPING THE ASSESSMENT OF COGNITIVE LOAD » — *mesurer avant de construire*

:SOURCE: Raina Mason, Simon, Graham Cooper, Barry Wilks — Southern Cross University et University of Newcastle

**Le problème posé** : la charge cognitive s'évalue d'ordinaire ***après*** l'apprentissage, par mesure physiologique pendant, ou par questionnaire après. « \*/Cependant, il est des circonstances où une décision sur le matériel d'apprentissage doit être prise AVANT que ce matériel n'existe./\* » ***C'EST EXACTEMENT LA SITUATION DE L'ARC.*** **K7PL n'a pas d'implantation ; ses choix de notation doivent être arbitrés avant qu'aucun apprenant n'existe.** /Le protocole d'ergonomie ne peut donc pas être un protocole classique de mesure post hoc, et cette source est la seule du corpus à traiter le cas./ **Le cadrage des auteurs mérite d'être retenu** : la programmation combine « l'interface humain-machine employée » et « un ensemble de concepts génériques, règles, logiques et algorithmes » — variables, propriétés, fonctions, tableaux, branchements, boucles — et « \*/la nature intrinsèquement complexe et entrelacée de la programmation fait qu'il est au mieux difficile de démêler les nombreux aspects de la conception et du développement en une séquence de démonstrations isolées/\* ». /À rapprocher de l'effet des éléments isolés : la littérature dit à la fois qu'il faudrait isoler les éléments, et que la programmation résiste à l'isolement. C'est une tension réelle, et nos couches sont une réponse possible à cette tension./

#### ISSEVER, DÉJÀ FICHÉE, ET DURAN, SORVA ET LEITE — *deux métriques calculables de la complexité d'un programme*

:SOURCE: Rodrigo Duran, Juha Sorva, Sofia Leite, *« Towards an Analysis of Program Complexity From a Cognitive Perspective »*, ICER 2018

**Le manque qu'ils constatent** : « il y a ***pénurie de méthodologies établies pour évaluer la complexité d'un programme du point de vue de l'apprentissage*** ». **Leur cadre** — la ***complexité cognitive des programmes informatiques*** — s'appuie sur la théorie de la charge cognitive et le modèle de complexité hiérarchique, et étend l'analyse de Soloway par plans. ***Il produit deux métriques*** :

|  |  |
|----|----|
| ***profondeur de plan*** | « la complexité globale des schémas cognitifs requis pour raisonner sur le programme » |
| ***interactivité maximale de plan*** | l'interaction maximale entre éléments à tenir simultanément |

***DEUX NOMBRES, CALCULABLES SUR UN PROGRAMME, ET QUI VISENT LA COGNITION PLUTÔT QUE LE CODE.*** \*T-61 s'était donné trois critères chiffrables — réimplantabilité, « un programme peut-il employer tout le langage », nombre de pages de spécification. Aucun ne porte sur UN PROGRAMME DONNÉ.\* /Ces deux-ci le font, et ils permettent une comparaison que l'arc n'avait pas les moyens de faire : écrire le même programme en deux notations candidates et comparer les deux métriques./ **C'est le seul instrument du corpus qui puisse départager deux notations SANS sujets humains.** *Ce qui, au stade où en est le projet, vaut beaucoup.*

### GRIS-LeVersantEnseignementEtNotation

    AUTHORS | DATE | TITLE: LE VERSANT ENSEIGNEMENT ET NOTATION — ce qui sert T-60, et deux points qui remontent à l'arc | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] QIAN ET LEHMAN, « STUDENTS' MISCONCEPTIONS AND OTHER DIFFICULTIES IN INTRODUCTORY PROGRAMMING »

:SOURCE: Yizhou Qian, James Lehman, Purdue University, *ACM Transactions on Computing Education* — revue de littérature

**La partition qu'ils établissent des difficultés est utile et le projet ne l'avait pas** : « les étudiants manifestent diverses idées fausses et autres difficultés en ***connaissance SYNTAXIQUE, connaissance CONCEPTUELLE et connaissance STRATÉGIQUE*** ». **Et la liste des facteurs, dont deux nous visent** :

> « Ces difficultés sont liées à de nombreux facteurs, dont ***l'ÉTRANGETÉ DE LA SYNTAXE***, ***la LANGUE NATURELLE***, la connaissance mathématique, des modèles mentaux inexacts, le manque de stratégies, les environnements de programmation, et les enseignants. »

***La langue naturelle figure dans la liste des facteurs de difficulté d'une revue de littérature en enseignement de la programmation.*** **Troisième source indépendante sur la question 41** — *Mason et Seton par questionnaire, Issever et al. par oculométrie, Qian et Lehman par recension. Trois littératures différentes, un même facteur.* **Et la partition syntaxique / conceptuelle / stratégique se superpose presque exactement à la coupe d'Oliveira** : *le syntaxique est de la LÉGIBILITÉ ; le conceptuel et le stratégique sont de la LISIBILITÉ. Deux corpus indépendants tracent la même frontière.*

#### BAU, GRAY, KELLEHER, SHELDON ET TURBAK, « LEARNABLE PROGRAMMING: BLOCKS AND BEYOND » — *et la question qu'ils posent est la nôtre*

:SOURCE: *Communications of the ACM* — article de synthèse sur les langages à blocs

**L'article ouvre sur une scène que le dépouillement de T-63 a rencontrée cent fois sous une autre forme** : « Un programmeur chevronné inspectant l'assemblage désordonné d'un débutant pourrait s'inquiéter que ***l'emboîtement de blocs colorés n'ait rien à voir avec du “vrai code”***. ***Mais qu'est-ce que le “vrai code”, et pourquoi l'apprendre ?*** » *C'est la même structure de dispute que « les parenthèses ne sont pas du vrai code », « APL n'est pas lisible », « Cognate est un jouet ».* **Et l'anti-superlativisme de Blackwell est la réponse : « vrai code » n'est pas une catégorie, c'est une adéquation à une tâche.** **Le point de conception à retenir** : les auteurs distinguent deux fins possibles de l'enseignement — *le développement d'une expertise, ou l'accès* — et notent que les langages à blocs servent la seconde. ***Un langage peut être conçu pour l'ACCÈS et non pour l'EXPERTISE, et ce n'est pas un défaut.*** *K7PL vise l'expertise ; cela doit être dit, parce que cela dispense l'arc de plusieurs objections qui supposent le contraire.*

#### WINKLER ET FLATSCHER, « COGNITIVE LOAD IN PROGRAMMING EDUCATION: EASING THE BURDEN WITH REXX » — *le seul article du corpus qui donne des règles de notation, et il cite Stefik*

:SOURCE: Till Winkler, Rony G. Flatscher, Vienna University of Economics and Business, CECIIS 2023

**Deux règles concrètes, tirées de Stefik et Siebert, que le dépouillement avait rencontré par ailleurs** :

- ***le mot plutôt que l'abréviation détournée*** : la syntaxe de boucle en `repeat` est comprise « ***dix fois plus exactement*** que la syntaxe de boucle traditionnelle de style C. Le mot `repeat`, ou `loop`, est simplement ***plus courant en anglais et peut être compris littéralement***, à la différence de `for` » ;
- ***le signe qui hérite d'un schéma existant*** : « l'usage d'un simple signe égal est perçu par les débutants comme ***plus facile à saisir*** que celui d'un double signe égal. ***Le sens d'un simple signe égal est un schéma développé dans l'enseignement des mathématiques***, tandis qu'un double signe égal est plutôt inhabituel. »

**ET LA RÈGLE GÉNÉRALE QU'ILS EN TIRENT** : « ***un langage intuitif devrait être conçu de sorte que les connaissances antérieures NON informatiques puissent s'appliquer comme prévu*** ». ***IL FAUT LIRE CETTE RÈGLE CONTRE LA QUESTION 41, PARCE QU'ELLES S'OPPOSENT.***

- **Winkler et Flatscher** : *emprunte au schéma existant du lecteur — `repeat`, `=` — parce que le schéma est déjà là et ne coûte rien à former.*
- **Mason et Seton** : *le schéma existant n'est là que pour CERTAINS lecteurs, et l'emprunter crée deux classes.*

***La contradiction est réelle et elle est instructive.*** **Elle se résout par la nature du schéma emprunté** : /le signe `=` vient des MATHÉMATIQUES — un schéma que tout lecteur scolarisé possède, quelle que soit sa langue. Le mot `repeat` vient de L'ANGLAIS — un schéma que seuls certains possèdent./ \*/D'OÙ UNE RÈGLE QUE NI L'UN NI L'AUTRE ARTICLE NE FORMULE, ET QUI EST LA RÉPONSE À LA QUESTION 41 : EMPRUNTER AUX SCHÉMAS UNIVERSELLEMENT PARTAGÉS — mathématiques, notation musicale, typographie —, FORGER LE RESTE, ET N'EMPRUNTER À L'ANGLAIS COURANT QU'EN DERNIER RECOURS./\* **Cela réconcilie les deux sources, cela vise directement le lexique de K7PL, et cela est déductible du corpus sans y figurer.** *À porter au corps, avec la mention que c'est une déduction du projet et non une conclusion citée.*

### GRIS-EtLeResteDuCorpusDpouillEtClassSansFicheProp

    AUTHORS | DATE | TITLE: ET LE RESTE DU CORPUS, DÉPOUILLÉ ET CLASSÉ SANS FICHE PROPRE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Ce qui ne vise pas l'arc, et pourquoi

- ***MORALES, RUSU, BOTELLA ET QUIÑONES, « PROGRAMMER EXPERIENCE »*** — revue systématique *IEEE Access* 2019, plus une cartographie systématique 2020 et une reprise de 2021 par Khan et Rana. **Trois articles qui fondent l'*expérience du programmeur* comme champ** : « nous considérons les programmeurs comme un cas particulier d'utilisateurs ». /Le champ existe, il porte surtout sur les environnements de développement et les interfaces de programmation, et il produit des jeux d'heuristiques d'évaluation./ \*Utile comme adossement institutionnel — il y a un nom et une communauté pour ce que le protocole d'ergonomie veut faire — sans résultat exploitable pour la notation.\* *Les trois articles se recouvrent largement.*
- ***ALI, BABAR, CHEN ET STOL, « A SYSTEMATIC REVIEW OF COMPARATIVE EVIDENCE OF ASPECT-ORIENTED PROGRAMMING »*** — 3 307 articles balayés, ***22 rapportant des résultats empiriques***. **Le rendement est le résultat** : /un paradigme abondamment promu pendant une décennie a produit vingt-deux études empiriques comparatives. C'est le taux d'évidence auquel un concepteur de langage doit s'attendre, et il est bas./ **À rapprocher du constat de Blackwell : le domaine ajoute des idées plus qu'il n'en renverse.**
- ***SHIN, « STRUCTURED QUERY LANGUAGE LEARNING »***, *IEEE Access* 2020 — cartes conceptuelles pour enseigner SQL. **Le motif est intéressant** : « SQL est difficile à maîtriser parce que ***le processus d'exécution des instructions est INVISIBLE*** » — l'apprenant doit visualiser en mémoire de travail l'évolution des jeux de données intermédiaires. /C'est la thèse de la visibilité, appliquée à un langage déclaratif. K7PL a le même problème avec le grade : le calcul du budget est invisible, et le lecteur doit le tenir de tête./ **À verser au dossier de la question 30 et du retour du vérificateur.**
- ***SHEIL, « THE PSYCHOLOGICAL STUDY OF PROGRAMMING »***, 1981 — la revue fondatrice. **Une remarque à garder, sur les commentaires** : /les résultats sur leur utilité sont équivoques, « et il n'est pas clair quel autre motif de résultats on aurait pu attendre. Manifestement, à un certain niveau, les commentaires DOIVENT être utiles ; croire autre chose serait croire que la compréhensibilité d'un programme est indépendante de l'information dont le lecteur dispose déjà »./ **C'est le modèle du raisonnement à tenir face à une mesure nulle : une mesure qui ne trouve rien peut n'avoir pas trouvé le bon niveau.** *À rapprocher de Stefik : le C n'est pas pire qu'un langage aléatoire — cela ne dit pas que la notation n'importe pas, cela dit que le C n'exploite pas ce qui importe.*

#### L'article mis en attente au premier tour

*« Clarifying and Differentiating Discoverability » figurait bien en entier dans le recueil — aux seize premières pages — et c'est mon extraction qui avait échoué, non la source.* **Fiche ci-dessous, sous l'angle demandé par Anthea.**

### GRIS-CeQueLeCorpusArrtePourLeProtocoleDErgonomie

    AUTHORS | DATE | TITLE: CE QUE LE CORPUS ARRÊTE POUR LE PROTOCOLE D'ERGONOMIE — six règles, chacune adossée | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-MackamulCasiezEtMalacriaClarifyingAndDiffere

    AUTHORS | DATE | TITLE: MACKAMUL, CASIEZ ET MALACRIA, « CLARIFYING AND DIFFERENTIATING DISCOVERABILITY » — lue sous la question posée par Anthea | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA QUESTION D'ANTHEA A UN NOM DANS LA LITTÉRATURE, ET C'EST LE TROISIÈME DES TROIS

L'article sépare ***trois découvrabilités***, et la séparation est le cœur de sa contribution.

|  |  |  |  |
|----|----|----|----|
| 1 | ***SYSTÈME*** | « la découverte des systèmes interactifs en général » | qu'il existe un langage, et qu'on peut écrire dedans |
| 2 | ***INTERACTION*** | « la découverte des actions ***qu'un utilisateur*** peut accomplir » | qu'on peut annoter un grade, ouvrir un délimiteur, poser un alias |
| 3 | ***FONCTIONNALITÉ*** | « la découverte des actions ***qu'un système*** peut accomplir » | ***qu'il existe une couche 1 ; qu'une macro fait déjà cela ; qu'un glyphe a un synonyme*** |

***La question d'Anthea est EXACTEMENT la troisième***, et sa définition la reprend mot pour mot : « la découvrabilité de fonctionnalité couvre \*/la capacité de l'utilisateur à découvrir des fonctions ou fonctionnalités dont il n'avait pas connaissance auparavant PENDANT QU'IL EMPLOIE LE SYSTÈME/\* ». **La question est donc bien posée, elle a un nom, et elle a une littérature.** *Ce que le document ignorait.* **ET LA COUPE ENTRE 2 ET 3 EST PLUS FINE QUE LA PROSE NE LE LAISSE CROIRE — c'est la figure 2 qui la donne** : ***les actions qu'un UTILISATEUR peut accomplir*** contre ***les actions qu'un SYSTÈME peut accomplir***. *Pour un langage : la notation relève de 2, la capacité relève de 3. Le glyphe est de l'interaction ; la couche est de la fonctionnalité.*

#### LA DÉFINITION À ADOPTER, ET SA BORNE — *la découvrabilité S'ARRÊTE À LA COMPRÉHENSION*

> « \*/La capacité pour des utilisateurs de percevoir et de comprendre un système, une fonction ou une méthode d'entrée COMME TELS lorsqu'ils la rencontrent, malgré une absence de connaissance ou de conscience préalable. Cela peut se faire par effort intentionnel ou de manière sérendipiteuse./\* »

« À ce titre, la découvrabilité couvre la période allant du ***déclenchement*** de l'interaction, la rencontre et la perception, ***jusqu'à ce que l'utilisateur COMPRENNE ce qu'il a rencontré***. » ***ELLE NE COUVRE PAS L'USAGE RÉUSSI. CELA, C'EST L'APPRENABILITÉ.*** **Et la frontière est utile pour l'arc**, parce qu'elle sépare deux échecs que le projet confondait : *ne pas savoir qu'une couche existe* n'est pas *ne pas savoir s'en servir*. \*Le premier est un problème de découvrabilité et se traite dans la notation ; le second est un problème d'apprenabilité et se traite dans T-60.\* **La chronologie que l'article dresse donne six étapes, et permet de situer un échec** :

    rencontre → perception → déclenchement → COMPRÉHENSION → interaction consciente → interaction réussie
    └──────────── découvrabilité ────────────┘
                                             └──────── apprenabilité ────────┘

**Et l'ordre entre les deux est énoncé** : « ***la découvrabilité PRÉCÈDE et DÉCLENCHE l'apprentissage***. Si un utilisateur potentiel rencontre une fonctionnalité mais ne la remarque ni ne la comprend comme telle, ***il est peu probable qu'il interagisse consciemment avec elle ou qu'il retienne une information*** qui lui permettrait d'améliorer l'interaction. » *T-60 est donc en aval de cette question, non en parallèle.*

#### LE PASSAGE QUI VISE K7PL DE PLEIN FOUET — *la suffisance de la couche 3*

> « Des rapports suggèrent que ***seulement 20 % environ des fonctionnalités d'une application sont couramment employées***. \[…\] d'autres fonctionnalités ne sont ***simplement jamais découvertes***. Cette découverte est souvent entravée par le fait que \*/LE SYSTÈME EST FONCTIONNEL et que l'utilisateur peut accomplir la majorité de ses actions voulues sans avoir conscience de toutes les fonctionnalités à sa disposition/\*. C'est particulièrement le cas si les utilisateurs ne sont pas encouragés à explorer d'autres options, \*/parce que ce qu'offre une nouvelle fonctionnalité peut être obtenu autrement, d'une façon potentiellement plus laborieuse, que l'utilisateur connaît déjà/\*. »

***C'EST LA DESCRIPTION EXACTE DU RISQUE STRUCTUREL DE K7PL, ET LA LITTÉRATURE LE PRÉDIT.*** **La couche 3 est fonctionnelle.** /Un codeur qui n'écrit qu'en couche 3 peut accomplir la majorité de ses actions voulues. Ce que les couches 1 et 2 lui offrent — la maîtrise de la ressource, la sédimentation — s'obtient autrement, « d'une façon potentiellement plus laborieuse, qu'il connaît déjà »./ ***IL NE LES DÉCOUVRIRA DONC PAS. Non parce qu'elles sont mal notées, mais parce qu'il n'en a pas besoin pour finir sa journée.*** **Et l'architecture en couches aggrave le cas plutôt qu'elle ne l'atténue**, *puisqu'elle est précisément conçue pour qu'on puisse travailler dans une seule.* **C'est le prix, jamais chiffré, de la propriété que le projet tient pour un acquis.** *Le chiffre de 20 % n'est pas transposable tel quel — il porte sur des applications à interface graphique. Mais le MÉCANISME est général, et il ne dépend d'aucune propriété de l'interface.*

#### LA BORNE SUPÉRIEURE — *« si tout est découvrable, rien ne l'est »*

**Le « dans quelle mesure » de la question d'Anthea a une réponse, et elle est restrictive.**

> « \[…\] la découvrabilité serait globalement ***un mythe***, en arguant que ***si tout est découvrable, rien ne l'est***. \[…\] il en vient à discuter le problème de ***l'ENCOMBREMENT*** et plaide pour ***prioriser la découvrabilité des fonctionnalités importantes et essentielles*** par rapport aux autres. Ce raisonnement suggère non pas l'absence ou la non-viabilité de la découvrabilité, mais ***l'importance d'une HIÉRARCHIE de découverte***. »

**Et le cas mesuré qui l'illustre** : dans un système de navigation vocale, « lorsque l'affichage montrait trop d'invites supposément utiles, \*/ces invites de découverte se disputaient l'attention de l'utilisateur et causaient confusion et frustration plutôt que de faciliter l'interaction/\* ». ***LA RÉPONSE À « DANS QUELLE MESURE » N'EST DONC PAS « AUTANT QUE POSSIBLE » : C'EST « SELON UNE HIÉRARCHIE ARRÊTÉE À L'AVANCE ».*** **Et c'est un résultat compatible avec KISS, ce qui est heureux** : /le langage doit désigner ce qu'un codeur DOIT découvrir, et se taire sur le reste. Un dispositif de découverte qui signale tout est un dispositif qui ne signale rien./ *Le projet n'a jamais dressé cette hiérarchie. C'est une tâche, et elle est petite.*

#### LES CONCEPTS VOISINS, ET CE QU'ILS RANGENT DANS L'ARC

**L'article distingue la découvrabilité de cinq concepts proches. Deux d'entre eux réassignent des questions ouvertes que l'arc avait mal étiquetées.**

- ***DEVINABILITÉ*** (*guessability*) — « une qualité ***DES SYMBOLES*** qui permet à un utilisateur d'accéder aux référents visés ***au travers de ces symboles, malgré une absence de connaissance de ces symboles*** ». Et sa portée : « la devinabilité porte sur ***l'impression immédiate*** de l'utilisateur plutôt que sur un examen attentif du contexte. À ce titre elle ***AIDE*** la découvrabilité mais n'inclut pas de considération sur la façon dont la rencontre a eu lieu ni sur ce qu'il en adviendra. » ***NOS QUESTIONS 23, 24 ET 27 PORTENT SUR LA DEVINABILITÉ, PAS SUR LA DÉCOUVRABILITÉ.*** \*Le glyphe, son budget, les signes dépourvus de sens : ce sont des questions sur ce qu'un symbole livre au premier regard.\* *Elles avaient été rangées avec l'amorçage ; elles n'y sont pas.*
- ***COMMUNICABILITÉ*** — « la qualité distinctive des systèmes interactifs qui communiquent efficacement aux utilisateurs ***leur intention de conception sous-jacente et leurs principes interactifs*** ». **C'est le versant SYSTÈME du même processus.** /Pour K7PL, la communicabilité est ce que porte le message d'erreur — question 30 — et ce que porte la spécification. La découvrabilité est ce que porte LE TEXTE SOURCE lui-même./
- ***TROUVABILITÉ*** (*findability*) — « l'utilisateur trouve aisément un contenu ou une fonctionnalité ***dont il suppose la présence*** », contre la découvrabilité où « l'utilisateur rencontre un contenu ou une fonctionnalité ***dont il n'avait pas connaissance*** ». ***Deux mécanismes distincts, et K7PL les traite par deux voies distinctes*** : /la trouvabilité passe par le manuel, l'index, la complétion ; la découvrabilité passe par le texte source. Le projet a beaucoup pensé à la première en croyant traiter la seconde./
- ***REMARQUABILITÉ*** (*noticeability*) — « la probabilité que quelque chose soit remarqué, c'est-à-dire capte l'attention ». *Étape 2 de la chronologie.*
- ***NAVIGABILITÉ*** — « la capacité d'un système à communiquer à l'utilisateur comment s'y déplacer (au mieux) ». *Suppose une destination ; hors sujet ici.*

#### ET LA CONCLUSION DES AUTEURS, QUI VISE UNE HYPOTHÈSE QUE LE PROJET FAIT SANS LE DIRE

> « \[…\] les concepteurs d'interaction croient encore que les utilisateurs vont ***“finir par comprendre”***. Cependant, la recherche et l'usage commercial suggèrent que ***L'HYPOTHÈSE SELON LAQUELLE LA DÉCOUVERTE SERAIT INÉVITABLE EST SANS FONDEMENT***. »

**L'arc fait cette hypothèse partout où il s'appuie sur l'uniformité.** /« Tout est expression symbolique », donc un lecteur qui sait lire une forme sait lire toutes les formes — c'est vrai de la LÉGIBILITÉ, et l'arc en a glissé à la découvrabilité sans s'en apercevoir. Savoir LIRE `(couche-1 …)` n'est pas savoir QUE la couche 1 existe./ **L'uniformité syntaxique ne produit pas de découvrabilité. Elle produit de la légibilité, et c'est tout.** *Distinction qui n'existait pas dans le document, et qui découle de la coupe d'Oliveira croisée avec celle-ci.*

#### UN SEPTIÈME AVERTISSEMENT DE MÉTHODE, ET C'EST LE PLUS DUR DU CORPUS

> « Étudier la découvrabilité présente ***une dichotomie inhérente entre recueillir des données pertinentes et accroître la découverte par le dispositif d'étude lui-même***. Si la découverte est nécessaire pour accomplir une tâche, si la méthode d'entrée est suggérée, si l'on interroge directement les participants ou qu'on leur donne une tâche qui encourage fortement l'exploration, les chercheurs recueillent plus vraisemblablement des résultats significatifs. ***Cependant ces résultats ne reflètent pas véritablement la découvrabilité, puisque le déclenchement, la rencontre et parfois la perception sont IMPOSÉS par l'étude.*** »

**Et le verdict** : « certaines études prétendant enquêter sur la découvrabilité ***échouent à le faire*** ». ***ON NE PEUT PAS MESURER LA DÉCOUVRABILITÉ PAR UNE TÂCHE QUI EXIGE DE DÉCOUVRIR.*** **C'est un interdit, il est net, et il ferme la voie la plus naturelle du protocole d'ergonomie.** /Ce qui reste : observer sur une durée longue, sur des tâches qui n'ont pas besoin de la fonctionnalité en cause, et compter combien de sujets la rencontrent sans y avoir été menés. C'est coûteux, et il n'y a pas de raccourci — les auteurs notent l'absence de repère établi et appellent à une revue des méthodes d'évaluation, qui n'existe donc pas./

## T-60 — L'ECOLOGICAL INTERFACE DESIGN, ET CE QU'IL DONNE APPLIQUÉ À LA LECTURE DE CODE

*Quatre sources fournies le 7 août, après la clôture de la phase d'exploration. L'entrée était annoncée « la plus structurante du lot » et avait été portée en perte ; elle est rouverte.*

### GRIS-LesSources

    AUTHORS | DATE | TITLE: LES SOURCES | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeButDuCadreEtIlEstMotPourMotCeluiQueT60Avai

    AUTHORS | DATE | TITLE: LE BUT DU CADRE, ET IL EST MOT POUR MOT CELUI QUE T-60 AVAIT SUPPOSÉ | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LePremierInstrument

    AUTHORS | DATE | TITLE: LE PREMIER INSTRUMENT — savoir-faire, règles, connaissances, et ce qui déclenche chacun | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Le résultat qui fait le critère

**La taxonomie ne classe pas seulement des comportements : elle dit CE QUI ACTIVE CHACUN.**

> « Le ***SBB*** ne peut être activé que lorsque l'information est présentée sous forme de ***SIGNAUX espace-temps***. Le ***RBB***, lui, est déclenché par des ***FORMES PERCEPTIVES FAMILIÈRES (des signes)***. Et enfin le ***KBB*** est activé par des ***STRUCTURES RELATIONNELLES SIGNIFIANTES (des symboles)***. »

***Signaux, signes, symboles. Trois déclencheurs, trois régimes, et la correspondance est prescriptive : elle dit ce qu'il faut mettre à l'écran pour obtenir tel régime.***

#### ET LA LECTURE QUE T-60 EN FAISAIT EST FAUSSE — *c'est le résultat de l'entrée*

**L'instruction supposait** : *« le glyphe servirait la reconnaissance de forme, l'alias la règle apprise, le type le raisonnement délibéré ».* ***Cela ne tient pas, et l'erreur est instructive.*** **Un glyphe est une *forme perceptive familière* — donc un ***SIGNE***, donc du RBB. Mais un alias textuel est ***AUSSI*** une forme perceptive familière — donc aussi un signe, donc aussi du RBB.** ***LE GLYPHE ET L'ALIAS SONT AU MÊME NIVEAU. Ce sont DEUX SIGNES POUR UNE MÊME CONTRAINTE, et non deux niveaux de contrôle cognitif.*** **Et le niveau savoir-faire reste alors vacant — ce qui pose la vraie question : qu'est-ce qu'un SIGNAL ESPACE-TEMPS dans du code source ?** /La réponse n'est pas le glyphe. C'est LA MISE EN PAGE : l'indentation, l'alignement, la silhouette du bloc sur la page, ce qu'on voit avant de lire./ **LA CORRESPONDANCE CORRIGÉE, ET ELLE EST LE PRODUIT DE T-60** :

|  |  |  |
|----|----|----|
| ***SBB*** — signaux espace-temps | ***la mise en page*** : indentation, alignement, silhouette du bloc | ce qu'on voit sans lire |
| ***RBB*** — signes | ***le glyphe ET l'alias*** — deux signes pour une contrainte | ce qu'on reconnaît sans raisonner |
| ***KBB*** — symboles | ***le grade, la couche, le budget*** — structures relationnelles | ce sur quoi il faut raisonner |

*Le projet n'avait jamais rangé la MISE EN PAGE parmi ses objets de conception. Elle y entre par ce cadre, et au niveau le moins coûteux des trois.*

### GRIS-LesTroisPrincipesEtLeDeuximeEstLeCritreQueT6

    AUTHORS | DATE | TITLE: LES TROIS PRINCIPES, ET LE DEUXIÈME EST LE CRITÈRE QUE T-60 CHERCHAIT | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Principe 1 — SBB

« La structure de l'information affichée devrait être ***ISOMORPHE À LA STRUCTURE PARTIE-TOUT*** des mouvements. » /Obtenu « en révélant l'information de haut niveau comme une AGRÉGATION de l'information de bas niveau » — de sorte que « plusieurs niveaux soient visibles en même temps et que l'opérateur soit libre de porter son attention au niveau qui l'intéresse, selon son degré d'expertise et les exigences du moment »./ **L'exemple des auteurs est la notation musicale** : « à mesure que la maîtrise du musicien augmente, les mouvements s'agrègent en fragments d'ordre supérieur \[…\] les musiciens expérimentés forment des fragments visuels d'ordre supérieur et les appliquent directement à un découpage concurrent des mouvements ». /Une NOTATION est prise en exemple, dans l'article fondateur, comme cas de soutien au savoir-faire. Le transfert vers un langage de programmation n'est donc pas une audace./

#### Principe 2 — RBB — *et c'est le critère opératoire pour P-2*

> « ***Fournir une correspondance UN-À-UN CONSISTANTE entre les contraintes du domaine de travail et les indices — ou signes — fournis par l'interface.*** »

**Et le mal qu'il prévient est nommé** : « le problème des interfaces conventionnelles est qu'il n'y a pas de correspondance consistante entre les indices perceptifs qu'elles fournissent et les contraintes qui gouvernent le comportement du processus. \*/Cela mène à des PIÈGES PROCÉDURAUX : des situations nouvelles où les opérateurs s'appuient sur leur jeu de règles habituel, sans le succès habituel./\* » ***« PIÈGE PROCÉDURAL » EST LE NOM D'UN MODE DE DÉFAILLANCE QUE K7PL PEUT PRODUIRE.*** **Il rejoint l'interférence de Hao et Glassman et la question 40 par un troisième chemin.** **ET LE BÉNÉFICE, QUI EST EXACTEMENT CE QUE K7PL VEUT** : « parce qu'il y a une correspondance 1:1 entre les symboles et les signes, ***l'opérateur peut manifester ce qui RESSEMBLE à du KBB en ne s'appuyant que sur du RBB***. \[…\] Le second principe permet donc de profiter de l'économie cognitive du RBB tout en préservant la large applicabilité du KBB. » ***Un lecteur qui RECONNAÎT le glyphe obtient la discipline de grade SANS RAISONNER DESSUS. C'est la promesse du glyphe, elle est formulée, et elle est CONDITIONNELLE à la correspondance 1:1.*** **D'OÙ LE CRITÈRE, QUI VISE P-2 DIRECTEMENT** : /P-2 pose que « le glyphe n'est jamais la seule notation ». Le principe 2 dit que la correspondance doit être ***CONSISTANTE*** et ***UN-À-UN***. Deux signes pour une contrainte sont admissibles — mais alors ce doit être TOUJOURS deux, jamais une fois deux et une fois un, et jamais deux glyphes pour une contrainte ni un glyphe pour deux./ **C'est chiffrable et vérifiable mécaniquement sur la table des glyphes.** *T-60 promettait « un critère opératoire, testable, non décoratif ». Le voici.*

#### Principe 3 — KBB

« Représenter le domaine de travail sous la forme d'une ***hiérarchie d'abstraction*** servant de ***MODÈLE MENTAL EXTERNALISÉ*** qui soutiendra la résolution de problèmes. » /Le bénéfice : « soulager les opérateurs d'avoir à suivre le réseau causal complexe dans lequel ils raisonnent »./

### GRIS-LeSecondInstrument

    AUTHORS | DATE | TITLE: LE SECOND INSTRUMENT — la hiérarchie d'abstraction, et ce qu'elle nomme pour T-62 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | FUSION: 2 entrées réunies le 1er septembre | SYNTHESE: t

#### \[DONE\] Sa structure

Elle appartient aux ***hiérarchies stratifiées*** : « chaque strate traite du ***même système***, la seule différence étant que les strates fournissent des descriptions différentes \[…\] chaque strate a son propre jeu de termes, de concepts et de principes ». **Et sa propriété distinctive est la relation MOYEN-FIN entre niveaux** :

> « \*/En MONTANT dans la hiérarchie, on obtient une compréhension plus profonde de la signification du système au regard des buts à atteindre ; en DESCENDANT, on obtient une explication plus détaillée du fonctionnement du système, en termes de la façon dont ces buts peuvent être réalisés./\* »

*Monter dit POURQUOI, descendre dit COMMENT. Et « les exigences du bon fonctionnement à un niveau apparaissent comme des CONTRAINTES sur l'opération signifiante des niveaux inférieurs ».* **Les cinq niveaux du contrôle de processus, donnés comme exemple et non comme norme** : *finalité fonctionnelle ; fonction abstraite ; fonction généralisée ; fonction physique ; forme physique.* « Le nombre exact de niveaux et leur contenu ***varient d'un domaine à l'autre***. »

#### ET VOICI CE QUE LA CONVENTION DE NOMMAGE NOMMAIT SANS LE SAVOIR — *T-62 est rouverte*

**Le cadre a DEUX axes, non un** : la hiérarchie d'abstraction — *moyen-fin, POURQUOI-COMMENT* — et la hiérarchie ***PARTIE-TOUT***, qui lui est orthogonale. *Leur produit est l'espace abstraction-décomposition.* **Or la convention de K7PL est « verbe d'action, puis portée, puis précision ».**

|  |  |  |
|----|----|----|
| ***action*** | ce que la chose fait | axe ***ABSTRACTION*** — la fonction généralisée |
| ***portée*** | de quel tout elle est la partie | axe ***PARTIE-TOUT*** |
| ***précision*** | quel élément parmi ses semblables | axe ***PARTIE-TOUT***, un cran plus bas |

***LA CONVENTION EST UNE ADRESSE DANS L'ESPACE ABSTRACTION-DÉCOMPOSITION : elle donne UN point sur l'axe d'abstraction, puis descend l'axe partie-tout.*** **T-62 avait été close sur le constat que la convention est « pratiquée sans être nommée ».** /C'était le résultat attendu et il était juste quant au NOM — aucun nom propre n'existe. Mais la convention a une STRUCTURE, elle est celle de Rasmussen, et l'instruction de T-62 l'avait pressenti : « l'espace abstraction-décomposition, qui décrirait la STRUCTURE du nom plutôt que sa FORME »./ **C'était exact.** **ET CELA REND LA CONVENTION CRITIQUABLE, CE QU'ELLE N'ÉTAIT PAS** : /elle donne un seul cran d'abstraction et deux crans de décomposition. Un nom qui dirait POURQUOI — le niveau du dessus — n'a pas de place dans la convention. Est-ce un manque ou une économie ? La question est neuve et elle est bien posée./

### GRIS-LaCritique

    AUTHORS | DATE | TITLE: LA CRITIQUE — Lin et Zhang, et elle empêche de prescrire naïvement | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Le niveau contesté est celui que K7PL voudrait afficher

> « Il ne fait pas de doute qu'un affichage de la seule information de fonction physique ne suffit pas \[…\] ***La question la plus CONTROVERSÉE avec l'interface écologique est l'affichage de l'information de FONCTION ABSTRAITE***, et la question d'intérêt particulier est ***comment et quand*** l'afficher. \[…\] (1) ***la complexité visuelle induite par l'affichage de la fonction abstraite peut affecter la performance***, et (2) la fonction abstraite telle qu'affichée aujourd'hui ***n'est pas positivement corrélée à l'amélioration de la performance pour toutes les catégories de tâches***. »

***« RÉVÉLER TOUTE LA HIÉRARCHIE » N'EST DONC PAS UNE PRESCRIPTION SÛRE.*** \*Le niveau le plus abstrait — celui qui, chez nous, correspond au grade et au budget — est précisément celui dont le bénéfice n'est pas établi et dont le coût visuel est attesté.\* *Cela tempère fortement ce qu'on pourrait tirer du principe 3, et cela va dans le même sens que la borne de la question 44 : « si tout est découvrable, rien ne l'est ».*

#### Et la dépendance à la tâche, énoncée de l'intérieur du cadre

« La variabilité de beaucoup de résultats expérimentaux sur l'interface écologique est étroitement liée ***aux catégories de tâches*** et aux niveaux de difficulté des tâches dans chacune de ces catégories. » /Ham et Yoon : la meilleure performance venait de l'affichage de la fonction généralisée pour un certain type de diagnostic ; et l'utilité de la fonction abstraite varie avec la difficulté./ ***C'est l'anti-superlativisme, formulé de l'intérieur de l'EID.*** **Aucun niveau n'est bon en soi : il est bon pour une tâche.**

#### Un avertissement de méthode, le huitième

**Lin et Zhang nomment un dilemme dans la vérification expérimentale** : la ***fiabilité*** — le résultat obtenu pour examiner le CONTENU informationnel est-il « contaminé » par un facteur incontrôlé, par exemple la FORME visuelle de ce contenu ? — contre la ***praticabilité*** — le dispositif ressemblait-il à la pratique réelle ? « Ham et Yoon peuvent produire des résultats plus fiables puisqu'ils ont éliminé l'effet des formes visuelles, ***mais leurs résultats peuvent ne pas se généraliser à la situation plus pratique***. » *Pour notre protocole : on ne peut pas mesurer À LA FOIS ce que dit une notation et ce que fait sa mise en forme. Il faut choisir lequel on mesure, et le déclarer.*

### GRIS-LeManuelDuPraticien

    AUTHORS | DATE | TITLE: LE MANUEL DU PRATICIEN — Burns et Hajdukiewicz, et deux motifs qui visent notre protocole | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] « Quand demander aux utilisateurs ne marche pas »

> « Dans des systèmes aussi complexes qu'une centrale, les utilisateurs, ***même très expérimentés***, n'ont pas une compréhension complète du fonctionnement. Vous ne pouvez pas simplement leur demander “de quoi avez-vous besoin à l'écran ?” et attendre une réponse complète et cohérente. ***Si vous interrogez cinq utilisateurs, vous obtiendrez cinq réponses.*** \[…\] Les utilisateurs ne sont pas toujours conscients des contraintes qui affectent le système avec lequel ils travaillent. »

**Et le remède prescrit inverse l'ordre habituel** : « une autre façon de traiter le problème est de ***COMMENCER PAR LES CONTRAINTES, PUIS de chercher l'avis des utilisateurs*** ». \*/HUITIÈME RÈGLE DU PROTOCOLE D'ERGONOMIE, ET ELLE EST STRUCTURANTE : le protocole ne commencera pas par demander aux programmeurs ce qu'ils veulent. Il partira des contraintes — que K7PL POSSÈDE, formellement — et cherchera ensuite l'avis./\* *Cela s'ajoute à la règle 2, qui interdisait déjà au projet de choisir ses propres tâches. Les deux ensemble dessinent un protocole peu intuitif et défendable.*

#### La conception par contraintes, et pourquoi elle traite l'imprévu

**L'analogie des auteurs — l'écureuil qui entre dans la maison** : /boucher chaque ouverture connue est une conception par scénarios, et l'écureuil entrera par où l'on n'a pas prévu. Définir le problème comme « franchir l'enveloppe extérieure » est une conception par contrainte./ « Quand nous concevons à partir de contraintes, nous pouvons traiter les événements imprévus parce que, ***quel que soit l'événement, la contrainte est rompue***. \[…\] Et de plus, nous avons montré à l'utilisateur comment agir : ***rétablir la contrainte et le système est réparé***. » ***LA DISCIPLINE DE GRADE EST UN SYSTÈME DE CONTRAINTES. Ce paragraphe est donc une description de ce que K7PL pourrait afficher, et de ce que son diagnostic pourrait dire.*** **Il rejoint la question 30 — que dit le message d'erreur — avec une réponse de forme : *rétablis la contrainte*, et non *retire ce `&`*.**

#### Et le motif d'expertise

« Si nous, concepteurs, faisons une partie du travail de compréhension de ces systèmes et ***encapsulons cette connaissance dans l'interface***, nous pouvons réduire la courbe d'apprentissage, ou aider les utilisateurs à atteindre des niveaux d'expertise ***qui n'étaient pas possibles auparavant***. » *Et la conséquence de méthode : « il est nécessaire que les concepteurs sortent de la communauté des utilisateurs pour obtenir des entrées » — manuels, plans, ingénieurs.*

### GRIS-Baber

    AUTHORS | DATE | TITLE: BABER — la correction sur le mot « affordance », et la boucle tâche-artefact | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Une affordance n'est pas une propriété

> « ***Il n'a aucun sens de dire qu'un artefact “A” une affordance.*** Et pourtant il existe une littérature abondante, particulièrement en conception et en interaction humain-machine, où l'affordance est traitée simplement comme ***une propriété de l'artefact*** \[…\] Mais il y a là un problème évident : la tasse à café “afforde” aussi de contenir un liquide, de le transporter, de le garder chaud, d'être lavée, rangée, jetée \[…\] ***le même artefact participe à une variété de situations affordantes***. »

***« LE GLYPHE AFFORDE X » EST UNE ERREUR DE CATÉGORIE.*** **La formule correcte est : *ce lecteur, avec cette compétence, dans cette tâche, peut faire X avec ce glyphe*.** /C'est la même exigence que l'anti-superlativisme, venue d'une autre littérature, et elle discipline la rédaction autant que la conception./

#### La boucle tâche-artefact

« ***Les tâches que les gens accomplissent sont CONTRAINTES PAR LE DISPOSITIF*** » — et la boucle est réciproque : *le dispositif engendre de nouvelles exigences de tâche, qui engendrent de nouvelles possibilités ou contraintes d'usage.* **L'exemple de la machine à écrire est directement transposable** : /il y a des différences dans la façon dont les erreurs se corrigent, « ce qui peut avoir un effet sur LE SOIN QU'ON APPLIQUE à former les mots, en particulier si, comme la machine à écrire, la technologie ne pardonne pas l'erreur »./ ***UN LANGAGE QUI NE PARDONNE PAS CHANGE LE SOIN QU'ON MET À ÉCRIRE — il ne se contente pas de servir la tâche, il la façonne.*** **K7PL ne pardonne pas : le grade est vérifié.** /Le projet a toujours posé cela comme un coût à minorer. C'est aussi un effet à revendiquer, et personne ne l'avait écrit./

#### Et le prêt-à-la-main

/« Une technologie bien conçue DISPARAÎT de la conscience pendant l'usage. \[…\] Nous devenons conscients de la technologie quand l'interaction se ROMPT » — elle devient alors « là-devant », un objet qui réclame l'attention./ **À rapprocher de la question 43 : une notation qu'on ne remarque plus est une notation qui ne se fera plus découvrir.** *Le prêt-à-la-main et la découvrabilité s'opposent, et c'est un arbitrage réel.*

### GRIS-LeTransfert

    AUTHORS | DATE | TITLE: LE TRANSFERT — ce que T-60 exigeait de trancher, et il se tranche sur pièces | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Le critère est donné par les auteurs eux-mêmes, et il n'est pas la ressemblance

> « \*/Le prérequis principal pour appliquer le cadre est que le concepteur DISPOSE D'UNE DESCRIPTION DES CONTRAINTES PERTINENTES POUR LE BUT qui gouvernent le domaine de travail. En principe, PEU IMPORTE QUELLES SONT CES CONTRAINTES/\*, du moment qu'elles peuvent être décrites de telle sorte qu'on puisse ensuite les appliquer aux traits perceptifs de l'affichage. »

***LE CRITÈRE N'EST DONC PAS « VOTRE DOMAINE DOIT RESSEMBLER À UNE SALLE DE CONTRÔLE ». C'est « vous devez posséder une description des contraintes ».*** **ET K7PL EN POSSÈDE UNE, FORMELLE** : /le grade $`r = \langle u, m, \ell, \beta\rangle`$, les trois couches, la sédimentation, les 34 règles, les six briques du noyau. C'est exactement ce que l'arc précédent a produit./ ***LE TRANSFERT EST DONC ARGUMENTÉ, ET NON DÉCLARÉ ANALOGIQUE — sur ce critère.***

#### Mais il ne l'est que pour une moitié, et il faut le dire

**Les auteurs sont eux-mêmes prudents** : « l'applicabilité et l'utilité du cadre EID ***reste à explorer systématiquement au-delà de ce contexte*** ». **ET TROIS DÉSANALOGIES DOIVENT ÊTRE INSCRITES** :

1.  ***L'EID suppose un système DYNAMIQUE dont l'état dérive et doit être surveillé.*** *Le code source est STATIQUE. Il n'y a pas d'état courant qui sort des clous sous les yeux du lecteur.* **L'analogue existe — un programme qui ne compile pas, un programme qui surprend — mais il est plus faible.**
2.  ***Le bénéfice mesuré va aux EXPERTS, pas aux novices.*** L'expérience de Vicente et Rasmussen : l'interface complète « a produit une performance de diagnostic supérieure \[…\] ***principalement pour les experts*** », et « ***un certain degré d'expertise théorique est requis pour obtenir cet avantage*** ». *Montrer plus n'aide pas tout le monde.*
3.  ***Le niveau le plus abstrait est le plus contesté*** — Lin et Zhang. **C'est celui du grade.**

\*/VERDICT : le transfert est ARGUMENTÉ pour la moitié SAVOIR-FAIRE/RÈGLES/CONNAISSANCES — dont le principe 2, qui donne un critère mécanique — et seulement ANALOGIQUE pour la moitié HIÉRARCHIE D'ABSTRACTION, où il faudra le mot LECTURE./\* *C'est une position plus fine que ce que T-60 demandait, et elle est défendable des deux côtés.*

## T-66 — LA RÉFLEXION SYNTAXIQUE : CARTOGRAPHIE DES NEUF SOURCES

*Fournies le 7 août. Les neuf ont été récupérées ; aucune n'a bloqué.* \*L'entrée est BORNÉE PAR SA QUESTION — question 16 (faut-il une tour de phases ?), B6 et `thm:expansion_macro`, ARB-018 le bac à sable. Le tri ci-dessous applique cette règle, et il écarte plus qu'il ne retient.\*

### GRIS-CeQuiEntre

    AUTHORS | DATE | TITLE: CE QUI ENTRE — quatre sources sur neuf | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] BORNER, « A DUAL VIEW ON SYNTAX » — *la source centrale, et elle joint T-66 à T-65*

:SOURCE: Marvin Borner, 11 août 2026 **La thèse, et elle est radicale** : *les variables ne sont rien d'autre que des FILS ORIENTÉS.*

> « Vous pouvez observer qu'il n'est apparemment fait aucune différence entre les champs “variable” et “corps” d'une abstraction — ***ce sont tous deux simplement des fils***. Il est donc sensé de voir les continuations comme ***un fil ordinaire de plus***. \[…\] Il n'y a plus d'ordre imposé par la syntaxe entre ces constructeurs ; ***on peut simplement les mettre dans un ENSEMBLE***. »

**Et la POLARITÉ fait le reste** : « les termes ont une ***polarité*** qui les divise en composants ***producteurs*** (positifs) et ***consommateurs*** (négatifs) \[…\] les fils vont du positif au négatif, et ne connectent jamais deux composants de même polarité ». ***LA CONSÉQUENCE POUR NOUS EST DE PREMIER ORDRE : LA SYNTAXE EST UNE VUE SUR UN GRAPHE POLARISÉ, ET LE CHOIX DU POINT DE DÉPART DU PARCOURS DONNE UNE SYNTAXE DIFFÉRENTE POUR LE MÊME TERME.*** L'auteur va jusqu'à écrire que la notation reçue est mauvaise : « à mon avis, la syntaxe $`\lambda x.b`$ est franchement ***déroutante*** — elle met $`x`$ dans une place si spéciale, sans permettre de sous-termes immédiats, alors que ***techniquement une notation exactement DUALE à $`b`$ pourrait être employée*** ». **Ce que cela donne à l'arc** : /une explication de POURQUOI une notation a la forme qu'elle a, au lieu d'un catalogue de goûts. C'est ce que T-61 cherchait sans le trouver, et c'est ce que l'anti-superlativisme rendait nécessaire — une notation est une VUE, et une vue se choisit pour une tâche./ ***ET C'EST LE POINT DE RENCONTRE DES DEUX ARCS, annoncé dans l'entrée T-66 et réalisé dès la première source*** : *la polarité, la dualité producteur/consommateur, les fils — c'est du vocabulaire catégorique appliqué à la syntaxe. À lire APRÈS le noyau de T-65, non avant.*

#### FORSP — *le minimum de formes spéciales, et l'axe B de T-57 par une autre porte*

:SOURCE: Anthony Bonkoski, xorvoid.com — *Forth + Lisp, réalisation du $`\lambda`$-calcul* **Le dénombrement, qui est l'argument** : « ***3 formes spéciales syntaxiques seulement*** : `'` `^` `$` ; ***1 seule forme spéciale à l'évaluation*** : `quote` ; ***10 fonctions primitives*** pour s'auto-implémenter ». *Implantation en ~600 lignes de C ; auto-implantation en moins de 80 lignes.* **ET `quote` EST LA SEULE FORME QUE L'ÉVALUATEUR DOIT TRAITER SPÉCIALEMENT** : « `push` et `pop` peuvent tous deux être implémentés comme des primitives ordinaires ». ***C'est l'axe B de l'instrument de T-57 — « K7PL écarte la quasi-citation et n'a rien à sa place » — traité par le minimum possible.*** **Et le rapport à la question 16 est direct** : /le couple `thunk` / `force` de l'appel par poussée de valeur est une distinction de PHASES portée par une parenthèse, sans tour et sans niveau. « `force` n'est pas une primitive » — il se définit en une ligne./ *Sert aussi T-61 : la réimplantabilité, avec deux chiffres.*

#### APRIL — *un langage à glyphes ENTIER, réalisé comme bibliothèque de macros*

:SOURCE: phantomics/april — *« April compiles a subset of APL into Common Lisp »* « Tirant parti des ***macros puissantes*** de Lisp et de ses facultés de traitement numérique, il met le potentiel expressif d'APL à la portée des développeurs Lisp. » ***C'EST LA PREUVE D'EXISTENCE QUE LE PROJET N'AVAIT PAS : un jeu de glyphes complet peut être une BIBLIOTHÈQUE DE MACROS au-dessus d'expressions symboliques, et non une syntaxe primitive.*** **Cela vise B6 et la position P-2 de front.** /Notre thèse — « les macros sont des glyphes de bibliothèque » — a un précédent industriel, testé sur sept implantations de Common Lisp, avec un article à l'European Lisp Symposium et une présentation à PLDI 2023 sur l'évaluation différée./ **À dépouiller pour une question précise** : /que coûte, en pratique, de faire porter un lexique de glyphes par un macro-système ? Et que devient l'hygiène quand la macro engendre du code à partir d'un caractère ?/

#### NELSON, « REASONS TO IMPROVE PROGRAMMING LANGUAGES IN AN AGE OF AI » — *les slangs de Raku*

:SOURCE: Tim Nelson, 6 août 2026 **Ce qui entre dans les bornes** : Raku « supporte les grammaires et les ***slangs***, ce qui permet ***la modification de presque toute partie du langage via des modules*** — nouveaux opérateurs, nouvelle syntaxe ». /C'est de la réflexion syntaxique au niveau de la GRAMMAIRE, et c'est le point le plus éloigné de notre ARB-018 : là où notre bac à sable refuse le métaniveau, Raku l'ouvre entièrement./ **La confrontation que l'entrée T-66 annonçait a donc un cas concret.** **Et un argument de motivation qu'il faut consigner sans le surestimer** : « améliorer un opérateur, une grammaire, un modèle d'arbre — et ***tout agent qui écrit dans ce langage hérite de l'amélioration*** ». *Opinion attestée, non mesure. Mais elle donne à l'arc syntaxe une raison d'être qu'il n'avait pas formulée.* /Réserve : l'article est en partie un plaidoyer pour Raku par un contributeur de Raku. Le biais est déclaré par l'auteur lui-même — « Data-Oriented Programming for Raku is being designed because someone (me) decided… »./

### GRIS-CeQuiNEntrePasEtOCelaVa

    AUTHORS | DATE | TITLE: CE QUI N'ENTRE PAS, ET OÙ CELA VA — cinq sources sur neuf | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] KAMILALISP — *à T-64*

*Lisp inspiré de Haskell et d'APL, symboles APL pour les opérations courantes, programmation tacite, de Bruijn fonctionnels.* **C'est du matériau T-57 et T-58 — le glyphe dans les expressions symboliques —, arrivé après la clôture de l'exploration.** *Une ligne à l'inventaire, pas de fiche.*

#### SWIFT, « A POSSIBLE TYPE-BASED MODEL FOR SCOPE RESTRICTIONS ON ~ESCAPABLE TYPES » — *à T-64, et c'est le plus riche des écartés*

:SOURCE: John McCall, forums.swift.org, 8-12 août 2026 **Hors bornes — c'est de la propriété et de la portée, non de la réflexion.** /Mais il faut le verser à l'inventaire, parce qu'il touche nos questions 32 et 39, et parce qu'une phrase y répond à notre architecture en couches./

> « Je pense que nous pouvons continuer à ***ne pas faire penser les programmeurs à tout cela À MOINS QU'ILS NE VEUILLENT SPÉCIFIQUEMENT écrire ce genre de code***, alors que Rust, je crois, encourage les gens à s'en préoccuper de manière proactive. »

***C'est la justification de nos couches, formulée par le concepteur d'un autre langage et sans nous.*** **À rapprocher du résultat de Coblenz — la propriété seule ne coûte rien de mesurable — qui dit la même chose par la mesure.** /Et une proposition de notation à retenir pour la phase 5 : porter la portée dans une SECTION GÉNÉRIQUE IMPLICITE — `Span<Element; scope storage>` — « qui pourrait être omise dans le source ordinaire, préservant l'orthographe existante ». C'est exactement le motif « inféré par défaut, déclarable » que B6 a retenu./

#### ODERSKY ET AL., « CLASSIFYING CAPABILITIES » — *à T-64 et à la mécanisation*

:SOURCE: Pham, Bračevac, Xu, Zhao, Odersky, EPFL, arXiv 2607.24504 /Des « classificateurs de capacités : une hiérarchie ***arborescente et extensible par l'utilisateur*** d'étiquettes qui classent les capacités par rôle sémantique », avec projections d'inclusion et d'exclusion./ **Et le point technique** : « la structure d'arbre permet un ***raisonnement de disjonction DÉCIDABLE*** : des classificateurs sur des branches séparées sont garantis disjoints ***quelles que soient les extensions inconnues ailleurs dans la hiérarchie*** ». *Touche notre système d'effets, non la réflexion. À l'inventaire.* **ET UN FAIT À NOTER POUR LA MÉCANISATION** : la preuve est « ***entièrement mécanisée en Lean 4*** ».

#### FUTHARK, « HOW SHOULD FUTHARK EXPOSE IRREGULAR ARRAYS » — *à T-64*

*Types de tailles avec taille existentielle — `?[m].([n]i64, [m]b, [n]c)` — pour un `flatmap` dont on ne connaît pas le résultat d'avance.* **Matériau pour la question du budget $`\beta`$ et des bornes.** *Et un chiffre honnête à consigner : la version par `flatmap` met 231 986 μs contre 12 079 μs pour la version aplatie à la main — *« pretty awful stuff »*, dit l'auteur, soit un facteur 19. Une abstraction qui borne peut coûter cher, et son concepteur le publie.*

#### SERGEY, « WHEN THE HARD PART STOPS BEING HARD » — *HORS T-66 ET HORS T-64 : cela vise la MÉCANISATION, et c'est le plus conséquent des neuf*

:SOURCE: Ilya Sergey, 14 août 2026

> « Pour cet article, la partie qui consomme d'ordinaire ***80 à 90 % de l'effort*** dans un article de conception de langage — la mécanisation de sa métathéorie et les preuves formelles de sûreté — a été faite ***par une seule personne, en Lean***, en ***environ quatre semaines***, de bout en bout, ***à l'échelle d'un compilateur de production plutôt que d'un calcul jouet***. »

**ET LE FAIT DE COMMUNAUTÉ QUI L'ACCOMPAGNE** : « les soumissions à POPL ont ***presque doublé*** cette année, de ~350 à 600 \[…\] la fraction de bouillie franchement engendrée par IA y est relativement faible. La plupart sont des travaux compétents, produits ***dix fois plus vite***. » ***NOTRE ARC DE MÉCANISATION EST « PRÊT, RIEN NE BLOQUE, L'OUTILLAGE EST À INSTALLER », ET IL PORTE TRENTE-DEUX THÉORÈMES DONT AUCUN N'EST VÉRIFIÉ PAR MACHINE.*** **Cette source dit que l'estimation de coût sur laquelle ce report repose est périmée d'un ordre de grandeur.** /RÉSERVES, et elles comptent : c'est un témoignage individuel, non une mesure ; l'auteur est partie prenante ; et « quatre semaines » pour un chercheur qui maîtrise déjà Lean et sa métathéorie n'est pas transposable tel quel./ **Mais l'ordre de grandeur mérite d'être porté à l'entrée de mécanisation**, /avec le second cas qu'il rapporte — Martin Rinard, « n'ayant jamais touché à Lean auparavant », formalisant un compilateur optimisant en un mois./ **ET UNE CIBLE DE LECTURE EN SORT, pour T-65** : l'article dont il parle, *« Tracking Borrows with Regular Expressions »*, OOPSLA 2026 — ***des expressions régulières pour capturer l'atteignabilité dans le tas***. *R-expressions et propriété dans le même énoncé : c'est la question 2 de T-65 et la sédimentation à la fois.*

### GRIS-CeQuiVaT65

    AUTHORS | DATE | TITLE: CE QUI VA À T-65 — la grammaire EST un automate, et le projet ne l'avait pas dit | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] RÉSEAU DE TRANSITION RÉCURSIF, et DIAGRAMME SYNTAXIQUE

« Un ***réseau de transition récursif*** est un ***schéma de la théorie des graphes*** employé pour représenter ***les règles d'une grammaire hors contexte***. » Et son pendant notationnel : « les diagrammes syntaxiques — ou ***diagrammes en rails*** — sont une façon de représenter une grammaire hors contexte. Ils constituent ***une alternative GRAPHIQUE*** à la forme de Backus-Naur ». \*/LE PONT QUE LA QUESTION 2 DE T-65 CHERCHE EXISTE DÉJÀ SOUS SA FORME LA PLUS ÉLÉMENTAIRE : une grammaire hors contexte EST un automate à pile, et le réseau de transition récursif est cette identification rendue visible./\* **C'est modeste et c'est exactement ce qui manquait au dossier** : /notre hiérarchie déterministe / non déterministe / à pile est posée par annotation ; le réseau récursif est la forme sous laquelle la troisième classe se lit./ **À placer AVANT Adámek et Trnková dans l'ordre de lecture — c'est l'échelon élémentaire, et il coûte dix minutes.** **ET LE DIAGRAMME EN RAILS VISE AUSSI LA QUESTION 48**, *la mise en page comme niveau du savoir-faire* : « BNF est textuel, employé par les auteurs de compilateurs ; ***les diagrammes en rails sont VISUELS, et peuvent être compris plus immédiatement par les profanes*** ». **Deux notations pour la même grammaire, dont l'une est une SILHOUETTE.** /C'est l'anti-superlativisme dans le cas le plus pur — même contenu, deux vues, deux publics — et Wirth employait déjà les deux dans le manuel de Pascal./

### GRIS-CeQuiEntreDansT66

    AUTHORS | DATE | TITLE: CE QUI ENTRE DANS T-66 — deux sources, et la première touche les TROIS bornes | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] « WHY I LIKE TCL » — *un langage qui a la réflexion SANS macro-système*

:SOURCE: q3cpma, world-playground-deceit.net, 3 octobre 2024 **Les trois bornes de T-66 sont touchées par un seul système, ce qui n'était arrivé avec aucune source.**

- ***QUESTION 16 — la réflexion sans tour*** : « `uplevel` (évaluer dans un autre cadre de pile) et `tailcall` (remplacer la procédure courante par une autre) vous permettent ***d'augmenter le langage en implémentant vous-même structures de contrôle et mots-clés*** ». /Et `upvar` : « une référence de variable n'est qu'un nom (une chaîne) attaché à un autre numéro de cadre de pile, ce qui est assez élégant au regard des concepts fondamentaux du langage »./ ***Voilà une réflexion syntaxique qui ne passe NI par une tour de phases NI par un macro-système : elle passe par l'accès au CADRE D'ÉVALUATION.*** **Le document n'avait jamais envisagé cette troisième voie.**
- ***B6 — et l'auteur dit lui-même ce qui lui manque*** : « ***inférieur à la synergie de Common Lisp entre macros non hygiéniques, homoiconicité de type “AST nu”, `gensym` et quasi-citation***, mais tout de même assez puissant ». Et dans les défauts : « ***fonctionnalités de métaprogrammation manquantes, comme le parcours de code et la quasi-citation*** ». ***UN PRATICIEN QUI DISPOSE DE LA RÉFLEXION ET PAS DE LA CITATION DIT CE QUE LA CITATION LUI MANQUE.*** **C'est l'axe B de l'instrument de T-57 — « K7PL écarte la quasi-citation et n'a rien à sa place » — instruit par le manque, ce qu'aucune source n'avait fourni.**
- ***ARB-018 — et c'est la confrontation que T-66 annonçait*** : « les ***interprètes sûrs*** comme ***prison très granulaire*** pour l'évaluation de script Tcl non fiable (par exemple des fichiers de configuration) ». ***Un bac à sable pour l'évaluation, dans un langage qui donne par ailleurs accès au cadre de pile.*** **Notre ARB-018 refuse le métaniveau ; Tcl l'ouvre et le confine. Ce sont deux réponses à la même question, et la seconde n'avait pas de nom dans le document.**

**ET DEUX POINTS POUR T-61** : *« syntaxe extrêmement consistante et élégante décrite en 12 règles tenant dans une courte page de manuel et ***aucun mot-clé réservé***, approchant le niveau de pureté ascétique d'un Lisp ou d'un Forth ».* **Douze règles : le chiffre le plus bas rencontré, devant les sept pages de Scheme.** *Et la réserve, franche : « soyons honnêtes, Tcl est presque mort \[…\] pas d'équivalent LSP, pas de gestionnaire de paquets vivant ».*

#### KING, « AN INTRODUCTION TO TYPECLASS METAPROGRAMMING » — *un TROISIÈME modèle, et B6 ne le connaît pas*

:SOURCE: Alexis King, 25 mars 2021

> « La ***métaprogrammation par classes de types*** est une technique puissante permettant ***d'engendrer automatiquement du code de niveau TERME à partir d'information de TYPE statique***. \[…\] La métaprogrammation par classes de types encourage une perspective différente : ***les classes de types sont des FONCTIONS DES TYPES VERS LES TERMES***. »

***LA TAXINOMIE DE LILIS ET SAVIDIS EN COMPTE SIX ; CELUI-CI N'Y FIGURE PAS SOUS CE NOM, ET IL EST ORTHOGONAL AU NÔTRE.*** **Nos macros sont pilotées par la SYNTAXE ; celle-ci est pilotée par les TYPES.** *K7PL a un système de types riche — grades, couches, effets — et n'a jamais envisagé qu'il puisse ENGENDRER du code plutôt que seulement en refuser.* **ET UN POINT DE DÉCOUVRABILITÉ, au sens de la question 43** : la technique est « ***reléguée à un savoir folklorique connu des seuls programmeurs Haskell avancés*** ». /Un mécanisme puissant, présent dans le langage, employé par des bibliothèques majeures, et que presque personne ne découvre. C'est le mécanisme de la question 43 attesté dans un langage réel./

### GRIS-CeQuiVaLaMcanisation

    AUTHORS | DATE | TITLE: CE QUI VA À LA MÉCANISATION — et c'est le résultat principal de ce lot | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] WAYNE, « WHY DON'T PEOPLE USE FORMAL METHODS ? » — *la ligne de base, et elle date de 2019*

:SOURCE: Hillel Wayne, 21 janvier 2019 **La note de coût écrite le 7 août s'appuyait sur un seul témoignage. Voici le point de comparaison qui lui manquait, et il est chiffré.**

> « En employant des solveurs SMT avancés et un langage de vérification de pointe, Microsoft a pu écrire ***5 000 lignes de Dafny vérifié en seulement 3,7 années-personne*** ! Soit un rythme fulgurant de ***QUATRE LIGNES PAR JOUR***. \[…\] Le record précédent était probablement seL4, dont les développeurs écrivaient l'équivalent de ***deux lignes de C par jour***. »

\*/LE COUPLE EST LE RÉSULTAT : Wayne 2019 dit quatre lignes par jour ; Sergey 2026 dit une métathéorie d'échelle industrielle en quatre semaines. Sept ans séparent les deux, et le second ne vaut que rapporté au premier./\* **ET WAYNE DONNE LE DILEMME QUI EST CELUI DE K7PL, formulé mieux que le document ne l'a fait** :

> « Les vérificateurs formels ont un dilemme : \*/plus le langage est expressif, plus il est difficile d'y prouver quoi que ce soit. Mais moins le langage est expressif, plus il est difficile d'y ÉCRIRE quoi que ce soit./\* »

/C'est la tension de l'arc entier, en une phrase. Nos couches sont une réponse à ce dilemme — la couche 3 pure et prouvable, la couche 1 expressive et confinée — et personne ne l'avait écrit ainsi./ **TROIS AUTRES POINTS À RETENIR.**

- ***Les trois camps de la spécification de code*** — théorème indépendant ; pré/post-conditions enchâssées ; types dépendants — « correspondent aux trois domaines de la vérification automatique : tests, contrats, types. ***Ce n'est pas une coïncidence. La correction est un SPECTRE*** ».
- ***La vérification PARTIELLE est ce que font les langages*** : « Rust, qui prouve la sûreté mémoire, et Pony, qui prouve la sûreté des exceptions \[…\] on ne peut y faire ***que*** de la vérification partielle ». **C'est notre catégorie, et elle est nommée.**
- ***Et l'obstacle à la vérification de CONCEPTION est SOCIAL, non technique*** : « les programmeurs tendent à se défier des artefacts logiciels qui ne sont pas du code ou qui ne sont pas synchronisés de force avec le code ». *Même motif que la documentation, les commentaires, les diagrammes.* **À verser au billet aux pairs.**

### GRIS-CeQuiVaT64CommeMatriau

    AUTHORS | DATE | TITLE: CE QUI VA À T-64 COMME MATÉRIAU — six pièces, dont deux qui pèsent | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] KING, « A BREAK FROM PROGRAMMING LANGUAGES » — *et c'est une pression de falsification, honnêtement dite*

:SOURCE: Alexis King, 29 mai 2025 — *billet de départ après dix ans sur GHC, Racket et Hackett* **Genre à haut rendement identifié par T-63 : le billet d'abandon après usage prolongé. Celui-ci vient de quelqu'un qui a travaillé sur le compilateur.**

> « Dix ans à travailler sur les langages de programmation et à y penser m'ont forcée à admettre une vérité humiliante : ***JE NE SAIS PAS CONSTRUIRE UN MEILLEUR LANGAGE DE PROGRAMMATION.*** \[…\] Le défi de la conception de langage n'est pas d'étendre une frontière bien définie, c'est \*/de se colleter à une liste sans fin de COMPROMIS FONDAMENTAUX entre traits mutuellement incompatibles/\*. »

« \*/Nous ne pouvons pas construire l'Unique Vrai Langage de Programmation parce que nous ne pouvons pas tout avoir à la fois, et nous ne pouvons pas espérer décider universellement quels compromis sont les bons./\* » ***TROISIÈME ROUTE VERS L'ANTI-SUPERLATIVISME, et la première qui vienne d'une praticienne plutôt que de la littérature.*** **Blackwell le dit depuis 1973 ; King le dit après dix ans de pratique.** **ET DEUX COMPROMIS DE SA LISTE NOUS VISENT NOMMÉMENT.**

- « Les systèmes de ***métaprogrammation sophistiqués*** peuvent réduire radicalement le code répétitif et améliorer concision et même lisibilité, \*/mais ils peuvent avoir un surcoût substantiel à l'exécution ou à la compilation et tendent à CONTRARIER L'OUTILLAGE AUTOMATIQUE/\*. » *C'est le coût de B6, attesté, et le dépouillement n'en avait qu'une doléance.*
- Sur le système polyglotte : « ***la disparité d'impédance aux frontières de langage***, l'outillage bien plus complexe qu'exige un système polyglotte, et ***le fardeau de connaissance accru*** ». ***C'est le coût de nos trois couches, nommé par quelqu'un qui a envisagé cette voie et l'a trouvée brutale.*** **À porter en regard de l'argument de Coblenz, qui joue dans l'autre sens.**

#### FOOTE ET YODER, « BIG BALL OF MUD » — *et il donne à T-61 son axe manquant*

**L'article de 1999 et son fil lobste.rs.** *Sept motifs ; deux nous concernent.*

- ***L'ÉROSION EST LE CAS GÉNÉRAL*** : « ***même les systèmes dotés d'architectures bien définies sont sujets à l'érosion structurelle.*** Le flot incessant d'exigences changeantes qu'attire tout système réussi peut graduellement en saper la structure. » /C'est le résultat de Ruby — « il est aussi facile d'écrire du beau code que du mauvais » — généralisé à l'architecture. ***L'élégance TENUE est un travail, pas une propriété.***
- ***LES COUCHES DE CISAILLEMENT***, et c'est un axe que nous n'avons pas : « les systèmes et leurs éléments ***évoluent à des RYTHMES différents***. Ce faisant, ce qui change vite tend à se distinguer de ce qui change lentement. Les ***couches de cisaillement*** qui se développent entre eux sont comme des lignes de faille \[…\] qui favorisent l'émergence d'abstractions durables. » \*/NOS COUCHES SONT DÉCOUPÉES PAR LA DISCIPLINE DE RESSOURCE. Celles-ci sont découpées par le RYTHME DE CHANGEMENT. Ce sont deux axes distincts, et le document n'a jamais examiné le second./\*

#### VAN DE WOESTYNE, « SUR LE CHOIX D'OCAML » — *et un argument franc pour l'expression symbolique*

:SOURCE: Xavier Van de Woestyne, 25 août 2024 — *source FRANCOPHONE, ce qui est rare et compte pour la question 41* **Le passage utile est celui sur Dune, dont le langage de description est en expressions symboliques** — quatre raisons données : « l'AST des expressions symboliques étant ***drastiquement simple***, le parsing est très simple \[…\] le langage dispose de ***TERMINAISON***, ce qui le rend plus facile à inspecter en cas d'erreurs (\*/pour toute personne ayant tenté de traiter des erreurs dans de gros fichiers YAML/\*…) \[…\] très facile à apprendre et à décrire \[…\] il permet de décrire de ***véritables programmes*** ». ***LA TERMINAISON — le fait que le délimiteur se ferme — EST DONNÉE COMME AVANTAGE POUR LE DIAGNOSTIC D'ERREUR, contre YAML.*** **C'est un appui pour l'arbitrage 3 qu'aucune source n'avait fourni sous cet angle : la parenthèse ne sert pas qu'à lire, elle sert à SITUER UNE FAUTE.** /Le débat `ml` / `mli` qu'il traite par ailleurs — l'interface séparée de l'implantation — est du matériau pour la question 42 et pour le principe de B6 selon lequel « une interface se lit, elle ne se calcule pas »./ **RÉSERVE déclarée par l'auteur : il est rémunéré pour travailler sur l'écosystème OCaml.**

#### « QOL ADDITION TO COMMON LISP :START/:END » — *petit, et il touche P-3 et la question 12*

**Le remplacement d'un calcul d'indices par des spécifications déclaratives** : `(subseq str '(:after #\b) '(:before #\f))` au lieu de `(subseq str (+ (position #\b str) 1) (position #\f str))` ; avec `:from`, `:until`, `:last`. **Le motif donné** : « ***améliore grandement la lisibilité et aide à prévenir les erreurs de décalage*** ». /Et une phrase qui entre en collision frontale avec la question 41 : « j'aime vraiment quand Common Lisp se lit comme un dialecte de l'ANGLAIS, c'est facile pour l'œil et pour le cerveau »./ ***LA MÊME PRÉFÉRENCE QUE MASON ET SETON MESURENT COMME INÉQUITABLE, ÉNONCÉE COMME UN AGRÉMENT.*** **À verser à la question 41 : c'est le témoignage d'un lecteur pour qui le schéma anglais est disponible, et il en jouit sans le savoir.** *Et pour la question 12 : l'extension se fait par une fonction qui OMBRE `cl:subseq` — une modification de langage réalisée en bibliothèque, quatre lignes.*

#### « IS SOFTWARE ABSTRACTION KILLING CIVILIZATION ? » — *un correctif de GENRE*

:SOURCE: datagubbe.se, début 2021 — *réfutation point par point d'une conférence de Jonathan Blow* **L'intérêt n'est pas la thèse mais la MÉTHODE, et elle vise un genre que le dépouillement a beaucoup lu.** *L'auteur reprend chaque affirmation — « cinq neufs », « l'Unix en trois semaines de Thompson », « on ne peut plus juste copier un programme » — et montre le tri sélectif.* « Blow a, assez ironiquement, dû ***oublier sélectivement de larges pans de l'histoire de l'informatique*** pour arriver à son propos. » ***LE GENRE « TOUT ÉTAIT MIEUX AVANT » EST UN GISEMENT QUE L'INSTRUMENT DE T-63 CLASSE EN OPINION ATTESTÉE ; CETTE PIÈCE MONTRE QU'IL FAUT PARFOIS LE CLASSER PLUS BAS.*** **À retenir pour T-64, quand il faudra pondérer.** *Et une phrase à garder : « la complexité est un problème fabriqué par l'homme, avec une solution tout aussi fabriquée par l'homme ».*

### GRIS-RcupresClassesNonEncoreDpouilles

    AUTHORS | DATE | TITLE: RÉCUPÉRÉES, CLASSÉES, NON ENCORE DÉPOUILLÉES — et je le dis plutôt que de faire semblant | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] « JAVA SUCKS », jwz — *TEXTE BRUT FOURNI LE 9 AOÛT ; la réserve est levée*

:SOURCE: Jamie Zawinski, 1997-2000, texte intégral + le fil lobste.rs (56 messages, 31 points)

1.  LE GRIEF QUI VISE LA QUESTION 15 — *l'arbitrage de périmètre, attesté avec son coût*

    > « Le fait est qu'il y a ***QUATRE CHOSES COMPLÈTEMENT DIFFÉRENTES*** qui vont sous le nom de “Java” : ***un langage ; une énorme bibliothèque de classes ; une machine virtuelle ; un modèle de sécurité***. Sun voudrait vous faire croire que ce sont la même chose \[…\] mais c'est ***une fiction de marketing***. Pire encore, le fait que Sun ait tant poussé cette idée ***a gravement nui à l'acceptation de Java***. \[…\] Si Sun n'avait pas tant cherché à confondre ces quatre choses complètement différentes \[…\] Java aurait probablement complètement supplanté C++ aujourd'hui. »

    ***K7PL A EXACTEMENT LES MÊMES QUATRE : un langage, une bibliothèque, un modèle d'exécution et de compilation, et un modèle de VÉRIFICATION — le solveur.*** \*La question 15 demandait « ce que porte le langage, ce que portent ses outils ». Voici le coût de ne pas trancher, nommé par quelqu'un qui l'a vu de près.\* *Et l'auteur donne même l'ORDRE qu'il aurait fallu : « s'ils avaient d'abord livré les compilateurs natifs, puis la machine virtuelle, puis le modèle de sécurité ».* **Un ordre de livraison, pas seulement une distinction conceptuelle.** *RÉSERVE, apportée par le fil : technomancy trouve « cette prise étrange — l'idée que Java sans la JVM aurait été bien plus réussi n'est pas quelque chose que j'avais jamais entendu ».*

2.  LE GRIEF QUI CRÉDITE NOTRE SÉDIMENTATION — *et il vient d'un document hostile*

    « ***Java n'a pas de `free()`.*** Je dois admettre d'emblée qu'après cela, tout le reste est du rabiot. ***Ce seul point me rend capable de pardonner à peu près tout le reste, si flagrant soit-il.*** Étant donné ce seul point, tout le reste de ce document s'estompe presque jusqu'à l'insignifiance. » ***K7PL N'A NI RAMASSE-MIETTES NI `free()`.*** **Le seul point qui, selon un critique acharné, achète le pardon de tout le reste, nous l'avons — et sans le coût du ramasse-miettes.** *À rapprocher de Coblenz via Ferdowsi : la propriété seule ne coûte rien de mesurable. Les deux vont dans le même sens par des routes opposées — l'une par la mesure, l'autre par la doléance.*

3.  TROIS GRIEFS QUI SONT DES APPUIS POUR B6

    - « Il est ***difficile de vivre sans aucun de*** : fonctions locales à portée lexicale ; ***un système de macros*** ; et fonctions inlinées. »
    - Et le coût, formulé comme une alternative forcée : « étant donné qu'il n'y a pas de préprocesseur \[…\] et ***aucun équivalent du `flet` de Common Lisp (ni même de `macrolet`)***, on finit soit par ***dupliquer du code***, soit par ***laisser le code inefficace***. ***Ce sont deux mauvais choix.*** »
    - Sur `assert` et `#ifdef DEBUG` : le contournement « est ***si gratuitement verbeux que ça me fait mal aux dents***. (Voir aussi : absence de tout système de macros.) »

    \*/TROISIÈME ATTESTATION DU MANQUE DE MACRO-SYSTÈME dans le dépouillement — après Tcl et après King. Et celle-ci est la seule qui chiffre le coût en ALTERNATIVE FORCÉE : dupliquer, ou être lent./\*

4.  ET DEUX GRIEFS QUI VONT CONTRE NOUS, ce qui est plus utile

    - ***CONTRE L'ARBITRAGE 3, qui refuse tout point d'extension au noyau*** : « la notion de méthodes “appartenant” à des classes est nulle. ***N'importe qui devrait pouvoir définir de nouvelles méthodes NON CONFLICTUELLES sur n'importe quelle classe*** (sans redéfinir les méthodes existantes). Cela ne casse aucune abstraction, puisque le code qui s'en soucie ne peut pas, par définition, appeler les méthodes nouvelles. \[…\] C'est une autre façon de dire que les fonctions génériques, ***convenablement contraintes par la règle du non-remplacement externe***, gagnent. » ***UNE TROISIÈME POSITION QUE LE DOCUMENT N'AVAIT PAS ENVISAGÉE : extension AUTORISÉE, remplacement INTERDIT.*** **L'arbitrage 3 oppose « point d'extension » et « aucun » ; il y a un milieu, et il est assorti d'une règle qui le rend sûr.**
    - ***CONTRE L'ABSENCE D'ÉCHAPPATOIRE — question 17*** : « en faisant de `new` la seule interface possible vers l'allocation, et ***en n'ayant aucune porte de derrière par laquelle échapper à la prison de la sûreté de typage***, il y a toute une classe d'optimisations anciennes et bien connues qu'on ne peut simplement pas faire. » *La question 17 demandait ce qui empêcherait les échappatoires de devenir la norme. Voici l'argument inverse : leur ABSENCE a un coût, et il est nommé.*

5.  ET DEUX AUTRES, NOTÉS

    *« La distinction entre champs et méthodes est stupide. `foo.x` devrait être défini comme équivalent à `foo.x()` » — c'est le principe d'accès uniforme, donc P-1, attesté comme grief.* /« Il n'y a aucun moyen de signaler sans lancer : aucun moyen de signaler une condition exceptionnelle et qu'un gestionnaire vous dise “allez-y, continuez quand même”. Au moment où le gestionnaire s'exécute, la portée fautive a déjà été quittée. » — le système de conditions de Common Lisp contre les exceptions ; à verser à la question 30 et au système d'effets./

6.  LA CHUTE, AJOUTÉE PLUS TARD, ET C'EST LA CHARGE DU GENRE

    > « *(Eh bien, c'est ainsi que ce document se terminait à l'origine. Mais ce n'est plus vrai, parce que ***je suis revenu à bidouiller en C, puisque c'est encore le seul moyen de livrer des programmes portables***.)* »

    ***UN DOCUMENT QUI TIENT JAVA POUR « LE MEILLEUR LANGAGE QUI SOIT AUJOURD'HUI » SE TERMINE PAR LE RETOUR DE SON AUTEUR AU LANGAGE QU'IL APPELLE « UN ASSEMBLEUR PDP-11 QUI SE CROIT UN LANGAGE ».*** **Les mérites techniques n'ont pas décidé.** /C'est la charge du genre, et elle vise l'arc entier : un langage peut gagner tous les arguments de conception et perdre son auteur sur la portabilité de la livraison./

7.  ET LE FIL DONNE UNE RÈGLE DE MÉTHODE QUE L'INSTRUMENT N'AVAIT PAS

    **Une doléance VIEILLIT, et ses griefs vieillissent INÉGALEMENT.**

    - *hyperpape* : « il est intéressant de le lire et de réaliser : “ah oui, cette critique existe sous cette forme \*/parce qu'il n'y avait pas de compilateur à la volée à l'époque/\*” — bien que ce ne soit pas le cas de toutes les plaintes de l'article » ;
    - *neilmadden*, sur la fuite de `substring()` : « ***ils ont fini par corriger cela une douzaine d'années après que jwz l'eut signalé*** » ;
    - *gf0* : « beaucoup de gens ont une aversion pour Java, ***fondée surtout sur des expériences périmées***. Il est dans l'intérêt de tous ***de mettre à jour ces a priori***. » *Suit la liste : types algébriques et filtrage, immuabilité par défaut pour les enregistrements, fils virtuels.*
    - *et à l'inverse*, LAC-Tech sur les interfaces contre l'héritage multiple : « ***je suis encore 100 % d'accord avec ceci*** ».

    \*/D'OÙ UN QUATRIÈME CHAMP À EXIGER DE TOUTE OPINION ATTESTÉE, en plus de la source, de la date et du N : LE GRIEF EST-IL STRUCTUREL OU CONTINGENT ? — porte-t-il sur la conception du langage, ou sur son implantation à la date du grief ?/\* **Sans ce champ, l'inventaire de T-64 pèsera comme des faits des artefacts d'implantation.** *Et le tri n'est pas toujours faisable : c'est justement ce qui doit être écrit.* **UN SECOND POINT DE MÉTHODE, DU MÊME FIL** : *yosefk — « Zawinski est un type Lisp, et son étalon est Lisp ».* **Le cadre de référence d'une doléance doit être déclaré**, *et celui-ci l'est par un lecteur, pas par l'auteur. K7PL sera lu au même étalon.*

8.  ET LE FIL DONNE LA TROISIÈME ATTESTATION DU RÉSULTAT DE RUBY

    /doctor_eval, sur Java EE : « une façon absolument terrible d'écrire du logiciel, avec des abstractions et des indirections sans fin. J'estime que cela a fait reculer mon entreprise de plusieurs années. » Puis : « j'ai fini par abandonner tout cela et je suis revenu à écrire du JavaSE ordinaire — ***la différence était incroyable*** »./ **Et gcupc nomme le mécanisme** : « ce qu'il y avait de mauvais, c'étaient ***des erreurs non forcées*** — Java ***ne vous OBLIGEAIT pas*** à écrire des échafaudages branlants de `SpringControllerFactoryFactory` \[…\] ***mais c'était comme ça qu'on faisait***. » ***TROISIÈME ATTESTATION, APRÈS RUBY ET APRÈS BIG BALL OF MUD : le langage permet, la culture dispose, et le résultat est inutilisable. L'élégance TENUE n'est pas une propriété du langage.***

#### RÉSERVE LEVÉE — *le fragment ci-dessous est conservé pour mémoire*

**Le cadrage est venu ; le corps de la liste de griefs, non.** /La page est structurée en listes imbriquées que l'extraction rend vides — « About the Java language itself: » suivi de rien. Deux tentatives, plus le fil lobste.rs qui revient vide lui aussi./ ***C'est une récupération partielle, non un blocage : je le signale plutôt que de prêter à jwz des griefs que je n'ai pas lus.*** **Ce qui est venu vaut d'être gardé, parce que c'est un jugement d'ensemble et qu'il est daté** :

> « Je pense que Java est le meilleur langage qui soit aujourd'hui, c'est-à-dire \*/le seul marginalement acceptable dans l'ensemble des langages complètement nuls avec lesquels nous devons travailler ici, dans le monde réel/\*. » *Puis : « cependant, en m'installant, j'ai trouvé quantité de choses qui m'irritent. À mesure que cela arrivait, je les notais. »*

**Le GENRE est celui que T-63 a identifié comme le plus productif** — *le grief consigné au fil de l'usage, par quelqu'un qui tient le langage pour le meilleur disponible*. **Et la précaution que l'auteur prend lui-même est celle de notre instrument** : « certaines des plaintes qui suivent ont pu être traitées dans des versions ultérieures, ***ou bien être des malentendus de ma part*** ». *Si Anthea veut le contenu, il faudra le texte brut.*

#### ARCAN — *HORS PÉRIMÈTRE, et je préfère l'écrire que d'étirer les bornes*

/Moteur d'affichage et de composition, quinze ans de travail d'un seul auteur, raconté en journal. Il a une interface de script en Lua, mais ce n'est pas un travail de CONCEPTION DE LANGAGE : ni réflexion syntaxique, ni macro-système, ni bac à sable au sens d'ARB-018./ ***Il ne touche aucune des trois bornes de T-66, ni aucune des trois questions de T-65. Écarté.*** **Une seule ligne mérite d'être gardée, et elle vise notre méthode plus que notre objet** :

> « On ne sait pas ce qu'on ne sait pas, et les idées ne valent pas cher. \*/Mettez-vous à construire la chose pour voir où et pourquoi elle est défectueuse. Les réponses sont dans les callosités, pas dans les invites./\* »

*Un projet qui en est à sa cent-quarante-cinquième passe de spécification sans une ligne d'implantation ferait mal de la ranger sans la lire.* **Trois des quinze liens sont des fils de commentaires attachés à des articles de la liste** — *java sucks, Big Ball of Mud, Arcan — et non des sources autonomes.*

### GRIS-LaRgleDeStroustrup

    AUTHORS | DATE | TITLE: LA RÈGLE DE STROUSTRUP — et elle date nos échéances | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtUneAttestationQueLeDogmeExiste

    AUTHORS | DATE | TITLE: ET UNE ATTESTATION QUE LE DOGME EXISTE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-CeQueLeSondageNAPasDonn

    AUTHORS | DATE | TITLE: CE QUE LE SONDAGE N'A PAS DONNÉ | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LochbaumProblemsWithBqn

    AUTHORS | DATE | TITLE: LOCHBAUM, « PROBLEMS WITH BQN » — le concepteur classe ses propres défauts, du pire au moindre | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA SURCHARGE DE VALENCE — *deuxième problème le plus grave selon son auteur, et il donne la RAISON*

> « ***Paires monade-dyade incohérentes.*** BQN hérite des fonctions `+×⌊⌈|` et ajoute `∧∨<>=≠≡≢↕⍷`, qui ***ne sont appariées que par leur GLYPHE et pour aucune autre raison*** — les deux valences correspondent au symbole, mais elles ne correspondent pas entre elles. ***Je trouve qu'il n'y a tout simplement PAS ASSEZ DE BONS GLYPHES pour les séparer toutes***, mais je suis sûr que les appariements pourraient être améliorés. ***Dans un langage futur, s'entend, BQN ayant dépassé le point où il pourrait les changer.*** »

***LA SURCHARGE DE VALENCE N'EST PAS UN CHOIX DE CONCEPTION : C'EST UNE CONTRAINTE DE BUDGET DE GLYPHES, ET SON AUTEUR LE DIT.*** **Cela vise la question 1 — arité fixe et surcharge de valence — et la question 3 — combien de glyphes ?** *P-1 refuse la surcharge ; voici ce qu'il en coûte, dit par quelqu'un qui l'a acceptée et le regrette : il faut alors ASSEZ DE BONS GLYPHES, et il n'y en a pas assez.* **ET C'EST LE CHIFFRAGE QUE LA QUESTION 3 N'AVAIT PAS** : /non pas « combien de glyphes peut-on apprendre » — question d'ergonomie — mais « combien de BONS glyphes existe-t-il », qui est une question de ressource et qui borne le reste./ *Une page dédiée est annoncée pour la discussion complète : `commentary/overload.html`, non dépouillée.*

#### LE TRAIN, ET IL A ENFIN UN NOMBRE — *question 6 et V-1*

> « ***Les longs trains sont difficiles à analyser pour les humains.*** Dans un train composé uniquement de fonctions, le comportement d'une fonction — appliquée directement aux arguments, ou aux résultats d'autres fonctions — est déterminé par ***sa DISTANCE au côté droit du train***. Avec un train plus long, il devient facile de perdre le fil de ***la parité de cette distance***. \[…\] ***La longueur à partir de laquelle la difficulté commence varie d'environ QUATRE À HUIT ÉLÉMENTS, selon le lecteur.*** Un train de fonctions seules est le pire cas, car les sujets ne peuvent occuper qu'une position et servent donc d'ancres. »

***QUATRE À HUIT. C'est le premier chiffre que le dépouillement obtienne sur les trains, et il vient du concepteur.*** **V-1 a conclu sur la transposition des règles de train ; ce chiffre porte sur leur LISIBILITÉ, ce que V-1 ne pouvait pas faire.** /Et le mécanisme est nommé : la PARITÉ d'une distance, que le lecteur doit tenir de tête. C'est de la charge cognitive, au sens strict, et elle est identifiable./

#### ET TROIS AUTRES QUI VISENT NOS QUESTIONS

- ***LE GLYPHE, SON COÛT ET SON GAIN, EN UNE LIGNE*** : « ***Les glyphes sont difficiles à taper.*** Beaucoup de travail a été fait là-dessus. Toujours là, toujours un problème. ***En revanche, les glyphes sont faciles à LIRE, et à écrire À LA MAIN !*** » *Le compromis de P-2, énoncé par celui qui l'a payé.* **Avec un problème matériel que le projet n'avait pas envisagé** : « ***Mauvais support des polices*** — les caractères `⥊∾⟜⎉⚇˜` et les lettres ajourées sont absents de beaucoup de polices ou dessinés bizarrement. »
- ***LE NOM CONTRE LE GLYPHE, ET C'EST P-2 DE FACE*** : « ***Les modificateurs NOMMÉS occupent beaucoup plus de place que les primitifs.*** `F _m_ G` contre `F∘G` : la syntaxe est la même mais ils ne se ressemblent pas du tout. \[…\] Cela signifie qu'***un programmeur soucieux du style doit ajuster sa façon d'écrire selon que les choses sont nommées ou non***, et rend les modificateurs nommés moins intégrés au langage. » ***NOTRE DUALITÉ GLYPHE/ALIAS PRODUIT EXACTEMENT CET EFFET, et personne ne l'avait signalé : le texte ne se met pas en page de la même façon selon qu'on emploie le glyphe ou le nom.***
- ***ET LA MISE EN PAGE EST UN OBJET DE CONCEPTION — question 48, confirmée*** : « ***Les modificateurs paraissent plus lâches que les trains sans espaces.*** \[…\] Ajouter une espace le corrige : `⋆∘- ×˜` relie visuellement `⋆∘-`. ***Il est regrettable que ce soit quelque chose que le SCRIPTEUR doive faire plutôt que quelque chose que la NOTATION encourage.*** » *« Ce que la notation encourage » — c'est la formulation exacte de la question 48.*

#### ET UN AVERTISSEMENT SUR LE TACITE, POUR LA COUCHE 3

« ***L'évaluation tacite est OPAQUE.*** Évaluer une fonction dérivée fait beaucoup de travail qui souvent ***ne peut être rattaché à aucun emplacement particulier dans la source***. C'est pourquoi les traces d'exécution ne creusent pas dans les fonctions tacites, pour l'instant du moins. » ***UNE FONCTION TACITE N'A PAS DE POSITION SOURCE. Cela vise la question 30 — que dit le message d'erreur — et la question 31, la porte de sortie du tacite.***

#### ET LA SECTION « PROBLÈMES RÉSOLUS » EST UN JOURNAL DE CONCEPTION

*Une trentaine d'entrées, en ordre chronologique inverse. Deux valent d'être notées.*

- « ***APL n'est pas hors contexte*** — ***Résolu par les conventions de CASSE des noms de variables*** », vues dans APL, « les casses étant inversées par rapport à BQN ». \*/UNE PROPRIÉTÉ GRAMMATICALE OBTENUE PAR UNE CONVENTION LEXICALE. C'est exactement ce que la question 19 demande — quelle convention sera VÉRIFIÉE — et voici un cas où la convention n'est pas un style mais une condition d'analyse./\*
- « ***Les fonctions ne sont pas de première classe*** — résolu en permettant à une variable d'être écrite avec ***un RÔLE SYNTAXIQUE différent de celui avec lequel elle a été créée***. »

**Le genre « journal de conception publié » est ce que le projet devrait tenir lui-même**, *et le dépouillement ne l'avait rencontré qu'ici et dans le manuel de TXR.*

### GRIS-UiuaPageDeConception

    AUTHORS | DATE | TITLE: UIUA, PAGE DE CONCEPTION — sept critères de choix des glyphes, et le formateur justifié | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LES SEPT CRITÈRES DE CHOIX D'UN GLYPHE — *question 24, et ils viennent du concepteur*

« La plupart des glyphes d'Uiua ont été choisis pour l'une de quelques raisons :

1.  c'est ***un symbole mathématique courant*** ;
2.  c'est une fonction ***très couramment employée*** et elle doit faire ***peu de bruit de ligne*** ;
3.  il est ***employé dans d'autres langages de tableaux*** ;
4.  ***il me rappelle un peu ce qu'il fait*** ;
5.  sa fonction est abstraite, mais il y a d'autres fonctions apparentées, ***alors elles emploient toutes des glyphes apparentés*** — *« fold a cette belle symétrie avec reduce et scan » ; les fonctions d'indexation, de recherche et de groupement « sont toutes des CERCLES »* ;
6.  ***les cercles et les carrés font joli*** ;
7.  ***je trouve qu'ils ressemblent à de petits bonshommes mignons***. »

***SEPT CRITÈRES, DONT TROIS SONT ESTHÉTIQUES ET ASSUMÉS COMME TELS.*** **La question 24 demandait « faut-il adopter les quatre règles d'admission d'une notation ? » ; en voici sept, appliquées.** **ET LE CINQUIÈME EST LE SEUL QUI SOIT UNE RÈGLE DE SYSTÈME** : /des fonctions apparentées reçoivent des glyphes apparentés — la famille se lit dans la FORME. C'est une contrainte que K7PL peut s'imposer et vérifier, et elle vaut plus que les six autres réunies./

#### LE FORMATEUR, ET C'EST UNE TROISIÈME POSITION SUR P-2

« J'ai décidé d'avoir ***un formateur qui transforme les NOMS en glyphes Unicode*** dès que j'ai commencé à employer des glyphes Unicode. ***Je ne voulais pas exiger un support clavier ou éditeur spécial comme APL et BQN le font.*** \[…\] L'avantage d'un formateur qui surveille les fichiers est que ***la seule fonctionnalité dont votre éditeur a besoin est de recharger les fichiers modifiés***. \[…\] ***Vous n'avez pas à mémoriser une foule de raccourcis clavier pour taper les glyphes. Vous n'avez qu'à apprendre leurs NOMS.*** » ***L'ALIAS EST LA MÉTHODE DE SAISIE ; LE GLYPHE EST LA FORME STOCKÉE. Et la justification n'est ni esthétique ni cognitive : elle est d'INDÉPENDANCE À L'OUTILLAGE, plus un argument d'amorçage.*** **V-3 avait relevé le modèle du formateur ; voici son MOTIF, et il est meilleur que ce que le document en disait.** *À rapprocher de la question 10 — la forme stockée est-elle normalisée ? — qui reçoit ici une réponse pratiquée : oui, vers le glyphe.*

#### ET LE TACITE JUGÉ PAR QUELQU'UN QUI A BÂTI UN LANGAGE TACITE

« ***J'ai découvert ce que beaucoup d'autres ont découvert en creusant le code tacite : c'est vraiment difficile à lire, à écrire et à raisonner dessus.*** » /Et sur la pile : « la manipulation de pile se prête bien davantage à produire du code illisible » — au point que la terminologie de pile a été RETIRÉE du langage./ ***UN CONCEPTEUR DE LANGAGE TACITE QUI RETIRE LE VOCABULAIRE DE LA PILE PARCE QU'IL PRODUIT DU CODE ILLISIBLE.*** **À verser à la question 31 et au dossier de la couche 3.** **Et la comparaison avec BQN donne le mécanisme** : « les opérations binaires étant INFIXES, \*/il faut analyser la structure d'ARBRE dans sa tête avant de pouvoir déterminer l'ordre des opérations/\* ». /Trois simplifications revendiquées : composition implicite ; exécution de droite à gauche AU LIEU d'un ordre d'arbre ; et « aucune expression Uiua n'exige de groupement explicite »./ ***CELA REJOINT LE CHIFFRE DE LOCHBAUM — quatre à huit — PAR LE MÊME MÉCANISME : ce que le lecteur doit tenir de tête, c'est une STRUCTURE, et le train la lui impose.***

#### ET UNE POSITION CONTRE P-3, ASSUMÉE

« ***Pas de variables locales.*** Interdire les variables locales générales a quelques avantages : je n'ai pas à les implémenter (bingo !) ; cela force à écrire du code tacite (souvent beau) ; ***cela vous libère du fardeau de NOMMER les choses*** ; et comme les valeurs n'existent que le temps nécessaire, la mémoire est allouée, réutilisée et récupérée efficacement. » *« Le fardeau de nommer » — P-3 fait du nommage une position ; en voici une qui l'évite.*

## T-58, SUITE — *« PRIMITIVE OVERLOADING », et deux concepteurs disent la même chose par deux chemins*

### GRIS-LochbaumPrimitiveOverloading

    AUTHORS | DATE | TITLE: LOCHBAUM, « PRIMITIVE OVERLOADING » — récupérée le 9 août, et elle donne une RECOMMANDATION | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA PHRASE QUI NOUS EST ADRESSÉE

> « La réponse facile est de dire qu'il vaut mieux pour BQN employer moins de caractères spéciaux \[…\] Par ailleurs, ***le nombre de beaux symboles dans Unicode est bien plus petit qu'on ne croirait***, si bien que je n'ai pas eu de meilleure idée que d'employer `≠` pour Length et `≢` pour Shape. ***DANS UN LANGAGE QUI N'EST PAS LIÉ AUX SYMBOLES UNICODE, JE RECOMMANDERAIS ABSOLUMENT DE SÉPARER LES PRIMITIVES DONT LES SENS NE VONT PAS ENSEMBLE.*** »

***K7PL N'EST PAS LIÉ AUX SYMBOLES UNICODE — P-2 lui donne un alias textuel pour chaque glyphe. La recommandation nous vise, et elle soutient P-1.*** **Et le mécanisme du blocage est nommé** : /« si toutes les paires malcommodes étaient séparées, il nous faudrait une touche de modification supplémentaire pour les faire tenir sur le clavier ! » C'est une contrainte de CLAVIER, et Uiua « évite la contrainte de clavier en traduisant les glyphes depuis des NOMS »./ **Notre formateur nous en affranchit de la même façon.**

#### LE BARÈME DE L'AUTEUR SUR SES PROPRES SURCHARGES — *cinq degrés, du meilleur au pire*

|  |  |
|----|----|
| ***Unifié*** | `⋈≍˙˘¨⌜∘○⌾⊘◶⎉⚇⎊` — *un seul concept* |
| ***Compatible*** | `-÷⋆√¬⊏⊑«»⍉⥊´˝⁼⍟` — *« deux vues d'une même idée »* |
| ***Similaire*** | `∾!/⊔⊣⊢↑↓˜⊸⟜` — *l'une s'exprime par l'autre* |
| ***Mnémonique*** | `⍋⍒⊒⊐⌽∊⌊⌈` — *liées, mais aucune ne se réduit à l'autre* |
| ***MAUVAIS*** | `+×∣∧∨<>≠=≡≢↕⍷` — *« les deux fonctions conviennent séparément au glyphe », et c'est tout* |

***UN CONCEPTEUR QUI CLASSE SES PROPRES DÉCISIONS EN CINQ DEGRÉS ET EN MET TREIZE AU PIRE.*** **C'est une grille que K7PL peut reprendre telle quelle pour son jeu de glyphes** : *avant d'admettre un signe pour deux sens, dire à quel degré on est.* **Question 24, et c'est une meilleure réponse que les sept critères d'Uiua parce qu'elle est ORDONNÉE.**

#### LE COÛT DE LA SURCHARGE EST DANS L'OUTILLAGE, ET C'EST L'ARGUMENT QUE LE PROJET N'AVAIT PAS

> « Quel est l'inconvénient pratique de la surcharge ? \*/Un programmeur expérimenté s'y habitue et n'éprouve aucune difficulté, ou du moins ne la remarque pas. Les utilisateurs NOUVEAUX ou OCCASIONNELS peuvent facilement se tromper de cas et rester bloqués./\* Et ***la surcharge gêne divers genres d'OUTILS***, et la traduction de code vers d'autres langages. »

**Et le cas d'Uiua est analysé comme contre-épreuve** : « il a conçu un langage plus facile à expliquer automatiquement parce que ***UN SYMBOLE VEUT DIRE UNE SEULE CHOSE***. Donc, rien qu'avec des infobulles fixes \[…\] on peut passer la souris sur une section de code et obtenir ***une description exacte de chaque primitive, sans cas hors de propos à filtrer***. ***Il faudrait une vraie ANALYSE SYNTAXIQUE pour faire cela en BQN, quand c'est seulement possible.*** » ***LA SURCHARGE SE PAIE EN OUTILLAGE, ET LE BÉNÉFICE VA AUX EXPERTS.*** \*C'est la même structure que le résultat de l'ecological interface design — le bénéfice de tout montrer va aux experts — et que la question 43.\* *Question 18 — que réserve K7PL à qui écrit du code — reçoit ici sa réponse par la négative : ce qu'on ne surcharge pas, l'outil peut l'expliquer sans analyse.*

#### ET LA RAISON PROFONDE — *la surcharge porte sur les VALEURS, non sur la SYNTAXE*

« La difficulté à résoudre les primitives vient de ce que ***la surcharge monade-dyade à la manière d'APL s'applique aux VALEURS, non à la SYNTAXE***. \[…\] mais quand le `-` ambivalent est ***une valeur de première classe***, une occurrence peut n'avoir même pas un seul sens, comme dans `Minus ← - ⋄ Minus 3 Minus 4`. » ***C'EST L'ARGUMENT SÉMANTIQUE DE P-1, ET IL N'EST PAS ESTHÉTIQUE.*** **L'arité fixe n'est pas une préférence de lisibilité : c'est ce qui permet à une occurrence d'avoir un sens.** /Et une distinction à retenir, sur le principe qui gouverne APL : « APL n'est pas vraiment un langage “une seule façon évidente de le faire” au sens de Python, mais il suit un principe que je décrirais comme ***“UNE FAÇON SUFFIT”*** »./

### GRIS-UiuaWhyDoesnTUiuaHaveFirstClassFunctions

    AUTHORS | DATE | TITLE: UIUA, « WHY DOESN'T UIUA HAVE FIRST-CLASS FUNCTIONS ? » — et B6 y trouve sa thèse la plus forte | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] CE QUE L'ARITÉ CONNUE ACHÈTE — *trois choses, dont une chiffrée*

« Le langage a commencé à s'appuyer de plus en plus sur le fait que ***les signatures de pile soient BIEN DÉFINIES***. Cette propriété ***détecte les erreurs tôt***, ***permet des optimisations***, et ***autorise les modificateurs à se comporter différemment selon la signature de leur fonction***. Ce dernier point nous évite d'avoir plusieurs modificateurs qui font la même chose sur des nombres d'arguments différents. Par exemple, ***Factor a les mots `bi`, `2bi`, `3bi`, `tri`, `2tri` et `3tri`. Uiua exprime tout cela et davantage avec le seul `fork`.*** » ***SIX COMBINATEURS RÉDUITS À UN. C'est le premier chiffrage de ce que P-1 achète.***

#### ET CE QUE LA PREMIÈRE CLASSE COÛTE — *le même diagnostic que Lochbaum, par un autre chemin*

« Comme les fonctions pouvaient être mises dans des tableaux et déplacées sur la pile, \*/le compilateur ne pouvait pas déterminer la signature d'une fonction qui appelait une valeur fonctionnelle/\*. Cela signifiait que ***partout où `! call` était employé, il fallait une annotation de signature à proximité — qu'on espérait juste, sinon le code cassait ailleurs***. » ***DEUX CONCEPTEURS, INDÉPENDAMMENT, DISENT QUE C'EST LA PREMIÈRE CLASSE QUI DÉTRUIT LA RÉSOLUTION STATIQUE.*** /Lochbaum : « quand le `-` ambivalent est une valeur de première classe, une occurrence peut n'avoir même pas un seul sens ». Kai : « le compilateur ne pouvait pas déterminer la signature »./ **Et le coût de lecture est nommé** : « il fallait garder en tête non seulement les valeurs, mais ***les fonctions qui travaillaient dessus***. C'était une valeur de plus à gérer. »

#### ET LA RÉSOLUTION EST CELLE DE B6, ÉNONCÉE PAR QUELQU'UN QUI L'A APPLIQUÉE

> « \*/Les MACROS couvrent le principal cas d'usage des fonctions de première classe : injecter du code variable dans une fonction. Bien qu'elles soient techniquement plus limitées, leur STRUCTURE UNIFORME les rend plus faciles à lire ET à écrire./\* Ce changement a aussi ***massivement simplifié l'interprète***, ainsi que la complexité du langage lui-même. »

***LES MACROS REMPLACENT LES FONCTIONS DE PREMIÈRE CLASSE. C'est la thèse de B6 poussée plus loin que le document ne l'a jamais poussée, et elle est appliquée dans un langage vivant.*** **Avec le compromis énoncé sans détour** : *techniquement plus limitées, mais uniformes — donc plus lisibles ET plus simples à implanter.* **Et la réserve de l'auteur, qui vaut d'être notée** : « il faut noter que ***j'aime les langages fonctionnels***. Je ne pense simplement pas que les fonctions de première classe conviennent à Uiua. En pratique, elles sont ***surtout inutiles si l'on a des fonctions d'ORDRE SUPÉRIEUR***, ce que les langages de tableaux ont depuis des décennies. » *Ce n'est donc pas un rejet du fonctionnel : c'est une observation que l'ordre supérieur suffit.*

### GRIS-EtLeFormateurDUiuaAUneConfiguration

    AUTHORS | DATE | TITLE: ET LE FORMATEUR D'UIUA A UNE CONFIGURATION — question 48, et elle tient en cinq options | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeStatutQueLesAuteursRevendiquent

    AUTHORS | DATE | TITLE: LE STATUT QUE LES AUTEURS REVENDIQUENT — et il est plus modeste que ce qu'on leur prête | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] CE QUE LE CADRE EST, DIT PAR SES AUTEURS

> « Les dimensions ***ne sont pas des lignes directrices***, qui sont des poignées de préceptes sans rapport entre eux ; elles ne sont ni des descriptions de dispositifs ni des descriptions de la manière de s'en servir ; et elles ne sont ***absolument pas un modèle cognitif de l'utilisateur***, quoiqu'elles reposent sur une “proto-théorie” de sens commun de ce que font les utilisateurs. ***Ce sont des OUTILS DE DISCUSSION, des descriptions de la relation artefact-utilisateur, destinés à élever le niveau du discours.*** »

**Et l'aveu de méthode, qui vaut d'être cité en entier** :

> « Nous n'essayons pas même, dans cet article, d'énoncer un ensemble de critères d'évaluation que les conceptions devraient satisfaire \[…\]. \*/C'est le CONCEPTEUR qui doit décider de la spécification et du lieu où placer l'artefact dans l'espace de conception, et inventer une solution. C'est le concepteur, non le cognitiviste, qui doit peser les coûts et bénéfices cognitifs contre les exigences de coût, d'ingénierie logicielle, de formation du personnel, d'organisation./\* »

***C'EST EXACTEMENT LE PARTAGE QUE L'ARC A ADOPTÉ SANS LE SAVOIR — « ses explorations sont des GUIDES, NON DES ARBITRES ».*** **La règle d'Anthea et la doctrine de Green et Petre disent la même chose ; l'arc peut désormais l'écrire avec un précédent.** /Et la remarque de Blackwell que l'arc citait — « la théorie IMPLICITE DE LA CONCEPTION qu'elle incarne » — se vérifie mot pour mot dans la source : les auteurs déclarent eux-mêmes ne pas faire de psychologie prescriptive./

#### ET LE PRIX D'ENTRÉE EST CHIFFRÉ

« L'analyse à gros trait est utilisable par des non-spécialistes de l'IHM parce qu'elle ***évite la “mort par le détail”*** : elle offre quelques points saillants couvrant deux pages, plutôt que des pages d'analyse. Elle est extrêmement rapide et peu coûteuse : ***une après-midi de réflexion soignée sur un système est probablement tout ce qu'il faut***. » ***UNE APRÈS-MIDI. C'est le coût de l'instrument, et il place T-61 dans le domaine du faisable.***

### GRIS-LesCompromis

    AUTHORS | DATE | TITLE: LES COMPROMIS — le cœur du cadre, et l'arc n'en avait que le mot | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA THÈSE, ET SON ANALOGIE PHYSIQUE

> « ***La position d'un artefact dans l'“espace des dimensions cognitives” ne peut pas être ajustée arbitrairement.*** Changer sa structure pour réduire la viscosité, par exemple, affectera probablement d'autres dimensions. \*/Il y a un parallèle avec les grandeurs qui définissent les systèmes physiques : chauffer un corps pour changer sa température changera aussi son volume, à moins qu'il ne soit comprimé, auquel cas c'est la pression qui changera./\* »

**Et la conséquence est énoncée sans ménagement** : « \*/un succès notable sur une dimension peut être annulé par une mauvaise performance sur une autre. Comme toute forme d'ingénierie, la conception est affaire de compromis./\* »

#### LE REMÈDE STANDARD, ET SA FACTURE — *ceci vise directement K7PL*

« ***La viscosité peut être réduite en augmentant le nombre d'abstractions*** (c'est de cela que traite toute la programmation par objets). ***Augmenter les abstractions tend à créer des DÉPENDANCES CACHÉES*** (parce qu'il n'est pas clair où les abstractions sont instanciées, ni quelles seront les conséquences d'un changement \[…\]). » **Et la suite énumère quatre contreparties** :

|  |  |
|----|----|
| ***dépendances cachées*** | on ne voit plus où l'abstraction est instanciée |
| ***visibilité à distance*** | « la visibilité LOCALE peut être bonne, la visibilité DISTANTE mauvaise » |
| ***engagement prématuré imposé*** | « les abstractions doivent être définies avant qu'on puisse programmer quoi que ce soit, moment auquel il peut devenir clair qu'elles étaient mal conçues » |
| ***gratification différée*** | « il faut beaucoup tripoter avant de démarrer » |

\*/K7PL EST UN LANGAGE À MACROS DE BIBLIOTHÈQUE : c'est un langage qui répond à la viscosité par l'abstraction. La facture ci-dessus est donc la SIENNE, et la question 3 — combien de glyphes — est la forme locale de « gratification différée »./\* **Et le remède au remède est nommé, avec sa limite** : « une maladresse peut être corrigée en ajoutant des OUTILS à l'environnement, comme des explorateurs pour afficher les dépendances qui seraient autrement cachées. ***Ce n'est habituellement qu'un remède PARTIEL. Les distractions liées à l'invocation de l'explorateur cassent le motif de résolution de problème*** \[…\]. » /C'est la troisième fois que le dossier rencontre ce schéma — la surcharge de Lochbaum se paie en outillage, la découvrabilité de fonctionnalité se paie en outillage, l'abstraction se paie en outillage — et c'est la première fois qu'un auteur dit que l'outil ne solde pas la dette./

### GRIS-LchelleDesAbstractions

    AUTHORS | DATE | TITLE: L'ÉCHELLE DES ABSTRACTIONS — trois positions, et K7PL doit choisir la sienne | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaTersitAUneBorneEtElleEstDeCeCtCi

    AUTHORS | DATE | TITLE: LA TERSITÉ A UNE BORNE, ET ELLE EST DE CE CÔTÉ-CI — ceci corrige une lecture naïve de KISS | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LesJugementsQuiPortentSurDesTraitsDeK7Pl

    AUTHORS | DATE | TITLE: LES JUGEMENTS QUI PORTENT SUR DES TRAITS DE K7PL | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LES DÉLIMITEURS APPARIÉS SONT NOMMÉS COMME SOURCE D'ERREUR

« Une autre source puissante de ***lapsus*** est le système de ***DÉLIMITEURS APPARIÉS*** : les parenthèses en Lisp, `begin`-`end` en Pascal, et une grande variété de symboles appariés en C — ***dans tous les cas, il n'est pas rare que l'appariement aille de travers***. » *Le cadre distingue les LAPSUS — « faire quelque chose qu'on ne voulait pas, alors qu'on savait depuis le début quoi faire » — des MÉPRISES d'analyse. La parenthèse produit des lapsus.* **C'est une pièce à verser au dossier de la question 6 et à l'exploration Lisp** : /l'objection n'est pas esthétique et ne porte pas sur la lecture ; elle porte sur la production, et sa réponse est outillée (l'éditeur apparie) plutôt que notationnelle./

#### LES VARIABLES SONT DES DÉPENDANCES *PARTIELLEMENT* CACHÉES

« Les langages textuels impératifs conventionnels emploient des variables : \*/parce que leurs noms doivent être MÉMORISÉS et doivent être appariés SYMBOLIQUEMENT plutôt que PERCEPTUELLEMENT, on pourrait les classer comme partiellement cachées/\*. » ***UN NOM EST UN APPARIEMENT SYMBOLIQUE ; UNE LIGNE EST UN APPARIEMENT PERCEPTUEL.*** \*La distinction est la plus fine que le dossier ait rencontrée sur ce point, et elle donne à la sédimentation un angle neuf\* : /K7PL rend la propriété statique et vérifiable, donc l'erreur est prise ; mais la DÉPENDANCE reste symbolique, et le cadre dit que c'est un coût même quand elle est correcte./ **C'est une question pour l'outillage — question 18.**

#### LA NOTATION SECONDAIRE, ET LE PRIX QU'UN EXPERT ACCEPTE DE PAYER

« Beaucoup de langages permettent que de l'information supplémentaire soit portée par d'autres moyens que leur syntaxe formelle : ***indentation, commentaires, choix de conventions de nommage, choix de construction, et groupement d'énoncés apparentés***. Ces techniques n'ont aucune place dans la sémantique formelle de l'algorithme, mais ***elles toutes véhiculent du sens pour le lecteur humain***. » **Et l'observation qui chiffre l'enjeu — un informateur expert de LabVIEW** :

> « \*/Je passe assez souvent une heure ou deux à seulement déplacer des boîtes et des fils, sans aucun changement de fonctionnalité, pour que ce soit d'autant plus compréhensible quand j'y reviendrai./\* »

\*/QUESTION 48 — la mise en page est-elle un objet de conception ? Voici un expert qui y consacre une à deux heures par programme, et des auteurs qui appellent « déficience sérieuse » le fait que la notation ne l'aide pas./\* **Et le mécanisme est nommé** : les ***« paragraphes qui riment »*** — un fragment Basic où les traitements vertical et horizontal sont mis en page en parallèle, « ce qui permet au lecteur de vérifier que les différences sont exactement celles attendues ». /C'est du contrôle par SILHOUETTE : on compare deux blocs perceptuellement au lieu de les lire. Rasmussen appellerait cela du niveau savoir-faire./ **Et le remède proposé est un OBJET, non une convention** : un ***« niveau de DESCRIPTION »*** explicite — Hendry et Green l'ont ajouté à un tableur commercial, « délibérément minimal, pour éviter d'élever inutilement le niveau d'abstraction » : des étiquettes attachées à des groupes de cellules non nécessairement contiguës, un ombrage, des flèches entre régions. « Si simple que ce fût, cela permettait de représenter ***toutes les assertions faites dans un corpus de descriptions de tableurs par des utilisateurs professionnels***. » ***C'EST UNE PISTE DE CONCEPTION POUR K7PL, ET ELLE EST BON MARCHÉ.***

#### LA VISIBILITÉ, ET UNE JUSTIFICATION HISTORIQUE DE LA TERSITÉ

« À mesure que les longueurs de programme croissaient de plusieurs ordres de grandeur, il devint nécessaire de prendre des mesures drastiques. Parmi ces mesures figuraient ***le développement de notations plus TERSES avec des opérations de haut niveau (notamment APL !)*** et l'usage accru de procédures et de bibliothèques pour cacher le détail localisé. » ***LA TERSITÉ D'APL EST ICI EXPLIQUÉE COMME UNE RÉPONSE À UN PROBLÈME DE VISIBILITÉ, NON COMME UN GOÛT.*** **C'est le meilleur argument que T-58 ait reçu de l'extérieur du camp APL.** **Avec sa contrepartie immédiate** : « bien que l'usage de procédures améliore la visibilité À UN NIVEAU, il peut créer de vrais problèmes ENTRE les niveaux ».

#### LES OPÉRATIONS MENTALES DIFFICILES ONT UN TEST, ET IL EST OPÉRABLE

« Le test à gros trait pour les opérations mentales difficiles est donc : (i) ***si j'assemble deux ou trois de ces constructions, cela devient-il incompréhensible ?*** (ii) ***y a-t-il un moyen, dans un autre langage, de le rendre compréhensible ?*** Si la réponse est oui aux deux, cela compte. » \*/DEUX QUESTIONS, ET UNE RÉPONSE BINAIRE. C'est le seul critère opérationnel du cadre, et il est applicable tel quel au grade ⟨u, m, ℓ, β⟩ : composer deux ou trois grades devient-il incompréhensible ?/\* **À verser à l'instrument de T-61.**

### GRIS-TroisRetoursSurLeCadre

    AUTHORS | DATE | TITLE: TROIS RETOURS SUR LE CADRE — 2006 et 2018, par ses auteurs et par la mesure | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] GREEN, BLANDFORD, CHURCH, ROAST ET CLARKE 2006 — *le cadre jugé par son auteur, dix ans après*

:SOURCE: *Cognitive dimensions: Achievements, new directions, and open questions*, JVLC 17, 2006 — `cite:@greenCognitiveDimensionsAchievements2006`

1.  LE CRITÈRE D'INVARIANCE — *et il tranche la question 2 par un principe*

    **Les auteurs posent que le cadre doit être INVARIANT sous re-habillage.** /L'exemple est un lecteur MP3 « habillable » : « parce que le fonctionnement fondamental du dispositif n'est pas changé par le ré-habillage, ***nous voulons une méthode d'évaluation qui soit INVARIANTE sous les changements d'APPARENCE*** »./ **L'exigence exclut explicitement les méthodes qui comptent les frappes ou mesurent la précision du pointage.** ***CONSÉQUENCE DIRECTE POUR P-2 : un glyphe et son alias textuel sont le MÊME artefact au sens du cadre.*** /La paire `×` / `multiplie` ne change pas une seule dimension cognitive : ni la viscosité, ni les dépendances cachées, ni l'engagement prématuré. Elle change la LÉGIBILITÉ au sens du corpus CLT — l'identification des éléments — et la diffusion./ **La question 2 — table ou règle systématique — n'est donc PAS une question de dimensions cognitives.** /Le cadre ne peut pas la trancher, et il le dit. Elle relève de la mnémonique et de l'apprentissage, c'est-à-dire des dimensions « fondées sur la connaissance » que le cadre d'origine a délibérément REJETÉES et que cet article de 2006 propose de réintégrer./

2.  L'AVEU SUR LA COMPLÉTUDE — *et il vaut pour tout inventaire, y compris les 48 questions*

    « L'informalité de définition a conduit à des interprétations alternatives des dimensions. \[…\] De plus, \*/l'informalité rend impossible de savoir jusqu'à quel point la liste est exhaustive. Ajouter simplement une dimension nouvelle quand on la trouve nécessaire, comme cela a été régulièrement fait, ne garantit nullement qu'il existe assez de dimensions pour couvrir les cas importants/\*. » ***L'ARC A EXACTEMENT CE PROBLÈME AVEC SES 48 QUESTIONS : elles se sont ajoutées au fil des lectures, et rien ne dit qu'elles couvrent.*** \*Le §« Un résultat qui porte sur la liste elle-même » avait posé le problème ; voici un précédent qui dit qu'il ne se résout pas par accumulation.\*

3.  ET LE CADRE N'A CONSIDÉRÉ QU'UNE SEULE ACTIVITÉ

    « Dans la version originale du cadre, ***une seule activité était considérée : la CONCEPTION EXPLORATOIRE***. » /Green et Petre l'écrivent d'ailleurs eux-mêmes en 1996 : « nous tendrons à limiter notre discussion à des situations comme la programmation exploratoire ou incrémentale. Nous ne prêterons aucune attention à d'autres critères de conception, tels que ***la conception critique pour la sûreté*** ou le codage pour l'efficacité »./ ***K7PL VISE UNE PROPRIÉTÉ VÉRIFIÉE STATIQUEMENT — c'est-à-dire, en partie, le régime que le cadre a explicitement mis hors de son champ.*** **L'emprunt reste légitime, mais il faut le dire.**

4.  ET LE MODÈLE DE L'OPÉRATION MENTALE DIFFICILE — *énoncé, et déclaré non testé*

    « Tous les exemples ont ces deux traits : (1) l'opération est facile à faire une fois, correcte deux fois, mais ***explosivement difficile au-delà de deux***, et (2) quand la personne doit l'exécuter plus d'une fois, ***l'entrée de la N-ième instance est la sortie de la (N−1)-ième***. » *Avec la probité qui caractérise ces auteurs : « il n'est pas difficile de proposer un modèle de traitement cognitif informel (qui est, bien sûr, ***complètement non testé***) ».*

#### DAGIT, LAWRANCE, NEUMANN, BURNETT, ET AL. 2006 — *et l'avertissement nous est adressé*

:SOURCE: *Using cognitive dimensions: Advice from the trenches*, JVLC 17, 2006 — `cite:@dagitUsingCognitiveDimensions2006`

> « Les chercheurs employant les dimensions cognitives peuvent démontrer que des défauts existent \[…\]. Cependant, \*/ils ne peuvent pas affirmer qu'aucun défaut n'existe quand ils n'en ont découvert aucun, car l'absence de preuve n'est pas preuve d'absence. Ainsi, les chercheurs qui ne découvrent aucun défaut dans leur recherche au moyen des dimensions cognitives ont essentiellement perdu leur temps : LES DIMENSIONS COGNITIVES NE SONT PAS UTILES COMME OUTIL D'ACCEPTATION./\* »

***C'EST UNE RÈGLE DE CONDUITE POUR T-61, ET ELLE EST STRICTE : l'arc peut employer les dimensions pour TROUVER des problèmes dans K7PL ; il ne peut pas les employer pour DÉCLARER K7PL utilisable.*** **Et le second avertissement porte sur la manière** : « des discussions détaillées d'**une seule** dimension \[…\] ou des discussions brèves de **chacune** peuvent ne pas rendre compte des compromis, parce que la discussion est ***trop étroitement ciblée ou trop superficielle pour montrer comment les dimensions INTERAGISSENT***. » *L'instrument de T-61 doit donc porter sur des PAIRES, non sur une liste.*

#### CHURCH, BLACKWELL ET HADHRAWI — *1 638 publications mesurées, et le résultat est un échec*

:SOURCE: *A Systematic Literature Review of Cognitive Dimensions*, PPIG — `cite:@hadhrawiSystematicLiteratureReview`

**La revue code toutes les citations des neuf articles-racines du cadre.**

|                                             |             |
|---------------------------------------------|-------------|
| publications analysées                      | ***1 638*** |
| citées pour une évaluation SOMMATIVE        | 211         |
| citées comme outil de DISCUSSION            | 585         |
| dont centrées sur ***UNE SEULE dimension*** | ***208***   |
| ne discutant ni n'évaluant rien             | 521         |
| dont simples citations « de complétude »    | 260         |

**Et la conclusion des auteurs** :

> « Le cadre est très largement cité, et considéré comme influent, \*/pourtant une grande partie de la littérature y puise d'une manière DIFFÉRENTE des intentions originelles de ses concepteurs/\*. \[…\] la discussion s'est concentrée sur une dimension unique, ce qui signifie que \*/le rôle du cadre a été d'ALERTER les concepteurs de langage sur une propriété particulière jusque-là mal comprise, plutôt que d'introduire une sophistication nouvelle dans le processus de conception/\*. »

***LE CADRE LE PLUS CITÉ DU DOMAINE A ÉCHOUÉ À FAIRE CE POUR QUOI IL A ÉTÉ FAIT. C'est le résultat le plus utile de tout ce lot, et il est de nature MÉTHODOLOGIQUE.*** **Il porte une leçon pour K7PL** : /un vocabulaire de conception, si bon soit-il, se fait consommer à l'unité. Ce qui a circulé, ce sont les MOTS — « viscosité » compte 3 116 occurrences dans 558 articles — et non la MÉTHODE. Si T-61 produit une grille, elle sera lue de la même façon./ **La conclusion n'est pas de renoncer, mais de concevoir l'instrument pour qu'il fonctionne DÉGRADÉ : chaque item doit valoir seul.** **Et deux mesures accessoires qui rangent le dossier** : /19 publications citent Green pour le ***superlativisme***, 16 pour la thèse ***adéquation-inadéquation***. Ce sont les deux résultats de l'équipe qui ont le mieux voyagé, et ce sont précisément les deux que l'arc avait retenus par Blackwell. La transmission de seconde main a donc reproduit le biais mesuré ici./

#### PETRE 2006 — *ce que les dimensions ne couvrent pas*

:SOURCE: *Cognitive dimensions « beyond the notation »*, JVLC 17, 2006 — `cite:@petreCognitiveDimensionsNotation2006`

« L'idéal, pour les dimensions cognitives, était de rendre évidents les attributs liés à la cognition des notations, d'une manière qui rapporte ces attributs ***concrètement et clairement à la façon dont les utilisateurs de notations les emploient et les éprouvent***. Nous visions une théorie qui pût ***révéler les attributs cachés du concret***. » /Et le titre dit le reste : l'article porte sur les questions « au-delà de la notation » que les études empiriques de développeurs professionnels ont fait remonter et que le cadre n'a pas absorbées./ **Le point à retenir pour l'arc est le procédé** : /le cadre est né d'un aller-retour permanent entre une connaissance des types de notations et des EXEMPLES tirés d'études empiriques — « pour nous comprendre l'un l'autre, et surtout quand nous ne nous comprenions pas, nous nous référions continuellement à des exemples »./ **C'est le protocole d'ergonomie, décrit dix-sept ans avant.**

## T-58, SUITE — *SOIXANTE-DEUX ANS D'APL EN TROIS ARTICLES, et la question 2 y est posée par ses concepteurs*

\*/Les trois pièces se lisent ensemble : Iverson dit ce qu'une notation doit avoir ; Falkoff et Iverson disent comment celle-là s'est faite ; Hui et Kromberg disent ce qu'elle est devenue et ce qu'ils ne savent toujours pas trancher./\*

### GRIS-Iverson1979

    AUTHORS | DATE | TITLE: IVERSON 1979 — « LA NOTATION COMME OUTIL DE PENSÉE », conférence Turing | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LES CINQ CARACTÈRES D'UNE BONNE NOTATION — *et il en manquait quatre au dossier*

« Outre l'exécutabilité et l'universalité soulignées dans l'introduction, une bonne notation devrait incarner des caractères familiers à tout usager de la notation mathématique. »

|  |  |  |
|----|----|----|
| 1 | ***facilité d'expression*** | des notions du problème, mais aussi « de celles qui surgissent dans l'analyse, la généralisation et la spécialisation SUBSÉQUENTES » |
| 2 | ***SUGGESTIVITÉ*** | « une notation sera dite suggestive si ***les formes des expressions surgissant dans un ensemble de problèmes SUGGÈRENT des expressions apparentées qui trouvent application dans d'autres problèmes*** » |
| 3 | ***subordination du détail*** | par les tableaux, par l'assignation de noms, par les opérateurs |
| 4 | ***ÉCONOMIE*** | voir ci-dessous — c'est le point qui nous concerne |
| 5 | ***aptitude aux preuves formelles*** |  |

***LA SUGGESTIVITÉ EST LE CARACTÈRE QUE LE DOSSIER N'AVAIT PAS NOMMÉ, ET C'EST CELUI QUI RÉPOND À LA DÉCOUVRABILITÉ.*** /Questions 43 à 46 : « dans quelle mesure pouvons-nous permettre à un codeur de découvrir le langage pendant qu'il écrit ? » Iverson répond par une propriété de la NOTATION — que la forme d'une expression connue suggère une expression inconnue — et non par un outil./ **C'est la première réponse NOTATIONNELLE à la découvrabilité de fonctionnalité que le dossier rencontre.** *Toutes les autres — infobulles d'Uiua, interface écologique de T-60, explorateur de Green et Petre — sont outillées.*

#### L'ÉCONOMIE, ÉNONCÉE COMME UN COMPROMIS À DEUX TERMES — *et c'est la règle KISS, en 1979*

> « \*/L'utilité d'un langage comme outil de pensée CROÎT avec l'étendue des sujets qu'il peut traiter, mais DÉCROÎT avec la quantité de VOCABULAIRE et la complexité des RÈGLES GRAMMATICALES que l'usager doit garder en tête./\* L'économie de notation est donc importante. »

***TROIS TERMES, PAS DEUX : la couverture, le vocabulaire, ET la grammaire.*** **La règle « less is more » de l'arc n'en distingue pas les deux derniers.** /Or ils se compensent : Uiua a beaucoup de glyphes et une grammaire triviale ; Lisp a peu de formes spéciales et une grammaire d'une ligne ; C a peu de mots-clés et une grammaire monstrueuse. Compter les glyphes sans compter les règles ne mesure rien./ **Et le moyen que recommande Iverson est celui de K7PL** : « un schéma fondamental pour y parvenir est l'introduction de ***RÈGLES GRAMMATICALES par lesquelles des phrases et des énoncés signifiants peuvent être construits en COMBINANT les éléments du vocabulaire*** ». /Son exemple : la somme des N premiers entiers n'est pas une primitive, c'est une phrase — `+/⍳N` — construite de deux notions plus générales. Et la fonction dérivée `+/` est elle-même une phrase./ ***C'EST L'ARGUMENT DE B6 : ne pas primitiver ce qui se compose.***

#### LA DISTINCTION QUI TRANCHE LA QUESTION 3 — *économie de SYMBOLES ≠ économie de FONCTIONS*

> « Une économie significative ***de SYMBOLES, PAR OPPOSITION À l'économie de FONCTIONS***, est obtenue en permettant à tout symbole de représenter à la fois une fonction monadique et une fonction dyadique, de la même manière que le signe moins est communément employé à la fois pour la soustraction et la négation. »

***DEUX GRANDEURS DISTINCTES, ET LA QUESTION 3 — « COMBIEN DE GLYPHES ? » — LES CONFOND.*** **Il faut la scinder** : /combien de FONCTIONS le langage offre-t-il (coût de vocabulaire, au sens de la formule ci-dessus), et combien de SIGNES les portent (coût de reconnaissance, au sens de la légibilité du corpus CLT) ? Ce ne sont pas les mêmes coûts, ils ne se paient pas au même moment, et une décision peut baisser l'un en montant l'autre./ **ET LA JUSTIFICATION D'IVERSON EST CONDITIONNELLE, ce qu'on oublie en le citant** : « ***Parce que les deux fonctions représentées peuvent, comme dans le cas du signe moins, être APPARENTÉES, le fardeau de se souvenir des symboles est allégé.*** » ***LA SURCHARGE N'EST JUSTIFIÉE QUE QUAND LES DEUX SENS SONT APPARENTÉS. C'est écrit dans le texte fondateur.*** \*Et le dossier possède l'instrument qui mesure « apparenté » : le barème en cinq degrés de Lochbaum — unifié, compatible, similaire, mnémonique, MAUVAIS — qui range treize glyphes de BQN au dernier degré.\* /Iverson pose la condition ; Lochbaum, quarante ans plus tard, constate qu'elle n'est pas tenue. Les deux ne se contredisent pas : le second applique le critère du premier./

#### LES DEUX SIMPLIFICATIONS GRAMMATICALES, ET LEUR PRIX

« (1) ***Toutes les fonctions sont traitées de la même façon, et il n'y a pas de règles de PRÉCÉDENCE*** telles que `×` exécuté avant `+`. (2) La règle selon laquelle ***l'argument droit d'une fonction est la valeur de l'expression ENTIÈRE à sa droite*** \[…\] est étendue aux fonctions dyadiques. » **Et la conséquence de lecture est énoncée avec une précision que le dossier n'avait pas atteinte** :

> « Une conséquence importante de cette règle est que toute portion d'une expression libre de parenthèses peut être lue ***ANALYTIQUEMENT de gauche à droite*** (puisque la fonction de tête à chaque étape est la fonction “extérieure” ou globale à appliquer au résultat à sa droite), et ***CONSTRUCTIVEMENT de droite à gauche*** (puisque la règle équivaut aisément à celle selon laquelle l'exécution se fait de droite à gauche). »

***DEUX SENS DE LECTURE, DEUX USAGES : de gauche à droite pour COMPRENDRE CE QUE FAIT l'expression, de droite à gauche pour SUIVRE CE QU'ELLE CALCULE.*** **C'est exactement la distinction lisibilité / légibilité du corpus CLT, appliquée à un ordre de lecture.** /Et l'hypothèse d'Iverson sur l'origine de la précédence mathématique vaut d'être versée : « il semble raisonnable de supposer que la motivation de la hiérarchie familière (puissance avant ×, et × avant + ou −) est née du désir de rendre les POLYNÔMES exprimables sans parenthèses »./ \*/LA PRÉCÉDENCE SERAIT UNE OPTIMISATION POUR UNE SEULE FAMILLE D'EXPRESSIONS. C'est une hypothèse, présentée comme telle, et elle est instructive pour K7PL : toute règle de précédence qu'on ajouterait devrait nommer la famille qu'elle sert./\* **Et l'uniformité de placement est revendiquée contre les mathématiques** : « une forme unique pour toutes les fonctions dyadiques, qui apparaissent ENTRE leurs arguments, et pour toutes les monadiques, qui apparaissent AVANT leurs arguments. Cela contraste avec la variété des règles en mathématiques : les symboles des fonctions monadiques de négation, factorielle et magnitude ***PRÉCÈDENT, SUIVENT et ENTOURENT*** leurs arguments respectivement. »

### GRIS-FalkoffEtIverson1978

    AUTHORS | DATE | TITLE: FALKOFF ET IVERSON 1978 — L'ÉVOLUTION D'APL, et la surcharge de valence y est datée et motivée | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA DÉCOMPOSITION DE KISS EN QUATRE — *et l'arc n'en avait qu'un mot*

> « ***Les principes opératoires effectifs guidant la conception de tout système complexe doivent être PEU NOMBREUX et LARGES.*** Dans le cas présent nous croyons que ces principes sont la ***SIMPLICITÉ*** et la ***PRATICABILITÉ***. La simplicité entre sous quatre espèces : ***UNIFORMITÉ*** (les règles sont peu nombreuses et simples), ***GÉNÉRALITÉ*** (un petit nombre de fonctions générales fournissent comme cas particuliers une foule de fonctions plus spécialisées), ***FAMILIARITÉ*** (symboles et usages familiers sont adoptés chaque fois que possible), et ***BRIÈVETÉ*** (l'économie d'expression est recherchée). »

***QUATRE ESPÈCES, ET ELLES PEUVENT SE CONTREDIRE.*** **C'est le raffinement dont la règle KISS de l'arc avait besoin.** /La généralité et la familiarité s'opposent — une fonction générale porte rarement un nom familier. La brièveté et l'uniformité s'opposent — la forme la plus brève d'un cas particulier n'est pas la forme uniforme. Dire « KISS » sans dire LAQUELLE des quatre, c'est laisser l'arbitrage implicite./ **ET LA PRATICABILITÉ A DEUX FACES** : « le souci de l'APPLICATION effective du langage, et le souci des ***LIMITATIONS PRATIQUES IMPOSÉES PAR L'ÉQUIPEMENT EXISTANT*** ». *La seconde est ce qui suit.*

#### LA SURCHARGE DE VALENCE EST UNE CONSÉQUENCE DE MATÉRIEL, ET LES CONCEPTEURS L'ÉCRIVENT

> « \*/La LIMITATION DU JEU DE CARACTÈRES a conduit à une exploitation plus systématique de la notion de VALENCE AMBIGUË, la représentation d'une fonction à la fois monadique et dyadique par le même symbole./\* »

***LA PRATIQUE QUE P-1 REFUSE EST DATÉE, ET SA CAUSE EST UN ÉLÉMENT D'IMPRESSION SELECTRIC À 88 CARACTÈRES.*** **Lochbaum l'avait diagnostiqué de l'extérieur — « c'est une contrainte de CLAVIER » ; les concepteurs le confirment de l'intérieur, dans l'article d'histoire officiel.** *Le dossier peut donc écrire, sans polémique : l'arité fixe ne rejette pas un principe de conception d'APL, elle se dispense d'une contrainte matérielle de 1964 que K7PL n'a pas.* **ET LE MÊME MÉCANISME A PRODUIT QUATRE AUTRES DÉCISIONS, dont trois ont bien vieilli** :

|  |  |
|----|----|
| 1 | la linéarisation — plus d'indices ni d'exposants |
| 2 | la substitution de `⍳N` à des fonctions à deux ou trois arguments |
| 3 | la valence ambiguë |
| 4 | un seul `⍴` pour le vecteur de dimensions, au lieu de deux fonctions |
| 5 | les ***CARACTÈRES COMPOSITES*** obtenus en surfrappant deux caractères de base |

**Et le jugement rétrospectif des auteurs sur la contrainte est le point le plus intéressant** : « Bien que nous nous attendions à ce que ces limitations aient un effet délétère, et qu'au début nous ayons trouvé déplaisante une part de la linéarité qui nous était imposée, \*/nous estimons aujourd'hui que ces changements ont été BÉNÉFIQUES, et que beaucoup ont conduit à des GÉNÉRALISATIONS importantes/\*. » ***UNE CONTRAINTE SUBIE A PRODUIT DES GÉNÉRALISATIONS. C'est le meilleur argument que la règle KISS ait reçu, et il vient de gens qui l'ont éprouvée contre leur gré.***

#### ET LES DÉCLARATIONS ONT ÉTÉ REFUSÉES, POUR UNE RAISON QUI VISE K7PL

« L'introduction de ***DÉCLARATIONS*** dans le langage nous fut pressée comme un préalable à l'implantation. Nous y avons résisté sur la base générale de la simplicité, mais aussi \*/sur la base que l'information contenue dans les déclarations serait REDONDANTE, ou peut-être CONFLICTUELLE, dans un langage où les tableaux sont primitifs/\*. » *L'argument n'est pas « les déclarations sont lourdes » mais « elles répètent ce que la structure dit déjà ».* **C'est un critère transposable** : /K7PL doit se demander, pour chaque annotation de grade, si elle AJOUTE une information ou si elle REDIT ce que le terme porte. Une annotation redondante est une occasion de conflit./

#### ET DEUX FAITS DE PROCÉDÉ, QUI ÉCLAIRENT LA CONDUITE D'UN ARC

- « À chaque étape la conception du langage fut contrôlée par ***un petit groupe d'au plus cinq personnes***. »
- « Les décisions de conception furent prises par ***CONSENSUS À LA MANIÈRE QUAKER*** ; les innovations controversées étaient ***DIFFÉRÉES*** jusqu'à ce qu'elles pussent être révisées ou réévaluées de manière à obtenir un accord unanime. » /Exemple donné : « de nombreuses notations différentes pour les fonctions circulaires et hyperboliques furent envisagées pendant PLUS D'UN AN »./
- Et la contrainte qui vient avec le succès : « \*/un soin plus grand est requis pour introduire de nouvelles facilités, afin d'éviter la possibilité d'une RÉTRACTATION ultérieure qui incommoderait des milliers d'usagers/\*. »

***DIFFÉRER PLUTÔT QUE TRANCHER, TANT QUE L'ACCORD N'EST PAS FAIT. C'est la règle que l'arc suit déjà en laissant 48 questions ouvertes ; elle a un précédent.***

### GRIS-HuiEtKromberg2020

    AUTHORS | DATE | TITLE: HUI ET KROMBERG 2020 — APL DEPUIS 1978, et la question 2 y est POSÉE PAR EUX | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] « FAUT-IL EN FAIRE UNE PRIMITIVE ? » — *la réponse est qu'il n'y a pas de réponse*

> « APL a un grand nombre de fonctions primitives, chacune dénotée par un symbole. Comment décide- t-on si une fonction doit être primitive ? ***IL N'EXISTE PAS DE PROCÉDURE DE DÉCISION qui réponde à cette question, indication que la conception de langage est plus un ART qu'une SCIENCE.*** »

***LA QUESTION 3 N'A PAS DE RÉPONSE MÉTHODIQUE, ET CE SONT LES MIEUX PLACÉS POUR RÉPONDRE QUI LE DISENT.*** **Il faut en tirer la conséquence pour l'arc** : /la question 3 ne se clôt pas par un critère ; elle se clôt par une DÉCISION MOTIVÉE, cas par cas, dont on garde la trace. C'est exactement le régime des décisions bibliographiques du projet, appliqué à la conception./ **Et les auteurs s'appliquent à eux-mêmes le regret correspondant** : à propos de la primitive `j.` de J, « Iverson a conçu la primitive et elle fut implantée sans autre discussion. ***Nous aurions dû le lui demander.*** »

#### HUIT FACTEURS QUI RÉDUISENT LA PRESSION À CRÉER UN SYMBOLE — *section « Vailing and Countervailing Pressures », et c'est une grille complète*

|  |  |  |
|----|----|----|
| 0 | ***ambivalence*** | un symbole porte une définition monadique et une dyadique |
| 1 | ***surcharge*** | un seul `+` pour entiers, flottants, complexes, rationnels, tableaux creux |
| 2 | ***encodage par un argument*** | `1○⍵` sinus, `2○⍵` cosinus, `3○⍵` tangente… |
| 3 | ***OPÉRATEURS*** | « pas besoin d'introduire Σ ni Π \[…\] : les calculs dérivent comme `+⌿` et `×⌿` » |
| 4 | ***noms préfixés*** | les `⎕`-noms — `⎕io`, `⎕fread` — pour tout ce qui n'est pas le noyau |
| 5 | ***fonctions utilisateur de première classe*** | « il n'est plus nécessaire de rendre une fonction primitive, et d'employer un symbole pour la dénoter, POUR QU'UN OPÉRATEUR S'Y APPLIQUE » |
| 6 | ***pouvoir d'encodage des opérateurs*** | un opérateur monadique porte quatre familles de fonctions, un dyadique huit |

**Et le chiffrage, qui est l'argument quantitatif que la question 3 attendait** : /avec `n` symboles — si tous dénotent des fonctions, `2×n` fonctions possibles ; si la moitié dénotent des fonctions et la moitié des opérateurs MONADIQUES, `n + n²/2` ; si la moitié sont des opérateurs DYADIQUES, `n + n³/4`./ ***UN OPÉRATEUR VAUT UN ORDRE DE GRANDEUR DE PLUS QU'UNE PRIMITIVE, PAR SYMBOLE DÉPENSÉ. C'est la justification chiffrée de B6 et du choix des combinateurs contre les primitives.*** **ET LA CONTRE-PRESSION EST NOMMÉE, ET ELLE EST DÉFINITIVE** : « il faut se demander s'il n'y aurait pas un meilleur usage du nouveau symbole, car ***une fois introduit, l'usage est POUR TOUJOURS et ne peut pas être changé***. » **Avec un garde-fou de 1973 contre l'encodage, cité par les auteurs** : « le schéma notationnel employé pour les fonctions circulaires doit clairement être ***employé avec DISCRÉTION*** ; il pourrait servir à remplacer TOUTES les fonctions monadiques par une seule fonction dyadique avec un argument gauche entier encodant chacune. » *Et Dyalog l'a effectivement évité pour l'opérateur `⌺` : un nouveau symbole a été préféré à un cas d'un opérateur existant.*

#### L'HEURISTIQUE DE k — *une contrainte sévère produit un critère d'admission*

« k a pris une autre voie, écartant à la fois les caractères spéciaux et les symboles multicaractères, et emploie ***des caractères ASCII 7 bits simples***. Toutes les primitives furent considérées d'un œil critique ; ***seules les fonctions les plus cruciales furent jugées dignes d'être primitives***. \*/La contrainte sévère imposée par les symboles ASCII simples conduit à une HEURISTIQUE UTILE DE CONCEPTION DE LANGAGE : si une fonction est primitive en k, consommant la ressource la plus précieuse de Whitney, elle mérite une étude et une considération attentives./\* » ***UN CRITÈRE D'ADMISSION EXTERNE, VÉRIFIABLE, ET GRATUIT : « est-ce une primitive de k ? »*** **À verser à la question 3, à côté des trois grilles déjà réunies — la fréquence de LFE, la non-perturbation de TXR, les sept critères d'Uiua, et le barème en cinq degrés de Lochbaum.**

#### ET LA SECTION « NAMES » EST LA QUESTION 2, POSÉE PAR LES CONCEPTEURS D'APL EUX-MÊMES

**Ils rendent l'expression des racines du trinôme dans les deux notations** :

> `(2×a) ÷⍨ (-b) (+,-) √ (b*2) - 4×a×c` `(2 times a) divide commute (minus b) (plus append minus) sqrt (b power 2) minus 4 times a times c`

« On imagine que le second rendu serait ***encore moins attrayant*** si chaque nom était précédé d'un `⎕`. ***Un concepteur que la laideur ne décourage pas doit néanmoins prendre des décisions avec sensibilité envers la conception d'APL.*** » ***QUATRE DÉCISIONS SONT ÉNUMÉRÉES, ET ELLES SONT LES QUESTIONS 2 ET 24 MOT POUR MOT.***

|  |  |
|----|----|
| 1 | ***l'ambivalence*** — « `,` est à la fois ravel et append, `⌊` à la fois floor et min. ***Emploie-t-on des noms DIFFÉRENTS pour les fonctions monadique et dyadique, et abandonne-t-on l'idée de fonctions ambivalentes ?*** Ou peut-être certaines fonctions nommées sont-elles ambivalentes et d'autres non ? » |
| 2 | ***CE QU'ON NOMME EXACTEMENT*** — voir ci-dessous, et c'est une objection neuve à P-2 |
| 3 | ***la langue*** — « les noms sont communément dans une langue naturelle. ***Choisir des noms non anglais convenables serait une tâche non triviale.*** » *Avec l'aparté : l'usage de `⍺ ⍵ ∊ ⍳ ⍴` « prive les hellénophones de s'en servir comme noms ».* |
| 4 | ***la distinction*** — « comment les primitives sont-elles distinguées des noms d'usager ? Ou bien ignore-t-on simplement le problème, ou soutient-on que c'est un AVANTAGE qu'elles soient indiscernables ? » |

***LA PREMIÈRE DÉCISION EST P-1, ET ILS LA POSENT COMME LA CONSÉQUENCE DIRECTE DU NOMMAGE.*** **Nommer force à trancher l'arité.** /K7PL a tranché — arité fixe — et prend donc, sans l'avoir su, la branche que Hui et Kromberg décrivent comme celle qu'un langage nommé doit prendre. P-1 et P-2 ne sont pas deux positions indépendantes : la seconde ENTRAÎNE la première./ **ET LA DEUXIÈME DÉCISION EST UNE OBJECTION QUE L'ARC N'AVAIT PAS** :

> « ***Ce qu'on nomme exactement fait une différence.*** Par exemple, APL a l'opérateur de réduction, dénoté `⌿`, de sorte que `+⌿` est la somme, `×⌿` le produit, `⌈⌿` le maximum. \*/Si l'on fournit somme, produit, maximum mais PAS réduction, l'idée essentielle des opérateurs est abandonnée ; si l'on nomme À LA FOIS l'opérateur et les fonctions dérivées, on réduit la conscience que somme, produit et maximum sont des fonctions d'une MÊME FAMILLE./\* »

***P-2 DONNE UN ALIAS TEXTUEL À CHAQUE GLYPHE. VOICI UN CAS OÙ NOMMER LES DEUX NIVEAUX COÛTE.*** **La règle qui s'en déduit est nette et opérable** : /aliaser l'OPÉRATEUR, pas les fonctions dérivées. Un alias par glyphe primitif ; aucun alias pour une combinaison. Sans quoi le formateur se met à écrire `somme` là où le lecteur devrait voir `réduit(plus)`, et la famille disparaît./ **C'est une contrainte de conception pour P-2, et elle a un précédent chiffré : `n + n²/2` contre `2n`. Ce qu'on perd en nommant les dérivées, c'est le facteur d'économie tout entier.**

#### ET LA VOIE MOYENNE EXISTE — *J, et son schéma d'orthographe*

« Le schéma d'orthographe de J ***n'offre pas l'occasion — ni n'impose le fardeau — de concevoir un glyphe convenable pour un symbole, mais il est néanmoins SYMBOLIQUE et MNÉMONIQUE***. » /Un caractère ASCII suivi d'un point ou d'un deux-points : `+` conjugué/plus, `+.` réel-imaginaire/PGCD, `+:` double/non-ou./ ***UNE TROISIÈME POSITION ENTRE LE GLYPHE ET LE MOT : LE DIGRAMME RÉGLÉ.*** **Et elle a exactement la propriété que la question 2 cherche** : *c'est une RÈGLE systématique, non une table — le suffixe dit la famille — et elle se tape sans clavier spécial.* **À verser à la question 2 comme troisième branche.** **Et la réponse effectivement adoptée par APL pour la distinction primitives / noms d'usager** : le préfixe `⎕`. *« Les `⎕`-noms créent un ensemble de mots réservés, et le préfixe `⎕` les rend aisément distinguables des noms d'usager (auxquels le caractère `⎕` est interdit). »* \*C'est un précédent direct pour la forme `:propriété valeur` d'Anthea : un caractère de tête réserve un espace de noms, et c'est tout le mécanisme.\*

## CE QUE COÛTE UNE PROPRIÉTÉ VÉRIFIÉE STATIQUEMENT — *deux études ICSE 2022, et c'est la sédimentation qui est mesurée*

***K7PL PROPOSE LA PROPRIÉTÉ SANS RAMASSE-MIETTES. VOICI DEUX MESURES DE CE QUE CELA COÛTE À CELUI QUI ÉCRIT, PRISES SUR LE SEUL LANGAGE DE PRODUCTION QUI L'AIT FAIT.*** /Les deux ont paru à la même conférence, la même année, avec des méthodes opposées — un essai contrôlé randomisé, et une inspection manuelle de questions publiques. Elles ne se contredisent pas./

### GRIS-CoblenzMazurekEtHicks

    AUTHORS | DATE | TITLE: COBLENZ, MAZUREK ET HICKS — 428 sujets, tirage au sort, et un chiffre qui tranche | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE DISPOSITIF, ET IL EST HONNÊTE

/Un cours de 633 personnes ; 333 tirées au sort entre deux conditions ; 428 ont fourni des données. La condition « Bronze » dispose d'un ramasse-miettes de bibliothèque ; la condition « traditionnelle » non./ **Et le point qui rend l'étude décisive** : *les sujets « Bronze » ont REFAIT la tâche SANS ramasse-miettes après l'avoir faite avec.*

#### LE RÉSULTAT — *un tiers du temps, et il est gratuit*

> « Nous avons trouvé que, pour une tâche exigeant de gérer un ***aliasing complexe***, les usagers de Bronze étaient plus susceptibles d'achever la tâche dans le temps imparti, et que ceux qui y parvenaient ***n'avaient besoin que d'environ un TIERS du temps (4 heures contre 12)***. ***Nous n'avons trouvé AUCUNE différence significative de temps TOTAL***, quoique les usagers de Bronze aient refait la tâche sans Bronze ensuite. »

|  |  |  |
|----|----|----|
| tâche d'aliasing, médiane | ***4 h*** contre ***12 h*** | `W = 561, p < .001` |
| tâche de propriété (`Ownership`) | pas de différence | `W = 2449.5, p ≈ 1` |
| temps TOTAL | pas de différence | `W = 2354.5, p ≈ 1` |

***TROIS FOIS LE TEMPS SUR LA TÂCHE D'ALIASING, ET ZÉRO SUR LE TOTAL. La difficulté n'est pas dans la PROPRIÉTÉ ; elle est dans l'ALIASING.*** **C'est la mesure la plus directement utile que le dossier ait rencontrée, et elle porte sur le trait central de K7PL.** /La sédimentation partage l'ambition de Rust — la propriété sans ramasse-miettes — et hérite donc de la question : que se passe-t-il quand plusieurs chemins doivent désigner la même valeur ?/

#### ET LA CAUSE EST NOMMÉE, ET CE N'EST PAS LA MÉMOIRE

> « ***L'essentiel du bénéfice du ramasse-miettes vient de la SIMPLIFICATION ARCHITECTURALE.*** Les participants ont rapporté que les exigences architecturales de `Aliasing_noGC` étaient extrêmement exigeantes \[…\]. Nous concluons qu'une part significative du bénéfice du ramasse-miettes dans les programmes Rust tient aux ***simplifications d'architecture qu'il permet et encourage***. »

***LE COÛT N'EST PAS DE GÉRER LA MÉMOIRE. LE COÛT EST DE CONCEVOIR AUTREMENT.*** **Et c'est une borne pour la sédimentation** : /si elle contraint la FORME des structures — et non seulement leur durée de vie — elle paiera le même prix. La question à poser à K7PL n'est pas « la sédimentation est-elle facile à comprendre ? » mais « quelles architectures interdit-elle ? »./ **Chiffre à l'appui** : /sur 1 143 commentaires de difficulté, 100 portent sur la mutabilité intérieure et 83 sur l'emprunt dynamique — « presque autant à eux deux que les 199 qui se plaignaient de la propriété ou de l'emprunt »./

#### ET L'ÉCHAPPATOIRE N'EMPÊCHE PAS D'APPRENDRE — *c'est le résultat inattendu*

« En concevant l'expérience, nous craignions que l'usage du ramasse-miettes ne permît aux participants ***d'éviter d'apprendre*** la propriété, l'emprunt et les durées de vie. \[…\] Cependant, en raison de la manière fondamentale dont la propriété est employée en Rust, ***une grande partie du code exigeait de comprendre la propriété et l'emprunt MÊME AVEC le ramasse-miettes***. \[…\] les participants ont rapporté avoir appris des quantités ***similaires*** sur ces sujets critiques dans les deux conditions. » ***UNE PORTE DE SORTIE N'EMPÊCHE PAS D'APPRENDRE CE QU'ELLE CONTOURNE, DÈS LORS QUE LE RESTE DU LANGAGE REPOSE DESSUS.*** **C'est un argument fort pour les couches de K7PL, et il est expérimental.** /La crainte des questions 43 à 46 — un codeur qui reste en couche 3 n'apprendra jamais les couches 1 et 2 — est ici testée sur son analogue le plus proche, et elle n'est pas confirmée./ **Sous une condition explicite : que le langage soit conçu de telle sorte que le concept irrigue tout le reste.**

#### LA RECOMMANDATION AUX CONCEPTEURS DE LANGAGE — *et elle ne porte pas sur la productivité*

> « Que les sentiments positifs envers Rust soient plus fortement corrélés à la ***FRUSTRATION*** et au ***STRESS*** qu'au TEMPS passé sur le devoir suggère que \*/les concepteurs de langage qui veulent favoriser l'adoption (en faisant des langages que les programmeurs aiment) devraient envisager de se concentrer sur la réduction du STRESS — par exemple EN RENDANT LE PROGRÈS PLUS PRÉVISIBLE — plutôt que sur la seule maximisation de la productivité/\*. »

***« RENDRE LE PROGRÈS PRÉVISIBLE » EST UN OBJECTIF DE CONCEPTION, IL EST MESURÉ, ET IL N'EST PAS DANS LA LISTE DES 48 QUESTIONS.*** **C'est le pendant exact de l'évaluation progressive de Green et Petre** — *« la possibilité d'évaluation progressive est carrément essentielle pour les novices »* — **et de la découvrabilité d'interaction du corpus CLT.** *Trois littératures indépendantes disent que ce qui compte n'est pas d'aller vite, mais de savoir où l'on en est.* **À ouvrir comme question 49.**

#### ET LES MESSAGES D'ERREUR SONT JUGÉS, PAR CEUX QUI LES SUBISSENT

« Bien que les messages d'erreur de Rust aient la réputation d'être de haute qualité — un participant a écrit “le compilateur Rust a pratiquement écrit le programme pour moi” — ***le compilateur ne peut pas donner de retour de CONCEPTION de haut niveau***. » **Trois griefs, chacun documenté par une citation de participant** :

|  |  |  |
|----|----|----|
| 1 | ***conseil LOCAL*** | « les messages d'erreur étaient ***cycliques***, du genre : enlever `&`, puis après l'avoir enlevé, essayer d'ajouter `&` » |
| 2 | ***conformité sans compréhension*** | « obtenir des erreurs bizarres que je ne comprends toujours pas mais que j'ai corrigées en écoutant le compilateur » — ***trois participants disent avoir corrigé sans comprendre*** |
| 3 | ***aucun retour d'architecture*** | « quand je testais ma version sans ramasse-miettes, je n'avais jamais rencontré autant d'erreurs de ma vie. Quand j'essayais de les corriger, de nouvelles apparaissaient » |

***UN MESSAGE D'ERREUR PEUT ÊTRE EXCELLENT ET LAISSER LE CODEUR SANS COMPRÉHENSION. C'est la question 30, et elle reçoit ici sa première donnée de première main.***

### GRIS-ZhuZhangQinXiongEtSong

    AUTHORS | DATE | TITLE: ZHU, ZHANG, QIN, XIONG ET SONG — 100 questions publiques disséquées, 101 programmeurs interrogés | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] CE QUI EST DIFFICILE N'EST PAS LA PROPRIÉTÉ, C'EST LA DURÉE DE VIE

|  |  |
|----|----|
| comprend « toujours » les erreurs de règle de ***PROPRIÉTÉ*** | ***39,6 %*** |
| comprend « toujours » les erreurs de règle de ***DURÉE DE VIE*** | ***10,0 %*** |

***UN FACTEUR QUATRE. Et le sens est net : posséder se comprend, DATER ne se comprend pas.*** **Confirmé par le comptage des questions publiques** : /44 violations relèvent du calcul de durée de vie, 41 des règles de propriété — mais sur le grand jeu de données, « plus de questions relatives aux durées de vie que de questions relatives à la propriété »./ *Et Coblenz et al. mesurent la même chose de l'autre côté : sur 1 143 commentaires, 340 portent sur les références, dont ***204 sur les durées de vie***.* ***K7PL PORTE UN GRADE ⟨u, m, ℓ, β⟩ DONT LA COMPOSANTE ℓ EST UNE DURÉE DE VIE. C'est, d'après deux études indépendantes, la composante la plus coûteuse à comprendre de tout le dispositif.***

#### ET LA DIFFICULTÉ N'EST PAS DANS LA RÈGLE, ELLE EST DANS LA RENCONTRE RÈGLE × CONSTRUCTION

> « \*/La MÊME règle a des niveaux de difficulté différents appliquée à des constructions de code différentes, et des règles DIFFÉRENTES ont des niveaux de difficulté différents appliquées à la MÊME construction./\* »

***UNE RÈGLE N'A PAS DE DIFFICULTÉ EN SOI. C'est un couple (règle, construction) qui en a une.*** **Validation expérimentale** : /deux programmes partageant les mêmes constructions mais violant des règles différentes reçoivent des niveaux de difficulté significativement distincts ; et réciproquement./ **Conséquence pour le protocole d'ergonomie de K7PL** : /on ne peut pas mesurer « la difficulté de la sédimentation ». On mesure la difficulté de la sédimentation DANS une construction — dans une macro, dans un gabarit, à une frontière de couche. La grille de l'instrument doit être un TABLEAU à deux entrées, non une liste./ **Et le fermeture est nommée comme cas dur** : /« quand un objet est déplacé vers une fermeture, il peut n'être pas clair pour le programmeur si le déplacement a lieu au site de CRÉATION de la fermeture ou à l'endroit où elle est employée pour la PREMIÈRE FOIS »./ ***Une ambiguïté sur le MOMENT, dans un langage où le moment est la moitié du sens.***

#### L'ÉCHAPPATOIRE N'EST PRESQUE JAMAIS NÉCESSAIRE — *et c'est un résultat rassurant pour K7PL*

« ***La majorité (91,8 %) des violations de règle de sûreté peuvent être corrigées au moyen de code SÛR ou de bibliothèques bien encapsulées à intérieur non sûr.*** Les programmeurs n'ont habituellement pas à écrire du code non sûr eux-mêmes. » *Sur les 110 cas examinés, ***trois seulement*** sont corrigés en écrivant directement du code non sûr.* ***LA DISCIPLINE EST TENABLE. C'est la réponse à l'objection « il faudra bien une porte de sortie » : elle existe, et elle sert dans moins d'un cas sur dix.*** **À rapprocher du résultat de T-63 sur Ruby** — *« les contournements existent, mais ils sont tous non idiomatiques et personne ne les emploie ».* **Ici la structure est inverse et meilleure : le contournement est idiomatique, encapsulé en bibliothèque, et rarement nécessaire.**

#### ET LA TAXINOMIE DE CE QUI MANQUE DANS UN MESSAGE D'ERREUR — *question 30, et c'est la pièce maîtresse*

**La méthode d'abord, parce qu'elle est transposable** : /une ANALYSE DE TÂCHE COGNITIVE auprès d'experts établit les étapes par lesquelles un expert comprend un message d'erreur ; puis on vérifie, message par message, si l'information requise à chaque étape s'y trouve./

|                                                         |                  |
|---------------------------------------------------------|------------------|
| messages contenant ***toute*** l'information nécessaire | ***59*** sur 110 |
| messages à qui il ***manque*** de l'information         | ***51*** sur 110 |

**Et les manques se rangent en trois espèces, qui sont trois espèces de dette d'EXPLICATION** :

|  |  |  |
|----|----|----|
| 1 | ***9*** | ***la règle appliquée à CETTE construction*** — « le compilateur échoue à expliquer comment une règle de sûreté fonctionne sur une construction de code particulière ». *Exemple : les messages « ne mentionnent pas que les éléments d'un tableau ne peuvent pas être empruntés individuellement en Rust ».* |
| 2 | ***32*** | ***les ÉTAPES du calcul*** — « le compilateur échoue à expliquer les étapes clés du calcul d'une durée de vie ou d'une relation d'emprunt ». *Exemple : les messages « n'expliquent pas POURQUOI l'emprunt de `bar2` à la ligne 14 ne prend pas fin avant que l'objet emprunté termine sa durée de vie à la ligne 16 ».* |
| 3 | ***10*** | ***la RELATION entre deux annotations*** — « le compilateur simplement se plaint que la seconde référence ne vit pas aussi longtemps que l'annotation élidée de la première. Cependant, il n'explique pas que la première est l'entrée de la fonction appelante et a une durée de vie PLUS LONGUE que l'appelante, tandis que la seconde réfère à une variable locale et a une durée de vie PLUS COURTE ». |

***TRENTE-DEUX SUR CINQUANTE-ET-UN : L'INFORMATION QUI MANQUE LE PLUS SOUVENT EST LE CHEMIN DU CALCUL, NON LA RÈGLE.*** **Le compilateur dit CE QUI est violé ; il ne dit pas COMMENT il est arrivé là.** ***C'EST LA RÉPONSE À LA QUESTION 30, ET ELLE EST OPÉRABLE : un message d'erreur de K7PL sur un grade doit porter la TRACE du calcul du grade, non seulement son résultat.*** **Et l'effet est mesuré** : /« les participants à qui l'on a montré des messages d'erreur ENRICHIS ont fait significativement mieux que ceux à qui l'on a montré les messages originaux pour expliquer comment les règles de sûreté étaient violées »./ **L'enrichissement n'est pas une conjecture ; il a été testé.**

#### UNE MESURE À VERSER À L'INSTRUMENT DE T-61

*Les auteurs demandent aux sujets de ***SURLIGNER les jetons du programme*** qui sont la cause racine de l'erreur, puis notent l'exactitude.* **Les scores moyens vont de ***0,39 à 0,75*** selon le programme.** ***UNE TÂCHE DE LOCALISATION, NOTÉE SUR UNE ÉCHELLE CONTINUE, QUI DISCRIMINE ENTRE VARIANTES D'UN MÊME PROGRAMME.*** **C'est un protocole de mesure de LÉGIBILITÉ au sens du corpus CLT — identifier les éléments — directement réutilisable pour K7PL** : *montrer un fragment qui viole une contrainte de grade, demander de surligner les jetons fautifs, comparer les variantes notationnelles.* **Et il se combine avec les six questions de leur protocole** — /surligner ; noter la difficulté ; choisir la règle violée parmi dix options dont quatre voisines ; noter la difficulté À NOUVEAU après avoir vu le message ; noter l'utilité du message ; décrire en clair comment la règle a été violée./ ***La double notation de difficulté avant et après le message mesure exactement ce que le message APPORTE. C'est le dispositif que le protocole d'ergonomie n'avait pas.***

## T-66, LE FOND — *LA RÉFLEXION, SEPT PIÈCES, ET B6 Y TROUVE SA JUSTIFICATION HISTORIQUE*

***T-66 n'avait AUCUNE de ces sources. L'entrée portait sur la « réflexion syntaxique » et ne s'appuyait que sur des billets. Voici la littérature.*** /Le résultat tient en une phrase : la réflexion complète a un prix qui se paie même quand on ne s'en sert pas, et les macros sont le sous-ensemble qui ne le paie pas. B6 avait raison, mais pour une raison qu'elle n'énonçait pas./

### GRIS-Smith1984

    AUTHORS | DATE | TITLE: SMITH 1984 — « RÉFLEXION ET SÉMANTIQUE EN LISP », et deux notions que l'arc n'avait pas | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] L'ACCUSATION — *« l'ÉVALUATION \[…\] considérée nuisible »*

> « ***La notion de base d'ÉVALUATION en Lisp, je le soutiendrai, est CONFUSE à cet égard, et devrait être remplacée par les notions indépendantes de DÉSIGNATION et de SIMPLIFICATION.*** »

**Le grief est précis** : /l'évaluateur de Lisp « TRAVERSE LES NIVEAUX SÉMANTIQUES, et obscurcit par là la différence entre simplification et désignation. Il autorise des anomalies sémantiques telles que `(+ 1 '2)`, qui s'évalue à 3 dans tous les Lisp existants »./ **Et la conséquence est énoncée sans détour** : « même si l'on sait ce qu'est Y, et que l'on sait que X s'évalue en Y, ***on ne sait toujours pas ce que X DÉSIGNE***. » ***UNE OPÉRATION QUI NE PRÉSERVE PAS CE QU'ELLE PORTE. C'est le diagnostic le plus dur qu'un concepteur ait porté sur le mécanisme central de Lisp, et il date de 1984.*** **La contrainte qu'il propose à la place** : *un processeur devrait TOUJOURS simplifier — c'est-à- dire préserver la désignation et produire une forme normale : `∀s ∈ S [Φ(Ψ(s)) = Φ(s) ∧     FORME-NORMALE(Ψ(s))]`.* \*/CECI VISE LA QUESTION 5. La quasi-citation de Common Lisp est écartée par Anthea ; voici l'argument de fond qui manquait : ce qui est vicié n'est pas la CITATION, c'est l'ÉVALUATION qui la traverse./\* *La citation, dit Smith, « c'est juste ce qu'est la citation » — elle est saine. C'est l'opérateur qui la défait sans le dire qui ne l'est pas.*

#### ET LE CRITÈRE DE CONCEPTION — *l'ALIGNEMENT DE CATÉGORIES*

> « J'ai reconstruit ce que j'appelle la ***STRUCTURE DE CATÉGORIES*** de Lisp, en exigeant que les catégories dans lesquelles les structures Lisp sont triées, à diverses fins, ***S'ALIGNENT***. Plus précisément, les expressions Lisp sont triées en catégories ***par la NOTATION, par la STRUCTURE*** (atomes, paires, numéraux), ***par le TRAITEMENT PROCÉDURAL*** (le “dispatch” à l'intérieur de `EVAL`), ***et par la SÉMANTIQUE DÉCLARATIVE*** (le type d'objet désigné). Traditionnellement \[…\] ces catégories ne sont PAS alignées \[…\]. En 2-Lisp nous exigeons que les catégories notationnelle, structurelle, procédurale et sémantique ***se correspondent une à une***. »

***QUATRE TRIS D'UN MÊME OBJET, ET UN CRITÈRE : QU'ILS COÏNCIDENT.*** **C'est le critère que l'arc cherchait pour P-3 et pour l'arbitrage des frontières de couches, et il est plus fort que tout ce que le dossier avait réuni.** /K7PL trie ses termes par notation (les délimiteurs de couche), par structure, par traitement (quelle couche vérifie quoi) et par sémantique (le grade). ***La question à poser à K7PL est donc : ces quatre tris coïncident-ils ?*** Si un même signe relève de deux catégories notationnelles selon le contexte, ou si la frontière notationnelle ne coïncide pas avec la frontière procédurale, l'alignement est rompu — et Smith montre que c'est exactement ce qui rend Lisp difficile à expliquer./ **Et le bénéfice de l'alignement est chiffré en propriétés gagnées** : /« de nombreuses propriétés de Lisp qu'il faut d'ordinaire poser AD HOC découlent directement de notre analyse. Par exemple, il faut normalement énoncer explicitement que certains atomes, comme `T`, `NIL` et les numéraux, s'auto-évaluent ; en 2-Lisp, le fait que les constantes booléennes s'auto-normalisent découle directement de ce qu'elles sont des désignateurs en forme normale »./ ***L'ALIGNEMENT TRANSFORME DES RÈGLES EN CONSÉQUENCES. C'est le rendement de conception que la règle KISS cherche.***

#### ET CE QUE LA RÉFLEXION ACHÈTE — *formulé une fois pour toutes*

« L'architecture réflexive fournit une méthode pour ***rendre certains aspects du calcul EXPLICITES, au beau milieu d'un calcul, même s'ils étaient implicites un instant plus tôt***. Elle fournit un mécanisme, autrement dit, ***pour tendre la main et « tirer de l'information du ciel » quand des circonstances inattendues le justifient, sans avoir à s'en soucier autrement***. »

### GRIS-HerzeelCostanzaEtDHondt

    AUTHORS | DATE | TITLE: HERZEEL, COSTANZA ET D'HONDT — le mot que le dossier n'avait pas : ABSORPTION | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA DÉFINITION, ET ELLE NOMME LES COUCHES DE K7PL

> « L'appel de fonction, la récursion et la portée lexicale ne sont pas explicitement mentionnés dans les programmes et sont donc dits ***ABSORBÉS*** par le langage. Certains langages absorbent MOINS et révèlent PLUS de détails du fonctionnement interne de leur implantation \[…\]. \*/Quand on conçoit un langage de programmation, choisir quelles parties du modèle d'implantation sont ou ne sont pas absorbées, c'est trouver le juste équilibre entre GÉNÉRALITÉ et CONCISION, et il est difficile de déterminer ce qu'est un bon équilibre dans le cas général./\* »

***L'ABSORPTION EST LA GRANDEUR QUE LES TROIS COUCHES DE K7PL FONT VARIER.*** \*La couche 3 absorbe le grade ; la couche 1 l'expose. Les couches ne sont pas trois langages : c'est un même langage à trois DEGRÉS D'ABSORPTION.\* **Et la définition de la réflexion suit** : « un langage réflexif fournit les moyens de ***rendre explicite ce qui est absorbé, DANS UN STYLE À LA DEMANDE*** ». ***« À LA DEMANDE » — c'est la réponse aux questions 43 à 46. Ce qu'un codeur doit pouvoir découvrir, ce n'est pas une fonctionnalité de plus : c'est ce que le langage lui cache.*** **Avec l'avertissement, qui vaut pour K7PL** : « en ajoutant la réflexion au langage, nous brisons (à dessein) cette illusion ».

#### LES DEUX RÉFLEXIONS, ET LA LIGNE DE PARTAGE EST CELLE DE B6

|  |  |
|----|----|
| ***réflexion STRUCTURELLE*** | « raisonner et programmer sur les éléments du domaine interne, c'est-à-dire inspecter et changer la représentation interne d'un programme » — ***2-Lisp*** |
| ***réflexion PROCÉDURALE*** | « raisonner sur la NORMALISATION des programmes » ; donne accès au contexte d'exécution — ***3-Lisp*** |

**Et le point décisif** : « ce qu'il importe de noter, c'est que \*/les changements structurels d'un programme peuvent être faits SANS EXÉCUTER le programme. À ce titre, des techniques de COMPILATION peuvent être employées pour implanter la réflexion structurelle./\* » ***LES MACROS SONT DE LA RÉFLEXION STRUCTURELLE. Elles se compilent. La réflexion procédurale non.***

#### ET LA POSITION DES MACROS EST DATÉE DE 1980

« Les macros furent introduites dans Lisp 1.5 dans les années 1960, et sont considérées comme ***un sous-ensemble ACCEPTABLE et GÉNÉRALEMENT PRÉFÉRABLE de la réflexion sur le code source*** \[Pitman 1980\]. La différence à cet égard avec les procédures réflexives, les `fexpr`, etc., est que \*/les macros ne peuvent pas être passées comme valeurs de première classe et sont typiquement empêchées d'accéder aux valeurs d'exécution pendant l'expansion. Cela permet de LES COMPILER AVANT L'EXÉCUTION/\*, comme l'imposent par exemple les spécifications actuelles de Scheme et de Common Lisp ANSI. » ***B6 — LES MACROS PLUTÔT QUE LES FONCTIONS DE PREMIÈRE CLASSE — A UN PRÉCÉDENT DE 1980, ET LA RAISON N'EST PAS LA SIMPLICITÉ : C'EST LA COMPILABILITÉ.*** **Et les deux restrictions qui l'achètent sont nommées** : /pas de première classe, pas d'accès aux valeurs d'exécution. Ce sont exactement les deux que Kai énonce pour Uiua, quarante-trois ans plus tard, sans citer Pitman./

### GRIS-Asai

    AUTHORS | DATE | TITLE: ASAI — LE PRIX DE LA RÉFLEXION PROCÉDURALE, ET IL SE PAIE SANS S'EN SERVIR | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE CHIFFRE QUI TRANCHE

> « Pour rendre l'interprète de métaniveau modifiable, il nous faut interpréter l'interprète de métaniveau au moyen d'un autre interprète. Ainsi, les programmes de l'usager sont interprétés par DEUX interprètes. Habituellement, \*/un niveau d'interprétation de plus entraîne un ralentissement d'un ORDRE DE GRANDEUR. Ce ralentissement est INÉVITABLE, MÊME SI L'ON N'EMPLOIE AUCUNE CAPACITÉ RÉFLEXIVE./\* »

***UN FACTEUR DIX, PAYÉ PAR TOUS, POUR UNE FACILITÉ QU'UNE MINORITÉ EMPLOIE. C'est l'argument décisif contre une tour réflexive dans K7PL, et il est quantitatif.*** **Et la parade de Black est une distinction que K7PL peut reprendre** : /« le système Black introduit une distinction entre code INTERPRÉTÉ et code COMPILÉ. Le code interprété est SENSIBLE à la redéfinition de l'interprète de métaniveau \[…\]. Le code compilé y est INSENSIBLE »./ ***DEUX RÉGIMES DANS UN MÊME LANGAGE, DISTINGUÉS PAR CE À QUOI ILS SONT SENSIBLES. C'est la même forme que les trois couches.***

#### ET LA COMPILATION D'UN LANGAGE RÉFLEXIF N'EST POSSIBLE QUE PAR ÉVALUATION PARTIELLE

« ***Nous ne pouvons pas construire de compilateur autonome, puisqu'un compilateur suppose une sémantique de langage FIXE.*** Dans la circonstance où la sémantique du langage peut changer, la seule manière de compiler un programme est ***l'ÉVALUATION PARTIELLE*** : nous spécialisons la sémantique du langage (un interprète) par rapport au programme de l'usager. » ***UNE SÉMANTIQUE MODIFIABLE INTERDIT LE COMPILATEUR AUTONOME. Écrit noir sur blanc.*** **Le résultat expérimental, pour la mesure** : *par MetaOCaml, « nous avons obtenu un facteur d'accélération d'environ ***HUIT*** en compilant tout le dispatch syntaxique. Le temps requis pour la compilation était négligeable, environ 0,04 seconde ».* **Et l'aveu de limite** : *« faute d'analyse de temps de liaison dans MetaOCaml, il est difficile de spécialiser un programme d'usager par rapport à l'interprète de métaniveau modifié et compilé ».*

### GRIS-DanvyEtMalmkjr

    AUTHORS | DATE | TITLE: DANVY ET MALMKJÆR — la tour formalisée, et une propriété qui a un nom | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-Flatt

    AUTHORS | DATE | TITLE: FLATT — LE PROBLÈME DE PHASE, ET K7PL EST UNE TOUR DE LANGAGES | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE DIAGNOSTIC

> « \*/Un langage qui permet aux transformateurs de macros d'effectuer un calcul arbitraire DOIT IMPOSER une séparation entre les calculs : temps d'exécution CONTRE temps de compilation, ainsi que le temps de compilation d'un module CONTRE celui d'un autre./\* Sans séparation imposée, ***le sens d'un fragment de code peut dépendre de l'ORDRE dans lequel le code est compilé et exécuté***. »

**Et le coût de ne pas l'imposer** : « au mieux, les programmeurs doivent travailler dur pour gérer les dépendances. ***Au pire, et plus communément, les dépendances sont trop subtiles pour être gérées correctement***, et ils ne peuvent pas attendre de résultats prévisibles en combinant des bibliothèques de manière neuve ou en employant de nouveaux outils. » ***« RÉSULTATS PRÉVISIBLES » — C'EST LE MÊME MOT QUE COBLENZ ET AL. Deux littératures sans rapport convergent sur la prévisibilité comme objet de conception.***

#### LES TROIS FAIBLESSES DE L'ANNOTATION — *et l'arc envisageait exactement cette solution*

|  |  |
|----|----|
| 1 | ***fragile*** — « de petits changements dans l'organisation du programme peuvent rendre un ensemble d'annotations incorrect » |
| 2 | ***indiscernable*** — « pour de grands exemples avec de HAUTES TOURS DE LANGAGES \[…\], les annotations correctes peuvent être difficiles à discerner » |
| 3 | ***silencieusement fausse*** — « ***un ensemble d'annotations incorrect peut sembler fonctionner correctement (pendant un temps)*** du fait de la mise en œuvre accidentelle \[…\] » |

\*/UNE ANNOTATION QUI PARAÎT MARCHER ET QUI EST FAUSSE. C'est le pire mode de défaillance possible pour un dispositif de conception, et c'est celui qu'on obtient si l'on traite la phase par convention plutôt que par le langage./\* **K7PL est concerné directement** : /ses macros sont des glyphes de bibliothèque, donc chaque bibliothèque de glyphes est un étage de tour. La question « les glyphes d'une bibliothèque peuvent-ils être employés pour définir les glyphes d'une autre ? » est la question de Flatt, et elle appelle une réponse DANS LE LANGAGE./\*

#### LES DEUX TRAITS QUI COMPLIQUENT, ET LE MÉCANISME RETENU

- ***macros engendrant des macros*** — « une expansion de macro peut engendrer une expression destinée à être exécutée dans la MÊME phase que son générateur. \[…\] critiquement importantes pour implanter des extensions de langage qui LIENT DE L'INFORMATION DE TEMPS DE COMPILATION » ;
- ***portée lexicale*** — « un identifiant libre introduit par une expansion réfère à sa liaison dans le contexte de DÉFINITION de la macro ».

**La solution** : *deux importations distinctes, `require` et `require-for-syntax`, et une instanciation SÉPARÉE du même module par phase.* **Avec la conséquence énoncée sans détour** : « le `cons` de temps de compilation est (en principe) ***sans rapport*** avec le `cons` d'exécution ». ***UN MÊME NOM, DEUX PHASES, DEUX CHOSES SANS RAPPORT. C'est admis, réglé, et écrit.*** **Et la traduction pour K7PL est immédiate** : /un glyphe employé pour DÉFINIR un glyphe n'est pas le même objet que le même glyphe employé dans un programme. Si K7PL veut une bibliothèque de glyphes composable, il lui faut cette distinction, et P-2 doit en tenir compte : l'alias textuel d'un glyphe est-il le même à toutes les phases ?/

### GRIS-HermanEtWand

    AUTHORS | DATE | TITLE: HERMAN ET WAND — L'HYGIÈNE COMME SPÉCIFICATION, ET LA BOUCLE EST ROMPUE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE PROBLÈME, ET IL EST CIRCULAIRE

> « L'hygiène n'a jamais été présentée de manière formelle, ***comme une SPÉCIFICATION plutôt que comme un ALGORITHME***. Selon le folklore, la définition de l'expansion hygiénique repose sur la préservation de l'α-équivalence. ***Mais la seule définition connue de l'α-équivalence pour Scheme dépend des RÉSULTATS de l'expansion !*** »

**La cause** : *« puisque les seules formes liantes connues en Scheme sont les formes du noyau, ***la structure de liaison d'une expression Scheme n'apparaît qu'APRÈS expansion complète*** ».*

#### LA SOLUTION — *et c'est une obligation faite à chaque macro*

« Nous brisons cette circularité en introduisant des ***SPÉCIFICATIONS DE LIAISON*** pour les macros, permettant une définition de l'α-équivalence ***INDÉPENDANTE de l'expansion***. » ***CHAQUE MACRO DÉCLARE SA STRUCTURE DE LIAISON. C'est le prix, et il est modeste.*** **Le vérificateur en tire deux obligations** : *« confirmer que ***chaque DÉFINITION de macro se conforme à sa spécification***, et que ***chaque USAGE d'une macro se conforme à son interface*** ».* **Une macro a donc un TYPE, et ce type est un type de LIAISON — un « type de forme ».** **Et le théorème** : *l'hygiène découle de la CONFLUENCE. « Ce théorème fournit la garantie cruciale des macros hygiéniques, à savoir que ***l'α-conversion des programmes préserve la sémantique***. »* \*/L'HYGIÈNE N'EST PAS UN ALGORITHME DE RENOMMAGE : C'EST UNE PROPRIÉTÉ QUI DÉCOULE D'UNE DÉCLARATION. C'est la réponse que la chaîne Gabbay-Pitts → Bojańczyk-Klin-Lasota → Kurz et al. appelait du côté des macros./\* *Et les auteurs citent Gabbay et Pitts explicitement : la chaîne est refermée.*

#### ET UNE ASTUCE D'UNIFORMITÉ, GRATUITE

/« Parce que l'application de fonction en Scheme est dénotée par la PARENTHÉSATION plutôt qu'en invoquant une macro d'application spéciale, la règle d'analyse des applications insère une référence explicite à une macro prédéfinie `@` », comme le `#%app` de PLT Scheme. Et `lambda` est elle-même définie comme une macro dans le contexte initial./ ***L'APPLICATION EST UNE MACRO. LA LIAISON EST UNE MACRO. Tout est macro, sans exception, et le noyau se réduit à deux entrées d'environnement.*** **C'est le degré d'uniformité que B6 vise et que K7PL peut atteindre** : /si les glyphes sont des macros de bibliothèque, alors la juxtaposition elle-même devrait en être une — sans quoi il reste une forme privilégiée, et l'alignement de catégories de Smith est rompu à cet endroit précis./ **Et la réserve des auteurs, qui borne le résultat** : /le calcul couvre un sous-ensemble du PREMIER ORDRE des macros Scheme ; « les macros PROCÉDURALES, l'inférence des types de forme, et le support de la capture INTENTIONNELLE » sont laissés en travaux futurs./ ***Les macros de K7PL ne sont pas au premier ordre si elles calculent. Le théorème ne les couvre pas encore.***

## QUESTION 30 — *LES MESSAGES D'ERREUR, CINQUANTE ANS DE LITTÉRATURE ET QUATRE FACTEURS MESURÉS*

***Le résidu T-63 n° 8 est levé. Et il apporte plus que prévu : non pas des conseils, mais un DISPOSITIF DE MESURE et un aveu d'échec collectif.***

### GRIS-BeckerDennyPettitEtAl

    AUTHORS | DATE | TITLE: BECKER, DENNY, PETTIT ET AL. — le rapport de groupe de travail, 300+ références | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] L'ÉTAT DU DOMAINE, DIT PAR CEUX QUI LE FONT — *cinq constats, dont trois désolants*

|  |  |
|----|----|
| A | « la littérature est ***clairsemée et dispersée***, quoique l'intérêt ait augmenté fortement ces cinq à dix dernières années » |
| B | « les messages d'erreur sont problématiques, ***quel que soit le langage***, particulièrement pour les étudiants. Ils le sont depuis ***plus de cinquante ans***, et les progrès ont été lents » |
| C | « ils sont ***pédagogiquement importants***, particulièrement dans leur rôle d'agents de rétroaction » |
| D | « ils sont ***techniquement difficiles à perfectionner AB INITIO***. Cela ne se résoudra pas de sitôt » |
| E | « ***aucune image cohérente n'a émergé pour répondre à des questions même simples telles que : à quoi ressemble un bon message d'erreur ?*** » |

***CINQUANTE ANS, ET LA QUESTION « À QUOI RESSEMBLE UN BON MESSAGE » N'A PAS DE RÉPONSE.*** **L'arc doit en prendre acte : la question 30 ne recevra pas d'arbitrage de la littérature.** /Elle reçoit ce que le corpus CLT donnait déjà — du vocabulaire, des méthodes de mesure, et des réfutations d'intuitions fausses./

#### LES DIX LIGNES DIRECTRICES GÉNÉRALISÉES — *extraites du corpus, et elles couvrent 20 des 22 de la littérature*

|  |  |  |
|----|----|----|
| 1 | ***accroître la LISIBILITÉ*** | mesurée depuis 2021 — voir ci-dessous |
| 2 | ***réduire la CHARGE COGNITIVE*** | « bref », « spécifique », « cohérent » |
| 3 | ***fournir le CONTEXTE de l'erreur*** | localiser, pointer |
| 4 | ***employer un TON POSITIF*** | « accord universel dans la littérature » |
| 5 | ***montrer des EXEMPLES d'erreurs semblables*** |  |
| 6 | ***montrer des SOLUTIONS ou des INDICES*** |  |
| 7 | ***permettre l'INTERACTION dynamique*** | « distinguer les corrections des explications » |
| 8 | ***fournir un ÉTAYAGE à l'usager*** | fondé sur la théorie de la charge cognitive |
| 9 | ***employer une ARGUMENTATION LOGIQUE*** | « présenter les reconstructions rationnelles comme des NARRATIONS cohérentes allant des causes aux symptômes » |
| 10 | ***signaler les erreurs AU BON MOMENT*** |  |

**La neuvième est celle qui recoupe le résultat de Zhu et al.** — /trente-deux messages Rust sur cinquante-et-un manquent des ÉTAPES du calcul. « Une narration cohérente des causes aux symptômes » est le nom que ce corpus donne à ce qui manque./ ***DEUX LITTÉRATURES DISJOINTES CONVERGENT SUR LE MÊME MANQUE.***

#### ET LA LOCALISATION EST LE POINT OÙ TOUT SE JOUE — *avec une contrepartie*

/« Traver note que fournir à l'usager une localisation d'erreur INCORRECTE rend le message PLUS confus. De même, Wrenn et Krishnamurthi rapportent que les étudiants trouvent le surlignage de l'emplacement de l'erreur ***utile quand il est correct, mais FRUSTRANT quand il est incorrect***. »/ *Et Nienaltowski et al. : le surlignage « a aidé les étudiants à corriger les erreurs PLUS VITE, mais n'a pas accru leur CAPACITÉ à les corriger ».* ***UN POINTEUR FAUX EST PIRE QU'AUCUN POINTEUR. C'est une contrainte de conception dure pour K7PL : un message sur un grade doit désigner un jeton dont il est CERTAIN, ou n'en désigner aucun.***

#### ET LA VOIE QUI SUPPRIME LE PROBLÈME AU LIEU DE LE TRAITER

*Le rapport cite Scratch, par Resnick et al.* :

> « ***Quand des gens jouent avec des briques LEGO, ils ne rencontrent pas de messages d'erreur. Les pièces ne s'emboîtent que de certaines façons, et il est plus facile de faire juste que faux*** \[…\] de même, Scratch n'a pas de messages d'erreur. Les erreurs de syntaxe sont éliminées parce que, comme les LEGO, les blocs ne s'assemblent que de manières qui ont du sens. \[…\] Bien sûr, éliminer les messages d'erreur n'élimine pas les erreurs \[…\] mais \*/un programme qui S'EXÉCUTE, même s'il est incorrect, semble plus près de fonctionner qu'un programme qui ne s'exécute (ou ne compile) PAS DU TOUT/\*. »

***« PLUS PRÈS DE FONCTIONNER » — c'est encore la PRÉVISIBILITÉ DU PROGRÈS de Coblenz et al., et c'est la troisième littérature indépendante à y arriver.*** **Et la version adulte existe** : *l'édition par cadres — Stride — « permet une programmation plus complexe avec l'élimination PAR CONCEPTION d'au moins certaines erreurs de syntaxe courantes ».* **Question ouverte pour K7PL** : *peut-on rendre certaines violations de grade INEXPRIMABLES plutôt que détectées ? C'est la différence entre un message d'erreur et une brique qui ne s'emboîte pas.*

### GRIS-DennyPratherEtBecker

    AUTHORS | DATE | TITLE: DENNY, PRATHER ET BECKER — l'essai contrôlé, et le facteur est de DEUX | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-DennyPratherBeckerEtAl

    AUTHORS | DATE | TITLE: DENNY, PRATHER, BECKER ET AL. — les QUATRE FACTEURS de lisibilité, et ils sont mesurés | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-MiaraMusselmanNavarroEtShneiderman

    AUTHORS | DATE | TITLE: MIARA, MUSSELMAN, NAVARRO ET SHNEIDERMAN — 86 sujets, quatre niveaux, deux styles | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE RÉSULTAT

> « Bien que ***le style de blocage n'ait fait aucune différence***, le niveau d'indentation a eu un ***effet significatif*** sur la compréhension du programme. (***2 à 4 espaces*** ont obtenu le score moyen le plus élevé.) Nous recommandons ***qu'un niveau MODÉRÉ d'indentation soit employé***. »

| niveau d'indentation         | novices     | experts     |
|------------------------------|-------------|-------------|
| ***0 espace***               | ***4,5***   | ***6,3***   |
| ***2 espaces*** — le maximum | ***6,0***   | ***7,5***   |
| 4 puis 6 espaces             | décroissant | décroissant |
| blocs contre non-blocs       | 5,0 / 4,8   | 6,7 / 6,7   |

*Sur 10 points. Analyse de variance : niveau d'expérience à `p < 0,001`, niveau d'indentation à `p = 0,013` ; ***aucun effet significatif du style de blocage***, ni dans les interactions.* ***LE NIVEAU COMPTE, LE STYLE NON. Et l'optimum n'est PAS au maximum.***

#### LE MÉCANISME EST NOMMÉ, ET C'EST UN MÉCANISME DE BALAYAGE

« La baisse de compréhension pourrait tenir au fait qu'à mesure que le niveau d'imbrication d'un programme profondément indenté augmente, ***le programme est décalé si loin vers la DROITE de la page que le BALAYAGE devient difficile***. Dans la version non blocs à 6 espaces, il devint nécessaire de continuer les énoncés à la ligne suivante quand l'imbrication amenait le texte à la limite des 80 colonnes. » ***C'EST EXACTEMENT LE MÉCANISME DE LA TROP GRANDE TERSITÉ CHEZ GREEN ET PETRE : la silhouette se dégrade.*** **Une seule cause — le balayage — deux excès opposés.** *Trop terse : deux programmes différents se ressemblent. Trop indenté : un même programme ne tient plus dans le champ.*

#### ET LE RÉSULTAT LE PLUS UTILE EST MÉTHODOLOGIQUE — *préférence et performance DIVERGENT*

> « Il est intéressant de noter, cependant, que ***les programmes à 6 espaces ont été jugés les MOINS DIFFICILES à employer***. Nous pensons que ce résultat tient à ce que les programmeurs trouvent un programme profondément indenté ***visuellement plaisant***, puisqu'il semble étaler proprement les constructions du langage. Cependant, quand une tâche de compréhension est assignée, cet espacement exagéré cause des problèmes \[…\]. »

***LA MISE EN PAGE LA PLUS APPRÉCIÉE EST CELLE QUI FAIT LE PLUS BAISSER LES SCORES.*** **C'est l'avertissement le plus dur que le protocole d'ergonomie de K7PL puisse recevoir** : /toute question de notation posée sous la forme « laquelle préférez-vous ? » risque de mesurer l'inverse de ce qu'on cherche. Les deux mesures doivent être prises SÉPARÉMENT et confrontées./ ***L'INSTRUMENT DE T-61 DOIT PORTER DEUX COLONNES : PERFORMANCE ET PRÉFÉRENCE. Et il doit s'attendre à ce qu'elles divergent.*** **Un second écart de même nature, entre novices et experts** : /« les novices se sont montrés bien plus critiques que les experts sur ce qu'ils appelaient de “mauvaises” pratiques \[…\]. Les experts n'ont fait que très peu de remarques sur la structure du programme »./ **Et pourtant les experts ont mieux réussi sur toutes les versions.** *Celui qui se plaint le plus n'est pas celui qui souffre le plus.*

#### ET UN COMPORTEMENT OBSERVÉ QUI VAUT POUR K7PL

*« Une proportion significative des sujets ayant reçu la version non indentée ont passé une grande part de la limite de 20 minutes ***à DÉCOUPER eux-mêmes le programme en blocs de contrôle*** (50 % des novices et 62 % des experts). »* ***QUAND LA MISE EN PAGE NE DIT PAS LA STRUCTURE, LE LECTEUR LA RECONSTRUIT À LA MAIN — et les EXPERTS le font PLUS SOUVENT que les novices.*** \*C'est le geste de l'informateur LabVIEW de Green et Petre — une à deux heures à déplacer des boîtes — vu du côté de la LECTURE au lieu de l'écriture.\* /Et le complément : dans le groupe novice recevant la version non blocs à 6 espaces, AUCUN listing rendu n'était découpé en blocs ; dans la version blocs à 6 espaces, 50 % l'étaient. « Une forme d'indentation est nécessaire pour distinguer clairement les segments de contrôle. Cependant, quand le programme est profondément indenté, les blocs de contrôle peuvent ne plus être clairement identifiables. »/

### GRIS-CeQueCelaDonnePourLeFormateurDeK7Pl

    AUTHORS | DATE | TITLE: CE QUE CELA DONNE POUR LE FORMATEUR DE K7PL | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-Gibson1979

    AUTHORS | DATE | TITLE: GIBSON 1979 — L'AFFORDANCE, ET ELLE N'EST PAS CE QUE L'IHM EN A FAIT | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA DÉFINITION, ET LE MOT EST UN NÉOLOGISME ASSUMÉ

> « ***Les affordances de l'environnement sont ce qu'il OFFRE à l'animal, ce qu'il lui procure ou lui fournit, EN BIEN COMME EN MAL.*** Le verbe *to afford* se trouve dans le dictionnaire, mais le substantif *affordance* ne s'y trouve pas. ***Je l'ai inventé.*** J'entends par là quelque chose qui réfère à la fois à l'environnement et à l'animal d'une manière qu'aucun terme existant ne fait. Il implique la ***COMPLÉMENTARITÉ*** de l'animal et de l'environnement. »

***« EN BIEN COMME EN MAL » — une affordance peut être NÉGATIVE. L'usage courant en IHM ne retient que les bonnes.*** **Et la mesure est relative, ce qui interdit une échelle absolue** : /les quatre propriétés qui font qu'une surface porte — horizontale, plane, étendue, rigide — « seraient des propriétés PHYSIQUES si on les mesurait avec les échelles et les unités de la physique. Comme affordance de support pour une espèce, cependant, ***elles doivent être mesurées RELATIVEMENT à l'animal. Elles sont uniques pour cet animal***. \[…\] ***Une affordance ne peut donc pas être mesurée comme on mesure en physique***. »/ **Et la position ontologique, qui est le cœur** :

> « \*/Une affordance n'est ni une propriété OBJECTIVE ni une propriété SUBJECTIVE ; ou elle est les deux, si l'on veut. Une affordance TRAVERSE la dichotomie subjectif-objectif et nous aide à comprendre son insuffisance./\* Elle est également un fait de l'environnement et un fait du comportement. \[…\] ***Une affordance pointe dans les deux sens, vers l'environnement et vers l'observateur.*** »

***C'EST EXACTEMENT LA POSITION ANTI-SUPERLATIVISTE, ÉNONCÉE VINGT ANS PLUS TÔT ET DANS UN AUTRE DOMAINE.*** **« Il n'y a pas de meilleure notation, il y a des notations qui conviennent à des tâches » est la forme notationnelle de « une affordance pointe dans les deux sens ».** *Et le lien est plus qu'analogique : « une NICHE est un ENSEMBLE d'affordances ». Une tâche, au sens de l'adéquation-inadéquation, est une niche.*

#### ET LE MODE DE DÉFAILLANCE QUI MANQUAIT AU DOSSIER — *la MÉSINFORMATION*

> « S'il y a de l'information dans la lumière ambiante pour les affordances des choses, peut-il y avoir aussi de la MÉSINFORMATION ? Selon la théorie développée ici, \*/si de l'information est captée, il en résulte une PERCEPTION ; si de la mésinformation est captée, il en résulte une MÉPRISE./\* »

**Les deux exemples sont célèbres et ils sont exacts** :

|  |  |
|----|----|
| 1 | ***la falaise visuelle*** — une plaque de verre au bord d'un vide : « elle n'offre plus de tomber et n'est en fait pas dangereuse, ***mais elle peut ENCORE LE PARAÎTRE*** ». Les nourrissons tapotent le verre et refusent d'avancer. |
| 2 | ***la porte vitrée*** — « un adulte peut se méprendre sur l'affordance d'une feuille de verre en prenant une porte vitrée FERMÉE pour une embrasure OUVERTE et en tentant de la traverser. Il heurte alors la barrière et se blesse. » |

***UNE NOTATION PEUT DONNER DE LA MÉSINFORMATION. Ce n'est ni « difficile à apprendre » ni « peu lisible » : c'est une forme qui SPÉCIFIE quelque chose de FAUX.*** **C'est le troisième terme que le dossier cherchait à côté de LISIBILITÉ et de LÉGIBILITÉ.** /Le corpus CLT distingue ce qui est facile à SAISIR (lisibilité) de ce qui est facile à IDENTIFIER (légibilité). Gibson ajoute : ce qui est identifié et saisi PEUT ÊTRE FAUX, et la faute en est à la forme, non au lecteur./ **Et il donne un nom à des griefs déjà recueillis** : /la surcharge de valence de Lochbaum — « une occurrence peut n'avoir même pas un seul sens » — est une mésinformation. L'annotation `eval-when` de Flatt qui « semble fonctionner correctement pendant un temps » est une mésinformation. Le pointeur d'erreur incorrect de Traver est une mésinformation./ ***TROIS GRIEFS INDÉPENDANTS, UN SEUL MÉCANISME, ET IL EST NOMMÉ DEPUIS 1979.***

### GRIS-Rasmussen1983

    AUTHORS | DATE | TITLE: RASMUSSEN 1983 — SRK DE PREMIÈRE MAIN, ET LA HIÉRARCHIE D'ABSTRACTION | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LES TROIS RÉGIMES D'INFORMATION, TEXTUELLEMENT

|  |  |
|----|----|
| ***SIGNAUX*** | « données sensorielles représentant des variables temps-espace \[…\] traitables comme des variables continues ». ***« Ces signaux n'ont aucune “signification” sinon comme données physiques directes. »*** |
| ***SIGNES*** | « indiquent un état de l'environnement en référence à certaines CONVENTIONS d'action. \[…\] ***Les signes ne peuvent pas être traités directement ; ils servent à ACTIVER des schémas de comportement stockés.*** » |
| ***SYMBOLES*** | « représentent d'autres informations, variables, relations et propriétés, et ***peuvent être traités FORMELLEMENT***. Constructions abstraites liées à et définies par une structure formelle de relations et de processus. » |

**Avec la distinction que Rasmussen emprunte à Cassirer** : « ***un signe fait partie du monde physique de l'ÊTRE, un symbole fait partie du monde humain du SENS*** ». ***POUR K7PL : un délimiteur de couche est-il un SIGNE ou un SYMBOLE ?*** \*S'il active un schéma stocké — « ici on change de régime » — c'est un signe et il relève de la règle. S'il est traité formellement — « ce fragment porte tel grade » — c'est un symbole.\* *Les deux sont légitimes ; ce qui ne l'est pas, c'est que le lecteur ne sache pas duquel il s'agit.*

#### ET LE POINT QUI VISE DIRECTEMENT LA QUESTION 25

> « \[…\] des problèmes majeurs durant les situations non familières peuvent être causés par le fait que ***LA MÊME INDICATION peut être perçue dans des RÔLES DIFFÉRENTS***, et que ***c'est un phénomène psychologique bien connu que le PASSAGE d'un mode de perception à un autre est DIFFICILE***. »

***LE COÛT N'EST PAS D'APPRENDRE TROIS RÉGIMES : C'EST DE PASSER DE L'UN À L'AUTRE.*** **La question 25 — « comment un lecteur neuf sait-il qu'il y a plusieurs régimes ? » — reçoit sa forme exacte** : /le difficile n'est pas de savoir qu'il y en a plusieurs ; c'est que le même signe change de rôle et que le lecteur doit changer de mode. K7PL a trois couches et un même vocabulaire dans les trois. C'est précisément la configuration que Rasmussen signale comme la plus coûteuse./ **Et il l'illustre par le témoignage des opérateurs de Three Mile Island devant le Congrès — c'est le cas d'école du domaine.**

#### LA HIÉRARCHIE D'ABSTRACTION, ET SA PROPRIÉTÉ NON ÉVIDENTE

|  |  |
|----|----|
| ***but fonctionnel*** | production, objectifs |
| ***fonction abstraite*** | flux de masse, d'énergie, d'information |
| ***fonctions généralisées*** | boucles de contrôle « standard », transfert de chaleur |
| ***fonctions physiques*** | processus électriques, mécaniques, chimiques des composants |
| ***forme physique*** | apparence matérielle, anatomie, emplacements |

> « ***En passant d'un niveau d'abstraction au niveau supérieur, le changement dans les propriétés représentées n'est PAS un simple RETRAIT de détails*** sur les propriétés physiques ou matérielles. ***Plus fondamentalement, DE L'INFORMATION EST AJOUTÉE sur les principes de niveau supérieur qui gouvernent la CO-FONCTION des divers éléments du niveau inférieur.*** »

***UN NIVEAU SUPÉRIEUR AJOUTE, IL NE CACHE PAS. C'est la contrainte la plus dure que ce lot impose à K7PL.*** **La couche 3 de K7PL est présentée comme celle qui absorbe le grade. Si elle ne fait qu'absorber, ce n'est pas un niveau d'abstraction au sens de Rasmussen : c'est un masque.** /Pour en être un, elle doit AJOUTER quelque chose que les couches 1 et 2 ne disent pas — une information sur ce qui gouverne la composition de leurs éléments./ **Question à porter au chantier.** **Et la relation entre niveaux est un plusieurs-à-plusieurs** : « un but peut être servi par beaucoup de configurations physiques, et un système physique peut servir beaucoup de buts ».

#### ET LA RÈGLE DE DIRECTION — *causes vers le HAUT, raisons vers le BAS*

> « \*/Les CAUSES de fonctionnement impropre dépendent de changements dans le monde physique ou matériel. Elles sont donc expliquées de BAS EN HAUT dans les niveaux d'abstraction, tandis que les RAISONS d'un fonctionnement propre sont dérivées de HAUT EN BAS depuis le but fonctionnel./\* »

***DEUX SENS DE PARCOURS, DEUX OBJETS. Et cela range deux questions du dossier d'un coup.***

|  |  |  |
|----|----|----|
| ***message d'erreur*** — question 30 | ***bas en haut*** | c'est une CAUSE : partir du jeton, remonter le calcul du grade — et c'est exactement ce que Zhu et al. mesurent comme manquant dans 32 messages Rust sur 51 |
| ***découvrabilité*** — questions 43 à 46 | ***haut en bas*** | ce sont des RAISONS : partir de ce que la couche sert, descendre vers la forme |

***LE MESSAGE D'ERREUR ET LA DOCUMENTATION NE SE PARCOURENT PAS DANS LE MÊME SENS. Une seule présentation ne peut pas servir les deux.*** **Et le diagnosticien fait les deux à la fois** : /« il devra typiquement identifier les chemins de flux d'information et les états fonctionnels propres en argumentant DE HAUT EN BAS depuis le niveau de l'information symbolique, tandis qu'il emploiera des considérations DE BAS EN HAUT pour analyser et expliquer l'état fonctionnel réel à partir des causes physiques »./

#### ET LA CONCEPTION EST UNE ITÉRATION, NON UNE DESCENTE

« La conception de système est fondamentalement ***un processus d'ITÉRATION entre considérations aux divers niveaux, plutôt qu'une transformation ordonnée*** d'une description de but en une description en termes de forme physique. » /Avec la citation d'Alexander que Rasmussen retient : « toute forme peut être décrite de deux façons : du point de vue de ce qu'elle EST, et du point de vue de ce qu'elle FAIT. \[…\] \*/La solution d'un problème de conception n'est vraiment qu'un nouvel effort pour trouver une description UNIFIÉE/\* \[…\] un effort pour comprendre la forme requise si pleinement ***qu'il n'y ait plus de faille entre sa spécification fonctionnelle et la forme qu'elle prend***. »/ ***C'EST L'ALIGNEMENT DE CATÉGORIES DE SMITH, DIT PAR UN ARCHITECTE. Deux domaines sans rapport, même critère.***

### GRIS-Vicente

    AUTHORS | DATE | TITLE: VICENTE — LA TROISIÈME VOIE : NORMATIF, DESCRIPTIF, FORMATIF | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-WrightMathersEtWalton

    AUTHORS | DATE | TITLE: WRIGHT, MATHERS ET WALTON — l'interface écologique appliquée à une DÉCOUVERTE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-BennettEtHoffman

    AUTHORS | DATE | TITLE: BENNETT ET HOFFMAN — et l'avertissement est adressé à T-61 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LesQuatreNiveauxParOUnLangageDriveDUneLangue

    AUTHORS | DATE | TITLE: LES QUATRE NIVEAUX PAR OÙ UN LANGAGE DÉRIVE D'UNE LANGUE — et c'est la grille qui manquait | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LePige

    AUTHORS | DATE | TITLE: LE PIÈGE — traduire le lexique et garder la syntaxe ne change RIEN | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LesDeuxCasQuiChangentLaDonne

    AUTHORS | DATE | TITLE: LES DEUX CAS QUI CHANGENT LA DONNE — et ils réfutent chacun une évidence | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtLeCritreDeNaur

    AUTHORS | DATE | TITLE: ET LE CRITÈRE DE NAUR — l'ANALYTICITÉ, qui est la règle KISS dite en linguiste | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtLaConclusionNommeK7PlSansLeSavoir

    AUTHORS | DATE | TITLE: ET LA CONCLUSION NOMME K7PL SANS LE SAVOIR | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeBilletSurLesIndices

    AUTHORS | DATE | TITLE: LE BILLET SUR LES INDICES — 2024-11-25, et il donne un CRITÈRE D'ADMISSION MORPHOLOGIQUE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE MALAISE QUI A CONDUIT AU DISPOSITIF, ET C'EST UN DÉSALIGNEMENT DE CATÉGORIES

> « Dans un langage de tableaux, la structure et le rang d'un tableau sont, dans la plupart des cas, ***LA STRUCTURE DU CALCUL LUI-MÊME. Il y a quelque chose d'étrange à avoir dans son code certains nombres qui réfèrent à de véritables NOMBRES, et d'autres qui réfèrent au CALCUL.*** »

***DEUX ESPÈCES DE CHOSES PORTANT LE MÊME HABIT. C'est un désalignement de catégories au sens de Smith, formulé par un concepteur qui n'a pas lu Smith.*** **Et la résolution est MORPHOLOGIQUE** : /le nombre qui parle du calcul s'écrit dans un autre REGISTRE des mêmes signes — chiffres en indice au lieu de chiffres sur la ligne. `♭₂`, `≡₁`, `⊟₄`, `√₃`, `∩₃`./ ***C'EST LE CAS PERLIGATA DE MÉLÈS, DANS UN LANGAGE VIVANT : la MORPHOLOGIE porte ce que l'ordre des mots ou une parenthèse porterait ailleurs.***

#### LE CRITÈRE D'ADMISSION, ET IL EST EXACTEMENT CELUI DE K7PL

« Le fait est que ***vous n'avez JAMAIS besoin que ce nombre soit dynamique. C'est TOUJOURS un nombre posé là dans le code lui-même, une valeur STATIQUE, connue à la compilation.*** Parfois il devait être relatif au rang du tableau, auquel cas on employait un nombre négatif statique, mais une valeur statique néanmoins. » ***UNE VALEUR QUI NE PEUT PAS ÊTRE DYNAMIQUE REÇOIT UN REGISTRE NOTATIONNEL DISTINCT.*** **C'est la condition que P2 pose déjà sur les grades** — *« à la seule condition que cette valeur soit CLOSE À LA COMPILATION ».* **Le postulat énonce la condition ; Uiua en tire une conséquence notationnelle que le document n'a pas tirée.** *Question pour K7PL : le grade ⟨u, m, ℓ, β⟩ est statique par construction. Doit-il s'écrire dans le même registre que les valeurs, ou dans un registre à part ?* **À verser à la question 4 et à l'arbitrage sur `:propriété valeur`.**

#### ET L'ÉCHEC DOCUMENTÉ, QUI EST LE MODE DE DÉFAILLANCE DE LA QUESTION 3

/« La première tentative pour apaiser ce malaise fut la fameuse ***Ocean Notation***. C'était une série de glyphes ayant des règles d'analyse spéciales et dont la fonction était SEULEMENT de créer des listes de rangs. \[…\] »/

> « Quoique ce système fût plutôt joli, il ***AJOUTAIT TROP DE NOUVEAUX SYMBOLES À APPRENDRE POUR UN BÉNÉFICE TRÈS FAIBLE***, et il n'était ***pas assez GÉNÉRAL pour traiter tous les cas***. »

***DEUX CRITÈRES DE REJET, ÉNONCÉS APRÈS COUP PAR CELUI QUI A ESSAYÉ : le rapport symboles-appris / bénéfice, et la généralité.*** **À verser à la question 3, à côté des quatre grilles déjà réunies.** *C'est la seule pièce du dossier où un concepteur raconte un jeu de glyphes qu'il a introduit PUIS RETIRÉ.* **Et un détail de graphématique qui vise la question 41** : *« Uiua permet en fait depuis un moment les chiffres en indice dans les identifiants. ***Puisque les identifiants ne peuvent pas contenir de chiffres ordinaires***, cela permet d'y mettre des nombres tout de même » — `Md₅`, `Sha₂₅₆`.* ***UNE INTERDICTION SUR UN REGISTRE OUVRE UNE PLACE POUR UN AUTRE. C'est le mécanisme du préfixe `⎕` d'APL, appliqué aux chiffres au lieu des lettres.***

### GRIS-LeBilletSurLeSystmeDeTypes

    AUTHORS | DATE | TITLE: LE BILLET SUR LE SYSTÈME DE TYPES — 2026-08-01, et c'est la pièce la plus récente du dossier | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA DÉCISION CENTRALE — *la spécification de type EST UNE VALEUR DU LANGAGE*

> « \*/Comme tout le reste en Uiua, la spécification de type est simplement un TABLEAU. C'est ainsi que, bien qu'il faille savoir construire une spécification pour le type qu'on veut, on l'écrit tout de même en Uiua ORDINAIRE plutôt que dans un langage séparé./\* »

***PAS DE SOUS-LANGAGE DE TYPES. L'annotation est un terme du langage.*** **C'est une instance forte de l'alignement de catégories de Smith, et la question qu'elle pose à K7PL est directe** : *le grade ⟨u, m, ℓ, β⟩ est-il un TERME de K7PL, ou une notation à part ?* **Et le motif du refus est chiffré en fatigue** : « le système devient un fardeau à la fois pour l'usager, qui peut finir par ***ÉCRIRE PLUS DE CODE DE TYPE QUE DE CODE TOUT COURT***, et pour l'implémenteur, qui doit implanter un système de types complexe. »

#### ET L'ARGUMENT CONTRE L'INFÉRENCE PUISSANTE, QUI EST LE MEILLEUR DU LOT

> « Certains langages fortement typés comme OCaml ou TypeScript ont des systèmes de types très puissants qui peuvent déduire ÉNORMÉMENT pour vous. \[…\] Cependant, cela peut causer des problèmes quand, par exemple, le type de la valeur qu'une fonction retourne n'est pas celui qu'on croit. Cela peut alors ***REMONTER à travers plusieurs fonctions, et l'erreur de type qui en résulte se trouve ATTACHÉE À DU CODE TRÈS ÉLOIGNÉ DU VRAI PROBLÈME***. Alors les gens écrivent l'annotation même quand ils n'y sont pas strictement obligés. ***Mais s'ils écrivent les annotations de toute façon, à quoi bon avoir rendu le système de types si puissant au départ ?*** »

***L'INFÉRENCE DÉPLACE L'ERREUR LOIN DE SA CAUSE, ET L'ANNOTATION REVIENT PAR LA PORTE.*** **Trois résultats du lot du 10 août convergent ici, et c'est la troisième fois** :

|  |  |
|----|----|
| 1 | ***Zhu et al.*** — 32 messages Rust sur 51 manquent *les ÉTAPES du calcul*, non la règle |
| 2 | ***Green et Petre*** — l'abstraction crée des ***DÉPENDANCES CACHÉES*** : « il n'est pas clair où les abstractions sont instanciées, ni quelles seront les conséquences d'un changement » |
| 3 | ***Uiua*** — l'inférence attache l'erreur « à du code très éloigné du vrai problème » |

***UN MÊME MÉCANISME : CE QUI EST DÉDUIT AU LOIN SE SIGNALE AU LOIN. K7PL vérifie des grades ; il est exposé à cela exactement.***

#### ET LE DISPOSITIF QUI EN SORT — *le FORMATEUR ÉCRIT L'ANNOTATION*

« Le nouveau système de types d'Uiua peut déduire certains types d'arguments et de sortie, puis ***LES INSÉRER DANS LE CODE LUI-MÊME***, permettant à l'usager de vérifier la correction de sa fonction sans avoir à spécifier lui-même les types de retour. D'autres langages ont des implantations LSP qui offrent cela comme action de code, mais ***Uiua peut lui donner un support de PREMIÈRE CLASSE et l'intégrer étroitement dans le langage***. » /Le mécanisme : un commentaire qui commence par `#?` est un ***commentaire de signature de type*** ; le formateur le remplace par la signature de la fonction en dessous. La sortie est à gauche du `?`, les arguments à droite./ ***C'EST LE « NIVEAU DE DESCRIPTION » DE HENDRY ET GREEN, IMPLANTÉ — et il est BIDIRECTIONNEL : `⊨ validate` est l'ENTRÉE du vérificateur, le commentaire `#?` en est la SORTIE.*** **Et cela range la question 48 autrement qu'on ne l'avait posée** : /le formateur ne fait pas qu'indenter. Il ÉCRIT dans le code ce que le vérificateur a compris. La mise en page devient un canal de retour./ **Deux réserves que l'auteur pose lui-même, et il faut les garder** :

- « le typage d'Uiua est et sera toujours ***AU MIEUX*** — Uiua est un langage hautement dynamique, tout ne peut pas être vérifié complètement » ;
- « l'information de type ne peut circuler que vers l'**AVANT**, pas vers l'arrière. Sauf tout au début d'une fonction, ***les contraintes de type ne peuvent pas remonter pour informer les types d'arguments***. »

**Et l'aveu final, qui borne l'ambition** : « je laisse à quelqu'un d'autre la création d'un langage de tableaux ***entièrement typé statiquement***. » /K7PL est ce quelqu'un d'autre, et il faut le savoir : ce billet décrit une voie GRADUELLE, non la voie de K7PL. Ce qu'il apporte est la forme de l'ANNOTATION, non celle du système./ *Et la nature du vérificateur est nommée en une phrase, ce qui est utile pour l'arc théorique : « c'est une sorte de RUNTIME qui exécute le code sur des TYPES au lieu de valeurs concrètes ».*

#### ET LES VALIDATEURS DE CHAMP — *qui visent la forme `:propriété valeur`*

/Une définition de données peut porter une fonction de validation par champ, « appelée à la fois à la construction (après l'initialiseur) et à la MUTATION », placée « après le nom et un `:`, mais avant l'initialiseur » — `~MyData {Foo: °0type|Bar: °1type}`./ ***UN DEUX-POINTS SÉPARE LE NOM DE SA CONTRAINTE, ET LA CONTRAINTE EST UNE FONCTION ORDINAIRE.*** **À rapprocher de la forme retenue par Anthea** : /~:propriété valeur~ instruit une propriété ; ici `nom: validateur ← initialiseur` instruit une propriété ET la fait vérifier. Le même signe, deux charges — c'est la question 4 posée sur un cas concret./

### GRIS-LOrdreLexical

    AUTHORS | DATE | TITLE: L'ORDRE LEXICAL — et c'est la question 48 rendue SÉMANTIQUE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LE PROBLÈME EST UNE MÉSINFORMATION AU SENS DE GIBSON

/Dans un « paquet de fonctions » écrit sur plusieurs lignes, « bien que `÷` soit sur la DERNIÈRE ligne du paquet, son résultat est SOUS les résultats de toutes les autres », parce que la forme repliée `⊃(+|-|×|÷)` doit faire la même chose./

> « ***Le premier exemple semble à l'envers ! La fonction qui est plus BAS dans la source s'exécute en PREMIER, si bien que pour lire dans l'ordre d'exécution il faut lire de BAS EN HAUT.*** »

***LA MISE EN PAGE SPÉCIFIE UN ORDRE QUI N'EST PAS L'ORDRE. C'est exactement la falaise recouverte de verre : l'information est captée, et elle est fausse.***

#### ET LE REMÈDE EST UN SIGNE QUI CHANGE CE QUI GOUVERNE

*« Pour résoudre cela, on peut préfixer le paquet d'un symbole `↓`, qui se formate depuis `|,` ».*

> « ***Un paquet muni d'un `↓` IGNORE l'ordre de l'arbre syntaxique et ne considère QUE LA DISPOSITION DU CODE DANS LA SOURCE RÉELLE.*** Ce genre de paquet est dit ***LEXICALEMENT ORDONNÉ***. »

***UN LANGAGE OÙ LA MISE EN PAGE EST SÉMANTIQUEMENT PORTANTE, PAR MARQUE EXPLICITE DU SCRIPTEUR.*** **La question 48 demandait si la mise en page est un objet de conception. Voici un langage où elle est un objet de SÉMANTIQUE, sur adhésion.** *Et l'auteur note honnêtement le prix : « replier ce code CHANGE son comportement ».* ***C'EST LA DOUBLE LECTURE D'IVERSON — analytique de gauche à droite, constructive de droite à gauche — TRANSFORMÉE EN CHOIX QUE LE SCRIPTEUR MARQUE.*** **Et cela vaut aussi pour la notation de tableau en pile, où `↓` fait lire les lignes de haut en bas au lieu de bas en haut.** **Pour K7PL, la question est neuve et elle est nette** : /les délimiteurs de couche marquent où le fragment change. Un signe pourrait-il marquer, de la même façon, que la disposition d'un bloc est PORTANTE plutôt qu'ornementale ?/

### GRIS-EtDeuxNotesDeMiseJour

    AUTHORS | DATE | TITLE: ET DEUX NOTES DE MISE À JOUR — la page de conception a CHANGÉ depuis la lecture du 9 août | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaDcisionEtElleEstP1

    AUTHORS | DATE | TITLE: LA DÉCISION, ET ELLE EST P-1 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] MOTIF 3 — *et c'est la QUATRIÈME formulation du même mécanisme dans ce lot*

> « Avec la curryfication, écrire `(f 1 2)` au lieu de `(f 1 2 3)` ***produit SILENCIEUSEMENT une application partielle***. Le compilateur infère joyeusement un type de fonction `:s -> :t` et poursuit. \*/La vraie erreur ne fait surface que PLUS TARD, quand cette valeur fonctionnelle inattendue entre enfin en conflit avec un type incompatible — SOUVENT LOIN DE LA VÉRITABLE FAUTE./\* Avec l'arité fixe, un argument manquant est attrapé ***là où il se produit***. »

|  |  |
|----|----|
| 1 | ***Zhu et al.*** — 32 messages Rust sur 51 manquent les ÉTAPES du calcul |
| 2 | ***Green et Petre*** — l'abstraction crée des DÉPENDANCES CACHÉES : « il n'est pas clair où les abstractions sont instanciées » |
| 3 | ***Uiua*** — l'inférence puissante attache l'erreur « à du code très éloigné du vrai problème » |
| 4 | ***COALTON*** — la curryfication fait surgir l'erreur loin de l'argument omis |

***QUATRE LITTÉRATURES, QUATRE MÉCANISMES DIFFÉRENTS, UN SEUL EFFET : CE QUI EST DÉDUIT AU LOIN SE SIGNALE AU LOIN.*** **Et le quatrième porte sur l'ARITÉ, donc directement sur P-1.** /Lochbaum disait que la surcharge de valence détruit le SENS d'une occurrence ; Coalton dit que la curryfication détruit la LOCALITÉ de l'erreur. Ce sont deux propriétés distinctes, et l'arité fixe achète les deux./

#### ET LE CHIFFRE, QUI EST UNE FALSIFICATION MESURÉE

> « Nous pensons que c'est un bon changement pour la raison simple que voici : quand nous avons basculé l'interrupteur pour activer ce nouveau style de fonction, \*/99 % DU CODE A COMPILÉ SANS PROBLÈME, SEULES LES SIGNATURES DE TYPE ONT CASSÉ. Cela signifie que le style curryfié n'était même pas tellement EMPLOYÉ/\*, et là où il l'était, il n'a fallu qu'une poignée de caractères pour corriger. »

***UN LANGAGE RETIRE LE TRAIT QUI FAISAIT SON IDENTITÉ, ET 99 % DU CODE NE S'EN APERÇOIT PAS.*** **C'est le résultat le plus utile que T-61 ait reçu, et il est d'une espèce rare** : /non pas « ce trait est-il bon ? » mais « ce trait est-il EMPLOYÉ ? ». La question se mesure, et la réponse peut être « presque pas », y compris pour un trait dont les concepteurs faisaient l'argument de vente principal./ **À rapprocher du résultat T-63 sur Ruby** — *« les contournements existent, mais ils sont tous non idiomatiques et personne ne les emploie ».* **Même forme, sens inverse : ici c'est la FONCTIONNALITÉ VANTÉE qui n'était pas employée.**

#### LES TROIS AUTRES MOTIFS, ET CHACUN TOUCHE UNE POSITION

|  |  |
|----|----|
| 1 | ***LA CONCEPTION D'API*** — « avec la curryfication, les API étaient conçues autour de ce qu'il était le plus commode d'appliquer PARTIELLEMENT, même si cela allait contre les tendances générales. Par exemple, pour obtenir le `n`-ième élément d'une liste `l`, on écrivait `(index n l)` parce que curryfier l'INDICE est plus utile que curryfier la LISTE. Mais tous les autres langages écrivent `l[n]`, `l.get(n)`, `(elt l n)`. ***L'arité fixe libère la conception d'API de ces contraintes.*** » — ***UN TRAIT DE CALCUL A DÉFORMÉ L'ORDRE DES ARGUMENTS DE TOUTE LA BIBLIOTHÈQUE. C'est pour P-3 et pour la question 2.*** |
| 2 | ***L'ALLOCATION IMPLICITE*** — « faire de l'allocation en tas un trait INTÉGRÉ de CHAQUE définition de fonction poussait le langage dans une direction que nous ne voulions pas. L'arité fixe n'empêche pas d'allouer des fermetures avec `fn`, mais ***cela devient EXPLICITE***. » — ***Pour la sédimentation : la curryfication est une allocation cachée.*** |
| 4 | ***UN FONDEMENT POUR DES CONVENTIONS D'APPEL PLUS RICHES*** — « arguments optionnels, arguments nommés, et de nouvelles conventions d'appel deviennent tous simples avec l'arité fixe ». |

***LE QUATRIÈME MOTIF EST CELUI QUI VISE ANTHEA : les arguments NOMMÉS sont DÉBLOQUÉS par l'arité fixe.*** *Coalton écrit désormais `(define (open path &key (direction Input) (if-exists EError)) …)`, appelable `(open "data.csv" :direction Output :if-exists Supersede)`.* **C'est la forme `:propriété valeur`, dans un langage qui vient de l'obtenir, et par le même chemin : P-1 d'abord, la forme ensuite.** /Question 4 : la coexistence de `:propriété valeur` avec les arguments positionnels n'est pas une complication ajoutée, c'est ce que l'arité fixe rend disponible./

### GRIS-EtQuatreAutresPointsQuiServentAilleurs

    AUTHORS | DATE | TITLE: ET QUATRE AUTRES POINTS QUI SERVENT AILLEURS | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeRsultatConnuEtSaFormulationExacte

    AUTHORS | DATE | TITLE: LE RÉSULTAT CONNU, ET SA FORMULATION EXACTE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeTroisimeApportEtCEstUnAvertissementChiffrP

    AUTHORS | DATE | TITLE: LE TROISIÈME APPORT, ET C'EST UN AVERTISSEMENT CHIFFRÉ POUR LE PROTOCOLE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtLesRsultatsDeDtailQuiVisentP3EtLaQuestion4

    AUTHORS | DATE | TITLE: ET LES RÉSULTATS DE DÉTAIL, QUI VISENT P-3 ET LA QUESTION 41 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaFalsificationEtElleEstConfirmeDansSaLettre

    AUTHORS | DATE | TITLE: LA FALSIFICATION, ET ELLE EST CONFIRMÉE DANS SA LETTRE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-MaisLeMmeCorpusProduitDesGriefsSyntaxiquesPr

    AUTHORS | DATE | TITLE: MAIS LE MÊME CORPUS PRODUIT DES GRIEFS SYNTAXIQUES PRÉCIS, ET C'EST LÀ QUE ÇA DEVIENT UTILE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtLaRsolutionDeLaContradictionEstLeRsultatPr

    AUTHORS | DATE | TITLE: ET LA RÉSOLUTION DE LA CONTRADICTION EST LE RÉSULTAT PRINCIPAL DU GROUPE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtDeuxRelevsIsolsQuiServentAilleurs

    AUTHORS | DATE | TITLE: ET DEUX RELEVÉS ISOLÉS QUI SERVENT AILLEURS | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-EtCeQueLeGroupeNAPasDonnEtQuIlFautDire

    AUTHORS | DATE | TITLE: ET CE QUE LE GROUPE N'A PAS DONNÉ, ET QU'IL FAUT DIRE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-CeQueDitLUniqueCommentaire

    AUTHORS | DATE | TITLE: CE QUE DIT L'UNIQUE COMMENTAIRE — lojikil, 3 approbations | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] IL RANGE LA PROPOSITION DANS UNE SÉRIE, ET LA SÉRIE EST LONGUE

« Il y a eu quelques SRFI différentes du genre expressions douces, ***SRFI-49*** étant l'une d'elles. Il y a aussi divers dialectes de Scheme qui ont fini par se muer en des choses comme ***Dylan***, et des variantes intermédiaires (comme le système Marlais Dylan, qui était du Dylan d'avant les D-Exprs). Divers Scheme ont également inclus des ***syntaxes ALTERNATIVES*** : `six` dans ***Gambit-C*** me vient immédiatement à l'esprit. ***Bigloo*** a même eu une syntaxe à la ML pendant un temps, quoique cela soit vite mort — ***on pouvait suivre et s'en créer une***. » ***CINQ TENTATIVES NOMMÉES, ET UNE SEULE A SURVÉCU EN CHANGEANT DE LANGAGE — Dylan.*** **C'est la réponse la plus complète que le dossier ait obtenue à la question de l'adoption d'une notation alternative dans une communauté Lisp.** /Elle est négative, elle est donnée par quelqu'un qui a lui-même écrit deux implantations de Scheme, et elle est donnée sans acrimonie — comme un fait d'histoire./ **Et la clause finale est celle qui pèse** : /« on pouvait suivre et s'en créer une ». Une syntaxe alternative dans un Lisp est SI FACILE À CONSTRUIRE que sa construction ne prouve rien sur son adoption./ ***C'EST LE COÛT D'ENTRÉE NUL QUI EXPLIQUE LE TAUX DE SURVIE NUL : quand tout le monde peut en faire une, personne n'a de raison d'adopter celle d'un autre.*** **À verser à P-2 comme pression de falsification.** /K7PL propose une paire glyphe/alias. Dans un langage à macros de bibliothèque, cette paire est reproductible par n'importe qui. Ce qui la fera tenir n'est donc pas sa qualité mais son statut — et le document doit dire lequel./

#### ET LE DIAGNOSTIC SUR LA COMMUNAUTÉ, PAR QUELQU'UN QUI EN VIENT

> « ***J'ai été programmeur Scheme professionnel pendant longtemps, j'ai même écrit PLUSIEURS IMPLANTATIONS. Cependant, je pense que son heure est largement passée*** ; je veux dire, R7RS-large est… un document markdown de votes des comités de pilotage ? ***La division R6RS a plutôt blessé le langage, et je ne pense pas qu'il s'en soit jamais vraiment remis*** (mais ce n'est peut-être que le point de vue d'un vieux). »

***UN PRATICIEN QUI A ÉCRIT DEUX IMPLANTATIONS DÉCLARE QUE LE LANGAGE EST PASSÉ, ET ATTRIBUE LA CAUSE À UNE DIVISION DE NORMALISATION.*** **Cela ne juge pas Scheme ; cela renseigne sur ce qu'une COMMUNAUTÉ peut faire à une notation.** *Le dossier avait déjà, par T-63, la thèse que la création de langages suit la disponibilité des OUTILS. Voici la thèse jumelle du côté de la mort : elle suit la disponibilité d'un ACCORD.* **Et la réserve que l'auteur pose lui-même — « ce n'est peut-être que le point de vue d'un vieux » — est la marque de fiabilité que le protocole de veille demande.**

### GRIS-CeQueLeRsiduDevient

    AUTHORS | DATE | TITLE: CE QUE LE RÉSIDU DEVIENT | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LesSixRaisons

    AUTHORS | DATE | TITLE: LES SIX RAISONS — et c'est une GRILLE D'ÉVALUATION, pas une liste d'éloges | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaRaison1EstLaPlusImportanteEtK7PlNAPasDePrc

    AUTHORS | DATE | TITLE: LA RAISON (1) EST LA PLUS IMPORTANTE, ET K7PL N'A PAS DE PRÉCÉDENCE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaRaison3ContreditLArbitrage2DeFront

    AUTHORS | DATE | TITLE: LA RAISON (3) CONTREDIT L'ARBITRAGE 2 DE FRONT — et le délimiteur la sauve | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-Le2TrainEstTranchParLHistoireEtLeMotifEstUnC

    AUTHORS | DATE | TITLE: LE 2-TRAIN EST TRANCHÉ PAR L'HISTOIRE, ET LE MOTIF EST UN CRITÈRE D'ANALYSE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaHirarchie

    AUTHORS | DATE | TITLE: LA HIÉRARCHIE — un DAG de spécialisations, et il PRÉDIT des combinateurs manquants | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] LA STRUCTURE

*Les combinateurs ne sont pas une liste : ils forment un graphe orienté acyclique, ordonné par SPÉCIALISATION. Trois espèces d'arête, que l'auteur distingue par le trait :*

|                         |                                            |
|-------------------------|--------------------------------------------|
| ***trait plein***       | deux termes lambda posés égaux             |
| ***trait tireté***      | un terme lambda posé égal au combinateur I |
| ***trait tireté gras*** | deux termes posés égaux à I                |

**Et les spécialisations elles-mêmes** :

|                                                       |
|-------------------------------------------------------|
| Φ est une spécialisation de D₂ avec `d = e`           |
| D est une spécialisation de D₂ avec `b = I`           |
| Ψ est une spécialisation de D₂ avec `b = c`           |
| S est une spécialisation de Φ avec `b = I`            |
| S est une spécialisation de D avec `b = d`            |
| W est une spécialisation de S avec `b = I`            |
| W est une spécialisation de Ψ avec `b = I` et `c = d` |

***D₂ EST LA RACINE, ET LES AUTRES EN DESCENDENT. `λabcde.a(bd)(ce)` engendre tout le reste par identification de variables.***

#### CE QUE LA HIÉRARCHIE PRODUIT, ET C'EST UN RÉSULTAT ORIGINAL

*En cherchant à réaliser « toutes les combinaisons d'une fonction unaire et d'une binaire », l'auteur constate que « ***il manque des combinateurs à la littérature de logique combinatoire*** » — et il en nomme quatre : ***Δ***, ***Σ***, ***H₁*** et ***H₂***.* **Δ et Σ sont les frères de D et S** : *« D et S sont les spécialisations de D₂ et Φ où l'argument fonctionnel DROIT est posé égal à I ; Δ et Σ sont celles où c'est l'argument GAUCHE ».* ***UNE ASYMÉTRIE DANS LA LITTÉRATURE DEPUIS 1924, RÉVÉLÉE PAR L'EXIGENCE DE COMPLÉTUDE D'UNE IMPLANTATION. Et « tous les combinateurs \[manquants\] peuvent s'écrire en BQN ».*** **ET LA HIÉRARCHIE DÉTECTE UNE ERREUR DE CONCEPTION DANS BQN** : *« B₁ et Ψ — *atop* et *over* — ont choisi le combinateur B pour sens monadique, ce qui fait ***DEUX manières d'écrire un même combinateur***. Cela ressemble bien à un oubli, alors qu'on aurait pu prendre H₂ comme sens monadique de *over*, ce qui aurait non seulement donné une écriture à un combinateur manquant, mais rendu *over* plus cohérent avec *before* et *after*. »* ***UN GRAPHE DE SPÉCIALISATIONS EMPLOYÉ COMME INSTRUMENT DE CONTRÔLE D'UN JEU DE GLYPHES : il détecte les doublons et les trous.*** **C'est un outil directement transposable à la question 3, et c'est le seul du dossier qui soit CONSTRUCTIF plutôt que restrictif.** /Les quatre grilles réunies jusqu'ici — fréquence, non- perturbation, sept critères d'Uiua, heuristique de k — disent toutes ce qu'il faut REFUSER. Le DAG dit ce qui MANQUE./

#### ET UNE SYMÉTRIE QUI RÉDUIT LE COMPTE DE SIGNES

/« Ψ et B₁ sont “opposés” ou ***SYMÉTRIQUES EN ARITÉ***. Pour Ψ, `f` est la fonction binaire et `g` l'unaire ; pour B₁ c'est l'inverse. Ψ applique l'unaire d'abord aux deux arguments, puis la binaire ; B₁ applique la binaire d'abord, puis l'unaire. »/ ***DEUX COMBINATEURS DISTINGUÉS PAR LA SEULE ARITÉ DE LEURS OPÉRANDES PEUVENT PARTAGER UN SIGNE.***

### GRIS-EtLeRsultatQuiViseP1

    AUTHORS | DATE | TITLE: ET LE RÉSULTAT QUI VISE P-1 — l'arité fixe permet ce que la surcharge de valence INTERDIT | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LeCotDeLaVoieNommeMesur

    AUTHORS | DATE | TITLE: LE COÛT DE LA VOIE NOMMÉE, MESURÉ — et il vise P-2 et la question 31 | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-UnDernierRelevQuiRangeLaLittrature

    AUTHORS | DATE | TITLE: UN DERNIER RELEVÉ, QUI RANGE LA LITTÉRATURE | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-LaRgleDeConduiteEnQuatrePoints

    AUTHORS | DATE | TITLE: La règle de conduite, en quatre points | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout

### GRIS-OChercherQuestionParQuestion

    AUTHORS | DATE | TITLE: Où chercher, question par question — les cibles concrètes | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Pour T-61 — l'élégance, et ses neuf cases

*L'élégance a trois lieux et trois échéances ; il manque des cas pour six d'entre elles.*

- **fils de discussion sur des langages admirés et peu employés** — Ada, Smalltalk, Forth, Rebol, APL. ***Le patron à chercher est celui qui a payé la fiche Ruby*** : quelqu'un qui l'a aimé, l'a employé longtemps, et dit ce qui a cédé ;
- **le critère de réimplémentabilité**, apparu trois fois et jamais instruit — chercher des cas où quelqu'un a réellement réimplémenté un langage, et ce qu'il en a dit ;
- **les notes par langage du témoin des cent langages**, qui existent une par entrée et ne sont pas lues. ***C'est le gisement le mieux identifié et le moins coûteux.***

#### Pour P-4 et T-60 — l'ergonomie, et c'est le groupe le plus faible

*Les groupes E et F du recueil Reddit — apprentissage, découragement, regard extérieur — ne sont toujours pas dépouillés, et ce sont ceux qui servent la thèse d'Anthea.*

- **les messages d'erreur** — question 30. Chercher des discussions sur les diagnostics de compilateurs à discipline forte : ce que les gens disent des messages du vérificateur d'emprunt, de ceux d'un typeur Hindley-Milner, de ceux d'un solveur ;
- **l'amorçage** — question 25. Comment un lecteur neuf apprend qu'il existe plusieurs régimes dans une source. *Aucune source n'a encore traité cela de front.*

#### Pour les questions de mémoire — 32 et 33

- **ce que devient la copie de confort dans les langages à propriété** : chercher des mesures ou des témoignages sur la fréquence de `clone` dans des bases Rust réelles. ***Question 32 demande un chiffre, et il existe peut-être.***
- **Bone Lisp**, seule entrée manquante de l'ordre arrêté de T-57.

#### Pour la falsification d'arc — *qui reste ouverte, et c'est la plus importante*

L'état actuel : affaiblie par deux cas où une notation est tenue pour la cause d'un dommage — `char a[..]` chez matklad, les espaces du Fortran — et par le cas Futhark, où l'absence d'une syntaxe bloque une fonctionnalité. **Renforcée par Joswig, par le témoin des cent langages, et par l'argument « cent fois l'écosystème contre un impact négligeable du typage ».** *Ce qui trancherait* : **des cas où un changement de NOTATION SEULE, à sémantique constante, a produit un effet mesuré.** ***C'est la seule chose qui manque, et c'est la seule qui compterait.* À chercher explicitement, plutôt qu'à espérer croiser.**

### GRIS-PrcautionRepriseDeLEntreDeTravauxEtConfirmeP

    AUTHORS | DATE | TITLE: Précaution, reprise de l'entrée de travaux et confirmée par le dépouillement | REVUE: littérature grise | IDENTIFIANT: sans identifiant bibliographique | REF.BIB: nil | RDF: nil | PDF: t | LU: t | A-CITER-SUR: non citable — sert l'instruction, pas la démonstration | SYNTHESE: t

#### \[DONE\] Fiche sans sous-titre — le chapeau porte tout
