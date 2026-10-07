<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Ratifications : les schémas de réduction (`ANOM-17`), les annexes, les sceaux

Éléments traités : les cinq lignes `ANOM-17` « à ratifier » de `DECISIONS.md` (`slice` ; `∥` et `vmap` ; `guard` conjonctif ; défaillance de `try` ; `spawn`, comptabilité par provision), les points de forme (formes terminales, sous-typage des tailles, énoncé du parallèle, copatron), les **grammaires et les six schémas des modalités** (séance 32 §A.3), `PREUVE-04` et `TRANS-06` (séance 32 §A.5), `ANOM-09` et `ANOM-10`, `D-7`, et les **deux changements de sceau proposés** (`thm:progres`, `thm:preservation`).

**Niveau de vérification.**

* Lecture directe du Verso aux lignes citées : `spec/Spec/C3/GrammaireDesTermes.lean`, `C3/GrammaireDesTypes.lean`, `C3/ReglesDeTypage.lean`, `C2/AdjonctionsEtEnrichissement.lean`, `C4/SemantiqueOperationnelle.lean` (§4.7), `C4/EchelleDuSysteme.lean` ; de l'instruction et des journaux 29, 31 et 32 ; de `tools/SpecExt/` pour `ANOM-09`/`ANOM-10` (existence des fichiers et des macros, non leur exécution).
* **Rien n'a été compilé ni exécuté** (ni `lake build`, ni `lualatex`, ni `tectonic`). Les vérifications de typage et de comptage sont faites à la main sur les règles écrites.
* Je n'ai lu aucune source externe. Le journal 33 (`2026-10-07-pr-02-33-*`) cité par la demande n'existe pas dans le dépôt à la date de cette analyse (dernier journal : séance 32).
* Les études comparatives sur `spawn` et `∥` sont [`etude-spawn-fil-de-temps`](../etude-spawn-fil-de-temps.md) et [`etude-parallele-fourche-entrelacement`](../etude-parallele-fourche-entrelacement.md) ; je ne refais pas leur travail, je dis ce que la ratification des voies **appliquées** engage.

Portes concernées : P2 (route et hypothèse nommées), P5 (anomalies levées : `ANOM-17` est la dernière anomalie du manuscrit qui reste ouverte), P1 (progrès et préservation sont invoqués par `BLOQ-05`, `BLOQ-07`).

## Constats transversaux

* **S1. Le sceau « théorème » de `thm:preservation` ne tient pas, et l'énoncé lui-même est faux pour trois schémas.** L'énoncé (`SemantiqueOperationnelle.lean:381-384`) dit : si `Δ ⊢ c : C | ε` et `c → c'`, alors `Δ ⊢ c' : C | ε'` avec `τ'·ε' ⊑ τ·ε`. Or l'esquisse admet que pour `wait` le contractum se type dans `Δ` et le sujet dans `○Δ` (« au contexte avancé près »), que pour `move` les contextes `@_nΔ` et `@_mΔ` ne coïncident que par un lemme non écrit, et que pour `declassify` « la préservation graduée est fausse en l'état, et elle doit l'être » (`:462-470`). Un énoncé dont la démonstration déclare trois exceptions n'est pas un théorème tel qu'écrit ; ce n'est pas seulement un défaut de preuve, c'est un défaut d'énoncé. L'esquisse dit en outre que, pour les cinq règles de la couche 2 et les schémas orientés, la préservation n'est « pas démontrée » (typage des configurations absent, `:439-441`, `:453-455`).
* **S2. Le sceau « théorème » de `thm:progres` ne tient pas non plus.** La preuve ne couvre qu'une partie des constructeurs (« Aucun de ces cas n'est conduit en détail », `:518-526`), repose sur deux hypothèses de module (totalité de `⟦operation⟧` ; élimination de l'arène non écrite), et le **lemme des formes canoniques** (`:502-508`) liste onze formes mais **omet les littéraux de vecteur `[v₀,…,vₙ₋₁]`**, **le jeton de capacité `κ`** (valeur de type `Cap ρ`) **et les localisations `ι`** (valeurs de type `Mb E`), qui sont des valeurs de l'exécution (`SemantiqueOperationnelle.lean:162-163, 254-256` ; `GrammaireDesTermes.lean`, forme `[v₀,…]`). Un calcul clos qui élimine un vecteur ou une capacité n'a donc pas de forme canonique garantie par la liste écrite.
* **S3. Des passages en amont disent « démontrée ».** `StructuresOuvertesEffetsEtMetaTheorie.lean:310-313` écrit que la préservation par évaluation « est démontrée au §`sec:g-semantique` (théorème `thm:preservation`) » ; `C6/CeQueLeSolveurRetourne.lean:416` l'appelle « la préservation graduée du §`sec:g-semantique` (théorème …) ». Ces phrases contredisent l'esquisse ; elles se corrigent en même temps que le sceau.

Ces trois constats appuient les **deux changements de sceau proposés** (voir la fin du fichier).

## `slice` : jeton de capacité sans contenu (voie B)

### Ce qui a été appliqué

* Séance 31 (commit `fab136a`), `SemantiqueOperationnelle.lean:238, 252-256, 443-445` : `slice κ as (x,y) in c → c[κ/x, κ/y]` ; le jeton `κ` est « une valeur d'exécution comme les localisations de la couche 2 : close, sans contenu, typée `Cap ρ` pour tout segment `ρ`, et elle n'apparaît que par la réduction d'une découpe ; elle est effacée avec les grades ». La sûreté spatiale reste un fait de typage.
* Source : instruction (`slice`, voie B ; orientation « B, qui est la lecture de `thm:surete_spatiale` ») ; règle `Slice` du §3.2 (`ReglesDeTypage.lean:1256`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.** La préservation de ce schéma se déduit du lemme de substitution (jeton typé `Cap ρ₁` et `Cap ρ₂`, comme la prémisse de `Slice` l'exige), et la conclusion « sûreté spatiale = fait de typage » est cohérente avec `thm:surete_spatiale` (disjonction par l'addition des contextes).

**Défauts relevés.**

1. **La source du premier jeton manque.** Le texte dit que `κ` « n'apparaît que par la réduction d'une découpe » ; or la règle `Slice` consomme un `v : Cap ρ` déjà détenu, et `ReglesDeTypage.lean:1249-1253, 1268-1271` dit que « l'unique source de capacité initiale est l'élimination de l'arène », règle que le document **ne donne pas** (« Ce document ne la donne donc pas ici », `:1243-1247`). Dans la grammaire des termes il n'existe pas de constructeur qui produise un `Cap ρ`. Conséquence : aucun terme clos de la grammaire écrite ne produit de jeton, donc le schéma de `slice` n'a pas de rédex dans un programme clos ; la sûreté spatiale est un fait de typage de termes **ouverts** sur une capacité que rien n'introduit. C'est cohérent avec la mention de l'hypothèse « conformité de l'abaissement » (`:531-533`) ; mais l'énoncé « `κ` n'apparaît que par la réduction d'une découpe » est faux ou incomplet : il apparaît aussi par l'élimination de l'arène, qui n'a ni règle de typage ni schéma.
2. **Les deux variables reçoivent le même jeton** (`c[κ/x, κ/y]`). C'est sans conséquence dans un langage où le jeton est effacé, mais le texte dit « typée `Cap ρ` pour tout segment » : un même terme `κ` a donc les types `Cap ρ₁` et `Cap ρ₂` avec `ρ₁ ⊎ ρ₂ = ρ`, c'est-à-dire que le jeton est polymorphe en `ρ`. Dit une fois, pas contradictoire ; mais « valeur d'exécution close typée pour tout segment » est une valeur d'un type universel, hors de la grammaire des types (qui n'a pas de quantification sur les segments).
3. **La table `tab:couverture-reductions`** classe `slice` comme « écrit, à ratifier ; la règle ne donne pas le découpage dans le terme, et le typage le porte » : exact.

### Alternatives écartées et pourquoi

| Voie | Pourquoi écartée |
|---|---|
| A : annoter le terme (`slice_{ρ₁,ρ₂} v as (x,y) in c`) | un constructeur annoté de plus (comme `iter_V`), grammaire modifiée |
| B : jeton sans contenu | **retenue** : rien à annoter, la sûreté spatiale reste une propriété de typage |

### Risque si on ratifie

Faible : le jeton est effacé, aucune sémantique n'en dépend. Le défaut 1 est un trou de présentation, non une erreur de preuve (l'hypothèse sur l'arène est déjà déclarée).

### Risque si on refuse

Faible à moyen : la voie A demande de modifier la grammaire et la règle (un constructeur annoté) et coûte un lien à `T-68` (`slice` provisoire).

### Ce que la ratification débloque ou ferme

Ferme la ligne `slice` d'`ANOM-17` ; allège la table de couverture. Aucune porte seule.

### Verdict recommandé

**Ratifier** (voie B), avec la correction du défaut 1.

### Correction minimale proposée (non appliquée)

`SemantiqueOperationnelle.lean:254-256`, remplacer « et elle n'apparaît que par la réduction d'une découpe » par : « et elle n'apparaît que par la réduction d'une découpe ou par l'élimination de l'arène, dont ce document ne donne pas la règle (§`sec:g-regles`) ». **Texte conjectural** : à confirmer par l'auteur ; la seconde mention suit `ReglesDeTypage.lean:1268-1271`.

## `∥` et `vmap` : fourche et jointure (voie B, étape vers la C)

### Ce qui a été appliqué

* Séance 31 (commit `fab136a`), `SemantiqueOperationnelle.lean:218-224, 234-237, 252-253, 261-262` : `⟨c₁ ∥ c₂ | μ | τ⟩ → ⟨return (v₁,v₂) | μ₁ ⊎ μ₂ | τ·(π(τ₁) ∥ π(τ₂))⟩` si les branches se réduisent, chacune depuis la trace vide, en une valeur ; même schéma, sur `n` branches, pour `vmap`.
* Avis de l'instruction : « C (entrelacement avec traces par branche) ; B comme étape ». **L'étude comparative n'a pas fait de choix** ; son avis : réparer la fourche-jointure, puis la trace structurée `V3`, l'entrelacement plus tard.
* Énoncé de `thm:determinisme_parallele` corrigé : « le second majore le premier » (`ReglesDeTypage.lean:1343-1357`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.**

* La profondeur est conservée : `⟨w₁+w₂, max(s₁,s₂)⟩`, ce que le dépliage en séquence aurait perdu (`ReglesDeTypage.lean:1287-1291`). La loi d'échange `(a·b) ∥ (c·d) ⊑ (a∥c)·(b∥d)` tient sur le couple `⟨w, s⟩` (refait à la main : `max(x+y, z+t) ≤ max(x,z) + max(y,t)`, les travaux étant identiques).
* L'énoncé corrigé de `thm:determinisme_parallele` est juste (`max(s₁,s₂) ≤ s₁+s₂`, le second majore).
* Le texte dit lui-même que la fourche-jointure « n'est pas la plus fidèle » et que l'entrelacement la prolongerait.

**Défauts relevés.**

1. **La prémisse mêle grand pas et petits pas** (`→*` dans une règle de pas) : annoncé dans le texte, c'est le coût connu de la voie B.
2. **Le schéma écrit `μ₁ ⊎ μ₂`** pour « l'arène `μ` mise à jour des deux » (`:252-254`), alors que la prémisse donne `μ_i` comme l'arène **résultante** de la branche `i` (`⟨c_i | μ | ∅⟩ →* ⟨return v_i | μ_i | τ_i⟩`). Si `μ_i` est l'arène complète, `μ₁ ⊎ μ₂` duplique la part commune `μ` ; le texte ne définit pas `⊎` sur des arènes qui partagent un état initial. Il faut dire que `μ_i` désigne la restriction au support écrit par la branche (ce que « les deux écritures ont des supports disjoints » suggère) ou définir `μ₁ ⊎ μ₂` comme la fusion de deux mises à jour d'un même `μ`.
3. **`vmap` répète `μ` en entrée de chaque branche** : même remarque.
4. **Le schéma n'est défini que sur les configurations de couche 3** (trois composantes `⟨c | μ | τ⟩`) ; un `∥` dans un contexte de couche 2 passe par `Loc`, ce qui est cohérent mais n'est pas dit pour les branches qui contiendraient `spawn` (interdit en couche 3 : `ℰ = ∅`).
5. **La préservation de ces schémas n'est pas démontrée en détail** (`:448-455`) et demande une monotonie de `∥` « que ce document n'énonce pas ». Elle est vérifiable : `∥` est monotone sur le couple `⟨w, s⟩` (somme et maximum sont monotones). À écrire.

### Alternatives écartées et pourquoi

Voir l'étude comparative (variantes `V0` à `V5`). Résumé : A (déplier en séquence) majore la profondeur, ce que la préservation interdit ; C (entrelacement avec trace par branche) est la plus fidèle, étend la machinerie de la couche 2 à la couche 3, rend l'ordre partiel nécessaire dès le fragment cartésien.

### Risque si on ratifie

Faible tant que la ratification est celle de **la fourche-jointure comme état provisoire**, que le texte dit lui-même provisoire. Le risque est de fermer la ligne alors que l'étude recommande d'aller vers `V3` ; la fermeture n'est pas une réponse à la question `∥` de la liste « attendent ».

### Risque si on refuse

Moyen : refuser B laisse `∥` et `vmap` sans schéma, donc le progrès et la préservation ne peuvent pas couvrir deux constructeurs de la couche 3 ; la voie A fait perdre la profondeur annoncée.

### Ce que la ratification débloque ou ferme

Ferme la ligne `∥`/`vmap` de `DECISIONS.md` (« à ratifier ») mais **pas** la question « fourche-jointure ou entrelacement ? » de la liste « attendent » ; ordre conseillé par les études : décider `∥` avant `spawn`.

### Verdict recommandé

**Ratifier la voie B comme étape**, avec précision du défaut 2 ; maintenir ouverte la question de la voie C.

### Correction minimale proposée (non appliquée)

`SemantiqueOperationnelle.lean:252-254`, remplacer « Les deux écritures `μ₁` et `μ₂` ont des supports disjoints, ce que l'addition des contextes de `Par` garantit par la linéarité des capacités d'écriture, de sorte que `μ₁ ⊎ μ₂` est l'arène `μ` mise à jour des deux » par :

> Dans la prémisse, `μ_i` est l'arène que la branche `i` rend ; seule la part qu'elle écrit la distingue de `μ`, et les deux parts écrites ont des supports disjoints, ce que l'addition des contextes de `Par` garantit par la linéarité des capacités d'écriture, de sorte que `μ₁ ⊎ μ₂` (la fusion de ces deux mises à jour de `μ`) est l'arène `μ` mise à jour des deux.

## `guard` à motif conjonctif (voie A)

### Ce qui a été appliqué

* Séance 31, `GrammaireDesTermes.lean` (motifs `p ::= m(x̄) | p & p`), `SemantiqueOperationnelle.lean:239-241, 257-258, 453` : motifs conjonctifs `m₁(x̄₁) & … & mᵣ(x̄ᵣ)` ; `k = 1` redonne la garde à un message ; le schéma consomme les `r` messages d'un coup ; le choix du message suit la structure de la boîte (ordre fixe des émetteurs, `IMPL-04`).
* Source : instruction (`guard` : « A (la jonction est le motif du chapitre 4) »).

### Relecture critique face au manuscrit actuel

**Ce qui tient.** La règle correspond à `thm:sync_motifs_jonction` (la consommation de plusieurs messages est une forme de `Guard`) : le défaut relevé à la séance 29 (la règle consomme un message, le théorème en consomme deux) est levé.

**Défauts relevés.**

1. **Deux règles pour la même construction** : `eq:reductions-couche2` (garde à un message, `:181-183`) et `eq:reductions-orientees` (garde conjonctive, `:239-241`) ; la seconde généralise la première (`r = 1`). La table `tab:couverture-reductions` les range en deux lignes (« écrit » ; « écrit, à ratifier »). Les deux règles coexistent donc ; si la garde à un message est le cas `r = 1`, la première ligne est redondante, et si les deux restent, le lecteur ne sait pas laquelle fait foi.
2. **Contradiction de texte au §4.7** sur le choix du message : voir `ratifications-numerique-et-execution.md` (`IMPL-04`, défaut 1) : `:214-216` dit que le choix n'est pas fixé, `:257-258` qu'il l'est.
3. **Motifs disjoints** : le postulat P4 dit que les motifs doivent être « deux à deux disjoints en plus d'être exhaustifs » pour supprimer le non-déterminisme du déclenchement (`Postulats.lean:194-197`) ; avec des motifs conjonctifs, deux motifs `x` et `x & y` ne sont pas disjoints au sens usuel (un `{x, y}` en boîte les satisfait tous deux). Le texte ne dit pas ce que « disjoints » veut dire pour des conjonctions : par conséquent la phrase « un choix forcé, donc pas un choix » demande à être précisée avant de s'appliquer à la garde conjonctive.

### Alternatives écartées et pourquoi

Voie B (`Guard` à un message, jonction dérivée) : perd l'atomicité que le théorème revendique.

### Risque si on ratifie

Faible, sous réserve des défauts 1 et 2 (rédaction).

### Risque si on refuse

Moyen : `thm:sync_motifs_jonction` retombe sur « opération native de `Guard` » alors que `Guard` n'a pas de produit, ce que la séance 29 avait relevé.

### Ce que la ratification débloque ou ferme

Ferme la ligne `guard` ; dépend d'`IMPL-04` pour le choix du message.

### Verdict recommandé

**Ratifier**, avec correction de la contradiction du §4.7 (déjà proposée à `IMPL-04`) et une phrase sur la disjonction des motifs conjonctifs.

### Correction minimale proposée (non appliquée)

`Postulats.lean:194-197`, après « deux à deux disjoints en plus d'être exhaustifs », ajouter : « — la disjonction s'entendant des motifs comme ensembles de canaux consommés d'un coup : deux motifs dont l'un contient l'autre se départagent par la clause la plus longue, ou ne sont pas admis » **(choix de modèle de l'auteur : la règle de départage n'est pas écrite ; je n'ai pas de recommandation de fond)**.

## Défaillance de `try` (voie A)

### Ce qui a été appliqué

* Séance 31, `SemantiqueOperationnelle.lean:242, 259-260` : `⟨try c catch h | μ | τ⟩ → ⟨h | μ | τ·fail⟩` ; un pas de l'environnement, sans retour en arrière ; la défaillance « peut survenir à tout moment avant la fin du corps » et « ne rend pas l'arène : le grade affine autorise l'abandon ».
* Source : instruction (« A : machine unique, la défaillance est un pas non déterministe sans retour en arrière »).

### Relecture critique face au manuscrit actuel

**Ce qui tient.** La lecture « défaillance = pas de l'environnement » est la lecture du texte (« la défaillance ne se type pas ») ; la préservation se ramène à l'affaiblissement par la jointure, comme pour la réussite (`:445-448`).

**Défauts relevés.**

1. **Le schéma n'a pas de condition de non-terminalité du corps.** La règle s'applique à tout `c`, y compris un `c` terminal (`return v`) ; alors `try (return v) catch h` peut, au choix, réussir (règle `try t catch h → t`, `:136`) ou défaillir (`→ h` avec `fail`) **après** la fin du corps. Le texte dit que la défaillance survient « avant la fin du corps » : la règle ne l'écrit pas. Le non-déterminisme est donc plus large que celui décrit.
2. **L'état laissé par `c`** (« ne défait pas ce que le corps avait écrit ») est cohérent avec « sans retour en arrière », mais les ressources que `c` détenait sont abandonnées (grade affine) ; en couche 1 (linéaire) la défaillance abandonnerait une ressource linéaire : le texte renvoie à la couche 2 sans écarter la couche 1.
3. **`τ·fail`** : l'effet `fail` s'inscrit dans la trace ; la préservation demande `τ·fail·ε' ⊑ τ·(ε ⊔ ε' ⊔ fail)`, ce qui demande que `ε ⊔ ε' ⊔ fail` soit l'effet de la conclusion ; voir la règle `Try` (`g-couche1`) ; non relue ici.

### Alternatives écartées et pourquoi

Voie B (configuration indexée par lieu, la défaillance détruit les fibrilles d'un lieu) : plus fidèle à « l'hypothèse d'environnement gagne une composante réseau », mais demande de décider si `μ` est par lieu ; écartée tant que la couche 1 n'est pas formalisée pour elle-même.

### Risque si on ratifie

Faible, sous réserve de la condition de non-terminalité.

### Risque si on refuse

Faible à moyen : `try` à corps non terminal n'aurait pas de schéma de défaillance ; le progrès ne couvrirait pas la défaillance.

### Ce que la ratification débloque ou ferme

Ferme la ligne `try`. Aucune porte.

### Verdict recommandé

**Ratifier avec correction** (défaut 1).

### Correction minimale proposée (non appliquée)

`SemantiqueOperationnelle.lean:242`, ajouter à la règle la condition `c` non terminal :

> `⟨try c catch h | μ | τ⟩ → ⟨h | μ | τ·fail⟩`, `c` non terminal

## `spawn` : comptabilité du travail, voie A (déjà écrite)

### Ce qui a été appliqué

* Séance 29/31 (rien à changer au texte) : `Spawn` annonce `⟨spawn, ⟨w(ε), 0⟩⟩` à la mère (la provision du travail de la fille) ; la fille inscrit ensuite ses propres événements ; le total est « le maximum par chaîne » (`SemantiqueOperationnelle.lean:171-174`).
* Source : instruction (`spawn`, comptabilité : voie A, déjà écrite ; B : la fille consomme la provision).
* Le fil de temps de la fibrille engendrée est une question à part, en attente (étude `spawn`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.** La profondeur de la provision est nulle (`⟨w, 0⟩`) ; la profondeur d'une chaîne n'est donc pas comptée deux fois.

**Défauts relevés.**

1. **Le travail est compté deux fois sur la chaîne de la fille, et l'inégalité de préservation en pâtit** (calcul à la main, confiance moyenne). Avant le pas, le potentiel de la chaîne qui contient le `spawn` est `τ·⟨spawn, ⟨w, 0⟩⟩`. Après le pas, la fille `q` reprend « après `ε_spawn` » (`:173`) avec l'annotation `ε` de `c` : le potentiel de la chaîne qui traverse `q` est `τ·⟨spawn,⟨w,0⟩⟩·ε`, dont la composante travail est `w + w`, au lieu de `w`. L'inégalité `τ'·ε' ⊑ τ·ε` y échouerait de `w` sur la composante travail. Le texte dit que « la borne de chaque chaîne reste correcte » (borne sûre) ; mais la préservation demande la **non-croissance**, non la seule sûreté. À moins de lire le potentiel initial de `q` comme déjà payé, c'est la voie B (la fille consomme la provision) qui satisfait `⊑`. **Non vérifié par l'auteur ; la préservation de `spawn` n'est de toute façon pas démontrée** (`:439-441`).
2. **« Le total est le maximum par chaîne »** est vrai de la profondeur ; pour le travail, la composition parallèle **additionne** (`⟨w₁+w₂, max(s₁,s₂)⟩`, `eq:cout-parallele`) : le total du travail d'une configuration à plusieurs chaînes est la somme et non le maximum. La phrase de l'instruction confond les deux composantes.

### Alternatives écartées et pourquoi

Voie B : la fille consomme la provision, un événement par pas de la fille, aucun à la mère ; évite le double comptage mais décale le travail de la mère à la fille dans la trace.

### Risque si on ratifie

**Moyen** : on fige une comptabilité dont l'inégalité de préservation, sur la composante travail, semble fausse sur la chaîne de la fille (défaut 1). L'erreur ne se verra qu'en conduisant la préservation de `Spawn`.

### Risque si on refuse

Faible : on adopte la voie B, avec un schéma de réduction à ajuster (l'événement de provision disparaît de la mère).

### Ce que la ratification débloque ou ferme

Ferme la ligne `spawn` (comptabilité) ; **ne ferme pas** la question du fil de temps (étude `spawn`, en attente). Dépend, pour la clause de traduction du fil, de cette question.

### Verdict recommandé

**Ne pas ratifier la voie A telle quelle ; recommander de vérifier d'abord le défaut 1.** Si le calcul est confirmé, ratifier la voie B. Si l'auteur préfère la voie A, ajouter l'hypothèse que le potentiel de `q` est lu net de la provision.

### Correction minimale proposée (non appliquée)

Si voie B : `SemantiqueOperationnelle.lean:172-174`, remplacer l'événement de la mère `⟨spawn, ⟨w(ε), 0⟩⟩` par `⟨spawn, ⟨0, 0⟩⟩` et noter que la provision de travail de la fille figure dans le seul potentiel de `q` (annotation `ε`). **Texte conjectural : le type de `Spawn` (§`g-couche2`) devrait alors donner `ε` à la mère et non `w(ε)`, ce que je n'ai pas relu.**

## Points de forme : formes terminales, sous-typage des tailles, copatron

### Ce qui a été appliqué

* Formes terminales : `thm:progres` liste `Λα.c`, le copatron, `delay c₀` (`SemantiqueOperationnelle.lean:485-487`) ; `try` à corps terminal.
* Sous-typage des tailles : `νC⟨j⟩ <: νC⟨i⟩` pour `i ≤ j` (`ReglesDeTypage.lean:1162-1165`).
* Énoncé de `thm:determinisme_parallele` corrigé.
* Copatron : la liaison implicite est un thunk (`x :₁ U_ε(να.C⟨i⟩)`), employée par `force x` ; schéma `out ⟨⟨j ↦ c_j⟩⟩ → ⟨c_j[thunk ⟨⟨…⟩⟩/x]⟩` (`:135`).

### Relecture critique face au manuscrit actuel

**Ce qui tient.** La liste des formes terminales est maintenant cohérente avec la grammaire (`λ`, `Λ`, `⟨c_i⟩`, copatron, `return`, `delay`) ; le thunk résout le lemme de substitution (valeur) sans lemme de plus ; le sous-typage des tailles comble l'écart entre `i` et `i+1` ; `ω + 1 = ω` donne le comportement des flux infinis.

**Défauts relevés.**

1. **Le lemme des formes canoniques** n'est pas mis à jour (S2) : il manque les vecteurs, `κ`, `ι`.
2. **`⊥_S`** n'a pas de terme dans la grammaire des valeurs ; la traduction le note `⟦⊥⟧` ; le schéma `fix` en dépend (`:132-134`) ; **la prose du §2.4 (ensembles finis) et les clauses de `eq:trellis-fin` (types de base de porteur fini, produit, vecteur, somme) ne disent pas la même chose du plus petit élément** (voir `ratifications-grades-et-cadre.md`, `FACT-14`). La préservation du dépliage `fix` suppose ce terme typable (`:429`).
3. **`thm:terminaison_lfp`** dit que le grade d'effet de `fix f` est « une fonction de l'indice que porte `S` » (`AdjonctionsEtEnrichissement.lean:387`) ; la règle `Fix` écrit `ℰ = ∅` (`:357`) ; le schéma n'émet aucun événement (suit la règle). Tension laissée par la séance 32, non fermée.

### Alternatives, risques, verdict

* Alternatives : lemme pour les variables de calcul (au lieu du thunk) ; écartée, plus lourde.
* Risque si on ratifie : faible (retouches de forme) ; risque si on refuse : faible.
* **Verdict : ratifier** ; les défauts 1 et 3 sont des points de cohérence (l'un trouve sa place dans la correction de `thm:progres`, l'autre est une anomalie voisine à traiter à part, pas une condition).

### Correction minimale proposée (non appliquée)

`SemantiqueOperationnelle.lean:502-506` (lemme des formes canoniques), ajouter : « un littéral `[v₀,…,vₙ₋₁]` au type `Vec n V`, un jeton `κ` au type `Cap ρ`, une localisation `ι` au type `Mb E` ». (Ces trois formes sont des valeurs de l'exécution ou de la grammaire que la liste omet.)

## Grammaires et six schémas des modalités (séance 32 §A.3)

### Ce qui a été appliqué

* Commit `819c6de` : `always`, `now`, `next`, `loc_n` rangés parmi les valeurs ; `at`, `wait`, `declassify_ℓ` calculs de type `F_𝟏 V` ; `delay` calcul ; types `□V`, `◇V`, `○V` (valeurs) et `○C` (calculs) productions ; `◇C`, `@_nC`, `!_ℓ A` abréviations (`GrammaireDesTypes.lean:77-100`) ; règles `Alw⁻`, `Wait` retypées, `Nxt`, `Loc`, `Declassify` ajoutées ; six schémas (`eq:reductions-modalites`) ; lecture séquentielle (l'horloge vit dans la trace et la traduction) et machine unique. Le croisement mécanique passe de 50 à 53 règles et de 46 à 49 constructeurs.
* Décision de l'auteur : « Les grammaires sont à définir. » La voie retenue pour `declassify` n'est pas l'étiquette (voie B de l'orientation) mais la boîte rendue au niveau abaissé.
* À ratifier (DECISIONS) : « le choix de lire les modalités comme l'identité de la relation (le temps vit dans la trace) ; `declassify` rendant une boîte au niveau abaissé plutôt qu'une étiquette ».

### Relecture critique face au manuscrit actuel

**Ce qui tient (vérifié en lisant les règles).**

* Les schémas sont bien typés : `at (always w) → return w` (`Alw⁻` : `□V ⊢ at v : F_𝟏 V`) ; `wait (next u) → return u` avec `next u : ○◇V` donc `u : ◇V` et `wait v : F_𝟏 ◇V` ; `when x = now w in c → c[w/x]` avec `now w : ◇V` ; `declassify_ℓ'(box_r w) → return (box_{r[ℓ']} w)` conclut exactement `F_𝟏(!_{r[ℓ']}V)` ; `at_n (return w) → return (loc_n w)` conclut `F_{@_nε}(@_nV)` par `Loc`/`At`.
* Les quatre clauses qui engendrent `Trellis_fin` et les trois abréviations sont posées par un prédicat, ce qu'une induction demande.
* Le choix de lecture séquentielle est cohérent avec le texte : « la durée d'attente n'est pas un pas de la relation, c'est la traduction qui la compte ».

**Défauts relevés.**

1. **La règle `Declassify` teste `v ∈ 𝒳` pour une valeur `v`, alors que 𝒳 est un ensemble d'_expressions_.** Le texte dit que `𝒳` est « un ensemble fini d'expressions — les échappatoires » (`AdjonctionsEtEnrichissement.lean:209`), « closes et évaluées dans l'état initial » (`:211-212`), puis en conclut qu'elles sont « des valeurs closes » (`:229-230`) pour que l'argument de `declassify` soit une valeur. Or une échappatoire utile dépend de l'**état initial** (la somme d'une colonne, le rang d'un enchérisseur, `:206-207`) ; une valeur **close** de la grammaire (littéral) n'en dépend pas, et `fv(v) = ∅` (prémisse) interdit à `v` de porter une variable secrète. Telle que rédigée, la déclassification ne s'applique qu'à des constantes ; la liaison entre « l'expression de 𝒳 évaluée dans l'état initial » et « la valeur argument de `declassify` » n'est écrite nulle part. La séance 32 a relevé que la règle donnait un type valeur à partir d'une expression ; le correctif (argument = valeur) déplace la difficulté sans la lever. **À trancher par l'auteur : 𝒳 est-il un ensemble de valeurs (alors l'énoncé « une échappatoire ne libère que ce qu'elle nomme » porte sur des constantes) ou d'expressions, auquel cas l'argument de `declassify` n'est pas une valeur ?**
2. **`declassify` : « préservation graduée fausse en l'état ».** Le schéma conclut exactement le type de la règle ; l'écart annoncé tient à la dérivation du contractum dans un contexte aux niveaux abaissés (`:466-470`). Avec `v` close (`fv(v) = ∅`), le contexte de la boîte est nul, donc le même dans le rédex et le contractum ; je ne vois pas, sur ces règles, de cas où la préservation du **type** échoue. L'écart est de **niveau** (`niv`), non de typage. Le texte dit « fausse en l'état » : à préciser (quelle composante du jugement change : le niveau du résultat, non le contexte).
3. **`move_{n→m}` : `⟨c, c⟩`.** Le coût de l'événement réseau est écrit `⟨c, c⟩` (`:279, 297`) avec le même symbole `c` que le calcul ; le texte n'introduit pas de constante de coût du transfert. Notation à lever.
4. **`wait`** : la préservation n'est vraie qu'« au contexte avancé près » (S1) : l'énoncé de `thm:preservation` ne le dit pas.
5. **Le facteur temporel** : trois formes (`ANOM-18`, ouverte) : `thm:temps_mononiveau` parle d'isomorphisme avec `ℰ₀ × ℕ∞` alors que la grammaire donne `(ℕ∞ × ℕ∞)^ℒ` (travail, profondeur).

### Alternatives écartées et pourquoi

| Choix | Alternative écartée |
|---|---|
| lecture séquentielle (le temps vit dans la trace) | B : une horloge dans la configuration ; plus fidèle aux bornes de `◇`, ajoute un composant à toutes les configurations |
| machine unique (lieux = étiquettes de type) | B : configuration indexée par lieu |
| `declassify` rend une boîte au niveau abaissé | B de l'orientation : une forme de valeur étiquetée `declass_ℓ'(w)` (forme de valeur de plus) ; C : opération à effet (contredit la règle donnée sans effet) |
| introductions temporelles en valeurs | corriger les règles plutôt que la grammaire (retyper) ou renvoyer au métalangage (voie C) |

### Risque si on ratifie

**Moyen** : les grammaires sont cohérentes et les schémas bien typés, mais la ratification de `declassify` engage la lecture de 𝒳 (défaut 1), qui détermine si la déclassification est utilisable ; la lecture séquentielle fait de la durée d'attente un objet de la traduction seule, donc hors de ce que `→` énonce.

### Risque si on refuse

Moyen : revenir à l'état antérieur laisse `at`, `wait`, `when` sans valeur close à consommer (défaut de grammaire démontré par la séance 29) et `declassify` sans contractum typable.

### Ce que la ratification débloque ou ferme

Ferme les lignes « grammaires » d'`ANOM-17` ; débloque la clause de traduction des six formes (`PREUVE-07`, `BLOQ-07`) ; conditionne `PREUVE-04` (le lemme fondamental sur `Declassify`). Aucune porte seule ; contribue à P5 (dernière anomalie ouverte du manuscrit avec `ANOM-18`).

### Verdict recommandé

**Ratifier les grammaires et les schémas purs (`at`, `wait`, `when`, `at_n`) ; ratifier `declassify` avec une question à l'auteur** (défaut 1). Les autres défauts sont des retouches.

### Correction minimale proposée (non appliquée)

* Défaut 1 : si 𝒳 est un ensemble de **valeurs** (choix le plus proche de la règle écrite) : `AdjonctionsEtEnrichissement.lean:209`, « Une déclaration fixe un ensemble fini 𝒳 d'expressions » devient « … un ensemble fini 𝒳 de valeurs closes, chacune obtenue par l'évaluation d'une expression de la déclaration dans l'état initial » **(texte conjectural : cela suppose que l'évaluation dans l'état initial a lieu avant la compilation de la règle, ce que l'auteur doit dire)**.
* Défaut 2 : `SemantiqueOperationnelle.lean:466-470`, remplacer « _c'est le seul cas où la préservation graduée est fausse en l'état, et elle doit l'être_ » par « c'est le seul cas où le niveau de la conclusion diffère de celui du sujet, et il le doit : … » (**formulation à confirmer**).
* Défaut 3 : `SemantiqueOperationnelle.lean:279, 297`, remplacer `⟨c, c⟩` par `⟨c_{\mathrm{net}}, c_{\mathrm{net}}⟩` (et définir la constante).

## `PREUVE-04` et `TRANS-06` (séance 32 §A.5)

### Ce qui a été appliqué

* `PREUVE-04` (partielle, 80 %) : la clôture des échappatoires est imposée par la prémisse `fv(v) = ∅` de `Declassify` ; le croquis et la phrase du §4.7 mis à jour ; le sceau reste « proposition » (`thm:divulgation_delimitee`).
* `TRANS-06` (fermée) : six conditions découvertes aux annexes, toutes remontées aux ch. 1 à 3 (tableau de complétude au journal 32).

### Relecture critique face au manuscrit actuel

* **`TRANS-06` : les six lignes sont présentes** (vérifié) : (1) `Declassify`, `fv(v) = ∅` ; (2) clause de niveau sur `Op`/`Case`/`Tick` (règle `Case` : `niv(Δ₁) ⊑ ℓ̂(ε)`, `ReglesDeTypage.lean:205`) ; (3) lecture par borne (P3, `Postulats.lean:134-137`) ; (4) inversion de sédimentation sur deux axes (`ReglesDeTypage.lean:887-892`) ; (5) la phrase du ch. 1 (`AxiomatiqueGerminale.lean:483`) ; (6) `tab:produit-mixte`. **Sauf** que la ligne 5 dit « famille de coûts temporels indexée par les niveaux » sans la forme complète, et `ANOM-18` reste ouverte (aucune des trois formes n'est choisie).
* **`PREUVE-04` : la prémisse existe, mais voir défaut 1 ci-dessus** : `fv(v) = ∅` ferme la substitution, au prix de rendre l'argument constant (question à l'auteur). Le lemme fondamental reste à conduire sur tous les cas ; `depend = PREUVE-05`.

### Risque, verdict

* Aucun risque nouveau à ratifier la clôture par la règle (elle est écrite) ; **ratifier** `TRANS-06` (déjà fermée) et laisser `PREUVE-04` partielle tant que la question 𝒳 n'est pas tranchée.

## `ANOM-09` et `ANOM-10` : index à pages, interface en français

### Ce qui a été appliqué

* Séance 32 §A.4 (décision de l'auteur : « Ok alors rédige ANOM-09 et ANOM-10 »). `ANOM-09` : `tools/SpecExt/Index.lean`, `IndexCore.lean`, `IndexTerms.lean` (31 termes), `AutoMark.lean` (passe sur l'arbre, première occurrence de chaque chapitre avec infobulle) ; en TeX, étiquette à chaque occurrence, macros du préambule `\specidxpage` et `\specidxentry` (paquet `refcount`, chargé par `hyperref`), sans `makeindex` ; en HTML, chaque terme renvoie aux sections. `ANOM-10` : `tools/SpecExt/Translate.lean`, remplacements exacts sur les pages et les scripts de recherche, appliqués après la génération. Tests : `tests/SpecToolsTest.lean` (13 tests, dans `lake test`).
* Niveau de vérification donné par le journal : `lake build`, `lake test`, `lake lint`, `reuse lint` verts ; PDF compilé avec `lualatex` (deux passes, 305 pages, page d'index contrôlée) ; **`tectonic`, moteur de la CI, non installé : compilation non vue**.
* À ratifier (DECISIONS) : le choix de la voie (ni `makeindex` ni contribution à Verso) ; le PDF compilé avec `lualatex` et pas encore avec `tectonic`.

### Relecture critique face au dépôt actuel

**Ce qui tient.** Les fichiers existent (`tools/SpecExt/` contient `Index.lean`, `IndexCore.lean`, `IndexTerms.lean`, `AutoMark.lean`, `Translate.lean`) ; `Setup.lean` charge `refcount` et définit `\specidxpage` (lignes 32-48) ; `scripts/controles/indexation.py` déclare `KNOWN_ABSENT = {"analyse de coût"}` ; la CI (`.github/workflows/verify.yaml:298`) compile avec `tectonic -X compile --keep-logs -Z deterministic-mode main.tex`. Le choix de macros LaTeX de base est cohérent avec ce que `tectonic` accepte.

**Défauts relevés.**

1. **Le comportement sous `tectonic` n'est pas vu** : le risque que le PDF de la CI n'imprime pas les pages (ou imprime des `??`) au premier passage n'est pas écarté ; `-Z deterministic-mode` ne change pas le nombre de passes, mais je n'ai pas lancé `tectonic` ici. **Je ne peux pas non plus lancer `lualatex` utilement sans construire le document** (non fait).
2. **« analyse de coût » est dans les trente et un termes et n'est écrit nulle part** : l'auteur doit l'écrire ou le retirer (déclaré dans `KNOWN_ABSENT`).
3. **Reconnaissance automatique** : la règle « frontières de mots, casse et accents indifférents, pluriel en `s` ou `x` » peut marquer des occurrences dans des citations ou des titres ; le journal dit que code, formules, liens et listes de termes sont exclus ; je n'ai pas relu le rendu pour le vérifier.
4. **Interface en français** : le journal reconnaît que toute chaîne future de Verso reste en anglais ; une montée de version de Verso peut en ajouter.

### Alternatives écartées et pourquoi

Une sortie TeX par `\index`/`makeindex` (programme externe, la CI compile avec `tectonic`) ; une contribution à Verso (hors périmètre) ; rester à une liste (régression par rapport au PDF d'origine).

### Risque si on ratifie

Faible pour le dépôt (outillage, hors manuscrit) ; moyen pour la release : si `tectonic` ne résout pas les références à deux passes, l'index du PDF archivé sur Zenodo serait faux. À lever par **une exécution de la CI** avant P6.

### Risque si on refuse

Faible : revenir à la liste sans pages.

### Ce que la ratification débloque ou ferme

Ferme `ANOM-09` et `ANOM-10` (déjà ✅ au suivi) ; contribue à P5 (anomalies). Dépendance de fait pour P6 : un PDF compilé par `tectonic`.

### Verdict recommandé

**Ratifier la voie** (macros TeX sans `makeindex`, feuille de traduction) **sous condition d'une exécution de la CI avec `tectonic`** avant la release ; écrire ou retirer « analyse de coût ».

### Correction minimale proposée (non appliquée)

Aucune dans le manuscrit. Dans le suivi : consigner à `DECISIONS.md`, ligne `ANOM-09`/`ANOM-10`, « à confirmer par la CI avec `tectonic` ».

## `D-7` : annexes B, C, D

### Ce qui a été appliqué

* Commit `d84021f` de l'auteur (6 octobre 2026, « chore(tooling): extract BCD prototypes ») : `spec/Spec/AnnexeB.lean`, `AnnexeC.lean`, `AnnexeD.lean` retirés de la spécification (87 + 40 + 52 lignes) et déplacés sous `tooling/prototypes-bcd/` ; `spec/Spec.lean` retire les trois inclusions. `ANOM-04` est close ; le bandeau « esquisse » de la séance 31 n'a plus d'objet. `DECISIONS.md` range déjà `D-7` ✅ « tranchée » dans « À ratifier ».

### Relecture critique

**Vérifié.** Aucune référence `annexe B/C/D` ne subsiste dans `spec/Spec` (grep) ; seules les étiquettes de l'annexe A existent ; `PORT-11`/`REECR-25`, qui citaient l'annexe D, sont traitées ailleurs (voir `ratifications-effets-et-fermetures.md`). Un reste : `.claude/skills/writing-rules.md`, tableau de structure, ligne `spec/Spec/<Ch>.lean`, cite encore « `AnnexeA`…`AnnexeD` ».

### Verdict recommandé

**Il n'y a rien à ratifier** : la décision a été prise et exécutée par l'auteur. La ligne peut être retirée du tableau « À ratifier » (elle y figure par inertie). Retouche hors périmètre : corriger la mention « `AnnexeA`…`AnnexeD` » de `writing-rules.md`.

## Les deux changements de sceau proposés (non appliqués)

`DECISIONS.md` propose de passer `thm:progres` et `thm:preservation` de « théorème » à « proposition ». Les constats S1 à S3 le soutiennent.

| Énoncé | Verdict | Pourquoi | Ce qu'il faut en plus |
|---|---|---|---|
| `thm:preservation` | **Accepter le passage à « proposition »**, ou `S3` (théorème restreint) ; **dans les deux cas réécrire l'énoncé** | l'énoncé est faux tel qu'écrit pour `wait`, `move`, `declassify` (S1) ; les cas de couche 2 et orientés ne sont pas démontrés | **amender aussi l'énoncé** : « … pour tout schéma de `eq:reductions-pures`, `eq:reductions-effets` ; pour `wait`, `move` et `declassify`, la préservation s'entend au contexte avancé, au contexte de grades nuls, à l'abaissement du niveau près » ; et corriger les trois phrases qui disent « démontrée » (S3) |
| `thm:progres` | **Accepter le passage à « proposition »** | la preuve ne couvre qu'une partie des constructeurs, deux hypothèses de module, formes canoniques incomplètes (S2) | compléter le lemme des formes canoniques ; déplacer les deux hypothèses de module dans l'énoncé |

**Avis voisin.** Le dossier [`05-sceaux-progres-preservation.md`](05-sceaux-progres-preservation.md) (agent « conception ») recommande `S3` : **restreindre chaque énoncé à son périmètre démontré et garder « théorème »**, le reste allant dans une proposition, et, « dans tous les cas », réécrire les deux énoncés (faux tels qu'écrits). Nos deux analyses convergent sur le point qui ne dépend pas du sceau : **l'énoncé de `thm:preservation` doit être réécrit** (S1). Elles diffèrent sur le sceau : « proposition » (changement proposé par `DECISIONS.md`, le plus simple) ou « théorème sur un périmètre restreint » (`S3`, qui garde la force de ce qui est démontré). Le choix est celui de l'auteur ; je ne vois pas d'objection de fond à `S3` si le périmètre restreint est écrit dans l'énoncé (c'est la correction ci-dessous, sans le changement de sceau).

Conséquences à vérifier avant d'appliquer : les renvois qui disent « théorème `thm:preservation` » en toutes lettres (`StructuresOuvertesEffetsEtMetaTheorie.lean:299, 312`, `C6/CeQueLeSolveurRetourne.lean:416`) ; `thm:correspondance_niveaux` (déjà proposition) s'appuie sur la préservation (`:762`) ; `scripts/controle.py` (propagation) devra être relancé : les énoncés qui citent un énoncé de rang inférieur sans le dire peuvent faire échouer le contrôle.

### Texte proposé (non appliqué)

`thm:preservation`, remplacer l'énoncé de la ligne 381-384 par :

> Si `Δ ⊢ c : C | ε` et `⟨c | μ | τ⟩ → ⟨c' | μ' | τ'⟩` par un schéma des blocs (`eq:reductions-pures`) et (`eq:reductions-effets`), alors il existe `ε'` tel que `Δ ⊢ c' : C | ε'` et `τ'·ε' ⊑ τ·ε`. Pour les schémas ajoutés, la conclusion s'entend avec les réserves de l'esquisse : au contexte avancé près (`wait`), au contexte de grades nuls près (`move`), à l'abaissement du niveau près (`declassify`) ; elle n'est pas démontrée pour la couche 2.

## Récapitulatif

| Élément | Verdict | Condition |
|---|---|---|
| `slice` (voie B) | ratifier | mention de l'élimination de l'arène |
| `∥`, `vmap` (voie B comme étape) | ratifier comme étape | précision de `μ₁ ⊎ μ₂` ; question de la voie C reste ouverte |
| `guard` conjonctif (voie A) | ratifier | corriger la contradiction du §4.7 ; disjonction des motifs |
| défaillance de `try` (voie A) | ratifier avec correction | condition « `c` non terminal » |
| `spawn`, comptabilité (voie A) | **ne pas ratifier telle quelle** | vérifier le double comptage ; sinon voie B |
| points de forme | ratifier | formes canoniques ; `⊥_S`, `thm:terminaison_lfp` à part |
| grammaires, schémas des modalités | ratifier, `declassify` avec une question | statut de 𝒳 (valeur ou expression) |
| `PREUVE-04`, `TRANS-06` | ratifier `TRANS-06` ; `PREUVE-04` reste partielle | question 𝒳 ; `ANOM-18` |
| `ANOM-09`, `ANOM-10` | ratifier la voie | exécution de la CI avec `tectonic` |
| `D-7` | rien à ratifier (tranchée, exécutée) | retirer la ligne |
| sceaux `thm:progres`, `thm:preservation` | accepter le passage à « proposition » | amender l'énoncé de la préservation ; aligner les trois renvois |
