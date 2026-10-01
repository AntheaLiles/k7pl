# B et F — les deux analyses demandées

8 septembre 2026. **B** : la forme des règles de la coalgèbre terminale, en
coût, risque et opportunité. **F** : la tentative de démontrer qu'un biproduit
fini est nécessaire à K7PL et que la codéréliction importe.

---

# B — Habiter `να.C`

## La mesure préalable, qui commande la comparaison

Le manuscrit conduit ses preuves **par récurrence sur la grammaire ou sur le
jeu de règles**. Treize inductions sont écrites dans l'annexe ; les cinq preuves
ouvertes — préservation par la traduction, non-interférence graduée,
divulgation délimitée, loi distributive, gradation indexée — le sont aussi, et
l'annexe le dit en toutes lettres.

Conséquence directe, et c'est l'unité de compte de toute cette analyse :

> **Une règle nouvelle ajoute un cas à chaque induction qui la rencontre.**
> Un *indice* nouveau sur les types ne coûte pas un cas : il coûte une
> traversée de **toutes** les règles et de **toutes** les inductions.

Avec la mécanisation portée jusqu'à l'abaissement, cette différence n'est pas
rhétorique. C'est le poste principal du projet.

## Les trois formes possibles

### B-a — Anamorphisme et observation

```
        Δ ⊢ c : να.C | ε
Out  ──────────────────────────────
        Δ ⊢ out c : C[να.C/α] | ε

        Δ ⊢ v : U(V ⊸ C[V/α]) | ε          (la coalgèbre)
Ana  ─────────────────────────────────────────────────
        Δ ⊢ ana v : U(V ⊸ να.C) | ε
```

La forme catégorique, et **elle est déjà dans le chapitre 2** : νG y est la
coalgèbre terminale, et `ana(α)` l'unique morphisme depuis toute autre
coalgèbre. La productivité ne se vérifie pas, elle suit de la terminalité.

### B-b — Copatrons et types dimensionnés

```
        Δ, x :_r να.C ⟨i⟩ ⊢ c_j : C_j ⟨i⟩ | ε     (une par observation j)
Cop  ───────────────────────────────────────────────────
        Δ ⊢ ⟨ j ↦ c_j ⟩ : να.C ⟨i+1⟩ | ε
```

La forme d'Abel et Pientka, que les chapitres 2 et 4 désignent tous deux comme
la forme définitionnelle naturelle. L'indice ⟨i⟩ est une taille, dont chaque
observation consomme une unité — le dual exact de la décroissance qui borne le
pli de couche 3.

### B-c — Point fixe gardé sur ○

Réutiliser la modalité ○ que le langage possède déjà, à la manière de Nakano :
`fix : (○A ⊸ A) ⊸ A`. Séduisant pour la condition de clôture — aucun mécanisme
ajouté, un connecteur réemployé.

## Le tableau

| | **B-a** anamorphisme | **B-b** copatrons + tailles | **B-c** point fixe gardé |
|---|---|---|---|
| **Grammaire des types** | inchangée | **+ un indice de taille** sur tout type de calcul | inchangée |
| **Grammaire des termes** | + 2 formes | + 1 forme | + 1 forme |
| **Règles** | + 2 | + 2, **et les 36 autres doivent porter l'indice** | + 1 |
| **Cas d'induction ajoutés** (13 écrites + 5 ouvertes) | **+ 36** | **+ 18, plus la reprise des 18 inductions entières** | + 18 |
| **Condition de clôture** | respectée — la construction est celle du chapitre 2 | **mécanisme ajouté**, à justifier | respectée en apparence |
| **Ergonomie d'écriture** | pauvre : il faut produire une coalgèbre | excellente | bonne |
| **Métathéorie disponible** | universelle, ancienne | Abel et Pientka, mécanisée | Nakano, Atkey et McBride |
| **Interaction avec la gradation** | aucune : ν ne touche pas au grade | **inconnue** — deux indices sur le même type, jamais étudiés ensemble | aucune |

## Le risque qui disqualifie B-c

**B-c défait le verdict rendu ce matin sur Q3.**

Q3 a établi qu'un seul pas différé suffit à K7PL, et la raison en est précise :
son point fixe n'est **pas gardé** — la règle ne porte aucune prémisse en ○ —
et son domaine, `Trellis_fin`, exclut toute modalité temporelle. La
configuration du conflit que Bahr décrit n'est donc pas réunie.

Introduire un point fixe **gardé sur ○** réunit exactement cette configuration :
un point fixe gardé et des modalités temporelles sur le même ○. Il faudrait
alors soit distinguer deux pas différés — ce que Q3 vient d'écarter —, soit
perdre la garantie de terminaison que Bahr montre détruite par leur
identification.

B-c est écartée. Non par prudence, mais parce qu'elle rouvre une question close
il y a trois heures.

## Le risque de B-b, et il est de nature différente

Deux indices vivraient sur le même type : le **grade**, qui dit l'usage, et la
**taille**, qui dit la profondeur d'approximation. Leur interaction n'est
étudiée nulle part — et c'est le même genre de réserve que la question Q1 posait
à propos de la dérivation des M-types : *rien n'établit que la chaîne survive à
la gradation*.

Le manuscrit a déjà payé une fois pour avoir supposé qu'une construction non
graduée se transportait telle quelle. Le faire une seconde fois, sur l'indice
qui porte la productivité de toute la couche 2, serait le pari le plus cher du
document — et il serait pris à l'endroit où le lecteur qui tente de reproduire
regardera en premier.

## L'objection à B-a, et ce qui la lève

B-a est pauvre à l'écriture : programmer par anamorphisme demande de fabriquer
une coalgèbre explicite, là où un copatron se lit comme une définition
ordinaire. C'est précisément la raison pour laquelle les copatrons ont été
inventés.

**La doctrine du langage répond déjà à cette objection.** Le chapitre 5 pose
qu'un glyphe n'est pas une notation primitive mais une macro de la bibliothèque
standard, et que « la difficulté de K7PL est de comprendre le noyau et ses
annotations, l'ergonomie venant de macro-fonctions composées que des experts
préparent au-dessus de lui ». La staticité de la syntaxe en fait un théorème
plutôt qu'une convention.

Les copatrons relèvent exactement de ce régime : **syntaxe de surface, élaborée
vers l'anamorphisme**. Le noyau reste minimal et mécanisable ; l'ergonomie
arrive par-dessus, comme pour tout le reste du langage.

## Recommandation

**B-a dans le noyau, copatrons en syntaxe de surface.**

Ce que cela engage :

| Poste | Quantité |
|---|---|
| Formes ajoutées à la grammaire des termes | 2 — `out c` et `ana v` |
| Règles ajoutées | 2 — `Out` et `Ana` |
| Entrées à la liste des primitives | 2 |
| Cas d'induction à écrire | 36 — deux par induction, sur dix-huit |
| Élaboration à écrire (Phase 0) | une : copatron → anamorphisme |
| Indices nouveaux sur les types | **zéro** |

L'opportunité, et elle n'est pas mince : la règle `Ana` **rend démontrable** ce
que le document affirme aujourd'hui sans support. La productivité de la couche 2
cesse d'être une propriété promise pour devenir la propriété universelle de la
terminalité — celle-là même que le chapitre 2 a déjà construite.

---

# F — Le biproduit fini est-il nécessaire, la codéréliction importe-t-elle ?

Tu m'as demandé de le démontrer, et de rester critique si j'échoue.
**J'échoue, et l'échec est instructif.**

## Ce que j'ai cherché, et ce que j'ai trouvé

### Route 1 — L'additivité pour combiner les branches

Un biproduit servirait si le langage devait *additionner* les effets de deux
branches. Il ne le fait pas : `Case` et `With` procèdent par **joint sur le
treillis des grades** et par **partage de contexte**. La conjonction additive
partage le même contexte entre ses deux composantes, puisqu'une seule sera
consommée — c'est écrit comme l'exception aux patrons précédents, et c'est ce
qui distingue l'additif du multiplicatif.

Plus profondément : un biproduit exige que ⊕ et & **coïncident**. Chez K7PL, ⊕
est un type de **valeur** et & un type de **calcul**. Les faire coïncider
demanderait d'effondrer la polarisation de l'appel par poussée de valeur, qui
est le choix fondateur du chapitre 1. *Route fermée.*

### Route 2 — Le semi-anneau des grades

ℛ porte une addition et une multiplication ; n'est-ce pas de l'additivité ?
Non — c'est une confusion de niveau. Ces opérations vivent sur les **grades**,
qui indexent la comonade. Un biproduit est une structure sur les **objets** de
/C/. Le chapitre 2 est explicite : scinder un grade par la contraction produit
deux objets **séparés**, non deux vues d'une même ressource, et le partage exige
une diagonale, donc le fragment cartésien. *Route fermée.*

### Route 3 — La différentiation comme trait du langage

Mesure faite sur les douze fichiers : **zéro** occurrence de « gradient »,
**zéro** de « automatic differentiation ». Les quatre « différenti- » sont trois
« test différentiel » — comparaison d'un programme optimisé à son interprétation
— et la phrase du chapitre 2 qui **refuse** la structure de catégorie
différentielle. Les dix « dérivée » sont toutes logiques : une règle dérivée, une
exponentielle dérivée, une chaîne dérivée.

**Le langage n'a aucun client pour la codéréliction.** *Route fermée.*

### Route 4 — L'extension probabiliste, et c'est la seule sérieuse

Le chapitre 4 déclare l'inférence probabiliste hors périmètre mais non hors
d'atteinte : les cônes mesurables modélisent la logique linéaire intuitionniste,
et la théorie de l'intégration qui leur manquait a été développée.

C'est le seul terrain où la question se pose vraiment, la lignée des espaces
cohérents et des espaces de finitude étant précisément celle d'où la logique
linéaire différentielle est sortie. **Mais cela ne rend pas la codéréliction
nécessaire au langage** : cela rendrait un *modèle* différentiel. La
codéréliction y serait une propriété du modèle choisi, découverte alors — non
une primitive due aujourd'hui.

## Coût, risque, opportunité de l'admettre malgré tout

| | Admettre la codéréliction | Rester critique |
|---|---|---|
| **Coût** | 1 primitive, ses règles, **+ 18 cas d'induction**, et les axiomes différentiels contraignent tout modèle retenu | nul |
| **Risque** | une structure sans client dans la métathéorie que la mécanisation devra porter ligne à ligne | l'extension probabiliste, *si* elle est prise, découvrira un modèle différentiel — sans conséquence pour le noyau |
| **Opportunité** | aucune identifiée dans le périmètre déclaré | la condition de clôture reste tenue : rien n'entre qui ne serve |

## Verdict, et la réserve qui l'accompagne

**Je n'ai pas démontré la nécessité. Nous restons critiques.** Le chapitre 2 a
raison de refuser les deux hypothèses, et sa formulation actuelle — « le langage
n'a aucun usage de cette structure, et n'a pas à en hériter par inadvertance » —
est exacte.

Mais l'analyse déplace la charge, et c'est ce qui reste à porter. Les deux
abstentions sont des **hypothèses de l'axiomatique**, non des propriétés
démontrées. **Rel** et **Vect** sont l'un et l'autre des catégories de Lafont à
biproduits finis : y instancier /C/ ferait réapparaître la codéréliction, et le
langage hériterait par inadvertance de ce qu'il refuse par principe.

Puisque le lecteur visé est **le pair qui tente de reproduire**, cette réserve
doit devenir une obligation écrite du document, et non une note de chantier :

> *Tout modèle concret retenu pour /C/ doit être vérifié contre deux
> abstentions : /C/ n'est pas une catégorie de Lafont, et n'a pas de biproduits
> finis. Un modèle qui les violerait donnerait au langage une codéréliction
> qu'il ne déclare pas.*

C'est le seul endroit où la question a des conséquences, et c'est à la
mécanisation qu'elle se posera.
