<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# T-68 : ratifier le vocabulaire des primitives, face au manuscrit

Réponse à la demande de l'auteur : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher », et à sa décision sur `T-68` : « en bloc, car il y a un besoin de complétude et un besoin de cohérence dans le choix du vocabulaire ». Ce document ne remplace pas la [proposition en bloc](../t68-vocabulaire-en-bloc.md) : il la confronte au texte de `spec/` tel qu'il est le 6 octobre 2026, mesure ce que le renommage change, et formule ce qu'il y a à trancher. **Rien n'est renommé** : `spec/` n'a pas été touché.

Retour au [dossier des analyses](README.md).

## 0. Niveau de vérification

* **Fait.** Lecture du Verso (`spec/Spec/**`), de `tools/`, `tests/`, `scripts/`, `docs/suivi/` ; recherches textuelles exhaustives sur les six mots qui changent et sur les mots qui arrivent ; essai à blanc du script `scripts/t68_renommer.py` ; **application complète dans une copie du dépôt** (hors du dépôt, sous le répertoire temporaire de la session), suivie de `python3 scripts/controle.py` et de `python3 scripts/manuscript_metrics.py summary` ; mesure de la largeur des lignes de la grammaire avec `lualatex` (classe `report`, 10 pt, `amsmath` et `unicode-math`) ; calcul du bruit que produiraient les entrées de glossaire sur la reconnaissance automatique de `tools/SpecExt/AutoMark.lean`.
* **Non fait.** `lake build Spec` et `lake exe spec` n'ont pas été lancés (pas de `.lake` dans cet environnement) ; le PDF réel n'a pas été compilé : les largeurs mesurées sont celles d'un document de substitution, pas du document du dépôt (la classe et les marges du PDF réel ne sont pas lues ici). Aucune source externe n'est en cause : `T-68` est une question de cohérence interne.
* **Contrôle de la proposition.** Les chiffres de la proposition en bloc ont été recomptés ; trois écarts sont signalés au §10 (ils ne changent pas la décision).

## 1. En quelques lignes

* Le renommage **mécanique** est petit et sûr : **6 mots K** changent, sur **3 fichiers** du manuscrit (`C3/GrammaireDesTermes`, `C3/ReglesDeTypage`, `C4/SemantiqueOperationnelle`), **36 occurrences**, toutes dans des formules LaTeX ou des phrases qui citent la formule ; plus 6 motifs dans `scripts/controles/croise.py`. L'essai à blanc compte 42 remplacements, **identiques aux nombres de la table**.
* Appliqué dans une copie, le renommage laisse **tous les contrôles verts** (`controle.py` : « TOUS LES CONTROLES PASSENT », dont le croisement grammaire/règles et le contrôle du vocabulaire), est **idempotent** (deuxième passage : 0 remplacement), ne laisse **aucune forme ancienne** `\mathsf{inj|iter|vmap|open|loc}` ni `\mathsf{at}` hors `at_n`, et ne change **aucune mesure** du manuscrit.
* Aucun des six mots n'entre en collision avec un mot réservé de K7PL, de Lean, de Verso ou de LaTeX ; aucun n'est déjà employé dans `spec/` pour autre chose (`current`, `placed`, `inject`, `iterate`, `vectormap` : zéro emploi ; `unpack` : cinq emplois en prose, tous au sens voulu).
* Ce qui n'est **pas** mécanique, et qui mérite la décision de l'auteur : (a) le **glossaire** : y ajouter les 44 noms manquants ferait reconnaître automatiquement, en moyenne, des mots très courants (« opération », « variable », « application », « unité »…) dans les 733 emplois de prose qu'ils ont : jusqu'à **121 bulles de glossaire**, une par chapitre et par mot, sur des phrases ordinaires (§6.2) ; (b) la ligne `Vmap`, qui **ne respecte pas la règle R-K1** de la proposition (`vectormap` n'est pas un mot anglais entier) ; (c) la ligne `Alw^{-}` (`current`), proche de `now` par le sens ; (d) le nom N de `Op` (« opération »), qui est aussi le genre dont `Op` et `Sc` sont les deux espèces d'après le chapitre 3.
* La ratification peut se faire **en bloc** comme l'auteur le demande, avec **cinq décisions** (§9) dont chacune a une formulation et une option d'amendement ; les lignes à regarder en premier sont au §10.

## 2. Parcours des occurrences, ligne par ligne

### 2.1 Les 49 lignes de la proposition, face au texte

Chaque ligne de la table de la proposition (§4) est reprise avec : le mot K ancien et nouveau ; le nombre d'occurrences de ce mot K dans `spec/` sous la forme `\mathsf{…}` ou `\mathbf{…}` (les formes symboliques `λx.c`, `c v`… n'ont pas de mot : « — ») ; le nom N proposé ; le nombre de ses occurrences **en prose** (hors code et hors formules ; sans les entrées de glossaire elles-mêmes), le nombre de chapitres où il apparaît (Annexe A comprise) ; l'état au glossaire. Le compte du mot `at` est séparé : `\mathsf{at}` seul pour `Alw^{-}` (8), `\mathsf{at}_n` pour `At` (7).

| # | Règle | K (ancien → nouveau) | Occurrences de K dans `spec/` | Nom N | Occurrences de N en prose | Chapitres | Glossaire |
|--:|---|---|--:|---|--:|--:|---|
| 1 | `Var` | `x` | — | variable | 61 | 7 | à ajouter |
| 2 | `Lam` | `λx.c` | — | abstraction | 23 | 5 | à ajouter |
| 3 | `App` | `c v` | — | application | 50 | 6 | à ajouter |
| 4 | `Th` | `thunk` | 7 | thunk | 7 | 2 | à ajouter |
| 5 | `Fo` | `force` | 7 | force | 11 | 5 | à ajouter |
| 6 | `Ret` | `return` | 37 | return | 0 | 0 | à ajouter |
| 7 | `Let` | `let x ← c in c` | — | liaison séquentielle | 1 | 1 | à ajouter |
| 8 | `One` | `()` | — | unité | 47 | 8 | à ajouter |
| 9 | `OneE` | `let () = v in c` | — | élimination de l'unité | 0 | 0 | à ajouter |
| 10 | `Pair` | `(v, v)` | — | paire | 26 | 6 | à ajouter |
| 11 | `Split` | `let (x,y) = v in c` | — | décomposition de paire | 0 | 0 | à ajouter |
| 12 | `Inj` | `inj_i` → `inject_i` | 6 | injection | 1 | 1 | à ajouter |
| 13 | `Case` | `case` | 4 | filtrage | 17 | 7 | à ajouter |
| 14 | `With` | `⟨c_i⟩` | — | conjonction additive | 11 | 2 | à ajouter |
| 15 | `Proj` | `c.i` | — | projection | 67 | 7 | à ajouter |
| 16 | `Pack` | `pack` | 6 | pack | 0 | 0 | à ajouter |
| 17 | `Open` | `open` → `unpack` | 3 | unpack | 0 | 0 | à ajouter |
| 18 | `Box` | `box_r` | 6 | promotion | 3 | 2 | à ajouter |
| 19 | `Unbox` | `unbox` | 3 | restitution | 1 | 1 | à ajouter |
| 20 | `Sc` | `scoped_f` | 11 | opération à portée | 17 | 4 | présent |
| 21 | `Op` | `operation_ε` | 24 | opération | 185 | 7 | à ajouter |
| 22 | `Fold` | `fold` | 4 | repliage | 0 | 0 | à ajouter |
| 23 | `Unfold` | `unfold` | 3 | dépliage | 6 | 3 | à ajouter |
| 24 | `Out` | `out` | 6 | observation | 36 | 6 | présent |
| 25 | `Cop` | `⟨⟨j ↦ c_j⟩⟩` | — | copatron | 17 | 3 | présent |
| 26 | `Gen` | `Λα. c` | — | généralisation | 10 | 2 | à ajouter |
| 27 | `Inst` | `c [W]` | — | instanciation | 4 | 2 | à ajouter |
| 28 | `Del` | `delay` | 8 | délai | 11 | 5 | à ajouter |
| 29 | `Alw` | `always` | 7 | permanence | 3 | 2 | à ajouter |
| 30 | `Alw^{-}` | `at` → `current` | 8 | lecture instantanée | 0 | 0 | à ajouter |
| 31 | `Now` | `now` | 7 | présence | 15 | 7 | à ajouter |
| 32 | `Nxt` | `next` | 7 | pas suivant | 2 | 2 | à ajouter |
| 33 | `Wait` | `wait` | 8 | attente | 24 | 2 | à ajouter |
| 34 | `When` | `when` | 6 | déclenchement | 2 | 2 | à ajouter |
| 35 | `VecI`, `VecE` | `[v₀,…] / iter_V` → `[v₀,…] / iterate_V` | — | pli indexé gradué | 0 | 0 | à ajouter |
| 36 | `Fix` | `fix` | 14 | point fixe | 62 | 6 | à ajouter |
| 37 | `Par` | `c ∥ c` | — | mise en parallèle | 9 | 3 | à ajouter |
| 38 | `Vmap` | `vmap` → `vectormap` | 6 | application vectorisée | 2 | 2 | à ajouter |
| 39 | `Spawn` | `spawn` | 10 | engendrement | 0 | 0 | à ajouter |
| 40 | `Slice` | `slice` | 4 | découpe | 13 | 2 | à ajouter |
| 41 | `New` | `new_E` | 4 | création de boîte | 0 | 0 | à ajouter |
| 42 | `Send` | `send` | 6 | émission | 26 | 4 | à ajouter |
| 43 | `Guard` | `guard` | 6 | réception gardée | 0 | 0 | à ajouter |
| 44 | `Free` | `free` | 4 | libération | 13 | 4 | à ajouter |
| 45 | `Loc` | `loc_n` → `placed_n` | 8 | marque de lieu | 0 | 0 | à ajouter |
| 46 | `At` | `at_n` | 7 | localisation | 21 | 4 | présent |
| 47 | `Move` | `move_{n→m}` | 7 | déplacement | 13 | 4 | à ajouter |
| 48 | `Try` | `try` | 7 | récupération | 7 | 2 | à ajouter |
| 49 | `Declassify` | `declassify_ℓ` | 11 | déclassification | 21 | 4 | présent |

Lectures de la table :

* **43 lignes ne changent pas de mot K**, et aucune ne change dans le manuscrit : les noms N ne s'écrivent aujourd'hui nulle part comme tels (ils sont « le nom de la primitive », que seul le glossaire écrirait). Ce que le renommage fait **vraiment** au texte tient dans les six lignes qui changent.
* Les six qui changent sont `Inj`, `Open`, `Alw^{-}`, `VecI`/`VecE` (le mot `iter`), `Vmap` et `Loc`. Cinq noms N sont déjà au glossaire : « observation », « opération à portée », « copatron », « localisation » et « déclassification ».
* Les noms N dont la prose est la plus fournie sont des mots de tous les jours : `opération` (185 emplois, dont les emplois de `opération à portée` et de l'« opération d'effet » du chapitre 3), `projection` (67), `point fixe` (62), `variable` (61), `application` (50), `unité` (47), `paire` (26), `émission` (26), `attente` (24), `abstraction` (23). Cette observation commande le §6.2.

### 2.2 Les six mots qui changent : où ils s'écrivent

| Ancien → nouveau | Total | `C3/GrammaireDesTermes` | `C3/ReglesDeTypage` | `C4/SemantiqueOperationnelle` | Nature des emplois |
|---|--:|--:|--:|--:|---|
| `inj` → `inject` | 6 | 1 | 1 | 4 | une ligne de grammaire, la règle `Inj`, le schéma de `case`, le lemme de forme canonique, la relation logique des sommes (deux occurrences) |
| `iter` → `iterate` | 5 | 1 | 1 | 3 | grammaire, règle `VecE`, deux schémas (vecteur vide, vecteur non vide : trois occurrences) |
| `vmap` → `vectormap` | 6 | 1 | 2 | 3 | grammaire, règle `Vmap`, une phrase de prose sur la profondeur, schéma de réduction, liste des constructeurs, une phrase de preuve |
| `open` → `unpack` | 3 | 1 | 1 | 1 | grammaire, règle `Open`, schéma `open (pack …)` |
| `at` (□) → `current` | 8 | 3 | 2 | 3 | grammaire (une ligne et deux phrases de prose), règle `Alw^{-}`, une phrase de prose, un schéma, la liste des constructeurs, une phrase citant le schéma |
| `loc` → `placed` | 8 | 2 | 1 | 5 | grammaire (une ligne, une phrase), règle `Loc`, schéma de `at_n`, schéma de `move` (deux occurrences), liste des constructeurs, lemme de forme canonique |
| **Total** | **36** | **9** | **8** | **19** | |

À ces 36 s'ajoutent, hors `spec/Spec`, les **6 motifs** du tableau `EXPECTED` de `scripts/controles/croise.py` (le motif de `Alw^{-}` y est écrit `mathsf\{at\}` et celui de `At` `mathsf\{at\}_n` : le script ne réécrit que le premier, ce que l'essai confirme).

### 2.3 Ce que le script **ne voit pas**

| Emploi | Où | Traitement |
|---|---|---|
| `` `open` sur `pack` `` (prose, police de code) | `C4/CalculDeProcessusSousJacent.lean`, ligne 315 | **à la main**, une occurrence, modification minimale (« `unbox` sur `box`, `unpack` sur `pack` ») ; la table de renommage la liste déjà au §2 ; on peut aussi l'ajouter au CSV comme ligne `LITERAL:` |
| `` `unpack` `` en prose | `C3/StructuresOuvertesEffetsEtMetaTheorie.lean` (lignes 83, 84, 88 : **3** emplois), `AnnexeA/DistinctionDePhaseEtMetaprogrammation.lean` (1), `C6/LeProcessusDeCompilation.lean` (ligne 114 : 1) | rien à changer : ils portent déjà le mot final. **La table de renommage en compte 3 et n'en cite que deux fichiers ; le compte exact est 5 en trois fichiers.** |
| `vmap` dans `spec/CHANGELOG.md` (ligne 26) | historique | à laisser : c'est l'état daté d'une version ; ajouter une ligne pour `T-68`, pas réécrire l'ancienne |
| noms de règles `\textsc{Inj}`, `\textsc{Open}`, `\textsc{Vmap}`, `\textsc{Loc}`, `\textsc{VecI}`, `\textsc{VecE}` (7 emplois), `\textsc{Alw}^{-}` | `ReglesDeTypage`, `SemantiqueOperationnelle` | **ne changent pas** : les noms de règles sont une troisième couche de noms (voir §5.3) |
| `\mathrm{loc}(\Delta)` | `C3/ReglesDeTypage.lean`, règle `At` | ne change pas : c'est la **fonction** de localisation d'un contexte, non le constructeur ; après renommage, `loc` ne désigne plus qu'elle, ce qui lève une ambiguïté |
| champs `SYMBOLE` de `docs/suivi/primitives.md` (6 lignes : 199, 252, 391, 551, 641 et le `at` de 659 qui reste) | `docs/suivi` | **le script ne les réécrit pas**, malgré ce qu'annoncent son en-tête et la proposition en bloc (§8) : le CSV n'a aucune ligne pour ce fichier. Décision : soit l'ajouter au CSV, soit tenir `primitives.md` pour l'état daté de la proposition du 6 octobre (46 lignes) et le laisser tel quel |

### 2.4 Impact par famille de fichiers

| Famille | Impact | Détail |
|---|---|---|
| Chapitres `spec/Spec/C*` et annexes | 3 fichiers, 36 occurrences, 1 occurrence à la main (§2.3) | formules (`align*`, règles `\frac`) et phrases citant la formule |
| Formules LaTeX | toutes les occurrences sont dans `\mathsf{…}` | aucune macro personnalisée, aucun `\newcommand` du préambule n'est concerné (`SpecExt/Setup.lean` ne définit pas de macro pour ces mots) |
| Index imprimé | **aucun** | les 31 termes de `tools/SpecExt/IndexTerms.lean` ne contiennent aucun des mots ; `scripts/controles` (« index : 31 termes, 30 présents ») inchangé dans la copie |
| Glossaire | **à décider** | §6.2 |
| Figures `spec/figures/` | **aucun** | aucune figure ne contient `mathsf`, `inj`, `iter`, `vmap`, `loc_n` |
| `tools/` et `tests/` | **aucun** | aucune occurrence des six mots ni de `mathsf` dans `tools/SpecExt/*.lean`, `tests/SpecToolsTest.lean`, `src/` ; les tests ne comptent pas les entrées du glossaire |
| Contrôles `scripts/controles/` | `croise.py` : 6 motifs réécrits ; `vocabulaire.py` : lit la proposition, pas le manuscrit | voir §3 : les deux passent après renommage |
| `scripts/manuscript_metrics.py` | **aucun** | `summary` identique avant et après dans la copie |
| `docs/` hors journaux | `docs/suivi/primitives.md` (§2.3) ; la proposition en bloc (colonne « K actuel » à mettre à jour) | les journaux, relectures et archives sont des états datés : ils ne bougent pas |
| `spec/CHANGELOG.md`, `CHANGELOG.md` | une ligne chacun | la règle du dépôt : les changements de la spécification vont dans `spec/CHANGELOG.md` |

## 3. Essai à blanc du script et application dans une copie

### 3.1 Essai à blanc

`python3 scripts/t68_renommer.py --diff` (sans `--appliquer` : rien n'est écrit, `git status` reste propre) :

| Fichier | `inj` | `iter` | `vmap` | `open` | `at` (□) | `loc` | Total |
|---|--:|--:|--:|--:|--:|--:|--:|
| `spec/Spec/C3/GrammaireDesTermes.lean` | 1 | 1 | 1 | 1 | 3 | 2 | 9 |
| `spec/Spec/C3/ReglesDeTypage.lean` | 1 | 1 | 2 | 1 | 2 | 1 | 8 |
| `spec/Spec/C4/SemantiqueOperationnelle.lean` | 4 | 3 | 3 | 1 | 3 | 5 | 19 |
| `scripts/controles/croise.py` | 1 | 1 | 1 | 1 | 1 | 1 | 6 |
| **Total** | 7 | 6 | 7 | 4 | 9 | 9 | **42** |

Les nombres coïncident avec la colonne « occurrences » du CSV et avec la table de renommage (6 + 5 + 6 + 3 + 8 + 8 = 36 dans `spec/`). Le `--diff` montre des lignes modifiées qui sont exactement celles attendues ; un seul effet de bord cosmétique : dans `croise.py`, les mots plus longs décalent l'alignement en colonnes des commentaires du tableau `EXPECTED` (aucun formateur Python n'est imposé par la CI : `ruff`, `black`, `flake8`, `pycodestyle` n'apparaissent ni dans `.github/` ni dans la configuration).

### 3.2 Application dans une copie, puis contrôles

Procédure : copie du dépôt (hors `.git`) dans le répertoire temporaire de la session ; `python3 scripts/t68_renommer.py --appliquer` ; `python3 scripts/controle.py` ; deuxième passage du script ; recherche des formes anciennes ; `python3 scripts/manuscript_metrics.py summary` avant et après.

| Vérification | Résultat |
|---|---|
| remplacements effectués | 42 |
| `controle.py` après renommage | **tous verts** (structure, algèbre, notation, croisement : « grammaire et règles coïncident », « 53 règles de typage », « 49 constructeurs de termes : 13 valeurs, 36 calculs » ; sémantique : sondes 17/17 ; index ; vocabulaire : « 49 lignes couvrent les 50 règles ») |
| deuxième passage du script | 0 remplacement : **idempotent** |
| restes de `\mathsf{inj\|iter\|vmap\|open\|loc}` ou de `\mathsf{at}` hors `at_n` | **aucun** (dans `spec/` et `scripts/`) |
| `manuscript_metrics.py summary` | **identique** |

Deux limites : le contrôle de croisement est le seul à lire les mots K du manuscrit (via `croise.py`), et il passe parce que le script réécrit à la fois le manuscrit et ses motifs ; si l'on réécrivait l'un sans l'autre, il échouerait (c'est son rôle : ses motifs *sont* le registre). Et `lake build Spec` n'a pas été lancé ; les modifications ne touchent que des chaînes de formules et du texte, jamais de code Lean ni de délimiteur Verso (aucun accent grave n'est introduit dans les mathématiques en ligne), de sorte que l'échec de la compilation n'est pas attendu, mais il se vérifie au renommage (§8, étape 7).

## 4. Collisions

### 4.1 Les six mots K

| Mot | Lean | Verso | LaTeX | Mots de K7PL | Dans `spec/` | Verdict |
|---|---|---|---|---|---|---|
| `inject` | non réservé | sans objet (dans une formule) | `\mathsf{inject}` : aucune commande | non réservé (liste de `vocabulaire.py` et §6 de la proposition) | 0 emploi, hors « injecté » (3 emplois du verbe commun) | aucune |
| `iterate` | non réservé | idem | aucune | non réservé | 0 emploi ; le français « itération » (chapitres 2 et 6) désigne autre chose, voir §5.2 | aucune |
| `vectormap` | non réservé | idem | aucune | non réservé | 0 | aucune |
| `unpack` | non réservé | idem | aucune | non réservé | 5 emplois en prose au sens voulu | **lève** une collision : `open` est un mot-clé de Lean (`open Verso.Genre Manual` en tête de chaque fichier de `spec/`), et un mot du manuscrit (« ouvrir ») pour autre chose |
| `current` | non réservé | idem | aucune | non réservé | 0 emploi dans `spec/` (les emplois de `tools/` et de `scripts/` sont de l'anglais de code) | aucune ; `extract` aurait heurté « extraction » (cinq occurrences de « extract » ou « extraction » dans cinq fichiers ; je n'ai pas relu lesquelles sont l'extraction de preuve) |
| `placed` | non réservé | idem | aucune | non réservé | 0 emploi (le participe français « placé » apparaît une fois, sans lien) | aucune |

À noter : `at` et `open` **sont** des jetons de Lean (`simp at h`, `open Foo`). Ils ne sont pas lus par Lean ici, puisqu'ils sont dans des chaînes de formules, mais ils le seraient si un jour le noyau était écrit dans un fichier Lean ; c'est un argument faible de plus pour `unpack`, nul pour `current` (qui aurait pu rester `at`).

Les mots K ne sont pas des mots de langue (français) ; leur lecture en anglais n'est pas ambiguë. **Sensibilité à la casse et ligatures** : `\mathsf` en mode mathématique n'applique pas de ligature (`unicode-math`), de sorte que `inject`, `iterate`, `vectormap` ne contiennent aucune ligature fautive.

### 4.2 Les noms N

La proposition en bloc (§6) relève neuf collisions. Deux autres apparaissent à la lecture du **glossaire** actuel (`spec/Spec/Refs/ListeDesGlosses.lean`, 99 entrées) :

| Nom N | Collision | Verdict proposé |
|---|---|---|
| « localisation » (`At`) | le glossaire définit déjà « localisation » comme l'**élément du demi-treillis** où réside une valeur, porté par une modalité graduée (« Élément du demi-treillis où réside une valeur… »). La proposition donne ce même mot à la **primitive** `at_n`. Deux objets, un mot : c'est exactement ce que la règle R-N4 interdit, et la table de la proposition ne le signale pas (elle dit « même mot que la modalité qui le type », ce qui est la même idée vue d'un autre côté) | à **signaler** au §6 de la proposition ; ou nommer la primitive « exécution en un lieu » ; l'entrée du glossaire reste telle |
| « déclassification » (`Declassify`) | le glossaire la définit comme l'**autorisation nommée** de faire descendre une donnée d'un niveau. La primitive `declassify_ℓ(v)` est l'acte | même remarque, plus faible : le mot est employé 22 fois au sens large ; à noter |

Et une **proximité** : « lecture instantanée » (`Alw^{-}`) contre l'entrée « instantané » du glossaire (« État d'un acteur figé et persisté à un instant donné »). Pas de collision de reconnaissance (la reconnaissance se fait sur des frontières de mot, et « instantanée » n'est pas « instantané » + marque de pluriel), mais deux emplois voisins de « instant » dans deux sens.

### 4.3 Collisions inverses (un même mot pour deux primitives)

Contrôlé par `vocabulaire.py` et recompté : aucun mot K ni nom N n'est partagé entre deux lignes ; `at` ne désigne plus qu'une forme après renommage.

## 5. Cohérence morphologique et sémantique face aux définitions du manuscrit

### 5.1 Le critère du chapitre 3

Le chapitre 3 (`C3/GrammaireDesTermes.lean`, lignes 77 à 86) pose : « Les constructeurs du noyau nomment ce qu'une chose _est_ ; les mots de surface nomment ce qu'un programme _fait_. » Il en tire que `operation` et `scoped` sont « deux espèces d'opération d'effet », que `perform` et `handle` sont « deux actions », que `handler` « est le nom d'une _valeur_ », et que les abréviations écartées le 3 septembre l'ont été parce que « deux constructeurs de même espèce doivent porter des noms de même forme, et deux abréviations de longueurs différentes n'en sont pas ».

Trois lectures, à bien distinguer :

1. **Le passage justifie R-K1** (pas de mot tronqué) *à la lettre* : `inj`, `iter`, `vmap` sont des abréviations de longueurs différentes dans une grammaire dont les autres noms sont entiers. La règle de forme de la proposition prolonge donc une règle que le manuscrit s'est déjà donnée ; ce n'est pas une règle nouvelle.
2. **Le passage ne dit pas que tout mot K soit un substantif ou un participe.** Les mots K existants sont, pour une bonne part, des verbes à l'impératif : `force`, `unfold`, `wait`, `spawn`, `send`, `free`, `move`, `try`, `declassify`. Les ajouter à la liste de ce qui « est » serait forcer le texte. La proposition le sait (§9 : seuls `Sc` et `Op` sont concernés par le critère) ; je confirme que c'est la bonne lecture, et qu'**aucun des six nouveaux mots ne contredit le passage** : `placed` (participe : ce que la valeur *est*) s'en rapproche le plus, `inject`, `iterate`, `unpack`, `vectormap` sont des verbes comme `force` et `unfold`, `current` est un adjectif substantivé.
3. **Le critère s'applique pleinement à l'unique ligne N qui touche le passage** : le nom N de `Op`. Le chapitre 3 dit que `operation` et `scoped` sont deux **espèces** d'*opération d'effet*. Le nom N « opération » pour `Op` et « opération à portée » pour `Sc` (proposé) fait donc de l'espèce le nom du genre. Le glossaire a déjà « effet algébrique », et `ARB-PR-03` nomme `ℰ_alg` et `ℰ_scoped` : « opération algébrique » (`Op`) et « opération à portée » (`Sc`) nommeraient les deux espèces au même niveau. C'est la **première alternative** du §10.

### 5.2 Ligne par ligne : les six qui changent

| Ligne | Cohérence morphologique | Cohérence sémantique face au texte |
|---|---|---|
| `inj` → `inject` | `inject`/`injection` ; la règle s'appelle `Inj` (nom de règle conservé) | le texte dit « injection » 1 fois en prose ; aucun conflit ; le terme est celui de la littérature (`inl`/`inr`, `inj_i`), `inject` n'est pas un usage établi mais lisible |
| `iter` → `iterate` | verbe entier | **nuance** : `iterate_V v c` exécute `c` sur chaque élément du vecteur, en séquence, et rend `()` ; ce n'est pas un pli (le glossaire réserve `fold` aux algèbres initiales). « itérer » est par ailleurs employé en prose pour l'itération de phases de compilation (`C6`) et le calcul de point fixe par itération (`C2`) : trois sens voisins, aucun conflit de mot |
| `vmap` → `vectormap` | **ne respecte pas R-K1** : « un mot anglais entier » ; `vectormap` est une soudure de deux mots (`vector` et `map`), pas un mot. `vmap` est le nom établi dans la littérature d'exécution vectorisée | voir §10, ligne 2 |
| `open` → `unpack` | symétrique de `pack` (R-K2) | le manuscrit **écrit déjà** `unpack` en prose (5 emplois en 3 fichiers) et `open` une seule fois (C4, ligne 315) : il est aujourd'hui incohérent avec lui-même, le renommage le met d'accord |
| `at` (□) → `current` | `current` est un adjectif ; `always` est un adverbe : R-K4 les range à part (introductions : adverbes ; éliminations : verbes ou conjonction), **mais `current` n'est ni un verbe ni une conjonction** : l'exception à R-K4 n'est pas dite | `current` et `now` sont proches par le sens (« à l'instant présent ») alors qu'ils appartiennent à deux modalités différentes (`current` élimine □V, `now` introduit ◇V). Le texte de la règle `Alw^{-}` : « la coercion □S → S existe déjà sous le nom `at` : ce qui est disponible à tout moment l'est en particulier maintenant » : `current` rend bien cette lecture |
| `loc` → `placed` | participe passé ; `placed_n v` se lit « v placée en n », comme `always v` « v toujours » | `placed_n` introduit `@ₙV` ; `at_n c` exécute `c` en `n` ; `move_{n→m}` déplace une valeur `placed` : les trois mots font une famille lisible |

### 5.3 Trois remarques de cohérence d'ensemble

1. **Trois couches de noms.** Un constructeur a un mot K (`unpack`), un nom N (« unpack »), et la règle qui le type a un nom de règle (`\textsc{Open}`). Le renommage ne touche pas le troisième, qui reste `Inj`, `Open`, `Vmap`, `Loc`, `Alw^{-}`. Après renommage, `Open` type `unpack` et `Vmap` type `vectormap` : un lecteur le comprendra, mais la table de croisement (`croise.py`, clés `Open`, `Vmap`…) et le contrôle du vocabulaire restent liés à ces noms. Les renommer (sept emplois de `\textsc`, plus les étiquettes `eq:` des règles) est possible mais **non demandé** ; la proposition ne le mentionne pas et il faut dire qu'on ne le fait pas (D6).
2. **Les paires** (proposition, §7). `pack`/`unpack`, `box`/`unbox`, `fold`/`unfold` sont de vraies paires introduction/élimination ; `always`/`current` et `now`/`when` le sont sur la même modalité. **`next`/`wait` n'en est pas une** : les règles montrent `Nxt` : `next v : ○V` et `Wait` : `wait v : F ◇V` pour `v : ○◇V` : `wait` élimine `○◇V`, non `○V`. La phrase de la proposition (« next/wait (introduction/élimination des trois modalités) ») est inexacte ; la conclusion (aucun mot ne désigne deux primitives) ne l'est pas. À corriger dans la proposition ; sans effet sur le renommage.
3. **Le registre N n'a pas d'emploi dans le texte aujourd'hui.** Seuls le glossaire et d'éventuelles références futures écrivent « thunk », « abstraction », « mise en parallèle », etc. comme noms de primitives. La cohérence des 49 noms est donc une cohérence **de table**, vérifiée par `vocabulaire.py` (pas de doublon, pas de mot réservé), non une cohérence **de lecture** que le texte éprouverait. D'où l'intérêt de limiter les entrées de glossaire à celles qui se liront (§6.2).

## 6. Rendu PDF et HTML

### 6.1 Largeur des formules

Mesure (`lualatex`, `amsmath`, `unicode-math`, classe `report` 10 pt : `\textwidth` = 345 pt ; **le document réel n'est pas ce document** : la mesure compare l'avant et l'après, elle ne dit pas ce qu'est la largeur du PDF du dépôt) des lignes de `align*` de la grammaire des termes :

| Ligne de la grammaire (numérotée dans l'ordre du bloc `align*`) | Mots renommés | Avant | Après | Écart |
|---|---|--:|--:|--:|
| 1. valeurs (une seule ligne) | `inject`, `placed_n` | 517 pt | 544 pt | +27 pt (+5 %) |
| 2. calculs, première ligne | aucun | 344 pt | 344 pt | 0 |
| 4. `unbox … unpack … unfold` | `unpack` | 223 pt | 232 pt | +10 pt |
| 5. `Λα … iterate_V` | `iterate` | 213 pt | 226 pt | +13 pt |
| 7. `delay … current … wait … when` | `current` | 179 pt | 201 pt | +21 pt |
| 9. `∥ … vectormap` | `vectormap` | 84 pt | 105 pt | +21 pt |
| 11. `spawn … slice` | aucun | 360 pt | 360 pt | 0 |
| 3, 6, 8, 10, 12 | aucun | 101 à 210 pt | inchangées | 0 |

Ce qu'on en retient : **la ligne « valeurs » est déjà bien plus large que la page** (517 pt pour 345 pt de ligne dans ce document de substitution ; la ligne `spawn … slice` aussi : 360 pt, et la première ligne des calculs est à 344 pt) et le renommage élargit la première de 5 %. C'est donc déjà un cas de coupure de ligne à régler (un `\\` après la moitié des alternatives), indépendamment de `T-68` ; le renommage n'en crée aucun nouveau dans cette mesure (aucune des autres lignes ne franchit 345 pt après renommage). Les règles de typage `\frac` n'ont pas été mesurées (compte de caractères seulement : la règle `Vmap` gagne 5 caractères de rendu, `Open` 2, sur des règles déjà longues) ; elles sont à regarder sur le PDF. **Vérification au renommage** : compiler le PDF et comparer les « Overfull \hbox » du journal LaTeX avant et après.

HTML : les formules sont composées par le moteur de mathématiques de Verso ; `\mathsf{…}` est standard, aucun moteur n'y diffère. Les lignes larges défilent plutôt que de déborder. Aucun effet autre que la longueur.

### 6.2 Glossaire et reconnaissance automatique

La passe `tools/SpecExt/AutoMark.lean` reconnaît dans le texte des paragraphes (jamais dans le code ni les formules) chaque terme du glossaire, **sur frontières de mot, sans tenir compte de la casse ni des accents, avec marque de pluriel facultative**, et pose une **bulle de glossaire à la première occurrence dans chaque chapitre**. Si l'on ajoute les 44 noms manquants (la table de renommage prévoit cette étape) :

* ils ont **733 occurrences en prose** dans `spec/` ;
* ils produiraient jusqu'à **121 bulles** (une par chapitre et par mot ; borne haute, car les termes plus longs — « opération à portée », « application vectorisée » — masquent leur début), contre aujourd'hui 99 entrées pour tout le manuscrit ;
* la plupart sur des **mots ordinaires** : « opération » (185 emplois dans 7 chapitres), « projection » (67 ; 7 chapitres), « point fixe » (62 ; 6), « variable » (61 ; 7), « application » (50 ; 6), « unité » (47 ; 8), « paire » (26), « émission » (26), « attente » (24 ; 2 chapitres), « abstraction » (23), « présence » (15 ; 7), « filtrage » (17 ; 7), « force » (11 ; le substantif ou le verbe commun). Une bulle « Variable : … » sur chaque première « variable » de chaque chapitre n'aide pas le lecteur, et une bulle « Force : … » sur « la force de » le trompe ;
* le glossaire actuel, lui, ne contient que des termes de spécialiste (« abaissement », « anamorphisme », « sédimentation »…), aucun mot de tous les jours.

Trois options pour la décision de l'auteur (§9, D5) :

| Option | Ce qu'elle ajoute | Bruit | Cohérence avec le besoin de complétude |
|---|---|---|---|
| **(a) les 44** | les 44 entrées | jusqu'à 121 bulles, dont une centaine sur des mots courants | complétude maximale ; coût de lecture |
| **(b) les locutions et les emprunts** | les 14 locutions (« liaison séquentielle », « décomposition de paire », « élimination de l'unité », « conjonction additive », « lecture instantanée », « pas suivant », « pli indexé gradué », « mise en parallèle », « application vectorisée », « création de boîte », « réception gardée », « marque de lieu », « opération à portée » déjà présente, « point fixe ») et les emprunts `thunk`, `pack`, `unpack` (pas `force`, `return`) | quelques dizaines de bulles, sur des expressions rares | la table complète reste dans la proposition ; le glossaire garde sa nature |
| **(c) aucune pour l'instant, une table des primitives** | une table (chapitre 3, §3.5) « règle ; mot K ; nom N » de 49 lignes, hors reconnaissance automatique | aucun | la complétude est au chapitre 3, non dispersée ; contredit toutefois la phrase du chapitre 3 « aucune table de correspondance n'est due au lecteur » **pour `operation`/`perform`** (autre objet : cette phrase concerne K et S, la table proposée concerne K et N) |

Ce n'est pas mon rôle de choisir : (a) répond le plus littéralement à « complétude », (b) évite le bruit, (c) déplace la complétude.

L'index imprimé n'est pas concerné (31 termes, aucun renommé).

## 7. Risques du renommage mécanique

| Risque | Gravité | Constat | Parade |
|---|---|---|---|
| remplacer un mot qui n'est pas un constructeur (`at` est aussi un mot ordinaire) | moyenne | le script ne remplace que `\mathsf{at}` non suivi de `_`, de sorte que `at_n` est intact ; vérifié : 8 remplacements, `at_n` ×7 conservés | garder le motif `(?!_)` ; recompter `\mathsf{at}_` avant et après (7) |
| oublier une forme (`\mathbf{inj}`, `\text{loc}`) | basse | recherche faite sur `\mathsf`, `\mathbf`, `\text`, `\mathrm`, `\textsf`, `\operatorname` : seules les formes `\mathsf` existent pour les six mots | aucun reste après renommage (§3.2) |
| double application | basse | idempotent (0 remplacement au second passage) | — |
| renommage partiel (manuscrit sans `croise.py`, ou l'inverse) | moyenne | `controle.py` échoue : le croisement ne trouve plus un constructeur | un seul commit, contrôles lancés avant le commit |
| prose en police de code oubliée (`open` sur `pack`) | basse | une occurrence connue (§2.3) | ligne à ajouter au CSV, ou édition à la main |
| compte faux dans la table (3 `unpack` au lieu de 5) | basse | l'écart est dans la prose, hors de ce que le script réécrit | corriger la table de renommage |
| formule plus large que la page | basse à moyenne | la ligne « valeurs » est déjà trop large, +5 % après | traiter la coupure de ligne dans le même commit ou dans le suivant ; comparer les `Overfull \hbox` |
| bruit de glossaire (§6.2) | moyenne | jusqu'à 121 bulles | option (b) ou (c) |
| nom de règle et mot K qui divergent (`Open`/`unpack`) | basse | trois couches (§5.3) | dire qu'on ne les renomme pas ; ou les renommer ensemble |
| journaux et relectures qui citent l'ancien vocabulaire | nulle | ce sont des états datés | ne pas les corriger ; la note du changelog dit où est la table |
| le renommage change le sens d'un énoncé scellé | nulle | aucun énoncé n'est modifié ; seuls des symboles de constructeurs changent ; le contrôle des sceaux est vert | — |
| le manuscrit porte « ne rien modifier sans l'accord de l'auteur » | **formelle** | la ratification en bloc **est** l'accord ; elle doit être écrite | la consigner au journal (étape 1 du plan) avant d'appliquer |

## 8. Plan de ratification en bloc

**Avant**, le jour de l'application :

1. Branche à jour, arbre propre ; `python3 scripts/controle.py` vert ; `python3 scripts/t68_renommer.py` (essai) : **42 remplacements** (43 si l'on ajoute la ligne de prose `open`).
2. Relever les « avant » : `grep -c 'mathsf{at}_'` sur les trois fichiers (attendu 7 en tout) ; `lake build Spec` vert (référence) ; `lake exe spec --output _out/spec --with-tex` puis compilation du PDF : sauvegarder le nombre de `Overfull \hbox` du journal LaTeX.

**Ordre d'application** (un seul commit, rien d'autre mélangé) :

1. consigner la ratification de l'auteur (journal de séance et ligne « tranchée » de `DECISIONS.md`) : sans cela, la règle « ne rien modifier sans l'accord de l'auteur » n'est pas tenue ;
2. corriger au besoin le CSV (amendements du §9 ; ligne de prose `open` ; compte de la table) ;
3. `python3 scripts/t68_renommer.py --diff` (relire) puis `--appliquer` ;
4. la ligne de prose `open` (si elle n'est pas dans le CSV) ;
5. entrées de glossaire selon D5 (option a, b ou c), travail éditorial à part ;
6. mettre à jour la proposition en bloc (colonne « K actuel » = ancien « K proposé », retrait des flèches) pour que `scripts/controles/vocabulaire.py` lise un état à jour ;
7. `lake build Spec`, `lake exe spec --output _out/spec --with-tex`, compilation du PDF, comparaison des `Overfull \hbox` ;
8. `python3 scripts/controle.py`, `python3 scripts/suivi.py all`, `reuse lint` ;
9. une ligne à `spec/CHANGELOG.md`, une au journal, une à `CHANGELOG.md` ; `T-68` passe à « fait » dans `DECISIONS.md`, `TABLEAU-DE-BORD.md` ; la table `t68-table-de-renommage.md` devient historique ;
10. commit `docs(spec): renommer les primitives (T-68)` (en minuscules, moins de 100 caractères), poussé sans force.

**Après** :

* `grep` : aucun `\mathsf{(inj|iter|vmap|open|loc)}` ni `\mathsf{at}` hors `at_n` dans `spec/` et `scripts/` ;
* `controle.py` : « TOUS LES CONTROLES PASSENT » ; les comptes (13 valeurs, 36 calculs, 53 règles) inchangés ;
* PDF : pas plus d'`Overfull \hbox` qu'avant (ou la ligne « valeurs » corrigée) ; HTML : une ouverture du chapitre 3 et du chapitre 4 ;
* les relectures et journaux antérieurs n'ont pas changé.

**Retour arrière.** Tout est dans **un seul commit** de `spec/`, `scripts/controles/croise.py` et des documents : `git revert <commit>` rétablit l'état d'avant, y compris les motifs du contrôle. Il n'est pas besoin d'un mode inverse du script, qui serait de toute façon fragile (`current` → `at` doit ne toucher que les `\mathsf{current}` ; sûr ici, mais le commit unique est plus simple). Si l'auteur change d'avis **après** la release `spec-v0.1.0`, le retour arrière n'est plus un revert : c'est un nouveau renommage, avec une ligne au changelog et un numéro de version ; d'où l'intérêt de ratifier **avant** la release, comme le prévoit l'ordre de finition.

## 9. Une décision par bloc de la table

Chaque bloc a une formulation à accepter ou à amender ; l'amendement d'un bloc n'oblige pas à défaire les autres. Les mots entre guillemets sont ceux de la proposition.

**D1. Les trois registres et les règles de forme** (proposition §2 et §3).
*Formulation.* « Le vocabulaire des primitives a trois registres : K (constructeurs du noyau, anglais, mot entier), N (noms, français, substantif) et S (mots de surface du chapitre 5, inchangés). Les règles R-K1 à R-K4 et R-N1 à R-N4 sont ratifiées. »
*Si l'on amende* : R-K1 est le point d'appui de `Vmap` (voir D2) ; R-K4 gagne à dire que `current` est une exception (adjectif) ou à la corriger.

**D2. Les six renommages de constructeurs** (`inj`→`inject`, `iter`→`iterate`, `vmap`→`vectormap`, `open`→`unpack`, `at`→`current`, `loc`→`placed`) ; 36 occurrences, 3 fichiers.
*Formulation.* « Ces six renommages sont appliqués mécaniquement avant la release, en un seul commit. »
*Si l'on amende* : la décision est ligne par ligne (une ligne à retirer du CSV ou à remplacer) ; les lignes à regarder sont au §10. Les six sont indépendantes : retirer `vmap` ne défait pas `unpack`.

**D3. Les 43 lignes dont le mot K ne change pas** : 29 mots (dont les quatre emprunts `thunk`, `force`, `return`, `pack`, et `operation`, `scoped`, `at_n`, `declassify`) et 14 formes symboliques sans mot (`λx.c`, `c v`, `()`, `(v, v)`, `∥`…).
*Formulation.* « Ces mots K sont conservés ; en particulier `operation` et `scoped` ne se renomment pas `perform` et `handle`. »
*Si l'on amende* : il n'y a pas de raison mécanique de le faire ; le passage du chapitre 3 les protège.

**D4. Les 49 noms N** (proposition §4, colonne « N proposé »).
*Formulation.* « Les 49 noms N sont adoptés comme noms des primitives dans la prose, le glossaire et l'index futurs. »
*Si l'on amende* : les lignes à regarder sont « opération » (`Op`), « localisation » (`At`) et « présence » (`Now`) ; le reste est un choix de langue (français, cinq emprunts) que la décision de l'auteur sur le registre de la table du 6 octobre n'a pas contredit.

**D5. Les entrées de glossaire** (44 manquantes).
*Formulation.* « Au renommage, le glossaire reçoit : (a) les 44 noms ; ou (b) les locutions et les emprunts seulement ; ou (c) aucun, la complétude étant portée par une table des primitives au chapitre 3. »
*À noter.* Ce n'est pas une décision de vocabulaire mais une décision d'édition ; elle est séparable des autres (le renommage de K n'en dépend pas).

**D6. Le périmètre de l'application** (ce que le commit contient).
*Formulation.* « Le commit contient : `spec/` (3 fichiers, 36 occurrences, plus l'unique prose `open`), `scripts/controles/croise.py`, la proposition en bloc mise à jour, `spec/CHANGELOG.md`, le journal ; `docs/suivi/primitives.md` est laissé tel quel (ou ajouté au CSV, au choix) ; les noms de règles (`Inj`, `Open`, `Vmap`, `Loc`) ne sont pas renommés. »

## 10. Les lignes les plus discutables, avec alternatives

Classées de la plus à la moins discutable.

| Rang | Ligne | Pourquoi discutable | Alternatives | Effet de l'alternative sur le renommage |
|--:|---|---|---|---|
| 1 | `Vmap` → `vectormap` | la proposition pose « un mot anglais entier » (R-K1), et `vectormap` est une soudure ; le nom établi (`vmap`) est le même que celui de la littérature | (i) garder `vmap` et l'ajouter aux exceptions de R-K1 (noms établis d'un seul mot comme `fix`) ; (ii) `vecmap` (toujours tronqué) ; (iii) `parmap` (dit le parallélisme, mais `Par` a son propre mot) ; (iv) `map` (le mot entier le plus simple ; conflit possible avec un mot de surface futur) | retirer 3 lignes du CSV (6 occurrences) et 1 de `croise.py` pour (i) ; changer le remplacement pour les autres |
| 2 | N de `Op` : « opération » | genre et espèce confondus (§5.1) ; 185 emplois en prose | « opération algébrique » (appariée à « opération à portée » et à `ℰ_alg`/`ℰ_scoped`, `ARB-PR-03`) ; « opération d'effet » (formule du chapitre 3) | aucun sur K ; la ligne N de la table et son contrôle (`vocabulaire.py` ne tolère pas deux N identiques) |
| 3 | `Alw^{-}` : `at` → `current` | proche de `now` par le sens ; n'est ni verbe ni conjonction (R-K4) ; en dehors du critère du chapitre 3 | (i) `extract` (nom de la coünité ; écarté pour « extraction » : à vérifier sur les cinq emplois) ; (ii) `sample` (évoque l'échantillonnage) ; (iii) un verbe, par exemple `sustain` (pistes, non instruites) ; (iv) garder `at` pour □ et renommer `at_n` (par exemple `execat_n`, simple illustration) | pour (i)–(iii) : changer `current` dans la ligne du CSV (8 occurrences) et le motif de `croise.py` ; pour (iv) : 7 occurrences de `at_n` à renommer, la ligne `At` de la table, `croise.py` |
| 4 | `Loc` → `placed` | `here_n` ou `loc_n` écartés ; `located_n` est aussi un participe | `located` ; `site` ; `loc` conservé (R-K1 écartée pour une seule abréviation : `loc` désigne aussi `\mathrm{loc}(\Delta)`) | 8 occurrences ; la ligne du CSV |
| 5 | `iter` → `iterate` | suggère une boucle non bornée ; `iterate_V v c` est borné par le vecteur | `foreach`, `each`, `traverse` (plus exacts, mais « traverse » appartient à un autre vocabulaire) | 5 occurrences ; une ligne |
| 6 | N de `At` : « localisation » | collision avec l'entrée du glossaire (§4.2) | « exécution localisée » ; « exécution en un lieu » | aucun sur K |
| 7 | N de `Now` : « présence » ; de `Alw^{-}` : « lecture instantanée » | mots courants (15 emplois ; proximité de « instantané » du glossaire) | pour `Now` : « actualité » (peu usité), « instant courant » ; pour `Alw^{-}` : « lecture de l'instant » | aucun sur K |
| 8 | la règle R-K1 elle-même (pour `inj`, `iter`, `vmap`) | trois renommages « de forme » : si l'auteur préfère l'usage de la littérature à la règle, il garde ces trois mots ; `unpack` passe seul, car `open` reste pris par les fichiers | garder `inj`, `iter`, `vmap` ; le chapitre 3 (« deux abréviations de longueurs différentes n'en sont pas [de même forme] ») plaide pour R-K1 | retirer du CSV les trois lignes de chaque mot (9 lignes) et la ligne correspondante de `croise.py` ; 17 occurrences restent inchangées |

Dans l'ordre de ce que je ferais regarder à l'auteur en premier : les rangs 1 à 3. Les autres sont des préférences.

**Liens avec les dossiers de conception** (voir [`00-index-design`](00-index-design.md)). Le rang 1 (`vmap`) dépend du [dossier 1](01-parallele-et-vmap.md) : si la forme de `∥` et de `vmap` est réparée (restriction au parallélisme pur, recommandée par ce dossier), le mot est à reprendre avec elle ; il vaut mieux décider ce dossier avant de figer `vectormap`. Les rangs 3 et 4 touchent les formes que traite le [dossier 6](06-formes-temporelles-declassify-at-move.md) (`at`, `loc_n`, `move`, `declassify`) : ce dossier traite les **formes** et leurs règles, non les mots ; les deux ne se contredisent pas, mais si le dossier 6 modifie la règle `Alw^{-}` ou `Loc`, le renommage s'appliquera aux règles alors écrites (le script réécrit des motifs, pas des règles).

## 11. Corrections à apporter à la proposition, sans rapport avec le choix

Ces corrections ne dépendent pas de la décision ; elles ne sont pas appliquées ici (la proposition est un document de séance, que l'auteur ratifie).

1. **Table de renommage, §2** : `unpack` en prose compte 5 emplois en 3 fichiers (`C3/StructuresOuvertesEffetsEtMetaTheorie` ×3, `AnnexeA/DistinctionDePhaseEtMetaprogrammation` ×1, `C6/LeProcessusDeCompilation` ×1) et non 3 en 2 fichiers.
2. **Table de renommage et `t68_renommer.py`** : ils annoncent que `docs/suivi/primitives.md` suit le renommage ; le CSV n'a aucune ligne pour ce fichier (§2.3).
3. **Proposition, §7** : `next`/`wait` n'est pas une paire introduction/élimination (§5.3).
4. **Proposition, §6** : ajouter « localisation » et « déclassification » aux collisions de noms N (§4.2).
5. **Le CSV** gagnerait une ligne `LITERAL:` pour la prose `open` (§2.3), afin que l'essai compte 43 et que rien ne reste à la main.

Vérifié et **exact** dans la proposition : les 49 lignes, les 35 noms N d'un mot et 14 locutions, le compte des mots K (28 mots K inchangés plus `move_{n→m}`, 14 formes symboliques sans mot, 6 mots qui changent), les 50 règles de constructeur et les 53 règles du contrôle de croisement.

## 12. Ce que ce document ne tranche pas

* Le choix des mots : il n'en change aucun. Il dit où ils sont, ce que le changement coûte, et quelles lignes l'auteur voudra relire.
* La mise en page réelle du PDF (largeur de la ligne « valeurs ») : c'est à mesurer sur le PDF du dépôt.
* La place de `T-68` dans l'ordre de finition : déjà arrêtée (« avant-dernier, juste avant la release »).
