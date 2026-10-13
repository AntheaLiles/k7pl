<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Relecture humaine des visualisations de preuves

Ce document trace les actions humaines qui ne peuvent pas être remplacées par la CI. Une extraction et un rendu réussis prouvent que les artefacts ont été produits et compilés ; ils ne prouvent pas que la visualisation est fidèle, lisible ou pédagogiquement utile.

## État des validations automatisées

- Pipeline natif Verso HTML + TeX et compilation PDF : réussi dans le run 38451997922 pour les cinq cibles du corpus.
- Extraction dans le workspace Paperproof épinglé sur Lean 4.34.0 : les journaux du même run confirment 2, 2, 5, 17 et 8 observations tactiques pour les cinq déclarations.
- Cette preuve est automatisée et porte sur l'arbre de fusion de test de la PR ; les inspections humaines des cinq vues web et PDF restent ouvertes.
- Contrôles Python, intégrité de la provenance, compilation Lean/Verso, validateurs de navigation et REUSE : couverts par CI ; consulter le run associé au commit exact avant d'enregistrer une validation.

## Contrôles humains à effectuer

- [ ] Comparer le texte de chaque tactique, les objectifs avant/après et les objectifs supplémentaires à la source Lean exacte.
- [ ] Pour les preuves à branches, confirmer que les objectifs et les noms de cas ne sont pas présentés comme équivalents lorsque l'export n'établit pas cette relation.
- [ ] Vérifier que les hypothèses affichées sont celles rapportées par l'export et ne sont pas interprétées comme un suivi complet de la portée lexicale.
- [ ] Ouvrir le site généré, naviguer au clavier sans souris, vérifier les disclosures d'hypothèses et contrôler la lisibilité à largeur mobile.
- [ ] Confirmer que le contenu essentiel reste compréhensible sans JavaScript et que les liens source pointent vers le fichier et la révision attendus.
- [ ] Inspecter toutes les pages PDF contenant les cinq vues après validation du commit étendu. Vérifier pagination, lignes longues, expressions de buts, hypothèses et continuité des branches.
- [ ] Consigner les étapes ambiguës, absentes ou trompeuses et la décision prise ; ne pas convertir silencieusement une absence de données en un état de preuve vide.

## Inspection initiale déjà effectuée

Sur l'artefact du run 38447082870 (trois vues), les pages PDF 297–298 ont été inspectées. Le contenu restait lisible, mais la ligne de métadonnées comprenant le SHA-256 et le toolchain était longue ; le renderer TeX a ensuite été ajusté pour séparer ces valeurs. Le paragraphe d'introduction indiquant Lean 4.29.0-rc8 a également été corrigé. Cette inspection antérieure ne valide pas les cinq vues produites par le run 38451997922 : elles doivent toutes être contrôlées sur les artefacts de ce run ou d'un run ultérieur.

## Critère de clôture

La relecture est complète seulement lorsque les cinq vues de la révision retenue ont été inspectées sur le web et dans le PDF, les réserves consignées, et les cas trompeurs corrigés ou explicitement documentés. Une case cochée par lecture de la CI seule ne compte pas comme inspection humaine.
