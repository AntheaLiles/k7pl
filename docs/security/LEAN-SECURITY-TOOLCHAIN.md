<!--
SPDX-FileCopyrightText: 2026 Cyprien PIERRE
SPDX-License-Identifier: CC-BY-4.0
-->

# Programme de sécurité outillée en Lean 4

Ce document est une proposition d'architecture et de séquencement. Il ne déclare aucun outil réimplémenté, aucune preuve achevée, aucune couverture de vulnérabilités ni aucune SBOM publiée.

## 1. Intention et limites de l'assurance

L'objectif est de construire des outils de sécurité réutilisables autour de Lean 4, en privilégiant les petits noyaux dont les propriétés peuvent être spécifiées et démontrées. Le langage de preuve ne rend pas automatiquement l'ensemble de la chaîne sûr : il permet de prouver des propriétés du code Lean vérifié, sous les hypothèses explicites du noyau de preuve et de la compilation utilisée.

Il faut distinguer les garanties suivantes :

1. **Correction interne** : propriétés démontrées sur les modèles, algorithmes, normaliseurs, règles de décision et sérialiseurs Lean.
2. **Fidélité des adaptateurs** : tests différentiels et preuves de conservation des données entre un format source (par exemple `lake-manifest.json`) et le modèle interne.
3. **Qualité des sources externes** : fraîcheur et couverture d'OSV, des bases de Grype ou des métadonnées de licence d'ORT. Elles restent des hypothèses externes ; un résultat vide ne prouve pas l'absence de vulnérabilités.
4. **Assurance de la chaîne d'exécution** : versions, empreintes, permissions CI, provenance des artefacts et reproductibilité. Une preuve Lean ne remplace pas ces contrôles opérationnels.

Les rapports devront annoncer précisément le périmètre testé, les hypothèses, les données ignorées et les propriétés prouvées. Ne pas employer « sécurité prouvée » sans qualifier la revendication.

## 2. Architecture cible

### 2.1 Noyau de données indépendant des formats

Définir en Lean un modèle intermédiaire explicite, versionné et sans dépendance à un scanner particulier :

- identité du composant : nom, écosystème, URL de source, révision exacte, version déclarée, identifiants externes éventuels ;
- intégrité : algorithmes et empreintes effectivement calculées, en distinguant une empreinte observée d'une empreinte déclarée ;
- relations : dépendances directes/transitives, composant parent, dépendances de construction et de développement lorsqu'elles sont connues ;
- provenance : fichier d'entrée, chemin d'origine, outil et version ayant produit l'observation ;
- licences : déclarations de licence, fichiers de licence observés et incertitudes, sans inférer une compatibilité juridique à partir d'une simple étiquette ;
- résultats d'analyse : identifiant d'avis, source, horodatage, statut, sévérité si fournie, et lien vers la preuve externe.

Les champs inconnus doivent rester inconnus, et non recevoir une valeur par défaut qui donnerait l'illusion d'une connaissance. Le modèle doit distinguer « absent », « non applicable », « non analysé » et « inconnu ». Les relations de dépendance et la complétude de l'inventaire doivent pouvoir être marquées comme partielles.

### 2.2 Adaptateurs et moteurs

- **Lake** : parser le manifeste, valider les URL et les révisions, produire un graphe typé, et vérifier la conservation des 14 dépendances actuellement observées dans le manifeste. Ajouter ensuite les cas limites et les versions de format.
- **OSV API** : adapter le modèle aux requêtes par paquet/version et par commit, valider strictement les réponses, gérer les erreurs réseau, les limites de débit, les reprises et le cache. Une réponse valide sans avis n'est pas une preuve d'absence de vulnérabilité.
- **Syft** : ne pas tenter de réécrire d'emblée un détecteur universel de fichiers, conteneurs et écosystèmes. Commencer par un importeur/exporteur de SBOM et un vérificateur de cohérence du graphe, puis ajouter les sources que K7PL peut inventorier avec une sémantique fiable.
- **Grype** : distinguer le moteur de correspondance entre composants et vulnérabilités, ses bases de données, les règles de priorité et les résultats. Une réimplémentation complète de la résolution des correspondances et du cycle de vie de la base serait un projet séparé ; le premier objectif est une comparaison différentielle des résultats, pas la parité annoncée.
- **ORT** : l'évaluer d'abord comme moteur d'analyse de licences et de politiques, à partir d'un format d'entrée effectivement supporté. Ne pas annoncer de support natif de Lake sans l'avoir démontré. Comparer les résultats et les limites de couverture avec le modèle Lean.
- **SPDX / CycloneDX** : implémenter des sérialiseurs à partir du modèle interne et valider les documents produits avec les schémas ou parseurs indépendants officiels. Éviter de convertir un format vers l'autre en supposant une conservation parfaite des sémantiques.

Les outils externes restent utiles comme références différentielles et comme sources de données. Le but n'est pas de les remplacer tous, mais d'apporter un noyau auditable, des adaptateurs fiables et des contrôles formels que d'autres écosystèmes peuvent réutiliser.

## 3. Stratégie SBOM : SPDX et CycloneDX

### 3.1 Comparaison orientée vers l'évolution de K7PL

| Dimension | SPDX | CycloneDX |
|---|---|---|
| Licence, copyright et conformité | Point fort historique ; SPDX 3 organise les usages en profils, dont Licensing | Métadonnées de licence et de copyright disponibles ; exploitable dans les chaînes de conformité |
| Inventaire logiciel et relations | Modèle logiciel, identifiants, relations et provenance ; SPDX 3 ajoute notamment les profils Software et Build | Modèle de composants et de dépendances conçu pour les échanges opérationnels |
| Sécurité et vulnérabilités | Profil Security dans SPDX 3 pour les avis, sévérités et effets sur les éléments | Modèle de vulnérabilités et intégration étendue des cas d'usage VEX/VDR |
| Fabrication et opérations | Profil Build et modèle général de relations/provenance | Formulation déclarée et observée, workflows, tâches et étapes ; extensions orientées opérations |
| Extensions futures | Profils pour logiciel, sécurité, licences, build, IA, jeux de données et extensions | Famille élargie de BOM : SaaS, matériel, cryptographie, IA, opérations et fabrication |
| Intégration actuelle dans K7PL | Très cohérent avec REUSE, les licences de dépendances et la traçabilité des artefacts ; demande de vérifier la maturité de l'outillage sur SPDX 3 | Très cohérent pour la surveillance de vulnérabilités et VEX ; vérifier la couverture de tous les outils ciblés et les besoins de conformité |
| Risque de conception | Les profils et versions doivent être choisis explicitement ; ne pas supposer que tous les consommateurs prennent en charge SPDX 3 | Ne pas confondre richesse du modèle et exhaustivité des composants détectés |

Références normatives à suivre :
- SPDX 3.0.1, modèle SBOM : https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Classes/Sbom/
- SPDX 3, profils de conformité : https://spdx.github.io/spdx-spec/v3.0-dev/conformance/
- CycloneDX, spécification et modèle : https://cyclonedx.org/specification/overview/
- CycloneDX, spécification publiée par Ecma International comme ECMA-424 : https://github.com/CycloneDX/specification

Les versions de spécification, la prise en charge réelle par les consommateurs et l'état des schémas devront être revérifiés au moment de l'implémentation ; cette comparaison n'est pas une certification de compatibilité.

### 3.2 Recommandation provisoire

**Utiliser SPDX comme format canonique initial**, sous réserve d'un prototype validé sur les outils réellement disponibles, et conserver CycloneDX comme format de sortie complémentaire si les consommateurs de sécurité, les workflows VEX ou les besoins opérationnels le justifient.

Cette préférence est motivée par le périmètre prévisible de K7PL : graphe des dépendances Lean/Lake, sources et révisions, licences et droits des fichiers, outils de construction, actions CI, artefacts générés et provenance de release. La continuité avec REUSE et l'analyse de licences est importante. SPDX 3 apporte en outre des profils distincts pour le logiciel, les licences, la sécurité et le build. Cela n'implique pas que SPDX soit universellement supérieur : CycloneDX dispose d'un modèle très adapté aux flux de vulnérabilités, à VEX et aux formulations de construction.

La décision ne doit pas se transformer en dépendance à une seule représentation. Le modèle interne Lean sera la source de vérité pour les informations que K7PL sait réellement établir. Les deux sérialiseurs éventuels seront produits directement depuis ce modèle, et non l'un depuis l'autre. Chaque export déclarera son périmètre et ses lacunes.

Avant de figer la version canonique, réaliser un prototype sur les dépendances Lake et comparer :
- la fidélité des identifiants de composants et des révisions Git ;
- la représentation des relations directes et transitives ;
- les déclarations de licence et les champs inconnus ;
- la prise en charge par Syft, Grype, ORT, OSV-Scanner et les validateurs indépendants visés ;
- le déterminisme, la stabilité des diffs et la facilité de vérifier la complétude.

Il est possible de publier ultérieurement les deux formats si la demande le justifie. Il ne faut toutefois pas ajouter deux formats uniquement pour augmenter artificiellement la couverture : chaque sortie ajoute une obligation de tests, de compatibilité et de maintenance.

## 4. Démarche de preuve et de validation

Pour chaque composant, maintenir un contrat séparant les invariants démontrables, les hypothèses d'environnement et les tests empiriques.

Exemples de propriétés utiles à prouver en Lean :

- le parseur n'invente ni ne supprime de dépendance silencieusement ;
- les révisions SHA valides sont conservées à l'identique lors de la normalisation ;
- le tri et la sérialisation sont déterministes pour une même entrée normalisée ;
- les relations exportées ne référencent que des composants définis ;
- toute omission est signalée comme omission, et la composition n'est pas déclarée complète si des entrées pertinentes ne sont pas couvertes ;
- une règle de décision est monotone par rapport aux catégories explicitement définies, si cette propriété est souhaitée et justifiée.

Les preuves du noyau doivent être accompagnées de tests de propriétés, de fuzzing et de tests différentiels contre des outils externes. Les tests ne remplacent pas les preuves ; les preuves ne remplacent pas les tests d'intégration et l'examen des données externes.

Le fuzzing devra être déterministe à graine enregistrée, avec réduction des contre-exemples et corpus de régression. Priorité aux entrées réellement exposées : manifeste Lake, JSON de réponses OSV, documents SPDX/CycloneDX et analyseurs de fichiers. Les générateurs doivent produire des entrées valides aussi bien que malformées, et utiliser des oracles indépendants.

Le SAST Lean devra cibler des classes de défauts formulées explicitement : constructions dangereuses dans les scripts et workflows, usages d'axiomes non autorisés, présence de trous de preuve, erreurs de validation des entrées ou règles de sécurité violées. Il devra compléter, et non simplement dupliquer, la compilation avec avertissements fatals, les tests, les linters et l'audit d'axiomes existants. Toute règle sera évaluée sur un corpus positif/négatif avant de devenir un contrôle bloquant.

## 5. Phases proposées

### Phase A — Inventaire fiable et spécification

- [ ] Stabiliser le contrat du modèle interne et le vocabulaire des états inconnus/partiels.
- [ ] Écrire une spécification de l'adaptateur Lake et de ses invariants.
- [ ] Établir un jeu de fixtures de manifeste, y compris les cas malformés et limites.
- [ ] Produire une matrice de couverture des données : manifeste, source, build, actions CI, outils et artefacts publiés.
- [ ] Décider des identifiants stables des composants et des champs de provenance.

**Sortie :** modèle et contrat documentés, sans nouveau contrôle de sécurité bloquant.

### Phase B — SBOM minimale et comparaison indépendante

- [ ] Générer une SBOM SPDX pour les dépendances Lake à partir du modèle interne.
- [ ] Valider l'export avec un parseur indépendant et vérifier les relations.
- [ ] Comparer les composants exportés au manifeste et expliciter toute différence.
- [ ] Évaluer un export CycloneDX à partir du même modèle si les consommateurs retenus le nécessitent.
- [ ] Mesurer déterminisme, taille, qualité des métadonnées et compatibilité des outils.

**Sortie :** prototype évalué ; aucune revendication de complétude hors du périmètre mesuré.

### Phase C — OSV et contrôles de sécurité

- [ ] Comparer l'adaptateur actuel vers OSV-Scanner avec un client API OSV Lean.
- [ ] Formaliser la validation des réponses et les états erreur/inconnu/aucun avis.
- [ ] Ajouter des tests différentiels et un cache sûr, explicite et invalidable.
- [ ] Comparer les résultats sur les mêmes révisions et enregistrer les écarts.
- [ ] Garder le contrôle non bloquant jusqu'à examen des faux positifs, faux négatifs possibles et limites de couverture.

**Sortie :** rapport comparatif ; le scanner existant reste un point de référence jusqu'à preuve de valeur de l'implémentation Lean.

### Phase D — Grype, ORT et politiques

- [ ] Établir une matrice des capacités réelles de Syft, Grype et ORT sur les entrées de K7PL.
- [ ] Distinguer génération de SBOM, identification des vulnérabilités, analyse de licences et décision de politique.
- [ ] Définir un corpus de résultats de référence et les divergences acceptables.
- [ ] Réimplémenter seulement les parties dont le contrat est borné et dont l'intérêt pour l'écosystème est démontré.
- [ ] Publier les limites connues et les critères de comparaison.

**Sortie :** décision argumentée pour chaque composant, pouvant conclure à conserver l'outil externe.

### Phase E — Fuzzing et SAST Lean

- [ ] Auditer licence, maintenance, compatibilité et règles des candidats existants avant de réimplémenter.
- [ ] Définir une cible concrète, des oracles, un budget CI et un format de rapport stable.
- [ ] Construire un corpus contrôlé de défauts et de cas négatifs.
- [ ] Mesurer les faux positifs et les défauts non détectés.
- [ ] Ajouter des contrôles bloquants seulement après validation du signal et des coûts.

**Sortie :** contrôles reproductibles avec revendications de couverture bornées.

### Phase F — Distribution et assurance de la chaîne

- [ ] Publier les SBOM avec les artefacts de release après validation du périmètre.
- [ ] Lier les documents à la révision source, aux outils et à leurs versions.
- [ ] Envisager des attestations de provenance et de résultats de vérification.
- [ ] Prévoir une politique de versionnement des formats, de compatibilité et de retrait des anciennes sorties.
- [ ] Documenter ce qui est prouvé, testé, observé ou supposé pour chaque release.

## 6. Principes de gouvernance

- Aucune preuve ou couverture n'est annoncée sans artefact de validation observable.
- Un scan sans résultat signifie « aucun avis retourné par cette exécution et ces sources », jamais « aucune vulnérabilité ».
- Les outils tiers sont épinglés, leurs licences et leurs chaînes de confiance évaluées, et leurs sorties ne sont pas traitées comme des instructions.
- Les écarts avec les outils de référence sont conservés comme cas de test ; ils ne sont pas supprimés pour obtenir artificiellement un résultat identique.
- Le statut « formellement vérifié » ne s'applique qu'aux propriétés énoncées et démontrées, dans les hypothèses documentées.
- Le périmètre de la SBOM est déclaré explicitement : dépendances Lake seulement, ou également outillage, actions CI, composants de build et artefacts.

