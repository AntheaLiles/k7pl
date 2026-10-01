> **Périmé le 8 septembre.** Relevé du 4 septembre, dont les points ont été
> traités. L'état courant du rendu se lit dans `REMISE-EMACS-08-09.md`.

# Ce que le PDF montre — relevé du 4 septembre

228 pages A4, 12 pt, une colonne de 16,2 cm. Mesuré page par page sur `src/main.pdf`,
pas estimé. Les douze figures sont bien présentes, la bibliographie est bien sur deux
colonnes, aucune page n'est vide, aucune n'est orpheline de contenu.

Ce qui suit est classé par **ce que ça coûte au lecteur**, pas par difficulté de correction.

---

## RANG 1 — Du texte est perdu à l'impression

**Vingt et une pages laissent 439 mots hors de la feuille.** Pas dans la marge : au-delà
du bord physique. Ces mots n'existent ni à l'écran ni au papier.

Le pire cas est la page 178, où le texte court jusqu'à x = 1914 pt sur une feuille qui en
fait 595. Des phrases entières sont amputées en plein milieu — « Projection implicite `e.τ`
sur un paquet existentiel dont le témoin porte un g… ».

**Treize tables sont identifiées**, et l'origine est toujours la même : plus de colonnes de
texte long que la largeur ne peut en porter.

| fichier | ligne | table | colonnes | page(s) PDF |
|---|---|---|---|---|
| `K7_Errors.org` | 89 | `tab:err-phase` | 2 | 178 |
| `K7_Errors.org` | 18 | `tab:err-frontieres` | 2 | 176 |
| `K7_Errors.org` | 44 | `tab:err-terminaison` | 2 | 177 |
| `K7_Semantique.org` | 1106 | `eq:relation-logique` | 2 | 220 |
| `K7_Semantique.org` | 1143 | `tab:capacites` | 3 | 221 |
| `K7_Semantique.org` | 232 | `tab:produit-mixte` | 5 | 189 |
| `K7_Semantique.org` | 417 | `tab:deux-projections` | 4 | 195 |
| `c1-prolegomenes.org` | 28 | `tab:engagements` | 3 | 3 |
| `c1-prolegomenes.org` | 345 | `tab:sedimentation` | 5 | 28 |
| `c1-prolegomenes.org` | 363 | `tab:dimensions` | 4 | 29 |
| `c4-automates.org` | 124 | `tab:memoire` | 5 | 92 |
| `c5-syntaxe.org` | 32 | `tab:delimiteurs` | 4 | 116 |
| `c5-syntaxe.org` | 231 | `eq:regle-expansion` | 3 | 126 |

**Trois corrections possibles, et elles ne se valent pas.**

La plus simple, sans toucher au contenu : `adjustbox` est déjà dans ton préambule.

```org
#+ATTR_LATEX: :environment tabular :align lll :float t
#+ATTR_LATEX: :center t :width \textwidth
```

La plus juste typographiquement : `tabularx`, qui répartit la largeur et fait passer les
colonnes de texte à la ligne au lieu de les laisser filer. Il n'est pas chargé — une ligne
à ajouter au préambule.

La plus radicale et parfois la bonne : **couper la table**. `tab:err-phase` porte 361
caractères sur deux colonnes ; c'est une liste de définitions déguisée en table, et une
liste de description la rendrait mieux.

**Il reste des débordements hors tables** — pages 21, 59, 106, 139, 182, 213, 218, 223.
Ce sont des règles d'inférence posées côte à côte dans un `array`, comme en bas de la
page 182 où la quatrième prémisse sort de la feuille. Elles demandent un passage à la
ligne, pas un ajustement de largeur.

---

## RANG 2 — Ce qui manque à un document de 228 pages

**Aucune table des matières.** `org-export-with-toc` est à `nil` dans ta configuration, ce
qui est délibéré, et le commentaire dit que la ToC se pose à la main par `#+TOC: headlines N`.
`main.org` n'en porte aucune. Sur 228 pages avec sept chapitres et six annexes, c'est le
manque le plus coûteux pour quelqu'un qui veut annoter.

**Aucune page de titre.** Le titre, l'auteur et la date occupent le tiers haut de la page 1,
et « 1 PROLÉGOMÈNES » commence juste en dessous. Un `\clearpage` après `\maketitle` suffirait.

**Le pied de page de la page 1 diffère de tous les autres** — il porte « 1 » quand les
suivantes portent « 50 / 228 ». C'est `\maketitle` qui impose `\thispagestyle{plain}`.

---

## RANG 3 — La bibliographie

Elle commence page 151 et occupe 78 pages, soit **un tiers du document**.

**Elle est numérotée « 8 BIBLIOGRAPHIE »**, donc comptée comme un huitième chapitre de
l'argument. Elle n'en est pas un. `#+print_bibliography: :heading none` est bien posé mais
le titre vient du titre org `* BIBLIOGRAPHIE` de `bibliographie.org`, que org numérote.

**Les colonnes sont trop étroites.** Deux colonnes dans 16,2 cm avec 0,8 cm de gouttière
donnent 7,7 cm par colonne, soit une trentaine de caractères par ligne à 11 pt. Le résultat
est visible page 151 : « Guil-laume », « Mem-ory », « Sci-ence », « Sympo-sium ». Pour un
document composé en Luciole — police choisie pour la basse vision et la dyslexie — la
césure à répétition travaille contre l'intention.

Trois voies : revenir à une colonne, réduire à `\footnotesize`, ou élargir le bloc de texte
pour cette section seule.

**Les dates de consultation alourdissent chaque entrée** — « [visité le 2026-08-02] ».
`biblatex` les retire avec `urldate=false` si tu ne les juges pas nécessaires.

---

## RANG 4 — Marges et impression

**Les marges sont symétriques : 2,4 cm à gauche comme à droite.** Le document est en
recto simple et non relié, donc rien n'est faux. Mais il est destiné à être **imprimé et
annoté**, et 2,4 cm ne laissent pas de quoi écrire.

Deux options selon l'usage réel :

```latex
% pour annoter : une marge extérieure large
\usepackage[top=3.2cm,bottom=3.2cm,inner=2.4cm,outer=5cm]{geometry}

% pour relier en recto-verso : un décalage de reliure
\usepackage[top=3.2cm,bottom=3.2cm,left=2.4cm,right=2.4cm,bindingoffset=1cm]{geometry}
```

**Trente-deux pages portent déjà du texte dans la marge droite**, entre 5 et 68 pt — ce sont
tes `\marginnote` et tes `RMQ`. Élargir la marge extérieure leur profiterait aussi. À noter :
`\reversemarginpar` est déclaré, ce qui devrait les envoyer à gauche ; elles sont à droite.

**Quatre-vingt-six pages dépassent la limite basse**, mais de peu — 8 pt au pire, 1 à 3 pt
le plus souvent. C'est l'élasticité normale d'un bas de page justifié en hauteur. Rien à faire,
sauf si tu veux un bas rigoureusement aligné, auquel cas `\raggedbottom`.

---

## RANG 5 — Confort de lecture

**Vingt-neuf pages finissent sur une ligne isolée** de moins d'un tiers de largeur —
« ce que P3 interdit. », « de représentation. », « à écrire. ». La parade est globale :

```latex
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
```

**Un titre est resté seul en bas de page** — « 3.2 Les contraintes de valeur », page 69.
Le préambule redéfinit `\section` et consorts en `\@startsection` sans pénalité de veuve ;
les trois lignes ci-dessus le règlent aussi.

**La ligne fait 74 caractères en médiane, 81 au neuvième décile.** L'optimum
typographique est 60 à 75. C'est donc à la limite haute, mais Luciole a un œil large et
12 pt compense : c'est acceptable en l'état. Si tu élargis la marge extérieure pour annoter,
la colonne se resserrera et cela s'améliorera tout seul.

**Le texte à l'intérieur des diagrammes est plus petit que le corps.** Les douze figures
sont vectorielles et donc nettes, mais leur police interne descend sous 8 pt à l'échelle
d'insertion. Même remarque que pour la bibliographie : le choix de Luciole dit une intention
d'accessibilité que les diagrammes ne suivent pas. À reprendre dans drawio, pas dans LaTeX.

---

## RANG 6 — Numérotation des annexes

Page 178 affiche « A.0.7 Contraintes de valeur et preuves résiduelles ». Le zéro médian
trahit un saut de niveau : l'annexe A porte des titres de niveau 3 sans niveau 2 intermédiaire.
`outils/audit_org.py` signale déjà deux sauts de ce type. À reprendre dans la structure org.

---

## Ce qui est bon, et qu'il vaut mieux ne pas toucher

Les douze figures sont présentes, vectorielles, correctement légendées et numérotées.
La bibliographie est complète et bien formée. Aucune page n'est vide. Aucun renvoi ne sort
en « ?? ». Le corps de texte est régulier : 45 lignes par page, marge gauche à 67,7 pt en
médiane pour 68 déclarés — l'écart est la protrusion `microtype`, qui est voulue.
Les théorèmes à barre latérale tiennent leur mise en page sur les quarante-quatre occurrences.
