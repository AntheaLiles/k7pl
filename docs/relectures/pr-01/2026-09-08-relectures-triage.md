# Les trois relectures — vérifiées une à une

8 septembre 2026. J'ai lu les trois dans l'ordre que tu donnes, puis j'ai
**vérifié chaque grief sérieux contre la source**, parce qu'une relecture ne
vaut que ce que le texte confirme.

Résultat : **quatre défauts réels et graves**, une convergence qui règle un
point ouvert ce matin, deux faux positifs à écarter avec leur preuve, et une
contradiction entre deux relecteurs qu'il te revient de trancher.

---

## 0. Ce qu'il faut savoir avant de les lire

**Ils ont lu un PDF, et ce PDF est périmé.** GPT annonce 282 pages ; Gemini
signale des `??` à l'index, des `\ref` non développés, et des séquences `92ref`
et `94=`. Ce sont les symptômes exacts de la compilation cassée que nous avons
réparée aujourd'hui — l'`.aux` corrompu, les légendes sur blocs export. Le
dernier assemblage n'en porte plus aucun.

Conséquence : **tout leur axe 4 est déjà traité**, et les `92ref` / `94=` sont
en outre des artefacts d'extraction de leur côté, non des chaînes de la source.
Ne dépense rien là-dessus.

**Ce qui compte davantage, et qui n'est pas à leur crédit ni au nôtre :** trois
des défauts qu'ils trouvent sont d'une nature que `make controle` ne peut pas
voir, parce que nos contrôles vérifient la *cohérence interne* du document et
jamais la *justesse d'une affirmation mathématique*. C'est la vraie leçon.

---

## 1. La convergence, et elle règle B

**GPT trouve, par un chemin entièrement différent du mien, le défaut de ℛ.**

Sa section 1.2 : ℛ est défini comme ℚ≥0 ∪ {ω} parce que les grades
fractionnaires sont nécessaires, puis le document affirme que ℛ « est le type
des conaturels ℕ∞ ». Il écrit : « Ce n'est pas un problème de vocabulaire. »

Et Gemini, sans le dire, en apporte la troisième voix : sa formalisation Lean 4
code ℛ **comme des conaturels** — `inductive Conat | fin : Nat | top` — et
titre son diagramme de dépendances « Algèbre pure sur ℕ∞ ». Un relecteur qui
implémente le manuscrit a implémenté ℕ∞, pas ℚ≥0.

Ce matin, j'étais arrivé au même endroit par les types dimensionnés : l'ordre
strict sur ℚ≥0 n'est pas bien fondé (1 > 1/2 > 1/4 > …), alors que les deux
théorèmes de progression invoquent « la bien-fondation de l'ordre sur les
tailles ».

**Trois chemins, un seul défaut.** Le lemme d'épreuve 1 de l'analyse B n'est
plus une proposition à éprouver : c'est une correction que trois lecteurs
indépendants réclament. GPT recommande de séparer ℛ_usage = ℚ≥0 ∪ {ω} des
indices ℕ∞ ; c'est exactement ma clause de bonne formation, écrite de l'autre
côté.

**Cela valide B-b sans réserve** et rend la correction obligatoire, plus
seulement opportune.

---

## 2. Le défaut le plus grave, et il est vérifié mot pour mot

**GPT 1.1 — la catégorie de co-Kleisli graduée n'est pas une catégorie.**

Le chapitre 2 écrit, et j'ai relu la phrase à la source :

> « Hom_{𝒞_{!_r}}(A,B) := Hom_𝒞(!_r A, B) ; **l'identité n'existe qu'en r = 1**,
> où elle est ε_A. La composition de f : !_r A → B avec g : !_s B → C produit un
> morphisme de **𝒞_{!_{r×s}}**. »

Une catégorie a une identité par objet et une composition interne. Celle-ci n'a
ni l'une ni l'autre. **Le manuscrit décrit correctement l'objet et lui donne le
mauvais nom.**

Ce n'est pas une chicane de vocabulaire : le document appuie sur ce mot une
famille d'énoncés, et un pair qui tente de reproduire s'arrêtera à la première
ligne. Le bon nom est une **structure de Kleisli graduée** — une famille de
hom-ensembles indexée par le monoïde des grades.

**Le coût de la correction est faible et le gain est large.** GPT note qu'une
quarantaine de paragraphes cessent de reconstruire une catégorie à chaque grade
pour parler d'une seule structure. Et le cas cartésien r = ω reste, lui, une
vraie catégorie — c'est déjà ce que le manuscrit dit de Δ_ω.

---

## 3. Les trois autres défauts vérifiés

### 3.1 BLAKE3 « sans collision » — trois erreurs en une phrase *(GPT 9)*

Le chapitre 4 écrit : « L'arène en calcule un hachage cryptographique (BLAKE3),
déterministe et **sans collision**, qui réduit l'égalité structurelle et la
déduplication à une comparaison d'entiers en O(1). »

Trois choses sont fausses, et un cryptographe les verra toutes :

1. Un hachage cryptographique n'est pas sans collision — il est *résistant aux
   collisions*. L'injectivité est impossible : le domaine est infini, l'image
   finie.
2. Le calcul du hachage sur une structure de taille n n'est pas en O(1). C'est
   la *comparaison de deux condensats déjà calculés* qui l'est.
3. `hash(x) = hash(y)` n'entraîne pas `x = y` sans hypothèse cryptographique
   déclarée.

Et le chapitre 6 aggrave : le binaire adressé par le hachage de son AST
normalisé « identifie deux programmes syntaxiquement distincts mais
**sémantiquement équivalents** ». Un hachage d'arbre normalisé décide l'égalité
*syntaxique canonique*. L'équivalence sémantique n'est pas décidable.

**C'est le genre d'affirmation qui coûte cher au crédit du reste**, parce
qu'elle est fausse d'une façon que le lecteur vérifie sans effort.

### 3.2 Le graphe statique ne borne pas le graphe d'attente *(GPT 6)*

Le théorème s'appelle `thm:deadlock_acyclique`, « absence de deadlock par
acyclicité du graphe de sessions », et énonce :

> « Si le graphe de dépendances G des acteurs et canaux est acyclique […], **la
> phase d'initialisation** atteint un état entièrement câblé sans interblocage :
> Acyclique(G) ⟹ ∃ un tri topologique. »

**L'énoncé est plus étroit que son nom.** Il porte sur l'initialisation ; le nom
promet l'absence d'interblocage. Or le manuscrit distingue lui-même les
dépendances de construction des dépendances d'attente, et l'acyclicité des
premières n'entraîne pas celle des secondes.

Il manque l'invariant de simulation que GPT écrit exactement :

> `wait_edge(a,b) ⟹ dependency_edge(a,b)`, d'où `G_dep acyclique ⟹ G_wait acyclique`.

Deux issues : ajouter ce lemme, ou renommer le théorème pour qu'il ne promette
que ce qu'il établit. La seconde coûte un mot ; la première vaut le théorème
que le nom annonce.

### 3.3 Γ reparaît dans trois jugements *(Gemini 1.1, et Claude le note)*

Le §1.4 pose : « Ce jugement porte une seule zone de contexte […] Le symbole Γ
reste employé au sens générique […] **jamais comme zone du jugement**. »

Comptage à la source : **trois occurrences de `\Gamma \vdash`**, deux au
chapitre 2, une au chapitre 3 — dont la préservation :

> `\(\Gamma \vdash t : \tau \land t \leadsto t' \implies \Gamma \vdash t' : \tau\)`

Le chapitre 2 a une excuse — « un jugement Γ ⊢ t : T n'est rien d'autre qu'un
morphisme t : Γ → T de /C/ » est bien l'emploi catégorique autorisé. La garantie
de gradualité statique et la préservation n'en ont aucune.

**C'est le seul des quatre défauts qu'un contrôle attrape**, et c'est pour cela
que je le mets en dernier : trois lignes de `controles/source.py` le ferment
pour toujours.

---

## 4. Deux faux positifs, avec leur preuve

Je les écarte parce qu'un relecteur qui a tort sur deux points affaiblit les
vingt sur lesquels il a raison, et parce que tu perdrais du temps à les traiter.

### GPT 12 — « les théories sont décidables mais pas leur combinaison »

Il présente cela comme une incohérence. Le manuscrit écrit :

> « Toutes sont décidables, ce qui fonde l'argument de terminaison de la
> Phase 5 ; leur combinaison ne l'est pas nécessairement, **et le document ne
> caractérise pas le fragment sur lequel il se restreint**. »

**La dette est déclarée dans la phrase même.** Ce n'est pas une contradiction,
c'est une réserve — et le document sait écrire ainsi. L'*action* que GPT propose
reste bonne (nommer 𝒯₀ ⊆ 𝒯_K7PL et dire ce qu'on rejette), mais elle est à
ranger avec les engagements, non avec les erreurs.

### GPT 10 — le théorème sur Arrow et Cap'n Proto « trop fort »

Il propose de le restreindre « pour un scalaire primitif fixe T, sous hypothèses
explicites ». Le manuscrit énonce déjà :

> « **Soit T un type scalaire primitif de largeur fixe.** Alors les trois
> dispositions suivantes coïncident bit à bit »

et ajoute que « trois nombres la déterminent pour un type donné — la largeur de
créneau, l'alignement… ». **L'hypothèse qu'il réclame est la première ligne de
l'énoncé.** Ce qu'il ajoute légitimement, et c'est mince : dire l'endianness, et
dire « hors métadonnées ».

---

## 5. Ce qui te revient à trancher

### 5.1 Les deux relecteurs se contredisent sur ! et □

| | Ce qu'il propose |
|---|---|
| **GPT** | garder `!_r` pour la ressource, `Sec_ℓ` pour la sécurité, `○ □_t ◇_t` pour le temps — parce que **□ porte aujourd'hui trois foncteurs différents** |
| **Gemini** | remplacer partout `!_r` par `□_r`, la modalité graduée générale portant ⟨u,m,ℓ,β⟩ |

**Ils ont vu le même fait et en tirent l'inverse.** Le fait est réel : □ sert
à la ressource (□_r), à la confidentialité et au temps (○, □, ◇).

Mon avis, et il penche du côté de GPT. `!` est le glyphe de l'exponentielle en
logique linéaire depuis Girard : un pair le lit sans apprendre. □ est le glyphe
de la nécessité en logique modale, et c'est ce qui rend son emploi temporel
naturel — donc c'est le temps qui a le meilleur titre sur □, pas la ressource.
Unifier vers □_r, comme Gemini le veut, résout une collision en en créant une
plus grave.

Mais Gemini a raison sur un point qu'il ne souligne pas : **le manuscrit emploie
déjà les deux**, `!_r` aux §2.2 et `□_r` en annexe E. Quelle que soit ta
décision, l'un des deux doit disparaître.

### 5.2 Trois modes ou quatre ? *(Claude C3, et GPT 1.3 y touche)*

Vérifié : le manuscrit écrit « il y en a trois — Lin, Aff, Unr — reliés par une
**chaîne** de morphismes », avec un théorème `thm:morphismes_modes` nommé « la
chaîne modale est une chaîne de morphismes de modes ». Et plus loin : « La
quatrième combinaison — la logique dite relevante — n'est instanciée par aucune
modalité de K7PL. »

**Il n'y a pas de contradiction, il y a une imprécision.** La construction
engendre quatre modes ; K7PL en instancie trois ; ces trois forment une chaîne
qui est le fragment totalement ordonné d'un treillis à quatre. Le mot « chaîne »
n'est pas faux — il est vrai du fragment instancié. Une phrase le dirait.

---

## 6. Ce que ces relectures valident, et c'est agréable à écrire

**Gemini corrige la règle `When` exactement comme A1.** Sa section 3.2 :

> « La règle actuelle autorise un contexte Δ₂ arbitraire lors de l'attente d'un
> événement ◇V. Correction : insérer la condition de report temporel sur le
> contexte : `Δ₁ ⊠₁ (□_t Δ₂) ⊢ when x = v in c : ◇C | ε[ω/k]` »

C'est la décision A1 rendue ce matin — introduire la duale de ◇ et poser la
contrainte sur le contexte — et Gemini nomme la duale `□_t`, ce qui est le nom
que j'ai proposé. **Un relecteur indépendant a retrouvé la correction et sa
forme.** A1 n'est plus un pari.

De même, `thm:progression_polarisee` : les deux relecteurs veulent fusionner les
théorèmes 1, 3 et 4, et la réécriture de Gemini garde la preuve « par
bien-fondation de l'ordre sur les tailles […] types dimensionnés ». Ils
confirment l'un et l'autre que **la taille dimensionnée est déjà le mécanisme
du manuscrit** — le fondement de B-b.

---

## 7. La leçon pour l'outillage, et c'est la partie inconfortable

Nos trente contrôles n'ont trouvé aucun des quatre défauts, sauf Γ. Ils tiennent
la cohérence interne : étiquettes, renvois, citations, croisement grammaire /
règles. **Ils ne vérifient jamais qu'une affirmation est vraie.**

Trois seulement sont mécanisables, et ce sont les trois à écrire :

| | Contrôle | Ce qu'il ferme |
|---|---|---|
| 1 | `\Gamma \vdash` interdit hors du chapitre 2 | Γ résiduel — *3 occurrences aujourd'hui* |
| 2 | un seul glyphe pour la modalité de ressource | la collision `!_r` / `□_r`, une fois la 5.1 tranchée |
| 3 | vocabulaire interdit : « sans collision », « injectif » à moins de 200 signes d'un hachage | l'affirmation cryptographique trop forte |

Le quatrième — « ce mot désigne-t-il le bon objet mathématique ? » — n'est pas
mécanisable. Il demande un relecteur. **C'est précisément ce que ces trois
relectures viennent de faire, et c'est leur valeur : elles trouvent ce que le
harnais ne peut pas trouver.**

---

## 8. L'ordre dans lequel je traiterais

| | Quoi | Pourquoi d'abord |
|---|---|---|
| 1 | **ℛ : séparer les grades des tailles** | trois lecteurs indépendants, et cela ferme B |
| 2 | **𝒞_{!_r} : structure de Kleisli graduée** | erreur formelle nue, visible dès la première ligne |
| 3 | **BLAKE3** | faux, et vérifiable sans effort par le lecteur |
| 4 | **`thm:deadlock_acyclique`** | soit le lemme de simulation, soit le renommage |
| 5 | **Γ résiduel** | trois lignes de contrôle, et c'est clos pour toujours |
| 6 | 5.1 et 5.2, une fois que tu auras tranché | dépend de toi |

Les factorisations qu'ils proposent tous les trois — théorèmes 1/3/4 fusionnés,
loi de cohérence φ/ψ posée une fois, procédé de gradation écrit une fois — sont
justes et convergentes, mais **elles allègent sans corriger**. Elles viennent
après.
