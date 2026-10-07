# K7PL — Plan de correction consolidé issu des six peer-reviews (PR-02)

**Manuscrit évalué :** `main.pdf`, 285 p., daté 2026-09-09 (LuaHBTeX / TeX Live 2025).
**Rapports intégrés :** `K7PL_PR_02_QWEN.md`, `K7PL_PR_02_CLAUDE.docx`, `K7PL_PR_02_GPT.md`, `K7PL_PR_02_FLASH.docx`, `K7PL_PR_02_DEEPSEEK.md`, `K7PL_PR_02_GEMINI.md`.
**Établi le :** 2026-09-14. **Révision 2** : arbitrages `ARB-PR-01`, `ARB-PR-02` et `ARB-PR-06` tranchés par vérification directe sur `K7PL_PR.pdf` ; fiche `BLOQ-14` réécrite (gravité A → B, cible de la correction déplacée) ; §19 remplacé par le relevé des vérifications.

---

## 0. Mode d'emploi

### 0.1 Conventions d'identification

| Préfixe | Lot | Contenu |
|---|---|---|
| `BLOQ-nn` | Bloquants | Énoncé faux, objet absent, preuve circulaire, hypothèse réfutée. Rien ne peut être gelé avant résorption. |
| `STRUCT-nn` | Structurels | L'architecture est réparable, sa présentation ou sa construction doit changer. |
| `PORT-nn` | Portée | L'idée est juste, l'énoncé promet plus qu'il ne tient. Correction par restriction ou conditionnement. |
| `PREUVE-nn` | Dettes de preuve | Un travail de démonstration reste à conduire, sur un objet construit. |
| `NOTA-nn` | Notation, comptes, renvois | Corrections mécaniques, coût quasi nul, effet de traçabilité élevé. |
| `IMPL-nn` | Dettes d'implémentation | Exigences sur le compilateur, le runtime, l'outillage. |
| `FACT-nn` | Factorisations à écrire | Théorèmes aspirateurs et abstractions manquantes. |
| `REFUS-nn` | Factorisations à refuser | Fusions tentantes et fausses, à documenter comme refusées. |
| `REECR-nn` | Réécritures d'énoncés | Affirmations à affaiblir, tableau de substitution. |
| `BIB-nn` | Recherche bibliographique | Vérification ou acquisition de source externe. |
| `TRANS-nn` | Refontes transversales | Causes racines : une correction, plusieurs symptômes. |
| `ARB-PR-nn` | Arbitrages | Points où les relecteurs divergent ; à trancher avant exécution. |

### 0.2 Sources citées dans les fiches

`Q` = QWEN (identifiants `R-nn`, `N-nn`, `RT-n`) · `C` = CLAUDE (`A-n`, `B-n`, `C-n`, `D-n`, `E-n`, `F-n`, causes α/β/γ) · `G` = GPT (`A1`, `B1`–`B10`, `C1`–`C5`, `R1`–`R4`) · `F` = FLASH (`CRIT-nn`, `DUP-nn`, `COL-nn`, `ASPIR-nn`) · `D` = DEEPSEEK (numérotation de sections) · `E` = GEMINI (`DEF-nn`).

Une fiche portant plusieurs sources signale une **convergence indépendante** : c'est le signal le plus fort de cette campagne, et l'ordre d'exécution du §16 en tient compte.

### 0.3 Gravité

Reprise de la grille commune aux six rapports : **A** bloquant · **B** structurel · **C** portée · **D** dette de preuve · **E** ambiguïté notationnelle · **F** dette d'implémentation · **G** stylistique.

### 0.4 Avertissement de lecture

Deux rapports (`CLAUDE`, `FLASH`) sont des transcriptions de session : ils contiennent le *system prompt* de revue en préambule et, pour FLASH, une seconde requête (approfondissement de la cartographie des duplications) dont la réponse constitue la moitié du fichier. Les deux moitiés sont intégrées ici. Les relances « continu » de la session CLAUDE coupent trois fiches en deux ; elles ont été recollées.

---

## 1. Tableau de convergence

Points relevés indépendamment par au moins trois relecteurs. Ce sont les corrections à ne pas différer.

| Objet | Q | C | G | F | D | E | Fiche |
|---|:-:|:-:|:-:|:-:|:-:|:-:|---|
| Th. 36 — préservation graduée par abaissement non démontrée, affirmée ailleurs | ✓ | ✓ | ✓ | ✓ | ✓ | — | `PORT-16`, `PREUVE-02` |
| Acyclicité statique ≠ vivacité dynamique ; graphe de câblage non défini | ✓ | ✓ | ✓ | ✓ | ✓ | — | `BLOQ-13`, `PREUVE-13` |
| Rejeu bit-à-bit : hypothèse insuffisante ou tardive | ✓ | — | ✓ | ✓ | ○ | ✓ | `PORT-04` |
| Zéro-copie : domaine réel plus étroit que l'usage qui en est fait | ✓ | ✓ | ✓ | ✓ | ✓ | — | `PORT-01` |
| Isolation sans MMU : « entièrement » indéfendable à frontière FFI ouverte | ✓ | ✓ | ✓ | — | ✓ | ✓ | `PORT-02` |
| Clôture des échappatoires 𝒳 non rétropropagée au ch. 2 (règle 10) | ✓ | ✓ | — | ✓ | ✓ | — | `BLOQ-11` |
| Statut épistémique des 51 énoncés : un seul environnement pour sept natures | ✓ | ✓ | ✓ | ○ | ✓ | — | `TRANS-01`, `STRUCT-03` |
| Effets à portée non absorbés par ℰ (ℳ est une pièce nouvelle) | ✓ | ✓ | ✓ | ✓ | ✓ | — | `STRUCT-02`, `STRUCT-11` |
| Collision de symboles contre une table déclarée normative | ✓ | ✓ | — | ✓ | ✓ | ✓ | `NOTA-01` |
| Trois critères de terminaison → un schéma de bien-fondation | ✓ | ✓ | ✓ | ✓ | ✓ | — | `FACT-03` |
| Commutation graduée : une loi, cinq à six emplois, aucun schéma | ✓ | ✓ | ✓ | ✓ | ✓ | — | `FACT-01` |
| Projection : quatre à cinq objets de même forme, non reliés | ✓ | ✓ | — | ✓ | ✓ | — | `FACT-02` |
| Le noyau catégorique 𝒞 sert de vocabulaire, non de modèle | ✓ | ✓ | ✓ | ✓ | — | ✓ | `BLOQ-08` |
| Amortissement vs pire cas : P3 à clarifier | ✓ | ✓ | ✓ | — | ✓ | — | `PORT-09` |
| Pipeline : boucle phases 5/6 et invariant de passe non déclaré | ✓ | — | ✓ | — | ✓ | ✓ | `STRUCT-05` |

Légende : ✓ relevé et argumenté · ○ relevé mais jugé non fautif par ce relecteur (voir §13).

---

## 2. Lot BLOQ — défauts bloquants

> Ces quatorze fiches ont en commun qu'aucune reformulation ne les résout : il manque un objet, une règle, ou l'énoncé est faux.

### `BLOQ-01` — Le noyau formel est séquentiel ; la couche 2 n'a ni règles, ni constructeurs, ni types habitables
**Sources :** Q/R-01, Q/RT-3 (cause racine) · corroboré partiellement par C (§1.3, deux sémantiques) et D (Obj. 1).
**Localisation :** annexe E.1 p. 244, E.2 p. 245, E.3 p. 246-261, E.3.4 p. 259, E.6 p. 281 — contre ch. 1 §1.4 p. 17-20 et 34, ch. 3 §3.2 p. 102-106, ch. 4 §4.3/§4.5/§4.6, ch. 5 §5.5, ch. 7.
**Constat :**
1. `S` (sessions) n'est clause ni de `V` ni de `C` ; les liaisons de Δ étant `x :_r V`, **aucun contexte bien formé ne peut contenir un canal**. La fusion Δ/canaux revendiquée au §1.4 n'est pas réalisée par la grammaire donnée.
2. Aucun des 35 constructeurs n'est une forme de communication (émission, réception, offre, sélection, création de canal, coupure, composition parallèle, motif de jonction), ni une capacité (`WriteCap`, `ReadCap`, `Dest`, `hollow_alloc`, `fill`, `finalize`), ni une opération d'arène, ni une fusion CRDT, ni un accès de lentille.
3. Aucune règle imprimée n'est une règle de communication. `LAM`/`APP` sont un β-rédex synchrone, non un rendez-vous.
4. Le croisement mécanique annoncé est pris en défaut dans les deux sens : les 8 constructeurs de `S` n'ont aucune règle ; six règles (`DEL`, `ALW`, `ALW⁻`, `NOW`, `WAIT`, `WHEN`) concluent des types `○C`, `□V`, `◇V`, `○◇V` **que la grammaire n'engendre pas** ; `DEL` applique `○` à un contexte, usage non grammaticalisé.
5. Les deux règles structurelles de formation de contexte sont comptées au §E.1 et **imprimées nulle part**.
**Portée du dommage :** Th. 17, 21, 22, 24, 25, 26, 28, 45, 51 et le groupe « couche 2 » du Th. 27 perdent leur support. Le §E.4.6 conclut « l'induction entière » sur un jeu de règles qui ne contient pas les cas traités. Le plus petit scénario de rupture est **l'exemple unique du document** (Listing 3-5 du §5.5 : `defactor`, `defhandler`, `bind-to`, `HandlerResult`, lentille `^.`, `select`), inécrivable dans la grammaire de E.2.
**⚠️ DÉCISION ARRÊTÉE (15 septembre 2026) : voie 2.** L'auteur a tranché — la couche 2 doit devenir un langage concurrent formalisé, et non une cible citée. La voie 1 ci-dessous est conservée pour mémoire et **ne doit pas être exécutée**. Le programme de construction est dans `K7PL_programme_concurrence.md` ; cette fiche en devient l'étape 2.
**Action — les deux voies étaient :**
- **Voie 1 (recommandée par Q, coût ≈ 1 page).** Déclarer au §E.1 que le noyau formalisé est le fragment séquentiel ; requalifier Th. 17, 21, 22, 24, 25, 26, 28, 45, 51 en énoncés *sur la cible* ou en *exigences d'implémentation* (catégorie que le §1.2 possède déjà). Perte assumée : la revendication que la couche 2 est un langage concurrent formalisé.
- **Voie 2 (coût ≈ 40 pages).** Ajouter `S` comme clause de `V`, six constructeurs de termes (send, recv, offer, select, fork/coupure, join) et leurs règles, une règle de création de canal, une sémantique opérationnelle à configurations multiples — que le §E.4 p. 266 annonce sans la donner. Reprise obligatoire des Th. 41, 43, 44, 47.
**Sous-tâches communes aux deux voies :**
- `BLOQ-01a` — les six règles temporelles concluent des types non engendrés : **soit** ajouter `○C`, `□V`, `◇V`, `○◇V` aux grammaires de C et V, **soit** restreindre les modalités à `S` et retirer les règles.
- `BLOQ-01b` — écrire les deux règles de formation de contexte (c'est aussi le lieu de `BLOQ-05`).
- `BLOQ-01c` — rendre le compte de règles unique et le faire réellement vérifier par le croisement annoncé (cf. `NOTA-04`).
**Conséquences interchapitres :** ch. 1 §1.4 (fusion Δ/canaux, équation fondamentale, clôture) · ch. 2 §2.5 (Th. 9) · ch. 3 §3.2 (Th. 17) · ch. 4 §4.3/§4.5/§4.6 · ch. 5 §5.5 · ch. 6 §6.3 · ch. 7 · annexe A (ERR-ACT, ERR-ARC, ERR-MEM, ERR-TYP-006/007, ERR-FFI portent tous sur des constructions hors noyau).
**Gain attendu :** sous la voie 1, la dette cesse d'être une traduction entre deux langages dont l'un n'existe pas, et devient une traduction entre un noyau possédé et une cible citée. Q qualifie ce gain de « réduction de complexité la plus rentable de la revue ».

### `BLOQ-02` — La modalité duale de ◇ n'a ni nom, ni glyphe, ni clause grammaticale ; la règle WHEN imprimée est celle que le texte déclare fausse
**Sources :** Q/R-31 (vérifié au niveau des objets texte du PDF).
**Localisation :** annexe E.3.1 p. 251 (règle WHEN) et p. 252 (trois occurrences prose) ; annexe E.1 p. 244 (grammaire des sessions).
**Constat :** une macro LaTeX non définie (ou définie vide) se propage en quatre endroits.
- p. 252 : « la duale porte le nom . » — un unique span `Luciole-Regular`, aucun glyphe.
- p. 252 : « La première est que  ne vit qu'en couche 2 » — deux espaces consécutives.
- p. 252 : la coercition annoncée se lit `𝑆 → 𝑆`, c'est-à-dire l'identité : l'énoncé devient vide.
- p. 244 : la grammaire des sessions se termine par `} ∣○𝑆∣□𝑆∣◇𝑆∣𝑆` — la clause ajoutée est `S ::= … ∣ S`, **production auto-référentielle vide**.
- p. 251 : la règle WHEN imprimée est `Δ₂, x:^r V ⊢ c : ◇C ∣ ε`, sans condition de bord — exactement la règle que le texte déclare « trop permissive », alors qu'il annonce la correction « désormais appliquée ».
**Conséquences en chaîne :** (i) WHEN, seule porte d'entrée de l'éventualité, est fausse ; (ii) le prédicat « type bien formé » est mal défini (`S ::= S` admet une dérivation infinie) ; (iii) la vérification de la condition de clôture du ch. 1 porte sur un symbole absent ; (iv) **le croisement mécanique revendiqué ne l'a pas détecté** — il compare des présences, pas des arités ni des occurrences utiles (cf. `IMPL-08`).
**Action :** définir le glyphe (ni `S`, qui a déjà cinq sens — cf. `NOTA-01`/N-06 ; respecter la cinquième règle d'admission du §E.7 : aucun couple de glyphes ne se ressemble à l'œil), l'ajouter à la table 5, écrire la clause `∣ 𝕊S` dans la grammaire de `S`, et réimprimer WHEN avec la condition :

```
Δ₁ ⊢ v : ◇V      Δ₂, x:^r V ⊢ c : ◇C ∣ ε      ∀ y ∈ Δ₂, sort_◇(y)
─────────────────────────────────────────────────────────────────
      Δ₁ ⊠₁ Δ₂ ⊢ when x = v in c : ◇C ∣ ε[ω/k]
```

**Coût :** trois lignes. **Gravité :** A. C'est le plus petit défaut du document et l'un des plus graves : il invalide une correction annoncée comme acquise.
**À conserver mot pour mot :** l'analyse qui précède le symbole manquant (diagnostic, source [7], motif du report indéfini, direction de la coercition, restriction à la couche 2, rattachement à la strate coeffet) est juste.
**Voir aussi :** `FACT-23` (relation entre `□` et la duale — qui pourrait supprimer un connecteur au lieu d'en ajouter un).

### `BLOQ-03` — Le Th. 1 (loi de cohérence) est faux au grade ω ; deux conventions de `⊖` coexistent
**Sources :** Q/R-02.
**Localisation :** ch. 2 §2.2 p. 48 (définition de `⊖`) et p. 49 (énoncé, esquisse) ; ch. 1 §1.4 p. 24-29 ; annexe E.3.5 p. 261-262.
**Constat :** le ch. 2 définit `⊖` comme le **résidu de l'addition** (« le plus petit x tel que k + x ≥ β »), donc `ω ⊖ ω = 0`. Avec β = 5, k = 3, u = ω :
- membre gauche `ω · (5 ⊖ 3) = ω · 2 = ω` ;
- membre droit `(ω·5) ⊖ (ω·3) = ω ⊖ ω = 0`.

L'annexe calcule correctement le membre gauche et **postule** ω pour le membre droit — elle emploie donc en silence la convention `ω ⊖ ω = ω`, que le ch. 2 exclut. La clause de partialité échoue symétriquement : pour u = 0, β = 2, k = 5, le membre gauche est indéfini et le droit vaut `0 ⊖ 0 = 0`.
**Trois lieux, aucune version complète :** le ch. 1 déclare la loi « démontrée à l'annexe E » ; l'annexe déclare qu'elle « n'est pas démontrée ici » et renvoie au ch. 2 ; le ch. 2 la démontre en trois lignes qui ne traitent pas le cas ω.
**Portée du dommage :** la loi est invoquée nommément par six démonstrations — Th. 38, 41, 45, 47 (cas LET et APP), 48/27, 32 — et ω est *le* grade du fragment cartésien, donc de la couche 3.
**Contre-exemple à inscrire au document :** `(force t) 5` où le forçage de `t` coûte k = 3 ticks et où `5` est à grade ω. APP compose `Δ₁ ⊠_{ε₀} (ω·Δ₂)` ; recombiner après substitution exige `ω = 0`.
**Action — par ordre de préférence :**
1. **Clarification (recommandée).** Définir `⊖` sur ℕ∞ par cas : `0` si β < k finis ; `β − k` si β ≥ k finis ; `ω` si β = ω. Écrire explicitement au §2.2 que **ce `⊖` n'est pas le résidu de l'addition** mais la soustraction tronquée prolongée par continuité en ω. Motivation interne : le §E.3.2 lit l'annotation comme une *borne*, et pour une borne `ω ⊖ ω = ω` est la sur-approximation sûre. La loi devient vraie sans restriction.
2. *Restriction (déconseillée).* Énoncer la loi pour u fini + condition de bord `u(r) = ω ⟹ k(ε) = 0` sur APP/LET : rejette des programmes corrects.
3. **Dans les deux cas :** isoler « distributivité du produit sur `⊖` dans ℕ∞ » comme lemme nommé, et **écrire la table d'arithmétique de ℕ∞** — `0·ω`, `ω·0`, `ω+ω`, `ω·ω` ne figurent nulle part, alors que ℕ∞ porte les indices de taille, les budgets et l'usage.
**Gain :** la convention `ω ⊖ ω = ω` unifie la soustraction de budget, la perte de borne sous `◇` (`ε[ω/k]`) et l'absorption du grade ω — un seul principe dont la loi de cohérence, le Th. 38 et la règle WHEN deviennent corollaires.

### `BLOQ-04` — ℛ désigne deux structures incompatibles ; l'action scalaire n'est pas définie sur deux de ses quatre facteurs
**Sources :** Q/R-04, Q/RT-2 · F/COL-01 (collision 𝒢 algèbre/grade) · E/§3.1 (collision sur G) · D/3.5 et 3.6 (mode vs intervalle, type vs valeur vs grade).
**Localisation :** ch. 2 §2.2 p. 48 et p. 53 ; ch. 3 §3.1 p. 86-87 (table 6, Th. 15) ; ch. 3 §3.3 p. 108 ; annexe E.1 p. 244 ; ch. 1 §1.5 p. 39 (table normative).
**Constat — quatre défauts, une cause :**
1. **Collision.** ℛ = ℚ≥0 ∪ {ω} (semi-anneau, ch. 2) et ℛ = ℕ∞ × {d⪯m} × ℒ × ℬ (produit à quatre facteurs, annexe E.1) ne sont ni la même structure, ni isomorphes, ni munies des mêmes opérations. La table normative interdit explicitement cette divergence.
2. **Les grades fractionnaires disparaissent du noyau.** `1/N` n'est pas représentable dans ℕ∞, alors que c'est le mécanisme par lequel le ch. 3 exprime N lecteurs simultanés (`ReadCap`) et le ch. 4 la partition d'arène.
3. **Singletons contre intervalles, avec conséquence de sûreté.** Sous la lecture intervalle, `Aff = [0..1]` contient 1/2, donc la contraction `c_{r,s} : !^{r+s} ⇒ !^r ⊗ !^s` est instanciable avec r = s = 1/2. **Le fragment affine admet alors la contraction**, contre la table 6, contre le §2.2 et contre la table 3. La preuve du Th. 15 est écrite pour les singletons, son énoncé porte sur les intervalles.
4. **`r · Δ` et `0 · Δ` ne sont pas définis.** Sur les facteurs monotonie `{d ⪯ m}` et niveau `ℒ`, il n'existe pas de multiplication scalaire : ce sont des ordres, pas des modules. Que vaut `ω · m` ? `0 · ℓ` ? Le §2.4 affirme que les lois passent « coordonnée par coordonnée » : c'est faux pour deux coordonnées sur quatre. Les trois conditions d'admission du §1.4 sont donc **insuffisantes** : *ordonnée* ne suffit pas, il faut une action du semi-anneau.
**Portée du dommage :** ℛ intervient dans la définition des fragments → des couches → des délimiteurs → d'ERR-TOP-001 ; dans VAR (`0·Δ`), BOX/APP/VECI/SC (`r·Δ`) ; dans ≼ (table 20) ; dans Th. 39, Th. 1, Th. 15, `Trellis_fin`, le grade de présence.
**Action (un renommage, aucune structure nouvelle) — voir `TRANS-02` :**
- `𝕌 := ℚ≥0 ∪ {ω}` — semi-anneau d'usage (le ℛ du ch. 2) ;
- `ℛ := 𝕌 × 𝕄 × ℒ × 𝔅` — algèbre des grades, avec `𝔅 = ℕ∞` muni de `⊖` (cf. `BLOQ-03`). **Écrire `𝔅` et non `ℬ`** (`ℬ` est hors table normative et, lu comme booléens, contredit `β ⊖ k`) ;
- définir : un **mode** est un sous-ensemble de ℛ de la forme `π_𝕌^{-1}(I) × 𝕄 × ℒ × 𝔅` pour un intervalle I de 𝕌 ; les fragments catégoriques du §2.2 deviennent `𝒞_{!π_𝕌^{-1}(S)}` ; **la table 6 doit dire laquelle des deux lectures elle donne** (singletons = fragments logiques, intervalles = modalités de type) ;
- définir l'action scalaire `r · ⟨u,m,ℓ,β⟩ = ⟨u_r·u, m, ℓ, β⟩` — identité sur monotonie et niveau —, vérifier qu'elle est celle dont VAR, BOX, APP, VECI, SC ont besoin, et l'écrire comme clause de la définition de ℛ ;
- écrire la table d'arithmétique de 𝕌 et de 𝔅.
**Conséquences interchapitres :** ch. 1 §1.4 (quatre composantes, élision, table 2), §1.5 (scinder la ligne « ℛ » en deux) · ch. 2 §2.2 (tout), §2.4 · ch. 3 §3.1 (table 6, Th. 15, ReadCap 1/N), §3.3 · annexe E.1, E.3, E.3.3 (produit mixte, Th. 39), E.4.3.

### `BLOQ-05` — Le niveau d'un calcul est invoqué par cinq démonstrations et produit par aucune règle ; le symbole ℓ recouvre deux ordres
**Sources :** Q/R-05 · C/B-2 (les deux ordres, le lemme de correspondance, la clause sur OP). Les deux fiches convergent et se complètent : Q fournit le diagnostic d'absence, C fournit le diagnostic de collision et la clause de règle.
**Localisation :** annexe E.3 p. 248 (TICK) ; E.4 p. 265-266 (réduction, Th. 43) ; E.4.2 p. 270 (Th. 46) ; E.4.4 p. 272 (Th. 47) ; E.5.2 p. 277 (sortes) ; E.5.4 p. 279 (Th. 51) ; E.5.6 p. 280 (incertitude 1) ; ch. 1 §1.4 p. 24-26 (table 2) ; ch. 2 §2.4 (confidentialité/intégrité).
**Constat :**
1. `TICK` conclut l'effet `⟨1,1⟩`. Or par E.1 un effet est `⟨φ, κ⟩ ∈ ℰ₀ × ℕ∞^ℒ` : la seconde composante est une **famille indexée**, pas un nombre. `⟨1,1⟩` n'est pas un effet bien formé ; la bonne forme est `⟨1, δ_ℓ⟩` — pour un ℓ que la règle ne peut pas déterminer, sa prémisse étant le contexte `0`.
2. **Aucune règle du §E.3 ne calcule, ne transporte ni ne borne le niveau d'un calcul.** OP prend ε tel quel ; APP compose sans condition de niveau ; CASE n'impose rien sur les niveaux ; BOX/UNBOX ne relient pas `niv(r)` au niveau du calcul enclos ; SUB permet `ε ⊑ ε'` sans condition.
3. La propriété dont tout dépend — *un calcul de niveau ℓ ne produit un tick qu'au niveau ℓ et n'inspecte que des valeurs de niveau ≤ ℓ* — n'est ni règle, ni lemme, ni hypothèse nommée. Elle est invoquée comme un fait (Th. 51).
4. **Son lieu d'énonciation existe et est vide** : les deux règles de formation de contexte (cf. `BLOQ-01b`).
5. **Collision.** Un seul ℓ circule pour deux ordres : `ℓ_lecture` (ce qu'une flèche a le droit de lire, dans Δ, contravariant) et `ℓ_production` (le niveau auquel un événement est observable, dans ℰ, covariant). Sans renommage, le lemme de correspondance est *inénonçable sans ambiguïté* — on écrirait « ℓ ⊑ ℓ ».
**Scénario de rupture :** un calcul lit `!^{⟨1,d,secret,0⟩} V` et produit un tick. Rien n'empêche ce calcul d'être par ailleurs de niveau public ; le tick n'est donc pas étiqueté `secret` ; `π_public(τ)` le conserve ; le nombre de ticks, dépendant du secret, est observable au niveau public. **Le canal temporel que le §E.4.4 déclare fermé est ouvert par absence de règle.**
**Contre-exemple interne :** le §E.3.2 exclut `φ_ℓ` de ℳ à la main, avec le bon motif. L'exclusion prouve que le couplage n'est pas structurel : il est maintenu par une clause négative.
**Action — deux composantes, à faire ensemble :**
- `BLOQ-05a` **Renommage (coût nul, indispensable).** `ℓ` pour le niveau de lecture, `ℓ̂` pour le niveau de production. La table 5 porte les deux lignes.
- `BLOQ-05b` **Indexation de la dérivation (Q).** Poser `Δ ⊢^ℓ_𝒢 c : C ∣ ε`, sur le précédent que le document possède déjà (𝒢 est un indice, non une composante). Clauses : formation de contexte `⊢^ℓ ∅`, niveau d'une liaison = `niv(r)`, niveau du contexte = `⊔ niv(r)` sur les liaisons employées ; `VAR : ℓ ⊒ niv(r)` ; `OP : ℓ ⊒ a` où l'opération déclare son niveau `a` ; `APP/LET/CASE/SC/VECE` : jointure des ℓ des prémisses ; `BOX : ℓ ⊒ niv(r)` ; `SUB` inchangé ; `TICK : Δ ⊢^ℓ tick : F_1 1 ∣ ⟨1, δ_ℓ⟩`.
- `BLOQ-05d` **Clause de niveau sur CASE (analyse GUARD du 15 septembre).** La règle `CASE` p. 248 ne contraint aucun niveau : un `case` sur une somme dont le constructeur est secret produit un calcul dont le comportement dépend du secret, sans relever `niv(C)`. Ajouter `⨆ᵢ niv(constructeurᵢ) ⊑ niv(C)`. **Scénario de rupture le plus court :** deux branches, deux étiquettes de niveaux différents, une divulgation. Le même défaut vaudrait pour la règle `GUARD` du programme de concurrence, où il a été découvert.
- `BLOQ-05c` **Clause sur OP (C), équivalente en effet, plus économe :** ajouter à OP la prémisse `⨆_{x:_r V ∈ Δ} niv(r) ⊑ niv(ε)`. Ajouter cette clause *fait* la correspondance au lieu de la démontrer, et rend l'exclusion de `φ_ℓ` **dérivée** plutôt que décidée.
**Effet secondaire acquis :** l'incertitude n° 3 du §E.5.6 (« un seul niveau par processus, la littérature en emploie deux ») est réglée : l'habilitation est `niv(r)` sur les liaisons, le niveau courant est l'indice de la dérivation, la jointure est la règle de propagation.
**Conséquences interchapitres :** ch. 1 §1.4 (table 2), §1.5 (table normative) · ch. 2 §2.4 (Th. 7, Th. 10, dualité) · ch. 3 §3.2 (règle 10) · annexe E.1, E.3 (six règles), E.4 (Th. 43, 46), E.4.3-E.4.5, E.5.2-E.5.5, E.5.6 (l'incertitude 1 est levée).

### `BLOQ-06` — La clause de taille `i ∈ ℕ∞ ∖ {ω}` interdit les acteurs et flux non bornés que le document exige
**Sources :** Q/R-03. **Divergence à instruire :** C/F-4(a) juge la clause et sa justification « excellentes » — voir `ARB-PR-02`.
**Localisation :** ch. 2 §2.3 p. 57 (clause et justification par l'issue Agda [25]), p. 62 (Th. 5, preuve « dans 𝒞^op pour p = ν ») ; annexe E.3.4 p. 260 (OUT/COP) — contre ch. 2 §2.3 p. 60, ch. 4 §4.2 p. 124, §4.5 p. 133, ch. 7 §7.1, P4.
**Constat :**
1. **OUT/COP bornent la durée de vie de tout objet coinductif.** Avec i ∈ ℕ, un flux initialisé à i = n produit au plus n observations puis atteint `να.C⟨0⟩` où OUT n'est plus instanciable. **Aucun processus non terminé n'est typable** — or c'est ce que la couche 2 est censée porter.
2. **La preuve du Th. 5 pour p = ν est invalide telle qu'écrite.** Sur ℕ, l'ordre opposé n'est pas bien fondé. Le côté coinductif ne demande pas une bien-fondation mais son dual : un plus grand élément absorbant la décrémentation (`∞ − 1 = ∞`) — précisément ce que la clause exclut.
3. **Mésusage de la source [25].** L'issue Agda incrimine le **partage d'une sorte de taille entre les deux polarités**, non l'existence d'un plus grand élément pour la polarité coinductive. Le document cite correctement le contenu et en tire la mauvaise conclusion.
**Scénario de rupture :** le flux d'événements d'interface du ch. 7 §7.1. Son type est `να.C⟨i⟩` : toute valeur finie de i fixe un nombre maximal d'images, `ω` est interdit. **Le cas d'usage I n'est pas typable.**
**Action — une distinction, pas un mécanisme :**
- `𝕊_μ = ℕ∞ ∖ {ω}` (taille inductive, ordre strict bien fondé) pour FOLD/UNFOLD, plis dépendants, hauteur de `Trellis_fin` ;
- `𝕊_ν = ℕ∞` **avec** `∞ + 1 = ∞` (taille coinductive, ordre dual co-bien-fondé) pour OUT/COP ;
- réénoncer le Th. 5 comme un schéma à *deux* instances de sortes : « en p = μ la mesure décroît dans un ordre bien fondé ; en p = ν la mesure croît vers un plus grand élément absorbant » ;
- la clause d'exclusion d'Agda devient : **les deux sortes sont disjointes et aucun type ne porte les deux** — ce qui est la leçon de la source.
**Conséquences interchapitres :** ch. 2 §2.3 (clause, Th. 4, Th. 5, RMQ 16) · ch. 4 §4.2 (flux, StreamContext), §4.5 (acteurs virtuels, supervision, Th. 22, 24) · ch. 7 §7.1 · annexe E.1 (la clause « n < ω » de `Trellis_fin` doit, elle, rester sur ℕ∞∖{ω}), E.3.4 (OUT/COP).
**Effet secondaire :** répare la confusion entre indice de taille d'un flux (profondeur d'approximation) et budget β (allowance de coût), qui vivent aujourd'hui dans ℕ∞ avec des conventions arithmétiques différentes et non écrites.
**Voir aussi :** `REFUS-05` — c'est le cas où l'unification du schéma (Th. 5) a entraîné à tort l'unification de l'objet.

### `BLOQ-07` — Deux sémantiques opérationnelles concurrentes, sans théorème d'accord
**Sources :** C/A-1, C/cause β.
**Localisation :** annexe E §E.4 (relation → sur configurations `⟨c ∣ μ ∣ τ⟩`) contre ch. 4 §4.6 + Th. 27 + Th. 28 (traduction `⟦·⟧` vers le métalangage, interprété par la machine à sessions linéaires de Caires–Toninho).
**Constat :** le §E.4.1 déclare « ce document retient un seul objet : la relation → est la définition de l'exécution, et rien d'autre ne l'est ». Le Th. 28 déclare que tout interpréteur réalisant le métalangage « est fidèle à la sémantique de K7PL sur la structure de communication, sur le contrôle et sur les effets ». **Les deux affirmations sont incompatibles telles qu'écrites.** Si → est *la* définition, la fidélité est relative à →, et il faut un théorème d'adéquation qui n'existe pas. La preuve du Th. 28 factorise par la préservation du typage (Th. 27) et l'adéquation de la machine cible — mais préservation du typage ≠ préservation du comportement : un terme bien typé peut avoir plusieurs images bien typées de comportements distincts. Il manque le maillon `⟦c⟧ ≈ c`.
**Portée du dommage :** le Th. 28 est le pivot du ch. 6 — c'est lui qui justifie l'oracle de test différentiel, donc la confiance dans les huit phases d'optimisation.
**Contre-exemple minimal :** `c = let x ← tick in tick`. Sous →, la trace est `⟨1,δ_ℓ⟩·⟨1,δ_ℓ⟩` dans cet ordre, en deux pas distincts. Sous `⟦·⟧`, c'est une émission sur le canal de temps puis une autre. **La composition parallèle du métalangage étant commutative** — le document le note lui-même au §E.3 —, rien dans la cible ne distingue `τ₁·τ₂` de `τ₂·τ₁` *sauf* si le préfixage les sérialise. Sur deux acteurs concurrents produisant chacun un tick, la sérialisation n'est plus garantie et l'ordre de la trace source n'a plus d'image déterminée.
**Action — par coût croissant :**
1. **Restriction de domaine (le moins cher).** Réénoncer le Th. 28 : « *sous l'hypothèse d'un théorème de simulation Sim reliant → et la réduction du métalangage*, tout interpréteur… ». Ne prouve rien de plus mais cesse de promettre ce qui n'est pas tenu, et nomme la dette au bon endroit.
2. **Lemme (recommandé, cf. `PREUVE-07`).** Établir la simulation dans le seul sens qui suffit : `⟨c∣μ∣τ⟩ → ⟨c′∣μ′∣τ′⟩ ⟹ ⟦c⟧ →⁺ ⟦c′⟧ modulo ≡`, avec l'extension correspondante de la trace. **C'est une induction de plus sur la même dérivation que le Th. 27** : les cas sont déjà énumérés au §E.4.6. Coût marginal faible, rendement le plus élevé du document.
3. *Abstraction (à écarter).* Construire une catégorie de simulations : coût disproportionné.
**Conséquences interchapitres :** §6.3 (l'oracle cesse d'être une hypothèse de confiance et devient un corollaire) · §4.6 (le Th. 28 change d'énoncé) · **table 1 : l'engagement « fidélité de l'interpréteur », déclaré levé le 4 août, doit être rouvert ou son périmètre restreint**.
**Gain :** le lemme de simulation absorberait aussi la justification de la phase 6 (les optimisations préservent le comportement, pas seulement le typage). Un lemme, deux dettes soldées.

### `BLOQ-08` — La catégorie ambiante 𝒞 n'interprète rien : P1 est un axiome sans modèle
**Sources :** C/A-2, C/cause β · G/B3 (SMCC ≠ mémoire physiquement disjointe) · G/R1 (la structure abstraite absorbe trop vite la sémantique concrète) · E/§6.1 (l'adjonction graduée n'est pas formalisée) · F/cause racine 2 (couplage modèle mathématique / ABI).
**Localisation :** P1 (§1.3), ch. 2 §2.1-2.2, Th. 9 (§2.5) ; pour le volet mémoire, P1 / §4.4.
**Constat :** aucune fonction d'interprétation n'est définie. Il n'existe nulle part un `⟦−⟧_𝒞` envoyant une dérivation sur un morphisme, ni de théorème de correction dénotationnelle. Le §2.5 déplace d'ailleurs l'objet : le foncteur du système de raffinement n'est pas `⟦−⟧_𝒞` mais `⟦−⟧` vers le **métalangage**. 𝒞 n'est jamais employée comme lieu d'interprétation ; elle sert de vocabulaire.
**Portée du dommage — P1 est invoqué six fois comme argument de correction :** §2.4 (monomorphisation licite car curry/uncurry est un iso naturel) ; §6.1 (les quatre familles d'optimisation « se formulent comme des isomorphismes naturels ») ; §3.3 Th. 19 (« l'abaissement MLIR se formule comme un isomorphisme naturel dans 𝒞 au sens de P1 ») ; §1.3 (l'absence de data race « se déduit de l'absence de diagonale ») ; §4.6 (le grade fini se traduit par ré-invocation) ; ch. 5 Th. 31. Chacun a la forme « X et Y ont même image dans 𝒞, donc même sens » — **sans fonction d'interprétation, cette forme n'a pas de contenu**.
**Contre-exemple :** `t₁ = λx.λy.c` et `t₂ = λp. let ⟨x,y⟩ = p in c` n'ont pas le même *type* (`V₁ ⊸ V₂ ⊸ C` contre `V₁ ⊗ V₂ ⊸ C`). Ils ont même image *sous l'iso de currification*, ce qui est un fait sur 𝒞 et non sur les termes. Conclure que la monomorphisation est licite demande de définir `⟦−⟧` sur les deux dérivations et de vérifier le carré.
**Volet mémoire (G/B3) :** une SMCC abstraite fournit une composition tensorielle ; elle ne fournit ni sémantique de mémoire physique, ni partition concrète d'un espace d'adresses. Le manuscrit possède déjà les trois étages (tensoriel abstrait → interprétation séparationnelle → machine mémoire) ; il faut cesser de les contracter en une implication, et faire de `⊗_𝒞 ↦ *` un **théorème du modèle mémoire**, pas une propriété de la SMCC.
**Action :**
- **Scinder P1.** `P1a` (postulat, conservé) : 𝒞 est une SMCC, les types sont ses objets, le tenseur dénote la disjonction de ressources — c'est ce que le §2.1 construit. `P1b` (obligation, nommée comme telle) : il existe une interprétation `⟦−⟧_𝒞` des dérivations vers les morphismes de 𝒞, correcte pour →.
- **Remplacer chacun des six arguments invoquant P1b par un argument syntaxique.** Le document le fait déjà par endroits sans s'en apercevoir : la monomorphisation se justifie par substitution + inversibilité syntaxique ; l'absence de data race est démontrée *par absence de dérivation* au Th. 21 (lemme de capacité, Th. 14), pas par absence de diagonale — **il suffit de corriger l'attribution du §1.3** ; la ré-invocation séquentielle repose sur le modèle mémoire, pas sur 𝒞.
- Mettre un théorème à chaque flèche de `structure syntaxique → modèle sémantique → machine` (G/R1).
**Conséquences interchapitres :** §1.3 (reformulation de P1) · §2.1 (réserve explicite : 𝒞 est le cadre, pas le modèle) · §2.4 · §3.3 Th. 19 · §6.1 (les quatre familles demandent chacune leur argument) · §4.4.
**Gain :** réduit la surface d'engagement sans rien retirer de démontré, et rend visible que le vrai foncteur du document est `⟦−⟧` vers le métalangage — ce que le §2.5 a découvert et que le §1.3 n'a pas intégré. **Absorbe `BLOQ-07`** : une fois P1b reconnue comme obligation, l'unique interprétation est celle du métalangage et le besoin de simulation devient évident.

### `BLOQ-09` — Le Th. 21 invoque l'absence de diagonale, alors que la propriété requise est l'unicité d'introduction de la capacité
**Sources :** Q/R-15 · D/5.7 (l'hypothèse de disjonction des contextes) · G/B3.
**Localisation :** ch. 4 §4.4 p. 130 (Th. 21, RMQ 27) ; ch. 1 §1.3 p. 16 ; ch. 3 §3.1 p. 95-96 ; ch. 4 §4.3 p. 127.
**Constat :** l'absence de diagonale interdit de **dupliquer** une capacité donnée ; elle n'interdit pas de **créer deux capacités distinctes pour la même région**. Or `WriteCap(r)` est indexé par la région r, et rien n'établit l'unicité d'introduction. Le mécanisme existe dans le document (partition statique d'arène par `Range`, §4.3 p. 127) mais **n'est pas invoqué dans la preuve** ; la condition d'exclusion du §3.1 porte sur la **vivacité**, notion dynamique, et aucun mécanisme de durée de vie n'est défini — le §4.3 p. 126 le dit lui-même (« Ce document a besoin des deux et n'a nommé que la première »).
**Scénario de rupture :** une primitive `alloc_range : Arena<T> → Range → WriteCap(Arena<T>, Range)` non linéaire en son premier argument (arène accessible à grade ω dans un bloc de couche 3, ou obtenue par capacité de lecture promue). Deux appels produisent deux capacités distinctes pour la même région, toutes deux linéaires, aucune dupliquée : le Th. 21 est satisfait pour chacune et faux pour le couple. Rien ne l'exclut, la règle d'introduction de `WriteCap` n'existant pas dans le noyau (cf. `BLOQ-01`).
**Action (deux lemmes, aucun mécanisme) — cf. `PREUVE-12` :**
- **Lemme d'unicité d'introduction** : la règle d'introduction de `WriteCap(r)` consomme linéairement son arène ou son segment, donc au plus une capacité d'écriture par région est dérivable en contexte clos.
- **Lemme de portée** : deux capacités de `Range` disjoints ne dénotent pas la même région (arithmétique d'intervalles, déchargeable par le solveur).
- Réénoncer le Th. 21 avec ces deux hypothèses, en gardant le Th. 14 pour la non-duplication.
- Séparément : **définir « région »** comme discipline de portée, ce que le §4.3 réclame. Voie la moins coûteuse indiquée par le document : le polymorphisme paramétrique ordinaire suffit, par une traduction préservant types et sens [19] (cf. `BIB-11`).
**Dépendance DEEPSEEK :** la condition de non-capture d'une capacité linéaire par une valeur cartésienne (RMQ 27) tient sous la discipline d'imbrication des délimiteurs `{ … ( … [ … ] … ) … }` du §5.1 — **cette dépendance doit être explicite dans l'énoncé**.
**Gain :** non-duplication, partition d'indices et âge des destinations (`Lin_k`) sont trois instances d'une seule loi — cf. `FACT-17`.

### `BLOQ-10` — Le Th. 35 invoque l'inférence principale, que le document réfute deux fois
**Sources :** Q/R-09 point 3.
**Localisation :** ch. 6 §6.2 p. 198 (Th. 35) contre ch. 3 §3.3 p. 112 et ch. 6 §6.1 p. 192.
**Constat :** la preuve du Th. 35 énonce « la dérivation est déterministe **puisque l'inférence est principale** ». Or le ch. 3 : « la vérification est bidirectionnelle, **non principale** […] K7PL n'infère pas les grades d'une définition non annotée » ; et le ch. 6 rappelle ce prix comme assumé.
**Contre-exemple :** une définition non annotée en grade. Un grade par défaut propre au fragment s'applique (ω en cartésien, 1 en linéaire, 0 ou 1 en affine « selon la forme de la liaison »). Deux ordres de parcours peuvent classer la même liaison sous deux formes, donc deux grades par défaut, donc deux messages de rejet. Le Th. 35 l'interdit ; rien ne l'empêche.
**Action :** remplacer l'invocation par une **hypothèse nommée `D_det`** : « tout parcours, toute recherche et toute graine sont des fonctions de la source et du compte de ressource ». Le document possède les deux moitiés de cette hypothèse (compte reproductible ; budget relevé écrit dans la source) ; il ne manque que leur assemblage. Cf. `PREUVE-15` pour les trois hypothèses de déterminisme non écrites.

### `BLOQ-11` — La règle (10) de déclassification n'a pas reçu la clause de clôture de 𝒳 ; elle admet le blanchiment par substitution
**Sources :** Q/R-19 point 4 · F/CRIT-04 · D/5.3 · C/cause α (remontée).
**Localisation :** ch. 2 §2.4 p. 69 (Définition 10 et règle) ; annexe E.4.5 p. 273-274.
**Constat :** le §E.4.5 découvre *a posteriori* que si les expressions de 𝒳 contiennent des variables libres, le lemme de substitution ouvre un contournement : `declassify_{ℓ'}(e)[v/x] = declassify_{ℓ'}(e[v/x])`, et rien ne garantit que `e[v/x] ∈ 𝒳`. Le document écrit que « la règle du chapitre 2 doit porter cette clause » — **et la règle (10) p. 69 n'a pas été corrigée.** Le Th. 7 prétend donc garantir la divulgation délimitée pour tout programme typable, alors qu'un programme employant une échappatoire ouverte le falsifie dans le corps du texte.
**Contre-exemple :** 𝒳 = {`compare mdp x`} avec x libre. Un appelant écrit `declassify_ℓ′(compare mdp secret)` ; si la règle accepte `e ∈ 𝒳` *avant* substitution, la dérivation existe et divulgue la comparaison du secret avec une valeur choisie par l'attaquant.
**Action :** rétropropager `∀e ∈ 𝒳, fv(e) = ∅` dès la Définition 10 du §2.4 (expressions closes, évaluées dans l'état initial). **Une ligne, déjà écrite au §E.4.5.**
**Gravité :** A — une règle de typage fausse telle qu'écrite.

### `BLOQ-12` — Le Th. 18 n'établit aucun homomorphisme et sa conclusion sur les lois de la théorie des roues est fausse
**Sources :** Q/R-12.
**Localisation :** ch. 3 §3.2 p. 107.
**Constat — quatre défauts :**
1. **Le titre ne correspond pas à l'énoncé.** Un homomorphisme exigerait `i(x ⊕_Wheel y) = i(x) ⊕_Float i(y)` pour chaque opération de la signature. L'énoncé ne porte que sur `select`, qui n'est pas une opération de la théorie des roues et dont la propriété écrite est la *définition* de select.
2. **La première clause est une tautologie obtenue par redéfinition** (`i(x) = i(x)` est vrai pour toute fonction et toute égalité réflexive).
3. **La conclusion sur les lois est fausse.** En roues `x/0 = ⊥` donc `1/0 = ⊥` ; en IEEE 754 `1/0 = +∞`. Second contre-exemple : `⊥ + y = ⊥` en roues ; en IEEE, `qNaN + y = qNaN` **avec propagation de charge utile non spécifiée** (recommandée, non exigée ; les opérations invalides comme `∞ − ∞` produisent le NaN par défaut, détruisant l'encodage). Le masque binaire de `select` ne dit rien de la propagation d'un NaN à travers `+`.
4. **Erreur de niveau.** La preuve invoque la liberté des bits de charge utile (norme), le masquage vectoriel (abaissement SIMD) et la redéfinition de l'égalité (représentation). Et elle contredit le critère que P3 revendique comme son ancêtre (« aucun effet dépendant de la machine, inexplicable dans les termes du langage lui-même », citant Hoare [10]).
**Action :** réécrire en **proposition de représentation** portant sur ce qui est vrai — (i) `i : Wheel → Float64` est injective sur les quatre singularités par encodage déterministe ; (ii) `select` est exact ; (iii) **l'arithmétique de couche 3 sur les valeurs encodées est spécifiée par K7PL** (table de propagation des singularités, cf. `IMPL-07`) et non déléguée à IEEE 754, sa réalisation étant une *exigence* vérifiable par test différentiel (§6.3). Retirer le mot « homomorphisme » et la clause `⊥ + y = ⊥`, ou les subordonner à la table.
**Conséquences interchapitres :** ch. 1 P3, P4 (rejeu bit à bit, cf. `PORT-04`) · ch. 3 §3.2 · ch. 4 §4.2 · ch. 6 §6.1 · ch. 7 §7.3.

### `BLOQ-13` — Le graphe de câblage, hypothèse du Th. 17 et du Th. 24, n'est défini nulle part
**Sources :** Q/R-17 · F/CRIT-02 et F/COL-06 · G/B6 · D/Obj. 8 · C/F-4(c) (qui valide la *distinction* des deux graphes).
**Localisation :** ch. 3 §3.2 p. 105-106 (Th. 17, RMQ 23, renvoi « au sens du chapitre 4 (§4.3) ») ; ch. 4 §4.5 p. 135-136 et p. 139 (Th. 24) ; annexe A p. 233 (ERR-ARC-001).
**Constat :**
1. **L'objet n'est pas défini.** Le §4.3 (« Échelle de l'acteur ») ne définit aucun graphe. La construction effective est au §4.5, sous un autre nom, sans définition formelle : ni sommets, ni relation d'arêtes, ni règle d'orientation, ni statut des canaux (sommets ou arêtes ? le Th. 24 dit « acteurs et canaux », le §4.5 dit « entre gabarits d'acteurs »). **Renvoi faux : §4.3 → §4.5.**
2. **Granularité non tranchée.** Le graphe est construit entre **gabarits** ; le Th. 17 conclut sur un **réseau d'acteurs**, donc sur des instances. Un graphe de gabarits acyclique n'implique pas un graphe d'instances acyclique.
3. **Hypothèse contredite par un mécanisme voisin.** Le Th. 17 suppose que le jeton linéaire force la progression ; or le §3.2 p. 103 déclare qu'une session peut être abandonnée (Timeout, circuit breaker) et que l'extension intuitionniste correspondante « est une obligation et non un acquis ». **L'abandon de session, pratiqué au ch. 4, n'est pas typé.**
4. **Équité absente.** « Il existe toujours une communication réductible » établit l'absence de blocage *structurel*, pas le progrès *effectif*. Le §4.5 connaît le besoin pour l'équité mémoire [30] et ne le transpose pas.
5. **Contre-exemple dynamique (F/CRIT-02) :** A→B, A→C, B→D, C→D, D portant `J = b⟨x⟩ ∣ c⟨y⟩ ▷ P`. Si B et C émettent conditionnellement selon des messages mutuels, une dépendance temporelle circulaire s'établit sur la consommation des boîtes aux lettres **sans qu'aucun cycle n'apparaisse dans le graphe statique**.
**Action — une page, trois objets :**
- **Définition** du graphe de câblage : sommets = instances statiquement créées (ou gabarits, avec clause explicite de passage à l'instance) ; arêtes = `(a,b)` ssi le protocole d'un canal détenu par `a` contient une réception dont l'émetteur est `b` ; orientation et sur-approximation déclarées.
- **Lemme de simulation** (cf. `PREUVE-13`) : toute arête d'attente dynamique est une arête du graphe de câblage. Exige : pas de délégation de session (acquis), pas de création dynamique de canal (à écrire, cf. `BLOQ-01`), sur-approximation des branchements (acquis).
- **Hypothèse d'équité** nommée, et **statut de l'abandon** tranché : soit le Timeout est typé (extension additive transportée en intuitionniste, cf. `BIB-12`), soit le Th. 17 exclut explicitement les sessions abandonnables.
- Corriger les renvois §4.3 → §4.5 (cf. `NOTA-07d`).
- Deux noms normatifs distincts (G/B6) : `G_static` pour le graphe de compilation, `W_run` pour le graphe dynamique d'attente, avec interdiction lexicale de passer de l'un à l'autre sans théorème.
- Qualifier explicitement le *circuit breaker* (Fig. 10) comme le mécanisme de sûreté **dynamique** garantissant la vivacité en cas de famine ou désynchronisation (F/CRIT-02) ; expliciter en annexe A qu'ERR-ARC-001 prévient les cycles structurels tandis qu'ERR-CMP-002 gère le débit.
- Piste de restriction (F) : restreindre le Th. 17 aux protocoles de sessions multiparties binaires ou hiérarchiques à priorités strictes sur les boîtes aux lettres (cf. `BIB-02`).
**Gain :** une fois le graphe défini, le tri topologique de la phase 1.5 (Th. 13), l'initialisation sans blocage (Th. 24) et la recherche de gestionnaire par `bind-to` (§5.5) deviennent trois lectures du même ordre partiel.

### `BLOQ-14` — ✅ **Vérifié sur le manuscrit** — Le ch. 1 et le ch. 2 énoncent le sous-typage modal dans le sens inverse de la règle SUBBOX et de la table 20
**Sources :** E/DEF-01 (diagnostic juste, remède erroné) · F/COL-03 (diagnostic exact) · vérification directe du 14 septembre 2026.
**Ce que dit le manuscrit, aux quatre endroits :**

| Lieu | Texte | Direction |
|---|---|---|
| ch. 1 §1.3, **p. 11** | « Le sous-typage modal Lin 𝑇 <∶ Aff 𝑇 <∶ Unr 𝑇 découle de cette structure pour tout type 𝑇 » | `Lin <: Unr` |
| ch. 2 §2.5, **p. 74** | « Le sous-typage modal Lin <∶ Aff <∶ Unr du chapitre 1 est le pendant exact — mais inversé — de la restriction de ⊑ » | `Lin <: Unr` |
| annexe E.3, **p. 247** | « Sur l'usage, elle descend : disposer d'une ressource librement copiable permet de ne l'employer qu'une fois, et **!𝜔 𝐴 se coerce donc en !1 𝐴** » | `Unr <: Lin` |
| annexe E.3, **table 20, p. 250** | usage 𝑢 : « descend, 𝜔 se coerce en 1 », relation `𝑢 ≥ 𝑢′` ; ≼ est le produit `(≥) × (⪰) × (≤) × (≤)` | `Unr <: Lin` |

Et la règle, p. 249 : `SUBBOX : 𝑟 ≼ 𝑟′ ⟹ !𝑟 𝑉 <∶ !𝑟′ 𝑉`. Avec `𝑢 ≥ 𝑢′` sur la composante d'usage, `!𝜔 𝑉 <∶ !1 𝑉`. **La contradiction est frontale et porte sur le symbole `<∶` lui-même.**
**Verdict :** GEMINI a raison sur l'existence de l'inversion et **tort sur la cible**. Les règles de l'annexe sont correctes et le manuscrit sait exactement pourquoi : « Le piège est que la direction de la coercion n'est pas la même pour toutes. […] prendre le produit des ordres sans y regarder inverserait la garantie de confidentialité. » Ce qui est faux est **l'énoncé du ch. 1**, répété au ch. 2.
**Action — ne pas toucher aux règles :**
1. Corriger **p. 11** : soit écrire `Unr 𝑇 <∶ Aff 𝑇 <∶ Lin 𝑇`, soit conserver l'ordre écrit en le nommant par ce qu'il est — l'**ordre de précision** `⊑`, et non le sous-typage `≼`. La seconde option est la meilleure : elle préserve la justification donnée p. 11 (« une ressource utilisable exactement une fois s'affaiblit en ressource abandonnable »), qui décrit bien un affaiblissement de contrainte, donc une perte de précision — pas une subsomption.
2. Corriger **p. 74** en conséquence : la phrase « le pendant exact — mais inversé — de la restriction de ⊑ » devient vraie si et seulement si le ch. 1 a écrit `≼` ; telle quelle, elle affirme que `Lin <: Unr` est l'inverse de `⊑`, alors que c'est `⊑` lui-même.
3. **Faire remonter la table 20 dans les ch. 1 à 3**, comme F le demandait : c'est la remontée n° 6 de `TRANS-06`. Sans elle, trois chapitres portent une direction que l'annexe contredit.
4. Vérifier au passage les six autres emplois de `<∶` dans le corps (notamment §3.1 et §4.5) : la table normative p. 39 distingue `⊑` (précision) et `≼` (sous-typage modal, produit mixte) — **cette distinction existe déjà et n'est pas appliquée**.
**Gravité révisée :** **B** (structurel, défaut de propagation) et non **A**. Aucune règle n'est à réécrire, aucune preuve de l'annexe n'est invalidée. C'est un cas exemplaire de la cause racine `TRANS-05` : le document se corrige en avant et ne propage pas en arrière.

---

## 3. Lot STRUCT — défauts structurels

### `STRUCT-01` — Inversion d'antériorité : le jugement germinal n'est pas germinal
**Sources :** C/B-1, C/cause α · E/DEF-05 (triple présentation de la sédimentation) · G/§1.1 (le système est plus petit que ses 285 pages) · Q/§1.2 (le germe est l'adjonction valeurs/calculs, non le jugement).
**Localisation :** §1.4 (« Les quatre postulats trouvent leur expression conjointe dans un unique jugement de typage ») contre §2.4 (« Ce procédé n'est pas propre à la monotonie, et s'énonce une fois dans sa forme générale »).
**Constat :** l'ordre de dépendance réel est inverse de l'ordre d'exposition. Le jugement à trois composantes n'engendre pas les modalités ; il est ce qui reste quand on a décidé (a) qu'il y aurait des modalités graduées, (b) qu'elles se rangeraient en deux familles selon qu'elles contraignent l'entrée ou la sortie, (c) qu'une troisième strate recevrait les propositions. La preuve interne : les conditions d'ajout d'une composante énoncées au §1.4 sont exactement les conditions d'être une modalité graduée au sens du §2.4 ; le critère de placement est la trichotomie contravariant / covariant / propositionnel appliquée à une modalité.
**Deux conséquences non stylistiques :**
1. La condition de clôture est **énoncée au mauvais niveau**. Formulée sur le jugement, elle reçoit un contre-exemple (l'extension probabiliste) qui la rend seulement suffisante. Formulée sur la modalité — *toute extension doit être une modalité graduée sur une structure ordonnée* — l'extension probabiliste tombe sous le critère, et la vraie difficulté apparaît : la composition y est multiplicative sans être celle du semi-anneau des grades. Le contre-exemple révèle un défaut de niveau, non une insuffisance.
2. **Trois objets hors des trois strates, traités en trois endroits comme trois exceptions locales** : la zone d'échange (§3.1, « appartient au mode, non au grade »), la donnée de mode (§1.4, idéal de contraction et booléen d'affaiblissement), la modalité `•` indéfiniment reportable (§E.3.1, « elle est ajoutée »). Ce sont des **paramètres du système de modes**, et le document a déjà le vocabulaire pour les nommer (§3.1 cite Licata–Shulman–Riley, où le mode est le paramètre et où l'admissibilité de la coupure est démontrée indépendamment de la théorie des modes).
**Action :** poser au §1.4, **avant** le jugement : « Une *discipline* est un triplet (P, ≼, {!_p}_{p∈P}) où {!_p} est une famille de comonades graduées sur 𝒞. » Puis présenter le jugement germinal comme **la présentation d'un système à quatre paramètres** : un mode m (algèbre, idéal de contraction, booléen d'affaiblissement, prédicat d'échange) et trois familles de disciplines rangées par variance. La table 3 (sédimentation) et le critère de placement en découlent au lieu de les précéder.
**Volet GEMINI (DEF-05) :** la sédimentation est aujourd'hui présentée trois fois — trois équations (2, 3, 4), une table de fragments (table 3), un axe de polarité μF/νF — sans donner l'abstraction sous-jacente ; si l'une des trois évolue, les deux autres divergent. Remplacer par une unique famille de modes gradués sur 𝒞 où la polarité détermine les règles structurelles admises et le domaine de la quantale.
**Conséquences interchapitres :** §1.4 (réordonnancement, ≈ trois paragraphes) · §2.4 (devient une instanciation et non une découverte) · §3.1 (la zone cesse d'être une exception) · §E.3.1 (la modalité `•` cesse d'être un ajout non dérivé).
**Gain :** « 1 jugement + 8 instances + 3 exceptions » devient « 1 discipline + 11 instances ». C/évalue cette correction comme la plus rentable après `BLOQ-07`.

### `STRUCT-02` — Le monoïde ℳ est une pièce théorique nouvelle ; la condition de clôture est trop fortement énoncée
**Sources :** C/B-3 · F/CRIT-01 (proposition alternative) · D/6.3 (proposition inverse) · G/§11.
**Localisation :** §E.3.2, §E.3.3 ; §1.4 (« Trois réponses, trois domiciles, et aucune quatrième place à inventer »).
**Constat :** le §E.3.3 conduit lui-même la vérification et conclut *contre* le §E.3 : les transformateurs admissibles forment un monoïde d'endomorphismes agissant sur l'algèbre des effets, « structure supplémentaire, non une instance de celle du chapitre 1 ». Ce que le document ne tire pas : **ℳ est le seul objet du langage qui n'est ni une modalité graduée ni une projection**, donc le seul point où la condition de clôture est effectivement enfreinte. Ce n'est pas un coeffet (il n'agit pas sur Δ), pas un effet (il n'est pas dans ℰ, il agit *sur* ℰ), pas un raffinement. Avec la zone, la donnée de mode et `•` (cf. `STRUCT-01`), cela porte à **quatre** les objets hors strates.
**Action (restriction de domaine) :** réénoncer la condition de clôture en deux clauses.
- **Clôture forte** (sur les *données* du jugement) : toute extension apportant une donnée nouvelle se range en coeffet, effet ou raffinement — c'est ce que le §1.4 démontre, avec son contre-exemple probabiliste.
- **Clôture faible** (sur les *actions*) : toute extension apportant une action nouvelle sur ces données doit être un morphisme de la structure ordonnée concernée. ℳ y satisfait (monoïde d'endomorphismes monotones).

Sous cette forme, ℳ cesse d'être une exception, et **la même clause faible absorbe les trois autres objets hors strates**.
**Conséquences interchapitres :** §1.4 (dédoublement de la condition) · §E.3.3 (le verdict négatif devient un placement) · §3.1 (la zone est justifiée par la clôture faible).
**À préserver :** la construction entière de ℳ (deux générateurs, trois lois, formes normales, décidabilité de l'appartenance) est de bonne qualité, et le Th. 40 est correctement conditionné ; le §E.3.2 identifie même la fragilité exacte.
**Arbitrage requis :** F/CRIT-01 propose de remplacer ℳ par une théorie des *Hefty Algebras* ; D/6.3 recommande au contraire de maintenir la distinction entre effets algébriques et effets à portée. Voir `ARB-PR-03`.

### `STRUCT-03` — Un seul environnement normatif pour sept natures épistémiques ; quatre statuts incompatibles pour le Th. 27
**Sources :** Q/R-06, Q/RT-5 · G/A1 (fermeture épistémique) · C (table 1 et engagements manquants) · D/RC1.
**Localisation :** tout le document — 51 « Théorème n », chacun avec Déclaration, Esquisse et □ ; zéro environnement Définition, Lemme, Axiome, Proposition, Corollaire, Conjecture.
**Constat :** l'environnement unique fusionne dans un même mot, une même numérotation et un même symbole des natures qui ne se valent pas : théorème démontré (11, 12, 13, 38, 40, 42, 50) ; théorème sous hypothèse nommée (2, 4, 5, 8, 41, 43, 44, 49) ; résultat de littérature ré-énoncé (6, 13, 15, 37, 40) ; **conjecture explicite** (7, 10, 27, 36) ; **définition ou stipulation** (31, 34, 37) ; **propriété d'implémentation** (16, 18, 20, 25, 33, 35) ; **exigence sur un tiers** (26, seconde clause).
**Le cas du Th. 27 — sept mentions, trois statuts :**

| Lieu | Statut affirmé |
|---|---|
| ch. 1, table 1, p. 7 | « démontré à l'annexe » ; engagement **levé** |
| ch. 2, note p. 76 | « l'induction n'est qu'esquissée » |
| ch. 4 §4.6, p. 155 | « n'établit qu'en esquisse » |
| ch. 6 §6.3, p. 210 | « reste ouverte » |
| annexe E, intro p. 243 | « ce qui reste ouvert » |
| annexe E §E.4.6, p. 276 | « **est donc démontré** » |
| annexe E §E.6, p. 281 | « est démontrée » |

Même schéma pour la non-interférence : §E.4.4 p. 273 (« démontrée pour le fragment sans communication ») contre §E.5.5 p. 280 (« cessent d'être bornées au fragment sans communication »), **sans qu'aucune induction nouvelle ne soit conduite entre les deux**.
**Effet de bord :** le patron « S'il tient / S'il tombe » — excellente idée d'analyse d'impact — transforme 51 énoncés en 51 conditionnelles dont aucune n'est déchargée. L'état épistémique réel est « 51 conjectures avec analyse d'impact », et rien dans la typographie ne le dit.
**Action — cf. `TRANS-01` et `TRANS-05` :** quatre environnements (`DÉFINITION`, `THÉORÈME`, `PROPOSITION`, `EXIGENCE`) + un sceau de niveau ⟨langage | compilation | représentation | déploiement⟩ ; un registre unique des obligations `O-nn` ; une règle de propagation écrite au §1.2.
**Bénéfice mesuré par Q :** sur 51 énoncés, 8 démontrés sans réserve, 12 sous hypothèse nommée, 9 de littérature, 11 d'implémentation ou d'environnement, 6 définitions, 5 conjectures avouées. **Ce compte n'est nulle part dans le document.**

### `STRUCT-04` — La couche 2 est asynchrone au ch. 3, synchrone dans le noyau, SPSC au ch. 4
**Sources :** Q/R-07.
**Localisation :** ch. 3 §3.2 p. 104 ; annexe E.1-E.3 ; ch. 4 §4.5 p. 143 (Th. 25) et p. 134 (Disruptor).
**Constat :**
1. **Asynchrone contre synchrone.** L'encodage des protocoles en implications linéaires imbriquées donne une communication *synchrone* (l'application est un rendez-vous). Le document sait que l'écart est sémantique et déclare l'encodage nécessaire pour passer de l'asynchrone au synchrone — **mais le noyau ne contient que le synchrone et le ch. 3 déclare l'asynchrone : l'encodage requis est dans l'autre sens, et il n'est pas donné.**
2. **SPSC contre multi-producteurs.** Un anneau *single-producer single-consumer* ne peut pas être la boîte aux lettres d'un acteur qui reçoit de plusieurs émetteurs. Ou bien il y a un anneau par couple — et `M(x) ≠ ∅ ∧ M(y) ≠ ∅` porte sur deux anneaux distincts —, ou bien l'anneau est MPSC et le mot SPSC est une erreur. Dans les deux cas, l'atomicité affirmée (« échange atomique de pointeurs ») n'est pas établie : un échange atomique porte sur un mot, pas sur deux anneaux indépendants. C'est la consommation multi-places d'un motif de jonction : il faut un verrou, une séquence CAS avec reprise, ou une file de jonction dédiée (solution du join-calculus de Fournet–Gonthier, déjà cité [60] — cf. `BIB-04`).
3. **Le Th. 25 est un énoncé mixte.** La direction ⟸ suppose l'ordonnancement, la disjonction des motifs et l'absence de concurrence sur `M` ; la direction ⟹ suppose que rien d'autre ne consomme x et y entre-temps. Aucune n'est dans l'esquisse.
**Action :** (i) remplacer « SPSC » par la structure réelle — « un anneau par couple (émetteur, récepteur) et une file de jonction par acteur pour l'appariement atomique », ou « MPSC » — et écrire le protocole d'appariement en trois lignes ; (ii) restreindre le Th. 25 à la seule direction dont l'architecture a besoin (⟹), l'autre relevant de l'ordonnanceur ; (iii) dire une fois, au §3.2, que le noyau formel est synchrone et que l'asynchronie est une propriété de l'abaissement.
**À préserver :** RMQ 29 (« K7PL revendique l'atomicité locale et non la localité ») évite exactement le piège de Herlihy–Wing ; le choix de la partition disjointe et exhaustive pour supprimer le non-déterminisme des jonctions est bien argumenté.
**Gain :** boîte aux lettres et file de jonction sont le même objet — `Mailbox = Σ_{c∈Chan} Bag(Cap(c))` — cf. `FACT-11`.

### `STRUCT-05` — La trace τ est à la fois grandeur de coût à optimiser et observable de sûreté à préserver ; aucun invariant de passe n'est déclaré
**Sources :** Q/R-08, Q/RT-4 · E/§4 (rupture de la chaîne phase 3 / phase 6) · D/10.4 (boucle cachée) · G/R1.
**Localisation :** annexe E.4 p. 265-266 ; E.4.3 p. 271 ; E.4.6 p. 275-276 ; ch. 6 §6.1 p. 200-201 et §6.3 p. 209-210 ; ch. 4 §4.5 p. 137 (évaluation semi-naïve) ; ch. 1 P1 p. 10.
**Constat :** trois candidats d'invariant coexistent sans être distingués — la dénotation (P1), le jugement gradué (Th. 36), la trace ou la trace projetée (Th. 47, §E.4.6) — et ils ne sont pas comparables. Si la durée est observable au niveau ℓ, alors fusion de boucles, déforestation et inlining **ne sont pas admissibles** dans du code où la non-interférence temporelle est revendiquée. Réciproquement, exiger `fix f` itéré exactement h fois interdit l'évaluation semi-naïve que le §4.5 déclare indispensable. **C'est un conflit entre deux des quatre postulats** : P3 veut le coût minimisé (donc optimisé), la composante de niveau veut le coût non divulgant (donc fixé). Le conflit est chiffrable : sur un univers de constantes de taille 10⁶, un facteur 10⁵.
**Volet GEMINI :** la phase 3 calcule l'itération des effets dans la quantale à partir des bornes de boucles, mais la phase 6 (inlining, résorption statique) modifie le graphe de contrôle et élimine des suspensions. Si l'évaluation des coûts est faite en phase 3 sur la syntaxe de surface, la borne calculée ne correspond pas au code émis en phase 8. **Dépendance circulaire non résolue entre inlining et certification du budget.**
**Volet DEEPSEEK :** la phase 6 peut régénérer des contraintes de grade que la phase 5 a déchargées ; le document détecte la boucle et fournit un argument de terminaison (Th. 33) — à intégrer à la déclaration ci-dessous.
**Action (une déclaration, trois lemmes) — cf. `TRANS-04` :** déclarer au ch. 6 un **ordre de préservation** —

| Invariant | Objet | Qui doit le préserver |
|---|---|---|
| `P-dén` | dénotation dans 𝒞 | toutes les passes (P1) |
| `P-grad` | jugement gradué `Δ ⊢_𝒢 c : C ∣ ε` | passes d'abaissement (Th. 36) |
| `P-trace(ℓ)` | `π_ℓ(τ)` | passes appliquées à une unité ℓ-sensible |
| `P-repr` | identité binaire de l'état observable | environnement (E_repro élargi, cf. `PORT-04`) |

— puis écrire la règle d'interaction : *une unité marquée ℓ-sensible n'admet que les passes P-trace(ℓ)*. Résultat : `fix f` itéré h fois dans le code ℓ-sensible, semi-naïf ailleurs ; fusion et déforestation admises partout sauf dans le code ℓ-sensible ; le ch. 6 retrouve sa liberté et le §E.4.6 sa contrainte, sans contradiction. Le marquage ℓ-sensible est la composante de niveau déjà possédée : **aucun mécanisme nouveau**.
**Effet de bord :** le Th. 36 devient « P-grad est l'obligation de chaque passe » — forme sous laquelle il est mécanisable passe par passe ; l'engagement « reproductibilité de la compilation » reçoit un critère.
**À préserver :** l'analyse en potentiel du Th. 43 (`τ · ε` décroissant, potentiel transféré et non consommé) et l'identification du budget comme potentiel sont justes et tiennent.

### `STRUCT-06` — Le pipeline n'a pas de Phase 0 ; « élaboration » désigne deux opérations différentes
**Sources :** Q/R-09 points 1, 2 et 4 · D/10.1 (l'inventaire des phases, qui numérote la phase 0 hors figure).
**Localisation :** ch. 6 §6.1 p. 191 (figure 11), §6.2 p. 198, §6.3 p. 208 ; ch. 5 §5.2-§5.4 (sept occurrences de « phase 0 ») ; ch. 3 §3.3 p. 109-110 ; ch. 1 §1.4 p. 32 ; ch. 2 §2.1 p. 45 ; annexe E.2 p. 246.
**Constat :**
1. **La phase 0 n'existe pas dans le pipeline.** Elle est invoquée dix fois et porte : l'exécution des macros *avant toute vérification*, le bac à sable complet, la staticité de la syntaxe (Th. 29), la résolution de `bind-to`, et la frontière de confiance du §3.3. La figure 11 commence à la phase 1. Un pipeline se déclarant « un ordre que rien ne permet d'inverser » omet la phase qui doit précéder toutes les autres.
2. **« Élaboration » a deux sens.** Au ch. 5, `Elab : Surface → Noyau` désucre les six formes de surface, *expansion de macro incluse*. Au ch. 6, la phase 2.5 « referme la composante A du jugement » : elle reçoit les `pack`/`unpack` explicites et résout les variables d'unification — travail *postérieur* au typage. L'expansion de macro est donc à la fois « phase 0, avant toute vérification » et « phase 2.5, après le typage ». **Le confinement de la phase 0 et le Th. 29 dépendent de l'antériorité ; la résolution des existentielles dépend de la postériorité.**
**Action :** (i) ajouter **Phase 0 : Expansion** à la figure 11 — l'annexe E dit que les macros opèrent « sur l'arbre », donc *après* Parse : la numérotation « 0 » devient trompeuse, il faut la renommer 1.5 ou déplacer Parse en 0 ; (ii) renommer la phase 2.5 en **Résolution** (ou *Généralisation*) et écrire au §5.3 : « le mot élaboration désigne ici Surface → Noyau ; la phase 2.5 est une résolution de variables d'unification, qui n'est pas une élaboration au sens du théorème 31 ».
**À préserver :** l'exigence de compilation bornée (§6.2) et la clause « un compte de ressource, jamais un délai » ; la clôture des trois voies de recours (§6.2.2) ; le Th. 33 ; la table 12.

### `STRUCT-07` — Le Th. 39 ne prouve pas la cohérence du sous-typage : l'existence de joints n'est pas la cohérence des coercions
**Sources :** G/B1, G/R2.
**Localisation :** annexe E.3, Th. 39.
**Constat :** la preuve annoncée interprète les coercions, élimine réflexivité et transitivité, pousse la subsomption jusqu'aux règles d'introduction, puis invoque l'existence des jointures. Or elle établit `a, b ≤ c ⟹ a ⊔ b existe` ; il faut encore `p₁ : A <: B, p₂ : A <: B ⟹ ⟦p₁⟧ = ⟦p₂⟧`. **La question centrale n'est pas la structure d'ordre mais la cohérence de l'interprétation des preuves de sous-typage** — c'est pourquoi la littérature traite la cohérence des sémantiques de coercions comme un problème autonome (cf. `BIB-05`).
**Contre-exemple structurel :** un ordre où deux chemins distincts mènent au même majorant ; l'existence du majorant ne garantit pas l'identité des deux compositions de coercions. Le produit des quatre ordres peut avoir toutes les jointures nécessaires tout en portant des coercions différentes.
**Action :** introduire explicitement une propriété de cohérence des coercions **par facteur** — `p₁, p₂ : r ≼ r′ ⟹ coe_{p₁} = coe_{p₂}` (ou égalité des deux interprétations selon la sémantique visée) — puis seulement montrer la fermeture par produit. Cf. `PREUVE-10` et `FACT-05`.
**Conséquences interchapitres :** CASE, SUB, SUBBOX, recherche dirigée par le type, Th. 28, et toute correction de compilation raisonnant modulo le typage.
**Gain :** G qualifie ce résultat de « dette la plus importante du noyau typé » et le candidat aspirateur pour tout le sous-typage.

### `STRUCT-08` — Le système de raffinement (Th. 9) est conditionnel à une traduction encore ouverte (Th. 27)
**Sources :** G/B2 · Q/R-06 (antériorité inversée : le ch. 2 utilise un résultat du ch. 4) · D/12.2.
**Localisation :** §2.5 (Th. 9) et §4.6 (Th. 27).
**Constat :** le Th. 9 définit la structure de raffinement à partir de `⟦·⟧`, elle-même couverte par le Th. 27, dont la preuve n'est qu'esquissée. La dépendance est normale ; ce qui ne l'est pas, c'est que le texte parle ensuite du système de raffinement comme d'une structure établie.
**Action :** reformuler le Th. 9 sous forme conditionnelle — « si `⟦·⟧` est un foncteur type-préservant, alors … » — puis transformer le Th. 27 en dette unique acquittant cette condition. **Le refinement system devient un théorème de fermeture, non une nouvelle construction.**

### `STRUCT-09` — « Tout le non-déterminisme est journalisé » est une obligation sémantique, pas une conséquence de la pureté
**Sources :** G/B5 · Q/R-25 point 3 · D/11.
**Localisation :** Th. 22 (§4.5).
**Constat :** le Th. 22 suppose que les sources non déterministes sont injectées comme capacités et journalisées. Une démonstration complète exige une **propriété de complétude du journal** : `∀ choix influençant Obs, ∃ entrée journalisée correspondante`. Cette propriété ne découle pas de la pureté. Elle importe pour : ordre des messages, pertes et duplications réseau, reprise après panne, ordonnancement, décisions du runtime, résultats FFI, interactions avec l'environnement. Le manuscrit traite bien horloge, hasard et latence — « le journal contient tout ce qui compte » est une propriété distincte.
**Action :** faire du journal un **paramètre de l'hypothèse de rejeu** et définir une fonction d'observation telle que chaque événement extérieur observable possède une entrée. C'est exactement la « borne inférieure » que le §1.3 déclare manquante.
**Lien :** cette hypothèse devient nommée et non implicite une fois la sémantique d'instructions écrite (cf. `STRUCT-15`).

### `STRUCT-10` — L'histomorphisme réclame une loi distributive qui n'était pas dans le noyau
**Sources :** G/B8 · C/F-4(b) (qui valide la distinction des deux comonades).
**Localisation :** §2.3.
**Constat :** le texte identifie correctement une loi `λ : F ∘ N ⇒ N ∘ F` pour obtenir la structure d'histomorphisme, et remarque lui-même qu'elle est distincte de la loi distributive graduée déjà présente. Le problème n'est pas le concept mais **la formulation de clôture** : le mécanisme est parfois présenté comme absorbé par le noyau existant alors qu'il requiert une donnée structurelle supplémentaire `(F, N, λ)`. Qu'elle soit théoriquement standard ne la fait pas disparaître.
**Action :** classer explicitement `λ` comme structure dérivée nécessaire à l'instance « historique », et non comme conséquence gratuite de `!^r`. La factorisation est préservée sous la forme *noyau + instance historique*.
**Voir aussi :** `REFUS-02` (ne pas fusionner les deux comonades) et `PREUVE-08` (la troncature).

### `STRUCT-11` — Les effets à portée ne sont pas absorbés par ℰ ; ℰ_alg et ℰ_scoped doivent être distingués dans la structure
**Sources :** G/§11 · D/Obs. 2 · F/CRIT-01 · C/B-3.
**Localisation :** §2.3, §3.3, §E.3.2.
**Constat :** le manuscrit dit explicitement que les opérations à portée sortent du cadre des effets algébriques ordinaires et réclament des théories algébriques paramétrées — puis la grammaire finale donne `ε = ⟨φ, κ⟩ ∈ ℰ` et les règles continuent de parler du même objet global. Le danger est de laisser entendre `effet algébrique = effet à portée` alors que le texte vient de dire le contraire. Le corps du texte ne signale pas que les deux ont une métathéorie différente ; seule l'annexe (§E.3.2) distingue proprement via `scoped_f(v,c)`.
**Action (sans primitive nouvelle) :** faire de la distinction `ℰ_alg` / `ℰ_scoped` une distinction **mathématique dans la structure existante**, puis définir leur interaction. Remonter la distinction de l'annexe dans les chapitres.
**Volet FLASH (CRIT-01) — à arbitrer, cf. `ARB-PR-03` :** identifier un gestionnaire à son action syntaxique globale `⟨φ_n, π_S⟩` sur la trace d'effet détruirait la modularité : deux gestionnaires de même signature d'effet mais de stratégies d'interception différentes cessent d'être interchangeables, et un gestionnaire tiers ne peut être substitué sans recompilation globale. Contre-exemple : `H₁` intercepte `{log}`, `H₂` intercepte `{log}` mais émet `{write_raw}` ; même abstraction en surface, appartenances différentes à ℳ. Correction proposée par F : remplacer ℳ par les *Hefty Algebras* (cf. `BIB-01`), où l'élaboration des effets d'ordre supérieur est factorisée en une algèbre paramétrée par les clauses de retour et d'opérations. Conséquence annoncée : la phase 6 n'aurait plus besoin de l'hypothèse de présentation libre sans relation croisée (Th. 40).
**À préserver :** la sémantique opérationnelle de délimitation à petits pas avec pile de contextes (p. 265) est saine et préserve le potentiel.

### `STRUCT-12` — Hygiène syntaxique et hygiène quantitative : le Th. 31 ne doit pas hériter automatiquement du Th. 30
**Sources :** G/§12 · Q/R-30(a).
**Localisation :** Th. 30 (§5.4), Th. 31 (§5.3), §5.2 p. 175.
**Constat :** le Th. 30 démontre `(Mθ)[σ] = (M[σ])θ` pour l'AST **non gradué**, et précise lui-même que l'extension au comportement quantitatif des macros reste ouverte (une macro qui utilise deux fois son argument demande de savoir ce qu'elle déclare de ses ressources). Le Th. 31 affirme ensuite que l'élaboration transporte les grades « sans les relâcher ». L'hygiène syntaxique est démontrée ; hygiène + usage quantitatif ne l'est pas.
**Action :** scinder `Elab_erase` (démontré par le Th. 30) et `Elab_graded` (extension conditionnelle nécessitant la signature quantitative des macros, que le §5.4.1 referme par le grade déclaré `r_i`). Formuler `Th. 30-nu` et `Th. 30-gradué`.
**Seconde réserve (Q) :** l'énoncé porte sur la métasubstitution dans l'AST du noyau, quand le but usuel est la préservation de l'α-équivalence **de surface** — qui ne s'en déduit pas sans une algèbre de liaison de la surface, non construite. Ajouter une **EXIGENCE de resucrage** (cf. `BIB-13`).

### `STRUCT-13` — La discipline d'échange est « voie retenue » au ch. 3, « envisagée » au ch. 4 et à l'annexe, « absente » dans les règles
**Sources :** Q/R-29.
**Localisation :** ch. 3 §3.1 p. 89-91 ; ch. 4 §4.6 p. 153 ; annexe E.3 p. 246 ; E.3.5 p. 263.
**Constat :** un même choix de conception est **arrêté** dans un chapitre et **hypothétique** dans trois autres. Le ch. 3 en tire quatre conséquences : une condition sur `Cont(m)` et `Exch(q₁,q₂)` ; une condition de bord au lemme de substitution ; un lemme supplémentaire pour la substitution simultanée ; et une **perte à la traduction** (la composition parallèle de la cible étant commutative, l'ordre d'une zone n'a pas d'image — « toute propriété de la source dérivée de la traduction devrait être revérifiée, l'acyclicité du ch. 4 en étant une »). **Si la voie est retenue, la quatrième conséquence invalide rétrospectivement les Th. 17 et 24.** L'annexe tranche de fait pour la non-adoption (contextes = applications finies, échange admissible), ce qui est cohérent avec l'encodage en ⊸ et la commutativité de la cible.
**Action :** trancher et écrire la décision une fois au §3.1, avec les quatre conséquences marquées *actives* ou *conditionnelles*. Lecture recommandée par Q : le document **n'adopte pas** la discipline d'échange ; remplacer « La voie retenue » par « La voie disponible, dont le prix est chiffré ci-après ». **Coût : deux mots.**
**À préserver :** l'analyse du ch. 3 est de haute qualité — les trois besoins indépendants d'ordre, l'argument contre le contexte ordonné unique, le rejet de la zone comme composante du grade avec sa raison algébrique exacte, le dilemme contraction/décidabilité des sous-exponentielles, et l'identification de la perte à la traduction.

### `STRUCT-14` — `𝒢_pile` et `𝒢_budget`, sous-algèbres qui *définissent* les couches, ne sont jamais construites
**Sources :** Q/R-28.
**Localisation :** ch. 1 §1.4 p. 35-36 (équations 2, 3, 4 et figure 1) ; ch. 2 §2.2 ; annexe E.4 p. 267.
**Constat :** la définition formelle des trois couches — déclarée unique et suffisante (« Cette spécialisation, et elle seule, constitue la définition formelle des trois couches ») — repose sur deux objets sans générateurs, sans clôture, sans inclusion dans ℛ, sans opérations. Et l'argument d'amortissement de l'annexe en dépend : la quatrième condition (non-duplication d'un porteur de potentiel) tient parce que la couche 3 « n'a pas d'effets du tout », c'est-à-dire `𝒢_pile` sans composante de budget — propriété d'un objet non défini.
**Tension connexe :** P3 contre la table 7 (niveau 4, « tas avec ownership », couche 2, « O(1) amorti »), que le ch. 1 déclare « s'instruire » alors que P3 est un postulat non révisable.
**Action :** deux définitions d'une ligne, par projection du produit (`TRANS-02`) — `𝒢_pile = 𝕌 × {d} × ℒ × {0}` (budget nul) ; `𝒢_budget = 𝕌 × {d,m} × ℒ × ℕ∞` — puis écrire la clause de portée de P3 : « P3 gouverne la borne synthétisée et l'admission à la bibliothèque ; il ne gouverne ni le coût de compilation, ni l'amortissement interne d'un régime de mémoire, à la condition que la borne synthétisée soit celle du pire cas » (les deux moitiés sont déjà écrites p. 14 et p. 15). Cf. `PORT-09`.
**Gain :** les trois couches deviennent trois **préimages** — couche 3 = `π_𝔅^{-1}({0}) ∩ π_𝕌^{-1}({ω})`, couche 2 = fragment affine × budget libre, couche 1 = fragment linéaire × budget fini —, donc une fonction `couche ↦ contrainte sur ℛ` mécaniquement vérifiable.

### `STRUCT-15` — « Gestionnaire » désigne deux objets de niveaux différents ; l'hypothèse de pureté du Th. 22 renvoie à des sections qui ne la contiennent pas
**Sources :** Q/R-25.
**Localisation :** ch. 2 §2.3 p. 56 et p. 66 ; ch. 1 §1.4 p. 23 ; ch. 4 §4.5 p. 134 (Th. 22, renvoi « ch. 3 §3.3 ») ; ch. 7 §7.2 p. 217 (renvoi « ch. 2 §2.3 »).
**Constat :**
1. **Deux objets, un mot.** (a) Le gestionnaire d'acteur : `(Message × État) → HandlerResult`, couche 2, défini par copatrons. (b) Le gestionnaire d'effet : une F-algèbre sur R, c'est-à-dire une *interprétation* d'opérations, qui par définition **élimine** un effet. Les deux sont dans la même section, à dix pages d'écart, sans distinction.
2. **Les deux renvois de la pureté sont faux.** Le ch. 3 §3.3 n'affirme nulle part que les gestionnaires de couche 2 sont purs ; le ch. 2 §2.3 les définit comme morphismes d'algèbres, donc comme interprètes d'effets — le contraire d'une fonction pure.
3. **Tension avec la couche 2 elle-même :** l'équation (3) donne `ℰ ∋ tick` ; si les gestionnaires étaient purs, aucun effet n'y serait produit.
**Action :**
- Deux mots distincts — **gestionnaire d'acteur** et **gestionnaire d'effet** — ajoutés à la liste des mots à sens fixe du §1.2 (le document a déjà cette liste).
- Écrire la **sémantique d'instructions** qui réconcilie tout : « un gestionnaire d'acteur est une fonction pure `(Message × État) → HandlerResult` ; le HandlerResult est une *description* d'effets, exécutée par le runtime ; c'est cette exécution qui est journalisée ». Corriger les deux renvois vers cette définition.
- Le Th. 22 gagne alors une hypothèse nommée : **complétude de la journalisation** (cf. `STRUCT-09`).
**Gain :** la sémantique d'instructions unifie HandlerResult, trace τ, ré-invocation séquentielle d'un grade fini et itération `φ_n` de SC — toutes des listes d'instructions sur lesquelles on plie, c'est-à-dire le `μF` du ch. 2 lu comme syntaxe libre d'effets. Le document possède l'objet (§2.3 p. 66) et ne l'emploie pas pour le HandlerResult.

### `STRUCT-16` — Quatre régimes de grade théoriques, trois exposés : la clôture n'est pas établie
**Sources :** G/§10.
**Constat :** la construction générale produit `Lin, Aff, Rel, Unr` ; K7PL n'en expose que trois. Le choix de langage est légitime, mais l'algèbre des grades et la relation de sous-typage sont développées sur la structure générale tandis que les garanties syntaxiques portent sur le sous-ensemble exposé.
**Action :** établir explicitement `Reachable_K7PL ⊆ {Lin, Aff, Unr}` et, surtout, que **les opérations de dérivation ne produisent jamais `Rel`**. Sans cela subsiste une distinction implicite entre grades mathématiquement admissibles et grades effectivement générables. Le document commence à formaliser cette distinction ailleurs pour les produits de grades : la solution est à portée.

### `STRUCT-17` — Quatre concepts de monotonie portent un seul nom
**Sources :** D/Obs. 3, D/6.4.
**Constat :** (1) monotonie comme composante de grade (§2.4) ; (2) monotonie de l'opérateur de point fixe (Th. 8) ; (3) monotonie de la composition et du tenseur, 𝒞 enrichie sur les préordres (§2.4) ; (4) monotonie des règles Datalog (§4.5). (1) et (3) portent sur des fonctions préservant un ordre ; (2) sur un domaine muni d'un ordre ; (4) sur la positivité des corps de règles. Le §2.4 affirme que « la monotonie est une propriété déclarée et vérifiée plutôt qu'une obligation de preuve », ce qui confond la préservation d'ordre par la fonction et la structure d'ordre du domaine.
**Action :** distinguer nommément — fonctions préservant l'ordre `f : S →_mon S` (composante de grade) ; domaines ordonnés (`Trellis_fin`) ; ensembles de règles monotones (méta-propriété du programme). Puis, si l'on veut la factorisation (`FACT-14`) : un type monotone est un type muni d'un ordre, une fonction monotone le préserve, le point fixe est défini sur les types monotones, les règles Datalog se compilent en fonctions monotones — ce qui rend explicite le lien entre la composante `m` et l'opérateur de point fixe.

### `STRUCT-18` — Surcharge de `⊗` : tenseur catégorique, composition de contextes, opération syntaxique du jugement
**Sources :** D/3.1 et 3.4 · F/COL-02.
**Constat :** trois sens liés mais non identiques — opération catégorique (§2.1), opération induite sur les contextes (§2.4), opération syntaxique dans le jugement (§4.2). De plus, dans une SMCC, `⊗` n'est pas cartésien : la structure cartésienne n'est fournie par `!_r` que sur les objets de la forme `!_r A`. Le §2.2 est prudent, mais la distinction n'est pas visible dans l'exposition. **`Δ₁ ⊗ Δ₂` n'a pas de sens algébrique** : l'opération légitime sur les contextes gradués est l'addition point par point `Δ₁ + Δ₂` ou la composition sous effet `Δ₁ ⊠_ε Δ₂` (F/COL-02 relève l'emploi de `Γ₁ ⊗ Γ₂` au ch. 2 p. 46 et ch. 4 p. 130).
**Action :** notation explicite dans le corps du texte, comme l'annexe le fait déjà — `Δ₁ + Δ₂` pour la composition de contextes, `A ⊗ B` pour le tenseur de types, `⊠_ε` pour la composition sensible à l'effet, `⊗_𝒞` pour le tenseur catégorique. Cf. `NOTA-01`.

### `STRUCT-19` — La distinction compilation / exécution est une phase, pas encore une modalité
**Sources :** D/4.1 et 7.3.
**Constat :** la phase 8 efface « tout ce qui appartient à la compilation », mais cette distinction repose sur une nécessité modale (le code sous `□` est disponible à la compilation) que le §1.4 reconnaît (« c'est une modalité de nécessité ») sans la formaliser. Le document emploie donc « compile-time » à la fois comme phase (phase 0, macros) et comme propriété modale (non-interférence) : deux niveaux.
**Action :** formaliser la distinction comme **modalité**, et faire de l'effacement de phase une instance du schéma de restriction (`FACT-02`), l'ordre étant le treillis à deux points.

### `STRUCT-20` — La loi distributive graduée : signature sous-déterminée et règles non écrites
**Sources :** E/DEF-02 · D/5.4 · D/5.5 (gradation indexée).
**Localisation :** ch. 1 §1.4 p. 24-25 (axiomatique germinale, table 2) ; ch. 2 §2.4 ; ch. 6 §6.1 ; annexe E.3, E.3.3, E.3.4.
**Constat (E/DEF-02) :** `φ` est introduite comme `φ : G × ℰ → ℰ`, mais sa définition explicite utilise une variable `n` (multiplicité d'exécution du calcul) tout en affirmant que `n ∉ G` et `n ≠ u`. **`φ(r, ε)` est donc incapable de calculer `ε^n` à partir de ses seuls arguments.** Contre-exemple : pour `r = ⟨u=1, disc, pub, β=100⟩`, `φ(r, tick)` ne peut décider entre `tick¹`, `tick¹⁰` et `tick^∞` sans connaître le nombre d'itérations de la boucle englobante.
**Constat (D/5.4) :** les lois gouvernant `φ` et `ψ` sont énoncées (table 2), mais la transformation `λ_{r,ε} : !^r ∘ T_ε ⇒ T_{φ(r,ε)} ∘ !^{ψ(r,ε)}` n'est pas spécifiée ; le §E.3.3 dit que « ces deux règles ne sont pas écrites ». LET et APP supposent la loi sans l'énoncer.
**Constat (D/5.5) :** la gradation indexée qu'exigent les effets dépendant de valeurs est classée « nommé, non posé » — or le système revendique des types dépendants gradués, donc une dépendance des grades aux *valeurs* et non seulement aux types.
**Action :** (i) incorporer la multiplicité d'exécution comme coordonnée explicite de la composante d'usage, **ou** faire de `φ` une fonction indexée par le combinateur de contrôle ; (ii) écrire explicitement les règles de la loi distributive et vérifier leurs conditions de cohérence (cf. `PREUVE-05`) ; (iii) définir le cadre de monade graduée indexée et prouver le lemme de substitution correspondant — le Th. 41 en fournit déjà la forme (cf. `PREUVE-06`).
**Conséquences interchapitres :** table 2 du ch. 1 ; construction de la loi au ch. 2 §2.4 ; vérification des boucles au ch. 6 §6.1.

### `STRUCT-21` — Tension non résolue entre appel par poussée de valeur, types dépendants et effets indexés
**Sources :** E/DEF-04.
**Localisation :** ch. 1 §1.4 p. 29-31 ; annexe E (Th. 1 / Th. 41).
**Constat :** le document affirme que le cadre PBV résout l'incompatibilité établie par Castellan et al. entre effets observables, élimination dépendante et lemme de substitution, « son lemme de substitution ne substituant que des valeurs ». C'est vrai pour la consistance logique. Mais les types dépendent d'indices de taille qui **modifient les annotations d'effet** (un parcours de tableau effectue N ticks) : substituer une valeur d'indice change l'effet (`tick^N`). Pour que le lemme de substitution vaille sur `Δ ⊢_𝒢 t : A ∣ ℰ`, il faut prouver que la quantale et l'itération `ε^n` sont **stables par substitution d'indices** — preuve annoncée comme découlant du Th. 1, alors que l'annexe ne traite que le cas sans dépendance d'indices dynamiques.
**Action :** formuler le lemme de substitution d'indices comme propriété séparée et restreindre les indices intervenant dans les effets aux termes clos à la compilation ; étendre le Th. 1 / Th. 41 en conséquence. Cf. `PREUVE-06`.

### `STRUCT-22` — L'orthogonalité annoncée par P2 est rompue en trois points
**Sources :** F/§3.
**Constat :** P2 affirme l'indépendance de l'axe d'usage (modalités linéaires/affines/non restreintes) et de l'axe de valeur (prédicats, intervalles, typestates). Trois couplages la contredisent :
1. **Destinations** (p. 96) : `Lin_k T` indexe la modalité linéaire par un paramètre d'âge `k` — le grade d'usage n'est plus indépendant de la valeur de structure.
2. **Élimination des existentiels** (p. 100 et 108) : `OPEN` interdit la projection implicite si le témoin porte un grade effaçable — le comportement de typage de la valeur dépend du grade du contexte.
3. **Point fixe déductif** (p. 72-73) : `fix f` exige `S ∈ Trellis_fin` — la règle de typage inspecte la structure sémantique du type de valeur pour autoriser la dérivation d'effet.
**Action :** énoncer P2 comme **orthogonalité au niveau du jugement**, avec les trois couplages nommés comme *interfaces contrôlées* entre les deux axes, chacun justifié séparément. Ne pas laisser P2 en affirmation non qualifiée.
**Lien :** (1) rejoint `FACT-17` (l'âge comme mesure décroissante) ; (3) rejoint `BLOQ-06` et `FACT-03`.

### `STRUCT-23` — L'annexe E est une fondation tardive ; le jeu de règles doit remonter dans le corps
**Sources :** D/RC3 et RC4 · C/cause α · Q/RT-5.
**Constat :** l'annexe contient les définitions et preuves que le corps suppose ; le corps renvoie à l'annexe pour les « preuves ouvertes » sans que la formalisation soit intégrée. Le §1.1 classe « le jeu de règles de typage lui-même » en « nommé, non posé » — alors que les règles **existent** au §E.3 ; ce qui suspend les preuves est leur incomplétude (`BLOQ-01`) et les objets manquants de `TRANS-02`/`TRANS-03`, non leur absence.
**Action :** (i) intégrer le jeu de règles dans le corps (ch. 3), l'annexe ne conservant que les preuves ; (ii) mettre à jour le §1.1 : la phrase « l'absence du jeu de règles est ce qui suspend les quatre preuves ouvertes » est aujourd'hui fausse et doit être remplacée par le diagnostic réel.

---

## 4. Lot PORT — défauts de portée et sur-affirmations

> Dans ce lot, l'idée est juste et la correction consiste presque toujours à **restreindre, conditionner ou renommer**. Plusieurs de ces réserves sont déjà écrites dans le manuscrit : ce qui manque est la réécriture de l'énoncé qu'elles bornent (cf. `TRANS-08`).

### `PORT-01` — Zéro-copie : trois affirmations de portées inégales présentées comme une seule ; Th. 20 sans paramètre de version
**Sources :** C/C-1 · Q/R-16 · G/§13 · F/COL-05 · D/8.3 et Obj. 6.
**Localisation :** Th. 20 (§4.3 p. 128-129, RMQ 26, note a) ; §4.5 (gel d'acteur) ; ch. 6 §6.1 (génération de code) ; ch. 1 §1.1 p. 5 (R1 « Arrêté »).
**Constat :**
1. **Le Th. 20 lui-même est exemplaire** : domaine exact (scalaires primitifs de largeur fixe), échec hors domaine nommé (transposition `O(n)` pour les structures), spécifications normatives citées, et déclaration de ce que les sources ne donnent pas. **Il n'est pas critiqué.**
2. **Le ch. 6 perd la condition** : « les correspondances rendent cette génération de code directe », sans rappeler qu'elle ne l'est que sur les scalaires. Une affirmation non conditionnée dans le chapitre qui alimente les décisions d'implémentation produit un compilateur qui suppose le zéro-copie partout et le découvre faux au premier message contenant une liste de structures.
3. **Aucun paramètre de version** (Q) : la vérité de l'énoncé dépend de la spécification Arrow (bitmap omis licite quand `null_count = 0`, alignement 8 ou 64), de Cap'n Proto (liste plate, encodage de pointeur, alignement 8, composite pour les structures), de l'abaissement MLIR et de l'ordre des champs. Or le ch. 1 déclare ces correspondances **arrêtées** — intenable pour une propriété fonction de spécifications tierces évolutives, alors que le document a déjà la bonne réponse pour un cas voisin (la convention d'élision appartient à la version de schéma).
4. **Deux précisions techniques manquent** (Q, G) : l'**endianness** — ni Arrow ni Cap'n Proto ne fixent l'ordre des octets comme invariant portable sans déclaration — et le sens exact de « sans copie » : le transfert exige l'écriture d'un mot de pointeur de liste et, côté Cap'n Proto, que le tampon soit déjà un segment de message aligné (obtenu par l'arène PIA, mais c'est une *condition*, pas une conséquence). G ajoute : signedness, représentation IEEE, bourrage, alignement exact, propriété et durée de vie, mutabilité.
5. **Glissement de niveau** (F/COL-05) : un isomorphisme `Hom_𝒞(Fin(n), T) ≅ T^n` dans une catégorie abstraite n'implique pas l'identité des représentations mémoire concrètes. L'isomorphisme catégorique reste vrai ; le coût physique passe de `O(1)` à une transposition `O(n)`.
**Action :** (i) clause de rappel au §6.1 : « directe *dans le domaine du théorème 20*, une transposition en `O(n)` étant requise dès qu'une liste de structures est en jeu » — **coût : une phrase** ; (ii) ajouter trois paramètres `vArrow`, `vCapnp`, `vMLIR` à l'énoncé et la clause « la coïncidence est vérifiée à la compilation par comparaison des trois entiers (largeur de créneau, alignement, ordre des champs) pour la version de schéma de l'artefact » ; (iii) retirer le statut « Arrêté » de cette ligne du §1.1, ou le restreindre au *domaine exact* (scalaires oui, structures non) ; (iv) requalifier en **PROPOSITION ⟨représentation⟩** ; (v) ajouter endianness et conditions d'alignement.
**Gain :** la même mise en paramètre s'applique au Th. 18 et au modèle mémoire, et donne un **profil de représentation** unique `Π = ⟨vArrow, vCapnp, vMLIR, arch, modèle mémoire, mode d'arrondi, version de schéma⟩` — cf. `IMPL-06`.

### `PORT-02` — « L'isolation repose entièrement sur les types » : la réserve est écrite, l'affirmation n'est pas corrigée
**Sources :** C/C-2 · G/B4 · E/§3.2 · D/Obj. 7 · Q/R-10.
**Localisation :** §4.5, premier paragraphe ; Th. 26.
**Constat :** le document énonce l'objection (les résultats de sûreté robuste portent sur des langages à modèle mémoire *abstrait*, l'unikernel a un modèle *concret*, du code non fiable peut y calculer une adresse) et **ne modifie pas l'affirmation**. Le mot « entièrement » demeure, et il est faux : l'isolation repose sur les types *plus* l'hypothèse qu'aucun code étranger n'entre — hypothèse fausse puisque le §4.5 construit une passerelle FFI. Le Th. 26 le confirme : sa seconde clause est explicitement déclarée non démontrée et repose sur la discipline de représentation de la passerelle — « exactement ce qu'une MMU fournirait indépendamment de tout bogue de compilateur ». E ajoute que la terminalité de la coalgèbre garantit l'indiscernabilité comportementale au niveau logique mais ne prouve pas l'absence de canaux cachés physiques (cache, temps d'exécution, faute matérielle).
**Action :** (i) remplacer « entièrement » par « pour le code compilé par K7PL » ; (ii) faire de la réserve un **invariant global paramétré** : `soundness(K7PL) ≠ soundness(système déployé)` ; la propriété système s'écrit `K7PL + contrat FFI + hypothèse de confinement` ; (iii) marquer la clause (ii) du Th. 26 comme **exigence d'ingénierie** et non comme théorème — le vocabulaire du §1.2 le permet exactement (cf. `PORT-05`).

### `PORT-03` — « À l'exécution, l'audit trouve trois régions et non six » : un décompte sans méthode
**Sources :** C/C-3.
**Localisation :** §1.3, dernier tiers.
**Constat :** le passage de six à trois n'est pas justifié : aucune liste des six, aucun critère d'exclusion pour les trois écartées. Le lecteur ne peut pas vérifier. Or le document se réclame partout d'une discipline où « aucune affirmation ne figure sans qu'un postulat, un théorème ou une construction établie la porte ». Un décompte est une affirmation ; celui-ci n'est porté que par « l'audit », dont le document ne dit ni qui l'a conduit, ni selon quel protocole, ni où ses résultats sont consignés.
**Action :** énumérer les six et dire lesquelles tombent et pourquoi, **ou** retirer le chiffre et écrire « trois régions demeurent, que voici ». La seconde option coûte un mot et ne perd rien.

### `PORT-04` — Le rejeu bit-à-bit : hypothèse insuffisante, et un autre théorème l'élargit sans le dire
**Sources :** Q/R-11 · G/C1 · E/DEF-03 · F (collision zéro-copie) · **dissidence : D/4.2 et Obs. 4 jugent la distinction correctement faite** — voir `ARB-PR-04`.
**Localisation :** ch. 4 §4.5 p. 135 (Th. 23) ; ch. 1 §1.3 p. 12 (P4) ; ch. 3 §3.2 p. 107 (Th. 18) ; §4.5 (Th. 22).
**Constat :**
1. **Ordre d'exposition (G/C1).** Juste avant le Th. 22, le texte affirme que le runtime rejoué est « bit à bit identique » ; le Th. 22 ne garantit qu'une égalité observationnelle et le Th. 23 ajoute `E_repro` pour l'identité binaire. La bonne hiérarchie est : `journal complet + pureté ⟹ ≈_obs`, puis `≈_obs + E_repro ⟹ =_bit`.
2. **`≈_obs ⟹ =_bit` exige une injectivité non énoncée (Q).** Le pas suppose qu'il n'existe aucune liberté représentationnelle non observable — faux dans le modèle même du document : bourrage d'alignement entre champs d'une arène SoA ; octets non initialisés ; ordre des segments et adresses relatives après `mremap`/RDMA ; purge d'un objet canonique orphelin lors de la rotation du journal ; **charge utile des NaN**.
3. **Le Th. 18 agrandit `E_repro` sans le dire.** Il encode les quatre singularités de la théorie des roues dans les bits de charge utile d'un NaN silencieux et redéfinit l'égalité de couche 3 comme identité bit à bit. La propagation de charge utile n'étant pas spécifiée par IEEE 754, deux machines ou deux chemins de compilation produisent des charges différentes. Il manque donc au moins une **quatrième composante** à `E_repro` : l'architecture et son comportement NaN.
4. **Non-déterminisme d'ordonnancement (E/DEF-03).** Exiger des motifs de jonction deux à deux disjoints supprime le choix non déterministe lors de la sélection d'une règle, mais l'ordre d'arrivée des messages sur des canaux non reliés par une jonction modifie l'ordre d'allocation dans l'arène partagée : états logiquement équivalents, disposition physique divergente.
**Scénario de rupture (Q) :** un `Vec 4 Float64` de couche 3 dont un élément vaut `0/0`. Par le Th. 18, la charge utile du NaN fait partie de l'état observable ; sur une machine produisant le NaN par défaut et une autre propageant la charge du premier opérande, le rejeu donne deux états bit-différents **alors que `E_repro` est satisfaite**.
**Action :** (i) restreindre le Th. 23 à l'énoncé conditionnel honnête `E_repro ∧ Injectivité(obs, repr) ⟹ =_bit`, avec `Injectivité` nommée comme **exigence** et la liste des libertés représentationnelles écrite à côté ; (ii) **ou, plus petit :** exclure la charge utile NaN de l'égalité observable de couche 3, ce qui demande de restreindre le Th. 18 (`BLOQ-12`) ; (iii) ajouter à `E_repro` la composante « architecture et comportement NaN », ou écrire que P4-bit ne vaut que sur architecture fixée — la portée « une machine » que le §4.5 applique déjà au modèle mémoire et au référentiel de coût ; (iv) restreindre explicitement la revendication bit-à-bit au périmètre d'un fil déterministe, ou consigner l'ordonnancement complet des réceptions inter-acteurs (E).
**À préserver :** la distinction des deux degrés de rejeu (ch. 1 p. 12) est excellente et exactement la bonne ; le Th. 23 ne fait que la répéter sous une forme qui promet davantage.
**Gain :** nommer `Injectivité(obs, repr)` comme exigence unique absorbe cinq dispositions éparses (élision → version de schéma, purge → rotation du journal, bourrage → règle d'abaissement, NaN → Th. 18, ordre des segments → `mremap`). Cf. `FACT-16`.

### `PORT-05` — Le Th. 26 énonce comme conclusion ce que la remarque suivante retire et ce que le paragraphe précédent déclare manquant
**Sources :** Q/R-10 · C/C-2 · G/B4.
**Localisation :** ch. 4 §4.5 p. 144-145 (paragraphe « Une opération manque cependant », Th. 26, RMQ 30).
**Constat :** la seconde clause (« le système hôte ne peut y accéder après le retour ») est réfutée une page avant (le système de types sait retirer une capacité, non la révoquer chez un pair ; « le destructeur d'une capacité exportée devrait en émettre une, faute de quoi P3 cesse de valoir au-delà de la frontière ») et retirée une page après (RMQ 30 : « Seule la première est ici un théorème »). Ce n'est pas une maladresse : c'est la catégorie *Exigence* du §1.2 qui n'est pas employée là où elle existe. Même schéma aux Th. 20, 18, 25, 16.
**Action :** scinder sans rien réécrire — **THÉORÈME 26 ⟨langage⟩** (clause 1, preuve inchangée) et **EXIGENCE 26-R ⟨représentation⟩** (clause 2, avec le contenu de RMQ 30 et l'obligation d'émettre une invalidation au destructeur, cf. `IMPL-05`). **Coût : deux lignes.**
**Gain :** le même geste appliqué aux Th. 18, 20, 25, 33, 35 déplace six énoncés de la colonne « théorèmes du langage » à la colonne « exigences de représentation ». Q qualifie ce geste de « plus forte réduction de complexité disponible à coût constant ».

### `PORT-06` — Le Th. 34 ré-affirme comme théorème la direction que le ch. 1 a explicitement retirée
**Sources :** Q/R-13 · D/5.6 et 8.1 (la clôture est suffisante, non nécessaire).
**Localisation :** ch. 6 §6.2 p. 196-197 (Th. 34) contre ch. 1 §1.4 p. 33-34.
**Constat :** le ch. 1 écrit que le critère « est suffisant sous une condition, et il n'est pas nécessaire ; l'énoncer comme une équivalence, ainsi que ce document l'a longtemps fait, promettait plus qu'il ne tient », et donne le contre-exemple probabiliste. Le Th. 34 énonce précisément cette direction retirée, six chapitres plus loin (« Aucune obligation ne déborde de ces trois »). Et le §4.5 p. 145-146 **construit** l'extension probabiliste en question tout en déclarant que le raisonnement statique correspondant demande deux notions dont K7PL ne dispose pas. La preuve avoue sa nature : « L'énoncé ne se démontre pas, il se montre » — c'est la définition d'une stipulation.
**Action :** transformer en **DÉFINITION** (l'interface d'une unité de compilation *est* son jugement) accompagnée d'une **PROPOSITION de clôture locale** : « pour les formes de déclaration énumérées au chapitre 6, aucune obligation ne demande une quatrième composante », avec renvoi explicite au contre-exemple du ch. 1 et à la clause de révision de l'axiome. **Une ligne de renvoi supprime la contradiction.**
**À noter :** ici la factorisation est déjà faite ; le seul travail est de ne pas la sur-vendre. Gain conceptuel : **nul et assumé**.

### `PORT-07` — Le Th. 16 (complétude graduée) est une propriété du vérificateur prouvée par énumération sur un catalogue déclaré non exhaustif
**Sources :** Q/R-14.
**Localisation :** ch. 3 §3.1 p. 97-98 ; annexe A p. 231-236.
**Constat :**
1. Le sens direct énumère sur un catalogue que l'annexe A déclare « illustrative et non exhaustive ». Une preuve par énumération sur une base incomplète ne prouve rien.
2. **Trois comptes incompatibles** : l'annexe A regroupe en **7** familles ; le corpus contient **49** codes sous **21** préfixes ; le Th. 16 annonce **18** familles et **4** catégories.
3. Le sens réciproque (« un programme dérivable est accepté, puisque le vérificateur implante les règles ») suppose ce qu'il faudrait prouver : une propriété d'implémentation promue en prémisse.
4. Un tiers des codes porte sur des constructions **hors noyau** (`BLOQ-01`) : ERR-ACT-002, ERR-ARC-001, ERR-TYP-006/007, ERR-MEM-004/006, ERR-TOP-005 à 008, ERR-STK-001, ERR-IND-003. Leur « exhibition comme dérivation qui échoue » est impossible.
**Action :** **PROPOSITION 16 ⟨langage⟩** — « pour tout constructeur du noyau (annexe E.2), tout refus du vérificateur est l'échec d'une prémisse d'une règle nommée du §E.3 », prouvée par énumération sur base close et vérifiée par le croisement mécanique ; **EXIGENCE 16-V ⟨compilation⟩** — « le vérificateur n'émet aucun code hors de cette correspondance », route mesure ou démonstration ; corriger le compte (remplacer « dix-huit familles » par le regroupement réel) et déclarer que l'énumération porte sur les codes du noyau.
**À préserver :** le principe est fort et doit être défendu — une garantie par inexpressibilité ne se diagnostique pas, et un catalogue de codes doit être l'image d'un catalogue de prémisses manquantes (RMQ 9). L'hypothèse nommée (la frontière de confiance comme objet du jugement) est un bon exemple d'auto-correction réussie.
**Gain :** la forme restreinte devient un artefact exécutable — une table à deux colonnes (code ⟷ prémisse manquante) sur les 35 constructeurs du noyau.

### `PORT-08` — Le Th. 31 quantifie sur une fonction `Sens` jamais définie ; le Th. 29 est un faux corollaire
**Sources :** Q/R-18.
**Localisation :** ch. 5 §5.3 p. 176-177.
**Constat :** `Sens` n'est défini ni au ch. 5, ni au ch. 2 (dénotation dans 𝒞), ni à l'annexe E (sémantique opérationnelle, traduction). L'énoncé est une formule ouverte : vrai par stipulation si l'on *définit* `Sens(s) := Sens(Elab(s))`, sans contenu sinon. La preuve n'établit pas la conclusion : le Th. 11 donne `Elab ∘ subst = subst ∘ Elab` — condition de bonne définition, non égalité de sens entre deux objets de domaines différents ; le Th. 1 donne le transport des grades, sans rapport avec `Sens`. Enfin, la dérivation du Th. 29 est un non-sequitur : **le Th. 29 est prouvé par ailleurs, correctement, par inspection de la grammaire en quatre points** — cette preuve autonome est la bonne.
**Action :** transformer le Th. 31 en **DÉFINITION** (`Sens(s) = Sens(Elab(s))`), et conserver comme **PROPOSITIONS** les trois contenus vérifiables : `Elab` commute avec la substitution (instance du Th. 11) ; `Elab` ne transporte les grades qu'en les majorant (instance du Th. 1) ; `Elab` n'émet que des termes du noyau — d'où le Th. 29 **par inspection, non par corollaire**. Coût : trois lignes, le ch. 5 perd un faux théorème sans perdre une idée.
**Gain :** une fois `Sens` défini comme `⟦Elab(·)⟧`, le Th. 31 devient un cas d'un schéma plus général : *toute transformation définie par récurrence et hygiénique induit un morphisme de systèmes de raffinement*, qui couvre Elab, l'abaissement (Th. 36), la traduction (Th. 27) et l'expansion (Th. 32). Cf. `FACT-06`.

### `PORT-09` — Amortissement et pire cas : P3 doit dire lequel il gouverne
**Sources :** G/C3 · D/5.8 · Q/R-28 (tension table 7) · C (le budget comme borne).
**Constat :** le manuscrit indique que la borne de profondeur historique est **amortie**, puis mobilise un potentiel pour justifier la complexité — alors que P3 condamne le fait de dissimuler un coût derrière une moyenne. Et la table 7 (niveau 4, « tas avec ownership », couche 2, `O(1)` amorti) est en tension avec un postulat non révisable.
**Action :** séparer systématiquement `B_space^WC` (borne mémoire physique maximale) et `T_time^amort` (borne temporelle amortie) : le premier peut satisfaire P3 même si le second est amorti. Écrire la clause de portée de P3 (cf. `STRUCT-14`) : P3 gouverne la borne synthétisée et l'admission à la bibliothèque, non le coût de compilation ni l'amortissement interne d'un régime de mémoire, à la condition que la borne synthétisée soit celle du pire cas. **Le cas amorti demande en outre un traitement formel dans le système de types** (D), que le document mentionne sans le fournir.

### `PORT-10` — Le budget est une borne supérieure dont l'écart au coût réel n'est pas borné
**Sources :** C/D-2.
**Localisation :** §E.3.2 (« Mesure ou borne, et la factorisation que l'écart décide »).
**Constat :** le document identifie que la règle SC suppose que l'action se factorise par l'annotation, que rien ne le garantit a priori, que la littérature donne trois contre-exemples (semi-déterminisme, état local, coupure), puis tranche : lue comme *borne* la factorisation tient, lue comme *mesure* elle échoue. L'argument est correct. **Ce que le document ne tire pas :** la borne de l'opération `once` est celle du calcul complet ; un programme qui l'emploie sur un calcul non déterministe large déclare un budget qu'il ne consommera jamais. P3 interdit de *dissimuler* un coût, non de le *surestimer* — la lecture par borne est donc compatible avec P3, mais rend le budget **structurellement pessimiste** en présence d'opérations à portée coupantes, dans une proportion non bornée.
**Action :** une phrase au §1.3 ou au §E.3.2 : *le budget est une borne supérieure, dont l'écart au coût effectif n'est pas borné en présence d'opérations à portée coupantes*. C'est l'honnêteté que le document pratique ailleurs (RMQ 6).

### `PORT-11` — « Deux paquets sémantiquement équivalents partagent un hash » est faux dans la construction actuelle
**Sources :** G/C2.
**Localisation :** annexe D, SUGOI.
**Constat :** le texte affirme un hachage BLAKE3 de l'AST normalisé, puis que deux paquets syntaxiquement distincts mais sémantiquement équivalents partagent un hash. **Les deux affirmations ne suivent pas l'une de l'autre.** Un hash de contenu sur un AST normalisé identifie au mieux `AST₁^norm = AST₂^norm` ; il ne donne pas `⟦AST₁⟧ = ⟦AST₂⟧ ⟹ hash(AST₁) = hash(AST₂)` — sauf si « normalisé » signifie « quotienté par l'équivalence sémantique », ce qui serait une tout autre construction, potentiellement indécidable.
**Action :** remplacer « équivalence sémantique » par « égalité de l'AST normalisé ». Si l'adressage par équivalence sémantique est réellement voulu, introduire un autre objet — certificat d'équivalence, forme canonique sémantique pour une classe restreinte, ou quotient explicitement défini. **Ne pas « réparer » par un nouveau hash.**

### `PORT-12` — R-expressions : trois écarts entre la classe de machine et la borne annoncée
**Sources :** Q/R-27.
**Localisation :** ch. 4 §4.2 p. 120-123, figure 7.
**Constat :**
1. **`O(1)` pour un DFA** : la reconnaissance est linéaire en la longueur du texte ; `O(1)` n'est vrai que *par bloc* ou *par octet*. P3 interdisant de dissimuler un coût — et le document appliquant ce critère à sa propre théorie au §2.3 p. 65 —, **la figure 7 contredit P3 dans le document qui l'énonce.**
2. **`@exponential` pour un PDA** : l'analyse d'une grammaire hors contexte est polynomiale (CYK/Earley en `O(n³)`) ; l'exponentiel vient du **retour arrière**, pas de la pile. L'annotation confond deux causes.
3. **Profondeur de pile comme grade statique** : pour un texte de longueur non bornée à la compilation, la profondeur croît avec l'entrée. La borner exige soit une entrée de longueur bornée, soit un analyseur à pile bornée — auquel cas la classe reconnue rétrécit. Le document ne dit pas lequel il retient, alors qu'il tranche exactement la question analogue pour la mémoïsation.
**Action :** (i) figure 7 : `O(1)` → « `O(n)` en temps, `O(1)` par bloc » ; (ii) séparer `@stack` (PDA, polynomial, pile proportionnelle à la profondeur d'imbrication) de `@backtrack` (retour arrière, exponentiel) ; (iii) écrire quelle discipline de pile est retenue, avec la conséquence sur la classe reconnue.
**À préserver :** l'exposition de la complexité plutôt que son masquage ; le rejet d'une structure non linéaire en contexte `@linear` comme preuve d'admissibilité ; les positions capturées comme paires d'offsets ; les réserves sur PEG et sur la mémoïsation ; la réserve sur le cadre nominal.
**Gain :** une annexe unique « classes de motifs et bornes » couvrirait les trois analyses d'automates du document (§4.2 R-expressions, §4.5 protocole Noise, §5.1 syntaxe de K7PL). Cf. `FACT-20`.

### `PORT-13` — La condition de clôture doit être énoncée comme suffisante, non nécessaire
**Sources :** D/5.6 et 8.1 · C/B-3 · Q/R-13.
**Constat :** le manuscrit fait déjà ce recul au §1.4. La tâche est de **propager** cette formulation partout où la condition est invoquée comme argument d'économie — notamment au Th. 34 (`PORT-06`) et dans l'argument qui justifie l'ajout de composantes de grade « sans preuve nouvelle ».
**Formulation proposée (D) :** « Cette condition est suffisante, non nécessaire. Une extension peut satisfaire les postulats sans s'y ranger, mais nécessite alors une révision de l'axiome. »
**Lien :** avec `STRUCT-01`, la condition remonte au niveau de la modalité et redevient discriminante sur le bon point ; avec `STRUCT-02`, elle se dédouble en clôture forte et faible.

### `PORT-14` — Trois réserves déjà identifiées mais laissées hors des énoncés
**Sources :** Q/R-30.
- **(a) Th. 30 (hygiène).** L'énoncé porte sur l'AST non gradué ; l'énoncé gradué est refermé par le §5.4.1 (grade déclaré `r_i`) mais le théorème n'est pas étendu. Seconde réserve : préservation de l'α-équivalence **de surface** non déductible sans algèbre de liaison de surface. → deux énoncés (`Th. 30-nu`, `Th. 30-gradué`) + une EXIGENCE de resucrage. Cf. `STRUCT-12`.
- **(b) Th. 19 contre Th. 43 contre Th. 36.** RMQ 24 et 25 conduisent l'analyse correctement (« Trois préservations circulent donc dans ce document »), mais le Th. 19 **énonce** le volet abaissement (« par évaluation *ou par abaissement MLIR* ») alors que le texte dit deux pages plus loin : « Le volet abaissement, lui, est revendiqué et non démontré ». → scinder en `Th. 19-év` (corollaire du Th. 43) et `Th. 19-ab` (renvoi au Th. 36, non démontré). Le document sait le faire : il l'a fait pour le Th. 26 en RMQ 30.
- **(c) Th. 3 (sédimentation).** RMQ 14 : « ces résultats valent sur des types et non sur des types gradués. La transposition à la gradation reste à faire », avec la note que la technique de secours (type de chemin cubique) n'est pas offerte par l'assistant visé. Or le Th. 3 est cité au ch. 1 comme ce qui « autorise à parler de sédimentation ». → énoncer en deux temps (cas non gradué : littérature ; cas gradué : ouvert, route démonstration, contrainte d'outil nommée) et **faire porter la réserve à la citation du ch. 1**.
**Gain (b) :** un **tableau des préservations** (objet préservé × mouvement × statut × lieu) remplacerait trois énoncés et deux remarques et rendrait la dette lisible en une page. La matière existe déjà (RMQ 25).

### `PORT-15` — La sédimentation s'inverse sur deux axes, pas un ; la réserve du §1.2 doit être mise à jour
**Sources :** C (passe 4, « contre la sédimentation triadique »).
**Constat :** l'inclusion des fragments va de la couche 1 vers la couche 3 sur l'axe des ressources ; le §1.2 note déjà l'inversion sur l'axe des effets (« la couche 3 est la plus pauvre puisqu'elle n'en a aucun ») et requalifie honnêtement la sédimentation en *lecture*. Mais le §E.3.2 découvre une **seconde inversion**, sur les transformateurs admissibles (« Les deux stratifications ne s'alignent pas »), 250 pages plus loin et sans y renvoyer.
**Action :** mettre à jour la réserve du §1.2 — deux axes s'inversent, pas un — et y renvoyer depuis le §E.3.2. Cf. `TRANS-06`.

### `PORT-16` — Le Th. 36 est affirmé comme acquis au ch. 3 et déclaré non démontré au ch. 6
**Sources :** F/CRIT-03 · C/D-3 · G/A1 · D/5.1 (qui le classe **bloquant**) · Q/RT-4.
**Localisation :** ch. 3 §3.3 p. 113-114 (Th. 19, RMQ 24-25) ; ch. 6 §6.1 p. 206-207 (Th. 36, RMQ 35).
**Constat :** le ch. 6 conduit ici une analyse exemplaire — il distingue trois préservations, constate que leur intersection laisse un trou, isole ce trou et écrit « Ce théorème n'est pas démontré. Il est énoncé parce que son absence restait invisible ». Le défaut est ailleurs : **le corps du ch. 3 affirme la préservation des grades par abaissement comme acquise**, et le passage à MLIR implique des réécritures d'optimisation (inlining, fusion de boucles) qui reconfigurent les contextes d'usage. D considère que, sans cette préservation, la clause de P1 selon laquelle « toute optimisation admise est accompagnée d'un morphisme de correction sémantique dans 𝒞 » n'est pas établie — d'où son classement en A.
**Action :** (i) requalifier formellement en **Conjecture de préservation quantitative par abaissement** et borner son application immédiate au fragment où les fonctions d'ordre supérieur sont monomorphisées et inlinées avant émission MLIR ; (ii) basculer la route de cet engagement dans la table 1 de « démonstration » à « dette ouverte conditionnée » ; (iii) **la dépendance à un résultat tiers conjectural (QTAL) est le seul cas du document où la levée dépend d'un travail extérieur non achevé** — la table 1 prévoit trois routes (littérature, démonstration, mesure) ; celle-ci en demande une quatrième (*littérature à venir*) ou doit être reclassée en « démonstration » avec le coût entier assumé ; (iv) reformuler le Th. 19 (cf. `PORT-14b`).
**Lien :** sous `STRUCT-05`/`TRANS-04`, le Th. 36 devient « `P-grad` est l'obligation de chaque passe », forme sous laquelle il est mécanisable passe par passe.

### `PORT-17` — Le manuscrit revendique à la fois un modèle invariant par équivalence et une détermination de la représentation, sans dire que les deux tirent en sens opposé
**Sources :** étude d'opportunité HoTT du 15 septembre 2026, §3.4 et §9 · prolonge `BLOQ-08`.
**Localisation :** §1.3 (P1 et P4) ; Th. 18 p. 107 ; Th. 20 p. 128 ; Th. 23 p. 135 ; `E_repro`.
**Constat :** P1 pose que tout programme est un morphisme dans une catégorie ambiante — cadre dans lequel les objets ne sont déterminés qu'à isomorphisme près. P4 et les trois théorèmes de représentation affirment au contraire que deux structures équivalentes coïncident, ou ne coïncident pas, **bit à bit**. Les deux engagements ne sont pas contradictoires — ils portent sur deux niveaux — mais ils tirent en sens opposé, et le manuscrit ne le dit nulle part. Conséquence pratique : un lecteur qui prend P1 au sérieux conclut que la disposition mémoire est un détail d'implémentation, ce que le Th. 20 dément ; un lecteur qui prend le Th. 20 au sérieux conclut que 𝒞 ne peut pas être le lieu du sens, ce qui est exactement `BLOQ-08`.
**Action :** une phrase au §1.3, après P4 — *les garanties de représentation de ce document ne sont pas invariantes par équivalence de types, et c'est délibéré : P1 fournit le vocabulaire de composition, non le critère d'identité des représentations.* Puis renvoyer au profil `Π` de `IMPL-06`, qui est l'objet où cette non-invariance devient paramétrable.
**Gain :** ferme la porte que `BLOQ-08` laisse ouverte, et écrit comme une décision ce qui est aujourd'hui subi comme une tension.

---

## 5. Lot PREUVE — dettes de preuve

### `PREUVE-01` — Th. 45 (correction de ressource) : la dette la plus lourde, et deux postulats en dépendent
**Sources :** C/D-1.
**Localisation :** §E.4, Th. 45.
**Constat :** le document pose la question dans les termes exacts — « Aucun des deux ne dit que *le grade compte ce qu'il prétend compter*. Il est jusqu'ici une grandeur purement statique, qu'aucun énoncé ne relie à un comportement observable — et c'est P3 qui l'exige. » La réponse est un théorème énoncé, non démontré, avec une esquisse en trois lignes et deux réserves empruntées.
**Ce que C ajoute — l'ampleur réelle.** Le document dit que « trois propriétés en descendent » ; il y en a **cinq**, et deux postulats en dépendent :

| Ce qui en dépend | Où | Sans le Th. 45 |
|---|---|---|
| mise à jour en place de l'arène | §3.1, §4.3 | la mutation physique n'est plus prouvée pure |
| partition d'arène `Range(0,k)` | §4.3 | le parallélisme sans mutex n'est plus garanti |
| **P3** | §1.3 | le budget ne mesure rien |
| Th. 21 (sûreté spatiale) | §4.4 | l'absence de dérivation ne dit rien de l'exécution |
| effaçabilité au grade nul | §6.1 | l'effacement peut supprimer un accès réel |

Le cas de P3 est le plus grave : un instrument dont on n'a pas montré qu'il mesure **dissimule davantage** qu'une absence d'instrument, en donnant l'apparence d'une mesure. Le document le formule presque ainsi : « Un grade relié à rien d'observable dissimulerait tout. »
**Contre-exemple :** `unbox v as x in c` avec `v : □₂V` et `x` employé trois fois dans `c`. UNBOX lie `x :_2 V` ; rien dans la règle ne compte les occurrences. Le comptage est fait *implicitement* par VAR composée avec l'addition des contextes — correct **si** l'addition correspond au nombre d'accès à l'exécution. Or la configuration `⟨c ∣ μ ∣ τ⟩` du §E.4 **n'a pas de composante d'usage** : elle ne compte rien. Aggravation par les branchements : la règle WITH *partage* le contexte avec la justification « une seule sera consommée » — **affirmation sur l'exécution, dans une règle statique**, qui est précisément ce que le Th. 45 devrait établir.
**Action — découpage par rentabilité :**
1. **Restreindre l'énoncé à la couche 1** d'abord : grade linéaire strict, comptage le plus simple (0 ou 1), enjeu le plus fort (arène, mise à jour en place). Résultat utile en soi.
2. **Établir la clause WITH séparément** : lemme d'exclusivité des branches, indépendant, probablement le cas le plus subtil.
3. **Ne pas viser les quatre composantes ensemble.** Seule la composante d'usage a besoin de ce théorème : le niveau est traité par la relation logique, le budget par la préservation (`τ·ε` décroissant), la monotonie est une propriété de fonction. **Le Th. 45 ne porte donc que sur `u`, et l'énoncer ainsi le divise par quatre.**
**Conséquences interchapitres :** §1.3 (P3 doit dire que le grade *sera* une mesure, ou renvoyer au Th. 45) · §E.3.4 (note sur WITH) · **table 1 : cet engagement n'y figure pas alors qu'il est plus lourd que six des huit qui y sont.**

### `PREUVE-02` — Th. 36 : préservation graduée par abaissement
**Sources :** toutes. Voir `PORT-16` pour la requalification d'énoncé ; cette fiche porte le travail de démonstration.
**Action :** soit conduire la preuve sur le fragment monomorphisé et inliné, soit restreindre la revendication aux propriétés non graduées qui survivent à l'abaissement (Th. 19 non gradué, établi). Suivre l'état de la défonctionnalisation quantitative dans la littérature (cf. `BIB-03`). Sous `TRANS-04`, l'énoncé se décompose passe par passe.

### `PREUVE-03` — Non-interférence graduée sur le fragment avec communication
**Sources :** D/5.2 · Q/R-19 point 5 · C/B-2.
**Constat :** le §E.4.4 écrit l'énoncé honnête (« démontrée pour le fragment sans communication, temps compris ») ; le §E.5.5 conclut qu'elle cesse d'être bornée à ce fragment, **sans qu'aucune induction nouvelle ne soit conduite**. Or la clause de session est définie sur `S` et aucun jugement ne peut porter une liaison de type `S` (`BLOQ-01`).
**Action :** (i) retirer la dernière phrase du §E.5.5 ou la conditionner à l'existence de règles de communication ; (ii) une fois `BLOQ-01` tranché, conduire la preuve sur le fragment retenu, en utilisant le système de sortes du §E.5 ; (iii) prérequis : `BLOQ-05` (le niveau d'un calcul) — sans lui l'énoncé n'est pas énonçable, et non simplement non éprouvé.

### `PREUVE-04` — Th. 7 (divulgation délimitée) : l'esquisse est circulaire
**Sources :** Q/R-19 points 1-3 · D/5.3 · F/CRIT-04.
**Constat :** l'esquisse déduit l'énoncé de sa propre négation (« … ce que l'énoncé interdit »), et le `□` ferme une tautologie. Le texte qui suit admet que la preuve n'est pas conduite : **la catégorie réelle est Conjecture**. En outre, « la voie est la même que celle du théorème suivant » renvoie au Th. 8 (point fixe déductif), sans rapport avec la paramétricité : la voie est celle du Th. 10.
**Action :** (i) requalifier en **PROPOSITION 7 ⟨langage⟩, non démontrée**, avec route nommée (paramétricité via existentielles) et dépendance explicite au Th. 47 + clause de clôture ; (ii) corriger le renvoi → Th. 10 (cf. `NOTA-07c`) ; (iii) conduire la preuve avec la condition de clôture explicitement posée (`BLOQ-11`).

### `PREUVE-05` — Écrire les règles de la loi distributive graduée et vérifier leur cohérence
**Sources :** D/5.4 · E/DEF-02. Voir `STRUCT-20` pour le diagnostic.
**Action :** énoncer explicitement `λ_{r,ε}`, écrire les deux règles manquantes du §E.3.3, vérifier les conditions de cohérence, et vérifier que LET et APP les emploient correctement.

### `PREUVE-06` — Gradation indexée et substitution d'indices
**Sources :** D/5.5 · E/DEF-04 · Q (R-02, effet de bord).
**Action :** définir le cadre de monade graduée **indexée** (le grade d'un effet peut dépendre d'un indice), prouver le lemme de substitution correspondant (le Th. 41 fournit la forme), et formuler séparément la stabilité de `ε^n` par substitution d'indices. Restreindre au besoin les indices intervenant dans les effets aux termes clos à la compilation.

### `PREUVE-07` — Lemme de simulation entre `→` et `⟦·⟧`
**Sources :** C/A-1. Voir `BLOQ-07`.
**Énoncé cible :** `⟨c∣μ∣τ⟩ → ⟨c′∣μ′∣τ′⟩ ⟹ ⟦c⟧ →⁺ ⟦c′⟧ modulo ≡`, avec extension correspondante de la trace.
**Coût :** une induction sur une dérivation déjà parcourue quatre fois ; les cas sont énumérés au §E.4.6.
**Rendement :** solde la dette de fidélité (Th. 28), justifie l'oracle du §6.3, et couvre la préservation du comportement par les optimisations du ch. 6. **Trois dettes, une preuve.**

### `PREUVE-08` — Th. 6 : la troncature préserve-t-elle les lois de comonade ?
**Sources :** Q/R-20.
**Localisation :** ch. 2 §2.3 p. 63-65.
**Constat :** les deux conditions de cohérence pour la comonade cofree **non tronquée** sont un résultat de littérature correctement ré-énoncé. La préservation par troncature est le seul point propre à K7PL, et elle est affirmée par deux formules qui ne sont pas des preuves (« les deux membres se tronquent au même rang » ; « la troncature étant idempotente et commutant avec elle-même »). Le point de difficulté réel est le **rang frontière** : `N_r δ_r` et `δ_r N_r` appliquent deux troncatures à des profondeurs différentes, et leur égalité dépend de la convention de remplissage. Or la borne `O(r)` en espace et `O(n·r)` en temps en dépendent.
**Action :** lemme explicite — « soit `T_r : N ⇒ N_r` le foncteur de troncature ; `T_r` est un morphisme de comonades si et seulement si la convention de remplissage au rang r est idempotente *et* `F` préserve les troncatures ; sous ces deux conditions `N_r` est une comonade et `λ_r = T_r ∘ λ ∘ F(η_r)` satisfait les deux conditions de cohérence ». Puis **écrire la convention** (le document la pratique sans la nommer). Si la condition échoue pour un `F` donné, restreindre la classe de conteneurs admissibles — restriction de domaine, pas mécanisme.
**À préserver :** la détection du problème de coût est exemplaire (« Annoncer une borne sans dire de laquelle des deux versions on parle reviendrait à dissimuler un facteur »), et la lecture du grade `r` comme **potentiel** est un bon résultat.
**Gain :** troncature à r niveaux, borne de profondeur de pile du PDA (§4.2) et taille de pile précalculée du `StreamContext` sont trois instances d'une **fenêtre statiquement dimensionnée sur un objet coinductif**. Cf. `FACT-18`.

### `PREUVE-09` — Th. 40 : deux structures pour ℰ₀, et une pétition de principe au second temps
**Sources :** Q/R-21.
**Localisation :** annexe E.3.2 p. 254-255 ; ch. 1 §1.4 p. 23-24.
**Constat :**
1. Une présentation par générateurs et relations produit un **monoïde quotient**, pas un treillis complet. La complétude de ℰ₀ est posée au ch. 1 comme propriété d'une quantale ; elle n'est pas compatible en général avec une présentation libre quotientée. Deux structures pour un symbole.
2. « En étendant `π_S` par `π_S(⋁ αᵢ) = ⋁ π_S(αᵢ)` » n'est pas une extension légitime : la bonne définition suppose que `π_S` préserve déjà les suprema, ce qui est la conclusion. **Pétition de principe de forme.**
3. Le ch. 1 avait pourtant identifié la structure minimale suffisante — un **monoïde ordonné par treillis** (distributivité sur les bornes supérieures *finies*) — et avait écrit que « savoir laquelle de ses propriétés porte l'extension est ce qui permettra de ne mécaniser que celle-là ». L'annexe fait l'inverse en utilisant `ε^ω = ⋁_m ε^m`.
**Action :** énoncer le Th. 40 en deux temps — (i) pour `n` **fini**, sous l'hypothèse « ℰ₀ est un monoïde ordonné par treillis quotient de la présentation, sans relation mixte », par récurrence et **sans complétude** ; (ii) pour `n = ω`, sous l'hypothèse supplémentaire « ℰ₀ est une quantale et le quotient préserve les suprema », **nommée comme exigence sur ℰ₀**. Le ch. 1 a déjà écrit la distinction ; il suffit de la descendre dans l'annexe (cf. `BIB-16`).
**Dépendance nouvelle (15 septembre) :** la règle `GUARD` du programme de concurrence compose les effets de branches par `⨆ᵢ εᵢ` et hérite donc de cette question. Pour un ensemble d'étiquettes **fini** — le seul cas qu'un motif de boîte puisse écrire — le besoin se réduit aux bornes supérieures finies, que le monoïde ordonné par treillis du ch. 1 fournit. **À écrire comme condition de la règle, non à supposer.**
**À préserver :** la condition sur `Rel` (aucune relation mixte) est juste, nécessaire, et son statut de point fragile est correctement signalé ; les formes normales `φ_n ∘ π_S` et la décidabilité de l'appartenance sont un vrai résultat ; l'exclusion de `φ_ℓ` de ℳ est une décision de sûreté bien argumentée (et devient dérivée sous `BLOQ-05c`).

### `PREUVE-10` — Cohérence des coercions par facteur, puis fermeture par produit
**Sources :** G/B1. Voir `STRUCT-07`.
**Action :** prouver `p₁, p₂ : r ≼ r′ ⟹ coe_{p₁} = coe_{p₂}` pour chacun des quatre facteurs, puis la fermeture par produit ; en déduire le Th. 39.

### `PREUVE-11` — Relation logique sur un produit de structures ordonnées
**Sources :** Q/R-19 point 5(a) · Th. 10 point (a) du manuscrit.
**Constat :** l'annexe traite ce point par une remarque (« la clause n'inspecte que la troisième composante — et le chapitre 1 établit que φ et ψ ne mêlent jamais deux composantes »), ce qui est un argument de *non-interaction* et non de *compatibilité*.
**Action :** énoncer le lemme — *si chaque facteur d'un produit de structures ordonnées admet une relation logique compatible, alors le produit en admet une, définie composante par composante, pourvu que la clause décisive (`!^r V`) n'inspecte qu'une composante.* C'est exactement ce que le document affirme ; il manque l'énoncé.

### `PREUVE-12` — Unicité d'introduction de `WriteCap` et lemme de portée
**Sources :** Q/R-15. Voir `BLOQ-09`.
**Action :** écrire la règle d'introduction de `WriteCap(r)` consommant linéairement son arène ou son segment ; prouver l'unicité en contexte clos ; prouver le lemme de disjonction des `Range` (arithmétique d'intervalles, déchargeable par le solveur) ; réénoncer le Th. 21 avec ces hypothèses.

### `PREUVE-13` — Lemme de simulation du graphe d'attente, et hypothèse d'équité
**Sources :** Q/R-17 · F/CRIT-02 · G/B6 · D/Obj. 8.
**Constat :** l'esquisse du Th. 17 admet elle-même que l'étape de préservation « se réduit à un énoncé unique — la simulation du graphe d'attente […] c'est le seul point que cet énoncé emprunte ». C'est le seul endroit du document où une preuve nomme explicitement l'étape qui lui manque, et le nomme correctement.
**Action :** prouver *toute arête d'attente dynamique est une arête du graphe de câblage*, sous les trois conditions (pas de délégation de session — acquis ; pas de création dynamique de canal — à écrire ; sur-approximation des branchements — acquise) ; nommer l'hypothèse d'équité de l'ordonnanceur, par analogie avec l'équité mémoire déjà relevée au §4.5.

### `PREUVE-14` — Th. 5 : schéma de méta-théorème à deux instanciations, et non identité des conclusions
**Sources :** G/B7 · Q/R-03 (qui en fait un bloquant, cf. `BLOQ-06`).
**Constat :** la factorisation des Th. 2 et 4 par la polarité est l'une des meilleures du manuscrit, et le document vérifie que la distinction « se voit dans la machine ». Reste une différence qui n'est pas seulement présentationnelle : en couche 3 on démontre l'**épuisement d'une structure finie**, en couche 2 l'**apparition d'une observation en temps fini**. Le manuscrit le reconnaît (« progression » est un terme choisi, non une identité littérale).
**Action :** faire du Th. 5 un **schéma de méta-théorème**, puis déclarer deux instanciations aux conclusions différentes ; ne pas prétendre que les propriétés sémantiques finales sont identiques. Combiné à `BLOQ-06` : un schéma, **deux sortes de tailles**.

### `PREUVE-15` — Hypothèse `D_det` : déterminisme des parcours, recherches et graines
**Sources :** Q/R-09 point 4. Voir `BLOQ-10`.
**Trois hypothèses non écrites dont dépend le Th. 35 :**
(a) l'ordre de parcours de l'arbre de syntaxe — que le §E.4.1 déclare explicitement *non spécifié* et renvoie à « la spécification de l'outillage », alors qu'il « décide de la localité des messages d'erreur » ;
(b) l'ordre de recherche du narrowing / de la synthèse dirigée par les grades, qui est « une recherche de preuve, avec espace de recherche et possibilité d'échec » ;
(c) la graine du test par propriétés des indices `invariant`/`witness`/`lemma`, exécution randomisée intégrée à la compilation.
**Action :** énoncer `D_det` ; **élever l'ordre de parcours du §E.4.1 du statut de renvoi à l'outillage à celui d'objet de la spécification**, puisqu'un théorème en dépend. C'est le seul cas du document où un choix déclaré « ni une règle ni un pas de réduction » est en réalité une hypothèse de théorème.

### `PREUVE-16` — Th. 3 : transposition graduée de la préservation des conteneurs
**Sources :** Q/R-30(c). Voir `PORT-14c`.
**Contrainte d'outil à nommer :** la technique qui rend la preuve possible est le type de chemin d'une théorie cubique, que l'assistant de preuve visé au ch. 6 n'offre pas (cf. `BIB-14`).

---

## 6. Lot NOTA — notation, comptes et renvois

> Coût quasi nul, effet de traçabilité maximal. Plusieurs de ces points sont des **signaux** : l'écart de comptage est exactement ce qu'une mécanisation révèle comme cas manquant.

### `NOTA-01` — La table 5 est déclarée normative et le document la contredit : 12 collisions, 11 symboles hors table
**Sources :** Q/R-22 (N-01 à N-12) · F/COL-01 à COL-04 · C/E-1 · D/3.1 à 3.6 · E/§3.1.
**Rappel de la norme :** « Ce document emploie un symbole par objet, et un objet par symbole. […] un symbole absent de cette table n'a pas de sens dans ce document. » (§1.5, p. 39.)

| # | Symbole | Sens 1 | Sens 2 (3, 4) | Lieux |
|---|---|---|---|---|
| N-01 | `ℛ` | semi-anneau ℚ≥0 ∪ {ω} | produit ℕ∞ × {d⪯m} × ℒ × ℬ | ch. 2 p. 48 / E.1 p. 244 — cf. `BLOQ-04` |
| N-02 | `φ` | action du grade sur l'effet `φ_r` | première composante d'un effet `ε = ⟨φ, κ⟩` | table 5 / E.1 p. 244 |
| N-03 | `κ` | famille temporelle ℕ∞^ℒ | compteur d'usages du Th. 45 | E.1 / E.4 p. 268 |
| N-04 | `1` | type unité | grade unité ; unité de la quantale ; entier dans `⟨1,1⟩` | E.3 p. 248 — **les quatre en six lignes** |
| N-05 | `I` | objet unité de la SMCC | ensemble d'indices ; `I(M)` intervalle admissible | ch. 2 §2.1 / E.1 / table 5 |
| N-06 | `S` | type de session | semi-treillis de `fix` ; ensemble d'opérations `π_S` ; état dans `Rejeu(J(H), S₀)` ; modalité duale de ◇ | E.1 / ch. 2 §2.4 / E.3.2 / ch. 4 p. 134 / E.3.1 — **cinq sens** |
| N-07 | `M` | mode | boîte aux lettres du Th. 25 ; borne haute d'intervalle | table 5 / ch. 4 p. 143 / ch. 3 p. 86 |
| N-08 | `r` | grade individuel | **région d'arène** dans `WriteCap(r)` ; profondeur d'historique ; budget de recherche | table 5 / ch. 4 p. 130 / ch. 2 p. 63 / ch. 3 p. 111 |
| N-09 | `π` | projection `c.i` | `π_S` conservatrice ; `π_ℓ` observationnelle ; `π†` | E.3.4 / E.3.2 |
| N-10 | `⊢` | tourniquet du jugement | identité droite (table 24) ; groupe non capturant des R-expressions | E.3 / E.7 p. 283 |
| N-11 | `𝒢` | algèbre des grades | genre de sorte `𝒢en` ; `𝒢_pile`, `𝒢_budget` (jamais définies) ; grade de présence | table 5 / E.5.2 / ch. 1 p. 35-36 / ch. 3 p. 108 |
| N-12 | `⊟/⊠` | composition de contextes | l'indice ε est omis « lorsque le contexte le détermine », alors que deux règles seulement ont un indice non trivial | ch. 1 p. 25 / E.3 p. 247 |

**Symboles employés normativement et absents de la table 5 :** `ℳ`, `𝒮`, `𝒢en`, `Ops`, `Rel`, `Trellis_fin`, `niv`, `ℬ`, `𝒟`, `𝒯`, `p` (foncteur de raffinement), `λ` (loi distributive **et** loi distributive d'histomorphisme — deux objets que le ch. 2 p. 64 distingue pourtant), `E` (prédicat d'échange), `Cont(m)`, `Exch`, `F_ε`, `U_ε`, `δ_ℓ`, `⊤`, `γ`, `μ` (état d'arène, alors que `μF` est le point fixe), `τ` (trace, alors que `τ` est aussi le type du Th. 19).
**Deux collisions dangereuses, pas seulement gênantes :**
- **N-08** : `WriteCap(r)` avec `r` *région* dans le théorème qui fonde P3 et P4, alors que la table normative fait de `r` un *grade*. Un lecteur — ou un mécaniseur — qui applique la table lit « capacité d'écriture de grade r », ce qui n'a pas de sens.
- **N-02 + N-04** : dans `⟨1,1⟩` (règle TICK), le premier `1` est l'unité de ℰ₀ et le second devrait être `δ_ℓ` ; et `φ_r(ε)` où `ε = ⟨φ, κ⟩` place deux `φ` à une lettre de distance dans la même expression — **celle du Th. 1, dont la preuve est fausse (`BLOQ-03`). La collision rend la faute difficile à voir.**
**Collisions relevées par les autres rapports :**
- `𝒢` algèbre contre grade individuel (F/COL-01) : le §1.4 p. 18 affirme que « deux dérivations ne diffèrent jamais par leur 𝒢 », mais p. 35 et p. 94 le document écrit `𝒢 = 𝒢_pile`, `𝒢 = 𝒢_budget`, puis `𝒢 = 1`. **Si 𝒢 varie au cours de la dérivation comme une valeur, le jugement cesse d'être paramétrique et la métathéorie de coupure de Licata et al. ne s'applique plus.**
- `Γ` contre `Δ` (F/COL-02, C/E-1, D/3.3) : l'usage est cohérent (Γ objet de 𝒞), mais (i) le ch. 2 p. 46 et le ch. 4 p. 130 écrivent `Γ₁ ⊗ Γ₂` pour une disjonction de contextes de typage, ce qui efface la distinction entre type produit et contexte de ressources ; (ii) **la table 5 assigne deux objets à un symbole** (« catégorique **ou** métathéorique ») alors qu'elle s'annonce comme assignant un objet par symbole — auto-contradiction sur la ligne même que RMQ 10 déclare la plus coûteuse à enfreindre.
- `⊑` précision contre `≼` sous-typage (F/COL-03) : cf. `BLOQ-14`.
- `π†` conservatrice contre `π_ℓ` observationnelle (F/COL-04) : **propriétés mathématiques inverses** — effacer le temps sous-estimerait le coût (violation de P3) ; conserver le temps d'un calcul secret ouvrirait un canal auxiliaire (violation de la confidentialité). Les confondre sous un même glyphe rend les preuves de coût et de non-interférence mutuellement contradictoires. Cf. `REFUS-04`.
- « mode » : fragment structurel global contre donnée algébrique locale de contraction/affaiblissement/échange (F) ; et modes présentés comme intervalles en table 6 alors qu'un mode est un triplet (D/3.5).
- `⊗` : trois sens (D/3.1, D/3.4) — cf. `STRUCT-18`.
- « canal » : type de protocole de session, capacité d'accès dans Δ portée par un grade, primitive de synchronisation du π-calcul cible (E/§3.1).
**Action :**
1. Étendre la table 5 aux ≈ 20 symboles manquants et **y ajouter une colonne « niveau »** (syntaxe / jugement / sémantique / compilation / représentation), ce qui prépare `TRANS-04` et fournit un test automatique : toute règle dont une prémisse et la conclusion sont à des niveaux différents est signalée.
2. Renommer les collisions dangereuses : `φ_r, ψ_r` → `α_r, β̂_r` (ou garder `φ_r` et renommer la composante d'effet `ε = ⟨e₀, κ⟩`) ; `κ` du Th. 45 → `ν` ou `#usages` ; `r` de région → `ρ` ; `1` → `𝟙` (type), `1_𝒢` (grade), `1_ℰ` (effet) ; `ℬ` → `𝔅`.
3. Corriger la ligne `Γ` : « contexte de la métathéorie (objet de 𝒞 ou contexte d'une preuve) » — un objet, non deux. **Coût : trois mots.**
4. Appliquer au document la règle qu'il énonce pour les glyphes : « un signe ne peut pas porter deux travaux ».
**À préserver :** la table normative est une excellente idée ; le §E.7 traite honnêtement trois coexistences (`⊢`, `#`, `.`) avec un argument de séparation par contexte recevable pour `⊢` et `.` ; la décision sur les glyphes de liaison (↢/↣ contre ⟜/⊸) applique exactement le bon principe.

### `NOTA-02` — `tick` : instance ou constructeur ?
**Sources :** C/E-2.
**Constat :** la grammaire dit que `tick` est une instance du schéma `operation_ε` (« et c'est délibéré ») ; le §E.3 lui donne une règle propre ; le §E.4 un schéma de réduction propre. Trois traitements, deux statuts. Le §E.4 traite l'induction comme instance (« Le cas de tick en est l'instance où `ε = ⟨1,δ_ℓ⟩` ») — **la règle TICK est donc dérivable et devrait être marquée comme telle.**
**Action :** marquer TICK comme règle **admissible**, non primitive, comme le §5.4 le fait pour EXPAND (Th. 32 : « La règle EXPAND n'est pas un axiome du système : elle se dérive »). Le document a déjà la convention. **Lien :** l'effet conclu doit en outre être corrigé en `⟨1, δ_ℓ⟩` (`BLOQ-05`).

### `NOTA-03` — Les comptes ne se recoupent pas : 39 / 35 / 34, et 19 / 18 / 49 / 21
**Sources :** C/E-3 · Q/R-01 point 4, Q/R-14.
**Constat :**
- §E.1 : « trente-neuf règles de typage, dont quatre ne gouvernent aucun constructeur ; trente-cinq constructeurs de termes » ; §E.3.5 et §E.4 : « les trente-quatre règles se rangent en cinq groupes ». **L'écart de un n'est pas expliqué** (probablement SUB/SUBBOX comptées ensemble, ou TICK — cf. `NOTA-02`).
- §E.3.4 affirme que `να.C` « était le seul de dix-neuf dans ce cas » : faux — `Arena` l'est aussi (déclaré) et la strate `S` entière l'est (non déclaré) ; et « dix-neuf » ne correspond à aucun décompte de la grammaire (10 + 5 = 15 pour V et C, 23 avec S).
- Th. 16 : 18 familles et 4 catégories, contre 7 familles en annexe A et 49 codes sous 21 préfixes (cf. `PORT-07`).
- Travaux ouverts : « quatre preuves ouvertes » (ch. 1), « cinq travaux ouverts » (annexe E), « trois preuves » (§E.6), « quatre points restent ouverts » (§E.5.6), huit engagements dont un déclaré anomalie (table 1).
**Constat aggravant :** le §E.1 écrit que « le croisement est vérifié mécaniquement à chaque construction du document ». **Si le croisement est mécanique, les comptes devraient l'être aussi.**
**Action :** faire produire tous les comptes par le même outil que le croisement. Valeur de **signal** : c'est le genre d'écart qu'une mécanisation révèle comme cas manquant. Cf. `IMPL-08` pour le renforcement du croisement lui-même.

### `NOTA-04` — Table 8 : la couche 3 a « Δ = ∅ », alors que le reste du document dit `Δ_ω`
**Sources :** Q/R-24.
**Localisation :** ch. 5 §5.1 p. 167 (table 8 et paragraphe suivant) contre ch. 1 §1.4 p. 35 (équation 2) — et contre la même page 167 (« un calcul de couche 3 — n'ayant besoin que de `Δω`, présent dans les trois jugements »).
**Constat :** tout l'argument du §1.4 pour supprimer la zone Γ est qu'une liaison non restreinte est une liaison de grade ω, donc que la couche 3 **a** un contexte, à savoir `Δ_ω`. La table 8 et sa glose affirment le contraire. Ce n'est pas cosmétique : l'argument de l'imbrication à sens unique (`{ ( [ ] ) }`, ERR-TOP-001) est justifié par « le jugement de couche 3 ne comporte pas de Δ », donc par une prémisse fausse. **L'argument survit avec la prémisse correcte** (un bloc de couche 3 ne peut exiger que des liaisons de grade ω, donc rien d'affine ni de linéaire) mais doit être réécrit.
**Action :** `Δ = ∅` → `Δ = Δ_ω` ; « Le jugement de couche 3 ne comporte pas de Δ » → « Le jugement de couche 3 n'admet que des liaisons de grade ω ». **Deux mots.**
**À préserver :** la règle d'imbrication à sens unique, son rattachement aux foncteurs d'inclusion fidèles, la propriété de grammaire à pile visible qui en découle, et les deux règles de portée (délimiteurs en position de calcul ; sigil deux-points comme espace de noms) sont justes et bien motivées.

### `NOTA-05` — `ε_m` désigne deux effets dans le Th. 32, et `∏_i` est non commutatif sur un ensemble d'indices non ordonné
**Sources :** Q/R-23.
**Localisation :** ch. 5 §5.4.1 p. 179 ; §5.4.2 (règle EXPAND) ; §5.4.3 (table 11, contrôle 2).
**Constat :**
1. Trois lectures pour deux objets : au §5.4.1 l'effet de l'expansion est **vide** et c'est l'effet du *code produit* qui est déclaré ; dans EXPAND, `ε_m` est un facteur non trivial ; dans la table 11, `ε_m` **majore ce que le corps compose**. Si `ε_m` est l'effet de l'expansion il vaut 1 et le facteur est inutile ; s'il est l'effet du code produit, la règle le *calcule* et l'interface ne le déclare pas ; s'il majore ce que le corps compose, le corps peut contenir du code effectueux du noyau — ce que le §5.4.1 exclut.
2. `∏_i` est un produit de la quantale, dont le ch. 1 dit explicitement qu'il est **non commutatif** (il dénote le séquencement). Un produit indexé par `i ≤ n` sans ordre spécifié n'est pas bien défini : l'ordre pertinent est celui des **occurrences des métavariables dans le corps**, qui n'est pas `i ≤ n` en général.
3. La règle suppose que l'effet du code produit est **exactement** le produit des effets transportés des arguments — faux dès que le corps contient un `tick` ou une `operation_ε`.
**Action :** trois noms au lieu d'un — `ε_exp = 1` (lemme, par le bac à sable, et non déclaration) ; `ε_body` (effet déclaré du code produit hors arguments) ; `ε_args = ∏_{i ∈ occ(m)} φ_{r_i}(ε_i)` où `occ(m)` est la **suite** des occurrences dans l'ordre du corps. Règle : `… ⊢ m(t₁,…,t_n) : B ∣ ε_body · ε_args`. Contrôle 2 de la table 11 : « `ε_body` majore les opérations du corps hors occurrences des arguments ».
**Gain :** `occ(m)` est le même objet que la zone ordonnée du §3.1 et que l'ordre de séquentialisation du Th. 42. Cf. `FACT-19`.

### `NOTA-06` — Six défauts formels localisés, mécaniquement bloquants, vérifiables en une ligne
**Sources :** Q/R-26.

| # | Localisation | Défaut | Correction |
|---|---|---|---|
| a | ch. 2 §2.3 p. 57, Th. 2 | `∀f : μF → A, ∃k, ∃v, f(x) ⇝_k v` : **`x` est libre** dans l'énoncé | `∀f, ∀x : μF, ∃k, ∃v` |
| b | ch. 2 §2.3 p. 57-61 | Th. 2 et Th. 4 déclarés « instances du théorème 5 » qui vient **après** | réordonner (Th. 5 d'abord) ou marquer la dépendance |
| c | ch. 2 §2.4 p. 70 | « la voie est la même que celle du **théorème suivant** » — le suivant est le Th. 8, la voie paramétrique est celle du Th. 10 | renvoi → Th. 10 |
| d | ch. 3 §3.2 p. 105 et RMQ 23 | « au sens du chapitre 4 (**§4.3**) » ; le graphe est construit au **§4.5** | renvoi → §4.5 |
| e | annexe E.3.1 p. 251-252 | la règle WHEN imprimée ne porte pas la condition déclarée « désormais appliquée » | cf. `BLOQ-02` |
| f | annexe E.3 p. 249, règle OPEN | condition de bord `α ∉ fv(C)` seulement : si `α ∈ fv(Δ₁)`, `fv(Δ₂)` ou `fv(ε)`, la conclusion contient une variable de type **non liée** | `α ∉ fv(Δ₁ ⊠₁ Δ₂ · ε · C)` |

**Le point (f) est plus grave qu'il n'en a l'air :** le §E.3 p. 250 écrit que la condition de bord de OPEN « est celle qui rend le témoin inatteignable, et c'est sur elle que la preuve de non-interférence s'appuiera » — et le §E.4.3 précise que les cas du quantificateur existentiel « comptent double, car c'est par elles que passe la preuve de non-interférence ». **La preuve de non-interférence s'appuie donc sur une condition insuffisante.** Gravité : D/C, à traiter avec `PREUVE-03`.

### `NOTA-07` — Identifiants de travail non résolus
**Sources :** Q/R-06.
**Constat :** `T-06` (foncteur d'effacement invoqué par le cas (a) de l'induction du §E.4.6), `T-42` (« l'économie que la clôture de T-42 avait annoncée »), `T-43 (a)-(c)`, `T-44 (i)-(ii)` (porté par la clause de session), `G.1` et `G.3` (renvois à une lettre d'annexe qui n'existe plus), « l'annexe de chantier » (absente du PDF). **Le lecteur ne peut pas vérifier la chaîne.**
**Action :** résoudre ou supprimer, dans le registre des obligations (`TRANS-05`).

### `NOTA-08` — Corriger les renvois faux de pureté des gestionnaires
**Sources :** Q/R-25 point 2.
**Constat :** le Th. 22 renvoie à « ch. 3, §3.3 » pour la pureté des gestionnaires de couche 2 — section qui ne l'affirme nulle part ; le ch. 7 §7.2 renvoie à « ch. 2, §2.3 » — section qui définit les gestionnaires comme morphismes d'algèbres, c'est-à-dire le contraire d'une fonction pure.
**Action :** faire pointer les deux renvois vers la définition à écrire en `STRUCT-15`.

---

## 7. Lot IMPL — dettes d'implémentation et d'outillage

### `IMPL-01` — Le solveur est traité comme une boîte noire, ce qui contredit le code porteur de preuve de l'annexe D
**Sources :** C/D-4.
**Constat :** le ch. 6 §6.1 énonce l'objection contre lui-même (« une réponse négative est crue sur parole, alors que les solveurs modernes savent produire des preuves vérifiables indépendamment ») et n'y répond pas. **Raison supplémentaire que le document ne donne pas :** l'annexe D affirme que chaque paquet embarque ses théorèmes SMT résiduels « que le compilateur local re-vérifie intégralement avant toute installation ». Sans certificat, la re-vérification consiste à **relancer le solveur** — ce qui est une répétition, non une vérification. Un paquet accompagné d'une formule que le solveur local résout différemment (version, options, graine) passerait ou échouerait sans qu'on sache pourquoi.
**Action :** exiger un certificat **pour les seules obligations qui traversent la frontière de paquet** ; les obligations internes à une compilation peuvent rester non certifiées, étant reproduites dans le même environnement. Conséquences : annexe D (la re-vérification devient vérification de certificat) ; §6.1 (clause de certificat ajoutée à la phase 5).

### `IMPL-02` — Compilation reproductible : visée et non garantie
**Sources :** C (lot F) · Q/RT-4.
**Statut :** **correctement déclarée** dans la table 1, route « mesure ». À ne pas compter contre le document ; à doter d'un critère opérationnel sous `TRANS-04` : reproductible = toute passe appliquée est déterministe *et* `P-trace(ℓ)` est respectée pour le ℓ du binaire.

### `IMPL-03` — Protocole de réglage du test différentiel
**Sources :** C (lot F).
**Constat :** relevé au ch. 6 et non fourni. À écrire, d'autant que l'oracle devient un corollaire sous `PREUVE-07`.

### `IMPL-04` — Structure réelle des boîtes aux lettres et protocole d'appariement atomique
**Sources :** Q/R-07. Voir `STRUCT-04`.
**Action :** décider entre « un anneau par couple + une file de jonction par acteur » et « MPSC », et écrire le protocole d'appariement multi-places (verrou, séquence CAS avec reprise, ou file de jonction dédiée — cf. `BIB-04`).

### `IMPL-05` — Révocation d'une capacité exportée à la frontière FFI
**Sources :** Q/R-10 · G/B4 · D/Obj. 7.
**Constat :** « le système de types sait retirer une capacité de son contexte, non la révoquer chez un pair qui l'a reçue. […] Le destructeur d'une capacité exportée devrait en émettre une, faute de quoi P3 cesse de valoir au-delà de la frontière. C'est le troisième point où ce document franchit une frontière de confiance sans l'avoir tracée. »
**Action :** écrire l'obligation d'invalidation au destructeur, sous forme d'**EXIGENCE 26-R** (`PORT-05`), avec la solution citée : invalidation explicite des protocoles d'accès distant (cf. `BIB-17`).

### `IMPL-06` — Profil de représentation `Π` unique
**Sources :** Q/R-16, Q/R-11, Q/RT-4 · F (découplage sémantique / ABI).
**Action :** définir `Π = ⟨vArrow, vCapnp, vMLIR, arch, modèle mémoire, mode d'arrondi, version de schéma⟩`, et faire d'`E_repro`, de la portée « une machine » du §4.5 et de la convention d'élision du §1.4 **trois projections de `Π`**. Requalifier le Th. 20 et le Th. 36 en **propriétés de conformité du compilateur**, vérifiées par le pipeline de validation de la phase 7, et non comme théorèmes du calcul des types (F).

### `IMPL-07` — Table de propagation des singularités
**Sources :** Q/R-12. Voir `BLOQ-12`.
**Action :** une table 4 × 4 × opérations devient l'unique objet normatif, dont l'encodage NaN, le masquage SIMD et l'égalité bit à bit sont trois réalisations. Conformité testable par test différentiel (§6.3).

### `IMPL-08` — Renforcer le croisement mécanique grammaire × règles
**Sources :** Q/R-31 point 4 · Q/R-01 point 4 · C/E-3.
**Constat :** le croisement annoncé **compare des présences, pas des arités ni des occurrences utiles** : une clause `S ::= S` « figure » dans la grammaire et ne gouverne aucune règle, donc le contrôle passe (cf. `BLOQ-02`). De même, il n'a pas détecté les six règles concluant des types non engendrés.
**Action :** étendre le contrôle à (i) l'arité et les occurrences effectives ; (ii) la détection des productions vides ou auto-référentielles ; (iii) la vérification que tout type conclu par une règle est engendré par la grammaire ; (iv) la production de tous les comptes par le même outil (`NOTA-03`) ; (v) l'échec du build sur un symbole normatif absent du rendu (qui aurait attrapé `BLOQ-02` en amont).

### `IMPL-09` — Hypothèses de module à porter en assistant de preuve
**Sources :** C (mécanisabilité) · Q/§5.2 · D/16.
**Constat :** le document identifie honnêtement deux hypothèses de module (totalité de `⟦operation⟧`, conformité de l'abaissement de l'arène) et trois obstacles nommés : le cadre de sortes n'a de métathéorie mécanisée que pour une sorte unique ; le type de chemin cubique manque à l'assistant visé ; le solveur n'émet pas de certificat.
**Action :** maintenir cet inventaire dans le registre des obligations (`TRANS-05`) et le lier aux fiches `IMPL-01`, `PREUVE-16`, `BIB-14`.

---

## 8. Lot FACT — factorisations à écrire

> Les six rapports convergent : **le manuscrit n'a pas besoin de mécanismes nouveaux, il a besoin de quelques montées de niveau sur des objets déjà construits.** Toutes les fiches de ce lot réduisent la taille conceptuelle *et* la dette de preuve.

### `FACT-01` — Schéma de commutation graduée (transport-échelle)
**Sources :** C/F-1 · Q/§4.2(i) · F/ASPIR-01 · D/6.5 · G/§15-A.
**Constat :** le Th. 1 est démontré et le document note qu'il sert quatre fois. **Il sert six fois**, et deux emplois ne sont pas signalés :

| Emploi | Où | Signalé |
|---|---|:-:|
| lemme de substitution | §E.3.5 | ✓ |
| relation logique | §E.4.4 | ✓ |
| traduction | §E.4.6 | ✓ |
| expansion de macro | Th. 32 | ✓ |
| **règle SC (opérations à portée)** | §E.3.2 | ✗ — contexte multiplié par n, effet par `φ_n` : même carré |
| **image du point fixe déductif** | Th. 49 | ✗ — la ré-invocation h fois est le même geste |

**Énoncé cible :** soit `T` une transformation définie par récurrence sur les dérivations, envoyant un jugement sur un objet muni d'une action de ℛ ; si `T` commute avec la mise à l'échelle sur les constructeurs, alors `T(r·𝒟) = r·T(𝒟)` pour toute dérivation. Forme équivalente donnée par Q : `T(Δ₁ ⊠_ε Δ₂) = T(Δ₁) ⊠_{φ_r(ε)} T(r·Δ₂)`.
**Où le poser :** §2.6, à côté du Th. 11 (qui porte sur la substitution de termes, non sur la mise à l'échelle de grades).
**Gain :** le §2.6 passe de quatre schémas à cinq, et le document passe de « une loi employée six fois » à « un schéma dont six preuves sont des instances ». **En mécanisation, la différence est réelle** : un schéma se prouve une fois et s'applique par instanciation ; un lemme invoqué six fois demande six vérifications d'applicabilité. Effet secondaire : la faute arithmétique de `BLOQ-03` se localise en un seul endroit.
**Variante FLASH (ASPIR-01) :** formuler sur une fibration bimodale, absorbant Th. 1, Th. 11, Th. 30 et Th. 48 — même contenu, cadre plus large ; voir `FACT-22` pour l'arbitrage sur le cadre.

### `FACT-02` — Schéma de restriction `ρ_p` (projection par niveau)
**Sources :** C/F-2 · Q/§4.2(ii) · F/DUP-03 · D/6.6.
**Constat :** cinq objets de même forme, en cinq endroits, non reliés :

| Objet | Où | Efface |
|---|---|---|
| `π_S†` conservatrice | §E.3.2 | les opérations de S, garde le temps |
| `π_ℓ` observationnelle | §E.3.2 | ce qui excède ℓ, temps compris |
| `⟦·⟧_ℓ` effacement indexé | §2.5 | ce qui est gradué au-dessus de ℓ |
| `𝒟_k ↪ 𝒟` namespace | §4.5 | les arêtes hors dimension k |
| purge de spécification (phase 8) | §6.1 | les blocs de compilation |

Le document approche la factorisation deux fois (§2.5 : « un seul mécanisme, deux emplois » ; §E.5.5 : « π† efface des *genres*, π efface au-dessus d'un *niveau*, et ce sont les deux projections de la sorte ») **et ne fait pas le troisième pas**. Q ajoute un sixième emploi : la projection du journal (Th. 46).
**Énoncé cible :** soit `≼` un ordre et `𝒟` une catégorie de dérivations dont les objets portent une étiquette dans P. La **restriction à p**, notée `ρ_p`, envoie une dérivation sur celle obtenue en retirant tout ce dont l'étiquette n'est pas `≼ p`. Elle est fonctorielle, idempotente, et `ρ_p ∘ ρ_q = ρ_{p ⊓ q}`.
**Instanciations :** treillis des niveaux pour `π_ℓ` et `⟦·⟧_ℓ` ; ordre d'inclusion des ensembles d'opérations pour `π_S†` ; ensemble des dimensions pour le namespace ; ordre à deux points pour la purge.
**Objection à écarter :** on pourrait croire que `π†` et `π` sont deux objets, l'une gardant le temps et l'autre non. C'est faux : elles restreignent sur des **coordonnées différentes de la sorte** `⟨g, ℓ⟩` — `π†` sur `g`, `π_ℓ` sur `ℓ`. **La table 21, qui les présente comme « de même forme sur les effets et de traitement opposé sur le temps », décrit une différence d'instanciation comme une différence de nature.** (Cela ne contredit pas `REFUS-04` : instances distinctes d'un même schéma, jamais interchangeables.)
**Trois acquis sans preuve nouvelle :** (i) `ρ_p ∘ ρ_q = ρ_{p⊓q}` donne gratuitement que le pipeline peut enchaîner ses trois restrictions (phases 5 à 8) — **commutation aujourd'hui jamais énoncée** ; (ii) la fonctorialité du namespace, démontrée à la main au §4.5, devient un cas ; (iii) le Th. 9 devient l'instance où P est l'ordre à deux points.
**Coût :** une définition et un lemme de trois lignes au §2.6. **C'est le plus gros gain disponible après `TRANS-02`.**

### `FACT-03` — Schéma de bien-fondation (progression polarisée)
**Sources :** C/F-3 · F/ASPIR-02 · D/6.1 · G/§15-C · Q (sous réserve de `BLOQ-06`).
**Constat :** le §2.4 (RMQ 18) énonce « Trois critères, un seul geste » ; le §2.3 fusionne les deux premiers par le Th. 5, paramétré par la polarité. **Le troisième reste dehors**, rangé par une remarque et non par un théorème.

| Critère | Ordre | Mesure |
|---|---|---|
| pli (μ) | sur `𝕊_μ` | indice de taille |
| coinduction (ν) | dual, sur `𝕊_ν` | indice de taille |
| `fix` | `⊏` sur `Trellis_fin` | hauteur |

**Énoncé cible :** paramétrer non sur la polarité mais sur l'**ordre bien fondé lui-même**, la polarité devenant une conséquence du choix de l'ordre. Les trois critères deviennent trois instances d'un théorème unique dont le Th. 5 est le cas où l'ordre est celui des tailles.
**Objection sérieuse, et pourquoi elle ne tient pas :** on pourrait dire que `fix` itère jusqu'à *stationnarité* et non jusqu'à *épuisement*. C'est vrai de l'algorithme, faux du critère : le Th. 8 démontre la terminaison par « une chaîne strictement croissante dans un ordre de hauteur h ne peut compter plus de h pas » — de la bien-fondation, exactement comme les deux autres. Le §E.4.6 confirme en décidant que la traduction doit itérer h fois *sans* sortie anticipée.
**Gain supplémentaire :** le document a un critère de placement pour une extension future (coeffet / effet / raffinement) mais **pas pour un schéma de récursion nouveau** ; « exhiber un ordre bien fondé porté par le type » en est un.
**Contrainte :** à écrire avec **deux sortes de tailles** (`BLOQ-06`, `REFUS-05`) — un schéma, deux sortes.

### `FACT-04` — Schéma de ré-invocation bornée
**Sources :** Q/§4.2(iii) · F/DUP-06 · C/F-1 (emploi non signalé du Th. 1).
**Constat :** cinq mécanismes sont la même chose — traduction d'un grade fini n (n canaux ré-invoqués en séquence), VECE (`∏_{i<n} ε(i)` et `n·Δ₂`), SC (`φ_n`), EXPAND (`φ_{r_i}`), image de `fix` (h itérations, Th. 49). Le document le découvre pour **deux cas seulement** (« Les deux cas résistants qui restaient partagent donc un seul appareil », §E.4.6), et traite le point fixe déductif comme un cas résistant d'exception alors qu'il est le cas déjà résolu de la ré-invocation à grade fini (F/DUP-06 : `fix_h f ≡ f^h(⊥) ≡` ré-invocation de `f` sous le grade `h`).
**Énoncé cible :** nommer `reinvo(n, t)` avec sa loi de coût `φ_n`, et faire de EXPAND, VECE, SC et du Th. 49 des corollaires.

### `FACT-05` — Théorème de cohérence des coercions
**Sources :** G/§15-B et G/R2. Voir `STRUCT-07`, `PREUVE-10`.
**Doit absorber :** SUB, SUBBOX, CASE, WITH, narrowing. G le désigne comme « la dette la plus importante du noyau typé » et comme le candidat aspirateur du sous-typage. Noyau manquant : **join-semilattice + coercion coherence**, et non simplement « un treillis ».

### `FACT-06` — Théorème d'effacement / simulation
**Sources :** G/§15-D et G/R3 · F/ASPIR-04 · C/A-1 et cause β · Q/R-18 (gain).
**Constat :** tout dépend de différentes versions de `représentation riche → représentation effacée` : système de raffinement, fidélité de l'interpréteur, macros, compilation, débogueur de rejeu. **Il serait plus économique de faire de l'effacement un objet central du document** et de ranger sous lui `erase_grade`, `erase_effect`, `erase_phase`, `compile`.
**Énoncé cible (G) :** regrouper la chaîne `K7PL → métalangage → machine` avec préservation du typage, puis simulation, puis correction machine — ce qui empêcherait les glissements actuels entre correction du typage, fidélité de l'interpréteur et correction du compilateur.
**Énoncé cible (Q, plus général) :** *toute transformation définie par récurrence et hygiénique induit un morphisme de systèmes de raffinement* — couvre `Elab` (ch. 5), l'abaissement (Th. 36), la traduction (Th. 27) et l'expansion (Th. 32), aujourd'hui quatre instances séparées des Th. 11 et 12. Q le désigne comme « le théorème aspirateur le plus rentable du document, déjà à moitié écrit (§2.6) ».
**Variante FLASH (ASPIR-04) :** foncteur d'élaboration unifié absorbant Th. 27, Th. 31, Th. 32.

### `FACT-07` — Théorème fondamental de préservation fibrée
**Sources :** F/ASPIR-03.
**Énoncé cible :** une relation logique `ℛ_ℓ` définie sur les fibres du système de raffinement `p : 𝒟 → 𝒯`, indexée par le treillis ℒ, absorbant **Th. 10** (non-interférence graduée), **Th. 7** (divulgation délimitée), **Th. 43** (préservation de type et potentiel) et **Th. 47** (lemme fondamental).
**Réserve :** cette factorisation suppose réglés `BLOQ-05` (le niveau d'un calcul) et `PREUVE-11` (relation logique sur un produit). À ne pas écrire avant.

### `FACT-08` — Le partage en lecture et le partage de canal sont un seul geste
**Sources :** F/DUP-01 · E/§2 (isomorphisme B ≅ B′) · Q/§1.2.
**Constat :** `ReadCap<T>` est modélisé par le plongement dans la catégorie cartésienne de co-Kleisli `𝒞_{!ω}` ; `SharedChan(p)` est traduit par un service répliqué `!x(y).P`. Dans la SMCC ambiante, un service répliqué est exactement un habitant de `!_ω(In(p) ⊸ Out(p))` et la capacité de lecture partagée un habitant de `!_ω(Loc(R) ⊸ T)` : **deux projections du même foncteur de co-Kleisli au grade ω, sur deux types d'objets différents.**
**Conséquence de la duplication :** le compilateur maintient deux analyses d'aliasing séparées en phase 2 (arènes via le solveur SMT, canaux via le calcul de processus) alors qu'une seule analyse de co-Kleisli suffirait.
**Réserve (Q) :** l'identification est **vraie au niveau de la cible, fausse au niveau de la source** tant que `BLOQ-01` n'est pas tranché.

### `FACT-09` — L'inexpressibilité comme unique mode de garantie, et la réduction des familles d'erreurs
**Sources :** F/DUP-04 · Q/4.1 point 7 · C (non-dérivabilité au Th. 21).
**Constat :** quatre mécanismes sont des projections du même concept — non-dérivabilité dans une fibration : le principe général (§1.4, RMQ 9) ; l'impossibilité de mutation concurrente par absence de contraction (Th. 21) ; l'impossibilité de capture de nom par indexation de l'AST sur la portée (Th. 30) ; l'impossibilité d'évasion d'effet de couche 2 vers couche 3 par imbrication stricte des délimiteurs. Dans chaque cas, `Hom_ℱ(C)(−,−) = ∅`.
**Conséquence de la duplication :** 18 familles de codes d'erreur distinctes pour ce qui est structurellement le même échec d'unification.
**Action :** énoncer le principe une fois, et rattacher chaque famille de codes à la prémisse manquante correspondante — ce qui rejoint `PORT-07` (table code ⟷ prémisse). **Objectif annoncé par F à vérifier : 18 familles → 4 diagnostics fibrés universels.**

### `FACT-10` — Séquencement dans la quantale et préfixage dans le calcul de processus
**Sources :** F/DUP-05.
**Constat :** la quantale ℰ₀ sur `Ops` est l'algèbre des chemins du graphe de transitions, quotientée par les relations de commutation structurelles. Le produit `·` et l'opérateur de préfixe `.P` sont la même loi de monoïde libre, agissant l'une sur le type d'effet (statique) et l'autre sur le terme de processus (dynamique).
**Conséquence :** la preuve de commutation du Th. 40 doit être répétée pour la quantale statique et pour la congruence structurelle au Th. 48.
**Réserve :** cette identification est ce qui rend `BLOQ-07` visible — le préfixage sérialise-t-il réellement les traces ? Ne pas écrire la factorisation avant le lemme de simulation (`PREUVE-07`).

### `FACT-11` — `Mailbox` comme objet unique
**Sources :** Q/R-07 (gain).
**Énoncé cible :** `Mailbox = Σ_{c ∈ Chan} Bag(Cap(c))` — un multi-ensemble de ressources linéaires indexé par canal, avec une règle de consommation atomique multi-places. Permet d'énoncer le Th. 25, le circuit breaker de session (comparaison de tag), la ré-invocation séquentielle d'un grade fini et la traduction `!x(y).P` comme **quatre lectures d'un seul objet**.

### `FACT-12` — Adjonction graduée unifiant coeffets et effets
**Sources :** E/§6.1 et §6.2.
**Constat (E) :** la cause racine commune à DEF-01, DEF-02 et DEF-05 serait l'absence de formalisation explicite de l'adjonction graduée entre la comonade des coeffets et la monade des effets dans le cadre PBV. Le document traite `𝒢`, `ℰ` et les contraintes de valeur comme trois dimensions parallèles qui se « rencontrent » dans le jugement germinal, alors que PBV définit canoniquement une adjonction entre valeurs et calculs.
**Énoncé cible :** un unique monadique/comonadique gradué sur l'adjonction `F ⊣ U`, la graduation étant prise dans `G × ℰ` ; les trois couches, les régimes d'usage et les propagations d'effets en deviennent des instances de l'enrichissement de cette adjonction par une monade/comonade graduée distributive. Tous les mécanismes d'effacement deviennent l'unique foncteur d'oubli de la graduation.
**Réduction annoncée (à vérifier) :** 3 spécialisations du jugement + 2 fonctions de la loi distributive + 3 règles d'inclusion fonctorielle + 5 mécanismes d'effacement → **1 principe et 3 instances**.
**Relation avec `STRUCT-01` :** C et Q situent le germe respectivement dans la modalité graduée sur une structure ordonnée et dans l'adjonction valeurs/calculs lue comme système de raffinement. Les trois descriptions sont compatibles ; le choix de formulation est un arbitrage de rédaction — voir `ARB-PR-05`.

### `FACT-13` — Une seule loi de substitution pour quatre lemmes
**Sources :** D/Obs. 5 et 6.5 · F/ASPIR-01 · G/§15-A.
**Constat :** le manuscrit a quatre énoncés qui sont le même patron *substitution commute avec construction* — Th. 11 (schéma de commutation), Th. 41 (substitution), Th. 42 (substitution simultanée), Th. 30 (métasubstitution des macros), auxquels D ajoute Th. 48 (commutation de la traduction).
**Énoncé cible :** `(C[t])[σ] = C[t[σ]]`, paramétré par (1) le langage objet, (2) les règles de construction, (3) la discipline de liaison et d'évitement de capture.
**Distinction avec `FACT-01` :** `FACT-01` porte sur la **mise à l'échelle par un grade**, celle-ci sur la **substitution**. Les deux schémas coexistent au §2.6 et ne doivent pas être fusionnés sans vérification.

### `FACT-14` — Cadre unique des structures monotones
**Sources :** D/6.4. Voir `STRUCT-17`.

### `FACT-15` — Une seule relation d'équivalence observationnelle pour les trois rejeux
**Sources :** D/6.6.
**Constat :** rejeu logique (Th. 22), rejeu bit-identique (Th. 23) et rejeu stratifié (Th. 46) sont déjà connectés par la relation logique et la projection `π_ℓ` ; la factorisation est **présente dans l'annexe (§E.4.2)** et invisible dans le corps.
**Gain :** la relation entre P4 et la confidentialité devient explicite. Instance de `FACT-02`.

### `FACT-16` — `Injectivité(obs, repr)` comme exigence de représentation unique
**Sources :** Q/R-11 (gain). Voir `PORT-04`.
**Absorbe cinq dispositions éparses :** élision → version de schéma ; purge → rotation du journal ; bourrage → règle d'abaissement ; NaN → Th. 18 ; ordre des segments → `mremap`. **Toutes disent la même chose : aucune liberté représentationnelle ne doit être observable.**

### `FACT-17` — Une loi unique d'introduction des ressources d'écriture
**Sources :** Q/R-15 (gain).
**Énoncé cible :** *une ressource d'écriture est introduite au plus une fois par région, et son introduction est indexée par une mesure strictement décroissante.* Le paramètre d'âge `Lin_k`, la taille de l'arène et le grade linéaire sont la même mesure lue sur trois objets. Le document le pressent (§3.1 p. 96 : « C'est, au niveau des types, une instance du même principe que la mesure strictement décroissante qui fonde la terminaison des catamorphismes ») sans en tirer le lemme unique qui porterait le Th. 21, la non-cyclicité des destinations et la terminaison des arènes.

### `FACT-18` — La fenêtre statiquement dimensionnée sur un objet coinductif
**Sources :** Q/R-20 (gain).
**Constat :** troncature à r niveaux (Th. 6), borne de profondeur de pile du PDA (§4.2) et taille de pile précalculée du `StreamContext` (§4.2) sont trois instances d'un seul objet. Un lemme de troncature unique les couvrirait et donnerait à P3 sa forme générale : *toute fenêtre est un grade, tout grade est connu à la compilation.*

### `FACT-19` — L'ordre d'occurrence
**Sources :** Q/R-23 (gain).
**Constat :** trois endroits en ont besoin, aucun ne le nomme — `occ(m)` dans EXPAND, la zone ordonnée du §3.1 (échange restreint), l'ordre de séquentialisation du Th. 42. Le nommer une fois permet d'énoncer la condition de bord du lemme de substitution, l'ordre du produit dans EXPAND et l'ordre de retrait des liaisons du Th. 42.

### `FACT-20` — Annexe unique « classes de motifs et bornes »
**Sources :** Q/R-27 (gain).
**Constat :** §4.2 (R-expressions), §4.5 (protocole Noise comme DFA « en temps constant et sans allocation » — même ambiguïté) et §5.1 (syntaxe de K7PL) sont trois analyses de langages par automate. Une seule annexe avec la même table (machine × temps × espace × classe reconnue) les couvrirait, et P3 y serait appliqué une fois.

### `FACT-21` — Architecture minimale à cinq couches de preuve
**Sources :** G/§17.
**Constat :** G recommande de **ne rajouter aucun mécanisme** et de réduire le système à cinq couches de preuve — (1) algèbre graduée ; (2) jugement + sous-typage cohérent ; (3) sémantique des points fixes et effets ; (4) effacement / traduction / simulation ; (5) machine concrète. Les trois fragments, les sessions, les acteurs, les macros, les effets, les arènes et les modalités cessent d'être des « systèmes voisins » et deviennent des instances de ces cinq niveaux.
**Statut :** proposition d'organisation d'ensemble, à confronter au noyau minimal de C (§9) et de Q (§9). Voir `ARB-PR-05`.

### `FACT-22` — Formulation fibrée bimodale
**Sources :** F/cause racine 1 et plan de refactorisation.
**Constat (F) :** la cause racine de toutes les tensions serait l'asymétrie de traitement entre la dimension coeffet (statique, fermée, modélisée rigoureusement) et la dimension effet (ouverte, étendue par patches successifs : famille temporelle indexée, monoïde de transformateurs, système de sortes).
**Énoncé cible :** `p : Judg(𝒞, ℛ, ℰ) → Proc(π-calcul)`, où les trois couches ne sont que les restrictions de la fibre au-dessus des sous-semi-anneaux `{1}`, `{0,1}`, `{ω}` ; le système de types K7PL est le foncteur de raffinement bimodal graduant simultanément les préconditions d'entrée (coeffets) et les postconditions de trace (effets).
**Statut :** cadre alternatif, cohérent avec `FACT-12` et avec le noyau minimal de Q. **À arbitrer, pas à cumuler** — voir `ARB-PR-05`.
**Objectifs chiffrés annoncés par F, à vérifier après refonte :** supprimer 14 théorèmes redondants ; réduire les règles de typage de 39 à 24 ; unifier 18 familles de codes d'erreur en 4 ; élever la formalisation au niveau d'une preuve mécanisée sans perte d'expressivité.

### `FACT-23` — Relation entre `□` et la modalité duale de ◇
**Sources :** Q/R-31 (gain).
**Constat :** `□V` dit « disponible à tout instant » ; la duale dit « disponible maintenant et après toute attente non bornée ». Ce sont presque le même objet, et le document le sent (« □ ressemble à la modalité d'usage sans lui être identique »).
**Action :** une fois le symbole posé (`BLOQ-02`), écrire la relation — probablement `□V ⊆ 𝕊V`. **Si elle tient, la grammaire ne gagne pas un connecteur : elle en réutilise un.** C'est exactement l'économie que la condition de clôture réclame, et elle est à portée d'une ligne.

### `FACT-24` — Le système de modes comme unique lieu des onze modalités
**Sources :** étude d'opportunité HoTT §6 (I1) · fusionne `STRUCT-01`, `STRUCT-02` et `FACT-12`.
**Constat :** K7PL possède onze instances d'une même construction — huit modalités graduées, plus la zone d'échange, la donnée de mode et la modalité `•` — et les traite en onze endroits, dont trois comme des exceptions locales. Le cadre qui range exactement cela est celui que le manuscrit cite déjà en [6] au §3.1 : le mode y est le **paramètre**, et l'admissibilité de la coupure y est démontrée indépendamment de la théorie des modes.
**Énoncé cible :** poser au §1.4, avant le jugement germinal, la notion de *discipline* — un mode (algèbre, idéal de contraction, booléen d'affaiblissement, prédicat d'échange) et trois familles de comonades graduées rangées par variance — puis présenter le jugement comme la présentation d'un système à quatre paramètres. La table 3, le critère de placement et la condition de clôture en découlent.
**Attention :** ce cadre range les modes ; **il ne compte pas les usages**. La graduation reste à importer de la famille graduée (`TRANS-02`, `BIB-21`). Les deux appareils se composent et ne se remplacent pas.
**Aucune dépendance homotopique.** Voir `ARB-PR-07` pour la décision de cadre.

---

## 9. Lot REFUS — factorisations à ne pas faire

> Ces refus doivent être **écrits** dans le manuscrit, avec leur motif. C et Q relèvent tous deux que le refus documenté d'une fusion tentante est le signal le plus fiable de discernement — et le manuscrit en pratique déjà trois.

| # | Fusion tentante | Pourquoi la refuser | Sources |
|---|---|---|---|
| `REFUS-01` | grade et indice de taille | Les deux vivent dans ℛ, mais l'indice doit être pris dans le seul fragment bien fondé. Mêmes objets, ordres différents, obligations différentes. Justification déjà donnée (irréflexivité de l'ordre strict, contre-exemple Agda) — **à conserver** | C/F-4(a) |
| `REFUS-02` | la comonade d'usage `!^r` et la comonade cofree de l'histomorphisme | « Deux comonades, deux rôles, et aucune raison qu'elles se confondent » (§2.3). L'histomorphisme requiert une donnée structurelle supplémentaire `(F, N, λ)` | C/F-4(b) · G/B8 |
| `REFUS-03` | graphe de câblage et graphe d'attente | Mêmes sommets, régimes de définition opposés (fini/inductif contre déplié/coinductif). **Seul endroit du document où une preuve nomme correctement l'étape qui lui manque** | C/F-4(c) · G/B6 · Q/R-17 · D/Obj. 8 |
| `REFUS-04` | `π†` et `π_ℓ` | Même forme, emplois **opposés** : employer la première là où la seconde est requise ouvrirait le canal temporel dans la démonstration même qui prétend le fermer. Mêmes objets, invariants différents ⟹ relation, pas identité. Compatible avec `FACT-02` : deux instances d'un même schéma, jamais interchangeables | Q/4.3 · F/COL-04 |
| `REFUS-05` | tailles inductives et coinductives | **C'est l'erreur que produit `BLOQ-06`** : le Th. 5 unifie le *schéma*, et l'unification du schéma a entraîné celle de l'objet. La bonne factorisation est : un schéma, deux sortes | Q/4.3 |
| `REFUS-06` | Th. 19, Th. 36 et Th. 43 | RMQ 24-25 démontrent que leurs emboîtements sont de sens contraire et qu'aucun ne contient l'autre. **Le document a résisté à cette fusion et il a eu raison — à conserver explicitement** | Q/4.3 · C |
| `REFUS-07` | effets algébriques et effets à portée | D : « Keep them distinguished. They are not instances of the same abstraction » — les effets à portée requièrent le monoïde de transformateurs. **Contredit par F/CRIT-01** (les unifier via Hefty Algebras) : voir `ARB-PR-03` | D/6.3 contre F/CRIT-01 |

---

## 10. Lot REECR — tableau des énoncés à affaiblir ou conditionner

> Application directe de `TRANS-08` : quand une réserve borne une affirmation, **réécrire l'affirmation** plutôt que l'annoter.

| # | Affirmation actuelle | Lieu | Réécriture | Sources |
|---|---|---|---|---|
| `REECR-01` | « tout programme K7PL est un morphisme dans une catégorie ambiante 𝒞 » | P1, §1.3 | scinder en P1a (vocabulaire, acquis) / P1b (interprétation, obligation) | C/A-2 |
| `REECR-02` | « l'isolation entre eux repose **entièrement** sur les preuves du système de types » | §4.5 | « pour le code compilé par K7PL » | C/C-2, G/B4 |
| `REECR-03` | « fidèle à la sémantique de K7PL sur la structure de communication, sur le contrôle et sur les effets » | Th. 28 | « sous l'hypothèse d'une simulation `Sim` » jusqu'à ce que le lemme soit établi | C/A-1 |
| `REECR-04` | « les correspondances rendent cette génération de code directe » | §6.1 | rappeler le domaine du Th. 20 (`O(n)` hors scalaires) | C/C-1 |
| `REECR-05` | « Trois réponses, trois domiciles, et aucune quatrième place à inventer » | §1.4 | scinder clôture forte (données) / clôture faible (actions) | C/B-3 |
| `REECR-06` | « À l'exécution, l'audit trouve trois régions et non six » | §1.3 | énumérer les six, ou retirer le chiffre | C/C-3 |
| `REECR-07` | le budget lu comme prédiction | §1.3, §E.3.2 | borne supérieure, écart non borné sous opérations coupantes | C/D-2 |
| `REECR-08` | « Le théorème 27 est donc démontré, et la dette de fidélité est acquittée » | §E.4.6 | « l'induction est planifiée, ses quatre cas résistants sont réduits à des objets construits, elle n'est pas conduite » — c'est déjà ce que disent les ch. 2, 4 et 6 | Q/R-06 |
| `REECR-09` | « La non-interférence graduée et la divulgation délimitée cessent d'être bornées au fragment sans communication » | §E.5.5 | « elles restent bornées au fragment sans communication, le fragment avec communication n'ayant pas de règles » | Q/R-01, R-19 |
| `REECR-10` | « Aucune obligation ne déborde de ces trois » | Th. 34 | « aucune des formes de déclaration du ch. 6 n'en demande une quatrième ; le ch. 1 donne un contre-exemple à la nécessité » | Q/R-13 |
| `REECR-11` | « le système hôte ne peut y accéder après le retour » | Th. 26 | exigence sur la représentation de la passerelle (RMQ 30 le dit déjà) | Q/R-10, C/C-2 |
| `REECR-12` | « l'égalité observationnelle se transporte en identité de représentation » | Th. 23 | « sous une hypothèse d'injectivité observation/représentation, et sous un `E_repro` élargi à l'architecture » | Q/R-11, G/C1 |
| `REECR-13` | « préservant les lois algébriques de la théorie des roues, par exemple ⊥ + y = ⊥ » | Th. 18 | retirer, ou subordonner à une table de propagation spécifiée par K7PL | Q/R-12 |
| `REECR-14` | « l'audit des dix-huit familles d'erreurs » | Th. 16 | « énumération sur les 35 constructeurs du noyau, le catalogue de l'annexe A étant déclaré non exhaustif » | Q/R-14 |
| `REECR-15` | « les trois dispositions coïncident bit à bit » | Th. 20 | « pour un profil de représentation `Π` donné » | Q/R-16 |
| `REECR-16` | « la syntaxe d'un programme est fixée à l'issue de la Phase 0 » | Th. 29 | conserver, une fois la phase 0 ajoutée au pipeline | Q/R-09 |
| `REECR-17` | « la dérivation est déterministe puisque l'inférence est principale » | Th. 35 | « sous une hypothèse `D_det` de déterminisme des parcours, recherches et graines » | Q/R-09 |
| `REECR-18` | « un ordre que rien ne permet d'inverser » | §6.1 | le §6.3 le dit déjà : « à cet endroit précis, c'est un choix d'ingénierie présenté comme une contrainte logique » | Q/R-09 |
| `REECR-19` | « la couche 2 est un π-calcul enrichi de motifs de jonction » | §1.4, §4.6 | « la traduction de la couche 2 séquentielle est un fragment d'un tel calcul ; acteurs, boîtes aux lettres et jonctions sont des objets de la cible et de l'abaissement » | Q/R-01 |
| `REECR-20` | `𝒞_{!S}` avec S singleton (ch. 2) contre intervalles (ch. 3) | §2.2, §3.1 | choisir, et dire que les singletons sont les fragments logiques et les intervalles les modalités de type | Q/R-04 |
| `REECR-21` | « la transposition à la gradation reste à faire » (RMQ 14) | ch. 1 (citation du Th. 3) | faire remonter la réserve dans la citation du ch. 1 | Q/R-30 |
| `REECR-22` | « Le jeu de règles de typage lui-même, dont l'absence est ce qui suspend les quatre preuves ouvertes » | ch. 1 p. 6 | « les règles existent (§E.3) ; ce qui suspend les preuves est leur incomplétude et les objets manquants » | Q/R-01 |
| `REECR-23` | « sans en payer le prix » (sûreté des gestionnaires d'effets en PBV) | §1.4 | mentionner la charge d'allocation ou d'indirection réintroduite par les suspensions si l'inlining ne les élimine pas systématiquement | E/§3.2 |
| `REECR-24` | « l'isolation par types remplace la MMU **par construction** » | §4.5 | la terminalité garantit l'indiscernabilité comportementale logique, non l'absence de canaux cachés physiques | E/§3.2 |
| `REECR-25` | « deux paquets sémantiquement équivalents partagent un seul hash » | annexe D | « égalité de l'AST normalisé » | G/C2 |
| `REECR-26` | `@linear` — DFA `O(1)` (figure 7) | §4.2 | « `O(n)` en temps, `O(1)` par bloc » | Q/R-27 |
| `REECR-27` | « Le jugement de couche 3 ne comporte pas de Δ » | table 8, §5.1 | « n'admet que des liaisons de grade ω » | Q/R-24 |

---

## 11. Lot BIB — recherches et vérifications externes

| # | Objet | Pourquoi | Fiches liées | Sources |
|---|---|---|---|---|
| `BIB-01` | *Hefty Algebras* (Van der Rest & Bach Poulsen, 2023/2025) | Alternative proposée au monoïde ℳ pour factoriser l'élaboration des effets d'ordre supérieur par une algèbre paramétrée par les clauses de retour et d'opérations | `STRUCT-02`, `STRUCT-11`, `ARB-PR-03` | F/CRIT-01 |
| `BIB-02` | Saffrich & Thiemann 2025 — priorités sur boîtes aux lettres | Restreindre le Th. 17 aux sessions multiparties binaires ou hiérarchiques à priorités strictes | `BLOQ-13` | F/CRIT-02 |
| `BIB-03` | QTAL / défonctionnalisation quantitative (Huang 2023) | **Vérifier l'état exact** : la version dépendante est établie et publiée, la version quantitative est présentée comme une conjecture dont les preuves sont annoncées et non faites. Seule dette du document dont la levée dépend d'un travail de tiers non achevé | `PORT-16`, `PREUVE-02` | F, C/D-3, D/12.2 |
| `BIB-04` | Join-calculus de Fournet–Gonthier [60] — file de jonction | Solution connue au problème de consommation multi-places d'un motif de jonction ; déjà cité par le document mais non mobilisé ici | `STRUCT-04`, `IMPL-04` | Q/R-07 |
| `BIB-05` | Cohérence des sémantiques de coercions | La littérature traite le sujet comme un problème de preuve autonome ; identifier la forme d'énoncé applicable au produit mixte | `STRUCT-07`, `PREUVE-10` | G/B1 |
| `BIB-06` | Sabelfeld & Myers — divulgation délimitée | Confirmer que la lecture retenue (𝒳 ensemble d'expressions **closes**) est bien celle de la source | `BLOQ-11`, `PREUVE-04` | D/5.3, Q/R-19 |
| `BIB-07` | Issue Agda sur les tailles réflexives [25] | **Relire ce que la source incrimine exactement** : le partage d'une sorte de taille entre polarités, ou l'existence d'un plus grand élément ? La correction de `BLOQ-06` en dépend | `BLOQ-06`, `ARB-PR-02` | Q/R-03 |
| `BIB-08` | IEEE 754 — propagation de charge utile des NaN | Recommandée, non exigée ; opérations invalides produisant le NaN par défaut. Nécessaire pour borner le Th. 18 et `E_repro` | `BLOQ-12`, `PORT-04` | Q/R-11, R-12 |
| `BIB-09` | Spécifications Arrow et Cap'n Proto | Versions, endianness, alignement (8 ou 64), licéité de l'omission du bitmap, disposition composite des structures | `PORT-01`, `IMPL-06` | Q/R-16, G/§13 |
| `BIB-10` | Licata–Shulman–Riley — systèmes de modes | Cadre où le mode est le paramètre et où l'admissibilité de la coupure est démontrée indépendamment de la théorie des modes : c'est le vocabulaire qui range la zone, la donnée de mode et `•` | `STRUCT-01`, `STRUCT-02` | C/B-1 |
| `BIB-11` | Régions par polymorphisme paramétrique [19] | Voie la moins coûteuse pour définir « région » comme discipline de portée, par une traduction préservant types et sens | `BLOQ-09`, `PREUVE-12` | Q/R-15 |
| `BIB-12` | Extension additive de la logique linéaire classique, transport intuitionniste | Nécessaire pour typer l'abandon de session (Timeout, circuit breaker). Le document nomme l'obligation sans la conduire | `BLOQ-13` | Q/R-17 |
| `BIB-13` | Resucrage et algèbre de liaison de surface [26] | Nécessaire pour passer de l'hygiène sur l'AST du noyau à la préservation de l'α-équivalence de surface | `STRUCT-12`, `PORT-14a` | Q/R-30 |
| `BIB-14` | Types de chemin cubiques et assistant visé | La technique qui rendrait possible la transposition graduée du Th. 3 n'est pas offerte par l'assistant visé : vérifier l'état actuel | `PREUVE-16`, `IMPL-09` | Q/R-30 |
| `BIB-15` | LMAX Disruptor contre preuve mécanisée de file bornée | **Le document ne dit pas que les deux objets diffèrent** : la preuve porte sur une file générique, la note d'ingénierie sur un anneau à curseur unique avec entrées tabulées. Le transport n'est pas nul | `IMPL-04` | C (passe 5) |
| `BIB-16` | Monoïde ordonné par treillis [27] contre quantale | Le ch. 1 identifie la structure minimale suffisante (distributivité sur les bornes supérieures **finies**) ; l'annexe utilise la complétude. Ne mécaniser que ce qui sert | `PREUVE-09` | Q/R-21 |
| `BIB-17` | Invalidation explicite des protocoles d'accès distant [54] | Solution citée pour la révocation d'une capacité exportée | `IMPL-05` | Q/R-10 |
| `BIB-18` | Ergonomie : essai contrôlé randomisé défavorable + étude sur les barrières d'adoption | **Rien à corriger.** Le document conduit l'objection contre lui-même mieux qu'un relecteur ne le ferait (« aucune mesure favorable ne lui fait pendant […] Un chapitre qui ne citerait que ce qui l'arrange ne ferait pas de la conception interdisciplinaire, il en emprunterait le vocabulaire »). À maintenir tel quel | — | C (passe 4) |
| `BIB-19` | Castellan et al. — triangle effets / élimination dépendante / substitution | Vérifier que la sortie revendiquée par PBV couvre bien le cas des effets **indexés par une valeur** et non seulement le cas général | `STRUCT-21`, `PREUVE-06` | E/DEF-04 |
| `BIB-20` | calf / decalf — cadre logique conscient du coût | Distinction de phase extension/intension, primitive de comptage de pas, méthode du physicien, préordre intrinsèque sur les types ; bâti sur CBPV comme K7PL. **Route pour le Th. 45** | `PREUVE-01`, `STRUCT-05`, `STRUCT-19`, `PORT-09`, `PORT-10`, `FACT-02` | étude HoTT §3.2 |
| `BIB-21` | Théorie des types graduée formalisée (Abel–Danielsson–Eriksson) | Patron de mécanisation : semi-anneau partiellement ordonné, universe, effacement, normalisation et décidabilité de l'égalité définitionnelle, en Agda. **Vérifier la restriction « pas d'instances affectant l'égalité définitionnelle » contre le produit mixte de la table 20** | `TRANS-02`, `FACT-06`, `IMPL-09` | étude HoTT §3.1 |
| `BIB-22` | Récursion gardée multi-horloges (CloTT) ; bisimulation comme type de chemin | `▷^κ` est la modalité `○` de K7PL, règles à la Fitch ; la productivité est encodée dans le type, **sans indice de taille**. Alternative à la clause `i ∈ ℕ∞ ∖ {ω}` | `BLOQ-06`, `BLOQ-01a`, `ARB-PR-02`, `STRUCT-04` | étude HoTT §3.5 |
| `BIB-23` | Granule — sessions et types modaux gradués ; TLL_C — sessions dépendantes | Précédent direct : réintroduire des comportements de concurrence non linéaires dans une base linéaire graduée | `STRUCT-04`, `BLOQ-01` voie 2, `FACT-11` | étude HoTT §3.6 |
| `BIB-24` | Théorie cubique sans types Glue (XTT et variantes) | Conserve extensionnalité fonctionnelle et quotients **sans univalence**, donc sans conflit avec la détermination de représentation. Seule porte cubique compatible | `PREUVE-16`, `BIB-14` | étude HoTT §6 (I5) |
| `BIB-25` | Algèbre de Kleene concurrente (Hoare, Möller, Struth, Wehrman) | La quantale ℰ₀ doit devenir concurrente : `·` séquentiel non commutatif, `∥` parallèle commutatif, loi d'échange. **Vérifier la forme exacte de la loi d'échange et sa compatibilité avec la résiduation du budget** | `N-01`, table 2 du ch. 1 | programme concurrence §6 |
| `BIB-26` | Déterminisme observationnel et flux d'information concurrent | La non-interférence séquentielle ne survit pas à la concurrence : l'ordonnanceur entre dans le modèle d'attaquant. Instruire la notion correcte avant d'énoncer `N-11` | `PREUVE-03`, Th. 7, Th. 10 | programme concurrence §4.2 |
| `BIB-27` | Types de boîtes aux lettres (de'Liguoro–Padovani, ECOOP 2018) ; *Special Delivery* (Fowler et al.) | Motifs commutatifs, résiduel de motif, **graphe de dépendance avec théorème d'absence d'interblocage**, système algorithmique co-contextuel et vérificateur prototype. **Remplace le graphe de câblage manquant** | `BLOQ-13`, `PREUVE-13`, `STRUCT-04`, `FACT-11` | programme concurrence §2 (D3, D4) |
| `BIB-28` | Exceptional GV / types de session asynchrones exceptionnels (Fowler–Lindley–Morris–Decova, POPL 2019) | Système affine, annulation explicite de session, fidélité, progrès global, confluence. **Type le Timeout et le disjoncteur du §4.5, et porte la défaillance distribuée** | `BLOQ-13` point 3, `N-10`, `N-14` | programme concurrence §3.2 |
| `BIB-29` | Valeurs localisées (HasChor, ChorLean, valeurs multiplement localisées) | `a @ l` comme comonade graduée sur un demi-treillis de localisations ; ChorLean est en Lean, ce qui intéresse la cible de mécanisation | `N-12`, `N-13` | programme concurrence §2 (D5) |

**Quatre emprunts de forme et non de résultat, correctement déclarés par le document** (C, passe 5) — à conserver tels quels : Kelly–Mac Lane (§2.2, avec la distinction entre part monoïdale publiée et part graduée posée) ; la divulgation délimitée (Th. 7) ; le typage des sessions (§3.2, « établie pour la grammaire de GV, non pour celle de K7PL ») ; la défonctionnalisation quantitative (§6.1, « la forme est donc connue et le résultat ne l'est pas »).

---

## 12. Lot TRANS — refontes transversales

> Une correction, plusieurs symptômes. **C'est ici que se trouve le meilleur rapport bénéfice/coût de toute la campagne.**

### `TRANS-01` — Sceau à deux axes sur chaque énoncé (statut × niveau)
**Sources :** Q/RT-1 · G/A1 · C/cause γ · D/RC1.
**Symptômes couverts :** `STRUCT-03`, `PORT-05`, `PORT-06`, `PORT-07`, `PORT-08`, `PORT-14`, `PORT-16`, `PREUVE-04`, `PREUVE-09`, `BLOQ-12`, `STRUCT-15`.
**Action :**
- Axe 1 — **statut** : `DÉFINITION` · `THÉORÈME` · `PROPOSITION` (esquissée, réserve écrite) · `CONJECTURE` · `EXIGENCE` · `LITTÉRATURE`.
- Axe 2 — **niveau** : `LANGAGE` · `COMPILATION` · `REPRÉSENTATION` · `DÉPLOIEMENT`.
- Applications immédiates : Th. 20 → PROPOSITION ⟨représentation⟩ ; Th. 26 → deux énoncés (THÉORÈME ⟨langage⟩ + EXIGENCE ⟨représentation⟩) ; Th. 31 et Th. 34 → DÉFINITION ; Th. 36 → PROPOSITION non démontrée ; Th. 7 → PROPOSITION non démontrée ; Th. 16 → PROPOSITION ⟨langage⟩ + EXIGENCE ⟨compilation⟩ ; Th. 18 → PROPOSITION ⟨représentation⟩.
**Coût :** typographique. **Aucun contenu ajouté.**
**Effet mesuré :** 11 énoncés changent de case sans qu'un mot de leur contenu change, et **la part réellement démontrée au niveau du langage apparaît** — Q la chiffre à 18 résultats (Th. 5, 8, 11, 12, 13, 15, 37, 38, 39, 40 pour n fini, 41, 42, 43, 44, 46, 48, 49, 50), « ce qui est beaucoup pour une spécification non mécanisée, et le document ne le sait pas ».
**Rappel du besoin de mécanisation :** un assistant exige exactement ce que l'environnement unique interdit — savoir si chaque énoncé est un `Theorem`, un `Axiom`, une `Definition`, une `Hypothesis` de module ou une `Conjecture`.

### `TRANS-02` — Décomposition module × ordre du grade
**Sources :** Q/RT-2.
**Symptômes couverts :** `BLOQ-03`, `BLOQ-04`, `BLOQ-05`, `NOTA-01` (N-01, N-04), `NOTA-04`, `STRUCT-14`, `PREUVE-08` en partie.
**Cause :** le grade a été construit par accrétion — usage, monotonie, niveau, budget — chaque ajout justifié par « une structure ordonnée de plus, les lois passent au produit ». Les trois conditions d'admission du §1.4 sont **insuffisantes**.
**Abstraction manquante :**

```
ℛ  =  ( 𝕌 × 𝔅 )      ×      ( 𝕄 × ℒ )
      module sur 𝕌           ordre pur, action triviale
```

avec `𝕌 = ℚ≥0 ∪ {ω}` (le ℛ du ch. 2), `𝔅 = ℕ∞` muni de `⊖` continu en ω (`BLOQ-03`), et deux projections `π_mod`, `π_ord`.
**Sept effets :** (i) les fragments catégoriques du §2.2 deviennent `𝒞_{!π_𝕌^{-1}(S)}` — singletons et intervalles coexistent sans conflit ; (ii) la table 6 dit laquelle des deux lectures elle donne ; (iii) `1/N` revient dans le noyau formel ; (iv) `r · Δ` est défini ; (v) le niveau d'un calcul devient un indice de dérivation, distinct de `niv(r)` ; (vi) `𝒢_pile` et `𝒢_budget` sont des préimages de projections ; (vii) **la condition de clôture devient vérifiable par machine** : une composante nouvelle est admissible ssi elle est un module sur 𝕌 ou un ordre pur à action triviale — exactement ce que le §1.4 cherchait sans l'obtenir.
**Coût :** un renommage, trois définitions, une table d'arithmétique. **Répare sept critiques dont deux bloquantes. C'est la correction la plus rentable de la campagne.**

### `TRANS-03` — Tracer la frontière noyau / cible
**Sources :** Q/RT-3 · C/§1.3 (deux confusions de niveaux) · G/R1 · F (découplage sémantique / ABI).
**Symptômes couverts :** `BLOQ-01`, `BLOQ-09`, `BLOQ-13`, `STRUCT-04`, `STRUCT-15`, et la moitié couche 2 des Th. 17, 21, 22, 24, 25, 26, 27, 28, 45, 47, 51.
**Cause :** deux objets portent le nom « couche 2 » — (a) le fragment affine du λ-calcul gradué, **formalisé** à l'annexe E ; (b) le calcul de processus avec acteurs, canaux, boîtes aux lettres, jonctions, arènes et supervision, **décrit** aux ch. 4 et 7 et **construit dans la cible**. Le document passe de (a) à (b) en lisant l'inclusion dans le sens qui l'arrange : formellement une traduction d'un calcul séquentiel vers un calcul de processus ; rhétoriquement une identification du langage source à un langage concurrent.
**Abstraction manquante :** aucune. **Il manque une frontière déclarée** — c'est le cas où la plus petite correction est une clarification et où toute abstraction supplémentaire serait gratuite.
**Coût :** voie 1, une page ; voie 2, quarante. Voir `BLOQ-01` pour le détail des deux voies.

### `TRANS-04` — Déclarer ce qu'une passe, une représentation et un environnement doivent préserver
**Sources :** Q/RT-4 · G/R1 · E/§4.
**Symptômes couverts :** `STRUCT-05`, `PORT-04`, `PORT-16`, `BLOQ-12`, `PORT-01`, `PREUVE-08`, `PREUVE-09`, `PORT-14b`, `STRUCT-06` en partie.
**Cause :** le document multiplie les propriétés de préservation — sémantique (P1), graduée (Th. 36), de trace (Th. 43), de projection (Th. 46, 47), de disposition (Th. 20), de représentation (Th. 23) — **sans jamais dire lesquelles sont obligatoires pour qui**. Or elles ne sont pas comparables : P1 porte sur la dénotation, la non-interférence temporelle exige la préservation de `π_ℓ(τ)` qui est strictement plus forte, et l'identité binaire exige une injectivité observation/représentation plus forte encore.
**Action :** la table `P-dén` / `P-grad` / `P-trace(ℓ)` / `P-repr` de `STRUCT-05`, plus le profil de représentation `Π` de `IMPL-06`, plus la règle d'interaction (« une unité marquée ℓ-sensible n'admet que les passes `P-trace(ℓ)` »).
**Coût :** une table, quatre définitions, trois lemmes de compatibilité (un par famille de réécriture).
**Effet :** (i) le conflit `fix f` / évaluation semi-naïve se résout ; (ii) Th. 18, 20, 23, 26 deviennent des exigences de `P-repr` ; (iii) la phrase du ch. 1 « aucune affirmation ne figure sans qu'un porteur la porte » devient **vérifiable**, chaque énoncé disant de quel invariant il relève.

### `TRANS-05` — Registre unique des obligations et règle de propagation
**Sources :** Q/RT-5 · C (passe 7, table 1 et engagements manquants) · D/RC1.
**Symptômes couverts :** `STRUCT-03`, `NOTA-03`, `NOTA-07`, `BLOQ-02`, `BLOQ-11`, `STRUCT-13`, `NOTA-04`, `BLOQ-13`, et toutes les contradictions de statut.
**Cause :** le document se corrige **en avant** et ne propage pas **en arrière**. Chaque correction est écrite là où elle est découverte, avec une RMQ qui la signale ; les énoncés antérieurs ne sont pas mis à jour. Résultat : un document stratifié au sens géologique — les couches récentes sont justes, les anciennes contredisent.
**Action :**
1. Un **registre normatif** en annexe, identifiants `O-nn`, chaque entrée portant : énoncé, niveau (`TRANS-01`), statut, dépendances amont et aval, route (littérature / démonstration / mesure). Les `T-06`, `T-42`, `T-43`, `T-44`, `G.1`, `G.3` y sont résolus ou supprimés.
2. La table 1 devient une **vue** de ce registre filtrée par statut = engagement, et non une liste parallèle. Les quatre comptes de travaux ouverts deviennent quatre vues du même registre.
3. Une **règle de propagation** écrite au §1.2 : *tout changement de statut d'un énoncé est propagé à toutes ses mentions ; une mention non propagée est une erreur du document, pas une nuance.* Le document a déjà cette règle implicitement (« un document qui ne relit pas ses engagements finit par s'accuser de dettes qu'il a payées ») : il faut la rendre contraignante.
**Trois engagements manquants à inscrire au registre (C) :**

| Engagement manquant | Route | Gravité |
|---|---|---|
| La correction de ressource (Th. 45) | démonstration | supérieure à six des huit engagements listés |
| L'accord entre `→` et `⟦·⟧` | démonstration | bloquante |
| L'existence de `⟦−⟧_𝒞` | démonstration ou requalification de P1 | bloquante |

**Une dette déclarée qui est en réalité payée** (Q/R-19) : la borne inférieure que le §1.3 réclame (« pour chaque niveau ℓ, la projection du journal sur ce niveau doit suffire à rejouer le comportement que l'observateur de niveau ℓ observe ») **est exactement le Th. 46, démontré p. 269**. Le ch. 1 écrit « Ce qui manque est de l'écrire, non de la trouver » — c'est écrit. Seul cas du document où une dette déclarée est payée sans que la table le reflète : **à propager.**
**Effet :** le document devient auditable en une heure au lieu d'exiger une lecture de 285 pages. **Coût :** une annexe de deux pages, générée pour moitié de ce qui existe déjà (§E.6, table 1, §E.5.6).

### `TRANS-06` — Passe de remontée : toute condition découverte en annexe qui contraint un objet du ch. 1 doit y être portée
**Sources :** C/cause α · F (recommandation finale) · Q/RT-5.
**Diagnostic :** le ch. 1 pose des objets que les ch. 2 à 4 construisent, puis l'annexe E découvre des conditions que le ch. 1 aurait dû porter. Le document en est conscient (RMQ 4 : « Le Prolégomène énonce ce que le document devra tenir. Il ne le tient pas lui-même ») **mais traite cela comme une convention d'exposition alors que c'est une dépendance non résolue** : le §E.5.6 déclare que l'incertitude 1 « touche l'axiome », c'est-à-dire remonte jusqu'au ch. 1.
**Au moins six remontées à conduire :**
1. la condition « 𝒳 clos » (§E.4.5) → règle de déclassification du §2.4 (`BLOQ-11`) ;
2. la clause de niveau sur OP (§E.5.6, incertitude 1) → §1.4 (`BLOQ-05`) ;
3. la lecture par borne des annotations (§E.3.2) → §1.3, P3 (`PORT-10`) ;
4. l'inversion de sédimentation sur deux axes (§E.3.2) → §1.2 (`PORT-15`) ;
5. la forme vectorielle indexée temporelle `ℕ∞^ℒ` (§E.1, Th. 37) → ch. 1 et 2 (F) ;
6. le produit mixte du sous-typage (§E.3 p. 250, table 20) → ch. 1 à 3 (`BLOQ-14`, F/COL-03).

### `TRANS-07` — Décider quelle sémantique est primitive et dériver les deux autres
**Sources :** C/cause β.
**Diagnostic :** le document a **une** sémantique construite (la relation `→`, §E.4), **une** sémantique empruntée (la machine à sessions linéaires, via `⟦·⟧`), et **une** sémantique invoquée sans construction (𝒞). Trois objets, deux liens manquants. Chaque lien manquant est localement invisible : le §E.4.1 raisonne comme si `→` était seule, le §4.6 comme si `⟦·⟧` suffisait, le §1.3 comme si 𝒞 interprétait. **Chacun est cohérent, et l'inconsistance n'apparaît qu'en les tenant ensemble.**
**Action :** `→` primitive (le §E.4.1 le dit déjà) ; `⟦·⟧` reliée par simulation (`PREUVE-07`) ; 𝒞 requalifiée en vocabulaire (`BLOQ-08`). **Une décision, deux dettes soldées.**

### `TRANS-08` — Convention de réécriture : une réserve qui borne une affirmation doit réécrire l'affirmation
**Sources :** C/cause γ.
**Diagnostic :** figure de style récurrente — « Cet énoncé demande d'être borné, faute de quoi il promet plus qu'il ne tient », suivi de la borne, **sans réécriture de l'énoncé**. La pratique est globalement excellente (elle vaut mieux que le silence) mais laisse au lecteur le soin d'appliquer la correction ; or un lecteur pressé lit l'affirmation et non la réserve, et le document le sait (RMQ 6 : « Un lecteur pressé conclurait le contraire de ce qui précède »).
**Action :** poser la convention au §1.2 et l'appliquer systématiquement — le lot `REECR` en est la mise en œuvre. Le document le fait déjà par endroits (§1.2 : « La table le dit maintenant, et le disait mal auparavant ») : il suffit de généraliser.

### `TRANS-09` — Factoriser les obligations et non seulement les théories
**Sources :** G/R4 · G/§14.
**Diagnostic :** le document factorise très bien les théories — confidentialité/monotonie, effets/grades, sessions/implication linéaire, macros/substitution, coercions/sous-typage — mais pas encore les **obligations**. « L'architecture conceptuelle est parfois déjà plus petite que la théorie de preuve qui lui correspond. »
**Action :** faire émerger quatre preuves transversales — substitution (`FACT-13`), cohérence des coercions (`FACT-05`), effacement/simulation (`FACT-06`), progression polarisée (`FACT-03`) — puis **requalifier le reste comme instances**. C'est la conclusion centrale de G : « je ne pense pas que K7PL souffre d'un manque de théorie ; il souffre de quelques théorèmes de liaison insuffisamment explicites. Ajouter davantage de mécanismes serait probablement la mauvaise direction. »

---

## 13. Arbitrages requis — divergences entre relecteurs

> **À trancher avant exécution.** Aucune de ces fiches ne doit être appliquée telle quelle sans décision.

### `ARB-PR-01` — ✅ **Tranché** — Le sens de la subsomption modale
**Position E (DEF-01, gravité A) :** `Lin T <: Aff T <: Unr T` inverse la subsomption et détruit la sûreté mémoire ; il faut inverser la relation.
**Position implicite des quatre autres :** aucun ne relève d'inversion ; Q analyse le produit mixte du sous-typage (table 20) en détail, y trouve des défauts de structure (`STRUCT-07`) mais pas d'inversion de sens ; C lit la table 20 comme donnant « la bonne présentation ».
**Position F (COL-03) :** il n'y a pas inversion mais **collision entre deux ordres** (précision `⊑` et sous-typage `≼`), rectifiée *in extremis* par le produit mixte de l'annexe E.3 et laissée non corrigée dans le corps.
**Vérification conduite le 14 septembre 2026 :** l'énoncé de la p. 11 est bien celui que E cite, la règle SUBBOX (p. 249) et la table 20 (p. 250) portent la direction opposée, et le manuscrit explicite lui-même le piège (p. 247). **F avait raison, E avait raison sur l'existence du défaut et tort sur sa cible.** Correction : `BLOQ-14` réécrite, gravité ramenée de A à B, remède = corriger les ch. 1 et 2 et appliquer la remontée n° 6 de `TRANS-06`. **Aucune règle n'est à modifier.**

### `ARB-PR-02` — ✅ **Tranché sur le point contesté** — La clause de taille `i ∈ ℕ∞ ∖ {ω}`
**Position Q (R-03, gravité A) :** la clause interdit les acteurs et flux non bornés, invalide la preuve duale du Th. 5, et repose sur un mésusage de la source Agda. Il faut deux sortes de tailles.
**Position C (F-4a) :** la clause et son argument d'irréflexivité sont « excellents » ; ne pas fusionner grade et indice de taille.
**Analyse :** les deux positions ne portent pas exactement sur le même objet. C valide la **séparation grade / indice de taille** ; Q conteste l'**unicité de la sorte d'indice**. Elles sont compatibles : on peut garder la séparation et scinder l'indice en deux sortes. Le seul point réellement contesté est l'interprétation de la source [25].
**Vérification conduite le 14 septembre 2026 (p. 57) :** le manuscrit écrit — « un assistant de preuve majeur admet une plus grande taille réflexive, et l'on y construit depuis dix ans **un type à la fois inductif et coinductif** dont se tire une preuve du type vide [25] ». **La source incrimine donc le mélange des polarités, et le manuscrit en tire l'exclusion globale de ω.** La lecture de Q est exacte ; la clause est trop large pour ce qu'elle doit interdire.
**Reste à faire :** `BIB-07` conserve son objet — vérifier la source elle-même, et non seulement la phrase que le manuscrit en tire —, puis appliquer `BLOQ-06`. La position de C (ne pas fusionner grade et indice de taille) n'est pas contredite et reste valide : `REFUS-01` est maintenue.

### `ARB-PR-03` — Le traitement des effets à portée
**Position F (CRIT-01, gravité B) :** remplacer le monoïde ℳ par les *Hefty Algebras*, ce qui unifierait effets ordinaires et effets à portée sous la même machinerie de catamorphismes sans hypothèse ad hoc de commutation, et rétablirait la modularité des gestionnaires tiers.
**Position D (6.3) :** « Keep them distinguished. They are not instances of the same abstraction. » Les effets à portée requièrent le monoïde de transformateurs ; l'unification serait une uniformisation abusive.
**Position C (B-3) et G (§11) :** intermédiaire — ℳ est bien une pièce nouvelle, mais la solution est de **ranger** l'exception (clôture faible) et de distinguer `ℰ_alg` / `ℰ_scoped` dans la structure, sans remplacer la machinerie.
**Ce qu'il faut faire :** la position intermédiaire est la moins coûteuse et ne ferme aucune porte. **Recommandation : appliquer `STRUCT-02` + `STRUCT-11` d'abord ; n'instruire `BIB-01` que si le besoin de modularité des gestionnaires tiers devient un objectif déclaré du langage.** Le contre-exemple de F (`H₁` et `H₂` de même signature non interchangeables) est réel et doit dans tous les cas être inscrit au document comme limite connue.

### `ARB-PR-04` — Le statut du rejeu bit-à-bit
**Position Q, G, E, F :** l'énoncé promet plus que ses hypothèses ; il manque au minimum l'injectivité observation/représentation et une quatrième composante à `E_repro`.
**Position D (4.2, Obs. 4) :** « This is correctly distinguished. No level error. » — le document sépare correctement propriété du langage (rejeu logique) et propriété de l'environnement (rejeu binaire).
**Analyse :** D évalue la **distinction conceptuelle**, qui est en effet correcte ; Q, G et E évaluent l'**énoncé du Th. 23 et sa preuve**, qui franchit un pas non justifié. Les deux constats coexistent : la distinction est bonne, sa formalisation ne l'est pas. `PORT-04` reste valide et D ne le contredit pas.

### `ARB-PR-05` — Le cadre d'ensemble du noyau minimal
**Quatre propositions concurrentes, toutes compatibles sur le fond, incompatibles comme organisation de rédaction :**

| Source | Noyau minimal proposé |
|---|---|
| C (passe 7) | Une **discipline** (famille de comonades graduées sur un ordre, avec coercions) + un système de modes + trois variances + une action + deux schémas de commutation + un schéma de restriction + un schéma de progression + une sémantique |
| Q (§5.3) | Un **λ-calcul CBPV** à conteneurs indexés, comonade graduée sur `ℛ = (module 𝕌 × 𝔅) × (ordre 𝕄 × ℒ)`, monade graduée indexée sur `ℰ = ℰ₀ × ℕ∞^ℒ`, indice de niveau courant, **deux sortes de tailles**, relation de raffinement dont le foncteur d'effacement est une traduction vers un π-calcul réflexif local à sortes |
| G (§17) | **Cinq couches de preuve** : algèbre graduée → jugement + sous-typage cohérent → sémantique des points fixes et effets → effacement/traduction/simulation → machine concrète |
| F (§5) | **Fibration bimodale** `p : Judg(𝒞, ℛ, ℰ) → Proc(π-calcul)` + purification du modèle d'effet + découplage strict sémantique/ABI + clôture de la sécurité |

**Ce qu'il faut faire :** ces quatre descriptions se recouvrent largement — toutes placent le germe dans la graduation, toutes font des trois couches des restrictions, toutes réclament un objet d'effacement central. **Choisir une formulation de rédaction et une seule**, puis vérifier que les trois autres s'y lisent comme des lectures. Ne pas empiler les quatre vocabulaires : ce serait exactement le défaut de juxtaposition que le document cherche à éviter.

### `ARB-PR-06` — ⚠️ **Élément versé au dossier** — La gravité du Th. 36
**Position D (5.1) :** défaut **bloquant** — sans préservation graduée par abaissement, la garantie de bout en bout revendiquée par P1 n'est pas établie.
**Position C (D-3), F (CRIT-03), G (A1) :** **dette de preuve correctement isolée**, avec traitement exemplaire par le document lui-même ; le défaut réel est l'affirmation non conditionnée du ch. 3.
**Vérification conduite le 14 septembre 2026 (p. 207) :** le manuscrit écrit « Ce théorème n'est pas démontré », et RMQ 35 précise « Il est énoncé parce que son absence restait invisible tant que la stabilité du chapitre 3 et la préservation de l'annexe passaient pour deux formulations de la même chose ». Le traitement au ch. 6 est donc exemplaire et la position de C, F et G est confirmée sur ce point.
**Ce qu'il faut faire :** la question restante est éditoriale — la revendication de bout en bout fait-elle partie des objectifs déclarés ? Si oui, D a raison et `PREUVE-02` passe en tête ; si la revendication est restreinte au niveau du langage (ce que `TRANS-01` permet d'écrire), `PORT-16` suffit à court terme.

### `ARB-PR-07` — Socle homotopique, ou famille modale et graduée ?
**Origine :** question posée le 15 septembre 2026 ; étude d'opportunité `K7PL_etude_opportunite_HoTT.md`.
**Conclusion de l'étude :** la famille modale et graduée, pour quatre motifs dirimants — l'univalence rend inexprimables les théorèmes 18, 20 et 23 ; le coût du transport n'est pas borné, ce que P3 interdit ; Lean est structurellement anti-univalent ; et aucune variante de HoTT ne fournit le semi-anneau de grades, qui est le cœur du système.
**Ce qu'il faut faire :** écrire la décision et son motif au §1.2, à côté des autres choix de cadre, **parce que la question sera reposée à chaque relecture** et que le manuscrit paie déjà cher le fait de ne pas consigner ses décisions écartées (`TRANS-05`). Deux lignes suffisent.
**Ce qui rouvrirait la question :** l'abandon de la revendication de représentation (E8), seule condition qui dépende de l'auteur. Les cinq autres conditions de révision sont listées au §7 de l'étude.

---

## 14. Acquis à préserver — ne pas « corriger » ce qui fonctionne

> Les six rapports insistent : ce document pratique déjà une bonne part de la discipline qu'une revue formelle demande. **Une correction qui détruirait ces acquis serait une régression.**

### 14.1 Dispositifs méthodologiques à conserver et à étendre
- La **table 1 des engagements avec trois routes** (littérature / démonstration / mesure) : Q écrit ne l'avoir vue nulle part ailleurs. À conserver et à transformer en vue du registre (`TRANS-05`), non à remplacer.
- **RMQ 2** (« un engagement sans route nommée est une anomalie ») : bonne règle, à rendre contraignante.
- Le patron **« S'il tient / S'il tombe »** : excellente analyse d'impact, à conserver — son effet pervers disparaît une fois le sceau de statut posé (`TRANS-01`).
- La **taxinomie du §1.2** (postulat / théorème / engagement / lecture / réserve / obligation / exigence) : exacte, il lui manque seulement d'être projetée sur les 51 énoncés.
- La **table 12** (statut de chaque affirmation d'ergonomie) : qualifiée de modèle par Q.
- Les **contre-exemples écrits par le document lui-même** (nécessité de la condition de clôture, attaque par blanchiment du §E.4.5, cas résistants de la traduction).
- Le **catalogue chiffré du prix d'expressivité** (élimination faible, pas de multiplicités dépendant d'une valeur d'exécution, joint sur-approximant, pas de délégation de session, pas de continuations multiples, pas de topologies circulaires, bornes pire cas en bibliothèque, `fix` conduit jusqu'à la hauteur du type).
- La **table 5 normative** : bonne idée, à étendre (`NOTA-01`), jamais à abandonner.

### 14.2 Factorisations déjà correctes (Q/§4.1)
1. **Th. 5 absorbe Th. 2 et Th. 4**, avec la bonne méthode, la bonne justification de non-gratuité (« un paramètre dont les deux valeurs diffèrent matériellement n'est pas une commodité de présentation ») et la bonne réserve. Modèle de factorisation légitime — *sous réserve de `BLOQ-06`*.
2. **§2.6 : trois schémas + un lemme de capacité**, instanciés par Th. 30, 31, 32, 36, 48, 21, 26, 24, 17. Économie réelle et vérifiable.
3. **§2.4 : la modalité graduée sur une structure ordonnée** comme procédé unique. C compte **huit instances** (usage, monotonie, confidentialité, budget, temps, effacement/phase, présence de champ, capacité de lecture fractionnaire) pour une seule construction. *C'est le noyau théorique le plus fort du document*, et l'argument « la confidentialité n'ajoute pas un axe mais instancie celui que la monotonie a ouvert » est exactement le bon.
4. **Th. 9 : le système de raffinement** dont l'effacement de phase, la non-interférence et l'ordre de précision sont trois lectures — *sous réserve de `STRUCT-08`*.
5. **Th. 38 : `⊠` généralise `+`**, avec l'observation historique forte que les présentations indépendantes des systèmes gradués « travaillaient dans le cas où les deux opérateurs se confondent ». Véritable résultat de positionnement.
6. **Six identifications correctes, chacune évitant un mécanisme** : grade de présence = fragment affine ; conjonction additive = partage de contexte ; copatron = acteur ; histomorphisme = catamorphisme sur foncteur enrichi ; itération induite = annotation d'effet d'un flux ; sessions = implication linéaire.
7. **L'inexpressibilité comme mode de garantie unique**, avec ses quatre emplois et son coût nommé (« Une violation inexprimable ne se diagnostique pas »). Vraie contribution de conception.

### 14.3 Passages d'une qualité remarquable, à ne pas toucher
- **Th. 20** (C) : « Domaine exact, échec hors domaine nommé, sources normatives citées, et déclaration de ce que les sources *ne* donnent pas. Modèle de ce qu'un théorème d'ingénierie doit être. » La critique porte sur ce que le ch. 6 en fait, pas sur le théorème.
- **§E.4.6** (clôture des quatre cas résistants de la traduction) : une dette portée depuis le ch. 4 y est soldée, et le document découvre en chemin que deux des quatre cas partagent un appareil.
- **§2.2** (chaîne à trois maillons, abstention sur l'exponentielle libre et les biproduits, RMQ 11) : distinction entre ce qui est assumé, posé, et payé par un choix de définition — « Assumer un théorème et poser un axiome ne sont pas le même acte ».
- **RMQ 23** (les deux graphes) : meilleure remarque du ch. 3, et exactement le bon diagnostic.
- **RMQ 24-25** (les trois préservations) : « travail remarquable et rare » (Q).
- **RMQ 27** (disjonction des contextes, contre-exemple de la valeur cartésienne capturant une capacité linéaire).
- **RMQ 29** (atomicité locale contre localité au sens de Herlihy–Wing) : le piège est évité.
- **RMQ 30** (les deux clauses du Th. 26) : le document sait scinder un énoncé ; il suffit de généraliser le geste.
- **§E.5.6** (les quatre incertitudes) et **§E.6** (traçabilité) : bonne intention, à outiller.
- **Le passage sur l'ergonomie** (ch. 5) : « c'est le passage qui donne le plus de crédit au reste du document : un auteur qui rapporte la mesure qui l'accable est un auteur dont on peut croire les autres affirmations » (C).
- **L'exclusion des continuations multiples** et son motif : le document donne la *vraie* raison (la règle de cadre ne survit pas à un bloc entré une fois et quitté deux fois) plutôt que la raison attendue (le coût de copier des segments de pile), que la littérature écarte explicitement.
- **Le choix d'un seul objet sémantique** (la relation `→`) plutôt qu'une machine à environnements, argumenté par le coût déjà payé du lemme de substitution.
- **Le refus du semi-anneau tropical** au motif d'axiomatisation infinie.
- **La justification du choix des sommes et conjonctions indexées** par le coût de preuve mesuré (« l'ajout de quelques règles de réduction pour les sommes disjointes a doublé la preuve de correction, le seul lemme de confluence recevant treize cas de plus »).
- **L'identification de la perte à la traduction** sous une discipline d'échange restreinte : résultat négatif important, correctement anticipé.
- **La clôture des trois voies de recours** du §6.2.2 (« ce n'est pas une limite d'imagination : c'est la clôture de ce dont la procédure dispose »).
- **L'équité mémoire** relevée spontanément au §4.5 comme exigence de l'invariant de vivacité : « point que la plupart des documents de ce genre omettent entièrement » (C).

### 14.4 Objections instruites et écartées — aucune action
> Consignées ici pour que le travail d'instruction ne soit pas refait.

| Objection | Verdict | Source |
|---|---|---|
| « La factorisation des trois couches n'est-elle qu'une analogie ? » | **Écartée.** Les règles sont bien des spécialisations d'un jugement unique ; factorisation réelle | D/Obj. 1 |
| « La catégorie 𝒞 existe-t-elle avec les opérations définies ? » | **Écartée** au plan de l'existence : la catégorie est standard dans la littérature, l'extension graduée aussi. (Ne résout pas `BLOQ-08`, qui porte sur l'absence de **fonction d'interprétation**, non sur l'existence de 𝒞) | D/Obj. 2 |
| « Les preuves de terminaison ne valent-elles que dans le cas discret ? » | **Écartée.** Le document se limite explicitement aux types discrets et le déclare | D/Obj. 3 |
| « Le semi-anneau résiduté est-il une hypothèse absente ? » | **Écartée.** L'exigence est explicitement spécifiée au §2.2 | D/Obj. 4 |
| « Le Th. 19 préserve-t-il le comportement ou seulement le typage ? » | **Distinction correctement faite** par le document ; reste la question de la preuve du morphisme (`PORT-16`) | D/Obj. 5 |
| « Le zéro-copie est-il réel ? » | **Limitation correctement énoncée** dans le théorème ; le défaut est dans son usage au ch. 6 (`PORT-01`) | D/Obj. 6 |
| « La traduction vers un métalangage est-elle une économie réelle de preuve ? » | **Écartée.** Le §E.4.6 solde les quatre cas et le décompte est favorable. *Réserve : l'économie dépend de `BLOQ-07` — sans simulation, on a économisé des preuves sur un objet dont on n'a pas montré qu'il est le bon* | C (passe 4) |
| « La sédimentation triadique survit-elle à deux inversions sur trois axes ? » | **Partiellement fondée, réponse suffisante** : le §1.2 requalifie la sédimentation en *lecture* et donne la mesure. Reste à mettre à jour la réserve (`PORT-15`) | C (passe 4) |
| « L'acyclicité est-elle une conséquence ou un choix ? » | **Fondée, et le document la formule lui-même** au §4.6 à propos du foncteur de l'orchestrateur (« Cet argument *remonte* de la cible vers la source »). Remarque résiduelle : l'acyclicité du §4.5 n'a pas reçu le même traitement alors que l'argument a la même direction | C (passe 4) |
| « Le budget est-il une composante de grade au même titre que les trois autres ? » | **Fondée, réponse adéquate, conséquence non tirée** : le §2.2 pose l'exigence de résiduation et écarte le tropical correctement, mais le §1.4 dit « point par point » alors que les quatre composantes ont quatre opérations de composition distinctes (multiplication, minimum, joint, `⊖`). **Correction : le §1.4 doit renvoyer à la table 20 du §E.3, qui donne déjà la bonne présentation** | C (passe 4) |
| Fusion Γ / Δ en un contexte gradué unique | **Défendable** : motivation catégorique réelle par `Δ_ω` | G/§16 |
| Dualité μ/ν comme métaphore | **Écartée** : le manuscrit distingue soigneusement point fixe fonctoriel et point fixe dans un ordre complet | G/§16 |
| Factorisation confidentialité / monotonie par modalité graduée | **Une des plus solides du texte** | G/§16 |
| Honnêteté sur les limites (abaissement MLIR, frontière FFI, environnement reproductible, modèle mémoire, lissage amorti contre pire cas) | **Réduit significativement le risque de mauvaise foi scientifique** | G/§16 |

### 14.5 Points d'incohérence instruits et clos par le document (D/9)
- `!` contre `□` pour la comonade graduée : **corrigé** dans la version courante (§1.5), avec la bonne raison (« l'un ou l'autre valant mieux que les deux »).
- Quatre composantes du grade contre « une composante nouvelle n'est pas une entorse » : **cohérent** — quatre est l'état actuel, non une limite, et la condition d'ajout est spécifiée (sous réserve de `STRUCT-01` et `TRANS-02`, qui la rendent *suffisante*).
- `ℕ∞` nu (ch. 1) contre `ℕ^ℒ_∞` (annexe E.1) : **raffinement, non contradiction** — le corps simplifie, l'annexe donne le détail formel. *Mais la remontée reste recommandée (`TRANS-06`, remontée 5).*
- CBPV contre λ-calcul : **présentation cohérente** de bout en bout.

---

## 15. Index par théorème

| Th. | Fiches | Nature du travail |
|---|---|---|
| 1 | `BLOQ-03`, `FACT-01`, `NOTA-01` (N-02) | énoncé faux en ω ; à poser comme schéma |
| 2 | `NOTA-06a`, `NOTA-06b`, `FACT-03`, `PREUVE-14` | variable libre ; instance déclarée avant son schéma |
| 3 | `PORT-14c`, `PREUVE-16`, `REECR-21` | transposition graduée ouverte ; réserve à remonter au ch. 1 |
| 4 | `BLOQ-06`, `FACT-03`, `PREUVE-14` | la clause de taille vide son domaine |
| 5 | `BLOQ-06`, `PREUVE-14`, `FACT-03`, `REFUS-05` | preuve duale invalide ; schéma à deux instances, deux sortes |
| 6 | `PREUVE-08`, `FACT-18` | préservation par troncature affirmée sans lemme |
| 7 | `BLOQ-11`, `PREUVE-04`, `FACT-07`, `NOTA-06c` | esquisse circulaire ; clause de clôture ; renvoi faux |
| 8 | `FACT-03`, `STRUCT-17`, `NOTA-06c` | à intégrer au schéma de bien-fondation |
| 9 | `STRUCT-08`, `FACT-02`, `BLOQ-01` | conditionnel au Th. 27 ; instance de `ρ_p` |
| 10 | `PREUVE-03`, `PREUVE-11`, `FACT-07`, `REECR-09` | trois points non résolus ; extension déclarée sans induction |
| 11 | `FACT-01`, `FACT-13`, `PORT-08` | schéma existant, à dédoubler (termes / grades) |
| 12 | `FACT-06` | à absorber dans l'effacement unifié |
| 13 | `BLOQ-13` | tri topologique, à relier au graphe défini |
| 14 | `BLOQ-09`, `PREUVE-12` | valide dans sa portée ; ne couvre pas l'unicité d'introduction |
| 15 | `BLOQ-04` | énoncé sur intervalles, preuve sur singletons |
| 16 | `PORT-07`, `FACT-09`, `TRANS-01` | énumération sur base non close ; scinder langage / outil |
| 17 | `BLOQ-13`, `PREUVE-13`, `STRUCT-13`, `TRANS-03` | hypothèse sans référent ; équité ; abandon non typé |
| 18 | `BLOQ-12`, `PORT-04`, `IMPL-07`, `TRANS-04` | conclusion fausse ; agrandit `E_repro` sans le dire |
| 19 | `PORT-14b`, `PORT-16`, `REFUS-06` | scinder 19-év / 19-ab |
| 20 | `PORT-01`, `IMPL-06`, `TRANS-01`, `REECR-15` | exemplaire ; paramétrer par la version, requalifier |
| 21 | `BLOQ-09`, `PREUVE-12`, `PREUVE-01`, `FACT-17` | mauvais mécanisme invoqué ; deux lemmes manquants |
| 22 | `STRUCT-09`, `STRUCT-15`, `PORT-04`, `FACT-15` | pureté mal renvoyée ; complétude du journal à nommer |
| 23 | `PORT-04`, `FACT-16`, `REECR-12` | pas `≈_obs ⟹ =_bit` non valide |
| 24 | `BLOQ-13`, `PREUVE-13`, `STRUCT-13` | rigoureux sur l'initialisation ; hypothèse non définie |
| 25 | `STRUCT-04`, `IMPL-04`, `FACT-11`, `PORT-05` | énoncé mixte sur trois niveaux ; SPSC contestable |
| 26 | `PORT-05`, `IMPL-05`, `PORT-02`, `REECR-11` | scinder théorème / exigence |
| 27 | `STRUCT-03`, `STRUCT-08`, `BLOQ-01`, `REECR-08`, `FACT-06` | **trois statuts incompatibles sur sept mentions** |
| 28 | `BLOQ-07`, `PREUVE-07`, `REECR-03` | pivot du ch. 6 ; maillon de simulation manquant |
| 29 | `PORT-08`, `STRUCT-06`, `REECR-16` | vraie preuve autonome ; faux statut de corollaire |
| 30 | `STRUCT-12`, `PORT-14a`, `FACT-13` | AST non gradué ; resucrage à exiger |
| 31 | `PORT-08`, `STRUCT-12`, `FACT-06`, `TRANS-01` | quantifie sur `Sens`, non défini → DÉFINITION |
| 32 | `NOTA-05`, `FACT-01`, `FACT-04`, `FACT-06` | `ε_m` ambigu ; produit non ordonné |
| 33 | `STRUCT-05`, `TRANS-01` | argument de terminaison de la boucle 5/6, à intégrer |
| 34 | `PORT-06`, `PORT-13`, `TRANS-01` | ré-affirme une direction retirée → DÉFINITION |
| 35 | `BLOQ-10`, `PREUVE-15`, `TRANS-01` | invoque une hypothèse réfutée deux fois |
| 36 | `PORT-16`, `PREUVE-02`, `TRANS-04`, `REFUS-06` | non démontré ; affirmé acquis au ch. 3 |
| 37 | `BLOQ-05`, `TRANS-06` | bonne correction (famille temporelle), à remonter |
| 38 | `BLOQ-03`, `FACT-01` | dépend de la loi de cohérence |
| 39 | `STRUCT-07`, `PREUVE-10`, `BLOQ-04` | joints ≠ cohérence des coercions |
| 40 | `PREUVE-09`, `STRUCT-02`, `FACT-10` | deux structures pour ℰ₀ ; pétition de principe pour n = ω |
| 41 | `BLOQ-03`, `FACT-13`, `STRUCT-13`, `PREUVE-06` | dépend du Th. 1 ; condition de bord d'échange |
| 42 | `FACT-13`, `FACT-19`, `STRUCT-13` | ordre de retrait des liaisons à nommer |
| 43 | `STRUCT-05`, `PORT-14b`, `REFUS-06`, `BLOQ-05` | analyse en potentiel correcte ; `δ_ℓ` non produit |
| 44 | `BLOQ-01` | raisonne « dans le contexte vide », règle absente |
| 45 | `PREUVE-01`, `BLOQ-03`, `BLOQ-01`, `NOTA-01` (N-03) | **dette la plus lourde ; absente de la table 1** |
| 46 | `FACT-02`, `FACT-15`, `TRANS-05`, `BLOQ-05` | **démontré, et la dette qu'il paie est encore déclarée ouverte** |
| 47 | `BLOQ-05`, `FACT-07`, `PREUVE-03`, `STRUCT-05` | repose sur une fonction de niveau inexistante |
| 48 | `FACT-01`, `FACT-13`, `FACT-10`, `BLOQ-01` | commutation, à absorber par le schéma |
| 49 | `FACT-01`, `FACT-04`, `BLOQ-03` | ré-invocation h fois : instance, non exception |
| 50 | — | démontré, aucune action |
| 51 | `BLOQ-05`, `BLOQ-01`, `TRANS-03` | confinement sans support de règles |

---

## 16. Index par chapitre

| Lieu | Fiches |
|---|---|
| **§1.1** (maturités, R1 « Arrêté ») | `PORT-01`, `STRUCT-23`, `REECR-22`, `TRANS-05` |
| **§1.2** (taxinomie, mots à sens fixe) | `TRANS-01`, `TRANS-05`, `TRANS-08`, `STRUCT-15`, `PORT-05` |
| **§1.3** (P1–P4, régions, rejeu) | `BLOQ-08`, `PORT-02`, `PORT-03`, `PORT-04`, `PORT-09`, `PORT-10`, `PREUVE-01`, `REECR-01`, `REECR-06` |
| **§1.4** (jugement germinal, clôture, table 2) | `BLOQ-03`, `BLOQ-04`, `BLOQ-05`, `STRUCT-01`, `STRUCT-02`, `STRUCT-14`, `STRUCT-20`, `STRUCT-21`, `PORT-06`, `PORT-13`, `REECR-05` |
| **§1.5** (table 5 normative) | `NOTA-01`, `BLOQ-02`, `BLOQ-04`, `BLOQ-05a` |
| **table 1** (engagements) | `BLOQ-07`, `PORT-16`, `PREUVE-01`, `TRANS-05` |
| **ch. 2 §2.1-2.2** (SMCC, comonade, ℛ, `⊖`) | `BLOQ-03`, `BLOQ-04`, `BLOQ-08`, `STRUCT-18`, `TRANS-02` |
| **ch. 2 §2.3** (polarité, histomorphisme, troncature) | `BLOQ-06`, `STRUCT-10`, `PREUVE-08`, `PREUVE-14`, `FACT-03`, `NOTA-06a/b` |
| **ch. 2 §2.4** (modalité graduée, déclassification, monotonie) | `BLOQ-11`, `STRUCT-17`, `PREUVE-04`, `PREUVE-11`, `NOTA-06c`, `FACT-14` |
| **ch. 2 §2.5** (système de raffinement) | `STRUCT-08`, `FACT-02`, `FACT-06` |
| **ch. 2 §2.6** (schémas de métathéorie) | `FACT-01`, `FACT-02`, `FACT-13` |
| **ch. 3 §3.1** (modes, table 6, capacités, zone) | `BLOQ-04`, `BLOQ-09`, `STRUCT-13`, `STRUCT-22`, `PORT-07`, `FACT-17` |
| **ch. 3 §3.2** (sessions, Th. 17, 18, 19) | `BLOQ-12`, `BLOQ-13`, `STRUCT-04`, `PORT-04`, `PORT-14b`, `NOTA-06d` |
| **ch. 3 §3.3** (bidirectionnel, frontière de confiance, effets à portée) | `BLOQ-10`, `STRUCT-11`, `PORT-07`, `PREUVE-15` |
| **ch. 4 §4.2** (R-expressions, flux) | `BLOQ-06`, `PORT-12`, `FACT-18`, `FACT-20` |
| **ch. 4 §4.3** (arènes, Th. 20, partition) | `BLOQ-09`, `PORT-01`, `IMPL-06`, `PREUVE-12` |
| **ch. 4 §4.4** (Th. 21, table 7) | `BLOQ-09`, `PORT-09`, `PREUVE-01` |
| **ch. 4 §4.5** (acteurs, FFI, rejeu, graphe, anneaux) | `BLOQ-13`, `STRUCT-04`, `STRUCT-09`, `STRUCT-15`, `PORT-02`, `PORT-04`, `PORT-05`, `IMPL-04`, `IMPL-05`, `PREUVE-13` |
| **ch. 4 §4.6** (métalangage, traduction) | `BLOQ-07`, `STRUCT-13`, `PREUVE-07`, `FACT-10`, `REECR-19` |
| **ch. 5 §5.1** (délimiteurs, table 8) | `NOTA-04`, `FACT-09` |
| **ch. 5 §5.2-5.4** (macros, hygiène, EXPAND) | `STRUCT-06`, `STRUCT-12`, `NOTA-05`, `PORT-08`, `PORT-14a` |
| **ch. 5 §5.5** (exemple des trois couches) | `BLOQ-01`, `BLOQ-13` |
| **ch. 6 §6.1** (pipeline, phases, Th. 36) | `STRUCT-05`, `STRUCT-06`, `PORT-01`, `PORT-16`, `PREUVE-02`, `IMPL-01`, `TRANS-04` |
| **ch. 6 §6.2** (compilation bornée, Th. 33-35) | `BLOQ-10`, `PORT-06`, `PREUVE-15` |
| **ch. 6 §6.3** (test différentiel, oracle) | `BLOQ-07`, `IMPL-03`, `IMPL-07` |
| **ch. 7** (études de cas) | `BLOQ-01`, `BLOQ-06`, `STRUCT-15`, `TRANS-03` |
| **annexe A** (codes d'erreur) | `PORT-07`, `FACT-09`, `BLOQ-13` |
| **annexe D** (SUGOI) | `PORT-11`, `IMPL-01` |
| **annexe E.1-E.2** (grammaire, constructeurs) | `BLOQ-01`, `BLOQ-02`, `BLOQ-04`, `NOTA-03` |
| **annexe E.3** (règles) | `BLOQ-01`, `BLOQ-02`, `BLOQ-05`, `NOTA-02`, `NOTA-06e/f`, `STRUCT-07` |
| **annexe E.3.2** (ℳ, π†, π_ℓ, SC) | `STRUCT-02`, `STRUCT-11`, `PORT-10`, `PREUVE-09`, `REFUS-04`, `FACT-02` |
| **annexe E.4** (sémantique, préservation, Th. 43-45) | `BLOQ-05`, `BLOQ-07`, `STRUCT-05`, `PREUVE-01`, `PREUVE-07` |
| **annexe E.4.3-E.4.6** (relation logique, traduction) | `PREUVE-03`, `PREUVE-04`, `PREUVE-11`, `FACT-04`, `FACT-07` |
| **annexe E.5** (sortes, confinement) | `BLOQ-05`, `PREUVE-03`, `REECR-09` |
| **annexe E.5.6** (quatre incertitudes) | `BLOQ-05`, `TRANS-06` |
| **annexe E.6** (traçabilité) | `STRUCT-03`, `TRANS-05`, `STRUCT-23` |
| **annexe E.7** (glyphes) | `BLOQ-02`, `NOTA-01` |

---

## 17. Ordre d'exécution et graphe de dépendances

### 17.1 Graphe de dépendances des corrections

```
                    ┌──────────────────────────────────────────┐
   VAGUE 0          │ TRANS-01  sceau statut × niveau          │  (typographique,
   Aucune           │ TRANS-05  registre des obligations       │   aucune dépendance,
   dépendance       │ NOTA-01   table 5 étendue + colonne niv. │   débloque la lecture
                    │ NOTA-03   comptes produits par l'outil   │   de tout le reste)
                    │ BLOQ-02   glyphe manquant + WHEN         │
                    └────────────────────┬─────────────────────┘
                                         │
                    ┌────────────────────▼─────────────────────┐
   VAGUE 1          │ TRANS-02  module × ordre  ──┬─► BLOQ-03  │
   Fondations       │                             ├─► BLOQ-04  │
   algébriques      │                             ├─► STRUCT-14│
                    │                             └─► BLOQ-05  │
                    │ BLOQ-06   deux sortes de tailles         │
                    └────────────────────┬─────────────────────┘
                                         │
                    ┌────────────────────▼─────────────────────┐
   VAGUE 2          │ TRANS-03  frontière noyau / cible        │
   Décision de      │   └─► BLOQ-01 (voie 1 ou 2)              │
   périmètre        │         └─► requalification Th. 17, 21,  │
                    │             22, 24, 25, 26, 28, 45, 51   │
                    └────────────────────┬─────────────────────┘
                                         │
          ┌──────────────────────────────┼──────────────────────────────┐
          ▼                              ▼                              ▼
   ┌─────────────┐              ┌─────────────────┐            ┌────────────────┐
   │ TRANS-06    │              │ TRANS-07        │            │ TRANS-04       │
   │ remontées   │              │ sémantique      │            │ ordre de       │
   │ (6 items)   │              │ primitive       │            │ préservation   │
   │  └ BLOQ-11  │              │  ├ BLOQ-08      │            │  ├ STRUCT-05   │
   │  └ BLOQ-14  │              │  └ BLOQ-07      │            │  ├ PORT-04     │
   │  └ PORT-15  │              │     └ PREUVE-07 │            │  ├ PORT-16     │
   └─────────────┘              └─────────────────┘            │  └ IMPL-06     │
          │                              │                     └────────────────┘
          └──────────────┬───────────────┴──────────────┬───────────────┘
                         ▼                              ▼
              ┌──────────────────────┐      ┌────────────────────────┐
   VAGUE 3    │ Lot PREUVE           │      │ Lot FACT               │
   Preuves    │ PREUVE-01 (Th. 45)   │      │ FACT-01 transport      │
   et         │ PREUVE-02 (Th. 36)   │      │ FACT-02 restriction    │
   montées    │ PREUVE-03 (sessions) │      │ FACT-03 bien-fondation │
   de niveau  │ PREUVE-10 (coercions)│      │ FACT-04 ré-invocation  │
              │ …                    │      │ FACT-05 / 06 / 07      │
              └──────────────────────┘      └────────────────────────┘
                         │                              │
                         └──────────────┬───────────────┘
                                        ▼
                            ┌───────────────────────┐
   VAGUE 4                  │ Lot REECR (27 items)  │  (dernière passe :
   Réécriture               │ TRANS-08 convention   │   les énoncés ne se
                            └───────────────────────┘   stabilisent qu'ici)
```

### 17.2 Séquencement recommandé

**Vague 0 — typographique et mécanique (aucune dépendance, effet immédiat sur l'auditabilité).**
`TRANS-01` · `TRANS-05` · `NOTA-01` · `NOTA-02` · `NOTA-03` · `NOTA-04` · `NOTA-06` · `NOTA-07` · `NOTA-08` · `BLOQ-02` · `IMPL-08` · `PORT-03` · `REECR-06`.
*Justification :* aucune ne demande de décision d'architecture, et `TRANS-01` + `TRANS-05` conditionnent la lisibilité de tout le reste — **on ne peut pas corriger ce dont on ne sait pas le statut**. `BLOQ-02` est en vague 0 parce que c'est une ligne de code source dont dépend la correction d'une règle.

**Vague 1 — fondations algébriques.**
`TRANS-02` puis, dans l'ordre, `BLOQ-03` · `BLOQ-04` · `BLOQ-05` · `STRUCT-14` · `BLOQ-06` (sous réserve de `ARB-PR-02` et `BIB-07`).
*Justification :* `TRANS-02` répare quatre fiches d'un coup et rend `BLOQ-05` énonçable. Rien de ce qui suit n'a de sens si `ℛ` a deux définitions.

**Vague 2 — décision de périmètre.**
`ARB-PR-05` (choix du cadre de rédaction) puis `TRANS-03` → `BLOQ-01` → requalification en chaîne.
*Justification :* c'est la seule décision qui change la **taille** du travail restant (une page contre quarante). Tout chiffrage de la dette avant cette décision est provisoire.

**Vague 3 — remontées, sémantique, préservation.**
`TRANS-06` (six remontées, dont `BLOQ-11` et `BLOQ-14`, désormais instruites) · `TRANS-07` → `BLOQ-08` → `BLOQ-07` → `PREUVE-07` · `TRANS-04` → `STRUCT-05`, `PORT-04`, `PORT-16`, `IMPL-06`.
*Justification :* `PREUVE-07` est, de l'avis de C, « l'ajout le plus rentable de tout le document » — une induction sur une dérivation déjà parcourue, qui solde trois dettes.

**Vague 4 — le reste des dettes de preuve et les montées de niveau.**
Lot `PREUVE` (en commençant par `PREUVE-01` restreint à la composante d'usage et à la couche 1) · lot `FACT` (en commençant par `FACT-01` et `FACT-02`) · lot `STRUCT` restant · lot `IMPL`.

**Vague 5 — réécriture finale.**
`TRANS-08` puis le lot `REECR` intégralement, plus `REFUS-01` à `REFUS-07` écrits dans le texte avec leur motif.
*Justification :* les énoncés ne se stabilisent qu'une fois les objets stabilisés. Réécrire plus tôt obligerait à réécrire deux fois.

### 17.3 Les cinq corrections au meilleur rapport bénéfice/coût

Synthèse des priorisations de Q (§5.1 question 6) et de C (conclusion §6), qui convergent :

| Rang | Fiche | Coût | Rendement |
|---|---|---|---|
| 1 | `TRANS-01` sceau à deux axes | typographique | supprime 11 faux théorèmes, **révèle 18 résultats acquis que le document ignore posséder** |
| 2 | `TRANS-02` module × ordre | une page | répare deux bloquants, rend `BLOQ-05` et `STRUCT-14` énonçables, mécanise la condition de clôture |
| 3 | `TRANS-05` registre des obligations | deux pages | supprime sept contradictions de statut et quatre comptes incompatibles ; document auditable en une heure |
| 4 | `BLOQ-01` voie 1 (frontière noyau/cible) | une page | requalifie neuf théorèmes, réduit la dette à un noyau mécanisable |
| 5 | `PREUVE-07` lemme de simulation | une induction déjà parcourue | solde la dette de fidélité, justifie l'oracle, couvre la préservation du comportement par les optimisations |

À quoi C ajoute **une correction qui ne réduit pas la complexité et qui domine néanmoins tout : `PREUVE-01` (Th. 45)** — à conduire restreinte à la composante d'usage et à la couche 1, ce qui la divise par quatre et lui donne une chance d'aboutir.

**Estimation agrégée :** moins de dix pages ajoutées pour passer d'un état où 51 énoncés sont des conditionnelles non typées à un état où 18 résultats sont démontrés, 12 sous hypothèses nommées, 9 situés dans la littérature, 11 déclarés exigences de représentation, 5 conjectures avec analyse d'impact. **Gain net de rigueur *et* de taille conceptuelle.**

### 17.4 Le coût réel, nommé une fois

Trois rapports convergent sur ce que la mise en cohérence coûtera, et il faut l'écrire d'avance plutôt que de le découvrir :
- **Q :** abandonner « la revendication que la couche 2 est, dans le langage source, un calcul de processus concurrent » — vraie dans la cible, plausible dans l'abaissement, non établie dans le noyau.
- **C :** reconnaître que P1 est un choix de vocabulaire et non un modèle, et que le vrai foncteur du document est `⟦·⟧` vers le métalangage.
- **G :** accepter que la mécanisabilité n'est pas encore une propriété acquise, et que « les lacunes que l'on pourrait laisser comme détails de présentation deviennent structurelles » précisément parce que le manuscrit vise la mécanisation.

Aucun des six rapports ne juge ces abandons fatals. C écrit des deux défauts bloquants qu'il retient : « Aucun des deux n'est fatal. » Q écrit des six siens : « Aucun n'est fatal au projet. »

---

## 18. Couverture — traçabilité de chaque fiche source

> Condition de succès de ce document : **chaque point de chaque rapport est rattaché à une fiche, à un acquis, ou à un arbitrage.** Les tables ci-dessous permettent la vérification item par item. `§14` renvoie aux acquis à préserver et aux objections closes ; `contexte` signale une section de reconstruction dont le contenu informe le plan sans appeler d'action propre.

### 18.1 `K7PL_PR_02_QWEN.md` (31 critiques, 12 collisions, 5 causes racines)

| Item source | Fiche(s) |
|---|---|
| §0 note de méthode, légende, échelle | conventions du §0 |
| §1.1 question scientifique, quatre portes fermées, prix d'expressivité | contexte · `§14.1` |
| §1.2 germe (adjonction valeurs/calculs), tableau des 14 revendications | contexte · `ARB-PR-05` · `§14.2` |
| §1.3 neuf niveaux, erreurs de passage | `TRANS-01` (axe niveau) · `NOTA-01` (colonne niveau) |
| R-01 noyau séquentiel | `BLOQ-01`, `TRANS-03` |
| R-02 Th. 1 faux en ω, deux `⊖` | `BLOQ-03` |
| R-03 clause de taille | `BLOQ-06`, `REFUS-05`, `ARB-PR-02` |
| R-04 ℛ double, action scalaire | `BLOQ-04`, `TRANS-02` |
| R-05 niveau d'un calcul | `BLOQ-05` |
| R-06 environnement unique, statuts du Th. 27 | `STRUCT-03`, `TRANS-01`, `TRANS-05`, `NOTA-07` |
| R-07 asynchrone / synchrone / SPSC | `STRUCT-04`, `IMPL-04`, `FACT-11`, `BIB-04` |
| R-08 trace τ contre optimisation | `STRUCT-05`, `TRANS-04` |
| R-09 phase 0, élaboration, Th. 35 | `STRUCT-06`, `BLOQ-10`, `PREUVE-15` |
| R-10 Th. 26 | `PORT-05`, `IMPL-05`, `REECR-11` |
| R-11 Th. 23, `E_repro` | `PORT-04`, `FACT-16`, `REECR-12` |
| R-12 Th. 18 | `BLOQ-12`, `IMPL-07`, `REECR-13` |
| R-13 Th. 34 | `PORT-06`, `REECR-10` |
| R-14 Th. 16 | `PORT-07`, `REECR-14` |
| R-15 Th. 21 | `BLOQ-09`, `PREUVE-12`, `FACT-17`, `BIB-11` |
| R-16 Th. 20 | `PORT-01`, `IMPL-06`, `REECR-15`, `BIB-09` |
| R-17 graphe de câblage | `BLOQ-13`, `PREUVE-13`, `BIB-12` |
| R-18 Th. 31, `Sens` | `PORT-08`, `FACT-06`, `REECR-16` |
| R-19 Th. 7 et Th. 10 | `PREUVE-04`, `PREUVE-03`, `PREUVE-11`, `BLOQ-11`, `REECR-09` |
| R-20 Th. 6 troncature | `PREUVE-08`, `FACT-18` |
| R-21 Th. 40 | `PREUVE-09`, `BIB-16` |
| R-22 collisions de symboles (N-01 à N-12) | `NOTA-01` |
| R-23 `ε_m`, `∏_i` | `NOTA-05`, `FACT-19` |
| R-24 table 8 `Δ = ∅` | `NOTA-04`, `REECR-27` |
| R-25 « gestionnaire » | `STRUCT-15`, `STRUCT-09`, `NOTA-08` |
| R-26 six défauts formels (a–f) | `NOTA-06` |
| R-27 R-expressions | `PORT-12`, `FACT-20`, `REECR-26` |
| R-28 `𝒢_pile`, `𝒢_budget` | `STRUCT-14`, `PORT-09` |
| R-29 discipline d'échange | `STRUCT-13` |
| R-30 trois réserves (a, b, c) | `PORT-14`, `STRUCT-12`, `PREUVE-16`, `BIB-13`, `BIB-14` |
| R-31 modalité duale de ◇ | `BLOQ-02`, `FACT-23`, `IMPL-08` |
| RT-1 à RT-5 | `TRANS-01` à `TRANS-05` |
| §4.1 sept acquis | `§14.2` |
| §4.2 (i) (ii) (iii) aspirateurs | `FACT-01`, `FACT-02`, `FACT-04` |
| §4.3 deux (+1) refus | `REFUS-04`, `REFUS-05`, `REFUS-06` |
| §5.1 six questions, §5.2 évaluation | `§17.3`, `§17.4` |
| §5.3 noyau minimal | `ARB-PR-05` |

### 18.2 `K7PL_PR_02_CLAUDE.docx`

| Item source | Fiche(s) |
|---|---|
| Avertissement de portée du reviewer | contexte |
| §1.1 question réelle (invariant d'économie théorique) | contexte |
| §1.2 germe : huit instances de la modalité graduée ; la projection comme second germe | `§14.2`, `FACT-02` |
| §1.3 sept niveaux, deux confusions de paires | `BLOQ-07`, `BLOQ-08` |
| A-1 deux sémantiques sans accord | `BLOQ-07`, `PREUVE-07`, `REECR-03` |
| A-2 𝒞 n'interprète rien | `BLOQ-08`, `REECR-01` |
| B-1 inversion d'antériorité | `STRUCT-01`, `BIB-10` |
| B-2 deux ordres notés ℓ | `BLOQ-05` |
| B-3 ℳ hors strates | `STRUCT-02`, `REECR-05` |
| C-1 zéro-copie au ch. 6 | `PORT-01`, `REECR-04` |
| C-2 « entièrement » | `PORT-02`, `REECR-02` |
| C-3 trois régions et non six | `PORT-03`, `REECR-06` |
| D-1 Th. 45 | `PREUVE-01`, `TRANS-05` |
| D-2 factorisation par l'annotation | `PORT-10`, `REECR-07` |
| D-3 Th. 36 | `PORT-16`, `PREUVE-02` |
| D-4 solveur sans certificat | `IMPL-01` |
| E-1 Γ | `NOTA-01` |
| E-2 tick | `NOTA-02` |
| E-3 comptes 39/35/34 | `NOTA-03` |
| F-1 commutation graduée | `FACT-01` |
| F-2 projection `ρ_p` | `FACT-02` |
| F-3 bien-fondation | `FACT-03` |
| F-4 (a) (b) (c) ne pas fusionner | `REFUS-01`, `REFUS-02`, `REFUS-03` |
| Passe 4 — six objections (sédimentation, zéro-copie, unikernel, traduction, acyclicité, ergonomie, budget) | `§14.4`, `PORT-15`, `PORT-02`, `BIB-18` |
| Passe 5 — quatre emprunts déclarés, un non déclaré (Disruptor), un mieux que dit (équité mémoire) | `§11` (note finale), `BIB-15`, `§14.3` |
| Cause α remontée | `TRANS-06` |
| Cause β une seule interprétation | `TRANS-07` |
| Cause γ auto-critique sans réécriture | `TRANS-08` |
| Passe 7 — classement, table 1 : trois engagements manquants | `TRANS-05` |
| Passe 7 — noyau minimal en huit points | `ARB-PR-05` |
| Conclusion 1-6 (architecture, noyau fort, abstractions manquantes, bloquants, affirmations à affaiblir, cinq corrections rentables) | `§17.3`, lot `REECR`, `§14` |
| Évaluation par dimension et remarque finale au relecteur suivant | `§17.4` |

### 18.3 `K7PL_PR_02_GPT.md`

| Item source | Fiche(s) |
|---|---|
| §1.1 quatre noyaux (jugement, produit de structures graduées, polarité, effacement) | contexte, `ARB-PR-05` |
| A1 fermeture épistémique | `STRUCT-03`, `TRANS-01` |
| B1 Th. 39 cohérence des coercions | `STRUCT-07`, `PREUVE-10`, `FACT-05`, `BIB-05` |
| B2 Th. 9 conditionnel | `STRUCT-08` |
| B3 SMCC ≠ mémoire disjointe | `BLOQ-08` |
| B4 isolement à frontière FFI | `PORT-02`, `IMPL-05` |
| C1 rejeu bit-à-bit avant son hypothèse | `PORT-04` |
| B5 complétude du journal | `STRUCT-09` |
| B6 DAG ≠ vivacité ; `G_static` / `W_run` | `BLOQ-13`, `REFUS-03` |
| C2 hash sémantique | `PORT-11`, `REECR-25` |
| B7 Th. 5 schéma à deux instanciations | `PREUVE-14` |
| B8 histomorphisme | `STRUCT-10`, `REFUS-02` |
| C3 amortissement contre P3 | `PORT-09` |
| §10 quatre régimes, trois exposés | `STRUCT-16` |
| §11 effets à portée | `STRUCT-11` |
| §12 Th. 30 / Th. 31 | `STRUCT-12` |
| §13 correspondances de disposition | `PORT-01` |
| §14 causes racines R1 à R4 | `BLOQ-08`/`TRANS-04` (R1), `STRUCT-07` (R2), `FACT-06` (R3), `TRANS-09` (R4) |
| §15 aspirateurs A à D | `FACT-13`, `FACT-05`, `FACT-03`, `FACT-06` |
| §16 ce qu'il ne critiquerait pas | `§14.4` |
| §17 architecture minimale à cinq couches | `FACT-21`, `ARB-PR-05` |
| §18 priorisation (17 identifiants, 7 bloqueurs) | `§17` |
| §19 verdict par dimension | `§17.4` |

### 18.4 `K7PL_PR_02_FLASH.docx` (deux parties : rapport initial + cartographie approfondie)

| Item source | Fiche(s) |
|---|---|
| §1.1-1.3 reconstruction, germe, cinq niveaux | contexte |
| §2 duplications structurelles (dualité inductive/coinductive, partage mémoire/canaux) | `FACT-03`, `FACT-08` |
| §2 collisions (« mode » à deux sens ; zéro-copie sémantique contre implémentation) | `NOTA-01`, `PORT-01` |
| CRIT-01 rupture de compositionnalité des effets à portée | `STRUCT-11`, `ARB-PR-03`, `BIB-01` |
| CRIT-02 acyclicité et deadlock dynamique | `BLOQ-13`, `PREUVE-13`, `BIB-02` |
| CRIT-03 abaissement MLIR | `PORT-16` |
| CRIT-04 fragilité de la déclassification | `BLOQ-11` |
| §4 cause racine (asymétrie coeffet / effet), schéma fibré bifactoriel | `FACT-22` |
| §5 verdict et trois recommandations finales | `TRANS-06`, `PORT-16`, `ARB-PR-03` |
| DUP-01 ReadCap / SharedChan | `FACT-08` |
| DUP-02 terminaison / productivité | `FACT-03` |
| DUP-03 effacement phase 8 / non-interférence | `FACT-02`, `STRUCT-19` |
| DUP-04 inexpressibilité, 18 familles d'erreurs | `FACT-09`, `PORT-07` |
| DUP-05 quantale / préfixage | `FACT-10` |
| DUP-06 ré-invocation `n·Δ` / `fix_h` | `FACT-04` |
| COL-01 `𝒢` algèbre contre grade | `NOTA-01` (N-11), `BLOQ-04` |
| COL-02 `Γ` contre `Δ` | `NOTA-01`, `STRUCT-18` |
| COL-03 `⊑` précision contre `≼` sous-typage | `BLOQ-14`, `ARB-PR-01` |
| COL-04 `π_S†` contre `π_ℓ` | `NOTA-01` (N-09), `REFUS-04` |
| COL-05 zéro-copie : iso catégorique contre identité bit-à-bit | `PORT-01` |
| COL-06 acyclicité statique contre deadlock dynamique | `BLOQ-13`, `REFUS-03` |
| §3 trois ruptures de l'orthogonalité P2 (destinations, OPEN, `fix`) | `STRUCT-22` |
| ASPIR-01 lemme universel de commutation fibrée | `FACT-01`, `FACT-13` |
| ASPIR-02 progression bimodale | `FACT-03` |
| ASPIR-03 préservation fibrée | `FACT-07` |
| ASPIR-04 foncteur d'élaboration unifié | `FACT-06` |
| §5 causes racines 1 et 2 (fibration bimodale ; couplage modèle / ABI) | `FACT-22`, `IMPL-06` |
| Plan de refactorisation en 4 étapes | `FACT-22`, `STRUCT-11`, `IMPL-06`, `BLOQ-11` |
| Résumé d'impact chiffré (14 théorèmes, 39→24 règles, 18→4 familles) | `FACT-22` (objectifs à vérifier après refonte) |

### 18.5 `K7PL_PR_02_DEEPSEEK.md`

| Item source | Fiche(s) |
|---|---|
| §1.1-1.3 question, objet central (9 mécanismes), niveaux | contexte, `§14.2` |
| §2.1 graphe de dépendances des notions | contexte |
| Obs. 1 trois critères de terminaison | `FACT-03` |
| Obs. 2 trois concepts d'effet | `STRUCT-11` |
| Obs. 3 quatre monotonies | `STRUCT-17`, `FACT-14` |
| Obs. 4 trois rejeux — *correctement distingués* | `§14.4`, `ARB-PR-04` |
| Obs. 5 quatre lemmes de substitution | `FACT-13` |
| §3.1 surcharge `⊗` | `STRUCT-18` |
| §3.2 surcharge `!` — *légitime, close* | `§14.5` |
| §3.3 `Δ` et `Γ` — *choix délibéré, assumé* | `NOTA-01`, `§14.5` |
| §3.4 monoïdal contre cartésien | `STRUCT-18` |
| §3.5 ensemble / intervalle / mode (table 6) | `BLOQ-04`, `NOTA-01` |
| §3.6 type / valeur / grade | `BLOQ-04`, `NOTA-01` |
| §4.1 compilation contre exécution | `STRUCT-19` |
| §4.2 rejeu logique contre bit-identique — *pas d'erreur de niveau* | `ARB-PR-04`, `§14.4` |
| §4.3 bornes statiques contre mesure dynamique — *aucun changement requis* | `§14.4` |
| §4.4 atomicité locale contre compositionnalité globale — *correctement distingué* | `§14.3` (RMQ 29) |
| §5.1 Th. 36 — **classé bloquant** | `PORT-16`, `PREUVE-02`, `ARB-PR-06` |
| §5.2 non-interférence pour les sessions | `PREUVE-03` |
| §5.3 divulgation délimitée | `BLOQ-11`, `PREUVE-04`, `BIB-06` |
| §5.4 loi distributive graduée | `STRUCT-20`, `PREUVE-05` |
| §5.5 effets gradués indexés | `PREUVE-06` |
| §5.6 clôture suffisante, non nécessaire | `PORT-13` |
| §5.7 absence de course garantie par le type | `BLOQ-09` |
| §5.8 « aucun coût dissimulé » et amortissement | `PORT-09` |
| §6.1 à §6.6 factorisations manquantes | `FACT-03`, `STRUCT-16`, `REFUS-07`, `FACT-14`, `FACT-13`, `FACT-15` |
| §7.1 usage × valeur | `STRUCT-22` |
| §7.2 type × effet × coeffet | `PORT-13` |
| §7.3 compilation × exécution | `STRUCT-19` |
| §8.1 « exactement » dans la clôture | `PORT-13` |
| §8.2 « automatiquement » dans l'analyse de coût — *vue nuancée déjà donnée* | `§14.4` |
| §8.3 « gratuitement » dans le transfert zéro-copie | `PORT-01` |
| §9.1 à §9.4 cohérences interchapitres | `§14.5` |
| §10.1 à §10.4 pipeline, invariants, boucle cachée | `STRUCT-06`, `STRUCT-05` |
| §11 propriétés de langage / d'implémentation / d'environnement | `TRANS-01` (axe niveau), `IMPL-06` |
| §12.1 usage correct de la littérature | `§14` |
| §12.2 trois extrapolations (Th. 7, 10, 36) | `BIB-03`, `BIB-06`, `PREUVE-02` |
| §13 objections 1 à 8 | `§14.4` |
| §14 causes racines 1 à 4 | `§14.4` (RC1), `TRANS-09` (RC2), `STRUCT-23` (RC3, RC4) |
| §15.1 à §15.5 corrections minimales | `PORT-16`, `PORT-13`, `PORT-01`, `PORT-09`, `§14.3` (bac à sable des macros) |
| §16 verdict et notation | `§17.4` |

### 18.6 `K7PL_PR_02_GEMINI.md`

| Item source | Fiche(s) |
|---|---|
| §1.1-1.3 question, objet germinal, cinq niveaux | contexte |
| §2 isomorphismes A≅A′ (adjonction PBV / coeffet-effet) | `FACT-12` |
| §2 isomorphisme B≅B′ (loi distributive graduée unifiant ressources et temps) | `FACT-12`, `STRUCT-20` |
| §2 isomorphisme C≅C′ (data race et déterminisme comme projections de l'absence de diagonale) | `BLOQ-08`, `BLOQ-09` — *l'attribution à l'absence de diagonale est précisément contestée* |
| §3.1 collision sur `G` ; collision sur « canal » | `NOTA-01` |
| §3.2 isolation par types « par construction » | `PORT-02`, `REECR-24` |
| §3.2 « sans en payer le prix » (PBV et gestionnaires d'effets) | `REECR-23` |
| §4 rupture de la chaîne : phase 3 contre phase 6, dépendance circulaire inlining / budget | `STRUCT-05` |
| DEF-01 subtypage modal inversé | `BLOQ-14`, `ARB-PR-01` |
| DEF-02 incomplétude formelle de `φ(r, ε)` | `STRUCT-20`, `PREUVE-05` |
| DEF-03 sur-extension du rejeu bit-à-bit sous P4 | `PORT-04` |
| DEF-04 PBV, types dépendants, effets indexés | `STRUCT-21`, `PREUVE-06`, `BIB-19` |
| DEF-05 duplication de la sédimentation triadique | `STRUCT-01` |
| §6.1 cause racine : adjonction graduée non formalisée | `FACT-12` |
| §6.2 « N règles → 1 principe + 3 instances » | `FACT-12`, `ARB-PR-05` |
| §7 verdict, tableau d'évaluation, recommandation prioritaire | `§17`, `BLOQ-14`, `STRUCT-20` |

---

## 19. Vérifications conduites sur le manuscrit (14 septembre 2026)

Extraction de la couche texte de `K7PL_PR.pdf` (285 p., LuaHBTeX, PDF 2.0), puis contrôle ligne à ligne des affirmations les plus coûteuses à appliquer de travers. **Aucune vérification n'a infirmé un constat de relecteur ; deux ont déplacé la cible d'une correction.**

| Constat vérifié | Fiche | Lieu (folio du PDF) | Résultat |
|---|---|---|---|
| `Lin 𝑇 <∶ Aff 𝑇 <∶ Unr 𝑇` au ch. 1 | `BLOQ-14` | p. 11 | ✅ conforme à la citation de E |
| `SUBBOX : 𝑟 ≼ 𝑟′ ⟹ !𝑟 𝑉 <∶ !𝑟′ 𝑉` | `BLOQ-14` | p. 249 | ✅ direction opposée à la p. 11 |
| Table 20 : usage « descend, 𝜔 se coerce en 1 », `≼ = (≥)×(⪰)×(≤)×(≤)` | `BLOQ-14`, `STRUCT-07` | p. 250 | ✅ **la contradiction est établie** |
| `⊖` = « résidu de l'addition, le plus petit 𝑥 tel que 𝑘 + 𝑥 ≥ 𝛽 » | `BLOQ-03` | p. 48 | ✅ définition confirmée ; `ω ⊖ ω = 0` en découle |
| Esquisse du Th. 1 : « distributivité du produit sur la soustraction tronquée dans ℕ∞ » | `BLOQ-03` | p. 49 | ✅ le cas 𝑢 = 𝜔 n'est pas traité |
| `ℛ = (ℚ≥0 ∪ {𝜔}, +, ×, 0, 1, ≤)` | `BLOQ-04` | p. 48 | ✅ |
| `𝑟 ∶∶= ⟨𝑢, 𝑚, ℓ, 𝛽⟩ ∈ ℛ = ℕ∞ × {d ⪯ m} × ℒ × ℬ` | `BLOQ-04`, `NOTA-01` | p. 244 | ✅ **deux définitions incompatibles de ℛ ; `ℬ` hors table normative** |
| `𝑉 ∶∶= 𝑏 ∣ 1 ∣ 𝑉⊗𝑉 ∣ ⨁ᵢ𝑉ᵢ ∣ Vec 𝑛 𝑉 ∣ Arena 𝑉 ∣ !𝑟 𝑉 ∣ 𝑈 𝐶 ∣ ∃𝛼.𝑉 ∣ 𝜇𝛼.𝑉` | `BLOQ-01` | p. 244 | ✅ **`S` n'est pas clause de `V` : aucun canal ne peut être une liaison de Δ** |
| `𝐶 ∶∶= 𝐹𝜀 𝑉 ∣ 𝑉 ⊸ 𝐶 ∣ &ᵢ𝐶ᵢ ∣ ∀𝛼.𝐶 ∣ 𝜈𝛼.𝐶` | `BLOQ-01a` | p. 244 | ✅ **ni `○𝐶`, ni `□𝑉`, ni `◇𝑉` ; DEL conclut `○𝐶` et WHEN conclut `◇𝐶`** |
| `𝑆 ∶∶= End ∣ … ∣ ○𝑆 ∣ □𝑆 ∣ ◇𝑆 ∣ 𝑆` | `BLOQ-02` | p. 244 | ✅ **production terminale vide `S ::= S`** |
| « la duale porte le nom . » / « que ne vit qu'en couche 2 » / « se coerce vers l'identité, 𝑆 → 𝑆 » | `BLOQ-02` | p. 252 | ✅ **trois occurrences sans glyphe ; la coercition annoncée est l'identité** |
| Règle WHEN imprimée, sans condition de bord sur Δ₂ | `BLOQ-02`, `NOTA-06e` | p. 251 | ✅ **la règle imprimée est celle que le texte déclare « trop permissive »** |
| `OPEN` : condition de bord `𝛼 ∉ fv(𝐶)` seulement | `NOTA-06f` | p. 248 | ✅ ; et p. 250 : « c'est sur elle que la preuve de non-interférence s'appuiera » |
| `TICK : 0 ⊢ tick ∶ 𝐹1 1 ∣ ⟨1, 1⟩` | `BLOQ-05` | p. 248 | ✅ **effet mal formé : la seconde composante doit être une famille `δ_ℓ`** |
| Clause de taille et sa justification par [25] | `BLOQ-06`, `ARB-PR-02` | p. 57 | ✅ **la source incrimine « un type à la fois inductif et coinductif »** |
| Table 8 : `[ ... ] Cartésien Δ = ∅` | `NOTA-04` | p. 167 | ✅ |
| « Ce théorème n'est pas démontré » (Th. 36) | `PORT-16`, `ARB-PR-06` | p. 207 | ✅ |
| « Le théorème 27 est donc démontré, et la dette de fidélité […] est acquittée » | `STRUCT-03` | p. 276 | ✅ contre p. 152-153 et p. 156, qui la déclarent ouverte |
| « L'audit des dix-huit familles d'erreurs » | `PORT-07` | p. 98 | ✅ |
| Comptes de règles : « trente-neuf règles […] trente-cinq constructeurs » contre « les trente-quatre règles » | `NOTA-03` | p. 244 contre p. 262 et p. 264 | ✅ **écart confirmé aux trois endroits** |
| Th. 45 « correction de ressource » | `PREUVE-01` | p. 268 ; mention isolée p. 30 | ✅ **absent de la table 1 des engagements** |

**Un point non confirmé, à ne pas propager tel quel :** la citation « [`να.C`] était le seul de dix-neuf dans ce cas » (Q/R-01, annexe E.3.4) **n'apparaît pas dans la couche texte extraite**. Le compte « dix-neuf » reste donc à vérifier sur le rendu, ou la citation à corriger. Le reste de R-01 est confirmé.

**Pagination :** les folios cités par QWEN se sont révélés exacts sur l'intégralité des points contrôlés (p. 11, 48, 49, 57, 98, 167, 207, 244, 247, 249, 250, 251, 252, 268, 276). **Les localisations de ce plan peuvent être suivies telles quelles.**

### 19.1 Ce qui n'est toujours pas dans ce fichier

1. **Les contrôles portent sur les points décisifs, non sur les 124 fiches.** Une vingtaine d'affirmations ont été vérifiées ; les autres restent sur la foi des rapports — fiabilité désormais établie, mais non universelle.
2. **Aucun chiffrage de charge propre.** Les coûts indiqués (« une page », « trois lignes », « quarante pages ») sont ceux avancés par les relecteurs.
3. **Trois arbitrages restent ouverts et sont éditoriaux, non factuels** : `ARB-PR-03` (traitement des effets à portée), `ARB-PR-04` (le constat tient, seule la gravité relative se discute), `ARB-PR-05` (choix du cadre de rédaction). Aucun ne se tranche par lecture du manuscrit.
