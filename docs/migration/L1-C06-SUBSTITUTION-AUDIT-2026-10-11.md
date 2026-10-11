<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Audit C-06 — substitution graduée

**Révision vérifiée :** main, SHA 414ce6a1d2347de11397002980f3e0fe0b1e8205, 11 octobre 2026.  
**Source de règles :** [ReglesDeTypage.lean](https://github.com/AntheaLiles/k7pl/blob/414ce6a1d2347de11397002980f3e0fe0b1e8205/spec/Spec/C3/ReglesDeTypage.lean), blob 11abe4803e93a13a2d24c847dad323337094502f.  
**Sources transversales :** [registre L1](L1-THEORY-OBJECTS.md), [audit C-03](L1-C03-CONVERSION-LAWS-AUDIT-2026-10-11.md), [C8 batch 01](../tracking/LEAN-SEMANTIC-AUDIT-BATCH-01.md), [C8 batch 11](../tracking/LEAN-SEMANTIC-AUDIT-BATCH-11.md), [dossier d’évidence C](L1-STAGE-C-EVIDENCE-DOSSIER-2026-10-11.md).  
**Verdict : C-06 OUVERT ; porte C NON SATISFAITE.** Rapport non normatif ; aucune décision d’autrice n’est inférée.

## 1. Résultat de l’audit

Les énoncés thm:substitution et thm:substitution_simultanee restent marqués under-review/proofsketch. Aucun développement Lean du jugement C3 et de ce lemme n’a été trouvé : src/K7pl/Semantics.lean ne formalise qu’un compteur LTS jouet et src/K7pl/Arith.lean une transformation arithmétique.

La preuve esquissée annonce couvrir « trente-quatre règles ». Le source C3 courant contient **49 occurrences** de règles d’inférence. Il y a aussi une erreur locale dans le regroupement : Pair a deux prémisses et additionne les contextes ; Inj n’a qu’une prémisse et conserve son contexte. Le raisonnement annoncé r=r₁+r₂ ne peut donc pas être le cas d’Inj. Ces constats réfutent l’exhaustivité de l’esquisse, **pas le théorème mathématique dans son ensemble**. Aucun contre-exemple typé réfutant le théorème complet n’est établi dans cet audit.

## 2. Contrat visé et hypothèses

Le contrat annoncé est :

\[
\Delta,x:_{r}V_i\vdash c:C\mid\varepsilon(i)
\quad\text{et}\quad
\Delta'\vdash v:V_j
\]
\[
\Longrightarrow\quad
\Delta\boxtimes_{\mathbf 1}
\mathrm{Scale\_Usage}(\pi_U(r),\Delta')
\vdash c[v/x]:C[j/i]\mid\varepsilon(j).
\]

C’est une cible de preuve, pas un résultat acquis. Les hypothèses à rendre explicites sont :

- **H0 — jugements/contextes :** domaines et types exacts des grades, contextes, somme, jointure et composition ; support des liaisons et égalité de contextes.
- **H1 — substitution :** définition évitant la capture et égalité modulo alpha-renommage pour termes, types, indices d’effet, tailles et niveaux ; règles de substitution pour chaque constructeur.
- **H2 — formation :** formulation précise de la formation de types sous usages annulés, qui rend C[j/i] et ε(j) admissibles.
- **H3 — Scale_Usage :** si cette candidate est retenue, preuves conditionnelles d’identité, composition, action nulle, monotonie et distributivité sur chaque agrégateur réellement utilisé.
- **H4 — contextes/ψ :** signature et domaine éventuel partiel de ψ dans Δ₁⊠εΔ₂=Δ₁+ψ(Δ₂,ε), neutralités et compatibilités avec Scale_Usage.
- **H5 — conversions/exponentielle :** domaine admissible de coerce, identité, composition, naturalité et diagrammes typés avec w, c et ! ; relation normative avec ConvCtx/Conv!.
- **H6 — effets/coûts :** substitution des familles d’effets, séquencement/parallélisme et domaines de ψ, Adm, Consume, W, D et Cost_Budget.
- **H7 — répétitions :** Scale_Usage agit sur la coordonnée d’usage/contexte ; φ_n agit séparément sur l’effet pour une multiplicité effective n. **L’usage rationnel a∈R n’autorise pas φ_a.** Un cas n=ω nécessite ses propres hypothèses de complétude/supremum ; il ne découle pas du cas entier fini.
- **H8 — conditions annexes :** chaque cas doit préserver fraîcheur, relations de sous-typage, bornes de niveau, sérialisation, partition de région, motif, tailles, indices, effet et budget.

### Codes utilisés

| Code | Classe épistémique |
|---|---|
| DPSH | Démontré sur papier sous hypothèses : étape locale seulement, pas le théorème global. |
| DANS | Démontré dans Lean. **Aucun cas n’a ce statut.** |
| IFS | Indéterminé faute de signature/domaine/compatibilité précise ou démontrée. |
| RCE | Réfuté par contre-exemple au cas mathématique lui-même. Aucun cas du théorème principal n’est actuellement ainsi classé. |
| BDN | Bloqué par décision normative, car une candidate ou interprétation non ratifiée doit être choisie. |

Un succès de compilation, de rendu Verso, de test ou de CI n’est jamais classé comme preuve mathématique.

## 3. Dépendances C-01 à C-05

| Dépendance | État observé | Ce que C-06 doit obtenir |
|---|---|---|
| **C-01 — signatures** | G=R×M×L×B est décrit ; π_U, Bang_G et Scale_Usage restent candidates dans C2, et certains domaines ne sont pas canoniques. | Ne pas utiliser projection/action comme primitives ratifiées ; typer les égalités et leurs domaines. |
| **C-02 — modalités** | ≼, inclusions des intervalles et morphismes de modes sont des objets distincts ; la réalisation des morphismes reste ouverte. | r≼r′ ⇒ π_U(r)≥π_U(r′) est conditionnel à π_U et ne prouve pas les conversions ni leur stabilité sous substitution. |
| **C-03 — conversions** | Identité/composition de ConvCtx sont dérivables sur papier comme relabellisation à support fixe. coerce/naturalité et diagrammes w/c ne sont pas démontrés ; Conv! dépend de π_U. Aucun lemme de cette interface n’a été trouvé dans src/. L’audit C-03 garde sa propre révision de référence ; son texte n’est pas utilisé seul comme état courant. | Démontrer le transport et sa compatibilité avec les constructeurs, Sub et SubBox. |
| **C-04 — When/ψ/budget** | Domaine de ψ, Adm, Consume et décision P3 restent à instruire/ratifier. | Cas When bloqué tant que passage d’effet, admissibilité et report des ressources ne sont pas prouvés. |
| **C-05 — W/D/Cost_Budget** | Lois papier conditionnelles enregistrées ; divergence entre signature partielle et formule max(W,D) à résoudre par décision humaine. | Les preuves doivent utiliser le domaine effectivement retenu, sans masquer la divergence. |

C8 batch 01 relève que le schéma générique de commutation n’énonce pas les équations par constructeur et que la préservation ne spécifie pas complètement traduction de contexte, prémisses et images des règles. Le schéma de ré-invocation laisse ouverte la compatibilité Scale_Usage/φ_n et mélange « fini » avec n∈N∞. thm:coherence_axiome et thm:coherence_usage ne deviennent pas des lemmes acquis par leur nom ou leur compilation.

### Lois déjà dérivables conditionnellement et dettes restantes

Il faut séparer les lois dont une dérivation papier conditionnelle est disponible, les lois simplement requises par l’esquisse et les obligations qui n’ont pas de preuve attachée.

- **Scale_Usage — papier sous hypothèses, pas Lean.** L’audit C-03 dérive, sur la formule candidate \(\mathrm{Scale\_Usage}(a,\langle u,m,\ell,\beta\rangle)=\langle a u,m,\ell,\beta\rangle\), l’identité à \(a=1\), la composition par associativité de la multiplication, l’additivité sur une somme de contextes bien formés quand l’addition et la distributivité du semi-anneau s’appliquent, et la monotonie sur l’ordre produit mixte. L’action nulle demande également la convention du semi-anneau et le support nul. Tous ces résultats sont **conditionnels** à la ratification de la candidate, à la définition exacte des opérations/contextes et au semi-anneau annoncé ; aucun n’est une preuve Lean ni une loi globale du grade complet.
- **ConvCtx — papier sous définition restreinte.** Si ConvCtx ne fait que relabelliser le grade sur un support de contexte fixé, identité et composition suivent liaison par liaison. Ceci n’établit ni une règle normative autonome, ni la stabilité de chaque jugement sous la conversion, ni aucune loi de coerce.
- **\(\varphi_n\) — calcul algébrique sur le fragment d’effet déclaré.** Pour un effet de la forme \(\langle\varepsilon_0,k\rangle\mapsto\langle\varepsilon_0^n,nk\rangle\), l’identité \(\varphi_1\), la composition \(\varphi_n\circ\varphi_m=\varphi_{nm}\) et le cas \(\varphi_0\) sont dérivables sous l’algèbre d’effets et les conventions d’exposant de la source. L’extension au cas \(n=\omega\) requiert l’existence des suprema pertinents et la préservation par les projections/transformations utilisées ; elle ne découle pas d’une récurrence sur les entiers finis. Rien de ceci autorise \(\varphi_a\) pour un usage rationnel \(a\in\mathcal R\).
- **Scale_Usage/ψ — obligation écrite, pas loi acquittée.** La commutation \(\mathrm{Scale\_Usage}(a,\psi(\Delta,\varepsilon))=\psi(\mathrm{Scale\_Usage}(a,\Delta),\varepsilon)\) est énoncée comme obligation de compatibilité et reste under-review/proofsketch ; il faut une signature/domaine de \(\psi\), la formation des deux côtés et une preuve pour tous les cas où elle est appelée (composition séquentielle, When, règles à contexte composé). Elle ne découle pas de la seule formule de Scale_Usage.
- **coerce, w, c et conversions Sub/SubBox — non établis.** Identité/composition de coerce, naturalité, diagrammes de compatibilité avec w/c, transport vers les constructeurs \(!\), et préservation des conditions annexes de Sub/SubBox ne sont pas déduits d’un nom d’interface ou de la direction de l’ordre. L’instance catégorique et son mapping vers les règles K7PL restent à expliciter.
- **Effets, budget et When — dépendances C-04/C-05.** La stabilité de \(\mathrm{Adm}\)/\(\mathrm{Consume}\), le comportement de \(\psi\) lors d’un report non borné et les lois de transport pour \(W,D,\mathrm{Cost\_Budget}\) ne sont pas acquittés par les dérivations de Scale_Usage ou \(\varphi_n\). Toute preuve C-06 de ces cas reste bloquée tant que les signatures et décisions humaines correspondantes sont ouvertes.

## 4. Table exhaustive des 49 occurrences de règles C3

La liste est obtenue en parcourant les marqueurs de règle dans le fichier source lié ci-dessus ; Alw figure deux fois, pour introduction et élimination temporelles. Chaque occurrence possède un cas propre. DPSH signifie seulement que l’étape décrite est conditionnellement directe.

| Règle | IH | Opérations/lois à vérifier | Classe |
|---|---|---|---|
| Var | Aucun ; séparer c=x de c=y≠x. | Pour x : unité et contexte nul imposés par Var. Pour y : usage nul, action nulle et neutralité du contexte. | **DPSH** |
| Ret | IH sur v. | Garder F₁V et l’effet unité après transport du contexte IH. | **DPSH** |
| Th | IH sur c. | Instancier cohérentement type U_εC et famille d’effet. | **DPSH** |
| Let | IH sur c₁,c₂ ; renommer x. | ⊠_{ε₁}, composition des effets et commutation Scale_Usage/ψ. | **IFS** |
| Fo | IH sur v. | Préserver U_εC et l’indice de l’effet. | **DPSH** |
| Box | IH sur v. | Relier r·Δ à Scale_Usage(π_U(r),Δ) et à !_rV. | **BDN** |
| Unbox | IH sur v,c ; renommer x. | ⊠₁, usage r de x et compatibilité Scale_Usage/ψ. | **IFS** |
| Lam | IH sur c ; renommer x frais. | Substitution sans capture et préservation de V_r⊸_εC. | **IFS** |
| App | IH sur fonction et argument. | Échelle d’usage, distribution sur ⊠_{ε₀}, compatibilité avec ψ et composition des effets. | **BDN** |
| Pair | IH séparées sur v₁,v₂. | Scale_Usage distribue sur + ; recomposer les contextes. | **DPSH** |
| Inj | IH unique sur v. | Conserver le même contexte ; aucune séparation r=r₁+r₂ entre deux prémisses n’existe ici. | **DPSH** |
| Pack | IH sur v:V[W/α]. | Compatibilité des substitutions de type/indice et fraîcheur de α. | **DPSH** |
| Open | IH sur v,c ; fraîcheur α,x. | Préserver la condition α∉fv(Δ₁⊠Δ₂)∪fv(ε)∪fv(C) et la composition de contextes. | **IFS** |
| One | Aucun IH ; terme fermé. | Action nulle et neutralité du contexte nul. | **DPSH** |
| OneE | IH sur v,c. | ⊠₁ et neutralité de la liaison/unité. | **IFS** |
| Split | IH sur v,c ; x,y frais. | Substitution des deux composantes, recomposition de contexte et type produit. | **IFS** |
| Case | IH sur le scruté et chaque branche ; lieurs frais. | Jointure de contexte/effet et stabilité de niv(Δ₁)⊑ℓ̂(ε). | **IFS** |
| Op | IH sur la valeur. | Domaine de l’effet et stabilité de niv(Δ)⊑ℓ̂(ε) sous expansion du contexte. | **IFS** |
| Tick | Aucun IH ; terme fermé. | Neutralité du contexte nul et signature de l’effet constant. | **DPSH** |
| Del | IH sur c. | Transport à travers ○Δ et ○C ; compatibilité d’usage avec la modalité. | **IFS** |
| Sub | IH sur c. | Stabilité de C<:C′ et ε⊑ε′ par substitution dans les indices/types/effets. | **IFS** |
| SubBox | Pas d’IH de terme dans cette règle de sous-typage. | Stabilité de r≼r′ et conversion !_rV vers !_r′V via coerce/π_U. | **BDN** |
| Alw⁺ (introduction) | IH sur v sous □Δ. | Commuter la substitution avec □ appliqué au contexte et préserver la disponibilité permanente. | **IFS** |
| Alw⁻ (élimination) | IH sur v. | Préserver □V→V sans dépense de ressource supplémentaire. | **DPSH** |
| Now | IH sur v. | Introduire ◇V sans changer le contrat de contexte. | **DPSH** |
| Wait | IH sur v. | Préserver ○◇V→◇V et l’indice d’effet. | **DPSH** |
| When | IH sur témoin v et corps c ; renommer x. | ε[ω/k], □Δ₂, ψ, Adm/Consume, coût et report illimité. | **BDN** |
| Sc | IH sur valeur d’opération et bloc. | Scale_Usage(n,−) sur contexte et φ_n sur effet restent séparés ; compatibilité ψ et domaine effectif, cas ω séparé. | **BDN** |
| Fold | IH sur v. | Substitution dans V[μα.V/α] et alpha-renommage de α. | **DPSH** |
| Unfold | IH sur v. | Compatibilité de substitution avec le type récursif instancié. | **DPSH** |
| Gen | IH sur c ; renommer α frais. | Préserver α∉fv(Δ), préciser fv et espaces de noms. | **IFS** |
| Inst | IH sur c. | Composition des substitutions d’indice/type et évitement de capture dans C[W/α]. | **DPSH** |
| Out | IH sur ν α.C⟨i+1⟩. | Substitution/indice successeur/type récursif ; domaine de i+1 et cas ω. | **IFS** |
| Cop | IH sur chaque cⱼ ; x frais. | Contexte partagé, substitution sous le lieur et taille i. | **IFS** |
| With | IH sur chaque composante cᵢ. | Le contexte est partagé, pas additionné ; établir que toutes les IH produisent le même contexte admissible. | **IFS** |
| Proj | IH sur c. | Conserver le contexte hérité et l’effet. | **DPSH** |
| VecI | IH sur chaque vᵢ. | Mise à l’échelle par longueur n, cas n=0 et recomposition. | **IFS** |
| VecE | IH sur le vecteur et c ; x frais. | Distinguer n·Δ₂ et ∏_{i<n}ε(i), indexation et ⊠. | **IFS** |
| Slice | IH sur v,c ; x,y frais. | Maintenir ρ=ρ₁⊎ρ₂, linéarité et disjonction des capacités. | **IFS** |
| Par | IH sur c₁,c₂. | Action sur les contextes additionnés et composition parallèle des effets. | **DPSH** |
| Vmap | IH sur v,w. | Séparer travail multiplié par n et profondeur ; action contextuelle et effet indexé. | **IFS** |
| Spawn | IH sur c. | Recalcul de ⟨spawn,⟨w(ε),0⟩⟩ et compatibilité de w. | **IFS** |
| New | Aucun IH ; primitive sans prémisse. | Le contexte reste nul ; action nulle. | **DPSH** |
| Send | IH sur destinataire et valeurs envoyées. | Types de messages, m[V̄]⊑E et agrégation des contextes. | **IFS** |
| Guard | IH dans chaque branche ; renommer lieurs de messages/boîte. | Motif résiduel Eᵢ, agrégations ⋁ᵢΔᵢ et ⋁ᵢεᵢ, compatibilité de substitution. | **IFS** |
| Free | IH sur v. | Préserver motif vide et contexte résultant. | **DPSH** |
| At | IH sur c. | Transport de @ₙ sur contexte/type/effet et stabilité de loc(Δ)⊒n. | **IFS** |
| Move | IH sur v. | Préserver Ser(V), n⊑m et admissibilité du contexte. | **DPSH** |
| Try | IH sur c,h. | Joint contextuel ⊔ et agrégation d’effet ; compatibilité avec Scale_Usage. | **IFS** |

### Conversions à intégrer à l’induction

ConvCtx/Conv! sont consignées dans la note de conception/audit C-03, pas comme opérateurs globaux canoniques du jeu de règles. Elles doivent être prises en charge par les cas de conversion ou explicitement reliées à Sub/SubBox.

| Conversion | IH | Obligations | Classe |
|---|---|---|---|
| ConvCtx | Réutiliser IH après relabellisation, à support fixe. | Identité/composition de la relabellisation sont dérivables sur papier ; règle normative et stabilité sous substitution restent ouvertes. | **IFS** |
| Conv! | IH sur terme de type !_rV. | Typage, naturalité et compatibilité de coerce_{π_U(r),π_U(r′),V} avec w,c et !. | **BDN** |

## 5. Usages directs et conséquences dans le manuscrit

La recherche des références actives a identifié les usages suivants. Les mentions des registres, des matrices de couverture et des archives Org sont des index/provenances ; elles ne constituent pas des preuves indépendantes.

| Emplacement courant | Utilisation exacte | Dette transmise depuis C-06 |
|---|---|---|
| C3, ReglesDeTypage.lean, thm:substitution | Énoncé élémentaire, terme/type/indice d’effet ensemble ; under-review/proofsketch. | La matrice de la section 4 couvre les occurrences de règle, mais les cas IFS/BDN et H0–H8 restent à démontrer. |
| C3, ReglesDeTypage.lean, thm:substitution_simultanee | Corollaire annoncé de la substitution élémentaire ; under-review/proofsketch. | Dépend du lemme élémentaire et d’un ordre admissible d’instanciation/retrait des liaisons. Une discipline ordonnée demande explicitement l’ordre inverse d’occurrence dans la zone. |
| C3, LeSystemeGradue.lean, discussion des zones | Le lemme est utilisé pour la condition de substitution sous contexte ordonné : substitution seulement dans la liaison maximale de sa zone. Le texte distingue préservation, relation logique et traduction. | La préservation d’une réduction utilise la maximalité du lieur nouvellement introduit ; la relation logique requiert une décomposition de la substitution simultanée en substitutions simples à ordre inverse ; la traduction parallèle vers une composition cible commutative ne reflète pas l’ordre source. Si la représentation zonée est retenue, ce sont des obligations sémantiques, pas de simples notations. |
| C4, SemantiqueOperationnelle.lean, thm:preservation | Le sketch raisonne par induction sur les réductions ; dans les réductions pures, il invoque la substitution pour obtenir le jugement du contractum avec le même effet. Unbox est le cas gradué (grade r et contexte de l’argument mis à l’échelle) ; Open dépend de sa condition de fraîcheur de α pour contexte, effet et type. | Requiert la conclusion C-06 sous le contrat exact du contexte mis à l’échelle, ainsi que preuve de maintien de la condition de fraîcheur de Open. La propriété reste under-review/proofsketch et ne constitue pas un résultat établi. |
| C4, SemantiqueOperationnelle.lean, thm:lemme_fondamental | Le sketch emploie la substitution deux fois : pour établir que l’application de γ/γ′ laisse le terme typé et son contexte composé, puis dans les cas Let/App via Scale_Usage et ψ. Il nomme explicitement la forme simultanée pour la substitution d’environnement. | Requiert la conclusion élémentaire ET simultanée avec contextes composés, puis les lois d’action/ψ. Le source courant borne le lemme fondamental aux termes et images de substitution sans Declassify. La revue de dépendances dit que PR #117 a supprimé le cycle syntaxique antérieurement signalé par C8 ; cela ne prouve ni le fragment logique ni l’extension divulgation. |
| C4, SemantiqueOperationnelle.lean, thm:commutation_traduction | La traduction d’un terme substitué est comparée à la substitution dans la traduction, modulo congruence structurelle de la cible. Le sketch invoque schema_commutation et la dérivation de substitution, notamment les deux sous-cas Var. | Requiert fraîcheur, compatibilité de chaque constructeur de traduction avec substitution et preuve que le grade non nul localise la prémisse pertinente. Une preuve du jugement source ne prouve pas seule l’équation de traduction. |
| C5, CeQuUneMacroDeclare.lean, thm:expansion_macro | Expand est dérivée par substitution à chaque occurrence du corps ; les effets se composent dans l’ordre syntaxique des occurrences. L’effet devient εᵢ₁·…·εᵢₖ, précédé de l’effet déclaré du corps. | Requiert la substitution élémentaire itérée, Scale_Usage(π_U(rᵢ),Δᵢ) sur les contextes et la composition séquentielle des effets. La quantale étant potentiellement non commutative, on ne peut pas regrouper les occurrences d’un même argument sous φₙ sans hypothèse de commutation supplémentaire. |
| C2, AdjonctionsEtEnrichissement.lean, argument de divulgation | Le texte de sécurité remarque qu’une substitution pourrait contourner la frontière de divulgation ; ce n’est pas une application déjà prouvée de thm:substitution au cas Declassify. | Le contrat C3 ne couvre pas automatiquement le calcul de sécurité. La condition de clôture des échappatoires et une clause de relation logique pour la divulgation demandent leurs preuves propres. |

Les entrées des archives/manuscrits Org et des matrices de migration reproduisent origine et classification ; elles ne sont pas des instances supplémentaires du lemme normatif. Les usages indirects doivent rester tracés par les dépendances explicites ci-dessus, sans inférer que thm:preservation, thm:image_fix ou un résultat de traduction est prouvé parce qu’il est voisin dans le graphe.

## 6. Liaison et contre-exemple de capture

Les lieurs de terme incluent au minimum Lam, Let, Unbox, Split, Case, Open, When, Cop, Slice et Guard ; les lieurs de type incluent Pack/Open, Fold/Unfold, Gen et Inst. La définition formelle doit indiquer l’égalité modulo alpha-renommage et les espaces de noms des indices/tailles/niveaux.

**Contre-exemple à une substitution naïve :** sous Λα.c, si α n’est pas libre dans c mais l’est dans le terme substitué v (ou son type), remplacer textuellement x par v capture α. Cela ne donne pas la substitution libre visée. Il faut renommer d’abord α en α′ frais vis-à-vis de v, des contextes, types et effets, puis substituer. Cela réfute la substitution textuelle non hygiénique, pas le théorème avec substitution capture-avoiding.

Open a déjà une condition de fraîcheur sur α dans contexte/effet/type ; il reste à démontrer qu’elle survit à la substitution. La forme simultanée demande un ordre explicite de retrait des liaisons sous discipline d’échange.

## 7. Limites de portée

- **Arena :** le texte C3 dit que l’élimination d’arène n’est pas donnée dans le jeu de règles et doit venir du chapitre mémoire ou d’un paramètre. Aucun cas de substitution ne peut lui être attribué avant d’avoir sa règle/signature.
- **Fix/Declassify :** le jugement C3 inventorié ici ne donne pas de règles de typage Fix/Declassify parmi ses 49 occurrences. Le source courant de thm:lemme_fondamental en C4 borne explicitement terme et images de substitution au fragment sans Declassify ; la revue de dépendances indique que PR #117 a supprimé le cycle syntaxique antérieurement signalé par C8 batch 11. Cela ne prouve pas divulgation délimitée ni un théorème étendu à Declassify : toute extension exige règles et conditions propres.
- **Métalangage/traduction :** substitution sur le langage cible, commutation de traduction, préservation du sortage et hygiène des macros sont des contrats séparés. Une preuve du jugement source ne les prouve pas par transitivité ou par citation d’un schéma.
- **Utilisations :** thm:substitution_simultanee, réduction de l’application, macro-expansion et les schémas commutation/traduction doivent dépendre des hypothèses réellement prouvées, non d’un théorème portant un nom similaire.

## 8. Squelette de preuve et options

Squelette conditionnel : (1) fixer une dérivation D, une dérivation pour v et H0–H8 ; (2) traiter Var par les cas x et y≠x et les lois d’unité/zéro ; (3) appliquer l’IH à chaque prémisse de chaque règle puis reconstruire le contexte selon l’opération propre à cette règle ; (4) alpha-renommer chaque lieur et préserver toutes les side conditions ; (5) séparer Scale_Usage sur le contexte de φ_n sur l’effet ; (6) prouver la stabilité de Sub/SubBox et des conversions ; (7) vérifier type, effet, contexte et prémisses annexes pour chaque ligne. Les lignes IFS/BDN indiquent où cette preuve n’est pas justifiée actuellement.

Options non adoptées : restreindre explicitement le théorème au fragment prouvé ; compléter les signatures/lois puis démontrer tous les cas ; séparer C3 des extensions Arena/sécurité/métalangage ; ou, seulement après contre-exemple typé et ratification, réviser une règle. Aucun choix normatif n’est fait ici.

## 9. Régression et clôture

Le test tests/python/test_stage_c_substitution_audit.py compare la matrice à l’inventaire du fichier source. Il détecte l’ajout/suppression d’un marqueur ou une ligne manquante ; il ne vérifie ni la vérité mathématique ni la sémantique de l’évitement de capture.

À vérifier sur le SHA de la PR : python3 -m pytest tests/python/test_stage_c_substitution_audit.py -q, puis python3 -m pytest tests/python -q, build/rendu Verso, liens et gate CI. Documenter quels jobs ont réellement tourné et lesquels ont été ignorés par des filtres de chemins.

**Critères de clôture :** les 49 occurrences sont traitées individuellement ; les extensions revendiquées sont incluses ou explicitement exclues ; signatures/domaines/fraîcheur sont établis ; conversions, ψ, When, SubBox et φ_n sont démontrés dans leurs domaines exacts ; papier, Lean, test, CI et décision humaine restent distingués.

**Verdict : C-06 OUVERT.** La complétude de l’esquisse est réfutée par omissions et par la mauvaise classification d’Inj ; le théorème de substitution n’est ni prouvé ni réfuté dans son ensemble.