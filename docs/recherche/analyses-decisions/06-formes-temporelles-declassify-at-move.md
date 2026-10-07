<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 6 : formes temporelles, `declassify`, `at_n`, `move` (grammaires corrigées, à ratifier)

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Décision antérieure de l'auteur (séance 32, §A.3) : « Les grammaires sont à définir. » Elles ont été corrigées ; la ligne de [`DECISIONS.md`](../../suivi/DECISIONS.md) attend la ratification de **deux choix** : lire les modalités temporelles comme l'identité de la relation (le temps vit dans la trace), et faire rendre à `declassify` une boîte au niveau abaissé plutôt qu'une étiquette. Ce dossier dit **ce que le manuscrit actuel engendre**, **ce qui reste en suspens**, et donne les options. Il ne tranche rien ; `spec/` n'est pas modifié ; les textes Verso du §7 sont **non appliqués**.

**Niveau de vérification.** Grammaires, règles et schémas : lus dans les fichiers cités (lignes). Les constats de « ce qui n'a ni règle ni définition » sont établis par `grep` sur `spec/Spec` ; ils disent ce que **je n'ai pas trouvé**, non une preuve d'absence dans d'autres sources du dépôt (j'ai lu `spec/`, non les archives). Les raisonnements sur la préservation sont de rédacteur, sans vérification par machine. Aucune source externe n'a été relue.

## 1. Question exacte

> (a) Ratifie-t-on la **lecture séquentielle** des six formes temporelles (`always`, `now`, `next` valeurs ; `delay` calcul terminal ; `at`, `wait`, `when` éliminations), où la durée d'attente n'est pas un pas de la relation ? (b) Ratifie-t-on `declassify_{ℓ'}(box_r w) → return (box_{r[ℓ']} w)` (boîte au niveau abaissé) plutôt qu'une étiquette d'exécution ? (c) Ratifie-t-on la **machine unique** pour `at_n` et `move` (lieux et niveaux comme étiquettes de type, aucun lieu courant dans la configuration) ? (d) Et que faire de ce qui reste en suspens (§4) ?

## 2. Ce que le manuscrit actuel engendre

### 2.1 Grammaires (lues)

| Fait | Où |
|---|---|
| Types de valeur : `… \| @_n V \| … \| □V \| ◇V \| ○V` ; types de calcul : `F_ε V \| V ⊸ C \| & \| ∀ \| ν \| ○C` ; **abréviations** (non productions) : `!_ℓ V`, `◇C`, `@_n C` (`@_n(F_ε V) = F_{@_nε}(@_n V)`) | `spec/Spec/C3/GrammaireDesTypes.lean:42-43, 74-95` |
| Valeurs de terme : `… \| always v \| now v \| next v \| loc_n v` ; calculs : `… \| declassify_ℓ(v) \| delay c \| at v \| wait v \| when x = v in c \| … \| at_n c \| move_{n→m} v \| …` | `spec/Spec/C3/GrammaireDesTermes.lean:26-37` |
| Règles : `Alw` (`□Δ ⊢ always v : □V`), `Alw⁻` (`at v : F_𝟏 V \| 𝟏`), `Now`, `Nxt` (`○Δ ⊢ next v : ○V`), `Wait` (`v : ○◇V` donne `F_𝟏 ◇V \| 𝟏`), `When` (conclusion `◇C \| ε[ω/k]`, contexte `□Δ₂`), `Del` (`○Δ ⊢ delay c : ○C`) | `spec/Spec/C3/ReglesDeTypage.lean:215, 451-463` |
| `Loc`, `At` (`@_nΔ ⊢ at_n c : F_{@_nε}(@_nV) \| @_nε`, prémisse `loc(Δ) ⊒ n`), `Move` (`Ser(V)`, `n ⊑ m`, effet `⟨net_{n,m}, ⟨c,c⟩⟩`), `Try` | `ReglesDeTypage.lean:1517-1531` |
| `Declassify` : `Δ ⊢ v : !_r V`, `v ∈ 𝒳`, `fv(v) = ∅`, `ℓ' ≤ ℓ` donne `declassify_{ℓ'}(v) : F_𝟏(!_{r[ℓ']}V) \| 𝟏` | `spec/Spec/C2/AdjonctionsEtEnrichissement.lean:218-224` |
| Schémas (six, `eq:reductions-modalites`) : `at (always w) → return w` ; `wait (next u) → return u` ; `when x = now w in c → c[w/x]` ; `declassify_{ℓ'}(box_r w) → return (box_{r[ℓ']} w)` ; `at_n (return w) → return (loc_n w)` ; `move_{n→m} (loc_n w) → return (loc_m w)` avec événement `net` ; contexte `at_n E` ; `delay c` **terminal** | `spec/Spec/C4/SemantiqueOperationnelle.lean:269-299` |
| Lecture « séquentielle, machine unique » : « la durée d'attente n'est pas un pas de la relation » ; la clause de session « ne traite ni la délégation ni la lecture des modalités temporelles » | `SemantiqueOperationnelle.lean:283-291` ; `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean:481-487` |

### 2.2 Ce que chaque forme engendre

| Forme | Catégorie | Type | Schéma | Progrès | Traduction | Préservation (croquis) |
|---|---|---|---|---|---|---|
| `always v` | valeur | `□V` | — (valeur) | terminal | non écrite | — |
| `at v` | calcul | `F_𝟏 V` | `at (always w) → return w` | par forme canonique | non écrite | **exacte** |
| `now v` | valeur | `◇V` | — | terminal | non écrite | — |
| `when x = v in c` | calcul | `◇C`, effet `ε[ω/k]` | `→ c[w/x]` | par forme canonique | non écrite | **exacte** (l'effet du contractum est majoré par `ε[ω/k]`) |
| `next v` | valeur | `○V` | — | terminal | non écrite | — |
| `wait v` | calcul | `F_𝟏 ◇V` | `wait (next u) → return u` | par forme canonique | non écrite | **demande un lemme** (contexte avancé) |
| `delay c` | calcul | `○C` | **aucun** | **terminal** | non écrite | — |
| `declassify_ℓ'(v)` | calcul | `F_𝟏(!_{r[ℓ']}V)` | `→ return (box_{r[ℓ']} w)` | par forme canonique | sans objet (identité à l'exécution, grades effacés) | « fausse en l'état » (croquis) ; voir §4.3 |
| `loc_n v` | valeur | `@_n V` | — | terminal | non écrite | — |
| `at_n c` | calcul | `F_{@_nε}(@_nV)` | `at_n (return w) → return (loc_n w)`, contexte `at_n E` | par contexte | non écrite | **exacte** |
| `move_{n→m} v` | calcul | `F(@_m V)` | `→ return (loc_m w)` + événement `net` | par forme canonique | non écrite | **demande un lemme** (`Ser(V)`, grades nuls) |

**Verdict.** Les grammaires corrigées **engendrent** tous les types que les règles concluent (l'abréviation `◇C` est définie sur la tête de chaque type de calcul, y compris `◇(○C) = ○◇C`) ; chaque forme a une règle, un schéma (sauf `delay`, terminal) ; trois préservations sont exactes, trois demandent un lemme. **Aucune des six formes temporelles ni `declassify`, `at_n`, `move` n'a de clause de traduction** (`PREUVE-07`, `BLOQ-07`).

## 3. Options exhaustives

### 3.1 Modalités temporelles (ratification de (a))

| | Option | Idée | Source |
|---|---|---|---|
| `T-A` | **lecture séquentielle** : modalités = identité de la relation ; le temps vit dans la trace et la traduction | appliquée | instruction, voie A |
| `T-B` | **horloge dans la configuration** : un compteur par niveau, `delay` attend un pas, `wait` et `when` attendent la disponibilité | donne un sens aux bornes de `◇` ; ajoute un composant à toutes les configurations ; change le statut de `tick` | voie B |
| `T-C` | **renvoi au métalangage** : `→` ne réduit pas ces formes, la traduction leur donne leur sens, la simulation ne les porte pas | aucun schéma | voie C |

### 3.2 Déclassification (ratification de (b))

| | Option | Idée |
|---|---|---|
| `D-A` | identité à l'exécution : `declassify_{ℓ'}(v) → return v` | préservation « à l'effacement près » |
| `D-B` | **étiquette d'exécution** : forme de valeur `declass_{ℓ'}(w)` typée par la règle | forme de valeur de plus (formes canoniques, substitution, grammaire) |
| `D-C` | **opération à effet** : la déclassification est un événement du journal | contredit la règle donnée sans effet |
| `D-D` | **boîte au niveau abaissé** (appliquée) : `box_r w → box_{r[ℓ']} w` | pas de forme de valeur nouvelle ; le type annoncé est celui du contractum |

### 3.3 Localisation et déplacement (ratification de (c))

| | Option | Idée |
|---|---|---|
| `L-A` | **machine unique** (appliquée) : lieux = étiquettes de type, `μ` une arène par machine, aucune sémantique répartie | suffit à la préservation si une forme de valeur étiquetée existe (`loc_n`) |
| `L-B` | **configuration indexée par lieu** : chaque fibrille a un lieu, `at_n` la déplace, `move` copie la valeur sérialisée, la défaillance détruit les fibrilles d'un lieu | le plus fidèle à « l'hypothèse d'environnement gagne une composante réseau » ; décider si `μ` est par lieu |

## 4. Pour chaque option : ce qu'elle impose, casse, coûte ; ce qui reste en suspens

### 4.1 `T-A` (appliquée)

* **Impose** : rien de plus que ce qui est écrit. **Perd** : la durée d'attente n'est pas observable **à la source**. Conséquences lues : (i) `wait` coûte `𝟏` (effet neutre) alors que la règle `When` perd la borne (`ε[ω/k]`) : le **type** dit « borne perdue », la **trace** n'enregistre aucune attente ; (ii) la **non-interférence temporelle** au niveau de la source ne voit pas la durée d'attente : un `wait` dont la durée dépend d'un secret n'est pas distingué à la source, seule la cible (fil de temps) le voit. Le texte dit déjà la clause de session non traitée pour ces formes (`LeSystemeDeSortesDuMetalangage.lean:481-487`) ; `thm:non_interference` (théorème) est borné au fragment sans communication ; **aucune règle ne contraint le niveau de production d'un `wait`** (effet `𝟏`, `ℓ̂ = ⊤`, la clause de `Case` ne contraint rien). **Dossier 3 (`ANOM-18`)** : le même défaut que `spawn`.
* **Théorèmes et sceaux touchés** : `thm:progres` et `thm:preservation` (dossier 5, périmètre des cas) ; `thm:determinisme_observationnel` (conjecture) : inchangé ; `thm:simulation` (proposition) : clauses de traduction à écrire pour six formes.
* **Grades** : `Alw` et `Nxt` portent `□Δ` et `○Δ` sur le contexte (modalités sur les contextes) ; `wait (next u) → return u` change le contexte (`○Δ → Δ`).
* **Coût** : nul pour la ratification ; `M` pour les trois lemmes de préservation et les clauses de traduction (`PREUVE-07`).
* **Exemples.** `at (always 3) → return 3` ; `when x = now 3 in c → c[3/x]` ; **contre-exemple d'élimination** : `delay c` n'a **aucun** consommateur (§4.5 point 1).

### 4.2 `T-B` et `T-C`

* `T-B` : ajoute un composant (horloge) à `⟨c | μ | τ⟩`, `⟨𝒫 | μ | ℳ | τ⟩` ; change `tick` (il avance l'horloge) ; **tous** les schémas écrits sont à relire ; donne un sens opérationnel à `ε[ω/k]` ; coût `L`, touche `thm:preservation` en entier. Écartée tant que le typage des configurations n'est pas écrit.
* `T-C` : cohérente avec `thm:simulation` (la simulation ne porterait pas ces formes), mais **retire** les six schémas du tableau `tab:couverture-reductions` : le progrès ne tiendrait plus sur `wait`, `when`. Coût `S` ; recul par rapport à ce qui est écrit.

### 4.3 `D-D` (appliquée) et ce qu'elle laisse

* **Impose** : la prémisse `fv(v) = ∅` (déjà dans la règle, séance 32) ; le schéma `declassify_{ℓ'}(box_r w) → return (box_{r[ℓ']} w)` suppose que l'argument est de la forme `box_r w` (valeur close de 𝒳).
* **Préservation : un point à vérifier.** Le croquis dit que la préservation graduée « est fausse en l'état » pour `declassify` (le contractum se dérive à niveaux abaissés). Or la règle `Box` donne `r·Δ_w ⊢ box_r w : !_r V` et la règle `Declassify` exige `fv(v) = ∅` : `w` est clos, de sorte que `Δ_w` n'a aucune liaison utilisée, et le contractum `return (box_{r[ℓ']} w)` reçoit **exactement** le type `F_𝟏(!_{r[ℓ']}V)` que la règle conclut. **Si** la multiplication `r·Δ` ne modifie pas la composante niveau des liaisons inutilisées, la préservation de **typage** est exacte pour ce cas, sans « à l'abaissement près ». Je n'ai trouvé nulle part la définition de `r·Δ` sur la composante niveau (aucune des lignes lues du ch. 3 et du ch. 1 ne la donne) : **la phrase « fausse en l'état » est peut-être périmée depuis que la clôture est dans la règle**. À vérifier avant de ratifier ; si le point est établi, le cas `declassify` passe de « demande un lemme » à « exact » (dossier 5).
* **Ce que `D-D` ne règle pas** : la garantie de bout en bout est la **divulgation délimitée** (`thm:divulgation_delimitee`, proposition, croquis non conduit : le lemme fondamental n'est pas conduit sur tous ses cas). Le choix `D-D` est neutre pour elle ; c'est le cas `Declassify` du lemme fondamental qui porte la preuve.
* **Alternatives, pour mémoire** : `D-B` ajoute une forme de valeur (grammaire, substitution, canoniques) pour un bénéfice que `D-D` obtient autrement (le type annoncé est celui du contractum) ; `D-A` perd la préservation graduée ; `D-C` contredit la règle (effet neutre).
* **Coût** : nul pour la ratification.

### 4.4 `L-A` (appliquée) et `L-B`

* `L-A` : `Loc`, `At`, `Move` sans lieu courant ; `at_n (return w) → return (loc_n w)`. **Ne dit pas** : ce que devient `μ` quand `move` change de machine (une arène par machine : le texte le dit, §4.5, mais le schéma de `move` ne touche pas `μ`) ; où se range la défaillance au regard du lieu (`try` est un pas de l'environnement, sans lien avec un lieu).
* `L-B` : plus fidèle, à instruire quand la couche 1 sera formalisée pour elle-même ; coût `L` (configuration indexée par lieu, arène par lieu, destruction par lieu).

### 4.5 Ce qui reste en suspens (constats de ce dossier)

1. **`○` n'a presque pas d'élimination.** `delay c : ○C` est une introduction de calcul **sans consommateur** : aucune règle ne prend un sous-terme de type `○C`, aucun schéma ne réduit `delay` (il est terminal). `next v : ○V` n'est consommé que par `wait`, et seulement si `V = ◇W` (`Wait` exige `○◇V`). Pour `V` quelconque, `○V` n'a aucune élimination. `grep` : `delay` et `bigcirc}C` n'apparaissent que dans `Del` (215), la table de couverture et l'énoncé du progrès. Ce n'est un défaut que si `○C` doit être exécutable à la source ; sous `T-A` il appartient à la traduction (le canal de temps). **À dire dans le texte** (§7.1) ou à compléter (`unstep`).
2. **Trois objets nommés, jamais définis dans les lignes lues** : `@_nε` (« l'effet `ε` vu au lieu `n` », `GrammaireDesTypes.lean:92`, utilisé par `At` et par `@_nC`) ; `loc(Δ)` (prémisse de `At`) ; `Ser(V)` (prédicat de raffinement, `Move`, ligne 1503 : « ce qui est déplaçable »). De plus, le coût `c` de `⟨net, ⟨c,c⟩⟩` est une constante non fixée. Sans définition de `@_nε`, le typage de `at_n` n'est pas complet.
3. **Les six formes et `declassify`, `at_n`, `move` n'ont aucune clause de traduction** : `PREUVE-07`, `BLOQ-07`, `PREUVE-03`.
4. **`ε[ω/k]`** est défini pour un facteur temporel en famille (`ReglesDeTypage.lean:483-490`) ; sous `ANOM-18` (`(ℕ∞ × ℕ∞)^ℒ`) il envoie sur `⟨ω, ω⟩` à tout niveau (dossier 3).
5. **Collision de noms** : deux constructeurs `at` (élimination de `□` ; localisation `at_n`) ; les règles s'appellent `Alw⁻` (pour le premier) et `At` (pour le second). À joindre à `T-68` (`primitives.md` porte déjà `Nxt`, `Loc`, `Declassify` comme « à arbitrer »).
6. **Notation du type de calcul** : `Move` et `Vmap` écrivent `F (…)` sans indice d'effet, quand les autres règles écrivent `F_ε V` ; la règle `When` met `ε` dans l'indice de `F` et `ε[ω/k]` dans l'effet du jugement. À uniformiser avec `ANOM-18`.

## 5. Recommandation argumentée

1. **Ratifier les grammaires** : elles engendrent tous les types que les règles concluent, croisés mécaniquement (53 règles, 49 constructeurs, `controle.py` vert). Rien dans les lignes lues ne les contredit.
2. **(a) Ratifier `T-A`** (lecture séquentielle), **à deux conditions écrites** : dire que `delay c` n'a pas de consommateur à la source et que la durée d'attente est visible dans la traduction seulement (§7.1) ; poser, quand la non-interférence graduée sera étendue aux formes temporelles, que la durée d'attente d'un `wait` est dans la **clause de session**, non dans la clause de calcul. `T-B` reste une cible de la couche 3 « horloge » ; `T-C` est un recul.
3. **(b) Ratifier `D-D`**, après **vérification du point du §4.3** (le cas `declassify` de la préservation est-il exact ?). Si oui, retirer du croquis la phrase « fausse en l'état » et du tableau `tab:couverture-reductions` « à l'abaissement près ». La garantie reste `thm:divulgation_delimitee`.
4. **(c) Ratifier `L-A`**, avec la définition de `@_nε`, `loc(Δ)`, `Ser(V)` écrite : sans elles `At` et `Move` ne sont pas complètement typés (§4.5 point 2). `L-B` quand la couche 1 sera formalisée.
5. **Ordre** : `ANOM-18` (dossier 3) avant de fixer `ε[ω/k]` et la clause de couplage de `wait`/`move` ; puis les clauses de traduction (après `∥`, dossier 1, et `spawn`, dossier 2).
6. **Ce que la recommandation ne tranche pas** : l'élimination de `○C` (compléter ou dire : §7.1) ; la notation du type de calcul.

## 6. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| ratifier les grammaires | fermeture de la partie « grammaires » de `ANOM-17` ; `T-68` pour les noms |
| `T-A` | les six schémas restent ; `PREUVE-07` clauses de traduction des modalités |
| `D-D` + vérification du §4.3 | préservation de `declassify` exacte ; `PREUVE-04` (divulgation délimitée) sur un cas de moins |
| `L-A` + définitions | `At` et `Move` complets ; lemme `Ser` pour la préservation de `move` |
| `T-B`, `L-B` | (plus tard) formalisation de la couche 1 |

## 7. Formulations prêtes à écrire (non appliquées)

### 7.1 Lecture des formes temporelles : ce qui est dit et ce qui ne l'est pas (après `eq:reductions-modalites`, `SemantiqueOperationnelle.lean`, paragraphe « Les lectures sont les suivantes »)

```
Deux conséquences de la lecture séquentielle sont à écrire. La première : $`\mathsf{delay}\;c` est terminal et
aucune règle ne consomme un calcul de type ${\bigcirc}C$ ; de même ${\bigcirc}V$ n'est consommé que par
$`\mathsf{wait}`, quand $`V = {\Diamond}W`. Le sens de ces formes est celui du canal de temps de la cible : la
source les range parmi les termes terminaux, et la traduction les relie à l'horloge de session. La seconde :
la durée d'une attente n'est pas un pas de la relation, de sorte qu'un $`\mathsf{wait}` dont la durée dépend
d'un secret n'est pas distingué à la source. Il l'est sur le canal de temps de la cible, et c'est la clause
de session ({num "sec:g-sortes"}[]) qui le compare, non la clause de calcul de la relation logique.
```

### 7.2 Définitions manquantes de la localisation (ch. 3, après `eq:regles-couche1`)

```
Trois notations de ces règles se définissent ainsi. L'effet $`@_n\varepsilon` est l'effet $`\varepsilon` dont
chaque événement est étiqueté du lieu $`n` : il ne change ni l'ordre ni la composante temporelle. Le lieu d'un
contexte, $`\mathrm{loc}(\Delta)`, est la borne supérieure des lieux des liaisons de $`\Delta`. Et $`\mathsf{Ser}(V)`
est le prédicat qui vaut pour les types de valeur dont les habitants sont des données sans ressource : unité,
bases, produit et somme de types $`\mathsf{Ser}`, vecteurs de types $`\mathsf{Ser}`, boîtes de grade nul.
Le coût de transfert $`c` est une constante de l'environnement, déclarée avec le profil
($`\Pi`, §{num "sec:c4-echelle-du-systeme"}[]).
```

(Ces définitions sont **des propositions de rédacteur** : le texte du manuscrit ne les donne pas ; elles sont à confirmer par l'auteur avant tout usage.)

### 7.3 Ratification de `D-D`, si le point du §4.3 est établi (croquis de `thm:preservation`, paragraphe sur `declassify`)

```
$`\mathbf{declassify}` : l'argument étant clos ($`\mathrm{fv}(v) = \emptyset`), la boîte rendue
$`\mathsf{box}_{r[\ell']}\,w` se type dans le même contexte que le rédex, avec le type que la règle
{sc}[Declassify] conclut ; la préservation y est exacte. Ce n'est pas la déclassification qui est bornée par
la préservation, mais ce qu'elle libère : le théorème de divulgation délimitée
({num "thm:divulgation_delimitee"}[]) en est la borne.
```

## 8. Niveau de vérification

* **Lu** : les cinq fichiers cités (grammaires, règles, schémas, extrait du ch. 2 sur la déclassification, extrait du ch. 4).
* **`grep`** : absence de définition de `@_nε`, `loc(Δ)`, `Ser(V)`, de consommateur de `○C`, dans `spec/Spec` (je n'ai pas lu `archives/`).
* **§4.3 (préservation de `declassify`)** : raisonnement de rédacteur, conditionnel à une définition de `r·Δ` que je n'ai pas trouvée ; **non vérifié**.
* **Sources externes** : aucune relue. `dasParallelComplexityAnalysis` (contrainte sur le contexte de `When`), `sabelfeldModelDelimitedInformation2004` (divulgation délimitée), `marshallGradedModalTypes2023` ne sont connus que par leur notice et par ce que le manuscrit en dit.

Renvois : [`instruction-des-decisions`](../instruction-des-decisions.md) (`declassify`, six formes, `at_n`/`move`) ; [`journal 02-32`](../../journal/2026-10-06-pr-02-32-redactions-de-l-auteur.md) §A.3 ; [03](03-anom-18-facteur-temporel.md) ; [05](05-sceaux-progres-preservation.md).
