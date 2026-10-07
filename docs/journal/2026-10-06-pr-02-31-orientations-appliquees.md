<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 31 : les orientations de l'instruction, appliquées « à ratifier »

Suite de l'[audit de la séance 30](2026-10-06-pr-02-30-arbitrages-deja-pris.md). Convention du dépôt : quand
l'instruction ([`instruction-des-decisions`](../recherche/instruction-des-decisions.md),
[`instruction-arb-pr-04`](../recherche/instruction-arb-pr-04-rejeu-binaire.md)) donne une orientation et qu'elle ne
dénature pas le projet, on l'applique et la décision est marquée **à ratifier** dans [`DECISIONS.md`](../suivi/DECISIONS.md).
Aucun sceau n'est changé ; les changements de sceau proposés sont dans `DECISIONS.md`. Modifications du manuscrit, au
minimum, sur mandat de l'auteur ; chacune est nommée ici.

## Modifications du manuscrit

| Décision | Où | Ce qui est écrit |
|---|---|---|
| `ARB-PR-04`, voie B puis C | §4.5 (`EchelleDuSysteme`), ch. 1 (`Postulats`) | `E_repro` à **quatre** composantes (ordonnancement, arrondi, version de la chaîne, architecture et comportement des NaN) ; promesse de l'identité binaire **sur une machine** ; pas de rejeu binaire multi-acteurs (journal non borné, contraire à P3) ; repli sur le rejeu logique si la réalisation ne tient pas. Le texte disait « aucune des trois composantes » alors que l'énoncé en listait déjà quatre : corrigé. |
| `IMPL-07` / `BLOQ-12` | §3.2 (`LesContraintesDeValeur`) | tables `tab:propagation-addition` et `tab:propagation-produit` sur les classes `0`, `x`, `∞`, `⊥` (théorie des roues : `0/0 = ⊥`, `1/0 = ∞`, `∞ + ∞ = ⊥`, `0·∞ = ⊥`, `∞·∞ = ∞`, `⊥` absorbant) ; règle d'entrée Float64 → roue : NaN lu `⊥`, `±∞` lus `∞` (les deux infinis d'IEEE 754 sont **identifiés**), `±0` lus `0` ; l'égalité de couche 3 compare les classes de singularités, jamais la charge utile d'un NaN. `∘` et `δ` ne sont définis ni par la théorie des roues ni par le texte : aucune ligne ne les porte, le choix est laissé ouvert. |
| `IMPL-04` | §4.5 | un anneau SPSC par couple (émetteur, boîte), une file de jonction par acteur ; l'appariement atomique se lit sur l'unicité du consommateur ; ordre fixe des émetteurs pour le choix du message ; borne mémoire connue par le graphe de câblage ; MPSC écarté (comparer-et-échanger, P3). |
| `STRUCT-16` | §3.1 (`LeSystemeGradue`) | le mode est attaché à la couche, donc au délimiteur (`tab:delimiteurs`) ; `Rel` est admissible, aucune zone ne l'instancie ; la grammaire des grades reste libre pour `Lin_k` et `1/N`. |
| `FACT-12` / `STRUCT-01` | §1.4 (`AxiomatiqueGerminale`) | la décomposition module × ordre tient lieu de cadre ; une adjonction graduée stricte serait fausse en l'état (loi distributive affaiblie, `thm:loi_distributive_conditions`). |
| `FACT-14` | §2.4 (`AdjonctionsEtEnrichissement`) | les trois notions de monotonie ne partagent aucun mécanisme : pas de cadre unique. |
| `D-7` | annexes B, C, D | bandeau « esquisse » ; le corps n'en dépend pas, il se borne à les citer. |
| `BLOQ-05` | §4.7 | une phrase : le lemme de correspondance n'exige pas d'indexer le jugement. |
| `ANOM-17`, orientations | §3.2 (`Guard`, grammaire), §4.7 | voir ci-dessous. |

### `ANOM-17` : ce qui est écrit, ce qui reste

Écrit (formule `eq:reductions-orientees`, table `tab:couverture-reductions` mise à jour) :

* **`slice`** (voie B) : jeton de capacité sans contenu, valeur d'exécution comme les localisations de la couche 2 ;
  `slice κ as (x,y) in c → c[κ/x, κ/y]` ; la sûreté spatiale reste un fait de typage.
* **`∥` et `vmap`** (voie B, comme étape vers la C) : fourche et jointure, la trace s'étend d'un seul événement,
  la composition parallèle des produits des traces des branches ; cela conserve la profondeur que le type annonce.
  Reste l'entrelacement avec une trace par branche (voie C), qui rend la trace partielle dès la couche 3.
* **`guard` multi-places** (voie A) : motifs conjonctifs `m₁(x̄₁) & … & mᵣ(x̄ᵣ)` à la grammaire et à la règle Guard ;
  `k = 1` redonne la garde à un message ; le motif de jonction du ch. 4 en devient une forme. Le choix du message suit
  `IMPL-04` (ordre fixe des émetteurs).
* **défaillance de `try`** (voie A) : un pas de l'environnement, `try c catch h → h` avec l'événement `fail`, sans retour
  en arrière ; la jointure des contextes y est requise comme pour la réussite.
* **points de forme** : l'énoncé du progrès liste désormais `Λα.c` et le copatron ; le sous-typage des tailles est écrit
  (`νC⟨j⟩ <: νC⟨i⟩` pour `i ≤ j`) ; l'énoncé de `thm:determinisme_parallele` disait que le premier effet « majore » le
  second, quand la preuve donne `max(s₁, s₂) ≤ s₁ + s₂` : corrigé (le second majore le premier). Le sceau n'est pas touché.
* `spawn`, comptabilité du travail : la voie A (événement de provision à la mère, événements réels à la fille) est celle
  que le texte écrit déjà ; rien à changer.

**Restent en attente**, une ligne chacun :

* `declassify`, les six formes temporelles, `at_n` et `move` : ces trois groupes partagent un défaut que l'orientation ne
  règle pas seule, celui de la **grammaire** (des termes jugés sans effet sont rangés parmi les calculs ; `□V`, `◇V`,
  `○C`, `@_n C`, `!_ℓ' A` conclus par les règles ne sont pas des types de la grammaire des types, qui ne porte les trois
  modalités temporelles que sur les sessions) ; choisir entre corriger les grammaires, retyper les règles, ou renvoyer
  ces formes au métalangage (voie C) est un choix de fond ;
* le fil de temps de la fibrille engendrée par `spawn` : la bifurcation par maillon (voie A) demande qu'une fibrille
  ouvre une chaîne par niveau et que le gestionnaire écoute un arbre de chaînes, donc d'étendre le système de sortes et le
  protocole du gestionnaire ; ce n'est pas écrit.

## `STRUCT-06` : la recommandation « Expansion = 1.5 » ne s'applique pas telle quelle

La recommandation (expansion = phase 1.5, sans renumérotation) suppose que 1.5 est libre. Elle ne l'est pas : la figure 11
porte déjà **Phase 1.5 : ConfigAnalysis** et le texte y range la vérification d'acyclicité (ch. 3, 4, 5). Les deux
options restantes ne sont pas équivalentes : une décimale de plus (expansion = 1.25, rien n'est renuméroté, mais le
motif « .5 » est rompu), ou Parse = 0 puis Expansion = 1 (neuf mentions de « Phase 0 » deviennent « Phase 1 »). La figure
n'est pas retouchée. Reste en attente avec cette question exacte.

## Autres éléments traités

* `PREUVE-05` : la loi distributive **affaiblie** est retenue (le texte l'écrit déjà) ; la loi stricte demanderait de
  restreindre `ℰ₀` à une partie commutative, ce que le séquencement refuse ; à ratifier.
* `BIB-17` (sens de l'invalidation au destructeur d'une capacité exportée, signalé à la séance 28) : le §4.5 dit désormais
  que l'exportateur, propriétaire de la région, **invalide localement** l'étiquette annoncée (dans les protocoles
  d'accès distant, l'invalidation s'exécute chez le propriétaire, sur sa demande ou celle de l'accédant) ; à ratifier.
* `FACT-21` et `FACT-22` (cadres écartés par `ARB-PR-05`) sont consignées dans
  [`factorisations-refusees.md`](../suivi/factorisations-refusees.md).
* `T-68` : proposition de vocabulaire préparée en tête de [`primitives.md`](../suivi/primitives.md) ; rien n'est renommé.
* `D-8` : tranchée et appliquée de longue date (`ANOM-06`), la ligne est retirée des questions ouvertes.

## Vérifications

`python3 scripts/controle.py` (tous verts), `lake build Spec` (sans avertissement), rendu HTML et TeX de
`lake exe spec --output … --with-tex` (sans erreur), `python3 scripts/manuscript_metrics.py summary` (45 formules, 32
tableaux, 627 renvois, 0 non résolu).
