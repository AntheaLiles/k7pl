<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Dossier de décision 2 : `spawn` et le fil de temps de la fibrille engendrée

**Demande de l'auteur** : « propose-moi les analyses détaillées face au manuscrit des éléments à trancher ». Ce dossier **synthétise et prolonge** l'étude [`etude-spawn-fil-de-temps`](../etude-spawn-fil-de-temps.md) (options `O1` à `O4`). Il ne tranche rien et ne modifie pas `spec/` ; les textes Verso du §7 sont **non appliqués**.

**Niveau de vérification.** Faits sur le manuscrit : lus dans les fichiers cités aux lignes indiquées. Esquisses de traduction, coûts `S`/`M`/`L`, constats de fuite : raisonnements de rédacteur, sans preuve ni vérification par machine. Sources externes : aucune relue (pages d'éditeurs et d'arXiv inaccessibles depuis la session) ; voir le §10.

## 1. Question exacte

> Le fil de temps enfilé (`eq:traduction-fils`) est une chaîne linéaire de maillons, un par niveau. Une fibrille engendrée par `spawn` ouvre une chaîne de plus, et un programme traduit ne peut ni créer ni recevoir de canal de temps ambiant (`thm:confinement_sortes`). **D'où vient le fil de la fille ?** Accepter la **bifurcation par maillon dirigée par le type** (`O1b`), ou une autre voie (`O2`, `O3`), ou **ne pas traduire** `spawn` pour l'instant en disant le périmètre (`O4a`) ?

Deux sous-questions en dépendent : la **forme du facteur temporel** (`ANOM-18`, dossier 3) et la **lecture de `∥`** (dossier 1).

## 2. État actuel du manuscrit

### 2.1 Faits lus

| Fait | Où (lu) |
|---|---|
| `Spawn` : `Δ ⊢ c : F₁ 𝟏 \| ε` donne `Δ ⊢ spawn c : F₁ 𝟏 \| ⟨spawn, ⟨w(ε), 0⟩⟩`. **Pas de clause de couplage** de niveau (seules `Case` et `Op` en portent) | `spec/Spec/C3/ReglesDeTypage.lean:1410-1415`, label `eq:regles-couche2` ; clauses de `Case` (205) et `Op` (211) |
| « `Spawn` ajoute le travail de la tâche fille et _rien à la profondeur de la mère_ … une tâche ne rallonge pas le chemin critique de celui qui l'engendre » | même fichier, 1445-1447 |
| Réduction : `⟨𝒫 ⊎ {p : spawn c} …⟩ → ⟨𝒫 ⊎ {p : return (), q : c} … τ ◁_p ε_spawn⟩`, `q` frais « reprenant après `ε_spawn` » | `spec/Spec/C4/SemantiqueOperationnelle.lean:171-176`, `eq:reductions-couche2` |
| Le fil enfilé : clauses pour `tick`, `operation`, `return`, `let` seulement ; « un événement d'un niveau ne touche que le fil de ce niveau » ; « une opération dont la famille `κ` n'est pas concentrée en un niveau n'a pas de clause » | `spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean:298-328`, `eq:traduction-fils` (306) |
| `J_k(P)` est « le mot des événements » reçus par le gestionnaire du niveau `k` ; `π^♭_ℓ(J) = (J_k)_{k ⊑ ℓ}` | même fichier, 330-337 |
| `thm:chaine_fils` (proposition) : fragment `return`, `let`, `tick`, opérations mononiveau ; « Pour `spawn` il ne s'étend pas tel quel : une fibrille engendrée ouvre une chaîne de plus, et d'où vient son canal ambiant est une question que le texte ne tranche pas » | même fichier, 339-376 |
| `tab:capacites` : émettre (un nom de programme, ou, pour un fil, son maillon suivant au même niveau) ; recevoir (« aucun terme traduit ne reçoit un nom de fil ») ; restreindre `𝒮_ν = 𝒮_prog ∪ 𝒮_maillon` | même fichier, 117-140 |
| `thm:confinement_sortes` (théorème) : aucun nom `operation_a` ou `temps` n'est lié ni transmis. **L'esquisse écrit « Couche 2 — tous les cas »** | même fichier, 228-272 (cas couche 2 : 257-265) |
| `thm:correspondance_niveaux` (proposition) : tout événement d'une exécution a un niveau `⊒ niv(Δ)` ; « Non démontrée en détail : l'induction doit encore traiter les règles de couche 2 » | `SemantiqueOperationnelle.lean:748-768` |
| `ℓ̂(ε)` : « borne inférieure des niveaux où `κ` est non nulle, et `⊤` si `κ = 0` » ; `Tick : ⟨𝟏, δ_ℓ̂⟩` ; `Send : ⟨send_m, ⟨1,1⟩⟩` ; `Spawn : ⟨spawn, ⟨w(ε), 0⟩⟩` | `ReglesDeTypage.lean:235-241, 213, 1413, 1421` |
| `thm:simulation` (proposition) : clauses pour `return`, `let`, `tick`, opération ; `→⁺` ou `→*` pour `spawn`, `new`, `try` non tranché | `spec/Spec/C4/CalculDeProcessusSousJacent.lean:299` |

### 2.2 Ce que le dossier ajoute à l'étude (constats nouveaux, lus)

1. **`ε_spawn` n'est pas le seul effet de couche 2 à porter un couple sans niveau.** `Send : ⟨send_m, ⟨1,1⟩⟩` (`ReglesDeTypage.lean:1421`) et le schéma de `move : ⟨net_{n,m}, ⟨c,c⟩⟩` (`SemantiqueOperationnelle.lean:279` ; règle `Move`, `ReglesDeTypage.lean:1525`) écrivent aussi un couple sans indice de niveau. Sous la clause de couplage `niv(Δ) ⊑ ℓ̂(ε)` de `Case`, leur `ℓ̂` n'est pas défini. Le même défaut que `spawn` frappe donc `send` et `move` : **un `case` sur un secret dont une branche émet est typable sans que la fuite par présence soit exclue par règle**. Ce n'est pas propre à `spawn` ; la réponse à `ANOM-18` règle les trois (dossier 3).
2. **Si `ANOM-18` est résolue par `(ℕ∞ × ℕ∞)^ℒ` avec `w(ε)` et `s(ε)` comme projections familles, `ℓs` disparaît.** L'étude (§5.1) écrit l'événement `spawn` sur « le niveau `ℓs` ». Mais si `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩` se lit avec `w(ε) ∈ ℕ∞^ℒ` (la famille des travaux de la fille, par niveau) et `0` la famille nulle, l'événement n'a **pas de niveau propre** : il est réparti sur les niveaux de la fille, `lev(ε) = {k | w_k(ε) ≠ 0}`. L'événement se projette alors sur chaque niveau `k ∈ lev(ε)` en un événement de bifurcation `fork` portant la part `⟨w_k(ε), 0⟩`. Le marqueur est écrit **exactement sur les fils où la fille travaille**, ce qui est la forme dirigée par le type de `O1b`, sans choix arbitraire de `ℓs` et sans « le niveau du `spawn` » à définir. C'est une lecture de rédacteur (non vérifiée) ; elle rend `O1b` canonique.
3. **L'esquisse de `thm:confinement_sortes` revendique la couche 2 « tous les cas » alors que la traduction de `spawn` n'existe pas** (`LeSystemeDeSortesDuMetalangage.lean:257-265` : les cas cités sont les structurelles, la modalité graduée, `operation` et les opérations à portée ; ni `spawn`, ni `send`, ni `guard`). Le théorème est scellé « théorème » ; l'esquisse promet donc plus que la traduction écrite (le même défaut que `thm:progres`, dossier 5). Sous `O4a`, l'esquisse doit être resserrée (§7.1).
4. **`thm:correspondance_niveaux` n'est pas seulement une hypothèse de `O1b`** : c'est aussi ce qui garantit que `Spawn`, sans clause de couplage, ne fuit pas. Sa preuve ne traite que `Tick`, `Op`, `Case` ; pour `Spawn`, elle suppose que la fille est typée sous le même `Δ` et que ses événements sont donc de niveau `⊒ niv(Δ)` (récurrence sur le calcul de la fille). Le **niveau de l'événement `spawn` lui-même** n'est couvert par aucune clause.

## 3. Options exhaustives

Reprise du tableau de l'étude (§1, §7), avec le sort que ce dossier propose.

| | Option | Sort proposé |
|---|---|---|
| `O1a` | bifurcation, un marqueur sur **chaque** niveau | écartée : fuite (programme `Q` de l'étude) |
| `O1b` | bifurcation dirigée par le type (marqueur sur les niveaux de `lev(ε_c)`) | **recommandée si l'on traduit** |
| `O2a` | partage littéral d'un maillon par deux producteurs | impossible (linéarité) |
| `O2b` | relais en ligne (la fille rend le maillon à sa fin) | écartée : introduit un blocage que la source n'a pas |
| `O2c` | chaînes séparées fusionnées par le gestionnaire (journal d'arrivée) | à garder en mémoire (journal unique pour P4) |
| `O3a` | la fille reçoit un canal `temps` | écartée sauf à réécrire `thm:confinement_sortes` |
| `O3b` | la fille reçoit des maillons du gestionnaire | candidate si l'application et l'opération à portée imposent l'extension §4.1 de l'étude |
| `O3c` | adresses statiques (un gestionnaire par site de `spawn`) | viable seulement avec une borne statique des engendrements |
| `O4a` | ne pas traduire : dire le périmètre | **état d'attente sans risque** |
| `O4b` | interdire `spawn` dans une unité `ℓ`-sensible | repli si `thm:correspondance_niveaux` échoue sur la couche 2 |
| `O4c` | `spawn` seulement si la fille n'a pas d'événement temporel | sans objet (la provision `w(ε)` perd son sens) |

## 4. Pour chaque option : ce qu'elle impose, casse, coûte

La grille `E1` à `E10` est celle de l'étude (§3) ; les tableaux de l'étude (§5, §7) en donnent le détail. Ce que ce dossier précise, option par option :

### 4.1 `O1b`

* **Impose** : (i) `ANOM-18` fixée en `(ℕ∞ × ℕ∞)^ℒ` (cf. §2.2, point 2 : sans cela `lev` n'est pas défini) ; (ii) un gestionnaire à deux branches (`ev`, `fork`) ; (iii) `J_k` redéfini en forêt de chaînes ; (iv) l'émission de deux maillons, écrite comme une suite de transmissions (la grammaire `eq:metalangage` n'a pas d'émission polyadique).
* **Ne casse aucun énoncé scellé** : `thm:confinement_sortes` garde son énoncé (le maillon n'est pas un canal d'effet) ; la phrase de l'esquisse « un maillon ne se transmettant que le long d'un fil » reste vraie.
* **Sceaux touchés** : `thm:chaine_fils` (proposition) s'étend à un arbre : son dernier mot (« le mot `J_k` est la suite des événements dans l'ordre de `→` ») devient « `J_k` est une forêt de chaînes ». `thm:simulation` (proposition) : le cas `spawn` est un `→⁺`.
* **Grades et niveaux** : le grade du maillon n'existe pas (le niveau d'un fil vient de l'effet, `LeSystemeDeSortesDuMetalangage.lean:384`). Les marqueurs ne tombent que sur `lev(ε_c) ⊒ niv(Δ)` par `thm:correspondance_niveaux` : **correction conditionnelle à ce théorème sur la couche 2**.
* **Sortes** : aucune ligne de `tab:capacites` ne change.
* **Préservation, non-interférence** : `P_trace(ℓ)` inchangée ; la clause de session compare des forêts, `θ` embarque la chaîne de la fille (un nom frais créé au même point).
* **Coût** : `M` à `L` (étude, tableau du §5.1), dominé par la définition de la comparaison de forêts et le lemme « marqueurs de niveau `⊒ niv(Δ)` ».
* **Exemple** : le programme `P` de l'étude (`let _ ← tick in let _ ← spawn (tick; tick) in tick`) donne `J_⊥` en arbre `m₁ → s ⟨fork⟩ → {m₂ ; c₁ → c₂}`. **Contre-exemple (`O1a`)** : `Q = case s of {0 ↦ spawn tick_H ; 1 ↦ return ()}`, `J_⊥` vide ou non selon `s` si un marqueur tombe sur le fil `⊥`.

### 4.2 `O2c`, `O3a`, `O3b`, `O3c`

Pour mémoire (détails à l'étude, §5.2 et §5.3) : `O2c` rend `J_k` total mais dépendant de l'ordonnanceur (clause de session à quantifier sur les entrelacements ou sous `𝒟_𝒮`, conjecture) ; `O3a` réécrit un théorème scellé ; `O3b` change deux lignes de `tab:capacites` et exige l'hypothèse « le gestionnaire répond toujours » ; `O3c` suppose une borne statique des `spawn`, **fausse sous une boucle ou un flux coinductif**, donc inapplicable à un acteur qui engendre par message.

### 4.3 `O4a`

* **Impose** : une phrase qui dit le périmètre (§7.1) et une relecture de l'esquisse de `thm:confinement_sortes` (point 3 du §2.2). **Coût nul**.
* **Ne casse rien** et **n'interdit pas** `O1b` plus tard.
* **Laisse** : `PREUVE-03` et `PREUVE-07` bornées (la non-interférence graduée reste au fragment sans communication) ; `BLOQ-07` « conditionnel à Sim » ; et **le trou de fuite de `Q`** (une règle de typage ne l'exclut pas) tant que `ANOM-18` est ouverte.

### 4.4 `O4b`

* Une condition de bord sur `Spawn` (« pas dans une unité `ℓ`-sensible »), qui demande la définition de « `ℓ`-sensible » au niveau du typage (elle n'existe aujourd'hui qu'en prose, §6.1 : « une unité `ℓ`-sensible n'admet que les passes `P_trace(ℓ)` »). Coût `S` à `M`. À retenir seulement comme repli.

## 5. Lien avec `∥`, avec `ANOM-18` et avec l'application

* **Avec `∥` (dossier 1).** Sous `V0` réparée, la traduction de `∥` est une bifurcation suivie d'une jointure, et ne demande aucune capacité nouvelle. Sous `V2`, `∥` est la traduction de `spawn` avec un `end` en plus : `O1b` devient quasi obligatoire. **Décider `∥` d'abord** : si l'auteur retient `V0` (ou `V3`), le choix pour `spawn` est libre ; il peut attendre (`O4a`).
* **Avec `ANOM-18` (dossier 3).** `lev(ε)` n'est défini qu'avec une forme complète. **Condition de `O1b`**, pas de `O4a`. `ANOM-18` doit donc être tranchée **avant** `O1b`, mais pas avant `O4a`.
* **Avec l'application et l'opération à portée.** Même question de fond (faire passer des maillons dans un appel, §4.1 de l'étude) : la séance 32 a renoncé à leur clause. `O1b` ne dispense pas de les traiter : elles réclament un maillon transmissible sur un canal de programme (« extension §4.1 »). Cette extension abaisse le coût de `O3b`, pas celui de `O1b`.

## 6. Recommandation argumentée

1. **Court terme : `O4a`, assorti de la correction de l'esquisse de `thm:confinement_sortes`.** Coût nul ; c'est l'état que le texte décrit déjà (`tab:couverture-reductions` : schéma écrit, pas de clause de traduction) ; il retire la seule promesse indue (« tous les cas ») sans rien interdire. **Raison** : trois décisions amont ne sont pas prises (`∥`, `ANOM-18`, application et portée), et `O1b` dépend d'un théorème (`thm:correspondance_niveaux`) dont l'induction sur la couche 2 n'est pas conduite.
2. **Cible : `O1b`**, sous les quatre conditions de l'étude, que ce dossier reformule : (i) `ANOM-18` en `(ℕ∞ × ℕ∞)^ℒ`, `w(ε)` et `s(ε)` lus comme familles (ce qui donne `lev` et supprime `ℓs`) ; (ii) l'auteur accepte `J_k` en ordre partiel (forêt) ; (iii) `thm:correspondance_niveaux` démontrée sur la couche 2 ; (iv) le gestionnaire spécifié, avec une borne sur ses instances. C'est l'option la moins invasive qui couvre `spawn` : aucune ligne de `tab:capacites` ne change, aucun énoncé scellé n'est modifié.
3. **Ordre** : `ANOM-18` et `∥` (indépendants l'un de l'autre pour `V0`) ; puis `spawn`. Si `∥` va vers `V2`, passer directement à `O1b`.
4. **Ne pas** retenir `O1a`, `O2a`, `O2b`, `O4c`, ni `O3a` sans accord de réécrire un théorème scellé.
5. **Conditions de révision** : celles de l'étude (§8) ; en particulier : si l'induction de `thm:correspondance_niveaux` sur la couche 2 échoue, replier sur `O4b` ; si l'on veut un seul journal pour l'observation et le rejeu de P4, examiner `O2c`.

## 7. Formulations prêtes à écrire (non appliquées)

### 7.1 `O4a` : périmètre, à la fin de l'esquisse de `thm:chaine_fils` (remplace la dernière phrase, `LeSystemeDeSortesDuMetalangage.lean:372-375`)

```
_Cette proposition est établie sur le fragment qu'elle nomme et seulement sur lui_ : la traduction n'a
pas de clause pour l'application, pour l'opération à portée ni pour la couche 2. Les énoncés de cette
section — la proposition ci-dessus, le théorème ({num "thm:confinement_sortes"}[]) et la clause de session
qui suit — valent donc pour les calculs dont la traduction est écrite. Le schéma de réduction de
$`\mathsf{spawn}` existe ({num "eq:reductions-couche2"}[]) ; sa traduction n'existe pas : une fibrille
engendrée ouvre une chaîne de plus, et d'où vient son canal ambiant est une question que le texte ne
tranche pas. Les voies en sont nommées au tableau des incertitudes.
```

Esquisse de `thm:confinement_sortes`, la ligne « _Couche 2 — tous les cas._ » devient :

```
_Couche 2 — les cas dont la traduction est écrite._ C'est le seul lieu où l'obligation a un contenu. Les
règles structurelles et les connecteurs n'engendrent que des noms de genre $`\mathsf{prog}` et des
maillons, restreignables par $`\mathcal{S}_\nu` ; la modalité graduée aussi. Le cas de
$`\mathsf{operation}_\varepsilon(v)` est celui qui produit une émission sur un canal distingué […]
Le cas des opérations à portée passe par la ré-invocation séquentielle, qui ne crée pas de nom nouveau.
Les constructeurs $`\mathsf{spawn}`, $`\mathsf{send}` et $`\mathsf{guard}` n'ont pas encore de traduction :
le théorème ne les couvre pas.
```

(Le reste de la phrase est celui de l'esquisse actuelle ; seul le titre du cas et la dernière phrase changent.)

### 7.2 `O1b` : clause de `spawn` et gestionnaire (si l'auteur retient la cible)

Dans `eq:traduction-fils`, une clause de plus, avec `L = lev(ε_c)` (les niveaux où le travail de la fille est non nul) :

```
\llbracket \mathsf{spawn}\;c \rrbracket_{z,\vec t,\vec t'} =
  (\nu z_c)(\nu (u_k, u'_k)_{k \in L})\Bigl(
      \textstyle\prod_{k \in L} \overline{t_k}\langle \mathsf{fork}_{\varepsilon_{\mathsf{spawn}}(k)},\, t'_k,\, u_k \rangle
    \mid \textstyle\prod_{k \notin L} [t_k \leftrightarrow t'_k]
    \mid \llbracket c \rrbracket_{z_c,\vec u,\vec u'}
    \mid z_c(\_).\mathbf{0} \mid \overline{z}\langle () \rangle \Bigr)
```

où `ε_spawn(k) = ⟨w_k(ε), 0⟩` est la part de la provision au niveau `k` (et `ū_k`, `ū'_k` sont reliés par `[ū_k ↔ ū'_k]` pour `k ∉ L` dans la traduction de `c`). Texte d'accompagnement :

```
Le gestionnaire du niveau $`k` offre deux branches : $`\mathsf{ev}`, qui reçoit un événement et un
maillon et écoute ce maillon ; $`\mathsf{fork}`, qui reçoit un événement et _deux_ maillons et écoute
les deux. Le fil d'un niveau est alors un _arbre_ de chaînes, ce qui est l'ordre partiel que la relation
donne à $`\tau` quand la fille « reprend après $`\varepsilon_{\mathsf{spawn}}` ». Seuls les niveaux où la
fille travaille bifurquent : les autres traversent par transfert. Par la correspondance des niveaux
({num "thm:correspondance_niveaux"}[]), ces niveaux sont au moins $`\mathrm{niv}(\Delta)`, de sorte que
la présence d'une bifurcation n'est visible que d'un observateur qui lit déjà $`\Delta`.
```

Énoncé de `thm:chaine_fils` étendu (dernière phrase de l'énoncé) :

```
Le journal $`J_k` est alors une _forêt_ de chaînes, dont les arêtes de bifurcation sont celles de
$`\mathsf{spawn}` ; sur le fragment sans $`\mathsf{spawn}` c'est le mot de la suite des événements de
niveau $`k`, dans l'ordre où la relation $`\to` les produit.
```

Clause de couplage manquante de `Spawn` (si `ANOM-18` fixe `ℓ̂(ε_spawn) = ℓ̂(ε_c)`) :

```
\textsc{Spawn}\;\frac{\;\Delta \vdash c : F_{\mathbf{1}} \mathbf{1} \mid \varepsilon \qquad \mathrm{niv}(\Delta) \sqsubseteq \hat\ell(\varepsilon)\;}{\;\Delta \vdash \mathsf{spawn}\;c : F_{\mathbf{1}} \mathbf{1} \mid \langle \mathsf{spawn},\ \langle w(\varepsilon),\ 0 \rangle \rangle\;}
```

(La clause est redondante avec la typabilité de `c` si `Op` et `Case` sont partout respectées ; la rendre explicite évite que la correction de `Spawn` repose sur `thm:correspondance_niveaux`.)

## 8. Ce que la réponse débloque

| Réponse | Débloque |
|---|---|
| `O4a` | l'écriture immédiate de §7.1 ; rien d'autre n'est bloqué ni débloqué |
| `O1b` | clause de traduction de `spawn` ; `thm:chaine_fils` pour la couche 2 ; cas `spawn` de `thm:simulation` (`→⁺`) ; `PREUVE-03` (clause du fil pour `spawn`) ; `PREUVE-07` ; l'ordre partiel de la couche 2 comme arbre de chaînes ; `∥` en `V2` |
| `O4b` | la fermeture de la fuite par interdiction ; définition de « `ℓ`-sensible » au typage |
| `ANOM-18` d'abord | `lev(ε)`, la clause de couplage de `Spawn`, `Send`, `move` |

## 9. Ce qui reste ouvert après la décision

L'application et l'opération à portée (maillons dans un appel) ; la borne mémoire du nombre de gestionnaires ; la clause de session sur des forêts ; la lecture du corps de Das, Hoffmann et Pfenning (comptage d'un processus engendré).

## 10. Niveau de vérification

* **Manuscrit** : faits lus, lignes indiquées, labels contrôlés (`grep`).
* **Constats nouveaux (§2.2)** : 1 et 3 lus directement dans les règles et l'esquisse ; 2 est une **lecture** de `⟨w(ε), 0⟩` comme famille, non confirmée par l'auteur ni par le texte (le texte ne définit pas `w(ε)`) ; 4 se lit sur la preuve de `thm:correspondance_niveaux`.
* **Coûts, esquisses** : estimations et raisonnements de rédacteur, non vérifiés par machine.
* **Sources externes** : aucune relue. Das, Hoffmann, Pfenning (2018, `dasParallelComplexityAnalysis`), Caires et Toninho (2026, `cairesLinearSessionAbstract2026`), Fournet et Gonthier (1996), Stefan et al. (2012), Borgström et al. (2016) ne sont connus que par leur notice (`biblio/references.json`) et par ce que le manuscrit en dit.

Renvois : [`etude-spawn-fil-de-temps`](../etude-spawn-fil-de-temps.md) ; [01, `∥` et `vmap`](01-parallele-et-vmap.md) ; [03, `ANOM-18`](03-anom-18-facteur-temporel.md) ; [`DECISIONS.md`](../../suivi/DECISIONS.md).
