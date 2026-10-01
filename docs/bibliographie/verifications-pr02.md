<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE

SPDX-License-Identifier: CC-BY-4.0
-->

# Vérifications bibliographiques de la campagne PR-02

Relevé des fiches `BIB` instruites par recherche en ligne le 1er octobre 2026. Seules les fiches
dont la source a été lue sont closes ; les autres restent ouvertes.

| Fiche | Constat | Sources |
|---|---|---|
| `BIB-03` | Huang et Yallop ont publié la défonctionnalisation pour un langage à types dépendants (*Defunctionalization with Dependent Types*, PLDI 2023 : correction et préservation du typage). La version **quantitative** n'est qu'un travail en cours : *Towards Quantitative Inductive Families* (exposé TYPES 2024). L'énoncé du manuscrit reste donc `conjecture ⟨compilation⟩`, son statut est exact. | [arXiv 2304.04574](https://arxiv.org/pdf/2304.04574) · [exposé TYPES 2024](https://types2024.itu.dk/slides/Yulong%20Huang%20-%20Towards%20Quantitative%20Inductive%20Families.pdf) |
| `BIB-08` | IEEE 754-2019 : une opération sur un NaN silencieux **devrait** produire un NaN silencieux de même charge utile — recommandé, non exigé ; la propagation est facultative selon les architectures (optionnelle sur RISC-V, désactivable sur ARM). L'architecture doit donc entrer dans `E_repro`, ce que le §4.5 fait. | [IEEE 754-2019, note sur la propagation des NaN](https://grouper.ieee.org/groups/msc/ANSI_IEEE-Std-754-2019/background/nan-propagation.pdf) |
| `BIB-09` | Arrow : un tableau sans valeur nulle **peut** ne pas allouer son bitmap de validité (les consommateurs doivent gérer les deux cas) ; les tampons **devraient** être alignés et complétés à 8 ou 64 octets, 64 recommandé. Le manuscrit écrit « minimum de 8 octets » : exact comme minimum. **À vérifier encore** : l'ordre des octets (little-endian par défaut), et Cap'n Proto (liste primitive, segment aligné sur 8 octets). | [Arrow Columnar Format](https://arrow.apache.org/docs/format/Columnar.html) |
