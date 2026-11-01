<!-- SPDX-FileCopyrightText: 2026 Cyprien PIERRE -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Plan de formalisation Lean

## Objet et statut

Ce document inventorie les obligations traitées par `proofs/`, leur source
théorique, leur niveau de formalisation et leurs limites. Il s'agit d'un plan
de preuves et d'un registre d'évidence, pas d'une extension normative de la
spécification.

La classification distingue :
1. **définition importée** : type ou opération défini dans la source de
   spécification, puis réutilisé ;
2. **lemme démontré** : Lean ferme l'énoncé indiqué sans axiome ajouté ;
3. **modèle abstrait conditionnel** : résultat valide dans un modèle explicite
   ou sous des hypothèses non encore prouvées ;
4. **obligation ouverte** : aucune conclusion n'est revendiquée.

## Architecture par domaine

| Domaine | Modules | Résultats présents | Limite |
|---|---|---|---|
| Grades et ressources | `Grades/UsageIntervals` | Inclusions Lin/Aff/Rel/Unr ; incomparabilité Aff/Rel | Propriétés ensemblistes des intervalles |
| Grades et ressources | `Grades/Scaling` | Correspondance bidirectionnelle entre les deux grades, projection `π_U`, commutation avec `Scale_Usage` | Ne prouve pas la simulation des règles K |
| Grades et ressources | `Grades/StructuralModes` | Réutilise les morphismes Ideal-based de l'implémentation et le candidat Rel | N'établit pas que les règles K les imposent |
| Grades et ressources | `Grades/Budget` | Réutilise `ℕ∞`, `Cost_Budget`, `Adm`, `consumeK`; conservation, borne du résidu, caractérisation du coût parallèle et borne séquentielle | Les règles opérationnelles n'invoquent pas encore `consumeK` sous preuve d'admissibilité |
| Structures | `Structural/RangeSeparation` | Symétrie, irréflexivité et séparation de `K7pl.MemoryRange.Range` | Pas de correspondance aux identités de régions ni H1/H3 |
| Mémoire | `Memory/CapabilityOwnership` | Préservation de l'unicité après allocation, exclusion de deux écrivains dans un état parallèle globalement unique, bornes de comptage | Modèle abstrait de comptage ; pas de simulation des règles K |
| Mémoire | `Memory/EntityRef` | Invalidation après incrément de génération | Génération `Nat` non bornée ; pas de concurrence |
| Métathéorie | `Metatheory/MultiStep` | Fermeture réflexive-transitive et préservation d'invariant | Pas de propriété temporelle ni de simulation |

## Composition du périmètre d'assurance

Le contrat d'axiomes suit 30 déclarations. Leur présence dans ce périmètre ne
signifie pas que les 30 preuves sont nouvelles dans cette tranche :

| Nature | Déclarations exposées | Nombre | Portée |
|---|---|---:|---|
| Réutilisation / ré-exposition | 5 morphismes de modes, 4 résultats budgétaires, 2 résultats de propriété des capacités, 1 lemme de séparation des plages | 12 | Théorèmes déjà établis dans les modules canoniques de l'implémentation, désormais audités dans le paquet de preuves |
| Correspondance définitionnelle | Conversions des grades, projection d'usage et commutation du scaling | 4 | Garde-fous de cohérence entre deux représentations champ-à-champ identiques ; les preuves sont définitionnelles (`rfl`) |
| Contenu de preuve nouveau | 6 relations d'intervalles, 2 lois de disjonction, 2 bornes de comptage, 2 bornes budgétaires, 1 invalidation par génération, 1 préservation multi-pas | 14 | Résultats nouvellement formalisés dans ce paquet, dans les modèles et limites décrits ci-dessous |

Le total `12 + 4 + 14 = 30` décrit le périmètre d'audit, pas un décompte
de théorèmes de sûreté K7PL établis. Les ré-expositions augmentent la
traçabilité de l'assurance ; les quatre résultats définitionnels ne sont pas
des preuves de raffinement ; les quatorze autres restent limités à leurs
modèles et hypothèses explicites.

## Dépendances théoriques

### Grades

Le porteur d'usage est importé depuis `K7pl.UsageScale` et rapproché par
égalité définitionnelle de `Spec.C3.EffectiveKernel.Usage`.
`Grades/Scaling.lean` met en correspondance le grade de C3 avec celui de
l'implémentation par deux conversions inverses. Lean vérifie la conservation
des quatre composantes, la compatibilité de `π_U` et la commutation avec
`Scale_Usage`. C'est une correspondance de représentations, pas une preuve
de raffinement des règles K.

Les intervalles formalisés, sur le porteur `WithTop ℚ≥0`, sont ceux de la
table C2 :
- `uLin = Set.Icc 1 1` (`[1..1]`) ;
- `uAff = Set.Icc 0 1` (`[0..1]`) ;
- `uRel = Set.Ici 1` (`[1..ω]`) ;
- `uUnr = Set.Icc 0 ⊤` (`[0..ω]`).

Le fait que `uAff` et `uRel` soient incomparables est démontré par les
témoins 0 et 2. Cela ne valide ni l'algèbre de grades entière ni les règles de
typage.

La structure de modes n'est pas redéfinie dans `proofs/` : les théorèmes
réutilisent `K7pl.StructuralModes.Mode` et `Morphism`, construits à partir
d'idéaux de contraction et de permissions d'affaiblissement. Le candidat
relationnel reste séparé du trio de référence. L'existence de ces morphismes
abstraits ne prouve pas que les règles de typage K les imposent.

### Budget

Le domaine réutilise `K7pl.GradeBudget` : `K = (ℕ∞ × ℕ∞)^L`,
`Cost_Budget = max(W,D)`, `Adm` et l'interface partielle `consumeK` dont
l'argument inclut une preuve d'admissibilité. Les résultats exposent la conservation de `consumeK`, la borne du résidu,
la caractérisation du coût parallèle (travail additif, profondeur maximale)
et une borne du coût séquentiel. Cela ne prouve pas que les règles
opérationnelles préservent l'admissibilité.

### Capabilités et sûreté spatiale

Le module réutilise `K7pl.MemoryRange.Range` et sa relation `Disjoint` ; il
ajoute symétrie, irréflexivité et non-identité de deux plages disjointes.
Cela formalise le volet arithmétique de H2 sur les plages, mais n'identifie pas
une plage à une région physique. Cela ne démontre pas :
- H1 : introduction unique et linéaire de `WriteCap` ;
- H2 : disjonction des plages impliquant des régions distinctes ;
- H3 : non-capture des capacités linéaires par les valeurs cartésiennes.

Le théorème C4 de sûreté spatiale reste donc conditionnel et n'est pas
re-prouvé par ce lot.

### Capabilités d'écriture

`K7pl.MemoryCapability` représente, pour chaque région, les jetons d'arène
et capacités d'écriture vivants. L'invariant impose que leur somme soit au plus
un. La formalisation prouve la préservation de cet invariant par allocation
lorsqu'un jeton d'arène existe, puis l'impossibilité de deux écrivains dans
une composition parallèle dont l'état global satisfait l'invariant. Cela
formalise un noyau de comptage associé à H1 ; cela ne prouve pas que les règles
K `Arena`, `WriteCap`, `alloc_range` et `Par` réalisent ce modèle.

### EntityRef et cycle de vie

Le modèle de slot représente une référence par (slot, génération). Il établit
que l'incrément de génération invalide la référence précédente dans le modèle
à compteur non borné. Il faut encore traiter la largeur concrète, l'épuisement,
la restauration, l'ABA, les références détenues par des opérations
asynchrones, la quiescence et la reclamation.

### Métathéorie

`MultiStep` définit une fermeture réflexive-transitive générique d'une
relation à petits pas. Le théorème de préservation transfère tout invariant
préservé par un pas à toute trace finie. Il s'agit d'un principe de preuve,
pas d'un théorème de terminaison ou de progression.

## Dépendances de compilation et invalidation de l'assurance

Les modules de domaine dépendent des définitions de `src/K7pl/` et du noyau
`spec/Spec/C3/EffectiveKernel.lean`. Ces chemins sont des entrées de lecture
du composant CI `lean-proofs`, limitées à la surface `axiom_audit` : leur
modification doit donc relancer la compilation du paquet de preuves et son
audit exact `#print axioms`, en plus des contrôles déclenchés par leurs
composants propriétaires. Cette liste doit rester synchronisée avec les
imports directs et transitifs des modules Lean ; l'ajout d'un nouvel import
de source locale implique l'ajout de l'entrée correspondante et d'un test de
classification.

À cette révision, `cache_determinants` est une métadonnée du registre :
aucun consommateur ne dérive de ce champ une clé de cache effective. Il ne
constitue donc pas, à lui seul, un mécanisme d'invalidation. Les entrées
source sont également déclarées comme `read_inputs`, qui est le mécanisme
effectif de déclenchement de la surface de preuve.

## Frontières K / Lean / TLA+

La séparation cible est :
- `lexicon/` : syntaxe K, règles opérationnelles et artefacts exécutables ;
- `proofs/` : preuves Lean générales et formalisation des contrats ;
- `models/` : modèles de protocoles/concurrence TLA+ et traces TLC bornées.

Aucune équivalence entre ces représentations n'est inférée de la compilation.
Pour relier une règle K à une règle Lean, il faudra une relation de représentation
et un théorème de simulation ou de correspondance sur les états et les pas.
Pour relier TLA+, il faudra établir un mapping d'états, la préservation des
transitions/invariants et des hypothèses de fairness adaptées. Un contre-exemple
TLC peut guider une preuve ou invalider un énoncé, mais ne devient pas un axiome.

Les interfaces envisagées avec #311 et #319 sont postérieures à leur fusion :
- #311 doit fournir la base K sous `lexicon/` ;
- #319 doit fournir les modèles TLA+ sous `models/` ;
- cette PR fournit le noyau Lean organisé par domaine, sans supposer leur
  structure non encore intégrée dans `main`.

## Travaux différés

La séquence ci-dessous est un ordre de dépendance technique proposé pour la
recherche ; elle ne ratifie aucune règle ni propriété normative.

1. **Relier la sûreté des capacités aux transitions K.** Stabiliser les règles
   concernées, définir une relation de représentation entre configurations K
   et états Lean, puis démontrer la préservation règle par règle pour
   `Arena`, `WriteCap`, `alloc_range` et `Par`. Distinguer les trois
   obligations : H1 (introduction et consommation linéaire de `WriteCap`),
   H2 (relation entre plages et régions, puis disjonction des régions) et H3
   (absence de capture des capacités linéaires dans les valeurs cartésiennes).
   Le modèle de comptage actuel n'établit aucune de ces propriétés sur
   l'exécution K sans cette relation.
2. **Raccorder grades et budgets à l'opérationnel.** Identifier, pour chaque
   règle pertinente, le coût, le domaine partiel de `Consume`, l'admissibilité
   et le résidu. Démontrer la préservation des budgets règle par règle avant
   d'établir les lois de composition de `⊠`, `ψ` et des effets ; ne pas
   supposer de factorisation additive qui ne découle pas de leurs contrats.
3. **Formaliser les sessions.** Définir leur sémantique, puis établir
   dualité, substitution et préservation sous des hypothèses explicites.
   Le raccordement à TLA+ doit passer par un mapping d'états et de transitions,
   et non par une similitude de noms ou de formes syntaxiques.
4. **Raffiner le cycle de vie de `EntityRef`.** Relier le modèle abstrait
   `Nat` à l'encodage borné concret ; préciser l'épuisement, le non-réemploi
   et les conditions de destruction/réincarnation. Traiter séparément ABA,
   références tardives, opérations asynchrones, quiescence, révocation et
   reclamation concurrente.
5. **Instancier la métathéorie par couche.** Construire les relations de pas
   propres à chaque couche. Établir la préservation sur ces relations, puis
   traiter séparément progression, terminaison, productivité et fairness :
   la fermeture multi-pas générique ne fournit pas ces propriétés sans
   hypothèses opérationnelles supplémentaires.
6. **Établir et vérifier les ponts inter-modèles.** Après K↔Lean, définir le
   mapping vers les états TLA+ et prouver la préservation des transitions et
   invariants. Utiliser TLC pour explorer des instances bornées et chercher
   des contre-exemples ; une exploration finie ne remplace pas le théorème de
   correspondance ni les preuves universelles.

Pour chaque étape, le critère de sortie reste : source et SHA identifiés,
hypothèses explicites, relation de représentation définie, preuve compilée,
audit d'axiomes exact et contre-exemples négatifs pertinents examinés. Une
obligation reste ouverte tant que ces éléments ne sont pas réunis.

## Critères de maturité

Une obligation ne passe au statut démontré que si son énoncé est relié à une
source stable, si toutes ses hypothèses sont visibles, si Lean compile la
preuve, si son audit d'axiomes est enregistré et si son périmètre n'excède pas
la représentation réellement formalisée. La compilation d'un modèle abstrait
ne valide pas les propriétés de l'implémentation.
