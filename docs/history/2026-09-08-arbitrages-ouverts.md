# Ce qui te revient — le volet unique d'arbitrages

> Archivé le 2026-10-01 : ce document décrit l'état du 8 septembre 2026 et a été remplacé par [le tableau de bord](../tracking/DASHBOARD.md). Il est conservé pour la trace, tel qu'écrit alors ; les noms de fichiers et les commandes qu'il cite désignent l'ancien arbre de travail (Org-mode).

8 septembre 2026, **rendu le soir même**. Sept décisions.

| | Décision | État |
|---|---|---|
| **A** | La contrainte manquante de ◇ | **A1 rendu** — introduire la duale |
| **B** | La forme des règles de ν | analyse rendue, décision attendue |
| **C** | Les 28 légendes muettes | **C3 rendu** — en faire de vrais flottants |
| **D** | Le lectorat | **rendu** — le pair qui évalue et tente de reproduire |
| **E** | Les engagements | **rendu** — valider par la littérature, sinon démontrer |
| **F** | Le modèle concret de /C/ | analyse rendue, décision attendue |
| **G** | Les entrées empiriques | à distinguer de l'arc G, qui est clos |

Le détail de chaque décision suit, et l'analyse coût-risque-opportunité de B et
de F est dans `ANALYSE-B-ET-F.md`.

---

## A — La contrainte manquante de l'élimination du diamant *(bloquant)*

**Le fait.** La règle `When` est trop permissive. Elle admet un contexte dont
une liaison porte une borne temporelle stricte, alors que l'attente peut la
dépasser : la conclusion promet une borne que le contexte ne peut pas tenir.
L'annexe le diagnostique déjà.

**Ce qui a changé.** La liste des primitives annonçait « réparable en une
ligne ». C'est faux. La correction exige que chaque liaison du contexte soit
sous la modalité **duale** de ◇ — et cette duale n'existe pas dans la grammaire
des types. La réparation coûte un connecteur, ce qui la fait tomber sous la
condition de clôture.

| | Issue | Ce qu'elle coûte |
|---|---|---|
| **A1** | Introduire la duale de ◇ et poser la contrainte | La règle devient correcte. La grammaire gagne un connecteur, et la condition de clôture doit être réexaminée — c'est elle qui interdit d'ajouter un mécanisme plutôt que de le dériver. |
| **A2** | Restreindre ◇ aux contextes déjà bornés | Aucun connecteur nouveau. La modalité perd le seul cas qui la motive : le transducteur qui produit à un rythme que son entrée ne détermine pas, que le chapitre 4 signale. |
| **A3** | Garder la réserve écrite, ne pas employer ◇ dans le noyau exécutable | Coût nul aujourd'hui, dette portée. |

> **Rendu : A1.** Introduire la duale de ◇ et poser la contrainte.
>
> **Une précision de fait, qui change ce que A1 coûte.** Tu situes la décision
> à la couche 3. Or ◇ n'y vit pas : la couche 3 est pure et terminante, sans
> modalité temporelle. L'annexe écrit que □ et ○ suffisent aux couches 1 et 2,
> dont les calendriers sont bornés par construction, et que **◇ n'est requis
> que là où un transducteur produit à un rythme que son entrée ne détermine
> pas** — le cas que le chapitre 4 signale, en couche 2.
>
> La rigueur que tu invoques est donc la bonne, mais elle s'applique ailleurs
> que là où tu la places. A1 reste le bon choix : la duale rend la règle
> correcte, et c'est la seule issue qui ne retire rien au langage. Le travail
> est en couche 2, et il touche la grammaire des types de session.

---

## B — La forme des deux règles de la coalgèbre terminale *(bloquant)*

**Le fait.** `να.C` figure à la grammaire des types et **aucune règle de terme
ne l'habite** — ni introduction, ni élimination. Sur dix-neuf connecteurs de
type, c'est le seul orphelin non déclaré. La productivité de la couche 2, sur
laquelle le document appuie un théorème et deux garanties, repose donc sur un
connecteur qu'aucun terme n'introduit.

La voie de la dérivation est fermée : elle suppose une théorie extensionnelle
que K7PL n'a pas. ν est primitive, et il lui manque ses règles.

**Trois formes sont possibles, et l'analyse complète est dans
`ANALYSE-B-ET-F.md`.** Ce qui suit en est le résumé.

| | Forme | Verdict |
|---|---|---|
| **B-a** | Anamorphisme + observation — la forme catégorique, déjà construite au chapitre 2 | **recommandée** |
| **B-b** | Copatrons + types dimensionnés — la forme d'Abel et Pientka | coûteuse, et risquée |
| **B-c** | Point fixe gardé sur ○ — réemploi de la modalité existante | **écartée** |

**B-c est écartée parce qu'elle défait Q3.** Ce matin, Q3 a établi qu'un seul
pas différé suffit, la raison étant que le point fixe de K7PL n'est pas gardé.
Introduire un point fixe gardé sur ○ réunit exactement la configuration que
Bahr décrit comme destructrice. Ce n'est pas de la prudence : c'est rouvrir une
question close il y a trois heures.

**B-b coûte un second indice sur les types.** La taille viendrait vivre à côté
du grade, et leur interaction n'est étudiée nulle part — la même réserve que
Q1 opposait à la dérivation des M-types : *rien n'établit que la chaîne survive
à la gradation*. Surtout, un indice ne coûte pas un cas d'induction : il coûte
la reprise des trente-six règles et des dix-huit inductions.

**B-a ne coûte que deux règles**, soit trente-six cas d'induction, et **aucun
indice nouveau**. Son seul défaut est ergonomique — programmer par anamorphisme
demande de fabriquer une coalgèbre. Or la doctrine du langage répond déjà :
le chapitre 5 pose que le noyau est petit et que l'ergonomie vient de macros
au-dessus de lui. **Les copatrons deviennent de la syntaxe de surface, élaborée
vers l'anamorphisme** — exactement le régime des glyphes.

| | Issue |
|---|---|
| **B1** | B-a dans le noyau, copatrons en syntaxe de surface. J'écris les deux règles, les deux formes de terme, les deux entrées, et l'élaboration. |
| **B2** | B-b, en assumant le second indice et la reprise des inductions. |
| **B3** | Retirer ν de la grammaire, et avec lui ce que la couche 2 lui doit. |

*Tant que B n'est pas rendu, `make controle` reste rouge : le quatrième volet
du croisement, posé aujourd'hui, refuse un connecteur de type inhabité.*

---

## C — Les vingt-huit légendes qui ne s'impriment pas

Vingt-huit `#+CAPTION:` posées sur des blocs `#+BEGIN_EXPORT` — les grammaires,
les jeux de règles, les équations de l'annexe. Org les ignore. Écrites, souvent
bonnes, jamais imprimées.

| | Issue |
|---|---|
| **C1** | Les supprimer — elles ne servent qu'à toi, au moment d'écrire. |
| **C2** | Les imprimer sans numéro, en ligne d'amorce au-dessus du display. Aucune pile affiliée à rompre, un bloc export n'en ayant pas. |
| **C3** | En faire de vrais flottants, numérotés et listés. Déplace les displays dans le flux et change la numérotation. |

> **Rendu : C3.** Les vingt-huit deviennent des flottants numérotés et listés.
> La numérotation des équations et des tables changera ; les renvois existants
> sont vérifiés par le contrôle des étiquettes, qui refusera tout orphelin.

---

## D — Le lectorat *(le plus lourd, et le moins visible)*

Aucun fichier de `meta/` ne dit à qui ce document s'adresse. Il commande
pourtant ce qu'on définit, ce qu'on suppose acquis, ce qu'on démontre — et la
charte de rédaction a été écrite sans cette donnée.

Depuis que la destination est l'implémentation, la question se resserre : le
lecteur visé est-il **celui qui implémentera**, auquel cas la spécification
peut supposer la théorie des types acquise et se concentrer sur ce qui décide
d'un choix d'implantation ? Ou reste-t-il **le pair qui évalue**, auquel cas
les emprunts doivent continuer d'être situés et justifiés ?

> **Rendu.** Le lecteur est **l'ensemble des pairs qui évaluent le projet et
> tentent de le reproduire afin de le vérifier et de le valider.**
>
> C'est le lectorat le plus exigeant des deux, et il tranche plusieurs choses
> d'un coup. Les quatre-vingt-huit termes du glossaire se justifient. Les
> emprunts doivent rester situés et justifiés. Et surtout : **ce qui n'est pas
> reproductible doit être écrit comme tel**, puisque le lecteur essaiera.
>
> Cette décision commande aussi F : la réserve sur le modèle concret de /C/
> cesse d'être une note de chantier pour devenir une obligation du document —
> un pair qui instancie /C/ dans **Rel** obtiendrait un langage différent de
> celui qu'il lit.

---

## E — Les quatre engagements tenus par « Rien » *(bloquant pour le gel)*

Sur huit engagements, quatre ne sont tenus par rien de démontré.

| Engagement | Ce qui le tient aujourd'hui |
|---|---|
| L'enrichissement sur les préordres, pour la part qui excède l'ordre des fibres | Rien |
| La conformité de l'abaissement au modèle mémoire déclaré | Rien ; c'est une propriété du compilateur |
| Le coût d'expressivité de P3 et P4, inférieur au bénéfice | Un pari, sans mesure |
| La rareté des changements de fragment | Un pari, contre un risque attesté ailleurs |

Les deux paris deviennent mesurables dès le noyau exécutable (phase 1) : c'est
l'argument qui t'a fait choisir le prototype tôt. Les deux premiers, non.

> **Rendu : ni E1, ni E2, ni E3 — une doctrine.** « Dans la mesure du possible,
> transformer les engagements en éléments validés par la littérature ; si ce
> n'est pas possible, programmer leurs démonstrations et les prouver
> nous-mêmes. »
>
> La requalification en réserve cesse donc d'être l'issue par défaut. Chaque
> engagement suit désormais trois étapes, dans cet ordre : **chercher dans la
> littérature** ce qui le tient ; à défaut, **programmer sa démonstration** ;
> et ne l'écrire en réserve que si les deux échouent, en disant pourquoi.
>
> C'est cohérent avec le lectorat rendu en D : un pair qui tente de reproduire
> ne se satisfait pas d'un pari, il en cherche la source ou la preuve.
>
> Les deux paris — coût d'expressivité de P3 et P4, rareté des changements de
> fragment — deviennent mesurables au noyau exécutable. Les deux autres
> demandent une recherche bibliographique puis, à défaut, une démonstration.

---

## F — Le modèle concret de la catégorie ambiante

Le chapitre 2 écarte la codéréliction par deux abstentions : /C/ n'est pas une
catégorie de Lafont, et K7PL ne suppose pas de biproduits finis. C'est ce qui
ferme la question — et plus solidement que l'argument par la polarisation que
la liste avançait.

Mais ce sont des **hypothèses de l'axiomatique**, non des propriétés d'un
modèle. **Rel** et **Vect**, modèles usuels de la logique linéaire, sont l'un
et l'autre des catégories de Lafont à biproduits : y instancier /C/ ferait
réapparaître la codéréliction, et le langage hériterait d'une primitive qu'il
ne déclare pas.

**Décision à porter, non à prendre aujourd'hui** : inscrire au chantier de
mécanisation que tout modèle concret retenu pour /C/ doit être vérifié contre
ces deux abstentions. Je l'ai déjà écrit dans l'entrée de la liste ; il te reste
à dire si cela devient une obligation formelle du document.

---

## G — Les entrées empiriques, à ne pas confondre avec l'arc G

Tu écris que l'arc G est entièrement fermé. **C'est exact** : trente questions
sur trente, et `meta/questions.org` n'en porte plus aucune.

Mais G-01, G-05 et G-06 ne sont pas des questions de l'arc G. Ce sont des
entrées du registre de **travail empirique**, qui porte le même préfixe. La
ligne 46 de `meta/plan.org` te les assigne encore, et elles restent ouvertes :

- **G-06** — poser le modèle matériel de référence, ou requalifier la borne
  comme relative à un profil. C'est le protocole de test de cohérence mémoire,
  et QF-20 s'y adosse. Il ne dépend d'aucun prototype.
- **G-01 et G-05** — l'évaluation des garanties et du coût. Le noyau exécutable
  de la phase 1 les rend mesurables.

Je le signale parce que fermer l'arc et fermer ces entrées sont deux gestes
distincts : abandonner G-06 en croyant l'arc clos ferait disparaître une
décision réelle sur les bornes temporelles.

---

## F bis — Le focus de recherche, borné à la route 4

**Rendu.** La route 4 est légitime ; nous restons critiques ; le focus est
**strictement borné à l'ouverture intuitionniste et probabiliste**. Aucun autre
impact n'est autorisé.

### Ce que le focus a le droit de faire

1. **Établir si les cônes mesurables portent le jugement germinal.** Ils
   modélisent la logique linéaire intuitionniste ; la question est de savoir si
   la gradation, les effets et la polarisation de l'appel par poussée de valeur
   s'y interprètent.
2. **Établir ce que la théorie de l'intégration récente apporte** pour
   interpréter les primitives d'échantillonnage, en appel par valeur comme en
   appel par poussée de valeur — le manuscrit note que c'est l'ingrédient qui
   manquait.
3. **Dire si l'extension probabiliste demande un connecteur** ou se dérive des
   effets algébriques déjà posés, comme le chapitre 4 l'affirme.

### Ce que le focus n'a pas le droit de faire

Ces quatre interdits sont la borne, et ils sont fermes.

- **Aucune codéréliction admise au noyau.** Si le modèle des cônes en porte une,
  elle reste une propriété de ce modèle et n'entre pas dans le langage.
- **Aucun biproduit fini supposé de /C/.** Les deux abstentions du chapitre 2
  tiennent, et le focus ne peut pas les lever.
- **Aucune structure différentielle au noyau.** Ni dérivation, ni transformation
  de dérivation, ni axiome différentiel dans la métathéorie.
- **Aucune modification de l'axiomatique germinale.** Si l'extension en demande
  une, le focus s'arrête et la rapporte plutôt que de la prendre.

### Le critère d'arrêt

Le focus se clôt sur l'une de ces trois issues, et sur aucune autre :

| | Issue | Conséquence |
|---|---|---|
| **F4-1** | Les cônes portent le jugement germinal sans lever aucun des quatre interdits | La voie probabiliste est ouverte, et le document peut le dire. |
| **F4-2** | Ils le portent, mais au prix d'un des quatre interdits | La voie est fermée en l'état, et le document écrit lequel des quatre l'a fermée. |
| **F4-3** | La question demande un travail qui excède le focus | Le focus rend ce qu'il a établi et s'arrête. Rien n'est admis par défaut. |

**Ce qui est déjà acquis, et qui borne la dépense.** Le chapitre 4 écrit que
« K7PL ayant retenu le CBPV, c'est son propre régime d'évaluation qui rend cette
extension disponible », et que « l'inférence probabiliste n'avait besoin d'aucun
mécanisme qu'elle ne possédât déjà ». Le focus vérifie cette affirmation ; il ne
la refonde pas.
