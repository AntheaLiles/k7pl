# Les hauteurs de fonte, et les deux leviers

> Réglages typographiques du préambule LaTeX de l'ancien dispositif ; archivé avec lui (`archives/outillage-org/`).

`\@setfontsize{taille}{interligne}` — les deux nombres sont en points, et ils ne
font pas le même travail.

**La taille** décide combien de caractères tiennent sur une ligne.
**L'interligne** décide si la page respire.

Ta cascade actuelle pose l'interligne à **1,2 × la taille**, partout. C'est
serré, et surtout c'est *constant* — or la règle est que le rapport doit
**diminuer quand la taille augmente** : un titre de 24 pt n'a pas besoin
d'autant d'air proportionnel qu'un corps de 12.

---

## Ce que la colonne rétrécie change

Mesuré sur ton PDF : **74 caractères par ligne à 12 pt sur 16,2 cm.** De là on
déduit tout le reste.

| corps | zone 2,6 cm | zone 3,6 cm | zone 4,6 cm | zone 5,6 cm |
|---|---|---|---|---|
| 12,0 pt | 60 | **55** | 51 | 46 |
| 11,5 pt | 62 | 58 | 53 | 48 |
| **11,0 pt** | 65 | **60** | 55 | 50 |
| 10,5 pt | 68 | 63 | 58 | 53 |
| 10,0 pt | 72 | 66 | 61 | 55 |

L'optimum typographique est **60 à 75 caractères**. En gras : la case où tu es
aujourd'hui (12 pt, zone 3,6 cm → 55, sous l'optimum) et celle que je te
propose (11 pt, même zone → 60, dans l'optimum).

**Descendre à 11 pt ne dégrade donc pas la lecture : elle l'améliore**, parce que
la colonne est déjà étroite. Et cela libère de quoi élargir la zone d'annotation
à 4,6 cm si tu préfères, au prix d'un retour à 55 caractères.

---

## La cascade proposée — corps à 11 pt

```latex
%%%% Redéfinition des tailles de police
%% Progression géométrique de rapport ~1,16 vers le haut, ~1,12 vers le bas.
%% L'interligne passe de 1,30 au corps à 1,13 aux grandes tailles : plus le
%% caractère est gros, moins il a besoin d'air proportionnel.
\makeatletter
\renewcommand{\tiny}        {\@setfontsize\tiny{7}{8.5}}
\renewcommand{\scriptsize}  {\@setfontsize\scriptsize{8}{10}}
\renewcommand{\footnotesize}{\@setfontsize\footnotesize{9}{11.5}}
\renewcommand{\small}       {\@setfontsize\small{10}{13}}
\renewcommand{\normalsize}  {\@setfontsize\normalsize{11}{14.3}}
\renewcommand{\large}       {\@setfontsize\large{13}{16}}
\renewcommand{\Large}       {\@setfontsize\Large{15}{18}}
\renewcommand{\LARGE}       {\@setfontsize\LARGE{17}{20}}
\renewcommand{\huge}        {\@setfontsize\huge{20}{23}}
\renewcommand{\Huge}        {\@setfontsize\Huge{23}{26}}
\makeatother
```

**Trois choses à noter.**

`\tiny`, `\scriptsize` et `\footnotesize` **manquaient à ta liste** : ils gardent
donc les valeurs de la classe pour 12 pt, qui ne suivront pas si tu changes le
corps. Les voici alignés sur le reste.

Le corps passe de 12/14,4 à 11/14,3 — **la hauteur de ligne ne bouge presque
pas**. Le gain n'est pas vertical : il est horizontal, chaque ligne portant cinq
caractères de plus. Les paragraphes comptent donc moins de lignes.

`\small` à 10/13 est celui qui porte les bibliographies par partie. Sur une
colonne de 12,1 cm cela donne ~66 caractères — confortable.

---

## Si tu veux vraiment gagner de la hauteur, le levier n'est pas la police

```latex
\setlength{\parskip}{0.5em}
\setlength{\parindent}{0pt}
```

À 11 pt, `0.5em` fait 5,5 pt **entre chaque paragraphe**. Sur 228 pages et une
médiane de 45 lignes par page, c'est le poste le plus lourd après le corps
lui-même. Trois options, par gain croissant :

| réglage | effet |
|---|---|
| `\parskip 0.35em` + `\parindent 0pt` | gain modéré, la séparation reste lisible |
| `\parskip 0pt` + `\parindent 1.2em` | retour à l'alinéa classique — gain net, mais change l'allure du document |
| `\parskip 0.25em` + `\parindent 1em` | les deux à la fois, ceinture et bretelles ; redondant typographiquement |

Je ne l'ai pas changé : c'est une décision d'allure, pas de technique.

---

## Une réserve, et elle tient au choix de Luciole

Luciole est dessinée pour la basse vision et la dyslexie. Descendre le corps va
contre cette intention, même si l'arithmétique de la colonne le justifie.
L'interligne à 1,30 que je propose compense en partie — les recommandations
d'accessibilité demandent 1,3 à 1,5, et ta valeur actuelle de 1,2 est en dessous.

Autrement dit : **passer de 12/14,4 à 11/14,3 rend le document plus accessible
qu'il ne l'est aujourd'hui**, parce que le rapport d'interligne monte de 1,20 à
1,30 pendant que la ligne se rapproche de la longueur optimale. Le corps baisse,
mais les deux autres paramètres s'améliorent.
