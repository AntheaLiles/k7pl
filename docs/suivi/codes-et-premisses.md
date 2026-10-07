<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Codes d'erreur et prémisse manquante (`FACT-09`, `PORT-07`)

**Séance 32 (6 octobre 2026).** Appariement de chacun des **48 codes** de l'annexe A à ce qui manque pour que la dérivation
existe, tel que la fiche `FACT-09` le demandait (« rattacher chaque famille de codes à la prémisse manquante »). L'appariement est une
**lecture** : je l'ai conduit à la main sur le texte du déclencheur de chaque code (annexe A) et sur les prémisses des règles
(ch. 3). Il n'est pas écrit dans le manuscrit, qui n'est pas modifié ; il est à ratifier. `scripts/controles/indexation.py`
ne le lit pas, mais `scripts/controles/structure.py` vérifie que chaque code du catalogue figure ici (garde de complétude).

**Mécanismes** (colonne « Méc. ») : **A** absence de contraction ou d'affaiblissement (la dérivation exigerait de copier ou d'abandonner
une ressource) ; **B** indexation par la portée (une valeur sort de la région ou de la portée qui l'indexe) ; **C** imbrication à sens
unique des délimiteurs ou absence de règle (frontière de couche) ; **P** distinction de phase (un objet de compilation lu à
l'exécution) ; **E** effet : l'indice d'effet n'est pas neutre ou n'est pas couvert ; **K** couverture : une somme, un motif ou un message
n'est pas couvert ; **T** terminaison ou productivité (indice de taille) ; **S** borne ou obligation de raffinement (budget, solveur,
certificat) ; **G** graphe : acyclicité du câblage ; **H** hors du jugement : politique de compilation, métrique, protocole matériel.

| Code | Méc. | Ce qui manque (règle, théorème ou phase) |
|---|:-:|---|
| `ERR-TOP-001` | C | règle d'imbrication des délimiteurs (`tab:delimiteurs`) : le fragment `( )` ne s'imbrique pas dans `[ ]` ; vérifiée en Phase 3 |
| `ERR-TOP-002` | C | idem pour `{ }` dans `[ ]` |
| `ERR-TOP-003` | P | `thm:schema_effacement`, `thm:non_interference` : aucun chemin de production ne lit un objet de compilation (la restriction de phase ne le dérive pas) |
| `ERR-TOP-005` | C | pas de règle de tenseur synchrone en couche 2 : l'émission est asynchrone primitive (`Send`) |
| `ERR-TOP-011` | H | résolution des noms, Phase 4 : filtre topologique sans cible |
| `ERR-POL-001` | H | politique P3 : résolution statique complète des appels, Phase 3 (monomorphisation) et Phase 4 |
| `ERR-TYP-010` | H | cohérence de la résolution des instances : unicité par couple (type, trait), Phase 4 |
| `ERR-PUR-001` | E | indice d'effet `𝟏` d'un bloc `pure` ou `[ ]` : `Fo`, `Op` concluent `ε ≠ 𝟏` ; Phase 5 |
| `ERR-EFF-001` | E | couverture de l'opération par un gestionnaire (`Op`, `Sc`) ; Phase 5 |
| `ERR-LOG-001` | K | `Case` : seules les branches d'une somme, exhaustives, conditionnent ; pas de conditionnelle impérative |
| `ERR-TOP-010` | E | idem `ERR-PUR-001` pour une fonction suffixée `!` |
| `ERR-TYP-009` | E | idem `ERR-EFF-001` pour une fonction suffixée `?` |
| `ERR-TER-001` | T | `Fix` (`eq:regle-fix`) : domaine de hauteur finie (`Trellis_fin`) ; pas de règle de récursion générale ; `thm:terminaison_couche_3` |
| `ERR-IND-001` | T | `Cop` : l'appel corécursif se fait à l'indice de taille inférieur (garde) ; `thm:productivite_couche_2` |
| `ERR-IND-003` | T | idem : un filtre tacite qui peut ne jamais émettre n'a pas d'indice décroissant |
| `ERR-CMP-001` | A | `Var`, `Pair` : l'usage `1` d'une variable annotée `@linear` n'admet pas de contraction ; `thm:lemme_capacite` |
| `ERR-CMP-004` | S | budget `β ⊖ k` défini (la fonction `ψ` est partielle) : le coût de l'évaluation `comptime` dépasse le budget |
| `ERR-STK-001` | H | typage ordinaire de l'application : arité de l'argument (`App`, `Lam`) |
| `ERR-STK-003` | S | `𝒢_pile`, préimage d'une projection du grade : la hauteur de pile dépasse la taille préallouée (solveur, Phase 7) |
| `ERR-MEM-009` | A | affaiblissement d'une ressource d'usage `1` : un consommateur abandonne un `StreamContext` non épuisé |
| `ERR-MEM-004` | A | contraction d'une capacité d'écriture : un état canonique emprunté en écriture ne se copie pas ; `Slice` |
| `ERR-MEM-006` | H | modèle mémoire (§4.4) : disposition par déplacements relatifs, hors du jugement |
| `ERR-TYP-006` | A | affaiblissement d'une ressource `Lin T` ou d'un point de session avant `end` ; `Var` ne l'autorise qu'au grade nul |
| `ERR-CMP-003` | A | affaiblissement affine de la couche 2 conditionné à un destructeur constant |
| `ERR-TOP-006` | H | modèle mémoire (§4.5), `E_repro` : barrière sur une écriture inter-cœurs |
| `ERR-TOP-007` | A | `Slice`, `Cap ρ` : la région ne se réalloue pas pendant qu'une partie `ρ₁` est prêtée, `ρ = ρ₁ ⊎ ρ₂` |
| `ERR-TOP-008` | B | `Cap ρ`, `Arena` : une vue `tref` ne sort pas de la région qui l'indexe |
| `ERR-FFI-001` | A | frontière de confiance (§3.3), `thm:surete_ffi` : un `ForeignHandle` linéaire ne se copie ni ne s'abandonne |
| `ERR-TYP-008` | A | idem (code réuni à `ERR-FFI-001` dans le catalogue) |
| `ERR-TYP-007` | H | typage ordinaire des protocoles : le type de l'état courant est celui de la continuation `V ⊸ S` (`App`) |
| `ERR-TOP-009` | K | `Case` ou `Proj` du produit négatif : toutes les branches de `&{ℓ_i : S_i}` sont traitées |
| `ERR-ACT-002` | K | `Guard` : la décomposition `E = Σ P_i · E_i` ne couvre pas la combinaison reçue ; `thm:sync_motifs_jonction` |
| `ERR-ACT-003` | G | acyclicité du graphe de dépendances entre acteurs et flux ; `thm:liberte_initialisation` |
| `ERR-ARC-001` | G | acyclicité du graphe de câblage, Phase 2 ; `thm:tri_topologique`, `thm:deadlock_acyclique` |
| `ERR-ARC-002` | H | métrique de conception (centralité) : aucune règle ne la porte |
| `ERR-TYP-011` | B | `Open`, condition de bord sur le témoin : le témoin ne sort pas de la portée de l'existentiel quand son grade est effaçable |
| `ERR-TYP-012` | P | `Case` : le scrutin doit avoir un grade non nul ; aucun éliminateur ne discrimine sur un argument de la phase de compilation |
| `ERR-MAC-001` | B | `thm:hygiene` : l'AST est indexé par la portée ; une liaison capturable non déclarée (`binds`) est hors de l'index |
| `ERR-MAC-002` | H | lint de signature : `binds` sans liaison n'affirme rien, aucune règle n'y est violée |
| `ERR-SMT-001` | S | obligation de raffinement : le témoin contredit les contraintes inférées, Phase 7 |
| `ERR-SMT-002` | S | obligation de raffinement falsifiée par un test de propriétés, mode `+verify` |
| `ERR-DPL-001` | H | schéma versionné (`E_repro`) : le morphisme pur entre schémas n'est pas fourni |
| `ERR-PKG-003` | S | certificat de la preuve SMT d'un paquet (clause de certificat de la Phase 7) |
| `ERR-CMP-002` | S | types temporels `○`, `□`, `◇` de la composition : calendrier des débits non compatible |
| `ERR-TYP-005` | K | `Case` sur `Result(Float64, Singularity)` : le cas singularité n'est pas traité ; `tab:propagation-addition` |
| `ERR-SLC-001` | A | `Slice` : la partition `ρ = ρ₁ ⊎ ρ₂` demandée n'est pas une partition |
| `ERR-ROW-001` | S | solveur de rangées (Phase 7) : conflit de contraintes de rangée |
| `ERR-FLD-001` | S | idem : conflit de présence de champ |

## Ce que le tableau établit, et ce qu'il n'établit pas

Les 48 codes se répartissent ainsi, d'après le tableau : **A** 9, **B** 3, **C** 3, **P** 2, **E** 4, **K** 4, **T** 3, **S** 8, **G** 2, **H** 10.
Seuls A, B, C et P — les quatre mécanismes de non-dérivabilité que `FACT-09` nomme (absence de contraction, indexation par la portée,
imbrication des délimiteurs, principe général de distinction de phase) — se ramènent à « la prémisse manquante est celle qui empêcherait la
dérivation » : **17 codes sur 48**.

**L'objectif annoncé par la relecture F, « 18 familles → 4 diagnostics fibrés universels », n'est donc pas atteint.** Il tient pour les 17
codes de non-dérivabilité structurelle, dont le diagnostic se dit en une phrase (« ceci demanderait de copier ou d'abandonner », « ceci sort
de la portée qui l'indexe », « ceci franchit une frontière de couche », « ceci lit un objet de compilation »). Les 31 autres relèvent de
mécanismes qui ne sont pas des non-dérivabilités : couverture de sommes (4), effets (4), indices de taille (3), bornes et obligations de
solveur (8), graphe (2), et dix codes que le jugement ne porte pas (politiques, lint, modèle mémoire). Le préfixe du code ne suit pas le
mécanisme : `MEM`, `TOP`, `TYP` et `CMP` portent chacun des codes de plusieurs mécanismes. La réduction « une famille de codes, un diagnostic » est
fausse ; la réduction « un mécanisme, un message-type » est vraie pour les 17 codes de non-dérivabilité, et c'est ce que l'annexe peut
reprendre si l'auteur le décide.
