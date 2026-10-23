# Dossiers de recherche — K7PL et conception d’un OS

Dix dossiers autonomes (R0–R9) cadrent les recherches nécessaires pour évaluer les garanties d’un système d’exploitation envisagé en K7PL. Ils sont préparatoires : ils ne modifient pas implicitement la spécification normative et ne déclarent aucune garantie acquise.

| ID | Sujet | Priorité |
|---|---|---:|
| [R0](R0-modele-menace-matrice-assurance.md) | Modèle de menace et matrice d’assurance | P0 |
| [R1](R1-autorite-capacites-revocation-FFI.md) | Autorité, capacités et révocation FFI | P1 |
| [R2](R2-compilation-surete-source-binaire.md) | Correction de compilation source → binaire | P1 |
| [R3](R3-confidentialite-integrite-non-interference.md) | Confidentialité, intégrité et non-interférence | P1 |
| [R4](R4-concurrence-protocoles-vivacite-annulation.md) | Protocoles, vivacité et annulation | P2 |
| [R5](R5-memoire-emprunt-aliasing-logique-separation.md) | Permissions mémoire et logique de séparation | P2 |
| [R6](R6-grades-budgets-WCET-temps-reel.md) | Grades, budgets et WCET | P3 |
| [R7](R7-pannes-ressources-lineaires-persistance.md) | Pannes, ressources linéaires et persistance | P3 |
| [R8](R8-comparaison-systemes-exploitation.md) | Comparaison d’OS et d’architectures voisines | P2, parallèle |
| [R9](R9-model-checking-contre-exemples-tracabilite.md) | Model checking et traçabilité | P3, transversal |

## Ordre de lancement

Commencer par R0. R1, R2 et R3 peuvent ensuite progresser en parallèle ; R8 peut être lancé dès le départ. R4 et R5 approfondissent concurrence et mémoire. R6 et R7 dépendent du modèle d’exécution retenu. R9 soutient tous les chantiers sans remplacer les preuves Lean.

## Règles communes

- Revalider le SHA courant de main, les statuts et les sources avant chaque étude.
- Distinguer spécifié, formalisé, prouvé, implémenté, testé, mesuré et déployé.
- Un lien lexical entre identifiant normatif et déclaration Lean n’est pas une preuve de correspondance sémantique.
- Ne pas ajouter une coordonnée au grade simplement parce qu’une propriété manque : déterminer si le besoin relève du langage, des preuves de composition, du compilateur, du runtime, du noyau ou du matériel.
- Le tableau de bord du dépôt indique que l’étape C est ouverte. Ces recherches ne constituent pas une autorisation de démarrer les étapes aval.

Chaque rapport doit présenter sources primaires, date/version, hypothèses, résultats, limites, contre-exemples, obligations restantes et recommandations priorisées.

## Executed report — R2

- [R2 — Source-to-Binary Correctness and Zero-Overhead Assurance](R2-source-to-binary-correctness.md): source-grounded pipeline audit, semantic-preservation contract, TCB boundaries, and a staged performance-assurance plan. Non-normative.
