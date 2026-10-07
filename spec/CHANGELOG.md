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
- ch. 1, ch. 2, ch. 3, §4.7 : la règle `Declassify` porte la clôture des échappatoires (`fv(v)=∅`) ; la table de sédimentation et les fragments du ch. 2 se lisent comme images réciproques de sous-ensembles de l'usage ; le ch. 1 dit la forme complète du facteur temporel de l'effet ; la liaison implicite du copatron est un thunk (`PREUVE-04`, `TRANS-02`, `TRANS-06`, point de forme de `ANOM-17`).
- L'index (§8.7) imprime les pages du PDF (et les sections dans le HTML) des trente et un termes, reconnus dans le texte à la génération ; l'interface du HTML est en français (`ANOM-09`, `ANOM-10` ; décision de l'auteur). La liste des termes quitte la page pour `tools/SpecExt/IndexTerms.lean`.
- ch. 3 (grammaires des types et des termes, règles de typage), §2.4, §4.7 : les grammaires engendrent `□V`, `◇V`, `○V`, `○C` ; `◇C`, `@ₙC` et `!_ℓ A` sont des abréviations définies ; `always`, `now`, `next` et `locₙ` sont des valeurs, `at`, `wait` et `declassify` des calculs ; règles `Nxt`, `Loc`, `Declassify` ajoutées, `Alw⁻`, `Wait`, `At` retypées ; six schémas de réduction des modalités et de la déclassification (`ANOM-17`, décision de l'auteur ; à ratifier).
- §3.2 : tables de propagation de `⊥` et `∞` calculées sur la roue des fractions (Carlström 2004, notice confirmée, corps non lu) ; l'écart d'IEEE 754 sur `∞ + ∞` est écrit ; `∘` et `δ` sont définis comme une extension de K7PL, absorbante et sans source, propagée par la borne supérieure (`BLOQ-12`, décision de l'auteur ; à ratifier). Deux notices ajoutées à la bibliographie (Carlström 2004 ; Bergstra et Ponse 2015).
- §6.1 et tous les renvois du document : les phases de compilation sont renumérotées de 0 à 10, une étape par numéro, sans fraction (Parse 0, Expansion 1, ConfigAnalysis 2, TypeCheck 3, Résolution 4, PurityCheck 5, TermProof 6, ConstraintSolve 7, Optimize 8, CodeGen 9, Link 10) ; la figure 11 est redessinée (l'expansion y figure, les trois points de contrôle sont en pointillés) ; le paragraphe de la Phase 1 est écrit ; « une phase d'élaboration » devient « la phase de résolution » (`STRUCT-06`, `REECR-16` ; décision de l'auteur, schéma à ratifier).
- §4.5 et ch. 1 (P4) : le rejeu binaire est promis sur une machine, sous `E_repro` à quatre composantes (ordonnancement, arrondi, chaîne de compilation, architecture et comportement des NaN) ; pas de rejeu binaire multi-acteurs (appliqué, à ratifier : `ARB-PR-04`, voie B puis C).
- §3.2 : tables de propagation des singularités (addition, produit) sur les classes `0`, `x`, `∞`, `⊥`, règle d'entrée Float64 → roue (NaN lu `⊥`, `±∞` lus `∞`) et égalité de couche 3 sur les classes ; `∘` et `δ` restent sans définition (appliqué, à ratifier : `IMPL-07`).
- §4.5 : structure physique de la boîte aux lettres, un anneau SPSC par couple (émetteur, boîte) et une file de jonction par acteur ; invalidation locale au destructeur d'une capacité exportée (appliqué, à ratifier : `IMPL-04`, `BIB-17`).
- §3.1 : le mode est attaché à la couche, `Rel` n'est instancié par aucune zone ; §1.4 : pas d'adjonction graduée unifiée ; §2.4 : pas de cadre unique des structures monotones (appliqué, à ratifier : `STRUCT-16`, `FACT-12`, `FACT-14`).
- §3.2, §4.7 : la règle Guard et la grammaire portent des motifs conjonctifs de messages ; schémas de réduction de la fourche-jointure (`∥`, `vmap`), de la découpe (`slice`) et de la défaillance de `try` ; formes terminales du progrès complétées (`Λα.c`, copatron) ; sous-typage des tailles coinductives ; l'énoncé de `thm:determinisme_parallele` dit que la profondeur séquentielle majore la parallèle (appliqué, à ratifier : `ANOM-17`).
- Annexes B, C, D : bandeau « esquisse » (appliqué, à ratifier : `D-7`).
- §4.7 : le lemme de correspondance des niveaux n'exige pas d'indexer le jugement (`BLOQ-05`).

- L'annexe E (présentation formelle) est fondue dans le manuscrit : grammaires et règles de typage au chapitre 3, sémantique opérationnelle et sortes du métalangage au chapitre 4, table des glyphes au chapitre 1. Les annexes restantes sont A à D.
- §1.2 : le choix d'une famille modale et graduée comme socle est écrit, avec son motif.
- §6.2 : la préservation graduée de bout en bout est déclarée comme objectif.

### Corrigé
- PREUVE-03 (partielle) : le fil de temps enfilé contredisait le système de sortes ; genre `maillon`, capacités d'émission, de réception et de restriction corrigées, clause de transfert au bon sortage ; traduction du fil par niveau, proposition `thm:chaine_fils` sur un fragment ; clause de session précisée (correspondance des noms, comparaison des fils) ; l'induction sur les règles de communication n'est pas conduite (§4.6, §4.7, §4.8).
- ANOM-17 (partielle) : schémas de réduction du point fixe (déplié exactement `h` fois), du copatron sous l'observation, de `try` à corps terminal et des cinq règles globales de la couche 2 avec la règle locale `Loc` ; contextes `E.i`, `E[W]`, `out E`, `try E catch h` ; table de couverture des constructeurs ; esquisses du progrès, de la préservation et de la simulation relues (§4.7, §4.6). Les constructeurs dont la réduction n'est pas déterminée par le texte restent sans schéma et sont instruits.
- PREUVE-07 / BLOQ-07 : clause de `return` avec transfert du canal de temps ; le domaine de la simulation et du progrès est borné aux formes qui se réduisent (§4.4, §4.6).
- FACT-07 : la relation logique du §4.7 est une seule famille indexée par le treillis, trois énoncés en sont des lectures ; sa non-monotonie en ℓ est dite.
- BIB-15 : §4.2, la file bornée prouvée (plusieurs producteurs et consommateurs) et l'anneau décrit (un producteur, un consommateur) sont dits distincts.
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
