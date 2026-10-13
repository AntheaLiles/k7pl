<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Registre de couverture des visualisations de preuves

État du registre : 2026-10-13. Ce document décrit ce que le prototype implémente et ce que les tests établissent ; il ne transforme pas une fonctionnalité plausible de Paperproof en garantie K7PL.

## Échelle de statut

- **Pris en charge** : la propriété est présente dans le contrat et démontrée par un test représentatif.
- **Partiel** : certaines données sont conservées ou rendues, mais la chaîne de bout en bout ou une dimension essentielle n'est pas validée.
- **Identifié mais non représenté** : la construction est présente dans le corpus ou reconnue comme besoin, sans représentation dédiée validée.
- **Non pris en charge** : le modèle actuel n'a pas de représentation pour cette famille.
- **Non évalué** : l'absence de test ou de cas source ne permet pas de conclure.

Une vérification lexicale des fichiers n'est pas un analyseur Lean : elle repère des candidats à la couverture, mais peut aussi trouver des occurrences dans les commentaires ou chaînes. Le statut « observé » doit être confirmé par inspection du code et, pour la couverture du générateur, par une extraction réelle.

## Corpus d'amorçage

L'inventaire initial porte sur les modules Lean de src/ et les tests Lean de tests/ présents dans le dépôt. Les principales familles tactiques repérées dans les sources comprennent intro, exact, apply, refine, constructor, cases, induction, rw, simp, rfl, change, subst, have, funext, ext, rcases, omega, by_cases et decide. Cette liste est indicative et n'est pas une mesure quantitative de couverture.

Les trois cibles sélectionnées sont des déclarations réelles ; leurs sélections éditoriales ne constituent pas un lien normatif inféré :

| Déclaration | Forme et comportements ciblés | Statut du générateur | Limite explicite |
|---|---|---|---|
| K7pl.Arith.eval_double | Preuve par tactiques, simp, ring | Partiel : cible configurée ; extraction end-to-end à confirmer après correction du chemin d'entrée | Le build K7PL sous Lean 4.34.0 et l'extraction Paperproof sous Lean 4.29.0-rc8 sont deux contrôles distincts |
| K7pl.UsageScale.scaleUsage_comp | cases, simp, contexte de variables paramétriques | Partiel : cible configurée ; extraction end-to-end à confirmer après correction du chemin d'entrée | Une sortie du parseur ne démontre pas la fidélité sémantique de toutes les transitions |
| K7pl.UsageScale.projectUsageContext_scale | funext, cases, hypothèses de cas, simp | Partiel : cible configurée ; extraction end-to-end à confirmer après correction du chemin d'entrée | La disponibilité des hypothèses est celle rapportée par l'exporteur, pas une reconstruction complète des portées lexicales |

## Couverture par dimension

| Dimension / famille | Statut | Données ou tests présents | Informations perdues, reconstruites ou non établies |
|---|---|---|---|
| Reconnaissance des trois déclarations ciblées | Partiel | Liste de cibles explicite ; contrôle de ligne de déclaration et provenance dans le contrat JSON | La compatibilité de chaque cible n'est pas démontrée tant que l'extraction réelle n'a pas réussi sous le workspace isolé |
| Séquences de tactiques « by » | Partiel | Modèle steps, chaîne de tactique, position, état avant/après ; tests de schéma synthétiques | L'extraction n'emploie pas Lean 4.34.0 et n'est pas encore un adaptateur natif sur l'InfoTree de cette version |
| simp, cases, funext, ring dans les cibles sélectionnées | Partiel | Présence dans les scripts sélectionnés ; tests de rendu synthétiques | Les effets observés sur les objectifs réels ne sont pas prouvés par des fixtures Python |
| intro, exact, apply, refine, constructor, induction, rw, rfl, change, subst, have, ext, rcases, omega, by_cases, decide | Identifié mais non représenté dans un corpus de tests propre à chaque famille | Plusieurs familles sont présentes dans les modules et/ou tests actuels ; le schéma ne maintient pas de registre de capacité par tactique | Aucune prise en charge universelle n'est revendiquée ; la reconnaissance, l'observation de l'effet et l'explication sémantique sont des capacités distinctes |
| Objectifs avant/après et objectifs créés | Partiel | Champs goalBefore, goalsAfter, spawnedGoals ; test Python synthétique de branchement | Sémantique et association des branches non comparées à un corpus extrait et inspecté |
| Hypothèses affichées dans un objectif | Partiel | Le rendu lit les champs hyps et échappe leur texte ; test synthétique d'échappement | Pas de suivi formel de l'introduction, de la suppression ou de la dépendance des hypothèses entre transitions |
| Contextes de tactique, objectifs multiples et blocs case | Partiel | Le JSON peut préserver les listes d'objectifs/hypothèses exposées par Paperproof | Pas de modèle explicite de contexte lexical, de foyer de tactique ou de sémantique des branches ; tests synthétiques seulement |
| Variables de section, lieurs lexicaux et portées imbriquées | Identifié mais non représenté | Besoin repéré à partir des modules paramétriques et contextes de preuve | Le prototype ne distingue pas contexte d'élaboration, contexte de tactique et portée lexicale |
| Preuves par termes, termes élaborés et sous-preuves locales | Identifié mais non représenté | Famille identifiée dans le plan de développement | Le prototype rend des traces de tactiques ; il n'expose pas un arbre de terme élaboré ou ses annotations |
| Blocs structurés calc | Non évalué | Aucun cas de test ciblé et aucun cas confirmé dans l'inventaire lexical initial | L'absence de cas repéré ne prouve ni l'absence de calc dans tout le dépôt ni son incompatibilité |
| Définitions, expressions et types inductifs | Non pris en charge | Pas de modèle ou de rendu dédié dans le prototype actuel | Arbre de terme, type inductif et trace tactique doivent rester des vues distinctes |
| Dépendances entre déclarations | Non pris en charge par ce générateur | Aucun graphe de dépendances produit par les vues de preuve | Ne pas confondre dépendance entre déclarations, utilisation de théorèmes dans une tactique, ni progression des objectifs |
| Inconnues et export incomplet | Partiel | Validation du JSON ; le générateur refuse les étapes absentes ou les localisations mal formées | Pas encore de classification explicite par famille de tactique ; une sortie non conforme échoue au lieu d'inventer un résultat |
| Provenance, révision et empreinte source | Partiel | Commit, chemin canonique, URL ancrée, empreinte SHA-256 et versions consignés ; test de révision obsolète | L'empreinte prouve l'identité du contenu haché, pas la correspondance entre le contenu et un objet de spécification |
| Sortie web | Partiel | Prototype HTML statique, échappement et contrôle de liens ; tests unitaires Python | Le HTML est encore produit après Verso et le lien injecté dans la navigation ne constitue pas une extension Verso native |
| Sortie PDF issue du même modèle | Non pris en charge actuellement | Le site Verso génère déjà du HTML et du TeX, mais aucune extension de preuve ne consomme les artefacts JSON | Les vues actuelles n'apparaissent pas dans le document TeX/PDF ; c'est un bloqueur architectural pour l'acceptation finale |
| Intégration à la compilation Verso | Non pris en charge actuellement | L'étape du prototype intervient après le rendu Verso et modifie une page HTML générée | Il faut une extension de contenu Verso avec rendu HTML et TeX à partir du même artefact |
| Extraction native Lean 4.34.0 | Non évalué | La compilation K7PL racine utilise Lean 4.34.0 ; l'exporteur Paperproof est verrouillé sur Lean 4.29.0-rc8 | La compilation racine ne valide pas l'extracteur ; la compatibilité source sous l'ancienne version est à établir cible par cible |

## Interprétation des preuves disponibles

Les tests Python actuels établissent des propriétés du validateur de données et du rendu HTML sur des fixtures synthétiques. Ils ne valident pas les effets des tactiques sur des objectifs réels. Le workflow racine compile K7PL sous Lean 4.34.0, mais ne prouve pas qu'un autre workspace extrait fidèlement les mêmes sources. Enfin, une page HTML et un lien de navigation ajoutés après la compilation ne démontrent pas une intégration Verso.

## Prochain seuil de validation

Le prochain résultat CI doit établir successivement : (1) l'extraction réelle des trois cibles, (2) la validation du contrat JSON et de la provenance, puis (3) la production documentaire. La réussite de cette étape ne suffira toujours pas à déclarer le générateur achevé : il faudra intégrer les artefacts à une extension Verso commune aux sorties HTML et TeX, puis ajouter des cas représentatifs pour les autres familles du corpus.
