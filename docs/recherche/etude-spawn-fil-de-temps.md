<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Étude comparative : le fil de temps de la fibrille engendrée par `spawn`

**Séance 32 (6 octobre 2026), partie C.** Réponse à la décision de l'auteur : « *pour faire un choix éclairé j'ai besoin d'avoir une analyse des possibilités au regard de l'état actuel du manuscrit* ».

**Statut.** Aucun choix n'est fait ici et le manuscrit (`spec/`) n'est pas modifié. La recommandation du §8 est un **avis**, avec ses conditions de révision. Les clauses de traduction données plus bas sont des **esquisses de lecture**, non vérifiées par machine et non démontrées : elles servent à chiffrer ce que chaque option impose, pas à être recopiées. Les faits sur le manuscrit sont vérifiés dans le dépôt (labels, règles, énoncés), les estimations de coût de preuve sont des estimations de rédacteur. Étude sœur : [`etude-parallele-fourche-entrelacement`](etude-parallele-fourche-entrelacement.md) (les deux sont liées, voir §4.3).

## 1. En bref

**La question.** Le fil de temps enfilé (`eq:traduction-fils`) est une chaîne linéaire de maillons, un par niveau : une fibrille, un fil. Une fibrille engendrée par `spawn` ouvre une chaîne de plus, et le programme traduit ne peut ni créer ni recevoir de canal de temps ambiant (`thm:confinement_sortes`). La traduction de `spawn` n'est pas écrite ; `thm:chaine_fils` le dit lui-même.

**Les options** (une variante de chacune est écartée par construction, §5) :

| | Option | En une phrase |
|---|---|---|
| `O1` | bifurcation par maillon (séance 29, « voie A ») | la mère crée les maillons de la fille et les lui donne par l'événement `spawn` ; le gestionnaire écoute un arbre de chaînes |
| `O2` | fil hérité, partagé (« voie C ») | la fille émet sur la chaîne de la mère ; sous sa forme littérale c'est impossible, sous sa forme arbitrée c'est `O1` plus un journal d'arrivée |
| `O3` | fil indépendant, fourni par le gestionnaire (« voie B ») | la fille reçoit une chaîne neuve du gestionnaire par un protocole de demande |
| `O4` | ne pas traduire le fil de la fille | borner le périmètre de `thm:simulation` et de la clause de session, ou interdire `spawn` dans le code où le temps est revendiqué |

**Ce qui est solide.** (i) Aucun énoncé ne **démontre** aujourd'hui quoi que ce soit sur la traduction de `spawn` : `thm:chaine_fils` est une proposition bornée à un fragment sans `spawn`, `thm:simulation` aussi, la clause de session est bornée au fragment sans communication (§2). Seule l'esquisse de `thm:confinement_sortes` (théorème) revendique la couche 2 « tous les cas », sans que la traduction de `spawn` existe : elle sera vraie ou fausse selon l'option. L'urgence est donc faible, mais cette esquisse est à surveiller. (ii) `O2` sous sa forme littérale est impossible (§5.2). (iii) `O1` sous sa forme « un marqueur de bifurcation sur chaque niveau » fuit : il faut la forme dirigée par le type (`O1b`, §5.1), dont la correction s'appuie sur `thm:correspondance_niveaux`, **non démontrée pour la couche 2**.

**Ce qui dépend d'un choix voisin.** L'application et l'opération à portée posent la même question de fond (faire passer des maillons dans un appel) : le prérequis commun est examiné au §4. La forme complète du facteur temporel (`ANOM-18`) conditionne toute option qui lit les niveaux de l'effet de la fille. Et `∥` en entrelacement (étude sœur) réclame le même mécanisme de bifurcation, plus une jointure.

**Avis** (§8) : `O1b` si l'auteur veut que la traduction couvre `spawn`, à quatre conditions ; sinon `O4a` (dire le périmètre) est un état d'attente sans risque, qui n'interdit pas `O1b` plus tard. À décider **après** l'étude sœur, car un entrelacement pour `∥` rend `O1b` quasi obligatoire.

## 2. Ce que le manuscrit dit aujourd'hui (faits vérifiés)

| Fait | Où |
|---|---|
| Réduction : `⟨𝒫 ⊎ {p : spawn c} …⟩ → ⟨𝒫 ⊎ {p : return (), q : c} … τ ◁_p ε_spawn⟩`, `q` frais, « reprenant après `ε_spawn` » ; `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩` | `eq:reductions-couche2` (§4.7, `sec:g-semantique`) |
| Typage : `Δ ⊢ c : F₁ 𝟏 \| ε` donne `Δ ⊢ spawn c : F₁ 𝟏 \| ⟨spawn, ⟨w(ε), 0⟩⟩` ; « rien à la profondeur de la mère » ; **aucune clause de couplage** `niv(Δ) ⊑ ℓ̂(ε)` (seules `Op` et `Case` en portent) | `eq:regles-couche2` (§3.2, `sec:g-couche2`) |
| Sous concurrence, `τ` est un ordre partiel étiqueté ; la décroissance de `τ·ε` s'entend « le long de chaque chaîne » | fin de `sec:g-couche2` ; énoncé de `thm:preservation` |
| Fil enfilé par niveau, clauses pour `tick`, `operation`, `return`, `let` seulement ; « un événement d'un niveau ne touche que le fil de ce niveau » | `eq:traduction-fils` (§4.8, `sec:g-sortes-fil`) |
| Sortes : genres `prog`, `operation_a`, `temps`, `maillon` ; capacités ; `𝒮_ν = 𝒮_prog ∪ 𝒮_maillon` ; transfert `[a ↔ b]` | `eq:sortes`, `tab:capacites`, `eq:bon-sortage` |
| Un programme traduit ne fabrique aucun canal d'effet : aucun nom `operation_a` ou `temps` n'est lié ni transmis (théorème) | `thm:confinement_sortes`, dont l'esquisse couvre « couche 2, tous les cas » |
| Le fil est une chaîne linéaire, sur le fragment `return`, `let`, `tick`, opération mononiveau (proposition) ; « pour `spawn` il ne s'étend pas tel quel » | `thm:chaine_fils` |
| Clause de session indexée par la correspondance `θ` des noms ; deux processus `ℓ`-comparables si leurs journaux `J_k` (`k ⊑ ℓ`) le sont pour le préfixe ; non-interférence graduée « bornée au fragment sans communication » | `eq:relation-sessions-mondes`, `sec:g-sortes` |
| Incertitude n° 6 : le canal ambiant d'une fibrille engendrée « ne peut venir ni du programme ni de la mère » ; il « vient du gestionnaire, par un protocole que le texte ne donne pas » | fin de `sec:g-sortes` |
| Simulation : un pas source donne au moins un pas cible ; clauses seulement pour `return`, `let`, `tick`, opération ; « l'énoncé pourrait y devoir s'entendre `→*` » pour `spawn`, `new`, `try` | `thm:simulation` (proposition), `thm:fidelite_interprete` (conditionnel à Sim) |
| Un calcul n'émet d'événement qu'à un niveau `⊒ niv(Δ)` ; induction non conduite sur la couche 2 | `thm:correspondance_niveaux` (proposition) |
| `ℓ̂(ε)` : borne inférieure des niveaux où `κ` est non nulle ; le facteur temporel est écrit de trois façons | `sec:g-regles` ; `ANOM-18` |
| Déterminisme observationnel : « deux exécutions qui diffèrent par le seul entrelacement ont la même projection » ; `Guard` résiste | `thm:determinisme_observationnel` (conjecture) |
| P4 : en couche 2, rejeu « modulo le journal : l'entrelacement des acteurs est journalisé » | `Postulats` (ch. 1) |

Deux lectures à retenir pour la suite.

* **Il y a deux « journaux ».** Celui de P4 restitue l'entrelacement pour le rejeu ; celui du §4.8 (`J_k`) est le mot des événements reçus par le gestionnaire de niveau `k`, sur lequel porte la projection observationnelle `π^♭_ℓ`. Le texte dit « le journal » pour les deux. Les options ci-dessous ne touchent que le second, sauf `O2c` qui les fusionne.
* **`J_k` est défini comme un mot** (« dans l'ordre où la relation `→` les produit »). Dès que deux fibrilles émettent au même niveau, ce n'est plus un mot que la chaîne détermine : c'est un ordre partiel (un arbre de chaînes sous `O1`), ou bien un mot qui dépend de l'ordonnanceur. Cette phrase de `thm:chaine_fils` est vraie sur son fragment et à reformuler ailleurs.

## 3. Grille : ce que toute option doit tenir

| | Exigence | Source |
|---|---|---|
| `E1` | **confinement** : aucun canal d'effet créé, reçu ni transmis par un programme traduit | `thm:confinement_sortes` |
| `E2` | **linéarité** : chaque maillon est produit une fois et consommé une fois | `thm:chaine_fils` |
| `E3` | **ordre** : l'image reproduit l'ordre partiel de la source, en particulier l'arête « la fille reprend après `ε_spawn` » | `eq:reductions-couche2` |
| `E4` | **pas de fuite par la structure** : la présence d'un marqueur de bifurcation sur le fil de niveau `k` ne dépend pas de données de niveau `⋢ k` | `thm:correspondance_niveaux`, `thm:non_interference` |
| `E5` | **simulation** : un pas source est suivi d'au moins un pas cible, la trace s'étendant de l'image des événements | `thm:simulation` |
| `E6` | **projection définissable** dans la cible : `π^♭_ℓ(J) = (J_k)_{k ⊑ ℓ}` | §4.8 |
| `E7` | **clause de session** : comparaison de journaux sous `θ`, sans notion nouvelle de correspondance si possible | `eq:relation-sessions-mondes` |
| `E8` | **gestionnaire** : le protocole que le texte ne donne pas aujourd'hui, avec l'hypothèse minimale sur l'environnement | incertitude n° 6 |
| `E9` | **portée** : la même solution sert l'application, l'opération à portée et le multiniveau | journal de la séance 32, « ce qui n'a pas été écrit » |
| `E10` | **cohérence avec P3 et P4** : profondeur de la mère inchangée, journal de rejeu non dénaturé | `eq:regles-couche2`, P3, P4 |

## 4. Trois points communs à toutes les options

### 4.1 Les maillons dans un appel (application, opération à portée)

La séance 32 a renoncé aux clauses de traduction de l'application et de l'opération à portée : « elles obligent à faire passer des maillons dans un appel, ce que `tab:capacites` ne permet pas ». Cela se vérifie. Une fonction est une valeur créée à un endroit et appelée à un autre ; les événements de son corps doivent s'inscrire sur la chaîne **de l'appelant**, au moment de l'appel. Le service qui la traduit doit donc recevoir `(t⃗, t⃗')` à l'appel, et `tab:capacites` n'autorise ni l'émission d'un maillon sur un canal de programme (ligne « émettre » : un fil ne transmet que son maillon, un canal de programme ne transmet que des noms de programme) ni sa réception (ligne « recevoir » : « aucun terme traduit ne reçoit un nom de fil »).

L'extension naturelle est de traiter le maillon comme un nom de programme à usage linéaire, de même niveau : émettre et recevoir `⟨maillon, k⟩` sur un canal `⟨prog, ℓ⟩`. Le prédicat actuel demande `niv(t) ⊑ niv(s)` ; un service dont le corps émet à un niveau plus haut que son canal d'appel ne pourrait pas recevoir le maillon de ce niveau. La réparation est la même que pour `O1b` : **n'enfiler que les niveaux que l'effet du corps mentionne** (`lev(ε)`, §5.1) et prendre pour niveau du canal d'appel la borne supérieure de ces niveaux. C'est une lecture, non une règle écrite.

Conséquence pour l'étude : si l'auteur veut l'application et l'opération à portée (il le faut pour `PREUVE-03` hors fragment), l'extension « maillon transmissible sur un canal de programme » est **de toute façon** due. Elle abaisse le coût marginal de `O3b` (§5.3), qui en a besoin ; elle ne change rien à `O1` (qui n'en a pas besoin) ni à `O4`.

### 4.2 La forme du facteur temporel (`ANOM-18`)

Toute option qui doit savoir « à quels niveaux la fille émet » lit `lev(ε)`, l'ensemble des niveaux où l'effet de la fille a un événement. Or `ε_spawn = ⟨spawn, ⟨w(ε), 0⟩⟩` écrit un couple sans indice de niveau, la formule `eq:grammaire-types` écrit `(ℕ∞ × ℕ∞)^ℒ`, et la prose et `thm:temps_mononiveau` écrivent `ℕ∞^ℒ`. Tant que la forme complète n'est pas fixée, `lev(ε)` n'est pas définie et `w(ε)` n'est pas un nombre. Deux conséquences indépendantes du choix de l'option :

* le niveau de l'événement `spawn` (donc le fil sur lequel il s'inscrit) n'est pas déterminé ;
* `ℓ̂(ε_spawn)` n'est pas défini, de sorte que la clause de couplage de `Case` ne contraint pas un `spawn` placé sous un `case` sur une valeur secrète. Un tel programme est sans doute typable sans que la fuite par la présence d'une fibrille (§6, programme `Q`) soit exclue par règle.

**Prérequis de toutes les options sauf `O4a`** : trancher `ANOM-18` (`(ℕ∞ × ℕ∞)^ℒ` est la lecture qui rend `eq:cout-parallele` et `spawn` cohérents). Aucune des options n'est comparable tant que ce point est ouvert ; je les compare en supposant la forme `(ℕ∞ × ℕ∞)^ℒ`.

### 4.3 Dépendance avec l'étude sur `∥`

Un `∥` en entrelacement (voie C de l'étude sœur) se traduit par une bifurcation de chaque fil suivie d'une jointure. `spawn` est la bifurcation sans jointure. Si l'auteur retient l'entrelacement pour `∥`, le mécanisme de `O1` est déjà exigé et `spawn` en hérite ; si `∥` reste en fourche-jointure à grand pas, le choix pour `spawn` est libre. D'où l'ordre conseillé : **étude sœur d'abord**.

## 5. Les options

Notations des esquisses : `ℓs` est le niveau de l'événement `spawn` ; `L = lev(ε_c)` les niveaux de l'effet de la fille `c` ; `z_c` le canal de résultat de la fille, que la mère ne lit pas ; `H_k` le gestionnaire du niveau `k`. Les clauses reprennent la forme de `eq:traduction-fils`.

### 5.1 `O1` : bifurcation par maillon

**Définition.** L'événement `spawn` que la mère émet porte, avec son propre maillon suivant, un maillon créé par elle pour la fille ; le gestionnaire écoute deux chaînes. Le fil devient un **arbre de chaînes**, ce qui est exactement l'ordre partiel que la source donne à `τ` (la fille « reprend après `ε_spawn` »).

Deux réalisations, qui ne se valent pas :

* **`O1a`, un marqueur sur chaque niveau.** La mère émet sur chaque fil `t_k` un marqueur `fork` portant `(t'_k, u_k)`. Uniforme, mais **fuit** : voir `Q` au §6. Écartée.
* **`O1b`, bifurcation dirigée par le type.** Seuls les fils des niveaux de `L` bifurquent ; les autres traversent par transfert, y compris côté fille.

```
⟦spawn c⟧_{z,t⃗,t⃗'} =
  (ν z_c)(ν (u_k, u'_k)_{k∈L}) (
      t̄_{ℓs}⟨ε_spawn, t'_{ℓs} [, u_{ℓs} si ℓs ∈ L]⟩
    | ∏_{k∈L, k≠ℓs} t̄_k⟨fork, t'_k, u_k⟩
    | ∏_{k∉L, k≠ℓs} [t_k ↔ t'_k]
    | ⟦c⟧_{z_c, ū, ū'}                -- ū_k, ū'_k reliés par [ū_k ↔ ū'_k] pour k ∉ L
    | z_c(_).𝟎 | z̄⟨()⟩ )
```

Le gestionnaire offre deux branches : `ev` (reçoit `e, t'`, continue sur `t'`) et `fork` (reçoit `e, t', u`, continue sur `t'` **et** sur `u`). C'est du branchement de session (`x ▷ {ℓ_i : P_i}`), déjà dans `eq:metalangage`.

**Règles de réduction.** Aucune règle source ne change. À expliciter seulement ce que « reprenant après `ε_spawn` » demande : une configuration qui retient, pour chaque fibrille, son dernier événement (`λ(q) := ε_spawn` à la création). Le texte l'a implicite dans `τ ◁_p e`.

**Sortes.** Aucune ligne de `tab:capacites` ne change : chaque maillon transmis l'est le long d'un fil, au même niveau (ligne « émettre », seconde alternative), `u_k` et `t'_k` de sorte `⟨maillon, k⟩`, créés par restriction (`𝒮_ν ∋ maillon`). L'émission passe de un à deux maillons : le texte écrit déjà le couple `⟨ε, t'⟩`, mais la grammaire `eq:metalangage` n'a pas d'émission polyadique ; il faut l'écrire comme une suite de transmissions sur une session `E ⊗ M ⊗ M`, les capacités s'appliquant nom par nom.

**Ce qu'elle impose.**

* `thm:chaine_fils` s'étend à un arbre : « consommé exactement une fois, produit exactement une fois » tient (la fille reçoit `u_k`, le bout de sa chaîne `u'_k` reste, comme le `t'_k` du programme principal, sans émetteur). L'énoncé « le mot `J_k` est la suite des événements dans l'ordre de `→` » devient « `J_k` est une forêt de chaînes ».
* `J_k` n'est plus un mot ; `π^♭_ℓ` reste « restriction aux niveaux `k ⊑ ℓ` » (`E6`).
* La clause de session compare des forêts « pour le préfixe » : une définition à écrire (sous-forêts clos vers le bas, ou chaîne par chaîne sous `θ`). La chaîne de la fille est un **nom** (un maillon) : `θ` l'embarque sans notion nouvelle, par la règle existante « chaque canal créé au même point entre dans `θ` par sa paire de noms frais » (`E7`).
* `thm:simulation` : l'émission de `ε_spawn` est une communication avec le gestionnaire, donc le cas `spawn` est bien un `→⁺` : **la question « `→⁺` ou `→*` » est réglée pour `spawn`** (elle reste ouverte pour `new` et `try`).
* Le gestionnaire doit être spécifié (c'est un prérequis de toutes les options, §3 `E8`), ici dans sa version qui bifurque.

**Ce qu'elle ne casse pas.** `thm:confinement_sortes` garde son énoncé (le maillon n'est pas un canal d'effet), et la phrase de son esquisse « un maillon ne se transmettant que le long d'un fil » reste vraie : le marqueur et le maillon de la fille voyagent bien le long d'un fil, au même niveau. `thm:cloture_sortage` : les clauses ne portent que sur des sortes de noms, inchangées.

**Condition de correction (`E4`).** Pourquoi `O1b` ne fuit pas : tout événement de la fille est de niveau `⊒ niv(Δ)` par `thm:correspondance_niveaux`, donc `L ⊒ niv(Δ)`, donc les marqueurs ne tombent que sur des fils de niveau `⊒ niv(Δ)`, que seuls voient les observateurs qui lisent déjà `niv(Δ)`. **Cet argument repose sur `thm:correspondance_niveaux` pour la couche 2, dont l'induction n'est pas conduite**, et sur `ANOM-18` (sans niveau pour `ε_spawn`, `ℓs` est libre).

**Coût de preuve** (S : un cas d'induction ou un lemme local ; M : plusieurs cas ou une définition neuve avec ses propriétés ; L : une induction sur plusieurs règles ou la réécriture d'un énoncé scellé).

| Poste | |
|---|---|
| trancher `ANOM-18`, définir `lev` | M, commun |
| clause de `spawn` et son bon sortage | S + S |
| polyadique : suite de transmissions | S |
| gestionnaire à deux branches, spécifié | M |
| `J_k` forêt, `π^♭` sur forêts | M |
| `thm:chaine_fils` pour l'arbre | M |
| comparaison de forêts dans la clause de session | M |
| clause de `spawn` de la simulation | S |
| lemme « marqueurs de niveau `⊒ niv(Δ)` » | M, dépend de `thm:correspondance_niveaux` (couche 2) |
| esquisse de `thm:confinement_sortes` : relecture | S |

Total : **M à L**, **aucun énoncé scellé modifié**.

**Risques.** (i) `thm:correspondance_niveaux` non démontré sur la couche 2 (la correction de `O1b` en dépend). (ii) Le nombre de gestionnaires croît avec les bifurcations (une instance par maillon de fille) : une borne mémoire à écrire, sinon P3 (aucun coût caché) est touché. (iii) Les bouts de chaîne des filles restent en attente indéfiniment, comme celui du programme principal : sans conséquence si le gestionnaire est une instance répliquée, à dire. (iv) La profondeur : sur l'ordre partiel, la chaîne qui traverse l'arête de `spawn` (préfixe de la mère, `ε_spawn`, événements de la fille) peut être plus longue que la profondeur annotée pour la mère (`⟨w(ε), 0⟩`). Si « chaîne » dans `thm:preservation` désigne tout chemin de l'ordre, l'énoncé est faux pour la profondeur ; il faut le lire **par fibrille** (c'est le sens de « le chemin critique de celui qui l'engendre », `sec:g-couche2`) ou charger `s(ε)` à `spawn`. Ce point est indépendant de l'option, `O1` le rend visible.

### 5.2 `O2` : fil hérité (la fille émet sur la chaîne de la mère)

**Définition.** Voie C de l'instruction : la fille n'ouvre pas de chaîne. Trois lectures.

* **`O2a`, partage littéral.** Deux producteurs sur un maillon. Chaque maillon est à usage unique (`E2`) : la seconde émission ne se lie jamais, un des deux fils reste bloqué. Impossible tel quel. Écartée.
* **`O2b`, relais en ligne.** La mère passe son maillon à la fille, qui le rend à sa fin. Les événements de la fille s'inscrivent avant la suite de la mère : c'est une séquentialisation du journal. Or la fille peut attendre un message que la mère n'enverra qu'après : la traduction **introduit un blocage que la source n'a pas**, ce qui détruit la simulation (`E5`). Écartée.
* **`O2c`, chaîne partagée avec arbitre.** Chaque fibrille garde sa propre chaîne (comme `O1`), et le gestionnaire **fusionne** les chaînes en un mot par ordre d'arrivée. `J_k` redevient un mot, total.

**`O2c` est `O1` plus un journal d'arrivée.** Tout ce qui est dit de `O1` vaut, plus :

* `J_k` dépend de l'ordonnanceur. `π^♭_ℓ(J)` aussi. La clause de session ne peut plus dire « comparables pour le préfixe » sans quantifier sur les entrelacements ou supposer `𝒟_𝒮` (l'hypothèse du `thm:determinisme_observationnel`, conjecture). Le texte note déjà que « l'ordonnanceur entre dans le modèle d'attaquant » (`sec:c2-le-systeme-de-raffinement`, après `thm:non_interference`).
* En contrepartie, `J_k` est un journal de **rejeu** (P4 dit que « l'entrelacement des acteurs est journalisé ») : les deux journaux du §2 se confondent.
* Coût : coût de `O1` + fusion au gestionnaire (S) + définition de la comparaison sous entrelacement (M à L).

**Risques.** Fuite par l'ordre d'arrivée si l'ordonnanceur consulte des valeurs hautes ; le journal total est le journal le plus bavard.

### 5.3 `O3` : fil indépendant, fourni par le gestionnaire

**Définition.** Voie B de l'instruction : la fille reçoit du gestionnaire une chaîne neuve par un protocole de demande sur le fil de la mère. Sa chaîne n'est **pas** prolongée depuis celle de la mère dans la traduction ; c'est le gestionnaire qui sait que la fille descend de l'événement `spawn`.

Trois réalisations.

* **`O3a`, la fille reçoit un canal `temps`.**

  ```
  ⟦spawn c⟧ = (ν r)( t̄_{ℓs}⟨ε_spawn, t'_{ℓs}, r⟩ | ∏_{k≠ℓs}[t_k ↔ t'_k]
                   | r(ū).⟦c⟧_{z_c,ū,ū'} | z_c(_).𝟎 | z̄⟨()⟩ )
  ```

  Il faut qu'un fil transmette un nom de programme `r` et qu'un canal de programme **reçoive** un nom de genre `temps`. L'énoncé de `thm:confinement_sortes` (« aucun n'est lié ») devient faux : un nom `temps` est lié par la réception. C'est un **théorème scellé** : le modifier demande l'accord de l'auteur ([règles de rédaction](../../.claude/skills/writing-rules.md), §10). Coût `L` et un énoncé réécrit.
* **`O3b`, la réponse porte des maillons.** Même clause, mais `r` livre des maillons (genre `maillon`) : `thm:confinement_sortes` garde son énoncé. Deux lignes de `tab:capacites` changent (émettre : un fil peut porter un nom de programme ; recevoir : un canal de programme peut recevoir un maillon), et la phrase de l'esquisse sur « un maillon ne se transmettant que le long d'un fil » est fausse. Le gestionnaire du niveau `ℓs` doit créer les chaînes de **tous** les niveaux de `L` : soit il demande aux autres gestionnaires (communication entre gestionnaires, non écrite), soit la mère émet une demande sur chacun (on retrouve la question des marqueurs de `O1a` et sa fuite, avec la même parade `O1b`). Une hypothèse neuve : **le gestionnaire répond toujours** (progrès de l'environnement), à consigner dans `hypotheses-de-module.md`. Si l'extension du §4.1 est de toute façon faite, le coût propre à `O3b` est celui du protocole.
* **`O3c`, adresses statiques.** La configuration instancie à l'avance un gestionnaire par site de `spawn` ; la fille est traduite avec des noms `temps` **libres** indexés par l'adresse (rien n'est lié ni transmis : `E1` tient). Valable si le nombre de `spawn` est borné statiquement ; faux dès qu'un `spawn` est sous une boucle ou dans un flux coinductif, ce qui est le cas typique d'un acteur qui engendre par message. Il faudrait une condition de typage neuve (un grade qui borne les engendrements).

**Ce qu'`O3` impose.** Le gestionnaire détient l'arbre : bon pour cacher la structure aux programmes, mais la correspondance `θ` doit alors s'étendre à des noms **créés par l'environnement** (la chaîne reçue), pas seulement par les deux exécutions au même point. La clause de session y gagne un cas. `thm:chaine_fils` s'étend à une forêt de chaînes **plus** une relation de filiation tenue par le gestionnaire. La simulation : le cas `spawn` est un `→⁺` (émission de la demande).

| Poste (`O3b`) | |
|---|---|
| deux changements de `tab:capacites` et de l'esquisse du confinement | S + S |
| protocole de demande et d'inter-gestionnaires | M à L |
| hypothèse « le gestionnaire répond toujours » | S, consignée |
| `θ` étendue aux noms de l'environnement | M |
| `J_k`, `thm:chaine_fils`, comparaison de forêts | M + M + M, comme `O1` |

Total : **L** pour `O3b`, **L et un énoncé scellé** pour `O3a`, **M plus une condition de typage neuve** pour `O3c` dans son périmètre.

**Risques.** Deux changements de capacités où `O1` n'en change aucun ; un protocole que le texte ne contient pas ; la tentation d'élargir `θ` à toute l'environnement.

### 5.4 `O4` : ne pas traduire le fil de la fille

* **`O4a`, dire le périmètre.** `thm:simulation`, `thm:chaine_fils` et la clause de session valent pour les configurations dont la traduction est écrite (aujourd'hui `return`, `let`, `tick`, opération). `spawn` n'est pas traduit ; le texte le dit déjà (`tab:couverture-reductions` : schéma écrit, pas de clause de traduction). Coût nul. La conséquence est que `BLOQ-07` reste « conditionnel à Sim » et que la non-interférence graduée reste bornée au fragment sans communication, ce qu'elle est.
* **`O4b`, interdire `spawn` là où le temps est revendiqué.** Une condition de bord sur `Spawn` ou, dans l'esprit du §6.1 (« une unité `ℓ`-sensible n'admet que les passes `P_trace(ℓ)` »), une règle d'interaction : pas de `spawn` dans une unité `ℓ`-sensible. Coût `S` à `M` (une condition, et la définition de « `ℓ`-sensible » au niveau du typage, qui n'existe qu'en prose). Elle **règle** la fuite de `Q` par interdiction plutôt que par traduction, au prix d'un langage où la concurrence engendrée et le temps observable ne se mêlent pas.
* **`O4c`, fille sans événement temporel.** `spawn c` n'est admis que si `lev(ε_c) = ∅` (la fille ne fait aucun `tick`). La fille n'a plus besoin de chaîne. Sans intérêt : la règle `Spawn` écrite pour provisionner `w(ε)` perd son objet.

**Risques.** `O4a` laisse la décision à plus tard sans l'oublier : le prix est de garder deux preuves partielles (`PREUVE-03` et `PREUVE-07`) tant que `spawn` n'est pas couvert, et de ne pas pouvoir écrire `thm:chaine_fils` pour la couche 2.

## 6. Exemples

**Programme `P`** (un seul niveau `⊥`, pour lire la forme des journaux) :

```
let _ ← tick in let _ ← spawn (let _ ← tick in tick) in let _ ← tick in return ()
```

Source : `m₁ ≺ s ≺ m₂`, `s ≺ c₁ ≺ c₂` (`m` : événements de la mère, `s` : `ε_spawn`, `c` : ceux de la fille).

| Option | `J_⊥` |
|---|---|
| `O1b` | arbre : `m₁ → s ⟨fork⟩ → { m₂ ; c₁ → c₂ }` |
| `O2c` | mot d'arrivée, par exemple `m₁ s c₁ m₂ c₂` ou `m₁ s m₂ c₁ c₂` selon l'ordonnanceur |
| `O3b` | deux racines : `m₁ → s → m₂` et `c₁ → c₂`, plus la filiation `s ▷ racine(fille)` tenue par le gestionnaire |
| `O4a` | `m₁ → s → m₂` (la fille n'a pas de fil traduit) |

**Programme `Q`** (deux niveaux `⊥ ⊑ H`, un secret `s :_r Bool` avec `niv(r) = H`) :

```
case s of { 0 ↦ spawn (tick_H) ; 1 ↦ return () }
```

Lecture : `ε_spawn` est étiqueté `H`, ce que la clause de couplage de `Case` exige si `ℓ̂(ε_spawn)` est défini (`ANOM-18`). Source : `π^♭_⊥(τ)` est vide dans les deux branches : la non-interférence en `⊥` tient.

* `O1a` : pour `s = 0`, un marqueur `fork` est reçu sur `t_⊥`, donc `J_⊥ ≠ ∅` ; pour `s = 1`, `J_⊥ = ∅`. **La non-interférence en `⊥` est fausse de la traduction.**
* `O1b` : `L = {H}` ; le fil `⊥` traverse par transfert dans les deux branches ; `J_⊥ = ∅` dans les deux. Tient, sous `thm:correspondance_niveaux` et `ANOM-18`.
* `O3b` : même parade nécessaire (ne demander une chaîne qu'aux niveaux de `L`).
* `O4b` : `Q` n'est pas admis dans une unité `⊥`-sensible.

## 7. Tableau comparatif

| | `O1b` bifurcation dirigée | `O2c` partagé arbitré | `O3a` fourni, `temps` | `O3b` fourni, maillons | `O3c` adresses statiques | `O4a` périmètre | `O4b` interdire |
|---|---|---|---|---|---|---|---|
| `E1` confinement | tient, énoncé intact | tient | **énoncé réécrit** | tient | tient | tient | tient |
| `E2` linéarité | tient | tient | tient | tient | tient | sans objet | sans objet |
| `E3` ordre partiel | exact (arbre) | perdu (mot) | par le gestionnaire | par le gestionnaire | par adresse | non traité | non traité |
| `E4` pas de fuite | sous `thm:correspondance_niveaux` | sous `𝒟_𝒮` | idem `O1b` | idem `O1b` | tient (statique) | non traité | par interdiction |
| `E5` simulation | `→⁺` acquis pour `spawn` | idem | idem | idem | idem | hors périmètre | hors périmètre |
| `E6` projection | oui | oui, dépend de l'ordonnanceur | oui | oui | oui | sans objet | sans objet |
| `E7` clause de session | `θ` suffit | à quantifier | `θ` étendue à l'environnement | idem | `θ` suffit | inchangée | inchangée |
| `E8` gestionnaire | deux branches | + fusion | protocole | protocole + hypothèse de réponse | instances statiques | inchangé | inchangé |
| `E9` application et portée | indépendant | indépendant | demande le §4.1 | demande le §4.1, le rend utile | indépendant | sans objet | sans objet |
| `E10` P3, P4 | P3 : borne mémoire à écrire | P4 : un seul journal | P3 idem | idem | P3 : borne statique | tient | tient |
| Capacités modifiées | aucune | aucune | deux | deux | aucune | aucune | aucune |
| Énoncé scellé modifié | non | non | **oui** | non | non | non | non |
| Coût | M à L | L | L+ | L | M + condition neuve | nul | S à M |

## 8. Avis, et conditions de révision

**Avis (non décision).**

1. **`O1b` est l'option la moins invasive qui couvre `spawn`.** Elle ne modifie aucune ligne de `tab:capacites`, laisse `thm:confinement_sortes` intact, reproduit l'ordre partiel de la source (`E3`), fait entrer la chaîne de la fille dans `θ` sans notion nouvelle (`E7`) et règle `→⁺` pour `spawn`. Son prix est de redéfinir `J_k` (mot, puis forêt) et de spécifier un gestionnaire qui bifurque.
2. **Quatre conditions**, sans lesquelles l'avis tombe : (i) `ANOM-18` tranchée sous la forme `(ℕ∞ × ℕ∞)^ℒ` ; (ii) l'auteur accepte que `J_k` soit un ordre partiel ; (iii) `thm:correspondance_niveaux` est démontrée sur la couche 2, car la correction de `O1b` en dépend ; (iv) le gestionnaire est spécifié, avec une borne sur ses instances.
3. **`O4a` est un état d'attente légitime**, pas un renoncement : coût nul, rien de scellé n'en dépend, `O1b` reste possible ensuite. Si l'auteur ne veut pas trancher avant d'avoir décidé `∥`, c'est l'attitude à tenir.
4. **Écarter** : `O2a` et `O2b` (impossibles ou infidèles), `O1a` (fuite), `O4c` (sans objet). `O3a` n'a de sens que si l'auteur accepte de réécrire `thm:confinement_sortes`.

**Conditions de révision.**

* Si l'auteur retient l'entrelacement pour `∥` : `O1b` devient quasi obligatoire (même mécanisme, plus une jointure) ; réviser dans ce sens.
* Si l'application et l'opération à portée sont décidées avec l'extension « maillon transmissible sur un canal de programme » (§4.1) : le coût marginal de `O3b` baisse ; refaire la comparaison `O1b` contre `O3b` (la question devient « qui détient l'arbre : le programme ou le gestionnaire ? »).
* Si `thm:correspondance_niveaux` échoue sur la couche 2 : `O1b` perd sa correction ; replier sur `O4b`.
* Si l'on veut un seul journal pour l'observation et pour le rejeu de P4 : examiner `O2c`.
* Si une borne statique des engendrements devient un grade du langage : `O3c` devient viable.
* Si la lecture du corps de la machine à sessions désignée au ch. 4 (non faite, §9) montre que l'entrelacement du métalangage y est fixé par une stratégie séquentielle déterministe : réexaminer `O2c`, dont le journal total serait alors déterministe par construction.

## 9. Niveau de vérification et ce qui reste à faire

**Faits sur le manuscrit.** Vérifiés dans le dépôt à la date de rédaction : chaque label cité existe, les énoncés sont cités d'après leur texte.

**Esquisses de traduction, coûts, constats de fuite.** Raisonnements du rédacteur sur le texte du manuscrit ; **aucune** vérification mécanique, aucune preuve. Les coûts `S`, `M`, `L` sont des estimations non mesurées.

**Sources externes.** Les pages des éditeurs et d'arXiv sont inaccessibles depuis la session (vérifié par requête : aucune réponse). Rien ci-dessus ne s'appuie sur un article relu pour cette étude. Sont cités uniquement ce que le dépôt contient :

| Œuvre | Ce qui en est dit ici | Niveau de vérification |
|---|---|---|
| Das, Hoffmann, Pfenning (2018), `dasParallelComplexityAnalysis` | traite de la complexité parallèle avec des types de session temporels ; **à lire avant de trancher** pour voir comment un processus engendré est compté | titre et notice de `biblio/references.json`, note du corpus (`docs/recherche/corpus.md`) ; corps non relu ici |
| Caires et Toninho (2026), `cairesLinearSessionAbstract2026` | machine à sessions linéaires, stratégie séquentielle déterministe d'après le manuscrit ; sa gestion de l'entrelacement n'est pas connue | citation du manuscrit (`sec:g-semantique`, `sec:c4-le-calcul-de-processus`) ; corps non relu ici |
| Fournet et Gonthier (1996), `fournetReflexiveCHAMJoincalculus1996` | motifs de jonction et sortes du calcul cible (gestionnaire en motif de jonction) | citation du manuscrit ; corps non relu ici |
| Stefan et al. (2012), `stefanAddressingCovertTermination2012` | placer les actions à durée dépendante de valeurs secrètes dans des fils séparés, étiquetés ; piste pour `O4b` | note du corpus (« lu partiel » au fonds) ; corps non relu ici |
| Borgström et al. (2016), `borgstromSortedSemanticFramework2016` | cadre de sortes emprunté (conditions d'équivariance, incertitude n° 5) | citation du manuscrit ; corps non relu ici |

**À faire, dans l'ordre.** (1) Trancher `ANOM-18`. (2) Lire Das, Hoffmann et Pfenning sur le traitement d'un processus engendré. (3) Écrire le gestionnaire (`E8`), quelle que soit l'option. (4) Conduire l'induction de `thm:correspondance_niveaux` sur la couche 2. (5) Seulement alors, écrire la clause de `spawn` et étendre `thm:chaine_fils`.
