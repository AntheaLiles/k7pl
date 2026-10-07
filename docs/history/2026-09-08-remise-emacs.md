# Remise du 8 septembre — les [rmq:] retrouvés, la grille de flottant, la table 3.1

> Remise de l'ancien dispositif de rendu (Emacs et LaTeX). Le rendu de la spécification Verso est décrit dans `tools/SpecExt/`.

Deux fichiers à recopier :

| Fichier livré | Destination |
|---|---|
| `livrables/my-export-config.el` | `~/.emacs.d/lisp/my-export-config.el` |
| `livrables/preamble-article.tex` | `~/.emacs.d/latex/preamble-article.tex` |

Le préambule livré part de ta dernière mouture ; seule la section 05 change.

---

## 1. Le traitement des `[rmq:]`, et pourquoi il avait disparu

`rmq` n'apparaissait dans aucun de tes treize `.el`. Le préambule définit bien
`\RMQ{}`, mais plus rien ne convertissait `[rmq:texte]` en appel de cette macro :
la page 80 du PDF imprime le crochet en toutes lettres, au beau milieu du
paragraphe. Trente et une remarques étaient dans ce cas.

La fonction `my/org-remarques-en-marge` rétablit le pont. Elle fait trois choses
qu'un simple remplacement ne ferait pas.

Elle **compte les crochets**, de sorte qu'une remarque qui en contient un
(`[rmq:… voir [1] …]`) ne se referme pas trop tôt. Elle **épargne les blocs** —
`#+BEGIN_SRC`, `#+BEGIN_EXPORT`, `#+BEGIN_EXAMPLE` — où le texte est littéral et
où un `[rmq:` doit rester tel quel. Et elle enveloppe le contenu dans des
extraits d'export plutôt que d'écrire `\RMQ{…}` en clair :

```
[rmq:Le /même/ nom, deux existences.]
   ↓
@@latex:\RMQ{@@Le /même/ nom, deux existences.@@latex:}@@
```

La différence compte. Écrit en clair, `\RMQ{…}` serait vu par Org comme un
fragment LaTeX et son contenu traverserait l'export sans être analysé :
l'emphase, les citations et les renvois posés dans une remarque s'imprimeraient
littéralement. Avec les extraits d'export, seules l'ouverture et la fermeture de
la macro sont du LaTeX ; le reste demeure du texte Org.

**Vérifié** : 31 remarques converties sur 31, aucune survivante, aucune touchée
à l'intérieur d'un bloc, crochet imbriqué compris.

---

## 2. Description, Note et Source

Quatre mots-clés ouvrent la pile du flottant — voir le § 5 bis pour la raison,
qui n'est pas une préférence :

```org
#+DESC:     Ce que la figure présente, pour dispenser le corps du texte de le raconter.
#+NOTE:     Comment lire le graphique lorsque sa forme n'est pas courante.
#+SOURCE:   https://fr.lipsum.com/
#+ALT_TEXT: Texte destiné à la synthèse vocale.
#+CAPTION:  Le titre du flottant
#+NAME:     fig:etiquette
#+ATTR_LATEX: :width 0.9\linewidth
[[./img/figure.pdf]]
```

Les quatre sont optionnels et indépendants. `my/org-items-flottants` les retire
avant l'analyse et replie leur contenu dans la légende, où le préambule les
relit pour composer la grille : le titre en `\small`, la description en `\small`,
la note et la source en `\footnotesize`, la source en italique.

Pour une **figure**, la grille entière tient sous l'image. Pour un **tableau**,
le titre reste au-dessus, où Org place la légende, et les trois items
descendent sous le filet de fin — c'est la place d'une note de tableau.

La légende reçoit au passage une forme courte, de sorte que la liste des figures
et celle des tableaux portent le seul titre.

### Le partage des rôles

| | dit quoi | à qui |
|---|---|---|
| `#+ALT_TEXT:` | ce que l'image montre | à la synthèse vocale |
| `#+DESC:` | ce que l'image présente | au lecteur |
| `#+NOTE:` | comment lire ce qui est présenté | au lecteur |
| `#+SOURCE:` | d'où cela vient | à la provenance |

### Pourquoi des mots-clés et non des lignes `#+LATEX:`

C'est le défaut de la table 3.1, ci-dessous : un mot-clé qui n'est pas affilié,
glissé dans la pile, la rompt. Le filtre retire donc ces lignes avant
qu'Org ne lise le tampon, et la pile qu'il voit ne contient que des mots-clés
affiliés.

---

## 3. La table 3.1, page 80

La ligne 19 de `c3-types.org` portait :

```org
#+CAPTION: Les quatre modalités d'usage comme quatre intervalles…
#+NAME: tab:modalites-intervalles
#+LATEX: \label{tab:modalites-intervalles}      ← la coupable
#+ATTR_LATEX: :environment tabularx …
| Modalité | Intervalle | … |
```

`#+LATEX:` n'est pas un mot-clé affilié : c'est un élément à part entière. Posé
au milieu de la pile, il la coupe en deux. `#+CAPTION:` et `#+NAME:` ne
s'attachent plus à rien, `#+ATTR_LATEX:` s'attache encore au tableau. D'où les
trois symptômes ensemble :

- pas de légende, donc **pas de flottant**, donc pas de numéro de table ;
- pas d'entrée dans la liste des tableaux ;
- le `\label` s'émet en cours de texte et capte le dernier compteur incrémenté
  — **le titre de sous-section**, d'où le « 3.1 » que tu as lu.

La ligne est retirée. `#+NAME:` suffit : `org-latex-prefer-user-labels` est à
`t`, l'étiquette se pose d'elle-même à l'intérieur du flottant.

Un contrôle nouveau refuse désormais tout mot-clé non affilié inséré dans une
pile — `outils/controle.py`, section « Pile de mots-clés affiliés ».

---

## 4. Deux renvois qui s'imprimaient « ?? »

Pages 232 et 241. `[[eq:grammaire-types]]` et `[[eq:regle-portee]]` visaient un
`#+NAME:` posé sur un bloc `#+BEGIN_EXPORT`. Org n'attache ni légende ni
étiquette à un bloc export : le `#+NAME:` ne produit aucun `\label`, et le renvoi
reste sans cible.

Les deux displays sont immédiatement sous la phrase qui les annonce ; les
numéroter pour un renvoi de deux centimètres aurait été du bruit, et la largeur
d'impression y aurait perdu. Les deux phrases disent désormais « ci-dessous ».

Un second contrôle nouveau les aurait trouvés : « Renvois vers un bloc export ».

---

## 5. Ce qui reste à trancher — 28 légendes qui ne s'impriment pas

Le même mécanisme joue ailleurs, et plus largement. **Vingt-huit** `#+CAPTION:`
sont posées sur des blocs `#+BEGIN_EXPORT` — les grammaires, les jeux de règles,
les équations de l'annexe. Org les ignore toutes. Ces vingt-huit phrases sont
écrites, souvent bonnes, et n'ont jamais été imprimées.

Exemple, `c3-types.org` :

> `#+CAPTION: La chaîne modale n'est pas posée, elle se dérive : les trois
> fragments sont trois modes et les deux inclusions sont des morphismes`

Trois issues, et le choix t'appartient :

1. **Les supprimer** — elles ne servent qu'à toi, au moment d'écrire.
2. **Les imprimer sans numéro**, en ligne d'amorce au-dessus du display, par une
   macro du préambule appelée depuis `#+LATEX:` *avant* le bloc (sans pile
   affiliée à rompre, puisqu'un bloc export n'en a pas).
3. **En faire de vrais flottants**, numérotés et listés — mais cela déplace les
   displays dans le flux et change la numérotation.

Dis-moi laquelle et je l'applique.

---

## 5 bis. `#+ALT_TEXT:` et l'ordre de déclaration

**Correctif du 8 septembre au soir.** L'ordre que tu proposais — les quatre
mots-clés personnels *après* `#+CAPTION:` — ne peut pas être tenu, et je ne
l'avais pas vu en te le confirmant. Org n'attache à un élément que les mots-clés
affiliés qui le précèdent **sans interruption**, et `#+DESC:`, `#+NOTE:`,
`#+SOURCE:`, `#+ALT_TEXT:` n'en sont pas. Posés après la légende, ils coupent la
chaîne : les douze figures ont perdu légende, numéro et étiquette. C'est
exactement le défaut de la table 3.1, que j'avais diagnostiqué le matin même et
reproduit l'après-midi.

Les quatre ouvrent donc la pile :

```org
#+DESC: Les deux états d'un acteur virtuel et les deux transitions qui les relient.
#+NOTE: On y suit la reprise de la coalgèbre à l'activation.
#+SOURCE: Fait avec mermaid.js v11, 2026
#+ALT_TEXT: Cycle a deux etats, de Desactive vers Actif puis retour.
#+CAPTION: Cycle de vie d'un acteur virtuel
#+NAME: fig:acteur-cycle-de-vie
#+ATTR_LATEX: :placement [htbp] :options width=.8\largeurimpression
[[../../meta/virtual-actor-lca.drawio]]
```

Le gain dépasse la réparation : ainsi disposée, **la source se compose
correctement même si le filtre n'a pas tourné** — sans les items, mais avec ses
légendes. Une source qui dépend d'un outil doit se dégrader de cette façon.
Un contrôle refuse désormais toute autre disposition.

Aucune des quatre premières lignes n'est obligatoire et leur ordre entre elles
est libre.
`#+ALT_TEXT:` se replie dans `:options alt={…}` : l'attribut s'ajoute à un
`:options` déjà présent, la ligne `#+ATTR_LATEX:` est créée si elle manque, et
seule la première est touchée lorsqu'il y en a plusieurs. Les douze textes de
remplacement du manuscrit sont portés à la nouvelle forme, et le contrôle
accepte désormais les deux écritures.

Deux caractères sont à éviter dans un `#+ALT_TEXT:` — l'accolade fermante, qui
refermerait `alt={…}` trop tôt, et un deux-points collé à un mot, qu'Org
prendrait pour le début d'un autre attribut. Le contrôle refuse le second.

---

## 5 ter. Le glossaire

`src/K7PL-glossary.org` est renseigné, au format qu'attend org-glossary et que
`#+GLOSSARY_SOURCES:` va chercher : **88 termes**, **48 sigles**, **31 entrées
d'index**.

Quatre règles y sont tenues, et écrites en tête du fichier pour qu'elles se
maintiennent : aucune définition ne se sert du terme qu'elle définit ; chacune
donne le genre puis la différence ; chacune se lit seule, sans renvoi à une page
ni à une section ; le pluriel est écrit dès que le français ne le forme pas en
ajoutant un « s » au dernier mot — « acteur virtuel, acteurs virtuels » — et une
virgule seule déclare un terme sans pluriel.

Les sigles ne reçoivent que leur développement, jamais de glose : org-glossary
imprime « Abstract Syntax Tree (AST) » à la première occurrence, et une glose y
serait illisible. Ce qui demande une glose est un terme, et prend place au
glossaire.

**Ce que le glossaire écarte, en le disant.** BLAKE3, LLVM, DWARF, LEAN4, BQN,
TXR, DFuzz, APL2, GEDANKEN, LMAX, VirtIO et WebAssembly sont des noms propres et
non des abréviations ; leur donner un développement serait écrire une chose
fausse. GV désigne le calcul de sessions de Gay et Vasconcelos, d'après les
initiales de ses auteurs. ABA nomme une séquence de valeurs.

Un contrôle nouveau tient l'exigence dans la durée : tout sigle employé en prose
doit être déclaré au glossaire ou figurer parmi ces exclusions. Un sigle
introduit demain échouera tant qu'il n'aura pas reçu son développement.

**Un point à surveiller au premier export.** Le sigle `SI` est déclaré ; si
org-glossary se révèle insensible à la casse, il accrocherait la conjonction
« si ». Un coup d'œil à la première occurrence le dira, et l'entrée se retire en
une ligne.

**Un second, sur le volume.** org-glossary lie *chaque* occurrence d'un terme
défini. Quatre-vingt-huit termes sur deux cent soixante-quatorze pages font
beaucoup de liens. Si la page s'en trouve bruyante, `org-glossary-automatic` à
`nil` bascule en liens explicites, et `M-x org-glossary-apply-terms` convertit
d'un coup ce qui existe.

**Ce qui manque encore.** Les vingt et un segments de trois lettres des codes
d'erreur — ARC, TYP, MEM, EFF, TOP, CMP, IND, STK, ACT, MAC, POL, PUR, LOG, TER,
DPL, PKG, SLC, ROW, FLD, SMT, FFI — n'ont leur table nulle part. Un lecteur qui
rencontre `ERR-SLC-001` n'a aucun moyen de savoir ce que SLC désigne. L'annexe
des codes d'erreur groupe par invariant, non par préfixe. C'est un manque réel,
et il relève de la complétude des codes d'erreur que tu as toi-même signalée.

---

## 6. Ce qui a été porté au manuscrit

- Les quatre indications de lecture logées dans une légende sont passées en
  `#+NOTE:` — `tab:capacites`, `tab:phi-psi`, `tab:statut-solveur`,
  `fig:session-automate`.
- Treize `#+DESC:` posées, une par figure, en première rédaction à relire : elles
  disent ce que la figure présente, sans redire l'`alt` ni empiéter sur le corps
  du texte.

`controle.py` passe intégralement, `audit_org.py` ne signale rien de bloquant.
