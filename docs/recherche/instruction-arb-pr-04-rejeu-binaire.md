<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Instruction de `ARB-PR-04` — ce que le document promet pour le rejeu bit-à-bit

**Décision de l'auteur (1er octobre 2026) :** à instruire, pour évaluer les possibilités avant de
trancher. Ce document est l'instruction ; il ne tranche pas.

## 1. État actuel du manuscrit

* Le rejeu est scindé en deux théorèmes : `thm:determinisme_rejeu` (logique, `≈_obs`) et
  `thm:rejeu_binaire` (proposition ⟨représentation⟩, sous `E_repro`, avec injectivité de la
  représentation sur les valeurs observables).
* `thm:representation_inobservable` (exigence) nomme `Injectivité(obs, repr)` et ses cinq
  dispositions ; `thm:homomorphisme_roues` n'affirme plus de homomorphisme et fait de l'arithmétique
  des singularités une spécification de K7PL.
* Aucune des trois composantes de `E_repro` (ordonnancement, mode d'arrondi, version de la chaîne)
  n'est fixée par le document ; l'architecture et le comportement NaN n'y figurent pas.

## 2. Les possibilités

| | Voie | Ce qu'elle promet | Ce qu'elle coûte | Réserve |
|---|---|---|---|---|
| A | **Logique seul** : retirer l'identité binaire de la promesse | `≈_obs` ; l'identité binaire devient une propriété d'une implémentation | rien au système de types ; P4-bit disparaît du chapitre 1 | le rejeu binaire sert l'oracle de test différentiel (ch. 6) |
| B | **Binaire sous `E_repro` étendue** : quatrième composante « architecture et comportement NaN », portée « une machine » | identité binaire sur une architecture fixée | une exigence sur le compilateur et l'exécutif, vérifiable par test | l'ordonnancement inter-acteurs n'est pas couvert |
| C | **Binaire par construction** : exclure la charge utile NaN de l'égalité observable de couche 3 et spécifier la propagation (table `IMPL-07`) | `Injectivité` devient vraie par définition sur les singularités | la table de propagation, et un abaissement SIMD qui la respecte | ne traite ni le bourrage ni `mremap` |
| D | **Binaire total** : consigner l'ordonnancement complet des réceptions inter-acteurs | identité binaire multi-acteurs | journal beaucoup plus gros, coût en temps et en espace contraire à P3 s'il n'est pas borné | borne à écrire |

## 3. Ce que l'instruction doit établir avant de choisir

1. **Lister les libertés représentationnelles** réelles du modèle (bourrage de l'arène SoA, octets non
   initialisés, ordre des segments après `mremap`/RDMA, purge à la rotation du journal, charge utile
   NaN) et dire pour chacune quelle voie la traite.
2. **Mesurer ce que le chapitre 6 attend du rejeu binaire** : si l'oracle de test différentiel se
   contente de `≈_obs` sur la sortie, la voie A suffit ; sinon B ou C.
3. **Établir la compatibilité avec P3** de la voie D : quelle borne sur la taille du journal.
4. **Vérifier par test** (à l'implémentation) l'hypothèse `Injectivité` : un test différentiel sur
   deux chemins de compilation par arrondi et par NaN.

## 4. Orientation provisoire (à confirmer)

B puis C : fixer la portée « une machine » que le §4.5 applique déjà au modèle mémoire, ajouter la
quatrième composante à `E_repro`, et faire de la table de propagation (`IMPL-07`) ce qui rend
l'injectivité vraie sur les singularités. A reste la voie de repli si l'implémentation ne peut tenir
B. D est écartée tant qu'aucune borne n'est écrite.
