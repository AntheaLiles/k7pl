<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — séance 33 : sourcer les propagations de singularités

Suite de la séance 32 (§A.2). Mandat de l'auteur : « Les singularités sont à définir, leurs propagations réelles sont à sourcer dans les références. » Le manuscrit n'est modifié que sur ce mandat, au plus juste ; les changements sont nommés ici, dans [`spec/CHANGELOG.md`](../../spec/CHANGELOG.md) et dans les fiches `BLOQ-12`, `IMPL-07`. Aucun sceau n'est changé.

## A — Niveau de vérification des sources

Tous les chemins d'accès essayés sont fermés : arXiv, Wikipédia, MathWorld, Zenodo, Cambridge, `math.su.se`, DiVA, `studylib`, `ar5iv`, IEEE (`grouper.ieee.org`) répondent `EGRESS_BLOCKED` (403 au `CONNECT`, politique de sortie de l'organisation, non contournée). Seuls les résumés de la recherche en ligne sont lisibles : **aucun corps d'article n'a été lu**. Le détail, œuvre par œuvre, est dans [`recherche/sources-singularites`](../recherche/sources-singularites.md). Résultat net : `⊥` absorbant et `1/0 = ∞` sont attestés au niveau du **résumé** (Carlström, Setzer, Bergstra–Ponse, Anderson) ; les autres valeurs des tables sont **calculées** sur la construction de la roue des fractions ; `∘`, `δ` ne sont dans **aucune** source atteinte.

## B — Ce que le calcul a infirmé

Un programme (`scripts/verif_singularites.py`) énumère la roue des fractions de GF(2), GF(3), GF(5) et la confronte aux axiomes de la roue **tels que je les rappelle** (monoïdes commutatifs, `//x = x`, `/(xy) = /x /y`, `xz + yz = (x+y)z + 0z`, `(x + yz)/y = x/y + z + 0y`, `0·0 = 0`, `(x + 0y)z = xz + 0y`, `/(x + 0y) = /x + 0y`, `0/0 + x = 0/0`) : ils tiennent tous, ce qui appuie le rappel et les tables. Sur l'extension de la séance 32, au contraire :

* l'**associativité de `+` et de `·` échoue** : `(∞ + ∞) + ∘ = ⊥` mais `∞ + (∞ + ∘) = ∘`. Le texte affirmait l'inverse (« commutatives et associatives sur les six classes ») sans l'avoir vérifié. L'échec est de fond : si `∘` absorbe `∞`, l'associativité force `⊥ + ∘ = ∘`, et `∘ ⋆ δ = ⊥` devient incompatible avec elle ;
* « une roue n'a que deux éléments hors du corps » est vrai de la roue des fractions d'un corps seulement.

## C — Correction apportée au §3.2

Définition retenue (appliquée, **à ratifier**) : une erreur est un ensemble non vide d'étiquettes pris parmi `∘` et `δ`, et `+`, `·`, `1/·` rendent la réunion des étiquettes des opérandes, la valeur de la roue étant oubliée ; `∘δ` est une cinquième singularité. Le programme confirme monoïdes, involution et multiplicativité de l'inverse, et tous les axiomes rappelés **sauf** `0/0 + x = 0/0` sur les éléments étiquetés : l'extension n'est pas une roue, et le texte le dit. Modifications minimales du chapitre 3, §3.2 : l'introduction (« et leur combinaison `∘δ` »), la proposition `thm:homomorphisme_roues` (quatre singularités devenues cinq, dans l'énoncé et (i)), la phrase sur le nombre d'éléments d'une roue, le paragraphe des règles de `∘` et `δ`, et une citation d'IEEE 754-2019 (notice ajoutée à `biblio/references.json`, `tools/SpecBib.lean` régénéré par `scripts/biblio/biblio.py`). Les tables ne changent pas.

Alternatives laissées à l'auteur : retirer `∘`, `δ` ; priorité fixe ; renoncer à l'absorption de `∞` par `∘` (voir la note de recherche).

## C bis — Contrôle

`scripts/controles/singularites.py` (branché dans `scripts/controle.py`) recalcule les deux tables du §3.2 sur la roue des fractions de GF(5) et refuse une case fausse (auto-test), puis rejoue l'énumération de l'algèbre des erreurs ; les tables ne peuvent plus dériver du calcul sans que le contrôle échoue.

## D — Parcours des attentes (`DECISIONS.md`, `ANOMALIES.md`, `RESTE-A-FAIRE.md`, `fiches-statuts.csv`)

Relevé des 32 fiches ouvertes et des anomalies ouvertes, avec, pour chacune, ce qui empêche d'écrire aujourd'hui. Rien n'a été écrit dans les cas ci-dessous : l'écrire reviendrait à trancher ou à inventer.

* **À ratifier (15 fiches)** : l'orientation est déjà appliquée au manuscrit ; il n'y a rien à rédiger, seulement la confirmation de l'auteur.
* **Décision de l'auteur en attente** : `spawn` et `∥` (études faites par un autre agent), `T-68` (renommage après ratification), `BIB-01` (conditionnel à `ARB-PR-03`), deux changements de sceau proposés (`thm:progres`, `thm:preservation`).
* **`ANOM-18`** (trois formes du facteur temporel de l'effet) : la forme `(ℕ∞ × ℕ∞)^ℒ` est celle de la formule, mais l'aligner change l'énoncé de `thm:temps_mononiveau` et dit si le travail et la profondeur sont indexés par le niveau : choix de modèle, laissé à l'auteur.
* **`IMPL-08`** : « si on le juge utile » ; non jugé utile (aucune erreur de ce type relevée depuis la séance 32).
* **Preuves** (`BLOQ-05`, `BLOQ-07`, `PREUVE-01`, `-03`, `-04`, `-07`, `FACT-10`) : les clauses manquantes dépendent des choix en attente (fil de temps de `spawn`, application et opération à portée) ou d'un modèle de coût que le texte ne donne pas ; voir la séance 32 (« ce qui n'a pas été écrit »).
* **Recherches** (`BIB-04`, `-12`, `-21`, `-24`, `-25`, `-27`, `PREUVE-16`) : exigent le corps des articles, inaccessible (§A) ; les résumés ont déjà été relevés.
* **Rapprochement des anciens documents** (`ANOM-15`, « ce qui n'a pas été rapproché ») : 2 700 lignes de questions et de manques déjà clos ; hors du périmètre de rédaction de cette séance.

Aucune fiche n'est fermée ni partielle de plus. Ce que la séance a produit pour `BLOQ-12`/`IMPL-07` est décrit plus haut.

## E — Statut

`BLOQ-12` : à ratifier, avancement inchangé ; sa suite devient : choisir parmi les alternatives, lire Carlström. `IMPL-07` : inchangé (tables et règle d'entrée à ratifier, test différentiel à l'implémentation). Les fiches ne sont pas fermées : aucune source n'a été lue dans son corps.

**Vérifications.** `lake build Spec`, `python3 scripts/controle.py`, `python3 scripts/verif_singularites.py` : verts.
