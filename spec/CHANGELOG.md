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

- `thm:raffinement` est scindé (décision de l'autrice du 12 octobre 2026) : le théorème garde la construction du système de raffinement ; ses trois lectures deviennent les corollaires `thm:raffinement_effacement`, `thm:raffinement_non_interference` et `thm:raffinement_precision`, chacun avec ses prémisses. Aucun état épistémique n'est promu ; la numérotation affichée des énoncés suivants change.
- `thm:schema_reinvocation` : le domaine de `n` est `ℕ∞`, avec un traitement explicite de `ω` (décision de l'autrice du 12 octobre 2026). Le cas fini reste la ré-invocation séquentielle bornée ; l'exigence de compatibilité nomme le cas `ω` comme obligation distincte.

### Corrigé

- `thm:sedimentation` : l'énoncé, tronqué lors de sa séparation en un résultat de littérature et une exigence, dit désormais qu'il vaut pour des conteneurs non gradués et renvoie à l'exigence graduée.

- Le texte placé hors des emplacements nommés d'un bloc d'énoncé n'était pas rendu, en HTML comme en PDF. Cinq blocs sont rétablis sans changement de texte : `thm:schema_reinvocation`, `req:schema_reinvocation_compatibility`, `req:homomorphisme_roues_realisation`, `thm:expansion_macro` et `thm:temps_mononiveau` (ligne parasite supprimée). Le contrôle d'ontologie des énoncés rejette désormais ce cas.

### Ajouté

- Chapitre 2, section « Six schémas de métathéorie » : six blocs portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 01). Ni énoncé, ni esquisse, ni état épistémique ne change ; le détail est tenu dans `docs/tracking/LEAN-STATEMENT-MIGRATION.md`.
- Chapitre 2 (système de raffinement ; algèbres, coalgèbres et points fixes) et chapitre 4 (calcul de processus sous-jacent) : six blocs portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 02), dont `thm:raffinement`, `thm:non_interference` et `thm:traduction_metalangage`. Ni énoncé, ni esquisse, ni état épistémique ne change.

## [0.0.0-alpha.2]

### Modifié

- Quatre sceaux de preuve sont rétrogradés explicitement au statut `proposition` (`thm:coherence_axiome`, `thm:action_parallele`, `thm:morphismes_modes`, `thm:substitution`) ; le résultat `thm:coherence_usage` est introduit comme proposition distincte pour la loi d'action d'usage.

- L'index (§8.7) contient les trente et un termes du manuscrit et leur liste canonique est portée par `tools/SpecExt/IndexTerms.lean`. La génération reconnaît ces termes dans le texte ; les pages du PDF et l'interface HTML restent des points distincts de l'indexation (`ANOM-09`, `ANOM-10`).

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

- Anomalies corrigées : lettres d'annexes écrites en dur remplacées par des renvois ; étiquettes d'annexes sans lettre ; en-tête et colonne « Route » du tableau des engagements ; trois couches rétablies au glossaire ; étiquette `fig:comp-process` ; commentaires d'auteur retirés du texte (`docs/research/commentaires-du-manuscrit.md`).

- Les chapitres d'exemple (`Introduction`, `Expressions`) sont remplacés par le manuscrit.
- Titre aligné sur la spécification Org-mode : « K7PL : KonSept Programming Language ».
