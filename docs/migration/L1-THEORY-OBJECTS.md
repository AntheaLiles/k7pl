<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# PR-02 — registre des objets théoriques

**État :** IN PROGRESS  
**Périmètre :** étape C — reprise des objets théoriques  
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
| `Cost_Budget` | DÉRIVÉ / OBLIGATION | scalarisation du coût temporel vers le budget | sous budget scalaire + P3, `Cost_Budget(κ)=max(W(κ),D(κ))` est la plus petite scalarisation ; restent à définir exactement `W`, `D` et `Adm` |
| `Unr ⊑ Aff ⊑ Lin` | DÉRIVÉ | ordre de précision des usages | ne pas le confondre avec le sous-typage modal `≼` |

Point de contrôle : trois relations doivent rester distinctes : l'inclusion des intervalles modaux
`Lin ⊆ Aff ⊆ Unr`, le sous-typage modal `≼` et l'ordre de précision `⊑`. Le mode `Rel = [1..ω]`
est mathématiquement admissible dans la construction générale mais n'est pas générable par les règles
actuelles de K7PL. Cette distinction doit être conservée : admissibilité algébrique ≠ atteignabilité
syntaxique ≠ précision.

**Correction critique de C — modes et intervalles.** La définition de mode utilisée dans la littérature de référence n'est pas celle d'un intervalle de grades : elle combine une algèbre de grades, un idéal de contraction et un prédicat d'affaiblissement. Les intervalles `U_m` de K7PL ne sont donc que des domaines syntaxiques d'annotations. En particulier, `U_Aff = [0..1]` n'est pas fermé par addition et ne peut pas jouer le rôle d'une algèbre de grades. La démonstration antérieure « inclusion d'intervalles ⇒ morphisme de modes » est retirée comme trop forte. Une réalisation structurelle candidate par les quatre triplets `M_Lin`, `M_Aff`, `M_Rel`, `M_Unr` est maintenant exposée en C2/C3 ; sa correspondance avec le jugement K7PL reste à vérifier.

**Obligation supplémentaire — action graduée.** Le simple remplacement de `\mathcal{R}` par un
produit de facteurs ne suffit pas à définir `r · Δ`. La composante d'usage porte
$`\mathbb{Q}_{\geq0}\cup\{\omega\}` tandis que le budget actuel porte $`\mathbb{N}_\infty` ; une
action uniforme du semi-anneau d'usage sur le budget n'est donc pas encore disponible pour les
grades rationnels. La notation utilisée par `VAR`, `Box`, `App`, `VECI` et `SC` doit être
factorisée en une action précisément typée, ou restreinte à un sous-domaine dont la fermeture
soit démontrée. Aucune convention arithmétique implicite ne doit être introduite pour franchir
cette frontière. Cette obligation devient une dépendance explicite de la substitution et de la
loi de compatibilité de l'action graduée.
**Correction critique de C — algèbre des grades.** `\mathcal{R}` est le semi-anneau de la composante d'usage. `\mathcal{G}` est le porteur du grade complet, produit de structures potentiellement hétérogènes. Il ne doit pas être appelé « semi-anneau des grades » sans préciser quelle structure algébrique est effectivement retenue. La notation de mise à l'échelle `r · Δ` doit elle aussi être lue comme une action graduée typée, et non comme une multiplication naïve de deux éléments de `\mathcal{G}`. La séance 28 distingue désormais quatre familles : agrégation des grades, éventuelle multiplication de `\mathcal{G}`, action `Scale` et consommation budgétaire `⊖`. Aucune de leurs identifications n'est acquise.

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

**Constat de reprise.** Le jeu actuel contient bien les règles `Alw`, `Alw⁻`, `Now`, `Wait` et `When`,
mais leur statut n'est pas homogène. `Del` apparaît dans le jeu central, tandis que les autres règles
sont regroupées dans une extension de section. Surtout, `When` utilise la transformation
`ε[ω/k]` sans que le registre actuel établisse encore son domaine, sa définition ni sa correction.
La perte de borne induite par `When` doit donc rester une obligation de preuve, et non être considérée
comme une conséquence acquise de la notation.

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

Les obligations encore ouvertes sont de nature démonstrative ou sémantique : naturalité et
fonctorialité de `coerce`, compatibilité avec `w`/`c`, commutation avec `Scale_Usage`, preuve de
substitution sous ces conversions, définition exacte de `W`/`D), et décision sur la place de
l'attente environnementale de `When` dans P3.
