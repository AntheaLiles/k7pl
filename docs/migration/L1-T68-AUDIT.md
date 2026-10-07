<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# T-68 — Audit de minimalité des primitives

**État :** IN PROGRESS  
**Source principale :** `docs/tracking/primitives.md`  
**Objectif :** établir la minimalité normative et formelle du noyau avant stabilisation de l'implémentation et de la mécanisation.

## 1. Premier constat

Le registre historique est intitulé « 44 primitives », mais son extraction structurée fait apparaître **45 entrées DOING**. Cette divergence doit être résolue avant toute conclusion sur le cardinal du noyau.

Le registre contient par ailleurs des entrées explicitement qualifiées de dérivées ou de décisions déjà prises contre une primitive, notamment le vecteur comme type dérivé et la codéréliction comme construction écartée. Le nombre lexical d'entrées ne peut donc pas être assimilé au nombre de primitives normatives.

Le premier résultat T-68 est ainsi méthodologique : **le cardinal 44 doit être démontré, et non repris comme donnée d'entrée.**

## 2. Critère de minimalité

Pour chaque candidat, l'audit doit établir :

`candidat → obligation → règle → propriété requise → preuve`

et, lorsqu'une factorisation ou dérivation a été examinée :

`candidat → construction candidate → obligations conservées/perdues → verdict`.

Une construction ne peut être déclarée dérivée simplement parce qu'elle possède une notation composite ou parce qu'une forme analogue existe dans la littérature. La factorisation est admissible uniquement si elle conserve les obligations pertinentes au même niveau d'abstraction.

Les refus historiques de `factorisations-refusees.md` constituent les premiers contre-exemples méthodologiques.

## 3. Inventaire extrait

| # | Opération | Famille | Règle | Verdict historique disponible |
|---:|---|---|---|---|
| 1 | Désigner une liaison | `noyau_CBPV` | `Var` | — |
| 2 | Fabriquer un calcul qui attend un argument | `noyau_CBPV` | `Lam` | — |
| 3 | Appliquer un calcul à une valeur | `noyau_CBPV` | `App` | — |
| 4 | Suspendre un calcul en une valeur | `noyau_CBPV` | `Th` | — |
| 5 | Reprendre un calcul suspendu | `noyau_CBPV` | `Fo` | — |
| 6 | Injecter une valeur dans un calcul trivial | `noyau_CBPV` | `Ret` | — |
| 7 | Séquencer deux calculs en liant le résultat du premier | `noyau_CBPV` | `Let` | — |
| 8 | Dénoter la seule valeur du type unité | `connecteurs` | `One` | — |
| 9 | Consommer l'unité sans rien lier | `connecteurs` | `OneE` | — |
| 10 | Réunir deux ressources disjointes | `connecteurs` | `Pair` | — |
| 11 | Défaire une paire en liant ses deux composantes | `connecteurs` | `Split` | — |
| 12 | Marquer une valeur d'une étiquette de somme | `connecteurs` | `Inj` | — |
| 13 | Choisir une branche selon l'étiquette | `connecteurs` | `Case` | — |
| 14 | Offrir plusieurs observations sur un même calcul | `connecteurs` | `With` | — |
| 15 | Sélectionner une observation | `connecteurs` | `Proj` | — |
| 16 | Cacher un témoin de type | `existentielle` | `Pack` | — |
| 17 | Ouvrir un témoin caché sans le laisser fuir | `existentielle` | `Open` | — |
| 18 | Entrer sous une modalité graduée | `gradation` | `Box` | — |
| 19 | Sortir d'une modalité graduée en restituant le grade | `gradation` | `Unbox` | — |
| 20 | Interpréter un calcul à effets dans un modèle donné | `effets` | `Sc` | — |
| 21 | Déclencher une opération de la signature | `effets` | `Op` | — |
| 22 | Replier un point fixe de type | `connecteurs` | `Fold` | — |
| 23 | Déplier un point fixe de type | `connecteurs` | `Unfold` | — |
| 24 | Observer un point fixe coinductif | `connecteurs` | `Out` | — |
| 25 | Définir par observations | `connecteurs` | `Cop` | — |
| 26 | Généraliser sur une variable de type | `connecteurs` | `Gen` | — |
| 27 | Instancier une variable de type | `connecteurs` | `Inst` | — |
| 28 | Différer un calcul d'un pas | `temporelles` | `Del` | — |
| 29 | Poser une garantie permanente | `temporelles` | `Alw` | — |
| 30 | Employer une garantie permanente | `temporelles` | `Alw^{-}` | — |
| 31 | Poser une garantie immédiate | `temporelles` | `Now` | — |
| 32 | Reporter une garantie éventuelle d'un pas | `temporelles` | `Wait` | — |
| 33 | Consommer une garantie éventuelle | `temporelles` | `When` | — |
| 34 | Plier une famille indexée sous grade | `gradation` | `VecI VecE` | — |
| 35 | Mettre deux calculs en parallèle | `connecteurs` | `Par` | — |
| 36 | Appliquer une fonction à tout un vecteur | `connecteurs` | `Vmap` | — |
| 37 | Engendrer une tâche concurrente | `couche 2` | `Spawn` | — |
| 38 | Découper une capacité d'écriture | `modèle mémoire` | `Slice` | — |
| 39 | Créer une boîte aux lettres | `couche 2` | `New` | — |
| 40 | Émettre un message vers une boîte | `couche 2` | `Send` | — |
| 41 | Recevoir sous garde | `couche 2` | `Guard` | — |
| 42 | Libérer une boîte vide | `couche 2` | `Free` | — |
| 43 | Localiser un calcul | `couche 1` | `At` | — |
| 44 | Déplacer une valeur d'un lieu à un autre | `couche 1` | `Move` | — |
| 45 | Récupérer d'une défaillance | `couche 1` | `Try` | — |

## 4. Anomalies à instruire avant l'audit de minimalité

### 4.1 Cardinal 44 / 45

Le registre fournit 45 entrées DOING. Il faut reconstruire le véritable ensemble des primitives à partir de la grammaire, des règles et des contraintes de clôture, puis expliquer explicitement toute différence entre :

- entrée de registre ;
- constructeur syntaxique ;
- règle de terme ;
- primitive conceptuelle ;
- primitive normative ;
- mécanisme dérivé ;
- élément d'implémentation.

Aucune correction du cardinal ne doit être faite par suppression éditoriale d'une entrée.

### 4.2 Vecteur

Le registre affirme que le vecteur est un type dérivé et que `VecI/VecE` sont les règles d'un « pli indexé gradué » qui n'est pas encore isolé comme primitive. Il faut donc décider au niveau conceptuel si le candidat réel est le vecteur, le pli indexé gradué, ou une structure plus fondamentale.

Cette analyse est particulièrement importante pour éviter de remplacer une primitive apparente par une autre primitive de même niveau sous un changement de vocabulaire.

### 4.3 Coalgèbre terminale

Le registre affirme que `ν` est primitive et que ses deux règles manquent dans la spécification. L'audit doit donc vérifier séparément :

- nécessité du constructeur de type ;
- nécessité de ses règles de terme ;
- relation avec les copatrons et `out` ;
- obligations de productivité ;
- relation avec les deux sortes de taille.

### 4.4 Diamant temporel

Le registre identifie `now`, `wait` et `when` comme primitifs dans le cadre des types de session et indique qu'une contrainte manque à `when`. La décision architecturale retenue dans `L1-DECISIONS.md` est d'introduire la structure supplémentaire requise. T-68 doit ensuite déterminer si cette structure constitue une primitive supplémentaire, une composante d'un connecteur existant, ou une règle structurale d'un niveau différent.

### 4.5 Constructions déjà qualifiées

Les entrées explicitement qualifiées de dérivées, refusées ou conditionnelles ne doivent pas être comptées automatiquement parmi les primitives. Elles restent toutefois dans le corpus parce qu'elles constituent des preuves négatives ou des obligations de justification.

## 5. Ordre de travail

1. Reconstruire l'ensemble des constructeurs et règles à partir de `spec/`.
2. Établir la correspondance registre historique ↔ spécification actuelle.
3. Classer chaque entrée selon son niveau ontologique.
4. Pour chaque primitive candidate, expliciter les obligations qui empêchent sa dérivation.
5. Rejouer les sept factorisations refusées comme tests négatifs de la méthode.
6. Chercher systématiquement les factorisations restantes.
7. Démontrer le cardinal final et documenter chaque exclusion.
8. Produire seulement alors une liste normative stabilisée des primitives.

## 6. Gate

T-68 est **OPEN / BLOCKING** pour la stabilisation de l'implémentation et de la mécanisation du noyau.

Un résultat compilable ou une implémentation déjà existante ne peut être utilisé pour fermer T-68. Inversement, T-68 n'interdit pas les expériences locales ; il interdit seulement de les prendre comme architecture normative stabilisée.

## 7. Provenance

Le présent audit est une extraction structurée du registre historique. Il ne transforme aucune de ses assertions en preuve. Les résultats doivent être confirmés contre `spec/` et, lorsque nécessaire, contre les références scientifiques invoquées dans le registre.
