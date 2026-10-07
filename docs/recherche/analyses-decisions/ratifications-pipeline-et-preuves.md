<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Ratifications : le pipeline de compilation et l'ordre de préservation

Fiches traitées : `STRUCT-06` (numérotation des phases, avec `REECR-16`), `STRUCT-05` et `TRANS-04` (ordre de préservation). Elles portent sur le même passage, le §6.1 (`spec/Spec/C6/LeProcessusDeCompilation.lean`), et la figure 11.

**Niveau de vérification.** Lecture directe du Verso (les fichiers et lignes cités), de la source Org archivée (`archives/manuscrit-org/chapitres/c5-syntaxe.org`) pour retrouver les anciens numéros, du CSV, de `DECISIONS.md`, des journaux 22 et 32, et de la fiche d'origine (`docs/relectures/pr-02/taches-consolidees.md`). **Rien n'a été compilé** et aucune source externe n'a été lue ; les constats ci-dessous sont des constats de lecture, repérables par grep. Les corrections proposées sont des textes, **non appliqués**.

Rappel des portes : P1 aucun bloquant ouvert ; P2 énoncés ouverts avec route nommée ; P3 décisions `ARB-PR-03`, `-04`, `-06`, `-07` ; P4 les huit exigences `IMPL` ; P5 `REECR`, anomalies, relecture d'ensemble ; P6 la release (`TABLEAU-DE-BORD.md` §2.D).

## `STRUCT-06` (et `REECR-16`) : numérotation consécutive de 0 à 10

### Ce qui a été appliqué

* Commits `35d6104` (renumérotation et figure) et `7605e72` (la phase 2.5 renommée Résolution), séance 32 §A.1.
* Figure 11 (`spec/figures/compilation-process.svg`, `.pdf`, source drawio redessinée) : onze étapes, `Parse 0`, `Expansion 1`, `ConfigAnalysis 2`, `TypeCheck 3`, `Résolution 4`, `PurityCheck 5`, `TermProof 6`, `ConstraintSolve 7`, `Optimize 8`, `CodeGen 9`, `Link 10` ; trois points de contrôle (1, 2, 4) en pointillés.
* §6.1 : paragraphe de lecture (onze étapes, huit ordres de vérification : les phases 0, 3, 5, 6, 7, 8, 9, 10), paragraphe nouveau sur la Phase 1, phase de résolution nommée, acyclicité rattachée à la Phase 2.
* Reports « Phase N » dans les chapitres 1 à 7 et les annexes A et D ; le §6.2 (`CeQueLeSolveurRetourne`, modes `+dev`, `+release`) reformulé en « phases 0 à 5 », « Phase 6 allégée », « phases 7 à 9 » ; le §6.3 (doctests) reformulé sans numéro de phase.
* Décision de l'auteur (mot pour mot) : « Renumérote toutes les phases de compilation pour les remettre en cohérence. » Ce qui reste à ratifier est le **schéma**, pas le principe.

### Relecture critique face au manuscrit actuel

**Ce qui tient (vérifié).**

* Aucune fraction ne subsiste : un grep de `Phase 1.5`, `Phase 2.5`, `Phase 0` fractionnaire ne trouve rien ; les seules occurrences de « Phase 0 » (`C5.lean:48`, `C5/LeTheoremeDElaboration.lean:28`) désignent bien Parse.
* La table ancien → nouveau du journal est respectée là où l'ancien texte est retrouvable. Exemple contrôlé : `C5.lean:48` disait « vérifié en Phase 1.5, après résolution des noms, et non en Phase 1 » (Org archivé) ; il dit maintenant « Phase 2 ... non en Phase 0 », ce qui est l'image exacte de 1.5 → 2 et 1 → 0.
* Les mentions qui touchent les phases se lisent correctement : solveur en Phase 7 (`C3/LesContraintesDeValeur.lean:26`, `C6/StrategiesDeVerificationEtDeTest.lean:36,57`), terminaison et productivité en Phase 6 (`C2/AlgebresCoalgebresEtPointsFixes.lean:159,316`), pureté en Phase 5 (`:323`, `C5/SExpressionsUniverselles.lean:142`), effacement en Phase 10 (`C2`, `C4/CalculDeProcessusSousJacent.lean:272`, `C1/AxiomatiqueGerminale.lean:693`), expansion en Phase 1 (`C3`, `C5`), acyclicité en Phase 2 (`C3/LesContraintesDeValeur.lean:290,314,320`, `C4/EchelleDuSysteme.lean:343,351`, `C7`), validation de conformité en Phase 9 (`C4/EchelleDuSysteme.lean:198`).
* Le texte et la figure disent la même chose (les onze libellés du SVG coïncident avec le §6.1).
* Le compte « huit ordres » est cohérent avec la liste « 0, 3, 5, 6, 7, 8, 9, 10 ».

**Défauts relevés.**

1. **`ERR-TOP-001` est rattachée à deux phases différentes.** `C5.lean:48` dit que le marquage des délimiteurs est vérifié « en Phase 2, après résolution des noms » ; `C5/SExpressionsUniverselles.lean:57` dit que l'imbrication interdite est « rejetée en Phase 3 (`ERR-TOP-001`) ». L'écart existait avant (1.5 contre 2 dans l'Org) ; la renumérotation le conserve fidèlement et le rend plus visible, parce que 2 et 3 sont maintenant deux étapes nommées. Plus grave : le §6.1 ne dit **nulle part** que la Phase 2 (ConfigAnalysis) vérifie le marquage ; elle y collecte les ressources externes et établit l'acyclicité. Le chapitre 5 attribue donc à la Phase 2 un travail que le chapitre 6 ne lui donne pas.
2. **La Phase 0 est comptée parmi les huit « ordres de vérification », et le §6.1 dit qu'elle « ne discute encore aucun des trois ordres »** (`LeProcessusDeCompilation.lean:63-64`). Pris à la lettre, l'ordre de vérification de Parse est vide. Ce n'est pas faux (Parse est un ordre de vérification de la forme, au sens large), mais la phrase de lecture de la ligne 31 (« huit ordres de vérification, chacun supposant le précédent acquis ») et celle de la ligne 24 (« chacun des trois ordres de vérification du jugement germinal ») ne désignent pas les mêmes objets : trois ordres du jugement, huit ordres du pipeline. Le texte ne le dit pas en une phrase.
3. **Réserves non rattachées au schéma.** Le §6.1 porte lui-même l'aveu que la suite linéaire « n'est pas le modèle défendu » (Phases 7 et 8 itérées, `thm:stabilisation_pipeline`). La figure 11 montre une chaîne linéaire de onze étapes sans la boucle. Ce n'est pas propre à la renumérotation, mais celle-ci fige la figure ; l'écart « se referme par un énoncé plutôt que par une figure » est assumé par le texte (ligne 168-169).
4. **Les fiches vivantes** : `DECISIONS.md` et le tableau « à ratifier » disent déjà que les anciens numéros restent dans les relectures et journaux antérieurs. Le contrôle `scripts/controle.py` ne garde que ce qu'il sait garder ; je n'ai pas vérifié qu'il garde les numéros de phase (hypothèse non vérifiée).
5. **Anomalie du §6.3 signalée par la séance 32** (doctests exécutés « pendant la Phase 1 » dans l'ancien texte) : le texte dit désormais « avant la génération de code (Phase 9) » ; la phase exécutant les tests n'est pas fixée. Pas une erreur ; c'est un trou dans la description du pipeline (aucune phase ne « porte » les tests).

6. **La résolution des noms n'a pas de phase.** La seule mention est `C5.lean:48` (« vérifié en Phase 2, après résolution des noms ») ; le §6.1 ne place nulle part cette opération (la Phase 4 résout des variables d'unification, la Phase 1 la liaison `bind-to`, la Phase 2 le manifeste et l'acyclicité). `docs/suivi/codes-et-premisses.md` range `ERR-TOP-011` et `ERR-TYP-010` sous « Phase 4 » faute de mieux. C'est le même mot « résolution » pour deux opérations, que `STRUCT-06` point 2 avait relevé pour « élaboration ».

### Alternatives écartées et pourquoi

| Schéma | Pourquoi écarté |
|---|---|
| Expansion = 1.5, rien n'est renuméroté (recommandation de l'instruction) | 1.5 était déjà pris par ConfigAnalysis (constat de la séance 31) |
| Expansion = 1.25 | rompt le motif « .5 » et ajoute un troisième motif de numérotation |
| Parse = 0, Expansion = 1, le reste inchangé | laisse un « 1 » entier qui est un point de contrôle et un « 1.5 » qui en est un autre : deux sortes de numéros |
| Garder les fractions pour les seuls points de contrôle, renuméroter les entiers | c'est la convention d'origine ; l'auteur a demandé de la remettre en cohérence |
| Lettres (A, B…) ou noms seuls, sans numéro | les chapitres invoquent « Phase N » vingt fois ; le numéro est le renvoi |

Le schéma retenu est le seul à n'avoir qu'un motif. Son coût est mécanique et connu (table de passage).

### Risque si on ratifie

Faible. Le décalage est une bijection sur les numéros de 0 à 10 ; l'erreur résiduelle possible est un numéro mal reporté dans un passage que le grep ne montre pas parce qu'il est écrit en toutes lettres (« la phase d'inférence »). Le relevé ci-dessus n'en trouve pas. Les documents antérieurs lus avec l'ancienne numérotation se lisent avec la table.

### Risque si on refuse

Moyen : il faudrait choisir un autre schéma et refaire la figure et une vingtaine de fichiers, alors que l'auteur a déjà demandé la renumérotation. Refuser le **principe** reviendrait à revenir au défaut d'origine (Phase 0 invoquée et absente de la figure).

### Ce que la ratification débloque ou ferme

Ferme `STRUCT-06` (statut `a-ratifier` → `fermee`) ; `REECR-16` est déjà `fermee` au CSV (« l'expansion est la Phase 1 »), la ratification la confirme. Contribue à P5 (relecture d'ensemble). Ne touche ni P1 ni P3. Après ratification, le renommage de `T-68` pourra s'appuyer sur des numéros stables.

### Verdict recommandé

**Ratifier, avec une correction (le défaut 1) et une précision (le défaut 2).**

### Correction minimale proposée (non appliquée)

(a) Aligner les deux mentions d'`ERR-TOP-001` (le tableau `codes-et-premisses.md` dit déjà « vérifiée en Phase 3 »). Le plus simple est de dire que le rejet a lieu à la Phase 3 dans les deux cas, ce qui est cohérent avec le §6.1 (c'est la vérification du jugement germinal, donc du typage). Texte proposé pour `C5.lean:47-48`, remplaçant « en Phase 2, après résolution des noms, et non en Phase 0 » par :

> en Phase 3, après la résolution des noms, et non en Phase 0

Si au contraire l'auteur veut que le marquage soit un point de contrôle de la Phase 2, il faut l'écrire au §6.1, dans le paragraphe de la Phase 2 : « La configuration vérifie aussi le marquage des délimiteurs (chapitre 5), qui suppose la résolution des noms. » ; ce qui contredirait la définition de la Phase 2 (avant la vérification de types) puisque la résolution des noms n'est pas encore faite. **Je recommande donc la première forme.**

(b) Une phrase au §6.1, après « le compte reste de huit » (défaut 2) :


> Les huit ordres du pipeline ne sont pas les trois ordres du jugement : ceux-ci sont établis par les phases 3, 5 et 6 ; les cinq autres (analyse syntaxique, solveur, optimisation, génération, édition de liens) vérifient chacun une propriété qui leur est propre et supposent le précédent acquis.

(Le rattachement « 3, 5, 6 » aux trois ordres suit la composition du §6.1 : `A` en Phase 3 et 4, `ℰ` en Phase 5, terminaison en Phase 6. Je n'ai pas vérifié que le chapitre 1 numérote ses trois ordres dans cet ordre ; à confirmer avant d'écrire.)

(c) Une phrase au §6.1, dans le paragraphe de la Phase 2 (défaut 6) : « La résolution des noms, qui précède la vérification de types, est faite à la Phase 2 : elle suppose l'arbre figé de la Phase 1. » **(rattachement conjectural : l'auteur choisit la phase.)**

## `STRUCT-05` et `TRANS-04` : l'ordre de préservation et la règle d'interaction

### Ce qui a été appliqué

* Commit `bfd34e0` (séance 22), §6.1, `tab:invariants-de-passe` (`LeProcessusDeCompilation.lean:171-211`).
* Quatre invariants : `P_dén` (toutes les passes), `P_grad` (les passes d'abaissement), `P_trace(ℓ)` (les passes appliquées à une unité ℓ-sensible), `P_repr` (l'environnement, sous le profil Π).
* Règle d'interaction : une unité marquée ℓ-sensible n'admet que les passes qui préservent `P_trace(ℓ)` ; le point fixe est itéré exactement `h` fois dans le code ℓ-sensible, évalué de façon semi-naïve ailleurs ; fusion et déforestation admises partout sauf dans le code ℓ-sensible ; le marquage est la composante de niveau que le jugement porte déjà.
* Le texte dit lui-même : « Cette déclaration est proposée à la ratification de l'auteur ; elle ne résout pas le conflit entre P3 et la non-interférence temporelle, elle le localise » (ligne 209-211).
* Ce n'est pas une preuve, mais une déclaration. Les **trois lemmes de compatibilité** (fusion et déforestation, inlining, défonctionnalisation, chacun avec `P_trace(ℓ)`) ne sont **pas** écrits (séance 32 : ils demandent un modèle de coût de chaque réécriture sur la trace projetée que le texte ne donne pas).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* Les quatre invariants sont bien distincts et pas comparables, comme le dit le texte. `P_repr` renvoie à un objet défini : le profil de représentation Π est défini au §4.5 (`EchelleDuSysteme.lean:191-199`), avec ses sept composantes, et ce paragraphe dit que les théorèmes de disposition et de rejeu binaire sont des propriétés de conformité vérifiées en Phase 9. La liaison `P_repr` ↔ `thm:rejeu_binaire` ↔ ratification d'`ARB-PR-04` est donc cohérente.
* Le conflit d'origine (point fixe itéré exactement `h` fois contre semi-naïf) est bien tranché par zone, sans nouveau mécanisme.
* `thm:abaissement_grades` (conjecture, niveau « compilation », `CeQueLeSolveurRetourne.lean:464`) est cohérent avec le tableau : la preuve se conduit « passe par passe » et est une propriété de conformité.

**Défauts relevés.**

1. **La règle d'interaction ne mentionne que fusion et déforestation**, alors que la phrase qui la précède (lignes 174-176) dit que « fusion de boucles, déforestation et _inlining_ » ne sont pas admissibles dans le code où la non-interférence temporelle est revendiquée, et que la fiche d'origine ainsi que le Th. 36 parlent de trois familles de réécriture (fusion/déforestation, inlining, défonctionnalisation). Le texte ne dit pas ce qu'il en est de l'inlining et de la défonctionnalisation dans le code ℓ-sensible : la règle générale (« n'admet que les passes qui préservent `P_trace(ℓ)` ») les couvre en droit, mais l'énumération « admises partout sauf » est incomplète en fait et peut se lire comme « l'inlining est admis partout ». C'est un trou de rédaction, pas de fond.
2. **« Le marquage est la composante de niveau que le jugement porte déjà : aucun mécanisme nouveau »** est plus fort que ce que le texte établit. La composante de niveau du jugement indexe un *calcul* (`niv(Δ)`, `thm:correspondance_niveaux`) ; la règle parle d'une *unité* marquée ℓ-sensible (unité de compilation, qui porte un grade budget, `CeQueLeSolveurRetourne.lean:46-62`). Le passage de l'un à l'autre (une unité est ℓ-sensible si l'un de ses calculs l'est ? si son interface l'est ?) n'est écrit nulle part. « Aucun mécanisme nouveau » vaut pour le *vocabulaire* (le niveau), pas pour la *règle de marquage*. Je n'ai pas trouvé d'autre définition dans le Verso (grep de `sensible`, `unité de compilation`).
3. **`P_grad` : « les passes d'abaissement » dans le tableau, « l'obligation de chaque passe » dans la phrase suivante** (ligne 206-207) ; `thm:abaissement_grades` parle de « chacune des passes du pipeline ». Les deux formulations ne sont pas équivalentes (l'abaissement vers MLIR est une passe parmi d'autres). À aligner.
4. **« pour le niveau du binaire »** (ligne 209) : le « niveau du binaire » n'est défini qu'à `StrategiesDeVerificationEtDeTest.lean:106` (« au niveau du binaire testé : c'est le critère opérationnel de la compilation reproductible »), pas ici. Lecture probable : le niveau auquel la compilation doit être reproductible ; à dire.
5. **Trou voisin, hors de la ratification mais sur le même passage : la preuve de `thm:stabilisation_pipeline` ne tient pas telle qu'écrite.** L'esquisse dit « chaque tour qui modifie le terme consomme au moins une unité du budget de spécialisation » (lignes 227-229). Or le paragraphe qui suit (257-271) dit que la déforestation, la défonctionnalisation et la fusion de boucles font décroître strictement *une mesure entière* sans consommer de budget, et que seul l'inlining et la monomorphisation décrémentent le budget. L'énoncé est probablement vrai, par l'ordre lexicographique (budget, mesure) : l'inlining fait baisser la première composante même si la seconde monte, les trois autres font baisser la seconde sans toucher la première. L'esquisse doit dire cela ; telle qu'elle est, elle est fausse pour les trois réécritures qui ne consomment pas de budget. Constat de lecture, non vérifié par ailleurs.
6. **Les trois lemmes de compatibilité manquent**, ce que la ratification de la déclaration ne règle pas ; la fiche reste à 70 % tant qu'ils ne sont pas écrits.
7. **Le conflit P3 / non-interférence temporelle n'est que localisé.** C'est dit honnêtement. Reste que la règle suppose que l'unité ℓ-sensible *perd* les optimisations qui font gagner du coût : le prix de P3 dans ces unités n'est pas chiffré (la fiche d'origine donnait un facteur de l'ordre de 10⁵ sur un univers de 10⁶ constantes ; ce chiffre vient de la relecture, je ne l'ai pas revérifié).

### Alternatives écartées et pourquoi

* **Un seul invariant** (par exemple « tout préserve la trace ») : écarté parce qu'il interdit l'évaluation semi-naïve, que le §4.5 déclare indispensable (fiche d'origine).
* **Abandonner la non-interférence temporelle** : écartée, elle est une revendication du ch. 4.
* **Abandonner l'optimisation** (P3) : écartée pour la même raison, du côté de P3.
* **Ne rien déclarer** (laisser le conflit implicite) : écarté, c'est l'état antérieur, où trois candidats d'invariant coexistaient sans être distingués.
* **Marquage par un mécanisme nouveau** (annotation de passe, effet d'optimisation) : écarté au nom du « aucun mécanisme nouveau » ; mais voir le défaut 2.

### Risque si on ratifie

Moyen. Ratifier la déclaration engage deux choses : (i) que la **règle de marquage** existe (défaut 2), faute de quoi la règle est inapplicable ; (ii) que la perte de coût dans le code ℓ-sensible est acceptée. Le risque réel est de ratifier un texte qui *se lit* comme complet alors que trois lemmes manquent. Il est atténué par la mention explicite des lemmes dans la fiche, pas dans le texte du manuscrit : **le manuscrit ne dit pas que les trois lemmes manquent**. Je le propose en correction.

### Risque si on refuse

Moyen à élevé : la fiche retombe à zéro et `thm:abaissement_grades` perd sa forme mécanisable (« `P_grad` est l'obligation de chaque passe »), `PREUVE-02` n'a plus de cadre pour être conduite passe par passe, et le critère de la compilation reproductible disparaît.

### Ce que la ratification débloque ou ferme

* `STRUCT-05` et `TRANS-04` : se ferment à l'écriture des trois lemmes, pas à la ratification (70 % → reste le travail).
* `PREUVE-02` (Th. 36, 10 %) : donne la forme « passe par passe ».
* `STRUCT-06` n'en dépend pas ; l'inverse non plus.
* Porte P5 (relecture d'ensemble) et, indirectement, P2 (une route nommée pour la préservation graduée).
* Ne ferme aucune des portes P1, P3, P4.

### Verdict recommandé

**Ratifier avec correction** : les points 1, 3, 4 sont des retouches de rédaction ; le point 2 (règle de marquage) est la seule vraie pièce manquante, et je recommande de ratifier **la déclaration** en écrivant dans le texte que le marquage d'une unité est à définir (plutôt que d'affirmer « aucun mécanisme nouveau »). Le point 5 est à traiter à part (c'est une erreur de preuve, pas un point de ratification).

### Correction minimale proposée (non appliquée)

Remplacer, à la ligne 204-206, « fusion et déforestation sont admises partout sauf dans le code ℓ-sensible. Le marquage est la composante de niveau que le jugement porte déjà : aucun mécanisme nouveau. » par :

> fusion, déforestation, mise en ligne et défonctionnalisation ne sont admises que là où elles préservent `P_trace(ℓ)` ; le code ℓ-sensible n'en admet aucune tant que le lemme de compatibilité correspondant n'est pas écrit. Le niveau que le marquage invoque est celui que le jugement porte déjà (`niv(Δ)`) ; la règle qui fait d'une unité de compilation une unité ℓ-sensible (par exemple : son interface porte un calcul de niveau `ℓ`) n'est pas encore écrite.

Remplacer, ligne 209-211, la phrase « Cette déclaration est proposée à la ratification de l'auteur ; elle ne résout pas… » par (une fois ratifiée) :

> Cette déclaration ne résout pas le conflit entre P3 et la non-interférence temporelle, elle le localise. Les trois lemmes de compatibilité qu'elle appelle (fusion et déforestation, mise en ligne, défonctionnalisation, chacun avec `P_trace(ℓ)`) ne sont pas écrits : ils demandent un modèle de coût de chaque réécriture sur la trace projetée.

Tableau : « `P_grad` : les passes d'abaissement » devient « chaque passe, comme obligation de l'abaissement ; l'abaissement vers MLIR en est le cas d'espèce du théorème `thm:abaissement_grades` ».

Esquisse de `thm:stabilisation_pipeline` (point 5), remplacer la première phrase par :

> Chaque tour qui modifie le terme, ou bien consomme au moins une unité du budget de spécialisation (mise en ligne, monomorphisation), ou bien laisse le budget intact et fait strictement décroître une mesure entière (déforestation, défonctionnalisation, fusion). Le couple (budget, mesure), ordonné lexicographiquement, décroît donc strictement à chaque tour qui modifie le terme ; cet ordre est bien fondé.

(Cette dernière correction est une correction de preuve ; elle exige l'accord de l'auteur au même titre que les autres.)
