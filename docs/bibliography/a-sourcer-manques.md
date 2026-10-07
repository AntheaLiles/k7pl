# SOURÇAGE DES MANQUES DE CORPUS

Établi le 31 août 2026 sur les seize entrées de `meta/manques.org`.
Les identifiants marqués **✓vérifié** ont été confirmés en ligne le jour même ; les autres sont donnés
de mémoire et portent leur réserve.

---

## A. LES MANQUES QUI BLOQUENT UN ENGAGEMENT

### A1 — La cohérence au sens de Kelly et Mac Lane · *arc A, engagement 1 sur 8*

La pièce fondatrice, et elle est exactement celle que le document invoque.

| | |
|---|---|
| **Auteurs** | G. M. Kelly, Saunders Mac Lane |
| **Titre** | Coherence in closed categories |
| **Revue** | Journal of Pure and Applied Algebra 1(1), 1971, p. 97–140 |
| **DOI** | `10.1016/0022-4049(71)90013-2` **✓vérifié** |

L'erratum, à verser avec — le théorème d'origine y est corrigé, et citer le premier sans le second est
une faute courante :

| | |
|---|---|
| **Titre** | Erratum to « Coherence in closed categories » |
| **Revue** | Journal of Pure and Applied Algebra 1(2), 1971, p. 219 |
| **DOI** | `10.1016/0022-4049(71)90019-3` *(de mémoire)* |

**Ce que cela ne couvre pas.** Le vrai besoin du document est la cohérence pour une structure
**graduée**, et cette pièce traite le cas clos ordinaire. Elle ferme la moitié de l'engagement — la
partie classique — et laisse ouverte la partie qui compte. À verser quand même : un engagement dont
la moitié classique n'est pas sourcée n'est pas défendable du tout.

---

### A2 — Le transport de la préservation des points fixes à un cadre gradué · *arcs A et B*

La pièce est récente, elle est exactement sur le sujet, et je ne la connaissais pas au moment où le
manque a été écrit.

| | |
|---|---|
| **Auteurs** | Georgi Nakov, Fredrik Nordvall Forsberg |
| **Titre** | Quantitative Polynomial Functors |
| **Publication** | TYPES 2021, LIPIcs vol. 239, p. 10:1–10:22 |
| **DOI** | `10.4230/LIPIcs.TYPES.2021.10` **✓vérifié** |

Elle traite les **conteneurs et foncteurs polynomiaux en théorie quantitative des types**, donne la
sémantique par **algèbre initiale** des types inductifs **en présence de linéarité**, et montre que le
raisonnement par induction y est supporté et **équivalent à l'initialité**. Formalisations en Idris 2.

**C'est le manque, entièrement.** La question était de savoir si la chaîne « les conteneurs préservent
les points fixes » survit à la gradation ; cette pièce l'établit du côté inductif.

Deux pièces voisines relevées au passage, à verser aussi :

| Titre | Identifiant |
|---|---|
| Quantitative Polynomial Functors (Early Ideas) | `10.4230/LIPIcs.CALCO.2021.22` |
| Formalising Inductive and Coinductive Containers | `10.4230/LIPIcs.ITP.2025.17` |

La seconde est le **versant coinductif**, et elle est en 2025 — donc postérieure au dépouillage de
`damatoFormalisingInductiveCoinductive2024` que l'arc A avait conduit. À comparer.

---

### A3 — La coinduction en LEAN · *arc K, manque requalifié*

La pièce de référence pour ce que Lean sait faire des types coinductifs.

| | |
|---|---|
| **Auteurs** | Jeremy Avigad, Mario Carneiro, Simon Hudon |
| **Titre** | Data Types as Quotients of Polynomial Functors |
| **Publication** | ITP 2019, LIPIcs vol. 141, p. 6:1–6:19 |
| **DOI** | `10.4230/LIPIcs.ITP.2019.6` **✓vérifié** |
| **Code** | https://github.com/avigad/qpf |

Elle établit qu'une large classe de types de données — **imbrications arbitraires de types inductifs,
de types COINDUCTIFS et de quotients** — se représente comme quotients de foncteurs polynomiaux, avec
formalisation **en Lean**. C'est la voie qui existe, et c'est précisément la voie par quotient que le
manque anticipait comme coûteuse : elle est déjà construite, et elle est dans Mathlib.

**Effet sur le manque** : il passe d'ouvert à *instruit* dès la lecture. Ce qui restera à établir est le
coût du passage par quotient pour la bisimulation, non l'existence du dispositif.

---

## B. LES MANQUES QUI BLOQUENT UN POINT DE CONTRÔLE

### B1 — Le temps d'exécution au pire cas · *arc I, point de contrôle G-06*

L'état de l'art, et il fait autorité depuis vingt ans.

| | |
|---|---|
| **Auteurs** | Reinhard Wilhelm, Jakob Engblom, Andreas Ermedahl, Niklas Holsti, Stephan Thesing, David Whalley, Guillem Bernat, Christian Ferdinand, Reinhold Heckmann, Tulika Mitra, Frank Mueller, Isabelle Puaut, Peter Puschner, Jan Staschulat, Per Stenström |
| **Titre** | The worst-case execution-time problem — overview of methods and survey of tools |
| **Revue** | ACM Transactions on Embedded Computing Systems 7(3), 2008, article 36, p. 1–53 |
| **DOI** | `10.1145/1347375.1347389` **✓vérifié** |

C'est le manque le plus sérieux de l'arc I : il porte sur un engagement chiffré, et la voie empirique
de repli est fermée par un résultat de l'arc F. Cette pièce donne les **méthodes** et l'**inventaire des
outils** ; elle ne donne pas de modèle matériel prêt à l'emploi, mais elle dit lesquels existent.

---

### B2 — La compilation reproductible · *arc I*

| | |
|---|---|
| **Auteurs** | Chris Lamb, Stefano Zacchiroli |
| **Titre** | Reproducible Builds: Increasing the Integrity of Software Supply Chains |
| **Revue** | IEEE Software 39(2), mars–avril 2022 |
| **DOI** | `10.1109/MS.2021.3073045` **✓vérifié** |
| **Préprint libre** | arXiv:2104.06020 |
| **Projet** | https://reproducible-builds.org/ |

Prix du meilleur article IEEE Software 2022. Elle définit le problème, donne le critère — *chaque
construction produit un résultat identique bit à bit* — et rapporte l'expérience de rendre une
distribution entière reproductible. C'est exactement ce que l'engagement « visé, non garanti » du
document demande de chiffrer.

---

### B3 — Les capacités matérielles · *arc J, et l'alternative laissée ouverte à l'arc E*

| | |
|---|---|
| **Auteurs** | Robert N. M. Watson, Jonathan Woodruff, Peter G. Neumann, Simon W. Moore, Jonathan Anderson, David Chisnall, Nirav Dave, Brooks Davis, Khilan Gudka, Ben Laurie, Steven J. Murdoch, Robert Norton, Michael Roe, Stacey Son, Munraj Vadera |
| **Titre** | CHERI: A Hybrid Capability-System Architecture for Scalable Software Compartmentalization |
| **Publication** | IEEE Symposium on Security and Privacy 2015, p. 20–37 |
| **DOI** | `10.1109/SP.2015.9` **✓vérifié** |

Le versant formel, à verser avec — c'est celui qui tranche l'homonymie :

| | |
|---|---|
| **Auteurs** | Kyndylan Nienhuis, Alexandre Joannou, Thomas Bauereiss, Anthony Fox, Michael Roe, Brian Campbell, Matthew Naylor, Robert Norton, Simon Moore, Peter Neumann, Ian Stark, Robert Watson, Peter Sewell |
| **Titre** | Rigorous engineering for hardware security: formal modelling and proof in the CHERI design and implementation process |
| **Publication** | IEEE Symposium on Security and Privacy 2020 |
| **DOI** | `10.1109/SP40000.2020.00055` *(de mémoire)* |

**Ce que cela décidera.** L'arc E a établi qu'une source fait tenir la non-duplicabilité d'une capacité
par le **matériel** là où K7PL la fait tenir par le **typage**. L'alternative — support matériel, ou
enveloppement dynamique au point de sortie — ne se tranche pas sans savoir ce que le matériel garantit
réellement, et la seconde pièce le dit formellement.

---

## C. LE MANQUE QUI VISE LE PARI LE PLUS EXPOSÉ

### C1 — BQN et Uiua · *arc G, temps 3 de la méthode*

**Aucun des deux n'a de publication évaluée par les pairs.** C'est un fait sur le domaine, non une
lacune du fonds, et il faut l'écrire comme tel : le chapitre 5 fonde sa notation tacite sur trois
langages dont **deux n'ont pas de littérature**.

| Langage | Auteur | Ce qui existe | URL |
|---|---|---|---|
| **BQN** | Marshall Lochbaum | Spécification et documentation de référence, tenues par l'auteur | https://mlochbaum.github.io/BQN/ — spéc. : https://mlochbaum.github.io/BQN/spec/ |
| **Uiua** | Kai Schmidt | Documentation de référence et tour du langage | https://www.uiua.org/docs |

**Conséquence de méthode.** Le temps 3 — *collecter les noms employés par les langages du corpus* — est
conduisible pour sept catégories sur neuf. Pour ces deux-là, la collecte se fera sur la **documentation
de référence**, qui est une source primaire mais non évaluée. C'est acceptable pour relever un
vocabulaire ; ce ne le serait pas pour appuyer une affirmation empirique.

À verser dans Zotero comme **documents web datés**, avec la date de consultation, et à marquer
`LU: nil` jusqu'à dépouillage.

---

## D. CE QUI N'EST PAS UN MANQUE DE CORPUS

Quatre entrées de `manques.org` sont des **manques de LECTURE** et se referment sans rien sourcer.
Le fonds a la pièce et son PDF.

| Entrée | Pièce au fonds | Question bloquée |
|---|---|---|
| Les hypothèses de Benton empruntées par c2 | `bentonLinearLcalculusCategorical1993` | QA-6 |
| La règle d'élimination du diamant | `dasParallelComplexityAnalysis` | correction de la règle `When` |
| Quel foncteur donne l'étage à pile | `AutomataAlgebrasCategories` *(Adámek et Trnková)*, `loregianAutomataCoalgebrasCategories2024` | QC-1, close par ailleurs |
| La planarité | `polakowNaturalDeductionIntuitionistic1999` — **manque levé**, reste un arbitrage | QC-4, close |

---

## E. UNE CORRECTION À PORTER

### Les formats colonnaires ne manquent pas · *arc I*

J'ai déclaré ce manque il y a une heure en sondant le registre des PDF de Zotero. **Les trois
spécifications sont au corpus**, avec leur PDF et leur URL, dans la section des documents segmentés :

| Clé | Document | URL |
|---|---|---|
| `SEG-arrowArrowColumnarFormat2024` | Arrow Columnar Format v1.5 | https://arrow.apache.org/docs/format/Columnar.html |
| `SEG-vardaProtoDocumentationSchema2024` | Cap'n Proto — schéma, encodage, RPC | https://capnproto.org/ |
| `SEG-communitySimpleBinaryEncoding2020` | Simple Binary Encoding v1.0 | https://www.fixtrading.org/standards/sbe/ |

Toutes trois dans `corpus/formats-arrow-capnproto-sbe.txt`, non importées dans Zotero et non
dépouillées. **Quatrième occurrence de la sonde incomplète**, quatrième cause : le mauvais inventaire.
Le manque est retiré ; ce qui reste est un dépouillage.

---

## F. UNE PIÈCE TROUVÉE EN CHEMIN, ET ELLE ROUVRE UNE QUESTION CLOSE

| | |
|---|---|
| **Titre** | Dependent Multiplicities in Dependent Linear Type Theory |
| **arXiv** | `arXiv:2507.08759` |

L'arc B a clos **QB-19** — *les multiplicités dépendantes sont-elles hors périmètre par choix ou par
impossibilité ?* — en concluant : *par frontière non ouverte, les grades de première classe étant
un travail à venir*. Cette pièce est datée de 2025 et son titre annonce précisément l'objet.

**À lire avant de considérer QB-19 comme close.** Une question fermée sur « personne ne l'a fait » se
rouvre dès que quelqu'un l'a fait.
