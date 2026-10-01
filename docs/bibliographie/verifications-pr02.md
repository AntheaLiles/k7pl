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

## Deuxième relevé (1er octobre 2026, recherche en ligne)

Niveau de vérification : **résumé** = lu dans la notice ou le résumé de l'éditeur, non dans le corps de
l'article ; une fiche n'est fermée que lorsque ce niveau répond à la question posée.

| Fiche | Constat | État | Sources |
|---|---|---|---|
| `BIB-04` | Le join-calculus est bien le cadre des motifs de jonction ; les implémentations à verrou sérialisent les envois, les approches récentes emploient un sac sans verrou par canal pour la recherche parallèle d'appariement. Le choix de protocole reste `IMPL-04`. | partielle | [Fournet–Gonthier](https://www.microsoft.com/en-us/research/publication/join-calculus-language-distributed-mobile-programming/) · [Scalable Join Patterns](https://www.microsoft.com/en-us/research/?p=168785) |
| `BIB-06` | Confirmé : les échappatoires de Sabelfeld–Myers sont des **expressions** annotées par `declassify`, la divulgation délimitée est la garantie de bout en bout contre le blanchiment. Nuance : la source note que les autres occurrences de l'expression sont aussi déclassifiées. La lecture « expressions closes » est notre précision, nécessaire pour la substitution, non une citation. | fermée | [Chalmers](https://research.chalmers.se/en/publication/2026) |
| `BIB-07` | Ce que la source incrimine est **l'existence d'une plus grande taille ∞** avec ∞ < ∞ (irréflexivité de l'ordre violée), non le partage d'une sorte entre polarités. La scission 𝕊_μ sans ω / 𝕊_ν avec ω de `BLOQ-06` tient : ω n'est jamais une borne stricte d'un type inductif. | fermée | [arXiv 2602.18921](https://arxiv.org/abs/2602.18921v1) · [liste Agda 2020](https://lists.chalmers.se/pipermail/agda/2020/012340.html) |
| `BIB-10` | Confirmé (résumé) : cadre paramétré par une théorie de modes ; coupure et identité admissibles indépendamment d'elle. Le manuscrit le cite déjà. | fermée | [Licata–Shulman–Riley, FSCD 2017](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.FSCD.2017.25) |
| `BIB-18` | Rien à corriger (décision de la fiche). | fermée | — |
| `BIB-20` | Confirmé : calf (POPL 2022) pose la distinction de phase extension/intension et la non-interférence interne entre résultat et coût ; decalf (POPL 2024) ajoute les effets (choix probabiliste, état). | fermée | [calf](https://par.nsf.gov/biblio/10603582-cost-aware-logical-framework) · [decalf](https://popl24.sigplan.org/details/POPL-2024-popl-research-papers/12/Decalf-A-Directed-Effectful-Cost-Aware-Logical-Framework) |
| `BIB-21` | Confirmé : théorie graduée dépendante paramétrée par un semi-anneau partiellement ordonné, formalisée en Agda (ICFP 2023). **Non vérifié** : la restriction « pas d'instances affectant l'égalité définitionnelle » contre le produit mixte — à lire dans le corps. | partielle | [Chalmers](https://research.chalmers.se/publication/537991) |
| `BIB-22` | Confirmé : CloTT encode la productivité dans les types, sans indice de taille ; normalisation forte, canonicité et décidabilité de l'égalité établies. | fermée | [arXiv 1804.06687](https://arxiv.org/pdf/1804.06687) |
| `BIB-23` | Confirmé : le travail Granule réintroduit des comportements non linéaires en base linéaire graduée (*Replicate, Reuse, Repeat*) ; TLL_C : sessions dépendantes. | fermée | [arXiv 2203.12875](https://arxiv.org/pdf/2203.12875) · [arXiv 2510.19129](https://arxiv.org/pdf/2510.19129) |
| `BIB-24` | XTT : théorie cubique cartésienne pour les ensembles de Bishop, unicité des preuves d'identité définitionnelle, extensionnalité des fonctions, canonicité par recollement ; elle conserve l'extensionnalité **sans** univalence. Le manuscrit cherche le type de chemin pour la sédimentation graduée : la compatibilité reste à instruire, XTT étant une théorie à types de Bishop. | partielle | [LMCS 9264](https://lmcs.episciences.org/9264) |
| `BIB-25` | Forme de la loi d'échange : `(a ∥ b) ; (c ∥ d) ≤ (a ; c) ∥ (b ; d)`, inégalité (faiblissement de l'égalité des 2-catégories) ; elle devient égalité pour les invariants. **Non vérifiée** : la compatibilité avec la résiduation du budget. | partielle | [Hoare et al. 2011](https://opus.bibliothek.uni-augsburg.de/opus4/frontdoor/index/index/docId/1301) |
| `BIB-27` | Confirmé : les types de boîtes aux lettres (de'Liguoro–Padovani) et *Special Delivery* (Pat, ICFP 2023, vérificateur en OCaml avec Z3) fournissent le typage de boîtes aux lettres et l'absence d'interblocage. Le théorème d'interblocage par graphe de dépendance reste à lire dans le corps. | partielle | [arXiv 1801.04167](https://arxiv.org/pdf/1801.04167) · [arXiv 2306.12935](https://arxiv.org/pdf/2306.12935) |
| `BIB-28` | Confirmé : *Exceptional Asynchronous Session Types* (POPL 2019) : sessions asynchrones avec exceptions, préservation, progrès, absence d'interblocage, confluence, terminaison. | fermée | [POPL 2019](https://popl19.sigplan.org/details/POPL-2019-Research-Papers/77/Exceptional-Asynchronous-Session-Types-Session-Types-without-Tiers) |
| `BIB-29` | Confirmé : ChorLean est une bibliothèque en Lean (valeurs localisées, `CHORLEAN_MAIN`) ; HasChor, MultiChor et CloudChor traitent les valeurs multiplement localisées. | fermée | [arXiv 2403.05417](https://arxiv.org/pdf/2403.05417) |

**Non retrouvées ou non instruites.** `BIB-02` (Saffrich & Thiemann 2025) : **aucune publication de ces auteurs n'a été retrouvée** — la référence est à vérifier auprès de la source du relecteur avant toute citation. `BIB-13` (resucrage : *Hygienic Resugaring of Compositional Desugaring*, ICFP 2015, traite l'hygiène mais pas l'α-équivalence de surface en général), `BIB-19` (aucun article de Castellan et al. sur les effets indexés retrouvé), `BIB-05`, `-11`, `-12`, `-14`, `-15`, `-16`, `-17`, `-26` : à instruire dans le corps des articles.
