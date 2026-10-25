<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# R5 — Permissions mémoire, emprunt, aliasing et logique de séparation

**Statut : étude documentaire et formelle non normative.** Base examinée : `main` à `ed03d4a86543eea0addf551747a8a81a43843127` (2026-10-23). Ce rapport ne change aucune règle normative. Il n'interprète ni un bloc Verso `proofsketch`, ni la compilation d'un fichier Lean, comme une preuve de sûreté mémoire de bout en bout.

## 1. Résultat exécutif

K7PL possède un modèle Lean volontairement petit pour deux idées : compter les jetons d'arène et les capacités d'écriture, puis raisonner sur des intervalles naturels. Ces deux noyaux sont utiles, mais leur périmètre est expressément limité dans le code. `K7pl.MemoryCapability` ne formalise pas les règles source `Arena`, `WriteCap`, `alloc_range` ou `Par`; `K7pl.MemoryRange` ne relie pas ses intervalles aux identités concrètes de régions et de capacités. Leurs théorèmes ne suffisent donc pas à établir que les accès à la mémoire réelle respectent le modèle de permissions.

C4 énonce `thm:surete_spatiale` sous trois hypothèses distinctes :
- **H1 — introduction unique** : une capacité d'écriture donnée ne peut pas être créée plusieurs fois pour la même région ;
- **H2 — portée et identité des régions** : les intervalles disjoints représentent des régions distinctes selon la sémantique choisie ;
- **H3 — discipline des délimiteurs** : une valeur cartésienne ne peut pas capturer indirectement une capacité linéaire.

L'énoncé est marqué `under-review`/`proofsketch`. La note de C4 précise que H1 demeure ouverte parce que le cas d'élimination de l'arène n'est pas écrit dans l'esquisse. H2 exige un lien formel entre intervalles, segments et régions ; H3 demande de démontrer la conséquence mémoire de la discipline d'imbrication. Les trois obligations ne se remplacent pas l'une l'autre.

**Conclusion principale :** un décompte de capacités ne modélise pas encore l'emprunt. Pour prendre en charge un système mémoire comparable à Rust, il faut formaliser la provenance des droits, leur transfert temporaire, les réemprunts, la fin des durées de vie, les permissions de lecture partagée, les écritures exclusives, la destruction et les frontières non sûres. Pour les structures concurrentes, il faut de plus relier ces droits à un modèle mémoire et aux primitives atomiques utilisées par le code produit.

Les décisions de conception devraient garder la sûreté mémoire comme propriété d'un assemblage de preuves : noyau du langage, bibliothèques, compilation, runtime et matériel. Il ne s'agit pas de choisir immédiatement une logique externe complète ni d'ajouter une nouvelle coordonnée au grade. Le premier livrable utile est une algèbre des permissions minimale dans Lean, puis sa correspondance avec les règles existantes.

## 2. Périmètre et éléments examinés

Sources du dépôt à la révision de base :

- [C4 — modèles mémoire, sûreté spatiale et H1/H2/H3](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/spec/Spec/C4/ModelesDeMemoire.lean)
- [C3 — règles de typage, arène, `Slice` et parallélisme](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/spec/Spec/C3/ReglesDeTypage.lean)
- [C4 — arènes, offsets et capacités de région](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/spec/Spec/C4/EchelleDeLActeur.lean)
- [Modèle Lean de comptage des capacités](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/src/K7pl/MemoryCapability.lean)
- [Modèle Lean d'intervalles](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/src/K7pl/MemoryRange.lean)
- [Audit C-08 de la sûreté mémoire](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/docs/migration/L1-C08-MEMORY-SAFETY-AUDIT-2026-10-11.md)
- [C5 — délimiteurs et frontières de fragments](https://github.com/AntheaLiles/k7pl/blob/ed03d4a86543eea0addf551747a8a81a43843127/spec/Spec/C5/SExpressionsUniverselles.lean)

L'analyse porte sur les blocs documentaires et les deux modules Lean ci-dessus ; elle ne constitue pas une compilation nouvelle ni un audit exhaustif de chaque primitive, du backend ou du runtime. Les tests présentés plus loin sont des scénarios proposés, non des tests déjà exécutés.

## 3. Ce que les modèles Lean établissent réellement

### 3.1 Comptage abstrait des capacités

`MemoryCapability.lean` définit :

```lean
abbrev State (Region : Type u) := Region → ℕ × ℕ
def Unique (s : State Region) : Prop :=
  ∀ r, (s r).1 + (s r).2 ≤ 1
```

Pour chaque région, le premier compteur représente les jetons d'arène disponibles et le second les capacités d'écriture vivantes. `allocate_preserves_unique` montre que l'opération de ce modèle conserve `Unique`, sous l'hypothèse que l'état initial est unique et qu'un jeton d'arène est disponible. `parallel` additionne les compteurs point par point. `no_double_writer` en déduit qu'un état déjà reconnu `Unique` ne peut pas contenir deux comptes positifs de rédacteurs pour une région.

Ces résultats sont cohérents dans le modèle arithmétique. Leur limite est également écrite dans son commentaire : il ne formalise pas les transitions source de `Arena`, `WriteCap`, `alloc_range` ou `Par`. En particulier, `no_double_writer` reçoit comme prémisse `Unique (parallel left right)`; il ne démontre pas que la composition parallèle préserve cet invariant à partir de deux états locaux arbitraires. Ce lemme est une conséquence utile d'un invariant, pas la preuve de fermeture de cet invariant sous toutes les opérations du langage.

### 3.2 Arithmétique des intervalles

`MemoryRange.lean` définit une plage fermée d'entiers naturels, avec `first ≤ last`, ainsi que la relation :

```lean
def Disjoint (r s : Range) : Prop :=
  r.last < s.first ∨ s.last < r.first
```

Son théorème `disjoint_ne` prouve que deux plages ainsi séparées ne sont pas la même valeur d'intervalle. Il ne prouve pas :
- que les régions réelles sont identifiées de façon injective par ces valeurs ;
- que l'adresse calculée pour chaque accès reste dans les bornes de la région ;
- que l'allocation source correspond à l'intervalle de ce modèle ;
- que l'addition, la découpe et la recomposition de plages correspondent à celles des capacités ;
- que des pointeurs, offsets ou références ne peuvent pas contourner l'identité de région.

Le commentaire du fichier le précise : la liaison entre plages, identités de région et règles de capacité K7PL reste distincte. Ce lien est une obligation de sémantique et de raffinement, non une conséquence du théorème arithmétique.

### 3.3 Le théorème documentaire de sûreté spatiale

`thm:surete_spatiale` se présente comme une impossibilité de mutation concurrente. Sa forme est conditionnelle à H1, H2 et H3. Le texte C4 reconnaît que la linéarité empêche de dupliquer une capacité détenue, mais qu'elle n'empêche pas, à elle seule, d'introduire deux capacités différentes sur la même région. Le cas source de l'élimination de l'arène est précisément le cas racine qui doit justifier l'unicité d'introduction.

C3 indique également que la règle `Slice` consomme une capacité existante et produit deux capacités sur des segments disjoints ; elle n'écrit pas le cas source d'où vient la capacité entière. C4 et l'audit C-08 signalent que le cas d'élimination de l'arène reste à établir. Il serait donc incorrect de considérer H1 comme acquise au seul motif que la règle de découpe est linéaire.

### 3.4 Le point de passage H3

H3 affirme qu'une valeur duplicable de couche plus permissive ne capture pas une capacité linéaire. La source relie cela au sens d'imbrication des délimiteurs de C5 et à la séparation entre modes. Pour en faire un théorème mémoire, il faut démontrer que les règles d'introduction, fermeture et passage de valeur préservent la restriction, y compris sous substitution, champs, closures, paramètres polymorphes et stockage dans des valeurs persistantes. Le rejet lexical ou syntaxique d'une forme ne prouve pas seul qu'aucune autre construction typée ne peut transporter la même autorité.

H3 ne peut pas remplacer H1 : même si aucune valeur cartésienne ne capture une capacité déjà donnée, la sémantique d'introduction pourrait encore produire deux capacités distinctes pour la même région. H2 est, elle aussi, indépendante : deux plages naturellement disjointes n'établissent pas que deux désignations de région abstraites sont réellement différentes.

## 4. Capacités, propriété, emprunt et permissions fractionnaires

Les termes se recouvrent partiellement mais ne désignent pas le même objet.

| Mécanisme | Contrat typique | Question que K7PL doit formaliser |
|---|---|---|
| Propriété exclusive | Un détenteur a l'autorité d'écrire ou de détruire la ressource | Quelle règle crée cette autorité, et comment en exclut-elle les duplicatas ? |
| Emprunt partagé | Plusieurs lecteurs peuvent consulter une ressource pendant une durée bornée ; aucune écriture incompatible n'est permise | Comment sont suspendus les droits d'écriture, et comment se terminent les emprunts ? |
| Emprunt mutable | Un emprunteur reçoit temporairement une autorité d'écriture exclusive | Comment les alias sont-ils interdits et comment la capacité revient-elle au propriétaire ? |
| Permission fractionnaire | Une ressource logique est partagée en fractions compatibles ; les fractions peuvent représenter des droits de lecture et sont recomposées selon une algèbre précise | Quelle fraction autorise la lecture, quelle fraction autorise l'écriture, et quelles combinaisons sont valides ? |
| Capacité logicielle | Possession d'un objet de référence confère un ensemble défini d'opérations | Qui protège ce mécanisme contre un code non typé, du code machine ou un périphérique ? |
| Permission atomique | Un accès respecte un protocole mémoire explicitement autorisé | Quelle sémantique garantit l'ordre et l'absence de course au niveau machine ? |

La règle « un jeton par région » suffit à modéliser une propriété exclusive très simple. Elle ne suffit pas à représenter la lecture partagée : soit chaque lecteur reçoit une capacité duplicable de lecture distincte d'une capacité linéaire d'écriture, soit le modèle comptabilise des fractions dont les combinaisons sont définies. Ces deux conceptions sont possibles, mais elles doivent être arrêtées explicitement.

Les permissions fractionnaires ne signifient pas que toute opération se partage proportionnellement. Un modèle classique donne un droit de lecture à toute fraction positive et réserve l'écriture à une permission pleine ; une autre politique peut employer des fractions pour d'autres invariants. Les règles précises font partie de la définition du modèle, elles ne doivent pas être extrapolées d'une simple paire de compteurs naturels.

L'emprunt ajoute une dimension temporelle : la permission est transférée ou transformée pendant une portée puis doit être récupérée ou terminée selon une règle. Il faut donc modéliser non seulement « combien de droits existent », mais aussi leur provenance, leur relation de parenté, le détenteur courant, l'état suspendu du parent et la condition permettant de mettre fin à la durée de vie. Une permission fractionnaire seule ne fournit pas automatiquement le protocole des réemprunts.

## 5. Alias, provenance, offsets et réutilisation des régions

C4 décrit des offsets relatifs teintés par une capacité de région, ainsi que des références d'entité composées d'un index et d'une génération. Ce sont des idées d'architecture. Pour en faire une garantie formelle, il faut relier chaque assertion à un modèle d'adresse et d'accès.

Les obligations minimales sont :

- **Provenance :** chaque offset ou référence est lié à la région qui l'a produit ; un offset d'une région ne peut pas indexer une région différente.
- **Bornes :** calculer un offset, former une sous-plage, convertir une longueur et accéder à un élément reste dans la plage autorisée, sans débordement arithmétique.
- **Identité :** deux allocations distinctes ne partagent pas la même identité logique vivante ; les plages vides et les tailles nulles ont une convention explicite.
- **Génération :** à la destruction et au recyclage d'un index, les anciennes références deviennent invalides ; la génération n'est pas confondue avec un identifiant absolu de mémoire.
- **Durée de vie :** aucune référence ne survit à la région, à l'arène ou au segment dont elle dépend.
- **Recomposition :** des segments découpés peuvent être recomposés seulement après restitution des capacités et si leur union et leurs identités respectent le contrat.
- **Déplacement :** la mobilité de l'arène préserve les références par offsets seulement si la base, la disposition et la sémantique du modèle mémoire sont elles-mêmes conformes.

Un compteur de génération ne suffit pas sans contrat sur sa largeur, son débordement et l'identité des allocations réutilisées. De même, une plage numérique bien formée ne suffit pas sans preuve que toutes les opérations de pointeur conservent la provenance et les limites.

## 6. Composition concurrente et logique de séparation

Une logique de séparation formalise l'idée que deux composants raisonnent sur des portions compatibles de l'état, puis compose leurs preuves. Mais l'assertion logique de disjonction doit être liée à la vraie sémantique de mémoire. En présence de mémoire partagée, permissions fractionnaires, invariants partagés, protocoles atomiques ou barrières, la simple addition de deux contextes n'est pas un substitut à l'algèbre de ressources ni au modèle de concurrence.

La recherche de R5 devrait établir au minimum :

1. Une structure de ressources (par exemple une algèbre partielle de composition) qui définit quand deux permissions peuvent coexister et ce que signifie leur composition.
2. Une interprétation des assertions de possession dans les états de mémoire concrets.
3. Une règle de lecture et une règle d'écriture qui consomment ou préservent les permissions attendues.
4. Un principe de cadre : une opération sur une région conserve les faits concernant les régions sans rapport avec elle.
5. Une règle de composition parallèle qui exige des ressources compatibles et préserve les invariants.
6. Un traitement distinct de l'accès atomique, dont la correction dépend d'un ordre mémoire précis.
7. Des obligations de raffinement du code produit pour les allocations, accès, atomiques, clôtures, barrières et libérations.

L'idée de logique de séparation ne nécessite pas que chaque règle source soit écrite comme une assertion textuelle isolée. En revanche, il faut une preuve que les règles du langage induisent l'interprétation de ressources choisie. Une formalisation par simple nommage des modules ou théorèmes ne fournit pas cette correspondance.

## 7. FFI, bibliothèques non sûres et frontières de confiance

R1 montre que la propriété de type ne limite pas à elle seule un composant natif capable de contourner l'interface. R5 doit lui donner un contrat mémoire : ce qu'un appel reçoit, ce qu'il peut lire ou muter, ce qui est emprunté ou transféré, ce qu'il doit restituer, et ce qui reste valide au retour.

Chaque frontière FFI devrait préciser :

- la disposition mémoire, l'alignement, la taille et la représentation des valeurs échangées ;
- les permissions associées aux buffers, pointeurs, handles et callbacks ;
- si l'appel peut conserver un pointeur après son retour, effectuer un accès asynchrone ou rappeler le programme ;
- quelles opérations sont autorisées en cas d'exception, timeout, annulation ou crash ;
- si le code natif peut modifier la région, dupliquer un alias, retenir une ressource ou conserver un accès après révocation ;
- quelle précondition et quelle postcondition sont vérifiées ou assumées ;
- quelle partie du TCB est ajoutée lorsque la preuve de l'implémentation native est absente.

Il faut distinguer deux résultats : une preuve que tout code K7PL sûr respecte le contrat de l'interface, et une preuve que chaque implémentation FFI respecte elle-même ce contrat. Le premier ne fournit pas le second.

Les bibliothèques non sûres peuvent être traitées par un contrat de module prouvé : chaque implémentation établit une obligation de raffinement avec un invariant, et les clients n'ont accès qu'à l'interface sûre. C'est la leçon centrale de RustBelt. Cela ne signifie pas que K7PL doit adopter le modèle mémoire complet de Rust, mais qu'une API sûre dont l'implémentation manipule des pointeurs doit porter une preuve reliant l'implémentation à l'abstraction visible.

## 8. Modèle mémoire faible, atomiques et structures concurrentes

C4 évoque une file SPSC, des anneaux verrou-libres, des barrières acquisition-libération et une hypothèse d'équité du système mémoire. Il faut conserver séparément trois questions :

- **Sûreté des accès :** aucun accès ordinaire concurrent incompatible n'est permis par le contrat.
- **Ordre mémoire :** les publications, consommations et synchronisations ont l'effet prévu dans le modèle mémoire ciblé.
- **Progrès :** un consommateur finit par observer une publication selon les hypothèses de scheduler et de propagation mémoire.

Une preuve de permissions contre les écritures concurrentes n'établit pas un ordre mémoire correct. Inversement, un couple de barrières ne donne pas à lui seul une preuve de propriété ou une absence de course. Le code compilé doit correspondre au modèle utilisé dans la preuve, y compris les ordres des atomiques, les instructions de synchronisation et les hypothèses sur la plateforme.

Les travaux `RustBelt meets relaxed memory` montrent pourquoi cette distinction est substantielle : une preuve initiale sous cohérence séquentielle n'établit pas le même résultat pour les opérations à mémoire relâchée. Pour K7PL, toute structure concurrente qui se fonde sur acquire/release doit nommer le modèle mémoire, les règles qui portent l'ordre et le contrat reliant ces règles au binaire.

## 9. Comparaison des cadres existants

### RustBelt

RustBelt fournit une méthode d'assurance pour un sous-ensemble réaliste de Rust et des bibliothèques internes qui utilisent des mécanismes non sûrs. Les bibliothèques sont acceptées quand leurs implémentations satisfont des conditions de preuve qui rétablissent l'interface sûre. Sa logique de durées de vie permet de raisonner sur le transfert de propriété pendant un emprunt et sa restauration après la portée.

**Apport à K7PL :** traiter les bibliothèques mémoire de bas niveau comme des modules dont le contrat de capacité doit être prouvé, plutôt que supposer que le typage des clients suffit.

**Limite de transposition :** RustBelt couvre un langage, une logique et un ensemble de bibliothèques déterminés. Sa preuve ne démontre pas la sûreté du système K7PL et ne dispense pas K7PL de définir sa propre sémantique des régions et modes.

### Iris

Iris est un cadre de logique de séparation concurrente dont les assertions et les règles sont définies dans une logique plus générale. Il soutient le raisonnement sur l'état partagé, les invariants, les ressources fantômes et les protocoles de synchronisation.

**Apport à K7PL :** il constitue une source de modèles pour construire une interprétation des permissions et des règles de composition concurrente, notamment pour les bibliothèques qui utilisent des atomiques.

**Limite de transposition :** employer Iris dans une preuve auxiliaire ne relie pas automatiquement les règles de K7PL à cette preuve. K7PL s'appuie aujourd'hui sur Lean ; un changement d'assistant ou l'introduction d'une seconde chaîne de preuve augmenterait le TCB et le coût de maintenance. Il faut d'abord évaluer si une algèbre de ressources Lean plus petite satisfait le besoin.

### Permissions fractionnaires

Les permissions fractionnaires fournissent un mécanisme pour partager des droits de lecture entre plusieurs composants et réserver les écritures au détenteur du droit exclusif, selon les règles choisies. Leur composition et leur fractionnement sont étudiés dans la littérature sur la séparation.

**Apport à K7PL :** séparer explicitement un droit de lecture duplicable d'un droit d'écriture exclusif ; définir un opérateur de partage dont les lois sont démontrées.

**Limite :** un nombre fractionnaire en lui-même ne définit ni provenance, ni portée d'emprunt, ni sémantique d'adresse, ni ordre mémoire. Les fractions doivent être rattachées à un modèle d'accès complet.

### RefinedRust et Tree Borrows

RefinedRust construit une discipline de types de raffinement dont la correction est prouvée dans Coq à l'aide d'Iris, y compris pour certains composants qui emploient des opérations non sûres. Tree Borrows étudie un modèle opérationnel d'aliasing visant à concilier règles d'accès par pointeurs et optimisations du compilateur ; ses auteurs fournissent une formalisation Rocq et évaluent le modèle sur un corpus important de bibliothèques Rust.

**Apport à K7PL :** ne pas réduire l'aliasing à l'identité d'une capacité. Il faut définir les accès par pointeurs, leurs relations de provenance et la façon dont le modèle justifie les optimisations du compilateur.

**Limite :** ces travaux sont attachés au modèle et au langage Rust. Ils servent de méthodes comparatives, pas de théorèmes applicables directement à K7PL.

## 10. Modèle minimal recommandé pour Lean

Il est préférable de commencer par des objets dont les invariants se composent, puis d'ajouter les durées de vie et l'exécution concrète.

### 10.1 Ressources

Définir un identifiant de région, une plage et une permission. Une première variante peut distinguer :

- `Read(q)` pour une fraction positive bornée par la permission totale ;
- `Write` pour le droit exclusif d'écrire ;
- `Atomic(protocol)` pour un droit de participer à un protocole atomique spécifié ;
- `ArenaToken` pour l'autorité racine nécessaire à l'introduction d'une région.

La forme exacte ne doit pas être présupposée : `Write` peut être représenté par une permission pleine et `Read` par des fractions, ou comme un constructeur séparé. Les lois de composition doivent préciser quelles paires de droits sont compatibles.

### 10.2 Opérations et obligations

| Opération | Précondition | Postcondition à prouver |
|---|---|---|
| Introduction de l'arène | Jeton racine unique ; identifiant et plage frais | Capacité de la région créée exactement une fois |
| Découpe `Slice` | Capacité parent entière et partition valide | Parent consommé ; deux capacités enfant sur des plages dont l'union est le parent et dont les intersections sont vides |
| Emprunt partagé | Droit de lecture disponible ; absence d'écriture concurrente incompatible | Permissions de lecture compatibles ; écriture suspendue pendant la portée |
| Emprunt mutable | Droit exclusif disponible | Un seul emprunteur peut écrire ; parent suspendu jusqu'à la fin du prêt |
| Fin d'emprunt | Tous les droits dérivés sont rendus ou terminés selon le contrat | Parent rétabli dans l'état prévu ; aucun alias temporaire encore utilisable |
| Lecture/écriture | Permission et durée de vie valides ; offset dans la plage | État mémoire modifié seulement pour l'écriture autorisée |
| Partage parallèle | Ressources composables et contextes compatibles | La composition conserve les invariants de permissions |
| Destruction/libération | Aucun emprunt vivant, aucun droit dérivé non résolu, conditions d'arène remplies | Région désactivée ; anciennes références rendues invalides |
| Passage FFI | Contrat du buffer, propriété et durée de vie déclarés | Postcondition du contrat établie ou obligation explicitement assumée |

### 10.3 Propriétés prioritaires

Le premier lot de théorèmes doit couvrir :
1. correction de l'opération de composition des permissions ;
2. unicité d'introduction de la capacité sur une région ;
3. préservation des permissions par découpe et recomposition ;
4. absence d'écriture concurrente sur la même plage ;
5. sûreté d'une lecture lorsque la durée de vie et la provenance sont valides ;
6. impossibilité d'utiliser une capacité après sa fin de portée ;
7. préservation de l'invariant sous parallélisme ;
8. contrat des opérations atomiques séparé des accès ordinaires.

Les résultats de conservation des ressources doivent être prouvés pour l'algèbre abstraite puis reliés à chaque règle du langage. Les propriétés sur plages doivent, séparément, être reliées à l'allocation, aux offsets, aux références et à la représentation compilée.

## 11. Contre-exemples et tests adverses

Les scénarios suivants sont proposés pour un modèle borné et des tests de propriétés. Ils ne sont pas présentés comme déjà exécutés.

| ID | Scénario | Résultat attendu |
|---|---|---|
| T1 | Deux capacités d'écriture sont introduites séparément pour la même région | H1 les exclut, ou le modèle produit un contre-exemple clair |
| T2 | Une arène est éliminée deux fois ou par une règle alternative | Le contrat racine prouve l'unicité ou refuse la seconde introduction |
| T3 | Une capacité est découpée en deux plages qui se recouvrent d'un index | La preuve de partition échoue |
| T4 | Deux plages disjointes sont mappées à la même identité concrète de région | H2 ou la fonction de représentation exclut cette identification |
| T5 | Une valeur cartésienne capture une capacité puis est dupliquée | H3 refuse la dérivation, y compris sous substitution et closure |
| T6 | Deux lecteurs partagent la même région puis une écriture intervient | Permission d'écriture refusée jusqu'à la restitution des emprunts |
| T7 | Un emprunt mutable est réemprunté, puis le parent est réutilisé avant la fin du prêt | L'état suspendu du parent interdit l'accès précoce |
| T8 | Une référence reste active après libération puis l'index est recyclé | L'ancienne génération ou la portée invalide la référence |
| T9 | Un offset déborde ou sort de la plage, y compris à la borne entière maximale | La création et l'accès sont refusés |
| T10 | Un appel FFI conserve un pointeur après le retour de l'emprunt | Le contrat l'interdit, ou marque cette frontière comme non sûre |
| T11 | Deux threads utilisent acquire/release différemment du modèle prouvé | Les hypothèses de compilation/modèle mémoire ne satisfont pas le contrat |
| T12 | Une opération de destruction coïncide avec un accès concurrent | La capacité ou le protocole de durée de vie impose un ordre sûr |
| T13 | Un buffer passe de K7PL à une bibliothèque native, qui retourne après mutation partielle | La postcondition FFI précise l'état mémoire et les ressources restantes |
| T14 | Une capacité est partagée en fractions dont la somme dépasse l'autorité disponible | La loi de composition rejette l'état résultant |

Une campagne de tests peut falsifier le modèle, mais ne remplace pas les preuves des transitions sur tous les états admis. Pour chaque cas, archiver une trace d'état ou une dérivation minimale et identifier H1, H2, H3 ou la nouvelle obligation visée.

## 12. Plan d'exécution et critères de clôture

### P1 — le noyau de permissions
- [ ] Définir l'opération d'introduction racine de l'arène et prouver H1 sans utiliser `thm:surete_spatiale` comme prémisse.
- [ ] Relier les plages `Range` aux segments, régions et identifiants concrets ; démontrer la correspondance injective ou préciser l'invariant requis à la place.
- [ ] Formaliser la règle `Slice`, l'union et l'intersection des segments, les permissions avant/après et la conservation de l'autorité totale.
- [ ] Écrire la preuve H3 au niveau des règles de modes, des délimiteurs et de la substitution.

### P2 — emprunt et partage
- [ ] Définir lecture partagée et écriture exclusive, ou une algèbre fractionnaire aux lois explicites.
- [ ] Formaliser les états de parent suspendu, les prêts imbriqués, leur fermeture et la restitution.
- [ ] Prouver le principe de cadre et la compatibilité de la composition parallèle.
- [ ] Définir destruction, réallocation, générations et validité des offsets.

### P3 — exécution et frontières
- [ ] Déclarer le modèle mémoire concret et les règles atomiques retenues.
- [ ] Relier l'abaissement et les accès générés aux obligations de R2.
- [ ] Spécifier des contrats FFI pour buffers, aliases, durée de vie et accès asynchrones, en articulation avec R1.
- [ ] Exécuter les scénarios T1–T14 sur un modèle borné et relier chaque résultat à une obligation de preuve.

R5 est clôturable lorsque les trois hypothèses H1/H2/H3 disposent chacune d'un énoncé et d'une preuve ou d'une borne d'application explicite, que l'emprunt a une sémantique opérationnelle de début et de fin, et que les accès de l'implémentation sont reliés aux permissions formelles. Une CI verte ou un lemme sur des compteurs naturels ne satisfait pas ce critère.

## 13. Sources primaires comparatives

- Ralf Jung, Jacques-Henri Jourdan, Robbert Krebbers et Derek Dreyer, [*RustBelt: Securing the Foundations of the Rust Programming Language*](https://plv.mpi-sws.org/rustbelt/popl18/), POPL 2018. Preuve mécanisée d'un modèle de Rust et obligations de preuve pour des bibliothèques qui emploient des mécanismes non sûrs.
- Ralf Jung et al., [*Iris from the Ground Up: A Modular Foundation for Higher-Order Concurrent Separation Logic*](https://doi.org/10.1017/S0956796818000151), Journal of Functional Programming, 2018. Cadre de logique de séparation concurrente et d'invariants partagés.
- Richard Bornat, Cristiano Calcagno, Peter O'Hearn et Matthew Parkinson, [*Permission Accounting in Separation Logic*](https://doi.org/10.1145/1040305.1040327), POPL 2005. Partage, fractionnement et recomposition de permissions pour le raisonnement concurrent.
- Hoang-Hai Dang, Jacques-Henri Jourdan, Jan-Oliver Kaiser et Derek Dreyer, [*RustBelt Meets Relaxed Memory*](https://doi.org/10.1145/3371102), POPL 2020. Extension de l'analyse de sûreté au modèle mémoire relâché et enjeux de récupération des ressources.
- Lennard Gäher, Michael Sammler, Ralf Jung, Robbert Krebbers et Derek Dreyer, [*RefinedRust: A Type System for High-Assurance Verification of Rust Programs*](https://plv.mpi-sws.org/refinedrust/), PLDI 2024. Types de raffinement et preuve fondationnelle, y compris pour un usage ciblé de primitives non sûres.
- Neven Villani, Johannes Hostert, Derek Dreyer et Ralf Jung, [*Tree Borrows*](https://plf.inf.ethz.ch/research/pldi25-tree-borrows.html), PLDI 2025. Modèle opérationnel de l'aliasing des pointeurs en Rust, preuve Rocq et évaluation sur un vaste corpus de crates.

Ces résultats appartiennent aux modèles qu'ils définissent. Ils orientent les choix de représentation et de preuve pour K7PL ; ils n'établissent aucune propriété du langage K7PL par transfert automatique.

---
**Conclusion :** la priorité n'est pas d'affirmer que la linéarité suffit, mais de relier une origine unique de capacité, des permissions composables, les durées de vie, les identités mémoire et les accès concrets. H1/H2/H3 fournissent un découpage utile ; leur preuve indépendante et leur correspondance avec l'exécution restent les conditions de la sûreté spatiale annoncée.
