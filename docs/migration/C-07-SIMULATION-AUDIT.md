<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# C-07 — Audit de la simulation source → métalangage

**État épistémique :** obligation ouverte ; audit documentaire provisoire, sans ratification normative.  
**Révision de base examinée :** `de1f6bed21b4c773a58f3cd0af93867bb3e07401`, branche `main`, le 11 octobre 2026.  
**Périmètre :** adéquation entre la réduction source K7PL et la réduction du métalangage.  
**Résultat :** `Sim` est une revendication de simulation avant, mais son contrat n'est ni entièrement défini sur les configurations, ni démontré règle par règle. C-07 reste **OPEN**.

Cet audit ne modifie ni la réduction normative, ni la traduction, ni le statut des blocs d'énoncés. Il transforme les lacunes repérées en obligations vérifiables. Les termes « un pas » et « deux pas » ci-dessous décrivent ce que le texte annonce dans son esquisse, pas un calcul de réduction cible exécuté ni une preuve mécanisée.

## 1. Objets et sens exact de Sim

La sémantique opérationnelle source représente une configuration par
`⟨c ∣ μ ∣ τ⟩` : `c` est le calcul, `μ` l'état d'arène (application des régions vers leur contenu), et `τ` une trace d'effets décrite comme un mot de la quantale. La relation source `→` porte sur ce triplet. Les règles pures laissent `μ` et `τ` invariants ; une opération `operation_ε(v)` peut changer `μ` en `μ′` et ajoute `ε` à la trace ; `tick` conserve `μ` et ajoute `⟨1, δ_ℓ⟩`. Les opérations à portée disposent d'une règle d'évaluation du corps et d'une règle de retour.

Le bloc source `thm:simulation` réclame la **direction avant** suivante : chaque pas source doit être suivi d'au moins un pas cible, modulo l'équivalence structurelle cible `≡`, avec extension correspondante de la trace. Schématiquement, il énonce
`⟨c ∣ μ ∣ τ⟩ → ⟨c′ ∣ μ′ ∣ τ′⟩`
qui entraîne
`⟦c⟧ →⁺ ⟦c′⟧` modulo `≡`, avec une clause en prose concernant `τ′`.

Ce sens ne doit pas être inversé. L'énoncé ne réclame explicitement ni une réduction cible qui se réfléchit en réduction source, ni une bisimulation, ni une équivalence observationnelle bidirectionnelle, ni une pleine abstraction.

**Lacune de contrat préalable à toute induction :** la conclusion affiche seulement `⟦c⟧ →⁺ ⟦c′⟧`, alors que les configurations sources contiennent aussi `μ` et `τ`. Le texte ne présente pas, dans ce bloc, de relation typée reliant l'état d'arène `μ` à l'état cible, ni de projection/observation typée reliant les événements cible à `τ`. La phrase « la trace s'étend en conséquence » n'est pas une définition de cette relation. Le contrat doit préciser le domaine des configurations admissibles et la relation entre configuration source et configuration cible avant que « simulation » soit un énoncé mathématique complet.

La fermeture de contexte source n'est pas la congruence structurelle cible. La source donne une grammaire de contextes d'évaluation `E ::= [] ∣ let x ← E in c ∣ E v ∣ scoped_f(v,E)` et une règle de fermeture par `E`. La conclusion cible est, elle, modulo `≡`. Il faut définir l'équivalence cible utilisée, les lois qu'elle contient, et la stabilité de la simulation sous cette équivalence.

## 2. Table exhaustive des règles source affichées et des obligations de correspondance

Dans cette table, « pas cible annoncé » se réfère exclusivement à l'esquisse de `thm:simulation` dans `spec/Spec/C4/CalculDeProcessusSousJacent.lean`. Aucun de ces nombres n'a été établi ici par calcul exécutable ou démonstration Lean. « Pas supplémentaire » désigne les réductions cible au-delà du pas source mis en correspondance ; la relation `→⁺` les autorise syntaxiquement, mais la preuve doit exclure qu'elles créent des observations ou effets sans correspondance source.

| Règle source | Cas cible annoncé / nombre annoncé | `μ`, `τ` et canaux | Obligations de simulation encore ouvertes |
|---|---|---|---|
| `let x ← return v in c → c[v/x]` | Communication/coupure correspondant à l'élimination de `return`; groupe β, un pas de communication annoncé, puis égalité modulo `≡`. | `μ` et `τ` invariants côté source. Aucun événement cible observable ne doit être ajouté. | Clause exacte de traduction de `return` et `let`; relation de configuration; substitution évitant la capture; hypothèses de typage/fraîcheur de `thm:commutation_traduction`; contrôle des réductions cible résiduelles. |
| `(λx.c) v → c[v/x]` | Communication entre introduction et élimination sur canal frais; un pas annoncé, puis congruence structurelle. | Source pure : `μ`, `τ` inchangés. | Même dette de substitution, avec correspondance exacte du canal et de la substitution cible; fraîcheur, alpha-équivalence et typage ne sont pas explicités dans l'énoncé universel de commutation. |
| `force (thunk c) → c` | Élimination d'un thunk par communication/routage; le texte la regroupe aux réductions β ou aux connecteurs mais n'isole pas sa clause cible. | `μ`, `τ` invariants. | Écrire la traduction de `thunk/force` et dériver la transition cible correspondante, sans évaluer prématurément le corps au-delà du pas apparié. |
| `let () = () in c → c` | Communication sur canal linéaire suivie d'un routage; un pas cible annoncé pour l'unité. | `μ`, `τ` invariants. | Montrer la clause de l'unité et la dérivation cible; aucune preuve formelle complète de ce cas n'est fournie par la prose. |
| `let (x,y) = (v₁,v₂) in c → c[v₁/x,v₂/y]` | Communication produit et routage; regroupée avec les éliminations de produits. | `μ`, `τ` invariants. | Clause pair/projection, substitution simultanée, fraîcheur et égalité de l'image cible au terme traduit après substitution. |
| `case (inj_i v) of {j ↦ c_j} → c_i[v/x]` | Communication somme suivie d'aiguillage; un pas cible est annoncé pour les éliminations usuelles, sans dérivation par constructeur. | `μ`, `τ` invariants. | Couvrir chaque branche, l'indice choisi et la substitution de la valeur; établir que les autres branches ne créent pas de comportement observable. |
| `⟨c_j⟩_{j∈I}.i → c_i` | Sélection/offre ou aiguillage par communication, selon le mapping déclaré dans le texte général de traduction. | `μ`, `τ` invariants. | Donner la clause cible exacte de cette forme additive et prouver la sélection du même indice; ne pas inférer ce cas de la seule traduction des produits. |
| `unbox (box_r v) as x in c → c[v/x]` | Groupe β, communication et substitution; un pas annoncé. | `μ`, `τ` invariants. | Traduction dépendante du grade/modalité; montrer que l'usage de la liaison et le mode de canal sont compatibles, en plus de la commutation de substitution. |
| `open (pack(W,v)) as (α,x) in c → c[W/α,v/x]` | Groupe β, communication et substitution de type/terme; un pas annoncé. | `μ`, `τ` invariants. | Clause de paquet ouvert, substitutions simultanées et conditions de fraîcheur; la seule mention de polymorphisme de second ordre n'établit pas la simulation. |
| `unfold (fold v) → v` | Communication/routage cible pour l'élimination du repli; le texte revendique un pas pour ce groupe. | `μ`, `τ` invariants. | Donner le cas inductif exact côté cible et l'identité de la valeur après élimination; cette ligne ne prouve pas l'image opérationnelle du point fixe déductif `fix`. |
| `(Λα.c)[W] → c[W/α]` | Groupe β, instanciation de type sur communication/coupure; un pas annoncé. | `μ`, `τ` invariants. | Clause du quantificateur de second ordre et commutation de substitution de type; le texte signale que la richesse du fragment cible nécessaire aux types dépendants pragmatiques n'est pas établie. |
| `iter_V [] c → return ()` | Le croquis range le vecteur vide parmi les cas de communication/routage à un pas. | `μ`, `τ` invariants pour ce pas d'expansion source. | Fournir la clause cible du constructeur vide; vérifier qu'elle ne déclenche pas le corps `c` et n'ajoute aucun effet qui n'existe pas côté source. |
| `iter_V [v₀,…,vₙ₋₁] c → let _ ← c[v₀/x] in iter_V [v₁,…,vₙ₋₁] c` (`n>0`) | Le croquis annonce deux pas cible pour dérouler une itération non vide. | Le pas d'expansion source lui-même laisse `μ` et `τ` inchangés; les réductions ultérieures du corps, elles, peuvent les changer. | Séparer les pas administratifs de déroulement des pas effectifs du corps. Un `→⁺` arbitraire pourrait exécuter le corps cible et produire un effet qui n'est pas dans le pas source courant. La preuve doit montrer que tout pas cible supplémentaire est silencieux/administratif ou correspond à un pas source ultérieur. |
| `operation_ε(v)` donne `return w`, avec `(w,μ′)=[[operation]](v,μ)` et `τ′=τ·ε` | Une communication sur le canal distingué de l'effet est annoncée; un pas lorsque le canal est correctement chaîné. | L'état source change de `μ` en `μ′`; la trace ajoute précisément `ε`. Le canal d'effet et son éventuel canal temporel doivent conserver leur relation. | Définir la clause cible pour chaque opération et la relation entre `μ′` et l'état cible; définir comment l'émission devient l'événement de trace source; prouver le confinement des canaux et l'absence d'effets supplémentaires. La seule préservation du typage ne suffit pas. |
| `tick` donne `return ()` et `τ′=τ·⟨1,δ_ℓ⟩` | Une communication sur le canal de temps est annoncée, à condition que le canal soit consommé puis retransmis. | `μ` inchangé; la trace ajoute un événement temporel de niveau `ℓ`. | Définir la clause et la projection de trace; établir l'invariant du jeton temporel chaîné. Une émission sur un nom cible commun, sans discipline de chaînage, ne prouve pas l'ordre de la trace source. |
| Pas du corps sous `scoped_f(v,c)`, si `c → c′` | La cible doit simuler le pas de `c` sous le gestionnaire/contexte, avec un nombre de pas compatible avec la simulation du sous-calcul. | Reprendre les changements d'état et de trace du sous-pas source; la clôture ne doit ni perdre ni dupliquer ses événements. | Formaliser la traduction d'un gestionnaire à portée et la stabilité de la simulation sous ce contexte. L'analogie « traité comme un let » reste une esquisse, pas une clause de traduction démontrée. |
| `scoped_f(v, return w) → return [[operation]](v,w)` | Fermeture du gestionnaire à portée; le texte ne donne pas un nombre cible isolé. | La règle source écrite ne modifie ni `μ` ni `τ` dans cette étape de retour; elle n'efface pas pour autant la trace déjà produite par le corps. | Définir la réception/interception sur le canal d'effet et prouver qu'elle préserve exactement les effets qui figurent dans la trace source. Le comportement du gestionnaire ne se déduit pas de la seule traduction de `Op`. |
| Fermeture par contexte `E` : un pas de `c` induit un pas de `E[c]` | Le croquis affirme que `E` se traduit en contexte de séquentialisation et que `→⁺` y est stable. | L'état et la trace suivent le pas du sous-calcul. Les positions évaluables sont fixées par la grammaire de contextes à appel par valeur. | Preuve de stabilité par induction sur `E`, correspondance des contextes et compatibilité de la relation target avec `≡`; aucun pas sous paire, injection ou thunk n'est permis par le texte source actuel. |
| Dépliage du point fixe déductif `fix` | Le texte dit qu'il se déplie sur son argument et évoque ailleurs une image par ré-invocation finie `h) fois (`thm:image_fix`). | Aucun changement de `μ` ou de `τ` n'est assigné à un pas opérationnel car le pas source de `fix` n'est pas écrit dans les équations de réduction affichées. | **Pas de règle de réduction source explicitement donnée à apparier** dans la relation affichée. L'image par itération finie est une esquisse conditionnelle, pas un cas de simulation acquis. Il faut d'abord identifier la règle autorisée et son domaine. |
| Réductions concurrentes : composition parallèle, apparition/création d'acteur, communication/émission/réception, jonction atomique, création/libération/déplacement de ressources (`Par`, `Spawn`, `New`, `Send`, `Guard`, `Free`, `At`, `Move`, `Try`, etc., selon la grammaire et les chapitres d'architecture) | La prose cible mentionne composition parallèle avec restriction de noms privés, acteur par point fixe gardé/réception et motif de jonction multi-entrée `J ▷ P). Le système de sortes donne une clause multi-réception. | L'architecture concurrente parle d'arène partagée, transitions d'acteurs et d'une trace par fibrille; le contrat de `Sim` ne définit pas l'état cible corrélé à l'arène ni la relation entre traces de fibrilles. | Ces constructeurs ne disposent pas de clauses de réduction dans la relation `→) affichée par la sémantique opérationnelle séquentielle. Une clause de typage, un constructeur cible ou un texte d'architecture ne remplace pas une règle source de petit pas. Il faut préciser si le domaine de `Sim` est seulement séquentiel ou inclut la couche concurrente; ne pas choisir cette restriction à la place de l'autrice. |

### Lecture de la table

Cette couverture reprend toutes les règles de petit pas effectivement affichées dans les familles pures/effectueuses et la fermeture par contexte, plus les cas explicitement évoqués mais non définis opérationnellement. Les constructs de concurrence listés dans la dernière ligne ne sont pas présentés comme des règles source déjà écrites : ils constituent précisément le périmètre manquant si `Sim` prétend couvrir la couche 2 entière.

L'esquisse n'est pas encore un contrat de « simulation avant » pleinement utilisable :
- La source est une configuration `⟨c,μ,τ⟩`, mais la conclusion compare seulement les traductions des termes `c) et `c′`.
- La relation entre état d'arène source et état cible est absente.
- La projection de la trace cible vers la trace source est absente.
- `→⁺` permet plus d'un pas cible, sans qualifier les pas additionnels (administratifs/silencieux ou observables/effectueux).
- L'égalité structurelle `≡` n'est pas définie comme partie intégrante du théorème de simulation dans ce bloc.
- La préservation du typage (`thm:traduction_metalangage`), la commutation traduction/substitution (`thm:commutation_traduction`) et le confinement des sortes (`thm:confinement_sortes`) sont des obligations voisines, pas une preuve de réduction simulée.

## 3. Contre-exemples minimaux et tests discriminants

| Cas | Comportement source attendu | Comportement/cas cible à tester | Ce que le cas établit et ce qu'il n'établit pas |
|---|---|---|---|
| Deux `tick` séquentiels : `let x ← tick in tick` | Deux pas effectifs et deux événements `⟨1,δ_ℓ⟩`, dans l'ordre de la trace source. | Sans jeton temporel transmis de la première communication à la seconde, les émissions parallèles sur le canal de temps ne portent pas à elles seules la relation d'ordre source. | Contre-exemple conditionnel à une traduction sans chaînage; le texte le mentionne déjà. Ce n'est ni une exécution du runtime K7PL ni une réfutation de toutes les traductions possibles. |
| Un `tick` seul | `μ` inchangé, un événement temporel ajouté. | Une communication sur le canal `temps`, plus projection de cette communication vers la trace. | Test discriminant de la clause temporelle; aucune clause précise et mécanisée n'a été trouvée au périmètre contrôlé. |
| `operation_ε(v)` qui change `μ` | Résultat `w`, nouvel état `μ′`, trace `τ·ε`. | Un appel/échange sur canal d'effet et état cible corrélé. | Le document ne fournit pas une opération concrète et sa traduction qui permettrait un contre-exemple exécutable. L'absence de relation de mémoire cible suffit à empêcher la formulation complète de l'obligation, mais ne prouve pas qu'une traduction future échoue. |
| Opération à portée avec corps terminant par `return w` | La règle de retour n'ajoute aucun événement à elle seule; les événements produits par le corps restent dans la trace, sauf autre règle explicite. | Le processus gestionnaire doit produire exactement l'observation correspondant à cette trace, sans duplication/effacement injustifié. | Distingue le traitement de l'opération de la journalisation de l'événement. La prose « traité comme un let » n'établit pas leur cohérence. |
| Deux acteurs concurrents produisant chacun un `tick` | Le texte d'architecture mentionne une trace par fibrille, alors que la configuration séquentielle présente `τ` comme un mot. | Un canal de temps partagé peut imposer une sérialisation globale; un canal par fibrille conserve seulement l'ordre local; un modèle à événements partiellement ordonnés conserverait les seules dépendances justifiées. | Ce cas met en évidence une décision sémantique non résolue, pas un contre-exemple décisif à une option ratifiée : l'ordre global attendu entre fibrilles n'est pas fixé par les clauses actuellement vérifiées. |

Ces cas peuvent devenir des tests différentiels seulement après définition d'une relation exploitable entre configurations source et cible et d'une observation commune. Aucun test actuel ne doit être déclaré test de C-07 en l'absence de ces objets.

## 4. Ce qui est formalisé, décrit, testé ou spécifique à Π

| Niveau de preuve | Éléments observés sur la révision de base | Conclusion autorisée |
|---|---|---|
| Sémantique source écrite | `spec/Spec/C4/SemantiqueOperationnelle.lean` contient les équations source et des blocs d'énoncés/étapes de preuve en prose. | Les clauses source décrites ci-dessus sont auditables comme contenu de spécification. Les notes de preuve restent des esquisses. |
| Traduction et élaboration | `thm:traduction_metalangage`, `thm:commutation_traduction`, `thm:simulation`, `thm:fidelite_interprete` apparaissent dans des fichiers Verso avec `::::theorem/lemma`, `:::statement` et `:::proofsketch`; leur état reste `under-review`. | Les obligations sont formulées et suivies dans la documentation. Ce ne sont pas, par leur seule présence dans un fichier `.lean`, des déclarations Lean vérifiées par le noyau. |
| Formalisation machine de K7PL | `src/K7pl/Semantics.lean` formalise un petit LTS de compteur à deux actions (`incr`, `reset`) et un théorème sur deux incréments. Aucun objet `Sim` ou relation de réduction sur les configurations K7PL `⟨c,μ,τ⟩` n'a été identifié dans le code Lean inspecté. | Ce module ne formalise pas C-07 et ne peut pas être invoqué comme preuve de simulation K7PL. |
| Tests exécutables existants | `tests/SemanticsTest.lean` teste les résultats du compteur (incrément/réinitialisation et deux incréments); il n'y a pas de test observé de réduction K7PL, traces, opérations, canal de temps ou `Π`. | Ces tests vérifient le jouet LTS, pas le contrat de simulation ni le runtime de la spécification. L'audit n'a pas exécuté de nouvelle suite de tests pour cette note. |
| Adéquation de l'interpréteur | `thm:fidelite_interprete` est conditionnel à la préservation du typage, à l'adéquation de l'interprétation cible et à `Sim`; le texte cible lui-même est désigné comme emprunté sans preuve reproduite ici. | La fidélité demeure conditionnelle. La simulation avant n'implique pas à elle seule le sens inverse, la bisimulation, l'équivalence observationnelle bidirectionnelle ou la pleine abstraction. |

**Incohérence textuelle à résoudre dans la traduction, sans la corriger ici :** le croquis de `thm:traduction_metalangage` indique que la composante `𝓔` n'est pas traduite (« elle n'a pas de contrepartie dans le calcul »), alors que la prose ultérieure de ce même fichier et `thm:fidelite_interprete` affirment qu'un effet devient une émission sur un canal distingué et que `tick` émet sur le canal de temps. Il faut distinguer explicitement l'effacement éventuel des annotations/grades d'effet de la représentation des occurrences d'effet. Sans clarification de cette distinction et de sa clause de traduction, on ne peut pas utiliser la prose ultérieure comme preuve d'une traduction complète.
| Profil concret de représentation `Π) | `thm:isomorphisme_memoire` dans `EchelleDeLActeur.lean` est une proposition de représentation `under-review`, bornée aux types primitifs de largeur fixe et à des versions déclarées de Arrow/Cap'n Proto/MLIR; les hypothèses de format y sont explicites. | Une conformité binaire relative à `Π` est une vérification distincte. Aucun résultat de disposition binaire, build, test ou identité d'artefact ne démontre la simulation mathématique générale. |

La révision de base avait les exécutions GitHub suivantes : le workflow CI `38155902581` et Scorecard `38155902312`, tous deux terminés avec succès sur `de1f6bed21b4c773a58f3cd0af93867bb3e07401`. Cela n'est pas une preuve de C-07 : la note présente des lacunes sémantiques et le workflow CI peut sélectionner des jobs selon les chemins modifiés. Les validations de cette PR documentaire devront être rapportées séparément, y compris tout job omis par le classificateur d'impact.

Sources principales (toutes relues à la révision de base) :
- [Réduction source — SemantiqueOperationnelle.lean](https://github.com/AntheaLiles/k7pl/blob/de1f6bed21b4c773a58f3cd0af93867bb3e07401/spec/Spec/C4/SemantiqueOperationnelle.lean#L30-L125)
- [Traduction, thm:simulation et fidélité](https://github.com/AntheaLiles/k7pl/blob/de1f6bed21b4c773a58f3cd0af93867bb3e07401/spec/Spec/C4/CalculDeProcessusSousJacent.lean#L151-L384)
- [Système de sortes cible](https://github.com/AntheaLiles/k7pl/blob/de1f6bed21b4c773a58f3cd0af93867bb3e07401/spec/Spec/C4/LeSystemeDeSortesDuMetalangage.lean#L150-L245)
- [Système multi-acteurs et contraintes de représentation](https://github.com/AntheaLiles/k7pl/blob/de1f6bed21b4c773a58f3cd0af93867bb3e07401/spec/Spec/C4/EchelleDuSysteme.lean#L160-L245)
- [Audit sémantique transversal déjà consigné — batch 07](../tracking/LEAN-SEMANTIC-AUDIT-BATCH-07.md)
- [Implémentation Lean du compteur](https://github.com/AntheaLiles/k7pl/blob/de1f6bed21b4c773a58f3cd0af93867bb3e07401/src/K7pl/Semantics.lean) et [ses tests](https://github.com/AntheaLiles/k7pl/blob/de1f6bed21b4c773a58f3cd0af93867bb3e07401/tests/SemanticsTest.lean)

## 5. Décision de sémantique à ratifier avant de compléter Sim

Il faut préciser le statut de l'ordre temporel sous concurrence. Les sources consultées évoquent à la fois une trace source « mot de la quantale », une trace par fibrille sous concurrence et une traduction qui « enfile » un canal de temps. Ces trois formulations ne déterminent pas la même relation d'ordre inter-fibrilles.

Options à soumettre à l'autrice, sans en choisir une dans cet audit :

1. **Ordre local par fibrille.** Chaque fibrille possède son propre canal/ordre temporel; la simulation conserve cet ordre local et ne revendique pas d'ordre total entre événements concurrents. Cela demande un énoncé de trace indexée par fibrille et une observation cible qui respecte cet index.
2. **Ordre global linéarisé.** Un canal temporel partagé impose un ordre global. Il faut alors définir quelle règle concurrente acquiert le jeton, comment l'arbitrage est choisi, et pourquoi cette linéarisation est bien la sémantique source — plutôt qu'un ordre ajouté par la traduction.
3. **Ordre partiel d'événements.** Les traces représentent les dépendances/happens-before, sans imposer d'ordre entre événements indépendants. Il faut préciser l'objet mathématique de trace, ses opérations de composition et les conditions de préservation par la cible; cela pourrait requérir une modification normative du modèle de trace.

Le présent audit ne modifie pas `τ`, les règles concurrentes ni les clauses de traduction pour trancher ce point. **Une ratification explicite est nécessaire** avant de prouver l'invariant de canal, ou avant de restreindre normativement le domaine de `Sim` au seul fragment séquentiel. Si l'autrice estime que ces trois options ne couvrent pas l'intention, il faut spécifier cette intention plutôt que déduire une politique de temps de la preuve esquissée.

## 6. Conditions de sortie de C-07

C-07 ne pourra être clos qu'après :
1. définition typée du domaine de `Sim` et de la relation source/configuration cible, notamment pour mémoire et traces;
2. décision documentée sur l'ordre temporel concurrent et sur le périmètre séquentiel/concurrent visé;
3. clauses explicites de traduction pour chaque règle source couverte, et règles source pour chaque construction incluse au domaine;
4. preuve de commutation substitution/traduction avec ses conditions de typage, fraîcheur et alpha-équivalence;
5. induction de simulation règle par règle; pas cible additionnels caractérisés (administratifs/silencieux ou observables corrélés), congruence cible définie et invariant de trace/canal prouvé;
6. énoncé distinct de la fidélité de l'interpréteur, en identifiant l'adéquation cible et les observations utilisées;
7. éventuelle conformité à un profil `Π` évaluée indépendamment, sans l'utiliser comme preuve de simulation;
8. evidence Lean et tests nommés exactement selon ce qu'ils vérifient.

**Conclusion : C-07 reste OPEN.** Cet audit spécifie des lacunes, un contrat de preuve attendu et des contre-exemples discriminants; il n'établit pas `Sim`, ne prouve pas que toutes les traductions possibles sont incorrectes, ne promeut aucun énoncé et n'autorise pas de modification normative en aval.
