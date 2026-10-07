<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Changelog de la spécification

Versions de la spécification publiées sur Zenodo (releases `spec-vX.Y.Z`).
Les versions de l'implémentation sont suivies dans [`../CHANGELOG.md`](../CHANGELOG.md).

Le format s'inspire de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).

## [Unreleased]

### Modifié

- §3.2 : les erreurs `∘`, `δ` sont des ensembles d'étiquettes combinés par réunion (`∘δ`, cinquième singularité ; la règle précédente, borne supérieure avec `∘ ⋆ δ = ⊥`, n'était pas associative : `(∞ + ∞) + ∘ ≠ ∞ + (∞ + ∘)`) ; l'extension n'est pas une roue (`⊥` n'absorbe plus les erreurs) et le texte le dit ; « une roue » devient « la roue des fractions d'un corps » pour le nombre d'éléments hors du corps ; IEEE 754-2019 cité pour l'écart sur `∞ + ∞` (une notice ajoutée) ; `thm:homomorphisme_roues` : cinq singularités au lieu de quatre (`BLOQ-12`, décision de l'auteur ; à ratifier ; sources lues au niveau du résumé seulement : `docs/recherche/sources-singularites.md`).
- L'index (§8.7) imprime les pages du PDF (et les sections dans le HTML) des trente et un termes, reconnus dans le texte à la génération ; l'interface du HTML est en français (`ANOM-09`, `ANOM-10` ; décision de l'auteur). La liste des termes quitte la page pour `tools/SpecExt/IndexTerms.lean`.
- §3.2 : tables de propagation de `⊥` et `∞` calculées sur la roue des fractions (Carlström 2004, notice confirmée, corps non lu) ; l'écart d'IEEE 754 sur `∞ + ∞` est écrit ; `∘` et `δ` sont définis comme une extension de K7PL, absorbante et sans source, propagée par la borne supérieure (`BLOQ-12`, décision de l'auteur ; à ratifier). Deux notices ajoutées à la bibliographie (Carlström 2004 ; Bergstra et Ponse 2015).
- §3.2 : tables de propagation des singularités (addition, produit) sur les classes `0`, `x`, `∞`, `⊥`, règle d'entrée Float64 → roue (NaN lu `⊥`, `±∞` lus `∞`) et égalité de couche 3 sur les classes ; `∘` et `δ` restent sans définition (appliqué, à ratifier : `IMPL-07`).

- L'annexe E (présentation formelle) est fondue dans le manuscrit : grammaires et règles de typage au chapitre 3, sémantique opérationnelle et sortes du métalangage au chapitre 4, table des glyphes au chapitre 1. Les annexes restantes sont A à D.
- §1.2 : le choix d'une famille modale et graduée comme socle est écrit, avec son motif.
- §6.2 : la préservation graduée de bout en bout est déclarée comme objectif.

### Corrigé
- PREUVE-08 : la troncature préserve les lois de comonade pour tout foncteur (convention d'écartement) ; la comonade tronquée est graduée par la somme des profondeurs, non par le produit (§2.3, théorème de troncature, désormais un théorème).
- IMPL-06 : l'abaissement gradué se lit comme une propriété de conformité du compilateur à un profil de représentation (§6.2).
- BLOQ-05 : niveaux de lecture ℓ et de production ℓ̂ distingués ; clauses sur Op et Case ; Tick bien formé.
- Lot PREUVE : énoncés nets pour la simulation, la troncature, la relation sur un produit ; hypothèse D_det écrite ; croquis du Th. 9 non circulaire ; commutation de ℰ₀ en deux temps.
- Lot FACT : loi unique d'introduction, exigence d'inobservabilité de la représentation, Mailbox, fenêtre-grade.

- BLOQ-14 : l'ordre de précision `Unr ⊑ Aff ⊑ Lin` n'est plus présenté comme le sous-typage `≼` (ch. 1, ch. 2).
- BLOQ-11 : les échappatoires de la déclassification sont closes (`fv(e) = ∅`) dès le chapitre 2.
- BLOQ-10 : reproductibilité du rejet sous l'hypothèse nommée `D_det`, non plus l'inférence principale.
- BLOQ-12 : le Th. 18 devient une proposition de représentation, sans prétendre à un homomorphisme.
- BLOQ-09 : sûreté spatiale sous trois hypothèses explicites (unicité d'introduction, portée, imbrication).
- BLOQ-07 : fidélité de l'interpréteur conditionnelle à Sim (statut proposition).
- BLOQ-08 : P1 scindé en P1a (postulat) et P1b (obligation).

### Added

- Squelette Verso de la spécification et génération du PDF.
- **Le manuscrit complet**, converti de l'Org-mode sans modification de texte : sept chapitres,
  « Références du document » (listes des figures, tableaux, formules, codes ; glosses, acronymes,
  index) et cinq annexes (codes d'erreur, LSP et REPL, Sushi, Sugoi, présentation formelle) ;
  59 énoncés scellés, 38 formules, 13 figures, 27 tableaux, 7 codes sources, 250 œuvres citées.
- Figures (`spec/figures/`) : SVG et PDF dérivés des exports drawio, et leurs sources.
- Page d'introduction : ORCID, DOI Zenodo, dépôt GitHub, écusson officiel CC BY 4.0 et mention © Cyprien PIERRE 2026.

### Changed

- Anomalies corrigées : lettres d'annexes écrites en dur remplacées par des renvois ; étiquettes d'annexes sans lettre ; en-tête et colonne « Route » du tableau des engagements ; trois couches rétablies au glossaire ; étiquette `fig:comp-process` ; commentaires d'auteur retirés du texte (`docs/recherche/commentaires-du-manuscrit.md`).

- Les chapitres d'exemple (`Introduction`, `Expressions`) sont remplacés par le manuscrit.
- Titre aligné sur la spécification Org-mode : « K7PL : KonSept Programming Language ».
