-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE
--
-- SPDX-License-Identifier: CC-BY-4.0

-- Converted from the Org-mode manuscript by scripts/org2verso/convert.py. From the commit that
-- introduces this file on, the Verso source is the source of truth: edit it directly.

import VersoManual
import SpecExt

open Verso.Genre Manual
open SpecExt

set_option linter.unusedVariables false

#doc (Manual) "Modèles de mémoire" =>
%%%
file := "c4-modeles-de-memoire"
tag := "c4-modeles-de-memoire"
%%%

{label "sec:c4-modeles-de-memoire"}

Le chapitre 1 (§{num "sec:c1-postulats"}[]) a posé que l'absence de course à la donnée et la sûreté
mémoire se déduisent de l'absence de diagonale dans _C_, sans le démontrer. C'est ici que la
démonstration a son lieu, puisque les deux objets qu'elle met en jeu — la fibrille et l'arène —
viennent d'être construits. La capacité d'écriture $`\mathsf{WriteCap}(r)` est une ressource
linéaire au sens du chapitre 3 (§{num "sec:c3-le-systeme-gradue"}[]), et l'énoncé n'emploie de son
grade que le caractère linéaire.

Un modèle dénotationnel existe pour cette discipline. Il est situé ici plutôt qu'adopté. Un _espace
de capacité_ est un ensemble muni d'une relation de poids qui assigne à chaque valeur les ensembles
de capacités qu'elle peut détenir. Un morphisme y est une fonction qui préserve les poids, et ses
auteurs établissent que ce sont précisément les fonctions sûres du point de vue des capacités, sans
accès non autorisé ni autorité ambiante {cite "choudhuryRecoveringPurityComonads2020"}[]. Ce modèle
valide la discipline que ce document emploie, non son énoncé : son objet est la permission de
produire un effet, quand celui du théorème est la disjonction de régions. Et il sert un système qui
recouvre la pureté depuis un ambiant impur, direction que ce document écarte ; l'adopter comme
sémantique importerait la lecture relative de la pureté qu'il refuse.

::::thm (label := "thm:surete_spatiale")
:::title
sûreté spatiale par capacités linéaires
:::

:::statement +titled
Impossibilité de mutation concurrente

Soient $`t_1` et $`t_2` deux membres du multi-ensemble de calculs, composés par la règle {sc}[Par]
de l'annexe (§{num "sec:g-parallelisme"}[]) et donc sous des contextes _additionnés_,
$`\Delta_1 + \Delta_2`. Soit $`\mathsf{WriteCap}(r)` une capacité d'écriture sur une région d'arène
$`r`. Si $`\Delta_1 \vdash t_1 : \mathsf{WriteCap}(r) \multimap \mathsf{Unit}`, alors il n'existe
aucun terme $`t_2'` tel que $`\Delta_2 \vdash t_2' : \mathsf{WriteCap}(r) \multimap \tau`, quel que
soit $`\tau` : aucune opération mutante sur $`r` n'est typable sous $`\Delta_2`.
:::

:::proofsketch
Instance du lemme de capacité (chapitre 2, §{num "sec:c2-six-schemas-de-metatheorie"}[],
théorème {num "thm:lemme_capacite"}[]), la ressource étant la région $`r` et la capacité
$`\mathsf{WriteCap}(r)`. Celle-ci vit dans le fragment linéaire strict de _C_, lequel ne porte par
construction aucun morphisme de duplication $`A \to A \otimes A`. C'est l'_addition_ des contextes
qui porte la disjonction, et c'est ce que la règle {sc}[Par] donne : une capacité de grade $`1`
présente dans $`\Delta_1 + \Delta_2` y est présente une seule fois, la somme des grades valant $`1`
et non $`2`. Sa consommation par $`t_1` la retire donc structurellement de $`\Delta_2`, et le
raisonnement vaut sur le multi-ensemble entier par associativité de l'addition. Sans elle dans son
propre contexte de typage, $`t_2` ne peut construire aucun terme bien typé opérant sur $`r` :
l'absence se lit sur la dérivation, sans analyse supplémentaire.
:::
::::

Une hypothèse porte tout, et elle n'est pas gratuite. {rmq}[C'est le sens unique d'imbrication des
délimiteurs qui tient l'hypothèse. Ce théorème dit ce qui casse dans l'autre sens.] La preuve
suppose les deux contextes disjoints, ce que $`\Gamma_1 \otimes \Gamma_2` écrit mais ne garantit pas
par lui-même dès que les fragments s'imbriquent. La couche 3 admet la contraction ; si une valeur
cartésienne pouvait capturer une capacité linéaire, la duplication licite en couche 3 dupliquerait
une ressource qui ne doit pas l'être, et l'énoncé tomberait. La logique adjointe donne le
contre-exemple sous forme courte et la parade avec : c'est la déclaration d'indépendance entre
modes, sans laquelle la contraction du mode le plus permissif fuit vers le mode le plus contraint {cite "PCPR18AdjointLogic"}[].
Le chapitre 5 (§{num "sec:c5-s-expressions-universelles"}[]) justifie le sens unique d'imbrication
des délimiteurs par l'inclusion des contextes ; ce qu'il ne montre pas est ce qui casse dans l'autre
sens, et c'est ce théorème.

S'il tient, l'absence de course à la donnée exigée par P4 et la sûreté mémoire exigée par P3 cessent
d'être des propriétés à vérifier sur le langage : ce sont deux lectures de l'absence de diagonale
dans _C_. S'il tombe — si la déclaration d'indépendance entre modes n'était pas tenable —, il
faudrait un mécanisme d'exécution pour interdire la mutation concurrente, c'est-à-dire ce que le
postulat d'autonomie physique refuse.

Ce que les arènes viennent de faire pour l'acteur, la mémoire physique le fait sur sept niveaux, et
c'est ici qu'il faut le dire puisque la section précédente vient d'en poser le cas principal. Cette
hiérarchie instancie l'exigence d'effacement que le chapitre 3 (§{num "sec:c3-le-systeme-gradue"}[])
pose pour les grades ; aucun de ses niveaux ne s'appuie sur un ramasse-miettes ou un comptage de
références atomique.

:::comment
```
À explorer pour un futur état de l'art de cette annexe : gestion mémoire par régions (Tofte et Talpin), hash-consing et structures persistantes (Appel ; Baker), comparaison avec les hiérarchies mémoire sans GC de Rust et de Zig.
```
:::

::::k7table (label := "tab:memoire") (align := "lZ{0.69}Z{1.31}ll")
:::caption
Les sept niveaux de gestion mémoire de K7PL
:::

:::table +header
* * Niveau
  * Mécanisme
  * Usage
  * Couche
  * Coût
* * 1
  * Pointeurs tagués
  * Encodage direct des scalaires dans le mot machine
  * L2/L3
  * $`O(1)`
* * 2
  * Allocation sur la pile
  * Liaisons locales non-échapantes
  * L3
  * $`O(1)`
* * 3
  * Régions scopées
  * Arènes temporaires bornées par un grade $`r`
  * L2/L3
  * $`O(1)`
* * 4
  * Tas avec ownership
  * Données mutables (transfert linéaire/affin)
  * L2
  * $`O(1)` amorti
* * 5
  * Déduplication canonique
  * Graphes immuables partagés (hash-consing BLAKE3)
  * L1
  * $`O(1)`
* * 6
  * Arènes linéaires contiguës
  * Données SoA pour ECS
  * L1
  * $`O(1)`
* * 7
  * Mémoire linéaire WAT
  * Interfaçage physique brut (FFI, DMA)
  * L1
  * $`O(1)`
:::
::::

Le cinquième régime appelle une précision que le tableau ne peut pas porter, et dont la réponse
n'est pas indifférente. La déduplication canonique est un partage de graphe ; reste à dire si ce
partage est _observable_ depuis le langage. La question n'est pas oiseuse : observer que deux
sous-termes sont le _même objet_, et non seulement égaux, c'est observer la représentation et non la
valeur, et toute solution directe y perd la transparence référentielle {cite "gillTypesafeObservableSharing"}[].

Deux réponses sont possibles et il faut en choisir une. K7PL retient la première — le partage n'est
pas observable, la déduplication est une propriété de la représentation et rien du langage ne permet
de la constater —, de sorte que la transparence est préservée sans condition. La seconde réponse
resterait ouverte si le besoin s'en faisait sentir : rendre le partage observable _sous une
modalité_, la transparence étant alors préservée partout où la modalité est absente. C'est une
possibilité que les grades donnent et que la littérature citée, qui n'en a pas, ne pouvait pas
envisager.

Deux travaux plus récents rendent cette seconde voie moins spéculative. L'un traite le partage et la
mutation par des _coeffets_, c'est-à-dire par l'appareil même de ce document {cite "bianchiniCoeffectsSharingMutation2022"}[]~;
l'autre établit que le partage _maximal_ se décide, ce qui borne ce qu'un compilateur peut promettre {cite "grabmayerMaximalSharingLam"}[].
Ce chapitre n'emprunte ni l'un ni l'autre — son choix reste que le partage n'est pas observable —,
mais l'ouverture qu'il laisse n'est pas une porte sur du vide.
