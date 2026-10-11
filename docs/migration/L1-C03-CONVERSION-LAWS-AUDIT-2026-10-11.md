<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit C-03 — conversions, comonade indexée et action d’usage

**Révision de référence :** `main` au commit `f8cc3a333016c20e117d0893de72c33f746d7810` (11 octobre 2026).
**Nature :** audit documentaire et dérivations conditionnelles sur les formules publiées.
**Verdict :** C-03 reste **OUVERT**. Aucun lemme relatif à cette interface n’a été trouvé dans `src/`; aucune sémantique candidate n’est promue et aucune modification de `spec/` ou `src/` n’est autorisée par cet audit.

## 1. Périmètre et provenance

| Source examinée sur la révision de référence | Usage dans cet audit |
|---|---|
| [C2 — interface exponentielle, lignes 337–374](../../spec/Spec/C2/ComonadeExponentielleEtFragments.lean#L337-L374), blob `819385958b3b2fbdada7418d7e7a1f340ff59baf` | Signature minimale de `!`, `w`, `c`, `coerce` ; distinction entre index et action du contexte |
| [C2 — factorisation et `Scale_Usage`, lignes 386–495](../../spec/Spec/C2/ComonadeExponentielleEtFragments.lean#L386-L495) | Formules candidates `π_U`, `Bang_𝒢`, `Scale_Usage` et lois demandées |
| [C2 — cohérence de l’action d’usage, lignes 182–208](../../spec/Spec/C2/ComonadeExponentielleEtFragments.lean#L182-L208) | Proposition `thm:coherence_usage`, statut `under-review/proofsketch` |
| [C3 — conventions de contexte, lignes 73–80](../../spec/Spec/C3/ReglesDeTypage.lean#L73-L80) | Action contextuelle employée dans les règles et condition annoncée pour l’addition |
| [C3 — ordre mixte, lignes 314–330](../../spec/Spec/C3/ReglesDeTypage.lean#L314-L330) | Direction exacte de `≼` |
| [C3 — cohérence de la subsomption, lignes 397–428](../../spec/Spec/C3/ReglesDeTypage.lean#L397-L428) | Différence entre existence de jointures et cohérence des conversions ; esquisse encore ouverte |
| [C3 — substitution, lignes 1598–1682](../../spec/Spec/C3/ReglesDeTypage.lean#L1598-L1682) | Règles appelant l’action graduée, `ψ`, `φ_n`, `Sub` et `SubBox` |
| [Séance 61 — transport des coercions](../history/2026-10-07-pr-02-61-coercion-transport-closure.md) | Provenance de `ConvCtx` et `Conv!`; **note de conception, pas source normative ni preuve** |
| [Matrice C](L1-THEORY-OBJECTS.md#c-03--coerce-w-c-conversions-et-scale_usage) et [dossier probant C](L1-STAGE-C-EVIDENCE-DOSSIER-2026-10-11.md) | Critères de clôture globaux et séparation des statuts |

Le CI de `main` a réussi sur ce SHA (run [38149623567](https://github.com/AntheaLiles/k7pl/actions/runs/38149623567)). Ce résultat valide le périmètre d’outillage déclenché sur ce commit, non les lois mathématiques ici étudiées. `src/K7pl/Semantics.lean` formalise un compteur LTS de démonstration et `src/K7pl/Arith.lean` un langage arithmétique jouet : aucun des deux ne déclare ces conversions. Le test `tests/python/test_stage_c_interface_audit.py` contrôle une cohérence documentaire structurelle ; ce n’est pas une preuve Lean de C-03.

## 2. Définitions et signatures canoniques disponibles

Les signatures ci-dessous sont les signatures **écrites dans les sources**, pas une ratification de leurs candidats.

| Objet | Signature / définition consignée | Limite de la source |
|---|---|---|
| Index de l’exponentielle | `! : I → End(𝒞)`, `0_I : I`, `+_I : I × I → I`, `·_I : I × I → I` | `I` n’est pas fixé par la seule interface. Le choix historique `I = 𝓡` est compatible avec l’exponentielle d’usage ; `I = 𝒢` demanderait une algèbre supplémentaire sur le grade complet. |
| `w` | `w_A : !_{0_I} A → A` | La source parle de counité au neutre, mais la signature ne donne qu’un morphisme d’indice zéro. Les lois exactes de compatibilité avec tous les `coerce` ne sont pas énoncées sous une forme typée complète. |
| `c` | `c_{i,j,A} : !_{i+_I j} A → !_i A ⊗ !_j A` | Le domaine de définition des indices et les diagrammes d’instanciation avec les coercions doivent être explicites. |
| `coerce` | `coerce_{i,j,A} : !_i A → !_j A`, seulement pour les couples d’indices admissibles | La source ne définit pas complètement « admissible ». L’identité, la composition, la naturalité et la compatibilité avec `w`/`c` ne découlent pas du seul nom. |
| `≼` | Pour `r = ⟨u,m,ℓ,β⟩` et `r' = ⟨u',m',ℓ',β'⟩`, `r ≼ r' ↔ u ≥ u' ∧ m ≽ m' ∧ ℓ ≤ ℓ' ∧ β ≤ β'` | C’est un produit d’ordres à directions mixtes, pas un ordre global qui autoriserait à inverser arbitrairement toutes les composantes. |
| `π_U` | Candidat `π_U : 𝒢 → 𝓡`, `π_U(⟨u,m,ℓ,β⟩) = u` | C2 le qualifie toujours de candidat d’architecture. |
| `Bang_𝒢` | Candidat `Bang_𝒢(r,A) := !_{π_U(r)} A` | C’est le pont proposé entre le grade complet de la syntaxe `!_r A` et la famille catégorique indexée par `𝓡`; le pont n’est pas ratifié. |
| `ConvCtx` | Séance 61 : `ConvCtx(r,r') : x:_r V ↦ x:_{r'} V`, si `r ≼ r'` | Cette note décrit une relabellisation du jugement. La spécification n’offre pas de déclaration autonome et canonique d’un opérateur global `ConvCtx`. |
| `Conv!` | Séance 61 : `Conv!_{r,r',A} := coerce_{π_U(r),π_U(r'),A}` | Cette signature n’est typée que si `π_U` est retenu, si `I = 𝓡`, et si la paire projetée est admissible. Elle ne prouve pas l’interprétation des types K7PL. |
| `Scale_Usage` | Candidat `Scale_Usage(a,⟨u,m,ℓ,β⟩) = ⟨a·u,m,ℓ,β⟩`, avec `a,u ∈ 𝓡` ; extension point par point aux contextes bien formés | Elle multiplie **la seule coordonnée d’usage**. Monotonie, niveau et budget sont conservés ; ce n’est ni une multiplication du grade complet ni une transformation d’effet. |

P1a (structure catégorique et axiomes de l’interface) et P1b (interprétation `⟦-⟧_𝒞` des dérivations et correction) restent distincts. Même une instanciation catégorique de P1a ne suffirait pas, à elle seule, à prouver que `SubBox` ou les conversions des jugements K7PL sont correctement interprétés au sens de P1b.

## 3. Direction de transport de l’index

**Lemme papier conditionnel — projection de la subsomption.** Sous les définitions écrites de `≼` et de la candidate `π_U` :

1. `r ≼ r'` donne directement `u ≥ u'`, par la première conjonction de la définition du produit mixte ;
2. `π_U(r)=u` et `π_U(r')=u'` ;
3. donc `π_U(r) ≥ π_U(r')`.

Cette déduction ne demande pas de structure catégorique. Elle donne la **direction requise** par le morphisme `coerce_{u,u',A} : !_u A → !_u' A`. Elle reste conditionnelle à la promotion de `π_U` et à la définition du domaine d’admissibilité de `coerce`. Elle ne prouve ni que le morphisme existe pour toute paire comparable, ni son identité, sa composition ou sa naturalité.

L’orientation inverse serait non justifiée : pour `u = ω` et `u' = 1`, la source indique `!_ω A → !_1 A`, pas `!_1 A → !_ω A`. Le sous-typage mixte impose cette orientation ; il ne fournit pas le morphisme lui-même.

## 4. Preuves par cas et obligations exactes

### 4.1. `ConvCtx` — identité et composition

Hypothèses explicites : support des variables et types fixé ; la conversion ne fait que remplacer l’annotation de grade ; aucune alpha-renommage, insertion, suppression ou transformation de type n’est incluse dans l’opérateur ; les relations de grade sont celles de C3.

- **Identité.** Pour chaque liaison `x:_r V`, `ConvCtx(r,r)` renvoie `x:_r V`. Appliqué liaison par liaison à un contexte de support fixé, le résultat est le contexte initial. La loi est définitionnelle sous cette définition de relabellisation.
- **Composition.** Pour `r ≼ s ≼ t`, une liaison `x:_r V` devient `x:_s V`, puis `x:_t V`. La composition et le transport direct rendent la même liaison `x:_t V` ; point par point, `ConvCtx(s,t) ∘ ConvCtx(r,s) = ConvCtx(r,t)`.
- **Portée.** Ce cas ferme uniquement la relabellisation du jugement sur un support fixe. Il ne prouve aucune loi de `coerce`, ne donne pas une conversion d’un type `!_r V`, et ne déduit aucune transformation d’effet.

**Statut :** preuve syntaxique sur papier, conditionnée par la lecture de séance 61. Comme cette fonction n’est pas déclarée canoniquement dans `spec/`, ce résultat ne constitue pas encore un lemme formel K7PL.

### 4.2. `coerce` — identité et composition

Les deux obligations doivent être typées pour tout objet `A` et toutes les paires indiquées admissibles :

- **Identité :** `coerce_{u,u,A} = id_{!_u A}`.
- **Composition :** pour `u ≥ v ≥ w`, `coerce_{u,w,A} = coerce_{v,w,A} ∘ coerce_{u,v,A}`.

La relation d’ordre permet d’énoncer les flèches seulement si le domaine de `coerce` admet effectivement chaque paire. Elle ne force pas des applications déjà données à satisfaire ces équations. Ni le registre C, ni la signature isolée, ni une compilation de Verso ne prouve ces égalités pour l’instance K7PL. Il faut distinguer preuve et axiome : C2 dit plus loin que K7PL adopte sans réserve l’axiomatisation graduée de la compatibilité entre le comonoïde et le couple `(ε,δ)` (lignes 551–558). Cette phrase constitue une déclaration de structure au niveau P1a, pas une preuve Lean. Elle ne spécifie cependant pas à elle seule le domaine des couples admissibles de `coerce`, ni le rattachement exact de ses lois d’identité/composition à ces axiomes, ni l’instanciation de la projection candidate du grade complet. C2 énumère d’ailleurs auparavant la compatibilité de `w`, `c` et des coercions comme obligation liée aux opérations d’indices (lignes 361–364), et C3 maintient la proposition de cohérence de la subsomption en `under-review/proofsketch`. Il y a donc au minimum un défaut de traçabilité du contrat, et une tension de statut à résoudre ; cet audit ne transforme pas une déclaration d’axiomes de modèle en preuve que toutes les conversions C3 les satisfont.

**Statut :** identité/composition sont des obligations listées par l’interface ; elles peuvent relever des axiomes du modèle catégorique adopté si le mapping est explicite. L’instance concrète `coerce`, son domaine et sa liaison au sous-typage de C3 restent à établir ou à identifier précisément comme hypothèses de P1a.

### 4.3. `coerce` — naturalité en l’objet

Pour chaque morphisme `f : A → B` de `𝒞` et chaque paire d’indices admissible `u ≥ v`, la naturalité demandée est le carré commutatif :

`!_v(f) ∘ coerce_{u,v,A} = coerce_{u,v,B} ∘ !_u(f)`.

Les équations d’identité et de composition portent sur le trajet dans **l’indice** ; cette équation porte sur le trajet dans **l’objet**. Elles sont logiquement distinctes.

**Contre-exemple à l’inférence « identité + composition ⇒ naturalité » (pas un contre-exemple à K7PL).** Prenons la petite catégorie `𝒞) ayant pour objets `A=\{*\}` et `B=\{0,1\}`, et pour flèches `id_A`, `id_B), `z:B→B` (constante `0`), `f_0:A→B` (constante `0`) et `f_1:A→B` (constante `1`). Les compositions non triviales sont `z∘z=z`, `z∘f_0=f_0) et `z∘f_1=f_0), ce qui définit une catégorie. Posons `!_2=!_1=!_0=Id_𝒞). Définissons les composants de `coerce_{2,1}` et `coerce_{1,0}` par `id_A) sur `A) et `z) sur `B), et ceux de `coerce_{2,0}` de même ; les composants des coercions d’identité sont les identités. Toutes les lois d’identité et la composition `coerce_{2,0}=coerce_{1,0}∘coerce_{2,1}` sont satisfaites composante par composante puisque `z∘z=z). Pourtant, le carré de naturalité de `coerce_{2,1}` pour `f_1) ne commute pas : le trajet gauche est `f_1∘id_A=f_1), alors que le trajet droit est `z∘f_1=f_0), et `f_0≠f_1). Cela montre, avec une catégorie explicitement fermée par composition, que les lois d’indice ne suffisent pas à établir la naturalité.

**Statut :** obligation ouverte. Il faut soit la prouver pour la réalisation concrète, soit montrer qu’elle est un axiome explicite de la structure importée et que l’instance K7PL satisfait effectivement ce contrat. Une citation catégorique externe sans mapping et hypothèses ne clôt pas l’instance.

### 4.4. Compatibilité avec `w`

La naturalité de `w` au neutre, si `w : !_{0_I} ⇒ Id` est bien l’interprétation retenue, s’écrit pour `f : A → B` :

`f ∘ w_A = w_B ∘ !_{0_I}(f)`.

C2 indique que la counité est naturelle au neutre, mais une signature isolée n’est pas un témoin de preuve de cette naturalité dans K7PL. Surtout, la compatibilité **entre les coercions et `w`** ne peut pas être déclarée complètement à partir du seul `w_A : !_{0_I}A → A` : la source n’expose pas une famille `w_{u,A}` pour tout indice permettant d’écrire une équation uniforme de transport.

La séance 61 résume aussi une relation comme `w ∘ ε = w` en la qualifiant de naturalité. Cette notation ne fournit ni signature de `ε`, ni indices source/cible des deux occurrences de `w`. Si elle vise la chaîne `u ≥ v ≥ 0`, la loi de composition correctement typée à expliciter est `coerce_{u,0,A} = coerce_{v,0,A} ∘ coerce_{u,v,A}` ; c’est la composition des coercions, et non le carré de naturalité ci-dessus. Si elle vise une autre loi, ses morphismes doivent être déclarés avant vérification.

**Statut :** interface à typer précisément ; ne pas traiter l’abréviation de séance comme une preuve ni réécrire le contrat normatif sans décision.

### 4.5. Compatibilité avec `c`

La naturalité en l’objet de la comultiplication doit, pour `f : A → B`, satisfaire :

`(!_i(f) ⊗ !_j(f)) ∘ c_{i,j,A} = c_{i,j,B} ∘ !_{i+_I j}(f)`.

La compatibilité des coercions avec la décomposition de l’indice demande, pour `i ≥ i'` et `j ≥ j'`, avec les sommes et toutes les coercions concernées admissibles :

`c_{i',j',A} ∘ coerce_{i+j,i'+j',A} = (coerce_{i,i',A} ⊗ coerce_{j,j',A}) ∘ c_{i,j,A}`.

Les deux côtés ont alors pour source `!_{i+j}A` et pour cible `!_{i'}A ⊗ !_{j'}A`. Cette égalité suppose notamment que `+_I` respecte l’ordre assez pour rendre admissible la coercion de la somme. Elle est indépendante de l’identité/composition de `coerce`. Les axiomes de coassociativité/neutralité de la structure graduée doivent, eux aussi, être reliés à la définition exacte adoptée pour l’instance.

**Statut :** obligation ouverte pour l’instanciation et le transport d’indice. L’interface C2 fournit le type de `c`, pas la preuve de ce diagramme pour les coercions K7PL.

### 4.6. `Scale_Usage` — identité, composition, addition et monotonie

Ces dérivations sont algébriques sur la **formule candidate**, sous les hypothèses indiquées ; elles ne promeuvent pas la formule au rang normatif.

- **Identité.** Si `1·u = u` dans `𝓡`, alors `Scale_Usage(1,r)=r` : la coordonnée d’usage revient à `u` et `m`, `ℓ`, `β` restent identiques.
- **Composition.** Si la multiplication de `𝓡` est associative, `a·(b·u)=(a·b)·u`; donc `Scale_Usage(a,Scale_Usage(b,r))=Scale_Usage(a·b,r)`.
- **Addition de contextes.** Si `Δ₁+Δ₂` est défini sur le même support de liaisons/types et si `a·(u₁+u₂)=a·u₁+a·u₂`, l’égalité de l’action et de l’addition se vérifie sur l’usage ; les autres composantes suivent les mêmes opérations d’agrégation sans être multipliées par `a`. Aucun énoncé n’est disponible lorsque l’addition est indéfinie.
- **Monotonie.** Si `r ≼ r'`, alors `u ≥ u'`. Par monotonie de la multiplication d’usage, `a·u ≥ a·u'` pour `a ∈ 𝓡`. Les relations sur `m`, `ℓ` et `β` sont conservées puisque ces coordonnées restent inchangées. Ainsi `Scale_Usage(a,r) ≼ Scale_Usage(a,r')`.
- **Relabellisation/action.** Liaison par liaison, les deux chemins « changer l’annotation puis multiplier son usage » et « multiplier l’usage puis changer l’annotation » donnent la même annotation finale. Cette égalité ne demande pas de multiplication de `𝒢`.

Ces cas demandent l’algèbre annoncée de `𝓡`, les porteurs/opérations de contexte réels et les domaines de formation correspondants. Aucun résultat ci-dessus n’est une preuve Lean trouvée dans `src/`.

### 4.7. Problème de signature : `0·Δ` n’est pas l’effacement complet sous la lecture `Scale_Usage`

C3 annonce que `Δ₁+Δ₂` n’est défini que pour des contextes ayant les mêmes liaisons/types et écrit cette condition sous la forme `0·Δ₁ = 0·Δ₂`, en disant que « l’annulation des grades » ne laisse que les couples variable-type ([C3, lignes 73–80](../../spec/Spec/C3/ReglesDeTypage.lean#L73-L80)). Dans le même passage, `r·Δ` est interprété, pour les règles concernées, par la candidate `Scale_Usage(π_U(r),Δ)`. Or la définition C2 multiplie **seulement l’usage** :

`Scale_Usage(0,⟨u,m,ℓ,β⟩) = ⟨0,m,ℓ,β⟩`.

**Cas témoin.** Deux liaisons de même variable et type mais dont `m`, `ℓ` ou `β` diffèrent ont toujours la même projection variable/type ; après `Scale_Usage(0,-)`, leurs trois composantes non liées à l’usage restent différentes. L’égalité `Scale_Usage(0,Δ₁)=Scale_Usage(0,Δ₂)` ne signifie donc pas, sous cette formule, seulement « même support variable/type ». L’action d’usage proposée n’est pas l’opération d’effacement complet décrite par la justification de C3.

Cette observation ne tranche pas la sémantique normative. Elle localise une incohérence à résoudre avant d’utiliser le critère dans les lemmes d’addition/substitution. Deux formes minimales possibles, **à soumettre à l’autrice et non à appliquer ici** :

1. définir la compatibilité de `Δ₁+Δ₂` directement par égalité du support variable/type, indépendamment d’une action scalaire ;
2. introduire un opérateur distinct d’extraction du support ou d’effacement complet du grade, dont le type et le contrat sont explicites, sans le confondre avec `Scale_Usage`.

Le choix modifie la définition opérationnelle des contextes. Aucune de ces options n’est retenue par cet audit.

## 5. Suivi de toutes les règles touchées

| Règle / interface | Conversion ou action invoquée | Obligation à décharger ; ce qui ne doit pas être déduit |
|---|---|---|
| `Sub` | `C <: C'` et `ε ⊑ ε'` | Le sous-typage de type et celui d’effet sont deux transports distincts. La règle ne donne pas elle-même une fonction de conversion générale pour tous les constructeurs de types ni pour les effets. |
| `SubBox` | `!_r V <: !_r' V` avec `r ≼ r'` | Prouver la direction projetée puis typer le transport par `coerce`. La candidate `Bang_𝒢` doit relier la syntaxe `!_r` à la famille `!_{π_U(r)}`. Le cas documenté garde le même `V` ; il ne prouve pas un changement arbitraire de forme du type. |
| `Box`, `App`, `Unbox`, substitution | Action de contexte `Scale_Usage(π_U(r),-)` dans l’architecture factorisée | Identité, composition, monotonie, additivité sur contextes compatibles, et compatibilité avec les conversions des sous-termes/types. Les autres coordonnées du grade ne sont pas multipliées. |
| Composition `Δ₁ ⊠_ε Δ₂ = Δ₁ + ψ(Δ₂,ε)` | `ψ` transporte l’effet et peut mettre à jour le budget ; `+` exige des contextes compatibles | Vérifier le domaine partiel de `ψ`, le support requis par `+` et les cas de compatibilité avec `Scale_Usage`. |
| `thm:coherence_usage` | `Scale_Usage(a,ψ(Δ,ε)) = ψ(Scale_Usage(a,Δ),ε)` | La vérification composante par composante est immédiate **sur le domaine commun**, si `ψ` laisse usage/monotonie/niveau inchangés et si `Scale_Usage` laisse le budget inchangé. Elle ne prouve pas que les deux côtés sont définis : le domaine de `ψ` reste à préciser. Le bloc est `under-review/proofsketch`. |
| `Sc` et répétitions effectives | `Scale_Usage(n,-)` sur le contexte et `φ_n` sur l’effet | Garder les deux actions distinctes. `n` appartient au domaine de multiplicité effective `ℕ∞` ; ne pas définir `φ_a` pour un usage rationnel par analogie. |
| `When` | Transformation de l’effet temporel, consignée comme `κω(ℓ)=⟨ω,ω⟩` | Ce n’est ni `ConvCtx` ni `Conv!`. La compatibilité avec `ψ`, `Adm` et `Consume` et la correction de ressource restent des obligations C-04/C-06 ; la simple présence de `ω` ne les prouve pas. |
| Constructeurs de types imbriquant `!` | Naturalité de `coerce` et compatibilité de conversion avec le constructeur | `coerce_{u,v,A}` ne porte que sur une famille de types à objet sous-jacent fixé `A`. Tout transport à travers d’autres constructeurs (ou un changement de `A`) nécessite les morphismes et naturalités correspondants. |

La preuve complète de substitution demeure C-06, distincte de ce sous-audit. C-03 doit toutefois établir que ses conversions sont typées et compatibles avec chaque règle qui les invoque ; elle ne peut présupposer un théorème de substitution que C-06 ne possède pas encore.

## 6. Contre-exemples et frontières établies

1. **Identité/composition sans naturalité :** le modèle `Set` de §4.3 montre que deux lois indexées ne garantissent pas le carré naturel.
2. **Sens du transport inversé :** `r ≼ r'` permet `u ≥ u'`, donc potentiellement `!_u A → !_u' A`. Aucun morphisme inverse n’est fourni par cette prémisse.
3. **Effacement du contexte :** le cas de §4.7 montre que `Scale_Usage(0,-)` conserve `m`, `ℓ` et `β`; il ne peut servir de projection vers le seul support syntaxique sans contrat supplémentaire.
4. **Usage rationnel et effet répété :** `a = 1/2` est un usage admissible dans la présentation de `𝓡`, mais ne constitue pas une multiplicité effective `n ∈ ℕ∞`. Une loi utilisant `φ_a` n’a donc pas de type dans l’interface présente.
5. **Type versus effet :** `ConvCtx` ne change ni `V` ni `ε`. `Sub` peut changer le type cible et l’effet via deux relations distinctes ; `Sc` transforme l’effet par `φ_n`, tandis que `When` modifie la composante temporelle. Les lois de conversion de contexte ne justifient pas ces transformations.

Les points 1–5 sont soit des contre-exemples à une inférence trop forte, soit des frontières de typage lisibles dans la source. Ils ne constituent pas un contre-exemple à une interprétation K7PL complète, laquelle n’est pas formellement donnée ici.

## 7. Obligations de clôture C-03

C-03 ne peut être déclaré clos avant les éléments suivants :

- [ ] Le registre canonique distingue le choix de l’exponentielle d’usage `I = 𝓡` décrit en C2 des ponts encore candidats `π_U`, `Bang_𝒢` et `Scale_Usage`. La portée normative de ces derniers doit être ratifiée ou explicitement maintenue au statut candidat ; aucune promotion ne découle des séances.
- [ ] Le domaine exact des paires admissibles de `coerce` et les lois d’identité/composition sont déclarés avec leurs prémisses ; la naturalité en `A` est prouvée ou assumée dans une structure précisément référencée et instanciée.
- [ ] La compatibilité avec `w` et `c` est donnée sous des équations aux types source/cible cohérents. L’ambiguïté de `w ∘ ε = w` est résolue sans confondre composition et naturalité.
- [ ] La différence entre syntaxe `!_r` indexée par le grade complet et famille catégorique `!_{π_U(r)}` est comblée par une définition ratifiée ou reste explicitement bloquante. Aucune preuve de P1a n’est présentée comme preuve de P1b.
- [ ] L’écart entre `0·Δ₁ = 0·Δ₂` et l’action `Scale_Usage(0,-)` est arbitré par l’autrice ; aucune correction n’est appliquée à `spec/` sans cette décision.
- [ ] Les règles `Sub`, `SubBox`, `Box`, `App`, `Unbox`, substitution, composition via `ψ`, `Sc` et `When` ont chacune une correspondance typée avec les lois requises. Les conversions génériques des autres constructeurs et la relation d’effet restent distinctes.
- [ ] Les lois formelles éventuellement produites dans Lean ciblent ces signatures mêmes, avec leurs hypothèses/domaines explicites ; les tests structurels et builds restent classés comme contrôles d’outillage.
- [ ] La revue de la porte C se fait sur un SHA contenant les preuves et les ratifications, et non à partir de ce seul document.

**État après cet audit : C-03 PARTIEL, NON CLOS.** Les lois de relabellisation pure et les égalités algébriques de `Scale_Usage` sont démontrables sur papier sous hypothèses ; l’identité/composition/naturalité de `coerce`, ses compatibilités avec `w`/`c`, la jonction de l’index complet à l’index d’usage et l’ambiguïté du test de support ne sont pas déchargées. Aucune preuve Lean nouvelle, modification normative ou ratification de l’autrice n’est revendiquée.
