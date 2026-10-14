<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Registre de couverture des visualisations de preuves

État : 2026-10-14. Le registre décrit ce que le prototype implémente et ce que les tests établissent. Il ne déduit pas de garantie à partir d'une syntaxe simplement présente dans un fichier. Le run CI [38457573950](https://github.com/AntheaLiles/k7pl/actions/runs/38457573950) valide l'ancienne sortie en liste verticale. Le rendu structuré de cette branche et ses tests de structure doivent être validés par un nouveau run avant d'être considérés comme compilés.

## Échelle de statut

- **Validé sur les cibles sélectionnées** : extraction réelle et rendu HTML/TeX passés pour cette déclaration dans une exécution CI identifiée.
- **En validation CI** : cible ajoutée au corpus et soumise au pipeline, sans résultat encore établi pour le commit qui l'ajoute.
- **Partiel** : information conservée mais une dimension sémantique, un rendu ou un test de régression manque.
- **Identifié mais non représenté** : besoin ou construction repérée, sans représentation dédiée validée.
- **Non évalué** : l'absence de cas ciblé ne permet pas de conclure.

Une recherche lexicale n'est pas un analyseur Lean : elle peut compter des commentaires, des chaînes ou de la syntaxe non exécutable. La présence d'un nom de tactique n'est donc pas une preuve de sa prise en charge.

## Corpus et preuves de validation

Le run CI 38457573950 valide l'extraction Paperproof pour cinq cibles sous Lean 4.34.0, la compilation Verso HTML/TeX, la génération du PDF, les contrôles de navigation et le résultat global. Les journaux antérieurs (run 38451997922) rapportent respectivement 2, 2, 5, 17 et 8 observations tactiques. Ces runs ne valident pas le nouveau rendu responsive de cette branche ; ils ne constituent ni une validation humaine ni une garantie générale de couverture.

| Déclaration canonique | Comportements ciblés | Statut dans le corpus courant | Limite explicite |
|---|---|---|---|
| K7pl.Arith.eval_double | by, simp, ring | Validé sur les cibles sélectionnées | Ne garantit pas l'explication sémantique de toute simplification |
| K7pl.UsageScale.scaleUsage_comp | cases, simp, contexte paramétrique | Validé sur les cibles sélectionnées | Une sortie d'extracteur ne prouve pas que chaque lien de branche est interprété correctement |
| K7pl.UsageScale.projectUsageContext_scale | funext, cases, objectifs de cas, simp | Validé sur les cibles sélectionnées | La liste d'hypothèses rapportée n'est pas un modèle exhaustif de toutes les portées lexicales |
| K7pl.GradeBudget.finite_multiplicity_compatibility | cases imbriqués, have, simp, objectifs dépendant des cas | Validé sur les cibles sélectionnées | 17 observations tactiques extraites ; l'association sémantique des branches reste à inspecter |
| K7pl.MemoryCapability.allocate_preserves_unique | intro, by_cases, subst, have, simp, omega | Validé sur les cibles sélectionnées | 8 observations tactiques extraites ; la présence ne démontre pas la couverture générale de toutes leurs formes |

## Couverture par dimension

| Dimension / famille | Statut | Données présentes et tests | Lacunes connues |
|---|---|---|---|
| Identité de déclaration, chemin source, révision, lignes, SHA-256 | Partiel mais testé | JSON versionné, manifeste, liens Git ancrés, contrôle de révision côté Verso et vérification Python que --ref correspond à HEAD ; tests négatifs de provenance/positions | La provenance identifie l'entrée et la révision ; elle n'établit pas de correspondance normative et la fidélité sémantique reste hors contrat |
| Séquences de tactiques by | Partiel | steps, tacticString, position, goalBefore, goalsAfter, spawnedGoals ; export réel sur les cibles validées | Pas de garantie pour toutes les constructions de preuve, ni pour toutes les tactiques d'une famille |
| simp, ring, cases, funext | Validé sur au moins une cible chacun | Présents dans des exportations réelles des trois premières cibles | La validation d'un exemple ne vaut pas validation de toutes les options, macros ou cas limites |
| intro, by_cases, subst, have, omega | Observé dans une cible extraite réelle ; couverture de famille partielle | Famille ciblée par allocate_preserves_unique | Une seule preuve par famille ne garantit pas le traitement de toutes les variantes ou macros |
| apply, refine, constructor, induction, rw, rfl, change, ext, rcases, decide | Identifié dans le corpus / couverture dédiée incomplète | Plusieurs formes sont présentes ailleurs dans les sources Lean actuelles | Pas de test d'extraction et de rendu propre à chaque famille |
| Objectifs avant/après et objectifs créés | Partiel | Les champs d'export sont conservés ; cas synthétique de branchement en test Python ; les premières cibles sont extraites réellement | La sémantique et l'appariement des branches ne sont pas validés pour toutes les formes de preuve |
| Identifiants de dépendance d’une tactique | Partiel | `tacticDependsOn` est validé et conservé ; HTML et TeX rapprochent les identifiants par égalité exacte avec les identifiants d’hypothèses présents dans les instantanés de buts de la même transition ; les identifiants non résolus restent visibles comme tels | Il s’agit de dépendances locales rapportées par Paperproof, pas d’un graphe de dépendance entre déclarations ni d’une preuve sémantique d’utilisation ; l’inspection visuelle reste nécessaire |
| Hypothèses et contextes locaux | Partiel | L'export conserve les hypothèses rapportées pour chaque état ; le renderer les affiche sans JavaScript | Aucun modèle dédié du contexte lexical, des sections, du foyer de tactique ou des changements de portée indépendants des buts |
| Blocs case, branches imbriquées et objectifs multiples | Partiel | Représentation de goalsAfter et spawnedGoals ; extraction réelle de cas imbriqués sur les cinq cibles dans le run 38451997922 | Un objectif créé et une branche syntaxique ne sont pas des notions équivalentes ; inspecter la correspondance réelle |
| Preuves par termes, calc, sous-preuves locales | Identifié mais non représenté | Familles à inventorier explicitement | Pas d'arbre de terme élaboré ni d'explication dédiée pour ces formes |
| Définitions, expressions et types inductifs | Non pris en charge par cette vue | Aucun modèle ou rendu spécialisé dans le générateur de traces tactiques | À concevoir comme vues séparées, et non comme faux arbres tactiques |
| Dépendances entre déclarations | Non pris en charge par ce générateur | Le graphe de navigation existant n'est pas utilisé pour inférer ici des dépendances de preuve | Ne pas confondre dépendance entre déclarations, théorèmes employés et transitions d'objectifs |
| Export inconnu ou incomplet | Partiel | L'extracteur échoue sur erreur ; validateur JSON refuse les étapes/localisations requises manquantes ; test négatif | La classification est par contrat de données, pas encore par famille de syntaxe/tactique |
| Sortie HTML Verso | Intégrée ; refonte responsive en attente de CI | Block extension Verso, même artefact JSON ; cette branche ajoute des panneaux objectif-avant → objectifs-après, styles de contexte et provenance repliable ; tests source-level ajoutés | Le run 38457573950 ne valide que l'ancien empilement vertical ; aucune arête entre branches n'est reconstruite à partir de spawnedGoals ; compilation du nouveau markup et inspection humaine restent requises |
| Sortie TeX/PDF Verso | Intégrée et compilée en CI pour la sortie précédente | Même JSON et même manifeste, sortie TeX dédiée ; PDF produit lors du run 38457573950 | La refonte actuelle concerne le renderer HTML ; inspection humaine du PDF et évolution de la composition TeX restent à faire |
| Contrat structurel du renderer HTML | Partiel, tests source-level ajoutés dans cette branche ; CI en attente | Assertions vérifiant la présence des zones avant/après, la séparation de spawnedGoals, le layout responsive, le mode sombre et le contenu statique | Ces tests vérifient des chaînes dans le code source, non le DOM rendu, les captures d'écran, les styles calculés ou le sens des transitions |\n| JavaScript | Non requis pour le contenu essentiel | Le bloc utilise HTML structuré/CSS et informations lisibles directement ; HTML sans dépendance de rendu JavaScript | Les améliorations d'interaction ne doivent pas cacher l'état essentiel |
| Conformité SPDX/REUSE | Validée par CI sur le premier incrément natif | Code de l'adaptateur et extension sous Apache-2.0, texte LICENSES/Apache-2.0.txt ; REUSE passe | Refaire la validation automatiquement après l'extension du corpus |

## Ce que les tests établissent

Le run 38457573950 établit pour les cinq cibles le build Lean racine, l'extraction Paperproof sous Lean 4.34.0, le rendu HTML/TeX via Verso, la génération PDF, les contrôles de navigation et REUSE pour la version précédente de la vue. Les tests Python offline utilisent des exports synthétiques pour tester le contrat de données, les positions source, la provenance, les identifiants de dépendance et le nettoyage de la copie temporaire ; ils ne remplacent pas l'extraction réelle.

Cette branche ajoute trois tests source-level de la structure HTML/CSS prévue. Ils ne compilent pas Verso et ne confirment ni le DOM final, ni le CSS calculé, ni la lisibilité. Le nouveau commit doit passer l'extraction/compilation/PDF dans CI ; puis l'inspection humaine doit comparer la vue à la source Lean. Le contrôle de provenance (HEAD correspondant à --ref et bornes de positions) réduit les liens trompeurs sans valider la sémantique des transitions. La généralisation à toutes les familles de tactiques reste non établie.

## Validation humaine nécessaire

Consulter les artefacts CI, comparer chaque transition au script Lean source et consigner les branches trompeuses ou omises. Inspecter le site avec clavier et largeur mobile, puis les pages PDF contenant les cinq vues. La réussite CI n'établit ni l'utilité pédagogique ni l'absence de surcharge visuelle.
