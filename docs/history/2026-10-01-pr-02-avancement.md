# PR-02 — état d'avancement

> Archivé le 2026-10-01 : ce document décrit l'état du 1er octobre 2026, 10 h 59 et a été remplacé par [le tableau de bord](/tracking/DASHBOARD.md). Il est conservé pour la trace, tel qu'écrit alors ; les noms de fichiers et les commandes qu'il cite désignent l'ancien arbre de travail (Org-mode).

1er octobre 2026. **84 contrôles verts.** Le noyau formel porte les trois
couches ; ce qui reste est inventorié ci-dessous.

---

## Ce qui est fait

### Les trois couches du noyau formel

| | Couche | Ce qui est écrit |
|---|---|---|
| 3 | parallélisme déterministe | le coût devient un couple travail-profondeur, `Par` et `Vmap`, le théorème de déterminisme |
| 2 | concurrence asynchrone | `Chan S` et `Mb E`, l'algèbre des motifs et son résiduel, `Spawn` `New` `Send` `Guard` `Free` |
| 1 | distribution | la localité comme modalité graduée, `At` `Move` `Try`, la défaillance disciplinée et non typée |

**La couche 1 est l'argument le plus fort du document en faveur de son
axiomatique.** Ses trois aspects se rangent dans les trois strates existantes —
le *où* est un coeffet, le *coût* est un effet, le *déplaçable* est un
raffinement. Aucune quatrième place n'a été nécessaire pour l'extension la plus
lourde du langage.

### Les mesures

| | Avant PR-02 | Aujourd'hui |
|---|---|---|
| Règles de typage | 39 | **49** |
| Constructeurs de termes | 35 | **45** — 9 valeurs, 36 calculs |
| Énoncés | 51 | 53, dont 5 ouverts et scellés comme tels |
| Contrôles | 36 | **84** |

Tous ces comptes sont **produits par l'outil**. Le croisement a refusé chaque
règle tant qu'elle n'avait pas son entrée à la liste des primitives — dix
entrées versées en trois jours, chacune avec son terme retenu, ses termes
écartés et le motif.

### Les quinze fiches refermées

**Bloquantes** — `BLOQ-01` noyau séquentiel · `BLOQ-02` duale de ◇ ·
`BLOQ-03` loi fausse au grade ω · `BLOQ-04` ℛ à deux structures ·
`BLOQ-06` clause de taille · `BLOQ-13` graphe de câblage.

**Structurelles et transversales** — `TRANS-01` sceau à deux axes ·
`TRANS-05` registre des obligations · `STRUCT-03` sept natures, un
environnement · `STRUCT-04` couche 2 asynchrone ou synchrone.

**Notation et portée** — `NOTA-01` table normative · `NOTA-03` comptes qui ne se
recoupaient pas · `NOTA-08` renvois faux · `PORT-04` rejeu bit-à-bit ·
`PORT-09` amortissement et pire cas.

### Deux choses que le travail a rendues et que personne n'avait demandées

**L'absence de déchets est devenue typée.** `Free` exige une boîte vide : un
acteur ne peut pas disparaître en laissant des messages non lus, parce que le
terme qui le libérerait n'a pas de dérivation. Le manuscrit ne portait cette
garantie sous aucune forme.

**Le contrôle a rectifié un relecteur.** Sa correction recommandée pour la loi
de cohérence était *pire* que le défaut — quatorze contre-exemples contre dix.
Le calcul a montré qu'aucune définition de ⊖ ne peut sauver la loi, parce que
deux cas exigent d'ω ⊖ ω deux valeurs contradictoires. C'est une restriction, pas
une convention.

---

## Ce qui reste

### Les neuf théorèmes qui changent d'énoncé

Le programme les inventorie ; **deux sont faits**, sept restent.

| État | Théorème | Ce qui change |
|---|---|---|
| ✅ | P4 (rejeu) | gradué par la couche — trois régimes |
| ✅ | P3 (coût) | borne le travail *et* la profondeur |
| | loi de cohérence | doit valoir aussi pour la composition parallèle |
| | progression | en couche 2, devient la progression du pool |
| | divulgation, non-interférence | **refonte** — l'ordonnanceur entre dans le modèle d'attaquant |
| | absence d'interblocage | devient corollaire ; l'hypothèse du graphe cesse d'être posée |
| | sûreté spatiale | la disjonction doit valoir sur le pool |
| | préservation du potentiel | la trace est un ordre partiel ; le potentiel décroît le long de chaque chaîne |
| | correction de ressource | la configuration gagne un composant par membre du pool |

**Le plus lourd est la refonte de la non-interférence.** La notion séquentielle
ne survit pas à la concurrence, et il faut lui substituer une notion qui tienne
l'ordonnanceur pour un attaquant. C'est un travail de fond, pas une réécriture.

### Les lots non entamés

| Lot | Fiches | Nature |
|---|---|---|
| `PREUVE` | 16 | dettes de démonstration sur des objets construits |
| `FACT` | 24 | factorisations à écrire — théorèmes aspirateurs |
| `STRUCT` | 13 restantes | architecture réparable, présentation à changer |
| `PORT` | 15 restantes | énoncés qui promettent plus qu'ils ne tiennent |
| `IMPL` | 9 | exigences sur le compilateur et l'outillage |
| `REECR` | 27 | réécriture finale — **à faire en dernier** |
| `REFUS` | 7 | factorisations à documenter comme refusées, **dans un fichier à part** |
| `BIB` | 11 | vérifications de sources externes |

### Les décisions qui te restent

| | Arbitrage | État |
|---|---|---|
| `ARB-PR-03` | le traitement des effets à portée | **ouvert** — cinq relecteurs sur six disent que le monoïde est une pièce nouvelle que l'effet n'absorbe pas |
| `ARB-PR-05` | le cadre d'ensemble du noyau minimal | partiellement tranché par le choix de la voie 2 |

Les quatre imports ciblés que tu as validés — théorie de modes, calf et decalf,
types gradués formalisés, récursion gardée multi-horloges — ne sont pas encore
versés au texte. Le dernier répond à la clause de taille, qui est corrigée
autrement ; les trois autres restent à instruire.

### Ce qui n'est pas à moi

**T-68** — la sélection des mots pour les quarante-quatre primitives en cours.
Dix nouvelles depuis trois jours, chacune avec ses candidats et le motif de
l'écart ; le choix reste à ta main.

---

## L'ordre que je propose pour la suite

1. **Les sept théorèmes restants**, dans l'ordre du programme — en commençant
   par la loi de cohérence sous `∥`, qui est courte et conditionne les autres.
2. **La refonte de la non-interférence**, qui est le gros morceau et mérite sa
   propre séance.
3. **Le lot `FACT`**, parce qu'il réduit le document pendant que le reste
   l'augmente.
4. **Le lot `REECR` en dernier** — les énoncés ne se stabilisent qu'une fois les
   objets stabilisés, et réécrire plus tôt obligerait à réécrire deux fois.

Le fichier des factorisations refusées est à créer quand j'attaquerai `FACT` :
il n'a de sens qu'en regard de celles qu'on accepte.
