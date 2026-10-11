<!--
SPDX-FileCopyrightText: 2026 K7PL contributors
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit typé C-01/C-02 — grades, index d'exponentielle et modes

**Statut :** audit documentaire non normatif ; C reste ouvert.  
**Révision auditée de `main` :** `232eb9afca0fdd7d87d2250eceaeeb8a381b271c` (11 octobre 2026).  
**Frontière :** C-01 et C-02 seulement. Cet audit décrit les sources avant la décision d'autrice consignée ci-dessous ; il n'est pas une preuve formelle. Les sources Verso/Spec décrivent les objets, propositions et esquisses ; leur compilation n'en fait pas des déclarations de théorèmes Lean.

**Mise à jour postérieure à l'audit :** le 11 octobre 2026, l'autrice a retenu comme interfaces de référence les signatures de π_U, Bang_𝒢 et Scale_Usage. Leur normalisation dans les sources et les preuves restent à réaliser. Voir [la note de ratification C-01](L1-C01-INTERFACE-RATIFICATION-2026-10-11.md).

## 1. Sources exactes et portée de la preuve

| Source | Révision du fichier (blob) | Passage pertinent | Ce que la source fournit |
|---|---|---|---|
| [C2 — ComonadeExponentielleEtFragments.lean](../../spec/Spec/C2/ComonadeExponentielleEtFragments.lean) | `819385958b3b2fbdada7418d7e7a1f340ff59baf` | définition de `𝓡`, interface exponentielle, `π_U`, `Bang_𝒢`, `Scale_Usage`, coût budgétaire | le texte source marque les signatures comme candidates et énonce des lois sans les mécaniser ; décision humaine postérieure référencée ci-dessus |
| [C3 — LeSystemeGradue.lean](../../spec/Spec/C3/LeSystemeGradue.lean) | `b579261957ce5a2967f736203682ca5c61482eaf` | intervalles `U_m`, triplets `M_m`, `thm:morphismes_modes` | instances candidates et preuve-esquisse sous contrat à expliciter |
| [C3 — GrammaireDesTypes.lean](../../spec/Spec/C3/GrammaireDesTypes.lean) | `3df5f24c41375de24d4254516be2863c437b9d6a` | grade complet et effet temporel indexé par niveau | composantes de l'annotation et structure temporelle |
| [C3 — ReglesDeTypage.lean](../../spec/Spec/C3/ReglesDeTypage.lean) | `11abe4803e93a13a2d24c847dad323337094502f` | produit mixte du sous-typage, `SubBox`, `φ_n`, substitution | direction de `≼`, opérations dans les règles et obligations |

Le dossier [L1-STAGE-C-EVIDENCE-DOSSIER-2026-10-11.md](L1-STAGE-C-EVIDENCE-DOSSIER-2026-10-11.md) et l'audit C8 B10 sont des registres de raisonnement ; ils ne remplacent ni les clauses source ni une preuve formelle. Aucun objet Lean correspondant aux signatures et lois ci-dessous n'a été identifié dans `src/` lors de cette revue.

## 2. Tableau d'interfaces typées — C-01

Notations : `𝒞` est la catégorie dont `End(𝒞)` désigne les endofoncteurs ; `𝔈` est l'algèbre/quantale d'effets ; `Ctx` est le domaine des contextes gradués ; `K := (ℕ∞ × ℕ∞)^ℒ` est la famille temporelle par niveau. Les deux derniers supports doivent être pris avec les conditions exactes de compatibilité indiquées dans le tableau, pas comme des types Lean déjà déclarés.

| Objet | Signature source ou reconstruction minimale | Sens, ordre, conditions et état épistémique |
|---|---|---|
| `𝓡` | `(ℚ≥0 ∪ {ω}, +, ×, 0, 1, ≤)` | Support/semi-anneau ordonné des usages. Les conventions source incluent `0·ω = ω·0 = 0`, `ω+ω=ω` et `ω·ω=ω`. Les lois du semi-anneau sont annoncées, mais leur instance K7PL n'est pas mécanisée par cette écriture. |
| `𝒢` | `𝓡 × 𝕄 × ℒ × 𝔅`, `𝔅 = ℕ∞` | Porteur du grade complet `r=⟨u,m,ℓ,β⟩`. Le produit de porteurs **ne définit pas**, à lui seul, une multiplication ou un semi-anneau sur `𝒢`. |
| `𝕄` | coordonnée `m∈𝕄`, avec comparaison écrite `m ≽ m′` | Marque de monotonie. Le support canonique et ses opérations/composition ne sont pas complètement spécifiés. Le « minimum » qui apparaît dans la table des candidats n'est pas encore une structure globale ratifiée. |
| `ℒ` | coordonnée de niveau `ℓ∈ℒ` ; `κ : ℒ → ℕ∞×ℕ∞` | Niveaux de confidentialité et indexation du coût temporel. La source utilise `ℓ≤ℓ′` et `⊔` dans les cas de branchement, mais la structure exacte requise (ordre/treillis, niveaux admissibles, contraintes) doit être canoniquement définie pour chaque loi invoquée. |
| `𝔅` | `ℕ∞` | Budget `β`, ordonné par `≤`. La consommation utilise la soustraction tronquée `⊖`, opération distincte de `+` et `×` du semi-anneau d'usage. |
| `π_U` | interface de référence ratifiée : `π_U : 𝒢 → 𝓡`, `π_U(⟨u,m,ℓ,β⟩)=u` | Projection de la seule coordonnée d'usage. C2 conserve encore la mention source « candidate » ; sa normalisation est à réaliser. La compatibilité générale reste à démontrer. |
| `Bang_𝒢` | interface de référence ratifiée : `Bang_𝒢 : 𝒢 × Obj(𝒞) → Obj(𝒞)`, `Bang_𝒢(r,A) := !_{π_U(r)}A` | Factorise l'indice de l'exponentielle par `π_U`. La catégorie et l'index effectif `I=𝓡` sont les hypothèses de la construction. C2 est à harmoniser ; ce raccourci ne prouve pas que les conversions du grade complet sont correctes. |
| Exponentielle indexée | `! : I → End(𝒞)` ; `0_I∈I`; `+_I, ·_I : I×I→I` | Interface abstraite de la comonade graduée. C2 exige aussi `w_A : !_{0_I}A → A`, `c_{i,j,A} : !_{i+_I j}A → !_i A ⊗ !_j A`, et `coerce_{i,j,A}: !_i A → !_j A` seulement pour les couples d'indices admissibles. Ne pas confondre `·_I`, action de contexte et multiplication sur `𝒢`. |
| `Scale_Usage` | interface de référence ratifiée : `Scale_Usage : 𝓡 × 𝒢 → 𝒢`; `Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩` | Action sur la seule composante usage. Pour les règles, extension liaison-par-liaison à `Ctx`; définie uniquement lorsque le contexte et son agrégation sont bien formés. Le budget n'est pas mis à l'échelle. C2 est à harmoniser ; les lois restent à prouver. |
| `φ_n` | `n∈ℕ∞`; `φ_n : 𝔈 → 𝔈` | Transformateur d'effets pour une multiplicité d'exécution effective `n`, distinct du scalaire d'usage `a∈𝓡`. La source donne `φ_n(⟨ε₀,k⟩)=⟨ε₀^n,n·k⟩`, avec `k` lu point-par-point sur les paires travail/profondeur indexées par `ℒ`. `φ_1=id`, `φ_n∘φ_m=φ_{nm}`, `φ_0` envoie sur l'unité ; ces lois dépendent de la signature exacte de `𝔈` et de sa puissance/supremum au cas infini. Ne pas définir `φ_a` pour un usage rationnel par analogie. |
| `W` | `W : K → ℕ∞`, `W(κ)=sup_{F⊆ℒ, F fini} Σ_{ℓ∈F} w_ℓ` | Agrège le travail comme supremum des sommes finies. La formule est la définition textuelle ; les conventions du supremum et les propriétés de composition restent à vérifier sur le `K` canonique. |
| `D` | `D : K → ℕ∞`, `D(κ)=sup_{ℓ∈ℒ} s_ℓ` | Agrège la profondeur par supremum ponctuel. Domaine et existence du supremum doivent être spécifiés (en particulier la convention si `ℒ` est vide, si ce cas est admis). |
| `Cost_Budget` | interface de référence ratifiée : `Cost_Budget : K → 𝔅`, `Cost_Budget(κ)=max(W(κ),D(κ))` | Décision d’autrice D3 (11 octobre 2026) : fonction totale sous les hypothèses et conventions explicites qui rendent `W`, `D` et `max` bien définis. Conformément à D4, `sup ∅=0` dans `ℕ∞` lorsque `ℒ=∅`. Cela ne prouve pas les propriétés de composition ou de sûreté budgétaire. Voir [la note de ratification D3](L1-D3-COST-BUDGET-RATIFICATION-2026-10-11.md). |
| `Adm` | prédicat attendu `Adm : 𝔅 × K → Prop`; formule de référence `β=ω ∨ Cost_Budget(κ)≤β` | Admissibilité d'un effet au budget donné ; dépend de la résolution de la signature de coût. La formule seule ne précise pas toutes les conditions de définissabilité. |
| `Consume` | source : `Consume(β,κ):=β⊖Cost_Budget(κ)`; interface attendue `𝔅 × K ⇀ 𝔅` | Consommation de budget à la traversée d'un effet, partielle hors domaine admissible selon les registres. Ce n'est ni une mesure exacte du coût ni l'action `Scale_Usage`. |
| `ψ` | interface minimale attendue `ψ : Ctx × 𝔈 ⇀ Ctx` | Transporte l'effet au contexte : conserve usage, monotonie et niveau et met à jour le budget par le coût temporel. Le domaine exact doit imposer la compatibilité de liaisons pour l'addition des contextes et le test admissible requis. Ne pas la présenter comme totale sans preuve de domaine. |
| `Δ₁ ⊠_ε Δ₂` | définition de règle `Δ₁ + ψ(Δ₂,ε)` | N'est défini que si `ψ` est défini et si les contextes ont les mêmes liaisons/types requises par l'addition. Il s'agit d'une opération de contexte indexée par effet, pas d'une addition universellement totale. |
| `coerce, w, c` | `coerce_{i,j,A}:!_iA→!_jA` (couples admissibles) ; `w_A:!_0A→A`; `c_{i,j,A}:!_{i+j}A→!_iA⊗!_jA` | Interfaces textuelles minimales. Les propriétés d'identité, composition, naturalité et compatibilité avec les opérations de l'exponentielle restent à prouver pour la réalisation K7PL. Les coercions d'usage suivent `u≥u′`, mais le contrat complet des indices admissibles doit être explicite. |

### Lois démontrables sur papier, sous hypothèses explicites

1. **Projection monotone dans la direction de sous-typage demandée.** La règle source donne `r≼r′ ⇒ u≥u′` pour les quadruplets bien formés ; la définition de référence de `π_U` (encore étiquetée candidate dans le texte source C2) donne `π_U(r)=u` et `π_U(r′)=u′`. Donc `π_U(r)≥π_U(r′)`. Cela est une conséquence immédiate des définitions textuelles. Hypothèses : même décomposition de `𝒢` et définition de `≼` exactement comme écrite. Ce n'est pas un théorème Lean, ni une preuve de fonctorialité de `coerce`.
2. **Identité de `Scale_Usage`.** Sous la formule retenue pour `Scale_Usage` et l’hypothèse `1·u=u`, chaque coordonnée reste identique ; donc `Scale_Usage(1,r)=r`, et liaison par liaison `Scale_Usage(1,Δ)=Δ`.
3. **Composition de `Scale_Usage`.** Sous associativité de `·` dans `𝓡`, la coordonnée usage de `Scale_Usage(a,Scale_Usage(b,r))` est `a·(b·u)=(a·b)·u`; les trois autres restent inchangées. La loi suit pour un grade, puis point-par-point pour un contexte admissible.
4. **Additivité de `Scale_Usage`.** Sous distributivité de `·` sur `+` dans `𝓡` et lorsque `Δ₁+Δ₂` est défini (mêmes liaisons/types), la coordonnée usage donne `a·(u₁+u₂)=a·u₁+a·u₂` et les autres coordonnées restent non-scalées. Aucun résultat n'en découle pour les contextes incompatibles.
5. **Monotonie de l'action.** Si `r≼r′`, alors `u≥u′`. Pour `a∈𝓡`, si la multiplication de `𝓡` est monotone en son second argument, `a·u≥a·u′` ; les trois autres coordonnées étant inchangées, `Scale_Usage(a,r)≼Scale_Usage(a,r′)`. Conditions : ordre mixte de la source, porteur et multiplication d'usage retenus et opération partout définie.

Ces résultats sont des déductions conditionnelles à partir des formules affichées ; aucune preuve Lean spécifique à ces objets n'a été trouvée dans la bibliothèque `src/`. Ils ne prouvent ni les lois générales requises ni la compatibilité des conversions.

## 3. Relations à ne pas confondre — C-02

| Relation/objet | Portée et direction source | Ce qu'elle ne prouve pas |
|---|---|---|
| Intervalles syntaxiques `U_m` | `U_Lin=[1..1]`, `U_Aff=[0..1]`, `U_Rel=[1..ω]`, `U_Unr=[0..ω]`; inclusions `U_Lin⊆U_Aff⊆U_Unr` et `U_Lin⊆U_Rel⊆U_Unr`; Aff/Rel incomparables | Ni sous-typage de types ni morphisme de modes, ni fermeture algébrique |
| Sous-typage de grades `≼` | `r≼r′ ⇔ u≥u′ ∧ m≽m′ ∧ ℓ≤ℓ′ ∧ β≤β′` | Ce n'est ni l'inclusion des intervalles ni l'ordre de précision `⊑` |
| Précision des usages/modes `⊑` | L'ordre de précision est présenté comme `Unr ⊑ Aff ⊑ Lin` (dans son domaine modal/fibre) | Ne permet pas d'inverser les directions des composantes du sous-typage mixte |
| Morphisme de modes | Sous le contrat appliqué par la preuve-esquisse : morphisme de l'algèbre de grades/ordre, `f(Cont(source))⊆Cont(cible)`, et préservation de l'affaiblissement (`Weak(source)⇒Weak(cible)`) | Le contrat exact et sa direction ne sont pas explicitement isolés dans le manuscrit ; les flèches abstraites ne prouvent pas la réalisation par le jugement K7PL |

**Signatures des relations : domaines connus et domaines conditionnels.**

- **Inclusion d'intervalles :** `\u2286 : \u2118(𝓡) × \u2118(𝓡) → Prop` (inclusion de sous-ensembles, ordre par inclusion). Elle compare les domaines syntaxiques `U_m ⊆ 𝓡`, pas des modes en tant qu'algèbres.
- **Sous-typage des grades :** `≼ : 𝒢 × 𝒢 → Prop`. Son ordre est le produit mixte défini dans la source : `u ≥ u′`, `m ≽ m′`, `ℓ ≤ ℓ′`, `β ≤ β′`. La projection sur la première conjonction suffit à établir la direction `π_U(r) ≥ π_U(r′)`.
- **Précision `⊑` :** la source de raffinement la place sur les objets d'une même fibre de l'interprétation `⟦-⟧ : 𝒟 → 𝒯`. Pour un type cible `S`, on peut noter conditionnellement `𝒟_S := {T ∈ Obj(𝒟) | ⟦T⟧=S}` et `⊑_S : 𝒟_S × 𝒟_S → Prop` comme l'ordre de cette fibre si le foncteur préservant le typage est établi. La chaîne modale `Unr ⊑ Aff ⊑ Lin` est présentée comme restriction sur la dimension d'usage. La signature globale de `⊑` et sa monotonicité sur tous les morphismes restent conditionnelles à `thm:traduction_metalangage` ; on ne lui attribue pas sans preuve le domaine `𝒢 × 𝒢`.
- **Morphisme de modes :** entre deux modes `M_s=(R_s,Cont(s),Weak(s))` et `M_t=(R_t,Cont(t),Weak(t))`, la fonction porteuse candidate a la forme `f : R_s → R_t`. Elle doit conserver les opérations/ordre exigés par l'algèbre de grades, vérifier `f(Cont(s)) ⊆ Cont(t)`, et préserver l'affaiblissement selon le sens donné par le contrat retenu. Le manuscrit utilise l'identité de `𝓡` pour les quatre flèches, mais la déclaration formelle complète de ce prédicat de morphisme reste manquante.

Ces signatures signalent aussi précisément ce qui reste ouvert : l'inclusion ensembliste est totale sur les parties, le sous-typage possède son domaine explicite, mais l'ordre de précision dépend d'une fibre/foncteur et le morphisme de modes dépend d'un contrat encore à fixer. Aucune des quatre relations n'est substituable aux autres.

### Candidats structurels et vérification conditionnelle

C3 propose, sur le porteur commun `𝓡` :

| Mode candidat | Algèbre porteuse | Grades contractables `Cont` | Affaiblissement `Weak` |
|---|---|---|---|
| `M_Lin` | `𝓡` | `{0}` | `false` |
| `M_Aff` | `𝓡` | `{0}` | `true` |
| `M_Rel` | `𝓡` | `𝓡` | `false` |
| `M_Unr` | `𝓡` | `𝓡` | `true` |

Si (et seulement si) `Cont` est bien un idéal de l'algèbre respective, le morphisme utilise l'inclusion `f(Cont(source))⊆Cont(cible)` dans cette direction, et `Weak(source)⇒Weak(cible)`, alors les identités sur `𝓡` satisfont le contrat affiché pour les quatre flèches :

- `M_Lin→M_Aff` : `{0}⊆{0}`, et `false⇒true`.
- `M_Lin→M_Rel` : `{0}⊆𝓡`, et `false⇒false`.
- `M_Aff→M_Unr` : `{0}⊆𝓡`, et `true⇒true`.
- `M_Rel→M_Unr` : `𝓡⊆𝓡`, et `false⇒true`.

Les non-flèches ont des témoins explicites :

- `M_Aff→M_Rel` échoue sur `Weak` : la source autorise l'affaiblissement (`true`), la cible non (`false`), donc l'implication de préservation échoue.
- `M_Rel→M_Aff` échoue sur `Cont` : prendre le grade `1∈𝓡=Cont(M_Rel)`. Son image par l'identité vaut `1`, qui n'appartient pas à `Cont(M_Aff)={0}`.

Cela valide la cohérence interne de la **preuve-esquisse sous contrat** pour les triplets indiqués, pas la propriété « théorème de modes de K7PL ». La source déclare `thm:morphismes_modes` comme `state := "under-review"`, `evidence := "proofsketch"`; le statut doit rester tel quel jusqu'à preuve/ratification appropriée. La référence à la littérature ne détermine pas à elle seule le contrat exact adopté par K7PL.

### Contre-exemples : un intervalle n'est pas une algèbre de grades

L'algèbre `𝓡` a un zéro additif `0` et les opérations héritées `+`, `×`. Avec ces opérations :

- `U_Lin={1}` n'inclut pas le zéro additif ; de plus `1+1=2∉U_Lin`.
- `U_Aff=[0,1]` n'est pas fermé sous l'addition : `1,1∈U_Aff` mais `1+1=2∉U_Aff`.
- `U_Rel=[1,ω]` ne contient pas `0`, donc ne possède pas le neutre additif hérité de `𝓡`.
- `U_Unr=[0,ω]=𝓡` est le seul des quatre à porter directement toutes les opérations héritées de `𝓡`.

Par conséquent, les inclusions d'intervalles sont exactes en tant que faits ensemblistes, mais ne démontrent aucun morphisme d'algèbres ou de modes. Construire une algèbre différente sur un intervalle exigerait de définir les opérations et prouver leurs lois ; cela ne figure pas parmi les engagements actuels.

## 4. Signatures manquantes et obligations restantes

1. **Porteurs `𝕄` et `ℒ` :** définition canonique, valeurs, relations complètes et opérations (y compris les lois de combinaison et le rôle exact de `⊔`).
2. **Contrat de morphisme de modes :** définition formelle explicite, direction de l'inclusion de `Cont`, sens de préservation de `Weak`, définition exacte d'un idéal dans le cadre choisi, et validation que les permissions effectivement utilisées par les règles K7PL suivent de ces triplets.
3. **`π_U` / `Bang_𝒢` :** interfaces de référence ratifiées par l'autrice ; harmoniser leurs déclarations de source, puis démontrer que les conversions de grade complet induisent les morphismes de l'exponentielle indexée, identité/composition/naturalité et compatibilité avec `w`/`c`.
4. **`Scale_Usage` :** interface de référence ratifiée ; normaliser sa déclaration et prouver les lois pour les contextes typés, en intégrant les cas de contextes incompatibles, `SubBox`, substitutions et conversions.
5. **Budget/coût :** `Cost_Budget:K→𝔅` est ratifiée comme totale sous hypothèses et conventions explicites ; formaliser `W`, `D` avec `sup ∅=0` dans `ℕ∞`, `max`, `Adm`, `Consume` et le domaine de `ψ`. `Consume` est retenue comme partielle, définie seulement lorsque `Adm(β,κ)` est satisfaite ; formaliser son domaine et le résidu budgétaire `⊖`, puis formaliser le domaine de `ψ` indépendamment de `Consume`, puis préciser quelles règles de traversée exigent en plus une consommation définie et comment le coût annoncé est relié à celle-ci.
6. **`φ_n` :** donner une définition de domaine/codomaine concordante avec les effets temporels actuels point-par-point par niveau ; montrer les lois utilisées par les règles pour tout domaine autorisé, en particulier si `n=ω` est conservé.
7. **Formalisation :** apporter des déclarations Lean qui modélisent explicitement ces interfaces et des théorèmes correspondants si la formalisation est retenue comme preuve. Le rendu/compilation Verso n'est pas cette preuve.
8. **Relations :** maintenir séparés `⊆`, `≼`, `⊑` et les morphismes de modes dans les règles, les tables et tout futur test structurel.

## 5. Décision d'autrice et décisions restant ouvertes

**D1 — Interfaces de grade et exponentielle : DÉCIDÉ.** Le 11 octobre 2026, l'autrice a retenu les signatures de `π_U`, `Bang_𝒢` et `Scale_Usage` comme interfaces de référence. Il ne reste pas à choisir entre les deux options de statut. L'action Scale_Usage porte seulement sur la composante d'usage et ne transforme pas le budget.

La source C2 porte encore textuellement l'étiquette « candidate » : cette divergence est un travail de normalisation documentaire/normative à réaliser dans un changement distinct. Les lois algébriques, conversions, naturalité, compatibilité avec les règles et substitution restent des obligations de preuve ; aucune preuve Lean n'est revendiquée. Le détail de la décision est consigné dans la [note de ratification C-01](L1-C01-INTERFACE-RATIFICATION-2026-10-11.md).

**D2 — Périmètre des modes : DÉCIDÉ ; preuves ouvertes.** Par décision d'autrice du 11 octobre 2026, le périmètre de référence courant retient `M_Lin` pour la couche 1, `M_Aff` pour la couche 2 et `M_Unr` pour la couche 3. `M_Rel` n'est pas activé dans les règles actuelles ; ses opportunités sont décrites dans [L1-REL-MODE-OPPORTUNITIES-2026-10-11.md](L1-REL-MODE-OPPORTUNITIES-2026-10-11.md). Cette décision ne prouve ni l'idéalité requise ni le contrat des morphismes : définir précisément la préservation de l'algèbre/ordre, `Cont(source)→Cont(cible)` et `Weak(source)⇒Weak(cible)`, puis établir la correspondance avec les permissions des règles K7PL.

**D3 — Totalité de `Cost_Budget` : DÉCIDÉ.** `Cost_Budget : K → 𝔅` est retenue comme totale sous les hypothèses et conventions explicites qui rendent `W`, `D` et `max` bien définis. Voir la note D3 et la décision D-17. Cette décision ne prouve pas les agrégats ni leurs propriétés.

## 6. Résultat pour le registre C

- **C-01 : PARTIEL, porte ouverte.** Les signatures de référence principales sont retenues par décision d'autrice. Leur normalisation entre le registre et C2, les domaines de plusieurs opérations, les porteurs `𝕄`/`ℒ`, les conversions de l'exponentielle, la formalisation de `sup ∅=0` et les preuves des lois restent ouvertes.
- **C-02 : PARTIEL, porte ouverte.** La direction `r≼r′ ⇒ π_U(r)≥π_U(r′)` est démontrable directement sur papier à partir des clauses source ; les intervalles n'impliquent pas des morphismes ; les flèches candidat sont validées conditionnellement à un contrat de mode encore à expliciter. La correspondance avec le jugement K7PL et la preuve machine demeurent ouvertes.
- **D5 — Principe d’admissibilité : DÉCIDÉ, formule exacte ouverte.** L’autrice retient le principe selon lequel un budget est admissible lorsqu’il couvre le coût annoncé. La formule candidate `Adm(β,κ) ↔ β=ω ∨ Cost_Budget(κ)≤β` n’est pas ratifiée telle quelle ; restent à normaliser le domaine et l’ordre de `𝔅`, le rôle de `ω` et l’éventuelle redondance du premier disjoint. Voir la note D5. D7 retient un domaine de `ψ` indépendant de celui de `Consume` ; les conditions d’autorisation de traversée et le traitement du budget doivent être spécifiés séparément.

**D6 — Domaine de `Consume` : DÉCIDÉ, réalisation formelle ouverte.** L’autrice retient l’option A : `Consume(β,κ)` est partielle et n’est définie que si `Adm(β,κ)` est satisfaite. La valeur candidate reste `β ⊖ Cost_Budget(κ)`. Il faut normaliser le contrat exact de `⊖` et prouver les propriétés nécessaires ; cette décision n’établit aucune garantie d’exécution. Voir la note D6.

**D7 — Domaine de `ψ` : DÉCIDÉ, contrat exact ouvert.** L’autrice retient l’option B : le domaine de `ψ` est indépendant de la définissabilité de `Consume`. Les règles doivent préciser séparément les conditions autorisant la traversée et le traitement du budget ; aucune traversée autorisée ni sûreté d’exécution ne se déduit de la seule définition de `ψ`. Voir la note D7.

**Porte C globale : NON SATISFAITE.** Cette tranche ne conclut ni sur C-03–C-09 ni sur les autres décisions humaines encore requises. D–F restent bloqués par la porte scientifique C.

## 7. Méthode de vérification reproductible

À la révision source du tableau §1 :

1. contrôler dans C2 la déclaration de `𝓡`, le produit `𝒢`, les formules de référence `π_U`/`Bang_𝒢`/`Scale_Usage` et l'interface `Cost_Budget`, puis vérifier leur harmonisation source;
2. contrôler dans C3 le tableau `U_m`, les quatre `M_m` candidats et le statut `under-review/proofsketch` de `thm:morphismes_modes`;
3. contrôler dans les règles de typage la définition explicite du produit mixte `≼`, puis projeter la conjonction sur `u≥u′` ;
4. vérifier les témoins d'échec `1+1=2` pour Lin/Aff et `0∉U_Rel`, puis les deux témoins de non-flèche Aff/Rel ci-dessus ;
5. exécuter le test structurel `tests/python/test_stage_c_interface_audit.py`. Ce test vérifie la cohérence documentaire et quelques témoins arithmétiques élémentaires ; il n'établit ni les lois d'un mode, ni les règles K7PL, ni un théorème Lean.

Les SHA de fichier consignés au §1 permettent de signaler toute dérive ultérieure de source. Tout changement de ces sources doit déclencher une nouvelle revue, et non une mise à jour automatique du statut épistémique.
