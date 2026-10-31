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
| Grades et ressources | `Grades/Budget` | Réutilise `ℕ∞`, `Cost_Budget`, `Adm`, `consumeK`; prouve la borne du résidu | Les règles opérationnelles n'invoquent pas encore `consumeK` sous preuve d'admissibilité |
| Structures | `Structural/RangeSeparation` | Symétrie, irréflexivité et séparation de `K7pl.MemoryRange.Range` | Pas de correspondance aux identités de régions ni H1/H3 |
| Mémoire | `Memory/EntityRef` | Invalidation après incrément de génération | Génération `Nat` non bornée ; pas de concurrence |
| Métathéorie | `Metatheory/MultiStep` | Fermeture réflexive-transitive et préservation d'invariant | Pas de propriété temporelle ni de simulation |

## Dépendances théoriques

### Grades

Le porteur d'usage est importé depuis `K7pl.UsageScale` et rapproché par
égalité définitionnelle de `Spec.C3.EffectiveKernel.Usage`.
`Grades/Scaling.lean` met en correspondance le grade de C3 avec celui de
l'implémentation par deux conversions inverses. Lean vérifie la conservation
des quatre composantes, la compatibilité de `π_U` et la commutation avec
`Scale_Usage`. C'est une correspondance de représentations, pas une preuve
de raffinement des règles K.

Les intervalles formalisés sont :
- `uLin = {1}` ;
- `uAff = {u | u ≤ 1}` ;
- `uRel = {u | 1 ≤ u}` ;
- `uUnr = 𝒫(Usage)`.

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
l'argument inclut une preuve d'admissibilité. Le lemme ajouté prouve que le
résidu consommé ne dépasse pas le budget disponible. Cela ne prouve pas que
les règles opérationnelles préservent l'admissibilité.

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

1. Formaliser H1/H2/H3, puis le théorème C4 spatial, après stabilisation des
   règles d'introduction/capture des capacités.
2. Étendre `Consume` à l'algèbre de budget normative, avec domaine partiel
   explicite et interactions avec les grades.
3. Démontrer les lois de composition de `⊠`, `ψ` et effets à partir de
   leurs contrats réels, sans factorisation additive implicite.
4. Définir la sémantique des sessions et établir dualité/substitution/
   préservation ; brancher ensuite le mapping TLA.
5. Modéliser le cycle de vie concurrent des slots : destroy, incarnation,
   références tardives, opérations async, revocation et reclaim.
6. Établir la correspondance K↔Lean puis Lean↔TLA par des obligations
   explicites, non par des ressemblances de noms.
7. Séparer terminaison, productivité, fairness et progression ; prouver
   chaque résultat avec ses hypothèses opérationnelles.

## Critères de maturité

Une obligation ne passe au statut démontré que si son énoncé est relié à une
source stable, si toutes ses hypothèses sont visibles, si Lean compile la
preuve, si son audit d'axiomes est enregistré et si son périmètre n'excède pas
la représentation réellement formalisée. La compilation d'un modèle abstrait
ne valide pas les propriétés de l'implémentation.
