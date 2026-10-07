> **Périmé le 8 septembre.** État au 4 septembre. La doctrine de rédaction en
> vigueur est celle de `CHARTE-REDACTION.md`, mesurée et datée.

# Évolutions stylistiques — état au 4 septembre

Tout est éprouvé par compilation, pas seulement écrit. Ce qui n'a pas pu l'être
ici est signalé comme tel.

---

## Une seule chose à installer

**Remplacer `~/.emacs.d/latex/preamble-article.tex` par `livrables/preamble-article.tex`.**

**Il a été refondu.** La documentation qu'il porte explique désormais comment
l'employer, non ce qui a changé — le journal des modifications est ici.

**Trois paquets seulement sont sortis**, et aucun n'est perdu :

| paquet | pourquoi |
|---|---|
| `colortbl` | déjà chargé par l'option `table` de `xcolor` |
| `url` | déjà chargé par `hyperref` |
| `amssymb` | `unicode-math` vient après lui et redéfinit tous ses symboles : il était **déjà inerte**. Si un symbole manque avec Luciole-Math, le remettre avant `unicode-math` |

Le bloc `todo` et sa redéfinition de `\todos` — vingt lignes — sont sortis aussi,
sans un seul appel. Les environnements `keyword` et `tablenotes` de même.
`siunitx` n'était pas dans ta liste : dis-moi si tu le veux, c'est une ligne.

**Ce qui est entré** : la géométrie à zone extérieure, `tabularx` et `xltabular`
avec le décalage de parité, `titletoc` pour les TOC locales, `\bibfont`,
`bookmark`, et les réglages de justification.

**Le gain le plus réel est invisible** : `\microtypesetup{expansion=true}`. Sur
une colonne large la justification a de la marge ; sur 12 cm elle n'en a plus et
les blancs se creusent. L'expansion laisse LuaTeX étirer les glyphes de quelques
millièmes. Avec `\tolerance`, `\hyphenpenalty` et `\emergencystretch`, c'est ce
qui rend une colonne étroite lisible. `\raggedbottom` règle au passage les
86 pages qui dépassaient du bas.

**Un défaut trouvé en compilant, et il venait de moi** : j'avais séparé
`\DeclareFloatingEnvironment` des `\renewcommand{\listoflistings}` qui en
dépendent, ce qui rendait la commande indéfinie. L'ordre est rétabli.

**Un avertissement subsistera, et il faut le laisser** : chaque table large
produit `Overfull \hbox (116.66pt too wide)`. 116,66 pt est exactement la zone
d'annotation plus son écart — le débordement est voulu. Tout autre nombre
signale un vrai défaut.

---

## Accessibilité

Trois choses sont déjà acquises : Luciole, un interligne de 1,30, et un gris de
lien à **7,7:1** de contraste sur blanc — au-dessus du seuil AAA de 7:1.

**Deux métadonnées sont ajoutées** à `\hypersetup` : `pdflang=fr` annonce la
langue, `pdfdisplaydoctitle=true` fait annoncer le *titre* plutôt que le nom de
fichier. Zéro risque, effet immédiat sur les lecteurs d'écran.

**Le balisage PDF/UA ne peut pas être posé dans le préambule.**
`\DocumentMetadata` doit précéder `\documentclass` : la ligne va donc dans
`my-export-config.el`, en tête de la chaîne de classe.

```elisp
"\\DocumentMetadata{lang=fr,pdfversion=2.0,pdfstandard=ua-2,
                   testphase={phase-III,math,graphic,table}}
\\documentclass[a4paper,12pt]{article}
\\input{~/.emacs.d/latex/preamble-article.tex}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
```

**Et je te le livre sans l'avoir éprouvé.** Le noyau LaTeX de cette machine date
de novembre 2021 : `\DocumentMetadata` n'y existe pas. Le tien est bien plus
récent — LuaTeX 1.22 — donc il l'a. Trois réserves quand même :

Le nom de la phase de test évolue d'une version à l'autre ; vérifie par
`texdoc latex-lab` avant de l'employer.

Le balisage d'un document qui porte 44 théorèmes encadrés par `framed`,
`unicode-math`, et des tables décalées selon la parité est exactement le cas où
le support est encore jeune. Attends-toi à des itérations.

Pose-le sur une copie avant de le poser ici.

**Le texte de remplacement d'une figure**, une fois le balisage actif :

```org
#+ATTR_LATEX: :options alt={Ce que la figure montre}
```

Les douze diagrammes n'en ont aucun aujourd'hui.

---

## Ce que tu peux régler d'une ligne

```latex
\newlength{\zoneannotation}   \setlength{\zoneannotation}{3.6cm}
```

A4 fait 21 cm. Les marges d'impression en prennent 2,4 de chaque côté ; les
**16,2 cm restants se partagent entre la colonne de texte et la zone d'annotation**.
Élargir l'une rétrécit l'autre, exactement.

| zone d'annotation | colonne de texte | caractères par ligne |
|---|---|---|
| 2,6 cm | 13,1 cm | ~60 — le bas de l'optimum |
| **3,6 cm** *(posé)* | **12,1 cm** | **~57** |
| 4,6 cm | 11,1 cm | ~52 — étroit à 12 pt |

L'optimum typographique est 60 à 75 caractères. À 12 pt et 3,6 cm d'annotation,
on est à 57 : légèrement en dessous. C'est le prix de la zone, et il n'y a pas
de solution gratuite — soit tu réduis le corps, soit tu réduis la zone.

---

## Les tables : trois attributs par table, et aucun n'est facultatif

**Réponse à ta question : `tabularx` ne s'applique pas tout seul.** Org écrit
`\begin{tabular}{lll}` par défaut, sans aucune largeur — c'est ce qui laissait
439 mots hors de la feuille sur 21 pages.

Il faut, par table :

```org
#+ATTR_LATEX: :environment tabularx :width \largeurimpression :align lZ{1.4}Z{0.6} :center nil
```

- **`:environment tabularx`** — sans quoi c'est un `tabular` nu.
- **`:width`** — obligatoire. Sans elle org écrit `\begin{tabularx}{lll}`, qui est malformé.
- **`:align`** — obligatoire aussi. Org déduit `lll` du contenu, et `tabularx`
  exige au moins une colonne souple pour absorber la largeur.
- **`:center nil`** — la table part du bord gauche de la colonne ; c'est le
  décalage de parité qui gère le côté.

**Deux types de colonne sont fournis par le préambule :**

`Y` — souple, au fer à gauche. Dans une colonne étroite, la justification étire
les blancs jusqu'à l'illisible.

`Z{p}` — la même, **pondérée**. C'est celui qui sert. Les poids se répartissent
la largeur souple et totalisent le nombre de colonnes souples.

**Pourquoi la pondération est nécessaire, et je l'ai appris en le ratant :** un
premier essai en `lXX` a donné une première colonne à sa largeur naturelle —
très longue — et deux colonnes X réduites à un caractère de large, hyphénées
verticalement. Une colonne `l` de texte long écrase ses voisines souples.

Les 22 tables sont déjà pourvues, avec des poids calculés sur la longueur réelle
de chaque colonne. Un contrôle a été ajouté à `outils/controle.py` : une table
sans ses trois attributs fait échouer la passe.

**Les tables débordent sur la zone d'annotation, jamais au-delà.** Et le
débordement suit le côté extérieur — à droite sur les pages impaires, à gauche
sur les paires. Sans cela, une table sur deux entrerait dans la reliure.
Vérifié : les 22 tables compilées, 14 pages, **zéro page hors des bornes
d'impression** sur les deux parités.

---

## Les tables des matières

**Générale, de premier niveau**, seule sur sa page, avant les prolégomènes.
Posée dans `main.org` par `#+TOC: headlines 1` entre deux `\clearpage`.

**Locale, sous chaque titre de partie**, sans intitulé « Table des matières »,
limitée aux sous-sections. C'est `#+TOC: headlines 2 local`, la directive org
native, posée en tête de chacun des douze fichiers de partie et d'annexe.

**Pourquoi elle ne rendait rien chez toi.** Org engendre, pour une TOC locale en
LaTeX, les commandes `\startcontents` et `\printcontents` — qui appartiennent au
paquet **`titletoc`**, absent de ton préambule. Une commande non définie ne se
plaint pas : elle ne fait rien. `titletoc` est ajouté, et `etoc` retiré, les deux
étant incompatibles.

Un repli manuel, `\tocpartie`, reste défini sur le même paquet au cas où la
directive resterait muette.

---

## Les bibliographies par partie

Chaque partie est enveloppée d'une `refsection` biblatex, et close par
`#+print_bibliography: :heading subbibliography` — la directive org native, comme
tu l'as demandé. La numérotation des citations repart à 1 dans chaque partie.

**Le corps est fixé dans le préambule**, une fois pour toutes :

```latex
\renewcommand*{\bibfont}{\small}
```

`\bibfont` est le crochet que biblatex prévoit pour cela. Le manuscrit n'a donc
rien à envelopper, et une seule colonne puisque rien ne l'en met en colonnes.

**La bibliographie générale de fin est retirée** — c'est ce que tu as demandé.
`chapitres/bibliographie.org` demeure sur le disque, inutilisé, si tu veux
revenir en arrière : il suffit de décommenter son `#+INCLUDE:` dans `main.org`.

**Quatre parties n'en reçoivent pas** — l'étude de cas, le LSP, `sushi` et
`sugoi` ne citent rien. Une bibliographie vide aurait fait un titre suivi de blanc.

**Ce point n'a pas pu être compilé ici** : `biblatex` n'est pas installé sur
cette machine. La mécanique `refsection` + `\printbibliography[heading=subbibliography]`
est standard, mais c'est le seul élément que je te livre sans l'avoir vu tourner.

---

## Les niveaux de titres des annexes

`A.0.7` venait d'un saut de niveau : l'annexe passait du titre 1 au titre 3 sans
titre 2, et le zéro médian était la section absente.

**`K7_Errors.org`** — sept titres promus d'un cran. La numérotation devient `A.1` à `A.7`.

**`K7_Semantique.org`** — plus retors. Ses titres portaient un préfixe manuel
`G.1`, `G.3.2.1`, que LaTeX redoublait en `E.0.1 G.1` — et la lettre était
fausse par-dessus le marché, l'annexe étant la cinquième donc `E`.

La hiérarchie était portée par ces préfixes, pas par les étoiles. Elle a été
reconstruite depuis eux : 1 / 7 / 17 / 15 / 7 titres du niveau 1 au niveau 5,
et les 21 préfixes retirés. **Le texte hors titres est identique**, vérifié.

**Deux points à surveiller.** `org-export-headline-levels` vaut 4 dans ta
configuration : les sept titres de niveau 5 sortiront en listes, non en
`\subparagraph`. Passe-le à 5 si tu les veux numérotés. Et trois renvois en clair
— « annexe D », « annexe E », « annexe F » — ne correspondent plus aux lettres
réelles ; les 60 renvois par `\ref{sec:g-...}` sont justes, eux, puisqu'ils
passent par des étiquettes.

---

## Veuves, orphelines et titres isolés

Trois pénalités ajoutées au préambule. Elles règlent d'un coup les 29 pages qui
finissaient sur une ligne isolée et le titre resté seul en bas de la page 69.

---

## Ce qui reste à trancher, et qui t'appartient

**Six en-têtes de théorème sur 88 déborderont** de la colonne rétrécie. `ntheorem`
pose l'en-tête sur une ligne qui ne se coupe pas, et deux d'entre eux débordaient
déjà à 16,2 cm. Les voici, par longueur :

| car. | environnement | en-tête |
|---|---|---|
| 88 | `statement` | Une itération à nombre de tours fixé, du même appareil que la ré-invocation séquentielle |
| 79 | `statement` | Le transport commute avec la mise à l'échelle, à condition d'échelonner l'effet |
| 72 | `statement` | Les modalités d'usage sont des modes, et leurs inclusions des morphismes |
| 64 | `statement` | Traduire un terme substitué, c'est substituer dans la traduction |
| 63 | `theorem` | productivité coinductive de la couche 2 par coalgèbre terminale |
| 58 | `statement` | Ce que la comonade cofree doit vérifier pour porter le pli |

Trois voies : les raccourcir, élargir la colonne, ou accepter le débordement sur
la zone d'annotation — qui après tout est de la marge. Je ne les ai pas touchés :
ce sont des énoncés, et les raccourcir est un acte d'écriture, pas de mise en page.

**Le texte interne des douze diagrammes** reste plus petit que le corps. À
reprendre dans drawio, pas dans LaTeX. La colonne rétrécie va accentuer l'écart,
puisque les figures sont posées à `.9\linewidth`.

**Une page de titre séparée** n'est pas posée : `\clearpage` après `\maketitle`
la donnerait, mais cela relève de ton préambule et je préfère te laisser décider
si tu veux une page de titre nue ou un titre suivi de la table des matières.
