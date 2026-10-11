<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — registre des objets théoriques

**État :** IN PROGRESS — exploration architecturale bornée ; porte de sortie C non satisfaite  
**Périmètre :** étape C — interfaces, preuves et obligations sémantiques résiduelles  
**Statut épistémique :** dossier d'instruction, non normatif.

Ce registre ne décide pas à lui seul de la validité mathématique des constructions. Il sert à
séparer les objets que la spécification emploie, leur statut, les relations qu'elle affirme entre
eux et les obligations qui restent à établir. Une modification normative n'est admise que lorsque
l'objet concerné, sa signature et la propriété invoquée sont identifiés.

## 1. Règle d'instruction

Pour chaque objet théorique, la reprise suit la chaîne :

`objet → signature → rôle normatif → dépendances → propriété invoquée → évidence → formalisation`.

Les statuts utilisés ici sont :

- **NORMATIF** : l'objet appartient au langage ou à son système de jugement ; sa modification
  change le contenu normatif de K7PL.
- **DÉRIVÉ** : l'objet est construit à partir d'objets normatifs ; il ne constitue pas une
  nouvelle primitive normative.
- **OBLIGATION** : propriété que la spécification doit établir pour justifier un objet ou une
  relation ; elle ne doit pas être présentée comme déjà démontrée.
- **DÉPENDANCE FORMELLE** : construction provenant d'un cadre externe utilisée pour la preuve ou
  la mécanisation ; elle ne devient pas normative par son seul emploi.
- **PROFIL** : paramètre de représentation ou d'exécution qui conditionne une propriété
  d'implémentation ; il ne doit pas être absorbé par la sémantique du langage.

Une même notion lexicale peut donc donner plusieurs objets distincts. La reprise interdit de les
fusionner sans relation explicitement établie.

## 2. Noyau catégorique et modal

| Objet | Statut | Fonction | Dette principale |
|---|---|---|---|
| `C` comme SMCC | NORMATIF | cadre catégorique annoncé par P1a | caractériser précisément ce que la structure permet et ne permet pas |
| `⟦-⟧_C` | OBLIGATION | interprétation des dérivations dans `C` annoncée par P1b | définir la fonction et sa correction, ou ne plus invoquer P1b |
| adjonction linéaire–non-linéaire | DÉRIVÉ | support de l'exponentielle et des fragments | distinguer les propriétés de l'adjonction de celles du langage |
| `!_r` | DÉRIVÉ | syntaxe d'une ressource graduée | factorisée par `π_U : 𝒢 → 𝓡` ; le noyau comonadique est indexé par `𝓡` |
| mode | NORMATIF | détermine les règles structurelles admissibles | relier mode, grades et sédimentation sans ajouter une règle ad hoc |
| morphisme de modes | DÉPENDANCE FORMELLE | passage entre structures de mode | vérifier la réalisation des modes K7PL et leur ordre sans les identifier aux intervalles d'usage |
| support d'indexation de la comonade | DÉRIVÉ | carrier effectif des indices de `!` | `𝓡` est le support de référence ; vérifier `w`, `c`, `coerce` et leurs lois de naturalité |
| `φ_n` | DÉRIVÉ | transformation de l'effet pour une répétition entière | domaine de référence : multiplicités effectives `n` ; ne pas l'étendre automatiquement aux usages rationnels |
| `mise à l'échelle d'un grade complet` | DÉRIVÉ | élaboration règle-locale de l'action sur un contexte | `Scale_Usage(a,<u,m,ℓ,β>)=<a·u,m,ℓ,β>` pour `Box`, `App`, substitution et contexte de `Sc` ; pas de multiplication globale de `𝒢` requise |
| `Cost_Budget` | DÉRIVÉ / INTERFACE À RÉCONCILIER | scalarisation du coût temporel vers le budget | la source C2 déclare encore une flèche partielle, mais définit ensuite max(W,D) ; séance 60 décrit cette dernière comme scalarisation totale sous hypothèses. Ne pas choisir silencieusement le domaine. |
| `Unr ⊑ Aff ⊑ Lin` | DÉRIVÉ | ordre de précision des usages | ne pas le confondre avec le sous-typage modal `≼` |

Point de contrôle : trois relations doivent rester distinctes : l'inclusion des intervalles modaux
`Lin ⊆ Aff ⊆ Unr`, le sous-typage modal `≼` et l'ordre de précision `⊑`. Le mode `Rel = [1..ω]`
est mathématiquement admissible dans la construction générale mais n'est pas générable par les règles
actuelles de K7PL. Cette distinction doit être conservée : admissibilité algébrique ≠ atteignabilité
syntaxique ≠ précision.

**Correction critique de C — modes et intervalles.** La définition de mode utilisée dans la littérature de référence n'est pas celle d'un intervalle de grades : elle combine une algèbre de grades, un idéal de contraction et un prédicat d'affaiblissement. Les intervalles `U_m` de K7PL ne sont donc que des domaines syntaxiques d'annotations. En particulier, `U_Aff = [0..1]` n'est pas fermé par addition et ne peut pas jouer le rôle d'une algèbre de grades. La démonstration antérieure « inclusion d'intervalles ⇒ morphisme de modes » est retirée comme trop forte. Une réalisation structurelle candidate par les quatre triplets `M_Lin`, `M_Aff`, `M_Rel`, `M_Unr` est maintenant exposée en C2/C3 ; sa correspondance avec le jugement K7PL reste à vérifier.

**Interface de mise à l'échelle enregistrée en séance 62 (statut normatif à réconcilier ; lois encore à prouver).** L'action est locale à la composante d'usage :

\[
\mathrm{Scale\_Usage} : \mathcal R \times \mathcal G \to \mathcal G,\qquad
\mathrm{Scale\_Usage}(a,\langle u,m,\ell,\beta\rangle)
=\langle a\cdot u,m,\ell,\beta\rangle.
\]

Elle ne définit aucune multiplication globale de \mathcal G et ne met pas à l'échelle le budget. Les règles VAR, Box, App, VECI et SC ainsi que les opérations de contexte doivent être contrôlées contre cette signature. φ_n est une transformation d'effets indexée par une multiplicité effective n ; son domaine ne s'étend pas automatiquement aux usages rationnels. La monotonie, la compatibilité avec les conversions et la fermeture de la substitution demeurent des obligations distinctes.

## 3. Grades et raffinement

**Constat de reprise.** Une incohérence de porteur a été trouvée entre C2 et la grammaire C3 : `\mathcal{R}`
est défini en C2 comme le semi-anneau `Q≥0 ∪ {ω}`, alors que la grammaire C3 le réutilisait pour le
quadruplet complet. La grammaire a été corrigée pour réserver `\mathcal{R}` au porteur de la composante
usage et `\mathcal{G}` au produit des quatre composantes. `N∞` reste la structure réservée aux tailles.
Cette correction est de portée notationnelle mais elle est nécessaire : sans elle, les grades
rationnels admis par C2 disparaissent de la grammaire générale.

**Constat de reprise.** Le porteur `R = Q≥0 ∪ {ω}` et les quatre intervalles `Lin`, `Aff`, `Rel`, `Unr`
forment une construction algébrique plus large que les trois modes effectivement générables. `Rel`
est donc un objet de l'espace théorique, mais pas une modalité du langage au sens syntaxique actuel.
Aucune extension de la grammaire ou des règles de typage n'est introduite à ce stade.

| Objet | Statut | Fonction | Dette principale |
|---|---|---|---|
| semi-anneau d'usage `𝓡` | NORMATIF | quantification de la composante d'usage | vérifier les lois effectivement requises par les règles ; `𝒢` reste le porteur du grade complet |
| contexte gradué | NORMATIF | porte les usages des liaisons | établir substitution et opérations de contexte |
| produit mixte de précision | NORMATIF | combine les dimensions de précision | vérifier chaque composante et sa direction |
| `⊖` | NORMATIF | soustraction tronquée du budget | conserver sa définition par cas et ses lois propres |
| budget | DÉRIVÉ | borne de ressource, non mesure exacte | ne pas lui attribuer une propriété de résidu non établie |
| `ℰ_alg`, `ℰ_scoped` | NORMATIF | distinguent effets algébriques et effets à portée | établir séparément leurs lois de composition |
| relation de précision `⊑` | NORMATIF | ordre transversal sur les artefacts | établir monotonie et opérations réellement utilisées |

Le registre distingue volontairement le porteur algébrique, le jugement gradué, la relation de
précision et le budget. Une preuve portant sur l'un ne doit pas être automatiquement propagée aux
trois autres.

## 4. Temporalité et sédimentation

| Objet | Statut | Fonction | Dette principale |
|---|---|---|---|
| `○S` | NORMATIF | temporalité au pas suivant | établir sa discipline de garde |
| `□S` | NORMATIF | permanence | préciser son interaction avec les ressources |
| `◇S` | NORMATIF | éventualité | déterminer la structure supplémentaire retenue |
| `delay`, `now`, `wait`, `when` | NORMATIF | opérations temporelles | vérifier leur couche d'introduction et leurs invariants |
| tailles inductives `𝕊_μ` | NORMATIF | mesure de terminaison | ne pas les confondre avec les tailles coinductives |
| tailles coinductives `𝕊_ν` | NORMATIF | mesure de productivité | vérifier le traitement de `∞` et la dualité |
| récursion gardée | DÉPENDANCE FORMELLE | justification de certaines disciplines temporelles | produire une analyse séparée pour les trois couches |

La temporalité ne doit pas être traitée comme un objet unique. L'étape C doit produire une carte
couche → construction → invariant → règle → propriété avant toute conclusion sur la théorie
temporelle globale.

**Interface temporelle retenue (séances 59–62 ; preuve non acquise).** When transforme l'effet temporel en la famille non bornée κω(ℓ)=⟨ω,ω⟩, notée ε[ω/k]. Les notes de conception définissent W comme le supremum des sommes finies de travail, D comme le supremum ponctuel de profondeur, puis Cost_Budget(κ)=max(W(κ),D(κ)). Adm(β,κ) vaut (β=ω) ou Cost_Budget(κ)≤β ; Consume(β,κ)=β⊖Cost_Budget(κ) n'est défini que sur le domaine admissible. La consommation est déclenchée au franchissement du contexte par ψ, selon Δ₁ ⊠ε Δ₂ = Δ₁ + ψ(Δ₂,ε), et non par la seule production d'un effet non borné. Cette résolution de conception remplace la bifurcation architecturale antérieure, mais ne prouve pas la correction de ressource. Il faut encore définir précisément le domaine partiel de ψ et vérifier chaque règle et cas-frontière.

## 5. Sémantique et concurrence

| Objet | Statut | Fonction | Dette principale |
|---|---|---|---|
| configuration `⟨c ∣ μ ∣ τ⟩` | NORMATIF | support de la réduction | préciser les invariants de `μ` et `τ` |
| réduction `→` | NORMATIF | définition de l'exécution | établir son accord avec la traduction du métalangage |
| trace `τ` | NORMATIF | observation des effets et du temps | distinguer séquentialité et ordre partiel |
| traduction `⟦-⟧` vers le métalangage | NORMATIF | sémantique opérationnelle de la couche 2 | compléter les clauses d'opérations |
| `Sim` | OBLIGATION | relie `→` à la réduction cible | preuve de simulation ; PREUVE-07 |
| acteur / coalgèbre | DÉRIVÉ | structure comportementale de la couche 2 | distinguer construction théorique et réalisation runtime |
| canal de session | DÉRIVÉ | représentation des protocoles | établir les correspondances de typage |
| motif de jonction | NORMATIF | synchronisation concurrente | préserver la contrainte de partition/disjonction |

La relation de réduction et la traduction ne sont pas deux définitions concurrentes. La première est
l'objet opérationnel ; la seconde est une représentation dont la fidélité dépend de `Sim`.

## 6. Mémoire et représentation

| Objet | Statut | Fonction | Dette principale |
|---|---|---|---|
| région d'arène | NORMATIF | domaine de portée mémoire | définir sa discipline de portée |
| `WriteCap(r)` | NORMATIF | autorité linéaire d'écriture | établir l'unicité d'introduction |
| `Range` | NORMATIF | partition d'une arène | établir disjonction et élimination |
| modèle mémoire abstrait | DÉRIVÉ | justification de la sûreté spatiale | séparer modèle abstrait et machine concrète |
| profil `Π` | PROFIL | paramètres de représentation/exécution | ne pas le transformer en propriété intrinsèque du langage |
| `E_repro` | PROFIL | hypothèse de reproductibilité de représentation | expliciter son contenu et ses projections |

Le point de contrôle majeur est la séparation entre sûreté du calcul, modèle mémoire et conformité à
une représentation concrète. Une propriété du dernier niveau ne doit pas être rétro-projetée dans le
premier.

## 7. Objets externes de formalisation

| Objet | Statut | Règle de frontière |
|---|---|---|
| patron de types gradués formalisés | DÉPENDANCE FORMELLE | ne prouve que les propriétés effectivement instanciées |
| Calf/Decalf | DÉPENDANCE FORMELLE | une construction disponible n'est pas une construction normative K7PL |
| Lean | OUTIL DE FORMALISATION | le succès de compilation n'établit pas la correction scientifique |
| tests différentiels | ÉVIDENCE | une absence d'écart ne remplace pas une preuve de fidélité |

## 8. Ordre de reprise

L'étape C est conduite dans l'ordre suivant :

1. **Objets et frontières.** Stabiliser les signatures, statuts et relations des objets ci-dessus.
2. **Modes et grades.** Vérifier la chaîne mode → grade → jugement → règles → propriétés.
3. **Temporalité.** Instruire la sédimentation par couche et la structure supplémentaire de `when`.
4. **Sémantique.** Conduire `Sim` et les obligations de traduction sans les confondre avec la
   réduction source.
5. **Mémoire.** Compléter H1/H2 et la frontière modèle abstrait / machine.
6. **Formalisation.** Pour chaque objet stabilisé, établir sa correspondance avec Lean sans utiliser
   la mécanisation comme preuve rétroactive.
7. **Ratification.** Revenir aux décisions historiques uniquement lorsqu'un résultat mathématique
   ou un contre-exemple nouveau l'exige.

Les travaux ultérieurs sur les singularités, `∥` et `spawn` doivent réutiliser ce registre :
ils ne doivent pas introduire implicitement un nouvel objet théorique ou modifier une relation
existante sans mettre à jour sa frontière.

## 9. Critères de sortie de l'étape C

C ne sera pas déclaré terminé lorsque les fichiers seront « cohérents » visuellement. Il faudra :

- qu'aucun objet normatif central ne soit défini uniquement par son usage implicite ;
- que chaque relation invoquée par une preuve possède une direction et un domaine explicites ;
- que les dépendances formelles externes soient séparées des engagements K7PL ;
- que les propriétés encore conjecturales restent marquées comme telles ;
- que les contradictions entre décision de migration et texte normatif soient soit corrigées, soit
  explicitement justifiées ;
- que les objets retenus disposent d'une correspondance traçable vers les règles, les propriétés
  et la formalisation ;
- que le périmètre restant soit suffisamment petit pour ouvrir les étapes D à G sans déplacer
  silencieusement les fondations.

Ce registre est un instrument de contrôle. Il ne transforme aucune obligation en résultat établi.


**Correction critique de C — séparation usage/exécution.** Le grade d'usage `u` mesure une quantité de ressource et ne doit pas être assimilé à une multiplicité d'exécution `n`. La définition `φ_r(ε)=ε^u` ne s'étend donc pas automatiquement aux usages rationnels `u∈ℚ≥0`. Les preuves de compatibilité qui remplacent `u` par un facteur d'exécution doivent être restreintes à un domaine où cette identification est explicitement justifiée.


**Dette d'interface désormais bornée.** Le grade porte un budget scalaire $`\beta \in \mathbb{N}_\infty`, tandis que le coût temporel courant est une famille $`\kappa \in (\mathbb{N}_\infty\times\mathbb{N}_\infty)^{\mathcal L}`$ de couples travail/profondeur par niveau. Sous budget scalaire + P3, la scalarisation minimale est dérivée : `Cost_Budget(κ)=max(W(κ),D(κ))`. Les agrégateurs sont désormais définis par les sommes finies sous supremum pour `W` et le supremum ponctuel pour `D`; l'admissibilité `Adm` est distincte de `⊖` et s'applique au franchissement de l'effet par `ψ`. Un budget vectoriel reste une extension possible, mais n'est pas requis par les règles actuelles.

**Piste théorique à instruire, sans décision normative.** Dans les systèmes multimodaux de type Grass, les grades d'un contexte peuvent être hétérogènes et la mise à l'échelle d'un vecteur est définie composante par composante après transport du scalaire par un morphisme de modes. Cette construction pourrait fournir un modèle alternatif au produit unique `𝒢`; elle ne doit pas être assimilée à la solution actuelle avant comparaison formelle avec les quatre composantes de K7PL.


## 10. Frontière désormais stabilisée de l'étape C

L'exploration architecturale des objets théoriques est considérée comme close sous réserve des
preuves et décisions explicitement listées dans le registre. Les tests 59–60 ont clos la bifurcation `When`/budget et fixé les agrégateurs canoniques du coût temporel. Les signatures ne doivent plus évoluer
par simple recherche de cohérence notationnelle.

La construction de référence est désormais accompagnée d'une loi de transport explicite pour les conversions de contexte et de `!`.

**Frontière de clôture de l'exploration.** La séance 62 établit que les signatures du sous-système grade/exponentielle/coût ne constituent plus une question de recherche architecturale. Les dettes restantes sont des preuves de naturalité, de substitution et de correction sémantique.

`𝒢 → π_U → 𝓡 → !`

avec `Scale_Usage` pour l'action contextuelle, `φ_n` pour les transformations d'effets liées aux
répétitions effectives et `Cost_Budget` comme interface scalaire du coût temporel.

Les obligations restantes sont bornées et classées dans la matrice C-01 à C-09 ci-dessous. L'exploration de conception du sous-système grade/exponentielle/coût est close, mais la porte de sortie globale de C demeure NON SATISFAITE. Les comptes rendus constituent la provenance des décisions de conception ; ils ne sont ni des preuves formelles ni une ratification humaine lorsque celle-ci est requise.

## 11. Matrice des obligations résiduelles de C

**Écart critique entre registre de conception et source normative.** Le manuscrit C2 qualifie encore π_U et Scale_Usage de candidats d'architecture, alors que les séances 59–62 les décrivent comme l'interface de référence. Il déclare aussi Cost_Budget : (ℕ∞×ℕ∞)^ℒ ⇀ ℕ∞ comme fonction partielle, puis expose Cost_Budget(κ)=max(W(κ),D(κ)) sans condition de domaine dans la définition de la scalarisation. Le registre n'élève pas une note de séance au rang normatif : l'autrice doit confirmer la promotion des interfaces candidates et décider si la flèche partielle est intentionnelle ou doit devenir totale sous les hypothèses scalarisation/P3. Jusque-là, ce point empêche la fermeture de la porte C.

Cette matrice consolide les audits de source existants et les séances 59–62 ; elle n'est ni une preuve ni une validation indépendante. Les fichiers sous spec/Spec sont des sources Verso contenant définitions textuelles, énoncés et esquisses, non des déclarations Lean correspondant automatiquement à des théorèmes machine-vérifiés. Leur compilation vérifie parsing/rendu et les contrôles associés, pas la vérité mathématique des propositions exposées.

### C-01 — Signatures des grades, usages et modes

**Classe :** question d'interface formelle et obligations mathématiques.

**Contrat de référence :** R = ℚ≥0 ∪ {ω}, avec addition, multiplication, zéro, unité et ordre annoncés ; G = R × M × L × B, B = ℕ∞ ; π_U : G → R ; Bang_G(r,A) := !_{π_U(r)}A comme interface candidate ; Scale_Usage : R × G → G agit sur la seule coordonnée d'usage comme interface candidate ; φ_n transforme un effet pour une multiplicité effective n ; le manuscrit C2 note actuellement Cost_Budget : K ⇀ B, alors que max(W,D) semble définir une fonction totale sous les hypothèses retenues ; Adm : B × K → Prop ; Consume : B × K ⇀ B, partielle hors du domaine admissible. Pour coerce, w, c et ψ, les types sont à vérifier contre leurs définitions canoniques et les objets effectivement présents dans le manuscrit : ne pas déduire leur signature complète de leur seule utilisation en prose.

**Hypothèses et cas manquants :** rendre canoniques les porteurs M et L et leurs opérations ; inventorier chaque relation et fonction employée par une règle avec domaines, codomaines, direction et conditions de définissabilité. Le produit d'ensembles G n'est pas un semi-anneau par lui-même. Il faut identifier la définition source de φ_n et les cas de répétition effectivement couverts sans assimiler usage rationnel et nombre d'exécutions.

**Dépendances :** chapitres 2–3, sessions 61–62, propositions de cohérence et de substitution.

**Critère de clôture :** chaque objet central a une signature explicite dans la source normative ou un renvoi non ambigu à cette signature ; chaque règle utilise seulement des opérations typées ; aucune multiplication globale de G ni extension implicite de φ_n n'est nécessaire.

### C-02 — Domaines et directions des relations modales

**Classe :** obligation mathématique et correspondance formelle.

**Relations à garder distinctes :** inclusion des intervalles syntaxiques Lin ⊆ Aff ⊆ Unr ; sous-typage modal ≼ ; ordre de précision Unr ⊑ Aff ⊑ Lin ; morphisme entre modes structurels M_m. La direction du transport d'index retenue est r ≼ r' ⇒ π_U(r) ≥ π_U(r'). Ces relations ne sont pas interchangeables.

**Hypothèses et cas manquants :** définir les quatre triplets candidats M_Lin, M_Aff, M_Rel et M_Unr avec algèbre de grades, idéal de contraction et condition d'affaiblissement ; exposer le contrat exact de morphisme de modes et la direction de l'inclusion de Cont ; vérifier chaque flèche candidate et les contre-exemples exigés pour l'incomparabilité Aff/Rel. Rel = [1..ω] appartient à l'espace théorique mais n'est pas généré par les règles courantes.

**Dépendances :** thm:morphismes_modes, audit C8 batch 10, définition du sous-typage et factorisation π_U.

**Critère de clôture :** preuve ou contre-exemple pour chaque flèche et chaque non-comparabilité ; aucune dérivation de morphisme à partir de la seule inclusion des intervalles.

### C-03 — coerce, w, c, conversions et Scale_Usage

**Classe :** preuve mathématique avec dépendance formelle catégorique externe.

**Contrat de transport consigné en séance 61 :** ConvCtx(r,r') transforme une liaison x:_r V en x:_r' V lorsque r ≼ r', sans changer variable ni type. ConvCtx(r,r)=id ; pour r ≼ s ≼ t, ConvCtx(r,t)=ConvCtx(s,t)∘ConvCtx(r,s). Conv!_{r,r',A} est coerce_{π_U(r),π_U(r'),A} dans la direction induite par π_U(r) ≥ π_U(r'). Scale_Usage(a,⟨u,m,ℓ,β⟩)=⟨a·u,m,ℓ,β⟩. Le texte C2 qualifie encore π_U et Scale_Usage de candidats d'architecture : ce classement doit être rendu cohérent avec la ratification ou non des séances 59–62.

**Hypothèses et cas manquants :** prouver coerce_{u,u,A}=id et coerce_{u,u'',A}=coerce_{u',u'',A}∘coerce_{u,u',A} sur les indices admissibles ; prouver naturalité et compatibilité avec counité w et comultiplication c de la comonade indexée ; démontrer que Scale_Usage préserve ≼ et commute avec la relabellisation de contexte ; vérifier le transport des types qui portent !, pas uniquement l'annotation de contexte. La référence externe ne prouve pas à elle seule l'instance K7PL.

**Dépendances :** modèle catégorique de !, hypothèses exactes des imports, sessions 61–62, thm:coherence_subsomption et thm:substitution.

**Critère de clôture :** les diagrammes ont des types source/cible cohérents ; les lois sont prouvées ou les hypothèses externes explicitement déclarées ; les cas de conversion sont couverts par l'induction de substitution.

### C-04 — When, ψ, Cost_Budget, Adm et Consume

**Classe :** obligation sémantique, correction de ressource et ratification normative.

**Contrat de conception :** When produit κω(ℓ)=⟨ω,ω⟩. W et D agrègent la famille κ ; Cost_Budget=max(W,D). Adm(β,κ) accepte β=ω ou Cost_Budget(κ)≤β. Consume soustrait Cost_Budget à β seulement si Adm est vraie. ψ s'applique quand un effet traverse le contexte dans Δ₁ ⊠ε Δ₂ = Δ₁ + ψ(Δ₂,ε).

**Hypothèses et cas manquants :** définir l'interface et le domaine partiel exacts de ψ, les conditions de partage des liaisons de contexte et la coordonnée de budget modifiée. Prouver règle par règle que le coût temporel de l'effet est bien le coût de l'opération composée ; traiter When en contexte local, passage de When par budget infini, passage par budget fini, coût nul et coûts finis aux frontières. Vérifier la soustraction tronquée, notamment ω⊖ω=ω, β fini et coût ω. La lecture P3 adoptée par les séances doit être ratifiée si elle n'est pas déjà confirmée comme décision d'autrice : l'alternative « attente externe hors budget » exige de distinguer latence et coût d'exécution au lieu de conserver implicitement le même Cost_Budget.

**Dépendances :** règles temporelles du chapitre 3, composition des contextes, P3, C-05 et C-06.

**Critère de clôture :** aucune traversée de contexte non admissible n'est typable ; le coût n'est jamais masqué ; tous les cas limites sont couverts par la preuve de correction de ressource.

### C-05 — Agrégateurs W/D et scalarisation

**Classe :** preuve mathématique.

**Définitions consignées en séance 60 :** si κ(ℓ)=⟨w_ℓ,s_ℓ⟩, W(κ)=sup {Σ_{ℓ∈F} w_ℓ | F ⊆ ℒ, F fini} et D(κ)=sup_{ℓ∈ℒ}s_ℓ dans ℕ∞. Sous budget scalaire et P3 interprété comme borne commune sur travail et profondeur, Cost_Budget(κ)=max(W(κ),D(κ)) est la plus petite borne scalaire dominante. Attention : le symbole ⇀ de la signature encore présente dans C2 suggère un domaine partiel ; il n'est pas cohérent de traiter simultanément la fonction comme totale sans préciser si la partialité appartient à l'interface normative ou est une trace historique.

**Hypothèses et cas manquants :** prouver la monotonie ponctuelle, W(0)=D(0)=0, l'additivité du travail sous séquencement et parallélisme, la sous-additivité de profondeur sous séquencement, le maximum de profondeur sous parallélisme et la sous-additivité correspondante de Cost_Budget. Vérifier supremums pour L infini, famille nulle, valeurs ω et opérations réellement produites par chaque règle. Le compte rendu qui donne la définition n'est pas l'évidence d'une preuve complète.

**Dépendances :** ordre et supremums de ℕ∞, définition normative de κ, Adm/Consume et contrat de ψ.

**Critère de clôture :** chaque loi invoquée est démontrée pour les opérations réellement retenues ; aucune égalité plus forte que les bornes requises n'est supposée.

### C-06 — Substitution, conversions, Scale_Usage et φ_n

**Classe :** obligation mathématique sur le typage et les effets.

**Hypothèses à isoler :** formation des types sous usage effacé ; identité, composition et monotonie de Scale_Usage ; compatibilité avec ψ ; conversion ConvCtx et Conv! ; conditions de Sub/SubBox ; transformation d'effet φ_n uniquement sur son domaine de multiplicités effectives ; lois zéro-somme/zéro-produit là où les lemmes les invoquent.

**Cas manquants :** variables, lieurs et fraîcheur ; Box, App, VECI, SC ; substitution sous Sub/SubBox ; contexte partagé dans ψ ; conversions de modalité et transport de ! ; effets et budgets ; répétitions finies/infinies seulement si elles sont admises par la règle concernée. Les schémas généraux de commutation et préservation ne remplacent pas la preuve d'instance.

**Dépendances :** C-01 à C-05, thm:substitution, thm:substitution_simultanee, thm:commutation_traduction, thm:coherence_axiome et thm:coherence_usage.

**Critère de clôture :** induction sur chaque règle avec hypothèses typées et fraîcheur ; identité et conversions établies ; aucun passage de l'usage rationnel à la multiplicité d'exécution sans preuve dédiée.

### C-07 — Réduction source, Sim et adéquation de la représentation

**Classe :** obligation sémantique avec dépendances formelles distinctes.

**Objets et direction :** la réduction source → porte sur les configurations ⟨c∣μ∣τ⟩. La traduction ⟦-⟧ vers la cible et sa réduction →ₜ sont des objets de représentation. Sim doit être une simulation avant : chaque pas source correspond à un ou plusieurs pas cible, modulo la congruence structurelle précisée, et la trace cible prolonge la trace source conformément au pas.

**Hypothèses et cas manquants :** domaine des configurations typées ; invariants de mémoire μ et convention de trace τ ; clauses de traduction des opérations et du temps ; invariant de canal de temps chaîné qui préserve l'ordre des événements ; cas de beta/communication, produits/sommes, vecteurs, effets, tick, opérations délimitées, congruence structurelle et réécritures. La préservation de typage, la commutation de traduction et le confinement des canaux sont des dépendances, pas des substituts à Sim. thm:simulation est explicitement non démontré ; thm:fidelite_interprete reste conditionnel à Sim et à l'adéquation de l'interpréteur cible. Une simulation avant ne prouve ni bisimulation, ni équivalence observationnelle bidirectionnelle, ni pleine abstraction.

**Dépendances :** thm:commutation_traduction, thm:traduction_metalangage, thm:confinement_sortes, interprétation cible et PREUVE-07 ; audit C8 batch 07.

**Critère de clôture :** énoncé entièrement typé, preuve par chaque cas de réduction, invariant trace/canal établi et hypothèse exacte d'adéquation explicitée. Sinon Sim reste OPEN.

### C-08 — Mémoire abstraite, H1/H2/H3 et profil concret

**Classe :** obligations mathématiques/sémantiques et question de représentation.

**H1 :** au plus une introduction de WriteCap(r) par région r. Le théorème de sûreté spatiale l'assume ; thm:introduction_unique ambitionne de le prouver, mais le cas d'élimination de l'arène est signalé comme manquant. L'arête thm:introduction_unique → thm:surete_spatiale crée une circularité argumentative si H1 est justifiée à partir d'un résultat qui la suppose, bien que ce ne soit pas un cycle de références syntaxiques.

**H2 et H3 :** H2 porte sur la disjonction des intervalles/régions ; elle exige une définition de Range et une preuve d'élimination/disjonction. H3 porte sur l'imbrication des délimiteurs et reste distincte. Prouver H1 ne décharge ni H2 ni H3.

**Alternatives non choisies :** compléter indépendamment le cas d'élimination afin d'établir H1 ; ou conserver H1 comme hypothèse normative/de modèle et réduire/laisser ouvert le résultat d'introduction unique. Pour H2, formaliser les intervalles puis prouver disjonction et élimination ; pour H3, expliciter les règles d'imbrication. L'autrice doit ratifier toute restriction ou hypothèse. Le modèle abstrait ne prouve pas la conformité à une machine/ABI.

**Profil Π :** identifier la révision de spécification, représentation/formalisation, chaîne d'exécution, architecture et paramètres matériels, paramètres d'exécution et sources pertinentes de non-déterminisme. Séparer la sûreté abstraite, E_repro, égalité binaire et garanties ABI.

**Dépendances :** ModelesDeMemoire.lean, LEAN-DEPENDENCY-SEMANTIC-REVIEW.md, H1/H2/H3 et contrôles propres à Π.

**Critère de clôture :** H1 indépendamment prouvée ou expressément acceptée comme hypothèse avec portée indiquée ; H2 et H3 prouvées séparément ; revendications concrètes testées/prouvées sur un profil versionné.

### C-09 — Imports et dépendances formelles externes

**Classe :** dépendance formelle, à séparer des engagements normatifs K7PL.

P1a (cadre catégorique annoncé par C) reste distinct de P1b (interprétation ⟦-⟧_C et correction), qui demeure une obligation ouverte. Théorie des modes et théorie des types gradués ont un rôle normatif déclaré, mais leurs sources bibliographiques n'établissent pas automatiquement leur correspondance avec les règles K7PL. Calf/Decalf et récursion gardée sont des mécanismes externes : seules les propriétés instanciées sous les hypothèses exactes peuvent être utilisées. Les résultats de littérature ne sont ni axiomes K7PL ni théorèmes du langage par défaut.

**Critère de clôture :** pour chaque import effectivement utilisé, consigner référence/version, hypothèses, fragment couvert, mapping K7PL et propriété obtenue ; toute hypothèse empruntée demeure visible.

## 12. Décisions humaines à préserver comme ouvertes

1. **Portée normative de P3/When :** confirmer que la politique voulue fait porter la consommation de ressource par le franchissement via ψ et l'admissibilité différée. L'alternative « attente externe hors budget » exige une distinction explicite entre latence et coût d'exécution ; l'alternative « interdire When au point d'introduction si le budget est fini » modifierait la règle locale. Aucune option ne doit être appliquée implicitement.
2. **H1 et thm:introduction_unique :** choisir entre preuve indépendante via l'élimination de l'arène et acceptation explicite de H1 comme hypothèse avec réduction de portée. Les conséquences théoriques diffèrent.
3. **Morphismes des modes :** si les triplets candidats ne satisfont pas le contrat, apporter les contre-exemples et la conséquence sur les règles avant de choisir restriction, modification normative ou obligation ouverte.

## 13. Porte de sortie C — état

**NON SATISFAITE.** L'exploration architecturale du sous-système grade/exponentielle/coût est bornée, mais les obligations C-01 à C-09, la traçabilité formelle des signatures et les ratifications humaines listées ci-dessus ne sont pas closes. D–F ne doivent pas commencer avant clôture explicite de cette porte.
