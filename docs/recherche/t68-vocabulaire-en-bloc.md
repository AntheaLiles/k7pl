<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# T-68 — le vocabulaire des primitives, en un seul bloc

**Séance 32 (6 octobre 2026).** Réponse à la décision de l'auteur : « *En bloc car il y a un besoin de complétude et un besoin de cohérence dans le choix du vocabulaire.* »
Ce document consolide en **un bloc complet et cohérent** la proposition de [`primitives.md`](../suivi/primitives.md) (table du 6 octobre, 46 lignes) : il couvre toutes les primitives
du manuscrit tel qu'il est après les rédactions de la séance 32 (**49 lignes**, 50 règles de constructeur ; les quatre règles sans constructeur sont à part), il fixe ce que
« mot » veut dire, il énonce les règles de forme, il vérifie les collisions et la cohérence, et il donne les renvois. **Rien n'est renommé dans le manuscrit** : `T-68` est l'avant-dernier
point de l'ordre de finition, juste avant la release `spec-v0.1.0`. La [table de renommage mécanique](../suivi/t68-table-de-renommage.md) est prête, et le script
[`scripts/t68_renommer.py`](../../scripts/t68_renommer.py) l'applique d'un coup après ratification (essai à blanc par défaut).

## 1. Ce que la proposition du 6 octobre ne tenait pas

Trois défauts, qui sont ceux que la décision de l'auteur désigne.

1. **Incomplétude.** La table portait 46 lignes ; la correction des grammaires (§A.3 du [journal 32](../journal/2026-10-06-pr-02-32-redactions-de-l-auteur.md)) a ajouté trois
   primitives, `next`, `loc` et `declassify`, qui n'avaient pas de mot. Le « 44 » de la demande est le compte d'une version antérieure : le compte exact est donné au §5.
2. **Deux registres confondus.** La colonne « Mot » mêlait des mots de code anglais (`lambda`, `thunk`, `force`, `handle`, `perform`) et des noms français
   (`repliage`, `mise en parallèle`, `émission`), sans dire lequel nomme quoi. Et elle contredisait un passage du manuscrit : le chapitre 3 (§3.5, grammaire des termes) pose que
   « les constructeurs du noyau nomment ce qu'une chose _est_, les mots de surface ce qu'un programme _fait_ », de sorte que `operation` et `scoped` ne se renomment pas `perform`
   et `handle`, qui sont des mots de surface.
3. **Collisions non relevées.** `at` désignait deux formes (la lecture d'une valeur permanente et l'exécution en un lieu) ; `open` est pris par les fichiers ; le chapitre 3 écrit déjà
   « `unpack` explicite » là où la grammaire écrit `open` ; trois constructeurs sont des mots tronqués (`inj`, `iter`, `vmap`) dans une grammaire dont les autres sont entiers.

## 2. Les trois registres, et ce qu'un « mot » est

| Registre | Ce qu'il nomme | Langue | Où il se lit |
|---|---|---|---|
| **K** | le _constructeur du noyau_ : ce que la grammaire des termes écrit (`\mathsf{…}`) | anglais, un mot entier, minuscules | grammaires, règles, sémantique opérationnelle |
| **N** | le _nom_ de la primitive dans la prose, au glossaire et à l'index | français, un substantif | chapitres, glossaire |
| **S** | le _mot de surface_ que le programme écrit (chapitre 5) | anglais | syntaxe du chapitre 5 ; **inchangé** par `T-68` |

Le « mot » de la table du 6 octobre devient le **nom N**. Le registre K ne change que là où une règle de forme l'exige (§3), et le registre S n'est pas touché : `perform`, `handle`, `match`,
`cond`, `select`, `pure`, `terminates` restent ce qu'ils sont, et `operation` et `scoped` restent les noms K de ce que `perform` et `handle` écrivent en surface.

## 3. Les règles de forme

**Pour K.**

* **R-K1** — un mot anglais _entier_, pas de troncature : `inject`, `iterate`, `vectormap`, `placed` ; les noms mathématiques établis d'un seul mot (`fix`, `out`, `fold`, `unfold`, `box`, `try`) en sont, étant des mots entiers.
* **R-K2** — l'introduction et l'élimination d'une même forme portent des mots symétriques : `pack`/`unpack`, `box`/`unbox`, `fold`/`unfold`.
* **R-K3** — un mot K désigne _une_ forme : `at` ne désigne plus que l'exécution en un lieu, `at_n` ; la lecture d'une valeur permanente s'appelle `current`.
* **R-K4** — les introductions temporelles sont des adverbes (`always`, `now`, `next`), leurs éliminations des verbes ou une conjonction (`current`, `wait`, `when`) ; `delay` est le verbe du calcul différé.

**Pour N.**

* **R-N1** — un substantif français, au singulier, sans article ; un complément n'est ajouté que pour lever une collision (« décomposition de paire », « élimination de l'unité », « opération à portée »).
* **R-N2** — quatre emprunts anglais seulement, ceux que l'auteur a _retenus_ : `thunk`, `force`, `return`, `pack` ; `unpack`, leur symétrique, en est un cinquième par R-K2.
* **R-N3** — un mot retenu par l'auteur est conservé tel quel ; la table l'indique (colonne « Origine »).
* **R-N4** — deux primitives ne portent jamais le même nom N ni le même mot K ; un nom N qui désigne aussi un autre objet du manuscrit est signalé au §4.

## 4. La table

Colonnes : la règle de typage ; la famille de la revue ; le constructeur K actuel et proposé ; le nom N proposé ; l'état de la proposition du 6 octobre (mot, état) ; l'origine du mot ; la raison.
« **Origine** » : _retenu_ = mot retenu par l'auteur dans la fiche ; _arc G_ = doctrine de nommage du 31 août ; _proposé_ = proposition de la revue ; _usage_ = usage établi du manuscrit ;
_séance 32_ = primitive ou mot nouveau.


| Règle | Famille | K actuel | K proposé | N proposé | 6 oct. : mot (état) | Origine | Raison |
|---|---|---|---|---|---|---|---|
| `Var` | noyau | `x` | `x` | variable | variable (retenu) | retenu | universel |
| `Lam` | noyau | `λx.c` | `λx.c` | abstraction | lambda (proposé) | arc G | calque français établi ; le mot anglais « lambda » reste un mot de code, non le nom de la règle |
| `App` | noyau | `c v` | `c v` | application | application (proposé) | proposé | terme exact, couvre aussi la composition ; ne s'écrit jamais |
| `Th` | noyau | `thunk` | `thunk` | thunk | thunk (retenu) | retenu | emprunt retenu (Levy) : le premier des quatre emprunts conservés |
| `Fo` | noyau | `force` | `force` | force | force (retenu) | retenu | emprunt retenu (Levy) : le deuxième |
| `Ret` | noyau | `return` | `return` | return | return (retenu) | retenu | emprunt retenu (Levy) : le troisième |
| `Let` | noyau | `let x ← c in c` | `let x ← c in c` | liaison séquentielle | let (proposé) | arc G | le mot de la doctrine du 31 août ; le séquencement est le nom de la composition des effets, que `let` met en œuvre |
| `One` | connecteurs | `()` | `()` | unité | unit (proposé) | arc G | nom du type unité |
| `OneE` | connecteurs | `let () = v in c` | `let () = v in c` | élimination de l'unité | (aucun mot) (à arbitrer) | séance 32 | pas de mot propre : la règle n'a que sa forme |
| `Pair` | connecteurs | `(v, v)` | `(v, v)` | paire | pair (proposé) | arc G | usuel ; ne dit pas la disjonction des ressources (P1), qu'une remarque dit |
| `Split` | connecteurs | `let (x,y) = v in c` | `let (x,y) = v in c` | décomposition de paire | split (proposé) | arc G | le complément « de paire » évite la collision avec la décomposition module × ordre du grade |
| `Inj` | connecteurs | `inj_i` | `inject_i` **→** | injection | inject (proposé) | arc G | R-K1 : pas de mot tronqué |
| `Case` | connecteurs | `case` | `case` | filtrage | case (proposé) | arc G | `match` reste réservé au filtrage de textes |
| `With` | connecteurs | `⟨c_i⟩` | `⟨c_i⟩` | conjonction additive | with (proposé) | usage | le nom de la forme dans tout le manuscrit |
| `Proj` | connecteurs | `c.i` | `c.i` | projection | project (proposé) | arc G | collision avec la projection observationnelle π_ℓ : même mot, deux objets, signalée |
| `Pack` | existentielle | `pack` | `pack` | pack | pack (retenu) | retenu | emprunt retenu : le quatrième |
| `Open` | existentielle | `open` | `unpack` **→** | unpack | unpack (proposé) | proposé | R-K2 : symétrique de `pack` ; `open` est pris par les fichiers ; le texte écrit déjà « unpack explicite » |
| `Box` | gradation | `box_r` | `box_r` | promotion | box (proposé) | usage | le mot de la logique linéaire, déjà employé (ch. 3, ch. 4) |
| `Unbox` | gradation | `unbox` | `unbox` | restitution | unbox (proposé) | séance 32 | dit ce que la règle rend : le grade |
| `Sc` | effets | `scoped_f` | `scoped_f` | opération à portée | handle (proposé) | usage | le noyau nomme ce que la chose est ; le mot de surface est `handle` |
| `Op` | effets | `operation_ε` | `operation_ε` | opération | perform (proposé) | usage | le noyau nomme ce que la chose est ; le mot de surface est `perform` |
| `Fold` | points fixes | `fold` | `fold` | repliage | repliage (retenu) | retenu | Malcolm ; sans concurrent |
| `Unfold` | points fixes | `unfold` | `unfold` | dépliage | dépliage (retenu) | retenu | inverse exact du précédent |
| `Out` | points fixes | `out` | `out` | observation | observation (retenu) | retenu | structure de la coalgèbre terminale |
| `Cop` | points fixes | `⟨⟨j ↦ c_j⟩⟩` | `⟨⟨j ↦ c_j⟩⟩` | copatron | copatron (retenu) | retenu | Abel et Pientka, seul en usage |
| `Gen` | connecteurs | `Λα. c` | `Λα. c` | généralisation | généralisation (proposé) | proposé | collision avec la généralisation des variables d'unification (§6.1), signalée |
| `Inst` | connecteurs | `c [W]` | `c [W]` | instanciation | instanciation (proposé) | proposé | Damas et Milner |
| `Del` | temporelles | `delay` | `delay` | délai | différer (à arbitrer) | séance 32 | le texte écrit « après un délai » ; introduction de ○C |
| `Alw` | temporelles | `always` | `always` | permanence | toujours (à arbitrer) | séance 32 | introduction de □V : adverbe |
| `Alw^{-}` | temporelles | `at` | `current` **→** | lecture instantanée | à (à arbitrer) | séance 32 | R-K3 : `at` désignait deux formes (□ et @) ; la valeur courante d'une valeur permanente |
| `Now` | temporelles | `now` | `now` | présence | maintenant (à arbitrer) | séance 32 | introduction de ◇V : adverbe |
| `Nxt` | temporelles | `next` | `next` | pas suivant | suivant (à arbitrer) | séance 32 | introduction de ○V : adverbe ; ajoutée avec la correction des grammaires |
| `Wait` | temporelles | `wait` | `wait` | attente | attendre (à arbitrer) | séance 32 | élimination de ○◇V : verbe |
| `When` | temporelles | `when` | `when` | déclenchement | quand (à arbitrer) | séance 32 | élimination de ◇V : conjonction |
| `VecI`, `VecE` | gradation | `[v₀,…] / iter_V` | `[v₀,…] / iterate_V` **→** | pli indexé gradué | pli indexé gradué (proposé) | proposé | R-K1 : `iter` devient `iterate` ; le vecteur est une instance du pli |
| `Fix` | points fixes | `fix` | `fix` | point fixe | point fixe (retenu) | retenu | Datafun ; « récursion » serait faux ; règle non nommée (`eq:regle-fix`) |
| `Par` | parallèle | `c ∥ c` | `c ∥ c` | mise en parallèle | mise en parallèle (retenu) | retenu | dit l'absence d'ordre |
| `Vmap` | parallèle | `vmap` | `vectormap` **→** | application vectorisée | application vectorisée (retenu) | retenu | R-K1 : `vmap` devient `vectormap` |
| `Spawn` | couche 2 | `spawn` | `spawn` | engendrement | engendrement (retenu) | retenu | création sans attente |
| `Slice` | mémoire | `slice` | `slice` | découpe | découpe (provisoire) | proposé | provisoire levé : `slice` est le mot du code d'erreur `ERR-SLC` et de la règle ; `partition` et `tranche` écartés |
| `New` | couche 2 | `new_E` | `new_E` | création de boîte | création de boîte (retenu) | retenu | contexte nul : rien |
| `Send` | couche 2 | `send` | `send` | émission | émission (retenu) | retenu | l'asynchronie est primitive |
| `Guard` | couche 2 | `guard` | `guard` | réception gardée | réception gardée (retenu) | retenu | un motif conjonctif de messages est consommé d'un seul tenant |
| `Free` | couche 2 | `free` | `free` | libération | libération (retenu) | retenu | même mot que pour les ressources de couche 1 |
| `Loc` | couche 1 | `loc_n` | `placed_n` **→** | marque de lieu | lieu (à arbitrer) | séance 32 | R-K1 : pas d'abréviation ; introduction de @ₙV ; ne pas confondre avec `at_n` |
| `At` | couche 1 | `at_n` | `at_n` | localisation | localisation (retenu) | retenu | même mot que la modalité qui le type |
| `Move` | couche 1 | `move_{n→m}` | `move_{n→m}` | déplacement | déplacement (retenu) | retenu | la ressource reste unique |
| `Try` | couche 1 | `try` | `try` | récupération | récupération (retenu) | retenu | un recours, non une garantie d'éviter la chute |
| `Declassify` | noyau | `declassify_ℓ` | `declassify_ℓ` | déclassification | déclassification (retenu) | usage | Sabelfeld et Myers, mot du manuscrit (22 emplois) ; règle nommée à la séance 32 |

Les quatre règles de typage qui ne gouvernent aucun constructeur n'ont pas de mot, et n'en reçoivent pas :

| Règle | Pourquoi |
|---|---|
| `Tick` | instance de `Op` : n'a pas de mot propre, `tick` est le nom de l'opération et non d'un constructeur |
| `Expand` | l'expansion des macros a lieu en Phase 1, avant la grammaire : pas un constructeur |
| `Sub` | règle de sous-typage : s'applique à tout terme sans en former |
| `SubBox` | règle de sous-typage de la modalité graduée |

## 5. Complétude

* **49 lignes**, qui couvrent les **50 règles de constructeur** du manuscrit (`VecI` et `VecE` partagent une ligne ; `Fix` est une règle sans nom, `eq:regle-fix`) et les **4 règles** qui n'ont pas de constructeur : au total les
  **53 règles** que compte le contrôle de croisement (`scripts/controles/croise.py`), plus `Fix`. Le nombre de **44** de la demande est celui d'un état antérieur de la table ; les 46 lignes du 6 octobre
  deviennent 49 par `Nxt`, `Loc` et `Declassify`.
* **Garde mécanique** : `scripts/controles/vocabulaire.py` lit cette table et échoue si une règle du manuscrit n'y a pas de ligne, si une ligne désigne une règle absente, si deux lignes portent le même K ou le même N, ou si un K ou
  un N est un mot réservé.
* **Constructeurs K** : 13 valeurs et 36 calculs (compte du contrôle) ; la table en porte 49, dont `Fix` n'est pas un des 49 du contrôle (règle non nommée) et dont `VecI`, `VecE` en font deux.

## 6. Collisions

Vérifiées contre les mots réservés de K7PL (`pure`, `terminates`, `event`, `contract`, `logic`, `perform`, `handle`, `handler`, `match`, `cond`, `select`, `comptime`, `binds`, `bind-to`, `var`, `end`) et contre les mots du manuscrit.

| Mot | Collision | Verdict |
|---|---|---|
| K `unpack` | aucune ; le manuscrit emploie déjà « `unpack` explicite » (§3.3, annexe A, §6.1) | **résout** une collision : `open` est pris par les fichiers |
| K `current` | aucune ; `extract` aurait heurté la « fonction d'extraction » du §3.2 (extraction de preuve) | écarté au profit de `current` |
| K `placed` | aucune | — |
| K `inject`, `iterate`, `vectormap` | aucune ; `inject` s'accorde avec `injection` (N) | — |
| N « projection » | la projection observationnelle π_ℓ (ch. 2, ch. 4) | **acceptée** : deux objets, le contexte tranche, le glossaire les distingue |
| N « généralisation » | la généralisation des variables d'unification (§6.1, Phase 4) | **acceptée**, même raison |
| N « abstraction » | l'abstraction de données de la non-interférence (ch. 2) | **acceptée** ; la doctrine du 31 août emploie déjà ce mot pour `Lam` |
| N « observation » | l'équivalence observationnelle | **acceptée** : c'est la même idée (ce que l'on peut distinguer par `out`) |
| N « liaison séquentielle » | le séquencement des effets | **voulue** : `let` met en œuvre le séquencement ; le mot est celui de la doctrine du 31 août |
| N « décomposition de paire » | la décomposition module × ordre du grade | **levée** par le complément « de paire » |
| N « libération » | la libération des ressources de couche 1 | **voulue** : même idée |
| N « délai » | « après un délai » (modalités temporelles) | **voulue** |

## 7. Cohérence morphologique

* **K** : les formes symboliques (`x`, `λx.c`, `c v`, `()`, `(v, v)`, `⟨c_i⟩`, `c.i`, `Λα. c`, `c [W]`, `[v₀,…]`, `c ∥ c`, `⟨⟨j ↦ c_j⟩⟩`) ne portent pas de mot ; toutes les autres portent un mot anglais entier, en minuscules, sans trait d'union ; les indices (`_i`, `_r`, `_ε`, `_n`, `_E`, `_f`, `_ℓ`) ne changent pas le mot.
* **Paires** : `pack`/`unpack`, `box`/`unbox`, `fold`/`unfold`, `always`/`current`, `now`/`when`, `next`/`wait` (introduction/élimination des trois modalités), `placed`/`move` (introduction de `@ₙV` et déplacement), `new`/`free`, `send`/`guard`, `spawn`/(sans élimination : l'engendrement ne se défait pas).
* **N** : tous des substantifs ; 35 mots simples (dont les 5 emprunts : `thunk`, `force`, `return`, `pack`, `unpack`) et 14 locutions (complément de collision ou nom composé établi : « mise en parallèle », « application vectorisée », « création de boîte », « réception gardée », « pas suivant », « lecture instantanée », « marque de lieu », « point fixe », « pli indexé gradué », « conjonction additive », « opération à portée », « décomposition de paire », « élimination de l'unité », « liaison séquentielle »).
* **Aucun mot ne désigne deux primitives** ; le seul mot K qui en désignait deux (`at`) est scindé.

## 8. Renvois

Où se lit chaque mot K qui change : voir la [table de renommage](../suivi/t68-table-de-renommage.md), qui donne les fichiers et les nombres d'occurrences. Les mots K qui ne changent pas n'ont pas de renvoi à corriger ;
les noms N ne s'écrivent dans le manuscrit qu'au glossaire, et l'ajout des entrées manquantes se fait au renommage (la table en tient la liste). Le registre `scripts/controles/croise.py` (motifs de la grammaire) et `docs/suivi/primitives.md`
(champs `SYMBOLE`) suivent le renommage.

## 9. Points sur lesquels la proposition arbitre, et ses alternatives

À ratifier avec le bloc, ou à amender un par un sans défaire le reste (les règles du §3 disent ce qui doit rester vrai).

| Point | Proposé | Alternative | Pourquoi le proposé |
|---|---|---|---|
| lecture d'une valeur permanente | `current` | `extract` (le nom de la coünité) ; `sample` | `extract` heurte « extraction » ; `sample` évoque l'échantillonnage |
| introduction de `@ₙV` | `placed_n` | `here_n` ; `loc_n` | R-K1 écarte `loc` ; `here` désigne un lieu courant que la configuration n'a pas |
| mots tronqués | `inject`, `iterate`, `vectormap` | garder `inj`, `iter`, `vmap` (usage de la littérature) | R-K1 : la grammaire n'a pas d'autre mot tronqué ; le renommage est mécanique |
| langue du nom N | français, cinq emprunts | anglais partout | le manuscrit et le glossaire sont en français ; la doctrine du 31 août nommait déjà en français |
| `slice` | conservé | `partition` | mot du code `ERR-SLC` et de la règle ; `partition` heurte la partition `ρ = ρ₁ ⊎ ρ₂` qu'elle exige |
| `Sc`, `Op` | K inchangés | `handle`, `perform` en K | passage du ch. 3 : le noyau nomme ce que la chose _est_ |
| noms N du noyau CBPV et de l'existentielle | `thunk`, `force`, `return`, `pack`, `unpack` (emprunts retenus) | `suspension`, `forçage`, `retour`, `empaquetage`, `ouverture` (doctrine du 31 août, descriptive) | l'auteur a retenu les quatre emprunts à la fiche ; les noms français de la doctrine désignaient des familles |
| N de `Sc` | « opération à portée » | « gestionnaire » (doctrine) | « gestionnaire » nomme une _valeur_ (ch. 3), non la forme `scoped` |
| N de `Box`, `Unbox` | « promotion », « restitution » | « entrée sous la modalité », « sortie » (doctrine) | des noms simples ; « promotion » est déjà employé |

## 10. Ratification

« En bloc » : accepter ce document, c'est accepter les trois registres, les règles du §3 et les 49 lignes du §4. Les alternatives du §9 peuvent être substituées sans autre travail que de modifier la ligne concernée
de la table de renommage. Après ratification : appliquer `python3 scripts/t68_renommer.py --appliquer`, ajouter les entrées de glossaire (liste dans la table de renommage), puis `lake build Spec`, `python3 scripts/controle.py` et
`python3 scripts/suivi.py all`.
