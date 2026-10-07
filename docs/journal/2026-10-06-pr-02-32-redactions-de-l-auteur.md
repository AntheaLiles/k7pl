<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 32 : les décisions de l'auteur rédigées

L'auteur a répondu aux questions restées en attente après la séance 31 (réponses reprises mot pour mot dans
chaque section). Ordre imposé : (A) rédactions, (B) mise à jour du manuscrit et du suivi, (C) études et
recherches. Ce journal est tenu section par section, au fil des commits. Le manuscrit n'est modifié que sur ce
mandat, au plus juste ; chaque modification est nommée ici, dans [`spec/CHANGELOG.md`](../../spec/CHANGELOG.md)
et dans la fiche concernée. Aucun sceau n'est changé.

## A.1 — `STRUCT-06` : renumérotation des phases de compilation

> « Renumérote toutes les phases de compilation pour les remettre en cohérence. »

**Constat.** La figure 11 mêlait des entiers (Parse = 1, TypeCheck = 2…, Link = 8) et deux numéros fractionnaires
(1.5 ConfigAnalysis, 2.5 Résolution) ; les chapitres 3 et 5 invoquaient dix fois une « Phase 0 » (l'expansion des
macros) absente de la figure ; le chapitre 5 notait que l'analyse « numérotée 1 » rend « 0 » trompeur. Les deux
options de la séance 31 (1.25 ; Parse = 0 puis Expansion = 1) laissaient chacune un défaut : la première rompt le
motif « .5 », la seconde laisse un « 1 » entier qui est un point de contrôle et un « 1.5 » qui en est un autre.

**Schéma retenu et sa justification.** Une numérotation **consécutive de 0 à 10, une étape par numéro, sans
fraction** :

| Nouveau | Étape | Ancien numéro | Nature |
|--:|---|---|---|
| 0 | Parse | 1 | ordre de vérification |
| 1 | Expansion | 0 (invoquée, absente de la figure) | point de contrôle |
| 2 | ConfigAnalysis | 1.5 | point de contrôle |
| 3 | TypeCheck | 2 | ordre de vérification |
| 4 | Résolution | 2.5 | point de contrôle |
| 5 | PurityCheck | 3 | ordre de vérification |
| 6 | TermProof | 4 | ordre de vérification |
| 7 | ConstraintSolve | 5 | ordre de vérification |
| 8 | Optimize | 6 | ordre de vérification |
| 9 | CodeGen | 7 | ordre de vérification |
| 10 | Link | 8 | ordre de vérification |

Raisons : (i) un numéro ne dit plus rien d'autre que le rang, la distinction « ordre de vérification » contre « point
de contrôle intercalaire » que portait la fraction passe au trait de la figure (pointillés) et au texte ; le compte
« huit ordres » est conservé (phases 0, 3, 5, 6, 7, 8, 9, 10) ; (ii) l'expansion, qui n'établit aucune composante du
jugement, rejoint les deux autres points de contrôle, ce qui rend la figure cohérente avec le texte du §6.1 ; (iii) le
décalage est mécanique et invertible (table ci-dessus), alors que « 1.25 » aurait ajouté un troisième motif.

**Modifié dans le manuscrit** (une vingtaine de fichiers de `spec/Spec/` et la figure) :

* figure 11 (`spec/figures/compilation-process.{svg,pdf}`, source `sources/compilation-process.drawio`, redessinées :
  onze étapes sur trois rangées, points de contrôle en pointillés, légende) ;
* §6.1 : paragraphe de lecture (onze étapes, trois points de contrôle), légende et description de la figure, un
  paragraphe nouveau sur la Phase 1 (le texte n'en disait rien : bac à sable du ch. 3, arbre figé à son issue,
  distinction avec l'élaboration Surface → Noyau et avec la résolution), la phase de résolution nommée (« une phase
  d'élaboration » désignait déjà la résolution : le mot est retiré, `STRUCT-06` point 2), l'acyclicité rattachée à la
  Phase 2, les numéros portés en parenthèse à chaque étape décrite ;
* ch. 1, 2, 3, 4, 5, 6, 7, annexes A et D : toutes les mentions « Phase N » reportées sur la nouvelle numérotation ;
  l'énoncé sur l'effacement est désormais « Phase 10 », le solveur « Phase 7 », la vérification d'acyclicité
  « Phase 2 », l'expansion « Phase 1 » ;
* ch. 5, remarque du théorème d'élaboration : la phrase qui laissait le choix à l'auteur est remplacée par le constat ;
* §6.2 (`CeQueLeSolveurRetourne`, modes `+dev` et `+release`) : « les trois premières phases, plus une version allégée de la Phase 4 » devient
  « les phases 0 à 5 [...] plus une version allégée de la Phase 6 » et « les phases 5 à 7 » devient « 7 à 9 » ; la
  lecture « les trois premières phases » comptait les seuls entiers 1 à 3, soit les anciens Parse, TypeCheck, PurityCheck
  avec leurs points de contrôle : c'est ce que la nouvelle formule dit.

**Anomalie signalée, non tranchée.** §6.3 (`StrategiesDeVerificationEtDeTest`, doctests) : « le compilateur les exécute […] pendant la Phase 1, avant toute
génération de code » : l'ancienne Phase 1 était l'analyse syntaxique, qui ne peut pas exécuter de test. Le report
mécanique aurait écrit « Phase 0 », ce qui est faux ; le texte dit désormais « pendant la compilation, avant la génération
de code (Phase 9) », ce qui est ce que la phrase voulait dire sans fixer la phase qui exécute les tests.

**Non renumérotés, par choix** : les relectures (`docs/relectures/`), les journaux antérieurs, les documents
historiques, le corpus et les questions de recherche citent la numérotation d'alors ; ils restent des états datés, la
table ci-dessus permet de les lire. Les fiches vivantes (`docs/suivi/`) sont tenues à jour.

**Vérifications.** `lake build Spec` sans avertissement ; `python3 scripts/controle.py` vert.

## A.2 — `BLOQ-12` : les singularités `∘` et `δ`

> « Les singularités sont à définir, leurs propagations réelles sont à sourcer dans les références. »

**Niveau de vérification des sources.** Les pages d'éditeurs, d'arXiv, de Wikipédia et des préimpressions de Stockholm
sont **bloquées** depuis la session (`EGRESS_BLOCKED`) : aucune source n'a été lue dans son corps. Ce qui est attesté
l'est par des **résumés de recherche** : (i) Carlström, *Wheels — On Division by Zero*, Math. Struct. Comput. Sci. 14(1),
143–184, 2004, DOI 10.1017/S0960129503004110 (notice confirmée par la recherche) ; une roue a `1/0` comme point à l'infini
non signé, `0/0` comme élément absorbant `⊥` (`x + 0/0 = 0/0`), et `0x ≠ 0` en général ; (ii) Bergstra et Ponse, *Division
by Zero in Common Meadows*, 2015, arXiv 1406.6878 : la division par zéro produit une valeur d'erreur, notée `a`, qui se
propage à travers toutes les opérations. Les deux notices sont ajoutées à `biblio/references.json` (champs limités à ce
qui est confirmé : ni volume ni pages pour la seconde).

**`⊥` et `∞`.** Les tables du §3.2 sont désormais **calculées** sur la construction de la roue des fractions (couples
`(a, b)` modulo les multiples non nuls ; somme `(ad+bc, bd)`, produit `(ac, bd)`, inverse `(b, a)`), par un petit calcul
dont le résultat coïncide avec les deux tables écrites à la séance 31 et avec `1/0 = ∞`, `1/∞ = 0`, `1/⊥ = ⊥` (bien défini
sur les classes). Le texte dit que les valeurs sont **calculées sur la construction**, non citées d'un énoncé de l'article.

**Écart avec IEEE 754 trouvé et écrit.** Le texte affirmait que la lecture « s'accorde » avec IEEE 754 sur les cas
singuliers. C'est faux pour `+∞ + (+∞)` : IEEE rend `+∞` quand les signes concordent, la roue (un seul infini) rend `⊥`.
Le §3.2 le dit désormais : la table fait foi, le test différentiel exclut ce cas.

**`∘` et `δ`.** Aucune des sources atteintes ne porte deux classes d'erreur distinctes de `⊥` : une roue en a une, un
méadow commun une. Elles sont donc **définies comme extension de K7PL, sans source**, et le texte le dit : deux classes
d'erreur absorbantes, distinctes entre elles et de `⊥`, propagées par la borne supérieure (`∘ ⋆ δ = ⊥`), jamais produites
par une entrée flottante (tout NaN est lu `⊥`). Le sens de chacune est laissé au programme. **Non vérifié** : que les axiomes
de la roue tiennent sur l'extension (les deux membres de chaque axiome que je connais portent les mêmes variables, ce qui
l'indique, mais je n'ai pas lu les axiomes dans le texte de Carlström) ; la proposition `thm:homomorphisme_roues` n'en
dépend pas. **Alternative laissée à l'auteur** : retirer `∘` et `δ` de l'encodage (i), sans autre modification.

**Statut.** `BLOQ-12` : à ratifier (définition de K7PL non sourcée). `IMPL-07` : inchangé.

## A.3 — `ANOM-17` : les grammaires des termes et des types

> « Les grammaires sont à définir. »

**Constat repris de la séance 31.** Les introductions `always` et `now` étaient rangées parmi les calculs mais attendues
comme valeurs par `at`, `wait`, `when` ; `□V`, `◇V`, `○V`, `@ₙV`, `!_ℓ' A` conclus par les règles n'étaient pas tous des
types de la grammaire ; aucune valeur close n'habitait `@ₙV` ni `○V` ; la règle de la déclassification concluait un type
valeur à partir d'une expression.

**Corrections de la grammaire des types** (ch. 3) : productions `□V | ◇V | ○V` pour les valeurs, `○C` pour les calculs ;
trois **abréviations** définies, non des productions : `!_ℓ V` (grade `r` dont seul le niveau est nommé, `r[ℓ']` le grade de
niveau abaissé), `◇C` (la possibilité se distribue sur la tête de tout type de calcul), `@ₙC` (la localisation se distribue
sur `F_ε V` seulement, `@ₙ(F_ε V) = F_{@ₙε}(@ₙV)`).

**Corrections de la grammaire des termes** : `always`, `now` et deux introductions nouvelles, `next` (`○V`) et `locₙ`
(`@ₙV`), sont des **valeurs** ; `at`, `wait`, `declassify_ℓ` _consomment_ une valeur : ce sont des **calculs** de type
`F_𝟏 V` ; `delay` reste un calcul, introduction de `○C`. L'argument de `declassify` est une valeur close (les échappatoires
de 𝒳 sont closes et évaluées dans l'état initial, ce que le texte disait déjà).

**Règles retypées ou ajoutées** (ch. 3 règles de typage, §2.4 pour `Declassify`) : `Alw⁻` et `Wait` concluent `F_𝟏 V | 𝟏` et
`F_𝟏 ◇V | 𝟏` ; `Nxt` et `Loc` sont ajoutées ; `At` se restreint à `F_ε V` et conclut `F_{@ₙε}(@ₙV)` ; `Declassify` reçoit son
nom et conclut `F_𝟏(!_{r[ℓ']} V) | 𝟏`. Le croisement mécanique passe de 50 à 53 règles et de 46 à 49 constructeurs (13 valeurs,
36 calculs).

**Schémas de réduction** (formule `eq:reductions-modalites`, §4.7) : six, tous purs sauf `move` ; `at (always w) → return w`,
`wait (next u) → return u`, `when x = now w in c → c[w/x]`, `declassify_ℓ'(box_r w) → return (box_{r[ℓ']} w)`,
`at_n (return w) → return (loc_n w)`, `move (loc_n w) → return (loc_m w)` avec l'événement réseau ; contexte `at_n E` ;
`delay c` terminal. Lecture **séquentielle** (l'horloge vit dans la trace et la traduction, non dans la configuration) et
**machine unique** (lieux et niveaux sont des étiquettes de type).

**Préservation des nouveaux schémas** (écrite dans le croquis, non démontrée) : trois exactes (`at/always`, `when/now`,
`at_n/return`) ; trois qui demandent un lemme : `wait` (contexte avancé d'un pas), `move` (le contexte d'une valeur `Ser` est de
grades nuls), `declassify` (le contractum se dérive à niveaux abaissés : la préservation graduée est fausse en l'état et doit
l'être, la divulgation délimitée la borne).

**Écarts avec l'orientation de l'instruction** : l'orientation proposait `declassify` en voie B (étiquette) ; la voie retenue
range la boîte au niveau abaissé dans un `box`, sans forme de valeur nouvelle, ce qui garde le type annoncé. Les trois règles
nouvelles (`Nxt`, `Loc`, `Declassify`) entrent à `docs/suivi/primitives.md` (entrées « à arbitrer » pour `T-68`).

**Reste ouvert** : les clauses de traduction vers le métalangage de ces six formes ; les lemmes ci-dessus ; la simulation
(`PREUVE-07`, `BLOQ-07`). Le sceau de `thm:progres` et de `thm:preservation` n'est pas changé (changement proposé dans
`DECISIONS.md`).

## A.4 — `ANOM-09` et `ANOM-10` : index à pages et interface HTML

> « Ok alors rédige ANOM-09 et ANOM-10. »

**Choix de voie (`ANOM-09`).** Les trois voies de `DECISIONS.md` étaient : une sortie TeX propre (`\index`, `makeindex`), une
contribution à Verso, ou rester à une liste. La voie retenue n'est aucune des trois : **les pages sont celles que LaTeX résout
lui-même**, par une étiquette posée à chaque occurrence et des macros du préambule (`\specidxpage` dédoublonne les pages par
comparaison des numéros que rend `\getpagerefnumber`, du paquet `refcount` que charge `hyperref`) ; aucun programme externe
(`makeindex`) ne tourne, ce qui compte parce que la CI compile le PDF avec `tectonic`. En HTML, l'équivalent d'une page est la
section : chaque terme renvoie aux sections où il paraît.

**Reconnaissance automatique.** `tools/SpecExt/AutoMark.lean` est une passe sur l'arbre du document, avant le rendu (`SpecMain`) : elle
remplace dans les nœuds de texte (jamais dans le code, les formules, les liens ni les listes de termes) les occurrences des trente et un
termes de `tools/SpecExt/IndexTerms.lean` par une marque `{idx}` ; pour le glossaire et les acronymes, la première occurrence de chaque
chapitre reçoit une infobulle (`{gloss}`) portant la définition. La règle de reconnaissance est celle d'`org-glossary` : frontières de
mots, casse et accents indifférents, pluriel en `s` ou `x`, acronymes sensibles à la casse. Le cœur est pur (`SpecExt.IndexCore`,
`SpecExt.Translate`), testé par `tests/SpecToolsTest.lean` (compris dans `lake test`, 13 tests).

**Vérification.** `lake build`, `lake test`, `lake lint`, `reuse lint` verts ; `lake exe spec --output _out/spec --with-tex` ; le PDF produit
est **compilé avec `lualatex`** (deux passes, 305 pages) et la page de l'index est contrôlée à l'œil (page 295 : lettres, pages
dédoublonnées, deux colonnes). `tectonic`, qui est le moteur de la CI, n'est pas installé dans la session : les macros n'emploient que du
LaTeX de base et `refcount`, mais la compilation par `tectonic` n'a pas été vue.

**Constat.** « analyse de coût » est au nombre des trente et un termes du manuscrit et n'est écrit nulle part dans le Verso (le texte dit
« analyse amortie ») ; il n'imprime rien. `scripts/controles/indexation.py` le déclare absent connu, à l'auteur de l'écrire ou de le
retirer.

**`ANOM-10`.** `tools/SpecExt/Translate.lean` est la feuille de traduction : remplacements exacts sur les pages HTML (table des matières,
code source, signalement d'un problème, lien permanent, page de recherche, `<html lang="fr">`) et sur les scripts de la zone de
recherche (invite, compteur de résultats, infobulles, plein texte), appliquée après la génération. Vérifié sur la sortie : plus aucune
chaîne d'interface anglaise dans les pages ni dans les scripts, hors un commentaire de code de Verso. Une montée de version de Verso peut
ajouter des chaînes : la feuille se complète alors.

**Modifié hors manuscrit** : `lakefile.lean` (le module de test entre dans `K7plTests`), `tools/`, `tests/`, `scripts/controles/`.
`spec/Spec/Refs/Index.lean` : la liste des termes est remplacée par `{printindex}` (la liste est dans `IndexTerms.lean`) et un paragraphe
de présentation.

## A.5 — Autres rédactions en attente, sans décision de fond

Parcours de `DECISIONS.md`, `ANOMALIES.md`, `RESTE-A-FAIRE.md`, `fiches-statuts.csv` et de l'instruction. Ce qui s'écrit sans choix de
l'auteur est écrit ici ; ce qui ne s'écrit pas est nommé dans la dernière section.

**`PREUVE-04` : clôture des échappatoires imposée par la règle.** La règle `Declassify` (§2.4) porte la prémisse `fv(v) = ∅` ; la phrase du
croquis du théorème de divulgation délimitée qui conditionnait sa preuve à cette clause, et celle du §4.7 qui la relevait comme écart de
formalisation, sont mises à jour. Le sceau n'est pas touché : l'énoncé reste une proposition tant que le lemme fondamental n'est pas conduit sur
tous ses cas.

**`TRANS-02` : fragments du ch. 2 et table de sédimentation selon les images réciproques.** Le ch. 1 dit que la table `tab:sedimentation` donne la
lecture par singletons de l'usage (ses trois lignes sont les images réciproques `π_𝕌⁻¹({ω})`, `π_𝕌⁻¹({0,1})`, `π_𝕌⁻¹({1})`) et que les
modalités de type du ch. 3 sont des intervalles ; le ch. 2 dit que `S` est un sous-ensemble de `𝕌`, la catégorie étant
`𝒞_{!_{π_𝕌⁻¹(S)}}`. La fiche reste à ratifier avec la décomposition.

**`TRANS-06` : remontées vers les ch. 1 à 3 — fermée, avec la preuve de complétude suivante.**

| # | Condition découverte en annexe | Où elle est portée aujourd'hui |
|---|---|---|
| 1 | clôture de 𝒳 | règle `Declassify`, prémisse `fv(v) = ∅` (§2.4), écrite à la séance 32 |
| 2 | clause de niveau sur `Op` | §1.4 (« le niveau d'un calcul est un indice distinct de `niv(r)` ») ; clauses `Op`, `Case`, `Tick` du ch. 3 ; `BLOQ-05` |
| 3 | lecture par borne des annotations | §1.3, `P3` (« une annotation dit ce que le calcul ne dépassera ») ; `PORT-10` |
| 4 | inversion de sédimentation sur deux axes | §1.4, table de sédimentation lue comme une lecture, inclusions et lecture inverse (pureté recouvrée) ; `PORT-15` |
| 5 | forme vectorielle indexée du facteur temporel | §1.4, phrase ajoutée à la séance 32 (le facteur est une famille indexée par les niveaux, le mononiveau redonne la forme plate) |
| 6 | produit mixte du sous-typage | §1.3 (`tab:produit-mixte`), §2.4, ch. 3 ; `BLOQ-14` |

**`FACT-09` : codes d'erreur et prémisse manquante.** Table écrite hors du manuscrit : [`codes-et-premisses.md`](../suivi/codes-et-premisses.md), 48 codes
sur 48, gardée par `scripts/controles/structure.py`. **Résultat négatif** : l'objectif « 18 familles, 4 diagnostics universels » de la relecture F
n'est pas atteint ; 17 codes sur 48 relèvent d'une non-dérivabilité structurelle (contraction ou affaiblissement, portée, frontière de couche,
phase), 31 relèvent d'autres mécanismes (couverture, effets, tailles, bornes, graphe, hors jugement). L'annexe A n'est pas modifiée.

**Point de forme du copatron.** La liaison implicite `x` du copatron est un **thunk** (`x :₁ U_ε(να.C⟨i⟩)`, employée par `force x`) : le lemme de
substitution, énoncé pour des valeurs, s'applique, et le cas du copatron de la préservation se dérive par `Th`, `Sub` et ce lemme. Le schéma de
réduction substitue `thunk ⟨⟨j ↦ c_j⟩⟩` à `x`. (Choix de la lecture « thunk » plutôt que d'un lemme pour les variables de calcul : c'est la
discipline de l'appel par poussée de valeur, et elle ne demande aucun lemme de plus.)

**Anomalie nouvelle, signalée : `ANOM-18`.** Le facteur temporel de l'effet est écrit `ℕ∞^ℒ` dans la prose de la grammaire des types, dans
`thm:temps_mononiveau` et dans le §4.8, `(ℕ∞ × ℕ∞)^ℒ` (travail, profondeur) dans la formule `eq:grammaire-types`, et `⟨w, s⟩` sans indice de
niveau dans les schémas de réduction (`spawn`, `move`). La phrase ajoutée au ch. 1 ne dit donc que « famille de coûts temporels indexée par les
niveaux ». À trancher par l'auteur : la forme complète est-elle `(ℕ∞ × ℕ∞)^ℒ` ?

**Ce qui n'a pas été écrit, et pourquoi.**

* **Les trois lemmes de compatibilité de `STRUCT-05` / `TRANS-04`** (un par famille de réécriture : fusion et déforestation, inlining,
  défonctionnalisation, avec `P-trace(ℓ)`) : ils demandent un modèle de coût de chaque réécriture sur la trace projetée que le texte ne donne pas ;
  les écrire reviendrait à inventer ce modèle.
* **Les clauses de traduction du fil de temps pour l'application et l'opération à portée** (`PREUVE-03`) : elles obligent à faire passer des
  maillons dans un appel, ce que le tableau des capacités (`tab:capacites`) ne permet pas (un maillon ne se transmet que le long d'un fil) ;
  c'est la même question que pour `spawn` et elle relève de l'étude comparative (C).
* **Le terme `⊥_S`** (plus petit élément d'un type de `Trellis_fin`) : la prose du §2.4 (ensembles finis, élément neutre vide) et les quatre
  clauses de la grammaire (somme comprise) ne disent pas la même chose du plus petit élément d'une somme ; le choix est un choix de modèle.
* **La simulation en `→⁺` ou `→*`** : la phrase du §4.8 reconnaît déjà l'incertitude ; la trancher demande les clauses de traduction de `spawn`, `new`
  et de la réussite de `try`.
* **`thm:terminaison_lfp` contre `ℰ = ∅`** (le grade d'effet de `fix f` est-il une fonction de l'indice de `S` ?) : le schéma écrit suit la règle ;
  la phrase du théorème parle d'autre chose que d'un effet ; le tranchement dit si l'itération coûte des pas de temps, ce qui est de fond.
* **`IMPL-08`** (occurrences effectives des métavariables) : « si on le juge utile » ; non jugé utile ici, aucune erreur de ce type n'a été relevée.
* **Les fiches de recherche** (`BIB-04`, `-12`, `-21`, `-24`, `-25`, `-27`, `PREUVE-16`, `BIB-01`) : le corps des articles n'est pas accessible
  depuis la session ; voir la partie C.
