# Revue formelle contradictoire — *K7PL : KonSept Programming Language*

**Document examiné** : `main.pdf`, 285 p., Cyprien PIERRE, daté 2026-09-09 (LuaHBTeX/TeX Live 2025).
**Corpus lu** : chapitres 1 à 7 en entier, annexe E en entier, annexe A en entier, annexes B–D et chapitre 8 en repérage.
**Posture** : reviewer hostile mais loyal. Aucune objection n'est retenue si elle n'est pas techniquement défendable ; aucune construction n'est rejetée en bloc quand seule une partie est fautive ; aucune objection déjà formulée par le document n'est présentée comme une découverte.

---

## 0. Note de méthode et de loyauté

Ce document s'impose à lui-même une exigence vérifiable, écrite au chapitre 1 (§1.2, p. 6) :

> « Aucune affirmation ne figure sans qu'un postulat, un théorème ou une construction établie la porte, et ce qui n'est pas porté est nommé comme tel. »

et une seconde (§1.5, p. 39) :

> « Ce document emploie un symbole par objet, et un objet par symbole. […] un symbole absent de cette table n'a pas de sens dans ce document. »

**La présente revue tient le document à ces deux exigences, et à elles d'abord.** C'est la seule façon loyale de le critiquer : la plupart des défauts que je relève ne sont pas des erreurs que l'auteur ignorerais, mais des écarts à une norme qu'il a lui-même énoncée et qu'il a outillée pour être vérifiée (RMQ 1–38, patrons « S'il tient / S'il tombe », table 1 des engagements et leurs trois routes, table 12 des statuts, §E.5.6 des incertitudes). Cet outillage est, je le dis d'emblée, d'un niveau que je n'ai rencontré dans aucune spécification de langage de cette taille. Il rend la critique précise possible, et il rend aussi les écarts *détectables* — ce qui aggrave les écarts non corrigés, parce qu'ils surviennent dans un document qui prétend les interdire.

**Légende des catégories** (conforme à la grille demandée, et appliquée sans substitution silencieuse) :

| Catégorie | Sens retenu ici |
|---|---|
| Déf. | ce que le document choisit de définir |
| Ax./Post. | ce qu'il pose sans le dériver (P1–P4, les lois de comonade graduée, la quantale ℰ) |
| Th. | ce qui découle effectivement des éléments précédents |
| Cor. | dérivable d'un résultat déjà établi |
| Conj. | annoncé mais non établi |
| Impl. | dépend d'une réalisation concrète (compilateur, solveur, IEEE 754, Arrow, Cap'n Proto, anneau SPSC) |
| Ing. | condition de déploiement ou de conception (E_repro, budget de spécialisation, bac à sable) |
| Litt. | emprunté à une source externe |
| Int. | mon interprétation de reviewer |
| Ref. | proposition de refactorisation |

**Échelle de gravité** : A bloquant · B structurel · C portée · D dette de preuve · E ambiguïté notationnelle · F dette d'implémentation · G stylistique.

---

# PREMIÈRE PARTIE — RECONSTRUCTION

## 1.1 La question scientifique (ce que le document cherche réellement)

La formulation de surface est : *définir un langage fonctionnel stratifié qui tient ensemble performance proche du matériel, sûreté mémoire et de concurrence, et vérification avant mise en production.* Ce n'est pas la question profonde.

La question profonde est architecturale et elle est énoncée au §1.1 : **les trois exigences ne sont pas un arbitrage si elles sont des instances d'une même structure algébrique ; alors on ne choisit pas un point sur un triangle, on gradue un niveau de rigueur payé localement.** L'invariant global que le document cherche à préserver n'est donc ni la sûreté ni la performance : c'est

> **l'absence de seuil de rupture entre ce qu'un terme exige, ce qu'il est, et ce qu'il produit.**

Tout le reste est au service de cet invariant. Le jugement germinal

$$\Delta \vdash_{\mathcal G} t : A \mid \mathcal E \tag{1}$$

n'est pas « un jugement à trois composantes » : c'est la *thèse* qu'il existe un point fixe minimal de l'architecture, c'est-à-dire un objet dont toute extension doit être une instance plutôt qu'un ajout. Les quatre postulats ne sont pas quatre promesses mais, comme le dit exactement le §1.4 (p. 17), **quatre portes fermées** : P1 ferme la porte des optimisations sans morphisme de correction ; P2 ferme la porte de la dépendance dynamique des grades (et achète au passage la sortie du triangle de Pédrot–Tabareau [40]) ; P3 ferme la porte du coût dissimulé ; P4 ferme la porte du non-déterminisme non journalisé.

Le prix d'expressivité accepté est nommé et chiffré : élimination faible seulement (pas de filtrage dépendant du sujet), pas de multiplicités dépendant d'une valeur d'exécution, joint de branchement sur-approximant (programmes corrects rejetés), pas de délégation de session, pas de continuations multiples, pas de sous-typage de protocoles asynchrones, pas de topologies circulaires, bornes pire cas pour la bibliothèque, itération `fix` conduite jusqu'à la hauteur du type et non jusqu'à stabilisation. Ce catalogue est honnête et c'est l'un des points forts du document.

## 1.2 L'objet central (le germe)

Le germe n'est pas le jugement : c'est **l'adjonction valeurs/calculs du régime d'appel par poussée de valeur, lue comme un système de raffinement de types au sens de Melliès–Zeilberger**, avec deux modalités graduées posées sur ses deux côtés et une strate de propositions déchargées plutôt que dérivées. Le §1.4 (p. 29) le dit dans les bons termes :

- *forme* : l'adjonction entre valeurs et calculs ;
- *structure* : deux modalités graduées, 𝒢 sur le contexte (coeffets), ℰ sur le calcul (effets) ;
- *obligations* : les raffinement s (propositions sur ce que la structure tient).

**Combien de mécanismes apparemment distincts sont des instances de ce germe ?** Le document en revendique un grand nombre, et mon examen confirme la plupart des revendications :

| Mécanisme | Instance de | Statut de la revendication |
|---|---|---|
| fragments Lin/Aff/Unr | sous-ensembles (ou intervalles) distingués de ℛ | **contestée** : deux définitions incompatibles (R-04) |
| grade de présence d'un champ d'enregistrement | fragment affine {0,1} | partiellement vraie, fausse sous la lecture intervalle |
| monotonie, confidentialité, budget, temps | modalités graduées sur une structure ordonnée (§2.4) | vraie, et c'est le meilleur résultat d'économie du document |
| SharedChan(p) | même ressource à un grade admettant la contraction | vraie en intention, **non réalisable** dans le noyau formel (R-01) |
| partage d'une région / partage d'un canal | même geste (image cartésienne / service répliqué) | vraie au niveau de la cible, fausse au niveau de la source |
| terminaison (couche 3) et productivité (couche 2) | un seul théorème paramétré par la polarité (Th. 5) | vraie, **mais contredite par la clause de taille** (R-03) |
| effacement Phase 8, non-interférence, ordre de précision | trois lectures d'un foncteur de raffinement (Th. 9) | vraie en forme, dépend de Th. 27 (R-06) |
| cinq mécanismes d'effacement | cinq usages de la distinction de phase | vraie |
| hygiène des macros | inexpressibilité (préfaisceau indexé par la portée) | vraie, sur l'AST non gradué seulement |
| règle EXPAND | lemme de substitution itéré + Th. 1 | vraie, sous réserve de R-02 |
| ⊠ | addition pointuelle + transport ψ | vraie (Th. 38), sous réserve de R-02 |
| journal stratifié, projection observationnelle, effacement par niveau, restriction de sortes | une seule opération π_ℓ lue quatre fois | vraie et **sous-exploitée** : voir §4.3 |
| grades finis, VECE, φ_n de SC, EXPAND, itération de `fix` | un seul appareil de ré-invocation bornée | vraie, le document le constate pour (b)/(d) seulement : voir §4.2 |
| acteur | copatron + point fixe + `out` | **non réalisée** : aucune règle (R-01) |
| canal de session | ressource de Δ typée par S | **non réalisable** : S n'habite pas V (R-01) |

Le bilan est donc contrasté : le germe est réel, il absorbe effectivement une dizaine de mécanismes, et il échoue précisément là où le document place sa singularité revendiquée — la couche 2 comme calcul de processus.

## 1.3 Architecture des niveaux

Reconstitution des niveaux, avec les erreurs de passage que j'y ai relevées (elles sont détaillées en deuxième partie) :

1. **Syntaxe de surface** (ch. 5) : S-expressions, trois paires de délimiteurs, six formes de surface, glyphes.
2. **Noyau élaboré** (annexe E.1–E.2) : grammaire des types (3 strates), des termes (35 constructeurs).
3. **Jugement / règles** (E.3) : 34 à 39 règles selon l'endroit du document où l'on compte.
4. **Sémantique opérationnelle** (E.4) : configuration ⟨c ∣ μ ∣ τ⟩, petits pas, déterminisme couche 3.
5. **Métathéorie** (E.3.5, E.4.3–E.4.6) : substitution, relation logique, lemme fondamental, traduction.
6. **Cible** (ch. 4 §4.6, E.5) : π-calcul réflexif local + motifs de jonction, système de sortes.
7. **Compilation** (ch. 6) : 8 ordres de vérification + 2 points de contrôle, MLIR, solveur SMT.
8. **Représentation / machine** (ch. 4) : arènes PIA, SoA, EntityRef, anneaux, BLAKE3, IEEE 754, Arrow, Cap'n Proto, VirtIO.
9. **Déploiement** (ch. 4 §4.5, ch. 7) : unikernel anneau 0, acteurs virtuels, supervision, cluster, E_repro.

**Les erreurs de passage que j'ai identifiées sont toutes dans le même sens** : une propriété établie (ou seulement visée) au niveau *n* est énoncée au niveau *n−1* ou *n+1* sans que le transport soit écrit. Concrètement :

- niveau 8 → niveau 3 : Th. 18 (NaN IEEE 754), Th. 20 (Arrow/Cap'n Proto), Th. 25 (anneau SPSC), Th. 26 seconde clause.
- niveau 7 → niveau 3 : Th. 16 (« le vérificateur implante les règles »), Th. 33 (budget d'implémentation), Th. 35 (déterminisme de l'outil).
- niveau 3 → niveau 9 : Th. 23 (≈obs ⟹ =bit), Th. 22 (complétude de la journalisation supposée).
- niveau 6 → niveau 3 : Th. 25, Th. 27 groupe « couche 2 », Th. 28.

C'est, à mon jugement, **la cause racine la plus féconde du document** : il ne dispose d'aucun dispositif qui oblige un énoncé à déclarer son niveau. Il dispose pourtant du vocabulaire (« postulat / théorème / engagement / lecture / réserve / obligation / exigence »), mais ce vocabulaire classe la *force épistémique*, pas le *niveau*. D'où la recommandation transversale RT-4 (§5).

---

# DEUXIÈME PARTIE — CRITIQUES SUBSTANTIELLES

Ordre : par gravité décroissante, puis par dépendance. Les identifiants R-nn sont stables et citables.

---

## [R-01] Le noyau formel est séquentiel : la couche 2 n'a ni règles, ni constructeurs, ni types habitables

**Localisation :** annexe E.1 (p. 244), E.2 (p. 245), E.3 (p. 246-261), E.3.4 (p. 259), E.6 (p. 281) ; contre chapitre 1 §1.4 (p. 17-20, 34), chapitre 3 §3.2 (p. 102-106), chapitre 4 §4.3/§4.5/§4.6, chapitre 5 §5.5, chapitre 7.

**Énoncé actuel :** le document affirme que (i) le contexte des canaux est fondu dans Δ, de sorte que le jugement n'a que trois composantes et qu'« un canal est une ressource de Δ, typée par un protocole de session » (§1.4, p. 20) ; (ii) la couche 2 est « un π-calcul enrichi de motifs de jonction » dont chaque constituant est construit (§1.4, p. 34) ; (iii) l'annexe comble l'asymétrie selon laquelle la cible est formellement présentée et la source ne l'est pas (§E.6, p. 281) ; (iv) la grammaire est « complète au sens précis où elle est croisée avec le jeu de règles », croisement « vérifié mécaniquement à chaque construction du document » (§E.1, p. 244).

**Diagnostic :** les quatre affirmations sont fausses telles quelles, pour une raison unique et vérifiable ligne à ligne.

1. La grammaire des types comporte trois strates : `V` (valeurs), `C` (calculs), `S` (sessions). **`S` n'est une clause ni de `V` ni de `C`.** Les liaisons de Δ sont de la forme `x :_r V`. Un canal ne peut donc *pas* être une ressource de Δ : il n'existe aucun contexte bien formé contenant un canal. La fusion revendiquée au §1.4 — qui est présentée comme une économie (« le jugement compte ainsi une composante de moins ») — n'est pas réalisée par la grammaire que le document donne.
2. La grammaire des termes (35 constructeurs : 9 valeurs + 26 calculs) ne contient **aucune forme de communication** : ni émission, ni réception, ni offre, ni sélection de branche protocolaire, ni création de canal, ni coupure, ni composition parallèle, ni motif de jonction sur canaux, ni acteur, ni capacité (`WriteCap`, `ReadCap`, `Dest`, `hollow_alloc`, `fill`, `finalize`), ni opération d'arène, ni fusion CRDT, ni accès de lentille. Les copatrons `⟨⟨j ↦ c_j⟩⟩` et `out c` sont l'élimination de la conjonction additive et du point fixe coinductif : ce ne sont pas des réceptions.
3. Par conséquent les règles imprimées (VAR, RET, TH, LET, FO, BOX, UNBOX, LAM, APP, PAIR, INJ, PACK, OPEN, ONE, ONEE, SPLIT, CASE, OP, TICK, DEL, SUB, SUBBOX, ALW, ALW−, NOW, WAIT, WHEN, SC, FOLD, UNFOLD, GEN, INST, OUT, COP, WITH, PROJ, VECI, VECE, plus `fix` (11) et `declassify` (10)) ne contiennent **aucune règle de communication**. Or le §E.3 (p. 246) affirme : « les sessions n'y contribuent rien. Un protocole étant une syntaxe de surface sur l'implication linéaire, ses règles sont celles de cette implication. » C'est exact pour les *types* et faux pour les *termes* : dans l'interprétation « propositions comme sessions », recevoir est `x(y).P` et envoyer est une coupure `(νx)(x⟨y⟩.Q ∣ P)`. `LAM`/`APP` ne fournissent ni l'un ni l'autre — `APP` est un β-rédex local et synchrone.
4. Le croisement mécanique revendiqué est pris en défaut par le document lui-même, dans les deux sens annoncés :
 - *constructeur sans règle* : les 8 constructeurs de `S` (End, ⊗, ⊸, ⊕{ℓ:S}, &{ℓ:S}, ○, □, ◇) n'ont aucune règle. Le §E.3.4 (p. 259) affirme que `να.C` « était le seul de dix-neuf dans ce cas » : c'est faux — `Arena` l'est aussi (déclaré), et la strate `S` entière l'est (non déclaré). Le compte « dix-neuf » ne correspond d'ailleurs à aucun décompte de la grammaire (10 + 5 = 15 pour V et C, 23 avec S).
 - *règle sans constructeur* : DEL conclut `○C`, ALW conclut `□V`, ALW− élimine `□V`, NOW conclut `◇V`, WAIT conclut `◇V` à partir de `○◇V`, WHEN conclut `◇C`. **Aucun de ces types n'est engendré par la grammaire** : ○, □, ◇ ne figurent que dans la strate `S`. Six règles concluent donc des types mal formés au sens de E.1. DEL applique en outre `○` à un *contexte* (`○Δ`), troisième usage non grammaticalisé.
 - le compte des règles est lui-même instable : 39 (§E.1, dont « les deux règles structurelles de formation de contexte »), 34 (§E.3.5, preuve du Th. 41), et **les deux règles de formation de contexte n'apparaissent nulle part** — alors que le Th. 44 (p. 266) raisonne « dans le contexte vide » et que c'est dans ces règles que devraient vivre la bonne formation des grades, l'affectation de mode/zone et le niveau d'un calcul (voir R-05).

**Nature :** **A** (bloquant), avec composante **E** pour les comptes.

**Pourquoi c'est réellement un problème :** ce n'est pas une lacune de rédaction, c'est une rupture de dépendance qui vide de leur support une dizaine d'énoncés centraux.
- Le Th. 27 (traduction préserve le typage) déclare couvrir « les cas de la couche 2 » et « les six correspondances » (acteur, canal, jonction, séquencement, capacité, composition). **Ces cas n'existent pas dans la source.** Le §E.4.6 (p. 276) conclut « les quatre cas résistants sont soldés, et avec eux l'induction entière : le théorème 27 est donc démontré ». Une induction ne peut pas être entière sur un jeu de règles qui ne contient pas les règles dont elle prétend traiter les cas.
- Le Th. 25 (atomicité des jonctions) quantifie sur `J ≜ x⟨u⟩ ∣ y⟨v⟩ ▷ P`, qui est un terme de la *cible*, et conclut sur « l'acteur », qui est une notion de la *source*, par un mécanisme d'*implémentation* (anneau SPSC, échange atomique de pointeurs). Trois niveaux en un énoncé.
- Le Th. 17 (absence de blocage) suppose « des canaux typés par des protocoles de session duaux » : aucun terme de la source n'a un canal pour type.
- Le Th. 45 (correction de ressource) et le Th. 51 (confinement des canaux distingués) traitent « Couche 2 — tous les cas » : il n'y a pas de cas.
- La relation logique (§E.4.3) est définie sur V et C ; la clause de session (§E.5.5) est définie sur S ; mais **aucun jugement ne peut porter une liaison de type S**, donc la clause de session ne s'applique à aucune dérivation de la source. Le §E.5.5 conclut pourtant que « la non-interférence graduée et la divulgation délimitée cessent donc d'être bornées au fragment sans communication » : elles restent bornées au fragment sans communication, parce que le fragment avec communication n'est pas formalisé.

**Ce qui reste valide :** beaucoup, et il faut le dire nettement.
- Le noyau CBPV gradué (V/C, U/F, BOX/UNBOX, LAM/APP avec `r·Δ2`, LET avec `⊠_{ε1}`) est cohérent, et je l'ai vérifié sur le point le plus sensible : la discipline de grade empêche bien la duplication d'une ressource linéaire capturée par un thunk. `thunk c` retient le contexte Δ de `c` ; forcer deux fois exigerait la valeur `thunk c` à un grade ≥ 2, que PAIR/LET refusent parce que l'addition des contextes est pointuelle et que la règle VAR impose `0·Δ, x:^1 V`. `BOX` à grade ω exige `ω·Δ`, donc que les ressources capturées soient elles-mêmes à ω. L'articulation thunkabilité/gradation tient.
- La sortie du triangle de Pédrot–Tabareau [40] est correctement identifiée et **structurellement réalisée par les règles imprimées** : `F_ε V` est un type de *calcul*, son seul éliminateur est LET qui lie une *valeur*, et aucun éliminateur ne discrimine sur un calcul. Le document a donc bien deux des trois sorties du triangle.
- La traduction « propositions comme sessions » pour le fragment séquentiel (couches 3 et la part affine non communicante de la couche 2) est un objet légitime, et le Th. 48 (commutation traduction/substitution) en est la bonne pièce maîtresse.
- L'auto-diagnostic du §E.6 est exact sur le diagnostic et faux sur le remède : « Le métalangage […] est formellement présenté quand K7PL, qui en est la source, ne l'est pas. Cette asymétrie est le vrai retard de ce document. » La phrase identifie le problème ; l'annexe ne le comble pas.

**Contre-exemple / scénario de rupture (le plus petit) :** écrire le programme du §5.5 (Listing 3-5 : `defactor Compteur`, `defhandler`, `bind-to`, `HandlerResult`, lentille `^.`, `select`) dans la grammaire de E.2. C'est impossible : aucun des constructeurs employés n'y figure. Or ce programme est présenté au chapitre 5 comme l'exemple de composition des trois couches, et au chapitre 7 comme le cas d'usage I. Le plus petit scénario de rupture est donc *l'exemple unique du document*.

Un second, plus court : soit `c : Chan(Send(Int,End))` une liaison de Δ. Par E.1, `Chan(S) ∉ V`, donc `Δ = (c :_1 Chan(S))` n'est pas un contexte gradué, donc VAR ne s'y applique pas, donc `c` n'est pas un terme. Le §1.4 (p. 20) affirme le contraire.

**Correction minimale :** deux voies, et il faut choisir explicitement.
- *Voie 1 (la plus petite, et celle que je recommande)* : **restreindre la portée** plutôt qu'ajouter un mécanisme. Écrire une fois, au §E.1 : « le noyau formalisé est le fragment séquentiel ; les formes de communication, de capacité et d'arène sont hors noyau et leurs énoncés sont des énoncés sur la cible ou sur l'implémentation ». Puis requalifier Th. 17, 21, 22, 24, 25, 26, 28, 45, 51 en énoncés *sur la cible* ou en *exigences d'implémentation* (catégorie que le §1.2 possède déjà : « une exigence est une contrainte que l'implémentation doit satisfaire, et dont ni la démonstration ni la réfutation n'appartiennent à ce texte »). Coût : une page. Perte : la revendication que la couche 2 est un langage concurrent formalisé.
- *Voie 2 (la plus coûteuse)* : ajouter `S` comme clause de `V` (donc des liaisons de Δ), six constructeurs de termes (send, recv, offer, select, fork/coupure, join) et leurs règles, une règle de création de canal, et une sémantique opérationnelle à configurations multiples — ce que le §E.4 (p. 266) annonce (« elle se relève aux configurations concurrentes de la couche 2 — plusieurs calculs, une arène partagée, une trace par fibrille ») sans le donner. Coût : le doublement de l'annexe, et la reprise des Th. 41, 43, 44, 47.
- Dans les deux voies, **réparer immédiatement** : (a) les six règles temporelles qui concluent des types non engendrés — ajouter `○C`, `□V`, `◇V`, `○◇V` aux grammaires de C et V, ou restreindre les modalités à S et retirer les règles ; (b) écrire les deux règles de formation de contexte ; (c) rendre le compte de règles unique et le faire réellement vérifier par le croisement annoncé.

**Conséquences interchapitres :** ch. 1 §1.4 (la fusion Δ/canaux, « l'équation fondamentale », la clôture), ch. 2 §2.5 (Th. 9 : la catégorie des dérivations), ch. 3 §3.2 (sessions asynchrones, Th. 17), ch. 4 §4.3/§4.5/§4.6 (acteurs, Th. 21, 22, 24, 25, 26, 27, 28), ch. 5 §5.5 (exemple), ch. 6 §6.3 (dette de fidélité), ch. 7 (trois études de cas), annexe A (codes ERR-ACT, ERR-ARC, ERR-MEM, ERR-TYP-006/007, ERR-FFI : tous portent sur des constructions hors noyau).

**Gain conceptuel éventuel :** considérable et *négatif* au bon sens du mot. Une fois la frontière noyau/cible tracée, la dette se réduit d'un coup : il n'y a plus « quatre preuves ouvertes » ou « cinq travaux ouverts » ou « trois preuves démontrées » (trois inventaires incompatibles, voir R-06), il y a un noyau séquentiel dont la métathéorie est à portée (substitution, préservation, progrès, relation logique sans canaux — c'est-à-dire exactement ce que l'annexe a *déjà* fait) et une cible dont la métathéorie est empruntée à la littérature [60, 61, 62, 67]. Le document cesse alors de devoir prouver une traduction entre deux langages dont l'un n'existe pas, et peut prouver une traduction entre un noyau qu'il a et une cible qu'il cite. C'est la réduction de complexité la plus rentable de cette revue.

---

## [R-02] La loi de cohérence (Th. 1) est fausse au grade ω ; les deux chapitres qui l'emploient utilisent deux conventions différentes de `⊖`

**Localisation :** chapitre 2 §2.2, p. 49 (énoncé et esquisse) ; chapitre 1 §1.4, p. 24-29 (table 2, `⊠`, loi de cohérence) ; annexe E.3.5, p. 261-262 (le calcul détaillé) ; définition de `⊖` au chapitre 2 §2.2, p. 48.

**Énoncé actuel :**
$$r\cdot\psi(\Delta,\varepsilon)=\psi(r\cdot\Delta,\varphi_r(\varepsilon))$$
« pour tout grade r, tout contexte Δ et tout effet ε ». Sur la composante de budget, avec u la composante d'usage de r, β le budget et k la composante temporelle de ε : membre gauche `u·(β ⊖ k)`, membre droit `(u·β) ⊖ (u·k)`. L'annexe (p. 262) conduit le cas : « pour u = ω les deux membres valent ω dès que β > k, et 0 sinon ». Le chapitre 2 (§2.2, p. 48) définit `⊖` comme « le résidu de l'addition, **le plus petit x tel que k + x ≥ β** ».

**Diagnostic :** avec la définition du chapitre 2, `ω ⊖ ω = 0` (car `ω + 0 = ω ≥ ω`, et 0 est le plus petit tel x). Donc pour β = 5, k = 3, u = ω :
- membre gauche : `ω · (5 ⊖ 3) = ω · 2 = ω` ;
- membre droit : `(ω·5) ⊖ (ω·3) = ω ⊖ ω = 0`.

`ω ≠ 0`. **La loi est fausse.** L'annexe calcule correctement le membre gauche et *postule* ω pour le membre droit, c'est-à-dire qu'elle utilise silencieusement la convention `ω ⊖ ω = ω`, que le chapitre 2 exclut. Le chapitre 1 (p. 29) déclare cette loi « démontrée à l'annexe E (§E, théorème 1) » ; l'annexe (p. 262) déclare qu'elle « n'est pas démontrée ici » et renvoie au chapitre 2 ; le chapitre 2 la démontre en trois lignes qui ne traitent pas le cas ω. Trois lieux, aucune version complète.

Ajoutons que la clause de partialité transporte mal : l'annexe écrit « le membre gauche est défini si et seulement si le droit l'est ». Sous la lecture *partielle* (β ⊖ k indéfini si β < k), pour u = 0, β = 2, k = 5 : le membre gauche est indéfini, le membre droit vaut `0 ⊖ 0 = 0` et est défini. L'équivalence de définissabilité échoue donc aussi, dans l'autre cas extrême.

**Nature :** **A** (bloquant) — non parce que l'idée est fausse, mais parce que l'énoncé tel qu'écrit est faux et qu'il est invoqué nommément par six démonstrations.

**Pourquoi c'est réellement un problème :** le chapitre 1 (p. 29) dit de cette loi : « elle est ce qui autorise le jugement à ne porter que trois composantes », et « une loi qui sert trois fois à trois endroits appartient aux fondations ». Le chapitre 2 (p. 49) : « le reste du document l'emploie quatre fois sans jamais la redémontrer ». Les emplois sont : Th. 38 (`⊠` généralise +), Th. 41 (substitution), Th. 45 (correction de ressource), Th. 47 (lemme fondamental, cas LET et APP), Th. 48/27 (traduction), Th. 32 (EXPAND). Une loi fausse au grade ω, et ω est *le* grade du fragment cartésien, donc de la couche 3, donc du cas le plus courant.

**Ce qui reste valide :** l'identité est vraie pour tout u fini, et l'argument de l'annexe pour u fini est correct (cas β ≥ k et β < k). Elle est aussi vraie pour u = ω lorsque k = 0. La loi n'est donc pas à jeter : elle est à *borner*. Et l'intuition qui la fonde — multiplier une exigence sans multiplier l'effet qu'elle traverse fait dériver les deux moitiés du jugement — est exacte et reste le bon invariant.

**Contre-exemple minimal (à inscrire au document) :** `(force t) 5`, où `t` est un thunk dont le forçage coûte k = 3 ticks, et où l'argument `5` est à grade ω. APP compose `Δ1 ⊠_{ε0} (ω·Δ2)`. Recombiner après substitution exige `ω·(β ⊖ 3) = (ω·β) ⊖ (ω·3)`, soit `ω = 0`. Le programme est parfaitement raisonnable ; c'est l'arithmétique de `⊖` qui ne suit pas.

**Correction minimale (dans l'ordre de préférence clarification < restriction < lemme) :**
1. **Clarification (suffisante, et la meilleure)** : définir `⊖` sur ℕ∞ par cas, avec la convention `ω ⊖ ω = ω`, c'est-à-dire
 `β ⊖ k = 0` si β < k (finis) ; `β − k` si β ≥ k finis ; `ω` si β = ω.
 Puis écrire explicitement au §2.2 : *ce `⊖` n'est pas le résidu de l'addition* (le résidu donnerait `ω ⊖ ω = 0`) ; c'est la soustraction tronquée prolongée par continuité en ω. La motivation est interne au document : le §E.3.2 lit l'annotation comme une **borne** et non comme une mesure (« Lue comme une borne […] elle tient »), et pour une borne, `ω ⊖ ω = ω` est la sur-approximation sûre. Cette convention rend la loi vraie *sans restriction*, et le calcul par cas de l'annexe devient correct tel quel.
2. **Restriction (si l'on veut garder le résidu)** : énoncer la loi pour u ∈ ℕ (usage fini) et ajouter à APP/LET la condition de bord `u(r) = ω ⟹ k(ε) = 0`. C'est plus faible et cela rejette des programmes corrects (voir le contre-exemple), donc je le déconseille.
3. **Lemme** : dans les deux cas, isoler « distributivité du produit sur `⊖` dans ℕ∞ » comme un lemme nommé (il sert aussi au Th. 38, au Th. 41 et au Th. 49), avec la convention de ℕ∞ écrite une fois (0·ω = ? ω·0 = ? ω+ω = ? ω·ω = ?). **Aucune de ces quatre égalités n'est écrite dans le document**, alors que ℕ∞ est le porteur des indices de taille, des budgets et de la composante d'usage.

**Conséquences interchapitres :** ch. 1 §1.4 (table 2, définition de `⊠`, localisation de la preuve), ch. 2 §2.2 (Th. 1, définition de `⊖`, clause « monoïde commutatif naturellement ordonné et résidué »), annexe E.3.5 (le calcul), E.3 (Th. 38), E.4 (Th. 43, 45), E.4.3-E.4.6 (Th. 47, 48, 27), ch. 5 §5.4.2 (Th. 32).

**Gain conceptuel éventuel :** la convention `ω ⊖ ω = ω` unifie trois choses que le document traite séparément : la soustraction de budget, la perte de borne sous `◇` (`ε[ω/k]`, §E.3.1) et l'absorption du grade ω. Toutes trois sont la même opération : *l'infini absorbe et reste infini*. On peut alors énoncer un seul principe (« ℕ∞ est un semi-anneau à élément absorbant ω pour + et ×, et `⊖` est continu en ω ») dont la loi de cohérence, le Th. 38 et la règle WHEN sont des corollaires. C'est une abstraction légitime au sens du critère que je m'impose : elle explique plusieurs constructions existantes, réduit leur duplication, permet une preuve commune, et ne masque aucune différence sémantique réelle.

---

## [R-03] La clause de taille `i ∈ ℕ∞ ∖ {ω}` interdit les acteurs et les flux non bornés que le document exige par ailleurs

**Localisation :** chapitre 2 §2.3, p. 57 (la clause et sa justification par l'issue Agda [25]) ; chapitre 2 §2.3, p. 62 (Th. 5, preuve « par bien-fondation […] dans 𝒞^op pour p = ν ») ; annexe E.3.4, p. 260 (règles OUT/COP, « L'indice est un grade, et la clause de bonne formation du chapitre 2 le borne : i ∈ ℕ∞ ∖ {ω} ») ; contre chapitre 2 §2.3, p. 60 (« produire une valeur observable en temps fini, **même si le calcul dans son entier ne termine jamais** »), chapitre 4 §4.2, p. 124 (« un flux qui ne termine jamais »), §4.5, p. 133 (acteurs virtuels désactivés/réactivés), chapitre 7 §7.1 (cycle réactif à chaque image), P4 (rejeu d'un historique H arbitraire).

**Énoncé actuel :** tout indice de taille est pris dans ℕ∞ ∖ {ω} ; ω est exclu parce qu'« un ordre strict bien fondé est irréflexif, de sorte que ω < ω est faux, quand un plus grand élément employé comme taille demanderait précisément qu'il soit vrai » ; et l'issue Agda [25] montre qu'une plus grande taille réflexive permet un type à la fois inductif et coinductif d'où se tire une preuve du type vide.

**Diagnostic :** la clause est justifiée par un argument qui ne vaut que pour le côté **inductif**, et elle est appliquée aux deux côtés. Trois conséquences vérifiables :

1. **OUT/COP bornent la durée de vie de tout objet coinductif.** OUT : de `να.C⟨i+1⟩` on obtient `C[να.C⟨i⟩/α]`. COP : produire `να.C⟨i+1⟩` demande des branches en `C_j⟨i⟩`. Avec i ∈ ℕ, un acteur ou un flux初始isé à i = n produit au plus n observations, puis atteint `να.C⟨0⟩` où OUT n'est plus instanciable (il faudrait `⟨−1⟩`). **Aucun processus non terminé n'est typable.** Or c'est exactement ce que la couche 2 est censée porter, et ce que le Th. 4 énonce (« un flux […] produit une valeur observable en un nombre fini d'étapes » — c'est-à-dire *à chaque pas*, pas *en tout*).
2. **La preuve du Th. 5 pour p = ν est invalide telle qu'écrite.** « Par bien-fondation de l'ordre sur les tailles […] dans 𝒞^op pour p = ν » : sur ℕ, l'ordre opposé n'est pas bien fondé (0 < 1 < 2 < … est une chaîne strictement croissante infinie, donc strictement décroissante infinie dans 𝒞^op). Le côté coinductif ne demande pas une bien-fondation mais son dual : un *plus grand élément* absorbant la décrément (`∞ − 1 = ∞`), c'est-à-dire précisément ce que la clause exclut.
3. **La justification par [25] est un mésusage de la source.** L'issue Agda porte sur un type *à la fois inductif et coinductif* — le document le dit lui-même (« un assistant de preuve majeur admet une plus grande taille réflexive, et l'on y construit depuis dix ans un type à la fois inductif et coinductif dont se tire une preuve du type vide »). Le défaut est donc le **partage d'une sorte de taille entre les deux polarités**, pas l'existence d'un plus grand élément pour la polarité coinductive. Le document cite correctement le contenu de la source et en tire la mauvaise conclusion : il interdit ω globalement alors que la source incrimine le mélange.

**Nature :** **A** (bloquant) — c'est une contradiction entre une clause de bonne formation, deux règles de typage, une preuve, et quatre affirmations d'architecture.

**Pourquoi c'est réellement un problème :** la thèse de sédimentation (ch. 1, table 3) fait de la couche 2 le lieu des coalgèbres terminales `νF` et de la productivité. Si tout `ν` est de taille finie, la couche 2 ne contient que des processus finis, et : (i) le Th. 3 (emboîtement `νY.G(μX.F(X,Y))`) porte sur des objets finis, donc la « bonne définition de la sédimentation » ne couvre pas l'interaction qui perdure ; (ii) le Th. 22 (rejeu) quantifie sur un « historique d'exécution H » qui ne peut pas être infini ; (iii) les acteurs virtuels du §4.5, dont la réactivation est « une reprise de sa coalgèbre à l'endroit exact où elle s'était arrêtée », n'ont pas de coalgèbre typable au-delà de leur taille initiale ; (iv) le Th. 28 (fidélité) compare une source finie à une cible qui ne l'est pas.

**Ce qui reste valide :** tout. La clause est *exacte* pour le côté inductif, et son argument d'irréflexivité est juste : un μ de taille ω ne fonde rien. Le critère « porté par les types et non par la syntaxe » (R15, R18) reste le bon choix, et l'unification des deux garanties en un seul schéma (Th. 5) reste vraie *comme schéma*.

**Scénario de rupture minimal :** un flux d'événements d'interface (ch. 7 §7.1). Son type est `να.C⟨i⟩`. À quelle valeur de i l'écrire ? Toute valeur finie fixe un nombre maximal d'images ; `ω` est interdit. Le programme du cas d'usage I n'est donc pas typable.

**Correction minimale (une distinction, pas un mécanisme) :** introduire **deux sortes de tailles**, ce que le document possède déjà implicitement puisqu'il distingue deux polarités :
- `𝕊_μ = ℕ∞ ∖ {ω}` (taille inductive, ordre strict bien fondé, irréflexif) — pour FOLD/UNFOLD, les plis dépendamment typés, la hauteur de Trellis_fin ;
- `𝕊_ν = ℕ∞` **avec** un plus grand élément `∞` tel que `∞ + 1 = ∞` (taille coinductive, ordre dual co-bien-fondé) — pour OUT/COP.
Puis énoncer le Th. 5 comme un schéma à *deux* instances de sortes, et non comme un seul ordre lu deux fois : « en p = μ, la mesure décroît dans un ordre bien fondé ; en p = ν, la com mesure croît vers un plus grand élément absorbant ». La clause d'exclusion d'Agda devient alors : **les deux sortes sont disjointes et aucun type ne porte les deux** — ce qui est exactement la leçon de [25], et ce que le document savait déjà puisqu'il écrit que l'axe de polarité « ne court que sur deux des trois couches ».

**Conséquences interchapitres :** ch. 2 §2.3 (clause, Th. 4, Th. 5, RMQ 16), ch. 4 §4.2 (flux, StreamContext), §4.5 (acteurs virtuels, supervision, Th. 22, 24), ch. 7 §7.1, annexe E.1 (la clause « n < ω » de Trellis_fin — qui, elle, doit rester sur ℕ∞∖{ω}), E.3.4 (OUT/COP).

**Gain conceptuel éventuel :** la distinction des deux sortes de tailles répare aussi un point voisin que le document laisse flottant : la différence entre l'indice de taille d'un flux (une profondeur d'approximation) et le budget `β` (une allowance de coût). Les deux vivent aujourd'hui dans ℕ∞, avec des conventions arithmétiques différentes et non écrites (R-02). Deux sortes + une table d'arithmétique par sorte = une page, et trois ambiguïtés levées.

---

## [R-04] ℛ désigne deux structures incompatibles ; la multiplication scalaire des grades n'est pas définie sur deux de ses quatre facteurs

**Localisation :** chapitre 2 §2.2, p. 48 (« ℛ = (ℚ≥0 ∪ {ω}, +, ×, 0, 1, ≤) le semi-anneau ordonné des grades ») ; chapitre 2 §2.2, p. 53 (fragments = images de {1}, {0,1}, {ω}) ; chapitre 3 §3.1, p. 86-87 (table 6 : Lin = [1..1], Aff = [0..1], Rel = [1..ω], Unr = [0..ω] ; Th. 15) ; chapitre 3 §3.3, p. 108 (grade de présence = {0,1} = « exactement le sous-ensemble dont le chapitre 2 fait le fragment affine ») ; annexe E.1, p. 244 (`r ::= ⟨u, m, ℓ, β⟩ ∈ ℛ = ℕ∞ × {d ⪯ m} × ℒ × ℬ`) ; chapitre 1 §1.5, p. 39 (table normative : « ℛ semi-anneau ordonné des grades »).

**Énoncé actuel :** ℛ est, au chapitre 2, un **semi-anneau** de porteur ℚ≥0 ∪ {ω} — les rationnels positifs étant requis parce que « les capacités de lecture divisées du chapitre 3 en ont besoin ». ℛ est, à l'annexe E.1, un **produit à quatre facteurs** dont le premier est ℕ∞. Les fragments sont, au chapitre 2, les images de *singletons* ({1}, {0,1}, {ω}) ; au chapitre 3, ce sont des *intervalles* ([1..1], [0..1], [0..ω]) ; au chapitre 3 §3.3, le fragment affine redevient le singleton {0,1}.

**Diagnostic :** quatre défauts distincts qui ont une seule cause.

1. **Collision de ℛ.** ℚ≥0 ∪ {ω} et ℕ∞ × {d⪯m} × ℒ × ℬ ne sont pas la même structure, ne sont pas isomorphes, et n'ont pas les mêmes opérations. La table normative du §1.5 interdit cette divergence (« aucune section ultérieure n'introduit de variante locale ») et l'annexe E l'introduit.
2. **Les grades fractionnaires disparaissent du noyau formel.** Le porteur de l'annexe est ℕ∞ pour l'usage : `1/N` n'y est pas représentable. Or `1/N` est le mécanisme par lequel le chapitre 3 (p. 94-95) exprime N lecteurs simultanés d'une région (`ReadCap`), et le chapitre 4 (p. 127) la partition d'arène. La grammaire formelle exclut donc un mécanisme que la théorie des types déclare central. Le §2.2 avait prévenu : « restreint au sous-semi-anneau des entiers, ℛ est le type des conaturels ℕ∞ […] **La restriction est à prendre au mot et la suite s'en sert.** » La suite s'en sert en effet — en perdant les rationnels.
3. **Singletons contre intervalles, avec une conséquence de sûreté.** Sous la lecture intervalle, Aff = [0..1] contient 1/2, et la contraction `c_{r,s} : !^{r+s} ⇒ !^r ⊗ !^s` est instanciable avec r = s = 1/2 puisque r+s = 1 ∈ [0..1]. **Le fragment affine admet donc la contraction**, contrairement à la table 6 (« contraction interdite »), contrairement au §2.2 (« aucune contraction ne s'y instancie, la somme sortant de l'ensemble »), et contrairement à la table 3 (couche 2 = affine = affaiblissement seul). La preuve du Th. 15 est écrite pour les singletons (« Les contractables de Lin et de Aff forment l'ensemble vide, **aucun de 1 ni de 0** n'admettant la contraction ») alors que son énoncé porte sur les intervalles : l'énoncé et la preuve ne parlent pas du même objet.
4. **`r · Δ` et `0 · Δ` ne sont pas définis.** L'annexe (p. 246) pose : « r · Δ multiplie tous ses grades par r », « 0 · Δ1 = 0 · Δ2 » est la condition d'addition, et VAR exige `0 · Δ, x:^1 V`. Sur le facteur usage (ℕ∞ ou ℚ≥0) la multiplication existe. Sur le facteur budget elle existe (avec R-02). **Sur le facteur monotonie {d ⪯ m} et sur le facteur niveau ℒ, il n'y a pas de multiplication scalaire** : ce sont des ordres, pas des modules. Que vaut `ω · m` ? Que vaut `0 · ℓ` ? Le §2.4 (p. 71) affirme que « les lois de comonade graduée y passent parce que chaque coordonnée les satisfait et que les opérations sont définies coordonnée par coordonnée » : c'est faux pour deux coordonnées sur quatre, qui ne satisfont pas les lois d'un module sur le semi-anneau d'usage. Le §1.4 (p. 21) donne bien trois conditions pour ajouter une composante (« structure ordonnée ; opérations sur chaque facteur séparément ; l'une des trois strates »), mais *ordonnée* ne suffit pas : il faut une action du semi-anneau, et ℒ n'en a pas.

**Nature :** **A** pour (1)-(3) (deux définitions d'un objet primitif, et une conséquence de sûreté), **B** pour (4).

**Pourquoi c'est réellement un problème :** ℛ est l'objet le plus utilisé du document. Il intervient dans : la définition des fragments donc des couches donc des délimiteurs donc de ERR-TOP-001 ; la règle VAR (via `0·Δ`) ; BOX/APP/VECI/SC (via `r·Δ`) ; le sous-typage ≼ (table 20, produit mixte) ; la cohérence de la subsomption (Th. 39, qui exige des jointures composante par composante) ; le Th. 1 ; le Th. 15 ; Trellis_fin ; le grade de présence. Deux définitions incompatibles d'un tel objet ne sont pas une imprécision : elles rendent indécidable la lecture de la moitié des règles.

**Ce qui reste valide :** les deux définitions sont *individuellement* correctes et chacune sert un usage réel. ℚ≥0 ∪ {ω} est le bon objet pour l'axe d'usage (grades fractionnaires, zéro-somme, zéro-produit, ℕ∞ comme sous-objet bien fondé). Le produit à quatre facteurs est le bon objet pour la discipline de sous-typage mixte et pour la relation logique (qui n'inspecte que la troisième composante). La lecture *intervalle* est la bonne pour les modalités (une modalité dit ce qu'une ressource *peut* subir, et l'argument du §3.1 contre `Unr = {ω}` est juste et bien vu). La lecture *singleton* est la bonne pour les fragments catégoriques `𝒞_{!S}` du §2.2.

**Correction minimale (un renommage, aucune structure nouvelle) :**
- `𝕌 := ℚ≥0 ∪ {ω}` — semi-anneau d'usage (le ℛ du chapitre 2). On y garde : zéro-somme, zéro-produit, ℕ∞ ⊂ 𝕌 comme seul fragment bien fondé, les intervalles [1..1], [0..1], [1..ω], [0..ω] comme modalités, les singletons {1}, {0,1}, {ω} comme *fragments catégoriques*.
- `ℛ := 𝕌 × 𝕄 × ℒ × 𝔅` — algèbre des grades (le ℛ de l'annexe), avec 𝔅 = ℕ∞ muni de `⊖` (R-02). **Écrire `𝔅` et non `ℬ`** : `ℬ` n'est pas dans la table normative et, lu comme booléens, il contredit `β ⊖ k`, « la valeur permissive du budget est l'infini » (§1.4, p. 22) et toute l'arithmétique du Th. 1.
- Définir explicitement : un **mode** est un sous-ensemble de ℛ de la forme `π_𝕌^{-1}(I) × 𝕄 × ℒ × 𝔅` pour un intervalle I de 𝕌. Les fragments catégoriques du §2.2 deviennent `𝒞_{!π_𝕌^{-1}(S)}`. Les deux lectures (singleton et intervalle) coexistent alors sans conflit : les singletons sont les *fragments logiques* (ce qui est instanciable en règles structurelles), les intervalles sont les *modalités de type* (ce qu'une ressource peut subir), et la table 6 doit dire laquelle des deux elle donne — aujourd'hui elle donne les intervalles sous le nom de modalités et les utilise comme fragments.
- Définir l'action scalaire : `r · ⟨u,m,ℓ,β⟩ = ⟨u_r·u, m, ℓ, β⟩` — **identité sur la monotonie et sur le niveau**, multiplication sur l'usage et le budget. Puis vérifier que cette action est celle dont VAR, BOX, APP, VECI, SC ont besoin, et l'écrire comme une clause de la définition de ℛ, pas comme un implicite.
- Écrire la table d'arithmétique de 𝕌 (0·ω, ω·0, ω+ω, ω·ω) et de 𝔅 (R-02).

**Conséquences interchapitres :** ch. 1 §1.4 (quatre composantes du grade, élision, table 2), §1.5 (table normative : la ligne « ℛ » doit être scindée en deux), ch. 2 §2.2 (tout), §2.4 (produit de structures ordonnées), ch. 3 §3.1 (table 6, Th. 15, ReadCap 1/N), §3.3 (grade de présence), annexe E.1 (grammaire), E.3 (conventions `r·Δ`, `0·Δ`), E.3.3 (produit mixte, Th. 39), E.4.3 (relation logique).

**Gain conceptuel éventuel :** ce renommage absorbe quatre symptômes d'un coup (collision de ℛ, singleton/intervalle, grades fractionnaires manquants, action scalaire indéfinie) et rend mécanisable la clause que le document réclame sans la posséder : « une composante de grade doit être une structure ordonnée » devient « une composante est soit un facteur de module sur 𝕌 (usage, budget), soit un facteur d'ordre pur (monotonie, niveau), et l'action scalaire est triviale sur les seconds ». C'est une condition vérifiable par machine sur toute extension future — donc exactement ce que la condition de clôture du §1.4 cherchait sans l'obtenir.

---

## [R-05] Le niveau d'un calcul est invoqué par cinq démonstrations et n'est produit par aucune règle ; son lieu naturel — les deux règles de formation de contexte — est vide

**Localisation :** annexe E.3, p. 248 (règle TICK : `0 ⊢ tick : F_1 1 ∣ ⟨1,1⟩`) ; E.4, p. 265 (réduction : `⟨tick ∣ μ ∣ τ⟩ ⟶ ⟨return () ∣ μ ∣ τ·⟨1,δ_ℓ⟩⟩`, « ℓ étant le niveau du calcul ») ; E.4, p. 266 (Th. 43 : « Le cas de tick en est l'instance où ε = ⟨1,δ_ℓ⟩ ») ; E.4.2, p. 270 (Th. 46 : « l'argument suppose l'étiquetage effectif de chaque opération par le niveau du calcul qui la produit ») ; E.4.4, p. 272 (Th. 47 : « dont la composante temporelle est comptée au niveau du calcul qui la produit ») ; E.5.2, p. 277 (assignation de sortes : « ℓ est le niveau de ses événements ») ; E.5.4, p. 279 (Th. 51 : « le calcul qui produit l'effet étant de niveau ℓ, tout ce qu'il possède l'est aussi ») ; E.5.6, p. 280 (incertitude 1) ; chapitre 1 §1.4, p. 24-26 (table 2 : « niveau ℓ → étiquetage par ℓ » sur les deux composantes de l'effet).

**Énoncé actuel :** le niveau ℓ étiquette l'effet sur ses deux composantes ; un calcul de niveau ℓ produit un effet observable au niveau ℓ ; c'est « là que la preuve de non-interférence devra travailler » (§1.4, p. 26). L'annexe déclare que cet étiquetage « n'est pas une hypothèse ajoutée mais la structure de ℰ » (§E.4.2, p. 270). Le §E.5.6 classe la question en incertitude n° 1 : « Le niveau d'un effet ne doit dépendre du grade que par φ. […] C'est la dette réelle de cette construction, et la seule qui touche l'axiome. »

**Diagnostic :** l'incertitude n° 1 est correctement identifiée mais **sous-évaluée dans sa nature**. Ce n'est pas « une vérification à conduire » sur une fonction déjà définie : c'est une **fonction qui n'existe pas**. Concrètement :
1. La règle TICK conclut l'effet `⟨1,1⟩`. Or par E.1, un effet est `⟨φ, κ⟩ ∈ ℰ₀ × ℕ∞^ℒ` : la seconde composante est une **famille indexée par les niveaux**, pas un nombre. `⟨1,1⟩` n'est pas un effet bien formé. Le Th. 37 (p. 245) donne la bonne forme : `k ↦ k δ_ℓ`. La règle devrait conclure `⟨1, δ_ℓ⟩` — pour un ℓ que la règle ne peut pas déterminer, puisque sa prémisse est le contexte `0` (tous grades annulés, donc composante de niveau annulée elle aussi, cf. R-04).
2. La réduction, la preuve du Th. 43, celle du Th. 46, celle du Th. 47 et celle du Th. 51 utilisent toutes `δ_ℓ` avec « ℓ = niveau du calcul ». **Aucune règle du §E.3 ne calcule, ne transporte ni ne borne le niveau d'un calcul.** OP prend ε tel quel ; APP compose `ε₀ · ε` sans condition de niveau ; CASE exige le même ε dans toutes les branches mais n'impose rien sur les niveaux ; BOX/UNBOX ne relient pas `niv(r)` au niveau du calcul enclos ; SUB permet `ε ⊑ ε'` sans condition de niveau.
3. Il en résulte que la propriété dont tout dépend — *un calcul de niveau ℓ ne peut produire un tick qu'au niveau ℓ, et ne peut inspecter que des valeurs de niveau ≤ ℓ* — n'est ni une règle, ni un lemme, ni une hypothèse nommée. Elle est invoquée comme un fait (« tout ce qu'il possède l'est aussi », Th. 51).
4. **Son lieu d'énonciation existe et est vide** : le §E.1 (p. 244) compte parmi les 39 règles « les deux règles structurelles de formation de contexte », qui ne sont imprimées nulle part (§E.3, p. 246 : « Les règles structurelles se réduisent à une seule »). C'est dans une formation de contexte que se déclare le niveau courant d'une dérivation, exactement comme dans les systèmes à étiquette flottante.

**Nature :** **A** (bloquant) pour l'axe confidentialité ; **B** pour la forme du jugement.

**Pourquoi c'est réellement un problème :** quatre énoncés dépendent de cette fonction absente, et ce sont les quatre énoncés de l'axe confidentialité — déclaré « Construit, non éprouvé » au §1.1, ce qui est exact mais euphémique : il n'est pas non éprouvé, il est non *énonçable*. De plus, l'assignation de sortes du §E.5.2 (`⟨prog, ℓ⟩`, `⟨operation_a, ℓ⟩`, `⟨temps, ℓ⟩`) dépend du niveau des événements, donc de la même fonction ; le Th. 51 (confinement) en dépend ; la clause de session de la relation logique (§E.5.5, première ligne : « un canal créé par un calcul de niveau ℓ′ ⋢ ℓ ») en dépend. Une seule fonction manquante suspend donc six énoncés, dont deux (Th. 47, Th. 51) sont ceux que le §E.6 déclare démontrés.

**Ce qui reste valide :** l'architecture est juste et je la valide. (i) Loger le niveau dans le grade et non dans une contrainte de valeur (§3.2, p. 99) est le bon choix, et l'argument (« un raffinement se décharge au cas par cas quand un grade se propage par les règles ») est exactement le bon. (ii) La famille temporelle `κ ∈ ℕ∞^ℒ` plutôt qu'un ℕ∞ nu est une correction réelle et bien motivée (Th. 37). (iii) La distinction `π†` (conservatrice, garde le temps) / `π_ℓ` (observationnelle, retire le temps effacé) est un résultat de conception fort : c'est elle qui ferme le canal temporel, et le document a raison d'y insister. (iv) La clause `ℛ_ℓ⟦!^r V⟧` (relation totale au-dessus de ℓ) est la bonne clause, et son économie (une seule clause décide, les autres propagent) est réelle.

**Contre-exemple / scénario de rupture :** soit un calcul qui lit une valeur `!^{⟨1,d,secret,0⟩} V` et produit un tick. Par SUB/SUBBOX et les règles imprimées, rien n'empêche ce calcul d'être *par ailleurs* de niveau public : aucun jugement ne porte son niveau, donc aucun tick ne sera étiqueté `secret`, donc `π_public(τ)` conservera ce tick, donc le nombre de ticks — dépendant du secret — est observable au niveau public. Le canal temporel que le §E.4.4 déclare fermé (« L'égalité des traces est ce qui ferme le canal temporel ») est ouvert, et il est ouvert *par absence de règle*, non par erreur de preuve. Que ce calcul soit dérivable ou non dépend d'une règle qui n'existe pas : c'est précisément le problème.

**Correction minimale (une indexation, pas une composante) :** le document possède déjà le bon précédent — 𝒢 est un **indice** du jugement et non une composante (§1.4, p. 18 : « L'indice 𝒢 n'est pas une composante du jugement […] C'est un paramètre du système, non une donnée du jugement »). Faire de même pour le niveau courant :
$$\Delta \vdash^{\ell}_{\mathcal G} c : C \mid \varepsilon$$
avec, dans les deux règles de formation de contexte à écrire :
- `⊢^ℓ ∅` et `Δ, x :_r V` formé si `Δ` formé (le niveau d'une **liaison** reste `niv(r)` ; le niveau du **contexte** est `⊔ niv(r)` sur les liaisons effectivement employées) ;
- VAR : `ℓ ⊒ niv(r)` ;
- OP : l'opération déclare son niveau `a`, et `ℓ ⊒ a` ;
- APP/LET/CASE/SC/VECE : `ℓ` de la conclusion est la jointure des `ℓ` des prémisses (c'est l'étiquette flottante) ;
- BOX : `ℓ ⊒ niv(r)` ; SUB : inchangé sur ℓ ;
- TICK devient : `Δ ⊢^ℓ tick : F_1 1 ∣ ⟨1, δ_ℓ⟩`.
Cela répond simultanément à l'incertitude n° 3 du §E.5.6 (« Un seul niveau par processus. La littérature du domaine en emploie deux — une habilitation et un niveau courant ») : l'habilitation est `niv(r)` sur les liaisons, le niveau courant est l'indice ℓ de la dérivation, et la jointure est la règle de propagation. Le document se demande si « la stratification en couches en tient lieu » : non, et il n'y a pas à le supposer — la réponse est deux objets de natures différentes, l'un sur les liaisons, l'autre sur les dérivations.

**Conséquences interchapitres :** ch. 1 §1.4 (table 2, cellule niveau/temps), ch. 2 §2.4 (Th. 7, Th. 10, la dualité confidentialité/intégrité), ch. 3 §3.2 (règle 10 de déclassification), annexe E.1 (grammaire de ℰ), E.3 (six règles), E.4 (Th. 43, 46), E.4.3-E.4.5 (Th. 47, non-interférence, divulgation), E.5.2-E.5.5 (sortes, Th. 51, clause de session).

**Gain conceptuel éventuel :** l'indice ℓ unifie trois objets que le document traite séparément : le niveau du grade (coeffet), le niveau de la famille temporelle (effet), et la sorte du canal du métalangage (`⟨g, ℓ⟩`). Ce sont les trois images d'une même quantité le long des trois niveaux (contexte → trace → cible). Une fois l'indice posé, le §E.5.2 n'a plus à justifier que « le niveau porté par la sorte est celui de l'effet, non celui du grade » par un argument ad hoc : c'est la même fonction, lue avant et après effacement. Et l'incertitude n° 1 du §E.5.6 se transforme en un lemme court : *le niveau d'un effet ne dépend du grade que par φ* devient *niv est constant le long des fibres de ⟦·⟧*, ce qui est exactement ce qu'un système de raffinement doit préserver.

---

## [R-06] Un seul environnement normatif (« Théorème ») pour sept natures épistémiques ; aucun registre unique des obligations ; quatre statuts incompatibles pour le Th. 27

**Localisation :** tout le document. 51 « Théorème n », chacun avec une « Déclaration n », une « Esquisse de preuve » et un « □ ». Zéro environnement Définition, Lemme, Axiome, Proposition, Corollaire, Conjecture (les deux occurrences de « Définition » sont « la Définition de Standard ML »). Registres d'ouverture : ch. 1 §1.1 (trois maturités), ch. 1 table 1 (huit engagements, trois routes), annexe E intro p. 243 (« Cinq travaux ouverts »), §E.4.4 p. 273 (« l'énoncé honnête »), §E.5.6 p. 280 (« Quatre points restent ouverts »), §E.6 p. 281 (« Ce que chaque preuve ouverte y puise »). Identifiants non résolus : T-06, T-42, T-43 (a)-(c), T-44 (i)-(ii), G.1, G.3, « l'annexe de chantier » (absente du PDF).

**Énoncé actuel :** « Un théorème est démontré ou esquissé, dans un environnement nommé, sa réserve écrite dans l'esquisse » (§1.2, p. 6).

**Diagnostic :** la convention est explicite et assumée ; elle n'en est pas moins la cause du défaut de traçabilité le plus grave du document, parce qu'elle **fusionne dans un même mot, une même numérotation et un même symbole □ des natures qui ne se valent pas**. Inventaire, vérifié énoncé par énoncé :

| Nature réelle | Exemples | Ce que l'environnement dit |
|---|---|---|
| Th. démontré par argument standard | 11, 12, 13, 38, 40, 42, 50 | Théorème ✓ |
| Th. démontré modulo une hypothèse nommée | 2, 4, 5, 8, 41, 43, 44, 49 | Théorème ✓ (hypothèse dans l'esquisse) |
| Résultat de littérature ré-énoncé | 6 (Uustalu–Vene), 13, 15 (Hanukaev–Eades), 37, 40 | Théorème (la part propre n'est pas isolée) |
| **Conjecture explicite** | 10 (« L'esquisse ne conduit pas la preuve, et trois points y résisteraient »), 36 (« **Ce théorème n'est pas démontré** »), 7 (« ce document […] n'en conduit pas la preuve pour K7PL »), 27 (« n'en donne qu'une esquisse ») | Théorème + □ |
| **Définition / stipulation** | 31 (quantifie sur `Sens`, jamais défini), 34 (« L'énoncé ne se démontre pas, il se montre »), 37 (isomorphisme par restriction) | Théorème + □ |
| **Propriété d'implémentation** | 16 (le vérificateur implante les règles), 18 (NaN IEEE 754, masquage SIMD), 20 (Arrow/Cap'n Proto/MLIR), 25 (anneau SPSC, échange de pointeurs), 33 (budget de spécialisation), 35 (déterminisme de l'outil) | Théorème + □ |
| **Exigence sur un tiers** | 26 seconde clause (l'hôte ne retient pas la capacité) — que RMQ 30 retire immédiatement | Théorème + □ |

Le défaut devient bloquant quand le **statut d'un même énoncé varie selon le chapitre**, ce qui est le cas du résultat le plus chargé du document :

| Lieu | Statut affirmé du Th. 27 |
|---|---|
| ch. 1, table 1, p. 7 | « Le théorème 27, **démontré à l'annexe** » ; engagement de fidélité « **levé** », route « démonstration (levée) » |
| ch. 2, note de bas de page p. 76 | « le théorème 27, dont **l'induction n'est qu'esquissée**. Tant qu'elle n'est pas conduite, ce théorème [9] hérite de la même réserve » |
| ch. 4 §4.6, p. 155 | « ce que le théorème 27 énonce et **n'établit qu'en esquisse** » |
| ch. 6 §6.3, p. 210 | « Cette dette-là **reste ouverte** […] le théorème 27 l'énonce et n'en donne qu'une esquisse » |
| annexe E, intro p. 243 | « Ce qui reste ouvert […] **la préservation du typage par la traduction** » |
| annexe E §E.4.6, p. 276 | « **Le théorème 27 est donc démontré**, et la dette de fidélité […] est acquittée » |
| annexe E §E.6, p. 281 | « est démontrée (§E.4.6) » |

Sept mentions, **trois statuts incompatibles**, dont deux à l'intérieur de la même annexe (intro p. 243 contre §E.4.6 p. 276). Et le §E.5.5 (p. 280) contredit de la même manière le §E.4.4 (p. 273) sur la non-interférence : « l'énoncé honnête est donc celui-ci. La non-interférence graduée est démontrée pour le fragment sans communication » (E.4.4) contre « La non-interférence graduée et la divulgation délimitée cessent donc d'être bornées au fragment sans communication » (E.5.5), sans qu'aucune induction nouvelle ne soit conduite entre les deux.

Le même défaut de registre produit des **dépendances non résolues** : le Th. 9 (structure de raffinement) est fondé sur le Th. 27 (antériorité inversée : ch. 2 utilise un résultat du ch. 4) ; le cas (a) de l'induction du §E.4.6 repose sur « le foncteur d'effacement de **T-06** » ; la clause de session porte « **T-44 (ii)** » ; la relation logique est « l'économie que la clôture de **T-42** avait annoncée » ; « La grammaire de **G.1** » et « appartiennent à **G.3** » renvoient à une lettre d'annexe qui n'existe plus. Le lecteur ne peut pas vérifier la chaîne.

Enfin, le compte des travaux ouverts n'est jamais le même : « quatre preuves ouvertes » (ch. 1, p. 6), « Cinq travaux ouverts » (annexe E, p. 243), « trois preuves » (§E.6), « Quatre points restent ouverts » (§E.5.6), huit engagements dont un « anomalie » (table 1).

**Nature :** **B** (structurel) — le contenu n'est pas faux, la *forme* empêche de savoir ce qui est établi.

**Pourquoi c'est réellement un problème :** le document revendique la mécanisabilité (« La transcription en assistant de preuve portera donc ces deux points comme hypothèses de module », p. 267 ; « Le croisement est vérifié mécaniquement », p. 244 ; « un document dont les règles doivent se vérifier par machine », p. 48). Or une mécanisation exige exactement ce que l'environnement unique interdit : savoir, pour chaque énoncé, s'il est un `Theorem`, un `Axiom`, une `Definition`, une `Hypothesis` de module ou une `Conjecture`. Le patron « S'il tient / S'il tombe », qui est une excellente idée d'analyse d'impact, a pour effet pervers de transformer 51 énoncés en 51 conditionnelles dont aucune n'est déchargée : l'état épistémique réel du document est « 51 conjectures avec analyse d'impact », et rien dans la typographie ne le dit.

**Ce qui reste valide :** l'exigence du §1.2 est la bonne (« aucun de ces sept mots n'apparaît ⟹ l'énoncé est une conséquence de ce qui précède ») ; la table 1 avec ses trois routes (littérature / démonstration / mesure) est un dispositif que je n'ai vu nulle part ailleurs et qui devrait être conservé et étendu ; RMQ 2 (« un engagement sans route nommée est une anomalie ») est la bonne règle ; le §E.6 (« la traçabilité doit être explicite pour que son achèvement soit mesurable ») est la bonne intention.

**Correction minimale (typographique, donc la moins coûteuse de toutes) :**
1. Remplacer l'environnement unique par **quatre** environnements, sans changer un mot des contenus : `DÉFINITION`, `THÉORÈME` (démontré), `PROPOSITION` (esquissée, réserve écrite), `EXIGENCE` (contrainte sur l'implémentation ou l'environnement, non démontrable ici). Ajouter un **sceau de niveau** à chaque énoncé : ⟨langage | compilation | représentation | déploiement⟩. Le Th. 20 devient « PROPOSITION ⟨représentation⟩ », le Th. 26 devient deux énoncés (THÉORÈME ⟨langage⟩ pour la clause 1, EXIGENCE ⟨représentation⟩ pour la clause 2), le Th. 34 devient DÉFINITION, le Th. 31 devient DÉFINITION, le Th. 36 devient PROPOSITION non démontrée.
2. **Un registre unique des obligations**, en annexe, avec identifiants stables (O-01…O-nn), chaque entrée portant : énoncé, niveau, dépendances (théorèmes qui en dépendent), route (littérature/démonstration/mesure), statut. Les T-06/T-42/T-43/T-44 et G.1/G.3 y sont résolus ou supprimés. La table 1 devient une vue de ce registre, non une liste parallèle.
3. **Une règle de propagation**, écrite au §1.2 : « tout changement de statut d'un énoncé est propagé à toutes ses mentions ; une mention non propagée est une erreur du document, pas une nuance. » Le document a déjà cette règle implicitement (« un document qui ne relit pas ses engagements finit par s'accuser de dettes qu'il a payées », p. 8) : il faut la rendre contraignante et l'appliquer au Th. 27.

**Conséquences interchapitres :** toutes. C'est la correction la plus transversale de cette revue.

**Gain conceptuel éventuel :** elle rend le document *auditable*, c'est-à-dire qu'elle transforme une lecture de 285 pages en une vérification de ~51 fiches. Elle permet aussi de mesurer honnêtement le noyau acquis : à mon décompte, sur 51 énoncés, 8 sont démontrés sans réserve, 12 sont démontrés sous hypothèse nommée et vérifiable, 9 sont des résultats de littérature correctement ré-énoncés, 11 sont des propriétés d'implémentation ou d'environnement, 6 sont des définitions ou stipulations, et 5 sont des conjectures dont le document dit qu'elles le sont. **Ce compte n'est nulle part dans le document, et c'est le premier service que cette correction lui rendrait.**

---

## [R-07] La couche 2 est asynchrone au chapitre 3, synchrone dans le noyau formel, et SPSC au chapitre 4

**Localisation :** chapitre 3 §3.2, p. 104 (« les sessions de K7PL sont asynchrones. Un Send dépose dans une boîte aux lettres et rend la main ; un Recv bloque sur une boîte vide ») ; annexe E.1-E.3 (aucune boîte aux lettres, aucune forme d'envoi, `APP` = β-rédex synchrone) ; chapitre 4 §4.5, p. 143 (Th. 25 : « La boîte aux lettres est un multi-ensemble de ressources linéaires stocké dans un **anneau SPSC** ») ; chapitre 4 §4.5, p. 134 (Disruptor : « un compteur 64 bits, incrémenté par le producteur et sondé par le consommateur »).

**Énoncé actuel :** trois descriptions du même mécanisme, à trois niveaux, qui ne se recouvrent pas.

**Diagnostic :**
1. **Asynchrone contre synchrone.** L'encodage des protocoles en implications linéaires imbriquées (ch. 3 §3.2, p. 102) donne une communication *synchrone* : dans l'interprétation propositions-comme-sessions d'un λ-calcul séquentiel, `x : A ⊸ B` côté fournisseur est « recevoir A puis fournir B », et l'application est un rendez-vous. Le document sait que l'écart est sémantique (« L'écart entre les deux régimes n'est pas une nuance d'implémentation : c'est un écart sémantique, dont le franchissement demande un encodage explicite par protocoles d'appel-retour », p. 104) — mais il déclare cet encodage pour le *passage de l'asynchrone au synchrone*, alors que le noyau formel ne contient que le synchrone et que le chapitre 3 déclare l'asynchrone. L'encodage requis est donc dans l'autre sens, et il n'est pas donné.
2. **SPSC contre multi-producteurs.** Un anneau SPSC (single-producer single-consumer) ne peut pas être la boîte aux lettres d'un acteur, qui reçoit de plusieurs émetteurs. Ou bien il y a un anneau par couple (émetteur, récepteur) — et alors la boîte aux lettres `M` du Th. 25 est une *famille* d'anneaux, et `M(x) ≠ ∅ ∧ M(y) ≠ ∅` porte sur deux anneaux distincts ; ou bien l'anneau est MPSC, et le mot SPSC est une erreur. Dans les deux cas, l'atomicité affirmée (« la réduction consomme les deux messages simultanément par échange atomique de pointeurs ») n'est pas établie : un échange atomique de pointeurs porte sur un mot, pas sur deux anneaux indépendants. C'est le problème classique de la consommation multi-places d'un motif de jonction, et il demande soit un verrou, soit une séquence CAS avec reprise, soit une file de jonction dédiée (c'est la solution du join-calculus de Fournet–Gonthier, que le document cite par ailleurs [60]).
3. **Le Th. 25 est un énoncé mixte.** `M(x) ≠ ∅ ∧ M(y) ≠ ∅ ⟺ M --J--> P` : la direction ⟸ suppose l'ordonnancement (l'acteur doit être activé), la disjonction des motifs (ch. 1, p. 12 : « en exigeant des motifs qu'ils soient deux à deux disjoints en plus d'être exhaustifs »), et l'absence de concurrence sur `M`. La direction ⟹ suppose que rien d'autre ne consomme x et y entre-temps. Ni l'une ni l'autre n'est dans l'esquisse, qui ne traite que le mécanisme d'abaissement.

**Nature :** **B** (structurel) avec composante **C** (le « si et seulement si »).

**Ce qui reste valide :** RMQ 29 est excellente et je la valide sans réserve : « K7PL revendique donc l'atomicité locale et non la localité » — la distinction entre atomicité d'une transition et localité au sens de Herlihy–Wing est exactement le piège, et le document l'évite. Le choix de la partition disjointe+exhaustive pour supprimer le choix non déterministe des jonctions (ch. 1, p. 12) est juste et bien argumenté (« une source retirée par construction vaut mieux qu'une source consignée »). Le rapprochement avec les réseaux de Petri colorés [17, 18] est pertinent.

**Correction minimale :** (i) remplacer « SPSC » par la structure réelle — soit « un anneau par couple (émetteur, récepteur), et une file de jonction par acteur pour l'appariement atomique », soit « MPSC » — et écrire le protocole d'appariement en trois lignes ; (ii) restreindre le Th. 25 en `⟸` sous hypothèse d'activation et de partition, et en `⟹` sous hypothèse d'absence de consommation concurrente, ou mieux : énoncer une seule direction, celle dont l'architecture a besoin (⟹ : la présence simultanée suffit à déclencher), l'autre relevant de l'ordonnanceur ; (iii) dire une fois, au §3.2, que le noyau formel est synchrone et que l'asynchronie est une propriété de la couche d'abaissement, avec l'encodage d'appel-retour cité comme la voie.

**Conséquences interchapitres :** ch. 3 §3.2 (Th. 17, l'hypothèse d'acyclicité), ch. 4 §4.5 (anneaux, Disruptor, Th. 25, équité mémoire [30]), ch. 6 (abaissement), annexe E (si l'on choisit la voie 2 de R-01).

**Gain conceptuel éventuel :** modeste, mais il y en a un : la file de jonction et la boîte aux lettres sont le même objet — un multi-ensemble de ressources linéaires indexé par canal, avec une règle de consommation atomique multi-places. Le nommer une fois (`Mailbox = Σ_{c∈Chan} Bag(Cap(c))`) permet d'énoncer le Th. 25, le circuit breaker de session (comparaison de tag), la ré-invocation séquentielle d'un grade fini et la traduction `!x(y).P` comme quatre lectures d'un seul objet. C'est exactement le type de factorisation que le §1.4 réclame.

---

## [R-08] La trace τ est à la fois une grandeur de coût à optimiser et un observable de sûreté à préserver exactement ; aucun invariant de préservation n'est déclaré pour les passes

**Localisation :** annexe E.4, p. 265 (τ « mot de la quantale accumulant ce qui a été produit ») ; E.4, p. 266 (Th. 43 : `τ' · ε' ⊑ τ · ε`) ; E.4.3, p. 271 (clause de calcul : `π_ℓ(τ) = π_ℓ(τ')`) ; E.4.6, p. 275-276 (à propos de `fix` : « Une sortie anticipée rendrait la durée de fix f dépendante de la donnée sur laquelle il itère, donc observable. C'est le canal temporel que la projection observationnelle et le théorème 47 ferment. Itérer jusqu'au bout […] c'est ce que la non-interférence exige ») ; chapitre 6 §6.1, p. 200-201 (quatre familles de réécritures : déforestation, fusion de boucles, saturation par égalité, défonctionnalisation, inlining, projections de Futamura) ; chapitre 6 §6.3, p. 209-210 ; chapitre 4 §4.5, p. 137 (évaluation semi-naïve « ce qui rend le dispositif praticable ») ; chapitre 1 P1, p. 10 (« toute optimisation admise […] est accompagnée d'un morphisme de correction sémantique dans C »).

**Énoncé actuel :** d'un côté, la non-interférence exige que la trace projetée `π_ℓ(τ)` soit identique entre deux exécutions, et le §E.4.6 en tire qu'une optimisation qui change la *durée* ouvre un canal temporel. De l'autre, P1 autorise toute optimisation accompagnée d'un morphisme de correction **sémantique**, et le chapitre 6 en liste six familles dont chacune modifie le nombre de pas.

**Diagnostic :** le document ne déclare nulle part **ce qu'une passe doit préserver**. Trois candidats coexistent sans être distingués :
1. la dénotation (P1, ch. 2 §2.4 : curry/uncurry, monomorphisation, isomorphisme de Yoneda) ;
2. le jugement gradué (Th. 36, explicitement non démontré) ;
3. la trace, ou la trace projetée (Th. 47, §E.4.6).

Or ces trois invariants ne sont pas comparables, et le §E.4.6 le montre lui-même sans en tirer la règle : si la durée est observable au niveau ℓ, alors la fusion de boucles, la déforestation et l'inlining — qui changent le nombre de ticks — **ne sont pas admissibles** dans du code où la non-interférence temporelle est revendiquée. Réciproquement, si l'on exige `fix f` itéré exactement h fois (h = hauteur du type) pour ne pas rendre la durée dépendante de la donnée, alors l'évaluation semi-naïve que le §4.5 déclare indispensable au caractère praticable de l'extension déductive est interdite. Le §E.4.6 tente de dissoudre le conflit (« la traduction, elle, interprète la dénotation […] confondre les deux niveaux ferait porter à la traduction une charge qui appartient au compilateur ») — mais c'est précisément le problème : si la charge appartient au compilateur, alors le compilateur modifie la durée, et la durée est un observable de sûreté.

**Nature :** **B** (structurel).

**Pourquoi c'est réellement un problème :** c'est un conflit entre deux des quatre postulats, pas une imprécision. P3 veut que le coût soit dit et minimisé (donc optimisé) ; la composante de niveau du grade veut que le coût ne divulgue rien (donc fixé). Le document a les deux, et n'a pas l'arbitrage. Et le conflit est *chiffrable* : un `fix f` sur un treillis de hauteur h = |support| coûte h itérations au lieu de 3 ou 4 en pratique ; sur un univers de constantes de taille 10⁶, c'est un facteur 10⁵ payé au nom de la non-interférence. Le document le dit (« la différence n'est pas un gaspillage à corriger — elle est le prix de la prédictibilité, et le document le paie sciemment »), ce qui est honnête, mais il ne dit pas que le même prix s'applique alors à *toute* optimisation, et que le chapitre 6 optimise.

**Ce qui reste valide :** l'analyse en potentiel du Th. 43 est correcte et élégante : `τ · ε` décroissant, avec la lecture « le potentiel est transféré de l'annotation vers la trace, non consommé ». L'identification du budget comme potentiel, des contraintes de valeur comme raffinements, et de la quatrième condition (non-duplication d'un porteur de potentiel) comme conséquence de la stratification est un très bon résultat — c'est le §E.4, p. 267, et il tient. La distinction « mesure contre borne » (§E.3.2, p. 257-258) est juste et bien argumentée, avec le contre-exemple `once`.

**Correction minimale (une déclaration, trois lemmes) :** déclarer au chapitre 6 un **ordre de préservation** sur les passes, en trois niveaux :
- **P-dén** : préserver la dénotation dans C. Toutes les passes.
- **P-grad** : préserver le jugement gradué (Th. 36). Passes d'abaissement.
- **P-trace(ℓ)** : préserver `π_ℓ(τ)`. Uniquement les unités marquées `ℓ`-sensibles.
Puis écrire la règle d'interaction : *une unité marquée ℓ-sensible n'admet que les passes P-trace(ℓ)*. Cela donne : (a) `fix f` itéré h fois dans le code ℓ-sensible, semi-naïf ailleurs ; (b) fusion de boucles et déforestation admises partout sauf dans le code ℓ-sensible ; (c) le chapitre 6 retrouve sa liberté, et le §E.4.6 sa contrainte, sans contradiction. Coût : une définition, une règle, trois lemmes de compatibilité (un par famille de réécriture). Aucun mécanisme nouveau — le marquage ℓ-sensible est la composante de niveau que le document possède déjà.

**Conséquences interchapitres :** ch. 1 P1 et P3, ch. 4 §4.5 (semi-naïf), ch. 6 §6.1 (toutes les passes), annexe E.4 (Th. 43), E.4.3 (clause de calcul), E.4.6 (remarque sur `fix`).

**Gain conceptuel éventuel :** cette déclaration absorbe trois dettes distinctes : le Th. 36 (non démontré) devient « P-grad est l'obligation de chaque passe », ce qui est la forme sous laquelle il est mécanisable passe par passe ; la réserve du §E.4.6 devient une clause du marquage ; et l'engagement « la reproductibilité de la compilation — visée, non garantie » (table 1) reçoit un critère : reproductible = toute passe appliquée est déterministe *et* P-trace(ℓ) est respectée pour le ℓ du binaire.

---

## [R-09] Le pipeline n'a pas de Phase 0, « élaboration » y désigne deux opérations différentes, et le Th. 35 suppose une inférence principale explicitement abandonnée

**Localisation :** chapitre 6 §6.1, p. 191 (figure 11 : Phase 1 Parse, 1.5 ConfigAnalysis, 2 TypeCheck, 2.5 Élaboration, 3 PurityCheck, 4 TermProof, 5 ConstraintSolve, 6 Optimize, 7 CodeGen, 8 Link) ; §6.2, p. 198 (Th. 35) ; §6.3, p. 208 ; chapitre 5 §5.2-§5.4 (phase 0, sept occurrences) ; chapitre 3 §3.3, p. 109-110 (phase 0, bac à sable) ; chapitre 3 §3.3, p. 112 (bidirectionnel, non principal) ; chapitre 1 §1.4, p. 32 (phase 8 purge les spécifications) ; chapitre 2 §2.1, p. 45 (phase 8 retire tout ce qui appartient à la compilation) ; annexe E.2, p. 246 (l'expansion de macro « opère en phase 0 »).

**Énoncé actuel :** « Compiler un programme K7PL, c'est établir, dans un ordre que rien ne permet d'inverser, chacun des trois ordres de vérification […] chaque étape n'est là que parce que la précédente devait l'être acquise avant elle » (§6.1, p. 190). Huit phases, deux points de contrôle intercalaires.

**Diagnostic :** quatre défauts, dont trois sont des contradictions internes.
1. **La phase 0 n'existe pas dans le pipeline.** Elle est invoquée dix fois (ch. 3 ×2, ch. 5 ×7, annexe E ×1) et c'est elle qui porte : l'exécution des macros **avant toute vérification**, le bac à sable complet, la générosité/paramétricité du métaniveau, la staticité de la syntaxe (Th. 29 : « la syntaxe d'un programme est fixée à l'issue de la Phase 0 »), la résolution de `bind-to` par recherche dirigée par le type, et la frontière de confiance du §3.3. La figure 11 commence à Phase 1 et n'a aucun emplacement pour elle. Un pipeline qui se déclare « un ordre que rien ne permet d'inverser » omet la phase qui doit précéder toutes les autres.
2. **« Élaboration » a deux sens.** Au chapitre 5 (§5.3, Th. 31), `Elab : Surface → Noyau` est la fonction qui désucre les six formes de surface, *incluant l'expansion de macro* (« l'expansion de macro est une élaboration au sens de la littérature », §5.2 p. 174). Au chapitre 6 (§6.1, p. 192), « Une phase d'élaboration referme la composante A du jugement » : elle reçoit les `pack`/`unpack` explicites des existentielles et résout les variables d'unification — c'est-à-dire un travail *postérieur* au typage. La figure 11 place Élaboration en **2.5, après TypeCheck (2)**. Donc l'expansion de macro est à la fois « phase 0, avant toute vérification » et « phase 2.5, après le typage ». Ce n'est pas une nuance : le confinement de la phase 0 (bac à sable, aucune capacité, ℰ = ∅ pendant toute l'expansion — §5.2, p. 176) et le Th. 29 dépendent de l'antériorité ; la résolution des existentielles dépend de la postériorité.
3. **Le Th. 35 invoque une propriété abandonnée.** Preuve : « L'obligation et sa localisation se lisent sur la dérivation, laquelle est déterministe **puisque l'inférence est principale** ». Or le chapitre 3 §3.3 (p. 112) : « la vérification est bidirectionnelle, **non principale**. […] K7PL n'infère pas les grades d'une définition non annotée et ne produit pas de type le plus général » ; et le chapitre 6 §6.1 (p. 192) : « au prix assumé au chapitre 3 (§3.3) d'une vérification bidirectionnelle à signatures obligatoires plutôt que d'une inférence principale ». Le Th. 35 repose donc sur l'hypothèse que le document réfute deux fois.
4. **Trois autres hypothèses de déterminisme ne sont pas écrites**, alors que le Th. 35 conclut « deux compilations d'un même programme produisent le même message, à l'identique » : (a) l'ordre de parcours de l'arbre de syntaxe — que le §E.4.1 (p. 269) déclare explicitement *non spécifié* et renvoyé à « la spécification de l'outillage », alors qu'il « décide de la localité des messages d'erreur » ; (b) l'ordre de recherche du narrowing / de la synthèse dirigée par les grades, qui est « une recherche de preuve, avec espace de recherche et possibilité d'échec » (§3.3, p. 111) ; (c) la graine du test par propriétés des indices `invariant`/`witness`/`lemma`, qui est une exécution randomisée intégrée à la compilation (§6.2, p. 197 ; §6.3, p. 209 : « la falsification des indices SMT par test de propriétés […] reste un test au sens classique du terme — une exécution qui pourrait échouer »). Sans graine fonction de la source, le message n'est pas reproductible.

**Nature :** **B** pour (1)-(2), **A** pour (3) (une preuve qui invoque une hypothèse réfutée), **D** pour (4).

**Ce qui reste valide :** l'exigence de compilation bornée (§6.2, p. 196) est un excellent dispositif, et la clause « un compte de ressource, jamais un délai » est exactement la bonne : c'est elle qui rend la reproductibilité concevable. La clôture des trois voies de recours (§6.2.2 : découper, indexer, relever la borne — « ce n'est pas une limite d'imagination : c'est la clôture de ce dont la procédure dispose ») est juste. Le Th. 33 (stabilisation) identifie un vrai problème — la phase 6 peut recréer des obligations que la phase 5 a déchargées — et c'est le document lui-même qui le détecte (« Le pipeline suppose ici une dépendance à sens unique qui n'est pas établie »). La table 12 (statut de chaque affirmation d'ergonomie) est un modèle.

**Contre-exemple minimal pour (3) :** une définition non annotée en grade. Par §3.3, le compilateur ne produit pas de type principal ; par §3.1, un grade par défaut propre au fragment s'applique (ω en cartésien, 1 en linéaire, 0 ou 1 en affine « selon la forme de la liaison »). Deux ordres de parcours différents peuvent classer la même liaison sous deux formes différentes, donc sous deux grades par défaut différents, donc produire deux messages de rejet différents. Le Th. 35 l'interdit ; rien dans le document ne l'empêche.

**Correction minimale :**
- (1)+(2) : ajouter **Phase 0 : Expansion** à la figure 11 (avant Parse ou immédiatement après, selon que les macros opèrent sur le texte ou sur l'AST — l'annexe E dit « sur l'arbre », donc *après* Parse : la numérotation « 0 » est alors trompeuse et il faut la renommer 1.5 ou déplacer Parse en 0). Renommer la phase 2.5 en **Résolution** (ou *Généralisation*), et écrire une phrase au §5.3 : « le mot élaboration désigne ici Surface → Noyau ; la phase 2.5 du chapitre 6 est une résolution de variables d'unification, qui n'est pas une élaboration au sens du théorème 31. »
- (3) : remplacer « puisque l'inférence est principale » par une **hypothèse nommée** `D_det` : « tout parcours, toute recherche et toute graine sont des fonctions de la source et du compte de ressource ». Le document possède déjà les deux moitiés de cette hypothèse (compte reproductible ; « le budget relevé doit être écrit dans la source ») : il ne manque que de les assembler et de les déclarer.
- (4) : élever l'ordre de parcours du §E.4.1 du statut de « renvoi à l'outillage » à celui d'objet de la spécification, puisque le Th. 35 en dépend. C'est le seul cas du document où un choix déclaré « ni une règle ni un pas de réduction » est en réalité une hypothèse de théorème.

**Conséquences interchapitres :** ch. 1 §1.4 (phase 8), ch. 2 §2.1 (phase 8), ch. 3 §3.3 (frontière de confiance, narrowing), ch. 5 §5.2-§5.4 (phase 0, Th. 29, 31, 32), ch. 6 (figure 11, Th. 33, 35), annexe A (ERR-TOP-001 « rejeté en phase 2 », ERR-CMP-004 « budget temporel de l'évaluation comptime »), annexe E.2, E.4.1.

**Gain conceptuel éventuel :** la figure 11 corrigée devient le *seul* endroit où les niveaux de preuve sont ordonnés, et l'on peut alors énoncer une propriété que le document cherche sans la trouver : **chaque phase consomme un invariant et en produit un autre, et aucune n'en recrée un que sa prédécesseure a éliminé — sauf la paire (5,6), qui est la seule boucle et dont le Th. 33 donne la mesure.** C'est exactement la chaîne de preuves que le chapitre 6 décrit sans la formaliser.

---

## [R-10] Le Th. 26 énonce comme conclusion ce que la remarque qui le suit retire, et ce que le paragraphe qui le précède déclare manquant

**Localisation :** chapitre 4 §4.5, p. 144 (paragraphe « Une opération manque cependant ») et p. 144-145 (Th. 26, RMQ 30).

**Énoncé actuel :** Th. 26 : « Si un acteur transfère la propriété d'un tampon B à la passerelle FFI pour un appel étranger, l'acteur ne peut accéder à B pendant l'exécution de l'appel, **et le système hôte ne peut y accéder après le retour de la passerelle.** » RMQ 30, immédiatement après : « Les deux clauses de cet énoncé n'ont pas le même statut […] **Seule la première est ici un théorème.** […] La seconde clause repose donc sur la discipline de représentation de la passerelle […] et non sur le système de types. » Et, une page avant : « Une opération manque cependant : le système de types sait retirer une capacité de son contexte, **non la révoquer chez un pair qui l'a reçue**. […] Le destructeur d'une capacité exportée devrait en émettre une, **faute de quoi P3 cesse de valoir au-delà de la frontière**. C'est le troisième point où ce document franchit une frontière de confiance sans l'avoir tracée. »

**Diagnostic :** l'énoncé contient une clause que le document réfute à la page précédente et retire à la page suivante. Ce n'est pas une maladresse de rédaction : c'est la catégorie *Exigence* du §1.2 qui n'est pas employée là où elle existe. Le même schéma se retrouve au Th. 20 (conformité à trois spécifications externes), au Th. 18 (NaN IEEE 754), au Th. 25 (anneau), au Th. 16 (le vérificateur implante les règles).

**Nature :** **C** (portée) — l'idée est valable, l'énoncé est trop fort ; avec composante **F** (dette d'implémentation : l'invalidation à l'export n'existe pas).

**Ce qui reste valide :** la première clause est un vrai théorème et son argument est correct (élimination de coupure sur une ressource linéaire). La distinction « contrainte d'entrée / contrainte de sortie » et son rattachement à la directionalité des restrictions substructurelles (RMQ 30) est une observation juste et non triviale. Le diagnostic de l'opération manquante (révocation) est exact, et la solution citée (invalidation explicite des protocoles d'accès distant [54]) est la bonne.

**Correction minimale :** scinder en deux énoncés, sans rien réécrire :
- **THÉORÈME 26 ⟨langage⟩** : clause 1 (l'acteur perd l'accès), preuve inchangée.
- **EXIGENCE 26-R ⟨représentation⟩** : clause 2, avec le contenu de RMQ 30 et l'obligation d'émettre une invalidation au destructeur. Le statut « exigence » est celui que le §1.2 définit : « une contrainte que l'implémentation doit satisfaire, et dont ni la démonstration ni la réfutation n'appartiennent à ce texte ».
Coût : deux lignes. Bénéfice : la frontière de confiance cesse d'être franchie sans être tracée, ce qui est exactement ce que le paragraphe précédent réclame.

**Conséquences interchapitres :** ch. 3 §3.3 (les trois franchissements de la frontière, l'intégrité comme composante de ℰ), ch. 5 §5.5, ch. 1 table 1 (engagement « l'isolation par types plutôt que par unité de gestion mémoire », §4.5), annexe A (ERR-FFI-001/ERR-TYP-008).

**Gain conceptuel éventuel :** le même geste appliqué aux Th. 18, 20, 25, 33, 35 déplace six énoncés de la colonne « théorèmes du langage » à la colonne « exigences de représentation », ce qui **réduit le noyau théorique à défendre** et rend la partie restante mécanisable sans hypothèse matérielle. C'est la plus forte réduction de complexité disponible à coût constant.

---

## [R-11] Le Th. 23 transporte ≈_obs en =_bit par un pas qui n'est pas valide ; E_repro est insuffisante, et le Th. 18 l'agrandit sans le dire

**Localisation :** chapitre 4 §4.5, p. 135 (Th. 23) ; chapitre 1 §1.3, p. 12 (P4, deux degrés de rejeu) ; chapitre 3 §3.2, p. 107 (Th. 18, égalité de couche 3 « redéfinie comme identité bit à bit ») ; chapitre 6 §6.2 (reproductibilité du rejet) ; chapitre 1 §1.4, p. 22 (la convention d'élision doit appartenir à la version de schéma).

**Énoncé actuel :** « Sous l'hypothèse E_repro — ordonnancement, mode d'arrondi flottant et version de la chaîne de compilation identiques —, l'égalité du théorème précédent est une identité binaire. » Preuve : « la représentation d'une valeur dénotée est fonction de la seule chaîne de compilation, et l'ordre d'évaluation est fixé ; l'égalité observationnelle du théorème 22 se transporte alors en identité de représentation. »

**Diagnostic :** le pas « ≈_obs ⟹ =_bit » exige que la fonction d'observation soit **injective sur les représentations**, c'est-à-dire qu'il n'existe aucune liberté représentationnelle non observable. Le document ne le dit pas, et c'est faux dans son propre modèle :
- bourrage d'alignement entre champs d'une arène SoA (le §4.3 impose un alignement 64 octets) ;
- octets non initialisés d'une arène allouée et non entièrement écrite ;
- ordre des segments d'arène et adresses relatives après `mremap`/RDMA ;
- condensat BLAKE3 d'un objet canonique orphelin purgé « lors de la rotation du journal » — la purge dépend de l'ordre de rotation ;
- **charge utile des NaN** : le Th. 18 encode les quatre singularités de la théorie des roues (⊥, ∞, ∘, δ) dans les bits de charge utile d'un NaN silencieux, et redéfinit l'égalité de couche 3 comme identité bit à bit. La propagation de charge utile d'un qNaN n'est **pas spécifiée** par IEEE 754 (elle est recommandée, non exigée, et les opérations invalides produisent le NaN par défaut). Deux machines, ou deux chemins de compilation différents, peuvent donc produire des charges utiles différentes.
Or le Th. 18 fait de ces bits une partie de l'égalité de couche 3, donc de l'observable. Il **agrandit** l'ensemble des composantes d'environnement dont dépend l'identité binaire, au-delà des trois que E_repro liste. Le document écrit « Aucune des trois composantes de E_repro n'est fixée par ce document » — c'est exact, mais il en manque au moins une quatrième (l'architecture et son comportement NaN), et elle est introduite par un autre théorème du même document.

**Nature :** **C** (portée) avec composante **A** sur l'interaction Th. 18 / Th. 23.

**Ce qui reste valide :** la distinction des deux degrés de rejeu (ch. 1, p. 12) est excellente, et c'est le bon réflexe : « Le rejeu logique […] est ce que P4 garantit […] Le rejeu bit à bit suppose en outre un ordonnancement, un mode d'arrondi flottant et une version de compilateur identiques, qu'aucune clause de ce document ne fixe et que le journal ne consigne pas. P4 énonce donc le premier ; le second est une propriété de déploiement. » Cette phrase est juste. Le Th. 23 ne fait que la répéter sous une forme qui promet davantage.

**Scénario de rupture minimal :** un `Vec 4 Float64` de couche 3 dont un élément vaut `0/0`. Par le Th. 18, l'égalité de couche 3 est bit à bit, donc la charge utile du NaN fait partie de l'état observable. Sur une machine où l'opération invalide produit le NaN par défaut et une autre où elle propage la charge utile du premier opérande, le rejeu donne deux états bit-différents alors que E_repro est satisfaite (même ordonnancement, même mode d'arrondi, même compilateur).

**Correction minimale :** (i) restreindre le Th. 23 à l'énoncé conditionnel honnête : `E_repro ∧ Injectivité(obs, repr) ⟹ =_bit`, avec `Injectivité` nommée comme exigence et *non* comme fait, et la liste des libertés représentationnelles du document (bourrage, non-initialisé, purge, charge utile NaN) écrite à côté ; (ii) ou, mieux et plus petit : **exclure la charge utile NaN de l'égalité observable de couche 3**, ce qui demande de restreindre le Th. 18 (R-12) ; (iii) ajouter à E_repro la composante « architecture et comportement NaN » ou, à défaut, écrire que P4-bit ne vaut que sur architecture fixée — ce que le §4.5 fait déjà pour le modèle mémoire (« le modèle mémoire acquisition-libération et sa portée d'une machine ») et pour le référentiel de coût (« une machine, sa hiérarchie de caches »). La cohérence veut que la portée « une machine » s'applique aussi au rejeu bit à bit : c'est une clause, pas un mécanisme.

**Conséquences interchapitres :** ch. 1 P4 et §1.4 (convention d'élision ⟶ version de schéma), ch. 3 §3.2 (Th. 18), ch. 4 §4.3 (BLAKE3, canonicalisation), §4.5 (Th. 22, 23, modèle mémoire), ch. 6 (artefacts reproductibles), annexe E.4.2 (journal stratifié).

**Gain conceptuel éventuel :** nommer `Injectivité(obs, repr)` comme une **exigence de représentation** unique permet d'absorber cinq dispositions éparses : élision ⟶ version de schéma, purge ⟶ rotation du journal, bourrage ⟶ règle d'abaissement, NaN ⟶ Th. 18, ordre des segments ⟶ `mremap`. Toutes disent la même chose : *aucune liberté représentationnelle ne doit être observable*. C'est une abstraction légitime : elle explique cinq constructions, réduit leur duplication, permet une preuve commune (le lemme d'injectivité), et ne masque aucune différence réelle.

---

## [R-12] Le Th. 18 n'établit aucun homomorphisme, et sa conclusion sur les lois de la théorie des roues est fausse

**Localisation :** chapitre 3 §3.2, p. 107.

**Énoncé actuel :** « Théorème 18 : homomorphisme de la théorie des roues. Soit i : Wheel → Float64 l'injection associant à chaque singularité (⊥, ∞, ∘, δ) un encodage dans les bits de charge utile d'un NaN silencieux IEEE 754. Cette injection préserve l'égalité structurelle (i(x) = i(x) toujours vrai), et le masquage vectoriel de couche 3 la propage de façon homomorphe : select(m, i(x), y) = i(x) si m, y sinon. » Preuve : « L'égalité de couche 3 est redéfinie comme identité bit à bit […] La nature binaire du masque garantit que la charge utile de la branche inactive est annihilée plutôt que corrompue, **préservant les lois algébriques de la théorie des roues, par exemple ⊥ + y = ⊥**. »

**Diagnostic :** quatre défauts.
1. **Le titre ne correspond pas à l'énoncé.** Un homomorphisme exigerait `i(x ⊕_Wheel y) = i(x) ⊕_Float i(y)` pour chaque opération de la signature. L'énoncé ne porte que sur `select`, qui n'est pas une opération de la théorie des roues mais un combinateur de couche 3, et dont la propriété écrite (`select(m,i(x),y) = i(x) si m, y sinon`) est la *définition* de select. Il n'y a donc aucun homomorphisme dans l'énoncé.
2. **La première clause est une tautologie obtenue par redéfinition.** `i(x) = i(x)` est vrai pour toute fonction et toute égalité réflexive ; la précision « l'égalité de couche 3 est redéfinie comme identité bit à bit » ne la renforce pas, elle la rend seulement plus coûteuse (R-11).
3. **La conclusion sur les lois est fausse.** Contre-exemple : dans la théorie des roues, `x/0 = ⊥` pour tout x, donc `1/0 = ⊥` ; en IEEE 754, `1/0 = +∞`. Si `i` envoyait ⊥ sur un NaN et ∞ sur un autre encodage, alors `i(1/0)` diffère selon que l'on calcule dans Wheel puis on injecte, ou que l'on calcule en IEEE. L'injection ne peut donc pas être compatible avec la division — et la division est l'opération qui motive l'existence des roues. Second contre-exemple : `⊥ + y = ⊥` en roues ; en IEEE, `qNaN + y = qNaN` **avec propagation de charge utile non spécifiée** (IEEE 754 recommande la charge du premier opérande NaN, ne l'exige pas, et les opérations invalides comme `∞ − ∞` produisent le NaN par défaut, détruisant l'encodage). Le masque binaire de `select` n'a aucun rapport avec cette question : il annule la branche inactive d'un *select*, il ne dit rien de la propagation d'un NaN à travers `+`.
4. **Niveau.** La preuve invoque la liberté des bits de charge utile (propriété de la norme), le masquage vectoriel (propriété de l'abaissement SIMD) et la redéfinition de l'égalité (propriété de la représentation). C'est une propriété d'implémentation présentée comme un théorème du langage. Et elle contredit le critère que P3 revendique comme son propre ancêtre : « aucun effet dépendant de la machine, inexplicable dans les termes du langage lui-même » (ch. 1 §1.3, p. 12, citant Hoare [10]). Un comportement arithmétique qui dépend des règles de propagation de charge utile du matériel est exactement cela.

**Nature :** **A** sur la clause 3 (énoncé faux), **C** sur le titre, **Impl.** sur la nature.

**Ce qui reste valide :** l'intention est bonne et défendable : (i) ne jamais tolérer un dépassement silencieux ; (ii) distinguer trois régimes d'échec (état illégal / indésirable / transitoire) est une distinction juste et utile ; (iii) propager les singularités sans branchement est un choix d'abaissement légitime pour du calcul vectoriel de couche 3 ; (iv) rendre l'échec *prouvé* plutôt que silencieux (`⊥` en sortie = absence de donnée) est conforme à P3.

**Correction minimale :** réécrire l'énoncé comme une **proposition de représentation** portant sur ce qui est vrai :
- `i : Wheel → Float64` est **injective** sur les quatre singularités, par encodage déterministe dans la charge utile ;
- `select` est **exact** : il ne corrompt pas la charge utile de la branche retenue et annule celle de la branche inactive ;
- l'arithmétique de couche 3 sur les valeurs encodées est **spécifiée par K7PL** (table de propagation des singularités), et non déléguée à IEEE 754 ; l'abaissement doit la réaliser, et sa conformité est une **exigence** au sens du §1.2, vérifiable par test différentiel (§6.3).
Retirer le mot « homomorphisme » et la clause `⊥ + y = ⊥` de la preuve, ou les subordonner explicitement à la table de propagation. Coût : une demi-page.

**Conséquences interchapitres :** ch. 1 P3 (le critère de Hoare), P4 (rejeu bit à bit, R-11), ch. 3 §3.2 (les trois régimes d'échec, `Wheel<T>` contre IEEE 754), ch. 4 §4.2 (masquage vectoriel, R-expressions `@linear`), ch. 6 §6.1 (abaissement), ch. 7 §7.3 (moteur déductif sur arènes colonnaires).

**Gain conceptuel éventuel :** une **table de propagation des singularités** (4 × 4 × opérations) devient l'unique objet normatif, dont l'encodage NaN, le masquage SIMD et l'égalité bit à bit sont trois réalisations. C'est plus petit que l'énoncé actuel et cela rend la conformité testable.

---

## [R-13] Le Th. 34 ré-affirme comme théorème la direction que le chapitre 1 a explicitement retirée

**Localisation :** chapitre 6 §6.2, p. 196-197 (Th. 34) ; chapitre 1 §1.4, p. 33-34 (clôture : suffisante, non nécessaire, contre-exemple probabiliste).

**Énoncé actuel :** Th. 34 : « Le jugement Δ ⊢_𝒢 t : A ∣ ℰ porte exactement les trois obligations d'une interface […] **Aucune obligation ne déborde de ces trois**, et aucune des trois n'est vide de contenu d'interface. » Preuve : « L'énoncé ne se démontre pas, il se montre : il s'agit de vérifier, par énumération sur les formes de déclaration de ce chapitre, que chacune se range dans l'une des trois composantes et qu'aucune n'en demande une quatrième. »

**Diagnostic :** le chapitre 1 (§1.4, p. 33) écrit : « Ce critère est suffisant sous une condition, et **il n'est pas nécessaire** ; l'énoncer comme une équivalence, **ainsi que ce document l'a longtemps fait**, promettait plus qu'il ne tient », et donne le contre-exemple (p. 34) : « Une extension probabiliste attacherait à chaque terme un poids réel […] Elle pourrait satisfaire les quatre postulats sans se ranger dans aucune des trois strates […] **Il faudrait une strate de plus, et l'axiome devrait être révisé**. » Le Th. 34 énonce précisément cette direction retirée, sous forme de théorème, six chapitres plus tard. Et le §4.5 (p. 145-146) construit l'extension probabiliste en question (« Les poids d'importance vivent dans des registres atomiques de l'arène ») tout en déclarant que « le raisonnement statique sur un programme probabiliste […] demande deux notions dont K7PL ne dispose pas » — c'est-à-dire qu'il exhibe lui-même le débordement.

Ajoutons que la preuve avoue sa nature : « L'énoncé ne se démontre pas, il se montre ». C'est la définition d'une stipulation, pas d'un théorème.

**Nature :** **C** (portée) + **E** (catégorie).

**Ce qui reste valide :** le contenu positif est juste et utile : trois obligations d'interface (ce qu'une unité exige / ce qu'elle est / ce qu'elle produit) correspondent aux trois composantes, et aucune des formes de déclaration du chapitre 6 n'en demande une quatrième. La comparaison avec Standard ML et Haskell (RMQ 34) est pertinente. La conséquence pratique (« si le grade est dans l'interface, alors le changer change l'interface, et les unités dépendantes recompilent ») est exacte et courageuse.

**Correction minimale :** transformer en **DÉFINITION** (l'interface d'une unité de compilation *est* son jugement) accompagnée d'une **PROPOSITION de clôture locale** : « pour les formes de déclaration énumérées au chapitre 6, aucune obligation ne demande une quatrième composante », avec renvoi explicite au contre-exemple du chapitre 1 et à la clause de révision de l'axiome. Une ligne de renvoi suffit à supprimer la contradiction.

**Conséquences interchapitres :** ch. 1 §1.4 (critère de placement, condition de clôture, contre-exemple), ch. 4 §4.5 (extension probabiliste), ch. 6 §6.2, annexe E (les quatre composantes du grade).

**Gain conceptuel éventuel :** aucun, et c'est important de le dire : ici la factorisation est déjà faite (les trois strates), et le seul travail est de ne pas la sur-vendre. C'est un cas où la correction *réduit* la portée sans rien ajouter.

---

## [R-14] Le Th. 16 (complétude graduée) est une propriété du vérificateur prouvée par énumération sur un catalogue déclaré non exhaustif, et le compte des familles ne correspond à rien

**Localisation :** chapitre 3 §3.1, p. 97-98 ; annexe A, p. 231-236.

**Énoncé actuel :** « L'ensemble des programmes que le vérificateur rejette est l'ensemble des programmes pour lesquels aucune dérivation du jugement n'existe. » Preuve : « L'énoncé se vérifie par énumération […] chaque code d'erreur du vérificateur doit être exhibé comme une dérivation qui échoue, et le catalogue des codes est fini. **L'audit des dix-huit familles d'erreurs** le conduit à la main […] Le sens réciproque est immédiat par correction du typage : un programme dérivable est accepté, **puisque le vérificateur implante les règles**. » Une hypothèse est nommée : « la frontière de confiance du §3.3 doit être un objet du jugement. Tant qu'elle lui reste extérieure […] le théorème est faux. »

**Diagnostic :**
1. **Le sens direct** est une énumération sur un catalogue que l'annexe A déclare « illustrative et non exhaustive : tout mécanisme nouveau engendrerait des codes qu'elle ne peut anticiper […] la complétude — qu'aucune partie de ce document n'a revendiquée pour cette annexe ». Une preuve par énumération sur une base déclarée incomplète ne prouve rien. De plus le compte ne correspond à rien de mesurable : l'annexe A regroupe les codes en **7** familles (A.1-A.7), le corpus contient **49** codes distincts sous **21** préfixes (ERR-TOP ×19, ERR-TYP ×10, ERR-CMP ×4, ERR-ARC ×4, ERR-SMT ×3, ERR-MEM ×3, ERR-STK ×2, ERR-MAC ×2, ERR-IND ×2, ERR-FFI ×2, ERR-EFF ×2, ERR-ACT ×2, puis ERR-TER, ERR-SLC, ERR-ROW, ERR-PUR, ERR-POL, ERR-PKG, ERR-LOG, ERR-FLD, ERR-DPL), et le Th. 16 annonce **18** familles et **4** catégories. Trois comptes incompatibles dans un énoncé qui repose sur le compte.
2. **Le sens réciproque** (« un programme dérivable est accepté, puisque le vérificateur implante les règles ») suppose exactement ce qu'il faudrait prouver : la conformité du vérificateur aux règles. C'est une propriété d'implémentation promue en prémisse.
3. **Le niveau** : l'énoncé porte sur « le vérificateur », un objet d'implémentation, et non sur le système de typage. La version langagière — *toute condition de rejet est l'échec d'une prémisse dans une règle nommée* — est plus faible et démontrable par construction ; la version outil est plus forte et indémontrable ici.
4. Beaucoup de codes de l'annexe A portent sur des constructions **hors noyau** (R-01) : ERR-ACT-002 (motifs de jonction), ERR-ARC-001 (graphe de dépendances), ERR-TYP-006 (session abandonnée), ERR-TYP-007 (typestate), ERR-MEM-004/006 (arènes), ERR-TOP-005/006/007/008 (réseau de Leech, barrière mémoire, réallocation d'arène, vue `tref`), ERR-STK-001 (train tacite), ERR-IND-003 (`stream-subscribe`). Leur « exhibition comme dérivation qui échoue » est impossible puisque aucune règle ne les gouverne.

**Nature :** **C** (portée) + **F** (dette d'implémentation) + **A** sur le point 4 (l'énumération n'a pas d'objet pour un tiers des codes).

**Ce qui reste valide :** l'idée est forte et je la défends : **une garantie par inexpressibilité ne se diagnostique pas, et un catalogue de codes doit être l'image d'un catalogue de prémisses manquantes.** Le §1.4 (p. 33) pose le principe correctement (« Une violation est dite inexprimable lorsque le terme qui la commettrait n'a pas de dérivation — non parce qu'une règle l'interdit, mais parce qu'aucune règle ne le produit »), et RMQ 9 (« Interdire demande un gardien. Rendre inexprimable n'en demande aucun ») est une formule juste. L'hypothèse nommée (la frontière de confiance comme objet du jugement, réalisée au §3.3 par le niveau d'intégrité dans ℰ) est un bon exemple d'auto-correction réussie.

**Correction minimale :** restreindre l'énoncé au langage et à la partie couverte :
- **PROPOSITION 16 ⟨langage⟩** : « Pour tout constructeur du noyau (annexe E.2), tout refus du vérificateur est l'échec d'une prémisse d'une règle nommée du §E.3. » Preuve : énumération sur 35 constructeurs et 34-39 règles, base *close par construction* et vérifiée par le croisement mécanique déjà annoncé.
- **EXIGENCE 16-V ⟨compilation⟩** : « Le vérificateur n'émet aucun code hors de cette correspondance » — propriété de l'outil, route *mesure* ou *démonstration* au sens de RMQ 2.
- Corriger le compte : remplacer « dix-huit familles » par le regroupement réel de l'annexe A, et déclarer que l'énumération porte sur les codes du noyau uniquement.

**Conséquences interchapitres :** ch. 1 §1.4 (inexpressibilité, clôture), ch. 3 §3.1, ch. 5 §5.1 (ERR-TOP-001 comme « nom d'un échec de dérivation »), annexe A (toutes les tables), annexe E (le croisement).

**Gain conceptuel éventuel :** la forme restreinte devient mécanisable *exactement* : une table à deux colonnes (code ⟷ prémisse manquante) pour les 35 constructeurs du noyau, vérifiée par le même croisement que grammaire × règles. C'est le seul énoncé de complétude du document qui puisse devenir un artefact exécutable.

---

## [R-15] Le Th. 21 (sûreté spatiale) invoque l'absence de diagonale, alors que la propriété requise est l'unicité d'introduction de la capacité

**Localisation :** chapitre 4 §4.4, p. 130 (Th. 21, RMQ 27) ; chapitre 1 §1.3, p. 16 (la logique de séparation comme ciment) ; chapitre 3 §3.1, p. 96 (`Dest T`, `hollow_alloc`, paramètre d'âge `Lin_k`) ; chapitre 4 §4.3, p. 127 (partition statique d'arène par `Range`).

**Énoncé actuel :** « Soient t₁ et t₂ deux fibrilles exécutées en parallèle sous des contextes disjoints (Δ₁ ⊗ Δ₂ ⊢ t₁ ⊗ t₂), et WriteCap(r) une capacité d'écriture sur une région d'arène r. Si Δ₁ ⊢ t₁ : WriteCap(r) ⊸ Unit, alors il n'existe aucun terme t′₂ tel que Δ₂ ⊢ t′₂ : WriteCap(r) ⊸ τ. » Preuve : instance du lemme de capacité (Th. 14) ; « Celui-ci vit dans le fragment linéaire strict de C, lequel ne porte par construction aucun morphisme de duplication A → A ⊗ A. Le produit tensoriel garantit qu'elle n'apparaît qu'une fois dans le contexte combiné Δ₁ ⊗ Δ₂, et sa consommation par t₁ la retire donc structurellement de Δ₂. »

**Diagnostic :** l'absence de diagonale interdit de **dupliquer** une capacité donnée. Elle n'interdit pas de **créer deux capacités distinctes pour la même région**. Or c'est la seconde propriété que l'énoncé requiert : `WriteCap(r)` est indexé par la région r, et rien dans l'argument n'établit que l'introduction de `WriteCap(r)` est unique pour un r donné. Le mécanisme qui le garantit existe dans le document, mais il n'est pas invoqué :
- §4.3, p. 127 : « Une arène est **statiquement partitionnée** en segments d'index contigus, **un par fibrille concurrente** : la fibrille A reçoit `WriteCap(Arena<T>, Range(0,k))`, la fibrille B reçoit `WriteCap(Arena<T>, Range(k+1,2k))`, et ces zones d'écriture ne se chevauchent jamais. » C'est une disjointness *d'indices*, pas une non-duplicabilité.
- §3.1, p. 96 : `Dest T` et le paramètre d'âge `Lin_k T` — une destination ne se remplit que par une valeur dont les destinations propres portent un âge strictement inférieur. C'est une mesure de bonne fondation, encore un autre mécanisme.
- §3.1, p. 95 : « Le solveur SMT vérifie alors une condition d'exclusion — aucune WriteCap vivante tant qu'une image cartésienne subsiste — et non une somme de fractions. » Cette condition porte sur la **vivacité**, notion dynamique, et aucun mécanisme de durée de vie (région, portée, emprunt) n'est défini — le §4.3, p. 126 le dit lui-même : « Une région est une discipline de portée […] Ce document a besoin des deux et n'a nommé que la première, de sorte que la seconde s'y devine sans jamais s'y écrire. »

Donc : le Th. 21 est prouvé par le mécanisme A (non-duplication) alors que la conclusion exige les mécanismes B (unicité d'introduction / partition statique) et C (exclusion dans le temps / portée). Le document le sent : RMQ 27 ajoute l'hypothèse de disjonction des contextes et renvoie à la « déclaration d'indépendance entre modes » [23] — mais cette hypothèse porte sur l'*imbrication des fragments*, pas sur la création de capacités.

**Nature :** **A** (le théorème qui porte P3 et P4 selon le ch. 1, p. 16 : « Le théorème qui les porte est établi au chapitre 4 (§4.4) ») avec composante **D** (deux lemmes manquants).

**Ce qui reste valide :** le lemme de capacité (Th. 14) est correct dans sa portée : « Si Cap(r) est de grade linéaire, alors aucun terme ne dérive deux accès concurrents à r » — *pour une capacité donnée*. RMQ 27 est une excellente remarque et son contre-exemple (une valeur cartésienne capturant une capacité linéaire) est le bon. L'inexpressibilité comme mode de garantie est bien employée ici. La partition statique d'arène par `Range` est un mécanisme réel et suffisant — il n'est simplement pas dans la preuve.

**Contre-exemple / scénario de rupture :** supposons une primitive `alloc_range : Arena<T> → Range → WriteCap(Arena<T>, Range)` non linéaire en son premier argument (par exemple parce que l'arène est accessible à grade ω dans un bloc de couche 3, ou parce qu'elle est obtenue par une capacité de lecture promue). Alors deux appels `alloc_range(a, Range(0,k))` produisent deux capacités distinctes pour la même région, toutes deux linéaires, toutes deux non dupliquées. Le Th. 21 est satisfait pour chacune et faux pour le couple. Rien dans l'énoncé ni dans la preuve ne l'exclut, parce que la règle d'introduction de `WriteCap` n'existe pas dans le noyau formel (R-01 : l'arène est le seul connecteur explicitement déclaré sans règle d'élimination, et son introduction « se lit comme celle d'une modalité graduée dont l'indice est une taille » — p. 261, sans être écrite).

**Correction minimale (deux lemmes, aucun mécanisme) :**
- **Lemme d'unicité d'introduction** : pour toute région r, la règle d'introduction de `WriteCap(r)` consomme linéairement son arène ou son segment, donc au plus une capacité d'écriture par région est dérivable dans un contexte clos. (C'est la forme correcte de ce que la partition statique par `Range` réalise ; il faut l'écrire comme règle.)
- **Lemme de portée** : deux capacités dont les `Range` sont disjointes ne dénotent pas la même région (arithmétique d'intervalles, déchargeable par le solveur).
Puis réénoncer le Th. 21 avec ces deux hypothèses, en gardant le Th. 14 pour la non-duplication. Coût : une règle, deux lemmes, un énoncé.
- Séparément : définir **région** (discipline de portée) comme le §4.3 le réclame, puisque la « condition d'exclusion » du §3.1 en dépend. Le document indique la voie la moins coûteuse : « la complication habituelle des systèmes à régions est en principe inutile, le polymorphisme paramétrique ordinaire y suffisant, par une traduction qui préserve les types et le sens [19] ».

**Conséquences interchapitres :** ch. 1 §1.3 (la disjonction fonde P3 et P4), ch. 2 §2.6 (Th. 14), ch. 3 §3.1 (ReadCap/WriteCap/Dest/Lin_k, condition d'exclusion), ch. 4 §4.3 (arènes, partition, ECS), §4.4 (Th. 21, table 7), ch. 6 (abaissement, conformité), annexe E.3.4 (arène hors jeu de règles), annexe A (ERR-MEM, ERR-TOP-006/007/008).

**Gain conceptuel éventuel :** les trois mécanismes (non-duplication, partition d'indices, âge des destinations) sont **trois instances d'une seule loi** : *une ressource d'écriture est introduite au plus une fois par région, et son introduction est indexée par une mesure strictement décroissante*. Le paramètre d'âge `Lin_k`, la taille de l'arène et le grade linéaire sont la même mesure lue sur trois objets. Le document le pressent (§3.1, p. 96 : « C'est, au niveau des types, une instance du même principe que la mesure strictement décroissante qui fonde la terminaison des catamorphismes ») sans en tirer le lemme unique qui porterait à la fois le Th. 21, la non-cyclicité des destinations et la terminaison des arènes.

---

## [R-16] Le Th. 20 est une conformité entre trois spécifications externes et un abaissement, sans paramètre de version

**Localisation :** chapitre 4 §4.3, p. 128-129 (Th. 20, RMQ 26, note a) ; chapitre 1 §1.1, p. 5 (R1 « Arrêté » : « Les correspondances de disposition et leur domaine exact ») ; chapitre 1 §1.4, p. 22 (la convention d'élision appartient à la version de schéma) ; chapitre 6 (isomorphisme mémoire avec le format de journalisation « assuré à la compilation »).

**Énoncé actuel :** pour T scalaire primitif de largeur fixe, les trois dispositions (tampon de valeurs d'un `Vec n T` de couche 3 ; tampon d'un tableau Arrow de type T et longueur n, bitmap de validité omis ; charge utile d'une liste primitive Cap'n Proto de n éléments de T) « coïncident bit à bit. Le transfert d'un pointeur y dispense de toute copie. »

**Diagnostic :** l'énoncé est correct dans son domaine et le domaine est bien délimité (le hors-domaine — structures composites, transposition en O(n) — est explicitement décrit, ce qui est à l'honneur du document). Mais sa *vérité* dépend de quatre artefacts externes : la spécification Arrow (bitmap omis licite quand null_count = 0, alignement 8 ou 64 octets), la spécification Cap'n Proto (liste plate, encodage du pointeur, alignement 8 octets, composite pour les structures), l'abaissement MLIR (alignement 64 bits), et l'ordre des champs. Aucun paramètre de version n'apparaît dans l'énoncé. Or le chapitre 1 déclare ces correspondances **arrêtées** (« ne changera plus sans révision de l'axiomatique »), ce qui est intenable pour une propriété dont la vérité est fonction de spécifications tierces évolutives. Le document a déjà la bonne réponse pour un cas voisin : « La convention d'élision appartient à la signification du programme, donc à la version de schéma de l'artefact, faute de quoi un rejeu bit à bit (P4) reposerait sur un accord tacite entre deux versions du compilateur. »

Deux précisions techniques manquent : (i) l'endianness — ni Arrow ni Cap'n Proto ne fixent l'ordre des octets comme invariant de format portable sans déclaration ; (ii) « sans copie » signifie ici « sans copie élément par élément » ; le transfert exige tout de même l'écriture d'un mot de pointeur de liste et, côté Cap'n Proto, que le tampon soit *déjà* un segment de message aligné — ce que le §4.3 obtient effectivement par l'arène PIA, mais qui est une condition, pas une conséquence.

**Nature :** **C** (portée) + **Impl.**

**Ce qui reste valide :** le domaine exact (scalaires seulement, transposition hors domaine) ; RMQ 26 (« Trois entiers par type, comparés. Pas une inspection de représentation ») est la bonne méthode et rend la vérification décidable ; la note a (aucune des deux spécifications ne publie de mesure de transposition ; la borne linéaire tient à la forme de l'opération) est un modèle d'honnêteté ; la conséquence architecturale (« une frontière, une marque, un prix ») est juste.

**Correction minimale :** ajouter trois paramètres à l'énoncé — `vArrow`, `vCapnp`, `vMLIR` — et une clause : « la coïncidence est vérifiée à la compilation par comparaison des trois entiers (largeur de créneau, alignement, ordre des champs) pour la version de schéma de l'artefact ». Le Th. 20 devient alors une **PROPOSITION ⟨représentation⟩** conditionnelle, et le statut « Arrêté » du chapitre 1 doit être retiré de cette ligne (ou restreint au *domaine exact*, qui lui est arrêté : scalaires oui, structures non).

**Conséquences interchapitres :** ch. 1 §1.1 (R1), §1.4 (version de schéma), ch. 4 §4.3 (gel d'acteur, promotion canonique), §4.5 (persistance, rejeu), ch. 6 (isomorphisme mémoire/journal), ch. 7 §7.3 (arènes colonnaires).

**Gain conceptuel éventuel :** la même mise en paramètre s'applique au Th. 18 (IEEE 754) et au modèle mémoire (§4.5, « portée d'une machine »). On obtient alors un seul objet : **un profil de représentation** `Π = ⟨vArrow, vCapnp, vMLIR, arch, modèle mémoire, mode d'arrondi⟩`, dont E_repro (R-11), la version de schéma (P4) et la conformité des dispositions (Th. 20) sont trois projections. C'est une abstraction légitime : elle explique quatre dispositions éparses, supprime quatre redites, permet un lemme commun, et ne masque aucune différence.

---

## [R-17] Le graphe de câblage, hypothèse du Th. 17 et du Th. 24, n'est défini nulle part ; les renvois pointent vers une section qui ne le contient pas ; la granularité gabarit/instance n'est pas tranchée

**Localisation :** chapitre 3 §3.2, p. 105-106 (Th. 17 : « dont le graphe de dépendances est acyclique **au sens du chapitre 4 (§4.3)** » ; RMQ 23 : « Le graphe de câblage **du §4.3** ») ; chapitre 4 §4.5, p. 135-136 (construction du graphe « entre **gabarits** d'acteurs ») ; chapitre 4 §4.5, p. 139 (Th. 24 : « le graphe de dépendances G des acteurs et canaux ») ; annexe A, p. 233 (ERR-ARC-001 : « Cycle dans le graphe de dépendances **entre acteurs et canaux** »).

**Énoncé actuel :** Th. 17 : « Soit un réseau d'acteurs N dont les canaux sont typés par des protocoles de session duaux […] et dont le graphe de dépendances est acyclique au sens du chapitre 4 (§4.3). Alors N n'atteint jamais d'état de blocage mutuel. » L'esquisse admet : « L'étape de préservation est ce que cette esquisse doit encore établir, et elle se réduit à un énoncé unique — la simulation du graphe d'attente […] Sans elle, l'amorce ne se propage pas, et c'est le seul point que cet énoncé emprunte. »

**Diagnostic :**
1. **L'objet n'est pas défini.** Le §4.3 est « Échelle de l'acteur » : il traite de l'espace d'état, des arènes PIA, d'ECS, d'EntityRef, des grades fractionnaires, de la promotion canonique et du Th. 20. Il ne définit aucun graphe. La construction effective est au §4.5, sous un autre nom (« graphe de dépendances entre gabarits d'acteurs »), sans définition formelle : ni ensemble de sommets, ni relation d'arêtes, ni règle d'orientation, ni statut des canaux (sommets ou arêtes ? le Th. 24 dit « des acteurs et canaux », ERR-ARC-001 aussi, le §4.5 dit « entre gabarits d'acteurs »).
2. **Granularité non tranchée.** Le §4.5 pose « le type d'état est unique par gabarit d'acteur » et construit le graphe **entre gabarits**. Le Th. 17 conclut sur un **réseau d'acteurs**, c'est-à-dire sur des instances. Un graphe de gabarits acyclique n'implique pas un graphe d'instances acyclique : deux instances d'un même gabarit peuvent être en relation d'attente mutuelle, et cette relation n'apparaît comme arête de gabarit que si le gabarit dépend de lui-même (boucle), ce que la construction ne dit pas. Le lemme de simulation (« si a attend un message de b, alors l'arête (a,b) est au graphe de câblage ») est exactement l'énoncé qui trancherait — et il est déclaré non établi.
3. **Hypothèse contredite par un mécanisme voisin.** Le Th. 17 suppose « Le jeton linéaire Lin(SessionEndpoint) force la progression : une session ne peut être abandonnée, elle doit atteindre end ou traiter un Timeout ». Or le §3.2, p. 103 déclare : « Une session peut être abandonnée — le Timeout et le circuit breaker du §4.5 le font —, et la grammaire ci-dessus décrit des protocoles qui ne peuvent pas échouer. L'écart se comble sans quitter le cadre : la logique linéaire classique s'étend conservativement de deux modalités duales capturant une (co)monade additive […] **Transporter l'extension au cadre intuitionniste est donc une obligation et non un acquis** […] K7PL ne conduit pas cette extension ; il la nomme. » Donc l'abandon de session — pratiqué au chapitre 4 — n'est pas typé, et le Th. 17 traite le Timeout comme une issue de progression alors qu'il est une rupture non typée.
4. **Équité absente.** L'argument « il existe toujours une communication réductible » établit l'absence de blocage *structurel*, pas le progrès *effectif* : il faut que l'ordonnanceur active l'acteur minimal. Le §4.5 le sait pour un cas voisin (l'équité mémoire [30], « Ce dispositif appelle une hypothèse que l'invariant de vivacité de ce chapitre suppose sans la nommer ») mais ne le transpose pas au Th. 17.

**Nature :** **A** (l'hypothèse d'un théorème central n'a pas de référent) + **D** (lemme de simulation, extension intuitionniste de l'abandon).

**Ce qui reste valide :** RMQ 23 est la meilleure remarque du chapitre et elle est exactement le bon diagnostic : « Le graphe de câblage […] est donné en entier à la compilation : fini, statique, il se traite inductivement […] Le graphe d'attente à l'exécution se déplie au fil des activations et n'est jamais donné. L'acyclicité du premier n'implique donc pas mécaniquement celle du second. » Le contre-exemple à trois participants duaux en cycle (p. 104-105) est juste et bien choisi. L'appui sur l'élimination des coupures du seul fragment multiplicatif, et sur la coinduction plutôt que l'induction, est correctement sourcé [36, 37]. Et le document a raison de ne pas confondre acyclicité statique et absence dynamique de blocage — c'est précisément pourquoi il lui manque la définition.

**Correction minimale :** une page, trois objets.
1. **DÉFINITION** du graphe de câblage : sommets = instances d'acteurs *statiquement créées* (ou gabarits, avec une clause explicite de passage à l'instance) ; arêtes = `(a,b)` ssi le protocole d'un canal détenu par `a` contient une réception dont l'émetteur est `b` ; orientation et sur-approximation déclarées.
2. **LEMME de simulation** : toute arête d'attente dynamique est une arête du graphe de câblage. Il exige : pas de délégation de session (acquis, §3.2 p. 103), pas de création dynamique de canal (à écrire — c'est l'objet de R-01), et sur-approximation des branchements (acquis : le graphe contient toutes les arêtes de tous les embranchements).
3. **Hypothèse d'équité** nommée, et **statut de l'abandon** : soit le Timeout est typé (extension additive transportée en intuitionniste, obligation déjà nommée), soit le Th. 17 exclut explicitement les sessions abandonnables.
Corriger les renvois §4.3 → §4.5.

**Conséquences interchapitres :** ch. 3 §3.2 (Th. 17, asynchronie, abandon), ch. 4 §4.3/§4.5 (graphe, Th. 24, supervision, invariant de vivacité, équité mémoire), ch. 5 §5.5 (`bind-to` et la recherche du gestionnaire, qui « s'achève » grâce à l'unicité du type d'état), ch. 6 §6.1 (Phase 1.5, ERR-ARC-001, ERR-ARC-002), ch. 7 §7.3.

**Gain conceptuel éventuel :** une fois le graphe défini, trois dispositifs cessent d'être séparés : le tri topologique de la Phase 1.5 (Th. 13), l'initialisation sans blocage (Th. 24) et la recherche de gestionnaire par `bind-to` (§5.5) sont trois lectures du même ordre partiel. Le document le dit déjà pour les deux premiers (« Les espaces de noms se lisent sur ce même graphe : un namespace en retient la restriction à une dimension choisie », p. 139-140, avec la correction juste : « Le namespace ne projette pas le graphe, il en isole une partie close par composition »). Il manque la troisième.

---

## [R-18] Le Th. 31 quantifie sur une fonction de sens `Sens` qui n'est définie nulle part, et le Th. 29 est déclaré son corollaire alors qu'il est prouvé indépendamment

**Localisation :** chapitre 5 §5.3, p. 176-177 (Th. 31, ses « trois conséquences »).

**Énoncé actuel :** « Soit Elab : Surface → Noyau la fonction d'élaboration. Pour toute forme de surface s, `Elab(s) = t ∧ Δ ⊢ t : A ∣ ℰ ⟹ Sens(s) = Sens(t)`. Aucune forme de surface n'a de sens propre, et aucune n'en ajoute au noyau. » Preuve : Elab est définie par récurrence, n'introduit aucune variable libre, respecte les liaisons ; donc justiciable du schéma de commutation (Th. 11) ; « La compatibilité de l'action graduée (théorème 1) en donne la part quantitative ». Conséquences : « La staticité de la syntaxe (théorème 29) en est un corollaire : si aucune forme de surface n'a de sens propre, aucune n'étend la grammaire du noyau. »

**Diagnostic :**
1. `Sens` n'est défini ni au chapitre 5, ni au chapitre 2 (la dénotation dans C), ni à l'annexe E (la sémantique opérationnelle ⟨c∣μ∣τ⟩, la traduction ⟦·⟧). L'énoncé est donc une formule ouverte : il est vrai par stipulation si l'on *définit* `Sens(s) := Sens(Elab(s))`, et il n'a aucun contenu sinon.
2. La preuve n'établit pas la conclusion. Le Th. 11 donne `Elab ∘ subst = subst ∘ Elab` : c'est une condition de *bonne définition* d'une sémantique sur les termes ouverts, pas une égalité de sens entre deux objets de domaines différents (Surface et Noyau). Le Th. 1 donne le transport des grades : rien à voir avec `Sens`.
3. La dérivation du Th. 29 est un non-sequitur : « aucune forme de surface n'a de sens propre ⟹ aucune n'étend la grammaire du noyau ». Le Th. 29 est prouvé par ailleurs, correctement, « par inspection de la grammaire, en quatre points » (p. 172-173), y compris le cas délicat de `bind-to`. Cette preuve autonome est la bonne ; le statut de corollaire est injustifié.

**Nature :** **C** (portée) + **E** (catégorie : une définition habillée en théorème).

**Ce qui reste valide :** le contenu architectural est vrai et important : **les six formes de surface sont des notations, pas des mécanismes**, et la table 10 le documente forme par forme. RMQ 33 (« Une seule loi, six emplois ») est le bon geste. Le Th. 29 est un vrai résultat, avec une vraie preuve, et sa conséquence (« ce qui empêche APL d'être compilé statiquement […] est inécrivable pour K7PL, et elle l'est par théorème ») est bien vue. Le Th. 30 (hygiène) est correctement rattaché au Th. 11, avec la bonne réserve : il porte sur l'AST non gradué, et « l'énoncé gradué suppose donc de savoir ce qu'une macro déclare de ses arguments » — question que le §5.4 referme effectivement par le grade déclaré `r_i`. La chaîne est donc bonne *sauf* au maillon 31.

**Correction minimale :** transformer le Th. 31 en **DÉFINITION** : « Une forme de surface n'a pas de sémantique propre. Par définition, `Sens(s) = Sens(Elab(s))`. » Puis conserver comme **PROPOSITION** les deux contenus vérifiables qui s'y trouvent réellement : (i) `Elab` commute avec la substitution (instance du Th. 11) ; (ii) `Elab` ne transporte les grades qu'en les majorant (instance du Th. 1) ; (iii) `Elab` n'émet que des termes du noyau — d'où le Th. 29 par inspection, et non par corollaire. Coût : trois lignes, et le chapitre 5 perd un faux théorème sans perdre une idée.

**Conséquences interchapitres :** ch. 5 §5.1-§5.4 (table 10, Th. 29, 30, 32), ch. 2 §2.6 (Th. 11), annexe E.2 (les six formes n'ont pas de constructeur propre).

**Gain conceptuel éventuel :** une fois `Sens` défini comme `⟦Elab(·)⟧` (traduction composée), le Th. 31 devient un cas particulier d'un schéma plus général que le document possède sans le nommer : **toute transformation définie par récurrence et hygiénique induit un morphisme de systèmes de raffinement**. Ce schéma couvre Elab (ch. 5), l'abaissement (Th. 36), la traduction (Th. 27) et l'expansion (Th. 32) — quatre énoncés qui sont aujourd'hui quatre instances séparées du Th. 11 et du Th. 12. C'est le « théorème aspirateur » le plus rentable du document, et il est déjà à moitié écrit (§2.6).

---

## [R-19] Le Th. 7 a une esquisse circulaire ; le Th. 10 admet trois points non résolus ; le §E.5.5 déclare les deux étendus sans induction

**Localisation :** chapitre 2 §2.4, p. 70 (Th. 7 et son esquisse), p. 77-78 (Th. 10 et ses trois points) ; annexe E.4.4, p. 272 (Th. 47, cas DECLASSIFY non traité), p. 273 (les deux points manquants), annexe E.4.5, p. 273-274, annexe E.5.5, p. 280.

**Énoncé actuel :** Th. 7, esquisse : « La quantification est ce qui porte l'énoncé. […] La différence mesure ce que 𝒳 libère, et rien de plus : **si une exécution divulguait une information qu'aucune expression de 𝒳 ne détermine, il existerait deux états s'accordant sur toutes ces expressions et néanmoins distinguables, ce que l'énoncé interdit.** □ » Puis : « Cet énoncé est celui de la divulgation délimitée [43], transposé au régime gradué de ce chapitre. **Ce document en reprend la formulation et n'en conduit pas la preuve pour K7PL.** Il note en revanche que la voie est la même que celle du **théorème suivant**, la quantification sur les états s'obtenant par la relation qu'une lecture paramétrique fournit. »

**Diagnostic :**
1. L'esquisse est circulaire : elle déduit l'énoncé de sa propre négation. La phrase « ce que l'énoncé interdit » est littéralement l'usage de la conclusion comme prémisse. Le □ ferme une tautologie.
2. Le texte suivant admet que la preuve n'est pas conduite — donc la catégorie réelle est **Conjecture**, et l'environnement dit **Théorème**.
3. « le théorème suivant » est le Th. 8 (terminaison du point fixe déductif), qui n'a aucun rapport avec la paramétricité. La voie paramétrique est celle du Th. 10. Renvoi faux.
4. Le Th. 10 est honnête : « L'esquisse ne conduit pas la preuve, et trois points y résisteraient » — (a) la relation par facteur ne donne pas automatiquement une relation sur le produit ; (b) la relation doit s'étendre aux communications sur les canaux distingués ; (c) la déclassification est une exception délibérée. Trois dettes nommées, ce qui est bien. Mais l'annexe ne traite (a) que par une remarque (« la clause n'inspecte que la troisième composante — et le chapitre 1 établit que φ et ψ ne mêlent jamais deux composantes »), ce qui est un argument de *non-interaction* et non de *compatibilité* ; elle traite (b) par une définition de clause (§E.5.5) et déclare l'extension acquise sans induction ; elle traite (c) par une requantification de la relation (§E.4.5) dont le seul cas nouveau est DECLASSIFY, et c'est correct — mais sous une condition que le §E.4.5 découvre et qui n'est pas dans la règle (10) du chapitre 2 : **𝒳 doit être un ensemble d'expressions closes**. Le document le dit (« La règle du chapitre 2 doit donc porter cette clause, et c'est un écart de formalisation relevé au chantier ») — mais la règle (10), p. 69, n'a pas été corrigée.
5. Le §E.5.5 conclut : « Le lemme fondamental (théorème 47) s'étend en conséquence à la strate des sessions, ses cas nouveaux étant ceux des règles de communication, chacun réglé par la clause correspondante. » Il n'y a pas de règles de communication dans la source (R-01), donc pas de cas, donc rien à régler. La conclusion « La non-interférence graduée et la divulgation délimitée cessent donc d'être bornées au fragment sans communication » est sans objet.

**Nature :** **D** (dette de preuve) pour les deux énoncés, **E** (catégorie et renvois), **A** pour la clause de clôture de 𝒳 (une règle de typage fausse telle qu'écrite : elle admet le blanchiment par substitution).

**Ce qui reste valide :** beaucoup, et il faut le souligner parce que c'est le cœur de l'axe confidentialité.
- La *forme* de l'énoncé (quantification sur les paires d'états qui s'accordent sur 𝒳) est la bonne : c'est bien la dimension « what » de Sabelfeld–Askarov [43], et le document a raison de dire que c'est la quantification, et elle seule, qui distingue cet énoncé de la non-interférence (RMQ 17).
- Le choix des **échappatoires nommées** plutôt que d'une permission générale de déclassifier est juste, et l'argument du §1.3 (p. 13) — « il n'assouplit pas la modalité de classification, il en ajoute une seconde, dédiée [12] […] l'ensemble des échappatoires devient énonçable comme un type et non comme une liste, et la question de sa clôture cesse d'être ouverte pour devenir une propriété de ce type » — est une excellente idée, correctement sourcée.
- La découverte du §E.4.5 (la substitution transforme l'échappatoire en gabarit) est un résultat de revue de qualité : c'est précisément l'attaque par blanchiment, trouvée par le document lui-même, avec la bonne condition de clôture.
- L'économie « une seule relation, quantifiée deux fois » (§E.4.5) est réelle.

**Contre-exemple minimal (celui que le §E.4.5 trouve, et que la règle (10) laisse passer) :** soit 𝒳 = {`compare mdp x`}, avec x libre. Un appelant écrit `declassify_ℓ′(compare mdp secret)` : par substitution, `e[v/x] = compare mdp secret ∈ 𝒳` ? Non — mais si la règle accepte `e ∈ 𝒳` *avant* substitution, la dérivation existe et divulgue la comparaison du secret avec une valeur choisie par l'attaquant. C'est le blanchiment.

**Correction minimale :**
1. Corriger la règle (10) du chapitre 2 en y portant la clause « e ∈ 𝒳 et 𝒳 clos » (expressions closes, évaluées dans l'état initial). Une ligne ; elle est déjà écrite au §E.4.5, il faut la remonter.
2. Remplacer l'esquisse circulaire du Th. 7 par son statut réel : **PROPOSITION 7 ⟨langage⟩, non démontrée**, avec la route nommée (paramétricité via existentielles, [49]) et la dépendance explicite au Th. 47 + clause de clôture.
3. Corriger le renvoi « le théorème suivant » → Th. 10.
4. Retirer la dernière phrase du §E.5.5 ou la conditionner à l'existence de règles de communication (R-01).
5. Traiter le point (a) du Th. 10 par un **lemme** plutôt que par une remarque : *si chaque facteur d'un produit de structures ordonnées admet une relation logique compatible, alors le produit en admet une, définie composante par composante, pourvu que la clause décisive (ici `!^r V`) n'inspecte qu'une composante.* C'est exactement ce que le document affirme ; il manque l'énoncé.

**Conséquences interchapitres :** ch. 1 §1.1 (maturité « Construit, non éprouvé » : axe de confidentialité, déclassification), §1.3 (P4 comme famille indexée par les niveaux, borne inférieure), ch. 2 §2.4 (règle 10, Th. 7, Th. 10, dualité confidentialité/intégrité), §2.5 (famille d'effacements ⟦·⟧_ℓ), ch. 3 §3.2 (le niveau n'est pas une contrainte de valeur), annexe E.1 (ℕ∞^ℒ), E.4.2 (Th. 46), E.4.3-E.4.5, E.5.2-E.5.5.

**Gain conceptuel éventuel :** la borne inférieure que le §1.3 réclame (« Pour chaque niveau ℓ, la projection du journal sur ce niveau doit suffire à rejouer le comportement que l'observateur de niveau ℓ observe ») est *exactement* le Th. 46, que l'annexe démontre. Le chapitre 1 ne le sait pas : il écrit « Ce qui manque est de l'écrire, non de la trouver » — et c'est écrit, p. 269. C'est le seul cas du document où une dette déclarée est en réalité payée sans que la table des engagements le reflète. À propager.

---

## [R-20] Le Th. 6 affirme la préservation des lois de comonade par troncature sans lemme, et la borne O(r) en dépend

**Localisation :** chapitre 2 §2.3, p. 63-65 (Th. 6, troncature à r niveaux, borne O(n·r) en temps et O(r) en espace).

**Énoncé actuel :** les deux conditions de cohérence de la loi distributive `λ : F ∘ N ⇒ N ∘ F` (que je vérifie correctes : `εF · λ = Fε` et `δF · λ = Nλ · λN · Fδ`) « se vérifient sur la comonade cofree par les lois de counité et de coassociativité […] **La troncature à r niveaux les préserve, chacune étant une équation entre transformations naturelles dont les deux membres se tronquent au même rang.** » Et : « K7PL ne travaille pas sur F^∞ mais sur son tronqué à r niveaux, qui est une comonade graduée de la même famille que !^r — sa comultiplication porte l'indice du produit du semi-anneau, et la coassociativité y survit, **la troncature étant idempotente et commutant avec elle-même** ».

**Diagnostic :** les deux conditions pour la comonade cofree **non tronquée** sont un résultat de littérature [22] correctement ré-énoncé. La préservation par troncature est le seul point propre à K7PL, et il est affirmé par deux formules qui ne sont pas des preuves : « les deux membres se tronquent au même rang » (pourquoi ? δ_r envoie un élément de profondeur ≤ r sur un élément de N_r(N_r A), dont la profondeur totale est ≤ 2r, et la comparaison des deux membres de la coassociativité se fait *après* troncature — donc au rang r, où les deux membres ne coïncident que si la troncature est un morphisme de coalgèbre, ce qui est précisément à montrer) ; « la troncature étant idempotente et commutant avec elle-même » (propriété d'un opérateur de troncature, pas d'une comultiplication). Le point de difficulté réel est le **rang frontière** : à la profondeur r, le sous-arbre est tronqué, donc `N_r δ_r` et `δ_r N_r` appliquent deux troncatures à des profondeurs différentes, et leur égalité dépend de la convention de remplissage.

Or la borne mémoire annoncée (O(r) au lieu de O(n)) et la borne temporelle (O(n·r) linéaire à grade fixé, donc conforme à P3) dépendent toutes deux de cette troncature.

**Nature :** **D** (dette de preuve) avec composante **C** (la borne annoncée est conditionnelle).

**Ce qui reste valide :** la détection du problème de coût est exemplaire. Le document écrit : « La seconde touche P3, et elle interdit de tenir la borne pour acquise. La dérivation directe d'un tel schéma est quadratique […] obtenir une version linéaire […] demande un travail supplémentaire et un résultat séparé. **Annoncer une borne sans dire de laquelle des deux versions on parle reviendrait à dissimuler un facteur, ce que le postulat d'autonomie physique interdit.** » C'est exactement l'application de P3 à la théorie elle-même, et c'est rare. La transposition par homomorphismes de λ-bialgèbres [36] est correctement identifiée. La lecture du grade r comme **potentiel** (donc comme borne amortie) et son rattachement au calcul par poussée de valeur [35] est un bon résultat : « Le grade qui borne l'historique est donc un potentiel, et le dire ainsi n'ajoute aucun mécanisme : cela nomme celui qui était déjà là. »

**Correction minimale :** un **lemme** explicite : « soit T_r : N ⇒ N_r le foncteur de troncature. T_r est un morphisme de comonades si et seulement si la convention de remplissage au rang r est idempotente *et* F préserve les troncatures. Sous ces deux conditions, N_r est une comonade et λ_r = T_r ∘ λ ∘ F(η_r) satisfait les deux conditions de cohérence. » Puis écrire la convention (le document la pratique sans la nommer). Si la condition échoue pour un F donné, restreindre la classe de conteneurs admissibles à l'histomorphisme tronqué — c'est une restriction de domaine, pas un mécanisme.

**Conséquences interchapitres :** ch. 2 §2.3 (Th. 6, borne O(r)), ch. 4 §4.2 (machine à pile + accumulateur d'historique, « toute exécution de couche 3 est un automate dont la mémoire se calcule avant l'exécution »), ch. 6 §6.1 (déforestation, inlining), annexe E.1 (Trellis_fin).

**Gain conceptuel éventuel :** la troncature à r niveaux et la borne de profondeur de pile du PDA (§4.2) et la taille de pile précalculée du StreamContext (§4.2) sont **trois instances d'un seul objet** : une fenêtre statiquement dimensionnée sur un objet coinductif. Le document les traite séparément. Un lemme de troncature unique couvrirait les trois, et donnerait à P3 sa forme générale : *toute fenêtre est un grade, tout grade est connu à la compilation.*

---

## [R-21] Le Th. 40 suppose ℰ₀ complet alors qu'il le présente comme un monoïde de présentation

**Localisation :** annexe E.3.2, p. 254-255 ; chapitre 1 §1.4, p. 23 (ℰ muni d'une quantale [20]) et p. 24 (« Une quantale est complète, donc distributive sur les bornes supérieures infinies. Ce dont on se sert est la composition d'un effet le long d'une suite finie d'opérations »).

**Énoncé actuel :** « Soit ℰ₀ présenté par un ensemble d'opérations Ops et un ensemble de relations Rel […] Si aucune relation de Rel ne fait intervenir à la fois une opération de S et une opération de Ops ∖ S, alors π_S est un morphisme de quantales et, pour tout n ∈ ℕ∞, π_S ∘ φ_n = φ_n ∘ π_S. » Preuve, second temps : « La quantale est complète et son produit distribue sur les bornes supérieures. **En étendant π_S par π_S(⋁ᵢ αᵢ) = ⋁ᵢ π_S(αᵢ)**, on obtient une application qui préserve à la fois le produit et les suprema. »

**Diagnostic :** deux sauts.
1. Une présentation par générateurs et relations produit un **monoïde quotient**, pas un treillis complet. La complétude de ℰ₀ (et la distributivité du produit sur les suprema infinis) est posée au chapitre 1 comme propriété d'une quantale [20] ; elle n'est pas compatible en général avec une présentation libre quotientée, où les suprema infinis n'existent pas (le monoïde libre sur Ops est dénombrable et n'a pas de bornes supérieures pour ses parties infinies). Le document utilise donc deux structures différentes pour ℰ₀ : la quantale complète (ch. 1) et la présentation (annexe E).
2. « En étendant π_S par π_S(⋁αᵢ) = ⋁π_S(αᵢ) » n'est pas une extension légitime : pour que cette définition soit bien posée, il faut que π_S préserve déjà les suprema, ce qui est la conclusion. C'est une pétition de principe de forme.
3. Le chapitre 1 (§1.4, p. 24) avait correctement diagnostiqué le problème et donné la bonne réponse : « La condition qui gouverne ce passage est connue et caractérisée : la fonction de transition d'un automate valué s'étend aux mots si et seulement si la multiplication distribue sur les bornes supérieures **finies**, c'est-à-dire si la structure est un **monoïde ordonné par treillis** [27]. La quantale a donc plus qu'il n'en faut pour ce que l'annexe en fait, et savoir laquelle de ses propriétés porte l'extension est ce qui permettra, le moment venu, de ne mécaniser que celle-là. » L'annexe fait exactement l'inverse : elle utilise le cas n = ω, donc un supremum infini (`ε^ω = ⋁_m ε^m`), donc la complétude, alors que le chapitre 1 avait identifié que la structure minimale suffisante est le monoïde ordonné par treillis.

**Nature :** **D** (dette de preuve) + **E** (deux structures pour un symbole).

**Ce qui reste valide :** la condition sur Rel (aucune relation mixte) est juste, nécessaire, et son statut de point fragile est correctement signalé (« Une extension de ℰ₀ qui introduirait une équation reliant une opération interceptable à une opération conservée romprait la commutation, donc les formes normales, donc la décidabilité de l'appartenance à ℳ. C'est le point où ce monoïde est fragile. »). Les formes normales `φ_n ∘ π_S` et la décidabilité de l'appartenance sont un vrai résultat, et c'est lui qui rend la règle SC inspectable. La distinction π†/π_ℓ est juste. L'exclusion de φ_ℓ de ℳ est une décision de sûreté bien argumentée (« Admettre φ_ℓ dans ℳ rouvrirait donc l'attaque de blanchiment que la déclassification ferme, et le ferait à l'endroit exact où la preuve de non-interférence est la plus fragile, celui du canal temporel »).

**Correction minimale :** énoncer le Th. 40 en deux temps : (i) pour n **fini**, sous l'hypothèse « ℰ₀ est un monoïde ordonné par treillis quotient de la présentation, sans relation mixte » — preuve par récurrence, aucune complétude requise ; (ii) pour n = ω, sous l'hypothèse supplémentaire « ℰ₀ est une quantale et le quotient préserve les suprema » — et nommer cette hypothèse comme une **exigence sur ℰ₀**, pas comme un fait. Le chapitre 1 a déjà écrit la distinction ; il suffit de la descendre dans l'annexe.

**Conséquences interchapitres :** ch. 1 §1.4 (quantale, table 2, φ et ψ), annexe E.1 (ℰ = ℰ₀ × ℕ∞^ℒ), E.3 (règle SC), E.3.2 (ℳ, formes normales, π†, π_ℓ), E.4 (trace τ, Th. 43), E.4.3 (clause de calcul).

**Gain conceptuel éventuel :** nommer la structure minimale (monoïde ordonné par treillis) plutôt que la structure maximale (quantale) permet de **ne mécaniser que ce qui sert**, ce que le chapitre 1 appelle de ses vœux. C'est un gain de mécanisabilité pur, sans perte d'expressivité pour les règles effectivement écrites.

---

## [R-22] Collisions de symboles contre une table normative qui les interdit

**Localisation :** chapitre 1 §1.5, p. 39-40 (table 5, RMQ 10) ; occurrences listées ci-dessous.

**Énoncé actuel :** « Ce document emploie un symbole par objet, et un objet par symbole. La table 5 en fixe la correspondance, et elle est normative : aucune section ultérieure n'introduit de variante locale, et un symbole absent de cette table n'a pas de sens dans ce document. »

**Diagnostic :** la table contient 17 lignes. Je relève 12 collisions et 11 symboles hors table employés normativement.

| # | Symbole | Sens 1 | Sens 2 (et 3, 4) | Où |
|---|---|---|---|---|
| N-01 | **ℛ** | semi-anneau ℚ≥0 ∪ {ω} | produit ℕ∞ × {d⪯m} × ℒ × ℬ | ch. 2 p. 48 / annexe E.1 p. 244 (voir R-04) |
| N-02 | **φ** | action du grade sur l'effet, φ_r | première composante d'un effet, ε = ⟨φ, κ⟩ | table 5 / annexe E.1 p. 244 |
| N-03 | **κ** | famille temporelle ℕ∞^ℒ | compteur d'usages du Th. 45 | E.1 p. 244 / E.4 p. 268 |
| N-04 | **1** | type unité (`() : 1`) | grade unité (`x:^1 V`) ; unité de la quantale (`∣ 1`) ; entier dans `⟨1,1⟩` | E.3 p. 248 : les quatre en six lignes |
| N-05 | **I** | objet unité de la SMCC | ensemble d'indices de sommes/produits ; `I(M)` intervalle admissible | ch. 2 §2.1 / E.1 / table 5 |
| N-06 | **S** | type de session | semi-treillis de `fix f : S →_mon S` ; ensemble d'opérations `π_S` ; état dans `Rejeu(J(H), S₀)` ; modalité temporelle duale de ◇ (glyphe non extrait) | E.1 / ch. 2 §2.4 / E.3.2 / ch. 4 p. 134 / E.3.1 p. 252 |
| N-07 | **M** | mode (table 5 : `M, I(M), F M`) | boîte aux lettres du Th. 25 ; borne haute d'un intervalle `[m..M]` | table 5 / ch. 4 p. 143 / ch. 3 p. 86 |
| N-08 | **r** | grade individuel (table 5 : « r, q grades individuels ») | **région d'arène** dans `WriteCap(r)` (Th. 21, Th. 14) ; profondeur d'historique ; budget de recherche | table 5 / ch. 4 p. 130 / ch. 2 p. 63 / ch. 3 p. 111 |
| N-09 | **π** | projection `c.i` | π_S (conservatrice), π_ℓ (observationnelle), π† | E.3.4 / E.3.2 |
| N-10 | **⊢** | tourniquet du jugement | identité droite (U+22A2, table 24) ; groupe non capturant des R-expressions | E.3 / E.7 p. 283 |
| N-11 | **𝒢** | algèbre des grades | `𝒢` comme genre de sorte (`𝒢en`) ; `𝒢_pile`, `𝒢_budget` (sous-algèbres jamais définies) ; grade de présence (emploi revendiqué identique) | table 5 / E.5.2 / ch. 1 p. 35-36 / ch. 3 p. 108 |
| N-12 | **⊟/⊠** | composition de contextes | l'indice ε est omis « lorsque le contexte le détermine, ce que les règles font partout » — mais §E.3 établit que deux règles seulement ont un indice non trivial, donc l'omission est fautive ailleurs | ch. 1 p. 25 / E.3 p. 247 |

Symboles employés normativement et **absents de la table 5** : `ℳ`, `𝒮`, `𝒢en`, `Ops`, `Rel`, `Trellis_fin`, `niv`, `ℬ`, `𝒟`, `𝒯`, `p` (foncteur de raffinement), `λ` (loi distributive, et aussi loi distributive d'histomorphisme — deux objets distincts que le ch. 2 p. 64 distingue explicitement), `E` (prédicat d'échange), `Cont(m)`, `Exch`, `F_ε`, `U_ε`, `δ_ℓ`, `⊤`, `γ`, `μ` (état d'arène — alors que `μF` est le point fixe), `τ` (trace — alors que τ est aussi le type dans `Δ ⊢ t : τ` du Th. 19).

Deux de ces collisions sont **dangereuses** et pas seulement gênantes :
- **N-08** : `WriteCap(r)` avec r *région* dans le théorème qui fonde P3 et P4, alors que la table normative fait de r un *grade*. Un lecteur (ou un mécaniseur) qui applique la table lit « capacité d'écriture de grade r », ce qui n'a pas de sens, ou pire, ce qui en a un autre.
- **N-02 + N-04** : dans `⟨1,1⟩` (règle TICK), le premier 1 est l'unité de ℰ₀, le second devrait être une famille `δ_ℓ` ; et `φ_r(ε)` où ε = ⟨φ, κ⟩ place deux φ à une lettre de distance dans la même expression — c'est précisément l'expression du Th. 1, dont la preuve est fausse (R-02). La collision rend la faute difficile à voir.

**Nature :** **E**, avec deux cas de gravité **C**.

**Ce qui reste valide :** la table normative est une excellente idée, et RMQ 10 (« La distinction entre Δ et Γ est celle qui coûte le plus cher à enfreindre ») montre que l'auteur sait pourquoi. Le §E.7 traite honnêtement trois coexistences (⊢, #, .) avec un argument de séparation par contexte qui est recevable pour ⊢ et pour `.`, et faible pour `#`. La décision sur les glyphes de liaison (↢/↣ contre ⟜/⊸, parce que « ⊸ est l'implication linéaire de Girard […] et un signe ne peut pas porter deux travaux ») applique exactement le principe — et montre que le document sait le faire quand il le décide.

**Correction minimale :**
1. Étendre la table 5 aux symboles manquants (une vingtaine de lignes) et y ajouter une colonne **niveau** (syntaxe / jugement / sémantique / compilation / représentation), ce qui prépare RT-4.
2. Renommer les quatre collisions dangereuses : `φ_r, ψ_r` → `α_r, β̂_r` (ou garder φ_r et renommer la composante d'effet `ε = ⟨e₀, κ⟩`) ; `κ` du Th. 45 → `ν` ou `#usages` ; `r` de région → `ρ` ; `1` → `𝟙` (type), `1_𝒢` (grade), `1_ℰ` (effet).
3. Appliquer au document la règle qu'il énonce pour les glyphes : « un signe ne peut pas porter deux travaux ».

**Conséquences interchapitres :** toutes ; la table 5 est normative par déclaration.

**Gain conceptuel éventuel :** la colonne « niveau » transforme la table en instrument de vérification automatique des erreurs de niveau (§1.3 de ma grille) : toute règle dont une prémisse et la conclusion sont à des niveaux différents est signalée. C'est le dispositif qui manque pour R-10, R-11, R-12, R-16, R-25.

---

## [R-23] `ε_m` désigne deux effets distincts dans le Th. 32, et le produit `∏_i` y est non commutatif sur un ensemble d'indices non ordonné

**Localisation :** chapitre 5 §5.4.1, p. 179 ; §5.4.2, p. 179 (règle EXPAND) ; §5.4.3, p. 180 (table 11, contrôle 2).

**Énoncé actuel :** §5.4.1 : « Il y a deux effets et non un. **L'effet de l'expansion est vide** : une macro ne peut ni lire un fichier, ni interroger le réseau, ni consulter l'horloge, et c'est ce qui rend l'expansion reproductible. **L'effet du code produit ne l'est pas.** […] C'est le second qu'une interface déclare. » Règle EXPAND : `⊠_i (r_i · Δ_i) ⊢ m(t₁,…,t_n) : B ∣ ε_m · ∏_i φ_{r_i}(ε_i)`. Table 11, contrôle 2 : « **l'effet ε_m majore ce que le corps compose** — lecture des opérations employées ».

**Diagnostic :**
1. Dans §5.4.1, l'effet de l'expansion est **vide** (unité de la quantale) et c'est l'effet du *code produit* qui est déclaré. Dans EXPAND, `ε_m` apparaît comme un facteur non trivial du produit. Dans la table 11, `ε_m` est une **majoration de ce que le corps compose**. Trois lectures, deux objets. Si `ε_m` est l'effet de l'expansion, il vaut 1 et le facteur est inutile ; s'il est l'effet du code produit, alors la règle *calcule* cet effet comme `ε_m · ∏_i φ_{r_i}(ε_i)`, donc l'interface ne le déclare pas ; s'il majore ce que le corps compose, alors le corps de la macro peut contenir du code effectueux du noyau — ce que §5.4.1 exclut.
2. `∏_i` est un produit de la quantale ℰ, dont le chapitre 1 (p. 23) dit explicitement : « L'ordre dans lequel ils surviennent porte de l'information […] dont le produit, **non commutatif**, dénote le séquencement. » Un produit indexé par un ensemble `i ≤ n` sans ordre spécifié n'est donc pas bien défini. L'ordre pertinent est l'ordre d'occurrence des métavariables dans le corps de la macro — qui n'est pas `i ≤ n` en général (une macro peut placer son deuxième argument avant le premier).
3. La règle suppose en outre que l'effet du code produit est **exactement** le produit des effets transportés des arguments. C'est faux dès que le corps de la macro contient du code du noyau effectueux (un `tick`, une `operation_ε`), ce que rien n'interdit et que le contrôle 2 de la table 11 semble au contraire envisager.

**Nature :** **E** (collision) + **C** (énoncé trop fort).

**Ce qui reste valide :** la distinction des deux effets (expansion / code produit) est une observation juste et nécessaire, et le §5.4.1 la motive bien (« Confondre les deux reviendrait à confondre le lieu de la contrainte et le lieu du mécanisme »). Le rattachement du grade déclaré au scalaire `r · Δ` du lemme de substitution est exact. Les quatre contrôles de la table 11 (comptage, majoration, appartenance, comparaison d'index) sont la bonne forme d'interface : syntaxiques, faits une fois à la définition, ce qui rend une bibliothèque tierce auditable. La décision « le grade déclaré est une borne et non un compte exact » est correctement justifiée (le corps qui branche n'a pas de compte exact) et correctement rattachée à la règle du noyau (le joint des branches).

**Correction minimale :** trois noms au lieu d'un : `ε_exp = 1` (par le bac à sable, c'est un lemme et non une déclaration), `ε_body` (l'effet déclaré du code produit par le corps lui-même, hors arguments), et `ε_args = ∏_{i ∈ occ(m)} φ_{r_i}(ε_i)` où `occ(m)` est la **suite** des occurrences des métavariables dans le corps, dans l'ordre du corps. Règle : `… ⊢ m(t₁,…,t_n) : B ∣ ε_body · ε_args`. Contrôle 2 de la table 11 : « ε_body majore les opérations du corps hors occurrences des arguments ».

**Conséquences interchapitres :** ch. 1 §1.4 (quantale non commutative, φ), ch. 2 §2.6 (Th. 11, 12), ch. 5 §5.2 (bac à sable, ℰ = ∅ pendant l'expansion), §5.4 (Th. 32, table 11), annexe E.3.2 (ℳ, π_S : un corps de macro peut-il intercepter ?).

**Gain conceptuel éventuel :** l'ordre `occ(m)` est le même objet que la zone ordonnée du §3.1 (échange restreint) et que l'ordre de séquentialisation du Th. 42 : **une suite finie d'occurrences dans un corps**. Trois endroits du document en ont besoin, aucun ne le nomme. Le nommer (`ordre d'occurrence`) permet d'énoncer une fois la condition de bord du lemme de substitution, l'ordre du produit dans EXPAND et l'ordre de retrait des liaisons dans le Th. 42.

---

## [R-24] Table 8 : la couche 3 a « Δ = ∅ », alors que tout le document — et la même page — dit Δ_ω

**Localisation :** chapitre 5 §5.1, p. 167 (table 8 et le paragraphe suivant) ; chapitre 1 §1.4, p. 35 (équation 2) ; chapitre 5 §5.1, p. 167 (« un calcul de couche 3 — n'ayant besoin que de Δω, présent dans les trois jugements »).

**Énoncé actuel :** table 8, ligne `[ ... ]` Cartésien : « Contexte du jugement germinal : **Δ = ∅** ». Paragraphe suivant : « Le jugement de couche 3 **ne comporte pas de Δ** ; il ne peut donc rien exprimer qui suppose une ressource affine ou linéaire. » Puis, même page : « C'est cette même asymétrie qui permet à un calcul de couche 3 — n'ayant besoin que de **Δω, présent dans les trois jugements** — d'être invoqué depuis n'importe laquelle des trois couches. »

**Diagnostic :** l'équation (2) du chapitre 1 est `Δ_ω ⊢_𝒢 t : A (ℰ = ∅, 𝒢 = 𝒢_pile)`, et tout l'argument du §1.4 pour supprimer la zone Γ est qu'**une liaison non restreinte est une liaison de grade ω**, donc que la couche 3 a un contexte, à savoir Δ_ω. La table 8 et la phrase qui la suit affirment le contraire. Ce n'est pas cosmétique : l'argument de l'imbrication à sens unique (`{ ( [ ] ) }` seulement, ERR-TOP-001) est justifié par « le jugement de couche 3 ne comporte pas de Δ », donc par une prémisse fausse. L'argument *survit* avec la prémisse correcte (un bloc de couche 3 ne peut exiger que des liaisons de grade ω, donc ne peut rien exiger d'affine ou de linéaire, donc ne peut pas être ouvert à l'intérieur d'un bloc qui n'offre que cela) — mais il doit être réécrit, et la table doit dire `Δ = Δ_ω`.

**Nature :** **E** avec conséquence **C** sur la justification d'ERR-TOP-001.

**Ce qui reste valide :** la règle d'imbrication à sens unique, son rattachement aux foncteurs d'inclusion fidèles F₁→₂, F₂→₃, la propriété de grammaire à pile visible qui en découle (« la définition est satisfaite par construction », avec l'analyse linéaire et la forêt d'arbres valides plutôt qu'un choix prioritaire silencieux), et les deux règles de portée (délimiteurs en position de calcul seulement ; sigil deux-points comme espace de noms distinct) sont justes et bien motivées. La règle du sigil est un excellent exemple de correction minimale : « La règle est d'une ligne et elle referme une classe entière d'erreurs silencieuses. »

**Correction minimale :** `Δ = ∅` → `Δ = Δ_ω` dans la table 8 ; remplacer « Le jugement de couche 3 ne comporte pas de Δ » par « Le jugement de couche 3 n'admet que des liaisons de grade ω ». Deux mots.

**Conséquences interchapitres :** ch. 1 §1.4 (équation 2, suppression de Γ), ch. 2 §2.2 (`𝒞_{!ω}` cartésienne), ch. 3 §3.1 (grades par défaut par fragment : ω en cartésien), ch. 5 §5.1 (ERR-TOP-001), annexe A (ERR-TOP-001, 002), annexe E (VAR : `0·Δ, x:^1 V`).

**Gain conceptuel éventuel :** aucun, mais la correction aligne la table 8 sur l'économie revendiquée du chapitre 1 (une seule zone de contexte), qui est l'un des rares gains de complexité *réellement* acquis du document.

---

## [R-25] « Gestionnaire » désigne deux objets de niveaux différents, et l'hypothèse de pureté du Th. 22 est renvoyée à une section qui ne la contient pas

**Localisation :** chapitre 2 §2.3, p. 56 (« Un gestionnaire d'acteur consomme un flux de messages et le replie en un état fini ») et p. 66 (« Un gestionnaire (handler) pour Σ, ciblant un type de résultat R, n'est rien d'autre qu'une F-algèbre sur R ») ; chapitre 1 §1.4, p. 23 (« chaque gestionnaire (handler) un morphisme d'algèbres ») ; chapitre 4 §4.5, p. 134 (Th. 22 : « Les gestionnaires de couche 2 sont des **fonctions pures** (Message × État) → HandlerResult (**chapitre 3, §3.3**) ») ; chapitre 7 §7.2, p. 217 (« La pureté des gestionnaires (**chapitre 2, §2.3**) garantit que ce rejeu reproduit fidèlement l'original »).

**Diagnostic :**
1. **Deux objets, un mot.** (a) Le gestionnaire d'acteur : `(Message × État) → HandlerResult`, couche 2, décrit par le §4.1 comme « une définition par copatrons ». (b) Le gestionnaire d'effet : une F-algèbre sur R, c'est-à-dire une *interprétation* d'opérations, qui par définition **élimine** un effet. Les deux sont dans la même section (§2.3), à dix pages d'écart, sans distinction. Le chapitre 1 emploie le sens (b) (« chaque gestionnaire un morphisme d'algèbres ») puis raisonne sur le sens (a) (« Le corps d'un gestionnaire pouvant être appelé plusieurs fois, il ne peut déplacer aucune valeur de son environnement »).
2. **Les deux renvois de la pureté sont faux.** Le chapitre 3 §3.3 contient une seule occurrence de « gestionnaire », à propos d'un état transitoire modélisé comme effet algébrique ; il n'y est nulle part affirmé que les gestionnaires de couche 2 sont des fonctions pures. Le chapitre 2 §2.3 définit les gestionnaires comme des morphismes d'algèbres, donc comme des *interprètes d'effets* — le contraire d'une fonction pure.
3. **La pureté est en tension avec la couche 2 elle-même.** L'équation (3) du chapitre 1 est `Δ_aff ⊢_𝒢 t : A ∣ ℰ (Δ_aff ≠ ∅, ℰ ∋ tick)` : la couche 2 a des effets, dont tick. Si ses gestionnaires étaient purs, aucun effet n'y serait produit. La lecture qui réconcilie tout est celle d'un **style libre / instructions** : le HandlerResult *décrit* les effets à exécuter, et c'est le runtime qui les exécute (§4.5 : « Au replay, le runtime substitue à chaque appel non déterministe la valeur consignée »). Cette lecture est cohérente, elle est compatible avec les effets à portée [21, 37] et avec l'abaissement en style à passage de capacités [42] — mais **elle n'est écrite nulle part**, et elle change le statut du Th. 22 : la pureté n'est plus une propriété des gestionnaires mais une propriété de la *description* qu'ils produisent.

**Nature :** **E** (collision) + **D** (hypothèse non supportée du Th. 22) + **A** sur la chaîne de justification (P4 repose dessus).

**Ce qui reste valide :** le Th. 22 lui-même, sous la bonne lecture : si le HandlerResult est une description et que le runtime substitue les valeurs journalisées, alors le pli sur J(H) est déterministe. La réserve finale de l'esquisse est juste et importante : « L'argument porte sur la fonction, donc sur la valeur dénotée ; **il ne porte pas sur sa représentation** » — c'est exactement la frontière avec le Th. 23 (R-11). Le rattachement des gestionnaires d'effet aux F-algèbres (Plotkin–Power) est correct, avec la bonne réserve de domaine (effets à portée, théories algébriques paramétrées). L'exclusion des continuations multiples et son motif (la règle de cadre ne survit pas à un bloc entré une fois et quitté deux fois [24]) sont correctement sourcés — et c'est un bon exemple de ce que le document fait de mieux : donner la *vraie* raison plutôt que la raison attendue (« Le motif attendu — le coût de copier des segments de pile — n'est pas le bon, et la littérature l'écarte explicitement »).

**Correction minimale :**
1. Deux mots : **gestionnaire d'acteur** (a) et **gestionnaire d'effet** (b). Une ligne au §1.2 dans la liste des mots à sens fixe — le document a déjà cette liste (« Quatre mots ont ici un sens fixe »), il suffit d'en ajouter deux.
2. Écrire la sémantique d'instructions : « Un gestionnaire d'acteur est une fonction pure `(Message × État) → HandlerResult` ; le HandlerResult est une *description* d'effets, exécutée par le runtime ; c'est cette exécution qui est journalisée. » Puis corriger les deux renvois (ch. 3 §3.3 → cette définition, ch. 2 §2.3 → cette définition).
3. Le Th. 22 gagne alors une hypothèse nommée : **complétude de la journalisation** — toute opération exécutée par le runtime est journalisée. C'est précisément la « borne inférieure » que le §1.3 déclare manquante, et elle devient une hypothèse explicite au lieu d'être un implicite de la preuve.

**Conséquences interchapitres :** ch. 1 §1.3 (P4, borne inférieure), §1.4 (ℰ, continuations), ch. 2 §2.3 (F-algèbres, histomorphisme, hylomorphisme d'acteur), ch. 3 §3.2-§3.3 (état transitoire, effet Import), ch. 4 §4.2 (fibrilles, StreamContext), §4.5 (Th. 22, 23, rejeu, acteurs virtuels), ch. 5 §5.5 (`defhandler`, HandlerResult), ch. 7 §7.2 (Replay Debugger), annexe A (ERR-EFF-001, ERR-MEM-009).

**Gain conceptuel éventuel :** la sémantique d'instructions unifie quatre choses : le HandlerResult, la trace τ (qui est la journalisation des instructions exécutées), la ré-invocation séquentielle d'un grade fini (qui est la ré-exécution d'une instruction), et l'itération φ_n de SC. Toutes sont des *listes d'instructions* sur lesquelles on plie. C'est le même `μF` du chapitre 2, lu comme syntaxe libre d'effets. Le document possède l'objet (« la syntaxe d'un calcul effectueux de type de retour A est l'algèbre initiale μF pour F(X) = A ⊕ Σ(X) », §2.3 p. 66) et ne l'emploie pas pour le HandlerResult.

---

## [R-26] Défauts formels localisés dans les énoncés

Regroupement de six points mineurs mais mécaniquement bloquants, tous vérifiables en une ligne.

| # | Localisation | Défaut | Correction |
|---|---|---|---|
| a | ch. 2 §2.3, p. 57, Th. 2 | `∀f : μF → A, ∃k ∈ ℕ, ∃v, f(x) ⇝_k v` : **x est libre** dans l'énoncé | `∀f, ∀x : μF, ∃k, ∃v` |
| b | ch. 2 §2.3, p. 57-61 | Th. 2 et Th. 4 sont déclarés « instances du théorème 5 » qui vient **après** ; le Th. 5 est donc utilisé avant d'être établi | réordonner (Th. 5 d'abord) ou marquer la dépendance |
| c | ch. 2 §2.4, p. 70 | après le Th. 7 : « la voie est la même que celle du **théorème suivant** » — le suivant est le Th. 8 (point fixe déductif), la voie paramétrique est celle du Th. 10 | renvoi → Th. 10 |
| d | ch. 3 §3.2, p. 105 et RMQ 23 | « au sens du chapitre 4 (**§4.3**) » ; le graphe est construit au **§4.5** | renvoi → §4.5 |
| e | annexe E.3.1, p. 251-252 | la règle WHEN imprimée ne porte **pas** la condition sur les liaisons de Δ₂ que le texte déclare « désormais appliquée ». Cause exacte : voir **R-31** (le symbole de la modalité duale n'existe pas) | écrire la règle avec la condition, une fois le symbole défini |
| f | annexe E.3, p. 249, règle OPEN | la condition de bord est `α ∉ fv(C)` seulement. Si `α ∈ fv(Δ₁)` ou `fv(Δ₂)` ou `fv(ε)`, la conclusion `Δ₁ ⊠₁ Δ₂ ⊢ … : C ∣ ε` contient une variable de type **non liée** | `α ∉ fv(Δ₁ ⊠₁ Δ₂ · ε · C)` |

Le point (f) mérite d'être souligné : le §E.3 (p. 250) écrit « OPEN porte sa condition de bord, α n'apparaissant pas dans le type de sortie : **c'est elle qui rend le témoin inatteignable, et c'est sur elle que la preuve de non-interférence s'appuiera** ». La preuve de non-interférence s'appuie donc sur une condition insuffisante. C'est la règle dont le §E.4.3 dit : « Celles du quantificateur existentiel comptent double, car c'est par elles que passe la preuve de non-interférence. »

**Nature :** **E** pour (a)-(e), **D/C** pour (f).

---

## [R-27] Complexité annoncée des R-expressions : trois écarts entre la classe de machine et la borne

**Localisation :** chapitre 4 §4.2, p. 120-123, figure 7.

**Énoncé actuel :** « @linear pour un automate fini déterministe, @polynomial pour un automate non déterministe, @exponential pour un automate à pile ou du retour arrière explicite » ; figure 7 : « @linear — DFA **O(1)**, masquage SIMD » ; « Pour les motifs non linéaires, la profondeur maximale de la pile du PDA est elle-même un grade r que le solveur SMT vérifie compatible avec la mémoire disponible ».

**Diagnostic :**
1. **`O(1)` pour un DFA.** La reconnaissance d'un motif par DFA est linéaire en la longueur du texte. `O(1)` n'est vrai que *par bloc* ou *par octet*. P3 interdisant de dissimuler un coût, et le document appliquant ce critère à sa propre théorie (« Annoncer une borne sans dire de laquelle des deux versions on parle reviendrait à dissimuler un facteur », §2.3 p. 65), la figure 7 contredit P3 dans le document même qui l'énonce.
2. **`@exponential` pour un PDA.** L'analyse d'une grammaire hors contexte est polynomiale (CYK/Earley en O(n³)) ; l'exponentiel vient du **retour arrière** sur expressions régulières, pas de la pile. L'annotation confond donc deux causes, et le texte les concatène (« un automate à pile **ou** du retour arrière explicite »).
3. **La profondeur de pile du PDA comme grade statique.** Pour un texte de longueur non bornée à la compilation, la profondeur de pile d'un PDA croît avec l'entrée. La rendre statiquement bornée par un grade r exige soit une entrée de longueur bornée statiquement, soit un analyseur **flottant à pile bornée** — et dans ce second cas la classe de langages reconnus rétrécit (une pile bornée donne un langage régulier sur les entrées assez longues). Le document ne dit pas lequel des deux il retient, alors qu'il tranche la question analogue pour la mémoïsation : « l'analyse par dérivée d'une grammaire à pile visible […] donne le même temps linéaire avec une pile, donc un espace proportionnel à la profondeur d'imbrication [12]. **Sur le postulat qui gouverne ce projet, la seconde technique domine la première.** » — c'est exactement le bon raisonnement, appliqué à un cas et pas à l'autre.

**Nature :** **C** (portée) + **G** pour la figure.

**Ce qui reste valide :** l'exposition de la complexité plutôt que son masquage (« sa compilation ne masque jamais la complexité qu'un motif engage, elle l'expose ») est conforme à P3 et c'est un bon choix ; le rejet d'une structure non linéaire dans un contexte @linear comme « preuve d'admissibilité » et non heuristique est juste ; les positions capturées comme paires d'offsets dans le texte source (jamais copiées) sont conformes à P3 ; les deux réserves sur PEG (l'ambiguïté déplacée, pas éliminée — question indécidable [10]) et sur la mémoïsation (l'espace tu [11]) sont d'une honnêteté exemplaire ; la réserve sur le cadre nominal (la déterminisation échoue [13], et la réponse « les automates de cette section opèrent sur des caractères et non sur des noms ») est la bonne réponse, correctement bornée.

**Correction minimale :** (i) figure 7 : `O(1)` → « O(n) en temps, O(1) par bloc » ; (ii) séparer `@stack` (PDA, polynomial en temps, pile proportionnelle à la profondeur d'imbrication) de `@backtrack` (retour arrière, exponentiel) ; (iii) écrire laquelle des deux disciplines de pile est retenue, avec la conséquence sur la classe reconnue.

**Conséquences interchapitres :** ch. 4 §4.2 (fibrilles, « toute exécution de couche 3 est un automate dont la mémoire se calcule avant l'exécution »), §4.5 (protocole Noise comme DFA de couche 3 « en temps constant et sans allocation » — même ambiguïté), ch. 6 (vérificateur de complexité, phase 4), ch. 5 §5.1 (grammaire à pile visible de K7PL lui-même).

**Gain conceptuel éventuel :** le §4.5 (protocole Noise) et le §5.1 (syntaxe de K7PL) et le §4.2 (R-expressions) sont trois analyses de langages par automate. Une seule annexe « classes de motifs et bornes » les couvrirait, avec la même table (machine × temps × espace × classe reconnue), et P3 y serait appliqué une fois.

---

## [R-28] `𝒢_pile` et `𝒢_budget`, sous-algèbres qui *définissent* les couches, ne sont jamais construites

**Localisation :** chapitre 1 §1.4, p. 35-36 (équations 2, 3, 4 et figure 1) ; chapitre 2 §2.2 (ℛ) ; annexe E.4, p. 267 (la quatrième condition de l'analyse amortie tient « par la stratification »).

**Énoncé actuel :** « En couche 3 […] 𝒢 se réduit à l'algèbre de pile ; c'est un λ-calcul pur au sens strict : `Δ_ω ⊢_𝒢 t : A (ℰ = ∅, 𝒢 = 𝒢_pile)` » ; « En couche 1 […] l'échéance temporelle se lit sur les deux composantes […] un budget fini dans les grades, un tick dans les effets : `Δ_lin ⊢_𝒢 t : A ∣ ℰ (𝒢 = 𝒢_budget, ℰ ∋ tick)` » ; « 𝒢_pile et 𝒢_budget sont deux sous-algèbres de ℛ, non deux valeurs. » Et : « **Cette spécialisation, et elle seule, constitue la définition formelle des trois couches du langage** — les chapitres suivants n'en développeront que le contenu, jamais une strate supplémentaire de définition. »

**Diagnostic :** la définition formelle des trois couches — déclarée unique et suffisante — repose sur deux objets qui n'apparaissent nulle part ailleurs : ni générateurs, ni clôture, ni inclusion dans ℛ, ni opérations. Et l'argument d'amortissement de l'annexe E (p. 267) en dépend : « le seul mécanisme amorti du langage vit en couche 2, dont le fragment est affine, quand la couche 1 est linéaire et que **la couche 3, où la duplication serait libre, n'a pas d'effets du tout** » — la quatrième condition (non-duplication d'un porteur de potentiel) tient parce que la couche 3 n'a *pas de potentiel*, ce qui veut dire `𝒢_pile` sans composante de budget. C'est une propriété de `𝒢_pile` qui porte une condition de sûreté d'un théorème, et `𝒢_pile` n'est pas défini.

S'y ajoute la tension P3 / table 7 (niveau 4, « Tas avec ownership », couche 2, « O(1) amorti ») que le chapitre 1 déclare « s'instruire » (p. 15) alors que P3 est un postulat non révisable et que le critère d'admission à la bibliothèque est la borne pire cas. La résolution est à portée : P3 gouverne *la borne synthétisée* et *l'admission à la bibliothèque*, pas le mécanisme interne d'un régime de mémoire — mais cette clause de portée n'est pas écrite.

**Nature :** **D** (objets non construits) + **B** (la définition formelle des couches est incomplète).

**Ce qui reste valide :** l'idée que les trois couches sont trois *restrictions* d'un même jugement, et non trois calculs, est le meilleur résultat d'architecture du document, et la figure 1 la rend lisible. La conséquence qui en est tirée (« le seul endroit du document où l'indice 𝒢 varie ») est juste. La lecture « la sédimentation accueille ce que la couche supérieure refuse » est une propriété d'architecture réelle et utile.

**Correction minimale :** deux définitions d'une ligne chacune, par projection du produit (R-04) :
- `𝒢_pile = 𝕌 × {d} × ℒ × {0}` — usage libre, monotonie discrète, niveau porté, **budget nul** ;
- `𝒢_budget = 𝕌 × {d,m} × ℒ × ℕ∞` — les quatre facteurs.
Puis écrire la clause de portée de P3 : « P3 gouverne la borne synthétisée et l'admission à la bibliothèque. Il ne gouverne ni le coût de compilation (déjà écrit, p. 14), ni l'amortissement interne d'un régime de mémoire, à la condition que la borne synthétisée par les règles soit celle du pire cas (déjà écrit, p. 15). »

**Conséquences interchapitres :** ch. 1 §1.4 (équations 2-4, figure 1, table 3, table 4), ch. 2 §2.2 (ℛ), ch. 4 §4.4 (table 7, niveau 4), annexe E.1 (grade), E.4 (quatrième condition d'amortissement).

**Gain conceptuel éventuel :** avec la projection de R-04, les trois couches deviennent trois **préimages** : couche 3 = `π_𝔅^{-1}({0}) ∩ π_𝕌^{-1}({ω})`, couche 2 = fragment affine × budget libre, couche 1 = fragment linéaire × budget fini. La spécialisation par couche, qui est aujourd'hui une liste de trois équations, devient une fonction `couche ↦ contrainte sur ℛ`, mécaniquement vérifiable — et la condition de clôture du §1.4 (« toute extension doit se projeter sur ces trois composantes ») reçoit enfin un objet sur lequel porter.

---

## [R-29] La discipline d'échange : « voie retenue » au chapitre 3, « envisagée » au chapitre 4 et à l'annexe, « absente » dans les règles

**Localisation :** chapitre 3 §3.1, p. 89-91 ; chapitre 4 §4.6, p. 153 ; annexe E.3, p. 246 ; annexe E.3.5, p. 263.

**Énoncé actuel :** chapitre 3 : « La voie retenue est de porter l'échange comme une donnée de mode […] **Ce point se fixe ici** […] Ce qui change est le lemme de substitution (annexe, théorème 41) : […] **Il acquiert donc une condition de bord** — la substitution est admissible pour la liaison maximale de sa zone. » Chapitre 4 : « Le quatrième [cas résistant] ne résiste pas aujourd'hui mais résisterait demain […] **Si la discipline d'échange restreint envisagée au chapitre 3 (§3.1) était adoptée** […] ». Annexe E.3 : « L'échange est admissible pour une raison distincte et qui tient à un choix ancien : **les contextes ne sont pas ordonnés**. » Annexe E.3.5 : « **Une condition de bord, si l'échange venait à être restreint.** […] Elle en deviendrait une **sous la discipline d'échange envisagée** au chapitre 3. »

**Diagnostic :** un même choix de conception est présenté comme **arrêté** dans un chapitre et comme **hypothétique** dans trois autres, avec des conséquences différentes. Ce n'est pas neutre : le chapitre 3 tire de la voie retenue (i) une condition sur `Cont(m)` et `Exch(q₁,q₂)` (« On ne fusionne deux emplois d'une ressource que si leur ordre est sans importance »), (ii) une condition de bord au lemme de substitution, (iii) un lemme supplémentaire pour la substitution simultanée, (iv) une **perte** à la traduction (« la composition parallèle du calcul cible est commutative : l'ordre d'une zone n'a aucune image dans la traduction […] toute propriété de la source dérivée de la traduction devrait être revérifiée, l'acyclicité du chapitre 4 (§4.5) en étant une »). Si la voie est retenue, ces quatre conséquences sont actives — en particulier la quatrième, qui invaliderait rétrospectivement le Th. 17 et le Th. 24. Si elle ne l'est pas, elles sont conditionnelles.

L'annexe tranche en fait pour la non-adoption (contextes = applications finies, échange admissible), ce qui est cohérent avec l'encodage des protocoles en implications linéaires et avec la commutativité de la cible. Mais le chapitre 3 dit l'inverse, et le dilemme des sous-exponentielles [13] (`E ≠ ∅ ⇒ C = ∅`) qu'il analyse soigneusement n'a plus d'objet si l'échange n'est pas restreint.

**Nature :** **B** (un choix d'architecture non tranché, avec des conséquences opposées selon la lecture).

**Ce qui reste valide :** toute l'analyse du chapitre 3 est de haute qualité et doit être conservée : les trois besoins indépendants d'ordre (séquentiel par session, partiel sur les durées d'emprunt, total sur les positions) et l'argument contre le contexte ordonné unique (« les trois besoins portent trois ordres différents […] qu'un contexte ordonné, n'en portant qu'un, confondrait ») ; le rejet de la zone comme composante du grade, avec la raison algébrique exacte (« faire de la zone une composante du grade demanderait […] r·z = z sur cette coordonnée, ce qui n'a pas d'unité à droite et ne fait donc pas un semi-anneau ») ; le dilemme contraction/décidabilité des subexponentielles et la condition `E ≠ ∅ ⇒ C = ∅` satisfaite par stratification ; la réserve de nature (« une subexponentielle est indexée par un préordre d'étiquettes ; un grade vit dans un semi-anneau préordonné […] Ce qui reste à faire n'est plus de construire le prédicat, mais de le composer avec une algèbre »). Et l'identification de la perte à la traduction est un résultat négatif important, correctement anticipé.

**Correction minimale :** trancher, et écrire la décision une fois au §3.1 avec ses quatre conséquences marquées *actives* ou *conditionnelles*. Ma lecture (Int.) : le document **n'adopte pas** la discipline d'échange — l'annexe, la cible commutative, l'encodage en ⊸ et le Th. 27 le supposent tous — et le chapitre 3 décrit une *extension disponible*, dont il chiffre le prix. La correction est donc : remplacer « La voie retenue » par « La voie disponible, dont le prix est chiffré ci-après », et marquer les quatre conséquences comme conditionnelles. Coût : deux mots, et la suppression d'une contradiction qui touche deux théorèmes.

**Conséquences interchapitres :** ch. 3 §3.1 (mode, Cont, Exch, sous-exponentielles), ch. 4 §4.6 (quatrième cas résistant, perte à la traduction, acyclicité), annexe E.3 (échange admissible), E.3.5 (Th. 41, 42 et leurs conditions de bord), E.4.4 (Th. 47 : « la distinction est sans effet aujourd'hui […] et elle en aurait un sous une discipline d'échange »).

**Gain conceptuel éventuel :** une fois tranché, l'ordre d'occurrence (R-23) et la zone ordonnée deviennent le même objet optionnel, et le document peut énoncer un seul théorème conditionnel : *sous une donnée d'échange E, le lemme de substitution, EXPAND et la substitution simultanée acquièrent la même condition de bord, et la traduction cesse de transporter l'ordre.* C'est une économie de trois énoncés.

---

## [R-30] Trois réserves de portée qui doivent être remontées dans les énoncés

Regroupement de points de nature **C**, chacun déjà identifié par le document mais laissé hors de l'énoncé.

**(a) Th. 30 (hygiène).** L'énoncé porte sur l'AST non gradué ; « l'énoncé gradué suppose donc de savoir ce qu'une macro déclare de ses arguments, question que ce document laisse ouverte » (§5.2, p. 175) — et le §5.4.1 referme la question par le grade déclaré `r_i`. Donc le Th. 30 peut être *étendu* au cas gradué moyennant EXPAND ; il ne l'est pas. Seconde réserve : « l'énoncé porte sur la métasubstitution dans l'AST du noyau, quand le but usuel est la préservation de l'α-équivalence de surface […] Celle-ci ne s'en déduit pas sans une algèbre de liaison de la surface, que ce document n'a pas construite » (resucrage [26]). **Correction** : deux énoncés, Th. 30-nu et Th. 30-gradué (avec EXPAND), et une EXIGENCE de resucrage.

**(b) Th. 19 (préservation du type) contre Th. 43 (préservation) contre Th. 36 (abaissement).** RMQ 24 et RMQ 25 font ici un travail remarquable et rare : « Deux emboîtements de sens contraire. L'un est plus fin, l'autre plus large, et aucun ne contient l'autre […] Trois préservations circulent donc dans ce document, et les nommer sépare ce qui est acquis de ce qui ne l'est pas. […] Ce qui manque à ce document est donc exactement la seconde. » C'est la bonne analyse, et elle est correctement conduite. Il reste que le Th. 19 *énonce* le volet abaissement (« si t se réduit en t′ — par évaluation **ou par abaissement MLIR** ») alors que le texte dit deux pages plus loin : « Le volet abaissement, lui, est revendiqué et non démontré ». **Correction** : scinder le Th. 19 en 19-év (corollaire du Th. 43) et 19-ab (renvoi au Th. 36, non démontré). Le document sait le faire : il l'a fait pour le Th. 26 dans RMQ 30, il faut le faire dans l'énoncé.

**(c) Th. 3 (sédimentation) et la transposition graduée.** RMQ 14 : « ces résultats valent sur des types et non sur des types gradués. **La transposition à la gradation reste à faire, et c'est ce que ce document demande.** » Avec la note de bas de page : « La technique qui rend la preuve possible est le type de chemin d'une théorie cubique, que l'assistant de preuve visé au chapitre 6 n'offre pas. » Donc le Th. 3 — qui est l'énoncé qui « autorise le chapitre 1 à parler de sédimentation » — repose sur une préservation de conteneurs non transposée à la gradation, et la technique de secours n'est pas disponible dans l'outil visé. **Correction** : énoncer le Th. 3 en deux temps (cas non gradué : littérature [28, 29, 30] ; cas gradué : ouvert, route *démonstration*, avec la contrainte d'outil nommée). Le Th. 3 est cité au chapitre 1 comme « établi par un théorème propre et non par la juxtaposition de ceux qui régissent chaque couche » : cette citation doit porter la réserve.

**Nature :** **C** pour les trois.

**Gain conceptuel éventuel :** (b) montre la voie : **un tableau des préservations** (objet préservé × mouvement × statut × lieu) remplacerait trois énoncés et deux remarques, et rendrait la dette lisible en une page. Le document en a déjà la matière (RMQ 25).

---

## [R-31] La modalité duale de ◇ — celle qui rend WHEN correcte — n'a ni nom, ni glyphe, ni clause grammaticale ; vérifié au niveau des objets du PDF

**Localisation :** annexe E.3.1, p. 251 (règle WHEN), p. 252 (trois occurrences), annexe E.1, p. 244 (grammaire des sessions).

**Énoncé actuel :** le §E.3.1 découvre une lacune de la règle WHEN, la diagnostique correctement, et la corrige :

> « Une SECONDE contrainte manque à cette règle […] elle contraint aussi le CONTEXTE : tout canal du contexte doit être d'une forme qui admet elle-même un report indéfini, ce que la modalité duale de ◇ exprime [7]. […] Cette contrainte manque ici, et son absence n'est pas neutre : **elle rend la règle WHEN trop permissive.** […] La correction est directe et se dit en une clause : exiger de chaque liaison du contexte qu'elle soit sous la modalité duale […] **Elle est désormais appliquée**, et la duale porte le nom . »
> « La première est que  ne vit qu'en couche 2. »
> « La deuxième est que la duale se coerce vers l'identité, 𝑆 → 𝑆. »
> « Ce que ce document ne prétend pas est qu'elle se dérive : **elle est ajoutée, et l'ajout est ce qui rend la règle correcte.** »
> « La troisième est que la grammaire des types gagne un connecteur, ce qui met en jeu la condition de clôture du chapitre 1. La condition est tenue, mais pas gratuitement :  se projette sur la composante Δ du jugement germinal. »

**Diagnostic :** le symbole n'existe pas. Je l'ai vérifié **au niveau des objets texte du PDF**, et non par une simple extraction :
- p. 252, ligne « désormais appliquée, et la duale porte le nom . » : un unique span `Luciole-Regular`, aucun glyphe entre « nom » et « . ».
- p. 252, « La première est que  ne vit qu'en couche 2 » : deux espaces consécutives à l'emplacement du symbole.
- p. 252, « la duale se coerce vers l'identité, 𝑆→𝑆 » : le span mathématique est `𝑆→𝑆`, sans opérateur avant le premier `S`. La coercition annoncée est donc `S → S`, c'est-à-dire l'identité — l'énoncé devient vide.
- p. 244, grammaire des sessions : le dernier span est `} ∣○𝑆∣□𝑆∣◇𝑆∣𝑆`. La clause ajoutée est donc **`S ::= … ∣ S`** — une production auto-référentielle vide. Le « connecteur » que la grammaire est censée gagner n'y figure pas.
- p. 251, règle WHEN : la prémisse est `Δ₂, x:^r V ⊢ c : ◇C ∣ ε`, sans aucune condition de bord. La règle **imprimée** est exactement celle que le texte déclare « trop permissive ».

Une cause unique et banale : une macro LaTeX non définie (ou définie vide) qui se propage en quatre endroits. Le document compte trois occurrences prose et une occurrence grammaticale ; il n'y a **aucune** occurrence dans une règle.

**Nature :** **A** (bloquant) pour la règle WHEN ; **E** pour le symbole. C'est le défaut le plus petit et le plus grave du document : une ligne de code source.

**Pourquoi c'est réellement un problème :** quatre conséquences en chaîne.
1. La règle WHEN, telle qu'imprimée, est **fausse** — c'est le document qui le dit, et sa correction n'a pas été appliquée. Or WHEN est la règle d'élimination de ◇, donc la seule porte d'entrée de l'éventualité, donc le seul endroit où le document traite l'attente non bornée : la modalité dont le §4.5 (p. 146) dit qu'elle porte le débit des transducteurs, et dont le §1.3 (p. 15) dit qu'elle est « le seul endroit où K7PL accepte l'imprévisible, et il l'accepte en le marquant ».
2. La grammaire des types contient une production vide, donc le prédicat « type bien formé » est mal défini (S ::= S admet une dérivation infinie).
3. Le contrôle de clôture du chapitre 1 est invoqué pour un objet sans nom : «  se projette sur la composante Δ du jugement germinal — c'est un coeffet ». La vérification de la condition de clôture porte sur un symbole absent.
4. **Le croisement mécanique revendiqué ne l'a pas détecté.** Le §E.1 (p. 244) : « Le croisement est vérifié mécaniquement à chaque construction du document, et il fait échouer celle-ci dès qu'un constructeur apparaît dans une règle sans figurer à la grammaire, ou l'inverse. » Une clause `S ::= S` « figure » dans la grammaire et ne gouverne aucune règle : le contrôle passe. C'est donc un cas où l'auto-vérification annoncée est insuffisante par construction — elle compare des présences, pas des arités ni des occurrences utiles.

**Ce qui reste valide :** l'analyse est excellente et doit être conservée mot pour mot. Le diagnostic (il faut contraindre le contexte et pas seulement la conclusion), la source [7], le motif (« puisque le processus peut attendre une durée indéfinie, la communication sur la conclusion et sur tout canal du contexte doit pouvoir être reportée d'autant »), le contre-exemple implicite (« Un canal du contexte porteur d'une échéance fixe serait rompu par cette attente »), la sémantique de la duale (« disponible maintenant, et disponible encore après une attente de durée non bornée »), la direction de la coercition (duale → identité, et non la réciproque), la restriction à la couche 2, et le rattachement à la strate coeffet : tout est juste. Il ne manque que le symbole.

**Correction minimale :** définir le glyphe (par exemple `𝕊` ou `▭`, en respectant la cinquième règle d'admission du §E.7 : « aucun couple de glyphes ne se ressemble à l'œil » — et en évitant `S`, qui a déjà cinq sens, N-06), l'ajouter à la table 5, écrire la clause `∣ 𝕊S` dans la grammaire de S, et écrire WHEN avec la condition :

$\frac{\Delta_1 \vdash v : \Diamond V \qquad \Delta_2,\, x{:}^{r} V \vdash c : \Diamond C \mid \varepsilon \qquad \forall y \in \Delta_2,\ \operatorname{sort}_\Diamond(y)}{\Delta_1 \boxtimes_1 \Delta_2 \vdash \mathtt{when}\ x = v\ \mathtt{in}\ c : \Diamond C \mid \varepsilon[\omega/k]}$

avec `sort_◇(y)` signifiant « la liaison y est sous 𝕊 ». Trois lignes.

**Conséquences interchapitres :** annexe E.1 (grammaire, croisement mécanique), E.3.1 (WHEN, clôture), ch. 1 §1.5 (table 5), §1.4 (condition de clôture), ch. 4 §4.5 (modalités temporelles et débit, transducteurs), ch. 1 §1.3 (perte de borne sous ◇, WCET), ch. 2 §2.4 (le temps comme quatrième structure ordonnée).

**Gain conceptuel éventuel :** la duale de ◇ et `□` sont deux modalités de disponibilité dans le temps — `□V` dit « disponible à tout instant », `𝕊V` dit « disponible maintenant et après toute attente non bornée ». Ce sont presque le même objet, et le document le sent (« □ ressemble à la modalité d'usage sans lui être identique »). Une fois le symbole posé, il faut écrire la relation entre `□` et `𝕊` (probablement `□V ⊆ 𝕊V`, puisque ce qui est disponible à tout instant survit à une attente non bornée) — et cette relation, si elle tient, **supprime un connecteur** : la grammaire n'en gagne pas un, elle en réutilise un. C'est exactement le type d'économie que la condition de clôture du chapitre 1 réclame, et elle est à portée d'une ligne.

---

# TROISIÈME PARTIE — CAUSES RACINES ET CORRECTIONS TRANSVERSALES

Cinq causes produisent, à elles cinq, la quasi-totalité des 30 critiques ci-dessus. Je les donne dans l'ordre du rapport bénéfice/coût.

## RT-1 — Absence de typage épistémique et de niveau des énoncés

**Symptômes produits :** R-06 (statuts contradictoires du Th. 27, environnement unique), R-10 (Th. 26), R-12 (Th. 18), R-13 (Th. 34), R-14 (Th. 16), R-16 (Th. 20), R-18 (Th. 31), R-19 (Th. 7 et 10), R-21 (Th. 40), R-25 (Th. 22), R-30 (Th. 19, 30, 3).

**Cause :** un seul environnement normatif, qui classe la *forme* (Théorème + Déclaration + Esquisse + □) et non la *nature*. Le document a déjà la taxinomie conceptuelle — il l'écrit au §1.2 (postulat / théorème / engagement / lecture / réserve / obligation / exigence) — mais elle reste dans la prose d'introduction et n'est pas projetée sur les 51 énoncés.

**Abstraction manquante :** un **sceau à deux axes** sur chaque énoncé :
- axe 1 (statut) : DÉFINITION · THÉORÈME · PROPOSITION (esquissée) · CONJECTURE · EXIGENCE · LITTÉRATURE ;
- axe 2 (niveau) : LANGAGE · COMPILATION · REPRÉSENTATION · DÉPLOIEMENT.

**Effet :** 11 énoncés changent de case sans qu'un mot de leur contenu change. La part du document qui est *démontrée au niveau du langage* apparaît alors clairement — et elle est réelle : Th. 5, 8, 11, 12, 13, 15, 37, 38, 39, 40(n fini), 41, 42, 43, 44, 46, 48, 49, 50. C'est un noyau de 18 résultats, ce qui est beaucoup pour une spécification non mécanisée, et le document ne le sait pas.

**Coût :** typographique. Aucun contenu ajouté.

## RT-2 — Deux algèbres de grades, et une action scalaire non définie sur deux facteurs

**Symptômes produits :** R-02 (Th. 1 faux en ω), R-04 (ℛ double, 1/N absent, singletons contre intervalles), R-05 (niveau d'un calcul), R-22 (N-01, N-04), R-24 (Δ = ∅), R-28 (𝒢_pile, 𝒢_budget), R-20 en partie.

**Cause :** le grade a été construit par accrétion — usage (Granule), monotonie (Datafun), niveau (Marshall–Orchard), budget (coût) — et chaque ajout a été justifié par « une structure ordonnée de plus, les lois passent au produit ». Le §1.4 (p. 21) énonce les trois conditions d'admission ; elles sont **insuffisantes** : une composante de grade doit être soit un module sur le semi-anneau d'usage, soit un ordre pur sur lequel l'action scalaire est triviale. Cette distinction n'est pas faite, donc `r · Δ` et `0 · Δ` — qui apparaissent dans VAR, BOX, APP, VECI, SC — n'ont pas de définition sur deux facteurs sur quatre.

**Abstraction manquante :** la **décomposition module × ordre** du grade :
$$\mathcal R \;=\; \underbrace{\mathbb U \times \mathfrak B}_{\text{module sur }\mathbb U} \;\times\; \underbrace{\mathbb M \times \mathcal L}_{\text{ordre pur, action triviale}}$$
avec 𝕌 = ℚ≥0 ∪ {ω} (le ℛ du chapitre 2), 𝔅 = ℕ∞ muni de `⊖` continu en ω (R-02), et les deux projections `π_mod`, `π_ord`.

**Effet :** (i) les fragments catégoriques du §2.2 deviennent `𝒞_{!π_𝕌^{-1}(S)}` — singletons et intervalles coexistent sans conflit ; (ii) les modalités du §3.1 (table 6) sont des intervalles de 𝕌, et les fragments logiques des singletons de 𝕌 — la table 6 dit lequel des deux elle donne ; (iii) `1/N` revient dans le noyau formel ; (iv) `r · Δ` est défini ; (v) le niveau d'un calcul (R-05) devient un indice ℓ de dérivation, distinct du niveau `niv(r)` d'une liaison, et la fonction manquante existe ; (vi) `𝒢_pile` et `𝒢_budget` sont des préimages de projections ; (vii) la condition de clôture du §1.4 devient vérifiable : une composante nouvelle est admissible ssi elle est un module sur 𝕌 ou un ordre pur à action triviale.

**Coût :** un renommage, trois définitions, une table d'arithmétique. C'est la correction la plus rentable de cette revue : elle répare sept critiques dont deux bloquantes.

## RT-3 — Le noyau formalisé est séquentiel ; le langage décrit est concurrent

**Symptômes produits :** R-01 (règles et grammaires), R-07 (asynchrone/SPSC), R-15 (WriteCap), R-17 (graphe de câblage), R-25 (gestionnaires), et la moitié couche 2 des Th. 17, 21, 22, 24, 25, 26, 27, 28, 45, 47, 51.

**Cause :** deux objets portent le même nom « couche 2 » : (a) le fragment affine du λ-calcul gradué, avec effets et modalités temporelles, qui est **formalisé** à l'annexe E ; (b) le calcul de processus avec acteurs, canaux, boîtes aux lettres, jonctions, arènes et supervision, qui est **décrit** aux chapitres 4 et 7 et **construit dans la cible**. Le document passe de (a) à (b) par l'équation `K7PL = (λ-linéaire) ⊂ (π-calcul + Join Patterns)`, en lisant l'inclusion dans le sens qui l'arrange : formellement, c'est une traduction d'un calcul séquentiel vers un calcul de processus ; rhétoriquement, c'est une identification du langage source à un langage concurrent.

**Abstraction manquante :** aucune — il manque une **frontière déclarée**. C'est le cas où la plus petite correction est une clarification, et où toute abstraction supplémentaire serait gratuite.

**Effet des deux voies possibles :**
- *Voie de restriction* (recommandée) : le noyau est séquentiel ; la concurrence est une propriété de la cible et de l'abaissement ; les théorèmes distribués sont requalifiés (énoncés sur la cible, ou exigences d'implémentation). Le document perd la revendication « un seul langage, trois couches, dont une concurrente » et gagne la possibilité de mécaniser ce qu'il a. Les trois études de cas du chapitre 7 deviennent des descriptions d'abaissement, ce qu'elles sont déjà en fait.
- *Voie d'extension* : ajouter `S ⊆ V`, six constructeurs de termes, leurs règles, une sémantique à configurations multiples. Le document gagne la cohérence et double l'annexe.

**Coût :** voie 1, une page ; voie 2, quarante.

## RT-4 — Aucune déclaration de ce qu'une passe, une représentation ou un environnement doivent préserver

**Symptômes produits :** R-08 (trace contre optimisation), R-11 (≈_obs contre =_bit, E_repro), R-12 (NaN et machine), R-16 (versions de spécifications), R-20 (troncature et borne), R-21 (complétude de ℰ₀), R-30b (trois préservations), R-09 en partie.

**Cause :** le document multiplie les propriétés de préservation — sémantique (P1), graduée (Th. 36), de trace (Th. 43), de projection (Th. 46, 47), de disposition (Th. 20), de représentation (Th. 23) — sans jamais dire lesquelles sont **obligatoires pour qui**. P1 fournit un morphisme de correction *dans C*, donc sur la dénotation ; or la non-interférence temporelle exige une préservation de `π_ℓ(τ)`, qui est strictement plus forte, et l'identité binaire exige une injectivité observation/représentation, qui est strictement plus forte encore.

**Abstraction manquante :** un **ordre de préservation** à quatre niveaux, et une table d'assignation :

| Invariant | Objet | Qui doit le préserver |
|---|---|---|
| P-dén | dénotation dans C | toutes les passes (P1) |
| P-grad | jugement gradué Δ ⊢_𝒢 c : C ∣ ε | passes d'abaissement (Th. 36) |
| P-trace(ℓ) | π_ℓ(τ) | passes appliquées à une unité ℓ-sensible |
| P-repr | identité binaire de l'état observable | environnement (E_repro élargi, R-11) |

**Effet :** (i) le conflit `fix f` / évaluation semi-naïve (R-08) se résout par le marquage ℓ-sensible ; (ii) les Th. 18, 20, 23, 26 deviennent des exigences de P-repr, avec un **profil de représentation** unique Π = ⟨vArrow, vCapnp, vMLIR, arch, modèle mémoire, mode d'arrondi, version de schéma⟩ dont E_repro, la portée « une machine » du §4.5 et la convention d'élision du §1.4 sont des projections ; (iii) la phrase du chapitre 1 « Aucune affirmation ne figure sans qu'un postulat, un théorème ou une construction établie la porte » devient vérifiable, parce que chaque énoncé dit de quel invariant il relève.

**Coût :** une table, quatre définitions, trois lemmes de compatibilité.

## RT-5 — Pas de registre unique des obligations, donc pas de propagation des corrections

**Symptômes produits :** R-06 (sept mentions du Th. 27, trois statuts), R-01 (§E.6 contre l'introduction de l'annexe), R-03 (la clause de taille jamais propagée aux acteurs), R-05 (l'incertitude 1 du §E.5.6 jamais remontée dans les règles), R-17 (renvois §4.3), R-19 (règle 10 non corrigée après la découverte du §E.4.5), R-24 (table 8 contre équation 2), R-29 (échange retenu/envisagé), **R-31 (une correction annoncée « désormais appliquée » et jamais appliquée, faute de symbole)**, T-06/T-42/T-43/T-44/G.1/G.3 non résolus, quatre comptes différents des travaux ouverts.

**Cause :** le document se corrige en continu — c'est sa grande qualité, et il le revendique (« un document qui ne relit pas ses engagements finit par s'accuser de dettes qu'il a payées ») — mais il corrige **en avant** et ne propage pas **en arrière**. Chaque correction est écrite là où elle est découverte, avec une remarque marginale (RMQ) qui la signale ; les énoncés antérieurs ne sont pas mis à jour. Le résultat est un document stratifié au sens géologique : les couches récentes sont justes, les couches anciennes contredisent.

**Abstraction manquante :** un **registre normatif des obligations** (O-nn), en annexe, avec pour chaque entrée : énoncé, niveau (RT-1), statut, dépendances amont et aval, route (RMQ 2 : littérature / démonstration / mesure). Plus une règle de propagation écrite au §1.2 : *toute correction est propagée à toutes ses mentions ; une mention non propagée est une erreur.*

**Effet :** les identifiants T-xx et G.x sont résolus ou supprimés ; les quatre comptes de travaux ouverts deviennent une vue du registre ; la table 1 des engagements devient une vue du registre filtrée par statut = engagement ; la borne inférieure de P4, que le §1.3 déclare manquante alors que le Th. 46 la démontre, est marquée payée. Le document devient **auditable en une heure** au lieu de demander une lecture de 285 pages.

**Coût :** une annexe de deux pages, générée pour moitié de ce qui existe déjà (§E.6, table 1, §E.5.6).

---

# QUATRIÈME PARTIE — FACTORISATIONS : ce qui est déjà unifié, ce qui peut l'être, ce qui ne doit pas l'être

## 4.1 Ce que le document unifie déjà correctement (à conserver tel quel)

Je le dis parce que c'est l'essentiel de sa valeur, et parce qu'une revue qui ne le dirait pas serait malhonnête :

1. **Th. 5 absorbe Th. 2 et Th. 4.** Le document le fait lui-même, avec la bonne méthode (« Les deux énoncés qui précèdent ne sont pas deux théorèmes, et ils ont été écrits comme les deux instances qu'ils sont »), la bonne justification de non-gratuité (« Un paramètre dont les deux valeurs diffèrent matériellement n'est pas une commodité de présentation ») et la bonne réserve (le paramètre ne court que sur deux couches). C'est un modèle de factorisation légitime. *Sous réserve de R-03.*
2. **§2.6 : trois schémas (commutation, préservation par traduction, tri topologique) + un lemme de capacité**, instanciés par Th. 30, 31, 32, 36, 48, 21, 26, 24, 17. L'économie est réelle et vérifiable.
3. **§2.4 : la modalité graduée sur une structure ordonnée** comme procédé unique, avec quatre instances (monotonie, confidentialité, budget, temps). C'est la meilleure idée d'architecture du document, et l'argument « la confidentialité n'ajoute pas un axe au langage mais instancie celui que la monotonie a ouvert » est exactement le bon.
4. **Th. 9 : le système de raffinement** comme objet dont l'effacement Phase 8, la non-interférence et l'ordre de précision sont trois lectures. L'idée est juste et le rattachement à [1] est correct. *Sous réserve de sa dépendance au Th. 27.*
5. **Th. 38 : `⊠` généralise `+`**, avec l'observation historique forte : les présentations indépendantes des systèmes gradués « n'ont donc pas fait un autre choix — elles travaillaient dans le cas où les deux opérateurs se confondent ». C'est un véritable résultat de positionnement.
6. **Le grade de présence = fragment affine** (§3.3), **la conjonction additive = partage de contexte** (§E.3.4), **le copatron = acteur** (§4.1), **l'histomorphisme = catamorphisme sur foncteur enrichi** (§2.3), **l'itération induite = annotation d'effet d'un flux** (§1.4) : six identifications correctes, chacune évitant un mécanisme.
7. **L'inexpressibilité** comme mode de garantie unique, avec ses quatre emplois (§1.4, p. 33) et son coût nommé (§5.2, p. 174 : « Une violation inexprimable ne se diagnostique pas »). C'est une vraie contribution de conception.

## 4.2 Trois « théorèmes aspirateurs » disponibles, non encore écrits

**(i) Schéma de transport-échelle (naturité graduée).** Les Th. 1, 38, 48, 32, et les cas LET/APP du Th. 41 et du Th. 47 sont des instances d'un seul carré de naturité : pour toute transformation T définie par récurrence et toute mise à l'échelle `r·(−)`,
$$T(\Delta_1 \boxtimes_\varepsilon \Delta_2) \;=\; T(\Delta_1) \boxtimes_{\varphi_r(\varepsilon)} T(r\cdot\Delta_2).$$
Le document constate le phénomène sans le nommer (« Une loi qui sert trois fois à trois endroits appartient aux fondations », ch. 1 p. 29 ; « quatre démonstrations la réclament ensuite, et aucune n'a de raison de la redécouvrir », ch. 2 p. 49). **L'écrire une fois comme schéma, avec sa condition (R-02) et ses cinq instances, supprime cinq redites et localise la faute arithmétique en un seul endroit.**

**(ii) Schéma de projection par niveau.** `π_ℓ` apparaît quatre fois : projection du journal (Th. 46), clause de calcul de la relation logique (§E.4.3), restriction de sortes (§E.5.5), famille d'effacements `⟦·⟧_ℓ` (§2.5). Le document le voit à moitié (« la table 21 cesse d'être une coïncidence de forme : π† efface des genres, π efface au-dessus d'un niveau, et ce sont les deux projections de la sorte »). **Un seul objet `π_ℓ : (traces, sortes, dérivations, journaux) → (·)_ℓ` avec une loi de commutation aux quatre traductions** absorberait le Th. 46, la clause de session, la famille d'effacements et la borne inférieure de P4. C'est le plus gros gain disponible après RT-2.

**(iii) Schéma de ré-invocation bornée.** Cinq mécanismes sont la même chose : la traduction d'un grade fini n (`n` canaux ré-invoqués en séquence), VECE (`∏_{i<n} ε(i)` et `n·Δ2`), SC (`φ_n`), EXPAND (`φ_{r_i}`), et l'image de `fix` (h itérations, Th. 49). Le document le découvre pour deux cas seulement (« Les deux cas résistants qui restaient partagent donc un seul appareil », §E.4.6). **Le nommer — `reinvo(n, t)` avec sa loi de coût `φ_n` — unifie cinq énoncés et rend la règle EXPAND, VECE, SC et le Th. 49 corollaires.**

## 4.3 Deux factorisations à **refuser**

Conformément au principe « ne pas confondre factorisation et uniformisation », je signale deux fusions tentantes qui seraient des erreurs :

1. **Ne pas fusionner π† et π_ℓ.** Elles ont la même forme et des emplois opposés ; le document le démontre (« Employer la première là où la seconde est requise ouvrirait le canal temporel dans la démonstration même qui prétend le fermer »). C'est une relation (deux projections d'un même objet de sortes), pas une identité. Le §23 de ma grille s'applique : mêmes objets ? oui. Mêmes invariants ? **non**. Donc relation, pas fusion.
2. **Ne pas fusionner les tailles inductives et coinductives.** C'est exactement l'erreur que produit R-03 : le Th. 5 unifie *le schéma*, et l'unification du schéma a entraîné l'unification de l'objet (une seule sorte de taille, ℕ∞ ∖ {ω}), ce qui casse le côté coinductif. La bonne factorisation est : **un schéma, deux sortes**. Le document a déjà le vocabulaire pour le dire (« la couche détermine déjà la polarité », §4.2 p. 124) ; il lui manque de l'appliquer aux tailles.
3. (bonus) **Ne pas fusionner Th. 19, Th. 36 et Th. 43.** RMQ 24-25 le démontrent : leurs emboîtements sont de sens contraire et aucun ne contient l'autre. C'est un cas où le document a *résisté* à une fusion tentante, et il a eu raison. À conserver.

---

# CINQUIÈME PARTIE — VERDICT GLOBAL

## 5.1 Les six questions

**1. Quelle est l'architecture conceptuelle réelle du projet ?**

Non pas « un langage à trois couches », mais : **un système de raffinement de types au sens de Melliès–Zeilberger, dont la base est un λ-calcul CBPV séquentiel, dont les fibres sont ordonnées par un produit mixte de quatre structures ordonnées, et dont le foncteur d'effacement est une traduction vers un π-calcul réflexif local à motifs de jonction et à sortes.** Les trois couches sont trois restrictions du même jugement ; les mécanismes du langage sont des instances de quatre procédés (modalité graduée sur une structure ordonnée ; inexpressibilité ; ré-invocation bornée ; projection par niveau) ; les garanties sont trois schémas de métathéorie instanciés. Cette architecture est **réelle, cohérente et originale dans son assemblage** — aucune de ses briques n'est nouvelle, et le document le dit (« Rien de ce qui suit n'est propre à K7PL », ch. 2 p. 45), ce qui est la bonne posture. Ce qui est propre au projet est le *choix des briques* et leur ajustement : CBPV comme sortie du triangle de Pédrot–Tabareau, le budget comme potentiel, la famille temporelle indexée par niveaux, π† contre π_ℓ, l'échange porté par le mode et non par le grade.

**2. Quel est son noyau théorique le plus fort ?**

À mon jugement, dans cet ordre :
- **Le dispositif CBPV + graduation** (§1.4, annexe E.3). C'est le seul endroit du document où une contrainte d'architecture *résout* un problème connu au lieu de le contourner : la séparation valeurs/calculs donne simultanément la thunkabilité (sortie du triangle [40]), la non-interférence de phase (les cinq effacements), les effets comme capacités sans fonctions de seconde classe [41, 42], et l'économie d'une annotation sur la flèche (§E.3, p. 249). Et les règles imprimées réalisent effectivement cette discipline — je l'ai vérifié sur le point sensible (duplication d'une ressource capturée par un thunk).
- **La modalité graduée sur une structure ordonnée comme procédé unique** (§2.4), avec la dualité confidentialité/intégrité placée des deux côtés de l'adjonction.
- **La distinction π† / π_ℓ** (§E.3.2, §E.4.3) et la famille temporelle `κ ∈ ℕ∞^ℒ` (Th. 37) : c'est ce qui permet d'énoncer le canal temporel, et le document a raison de dire que c'est là que la preuve doit travailler.
- **Le lemme de substitution à trois niveaux et la loi de cohérence** (§E.3.5) : l'objet est bien conçu — terme, type, grade ensemble, avec la découverte *a posteriori* de la loi qui les tient. Sauf que la loi est fausse en ω (R-02).
- **L'analyse d'amortissement comme potentiel** (§E.4, p. 267), avec la quatrième condition obtenue par stratification et non par clause.

**3. Quelles sont les abstractions manquantes ?**

Quatre, et elles sont toutes *petites* :
- la décomposition **module × ordre** du grade (RT-2) — c'est la plus urgente, elle répare deux défauts bloquants ;
- le **niveau courant d'une dérivation** comme indice du jugement (R-05) — sans lui, l'axe confidentialité n'est pas énonçable ;
- les **deux sortes de tailles** (R-03) — sans elles, aucun processus non borné n'est typable ;
- l'**ordre de préservation** P-dén / P-grad / P-trace(ℓ) / P-repr (RT-4) — sans lui, optimisation et non-interférence s'excluent.
S'y ajoutent trois schémas aspirateurs déjà présents à l'état diffus (§4.2) : transport-échelle, projection par niveau, ré-invocation bornée.

**4. Quels sont les défauts réellement bloquants ?**

Six, dans l'ordre :
- **R-31** : la modalité duale de ◇, dont le document écrit qu'elle « est désormais appliquée » et qu'elle « est ce qui rend la règle WHEN correcte », n'a ni nom ni glyphe ni clause grammaticale — vérifié au niveau des objets du PDF. La règle WHEN imprimée est donc exactement celle que le texte déclare trop permissive, et la grammaire des sessions contient une production vide `S ::= S`. C'est le plus petit défaut du document (une macro LaTeX) et l'un des plus graves, parce qu'il invalide une correction annoncée comme acquise.
- **R-01** : le noyau formel ne contient ni canaux, ni communication, ni acteurs, ni capacités, ni arènes ; six règles temporelles concluent des types que la grammaire n'engendre pas ; les deux règles de formation de contexte sont annoncées et absentes. Conséquence : la moitié distribuée du document (Th. 17, 21, 22, 24, 25, 26, 28, 45, 51 et le groupe « couche 2 » du Th. 27) n'a pas de support.
- **R-02** : la loi de cohérence est fausse au grade ω, avec contre-exemple en deux lignes, et elle est invoquée par six démonstrations.
- **R-03** : la clause de taille interdit les acteurs et flux non bornés, et invalide la preuve duale du Th. 5.
- **R-04** : ℛ a deux définitions incompatibles ; les grades fractionnaires 1/N sont hors noyau formel ; la contraction devient disponible dans le fragment affine sous la lecture intervalle.
- **R-05** : le niveau d'un calcul est utilisé par cinq démonstrations et produit par aucune règle.
Les trois premiers sont réparables en moins de dix pages. Le quatrième en une page de renommages. Le cinquième en un indice et six clauses de règles. **Aucun n'est fatal au projet.**

**5. Quelles affirmations doivent être affaiblies ou mieux conditionnées ?**

Par ordre d'importance :
- « Le théorème 27 est donc démontré » (§E.4.6) → *l'induction est planifiée, ses quatre cas résistants sont réduits à des objets construits, elle n'est pas conduite* (c'est déjà ce que disent le ch. 2, le ch. 4 et le ch. 6).
- « La non-interférence graduée et la divulgation délimitée cessent d'être bornées au fragment sans communication » (§E.5.5) → *elles restent bornées au fragment sans communication, parce que le fragment avec communication n'a pas de règles* (R-01).
- « Aucune obligation ne déborde de ces trois » (Th. 34) → *aucune des formes de déclaration du chapitre 6 n'en demande une quatrième ; le chapitre 1 donne un contre-exemple à la nécessité*.
- « le système hôte ne peut y accéder après le retour » (Th. 26) → *exigence sur la représentation de la passerelle* (RMQ 30 le dit déjà).
- « l'égalité observationnelle se transporte en identité de représentation » (Th. 23) → *sous une hypothèse d'injectivité observation/représentation, et sous un E_repro élargi à l'architecture*.
- « préservant les lois algébriques de la théorie des roues » (Th. 18) → *retirer, ou subordonner à une table de propagation spécifiée par K7PL*.
- « l'audit des dix-huit familles d'erreurs » (Th. 16) → *énumération sur les 35 constructeurs du noyau, le catalogue de l'annexe A étant déclaré non exhaustif*.
- « les trois dispositions coïncident bit à bit » (Th. 20) → *pour un profil de représentation Π donné*.
- « la syntaxe d'un programme est fixée à l'issue de la Phase 0 » (Th. 29) → *Phase 0 à ajouter au pipeline* (R-09).
- « la dérivation est déterministe puisque l'inférence est principale » (Th. 35) → *sous une hypothèse D_det de déterminisme des parcours, recherches et graines*.
- « l'ordre que rien ne permet d'inverser » (§6.1) → *le §6.3 le dit déjà : « à cet endroit précis, c'est un choix d'ingénierie présenté comme une contrainte logique »*.
- « la couche 2 est un π-calcul enrichi de motifs de jonction » (§1.4, §4.6) → *la traduction de la couche 2 séquentielle est un fragment d'un tel calcul ; les acteurs, boîtes aux lettres et jonctions sont des objets de la cible et de l'abaissement*.
- « 𝒞_{!S} » avec S = {1}, {0,1}, {ω} (ch. 2) contre Lin = [1..1], Aff = [0..1], Unr = [0..ω] (ch. 3) → *choisir, et dire que les singletons sont les fragments logiques et les intervalles les modalités de type*.
- « la transposition à la gradation reste à faire » (RMQ 14, Th. 3) → à faire remonter dans la citation que le chapitre 1 fait du Th. 3.
- « Le jeu de règles de typage lui-même, dont l'absence est ce qui suspend les quatre preuves ouvertes » (ch. 1, p. 6) → *les règles existent (§E.3) ; ce qui suspend les preuves est leur incomplétude (R-01) et les cinq objets de RT-2/RT-3*.

**6. Quelles corrections réduisent simultanément la complexité et augmentent la rigueur ?**

Cinq, dans l'ordre du rapport :
1. **RT-1 (sceau à deux axes)** : coût typographique, supprime 11 faux théorèmes, révèle 18 résultats acquis.
2. **RT-2 (module × ordre sur le grade)** : une page, répare R-02 et R-04 (deux bloquants), rend R-05 et R-28 énonçables, mécanise la condition de clôture.
3. **RT-5 (registre des obligations)** : deux pages, supprime sept contradictions de statut et quatre comptes incompatibles, rend le document auditable.
4. **R-01 voie 1 (frontière noyau/cible)** : une page, requalifie neuf théorèmes, réduit la dette à un noyau mécanisable.
5. **RT-4 (ordre de préservation)** : une table, résout le conflit optimisation/confidentialité et unifie E_repro, la version de schéma et la portée « une machine ».
Total : **moins de dix pages ajoutées, et le document passe d'un état où 51 énoncés sont des conditionnelles non typées à un état où 18 résultats sont démontrés, 12 sont démontrés sous hypothèses nommées, 9 sont de la littérature correctement située, 11 sont des exigences de représentation, et 5 sont des conjectures avec analyse d'impact.** C'est un gain net de rigueur *et* de taille conceptuelle.

## 5.2 Évaluation

$$\boxed{\text{Architecture} \;\big|\; \text{Cohérence} \;\big|\; \text{Solidité des preuves} \;\big|\; \text{Factorisation} \;\big|\; \text{Mécanisabilité}}$$

**Architecture — forte, et c'est le résultat principal du document.**
Le germe est réel et il n'est pas décoratif : l'adjonction valeurs/calculs lue comme système de raffinement, avec deux modalités graduées et une strate d'obligations, explique effectivement la coexistence des mécanismes. Le test que j'applique — « combien de mécanismes apparemment différents sont des instances de l'objet central ? » — donne une douzaine de réponses positives vérifiables (tableau du §1.2), ce qui est exceptionnel pour une spécification de langage. Le choix CBPV est *fondationnel* et non commode, et il est correctement argumenté (triangle de Pédrot–Tabareau, effets comme capacités, faible élimination). Le prix d'expressivité est nommé, chiffré et assumé, avec des protocoles de mesure écrits à défaut d'être conduits. Deux réserves : la strate « obligation » est sous-développée (les raffinement s sont déchargés par un solveur dont le fragment décidable 𝒯₀ n'est pas délimité, §6.1 p. 193) ; et l'architecture *décrite* (concurrente, distribuée, à arènes) est plus large que l'architecture *construite* (séquentielle, graduée, à effets) — c'est R-01/RT-3.

**Cohérence — faible, et c'est le défaut dominant.**
Non pas par absence d'analyse — le document s'auto-critique mieux que je ne le ferais sur certains points (RMQ 24-25 sur les trois préservations, RMQ 27 sur la disjonction des contextes, RMQ 29 sur l'atomicité locale contre la localité, RMQ 30 sur les deux clauses du Th. 26, §E.5.6 sur les quatre incertitudes) — mais par **défaut de propagation**. Les corrections sont écrites là où elles sont découvertes, et les énoncés antérieurs ne sont pas mis à jour. Résultat : sept mentions du Th. 27 avec trois statuts incompatibles, deux définitions de ℛ, deux définitions des fragments, deux sens d'« élaboration », deux objets sous « gestionnaire », une règle (10) non corrigée après la découverte de sa faille, une table (8) contredisant l'équation (2), une phase (0) invoquée dix fois et absente du pipeline, un graphe (de câblage) jamais défini mais hypo thèse de deux théorèmes, et quatre comptes des travaux ouverts. La norme que le document s'impose (« aucune affirmation sans porteur ») est violée en au moins six endroits identifiables, toujours par excès de confiance dans une correction locale. **C'est réparable, et presque entièrement par des moyens typographiques** (RT-1, RT-5).

**Solidité des preuves — très inégale, avec un noyau réel.**
Sur 51 énoncés : 18 sont démontrés ou démontrables sans réserve (Th. 5, 8, 11, 12, 13, 15, 37, 38, 39, 40 pour n fini, 41, 42, 43, 44, 46, 48, 49, 50) ; 12 le sont sous hypothèses nommées et raisonnables ; 9 sont des résultats de littérature correctement ré-énoncés avec leur portée (Th. 6, 13, 15, 37, 40) ; 11 sont des propriétés d'implémentation ou d'environnement habillées en théorèmes (Th. 16, 18, 20, 25, 26-2, 33, 35) ; 6 sont des définitions ou stipulations (Th. 31, 34) ; 5 sont des conjectures que le document reconnaît comme telles (Th. 7, 10, 17, 27, 36). Une loi fondamentale est fausse telle qu'énoncée (Th. 1 en ω) avec contre-exemple en deux lignes. Deux preuves sont circulaires ou pétitionnaires (Th. 7, second temps du Th. 40). Une preuve invoque une hypothèse que le document réfute deux fois (Th. 35, inférence principale). Deux énoncés quantifient sur des objets non définis (`Sens` au Th. 31, le graphe de câblage au Th. 17, `niv(calcul)` dans cinq preuves). En revanche, les preuves qui sont conduites le sont proprement : le lemme de substitution à trois niveaux, le Th. 38, le Th. 39, le Th. 40 (n fini), le Th. 46 et le Th. 49 sont d'un niveau correct, et les esquisses de Th. 43 et 47 identifient exactement les cas qui portent. **Le problème n'est pas la qualité des preuves, c'est qu'elles ne sont pas séparées des autres natures d'énoncés.**

**Factorisation — très bonne, avec trois aspirateurs non écrits et deux fusions à refuser.**
Le document pratique la factorisation comme une discipline explicite (« Cette économie n'est pas cosmétique », « Ce dispositif porte à lui seul ce que le langage obtenait par trois », « il n'y avait pas deux questions, il y en avait une, posée deux fois ») et il a le bon critère de légitimité (§9 de ma grille : expliquer plusieurs constructions, réduire la duplication, permettre une preuve commune, ne pas masquer une différence réelle) — il l'énonce lui-même pour la clôture. Il sait aussi *refuser* une fusion (π†/π_ℓ, Th. 19/36/43) et dire pourquoi. Trois aspirateurs restent à écrire (§4.2), dont un (la projection par niveau) absorberait quatre dispositifs. Une fusion a été faite à tort : celle des deux tailles sous une seule sorte (R-03), et elle est la conséquence directe du succès du Th. 5 — c'est le cas le plus intéressant de cette revue, parce qu'il montre le risque propre de la factorisation : **unifier le schéma peut conduire à unifier l'objet alors que l'objet doit rester double.**

**Mécanisabilité — actuellement faible, avec un chemin clair.**
Contre : une grammaire et un jeu de règles qui ne se croisent pas (six règles concluent des types non engendrés ; huit constructeurs de session sans règle ; deux règles de formation de contexte annoncées et absentes ; une production vide `S ::= S` ; trois comptes de règles différents) ; un symbole normatif absent du document lui-même (R-31) ; un symbole `ℬ` non défini dans une grammaire normative ; des identifiants de travail non résolus (T-06, T-42, T-43, T-44, G.1, G.3) ; une arithmétique de ℕ∞ dont quatre égalités de base (0·ω, ω·0, ω+ω, ω·ω) ne sont jamais écrites alors que trois théorèmes en dépendent ; une opération `⊖` définie deux fois différemment ; un environnement épistémique unique. Pour : le choix CBPV à élimination faible (pas de coercitions, unicité du typage conservée — §1.4 p. 32) ; les sommes et conjonctions indexées, motivées explicitement par le coût de preuve (« l'ajout de quelques règles de réduction pour les sommes disjointes a doublé la preuve de correction, le seul lemme de confluence recevant treize cas de plus ») ; ℳ avec formes normales et appartenance décidable ; le refus du semi-anneau tropical au motif d'axiomatisation infinie ; la restriction 𝒯₀ ⊆ 𝒯_K7PL ; le choix d'un seul objet sémantique (la relation ⟶) plutôt qu'une machine à environnements, argumenté correctement (« le lemme de substitution est déjà démontré […] le coût que la machine à environnements permettrait d'éviter est donc un coût déjà payé ») ; et l'identification honnête des deux hypothèses de module à porter en assistant (totalité de ⟦operation⟧, conformité de l'abaissement de l'arène). **Le document est à environ dix pages d'être mécanisable sur son noyau séquentiel**, à condition d'accepter que ce noyau soit séquentiel.

## 5.3 Le plus petit système conceptuel dans lequel toutes les bonnes idées du document restent vraies

C'est la question que je me suis posée en priorité, et la réponse est courte :

> **Un λ-calcul CBPV, dont les types sont des conteneurs indexés, muni d'une comonade graduée sur un grade `ℛ = (module 𝕌 × 𝔅) × (ordre 𝕄 × ℒ)`, d'une monade graduée indexée sur une quantale d'effets `ℰ = ℰ₀ × ℕ∞^ℒ`, d'un indice de niveau courant ℓ sur les dérivations, de deux sortes de tailles (inductive ℕ∞∖{ω}, coinductive ℕ∞ avec ∞+1=∞), et d'une relation de raffinement dont le foncteur d'effacement est une traduction vers un π-calcul réflexif local à sortes.**
>
> **Les trois couches sont trois préimages de projections sur ℛ et ℰ. Les quatre garanties (terminaison, productivité, non-interférence, divulgation délimitée) sont trois schémas de métathéorie (transport-échelle, projection par niveau, ré-invocation bornée) instanciés. Tout le reste — acteurs, canaux, arènes, capacités, jonctions, macros, glyphes, CRDT, supervision — est abaissement, et relève d'exigences de représentation indexées par un profil Π.**

Ce système est **plus petit** que celui du document (il supprime : la quatrième strate d'obligations comme composante — elle est dans les fibres ; le graphe de câblage comme objet primitif — il est dans la traduction ; la phase 0 comme phase séparée — elle est dans l'élaboration ; les deux sens d'« élaboration » ; les trois comptes de règles), et il **augmente la rigueur** (il donne un objet à chacune des cinq fonctions invoquées sans définition : `niv(calcul)`, `𝒢_pile`, `𝒢_budget`, le graphe de câblage, `Sens`). Toutes les bonnes idées du document y restent vraies, y compris les trois plus originales : le budget comme potentiel, π† contre π_ℓ, l'échange porté par le mode et non par le grade.

Ce qu'il faut abandonner pour y parvenir, et il faut le dire clairement parce que c'est le seul coût réel : **la revendication que la couche 2 est, dans le langage source, un calcul de processus concurrent.** Elle est vraie dans la cible, elle est plausible dans l'abaissement, elle n'est pas établie dans le noyau — et le document a déjà écrit, au §E.6, la phrase qui constate le problème sans le résoudre : « Le métalangage du chapitre 4, qui est la cible de la traduction, est formellement présenté — grammaire, motifs, coupure — quand K7PL, qui en est la source, ne l'est pas. Cette asymétrie est le vrai retard de ce document. »

---

*Fin de la revue. Les identifiants R-01 à R-31, N-01 à N-12 et RT-1 à RT-5 sont stables et citables dans une réponse.*
