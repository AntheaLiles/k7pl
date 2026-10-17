<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Note de décision — recherche d’assurance de conformité avec Lean

**État : décision de recherche proposée, au 17 octobre 2026.** Cette note synthétise le cadrage demandé par l’issue [#122](https://github.com/AntheaLiles/k7pl/issues/122). Elle ne ferme pas l’issue et n’autorise pas une porte de conformité en production. Les travaux de la [PR #229](https://github.com/AntheaLiles/k7pl/pull/229) restent expérimentaux et soumis à revue humaine.

## Décision

**GO conditionnel** pour un démonstrateur hybride, borné à la cohérence d’un inventaire de dépendances Lake, à la validation indépendante du document SPDX sérialisé et à l’interrogation séparée d’OSV-Scanner sur les révisions épinglées.

**NO-GO** pour une porte de conformité générale en production, une revendication de conformité légale, contractuelle ou réglementaire, une preuve de complétude universelle de la SBOM, ou une réimplémentation Lean du validateur SPDX ou du moteur de vulnérabilités. Compilation Lean réussie, validation SPDX positive et scan OSV sans avis ne suffisent pas à établir une affirmation générale.

## Cible d’assurance

La revendication admissible est la suivante : pour des octets d’entrée et une révision du dépôt identifiés, le démonstrateur vérifie certains invariants locaux de l’inventaire de paquets normalisé, contrôle sa correspondance avec le contrat K7PL déclaré, produit un document SPDX 2.3 à partir des seules entrées couvertes et conserve les résultats séparés des outils spécialisés exécutés sur ces artefacts.

Le contrôle Lean caractérise la relation entre `InventoryContract` et `verifyContract` sur la structure `AuditInput` déjà normalisée. Les théorèmes `verifyContract_sound`, `verifyContract_complete` et `verifyContract_iff_inventoryContract` établissent cette correspondance au niveau du modèle. Ils ne prouvent ni la fidélité du parseur JSON aux octets, ni que le générateur reflète toute la chaîne de dépendances, ni l’exactitude des assertions de licence, ni l’authenticité des dépôts amont.

## Représentations et responsabilités retenues

| Couche | Représentation / outil | Résultat admissible | Hors garantie |
|---|---|---|---|
| Entrées et révisions | `lake-manifest.json`, `lakefile.lean`, `lean-toolchain`, SHA-256 et révisions Git | Identifier les entrées effectivement lues et vérifier certains rapprochements locaux | Authenticité amont ou exhaustivité du graphe de dépendances |
| Invariants locaux | Types, prédicat `InventoryContract`, vérificateur booléen et théorèmes Lean | Cohérence logique des invariants sur `AuditInput` | Conversion fidèle des octets JSON, conformité globale |
| Document sérialisé | Générateur SPDX K7PL, précontrôles locaux ciblés, `spdx-tools` 0.8.5 verrouillé | Résultat du validateur pour un document précis et des octets précis | Complétude SBOM, vérité factuelle ou légale des métadonnées |
| Avis de vulnérabilités | Adaptateur Lake→OSV et OSV-Scanner externe | Avis renvoyés par l’outil et la base interrogée pour les révisions fournies | Absence de vulnérabilités non connues/indexées |
| Applicabilité et sign-off | Revue humaine et éléments probants versionnés | Décision responsable et traçable sur un périmètre déclaré | Décision automatique fondée uniquement sur « preuve absente » ou « build réussi » |

Le validateur SPDX externe reste responsable de sa validation spécialisée. Le précontrôle K7PL ne traite que des lacunes précisément identifiées : un nom de paquet vide que `spdx-tools 0.8.5` accepte dans le cas testé, et une propriété racine non déclarée alors que le schéma JSON SPDX 2.3 épinglé spécifie `additionalProperties: false`. Ce second garde est **limité à la racine** ; ce n’est pas une implémentation récursive du schéma. Les règles locales — notamment inventaire non vide et unicité de certaines relations — restent explicitement distinctes des exigences universelles SPDX.

## Comparaison des options

| Option | Décision | Motif |
|---|---|---|
| A — réimplémenter en Lean le parsing, tout le schéma SPDX, la sémantique des licences ou le matching de vulnérabilités | **NO-GO** | Surface normative large, duplication d’outils spécialisés et absence de preuve qu’une réimplémentation ferait mieux. Une preuve sur un modèle ne rend pas automatiquement le parsing ni les données vrais. |
| B — ne conserver que les sorties d’outils externes | **Insuffisant seul** | Donne des avis spécialisés, mais n’établit pas les invariants propres au profil K7PL ni la correspondance entre le prédicat formel et le vérificateur booléen. |
| C — modèle Lean limité + outils spécialisés + provenance + revue humaine | **Retenu** | Sépare les responsabilités et permet de démontrer des propriétés locales sans généraliser les conclusions. |

Syft/Grype/ORT, le fuzzing du parseur et le SAST Lean ne doivent être adoptés qu’après choix d’un artefact cible, d’un oracle, d’un corpus de référence et d’un critère de comparaison. Le contrôle déterministe par mutations n’est pas un fuzzer général. Les tests HTML/SVG ciblés ne sont pas une certification WCAG.

## Démonstrateur borné et preuves observées

Le démonstrateur produit un inventaire SPDX 2.3 à partir des 14 entrées de `lake-manifest.json`, conserve les révisions de commit, laisse les champs de licence inconnus à `NOASSERTION`, et compare le document sérialisé au validateur SPDX externe verrouillé. Les tests déterministes incluent des cas négatifs de manifeste, des révisions invalides, des noms vides/blancs, des références de relations, des mutations de propriétés JSON et des permutations bénignes. Le corpus négatif SPDX demeure exploratoire et non bloquant.

Le workflow complet [#39019317531](https://github.com/AntheaLiles/k7pl/actions/runs/39019317531) a terminé `success` sur la tête de PR `53bc52c44f662134f5ab41f986ea39b5db2c1ad2`. Son [artefact de validation indépendante](https://github.com/AntheaLiles/k7pl/actions/runs/39019317531/artifacts/12096385801) lie le contrôle à cette exécution et aux hashes d’entrées/outils ; `spdx-tools 0.8.5` accepte le document positif. Le rapport du corpus v2 enregistre 18 mutations structurées et deux entrées JSON brutes. Pour la propriété racine inconnue, le validateur externe renvoie `0` et le précontrôle K7PL rejette l’entrée avec `SPDX-PREFLIGHT-UNKNOWN-DOCUMENT-FIELD`. C’est une observation sur ce cas, pas une conclusion générale sur tous les défauts du validateur. Les cinq mesures de latence sont des répétitions sur un seul runner ; les trois exécutions CI complètes historiques du benchmark sont documentées dans la note d’assurance et les valeurs restent descriptives, non causales.

## Conditions restantes avant toute clôture

1. Revoir humainement l’interprétation des chaînes vides dans les champs de nom SPDX 2.3 et ratifier la frontière entre SPDX générique et profil local K7PL pour les relations dupliquées.
2. Garder les sondes négatives non bloquantes tant que chaque règle n’a pas d’oracle normatif qualifié.
3. Vérifier chaque nouvelle conclusion contre l’artefact lié au SHA exact du head concerné ; conserver codes d’erreur, diagnostics, hashes et versions effectives.
4. Examiner la PR et cette recommandation avant intégration. La PR ne modifie pas `spec/` ni `src/K7pl/` et ne doit pas être fusionnée sans autorisation explicite.

**Conclusion :** Lean apporte de la valeur pour prouver des invariants déclarés et leur vérificateur sur une représentation normalisée. Il ne remplace ni la validation des formats, ni les bases d’avis, ni l’établissement des faits, ni le jugement juridique ou la responsabilité humaine. L’issue #122 reste ouverte en attente de cette revue.
