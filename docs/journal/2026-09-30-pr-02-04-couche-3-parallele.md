# La couche 3 parallèle — écrite

30 septembre 2026. Première pièce du noyau formel que la campagne disait absent.
**84 contrôles verts.**

---

## Les six décisions, arrêtées

| | Décision | Retenue |
|---|---|---|
| D1 | Le canal est-il une valeur ? | `Chan S` et `Mb E` comme constructeurs de valeur — la discipline est portée par le **grade**, non par une seconde zone de contexte |
| D2 | Synchrone ou asynchrone ? | **asynchrone primitif**, synchrone dérivé |
| D3 | Sessions ou boîtes aux lettres ? | les deux formateurs, une sémantique, un théorème de plongement |
| D4 | Le graphe des théorèmes d'interblocage ? | importé avec son théorème, plutôt que défini à la main |
| D5 | La localité dans le jugement ? | modalité graduée `@` sur un demi-treillis — **neuvième instance** du procédé de gradation |
| D6 | Le parallélisme et le coût ? | **travail et profondeur** |

D1, D3, D4 et D5 sont prises telles que le programme les recommande ; leurs
motifs sont décisifs et chacune referme une fiche nommée. D2 et D6 changeaient le
langage lui-même et te revenaient.

**Ce que les six ne coûtent pas, et c'est ce qui les rend acceptables : aucune
quatrième place dans le jugement.** Canaux, localité et parallélisme se rangent
en valeur graduée, en modalité graduée et en composante d'effet. La condition de
clôture tient sans révision de l'axiomatique.

---

## Ce qui est écrit

**Le facteur temporel devient un couple.** `κ = ⟨w, s⟩` par niveau — le travail,
nombre total de pas, et la profondeur, longueur du plus long chemin de
dépendances. Deux compositions les gouvernent, et leur différence *est* le
parallélisme :

```
séquentiel :  ⟨w₁,s₁⟩ · ⟨w₂,s₂⟩ = ⟨w₁+w₂, s₁+s₂⟩
parallèle  :  ⟨w₁,s₁⟩ ∥ ⟨w₂,s₂⟩ = ⟨w₁+w₂, max(s₁,s₂)⟩
```

Le séquencement reste non commutatif — l'ordre des effets compte. **La mise en
parallèle est commutative**, et c'est exactement ce qu'on veut dire en mettant
deux calculs en parallèle. Une loi d'échange les relie : entrelacer ne coûte
jamais plus que séquencer par tranches.

**Deux règles**, `Par` et `Vmap`, et deux formes de terme à la grammaire.

### Les trois remarques qui portent le contenu

**`Par` compose ses contextes par l'addition**, exactement comme la règle de la
paire. Rien n'est inventé : la règle existait pour les valeurs, elle est étendue
aux calculs.

**`Par` n'est pas la conjonction additive**, et les confondre serait l'erreur.
L'additive *partage* son contexte parce qu'une seule branche s'exécutera ; `Par`
l'*additionne* parce que les deux s'exécutent. C'est la différence entre le
choix et la coexistence, et elle se lit sur la composition des contextes.

**La profondeur de `vmap` ne dépend pas de n.** C'est la vectorisation écrite
dans le type plutôt que promise par le compilateur : appliquer une fonction à un
vecteur de longueur n coûte n fois son travail et **une seule fois** sa
profondeur. Un programme qui l'écrit déclare qu'il est vectorisable, et le
vérificateur le tient.

---

## Le théorème, et pourquoi sa facilité est un résultat

> **Déterminisme du parallélisme de couche 3.** Pour c₁ et c₂ de couche 3,
> `c₁ ∥ c₂` et le séquencement des deux rendent la même valeur. Leurs effets ne
> diffèrent que sur la profondeur, où le premier majore le second.

La preuve tient en une ligne : la couche 3 est le fragment cartésien, son seul
effet est le coût, **deux branches parallèles n'ont donc aucune opération par
laquelle interférer**. Il n'y a rien à ordonner.

Ce que cela achète mérite d'être dit, car la facilité pourrait le masquer. *Le
parallélisme de couche 3 n'a pas besoin d'être vérifié* : il est sûr par la
structure du fragment, et non par une analyse d'indépendance que le compilateur
conduirait. Là où un langage ordinaire doit prouver que deux tâches ne se
marchent pas dessus, celui-ci **n'a pas d'endroit où elles le pourraient**.

---

## P3 précisé

Le postulat parlait de coût mémoire. Il borne désormais les deux composantes du
temps, et le texte dit pourquoi : borner le seul travail laisserait la latence
libre ; borner la seule profondeur laisserait la consommation libre, et le
budget cesserait d'être une provision.

---

## L'état

| | |
|---|---|
| Contrôles | **84 verts** |
| Règles de typage | 41, dont 4 sans constructeur |
| Constructeurs | 37 — 9 valeurs, 28 calculs |
| Énoncés | 53 |
| Primitives | 2 entrées neuves, avec leurs termes écartés et le motif |

Les comptes du manuscrit ont suivi, et c'est le croisement qui les a vérifiés —
il avait d'abord refusé les deux règles faute d'entrée à la liste.

---

## Ce qui vient

La couche 2 asynchrone à boîtes aux lettres : `Chan S`, `Mb E`, les motifs de
boîte avec leur résiduel, et les règles `spawn`, `new`, `send`, `guard`, `free`.

C'est la pièce lourde, et elle porte ce que la campagne reprochait au manuscrit —
que les acteurs, les sessions et la concurrence soient décrits au corps du texte
et absents de l'appareil. Neuf théorèmes changeront d'énoncé ; le programme les
inventorie, et je les traiterai dans son ordre.
