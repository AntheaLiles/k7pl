> **Remplacé le 8 septembre** par `REMISE-EMACS-08-09.md`, qui reprend ce qui
> reste applicable. Conservé pour la trace des diagnostics.

# Remise Emacs — 7 septembre 2026

Deux lignes à changer dans `my-export-config.el`, une ligne facultative, et une
vérification que je ne peux pas faire ici.

---

## 1. Passer l'article en 11 pt

```elisp
"\\documentclass[a4paper,11pt]{article}     ; était 12pt
```

La cascade de tailles du préambule (§03) est calée sur 11 pt de corps et 14,3 pt
d'interligne.
Tant que la classe déclare 12 pt, `\normalsize` sort bien à 11 pt, mais tout ce
que la classe calcule elle-même à partir de sa taille nominale — `\@listi`,
les ressauts verticaux, les retraits — reste dimensionné pour 12 pt.
Avec 11 pt et la colonne de 12,1 cm, la mesure tombe à une soixantaine de
caractères par ligne.

---

## 2. Descendre à cinq niveaux de titre

```elisp
org-export-headline-levels 5)              ; était 4
```

`K7_Semantique.org` porte sept titres de niveau 5.
Au-delà du seuil, org cesse d'écrire un titre et écrit une liste imbriquée ;
LaTeX bute alors sur « Too deeply nested », 105 fois dans ton dernier log.
La classe déclare déjà `\subparagraph`, il n'y a donc rien d'autre à faire.

Le préambule pose désormais un filet — `itemize` et `enumerate` refaits en
listes enumitem à neuf niveaux, §09 — mais c'est un filet.
La correction, c'est que cinq niveaux de titre sortent en titres.

---

## 3. Facultatif — le balisage PDF

Le texte de remplacement des figures est maintenant écrit dans le manuscrit.
Il n'arrive dans le PDF que si le balisage est actif, et le balisage se déclare
avant `\documentclass` :

```elisp
"\\DocumentMetadata{lang=fr,pdfversion=2.0,pdfstandard=ua-2,
                    testphase={phase-III,math,graphic,table}}
\\documentclass[a4paper,11pt]{article}
...
```

À poser sur une copie d'abord.
Un document qui porte des théorèmes encadrés, unicode-math et des tables
décalées demande plusieurs itérations avant de se baliser proprement, et le nom
de la phase change d'une version du noyau à l'autre — `texdoc latex-lab` le dit.
Sans cette ligne, les `alt=` sont acceptés par graphicx et simplement ignorés :
rien ne casse.

---

## 4. Vérification — la police mathématique couvre-t-elle les sept alias ?

Le préambule ne charge plus amssymb ; il pose sept `\let` vers les noms
unicode-math (§12).
J'ai éprouvé les sept avec Latin Modern Math, seule police mathématique dont je
dispose ici. Six sont rendus. Le septième, `\Diamond` → `\mdlgwhtdiamond`
(U+25C7), en est absent — et le manuscrit l'emploie 68 fois.

Luciole-Math le porte peut-être. Je ne peux pas le savoir : la police n'est pas
sur cette machine.

Un fichier suffit à trancher :

```latex
% sonde-glyphes.tex — compiler par : lualatex sonde-glyphes.tex
\documentclass{article}
\usepackage{unicode-math}
\setmathfont{Luciole-Math.otf}
\begin{document}
$\lBrack A \rBrack \quad \mdlgwhtsquare \quad \mdlgwhtdiamond
 \quad \mdlgwhtcircle \quad \rightsquigarrow$
\end{document}
```

Puis chercher `Missing character` dans le log.
S'il en signale un pour U+25C7, remplacer dans le préambule §12 :

```latex
\let\Diamond\mdlgwhtlozenge      % U+25CA, au lieu de \mdlgwhtdiamond
```

---

## 5. Un seul essai à faire, et il tranche trois défauts d'un coup

Trois choses ne marchent pas chez toi et marchent ici, sur le même préambule.
Je l'ai vérifié : ton PDF du 17 h 39 porte bien mes puces (quinze) et tes huit
parties ouvrent toutes sur une page impaire, donc tu as le bon fichier.

| Ce qu'on voit | Chez toi | Sur mon banc d'essai |
|---|---|---|
| légende de table | largeur de la colonne de texte, 347 pt, une légende courte est centrée | largeur d'impression, 459 pt, calée sur le bord de la table |
| entrées de TOC locale | aucun lien | chaque entrée cliquable |
| légende de listing | superposée à la dernière ligne de code, p.177 | posée dessous |

`\captionsetup[table]` est donc entièrement ignoré chez toi — pas seulement le
format, l'alignement aussi.

Les trois défauts sont dans les trois mécanismes que le balisage PDF/UA
réécrit : la fabrique des légendes de flottants, `\contentsline`, et le
traitement du verbatim. Ton `main.tex` porte
`testphase={phase-III,math,graphic,table}`.

**Compile une fois sans la ligne `\DocumentMetadata`.** Si les trois rentrent
dans l'ordre, la cause est là et il faudra choisir entre le balisage et ces
trois réglages — ou attendre que `latex-lab` couvre ces cas.

J'ai posé des filets qui ne dépendent d'aucune rustine, au cas où : la largeur
de la légende de table est aussi réglée à l'ouverture du flottant, et un `\par`
précède désormais la légende d'un listing. Un point reste hors de portée : le
balisage `graphic` corrige lui aussi `\includegraphics`, et si sa correction
passe après la mienne, le décalage de la figure 10 sera perdu. Ça se voit d'un
coup d'œil — la figure sortirait des deux côtés au lieu d'un seul.

---

## 5 bis. Les liens des TOC locales

Les entrées des tables des matières locales ne sont pas cliquables : mesuré sur
ton PDF, la page 3 ne porte qu'une annotation, et c'est le folio.
La table générale, elle, en porte treize.

Ce n'est pas le préambule. Éprouvé ici sur le tien, chaque entrée de TOC locale
porte bien son lien, avec ou sans mes `\titlecontents` — j'ai fait tourner la
contre-épreuve.

Ce qui reste comme cause probable est le balisage. Ton `main.tex` du jour porte
`\DocumentMetadata{... pdfstandard=ua-2, testphase={phase-III,math,graphic,table}}` :
le code de balisage réécrit `\contentsline`, et la table partielle de titletoc
n'est pas prévue par `latex-lab`.

Une compilation sans cette ligne tranche la question en une passe.

---

## Ce qui a changé de mon côté

### `livrables/preamble-article.tex` — troisième tour

| § | Changement | Pourquoi |
|---|---|---|
| 08 | légende de table à `\largeurimpression`, décalée comme la table | elle se calait sur la seule colonne de texte et pendait au-dessus d'un tableau plus large qu'elle |
| 09 | `\renewlist` retiré, retour aux deux lignes d'origine | il effaçait les étiquettes que babel-french pose pour les listes françaises — d'où les puces disparues p.59. Il ne servait plus à rien : le manuscrit n'imbrique nulle part plus d'UNE liste, et `org-export-headline-levels` est à 5 |
| 13 | `refsection=section` retiré | il ne faisait rien : les sous-bibliographies imprimaient les 234 clés du document, c'est-à-dire la refsection 0. Il procède par rustine sur `\section`, que le §03 redéfinit |
| 14 | `\newrefsection` posé dans l'enveloppe de `\section` | même endroit que le saut de page, visible dans le préambule, indépendant de toute rustine |

Les annexes sont des `\section` comme les autres : elles ouvrent donc déjà sur
un recto, éprouvé sur un document témoin.

### `livrables/preamble-article.tex` — second tour

| § | Changement | Pourquoi |
|---|---|---|
| 02 | `\maketitle` enveloppé dans `\newgeometry` / `\restoregeometry` | la page de garde n'a pas d'annotation à loger, le titre s'y centre sur la page entière |
| 12 | `ntheorem` retiré, théorème et déclaration et esquisse écrits en paragraphes | un en-tête ntheorem est une étiquette de liste, qui ne se coupe pas — d'où le titre long sorti de la page p.26 ; et deux en-têtes imbriqués sans texte entre eux se superposaient — d'où la surimpression p.73 |
| 12 | `framed`, `leftbar` et le gris retirés | un environnement encadré ne se coupe pas entre deux pages, et le `\color` du filet fuyait dans le corps |
| 13 | `\bibfont` en `\footnotesize` | mesuré : la bibliographie sortait à 10 pt contre 11 au corps, un point d'écart ne se voit pas |
| 14 | `\cleardoublepage` devant chaque `\section` non étoilée | chaque partie ouvre sur un recto ; le `\@ifstar` épargne les titres étoilés |

### `livrables/preamble-article.tex` — premier tour

| § | Changement | Pourquoi |
|---|---|---|
| 01 / 10 | `csquotes` déplacé après `fvextra` | fvextra le réclame ; supprime l'avertissement `\@parboxrestore has changed` |
| 09 | `\renewlist{itemize}{itemize}{9}` et les neuf étiquettes | `\setlistdepth` seul ne fait rien sur les listes de la classe — mesuré |
| 10 | messages de liste vide sur `\ifdefstring{\languagename}` | `\iflanguage` compare les registres de césure, pas les noms — mesuré |
| 10 | chaque message dans son propre paragraphe | ils se suivaient sur une seule ligne |
| 12 | `\let` au lieu de `\providecommand` pour les sept alias | le noyau définit déjà `\Box`, `\Diamond` et `\leadsto` comme des amorces d'erreur, que `\providecommand` respecte — mesuré |
| 15 | `\titlecontents` niveaux 2 et 3 en `\small` | les TOC locales empruntent les formats de la TOC générale ; celle-ci s'arrête au niveau 1 |
| 15 | `\tocpartie` retiré | la directive org suffit, et ses arguments ne correspondaient pas à ce qu'org engendre |

### `src/main.org`

L'inclusion de `chapitres/c1-prolegomenes.org` et la table des matières générale
avaient disparu du fichier.
Ton export du 6 septembre ne contenait donc ni le Prolégomène ni aucune
`\tableofcontents` — vérifié sur `src/main.tex`.
Les deux sont remis, la TOC entre deux `\clearpage`.

### `src/chapitres/c1-prolegomenes.org`

Les quatre lignes LaTeX manuelles — `\small{`, `\renewcommand{\contentsname}{}`,
`#+TOC: headlines 2`, `}` — remplacées par `#+TOC: headlines 2 local`, comme
dans les onze autres parties.
Le groupe `\small{` ouvert d'un élément org à l'autre était le motif fragile déjà
rencontré dans `bibliographie.org`.

### Les douze figures

Chacune porte son texte de remplacement, rédigé sur le contenu réel du diagramme
— j'ai lu les PDF engendrés depuis les `.drawio`, pas seulement les légendes.

```org
#+ATTR_LATEX: :placement [htbp] :options alt={...},width=.9\linewidth
```

La largeur est répétée dans `:options` à dessein : selon la version d'org, la
largeur par défaut est ajoutée après les options ou remplacée par elles.
Une clé `width` en double est sans effet, une largeur perdue ne l'est pas.
Pas de deux-points dans un `alt=` : org lit la ligne avec
`org-babel-parse-header-arguments`, qui y verrait une clé neuve.

### Deux tables sans légende

`K7_Semantique.org` (le cadre de sortes) et `c5-syntaxe.org` (les quatre
contrôles avant expansion) en ont reçu une, et un `#+NAME:`.

### `outils/controle.py`

Quatre contrôles neufs, qui échoueront si l'un de ces états se défait :

- toute table porte sa légende ;
- tout flottant porte sa légende, toute figure son `alt=`, et aucun `alt=` ne
  contient de deux-points ;
- les douze parties sont inclues par `main.org`, qui porte sa TOC générale ;
- toute partie qui cite ferme sur sa sous-bibliographie, et elle seule.

---

## Ce que je n'ai pas pu éprouver ici

- **unicode-math sous LuaLaTeX** — `lualatex-math.sty` manque sur cette machine.
  J'ai compilé sous XeLaTeX, qui charge le vrai unicode-math ; c'est la même
  logique de macros, mais pas le même moteur.
- **biblatex** — absent. `refsection=section` et
  `#+print_bibliography: :heading subbibliography` sont écrits d'après la
  documentation et d'après ce que ton export du 6 septembre engendrait déjà.
  Ils n'ont pas tourné.
- **Luciole et Iosevka** — absentes ; substituées par Latin Modern.
  Seules les métriques changent, mais la couverture de glyphes aussi — d'où le §4.
- **`\DocumentMetadata`** — le noyau de cette machine date de 2021 et ne le
  connaît pas.

Tout le reste — géométrie, TOC locales, listes à neuf niveaux, messages de liste
vide dans les deux langues, alias mathématiques, tables `tabularx` décalées vers
l'extérieur — a compilé sans une erreur ni un débordement, en trois passes.
