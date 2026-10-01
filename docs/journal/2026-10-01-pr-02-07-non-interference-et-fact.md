# La non-interférence refondue, et les factorisations ouvertes

1er octobre 2026. **85 contrôles verts, 56 énoncés.**

---

## La non-interférence : ce qui ne survit pas, et ce qui lui succède

**La non-interférence séquentielle ne survit pas à la concurrence**, et la
raison tient en une phrase : deux calculs qui ne se distinguent par aucune
valeur peuvent se distinguer par le *moment* où ils rendent la main.

Un secret qui gouverne la durée d'une branche gouverne l'ordre dans lequel
l'ordonnanceur sert les autres, et cet ordre est observable. **Le secret ne fuit
pas par ce qui est calculé mais par quand cela l'est** — et aucune relation sur
les valeurs ne l'attrape.

L'ancien théorème porte donc désormais son domaine dans son nom : *non-interférence
graduée, fragment séquentiel*. Il n'est pas affaibli, il est situé.

### Ce qui lui succède, et sous quelle hypothèse

Le **déterminisme observationnel** : deux entrelacements d'un même ensemble de
calculs bien typés ont la même projection à un niveau donné. Strictement plus
fort, et pas un corollaire du précédent.

**Je l'ai scellé `conjecture`, et énoncé sous une hypothèse nommée.** Le
déterminisme observationnel sous ordonnanceur quelconque est un problème ouvert ;
le promettre sans hypothèse serait promettre ce qu'on ne sait pas tenir. La
propriété vaut donc *sous une politique d'ordonnancement déclarée* — exactement
comme le rejeu binaire est conditionné à un environnement reproductible.

> Deux hypothèses de même nature, portées par l'exécution et non par le langage,
> et nommées toutes les deux.

L'esquisse dit aussi **où la preuve résistera** : quatre des cinq règles
globales s'y prêtent, leur effet sur la trace étant local ; `Guard` est le cas
dur, puisqu'il choisit une branche selon un message dont le niveau peut excéder
celui de l'observateur.

### Un risque éprouvé avant d'écrire

Le dossier avertissait : *la règle `Guard` pourrait demander une opération que
l'algèbre des grades ne fournit pas — typiquement une borne inférieure non
définie sur les quatre composantes. À éprouver avant d'écrire trente pages.*

**Éprouvé par le calcul, sur 96 grades échantillonnés.** La jointure que `Guard`
emploie est totale, idempotente, commutative, associative, et c'est bien une
borne supérieure pour l'ordre produit mixte. Le risque nommé portait sur une
borne *inférieure* — que `Guard` n'emploie pas.

---

## ARB-PR-05, tranché sans rien réécrire

Quatre cadres de rédaction étaient proposés, et le dossier note qu'ils se
recouvrent largement : tous placent le germe dans la graduation, tous font des
trois couches des restrictions, tous réclament un objet d'effacement central.

**La formulation du manuscrit est l'une des quatre.** Le jugement germinal à
trois composantes, la sédimentation des trois couches, l'effacement en dernière
phase — c'est déjà écrit, déjà défendu, et déjà éprouvé par la couche 1 qui
vient d'y loger la distribution entière.

Choisir celle-là coûte zéro ; en choisir une autre coûte une réécriture pour un
gain nul. **Décision : le cadre du manuscrit, ratifié.**

---

## Le fichier des factorisations refusées

Écrit à part, comme tu l'as demandé : `meta/factorisations-refusees.org`.

Sept fusions tentantes, chacune avec son motif. **Six sur sept rapprochaient des
objets de même forme** — et c'est le signal à retenir : la ressemblance de
notation est ce qui rend une fusion tentante, elle n'est jamais ce qui la
justifie.

Deux méritent d'être relues.

**La cinquième est mon erreur du 9 septembre**, et je l'ai écrite comme telle :
j'avais unifié le domaine des tailles parce que le schéma était unifié, et aucun
processus non terminé n'était plus typable. *L'unification du schéma n'entraîne
pas celle de l'objet.* La leçon dépasse ce cas — une factorisation réussie à un
niveau invite à en tenter une au niveau d'en dessous, et c'est là qu'il faut
s'arrêter.

**La sixième était déjà acquise.** Le document a résisté à la fusion des trois
préservations avant qu'on la lui propose, et il avait raison. C'est le seul des
sept refus qui ne demandait rien.

---

## FACT-02 — le schéma de restriction

Cinq constructions du document *retirent* : la projection conservatrice, la
projection observationnelle, l'effacement indexé, la restriction d'un espace de
noms, la purge de spécification. Cinq objets de même forme, que rien ne reliait.

Le schéma les unifie, et **ce qu'il apporte n'est pas l'économie de cinq preuves
mais la condition qu'elles partagent et qu'aucune n'énonçait** :

> Une restriction n'est un morphisme que si son critère est **stable par les
> opérations de la structure**. C'est cette condition, et elle seule, qui sépare
> une restriction d'une mutilation.

Et il explique au passage pourquoi les deux projections ne se confondent pas :
elles diffèrent par leur critère, pas par leur forme. *Ce n'est pas une
coïncidence malheureuse, c'est une conséquence du schéma.*

La section du chapitre 2 en compte désormais quatre.

---

## L'état

| | |
|---|---|
| Contrôles | **85 verts** |
| Énoncés | 56, dont 6 ouverts |
| Schémas de métathéorie | 4 |
| Factorisations refusées | 7, documentées à part |

---

## Ce qui reste du lot FACT

| | Schéma | État |
|---|---|---|
| FACT-01 | commutation graduée | **fait** — transport, échelle, et la mise en parallèle |
| FACT-02 | restriction par critère | **fait** |
| FACT-03 | bien-fondation polarisée | **fait** — un schéma, deux sortes |
| FACT-04 | ré-invocation bornée | à écrire |
| FACT-05 | cohérence des coercions | à écrire |
| FACT-06 | effacement et simulation | à écrire |
| FACT-07 | préservation fibrée | partiel — le schéma de préservation existe |

Quatre restent, plus les dix-sept factorisations de second rang. Puis les lots
`PREUVE`, `STRUCT`, `PORT`, `IMPL`, et `REECR` en dernier.
