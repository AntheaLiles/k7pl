<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 5 : les sceaux de `thm:progres` et de `thm:preservation`

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Question posée par [`DECISIONS.md`](../../suivi/DECISIONS.md) (« Changements de sceau proposés, non appliqués ») : faut-il passer `thm:progres` et `thm:preservation` de « théorème » à « proposition » ? Ce dossier dit **ce que les preuves couvrent réellement**, **ce qu'il faudrait pour mériter le sceau**, les **conséquences sur les renvois** et sur l'**énoncé de la revendication `ARB-PR-06`**. Il ne tranche rien ; `spec/` n'est pas modifié ; les textes Verso du §7 sont **non appliqués**.

**Niveau de vérification.** Lectures des énoncés, des esquisses et des mentions : faites dans les fichiers cités (lignes). Le contrôle des sceaux et de la propagation (`scripts/controles/notation.py`) est **lu**, non modifié. Les raisonnements sur la vérité des énoncés tels qu'écrits sont de rédacteur, sans vérification par machine ; aucune source externe n'a été relue.

## 1. Question exacte

> Les deux énoncés sont scellés « théorème », alors que leurs esquisses déclarent « non démontrés en détail » une série de cas. Faut-il (S1) les passer en « proposition » ; (S3) restreindre chaque énoncé à son périmètre démontré en gardant le sceau, et porter le reste dans une proposition ; (S4) conduire les cas manquants pour mériter le sceau sur tout le périmètre ; ou (S0) ne rien changer ?

Une sous-question en découle : **que devient l'énoncé de la revendication `ARB-PR-06`** (« préservation graduée de bout en bout »), qui se lit comme la conjonction de la préservation par évaluation (`thm:preservation`) et de la préservation par abaissement (`thm:abaissement_grades`, conjecture) ?

## 2. État du manuscrit

### 2.1 Ce que le manuscrit dit et ce que les sceaux exigent

| Fait | Où (lu) |
|---|---|
| Convention : « Un _théorème_ est démontré ou esquissé, dans un environnement nommé, sa réserve écrite dans l'esquisse » ; règle : « _une réserve qui borne une affirmation réécrit l'affirmation_, elle ne l'annote pas » ; « un changement de statut d'un énoncé se propage à toutes ses mentions … le contrôle de propagation (`scripts/controle.py`) la rend vérifiable » | `spec/Spec/C1/GuideDeLecture.lean:22-39` |
| Le contrôle de sceau exige seulement que « théorème » porte une esquisse ; le contrôle de propagation interdit qu'une **mention d'un énoncé ouvert** (proposition, conjecture, exigence) soit suivie, dans les 90 caractères qui suivent le renvoi et jusqu'au premier point, d'un verbe assertif (`établit`, `démontre`, `garantit`, `prouve`, `assure`, `acquitte`) | `scripts/controles/notation.py:91-130` |
| Introduction de §4.7 : « La préservation et le progrès sont démontrés, le second sous deux hypothèses nommées, **sur les constructeurs que la relation réduit** » ; plus loin « la relation étant écrite pour les constructeurs que le texte détermine (table `tab:couverture-reductions`), elles se démontrent sur ceux-là » | `spec/Spec/C4/SemantiqueOperationnelle.lean:25-29`, 365-370 |
| `thm:preservation` (théorème, 5 renvois entrants) ; `thm:progres` (théorème, **0** renvoi entrant) | `SemantiqueOperationnelle.lean:373`, 477 ; `python3 scripts/manuscript_metrics.py statements` (colonne « Renvois ») |
| L'ensemble : 72 énoncés, 49 théorèmes, 15 propositions, 4 exigences, 2 conjectures, 2 définitions ; **21 ouverts** | `python3 scripts/manuscript_metrics.py summary` |

**Fait structurant** : la phrase « sur les constructeurs que la relation réduit » bornait correctement l'affirmation à l'époque où la relation ne réduisait que les blocs `eq:reductions-pures` et `eq:reductions-effets`. Depuis les séances 29, 31 et 32, **la relation réduit tous les constructeurs** (table `tab:couverture-reductions`) ; la même phrase, inchangée, annonce donc maintenant une preuve sur la totalité, alors que les cas ajoutés « ne sont pas démontrés en détail ». L'esquisse le dit ; l'introduction et le sceau ne le disent plus.

### 2.2 Ce que couvre réellement la preuve

Lecture de l'esquisse de `thm:preservation` (`SemantiqueOperationnelle.lean:385-470`) et de celle de `thm:progres` (`:486-515`), croisée avec la table `tab:couverture-reductions` (`:299-345`).

| Constructeurs | Schéma | Préservation | Progrès |
|---|---|---|---|
| éliminations pures, `iter` (16 schémas de `eq:reductions-pures`) | écrit | **démontrée (esquisse uniforme)** : rédex = introduction sous élimination, lemme de substitution ; `Unbox`, `Open` détaillés | couverte : forme canonique, schéma |
| `operation`, `tick`, `scoped` (2 règles), congruence | écrit | **démontrée (esquisse)** : potentiel transféré ; inégalité stricte pour l'opération à portée ; monotonie du produit de la quantale | couverte (avance inconditionnellement sous totalité de `⟦operation⟧`) |
| `fix`, copatron (`out`) | écrit (`eq:reductions-pures-suite`) | dérivée, **sous hypothèse** : `⊥_S` terme typable « que le chapitre 2 pose sans l'écrire » ; copatron par `Th`, `Sub`, lemme (thunk) | « se déplie toujours » |
| `try` (réussite et défaillance) | écrit | **conditionnelle** : exige l'affaiblissement par la jointure, soit `thm:coherence_subsomption` (**proposition ouverte**, 6 renvois entrants) | non conduite |
| couche 2 : `spawn`, `new`, `send`, `guard`, `free`, `Loc` | écrit (`eq:reductions-couche2`) | **non démontrée** : « demandent de typer les configurations … ce que ce document n'écrit pas » | forme globale sur le pool, renvoi à l'acyclicité du graphe (ch. 3) ; cas non conduits |
| `slice` | écrit | démontrée (substitution) | « se lit comme les autres » |
| `∥`, `vmap` | écrit (fourche-jointure) | **non démontrée en détail** : monotonie de `∥` « que ce document n'énonce pas » ; dépend des suites de pas des branches | non conduite ; voir dossier 1 (trou 2, branches terminantes) |
| `guard` à motif conjonctif | écrit | **non démontrée** (typage des configurations) | non conduite |
| `at/always`, `when/now`, `at_n/return` | écrit (`eq:reductions-modalites`) | **exacte** (dérivation indiquée) | « se lit comme les autres » |
| `wait/next`, `move` | écrit | **demande un lemme** non écrit : contexte avancé d'un pas (`wait`) ; contexte d'une valeur `Ser` de grades nuls (`move`) | non conduite |
| `declassify` | écrit | **fausse en l'état, et elle doit l'être** : le contractum se dérive à niveaux abaissés ; bornée par la divulgation délimitée (`thm:divulgation_delimitee`, proposition) | non conduite |

### 2.3 Les énoncés sont faux ou mal posés **tels qu'écrits**, indépendamment de la preuve

Deux constats, lus sur les énoncés (`SemantiqueOperationnelle.lean:373-390` et `:477-492`) :

1. **`thm:preservation` conclut dans le même contexte `Δ`** (« il existe `ε'` tel que `Δ ⊢ c' : C | ε'` ») alors que trois schémas ne le conservent pas : `wait` (contexte avancé), `move` (`@_n Δ` devient `@_m Δ`), `declassify` (niveaux abaissés). L'esquisse l'écrit (« au contexte avancé près », « à l'abaissement près »). **L'énoncé est donc littéralement faux pour ces trois formes** ; il est vrai pour tous les autres cas conduits. C'est un défaut d'**énoncé**, non de preuve : aucune démonstration ne l'établira.
2. **`thm:progres` est énoncé sur des triplets** (« il existe `⟨c'|μ'|τ'⟩` tel que `⟨c|μ|τ⟩ → ⟨c'|μ'|τ'⟩`, et ce pour tout `μ` et tout `τ` ») alors que `send`, `guard`, `spawn`, `new` et `free` ne réduisent que dans une configuration à pool et à boîtes (schémas **globaux**, `eq:reductions-couche2`). Sur un triplet, un calcul clos `send m() to ι` est **ni terminal ni réductible** : l'énoncé est faux. L'esquisse le reconnaît (« la forme globale de l'énoncé, d'abord : … le progrès porte sur le multi-ensemble `𝒫` »), mais l'énoncé n'a pas été récrit. De plus, un `∥` dont une branche ne termine pas, ou est bloquée sur une règle globale, n'a pas de pas (dossier 1, §2.2 point 3 : la prémisse de la fourche-jointure exige des branches terminantes).

Ces deux constats ne dépendent pas du choix de sceau : ils appellent une **réécriture d'énoncé** dans tous les cas.

### 2.4 Mentions de `thm:preservation` (cinq renvois entrants) et d'énoncés qui s'y appuient

| Mention | Texte (lu) | Effet d'un passage en proposition |
|---|---|---|
| `StructuresOuvertesEffetsEtMetaTheorie.lean:270` (énoncé de `thm:preservation_type`, **théorème**) | « Le volet évaluation est un corollaire de la préservation du §… » | un **théorème** dont un volet dérive d'une proposition : à ramener à « proposition » pour le volet, ou à reformuler |
| même fichier, 299 | « Ce théorème et la préservation du §… (théorème `thm:preservation`) ne sont pas deux formulations d'une même chose » | « théorème » → « proposition » |
| même fichier, 311-312 | « La _préservation par évaluation_ … **est démontrée** au §… (théorème `thm:preservation`) » | **fausse après passage** ; la phrase doit dire « esquissée sur … » ; le contrôle ne la détecte pas (le verbe précède le renvoi) |
| même fichier, 315-318 | « Ce qui manque à ce document est donc **exactement la seconde** [préservation par abaissement], et non “la préservation” en général » | **fausse après passage** : il manque aussi, de la première, les cas non conduits |
| `SemantiqueOperationnelle.lean:762` (esquisse de `thm:correspondance_niveaux`, proposition) | « Par préservation (théorème `thm:preservation`), chaque contractum reste typable » | « théorème » → « proposition » |
| même fichier, 964 | « La préservation (théorème `thm:preservation`) n'en fait pas partie » | « théorème » → « proposition » |
| `C6/CeQueLeSolveurRetourne.lean:416` | « la préservation graduée du §… (théorème `thm:preservation`) porte les grades, mais ne couvre que l'évaluation » | « théorème » → « proposition » ; le diagnostic « Rien, entre les deux, n'établit … » reste vrai |
| `SemantiqueOperationnelle.lean:25-29, 365-370`, 538-550 | « La préservation et le progrès sont démontrés … sur les constructeurs que la relation réduit » | à reborner |

`thm:progres` n'a **aucune** mention entrante ; son changement ne se propage nulle part (mais l'introduction de §4.7 et la phrase « Ensemble, ils donnent la correction du système d'effets » de la ligne ~371 la citent par le nom).

**Limite du contrôle de propagation, relevée** (`scripts/controles/notation.py:117-126`) : la fenêtre examinée suit le renvoi ; un verbe assertif **avant** le renvoi (« est démontrée … (théorème `…`) », ligne 311-312) n'est pas vu. Après un passage en proposition, le contrôle resterait vert alors que cette phrase serait fausse. Les mentions sont donc à relire **à la main** (liste ci-dessus).

## 3. Options exhaustives

| | Option | Idée |
|---|---|---|
| `S0` | statu quo | deux théorèmes ; l'esquisse porte les réserves |
| `S1` | **passer les deux en proposition** (le changement proposé dans `DECISIONS.md`) | l'énoncé reste tel quel, le sceau dit « ouvert » |
| `S2` | passer la seule préservation en proposition | le progrès resterait « théorème » (il n'a aucune mention entrante) |
| `S3` | **restreindre chaque énoncé à son périmètre démontré**, garder « théorème », porter le reste dans **une proposition** | applique la règle « une réserve qui borne une affirmation réécrit l'affirmation » |
| `S4` | **mériter le sceau** sur tout le périmètre | conduire les cas manquants (§5) |
| `S5` | passer en « conjecture » | écartée : les énoncés ne sont pas douteux, ils sont incomplets |

## 4. Pour chaque option : ce qu'elle impose, casse, coûte

### 4.1 `S0`

Viole la règle du Guide de lecture (réserve en esquisse, affirmation intacte) et laisse faux les deux énoncés (§2.3). La sentence « La préservation et le progrès sont démontrés … sur les constructeurs que la relation réduit » est vraie à la lettre mais engage la totalité. **Non recommandée.**

### 4.2 `S1`

* **Impose** : deux attributs `(status := "proposition")` ; relecture des huit mentions du §2.4 ; réécriture de l'introduction de §4.7 ; **et** les réécritures d'énoncé du §2.3 (le sceau seul ne les évite pas : une proposition fausse reste fausse).
* **Théorèmes et sceaux touchés** : `thm:preservation_type` (théorème, volet évaluation dérivé) doit suivre ; `thm:correspondance_niveaux` (proposition, déjà ouverte) : aucun changement ; `thm:progression_polarisee` et `thm:terminaison_couche_3` : indépendants. Énoncés ouverts : **21 → 23** (ou 24).
* **Grades, niveaux, sortes, simulation, non-interférence** : aucune interaction logique ; `thm:simulation` (proposition) et `thm:fidelite_interprete` (conditionnel à `Sim`) ne citent pas la préservation. La non-interférence n'en dépend pas (`SemantiqueOperationnelle.lean:963-966`).
* **Coût** : `S` (texte) ; **perte** : le noyau réellement esquissé (blocs pur et effet, congruence) perd le sceau qu'il méritait ; les cinq renvois entrants, qui utilisent ce noyau, deviennent « proposition » sans que leur usage change.
* **Effet sur la revendication `ARB-PR-06`** : voir §6.

### 4.3 `S2`

Même coût que `S1` en moins. Garde un « théorème » dont l'énoncé est faux sur les triplets (§2.3 point 2) : n'a de sens que si l'énoncé de `thm:progres` est récrit en forme globale **et** restreint. Reste incohérente avec `S1` pour la préservation.

### 4.4 `S3`

* **Impose** : (a) `thm:preservation` récrit sur le périmètre démontré : « pour un calcul formé des constructeurs des blocs `eq:reductions-pures` et `eq:reductions-effets`, avec les contextes d'évaluation » ; (b) `thm:progres` récrit sur ce périmètre, en triplets ; (c) **une** proposition nouvelle, après `thm:progres`, qui énonce la préservation et le progrès pour tous les autres constructeurs, avec la relation entre contextes `Δ → Δ'` (identité sauf `wait`, `move`, `declassify`) et la forme globale du progrès.
* **Théorèmes et sceaux touchés** : `thm:preservation` et `thm:progres` **gardent** « théorème » et deviennent vrais tels qu'écrits ; une proposition entre (le compteur d'énoncés, global, **décale d'un** les énoncés suivants : `correspondance-enonces.md` et les renvois du suivi à des numéros se régénèrent par `python3 scripts/suivi.py all`) ; `thm:preservation_type` : inchangé (son volet évaluation renvoie au périmètre démontré, ce qui est exact) ; `thm:correspondance_niveaux` : inchangé.
* **Mentions** : seules les mentions qui visent la couche 2, `∥`, les modalités doivent renvoyer à la proposition nouvelle ; les cinq mentions entrantes (qui utilisent le noyau) restent vraies.
* **Coût** : `M` (deux énoncés réécrits, une proposition, l'introduction, deux phrases du ch. 3 et une du ch. 6) ; aucune preuve nouvelle.
* **Avantage** : suit la règle du Guide ; **conserve** le sceau gagné ; les cas non conduits sont **nommés dans l'énoncé** de la proposition, non seulement dans une esquisse.
* **Risque** : le périmètre « blocs » exclut `fix`, `copatron`, `try`, qui sont dérivés sous hypothèse : à ranger dans la proposition (c'est le choix ci-dessous).

### 4.5 `S4`

Voir le §5.

## 5. Ce qu'il faudrait pour mériter le sceau sur tout le périmètre (`S4`)

| Poste | Contenu | Coût (estimation) |
|---|---|---|
| (a) **typage des configurations** | jugement `⊢ ⟨𝒫 \| μ \| ℳ \| τ⟩ : …` : type `Mb E` de chaque localisation, typage de chaque fibrille, `join` si `∥` passe en `V2` (dossier 1) | `L` |
| (b) **préservation par chaîne** | définition de « le long de chaque chaîne » sur un ordre partiel ; lecture « par fibrille » pour `spawn` (dossier 1 §6 de l'étude) ; cas de `spawn`, `new`, `send`, `guard`, `free`, `Loc` | `L` |
| (c) `thm:coherence_subsomption` | prérequis de `try` ; **proposition ouverte** | `M` |
| (d) **monotonie de `∥`** et lemmes de `∥`/`vmap` | dossier 1, `R4`, `R5` | `S` à `M` |
| (e) **lemmes de contexte** | `wait` (contexte avancé), `move` (`Ser` de grades nuls), `declassify` (abaissement borné par `thm:divulgation_delimitee`, lui-même proposition) | `M` |
| (f) `⊥_S` typable | terme du plus petit élément (ch. 2 le pose sans l'écrire ; la séance 32 ne l'a pas écrit : « choix de modèle ») | `S` |
| (g) **progrès global** | acyclicité du graphe de dépendances comme théorème (le texte la renvoie au ch. 3), exclusion du blocage mutuel ; terminaison des branches de `∥` (`thm:terminaison_couche_3`, énoncé conditionnel) | `L` |
| (h) hypothèses de module | totalité de `⟦operation⟧`, conformité de l'abaissement : restent hypothèses | — |

Total : **`L` à `XL`**, dont (a), (b), (g) sont de la dette de la couche 2 déjà inscrite (`PREUVE-03`, `BLOQ-05`). Aucune transcription en assistant de preuve n'existe dans le dépôt : « démontré » désigne ici une esquisse conduite sur tous les cas, au sens du Guide de lecture.

## 6. Conséquences sur l'énoncé de la revendication `ARB-PR-06`

**Ce que le texte dit** (`C6/CeQueLeSolveurRetourne.lean:414-419, 464-506`). La « préservation graduée de bout en bout » est la jonction de deux énoncés : `thm:preservation` (évaluation, grades et potentiel) et `thm:abaissement_grades` (conjecture, niveau `compilation`). Le texte dit que le premier « ne couvre que l'évaluation », que « rien, entre les deux, n'établit » la préservation par abaissement, et que la revendication est « _déclarée_, non une réserve à abandonner » ; l'énoncé reste conjecture et « aucune prose ne le dit acquis ». `StructuresOuvertes...:315-318` ajoute que « ce qui manque à ce document est donc exactement la seconde ».

**Ce que les sceaux changent.**

* Si `thm:preservation` n'est plus un théorème sur tout son périmètre (`S1`, ou `S3` pour les cas étendus), **la revendication a deux moitiés ouvertes, non une** : la préservation par abaissement (conjecture) **et** les cas non conduits de la préservation par évaluation (couche 2, `∥`, `vmap`, `try`, `wait`, `move`, `declassify`). La phrase « exactement la seconde » devient fausse.
* Sur le **fragment monomorphisé que la preuve de `ARB-PR-06` vise d'abord** (« passe par passe, fragment monomorphisé d'abord », `DECISIONS.md`), les cas qui comptent sont ceux des blocs pur et effet, où la préservation par évaluation est **démontrée** : `S3` n'abaisse pas ce noyau, `S1` le fait.
* **`declassify`** : sa préservation graduée est fausse par construction (borne : `thm:divulgation_delimitee`, proposition). La revendication « de bout en bout » doit donc **excepter** les calculs qui déclassifient, ou énoncer « à l'abaissement près ». C'est un défaut de l'énoncé de la revendication, présent quelle que soit l'option.
* Le texte de la revendication demande que la préservation soit « de bout en bout » sans dire pour quels constructeurs. Le fragment monomorphisé n'a ni couche 2, ni `∥` avec branches de couche 2, ni `declassify` : **le périmètre de départ de la preuve de `ARB-PR-06` est exactement le noyau démontré**. `S3` le rend lisible dans les énoncés.

## 7. Recommandation argumentée

1. **`S3`**, avec réécriture des deux énoncés. Raisons : (i) c'est l'application de la règle du Guide de lecture (« une réserve qui borne une affirmation réécrit l'affirmation ») ; (ii) elle corrige les deux énoncés **faux tels qu'écrits** (§2.3), ce que `S1` ne fait pas à elle seule ; (iii) elle conserve le sceau « théorème » pour le noyau qui le mérite, donc ne dégrade pas les cinq renvois entrants ni `thm:preservation_type` ; (iv) elle rend le **périmètre de départ de `ARB-PR-06`** lisible dans le texte ; (v) coût `M`, sans preuve nouvelle.
2. **`S1` est le repli minimal** si l'auteur veut éviter d'ajouter un énoncé (donc un décalage de numéros) : changer deux attributs et relire les mentions. Il faut alors **aussi** récrire l'énoncé de `thm:progres` (forme globale) et ajouter à `thm:preservation` la relation de contextes `Δ → Δ'`, sans quoi une proposition fausse reste fausse.
3. **Dans tous les cas** : reborner l'introduction de §4.7 (« sur les constructeurs que la relation réduit ») et corriger les phrases `StructuresOuvertes…:311-318` ; relire à la main les mentions (§2.4, limite du contrôle).
4. **`S4`** : le but à terme, dans l'ordre de la dette de la couche 2 (§5) ; il n'est pas un préalable.
5. **Ne pas** passer en conjecture (`S5`).
6. **Ce que la recommandation ne tranche pas** : où ranger `fix`, copatron, `try` (noyau ou extension) : je les range dans l'extension parce que leur dérivation est sous hypothèse ou conditionnelle (§2.2).

## 8. Formulations prêtes à écrire (non appliquées)

### 8.1 `thm:preservation`, énoncé restreint (option `S3`)

```
::::thm (label := "thm:preservation")
:::title
préservation
:::

:::statement +titled
Le type se conserve, le potentiel ne croît pas

Soit $`c` un calcul formé des constructeurs des formules ({num "eq:reductions-pures"}[]) et
({num "eq:reductions-effets"}[]), et de leurs contextes d'évaluation. Si $`\Delta \vdash c : C \mid \varepsilon`
et $`\langle c \mid \mu \mid \tau\rangle \longrightarrow \langle c' \mid \mu' \mid \tau'\rangle`, alors il
existe $`\varepsilon'` tel que $`\Delta \vdash c' : C \mid \varepsilon'` et
$`\tau'\cdot\varepsilon' \sqsubseteq \tau\cdot\varepsilon`. Pour les autres constructeurs, la proposition
({num "thm:extension_reduction"}[]) donne l'énoncé et dit ce qui n'est pas conduit.
:::
```

(l'esquisse actuelle est conservée, amputée des paragraphes « Schémas ajoutés », « Schémas orientés », « Schémas des modalités », qui passent à la proposition.)

### 8.2 `thm:progres`, énoncé restreint

```
Soit $`\vdash c : C \mid \varepsilon` dans le contexte vide, $`c` formé des constructeurs des formules
({num "eq:reductions-pures"}[]) et ({num "eq:reductions-effets"}[]). Alors $`c` est terminal — de la forme
$`\mathsf{return}\;v`, $`\lambda x. c_0`, $`\Lambda\alpha. c_0`, $`\langle c_i\rangle_{i\in I}`,
$`\langle\!\langle j \mapsto c_j \rangle\!\rangle_{j \in J}` ou $`\mathsf{delay}\;c_0` — ou bien il existe
$`\langle c' \mid \mu' \mid \tau'\rangle` tel que $`\langle c \mid \mu \mid \tau\rangle \longrightarrow \langle c' \mid \mu' \mid \tau'\rangle`,
et ce pour tout $`\mu` et tout $`\tau`.
```

### 8.3 La proposition nouvelle

```
::::thm (label := "thm:extension_reduction") (status := "proposition")
:::title
préservation et progrès pour les schémas ajoutés
:::

:::statement +titled
Ce que les énoncés précédents deviennent hors du noyau pur et à effet

Pour les constructeurs des formules ({num "eq:reductions-pures-suite"}[]), ({num "eq:reductions-couche2"}[]),
({num "eq:reductions-orientees"}[]) et ({num "eq:reductions-modalites"}[]), la préservation et le progrès
se lisent aux conditions suivantes. (i) Le jugement conserve le contexte, sauf pour $`\mathsf{wait}`
(contexte avancé d'un pas), $`\mathsf{move}` (le contexte d'une valeur sérialisable est de grades nuls) et
$`\mathbf{declassify}` (niveaux abaissés), où il le conserve à la relation indiquée près. (ii) Pour la couche 2,
l'énoncé porte sur une configuration typée et la décroissance s'entend le long de chaque chaîne ; le progrès
porte sur le multi-ensemble de fibrilles. (iii) Pour la récupération, l'affaiblissement par la jointure
({num "thm:coherence_subsomption"}[]) est supposé ; pour la mise en parallèle, la terminaison des branches.
:::

:::proofsketch
Les cas dérivables sont donnés dans l'esquisse de la préservation ; les autres ne sont pas conduits.
:::
::::
```

### 8.4 Introduction de §4.7 (`SemantiqueOperationnelle.lean:25-29`)

```
La préservation et le progrès sont démontrés, le second sous deux hypothèses nommées, sur les constructeurs
des deux premiers blocs ; pour les schémas ajoutés par la suite, ils sont énoncés dans une proposition qui
dit ce qui n'est pas conduit ({num "thm:extension_reduction"}[]).
```

### 8.5 Ch. 3, `StructuresOuvertesEffetsEtMetaTheorie.lean:310-318`

```
La _préservation par évaluation_ porte les grades et les effets : elle est démontrée sur le noyau pur et à
effet (théorème {num "thm:preservation"}[]) et énoncée sans l'être au-delà (proposition
{num "thm:extension_reduction"}[]). La _préservation par abaissement_ porte les grades à travers la
compilation, et elle est énoncée sans être démontrée (théorème {num "thm:abaissement_grades"}[]). […] Ce qui
manque à ce document est donc la seconde et, de la première, les cas que la proposition nomme.
```

### 8.6 Revendication `ARB-PR-06` (`C6/CeQueLeSolveurRetourne.lean:495-499`, phrase à ajouter)

```
La revendication a deux moitiés, et il faut les dire séparément : la préservation par évaluation, démontrée sur
le noyau pur et à effet et non conduite au-delà, et la préservation par abaissement, qui est la conjecture
ci-dessus. Le fragment sur lequel la preuve s'engage d'abord — fonctions d'ordre supérieur monomorphisées et
inlinées — est celui du noyau démontré ; la déclassification en est exceptée, sa préservation graduée n'étant
vraie qu'à l'abaissement près.
```

## 9. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| `S3` | énoncés vrais tels qu'écrits ; `PREUVE-02` (ARB-PR-06) sur un périmètre lisible ; l'écriture du typage des configurations comme travail **nommé** (poste (a) du §5) |
| `S1` | fermeture de la proposition de changement de sceau dans `DECISIONS.md` ; relecture des mentions |
| `S4` | `PREUVE-03`, `PREUVE-07`, `BLOQ-05`, `BLOQ-07` (même dette) |
| tous | alignement de l'introduction de §4.7 et du ch. 3 ; ouverture de la voie de la revendication |

## 10. Niveau de vérification

* **Lu** : énoncés, esquisses, introduction, table de couverture, mentions, contrôles (lignes citées).
* **Constats du §2.3** : lectures de rédacteur ; le constat 1 se vérifie sur les trois schémas dont l'esquisse dit elle-même que le contexte change ; le constat 2 se vérifie sur la règle globale de `send`, qui ne figure pas parmi les schémas à triplets.
* **Coûts** : estimations non mesurées.
* **Sources externes** : aucune relue.

Renvois : [`DECISIONS.md`](../../suivi/DECISIONS.md) (changements de sceau proposés) ; [01](01-parallele-et-vmap.md) ; [06, formes temporelles et `declassify`](06-formes-temporelles-declassify-at-move.md) ; [`GuideDeLecture`](../../../spec/Spec/C1/GuideDeLecture.lean).
