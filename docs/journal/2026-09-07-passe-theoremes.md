# Passe des théorèmes — la convention, et le chapitre 2 fait

7 septembre 2026. Le chapitre 2 est fait, les six autres attendent ton verdict
sur celui-ci.

---

## Le défaut qui commandait la passe

Org ne traite pas `org-cite` à l'intérieur d'un `#+BEGIN_EXPORT latex`.
Une clé écrite là traverse l'export sans être résolue et s'imprime en toutes
lettres : page 73 du PDF, on lit `[cite:@dilavoreMonoidalStreamsDataflow2022]`
au milieu d'une esquisse de preuve.

Ce n'était donc pas seulement une mauvaise pratique de rédaction.
C'était une sortie fausse, 51 fois.

`outils/controle.py` porte maintenant le contrôle, et il échoue :

```
[Citations hors des blocs export]
    ECHEC  32 citation(s) piégée(s) dans un bloc export : K7_Semantique.org 5,
           c1-prolegomenes.org 1, c3-types.org 10, c4-automates.org 10,
           c5-syntaxe.org 2, c6-compilation.org 4
```

Il restera rouge tant que la passe n'est pas finie. C'est son travail : le
compte qu'il donne est exactement ce qui reste.

---

## La convention appliquée

Trois temps, dans cet ordre, pour chaque théorème.

**Amont — la prose qui porte le théorème.**
Le sujet, les mécanismes, les enjeux, et toutes les références.
C'est là que se dit sur quoi le théorème se construit, et c'est le seul endroit
où une citation est traitée.

**Le théorème — atomique.**
Titre, Déclaration, Esquisse de preuve. Rien d'autre.
L'esquisse porte l'argument et s'arrête là : pas de digression, pas de réserve,
pas de mise en garde, aucune citation.

**Aval — ce que le théorème engage.**
Ce qu'il donne s'il tient, ce qu'il coûte s'il tombe.
Puis les réserves, les portées, les distinctions de vocabulaire — tout ce qui
encombrait la preuve.

### Les deux compléments

`[rmq:...]` porte le discours parallèle : interpréter, qualifier, avertir,
guider la lecture. Une ou deux phrases, jamais plus — la marge fait 3,6 cm.
Neuf posées au chapitre 2.

`[fn::...]` porte la clarification technique brève. Quatre posées.
J'écris le double deux-points, qui est la note anonyme native d'org ; `[fn: ...]`
avec un seul n'est pas une syntaxe qu'org reconnaît.

**Vérifie que `[rmq:...]` sort bien.** Tu m'as dit l'avoir défini en custom, je
l'ai employé tel quel et je ne peux pas le compiler ici. Neuf occurrences au
chapitre 2 : si la syntaxe n'est pas celle-là, elles se verront toutes du
premier coup, et la correction est un `sed`.

---

## Le chapitre 2, avant et après

Neuf théorèmes, zéro citation piégée.

| Théorème | Mots dans le bloc |
|---|---|
| terminaison de la couche 3 par algèbre initiale | 175 |
| bonne définition de la sédimentation | 126 |
| productivité coinductive de la couche 2 | 123 |
| progression, paramétrée par la couche | 162 |
| loi distributive de l'historique | 184 |
| divulgation délimitée | 154 |
| terminaison du point fixe déductif | 227 |
| structure de raffinement | 241 |
| non-interférence graduée | 191 |

Le premier faisait 1 100 mots avant la passe, dont cinq paragraphes
d'exposition logés entre la déclaration et l'esquisse.

Rien n'a été supprimé. Tout ce qui est sorti du bloc est remonté dans la prose
amont ou descendu dans la prose aval, et les dix-neuf citations du chapitre sont
maintenant là où org les résout.

---

## Ce que je n'ai pas pu vérifier

La compilation. Ni biblatex ni les polices Luciole ne sont sur cette machine ;
j'ai éprouvé la mécanique du théorème allégé sur un document témoin, avec Latin
Modern, et le rendu est celui que tu as demandé — Théorème n en gras,
Déclaration n en romain, Esquisse de preuve en italique close d'un carré blanc,
sans barre, sans cadre, sans gris, et le titre long se coupe en fin de ligne.

Ce que je n'ai pas éprouvé, c'est ce rendu sur tes 44 théorèmes réels.

---

## État au 7 septembre, fin de journée — les deux passes sont faites

Les 44 théorèmes des sept chapitres et de l'annexe E sont passés.
`controle.py` le dit :

```
[Citations hors des blocs export]
    ok     aucune citation prisonnière d'un bloc export
```

Les 51 citations sont dans la prose qui porte chaque théorème, là où org les
résout. Rien n'a été supprimé : ce qui est sorti d'un bloc est remonté en amont
ou descendu en aval.

Et plus aucune formule ne sort de la page. J'ai monté une boucle de mesure —
extraire les 45 environnements mathématiques du manuscrit, les composer un par
page à la géométrie réelle, relever ce qui dépasse — puis corrigé et remesuré
jusqu'à zéro. Quinze coupures en tout, toutes dans l'annexe E : règles
d'inférence redistribuées sur deux lignes, grammaires coupées, relations
logiques dont la partie droite passait la marge.

Ce qui reste, et que je n'ai pas pu éprouver : la compilation réelle. Ni
biblatex ni les polices Luciole ne sont ici.

---

## Le second chantier, mesuré — les formules qui sortent de la page

`outils/deborde.py` relève ce qui dépasse la marge d'impression dans le PDF
composé, en écartant la protrusion de microtype, qui est voulue.

```
python3 outils/deborde.py src/main.pdf
```

Neuf pages sur 390 débordaient. La page 182 est corrigée — la grammaire du
métalangage est passée sur deux lignes. Les huit autres sont toutes dans
l'annexe E, `K7_Semantique.org` :

| Page | Débordement | Ce qui déborde |
|---|---|---|
| 318 | 378 pt | grammaire des valeurs, des calculs et des sessions |
| 367 | 182 pt | relation logique sur les sessions |
| 355 | 146 pt | relation logique sur les valeurs |
| 346 | 121 pt | règles de réduction |
| 324 | 128 pt | règles de typage des calculs |
| 340 | 98 pt | règles de typage des vecteurs |
| 320 | 76 pt | grammaire des termes |
| 328 | 42 pt | règles des modalités |

Vingt et un blocs de mathématiques de ce fichier portent une ligne de plus de
150 caractères. Ce n'est pas une passe qui se fait à l'aveugle : chaque
grammaire se coupe où sa lecture le permet, chaque règle d'inférence a une
largeur naturelle. C'est le chantier suivant, s'il te va.

---

## La suite, si celui-ci te va

Six chapitres, dans l'ordre du reste à faire :

| Fichier | Citations piégées |
|---|---|
| `c3-types.org` | 10 |
| `c4-automates.org` | 10 |
| `K7_Semantique.org` | 5 |
| `c6-compilation.org` | 4 |
| `c5-syntaxe.org` | 2 |
| `c1-prolegomenes.org` | 1 |
