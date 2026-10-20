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

- `thm:deadlock_acyclique` (décision de l'autrice du 20 octobre 2026) : la conclusion « absence de blocage mutuel » est conservée, et la simulation du graphe d'attente par le graphe de dépendances statique devient une prémisse explicite de l'énoncé, notée (Sim). L'argument par le typage de `Guard` reste la route pour la décharger. La prose qui suit dit que, tant que (Sim) n'est pas démontrée, la Phase 1.5 n'établit que l'acyclicité du graphe statique ; le chapitre 4 dit que K7PL « énonce » l'absence de blocage sous cette simulation (ligne 22 de la liste « Lot 0 »). La PR #246 affaiblissait la conclusion en un graphe d'attente acyclique : ce choix n'est pas repris.
- `thm:rejeu_binaire` (décision de l'autrice du 20 octobre 2026, option (a)) : la prémisse d'injectivité de la représentation est remplacée par son invariance `H_repr` — deux états atteignables observationnellement égaux ont la même représentation sous `Π` —, comme le proposait la PR #246. La conclusion est inchangée ; l'esquisse et la note suivent.
- `thm:stabilisation_pipeline` (décision de l'autrice du 20 octobre 2026) : les prémisses opérationnelles entrent dans l'énoncé — terminaison de chaque tour, consommation du budget de spécialisation par tout tour qui modifie le terme, budget fini qui ne croît jamais, reconnaissance d'un tour sans changement comme point fixe —, comme le proposait la PR #246. La prose qui suit (« Cette itération termine ») devient conditionnelle.
- `thm:schema_commutation` (décision de l'autrice du 20 octobre 2026) : l'énoncé suppose la compatibilité de chaque clause de la transformation avec la substitution, hypothèse proposée par la PR #246 ; les obligations restent à chaque instance.
- Effets dans la traduction vers le métalangage (décision de l'autrice du 20 octobre 2026) : l'esquisse et la note de `thm:traduction_metalangage`, la lecture de l'effacement, la réserve qui clôt le calcul de processus et l'ouverture du système de raffinement (chapitre 2) suivent le choix du texte — une opération à effet devient une communication sur un canal distingué — au lieu de dire que la composante `𝓔` n'a pas de contrepartie. L'énoncé est inchangé et n'est pas restreint au code sans effet, contrairement à la PR #246.
- Page « Artefacts exécutables expérimentaux » (`experimental-code-artifacts`) : les blocs de code K sont déclarés normatifs (décision de l'autrice du 19 octobre 2026 : « les codeblocs K dans les fichiers Verso sont normatifs ») ; le script Python de vérification reste un outil de vérification, non normatif. Les blocs de code, leur extraction et l'étiquette de la page sont inchangés.
- Figures : les neuf figures encore dessinées dans draw.io sont redessinées en TikZ (décision de l'autrice du 13 octobre 2026 : toutes les figures d'illustration sont codées en TikZ). Contenu, légendes, textes alternatifs et descriptions sont inchangés ; le style suit les trois figures TikZ existantes. Les PDF et SVG sont désormais générés pour les douze figures.
- `thm:raffinement` est scindé (décision de l'autrice du 12 octobre 2026) : le théorème garde la construction du système de raffinement ; ses trois lectures deviennent les corollaires `thm:raffinement_effacement`, `thm:raffinement_non_interference` et `thm:raffinement_precision`, chacun avec ses prémisses. Aucun état épistémique n'est promu ; la numérotation affichée des énoncés suivants change.
- `thm:schema_reinvocation` : le domaine de `n` est `ℕ∞`, avec un traitement explicite de `ω` (décision de l'autrice du 12 octobre 2026). Le cas fini reste la ré-invocation séquentielle bornée ; l'exigence de compatibilité nomme le cas `ω` comme obligation distincte.

### Corrigé

- Statuts annoncés, repris de la PR #246 et refaits depuis `main` (décision de l'autrice du 20 octobre 2026) : le guide de lecture ne tient plus un énoncé sans marqueur pour une conséquence de ce qui précède, et l'introduction du chapitre 1 pose une exigence de rédaction au lieu d'affirmer qu'aucune affirmation ne figure sans appui établi.
- Chapitre 2 : les trois paragraphes d'ouverture, qui annonçaient la suite et le résultat du système de raffinement, sont retirés ; le chapitre s'ouvre sur sa première section (décision de l'autrice du 20 octobre 2026). Les six schémas de métathéorie y sont « énoncés » une fois pour toutes, et non « démontrés » (ligne 1 de la liste « Lot 0 »).
- Chapitre 5 : le critère de l'interface des macros n'est plus dit « rempli » tant que la règle `Expand` n'est pas alignée sur le lemme de substitution, et les conséquences du théorème d'élaboration sont conditionnelles à ses conditions et aux obligations de chaque instance (reprise de la PR #246, sans sa nouvelle affirmation sur la défonctionnalisation).
- Chapitre 6 : la mécanisation du suivi d'emprunts « serait » à transposer, et que la transposition tienne reste à établir.
- Chapitre 7 : l'ouverture compte trois études de cas et ne dit plus que chaque pièce est fondée ; l'étude I dit que la productivité ne borne pas la latence par image et que l'égalité des condensats BLAKE3 suppose une représentation canonique et la résistance aux collisions ; l'étude II limite « aucun outil supplémentaire » aux deux usages qu'elle examine (reprise partielle de la PR #246).
- Vocabulaire de preuve aligné sur l'état enregistré des énoncés (mandat de l'autrice du 19 octobre 2026, liste « Lot 0 » de la méta-revue PR-03) : dans 22 des 27 passages relevés, « démontré », « établi » ou « prouvé » deviennent « esquissé », « conjecturé », « énoncé » ou « à établir » lorsque l'énoncé visé est en revue ou proposé. Aucun énoncé, label, hypothèse, métadonnée ni étiquette de section ne change. Les cinq passages restants attendent une décision (`thm:progres`, absence de blocage) ou la vérification d'une attribution bibliographique.
- Vocabulaire de preuve, suite (extension du mandat B-01 approuvée par l'autrice le 20 octobre 2026) : huit passages hors de la liste « Lot 0 », quatre voisins de passages déjà corrigés et quatre relevés par les revues longitudinales, ne disent plus « établit », « démontrées », « la preuve est au », « déjà payé » ni « acquise par un résultat » d'un énoncé en revue ou proposé, ou d'un argument en prose ; ils disent « énonce », « esquissées », « doit établir », « la preuve est due au », « déjà engagé » ou « repose sur un énoncé ». Aucun énoncé, label, hypothèse, métadonnée ni étiquette de section ne change.
- Terminologie (instruction de l'autrice du 20 octobre 2026 : ne pas confondre fibre, fibrille et cofibre) : au chapitre 3, l'unité d'exécution qui ne peut observer d'état intermédiaire d'une mutation en place est une « fibrille », et non une « fibre ». Au chapitre 2, « cofibre » signifiait _cofree_ et s'écrit désormais ainsi, en italique (réponse de l'autrice du même jour) : le comonoïde cocommutatif _cofree_ d'une exponentielle libre, en deux endroits.
- Figures : quatre textes alternatifs décrivent désormais ce que montre le dessin (décision de l'autrice du 19 octobre 2026 : « le dessin fait toujours foi et l'alt-text doit correspondre au dessin ») : `fig:rexp-complexite` (une chaîne de trois classes, et non trois niveaux emboîtés), `fig:session-dualite` (deux flèches horizontales de sens opposés, et non deux flèches croisées), `fig:dualite-algebre-coalgebre` (double flèche en pointillés ; `in` et `out` sont des isomorphismes), `fig:acteur-cycle-de-vie` (point initial vers Désactivé). Dessins, descriptions et étiquettes sont inchangés. La légende de `fig:circuit-breaker` dit désormais « fibrille », comme le dessin, la description et le glossaire, et non « fibre » : fibre, fibrille et cofibrille sont trois notions distinctes.
- `thm:sedimentation` : l'énoncé, tronqué lors de sa séparation en un résultat de littérature et une exigence, dit désormais qu'il vaut pour des conteneurs non gradués et renvoie à l'exigence graduée.

- Le texte placé hors des emplacements nommés d'un bloc d'énoncé n'était pas rendu, en HTML comme en PDF. Cinq blocs sont rétablis sans changement de texte : `thm:schema_reinvocation`, `req:schema_reinvocation_compatibility`, `req:homomorphisme_roues_realisation`, `thm:expansion_macro` et `thm:temps_mononiveau` (ligne parasite supprimée). Le contrôle d'ontologie des énoncés rejette désormais ce cas.

### Ajouté

- Chapitre 4 : l'introduction s'ouvre sur la définition de l'autrice (décision 52) : « Toute fonction ou groupe de fonctions mis en production est un automate. » Elle n'annonce ni la structure du chapitre ni les automates que crée chaque couche.
- Page « Visualisations de preuves » (`Spec.ProofVisualizations`, `1f16d55`) : observations dérivées de Paperproof pour cinq preuves Lean sélectionnées, extraites dans un espace Lake isolé et rendues en HTML et en TeX ; mise en page par transitions (#221). Ce sont des observations non normatives : ni preuve indépendante, ni correspondance établie avec un énoncé du manuscrit.
- Chapitre 3 (règles de typage) : un noyau Lean exécutable d'un fragment projeté des règles C3 est déclaré dans la source Verso (`805498e`), puis compilé et audité comme module racine `Spec.C3.EffectiveKernel` (`ee0d05a`, #183). Les règles absentes de ce fragment restent non formalisées.
- Chapitre 2, section « Six schémas de métathéorie » : six blocs portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 01). Ni énoncé, ni esquisse, ni état épistémique ne change ; le détail est tenu dans `docs/tracking/LEAN-STATEMENT-MIGRATION.md`.
- Chapitre 2 (système de raffinement ; algèbres, coalgèbres et points fixes) et chapitre 4 (calcul de processus sous-jacent) : six blocs portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 02), dont `thm:raffinement`, `thm:non_interference` et `thm:traduction_metalangage`. Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 4 (sémantique opérationnelle) : `thm:preservation`, `thm:progres` et `thm:correction_ressource` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 03). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 4 (sémantique opérationnelle) : `thm:stratification_journal` et `thm:relation_produit` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 04). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitres 2 et 4 : `thm:commutation_traduction`, `thm:image_fix` et `thm:terminaison_lfp` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 05). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 4 (système de sortes du métalangage) : `thm:cloture_sortage` et `thm:confinement_sortes` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 06). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 4 (calcul de processus sous-jacent) : `thm:simulation` et `thm:fidelite_interprete` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 07). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 3 : `thm:deadlock_acyclique` et `thm:determinisme_parallele` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 08). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 2 (comonade exponentielle et fragments) : `thm:distributivite_tronquee`, `thm:coherence_axiome` et `thm:coherence_usage` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 09). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitre 3 : `thm:temps_mononiveau`, `thm:morphismes_modes` et `thm:boxtimes_addition` portent une note « Obligation ouverte » issue de la revue sémantique C8 (lot 10). Ni énoncé, ni esquisse, ni état épistémique ne change.
- Chapitres 2 à 6 : les 37 blocs couverts par le lot 11 de la revue sémantique C8 portent une note « Obligation ouverte ». Ni énoncé, ni esquisse, ni état épistémique ne change.

## [0.0.0-alpha.2]

### Modifié

- Quatre sceaux de preuve sont rétrogradés explicitement au statut `proposition` (`thm:coherence_axiome`, `thm:action_parallele`, `thm:morphismes_modes`, `thm:substitution`) ; le résultat `thm:coherence_usage` est introduit comme proposition distincte pour la loi d'action d'usage.

- L'index (§8.7) contient les trente et un termes du manuscrit et leur liste canonique est portée par `tools/SpecExt/IndexTerms.lean`. La génération reconnaît ces termes dans le texte ; les pages du PDF et l'interface HTML restent des points distincts de l'indexation (`ANOM-09`, `ANOM-10`).

- L'annexe E (présentation formelle) est fondue dans le manuscrit : grammaires et règles de typage au chapitre 3, sémantique opérationnelle et sortes du métalangage au chapitre 4, table des glyphes au chapitre 1. Les annexes B, C et D sont ensuite retirées du document ; `tooling/prototypes-bcd/` en conserve des prototypes Lean (`d84021f`). Seule l'annexe A reste dans la spécification.
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
